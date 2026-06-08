-- Schema for Domain: vendor | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`vendor` COMMENT 'SSOT for all third-party media vendors, publishers, technology partners (DSPs, SSPs, DMPs, CDPs), and production suppliers. Manages vendor profiles, accreditation status (TAG, MRC), rate cards, onboarding records, and supply chain transparency. Supports media buying, creative production, and programmatic operations. Ensures brand safety compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique surrogate identifier for the supplier record. Primary key for the vendor.supplier data product. All other vendor-domain products reference this entity via supplier_id. MASTER_PARTY role.',
    `ads_txt_verified` BOOLEAN COMMENT 'Indicates whether the publisher suppliers authorized digital sellers (ads.txt) or sellers.json file has been verified by the agencys programmatic operations team, confirming legitimate inventory authorization and reducing counterfeit inventory risk per IAB Tech Lab standards.',
    `agency_relationship_owner` STRING COMMENT 'Name or identifier of the primary agency employee (e.g., media director, programmatic lead, or account director) responsible for managing the commercial relationship with this supplier. Used for accountability, QBR scheduling, and escalation routing.',
    `api_integration_status` STRING COMMENT 'Current status of the API integration between the agencys technology stack and the suppliers platform. Applicable primarily to tech_platform vendor types. Tracks whether automated data exchange (bid management, reporting, audience sync) is live, pending setup, inactive, or not applicable.. Valid values are `active|inactive|pending|not_applicable`',
    `audience_reach` BIGINT COMMENT 'Estimated total unique audience reach of the suppliers media properties, expressed as number of unique users/devices per month. Sourced from Comscore or Nielsen Ad Intel measurement. Used in media planning for reach and frequency analysis and GRP/TRP calculations.',
    `brand_safety_tier` STRING COMMENT 'Agency-assigned brand safety tier rating for the supplier based on content quality, TAG certification, MRC accreditation, and supply chain transparency. Tier 1 = premium brand-safe inventory; Tier 2 = standard; Tier 3 = restricted/monitored; Unrated = pending assessment. Controls eligibility for client campaigns with brand safety mandates.. Valid values are `tier_1|tier_2|tier_3|unrated`',
    `cm360_vendor_code` STRING COMMENT 'Unique vendor or site identifier assigned to the supplier within Google Campaign Manager 360 for ad trafficking, placement management, and delivery reporting. Enables reconciliation between CM360 delivery data and the vendor master.',
    `contract_expiry_date` DATE COMMENT 'Expiry date of the master service agreement (MSA) or master vendor contract with the supplier. Triggers contract renewal workflows and controls whether new insertion orders (IOs) can be issued against this supplier in Mediaocean Prisma.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country where the supplier is legally incorporated. Drives regulatory compliance checks (GDPR, CCPA), tax treatment in SAP S/4HANA, and supply path transparency (SPO) reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was first created in the vendor master system (Mediaocean Prisma or Salesforce CRM), captured in ISO 8601 format with timezone offset. Supports data lineage, audit trail, and GDPR data subject request processing.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the supplier invoices the agency (e.g., USD, GBP, EUR). Used for multi-currency financial reconciliation in SAP S/4HANA and Mediaocean Prisma billing workflows.. Valid values are `^[A-Z]{3}$`',
    `data_sharing_agreement` BOOLEAN COMMENT 'Indicates whether a formal data sharing agreement is in place with the supplier, governing the exchange of audience data, campaign performance data, and measurement signals. Required for GDPR/CCPA compliance when audience data flows between the agency and the supplier.',
    `diversity_cert_type` STRING COMMENT 'Specific type of diversity certification held by the supplier (e.g., MBE, WBE, LGBTBE, VOSB, SDVOSB, SBE). Populated only when diversity_certified is True. Used for granular diversity spend categorization and client reporting. [ENUM-REF-CANDIDATE: MBE|WBE|LGBTBE|VOSB|SDVOSB|SBE|HUBZone|other — promote to reference product]',
    `diversity_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds a recognized diversity certification (e.g., MBE - Minority Business Enterprise, WBE - Women Business Enterprise, LGBTBE, VOSB). Supports client diversity spend reporting mandates and ANA supplier diversity program compliance.',
    `iab_content_category` STRING COMMENT 'IAB Content Taxonomy category code assigned to the publishers primary content vertical (e.g., IAB1 - Arts & Entertainment, IAB19 - Technology & Computing). Applicable to publisher vendor types. Used for brand safety targeting, contextual alignment, and programmatic supply curation in The Trade Desk and Google CM360.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the supplier record in the vendor master. Used for change data capture (CDC) in ETL pipelines, data freshness monitoring, and audit trail compliance.',
    `legal_name` STRING COMMENT 'Full registered legal name of the supplier entity as filed with the relevant government authority. Used for contract execution, insertion orders (IOs), and financial reconciliation in SAP S/4HANA and Mediaocean Prisma.',
    `media_channel` STRING COMMENT 'Primary media channel through which the publisher or supplier delivers advertising inventory. Applicable to publisher vendor types. Drives media planning and buying workflows in Mediaocean Prisma and The Trade Desk. [ENUM-REF-CANDIDATE: digital|broadcast|ooh|dooh|ctv_ott|print|audio|social|search|other — promote to reference product]',
    `mediaocean_vendor_code` STRING COMMENT 'Unique vendor identifier assigned within Mediaocean Prisma, the agencys primary media planning, buying, and billing system of record. Used for cross-system reconciliation between the lakehouse silver layer and Mediaocean operational records.',
    `mrc_accredited` BOOLEAN COMMENT 'Indicates whether the suppliers audience measurement methodology or ad serving has been audited and accredited by the Media Rating Council (MRC). Critical for validating impression counting, viewability measurement, and GRP/TRP reporting integrity.',
    `mrc_audit_date` DATE COMMENT 'Date of the most recent MRC audit completion for the suppliers measurement methodology or ad serving infrastructure. Used to assess currency of accreditation and trigger re-audit workflows when accreditation lapses.',
    `notes` STRING COMMENT 'Free-text field for capturing supplementary information about the supplier that does not fit structured fields, such as special commercial terms, relationship history, escalation contacts, or onboarding exceptions noted by the agency relationship owner.',
    `onboarding_date` DATE COMMENT 'Date on which the supplier was formally approved and activated in the agencys vendor management system following completion of onboarding due diligence (financial, legal, brand safety, and compliance checks).',
    `onboarding_status` STRING COMMENT 'Current state of the supplier in the agency onboarding and vendor management lifecycle. Controls whether the supplier is eligible for media buys, IO issuance, and payment processing in Mediaocean Prisma and SAP S/4HANA.. Valid values are `prospect|under_review|approved|active|suspended|terminated`',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the supplier for invoice settlement, as configured in SAP S/4HANA and Mediaocean Prisma. Drives accounts payable scheduling and cash flow management in financial reconciliation workflows.. Valid values are `net_30|net_45|net_60|net_90|immediate|other`',
    `platform_type` STRING COMMENT 'Specific platform classification per IAB Tech Lab taxonomy for tech_platform vendor types. Identifies the suppliers role in the programmatic supply chain (e.g., DSP, SSP, DMP, CDP, ad server, verification vendor such as IAS/DoubleVerify, attribution platform, data provider). Null for non-tech-platform vendors. [ENUM-REF-CANDIDATE: dsp|ssp|dmp|cdp|ad_server|verification|attribution|data_provider|other — 9 candidates stripped; promote to reference product]',
    `primary_contact_email` STRING COMMENT 'Primary business email address for the suppliers account representative or partnership contact. Used for IO delivery, billing correspondence, and campaign trafficking communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the supplier organization responsible for account management, campaign trafficking, and billing inquiries.',
    `primary_contact_phone` STRING COMMENT 'Primary business phone number for the supplier contact, formatted per ITU-T E.164 standard. Used for urgent campaign and billing escalations.. Valid values are `^+?[1-9]d{1,14}$`',
    `programmatic_supply_role` STRING COMMENT 'Defines the suppliers role in the programmatic supply chain as declared in ads.txt/sellers.json: direct (authorized direct seller of inventory), reseller (authorized to resell another sellers inventory), both (acts as both), or not_applicable (non-programmatic supplier). Used for supply chain transparency and SPO analysis.. Valid values are `direct|reseller|both|not_applicable`',
    `salesforce_account_code` STRING COMMENT 'Unique account identifier for the supplier record in Salesforce CRM (Sales Cloud). Enables cross-system linkage between the vendor master in the lakehouse and the CRM account for relationship management, contract tracking, and QBR reporting.',
    `spo_enabled` BOOLEAN COMMENT 'Indicates whether the supplier participates in the agencys Supply Path Optimization (SPO) program, meaning the agency has a direct or preferred supply relationship with this vendor to reduce intermediary hops, improve transparency, and lower CPM costs in programmatic buying via The Trade Desk.',
    `tag_certified_against_fraud` BOOLEAN COMMENT 'Indicates whether the supplier holds current TAG Certified Against Fraud certification, a key brand safety and ad fraud prevention credential. Required for programmatic supply curation and brand safety tier assignment. Sourced from TAG registry.',
    `tag_seal_certification_code` STRING COMMENT 'The unique TAG Seal identifier issued to the supplier upon achieving TAG certification (e.g., TAG Certified Against Fraud, TAG Brand Safety Certified). Used to verify certification authenticity via the TAG registry and enforce brand safety compliance in programmatic buying.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number (e.g., EIN in the US, VAT number in the EU) for the suppliers legal entity. Required for W-9/W-8 compliance, SAP S/4HANA vendor master setup, and financial reconciliation in Mediaocean Prisma.',
    `trade_desk_partner_code` STRING COMMENT 'Unique partner or supply partner identifier assigned to the supplier within The Trade Desk DSP platform. Used for programmatic buying configuration, bid management, and supply path optimization (SPO) tracking.',
    `trading_name` STRING COMMENT 'The brand or doing business as (DBA) name used in day-to-day media buying, campaign trafficking, and agency communications. May differ from the legal entity name.',
    `vendor_type` STRING COMMENT 'Primary classification of the supplier within the advertising ecosystem. Drives downstream workflow routing, rate card applicability, and compliance checks. Enum: publisher (media owner), tech_platform (DSP/SSP/DMP/CDP/ad server/verification/attribution), production (creative/production house), research (audience/measurement provider), other.. Valid values are `publisher|tech_platform|production|research|other`',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Canonical master record and Single Source of Truth (SSOT) for all third-party vendor identities in the advertising ecosystem. Encompasses media publishers (digital, broadcast, OOH, DOOH, CTV/OTT, print), technology platforms (DSPs, SSPs, DMPs, CDPs, ad servers, verification vendors such as IAS and DoubleVerify, attribution platforms, data providers), production houses, research providers, and supply chain partners. Captures legal entity details, vendor type classification (enum: publisher, tech_platform, production, research, other), IAB content category (for publishers), platform type per IAB Tech Lab taxonomy and API integration status (for tech partners), audience reach metrics, MRC-audited measurement status, TAG/MRC accreditation status, TAG Certified Against Fraud, brand safety tier rating, supply path transparency (SPO) attributes, diversity certification, data sharing agreement status, programmatic supply chain role, onboarding lifecycle state, and primary agency relationship owner. All other vendor-domain products reference this entity via supplier_id. Sourced from Mediaocean Prisma vendor records, Salesforce CRM, The Trade Desk, and Google CM360 integrations.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`publisher` (
    `publisher_id` BIGINT COMMENT 'Unique surrogate identifier for the publisher record in the vendor domain master. Primary key for all downstream joins and lineage tracking.',
    `accreditation_id` BIGINT COMMENT 'Unique TAG-issued certification identifier for the publisher. Used to verify certification status via the TAG registry and to validate supply chain transparency in programmatic buying workflows.. Valid values are `^[A-Za-z0-9]{8,64}$`',
    `parent_publisher_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent publisher entity, enabling hierarchical modelling of publisher groups and media conglomerates (e.g., a local TV station under a national broadcast network). Null for top-level publishers.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Publisher is a specialized subtype of supplier (media publishers and inventory owners). This FK establishes the subtype-to-supertype relationship, allowing publisher to inherit common supplier master ',
    `ads_txt_verified` BOOLEAN COMMENT 'Indicates whether the publishers ads.txt file has been validated, confirming that authorized digital sellers are declared and reducing the risk of unauthorized inventory reselling. Critical for supply path optimization (SPO) and programmatic fraud prevention.',
    `audience_measurement_source` STRING COMMENT 'Identifies the third-party audience measurement provider or methodology used to validate the publishers audience reach figures. Determines the credibility and comparability of audience data for media planning and post-campaign reporting.. Valid values are `comscore|nielsen|mrc_audited_self|third_party|not_measured`',
    `base_cpm_rate` DECIMAL(18,2) COMMENT 'Publishers standard base CPM (Cost Per Mille) rate in the agencys operating currency, representing the cost per 1,000 ad impressions. Serves as the benchmark rate for media planning, rate card negotiations, and budget estimation in Mediaocean Prisma. Classified as confidential commercial pricing data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the publisher record was first created in the vendor management system. Provides audit trail for vendor onboarding governance and data lineage tracking in the Databricks Silver Layer.',
    `deal_type` STRING COMMENT 'Primary deal structure type through which the publishers inventory is transacted. Determines buying workflow, pricing model, and IO/insertion order requirements in Mediaocean Prisma. [ENUM-REF-CANDIDATE: open_market|private_marketplace|preferred_deal|programmatic_guaranteed|direct_io — promote to reference product if additional deal types are required]. Valid values are `open_market|private_marketplace|preferred_deal|programmatic_guaranteed|direct_io`',
    `grp_enabled` BOOLEAN COMMENT 'Indicates whether the publisher supports Gross Rating Point (GRP) or Target Rating Point (TRP) based audience buying and reporting, typically applicable to broadcast, CTV/OTT, and premium digital video inventory. Enables GRP-based media planning in Nielsen Ad Intel integrated workflows.',
    `iab_content_category_code` STRING COMMENT 'Primary IAB Content Taxonomy category code (e.g., IAB1, IAB2-1) classifying the publishers editorial content vertical. Used for audience targeting, brand safety filtering, and contextual advertising alignment per IAB Content Taxonomy v3.',
    `inventory_type` STRING COMMENT 'Primary ad inventory format type offered by the publisher. Drives format-specific buying workflows, creative specifications, and measurement methodologies. [ENUM-REF-CANDIDATE: display|video|audio|native|ooh|dooh|print|sponsorship — promote to reference product if additional formats are required]',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic vendor review or Quarterly Business Review (QBR) conducted for this publisher, covering brand safety compliance, performance metrics, and accreditation status. Supports vendor governance and renewal workflows.',
    `monthly_impressions` BIGINT COMMENT 'Estimated or audited total monthly ad impression volume available from the publisher across all inventory types. Used for media planning capacity assessment, share of voice (SOV) calculations, and programmatic deal sizing.',
    `monthly_unique_visitors` BIGINT COMMENT 'Estimated or MRC-audited monthly unique visitor count for the publishers primary digital property, as reported by Comscore or Nielsen. Used for audience reach planning, CPM (Cost Per Mille) benchmarking, and media plan audience delivery estimation.',
    `mrc_accreditation_scope` STRING COMMENT 'Description of the specific measurement types and platforms covered under the publishers MRC accreditation (e.g., Display Impressions, Video Viewability, Cross-Platform). Null if mrc_audited is false.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic vendor review or accreditation renewal check for this publisher. Used to trigger compliance review workflows and ensure TAG/MRC certifications remain current.',
    `notes` STRING COMMENT 'Free-text field for capturing additional operational notes, special buying conditions, negotiation history, or account management observations relevant to the publisher relationship. Used by media buying and account management teams.',
    `preferred_ssp` STRING COMMENT 'Name of the publishers primary or preferred Supply-Side Platform (SSP) used for programmatic inventory monetization (e.g., Google Ad Manager, Magnite, PubMatic, Index Exchange). Used for supply path optimization (SPO) and deal activation in The Trade Desk.',
    `programmatic_enabled` BOOLEAN COMMENT 'Indicates whether the publishers inventory is available for programmatic buying via Demand-Side Platforms (DSPs) and Supply-Side Platforms (SSPs), including Real-Time Bidding (RTB) and private marketplace (PMP) deal structures.',
    `publisher_type` STRING COMMENT 'Classification of the publisher by inventory channel category. Distinguishes digital publishers, broadcast networks, Out-of-Home (OOH) operators, Digital Out-of-Home (DOOH) networks, Connected TV (CTV) / Over-the-Top (OTT) platforms, and print media owners. Drives channel-specific buying workflows and rate card application.. Valid values are `digital|broadcast_network|ooh_operator|dooh_network|ctv_ott|print`',
    `rate_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the publishers rate card pricing (e.g., USD, GBP, EUR). Ensures correct currency conversion and financial reconciliation in SAP S/4HANA and Mediaocean Prisma billing workflows.. Valid values are `^[A-Z]{3}$`',
    `secondary_iab_category_codes` STRING COMMENT 'Pipe-delimited list of secondary IAB Content Taxonomy category codes representing additional content verticals covered by the publisher. Supports multi-category targeting and brand safety analysis beyond the primary classification.',
    `sellers_json_verified` BOOLEAN COMMENT 'Indicates whether the publishers sellers.json file has been validated, providing transparency into the supply chain by identifying all entities authorized to sell the publishers inventory. Supports supply path optimization (SPO) and anti-fraud compliance.',
    `spo_tier` STRING COMMENT 'Supply Path Optimization (SPO) classification indicating the preferred supply path designation for this publisher. Direct = direct publisher relationship; Preferred = approved SSP path; Standard = open market; Excluded = removed from programmatic buying paths. Used by The Trade Desk and DSP buying teams to optimize supply chain efficiency.. Valid values are `direct|preferred|standard|excluded`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the publisher record, capturing any changes to profile, accreditation status, brand safety tier, or rate card information. Supports change data capture (CDC) and audit trail requirements.',
    `vast_vpaid_support` STRING COMMENT 'Indicates the publishers supported video ad serving standards: VAST (Video Ad Serving Template) only, VPAID (Video Player-Ad Interface Definition) only, both, or neither. Determines video creative compatibility and trafficking requirements in Google Campaign Manager 360.. Valid values are `vast_only|vpaid_only|both|neither`',
    `website_url` STRING COMMENT 'Primary public-facing website URL of the publisher. Serves as the canonical digital identity reference for brand safety audits, supply path optimization (SPO) verification, and ads.txt/sellers.json validation.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_publisher PRIMARY KEY(`publisher_id`)
) COMMENT 'Master record for media publishers and inventory owners — including digital publishers, broadcast networks, OOH operators, DOOH networks, CTV/OTT platforms, and print media owners. Captures publisher profile, IAB content category classifications, audience reach, MRC-audited measurement status, brand safety tier, and supply path transparency (SPO) attributes. Distinct from DSP/SSP technology partners.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`tech_partner` (
    `tech_partner_id` BIGINT COMMENT 'Unique surrogate identifier for the advertising technology platform partner record in the vendor master. Primary key for the tech_partner data product.',
    `accreditation_id` BIGINT COMMENT 'Official TAG-issued certification identifier for the tech partner. Used to validate brand safety compliance and anti-fraud accreditation during programmatic deal setup and IO execution.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Tech_partner is a specialized subtype of supplier (advertising technology platform partners - DSPs, SSPs, DMPs, CDPs, ad servers, verification providers). This FK establishes the subtype-to-supertype ',
    `ads_txt_authorized` BOOLEAN COMMENT 'Indicates whether the tech partner is listed as an authorized digital seller in the relevant ads.txt files, confirming legitimate inventory resale rights per IAB Tech Lab standards. Critical for anti-fraud and brand safety compliance.',
    `annual_platform_fee` DECIMAL(18,2) COMMENT 'Annual licensing or platform access fee payable to the tech partner, denominated in the contract currency. Used for budget planning, P&L reporting, and financial reconciliation in SAP S/4HANA FI/CO.',
    `api_endpoint_url` STRING COMMENT 'Primary API endpoint URL for programmatic integration with the tech partners platform. Used by ETL pipelines and DSP/SSP connectors for bid requests, reporting pulls, and audience segment synchronization. Classified confidential as it represents proprietary integration infrastructure.',
    `api_integration_status` STRING COMMENT 'Current status of the API integration between the agencys systems (The Trade Desk, Google CM360, Mediaocean Prisma) and the tech partners platform. Drives automated bid management, reporting ingestion, and audience sync workflows.. Valid values are `active|inactive|in_progress|not_integrated`',
    `attribution_model_support` STRING COMMENT 'Attribution modeling methodology supported by the tech partners platform for campaign performance measurement. Informs ROAS and CPA reporting configurations in Google CM360 and The Trade Desk. [ENUM-REF-CANDIDATE: last_click|first_click|linear|data_driven|multi_touch|time_decay|position_based|none — promote to reference product]. Valid values are `last_click|first_click|linear|data_driven|multi_touch|none`',
    `audience_targeting_capability` BOOLEAN COMMENT 'Indicates whether the tech partner provides audience targeting capabilities (e.g., DMP/CDP segment activation, lookalike modeling, contextual targeting). Relevant for DMP and CDP partners integrated with The Trade Desk audience management.',
    `brand_safety_tier` STRING COMMENT 'Internal brand safety tier assigned to the tech partner based on TAG certification, MRC accreditation, IAS/DoubleVerify verification scores, and supply chain transparency. Tier 1 = highest trust; Tier 3 = restricted use. Governs which client campaigns may activate this partner.. Valid values are `tier_1|tier_2|tier_3|unrated`',
    `contract_end_date` DATE COMMENT 'Expiry date of the master service agreement or platform access contract with the tech partner. Nullable for evergreen agreements. Triggers renewal workflow in Workfront and SAP S/4HANA contract management.',
    `contract_start_date` DATE COMMENT 'Effective start date of the master service agreement or platform access contract with the tech partner. Used for contract lifecycle management in SAP S/4HANA PS and financial accrual scheduling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tech partner record was first created in the vendor master system. Supports data lineage, audit trail, and onboarding SLA tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_residency_region` STRING COMMENT 'Geographic region where the tech partner stores and processes data (e.g., EU, US, APAC). Critical for GDPR cross-border data transfer compliance (Standard Contractual Clauses) and CCPA jurisdiction assessments.',
    `data_sharing_agreement_flag` BOOLEAN COMMENT 'Indicates whether a formal data sharing agreement (DSA) is in place with the tech partner governing the exchange of audience data, campaign performance data, and first-party data. Required for DMP/CDP integrations under GDPR and CCPA.',
    `data_sharing_agreement_ref` STRING COMMENT 'Reference number or document identifier for the executed data sharing agreement with the tech partner. Links to the contract management system (SAP S/4HANA PS or Workfront DAM) for legal and compliance audit purposes.',
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the annual platform fee and any transactional fees charged by the tech partner (e.g., USD, GBP, EUR). Required for multi-currency financial reconciliation in SAP S/4HANA FI.. Valid values are `^[A-Z]{3}$`',
    `iab_tech_lab_member` BOOLEAN COMMENT 'Indicates whether the tech partner is an active member of the IAB Tech Lab, which governs programmatic standards including OpenRTB, VAST, VPAID, and ads.txt. Membership status informs standards compliance expectations.',
    `last_audit_date` DATE COMMENT 'Date of the most recent vendor compliance audit conducted for the tech partner, covering TAG certification, MRC accreditation, GDPR DPA, and brand safety assessments. Supports annual vendor review cycles.',
    `measurement_capability` BOOLEAN COMMENT 'Indicates whether the tech partner provides independent measurement, viewability verification, or attribution services (e.g., IAS, DoubleVerify, Nielsen, Comscore). Determines eligibility as a third-party measurement vendor on campaign IOs.',
    `platform_type` STRING COMMENT 'Categorical classification of the advertising technology platform per IAB Tech Lab taxonomy. Determines the partners role in the programmatic supply chain and which integration workflows apply. [ENUM-REF-CANDIDATE: DSP|SSP|DMP|CDP|Ad Server|Verification|Attribution|Data Provider|CRM|Analytics — promote to reference product]',
    `rtb_protocol_version` STRING COMMENT 'OpenRTB protocol version supported by the tech partner for programmatic buying and selling (e.g., OpenRTB 2.5, OpenRTB 2.6, OpenRTB 3.0). Governs bid request/response schema compatibility with The Trade Desk and other DSP integrations.',
    `sellers_json_verified` BOOLEAN COMMENT 'Indicates whether the tech partners sellers.json file has been validated per IAB Tech Lab specification, confirming supply chain transparency for programmatic inventory. Required for SSP and ad exchange partners.',
    `soc2_certified` BOOLEAN COMMENT 'Indicates whether the tech partner holds a current SOC 2 Type II certification, confirming security, availability, and confidentiality controls. Required for partners handling first-party audience data or campaign performance data.',
    `supply_chain_role` STRING COMMENT 'The partners functional role within the programmatic advertising supply chain as defined by IAB ads.txt and sellers.json standards. Supports supply chain transparency audits and brand safety compliance. Values: buyer (DSP), seller (SSP/publisher), intermediary (reseller), data_provider, measurement.. Valid values are `buyer|seller|intermediary|data_provider|measurement`',
    `supported_channels` STRING COMMENT 'Comma-separated list of advertising channels supported by the tech partners platform (e.g., Display, Video, CTV, OTT, DOOH, Audio, Native, Search). Informs media planning channel eligibility in Mediaocean Prisma and The Trade Desk.',
    `tech_fee_rate` DECIMAL(18,2) COMMENT 'Percentage-based technology fee charged by the partner per media dollar transacted through their platform (e.g., DSP tech fee as a percentage of media spend). Used in CPM/CPC rate card calculations and ROAS reporting in Mediaocean Prisma.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tech partner record in the vendor master. Used for change data capture (CDC) in ETL pipelines and compliance audit trails. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vast_vpaid_support` STRING COMMENT 'Supported video ad serving standard(s) for the tech partners platform. Determines compatibility with video campaign trafficking in Google CM360 and The Trade Desk. VAST 4.x is the current IAB Tech Lab standard; VPAID 2.0 is legacy.. Valid values are `VAST_4|VAST_3|VPAID_2|VAST_4_VPAID_2|none`',
    CONSTRAINT pk_tech_partner PRIMARY KEY(`tech_partner_id`)
) COMMENT 'Master record for advertising technology platform partners — DSPs, SSPs, DMPs, CDPs, ad servers, verification vendors (IAS, DoubleVerify), attribution platforms, and data providers. Captures platform type (IAB Tech Lab taxonomy), API integration status, data sharing agreements, TAG certification, and programmatic supply chain role. Supports The Trade Desk, Google CM360, and DMP/CDP integrations.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`accreditation` (
    `accreditation_id` BIGINT COMMENT 'Unique surrogate identifier for each vendor accreditation, certification, or compliance record within the vendor domain SSOT.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor (media publisher, technology partner, DSP, SSP, DMP, CDP, or production supplier) that holds this accreditation.',
    `accreditation_status` STRING COMMENT 'Current validity status of the accreditation record. active indicates the certification is current and enforceable; expired indicates the certification period has lapsed; suspended indicates temporary hold pending review; revoked indicates the certifying body has withdrawn the certification; pending indicates an application in progress.. Valid values are `active|expired|suspended|revoked|pending`',
    `accreditation_tier` STRING COMMENT 'The tier or level of the accreditation where the certifying body defines multiple levels (e.g., IAB Gold Standard tiers, MRC provisional vs. full accreditation). Supports vendor segmentation and preferential buying decisions.. Valid values are `gold|silver|bronze|standard|provisional`',
    `anti_fraud_certified` BOOLEAN COMMENT 'Indicates whether this accreditation record confers TAG Certified Against Fraud status on the vendor. True when the certification type is TAG Certified Against Fraud and status is active. Supports invalid traffic (IVT) mitigation in programmatic buying.',
    `application_date` DATE COMMENT 'The date on which the vendor first submitted the application for this accreditation or certification. Supports onboarding workflow tracking and time-to-accreditation analytics.',
    `audit_cycle` STRING COMMENT 'The frequency at which the certifying body requires the vendor to undergo re-audit or re-assessment to maintain the accreditation (e.g., annual TAG re-certification, biennial MRC audit). Drives renewal workflow scheduling.. Valid values are `annual|biennial|quarterly|continuous|on_demand`',
    `brand_safety_certified` BOOLEAN COMMENT 'Indicates whether this accreditation record confers TAG Brand Safety Certified status on the vendor. True when the certification type is TAG Brand Safety Certified and status is active. Enables rapid brand safety filtering in media buying workflows.',
    `ccpa_compliant` BOOLEAN COMMENT 'Indicates whether the vendor has demonstrated CCPA compliance as part of this accreditation record. Relevant for US-based audience data operations, programmatic buying, and DMP/CDP integrations.',
    `certificate_reference_number` STRING COMMENT 'The official certificate or registration number issued by the certifying body (e.g., TAG seal ID, MRC accreditation number, IAB Gold Standard reference). Used for external verification and audit trail.. Valid values are `^[A-Z0-9-]{4,50}$`',
    `certification_name` STRING COMMENT 'The full official name of the certification or accreditation program as designated by the certifying body (e.g., TAG Brand Safety Certified Seal, MRC Digital Audience-Based Buying Accreditation). Provides human-readable identification beyond the type code.',
    `certification_type` STRING COMMENT 'The specific type of accreditation or certification held by the vendor. Covers brand safety, anti-fraud, audience measurement, content standards, and regulatory compliance certifications. [ENUM-REF-CANDIDATE: TAG Brand Safety Certified|TAG Certified Against Fraud|MRC Accredited|IAB Gold Standard|ASA Compliant|FTC Compliant|EASA Compliant|4As Member|ANA Member — promote to reference product]. Valid values are `TAG Brand Safety Certified|TAG Certified Against Fraud|MRC Accredited|IAB Gold Standard|ASA Compliant|FTC Compliant`',
    `certifying_body` STRING COMMENT 'The governing or standards body that issued the accreditation or certification (e.g., TAG, MRC, IAB, ASA, FTC). Determines the authority and scope of the certification. [ENUM-REF-CANDIDATE: TAG|MRC|IAB|ASA|FTC|EASA|4As|ANA|NAI|ICC — 10 candidates stripped; promote to reference product]',
    `certifying_body_contact` STRING COMMENT 'Name or email of the primary contact at the certifying body responsible for managing this accreditation record. Used for renewal correspondence and audit coordination.',
    `channel_scope` STRING COMMENT 'The advertising channel(s) covered by this accreditation (e.g., programmatic display, OTT/CTV, DOOH). Aligns with IAB channel taxonomy and supports media buying compliance checks. [ENUM-REF-CANDIDATE: display|video|audio|search|social|OOH|DOOH|OTT|CTV|programmatic|native|all — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this accreditation record was first created in the system. Supports audit trail, data lineage, and compliance reporting requirements.',
    `expiry_date` DATE COMMENT 'The date on which the accreditation or certification expires and must be renewed. Null for certifications with no defined expiry. Critical for brand safety enforcement and supply chain transparency checks.',
    `fee_usd` DECIMAL(18,2) COMMENT 'The fee paid by the vendor to the certifying body to obtain or renew this accreditation, denominated in US Dollars. Supports vendor cost tracking, budget management, and P&L reconciliation for supply chain compliance expenditure.',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the vendor has demonstrated GDPR compliance as part of this accreditation record. Relevant for European media buying, data processing agreements, and audience targeting operations.',
    `geography_scope` STRING COMMENT 'ISO 3166-1 alpha-3 country code(s) indicating the geographic markets covered by this accreditation (e.g., USA, GBR|DEU|FRA). Pipe-delimited for multi-country scope. Supports GDPR, CCPA, and regional compliance enforcement.. Valid values are `^[A-Z]{3}(|[A-Z]{3})*$`',
    `iab_gold_standard` BOOLEAN COMMENT 'Indicates whether the vendor holds IAB Gold Standard certification as part of this accreditation record. Covers ads.txt/sellers.json adoption, brand safety, and anti-fraud commitments.',
    `issue_date` DATE COMMENT 'The date on which the certifying body formally issued or granted the accreditation to the vendor. Marks the start of the certifications validity period.',
    `last_audit_date` DATE COMMENT 'The date of the most recent audit or assessment conducted by the certifying body against this accreditation. Used to assess currency of compliance and schedule next audit.',
    `mrc_accredited` BOOLEAN COMMENT 'Indicates whether this accreditation record reflects MRC accreditation for audience measurement or ad verification. True when certifying_body is MRC and status is active. Supports Nielsen/Comscore measurement validation and media buying quality assurance.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next audit or re-assessment by the certifying body. Supports proactive compliance management and vendor onboarding risk assessment.',
    `notes` STRING COMMENT 'Free-text field for additional context, conditions, or observations related to this accreditation record (e.g., conditional approval notes, scope limitations, certifying body commentary). Supports operational transparency.',
    `reinstatement_date` DATE COMMENT 'The date on which a previously suspended or revoked accreditation was reinstated by the certifying body. Supports vendor lifecycle management and historical compliance audit trails.',
    `renewal_alert_days` STRING COMMENT 'Number of days before expiry_date at which automated renewal alerts should be triggered for this accreditation. Configurable per certification type to support proactive compliance management (e.g., 90 days for TAG, 60 days for MRC).',
    `renewal_date` DATE COMMENT 'The date on which the vendor submitted or completed the renewal application for this accreditation. Distinct from expiry_date; tracks the renewal action rather than the deadline.',
    `scope_description` STRING COMMENT 'Narrative description of the scope of the accreditation, including which services, channels, geographies, or business units are covered (e.g., Programmatic display and video buying via DSP, Digital audience measurement for desktop and mobile). Enables precise brand safety and supply chain enforcement.',
    `supporting_document_url` STRING COMMENT 'URL pointing to the official certificate document, audit report, or compliance evidence stored in the DAM (Digital Asset Management) system or secure document repository. Enables direct access to certification evidence for brand safety audits.. Valid values are `^https?://.+`',
    `suspension_date` DATE COMMENT 'The date on which the certifying body suspended or revoked this accreditation. Populated only when accreditation_status is suspended or revoked. Enables point-in-time compliance reporting.',
    `suspension_reason` STRING COMMENT 'Narrative explanation of why the accreditation was suspended or revoked by the certifying body. Populated only when accreditation_status is suspended or revoked. Supports vendor risk management and supply chain transparency reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this accreditation record was most recently modified. Supports change tracking, data lineage, and compliance audit requirements in the Databricks Silver Layer.',
    `vendor_contact_email` STRING COMMENT 'Email address of the vendors internal contact responsible for managing and renewing this accreditation. Used for renewal notifications and audit correspondence. Classified as confidential PII.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Full name of the vendors internal contact responsible for managing and renewing this accreditation. Business-confidential as it identifies a named individual within a commercial partner organization.',
    CONSTRAINT pk_accreditation PRIMARY KEY(`accreditation_id`)
) COMMENT 'Tracks formal accreditation, certification, and compliance status records for vendors — including TAG Brand Safety Certified, TAG Certified Against Fraud, MRC accreditation, IAB Gold Standard, and ASA/FTC compliance certifications. Each record captures the certifying body, certification type, issue date, expiry date, certificate reference number, and current validity status. Enables brand safety and supply chain transparency enforcement.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` (
    `vendor_rate_card_id` BIGINT COMMENT 'Unique surrogate identifier for the vendor rate card record in the Silver Layer lakehouse. Primary key for this entity.',
    `source_system_rate_card_vendor_rate_card_id` BIGINT COMMENT 'The native identifier of this rate card record in the originating source system (Mediaocean Prisma). Enables lineage tracing and reconciliation between the Silver Layer lakehouse and the operational system of record.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor (media publisher, technology partner, or production supplier) who issued this rate card.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Vendor rate cards are negotiated as part of vendor contracts and reference contract pricing models. Procurement teams link rate card versions to contract amendments, enforce rate card effective dates ',
    `ad_format` STRING COMMENT 'The specific creative ad format covered by this rate card entry (e.g., banner, video pre-roll, native, audio, rich media, interstitial). Aligns with IAB standard ad unit taxonomy and Google Campaign Manager 360 trafficking formats. [ENUM-REF-CANDIDATE: banner|video|native|audio|rich_media|interstitial|DOOH_static|DOOH_dynamic — 8 candidates stripped; promote to reference product]',
    `ad_size` STRING COMMENT 'The dimensions or specification of the ad unit covered by this rate (e.g., 300x250, 728x90, 15s, 30s, 6s bumper). Follows IAB standard ad unit sizes for display and video formats.',
    `added_value_description` STRING COMMENT 'Free-text description of any added-value elements bundled with this rate card (e.g., bonus impressions, free creative production, data targeting inclusion, brand safety tools). Common in direct media deals and IO negotiations.',
    `agency_commission_pct` DECIMAL(18,2) COMMENT 'The standard agency commission percentage applicable to this rate card (typically 15% per 4As convention). Distinct from discount_rate_pct; represents the agencys earned commission on media spend billed at this rate.',
    `approved_by` STRING COMMENT 'Name or identifier of the internal stakeholder (media buyer, procurement manager) who approved this rate card for use. Supports internal governance and audit trail.',
    `approved_date` DATE COMMENT 'The date on which the rate card was internally approved by the media buying or procurement team for use in campaign planning and IO execution. Supports governance and audit trail requirements.',
    `audience_segment_label` STRING COMMENT 'The audience segment or demographic targeting profile for which this rate applies (e.g., Adults 18-34, In-Market Auto Buyers, Lookalike High-Value). Supports audience-based rate differentiation used in DMP/CDP-driven buying on The Trade Desk.',
    `base_rate` DECIMAL(18,2) COMMENT 'The standard published rate for the pricing unit defined by the pricing_model (e.g., CPM rate in currency per 1,000 impressions, CPC rate per click, flat fee amount). This is the principal quantitative fact of the rate card before any volume discounts or negotiated adjustments.',
    `brand_safety_tier` STRING COMMENT 'The brand safety classification level associated with this rate cards inventory. TAG (Trustworthy Accountability Group) certified inventory commands premium rates. Supports brand safety compliance and supply chain transparency requirements.. Valid values are `standard|brand_safe|premium_brand_safe|TAG_certified`',
    `channel_category` STRING COMMENT 'Broad channel classification for the media inventory covered by this rate card (e.g., digital, traditional broadcast/print, programmatic, direct-sold, out-of-home). Supports media planning and channel mix analytics.. Valid values are `digital|traditional|programmatic|direct|out_of_home`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rate card record was first created in the Silver Layer lakehouse. Supports data lineage, audit trail, and incremental load processing.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the rate card rates are denominated (e.g., USD, GBP, EUR). Required for multi-currency media buying operations and financial reconciliation in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `discount_rate_pct` DECIMAL(18,2) COMMENT 'The percentage discount applied to the base_rate to arrive at the negotiated net rate (e.g., 15.00 for a 15% agency discount). Expressed as a percentage. Used in Mediaocean Prisma billing and SAP S/4HANA financial reconciliation.',
    `effective_end_date` DATE COMMENT 'The date after which this rate card version is no longer valid for new bookings. Nullable for open-ended rate cards with no defined expiry.',
    `effective_start_date` DATE COMMENT 'The date from which this rate card version becomes binding and applicable for media buying, IO execution, and billing. Aligns with vendor IO terms.',
    `geo_market` STRING COMMENT 'The geographic market or region for which this rate card applies (e.g., USA, GBR, New York DMA, EMEA). Rates may vary by market due to inventory supply and demand dynamics.',
    `guaranteed_viewability_pct` DECIMAL(18,2) COMMENT 'The minimum viewability percentage guaranteed by the vendor for inventory sold under this rate card (e.g., 70.00 for 70% viewability guarantee). Null if no viewability guarantee is offered. Supports campaign performance KPI tracking.',
    `inventory_type` STRING COMMENT 'The category of media inventory or service covered by this rate card. Classifies the supply type (e.g., display, video, OOH/Out-of-Home, DOOH/Digital Out-of-Home, OTT/Over-the-Top, CTV/Connected TV). [ENUM-REF-CANDIDATE: display|video|audio|OOH|DOOH|print|broadcast|OTT|CTV|search|social|native — promote to reference product]',
    `io_terms_reference` STRING COMMENT 'Reference identifier or URL to the vendors standard Insertion Order (IO) terms and conditions document associated with this rate card. Links rate card pricing to contractual obligations in Mediaocean Prisma.',
    `is_negotiated_rate` BOOLEAN COMMENT 'Indicates whether this rate is a negotiated/contracted rate (True) as opposed to the vendors published open-market rate (False). Negotiated rates are commercially sensitive and used in IO reconciliation and P&L reporting.',
    `minimum_spend` DECIMAL(18,2) COMMENT 'The minimum monetary commitment required by the vendor to activate this rate card or rate tier. Expressed in the currency defined by currency_code. Relevant for IO negotiation and budget planning.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or annotations related to this rate card entry (e.g., seasonal restrictions, exclusivity clauses, make-good provisions). Sourced from Mediaocean Prisma rate card comments.',
    `placement_position` STRING COMMENT 'The placement position or contextual location of the ad unit on the publishers inventory (e.g., above_the_fold, pre_roll, homepage_takeover). Position premiums are a standard component of vendor rate cards. [ENUM-REF-CANDIDATE: above_the_fold|below_the_fold|pre_roll|mid_roll|post_roll|interstitial|homepage_takeover|run_of_site — 8 candidates stripped; promote to reference product]',
    `pricing_model` STRING COMMENT 'The commercial pricing model under which rates are defined. CPM (Cost Per Mille) for impression-based; CPC (Cost Per Click) for click-based; CPA (Cost Per Acquisition) for conversion-based; flat_fee for fixed-cost placements; GRP (Gross Rating Point) for broadcast/linear TV; CTV for Connected TV; CPCV for Cost Per Completed View. [ENUM-REF-CANDIDATE: CPM|CPC|CPA|flat_fee|GRP|CTV|CPCV — 7 candidates stripped; promote to reference product]',
    `published_date` DATE COMMENT 'The date on which the vendor formally published or issued this rate card version. Distinct from effective_start_date; a rate card may be published in advance of its effective period.',
    `rate_card_name` STRING COMMENT 'Human-readable name or title of the rate card as published by the vendor (e.g., Q3 2024 Display Standard Rate Card, Programmatic Open Market CPM Card).',
    `rate_card_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned by the vendor or Mediaocean Prisma to uniquely reference this rate card document. Used in Insertion Order (IO) negotiations and reconciliation.. Valid values are `^RC-[A-Z0-9]{4,20}$`',
    `rate_card_status` STRING COMMENT 'Current lifecycle state of the rate card. active indicates the card is currently in use for media buying; superseded means a newer version has replaced it; expired means the effective period has lapsed.. Valid values are `draft|active|superseded|expired|withdrawn`',
    `rate_card_type` STRING COMMENT 'Indicates whether the rates are open-market published rates or negotiated/contracted rates. programmatic_guaranteed and private_marketplace (PMP) reflect programmatic deal structures. Drives reconciliation logic in Mediaocean Prisma.. Valid values are `open_market|negotiated|preferred|programmatic_guaranteed|private_marketplace`',
    `rate_unit` STRING COMMENT 'The unit of measure against which the base_rate is applied (e.g., per_mille for CPM, per_click for CPC, per_grp for GRP-based broadcast buying, flat for fixed-fee placements). Ensures correct billing calculation in Mediaocean Prisma. [ENUM-REF-CANDIDATE: per_mille|per_click|per_acquisition|per_view|per_grp|per_day|per_week|per_month|flat — 9 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this rate card record was last modified in the Silver Layer lakehouse. Used for change data capture (CDC), incremental ETL processing, and audit trail compliance.',
    `version` STRING COMMENT 'Version identifier of the rate card (e.g., v1.0, v2.3). Tracks revisions issued by the vendor over time to support historical rate lookups and audit trails.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `viewability_standard` STRING COMMENT 'The viewability measurement standard applied to inventory covered by this rate card (e.g., MRC display standard: 50% pixels for 1 second; MRC video: 50% pixels for 2 seconds). Affects rate premiums and campaign KPI commitments.. Valid values are `MRC_display|MRC_video|GROUPM|custom`',
    `volume_threshold_max` DECIMAL(18,2) COMMENT 'The upper bound of the volume or spend range that qualifies for this rate tier. Nullable for the highest open-ended tier. Used with volume_threshold_min to define tier eligibility.',
    `volume_threshold_min` DECIMAL(18,2) COMMENT 'The lower bound of the volume or spend range (in impressions, clicks, or currency units per currency_code) that qualifies for this rate tier. Used in conjunction with volume_threshold_max to define tier eligibility.',
    `volume_threshold_unit` STRING COMMENT 'The unit of measure for the volume thresholds (volume_threshold_min and volume_threshold_max). Specifies whether thresholds are in impressions, clicks, currency spend, GRP points, or other measurable units.. Valid values are `impressions|clicks|acquisitions|currency|GRP|views`',
    `volume_tier_label` STRING COMMENT 'Human-readable label identifying the volume or spend tier this rate applies to (e.g., Tier 1: $0–$50K, Tier 2: $50K–$250K, Enterprise). Supports tiered pricing structures common in programmatic and direct media deals.',
    CONSTRAINT pk_vendor_rate_card PRIMARY KEY(`vendor_rate_card_id`)
) COMMENT 'Vendor-published rate card defining standard pricing for media inventory, production services, or technology platform fees. Captures rate card version, effective date range, currency, pricing model (CPM, CPC, CPA, flat fee, GRP-based), rate tiers by volume or audience segment, and negotiated vs. open-market rate flags. Sourced from Mediaocean Prisma rate card management and vendor IO terms.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` (
    `vendor_onboarding_id` BIGINT COMMENT 'Unique surrogate identifier for each vendor onboarding attempt record. One record represents one end-to-end onboarding workflow instance for one vendor (supplier). Role: TRANSACTION_HEADER — primary key.',
    `worker_id` BIGINT COMMENT 'Reference to the internal employee who granted or rejected the final approval for this vendor onboarding attempt.',
    `primary_vendor_worker_id` BIGINT COMMENT 'Reference to the internal employee or team member assigned as the primary reviewer and owner of this onboarding workflow. Drives task assignment in Salesforce CRM and Workfront.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to vendor.risk_assessment. Business justification: Vendor onboarding is the end-to-end qualification and activation process, which includes a mandatory risk assessment step (financial stability, data security, compliance). The onboarding record has ri',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor/supplier master record being onboarded. Links this onboarding workflow instance to the vendor profile in the vendor domain.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Vendor onboarding culminates in executed vendor contracts. Procurement teams track onboarding completion against contract execution milestones, link due diligence records to final contract terms, and ',
    `brand_safety_review_status` STRING COMMENT 'Status of the brand safety compliance review, assessing whether the vendors inventory, content adjacency, and operational practices meet the agencys brand safety standards per TAG and IAB guidelines.. Valid values are `not_started|in_progress|approved|rejected|conditional`',
    `ccpa_dpa_executed_date` DATE COMMENT 'The date on which the CCPA Data Processing Agreement was formally executed and signed by both parties.',
    `ccpa_dpa_status` STRING COMMENT 'Status of the CCPA-compliant data processing agreement with the vendor, required for vendors processing personal information of California consumers on behalf of the agency.. Valid values are `not_required|pending|executed|rejected`',
    `completion_date` DATE COMMENT 'The actual date on which the vendor onboarding process was fully completed and the vendor was activated in all relevant systems. Null if onboarding is still in progress or was rejected/withdrawn.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor onboarding record was first created in the system, providing the audit trail creation marker.',
    `due_diligence_checklist_complete` BOOLEAN COMMENT 'Indicates whether all items on the vendor due diligence checklist have been reviewed and signed off, covering financial, legal, operational, and compliance dimensions.',
    `due_diligence_completion_date` DATE COMMENT 'The date on which all due diligence checklist items were completed and signed off by the assigned reviewer.',
    `final_approval_date` DATE COMMENT 'The date on which the final approval or rejection decision was recorded for this onboarding attempt.',
    `final_approval_status` STRING COMMENT 'The final approval determination for the vendor onboarding attempt, granted by the designated approval authority after all review stages are complete.. Valid values are `pending|approved|conditionally_approved|rejected`',
    `financial_vetting_completion_date` DATE COMMENT 'The date on which the financial vetting review was completed and a determination recorded.',
    `financial_vetting_status` STRING COMMENT 'Current status of the financial vetting stage, including credit checks, financial stability assessment, and payment history review conducted via SAP S/4HANA FI.. Valid values are `not_started|in_progress|approved|rejected|pending_revision`',
    `gdpr_dpa_executed_date` DATE COMMENT 'The date on which the GDPR Data Processing Agreement was formally executed and signed by both parties.',
    `gdpr_dpa_status` STRING COMMENT 'Status of the GDPR-compliant Data Processing Agreement (DPA) with the vendor, required for any vendor processing personal data of EU data subjects on behalf of the agency.. Valid values are `not_required|pending|executed|rejected`',
    `initiated_date` DATE COMMENT 'The date on which the vendor onboarding process was formally initiated — i.e., when the RFI/RFP response was received and the workflow was opened. Serves as the principal business event date for this transaction.',
    `integration_test_completion_date` DATE COMMENT 'The date on which system integration testing was completed and a pass/fail determination was recorded.',
    `integration_test_notes` STRING COMMENT 'Free-text notes capturing the results, issues identified, and remediation actions from the system integration testing phase. Supports UAT (User Acceptance Testing) documentation.',
    `integration_test_status` STRING COMMENT 'Status of the technical system integration testing phase, covering API connectivity, ad serving tag validation (VAST/VPAID), DSP/SSP bid stream testing, and data feed verification with The Trade Desk and Google Campaign Manager 360.. Valid values are `not_started|in_progress|passed|failed|waived`',
    `legal_review_completion_date` DATE COMMENT 'The date on which the legal review was completed and a final determination (approved or rejected) was recorded.',
    `legal_review_status` STRING COMMENT 'Current status of the legal review stage, covering contract terms, liability clauses, intellectual property rights, and compliance with applicable advertising regulations.. Valid values are `not_started|in_progress|approved|rejected|pending_revision`',
    `mrc_accreditation_status` STRING COMMENT 'Accreditation status of the vendor under the Media Rating Council (MRC) standards for audience measurement and ad impression counting. Required for measurement and analytics vendors.. Valid values are `not_applicable|pending|accredited|expired|revoked`',
    `onboarding_status` STRING COMMENT 'High-level lifecycle status of the onboarding attempt, distinct from the granular stage. Indicates whether the overall process is actively progressing, paused, successfully completed, rejected, or withdrawn by the vendor.. Valid values are `in_progress|on_hold|completed|rejected|withdrawn`',
    `payment_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the agreed payment currency with the vendor (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `payment_terms` STRING COMMENT 'Agreed payment terms negotiated with the vendor during the onboarding financial vetting stage (e.g., Net 30, Net 60). Feeds SAP S/4HANA FI vendor master and Mediaocean Prisma billing configuration.. Valid values are `net_15|net_30|net_45|net_60|net_90`',
    `reference_number` STRING COMMENT 'Externally-known business identifier for this onboarding workflow instance, used in Salesforce CRM vendor onboarding workflows and cross-system communications (e.g., ONB-2024-000123). Serves as the human-readable tracking number shared with the vendor.. Valid values are `^ONB-[0-9]{4}-[0-9]{6}$`',
    `rejection_reason` STRING COMMENT 'Free-text description of the reason for rejection if the onboarding attempt was rejected at any stage (legal, financial, risk, brand safety, or final approval). Null if not rejected.',
    `rfi_received_date` DATE COMMENT 'The date on which the vendors completed RFI response was received, marking the formal start of the qualification review.',
    `rfi_response_received` BOOLEAN COMMENT 'Indicates whether the vendor has submitted a completed Request for Information (RFI) response as part of the initial qualification step of the onboarding process.',
    `salesforce_opportunity_code` STRING COMMENT 'The Salesforce CRM Opportunity or Account record ID associated with this vendor onboarding workflow, enabling traceability back to the originating CRM record.',
    `sap_vendor_account_code` STRING COMMENT 'The vendor account code assigned in SAP S/4HANA upon successful completion of onboarding, enabling financial transactions, purchase orders, and invoice processing in the ERP system.',
    `stage` STRING COMMENT 'Current stage of the vendor onboarding workflow lifecycle — from initial RFI/RFP response through legal review, financial vetting, risk assessment, accreditation verification, system integration setup, and final approval. [ENUM-REF-CANDIDATE: rfi_received|legal_review|financial_vetting|risk_assessment|accreditation_check|integration_setup|final_approval|completed|rejected|withdrawn — promote to reference product]',
    `tag_certification_status` STRING COMMENT 'Accreditation status of the vendor under the Trustworthy Accountability Group (TAG) Certified Against Fraud and Brand Safety programs. Required for programmatic media vendors and DSPs/SSPs.. Valid values are `not_applicable|pending|certified|expired|revoked`',
    `target_completion_date` DATE COMMENT 'The planned date by which the vendor onboarding process is expected to be fully completed and the vendor activated. Used for SLA tracking and escalation management.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor onboarding record was most recently modified, supporting audit trail and change tracking requirements.',
    `vendor_type` STRING COMMENT 'Classification of the vendor being onboarded — e.g., media publisher, Demand-Side Platform (DSP), Supply-Side Platform (SSP), Data Management Platform (DMP), Customer Data Platform (CDP), production supplier, or technology partner. Drives applicable due diligence checklist and accreditation requirements. [ENUM-REF-CANDIDATE: media_publisher|dsp|ssp|dmp|cdp|production_supplier|technology_partner|research_provider|ooh_vendor|data_provider — promote to reference product]',
    CONSTRAINT pk_vendor_onboarding PRIMARY KEY(`vendor_onboarding_id`)
) COMMENT 'Vendor onboarding workflow record tracking the end-to-end qualification and activation process — from initial RFI/RFP response through legal review, financial vetting, risk assessment, accreditation verification, system integration setup, and final approval. Captures onboarding stage, assigned reviewer, due diligence checklist completion, GDPR/CCPA data processing agreement status, payment terms agreed, integration test results, and completion date. Each record represents one onboarding attempt for one vendor (supplier_id). Supports Salesforce CRM vendor onboarding workflows and feeds vendor_risk assessment.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`io_line` (
    `io_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual line item within a vendor Insertion Order. Primary key for this entity. Entity role: TRANSACTION_LINE — represents one discrete media buy line within a vendor IO header.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign this IO line item is associated with, enabling campaign-level spend and delivery aggregation.',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: IO lines specify which client brand the media buy supports. Multi-brand advertisers require brand-level media spend tracking. Critical for brand budget management, pacing dashboards, and brand-level R',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: IO lines often map to specific flights within campaigns for budget allocation and pacing. Required for flight-level budget tracking, delivery monitoring, and financial planning in advertising media bu',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Insertion order lines represent committed media buys executed within specific projects/initiatives. Linking IO lines to initiative enables project media planning tracking, budget monitoring, and deliv',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to campaign.line_item. Business justification: IO lines frequently correspond 1:1 with campaign line items for execution tracking. Essential for linking contractual commitments to delivery execution, reconciliation, and billing in advertising oper',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Vendor IO lines represent the vendors billing line items that must reconcile to the agencys media insertion order. Reconciliation teams match vendor IO lines to media IOs to validate billing accurac',
    `media_placement_id` BIGINT COMMENT 'The placement identifier from Google Campaign Manager 360 (CM360) ad server corresponding to this IO line item. Enables trafficking, delivery tracking, and third-party ad serving reconciliation.',
    `programmatic_deal_id` BIGINT COMMENT 'The unique deal identifier assigned by the Supply-Side Platform (SSP) or publisher for Private Marketplace (PMP) or Programmatic Guaranteed deals. Used to activate and track specific inventory packages in The Trade Desk and other Demand-Side Platforms (DSPs).',
    `supplier_id` BIGINT COMMENT 'Reference to the third-party media vendor, publisher, or technology partner supplying the media inventory for this line item. Satisfies TRANSACTION_LINE RESOURCE_REFERENCE category.',
    `talent_engagement_id` BIGINT COMMENT 'Foreign key linking to talent.engagement. Business justification: Vendor insertion order lines for talent services (influencer posts, actor appearances, crew bookings) should reference the specific talent engagement. Critical for delivery tracking, performance verif',
    `vendor_io_media_insertion_order_id` BIGINT COMMENT 'Foreign key reference to the parent Insertion Order header that this line item belongs to. Satisfies TRANSACTION_LINE HEADER_REFERENCE category — mandatory link to the parent IO.',
    `actual_spend` DECIMAL(18,2) COMMENT 'The actual amount spent against this line item based on delivered units and applicable rate, as reported by the vendor or ad server. Compared against contracted_spend during financial reconciliation in Mediaocean Prisma and SAP S/4HANA.',
    `actual_units_delivered` DECIMAL(18,2) COMMENT 'The actual number of units (impressions, clicks, GRPs, etc.) delivered by the vendor for this line item as reported by the ad server or third-party measurement provider. Used in reconciliation against contracted_units to identify under- or over-delivery.',
    `ad_format` STRING COMMENT 'The creative format of the ad unit being delivered on this line item. Determines technical specifications and delivery method. Includes display banners, video (VAST/VPAID), audio, native, Out-of-Home (OOH), Digital Out-of-Home (DOOH), Connected TV (CTV), and Over-the-Top (OTT). [ENUM-REF-CANDIDATE: display|video|audio|native|OOH|DOOH|CTV|OTT|rich_media — promote to reference product]',
    `ad_unit_size` STRING COMMENT 'Pixel dimensions of the ad unit (e.g., 300x250, 728x90, 160x600). Applicable to display and rich media formats. Null for non-dimensional formats such as audio, OOH, or CTV.. Valid values are `^[0-9]+x[0-9]+$`',
    `added_value_flag` BOOLEAN COMMENT 'Indicates whether this line item represents added-value inventory (bonus impressions, editorial mentions, or complimentary placements) provided by the vendor at no additional cost as part of the negotiated IO package.',
    `agency_commission_pct` DECIMAL(18,2) COMMENT 'The agency commission percentage applied to this line items gross spend, typically 15% per industry standard. Used to calculate net vendor cost and agency revenue. Expressed as a percentage (e.g., 15.00 for 15%).',
    `brand_safety_segments` STRING COMMENT 'Comma-separated list of brand safety and content suitability categories applied to this line item to prevent ad adjacency with inappropriate content. Aligned with TAG Brand Safety Standards and IAB Content Taxonomy.',
    `buying_type` STRING COMMENT 'The pricing and buying model for this line item. Specifies whether inventory is purchased on a Cost Per Mille (CPM), Cost Per Click (CPC), Cost Per Acquisition (CPA), Cost Per View (CPV), Cost Per Completed View (CPCV), flat rate, Gross Rating Point (GRP), or Target Rating Point (TRP) basis. [ENUM-REF-CANDIDATE: CPM|CPC|CPA|CPV|CPCV|flat_rate|GRP|TRP — promote to reference product]',
    `contracted_spend` DECIMAL(18,2) COMMENT 'The total authorized spend amount for this line item as agreed in the Insertion Order (rate × contracted_units for unit-based buys, or flat rate for flat buys). Represents the financial commitment to the vendor. Core to Mediaocean Prisma billing and budget management.',
    `contracted_units` DECIMAL(18,2) COMMENT 'The total number of units (impressions, clicks, acquisitions, GRPs, TRPs, or views) contracted with the vendor for this line item as specified in the Insertion Order. Satisfies TRANSACTION_LINE LINE_QUANTITY category.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this IO line item record was first created in the system. Used for audit trail, data lineage, and compliance reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary values on this line item (rate, contracted spend, actual spend). Supports multi-currency media buying across international campaigns.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'The mechanism by which ad inventory is purchased and delivered for this line item. Distinguishes between Real-Time Bidding (RTB) programmatic, programmatic direct, guaranteed direct buys, non-guaranteed direct, and Private Marketplace (PMP) deals. Core to The Trade Desk and Mediaocean Prisma workflow classification.. Valid values are `programmatic_rtb|programmatic_direct|direct_guaranteed|direct_non_guaranteed|private_marketplace`',
    `dsp_line_code` STRING COMMENT 'The external line item identifier assigned by the Demand-Side Platform (DSP), such as The Trade Desk, for programmatic buys. Enables cross-system reconciliation between Mediaocean Prisma and the DSP platform.',
    `flight_end_date` DATE COMMENT 'The date on which ad delivery for this line item is scheduled to end. Defines the close of the contracted flight period. Used for campaign scheduling, pacing, and vendor reconciliation.',
    `flight_start_date` DATE COMMENT 'The date on which ad delivery for this line item is scheduled to begin. Defines the start of the contracted flight period. Used for campaign scheduling, pacing, and reconciliation.',
    `frequency_cap` STRING COMMENT 'Maximum number of times a unique user or household may be served an ad from this line item within the frequency_cap_period. Controls ad fatigue and audience experience as configured in Google Campaign Manager 360 or The Trade Desk.',
    `frequency_cap_period` STRING COMMENT 'The time window over which the frequency_cap applies. Defines whether the cap is enforced per hour, day, week, month, or over the lifetime of the campaign flight.. Valid values are `hour|day|week|month|lifetime`',
    `geo_targeting` STRING COMMENT 'Geographic scope of ad delivery for this line item, specifying targeted countries, regions, DMAs, or cities. Expressed as a comma-separated list of location identifiers or descriptive text (e.g., USA - New York DMA, Los Angeles DMA).',
    `grp_contracted` DECIMAL(18,2) COMMENT 'The total Gross Rating Points (GRPs) contracted for this line item, applicable to broadcast, OOH, and audience-guaranteed buys. Represents reach × frequency for the target audience. Tracked via Nielsen Ad Intel.',
    `line_description` STRING COMMENT 'Human-readable description of the media buy represented by this line item, including placement name, ad unit, and targeting summary as specified in the Insertion Order.',
    `line_number` STRING COMMENT 'Sequential line number identifying the position of this line item within the parent Insertion Order. Satisfies TRANSACTION_LINE LINE_SEQUENCE category. Used for ordering, referencing, and reconciliation against vendor invoices.',
    `line_status` STRING COMMENT 'Current workflow and lifecycle status of this IO line item within Mediaocean Prisma. Tracks progression from draft through approval, active delivery, completion, and financial reconciliation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|paused|completed|cancelled|reconciled — promote to reference product]',
    `makegood_flag` BOOLEAN COMMENT 'Indicates whether this IO line item is a make-good — compensatory inventory provided by the vendor to offset under-delivery or quality failures on a prior line item. True if this is a make-good line; False otherwise.',
    `net_rate` DECIMAL(18,2) COMMENT 'The net unit rate payable to the vendor after deducting agency commission from the gross rate. Used for vendor invoice validation and SAP S/4HANA accounts payable processing.',
    `placement_name` STRING COMMENT 'Name of the specific ad placement or inventory unit being purchased on the vendors property (e.g., Homepage Takeover, Pre-Roll Video, Leaderboard 728x90). Used in trafficking and reporting within Google Campaign Manager 360.',
    `prisma_line_code` STRING COMMENT 'The native line item identifier from Mediaocean Prisma, the system of record for media planning, buying, billing, and reconciliation. Used for cross-system traceability and audit.',
    `rate` DECIMAL(18,2) COMMENT 'The negotiated unit rate for this line item expressed in the currency of the IO. Interpretation depends on buying_type: CPM rate per 1,000 impressions, CPC rate per click, CPA rate per acquisition, flat rate for the full flight, or GRP/TRP rate per rating point. Satisfies TRANSACTION_LINE LINE_VALUE_OR_RESULT category.',
    `reconciliation_status` STRING COMMENT 'Financial reconciliation status of this line item comparing contracted delivery against vendor-reported actuals. Tracks whether the line has been reconciled, is under dispute, or has been written off. Core to Mediaocean Prisma billing reconciliation workflow.. Valid values are `unreconciled|in_progress|reconciled|disputed|written_off`',
    `targeting_description` STRING COMMENT 'Free-text description of the audience targeting parameters applied to this line item, including demographic, geographic, behavioral, contextual, or keyword targeting criteria as configured in The Trade Desk or Google Campaign Manager 360.',
    `trp_contracted` DECIMAL(18,2) COMMENT 'The total Target Rating Points (TRPs) contracted for this line item, representing GRPs delivered specifically to the defined target audience demographic. Used for audience-guaranteed buys tracked via Nielsen Ad Intel.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this IO line item record was last modified. Tracks changes to rate, units, flight dates, status, or targeting parameters for audit and reconciliation purposes.',
    `viewability_target_pct` DECIMAL(18,2) COMMENT 'The contracted minimum viewability rate (percentage of served impressions that meet MRC viewability standards) for this line item. Used to enforce quality guarantees with vendors and measure delivery compliance.',
    CONSTRAINT pk_io_line PRIMARY KEY(`io_line_id`)
) COMMENT 'Individual line items within a vendor Insertion Order, each specifying a discrete media buy — placement, ad unit, targeting parameters, flight dates, contracted impressions or GRPs, CPM/CPC rate, and authorized spend. Captures delivery method (programmatic RTB, direct, guaranteed), ad format (display, video VAST, OOH, CTV), and reconciliation status against actuals. Core to Mediaocean Prisma billing and reconciliation.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique surrogate identifier for the invoice record in the vendor billing and reconciliation system. Primary key for the invoice data product within the vendor domain.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with the media spend or production services billed on this invoice. Enables campaign-level financial reconciliation and P&L reporting.',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Advertising invoices are typically allocated to specific client brands, not just advertiser level. Brand-level budget tracking and P&L reporting require invoice-to-brand attribution. Essential for bra',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: Invoices often bill at flight level in multi-flight campaigns for granular financial tracking. Essential for flight-level budget reconciliation, variance analysis, and financial reporting in advertisi',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Vendor invoices must be allocated to projects/initiatives for accurate project cost accounting, budget tracking, and financial reporting. Essential for project P&L, variance analysis, and client billi',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to campaign.line_item. Business justification: Invoices frequently itemize by line item for granular billing and cost tracking. Critical for line-item-level cost reconciliation, variance analysis, and financial reporting in advertising media buyin',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Invoices bill against specific media insertion orders. AP teams reconcile vendor invoices to media IOs for payment approval and budget tracking. invoice.insertion_order_id currently targets contract d',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Vendor invoices often bill against SOW-level budgets and scope, not just insertion orders. Finance teams reconcile invoice amounts to SOW committed spend and track SOW budget burn rates across multipl',
    `supplier_id` BIGINT COMMENT 'Reference to the third-party media vendor, publisher, technology partner (DSP/SSP/DMP), or production supplier who issued this invoice. Links to the vendor master record.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Invoices execute vendor contract payment terms and pricing models. AP teams validate invoice terms against master vendor contracts, verify rate cards, and enforce payment terms and liability caps defi',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Vendor invoices for talent services (freelancer fees, influencer payments, crew charges) need to reference the specific worker who performed the work. Essential for timesheet reconciliation, payment a',
    `agency_discount_amount` DECIMAL(18,2) COMMENT 'The monetary value of agency commission or trade discount deducted from the gross invoice amount, as negotiated in the vendor contract or IO. Typically expressed as a percentage of gross media spend.',
    `approved_billing_amount` DECIMAL(18,2) COMMENT 'The final approved amount authorized for payment after reconciliation and dispute resolution. May differ from the original net_amount if adjustments were made during the reconciliation or dispute process. This is the amount posted to SAP S/4HANA FI-AP for payment.',
    `billing_period_end` DATE COMMENT 'The end date of the media flight, production period, or service period covered by this invoice. Together with billing_period_start, defines the reconciliation window for delivery data matching.',
    `billing_period_start` DATE COMMENT 'The start date of the media flight, production period, or service period covered by this invoice. Used to align invoice charges with campaign delivery windows and IO-authorized spend periods.',
    `brand_safety_compliant` BOOLEAN COMMENT 'Indicates whether the media inventory delivered by the vendor during the billing period was verified as brand-safe per TAG (Trustworthy Accountability Group) and internal brand safety standards. A value of False may trigger invoice dispute or vendor review.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the invoice record was first created in the system, representing the audit trail creation event. Follows ISO 8601 format with timezone offset.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice (e.g., USD, GBP, EUR). Required for multi-currency media buying operations and SAP S/4HANA foreign currency revaluation.. Valid values are `^[A-Z]{3}$`',
    `delivered_spend_amount` DECIMAL(18,2) COMMENT 'The actual ad spend amount as recorded by the ad server (Google CM360) or DSP (The Trade Desk) for the billing period. Represents the verified delivery data used in post-buy reconciliation against the vendor invoice.',
    `delivery_data_source` STRING COMMENT 'The ad server or measurement platform used as the authoritative source of delivery data for reconciliation (e.g., Google CM360, The Trade Desk). Determines which systems impression and spend data is used to validate the vendor invoice. [ENUM-REF-CANDIDATE: cm360|the_trade_desk|mediaocean_prisma|nielsen|comscore|vendor_reported|other — promote to reference product]',
    `discrepancy_reason_code` STRING COMMENT 'Standardized code identifying the root cause of the reconciliation variance. Delivery shortfall: vendor delivered less than invoiced. Overbilling: vendor charged above IO rate. Trafficking error: ad server setup error. Invalid traffic: IVT/fraud detected. Make good: compensatory delivery. [ENUM-REF-CANDIDATE: delivery_shortfall|overbilling|trafficking_error|data_discrepancy|invalid_traffic|make_good|other — promote to reference product]',
    `dispute_id` BIGINT COMMENT 'Unique identifier for the formal dispute case raised against this invoice when the variance exceeds the acceptable threshold. Links to the dispute management workflow in SAP S/4HANA or Mediaocean Prisma.',
    `dispute_raised_date` DATE COMMENT 'The date on which a formal billing dispute was raised with the vendor. Initiates the dispute resolution clock and triggers vendor notification per contractual SLA terms.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the billing dispute was formally resolved and the approved billing amount was agreed upon with the vendor. Marks the transition from disputed to approved status.',
    `dispute_resolution_notes` STRING COMMENT 'Free-text narrative documenting the outcome of the dispute resolution process, including the agreed adjustment, vendor concessions, make-good arrangements, or credit note details.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross amount billed by the vendor before any agency discounts, rebates, or adjustments. Represents the full rate card value of media or services delivered as stated on the vendor invoice.',
    `invalid_traffic_flag` BOOLEAN COMMENT 'Indicates whether invalid traffic (IVT) or ad fraud was detected in the delivery data for this invoice period, as identified by TAG-certified measurement tools. A True value triggers discrepancy_reason_code = invalid_traffic and initiates dispute proceedings.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice within the invoice-to-payment workflow. Received: invoice has been received from vendor. Reconciled: matched against IO and delivery data. Approved: cleared for payment. Disputed: discrepancy identified requiring resolution. Paid: payment has been issued.. Valid values are `received|reconciled|approved|disputed|paid`',
    `invoice_type` STRING COMMENT 'Classification of the invoice by the nature of services billed. Media covers ad placements and programmatic buys; production covers creative and content production; technology covers DSP/SSP/DMP platform fees; data covers audience data and analytics services; talent covers freelance and contractor services. [ENUM-REF-CANDIDATE: media|production|technology|data|talent|other — promote to reference product]. Valid values are `media|production|technology|data|talent|other`',
    `io_authorized_amount` DECIMAL(18,2) COMMENT 'The total spend amount authorized under the associated Insertion Order (IO) for the billing period. Used as the baseline for reconciliation against the vendor invoice gross amount to identify overbilling or underbilling.',
    `issue_date` DATE COMMENT 'The date the invoice was issued by the vendor, as stated on the invoice document. Used as the principal business event date for the invoice and for payment terms calculation.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net payable amount after deducting agency discounts and rebates from the gross amount. This is the amount recorded in SAP S/4HANA Accounts Payable for payment processing.',
    `number` STRING COMMENT 'Externally-assigned invoice number as provided by the vendor on the invoice document. Used as the primary business identifier for matching vendor invoices to internal purchase orders and IOs. Must be unique per vendor.',
    `payment_date` DATE COMMENT 'The date on which payment was issued to the vendor for the approved billing amount. Populated when invoice status transitions to paid. Used for cash flow reporting and vendor payment history.',
    `payment_due_date` DATE COMMENT 'The contractual date by which payment must be made to the vendor to comply with agreed payment terms (e.g., Net 30, Net 60). Used for cash flow planning and avoiding late payment penalties.',
    `payment_reference` STRING COMMENT 'The payment transaction reference number generated by SAP S/4HANA FI-AP when the payment run is executed. Used to trace the payment in bank statements and vendor remittance advice.',
    `payment_terms` STRING COMMENT 'The contractual payment terms agreed with the vendor, defining the number of days from invoice receipt to payment due date (e.g., Net 30, Net 60). Sourced from the vendor contract in SAP S/4HANA.. Valid values are `net_30|net_45|net_60|net_90|immediate|other`',
    `received_date` DATE COMMENT 'The date the invoice was received and logged into the accounts payable system. May differ from the issue date due to postal or electronic delivery lag. Used for aging analysis and payment terms compliance.',
    `reconciliation_date` DATE COMMENT 'The date on which the invoice reconciliation was completed and the variance amount and percentage were calculated. Marks the transition from received to reconciled status.',
    `reconciliation_period_end` DATE COMMENT 'The end date of the reconciliation window used to pull delivery data from CM360 or The Trade Desk for matching against this invoice.',
    `reconciliation_period_start` DATE COMMENT 'The start date of the reconciliation window used to pull delivery data from CM360 or The Trade Desk for matching against this invoice. May differ from billing_period_start if reconciliation covers a different date range.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The applicable tax amount (e.g., VAT, GST, sales tax) charged on the invoice as required by the vendors jurisdiction. Recorded separately for tax compliance and SAP S/4HANA FI tax reporting.',
    `total_payable_amount` DECIMAL(18,2) COMMENT 'The final total amount payable to the vendor, calculated as net_amount plus tax_amount. This is the amount that will be disbursed in the payment run in SAP S/4HANA FI-AP.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the invoice record was last modified, capturing any status changes, reconciliation updates, dispute actions, or payment postings. Used for audit trail and change tracking in the Silver Layer.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference between the vendors invoiced gross amount and the delivered spend amount recorded by the ad server or DSP. A positive value indicates overbilling by the vendor; negative indicates underbilling.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance amount expressed as a percentage of the delivered spend amount. Used to assess whether the discrepancy exceeds the industry-standard tolerance threshold (typically 10% per MRC guidelines) triggering a formal dispute.',
    `vendor_reference_number` STRING COMMENT 'Vendors own internal reference or purchase order number included on the invoice, used to cross-reference the vendors billing system and facilitate dispute resolution.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Invoice, reconciliation, and billing resolution record for media vendors, publishers, and production suppliers. Captures the full invoice-to-payment lifecycle: invoice receipt (number, vendor reference, billing period, gross/net amounts, currency, payment due date), reconciliation against IO-authorized spend and actual ad server delivery data (CM360, The Trade Desk) including variance amount, variance percentage, discrepancy reason code, reconciliation period, dispute management, resolution status, and final approved billing amount. Supports invoice statuses: received, reconciled, approved, disputed, paid. Feeds SAP S/4HANA Accounts Payable, Mediaocean Prisma post-buy reconciliation, and financial close processes.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`reconciliation` (
    `reconciliation_id` BIGINT COMMENT 'Unique surrogate identifier for the media cost reconciliation record. Primary key for this entity in the Silver Layer lakehouse.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this reconciliation record, enabling campaign-level financial close and post-buy analysis.',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Reconciliations track delivered spend by brand for budget management. Multi-brand advertisers reconcile vendor invoices at brand level to ensure accurate brand P&L. Essential for brand-level financial',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: Reconciliations often occur at flight level for multi-flight campaigns to verify delivery and spend. Essential for flight-level discrepancy resolution, makegood tracking, and financial accuracy in adv',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Media reconciliations validate vendor billing against project budgets and deliverables. Linking reconciliation to initiative enables project-level financial close, variance reporting, and ensures proj',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to vendor.invoice. Business justification: Reconciliation is the process of comparing IO-authorized spend against vendor-invoiced amounts and ad-server-delivered spend. Each reconciliation record analyzes a specific invoice to identify varianc',
    `io_line_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_io_line. Business justification: Reconciliations occur at IO line level to match contracted vs delivered units. Essential for billing disputes, makegood identification, under-delivery penalties, and vendor performance evaluation. Ena',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to campaign.line_item. Business justification: Reconciliations commonly reconcile at line-item level for granular delivery verification against contracted units. Critical for line-item-level discrepancy resolution, billing accuracy, and vendor per',
    `media_insertion_order_id` BIGINT COMMENT 'Reference to the Insertion Order (IO) that authorized the media spend being reconciled. Links reconciliation to the originating IO commitment.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Reconciliation validates delivered media spend against SOW-level budgets and scope commitments. Finance teams track SOW budget utilization, flag overruns, and trigger SOW amendments when reconciled sp',
    `supplier_id` BIGINT COMMENT 'Reference to the third-party media vendor, publisher, or technology partner (DSP/SSP) whose invoice is being reconciled against authorized spend.',
    `talent_engagement_id` BIGINT COMMENT 'Foreign key linking to talent.engagement. Business justification: Reconciliation of vendor invoices for talent services needs to reference the specific engagement for accurate billing verification. Essential for matching invoiced amounts against engagement agreement',
    `adserver_delivered_amount` DECIMAL(18,2) COMMENT 'Actual media cost derived from ad server delivery data (Google Campaign Manager 360 or The Trade Desk) for the reconciliation period. Used as the authoritative delivery benchmark in post-buy reconciliation.',
    `adserver_source` STRING COMMENT 'Identifies the authoritative ad serving or DSP platform from which delivery data was sourced for this reconciliation (e.g., Google Campaign Manager 360, The Trade Desk). Ensures traceability of delivery benchmarks.. Valid values are `CM360|the_trade_desk|mediaocean_prisma|other`',
    `approved_billing_amount` DECIMAL(18,2) COMMENT 'The mutually agreed and approved final billing amount after reconciliation resolution. This is the amount posted to SAP S/4HANA for financial close and vendor payment processing.',
    `approved_by` STRING COMMENT 'Name or identifier of the agency finance or media operations team member who formally approved the final billing amount and closed the reconciliation record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the reconciliation record was formally approved and the final billing amount was confirmed. Key lifecycle event for SAP S/4HANA financial period close.',
    `buying_method` STRING COMMENT 'Method by which the media was purchased, distinguishing between direct IO buys, programmatic guaranteed, open RTB (Real-Time Bidding), private marketplace (PMP), or preferred deals. Affects reconciliation workflow and tolerance thresholds.. Valid values are `direct_io|programmatic_guaranteed|open_rtb|private_marketplace|preferred_deal`',
    `channel_type` STRING COMMENT 'The media channel category for the spend being reconciled (e.g., Display, Video, CTV/OTT, OOH/DOOH, Search). Enables channel-level reconciliation reporting and variance analysis. [ENUM-REF-CANDIDATE: display|video|search|social|ooh|dooh|ctv|ott|audio|print — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this reconciliation record was first created in the system, establishing the audit trail start point for the post-buy reconciliation lifecycle.',
    `credit_note_amount` DECIMAL(18,2) COMMENT 'Monetary value of the vendor-issued credit note applied to resolve an overbilling discrepancy. Reduces the net payable amount in SAP S/4HANA Accounts Payable.',
    `credit_note_number` STRING COMMENT 'Vendor-issued credit note reference number when a credit adjustment is issued to resolve an overbilling discrepancy. Linked to SAP S/4HANA Accounts Payable credit memo processing.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary amounts on this reconciliation record (e.g., USD, GBP, EUR). Supports multi-currency media buying operations.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_description` STRING COMMENT 'Free-text narrative explaining the specific nature of the billing discrepancy, including details of delivery shortfalls, trafficking errors, or vendor disputes not fully captured by the reason code.',
    `discrepancy_reason_code` STRING COMMENT 'Standardized code classifying the root cause of the billing discrepancy between IO-authorized spend and vendor invoice. Drives resolution workflow and vendor performance tracking. [ENUM-REF-CANDIDATE: delivery_shortfall|trafficking_error|ad_fraud|brand_safety_block|viewability_adjustment|data_discrepancy|billing_error|makegood_offset — promote to reference product]',
    `due_date` DATE COMMENT 'Date by which the approved billing amount must be paid to the vendor per contractual payment terms. Derived from vendor invoice date and agreed net payment terms (e.g., Net 30, Net 60).',
    `io_authorized_amount` DECIMAL(18,2) COMMENT 'Total media spend amount authorized under the Insertion Order (IO) for the reconciliation period. Represents the contractually committed budget against which vendor invoices are compared.',
    `makegood_flag` BOOLEAN COMMENT 'Indicates whether a make-good placement has been agreed as part of the discrepancy resolution, where the vendor compensates for delivery shortfalls with additional inventory rather than a monetary credit.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, escalation notes, or vendor communication summaries relevant to the reconciliation record. Used by media finance teams during dispute resolution.',
    `period_end_date` DATE COMMENT 'End date of the media delivery period covered by this reconciliation record. Together with period_start_date defines the reconciliation billing window.',
    `period_start_date` DATE COMMENT 'Start date of the media delivery period covered by this reconciliation record. Defines the billing window for comparing IO-authorized spend against vendor-invoiced amounts.',
    `prisma_reconciliation_ref` STRING COMMENT 'Reference identifier from Mediaocean Prisma post-buy reconciliation module corresponding to this record. Enables traceability between the lakehouse Silver Layer and the source system of record.',
    `reconciliation_number` STRING COMMENT 'Externally-known business identifier for this reconciliation record, used in Mediaocean Prisma post-buy workflows and SAP S/4HANA financial close correspondence with vendors.. Valid values are `^REC-[0-9]{4}-[0-9]{6}$`',
    `reconciliation_status` STRING COMMENT 'Current lifecycle state of the reconciliation record within the post-buy financial close workflow. Drives approval routing in Mediaocean Prisma and SAP S/4HANA.. Valid values are `draft|in_review|disputed|approved|closed|cancelled`',
    `reconciliation_type` STRING COMMENT 'Classification of the reconciliation record indicating whether it covers standard media buys, programmatic (RTB/DSP) activity, make-good placements, credit adjustments, or final billing close.. Valid values are `standard|programmatic|makegood|credit_adjustment|final_bill`',
    `resolution_date` DATE COMMENT 'Date on which the billing discrepancy was formally resolved and the approved billing amount was agreed between the agency and the vendor.',
    `resolution_status` STRING COMMENT 'Current status of the discrepancy resolution process. Tracks whether the variance is unresolved, awaiting vendor response, under internal review, fully resolved, or written off as immaterial.. Valid values are `unresolved|pending_vendor|pending_internal|resolved|written_off`',
    `sap_document_number` STRING COMMENT 'SAP S/4HANA FI accounting document number generated upon financial close posting of the approved billing amount. Provides the audit link between media reconciliation and the general ledger.',
    `tolerance_threshold_pct` DECIMAL(18,2) COMMENT 'Agreed acceptable variance percentage threshold below which discrepancies are considered immaterial and do not require formal dispute resolution. Typically set per vendor contract or IAB industry standard (commonly 10%).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this reconciliation record was most recently modified, supporting audit trail requirements and change tracking in the Silver Layer lakehouse.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Absolute monetary difference between the vendor-invoiced amount and the ad server delivered amount (vendor_invoiced_amount minus adserver_delivered_amount). Positive value indicates vendor overbilling; negative indicates underbilling.',
    `variance_pct` DECIMAL(18,2) COMMENT 'Variance expressed as a percentage of the IO-authorized amount ((variance_amount / io_authorized_amount) * 100). Used to assess materiality of discrepancy against agency tolerance thresholds (typically ±10% per IAB guidelines).',
    `vendor_invoiced_amount` DECIMAL(18,2) COMMENT 'Total gross amount billed by the vendor on their invoice for the reconciliation period. Primary input to variance calculation against IO-authorized spend.',
    `within_tolerance_flag` BOOLEAN COMMENT 'Indicates whether the variance percentage falls within the agreed tolerance threshold, determining whether formal dispute escalation is required.',
    CONSTRAINT pk_reconciliation PRIMARY KEY(`reconciliation_id`)
) COMMENT 'Media cost reconciliation record comparing IO-authorized spend against vendor-invoiced amounts and actual delivery data from ad servers (CM360, The Trade Desk). Captures reconciliation period, variance amount, variance percentage, discrepancy reason code, resolution status, and approved final billing amount. Supports Mediaocean Prisma post-buy reconciliation and SAP S/4HANA financial close processes.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`vendor_contact` (
    `vendor_contact_id` BIGINT COMMENT 'Unique surrogate identifier for the vendor contact record in the Silver Layer lakehouse. Primary key for the vendor_contact data product.',
    `supplier_id` BIGINT COMMENT 'Reference to the parent vendor organisation record to which this contact belongs. Links the individual contact to the vendor master profile.',
    `agency_relationship_owner` STRING COMMENT 'Full name or employee identifier of the agency-side team member who owns the relationship with this vendor contact. Represents the internal counterpart responsible for day-to-day engagement, escalation management, and vendor performance oversight.',
    `city` STRING COMMENT 'City where the vendor contact is primarily based. Used for regional market alignment, OOH/DOOH territory management, and scheduling in-person meetings or site visits.',
    `contact_source` STRING COMMENT 'Indicates the originating source through which this vendor contact record was created or first captured. Supports data lineage tracking and CRM data quality audits.. Valid values are `salesforce_crm|manual_entry|vendor_portal|io_document|rfp_response|conference`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the vendor contact record. Indicates whether the contact is actively engaged, temporarily unavailable, or no longer with the vendor organisation. Drives communication routing and CRM hygiene.. Valid values are `active|inactive|on_leave|departed|pending_verification`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code representing the country where the vendor contact is primarily based. Used for regulatory jurisdiction determination (GDPR, CCPA), regional media buying operations, and OOH/DOOH market coverage.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this vendor contact record was first created in the source system (Salesforce CRM). Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage tracking.',
    `data_privacy_region` STRING COMMENT 'Regulatory privacy jurisdiction applicable to this vendor contacts personal data. Determines which data protection framework governs the processing of their information (e.g., GDPR for EEA, CCPA for USA-California, PIPEDA for Canada).. Valid values are `EEA|USA|GBR|CAN|AUS|OTHER`',
    `department` STRING COMMENT 'Business department or functional unit within the vendor organisation to which this contact belongs (e.g., Ad Operations, Finance, Technology, Sales). Supports routing of operational queries to the correct team.',
    `do_not_contact_flag` BOOLEAN COMMENT 'Indicates that this vendor contact has requested to not be contacted, or has been flagged by the agency as inactive for outreach. Ensures compliance with communication preferences and prevents unsolicited contact in line with GDPR and CCPA opt-out requirements.',
    `email` STRING COMMENT 'Primary business email address of the vendor contact. The principal digital channel for day-to-day operational communication, Insertion Order (IO) correspondence, and escalation. Managed in Salesforce CRM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of the vendor contact individual as recorded in Salesforce CRM. Used for personalised communication and salutation in correspondence.',
    `gdpr_consent_status` STRING COMMENT 'Records the GDPR consent status for processing this vendor contacts personal data. Required for contacts based in the European Economic Area (EEA). Tracks whether consent has been obtained, is not required (B2B legitimate interest), has been withdrawn, or is pending confirmation.. Valid values are `obtained|not_required|withdrawn|pending`',
    `is_billing_contact` BOOLEAN COMMENT 'Indicates whether this vendor contact is designated to receive billing-related communications including invoices, reconciliation queries, and credit note notifications. Supports the Mediaocean Prisma billing workflow and SAP S/4HANA FI processes.',
    `is_executive_sponsor` BOOLEAN COMMENT 'Indicates whether this vendor contact holds an executive sponsor role, typically a senior stakeholder engaged for Quarterly Business Reviews (QBRs), strategic negotiations, and escalation resolution at the executive level.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this individual is the designated primary point of contact for the vendor organisation. Only one contact per vendor should hold this flag as True at any given time. Used to determine default routing for IO negotiations and account queries.',
    `is_technical_contact` BOOLEAN COMMENT 'Indicates whether this vendor contact is the designated technical integration lead responsible for API connections, tag implementation, DSP/SSP platform integrations, and VAST/VPAID troubleshooting.',
    `job_title` STRING COMMENT 'Official job title or designation of the vendor contact within their organisation (e.g., Account Manager, Trafficking Coordinator, VP of Partnerships). Used to identify seniority and functional responsibility.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region subtag, e.g., en-US, fr-FR) representing the vendor contacts preferred language for written and verbal communication. Supports multilingual campaign operations and international media buying.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_interaction_date` DATE COMMENT 'Date of the most recent recorded interaction between the agency and this vendor contact (e.g., email, call, meeting, QBR). Used to identify stale contacts, drive CRM hygiene, and prioritise re-engagement for active campaigns.',
    `last_name` STRING COMMENT 'Family name / surname of the vendor contact individual. Combined with first_name to form the full display name for operational communication and escalation paths.',
    `linkedin_url` STRING COMMENT 'LinkedIn public profile URL for the vendor contact. Used for professional background verification, relationship intelligence, and executive engagement preparation ahead of QBRs and pitch meetings.. Valid values are `^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$`',
    `mobile_phone` STRING COMMENT 'Mobile / cell phone number for the vendor contact in E.164 format. Used for urgent out-of-hours escalations, SMS notifications, and direct contact when office lines are unavailable.. Valid values are `^+?[1-9]d{1,14}$`',
    `notes` STRING COMMENT 'Free-text field for capturing qualitative notes about the vendor contact, including relationship context, communication preferences, escalation history, or special instructions from the agency account team. Sourced from Salesforce CRM Contact Description field.',
    `offboarding_date` DATE COMMENT 'Date on which this vendor contact was offboarded or deactivated from the agencys vendor management system, typically due to departure from the vendor organisation or role change. Triggers deactivation workflows and access revocation.',
    `onboarding_date` DATE COMMENT 'Date on which this vendor contact was formally onboarded into the agencys vendor management system (Salesforce CRM). Marks the start of the operational relationship and triggers onboarding workflow tasks in Workfront.',
    `phone` STRING COMMENT 'Primary business phone number for the vendor contact in E.164 international format. Used for urgent operational communication, campaign trafficking issues, and escalation calls.. Valid values are `^+?[1-9]d{1,14}$`',
    `preferred_communication_channel` STRING COMMENT 'The vendor contacts stated preferred channel for receiving communications from the agency. Guides account teams on how to initiate contact for routine updates, campaign queries, and escalations.. Valid values are `email|phone|mobile|slack|teams|portal`',
    `role_type` STRING COMMENT 'Functional role classification of the vendor contact from the agencys perspective. Determines routing of operational requests, escalations, and communications. [ENUM-REF-CANDIDATE: account_manager|trafficking_coordinator|billing_contact|technical_integration_lead|executive_sponsor|media_planner|legal_contact|data_privacy_officer — promote to reference product if additional roles are required]. Valid values are `account_manager|trafficking_coordinator|billing_contact|technical_integration_lead|executive_sponsor|media_planner`',
    `salesforce_contact_code` STRING COMMENT 'The native 18-character Salesforce CRM Contact object identifier (Sales Cloud). Used for bi-directional synchronisation between the lakehouse Silver Layer and the Salesforce system of record.',
    `secondary_email` STRING COMMENT 'Alternate or backup email address for the vendor contact. Used when the primary email is unresponsive or for specific communication streams such as billing or technical alerts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the vendor contacts primary working location (e.g., America/New_York, Europe/London). Used to schedule calls, set SLA response windows, and coordinate cross-timezone campaign operations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this vendor contact record in the source system (Salesforce CRM). Conforms to ISO 8601 format. Used for incremental ETL processing, change detection, and audit compliance.',
    CONSTRAINT pk_vendor_contact PRIMARY KEY(`vendor_contact_id`)
) COMMENT 'Individual contact records for vendor organization representatives — including account managers, trafficking coordinators, billing contacts, technical integration leads, and executive sponsors. Captures contact name, role/title, email, phone, preferred communication channel, contact status (active/inactive), and agency-side relationship owner. Supports day-to-day operational communication and escalation paths. Managed in Salesforce CRM.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` (
    `preferred_vendor_list_id` BIGINT COMMENT 'Unique surrogate identifier for each preferred vendor list entry. Primary key for the preferred_vendor_list data product within the vendor domain.',
    `accreditation_id` BIGINT COMMENT 'Official TAG certification identifier issued by the Trustworthy Accountability Group. Used to verify vendor accreditation status in programmatic supply chain audits and brand safety compliance checks.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser/client for whom this PVL entry applies. Null if the entry is agency-wide (not client-specific). Enables enforcement of client-mandated vendor restrictions and preferred partner agreements.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: PVL entries often reference master service agreements that govern preferred vendor relationships. Procurement teams link PVL status to underlying MSAs, enforce MSA terms across campaigns, and trigger ',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor record in the vendor master. Identifies the third-party media vendor, publisher, technology partner (DSP, SSP, DMP, CDP), or production supplier designated on this PVL entry.',
    `vendor_rate_card_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_rate_card. Business justification: Preferred vendor list entries designate approved vendors by category and tier. The PVL already has a rate_card_id field referencing vendor.rate_card (likely a naming inconsistency - the actual product',
    `ads_txt_compliant` BOOLEAN COMMENT 'Indicates whether the vendor (publisher or SSP) is compliant with the IAB Tech Lab ads.txt standard for authorized digital sellers. Critical for programmatic buying fraud prevention and supply path optimization (SPO).',
    `approval_date` DATE COMMENT 'Date on which this vendor was formally approved and added to the preferred vendor list. Represents the effective start of the vendors PVL designation. Used in audit trails and compliance reporting.',
    `approval_status` STRING COMMENT 'Current lifecycle status of this PVL entry. active = currently approved for use; inactive = no longer in use but retained for history; suspended = temporarily blocked pending investigation; pending_approval = submitted for review but not yet approved; expired = review cycle lapsed without renewal.. Valid values are `active|inactive|suspended|pending_approval|expired`',
    `approving_stakeholder` STRING COMMENT 'Name or role of the internal stakeholder (e.g., Chief Procurement Officer, Group Media Director, Client Lead) who authorized this vendors inclusion on the PVL. Supports governance accountability and audit requirements.',
    `approving_stakeholder_email` STRING COMMENT 'Email address of the internal stakeholder who approved this PVL entry. Used for audit trail, escalation routing, and review cycle notifications. Classified confidential as it is an internal business contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `brand_safety_rating` STRING COMMENT 'Agency-assigned or third-party brand safety rating for the vendor. Reflects the vendors compliance with brand safety standards including content adjacency, fraud prevention, and viewability benchmarks. Informs media planner decisions.. Valid values are `gold|silver|bronze|unrated|failed`',
    `buying_method` STRING COMMENT 'Indicates the transactional method by which media is purchased from this vendor. Supports Mediaocean Prisma media plan configuration and The Trade Desk programmatic buying workflow alignment.. Valid values are `direct_io|programmatic_guaranteed|private_marketplace|open_rtb|preferred_deal`',
    `campaign_type_scope` STRING COMMENT 'Specifies the campaign type(s) for which this vendor designation applies (e.g., brand awareness, performance, direct response, ABM, retargeting). Null if applicable to all campaign types. Supports campaign strategy and planning alignment.',
    `ccpa_compliant` BOOLEAN COMMENT 'Indicates whether the vendor has confirmed CCPA compliance for handling California consumer data. Required for vendors involved in audience targeting, data management, or programmatic buying for US campaigns.',
    `channel_type` STRING COMMENT 'Media channel or advertising channel for which this vendor is designated on the PVL. Enables media planners to filter the PVL by channel when building media plans. Aligns with IAB channel taxonomy. [ENUM-REF-CANDIDATE: digital|tv|radio|print|ooh|dooh|ctv|social|search|programmatic — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PVL entry was first created in the system. Provides the audit trail creation anchor for the vendors PVL lifecycle. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the minimum spend commitment and any financial terms associated with this PVL entry (e.g., USD, GBP, EUR). Supports multi-currency agency operations.. Valid values are `^[A-Z]{3}$`',
    `data_processing_agreement_signed` BOOLEAN COMMENT 'Indicates whether a formal Data Processing Agreement has been executed with this vendor. Required under GDPR Article 28 for any vendor processing personal data on behalf of the agency or its clients.',
    `dpa_expiry_date` DATE COMMENT 'Date on which the vendors Data Processing Agreement expires and must be renewed. Null if the DPA is perpetual or not applicable. Triggers compliance renewal workflows.',
    `effective_from_date` DATE COMMENT 'Date from which this PVL entry is binding and the vendor designation is enforceable for media planning and buying. May differ from approval_date if a future-dated activation is configured.',
    `effective_until_date` DATE COMMENT 'Date on which this PVL entry expires and the vendor designation ceases to be enforceable. Null for open-ended designations. Triggers review cycle notifications when approaching expiry.',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the vendor has confirmed GDPR compliance through a signed Data Processing Agreement (DPA) or equivalent documentation. Mandatory for vendors processing EU audience data in digital campaigns.',
    `iab_member` BOOLEAN COMMENT 'Indicates whether the vendor is a current member of the IAB (Interactive Advertising Bureau). IAB membership signals adherence to industry standards for digital advertising, viewability, and data practices.',
    `minimum_spend_commitment` DECIMAL(18,2) COMMENT 'Contractually committed minimum annual or period spend with this vendor as part of the preferred partner agreement. Expressed in the agencys base currency. Used in budget management and financial reconciliation to track commitment utilization.',
    `mrc_accredited` BOOLEAN COMMENT 'Indicates whether the vendor holds current MRC (Media Rating Council) accreditation for audience measurement or ad verification services. Required for vendors providing viewability, brand safety, or audience measurement in agency-managed campaigns.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this PVL entry. Calculated from approval_date plus review_cycle_months. Used by procurement and account management teams to manage vendor governance calendars.',
    `onboarding_completed` BOOLEAN COMMENT 'Indicates whether the vendor has completed the agencys full onboarding process including legal, compliance, financial, and technical setup steps. Vendors must be fully onboarded before being activated on the PVL.',
    `onboarding_date` DATE COMMENT 'Date on which the vendor completed the agencys onboarding process. Used to track vendor lifecycle from initial engagement through active PVL status.',
    `preferred_partner_agreement` BOOLEAN COMMENT 'Indicates whether the agency has a formal preferred partner agreement (e.g., volume commitment, rebate arrangement, or strategic partnership MOU) with this vendor. Preferred partner agreements typically carry negotiated CPM/CPC rates and added-value commitments.',
    `pvl_entry_code` STRING COMMENT 'Human-readable, externally-known business identifier for this PVL entry (e.g., PVL-2024-0042). Used in agency communications, audit trails, and vendor onboarding correspondence.. Valid values are `^PVL-[A-Z0-9]{4,12}$`',
    `restriction_reason` STRING COMMENT 'Documented reason for a restricted or blacklisted vendor tier designation. Required when vendor_tier is restricted or blacklisted. Supports compliance audit trails and media planner guidance. Examples: brand safety incident, fraud detection, client conflict, regulatory non-compliance.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which this PVL entry must be formally reviewed and re-approved. Standard cycles are 6, 12, or 24 months depending on vendor tier and client requirements. Drives automated review reminders.',
    `scope_notes` STRING COMMENT 'Free-text field capturing any specific conditions, restrictions, or qualifications on the vendors PVL designation. Examples include geographic restrictions, format limitations, client-specific exclusions, or campaign type caveats not captured in structured fields.',
    `supply_chain_transparency_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) reflecting the vendors supply chain transparency rating based on ads.txt/sellers.json compliance, TAG certification, and programmatic path quality assessments. Supports programmatic operations and brand safety governance.',
    `tag_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds a current TAG (Trustworthy Accountability Group) certification (e.g., TAG Certified Against Fraud, TAG Brand Safety Certified). Critical for brand safety compliance and programmatic buying governance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this PVL entry. Used for change tracking, data lineage, and incremental ETL processing in the Databricks Lakehouse Silver Layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vendor_category` STRING COMMENT 'Primary business category classifying the vendors service type (e.g., publisher, DSP, SSP, DMP, CDP, OOH provider, CTV/OTT network, production house, research firm, PR agency). Drives media planning filter logic and category-level spend reporting. [ENUM-REF-CANDIDATE: publisher|dsp|ssp|dmp|cdp|ooh_provider|ctv_ott|production|research|pr_agency|data_provider|creative_tech — promote to reference product]',
    `vendor_tier` STRING COMMENT 'Agency-assigned designation indicating the vendors standing on the preferred vendor list. preferred = actively recommended partner with negotiated rates; approved = cleared for use without special authorization; restricted = requires client or management sign-off before use; blacklisted = prohibited from use; under_review = pending re-evaluation.. Valid values are `preferred|approved|restricted|blacklisted|under_review`',
    CONSTRAINT pk_preferred_vendor_list PRIMARY KEY(`preferred_vendor_list_id`)
) COMMENT 'Agency-maintained preferred vendor list (PVL) designating approved and preferred vendors by category, channel, client, or campaign type. Captures vendor tier (preferred, approved, restricted, blacklisted), approval date, approving stakeholder, applicable client or campaign scope, and review cycle. Enables media planners to enforce client-mandated vendor restrictions and agency-wide preferred partner agreements.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`performance_evaluation` (
    `performance_evaluation_id` BIGINT COMMENT 'Unique system-generated identifier for each vendor performance evaluation record. Primary key for the performance_evaluation product.',
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: Vendor performance evaluations are conducted in context of specific agency-client relationships. Vendor scorecards vary by client account due to different SLAs, rate cards, and service expectations. L',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Vendor performance evaluations are often scoped to specific projects they supported, assessing delivery, quality, and responsiveness within project context. Enables project-based vendor scorecarding a',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Performance evaluations assess vendor delivery against SOW scope, deliverables, and SLA targets. Account teams score vendors on SOW fulfillment rates, link evaluation outcomes to SOW renewal decisions',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor being evaluated. Links to the vendor master record in the vendor domain.',
    `vendor_contract_id` BIGINT COMMENT 'Reference to the governing contract or master service agreement under which this vendor is being evaluated.',
    `actual_delivered_units` BIGINT COMMENT 'Total number of impressions, clicks, or deliverable units actually delivered by the vendor during the evaluation period as recorded in the ad server (e.g., Google Campaign Manager 360). Numerator for delivery fulfillment rate calculation.',
    `approved_by` STRING COMMENT 'Name or identifier of the senior stakeholder (e.g., VP of Media, Chief Procurement Officer) who formally approved this vendor performance evaluation and its resulting tier assignment and renewal recommendation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor performance evaluation was formally approved by the designated approver. Distinct lifecycle event from evaluation completion.',
    `brand_safety_incident_count` STRING COMMENT 'Number of brand safety incidents recorded against the vendor during the evaluation period, including ad placements adjacent to harmful, inappropriate, or non-brand-safe content. Critical metric for TAG (Trustworthy Accountability Group) compliance and preferred vendor list eligibility.',
    `brand_safety_incident_severity` STRING COMMENT 'Highest severity level of brand safety incidents recorded against the vendor during the evaluation period. Aligned to GARM (Global Alliance for Responsible Media) brand safety floor and suitability framework tiers.. Valid values are `none|low|medium|high|critical`',
    `contract_renewal_recommendation` STRING COMMENT 'Formal recommendation for contract renewal action based on the outcome of this performance evaluation. Feeds directly into the contract management workflow and vendor relationship strategy decisions.. Valid values are `renew|renew_with_conditions|renegotiate|do_not_renew`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor performance evaluation record was first created in the system. Audit trail field for data lineage and governance purposes.',
    `delivery_fulfillment_rate` DECIMAL(18,2) COMMENT 'Percentage of Insertion Order (IO) committed impressions, units, or deliverables that were actually fulfilled by the vendor during the evaluation period. Calculated as (actual_delivered / io_committed) * 100. Core KPI for media vendor accountability.',
    `disputed_invoices_count` STRING COMMENT 'Number of invoices submitted by the vendor during the evaluation period that required dispute resolution, credit notes, or correction due to billing inaccuracies. Feeds into invoice accuracy rate and financial risk assessment.',
    `evaluation_cycle` STRING COMMENT 'The fiscal quarter in which this evaluation was conducted, aligned to the QBR (Quarterly Business Review) cycle. Used to track cadence and trend analysis across periods.. Valid values are `Q1|Q2|Q3|Q4`',
    `evaluation_date` DATE COMMENT 'The principal business date on which the formal vendor performance evaluation was conducted or finalized, typically the QBR session date.',
    `evaluation_notes` STRING COMMENT 'Free-text qualitative commentary from the evaluator capturing context, mitigating factors, notable incidents, or strategic observations not captured in the quantitative scorecard metrics. Used in QBR presentations and vendor relationship management.',
    `evaluation_number` STRING COMMENT 'Externally-visible business identifier for this evaluation record, used in QBR documentation, vendor communications, and preferred vendor list reviews. Format: VPE-{YEAR}-{SEQUENCE}.. Valid values are `^VPE-[0-9]{4}-[0-9]{6}$`',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance measurement period covered by this evaluation, typically aligned to the quarterly QBR cycle (e.g., last day of the quarter).',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance measurement period covered by this evaluation, typically aligned to the quarterly QBR cycle (e.g., first day of the quarter).',
    `evaluation_status` STRING COMMENT 'Current lifecycle state of the vendor performance evaluation record. Draft indicates data collection in progress; in_review indicates pending stakeholder sign-off; completed indicates finalized; approved indicates accepted by vendor management; disputed indicates vendor has raised a formal objection.. Valid values are `draft|in_review|completed|approved|disputed`',
    `evaluation_year` STRING COMMENT 'The fiscal year in which this evaluation was conducted. Combined with evaluation_cycle to uniquely identify the QBR period for trend and year-over-year comparison.',
    `evaluator_name` STRING COMMENT 'Name of the internal agency staff member or team lead responsible for conducting and submitting this vendor performance evaluation, typically the media buyer, account director, or vendor management lead.',
    `invalid_traffic_rate` DECIMAL(18,2) COMMENT 'Percentage of impressions delivered by the vendor during the evaluation period classified as invalid traffic (IVT) including general invalid traffic (GIVT) and sophisticated invalid traffic (SIVT) per MRC and TAG standards. Critical for fraud prevention and supply chain transparency.',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of vendor invoices submitted during the evaluation period that matched the reconciled billing amounts within the agreed tolerance threshold, without requiring correction or credit notes. Calculated as (accurate_invoices / total_invoices) * 100. Sourced from Mediaocean Prisma reconciliation data.',
    `io_committed_units` BIGINT COMMENT 'Total number of impressions, clicks, or deliverable units committed by the vendor across all active Insertion Orders (IOs) during the evaluation period. Denominator for delivery fulfillment rate calculation.',
    `makegood_fulfilled_count` STRING COMMENT 'Number of make-good obligations that were successfully fulfilled by the vendor during the evaluation period. Compared against makegood_obligation_count to assess vendor responsiveness to under-delivery.',
    `makegood_obligation_count` STRING COMMENT 'Number of make-good obligations raised against the vendor during the evaluation period due to under-delivery against IO commitments. A make-good is compensatory inventory provided by the vendor to offset shortfalls.',
    `mrc_accreditation_status` STRING COMMENT 'Current MRC (Media Rating Council) accreditation status of the vendor at the time of evaluation. MRC accreditation validates the vendors measurement methodologies and is required for audience measurement and impression counting credibility.. Valid values are `accredited|not_accredited|pending|suspended`',
    `overall_scorecard_rating` DECIMAL(18,2) COMMENT 'Composite weighted scorecard rating for the vendor for the evaluation period, typically on a scale of 0.00 to 10.00 or 0.00 to 100.00. Aggregates delivery fulfillment, invoice accuracy, SLA adherence, brand safety, and viewability dimensions into a single performance score used for preferred vendor list tier assignment.',
    `preferred_vendor_tier` STRING COMMENT 'Preferred vendor list tier assignment resulting from this evaluation. Tier 1 indicates top-performing strategic partners; Tier 2 indicates approved vendors; Tier 3 indicates conditional approval; Probation indicates performance improvement required; Disqualified indicates removal from preferred vendor list.. Valid values are `tier_1|tier_2|tier_3|probation|disqualified`',
    `prior_preferred_vendor_tier` STRING COMMENT 'The vendors preferred vendor list tier from the immediately preceding evaluation period. Used to track tier movement (promotion or demotion) resulting from this evaluation cycle.. Valid values are `tier_1|tier_2|tier_3|probation|disqualified`',
    `prior_scorecard_rating` DECIMAL(18,2) COMMENT 'The vendors overall scorecard rating from the immediately preceding evaluation period. Enables quarter-over-quarter trend analysis and identification of improving or declining vendor performance trajectories.',
    `response_time_sla_adherence_rate` DECIMAL(18,2) COMMENT 'Percentage of vendor response obligations (e.g., campaign issue resolution, data discrepancy responses, creative trafficking requests) fulfilled within the contractually agreed SLA response time during the evaluation period.',
    `scorecard_rating_scale` STRING COMMENT 'The numeric scale used for the overall_scorecard_rating in this evaluation (e.g., 0-10, 0-100, 1-5). Ensures correct interpretation of the rating value across different evaluation frameworks or vendor categories.. Valid values are `0-10|0-100|1-5`',
    `sla_breaches_count` STRING COMMENT 'Number of SLA response obligations that were not fulfilled within the contractually agreed timeframe during the evaluation period. Used to identify chronic SLA non-compliance patterns.',
    `sla_incidents_total` STRING COMMENT 'Total number of SLA-governed response obligations raised against the vendor during the evaluation period. Denominator for response_time_sla_adherence_rate calculation.',
    `tag_certification_status` STRING COMMENT 'Current TAG (Trustworthy Accountability Group) certification status of the vendor at the time of evaluation. TAG certification is a prerequisite for preferred vendor list tier 1 eligibility and indicates compliance with anti-fraud, brand safety, and supply chain transparency standards.. Valid values are `certified|not_certified|pending|expired`',
    `total_invoices_submitted` STRING COMMENT 'Total number of invoices submitted by the vendor during the evaluation period. Denominator for invoice accuracy rate calculation. Sourced from Mediaocean Prisma billing records.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor performance evaluation record was last modified. Audit trail field for change tracking and data lineage in the Databricks Silver Layer.',
    `vendor_category` STRING COMMENT 'Classification of the vendor type being evaluated. Determines which performance dimensions and benchmarks are applicable. [ENUM-REF-CANDIDATE: media_publisher|dsp|ssp|dmp|cdp|production_supplier|technology_partner|research_vendor — promote to reference product]',
    `vendor_dispute_flag` BOOLEAN COMMENT 'Indicates whether the vendor has formally disputed the findings of this performance evaluation. When True, the evaluation status should reflect disputed and a resolution process must be initiated.',
    `vendor_dispute_notes` STRING COMMENT 'Free-text notes capturing the vendors formal objection or dispute rationale when vendor_dispute_flag is True. Documents the basis of the dispute for audit trail and resolution tracking purposes.',
    `viewability_rate` DECIMAL(18,2) COMMENT 'Percentage of impressions delivered by the vendor during the evaluation period that met the MRC (Media Rating Council) viewability standard (50% of pixels in view for 1 continuous second for display; 50% for 2 seconds for video). Key quality metric for media vendor evaluation.',
    CONSTRAINT pk_performance_evaluation PRIMARY KEY(`performance_evaluation_id`)
) COMMENT 'Periodic vendor performance evaluation records capturing delivery fulfillment rate against IO commitments, make-good obligations, invoice accuracy rate, response time SLA adherence, brand safety incident count, and overall vendor scorecard rating. Evaluated quarterly (QBR cycle) and used to inform preferred vendor list tier assignments and contract renewal decisions. Operational records — not aggregated analytics.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for the vendor risk assessment record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client who mandated this risk assessment, if applicable.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Risk assessments may be conducted for vendors engaged on high-value or sensitive projects/initiatives. Linking assessment to initiative enables project-specific vendor risk management, compliance trac',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor being assessed. Links to the vendor master record.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Risk assessments inform vendor contract terms (liability caps, insurance requirements, SLA penalties). Legal and procurement teams reference risk scores when negotiating contract clauses, set contract',
    `prior_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on risk_assessment (prior_risk_assessment_id)',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the risk assessment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the risk assessment was formally approved.',
    `assessment_date` DATE COMMENT 'Date when the risk assessment was conducted or completed.',
    `assessment_number` STRING COMMENT 'Business-facing unique identifier for the risk assessment, used in communications and reporting.. Valid values are `^RA-[0-9]{6,10}$`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment record.. Valid values are `draft|in_review|approved|rejected|expired`',
    `assessment_type` STRING COMMENT 'Classification of the assessment based on the trigger or purpose (initial onboarding, annual refresh, triggered by incident, ad-hoc review, or client-mandated due diligence).. Valid values are `initial|annual_refresh|triggered|ad_hoc|client_mandated`',
    `assessor_name` STRING COMMENT 'Name of the individual or team who conducted the risk assessment.',
    `brand_safety_risk` STRING COMMENT 'Assessment of risk related to brand safety incidents, including ad placement near inappropriate content, fraud, or reputational damage.. Valid values are `low|medium|high|critical`',
    `business_continuity_plan_verified` BOOLEAN COMMENT 'Indicates whether the vendors business continuity plan has been reviewed and verified as adequate.',
    `business_continuity_risk` STRING COMMENT 'Assessment of risk related to the vendors ability to maintain operations during disruptions, including disaster recovery and business continuity planning.. Valid values are `low|medium|high|critical`',
    `ccpa_compliance_status` STRING COMMENT 'Assessment of the vendors compliance with CCPA requirements for consumer data privacy.. Valid values are `compliant|partially_compliant|non_compliant|not_applicable`',
    `ccpa_risk_level` STRING COMMENT 'Risk level associated with the vendors CCPA compliance posture and consumer data handling practices.. Valid values are `low|medium|high|critical`',
    `client_mandated_flag` BOOLEAN COMMENT 'Indicates whether this risk assessment was mandated by a specific client as part of their vendor due diligence requirements.',
    `concentration_risk` STRING COMMENT 'Risk level associated with revenue dependency on this vendor, assessing the impact if the vendor relationship were to terminate.. Valid values are `low|medium|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this risk assessment record was first created in the system.',
    `data_breach_count` STRING COMMENT 'Number of documented data breaches or significant security incidents involving the vendor in the assessment period.',
    `data_breach_history_flag` BOOLEAN COMMENT 'Indicates whether the vendor has a documented history of data breaches or security incidents.',
    `data_security_posture` STRING COMMENT 'Overall assessment of the vendors data security capabilities, controls, and practices.. Valid values are `excellent|good|adequate|needs_improvement|poor`',
    `effective_from_date` DATE COMMENT 'Date from which this risk assessment is considered valid and applicable.',
    `expiry_date` DATE COMMENT 'Date when this risk assessment expires and requires refresh or renewal.',
    `financial_risk_score` DECIMAL(18,2) COMMENT 'Numeric score representing the financial risk level of the vendor, typically on a scale of 0-100 where higher values indicate higher risk.',
    `financial_stability_rating` STRING COMMENT 'Credit or financial health rating of the vendor, indicating their ability to continue operations and fulfill contractual obligations. Ratings follow standard credit rating scale. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — 10 candidates stripped; promote to reference product]',
    `gdpr_compliance_status` STRING COMMENT 'Assessment of the vendors compliance with GDPR requirements for data processing and privacy.. Valid values are `compliant|partially_compliant|non_compliant|not_applicable`',
    `gdpr_risk_level` STRING COMMENT 'Risk level associated with the vendors GDPR compliance posture and data processing activities.. Valid values are `low|medium|high|critical`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total amount of insurance coverage held by the vendor, typically in USD.',
    `insurance_coverage_verified` BOOLEAN COMMENT 'Indicates whether the vendors insurance coverage (general liability, professional indemnity, cyber liability) has been verified and meets requirements.',
    `insurance_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the insurance coverage amount.. Valid values are `^[A-Z]{3}$`',
    `iso27001_certificate_expiry_date` DATE COMMENT 'Expiration date of the vendors ISO 27001 certification.',
    `iso27001_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds ISO 27001 certification for information security management systems.',
    `mrc_accredited` BOOLEAN COMMENT 'Indicates whether the vendor is accredited by the Media Rating Council for audience measurement and reporting standards.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of vendor risk, typically annual.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, observations, or recommendations from the risk assessment process.',
    `overall_risk_rating` STRING COMMENT 'Composite risk rating summarizing all risk dimensions (financial, security, compliance, continuity, concentration) into a single overall assessment.. Valid values are `low|medium|high|critical`',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Numeric composite risk score aggregating all risk dimensions, typically on a scale of 0-100 where higher values indicate higher risk.',
    `revenue_dependency_pct` DECIMAL(18,2) COMMENT 'Percentage of agency revenue that is dependent on or flows through this vendor, used to assess concentration risk.',
    `soc2_compliant` BOOLEAN COMMENT 'Indicates whether the vendor has achieved SOC 2 Type II compliance, demonstrating controls for security, availability, processing integrity, confidentiality, and privacy.',
    `soc2_report_date` DATE COMMENT 'Date of the most recent SOC 2 audit report received from the vendor.',
    `tag_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds TAG certification against fraud, malware, and piracy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this risk assessment record was last modified.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Vendor risk assessment record capturing financial stability rating, data security posture (SOC 2, ISO 27001 compliance), GDPR/CCPA data processing risk level, business continuity risk, concentration risk (revenue dependency), and insurance coverage verification. Evaluated during onboarding and refreshed annually. Supports client-mandated vendor due diligence requirements and agency risk management policies.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` (
    `supply_chain_profile_id` BIGINT COMMENT 'Unique identifier for the supply chain profile record. Primary key.',
    `accreditation_id` BIGINT COMMENT 'Unique certification identifier issued by TAG for fraud prevention and brand safety compliance.',
    `publisher_id` BIGINT COMMENT 'Foreign key linking to vendor.publisher. Business justification: Supply chain profiles assess publisher-specific supply path quality, transparency, and fraud risk. Media buyers review publisher supply chain profiles before authorizing IOs. Profile.supplier_id links',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or technology partner this supply chain profile belongs to.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Supply chain profiles (SPO tier, ads.txt verification, brand safety ratings) inform vendor contract approval and terms. Procurement teams enforce supply chain transparency requirements in contracts, l',
    `superseded_supply_chain_profile_id` BIGINT COMMENT 'Self-referencing FK on supply_chain_profile (superseded_supply_chain_profile_id)',
    `ads_txt_authorized` BOOLEAN COMMENT 'Indicates whether the vendor is authorized in relevant publisher ads.txt files for inventory authenticity.',
    `approved_by` STRING COMMENT 'Name or identifier of the stakeholder who approved the supply chain profile and vendor classification.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the supply chain profile was officially approved.',
    `assessment_date` DATE COMMENT 'Date when the supply chain transparency and brand safety assessment was conducted.',
    `assessment_version` STRING COMMENT 'Version number of this supply chain profile assessment, used for tracking updates and revisions.',
    `assessor_name` STRING COMMENT 'Name of the individual or team responsible for conducting the supply chain profile assessment.',
    `average_viewability_rate` DECIMAL(18,2) COMMENT 'Average percentage of viewable impressions delivered by the vendor, measured per MRC standards.',
    `brand_safety_tier` STRING COMMENT 'Overall brand safety classification tier based on content adjacency risk, verification scores, and compliance history.. Valid values are `premium|standard|monitored|high_risk|excluded`',
    `brand_safety_verification_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) representing the vendors brand safety verification performance and compliance level.',
    `ccpa_compliant` BOOLEAN COMMENT 'Indicates whether the vendors supply chain practices comply with CCPA consumer privacy requirements.',
    `content_adjacency_risk_rating` STRING COMMENT 'Risk rating for potential brand-unsafe content adjacency based on inventory quality and content categorization.. Valid values are `low|medium|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the supply chain profile record was first created in the system.',
    `critical_incident_count` STRING COMMENT 'Number of critical-severity brand safety or fraud incidents that resulted in immediate action or vendor suspension.',
    `data_residency_region` STRING COMMENT 'Geographic region where the vendor stores and processes advertising data, relevant for data sovereignty compliance.',
    `exclusion_reason` STRING COMMENT 'Detailed explanation if the vendor is excluded or restricted from preferred status due to supply chain or brand safety concerns.',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the vendors supply chain practices comply with GDPR data protection requirements.',
    `incident_count` STRING COMMENT 'Total number of brand safety or supply chain transparency incidents recorded for this vendor during the assessment period.',
    `intermediary_count` STRING COMMENT 'Number of intermediary hops in the programmatic supply chain between the advertiser and the publisher.',
    `invalid_traffic_rate` DECIMAL(18,2) COMMENT 'Percentage of invalid traffic detected in the vendors supply, measured against MRC standards for ad fraud prevention.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supply chain transparency and brand safety audit conducted for this vendor.',
    `mrc_accredited` BOOLEAN COMMENT 'Indicates whether the vendor holds active MRC accreditation for measurement and audience verification.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next supply chain profile review and reassessment.',
    `notes` STRING COMMENT 'Additional notes, observations, or context regarding the vendors supply chain transparency and brand safety assessment.',
    `preferred_vendor_status` STRING COMMENT 'Vendors status on the agencys preferred vendor list based on supply chain transparency and brand safety performance.. Valid values are `preferred|approved|conditional|excluded|under_review`',
    `profile_reference_number` STRING COMMENT 'Business-readable unique reference number for this supply chain profile assessment.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the supply chain profile assessment.. Valid values are `active|under_review|suspended|approved|rejected|expired`',
    `review_cycle_months` STRING COMMENT 'Number of months between scheduled supply chain profile reviews based on vendor tier and risk level.',
    `sellers_json_url` STRING COMMENT 'URL to the vendors published sellers.json file for programmatic supply chain transparency.',
    `sellers_json_verified` BOOLEAN COMMENT 'Indicates whether the vendor has a verified sellers.json file published per IAB Tech Lab standards for supply chain transparency.',
    `spo_documentation_url` STRING COMMENT 'URL reference to the vendors supply path optimization documentation and transparency disclosures.',
    `supply_chain_documentation_complete` BOOLEAN COMMENT 'Indicates whether the vendor has provided complete supply chain documentation including all intermediaries and fee structures.',
    `supply_chain_transparency_score` DECIMAL(18,2) COMMENT 'Composite score (0-100) measuring the vendors overall supply chain transparency, documentation completeness, and disclosure quality.',
    `supply_path_optimization_tier` STRING COMMENT 'Classification tier for programmatic supply path optimization indicating the vendors preferred routing status in the supply chain.. Valid values are `tier_1_direct|tier_2_preferred|tier_3_standard|tier_4_restricted|not_classified`',
    `tag_certified_against_fraud` BOOLEAN COMMENT 'Indicates whether the vendor holds active TAG certification for anti-fraud and invalid traffic prevention.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the supply chain profile record was last modified.',
    `viewability_standard_met` BOOLEAN COMMENT 'Indicates whether the vendor meets MRC viewability standards for display and video ad impressions.',
    CONSTRAINT pk_supply_chain_profile PRIMARY KEY(`supply_chain_profile_id`)
) COMMENT 'Vendor-level supply chain transparency and brand safety assessment record — capturing programmatic supply path documentation (SPO), content adjacency risk ratings, verification scores, and preferred/excluded status.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`supply_path_record` (
    `supply_path_record_id` BIGINT COMMENT 'Unique identifier for the supply path transparency record. Primary key for programmatic supply chain tracking.',
    `accreditation_id` BIGINT COMMENT 'The TAG certification identifier as declared in ads.txt, providing third-party verification of anti-fraud and brand safety measures.',
    `publisher_account_publisher_id` BIGINT COMMENT 'The publishers account identifier within the SSPs system, as declared in ads.txt, used to uniquely identify the business relationship.',
    `publisher_id` BIGINT COMMENT 'Reference to the publisher entity whose supply path is being documented.',
    `seller_publisher_id` BIGINT COMMENT 'The unique seller identifier as declared in the SSPs sellers.json file, used to match publisher relationships across the supply chain.',
    `ssp_platform_id` BIGINT COMMENT 'Reference to the SSP or exchange through which inventory is made available for programmatic buying.',
    `upstream_supply_path_record_id` BIGINT COMMENT 'Self-referencing FK on supply_path_record (upstream_supply_path_record_id)',
    `ads_txt_entry` STRING COMMENT 'The complete ads.txt entry line from the publishers ads.txt file that authorizes this supply path, including domain, publisher ID, relationship type, and TAG ID.',
    `ads_txt_verification_date` DATE COMMENT 'Date when the ads.txt file was last verified for this supply path, ensuring current authorization status.',
    `ads_txt_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the supply path has been verified against the publishers ads.txt file and the declaration is valid.',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved this supply path for inclusion in the preferred vendor list or SPO strategy.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply path record was approved for use in programmatic buying operations.',
    `authorized_seller_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the SSP is explicitly authorized to sell the publishers inventory as declared in the publishers ads.txt file.',
    `brand_safety_tier` STRING COMMENT 'Brand safety tier assigned to this supply path based on content adjacency risk, verification status, and historical incident data.. Valid values are `tier_1_premium|tier_2_standard|tier_3_monitored|tier_4_restricted|unrated`',
    `brand_safety_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the supply path has passed brand safety verification checks and meets advertiser safety requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply path record was first created in the system, used for audit trail and data lineage.',
    `critical_incident_count` STRING COMMENT 'Number of critical severity incidents (major brand safety violations, fraud, or compliance breaches) recorded for this supply path.',
    `effective_from_date` DATE COMMENT 'Date from which this supply path authorization became effective and valid for programmatic transactions.',
    `effective_until_date` DATE COMMENT 'Date until which this supply path authorization remains valid. Null indicates no expiration date.',
    `exclusion_reason` STRING COMMENT 'Reason for exclusion or restriction of this supply path from programmatic buying, if applicable. Null if path is approved.',
    `incident_count` STRING COMMENT 'Total number of brand safety, fraud, or compliance incidents recorded for this supply path since inception.',
    `intermediary_count` STRING COMMENT 'Number of intermediaries in the supply path between the publisher and the DSP, used for supply path optimization and cost analysis.',
    `invalid_traffic_rate` DECIMAL(18,2) COMMENT 'Percentage of invalid traffic detected on this supply path based on TAG and MRC measurement standards. Lower rates indicate higher quality.',
    `last_verification_date` DATE COMMENT 'Date when the supply path was last verified for ads.txt, sellers.json, and brand safety compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and verification of this supply path record to ensure continued compliance and authorization.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special conditions, or operational guidance related to this supply path.',
    `record_reference_number` STRING COMMENT 'Business-facing unique reference number for this supply path transparency record, used for auditing and reconciliation.',
    `record_status` STRING COMMENT 'Current lifecycle status of the supply path record indicating whether the path is currently valid and authorized for programmatic transactions.. Valid values are `active|inactive|suspended|under_review|expired|revoked`',
    `review_cycle_months` STRING COMMENT 'Number of months between scheduled reviews of this supply path, based on tier classification and risk assessment.',
    `seller_domain` STRING COMMENT 'The sellers domain as declared in the SSPs sellers.json file, used for cross-verification with ads.txt declarations.',
    `seller_name` STRING COMMENT 'The seller name as declared in the SSPs sellers.json file, providing human-readable identification of the publisher or intermediary.',
    `seller_type` STRING COMMENT 'Classification indicating whether the SSP has a direct relationship with the publisher or is acting as a reseller, as declared in ads.txt and sellers.json.. Valid values are `direct|reseller|both`',
    `sellers_json_verification_date` DATE COMMENT 'Date when the sellers.json file was last verified for this supply path, ensuring transparency compliance.',
    `sellers_json_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the SSPs sellers.json file has been verified and contains a valid entry for this publisher relationship.',
    `spo_tier` STRING COMMENT 'Tiered classification of the supply path based on quality, transparency, and performance metrics, used for programmatic buying prioritization.. Valid values are `tier_1_preferred|tier_2_approved|tier_3_standard|tier_4_restricted|unclassified`',
    `ssp_domain` STRING COMMENT 'The domain of the SSP or exchange as declared in ads.txt, used for supply path identification and verification.',
    `supply_path_quality_score` DECIMAL(18,2) COMMENT 'Calculated quality score for this supply path based on transparency, verification status, intermediary count, and brand safety compliance. Scale 0.00 to 100.00.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply path record was last modified, used for change tracking and audit purposes.',
    `viewability_rate` DECIMAL(18,2) COMMENT 'Average viewability rate for impressions served through this supply path, measured according to MRC viewability standards.',
    CONSTRAINT pk_supply_path_record PRIMARY KEY(`supply_path_record_id`)
) COMMENT 'Programmatic supply chain transparency record capturing ads.txt, sellers.json, and supply path optimization (SPO) data for each publisher and SSP — including authorized seller declarations, seller types (direct/reseller), and supply path quality scores.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`platform_activation` (
    `platform_activation_id` BIGINT COMMENT 'Unique surrogate identifier for this platform activation record. Primary key.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to the agency project or initiative for which the tech platform is being activated',
    `worker_id` BIGINT COMMENT 'Reference to the employee (typically technical lead or project manager) responsible for managing this platform integration within the initiative. Supports accountability and operational ownership.',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to the advertising technology platform partner being activated for this initiative',
    `activation_date` DATE COMMENT 'Date when the tech platform was activated and made operational for this initiative. Marks the start of platform usage for this project.',
    `api_credentials_ref` STRING COMMENT 'Reference identifier or vault key for project-specific API credentials used to integrate with this tech platform. Supports secure credential management per initiative.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this platform activation record was first created in the system.',
    `deactivation_date` DATE COMMENT 'Date when the tech platform was deactivated or integration was terminated for this initiative. Null if still active. Supports historical tracking of platform usage across project lifecycle.',
    `integration_scope` STRING COMMENT 'Defines the scope of platform integration for this specific initiative (e.g., full programmatic integration, limited pilot, measurement only, data sharing only). Varies by project needs and budget.',
    `integration_status` STRING COMMENT 'Current operational status of the platform integration for this initiative. Tracks integration health and readiness from a project delivery perspective.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent data synchronization or API call between the initiatives systems and this tech platform. Used for monitoring integration health.',
    `platform_fee_allocated` DECIMAL(18,2) COMMENT 'Portion of the tech partners platform fee allocated to this specific initiative, denominated in the projects budget currency. Used for project cost accounting and budget tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this platform activation record.',
    `usage_volume` DECIMAL(18,2) COMMENT 'Quantitative measure of platform usage for this initiative (e.g., impressions served, data records processed, API calls made). Unit of measure depends on platform type and billing model.',
    CONSTRAINT pk_platform_activation PRIMARY KEY(`platform_activation_id`)
) COMMENT 'This association product represents the activation and integration of advertising technology platforms (DSPs, DMPs, ad servers, analytics tools) within specific agency projects or initiatives. It captures project-specific integration scope, activation timeline, allocated platform fees, usage metrics, and integration health status. Each record links one tech partner platform to one initiative with attributes that exist only in the context of this project-specific activation.. Existence Justification: In advertising agency operations, tech platforms (DSPs, DMPs, ad servers, analytics tools) are activated for multiple initiatives based on project needs, and initiatives routinely use multiple tech platforms as part of their integrated tech stack. Platform activations are actively managed by project teams with project-specific integration scope, activation timelines, allocated costs, and usage tracking. This is an operational M:N relationship that the business recognizes and manages as platform activation or tech stack assignment.';

