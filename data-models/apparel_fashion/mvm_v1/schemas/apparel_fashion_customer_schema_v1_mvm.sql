-- Schema for Domain: customer | Business: Apparel Fashion | Version: v1_mvm
-- Generated on: 2026-05-05 18:07:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`customer` COMMENT 'SSOT for all customer identities, profiles, preferences, segments, loyalty programs, and CLTV across DTC, wholesale, and retail channels. Manages B2C consumers, B2B wholesale accounts, household relationships, and enterprise partnerships. Supports NPS tracking, personalization strategies, and CRM data sourced from Adobe Experience Platform and Salesforce.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique surrogate identifier for the consumer profile record. Serves as the primary key and golden identity anchor across all downstream systems including loyalty, preferences, interactions, and Customer Lifetime Value (CLTV) analytics.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to merchandising.channel. Business justification: Preferred channel normalization: profile.acquisition_channel is a denormalized text field. A proper FK to merchandising.channel enables omnichannel personalization — assortment recommendations, pricin',
    `contact_id` BIGINT COMMENT 'Native contact identifier from Salesforce CRM (Salesforce Contact ID). Used to cross-reference the golden profile with the operational CRM record for campaign management, service interactions, and sales activity tracking.',
    `merged_into_profile_id` BIGINT COMMENT 'When profile_status = merged, this field contains the profile_id of the surviving golden master profile into which this record was consolidated. Enables identity resolution audit trails and supports data subject access requests (DSAR) under GDPR Article 15 by tracing merged identities.',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to merchandising.price_book. Business justification: Personalized pricing: VIP, employee, and loyalty-tier customers are assigned specific price books in DTC fashion retail. This FK enables the POS and e-commerce engine to apply the correct price book a',
    `region_id` BIGINT COMMENT 'Foreign key linking to merchandising.region. Business justification: Regional pricing and assortment targeting: customer profiles are assigned to merchandising regions to apply correct price books, tax jurisdictions, and regional promotions. Fashion retailers use regio',
    `retail_store_id` BIGINT COMMENT 'Identifier of the consumers preferred or most frequently visited retail store location. Used for store-level clienteling, localized promotions, in-store event invitations, and store traffic attribution in SAP Customer Activity Repository.',
    `adobe_ecid` STRING COMMENT 'Adobe Experience Cloud Identity (ECID) assigned by Adobe Experience Platform (AEP) for cross-channel identity stitching, personalization, and real-time audience segmentation. Core identifier in the identity resolution graph.',
    `birth_date` DATE COMMENT 'Consumers date of birth in yyyy-MM-dd format. Used for age verification, birthday loyalty reward triggers, demographic segmentation, and compliance with COPPA (Childrens Online Privacy Protection Act) for consumers under 13.',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the California consumer has exercised their right to opt out of the sale or sharing of personal information under CCPA. True = opted out of data sale/sharing; False = no opt-out exercised. Applicable to California residents. Must be honored within 15 business days per CCPA Section 1798.120.',
    `country_of_residence` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the consumers country of residence. Determines applicable privacy regulations (GDPR for EU residents, CCPA for California residents), tax jurisdiction, and eligible product catalog.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumer profile record was first created in the Silver Layer data lakehouse. Recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit compliance, and consumer tenure calculations.',
    `customer_type` STRING COMMENT 'Classification of the consumer profile by relationship type. Distinguishes Direct-to-Consumer (DTC) retail shoppers, Business-to-Business (B2B) wholesale account contacts, VIP/high-value consumers, employee accounts, brand influencers, and anonymous guest profiles. Drives differential pricing, service levels, and personalization strategies. [ENUM-REF-CANDIDATE: b2c_consumer|b2b_wholesale|vip|employee|influencer|anonymous — promote to reference product]. Valid values are `b2c_consumer|b2b_wholesale|vip|employee|influencer|anonymous`',
    `data_retention_flag` BOOLEAN COMMENT 'Indicates whether the consumer has consented to extended data retention beyond the minimum operational period. True = extended retention consented; False = standard minimum retention applies. Supports GDPR Article 5(1)(e) storage limitation principle and data governance policy enforcement.',
    `email` STRING COMMENT 'Consumers primary email address used for Direct-to-Consumer (DTC) communications, e-commerce account login, loyalty enrollment, and marketing campaign delivery. Serves as a key deterministic identity resolution signal.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_opt_in` BOOLEAN COMMENT 'Indicates whether the consumer has provided explicit consent to receive marketing emails. True = opted in; False = opted out or no consent given. Mandatory compliance flag for CAN-SPAM, GDPR Article 6, and CCPA opt-out requirements. Must be honored in all email campaign execution.',
    `family_name` STRING COMMENT 'Consumers legal family name (last name or surname) as captured at registration or point of sale. Combined with given_name to form the full display name for communications and identity resolution.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the consumer has provided valid GDPR consent for personal data processing. True = consent granted; False = consent not granted or withdrawn. Applicable to EU/EEA residents. Mandatory for lawful data processing under GDPR Article 6(1)(a). Must be re-evaluated upon consent withdrawal.',
    `gender_identity` STRING COMMENT 'Consumers self-reported gender identity. Used for personalized product recommendations, size guidance, targeted marketing, and assortment planning analytics. Collected with explicit consent per GDPR and CCPA requirements.. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `given_name` STRING COMMENT 'Consumers legal given name (first name) as captured at registration or point of sale. Used for personalized communications, loyalty program enrollment, and CRM record matching.',
    `identity_confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence score (0.0000 to 1.0000) representing the certainty of the identity resolution linking multiple cross-channel identifiers to this golden profile. Higher scores indicate stronger deterministic signal overlap. Used to prioritize profile merge decisions and flag low-confidence profiles for manual review in Adobe Experience Platform.',
    `identity_resolution_method` STRING COMMENT 'The method used to resolve and stitch cross-channel identifiers into this golden profile. deterministic uses exact-match signals (email, loyalty card); probabilistic uses statistical inference (device fingerprint, behavioral signals); hybrid combines both; manual indicates agent-assisted resolution. Sourced from Adobe Experience Platform Identity Service.. Valid values are `deterministic|probabilistic|hybrid|manual`',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the consumers identity has been verified through email confirmation, phone OTP, or document verification. True = identity verified; False = unverified or pending. Verified profiles receive higher identity confidence scores and are eligible for full loyalty benefits and personalization features.',
    `loyalty_card_number` STRING COMMENT 'Physical or digital loyalty program card number issued to the consumer. Used as a cross-channel identifier linking in-store POS transactions, e-commerce orders, and loyalty reward accruals to the golden profile.',
    `loyalty_enrollment_date` DATE COMMENT 'Date on which the consumer enrolled in the brands loyalty program. Used to calculate loyalty tenure, anniversary reward triggers, and cohort-based loyalty program performance analysis.',
    `loyalty_points_balance` STRING COMMENT 'Current unredeemed loyalty points balance for the consumer. Represents accrued reward currency from purchases, referrals, and engagement activities. Used for redemption eligibility checks, tier qualification calculations, and loyalty liability reporting.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) survey response from the consumer, ranging from 0 (detractor) to 10 (promoter). Used to classify consumers as Promoters (9-10), Passives (7-8), or Detractors (0-6) for brand health tracking and CRM segmentation in Salesforce.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent Net Promoter Score (NPS) survey response was recorded. Used to assess recency of sentiment data and determine eligibility for follow-up NPS surveys based on survey frequency rules.',
    `phone` STRING COMMENT 'Consumers primary contact phone number in E.164 international format. Used for SMS marketing opt-ins, order notifications, loyalty communications, and as a probabilistic identity resolution signal.. Valid values are `^+?[1-9]d{1,14}$`',
    `pos_customer_code` STRING COMMENT 'Customer identifier assigned within the SAP Customer Activity Repository (CAR) POS system for in-store transaction linkage. Enables reconciliation of retail store purchases to the golden consumer profile.',
    `preferred_language` STRING COMMENT 'Consumers preferred communication language expressed as an IETF BCP 47 language tag (e.g., en-US, fr-FR, de-DE). Drives localized content delivery, email template selection, and customer service routing in Salesforce Commerce Cloud.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `preferred_shoe_size` STRING COMMENT 'Consumers self-reported or purchase-history-derived preferred footwear size including size system notation (e.g., US 10, EU 44, UK 9). Used for footwear product recommendations, inventory allocation, and size curve analytics in Oracle Retail Merchandising System.',
    `preferred_size_bottom` STRING COMMENT 'Consumers self-reported or algorithmically inferred preferred size for bottoms/lower body apparel (e.g., waist/inseam measurements or S/M/L sizing). Used for personalized product recommendations, size-based filtering, and returns reduction analytics.',
    `preferred_size_top` STRING COMMENT 'Consumers self-reported or algorithmically inferred preferred size for tops/upper body apparel (e.g., XS, S, M, L, XL, XXL, or numeric sizing). Used for personalized product recommendations, size-based filtering, and fit analytics in Salesforce Commerce Cloud and Adobe Experience Platform.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the consumer profile record. active indicates a verified, engaged consumer; merged indicates the record has been consolidated into a master golden profile; pending_verification indicates email or identity not yet confirmed. Drives CRM suppression lists and data governance workflows.. Valid values are `active|inactive|suspended|pending_verification|merged|deceased`',
    `push_notification_opt_in` BOOLEAN COMMENT 'Indicates whether the consumer has enabled push notifications on their registered mobile device(s) for the brands mobile application. True = enabled; False = disabled. Drives mobile engagement campaign eligibility in Adobe Experience Platform.',
    `registration_source` STRING COMMENT 'The operational system of record from which this consumer profile was originally created or first ingested. Identifies whether the profile originated from Salesforce Commerce Cloud (e-commerce), Adobe Experience Platform (digital), SAP Customer Activity Repository (POS/in-store), mobile app, or manual entry. Critical for data lineage and source system reconciliation. [ENUM-REF-CANDIDATE: salesforce_commerce_cloud|adobe_aep|sap_car_pos|mobile_app|in_store_tablet|wholesale_portal|manual_entry — promote to reference product]',
    `sms_opt_in` BOOLEAN COMMENT 'Indicates whether the consumer has provided explicit consent to receive SMS/text message marketing communications. True = opted in; False = opted out. Required for TCPA (Telephone Consumer Protection Act) compliance in the US and equivalent regulations in other jurisdictions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any attribute on this consumer profile record. Recorded in ISO 8601 format. Used for change data capture (CDC) processing, data freshness monitoring, and audit trail compliance in the Databricks Silver Layer.',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'SSOT master record and golden identity for every individual consumer (B2C) across DTC, retail, and e-commerce channels. Captures full identity attributes including name, date of birth, gender, preferred language, contact details, GDPR/CCPA consent flags, communication opt-ins, household membership, and CRM source system identifiers. Embeds the complete identity resolution graph linking multiple cross-channel identifiers (email, phone, cookie ID, device ID, loyalty card number, POS customer ID, Salesforce contact ID, Adobe ECID) with link type, link confidence scores, resolution methods (deterministic, probabilistic), source systems, and active status. Serves as the anchor entity for loyalty, preferences, interactions, CLTV, and all downstream personalization.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` (
    `wholesale_account_id` BIGINT COMMENT 'Unique surrogate identifier for the wholesale account record in the Databricks Silver Layer. Primary key for all downstream joins and lineage tracking.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to merchandising.channel. Business justification: Channel assignment: wholesale accounts are assigned to a merchandising channel (wholesale, department store, specialty retail) driving assortment eligibility, pricing strategy, and allocation priority',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Wholesale accounts in multi-entity apparel businesses must be assigned to the contracting legal entity (company code) for statutory reporting, tax compliance, intercompany revenue recognition, and leg',
    `parent_account_wholesale_account_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent wholesale account record. Supports parent-child hierarchy modeling for franchise networks, buying groups, and corporate group structures. Null for top-level accounts.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Wholesale accounts (retailers, distributors) often have preferred vendor relationships for private label manufacturing, co-branding, or exclusive production agreements. Critical for vendor allocation,',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to merchandising.price_book. Business justification: Wholesale pricing: every wholesale account is assigned a price book (key account, distributor, or standard wholesale) that governs all order pricing. This is a core B2B merchandising operation — witho',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Wholesale accounts are assigned to profit centers for revenue attribution and account-level P&L reporting. Apparel wholesale finance teams track net revenue, margin, and trade spend by account against',
    `region_id` BIGINT COMMENT 'Foreign key linking to merchandising.region. Business justification: Territory/regional assignment: wholesale accounts are assigned to merchandising regions for territory management, regional pricing zones, and allocation decisions. Fashion sales operations use this FK',
    `account_number` STRING COMMENT 'Externally-known alphanumeric account number assigned to the wholesale buyer in the ERP system (SAP S/4HANA SD Customer Number). Used as the primary business identifier on purchase orders, invoices, and EDI transactions.',
    `account_status` STRING COMMENT 'Current lifecycle status of the wholesale account. Controls order acceptance, credit extension, and EDI transaction processing. On Hold blocks new purchase orders pending credit review.. Valid values are `active|inactive|suspended|prospect|on_hold|terminated`',
    `account_tier` STRING COMMENT 'Strategic tier classification of the wholesale account reflecting revenue contribution, strategic importance, and service priority. Platinum and Gold accounts receive dedicated sales reps, priority allocation, and preferential credit terms.. Valid values are `platinum|gold|silver|bronze|standard`',
    `account_type` STRING COMMENT 'Classification of the wholesale account by channel and business model. Drives assortment planning, pricing strategy, and service level agreements. [ENUM-REF-CANDIDATE: department_store|specialty_retailer|boutique|online_retailer|franchise|buying_group|distributor|corporate_group — promote to reference product]',
    `billing_address_line1` STRING COMMENT 'Primary street address line for the wholesale accounts billing location. Used on invoices, credit documents, and financial correspondence.',
    `billing_city` STRING COMMENT 'City of the wholesale accounts billing address. Used for invoice generation, tax jurisdiction determination, and geographic sales reporting.',
    `billing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the wholesale accounts billing address. Drives VAT/GST applicability, currency assignment, and cross-border trade compliance.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the wholesale accounts billing address. Used for tax jurisdiction mapping, freight zone calculation, and geographic analytics.',
    `buying_authority_level` STRING COMMENT 'Level of purchasing authority held by the primary contact at the wholesale account. Full = can commit to purchase orders independently; Limited = requires co-approval; None = informational contact only. Used to ensure correct approval routing.. Valid values are `full|limited|none`',
    `contract_end_date` DATE COMMENT 'Expiry date of the current wholesale trading agreement. Null indicates an open-ended agreement. Used to trigger contract renewal workflows and prevent order acceptance on expired terms.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current wholesale trading agreement or master service agreement with this account. Defines the period during which agreed pricing, MOQ, and credit terms are binding.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the wholesale accounts primary registered business address. Used for trade compliance, duty calculations, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the wholesale account record was first created in the data platform. Supports data lineage, audit trail, and GDPR data retention policy enforcement.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding accounts receivable balance approved for this wholesale account in the accounts transaction currency. Enforced by SAP S/4HANA FI credit management to block orders when exceeded.',
    `credit_rating` STRING COMMENT 'Internal or external credit risk rating assigned to the wholesale account. Informs credit limit setting, payment term negotiation, and order hold decisions. Aligned with Dun & Bradstreet or internal credit scoring models. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|D — 8 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the wholesale accounts default transaction currency. Used for purchase order pricing, invoicing, and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet Data Universal Numbering System (DUNS) identifier uniquely identifying the legal business entity globally. Used for credit risk assessment, EDI partner setup, and supplier onboarding.. Valid values are `^[0-9]{9}$`',
    `edi_capable` BOOLEAN COMMENT 'Indicates whether the wholesale account is set up for Electronic Data Interchange (EDI) transaction processing (purchase orders, invoices, advance ship notices). True = EDI-enabled; False = manual/portal-based ordering.',
    `edi_partner_code` STRING COMMENT 'EDI interchange qualifier and sender/receiver ID assigned to the wholesale account for EDI transaction routing. Required for X12 850 (PO), 810 (Invoice), and 856 (ASN) message exchange.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this account within the parent-child hierarchy. Level 1 = top-level corporate group; Level 2 = regional subsidiary; Level 3 = individual franchise or buying office. Used for roll-up reporting and consolidated financial analysis.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost responsibility between Apparel Fashion and the wholesale account. FOB and DDP are most common in apparel wholesale. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `industry_segment` STRING COMMENT 'Primary apparel industry segment the wholesale account operates in. Used for targeted collection planning, assortment curation, and marketing alignment. [ENUM-REF-CANDIDATE: athletic|lifestyle|luxury|outdoor|workwear|childrenswear|accessories|footwear — promote to reference product]',
    `legal_entity_name` STRING COMMENT 'Full registered legal name of the wholesale account as filed with the relevant government authority. Used for contracts, invoicing, and regulatory compliance. Sourced from SAP S/4HANA SD Customer Master.',
    `moq_units` STRING COMMENT 'Minimum Order Quantity (MOQ) in units agreed with this wholesale account per purchase order or per style. Enforced during order entry to ensure production viability and margin targets.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) survey result from the wholesale accounts primary contact, ranging from 0 to 10. Used to measure account satisfaction, predict churn risk, and prioritize retention efforts.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS survey response was recorded for this wholesale account. Used to determine survey recency and schedule follow-up outreach.',
    `onboarding_date` DATE COMMENT 'Date on which the wholesale account was formally onboarded and activated for trading. Used to calculate account tenure, cohort analysis, and anniversary-based relationship milestones.',
    `payment_terms_code` STRING COMMENT 'SAP payment terms key (e.g., NET30, NET60, 2/10NET30) defining the due date and early payment discount structure for invoices issued to this wholesale account. Directly impacts cash flow forecasting and DSO metrics.',
    `preferred_comm_channel` STRING COMMENT 'The wholesale accounts preferred channel for receiving business communications including order confirmations, collection previews, and account updates. Drives outreach strategy in Salesforce and Adobe Experience Platform.. Valid values are `email|phone|edi|portal|in_person`',
    `primary_contact_department` STRING COMMENT 'Department of the primary contact person within the wholesale account organization. Used to route communications to the correct functional team (e.g., buying team for assortment decisions, logistics for shipment coordination). [ENUM-REF-CANDIDATE: buying|merchandising|logistics|finance|marketing|operations|executive — 7 candidates stripped; promote to reference product]',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary contact person at the wholesale account. Used for order confirmations, collection previews, and account communications. Mapped to Salesforce Contact Email field.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Direct business phone number of the primary contact person at the wholesale account. Used for urgent order communications, sales calls, and account management.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the wholesale account (e.g., Head Buyer, VP Merchandising, Procurement Director). Used to assess buying authority and route communications appropriately.',
    `relationship_status` STRING COMMENT 'Current health and strategic status of the commercial relationship with the wholesale account. At Risk triggers proactive account management intervention. Used in CRM pipeline and NPS-driven retention programs.. Valid values are `active|at_risk|churned|new|strategic`',
    `rfid_enabled` BOOLEAN COMMENT 'Indicates whether the wholesale account requires Radio Frequency Identification (RFID) tagging on shipped merchandise for inventory tracking and compliance with the accounts receiving standards.',
    `sales_territory_code` STRING COMMENT 'Code identifying the geographic or channel-based sales territory to which this wholesale account is assigned. Used for quota allocation, territory performance reporting, and sales rep assignment.',
    `salesforce_account_code` STRING COMMENT 'Unique identifier of the corresponding Account object in Salesforce CRM. Enables bi-directional synchronization between the data lakehouse and Salesforce for sales pipeline, opportunity, and contact management.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identification number (e.g., EIN in the US, VAT registration number in the EU) for the wholesale account. Required for invoicing, customs documentation, and regulatory reporting.',
    `trade_name` STRING COMMENT 'Operating or doing business as (DBA) name of the wholesale account, which may differ from the legal entity name. Used for commercial communications and brand recognition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the wholesale account record in the data platform. Used for change data capture (CDC), incremental ETL processing, and audit compliance.',
    CONSTRAINT pk_wholesale_account PRIMARY KEY(`wholesale_account_id`)
) COMMENT 'SSOT master record for B2B wholesale buyers, retail partners, and enterprise accounts. Captures legal entity name, DUNS number, tax ID, credit terms, payment terms, assigned sales rep, account tier, EDI capability, MOQ agreements, and parent-child hierarchy relationships for franchise networks, buying groups, and corporate group structures. Includes full contact person management: each contact with first name, last name, job title, department, email, phone, preferred communication channel, buying authority level, relationship status, and Salesforce Contact object mapping. Supports multi-contact management per account with role-based access patterns for buying, logistics, and finance contacts.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique surrogate identifier for the contact person record within the Apparel Fashion customer domain. Primary key for the contact data product.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: The contact product description explicitly states Individual contact persons associated with a wholesale account or enterprise partnership. This is the primary parent-child relationship for the cont',
    `buying_authority_level` STRING COMMENT 'Indicates the contacts level of purchasing decision-making authority within their organization. Determines the appropriate engagement level for sales and account management teams. Ranges from no authority (none) to full executive sign-off (executive). Critical for B2B sales strategy and PO approval workflows.. Valid values are `none|limited|standard|senior|executive`',
    `ccpa_opt_out` BOOLEAN COMMENT 'Indicates whether this contact has exercised their CCPA right to opt out of the sale or sharing of their personal information. When True, the contacts data must not be sold or shared with third parties per California law.',
    `contact_type` STRING COMMENT 'Functional classification of the contacts role in the B2B relationship. Buyer contacts are involved in purchasing decisions; merchandiser contacts manage product assortment; finance contacts handle invoicing and payments; logistics contacts manage shipping and fulfillment. [ENUM-REF-CANDIDATE: buyer|merchandiser|finance|logistics|executive|legal|operations|other — promote to reference product]. Valid values are `buyer|merchandiser|finance|logistics|executive|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation anchor for data governance and regulatory compliance reporting.',
    `data_source` STRING COMMENT 'Identifies the originating system or method through which this contact record was created or last updated. Supports data lineage, quality assessment, and reconciliation between Salesforce CRM, Adobe Experience Platform, and the Databricks lakehouse silver layer.. Valid values are `salesforce|manual_entry|edi|web_form|import|adobe_aep`',
    `department` STRING COMMENT 'Business department or functional area within the wholesale account or enterprise partner organization where the contact works (e.g., Buying, Merchandising, Finance, Logistics). Supports targeted B2B communication routing.',
    `email` STRING COMMENT 'Primary business email address for the contact person. Used for order confirmations, EDI notifications, collection previews, and B2B account communications. Maps to Salesforce Contact Email field.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_opt_in` BOOLEAN COMMENT 'Indicates whether this contact has opted in to receive marketing emails, including seasonal collection previews, trade show invitations, and promotional communications. Drives email campaign eligibility in Adobe Experience Platform.',
    `first_name` STRING COMMENT 'Given name of the contact person. Used for personalized communication and salutation in B2B correspondence with wholesale accounts and enterprise partners.',
    `gdpr_consent_date` DATE COMMENT 'Date on which GDPR consent was most recently granted or withdrawn by this contact. Required for regulatory audit trails demonstrating lawful basis for data processing under GDPR Article 7.',
    `gdpr_consent_status` STRING COMMENT 'Current GDPR consent status for processing this contacts personal data for marketing and communication purposes. granted indicates explicit consent; withdrawn triggers suppression from marketing campaigns; not_applicable for contacts outside GDPR jurisdiction.. Valid values are `granted|withdrawn|pending|not_applicable`',
    `is_billing_contact` BOOLEAN COMMENT 'Indicates whether this contact is designated to receive invoices, payment reminders, and financial communications for the associated wholesale account. Supports accounts receivable workflows in SAP S/4HANA FI/CO module.',
    `is_decision_maker` BOOLEAN COMMENT 'Indicates whether this contact has final decision-making authority for purchasing, contract signing, or strategic partnership agreements. Used by sales and account management teams to prioritize engagement and escalation paths.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the designated primary point of contact for the associated wholesale account or enterprise partnership. Only one contact per account should be flagged as primary. Used to route default communications and account management activities.',
    `is_shipping_contact` BOOLEAN COMMENT 'Indicates whether this contact is designated to receive shipping notifications, delivery confirmations, and logistics communications. Supports OTIF tracking and 3PL coordination for wholesale order fulfillment.',
    `job_title` STRING COMMENT 'Official job title or position of the contact person within their organization (e.g., Head Buyer, VP Merchandising, Procurement Manager). Critical for understanding the contacts role in the B2B purchasing process.',
    `language_code` STRING COMMENT 'ISO 639-1 language code representing the contacts preferred language for business communications (e.g., en, fr, de, zh-CN). Drives localization of email templates, product catalogs, and collection presentations sent to wholesale buyers.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_interaction_date` DATE COMMENT 'Date of the most recent business interaction with this contact, including calls, emails, meetings, or trade show engagements. Used by account managers to monitor relationship health and identify contacts requiring re-engagement.',
    `last_name` STRING COMMENT 'Family name or surname of the contact person. Combined with first_name to form the full display name for B2B relationship management and CRM records.',
    `linkedin_url` STRING COMMENT 'LinkedIn professional profile URL for the contact. Used by account managers and sales teams for relationship intelligence, pre-meeting research, and social selling in B2B wholesale and enterprise partnership contexts.. Valid values are `^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$`',
    `mailing_city` STRING COMMENT 'City component of the contacts mailing address. Used in conjunction with mailing_street for physical correspondence and geographic segmentation of wholesale accounts.',
    `mailing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the contacts mailing address country (e.g., USA, GBR, DEU). Used for international shipping, customs documentation, and regional account management assignment.. Valid values are `^[A-Z]{3}$`',
    `mailing_street` STRING COMMENT 'Street address line for the contacts mailing address. Used for sending physical samples, lookbooks, seasonal collection materials, and formal correspondence to wholesale buyers and enterprise partners.',
    `mobile_phone` STRING COMMENT 'Mobile or cell phone number for the contact person in E.164 international format. Supports SMS notifications, WhatsApp business communications, and urgent B2B outreach for wholesale account management.. Valid values are `^+?[1-9]d{1,14}$`',
    `next_followup_date` DATE COMMENT 'Scheduled date for the next planned follow-up interaction with this contact. Used by account managers and sales representatives to manage their B2B outreach cadence and ensure timely engagement with wholesale buyers.',
    `notes` STRING COMMENT 'Free-text field for account managers to capture qualitative relationship notes, meeting summaries, preferences, and contextual information about the contact. Supports B2B relationship intelligence and account handover documentation. Classified confidential due to potential inclusion of sensitive business relationship details.',
    `nps_score` STRING COMMENT 'Net Promoter Score (NPS) for this contact, ranging from 0 to 10, representing their likelihood to recommend Apparel Fashion to other businesses. Supports B2B relationship health monitoring and partner satisfaction tracking as part of the customer domain NPS strategy.',
    `nps_survey_date` DATE COMMENT 'Date when the most recent NPS survey was administered to this contact. Used to track survey recency and schedule future NPS measurement cycles for B2B partner satisfaction programs.',
    `phone` STRING COMMENT 'Primary business phone number for the contact person in E.164 international format. Used for direct B2B account management calls, order follow-ups, and time-sensitive communications.. Valid values are `^+?[1-9]d{1,14}$`',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred channel for business communications. Drives outreach strategy for account managers and sales representatives managing wholesale and enterprise partnerships. Supports personalization in CRM workflows.. Valid values are `email|phone|mobile|video_call|in_person`',
    `relationship_status` STRING COMMENT 'Current status of the business relationship with this contact. Drives CRM workflows, outreach eligibility, and account management prioritization. do_not_contact enforces opt-out compliance under GDPR and CCPA.. Valid values are `active|inactive|prospect|lapsed|do_not_contact`',
    `salesforce_contact_code` STRING COMMENT 'External identifier from the Salesforce CRM system corresponding to the Contact object. Used for cross-system reconciliation and data lineage between the lakehouse silver layer and Salesforce.. Valid values are `^003[a-zA-Z0-9]{15}$`',
    `salutation` STRING COMMENT 'Formal honorific or salutation prefix for the contact person (e.g., Mr., Ms., Dr.). Used in formal written and email correspondence with wholesale buyers and enterprise partners.. Valid values are `Mr.|Ms.|Mrs.|Dr.|Prof.`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the contacts location (e.g., America/New_York, Europe/London). Used to schedule calls, meetings, and automated communications at appropriate local times for global wholesale account management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC), incremental ETL processing, and audit trail maintenance in the Databricks silver layer.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual contact persons associated with a wholesale account or enterprise partnership. Captures first name, last name, job title, department, email, phone, preferred communication channel, buying authority level, and relationship status. Supports B2B relationship management and maps to Salesforce Contact object. Multiple contacts can be linked to a single wholesale account.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`address` (
    `address_id` BIGINT COMMENT 'Unique surrogate identifier for each address record in the customer domain. Serves as the primary key for the address data product across B2C and B2B entities.',
    `profile_id` BIGINT COMMENT 'Reference to the customer (B2C consumer or B2B wholesale account) who owns this address. Links the address to the parent customer profile in the CRM and Adobe Experience Platform.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Address table is described as serving both B2C profiles and B2B wholesale accounts. Currently only has profile_id FK for B2C. Adding wholesale_account_id enables B2B address management. An address b',
    `address_source` STRING COMMENT 'The originating channel or system through which this address was captured. Supports data lineage tracking and quality scoring. EDI-sourced addresses originate from wholesale partner Electronic Data Interchange transactions; POS addresses from SAP Customer Activity Repository in-store capture. [ENUM-REF-CANDIDATE: ecommerce|pos|crm|edi|manual|import|wholesale_portal — 7 candidates stripped; promote to reference product]',
    `address_type` STRING COMMENT 'Functional classification of the address indicating its business purpose. Billing addresses are used for invoicing and payment processing; shipping addresses for DTC order fulfillment and wholesale delivery routing; store_pickup for BOPIS (Buy Online Pick Up In Store) orders; warehouse for distribution center addresses; return for RTV (Return to Vendor) and consumer return processing.. Valid values are `billing|shipping|store_pickup|warehouse|return`',
    `carrier_route_code` STRING COMMENT 'USPS carrier route code assigned to the address, identifying the specific mail carrier delivery route. Used for bulk mail rate optimization, direct mail marketing campaigns, and last-mile delivery planning.',
    `city` STRING COMMENT 'City, town, or municipality name of the address. Used in order routing, tax jurisdiction determination, and geographic sales analytics for retail store operations and DTC e-commerce.',
    `country_code` STRING COMMENT 'Two-letter ISO 3166-1 Alpha-2 country code for the address (e.g., US, GB, DE, JP). Used for international shipping routing, customs documentation, HS Code determination, LDP (Landed Duty Paid) cost calculation, and GSP (Generalized System of Preferences) eligibility.. Valid values are `^[A-Z]{2}$`',
    `country_name` STRING COMMENT 'Full English name of the country corresponding to the country_code. Stored for display and reporting purposes to avoid repeated lookups against reference data.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the address record was first created in the system. Supports data lineage, GDPR data subject access requests, and audit trail requirements. Sourced from Adobe Experience Platform or Salesforce CRM upon initial capture.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite quality score (0.00–100.00) assigned to the address record based on validation status, standardization, geocoding accuracy, and completeness. Used to prioritize address cleansing campaigns and filter high-confidence addresses for marketing and fulfillment operations.',
    `delivery_instructions` STRING COMMENT 'Free-text special instructions for carriers and fulfillment teams regarding delivery at this address (e.g., Leave at reception, Dock 3 only, Requires appointment, Signature required). Passed to Manhattan Associates WMS and 3PL partners during shipment creation.',
    `district` STRING COMMENT 'Administrative district, county, or sub-regional area of the address. Used for tax jurisdiction determination (county-level sales tax), regional sales territory assignment, and wholesale distribution zone mapping.',
    `dpv_confirmation_code` STRING COMMENT 'USPS Delivery Point Validation (DPV) confirmation code indicating the deliverability of the address. Y = confirmed deliverable; S = confirmed with secondary number missing; D = confirmed primary but secondary not confirmed; N = not confirmed. Used to assess address quality and reduce undeliverable-as-addressed (UAA) mail.. Valid values are `Y|S|D|N`',
    `effective_from` DATE COMMENT 'Date from which this address record is considered valid and active for business use. Supports bi-temporal data modeling for address history tracking, enabling accurate reconstruction of customer address state at any point in time for order dispute resolution and compliance.',
    `effective_until` DATE COMMENT 'Date until which this address record is valid. Null indicates the address is currently active with no planned expiry. Used for managing temporary addresses (e.g., seasonal warehouse locations, pop-up store addresses) and tracking address change history.',
    `external_address_code` STRING COMMENT 'Address identifier from the originating source system (e.g., Salesforce Commerce Cloud address ID, SAP S/4HANA partner address number, Adobe Experience Platform profile address key). Enables cross-system reconciliation and deduplication during data integration.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the customer has provided explicit consent for the storage and processing of this address under GDPR Article 6 and CCPA requirements. Required for EU and California-resident customers. False triggers restricted processing workflows.',
    `geocoding_accuracy` STRING COMMENT 'Precision level of the geocoordinates assigned to this address. Rooftop indicates exact parcel-level accuracy; range_interpolated is street-level; geometric_center is centroid of a region; approximate is low-precision. Drives confidence scoring for proximity-based analytics and last-mile routing.. Valid values are `rooftop|range_interpolated|geometric_center|approximate|ungeocoded`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the address record is currently active and eligible for use in order processing, wholesale delivery routing, and marketing communications. Inactive addresses are retained for historical order reference and audit purposes.',
    `is_default_billing` BOOLEAN COMMENT 'Indicates whether this address is the customers default billing address used for invoice generation and payment processing. Only one address per customer should have this flag set to true at any given time.',
    `is_default_shipping` BOOLEAN COMMENT 'Indicates whether this address is the customers default shipping address for DTC order fulfillment. Pre-populated at checkout to streamline the purchase experience. Only one address per customer should have this flag set to true.',
    `label` STRING COMMENT 'Customer-assigned friendly label for the address (e.g., Home, Office, NYC Warehouse, LA Showroom). Displayed in the customers address book in the DTC e-commerce storefront and CRM to facilitate address selection at checkout.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the address in decimal degrees (WGS 84 datum). Used for store proximity searches, BOPIS (Buy Online Pick Up In Store) routing, last-mile delivery optimization, and geographic clustering in customer analytics.',
    `line1` STRING COMMENT 'Primary street address line including street number, street name, and directional indicators. Required field for all address records used in order fulfillment, wholesale delivery routing, and store operations.',
    `line2` STRING COMMENT 'Secondary address line for suite, apartment, unit, floor, building, or care-of information. Optional field used to capture additional location detail for B2C consumers and B2B wholesale accounts.',
    `line3` STRING COMMENT 'Tertiary address line used for international addresses requiring additional locality, district, or neighborhood detail. Primarily applicable for wholesale accounts in markets with complex addressing conventions.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the address in decimal degrees (WGS 84 datum). Used alongside latitude for geospatial analytics, delivery zone mapping, and proximity-based store operations reporting.',
    `phone` STRING COMMENT 'Contact phone number associated with this address, formatted per E.164 international standard. Used by carriers for delivery notifications, failed delivery callbacks, and customs clearance contact for international wholesale shipments.. Valid values are `^+?[1-9]d{1,14}$`',
    `po_box_flag` BOOLEAN COMMENT 'Indicates whether the address is a Post Office (PO) Box. PO Box addresses are ineligible for certain carrier services (e.g., UPS, FedEx ground) and require USPS routing. Used in carrier selection logic during order fulfillment.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the address. Used for carrier rate calculation, delivery zone assignment, tax jurisdiction mapping, and geographic segmentation in marketing analytics.',
    `recipient_name` STRING COMMENT 'Full name of the individual or business entity designated to receive deliveries at this address. May differ from the account holder name for gift shipments, B2B receiving departments, or wholesale distribution contacts.',
    `residential_flag` BOOLEAN COMMENT 'Indicates whether the address is classified as residential (True) or commercial/business (False). Carrier surcharges differ between residential and commercial deliveries; this flag drives accurate shipping cost calculation and carrier rate shopping.',
    `standardized_flag` BOOLEAN COMMENT 'Indicates whether the address has been standardized to postal authority format (e.g., USPS CASS normalization, Canada Post, Royal Mail PAF). Standardized addresses improve carrier label accuracy and reduce failed delivery rates.',
    `state_province` STRING COMMENT 'State, province, or region code of the address using ISO 3166-2 subdivision codes (e.g., CA, NY, ON, NSW). Used for tax calculation, shipping zone determination, and regulatory compliance reporting.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction identifier assigned to this address for sales tax calculation purposes. Used in SAP S/4HANA FI/CO and integrated tax engines (e.g., Vertex, Avalara) to determine applicable state, county, and municipal tax rates for DTC and wholesale transactions.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the address location (e.g., America/New_York, Europe/London). Used for scheduling delivery windows, store pickup time slots, and localizing customer communications in marketing campaigns.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the address record was last modified. Used to detect stale addresses requiring re-validation, support incremental data loads in the Databricks Lakehouse Silver Layer, and comply with GDPR data accuracy obligations.',
    `validation_provider` STRING COMMENT 'Name of the third-party address validation service used to verify this address (e.g., USPS CASS, SmartyStreets, Loqate, Google Maps API). Supports audit trails for address quality management and vendor SLA (Service Level Agreement) tracking.',
    `validation_status` STRING COMMENT 'Current validation state of the address record as determined by address verification services (e.g., USPS CASS, SmartyStreets, Loqate). Validated addresses reduce failed deliveries and carrier surcharges. Invalid addresses are flagged for customer outreach before order fulfillment.. Valid values are `validated|unvalidated|invalid|corrected|pending`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the address was last validated by the address verification service. Used to determine if re-validation is required based on data freshness policies and carrier compliance requirements.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Standardized address records for both B2C profiles and B2B wholesale accounts. Captures address type (billing, shipping, store, warehouse), street lines, city, state/province, postal code, country ISO code, geocoordinates, address validation status, and default flag. Supports multi-address per customer for DTC shipping, store pickup, and wholesale delivery routing.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` (
    `loyalty_program_id` BIGINT COMMENT 'Unique system-generated identifier for the loyalty program record. Serves as the primary key for all downstream enrollment, tier, and points tracking references.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each loyalty program has a dedicated cost center for budget ownership and program administration cost tracking. Apparel finance teams require program-level cost center attribution for annual budgeting',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: loyalty_program has eligible_customer_segment (STRING) defining which segment can enroll. Normalizing to FK enables referential integrity for program eligibility rules. Note: This is a simplified 1:N ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Apparel loyalty programs frequently operate Partner Earn Programs where customers earn points through co-branded vendor partnerships (e.g., co-branded credit cards, partner retail earn). The loyalty_p',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Under IFRS 15 / ASC 606, loyalty points represent deferred revenue liability posted to a specific GL account. Apparel retailers must link each loyalty program to its GL account for points liability ac',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Loyalty program revenue (enrollment fees, partner earn commissions) and costs (redemption liability, program administration) are tracked against a profit center for program-level P&L. Apparel retailer',
    `annual_fee` DECIMAL(18,2) COMMENT 'Recurring annual fee charged to maintain active membership in the loyalty program. A value of 0.00 indicates no annual fee. Used for subscription-based program revenue recognition.',
    `birthday_bonus_points` DECIMAL(18,2) COMMENT 'Number of bonus loyalty points awarded to a member during their birthday month or on their birthday date as a program benefit. A value of 0 indicates no birthday bonus.',
    `ccpa_opt_out_supported` BOOLEAN COMMENT 'Indicates whether this loyalty program supports the California Consumer Privacy Act (CCPA) right to opt out of the sale of personal information, applicable to members in California.',
    `cltv_segment_eligible` BOOLEAN COMMENT 'Indicates whether members enrolled in this program are included in Customer Lifetime Value (CLTV) segmentation models run through Adobe Experience Platform for personalization and targeted marketing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this loyalty program record was first created in the data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which monetary thresholds, rewards values, and redemption amounts for this program are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `eligible_country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes identifying the geographic markets where this loyalty program is available for enrollment (e.g., USA,CAN,GBR). Null indicates global availability.',
    `end_date` DATE COMMENT 'Calendar date on which the loyalty program is scheduled to close or was retired. Null for open-ended programs. Used to manage program sunset communications and enrollment cutoffs.',
    `enrollment_fee` DECIMAL(18,2) COMMENT 'One-time fee charged to a customer upon joining the loyalty program. A value of 0.00 indicates the program is free to join. Applicable primarily to subscription-type programs.',
    `gdpr_consent_required` BOOLEAN COMMENT 'Indicates whether explicit GDPR consent must be captured from members at enrollment for this program, applicable to programs operating in EU jurisdictions. Drives consent management workflows.',
    `is_dtc_eligible` BOOLEAN COMMENT 'Indicates whether members can earn and redeem points through the Direct-to-Consumer (DTC) channel, including brand-owned retail stores and owned digital storefronts.',
    `is_ecommerce_eligible` BOOLEAN COMMENT 'Indicates whether members can earn and redeem points through the e-commerce channel, including the brands online store and digital marketplace integrations.',
    `is_partner_earn_eligible` BOOLEAN COMMENT 'Indicates whether members can earn loyalty points through purchases or activities with third-party partner brands or co-branded programs affiliated with Apparel Fashion.',
    `is_retail_store_eligible` BOOLEAN COMMENT 'Indicates whether members can earn and redeem points at physical retail store locations via POS transactions tracked through SAP Customer Activity Repository.',
    `is_wholesale_eligible` BOOLEAN COMMENT 'Indicates whether B2B wholesale account holders are eligible to participate in this loyalty program and earn rewards on wholesale purchase volumes.',
    `launch_date` DATE COMMENT 'Calendar date on which the loyalty program became publicly available and open for customer enrollment. Used for program age calculations and anniversary promotions.',
    `max_points_balance` DECIMAL(18,2) COMMENT 'Maximum cumulative points balance a member may hold at any time. Enforces program liability ceiling and prevents excessive point accumulation. Null indicates no cap.',
    `max_points_per_transaction` DECIMAL(18,2) COMMENT 'Cap on the number of loyalty points that can be earned in a single transaction. Prevents abuse of promotional multipliers and controls program liability exposure per event.',
    `nps_tracking_enabled` BOOLEAN COMMENT 'Indicates whether Net Promoter Score (NPS) surveys are triggered for members of this loyalty program to measure customer satisfaction and advocacy. Supports CRM and brand management analytics.',
    `personalization_enabled` BOOLEAN COMMENT 'Indicates whether Adobe Experience Platform personalization and AI-driven offer targeting is activated for members of this loyalty program, enabling tailored product recommendations and promotions.',
    `points_earning_rate` DECIMAL(18,2) COMMENT 'Base number of loyalty points awarded per unit of currency spent (e.g., 1.0000 point per USD spent). Tier-specific multipliers may override this base rate at the enrollment level.',
    `points_expiry_months` STRING COMMENT 'Number of months after which unspent loyalty points expire from a members account if no qualifying activity occurs. A value of 0 or null indicates points do not expire.',
    `points_expiry_policy` STRING COMMENT 'Rule governing when points expire: rolling resets the expiry window on each qualifying activity; fixed_anniversary expires points on the members enrollment anniversary; no_expiry means points never expire; calendar_year expires all points at year-end.. Valid values are `rolling|fixed_anniversary|no_expiry|calendar_year`',
    `points_monetary_value` DECIMAL(18,2) COMMENT 'Monetary value assigned to a single loyalty point at redemption (e.g., 0.010000 USD per point). Used to calculate reward discount amounts and program liability on the balance sheet.',
    `points_redemption_threshold` DECIMAL(18,2) COMMENT 'Minimum accumulated points balance a member must hold before they are eligible to redeem points for rewards or discounts. Enforces program economics and prevents micro-redemptions.',
    `program_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the loyalty program across all channels and systems (e.g., AF_REWARDS_2024). Used in EDI, CRM, and POS integrations as the canonical business identifier.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `program_description` STRING COMMENT 'Full marketing and operational description of the loyalty program, including its value proposition, key benefits, and eligibility criteria as communicated to customers and internal stakeholders.',
    `program_name` STRING COMMENT 'Human-readable marketing name of the loyalty program as presented to customers across DTC, retail, and e-commerce channels (e.g., Apparel Fashion Rewards).',
    `program_status` STRING COMMENT 'Current lifecycle state of the loyalty program. Active programs accept new enrollments and transactions; draft programs are in configuration; suspended programs are temporarily halted; retired programs are closed to new activity.. Valid values are `active|inactive|draft|suspended|retired`',
    `program_type` STRING COMMENT 'Classification of the loyalty program structure. Points-based programs award redeemable points per transaction; tiered programs unlock benefits at spend thresholds; cashback returns a percentage of spend; subscription requires a membership fee; hybrid combines multiple mechanics.. Valid values are `points_based|tiered|cashback|subscription|hybrid`',
    `redemption_increment` DECIMAL(18,2) COMMENT 'Minimum unit of points that can be redeemed in a single transaction (e.g., points must be redeemed in multiples of 100). Ensures redemption amounts align with reward value denominations.',
    `referral_bonus_points` DECIMAL(18,2) COMMENT 'Number of loyalty points awarded to an existing member when they successfully refer a new customer who enrolls in the program. Supports member acquisition through word-of-mouth incentives.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this loyalty program configuration was originated or is mastered (e.g., SFCC for Salesforce Commerce Cloud, AEP for Adobe Experience Platform).. Valid values are `SFCC|AEP|SAP_CRM|MANUAL`',
    `terms_effective_date` DATE COMMENT 'Date on which the current version of the loyalty program terms and conditions became legally effective. Members enrolled before this date may require re-consent notification.',
    `terms_version` STRING COMMENT 'Version identifier of the loyalty programs terms and conditions document currently in effect (e.g., v2.1). Used to track member consent to specific T&C versions and manage regulatory compliance.. Valid values are `^v[0-9]+.[0-9]+$`',
    `tier_count` STRING COMMENT 'Total number of distinct membership tiers defined within this loyalty program (e.g., 3 for Silver, Gold, Platinum). Drives tier configuration and progression rule setup.',
    `tier_qualification_metric` STRING COMMENT 'The primary metric used to determine a members tier eligibility and progression (e.g., cumulative spend amount, total points earned, number of transactions, or units purchased within the qualification period).. Valid values are `spend_amount|points_earned|transaction_count|units_purchased`',
    `tier_qualification_period_months` STRING COMMENT 'Rolling or fixed window in months over which a members qualifying activity is measured for tier assignment or maintenance (e.g., 12 months for annual tier review).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this loyalty program record in the data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection and incremental processing.',
    `welcome_bonus_points` DECIMAL(18,2) COMMENT 'Number of bonus loyalty points awarded to a new member upon successful enrollment in the program. A value of 0 indicates no welcome bonus is offered.',
    CONSTRAINT pk_loyalty_program PRIMARY KEY(`loyalty_program_id`)
) COMMENT 'Master definition of loyalty program tiers, rules, and configurations offered by Apparel Fashion. Captures program name, tier structure (e.g., Silver, Gold, Platinum), points earning rules, redemption thresholds, expiry policies, eligible channel flags (DTC, retail, e-commerce), program launch date, and program status. Serves as the reference template against which individual enrollments are tracked.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` (
    `loyalty_enrollment_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying each loyalty program enrollment record. One record per customer-program combination.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Loyalty enrollments are frequently driven by specific acquisition campaigns (sign-up bonuses, enrollment promotions). Essential for calculating campaign-specific CAC, measuring enrollment campaign eff',
    `associate_id` BIGINT COMMENT 'Foreign key linking to store.associate. Business justification: Loyalty enrollments in apparel retail are facilitated by store associates who earn incentives for enrollments. No associate FK exists on loyalty_enrollment. Associate enrollment attribution is require',
    `event_id` BIGINT COMMENT 'Foreign key linking to marketing.event. Business justification: Event-driven loyalty enrollment attribution: pop-ups, trunk shows, and brand events drive loyalty sign-ups. This FK attributes enrollments to the specific event for event ROI measurement, enrollment c',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to order.sales_order. Business justification: In apparel loyalty programs, enrollment is frequently triggered by a qualifying purchase. Linking enrollment to the originating sales_order supports enrollment attribution reporting, first-purchase lo',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program definition this enrollment belongs to (e.g., Rewards Club, VIP Program, Wholesale Partner Program).',
    `profile_id` BIGINT COMMENT 'Reference to the customer who is enrolled in the loyalty program. Links to the customer master record in the CRM/CDP.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to merchandising.promotion. Business justification: Promotional enrollment attribution: loyalty enrollments are frequently triggered by specific promotions (enroll and earn double points). Marketers and CRM analysts need to track which promotion drov',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store location where the customer enrolled, if the enrollment channel was in-store. Null for digital enrollments.',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to marketing.promo_code. Business justification: Loyalty enrollment welcome promo assignment: when a customer enrolls in a loyalty program, a welcome promo code is issued. This FK links the enrollment to the specific promo code for redemption tracki',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the member has exercised their California Consumer Privacy Act (CCPA) right to opt out of the sale or sharing of their personal information. Applicable to California-resident members.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this loyalty enrollment record was first created in the data platform. Supports audit trail, data lineage, and GDPR accountability requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary values recorded in this enrollment (e.g., tier qualification spend, reward monetary equivalents). Supports multi-currency loyalty programs.. Valid values are `^[A-Z]{3}$`',
    `data_retention_flag` BOOLEAN COMMENT 'Indicates whether this enrollment record is subject to a legal hold or data retention requirement that prevents deletion even after termination. Set by legal or compliance teams.',
    `enrollment_channel` STRING COMMENT 'The Direct-to-Consumer (DTC) or wholesale channel through which the customer enrolled in the loyalty program. Supports channel attribution and omnichannel analytics.. Valid values are `store|ecommerce|mobile_app|wholesale|call_center|partner`',
    `enrollment_date` DATE COMMENT 'Calendar date on which the customer formally enrolled in the loyalty program. Used for anniversary calculations, tenure segmentation, and cohort analysis.',
    `enrollment_number` STRING COMMENT 'Externally visible, human-readable enrollment reference number used in customer communications, receipts, and CRM lookups. Follows the format LYL-XXXXXXXXXX.. Valid values are `^LYL-[0-9]{10}$`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the loyalty enrollment. Active = earning and redeeming; Suspended = temporarily blocked; Terminated = permanently closed; Pending = awaiting verification; Frozen = points locked pending investigation.. Valid values are `active|suspended|terminated|pending|frozen`',
    `gdpr_consent_date` DATE COMMENT 'Date on which the member provided GDPR consent for loyalty data processing. Required for audit trail and regulatory compliance demonstration under GDPR Article 7(1).',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the member has provided explicit consent for personal data processing under GDPR Article 6 for loyalty program purposes. Mandatory for EU-resident members.',
    `last_activity_date` DATE COMMENT 'Date of the most recent qualifying loyalty activity (earn, redeem, or bonus event) by this member. Used to identify inactive members, trigger re-engagement campaigns, and enforce inactivity-based points expiry policies.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent purchase transaction that generated a loyalty points earn event. Distinct from last_activity_date which may include non-purchase activities such as profile updates or bonus events.',
    `lifetime_points_earned` DECIMAL(18,2) COMMENT 'Total cumulative points earned by the customer since enrollment inception, including all earn, bonus, and adjustment credits. Used for Customer Lifetime Value (CLTV) analysis and VIP qualification.',
    `lifetime_points_expired` DECIMAL(18,2) COMMENT 'Total cumulative points that have expired due to inactivity or program policy since enrollment inception. Used for program liability management and customer re-engagement targeting.',
    `lifetime_points_redeemed` DECIMAL(18,2) COMMENT 'Total cumulative points redeemed by the customer since enrollment inception. Used to measure program engagement and redemption rate analytics.',
    `member_card_number` STRING COMMENT 'Physical or virtual loyalty card number issued to the member. Used for in-store Point of Sale (POS) identification, RFID scanning, and customer service lookups. Classified as confidential PII identifier.',
    `member_card_type` STRING COMMENT 'Format of the loyalty card issued to the member. Physical = plastic card; Virtual = app-based barcode; RFID = contactless chip card; Digital Wallet = Apple/Google Wallet pass.. Valid values are `physical|virtual|rfid|digital_wallet`',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) survey response from this loyalty member, on a scale of 0-10. Used to segment promoters, passives, and detractors for loyalty program satisfaction analysis.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS survey response was captured for this loyalty member. Used to determine survey recency and schedule follow-up surveys.',
    `opt_in_email` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive loyalty-related email communications including points statements, tier upgrade notifications, and exclusive member offers.',
    `opt_in_push` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive mobile push notifications for loyalty events such as points earned, tier changes, and reward availability.',
    `opt_in_sms` BOOLEAN COMMENT 'Indicates whether the member has opted in to receive loyalty-related SMS/text message communications including points alerts and promotional offers.',
    `pending_points` DECIMAL(18,2) COMMENT 'Points earned from recent transactions that are not yet confirmed as redeemable, typically held during a return window or fraud review period before being credited to the redeemable balance.',
    `points_balance` DECIMAL(18,2) COMMENT 'Current redeemable points balance available to the customer for redemption against purchases, rewards, or experiences. Reflects all earned, redeemed, adjusted, and expired points.',
    `points_expiry_date` DATE COMMENT 'Date on which the current redeemable points balance (or the oldest tranche of points) will expire if no qualifying activity occurs. Drives expiry notification campaigns.',
    `referral_source_code` STRING COMMENT 'Campaign or referral code used at enrollment to attribute the sign-up to a specific marketing campaign, influencer, or existing member referral. Supports Customer Acquisition Cost (CAC) and campaign ROI analysis.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this enrollment was originated or last updated. AEP = Adobe Experience Platform; SFCC = Salesforce Commerce Cloud; SAP_CAR = SAP Customer Activity Repository; CRM = Salesforce CRM; MANUAL = manual entry.. Valid values are `AEP|SFCC|SAP_CAR|CRM|MANUAL`',
    `source_system_member_code` STRING COMMENT 'The member or enrollment identifier as recorded in the originating source system (e.g., AEP profile ID, Salesforce Contact ID). Used for cross-system reconciliation and data lineage tracing.',
    `termination_date` DATE COMMENT 'Date on which the loyalty enrollment was terminated or closed, either by customer request, program policy, or fraud investigation outcome. Null for active enrollments.',
    `termination_reason` STRING COMMENT 'Reason code explaining why the loyalty enrollment was terminated. Used for compliance reporting, program analytics, and customer win-back strategy.. Valid values are `customer_request|inactivity|fraud|program_closure|duplicate_account|deceased`',
    `tier_effective_date` DATE COMMENT 'Date on which the customers current tier status became effective. Used to calculate tier tenure and determine when the next tier review is due.',
    `tier_expiry_date` DATE COMMENT 'Date on which the customers current tier qualification expires and is subject to re-evaluation based on qualifying spend or activity. Null for lifetime tiers.',
    `tier_qualification_spend` DECIMAL(18,2) COMMENT 'Cumulative qualifying spend amount (in program currency) accumulated by the customer within the current tier qualification period. Compared against tier thresholds to determine tier status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this loyalty enrollment record was most recently modified in the data platform. Used for incremental data processing, change detection, and audit compliance.',
    CONSTRAINT pk_loyalty_enrollment PRIMARY KEY(`loyalty_enrollment_id`)
) COMMENT 'Tracks each customers active enrollment in a loyalty program including current tier status, points balance, and full transaction history of points movements. Captures enrollment date, current tier, tier qualification/expiry dates, lifetime points earned, redeemable balance, enrollment channel, and a ledger of all earn/redeem/adjust/expire/bonus events with timestamps, triggering references, and running balances. Provides complete loyalty lifecycle per customer.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Primary key for segment',
    `parent_segment_id` BIGINT COMMENT 'Self-referencing identifier pointing to a parent segment when this segment is a sub-segment or refinement of a broader segment hierarchy (e.g., High-Value Female Loyalists as a child of High-Value Loyalists). Supports hierarchical segment structures for nested targeting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Customer segments (VIP, wholesale tier, lifestyle) are mapped to profit centers for segment-level P&L reporting. Apparel finance teams analyze revenue, margin, and marketing spend by customer segment ',
    `age_band_max` STRING COMMENT 'Maximum age (in years) of the target demographic for this segment. Used in demographic segmentation to define the upper bound of the age range for personalization and marketing targeting.',
    `age_band_min` STRING COMMENT 'Minimum age (in years) of the target demographic for this segment. Used in demographic segmentation to define the lower bound of the age range for personalization and marketing targeting.',
    `campaign_budget_usd` DECIMAL(18,2) COMMENT 'Planned marketing spend budget allocated to campaigns targeting this segment, expressed in USD. Used for marketing financial planning in Anaplan and ROI measurement. Classified as confidential as it reflects internal budget allocation strategy.',
    `channel_scope` STRING COMMENT 'The commerce channel(s) this segment is scoped to. DTC (Direct-to-Consumer) covers owned e-commerce and retail stores; wholesale covers B2B accounts; omnichannel covers all channels. Drives channel-specific activation in Salesforce Commerce Cloud and SAP Customer Activity Repository.. Valid values are `dtc|wholesale|retail|omnichannel|ecommerce`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the Apparel Fashion data platform. Provides audit trail for data lineage and governance compliance.',
    `crm_sync_status` STRING COMMENT 'Current synchronization status of this segment to Salesforce CRM for campaign activation. Synced indicates the segment definition and membership are current in CRM; pending indicates a sync is queued; failed indicates a sync error requiring investigation.. Valid values are `synced|pending|failed|not_applicable`',
    `crm_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful synchronization of this segment to Salesforce CRM. Used to monitor data freshness and SLA compliance for campaign activation pipelines.',
    `customer_class` STRING COMMENT 'Indicates whether the segment targets B2C (individual consumers), B2B (wholesale accounts), household-level groupings, or enterprise partnerships. Drives different activation logic and CRM workflows in Salesforce and Adobe Experience Platform.. Valid values are `b2c|b2b|household|enterprise`',
    `data_consent_required` BOOLEAN COMMENT 'Indicates whether activation of this segment requires verified customer consent under GDPR or CCPA regulations. When true, only profiles with explicit consent records in Adobe Experience Platform may be included in segment activations.',
    `data_sensitivity_level` STRING COMMENT 'Data classification level assigned to this segment definition based on the sensitivity of its qualifying criteria and the customer data it processes. Restricted segments may involve sensitive demographic or behavioral data requiring heightened access controls per GDPR and CCPA.. Valid values are `public|internal|confidential|restricted`',
    `definition_criteria` STRING COMMENT 'Human-readable description of the business rules and logic used to qualify customers into this segment (e.g., Customers with 3+ purchases in last 90 days, AOV > $150, active loyalty member). Serves as the business specification for technical implementation in Adobe Experience Platform.',
    `definition_expression` STRING COMMENT 'Structured query expression or rule set (e.g., PQL — Profile Query Language from Adobe Experience Platform) that technically defines segment membership criteria. Enables automated re-evaluation and sync to CRM activation systems.',
    `effective_end_date` DATE COMMENT 'Date after which this segment definition expires and is no longer used for active targeting. Nullable for evergreen segments with no planned expiry. Supports time-bound campaign segments tied to seasonal promotions or collection launches.',
    `effective_start_date` DATE COMMENT 'Date from which this segment definition becomes active and eligible for campaign targeting and personalization activation. Supports seasonal and campaign-specific segment scheduling aligned with collection launches and promotional calendars.',
    `estimated_size` BIGINT COMMENT 'Estimated count of customer profiles qualifying for this segment at the last evaluation run. Used for campaign reach planning, budget allocation, and marketing ROI forecasting. Sourced from Adobe Experience Platform segment evaluation output.',
    `evaluation_frequency` STRING COMMENT 'How frequently the segment membership is re-evaluated and refreshed. Real-time segments update continuously via streaming; daily/weekly/monthly segments are refreshed on a scheduled batch cadence. Impacts campaign activation timeliness and system resource planning.. Valid values are `real_time|daily|weekly|monthly`',
    `evaluation_method` STRING COMMENT 'Method by which Adobe Experience Platform evaluates segment membership. Batch evaluation runs on a scheduled cadence; streaming evaluation updates membership in near-real-time as profile events occur; edge evaluation enables on-device personalization at the point of interaction.. Valid values are `batch|streaming|edge`',
    `gender_affinity` STRING COMMENT 'Gender affinity profile of the segment used for product assortment targeting, personalization, and marketing creative selection. Informs merchandising allocation and collection planning for gender-specific product lines.. Valid values are `male|female|unisex|non_binary|all`',
    `geographic_scope` STRING COMMENT 'Geographic market scope for this segment expressed as ISO 3166-1 alpha-3 country codes or region identifiers (e.g., USA, GBR, DEU). Supports geo-targeted campaign activation and regional merchandising decisions. Multiple values stored as comma-separated codes.',
    `lifecycle_stage` STRING COMMENT 'The customer lifecycle stage this segment targets. Acquisition segments target new prospects; activation targets first-time buyers; retention targets active loyal customers; reactivation targets declining customers; winback targets lapsed customers. Aligns with CRM and CLTV (Customer Lifetime Value) strategy.. Valid values are `acquisition|activation|retention|reactivation|winback`',
    `loyalty_program_linked` BOOLEAN COMMENT 'Indicates whether this segment is linked to a loyalty program tier or reward structure. Loyalty-linked segments receive differentiated offers, early access to collections, and exclusive promotions managed through Salesforce CRM.',
    `notes` STRING COMMENT 'Free-text field for business analysts and segment owners to capture contextual notes, assumptions, known limitations, or activation guidance for this segment. Supports knowledge transfer and operational documentation.',
    `nps_target_flag` BOOLEAN COMMENT 'Indicates whether this segment is designated as a target population for NPS (Net Promoter Score) survey distribution. NPS-targeted segments are used to measure customer satisfaction and brand loyalty across DTC and wholesale channels.',
    `owner_function` STRING COMMENT 'The business function responsible for defining, maintaining, and activating this segment. Marketing-owned segments drive campaign targeting; merchandising-owned segments inform assortment and OTB planning; CRM-owned segments support loyalty and NPS programs.. Valid values are `marketing|merchandising|crm|ecommerce|wholesale`',
    `owner_name` STRING COMMENT 'Full name of the individual business owner or manager accountable for this segments definition, quality, and activation. Supports data stewardship and governance workflows.',
    `personalization_use_case` STRING COMMENT 'Primary personalization or activation use case this segment supports (e.g., Email re-engagement campaign, Homepage product recommendation, Loyalty tier upgrade offer, Wholesale reorder reminder). Guides campaign brief creation and Adobe Experience Platform activation configuration.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking of this segment relative to other segments within the same owner function or campaign cycle. Lower numbers indicate higher priority. Used to resolve conflicts when a customer qualifies for multiple segments and to sequence campaign activation.',
    `rfm_tier` STRING COMMENT 'RFM (Recency, Frequency, Monetary) classification tier assigned to this segment when segment_type is rfm. Champions are highest-value active buyers; loyal are consistent purchasers; at_risk are declining in engagement; lapsed have not purchased recently; prospects are new or low-activity customers.. Valid values are `champions|loyal|at_risk|lapsed|prospects`',
    `season_code` STRING COMMENT 'Apparel season code associated with this segment when the segment is scoped to a specific merchandise season (e.g., SS2025 for Spring/Summer 2025, FW2024 for Fall/Winter 2024). Links segment activation to collection planning and merchandising calendars in Oracle Retail Merchandising System.. Valid values are `^[A-Z]{2}[0-9]{4}$`',
    `segment_code` STRING COMMENT 'Externally-known, human-readable business identifier for the segment (e.g., LOYAL_VIP_B2C, WHOLESALE_TIER1). Used as the stable reference key across Adobe Experience Platform, Salesforce CRM, and campaign activation systems.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `segment_name` STRING COMMENT 'Human-readable display name of the customer segment (e.g., High-Value Loyalists, Lapsed Wholesale Accounts, Gen-Z Streetwear Enthusiasts). Used in campaign briefs, merchandising plans, and personalization dashboards.',
    `segment_status` STRING COMMENT 'Current lifecycle state of the segment. Active segments are available for campaign targeting and personalization. Draft segments are under construction. Inactive segments are paused. Archived segments are retained for historical analysis but not used in live activations.. Valid values are `active|inactive|draft|archived`',
    `segment_type` STRING COMMENT 'Classification of the methodology used to define the segment. Behavioral segments are based on purchase/browse actions; demographic on age/gender/location; psychographic on lifestyle/values; RFM (Recency, Frequency, Monetary) on transactional scoring; channel_based on preferred shopping channel (DTC, wholesale, retail).. Valid values are `behavioral|demographic|psychographic|rfm|channel_based`',
    `size_last_evaluated_date` DATE COMMENT 'Date on which the segment membership count (estimated_size) was last computed by Adobe Experience Platform. Indicates data freshness for campaign planning and audience activation decisions.',
    `source_system` STRING COMMENT 'The operational system of record where this segment was originally created and is mastered. Adobe Experience Platform is the primary CDP for B2C segments; Salesforce CRM manages B2B wholesale account segments; Anaplan supports planning-driven segments; manual indicates analyst-defined segments.. Valid values are `adobe_experience_platform|salesforce_crm|anaplan|manual`',
    `source_system_segment_code` STRING COMMENT 'The native identifier of this segment in the originating source system (e.g., Adobe Experience Platform Segment GUID, Salesforce CRM Segment Record ID). Enables bidirectional traceability and sync reconciliation between the lakehouse and operational systems.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this segment is a suppression list used to exclude customers from specific campaigns or communications (e.g., recent purchasers suppressed from acquisition campaigns, opted-out customers). Critical for compliance with GDPR and CCPA opt-out requirements.',
    `tags_list` STRING COMMENT 'Comma-separated list of free-form business tags applied to this segment for discoverability, governance, and cross-functional search (e.g., loyalty,high-value,email-only,seasonal). Supports segment catalog management in Adobe Experience Platform and internal data governance portals.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this segment record, including definition changes, status updates, or ownership reassignments. Supports change tracking and data freshness monitoring.',
    `version_number` STRING COMMENT 'Monotonically incrementing version number tracking revisions to the segment definition criteria. Enables audit trail of definition changes and supports rollback to prior versions when segment performance degrades.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Defines named market segments used to classify B2C and B2B customers for personalization, merchandising, and marketing targeting. Captures segment name, segment type (behavioral, demographic, psychographic, RFM, channel-based), definition criteria, segment owner (marketing vs. merchandising), creation date, and active status. Segments are managed in Adobe Experience Platform and synced to CRM for campaign activation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`preference` (
    `preference_id` BIGINT COMMENT 'Unique system-generated identifier for each customer preference or measurement record. Serves as the primary key for the preference data product.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: preference table has personalization_segment (STRING) for tagging preferences with segment context. Normalizing to FK enables linking preference patterns to segment definitions and supports segment-ba',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: Customer preferences map to specific product categories in the merchandise hierarchy. Powers recommendation engines, personalized emails, and size/style suggestions. Replaces denormalized apparel_cate',
    `previous_preference_id` BIGINT COMMENT 'Self-referencing identifier pointing to the prior version of this preference record when it was superseded or updated. Enables preference history chaining and change tracking without a separate history table. Null for the initial version of a preference.',
    `profile_id` BIGINT COMMENT 'Reference to the customer whose preference or measurement this record describes. Links to the customer master profile in the CRM and Adobe Experience Platform.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Customer preferences in apparel are captured at specific stores during clienteling or fitting sessions. channel_of_capture exists as plain text but no store FK. Linking to retail_store supports store-',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Seasonal preference analytics: customer preferences are season-specific in fashion (e.g., SS25 color palette preferences vs. AW25). Merchandisers use seasonal preference data to validate assortment pl',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: The preference table is the SSOT for all customer preferences including communication channel, communication frequency, brand preferences, and sustainability preferences. Wholesale accounts (B2B buyer',
    `brand_name` STRING COMMENT 'The brand to which the preferred_brand_size or brand preference applies. Enables brand-specific size mapping and brand affinity tracking for personalization and assortment planning.',
    `channel_of_capture` STRING COMMENT 'The business channel through which this preference was captured or inferred. Supports omnichannel preference reconciliation and channel-specific personalization strategies. Distinct from source_system (technical system) — this represents the customer-facing channel. [ENUM-REF-CANDIDATE: ecommerce|retail_store|mobile_app|style_quiz|loyalty_portal|wholesale|call_center|social_commerce|pop_up_event — promote to reference product]',
    `color_palette` STRING COMMENT 'Customers preferred color palette or specific color preferences (e.g., neutrals, earth tones, navy,white,grey, bold primaries). Used to filter product recommendations and personalize marketing communications. May store comma-separated color values.',
    `communication_channel` STRING COMMENT 'Customers preferred channel for receiving marketing communications, personalized recommendations, and promotional offers. Drives omnichannel campaign orchestration in Adobe Experience Platform and Salesforce CRM. Null indicates no stated preference.. Valid values are `email|sms|push_notification|in_app|direct_mail|none`',
    `communication_frequency` STRING COMMENT 'Customers preferred frequency for receiving marketing and personalization communications. Used to govern outreach cadence in campaign management and suppress over-communication. Supports GDPR and CCPA consent management.. Valid values are `daily|weekly|biweekly|monthly|seasonal|never`',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level (0.00–100.00) indicating the reliability of this preference or measurement. Self-declared and body scan data typically score highest; behavioral inference scores reflect signal strength from purchase/browse history. Used by recommendation engines to weight preference inputs.',
    `consent_date` DATE COMMENT 'Date on which the customer provided consent for this preference data to be collected and used. Required for GDPR and CCPA audit trails. Null for preferences captured prior to consent framework implementation.',
    `consent_flag` BOOLEAN COMMENT 'Indicates whether the customer has provided explicit consent for this preference data to be collected, stored, and used for personalization purposes. Mandatory for GDPR and CCPA compliance. False values trigger suppression from personalization pipelines.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this preference record was first created in the system. Used for audit trails, GDPR data retention calculations, and preference lifecycle analytics.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite data quality score (0.00–100.00) for this preference record, reflecting completeness, recency, and source reliability. Used by recommendation engines to weight preference inputs and by data stewards to prioritize enrichment efforts.',
    `fit_preference` STRING COMMENT 'Customers preferred garment fit silhouette for the associated apparel category. Drives fit-based filtering in recommendation engines and reduces return rates by surfacing appropriately fitted products. [ENUM-REF-CANDIDATE: slim|regular|relaxed|oversized|athletic|tailored|skinny|straight|wide_leg — promote to reference product]. Valid values are `slim|regular|relaxed|oversized|athletic|tailored`',
    `inference_model_version` STRING COMMENT 'Version identifier of the AI/ML model used to infer this preference from behavioral data (e.g., style_affinity_v2.3, fit_inference_v1.1). Null for self-declared or manually assigned preferences. Supports model governance, A/B testing, and reproducibility audits.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this preference record is currently active and should be used by recommendation engines and personalization systems. Inactive records are retained for audit and historical analysis but excluded from real-time personalization.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this preference record, whether from customer self-service, behavioral re-inference, stylist update, or system refresh. Critical for staleness detection and preference freshness scoring in recommendation engines.',
    `locale` STRING COMMENT 'IETF BCP 47 locale code representing the language and regional context in which this preference was captured (e.g., en-US, fr-FR, de-DE). Ensures size system and communication preferences are interpreted in the correct regional context.. Valid values are `^[a-z]{2}-[A-Z]{2}$`',
    `material_preference` STRING COMMENT 'Customers preferred fabric or material types (e.g., organic cotton, merino wool, recycled polyester, linen). Supports sustainability-aligned personalization and allergy/sensitivity filtering. May store comma-separated material values.',
    `notes` STRING COMMENT 'Free-text notes added by a stylist, customer service agent, or automated system providing additional context about this preference (e.g., customer mentioned sensitivity to wool, measured during in-store fitting event). Supports qualitative enrichment of structured preference data.',
    `numeric_value` DECIMAL(18,2) COMMENT 'Parsed numeric representation of the preference value for body measurements and quantitative preferences (e.g., chest circumference 92.50, inseam 76.00, shoe size 10.5). Null for non-numeric preferences. Used by recommendation engines for size matching algorithms.',
    `occasion_preference` STRING COMMENT 'Customers preferred occasions or use cases for apparel (e.g., workwear, casual, formal, activewear, evening). Supports occasion-based product filtering and targeted collection recommendations. May store comma-separated occasion values.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this preference record was manually overridden by a stylist, customer service agent, or the customer themselves, superseding a previously inferred value. When true, the record takes precedence over behavioral inference for the same preference type.',
    `preference_category` STRING COMMENT 'High-level category classifying the type of preference or measurement captured. Drives segmentation and personalization routing in Adobe Experience Platform. [ENUM-REF-CANDIDATE: style|fit|color|size|brand|communication|sustainability|material|fragrance|occasion|price_range — promote to reference product]',
    `preference_status` STRING COMMENT 'Lifecycle status of this preference record. Active records are used in personalization; superseded records have been replaced by a newer version; expired records have passed their validity window; withdrawn records reflect customer opt-out; pending_verification awaits confirmation.. Valid values are `active|superseded|expired|withdrawn|pending_verification`',
    `preference_type` STRING COMMENT 'Specific type of preference or measurement within the category (e.g., neckline_style, waist_fit, chest_circumference_cm, preferred_color_palette, inseam_length_cm). Provides granular classification for recommendation engine targeting.',
    `preference_value` DECIMAL(18,2) COMMENT 'The actual value of the preference or measurement (e.g., slim fit, navy blue, 92.5, XL, Nike). For numeric measurements, this stores the string representation; numeric_value stores the parsed decimal. Supports both categorical and quantitative preference data.',
    `preferred_brand_size` STRING COMMENT 'Customers preferred size label as used by a specific brand for the associated apparel category (e.g., M, L, 32x30, 10.5). Captures brand-specific sizing conventions which differ from standardized measurements, enabling brand-aware size recommendations.',
    `price_range_preference` STRING COMMENT 'Customers preferred price tier for apparel purchases, aligned to the brands pricing architecture. Informs personalized product recommendations and promotional targeting. Derived from purchase history behavioral inference or self-declared via style profile.. Valid values are `budget|mid_range|premium|luxury`',
    `source_system` STRING COMMENT 'Operational system of record from which this preference was captured or inferred. Supports data lineage tracking and conflict resolution when the same preference type is captured from multiple systems. [ENUM-REF-CANDIDATE: adobe_experience_platform|salesforce_crm|salesforce_commerce_cloud|sap_car|in_store_scan|virtual_try_on_app|stylist_portal|mobile_app|web_portal — promote to reference product]',
    `source_type` STRING COMMENT 'Method by which this preference or measurement was captured. Drives confidence scoring and consent management. Self-declared data from customer profiles, behavioral inference from purchase/browse history, stylist-assigned from in-store consultations, in-store body scan from 3D measurement technology, virtual try-on from digital fitting tools.. Valid values are `self_declared|behavioral_inference|stylist_assigned|in_store_body_scan|virtual_try_on`',
    `style_affinity` STRING COMMENT 'Customers preferred aesthetic style or fashion archetype (e.g., minimalist, streetwear, classic, bohemian, athleisure). Captured via style quiz, behavioral inference from browse/purchase patterns, or stylist assessment. Feeds personalization and collection recommendation engines.',
    `sustainability_preference` BOOLEAN COMMENT 'Indicates whether the customer has expressed a preference for sustainably sourced, ethically produced, or eco-certified products. When true, recommendation engines prioritize GOTS-certified, BCI cotton, and OEKO-TEX certified products.',
    `unit_of_measure` STRING COMMENT 'Unit associated with the numeric preference value (e.g., cm for body measurements, in for imperial measurements, EU/UK/US for shoe sizing systems). Null for non-numeric or unitless preferences. [ENUM-REF-CANDIDATE: cm|in|mm|kg|lbs|EU|UK|US|JP — 9 candidates stripped; promote to reference product]',
    `valid_until` DATE COMMENT 'Date after which this preference record expires and should no longer be applied in personalization. Null indicates an open-ended preference with no expiry. Supports seasonal preference windows and time-limited style profiles.',
    `valid_from` DATE COMMENT 'Date from which this preference record is considered valid and applicable for personalization. Supports temporal preference management, enabling seasonal or time-bounded preferences (e.g., summer color preferences).',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'SSOT for all explicit and inferred customer preferences, body measurements, and size profiles across apparel categories. Captures style affinities, fit preferences, color palettes, brand preferences, communication channel preferences, and detailed size/measurement data per category (tops, bottoms, outerwear, footwear, accessories). For each preference or measurement: records type, source (self-declared, behavioral inference, stylist-assigned, in-store body scan, virtual try-on), value with units, preferred brand size per category, confidence level, and last updated timestamp. Consolidates all personalization and fit inputs to feed recommendation engines, enable size/fit personalization, and reduce return rates in Adobe Experience Platform.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`consent` (
    `consent_id` BIGINT COMMENT 'Primary key for consent',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: GDPR and CCPA regulations apply to individual persons, including B2B contact persons at wholesale accounts. Individual contacts must provide consent for email marketing, data processing, and communica',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: consent table has customer_segment_code (STRING) for compliance reporting and segmentation. Normalizing to FK enables tracking which segments have specific consent patterns and supports segment-level ',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program associated with this consent record, where consent was captured as part of a loyalty enrollment or re-enrollment process. Links to the loyalty program master in the customer domain.',
    `parent_consent_record_consent_id` BIGINT COMMENT 'Self-referencing identifier linking this consent record to a prior version or parent consent record. Enables full consent history lineage tracking when a customer updates or re-grants consent under a new policy version.',
    `profile_id` BIGINT COMMENT 'Reference to the customer whose consent is being recorded. Links to the master customer profile managed in Adobe Experience Platform (AEP) and Salesforce CRM.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: GDPR/CCPA consent records in apparel retail are frequently captured at POS or in-store enrollment. collection_channel exists as plain text but no store FK. Store-level consent audit trails are a regul',
    `sales_order_id` BIGINT COMMENT 'Reference to the order transaction during which this consent was captured (e.g., checkout opt-in for marketing emails). Links to the order transaction in the order domain. Null if consent was not captured in the context of a purchase.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: GDPR and CCPA compliance applies to B2B wholesale accounts as well as B2C profiles. Wholesale accounts must provide consent for data processing, marketing communications, and third-party data sharing.',
    `collection_channel` STRING COMMENT 'The touchpoint or channel through which the customers consent was collected. Supports omnichannel compliance tracking across DTC e-commerce (Salesforce Commerce Cloud), POS (SAP CAR), in-store, and wholesale portals. [ENUM-REF-CANDIDATE: web|mobile_app|pos|email|sms|call_center|in_store_kiosk|wholesale_portal — promote to reference product]',
    `consent_method` STRING COMMENT 'The mechanism by which consent was obtained. Explicit = active affirmative action by the customer; Implicit = inferred from behavior; Pre-ticked = checkbox pre-selected (non-compliant under GDPR); Opt-out = consent assumed unless declined.. Valid values are `explicit|implicit|pre_ticked|opt_out`',
    `consent_status` STRING COMMENT 'Current lifecycle state of the consent record indicating whether the customer has actively granted, withdrawn, or has a pending or expired consent for the specified consent type.. Valid values are `granted|withdrawn|pending|expired`',
    `consent_type` STRING COMMENT 'The category of consent being captured, indicating the specific processing activity or communication channel for which the customer is granting or withdrawing permission. Covers marketing email, SMS, push notification, data sharing, profiling, and cookies.. Valid values are `marketing_email|sms|push_notification|data_sharing|profiling|cookies`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country of the customer at the time of consent. Determines the applicable regulatory jurisdiction and consent requirements (e.g., GDPR for EU countries, CCPA for USA-California).. Valid values are `^[A-Z]{3}$`',
    `data_subject_age_verified_flag` BOOLEAN COMMENT 'Indicates whether the customers age was verified prior to consent capture to ensure compliance with child data protection requirements (e.g., GDPR Article 8 requires parental consent for children under 16). True = age verified; False = not verified.',
    `device_type` STRING COMMENT 'The category of device used by the customer when providing consent. Supports channel analytics and helps identify consent collection patterns across DTC digital touchpoints and in-store POS terminals.. Valid values are `desktop|mobile|tablet|kiosk|pos_terminal|other`',
    `double_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the customer completed a double opt-in verification process (e.g., email confirmation link clicked) to confirm their consent. True = double opt-in confirmed; False = single opt-in only. Relevant for marketing email compliance.',
    `double_opt_in_timestamp` TIMESTAMP COMMENT 'The exact date and time when the customer completed the double opt-in verification step. Null if double opt-in was not required or not completed. Supports email marketing compliance audit trails.',
    `effective_from_date` DATE COMMENT 'The date from which this consent record is considered active and enforceable. May differ from the granted timestamp if consent is scheduled to take effect at a future date (e.g., post-enrollment cooling-off period).',
    `expiry_date` DATE COMMENT 'The date on which the consent record expires and must be re-obtained from the customer. Used to enforce time-limited consent policies and trigger re-consent workflows in Adobe Experience Platform.',
    `granted_timestamp` TIMESTAMP COMMENT 'The exact date and time (with timezone offset) when the customer actively granted consent. This is the principal business event timestamp for the consent record and is mandatory for GDPR and CCPA audit trails.',
    `ip_address` STRING COMMENT 'The IP address of the device from which the customer submitted their consent. Captured at the moment of consent for regulatory audit purposes. May be considered PII under GDPR in certain jurisdictions.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this consent record is the current active version for the customer and consent type combination. True = this is the authoritative current record; False = superseded by a newer consent record. Supports efficient querying of current consent state without full history traversal.',
    `legal_basis` STRING COMMENT 'The lawful basis under which customer data is being processed, as required by GDPR Article 6. Consent is one of six possible legal bases. Mandatory for GDPR compliance documentation and DPA audit responses.. Valid values are `consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task`',
    `locale_code` STRING COMMENT 'The IETF BCP 47 locale code (e.g., en-US, fr-FR, de-DE) representing the language and region in which the consent notice was presented to the customer. Ensures the customer received consent information in their preferred language.. Valid values are `^[a-z]{2}-[A-Z]{2}$`',
    `notice_url` STRING COMMENT 'The URL of the privacy notice, cookie policy, or consent form that was presented to the customer at the time of consent capture. Provides an auditable link to the exact disclosure document shown.. Valid values are `^https?://.+`',
    `nps_eligible_flag` BOOLEAN COMMENT 'Indicates whether the customer has consented to receiving Net Promoter Score (NPS) survey invitations. Derived from the consent record for survey/feedback consent type. Used by the CRM and customer experience teams to build eligible NPS survey audiences.',
    `parental_consent_flag` BOOLEAN COMMENT 'Indicates whether parental or guardian consent was obtained on behalf of a minor customer. Required under GDPR Article 8 for data subjects under the age of digital consent in the applicable jurisdiction.',
    `personalization_eligible_flag` BOOLEAN COMMENT 'Indicates whether the customer has consented to data-driven personalization of their shopping experience, including product recommendations and targeted content. Consumed by Adobe Experience Platform personalization workflows.',
    `preference_center_code` BIGINT COMMENT 'Reference to the preference center session or interaction through which the customer managed their consent preferences. Links to the preference management module in Adobe Experience Platform or Salesforce Marketing Cloud.',
    `proof_of_consent_reference` STRING COMMENT 'A reference identifier (e.g., document ID, audit log reference, or digital signature hash) pointing to the stored proof of consent artifact. Supports regulatory audit responses and dispute resolution under GDPR Article 7(1) burden-of-proof requirements.',
    `re_consent_required_flag` BOOLEAN COMMENT 'Indicates whether this consent record requires re-confirmation from the customer due to a policy change, expiry, or regulatory update. True = re-consent workflow must be triggered; False = consent is current and valid.',
    `re_consent_sent_timestamp` TIMESTAMP COMMENT 'The date and time when a re-consent request was dispatched to the customer via the applicable communication channel. Supports SLA tracking for re-consent campaigns and regulatory response timelines.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was first created in the Silver Layer lakehouse. Serves as the audit creation timestamp for data lineage and compliance reporting.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was last modified in the Silver Layer lakehouse. Tracks updates such as status changes, re-consent confirmations, or suppression flag updates.',
    `regulatory_jurisdiction` STRING COMMENT 'The applicable data privacy regulatory framework under which this consent record was captured. Determines the legal basis, retention rules, and customer rights applicable to this record. Supports multi-jurisdiction compliance for global apparel operations.. Valid values are `GDPR|CCPA|PIPEDA|LGPD|PDPA|OTHER`',
    `source_record_reference` STRING COMMENT 'The native identifier of this consent record in the originating source system (e.g., AEP consent event ID, Salesforce consent object ID). Enables traceability and reconciliation between the lakehouse Silver Layer and upstream operational systems.',
    `source_system` STRING COMMENT 'The operational system of record from which this consent record originated. Supports data lineage tracking across Adobe Experience Platform (AEP), Salesforce Commerce Cloud (SFCC), SAP Customer Activity Repository (SAP CAR), and Salesforce CRM.. Valid values are `AEP|SFCC|SAP_CAR|SALESFORCE_CRM|MANUAL|WHOLESALE_PORTAL`',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this customer is suppressed from the specific communication type associated with this consent record. True = customer must not receive communications of this type; False = communications are permitted. Enforced in Salesforce Marketing Cloud and Adobe Experience Platform.',
    `suppression_reason` STRING COMMENT 'The reason why a customer has been suppressed from communications of this consent type. Supports compliance reporting and operational triage for marketing and CRM teams. [ENUM-REF-CANDIDATE: customer_request|regulatory_requirement|bounce|complaint|deceased|fraud|other — 7 candidates stripped; promote to reference product]',
    `text_snapshot` STRING COMMENT 'A verbatim snapshot or hash reference of the consent language presented to the customer at the time of consent. Preserves the exact wording for regulatory audit and dispute resolution purposes.',
    `third_party_sharing_flag` BOOLEAN COMMENT 'Indicates whether the customer has consented to their data being shared with third-party partners (e.g., wholesale partners, affiliate marketers, analytics vendors). Critical for CCPA Do Not Sell compliance and GDPR data sharing agreements.',
    `user_agent` STRING COMMENT 'The browser or application user agent string captured at the time of consent submission for digital channels. Used for technical audit trails and device fingerprinting in compliance investigations.',
    `version` STRING COMMENT 'Version identifier of the consent notice, privacy policy, or terms and conditions document that was presented to the customer at the time of consent capture. Enables tracking of consent obtained under different policy versions.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `withdrawn_timestamp` TIMESTAMP COMMENT 'The exact date and time (with timezone offset) when the customer withdrew or revoked a previously granted consent. Null if consent has not been withdrawn. Required for GDPR right-to-withdraw audit compliance.',
    CONSTRAINT pk_consent PRIMARY KEY(`consent_id`)
) COMMENT 'Tracks customer consent and privacy preferences in compliance with GDPR and CCPA regulations. Captures consent type (marketing email, SMS, push notification, data sharing, profiling, cookies), consent status (granted, withdrawn, pending), consent timestamp, consent version, collection channel, IP address at time of consent, and regulatory jurisdiction. Mandatory for FTC and GDPR compliance across all customer touchpoints.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`service_request` (
    `service_request_id` BIGINT COMMENT 'Unique identifier for the customer service request case. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Service requests often relate to campaign-driven purchases (defective items, sizing issues from campaign promotions). Enables campaign quality analysis, post-purchase support cost attribution, and cam',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: For B2B service requests, the specific contact person (buyer, logistics manager, etc.) who filed the case must be tracked. service_request has contact_email and contact_phone as inline strings, but th',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service requests (returns, warranty claims, complaints) incur customer service costs that must be allocated to cost centers for departmental cost accounting, chargeback analysis to stores/channels, an',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Customer service refunds, goodwill credits, and warranty replacements require GL account attribution for financial posting. Apparel retailers post service-related financial adjustments (refund_amount ',
    `promo_code_id` BIGINT COMMENT 'Foreign key linking to marketing.promo_code. Business justification: Customer service recovery promo issuance: when resolving complaints or returns, associates issue goodwill promo codes. This FK links the service request to the issued promo code for cost tracking, pro',
    `associate_id` BIGINT COMMENT 'Foreign key linking to store.associate. Business justification: Service requests handled by store associates (in-store returns, complaints, styling consultations) require associate-level tracking for performance reviews, training needs identification, customer sat',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: Service requests and quality issues tracked by product category enable trend analysis (footwear sizing issues, outerwear zipper defects). Merchandising teams use this for vendor quality scorecards and',
    `profile_id` BIGINT COMMENT 'Identifier of the customer who submitted the service request. Links to the customer who initiated the case.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to merchandising.promotion. Business justification: Promotion dispute resolution: customer service agents handling complaints about unapplied discounts, incorrect promotional pricing, or coupon failures must reference the specific promotion. This is a ',
    `retail_store_id` BIGINT COMMENT 'Identifier of the retail store where the service request was initiated, if submitted in-store. Links to store operations entity.',
    `rma_id` BIGINT COMMENT 'Foreign key linking to order.rma. Business justification: Customer service tracks service cases related to returns. Links service requests to RMAs for return case management, resolution tracking, and customer satisfaction analysis on return-related issues.',
    `sales_order_id` BIGINT COMMENT 'Identifier of the order associated with this service request, if applicable. Used for order-related inquiries, returns, and exchanges.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Customer service requests for damaged, lost, or delayed items require direct reference to the specific shipment for carrier claims, insurance filing, and root cause analysis. Service teams need shipme',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Factory-level traceability for quality issues enables targeted corrective actions, factory-specific audits, and compliance remediation. Essential for apparel industry quality management systems, regul',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Quality complaints and product defects require tracing to the manufacturing vendor for root cause analysis, corrective action requests, and vendor scorecarding. Critical for vendor performance managem',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: service_request already has profile_id for B2C customer service cases. For B2B wholesale accounts, service requests (returns inquiries, exchange requests, product complaints) are filed against the who',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Quality complaint traceability: when a customer service request involves a defective garment, apparel-fashion operations must trace it to the originating work order for root cause analysis, supplier a',
    `assigned_team` STRING COMMENT 'Name or identifier of the customer service team responsible for handling this case type. Used for workload distribution and routing.',
    `case_number` STRING COMMENT 'Externally visible case number provided to the customer for tracking and reference purposes. Human-readable identifier.. Valid values are `^[A-Z0-9]{8,20}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the service request. Tracks progression from initial submission through resolution and closure.. Valid values are `open|in_progress|pending_customer|resolved|closed|cancelled`',
    `case_type` STRING COMMENT 'Classification of the service request type. Categorizes the nature of the customer inquiry or issue.. Valid values are `return|exchange|product_complaint|order_inquiry|loyalty_dispute|general_support`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was formally closed. May differ from resolved timestamp if additional administrative steps were required.',
    `contact_email` STRING COMMENT 'Email address used by the customer for this specific service request. May differ from primary customer email if submitted by alternate contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number used by the customer for this specific service request. Used for follow-up communication and case resolution.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country from which the service request originated. Used for regional routing and compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was initially created in the system. Represents the moment the customer issue was logged.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any monetary amounts associated with this service request, such as refunds or credits.. Valid values are `^[A-Z]{3}$`',
    `customer_satisfaction_score` STRING COMMENT 'Customer satisfaction rating provided by the customer after case resolution. Typically on a scale of 1-5 or 1-10.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator of whether this service request was escalated to a higher support tier or management. True if escalation occurred.',
    `escalation_reason` STRING COMMENT 'Explanation of why the service request was escalated. Captures business justification for escalation to higher support tiers.',
    `first_response_timestamp` TIMESTAMP COMMENT 'Date and time when the first response was provided to the customer by a service agent. Used for Service Level Agreement (SLA) tracking.',
    `internal_notes` STRING COMMENT 'Internal notes and comments visible only to service agents and management. Contains sensitive operational details not shared with customers.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the service request was submitted and should be handled.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service request record was last updated. Tracks most recent activity or status change.',
    `loyalty_points_adjustment` STRING COMMENT 'Number of loyalty program points added or deducted as part of the service request resolution. Positive for credits, negative for deductions.',
    `nps_score` STRING COMMENT 'Net Promoter Score provided by the customer indicating likelihood to recommend the brand. Scale of 0-10 where 9-10 are promoters, 7-8 passive, 0-6 detractors.',
    `priority` STRING COMMENT 'Priority level assigned to the service request based on urgency and business impact. Determines Service Level Agreement (SLA) targets.. Valid values are `low|medium|high|critical`',
    `product_sku` STRING COMMENT 'Stock Keeping Unit identifier of the product related to this service request, if applicable. Used for product-specific complaints or inquiries.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded to the customer as part of the service request resolution, if applicable. Excludes currency code.',
    `resolution_category` STRING COMMENT 'Classification of how the service request was resolved. Used for analytics on resolution patterns and customer satisfaction drivers.. Valid values are `refund_issued|exchange_processed|replacement_sent|information_provided|escalated|no_action_required`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the actions taken and resolution provided to the customer. Captures final outcome and customer satisfaction details.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was marked as resolved. Indicates when the issue was addressed to customer satisfaction.',
    `service_request_description` STRING COMMENT 'Detailed description of the customer issue, inquiry, or complaint as initially reported. Captures full context of the service request.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator of whether the Service Level Agreement (SLA) target was breached for this case. True if response or resolution exceeded target timeframes.',
    `sla_target_resolution_hours` DECIMAL(18,2) COMMENT 'Target number of hours within which the case should be resolved based on case priority and Service Level Agreement (SLA) rules.',
    `sla_target_response_hours` DECIMAL(18,2) COMMENT 'Target number of hours within which the first response should be provided based on case priority and Service Level Agreement (SLA) rules.',
    `source_record_reference` STRING COMMENT 'Unique identifier of this service request in the source system. Used for data lineage and reconciliation with operational systems.',
    `source_system` STRING COMMENT 'Name or identifier of the system from which this service request record originated. Typically Salesforce Service Cloud or other Customer Relationship Management (CRM) platform.',
    `subject` STRING COMMENT 'Brief summary or title of the service request. Provides quick overview of the customer issue or inquiry.',
    `submission_channel` STRING COMMENT 'Channel through which the customer submitted the service request. Tracks customer contact preferences and channel effectiveness. [ENUM-REF-CANDIDATE: store|email|chat|phone|web|mobile_app|social_media — 7 candidates stripped; promote to reference product]',
    `survey_response_date` DATE COMMENT 'Date when the customer completed the satisfaction or Net Promoter Score (NPS) survey related to this service request.',
    CONSTRAINT pk_service_request PRIMARY KEY(`service_request_id`)
) COMMENT 'Tracks post-purchase customer service cases including returns inquiries, exchange requests, product complaints, order issues, loyalty disputes, and general support tickets. Captures case type, priority, status (open, in-progress, resolved, closed), channel of submission (store, email, chat, phone), assigned agent, resolution notes, resolution date, SLA breach flag, and linked order or return reference. Managed via Salesforce Service Cloud.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`payment_method` (
    `payment_method_id` BIGINT COMMENT 'Unique identifier for the payment method record. Primary key.',
    `address_id` BIGINT COMMENT 'Reference to the billing address associated with this payment method. Links to customer address record.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who owns this payment method. Links to the customer master record.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: payment_method stores tokenized payment instruments on file. The description says enabling one-click checkout and recurring billing. Wholesale accounts (B2B buyers) also have payment methods on file',
    `added_channel` STRING COMMENT 'The channel or interface through which the customer added this payment method (web storefront, mobile app, physical store, call center, API integration).. Valid values are `web|mobile_app|store|call_center|api`',
    `added_date` DATE COMMENT 'The date when the customer added this payment method to their account.',
    `auto_update_enabled` BOOLEAN COMMENT 'Flag indicating whether this payment method is enrolled in automatic card updater services that refresh expiry dates and card numbers when cards are reissued.',
    `bnpl_provider` STRING COMMENT 'The buy-now-pay-later service provider when payment_type is buy_now_pay_later (Klarna, Afterpay, Affirm, Sezzle, Zip, QuadPay). Null for non-BNPL payment types.. Valid values are `klarna|afterpay|affirm|sezzle|zip|quadpay`',
    `card_brand` STRING COMMENT 'The card network or brand (Visa, Mastercard, American Express, Discover, JCB, Diners Club). Null for non-card payment types.. Valid values are `visa|mastercard|amex|discover|jcb|diners_club`',
    `card_funding_type` STRING COMMENT 'The funding mechanism of the card (credit, debit, prepaid, charge card, or deferred debit). Null for non-card payment types.. Valid values are `credit|debit|prepaid|charge|deferred_debit`',
    `cardholder_name` STRING COMMENT 'The name of the cardholder as it appears on the payment instrument. Used for verification and display purposes.',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Flag indicating whether the customer has opted out of the sale or sharing of their payment method data under California Consumer Privacy Act (CCPA) requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment method record was first created in the data platform.',
    `data_retention_date` DATE COMMENT 'The date when this payment method record is scheduled for deletion or archival according to data retention policies and regulatory requirements.',
    `digital_wallet_type` STRING COMMENT 'The specific digital wallet provider when payment_type is digital_wallet (Apple Pay, Google Pay, PayPal, Samsung Pay, Venmo, Alipay, WeChat Pay). Null for non-wallet payment types. [ENUM-REF-CANDIDATE: apple_pay|google_pay|paypal|samsung_pay|venmo|alipay|wechat_pay — 7 candidates stripped; promote to reference product]',
    `expiry_month` STRING COMMENT 'The expiration month of the payment card (1-12). Null for non-expiring payment types.',
    `expiry_year` STRING COMMENT 'The expiration year of the payment card (four-digit year). Null for non-expiring payment types.',
    `failed_transaction_count` STRING COMMENT 'The total number of failed or declined transaction attempts using this payment method. High failure counts may trigger automatic suspension.',
    `fraud_check_date` DATE COMMENT 'The date when the most recent fraud risk assessment was performed on this payment method.',
    `fraud_score` DECIMAL(18,2) COMMENT 'A risk score (0.00 to 100.00) assigned by fraud detection systems indicating the likelihood that this payment method is associated with fraudulent activity. Higher scores indicate higher risk.',
    `gdpr_consent_date` DATE COMMENT 'The date when GDPR consent was obtained for storing and processing this payment method data.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Flag indicating whether the customer has provided explicit consent for storage and processing of this payment method data under GDPR requirements.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this is the customers default payment method for one-click checkout and recurring billing. Only one payment method per customer should be marked as default.',
    `issuing_bank` STRING COMMENT 'The name of the financial institution that issued the card or payment instrument. Derived from Bank Identification Number (BIN) lookup.',
    `issuing_country_code` STRING COMMENT 'The three-letter ISO country code of the country where the payment instrument was issued. Used for fraud detection and regional compliance.. Valid values are `^[A-Z]{3}$`',
    `last_four_digits` STRING COMMENT 'The last four digits of the card number or account number, used for customer identification and display purposes. PCI-DSS compliant truncated value.. Valid values are `^[0-9]{4}$`',
    `last_used_date` DATE COMMENT 'The date when this payment method was last successfully used for a transaction.',
    `nickname` STRING COMMENT 'Optional customer-defined nickname or label for this payment method to help identify it in their account (e.g., Work Visa, Personal Amex).',
    `payment_method_status` STRING COMMENT 'Current lifecycle status of the payment method. Active methods are available for transactions; expired methods have passed their expiry date; suspended methods are temporarily blocked; pending or failed verification indicates incomplete validation.. Valid values are `active|inactive|expired|suspended|pending_verification|failed_verification`',
    `payment_type` STRING COMMENT 'The category of payment instrument (credit card, debit card, digital wallet such as Apple Pay or Google Pay, gift card, buy-now-pay-later services such as Klarna or Afterpay, or store credit).. Valid values are `credit_card|debit_card|digital_wallet|gift_card|buy_now_pay_later|store_credit`',
    `pci_compliance_flag` BOOLEAN COMMENT 'Flag confirming that this payment method record complies with PCI-DSS requirements (no raw card data stored, only tokenized references).',
    `recurring_billing_enabled` BOOLEAN COMMENT 'Flag indicating whether this payment method is authorized for recurring billing or subscription charges without additional customer authentication.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this payment method in the source system, used for data lineage and reconciliation.',
    `source_system` STRING COMMENT 'The operational system that originated this payment method record (e.g., Salesforce Commerce Cloud, Adobe Experience Platform, internal payment gateway).',
    `three_d_secure_enrolled` BOOLEAN COMMENT 'Flag indicating whether this payment method is enrolled in 3D Secure authentication (Verified by Visa, Mastercard SecureCode, etc.) for enhanced transaction security.',
    `token` STRING COMMENT 'The tokenized reference to the actual payment instrument, provided by the payment gateway or tokenization service. No raw card data is stored. PCI-DSS compliant token.',
    `tokenization_provider` STRING COMMENT 'The name of the payment gateway or tokenization service that issued the token (e.g., Stripe, Adyen, Braintree, Salesforce Commerce Cloud Payment Gateway).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment method record was last modified in the data platform.',
    `usage_count` STRING COMMENT 'The total number of successful transactions processed using this payment method since it was added.',
    `verification_date` DATE COMMENT 'The date when the payment method was last verified or validation was attempted.',
    `verification_status` STRING COMMENT 'Indicates whether the payment method has been successfully verified through Address Verification Service (AVS), Card Verification Value (CVV) check, or other validation mechanisms.. Valid values are `verified|unverified|failed|pending`',
    CONSTRAINT pk_payment_method PRIMARY KEY(`payment_method_id`)
) COMMENT 'Stores tokenized payment instruments on file for a customer, enabling one-click checkout and recurring billing. Captures payment type (credit card, debit card, digital wallet, gift card, buy-now-pay-later), card brand, last four digits, expiry date, billing address reference, tokenization provider, default flag, and active status. PCI-DSS compliant — no raw card data stored; only tokenized references from Salesforce Commerce Cloud.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`size_profile` (
    `size_profile_id` BIGINT COMMENT 'Unique identifier for the customer size profile record. Primary key.',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: Size profiles are category-specific (tops vs bottoms vs footwear have different sizing systems). Essential for size recommendations, virtual try-on, and reducing returns. Replaces denormalized apparel',
    `profile_id` BIGINT COMMENT 'Reference to the customer who owns this size profile. Links to the customer master record.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Size profiles in apparel are captured at stores during fitting room sessions or associate-assisted fitting. measurement_source exists as plain text but no store FK. Linking to retail_store supports fi',
    `size_scale_id` BIGINT COMMENT 'Foreign key linking to product.size_scale. Business justification: A customers size profile measurements are captured against a specific size scale (US womens, EU mens, Asian kids). Fit recommendation engines and virtual try-on systems require knowing which size_',
    `body_shape_type` STRING COMMENT 'Optional classification of the customers body shape (e.g., athletic, pear, rectangle, hourglass, inverted_triangle). Used for advanced fit personalization and style recommendations.',
    `bra_band_size` STRING COMMENT 'Bra band size measurement (e.g., 32, 34, 36). Specific to womens intimate apparel and activewear.',
    `bra_cup_size` STRING COMMENT 'Bra cup size measurement (e.g., A, B, C, D, DD). Specific to womens intimate apparel and activewear.',
    `chest_measurement` DECIMAL(18,2) COMMENT 'Chest circumference measurement. Critical for tops, outerwear, and activewear sizing.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this size profile record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_source_system` STRING COMMENT 'The source system or platform from which this size profile data originated (e.g., Adobe Experience Platform, Salesforce Commerce Cloud, In-Store Kiosk, Mobile App).',
    `fit_preference` STRING COMMENT 'The customers preferred fit style for this apparel category. Influences product recommendations and helps reduce returns driven by fit dissatisfaction.. Valid values are `slim|regular|relaxed|oversized|athletic`',
    `foot_length_measurement` DECIMAL(18,2) COMMENT 'Foot length measurement from heel to toe. Critical for footwear sizing.',
    `foot_width_measurement` DECIMAL(18,2) COMMENT 'Foot width measurement at the widest point. Used for footwear width sizing (narrow, medium, wide).',
    `height` DECIMAL(18,2) COMMENT 'The customers height measurement. Critical for inseam, sleeve length, and overall garment length recommendations.',
    `height_unit` STRING COMMENT 'The unit in which height is expressed (inches, centimeters, or feet).. Valid values are `inches|centimeters|feet`',
    `hip_measurement` DECIMAL(18,2) COMMENT 'Hip circumference measurement. Critical for bottoms and activewear sizing, particularly for womens apparel.',
    `inseam_measurement` DECIMAL(18,2) COMMENT 'Inseam length measurement from crotch to ankle. Critical for pants and jeans sizing.',
    `is_primary_profile` BOOLEAN COMMENT 'Indicates whether this is the customers primary size profile used for default fit recommendations and personalization. Only one profile per customer should be marked as primary.',
    `last_verified_date` DATE COMMENT 'The date when the customer last verified or confirmed their size profile measurements. Used to prompt customers to update outdated profiles.',
    `measurement_date` DATE COMMENT 'The date when this measurement was captured or last updated. Body measurements can change over time; recent measurements are prioritized for fit recommendations.',
    `measurement_source` STRING COMMENT 'The method by which the measurement was captured. Self-reported measurements may be less accurate than professional scans or tailor measurements. Used to weight fit recommendations.. Valid values are `self_reported|in_store_scan|virtual_try_on|tailor_measured|size_quiz`',
    `measurement_type` STRING COMMENT 'The specific body measurement captured (e.g., chest, waist, hip, inseam, shoulder_width, foot_length, neck, sleeve_length, rise, thigh). Varies by apparel category.',
    `measurement_value` DECIMAL(18,2) COMMENT 'The numeric value of the body measurement. Precision supports fractional measurements for accurate fit personalization.',
    `neck_measurement` DECIMAL(18,2) COMMENT 'Neck circumference measurement. Critical for dress shirts, formal wear, and outerwear sizing.',
    `preferred_brand_size` STRING COMMENT 'The customers preferred size designation within the brands sizing system for this apparel category (e.g., M, L, 32x34, 10, 42EU). Complements body measurements for fit personalization.',
    `profile_completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage (0-100) indicating how complete this size profile is based on the number of measurements captured relative to the ideal set for the apparel category. Used to prompt customers to complete their profiles.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the size profile. Active profiles are used for fit recommendations; inactive profiles are retained but not applied; archived profiles are historical records.. Valid values are `active|inactive|archived`',
    `return_rate_impact_flag` BOOLEAN COMMENT 'Indicates whether this size profile has been effective in reducing the customers return rate for sizing-related issues. Used to measure the business impact of fit personalization.',
    `shoulder_width_measurement` DECIMAL(18,2) COMMENT 'Shoulder width measurement from shoulder point to shoulder point. Critical for tops, outerwear, and formal wear sizing.',
    `size_confidence_score` DECIMAL(18,2) COMMENT 'A calculated confidence score (0-100) indicating the reliability of this size profile based on measurement source, recency, and consistency with purchase history. Higher scores indicate more reliable fit recommendations.',
    `sleeve_length_measurement` DECIMAL(18,2) COMMENT 'Sleeve length measurement from shoulder to wrist. Critical for tops, outerwear, and formal wear sizing.',
    `stylist_notes` STRING COMMENT 'Optional free-text notes from personal stylists or store associates regarding the customers fit preferences, body shape considerations, or special sizing needs. Treated as confidential business data.',
    `unit_of_measure` STRING COMMENT 'The unit in which the measurement value is expressed. Supports both metric (centimeters) and imperial (inches) systems, as well as regional sizing standards (US, UK, EU) for footwear and ready-to-wear sizes.. Valid values are `inches|centimeters|US|UK|EU`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this size profile record was last modified. Used for audit trail and data synchronization.',
    `virtual_try_on_enabled` BOOLEAN COMMENT 'Indicates whether this size profile is enabled for virtual try-on experiences in the e-commerce platform. Requires sufficient measurement data and customer consent.',
    `waist_measurement` DECIMAL(18,2) COMMENT 'Waist circumference measurement. Critical for bottoms, activewear, and outerwear sizing.',
    `weight` DECIMAL(18,2) COMMENT 'The customers weight measurement. Optional field used for advanced fit modeling and size recommendations. Treated as confidential business data.',
    `weight_unit` STRING COMMENT 'The unit in which weight is expressed (pounds or kilograms).. Valid values are `pounds|kilograms`',
    CONSTRAINT pk_size_profile PRIMARY KEY(`size_profile_id`)
) COMMENT 'Stores a customers body measurements and size preferences across apparel categories (tops, bottoms, outerwear, footwear, accessories). Captures measurement type (chest, waist, hip, inseam, shoulder width, foot length), measurement value, unit of measure, measurement source (self-reported, in-store scan, virtual try-on), measurement date, and preferred brand size per category. Enables fit personalization and reduces return rates driven by sizing issues.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` (
    `segment_membership_id` BIGINT COMMENT 'Primary key for the segment_membership association',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the consumer profile record that is a member of the segment.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to the named market segment the profile is assigned to.',
    `assignment_date` TIMESTAMP COMMENT 'Timestamp when the consumer profile was first assigned or qualified into this segment. Sourced from detection phase relationship data.',
    `assignment_source` STRING COMMENT 'The system or process that triggered the segment assignment. Indicates whether membership was determined via batch evaluation, real-time streaming, or manual override in Adobe Experience Platform or Salesforce CRM. Sourced from detection phase relationship data.',
    `expiry_date` DATE COMMENT 'Date on which this segment membership expires or is scheduled for re-evaluation. Used for time-bounded segments (e.g., seasonal campaigns, promotional windows). Sourced from detection phase relationship data.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this segment membership is currently active. Set to FALSE when the profile no longer meets segment criteria or when the membership has expired. Sourced from detection phase relationship data.',
    `membership_score` DECIMAL(18,2) COMMENT 'Numeric score (0.0000 to 1.0000) indicating how strongly the consumer profile qualifies for this segment based on the segments definition criteria. Higher scores indicate stronger qualification. Sourced from detection phase relationship data.',
    CONSTRAINT pk_segment_membership PRIMARY KEY(`segment_membership_id`)
) COMMENT 'This association product represents the Membership relationship between a consumer profile and a named market segment. It captures the operational assignment of a profile to a segment as managed in Adobe Experience Platform and synced to Salesforce CRM. Each record links one profile to one segment and carries attributes that exist only in the context of that membership — including when the assignment occurred, how it was triggered, how strongly the profile qualifies, and whether the membership is currently active.. Existence Justification: In apparel fashion CDP/CRM operations (Adobe Experience Platform, Salesforce Marketing Cloud), segment membership is an explicitly managed operational concept: profiles are evaluated against segment criteria, assigned to segments, and removed when criteria are no longer met. A single consumer profile belongs to multiple segments simultaneously (e.g., High-Value Loyalist, Summer Campaign Target, Size-M Womens Activewear), and each segment contains thousands of profiles. The business actively creates, updates, and expires these memberships as part of campaign activation workflows — this is not derivable from transactional joins alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ADD CONSTRAINT `fk_customer_profile_merged_into_profile_id` FOREIGN KEY (`merged_into_profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ADD CONSTRAINT `fk_customer_wholesale_account_parent_account_wholesale_account_id` FOREIGN KEY (`parent_account_wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ADD CONSTRAINT `fk_customer_loyalty_program_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ADD CONSTRAINT `fk_customer_loyalty_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_parent_segment_id` FOREIGN KEY (`parent_segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_previous_preference_id` FOREIGN KEY (`previous_preference_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`preference`(`preference_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_parent_consent_record_consent_id` FOREIGN KEY (`parent_consent_record_consent_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`consent`(`consent_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ADD CONSTRAINT `fk_customer_consent_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_address_id` FOREIGN KEY (`address_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ADD CONSTRAINT `fk_customer_payment_method_wholesale_account_id` FOREIGN KEY (`wholesale_account_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`wholesale_account`(`wholesale_account_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ADD CONSTRAINT `fk_customer_size_profile_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` ADD CONSTRAINT `fk_customer_segment_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` ADD CONSTRAINT `fk_customer_segment_membership_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `apparel_fashion_ecm`.`customer`.`segment`(`segment_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `apparel_fashion_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Contact ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `contact_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `contact_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `merged_into_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Merged Into Profile ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `adobe_ecid` SET TAGS ('dbx_business_glossary_term' = 'Adobe Experience Cloud ID (ECID)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `adobe_ecid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `adobe_ecid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `country_of_residence` SET TAGS ('dbx_business_glossary_term' = 'Country of Residence');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `country_of_residence` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `customer_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `customer_type` SET TAGS ('dbx_value_regex' = 'b2c_consumer|b2b_wholesale|vip|employee|influencer|anonymous');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `data_retention_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Consent Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Email Marketing Opt-In');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name (Last Name)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Given Name (First Name)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `identity_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Identity Confidence Score');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `identity_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Resolution Method');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `identity_resolution_method` SET TAGS ('dbx_value_regex' = 'deterministic|probabilistic|hybrid|manual');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Identity Verified Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Card Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `loyalty_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Enrollment Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `loyalty_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Balance');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `pos_customer_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `pos_customer_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `pos_customer_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `preferred_shoe_size` SET TAGS ('dbx_business_glossary_term' = 'Preferred Shoe Size');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `preferred_size_bottom` SET TAGS ('dbx_business_glossary_term' = 'Preferred Bottom Size');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `preferred_size_top` SET TAGS ('dbx_business_glossary_term' = 'Preferred Top Size');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification|merged|deceased');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `push_notification_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source System');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'SMS Marketing Opt-In');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `parent_account_wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Wholesale Account ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|prospect|on_hold|terminated');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Tier');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `buying_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Buying Authority Level');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `buying_authority_level` SET TAGS ('dbx_value_regex' = 'full|limited|none');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number (Data Universal Numbering System)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `edi_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `edi_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Partner ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `moq_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Units');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Account Onboarding Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `preferred_comm_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `preferred_comm_channel` SET TAGS ('dbx_value_regex' = 'email|phone|edi|portal|in_person');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `primary_contact_department` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Department');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Job Title');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Account Relationship Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|at_risk|churned|new|strategic');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `rfid_enabled` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `sales_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name (DBA)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`wholesale_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `buying_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Buying Authority Level');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `buying_authority_level` SET TAGS ('dbx_value_regex' = 'none|limited|standard|senior|executive');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `ccpa_opt_out` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'buyer|merchandiser|finance|logistics|executive|other');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'salesforce|manual_entry|edi|web_form|import|adobe_aep');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Primary Email Address');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Email Marketing Opt-In Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `is_billing_contact` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `is_decision_maker` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `is_shipping_contact` SET TAGS ('dbx_business_glossary_term' = 'Shipping Contact Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Preferred Language Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_business_glossary_term' = 'Contact LinkedIn Profile URL');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_value_regex' = '^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing City');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Country Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mailing_street` SET TAGS ('dbx_business_glossary_term' = 'Contact Mailing Street Address');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mailing_street` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mailing_street` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `next_followup_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Business Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|video_call|in_person');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Relationship Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|prospect|lapsed|do_not_contact');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `salesforce_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Contact ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `salesforce_contact_code` SET TAGS ('dbx_value_regex' = '^003[a-zA-Z0-9]{15}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `salesforce_contact_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Mr.|Ms.|Mrs.|Dr.|Prof.');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `address_source` SET TAGS ('dbx_business_glossary_term' = 'Address Source Channel');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `address_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `address_source` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'billing|shipping|store_pickup|warehouse|return');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `carrier_route_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Route Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-2)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `country_name` SET TAGS ('dbx_business_glossary_term' = 'Country Name');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Address Data Quality Score');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `district` SET TAGS ('dbx_business_glossary_term' = 'District / County');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `dpv_confirmation_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Validation (DPV) Confirmation Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `dpv_confirmation_code` SET TAGS ('dbx_value_regex' = 'Y|S|D|N');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Address Effective From Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Until Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `external_address_code` SET TAGS ('dbx_business_glossary_term' = 'External Address ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `external_address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `external_address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Address Data Consent Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Accuracy Level');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_value_regex' = 'rooftop|range_interpolated|geometric_center|approximate|ungeocoded');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Address Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `is_default_billing` SET TAGS ('dbx_business_glossary_term' = 'Default Billing Address Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `is_default_shipping` SET TAGS ('dbx_business_glossary_term' = 'Default Shipping Address Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Address Label');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Geocoordinate)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Geocoordinate)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Address Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `po_box_flag` SET TAGS ('dbx_business_glossary_term' = 'PO Box Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `po_box_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `po_box_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `residential_flag` SET TAGS ('dbx_business_glossary_term' = 'Residential Address Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `standardized_flag` SET TAGS ('dbx_business_glossary_term' = 'Address Standardized Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State / Province');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Address Timezone');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `validation_provider` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Provider');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|invalid|corrected|pending');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` SET TAGS ('dbx_subdomain' = 'loyalty_engagement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Points Liability Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `annual_fee` SET TAGS ('dbx_business_glossary_term' = 'Annual Membership Fee');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Birthday Bonus Points');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `ccpa_opt_out_supported` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Supported');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `cltv_segment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Segment Eligible');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Program Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `eligible_country_codes` SET TAGS ('dbx_business_glossary_term' = 'Eligible Country Codes');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `enrollment_fee` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Fee');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `gdpr_consent_required` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Required');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `is_dtc_eligible` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Channel Eligible');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `is_ecommerce_eligible` SET TAGS ('dbx_business_glossary_term' = 'E-Commerce Channel Eligible');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `is_partner_earn_eligible` SET TAGS ('dbx_business_glossary_term' = 'Partner Earn Eligible');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `is_retail_store_eligible` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Channel Eligible');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `is_wholesale_eligible` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Channel Eligible');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Program Launch Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `max_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Maximum Points Balance');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `max_points_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Maximum Points Per Transaction');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `nps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Tracking Enabled');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `personalization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Personalization Enabled');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_earning_rate` SET TAGS ('dbx_business_glossary_term' = 'Points Earning Rate');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_expiry_months` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Period (Months)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Policy');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_value_regex' = 'rolling|fixed_anniversary|no_expiry|calendar_year');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Points Monetary Value');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `points_redemption_threshold` SET TAGS ('dbx_business_glossary_term' = 'Points Redemption Threshold');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Description');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Name');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|retired');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'points_based|tiered|cashback|subscription|hybrid');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `redemption_increment` SET TAGS ('dbx_business_glossary_term' = 'Redemption Increment');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `referral_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Referral Bonus Points');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SFCC|AEP|SAP_CRM|MANUAL');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `terms_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Terms Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `terms_version` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Version');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `terms_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_count` SET TAGS ('dbx_business_glossary_term' = 'Tier Count');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_qualification_metric` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Metric');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_qualification_metric` SET TAGS ('dbx_value_regex' = 'spend_amount|points_earned|transaction_count|units_purchased');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `tier_qualification_period_months` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Period (Months)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_program` ALTER COLUMN `welcome_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Welcome Bonus Points');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` SET TAGS ('dbx_subdomain' = 'loyalty_engagement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `loyalty_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Enrolling Associate Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Sales Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Store ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Welcome Promo Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Program Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `data_retention_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Hold Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Channel');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'store|ecommerce|mobile_app|wholesale|call_center|partner');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^LYL-[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|frozen');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Processing Consent Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Loyalty Activity Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Transaction Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `lifetime_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Earned');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `lifetime_points_expired` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Expired');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `lifetime_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Redeemed');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `member_card_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Card Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `member_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `member_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `member_card_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Card Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `member_card_type` SET TAGS ('dbx_value_regex' = 'physical|virtual|rfid|digital_wallet');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Marketing Opt-In Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_push` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Marketing Opt-In Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `pending_points` SET TAGS ('dbx_business_glossary_term' = 'Pending Points Balance');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `points_balance` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Balance');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `points_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `referral_source_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'AEP|SFCC|SAP_CAR|CRM|MANUAL');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Member ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `source_system_member_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Termination Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Termination Reason');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'customer_request|inactivity|fraud|program_closure|duplicate_account|deceased');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `tier_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `tier_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `tier_qualification_spend` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Spend');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`loyalty_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'loyalty_engagement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `parent_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Segment ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Age Band Maximum');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Age Band Minimum');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `campaign_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget (USD)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `campaign_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `channel_scope` SET TAGS ('dbx_value_regex' = 'dtc|wholesale|retail|omnichannel|ecommerce');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `crm_sync_status` SET TAGS ('dbx_business_glossary_term' = 'CRM Sync Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `crm_sync_status` SET TAGS ('dbx_value_regex' = 'synced|pending|failed|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `crm_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CRM Sync Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'b2c|b2b|household|enterprise');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `data_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Data Consent Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Data Sensitivity Level');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `definition_criteria` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Criteria');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `definition_expression` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Expression');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `estimated_size` SET TAGS ('dbx_business_glossary_term' = 'Estimated Segment Size');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Evaluation Frequency');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Segment Evaluation Method');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_value_regex' = 'batch|streaming|edge');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `gender_affinity` SET TAGS ('dbx_business_glossary_term' = 'Gender Affinity');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `gender_affinity` SET TAGS ('dbx_value_regex' = 'male|female|unisex|non_binary|all');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `gender_affinity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `gender_affinity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifecycle Stage');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'acquisition|activation|retention|reactivation|winback');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `loyalty_program_linked` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Linked Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Notes');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `nps_target_flag` SET TAGS ('dbx_business_glossary_term' = 'NPS (Net Promoter Score) Target Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `owner_function` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Function');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `owner_function` SET TAGS ('dbx_value_regex' = 'marketing|merchandising|crm|ecommerce|wholesale');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner Name');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `personalization_use_case` SET TAGS ('dbx_business_glossary_term' = 'Personalization Use Case');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority Rank');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `rfm_tier` SET TAGS ('dbx_business_glossary_term' = 'RFM (Recency Frequency Monetary) Tier');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `rfm_tier` SET TAGS ('dbx_value_regex' = 'champions|loyal|at_risk|lapsed|prospects');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'behavioral|demographic|psychographic|rfm|channel_based');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `size_last_evaluated_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Size Last Evaluated Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'adobe_experience_platform|salesforce_crm|anaplan|manual');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `source_system_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Segment ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `tags_list` SET TAGS ('dbx_business_glossary_term' = 'Segment Tags List');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Segment Version Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Preference ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `previous_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Preference Record ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `channel_of_capture` SET TAGS ('dbx_business_glossary_term' = 'Channel of Capture');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `color_palette` SET TAGS ('dbx_business_glossary_term' = 'Color Palette Preference');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|in_app|direct_mail|none');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `communication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Frequency');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `communication_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|seasonal|never');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Preference Confidence Score');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Consent Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Preference Data Consent Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `fit_preference` SET TAGS ('dbx_business_glossary_term' = 'Fit Preference');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `fit_preference` SET TAGS ('dbx_value_regex' = 'slim|regular|relaxed|oversized|athletic|tailored');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `inference_model_version` SET TAGS ('dbx_business_glossary_term' = 'Inference Model Version');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Preference Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}-[A-Z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `material_preference` SET TAGS ('dbx_business_glossary_term' = 'Material Preference');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `numeric_value` SET TAGS ('dbx_business_glossary_term' = 'Numeric Preference Value');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `occasion_preference` SET TAGS ('dbx_business_glossary_term' = 'Occasion Preference');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `preference_category` SET TAGS ('dbx_business_glossary_term' = 'Preference Category');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|superseded|expired|withdrawn|pending_verification');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `preference_type` SET TAGS ('dbx_business_glossary_term' = 'Preference Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `preference_value` SET TAGS ('dbx_business_glossary_term' = 'Preference Value');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `preferred_brand_size` SET TAGS ('dbx_business_glossary_term' = 'Preferred Brand Size');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `price_range_preference` SET TAGS ('dbx_business_glossary_term' = 'Price Range Preference');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `price_range_preference` SET TAGS ('dbx_value_regex' = 'budget|mid_range|premium|luxury');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Preference Source Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'self_declared|behavioral_inference|stylist_assigned|in_store_body_scan|virtual_try_on');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `style_affinity` SET TAGS ('dbx_business_glossary_term' = 'Style Affinity');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `sustainability_preference` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Preference Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Preference Valid Until Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`preference` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Preference Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` SET TAGS ('dbx_subdomain' = 'loyalty_engagement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Identifier');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `parent_consent_record_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Consent Record ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `collection_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Channel');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'explicit|implicit|pre_ticked|opt_out');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|expired');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing_email|sms|push_notification|data_sharing|profiling|cookies');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `data_subject_age_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Age Verified Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type at Consent');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk|pos_terminal|other');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `double_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `double_opt_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective From Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `granted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Granted Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address at Consent');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Consent Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `locale_code` SET TAGS ('dbx_business_glossary_term' = 'Locale Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `locale_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}-[A-Z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `notice_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Notice URL');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `notice_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `nps_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `parental_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `personalization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `preference_center_code` SET TAGS ('dbx_business_glossary_term' = 'Preference Center ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `proof_of_consent_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof of Consent Reference');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `re_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Consent Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `re_consent_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Re-Consent Request Sent Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|PIPEDA|LGPD|PDPA|OTHER');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'AEP|SFCC|SAP_CAR|SALESFORCE_CRM|MANUAL|WHOLESALE_PORTAL');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `text_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Consent Text Snapshot');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `third_party_sharing_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Data Sharing Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String at Consent');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`consent` ALTER COLUMN `withdrawn_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawn Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` SET TAGS ('dbx_subdomain' = 'loyalty_engagement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Goodwill Promo Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Associate Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `assigned_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_customer|resolved|closed|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'return|exchange|product_complaint|order_inquiry|loyalty_dispute|general_support');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `first_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `loyalty_points_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Adjustment');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `product_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `resolution_category` SET TAGS ('dbx_business_glossary_term' = 'Resolution Category');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `resolution_category` SET TAGS ('dbx_value_regex' = 'refund_issued|exchange_processed|replacement_sent|information_provided|escalated|no_action_required');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `service_request_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `sla_target_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Hours');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `sla_target_response_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Response Hours');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Case Subject');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`service_request` ALTER COLUMN `survey_response_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `added_channel` SET TAGS ('dbx_business_glossary_term' = 'Added Channel');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `added_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|store|call_center|api');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `added_date` SET TAGS ('dbx_business_glossary_term' = 'Added Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `auto_update_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Update Enabled');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `bnpl_provider` SET TAGS ('dbx_business_glossary_term' = 'Buy Now Pay Later (BNPL) Provider');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `bnpl_provider` SET TAGS ('dbx_value_regex' = 'klarna|afterpay|affirm|sezzle|zip|quadpay');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|diners_club');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `card_funding_type` SET TAGS ('dbx_business_glossary_term' = 'Card Funding Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `card_funding_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|charge|deferred_debit');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'CCPA Opt-Out Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `data_retention_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `digital_wallet_type` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Expiry Month');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Expiry Year');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `failed_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Transaction Count');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `fraud_check_date` SET TAGS ('dbx_business_glossary_term' = 'Fraud Check Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `issuing_bank` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Last Four Digits');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `nickname` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Nickname');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `payment_method_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `payment_method_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|pending_verification|failed_verification');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|digital_wallet|gift_card|buy_now_pay_later|store_credit');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `pci_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `recurring_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Recurring Billing Enabled');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `three_d_secure_enrolled` SET TAGS ('dbx_business_glossary_term' = '3D Secure (3DS) Enrolled');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'Payment Token');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `tokenization_provider` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Provider');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|failed|pending');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `size_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Size Profile Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `size_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Size Scale Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `body_shape_type` SET TAGS ('dbx_business_glossary_term' = 'Body Shape Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `bra_band_size` SET TAGS ('dbx_business_glossary_term' = 'Bra Band Size');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `bra_cup_size` SET TAGS ('dbx_business_glossary_term' = 'Bra Cup Size');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `chest_measurement` SET TAGS ('dbx_business_glossary_term' = 'Chest Measurement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `fit_preference` SET TAGS ('dbx_business_glossary_term' = 'Fit Preference');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `fit_preference` SET TAGS ('dbx_value_regex' = 'slim|regular|relaxed|oversized|athletic');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `foot_length_measurement` SET TAGS ('dbx_business_glossary_term' = 'Foot Length Measurement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `foot_width_measurement` SET TAGS ('dbx_business_glossary_term' = 'Foot Width Measurement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `height` SET TAGS ('dbx_business_glossary_term' = 'Customer Height');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `height_unit` SET TAGS ('dbx_business_glossary_term' = 'Height Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `height_unit` SET TAGS ('dbx_value_regex' = 'inches|centimeters|feet');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `hip_measurement` SET TAGS ('dbx_business_glossary_term' = 'Hip Measurement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `inseam_measurement` SET TAGS ('dbx_business_glossary_term' = 'Inseam Measurement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `is_primary_profile` SET TAGS ('dbx_business_glossary_term' = 'Primary Profile Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'self_reported|in_store_scan|virtual_try_on|tailor_measured|size_quiz');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `neck_measurement` SET TAGS ('dbx_business_glossary_term' = 'Neck Measurement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `preferred_brand_size` SET TAGS ('dbx_business_glossary_term' = 'Preferred Brand Size');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `profile_completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profile Completeness Percentage');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Size Profile Status');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `return_rate_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Rate Impact Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `shoulder_width_measurement` SET TAGS ('dbx_business_glossary_term' = 'Shoulder Width Measurement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `size_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Size Confidence Score');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `sleeve_length_measurement` SET TAGS ('dbx_business_glossary_term' = 'Sleeve Length Measurement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `stylist_notes` SET TAGS ('dbx_business_glossary_term' = 'Stylist Notes');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `stylist_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'inches|centimeters|US|UK|EU');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `virtual_try_on_enabled` SET TAGS ('dbx_business_glossary_term' = 'Virtual Try-On Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `waist_measurement` SET TAGS ('dbx_business_glossary_term' = 'Waist Measurement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Customer Weight');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `weight` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`size_profile` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'pounds|kilograms');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` SET TAGS ('dbx_subdomain' = 'loyalty_engagement');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` SET TAGS ('dbx_association_edges' = 'customer.profile,customer.segment');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` ALTER COLUMN `segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership - Segment Membership Id');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership - Profile Id');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership - Segment Id');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Membership Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`customer`.`segment_membership` ALTER COLUMN `membership_score` SET TAGS ('dbx_business_glossary_term' = 'Membership Score');
