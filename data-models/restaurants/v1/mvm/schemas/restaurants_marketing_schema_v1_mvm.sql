-- Schema for Domain: marketing | Business: Restaurants | Version: v1_mvm
-- Generated on: 2026-05-06 04:01:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `restaurants_ecm`.`marketing` COMMENT 'Manages promotional campaign planning, LTO execution, advertising spend, media channel performance (digital, social, traditional), brand positioning, local store marketing, guest segmentation, and campaign ROI measurement. Drives traffic, average daily transactions (ADT), and comparable store sales (comp sales) lift.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `restaurants_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for each marketing campaign.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.franchise_agreement. Business justification: Needed to associate campaigns with the governing franchise agreement, ensuring marketing fees are charged per agreement and supporting audit of compliance with contract terms.',
    `area_management_id` BIGINT COMMENT 'Foreign key linking to restaurant.area_management. Business justification: Campaigns are scoped to geographic areas/territories for regional marketing fund planning and area-level comp-sales lift reporting. Area managers review campaign ROI for their territory — a named oper',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Campaigns are planned and budgeted at the brand level in multi-brand restaurant groups (e.g., brand-level marketing fund allocation, brand performance reporting). owning_brand is a denormalized text',
    `nro_project_id` BIGINT COMMENT 'Foreign key linking to realestate.nro_project. Business justification: Grand opening campaigns in foodservice are explicitly created for NRO projects. Marketing teams plan and track campaign ROI (ADT lift, comp sales) against specific new restaurant openings. A foodservi',
    `campaign_remodel_project_nro_project_id` BIGINT COMMENT 'Foreign key linking to realestate.realestate_remodel_project. Business justification: Reimage/remodel completions in QSR chains trigger dedicated grand reopening marketing campaigns to drive traffic back to refreshed locations. Marketing ROI reporting for remodel investments requires',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaign actual_spend and budget_amount must be allocated to a marketing cost center for departmental P&L and budget variance reporting. QSR finance teams require campaign spend to be cost-center-code',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Required for Ingredient Launch Campaigns that promote a newly sourced ingredient; marketing needs to reference the specific ingredient being advertised.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: In franchise/multi-entity restaurant groups, campaigns are owned and funded by a specific legal entity (e.g., national marketing fund entity vs. regional co-op). Legal entity attribution is required f',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for the Campaign Ownership Report that tracks which employee owns each marketing campaign, a standard operational metric in restaurant marketing.',
    `segment_id` BIGINT COMMENT 'Guest segment (e.g., families, millennials) the campaign targets.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Needed for Supplier Co‑Brand Campaigns where a marketing campaign is jointly run with a specific supplier; ties campaign to the supplier record.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Required for campaign planning and ROI reporting by linking each marketing campaign to the specific franchise territory it targets, enabling territory-level spend allocation and compliance tracking.',
    `actual_adt_lift_pct` DECIMAL(18,2) COMMENT 'Measured increase in Average Daily Transactions after campaign execution.',
    `actual_comp_sales_lift_pct` DECIMAL(18,2) COMMENT 'Measured lift in comparable store sales after campaign execution.',
    `actual_end_date` DATE COMMENT 'Date the campaign actually ended.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Actual monetary spend recorded for the campaign.',
    `actual_start_date` DATE COMMENT 'Date the campaign actually started.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned monetary budget allocated to the campaign.',
    `campaign_code` STRING COMMENT 'Business identifier or code used to reference the campaign in external systems.',
    `campaign_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of the campaign.',
    `campaign_name` STRING COMMENT 'Human‑readable name of the campaign.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign.. Valid values are `planned|active|completed|cancelled`',
    `campaign_type` STRING COMMENT 'Classification of the campaign by scope and delivery channel.. Valid values are `national|local|digital|traditional|online|social`',
    `channel_mix` STRING COMMENT 'Combination of media channels used (e.g., digital, social, TV, radio).',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the campaign complies with all applicable foodservice marketing regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created.',
    `expected_adt_lift_pct` DECIMAL(18,2) COMMENT 'Planned increase in Average Daily Transactions expressed as a percentage.',
    `expected_comp_sales_lift_pct` DECIMAL(18,2) COMMENT 'Planned lift in comparable store sales expressed as a percentage.',
    `is_lto` BOOLEAN COMMENT 'True if the campaign includes a Limited‑Time Offer (LTO).',
    `is_test_campaign` BOOLEAN COMMENT 'Indicates whether the campaign is a test or pilot (true) or a production campaign (false).',
    `lto_end_date` DATE COMMENT 'End date of the Limited‑Time Offer component, if applicable.',
    `lto_start_date` DATE COMMENT 'Start date of the Limited‑Time Offer component, if applicable.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the campaign.',
    `objective` STRING COMMENT 'Primary business goal of the campaign (e.g., ADT lift, comparable store sales, brand awareness).',
    `objective_metric` STRING COMMENT 'Metric used to measure the campaigns objective.. Valid values are `adt_lift|comp_sales_lift|brand_awareness|traffic`',
    `planned_end_date` DATE COMMENT 'Date the campaign is scheduled to conclude.',
    `planned_start_date` DATE COMMENT 'Date the campaign is scheduled to begin.',
    `target_daypart` STRING COMMENT 'Daypart (e.g., breakfast, lunch, dinner) the campaign is aimed at.',
    `target_geography` STRING COMMENT 'Geographic region(s) targeted by the campaign (e.g., USA, CAN).',
    `target_market` STRING COMMENT 'Market segment or demographic the campaign is aimed at (e.g., urban millennials).',
    `target_store_count` STRING COMMENT 'Number of restaurant locations the campaign is intended to cover.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for every marketing campaign executed by Restaurants, including promotional campaigns, LTO (Limited Time Offer) launches, brand awareness drives, and traffic-building initiatives. Captures campaign name, type (national/local/digital/traditional), objective (ADT lift, comp sales, brand awareness), status (planned/active/completed/cancelled), planned and actual start/end dates, target daypart, target guest segment, owning brand, channel mix, budget allocation, and campaign owner. SSOT for campaign identity across all marketing execution.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`marketing`.`campaign_execution` (
    `campaign_execution_id` BIGINT COMMENT 'Unique identifier for the campaign execution record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.franchise_agreement. Business justification: Links each campaign execution to the specific franchise agreement authorizing it, required for royalty calculations and legal compliance verification.',
    `area_management_id` BIGINT COMMENT 'Foreign key linking to restaurant.area_management. Business justification: Area managers review campaign execution performance (ROI, comp-sales lift) for their territory — a standard named process in restaurant operations. campaign_execution.market_dma is a plain text field;',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Each execution belongs to a single campaign; linking enables traceability of spend and performance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaign execution channel_spend_amount must be allocated to a cost center for granular marketing spend control by channel and market. Finance teams require execution-level cost center coding to recon',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for the Campaign Execution Oversight Report, linking the employee responsible for executing a campaign to the execution record.',
    `health_inspection_id` BIGINT COMMENT 'Foreign key linking to foodsafety.health_inspection. Business justification: Compliance check: marketing verifies latest health inspection before launching campaign execution to ensure unit meets safety standards.',
    `media_plan_id` BIGINT COMMENT 'Foreign key linking to marketing.media_plan. Business justification: A campaign execution is the act of running a campaign in a specific market or channel, and it executes against a media plan that defines the spend allocation across channels (TV, digital, social, OOH,',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchise associated with the execution (if applicable).',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to marketing.promotion. Business justification: A campaign execution drives guest traffic to redeem a specific promotion. campaign_execution has target_audience, target_segment, and ROI metrics that are most meaningful when tied directly to the pro',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.guest_segment. Business justification: Campaign executions target specific guest segments. This FK replaces the denormalized target_segment text field, enabling proper segment-level execution reporting and campaign reach measurement — stan',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Required for budgeting, ROI calculation, and compliance reporting of campaign execution at a specific restaurant location.',
    `actual_adt_lift_percent` DECIMAL(18,2) COMMENT 'Observed percentage increase in ADT after execution.',
    `actual_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'Observed percentage lift in comparable store sales.',
    `actual_end_date` DATE COMMENT 'Actual date when the campaign ended.',
    `actual_launch_date` DATE COMMENT 'Actual date when the campaign went live.',
    `campaign_execution_status` STRING COMMENT 'Current lifecycle status of the campaign execution.. Valid values are `planned|launched|completed|cancelled|paused`',
    `channel_spend_amount` DECIMAL(18,2) COMMENT 'Total monetary spend allocated to the execution channel.',
    `clicks` STRING COMMENT 'Number of clicks generated by the campaign.',
    `conversions` STRING COMMENT 'Number of conversion actions (e.g., orders) attributed to the campaign.',
    `cost_per_click` DECIMAL(18,2) COMMENT 'Average cost incurred per click.',
    `cost_per_impression` DECIMAL(18,2) COMMENT 'Average cost incurred per thousand impressions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign execution record was created.',
    `creative_version` STRING COMMENT 'Identifier for the creative version used in the execution.',
    `currency_code` STRING COMMENT 'Three‑letter currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `deviation_reason` STRING COMMENT 'Explanation of any deviation from the original campaign plan.',
    `execution_channel` STRING COMMENT 'Channel through which the campaign was executed.. Valid values are `digital|social|ooH|radio|tv|in_store_pos`',
    `execution_code` STRING COMMENT 'Business identifier code assigned to the campaign execution.',
    `execution_owner` STRING COMMENT 'Person or team responsible for executing the campaign.',
    `execution_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary execution event (e.g., launch).',
    `expected_adt_lift_percent` DECIMAL(18,2) COMMENT 'Projected percentage increase in ADT due to the campaign.',
    `expected_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'Projected percentage lift in comparable store sales.',
    `impressions` STRING COMMENT 'Number of times the campaign was displayed.',
    `launch_date` DATE COMMENT 'Planned date for the campaign launch.',
    `market_dma` STRING COMMENT 'Geographic market or DMA where the campaign is executed.',
    `media_vendor` STRING COMMENT 'Name of the media vendor or agency delivering the campaign.',
    `notes` STRING COMMENT 'Free‑form field for any additional information about the execution.',
    `planned_end_date` DATE COMMENT 'Planned date for the campaign to end.',
    `restaurant_scope` STRING COMMENT 'Scope of restaurants included in the execution.. Valid values are `all_units|franchise_group|company_owned|selected_units`',
    `roi_percent` DECIMAL(18,2) COMMENT 'Calculated ROI percentage for the campaign execution.',
    `target_audience` STRING COMMENT 'Description of the intended audience for the campaign.',
    `tracking_url` STRING COMMENT 'URL used to track digital campaign performance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_campaign_execution PRIMARY KEY(`campaign_execution_id`)
) COMMENT 'Transactional record capturing the actual execution of a campaign within a specific market, restaurant group, or channel. Tracks execution status, launch date, actual vs. planned go-live, execution channel (digital, social, OOH, radio, TV, in-store POS), market/DMA, restaurant scope (all units, franchise group, company-owned), execution owner, and any deviations from the campaign plan. Enables operational tracking of campaign rollout across thousands of restaurant units.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`marketing`.`marketing_lto` (
    `marketing_lto_id` BIGINT COMMENT 'Unique identifier for the marketing_lto data product (auto-inserted pre-linking).',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: LTOs are created for specific campaigns; linking provides ownership.',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: LTO (Limited Time Offer) products are definitionally built around a featured ingredient requiring dedicated procurement planning. The LTO Launch Readiness process requires supply to confirm ingredie',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to marketing.promotion. Business justification: An LTO (Limited Time Offer) is fundamentally a promotional construct — it is a time-bounded promotion that drives traffic and comp sales. marketing_lto currently only links to campaign_id, leaving the',
    `reward_id` BIGINT COMMENT 'Foreign key linking to loyalty.reward. Business justification: Limited-time offers (LTOs) in restaurant marketing are frequently paired with loyalty rewards (e.g., earn bonus points on the LTO item). Linking marketing_lto to reward enables LTO performance reporti',
    CONSTRAINT pk_marketing_lto PRIMARY KEY(`marketing_lto_id`)
) COMMENT 'Master record for Limited Time Offers (LTOs) — the cornerstone of QSR marketing strategy. Captures LTO name, associated menu item(s), promotional price, offer window (start/end date), daypart applicability, channel availability (DT, OLO, 3PD, dine-in), target guest segment, PMIX impact forecast, sourcing readiness flag, and regulatory compliance status (FDA labeling). Links to campaign and menu domain for full LTO lifecycle management from ideation through execution.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`marketing`.`media_plan` (
    `media_plan_id` BIGINT COMMENT 'Unique identifier for the media plan.',
    `area_management_id` BIGINT COMMENT 'Foreign key linking to restaurant.area_management. Business justification: Media plans are allocated by geographic territory for area-level marketing fund budgeting and spend reporting. media_plan.target_dma is a plain text field; a proper FK to area_management enables struc',
    `brand_id` BIGINT COMMENT 'FK to restaurant.brand',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Media plans are funded by an approved marketing budget. Finance and marketing jointly track media plan spend against the authorizing budget for variance analysis and spend approval workflows — a stand',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with this media plan.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media plan total_planned_spend and channel-level spend (tv_spend, digital_spend, etc.) must be allocated to a marketing cost center for budget control and AP invoice matching. Finance requires cost ce',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Media plan spend is posted to advertising expense GL accounts. Finance teams map media plans to GL accounts during budget setup and AP invoice processing to ensure media spend is correctly classified ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Media plans require an accountable owner employee for approval workflows, budget sign-off, and audit trails. In restaurant marketing operations, media plans are owned and approved by specific marketin',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Franchise co-op marketing funds are territory-scoped; media plans must be linked to franchise territories to allocate cooperative advertising spend, report media investment by territory, and ensure fr',
    `agency_name` STRING COMMENT 'Advertising agency partner responsible for executing the media plan.',
    `approval_status` STRING COMMENT 'Current approval state of the media plan.. Valid values are `pending|approved|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the media plan record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the planned spend.. Valid values are `^[A-Z]{3}$`',
    `daypart_target` STRING COMMENT 'Primary daypart(s) targeted by the media plan.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `digital_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to digital advertising channels.',
    `effective_from` DATE COMMENT 'Date when the media plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the media plan ends or expires.',
    `frequency_target` STRING COMMENT 'Target average number of times each individual is exposed.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the media plan is currently active.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the media plan.. Valid values are `draft|pending|active|suspended|closed|cancelled`',
    `ooh_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to out-of-home advertising.',
    `plan_code` STRING COMMENT 'External reference code for the media plan used in marketing systems.',
    `plan_description` STRING COMMENT 'Detailed description of the media plan objectives and scope.',
    `plan_name` STRING COMMENT 'Descriptive name of the media plan.',
    `plan_type` STRING COMMENT 'Category of the media plan indicating its scope.. Valid values are `brand|regional|national|global`',
    `print_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to print advertising.',
    `radio_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to radio advertising.',
    `reach_target` BIGINT COMMENT 'Target number of unique individuals to be reached.',
    `social_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to social media advertising.',
    `target_dma` STRING COMMENT 'Designated Designated Market Area code for the media plans geographic focus.. Valid values are `^[A-Z]{3}$`',
    `total_planned_spend` DECIMAL(18,2) COMMENT 'Total amount of advertising spend planned for the media plan.',
    `tv_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to television advertising.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the media plan record.',
    CONSTRAINT pk_media_plan PRIMARY KEY(`media_plan_id`)
) COMMENT 'Master record for the media planning document that defines how advertising spend is allocated across channels (TV, radio, digital, social, OOH, print) for a given campaign or fiscal period. Captures plan name, planning period, total planned spend, channel mix breakdown, target DMA/market, agency partner, brand, daypart targeting, reach and frequency targets, and approval status. SSOT for pre-buy media strategy and spend authorization.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`marketing`.`promotion` (
    `promotion_id` BIGINT COMMENT 'Unique system-generated identifier for the promotion.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Promotions are brand-specific in multi-brand restaurant groups; brand-level promotion reporting, financial liability tracking, and franchise compliance audits require knowing which brand owns each pro',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: LTO and promotional campaigns in QSR have dedicated budget allocations. Linking promotion directly to budget enables finance to track promotion discount spend against approved budget, supporting perio',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotions are launched under a campaign; linking enables aggregation of promotion performance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Promotion discount costs (e.g., LTO price reductions) must be allocated to a cost center for marketing P&L reporting and budget variance analysis. QSR finance teams track promotional spend by cost cen',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Allows tracking of promotions originated by individual franchisees, supporting franchisee-specific performance dashboards and reimbursement of promotion costs.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Promotion discount amounts are posted to specific GL accounts (promotional discount expense, contra-revenue). Finance reconciles total promotion liability and discount expense against GL balances duri',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Promotions featuring specific ingredients (e.g., Angus Beef LTO) require supply readiness validation before launch. The Promotion Supply Readiness Review process — confirming ingredient availabili',
    `nro_project_id` BIGINT COMMENT 'Foreign key linking to realestate.nro_project. Business justification: Grand opening promotions (BOGO, free item offers) are standard NRO marketing tools in QSR/casual dining. Linking promotion directly to nro_project supports grand opening promotional planning, redempti',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Promotions are created, owned, and approved by specific marketing employees. Tracking the owning employee enables approval workflows, compliance audits, and accountability reporting. In restaurant mar',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.guest_segment. Business justification: Promotions define eligibility by guest segment. This FK replaces the denormalized eligible_guest_segments text field, enabling proper eligibility enforcement, segment-based promotion targeting reports',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Local promotions are often site‑specific (e.g., store‑level discounts); linking allows promotion scheduling, audit, and performance tracking per restaurant site.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Supplier‑Sponsored Promotions require tracking which supplier funded the promotion; creates a FK to the supplier entity.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Store‑specific promotions must be tied to the unit for performance tracking, local compliance, and redemption reporting.',
    `applicable_channels` STRING COMMENT 'Sales channels where the promotion can be redeemed (POS, online ordering, third‑party delivery, mobile app).. Valid values are `pos|olo|3pd|app`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary discount applied when the promotion is used.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied when the promotion is used.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining eligibility (e.g., purchase of specific SKU, time of day).',
    `end_date` DATE COMMENT 'Date when the promotion expires; null if open‑ended.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the promotion excludes other concurrent promotions.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether the promotion can be combined with other promotions.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum order total required for the promotion to be eligible.',
    `promo_category` STRING COMMENT 'High‑level business grouping of the promotion for reporting purposes.. Valid values are `seasonal|new_product|clearance|holiday|loyalty|event`',
    `promo_source` STRING COMMENT 'Origin of the promotion (e.g., corporate, franchisee, external partner).. Valid values are `internal|franchise|partner|vendor`',
    `promotion_code` STRING COMMENT 'Business code used to reference the promotion in POS and reporting systems.',
    `promotion_description` STRING COMMENT 'Detailed marketing description of the promotion displayed to guests.',
    `promotion_name` STRING COMMENT 'Human‑readable name of the promotional offer.',
    `promotion_status` STRING COMMENT 'Current lifecycle status of the promotion.. Valid values are `active|inactive|pending|expired|draft`',
    `promotion_type` STRING COMMENT 'Category of the promotion defining the pricing mechanic (e.g., discount, buy‑one‑get‑one).. Valid values are `discount|bogo|bundle|coupon|loyalty|gift`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the promotion record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the promotion record.',
    `redemption_count` STRING COMMENT 'Running total of how many times the promotion has been redeemed.',
    `redemption_limit_per_customer` STRING COMMENT 'Maximum number of times a single guest may redeem the promotion.',
    `start_date` DATE COMMENT 'Date when the promotion becomes effective and can be redeemed.',
    `total_redemption_limit` STRING COMMENT 'Overall cap on the number of redemptions across all guests.',
    CONSTRAINT pk_promotion PRIMARY KEY(`promotion_id`)
) COMMENT 'Master record for all guest-facing promotional offers and their issued instruments (coupons) — including discounts, BOGOs (buy-one-get-one), combo deals, value meals, loyalty reward redemptions, digital app deals, and physical/digital coupons. Captures promotion name, type (discount/BOGO/bundle/coupon/loyalty/app-exclusive), discount value or percentage, minimum purchase threshold, channel eligibility (POS/OLO/3PD/app), guest segment targeting, redemption limits, and associated campaign. For coupon-type promotions: coupon code, coupon format (single-use/multi-use/loyalty-exclusive/app-only/printed), eligible menu items or categories, issue date, expiry date, maximum redemption count, and fraud prevention flags (velocity checks, geo-fencing). SSOT for all promotional offer mechanics and issued coupon instruments.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` (
    `promotion_redemption_id` BIGINT COMMENT 'Unique identifier for the promotion redemption record.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign linked to the promotion.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: Channel-level promotion redemption analytics: marketing teams report promotion performance by channel (mobile app vs. in-store vs. drive-thru) to optimize channel-specific offers. The plain channel ',
    `coupon_id` BIGINT COMMENT 'Foreign key linking to marketing.coupon. Business justification: A promotion redemption is frequently triggered by the presentation of a specific coupon (physical or digital). Linking promotion_redemption directly to coupon enables fraud prevention validation (chec',
    `digital_account_id` BIGINT COMMENT 'Foreign key linking to guest.digital_account. Business justification: Digital channel promotion redemptions are tied to a specific digital account (app/web). This link supports per-account redemption limit enforcement, fraud prevention, and digital channel attribution r',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who processed the redemption.',
    `guest_order_id` BIGINT COMMENT 'Foreign key linking to order.guest_order. Business justification: Promotion redemption reconciliation: marketing ops and finance teams reconcile every redemption event against the actual order for ROI calculation, fraud detection, and redemption validation. A foodse',
    `profile_id` BIGINT COMMENT 'Identifier of the guest who redeemed the promotion.',
    `member_id` BIGINT COMMENT 'Identifier of the loyalty member associated with the redemption.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where redemption occurred.',
    `promotion_id` BIGINT COMMENT 'Identifier of the promotion that was redeemed.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: Promotion redemptions occur during a specific guest visit. Linking redemption to guest_visit enables visit-level promotion attribution reporting — a core restaurant marketing analytics process measuri',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the redemption record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `daypart` STRING COMMENT 'Meal period during which the redemption occurred.. Valid values are `breakfast|lunch|dinner|late_night`',
    `device_code` STRING COMMENT 'Identifier of the POS or kiosk device that captured the redemption.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied when discount is percent‑based.',
    `discount_type` STRING COMMENT 'Indicates whether the discount is a fixed amount or a percentage.. Valid values are `amount|percent`',
    `is_test_redemption` BOOLEAN COMMENT 'True if the redemption was a test or training transaction.',
    `loyalty_member_flag` BOOLEAN COMMENT 'Indicates if the guest is a loyalty program member at the time of redemption.',
    `promotion_redemption_status` STRING COMMENT 'Current lifecycle status of the redemption.. Valid values are `redeemed|voided|pending|failed|cancelled`',
    `redemption_number` STRING COMMENT 'Business identifier for the redemption event, often displayed to staff.',
    `redemption_timestamp` TIMESTAMP COMMENT 'Date and time when the promotion was redeemed.',
    `source_system` STRING COMMENT 'System of record that originated the redemption data (e.g., MICROS, OLO).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the redemption record.',
    CONSTRAINT pk_promotion_redemption PRIMARY KEY(`promotion_redemption_id`)
) COMMENT 'Transactional record capturing each instance of a guest redeeming a promotional offer at a restaurant. Captures redemption timestamp, channel (POS/OLO/3PD/app), restaurant unit, promotion redeemed, discount amount applied, order value before and after discount, guest identifier (if known), and loyalty member flag. Enables measurement of promotion uptake, discount liability, and incremental traffic driven by promotional activity.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`marketing`.`coupon` (
    `coupon_id` BIGINT COMMENT 'Unique identifier for the coupon record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Coupons are brand-specific in multi-brand restaurant groups; brand-level coupon liability reporting, redemption rate analysis, and franchise marketing fund compliance require knowing which brand each ',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that issued the coupon.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: Channel-restricted coupon management: marketing teams configure coupons valid only on specific channels (e.g., app-only coupons, drive-thru exclusives). A proper FK to order.channel enforces referenti',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Required for Coupon Management: link item‑specific coupons to the menu item they discount, enabling redemption tracking, inventory impact analysis, and compliance reporting.',
    `offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.offer. Business justification: Marketing coupons are a distribution channel for loyalty offers (e.g., a coupon code activates a loyalty offer). Linking coupon to offer enables tracking of which loyalty offers were distributed via c',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to marketing.promotion. Business justification: A coupon is the physical or digital instrument that operationalizes a promotion. The coupon currently links to campaign_id but not directly to the governing promotion record. Adding promotion_id to co',
    `reward_id` BIGINT COMMENT 'Foreign key linking to loyalty.reward. Business justification: Marketing coupons in restaurant operations frequently distribute loyalty rewards (e.g., a coupon code that redeems a free item reward). Linking coupon to reward enables reconciliation of coupon redemp',
    `coupon_code` STRING COMMENT 'Human‑readable code assigned to the coupon for issuance and redemption tracking.',
    `coupon_description` STRING COMMENT 'Full marketing description and terms of the coupon.',
    `coupon_name` STRING COMMENT 'Descriptive name of the coupon used in marketing materials.',
    `coupon_status` STRING COMMENT 'Current lifecycle state of the coupon.. Valid values are `active|expired|revoked|pending|cancelled`',
    `coupon_type` STRING COMMENT 'Classification of the coupon indicating its usage rules.. Valid values are `single_use|multi_use|loyalty_exclusive|app_only|printed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the coupon record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount when discount_type is fixed_amount.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage value of the discount when discount_type is percentage.',
    `discount_type` STRING COMMENT 'Mechanism by which the coupon provides a discount.. Valid values are `percentage|fixed_amount|free_item`',
    `eligible_item_category` STRING COMMENT 'Menu category or SKU that the coupon can be applied to.',
    `expiry_date` DATE COMMENT 'Date after which the coupon can no longer be redeemed.',
    `fraud_prevention_flag` BOOLEAN COMMENT 'Flag indicating whether the coupon is subject to fraud monitoring.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the coupon excludes the use of other promotions.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether the coupon can be used together with other promotions.',
    `issue_date` DATE COMMENT 'Date the coupon was generated and made available.',
    `max_redemptions` STRING COMMENT 'Total number of times the coupon may be redeemed across all customers.',
    `notes` STRING COMMENT 'Free‑form field for internal remarks about the coupon.',
    `per_customer_limit` STRING COMMENT 'Maximum number of redemptions allowed per individual guest.',
    `redemption_count` STRING COMMENT 'Number of times the coupon has already been redeemed.',
    `redemption_window_end` DATE COMMENT 'End date of the period during which the coupon may be redeemed.',
    `redemption_window_start` DATE COMMENT 'Start date of the period during which the coupon may be redeemed.',
    `store_scope` STRING COMMENT 'Geographic or store‑level scope where the coupon is valid.. Valid values are `all|selected|specific`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the coupon record.',
    `usage_limit_type` STRING COMMENT 'Specifies whether the coupon has a usage limit.. Valid values are `unlimited|limited`',
    CONSTRAINT pk_coupon PRIMARY KEY(`coupon_id`)
) COMMENT 'Master record for physical and digital coupons issued as part of marketing campaigns or standalone promotional activity. Captures coupon code, coupon type (single-use/multi-use/loyalty-exclusive/app-only/printed), face value or discount type, eligible menu items or categories, channel restrictions (POS/OLO/3PD/app), issue date, expiry date, maximum redemption count, and fraud prevention flags. Distinct from promotion (which defines the offer mechanic) — coupon is the specific issued instrument.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `restaurants_ecm`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` ADD CONSTRAINT `fk_marketing_marketing_lto_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` ADD CONSTRAINT `fk_marketing_marketing_lto_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `restaurants_ecm`.`marketing`.`coupon`(`coupon_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ADD CONSTRAINT `fk_marketing_coupon_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ADD CONSTRAINT `fk_marketing_coupon_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);