CREATE OR REPLACE TABLE `advertising_ecm`.`vendor`.`invoice_dispute` (
    `invoice_dispute_id` BIGINT COMMENT 'Primary key for invoice_dispute',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice being disputed.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor whose invoice is being disputed.',
    `escalated_from_invoice_dispute_id` BIGINT COMMENT 'Self-referencing FK on invoice_dispute (escalated_from_invoice_dispute_id)',
    `actual_resolution_date` DATE COMMENT 'The actual date when the dispute was resolved and closed.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The net adjustment applied to the invoice as a result of the dispute resolution. Positive for credits, negative for additional charges.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The amount approved for payment after dispute resolution. May differ from disputed amount.',
    `assigned_to` STRING COMMENT 'Name or identifier of the person or team currently responsible for resolving the dispute.',
    `compliance_flag` BOOLEAN COMMENT 'Flag indicating whether the dispute involves a compliance or regulatory issue requiring special handling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this dispute record was first created in the system.',
    `credit_memo_number` STRING COMMENT 'Reference number of the credit memo issued as part of the dispute resolution, if applicable.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this dispute.',
    `dispute_category` STRING COMMENT 'Secondary classification providing additional context for the dispute reason.',
    `dispute_number` STRING COMMENT 'Externally-known unique business identifier for the dispute, formatted as DSP-NNNNNNNN.',
    `dispute_opened_date` DATE COMMENT 'The date when the dispute was formally opened and logged in the system.',
    `dispute_opened_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the dispute was formally opened, representing the principal business event time.',
    `dispute_reason` STRING COMMENT 'Detailed explanation of why the invoice is being disputed, provided by the initiating party.',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute in the resolution workflow.',
    `dispute_type` STRING COMMENT 'Classification of the dispute based on the nature of the disagreement.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The monetary value being contested in the dispute. Expressed in the invoice currency.',
    `escalated_to` STRING COMMENT 'Name or identifier of the senior manager or executive to whom the dispute has been escalated.',
    `escalation_date` DATE COMMENT 'The date when the dispute was escalated to a higher authority level.',
    `escalation_level` STRING COMMENT 'The current escalation tier of the dispute. 0 = no escalation, higher numbers indicate progressive escalation to senior management.',
    `impact_on_vendor_rating` STRING COMMENT 'Assessment of how this dispute impacts the vendors performance rating or accreditation status.',
    `initiated_by` STRING COMMENT 'Name or identifier of the person or department who initiated the dispute.',
    `is_recurring_issue` BOOLEAN COMMENT 'Flag indicating whether this dispute is part of a recurring pattern with the same vendor or invoice type.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this dispute record was last updated or modified.',
    `priority_level` STRING COMMENT 'Business priority assigned to the dispute based on urgency and financial impact.',
    `resolution_method` STRING COMMENT 'The method or approach used to resolve the dispute.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution outcome, actions taken, and final agreement.',
    `resolution_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the dispute was resolved and status changed to resolved or closed.',
    `supporting_documentation` STRING COMMENT 'References or links to supporting documents, contracts, purchase orders, or evidence submitted with the dispute.',
    `target_resolution_date` DATE COMMENT 'The target date by which the dispute should be resolved based on service level agreements (SLAs) or business policies.',
    CONSTRAINT pk_invoice_dispute PRIMARY KEY(`invoice_dispute_id`)
) COMMENT 'Master reference table for invoice_dispute. Referenced by dispute_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ADD CONSTRAINT `fk_vendor_publisher_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `advertising_ecm`.`vendor`.`accreditation`(`accreditation_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ADD CONSTRAINT `fk_vendor_publisher_parent_publisher_id` FOREIGN KEY (`parent_publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ADD CONSTRAINT `fk_vendor_publisher_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ADD CONSTRAINT `fk_vendor_tech_partner_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `advertising_ecm`.`vendor`.`accreditation`(`accreditation_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ADD CONSTRAINT `fk_vendor_tech_partner_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ADD CONSTRAINT `fk_vendor_accreditation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ADD CONSTRAINT `fk_vendor_vendor_rate_card_source_system_rate_card_vendor_rate_card_id` FOREIGN KEY (`source_system_rate_card_vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ADD CONSTRAINT `fk_vendor_vendor_rate_card_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ADD CONSTRAINT `fk_vendor_vendor_onboarding_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `advertising_ecm`.`vendor`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ADD CONSTRAINT `fk_vendor_vendor_onboarding_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ADD CONSTRAINT `fk_vendor_io_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `advertising_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_io_line_id` FOREIGN KEY (`io_line_id`) REFERENCES `advertising_ecm`.`vendor`.`io_line`(`io_line_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ADD CONSTRAINT `fk_vendor_reconciliation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ADD CONSTRAINT `fk_vendor_vendor_contact_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ADD CONSTRAINT `fk_vendor_preferred_vendor_list_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `advertising_ecm`.`vendor`.`accreditation`(`accreditation_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ADD CONSTRAINT `fk_vendor_preferred_vendor_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ADD CONSTRAINT `fk_vendor_preferred_vendor_list_vendor_rate_card_id` FOREIGN KEY (`vendor_rate_card_id`) REFERENCES `advertising_ecm`.`vendor`.`vendor_rate_card`(`vendor_rate_card_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ADD CONSTRAINT `fk_vendor_performance_evaluation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ADD CONSTRAINT `fk_vendor_risk_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ADD CONSTRAINT `fk_vendor_risk_assessment_prior_risk_assessment_id` FOREIGN KEY (`prior_risk_assessment_id`) REFERENCES `advertising_ecm`.`vendor`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ADD CONSTRAINT `fk_vendor_supply_chain_profile_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `advertising_ecm`.`vendor`.`accreditation`(`accreditation_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ADD CONSTRAINT `fk_vendor_supply_chain_profile_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ADD CONSTRAINT `fk_vendor_supply_chain_profile_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ADD CONSTRAINT `fk_vendor_supply_chain_profile_superseded_supply_chain_profile_id` FOREIGN KEY (`superseded_supply_chain_profile_id`) REFERENCES `advertising_ecm`.`vendor`.`supply_chain_profile`(`supply_chain_profile_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ADD CONSTRAINT `fk_vendor_supply_path_record_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `advertising_ecm`.`vendor`.`accreditation`(`accreditation_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ADD CONSTRAINT `fk_vendor_supply_path_record_publisher_account_publisher_id` FOREIGN KEY (`publisher_account_publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ADD CONSTRAINT `fk_vendor_supply_path_record_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ADD CONSTRAINT `fk_vendor_supply_path_record_seller_publisher_id` FOREIGN KEY (`seller_publisher_id`) REFERENCES `advertising_ecm`.`vendor`.`publisher`(`publisher_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ADD CONSTRAINT `fk_vendor_supply_path_record_upstream_supply_path_record_id` FOREIGN KEY (`upstream_supply_path_record_id`) REFERENCES `advertising_ecm`.`vendor`.`supply_path_record`(`supply_path_record_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ADD CONSTRAINT `fk_vendor_platform_activation_tech_partner_id` FOREIGN KEY (`tech_partner_id`) REFERENCES `advertising_ecm`.`vendor`.`tech_partner`(`tech_partner_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice_dispute` ADD CONSTRAINT `fk_vendor_invoice_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `advertising_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice_dispute` ADD CONSTRAINT `fk_vendor_invoice_dispute_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `advertising_ecm`.`vendor`.`supplier`(`supplier_id`);
ALTER TABLE `advertising_ecm`.`vendor`.`invoice_dispute` ADD CONSTRAINT `fk_vendor_invoice_dispute_escalated_from_invoice_dispute_id` FOREIGN KEY (`escalated_from_invoice_dispute_id`) REFERENCES `advertising_ecm`.`vendor`.`invoice_dispute`(`invoice_dispute_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`vendor` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `advertising_ecm`.`vendor` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` SET TAGS ('dbx_subdomain' = 'partner_identity');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `ads_txt_verified` SET TAGS ('dbx_business_glossary_term' = 'Ads.txt / Sellers.json Verification Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `agency_relationship_owner` SET TAGS ('dbx_business_glossary_term' = 'Primary Agency Relationship Owner');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `api_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `api_integration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|not_applicable');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `audience_reach` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audience Reach (Unique Users)');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier Rating');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|unrated');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `cm360_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Google Campaign Manager 360 (CM360) Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Master Contract Expiry Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Country of Incorporation (ISO 3166-1 Alpha-3)');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Billing Currency Code (ISO 4217)');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `data_sharing_agreement` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement (DSA) Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `diversity_cert_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Certification Type');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `diversity_certified` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Certification Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Content Category');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Legal Entity Name');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `media_channel` SET TAGS ('dbx_business_glossary_term' = 'Supplier Media Channel');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `mediaocean_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `mrc_accredited` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accreditation Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `mrc_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Audit Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Supplier Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding Approval Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding Lifecycle Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'prospect|under_review|approved|active|suspended|terminated');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Supplier Payment Terms');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|net_90|immediate|other');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform Type (IAB Tech Lab Taxonomy)');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Supplier Primary Contact Email Address');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Primary Contact Full Name');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Supplier Primary Contact Phone Number');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `programmatic_supply_role` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Supply Chain Role');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `programmatic_supply_role` SET TAGS ('dbx_value_regex' = 'direct|reseller|both|not_applicable');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Account ID');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `spo_enabled` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Optimization (SPO) Enabled Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `tag_certified_against_fraud` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certified Against Fraud Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `tag_seal_certification_code` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Seal ID');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tax Identification Number');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `trade_desk_partner_code` SET TAGS ('dbx_business_glossary_term' = 'The Trade Desk Partner ID');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Trading Name (DBA)');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type Classification');
ALTER TABLE `advertising_ecm`.`vendor`.`supplier` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'publisher|tech_platform|production|research|other');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` SET TAGS ('dbx_subdomain' = 'partner_identity');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher ID');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certification ID');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9]{8,64}$');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `parent_publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Publisher ID');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `ads_txt_verified` SET TAGS ('dbx_business_glossary_term' = 'Ads.txt Verified Status');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `audience_measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Audience Measurement Source');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `audience_measurement_source` SET TAGS ('dbx_value_regex' = 'comscore|nielsen|mrc_audited_self|third_party|not_measured');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `base_cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Cost Per Mille (CPM) Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `base_cpm_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'open_market|private_marketplace|preferred_deal|programmatic_guaranteed|direct_io');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `grp_enabled` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Enabled');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `iab_content_category_code` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Content Category Code');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Vendor Review Date');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `monthly_impressions` SET TAGS ('dbx_business_glossary_term' = 'Monthly Impressions');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `monthly_unique_visitors` SET TAGS ('dbx_business_glossary_term' = 'Monthly Unique Visitors');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `mrc_accreditation_scope` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accreditation Scope');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Vendor Review Date');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Publisher Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `preferred_ssp` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supply-Side Platform (SSP)');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `programmatic_enabled` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Buying Enabled');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `publisher_type` SET TAGS ('dbx_business_glossary_term' = 'Publisher Type');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `publisher_type` SET TAGS ('dbx_value_regex' = 'digital|broadcast_network|ooh_operator|dooh_network|ctv_ott|print');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `secondary_iab_category_codes` SET TAGS ('dbx_business_glossary_term' = 'Secondary Interactive Advertising Bureau (IAB) Content Category Codes');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `sellers_json_verified` SET TAGS ('dbx_business_glossary_term' = 'Sellers.json Verified Status');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `spo_tier` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Optimization (SPO) Tier');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `spo_tier` SET TAGS ('dbx_value_regex' = 'direct|preferred|standard|excluded');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `vast_vpaid_support` SET TAGS ('dbx_business_glossary_term' = 'Video Ad Serving Template (VAST) / Video Player-Ad Interface Definition (VPAID) Support');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `vast_vpaid_support` SET TAGS ('dbx_value_regex' = 'vast_only|vpaid_only|both|neither');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Publisher Website URL');
ALTER TABLE `advertising_ecm`.`vendor`.`publisher` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` SET TAGS ('dbx_subdomain' = 'partner_identity');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Partner ID');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certification ID');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `ads_txt_authorized` SET TAGS ('dbx_business_glossary_term' = 'ads.txt Authorization Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `annual_platform_fee` SET TAGS ('dbx_business_glossary_term' = 'Annual Platform Fee');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `annual_platform_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint URL');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `api_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Status');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `api_integration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|in_progress|not_integrated');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `attribution_model_support` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Support');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `attribution_model_support` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|data_driven|multi_touch|none');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `audience_targeting_capability` SET TAGS ('dbx_business_glossary_term' = 'Audience Targeting Capability Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier Classification');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|unrated');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `data_residency_region` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Region');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `data_sharing_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `data_sharing_agreement_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Reference Number');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `data_sharing_agreement_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `iab_tech_lab_member` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Tech Lab Member Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Vendor Audit Date');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `measurement_capability` SET TAGS ('dbx_business_glossary_term' = 'Measurement and Verification Capability Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type (IAB Tech Lab Taxonomy)');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `rtb_protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Bidding (RTB) Protocol Version');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `sellers_json_verified` SET TAGS ('dbx_business_glossary_term' = 'sellers.json Verification Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `soc2_certified` SET TAGS ('dbx_business_glossary_term' = 'SOC 2 Type II Certification Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `supply_chain_role` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Supply Chain Role');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `supply_chain_role` SET TAGS ('dbx_value_regex' = 'buyer|seller|intermediary|data_provider|measurement');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `supported_channels` SET TAGS ('dbx_business_glossary_term' = 'Supported Advertising Channels');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `tech_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Technology Fee Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `tech_fee_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `vast_vpaid_support` SET TAGS ('dbx_business_glossary_term' = 'Video Ad Serving Template (VAST) / Video Player-Ad Interface Definition (VPAID) Support Version');
ALTER TABLE `advertising_ecm`.`vendor`.`tech_partner` ALTER COLUMN `vast_vpaid_support` SET TAGS ('dbx_value_regex' = 'VAST_4|VAST_3|VPAID_2|VAST_4_VPAID_2|none');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` SET TAGS ('dbx_subdomain' = 'compliance_evaluation');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation ID');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `accreditation_tier` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Tier');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `accreditation_tier` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze|standard|provisional');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `anti_fraud_certified` SET TAGS ('dbx_business_glossary_term' = 'Anti-Fraud Certified Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Application Date');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `audit_cycle` SET TAGS ('dbx_business_glossary_term' = 'Audit Cycle');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `audit_cycle` SET TAGS ('dbx_value_regex' = 'annual|biennial|quarterly|continuous|on_demand');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `brand_safety_certified` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Certified Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `ccpa_compliant` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `certificate_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Reference Number');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `certificate_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,50}$');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'TAG Brand Safety Certified|TAG Certified Against Fraud|MRC Accredited|IAB Gold Standard|ASA Compliant|FTC Compliant');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `certifying_body_contact` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body Contact');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Fee (USD)');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `geography_scope` SET TAGS ('dbx_business_glossary_term' = 'Geography Scope');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `geography_scope` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}(|[A-Z]{3})*$');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `iab_gold_standard` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Gold Standard Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `mrc_accredited` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accredited Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `renewal_alert_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Alert Lead Days');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Date');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope Description');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document URL');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `supporting_document_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Accreditation Contact Email');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Accreditation Contact Name');
ALTER TABLE `advertising_ecm`.`vendor`.`accreditation` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rate Card ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `source_system_rate_card_vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Rate Card ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `ad_size` SET TAGS ('dbx_business_glossary_term' = 'Ad Size');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `added_value_description` SET TAGS ('dbx_business_glossary_term' = 'Added Value Description');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `audience_segment_label` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Label');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `base_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'standard|brand_safe|premium_brand_safe|TAG_certified');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `channel_category` SET TAGS ('dbx_business_glossary_term' = 'Channel Category');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `channel_category` SET TAGS ('dbx_value_regex' = 'digital|traditional|programmatic|direct|out_of_home');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `geo_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `guaranteed_viewability_pct` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Viewability Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `io_terms_reference` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Terms Reference');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `is_negotiated_rate` SET TAGS ('dbx_business_glossary_term' = 'Is Negotiated Rate Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `is_negotiated_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `minimum_spend` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `minimum_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `placement_position` SET TAGS ('dbx_business_glossary_term' = 'Placement Position');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Name');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Number');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_value_regex' = '^RC-[A-Z0-9]{4,20}$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|expired|withdrawn');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `rate_card_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Type');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `rate_card_type` SET TAGS ('dbx_value_regex' = 'open_market|negotiated|preferred|programmatic_guaranteed|private_marketplace');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Version');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_business_glossary_term' = 'Viewability Standard');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_value_regex' = 'MRC_display|MRC_video|GROUPM|custom');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `volume_threshold_max` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Maximum');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `volume_threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Minimum');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `volume_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Unit');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `volume_threshold_unit` SET TAGS ('dbx_value_regex' = 'impressions|clicks|acquisitions|currency|GRP|views');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_rate_card` ALTER COLUMN `volume_tier_label` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Label');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` SET TAGS ('dbx_subdomain' = 'compliance_evaluation');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `vendor_onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `primary_vendor_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `brand_safety_review_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Review Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `brand_safety_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|approved|rejected|conditional');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `ccpa_dpa_executed_date` SET TAGS ('dbx_business_glossary_term' = 'CCPA Data Processing Agreement (DPA) Executed Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `ccpa_dpa_status` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Data Processing Agreement (DPA) Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `ccpa_dpa_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|executed|rejected');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `due_diligence_checklist_complete` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Checklist Complete');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `due_diligence_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `final_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditionally_approved|rejected');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `financial_vetting_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Vetting Completion Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `financial_vetting_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Vetting Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `financial_vetting_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|approved|rejected|pending_revision');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `gdpr_dpa_executed_date` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Processing Agreement (DPA) Executed Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `gdpr_dpa_status` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Processing Agreement (DPA) Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `gdpr_dpa_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|executed|rejected');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Initiated Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `integration_test_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Integration Test Completion Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `integration_test_notes` SET TAGS ('dbx_business_glossary_term' = 'Integration Test Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `integration_test_status` SET TAGS ('dbx_business_glossary_term' = 'System Integration Test Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `integration_test_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|waived');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `legal_review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completion Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|approved|rejected|pending_revision');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `mrc_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accreditation Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `mrc_accreditation_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|accredited|expired|revoked');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'in_progress|on_hold|completed|rejected|withdrawn');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `payment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|net_90');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Reference Number');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^ONB-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `rfi_received_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Received Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `rfi_response_received` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Response Received');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `sap_vendor_account_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Vendor Account Code');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `sap_vendor_account_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Stage');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `tag_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certification Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `tag_certification_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|certified|expired|revoked');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_onboarding` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `io_line_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Insertion Order (IO) Line ID');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Manager 360 (CM360) Placement ID');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `talent_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `vendor_io_media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `actual_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `actual_units_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Units Delivered');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `ad_unit_size` SET TAGS ('dbx_business_glossary_term' = 'Ad Unit Size');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `ad_unit_size` SET TAGS ('dbx_value_regex' = '^[0-9]+x[0-9]+$');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `added_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Added Value Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `brand_safety_segments` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Segments');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `buying_type` SET TAGS ('dbx_business_glossary_term' = 'Buying Type');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `contracted_spend` SET TAGS ('dbx_business_glossary_term' = 'Contracted Spend');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `contracted_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `contracted_units` SET TAGS ('dbx_business_glossary_term' = 'Contracted Units');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'programmatic_rtb|programmatic_direct|direct_guaranteed|direct_non_guaranteed|private_marketplace');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `dsp_line_code` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP) Line ID');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|lifetime');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `geo_targeting` SET TAGS ('dbx_business_glossary_term' = 'Geographic Targeting');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `grp_contracted` SET TAGS ('dbx_business_glossary_term' = 'Contracted Gross Rating Points (GRP)');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'IO Line Description');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'IO Line Number');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'IO Line Status');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_business_glossary_term' = 'Make-Good Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `net_rate` SET TAGS ('dbx_business_glossary_term' = 'Net Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `net_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `placement_name` SET TAGS ('dbx_business_glossary_term' = 'Placement Name');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `prisma_line_code` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Line ID');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|in_progress|reconciled|disputed|written_off');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `targeting_description` SET TAGS ('dbx_business_glossary_term' = 'Targeting Description');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `trp_contracted` SET TAGS ('dbx_business_glossary_term' = 'Contracted Target Rating Points (TRP)');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`io_line` ALTER COLUMN `viewability_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Viewability Target Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `agency_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Discount Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `agency_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `approved_billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Billing Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `approved_billing_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `brand_safety_compliant` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Compliant Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `delivered_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivered Spend Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `delivered_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `delivery_data_source` SET TAGS ('dbx_business_glossary_term' = 'Delivery Data Source');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `discrepancy_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason Code');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `dispute_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `invalid_traffic_flag` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'received|reconciled|approved|disputed|paid');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'media|production|technology|data|talent|other');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `io_authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Authorized Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `io_authorized_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|net_90|immediate|other');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `reconciliation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `reconciliation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `total_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payable Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `total_payable_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `vendor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference Number');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice` ALTER COLUMN `vendor_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation ID');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `io_line_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Io Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `talent_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `adserver_delivered_amount` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Delivered Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `adserver_delivered_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `adserver_source` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Source System');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `adserver_source` SET TAGS ('dbx_value_regex' = 'CM360|the_trade_desk|mediaocean_prisma|other');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `approved_billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Final Billing Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `approved_billing_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `buying_method` SET TAGS ('dbx_business_glossary_term' = 'Media Buying Method');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `buying_method` SET TAGS ('dbx_value_regex' = 'direct_io|programmatic_guaranteed|open_rtb|private_marketplace|preferred_deal');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Media Channel Type');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `credit_note_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `credit_note_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Number');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `discrepancy_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason Code');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `io_authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Authorized Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `io_authorized_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_business_glossary_term' = 'Make-Good Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `prisma_reconciliation_ref` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Reconciliation Reference');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_value_regex' = '^REC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|disputed|approved|closed|cancelled');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'standard|programmatic|makegood|credit_adjustment|final_bill');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Resolution Date');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Resolution Status');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'unresolved|pending_vendor|pending_internal|resolved|written_off');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Document Number');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `tolerance_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `vendor_invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoiced Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `vendor_invoiced_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`reconciliation` ALTER COLUMN `within_tolerance_flag` SET TAGS ('dbx_business_glossary_term' = 'Within Tolerance Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` SET TAGS ('dbx_subdomain' = 'partner_identity');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `agency_relationship_owner` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Owner');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Contact City');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `contact_source` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Source');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `contact_source` SET TAGS ('dbx_value_regex' = 'salesforce_crm|manual_entry|vendor_portal|io_document|rfp_response|conference');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|departed|pending_verification');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Country Code');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `data_privacy_region` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Regulatory Region');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `data_privacy_region` SET TAGS ('dbx_value_regex' = 'EEA|USA|GBR|CAN|AUS|OTHER');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `do_not_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Status');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_value_regex' = 'obtained|not_required|withdrawn|pending');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `is_billing_contact` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `is_executive_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `is_technical_contact` SET TAGS ('dbx_business_glossary_term' = 'Technical Integration Contact Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Preferred Language Code');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_business_glossary_term' = 'Contact LinkedIn Profile URL');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_value_regex' = '^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `offboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Offboarding Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Onboarding Date');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|slack|teams|portal');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'account_manager|trafficking_coordinator|billing_contact|technical_integration_lead|executive_sponsor|media_planner');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `salesforce_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Contact ID');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `salesforce_contact_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Secondary Email Address');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `advertising_ecm`.`vendor`.`vendor_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` SET TAGS ('dbx_subdomain' = 'compliance_evaluation');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `preferred_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor List (PVL) ID');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certification ID');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `ads_txt_compliant` SET TAGS ('dbx_business_glossary_term' = 'ads.txt Compliant Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|expired');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `approving_stakeholder` SET TAGS ('dbx_business_glossary_term' = 'Approving Stakeholder');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `approving_stakeholder_email` SET TAGS ('dbx_business_glossary_term' = 'Approving Stakeholder Email Address');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `approving_stakeholder_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `approving_stakeholder_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `brand_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Rating');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `brand_safety_rating` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze|unrated|failed');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `buying_method` SET TAGS ('dbx_business_glossary_term' = 'Buying Method');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `buying_method` SET TAGS ('dbx_value_regex' = 'direct_io|programmatic_guaranteed|private_marketplace|open_rtb|preferred_deal');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `campaign_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type Scope');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `ccpa_compliant` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `data_processing_agreement_signed` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement (DPA) Signed Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `dpa_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Agreement (DPA) Expiry Date');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `iab_member` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Member Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `minimum_spend_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend Commitment');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `minimum_spend_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `mrc_accredited` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accredited Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `onboarding_completed` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completed Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `preferred_partner_agreement` SET TAGS ('dbx_business_glossary_term' = 'Preferred Partner Agreement Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `pvl_entry_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor List (PVL) Entry Code');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `pvl_entry_code` SET TAGS ('dbx_value_regex' = '^PVL-[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `restriction_reason` SET TAGS ('dbx_business_glossary_term' = 'Restriction Reason');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `scope_notes` SET TAGS ('dbx_business_glossary_term' = 'Scope Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `supply_chain_transparency_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Transparency Score');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `tag_certified` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certified Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `vendor_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier');
ALTER TABLE `advertising_ecm`.`vendor`.`preferred_vendor_list` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|restricted|blacklisted|under_review');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` SET TAGS ('dbx_subdomain' = 'compliance_evaluation');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `performance_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Evaluation ID');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `actual_delivered_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivered Units');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `brand_safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Incident Count');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `brand_safety_incident_severity` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Incident Severity');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `brand_safety_incident_severity` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `contract_renewal_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Recommendation');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `contract_renewal_recommendation` SET TAGS ('dbx_value_regex' = 'renew|renew_with_conditions|renegotiate|do_not_renew');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `delivery_fulfillment_rate` SET TAGS ('dbx_business_glossary_term' = 'Delivery Fulfillment Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `disputed_invoices_count` SET TAGS ('dbx_business_glossary_term' = 'Disputed Invoices Count');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_cycle` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Cycle Quarter');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_cycle` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Evaluation Number');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_number` SET TAGS ('dbx_value_regex' = '^VPE-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|completed|approved|disputed');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluation_year` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Year');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `invalid_traffic_rate` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `io_committed_units` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Committed Units');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `makegood_fulfilled_count` SET TAGS ('dbx_business_glossary_term' = 'Make-Good Fulfilled Count');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `makegood_obligation_count` SET TAGS ('dbx_business_glossary_term' = 'Make-Good Obligation Count');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `mrc_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accreditation Status');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `mrc_accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|not_accredited|pending|suspended');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `overall_scorecard_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Vendor Scorecard Rating');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `preferred_vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor List (PVL) Tier');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `preferred_vendor_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|probation|disqualified');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `prior_preferred_vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Preferred Vendor List (PVL) Tier');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `prior_preferred_vendor_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|probation|disqualified');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `prior_scorecard_rating` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Vendor Scorecard Rating');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `response_time_sla_adherence_rate` SET TAGS ('dbx_business_glossary_term' = 'Response Time Service Level Agreement (SLA) Adherence Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `scorecard_rating_scale` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Rating Scale');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `scorecard_rating_scale` SET TAGS ('dbx_value_regex' = '0-10|0-100|1-5');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `sla_breaches_count` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breaches Count');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `sla_incidents_total` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Incidents Total');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `tag_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certification Status');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `tag_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|pending|expired');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `total_invoices_submitted` SET TAGS ('dbx_business_glossary_term' = 'Total Invoices Submitted');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `vendor_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `vendor_dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Dispute Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `vendor_dispute_notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Dispute Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`performance_evaluation` ALTER COLUMN `viewability_rate` SET TAGS ('dbx_business_glossary_term' = 'Viewability Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'compliance_evaluation');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `prior_risk_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^RA-[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|expired');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial|annual_refresh|triggered|ad_hoc|client_mandated');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `brand_safety_risk` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Risk');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `brand_safety_risk` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `business_continuity_plan_verified` SET TAGS ('dbx_business_glossary_term' = 'Business Continuity Plan (BCP) Verified');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `business_continuity_risk` SET TAGS ('dbx_business_glossary_term' = 'Business Continuity Risk');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `business_continuity_risk` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `ccpa_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'CCPA (California Consumer Privacy Act) Compliance Status');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `ccpa_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|partially_compliant|non_compliant|not_applicable');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `ccpa_risk_level` SET TAGS ('dbx_business_glossary_term' = 'CCPA (California Consumer Privacy Act) Risk Level');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `ccpa_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `client_mandated_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Mandated Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `concentration_risk` SET TAGS ('dbx_business_glossary_term' = 'Concentration Risk');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `concentration_risk` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `data_breach_count` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Count');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `data_breach_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Breach History Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `data_security_posture` SET TAGS ('dbx_business_glossary_term' = 'Data Security Posture');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `data_security_posture` SET TAGS ('dbx_value_regex' = 'excellent|good|adequate|needs_improvement|poor');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `financial_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Risk Score');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `financial_stability_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Stability Rating');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `gdpr_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Compliance Status');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `gdpr_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|partially_compliant|non_compliant|not_applicable');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `gdpr_risk_level` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Risk Level');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `gdpr_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `insurance_coverage_verified` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Verified');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency Code');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `iso27001_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'ISO 27001 Certificate Expiry Date');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `iso27001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 27001 Certified');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `mrc_accredited` SET TAGS ('dbx_business_glossary_term' = 'MRC (Media Rating Council) Accredited');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `overall_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Rating');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `overall_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `revenue_dependency_pct` SET TAGS ('dbx_business_glossary_term' = 'Revenue Dependency Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `revenue_dependency_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `soc2_compliant` SET TAGS ('dbx_business_glossary_term' = 'SOC 2 (Service Organization Control 2) Compliant');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `soc2_report_date` SET TAGS ('dbx_business_glossary_term' = 'SOC 2 (Service Organization Control 2) Report Date');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `tag_certified` SET TAGS ('dbx_business_glossary_term' = 'TAG (Trustworthy Accountability Group) Certified');
ALTER TABLE `advertising_ecm`.`vendor`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` SET TAGS ('dbx_subdomain' = 'compliance_evaluation');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `supply_chain_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Profile ID');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certification ID');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `superseded_supply_chain_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `ads_txt_authorized` SET TAGS ('dbx_business_glossary_term' = 'Ads.txt Authorized');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `average_viewability_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Viewability Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|monitored|high_risk|excluded');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `brand_safety_verification_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Verification Score');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `ccpa_compliant` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `content_adjacency_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Adjacency Risk Rating');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `content_adjacency_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `critical_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Incident Count');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `data_residency_region` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Region');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `intermediary_count` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Count');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `invalid_traffic_rate` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Rate');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `mrc_accredited` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accredited');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `preferred_vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `preferred_vendor_status` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|excluded|under_review');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `profile_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Profile Reference Number');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|under_review|suspended|approved|rejected|expired');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Months');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `sellers_json_url` SET TAGS ('dbx_business_glossary_term' = 'Sellers.json URL');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `sellers_json_verified` SET TAGS ('dbx_business_glossary_term' = 'Sellers.json Verified');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `spo_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Optimization (SPO) Documentation URL');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `supply_chain_documentation_complete` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Documentation Complete');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `supply_chain_transparency_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Transparency Score');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `supply_path_optimization_tier` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Optimization (SPO) Tier');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `supply_path_optimization_tier` SET TAGS ('dbx_value_regex' = 'tier_1_direct|tier_2_preferred|tier_3_standard|tier_4_restricted|not_classified');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `tag_certified_against_fraud` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certified Against Fraud');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_chain_profile` ALTER COLUMN `viewability_standard_met` SET TAGS ('dbx_business_glossary_term' = 'Viewability Standard Met');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` SET TAGS ('dbx_subdomain' = 'compliance_evaluation');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `supply_path_record_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Record Identifier (ID)');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certification Identifier (ID)');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `publisher_account_publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Account Identifier (ID) at SSP');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Identifier (ID)');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `seller_publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Identifier (ID) in Sellers.json');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `ssp_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Supply-Side Platform (SSP) Identifier (ID)');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `upstream_supply_path_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `ads_txt_entry` SET TAGS ('dbx_business_glossary_term' = 'Ads.txt Entry Declaration');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `ads_txt_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Ads.txt Verification Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `ads_txt_verified` SET TAGS ('dbx_business_glossary_term' = 'Ads.txt Verification Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Approved By User');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Approval Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `authorized_seller_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorized Seller Declaration Flag');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier Classification');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'tier_1_premium|tier_2_standard|tier_3_monitored|tier_4_restricted|unrated');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `brand_safety_verified` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Verification Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `critical_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Supply Path Incident Count');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Effective From Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Effective Until Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Exclusion Reason');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Incident Count');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `intermediary_count` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Intermediary Count');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `invalid_traffic_rate` SET TAGS ('dbx_business_glossary_term' = 'Invalid Traffic (IVT) Rate Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Supply Path Verification Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Supply Path Review Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Record Notes');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `record_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Record Reference Number');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Record Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|expired|revoked');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Review Cycle in Months');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `seller_domain` SET TAGS ('dbx_business_glossary_term' = 'Seller Domain in Sellers.json');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `seller_name` SET TAGS ('dbx_business_glossary_term' = 'Seller Name in Sellers.json');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `seller_type` SET TAGS ('dbx_business_glossary_term' = 'Seller Type Classification');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `seller_type` SET TAGS ('dbx_value_regex' = 'direct|reseller|both');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `sellers_json_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Sellers.json Verification Date');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `sellers_json_verified` SET TAGS ('dbx_business_glossary_term' = 'Sellers.json Verification Status');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `spo_tier` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Optimization (SPO) Tier Classification');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `spo_tier` SET TAGS ('dbx_value_regex' = 'tier_1_preferred|tier_2_approved|tier_3_standard|tier_4_restricted|unclassified');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `ssp_domain` SET TAGS ('dbx_business_glossary_term' = 'Supply-Side Platform (SSP) Domain');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `supply_path_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Optimization (SPO) Quality Score');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supply Path Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`supply_path_record` ALTER COLUMN `viewability_rate` SET TAGS ('dbx_business_glossary_term' = 'Viewability Rate Percentage');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` SET TAGS ('dbx_subdomain' = 'compliance_evaluation');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` SET TAGS ('dbx_association_edges' = 'vendor.tech_partner,project.initiative');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `platform_activation_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Activation Identifier');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Activation - Initiative Id');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Integration Owner');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Activation - Tech Partner Id');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `api_credentials_ref` SET TAGS ('dbx_business_glossary_term' = 'API Credentials Reference');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `api_credentials_ref` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `integration_scope` SET TAGS ('dbx_business_glossary_term' = 'Integration Scope');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `platform_fee_allocated` SET TAGS ('dbx_business_glossary_term' = 'Allocated Platform Fee');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `advertising_ecm`.`vendor`.`platform_activation` ALTER COLUMN `usage_volume` SET TAGS ('dbx_business_glossary_term' = 'Platform Usage Volume');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice_dispute` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice_dispute` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice_dispute` ALTER COLUMN `invoice_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Identifier');
ALTER TABLE `advertising_ecm`.`vendor`.`invoice_dispute` ALTER COLUMN `escalated_from_invoice_dispute_id` SET TAGS ('dbx_self_ref_fk' = 'true');
