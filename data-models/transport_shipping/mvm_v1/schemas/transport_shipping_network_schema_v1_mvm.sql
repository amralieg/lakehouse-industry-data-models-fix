-- Schema for Domain: network | Business: Transport Shipping | Version: v1_mvm
-- Generated on: 2026-05-08 22:35:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`network` COMMENT 'Manages partner network relationships including carrier profiles, agent networks, correspondent offices, interline agreements, and third-party logistics provider operational capabilities across all geographies and transport modes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Unique identifier for the carrier partner. Primary key for the carrier master record.',
    `parent_carrier_id` BIGINT COMMENT 'Self-referencing FK on carrier (parent_carrier_id)',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: Carrier is an external organization that should reference the unified partner master record. This enables unified partner reporting, tiering, and lifecycle management. No columns removed because carri',
    `aeo_certified` BOOLEAN COMMENT 'Indicates whether the carrier holds AEO certification, demonstrating trusted trader status and supply chain security compliance in EU and other jurisdictions.',
    `api_integration_enabled` BOOLEAN COMMENT 'Indicates whether the carrier supports API integration for automated booking, tracking, and rate retrieval. Enables real-time system-to-system communication.',
    `carrier_type` STRING COMMENT 'Primary classification of the carrier based on their core transport service offering. NVOCC = Non-Vessel Operating Common Carrier.. Valid values are `airline|ocean_carrier|road_haulier|rail_operator|express_courier|nvocc`',
    `contract_end_date` DATE COMMENT 'Date when the primary carrier agreement expires or is scheduled for renewal. Null for open-ended agreements.',
    `contract_start_date` DATE COMMENT 'Date when the primary carrier agreement with Transport Shipping became effective. Marks the beginning of the commercial relationship.',
    `country_of_registration` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the carrier is legally registered and holds its primary operating license.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_rating` STRING COMMENT 'External credit rating assigned by rating agencies (e.g., Moodys, S&P, Fitch) indicating the carriers creditworthiness and default risk.',
    `ctpat_certified` BOOLEAN COMMENT 'Indicates whether the carrier is certified under the US C-TPAT program, demonstrating supply chain security compliance for US-bound shipments.',
    `customs_brokerage_service` BOOLEAN COMMENT 'Indicates whether the carrier provides in-house customs brokerage services for import/export clearance, or if third-party brokers must be engaged.',
    `dangerous_goods_certified` BOOLEAN COMMENT 'Indicates whether the carrier is certified to handle dangerous goods shipments under IMDG Code (ocean), IATA DGR (air), or ADR (road) regulations.',
    `edi_enabled` BOOLEAN COMMENT 'Indicates whether the carrier supports EDI for structured electronic document exchange (e.g., booking confirmations, status updates, invoices).',
    `fiata_certified` BOOLEAN COMMENT 'Indicates whether the carrier holds FIATA certification, demonstrating compliance with international freight forwarding standards.',
    `financial_standing` STRING COMMENT 'Assessment of the carriers financial health and creditworthiness based on credit ratings, financial statements, and payment history. Used for risk management and credit limit decisions.. Valid values are `excellent|good|fair|poor|under_review`',
    `headquarters_address` STRING COMMENT 'Full street address of the carriers corporate headquarters, including street, city, state/province, and postal code.',
    `headquarters_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the carriers headquarters is located.. Valid values are `^[A-Z]{3}$`',
    `iata_certified` BOOLEAN COMMENT 'Indicates whether the carrier holds valid IATA certification for air cargo operations. Required for participation in IATA cargo agency programs.',
    `iata_code` STRING COMMENT 'Two or three character airline designator code assigned by IATA for air carriers. Used in AWB (Air Waybill) and flight operations.. Valid values are `^[A-Z0-9]{2,3}$`',
    `imo_number` STRING COMMENT 'Seven-digit ship identification number assigned by IMO to ocean-going vessels. Format: IMO followed by seven digits.. Valid values are `^IMO[0-9]{7}$`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum cargo liability insurance coverage amount the carrier maintains, typically expressed in USD. Critical for high-value shipment risk assessment.',
    `insurance_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the insurance coverage amount.. Valid values are `^[A-Z]{3}$`',
    `insurance_expiry_date` DATE COMMENT 'Date when the carriers current cargo liability insurance policy expires. Monitored to ensure continuous coverage for active shipments.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the carriers cargo liability insurance policy. Used for claims processing and verification.',
    `iso_28000_certified` BOOLEAN COMMENT 'Indicates whether the carrier holds ISO 28000 certification for supply chain security management systems.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the carrier holds ISO 9001 certification for quality management systems, demonstrating commitment to consistent service quality.',
    `legal_name` STRING COMMENT 'The full legal registered name of the carrier organization as it appears on official business documents and regulatory filings.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or internal comments about the carrier relationship.',
    `onboarding_stage` STRING COMMENT 'Current stage in the carrier onboarding lifecycle, from initial prospect through active operations to potential offboarding.. Valid values are `prospect|due_diligence|contract_negotiation|integration|active|offboarding`',
    `operational_status` STRING COMMENT 'Current operational status of the carrier in the Transport Shipping network. Active carriers are eligible for new bookings; suspended/blacklisted carriers are blocked.. Valid values are `active|suspended|inactive|blacklisted|under_review`',
    `otd_percentage` DECIMAL(18,2) COMMENT 'Percentage of shipments delivered on or before the committed delivery date over the last 12 months. Key performance indicator for carrier reliability.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Composite performance score (0.00 to 5.00) based on OTD (On-Time Delivery), OTIF (On-Time In-Full), claims ratio, and service quality metrics. Used for carrier selection and routing decisions.',
    `preferred_carrier_flag` BOOLEAN COMMENT 'Indicates whether this carrier has preferred status in Transport Shippings network, receiving priority allocation and preferential rates due to strategic partnership or superior performance.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the carrier. Used for operational communications, booking confirmations, and issue escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the carrier organization for operational coordination and issue resolution.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact at the carrier, including country code. Used for urgent operational communications.',
    `registration_number` STRING COMMENT 'Official business registration or incorporation number issued by the country of registration. May be tax ID, company registration number, or equivalent national identifier.',
    `scac_code` STRING COMMENT 'Unique two-to-four letter code used to identify transportation companies in North America. Required for ocean, rail, and motor carriers operating in US trade.. Valid values are `^[A-Z]{2,4}$`',
    `service_scope` STRING COMMENT 'Geographic reach of the carriers service network: domestic (single country), regional (multi-country region), international (cross-border), or global (worldwide coverage).. Valid values are `domestic|international|regional|global`',
    `temperature_controlled_capable` BOOLEAN COMMENT 'Indicates whether the carrier has temperature-controlled (reefer) capabilities for perishable and pharmaceutical shipments requiring cold chain management.',
    `trade_name` STRING COMMENT 'The commercial or trading name under which the carrier operates, which may differ from the legal name. Also known as DBA (Doing Business As).',
    `transport_modes` STRING COMMENT 'Comma-separated list of transport modes the carrier operates: air, ocean, road, rail, multimodal. Indicates the carriers operational capabilities across different freight modes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier record was last modified. Used for audit trail and change tracking.',
    `website_url` STRING COMMENT 'Primary website URL of the carrier for tracking, service information, and customer support.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record for all carrier partners in the Transport Shipping network, including airlines, ocean shipping lines, road hauliers, rail operators, and express courier partners. Captures carrier legal name, IATA/SCAC/IMO codes, carrier type, transport modes supported, country of registration, regulatory certifications (IATA, FIATA, C-TPAT, AEO), financial standing, insurance coverage details, operational status, and onboarding lifecycle stage. Serves as the SSOT for carrier identity across freight, route, and contract domains.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`carrier_profile` (
    `carrier_profile_id` BIGINT COMMENT 'Unique identifier for the carrier operational capability profile. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier master identity record. Links this operational profile to the carrier entity.',
    `superseded_carrier_profile_id` BIGINT COMMENT 'Self-referencing FK on carrier_profile (superseded_carrier_profile_id)',
    `api_integration_available` BOOLEAN COMMENT 'Indicates whether the carrier provides API (Application Programming Interface) integration for real-time booking, tracking, and rate queries.',
    `api_protocol` STRING COMMENT 'Type of API protocol supported by the carrier: REST, SOAP, GraphQL, proprietary, or none if no API available.. Valid values are `rest|soap|graphql|proprietary|none`',
    `average_transit_time_days` DECIMAL(18,2) COMMENT 'Average transit time in days for shipments handled by this carrier profile, calculated from historical data.',
    `carbon_reporting_available` BOOLEAN COMMENT 'Indicates whether the carrier provides CO2e (Carbon Dioxide Equivalent) emissions reporting for shipments.',
    `claims_ratio_percentage` DECIMAL(18,2) COMMENT 'Historical cargo claims ratio as a percentage of total shipments (0.00 to 100.00). Lower is better.',
    `countries_served` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where carrier provides service (e.g., USA, CAN, MEX, GBR, DEU, CHN).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier profile record was first created in the system.',
    `cross_border_capable` BOOLEAN COMMENT 'Indicates whether the carrier handles cross-border international shipments including customs clearance coordination.',
    `customs_brokerage_included` BOOLEAN COMMENT 'Indicates whether the carrier provides in-house customs brokerage services as part of their offering.',
    `dangerous_goods_certified` BOOLEAN COMMENT 'Indicates whether the carrier is certified to handle dangerous goods (hazmat) shipments.',
    `dg_classes_handled` STRING COMMENT 'Comma-separated list of UN dangerous goods classes the carrier is certified to handle (e.g., Class 1 Explosives, Class 3 Flammable Liquids, Class 8 Corrosives). Null if not DG certified.',
    `edi_capable` BOOLEAN COMMENT 'Indicates whether the carrier supports EDI (Electronic Data Interchange) for automated document exchange (e.g., 214, 210, 990 transaction sets).',
    `effective_date` DATE COMMENT 'Date when this carrier profile became effective and available for operational use.',
    `equipment_types` STRING COMMENT 'Comma-separated list of equipment types operated: dry_van, reefer, flatbed, tanker, container_20ft, container_40ft, container_40ft_hc, aircraft_freighter, rail_car, barge. [ENUM-REF-CANDIDATE: dry_van|reefer|flatbed|tanker|container_20ft|container_40ft|container_40ft_hc|aircraft_freighter|rail_car|barge|lowboy|chassis — promote to reference product]',
    `expiration_date` DATE COMMENT 'Date when this carrier profile expires or is scheduled for review. Null if open-ended.',
    `geographic_coverage_scope` STRING COMMENT 'Overall geographic reach of the carrier: global (worldwide), regional (multi-country region), national (single country), local (city/metro), or trade-lane-specific (dedicated corridors).. Valid values are `global|regional|national|local|trade_lane_specific`',
    `insurance_coverage_available` BOOLEAN COMMENT 'Indicates whether the carrier offers cargo insurance coverage as part of their service or through a partner.',
    `last_mile_capable` BOOLEAN COMMENT 'Indicates whether the carrier provides last-mile delivery services to final consignee addresses (residential or commercial).',
    `last_reviewed_date` DATE COMMENT 'Date when this carrier profile was last reviewed and validated by the carrier management team.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier profile record was last modified.',
    `max_insurance_value_usd` DECIMAL(18,2) COMMENT 'Maximum cargo value in USD that can be insured per shipment. Null if insurance not available.',
    `max_volume_capacity_cbm` DECIMAL(18,2) COMMENT 'Maximum single shipment volume capacity in cubic meters (CBM) that this carrier can handle.',
    `max_weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum single shipment weight capacity in kilograms that this carrier can handle.',
    `operational_status` STRING COMMENT 'Current operational status of the carrier profile indicating availability for shipment assignment and booking.. Valid values are `active|inactive|suspended|onboarding|offboarding|restricted`',
    `otd_percentage` DECIMAL(18,2) COMMENT 'Historical on-time delivery performance percentage for this carrier profile (0.00 to 100.00). Calculated from actual shipment data.',
    `performance_tier` STRING COMMENT 'Internal performance tier classification based on OTD (On-Time Delivery), claims ratio, and service quality: platinum (best), gold, silver, bronze, or standard.. Valid values are `platinum|gold|silver|bronze|standard`',
    `profile_code` STRING COMMENT 'Unique business identifier code for this carrier profile used in operational systems and partner integrations.',
    `profile_name` STRING COMMENT 'Business-friendly name for this carrier operational profile (e.g., Global Express Air, Regional LTL Network).',
    `profile_type` STRING COMMENT 'Classification of the carrier operational model: asset-based (owns fleet), non-asset-based (broker/3PL), hybrid, NVOCC (Non-Vessel Operating Common Carrier), or freight forwarder.. Valid values are `asset_based|non_asset_based|hybrid|nvocc|freight_forwarder`',
    `quality_certifications` STRING COMMENT 'Comma-separated list of quality and compliance certifications held by the carrier (e.g., ISO 9001, C-TPAT, AEO, TAPA, GDP).',
    `real_time_tracking_available` BOOLEAN COMMENT 'Indicates whether the carrier provides real-time GPS or milestone-based shipment tracking visibility.',
    `regions_served` STRING COMMENT 'Comma-separated list of geographic regions where carrier operates (e.g., North America, Europe, Asia Pacific, Middle East, Latin America, Africa).',
    `security_rating` STRING COMMENT 'Security risk rating assigned to the carrier based on compliance, incident history, and certifications: high (best), medium, low, or not rated.. Valid values are `high|medium|low|not_rated`',
    `service_types` STRING COMMENT 'Comma-separated list of service types offered: FTL (Full Truckload), LTL (Less Than Truckload), FCL (Full Container Load), LCL (Less Than Container Load), express, economy, standard, same_day, next_day, deferred. [ENUM-REF-CANDIDATE: ftl|ltl|fcl|lcl|express|economy|standard|same_day|next_day|deferred|white_glove — promote to reference product]',
    `sustainability_certified` BOOLEAN COMMENT 'Indicates whether the carrier holds sustainability or environmental certifications (e.g., SmartWay, ISO 14001, carbon neutral).',
    `temperature_controlled_capable` BOOLEAN COMMENT 'Indicates whether the carrier has temperature-controlled (reefer) capability for cold chain shipments.',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius that carrier can maintain for temperature-controlled shipments. Null if not applicable.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius that carrier can maintain for temperature-controlled shipments. Null if not applicable.',
    `teu_capacity` STRING COMMENT 'Container capacity measured in TEU (Twenty-foot Equivalent Units) for ocean carriers. Null for non-ocean modes.',
    `tracking_granularity` STRING COMMENT 'Level of tracking detail provided: real-time GPS, milestone-based (pickup/in-transit/delivery), daily update, manual, or none.. Valid values are `real_time_gps|milestone_based|daily_update|manual|none`',
    `trade_lanes_covered` STRING COMMENT 'Comma-separated list of major trade lanes or corridors served (e.g., Transpacific, Transatlantic, Asia-Europe, Intra-Asia, US-Mexico).',
    `transport_modes` STRING COMMENT 'Comma-separated list of transport modes this carrier operates: air, ocean, road, rail, multimodal, barge, courier. [ENUM-REF-CANDIDATE: air|ocean|road|rail|multimodal|barge|courier|parcel — promote to reference product]',
    CONSTRAINT pk_carrier_profile PRIMARY KEY(`carrier_profile_id`)
) COMMENT 'Operational capability profile for a carrier partner, extending the carrier master with detailed service capability data. Captures transport modes offered (air, ocean, road, rail, multimodal), geographic coverage (trade lanes, regions, countries served), service types (FTL, LTL, FCL, LCL, express, economy), capacity parameters (max weight, volume, TEU capacity), equipment types operated, temperature-controlled capability, dangerous goods handling certification, last-mile capability, and digital integration readiness (EDI, API). Distinct from the carrier master identity record — this is the operational capability profile.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`agent` (
    `agent_id` BIGINT COMMENT 'Unique identifier for the freight agent, general sales agent (GSA), handling agent, or ground handling agent in the Transport Shipping partner network.',
    `parent_agent_id` BIGINT COMMENT 'Self-referencing FK on agent (parent_agent_id)',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: Agent is an external organization participating in the Transport Shipping network. The partner table is the unified master for all external organizations. Linking agent to partner enables unified part',
    `address_line1` STRING COMMENT 'The primary street address line for the agents registered business location, including street number and name.',
    `address_line2` STRING COMMENT 'Secondary address information such as suite number, building name, floor, or department for the agents business location.',
    `aeo_certified` BOOLEAN COMMENT 'Indicates whether the agent holds AEO certification, a trusted trader status granted by customs authorities that provides expedited clearance and reduced inspections for compliant supply chain partners.',
    `agent_status` STRING COMMENT 'The current lifecycle status of the agent relationship. Active agents are authorized to conduct business; inactive agents are temporarily not operating; suspended agents have had privileges revoked pending review; pending approval agents are undergoing onboarding; terminated agents have had their relationship permanently ended.. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `agent_type` STRING COMMENT 'Classification of the agent based on their primary operational role in the logistics network. Freight agents represent carriers for cargo booking; GSAs (General Sales Agents) represent airlines for sales and marketing; handling agents provide ground services at airports/ports; customs agents facilitate trade compliance; co-loaders consolidate shipments; ground handling agents provide airport ramp and terminal services.. Valid values are `freight_agent|gsa|handling_agent|customs_agent|co_loader|ground_handling_agent`',
    `bond_amount` DECIMAL(18,2) COMMENT 'The monetary value of the customs bond or financial guarantee held by the agent, expressed in the agents local currency. Represents the maximum liability coverage for customs duties and taxes.',
    `bond_currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the bond amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `bonding_status` STRING COMMENT 'Indicates whether the agent holds a valid customs bond or financial guarantee required for handling in-bond cargo movements and customs clearance activities. Bonded status is mandatory for customs agents.. Valid values are `bonded|non_bonded|pending`',
    `business_registration_number` STRING COMMENT 'The official company registration or incorporation number assigned by the government registry in the agents country of operation, proving legal entity status.',
    `city` STRING COMMENT 'The primary city where the agent maintains their main operational office or headquarters.',
    `commission_structure_type` STRING COMMENT 'The method by which the agent earns compensation for services rendered. Percentage commissions are based on shipment value or freight charges; flat fees are fixed per transaction; tiered structures vary by volume thresholds; hybrid combines multiple methods.. Valid values are `percentage|flat_fee|tiered|hybrid`',
    `contract_end_date` DATE COMMENT 'The date on which the agent agreement or partnership contract is scheduled to expire or was terminated. Null for open-ended agreements.',
    `contract_start_date` DATE COMMENT 'The date on which the agent agreement or partnership contract became effective, marking the beginning of the authorized business relationship.',
    `country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code representing the primary country of operation for the agent.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this agent record was first created in the system, used for audit trail and data lineage tracking.',
    `ctpat_certified` BOOLEAN COMMENT 'Indicates whether the agent is certified under the U.S. Customs and Border Protection C-TPAT program, which validates supply chain security practices and provides trade facilitation benefits.',
    `dangerous_goods_certified` BOOLEAN COMMENT 'Indicates whether the agent is certified and authorized to handle dangerous goods (DG) shipments in accordance with IATA Dangerous Goods Regulations (DGR) or IMDG Code requirements.',
    `fiata_member` BOOLEAN COMMENT 'Indicates whether the agent is a member of FIATA, the global representative body for freight forwarders and logistics providers, which provides industry standards and advocacy.',
    `iata_agent_code` STRING COMMENT 'The unique numeric code assigned by IATA to accredited cargo and passenger sales agents, typically 7 or 8 digits. Required for agents handling air waybills (AWBs) and airline bookings.. Valid values are `^[0-9]{7,8}$`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The total monetary value of liability insurance coverage maintained by the agent for cargo loss, damage, and professional indemnity, expressed in the agents local currency.',
    `insurance_currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the insurance coverage amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the agent holds ISO 9001 certification for quality management systems, demonstrating adherence to international standards for process consistency and customer satisfaction.',
    `last_audit_date` DATE COMMENT 'The date of the most recent operational or compliance audit conducted on the agents facilities, processes, and documentation practices.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this agent record was most recently updated, used for change tracking and data synchronization.',
    `legal_name` STRING COMMENT 'The full legal registered name of the agent entity as it appears on official business registration documents and contracts.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next periodic audit of the agents operations and compliance status, typically conducted annually or biennially.',
    `notes` STRING COMMENT 'Free-text field for capturing additional operational notes, special handling instructions, service limitations, or relationship management comments about the agent.',
    `nvocc_licensed` BOOLEAN COMMENT 'Indicates whether the agent holds a valid NVOCC license, allowing them to issue house bills of lading (HBLs) and operate as a carrier without owning vessels.',
    `operational_scope` STRING COMMENT 'The geographic reach of the agents service capabilities. Local agents serve a single city or metro area; regional agents cover multiple cities or provinces; national agents operate across an entire country; international agents have cross-border capabilities.. Valid values are `local|regional|national|international`',
    `performance_rating` STRING COMMENT 'The most recent performance evaluation rating assigned to the agent based on service quality, compliance, on-time delivery (OTD), documentation accuracy, and customer satisfaction metrics.. Valid values are `excellent|good|satisfactory|needs_improvement|poor`',
    `postal_code` STRING COMMENT 'The postal or ZIP code for the agents registered business address, used for mail delivery and geographic identification.',
    `primary_contact_email` STRING COMMENT 'The main email address for operational communication with the agent, used for booking confirmations, documentation, and business correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'The main telephone number for reaching the agents operations team, including country code and area code.',
    `principal_carrier_relationships` STRING COMMENT 'Comma-separated list of carrier names or IATA/SCAC codes for which this agent acts as an authorized representative or sales agent. Defines the agents network affiliations and booking authority.',
    `standard_commission_rate` DECIMAL(18,2) COMMENT 'The default commission percentage or flat fee amount applied to transactions handled by the agent, expressed as a percentage (e.g., 5.00 for 5%) or monetary value depending on commission structure type.',
    `tax_identification_number` STRING COMMENT 'The agents tax registration number or VAT identification number issued by the relevant tax authority in their country of operation, used for invoicing and compliance reporting.',
    `trade_name` STRING COMMENT 'The commercial or trading name under which the agent operates in the market, which may differ from the legal name.',
    `transport_modes_supported` STRING COMMENT 'Comma-separated list of transport modes the agent is authorized and equipped to handle (e.g., air, ocean, road, rail, multimodal). Indicates the agents operational versatility across different freight types.',
    `website_url` STRING COMMENT 'The agents official website address, providing access to service information, contact details, and online booking capabilities.',
    CONSTRAINT pk_agent PRIMARY KEY(`agent_id`)
) COMMENT 'Master record for freight agents, general sales agents (GSAs), handling agents, and ground handling agents in the Transport Shipping partner network. Captures agent legal name, agent type (freight agent, GSA, handling agent, customs agent, co-loader), IATA agent code, FIATA membership, country and city of operation, principal carrier relationships, bonding and financial guarantee status, commission structure type, and operational scope. Agents are distinct from carriers — they act as intermediaries and representatives rather than transport operators.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`agent_appointment` (
    `agent_appointment_id` BIGINT COMMENT 'Unique identifier for the agent appointment record. Primary key for the agent appointment entity.',
    `agent_id` BIGINT COMMENT 'Identifier of the freight agent or General Sales Agent (GSA) being appointed to act on behalf of the appointing party.',
    `partner_id` BIGINT COMMENT 'Identifier of the party granting the appointment authority. May reference Transport Shipping or a carrier partner on whose behalf the appointment is made.',
    `renewed_agent_appointment_id` BIGINT COMMENT 'Self-referencing FK on agent_appointment (renewed_agent_appointment_id)',
    `aeo_certification_flag` BOOLEAN COMMENT 'Indicates whether the agent holds Authorized Economic Operator (AEO) certification, demonstrating secure and compliant supply chain practices. True means certified; False means not certified.',
    `appointment_effective_date` DATE COMMENT 'Date when the agent appointment becomes active and the agent is authorized to begin operations on behalf of the appointing party.',
    `appointment_expiry_date` DATE COMMENT 'Date when the agent appointment expires and the agent authority terminates. Nullable for open-ended appointments subject to termination notice.',
    `appointment_reference_number` STRING COMMENT 'External business reference number for the agent appointment, used in contracts and communications with the appointed agent.. Valid values are `^[A-Z0-9]{8,20}$`',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the agent appointment. Active indicates the agent is authorized to operate; suspended indicates temporary halt of authority; terminated indicates permanent revocation; expired indicates natural end of appointment term.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `appointment_term_months` STRING COMMENT 'Duration of the appointment term expressed in months. Used for fixed-term appointments. Null for indefinite appointments.',
    `appointment_type` STRING COMMENT 'Classification of the agent appointment indicating the nature of the agency relationship. GSA (General Sales Agent) represents full sales authority; freight agent handles specific services; correspondent provides local representation; sub-agent operates under another agent.. Valid values are `freight_agent|gsa|correspondent|sub_agent|exclusive_agent|non_exclusive_agent`',
    `approval_date` DATE COMMENT 'Date when the agent appointment was formally approved by the appointing party. Null if not yet approved.',
    `authorized_service_lines` STRING COMMENT 'Semicolon-separated list of service lines the agent is authorized to sell or manage. May include express parcel, air freight, ocean freight, road freight, rail freight, customs brokerage, warehousing, last-mile delivery, e-commerce fulfillment.',
    `authorized_transport_modes` STRING COMMENT 'Semicolon-separated list of transport modes the agent is authorized to handle. May include air, ocean, road, rail, multimodal.',
    `commission_basis` STRING COMMENT 'Basis on which the commission is calculated. Gross revenue includes all charges; net revenue excludes certain pass-through costs; margin is based on profit; per-shipment is fixed fee per transaction; tiered varies by volume thresholds.. Valid values are `gross_revenue|net_revenue|margin|per_shipment|tiered`',
    `commission_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which commission payments are denominated.. Valid values are `^[A-Z]{3}$`',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage commission rate paid to the agent on revenue generated within their territory and service scope. Expressed as percentage (e.g., 5.50 for 5.5%).',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the formal contract or agreement document governing this agent appointment. May link to document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agent appointment record was first created in the system. Immutable audit field.',
    `ctpat_certification_flag` BOOLEAN COMMENT 'Indicates whether the agent holds C-TPAT certification, a US Customs and Border Protection program for supply chain security. True means certified; False means not certified.',
    `customs_broker_license_flag` BOOLEAN COMMENT 'Indicates whether the agent holds a valid customs broker license, required for handling customs clearance and trade compliance services. True means licensed; False means not licensed.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the agent has exclusive rights to represent the appointing party in the defined territory. True means no other agents may be appointed in the same territory for the same services; False allows multiple agents.',
    `iata_accreditation_flag` BOOLEAN COMMENT 'Indicates whether the agent holds valid IATA accreditation, required for handling air freight and issuing Air Waybills (AWB). True means accredited; False means not accredited.',
    `iata_code` STRING COMMENT 'IATA-issued numeric code uniquely identifying the accredited cargo agent. Required for air freight operations. Null if agent is not IATA-accredited.. Valid values are `^[0-9]{7,8}$`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Minimum liability insurance coverage amount the agent must maintain, if required. Null if no insurance is required.',
    `insurance_coverage_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the insurance coverage amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `insurance_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether the agent is required to maintain liability insurance coverage as a condition of the appointment. True requires insurance; False does not.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the agent appointment record was last updated. Updated on every modification to track change history.',
    `minimum_revenue_commitment` DECIMAL(18,2) COMMENT 'Minimum revenue the agent commits to generate during the appointment term. Failure to meet this may trigger penalties or termination. Null if no minimum is specified.',
    `minimum_revenue_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the minimum revenue commitment is denominated.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or remarks related to the agent appointment. May include operational instructions, historical context, or exceptions.',
    `nvocc_license_flag` BOOLEAN COMMENT 'Indicates whether the agent holds a valid NVOCC license, required for ocean freight consolidation and issuing House Bills of Lading (HBL). True means licensed; False means not licensed.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the performance bond or financial guarantee required from the agent, if applicable. Null if no bond is required.',
    `performance_bond_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the performance bond amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `performance_bond_required_flag` BOOLEAN COMMENT 'Indicates whether the agent is required to post a performance bond or financial guarantee as a condition of the appointment. True requires bond; False does not.',
    `renewal_option` STRING COMMENT 'Terms under which the appointment may be renewed at expiry. Automatic renews unless terminated; mutual consent requires both parties to agree; appointing party option allows appointing party to renew unilaterally; agent option allows agent to renew; no renewal means appointment ends at expiry.. Valid values are `automatic|mutual_consent|appointing_party_option|agent_option|no_renewal`',
    `termination_date` DATE COMMENT 'Actual date when the appointment was terminated or suspended. Null for active appointments.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the appointment. Null if termination is not permitted or governed by other terms.',
    `termination_reason` STRING COMMENT 'Free-text explanation of the reason for termination or suspension of the appointment. Populated when appointment status changes to terminated or suspended.',
    `territory_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code defining the geographic territory where the agent is authorized to operate.. Valid values are `^[A-Z]{3}$`',
    `territory_region` STRING COMMENT 'Specific region, state, province, or sub-national area within the country where the agent appointment is valid. May include multiple regions separated by semicolons.',
    `territory_scope` STRING COMMENT 'Granularity level of the geographic territory covered by the appointment. National covers entire country; regional covers specific provinces/states; city/port/airport/station covers specific locations.. Valid values are `national|regional|city|port|airport|station`',
    CONSTRAINT pk_agent_appointment PRIMARY KEY(`agent_appointment_id`)
) COMMENT 'Formal appointment record authorizing a freight agent or GSA to act on behalf of Transport Shipping or a carrier partner in a defined territory or for a defined service scope. Captures appointment reference, appointing party, appointed agent, territory (country/region), authorized service lines, appointment start and expiry dates, commission rate agreed, exclusivity flag, performance bond requirement, and appointment status (active, suspended, terminated). Manages the lifecycle of agent authority grants across the network.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`interline_agreement` (
    `interline_agreement_id` BIGINT COMMENT 'Unique system identifier for the interline agreement record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the partner carrier organization with whom this interline agreement is established.',
    `renewed_interline_agreement_id` BIGINT COMMENT 'Self-referencing FK on interline_agreement (renewed_interline_agreement_id)',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the interline agreement, used in communications with partner carriers and operational systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the interline agreement. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|under_review — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the interline agreement defining the nature of the commercial relationship. SPA = Special Prorate Agreement. [ENUM-REF-CANDIDATE: interline|code_share|blocked_space|spa|prorate|joint_service|slot_exchange — 7 candidates stripped; promote to reference product]',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline agreement was formally approved and moved to active status.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this agreement automatically renews at expiry unless either party provides termination notice.',
    `awb_prefix_allocation` STRING COMMENT 'IATA-assigned three-digit AWB prefix(es) that may be used under this interline agreement for through-billing. Applicable to air cargo agreements.',
    `billing_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which interline settlements and revenue splits are calculated and paid.. Valid values are `^[A-Z]{3}$`',
    `commitment_period` STRING COMMENT 'Time period over which the minimum volume commitment is measured and enforced.. Valid values are `monthly|quarterly|annual|contract_term`',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a confidentiality or non-disclosure clause restricting the sharing of agreement terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline agreement record was first created in the system.',
    `destination_region` STRING COMMENT 'Geographic region or country codes where shipments are delivered under this agreement. May be comma-separated list of ISO 3166-1 alpha-3 country codes or regional identifiers.',
    `dispute_resolution_method` STRING COMMENT 'Agreed method for resolving disputes arising from this interline agreement. IATA arbitration refers to IATA arbitration procedures for cargo disputes.. Valid values are `litigation|arbitration|mediation|iata_arbitration`',
    `effective_date` DATE COMMENT 'Date on which this interline agreement becomes active and enforceable.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this agreement grants exclusive interline rights to the partner carrier for the specified trade lanes or service types.',
    `expiry_date` DATE COMMENT 'Date on which this interline agreement expires or terminates. Null if the agreement is open-ended or evergreen.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law under which this interline agreement is executed and disputes are resolved (e.g., New York, USA, England and Wales, Singapore).',
    `iata_prorate_rule_reference` STRING COMMENT 'Reference to specific IATA Resolution 780 prorate rule or tariff provision governing revenue allocation for air cargo interline agreements.',
    `insurance_requirement` STRING COMMENT 'Type of insurance coverage required or provided under this interline agreement for cargo in transit.. Valid values are `none|carrier_liability|cargo_insurance|all_risk`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline agreement record was last updated in the system.',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount per shipment or per unit weight that each carrier assumes under this interline agreement. Confidential commercial term.',
    `liability_limit_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the liability limit amount.. Valid values are `^[A-Z]{3}$`',
    `minimum_volume_commitment` DECIMAL(18,2) COMMENT 'Minimum shipment volume (in TEU, tons, or shipment count depending on mode) that Transport Shipping commits to provide under this agreement within the commitment period. Confidential commercial term.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational instructions related to this interline agreement.',
    `origin_region` STRING COMMENT 'Geographic region or country codes where shipments originate under this agreement. May be comma-separated list of ISO 3166-1 alpha-3 country codes or regional identifiers.',
    `penalty_for_non_compliance` STRING COMMENT 'Description of financial or operational penalties applied if either party fails to meet volume commitments or SLA targets. Confidential commercial term.',
    `performance_review_frequency` STRING COMMENT 'Frequency at which the parties conduct formal performance reviews of the interline agreement against SLA commitments and volume targets.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `prorate_methodology` STRING COMMENT 'Method used to allocate revenue between carriers for through-shipments. IATA standard refers to IATA Resolution 780 prorate rules.. Valid values are `mileage|segment|proportional|fixed|negotiated|iata_standard`',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that either party must provide notice if they wish to terminate or renegotiate the agreement.',
    `revenue_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of total revenue allocated to Transport Shipping under this agreement. Remaining percentage goes to partner carrier. Confidential commercial term.',
    `service_type` STRING COMMENT 'Type of logistics service covered under the agreement. LTL = Less Than Truckload, FTL = Full Truckload, FCL = Full Container Load, LCL = Less Than Container Load. [ENUM-REF-CANDIDATE: express|freight|parcel|ltl|ftl|fcl|lcl|bulk — 8 candidates stripped; promote to reference product]',
    `settlement_frequency` STRING COMMENT 'Frequency at which interline revenue settlements are calculated and exchanged between Transport Shipping and the partner carrier.. Valid values are `weekly|biweekly|monthly|quarterly`',
    `sla_on_time_delivery_target_pct` DECIMAL(18,2) COMMENT 'Target percentage for on-time delivery performance that both carriers commit to achieve under this interline agreement.',
    `suspension_reason` STRING COMMENT 'Business reason for suspension if agreement_status is suspended. Examples: partner non-compliance, volume shortfall, regulatory restriction, operational disruption.',
    `termination_date` DATE COMMENT 'Actual date on which the agreement was terminated, if applicable. Distinct from expiry_date which is the planned end date.',
    `termination_reason` STRING COMMENT 'Business reason for early termination if the agreement was terminated before its expiry date. Examples: breach of contract, strategic realignment, partner insolvency, regulatory change.',
    `through_billing_enabled` BOOLEAN COMMENT 'Indicates whether this agreement permits through-billing, where a single AWB or BOL covers the entire journey across both carriers networks.',
    `trade_lanes_covered` STRING COMMENT 'Geographic trade lanes or route corridors covered by this agreement, typically expressed as origin-destination pairs or regional groupings (e.g., USA-EUR, APAC-LATAM, Transatlantic).',
    `transport_mode` STRING COMMENT 'Primary mode of transportation covered by this interline agreement.. Valid values are `air|ocean|road|rail|multimodal`',
    `volume_commitment_unit` STRING COMMENT 'Unit of measure for the minimum volume commitment. TEU = Twenty-foot Equivalent Unit, CBM = Cubic Meter.. Valid values are `teu|ton|kg|cbm|shipment_count|pallet`',
    CONSTRAINT pk_interline_agreement PRIMARY KEY(`interline_agreement_id`)
) COMMENT 'Master record for interline agreements between Transport Shipping and partner carriers enabling the exchange of traffic, co-loading, and through-billing across carrier networks. Captures agreement reference, partner carrier, agreement type (interline, code-share, blocked space, SPA — Special Prorate Agreement), transport mode, trade lanes covered, prorate methodology, revenue split terms, minimum volume commitments, IATA prorate rules reference, effective and expiry dates, and agreement status. Governs the commercial and operational terms for traffic interchange.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`tpl_provider` (
    `tpl_provider_id` BIGINT COMMENT 'Unique identifier for the third-party logistics provider record. Primary key.',
    `parent_tpl_provider_id` BIGINT COMMENT 'Self-referencing FK on tpl_provider (parent_tpl_provider_id)',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: TPL provider is an external organization in the network that should reference the unified partner master. This enables consistent partner lifecycle management across all partner types. No columns remo',
    `aeo_certified` BOOLEAN COMMENT 'Indicates whether the provider holds Authorized Economic Operator (AEO) certification for trusted trader status in international trade.',
    `api_integration_available` BOOLEAN COMMENT 'Indicates whether the provider offers API (Application Programming Interface) integration for real-time data exchange and system connectivity.',
    `cold_chain_capability` BOOLEAN COMMENT 'Indicates whether the provider has temperature-controlled logistics capabilities for perishable or pharmaceutical goods.',
    `contract_end_date` DATE COMMENT 'Expiration or termination date of the current master service agreement with the provider, if applicable.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current master service agreement or partnership contract with the provider.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this provider record was first created in the system.',
    `ctpat_certified` BOOLEAN COMMENT 'Indicates whether the provider is certified under the U.S. Customs-Trade Partnership Against Terrorism (C-TPAT) program for supply chain security.',
    `customs_brokerage_capability` BOOLEAN COMMENT 'Indicates whether the provider offers customs brokerage and trade compliance services for cross-border shipments.',
    `distribution_capability` BOOLEAN COMMENT 'Indicates whether the provider offers distribution and order fulfillment services.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet DUNS number uniquely identifying the provider for credit and business verification purposes.. Valid values are `^[0-9]{9}$`',
    `edi_capability` BOOLEAN COMMENT 'Indicates whether the provider supports Electronic Data Interchange (EDI) for automated transaction processing and data exchange.',
    `financial_rating` STRING COMMENT 'Credit or financial strength rating assigned to the provider by a recognized rating agency or internal risk assessment. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D|not_rated — 11 candidates stripped; promote to reference product]',
    `gdp_certified` BOOLEAN COMMENT 'Indicates whether the provider holds Good Distribution Practice (GDP) certification for pharmaceutical and healthcare logistics.',
    `geographic_coverage` STRING COMMENT 'Description of the providers geographic footprint and service coverage areas, including countries, regions, or specific trade lanes served.',
    `haccp_certified` BOOLEAN COMMENT 'Indicates whether the provider holds HACCP (Hazard Analysis and Critical Control Points) certification for food safety and cold chain management.',
    `headquarters_address_line1` STRING COMMENT 'First line of the providers headquarters street address including building number and street name.',
    `headquarters_city` STRING COMMENT 'City where the providers headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the providers headquarters location.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the providers headquarters address.',
    `headquarters_state_province` STRING COMMENT 'State, province, or administrative region where the providers headquarters is located.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total liability insurance coverage amount in USD maintained by the provider for cargo and operational risks.',
    `iso_28000_certified` BOOLEAN COMMENT 'Indicates whether the provider holds ISO 28000 certification for supply chain security management.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the provider holds ISO 9001 certification for quality management systems.',
    `last_mile_delivery_capability` BOOLEAN COMMENT 'Indicates whether the provider offers last-mile delivery services to end customers or consignees.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this provider record was last updated or modified.',
    `legal_name` STRING COMMENT 'Full legal registered name of the third-party logistics provider as it appears on official business documents and contracts.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the provider relationship and operational considerations.',
    `onboarding_date` DATE COMMENT 'Date when the provider was officially onboarded and approved to begin operations within the Transport Shipping partner network.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the provider relationship indicating whether the provider is actively engaged, suspended, or in transition.. Valid values are `active|inactive|suspended|onboarding|offboarding|pending_approval`',
    `performance_score` DECIMAL(18,2) COMMENT 'Composite performance score (0-100) evaluating the providers operational performance based on KPIs such as on-time delivery, accuracy, and service quality.',
    `preferred_provider_flag` BOOLEAN COMMENT 'Indicates whether the provider has been designated as a preferred or strategic partner based on performance, capabilities, and relationship strength.',
    `primary_contact_email` STRING COMMENT 'Primary email address for operational communications with the providers account management or operations team.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the providers operations or account management team.',
    `provider_code` STRING COMMENT 'Externally-known unique business identifier code for the 3PL/4PL provider, used in operational systems and partner communications.. Valid values are `^[A-Z0-9]{4,12}$`',
    `provider_type` STRING COMMENT 'Classification of the logistics provider based on service model: 3PL (Third-Party Logistics), 4PL (Fourth-Party Logistics), co-packer, value-added logistics provider, freight forwarder, or NVOCC (Non-Vessel Operating Common Carrier).. Valid values are `3PL|4PL|co-packer|value-added logistics|freight forwarder|NVOCC`',
    `reverse_logistics_capability` BOOLEAN COMMENT 'Indicates whether the provider offers reverse logistics services including returns management and RMA (Return Merchandise Authorization) processing.',
    `tax_identification_number` STRING COMMENT 'Tax identification number or employer identification number (EIN) for the provider in their country of registration.',
    `tms_platform` STRING COMMENT 'Name and version of the Transportation Management System (TMS) platform used by the provider for shipment execution and freight management.',
    `total_warehouse_sqft` DECIMAL(18,2) COMMENT 'Total warehouse and distribution center space in square feet managed by the provider across all facilities.',
    `trade_name` STRING COMMENT 'Operating or trade name under which the provider conducts business, if different from legal name.',
    `value_added_services` STRING COMMENT 'Comma-separated list of value-added logistics services offered by the provider such as kitting, labeling, packaging, assembly, quality inspection, or co-packing.',
    `warehousing_capability` BOOLEAN COMMENT 'Indicates whether the provider offers warehousing and storage services as part of their operational capabilities.',
    `wms_platform` STRING COMMENT 'Name and version of the Warehouse Management System (WMS) platform used by the provider for inventory control and order fulfillment.',
    CONSTRAINT pk_tpl_provider PRIMARY KEY(`tpl_provider_id`)
) COMMENT 'Master record for third-party logistics (3PL) and fourth-party logistics (4PL) providers in the Transport Shipping partner network. Captures provider legal name, provider type (3PL, 4PL, co-packer, value-added logistics provider), operational capabilities (warehousing, distribution, customs brokerage, last-mile, cold chain), geographic footprint, technology platform integrations, certifications (ISO, GDP, HACCP), financial standing, and onboarding status. Distinct from carriers (who move goods) — 3PL/4PL providers manage logistics operations on behalf of shippers.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner` (
    `partner_id` BIGINT COMMENT 'Unique identifier for the network partner record. Primary key.',
    `parent_partner_id` BIGINT COMMENT 'Self-referencing FK on partner (parent_partner_id)',
    `address_line_1` STRING COMMENT 'First line of the partners primary business address, typically containing street number and name.',
    `address_line_2` STRING COMMENT 'Second line of the partners primary business address, typically containing building, suite, or unit information.',
    `aeo_certification` STRING COMMENT 'AEO certification number indicating the partner has been certified as a secure and compliant supply chain participant.',
    `audit_status` STRING COMMENT 'Result or status of the most recent audit conducted on the partner.. Valid values are `passed|failed|pending|not_required`',
    `bonded_warehouse_license` STRING COMMENT 'License number issued by customs authorities authorizing the partner to operate a bonded warehouse facility.',
    `city` STRING COMMENT 'City or municipality of the partners primary business address.',
    `contract_expiry_date` DATE COMMENT 'Date when the current partnership agreement or contract with the partner is scheduled to expire.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the partners primary country of operations or registration.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the network partner record was first created in the system.',
    `credit_rating` STRING COMMENT 'Credit rating or financial stability assessment of the partner organization, used for risk management and credit decisions.',
    `ctpat_certification` STRING COMMENT 'C-TPAT certification number indicating the partner has been certified under the US CBP security program.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the partners preferred billing and settlement currency.. Valid values are `^[A-Z]{3}$`',
    `customs_broker_license` STRING COMMENT 'License or registration number issued by customs authorities authorizing the partner to perform customs brokerage services.',
    `facility_type` STRING COMMENT 'Type of facility operated by the partner, such as Container Freight Station (CFS), Inland Container Depot (ICD), Free Trade Zone (FTZ), or bonded warehouse.',
    `handling_capacity` STRING COMMENT 'Description of the partners handling capacity, such as TEU capacity for container facilities or tonnage capacity for freight stations.',
    `iata_code` STRING COMMENT 'Three-letter IATA code assigned to the partner if they are an airport, airline, or air cargo handler.. Valid values are `^[A-Z]{3}$`',
    `icao_code` STRING COMMENT 'Four-letter ICAO code assigned to the partner if they are an airport or aviation facility.. Valid values are `^[A-Z]{4}$`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total insurance coverage amount maintained by the partner for liability, cargo damage, and operational risks.',
    `insurance_expiry_date` DATE COMMENT 'Expiry date of the partners current insurance policy coverage.',
    `iso_certification` STRING COMMENT 'ISO certification numbers held by the partner, such as ISO 9001 (Quality Management) or ISO 28000 (Supply Chain Security).',
    `last_audit_date` DATE COMMENT 'Date of the most recent operational or compliance audit conducted on the partner.',
    `legal_name` STRING COMMENT 'Full legal registered name of the partner organization as it appears on official documents and contracts.',
    `network_participation_date` DATE COMMENT 'Date when the partner was onboarded and began participating in the Transport Shipping logistics network.',
    `notes` STRING COMMENT 'Free-text notes or comments about the partner, including special handling instructions, relationship history, or operational considerations.',
    `operating_hours` STRING COMMENT 'Standard operating hours or schedule for the partners facility or service operations.',
    `operational_scope` STRING COMMENT 'Description of the partners operational capabilities, service offerings, and geographic coverage within the logistics network.',
    `partner_category` STRING COMMENT 'Classification of the partner type within the logistics network. Defines the operational role and service scope of the partner.. Valid values are `port_authority|airport_ground_handler|customs_broker|bonded_warehouse|freight_station|co_loading_partner`',
    `partner_code` STRING COMMENT 'Externally-known unique business identifier for the partner, used in operational systems and documentation.. Valid values are `^[A-Z0-9]{6,12}$`',
    `partner_status` STRING COMMENT 'Current lifecycle status of the partner relationship within the network.. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the partner, such as net 30, net 60, or prepayment requirements.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the partners primary business address.',
    `primary_contact_email` STRING COMMENT 'Primary email address for operational communication with the partner organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for operational communication with the partner organization.',
    `registration_number` STRING COMMENT 'Official business registration or incorporation number issued by the government authority in the partners country of registration.',
    `risk_level` STRING COMMENT 'Assessed risk level of the partner based on financial stability, compliance history, operational performance, and security factors.. Valid values are `low|medium|high|critical`',
    `service_modes` STRING COMMENT 'Transport modes and service types supported by the partner (e.g., air, ocean, road, rail, multimodal).',
    `state_province` STRING COMMENT 'State, province, or administrative region of the partners primary business address.',
    `tax_identification_number` STRING COMMENT 'Tax identification number or VAT registration number used for fiscal and customs purposes.',
    `trade_name` STRING COMMENT 'Operating or trade name used by the partner in day-to-day business operations, if different from legal name.',
    `un_locode` STRING COMMENT 'Five-character UN/LOCODE identifying the partners location for trade and transport purposes.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}$`',
    `updated_by` STRING COMMENT 'User identifier or system name that last modified the network partner record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the network partner record was last modified in the system.',
    `website_url` STRING COMMENT 'Official website URL of the partner organization.',
    CONSTRAINT pk_partner PRIMARY KEY(`partner_id`)
) COMMENT 'Unified master record representing any external organization participating in the Transport Shipping logistics network beyond carriers and 3PL providers — including port authorities, airport ground handlers, customs brokers, bonded warehouse operators, freight stations (CFS/ICD), and co-loading partners. Captures partner legal name, partner category, country, regulatory registrations, operational scope, contact details, and network participation status. Acts as the umbrella partner identity record for network participants not covered by the carrier or 3PL provider masters.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_certification` (
    `partner_certification_id` BIGINT COMMENT 'Unique identifier for the partner certification record. Primary key.',
    `partner_id` BIGINT COMMENT 'Reference to the network partner (carrier, agent, 3PL provider, correspondent office) holding this certification.',
    `renewed_partner_certification_id` BIGINT COMMENT 'Self-referencing FK on partner_certification (renewed_partner_certification_id)',
    `accreditation_body` STRING COMMENT 'The name of the accreditation body that accredited the issuing authority or certification body (e.g., UKAS, ANAB, DAkkS). Applicable primarily to ISO certifications where the certification body itself must be accredited.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this certification record is currently active and should be considered in partner compliance checks. True if active, False if logically deleted or archived.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the certification is set up for automatic renewal by the partner or issuing authority. True if auto-renewal is enabled, False otherwise.',
    `certification_document_url` STRING COMMENT 'URL or file path to the digital copy of the certification certificate or official documentation stored in the document management system.',
    `certification_number` STRING COMMENT 'The unique certificate or registration number issued by the certifying authority. This is the externally-known identifier for the certification.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Indicates whether the certification is valid and in good standing. Values: active (valid and current), expired (past expiry date), suspended (temporarily invalid), pending_renewal (renewal application submitted), revoked (permanently invalidated), under_review (initial application or audit in progress).. Valid values are `active|expired|suspended|pending_renewal|revoked|under_review`',
    `certification_type` STRING COMMENT 'The type or category of certification held by the partner. Indicates the regulatory, industry, or quality standard framework. Values: IATA (International Air Transport Association), AEO (Authorized Economic Operator), C-TPAT (Customs-Trade Partnership Against Terrorism), ISO_9001 (Quality Management System), GDP (Good Distribution Practice), TAPA (Transported Asset Protection Association), SmartWay (EPA environmental certification), FIATA (International Federation of Freight Forwarders Associations). [ENUM-REF-CANDIDATE: IATA|AEO|C-TPAT|ISO_9001|GDP|TAPA|SmartWay|FIATA — 8 candidates stripped; promote to reference product]',
    `compliance_level` STRING COMMENT 'The tier, level, or grade of certification achieved, if the certification framework has multiple levels (e.g., AEO has different tiers in some jurisdictions; TAPA has Class A, B, C security levels). Nullable if certification has no levels.',
    `created_by_user` STRING COMMENT 'The username or user identifier of the person or system that created this certification record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_date` DATE COMMENT 'The date from which the certification becomes valid and enforceable. May differ from issue_date if there is a grace period. Format: yyyy-MM-dd.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid unless renewed. Nullable for certifications with indefinite validity. Format: yyyy-MM-dd.',
    `geographic_scope` STRING COMMENT 'The geographic coverage or jurisdictional scope of the certification. May specify countries, regions, or specific facility locations where the certification is valid (e.g., EU member states for AEO, specific warehouse locations for TAPA).',
    `issue_date` DATE COMMENT 'The date on which the certification was originally issued or granted to the partner. Format: yyyy-MM-dd.',
    `issuing_authority` STRING COMMENT 'The name of the regulatory body, industry association, or certification organization that issued the certification (e.g., IATA, US Customs and Border Protection, ISO certification body, national customs authority).',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction or country where the certification was issued (e.g., USA, GBR, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `last_audit_date` DATE COMMENT 'The date of the most recent compliance audit or verification inspection conducted by the issuing authority or third-party auditor. Format: yyyy-MM-dd.',
    `last_modified_by_user` STRING COMMENT 'The username or user identifier of the person or system that last modified this certification record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mandatory_for_commodity_types` STRING COMMENT 'Comma-separated list of commodity types or HS Code (Harmonized System Code) categories for which this certification is required. Used to ensure only certified partners handle regulated goods (e.g., GDP for pharmaceuticals, IATA for dangerous goods).',
    `mandatory_for_trade_lanes` STRING COMMENT 'Comma-separated list of trade lane codes or route identifiers for which this certification is mandatory. Used to enforce compliance rules in partner selection and shipment routing (e.g., US_IMPORT requires C-TPAT, EU_EXPORT requires AEO).',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next compliance audit or surveillance visit. Used for proactive compliance monitoring. Format: yyyy-MM-dd.',
    `non_compliance_notes` STRING COMMENT 'Free-text notes documenting any non-compliance findings, audit observations, corrective action requests, or conditions attached to the certification. Used for compliance tracking and partner performance management.',
    `reinstatement_date` DATE COMMENT 'The date on which a previously suspended or revoked certification was reinstated to active status. Nullable if never reinstated. Format: yyyy-MM-dd.',
    `renewal_due_date` DATE COMMENT 'The date by which the partner must submit renewal application or documentation to maintain certification. Typically precedes expiry_date. Format: yyyy-MM-dd.',
    `renewal_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a renewal reminder notification has been sent to the partner or internal compliance team. True if notification sent, False otherwise.',
    `risk_rating` STRING COMMENT 'Internal risk assessment rating assigned based on the certification status and compliance history. Values: low (certification valid and in good standing), medium (approaching expiry or minor compliance issues), high (expired or suspended), critical (revoked or under investigation).. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Detailed description of the scope of the certification, including covered activities, services, locations, or product categories. For example, ISO 9001 scope may specify freight forwarding services at specific facilities; AEO may cover customs clearance and warehousing.',
    `source_system` STRING COMMENT 'The name of the operational system or data source from which this certification record originated (e.g., SAP TM, Oracle TMS, Descartes Customs, manual entry).',
    `suspension_date` DATE COMMENT 'The date on which the certification was suspended or revoked by the issuing authority. Nullable if certification has never been suspended. Format: yyyy-MM-dd.',
    `suspension_reason` STRING COMMENT 'Reason for certification suspension or revocation, if applicable. Captures the cause of status change to suspended or revoked (e.g., failed audit, regulatory violation, voluntary withdrawal).',
    `verification_date` DATE COMMENT 'The date on which Transport Shipping last verified the validity and authenticity of this certification with the issuing authority or through official registries. Format: yyyy-MM-dd.',
    `verification_method` STRING COMMENT 'The method used by Transport Shipping to verify the authenticity and current status of the certification. Values: online_registry (checked official online database), issuer_confirmation (direct confirmation from issuing authority), document_review (reviewed physical or digital certificate), third_party_audit (verified by independent auditor), self_declaration (partner self-reported, pending verification).. Valid values are `online_registry|issuer_confirmation|document_review|third_party_audit|self_declaration`',
    CONSTRAINT pk_partner_certification PRIMARY KEY(`partner_certification_id`)
) COMMENT 'Master record tracking all regulatory, industry, and quality certifications held by network partners (carriers, agents, 3PL providers, correspondent offices). Captures partner reference, certification type (IATA, AEO, C-TPAT, ISO 9001, GDP, TAPA, SmartWay, FIATA), issuing authority, certificate number, issue date, expiry date, renewal status, and compliance verification date. Enables partner compliance monitoring and ensures only certified partners are used for regulated trade lanes and commodity types.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_performance` (
    `partner_performance_id` BIGINT COMMENT 'Unique identifier for the partner performance evaluation record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the carrier agreement or partnership contract under which this performance is being evaluated.',
    `partner_id` BIGINT COMMENT 'Reference to the network partner being evaluated (carrier, agent, 3PL, NVOCC, correspondent office).',
    `prior_partner_performance_id` BIGINT COMMENT 'Self-referencing FK on partner_performance (prior_partner_performance_id)',
    `approval_status` STRING COMMENT 'Current approval status of the performance evaluation record in the review workflow.. Valid values are `draft|pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the performance evaluation was approved.',
    `capacity_fulfillment_actual_pct` DECIMAL(18,2) COMMENT 'Actual percentage of requested capacity that the partner was able to fulfill during the evaluation period.',
    `capacity_fulfillment_target_pct` DECIMAL(18,2) COMMENT 'Target percentage for capacity fulfillment as per partner agreement.',
    `claims_rate_actual_pct` DECIMAL(18,2) COMMENT 'Actual percentage of shipments resulting in claims (loss, damage, delay) during the evaluation period.',
    `claims_rate_target_pct` DECIMAL(18,2) COMMENT 'Maximum acceptable claims rate threshold as per partner agreement.',
    `composite_score` DECIMAL(18,2) COMMENT 'Weighted composite score aggregating all performance dimensions into a single overall performance rating (0-100 scale).',
    `corrective_action_due_date` DATE COMMENT 'Date by which the partner must submit or complete corrective action plan if required.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action plan is required from the partner based on performance deficiencies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this performance evaluation record was first created in the system.',
    `damage_rate_actual_pct` DECIMAL(18,2) COMMENT 'Actual percentage of shipments with damage incidents during the evaluation period.',
    `damage_rate_target_pct` DECIMAL(18,2) COMMENT 'Maximum acceptable damage rate threshold as per partner agreement.',
    `documentation_accuracy_actual_pct` DECIMAL(18,2) COMMENT 'Actual percentage of shipments with accurate and complete documentation (AWB, BOL, customs paperwork) during the evaluation period.',
    `documentation_accuracy_target_pct` DECIMAL(18,2) COMMENT 'Target percentage for documentation accuracy as per partner agreement.',
    `evaluation_completed_date` DATE COMMENT 'Date when the performance evaluation was completed and finalized.',
    `evaluation_frequency` STRING COMMENT 'Frequency at which this partner performance evaluation is conducted.. Valid values are `monthly|quarterly|semi-annual|annual|ad-hoc`',
    `evaluation_period_end_date` DATE COMMENT 'End date of the measurement period for this performance evaluation.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the measurement period for this performance evaluation.',
    `geographic_scope` STRING COMMENT 'Geographic scope of operations covered by this performance evaluation.. Valid values are `domestic|regional|international|global`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this performance evaluation record was last updated.',
    `otd_rate_actual_pct` DECIMAL(18,2) COMMENT 'Actual on-time delivery rate achieved by the partner during the evaluation period, expressed as a percentage.',
    `otd_rate_target_pct` DECIMAL(18,2) COMMENT 'Target on-time delivery rate contracted with the partner, expressed as a percentage.',
    `review_notes` STRING COMMENT 'Detailed notes and commentary from the performance review, including strengths, weaknesses, and improvement actions.',
    `review_outcome` STRING COMMENT 'Business decision outcome resulting from this performance evaluation (continue partnership, renew contract, place on probation, terminate, escalate for executive review).. Valid values are `continue|renew|probation|terminate|escalate`',
    `service_mode` STRING COMMENT 'Primary transport mode for which this partner performance is being evaluated.. Valid values are `air|ocean|road|rail|multimodal`',
    `total_shipments_evaluated` BIGINT COMMENT 'Total number of shipments handled by the partner during the evaluation period that were included in this performance assessment.',
    `total_volume_teu` DECIMAL(18,2) COMMENT 'Total volume handled by the partner during the evaluation period, measured in TEU for ocean freight partners.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight handled by the partner during the evaluation period, measured in kilograms.',
    `transit_time_compliance_actual_pct` DECIMAL(18,2) COMMENT 'Actual percentage of shipments meeting contracted transit time commitments during the evaluation period.',
    `transit_time_compliance_target_pct` DECIMAL(18,2) COMMENT 'Target percentage for transit time compliance as per partner agreement.',
    `trend_direction` STRING COMMENT 'Overall performance trend direction compared to the previous evaluation period.. Valid values are `improving|stable|declining`',
    CONSTRAINT pk_partner_performance PRIMARY KEY(`partner_performance_id`)
) COMMENT 'Periodic operational performance record evaluating network partner performance against contracted KPIs and service standards. Captures partner reference, measurement period, performance dimensions (OTD rate, transit time compliance, damage rate, documentation accuracy, claims rate, capacity fulfillment rate), actual vs. target values, performance tier (preferred, approved, probation, suspended), trend direction, and review outcome. Drives partner tiering decisions, contract renewals, and network optimization. Distinct from contract SLA performance — this is the network-level partner scorecard.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` (
    `capacity_allocation_id` BIGINT COMMENT 'Unique identifier for the capacity allocation record. Primary key for the capacity allocation entity.',
    `blocked_space_agreement_id` BIGINT COMMENT 'Foreign key linking to network.blocked_space_agreement. Business justification: Capacity allocations are often drawn from blocked space agreement commitments. This link enables tracking of BSA utilization and ensures allocations are tied to contractual capacity commitments. Nulla',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or third-party logistics (3PL) provider from whom capacity is allocated.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Capacity allocations should reference the specific carrier service on which capacity is allocated, not just the carrier. This enables service-level capacity tracking and planning. Removes service_type',
    `agreement_id` BIGINT COMMENT 'Reference to the master carrier agreement or partnership contract under which this capacity allocation is governed.',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity (agent, correspondent office, NVOCC) providing the capacity allocation.',
    `revised_capacity_allocation_id` BIGINT COMMENT 'Self-referencing FK on capacity_allocation (revised_capacity_allocation_id)',
    `lane_id` BIGINT COMMENT 'Reference to the trade lane (origin-destination corridor) for which capacity is allocated.',
    `allocated_capacity_pallet_positions` STRING COMMENT 'Total pallet position capacity allocated by the carrier or partner for the specified period and trade lane. Applicable to road and rail freight.',
    `allocated_capacity_teu` DECIMAL(18,2) COMMENT 'Total container capacity allocated by the carrier for the specified period and trade lane, measured in TEU. Applicable to ocean freight (FCL shipments).',
    `allocated_capacity_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume capacity allocated by the carrier or partner for the specified period and trade lane, measured in cubic meters. Applicable to all transport modes.',
    `allocated_capacity_weight_kg` DECIMAL(18,2) COMMENT 'Total weight capacity allocated by the carrier or partner for the specified period and trade lane, measured in kilograms. Applicable primarily to air and road freight.',
    `allocation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any financial terms associated with the capacity allocation (e.g., minimum commitment charges, overage fees).. Valid values are `^[A-Z]{3}$`',
    `allocation_end_date` DATE COMMENT 'The date when the capacity allocation expires or is no longer available for booking. Nullable for open-ended allocations.',
    `allocation_notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational instructions related to the capacity allocation.',
    `allocation_period_type` STRING COMMENT 'Frequency or granularity of the capacity allocation period: daily, weekly, monthly, quarterly, or annual allocation cycle.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `allocation_reference_number` STRING COMMENT 'External business identifier for the capacity allocation, typically provided by the carrier or partner for tracking and reconciliation purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `allocation_start_date` DATE COMMENT 'The date when the capacity allocation becomes effective and available for booking.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the capacity allocation: active (available for booking), reserved (held but not yet utilized), utilized (fully consumed), expired (past end date), cancelled (terminated early), or suspended (temporarily unavailable).. Valid values are `active|reserved|utilized|expired|cancelled|suspended`',
    `booking_cutoff_hours` STRING COMMENT 'Number of hours before departure or shipment date by which bookings must be made to utilize this capacity allocation.',
    `capacity_fill_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of allocated capacity that has been utilized during the period, calculated as (utilized / allocated) * 100. Key performance indicator for capacity procurement efficiency.',
    `capacity_source_type` STRING COMMENT 'Type of capacity procurement arrangement: blocked space agreement (BSA), allotment, spot market purchase, long-term contract, or ad-hoc allocation.. Valid values are `blocked_space|allotment|spot|contract|ad_hoc`',
    `commodity_restriction` STRING COMMENT 'Restrictions on commodity types that can be shipped using this capacity allocation (e.g., general cargo only, no hazardous materials, perishables only). Nullable if no restrictions apply.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capacity allocation record was first created in the system.',
    `destination_location_code` STRING COMMENT 'Three-letter IATA or UN/LOCODE representing the destination point of the capacity allocation (airport, seaport, or inland terminal).. Valid values are `^[A-Z]{3}$`',
    `equipment_type` STRING COMMENT 'Type of equipment or container associated with the capacity allocation (e.g., 20ft dry container, 40ft reefer, ULD type for air freight). Nullable if not equipment-specific. [ENUM-REF-CANDIDATE: 20ft_dry|40ft_dry|40ft_hc|20ft_reefer|40ft_reefer|flat_rack|open_top|tank|AKE|LD3|LD7|PMC — promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the capacity allocation record was last updated or modified.',
    `minimum_commitment_amount` DECIMAL(18,2) COMMENT 'Minimum financial commitment or guaranteed payment amount for the capacity allocation, regardless of utilization. Nullable if no minimum commitment exists.',
    `origin_location_code` STRING COMMENT 'Three-letter IATA or UN/LOCODE representing the origin point of the capacity allocation (airport, seaport, or inland terminal).. Valid values are `^[A-Z]{3}$`',
    `overage_rate_per_unit` DECIMAL(18,2) COMMENT 'Additional charge per unit (kg, TEU, CBM, pallet) if utilization exceeds the allocated capacity. Nullable if overage is not permitted or not charged.',
    `priority_level` STRING COMMENT 'Priority level assigned to this capacity allocation for booking and space allocation purposes: high (premium access), medium (standard access), low (space-available), or standard (default priority).. Valid values are `high|medium|low|standard`',
    `rollover_allowed_flag` BOOLEAN COMMENT 'Indicates whether unused capacity from the current allocation period can be rolled over to the next period. True if rollover is permitted, false otherwise.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which the capacity allocation data originated (e.g., SAP TM, Oracle TMS, Blue Yonder, manual entry, API integration).. Valid values are `SAP_TM|ORACLE_TMS|BLUE_YONDER|MANUAL|API`',
    `utilized_capacity_pallet_positions` STRING COMMENT 'Actual pallet position capacity utilized or booked against the allocation during the period.',
    `utilized_capacity_teu` DECIMAL(18,2) COMMENT 'Actual container capacity utilized or booked against the allocation during the period, measured in TEU.',
    `utilized_capacity_volume_cbm` DECIMAL(18,2) COMMENT 'Actual volume capacity utilized or booked against the allocation during the period, measured in cubic meters.',
    `utilized_capacity_weight_kg` DECIMAL(18,2) COMMENT 'Actual weight capacity utilized or booked against the allocation during the period, measured in kilograms.',
    CONSTRAINT pk_capacity_allocation PRIMARY KEY(`capacity_allocation_id`)
) COMMENT 'Transactional record capturing the allocation of transport capacity from a carrier or 3PL partner to Transport Shipping for a defined period, trade lane, and service type. Captures carrier or partner reference, trade lane, transport mode, service type, allocation period (weekly/monthly), allocated capacity (kg, TEU, CBM, pallet positions), utilized capacity, fill rate, capacity source (blocked space, allotment, spot), and allocation status. Enables capacity planning, utilization monitoring, and carrier capacity procurement management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` (
    `blocked_space_agreement_id` BIGINT COMMENT 'Unique identifier for the blocked space agreement record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the ocean or air carrier party with whom Transport Shipping has contracted this blocked space agreement.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Blocked space agreements are typically tied to specific carrier services (e.g., weekly Asia-Europe ocean service, daily air freight service). This link enables service-level capacity management and re',
    `renewed_blocked_space_agreement_id` BIGINT COMMENT 'Self-referencing FK on blocked_space_agreement (renewed_blocked_space_agreement_id)',
    `lane_id` BIGINT COMMENT 'Reference to the specific trade lane (origin-destination corridor) covered by this blocked space agreement, such as Asia-Europe or Trans-Pacific.',
    `agreement_reference_number` STRING COMMENT 'The externally-known business identifier or contract number for this blocked space agreement, used in communications with the carrier and internal stakeholders.',
    `agreement_type` STRING COMMENT 'Classification of the blocked space agreement by transport mode and service type. Ocean FCL (Full Container Load), Ocean LCL (Less Than Container Load), Air Freight, or Multimodal.. Valid values are `ocean_fcl|ocean_lcl|air_freight|multimodal`',
    `allocation_frequency` STRING COMMENT 'The frequency at which the guaranteed capacity is allocated or refreshed (e.g., weekly allocation of 100 TEU, monthly allocation of 50,000 kg).. Valid values are `weekly|biweekly|monthly|quarterly|per_voyage|per_flight`',
    `base_rate_per_unit` DECIMAL(18,2) COMMENT 'The base freight rate per unit of capacity (per TEU, per kg, per CBM) agreed in this blocked space agreement. Subject to surcharges and adjustments.',
    `blocked_space_agreement_status` STRING COMMENT 'Current lifecycle status of the blocked space agreement. Draft indicates under negotiation; Active indicates in force; Suspended indicates temporarily paused; Expired indicates past end date; Terminated indicates cancelled before expiry; Pending Renewal indicates approaching expiry with renewal in progress.. Valid values are `draft|active|suspended|expired|terminated|pending_renewal`',
    `capacity_unit_of_measure` STRING COMMENT 'Primary unit of measure used to express the guaranteed capacity in this agreement: TEU for ocean containers, kg or CBM for air freight, or pallets for specialized services.. Valid values are `TEU|kg|CBM|pallets`',
    `created_by_user` STRING COMMENT 'Identifier or name of the user who created this blocked space agreement record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this blocked space agreement record was first created in the system.',
    `destination_region` STRING COMMENT 'Geographic region or port cluster to which the blocked space capacity is destined (e.g., Mediterranean, Middle East, US East Coast).',
    `dispute_resolution_mechanism` STRING COMMENT 'The agreed mechanism for resolving disputes arising from this blocked space agreement: Arbitration, Litigation, Mediation, or Negotiation.. Valid values are `arbitration|litigation|mediation|negotiation`',
    `effective_date` DATE COMMENT 'The date from which this blocked space agreement becomes binding and capacity reservations take effect.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this blocked space agreement grants Transport Shipping exclusive access to the specified capacity on the service. True if exclusive; False if shared with other parties.',
    `expiry_date` DATE COMMENT 'The date on which this blocked space agreement ceases to be in force. Nullable for open-ended agreements subject to notice periods.',
    `force_majeure_clause` STRING COMMENT 'Summary of the force majeure provisions that excuse performance under extraordinary circumstances (e.g., natural disasters, war, strikes, pandemics).',
    `governing_law` STRING COMMENT 'The jurisdiction and legal framework governing this blocked space agreement (e.g., English Law, New York Law, Singapore Law).',
    `guaranteed_capacity_cbm` DECIMAL(18,2) COMMENT 'Total volume capacity guaranteed to Transport Shipping measured in cubic meters. Applicable to both ocean LCL and air freight agreements.',
    `guaranteed_capacity_kg` DECIMAL(18,2) COMMENT 'Total weight capacity guaranteed to Transport Shipping measured in kilograms for air freight agreements. Null for ocean agreements.',
    `guaranteed_capacity_teu` DECIMAL(18,2) COMMENT 'Total capacity guaranteed to Transport Shipping measured in TEU (Twenty-foot Equivalent Units) for ocean agreements. Null for air freight agreements.',
    `last_modified_by_user` STRING COMMENT 'Identifier or name of the user who last modified this blocked space agreement record in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this blocked space agreement record was last updated in the system.',
    `minimum_utilization_commitment_absolute` DECIMAL(18,2) COMMENT 'The minimum absolute quantity of capacity (in the agreements unit of measure) that Transport Shipping commits to utilize. Alternative or complementary to percentage-based commitment.',
    `minimum_utilization_commitment_percent` DECIMAL(18,2) COMMENT 'The minimum percentage of guaranteed capacity that Transport Shipping commits to utilize over the agreement period. Failure to meet this threshold may trigger penalties.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational instructions related to this blocked space agreement.',
    `origin_region` STRING COMMENT 'Geographic region or port cluster from which the blocked space capacity originates (e.g., Far East, North Europe, US West Coast).',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Fixed or maximum monetary penalty amount for under-utilization, if applicable. Null if penalty is variable or non-monetary.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `penalty_for_underutilization` STRING COMMENT 'Description of the financial or operational penalty imposed if Transport Shipping fails to meet the minimum utilization commitment (e.g., payment for unused capacity, rate adjustment, loss of priority).',
    `priority_level` STRING COMMENT 'The booking priority or service level that Transport Shipping receives under this blocked space agreement relative to other shippers (e.g., guaranteed space, preferred allocation, standard queue).. Valid values are `standard|preferred|premium|guaranteed`',
    `rate_basis` STRING COMMENT 'Description of the pricing or rate structure associated with the blocked space (e.g., fixed rate per TEU, discounted rate schedule, spot rate with floor). Distinct from the rate schedule itself which may be stored separately.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base rate (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiry that renewal notice must be provided by the party holding the renewal option or to prevent automatic renewal.',
    `renewal_option` STRING COMMENT 'The renewal mechanism for this blocked space agreement: Automatic renewal unless notice given, Mutual consent required, Shipper (Transport Shipping) holds renewal option, Carrier holds renewal option, or No renewal (one-time agreement).. Valid values are `automatic|mutual_consent|shipper_option|carrier_option|none`',
    `rollover_allowed_flag` BOOLEAN COMMENT 'Indicates whether unused capacity from one allocation period can be rolled over to the next period. True if rollover is permitted; False otherwise.',
    `rollover_limit_percent` DECIMAL(18,2) COMMENT 'Maximum percentage of unused capacity that can be rolled over to the next allocation period, if rollover is allowed. Null if no limit or rollover not allowed.',
    `signed_by_carrier` STRING COMMENT 'Name and title of the carrier authorized signatory who executed this agreement.',
    `signed_by_transport_shipping` STRING COMMENT 'Name and title of the Transport Shipping authorized signatory who executed this agreement.',
    `signed_date` DATE COMMENT 'The date on which this blocked space agreement was formally executed by both Transport Shipping and the carrier.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate this blocked space agreement prior to its natural expiry.',
    CONSTRAINT pk_blocked_space_agreement PRIMARY KEY(`blocked_space_agreement_id`)
) COMMENT 'Master record for blocked space agreements (BSAs) between Transport Shipping and ocean or air carriers guaranteeing a fixed volume of capacity on specific services or trade lanes. Captures BSA reference, carrier, trade lane, transport mode (air/ocean), service or vessel/flight, guaranteed capacity (TEU, kg, CBM), minimum utilization commitment, penalty for under-utilization, rate basis, effective and expiry dates, and BSA status. Distinct from interline agreements (which govern revenue proration) — BSAs govern capacity reservation and utilization obligations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`carrier_service` (
    `carrier_service_id` BIGINT COMMENT 'Unique identifier for the carrier service product. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier partner offering this service. Links to the carrier profile master data.',
    `connecting_carrier_service_id` BIGINT COMMENT 'Self-referencing FK on carrier_service (connecting_carrier_service_id)',
    `carbon_neutral_certified` BOOLEAN COMMENT 'Indicates whether this service is certified as carbon-neutral through offsets or sustainable fuel programs.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this carrier service record was first created in the system.',
    `customs_clearance_included` BOOLEAN COMMENT 'Indicates whether customs brokerage and clearance services are included in this service offering.',
    `cutoff_day_offset` STRING COMMENT 'The number of days before departure that the cutoff time applies (0 = same day, 1 = one day before, etc.).',
    `cutoff_time_local` STRING COMMENT 'The local time by which cargo must be delivered to the carrier facility to be accepted for this service (format: HH:MM).',
    `dangerous_goods_capable` BOOLEAN COMMENT 'Indicates whether this service is certified to handle dangerous goods (DG) or hazardous materials (HAZMAT).',
    `destination_location_code` STRING COMMENT 'The specific destination location code (IATA airport code, UN/LOCODE port code, or city code) where the service ends.',
    `destination_region` STRING COMMENT 'The geographic region or country code where this service terminates. May be a specific port, city, or broader region code.',
    `dg_classes_supported` STRING COMMENT 'Comma-separated list of UN dangerous goods classes supported by this service (e.g., 1, 2.1, 3, 4.1, 5.1, 6.1, 8, 9).',
    `documentation_cutoff_time` TIMESTAMP COMMENT 'The local time by which shipping documentation (AWB, BOL, customs declarations) must be submitted (format: HH:MM).',
    `door_to_door_available` BOOLEAN COMMENT 'Indicates whether this service includes door-to-door pickup and delivery, or is port-to-port / terminal-to-terminal only.',
    `effective_date` DATE COMMENT 'The date from which this service definition becomes valid and available for booking.',
    `equipment_types_supported` STRING COMMENT 'Comma-separated list of equipment types supported by this service (e.g., 20GP, 40HC, 45HC for ocean; ULD types for air; truck types for road).',
    `expiry_date` DATE COMMENT 'The date on which this service definition expires or is no longer available for booking. Null for open-ended services.',
    `flight_service_identifier` STRING COMMENT 'The carrier-assigned flight number or air service identifier (for air freight).',
    `frequency` STRING COMMENT 'The operational frequency of this service: daily, weekly, biweekly (fortnightly), monthly, or on-demand.. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `frequency_per_week` STRING COMMENT 'The number of service departures per week. Used for capacity planning and booking availability.',
    `incoterms_supported` STRING COMMENT 'Comma-separated list of Incoterms (International Commercial Terms) supported by this service (e.g., FOB, CIF, DDP, DAP, EXW).',
    `insurance_available` BOOLEAN COMMENT 'Indicates whether cargo insurance is available or included with this service.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this carrier service record was last modified.',
    `live_animal_capable` BOOLEAN COMMENT 'Indicates whether this service is certified to transport live animals.',
    `max_volume_capacity_cbm` DECIMAL(18,2) COMMENT 'The maximum volume capacity in cubic meters (CBM) that this service can handle per shipment or booking.',
    `max_weight_capacity_kg` DECIMAL(18,2) COMMENT 'The maximum weight capacity in kilograms that this service can handle per shipment or booking.',
    `origin_location_code` STRING COMMENT 'The specific origin location code (IATA airport code, UN/LOCODE port code, or city code) where the service begins.',
    `origin_region` STRING COMMENT 'The geographic region or country code where this service originates. May be a specific port, city, or broader region code.',
    `oversized_cargo_capable` BOOLEAN COMMENT 'Indicates whether this service can handle oversized or out-of-gauge cargo that exceeds standard equipment dimensions.',
    `perishable_cargo_capable` BOOLEAN COMMENT 'Indicates whether this service supports perishable cargo requiring time-sensitive handling.',
    `service_code` STRING COMMENT 'The unique alphanumeric code assigned by the carrier to identify this service product. Used in booking and rating systems.',
    `service_description` STRING COMMENT 'Detailed textual description of the service offering, including unique features, routing details, and value propositions.',
    `service_level` STRING COMMENT 'The quality tier of the service offering: premium (highest priority, fastest), standard (regular service), economy (cost-optimized), or basic (minimal service).. Valid values are `premium|standard|economy|basic`',
    `service_name` STRING COMMENT 'The commercial name of the carrier service product as marketed by the carrier (e.g., FedEx Priority Overnight, Maersk AE7 Asia-Europe Express).',
    `service_status` STRING COMMENT 'The current operational status of this carrier service: active (available for booking), suspended (temporarily unavailable), discontinued (permanently ended), seasonal (operates during specific periods), or planned (future service).. Valid values are `active|suspended|discontinued|seasonal|planned`',
    `service_type` STRING COMMENT 'Classification of the service delivery model: direct (non-stop), transshipment (hub-and-spoke), feeder (connecting service), express (time-definite), economy (cost-optimized), or standard (regular service).. Valid values are `direct|transshipment|feeder|express|economy|standard`',
    `temperature_controlled_capable` BOOLEAN COMMENT 'Indicates whether this service supports temperature-controlled (reefer) cargo.',
    `tracking_available` BOOLEAN COMMENT 'Indicates whether real-time or milestone-based shipment tracking is available for this service.',
    `tracking_granularity` STRING COMMENT 'The level of tracking detail provided: real-time (GPS/IoT), milestone (event-based), daily (batch updates), or none.. Valid values are `real_time|milestone|daily|none`',
    `train_service_identifier` STRING COMMENT 'The carrier-assigned train service number or rail service identifier (for rail freight).',
    `transit_time_days` STRING COMMENT 'The standard transit time in days from origin to destination for this service, excluding customs clearance and last-mile delivery.',
    `transit_time_hours` STRING COMMENT 'The standard transit time in hours for express or time-critical services where hour-level precision is required.',
    `transport_mode` STRING COMMENT 'The primary mode of transportation for this service (air, ocean, road, rail, multimodal, courier).. Valid values are `air|ocean|road|rail|multimodal|courier`',
    `vessel_service_identifier` STRING COMMENT 'The carrier-assigned identifier for the vessel service string (for ocean freight) or vessel rotation code.',
    CONSTRAINT pk_carrier_service PRIMARY KEY(`carrier_service_id`)
) COMMENT 'Master record defining the specific transport services offered by a carrier partner, representing the named service products available for booking. Captures carrier reference, service name, service code, transport mode, service type (direct, transshipment, feeder, express, economy), origin and destination regions, transit time, frequency (daily, weekly, fortnightly), vessel/flight/train service identifier, cut-off times, and service status. Enables service-level carrier selection and route planning. Distinct from route.carrier_schedule (which captures published timetables) — this is the service product definition.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`carrier_contact` (
    `carrier_contact_id` BIGINT COMMENT 'Unique identifier for the carrier contact record. Primary key.',
    `carrier_profile_id` BIGINT COMMENT 'Reference to the carrier or network partner organization this contact represents.',
    `reports_to_carrier_contact_id` BIGINT COMMENT 'Self-referencing FK on carrier_contact (reports_to_carrier_contact_id)',
    `active_status` STRING COMMENT 'Current status of the contact indicating whether they are actively available for communication and liaison activities.. Valid values are `active|inactive|on_leave|terminated`',
    `contact_first_name` STRING COMMENT 'Given name of the contact person.',
    `contact_full_name` STRING COMMENT 'Full legal name of the individual contact at the carrier or partner organization.',
    `contact_last_name` STRING COMMENT 'Family name or surname of the contact person.',
    `contact_type` STRING COMMENT 'Classification of the contact role indicating their primary area of responsibility and liaison function with Transport Shipping. [ENUM-REF-CANDIDATE: commercial|operations|claims|documentation|it_edi|technical|customer_service — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this carrier contact record was first created in the system.',
    `crm_account_code` STRING COMMENT 'External identifier linking this contact to their record in the Salesforce CRM system for unified relationship management.',
    `department` STRING COMMENT 'Department or functional area within the carrier organization where the contact works (e.g., Operations, Commercial, Claims, IT).',
    `effective_end_date` DATE COMMENT 'Date when this contact ceased to be active or available for liaison, if applicable. Null indicates the contact is currently active.',
    `effective_start_date` DATE COMMENT 'Date when this contact became active and available for liaison with Transport Shipping.',
    `email_address` STRING COMMENT 'Primary email address for contacting this individual at the carrier or partner organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_flag` BOOLEAN COMMENT 'Indicates whether this contact should be reached for emergency or critical operational issues requiring immediate attention.',
    `escalation_level` STRING COMMENT 'Numeric indicator of the contacts position in the escalation hierarchy, where lower numbers indicate first-line contacts and higher numbers indicate senior management (e.g., 1=frontline, 2=supervisor, 3=manager, 4=director, 5=executive).',
    `fax_number` STRING COMMENT 'Fax number for the contact, used for document transmission where required by legacy processes or regulatory requirements.',
    `job_title` STRING COMMENT 'Official job title or position of the contact within the carrier or partner organization.',
    `language_preference` STRING COMMENT 'Preferred language for communication with this contact, specified as ISO 639-1 two-letter language code (e.g., EN, ES, FR, DE, ZH).',
    `last_contact_date` DATE COMMENT 'Date of the most recent communication or interaction with this contact.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this carrier contact record was most recently updated.',
    `mobile_number` STRING COMMENT 'Mobile or cellular phone number for the contact, used for urgent or after-hours communication.',
    `notes` STRING COMMENT 'Free-text field for capturing additional information about the contact, such as special instructions, availability constraints, or relationship history.',
    `office_location` STRING COMMENT 'Physical office location or branch where the contact is based (e.g., city, country, or facility name).',
    `phone_number` STRING COMMENT 'Primary telephone number for reaching the contact, including country and area codes.',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method of communication for routine business interactions.. Valid values are `email|phone|mobile|fax|portal|edi`',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this contact is the primary point of contact for their contact type at this carrier or partner organization.',
    `time_zone` STRING COMMENT 'Time zone where the contact is located, specified in IANA time zone database format (e.g., America/New_York, Europe/London, Asia/Singapore).',
    CONSTRAINT pk_carrier_contact PRIMARY KEY(`carrier_contact_id`)
) COMMENT 'Master record for key contacts at carrier and network partner organizations, capturing the individuals responsible for commercial, operational, and technical liaison with Transport Shipping. Captures carrier or partner reference, contact full name, job title, department, contact type (commercial, operations, claims, documentation, IT/EDI), email, phone, preferred communication channel, and active status. Enables relationship management and escalation routing across the partner network.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`network_event` (
    `network_event_id` BIGINT COMMENT 'Unique identifier for the network event record. Primary key.',
    `agent_id` BIGINT COMMENT 'Identifier of the agent or correspondent office affected by this network event. References the agent master entity.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier affected by this network event. References the carrier master entity.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Network events often affect specific carrier services (e.g., flight delays, vessel schedule changes, service suspensions). This link enables service-level event tracking and impact analysis. Nullable ',
    `depot_id` BIGINT COMMENT 'Foreign key linking to fleet.depot. Business justification: Network disruption events (port closures, carrier strikes, weather events) directly affect specific depots, triggering rerouting, asset redeployment, and customer notifications. Operations centers nee',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: network_event currently stores partner_name as a denormalized STRING column but has no FK to the partner master record. Adding partner_id normalizes this relationship — the partners legal_name, trade',
    `affected_airports` STRING COMMENT 'Comma-separated list of IATA airport codes affected by this network event (e.g., JFK, PVG, AMS).',
    `affected_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes for countries impacted by this network event.',
    `affected_ports` STRING COMMENT 'Comma-separated list of port codes or names affected by this network event (e.g., USNYC, CNSHA, NLRTM).',
    `affected_regions` STRING COMMENT 'Comma-separated list of geographic regions impacted by this network event (e.g., APAC, EMEA, Americas).',
    `affected_trade_lanes` STRING COMMENT 'Comma-separated list of trade lanes or shipping routes impacted by this network event (e.g., Asia-Europe, Trans-Pacific, North Atlantic).',
    `affected_transport_modes` STRING COMMENT 'Comma-separated list of transport modes impacted by this event (e.g., air, ocean, road, rail).',
    `alternative_carrier_engaged` BOOLEAN COMMENT 'Indicates whether alternative carriers have been engaged to provide substitute capacity during this network event.',
    `alternative_routing_available` BOOLEAN COMMENT 'Indicates whether alternative routing options are available to bypass the affected network segment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this network event record was first created in the system.',
    `customer_notification_datetime` TIMESTAMP COMMENT 'Date and time when customer notifications were sent regarding this network event.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether affected customers have been notified about this network event and its impact on their shipments.',
    `end_datetime` TIMESTAMP COMMENT 'Date and time when the network disruption or event was resolved and operations returned to normal. Null if event is ongoing.',
    `escalation_datetime` TIMESTAMP COMMENT 'Date and time when this network event was escalated to higher management levels.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether this network event requires escalation to senior management or executive leadership.',
    `estimated_capacity_loss_teu` DECIMAL(18,2) COMMENT 'Estimated loss of container capacity measured in TEU resulting from this network event.',
    `estimated_delay_hours` DECIMAL(18,2) COMMENT 'Estimated average delay in hours to shipments affected by this network event.',
    `estimated_shipments_affected` STRING COMMENT 'Estimated number of active shipments impacted by this network event.',
    `event_code` STRING COMMENT 'Unique business identifier code assigned to this network event for external reference and tracking.. Valid values are `^[A-Z0-9]{6,12}$`',
    `event_description` STRING COMMENT 'Detailed narrative description of the network event, including the nature of the disruption, root cause, and contextual information.',
    `event_status` STRING COMMENT 'Current lifecycle status of the network event indicating the stage of resolution and operational response.. Valid values are `open|in_progress|mitigated|resolved|closed`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the network event was first detected or reported in the operational system.',
    `event_type` STRING COMMENT 'Classification of the network event indicating the nature of the disruption or change affecting the partner network. [ENUM-REF-CANDIDATE: carrier_service_suspension|capacity_disruption|port_congestion|strike_action|natural_disaster|regulatory_change|partner_status_change — 7 candidates stripped; promote to reference product]',
    `financial_impact_estimated_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact of this network event in USD, including revenue loss, additional costs, and penalties.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this network event record was last updated or modified.',
    `lessons_learned` STRING COMMENT 'Documentation of lessons learned and recommendations for preventing similar network events in the future.',
    `mitigation_actions_taken` STRING COMMENT 'Detailed description of mitigation actions and contingency measures implemented to minimize the impact of this network event.',
    `notes` STRING COMMENT 'Additional free-form notes and comments related to this network event for internal reference and collaboration.',
    `operational_impact_description` STRING COMMENT 'Detailed description of the operational impact on service delivery, capacity, transit times, and customer commitments resulting from this network event.',
    `priority_level` STRING COMMENT 'Priority level assigned to this network event for resource allocation and response planning.. Valid values are `urgent|high|medium|low`',
    `regulatory_authority_name` STRING COMMENT 'Name of the regulatory authority or governing body notified about this network event (e.g., IMO, IATA, FMC, DOT).',
    `regulatory_authority_notified` BOOLEAN COMMENT 'Indicates whether relevant regulatory authorities have been notified about this network event as required by compliance obligations.',
    `resolution_description` STRING COMMENT 'Detailed description of how the network event was resolved and operations were restored to normal.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause of this network event for trend analysis and risk management. [ENUM-REF-CANDIDATE: weather|labor_dispute|equipment_failure|port_congestion|regulatory|security|pandemic|geopolitical|infrastructure|other — 10 candidates stripped; promote to reference product]',
    `root_cause_details` STRING COMMENT 'Detailed explanation of the root cause analysis findings for this network event.',
    `severity` STRING COMMENT 'Severity level of the network event indicating the magnitude of operational impact on the partner network and service delivery.. Valid values are `critical|high|medium|low`',
    `sla_breach_count` STRING COMMENT 'Number of SLA breaches resulting from this network event across affected customer contracts.',
    `start_datetime` TIMESTAMP COMMENT 'Date and time when the network disruption or event began affecting operations.',
    CONSTRAINT pk_network_event PRIMARY KEY(`network_event_id`)
) COMMENT 'Transactional event log capturing significant operational events affecting the partner network — including carrier service suspensions, capacity disruptions, port congestion alerts, strike actions, natural disaster impacts, regulatory changes affecting trade lanes, and partner status changes. Captures event type, affected partner or carrier, affected trade lanes or regions, event severity, start and end datetime, operational impact description, mitigation actions taken, and resolution status. Enables proactive network disruption management and partner communication.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` (
    `partner_onboarding_id` BIGINT COMMENT 'Unique identifier for the partner onboarding record. Primary key for tracking the end-to-end onboarding lifecycle of a network partner from initial qualification through activation.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Partner onboarding is governed by a formal contract agreement. Currently has contract_reference_number (string) but needs proper FK for referential integrity. The contract_reference_number can remain ',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity being onboarded (carrier, agent, 3PL, correspondent office). Links to the master partner record in the network domain.',
    `reactivation_partner_onboarding_id` BIGINT COMMENT 'Self-referencing FK on partner_onboarding (reactivation_partner_onboarding_id)',
    `actual_activation_date` DATE COMMENT 'Actual date when the partner was activated and began operational activities. Nullable until activation is completed.',
    `api_integration_status` STRING COMMENT 'Status of API connectivity setup and testing. Tracks technical integration for real-time system-to-system communication.. Valid values are `not_required|not_started|in_progress|testing|live|failed`',
    `approval_date` DATE COMMENT 'Date when final approval for partner activation was granted.',
    `approval_status` STRING COMMENT 'Final approval status for partner activation. Indicates whether the partner has been approved to go live.. Valid values are `pending|approved|rejected|conditional`',
    `certification_verification_status` STRING COMMENT 'Status of industry certification verification (ISO, AEO, C-TPAT, dangerous goods, etc.). Confirms partner holds required certifications.. Valid values are `not_started|in_progress|verified|missing|waived`',
    `certification_verified_date` DATE COMMENT 'Date when required certifications were verified.',
    `contract_execution_date` DATE COMMENT 'Date when the partnership contract was formally executed by all parties. Marks legal commitment.',
    `contract_reference_number` STRING COMMENT 'Reference to the executed partnership contract document. Links onboarding to the legal agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding record was first created in the system. Audit trail for record creation.',
    `due_diligence_completed_date` DATE COMMENT 'Date when comprehensive due diligence checks (financial, operational, compliance) were completed and approved.',
    `edi_integration_status` STRING COMMENT 'Status of EDI connectivity setup and testing. Tracks technical integration for automated data exchange.. Valid values are `not_required|not_started|in_progress|testing|live|failed`',
    `financial_assessment_date` DATE COMMENT 'Date when the financial assessment was completed.',
    `financial_assessment_status` STRING COMMENT 'Status of the financial viability and creditworthiness assessment. Evaluates partner financial stability and risk.. Valid values are `not_started|in_progress|approved|rejected|conditional`',
    `geographic_scope_authorized` STRING COMMENT 'Geographic regions or countries the partner is authorized to operate in. Defines territorial scope of the partnership.',
    `go_live_date` DATE COMMENT 'Date when the partner officially went live and began processing live transactions. Marks operational commencement.',
    `initiated_date` DATE COMMENT 'Date when the onboarding process was formally initiated. Marks the beginning of the partner onboarding lifecycle.',
    `insurance_verification_status` STRING COMMENT 'Status of insurance coverage verification. Confirms partner has adequate liability, cargo, and other required insurance.. Valid values are `not_started|in_progress|verified|insufficient|waived`',
    `insurance_verified_date` DATE COMMENT 'Date when insurance coverage was verified and approved.',
    `kyc_check_status` STRING COMMENT 'Status of the Know Your Customer compliance check. Verifies partner identity, ownership structure, and legitimacy.. Valid values are `not_started|in_progress|completed|failed|waived`',
    `kyc_completed_date` DATE COMMENT 'Date when the KYC compliance check was completed and approved.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding record was last updated. Audit trail for record changes.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special conditions, escalations, or other relevant information about the onboarding process.',
    `onboarding_duration_days` STRING COMMENT 'Total number of calendar days from initiation to activation. Used for process performance measurement and continuous improvement.',
    `onboarding_reference_number` STRING COMMENT 'Externally-known unique business identifier for this onboarding case. Used for tracking and communication with the partner and internal stakeholders.. Valid values are `^ONB-[A-Z0-9]{8,12}$`',
    `onboarding_stage` STRING COMMENT 'Current stage in the onboarding workflow. Represents the specific phase of the structured onboarding process the partner is currently in. [ENUM-REF-CANDIDATE: pre_qualification|due_diligence|contract_negotiation|contract_execution|system_integration|operational_readiness|go_live|post_activation — 8 candidates stripped; promote to reference product]',
    `onboarding_status` STRING COMMENT 'Overall lifecycle status of the onboarding process. Tracks the current state from initiation through completion or termination.. Valid values are `initiated|in_progress|on_hold|completed|cancelled|rejected`',
    `onboarding_type` STRING COMMENT 'Type of onboarding activity. Distinguishes between new partner onboarding, expansion of existing partner capabilities, or reactivation of dormant partnerships.. Valid values are `new_partner|service_expansion|geographic_expansion|mode_addition|reactivation`',
    `operational_readiness_score` DECIMAL(18,2) COMMENT 'Composite score (0-100) assessing the partner readiness across all onboarding dimensions. Used for go/no-go decision making.',
    `partner_type` STRING COMMENT 'Classification of the partner being onboarded. Determines the onboarding workflow, compliance requirements, and integration scope.. Valid values are `carrier|agent|3pl|correspondent_office|nvocc|freight_forwarder`',
    `pre_qualification_completed_date` DATE COMMENT 'Date when the pre-qualification stage was completed. Indicates the partner met initial screening criteria.',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the onboarding was rejected or cancelled. Captures business rationale for non-activation.',
    `risk_rating` STRING COMMENT 'Overall risk assessment of the partner based on due diligence, financial assessment, and compliance checks. Influences monitoring and oversight requirements.. Valid values are `low|medium|high|critical`',
    `sanctions_screening_date` DATE COMMENT 'Date when sanctions screening was performed and cleared.',
    `sanctions_screening_status` STRING COMMENT 'Status of sanctions and denied party screening. Ensures partner is not on restricted or prohibited lists.. Valid values are `not_started|in_progress|cleared|flagged|escalated`',
    `service_modes_authorized` STRING COMMENT 'Comma-separated list of transport modes the partner is authorized to operate (air, ocean, road, rail, multimodal). Defines operational scope.',
    `system_integration_completed_date` DATE COMMENT 'Date when technical system integration (EDI, API, TMS connectivity) was completed and tested successfully.',
    `target_activation_date` DATE COMMENT 'Planned date for the partner to go live and begin operational activities. Used for project planning and stakeholder communication.',
    `tms_integration_status` STRING COMMENT 'Status of TMS system integration. Tracks connectivity to core transportation management platform for order and shipment processing.. Valid values are `not_required|not_started|in_progress|testing|live|failed`',
    CONSTRAINT pk_partner_onboarding PRIMARY KEY(`partner_onboarding_id`)
) COMMENT 'Transactional record tracking the end-to-end onboarding lifecycle of a new network partner (carrier, agent, 3PL, correspondent office) from initial qualification through activation. Captures partner reference, onboarding type, onboarding stage (pre-qualification, due diligence, contract execution, system integration, go-live), stage completion dates, responsible onboarding manager, compliance checks completed (KYC, sanctions screening, certification verification), IT integration status (EDI, API), and overall onboarding status. Ensures structured and auditable partner onboarding.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_settlement` (
    `partner_settlement_id` BIGINT COMMENT 'Unique identifier for the partner settlement transaction. Primary key for the partner settlement record.',
    `interline_agreement_id` BIGINT COMMENT 'Reference to the interline agreement governing the prorate methodology and revenue split for this settlement, if applicable.',
    `partner_id` BIGINT COMMENT 'Reference to the network partner (carrier, agent, 3PL provider) for whom this settlement is being processed.',
    `reversed_partner_settlement_id` BIGINT COMMENT 'Self-referencing FK on partner_settlement (reversed_partner_settlement_id)',
    `actual_payment_date` DATE COMMENT 'Actual date on which payment was successfully made to the partner, as confirmed by the payment system.',
    `approval_date` DATE COMMENT 'Date on which the settlement was formally approved for payment by authorized personnel.',
    `awb_count` STRING COMMENT 'Number of air waybills included in this settlement period for interline traffic settlements.',
    `bank_account_number` STRING COMMENT 'Partner bank account number to which the settlement payment is made. Masked or encrypted for security.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the partner account for settlement payment.',
    `cost_center_code` STRING COMMENT 'Cost center or business unit code responsible for this settlement expense or revenue allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this settlement record was first created in the system.',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Total amount of deductions applied to the gross settlement, including penalties, chargebacks, claims offsets, and other adjustments.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the partner has raised a dispute or disagreement regarding this settlement transaction.',
    `dispute_raised_date` DATE COMMENT 'Date on which the partner formally raised a dispute regarding this settlement.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute raised by the partner, including details of the discrepancy or disagreement.',
    `dispute_resolution_date` DATE COMMENT 'Date on which the dispute was resolved and both parties agreed on the final settlement terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied when converting from original currency to settlement currency, if applicable.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this settlement transaction is posted for financial accounting purposes.',
    `gross_settlement_amount` DECIMAL(18,2) COMMENT 'Total settlement amount before any deductions, adjustments, or withholdings are applied.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this settlement record was last updated or modified.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Final settlement amount payable to the partner after all deductions, adjustments, and withholdings have been applied. Calculated as gross amount minus deductions minus tax withholding.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information regarding this settlement transaction.',
    `original_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the original transaction currency before any currency conversion was applied.. Valid values are `^[A-Z]{3}$`',
    `payment_reference_number` STRING COMMENT 'Unique reference number or transaction identifier from the payment system used to track and reconcile the payment.',
    `payment_terms_days` STRING COMMENT 'Number of days from settlement approval date within which payment must be made to the partner, as per contractual agreement.',
    `reconciliation_date` DATE COMMENT 'Date on which the settlement was successfully reconciled and confirmed by both parties.',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process indicating whether the settlement has been matched and verified against partner records and source transactions.. Valid values are `not_started|in_progress|reconciled|discrepancy_found|disputed|resolved`',
    `scheduled_payment_date` DATE COMMENT 'Target date on which payment is scheduled to be made to the partner based on payment terms and approval date.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the settlement is denominated and will be paid.. Valid values are `^[A-Z]{3}$`',
    `settlement_method` STRING COMMENT 'Payment mechanism used to settle the financial obligation with the partner. CASS refers to IATA Cargo Accounts Settlement System. [ENUM-REF-CANDIDATE: cass|bank_transfer|wire_transfer|ach|netting|offset|check — 7 candidates stripped; promote to reference product]',
    `settlement_period_end_date` DATE COMMENT 'End date of the period covered by this settlement (e.g., end of the month or billing cycle).',
    `settlement_period_start_date` DATE COMMENT 'Start date of the period covered by this settlement (e.g., beginning of the month or billing cycle).',
    `settlement_reference_number` STRING COMMENT 'Externally visible unique reference number for this settlement transaction, used for partner communication and reconciliation.',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the settlement transaction indicating its processing stage and payment state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_payment|paid|disputed|reconciled|cancelled — 8 candidates stripped; promote to reference product]',
    `settlement_type` STRING COMMENT 'Classification of the settlement transaction indicating the nature of the financial arrangement. [ENUM-REF-CANDIDATE: interline_prorate|agent_commission|3pl_service_fee|capacity_penalty|handling_charge|fuel_surcharge|volume_incentive|performance_bonus|demurrage_charge|detention_charge — promote to reference product]. Valid values are `interline_prorate|agent_commission|3pl_service_fee|capacity_penalty|handling_charge|fuel_surcharge`',
    `shipment_count` STRING COMMENT 'Total number of shipments or consignments included in this settlement calculation.',
    `swift_code` STRING COMMENT 'SWIFT/BIC code identifying the partner bank for international wire transfers.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld at source as required by local tax regulations or international tax treaties.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume in cubic meters for all shipments included in this settlement.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total chargeable weight in kilograms for all shipments included in this settlement.',
    CONSTRAINT pk_partner_settlement PRIMARY KEY(`partner_settlement_id`)
) COMMENT 'Transactional record managing financial settlement between Transport Shipping and network partners for interline traffic, capacity utilization, agent commissions, and 3PL service fees. Captures partner reference, settlement period, settlement type (interline prorate, agent commission, 3PL service fee, capacity penalty), gross amount, deductions, net settlement amount, currency, settlement method (CASS, bank transfer, netting), settlement date, and reconciliation status. Enables accurate partner financial settlement and dispute resolution.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_sla` (
    `partner_sla_id` BIGINT COMMENT 'Unique identifier for the partner service level agreement record.',
    `agent_id` BIGINT COMMENT 'Reference to the agent if the partner is an agent entity.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier if the partner is a carrier entity.',
    `partner_id` BIGINT COMMENT 'Reference to the network partner (carrier, agent, 3PL provider) to whom this SLA applies.',
    `superseded_partner_sla_id` BIGINT COMMENT 'Self-referencing FK on partner_sla (superseded_partner_sla_id)',
    `approval_date` DATE COMMENT 'Date on which this partner SLA was formally approved and authorized.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this SLA automatically renews upon expiry (True) or requires explicit renewal action (False).',
    `breach_threshold` DECIMAL(18,2) COMMENT 'Performance level at which the SLA is considered breached, triggering penalties or remediation actions.',
    `contract_reference` STRING COMMENT 'Reference to the parent contract or agreement document under which this SLA is governed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner SLA record was first created in the system.',
    `destination_region` STRING COMMENT 'Geographic region or country code for the destination scope of this SLA.',
    `effective_date` DATE COMMENT 'Date from which this partner SLA commitment becomes active and enforceable.',
    `escalation_procedure` STRING COMMENT 'Description of the escalation process to be followed when SLA performance issues or breaches occur.',
    `expiry_date` DATE COMMENT 'Date on which this partner SLA commitment expires or is scheduled for renewal. Nullable for open-ended SLAs.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary incentive or bonus amount awarded for exceeding SLA performance targets.',
    `incentive_clause_reference` STRING COMMENT 'Reference to the contract clause or document section that defines incentives or bonuses for exceeding SLA targets.',
    `incentive_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the incentive amount.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner SLA record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal SLA review meeting or assessment.',
    `measurement_frequency` STRING COMMENT 'Frequency at which the SLA performance is measured and reported (e.g., daily, weekly, monthly, per shipment). [ENUM-REF-CANDIDATE: real_time|daily|weekly|monthly|quarterly|per_shipment|per_transaction — 7 candidates stripped; promote to reference product]',
    `measurement_period_days` STRING COMMENT 'Number of days over which performance is aggregated for SLA evaluation (e.g., rolling 30-day average).',
    `measurement_unit` STRING COMMENT 'Unit of measure for the performance metric (e.g., percentage, hours, days, count).. Valid values are `percentage|hours|days|minutes|count|ratio`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal SLA review meeting or assessment.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special conditions related to this partner SLA.',
    `origin_region` STRING COMMENT 'Geographic region or country code for the origin scope of this SLA.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount applied per SLA breach occurrence or per measurement period.',
    `penalty_clause_reference` STRING COMMENT 'Reference to the contract clause or document section that defines penalties for SLA breach.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `performance_metric` STRING COMMENT 'Specific metric or Key Performance Indicator (KPI) being measured under this SLA (e.g., on-time delivery percentage, average transit days, documentation error rate).',
    `renewal_notice_period_days` STRING COMMENT 'Number of days advance notice required before SLA renewal or termination.',
    `reporting_frequency` STRING COMMENT 'Frequency at which SLA performance reports are provided to stakeholders (e.g., daily, weekly, monthly, quarterly).. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `review_frequency` STRING COMMENT 'Frequency at which the SLA terms and performance are formally reviewed with the partner (e.g., monthly, quarterly, annually).. Valid values are `monthly|quarterly|semi_annually|annually`',
    `service_type` STRING COMMENT 'Type of service to which this SLA applies (e.g., express, standard, economy, Full Truckload (FTL), Less Than Truckload (LTL), Full Container Load (FCL), Less Than Container Load (LCL)). [ENUM-REF-CANDIDATE: express|standard|economy|freight|ltl|ftl|fcl|lcl — 8 candidates stripped; promote to reference product]',
    `sla_name` STRING COMMENT 'Descriptive name or title of the partner SLA commitment.',
    `sla_reference_number` STRING COMMENT 'Externally-known unique reference number or code for this partner SLA commitment.',
    `sla_status` STRING COMMENT 'Current lifecycle status of the partner SLA (e.g., active, suspended, expired, terminated, draft, under review).. Valid values are `active|suspended|expired|terminated|draft|under_review`',
    `sla_type` STRING COMMENT 'Category of operational performance standard governed by this SLA. Defines the specific performance dimension being measured (e.g., transit time, pickup compliance, documentation accuracy, claims response time, capacity fulfillment). [ENUM-REF-CANDIDATE: transit_time|pickup_compliance|documentation_accuracy|claims_response_time|capacity_fulfillment|delivery_performance|tracking_update_frequency|customs_clearance_time — 8 candidates stripped; promote to reference product]',
    `target_value` DECIMAL(18,2) COMMENT 'Target performance threshold that the partner is committed to achieve. Represents the agreed-upon service level standard.',
    `termination_date` DATE COMMENT 'Date on which this partner SLA was terminated or cancelled, if applicable.',
    `termination_reason` STRING COMMENT 'Explanation or reason code for why this partner SLA was terminated.',
    `trade_lane` STRING COMMENT 'Specific trade lane or route corridor to which this SLA applies (e.g., Asia-Europe, Trans-Pacific, North America-Latin America).',
    `transport_mode` STRING COMMENT 'Mode of transportation to which this SLA applies (e.g., air, ocean, road, rail, multimodal). [ENUM-REF-CANDIDATE: air|ocean|road|rail|multimodal|courier|parcel — 7 candidates stripped; promote to reference product]',
    `warning_threshold` DECIMAL(18,2) COMMENT 'Performance level that triggers a warning notification before a full SLA breach occurs. Allows proactive intervention.',
    CONSTRAINT pk_partner_sla PRIMARY KEY(`partner_sla_id`)
) COMMENT 'Master record defining the service level agreement commitments agreed with network partners (carriers, agents, 3PL providers) governing operational performance standards. Captures partner reference, SLA type (transit time, pickup compliance, documentation accuracy, claims response time, capacity fulfillment), target metric, measurement unit, threshold values (target, warning, breach), measurement frequency, penalty or incentive clause reference, effective date, and SLA status. Distinct from contract.sla_commitment (which governs customer-facing SLAs) — this is the partner-facing operational SLA.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`edi_connection` (
    `edi_connection_id` BIGINT COMMENT 'Unique identifier for the EDI or API integration connection record. Primary key.',
    `fallback_edi_connection_id` BIGINT COMMENT 'Self-referencing FK on edi_connection (fallback_edi_connection_id)',
    `partner_id` BIGINT COMMENT 'Reference to the network partner (carrier, agent, or third-party logistics provider) for whom this EDI connection is established.',
    `acknowledgment_required` BOOLEAN COMMENT 'Indicates whether the partner is required to send functional acknowledgments (e.g., CONTRL, 997) for messages received through this connection.',
    `authentication_method` STRING COMMENT 'Method used to authenticate and authorize access to the partners EDI or API endpoint. [ENUM-REF-CANDIDATE: BASIC_AUTH|OAUTH2|API_KEY|CERTIFICATE|SSH_KEY|USERNAME_PASSWORD|TOKEN|NONE — 8 candidates stripped; promote to reference product]',
    `average_daily_message_volume` STRING COMMENT 'Average number of messages exchanged per day through this connection, used for capacity planning and performance monitoring.',
    `compression_enabled` BOOLEAN COMMENT 'Indicates whether message compression is enabled to reduce bandwidth usage and improve transmission efficiency.',
    `connection_health_status` STRING COMMENT 'Current health status of the EDI connection based on recent transmission success rates, latency, and error patterns. Used for proactive monitoring and alerting.. Valid values are `HEALTHY|DEGRADED|CRITICAL|OFFLINE|UNKNOWN`',
    `connection_name` STRING COMMENT 'Human-readable name or label for the EDI connection, typically including partner name and connection type for easy identification.',
    `connection_reference_number` STRING COMMENT 'Business-assigned unique reference number or code for this EDI connection, used for operational tracking and support.',
    `connection_status` STRING COMMENT 'Overall lifecycle status of the EDI connection. Reflects the current operational state from initial setup through active use to eventual termination.. Valid values are `DRAFT|TESTING|ACTIVE|SUSPENDED|INACTIVE|TERMINATED`',
    `connection_type` STRING COMMENT 'Type of electronic integration connection established with the partner. Includes traditional EDI standards (TRADACOMS, EDIFACT, X12) and modern API protocols (REST, SOAP) as well as file transfer methods (SFTP, AS2, FTP). [ENUM-REF-CANDIDATE: EDI_TRADACOMS|EDI_EDIFACT|EDI_X12|API_REST|API_SOAP|SFTP|AS2|FTP|FTPS — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this EDI connection record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this EDI connection configuration expires or is scheduled for decommissioning. Null indicates an open-ended connection.',
    `effective_start_date` DATE COMMENT 'Date from which this EDI connection configuration is valid and authorized for use.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether message encryption is enabled for this connection to protect data in transit.',
    `encryption_protocol` STRING COMMENT 'Encryption protocol or standard used to secure messages transmitted through this connection (e.g., TLS 1.2, TLS 1.3, PGP, S/MIME).',
    `endpoint_host` STRING COMMENT 'Hostname or IP address of the partners EDI or API server. Confidential business integration detail.',
    `endpoint_port` STRING COMMENT 'Network port number used for the EDI or API connection (e.g., 443 for HTTPS, 22 for SFTP).',
    `endpoint_url` STRING COMMENT 'The URL or network address of the partners EDI or API endpoint where messages are sent or received. Confidential business integration detail.',
    `go_live_date` DATE COMMENT 'Date when the EDI connection was activated for production use and began processing live business transactions.',
    `interchange_control_reference_prefix` STRING COMMENT 'Prefix or pattern used for generating unique interchange control numbers in EDI message headers for this connection.',
    `last_failed_transmission_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent failed message transmission attempt, used for troubleshooting and alerting.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent automated health check performed on this connection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this EDI connection record was most recently updated.',
    `last_successful_transmission_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful message transmission through this connection, used for health monitoring.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of times the system will attempt to retransmit a failed message before escalating to manual intervention.',
    `message_direction` STRING COMMENT 'Indicates whether this connection is used for sending messages to the partner (outbound), receiving messages from the partner (inbound), or both (bidirectional).. Valid values are `INBOUND|OUTBOUND|BIDIRECTIONAL`',
    `message_format` STRING COMMENT 'Data format or serialization method used for messages exchanged through this connection.. Valid values are `XML|JSON|FLAT_FILE|CSV|FIXED_WIDTH|EDI_NATIVE`',
    `message_types_supported` STRING COMMENT 'Comma-separated list of message types or transaction sets supported by this connection (e.g., IFTMBF booking confirmation, IFTSTA status update, AWB data, manifest, invoice, DESADV despatch advice).',
    `notes` STRING COMMENT 'Free-text field for additional information, special configuration details, known issues, or operational notes related to this EDI connection.',
    `peak_message_volume` STRING COMMENT 'Maximum number of messages processed in a single day through this connection, representing peak capacity utilization.',
    `production_environment_status` STRING COMMENT 'Current operational status of the production environment connection. Indicates whether the connection is actively processing live business transactions.. Valid values are `NOT_CONFIGURED|CONFIGURED|ACTIVE|SUSPENDED|INACTIVE|DECOMMISSIONED`',
    `protocol_version` STRING COMMENT 'Version of the EDI standard or API protocol being used for this connection (e.g., EDIFACT D.96A, X12 4010, REST API v2.1).',
    `receiver_identifier` STRING COMMENT 'EDI receiver identification code or qualifier assigned to the partner for inbound messages (e.g., partners SCAC code, IATA code, GLN, DUNS number).',
    `retry_policy` STRING COMMENT 'Description of the retry logic and parameters applied when message transmission fails (e.g., number of retries, backoff intervals).',
    `sender_identifier` STRING COMMENT 'EDI sender identification code or qualifier used by Transport Shipping in outbound messages to this partner (e.g., SCAC code, IATA code, GLN, DUNS number).',
    `sla_response_time_seconds` STRING COMMENT 'Maximum response time in seconds agreed with the partner for message acknowledgment or processing, as defined in the integration SLA.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Minimum uptime percentage committed for this connection as defined in the integration SLA (e.g., 99.9%).',
    `technical_contact_email` STRING COMMENT 'Email address of the primary technical contact at the partner organization for EDI support and troubleshooting.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `technical_contact_name` STRING COMMENT 'Name of the primary technical contact at the partner organization responsible for this EDI connection.',
    `technical_contact_phone` STRING COMMENT 'Phone number of the primary technical contact at the partner organization for urgent EDI issues.',
    `test_environment_endpoint_url` STRING COMMENT 'The URL or network address of the partners test/sandbox EDI or API endpoint used for integration testing before production go-live.',
    `test_environment_status` STRING COMMENT 'Current status of the test/sandbox environment connection for this partner integration. Indicates whether test connectivity and message exchange have been successfully validated.. Valid values are `NOT_CONFIGURED|CONFIGURED|TESTING|PASSED|FAILED`',
    `timeout_seconds` STRING COMMENT 'Maximum time in seconds to wait for a response from the partner endpoint before considering the transmission failed.',
    CONSTRAINT pk_edi_connection PRIMARY KEY(`edi_connection_id`)
) COMMENT 'Master record for electronic data interchange (EDI) and API integration connections established with network partners for automated message exchange. Captures partner reference, connection type (EDI TRADACOMS, EDIFACT, X12, API REST, SFTP), message types supported (booking confirmation, status update, AWB data, manifest, invoice), connection endpoint details, protocol version, test and production environment status, go-live date, message volume, and connection health status. Manages the digital integration layer of the partner network.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ADD CONSTRAINT `fk_network_carrier_parent_carrier_id` FOREIGN KEY (`parent_carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ADD CONSTRAINT `fk_network_carrier_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ADD CONSTRAINT `fk_network_carrier_profile_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ADD CONSTRAINT `fk_network_carrier_profile_superseded_carrier_profile_id` FOREIGN KEY (`superseded_carrier_profile_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_profile`(`carrier_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ADD CONSTRAINT `fk_network_agent_parent_agent_id` FOREIGN KEY (`parent_agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ADD CONSTRAINT `fk_network_agent_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ADD CONSTRAINT `fk_network_agent_appointment_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ADD CONSTRAINT `fk_network_agent_appointment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ADD CONSTRAINT `fk_network_agent_appointment_renewed_agent_appointment_id` FOREIGN KEY (`renewed_agent_appointment_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ADD CONSTRAINT `fk_network_interline_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ADD CONSTRAINT `fk_network_interline_agreement_renewed_interline_agreement_id` FOREIGN KEY (`renewed_interline_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ADD CONSTRAINT `fk_network_tpl_provider_parent_tpl_provider_id` FOREIGN KEY (`parent_tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ADD CONSTRAINT `fk_network_tpl_provider_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ADD CONSTRAINT `fk_network_partner_parent_partner_id` FOREIGN KEY (`parent_partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ADD CONSTRAINT `fk_network_partner_certification_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ADD CONSTRAINT `fk_network_partner_certification_renewed_partner_certification_id` FOREIGN KEY (`renewed_partner_certification_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_certification`(`partner_certification_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ADD CONSTRAINT `fk_network_partner_performance_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ADD CONSTRAINT `fk_network_partner_performance_prior_partner_performance_id` FOREIGN KEY (`prior_partner_performance_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_performance`(`partner_performance_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ADD CONSTRAINT `fk_network_capacity_allocation_blocked_space_agreement_id` FOREIGN KEY (`blocked_space_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`blocked_space_agreement`(`blocked_space_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ADD CONSTRAINT `fk_network_capacity_allocation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ADD CONSTRAINT `fk_network_capacity_allocation_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ADD CONSTRAINT `fk_network_capacity_allocation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ADD CONSTRAINT `fk_network_capacity_allocation_revised_capacity_allocation_id` FOREIGN KEY (`revised_capacity_allocation_id`) REFERENCES `transport_shipping_ecm`.`network`.`capacity_allocation`(`capacity_allocation_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ADD CONSTRAINT `fk_network_blocked_space_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ADD CONSTRAINT `fk_network_blocked_space_agreement_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ADD CONSTRAINT `fk_network_blocked_space_agreement_renewed_blocked_space_agreement_id` FOREIGN KEY (`renewed_blocked_space_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`blocked_space_agreement`(`blocked_space_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ADD CONSTRAINT `fk_network_carrier_service_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ADD CONSTRAINT `fk_network_carrier_service_connecting_carrier_service_id` FOREIGN KEY (`connecting_carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ADD CONSTRAINT `fk_network_carrier_contact_carrier_profile_id` FOREIGN KEY (`carrier_profile_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_profile`(`carrier_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ADD CONSTRAINT `fk_network_carrier_contact_reports_to_carrier_contact_id` FOREIGN KEY (`reports_to_carrier_contact_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_contact`(`carrier_contact_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ADD CONSTRAINT `fk_network_network_event_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ADD CONSTRAINT `fk_network_network_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ADD CONSTRAINT `fk_network_network_event_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ADD CONSTRAINT `fk_network_network_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ADD CONSTRAINT `fk_network_partner_onboarding_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ADD CONSTRAINT `fk_network_partner_onboarding_reactivation_partner_onboarding_id` FOREIGN KEY (`reactivation_partner_onboarding_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_onboarding`(`partner_onboarding_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ADD CONSTRAINT `fk_network_partner_settlement_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ADD CONSTRAINT `fk_network_partner_settlement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ADD CONSTRAINT `fk_network_partner_settlement_reversed_partner_settlement_id` FOREIGN KEY (`reversed_partner_settlement_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_settlement`(`partner_settlement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ADD CONSTRAINT `fk_network_partner_sla_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ADD CONSTRAINT `fk_network_partner_sla_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ADD CONSTRAINT `fk_network_partner_sla_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ADD CONSTRAINT `fk_network_partner_sla_superseded_partner_sla_id` FOREIGN KEY (`superseded_partner_sla_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_sla`(`partner_sla_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ADD CONSTRAINT `fk_network_edi_connection_fallback_edi_connection_id` FOREIGN KEY (`fallback_edi_connection_id`) REFERENCES `transport_shipping_ecm`.`network`.`edi_connection`(`edi_connection_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ADD CONSTRAINT `fk_network_edi_connection_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`network` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `transport_shipping_ecm`.`network` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `parent_carrier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `api_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Enabled');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'airline|ocean_carrier|road_haulier|rail_operator|express_courier|nvocc');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_business_glossary_term' = 'Country of Registration');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `customs_brokerage_service` SET TAGS ('dbx_business_glossary_term' = 'Customs Brokerage Service Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `dangerous_goods_certified` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `edi_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `fiata_certified` SET TAGS ('dbx_business_glossary_term' = 'International Federation of Freight Forwarders Associations (FIATA) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `financial_standing` SET TAGS ('dbx_business_glossary_term' = 'Financial Standing');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `financial_standing` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|under_review');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `iata_certified` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `imo_number` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Organization (IMO) Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `insurance_currency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `insurance_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `iso_28000_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 28000 Supply Chain Security Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Management Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Legal Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Carrier Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Lifecycle Stage');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_value_regex' = 'prospect|due_diligence|contract_negotiation|integration|active|offboarding');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|blacklisted|under_review');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `otd_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `preferred_carrier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `service_scope` SET TAGS ('dbx_value_regex' = 'domestic|international|regional|global');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `temperature_controlled_capable` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Capable');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Trade Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `transport_modes` SET TAGS ('dbx_business_glossary_term' = 'Supported Transport Modes');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Carrier Website URL');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `carrier_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Profile ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `superseded_carrier_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `api_integration_available` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `api_protocol` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Protocol');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `api_protocol` SET TAGS ('dbx_value_regex' = 'rest|soap|graphql|proprietary|none');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `average_transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Transit Time (Days)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `carbon_reporting_available` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Reporting Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `claims_ratio_percentage` SET TAGS ('dbx_business_glossary_term' = 'Claims Ratio Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `countries_served` SET TAGS ('dbx_business_glossary_term' = 'Countries Served');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `cross_border_capable` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Shipping Capable');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `customs_brokerage_included` SET TAGS ('dbx_business_glossary_term' = 'Customs Brokerage Included');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `dangerous_goods_certified` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `dg_classes_handled` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Classes Handled');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `edi_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `equipment_types` SET TAGS ('dbx_business_glossary_term' = 'Equipment Types Operated');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `geographic_coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `geographic_coverage_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local|trade_lane_specific');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `insurance_coverage_available` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `last_mile_capable` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Delivery Capable');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `max_insurance_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Maximum Insurance Value (United States Dollars)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `max_volume_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Capacity (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `max_weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Capacity (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|onboarding|offboarding|restricted');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `otd_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Profile Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Profile Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Profile Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_value_regex' = 'asset_based|non_asset_based|hybrid|nvocc|freight_forwarder');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `quality_certifications` SET TAGS ('dbx_business_glossary_term' = 'Quality Certifications Held');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `real_time_tracking_available` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Tracking Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `regions_served` SET TAGS ('dbx_business_glossary_term' = 'Regions Served');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `security_rating` SET TAGS ('dbx_business_glossary_term' = 'Security Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `security_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_rated');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `service_types` SET TAGS ('dbx_business_glossary_term' = 'Service Types Offered');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `sustainability_certified` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `temperature_controlled_capable` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Capability');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Range (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Range (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `teu_capacity` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Capacity');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `tracking_granularity` SET TAGS ('dbx_business_glossary_term' = 'Tracking Granularity Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `tracking_granularity` SET TAGS ('dbx_value_regex' = 'real_time_gps|milestone_based|daily_update|manual|none');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `trade_lanes_covered` SET TAGS ('dbx_business_glossary_term' = 'Trade Lanes Covered');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ALTER COLUMN `transport_modes` SET TAGS ('dbx_business_glossary_term' = 'Transport Modes Offered');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `parent_agent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `agent_status` SET TAGS ('dbx_business_glossary_term' = 'Agent Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `agent_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `agent_type` SET TAGS ('dbx_business_glossary_term' = 'Agent Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `agent_type` SET TAGS ('dbx_value_regex' = 'freight_agent|gsa|handling_agent|customs_agent|co_loader|ground_handling_agent');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `bond_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Bond Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `bond_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `bonding_status` SET TAGS ('dbx_business_glossary_term' = 'Bonding Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `bonding_status` SET TAGS ('dbx_value_regex' = 'bonded|non_bonded|pending');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City of Operation');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `commission_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Structure Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `commission_structure_type` SET TAGS ('dbx_value_regex' = 'percentage|flat_fee|tiered|hybrid');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `dangerous_goods_certified` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `fiata_member` SET TAGS ('dbx_business_glossary_term' = 'International Federation of Freight Forwarders Associations (FIATA) Member');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `iata_agent_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Agent Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `iata_agent_code` SET TAGS ('dbx_value_regex' = '^[0-9]{7,8}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Management Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Legal Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agent Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `nvocc_licensed` SET TAGS ('dbx_business_glossary_term' = 'Non-Vessel Operating Common Carrier (NVOCC) Licensed');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `operational_scope` SET TAGS ('dbx_business_glossary_term' = 'Operational Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `operational_scope` SET TAGS ('dbx_value_regex' = 'local|regional|national|international');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `principal_carrier_relationships` SET TAGS ('dbx_business_glossary_term' = 'Principal Carrier Relationships');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Commission Rate');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Trade Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `transport_modes_supported` SET TAGS ('dbx_business_glossary_term' = 'Transport Modes Supported');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` SET TAGS ('dbx_subdomain' = 'operational_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `agent_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Appointment Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Appointed Agent Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Appointing Party Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `renewed_agent_appointment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `aeo_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `appointment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `appointment_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `appointment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `appointment_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `appointment_term_months` SET TAGS ('dbx_business_glossary_term' = 'Appointment Term in Months');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'freight_agent|gsa|correspondent|sub_agent|exclusive_agent|non_exclusive_agent');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `authorized_service_lines` SET TAGS ('dbx_business_glossary_term' = 'Authorized Service Lines');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `authorized_transport_modes` SET TAGS ('dbx_business_glossary_term' = 'Authorized Transport Modes');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `commission_basis` SET TAGS ('dbx_business_glossary_term' = 'Commission Basis');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `commission_basis` SET TAGS ('dbx_value_regex' = 'gross_revenue|net_revenue|margin|per_shipment|tiered');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `commission_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `commission_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `ctpat_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `customs_broker_license_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `iata_accreditation_flag` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Accreditation Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Agent Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `iata_code` SET TAGS ('dbx_value_regex' = '^[0-9]{7,8}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `insurance_coverage_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `insurance_coverage_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `insurance_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `minimum_revenue_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Revenue Commitment');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `minimum_revenue_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `minimum_revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Minimum Revenue Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `minimum_revenue_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appointment Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `nvocc_license_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Vessel Operating Common Carrier (NVOCC) License Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `performance_bond_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `performance_bond_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `performance_bond_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'automatic|mutual_consent|appointing_party_option|agent_option|no_renewal');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `territory_country_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `territory_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `territory_region` SET TAGS ('dbx_business_glossary_term' = 'Territory Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `territory_scope` SET TAGS ('dbx_value_regex' = 'national|regional|city|port|airport|station');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` SET TAGS ('dbx_subdomain' = 'operational_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `interline_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `renewed_interline_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `awb_prefix_allocation` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Prefix Allocation');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `commitment_period` SET TAGS ('dbx_business_glossary_term' = 'Commitment Period');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `commitment_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|contract_term');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Destination Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|iata_arbitration');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `iata_prorate_rule_reference` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Prorate Rule Reference');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `insurance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `insurance_requirement` SET TAGS ('dbx_value_regex' = 'none|carrier_liability|cargo_insurance|all_risk');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `liability_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `liability_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `prorate_methodology` SET TAGS ('dbx_business_glossary_term' = 'Prorate Methodology');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `prorate_methodology` SET TAGS ('dbx_value_regex' = 'mileage|segment|proportional|fixed|negotiated|iata_standard');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `revenue_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Split Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `revenue_split_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `sla_on_time_delivery_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On-Time Delivery Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `through_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Through-Billing Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `trade_lanes_covered` SET TAGS ('dbx_business_glossary_term' = 'Trade Lanes Covered');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_value_regex' = 'teu|ton|kg|cbm|shipment_count|pallet');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Provider ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `parent_tpl_provider_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `api_integration_available` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `cold_chain_capability` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Capability');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `customs_brokerage_capability` SET TAGS ('dbx_business_glossary_term' = 'Customs Brokerage Capability');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `distribution_capability` SET TAGS ('dbx_business_glossary_term' = 'Distribution Capability');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `edi_capability` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capability');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `financial_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `gdp_certified` SET TAGS ('dbx_business_glossary_term' = 'Good Distribution Practice (GDP) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `haccp_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis and Critical Control Points (HACCP) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `iso_28000_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 28000 Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `last_mile_delivery_capability` SET TAGS ('dbx_business_glossary_term' = 'Last-Mile Delivery Capability');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|onboarding|offboarding|pending_approval');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `preferred_provider_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Provider Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `provider_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `provider_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = '3PL|4PL|co-packer|value-added logistics|freight forwarder|NVOCC');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `reverse_logistics_capability` SET TAGS ('dbx_business_glossary_term' = 'Reverse Logistics Capability');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `tms_platform` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Platform');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `total_warehouse_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Warehouse Square Footage');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `value_added_services` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Services');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `warehousing_capability` SET TAGS ('dbx_business_glossary_term' = 'Warehousing Capability');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `wms_platform` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Platform');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `parent_partner_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `aeo_certification` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certification Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `bonded_warehouse_license` SET TAGS ('dbx_business_glossary_term' = 'Bonded Warehouse License Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `ctpat_certification` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certification Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `customs_broker_license` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `handling_capacity` SET TAGS ('dbx_business_glossary_term' = 'Handling Capacity');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `icao_code` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `icao_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `iso_certification` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Certification');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `network_participation_date` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `operational_scope` SET TAGS ('dbx_business_glossary_term' = 'Operational Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `partner_category` SET TAGS ('dbx_business_glossary_term' = 'Partner Category');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `partner_category` SET TAGS ('dbx_value_regex' = 'port_authority|airport_ground_handler|customs_broker|bonded_warehouse|freight_station|co_loading_partner');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `service_modes` SET TAGS ('dbx_business_glossary_term' = 'Service Modes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `un_locode` SET TAGS ('dbx_business_glossary_term' = 'United Nations Code for Trade and Transport Locations (UN/LOCODE)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `un_locode` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `partner_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Certification Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `renewed_partner_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_renewal|revoked|under_review');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `compliance_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `mandatory_for_commodity_types` SET TAGS ('dbx_business_glossary_term' = 'Mandatory for Commodity Types');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `mandatory_for_trade_lanes` SET TAGS ('dbx_business_glossary_term' = 'Mandatory for Trade Lanes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `non_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `non_compliance_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `renewal_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Certification Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope Description');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verification Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'online_registry|issuer_confirmation|document_review|third_party_audit|self_declaration');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` SET TAGS ('dbx_subdomain' = 'operational_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `partner_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `prior_partner_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `capacity_fulfillment_actual_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Fulfillment Actual Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `capacity_fulfillment_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Fulfillment Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `claims_rate_actual_pct` SET TAGS ('dbx_business_glossary_term' = 'Claims Rate Actual Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `claims_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Claims Rate Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Performance Score');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `damage_rate_actual_pct` SET TAGS ('dbx_business_glossary_term' = 'Damage Rate Actual Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `damage_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Damage Rate Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `documentation_accuracy_actual_pct` SET TAGS ('dbx_business_glossary_term' = 'Documentation Accuracy Actual Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `documentation_accuracy_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Documentation Accuracy Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `evaluation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Completed Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual|ad-hoc');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'domestic|regional|international|global');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `otd_rate_actual_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Rate Actual Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `otd_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Rate Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'continue|renew|probation|terminate|escalate');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `service_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `total_shipments_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Shipments Evaluated');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `total_volume_teu` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Twenty-foot Equivalent Unit (TEU)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kilograms');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `transit_time_compliance_actual_pct` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Compliance Actual Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `transit_time_compliance_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Compliance Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'improving|stable|declining');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` SET TAGS ('dbx_subdomain' = 'operational_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `capacity_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Allocation Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `blocked_space_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Blocked Space Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `revised_capacity_allocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocated_capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity in Pallet Positions');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocated_capacity_teu` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity in Twenty-foot Equivalent Units (TEU)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocated_capacity_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocated_capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_period_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'active|reserved|utilized|expired|cancelled|suspended');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `booking_cutoff_hours` SET TAGS ('dbx_business_glossary_term' = 'Booking Cutoff Hours');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `capacity_fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Fill Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `capacity_source_type` SET TAGS ('dbx_business_glossary_term' = 'Capacity Source Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `capacity_source_type` SET TAGS ('dbx_value_regex' = 'blocked_space|allotment|spot|contract|ad_hoc');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `commodity_restriction` SET TAGS ('dbx_business_glossary_term' = 'Commodity Restriction');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `minimum_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `minimum_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `overage_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Overage Rate Per Unit');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `overage_rate_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|standard');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `rollover_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_TM|ORACLE_TMS|BLUE_YONDER|MANUAL|API');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `utilized_capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Utilized Capacity in Pallet Positions');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `utilized_capacity_teu` SET TAGS ('dbx_business_glossary_term' = 'Utilized Capacity in Twenty-foot Equivalent Units (TEU)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `utilized_capacity_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Utilized Capacity Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `utilized_capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Utilized Capacity Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` SET TAGS ('dbx_subdomain' = 'operational_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `blocked_space_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Blocked Space Agreement (BSA) ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `renewed_blocked_space_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `agreement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'ocean_fcl|ocean_lcl|air_freight|multimodal');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `allocation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Allocation Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `allocation_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|per_voyage|per_flight');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `base_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Base Rate per Unit');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `blocked_space_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `blocked_space_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|pending_renewal');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'TEU|kg|CBM|pallets');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created by User');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Destination Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|litigation|mediation|negotiation');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `guaranteed_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Capacity Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `guaranteed_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Capacity Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `guaranteed_capacity_teu` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Capacity Twenty-foot Equivalent Unit (TEU)');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified by User');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `minimum_utilization_commitment_absolute` SET TAGS ('dbx_business_glossary_term' = 'Minimum Utilization Commitment Absolute');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `minimum_utilization_commitment_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Utilization Commitment Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `penalty_for_underutilization` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Under-Utilization');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|preferred|premium|guaranteed');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'automatic|mutual_consent|shipper_option|carrier_option|none');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `rollover_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `rollover_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Rollover Limit Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `signed_by_carrier` SET TAGS ('dbx_business_glossary_term' = 'Signed by Carrier');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `signed_by_transport_shipping` SET TAGS ('dbx_business_glossary_term' = 'Signed by Transport Shipping');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `connecting_carrier_service_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `carbon_neutral_certified` SET TAGS ('dbx_business_glossary_term' = 'Carbon Neutral Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `customs_clearance_included` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Included');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `cutoff_day_offset` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Day Offset');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `cutoff_time_local` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Time (Local)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `dangerous_goods_capable` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Capable');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Destination Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `dg_classes_supported` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Classes Supported');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `documentation_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Documentation Cutoff Time');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `door_to_door_available` SET TAGS ('dbx_business_glossary_term' = 'Door-to-Door (D2D) Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `equipment_types_supported` SET TAGS ('dbx_business_glossary_term' = 'Equipment Types Supported');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `flight_service_identifier` SET TAGS ('dbx_business_glossary_term' = 'Flight Service Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `frequency_per_week` SET TAGS ('dbx_business_glossary_term' = 'Frequency Per Week');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `incoterms_supported` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Supported');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `insurance_available` SET TAGS ('dbx_business_glossary_term' = 'Insurance Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `live_animal_capable` SET TAGS ('dbx_business_glossary_term' = 'Live Animal Capable');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `max_volume_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Capacity (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `max_weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Capacity (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `oversized_cargo_capable` SET TAGS ('dbx_business_glossary_term' = 'Oversized Cargo Capable');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `perishable_cargo_capable` SET TAGS ('dbx_business_glossary_term' = 'Perishable Cargo Capable');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'premium|standard|economy|basic');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|suspended|discontinued|seasonal|planned');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'direct|transshipment|feeder|express|economy|standard');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `temperature_controlled_capable` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Capable');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `tracking_available` SET TAGS ('dbx_business_glossary_term' = 'Tracking Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `tracking_granularity` SET TAGS ('dbx_business_glossary_term' = 'Tracking Granularity');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `tracking_granularity` SET TAGS ('dbx_value_regex' = 'real_time|milestone|daily|none');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `train_service_identifier` SET TAGS ('dbx_business_glossary_term' = 'Train Service Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time (Days)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Transit Time (Hours)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|courier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` ALTER COLUMN `vessel_service_identifier` SET TAGS ('dbx_business_glossary_term' = 'Vessel Service Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `carrier_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `carrier_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Profile Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `reports_to_carrier_contact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `emergency_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|portal|edi');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` SET TAGS ('dbx_subdomain' = 'operational_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `network_event_id` SET TAGS ('dbx_business_glossary_term' = 'Network Event ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `affected_airports` SET TAGS ('dbx_business_glossary_term' = 'Affected Airports');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `affected_countries` SET TAGS ('dbx_business_glossary_term' = 'Affected Countries');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `affected_ports` SET TAGS ('dbx_business_glossary_term' = 'Affected Ports');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `affected_regions` SET TAGS ('dbx_business_glossary_term' = 'Affected Regions');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `affected_trade_lanes` SET TAGS ('dbx_business_glossary_term' = 'Affected Trade Lanes');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `affected_transport_modes` SET TAGS ('dbx_business_glossary_term' = 'Affected Transport Modes');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `alternative_carrier_engaged` SET TAGS ('dbx_business_glossary_term' = 'Alternative Carrier Engaged');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `alternative_routing_available` SET TAGS ('dbx_business_glossary_term' = 'Alternative Routing Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `customer_notification_datetime` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date Time');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Event End Date Time');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `escalation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date Time');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `estimated_capacity_loss_teu` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capacity Loss Twenty-foot Equivalent Unit (TEU)');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `estimated_delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delay Hours');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `estimated_shipments_affected` SET TAGS ('dbx_business_glossary_term' = 'Estimated Shipments Affected');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|mitigated|resolved|closed');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `financial_impact_estimated_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimated United States Dollar (USD)');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `financial_impact_estimated_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `mitigation_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Actions Taken');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `operational_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Operational Impact Description');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `regulatory_authority_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notified');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `root_cause_details` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Details');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `sla_breach_count` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Count');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date Time');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` SET TAGS ('dbx_subdomain' = 'operational_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `partner_onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Onboarding ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `reactivation_partner_onboarding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `actual_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Activation Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `api_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `api_integration_status` SET TAGS ('dbx_value_regex' = 'not_required|not_started|in_progress|testing|live|failed');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `certification_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Verification Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `certification_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|missing|waived');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `certification_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Verified Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `contract_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `due_diligence_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completed Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `edi_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Integration Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `edi_integration_status` SET TAGS ('dbx_value_regex' = 'not_required|not_started|in_progress|testing|live|failed');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `financial_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Assessment Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `financial_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Assessment Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `financial_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|approved|rejected|conditional');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `geographic_scope_authorized` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope Authorized');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Initiated Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `insurance_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `insurance_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|insufficient|waived');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `insurance_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verified Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `kyc_check_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Check Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `kyc_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed|waived');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `kyc_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Completed Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `onboarding_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Duration Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `onboarding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `onboarding_reference_number` SET TAGS ('dbx_value_regex' = '^ONB-[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Stage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|on_hold|completed|cancelled|rejected');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `onboarding_type` SET TAGS ('dbx_value_regex' = 'new_partner|service_expansion|geographic_expansion|mode_addition|reactivation');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `operational_readiness_score` SET TAGS ('dbx_business_glossary_term' = 'Operational Readiness Score');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'carrier|agent|3pl|correspondent_office|nvocc|freight_forwarder');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `pre_qualification_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Qualification Completed Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|cleared|flagged|escalated');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `service_modes_authorized` SET TAGS ('dbx_business_glossary_term' = 'Service Modes Authorized');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `system_integration_completed_date` SET TAGS ('dbx_business_glossary_term' = 'System Integration Completed Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `target_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Activation Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `tms_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Integration Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `tms_integration_status` SET TAGS ('dbx_value_regex' = 'not_required|not_started|in_progress|testing|live|failed');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` SET TAGS ('dbx_subdomain' = 'operational_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `partner_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `interline_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `reversed_partner_settlement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `awb_count` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Count');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `gross_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|reconciled|discrepancy_found|disputed|resolved');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `scheduled_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `settlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `settlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `settlement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'interline_prorate|agent_commission|3pl_service_fee|capacity_penalty|handling_charge|fuel_surcharge');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Shipment Count');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `partner_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Service Level Agreement (SLA) ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `superseded_partner_sla_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `breach_threshold` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Destination Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `incentive_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Incentive Clause Reference');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `incentive_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Incentive Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `incentive_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `measurement_period_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'percentage|hours|days|minutes|count|ratio');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `penalty_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Reference');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `sla_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|terminated|draft|under_review');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `trade_lane` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `warning_threshold` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `edi_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Connection ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `fallback_edi_connection_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `acknowledgment_required` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `average_daily_message_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Message Volume');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `compression_enabled` SET TAGS ('dbx_business_glossary_term' = 'Compression Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `connection_health_status` SET TAGS ('dbx_business_glossary_term' = 'Connection Health Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `connection_health_status` SET TAGS ('dbx_value_regex' = 'HEALTHY|DEGRADED|CRITICAL|OFFLINE|UNKNOWN');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `connection_health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `connection_health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `connection_name` SET TAGS ('dbx_business_glossary_term' = 'Connection Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `connection_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Connection Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `connection_status` SET TAGS ('dbx_business_glossary_term' = 'Connection Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `connection_status` SET TAGS ('dbx_value_regex' = 'DRAFT|TESTING|ACTIVE|SUSPENDED|INACTIVE|TERMINATED');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `encryption_protocol` SET TAGS ('dbx_business_glossary_term' = 'Encryption Protocol');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `endpoint_host` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Host');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `endpoint_host` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `endpoint_port` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Port');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `interchange_control_reference_prefix` SET TAGS ('dbx_business_glossary_term' = 'Interchange Control Reference Prefix');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `last_failed_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failed Transmission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `last_successful_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Transmission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `max_retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `message_direction` SET TAGS ('dbx_business_glossary_term' = 'Message Direction');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `message_direction` SET TAGS ('dbx_value_regex' = 'INBOUND|OUTBOUND|BIDIRECTIONAL');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `message_format` SET TAGS ('dbx_business_glossary_term' = 'Message Format');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `message_format` SET TAGS ('dbx_value_regex' = 'XML|JSON|FLAT_FILE|CSV|FIXED_WIDTH|EDI_NATIVE');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `message_types_supported` SET TAGS ('dbx_business_glossary_term' = 'Message Types Supported');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `peak_message_volume` SET TAGS ('dbx_business_glossary_term' = 'Peak Message Volume');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `production_environment_status` SET TAGS ('dbx_business_glossary_term' = 'Production Environment Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `production_environment_status` SET TAGS ('dbx_value_regex' = 'NOT_CONFIGURED|CONFIGURED|ACTIVE|SUSPENDED|INACTIVE|DECOMMISSIONED');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `receiver_identifier` SET TAGS ('dbx_business_glossary_term' = 'Receiver Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `retry_policy` SET TAGS ('dbx_business_glossary_term' = 'Retry Policy');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `sender_identifier` SET TAGS ('dbx_business_glossary_term' = 'Sender Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `sla_response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Seconds');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `technical_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `technical_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `technical_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `test_environment_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Test Environment Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `test_environment_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `test_environment_status` SET TAGS ('dbx_business_glossary_term' = 'Test Environment Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `test_environment_status` SET TAGS ('dbx_value_regex' = 'NOT_CONFIGURED|CONFIGURED|TESTING|PASSED|FAILED');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Timeout Seconds');
