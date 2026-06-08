-- Schema for Domain: partner | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`partner` COMMENT 'SSOT for all third-party partner and vendor relationships — MVNO host agreements, content provider contracts, OTT platform partnerships, roaming partners, equipment vendors, channel partners, dealers, and agents. Manages partner onboarding, SLAs, revenue sharing, and settlement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`partner` (
    `partner_id` BIGINT COMMENT 'Unique identifier for the partner entity. Primary key for the partner master registry. Serves as the authoritative identity anchor referenced by all other products in the partner domain.',
    `employee_id` BIGINT COMMENT 'FK to people.employee',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Partners must be assigned to legal entities (company codes) for statutory financial reporting, consolidation, and tax compliance. Essential for partner financial transaction posting and multi-entity t',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: MVNOs, wholesale partners, and channel partners often ARE enterprise customers with corporate accounts. Enables consolidated billing, cross-product bundling, account hierarchy reporting, and unified c',
    `parent_partner_id` BIGINT COMMENT 'Reference to the parent partner in a corporate hierarchy. Null for top-level partners. Used to model subsidiary relationships and consolidated reporting.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Partners (MVNOs, roaming partners, dealers) must comply with jurisdiction-specific regulatory obligations. Essential for compliance tracking, audit trails, partner onboarding validation, and regulator',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Partners operate within specific service territories for regulatory compliance, franchise agreement enforcement, and revenue allocation. Essential for USO reporting, territory-based commission calcula',
    `compliance_status` STRING COMMENT 'Current compliance status of the partner with respect to regulatory requirements, contractual obligations, and internal policies. Non-compliant partners may face restrictions or termination.. Valid values are `compliant|non_compliant|under_review|exempted`',
    `contract_end_date` DATE COMMENT 'Scheduled expiration date of the master partner agreement. Null for evergreen agreements. Triggers renewal workflows when approaching.',
    `contract_renewal_type` STRING COMMENT 'Renewal mechanism for the partner agreement. Auto-renew contracts extend automatically unless terminated; manual-renew requires explicit action.. Valid values are `auto_renew|manual_renew|fixed_term|evergreen`',
    `contract_start_date` DATE COMMENT 'Effective start date of the master partner agreement. Marks the beginning of the contractual relationship and SLA obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the partner record was first created in the system. Used for audit trails and data lineage tracking.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the partner before transactions are blocked. Used for credit risk management and financial controls.',
    `credit_rating` STRING COMMENT 'External credit rating assigned to the partner by a recognized credit agency. Used for risk assessment and credit limit determination.',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the partner has provided consent for data sharing under applicable privacy regulations. Used for GDPR, CCPA, and other privacy compliance.',
    `dba_name` STRING COMMENT 'Trade name or doing-business-as name used by the partner in commercial operations. May differ from legal name for branding purposes.',
    `headquarters_address` STRING COMMENT 'Full street address of the partner organization headquarters. Used for legal correspondence, contract execution, and regulatory filings.',
    `headquarters_city` STRING COMMENT 'City where the partner headquarters is located. Used for geographic segmentation and regional compliance requirements.',
    `headquarters_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the partner headquarters location. Determines applicable regulatory frameworks and tax treaties.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the partner headquarters address. Used for mail delivery and geographic analytics.',
    `headquarters_state_province` STRING COMMENT 'State or province where the partner headquarters is located. Used for tax jurisdiction determination and regulatory compliance.',
    `industry_classification_code` STRING COMMENT 'Standard industry classification code for the partner organization. Typically NAICS or SIC code. Used for market segmentation and competitive analysis.',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent compliance review or audit conducted for this partner. Used to schedule periodic re-assessments and track compliance history.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the partner record was last updated. Used for change tracking, audit trails, and data synchronization.',
    `legal_entity_identifier` STRING COMMENT 'ISO 17442 Legal Entity Identifier for the partner organization. Used for regulatory reporting, financial transactions, and global entity identification.. Valid values are `^[A-Z0-9]{18,20}$`',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next compliance review or audit. Triggers workflow notifications and resource allocation for compliance teams.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special instructions, or historical notes about the partner relationship. Used for knowledge transfer and relationship continuity.',
    `onboarding_status` STRING COMMENT 'Current stage in the partner onboarding workflow. Tracks progress through documentation, technical integration, compliance verification, and final approval. [ENUM-REF-CANDIDATE: not_started|in_progress|documentation_pending|technical_integration|compliance_review|completed|failed — 7 candidates stripped; promote to reference product]',
    `operating_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where the partner has active operations. Used for roaming agreements, content licensing, and multi-jurisdiction compliance.',
    `partner_code` STRING COMMENT 'Externally-known unique business identifier for the partner. Used in contracts, invoices, and inter-operator communications. Typically assigned during onboarding and immutable thereafter.. Valid values are `^[A-Z0-9]{6,20}$`',
    `partner_name` STRING COMMENT 'Full legal name of the partner organization as registered with governing authorities. Used for contracts, regulatory filings, and legal correspondence.',
    `partner_status` STRING COMMENT 'Current lifecycle status of the partner relationship. Active partners are eligible for transactions and settlements. Suspended or terminated partners are blocked from new business.. Valid values are `active|inactive|suspended|pending_onboarding|terminated|under_review`',
    `partner_tier` STRING COMMENT 'Strategic tier or grade assigned to the partner based on revenue contribution, strategic importance, and relationship maturity. Influences SLA commitments, support priority, and commercial terms.. Valid values are `platinum|gold|silver|bronze|standard`',
    `partner_type` STRING COMMENT 'Classification of the partner based on their role in the telecommunications ecosystem. Determines applicable business processes, SLA templates, and revenue-sharing models. [ENUM-REF-CANDIDATE: MVNO|roaming_partner|content_provider|ott_platform|equipment_vendor|channel_partner|dealer|agent|wholesale_carrier|interconnect_carrier|network_vendor|system_integrator — 12 candidates stripped; promote to reference product]',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment after invoice date. Standard commercial terms such as Net 30, Net 60, or Net 90.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact. Used for operational communications, SLA notifications, and settlement correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the partner organization. Responsible for day-to-day relationship management and escalations.',
    `primary_contact_phone` STRING COMMENT 'Primary phone number for the partner contact. Used for urgent escalations and operational coordination. Format follows E.164 international standard.. Valid values are `^+?[1-9]d{1,14}$`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Default revenue-sharing percentage allocated to the partner for transactions under this agreement. Expressed as a percentage (0.00 to 100.00). May be overridden at product or service level.',
    `risk_classification` STRING COMMENT 'Internal risk classification assigned to the partner based on financial stability, compliance history, and operational performance. Influences approval workflows and monitoring intensity.. Valid values are `low|medium|high|critical`',
    `settlement_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for financial settlements with this partner. All invoices and payments are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `settlement_frequency` STRING COMMENT 'Frequency at which financial settlements are processed with the partner. Determines invoice generation schedule and payment cycles. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|annual|on_demand — 7 candidates stripped; promote to reference product]',
    `sla_tier` STRING COMMENT 'Service level agreement tier assigned to the partner. Determines response times, uptime commitments, and support escalation paths.. Valid values are `premium|standard|basic|custom`',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Committed uptime percentage for services provided to or by the partner. Expressed as a percentage (e.g., 99.95 for four nines). Breaches trigger SLA credits or penalties.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number for the partner entity. Used for invoicing, tax reporting, and revenue settlement. Format varies by jurisdiction.',
    `termination_date` DATE COMMENT 'Date when the partner relationship was formally terminated. Null for active partners. Used for historical analysis and post-termination settlement processing.',
    `termination_reason` STRING COMMENT 'Reason for partner relationship termination. Captured for root cause analysis, churn analytics, and future partner selection criteria refinement.',
    `website_url` STRING COMMENT 'Official website URL of the partner organization. Used for due diligence, public information verification, and business intelligence.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    CONSTRAINT pk_partner PRIMARY KEY(`partner_id`)
) COMMENT 'Master registry of all third-party partners in the telecommunications ecosystem — MVNOs, roaming operators, OTT platforms, content providers, equipment vendors, channel partners, and wholesale carriers. SSOT for partner identity, legal entity details, classification type, onboarding status, tier/grade, and relationship metadata. Every other product in this domain references partner_id as the authoritative identity anchor. Aligned with TM Forum SID PartnerRole entity.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the partner agreement record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Agreements are signed by specific legal entities and must be tracked to the signing company code for contract liability accounting (ASC 606/IFRS 15), revenue recognition, and legal entity P&L attribut',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Wholesale content distribution agreements (IPTV, OTT platform bundles) explicitly define which content packages are licensed under the partner agreement. Required for contract compliance verification,',
    `partner_id` BIGINT COMMENT 'Reference to the partner organization that is party to this agreement.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Partner agreements must reference applicable regulatory frameworks (data protection, interconnection rules, consumer protection laws). Critical for contract compliance validation, legal review process',
    `revenue_share_plan_id` BIGINT COMMENT 'Foreign key linking to partner.revenue_share_plan. Business justification: Partner agreements that involve revenue sharing should reference the specific revenue_share_plan that governs the commercial arrangement. The agreement has revenue_share_percentage embedded, but the f',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Partner contracts require internal signatory tracking for legal compliance, audit trails, and authority verification. Telecom wholesale/MVNO agreements involve significant financial commitments requir',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Partner agreements specify SLA performance metrics (uptime %, latency, throughput) that must reference formal KPI definitions for consistent measurement and reporting. Telecom operators standardize SL',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the partner agreement for identification and reporting purposes.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the partner agreement. Used in communications, invoices, and legal references.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the partner agreement. Controls operational activation, billing, and settlement processes.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `agreement_type` STRING COMMENT 'Classification of the partner agreement based on the nature of the commercial relationship. Determines applicable terms, revenue models, and operational workflows.. Valid values are `mvno_host|roaming_bilateral|content_licensing|ott_platform|equipment_supply|dealer_commission`',
    `amendment_count` STRING COMMENT 'Total number of amendments or addenda executed since the original agreement. Indicates contract stability and negotiation history.',
    `audit_frequency` STRING COMMENT 'Frequency at which compliance or financial audits may be conducted under the agreement terms.. Valid values are `annual|semi_annual|quarterly|on_demand`',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether Telecommunication retains the right to audit partner records, systems, or processes for compliance verification.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews upon expiration. Controls renewal notification and renegotiation workflows.',
    `confidentiality_period_years` STRING COMMENT 'Duration in years that confidentiality obligations survive agreement termination. Governs data retention and disclosure policies.',
    `contract_term_months` STRING COMMENT 'Duration of the agreement in months from effective start date. Used for renewal planning and commitment tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this agreement. Determines settlement currency and foreign exchange handling.. Valid values are `^[A-Z]{3}$`',
    `data_protection_addendum_flag` BOOLEAN COMMENT 'Indicates whether a Data Protection Addendum (DPA) or Data Processing Agreement is attached to govern personal data processing under GDPR or equivalent regulations.',
    `data_sharing_permitted_flag` BOOLEAN COMMENT 'Indicates whether customer or operational data sharing is permitted under this agreement. Critical for GDPR and privacy compliance.',
    `dispute_resolution_method` STRING COMMENT 'Agreed mechanism for resolving contractual disputes between parties. Determines escalation paths and legal procedures.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `document_repository_url` STRING COMMENT 'URL or file path to the secure repository location where the executed agreement and related documents are stored.',
    `effective_end_date` DATE COMMENT 'Date when the partner agreement expires or terminates. Nullable for open-ended agreements. Triggers renewal workflows and settlement finalization.',
    `effective_start_date` DATE COMMENT 'Date when the partner agreement becomes legally binding and operationally active. Determines when revenue sharing, SLA enforcement, and settlement calculations begin.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this agreement grants exclusive rights to the partner in a defined territory, product category, or service domain.',
    `exclusivity_scope` STRING COMMENT 'Description of the scope of exclusivity granted, including geographic territories, product lines, or customer segments covered.',
    `fixed_fee_amount` DECIMAL(18,2) COMMENT 'Fixed periodic payment amount for fixed-fee agreements. Confidential commercial term.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of this agreement. Critical for dispute resolution.',
    `insurance_requirement_amount` DECIMAL(18,2) COMMENT 'Minimum insurance coverage amount required from the partner for liability, professional indemnity, or other risk categories.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or addendum to the agreement. Tracks contract evolution and version history.',
    `minimum_commitment_amount` DECIMAL(18,2) COMMENT 'Minimum revenue, volume, or purchase commitment required from either party over the contract term. Confidential commercial term.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational instructions related to the agreement.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due. Drives accounts payable and receivable workflows.',
    `penalty_cap_amount` DECIMAL(18,2) COMMENT 'Maximum aggregate penalty amount that can be assessed in a given period for SLA breaches. Confidential commercial term.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Value of performance bond or bank guarantee required to secure partner obligations. Confidential commercial term.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary partner contact for operational communications and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact at the partner organization responsible for agreement management and escalations.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary partner contact for urgent escalations and voice communications.',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory frameworks governing this agreement, such as FCC regulations for MVNO agreements, BEREC guidelines for roaming, or content licensing regulations.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that renewal or termination notice must be provided. Drives automated notification workflows.',
    `revenue_share_model` STRING COMMENT 'Commercial model governing how revenue or costs are shared between Telecommunication and the partner. Determines settlement calculation methodology.. Valid values are `fixed_fee|percentage_revenue|tiered_revenue|usage_based|hybrid`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue allocated to the partner under percentage-based or tiered revenue share models. Confidential commercial term.',
    `settlement_frequency` STRING COMMENT 'Frequency at which revenue sharing or cost settlements are calculated and invoiced between parties.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `signed_date` DATE COMMENT 'Date when the agreement was executed by authorized signatories from both parties. Establishes legal binding date.',
    `sla_tier` STRING COMMENT 'Service level tier defining performance commitments, response times, and penalties. Links to detailed SLA schedules and KPI targets.. Valid values are `platinum|gold|silver|bronze|standard`',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Committed service availability percentage for network, platform, or service uptime. Breaches trigger penalty calculations.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for voluntary termination by either party. Drives offboarding and transition workflows.',
    `termination_penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty assessed for early termination of the agreement. Confidential commercial term.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement record was last modified. Audit trail for change tracking and compliance.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Contractual agreements and commercial arrangements between Telecommunication and its partners — MVNO host agreements, roaming bilateral agreements, content licensing contracts, OTT platform partnership agreements, equipment supply contracts, dealer/agent commission agreements, and wholesale carrier agreements. Captures contract terms, effective dates, renewal conditions, and governing regulatory frameworks.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`mvno_profile` (
    `mvno_profile_id` BIGINT COMMENT 'Unique identifier for the MVNO partner profile record. Primary key.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: MVNO partners typically have separate corporate accounts for their own enterprise service consumption (office connectivity, employee mobile, UCaaS). Business process: separate wholesale MVNO billing f',
    `agreement_id` BIGINT COMMENT 'Reference to the master host agreement contract governing the MVNO relationship, terms, and commercial arrangements.',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity representing this MVNO in the partner master data.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: MVNOs differentiate mobile offerings by bundling content packages (streaming services, OTT platforms) as value-adds. Telco operations track which content bundles are included in MVNO wholesale agreeme',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: MVNOs are distinct business segments requiring dedicated P&L tracking. Essential for MVNO profitability reporting, ARPU analysis, segment performance management, and management accounting in wholesale',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: MVNO subscriber populations are analyzed as distinct customer segments for churn prediction, ARPU analysis, and usage profiling. Analytics teams define MVNO-specific segments (e.g., "MVNO_BrandX_Prepa',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: MVNOs are licensed to operate in specific service territories. Critical for spectrum access rights validation, regulatory compliance reporting, subscriber capacity planning by territory, and franchise',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: MVNOs operate under host operators spectrum licenses. Tracking which license authorizes MVNO operations is essential for regulatory compliance, capacity planning, spectrum utilization reporting, and ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: MVNOs require dedicated technical account manager for HLR/HSS provisioning, IMSI/MSISDN range management, APN configuration, and network integration. Critical for operational escalations and SLA manag',
    `rate_plan_id` BIGINT COMMENT 'Reference to the wholesale rate plan applied to this MVNO for usage-based charging (voice, SMS, data).',
    `apn_configuration` STRING COMMENT 'JSON or structured text defining the APN settings assigned to this MVNO for data connectivity, including APN names, IP addressing, and QoS parameters.',
    `billing_arrangement_type` STRING COMMENT 'Defines the billing model between host MNO and MVNO: wholesale rated (MNO bills MVNO), retail billed (MNO bills end customers on behalf of MVNO), hybrid, or self-billed (MVNO manages own billing).. Valid values are `wholesale_rated|retail_billed|hybrid|self_billed`',
    `billing_contact_email` STRING COMMENT 'Email address of the billing and finance contact at the MVNO for invoicing and settlement matters.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contract_end_date` DATE COMMENT 'Expiration or renewal date of the MVNO host agreement contract.',
    `contract_start_date` DATE COMMENT 'Effective start date of the MVNO host agreement contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MVNO profile record was first created in the system.',
    `current_subscriber_count` STRING COMMENT 'Current number of active subscribers provisioned under this MVNO profile.',
    `esim_support_enabled` BOOLEAN COMMENT 'Indicates whether the MVNO supports eSIM provisioning and management for subscribers.',
    `five_g_access_enabled` BOOLEAN COMMENT 'Indicates whether MVNO subscribers have access to 5G NR network services.',
    `hlr_provisioning_enabled` BOOLEAN COMMENT 'Indicates whether the MVNO has direct provisioning access to the HLR for subscriber management.',
    `hss_provisioning_enabled` BOOLEAN COMMENT 'Indicates whether the MVNO has direct provisioning access to the HSS for LTE/IMS subscriber management.',
    `imsi_range_end` STRING COMMENT 'Ending IMSI number in the range allocated to this MVNO for subscriber identification.. Valid values are `^[0-9]{15}$`',
    `imsi_range_start` STRING COMMENT 'Starting IMSI number in the range allocated to this MVNO for subscriber identification.. Valid values are `^[0-9]{15}$`',
    `international_roaming_enabled` BOOLEAN COMMENT 'Indicates whether MVNO subscribers are permitted to roam internationally on partner carrier networks.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MVNO profile record was last updated.',
    `msisdn_range_end` STRING COMMENT 'Ending phone number in the MSISDN range allocated to this MVNO for customer-facing mobile numbers.. Valid values are `^[0-9]{10,15}$`',
    `msisdn_range_start` STRING COMMENT 'Starting phone number in the MSISDN range allocated to this MVNO for customer-facing mobile numbers.. Valid values are `^[0-9]{10,15}$`',
    `mvno_brand_name` STRING COMMENT 'The commercial brand name under which the MVNO operates and markets services to end customers.',
    `mvno_code` STRING COMMENT 'Unique alphanumeric code assigned to the MVNO for operational identification across network and billing systems.. Valid values are `^[A-Z0-9]{3,10}$`',
    `mvno_legal_name` STRING COMMENT 'The legal registered business name of the MVNO entity as per incorporation documents.',
    `mvno_type` STRING COMMENT 'Classification of the MVNO business model: full MVNO (owns core network elements), light MVNO (limited infrastructure), branded reseller (pure resale), ESP (Enhanced Service Provider), or MVNE (MVNO Enabler).. Valid values are `full_mvno|light_mvno|branded_reseller|esp|mvne`',
    `network_access_type` STRING COMMENT 'Level of network infrastructure access granted to the MVNO: full access to RAN and core, RAN sharing only, core network sharing, or pure resale arrangement.. Valid values are `full_access|ran_sharing|core_sharing|resale_only`',
    `noc_contact_phone` STRING COMMENT '24/7 phone number for the MVNO Network Operations Center for incident escalation and service restoration.',
    `onboarding_date` DATE COMMENT 'Date when the MVNO partner was onboarded and provisioned on the host network infrastructure.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the MVNO organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the MVNO organization for operational coordination.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact at the MVNO organization.',
    `profile_status` STRING COMMENT 'Current operational status of the MVNO profile: active (live and serving subscribers), suspended (temporarily disabled), terminated (contract ended), pending activation (onboarding in progress), or under review (compliance or commercial review).. Valid values are `active|suspended|terminated|pending_activation|under_review`',
    `qos_profile` STRING COMMENT 'QoS class identifier or profile name defining traffic prioritization, bandwidth allocation, and latency guarantees for MVNO subscribers.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the host MNO from MVNO subscriber services, as per commercial agreement.',
    `roaming_enabled` BOOLEAN COMMENT 'Indicates whether MVNO subscribers are permitted to roam on partner networks outside the host MNO coverage area.',
    `sla_latency_ms` STRING COMMENT 'Maximum network latency in milliseconds guaranteed under the SLA for data services.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Contractual network uptime percentage guaranteed to the MVNO (e.g., 99.9%).',
    `spectrum_access_rights` STRING COMMENT 'Description of spectrum bands and frequencies the MVNO is authorized to utilize (e.g., 700MHz, 1800MHz, 2600MHz, 3.5GHz 5G NR).',
    `subscriber_capacity_limit` STRING COMMENT 'Maximum number of active subscribers the MVNO is permitted to host on the network infrastructure as per contractual agreement.',
    `suspension_reason` STRING COMMENT 'Business reason for suspension if profile_status is suspended (e.g., payment default, SLA breach, regulatory compliance issue).',
    `technical_contact_email` STRING COMMENT 'Email address of the technical operations contact at the MVNO for network and provisioning issues.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `termination_date` DATE COMMENT 'Date when the MVNO profile was terminated and services ceased.',
    `termination_reason` STRING COMMENT 'Business reason for termination if profile_status is terminated (e.g., contract expiry, mutual agreement, breach of terms).',
    `volte_enabled` BOOLEAN COMMENT 'Indicates whether VoLTE voice services are enabled for MVNO subscribers.',
    `vowifi_enabled` BOOLEAN COMMENT 'Indicates whether VoWiFi (Wi-Fi calling) services are enabled for MVNO subscribers.',
    CONSTRAINT pk_mvno_profile PRIMARY KEY(`mvno_profile_id`)
) COMMENT 'Detailed operational and commercial profile for Mobile Virtual Network Operator (MVNO) partners hosted on Telecommunications network infrastructure. Captures MVNO brand identity, subscriber base capacity, spectrum access rights, network access type (full MVNO, light MVNO, branded reseller), HLR/HSS provisioning parameters, APN configurations, and MVNO-specific billing arrangements.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` (
    `roaming_agreement_id` BIGINT COMMENT 'Unique identifier for the roaming agreement between the home network operator and the visited network operator.',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Roaming agreements specify permitted coverage areas for roaming subscribers. Essential for steering policy enforcement, fraud detection (usage outside permitted zones), NRTRDE threshold monitoring, an',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT roaming agreements enable enterprise IoT devices to roam internationally under negotiated rates. Business process: IoT deployment cost modeling with roaming charges, roaming usage reconciliation f',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Roaming agreements (TAP/RAP file exchange, GSMA AA12/AA13 compliance, IoT rates) require tracking of internal negotiator for accountability, knowledge retention, and future renegotiations. Critical fo',
    `partner_id` BIGINT COMMENT 'Reference to the roaming partner network operator with whom this agreement is established.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Roaming agreements must comply with jurisdiction-specific regulations (GSMA standards, local telecom rules, data protection laws). Essential for international compliance validation, cross-border data ',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the roaming agreement for identification and reporting purposes.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the roaming agreement, used in partner communications and settlement processes.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the roaming agreement: draft (under negotiation), pending_approval (awaiting signature), active (in force), suspended (temporarily inactive), terminated (ended by party), or expired (reached end date).. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `agreement_type` STRING COMMENT 'Classification of the roaming agreement structure: bilateral (one-to-one), multilateral (many-to-many), regional (geographic grouping), global (worldwide coverage), preferred (priority partner), or standard (default terms).. Valid values are `bilateral|multilateral|regional|global|preferred|standard`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at the end of its term unless terminated by either party.',
    `contract_document_url` STRING COMMENT 'Secure storage location or document management system URL for the signed roaming agreement contract.',
    `coverage_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this roaming agreement provides coverage (e.g., USA,CAN,MEX).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this roaming agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all financial terms in this agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_mb_rate` DECIMAL(18,2) COMMENT 'Wholesale rate per megabyte of data usage in the agreement currency. Used for settlement calculations.',
    `dispute_resolution_period_days` STRING COMMENT 'Number of days within which settlement disputes must be raised after invoice receipt.',
    `effective_end_date` DATE COMMENT 'Date when the roaming agreement expires or terminates. Null indicates an open-ended agreement subject to notice period.',
    `effective_start_date` DATE COMMENT 'Date when the roaming agreement becomes legally binding and operational for traffic exchange and settlement.',
    `fraud_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether automated fraud detection and prevention mechanisms are active for this roaming agreement.',
    `fraud_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum allowed roaming charges per subscriber per day before fraud alerts are triggered and service may be suspended.',
    `gsma_aa12_compliant` BOOLEAN COMMENT 'Indicates whether the agreement adheres to GSMA AA.12 standard for roaming agreement principles and commercial frameworks.',
    `gsma_aa13_compliant` BOOLEAN COMMENT 'Indicates whether the agreement adheres to GSMA AA.13 standard for roaming financial settlement and dispute resolution.',
    `iot_rate_type` STRING COMMENT 'Pricing structure for wholesale roaming charges: fixed (flat rate), tiered (volume discounts), volume_based (per unit), time_based (peak/off-peak), or hybrid (combination).. Valid values are `fixed|tiered|volume_based|time_based|hybrid`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the roaming agreement terms.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this roaming agreement record was most recently modified in the system.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or operational notes related to the roaming agreement.',
    `nrtrde_enabled` BOOLEAN COMMENT 'Indicates whether near real-time roaming data exchange is enabled for fraud prevention and usage monitoring.',
    `nrtrde_threshold_amount` DECIMAL(18,2) COMMENT 'Financial threshold in agreement currency that triggers NRTRDE notification to home network for fraud prevention.',
    `partner_signatory_name` STRING COMMENT 'Name of the authorized representative who signed the agreement on behalf of the roaming partner network operator.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment must be received to avoid late payment penalties.',
    `preferred_partner_flag` BOOLEAN COMMENT 'Indicates whether this partner is designated as a preferred roaming partner for network steering and priority routing.',
    `rap_version` STRING COMMENT 'Version of the RAP file format used for dispute resolution and error correction (e.g., RAP3, RAP4).. Valid values are `^RAP[0-9]{1,2}$`',
    `renewal_term_months` STRING COMMENT 'Duration in months for each automatic renewal period if auto-renewal is enabled.',
    `roaming_direction` STRING COMMENT 'Traffic flow direction covered by the agreement: inbound (partner subscribers roaming on our network), outbound (our subscribers roaming on partner network), or bidirectional (both directions).. Valid values are `inbound|outbound|bidirectional`',
    `service_types_covered` STRING COMMENT 'Comma-separated list of service types included in the roaming agreement: voice, SMS, data, MMS, VoLTE, video calling, 5G services, etc.',
    `settlement_period_days` STRING COMMENT 'Number of days after period end by which settlement invoices must be issued and paid.',
    `signatory_name` STRING COMMENT 'Name of the authorized representative who signed the agreement on behalf of the home network operator.',
    `signed_date` DATE COMMENT 'Date when the roaming agreement was formally executed and signed by both parties.',
    `sla_availability_percent` DECIMAL(18,2) COMMENT 'Minimum network availability percentage guaranteed by the visited network operator (e.g., 99.9%).',
    `sla_call_success_rate_percent` DECIMAL(18,2) COMMENT 'Minimum call setup success rate percentage guaranteed for roaming voice services.',
    `sla_data_throughput_mbps` DECIMAL(18,2) COMMENT 'Minimum guaranteed data throughput in megabits per second for roaming data services.',
    `sms_rate` DECIMAL(18,2) COMMENT 'Wholesale rate per SMS message in the agreement currency. Used for settlement calculations.',
    `steering_policy` STRING COMMENT 'Policy for directing subscribers to this partner network: automatic (default selection), manual (user choice), preferred (priority), cost_based (lowest rate), or quality_based (best QoS).. Valid values are `automatic|manual|preferred|cost_based|quality_based`',
    `tap_file_frequency` STRING COMMENT 'Frequency at which TAP files are exchanged between operators for settlement: daily, weekly, monthly, or real_time (near real-time).. Valid values are `daily|weekly|monthly|real_time`',
    `tap_version` STRING COMMENT 'Version of the TAP file format used for roaming data exchange and settlement (e.g., TAP3.12, TAP3.13).. Valid values are `^TAP3.[0-9]{1,2}$`',
    `technology_standards` STRING COMMENT 'Comma-separated list of network technology standards covered: 2G, 3G, 4G LTE, 5G NR, VoLTE, IMS, etc.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the roaming agreement.',
    `voice_mou_rate` DECIMAL(18,2) COMMENT 'Wholesale rate per minute for voice calls in the agreement currency. Used for settlement calculations.',
    CONSTRAINT pk_roaming_agreement PRIMARY KEY(`roaming_agreement_id`)
) COMMENT 'Bilateral and multilateral roaming agreements with international and domestic network operators. Captures IOT (Inter-Operator Tariff) rates, TAP (Transferred Account Procedure) file exchange parameters, NRTRDE near-real-time data exchange settings, roaming steering policies, preferred roaming partner designations, fraud prevention thresholds, and GSMA AA.12/AA.13 compliance status.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`sla_definition` (
    `sla_definition_id` BIGINT COMMENT 'Unique identifier for the SLA definition record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the partner agreement to which this SLA definition is attached. Links SLA commitments to contractual relationships.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: SLA definitions (uptime, latency, call success rate) need creator tracking for governance, version control, and accountability. Reusing existing created_by field as proper FK enables audit trail for p',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: SLAs often derive from regulatory requirements (E911 response times, network availability mandates, quality-of-service standards). Critical for tracking regulatory compliance in partner performance ma',
    `approval_status` STRING COMMENT 'Approval state of this SLA definition within internal governance process before it becomes active.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this SLA definition for activation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA definition was approved.',
    `compliance_required_flag` BOOLEAN COMMENT 'Indicates whether this SLA is subject to regulatory compliance requirements (e.g., FCC-mandated interconnection SLAs, BEREC roaming quality standards). True if compliance reporting is mandatory.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA definition record was first created in the system.',
    `credit_formula` STRING COMMENT 'Formula or rule for calculating service credits issued to partners when SLA is breached (e.g., Pro-rated credit based on downtime duration).',
    `dispute_resolution_window_days` STRING COMMENT 'Number of days within which SLA measurement disputes must be raised and resolved.',
    `effective_end_date` DATE COMMENT 'Date when this SLA definition expires or is no longer in force. Nullable for open-ended SLAs.',
    `effective_start_date` DATE COMMENT 'Date when this SLA definition becomes binding and measurements begin.',
    `escalation_procedure` STRING COMMENT 'Description of the escalation process when threshold is breached, including notification requirements and resolution timelines.',
    `escalation_threshold` DECIMAL(18,2) COMMENT 'Value at which SLA breach triggers escalation to senior management or dispute resolution process. Nullable if no escalation defined.',
    `exclusion_conditions` STRING COMMENT 'Conditions under which SLA measurements are excluded or suspended (e.g., Force majeure events, Planned maintenance windows with 72-hour notice, Partner-caused outages).',
    `last_modified_by` STRING COMMENT 'User or system identifier of the person or process that last modified this SLA definition record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA definition record was last updated.',
    `measurement_method` STRING COMMENT 'Description of how the metric is measured, including data sources, calculation formulas, and exclusions (e.g., Calculated from NOC monitoring system, excluding planned maintenance windows).',
    `measurement_period` STRING COMMENT 'Time window over which SLA compliance is measured and evaluated (e.g., monthly for uptime, per_incident for MTTR, quarterly for settlement processing).. Valid values are `monthly|quarterly|annual|daily|weekly|per_incident`',
    `metric_description` STRING COMMENT 'Detailed description of how the metric is measured, calculated, and interpreted for compliance evaluation.',
    `metric_name` STRING COMMENT 'Name of the measurable metric governed by this SLA (e.g., Network Uptime Percentage, Average Latency, Settlement Processing Time, Dispute Resolution Time).',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to this SLA definition.',
    `notification_recipients` STRING COMMENT 'List of roles or contact points to be notified when SLA thresholds are breached (e.g., Partner NOC Manager, Account Manager, Escalation Team).',
    `notification_threshold` DECIMAL(18,2) COMMENT 'Value at which proactive notifications are sent to partners warning of potential SLA breach (e.g., 95% when target is 99%).',
    `partner_type` STRING COMMENT 'Category of partner to which this SLA applies, enabling type-specific SLA templates and benchmarks.. Valid values are `mvno|content_provider|roaming_partner|equipment_vendor|channel_partner|ott_platform`',
    `penalty_cap_amount` DECIMAL(18,2) COMMENT 'Maximum financial penalty that can be assessed in a single measurement period. Nullable if no cap applies.',
    `penalty_cap_currency` STRING COMMENT 'ISO 4217 three-letter currency code for penalty cap amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `penalty_formula` STRING COMMENT 'Formula or rule for calculating financial penalties when SLA is breached (e.g., 1% of monthly fee per 0.1% below threshold, Fixed $10,000 per incident exceeding MTTR).',
    `priority_level` STRING COMMENT 'Business priority of this SLA definition, used for resource allocation and escalation routing (e.g., critical for tier-1 MVNO partners, low for non-revenue content providers).. Valid values are `critical|high|medium|low`',
    `regulatory_reference` STRING COMMENT 'Citation of regulatory requirement or industry standard that mandates or influences this SLA (e.g., FCC 47 CFR Part 51, BEREC Roaming Regulation (EU) 2015/2120, TM Forum SID SLASpecification).',
    `reporting_format` STRING COMMENT 'Format and delivery method for SLA performance reports (e.g., PDF via email, API endpoint, Partner portal dashboard).',
    `reporting_frequency` STRING COMMENT 'How often SLA performance reports are generated and shared with partners (e.g., monthly for uptime reports, real_time for critical QoS metrics).. Valid values are `real_time|daily|weekly|monthly|quarterly|on_demand`',
    `service_scope` STRING COMMENT 'Description of which services, network elements, or geographic regions this SLA applies to (e.g., All LTE RAN sites in Region A, MVNO data services, International roaming partners).',
    `sla_code` STRING COMMENT 'Unique business code or identifier for the SLA definition used in operational systems and reporting (e.g., SLA-UPTIME-001, SLA-QOS-GOLD).',
    `sla_definition_status` STRING COMMENT 'Current lifecycle status of the SLA definition: draft (under negotiation), active (in force), suspended (temporarily inactive), expired (past end date), terminated (cancelled before expiration).. Valid values are `draft|active|suspended|expired|terminated`',
    `sla_name` STRING COMMENT 'Business-friendly name of the SLA definition (e.g., Gold Tier Uptime SLA, MVNO QoS Commitment, Roaming Settlement Processing SLA).',
    `sla_type` STRING COMMENT 'Category of SLA commitment: uptime (availability percentage), qos (Quality of Service thresholds for latency/jitter/packet loss), mttr (Mean Time to Repair targets), settlement (processing deadlines for revenue sharing), dispute_resolution (resolution windows), performance (general KPI targets).. Valid values are `uptime|qos|mttr|settlement|dispute_resolution|performance`',
    `target_value` DECIMAL(18,2) COMMENT 'The committed target value for the SLA metric (e.g., 99.95 for uptime percentage, 50 for latency in milliseconds, 5 for MTTR in hours).',
    `threshold_value` DECIMAL(18,2) COMMENT 'The minimum acceptable value before penalties or credits are triggered. May differ from target_value to allow for tolerance bands.',
    `unit_of_measure` STRING COMMENT 'Unit in which the metric is expressed (e.g., percent, milliseconds, hours, days, packets_per_second, business_days).',
    `version_number` STRING COMMENT 'Version identifier for this SLA definition, enabling tracking of amendments and revisions over the agreement lifecycle (e.g., 1.0, 2.1, 3.0-amended).',
    CONSTRAINT pk_sla_definition PRIMARY KEY(`sla_definition_id`)
) COMMENT 'Service Level Agreement definitions specifying measurable commitments governing partner relationships — uptime percentages, QoS thresholds (latency, jitter, packet loss), MTTR targets, settlement processing deadlines, dispute resolution windows, and penalty/credit calculation formulas. Each definition attaches to one or more partner agreements and serves as the benchmark for partner_sla_measurement evaluation. Aligned with TM Forum SID SLASpecification entity.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` (
    `revenue_share_plan_id` BIGINT COMMENT 'Unique identifier for the revenue share plan. Primary key.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Revenue share plans define default GL account mappings for automated partner revenue posting during settlement processing. Required for financial automation, revenue recognition workflows, and reducin',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity to which this revenue share plan applies. Links to the partner master record for MVNO hosts, content providers, OTT platforms, dealers, agents, or wholesale resellers.',
    `applicable_product_scope` STRING COMMENT 'Defines the scope of products and services to which this revenue share plan applies. Determines which revenue streams are included in the calculation. [ENUM-REF-CANDIDATE: all_products|mobile_services|broadband_services|content_services|iptv_services|ott_services|voice_services|data_services|roaming_services|specific_product_list — 10 candidates stripped; promote to reference product]',
    `applicable_service_type` STRING COMMENT 'Specific service types covered by this revenue share plan. Free-text field for detailed service classification (e.g., Prepaid Mobile Voice and Data, Premium IPTV Channels, International Roaming Data).',
    `approval_date` DATE COMMENT 'Date on which the revenue share plan was approved by authorized stakeholders. Required before plan can move to active status.',
    `approved_by` STRING COMMENT 'Name or identifier of the business user or role who approved this revenue share plan. Used for audit and governance.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this revenue share plan automatically renews at the end of its effective period. True if the plan renews without manual intervention.',
    `calculation_method` STRING COMMENT 'Methodology used to calculate the revenue share or commission. Defines whether the share is a percentage of revenue, a fixed rate per transaction/unit, tiered based on volume thresholds, or a hybrid model.. Valid values are `percentage_split|fixed_rate_per_unit|tiered_percentage|tiered_fixed|hybrid|cost_plus_margin`',
    `contract_reference_number` STRING COMMENT 'Reference to the master partner agreement or contract under which this revenue share plan is defined. Links to legal contract documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue share plan record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this revenue share plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_process` STRING COMMENT 'Description of the process and escalation path for resolving revenue share calculation disputes with the partner. References contract terms.',
    `effective_end_date` DATE COMMENT 'Date on which this revenue share plan expires or is terminated. Null for open-ended plans. Used for contract renewals and plan transitions.',
    `effective_start_date` DATE COMMENT 'Date from which this revenue share plan becomes active and applicable to partner transactions. Aligns with contract effective date.',
    `exchange_rate_source` STRING COMMENT 'Source of foreign exchange rates used for currency conversion in revenue share calculations (e.g., Reuters, Bloomberg, Central Bank Daily Rate).',
    `fixed_rate_amount` DECIMAL(18,2) COMMENT 'The fixed monetary amount paid per unit/transaction when calculation_method is fixed-rate based. Null if calculation method is percentage-based or tiered.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue share plan record was last updated. Used for change tracking and audit purposes.',
    `maximum_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum revenue or transaction volume subject to revenue sharing. Used for plans with capped commission structures. Null if no maximum threshold applies.',
    `minimum_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum revenue or transaction volume required before revenue sharing begins. Used for plans with minimum commitment clauses. Null if no minimum threshold applies.',
    `modified_by` STRING COMMENT 'Identifier of the user or system process that last modified this revenue share plan record. Used for audit and accountability.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special terms, or exceptions related to this revenue share plan. Used for operational guidance and context.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier for the revenue share plan. Used in contracts, invoices, and settlement documents.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `plan_description` STRING COMMENT 'Detailed description of the revenue share plan, including scope, applicable services, and commercial terms summary.',
    `plan_name` STRING COMMENT 'Human-readable name of the revenue share plan. Describes the commercial arrangement (e.g., MVNO Wholesale Rate Plan Q1 2024, OTT Content Revenue Split - Premium Tier).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the revenue share plan. Determines whether the plan is in use for settlement calculations.. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `plan_type` STRING COMMENT 'Classification of the revenue share plan by partner relationship type. Determines the calculation methodology and applicable business rules. [ENUM-REF-CANDIDATE: mvno_wholesale|content_provider_split|ott_platform_share|dealer_commission|agent_commission|reseller_margin|roaming_settlement|equipment_vendor_rebate — 8 candidates stripped; promote to reference product]',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to effective_end_date that renewal or termination notice must be provided. Null if auto_renewal_flag is false.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code used for revenue share reporting and analytics. May differ from settlement currency_code for multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `settlement_frequency` STRING COMMENT 'Frequency at which revenue share settlements are calculated and paid to the partner. Defines the billing cycle for partner payouts. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|annual|event_based — 7 candidates stripped; promote to reference product]',
    `settlement_terms_days` STRING COMMENT 'Number of days after the settlement period end date by which payment must be made to the partner. Standard payment terms (e.g., Net 30, Net 45).',
    `share_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue allocated to the partner when calculation_method is percentage-based. Expressed as a decimal (e.g., 15.50 for 15.5%). Null if calculation method is fixed rate or tiered.',
    `sla_target_accuracy_percentage` DECIMAL(18,2) COMMENT 'Target accuracy percentage for revenue share calculations as defined in the partner SLA. Used for performance monitoring and dispute resolution.',
    `tax_treatment_code` STRING COMMENT 'Code indicating the tax treatment applicable to revenue share payments under this plan. Determines withholding tax, VAT, or GST applicability.',
    `tier_structure_flag` BOOLEAN COMMENT 'Indicates whether this revenue share plan uses tiered thresholds for calculation. True if the plan has multiple tiers with different rates/percentages based on volume or revenue thresholds.',
    `version_number` STRING COMMENT 'Version number of this revenue share plan. Incremented with each amendment or revision to track plan evolution over time.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Percentage of revenue share payment subject to withholding tax, if applicable. Null if no withholding tax applies.',
    CONSTRAINT pk_revenue_share_plan PRIMARY KEY(`revenue_share_plan_id`)
) COMMENT 'Revenue sharing and commission plan definitions for partner commercial arrangements — MVNO wholesale rate plans, content provider revenue split percentages, OTT platform revenue share tiers, dealer/agent commission structures, and wholesale reseller margin schedules. Captures calculation methodology, tiered thresholds, effective periods, and applicable product/service scope.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`settlement_run` (
    `settlement_run_id` BIGINT COMMENT 'Unique identifier for the settlement run execution record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Partner settlements may reference specific billing accounts (MVNO accounts, wholesale customer accounts). Required for settlement-to-account reconciliation, partner billing integration, and financial ',
    `employee_id` BIGINT COMMENT 'Reference to the internal user (finance manager, revenue assurance analyst) who approved this settlement run for payment.',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity for whom this settlement run is executed (MVNO, roaming carrier, content provider, dealer, agent, or equipment vendor).',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Settlement calculations are data pipelines processing CDRs, applying rates, and generating payables. Tracking settlement runs as pipeline executions enables SLA monitoring (settlement must complete wi',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Settlement runs represent partner revenue/cost flows that must be attributed to profit centers for segment reporting, management P&L, and business unit performance analysis. Critical for wholesale and',
    `agreement_id` BIGINT COMMENT 'Reference to the master partner agreement governing the commercial terms, revenue share percentages, and settlement frequency for this run.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The total value of manual adjustments (credits, debits, corrections) applied to the settlement run, typically resulting from prior period corrections, dispute resolutions, or contractual true-ups.',
    `adjustment_reason` STRING COMMENT 'Business justification for the adjustment amount, documenting the cause (e.g., prior period correction, billing error, goodwill credit, contractual amendment).',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the settlement run was formally approved by an authorized finance or revenue assurance manager, marking it ready for payment processing.',
    `calculation_method` STRING COMMENT 'Indicates whether the settlement amounts were computed via automated billing engine (automated), manually entered by finance staff (manual), or a combination of system calculation with manual adjustments (hybrid).. Valid values are `automated|manual|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement run record was first created in the system, marking the initiation of the settlement process.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the settlement amount is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the partner has formally disputed the settlement run amounts, triggering a dispute resolution workflow.',
    `dispute_reason` STRING COMMENT 'Free-text description of the partners stated reason for disputing the settlement run (e.g., incorrect usage volumes, wrong rate applied, missing credits, data quality issues).',
    `dispute_resolution_date` DATE COMMENT 'The date on which the settlement dispute was formally resolved, either through agreement, adjustment, or arbitration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement run record was most recently updated, capturing any status changes, approvals, or data corrections.',
    `line_item_count` STRING COMMENT 'The total number of detailed settlement line items (charges, credits, adjustments, usage records) included in this settlement run, providing a summary count for reconciliation purposes.',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'The final amount payable to the partner after applying all taxes, adjustments, and deductions to the total settlement amount.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special instructions, or operational comments related to this settlement run (e.g., partner communication notes, escalation details, processing exceptions).',
    `payment_completion_date` DATE COMMENT 'The actual date on which the payment was successfully transferred to the partner, confirming settlement closure.',
    `payment_due_date` DATE COMMENT 'The contractual date by which payment must be made to the partner, as defined in the settlement agreement SLA (Service Level Agreement) terms.',
    `payment_instruction_reference` STRING COMMENT 'External reference number or identifier linking this settlement run to the payment instruction sent to the treasury or accounts payable system (e.g., wire transfer batch ID, ACH transaction reference).',
    `reconciliation_status` STRING COMMENT 'Indicates the outcome of the settlement reconciliation process comparing Telecommunications calculated amounts against partner-submitted invoices or usage reports: not started, in progress, reconciled (matched), discrepancy identified (variance detected), or escalated (dispute raised).. Valid values are `not_started|in_progress|reconciled|discrepancy_identified|escalated`',
    `reconciliation_variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference identified during reconciliation between Telecommunications calculated settlement amount and the partners submitted claim or invoice. Positive values indicate partner over-claim; negative values indicate under-claim.',
    `run_execution_timestamp` TIMESTAMP COMMENT 'The date and time when the settlement calculation engine executed this run, generating the settlement amount and line-item details.',
    `run_number` STRING COMMENT 'Business-facing unique identifier for the settlement run, typically formatted as a human-readable code (e.g., SETT-2024-Q1-001) used in partner communications and financial reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `settlement_frequency` STRING COMMENT 'The contractual cadence at which settlement runs are executed for this partner relationship: daily, weekly, monthly, quarterly, annual, or ad hoc (event-driven).. Valid values are `daily|weekly|monthly|quarterly|annual|ad_hoc`',
    `settlement_period_end_date` DATE COMMENT 'The last date of the business period covered by this settlement run, defining the cutoff for transactions, usage events, or sales included in the settlement calculation.',
    `settlement_period_start_date` DATE COMMENT 'The first date of the business period covered by this settlement run (e.g., the start of the billing cycle, roaming data exchange window, or commission calculation period).',
    `settlement_status` STRING COMMENT 'Current lifecycle state of the settlement run: draft (in preparation), calculated (amounts computed), pending approval (awaiting finance review), approved (ready for payment), rejected (failed validation), payment initiated (sent to treasury), paid (funds transferred), disputed (partner contest), or cancelled (voided). [ENUM-REF-CANDIDATE: draft|calculated|pending_approval|approved|rejected|payment_initiated|paid|disputed|cancelled — 9 candidates stripped; promote to reference product]',
    `settlement_type` STRING COMMENT 'Category of settlement run indicating the nature of the financial arrangement: MVNO wholesale billing, roaming IOT (Inter-Operator Tariff) settlement, content provider revenue share, dealer/agent commission payout, interconnect carrier settlement, or equipment vendor rebate.. Valid values are `mvno_wholesale|roaming_iot|content_revenue_share|dealer_commission|interconnect_settlement|equipment_rebate`',
    `source_system` STRING COMMENT 'Name of the operational system that generated or calculated this settlement run (e.g., Amdocs Revenue Management, Oracle Communications Order and Service Management, custom settlement engine).',
    `source_system_reference` STRING COMMENT 'The unique identifier or transaction ID of this settlement run in the originating operational system, enabling traceability and audit.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax (VAT, GST, withholding tax) applied to the settlement amount, as required by applicable tax regulations and the partner agreement terms.',
    `total_settlement_amount` DECIMAL(18,2) COMMENT 'The aggregate financial amount calculated for this settlement run, representing the net payable or receivable between Telecommunication and the partner. Positive values indicate amounts owed to the partner; negative values indicate amounts owed by the partner.',
    CONSTRAINT pk_settlement_run PRIMARY KEY(`settlement_run_id`)
) COMMENT 'Periodic financial settlement execution records between Telecommunication and its partners — MVNO wholesale billing cycles, roaming IOT settlement batches, content revenue share disbursements, and dealer commission payouts. Captures settlement period, run date, total calculated amount, currency, approval status, payment instruction reference, and reconciliation outcome. Serves as the header record for settlement_line detail items.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`settlement_line` (
    `settlement_line_id` BIGINT COMMENT 'Unique identifier for the settlement line item record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Settlement lines are governed by specific partner agreements. While settlement_line already links to settlement_run (which links to partner_agreement), direct linkage enables line-level agreement vali',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Settlement line items may trace to specific billing accounts for detailed reconciliation. Required for granular settlement reconciliation, account-level revenue tracking, and partner billing integrati',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Settlement costs (wholesale, roaming, interconnect) must be allocated to cost centers for operational cost management, variance analysis, and departmental budgeting. Essential for network operations a',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Settlement line items must post to specific GL accounts (interconnect revenue, roaming expense, wholesale COGS) for financial statement preparation, audit trail, and revenue/expense recognition. Funda',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Settlement lines may reference specific invoices for reconciliation. Required for settlement-to-invoice matching, dispute resolution, and financial reconciliation between partner settlements and billi',
    `rate_id` BIGINT COMMENT 'Reference to the specific Inter-Operator Tariff (IOT) rate agreement used for this settlement line. Applicable for roaming and interconnect settlements.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Settlement line items for partner commissions/revenue share must reference source order lines for dispute resolution, audit trail, and reconciliation - required for telecommunications partner financia',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Wholesale/MVNO traffic settlement often references specific managed services (e.g., white-label IoT connectivity, wholesale SD-WAN). Business process: usage-based settlement reconciliation for resold ',
    `nrtrde_record_id` BIGINT COMMENT 'Reference to the Near Real-Time Roaming Data Exchange (NRTRDE) record used for real-time roaming settlement validation.',
    `partner_id` BIGINT COMMENT 'Reference to the partner or vendor for whom this settlement line is calculated. Identifies the counterparty in the settlement transaction.',
    `rated_event_id` BIGINT COMMENT 'Foreign key linking to billing.rated_event. Business justification: Settlement lines for usage-based charges trace to rated events. Required for usage-based settlement reconciliation, roaming event settlement, and detailed event-level financial tracking in telecommuni',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Settlement line items (roaming, interconnect revenue) feed regulatory filings for revenue reporting, universal service fund contributions, and interconnection reporting. Essential for automated regula',
    `revenue_analytics_kpi_id` BIGINT COMMENT 'Foreign key linking to analytics.revenue_analytics_kpi. Business justification: Settlement lines (wholesale roaming, MVNO, interconnect revenue) feed revenue analytics KPIs measured by product line, channel, and region. Finance and analytics teams reconcile partner settlement rev',
    `revenue_share_plan_id` BIGINT COMMENT 'Foreign key linking to partner.revenue_share_plan. Business justification: Settlement lines apply specific revenue share plans to calculate partner compensation. The line has revenue_share_percentage embedded, but should reference the full revenue_share_plan for tier structu',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Settlement line items are allocated by service territory for cost center accounting, regulatory reporting (USO obligations), franchise fee calculations, and partner performance analysis by geography. ',
    `settlement_run_id` BIGINT COMMENT 'Reference to the parent settlement run that contains this line item. Links this detail record to its header settlement batch.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Settlement line disputes and adjustments often reference trouble tickets documenting service quality issues, outages, or fraud events that justify credit notes, rate adjustments, or dispute claims in ',
    `wholesale_agreement_id` BIGINT COMMENT 'Reference to the wholesale or Mobile Virtual Network Operator (MVNO) host agreement governing the rates and terms for this settlement line.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Manual or system-generated adjustment to the settlement line. Includes corrections, credits, or penalties applied after initial rating.',
    `approval_status` STRING COMMENT 'Current approval workflow status for this settlement line item. Tracks internal review and authorization before finalization.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Identifier or name of the user or system that approved this settlement line item for payment or invoicing.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this settlement line item was approved for processing.',
    `cdr_count` STRING COMMENT 'Number of Call Detail Records (CDRs) or usage events aggregated into this settlement line item. Provides traceability to source usage data.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this settlement line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this settlement line.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this settlement line based on volume commitments, promotional agreements, or Service Level Agreement (SLA) credits.',
    `dispute_raised_date` DATE COMMENT 'Date when a dispute was formally raised against this settlement line item.',
    `dispute_reason` STRING COMMENT 'Explanation or category of the dispute raised for this settlement line. Captures partner objections or reconciliation discrepancies.',
    `dispute_status` STRING COMMENT 'Current status of any dispute raised against this settlement line item. Tracks reconciliation exceptions and partner challenges.. Valid values are `none|pending|under_review|resolved|escalated`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total settlement amount before adjustments, discounts, or taxes. Calculated as usage volume multiplied by rate applied.',
    `line_description` STRING COMMENT 'Detailed textual description of this settlement line item. Provides additional context for manual review and audit purposes.',
    `line_sequence_number` STRING COMMENT 'Sequential ordering of this line item within the parent settlement run. Used for sorting and display purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this settlement line record was last updated or modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final settlement amount payable or receivable after all discounts, adjustments, and taxes. This is the amount that will be paid or collected.',
    `notes` STRING COMMENT 'Free-form notes or comments related to this settlement line. Used for documenting exceptions, special handling, or reconciliation findings.',
    `originating_network` STRING COMMENT 'Identifier of the network where the usage or transaction originated. Relevant for roaming and interconnect settlements.',
    `product_code` STRING COMMENT 'Identifier of the specific product or service offering associated with this settlement line. Maps to the product catalog entry.',
    `product_name` STRING COMMENT 'Human-readable name of the product or service offering for this settlement line item.',
    `rap_file_reference` STRING COMMENT 'Reference to the Returned Account Procedure (RAP) file containing acknowledgments or rejections related to this settlement line.',
    `rate_applied` DECIMAL(18,2) COMMENT 'Per-unit rate applied to calculate the settlement amount. Represents the wholesale rate, Inter-Operator Tariff (IOT), or revenue share percentage.',
    `rate_type` STRING COMMENT 'Classification of the rating method applied. Distinguishes between fixed rates, tiered pricing, percentage-based revenue sharing, and Inter-Operator Tariff (IOT) rates.. Valid values are `fixed|tiered|percentage|iot|wholesale|revenue_share`',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process comparing this settlement line against partner-provided data or Near Real-Time Roaming Data Exchange (NRTRDE) records.. Valid values are `pending|matched|variance|approved|rejected`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue allocated to the partner for content, Over-The-Top (OTT), or value-added services. Expressed as a decimal (e.g., 30.00 for 30%).',
    `roaming_country_code` STRING COMMENT 'Three-letter ISO country code where roaming usage occurred. Applicable for international roaming settlement lines.. Valid values are `^[A-Z]{3}$`',
    `service_type` STRING COMMENT 'Category of telecommunications service for which this settlement line is generated. Distinguishes between voice, data, messaging, content, and wholesale services. [ENUM-REF-CANDIDATE: voice|sms|data|roaming|content|wholesale|mvno|ott|iptv|vod — 10 candidates stripped; promote to reference product]',
    `settlement_period_end_date` DATE COMMENT 'Ending date of the usage or service period covered by this settlement line item.',
    `settlement_period_start_date` DATE COMMENT 'Beginning date of the usage or service period covered by this settlement line item.',
    `tap_file_reference` STRING COMMENT 'Reference to the Transferred Account Procedure (TAP) file from which roaming usage data was sourced for this settlement line.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for this settlement line based on applicable tax jurisdictions and rates.',
    `terminating_network` STRING COMMENT 'Identifier of the network where the usage or transaction terminated. Relevant for roaming and interconnect settlements.',
    `traffic_category` STRING COMMENT 'Classification of network traffic type for rating and settlement purposes. Distinguishes on-net, off-net, international, and roaming traffic patterns. [ENUM-REF-CANDIDATE: on_net|off_net|international|roaming_inbound|roaming_outbound|premium|standard — 7 candidates stripped; promote to reference product]',
    `usage_date` DATE COMMENT 'Specific date when the usage or service transaction occurred. Used for daily granularity in settlement reconciliation.',
    `usage_unit` STRING COMMENT 'Unit of measurement for the usage volume. Defines whether volume is measured in time, data, count, or other units. [ENUM-REF-CANDIDATE: minutes|seconds|mb|gb|messages|sessions|transactions — 7 candidates stripped; promote to reference product]',
    `usage_volume` DECIMAL(18,2) COMMENT 'Quantity of service usage for this settlement line. Represents minutes, megabytes, messages, or transactions depending on service type.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between calculated settlement amount and partner-reported amount. Positive values indicate amounts owed to us; negative values indicate amounts we owe.',
    CONSTRAINT pk_settlement_line PRIMARY KEY(`settlement_line_id`)
) COMMENT 'Individual line-item detail records within a partner settlement run — per-service, per-product, or per-traffic-category charges and credits. Captures service type, usage volume, rated amount, applicable IOT/wholesale rate, adjustments, and dispute status. Enables granular reconciliation of MVNO wholesale charges, roaming IOT items, and content revenue share line items.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`onboarding_request` (
    `onboarding_request_id` BIGINT COMMENT 'Unique identifier for the partner onboarding request. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Onboarding workflow results in a partner_agreement being created. Once the contract is executed (contract_execution_date populated), the onboarding_request should link to the resulting partner_agreeme',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Partner onboarding triggers compliance audits (KYC, AML, regulatory fitness checks, technical compliance validation). Links onboarding workflow to audit records for compliance verification, regulatory',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Partner onboarding often creates or links to corporate account for partners own service needs during onboarding. Business process: partner lifecycle management, consolidated credit assessment (partne',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Partner onboarding activities (due diligence, integration, testing) incur costs that must be tracked to cost centers for partner acquisition cost analysis, ROI calculation, and business development bu',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Onboarding requests can be for dealer partners specifically. When partner_type indicates dealer/channel partner, this FK links to the dealer record being onboarded. Allows dealer-specific onboarding w',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity being onboarded. Links to the partner master record.',
    `api_connectivity_validated` BOOLEAN COMMENT 'Indicates whether API connectivity testing has been successfully completed and validated.',
    `application_date` DATE COMMENT 'Date when the partner submitted the initial onboarding application.',
    `approval_date` DATE COMMENT 'Date when the onboarding request received final approval to proceed to activation.',
    `assigned_owner` STRING COMMENT 'Name or identifier of the business user responsible for managing this onboarding request through completion.',
    `cancellation_date` DATE COMMENT 'Date when the onboarding request was cancelled by either party before completion.',
    `cancellation_reason` STRING COMMENT 'Explanation of why the onboarding request was cancelled, including which party initiated the cancellation.',
    `compliance_notes` STRING COMMENT 'Additional notes regarding regulatory compliance requirements, exceptions, or special considerations for this partner onboarding.',
    `contract_effective_date` DATE COMMENT 'Date when the partner contract terms become legally effective and binding.',
    `contract_execution_date` DATE COMMENT 'Date when the partner contract was formally executed and signed by all parties.',
    `contract_expiry_date` DATE COMMENT 'Date when the partner contract is scheduled to expire unless renewed.',
    `contract_status` STRING COMMENT 'Status of the partner contract execution process, tracking progression from draft through final execution. [ENUM-REF-CANDIDATE: Not Started|Draft|Under Review|Negotiation|Approved|Executed|Rejected — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this onboarding request record was first created in the system.',
    `credit_assessment_status` STRING COMMENT 'Status of the financial credit assessment to evaluate the partners creditworthiness and financial stability.. Valid values are `Not Started|In Progress|Approved|Rejected|Conditional`',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit limit approved for the partner in the base currency. Determines financial exposure limits.',
    `credit_score` STRING COMMENT 'Numerical credit score assigned to the partner based on financial assessment. Used to determine credit terms and risk level.',
    `documentation_checklist_complete` BOOLEAN COMMENT 'Indicates whether all required onboarding documentation has been received and verified as complete.',
    `go_live_actual_date` DATE COMMENT 'Actual date when the partner was activated and went live in production systems.',
    `go_live_target_date` DATE COMMENT 'Planned target date for partner activation and go-live in production systems.',
    `integration_test_completion_date` DATE COMMENT 'Date when all technical integration testing was successfully completed and approved.',
    `kyc_completion_date` DATE COMMENT 'Date when the KYC due diligence process was completed and approved.',
    `kyc_status` STRING COMMENT 'Status of the Know Your Customer (KYC) due diligence process for regulatory compliance and risk assessment.. Valid values are `Not Started|In Progress|Documents Pending|Under Review|Approved|Rejected`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this onboarding request record was last updated or modified.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this onboarding request record.',
    `onboarding_status` STRING COMMENT 'Current lifecycle state of the onboarding request workflow. Tracks progression from initial application through approval or rejection. [ENUM-REF-CANDIDATE: Draft|Submitted|KYC In Progress|Credit Assessment|Contract Review|Technical Integration|Approved|Rejected|Cancelled — 9 candidates stripped; promote to reference product]',
    `owner_email` STRING COMMENT 'Email address of the assigned owner for communication and notifications regarding this onboarding request.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `priority_level` STRING COMMENT 'Business priority assigned to this onboarding request, determining resource allocation and processing urgency.. Valid values are `Low|Medium|High|Critical`',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory approval was granted by the relevant governing body.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval process with governing bodies such as Federal Communications Commission (FCC) or International Telecommunication Union (ITU) where required for partner activation.. Valid values are `Not Required|Pending|Submitted|Under Review|Approved|Rejected`',
    `rejection_date` DATE COMMENT 'Date when the onboarding request was rejected and the process terminated.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the onboarding request was rejected, including specific criteria or requirements not met.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the onboarding request, formatted as ONB-NNNNNNNN.. Valid values are `^ONB-[0-9]{8}$`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue allocated to the partner under the revenue sharing agreement. Expressed as a decimal (e.g., 15.50 for 15.5%).',
    `revenue_sharing_model` STRING COMMENT 'Type of revenue sharing arrangement agreed with the partner: Fixed Fee, Percentage-based, Tiered structure, Hybrid model, or Cost Plus.. Valid values are `Fixed Fee|Percentage|Tiered|Hybrid|Cost Plus`',
    `risk_rating` STRING COMMENT 'Overall risk assessment rating for the partner relationship based on financial, operational, and compliance factors.. Valid values are `Low|Medium|High|Critical`',
    `settlement_frequency` STRING COMMENT 'Frequency at which financial settlements and revenue sharing payments are processed with the partner.. Valid values are `Daily|Weekly|Monthly|Quarterly|Annual`',
    `sla_terms_defined` BOOLEAN COMMENT 'Indicates whether Service Level Agreement (SLA) terms have been defined and agreed upon with the partner.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Precise date and time when the onboarding request was formally submitted for processing.',
    `tap_file_exchange_validated` BOOLEAN COMMENT 'Indicates whether TAP file exchange validation for roaming data has been successfully completed. Applicable for roaming partners and Mobile Virtual Network Operator (MVNO) relationships.',
    `technical_integration_status` STRING COMMENT 'Status of technical integration testing including Application Programming Interface (API) connectivity, Transferred Account Procedure (TAP) file exchange validation, and system integration testing. [ENUM-REF-CANDIDATE: Not Started|Planning|API Testing|TAP Validation|System Integration|UAT|Approved|Failed — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_onboarding_request PRIMARY KEY(`onboarding_request_id`)
) COMMENT 'Partner onboarding workflow records tracking end-to-end partner activation — from initial application through KYC/due diligence, credit assessment, contract execution, technical integration testing (API connectivity, TAP file exchange validation), and go-live activation. Captures onboarding stage, assigned owner, documentation checklist, regulatory approval status, and milestone dates. Aligned with TM Forum SID PartyRole lifecycle state management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`dealer` (
    `dealer_id` BIGINT COMMENT 'Unique identifier for the dealer record. Primary key.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Dealers/agents are businesses consuming enterprise services (office internet, SD-WAN, UCaaS for sales teams). Business process: dealer incentive programs tied to own service consumption, consolidated ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Dealer channel operations incur costs (commissions, training, support, POS systems) that must be allocated to cost centers for indirect channel cost management, dealer profitability analysis, and chan',
    `master_agent_dealer_id` BIGINT COMMENT 'Reference to the parent master agent in the channel hierarchy if this dealer operates as a sub-agent.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Dealer/retail channel management requires internal relationship owner for activation quota management, compliance audits, POS system integration, and commission settlement. Critical for indirect sales',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Dealers may be tracked as sub-segments within indirect channel profit centers for dealer performance reporting, contribution margin analysis, and channel mix optimization. Common in multi-tier distrib',
    `revenue_share_plan_id` BIGINT COMMENT 'Foreign key linking to partner.revenue_share_plan. Business justification: Dealers have commission structures that should reference standardized revenue_share_plan definitions. The commission_structure_reference is a string that should be replaced with a proper FK to revenue',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Dealers are assigned exclusive or primary service territories for sales operations. Required for commission calculations, monthly activation quota enforcement, channel conflict resolution, and territo',
    `activation_credential_code` STRING COMMENT 'Unique credential or API key identifier used by the dealer to authenticate and perform service activations in carrier systems.',
    `authorized_product_portfolio` STRING COMMENT 'Comma-separated list or description of product categories and service offerings the dealer is authorized to sell.',
    `authorized_territory` STRING COMMENT 'Geographic region, market area, or territory where the dealer is authorized to conduct sales and service activities.',
    `bank_account_number` STRING COMMENT 'Dealers bank account number for commission payments and revenue settlement.',
    `bank_routing_number` STRING COMMENT 'Bank routing or sort code for electronic funds transfer to the dealer.',
    `business_address_line1` STRING COMMENT 'Primary street address line for the dealers principal place of business.',
    `business_address_line2` STRING COMMENT 'Secondary street address line for suite, unit, or building details of the dealers business location.',
    `business_city` STRING COMMENT 'City or municipality where the dealers principal place of business is located.',
    `business_country_code` STRING COMMENT 'Three-letter ISO country code for the dealers principal business location.. Valid values are `^[A-Z]{3}$`',
    `business_postal_code` STRING COMMENT 'Postal or ZIP code for the dealers business address.',
    `business_state_province` STRING COMMENT 'State, province, or administrative region where the dealers business is located.',
    `certification_expiry_date` DATE COMMENT 'Date when the dealers current compliance certification expires and requires renewal.',
    `channel_type` STRING COMMENT 'Classification of the indirect sales channel participant role within the partner ecosystem.. Valid values are `dealer|agent|master_agent|independent_rep|retail_partner|sub_agent`',
    `compliance_certification_status` STRING COMMENT 'Current status of the dealers compliance certification indicating whether they meet regulatory and carrier policy requirements.. Valid values are `certified|pending|expired|suspended|not_certified`',
    `contract_effective_date` DATE COMMENT 'Date when the dealer agreement became legally effective and operational.',
    `contract_expiry_date` DATE COMMENT 'Date when the current dealer agreement expires or is scheduled for renewal.',
    `contract_renewal_terms` STRING COMMENT 'Description of the renewal terms, conditions, and notice period requirements for the dealer agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dealer record was first created in the system.',
    `dealer_code` STRING COMMENT 'Externally-known unique business identifier assigned to the dealer for operational reference and system integration.. Valid values are `^[A-Z0-9]{6,12}$`',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or performance audit conducted on the dealer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the dealer record was most recently updated.',
    `legal_entity_name` STRING COMMENT 'The official registered legal name of the dealer organization as recorded with regulatory authorities.',
    `lifecycle_status` STRING COMMENT 'Current operational state of the dealer relationship within its lifecycle from onboarding through termination.. Valid values are `active|suspended|terminated|pending_approval|onboarding|inactive`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified the dealer record.',
    `monthly_activation_quota` STRING COMMENT 'Target number of new service activations the dealer is expected to achieve per month as per agreement terms.',
    `next_audit_scheduled_date` DATE COMMENT 'Scheduled date for the next compliance or performance audit of the dealer.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special instructions, or contextual information about the dealer.',
    `onboarding_completed_date` DATE COMMENT 'Date when the dealer successfully completed all onboarding requirements and became operationally active.',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment settlement of commissions or revenue share to the dealer.',
    `pos_integration_endpoint` STRING COMMENT 'API endpoint URL or system integration identifier for connecting the dealers POS system to carrier BSS/OSS platforms.',
    `pos_system_type` STRING COMMENT 'Type or vendor name of the point-of-sale system used by the dealer for transaction processing and inventory management.',
    `primary_contact_email` STRING COMMENT 'Primary email address for operational communication with the dealer organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person responsible for dealer relationship management.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for voice communication with the dealer organization.',
    `sla_performance_tier` STRING COMMENT 'Current performance tier classification based on the dealers adherence to contractual SLA commitments.. Valid values are `exceeds|meets|below|critical`',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identifier for the dealer entity used for revenue reporting and compliance.',
    `termination_date` DATE COMMENT 'Date when the dealer relationship was terminated or the agreement ended.',
    `termination_reason` STRING COMMENT 'Business reason or cause for termination of the dealer relationship.',
    `tier_grade` STRING COMMENT 'Performance-based tier classification indicating the dealers standing, sales volume, and benefit level within the channel program.. Valid values are `platinum|gold|silver|bronze|standard`',
    `trade_name` STRING COMMENT 'The business trading name under which the dealer operates and is publicly known.',
    CONSTRAINT pk_dealer PRIMARY KEY(`dealer_id`)
) COMMENT 'Master registry of all authorized indirect sales channel participants — dealers, retail partners, master agents, sub-agents, and independent sales representatives. SSOT for channel partner identity, trade name, channel type classification (dealer/agent/master_agent/independent_rep), authorized product portfolio, geographic territory, tier/grade, commission structure reference, activation credentials, POS system integration details, hierarchy relationships (master agent → sub-agent), and compliance certification status. Aligned with TM Forum SID PartnerRole specialization for indirect channel management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`partner_contact` (
    `partner_contact_id` BIGINT COMMENT 'Unique identifier for the partner contact record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Partner contact management systems require audit trail of who created contact records for data governance, GDPR compliance, and CRM data quality accountability in telecommunications partner ecosystems',
    `partner_id` BIGINT COMMENT 'Reference to the partner organization this contact represents. Links to the partner master entity.',
    `authorization_level` STRING COMMENT 'Level of decision-making authority granted to this contact for partner-related transactions and agreements.. Valid values are `view_only|operational|approval_authority|executive`',
    `billing_notification_enabled` BOOLEAN COMMENT 'Indicates whether this contact should receive billing statements, invoices, and settlement notifications.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the partner contact indicating availability for business communication.. Valid values are `active|inactive|on_leave|terminated`',
    `contact_type` STRING COMMENT 'Classification of the contacts role within the partner organization. Defines the functional area this contact represents.. Valid values are `account_manager|technical_lead|billing_contact|legal_representative|escalation_contact|operations_contact`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this partner contact record was first created in the system.',
    `department` STRING COMMENT 'Organizational unit or department within the partner organization where this contact is assigned.',
    `effective_end_date` DATE COMMENT 'Date when this contacts authorization to represent the partner organization in their designated role ends or ended. Null for open-ended assignments.',
    `effective_start_date` DATE COMMENT 'Date when this contact became active and authorized to represent the partner organization in their designated role.',
    `email_address` STRING COMMENT 'Primary email address for business communication with the partner contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_level` STRING COMMENT 'Numeric level in the escalation hierarchy, with lower numbers representing first-line contacts and higher numbers representing executive escalation.',
    `fax_number` STRING COMMENT 'Facsimile number for document transmission, primarily used for legal or formal communications.',
    `first_name` STRING COMMENT 'Given name of the partner contact representative.',
    `full_name` STRING COMMENT 'Complete formatted name of the partner contact for display and communication purposes.',
    `is_escalation_contact` BOOLEAN COMMENT 'Indicates whether this contact should be included in escalation procedures for critical issues or Service Level Agreement (SLA) breaches.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the primary point of contact for their designated role within the partner organization.',
    `job_title` STRING COMMENT 'Official position or role title of the contact within the partner organization.',
    `last_contact_date` DATE COMMENT 'Date of the most recent business interaction or communication with this partner contact.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this partner contact record was most recently updated.',
    `last_name` STRING COMMENT 'Family name or surname of the partner contact representative.',
    `mobile_number` STRING COMMENT 'Mobile telephone number for urgent or mobile communication with the partner contact.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special instructions, or context about the partner contact.',
    `office_location` STRING COMMENT 'Physical office location or site identifier where the contact is based within the partner organization.',
    `phone_number` STRING COMMENT 'Primary business telephone number for voice communication with the partner contact.',
    `preferred_communication_method` STRING COMMENT 'Contacts preferred channel for routine business communication and coordination.. Valid values are `email|phone|mobile|video_conference|instant_message`',
    `preferred_language` STRING COMMENT 'Preferred language for business communication with the contact, using ISO 639-1 two-letter language codes.',
    `secondary_email_address` STRING COMMENT 'Alternate email address for backup communication or out-of-office scenarios.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sla_notification_enabled` BOOLEAN COMMENT 'Indicates whether this contact should receive automated notifications for Service Level Agreement (SLA) performance, breaches, or warnings.',
    `technical_notification_enabled` BOOLEAN COMMENT 'Indicates whether this contact should receive technical integration alerts, system maintenance notifications, and operational updates.',
    `time_zone` STRING COMMENT 'Time zone of the contacts primary work location for scheduling and coordination purposes.',
    CONSTRAINT pk_partner_contact PRIMARY KEY(`partner_contact_id`)
) COMMENT 'Named contact directory for partner organization representatives — account managers, technical integration leads, billing/settlement contacts, legal representatives, and escalation contacts. Captures contact role, communication preferences, organizational unit, and active status. Serves inter-company operational coordination distinct from end-customer CRM contact management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` (
    `partner_sla_measurement_id` BIGINT COMMENT 'Unique identifier for the partner SLA measurement record.',
    `agreement_id` BIGINT COMMENT 'Reference to the partner agreement under which this SLA measurement is captured.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SLA breaches trigger penalty costs, remediation expenses, and operational overhead that must be tracked to cost centers for SLA cost impact analysis, partner management efficiency, and quality cost re',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: SLA breaches may trigger credits applied to specific invoices. Required for SLA credit application, performance-based billing adjustments, and linking SLA measurements to billing impacts in telecommun',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: SLA measurements track specific KPIs (network availability, call success rate, data throughput). Linking to kpi_definition ensures consistent metric definitions, calculation formulas, and thresholds a',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity being measured.',
    `performance_measurement_id` BIGINT COMMENT 'Foreign key linking to assurance.performance_measurement. Business justification: Partner SLA measurements must reference underlying network performance measurements for validation, dispute resolution, and audit trail when partners challenge SLA breach determinations or penalty cal',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: SLA performance data (wholesale, MVNO services) feeds regulatory quality-of-service filings. Critical for automated regulatory QoS reporting, demonstrating compliance with service quality mandates, an',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to partner.sla_definition. Business justification: SLA measurements are taken against specific SLA definitions. The measurement record has sla_metric_type and sla_metric_name as strings, but should reference the authoritative sla_definition to get tar',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual measured value for the SLA metric during the measurement period.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved the SLA measurement for finalization.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when the SLA measurement was approved.',
    `breach_severity` STRING COMMENT 'The severity level of the SLA breach if non-compliant (none, minor, moderate, major, critical).. Valid values are `none|minor|moderate|major|critical`',
    `compliance_status` STRING COMMENT 'Indicates whether the actual performance met the SLA target (compliant, non-compliant, marginal, not measured).. Valid values are `compliant|non_compliant|marginal|not_measured`',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions taken to address the SLA breach and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the SLA measurement record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The calculated service credit amount in the agreement currency for the SLA breach.',
    `credit_applicable` BOOLEAN COMMENT 'Indicates whether a service credit applies for this SLA breach.',
    `dispute_reason` STRING COMMENT 'The reason provided by the partner for disputing the SLA measurement.',
    `dispute_status` STRING COMMENT 'Indicates whether the SLA measurement is under dispute by the partner (none, raised, under review, resolved, escalated).. Valid values are `none|raised|under_review|resolved|escalated`',
    `escalation_level` STRING COMMENT 'The level of escalation required for the SLA breach (none, operational, tactical, executive).. Valid values are `none|operational|tactical|executive`',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether the SLA breach requires escalation to management or partner review.',
    `geographic_scope` STRING COMMENT 'The geographic region or coverage area for this SLA measurement (e.g., national, regional, specific market).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the SLA measurement record was last modified.',
    `measurement_confidence_level` DECIMAL(18,2) COMMENT 'The statistical confidence level of the measurement expressed as a percentage (e.g., 95.00 for 95% confidence).',
    `measurement_method` STRING COMMENT 'The methodology or calculation approach used to derive the SLA metric value.',
    `measurement_period_end` TIMESTAMP COMMENT 'The end timestamp of the SLA measurement period.',
    `measurement_period_start` TIMESTAMP COMMENT 'The start timestamp of the SLA measurement period.',
    `measurement_source` STRING COMMENT 'The source system or method used to capture the SLA measurement (e.g., NMS, OSS, partner report, third-party monitor).. Valid values are `nms|oss|bss|partner_report|third_party_monitor|manual`',
    `measurement_status` STRING COMMENT 'The current lifecycle status of the SLA measurement record (draft, validated, approved, disputed, finalized).. Valid values are `draft|validated|approved|disputed|finalized`',
    `measurement_timestamp` TIMESTAMP COMMENT 'The timestamp when the SLA measurement was captured or calculated.',
    `network_element_type` STRING COMMENT 'The type of network element or infrastructure component being measured (e.g., RAN, core network, transport, CPE).',
    `notes` STRING COMMENT 'Additional notes or comments regarding the SLA measurement, breach circumstances, or partner communication.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The calculated penalty amount in the agreement currency for the SLA breach.',
    `penalty_applicable` BOOLEAN COMMENT 'Indicates whether a contractual penalty applies for this SLA breach.',
    `reporting_period` STRING COMMENT 'The frequency or granularity of the SLA reporting period (e.g., hourly, daily, weekly, monthly, quarterly, annual).. Valid values are `hourly|daily|weekly|monthly|quarterly|annual`',
    `root_cause_category` STRING COMMENT 'The high-level category of the root cause for SLA non-compliance (e.g., network outage, capacity constraint, partner issue, force majeure).',
    `root_cause_description` STRING COMMENT 'Detailed description of the root cause analysis for the SLA breach.',
    `sample_size` BIGINT COMMENT 'The number of data points or observations used to calculate the SLA metric.',
    `service_type` STRING COMMENT 'The type of service covered by this SLA measurement (e.g., network access, content delivery, roaming services).',
    `target_value` DECIMAL(18,2) COMMENT 'The committed target value for the SLA metric as defined in the partner agreement.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the SLA metric values (e.g., percent, milliseconds, hours, count). [ENUM-REF-CANDIDATE: percent|milliseconds|seconds|minutes|hours|days|count|mbps|gbps — 9 candidates stripped; promote to reference product]',
    `validated_by` STRING COMMENT 'The name or identifier of the person or system that validated the SLA measurement.',
    `validated_timestamp` TIMESTAMP COMMENT 'The timestamp when the SLA measurement was validated.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the target value.',
    `variance_value` DECIMAL(18,2) COMMENT 'The calculated variance between actual and target values (actual minus target).',
    CONSTRAINT pk_partner_sla_measurement PRIMARY KEY(`partner_sla_measurement_id`)
) COMMENT 'Operational records of SLA performance measurements against partner agreements — periodic KPI snapshots capturing actual vs. committed performance for network availability, QoS metrics, MTTR, settlement timeliness, and content delivery quality. Feeds partner performance reviews, penalty/credit calculations, and contract renewal assessments.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`partner_dispute` (
    `partner_dispute_id` BIGINT COMMENT 'Unique identifier for the partner dispute record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the specific partner agreement or contract under which the dispute arose.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Partner disputes may trigger compliance audits or be referenced in audit findings (billing accuracy, SLA compliance, settlement disputes). Essential for audit trail, dispute resolution documentation, ',
    `billing_charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Partner disputes may target specific charges. Required for charge-level dispute resolution, granular dispute tracking, and linking partner disputes to specific billing charges in telecommunications op',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Dispute resolution activities (investigation, arbitration, legal) incur operational costs that must be tracked to cost centers for dispute management cost analysis, partner relationship quality metric',
    `dq_issue_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_issue. Business justification: Partner billing disputes frequently originate from data quality issues (TAP file errors, rating mismatches, duplicate CDRs). Linking disputes to DQ issues enables root cause analysis, prevents recurre',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee or team responsible for managing and resolving the dispute.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Partner disputes often reference specific invoices. Required for invoice-level dispute tracking, billing dispute resolution, and linking partner disputes to underlying billing documents in telecommuni',
    `partner_id` BIGINT COMMENT 'Reference to the partner involved in the dispute (MVNO, content provider, roaming partner, equipment vendor, dealer, agent).',
    `settlement_run_id` BIGINT COMMENT 'Foreign key linking to partner.settlement_run. Business justification: Many partner disputes arise from specific settlement runs (disputed amounts, calculation errors, data discrepancies). This FK links the dispute to the settlement run that triggered it. The dispute rec',
    `sla_breach_event_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_breach_event. Business justification: Partner disputes about SLA penalties or credits must reference the specific SLA breach event as evidence for dispute substantiation, penalty negotiation, and arbitration proceedings per partner agreem',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to partner.sla_definition. Business justification: When disputes involve SLA breaches (sla_breach_flag = true), this FK links to the specific sla_definition that was allegedly breached. The dispute has sla_metric_breached as a string, but linking to s',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Partner disputes about service quality, outage impact, or settlement adjustments reference specific trouble tickets as evidence for root cause validation, impact assessment, and dispute resolution or ',
    `acknowledged_date` DATE COMMENT 'Date when the receiving party formally acknowledged receipt of the dispute.',
    `agreed_adjustment_amount` DECIMAL(18,2) COMMENT 'The final monetary adjustment amount agreed upon as part of the dispute resolution (positive for credits to partner, negative for debits).',
    `agreed_adjustment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the agreed adjustment amount.. Valid values are `^[A-Z]{3}$`',
    `arbitration_body` STRING COMMENT 'Name of the third-party arbitration or dispute resolution body engaged to resolve the dispute (e.g., GSMA Dispute Resolution Service, ICC Arbitration).',
    `assigned_department` STRING COMMENT 'Name of the internal department or business unit responsible for handling the dispute (e.g., Partner Finance, Roaming Operations, Legal).',
    `closed_date` DATE COMMENT 'Date when the dispute record was administratively closed and all follow-up actions completed.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions implemented to resolve the dispute and prevent recurrence (e.g., process changes, system fixes, rate updates).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was first created in the system, supporting audit trail and data lineage.',
    `credit_note_reference` STRING COMMENT 'Reference number of any credit note issued as a result of the dispute resolution.',
    `direction` STRING COMMENT 'Indicates whether the dispute was raised by the telecommunications company against the partner, or raised by the partner against the company.. Valid values are `raised_by_us|raised_against_us`',
    `dispute_category` STRING COMMENT 'High-level categorization of the dispute domain: financial (billing, settlement), operational (SLA, service delivery), technical (network, system), legal (contract interpretation), commercial (pricing, terms), or regulatory (compliance).. Valid values are `financial|operational|technical|legal|commercial|regulatory`',
    `dispute_description` STRING COMMENT 'Detailed narrative description of the dispute, including the nature of the disagreement, affected services, and initial claim.',
    `dispute_number` STRING COMMENT 'Externally visible unique reference number for the dispute, used in communications with the partner and in GSMA dispute resolution procedures.',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute: draft (being prepared), submitted (formally raised), under review (initial assessment), investigation (evidence gathering), negotiation (parties discussing), escalated (moved to higher authority), arbitration (formal dispute resolution), resolved (agreement reached), closed (finalized), withdrawn (retracted by initiator), or rejected (deemed invalid). [ENUM-REF-CANDIDATE: draft|submitted|under_review|investigation|negotiation|escalated|arbitration|resolved|closed|withdrawn|rejected — 11 candidates stripped; promote to reference product]',
    `dispute_type` STRING COMMENT 'Classification of the dispute nature: settlement discrepancy, SLA breach, billing error, roaming IOT charge dispute, revenue share disagreement, contractual obligation violation, quality of service issue, data accuracy dispute, fraud claim, or other. [ENUM-REF-CANDIDATE: settlement_discrepancy|sla_breach|billing_error|roaming_iot_charge|revenue_share_dispute|contractual_obligation|quality_of_service|data_accuracy|fraud_claim|other — 10 candidates stripped; promote to reference product]',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The monetary value in dispute, representing the amount being contested by either party.',
    `disputed_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `escalated_to_arbitration_flag` BOOLEAN COMMENT 'Boolean indicator of whether the dispute has been escalated to formal arbitration or third-party dispute resolution.',
    `escalation_level` STRING COMMENT 'Numeric indicator of the current escalation tier (e.g., 1=operational, 2=management, 3=executive, 4=arbitration), reflecting the dispute resolution hierarchy.',
    `escalation_path` STRING COMMENT 'Description of the escalation workflow or path defined for this dispute, including roles and decision points at each level.',
    `initiating_party` STRING COMMENT 'Identifies which party initiated the dispute: the partner or the internal telecommunications company.. Valid values are `partner|internal`',
    `internal_response` STRING COMMENT 'Summary of the internal telecommunications companys formal response to the dispute, including position, evidence, and proposed resolution.',
    `invoice_adjustment_reference` STRING COMMENT 'Reference number of any invoice adjustment or correction applied as a result of the dispute resolution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was last updated, supporting change tracking and audit requirements.',
    `partner_response` STRING COMMENT 'Summary of the partners formal response to the dispute, including their position, counter-claims, or acceptance.',
    `preventive_action_recommended` STRING COMMENT 'Recommendations for preventive measures to avoid similar disputes in the future, including process improvements and control enhancements.',
    `priority` STRING COMMENT 'Priority level assigned to the dispute based on business impact, disputed amount, and partner relationship criticality.. Valid values are `critical|high|medium|low`',
    `raised_date` DATE COMMENT 'Date when the dispute was formally raised or submitted by the initiating party.',
    `raised_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the dispute was formally raised or submitted, supporting audit trail and SLA tracking.',
    `reason_code` STRING COMMENT 'Standardized code representing the specific reason for the dispute, aligned with GSMA dispute reason taxonomies where applicable.',
    `resolution_description` STRING COMMENT 'Detailed narrative of the final resolution, including agreed actions, adjustments, credits, or other remedies.',
    `resolution_due_date` DATE COMMENT 'Target date by which the dispute should be resolved, based on contractual SLA or GSMA dispute resolution timelines.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the dispute resolution: accepted (claim upheld), rejected (claim denied), partially accepted (compromise), settled (mutual agreement), arbitrated (third-party decision), or withdrawn (claim retracted).. Valid values are `accepted|rejected|partially_accepted|settled|arbitrated|withdrawn`',
    `resolved_date` DATE COMMENT 'Date when the dispute was formally resolved and agreement reached between parties.',
    `responding_party` STRING COMMENT 'Identifies which party is responding to the dispute: the partner or the internal telecommunications company.. Valid values are `partner|internal`',
    `root_cause_category` STRING COMMENT 'High-level categorization of the underlying root cause identified during dispute investigation. [ENUM-REF-CANDIDATE: data_quality|system_error|process_failure|contractual_ambiguity|rate_discrepancy|service_failure|fraud|other — 8 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed description of the root cause analysis findings, including contributing factors and systemic issues identified.',
    `settlement_period_end_date` DATE COMMENT 'End date of the settlement or billing period to which the dispute relates.',
    `settlement_period_start_date` DATE COMMENT 'Start date of the settlement or billing period to which the dispute relates.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the dispute relates to a breach of contractual SLA commitments.',
    `sla_metric_breached` STRING COMMENT 'Specific SLA metric or KPI that was breached and is the subject of the dispute (e.g., network availability, call completion rate, response time).',
    `supporting_evidence_reference` STRING COMMENT 'Reference identifier or location of supporting documentation, evidence files, CDRs, TAP files, invoices, or other materials substantiating the dispute claim.',
    CONSTRAINT pk_partner_dispute PRIMARY KEY(`partner_dispute_id`)
) COMMENT 'Formal dispute records raised by or against partners regarding settlement amounts, SLA breaches, billing discrepancies, roaming IOT charges, or contractual obligations. Captures dispute type, disputed amount, supporting evidence, resolution workflow stage, assigned owner, escalation path, and final resolution outcome. Supports GSMA dispute resolution procedures (AA.12/AA.14) and internal arbitration workflows.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`partner_certification` (
    `partner_certification_id` BIGINT COMMENT 'Unique identifier for the partner certification record. Primary key.',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity that holds this certification. Links to the partner master record (MVNO, content provider, equipment vendor, dealer, agent, roaming partner, OTT platform, or channel partner).',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Partner certifications (ISO, SOC2, telecom-specific certifications) fulfill specific regulatory obligations. Essential for compliance verification, audit evidence, regulatory approval processes, and d',
    `audit_frequency_months` STRING COMMENT 'The required frequency (in months) at which the partner must undergo compliance audits or recertification reviews to maintain this certification. Examples: 12 (annual), 24 (biennial), 36 (triennial). Nullable if no periodic audit is required.',
    `audit_outcome` STRING COMMENT 'The result of the most recent compliance audit or recertification review. Indicates whether the partner passed the audit, passed with minor conditions/findings, failed and requires corrective action, or audit is pending completion.. Valid values are `passed|passed_with_conditions|failed|not_applicable|pending`',
    `authority` STRING COMMENT 'The name of the regulatory body, standards organization, or certifying entity that issued the certification. Examples: Federal Communications Commission (FCC), European Telecommunications Standards Institute (ETSI), International Telecommunication Union (ITU), International Organization for Standardization (ISO), GSM Association (GSMA), Office of Communications (Ofcom), national telecommunications regulatory authorities.',
    `authority_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the jurisdiction of the certifying authority (e.g., USA for FCC, GBR for Ofcom, DEU for BNetzA). Used for multi-jurisdiction compliance tracking.. Valid values are `^[A-Z]{3}$`',
    `bond_amount` DECIMAL(18,2) COMMENT 'The monetary value of the performance bond or financial guarantee required from the partner. Expressed in the base currency of the business. Nullable if no bond is required.',
    `bond_expiry_date` DATE COMMENT 'The expiration date of the partners performance bond or financial guarantee. Used to monitor bond coverage continuity. Nullable if no bond is required.',
    `bond_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the partner is required to post a performance bond or financial guarantee as a condition of this certification (common for dealer/agent licenses and spectrum licenses). True if bond is required, False otherwise.',
    `certification_level` STRING COMMENT 'The tier or grade of certification achieved by the partner, if the certification framework includes multiple levels. Examples: Gold/Silver/Bronze partner tiers, Level 1/2/3 dealer authorization, Basic/Advanced/Expert agent certification. Nullable if the certification does not have levels.',
    `certification_number` STRING COMMENT 'The official certificate number or registration identifier issued by the certifying authority. This is the externally-known unique identifier for the certification (e.g., FCC Equipment Authorization number, ETSI type approval certificate number, ISO 27001 certificate number, dealer license number).',
    `certification_scope` STRING COMMENT 'Detailed description of what the certification covers. For equipment type approval: device models and frequency bands. For spectrum licenses: frequency ranges and geographic coverage. For dealer licenses: authorized product categories and sales territories. For ISO certifications: certified processes and business units.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Indicates whether the certification is active and valid, expired and requires renewal, suspended by the regulatory body, pending renewal workflow, revoked due to non-compliance, or under review by the certifying authority.. Valid values are `active|expired|suspended|pending_renewal|revoked|under_review`',
    `certification_type` STRING COMMENT 'The category of certification held by the partner. Classifies the regulatory or compliance certification into business-relevant types: equipment type approval (CPE, ONT, OLT, handset), spectrum licensing (MVNO spectrum rights), dealer/agent regulatory certifications, content provider broadcasting licenses, ISO/security certifications (ISO 27001, SOC 2), MVNO host authorizations, roaming agreement certifications, or vendor qualification certificates. [ENUM-REF-CANDIDATE: equipment_type_approval|spectrum_license|dealer_license|agent_certification|content_broadcasting_license|iso_certification|security_certification|mvno_host_authorization|roaming_agreement_certification|vendor_qualification — 10 candidates stripped; promote to reference product]',
    `certified_product_category` STRING COMMENT 'The product or service category that this certification authorizes the partner to provide, sell, or operate. Examples: CPE (Customer Premises Equipment), mobile handsets, FTTH (Fiber to the Home) equipment, MVNO (Mobile Virtual Network Operator) services, IPTV (Internet Protocol Television) content, broadband services.',
    `compliance_standard` STRING COMMENT 'The technical or quality standard that the partner must comply with under this certification. Examples: ISO 9001 (quality management), ISO 27001 (information security), SOC 2 Type II (service organization controls), PCI DSS (payment card industry data security), GDPR (data protection).',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which the partner must complete corrective actions to address audit findings or non-compliance issues. Nullable if no corrective action is required.',
    `corrective_action_status` STRING COMMENT 'Current status of corrective actions required to address audit findings. Tracks whether corrective action is not required, open and not started, in progress, completed by partner, overdue, or verified/closed by the certifying authority.. Valid values are `not_required|open|in_progress|completed|overdue|verified`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was first created in the system. Used for audit trail and data lineage tracking.',
    `document_url` STRING COMMENT 'The file path or URL to the digital copy of the official certification document, certificate, or license. Used for document management and audit trail purposes.',
    `effective_start_date` DATE COMMENT 'The date from which the certification becomes legally effective and the partner is authorized to operate under its terms. May differ from issue_date if there is a grace period or delayed activation.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. After this date, the partner must renew the certification or cease operations requiring this certification. Nullable for perpetual certifications.',
    `frequency_band` STRING COMMENT 'The radio frequency spectrum band(s) covered by this certification, applicable to spectrum licenses and equipment type approvals. Examples: 700 MHz, 2.5 GHz, 3.5 GHz (CBRS), 28 GHz (5G mmWave), 2.4 GHz/5 GHz (Wi-Fi). Nullable for non-spectrum certifications.',
    `geographic_coverage` STRING COMMENT 'The geographic region or territory where this certification is valid and the partner is authorized to operate. Examples: nationwide, specific states/provinces, regional (e.g., EU, APAC), or global. Particularly relevant for spectrum licenses, dealer territories, and content broadcasting licenses.',
    `insurance_expiry_date` DATE COMMENT 'The expiration date of the partners insurance policy. Used to monitor insurance coverage continuity and trigger renewal alerts. Nullable if insurance is not required.',
    `insurance_policy_number` STRING COMMENT 'The policy number of the insurance coverage maintained by the partner to satisfy certification requirements. Nullable if insurance is not required or not yet provided.',
    `insurance_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the partner is required to maintain specific insurance coverage (liability, professional indemnity, errors and omissions) as a condition of this certification. True if insurance is required, False otherwise.',
    `internal_owner_name` STRING COMMENT 'The name of the internal employee or team responsible for managing this partner certification relationship on behalf of the telecommunications business. Used for internal accountability and workflow routing.',
    `issue_date` DATE COMMENT 'The date on which the certification was officially issued or granted by the certifying authority. Marks the start of the certifications validity period.',
    `last_audit_date` DATE COMMENT 'The date of the most recent compliance audit or recertification review conducted for this certification. Used to calculate next audit due date and track audit history.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was most recently updated. Used for audit trail, change tracking, and data quality monitoring.',
    `last_renewal_date` DATE COMMENT 'The date on which the certification was most recently renewed. Used to track renewal history and calculate next renewal cycle.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next compliance audit or recertification review. Calculated based on last_audit_date and audit_frequency_months. Used to trigger audit preparation workflows.',
    `non_compliance_findings_count` STRING COMMENT 'The number of non-compliance findings or deficiencies identified in the most recent audit. Used to assess partner compliance risk and prioritize corrective action follow-up.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to this certification. May include details on certification restrictions, conditional approvals, or historical context.',
    `regulatory_body_reference` STRING COMMENT 'The specific regulation, standard, or legal framework under which this certification was issued. Examples: FCC Part 15 (radio frequency devices), ETSI EN 300 328 (wideband transmission), ITU-T G.984 (GPON), ISO/IEC 27001:2013 (information security), 3GPP TS 23.501 (5G system architecture).',
    `renewal_due_date` DATE COMMENT 'The target date by which the certification renewal process must be initiated or completed to avoid lapse. Typically set ahead of expiry_date to allow for processing time. Used to trigger renewal workflow alerts.',
    `renewal_workflow_status` STRING COMMENT 'Current state of the certification renewal workflow process. Tracks whether renewal has been initiated, documents submitted to the authority, under review, approved, rejected, or on hold pending additional information. [ENUM-REF-CANDIDATE: not_started|in_progress|documents_submitted|under_authority_review|approved|rejected|on_hold — 7 candidates stripped; promote to reference product]',
    `responsible_party_email` STRING COMMENT 'The email address of the responsible party at the partner organization. Used for certification renewal notifications, audit scheduling, and compliance communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_name` STRING COMMENT 'The name of the individual or role within the partner organization who is responsible for maintaining this certification and ensuring ongoing compliance. Used for escalation and communication purposes.',
    `technology_standard` STRING COMMENT 'The telecommunications technology standard or protocol that this certification covers. Examples: LTE (Long-Term Evolution), 5G NR (5G New Radio), GPON (Gigabit Passive Optical Network), VoLTE (Voice over LTE), IMS (IP Multimedia Subsystem), Wi-Fi 6 (802.11ax). Applicable to equipment and network certifications.',
    CONSTRAINT pk_partner_certification PRIMARY KEY(`partner_certification_id`)
) COMMENT 'Compliance and certification records for partners — dealer/agent regulatory certifications, equipment vendor type approval certificates, MVNO spectrum licensing, content provider broadcasting licenses, and ISO/security certifications. Tracks certification authority, issue date, expiry date, renewal workflow status, and regulatory body reference (FCC, ETSI, ITU).';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`partner`.`scorecard` (
    `scorecard_id` BIGINT COMMENT 'Unique identifier for the partner scorecard evaluation record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Partner scorecards evaluate performance under specific partner agreements. A partner may have multiple agreements (e.g., MVNO hosting + roaming), and scorecards should be tied to the specific agreemen',
    `analytical_subject_area_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_subject_area. Business justification: Partner scorecards are analytical products belonging to the "Partner Management Analytics" subject area. This link enables data governance, lineage tracking, and access control for partner performance',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Partner scorecards include compliance metrics and may be reviewed during compliance audits. Links performance evaluation to audit processes for compliance performance tracking, audit evidence, and dem',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Partner scorecards evaluate performance using standardized KPIs (revenue contribution, SLA compliance, dispute resolution rate). The composite score aggregates multiple KPI definitions. Linking enable',
    `partner_id` BIGINT COMMENT 'Reference to the partner being evaluated in this scorecard.',
    `prior_period_scorecard_id` BIGINT COMMENT 'Self-referencing FK on scorecard (prior_period_scorecard_id)',
    `action_plan_due_date` DATE COMMENT 'Target date by which the partner must submit or complete a performance improvement action plan.',
    `action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal performance improvement action plan is required based on scorecard outcomes.',
    `approval_date` DATE COMMENT 'Date on which the scorecard evaluation was officially approved by authorized management.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the scorecard evaluation.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Performance score reflecting the partners adherence to regulatory, contractual, and internal compliance requirements.',
    `composite_score` DECIMAL(18,2) COMMENT 'Overall weighted performance score aggregating all evaluation dimensions, typically on a 0-100 scale.',
    `contract_renewal_recommendation` STRING COMMENT 'Recommendation regarding contract renewal or termination based on scorecard evaluation outcomes.. Valid values are `renew|renegotiate|terminate|extend|review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scorecard record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this scorecard.. Valid values are `^[A-Z]{3}$`',
    `current_tier` STRING COMMENT 'Current tier classification of the partner at the time of this scorecard evaluation.. Valid values are `platinum|gold|silver|bronze|standard`',
    `customer_satisfaction_score` DECIMAL(18,2) COMMENT 'Customer satisfaction score for services or products delivered through this partner, typically measured via surveys or Net Promoter Score (NPS).',
    `dispute_count` STRING COMMENT 'Total number of disputes raised by or against the partner during the evaluation period.',
    `dispute_frequency_score` DECIMAL(18,2) COMMENT 'Performance score reflecting the frequency and severity of disputes raised during the evaluation period, with lower dispute counts yielding higher scores.',
    `dispute_resolution_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of disputes successfully resolved during the evaluation period.',
    `evaluation_frequency` STRING COMMENT 'Frequency at which this partner scorecard evaluation is conducted.. Valid values are `quarterly|semi-annual|annual|ad-hoc`',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period covered by this scorecard.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period covered by this scorecard.',
    `evaluator_department` STRING COMMENT 'Department or business unit responsible for conducting the scorecard evaluation.',
    `evaluator_name` STRING COMMENT 'Name of the individual or team responsible for conducting the scorecard evaluation.',
    `improvement_areas_summary` STRING COMMENT 'Narrative summary of areas requiring improvement or corrective action identified during the evaluation.',
    `innovation_contribution_score` DECIMAL(18,2) COMMENT 'Performance score reflecting the partners contribution to innovation, new product development, or technology advancement initiatives.',
    `investment_priority` STRING COMMENT 'Priority level for allocating partner development resources, training, and support investments based on scorecard outcomes.. Valid values are `high|medium|low|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this scorecard record was last modified.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next partner scorecard evaluation.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the scorecard evaluation.',
    `operational_quality_score` DECIMAL(18,2) COMMENT 'Performance score reflecting operational excellence metrics such as service delivery quality, responsiveness, and process adherence.',
    `publication_date` DATE COMMENT 'Date on which the scorecard evaluation was published or communicated to the partner.',
    `recommended_tier` STRING COMMENT 'Recommended tier classification for the partner based on scorecard evaluation outcomes, which may trigger tier reclassification decisions. [ENUM-REF-CANDIDATE: platinum|gold|silver|bronze|standard|downgrade|terminate — 7 candidates stripped; promote to reference product]',
    `revenue_contribution_amount` DECIMAL(18,2) COMMENT 'Total revenue generated or contributed by the partner during the evaluation period.',
    `revenue_contribution_score` DECIMAL(18,2) COMMENT 'Performance score reflecting the partners revenue generation and growth contribution during the evaluation period.',
    `revenue_growth_percentage` DECIMAL(18,2) COMMENT 'Year-over-year or period-over-period revenue growth rate for this partner, expressed as a percentage.',
    `review_date` DATE COMMENT 'Date on which the scorecard evaluation was formally reviewed and finalized.',
    `risk_rating` STRING COMMENT 'Overall risk classification assigned to the partner based on financial stability, operational risk, compliance risk, and strategic risk factors.. Valid values are `low|medium|high|critical`',
    `scorecard_number` STRING COMMENT 'Business identifier for the scorecard evaluation, typically formatted as year-quarter-partner code for traceability.',
    `scorecard_status` STRING COMMENT 'Current lifecycle status of the scorecard evaluation record.. Valid values are `draft|in-review|approved|published|archived`',
    `sla_breach_count` STRING COMMENT 'Total number of SLA breaches recorded for this partner during the evaluation period.',
    `sla_compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of SLA metrics met or exceeded by the partner during the evaluation period.',
    `sla_compliance_score` DECIMAL(18,2) COMMENT 'Performance score reflecting the partners adherence to contractual SLA commitments during the evaluation period.',
    `strategic_alignment_score` DECIMAL(18,2) COMMENT 'Performance score reflecting the partners alignment with strategic business objectives, innovation initiatives, and long-term roadmap.',
    `strengths_summary` STRING COMMENT 'Narrative summary of the partners key strengths and positive performance areas identified during the evaluation.',
    `tier_change_flag` BOOLEAN COMMENT 'Indicates whether a tier reclassification is recommended based on this scorecard evaluation.',
    CONSTRAINT pk_scorecard PRIMARY KEY(`scorecard_id`)
) COMMENT 'Periodic partner performance evaluation records summarizing commercial, operational, and strategic value of each partner relationship. Captures quarterly/annual review outcomes, composite performance scores across revenue contribution, SLA compliance, dispute frequency, growth trajectory, and strategic alignment. Drives tier reclassification decisions, contract renewal recommendations, and partner development investment priorities.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ADD CONSTRAINT `fk_partner_partner_parent_partner_id` FOREIGN KEY (`parent_partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_revenue_share_plan_id` FOREIGN KEY (`revenue_share_plan_id`) REFERENCES `telecommunication_ecm`.`partner`.`revenue_share_plan`(`revenue_share_plan_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ADD CONSTRAINT `fk_partner_mvno_profile_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ADD CONSTRAINT `fk_partner_roaming_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ADD CONSTRAINT `fk_partner_sla_definition_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ADD CONSTRAINT `fk_partner_revenue_share_plan_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ADD CONSTRAINT `fk_partner_settlement_run_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_revenue_share_plan_id` FOREIGN KEY (`revenue_share_plan_id`) REFERENCES `telecommunication_ecm`.`partner`.`revenue_share_plan`(`revenue_share_plan_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_settlement_run_id` FOREIGN KEY (`settlement_run_id`) REFERENCES `telecommunication_ecm`.`partner`.`settlement_run`(`settlement_run_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ADD CONSTRAINT `fk_partner_settlement_line_wholesale_agreement_id` FOREIGN KEY (`wholesale_agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_dealer_id` FOREIGN KEY (`dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ADD CONSTRAINT `fk_partner_onboarding_request_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ADD CONSTRAINT `fk_partner_dealer_master_agent_dealer_id` FOREIGN KEY (`master_agent_dealer_id`) REFERENCES `telecommunication_ecm`.`partner`.`dealer`(`dealer_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ADD CONSTRAINT `fk_partner_dealer_revenue_share_plan_id` FOREIGN KEY (`revenue_share_plan_id`) REFERENCES `telecommunication_ecm`.`partner`.`revenue_share_plan`(`revenue_share_plan_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ADD CONSTRAINT `fk_partner_partner_sla_measurement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ADD CONSTRAINT `fk_partner_partner_sla_measurement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ADD CONSTRAINT `fk_partner_partner_sla_measurement_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_settlement_run_id` FOREIGN KEY (`settlement_run_id`) REFERENCES `telecommunication_ecm`.`partner`.`settlement_run`(`settlement_run_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `telecommunication_ecm`.`partner`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ADD CONSTRAINT `fk_partner_partner_certification_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ADD CONSTRAINT `fk_partner_scorecard_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `telecommunication_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ADD CONSTRAINT `fk_partner_scorecard_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `telecommunication_ecm`.`partner`.`partner`(`partner_id`);
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ADD CONSTRAINT `fk_partner_scorecard_prior_period_scorecard_id` FOREIGN KEY (`prior_period_scorecard_id`) REFERENCES `telecommunication_ecm`.`partner`.`scorecard`(`scorecard_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`partner` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `telecommunication_ecm`.`partner` SET TAGS ('dbx_domain' = 'partner');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` SET TAGS ('dbx_subdomain' = 'partner_operations');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `parent_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempted');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `contract_renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `contract_renewal_type` SET TAGS ('dbx_value_regex' = 'auto_renew|manual_renew|fixed_term|evergreen');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Doing Business As (DBA) Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `industry_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{18,20}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partner Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `operating_countries` SET TAGS ('dbx_business_glossary_term' = 'Operating Countries');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Legal Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_onboarding|terminated|under_review');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `partner_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|basic|custom');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `revenue_share_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Signed By Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'mvno_host|roaming_bilateral|content_licensing|ott_platform|equipment_supply|dealer_commission');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|on_demand');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `confidentiality_period_years` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Period in Years');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `data_protection_addendum_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Addendum Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `data_sharing_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Permitted Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `document_repository_url` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `document_repository_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `fixed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Fee Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `fixed_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `insurance_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `minimum_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `minimum_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `penalty_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Cap Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `penalty_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period in Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Model');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_value_regex' = 'fixed_fee|percentage_revenue|tiered_revenue|usage_based|hybrid');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Termination Penalty Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Host Agreement Identifier');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Partner Identifier');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Rate Plan Identifier');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `apn_configuration` SET TAGS ('dbx_business_glossary_term' = 'Access Point Name (APN) Configuration');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `billing_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Arrangement Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `billing_arrangement_type` SET TAGS ('dbx_value_regex' = 'wholesale_rated|retail_billed|hybrid|self_billed');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `current_subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Current Subscriber Count');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `esim_support_enabled` SET TAGS ('dbx_business_glossary_term' = 'Embedded Subscriber Identity Module (eSIM) Support Enabled');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `five_g_access_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fifth Generation (5G) Access Enabled');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `hlr_provisioning_enabled` SET TAGS ('dbx_business_glossary_term' = 'Home Location Register (HLR) Provisioning Enabled');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `hss_provisioning_enabled` SET TAGS ('dbx_business_glossary_term' = 'Home Subscriber Server (HSS) Provisioning Enabled');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `imsi_range_end` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI) Range End');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `imsi_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `imsi_range_end` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `imsi_range_start` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI) Range Start');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `imsi_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `imsi_range_start` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `international_roaming_enabled` SET TAGS ('dbx_business_glossary_term' = 'International Roaming Enabled');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `msisdn_range_end` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN) Range End');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `msisdn_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `msisdn_range_end` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `msisdn_range_start` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN) Range Start');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `msisdn_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `msisdn_range_start` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `mvno_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Brand Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `mvno_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `mvno_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `mvno_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Legal Entity Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `mvno_type` SET TAGS ('dbx_business_glossary_term' = 'Mobile Virtual Network Operator (MVNO) Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `mvno_type` SET TAGS ('dbx_value_regex' = 'full_mvno|light_mvno|branded_reseller|esp|mvne');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `network_access_type` SET TAGS ('dbx_business_glossary_term' = 'Network Access Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `network_access_type` SET TAGS ('dbx_value_regex' = 'full_access|ran_sharing|core_sharing|resale_only');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `noc_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Network Operations Center (NOC) Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `noc_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `noc_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_activation|under_review');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `qos_profile` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `roaming_enabled` SET TAGS ('dbx_business_glossary_term' = 'Roaming Enabled');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `sla_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency Milliseconds');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `spectrum_access_rights` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Access Rights');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `subscriber_capacity_limit` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Capacity Limit');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `volte_enabled` SET TAGS ('dbx_business_glossary_term' = 'Voice over Long-Term Evolution (VoLTE) Enabled');
ALTER TABLE `telecommunication_ecm`.`partner`.`mvno_profile` ALTER COLUMN `vowifi_enabled` SET TAGS ('dbx_business_glossary_term' = 'Voice over Wi-Fi (VoWiFi) Enabled');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Roaming Agreement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiated By Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Roaming Agreement Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'bilateral|multilateral|regional|global|preferred|standard');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `coverage_countries` SET TAGS ('dbx_business_glossary_term' = 'Coverage Countries');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `data_mb_rate` SET TAGS ('dbx_business_glossary_term' = 'Data Megabyte (MB) Rate');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `data_mb_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `dispute_resolution_period_days` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Period Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `fraud_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fraud Monitoring Enabled');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `fraud_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Fraud Threshold Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `gsma_aa12_compliant` SET TAGS ('dbx_business_glossary_term' = 'GSMA AA.12 Compliant');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `gsma_aa13_compliant` SET TAGS ('dbx_business_glossary_term' = 'GSMA AA.13 Compliant');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `iot_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Inter-Operator Tariff (IOT) Rate Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `iot_rate_type` SET TAGS ('dbx_value_regex' = 'fixed|tiered|volume_based|time_based|hybrid');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `nrtrde_enabled` SET TAGS ('dbx_business_glossary_term' = 'Near Real-Time Roaming Data Exchange (NRTRDE) Enabled');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `nrtrde_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Near Real-Time Roaming Data Exchange (NRTRDE) Threshold Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `partner_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Signatory Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `preferred_partner_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Partner Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `rap_version` SET TAGS ('dbx_business_glossary_term' = 'Returned Account Procedure (RAP) Version');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `rap_version` SET TAGS ('dbx_value_regex' = '^RAP[0-9]{1,2}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `roaming_direction` SET TAGS ('dbx_business_glossary_term' = 'Roaming Direction');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `roaming_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|bidirectional');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `service_types_covered` SET TAGS ('dbx_business_glossary_term' = 'Service Types Covered');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `settlement_period_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `sla_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Availability Percent');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `sla_call_success_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Call Success Rate Percent');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `sla_data_throughput_mbps` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Data Throughput Megabits Per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `sms_rate` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Rate');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `sms_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `steering_policy` SET TAGS ('dbx_business_glossary_term' = 'Roaming Steering Policy');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `steering_policy` SET TAGS ('dbx_value_regex' = 'automatic|manual|preferred|cost_based|quality_based');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `tap_file_frequency` SET TAGS ('dbx_business_glossary_term' = 'Transferred Account Procedure (TAP) File Frequency');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `tap_file_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|real_time');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `tap_version` SET TAGS ('dbx_business_glossary_term' = 'Transferred Account Procedure (TAP) Version');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `tap_version` SET TAGS ('dbx_value_regex' = '^TAP3.[0-9]{1,2}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `technology_standards` SET TAGS ('dbx_business_glossary_term' = 'Technology Standards Supported');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `voice_mou_rate` SET TAGS ('dbx_business_glossary_term' = 'Voice Minute of Use (MOU) Rate');
ALTER TABLE `telecommunication_ecm`.`partner`.`roaming_agreement` ALTER COLUMN `voice_mou_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition Identifier');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Identifier');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Required Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `credit_formula` SET TAGS ('dbx_business_glossary_term' = 'Credit Calculation Formula');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `dispute_resolution_window_days` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Window (Days)');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `escalation_threshold` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `exclusion_conditions` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Conditions');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `measurement_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|daily|weekly|per_incident');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `metric_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Description');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipients');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `notification_threshold` SET TAGS ('dbx_business_glossary_term' = 'Notification Threshold');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'mvno|content_provider|roaming_partner|equipment_vendor|channel_partner|ott_platform');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `penalty_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Cap Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `penalty_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Cap Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `penalty_cap_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `penalty_formula` SET TAGS ('dbx_business_glossary_term' = 'Penalty Calculation Formula');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `reporting_format` SET TAGS ('dbx_business_glossary_term' = 'Reporting Format');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `sla_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `sla_definition_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'uptime|qos|mttr|settlement|dispute_resolution|performance');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Value');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Threshold Value');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`partner`.`sla_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `revenue_share_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan ID');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `applicable_product_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Scope');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `applicable_service_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Calculation Method');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'percentage_split|fixed_rate_per_unit|tiered_percentage|tiered_fixed|hybrid|cost_plus_margin');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `dispute_resolution_process` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Process');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `exchange_rate_source` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Source');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `fixed_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Rate Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `maximum_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Threshold Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `minimum_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Threshold Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Description');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `settlement_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `sla_target_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Accuracy Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `tier_structure_flag` SET TAGS ('dbx_business_glossary_term' = 'Tiered Structure Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`revenue_share_plan` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `settlement_run_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `payment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Completion Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `payment_instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Reference');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|reconciled|discrepancy_identified|escalated');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `reconciliation_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `run_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Execution Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `run_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'mvno_wholesale|roaming_iot|content_revenue_share|dealer_commission|interconnect_settlement|equipment_rebate');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_run` ALTER COLUMN `total_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Settlement Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `settlement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Line Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Inter-Operator Tariff (IOT) Rate Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `nrtrde_record_id` SET TAGS ('dbx_business_glossary_term' = 'Near Real-Time Roaming Data Exchange (NRTRDE) Record Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `rated_event_id` SET TAGS ('dbx_business_glossary_term' = 'Rated Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `revenue_analytics_kpi_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Analytics Kpi Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `revenue_share_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `settlement_run_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `wholesale_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Agreement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `cdr_count` SET TAGS ('dbx_business_glossary_term' = 'Call Detail Record (CDR) Count');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|pending|under_review|resolved|escalated');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `originating_network` SET TAGS ('dbx_business_glossary_term' = 'Originating Network');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `rap_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Returned Account Procedure (RAP) File Reference');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Rate Applied');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'fixed|tiered|percentage|iot|wholesale|revenue_share');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|variance|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `roaming_country_code` SET TAGS ('dbx_business_glossary_term' = 'Roaming Country Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `roaming_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `tap_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Transferred Account Procedure (TAP) File Reference');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `terminating_network` SET TAGS ('dbx_business_glossary_term' = 'Terminating Network');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `traffic_category` SET TAGS ('dbx_business_glossary_term' = 'Traffic Category');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `usage_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `usage_unit` SET TAGS ('dbx_business_glossary_term' = 'Usage Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `usage_volume` SET TAGS ('dbx_business_glossary_term' = 'Usage Volume');
ALTER TABLE `telecommunication_ecm`.`partner`.`settlement_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` SET TAGS ('dbx_subdomain' = 'partner_operations');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `onboarding_request_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Request ID');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `api_connectivity_validated` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Connectivity Validated');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `assigned_owner` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `contract_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `credit_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Assessment Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `credit_assessment_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Approved|Rejected|Conditional');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `documentation_checklist_complete` SET TAGS ('dbx_business_glossary_term' = 'Documentation Checklist Complete');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `go_live_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Actual Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `go_live_target_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Target Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `integration_test_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Integration Test Completion Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Completion Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Documents Pending|Under Review|Approved|Rejected');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Email Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'Not Required|Pending|Submitted|Under Review|Approved|Rejected');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Request Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^ONB-[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Sharing Model');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_value_regex' = 'Fixed Fee|Percentage|Tiered|Hybrid|Cost Plus');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'Daily|Weekly|Monthly|Quarterly|Annual');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `sla_terms_defined` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Terms Defined');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `tap_file_exchange_validated` SET TAGS ('dbx_business_glossary_term' = 'Transferred Account Procedure (TAP) File Exchange Validated');
ALTER TABLE `telecommunication_ecm`.`partner`.`onboarding_request` ALTER COLUMN `technical_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Technical Integration Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` SET TAGS ('dbx_subdomain' = 'partner_operations');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `master_agent_dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Master Agent Identifier');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `revenue_share_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `activation_credential_code` SET TAGS ('dbx_business_glossary_term' = 'Activation Credential Identifier');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `activation_credential_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `activation_credential_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `authorized_product_portfolio` SET TAGS ('dbx_business_glossary_term' = 'Authorized Product Portfolio');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `authorized_territory` SET TAGS ('dbx_business_glossary_term' = 'Authorized Geographic Territory');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 1');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 2');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Business City');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_country_code` SET TAGS ('dbx_business_glossary_term' = 'Business Country Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Business Postal Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_state_province` SET TAGS ('dbx_business_glossary_term' = 'Business State or Province');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `business_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'dealer|agent|master_agent|independent_rep|retail_partner|sub_agent');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `compliance_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `compliance_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|expired|suspended|not_certified');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `contract_renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Terms');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `contract_renewal_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `dealer_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `dealer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_approval|onboarding|inactive');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `monthly_activation_quota` SET TAGS ('dbx_business_glossary_term' = 'Monthly Activation Quota');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `monthly_activation_quota` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `next_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Scheduled Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `onboarding_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completed Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `pos_integration_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Integration Endpoint');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `pos_integration_endpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `pos_system_type` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) System Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `sla_performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Performance Tier');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `sla_performance_tier` SET TAGS ('dbx_value_regex' = 'exceeds|meets|below|critical');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `tier_grade` SET TAGS ('dbx_business_glossary_term' = 'Tier Grade');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `tier_grade` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `telecommunication_ecm`.`partner`.`dealer` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` SET TAGS ('dbx_subdomain' = 'partner_operations');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `partner_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'view_only|operational|approval_authority|executive');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `billing_notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Billing Notification Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'account_manager|technical_lead|billing_contact|legal_representative|escalation_contact|operations_contact');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `is_escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Escalation Contact Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `preferred_communication_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Method');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `preferred_communication_method` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|video_conference|instant_message');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_business_glossary_term' = 'Secondary Email Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `sla_notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Notification Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `technical_notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Technical Notification Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `partner_sla_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Service Level Agreement (SLA) Measurement ID');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement ID');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `performance_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Measurement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|critical');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|marginal|not_measured');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `credit_applicable` SET TAGS ('dbx_business_glossary_term' = 'Credit Applicable Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|raised|under_review|resolved|escalated');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|operational|tactical|executive');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `measurement_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Measurement Confidence Level');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'nms|oss|bss|partner_report|third_party_monitor|manual');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'draft|validated|approved|disputed|finalized');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `network_element_type` SET TAGS ('dbx_business_glossary_term' = 'Network Element Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `penalty_applicable` SET TAGS ('dbx_business_glossary_term' = 'Penalty Applicable Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|quarterly|annual');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validated Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_sla_measurement` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Value');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `partner_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Dispute Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `billing_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `dq_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Issue Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `settlement_run_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `sla_breach_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Breach Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `acknowledged_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Acknowledged Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `agreed_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Adjustment Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `agreed_adjustment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Agreed Adjustment Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `agreed_adjustment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `arbitration_body` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Body');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Closed Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `credit_note_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Reference');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Dispute Direction');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'raised_by_us|raised_against_us');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Category');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_value_regex' = 'financial|operational|technical|legal|commercial|regulatory');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `disputed_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Disputed Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `disputed_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `escalated_to_arbitration_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalated to Arbitration Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `initiating_party` SET TAGS ('dbx_business_glossary_term' = 'Initiating Party');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `initiating_party` SET TAGS ('dbx_value_regex' = 'partner|internal');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `internal_response` SET TAGS ('dbx_business_glossary_term' = 'Internal Response');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `invoice_adjustment_reference` SET TAGS ('dbx_business_glossary_term' = 'Invoice Adjustment Reference');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `partner_response` SET TAGS ('dbx_business_glossary_term' = 'Partner Response');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `preventive_action_recommended` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Recommended');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `raised_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `resolution_due_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Due Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partially_accepted|settled|arbitrated|withdrawn');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `resolved_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolved Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `responding_party` SET TAGS ('dbx_business_glossary_term' = 'Responding Party');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `responding_party` SET TAGS ('dbx_value_regex' = 'partner|internal');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `sla_metric_breached` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Breached');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_dispute` ALTER COLUMN `supporting_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence Reference');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` SET TAGS ('dbx_subdomain' = 'partner_operations');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `partner_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Certification Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_value_regex' = 'passed|passed_with_conditions|failed|not_applicable|pending');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `authority` SET TAGS ('dbx_business_glossary_term' = 'Certification Authority');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `authority_country_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Authority Country Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `authority_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `bond_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Bond Expiry Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `bond_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Bond Required Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_renewal|revoked|under_review');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `certified_product_category` SET TAGS ('dbx_business_glossary_term' = 'Certified Product Category');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_required|open|in_progress|completed|overdue|verified');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Frequency Band');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Expiry Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `internal_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Certification Renewal Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `non_compliance_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Findings Count');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `regulatory_body_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Reference');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Due Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `renewal_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Workflow Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`partner_certification` ALTER COLUMN `technology_standard` SET TAGS ('dbx_business_glossary_term' = 'Technology Standard');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` SET TAGS ('dbx_subdomain' = 'partner_operations');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Scorecard ID');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `analytical_subject_area_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Subject Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Composite Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `prior_period_scorecard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Due Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `action_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Required Flag');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Performance Score');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `contract_renewal_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Recommendation');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `contract_renewal_recommendation` SET TAGS ('dbx_value_regex' = 'renew|renegotiate|terminate|extend|review');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `current_tier` SET TAGS ('dbx_business_glossary_term' = 'Current Partner Tier');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `current_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `dispute_count` SET TAGS ('dbx_business_glossary_term' = 'Dispute Count');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `dispute_frequency_score` SET TAGS ('dbx_business_glossary_term' = 'Dispute Frequency Score');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `dispute_resolution_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Rate Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Frequency');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi-annual|annual|ad-hoc');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `evaluator_department` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Department');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `improvement_areas_summary` SET TAGS ('dbx_business_glossary_term' = 'Improvement Areas Summary');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `innovation_contribution_score` SET TAGS ('dbx_business_glossary_term' = 'Innovation Contribution Score');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `investment_priority` SET TAGS ('dbx_business_glossary_term' = 'Partner Development Investment Priority');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `investment_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `operational_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Operational Quality Score');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `recommended_tier` SET TAGS ('dbx_business_glossary_term' = 'Recommended Partner Tier');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `revenue_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Contribution Amount');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `revenue_contribution_score` SET TAGS ('dbx_business_glossary_term' = 'Revenue Contribution Score');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `revenue_growth_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Growth Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|in-review|approved|published|archived');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `sla_breach_count` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Count');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `sla_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Percentage');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `sla_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Score');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `strategic_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Strategic Alignment Score');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `telecommunication_ecm`.`partner`.`scorecard` ALTER COLUMN `tier_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Flag');