-- ========= TAGS =========
ALTER SCHEMA `restaurants_ecm`.`marketing` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `restaurants_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `area_management_id` SET TAGS ('dbx_business_glossary_term' = 'Area Management Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `nro_project_id` SET TAGS ('dbx_business_glossary_term' = 'Nro Project Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_remodel_project_nro_project_id` SET TAGS ('dbx_business_glossary_term' = 'Realestate Remodel Project Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Owner Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_adt_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual ADT Lift Percentage');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_comp_sales_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Comparable Store Sales Lift Percentage');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'national|local|digital|traditional|online|social');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `expected_adt_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected ADT Lift Percentage');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `expected_comp_sales_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected Comparable Store Sales Lift Percentage');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `is_lto` SET TAGS ('dbx_business_glossary_term' = 'Limited‑Time Offer Flag');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `is_test_campaign` SET TAGS ('dbx_business_glossary_term' = 'Test Campaign Flag');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `lto_end_date` SET TAGS ('dbx_business_glossary_term' = 'LTO End Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `lto_start_date` SET TAGS ('dbx_business_glossary_term' = 'LTO Start Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `objective_metric` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective Metric');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `objective_metric` SET TAGS ('dbx_value_regex' = 'adt_lift|comp_sales_lift|brand_awareness|traffic');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `target_daypart` SET TAGS ('dbx_business_glossary_term' = 'Target Daypart');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `target_geography` SET TAGS ('dbx_business_glossary_term' = 'Target Geography');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `target_store_count` SET TAGS ('dbx_business_glossary_term' = 'Target Store Count');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `area_management_id` SET TAGS ('dbx_business_glossary_term' = 'Area Management Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Owner Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `actual_adt_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual ADT Lift Percentage');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `actual_comp_sales_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Comparable Store Sales Lift Percentage');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_status` SET TAGS ('dbx_value_regex' = 'planned|launched|completed|cancelled|paused');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Channel Spend Amount (Monetary Value)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks Count');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `conversions` SET TAGS ('dbx_business_glossary_term' = 'Conversions Count');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `cost_per_click` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC) Amount');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `cost_per_impression` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Impression (CPM) Amount');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `creative_version` SET TAGS ('dbx_business_glossary_term' = 'Creative Version Identifier');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `deviation_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Deviation from Campaign Plan');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_channel` SET TAGS ('dbx_business_glossary_term' = 'Execution Channel (Digital, Social, Out-of-Home, Radio, TV, In-Store POS)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_channel` SET TAGS ('dbx_value_regex' = 'digital|social|ooH|radio|tv|in_store_pos');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution Code');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_owner` SET TAGS ('dbx_business_glossary_term' = 'Execution Owner (Employee or Team)');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Event Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `expected_adt_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Average Daily Transactions (ADT) Lift Percentage');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `expected_comp_sales_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Comparable Store Sales Lift Percentage');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions Count');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Launch Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `market_dma` SET TAGS ('dbx_business_glossary_term' = 'Market Designated Market Area (DMA) Code');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `media_vendor` SET TAGS ('dbx_business_glossary_term' = 'Media Vendor Name');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes or Comments');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `restaurant_scope` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Scope of Campaign Execution');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `restaurant_scope` SET TAGS ('dbx_value_regex' = 'all_units|franchise_group|company_owned|selected_units');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment Percentage');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `tracking_url` SET TAGS ('dbx_business_glossary_term' = 'Tracking URL for Campaign Metrics');
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` SET TAGS ('dbx_subdomain' = 'promotional_offers');
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` ALTER COLUMN `marketing_lto_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for marketing_lto');
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `area_management_id` SET TAGS ('dbx_business_glossary_term' = 'Area Management Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `daypart_target` SET TAGS ('dbx_business_glossary_term' = 'Daypart Target');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `daypart_target` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `digital_spend` SET TAGS ('dbx_business_glossary_term' = 'Digital Spend (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `frequency_target` SET TAGS ('dbx_business_glossary_term' = 'Frequency Target (Impressions per Person)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Lifecycle Status');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|pending|active|suspended|closed|cancelled');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `ooh_spend` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Home Spend (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Code');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Description');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Name');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Type');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'brand|regional|national|global');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `print_spend` SET TAGS ('dbx_business_glossary_term' = 'Print Spend (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `radio_spend` SET TAGS ('dbx_business_glossary_term' = 'Radio Spend (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `reach_target` SET TAGS ('dbx_business_glossary_term' = 'Reach Target (Individuals)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `social_spend` SET TAGS ('dbx_business_glossary_term' = 'Social Media Spend (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `target_dma` SET TAGS ('dbx_business_glossary_term' = 'Target DMA Code');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `target_dma` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `total_planned_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Spend (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `tv_spend` SET TAGS ('dbx_business_glossary_term' = 'TV Spend (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` SET TAGS ('dbx_subdomain' = 'promotional_offers');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `nro_project_id` SET TAGS ('dbx_business_glossary_term' = 'Nro Project Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_business_glossary_term' = 'Applicable Channels');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_value_regex' = 'pos|olo|3pd|app');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Exclusive');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Is Stackable');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promo_category` SET TAGS ('dbx_business_glossary_term' = 'Promotion Category');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promo_category` SET TAGS ('dbx_value_regex' = 'seasonal|new_product|clearance|holiday|loyalty|event');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promo_source` SET TAGS ('dbx_business_glossary_term' = 'Promotion Source');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promo_source` SET TAGS ('dbx_value_regex' = 'internal|franchise|partner|vendor');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promotion_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Description');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Name');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|draft');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'discount|bogo|bundle|coupon|loyalty|gift');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `redemption_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ALTER COLUMN `total_redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` SET TAGS ('dbx_subdomain' = 'promotional_offers');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Redemption ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `digital_account_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'amount|percent');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `is_test_redemption` SET TAGS ('dbx_business_glossary_term' = 'Test Redemption Flag');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `loyalty_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Flag');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_redemption_status` SET TAGS ('dbx_value_regex' = 'redeemed|voided|pending|failed|cancelled');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `redemption_number` SET TAGS ('dbx_business_glossary_term' = 'Redemption Number');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` SET TAGS ('dbx_subdomain' = 'promotional_offers');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Marketing Campaign ID');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `coupon_description` SET TAGS ('dbx_business_glossary_term' = 'Coupon Description (Marketing Copy and Terms)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `coupon_name` SET TAGS ('dbx_business_glossary_term' = 'Coupon Name');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_business_glossary_term' = 'Coupon Lifecycle Status (e.g., Active, Expired, Revoked, Pending, Cancelled)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending|cancelled');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type (e.g., Single‑Use, Multi‑Use, Loyalty‑Exclusive, App‑Only, Printed)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'single_use|multi_use|loyalty_exclusive|app_only|printed');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (Fixed Monetary Value) (USD)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage (Percent of Transaction) (PCT)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type (Percentage, Fixed Amount, Free Item)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_item');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `eligible_item_category` SET TAGS ('dbx_business_glossary_term' = 'Eligible Item Category (Menu Category or SKU)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Coupon Expiry Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `fraud_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Prevention Flag (Indicates Potential Fraudulent Use)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Flag (Indicates if Coupon Excludes Other Promotions)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag (Indicates if Coupon Can Be Combined with Others)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Coupon Issue Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `max_redemptions` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Count');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes or Internal Comments');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `per_customer_limit` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Current Redemption Count');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `redemption_window_end` SET TAGS ('dbx_business_glossary_term' = 'Redemption Window End Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `redemption_window_start` SET TAGS ('dbx_business_glossary_term' = 'Redemption Window Start Date');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `store_scope` SET TAGS ('dbx_business_glossary_term' = 'Store Scope (All Stores, Selected Stores, Specific Stores)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `store_scope` SET TAGS ('dbx_value_regex' = 'all|selected|specific');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `usage_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Type (Unlimited or Limited)');
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ALTER COLUMN `usage_limit_type` SET TAGS ('dbx_value_regex' = 'unlimited|limited');
