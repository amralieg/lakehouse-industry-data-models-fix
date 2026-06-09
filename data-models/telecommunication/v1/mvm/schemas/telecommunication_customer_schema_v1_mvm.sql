-- Schema for Domain: customer | Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`customer` COMMENT 'SSOT for all subscriber identities, account hierarchies, and relationship data across B2C consumers, B2B enterprise accounts, and wholesale clients. Manages customer profiles, contacts, segments, household groupings, NPS/CSAT scores, CLTV segmentation, and CRM interactions managed via Salesforce CRM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`customer_account` (
    `customer_account_id` BIGINT COMMENT 'Unique system identifier for the customer account. Primary key for the customer account entity. Serves as the anchor for all customer-related data across billing, order, service, and usage domains.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Account-level bundle enrollment (e.g., triple-play, converged home bundle) drives billing, retention reporting, and upgrade/downgrade workflows. Telecom domain experts expect customer_account to refer',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Dealer commission calculation and acquisition attribution require linking customer accounts to the originating dealer. Telecom operators track which dealer acquired each account for revenue share sett',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Accounts enroll in specific offerings (promotional packages, enterprise solutions). Primary commercial relationship for order capture, contract management, and revenue recognition.',
    `parent_account_customer_account_id` BIGINT COMMENT 'Reference to parent account in hierarchical account structures. Used for enterprise customers with master account and sub-accounts, family plans with primary and secondary accounts, or wholesale relationships with reseller hierarchy. Null for standalone accounts. Enables consolidated billing and hierarchical reporting.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Accounts are assigned specific price plans for billing calculations. Essential for invoice generation, ARPU reporting, and revenue assurance in telecommunications billing systems.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to product.promo_offer. Business justification: Account-level loyalty and win-back promotions are applied at the account level. Retention analytics, promo budget tracking, and marketing attribution require knowing which promo_offer is active on an ',
    `account_number` STRING COMMENT 'Externally visible unique account number assigned to the customer. Used for customer communication, billing statements, and customer service interactions. Human-readable identifier distinct from internal system ID.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the customer account. Active accounts have full service access; suspended accounts have temporary service restrictions; terminated accounts are closed; pending activation accounts are awaiting provisioning; on hold accounts have administrative holds; delinquent accounts have payment issues.. Valid values are `active|suspended|terminated|pending_activation|on_hold|delinquent`',
    `account_tier` STRING COMMENT 'Service tier or loyalty level determining priority support, special offers, and premium features. Higher tiers receive enhanced customer service, exclusive promotions, and preferential treatment. Used for customer retention and lifetime value (CLTV) optimization.. Valid values are `basic|silver|gold|platinum|diamond|vip`',
    `account_type` STRING COMMENT 'Classification of the account based on billing and payment model. Prepaid accounts require balance top-up before service usage; postpaid accounts are billed after usage; hybrid accounts combine both models; wholesale accounts serve carrier partners; MVNO (Mobile Virtual Network Operator) accounts serve virtual operators; enterprise accounts serve business customers with custom arrangements.. Valid values are `prepaid|postpaid|hybrid|wholesale|mvno|enterprise`',
    `acquisition_channel` STRING COMMENT 'Sales channel through which customer account was originally acquired. Retail store for physical locations; online for web/mobile signup; telesales for inbound/outbound call center; dealer for authorized resellers; partner for co-marketing channels; direct sales for field sales teams; referral for customer referral programs. Used for channel performance analysis and commission attribution. [ENUM-REF-CANDIDATE: retail_store|online|telesales|dealer|partner|direct_sales|referral — 7 candidates stripped; promote to reference product]',
    `acquisition_date` DATE COMMENT 'Date when customer account was first created and customer relationship began. Used for customer tenure analysis, loyalty program eligibility, and customer lifetime value (CLTV) calculations. Critical metric for churn prediction models.',
    `activation_date` DATE COMMENT 'Date when account was activated and services became operational. May differ from acquisition date if provisioning or credit checks delayed activation. Used for service anniversary tracking and billing cycle start date determination.',
    `arpu` DECIMAL(18,2) COMMENT 'Average monthly revenue generated by this account over the trailing 12 months. Calculated as total revenue divided by number of active months. Expressed in account currency. Key metric for customer value assessment, segmentation, and churn impact analysis. Used for CLTV calculations and retention investment decisions.',
    `auto_pay_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic payment is configured for this account. True means payment method is automatically charged on due date; false requires manual payment. Reduces delinquency rates and improves cash flow predictability.',
    `billing_cycle_day` STRING COMMENT 'Day of month when billing cycle closes and invoice is generated. Value between 1 and 28 to accommodate all months. Determines invoice generation schedule and payment due dates. Critical for revenue recognition and cash flow management.',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether California resident has exercised right to opt out of personal information sale under CCPA. True means customer opted out; false means no opt-out request. Required for California customers. Restricts data sharing with third parties for marketing purposes.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Predictive score indicating likelihood of customer churn within next 90 days. Ranges from 0.00 (lowest risk) to 100.00 (highest risk). Generated by machine learning models analyzing usage patterns, payment behavior, support interactions, NPS scores, and competitive activity. Triggers proactive retention campaigns and win-back offers.',
    `cltv_segment` STRING COMMENT 'Segmentation based on predicted customer lifetime value. High segment represents most valuable customers with strong retention and upsell potential; medium segment shows moderate value; low segment indicates limited revenue potential; new segment for recently acquired customers without history; at risk segment for high-value customers with churn indicators. Drives retention investment prioritization.. Valid values are `high|medium|low|new|at_risk`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this customer account record was first created in the database. Immutable audit field. Used for data lineage, record age analysis, and compliance with data retention policies. Distinct from acquisition date which represents business event time.',
    `credit_class` STRING COMMENT 'Credit risk classification based on credit bureau assessment and payment history. Determines deposit requirements, credit limits, and payment terms. Excellent and good classes receive favorable terms; fair and poor classes may require deposits; no credit check applies to prepaid; secured accounts have collateral.. Valid values are `excellent|good|fair|poor|no_credit_check|secured`',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for postpaid accounts before service suspension. Determined by credit class, payment history, and account tenure. Expressed in account currency. Null for prepaid accounts.',
    `csat_score` DECIMAL(18,2) COMMENT 'Most recent Customer Satisfaction score ranging from 1.0 (very dissatisfied) to 5.0 (very satisfied). Typically measured after service interactions, support cases, or billing inquiries. Used for service quality monitoring, agent performance evaluation, and customer experience improvement. Null if not yet surveyed.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary transactions on this account. Examples: USD (US Dollar), EUR (Euro), GBP (British Pound), JPY (Japanese Yen). Determines billing currency, payment processing, and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Market segment classification for strategic planning, product offerings, and service differentiation. Consumer segment includes residential customers; small business serves companies with fewer than 50 employees; mid-market serves 50-500 employees; enterprise serves large corporations; wholesale serves carrier partners; public sector serves government entities.. Valid values are `consumer|small_business|mid_market|enterprise|wholesale|public_sector`',
    `days_past_due` STRING COMMENT 'Number of days the oldest unpaid invoice is overdue. Zero for accounts current on payments; positive values indicate delinquency. Used for aging analysis, dunning process triggers, and credit risk assessment. Null for prepaid accounts or accounts with no outstanding balance.',
    `do_not_call_flag` BOOLEAN COMMENT 'Indicates whether customer is registered on Do Not Call list or has requested no telemarketing calls. True means no outbound sales calls permitted; false means calls allowed with consent. Compliance with FTC Do Not Call Registry and TCPA regulations. Does not restrict service-related or transactional calls.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether account has been flagged for suspected fraudulent activity. True means fraud investigation in progress or confirmed fraud; false means no fraud indicators. Triggers service suspension, payment holds, and security team review. Used for fraud pattern analysis and prevention.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Calculated fraud risk score ranging from 0.00 (lowest risk) to 100.00 (highest risk). Generated by fraud detection algorithms analyzing payment patterns, usage behavior, identity verification, and historical fraud indicators. Triggers enhanced verification, deposit requirements, or service restrictions for high-risk accounts.',
    `gdpr_consent_date` TIMESTAMP COMMENT 'Timestamp when GDPR consent was obtained or last updated. Required for audit trail and consent management. Null if consent not applicable or not obtained. Must be refreshed periodically per GDPR guidelines.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether customer has provided explicit consent for data processing under GDPR regulations. True means valid consent obtained; false means consent not given or withdrawn. Required for EU/EEA customers. Governs marketing communications, data sharing, and analytics usage.',
    `hierarchy_level` STRING COMMENT 'Depth level in account hierarchy tree. Level 1 for root/master accounts; level 2 for direct children; level 3+ for nested sub-accounts. Used for hierarchical navigation, consolidated billing rollup, and organizational structure reporting. Null or 1 for standalone accounts.',
    `language_preference` STRING COMMENT 'Two-letter ISO 639-1 language code for customer communications, invoices, and support interactions. Examples: en (English), es (Spanish), fr (French), de (German), zh (Chinese). Ensures culturally appropriate customer experience.. Valid values are `^[a-z]{2}$`',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of most recent payment received. Expressed in account currency. Used for payment pattern analysis and partial payment detection. Null for accounts with no payment history.',
    `last_payment_date` DATE COMMENT 'Date of most recent successful payment received for this account. Used for payment recency analysis, delinquency detection, and credit risk assessment. Null for new accounts with no payment history.',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether customer has consented to receive marketing communications, promotional offers, and product announcements. True means customer opted in; false means customer declined or opted out. Governs eligibility for marketing campaigns and compliance with CAN-SPAM Act and TCPA regulations.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score for this account ranging from -100 to +100. Measures customer loyalty and likelihood to recommend services. Scores 9-10 are promoters; 7-8 are passives; 0-6 are detractors. Used for customer satisfaction tracking, churn prediction, and service improvement initiatives. Null if customer has not been surveyed.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current total amount owed by customer including unpaid invoices, late fees, and adjustments. Positive values indicate customer owes money; negative values indicate credit balance. Expressed in account currency. Zero for prepaid accounts. Used for collections prioritization and credit limit management.',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether customer has opted for electronic billing instead of paper invoices. True means customer receives invoices via email or web portal only; false means paper invoices are mailed. Supports environmental sustainability initiatives and reduces operational costs (OPEX).',
    `preferred_contact_method` STRING COMMENT 'Customers preferred channel for receiving notifications, billing statements, promotional offers, and service updates. Email for electronic delivery; SMS for text messages; phone for voice calls; mail for postal delivery; mobile app for push notifications; web portal for self-service access.. Valid values are `email|sms|phone|mail|mobile_app|web_portal`',
    `previous_status` STRING COMMENT 'Account status immediately before the most recent status change. Used for status transition audit trail and lifecycle analysis. Enables tracking of suspension-to-active restorations, termination reversals, and status change patterns. Null for accounts that have never changed status.. Valid values are `active|suspended|terminated|pending_activation|on_hold|delinquent`',
    `primary_contact_name` STRING COMMENT 'Full legal name of the primary account holder or authorized contact person. Used for identity verification, legal correspondence, and customer service authentication. For business accounts, this is the primary business contact. For consumer accounts, this is the account owner.',
    `primary_email_address` STRING COMMENT 'Primary email address for account communications, billing notifications, service alerts, and password resets. Must be unique per account for authentication purposes. Used for electronic invoice delivery when paperless billing is enabled.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone_number` STRING COMMENT 'Primary contact telephone number in E.164 international format. Used for customer service callbacks, two-factor authentication, SMS notifications, and emergency contact. May be mobile or landline. For mobile accounts, often matches the service MSISDN (Mobile Station International Subscriber Directory Number).. Valid values are `^+?[1-9]d{1,14}$`',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Refundable deposit held for accounts with credit risk or new customers without credit history. Returned after satisfactory payment history period. Expressed in account currency. Zero or null for accounts not requiring deposits.',
    `service_address_same_as_billing_flag` BOOLEAN COMMENT 'Indicates whether service delivery address matches billing address. True for most residential mobile accounts; false for business accounts with separate billing and service locations, or customers with PO Box billing addresses. Determines whether separate service address fields are populated.',
    `status_change_date` TIMESTAMP COMMENT 'Timestamp of most recent account status change. Used for status duration analysis, SLA compliance tracking, and lifecycle event sequencing. Null for accounts that have never changed status since creation.',
    `status_change_initiated_by` STRING COMMENT 'Actor or system that triggered the most recent status change. Customer for self-service actions; system for automated processes; agent for customer service actions; billing for payment-related changes; fraud for security actions; credit for credit management; provisioning for technical changes. Used for accountability and process analysis. [ENUM-REF-CANDIDATE: customer|system|agent|billing|fraud|credit|provisioning — 7 candidates stripped; promote to reference product]',
    `status_change_reason` STRING COMMENT 'Free-text explanation for most recent status change. Examples: payment received for suspension-to-active; non-payment for active-to-suspended; customer request for termination; fraud detection for suspension. Used for root cause analysis and process improvement. Null for accounts with no status changes.',
    `sub_type` STRING COMMENT 'Secondary classification providing additional segmentation within account type. Individual accounts serve single consumers; family accounts serve household groups; business accounts serve commercial entities; government accounts serve public sector; nonprofit accounts serve charitable organizations; reseller accounts serve distribution partners.. Valid values are `individual|family|business|government|nonprofit|reseller`',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether account is exempt from sales tax, value-added tax (VAT), or other telecommunications taxes. True for government entities, nonprofits, or accounts with valid tax exemption certificates; false for standard taxable accounts. Requires supporting documentation.',
    `tax_exemption_certificate_number` STRING COMMENT 'Official certificate or registration number proving tax-exempt status. Required for audit compliance when tax exempt flag is true. Issued by relevant tax authority. Null for non-exempt accounts.',
    `termination_date` DATE COMMENT 'Date when account was permanently closed and customer relationship ended. Null for active accounts. Used for churn analysis, win-back campaigns, and regulatory retention period compliance. Triggers final billing and service deactivation.',
    `termination_reason` STRING COMMENT 'Primary reason for account closure. Customer request for voluntary cancellation; non-payment for delinquency; fraud for security violations; relocation for move outside service area; competitor for churn to rival; service quality for dissatisfaction; price for cost concerns; deceased for customer death; duplicate for consolidation. Critical for churn root cause analysis. [ENUM-REF-CANDIDATE: customer_request|non_payment|fraud|relocation|competitor|service_quality|price|deceased|duplicate — 9 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this customer account record was last modified. Updated automatically on any field change. Used for change tracking, data freshness monitoring, and incremental data processing. Critical for CDC (Change Data Capture) and real-time analytics.',
    `vip_flag` BOOLEAN COMMENT 'Indicates whether account is designated as VIP requiring special handling. True for high-value customers, executives, celebrities, government officials, or strategic partners. Triggers priority support routing, dedicated account management, and enhanced service level agreements (SLA). Used for customer retention and satisfaction optimization.',
    CONSTRAINT pk_customer_account PRIMARY KEY(`customer_account_id`)
) COMMENT 'Master record for every customer account in the telecommunications business — B2C consumer, B2B enterprise, and wholesale client. Stores account number, account type (prepaid/postpaid/wholesale), account status (active/suspended/terminated), credit class, credit limit, language preference, preferred contact method, acquisition channel, acquisition date, market segment, account tier, billing cycle, currency, tax exemption flag, regulatory consent flags (GDPR/CCPA), lifecycle timestamps, and full account status transition history (previous status, new status, transition reason, effective date, initiated by). This is the SSOT for subscriber identity, account lifecycle audit trail, and is the anchor entity for the entire customer domain.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`subscriber` (
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the subscriber record. Primary key. Represents a single SIM/line/service user within an account.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Subscriber may have a service address (where the line is primarily used, different from account billing address). Adding service_address_id FK links subscriber to their service location for network pl',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Subscribers have active catalog items (SIM plans, data plans). Core service relationship for provisioning, usage rating, and service assurance in mobile/broadband operations.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise mobile fleet management: corporate accounts own many subscriber lines (employee SIMs). Telecom enterprise teams manage corporate mobile fleets, track subscriber counts per corporate account',
    `customer_account_id` BIGINT COMMENT 'Reference to the parent billing account. A single account may have multiple subscribers.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Subscriber may have a designated contact person (authorized user, line owner, account manager for that SIM). Adding primary_contact_id FK tracks the subscribers contact. Removing first_name, last_nam',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: Subscribers use specific device models (iPhone 14, Samsung Galaxy). Required for device compatibility checks, VoLTE/5G enablement, network optimization, and technical support.',
    `msisdn_range_id` BIGINT COMMENT 'Foreign key linking to inventory.msisdn_range. Business justification: Number portability compliance and MSISDN lifecycle management require knowing which allocated number range a subscribers MSISDN was drawn from. Telecom operators must report MSISDN utilization per ra',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Subscribers are provisioned with specific offerings. Direct service-to-product link for network provisioning, QoS policy application, and service entitlement management.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Subscribers are rated under specific price plans. Essential for real-time charging, usage mediation, and prepaid/postpaid billing in telecommunications rating engines.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to product.promo_offer. Business justification: Subscribers are enrolled in promotional offers (free trials, discounts). Promo redemption tracking, budget consumption reporting, and eligibility enforcement require linking subscriber to the active p',
    `spec_id` BIGINT COMMENT 'Foreign key linking to product.spec. Business justification: Subscriber QoS profile and data speed tier are governed by a product spec. Real-time network provisioning systems look up spec directly by subscriber for QoS enforcement without traversing offering. N',
    `activation_date` DATE COMMENT 'Date when the subscriber was first activated on the network. Marks the start of the subscriber lifecycle.',
    `biometric_verified_flag` BOOLEAN COMMENT 'Indicates whether the subscriber has completed biometric identity verification (fingerprint, facial recognition, etc.).',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Calculated probability that the subscriber will terminate service within the next period. Range 0.00 to 100.00.',
    `cltv_score` DECIMAL(18,2) COMMENT 'Predicted total revenue value of the subscriber over their expected lifetime with the company. Used for retention and marketing prioritization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscriber record was first created in the system.',
    `credit_class` STRING COMMENT 'Credit risk classification of the subscriber, used for deposit requirements and service eligibility decisions.. Valid values are `excellent|good|fair|poor|no_credit`',
    `customer_segment` STRING COMMENT 'Marketing and service segmentation classification of the subscriber based on demographics, usage patterns, and value.. Valid values are `premium|standard|value|youth|senior|business`',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the subscriber has consented to sharing their data with third parties for analytics or marketing purposes.',
    `data_speed_tier` STRING COMMENT 'Classification of the data speed entitlement for the subscriber based on their service plan and current usage status.. Valid values are `unlimited|high_speed|standard|throttled|zero_rated`',
    `date_of_birth` DATE COMMENT 'Birth date of the subscriber. Used for age verification, parental controls, and regulatory compliance.',
    `deactivation_date` DATE COMMENT 'Date when the subscriber was deactivated or terminated. Null for active subscribers.',
    `device_imei` STRING COMMENT 'Unique 15-digit identifier of the mobile device currently associated with the subscriber. Used for device tracking and fraud prevention.. Valid values are `^d{15}$`',
    `esim_eligible_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is eligible for eSIM provisioning based on device capability and service plan.',
    `five_g_enabled_flag` BOOLEAN COMMENT 'Indicates whether the subscriber has access to 5G network services based on device capability and service plan.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Calculated risk score indicating the likelihood of fraudulent activity associated with the subscriber. Range 0.00 to 100.00.',
    `hotspot_enabled_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is permitted to use mobile hotspot/tethering functionality.',
    `iccid` STRING COMMENT 'Unique serial number of the SIM card. Used for SIM inventory and provisioning.. Valid values are `^89[0-9]{17,19}$`',
    `id_document_number` STRING COMMENT 'Unique number of the government-issued identification document. Used for KYC and regulatory compliance.',
    `id_document_type` STRING COMMENT 'Type of government-issued identification document provided by the subscriber during registration.. Valid values are `passport|national_id|drivers_license|residence_permit|military_id|other`',
    `imsi` STRING COMMENT 'Unique identifier stored on the SIM card, used to identify the subscriber on the network. Sourced from HSS/UDM.. Valid values are `^d{14,15}$`',
    `international_dialing_enabled_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is permitted to make international calls from the home network.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscriber record was last updated in the system.',
    `last_nps_survey_date` DATE COMMENT 'Date when the subscriber last completed an NPS survey.',
    `last_sim_swap_date` DATE COMMENT 'Date of the most recent SIM card swap event for the subscriber.',
    `last_usage_date` DATE COMMENT 'Date when the subscriber last used any network service (voice, data, SMS). Used for dormancy detection and churn prediction.',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the subscriber has consented to receive marketing communications.',
    `msisdn` STRING COMMENT 'The subscribers mobile phone number in E.164 format. Primary contact identifier for the subscriber.. Valid values are `^+?[1-9]d{1,14}$`',
    `nationality` STRING COMMENT 'Country of citizenship of the subscriber, represented as ISO 3166-1 alpha-3 code. Used for roaming profile and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score provided by the subscriber, ranging from -100 to 100. Measures customer loyalty and satisfaction.',
    `parental_control_flag` BOOLEAN COMMENT 'Indicates whether parental control restrictions are applied to the subscriber, typically for minor dependents.',
    `preferred_language` STRING COMMENT 'ISO 639-1 two-letter language code representing the subscribers preferred language for communication and service delivery.. Valid values are `^[a-z]{2}$`',
    `qos_profile` STRING COMMENT 'Defines the Quality of Service parameters applied to the subscribers traffic, including priority, latency, and throughput guarantees.. Valid values are `premium|standard|basic|best_effort`',
    `roaming_enabled_flag` BOOLEAN COMMENT 'Indicates whether roaming services are currently enabled for the subscriber. Can be toggled for fraud prevention or cost control.',
    `roaming_profile` STRING COMMENT 'Defines the subscribers roaming permissions and geographic scope. Determines which networks the subscriber can access outside the home network.. Valid values are `domestic_only|international|regional|premium|restricted`',
    `sim_swap_count` STRING COMMENT 'Total number of times the subscriber has performed a SIM card swap. High frequency may indicate fraud risk.',
    `subscriber_status` STRING COMMENT 'Current lifecycle status of the subscriber. Active indicates the subscriber can use services; suspended/barred indicates temporary restriction; terminated indicates permanent closure.. Valid values are `active|suspended|inactive|pending_activation|terminated|barred`',
    `subscriber_type` STRING COMMENT 'Classification of the subscriber within the account structure. Primary is the main account holder, secondary/add-on are additional lines.. Valid values are `primary|secondary|add_on|dependent|shared_data`',
    `volte_enabled_flag` BOOLEAN COMMENT 'Indicates whether VoLTE service is enabled for the subscriber, allowing voice calls over LTE network.',
    `vowifi_enabled_flag` BOOLEAN COMMENT 'Indicates whether Voice over Wi-Fi calling is enabled for the subscriber.',
    CONSTRAINT pk_subscriber PRIMARY KEY(`subscriber_id`)
) COMMENT 'Individual subscriber identity record representing a single SIM/line/service user within an account. Captures subscriber number (MSISDN), subscriber type (primary/secondary/add-on), subscriber status, date of birth, nationality, ID document type and number, biometric verification flag, eSIM eligibility, VoLTE capability, roaming profile, preferred language, parental control flag, and association to the parent account. Distinct from account (which is the billing/commercial entity) — a single account may have multiple subscribers. SSOT for individual subscriber identity. Sourced from HSS/UDM and provisioning systems.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`customer_contact` (
    `customer_contact_id` BIGINT COMMENT 'Unique identifier for the contact record. Primary key for the contact entity.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.customer_address. Business justification: customer_contact currently embeds address fields (address_line_1, address_line_2, city, state_province, postal_code, country_code) directly on the record. customer_address is the authoritative SSOT fo',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account this contact is associated with. Links contact to parent customer entity in Salesforce CRM Customer 360.',
    `alternate_phone` STRING COMMENT 'An alternate or secondary telephone number for the contact person (landline, office, or additional mobile).',
    `authorization_level` STRING COMMENT 'The level of authorization or permission this contact has to perform actions on the customer account (e.g., make changes, view bills, authorize service orders).. Valid values are `full|limited|view_only|none`',
    `communication_language` STRING COMMENT 'The preferred language for communication with the contact person, specified as a 3-letter ISO 639-2 language code (e.g., ENG for English, SPA for Spanish).. Valid values are `^[A-Z]{3}$`',
    `contact_role` STRING COMMENT 'The role or capacity in which this contact person is associated with the customer account. Defines the contacts authority and responsibility level.. Valid values are `primary_account_holder|authorized_representative|technical_contact|billing_contact|emergency_contact|legal_contact`',
    `contact_status` STRING COMMENT 'The current lifecycle status of the contact record. Indicates whether the contact is actively associated with the customer account.. Valid values are `active|inactive|suspended|deceased`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `date_of_birth` DATE COMMENT 'The date of birth of the contact person. Used for identity verification and age-restricted service eligibility.',
    `department` STRING COMMENT 'The department or business unit within the organization where the contact person works. Primarily used for B2B enterprise accounts.',
    `do_not_contact_flag` BOOLEAN COMMENT 'Indicates whether the contact person has requested not to be contacted for any purpose. True if contact is prohibited, False otherwise.',
    `effective_end_date` DATE COMMENT 'The date on which this contact record ceases to be effective or is terminated. Null indicates the contact is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this contact record becomes effective and active for the customer account.',
    `email_address` STRING COMMENT 'The primary email address of the contact person used for electronic communication and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `external_reference_code` STRING COMMENT 'The unique identifier for this contact in the source operational system. Used for cross-system reconciliation and data lineage tracking.',
    `fax_number` STRING COMMENT 'The facsimile (fax) number of the contact person, if applicable. Used primarily for B2B enterprise communications.',
    `first_name` STRING COMMENT 'The given name or first name of the contact person.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the primary or main contact for the customer account. True if primary, False otherwise. Only one contact per account should be marked as primary.',
    `job_title` STRING COMMENT 'The professional job title or position of the contact person within their organization. Primarily used for Business-to-Business (B2B) enterprise accounts.',
    `last_name` STRING COMMENT 'The family name or surname of the contact person.',
    `marketing_opt_in_date` DATE COMMENT 'The date when the contact person provided consent to receive marketing communications. Used for compliance tracking and consent management.',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the contact person has explicitly opted in to receive marketing communications, promotional offers, and product updates. True if opted in, False otherwise.',
    `marketing_opt_out_date` DATE COMMENT 'The date when the contact person withdrew consent or opted out of receiving marketing communications.',
    `middle_name` STRING COMMENT 'The middle name or initial of the contact person, if applicable.',
    `mobile_number` STRING COMMENT 'The mobile telephone number of the contact person. Primary contact channel for SMS and voice communication.',
    `national_id_number` STRING COMMENT 'The government-issued national identification number of the contact person (e.g., Social Security Number in USA, National Insurance Number in UK). Used for identity verification and regulatory compliance.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the contact person. Used by Customer Relationship Management (CRM) representatives for context.',
    `preferred_contact_channel` STRING COMMENT 'The contact persons preferred communication channel for receiving notifications, updates, and correspondence from the telecommunications provider.. Valid values are `email|mobile|phone|sms|mail|portal`',
    `relationship_to_account_holder` STRING COMMENT 'Describes the personal or professional relationship of this contact to the primary account holder (e.g., spouse, parent, employee, business partner).',
    `source_system` STRING COMMENT 'The name or identifier of the operational system from which this contact record originated (e.g., Salesforce CRM, legacy billing system, customer portal).',
    `title` STRING COMMENT 'The honorific or courtesy title of the contact person (e.g., Mr., Mrs., Dr.).. Valid values are `Mr|Mrs|Ms|Dr|Prof`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact record was last modified or updated. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `verification_date` DATE COMMENT 'The date when the contact information was last verified or validated.',
    `verification_status` STRING COMMENT 'The verification status of the contact information. Indicates whether the contact details (email, phone) have been validated through verification processes.. Valid values are `verified|unverified|pending|failed`',
    CONSTRAINT pk_customer_contact PRIMARY KEY(`customer_contact_id`)
) COMMENT 'Contact person record associated with a customer account — primary account holder, authorized representative, technical contact, billing contact, or emergency contact. Stores full name, title, job title (for B2B), email address, mobile number, alternate phone, preferred contact channel, contact role, do-not-contact flags, marketing opt-in/opt-out, communication language, and verification status. Supports multiple contacts per account with role-based differentiation. SSOT for customer contact identity within the customer domain.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`address` (
    `address_id` BIGINT COMMENT 'Unique identifier for the address record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account or subscriber associated with this address.',
    `olt_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.olt_asset. Business justification: Fiber service qualification, outage impact analysis, and capacity planning all require knowing which OLT serves a customer address. serving_central_office is a plain-text denormalization of this relat',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this address record is currently active and in use. True if active, false if inactive or deprecated.',
    `address_type` STRING COMMENT 'Classification of the address purpose: service address (where service is delivered), billing address (where invoices are sent), installation address (where equipment is installed), correspondence address (general mail), shipping address (equipment delivery), or legal address (registered business location).. Valid values are `service|billing|installation|correspondence|shipping|legal`',
    `broadband_coverage_tier` STRING COMMENT 'Highest tier of broadband technology available at this address: fiber (FTTH/GPON), cable (DOCSIS), DSL (ADSL/VDSL), fixed wireless (LTE/5G), satellite, or no coverage.. Valid values are `fiber|cable|dsl|fixed_wireless|satellite|no_coverage`',
    `city` STRING COMMENT 'City or municipality name where the address is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the address is located (e.g., USA, CAN, GBR, AUS).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the system. Used for audit trail and data lineage.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite data quality score (0-100) reflecting completeness, accuracy, consistency, and timeliness of the address record. Higher scores indicate better data quality.',
    `dwelling_type` STRING COMMENT 'Classification of the building or property type at this address: single family home, multi-family building, apartment, condominium, townhouse, commercial property, industrial facility, or mixed-use development. [ENUM-REF-CANDIDATE: single_family|multi_family|apartment|condo|townhouse|commercial|industrial|mixed_use — 8 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this address ceased to be effective for the associated customer account. Null if currently active. Used for temporal tracking and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this address became effective and active for the associated customer account. Used for temporal tracking and historical analysis.',
    `ftth_serviceable_flag` BOOLEAN COMMENT 'Indicates whether this address is within the FTTH network footprint and can receive fiber-optic broadband service. True if fiber service is available, false otherwise.',
    `gpon_serviceable_flag` BOOLEAN COMMENT 'Indicates whether this address is within the GPON network coverage area and can receive gigabit passive optical network service. True if GPON service is available, false otherwise.',
    `hash` STRING COMMENT 'Cryptographic hash of the complete address components used for deduplication, matching, and privacy-preserving analytics without exposing actual address details.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last updated or modified. Used for audit trail and change tracking.',
    `last_verified_date` DATE COMMENT 'Date when this address was last verified or validated for accuracy, either through automated validation service or manual confirmation.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees format for precise location mapping. Used for field dispatch routing, coverage analysis, and GIS applications.',
    `line_1` STRING COMMENT 'Primary street address line including street number, street name, and street type (e.g., 123 Main Street).',
    `line_2` STRING COMMENT 'Secondary address line for apartment number, suite, unit, building, floor, or other location details within the primary address.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees format for precise location mapping. Used for field dispatch routing, coverage analysis, and GIS applications.',
    `lte_coverage_flag` BOOLEAN COMMENT 'Indicates whether this address has LTE (4G) wireless network coverage. True if LTE service is available, false otherwise.',
    `maximum_download_speed_mbps` DECIMAL(18,2) COMMENT 'Maximum theoretical download speed in megabits per second available at this address based on network infrastructure and technology tier.',
    `maximum_upload_speed_mbps` DECIMAL(18,2) COMMENT 'Maximum theoretical upload speed in megabits per second available at this address based on network infrastructure and technology tier.',
    `mdu_flag` BOOLEAN COMMENT 'Indicates whether this address is part of a multi-dwelling unit property (apartment building, condo complex, etc.) requiring special provisioning considerations. True if MDU, false if single-unit.',
    `n5g_coverage_flag` BOOLEAN COMMENT 'Indicates whether this address has 5G New Radio wireless network coverage. True if 5G service is available, false otherwise.',
    `postal_code` STRING COMMENT 'Postal code, ZIP code, or postcode for mail delivery routing. Format varies by country (e.g., 12345, 12345-6789, A1A 1A1).',
    `primary_address_flag` BOOLEAN COMMENT 'Indicates whether this is the primary or default address for the associated customer account. True if primary, false if secondary or alternate address.',
    `source_system` STRING COMMENT 'Name of the operational system that originated or last updated this address record (e.g., Salesforce CRM, Oracle OSM, customer portal, field service application).',
    `standardized_address` STRING COMMENT 'Fully standardized and formatted address string as returned by the validation service, following postal authority standards. Used for mail delivery and system integration.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the address is located. Use standard postal abbreviations (e.g., CA for California, ON for Ontario).',
    `unit_count` STRING COMMENT 'Number of individual units or dwellings within the property at this address. Relevant for MDU properties and bulk service opportunities.',
    `validation_source` STRING COMMENT 'Name of the validation service or system used to verify the address (e.g., USPS CASS, Google Maps API, Loqate, Melissa Data, internal GIS system).',
    `validation_status` STRING COMMENT 'Current validation state of the address: validated (confirmed accurate by validation service), unvalidated (not yet checked), invalid (failed validation), pending (validation in progress), corrected (modified during validation), or partial (some components validated).. Valid values are `validated|unvalidated|invalid|pending|corrected|partial`',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing address records associated with customer accounts and subscribers. Captures address type (service address, billing address, installation address, correspondence address), street line 1 and 2, city, state/province, postal code, country, geocoordinates (latitude/longitude), address validation status, address validation source, GPON/FTTH serviceability flag, broadband coverage tier, and last verified date. Supports multiple addresses per account. Critical for service provisioning, field dispatch, and coverage eligibility checks.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique identifier for the customer interaction record. Primary key.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Interactions about bundle changes, bundle billing disputes, or bundle upgrade requests explicitly reference the bundle product. Agent workflows and interaction analytics require this link. Bundles are',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Outbound campaign-driven interactions (telemarketing, SMS follow-up calls) must be attributed to the originating campaign for response rate, conversion, and ROI measurement. Telecom campaign managers ',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Interactions often concern specific catalog items (plan inquiries, upgrade requests, billing questions). Provides customer service context for CRM systems and interaction analytics.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise account management teams pull all interactions (support calls, complaints, renewals) for a corporate account. This is a standard telecom enterprise support reporting process. No existing co',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: In telecom, many customer interactions are at the account level (billing inquiries, plan changes, account status updates) rather than subscriber-specific. While customer_interaction already links to s',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Interactions often involve a specific contact person (caller, chat initiator, email sender). Adding contact_id FK tracks who initiated the interaction. No redundant columns to remove.',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Dealer channel performance analytics and mis-selling complaint tracking require linking interactions to the originating dealer. In-store and dealer-assisted interactions must be attributed to specific',
    `device_registration_id` BIGINT COMMENT 'Foreign key linking to customer.device_registration. Business justification: Interactions can be about device issues (activation help, troubleshooting, IMEI registration). Adding device_registration_id FK links interaction to the specific device being discussed. No redundant c',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the order if the interaction was related to order placement, modification, or inquiry. Null if not order-related.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Call center agents handle billing query interactions referencing specific invoices (payment disputes, charge explanations, late fee waivers). Direct invoice FK on customer_interaction enables invoice-',
    `noc_incident_id` BIGINT COMMENT 'Foreign key linking to assurance.noc_incident. Business justification: Major network incidents trigger customer complaint calls. Linking interaction to incident enables customer impact analysis, proactive communication tracking, and regulatory reporting of customer-affec',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Interactions reference specific offerings being discussed or sold. Essential for sales tracking, conversion analytics, and next-best-action recommendations in contact centers.',
    `outage_record_id` BIGINT COMMENT 'Foreign key linking to assurance.outage_record. Business justification: Customer calls during outages must link to outage records for impact validation, customer communication tracking, and regulatory reporting of customer-reported outages. Real business process: outage c',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to product.promo_offer. Business justification: Interactions triggered by promotional offers (promo disputes, customers calling about received offers) need to reference the promo_offer. Marketing attribution and promo effectiveness reporting depend',
    `retention_offer_id` BIGINT COMMENT 'Foreign key linking to sales.retention_offer. Business justification: Save-desk interactions are the primary channel through which retention offers are presented. Linking customer_interaction to the retention_offer presented during that call enables save-desk performanc',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Interactions can be subscriber-specific (SIM swap call, roaming inquiry, line-specific service issue). Adding subscriber_id FK tracks line-level interactions. No redundant columns to remove.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to customer.customer_subscription. Business justification: Customer interactions in telecom are frequently about specific add-on subscriptions — activation calls, cancellation requests, billing queries for a specific add-on. A direct FK from customer_interact',
    `svc_instance_id` BIGINT COMMENT 'Reference to the specific service instance discussed or affected during the interaction (e.g., mobile subscription, broadband connection). Null if not service-specific.',
    `callback_requested_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer requested a callback (True) or not (False).',
    `callback_scheduled_timestamp` TIMESTAMP COMMENT 'Date and time when a callback was scheduled, in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if no callback scheduled.',
    `channel` STRING COMMENT 'Channel through which the interaction occurred: voice (phone call), chat, email, retail store, mobile app, or web portal.. Valid values are `voice|chat|email|store|mobile_app|web_portal`',
    `contact_email_address` STRING COMMENT 'Email address used by the customer during this interaction. May differ from the primary account email.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone_number` STRING COMMENT 'Phone number used by the customer during this interaction. May differ from the primary account phone number.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was first created in the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `csat_score` STRING COMMENT 'Customer Satisfaction score captured immediately after the interaction, typically on a scale of 1-5 or 1-10. Null if no survey was completed.',
    `customer_effort_score` STRING COMMENT 'Customer Effort Score measuring how easy it was for the customer to resolve their issue, typically on a scale of 1-7. Null if not captured.',
    `direction` STRING COMMENT 'Direction of the interaction: inbound (customer-initiated) or outbound (company-initiated).. Valid values are `inbound|outbound`',
    `duration_seconds` STRING COMMENT 'Total duration of the interaction in seconds, from start to end.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction ended or was closed, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `escalation_level` STRING COMMENT 'Numeric indicator of escalation tier (0 = no escalation, 1 = first-level supervisor, 2 = second-level management, etc.). Null if not escalated.',
    `fcr_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer issue was resolved on the first contact without requiring follow-up (True) or not (False). Key KPI for customer service quality.',
    `interaction_status` STRING COMMENT 'Current lifecycle status of the interaction: open, in progress, resolved, closed, escalated, or pending customer response.. Valid values are `open|in_progress|resolved|closed|escalated|pending`',
    `interaction_type` STRING COMMENT 'Classification of the interaction purpose: inquiry, complaint, service request, sales, technical support, or billing inquiry.. Valid values are `inquiry|complaint|service_request|sales|technical_support|billing_inquiry`',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language used during the interaction (e.g., ENG for English, SPA for Spanish).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interaction record was last updated or modified, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Detailed notes captured by the agent during or after the interaction, including customer statements, troubleshooting steps, and resolution details.',
    `nps_survey_triggered_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a Net Promoter Score survey was triggered following this interaction (True) or not (False).',
    `queue_name` STRING COMMENT 'Name of the service queue or routing group to which the interaction was assigned (e.g., Technical Support, Billing, Sales).',
    `recording_url` STRING COMMENT 'URL or storage path to the interaction recording (voice call recording, chat transcript, email thread). Null if recording not available or not permitted.',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for the interaction, used for customer communication and tracking.. Valid values are `^INT-[0-9]{10}$`',
    `resolution_status` STRING COMMENT 'Status indicating whether the customer issue was resolved during the interaction: resolved, unresolved, partially resolved, escalated, or pending.. Valid values are `resolved|unresolved|partially_resolved|escalated|pending`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated sentiment analysis score derived from interaction content (voice transcription, chat text, email), ranging from -1.00 (negative) to +1.00 (positive).',
    `source_system` STRING COMMENT 'Name of the source system or platform that captured this interaction (e.g., Salesforce CRM, Contact Center Platform, Mobile App).',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction began, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `summary` STRING COMMENT 'Brief textual summary of the interaction content, key points discussed, and actions taken. Used for quick reference and reporting.',
    `topic_category` STRING COMMENT 'High-level category of the interaction topic (e.g., Billing, Network Quality, Service Activation, Account Management).',
    `topic_subcategory` STRING COMMENT 'Detailed subcategory of the interaction topic providing granular classification (e.g., Invoice Dispute, Data Speed Issue, SIM Activation).',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Record of every customer interaction across all touchpoints — inbound/outbound calls, chat sessions, email exchanges, retail store visits, self-service portal sessions, and social media contacts. Stores interaction type, channel (voice/chat/email/store/app/social), direction (inbound/outbound), interaction date and time, duration, agent ID, queue name, topic category, sub-topic, resolution status, FCR flag (First Call Resolution), CSAT score captured at interaction, NPS survey triggered flag, and case reference if escalated. SSOT for customer interaction history across all channels.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`case` (
    `case_id` BIGINT COMMENT 'Unique identifier for the customer support case. Primary key for the case entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Cases frequently address billing issues (payment disputes, invoice queries, dunning appeals, payment arrangement requests). Direct billing_account link enables billing case routing to collections team',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Support cases about bundle billing errors, bundle component failures, or bundle upgrade disputes reference the specific bundle. Case routing, SLA tracking, and product defect reporting require this li',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Cases often relate to specific catalog items (billing disputes, service quality issues). Essential for problem resolution, product defect tracking, and quality assurance.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Cases often involve a specific contact person who reported the issue or is the authorized representative handling the case. Adding contact_id FK tracks who initiated/owns the case. No redundant column',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.data_breach_incident. Business justification: When a data breach occurs, customer service cases are opened for affected customers (complaints, compensation claims, notification follow-up). Linking case to data_breach_incident enables the customer',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: Cases frequently involve specific device models (troubleshooting, warranty claims, defects). Essential for technical support, warranty processing, and device quality tracking.',
    `device_registration_id` BIGINT COMMENT 'Foreign key linking to customer.device_registration. Business justification: Cases often relate to device issues (IMEI block, warranty claim, insurance claim, device malfunction). Adding device_registration_id FK links case to the specific device being serviced. No redundant c',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the order that this case relates to, if the case concerns order fulfillment or delivery issues.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Technical support cases for CPE equipment issues need asset details (firmware version, model, warranty status) for troubleshooting, RMA decisions, and vendor warranty claims. Enables support agents to',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice that this case relates to, if the case concerns billing disputes or invoice inquiries.',
    `noc_incident_id` BIGINT COMMENT 'Foreign key linking to assurance.noc_incident. Business justification: Customer cases escalated to NOC incidents require linking for resolution coordination, customer notification, and SLA impact tracking. Real business process: major incident customer case management an',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: Fiber service cases require ONT asset details for optical power diagnostics, firmware troubleshooting, and replacement workflows. Technical support needs ONT serial number, optical metrics, and firmwa',
    `outage_record_id` BIGINT COMMENT 'Foreign key linking to assurance.outage_record. Business justification: Cases opened during outages reference the outage for root cause, SLA exclusion justification, and customer compensation eligibility. Real business process: outage-related case management and SLA excep',
    `parent_case_id` BIGINT COMMENT 'Reference to a parent case if this case is a child or related case, enabling case hierarchy tracking.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Cases often dispute or query specific price plans (billing errors, rate changes). Required for billing dispute resolution and revenue assurance investigations.',
    `privacy_request_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_request. Business justification: Customer service cases are routinely opened to manage GDPR/CCPA privacy request fulfillment (data access, deletion, portability). Linking case to privacy_request enables SLA tracking, escalation manag',
    `problem_record_id` BIGINT COMMENT 'Foreign key linking to assurance.problem_record. Business justification: Customer cases linked to known problems enable workaround application and customer notification when permanent fixes are deployed. Real business process: known error customer case management and resol',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to product.promo_offer. Business justification: Retention cases (save desk) involve applying or referencing a promo_offer. The existing offer_code plain column is a denormalized reference to promo_offer. A proper FK enables promo redemption trackin',
    `provisioning_order_id` BIGINT COMMENT 'Foreign key linking to service.provisioning_order. Business justification: Provisioning failure case management: when a provisioning order fails or causes service issues, a customer case is opened. Direct link enables root cause analysis reports linking case resolution outco',
    `retention_offer_id` BIGINT COMMENT 'Foreign key linking to sales.retention_offer. Business justification: Retention cases (churn prevention, save-desk escalations) are directly associated with a retention offer. case already carries retention_outcome, retention_cost, retention_trigger_reason as denormaliz',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Contract dispute cases, early termination requests, and SLA breach cases must reference the governing sales contract. Telecom legal and operations teams require this link for contract dispute resoluti',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Enterprise support cases are site-specific (CPE fault, connectivity outage at a physical location). Field dispatch and SLA measurement require knowing which enterprise site a case relates to. Telecom ',
    `spec_id` BIGINT COMMENT 'Reference to the product offering that this case relates to, if applicable.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to customer.customer_subscription. Business justification: Support cases in telecom are frequently raised about a specific add-on subscription (e.g., a streaming add-on not activating, an add-on being incorrectly charged, or a subscription cancellation disput',
    `svc_instance_id` BIGINT COMMENT 'Reference to the specific service instance (subscription, line, connection) that this case relates to, if applicable.',
    `actual_resolution_date` TIMESTAMP COMMENT 'Actual date and time when the case was resolved and solution was provided to the customer.',
    `case_category` STRING COMMENT 'Secondary classification providing additional context for the case type. [ENUM-REF-CANDIDATE: network_coverage|billing_error|service_activation|device_issue|contract_inquiry|data_usage|roaming|porting|upgrade_request|cancellation_request|loyalty_reward|win_back|contract_renewal — promote to reference product]',
    `case_description` STRING COMMENT 'Detailed description of the customer issue, complaint, or request as initially reported.',
    `case_number` STRING COMMENT 'Externally visible unique case number used for customer communication and tracking. Format: CASE-xxxxxxxxxx.. Valid values are `^CASE-[0-9]{10}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the case. Open (newly created), in_progress (being worked), pending_customer (awaiting customer response), resolved (solution provided), closed (completed and verified), cancelled (withdrawn).. Valid values are `open|in_progress|pending_customer|resolved|closed|cancelled`',
    `case_type` STRING COMMENT 'Classification of the case by business purpose: complaint (service quality issue), billing_dispute (invoice or charge dispute), technical_fault (network or service technical issue), mnp_request (Mobile Number Portability request), general_inquiry (information request), save_offer (retention intervention).. Valid values are `complaint|billing_dispute|technical_fault|mnp_request|general_inquiry|save_offer`',
    `channel` STRING COMMENT 'Channel through which the customer initiated the case: phone (call center), email, web (self-service portal), mobile_app, chat (live chat), store (retail location), social_media. [ENUM-REF-CANDIDATE: phone|email|web|mobile_app|chat|store|social_media — 7 candidates stripped; promote to reference product]',
    `closed_date` TIMESTAMP COMMENT 'Date and time when the case was officially closed and marked as complete.',
    `contact_attempts` STRING COMMENT 'Number of times the support team attempted to contact the customer regarding this case.',
    `contract_extension_months` STRING COMMENT 'For retention cases, the number of months the customer contract was extended as part of the retention offer.',
    `created_date` TIMESTAMP COMMENT 'Date and time when the case was first created in the system.',
    `csat_score` STRING COMMENT 'Customer satisfaction score provided by the customer after case resolution, typically on a scale of 1-5 or 1-10.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the case has been escalated to a higher support tier or management. True if escalated, False otherwise.',
    `escalation_level` STRING COMMENT 'Number of escalation tiers the case has passed through. 0 for no escalation, 1 for first-level escalation, 2 for second-level, etc.',
    `fcr_flag` BOOLEAN COMMENT 'Indicates whether the case was resolved on the first contact without requiring follow-up. True if resolved on first contact, False otherwise.',
    `modified_date` TIMESTAMP COMMENT 'Date and time when the case record was last modified or updated.',
    `nps_score` STRING COMMENT 'Net Promoter Score provided by the customer after case resolution, on a scale of 0-10 measuring likelihood to recommend.',
    `offer_accepted_flag` BOOLEAN COMMENT 'For retention cases, indicates whether the customer accepted the retention offer. True if accepted, False if declined.',
    `offer_value` DECIMAL(18,2) COMMENT 'For retention cases, the monetary value of the retention offer presented to the customer (discount amount, credit value, waived fees).',
    `origin` STRING COMMENT 'Source or trigger that created the case: customer_initiated (customer contacted support), proactive_outreach (company reached out), system_generated (automated alert), escalation (from another case), third_party (partner or regulator).. Valid values are `customer_initiated|proactive_outreach|system_generated|escalation|third_party`',
    `owning_team` STRING COMMENT 'Name or identifier of the support team currently responsible for resolving the case. [ENUM-REF-CANDIDATE: tier1_support|tier2_support|tier3_support|billing_team|technical_team|retention_team|save_desk|mnp_team|vip_support|enterprise_support — promote to reference product]',
    `priority` STRING COMMENT 'Priority level assigned to the case based on business impact and urgency. P1 (critical - service down), P2 (high - major impact), P3 (medium - moderate impact), P4 (low - minor issue).. Valid values are `P1|P2|P3|P4`',
    `regulatory_flag` BOOLEAN COMMENT 'Indicates whether the case involves regulatory compliance issues or requires regulatory reporting. True if regulatory-related, False otherwise.',
    `reopen_count` STRING COMMENT 'Number of times the case has been reopened after initial closure, indicating unresolved issues or customer dissatisfaction.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the actions taken, solution provided, and final resolution of the case.',
    `retention_cost` DECIMAL(18,2) COMMENT 'For retention cases, the total cost to the business of the retention intervention (discount value, credits, waived fees, incentive costs).',
    `retention_outcome` STRING COMMENT 'For retention cases, the final outcome of the retention intervention: retained (customer stayed), churned (customer left), pending (decision not yet made), no_action (customer did not require intervention).. Valid values are `retained|churned|pending|no_action`',
    `retention_trigger_reason` STRING COMMENT 'For retention cases, the business reason that triggered the save intervention: churn_intent (customer expressed intent to leave), contract_expiry (contract ending soon), competitor_offer (customer received competitive offer), high_risk_score (predictive churn model), usage_decline (significant usage drop), payment_issue (payment problems).. Valid values are `churn_intent|contract_expiry|competitor_offer|high_risk_score|usage_decline|payment_issue`',
    `root_cause` STRING COMMENT 'Identified root cause of the issue after investigation and resolution. [ENUM-REF-CANDIDATE: network_outage|billing_system_error|provisioning_failure|user_error|device_defect|third_party_issue|process_gap|system_bug|configuration_error|capacity_issue — promote to reference product]',
    `save_desk_queue` STRING COMMENT 'For retention cases, the specific save desk queue or team that handled the retention intervention (high_value, standard, win_back, contract_renewal).',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the case resolution exceeded the SLA target date. True if breached, False if met.',
    `sla_target_date` TIMESTAMP COMMENT 'Target date and time by which the case must be resolved according to the applicable SLA policy.',
    `subject` STRING COMMENT 'Brief summary or title of the case describing the primary issue or request.',
    `time_to_resolution_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from case creation to resolution, used for SLA tracking and performance measurement.',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Customer support case record tracking issues, complaints, service requests, retention interventions, and save-desk activities through their full lifecycle. Stores case number, case type (complaint/billing dispute/technical fault/MNP request/general inquiry/save offer/win-back/contract renewal/loyalty reward), priority (P1-P4), status (open/in-progress/pending-customer/resolved/closed), subject, description, resolution notes, SLA breach flag, SLA target date, actual resolution date, escalation flag, escalation level, owning team, linked interaction references. For retention cases: trigger reason (churn intent/contract expiry/competitor offer/high risk score), offer code, offer value, offer accepted flag, outcome (retained/churned/pending), retention cost, contract extension months, and save desk queue. SSOT for all customer service workflow including proactive/reactive retention activity tracking. Distinct from network fault tickets (owned by assurance domain).';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique identifier for the consent record. Primary key.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: GDPR/CCPA consent records are scoped to specific products/services. Regulatory compliance reporting requires knowing which catalog item the consent applies to (e.g., consent for data usage on a specif',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer who provided or withdrew consent. Links to the customer master record in Salesforce CRM.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Consent is often captured from a specific contact person (authorized representative, account holder). Adding contact_id FK tracks who provided the consent. No redundant columns to remove.',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to customer.customer_interaction. Business justification: Consent records in telecom are frequently captured during customer interactions — a call center agent records a verbal consent, a chat session captures a digital consent, or an in-store interaction ca',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Consent for service notifications or marketing is scoped to a specific offering. GDPR/CCPA compliance requires consent to be traceable to the specific product/service offering. No existing FK covers c',
    `parent_consent_record_id` BIGINT COMMENT 'Reference to a previous consent record that this record supersedes or amends. Used to track consent history and version chains. Null for initial consent records.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: GDPR Article 13/14 compliance requires recording which specific third-party partner a customer consented to share data with. consent_record has third_party_sharing_opt_in as a boolean but no FK iden',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: Telecom operators must reconcile customer-facing consent records (marketing, service notifications) with regulatory privacy_consent records (GDPR lawful basis, CPNI, CALEA). This link supports consent',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Consent can be subscriber-specific (SMS opt-in for a specific line, roaming consent, data usage consent per SIM). Adding subscriber_id FK tracks line-level consent preferences. No redundant columns to',
    `consent_channel` STRING COMMENT 'The channel through which the consent was captured: web (online portal), mobile_app (mobile application), retail_store (physical store interaction), ivr (Interactive Voice Response system), paper (physical form), email (email response), or sms (text message confirmation). [ENUM-REF-CANDIDATE: web|mobile_app|retail_store|ivr|paper|email|sms — 7 candidates stripped; promote to reference product]',
    `consent_method` STRING COMMENT 'The method by which consent was obtained: explicit (affirmative action required), implicit (inferred from behavior), opt_in (customer actively chose to consent), opt_out (customer must actively decline), pre_checked (checkbox pre-selected), or unchecked (checkbox not pre-selected). Critical for GDPR compliance as pre-checked boxes do not constitute valid consent.. Valid values are `explicit|implicit|opt_in|opt_out|pre_checked|unchecked`',
    `consent_status` STRING COMMENT 'Current state of the consent: granted (customer has given consent), withdrawn (customer has revoked consent), pending (awaiting customer decision), expired (consent period has lapsed), or revoked (administratively cancelled).. Valid values are `granted|withdrawn|pending|expired|revoked`',
    `consent_text` STRING COMMENT 'The exact text of the consent statement or privacy notice that was presented to the customer at the time of consent capture. Stored for audit and compliance verification. Required to demonstrate informed consent under GDPR Article 13.',
    `consent_type` STRING COMMENT 'The category of consent being recorded: marketing (promotional communications), data_processing (use of personal data for service delivery), third_party_sharing (sharing data with partners), lawful_intercept (government access compliance), cpni (Customer Proprietary Network Information usage under FCC rules), or channel_opt_in (permission to contact via specific channel).. Valid values are `marketing|data_processing|third_party_sharing|lawful_intercept|cpni|channel_opt_in`',
    `consent_version` STRING COMMENT 'The version identifier of the privacy policy or terms of service under which this consent was granted. Enables tracking of consent against evolving policy versions for regulatory audit trails.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this consent record was first created in the system. Used for audit trails and data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_category` STRING COMMENT 'The specific category or categories of personal data covered by this consent (e.g., contact information, usage data, location data, payment information, call detail records). Free-text field to accommodate diverse data classification schemes across jurisdictions.',
    `device_code` STRING COMMENT 'The unique identifier of the device (e.g., mobile device ID, browser fingerprint, IMEI) from which the consent was captured. Used for audit trails and fraud prevention. Considered PII under GDPR and CCPA.',
    `do_not_disturb_schedule` STRING COMMENT 'Specific times or days when the customer does not wish to be contacted (e.g., weekends, evenings, holidays). Free-text to accommodate complex schedules. Supports FCC Telephone Consumer Protection Act (TCPA) compliance and customer experience optimization.',
    `effective_date` DATE COMMENT 'The date when the consent becomes active and enforceable. Aligns with regulatory requirement for clear consent timing.',
    `electronic_bill_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive electronic bills via email or online portal. True = e-bill requested, False = paper bill only. Supports digital transformation and cost reduction initiatives.',
    `expiration_date` DATE COMMENT 'The date when the consent automatically expires and must be renewed. Null for indefinite consents. Required for time-bound consent management under GDPR and CCPA.',
    `geolocation` STRING COMMENT 'The geographic coordinates (latitude, longitude) or general location from which the consent was captured. Used to verify jurisdiction and support location-based consent requirements. May be considered PII under GDPR.',
    `ip_address` STRING COMMENT 'The IP address from which the consent was submitted (for web or mobile app channels). Used for fraud detection, audit trails, and geolocation verification. May be considered PII under GDPR.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this consent record is currently active and enforceable. True = active, False = superseded or inactive. Used for operational filtering to identify current consents.',
    `jurisdiction` STRING COMMENT 'The primary regulatory framework governing this consent: FCC (Federal Communications Commission - US telecom), GDPR (General Data Protection Regulation - EU), CCPA (California Consumer Privacy Act), OFCOM (UK communications regulator), PIPEDA (Canadian privacy law), or LGPD (Brazilian data protection law).. Valid values are `FCC|GDPR|CCPA|OFCOM|PIPEDA|LGPD`',
    `language_preference` STRING COMMENT 'The customers preferred language for communications, using ISO 639-2 three-letter language codes: ENG (English), SPA (Spanish), FRA (French), GER (German), CHI (Chinese), JPN (Japanese), POR (Portuguese), ARA (Arabic). Supports multilingual customer experience and regulatory requirements for language access. [ENUM-REF-CANDIDATE: ENG|SPA|FRA|GER|CHI|JPN|POR|ARA — 8 candidates stripped; promote to reference product]',
    `marketing_email_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive marketing communications via email. True = opted in, False = opted out. Required for CAN-SPAM Act and GDPR compliance.',
    `marketing_mail_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive marketing communications via postal mail. True = opted in, False = opted out.',
    `marketing_phone_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive marketing communications via phone call. True = opted in, False = opted out. Required for TCPA and FCC telemarketing rules compliance.',
    `marketing_sms_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive marketing communications via SMS text message. True = opted in, False = opted out. Required for TCPA compliance.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the consent record (e.g., special circumstances, customer requests, dispute details). Used for operational support and customer service.',
    `paper_bill_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive paper bills via postal mail. True = paper bill requested, False = electronic bill only. Impacts billing operations and environmental sustainability initiatives.',
    `preferred_contact_channel` STRING COMMENT 'The customers preferred channel for receiving communications: email, sms (text message), phone (voice call), mail (postal), mobile_app (push notification), or none (do not contact). Used for operational communication routing and marketing campaign targeting.. Valid values are `email|sms|phone|mail|mobile_app|none`',
    `preferred_contact_time_window` STRING COMMENT 'The time window during which the customer prefers to be contacted, expressed as a time range (e.g., 09:00-17:00, 18:00-21:00). Free-text to accommodate various formats. Used to honor customer communication preferences and improve Customer Satisfaction Score (CSAT).',
    `proof_reference` STRING COMMENT 'Reference identifier or URL to the stored proof of consent (e.g., signed form, recorded call ID, web session ID, email confirmation ID). Required for regulatory audit trails and dispute resolution under GDPR Article 7(1) requirement to demonstrate consent.',
    `retention_period_days` STRING COMMENT 'The number of days for which data collected under this consent will be retained. Null indicates indefinite retention subject to other policies. Required for GDPR storage limitation principle.',
    `service_notification_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive service-related notifications (e.g., outage alerts, billing reminders, service updates). True = opted in, False = opted out. Distinct from marketing opt-ins; typically required for operational communications.',
    `source_system` STRING COMMENT 'The name of the operational system from which this consent record originated (e.g., Salesforce CRM, Web Portal, Mobile App, IVR System, Retail POS). Used for data lineage and troubleshooting.',
    `third_party_sharing_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has consented to sharing their personal data with third-party partners or affiliates. True = consented, False = not consented. Required for GDPR Article 6 lawful basis and CCPA right to opt-out of sale.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this consent record was last modified in the system. Used for audit trails and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `withdrawal_date` DATE COMMENT 'The date when the customer withdrew or revoked consent. Null if consent is still active. Required for GDPR right to withdraw consent tracking.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Unified customer consent, privacy preference, and communication preference record capturing all regulatory consent decisions, operational contact governance, and channel routing preferences. Stores consent/preference type (marketing/data processing/third-party sharing/lawful intercept/CPNI/channel opt-in/contact time window/language preference/paper bill/e-bill), status (granted/withdrawn/pending), channel (web/app/store/IVR/paper), effective date, withdrawal date, consent version (policy version), jurisdiction (FCC/GDPR/CCPA/Ofcom), data category covered, retention period, preferred contact channel, preferred contact time window, do-not-disturb schedule, marketing opt-in flags per channel, service notification opt-in flags, and proof reference. SSOT for all customer contact governance — regulatory compliance, privacy preferences, and operational communication routing. Required for FCC, GDPR, CCPA, and Ofcom regulatory obligations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`device_registration` (
    `device_registration_id` BIGINT COMMENT 'Unique identifier for the device registration record. Primary key.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Device registrations link to the catalog item representing the device product for warranty, insurance enrollment, and device financing workflows. Order management and device lifecycle reporting requir',
    `customer_account_id` BIGINT COMMENT 'Reference to the billing account under which this device is registered.',
    `dealer_id` BIGINT COMMENT 'Reference to the billing installment plan if the device is financed. Null if device is not financed.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: Device registrations must reference the specific model being registered. Mandatory for IMEI/TAC validation, CEIR blocking, network access control, and warranty management.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_order. Business justification: Device registrations are created as a direct result of order fulfillment (new activations, device upgrades, replacements). Linking device_registration to the originating fulfillment_order enables orde',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Links customer-registered device (IMEI/serial) to inventory asset record for warranty management, insurance claims, and device replacement eligibility. Support agents need this to validate warranty st',
    `replacement_device_registration_id` BIGINT COMMENT 'Reference to the new device registration record if this device was replaced. Null if no replacement occurred.',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Enables tracking SIM-device pairing for activation workflows, eSIM provisioning, and SIM swap validation. Real business process: when activating new device or processing SIM swap, system must link dev',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Enterprise CPE and device registrations are physically located at enterprise sites. Telecom field operations and inventory management require site-level device registration tracking for installation, ',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns or is associated with this registered device.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Device-service binding: telecom operations require direct IMEI-to-service-instance mapping for network troubleshooting, CEIR blocking, and device swap workflows. A domain expert expects device_registr',
    `byod_flag` BOOLEAN COMMENT 'Indicates whether the device is customer-owned (BYOD = True) or operator-provided/financed (BYOD = False).',
    `ceir_block_date` DATE COMMENT 'Date when the device was blocked in the CEIR. Null if device is not blocked.',
    `ceir_block_flag` BOOLEAN COMMENT 'Indicates whether the device IMEI has been blocked in the Central Equipment Identity Register (CEIR) due to theft, loss, or fraud (True) or not (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this device registration record was first created in the system. Audit trail field.',
    `data_source_system` STRING COMMENT 'Name of the operational system that is the source of record for this device registration (e.g., Salesforce CRM, Netcracker OSS, Oracle Service Management).',
    `deregistration_date` DATE COMMENT 'Date when the device was deregistered or removed from the subscriber account. Null if device is still registered.',
    `deregistration_reason` STRING COMMENT 'Reason for device deregistration: upgrade to new device, reported lost, reported stolen, damaged beyond repair, sold to another party, service termination, or other. [ENUM-REF-CANDIDATE: upgrade|lost|stolen|damaged|sold|service_termination|other — 7 candidates stripped; promote to reference product]',
    `device_financing_flag` BOOLEAN COMMENT 'Indicates whether the device is under an installment financing plan (True) or purchased outright (False). Links to billing installment plan records.',
    `device_status` STRING COMMENT 'Current lifecycle status of the registered device: active (in use), inactive (not in use), lost (reported lost), stolen (reported stolen and blocked via CEIR), replaced (superseded by new device), or blocked (administratively blocked).. Valid values are `active|inactive|lost|stolen|replaced|blocked`',
    `imei` STRING COMMENT '15-digit unique identifier for mobile handsets and cellular devices. Used for device authentication, fraud detection, and Equipment Identity Register (EIR) blocking of lost/stolen devices.. Valid values are `^[0-9]{15}$`',
    `insurance_enrollment_flag` BOOLEAN COMMENT 'Indicates whether the device is enrolled in an insurance or protection plan (True) or not (False).',
    `insurance_policy_number` STRING COMMENT 'Policy number or reference for the device insurance plan, if enrolled. Used for insurance claim validation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this device registration record was last updated. Audit trail field.',
    `last_network_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the last recorded network activity (data session, voice call, SMS) from this device. Used for device usage analytics and fraud detection.',
    `mac_address` STRING COMMENT 'Hardware address of the device network interface, used for CPE provisioning and network access control.. Valid values are `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`',
    `network_capability_4g` BOOLEAN COMMENT 'Indicates whether the device supports 4G LTE connectivity (True) or not (False).',
    `network_capability_5g` BOOLEAN COMMENT 'Indicates whether the device supports 5G NR connectivity (True) or not (False).',
    `notes` STRING COMMENT 'Free-text notes or comments related to the device registration, such as special handling instructions, customer requests, or issue tracking.',
    `os_type` STRING COMMENT 'Operating system family running on the device: Android, iOS, Windows, Linux, proprietary (for CPE/ONT), or other.. Valid values are `android|ios|windows|linux|proprietary|other`',
    `os_version` STRING COMMENT 'Specific version of the operating system installed on the device (e.g., Android 13, iOS 16.5, firmware v2.1.3 for CPE).',
    `primary_sim_iccid` STRING COMMENT 'Integrated Circuit Card ID of the primary SIM card associated with this device. 19-20 digit unique identifier for the physical or eSIM card.. Valid values are `^[0-9]{19,20}$`',
    `purchase_date` DATE COMMENT 'Date when the device was purchased by the customer, either from the operator or a third party. Used for warranty and upgrade eligibility calculations.',
    `purchase_price_amount` DECIMAL(18,2) COMMENT 'Original purchase price of the device in the billing currency. Used for device financing and depreciation calculations.',
    `registration_channel` STRING COMMENT 'Channel through which the device was registered: retail store, online customer portal, mobile app, call center, or authorized dealer.. Valid values are `retail_store|online_portal|mobile_app|call_center|dealer`',
    `registration_date` DATE COMMENT 'Date when the device was registered against the subscriber or account in the Customer Relationship Management (CRM) system.',
    `registration_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the device registration was recorded in the system, including time zone information.',
    `residual_value_amount` DECIMAL(18,2) COMMENT 'Current estimated residual or trade-in value of the device. Used for upgrade offers and device buyback programs.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for non-cellular devices such as Customer Premises Equipment (CPE), Optical Network Terminals (ONT), routers, modems, and IoT devices.',
    `sim_slot_type` STRING COMMENT 'SIM slot configuration of the device: single SIM, dual SIM (two physical slots), eSIM only (embedded SIM), hybrid (physical + eSIM), or none (for non-cellular devices).. Valid values are `single_sim|dual_sim|esim_only|hybrid|none`',
    `tac` STRING COMMENT 'First 8 digits of the IMEI, identifying the device model and manufacturer. Used for device capability lookup in GSMA TAC database.. Valid values are `^[0-9]{8}$`',
    `volte_capable` BOOLEAN COMMENT 'Indicates whether the device supports Voice over LTE (VoLTE) for voice calls over 4G networks (True) or not (False).',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturer or operator warranty for the device expires. Null if no warranty or warranty information unavailable.',
    `wifi_capability` STRING COMMENT 'Highest Wi-Fi standard supported by the device: WiFi 4 (802.11n), WiFi 5 (802.11ac), WiFi 6 (802.11ax), WiFi 6E (6 GHz), or none.. Valid values are `wifi4|wifi5|wifi6|wifi6e|none`',
    CONSTRAINT pk_device_registration PRIMARY KEY(`device_registration_id`)
) COMMENT 'Record of customer-owned and financed devices registered against a subscriber or account — handsets, tablets, CPE (routers/modems), ONT, and IoT devices. Stores device type, make, model, IMEI/serial number, registration date, device status (active/lost/stolen/replaced), BYOD flag, device financing flag (linked to installment plan), insurance enrollment flag, warranty expiry date, OS version, network capability (4G/5G/VoLTE/WiFi6), SIM slot type, and eSIM profile reference. Distinct from network inventory (operator-owned infrastructure) and inventory domain (stock/warehouse tracking) — this is the customer-premises device registry. Enables IMEI-based fraud detection, stolen device blocking (CEIR/EIR integration), device upgrade targeting, and insurance claim validation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`subscription` (
    `subscription_id` BIGINT COMMENT 'Primary key for customer_subscription',
    `addon_id` BIGINT COMMENT 'Foreign key linking to the add-on product that was purchased',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Each add-on subscription corresponds to a sellable catalog item. Order management, billing reconciliation, and product catalog reporting require linking subscriptions to their catalog item. No existin',
    `channel_id` BIGINT COMMENT 'Foreign key linking to sales.channel. Business justification: The sales channel through which a subscription was sold drives commission calculation and channel performance reporting. customer_subscription has a plain channel string attribute — replacing it wit',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Dealer addon commission calculation requires linking each subscription to the selling dealer. Telecom dealers earn commissions on addon sales (insurance, content bundles); revenue share settlement and',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Add-on subscriptions are tied to a base offering (e.g., streaming add-on available only with a specific broadband offering). Offer-level subscription analytics and eligibility validation require this ',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Each add-on subscription is rated against a price plan governing its recurring charge and proration. Billing accuracy and revenue recognition require knowing the price_plan for the subscription. No ex',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to product.promo_offer. Business justification: Add-on subscriptions are frequently activated under a promotional offer (e.g., first 3 months free). Promo redemption counting and discount application require a proper FK. The existing promotion_code',
    `provisioning_order_id` BIGINT COMMENT 'Foreign key linking to service.provisioning_order. Business justification: Order fulfillment tracking: every addon subscription activation or renewal triggers a provisioning order. Direct link enables SLA compliance reporting on subscription provisioning times and fallout an',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: A customer subscription is the fulfilled result of a specific quote line item. Linking subscription to its originating quote_line enables order-to-cash tracing, commission calculation (commission_elig',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Postpaid and enterprise subscriptions are governed by a sales contract defining term, ETF, and SLA. Linking customer_subscription to its governing sales_contract enables contract compliance tracking, ',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to the subscriber who purchased the add-on',
    `svc_configuration_id` BIGINT COMMENT 'Foreign key linking to service.svc_configuration. Business justification: Addon configuration audit: subscribing to an addon (roaming pack, data boost, VoLTE) triggers a specific service configuration. Direct link enables configuration compliance audits, addon feature verif',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Subscription lifecycle management: when a customer subscribes to an addon, the resulting provisioned service instance must be traceable. Enables subscription-to-service reconciliation reports and chur',
    `activation_date` TIMESTAMP COMMENT 'Date and time when the add-on was activated for this subscriber. Marks the start of service delivery and billing.',
    `addon_status` STRING COMMENT 'Current lifecycle status of this specific subscriber-addon subscription. Active: in use; Suspended: temporarily disabled; Expired: validity period ended; Cancelled: terminated by user or system; Pending: awaiting activation.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this specific subscription will automatically renew at expiry. Subscriber may override the default add-on auto-renewal setting.',
    `cancellation_date` TIMESTAMP COMMENT 'Date and time when the subscriber cancelled this add-on subscription. Null for active subscriptions.',
    `cancellation_reason` STRING COMMENT 'Reason code or description for why the subscription was cancelled. Used for churn analysis and retention strategies.',
    `expiry_date` TIMESTAMP COMMENT 'Date and time when the add-on subscription expires or is scheduled to terminate. Null for perpetual add-ons or those without defined end dates.',
    `last_renewal_date` TIMESTAMP COMMENT 'Date and time of the most recent automatic or manual renewal of this subscription. Null if never renewed.',
    `proration_amount` DECIMAL(18,2) COMMENT 'Prorated charge amount calculated when the add-on is activated or deactivated mid-billing cycle. Null if no proration applies.',
    `quantity` STRING COMMENT 'Number of instances of this add-on subscribed by the subscriber. Relevant for add-ons that allow multiple quantities (e.g., multiple data top-ups, multiple premium channels).',
    `recurring_charge` DECIMAL(18,2) COMMENT 'The actual recurring charge amount applied to this subscriber for this add-on. May differ from the standard add-on price due to promotions, discounts, or subscriber-specific pricing.',
    `trial_end_date` DATE COMMENT 'Date when the free trial period for this add-on ends and billing begins. Null if no trial period applies.',
    CONSTRAINT pk_subscription PRIMARY KEY(`subscription_id`)
) COMMENT 'This association product represents the subscription contract between a subscriber and an add-on product. It captures the activation, lifecycle, and billing details specific to each subscribers purchase of an add-on. Each record links one subscriber to one add-on with attributes that exist only in the context of this subscription relationship, including activation dates, expiry, status, pricing, and renewal behavior.. Existence Justification: In telecommunications operations, subscribers purchase and activate multiple add-ons simultaneously (international roaming, data top-ups, premium content, cloud storage), and each add-on product is purchased by thousands of subscribers. The business actively manages these subscriptions as operational entities with lifecycle states, billing cycles, activation/expiry dates, and subscriber-specific pricing. Customer care, billing, and provisioning systems create, update, and deactivate these subscription records as part of daily operations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_parent_account_customer_account_id` FOREIGN KEY (`parent_account_customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_address_id` FOREIGN KEY (`address_id`) REFERENCES `telecommunication_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ADD CONSTRAINT `fk_customer_customer_contact_address_id` FOREIGN KEY (`address_id`) REFERENCES `telecommunication_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ADD CONSTRAINT `fk_customer_customer_contact_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscription`(`subscription_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_parent_case_id` FOREIGN KEY (`parent_case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscription`(`subscription_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `telecommunication_ecm`.`customer`.`interaction`(`interaction_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_parent_consent_record_id` FOREIGN KEY (`parent_consent_record_id`) REFERENCES `telecommunication_ecm`.`customer`.`consent_record`(`consent_record_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_replacement_device_registration_id` FOREIGN KEY (`replacement_device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ADD CONSTRAINT `fk_customer_subscription_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `telecommunication_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `parent_account_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_activation|on_hold|delinquent');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'basic|silver|gold|platinum|diamond|vip');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'prepaid|postpaid|hybrid|wholesale|mvno|enterprise');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `arpu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `arpu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `auto_pay_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Segment');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_value_regex' = 'high|medium|low|new|at_risk');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `credit_class` SET TAGS ('dbx_business_glossary_term' = 'Credit Class');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `credit_class` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|no_credit_check|secured');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|mid_market|enterprise|wholesale|public_sector');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `do_not_call_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `fraud_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail|mobile_app|web_portal');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Account Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_activation|on_hold|delinquent');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `primary_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `service_address_same_as_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Address Same As Billing Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `service_address_same_as_billing_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `service_address_same_as_billing_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `status_change_date` SET TAGS ('dbx_business_glossary_term' = 'Status Change Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `status_change_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Status Change Initiated By');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `status_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `sub_type` SET TAGS ('dbx_business_glossary_term' = 'Account Sub-Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `sub_type` SET TAGS ('dbx_value_regex' = 'individual|family|business|government|nonprofit|reseller');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'Very Important Person (VIP) Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Msisdn Range Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Activation Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `biometric_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Biometric Verification Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `biometric_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `biometric_verified_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `cltv_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `cltv_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `credit_class` SET TAGS ('dbx_business_glossary_term' = 'Credit Classification');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `credit_class` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|no_credit');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `credit_class` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'premium|standard|value|youth|senior|business');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `data_speed_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Speed Tier');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `data_speed_tier` SET TAGS ('dbx_value_regex' = 'unlimited|high_speed|standard|throttled|zero_rated');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Date of Birth');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Deactivation Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `device_imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `device_imei` SET TAGS ('dbx_value_regex' = '^d{15}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `device_imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `device_imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `esim_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Embedded SIM (eSIM) Eligibility Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `five_g_enabled_flag` SET TAGS ('dbx_business_glossary_term' = '5G New Radio (5G NR) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `fraud_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `hotspot_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Hotspot Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `iccid` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit Card Identifier (ICCID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `iccid` SET TAGS ('dbx_value_regex' = '^89[0-9]{17,19}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `iccid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `iccid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `id_document_number` SET TAGS ('dbx_business_glossary_term' = 'Identification Document Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `id_document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `id_document_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `id_document_type` SET TAGS ('dbx_business_glossary_term' = 'Identification Document Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `id_document_type` SET TAGS ('dbx_value_regex' = 'passport|national_id|drivers_license|residence_permit|military_id|other');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `id_document_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^d{14,15}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `international_dialing_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Dialing Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `last_nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Net Promoter Score (NPS) Survey Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `last_sim_swap_date` SET TAGS ('dbx_business_glossary_term' = 'Last SIM Swap Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `last_usage_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Usage Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Communication Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Nationality');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `parental_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `qos_profile` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Profile');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `qos_profile` SET TAGS ('dbx_value_regex' = 'premium|standard|basic|best_effort');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `roaming_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `roaming_profile` SET TAGS ('dbx_business_glossary_term' = 'Roaming Profile');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `roaming_profile` SET TAGS ('dbx_value_regex' = 'domestic_only|international|regional|premium|restricted');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `sim_swap_count` SET TAGS ('dbx_business_glossary_term' = 'SIM Swap Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|pending_activation|terminated|barred');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `subscriber_type` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `subscriber_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|add_on|dependent|shared_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `volte_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice over Long-Term Evolution (VoLTE) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `vowifi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice over Wi-Fi (VoWiFi) Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `alternate_phone` SET TAGS ('dbx_business_glossary_term' = 'Alternate Phone Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `alternate_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `alternate_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'full|limited|view_only|none');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `communication_language` SET TAGS ('dbx_business_glossary_term' = 'Communication Language');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `communication_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_value_regex' = 'primary_account_holder|authorized_representative|technical_contact|billing_contact|emergency_contact|legal_contact');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deceased');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `do_not_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `marketing_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `marketing_opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-Out Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_value_regex' = 'email|mobile|phone|sms|mail|portal');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `relationship_to_account_holder` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Account Holder');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contact Title');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `title` SET TAGS ('dbx_value_regex' = 'Mr|Mrs|Ms|Dr|Prof');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Verification Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Verification Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending|failed');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `olt_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Olt Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'service|billing|installation|correspondence|shipping|legal');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `broadband_coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Broadband Coverage Tier');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `broadband_coverage_tier` SET TAGS ('dbx_value_regex' = 'fiber|cable|dsl|fixed_wireless|satellite|no_coverage');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `dwelling_type` SET TAGS ('dbx_business_glossary_term' = 'Dwelling Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `ftth_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fiber to the Home (FTTH) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `gpon_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Gigabit Passive Optical Network (GPON) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `hash` SET TAGS ('dbx_business_glossary_term' = 'Address Hash');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `lte_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Evolution (LTE) Coverage Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `maximum_download_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Download Speed in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `maximum_upload_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Upload Speed in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `mdu_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Dwelling Unit (MDU) Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `n5g_coverage_flag` SET TAGS ('dbx_business_glossary_term' = '5G New Radio (NR) Coverage Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_business_glossary_term' = 'Standardized Address');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `unit_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Source');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|invalid|pending|corrected|partial');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'service_support');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `retention_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Subscription Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `callback_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Callback Requested Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `callback_scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Callback Scheduled Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'voice|chat|email|store|mobile_app|web_portal');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `customer_effort_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Effort Score (CES)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Interaction Direction');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration in Seconds');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction End Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `fcr_flag` SET TAGS ('dbx_business_glossary_term' = 'First Call Resolution (FCR) Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated|pending');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'inquiry|complaint|service_request|sales|technical_support|billing_inquiry');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Notes');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `nps_survey_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Triggered Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `queue_name` SET TAGS ('dbx_business_glossary_term' = 'Queue Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `recording_url` SET TAGS ('dbx_business_glossary_term' = 'Recording Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `recording_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Interaction Reference Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^INT-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|partially_resolved|escalated|pending');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Interaction Source System');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Interaction Summary');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `topic_category` SET TAGS ('dbx_business_glossary_term' = 'Topic Category');
ALTER TABLE `telecommunication_ecm`.`customer`.`interaction` ALTER COLUMN `topic_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Topic Subcategory');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` SET TAGS ('dbx_subdomain' = 'service_support');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `parent_case_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Case Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `problem_record_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `retention_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Subscription Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Case Category');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^CASE-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_customer|resolved|closed|cancelled');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'complaint|billing_dispute|technical_fault|mnp_request|general_inquiry|save_offer');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Contact Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `contact_attempts` SET TAGS ('dbx_business_glossary_term' = 'Contact Attempts');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `contract_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Extension Months');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Case Created Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `fcr_flag` SET TAGS ('dbx_business_glossary_term' = 'First Call Resolution (FCR) Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `modified_date` SET TAGS ('dbx_business_glossary_term' = 'Case Modified Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `offer_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `offer_value` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Value');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Case Origin');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'customer_initiated|proactive_outreach|system_generated|escalation|third_party');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `reopen_count` SET TAGS ('dbx_business_glossary_term' = 'Reopen Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `retention_cost` SET TAGS ('dbx_business_glossary_term' = 'Retention Cost');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `retention_outcome` SET TAGS ('dbx_business_glossary_term' = 'Retention Outcome');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `retention_outcome` SET TAGS ('dbx_value_regex' = 'retained|churned|pending|no_action');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `retention_trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `retention_trigger_reason` SET TAGS ('dbx_value_regex' = 'churn_intent|contract_expiry|competitor_offer|high_risk_score|usage_decline|payment_issue');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `save_desk_queue` SET TAGS ('dbx_business_glossary_term' = 'Save Desk Queue');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `sla_target_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Case Subject');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `time_to_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Time to Resolution (Hours)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Interaction Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `parent_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Consent Record Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Method');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'explicit|implicit|opt_in|opt_out|pre_checked|unchecked');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|expired|revoked');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_text` SET TAGS ('dbx_business_glossary_term' = 'Consent Text Presented');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing|data_processing|third_party_sharing|lawful_intercept|cpni|channel_opt_in');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Version');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `data_category` SET TAGS ('dbx_business_glossary_term' = 'Data Category Covered');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `do_not_disturb_schedule` SET TAGS ('dbx_business_glossary_term' = 'Do Not Disturb (DND) Schedule');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `electronic_bill_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Electronic Bill (E-Bill) Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `geolocation` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Coordinates');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `geolocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `geolocation` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Consent Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'FCC|GDPR|CCPA|OFCOM|PIPEDA|LGPD');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `marketing_email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Email Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `marketing_email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `marketing_email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `marketing_mail_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Postal Mail Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `marketing_phone_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Phone Call Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `marketing_phone_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `marketing_phone_opt_in` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `marketing_sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Short Message Service (SMS) Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Notes');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `paper_bill_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Paper Bill Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail|mobile_app|none');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `preferred_contact_time_window` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Time Window');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `proof_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Proof Reference');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period in Days');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `service_notification_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Service Notification Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `third_party_sharing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Data Sharing Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Installment Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `replacement_device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Device Registration Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `byod_flag` SET TAGS ('dbx_business_glossary_term' = 'Bring Your Own Device (BYOD) Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `ceir_block_date` SET TAGS ('dbx_business_glossary_term' = 'Central Equipment Identity Register (CEIR) Block Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `ceir_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Central Equipment Identity Register (CEIR) Block Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `deregistration_date` SET TAGS ('dbx_business_glossary_term' = 'Device Deregistration Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `deregistration_reason` SET TAGS ('dbx_business_glossary_term' = 'Device Deregistration Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `device_financing_flag` SET TAGS ('dbx_business_glossary_term' = 'Device Financing Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `device_status` SET TAGS ('dbx_business_glossary_term' = 'Device Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `device_status` SET TAGS ('dbx_value_regex' = 'active|inactive|lost|stolen|replaced|blocked');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `imei` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `insurance_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Device Insurance Enrollment Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Device Insurance Policy Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `last_network_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Network Activity Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `network_capability_4g` SET TAGS ('dbx_business_glossary_term' = '4G Long-Term Evolution (LTE) Network Capability');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `network_capability_5g` SET TAGS ('dbx_business_glossary_term' = '5G New Radio (NR) Network Capability');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Notes');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `os_type` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `os_type` SET TAGS ('dbx_value_regex' = 'android|ios|windows|linux|proprietary|other');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `os_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Version');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `primary_sim_iccid` SET TAGS ('dbx_business_glossary_term' = 'Primary Integrated Circuit Card Identifier (ICCID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `primary_sim_iccid` SET TAGS ('dbx_value_regex' = '^[0-9]{19,20}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `primary_sim_iccid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `primary_sim_iccid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Device Purchase Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `purchase_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Device Purchase Price Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `purchase_price_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `registration_channel` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `registration_channel` SET TAGS ('dbx_value_regex' = 'retail_store|online_portal|mobile_app|call_center|dealer');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `residual_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Device Residual Value Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `residual_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `sim_slot_type` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identity Module (SIM) Slot Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `sim_slot_type` SET TAGS ('dbx_value_regex' = 'single_sim|dual_sim|esim_only|hybrid|none');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `tac` SET TAGS ('dbx_business_glossary_term' = 'Type Allocation Code (TAC)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `tac` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `volte_capable` SET TAGS ('dbx_business_glossary_term' = 'Voice over Long-Term Evolution (VoLTE) Capable');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Device Warranty Expiry Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `wifi_capability` SET TAGS ('dbx_business_glossary_term' = 'Wi-Fi Capability');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `wifi_capability` SET TAGS ('dbx_value_regex' = 'wifi4|wifi5|wifi6|wifi6e|none');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'customer_subscription Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription - Addon Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription - Subscriber Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `svc_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Configuration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `addon_status` SET TAGS ('dbx_business_glossary_term' = 'Add-on Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `proration_amount` SET TAGS ('dbx_business_glossary_term' = 'Proration Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `recurring_charge` SET TAGS ('dbx_business_glossary_term' = 'Recurring Charge Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscription` ALTER COLUMN `trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trial End Date');
