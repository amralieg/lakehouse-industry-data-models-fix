-- Schema for Domain: customer | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`customer` COMMENT 'SSOT for all subscriber identities, account hierarchies, and relationship data across B2C consumers, B2B enterprise accounts, and wholesale clients. Manages customer profiles, contacts, segments, household groupings, NPS/CSAT scores, CLTV segmentation, and CRM interactions managed via Salesforce CRM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`customer_account` (
    `customer_account_id` BIGINT COMMENT 'Unique system identifier for the customer account. Primary key for the customer account entity. Serves as the anchor for all customer-related data across billing, order, service, and usage domains.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Enterprise/corporate accounts require dedicated account managers for relationship management, contract negotiations, upsell opportunities, and executive escalations. Critical for B2B revenue operation',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Accounts enroll in specific offerings (promotional packages, enterprise solutions). Primary commercial relationship for order capture, contract management, and revenue recognition.',
    `parent_account_customer_account_id` BIGINT COMMENT 'Reference to parent account in hierarchical account structures. Used for enterprise customers with master account and sub-accounts, family plans with primary and secondary accounts, or wholesale relationships with reseller hierarchy. Null for standalone accounts. Enables consolidated billing and hierarchical reporting.',
    `partner_id` BIGINT COMMENT 'External identifier linking this customer account to corresponding account record in Salesforce CRM system. 15 or 18 character alphanumeric Salesforce ID. Enables bidirectional synchronization of customer data, opportunity tracking, case management, and 360-degree customer view. Null if account not yet synced to Salesforce.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Accounts are assigned specific price plans for billing calculations. Essential for invoice generation, ARPU reporting, and revenue assurance in telecommunications billing systems.',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Account-level attributes (account_tier, credit_class, churn_risk_score, cltv_segment) are primary segmentation criteria for B2C and B2B analytics, campaign targeting, and personalized pricing. Fundame',
    `location_address_id` BIGINT COMMENT 'Foreign key linking to location.location_address. Business justification: Accounts require authoritative geocoded service addresses for installation scheduling, coverage qualification, service provisioning, and regulatory reporting. Location.location_address is the master a',
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
    `customer_address_id` BIGINT COMMENT 'FK to customer.address',
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
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Subscribers have active catalog items (SIM plans, data plans). Core service relationship for provisioning, usage rating, and service assurance in mobile/broadband operations.',
    `customer_account_id` BIGINT COMMENT 'Reference to the parent billing account. A single account may have multiple subscribers.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Subscriber may have a service address (where the line is primarily used, different from account billing address). Adding service_address_id FK links subscriber to their service location for network pl',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Subscriber may have a designated contact person (authorized user, line owner, account manager for that SIM). Adding primary_contact_id FK tracks the subscribers contact. Removing first_name, last_nam',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: Subscribers use specific device models (iPhone 14, Samsung Galaxy). Required for device compatibility checks, VoLTE/5G enablement, network optimization, and technical support.',
    `household_id` BIGINT COMMENT 'Foreign key linking to customer.household. Business justification: Subscribers can be grouped into households (family plans, shared data pools, household billing). Adding household_id FK links subscriber to household grouping. No redundant columns to remove as subscr',
    `mvno_profile_id` BIGINT COMMENT 'Unique identifier for the eSIM profile provisioned to the subscriber. Null for physical SIM subscribers.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Subscribers are provisioned with specific offerings. Direct service-to-product link for network provisioning, QoS policy application, and service entitlement management.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Subscribers are rated under specific price plans. Essential for real-time charging, usage mediation, and prepaid/postpaid billing in telecommunications rating engines.',
    `location_address_id` BIGINT COMMENT 'Foreign key linking to location.location_address. Business justification: Subscribers need authoritative service addresses for network slice assignment, coverage tier determination, field service dispatch, and roaming profile configuration. Location.location_address provide',
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
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account this contact is associated with. Links contact to parent customer entity in Salesforce CRM Customer 360.',
    `address_line_1` STRING COMMENT 'The first line of the contact persons mailing or physical address, typically containing street number and street name.',
    `address_line_2` STRING COMMENT 'The second line of the contact persons address, typically containing apartment, suite, or unit number.',
    `alternate_phone` STRING COMMENT 'An alternate or secondary telephone number for the contact person (landline, office, or additional mobile).',
    `authorization_level` STRING COMMENT 'The level of authorization or permission this contact has to perform actions on the customer account (e.g., make changes, view bills, authorize service orders).. Valid values are `full|limited|view_only|none`',
    `city` STRING COMMENT 'The city or municipality of the contact persons address.',
    `communication_language` STRING COMMENT 'The preferred language for communication with the contact person, specified as a 3-letter ISO 639-2 language code (e.g., ENG for English, SPA for Spanish).. Valid values are `^[A-Z]{3}$`',
    `contact_role` STRING COMMENT 'The role or capacity in which this contact person is associated with the customer account. Defines the contacts authority and responsibility level.. Valid values are `primary_account_holder|authorized_representative|technical_contact|billing_contact|emergency_contact|legal_contact`',
    `contact_status` STRING COMMENT 'The current lifecycle status of the contact record. Indicates whether the contact is actively associated with the customer account.. Valid values are `active|inactive|suspended|deceased`',
    `country_code` STRING COMMENT 'The 3-letter ISO country code representing the country of the contact persons address (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
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
    `postal_code` STRING COMMENT 'The postal code or ZIP code of the contact persons address.',
    `preferred_contact_channel` STRING COMMENT 'The contact persons preferred communication channel for receiving notifications, updates, and correspondence from the telecommunications provider.. Valid values are `email|mobile|phone|sms|mail|portal`',
    `relationship_to_account_holder` STRING COMMENT 'Describes the personal or professional relationship of this contact to the primary account holder (e.g., spouse, parent, employee, business partner).',
    `source_system` STRING COMMENT 'The name or identifier of the operational system from which this contact record originated (e.g., Salesforce CRM, legacy billing system, customer portal).',
    `state_province` STRING COMMENT 'The state, province, or region of the contact persons address.',
    `title` STRING COMMENT 'The honorific or courtesy title of the contact person (e.g., Mr., Mrs., Dr.).. Valid values are `Mr|Mrs|Ms|Dr|Prof`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this contact record was last modified or updated. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `verification_date` DATE COMMENT 'The date when the contact information was last verified or validated.',
    `verification_status` STRING COMMENT 'The verification status of the contact information. Indicates whether the contact details (email, phone) have been validated through verification processes.. Valid values are `verified|unverified|pending|failed`',
    CONSTRAINT pk_customer_contact PRIMARY KEY(`customer_contact_id`)
) COMMENT 'Contact person record associated with a customer account — primary account holder, authorized representative, technical contact, billing contact, or emergency contact. Stores full name, title, job title (for B2B), email address, mobile number, alternate phone, preferred contact channel, contact role, do-not-contact flags, marketing opt-in/opt-out, communication language, and verification status. Supports multiple contacts per account with role-based differentiation. SSOT for customer contact identity within the customer domain.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`customer_address` (
    `customer_address_id` BIGINT COMMENT 'Unique identifier for the address record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account or subscriber associated with this address.',
    `location_address_id` BIGINT COMMENT 'Foreign key linking to location.location_address. Business justification: Customer addresses must reference authoritative location addresses for geocoding validation, serviceability checks, coverage tier assignment, and network planning. Location.location_address is the mas',
    `partner_id` BIGINT COMMENT 'Identifier of the cellular tower or base station that provides primary wireless coverage to this address. Used for fixed wireless and mobile service planning.',
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
    `serving_central_office` STRING COMMENT 'Identifier or name of the telecommunications central office, wire center, or exchange that serves this address. Used for network planning and service provisioning.',
    `source_system` STRING COMMENT 'Name of the operational system that originated or last updated this address record (e.g., Salesforce CRM, Oracle OSM, customer portal, field service application).',
    `standardized_address` STRING COMMENT 'Fully standardized and formatted address string as returned by the validation service, following postal authority standards. Used for mail delivery and system integration.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the address is located. Use standard postal abbreviations (e.g., CA for California, ON for Ontario).',
    `unit_count` STRING COMMENT 'Number of individual units or dwellings within the property at this address. Relevant for MDU properties and bulk service opportunities.',
    `validation_source` STRING COMMENT 'Name of the validation service or system used to verify the address (e.g., USPS CASS, Google Maps API, Loqate, Melissa Data, internal GIS system).',
    `validation_status` STRING COMMENT 'Current validation state of the address: validated (confirmed accurate by validation service), unvalidated (not yet checked), invalid (failed validation), pending (validation in progress), corrected (modified during validation), or partial (some components validated).. Valid values are `validated|unvalidated|invalid|pending|corrected|partial`',
    CONSTRAINT pk_customer_address PRIMARY KEY(`customer_address_id`)
) COMMENT 'Physical and mailing address records associated with customer accounts and subscribers. Captures address type (service address, billing address, installation address, correspondence address), street line 1 and 2, city, state/province, postal code, country, geocoordinates (latitude/longitude), address validation status, address validation source, GPON/FTTH serviceability flag, broadband coverage tier, and last verified date. Supports multiple addresses per account. Critical for service provisioning, field dispatch, and coverage eligibility checks.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`household` (
    `household_id` BIGINT COMMENT 'Unique system identifier for the household grouping entity. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the primary account holder who is the billing and administrative owner of the household. This is the main subscriber account within the household grouping.',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Household has embedded address fields that should be normalized to reference customer.address table. Adding primary_service_address_id FK eliminates redundant address storage. Removing 6 embedded addr',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Household should have a primary contact person (household decision-maker, bill payer, authorized representative). Adding primary_contact_id FK identifies the households primary contact. No redundant ',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Household-level segmentation (household_cltv_tier, shared_data_pool usage patterns, member_count) drives family plan analytics, cross-sell strategies, and household ARPU optimization. Critical for mul',
    `location_address_id` BIGINT COMMENT 'Foreign key linking to location.location_address. Business justification: Households require authoritative service addresses for shared data pool provisioning, family plan configuration, and multi-line service delivery. Location.location_address provides geocoded coordinate',
    `activation_date` DATE COMMENT 'Date when the household grouping became active and eligible for shared services. May differ from created_timestamp if there was a pending activation period.',
    `active_member_count` STRING COMMENT 'Number of household members with active service status. Excludes suspended or terminated member accounts.',
    `arpu` DECIMAL(18,2) COMMENT 'Combined monthly average revenue per user across all household members. Calculated as total household monthly recurring revenue divided by active member count. Used for household-level value segmentation.',
    `autopay_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic payment is enabled for the household. True if autopay is active, False if manual payment is required.',
    `billing_cycle_day` STRING COMMENT 'Day of the month when the household billing cycle closes and invoices are generated. Value between 1 and 28 to accommodate all months.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Predictive score indicating the likelihood of household churn, ranging from 0.0000 (no risk) to 1.0000 (high risk). Generated by churn prediction models using usage patterns, payment history, and interaction data.',
    `churn_risk_tier` STRING COMMENT 'Categorical segmentation of household churn risk for retention campaign targeting. Derived from churn_risk_score thresholds.. Valid values are `critical|high|medium|low|minimal`',
    `cltv_score` DECIMAL(18,2) COMMENT 'Calculated lifetime value score for the household in monetary terms. Represents the projected total revenue from this household over the expected relationship duration.',
    `cltv_tier` STRING COMMENT 'Segmentation tier based on projected lifetime value of the entire household. Used for retention strategy prioritization and personalized offer targeting.. Valid values are `platinum|gold|silver|bronze|standard`',
    `contract_end_date` DATE COMMENT 'Date when the current household service contract or commitment period expires. Used for retention planning and renewal campaign timing.',
    `contract_type` STRING COMMENT 'Type of service contract or commitment period for the household. Determines early termination fees and upgrade eligibility.. Valid values are `month_to_month|12_month|24_month|36_month|prepaid|custom`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the household grouping record was first created in the system. Represents the initial establishment of the household relationship.',
    `credit_class` STRING COMMENT 'Credit risk classification for the household based on credit bureau data and payment history. Determines deposit requirements and service eligibility.. Valid values are `excellent|good|fair|poor|no_credit_check`',
    `csat_score` DECIMAL(18,2) COMMENT 'Average customer satisfaction score for the household, typically on a scale of 1.00 to 5.00. Derived from service interaction surveys and feedback.',
    `household_name` STRING COMMENT 'Display name for the household grouping, typically the family surname or primary account holder name (e.g., Smith Family, Johnson Household).',
    `household_status` STRING COMMENT 'Current lifecycle state of the household grouping. Active households have at least one active member account; suspended households have temporary service restrictions; terminated households are closed.. Valid values are `active|suspended|inactive|pending_activation|terminated`',
    `household_type` STRING COMMENT 'Classification of the household grouping structure. Determines eligibility for specific plan types and shared resource configurations.. Valid values are `family_plan|shared_data_group|multi_line_residential|business_group|student_group|senior_plan`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the household record was most recently updated. Tracks any changes to household configuration, membership, or attributes.',
    `loyalty_points_balance` STRING COMMENT 'Current accumulated loyalty points balance for the household. Points can be redeemed for rewards, discounts, or service upgrades.',
    `loyalty_program_tier` STRING COMMENT 'Current tier in the telecommunications provider loyalty or rewards program. Determines eligibility for exclusive benefits, discounts, and priority support.. Valid values are `diamond|platinum|gold|silver|bronze|none`',
    `member_count` STRING COMMENT 'Total number of individual subscriber accounts currently linked to this household grouping. Used for family plan eligibility and pricing tier determination.',
    `mrr` DECIMAL(18,2) COMMENT 'Total monthly recurring revenue generated by all members of the household. Sum of all subscription charges, shared plan fees, and recurring add-ons across household members.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score for the household, ranging from -100 to +100. Aggregated from individual member NPS responses or assigned at household level.',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether the household has opted for electronic billing statements only. True if paperless, False if paper invoices are mailed.',
    `payment_method_type` STRING COMMENT 'Primary payment instrument type used for household billing. Determines payment processing workflow and collection strategy. [ENUM-REF-CANDIDATE: credit_card|debit_card|bank_transfer|direct_debit|prepaid|cash|check — 7 candidates stripped; promote to reference product]',
    `preferred_contact_method` STRING COMMENT 'Primary communication channel preferred by the household for service notifications, billing alerts, and promotional offers.. Valid values are `email|sms|phone|mail|mobile_app`',
    `reference_number` STRING COMMENT 'Business-facing unique identifier for the household, used in customer service interactions and billing statements. Format: HH followed by 10 digits.. Valid values are `^HH[0-9]{10}$`',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Total security deposit held for the household, if applicable. Based on credit class and service type. Refundable upon account closure or credit improvement.',
    `segment` STRING COMMENT 'Marketing and service segmentation classification for the household. Determines product offerings, pricing strategies, and service level expectations.. Valid values are `premium|mass_market|value|prepaid|business`',
    `shared_data_pool_flag` BOOLEAN COMMENT 'Indicates whether the household has a shared data pool configuration where all members draw from a common data allowance. True if shared pool is active, False otherwise.',
    `shared_data_pool_size_gb` DECIMAL(18,2) COMMENT 'Total size of the shared data pool in gigabytes available to all household members. Null if shared_data_pool_flag is False.',
    `shared_data_pool_used_gb` DECIMAL(18,2) COMMENT 'Current month-to-date data consumption from the shared pool across all household members, measured in gigabytes.',
    `shared_minutes_pool_flag` BOOLEAN COMMENT 'Indicates whether the household has a shared voice minutes pool where all members draw from a common allowance. True if shared minutes pool is active, False otherwise.',
    `shared_minutes_pool_size` STRING COMMENT 'Total number of voice minutes in the shared pool available to all household members. Null if shared_minutes_pool_flag is False.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system that originated this household record. Used for data lineage tracking and reconciliation across systems.. Valid values are `salesforce_crm|amdocs|netcracker|oracle_osm|legacy_billing|manual_entry`',
    `termination_date` DATE COMMENT 'Date when the household grouping was terminated or closed. Null for active households. Used for retention analysis and win-back campaign eligibility.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for household termination. Used for churn analysis and service improvement initiatives. Null for active households. [ENUM-REF-CANDIDATE: voluntary_churn|involuntary_churn|relocation|financial|service_quality|competitor_offer|deceased|other — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Household grouping entity that links multiple individual subscriber accounts sharing a common residential address or family relationship. Stores household reference number, household type (family plan, shared data group, multi-line residential), primary account holder reference, number of members, combined ARPU, household CLTV tier, shared data pool flag, shared data pool size (GB), and household creation date. Enables family plan management, shared data bundles, and household-level analytics for B2C segment. Distinct from corporate account hierarchy.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` (
    `corporate_hierarchy_id` BIGINT COMMENT 'Unique identifier for the corporate hierarchy node. Primary key for the corporate hierarchy entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Corporate hierarchies have separate billing arrangements (consolidated billing, cost center allocation, invoice aggregation, inter-company charging). Direct billing_account link enables enterprise bil',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Enterprise B2B accounts in telecommunications require cost center mapping for internal charge-back, budget allocation, and departmental expense tracking. Corporate hierarchy nodes (divisions, subsidia',
    `customer_address_id` BIGINT COMMENT 'FK to customer.address',
    `customer_contact_id` BIGINT COMMENT 'FK to customer.contact',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Large enterprise customers often have both consumer corporate hierarchy structures and enterprise managed service accounts. Telcos track which enterprise account manager owns the commercial relationsh',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Enterprise segmentation by hierarchy_level, employee_headcount_band, annual_revenue_band, and industry_vertical_code is fundamental for B2B analytics, account planning, and enterprise sales targeting.',
    `location_address_id` BIGINT COMMENT 'Foreign key linking to location.location_address. Business justification: Corporate entities require authoritative headquarters addresses for service territory assignment, enterprise account management, and regulatory jurisdiction determination. Location.location_address pr',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Corporate accounts subscribe to enterprise offerings (MPLS, SD-WAN, IoT solutions). Essential B2B commercial relationship for enterprise sales, contract management, and account planning.',
    `parent_hierarchy_corporate_hierarchy_id` BIGINT COMMENT 'Reference to the parent node in the corporate hierarchy structure. Null for ultimate parent/root nodes. Enables recursive traversal of the organizational tree.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Corporate accounts have negotiated price plans (volume discounts, custom rates). Required for enterprise pricing management, contract compliance, and revenue forecasting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Corporate accounts are segmented by profit center for P&L reporting, revenue attribution, and business unit performance analysis. Telecommunications operators track enterprise customer profitability b',
    `annual_revenue_band` STRING COMMENT 'Categorical range representing the entitys annual revenue in USD. Used for customer segmentation, credit assessment, and strategic account classification. Bands represent millions of dollars.. Valid values are `0-1M|1M-10M|10M-50M|50M-100M|100M-500M|500M+`',
    `billing_cycle_day` STRING COMMENT 'Day of the month (1-31) when invoices are generated for this hierarchy node. Used for billing schedule management and revenue recognition timing.',
    `company_registration_number` STRING COMMENT 'Government-issued registration or incorporation number assigned by the jurisdiction of incorporation. Used for legal verification, due diligence, and regulatory reporting.',
    `consolidated_billing_flag` BOOLEAN COMMENT 'Indicates whether charges for this hierarchy node and its children are consolidated into a single invoice sent to the parent entity. True enables enterprise-wide billing aggregation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this hierarchy node record was first created in the system. Used for audit trail, data lineage, and record lifecycle tracking.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for this hierarchy node in USD. Used for order approval, billing controls, and accounts receivable management. Null indicates no credit limit.',
    `credit_rating` STRING COMMENT 'External credit rating assigned by a credit rating agency (e.g., Moodys, S&P, Fitch). Used for credit risk assessment, payment terms determination, and financial exposure management. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — 10 candidates stripped; promote to reference product]',
    `doing_business_as_name` STRING COMMENT 'Trade name or brand name under which the entity operates commercially. May differ from the legal entity name. Used for customer-facing communications and marketing.',
    `effective_end_date` DATE COMMENT 'Date when this hierarchy node was deactivated or terminated. Null for currently active nodes. Used for churn analysis, contract expiration tracking, and historical segmentation.',
    `effective_start_date` DATE COMMENT 'Date when this hierarchy node became active and operational. Used for temporal analysis, contract lifecycle management, and historical reporting.',
    `employee_headcount_band` STRING COMMENT 'Categorical range representing the total number of employees across the entity. Used for enterprise segmentation, pricing tier determination, and sales territory assignment.. Valid values are `1-10|11-50|51-200|201-500|501-1000|1001-5000|5001+`',
    `general_ledger_account_code` STRING COMMENT 'Chart of accounts code in the ERP system used for financial posting and consolidation. Links hierarchy node to the financial accounting structure.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this node in the hierarchy tree. Level 1 represents the ultimate parent, level 2 represents direct subsidiaries, and so on. Used for hierarchy traversal and reporting rollups.',
    `hierarchy_node_type` STRING COMMENT 'Classification of the node within the corporate structure. Ultimate parent represents the top-level legal entity, subsidiary is a controlled entity, branch is a geographic location, department is a functional unit, cost center is a budget allocation unit, and division is a business segment.. Valid values are `ultimate_parent|subsidiary|branch|department|cost_center|division`',
    `hierarchy_status` STRING COMMENT 'Current operational status of the hierarchy node. Active indicates the node is operational, inactive indicates it has been deactivated, suspended indicates temporary hold, pending states indicate workflow transitions.. Valid values are `active|inactive|suspended|pending_activation|pending_termination`',
    `industry_vertical_code` STRING COMMENT 'Standard Industrial Classification (SIC) or North American Industry Classification System (NAICS) code identifying the primary business sector. Used for market segmentation, competitive analysis, and product targeting.',
    `industry_vertical_description` STRING COMMENT 'Human-readable description of the industry vertical corresponding to the SIC or NAICS code. Examples: Financial Services, Healthcare, Manufacturing, Retail, Technology.',
    `jurisdiction_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the legal jurisdiction of incorporation or registration. Used for regulatory compliance, tax treatment, and legal entity management.. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_state_province` STRING COMMENT 'State, province, or regional subdivision within the jurisdiction country where the entity is registered. Used for state-level tax compliance and regulatory reporting.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user or system process that last modified this record. Used for audit trail, compliance reporting, and change management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this hierarchy node record was last updated. Used for change tracking, data quality monitoring, and incremental data processing.',
    `legal_entity_identifier` STRING COMMENT 'ISO 17442 compliant 20-character alphanumeric Legal Entity Identifier for global entity identification in financial transactions and regulatory reporting. Required for large enterprise accounts.. Valid values are `^[A-Z0-9]{20}$`',
    `legal_entity_name` STRING COMMENT 'Official registered legal name of the corporate entity as it appears on incorporation documents, contracts, and regulatory filings. Used for legal compliance, invoicing, and contract management.',
    `managed_account_flag` BOOLEAN COMMENT 'Indicates whether this hierarchy node is assigned to a dedicated account manager or strategic account team. True for high-value enterprise accounts requiring white-glove service.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of equity ownership the parent entity holds in this subsidiary or controlled entity. Used for financial consolidation, regulatory reporting, and corporate structure analysis. Range 0.00 to 100.00.',
    `payment_terms_days` STRING COMMENT 'Standard number of days allowed for invoice payment (e.g., Net 30, Net 60). Used for accounts receivable forecasting, cash flow management, and dunning process configuration.',
    `relationship_type` STRING COMMENT 'Nature of the corporate relationship between parent and child nodes. Wholly owned indicates 100% ownership, majority owned indicates >50%, minority owned indicates <50%, joint venture indicates shared control, affiliate indicates associated entity.. Valid values are `wholly_owned|majority_owned|minority_owned|joint_venture|affiliate`',
    `salesforce_account_code` STRING COMMENT 'External identifier from Salesforce CRM system linking this hierarchy node to the corresponding Account object. Used for CRM integration, opportunity tracking, and customer 360 view.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `tax_identification_number` STRING COMMENT 'Tax identifier assigned by the tax authority in the entitys jurisdiction. Used for tax reporting, invoicing, and revenue recognition. May be EIN (USA), VAT number (EU), or equivalent.',
    CONSTRAINT pk_corporate_hierarchy PRIMARY KEY(`corporate_hierarchy_id`)
) COMMENT 'B2B enterprise account hierarchy structure defining parent-child relationships between corporate accounts, subsidiaries, departments, and cost centers. Stores hierarchy node type (ultimate parent, subsidiary, branch, department), parent node reference, hierarchy level, legal entity name, company registration number, tax identification number, industry vertical (SIC/NAICS code), employee headcount band, annual revenue band, and managed account flag. Enables enterprise account management, consolidated billing, and B2B sales reporting. Distinct from household (B2C grouping).';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`customer_interaction` (
    `customer_interaction_id` BIGINT COMMENT 'Unique identifier for the customer interaction record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Interactions frequently address billing topics (payment inquiries, invoice questions, balance checks, payment method updates). Direct billing_account link enables billing interaction analytics, billin',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Interactions often concern specific catalog items (plan inquiries, upgrade requests, billing questions). Provides customer service context for CRM systems and interaction analytics.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Interactions often involve a specific contact person (caller, chat initiator, email sender). Adding contact_id FK tracks who initiated the interaction. No redundant columns to remove.',
    `customer_mnp_request_id` BIGINT COMMENT 'Foreign key linking to customer.mnp_request. Business justification: Interactions can be about MNP status inquiries, port issues, or port-related complaints. Adding mnp_request_id FK links interaction to the specific port request being discussed. No redundant columns t',
    `device_registration_id` BIGINT COMMENT 'Foreign key linking to customer.device_registration. Business justification: Interactions can be about device issues (activation help, troubleshooting, IMEI registration). Adding device_registration_id FK links interaction to the specific device being discussed. No redundant c',
    `employee_id` BIGINT COMMENT 'Identifier of the customer service agent or representative who handled the interaction. Null for self-service interactions.',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to assurance.fraud_case. Business justification: Fraud-related customer interactions (dispute calls, fraud reports) must link to fraud cases for investigation tracking, customer communication, and case resolution. Real business process: fraud case c',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the order if the interaction was related to order placement, modification, or inquiry. Null if not order-related.',
    `iptv_channel_id` BIGINT COMMENT 'Foreign key linking to content.iptv_channel. Business justification: Customer service interactions log channel-specific inquiries (availability in package, technical quality issues, content schedule questions, parental control setup) and complaints. Direct channel refe',
    `noc_incident_id` BIGINT COMMENT 'Foreign key linking to assurance.noc_incident. Business justification: Major network incidents trigger customer complaint calls. Linking interaction to incident enables customer impact analysis, proactive communication tracking, and regulatory reporting of customer-affec',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Interactions reference specific offerings being discussed or sold. Essential for sales tracking, conversion analytics, and next-best-action recommendations in contact centers.',
    `outage_record_id` BIGINT COMMENT 'Foreign key linking to assurance.outage_record. Business justification: Customer calls during outages must link to outage records for impact validation, customer communication tracking, and regulatory reporting of customer-reported outages. Real business process: outage c',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: Service interactions (installation appointments, repair tickets, coverage complaints) require premise-level tracking for field service dispatch, technician routing, and premise-specific service histor',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Interactions can be subscriber-specific (SIM swap call, roaming inquiry, line-specific service issue). Adding subscriber_id FK tracks line-level interactions. No redundant columns to remove.',
    `svc_instance_id` BIGINT COMMENT 'Reference to the specific service instance discussed or affected during the interaction (e.g., mobile subscription, broadband connection). Null if not service-specific.',
    `vod_asset_id` BIGINT COMMENT 'Foreign key linking to content.vod_asset. Business justification: Customer service interactions frequently reference specific VOD assets when handling playback failures, content quality complaints, billing disputes about rentals/purchases, or content availability qu',
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
    CONSTRAINT pk_customer_interaction PRIMARY KEY(`customer_interaction_id`)
) COMMENT 'Record of every customer interaction across all touchpoints — inbound/outbound calls, chat sessions, email exchanges, retail store visits, self-service portal sessions, and social media contacts. Stores interaction type, channel (voice/chat/email/store/app/social), direction (inbound/outbound), interaction date and time, duration, agent ID, queue name, topic category, sub-topic, resolution status, FCR flag (First Call Resolution), CSAT score captured at interaction, NPS survey triggered flag, and case reference if escalated. SSOT for customer interaction history across all channels.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`case` (
    `case_id` BIGINT COMMENT 'Unique identifier for the customer support case. Primary key for the case entity.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Audit findings identifying systematic issues (billing errors, service provisioning defects) require customer cases for remediation. Real-world: compliance audit finds roaming charge errors → finding i',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Cases frequently address billing issues (payment disputes, invoice queries, dunning appeals, payment arrangement requests). Direct billing_account link enables billing case routing to collections team',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Cases often relate to specific catalog items (billing disputes, service quality issues). Essential for problem resolution, product defect tracking, and quality assurance.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Direct link from case to its owning account simplifies queries and reporting; no existing reverse link, no cycle.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Cases often involve a specific contact person who reported the issue or is the authorized representative handling the case. Adding contact_id FK tracks who initiated/owns the case. No redundant column',
    `customer_interaction_id` BIGINT COMMENT 'Reference to the customer interaction record that initiated or is linked to this case.',
    `customer_mnp_request_id` BIGINT COMMENT 'Foreign key linking to customer.mnp_request. Business justification: Cases can be triggered by MNP port issues (delays, rejections, disputes). Adding mnp_request_id FK links case to the specific port request being disputed or tracked. No redundant columns to remove.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: Cases frequently involve specific device models (troubleshooting, warranty claims, defects). Essential for technical support, warranty processing, and device quality tracking.',
    `device_registration_id` BIGINT COMMENT 'Foreign key linking to customer.device_registration. Business justification: Cases often relate to device issues (IMEI block, warranty claim, insurance claim, device malfunction). Adding device_registration_id FK links case to the specific device being serviced. No redundant c',
    `employee_id` BIGINT COMMENT 'Reference to the customer service agent or representative currently assigned to work on this case.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the order that this case relates to, if the case concerns order fulfillment or delivery issues.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Technical support cases for CPE equipment issues need asset details (firmware version, model, warranty status) for troubleshooting, RMA decisions, and vendor warranty claims. Enables support agents to',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice that this case relates to, if the case concerns billing disputes or invoice inquiries.',
    `iptv_channel_id` BIGINT COMMENT 'Foreign key linking to content.iptv_channel. Business justification: Support cases for live TV services require direct channel reference for technical issues (signal quality, buffering, blackouts), content complaints (inappropriate content, rating disputes), availabili',
    `noc_incident_id` BIGINT COMMENT 'Foreign key linking to assurance.noc_incident. Business justification: Customer cases escalated to NOC incidents require linking for resolution coordination, customer notification, and SLA impact tracking. Real business process: major incident customer case management an',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Cases reference offerings under dispute or requiring support. Required for SLA compliance tracking, offering performance analysis, and regulatory complaint reporting.',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: Fiber service cases require ONT asset details for optical power diagnostics, firmware troubleshooting, and replacement workflows. Technical support needs ONT serial number, optical metrics, and firmwa',
    `outage_record_id` BIGINT COMMENT 'Foreign key linking to assurance.outage_record. Business justification: Cases opened during outages reference the outage for root cause, SLA exclusion justification, and customer compensation eligibility. Real business process: outage-related case management and SLA excep',
    `parent_case_id` BIGINT COMMENT 'Reference to a parent case if this case is a child or related case, enabling case hierarchy tracking.',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Cases often dispute or query specific price plans (billing errors, rate changes). Required for billing dispute resolution and revenue assurance investigations.',
    `problem_record_id` BIGINT COMMENT 'Foreign key linking to assurance.problem_record. Business justification: Customer cases linked to known problems enable workaround application and customer notification when permanent fixes are deployed. Real business process: known error customer case management and resol',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Customer cases track remediation of regulatory penalties (e.g., FCC complaint escalates to penalty, case manages customer resolution and refunds). Real-world: regulator imposes penalty for billing vio',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: Cases frequently involve premise-specific issues (installation failures, coverage gaps, equipment problems) requiring premise-level tracking for root cause analysis, field service dispatch, and premis',
    `spec_id` BIGINT COMMENT 'Reference to the product offering that this case relates to, if applicable.',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Cases can be subscriber-specific (SIM swap, device issue, service complaint). Adding subscriber_id FK allows direct linkage to the affected subscriber line. No redundant columns to remove as case does',
    `svc_instance_id` BIGINT COMMENT 'Reference to the specific service instance (subscription, line, connection) that this case relates to, if applicable.',
    `vod_asset_id` BIGINT COMMENT 'Foreign key linking to content.vod_asset. Business justification: Support cases track content-specific technical issues (DRM failures, encoding problems, metadata errors), billing disputes for specific rentals/purchases, and licensing/availability complaints. Direct',
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
    `offer_code` STRING COMMENT 'For retention cases, the code or identifier of the retention offer presented to the customer (discount, upgrade, loyalty reward, contract extension).',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`csat_response` (
    `csat_response_id` BIGINT COMMENT 'Unique identifier for the customer satisfaction survey response record.',
    `case_id` BIGINT COMMENT 'Foreign key linking to customer.case. Business justification: CSAT surveys are often triggered after case resolution to measure customer satisfaction with support experience. Adding case_id FK links survey response to the specific case that was resolved. No redu',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: CSAT surveys measure satisfaction with specific catalog items. Essential for product performance tracking, NPS analysis by product, and product portfolio optimization decisions.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who provided the feedback response.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: CSAT response may come from a specific contact person (survey respondent). Adding contact_id FK tracks who provided the feedback. No redundant columns to remove.',
    `customer_interaction_id` BIGINT COMMENT 'Identifier of the customer interaction (call, chat, ticket, order) that triggered this survey, enabling correlation with operational events.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: CSAT surveys often rate device satisfaction. Essential for device quality tracking, vendor performance management, and device portfolio rationalization decisions.',
    `fulfillment_order_id` BIGINT COMMENT 'Identifier of the order associated with this survey response, if the survey was triggered by an order event.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: CSAT surveys evaluate specific offerings. Required for offering performance measurement, promotional campaign effectiveness analysis, and customer experience management.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to content.ott_platform. Business justification: Satisfaction surveys specifically measure OTT platform experience including app usability, streaming quality, catalog satisfaction, login/authentication issues, and device compatibility. Direct platfo',
    `spec_id` BIGINT COMMENT 'Identifier of the product offering that was the subject of the customer feedback.',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: CSAT surveys can be subscriber-specific (rating service quality for a specific line, network performance for a SIM). Adding subscriber_id FK tracks line-level satisfaction metrics. No redundant column',
    `survey_wave_id` BIGINT COMMENT 'Identifier for the survey campaign wave or batch in which this response was collected. Enables cohort analysis.',
    `svc_instance_id` BIGINT COMMENT 'Identifier of the service instance (subscription, line, account) that was the subject of the customer feedback.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Post-service CSAT surveys tied to specific field technician performance for individual performance management, coaching, incentive compensation, and quality assurance. Critical for workforce performan',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to workforce.work_order. Business justification: CSAT surveys triggered by work order completion events link customer satisfaction scores to specific service delivery transactions for first-time fix rate analysis, SLA compliance correlation, and clo',
    `agent_rating` STRING COMMENT 'Customer rating of the service agent or representative who handled their interaction, if applicable.',
    `closed_loop_action_code` STRING COMMENT 'Code representing the closed-loop action taken in response to this feedback (e.g., callback scheduled, credit issued, escalation created).',
    `closed_loop_completion_date` DATE COMMENT 'Date when the closed-loop follow-up action was completed and the feedback loop was closed.',
    `contact_permission_flag` BOOLEAN COMMENT 'Indicates whether the customer granted permission to be contacted regarding their feedback (true/false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey response record was first created in the system.',
    `customer_segment` STRING COMMENT 'Customer segment classification at the time of survey response: consumer (B2C), small business, enterprise (B2B), wholesale, prepaid, or postpaid.. Valid values are `consumer|small_business|enterprise|wholesale|prepaid|postpaid`',
    `ease_of_resolution_rating` STRING COMMENT 'Customer rating indicating how easy it was to resolve their issue or complete their request. Core component of Customer Effort Score (CES).',
    `follow_up_action_flag` BOOLEAN COMMENT 'Indicates whether the response requires follow-up action from customer service or retention teams (true/false).',
    `follow_up_completed_flag` BOOLEAN COMMENT 'Indicates whether the required follow-up action has been completed (true/false).',
    `geographic_region` STRING COMMENT 'Geographic region or market where the customer is located at the time of survey response.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey response record was last updated or modified.',
    `nps_category` STRING COMMENT 'Classification of NPS response: promoter (9-10), passive (7-8), or detractor (0-6). Null for non-NPS surveys.. Valid values are `promoter|passive|detractor`',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the customer opted out of future surveys during or after this response (true/false).',
    `response_date` DATE COMMENT 'Date when the customer submitted the survey response.',
    `response_status` STRING COMMENT 'Status of the survey response: completed (fully answered), partial (incomplete), abandoned (started but not finished), or invalid (failed validation).. Valid values are `completed|partial|abandoned|invalid`',
    `response_time_seconds` STRING COMMENT 'Time in seconds taken by the customer to complete the survey from start to submission.',
    `response_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the customer completed and submitted the survey response.',
    `score_scale` STRING COMMENT 'The rating scale used for the survey (e.g., 0-10 for NPS, 1-5 for CSAT, 1-7 for CES).. Valid values are `0-10|1-5|1-7|1-10`',
    `score_value` STRING COMMENT 'Numeric score value provided by the customer in response to the survey question.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated sentiment analysis score derived from verbatim comment text, ranging from -1.00 (negative) to +1.00 (positive).',
    `survey_channel` STRING COMMENT 'Channel through which the survey was delivered and completed: SMS, email, Interactive Voice Response (IVR), mobile app, web portal, or post-call.. Valid values are `SMS|email|IVR|mobile_app|web_portal|post_call`',
    `survey_invitation_date` DATE COMMENT 'Date when the survey invitation was sent to the customer.',
    `survey_language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the survey was presented to the customer.. Valid values are `^[A-Z]{3}$`',
    `survey_type` STRING COMMENT 'Type of customer feedback survey administered: Net Promoter Score (NPS), Customer Satisfaction (CSAT), or Customer Effort Score (CES).. Valid values are `NPS|CSAT|CES`',
    `trigger_event` STRING COMMENT 'Business event that triggered the survey: post-interaction, post-installation, periodic check-in, post-repair, post-purchase, or post-billing.. Valid values are `post_interaction|post_installation|periodic|post_repair|post_purchase|post_billing`',
    `verbatim_comment` STRING COMMENT 'Free-text customer comment or feedback provided alongside the numeric score. May contain sensitive customer opinions.',
    CONSTRAINT pk_csat_response PRIMARY KEY(`csat_response_id`)
) COMMENT 'Unified voice-of-customer survey response record capturing all structured customer feedback measurements — Net Promoter Score (NPS), Customer Satisfaction (CSAT), and Customer Effort Score (CES). Stores survey type (NPS/CSAT/CES), score value, score scale, NPS category (promoter/passive/detractor) where applicable, survey channel (SMS/email/IVR/app/post-call), trigger event (post-interaction/post-installation/periodic/post-repair), response date, verbatim comment, agent rating, ease-of-resolution rating, follow-up action flag, survey wave identifier, and opt-out flag. SSOT for all customer feedback and loyalty measurement. Enables unified VoC analytics, closed-loop feedback management, FCR correlation, and segment-level loyalty benchmarking.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique identifier for the consent record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer who provided or withdrew consent. Links to the customer master record in Salesforce CRM.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Consent is often captured from a specific contact person (authorized representative, account holder). Adding contact_id FK tracks who provided the consent. No redundant columns to remove.',
    `dq_rule_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_rule. Business justification: Consent records are subject to DQ rules for GDPR/CCPA compliance (consent_status completeness, withdrawal_date accuracy, expiration tracking, audit trail integrity). Essential for privacy compliance r',
    `employee_id` BIGINT COMMENT 'The identifier of the customer service agent or sales representative who captured the consent (for retail store or call center channels). Used for audit trails and quality assurance. Links to workforce management systems.',
    `parent_consent_record_id` BIGINT COMMENT 'Reference to a previous consent record that this record supersedes or amends. Used to track consent history and version chains. Null for initial consent records.',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` (
    `customer_mnp_request_id` BIGINT COMMENT 'Unique identifier for the MNP request record. Primary key for tracking port-in and port-out transactions across the MNP lifecycle.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: MNP port-out requests require outstanding balance validation, early termination fee calculation, final bill generation, and payment settlement before port completion. Direct billing_account link criti',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: MNP authorization often requires a specific contact person (authorized representative who approves the port). Adding contact_id FK tracks who authorized the port. Removing subscriber_name as name will',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: MNP porting requires tracking the donor carrier for settlement reconciliation, dispute resolution, regulatory reporting (NRTRDE), and SLA compliance monitoring. Telecommunications regulators mandate a',
    `location_address_id` BIGINT COMMENT 'Foreign key linking to location.location_address. Business justification: Number portability requests require address verification for service territory determination, donor/recipient operator identification, and regulatory compliance. Location.location_address provides geo',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Port-in fulfillment workflow requires allocating and activating new SIM from inventory as part of number porting process. MNP operations team needs to reserve SIM, assign IMSI, and track SIM delivery/',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: MNP request is for a specific subscriber/line (MSISDN port). Adding subscriber_id FK links port request to the subscriber record. Removing msisdn, imsi, sim_card_number as these are authoritative in s',
    `actual_completion_hours` DECIMAL(18,2) COMMENT 'The actual elapsed time in hours from request submission to port completion. Used for SLA compliance monitoring and process performance analysis.',
    `actual_port_completion_timestamp` TIMESTAMP COMMENT 'The precise date and time when the number port was successfully completed and the MSISDN became active on the recipient operators network.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the MNP request was approved by the donor operator and authorized to proceed to execution.',
    `authorization_code` STRING COMMENT 'Security code or Personal Account Number (PAN) provided by the donor operator to authorize the port. Prevents unauthorized number porting and fraud.. Valid values are `^[A-Z0-9]{6,20}$`',
    `cancellation_reason` STRING COMMENT 'Explanation of why the MNP request was cancelled. May include subscriber change of mind, technical issues, or regulatory intervention.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the MNP request was cancelled by the subscriber, donor operator, or recipient operator.',
    `central_database_sync_flag` BOOLEAN COMMENT 'Indicates whether the MNP transaction has been synchronized with the central MNP database or number portability clearinghouse. Required for routing and billing accuracy.',
    `central_database_sync_timestamp` TIMESTAMP COMMENT 'The date and time when the MNP transaction was synchronized with the central MNP database.',
    `contract_end_date` DATE COMMENT 'The end date of the subscribers contract with the donor operator. Used to validate eligibility for porting and identify potential early termination fees.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this MNP request record was first created in the system. Audit field for data lineage and compliance.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the MNP request is subject to a dispute between operators, subscriber, or regulatory authority. Triggers escalation and resolution workflows.',
    `dispute_resolution_date` DATE COMMENT 'The date when a dispute related to the MNP request was resolved, allowing the porting process to continue or be terminated.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this MNP request record was last modified. Audit field for tracking changes and data quality.',
    `mnp_request_number` STRING COMMENT 'Externally visible business identifier for the MNP request. Used for customer communication, inter-operator coordination, and regulatory reporting.. Valid values are `^MNP[0-9]{10,15}$`',
    `nrtrde_notification_flag` BOOLEAN COMMENT 'Indicates whether NRTRDE notification was sent to roaming partners about the number port. Required for maintaining accurate roaming records and billing across international networks.',
    `number_range_holder` STRING COMMENT 'The original operator to which the number range was allocated by the regulatory authority. May differ from the current donor operator if the number was previously ported.. Valid values are `^[A-Z0-9]{3,10}$`',
    `port_type` STRING COMMENT 'Classification of the porting complexity. Simple (single number), complex (number with associated services), or bulk (multiple numbers in one request).. Valid values are `simple|complex|bulk`',
    `previous_port_count` STRING COMMENT 'The number of times this MSISDN has been ported between operators. Used for tracking porting history and identifying potential fraud patterns.',
    `recipient_operator_code` STRING COMMENT 'Unique code identifying the telecommunications operator to which the subscriber is porting (gaining carrier). Typically a regulatory-assigned carrier identification code.. Valid values are `^[A-Z0-9]{3,10}$`',
    `regulatory_reference_number` STRING COMMENT 'Unique reference number assigned by the regulatory authority or central MNP database for tracking and compliance purposes. Used for regulatory reporting to FCC, BEREC, or national telecom regulators.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating why the MNP request was rejected. Examples include account mismatch, outstanding balance, contract obligations, or technical validation failures.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `rejection_reason_description` STRING COMMENT 'Human-readable explanation of why the MNP request was rejected. Provides detailed context beyond the rejection reason code for customer service and dispute resolution.',
    `request_date` DATE COMMENT 'The date when the MNP request was initially submitted by the subscriber or receiving operator. This is the business event timestamp marking the start of the porting process.',
    `request_status` STRING COMMENT 'Current lifecycle status of the MNP request. Tracks progression from initial submission through validation, approval, execution, or rejection/cancellation. [ENUM-REF-CANDIDATE: submitted|validated|approved|rejected|completed|cancelled|failed — 7 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Indicates whether this is a port-in request (subscriber moving TO this operator) or port-out request (subscriber moving FROM this operator to another carrier).. Valid values are `port_in|port_out`',
    `routing_number` STRING COMMENT 'The network routing number assigned to the MSISDN after porting. Used by all operators to correctly route calls and messages to the recipient operators network.. Valid values are `^[0-9]{4,10}$`',
    `scheduled_port_date` DATE COMMENT 'The planned date for executing the number port. This is the target date agreed upon between operators for completing the MSISDN transfer.',
    `service_type` STRING COMMENT 'The billing model of the service being ported. Indicates whether the subscriber is on a prepaid, postpaid, or hybrid billing plan.. Valid values are `prepaid|postpaid|hybrid`',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the MNP request was completed within the regulatory or contractual SLA timeframe. Typically measured against mandated porting windows (e.g., 24-48 hours).',
    `sla_target_hours` STRING COMMENT 'The number of hours within which the MNP request must be completed to meet regulatory or contractual SLA requirements. Varies by jurisdiction (e.g., 24 hours in EU, 48 hours in some markets).',
    `subscriber_account_number` STRING COMMENT 'The account number of the subscriber at the donor operator. Used for validation and account matching during the porting process.',
    `validation_status` STRING COMMENT 'Status of the technical and business validation checks performed on the MNP request. Includes account verification, subscriber identity validation, and technical feasibility checks.. Valid values are `pending|passed|failed`',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when validation checks were completed for the MNP request.',
    CONSTRAINT pk_customer_mnp_request PRIMARY KEY(`customer_mnp_request_id`)
) COMMENT 'Mobile Number Portability request record tracking the end-to-end MNP port-in and port-out process for subscriber number transfers between operators. Stores MNP request type (port-in/port-out), MSISDN being ported, donor operator code, recipient operator code, MNP request date, scheduled port date, actual port completion date, MNP status (submitted/validated/approved/rejected/completed/cancelled), rejection reason code, NRTRDE notification flag, regulatory reference number, and SLA compliance flag. Required for GSMA/BEREC/FCC MNP regulatory compliance.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`loyalty_account` (
    `loyalty_account_id` BIGINT COMMENT 'Unique identifier for the loyalty program account. Primary key. _canonical_skip_reason: MASTER_AGREEMENT role inferred; this is the PK.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Loyalty points redemption for bill credits requires direct billing_account link for payment offset processing. Loyalty tier qualification based on billing spend (ARPU, MRR, payment history). Points-to',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Link loyalty_account directly to the owning customer_account for one‑to‑one relationship; avoids indirect joins via billing_account.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Loyalty points represent deferred revenue liability under IFRS 15 and ASC 606. Telecommunications operators must map loyalty accounts to specific GL accounts for balance sheet reporting, liability val',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to product.promo_offer. Business justification: Loyalty accounts redeem specific promo offers (bonus data, discounts). Core loyalty program mechanics for points redemption, offer eligibility validation, and campaign tracking.',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Loyalty tier_level and cltv_segment are primary segmentation criteria for targeted retention campaigns, personalized offers, and loyalty program analytics. Enables segment-based loyalty performance re',
    `account_number` STRING COMMENT 'Externally-visible unique account number for the loyalty membership, used for customer service and redemption transactions.. Valid values are `^[A-Z0-9]{8,16}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the loyalty account. Active accounts can earn and redeem points; suspended accounts are temporarily blocked; inactive accounts have no recent activity; closed accounts are permanently terminated; pending_activation accounts are awaiting first enrollment confirmation; frozen accounts are under investigation or dispute.. Valid values are `active|suspended|inactive|closed|pending_activation|frozen`',
    `activation_date` DATE COMMENT 'Date when the loyalty account was activated and became eligible for points earning. May differ from enrollment date if activation requires additional steps.',
    `auto_redemption_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic points redemption is enabled for this account (e.g., auto-apply points to bill payment). True if enabled, False if manual redemption only.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Predictive churn risk score for this loyalty account, typically ranging from 0.00 (low risk) to 1.00 (high risk). Used for proactive retention interventions. Calculated using AI/ML models on usage and engagement patterns.',
    `closure_date` DATE COMMENT 'Date when the loyalty account was permanently closed. Null if account is still open.',
    `closure_reason` STRING COMMENT 'Reason for account closure (e.g., customer request, account termination, fraud, inactivity, program discontinuation). Null if account is still open.',
    `cltv_segment` STRING COMMENT 'Customer Lifetime Value (CLTV) segmentation category for this loyalty account holder. Used for targeted retention strategies and personalized reward offerings. Calculated in Salesforce CRM analytics.. Valid values are `high|medium|low|vip|at_risk`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty account record was first created in the system. Used for audit trail and data lineage tracking.',
    `csat_score` DECIMAL(18,2) COMMENT 'Most recent Customer Satisfaction Score (CSAT) for loyalty program experience, typically on a scale of 1.0 to 5.0. Used for program quality monitoring. Sourced from Salesforce CRM.',
    `current_points_balance` DECIMAL(18,2) COMMENT 'Current available points balance that can be redeemed. Reflects all earned points minus redeemed and expired points. Updated in real-time via Comverse ONE prepaid balance management.',
    `earning_rate_multiplier` DECIMAL(18,2) COMMENT 'Current points earning rate multiplier for this account based on tier level and promotions (e.g., 1.0 for base rate, 1.5 for gold tier, 2.0 for platinum). Used for real-time rating in Comverse ONE.',
    `enrollment_channel` STRING COMMENT 'Channel through which the customer enrolled in the loyalty program (e.g., web, mobile app, retail store, call center, partner, auto-enroll). Used for channel effectiveness analysis.. Valid values are `web|mobile_app|retail_store|call_center|partner|auto_enroll`',
    `enrollment_date` DATE COMMENT 'Date when the customer enrolled in the loyalty program. Used for tenure analysis and anniversary rewards.',
    `last_activity_date` DATE COMMENT 'Date of the most recent points transaction (earn, redeem, or adjustment). Used for dormancy detection and churn risk scoring.',
    `last_earn_date` DATE COMMENT 'Date when points were last earned by the customer. Used for engagement tracking and reactivation campaigns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty account record was last modified. Used for audit trail, change tracking, and data synchronization across systems.',
    `last_redemption_date` DATE COMMENT 'Date when points were last redeemed by the customer. Used for redemption behavior analysis and reward catalog optimization.',
    `lifetime_points_earned` DECIMAL(18,2) COMMENT 'Total cumulative points earned since account inception, including redeemed and expired points. Used for tier qualification and Customer Lifetime Value (CLTV) segmentation.',
    `lifetime_points_expired` DECIMAL(18,2) COMMENT 'Total cumulative points that have expired due to inactivity or program rules since account inception. Used for churn risk analysis.',
    `lifetime_points_redeemed` DECIMAL(18,2) COMMENT 'Total cumulative points redeemed by the customer since account inception. Used for engagement analytics and Average Revenue Per User (ARPU) uplift measurement.',
    `loyalty_program_code` STRING COMMENT 'Business identifier for the loyalty program this account is enrolled in (e.g., REWARDS_PLUS, PLATINUM_CLUB, BUSINESS_ADVANTAGE). Aligns with product catalog in Netcracker OSS/BSS Suite.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `loyalty_program_name` STRING COMMENT 'Human-readable name of the loyalty program (e.g., Rewards Plus, Platinum Club, Business Advantage).',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive loyalty program marketing communications and promotional offers. True if opted in, False if opted out.',
    `next_expiry_date` DATE COMMENT 'Date when the next batch of points is scheduled to expire. Used for proactive customer engagement and churn prevention campaigns.',
    `next_expiry_points_amount` DECIMAL(18,2) COMMENT 'Number of points scheduled to expire on the next expiry date. Used for customer notification and retention campaigns.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) for this loyalty account holder, ranging from 0 to 10. Used for loyalty program satisfaction tracking and churn prediction. Sourced from Salesforce CRM Customer 360.',
    `partner_account_number` STRING COMMENT 'Customers account number in the partner loyalty program. Used for cross-program point transfers and reconciliation. Null if no partner linkage.',
    `partner_program_code` STRING COMMENT 'Code identifying any partner loyalty program this account is linked to for cross-program point transfers or earning (e.g., airline frequent flyer, hotel rewards). Null if no partner linkage.',
    `points_expiry_period_months` STRING COMMENT 'Number of months after which earned points expire if not redeemed. Program rule applied at account level. Null if points never expire.',
    `points_pending_credit` DECIMAL(18,2) COMMENT 'Points earned but not yet credited to the account balance, typically awaiting transaction settlement or validation period completion.',
    `points_to_next_tier` DECIMAL(18,2) COMMENT 'Number of additional lifetime points required to qualify for the next tier level. Used for customer engagement and upsell campaigns.',
    `redemption_rate` DECIMAL(18,2) COMMENT 'Monetary value per point when redeeming (e.g., 0.01 means 100 points = $1). Used for redemption transaction processing and reward valuation.',
    `referral_bonus_points_earned` DECIMAL(18,2) COMMENT 'Total points earned through successful customer referrals. Used for referral program effectiveness measurement and Net Promoter Score (NPS) correlation.',
    `referral_code` STRING COMMENT 'Unique referral code assigned to this loyalty account for customer acquisition campaigns. Used when this customer refers new subscribers to earn bonus points.. Valid values are `^[A-Z0-9]{6,12}$`',
    `source_system` STRING COMMENT 'Name of the source system that created or manages this loyalty account record (e.g., Salesforce CRM, Comverse ONE, Netcracker). Used for data lineage and system-of-record identification.',
    `suspension_date` DATE COMMENT 'Date when the account was suspended. Null if account has never been suspended or is currently active.',
    `suspension_reason` STRING COMMENT 'Reason for account suspension (e.g., fraud investigation, customer request, policy violation, billing dispute). Null if account is not suspended.',
    `tier_level` STRING COMMENT 'Current tier or status level within the loyalty program (e.g., bronze, silver, gold, platinum, diamond, VIP). Tier determines benefits, earning rates, and service differentiation. Managed via Salesforce CRM segmentation.. Valid values are `bronze|silver|gold|platinum|diamond|vip`',
    `tier_points_threshold` DECIMAL(18,2) COMMENT 'Minimum lifetime points required to maintain current tier level. Used for tier retention and upgrade eligibility calculations.',
    `tier_qualification_date` DATE COMMENT 'Date when the customer qualified for their current tier level. Used for tier anniversary benefits and retention analysis.',
    `tier_review_date` DATE COMMENT 'Next scheduled date for tier status review and potential upgrade or downgrade based on activity and points accumulation.',
    CONSTRAINT pk_loyalty_account PRIMARY KEY(`loyalty_account_id`)
) COMMENT 'Customer loyalty program account and full transaction ledger tracking points accumulation, redemption, tier status, and complete points history. Stores loyalty program code, loyalty tier (bronze/silver/gold/platinum), current points balance, lifetime points earned, points expiry date, tier qualification date, tier review date, enrolled date, program status, and all transaction records: transaction type (earn/redeem/expire/adjust/transfer), points amount, transaction date, trigger event (bill payment/top-up/referral/promotion/redemption), reference transaction ID, redemption reward type (discount/device/accessory/content), expiry date of earned points, and running balance after transaction. SSOT for loyalty program membership and the complete points ledger. Enables loyalty-driven retention, ARPU uplift through rewards, tier-based service differentiation, and full points reconciliation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`device_registration` (
    `device_registration_id` BIGINT COMMENT 'Unique identifier for the device registration record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the billing account under which this device is registered.',
    `dealer_id` BIGINT COMMENT 'Reference to the billing installment plan if the device is financed. Null if device is not financed.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: Device registrations must reference the specific model being registered. Mandatory for IMEI/TAC validation, CEIR blocking, network access control, and warranty management.',
    `device_offering_id` BIGINT COMMENT 'Foreign key linking to product.device_offering. Business justification: Registrations tied to device purchase/financing offerings. Essential for installment plan tracking, subsidy management, trade-in eligibility, and inventory reconciliation.',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Device attributes (BYOD vs financed, 5G-capable, device_type) are common segmentation dimensions for product adoption analytics, upsell targeting (5G plan upgrades), and device financing campaign elig',
    `employee_id` BIGINT COMMENT 'Identifier of the customer service representative, dealer, or system user who performed the device registration. Null for self-service registrations.',
    `esim_profile_id` BIGINT COMMENT 'Unique identifier for the eSIM profile provisioned on the device, if applicable. Used for remote SIM provisioning and management.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: Device installations (CPE, ONT, fixed wireless equipment) occur at specific premises requiring premise-level tracking for inventory management, field service dispatch, and premise serviceability valid',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Links customer-registered device (IMEI/serial) to inventory asset record for warranty management, insurance claims, and device replacement eligibility. Support agents need this to validate warranty st',
    `replacement_device_registration_id` BIGINT COMMENT 'Reference to the new device registration record if this device was replaced. Null if no replacement occurred.',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Enables tracking SIM-device pairing for activation workflows, eSIM provisioning, and SIM swap validation. Real business process: when activating new device or processing SIM swap, system must link dev',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who owns or is associated with this registered device.',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`kyc_verification` (
    `kyc_verification_id` BIGINT COMMENT 'Unique identifier for the KYC verification record. Primary key for the KYC verification entity.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: AML/KYC audits identify deficient verification records requiring remediation. Real-world: regulatory audit finds incomplete identity verification for high-risk accounts → audit finding references spec',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account undergoing KYC verification. Links to the customer master record in Salesforce CRM.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: KYC verification is performed on a specific contact/individual (identity document verification, biometric check). Adding contact_id FK tracks who was verified. No redundant columns to remove.',
    `dq_rule_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_rule. Business justification: KYC verification records must meet strict data quality rules for regulatory compliance (verification_status completeness, document expiry monitoring, biometric match score thresholds). Required for GD',
    `employee_id` BIGINT COMMENT 'User ID or system identifier of the compliance officer or automated process that completed the verification. Used for audit trail and accountability.',
    `previous_verification_kyc_verification_id` BIGINT COMMENT 'Reference to the previous KYC verification record for this customer, enabling verification history tracking and periodic re-verification workflows. Null for first-time verification.',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: KYC can be performed at subscriber level (prepaid SIM activation, identity verification for new line, regulatory compliance per SIM). Adding subscriber_id FK tracks line-level KYC verification. No red',
    `address_verification_status` STRING COMMENT 'Status of address proof verification: fully verified against authoritative source, unverified, partially verified with some discrepancies, or not applicable for this verification type.. Valid values are `verified|unverified|partial|not_applicable`',
    `biometric_match_score` DECIMAL(18,2) COMMENT 'Numerical score indicating the confidence level of biometric match, typically ranging from 0.00 to 100.00. Null if biometric verification was not performed.',
    `biometric_type` STRING COMMENT 'Type of biometric authentication used during verification: facial recognition, fingerprint scan, iris scan, voice recognition, or none if biometric verification was not performed.. Valid values are `facial_recognition|fingerprint|iris_scan|voice_recognition|none`',
    `consent_obtained` BOOLEAN COMMENT 'Boolean flag indicating whether explicit customer consent was obtained for identity verification and data processing. True if consent obtained, False otherwise. Required for GDPR compliance.',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when customer consent was obtained for KYC verification and data processing, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Null if consent not obtained or not applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this KYC verification record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trail and data lineage.',
    `credit_check_performed` BOOLEAN COMMENT 'Boolean flag indicating whether a credit bureau check was performed as part of the KYC verification process. True if credit check was conducted, False otherwise.',
    `credit_score` STRING COMMENT 'Credit score obtained from credit bureau during verification process. Null if credit check was not performed. Used for risk assessment and service eligibility determination.',
    `data_retention_expiry_date` DATE COMMENT 'Date when this KYC verification record must be purged or archived per data retention policy and regulatory requirements, in yyyy-MM-dd format.',
    `document_expiry_date` DATE COMMENT 'Date when the identity document expires and is no longer valid for verification purposes, in yyyy-MM-dd format. Null for documents without expiration.',
    `document_issue_date` DATE COMMENT 'Date when the identity document was originally issued by the authority, in yyyy-MM-dd format.',
    `document_number` STRING COMMENT 'Masked or tokenized document identification number from the submitted identity document. Stored in encrypted or hashed format to protect sensitive personal information.',
    `document_type` STRING COMMENT 'Type of identity or proof document submitted for verification: passport, national identity card, driving licence, utility bill for address proof, bank statement, or tax document.. Valid values are `passport|national_id|driving_licence|utility_bill|bank_statement|tax_document`',
    `fraud_indicators` STRING COMMENT 'Comma-separated list of fraud indicators or red flags identified during verification process (e.g., document tampering, synthetic identity, address mismatch, velocity abuse).',
    `issuing_authority` STRING COMMENT 'Name of the government agency or authority that issued the identity document (e.g., Department of State, Home Office, Ministry of Interior).',
    `issuing_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country that issued the identity document (e.g., USA, GBR, DEU, FRA).. Valid values are `^[A-Z]{3}$`',
    `jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the regulatory jurisdiction governing this KYC verification (e.g., USA, GBR, DEU, FRA).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this KYC verification record was last updated or modified, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trail and change tracking.',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework or compliance standard under which the KYC verification was performed (e.g., AML/CTF, KYC, eIDAS, GDPR, USA PATRIOT Act, local telecommunications regulations).',
    `retry_count` STRING COMMENT 'Number of verification attempts made before reaching final status. Tracks customer or system retry behavior for quality and fraud analysis.',
    `risk_rating` STRING COMMENT 'Risk classification assigned to the customer based on KYC verification results and fraud indicators: low risk, medium risk, high risk requiring enhanced due diligence, or critical risk requiring immediate review.. Valid values are `low|medium|high|critical`',
    `verification_channel` STRING COMMENT 'Channel through which the KYC verification was initiated and completed: web portal, mobile application, retail store, call center, or agent portal.. Valid values are `web|mobile_app|retail_store|call_center|agent_portal`',
    `verification_date` DATE COMMENT 'Date when the KYC verification check was performed or completed, in yyyy-MM-dd format.',
    `verification_duration_seconds` STRING COMMENT 'Total time in seconds taken to complete the verification process from initiation to final status. Used for process efficiency analysis and SLA monitoring.',
    `verification_expiry_date` DATE COMMENT 'Date when the KYC verification expires and requires re-verification per regulatory requirements or internal policy, in yyyy-MM-dd format.',
    `verification_method` STRING COMMENT 'Method used to perform the verification: fully automated using AI/ML algorithms, manual review by compliance officer, or hybrid approach combining automated screening with manual validation.. Valid values are `automated|manual|hybrid`',
    `verification_notes` STRING COMMENT 'Free-text notes and comments from compliance officers or automated system regarding verification process, findings, or special circumstances.',
    `verification_provider` STRING COMMENT 'Name of the third-party verification service provider or internal system that performed the KYC check (e.g., Jumio, Onfido, Experian, internal compliance system).',
    `verification_provider_reference` STRING COMMENT 'External reference or transaction ID assigned by the verification provider for their internal tracking and support purposes.',
    `verification_reason` STRING COMMENT 'Business reason triggering the KYC verification: new customer onboarding, periodic re-verification, high-value transaction threshold, regulatory mandate, fraud alert, or customer-initiated update.. Valid values are `new_customer|periodic_review|high_value_transaction|regulatory_requirement|fraud_alert|customer_request`',
    `verification_reference_number` STRING COMMENT 'External reference number assigned by the verification provider or internal system for tracking and audit purposes.',
    `verification_score` DECIMAL(18,2) COMMENT 'Numerical confidence score assigned by the verification system indicating the reliability of the identity verification, typically ranging from 0.00 to 100.00.',
    `verification_status` STRING COMMENT 'Current status of the KYC verification process: pending initiation, in progress, successfully passed, failed validation, expired and requires renewal, or cancelled by customer or system.. Valid values are `pending|in_progress|passed|failed|expired|cancelled`',
    `verification_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the KYC verification was completed, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trail and compliance reporting.',
    `verification_type` STRING COMMENT 'Type of KYC verification performed: identity document scan, biometric authentication, credit bureau check, address proof validation, database cross-reference, or video-based identity verification.. Valid values are `identity_document|biometric|credit_check|address_proof|database_check|video_verification`',
    `watchlist_match_details` STRING COMMENT 'Details of any matches found during watchlist screening, including list name and match confidence. Null if no matches found or screening not performed.',
    `watchlist_screening_status` STRING COMMENT 'Result of screening against sanctions lists, PEP (Politically Exposed Persons) databases, and fraud watchlists: clear with no matches, match found requiring investigation, pending manual review, or not performed.. Valid values are `clear|match_found|pending_review|not_performed`',
    CONSTRAINT pk_kyc_verification PRIMARY KEY(`kyc_verification_id`)
) COMMENT 'Know Your Customer identity verification record capturing the results of identity checks performed during customer onboarding and periodic re-verification. Stores verification type (ID document/biometric/credit check/address proof), verification status (pending/passed/failed/expired), document type (passport/national ID/driving licence/utility bill), document number (masked), issuing country, verification date, expiry date, verification provider, verification score, risk rating (low/medium/high), and regulatory framework (AML/KYC/eIDAS). Required for regulatory compliance and fraud prevention during onboarding.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` (
    `customer_segment_membership_id` BIGINT COMMENT 'Primary key for customer_segment_membership',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to the segment definition that this subscriber belongs to',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to the subscriber who is a member of this segment',
    `assignment_date` TIMESTAMP COMMENT 'Date and time when this subscriber was first assigned to this segment. Marks the start of membership history.',
    `assignment_method` STRING COMMENT 'Method by which this subscriber was assigned to this segment. Rule-based indicates SQL predicate evaluation. ML model indicates predictive model scoring. Manual override indicates analyst intervention. Campaign trigger indicates event-driven assignment.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence score (0.00-1.00) indicating the certainty of this segment assignment. For rule-based segments, typically 1.00. For ML-based segments, represents model confidence. Used to filter low-confidence assignments.',
    `effective_end_date` DATE COMMENT 'Date when this segment membership expires or is no longer valid. Null indicates ongoing membership. Used for time-bound segments (e.g., promotional cohorts, seasonal segments).',
    `effective_start_date` DATE COMMENT 'Date when this segment membership becomes or became effective for business use (campaigns, personalization, reporting). May differ from assignment_date if membership is pre-calculated.',
    `is_primary_segment` BOOLEAN COMMENT 'Indicates whether this is the primary or dominant segment for this subscriber. Used when systems require a single segment classification. Typically the highest-priority active segment.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Date and time when this segment membership was last recalculated or validated. Used to track data freshness and identify stale memberships.',
    `membership_status` STRING COMMENT 'Current lifecycle status of this segment membership. Active indicates the subscriber currently qualifies for this segment. Inactive indicates they no longer qualify. Pending indicates membership is calculated but not yet activated. Expired indicates temporal validity has ended.',
    `override_by_user` STRING COMMENT 'Username or identifier of the analyst or business user who performed the manual override. Null for automated assignments.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this segment membership was manually overridden by an analyst or business user, bypassing automated assignment logic. Used for exception handling and audit trails.',
    `override_reason` STRING COMMENT 'Free-text explanation for why this segment membership was manually overridden. Required when override_flag is true. Used for governance and audit.',
    `priority_rank` STRING COMMENT 'Priority ranking of this segment membership relative to other segments this subscriber belongs to. Lower numbers indicate higher priority. Used when business rules require selecting a primary segment from multiple memberships.',
    `propensity_score` DECIMAL(18,2) COMMENT 'Propensity or likelihood score (0.00-1.00) indicating the strength of this subscribers fit to this segment. For behavioral segments (e.g., churn risk), represents predicted probability. Used for prioritization and targeting.',
    `segment_membership_code` BIGINT COMMENT 'Unique identifier for this segment membership record. Primary key.',
    `source_system` STRING COMMENT 'Name of the system or platform that calculated and assigned this segment membership (e.g., Customer Data Platform, Marketing Automation, Analytics Engine).',
    CONSTRAINT pk_customer_segment_membership PRIMARY KEY(`customer_segment_membership_id`)
) COMMENT 'This association product represents the assignment of subscribers to analytical segments. It captures the dynamic, multi-dimensional segmentation of subscribers where each subscriber can belong to multiple segments simultaneously (e.g., High-Value Postpaid AND 5G Early Adopter AND Churn Risk), and each segment contains many subscribers. Each record links one subscriber to one segment with temporal validity, confidence scoring, priority ranking, and override logic that exist only in the context of this relationship. This is the operational SSOT for segment membership used by marketing automation, personalization engines, and campaign management systems.. Existence Justification: In telecommunications analytics operations, subscribers are simultaneously assigned to multiple segments (a high-value postpaid subscriber can also be a 5G early adopter AND a churn risk), and each segment contains thousands to millions of subscribers. The business actively manages segment membership through automated refresh cycles, manual overrides, and campaign-triggered assignments. Segment membership is a recognized operational entity with its own lifecycle, confidence scoring, priority ranking, and temporal validity.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`promo_redemption` (
    `promo_redemption_id` BIGINT COMMENT 'Unique system identifier for this promotional offer redemption record. Primary key.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice where this promotional discount was first applied. Supports revenue impact tracking.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to the customer account that redeemed the promotional offer',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to the promotional offer that was redeemed',
    `discount_applied_amount` DECIMAL(18,2) COMMENT 'Actual monetary discount amount applied to this customer account for this promotional offer redemption. Explicitly identified in detection phase relationship data.',
    `effective_end_date` DATE COMMENT 'Date when the promotional discount expires for this specific customer account redemption. Explicitly identified in detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'Date when the promotional discount became effective for this specific customer account redemption. Explicitly identified in detection phase relationship data.',
    `promo_status` STRING COMMENT 'Current status of this specific redemption instance. Explicitly identified in detection phase relationship data.',
    `redeemed_by_user` STRING COMMENT 'Username or identifier of the customer service representative or system user who processed the redemption, if applicable.',
    `redemption_channel` STRING COMMENT 'Sales or service channel through which the promotional offer was redeemed. Explicitly identified in detection phase relationship data.',
    `redemption_code` STRING COMMENT 'Specific code entered or used by the customer to redeem this promotional offer. May differ from the generic promo_code if personalized codes are used. Explicitly identified in detection phase relationship data.',
    `redemption_date` DATE COMMENT 'Date when the customer account redeemed this promotional offer. Explicitly identified in detection phase relationship data.',
    `redemption_timestamp` TIMESTAMP COMMENT 'Precise date and time when the redemption was recorded in the system.',
    CONSTRAINT pk_promo_redemption PRIMARY KEY(`promo_redemption_id`)
) COMMENT 'This association product represents the redemption event between customer_account and promo_offer. It captures when and how a customer account redeemed a specific promotional offer, including the discount applied, redemption channel, and effective period. Each record links one customer_account to one promo_offer with attributes that exist only in the context of this redemption relationship.. Existence Justification: In telecommunications operations, customer accounts redeem multiple promotional offers over their lifecycle (welcome bonus at acquisition, loyalty discount after 12 months, seasonal data promotion, retention offer when considering churn), and each promotional offer is redeemed by thousands of customer accounts. The redemption relationship is an operational business entity that customer service teams actively create when customers apply promo codes, billing systems reference to calculate discounts, and marketing teams analyze for campaign ROI and revenue impact.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` (
    `account_dealer_transaction_id` BIGINT COMMENT 'Primary key uniquely identifying each transaction event between a customer account and a dealer',
    `account_customer_account_id` BIGINT COMMENT 'Foreign key linking to the customer account involved in this dealer transaction',
    `customer_account_id` BIGINT COMMENT 'Foreign key to customer_account - the account involved in this transaction',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to the dealer who performed or was credited for this transaction',
    `activation_count` STRING COMMENT 'Number of new line activations performed in this transaction - typically 1 for single-line activations, can be multiple for family plans or business account bulk activations',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission amount earned by the dealer for this specific transaction, calculated based on transaction type, product sold, and dealer tier/commission structure',
    `created_at` TIMESTAMP COMMENT 'System timestamp when this association record was created',
    `device_sale_count` STRING COMMENT 'Number of devices sold to the customer account in this transaction - used for dealer performance metrics and inventory tracking',
    `relationship_start_date` DATE COMMENT 'Date when the dealer-account relationship began - typically the date of first activation transaction, used to identify the originating dealer for lifetime value attribution',
    `relationship_status` STRING COMMENT 'Current status of the dealer-account relationship - ACTIVE if dealer is still the primary servicing dealer, INACTIVE if account has moved to another dealer or channel, TRANSFERRED if account was explicitly reassigned',
    `transaction_date` DATE COMMENT 'Date when the dealer transaction occurred - activation, upgrade, plan change, or device sale event date',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the transaction was recorded in the system, used for audit trail and commission calculation cutoff periods',
    `transaction_type` STRING COMMENT 'Classification of the dealer transaction - ACTIVATION for new account setup, UPGRADE for device/plan upgrades, PLAN_CHANGE for service modifications, DEVICE_SALE for equipment purchases, SERVICE_MODIFICATION for add-ons, REACTIVATION for restoring suspended accounts, PORT_IN for number transfers',
    `updated_at` TIMESTAMP COMMENT 'System timestamp when this association record was last modified',
    CONSTRAINT pk_account_dealer_transaction PRIMARY KEY(`account_dealer_transaction_id`)
) COMMENT 'This association product represents the transactional relationship between customer accounts and dealers in the indirect sales channel. It captures every interaction where a dealer performs a transaction on behalf of or involving a customer account — including initial activations, device sales, plan changes, upgrades, and service modifications. Each record links one customer account to one dealer for a specific transaction event, with attributes that track the transaction type, timing, commission attribution, and relationship lifecycle. This is the SSOT for dealer performance analytics, commission calculation, and customer acquisition/service attribution in the indirect channel.. Existence Justification: In telecommunications indirect channel operations, customer accounts interact with multiple dealers throughout their lifecycle — initial activation at one dealer, device upgrades at another, plan changes at a third. Each dealer serves thousands of customer accounts. The business actively manages and tracks each dealer-account transaction for commission attribution, dealer performance measurement, customer acquisition source tracking, and regulatory compliance. This is operational M:N with transaction-level relationship data.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`customer_subscription` (
    `customer_subscription_id` BIGINT COMMENT 'Primary key for customer_subscription',
    `addon_id` BIGINT COMMENT 'Foreign key linking to the add-on product that was purchased',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to the subscriber who purchased the add-on',
    `billing_subscription_id` BIGINT COMMENT 'Unique identifier for this subscriber-addon subscription record. Primary key.',
    `activation_date` TIMESTAMP COMMENT 'Date and time when the add-on was activated for this subscriber. Marks the start of service delivery and billing.',
    `addon_status` STRING COMMENT 'Current lifecycle status of this specific subscriber-addon subscription. Active: in use; Suspended: temporarily disabled; Expired: validity period ended; Cancelled: terminated by user or system; Pending: awaiting activation.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this specific subscription will automatically renew at expiry. Subscriber may override the default add-on auto-renewal setting.',
    `cancellation_date` TIMESTAMP COMMENT 'Date and time when the subscriber cancelled this add-on subscription. Null for active subscriptions.',
    `cancellation_reason` STRING COMMENT 'Reason code or description for why the subscription was cancelled. Used for churn analysis and retention strategies.',
    `channel` STRING COMMENT 'Sales or service channel through which the subscriber purchased or activated this add-on.',
    `expiry_date` TIMESTAMP COMMENT 'Date and time when the add-on subscription expires or is scheduled to terminate. Null for perpetual add-ons or those without defined end dates.',
    `last_renewal_date` TIMESTAMP COMMENT 'Date and time of the most recent automatic or manual renewal of this subscription. Null if never renewed.',
    `promotion_code` STRING COMMENT 'Promotional campaign code applied to this subscription, if any. Used to track promotional uptake and apply special pricing or trial periods.',
    `proration_amount` DECIMAL(18,2) COMMENT 'Prorated charge amount calculated when the add-on is activated or deactivated mid-billing cycle. Null if no proration applies.',
    `quantity` STRING COMMENT 'Number of instances of this add-on subscribed by the subscriber. Relevant for add-ons that allow multiple quantities (e.g., multiple data top-ups, multiple premium channels).',
    `recurring_charge` DECIMAL(18,2) COMMENT 'The actual recurring charge amount applied to this subscriber for this add-on. May differ from the standard add-on price due to promotions, discounts, or subscriber-specific pricing.',
    `trial_end_date` DATE COMMENT 'Date when the free trial period for this add-on ends and billing begins. Null if no trial period applies.',
    CONSTRAINT pk_customer_subscription PRIMARY KEY(`customer_subscription_id`)
) COMMENT 'This association product represents the subscription contract between a subscriber and an add-on product. It captures the activation, lifecycle, and billing details specific to each subscribers purchase of an add-on. Each record links one subscriber to one add-on with attributes that exist only in the context of this subscription relationship, including activation dates, expiry, status, pricing, and renewal behavior.. Existence Justification: In telecommunications operations, subscribers purchase and activate multiple add-ons simultaneously (international roaming, data top-ups, premium content, cloud storage), and each add-on product is purchased by thousands of subscribers. The business actively manages these subscriptions as operational entities with lifecycle states, billing cycles, activation/expiry dates, and subscriber-specific pricing. Customer care, billing, and provisioning systems create, update, and deactivate these subscription records as part of daily operations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` (
    `customer_roaming_session_id` BIGINT COMMENT 'Primary key for customer_roaming_session',
    `roaming_agreement_id` BIGINT COMMENT 'Foreign key linking to the roaming agreement under which this session occurred',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to the subscriber who initiated the roaming session',
    `data_usage_mb` DECIMAL(18,2) COMMENT 'Total data volume consumed during this roaming session in megabytes. Used for wholesale billing calculation based on agreement data_mb_rate.',
    `fraud_alert_triggered` BOOLEAN COMMENT 'Indicates whether this session triggered a fraud alert based on agreement fraud_threshold_amount or NRTRDE rules.',
    `location_area_code` STRING COMMENT 'Geographic location identifier within the visited network where the subscriber roamed. Used for roaming analytics and steering policy evaluation.',
    `roaming_charges` DECIMAL(18,2) COMMENT 'Total wholesale charges for this roaming session calculated based on usage and agreement rates. Used for settlement and fraud threshold monitoring.',
    `roaming_session_id` BIGINT COMMENT 'Primary key. Unique identifier for each roaming session record.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscriber detached from the visited partner network or session was terminated. Null for active sessions.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscriber first attached to the visited partner network. Used for session duration calculation and TAP file reconciliation.',
    `sms_count` STRING COMMENT 'Total number of SMS messages sent during this roaming session. Used for wholesale billing calculation based on agreement sms_rate.',
    `tap_file_reference` STRING COMMENT 'Reference to the TAP file batch in which this session was included for settlement. Used for reconciliation and dispute resolution.',
    `technology_used` STRING COMMENT 'Network technology standard used during this roaming session. Must match one of the technology_standards covered by the agreement.',
    `visited_network_code` STRING COMMENT 'Mobile Country Code and Mobile Network Code of the visited partner network where the subscriber roamed. Used for network identification in TAP files.',
    `voice_minutes` DECIMAL(18,2) COMMENT 'Total voice call duration during this roaming session in minutes. Used for wholesale billing calculation based on agreement voice_mou_rate.',
    CONSTRAINT pk_customer_roaming_session PRIMARY KEY(`customer_roaming_session_id`)
) COMMENT 'This association product represents the roaming event between a subscriber and a partner roaming agreement. It captures individual roaming sessions when a subscriber connects to a partner network covered by a specific roaming agreement. Each record links one subscriber to one partner roaming agreement with session-level attributes including usage metrics, timestamps, network identifiers, and charges that exist only in the context of this roaming event. This is the operational record used for TAP file generation, wholesale settlement, fraud detection, and roaming analytics.. Existence Justification: In telecommunications operations, subscribers roam on multiple partner networks as they travel internationally or domestically, and each roaming agreement covers millions of subscribers. The business actively manages roaming sessions as operational events that generate TAP files for wholesale settlement, trigger fraud alerts via NRTRDE, and drive roaming steering policies. Each session is a distinct business record with usage metrics, timestamps, network identifiers, and charges that belong to neither the subscriber nor the agreement alone.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` (
    `customer_account_coverage_id` BIGINT COMMENT 'Primary key for customer_account_coverage',
    `corporate_hierarchy_id` BIGINT COMMENT 'Foreign key linking to the corporate hierarchy node being covered by this assignment',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to manage this corporate hierarchy node',
    `account_coverage_code` BIGINT COMMENT 'Unique identifier for this account coverage assignment record. Primary key.',
    `assignment_status` STRING COMMENT 'Current operational status of this coverage assignment. Active indicates the employee is currently responsible for this account.',
    `commission_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of commission this employee receives for sales to this corporate hierarchy node when multiple employees share coverage. Sum across all employees for a node may equal 100% or vary based on compensation plan.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this coverage assignment record was created.',
    `effective_end_date` DATE COMMENT 'Date when this coverage assignment ended. Null for currently active assignments. Used for territory transition tracking and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this employee began managing this corporate hierarchy node in this role. Used for historical tracking and compensation calculation.',
    `primary_coverage_flag` BOOLEAN COMMENT 'Indicates whether this employee is the primary point of contact for this corporate hierarchy node. Used when multiple employees have coverage roles.',
    `quota_allocation` DECIMAL(18,2) COMMENT 'Revenue or unit quota allocated to this employee for this specific corporate hierarchy node. Used for performance measurement and compensation calculation.',
    `sales_role` STRING COMMENT 'The specific sales or account management role the employee performs for this corporate hierarchy node. Determines responsibilities and authority level.',
    `territory_assignment` STRING COMMENT 'Geographic or vertical territory designation for this coverage assignment. Used for territory planning and conflict resolution.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this coverage assignment record was last modified.',
    CONSTRAINT pk_customer_account_coverage PRIMARY KEY(`customer_account_coverage_id`)
) COMMENT 'This association product represents the assignment relationship between corporate hierarchy nodes and employees who manage them in sales or account management roles. It captures territory assignments, quota allocations, and commission structures. Each record links one corporate hierarchy node to one employee with role-specific attributes that exist only in the context of this coverage assignment.. Existence Justification: In telecommunications B2B sales, corporate hierarchy nodes (enterprise accounts, subsidiaries, divisions) are routinely managed by multiple employees in different sales roles - a Strategic Account Manager owns the relationship, a Solutions Engineer provides technical support, and an Inside Sales Rep handles order processing. Simultaneously, each employee manages a portfolio of multiple corporate entities across their assigned territory. The business actively manages these coverage assignments with territory planning, quota allocation, and commission splits tracked per assignment.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`redemption` (
    `redemption_id` BIGINT COMMENT 'Unique identifier for this promotion redemption event. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee ID of the sales representative or dealer who applied this promotion to the subscribers account. Null for self-service redemptions.',
    `promotion_id` BIGINT COMMENT 'Foreign key to sales.promotion. Identifies which promotion was redeemed.',
    `subscriber_id` BIGINT COMMENT 'Foreign key to customer.subscriber. Identifies which subscriber redeemed the promotion.',
    `benefit_end_date` DATE COMMENT 'Date when the promotional benefit expires for this subscriber. For time-limited offers (e.g., 50% off for 6 months), marks the end of the discounted period. Null for one-time discounts.',
    `benefit_start_date` DATE COMMENT 'Date when the promotional benefit begins for this subscriber. For recurring discounts (e.g., 3 months free), marks the start of the benefit period.',
    `channel` STRING COMMENT 'Sales channel through which the promotion was redeemed (e.g., web, mobile_app, retail_store, call_center, dealer, partner). Indicates where the redemption transaction occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was first created in the system. Used for audit trail.',
    `discount_amount_applied` DECIMAL(18,2) COMMENT 'Actual monetary discount amount applied to this specific subscribers transaction as a result of this promotion redemption. May differ from promotion.discount_value due to stacking rules, minimum purchase requirements, or percentage calculations.',
    `promotion_status` STRING COMMENT 'Current status of this specific redemption instance: pending (awaiting approval), approved (authorized but not yet applied), applied (discount successfully applied), rejected (redemption denied), expired (benefit period ended), reversed (discount clawed back).',
    `quote_reference` STRING COMMENT 'Reference to the sales quote or order where this promotion was applied. Links the redemption to the specific sales transaction.',
    `redemption_date` TIMESTAMP COMMENT 'Timestamp when the promotion was redeemed by the subscriber. Marks the moment the promotional offer was applied to the subscribers account or order.',
    `validation_status` STRING COMMENT 'Indicates whether this redemption passed eligibility validation checks (customer segment, product category, geographic eligibility, stacking rules). Used for audit and compliance.',
    CONSTRAINT pk_redemption PRIMARY KEY(`redemption_id`)
) COMMENT 'This association product represents the Event of a subscriber redeeming a sales promotion. It captures the specific instance when a promotion offer is applied to a subscribers account, including the discount amount realized, the channel through which redemption occurred, and the benefit period. Each record links one subscriber to one promotion with attributes that exist only in the context of this redemption transaction.. Existence Justification: In telecommunications sales operations, subscribers redeem multiple promotions over their customer lifetime (activation bonus, seasonal offers, loyalty discounts, retention credits, device subsidies). Each promotion is redeemed by thousands of subscribers across different channels and time periods. The business actively manages redemption records as operational entities, tracking when each subscriber redeemed which promotion, through what channel, for what applied discount amount, and the benefit period duration.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`survey_wave` (
    `survey_wave_id` BIGINT COMMENT 'Primary key for survey_wave',
    `survey_template_id` BIGINT COMMENT 'Identifier of the survey template used for this wave.',
    `prior_survey_wave_id` BIGINT COMMENT 'Self-referencing FK on survey_wave (prior_survey_wave_id)',
    `actual_respondent_count` BIGINT COMMENT 'Number of respondents who completed the survey wave.',
    `compliance_ccpa` BOOLEAN COMMENT 'Indicates if the survey wave complies with CCPA requirements.',
    `compliance_gdpr` BOOLEAN COMMENT 'Indicates if the survey wave complies with GDPR requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey wave record was created.',
    `data_retention_days` STRING COMMENT 'Number of days survey responses are retained before deletion.',
    `delivery_channel` STRING COMMENT 'Primary channel used to deliver the survey to respondents.',
    `survey_wave_description` STRING COMMENT 'Detailed description of the purpose and scope of the survey wave.',
    `end_date` DATE COMMENT 'Date when the survey wave ends or is scheduled to end.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary value of the incentive offered per respondent.',
    `incentive_offered` BOOLEAN COMMENT 'Flag indicating if an incentive is offered to respondents.',
    `incentive_type` STRING COMMENT 'Type of incentive provided to respondents, if any.',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether responses are collected anonymously.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter code representing the language of the survey.',
    `last_response_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent response received for this wave.',
    `notes` STRING COMMENT 'Additional free-text notes related to the survey wave.',
    `region_code` STRING COMMENT 'Three-letter ISO country code indicating the primary region for the survey wave.',
    `response_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of respondents who completed the survey out of those invited.',
    `start_date` DATE COMMENT 'Date when the survey wave begins.',
    `survey_owner` STRING COMMENT 'Name or identifier of the business unit or individual responsible for the survey wave.',
    `survey_owner_email` STRING COMMENT 'Email address of the survey owner.',
    `survey_version` STRING COMMENT 'Version identifier of the survey instrument used in this wave.',
    `target_respondent_count` BIGINT COMMENT 'Planned number of respondents for the survey wave.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the survey wave record.',
    `wave_code` STRING COMMENT 'Business code used to reference the survey wave.',
    `wave_name` STRING COMMENT 'Human readable name of the survey wave.',
    `wave_status` STRING COMMENT 'Current lifecycle status of the survey wave.',
    `wave_type` STRING COMMENT 'Category of respondents targeted by the wave.',
    CONSTRAINT pk_survey_wave PRIMARY KEY(`survey_wave_id`)
) COMMENT 'Master reference table for survey_wave. Referenced by survey_wave_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`customer`.`survey_template` (
    `survey_template_id` BIGINT COMMENT 'Primary key for survey_template',
    `derived_from_survey_template_id` BIGINT COMMENT 'Self-referencing FK on survey_template (derived_from_survey_template_id)',
    `approval_status` STRING COMMENT 'Current approval state of the survey template.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the survey template was approved.',
    `average_completion_time_minutes` STRING COMMENT 'Estimated average time (in minutes) required to complete the survey.',
    `survey_template_code` STRING COMMENT 'Business code used to reference the survey template in external systems.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the survey content.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the survey template record was first created.',
    `survey_template_description` STRING COMMENT 'Detailed description of the purpose and content of the survey.',
    `effective_from` DATE COMMENT 'Date from which the survey template becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the survey template is no longer valid (nullable for open‑ended).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether completion of the survey is mandatory for the target audience.',
    `language` STRING COMMENT 'ISO language code of the survey content.',
    `last_review_date` DATE COMMENT 'Date when the survey template was last reviewed for relevance or compliance.',
    `max_questions` STRING COMMENT 'Maximum number of questions allowed in the survey template.',
    `survey_template_name` STRING COMMENT 'Human‑readable name of the survey template.',
    `owner_department` STRING COMMENT 'Organizational department responsible for the survey template.',
    `response_type` STRING COMMENT 'Supported response format for questions in the survey.',
    `survey_template_status` STRING COMMENT 'Current lifecycle status of the survey template.',
    `survey_category` STRING COMMENT 'High‑level business category the survey addresses.',
    `target_audience` STRING COMMENT 'Intended audience segment for the survey.',
    `survey_template_type` STRING COMMENT 'Category of the survey (e.g., customer, employee, partner, network, service).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the survey template.',
    `version` STRING COMMENT 'Version identifier following semantic versioning (e.g., v1.0).',
    CONSTRAINT pk_survey_template PRIMARY KEY(`survey_template_id`)
) COMMENT 'Master reference table for survey_template. Referenced by survey_template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_parent_account_customer_account_id` FOREIGN KEY (`parent_account_customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ADD CONSTRAINT `fk_customer_subscriber_household_id` FOREIGN KEY (`household_id`) REFERENCES `telecommunication_ecm`.`customer`.`household`(`household_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ADD CONSTRAINT `fk_customer_customer_contact_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ADD CONSTRAINT `fk_customer_customer_address_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ADD CONSTRAINT `fk_customer_household_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_customer_address_id` FOREIGN KEY (`customer_address_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_address`(`customer_address_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ADD CONSTRAINT `fk_customer_corporate_hierarchy_parent_hierarchy_corporate_hierarchy_id` FOREIGN KEY (`parent_hierarchy_corporate_hierarchy_id`) REFERENCES `telecommunication_ecm`.`customer`.`corporate_hierarchy`(`corporate_hierarchy_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_customer_mnp_request_id` FOREIGN KEY (`customer_mnp_request_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_mnp_request`(`customer_mnp_request_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ADD CONSTRAINT `fk_customer_customer_interaction_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_customer_interaction_id` FOREIGN KEY (`customer_interaction_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_interaction`(`customer_interaction_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_customer_mnp_request_id` FOREIGN KEY (`customer_mnp_request_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_mnp_request`(`customer_mnp_request_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_device_registration_id` FOREIGN KEY (`device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_parent_case_id` FOREIGN KEY (`parent_case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_case_id` FOREIGN KEY (`case_id`) REFERENCES `telecommunication_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_customer_interaction_id` FOREIGN KEY (`customer_interaction_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_interaction`(`customer_interaction_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ADD CONSTRAINT `fk_customer_csat_response_survey_wave_id` FOREIGN KEY (`survey_wave_id`) REFERENCES `telecommunication_ecm`.`customer`.`survey_wave`(`survey_wave_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_parent_consent_record_id` FOREIGN KEY (`parent_consent_record_id`) REFERENCES `telecommunication_ecm`.`customer`.`consent_record`(`consent_record_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ADD CONSTRAINT `fk_customer_customer_mnp_request_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ADD CONSTRAINT `fk_customer_customer_mnp_request_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ADD CONSTRAINT `fk_customer_loyalty_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_replacement_device_registration_id` FOREIGN KEY (`replacement_device_registration_id`) REFERENCES `telecommunication_ecm`.`customer`.`device_registration`(`device_registration_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ADD CONSTRAINT `fk_customer_device_registration_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ADD CONSTRAINT `fk_customer_kyc_verification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ADD CONSTRAINT `fk_customer_kyc_verification_customer_contact_id` FOREIGN KEY (`customer_contact_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_contact`(`customer_contact_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ADD CONSTRAINT `fk_customer_kyc_verification_previous_verification_kyc_verification_id` FOREIGN KEY (`previous_verification_kyc_verification_id`) REFERENCES `telecommunication_ecm`.`customer`.`kyc_verification`(`kyc_verification_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ADD CONSTRAINT `fk_customer_kyc_verification_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ADD CONSTRAINT `fk_customer_customer_segment_membership_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ADD CONSTRAINT `fk_customer_promo_redemption_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ADD CONSTRAINT `fk_customer_account_dealer_transaction_account_customer_account_id` FOREIGN KEY (`account_customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ADD CONSTRAINT `fk_customer_account_dealer_transaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `telecommunication_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ADD CONSTRAINT `fk_customer_customer_subscription_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ADD CONSTRAINT `fk_customer_customer_roaming_session_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ADD CONSTRAINT `fk_customer_customer_account_coverage_corporate_hierarchy_id` FOREIGN KEY (`corporate_hierarchy_id`) REFERENCES `telecommunication_ecm`.`customer`.`corporate_hierarchy`(`corporate_hierarchy_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ADD CONSTRAINT `fk_customer_redemption_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `telecommunication_ecm`.`customer`.`subscriber`(`subscriber_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_wave` ADD CONSTRAINT `fk_customer_survey_wave_survey_template_id` FOREIGN KEY (`survey_template_id`) REFERENCES `telecommunication_ecm`.`customer`.`survey_template`(`survey_template_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_wave` ADD CONSTRAINT `fk_customer_survey_wave_prior_survey_wave_id` FOREIGN KEY (`prior_survey_wave_id`) REFERENCES `telecommunication_ecm`.`customer`.`survey_wave`(`survey_wave_id`);
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_template` ADD CONSTRAINT `fk_customer_survey_template_derived_from_survey_template_id` FOREIGN KEY (`derived_from_survey_template_id`) REFERENCES `telecommunication_ecm`.`customer`.`survey_template`(`survey_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `telecommunication_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `parent_account_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Customer Relationship Management (CRM) Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Embedded SIM (eSIM) Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `mvno_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`subscriber` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `alternate_phone` SET TAGS ('dbx_business_glossary_term' = 'Alternate Phone Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `alternate_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `alternate_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'full|limited|view_only|none');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `communication_language` SET TAGS ('dbx_business_glossary_term' = 'Communication Language');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `communication_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_value_regex' = 'primary_account_holder|authorized_representative|technical_contact|billing_contact|emergency_contact|legal_contact');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deceased');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_value_regex' = 'email|mobile|phone|sms|mail|portal');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `relationship_to_account_holder` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Account Holder');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contact Title');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `title` SET TAGS ('dbx_value_regex' = 'Mr|Mrs|Ms|Dr|Prof');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Verification Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Verification Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_contact` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending|failed');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Location Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Cell Tower Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'service|billing|installation|correspondence|shipping|legal');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `broadband_coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Broadband Coverage Tier');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `broadband_coverage_tier` SET TAGS ('dbx_value_regex' = 'fiber|cable|dsl|fixed_wireless|satellite|no_coverage');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `dwelling_type` SET TAGS ('dbx_business_glossary_term' = 'Dwelling Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `ftth_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fiber to the Home (FTTH) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `gpon_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Gigabit Passive Optical Network (GPON) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `hash` SET TAGS ('dbx_business_glossary_term' = 'Address Hash');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `lte_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Evolution (LTE) Coverage Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `maximum_download_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Download Speed in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `maximum_upload_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Upload Speed in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `mdu_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Dwelling Unit (MDU) Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `n5g_coverage_flag` SET TAGS ('dbx_business_glossary_term' = '5G New Radio (NR) Coverage Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `serving_central_office` SET TAGS ('dbx_business_glossary_term' = 'Serving Central Office');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_business_glossary_term' = 'Standardized Address');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `unit_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Source');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|invalid|pending|corrected|partial');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Household Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `active_member_count` SET TAGS ('dbx_business_glossary_term' = 'Active Member Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `arpu` SET TAGS ('dbx_business_glossary_term' = 'Household Average Revenue Per User (ARPU)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `arpu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `autopay_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Autopay Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `churn_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Tier');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `churn_risk_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `churn_risk_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `cltv_score` SET TAGS ('dbx_business_glossary_term' = 'Household Customer Lifetime Value (CLTV) Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `cltv_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_business_glossary_term' = 'Household Customer Lifetime Value (CLTV) Tier');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'month_to_month|12_month|24_month|36_month|prepaid|custom');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `credit_class` SET TAGS ('dbx_business_glossary_term' = 'Credit Class');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `credit_class` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|no_credit_check');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `credit_class` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Household Customer Satisfaction (CSAT) Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `csat_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_business_glossary_term' = 'Household Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_business_glossary_term' = 'Household Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|pending_activation|terminated');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_business_glossary_term' = 'Household Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_value_regex' = 'family_plan|shared_data_group|multi_line_residential|business_group|student_group|senior_plan');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `loyalty_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Balance');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `loyalty_program_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Tier');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `loyalty_program_tier` SET TAGS ('dbx_value_regex' = 'diamond|platinum|gold|silver|bronze|none');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `mrr` SET TAGS ('dbx_business_glossary_term' = 'Household Monthly Recurring Revenue (MRR)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `mrr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Household Net Promoter Score (NPS)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `nps_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail|mobile_app');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Household Reference Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^HH[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Household Segment');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'premium|mass_market|value|prepaid|business');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `shared_data_pool_flag` SET TAGS ('dbx_business_glossary_term' = 'Shared Data Pool Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `shared_data_pool_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Shared Data Pool Size Gigabytes (GB)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `shared_data_pool_used_gb` SET TAGS ('dbx_business_glossary_term' = 'Shared Data Pool Used Gigabytes (GB)');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `shared_minutes_pool_flag` SET TAGS ('dbx_business_glossary_term' = 'Shared Minutes Pool Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `shared_minutes_pool_size` SET TAGS ('dbx_business_glossary_term' = 'Shared Minutes Pool Size');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'salesforce_crm|amdocs|netcracker|oracle_osm|legacy_billing|manual_entry');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`household` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `corporate_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Hierarchy Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Location Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `parent_hierarchy_corporate_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Hierarchy Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Band');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_value_regex' = '0-1M|1M-10M|10M-50M|50M-100M|100M-500M|500M+');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `company_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `company_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `consolidated_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Billing Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `employee_headcount_band` SET TAGS ('dbx_business_glossary_term' = 'Employee Headcount Band');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `employee_headcount_band` SET TAGS ('dbx_value_regex' = '1-10|11-50|51-200|201-500|501-1000|1001-5000|5001+');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `employee_headcount_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `hierarchy_node_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `hierarchy_node_type` SET TAGS ('dbx_value_regex' = 'ultimate_parent|subsidiary|branch|department|cost_center|division');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_activation|pending_termination');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `industry_vertical_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `industry_vertical_description` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical Description');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `jurisdiction_state_province` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State or Province');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `managed_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Managed Account Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'wholly_owned|majority_owned|minority_owned|joint_venture|affiliate');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `telecommunication_ecm`.`customer`.`corporate_hierarchy` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `customer_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `customer_mnp_request_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Request Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `iptv_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Iptv Channel Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Service Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vod Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `callback_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Callback Requested Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `callback_scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Callback Scheduled Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'voice|chat|email|store|mobile_app|web_portal');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `customer_effort_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Effort Score (CES)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Interaction Direction');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration in Seconds');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction End Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `fcr_flag` SET TAGS ('dbx_business_glossary_term' = 'First Call Resolution (FCR) Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated|pending');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'inquiry|complaint|service_request|sales|technical_support|billing_inquiry');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Notes');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `nps_survey_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Triggered Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `queue_name` SET TAGS ('dbx_business_glossary_term' = 'Queue Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `recording_url` SET TAGS ('dbx_business_glossary_term' = 'Recording Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `recording_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Interaction Reference Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^INT-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|partially_resolved|escalated|pending');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Interaction Source System');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Interaction Summary');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `topic_category` SET TAGS ('dbx_business_glossary_term' = 'Topic Category');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_interaction` ALTER COLUMN `topic_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Topic Subcategory');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `customer_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `customer_mnp_request_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Request Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `iptv_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Iptv Channel Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `parent_case_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Case Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `problem_record_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Service Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vod Asset Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`customer`.`case` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Code');
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
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` SET TAGS ('dbx_subdomain' = 'marketing_analytics');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `csat_response_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Response ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `customer_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `survey_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Wave ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `agent_rating` SET TAGS ('dbx_business_glossary_term' = 'Agent Rating');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `closed_loop_action_code` SET TAGS ('dbx_business_glossary_term' = 'Closed-Loop Action Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `closed_loop_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Closed-Loop Completion Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `contact_permission_flag` SET TAGS ('dbx_business_glossary_term' = 'Contact Permission Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|enterprise|wholesale|prepaid|postpaid');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `ease_of_resolution_rating` SET TAGS ('dbx_business_glossary_term' = 'Ease of Resolution Rating');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `follow_up_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `follow_up_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Category');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'completed|partial|abandoned|invalid');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Time Seconds');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `score_scale` SET TAGS ('dbx_business_glossary_term' = 'Score Scale');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `score_scale` SET TAGS ('dbx_value_regex' = '0-10|1-5|1-7|1-10');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `score_value` SET TAGS ('dbx_business_glossary_term' = 'Score Value');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `survey_channel` SET TAGS ('dbx_business_glossary_term' = 'Survey Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `survey_channel` SET TAGS ('dbx_value_regex' = 'SMS|email|IVR|mobile_app|web_portal|post_call');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `survey_invitation_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Invitation Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `survey_language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `survey_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'NPS|CSAT|CES');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `trigger_event` SET TAGS ('dbx_value_regex' = 'post_interaction|post_installation|periodic|post_repair|post_purchase|post_billing');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Comment');
ALTER TABLE `telecommunication_ecm`.`customer`.`csat_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Rule Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`consent_record` ALTER COLUMN `parent_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Consent Record Identifier (ID)');
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
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `customer_mnp_request_id` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Request ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Address Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `actual_completion_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Hours');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `actual_port_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Port Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `central_database_sync_flag` SET TAGS ('dbx_business_glossary_term' = 'Central Database Sync Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `central_database_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Central Database Sync Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `mnp_request_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Request Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `mnp_request_number` SET TAGS ('dbx_value_regex' = '^MNP[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `nrtrde_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Near Real-Time Roaming Data Exchange (NRTRDE) Notification Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `number_range_holder` SET TAGS ('dbx_business_glossary_term' = 'Number Range Holder');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `number_range_holder` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `port_type` SET TAGS ('dbx_business_glossary_term' = 'Port Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `port_type` SET TAGS ('dbx_value_regex' = 'simple|complex|bulk');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `previous_port_count` SET TAGS ('dbx_business_glossary_term' = 'Previous Port Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `recipient_operator_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Operator Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `recipient_operator_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Request Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Request Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Request Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'port_in|port_out');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `scheduled_port_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Port Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'prepaid|postpaid|hybrid');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `subscriber_account_number` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Account Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `subscriber_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `subscriber_account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_mnp_request` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Liability General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|closed|pending_activation|frozen');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `auto_redemption_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Redemption Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Segment');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_value_regex' = 'high|medium|low|vip|at_risk');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score (CSAT)');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `current_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Points Balance');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `earning_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Earning Rate Multiplier');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|retail_store|call_center|partner|auto_enroll');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `last_earn_date` SET TAGS ('dbx_business_glossary_term' = 'Last Points Earn Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `last_redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Last Points Redemption Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `lifetime_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Earned');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `lifetime_points_expired` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Expired');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `lifetime_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Redeemed');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `loyalty_program_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `loyalty_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `loyalty_program_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Name');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `next_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Next Points Expiry Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `next_expiry_points_amount` SET TAGS ('dbx_business_glossary_term' = 'Next Expiry Points Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `partner_account_number` SET TAGS ('dbx_business_glossary_term' = 'Partner Account Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `partner_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `partner_program_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `points_expiry_period_months` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Period (Months)');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `points_pending_credit` SET TAGS ('dbx_business_glossary_term' = 'Points Pending Credit');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `points_to_next_tier` SET TAGS ('dbx_business_glossary_term' = 'Points to Next Tier');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `redemption_rate` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rate');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `referral_bonus_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Referral Bonus Points Earned');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `referral_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Level');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `tier_level` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond|vip');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `tier_points_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier Points Threshold');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `tier_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`loyalty_account` ALTER COLUMN `tier_review_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Review Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Installment Plan Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `device_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Device Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Device Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Registered By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `esim_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Embedded Subscriber Identity Module (eSIM) Profile Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `esim_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `esim_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `replacement_device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Device Registration Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`device_registration` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
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
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `kyc_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Rule Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `previous_verification_kyc_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Verification ID');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|partial|not_applicable');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `biometric_match_score` SET TAGS ('dbx_business_glossary_term' = 'Biometric Match Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `biometric_match_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `biometric_match_score` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `biometric_type` SET TAGS ('dbx_business_glossary_term' = 'Biometric Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `biometric_type` SET TAGS ('dbx_value_regex' = 'facial_recognition|fingerprint|iris_scan|voice_recognition|none');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `biometric_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `biometric_type` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `credit_check_performed` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Performed');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `document_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiry Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `document_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Document Issue Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'passport|national_id|driving_licence|utility_bill|bank_statement|tax_document');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `fraud_indicators` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicators');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `fraud_indicators` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_channel` SET TAGS ('dbx_business_glossary_term' = 'Verification Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|retail_store|call_center|agent_portal');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Verification Duration Seconds');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Expiry Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_provider` SET TAGS ('dbx_business_glossary_term' = 'Verification Provider');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_provider_reference` SET TAGS ('dbx_business_glossary_term' = 'Verification Provider Reference');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_reason` SET TAGS ('dbx_business_glossary_term' = 'Verification Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_reason` SET TAGS ('dbx_value_regex' = 'new_customer|periodic_review|high_value_transaction|regulatory_requirement|fraud_alert|customer_request');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Reference Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_score` SET TAGS ('dbx_business_glossary_term' = 'Verification Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|passed|failed|expired|cancelled');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_type` SET TAGS ('dbx_business_glossary_term' = 'Verification Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `verification_type` SET TAGS ('dbx_value_regex' = 'identity_document|biometric|credit_check|address_proof|database_check|video_verification');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `watchlist_match_details` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Match Details');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `watchlist_match_details` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `watchlist_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Screening Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`kyc_verification` ALTER COLUMN `watchlist_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match_found|pending_review|not_performed');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` SET TAGS ('dbx_subdomain' = 'marketing_analytics');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` SET TAGS ('dbx_association_edges' = 'customer.subscriber,analytics.segment_definition');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `customer_segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'customer_segment_membership Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership - Segment Definition Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership - Subscriber Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `is_primary_segment` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Segment Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `override_by_user` SET TAGS ('dbx_business_glossary_term' = 'Override By User');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `propensity_score` SET TAGS ('dbx_business_glossary_term' = 'Propensity Score');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `segment_membership_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_segment_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` SET TAGS ('dbx_subdomain' = 'marketing_analytics');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` SET TAGS ('dbx_association_edges' = 'customer.customer_account,product.promo_offer');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `promo_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Redemption Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Applied To Invoice');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Redemption - Customer Account Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Redemption - Promo Offer Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `discount_applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Applied Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `promo_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `redeemed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Redeemed By User');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `redemption_code` SET TAGS ('dbx_business_glossary_term' = 'Redemption Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`promo_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` SET TAGS ('dbx_association_edges' = 'customer.customer_account,partner.dealer');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `account_dealer_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Account Dealer Transaction Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `account_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Dealer Transaction - Customer Account Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Account Dealer Transaction - Dealer Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `activation_count` SET TAGS ('dbx_business_glossary_term' = 'Activation Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `device_sale_count` SET TAGS ('dbx_business_glossary_term' = 'Device Sale Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`account_dealer_transaction` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` SET TAGS ('dbx_association_edges' = 'customer.subscriber,product.addon');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `customer_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'customer_subscription Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription - Addon Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription - Subscriber Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `billing_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `addon_status` SET TAGS ('dbx_business_glossary_term' = 'Add-on Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Purchase Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `proration_amount` SET TAGS ('dbx_business_glossary_term' = 'Proration Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `recurring_charge` SET TAGS ('dbx_business_glossary_term' = 'Recurring Charge Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_subscription` ALTER COLUMN `trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trial End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` SET TAGS ('dbx_association_edges' = 'customer.subscriber,partner.partner_roaming_agreement');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `customer_roaming_session_id` SET TAGS ('dbx_business_glossary_term' = 'customer_roaming_session Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `roaming_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Session - Partner Roaming Agreement Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Session - Subscriber Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `data_usage_mb` SET TAGS ('dbx_business_glossary_term' = 'Data Usage Volume');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `fraud_alert_triggered` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Flag');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `location_area_code` SET TAGS ('dbx_business_glossary_term' = 'Location Area Code');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `roaming_charges` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Roaming Charges');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `roaming_session_id` SET TAGS ('dbx_business_glossary_term' = 'Roaming Session Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Roaming Session End Time');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Roaming Session Start Time');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `sms_count` SET TAGS ('dbx_business_glossary_term' = 'SMS Message Count');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `tap_file_reference` SET TAGS ('dbx_business_glossary_term' = 'TAP File Reference Number');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `technology_used` SET TAGS ('dbx_business_glossary_term' = 'Network Technology Standard');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `visited_network_code` SET TAGS ('dbx_business_glossary_term' = 'Visited Network MCC-MNC');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_roaming_session` ALTER COLUMN `voice_minutes` SET TAGS ('dbx_business_glossary_term' = 'Voice Call Duration');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` SET TAGS ('dbx_association_edges' = 'customer.corporate_hierarchy,people.employee');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `customer_account_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'customer_account_coverage Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `corporate_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Coverage - Corporate Hierarchy Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Coverage - Employee Id');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `account_coverage_code` SET TAGS ('dbx_business_glossary_term' = 'Account Coverage Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `commission_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Percentage');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Assignment Start Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `primary_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Coverage Indicator');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `quota_allocation` SET TAGS ('dbx_business_glossary_term' = 'Quota Allocation Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `sales_role` SET TAGS ('dbx_business_glossary_term' = 'Sales Role Type');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `territory_assignment` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Assignment');
ALTER TABLE `telecommunication_ecm`.`customer`.`customer_account_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` SET TAGS ('dbx_subdomain' = 'marketing_analytics');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` SET TAGS ('dbx_association_edges' = 'customer.subscriber,sales.promotion');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applying Employee');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `benefit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit End Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `benefit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Start Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `discount_amount_applied` SET TAGS ('dbx_business_glossary_term' = 'Applied Discount Amount');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `quote_reference` SET TAGS ('dbx_business_glossary_term' = 'Quote Reference');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Date');
ALTER TABLE `telecommunication_ecm`.`customer`.`redemption` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_wave` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_wave` SET TAGS ('dbx_subdomain' = 'marketing_analytics');
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_wave` ALTER COLUMN `survey_wave_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Wave Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_wave` ALTER COLUMN `prior_survey_wave_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_wave` ALTER COLUMN `survey_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_wave` ALTER COLUMN `survey_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_template` SET TAGS ('dbx_subdomain' = 'marketing_analytics');
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_template` ALTER COLUMN `survey_template_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Template Identifier');
ALTER TABLE `telecommunication_ecm`.`customer`.`survey_template` ALTER COLUMN `derived_from_survey_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
