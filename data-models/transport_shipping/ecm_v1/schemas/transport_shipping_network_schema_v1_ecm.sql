-- Schema for Domain: network | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`network` COMMENT 'Manages partner network relationships including carrier profiles, agent networks, correspondent offices, interline agreements, and third-party logistics provider operational capabilities across all geographies and transport modes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Unique identifier for the carrier partner. Primary key for the carrier master record.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: Carrier is an external organization that should reference the unified partner master record. This enables unified partner reporting, tiering, and lifecycle management. No columns removed because carri',
    `parent_carrier_id` BIGINT COMMENT 'Self-referencing FK on carrier (parent_carrier_id)',
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
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: Agent is an external organization participating in the Transport Shipping network. The partner table is the unified master for all external organizations. Linking agent to partner enables unified part',
    `parent_agent_id` BIGINT COMMENT 'Self-referencing FK on agent (parent_agent_id)',
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
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the agent appointment. Null if appointment is not yet approved or approval is not tracked.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`correspondent_office` (
    `correspondent_office_id` BIGINT COMMENT 'Unique identifier for the correspondent office record. Primary key.',
    `partner_id` BIGINT COMMENT 'Reference to the parent network partner entity that owns or operates this correspondent office.',
    `parent_correspondent_office_id` BIGINT COMMENT 'Self-referencing FK on correspondent_office (parent_correspondent_office_id)',
    `address_line_1` STRING COMMENT 'Primary street address line of the correspondent office location, including building number and street name.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as suite, floor, or building name.',
    `aeo_certified` BOOLEAN COMMENT 'Indicates whether the correspondent office holds Authorized Economic Operator certification, demonstrating compliance with customs and supply chain security standards.',
    `agreement_renewal_date` DATE COMMENT 'The date when the representation agreement with the correspondent office is due for renewal or renegotiation.',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'The annual revenue target or quota assigned to the correspondent office for services provided on behalf of Transport Shipping.',
    `city` STRING COMMENT 'City or municipality where the correspondent office is located.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'The percentage commission rate applied to revenue generated by the correspondent office, if applicable under the revenue sharing model.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code identifying the country where the correspondent office is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this correspondent office record was first created in the system.',
    `ctpat_certified` BOOLEAN COMMENT 'Indicates whether the correspondent office is certified under the U.S. Customs-Trade Partnership Against Terrorism program for supply chain security.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial transactions and revenue reporting associated with the correspondent office.. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_capability` BOOLEAN COMMENT 'Indicates whether the correspondent office has the capability and authorization to perform customs clearance and trade compliance services.',
    `effective_end_date` DATE COMMENT 'The date when the correspondent office relationship with Transport Shipping ended or is scheduled to end. Null for active relationships.',
    `effective_start_date` DATE COMMENT 'The date when the correspondent office relationship with Transport Shipping became effective and operational.',
    `geographic_region` STRING COMMENT 'Broader geographic region or territory classification for the correspondent office, used for regional management and reporting.',
    `iata_office_code` STRING COMMENT 'Seven-character IATA office identifier code used for air freight and cargo operations, enabling global interline billing and settlement.. Valid values are `^[A-Z0-9]{7}$`',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the correspondent office holds ISO 9001 certification for quality management systems.',
    `language_support` STRING COMMENT 'Comma-separated list of languages supported by the correspondent office for customer service and operational communications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this correspondent office record was last updated or modified.',
    `last_performance_review_date` DATE COMMENT 'The date when the correspondent office last underwent a formal performance review or audit by Transport Shipping.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about the correspondent office relationship.',
    `office_code` STRING COMMENT 'Internal unique alphanumeric code assigned to the correspondent office for operational reference and system integration.. Valid values are `^[A-Z0-9]{3,10}$`',
    `office_email` STRING COMMENT 'General email address for the correspondent office for customer inquiries and business communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `office_fax` STRING COMMENT 'Fax number for the correspondent office, used for document transmission in regions where fax is still operationally relevant.',
    `office_name` STRING COMMENT 'The official business name of the correspondent office as it appears in legal and operational documents.',
    `office_phone` STRING COMMENT 'Main telephone number for the correspondent office for general inquiries and customer service.',
    `office_type` STRING COMMENT 'Classification of the correspondent office based on its operational and legal relationship with Transport Shipping. Correspondent offices operate under formal representation agreements and carry the Transport Shipping brand.. Valid values are `correspondent|representative|branch|franchise|agent|affiliate`',
    `operating_hours` STRING COMMENT 'Standard operating hours of the correspondent office, typically in format such as Mon-Fri 08:00-18:00, Sat 09:00-13:00.',
    `operational_status` STRING COMMENT 'Current operational status of the correspondent office indicating whether it is actively providing services on behalf of Transport Shipping.. Valid values are `active|inactive|suspended|pending_activation|terminated`',
    `performance_rating` STRING COMMENT 'Most recent performance rating assigned to the correspondent office based on service quality, compliance, and operational metrics.. Valid values are `excellent|good|satisfactory|needs_improvement|poor`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the correspondent office address, used for mail delivery and geographic classification.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person for operational communications and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the correspondent office responsible for operational coordination with Transport Shipping.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the correspondent office contact person.',
    `primary_contact_title` STRING COMMENT 'Job title or position of the primary contact person at the correspondent office.',
    `representation_agreement_type` STRING COMMENT 'Type of formal representation agreement governing the correspondent office relationship, defining exclusivity and scope of services.. Valid values are `exclusive|non_exclusive|limited_scope|full_service`',
    `revenue_sharing_model` STRING COMMENT 'The financial arrangement model defining how revenue is shared between Transport Shipping and the correspondent office for services rendered.. Valid values are `commission|fixed_fee|profit_share|hybrid|cost_plus`',
    `services_offered` STRING COMMENT 'Comma-separated list or description of logistics services offered by the correspondent office on behalf of Transport Shipping, such as express delivery, freight forwarding, customs brokerage, warehousing, last-mile delivery.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the correspondent office is located.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the correspondent office location, used for scheduling and coordination across geographies.',
    `transport_modes_supported` STRING COMMENT 'Comma-separated list of transport modes the correspondent office can handle, such as air, ocean, road, rail, multimodal.',
    `warehouse_facility_available` BOOLEAN COMMENT 'Indicates whether the correspondent office has access to warehouse or distribution facilities for cargo storage and handling.',
    `website_url` STRING COMMENT 'The website URL of the correspondent office, if available, for customer information and online service access.',
    CONSTRAINT pk_correspondent_office PRIMARY KEY(`correspondent_office_id`)
) COMMENT 'Master record for correspondent offices and overseas partner offices that represent Transport Shipping in geographies where it does not have a direct presence. Captures office name, parent network partner, city, country, office type (correspondent, representative, branch, franchise), IATA office code, contact details, services offered on behalf of Transport Shipping, revenue-sharing arrangement type, and operational status. Distinct from agent records — correspondent offices operate under a formal representation agreement and carry the Transport Shipping brand.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`interline_agreement` (
    `interline_agreement_id` BIGINT COMMENT 'Unique system identifier for the interline agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this interline agreement for activation.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`interline_prorate` (
    `interline_prorate_id` BIGINT COMMENT 'Unique identifier for the interline prorate transaction record.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment record associated with this prorate transaction.',
    `interline_agreement_id` BIGINT COMMENT 'Reference to the interline agreement under which this prorate calculation is performed.',
    `partner_settlement_id` BIGINT COMMENT 'Foreign key linking to network.partner_settlement. Business justification: Interline prorate records are the line-item details that roll up into partner settlements. This link enables settlement reconciliation and tracking of which prorate records have been settled. Removes ',
    `reversed_interline_prorate_id` BIGINT COMMENT 'Self-referencing FK on interline_prorate (reversed_interline_prorate_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any manual or system adjustment applied to the calculated prorate amount due to disputes, corrections, or special agreements.',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment made to the prorate amount.',
    `approved_by` STRING COMMENT 'The user or system identifier that approved this prorate calculation for settlement.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when this prorate calculation was approved for settlement.',
    `awb_number` STRING COMMENT 'The air waybill number identifying the shipment for which prorate revenue is being calculated. Format: 3-digit airline prefix followed by 8-digit serial number.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `billing_carrier_code` STRING COMMENT 'IATA or SCAC code of the carrier responsible for billing the customer and distributing prorate payments.. Valid values are `^[A-Z0-9]{2,3}$`',
    `calculation_date` DATE COMMENT 'The date on which the prorate calculation was performed.',
    `commodity_code` STRING COMMENT 'The HS code of the commodity being shipped, which may influence prorate calculations for specialized cargo.. Valid values are `^[0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this prorate record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the prorate revenue amounts.. Valid values are `^[A-Z]{3}$`',
    `destination_carrier_code` STRING COMMENT 'IATA or SCAC code of the carrier operating the destination segment of the interline movement.. Valid values are `^[A-Z0-9]{2,3}$`',
    `destination_station_code` STRING COMMENT 'IATA three-letter airport or UN/LOCODE station code for the destination of this carrier segment.. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this prorate transaction is under dispute between carriers.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if the dispute flag is true.',
    `distance_km` DECIMAL(18,2) COMMENT 'The distance in kilometers for this carrier segment, used for distance-based prorate calculations.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied if currency conversion was required for prorate settlement.',
    `exchange_rate_date` DATE COMMENT 'The date for which the exchange rate was applied.',
    `invoice_number` STRING COMMENT 'The invoice number associated with this prorate transaction for billing and settlement purposes.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this prorate record is currently active or has been superseded by a correction or adjustment.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this prorate record was last modified.',
    `origin_carrier_code` STRING COMMENT 'IATA or SCAC code of the carrier operating the origin segment of the interline movement.. Valid values are `^[A-Z0-9]{2,3}$`',
    `origin_station_code` STRING COMMENT 'IATA three-letter airport or UN/LOCODE station code for the origin of this carrier segment.. Valid values are `^[A-Z]{3}$`',
    `payment_due_date` DATE COMMENT 'The date by which the prorate payment is due to the receiving carrier.',
    `prorate_amount` DECIMAL(18,2) COMMENT 'The calculated revenue amount allocated to this carrier segment based on the prorate percentage and basis.',
    `prorate_basis` STRING COMMENT 'The method used to calculate the revenue split between carriers: weight-based, revenue-based, distance-based, flat rate, negotiated percentage, or mileage-based.. Valid values are `weight|revenue|distance|flat_rate|negotiated|mileage`',
    `prorate_factor` DECIMAL(18,2) COMMENT 'The calculated factor used in the prorate formula, derived from weight, distance, or other basis metrics.',
    `prorate_percentage` DECIMAL(18,2) COMMENT 'The percentage of total revenue allocated to this carrier segment, expressed as a decimal (e.g., 35.50 for 35.5%).',
    `receiving_carrier_code` STRING COMMENT 'IATA or SCAC code of the carrier receiving the prorate payment for this segment.. Valid values are `^[A-Z0-9]{2,3}$`',
    `remarks` STRING COMMENT 'Additional notes or comments regarding this prorate transaction.',
    `segment_sequence` STRING COMMENT 'Sequential order of this carrier segment within the multi-carrier interline routing.',
    `service_type` STRING COMMENT 'The type of service provided for this carrier segment.. Valid values are `express|standard|economy|charter|dedicated`',
    `settlement_period` STRING COMMENT 'The billing period for which this prorate is being settled, in YYYY-MM format.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `source_system` STRING COMMENT 'The operational system that originated this prorate record (e.g., SAP TM, Oracle TMS).',
    `special_handling_code` STRING COMMENT 'IATA three-letter special handling code indicating special cargo requirements (e.g., DGR for dangerous goods, PER for perishables).. Valid values are `^[A-Z]{3}$`',
    `total_revenue_amount` DECIMAL(18,2) COMMENT 'The total freight revenue for the shipment before prorate split calculation.',
    `transport_mode` STRING COMMENT 'The mode of transportation for this carrier segment.. Valid values are `air|ocean|road|rail|multimodal`',
    `weight_kg` DECIMAL(18,2) COMMENT 'The chargeable weight of the shipment in kilograms used for weight-based prorate calculations.',
    CONSTRAINT pk_interline_prorate PRIMARY KEY(`interline_prorate_id`)
) COMMENT 'Transactional prorate record capturing the revenue split calculation for a specific interline shipment or traffic unit exchanged under an interline agreement. Captures interline agreement reference, shipment or AWB reference, origin and destination carrier segments, revenue amount, prorate percentage applied, prorate basis (weight, revenue, distance), currency, settlement period, and settlement status. Enables accurate interline revenue accounting and carrier settlement reconciliation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`tpl_provider` (
    `tpl_provider_id` BIGINT COMMENT 'Unique identifier for the third-party logistics provider record. Primary key.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: TPL provider is an external organization in the network that should reference the unified partner master. This enables consistent partner lifecycle management across all partner types. No columns remo',
    `parent_tpl_provider_id` BIGINT COMMENT 'Self-referencing FK on tpl_provider (parent_tpl_provider_id)',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`tpl_capability` (
    `tpl_capability_id` BIGINT COMMENT 'Unique identifier for the 3PL/4PL provider capability record. Primary key.',
    `facility_id` BIGINT COMMENT 'Reference to the specific facility or site where this capability is available.',
    `tpl_provider_id` BIGINT COMMENT 'Reference to the 3PL or 4PL provider organization offering this capability.',
    `parent_tpl_capability_id` BIGINT COMMENT 'Self-referencing FK on tpl_capability (parent_tpl_capability_id)',
    `aeo_certified` BOOLEAN COMMENT 'Indicates whether the provider holds AEO certification for trusted trader status.',
    `api_integration_available` BOOLEAN COMMENT 'Indicates whether the provider offers API integration for real-time system connectivity.',
    `bonded_warehouse_certified` BOOLEAN COMMENT 'Indicates whether the facility is certified as a bonded warehouse for customs-deferred storage.',
    `capability_code` STRING COMMENT 'Standardized code identifying the type of logistics capability (e.g., AMB_WH, COLD_STOR, BONDED_WH, CROSS_DOCK, KITTING, RET_PROC, CUST_BROK).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `capability_name` STRING COMMENT 'Human-readable name of the logistics capability offered (e.g., Ambient Warehousing, Cold Storage, Bonded Warehouse, Cross-Docking, Kitting and Assembly, Returns Processing, Customs Brokerage).',
    `capability_status` STRING COMMENT 'Current operational status of this capability at the facility. Active indicates the capability is fully operational and available for partner selection.. Valid values are `active|inactive|suspended|planned|decommissioned|under_review`',
    `capability_type` STRING COMMENT 'Primary classification of the logistics service capability. [ENUM-REF-CANDIDATE: warehousing|cold_storage|bonded_warehouse|cross_docking|kitting|returns_processing|customs_brokerage|freight_forwarding|value_added_services|transportation|fulfillment — promote to reference product]. Valid values are `warehousing|cold_storage|bonded_warehouse|cross_docking|kitting|returns_processing`',
    `capacity_cbm` DECIMAL(18,2) COMMENT 'Total volumetric storage capacity in cubic meters, used for space planning and utilization analysis.',
    `capacity_pallet_positions` STRING COMMENT 'Total number of pallet positions available for storage, relevant for warehousing capabilities.',
    `capacity_sqm` DECIMAL(18,2) COMMENT 'Total available floor space capacity in square meters for warehousing or storage capabilities.',
    `cost_per_pallet_per_month` DECIMAL(18,2) COMMENT 'Standard monthly storage cost per pallet position for warehousing capabilities, used for cost modeling and partner selection.',
    `cost_per_unit_handled` DECIMAL(18,2) COMMENT 'Standard handling cost per unit (carton, parcel, or SKU) for throughput-based capabilities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capability record was first created in the system.',
    `ctpat_certified` BOOLEAN COMMENT 'Indicates whether the provider is C-TPAT certified for supply chain security.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all cost and pricing fields (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `edi_capable` BOOLEAN COMMENT 'Indicates whether the provider supports EDI integration for automated data exchange.',
    `effective_from_date` DATE COMMENT 'Date from which this capability became or will become operational and available for partner selection.',
    `effective_to_date` DATE COMMENT 'Date until which this capability remains operational. Null indicates an open-ended capability.',
    `equipment_types` STRING COMMENT 'Comma-separated list of material handling equipment available at the facility (e.g., forklifts, pallet jacks, conveyors, automated sorters, cranes).',
    `ftz_certified` BOOLEAN COMMENT 'Indicates whether the facility operates within or is certified as a Free Trade Zone.',
    `geographic_coverage` STRING COMMENT 'Geographic regions or countries served from this capability location, using ISO 3166-1 alpha-3 country codes.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the facility is certified to handle hazardous materials per IMDG Code or ICAO Technical Instructions.',
    `iot_enabled` BOOLEAN COMMENT 'Indicates whether the facility uses IoT sensors for real-time monitoring and tracking.',
    `iso_28000_certified` BOOLEAN COMMENT 'Indicates whether the facility is certified to ISO 28000 supply chain security management standards.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the facility is certified to ISO 9001 quality management system standards.',
    `last_audit_date` DATE COMMENT 'Date of the most recent operational or compliance audit conducted for this capability.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next operational or compliance audit of this capability.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, restrictions, or special conditions related to this capability.',
    `operating_hours` STRING COMMENT 'Standard operating hours for this capability (e.g., 24/7, business hours, shift-based).',
    `rfid_enabled` BOOLEAN COMMENT 'Indicates whether the facility uses RFID technology for inventory tracking and visibility.',
    `service_level` STRING COMMENT 'Service level tier offered for this capability, defining performance expectations and pricing.. Valid values are `standard|premium|express|economy`',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature capability in Celsius for cold storage or temperature-controlled capabilities.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature capability in Celsius for cold storage or temperature-controlled capabilities.',
    `throughput_units_per_day` STRING COMMENT 'Maximum daily processing throughput capacity measured in units (cartons, parcels, or SKUs) that can be handled.',
    `tms_system_name` STRING COMMENT 'Name of the Transportation Management System operated for this capability (e.g., SAP TM, Oracle TMS, Blue Yonder).',
    `transport_modes_supported` STRING COMMENT 'Comma-separated list of transport modes supported (e.g., air, ocean, road, rail, multimodal).',
    `updated_by_user` STRING COMMENT 'Identifier of the user or system that last updated this capability record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capability record was last modified.',
    `value_added_services` STRING COMMENT 'Comma-separated list of additional value-added services offered (e.g., labeling, packaging, quality inspection, kitting, assembly, returns management).',
    `wms_system_name` STRING COMMENT 'Name of the Warehouse Management System operated at this facility (e.g., Manhattan WMS, SAP EWM, Oracle WMS).',
    CONSTRAINT pk_tpl_capability PRIMARY KEY(`tpl_capability_id`)
) COMMENT 'Operational capability record detailing the specific logistics services and infrastructure a 3PL/4PL provider offers at a given facility or geography. Captures provider reference, facility location, capability type (ambient warehousing, cold storage, bonded warehouse, cross-docking, kitting, returns processing, customs brokerage), capacity metrics (sqm, pallet positions, throughput units/day), equipment available, technology systems operated (WMS, TMS), and capability status. Enables capability-based partner selection for outsourced logistics operations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner` (
    `partner_id` BIGINT COMMENT 'Unique identifier for the network partner record. Primary key.',
    `partner_tier_id` BIGINT COMMENT 'Foreign key linking to network.partner_tier. Business justification: Partner should reference its current tier classification directly. While partner_performance and partner_sla already reference partner_tier, the partner master itself should carry its current tier for',
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
    `partner_tier_id` BIGINT COMMENT 'Foreign key linking to network.partner_tier. Business justification: Partner performance evaluations should capture which tier the partner was assigned during that evaluation period. This enables tier-based performance analysis and supports tier upgrade/downgrade decis',
    `employee_id` BIGINT COMMENT 'Reference to the employee or team responsible for conducting this performance evaluation.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created the capacity allocation record.',
    `lane_id` BIGINT COMMENT 'Reference to the trade lane (origin-destination corridor) for which capacity is allocated.',
    `revised_capacity_allocation_id` BIGINT COMMENT 'Self-referencing FK on capacity_allocation (revised_capacity_allocation_id)',
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
    `lane_id` BIGINT COMMENT 'Reference to the specific trade lane (origin-destination corridor) covered by this blocked space agreement, such as Asia-Europe or Trans-Pacific.',
    `renewed_blocked_space_agreement_id` BIGINT COMMENT 'Self-referencing FK on blocked_space_agreement (renewed_blocked_space_agreement_id)',
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
    `secondary_email_address` STRING COMMENT 'Alternate email address for the contact, used for backup communication or escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `time_zone` STRING COMMENT 'Time zone where the contact is located, specified in IANA time zone database format (e.g., America/New_York, Europe/London, Asia/Singapore).',
    CONSTRAINT pk_carrier_contact PRIMARY KEY(`carrier_contact_id`)
) COMMENT 'Master record for key contacts at carrier and network partner organizations, capturing the individuals responsible for commercial, operational, and technical liaison with Transport Shipping. Captures carrier or partner reference, contact full name, job title, department, contact type (commercial, operations, claims, documentation, IT/EDI), email, phone, preferred communication channel, and active status. Enables relationship management and escalation routing across the partner network.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`network_event` (
    `network_event_id` BIGINT COMMENT 'Unique identifier for the network event record. Primary key.',
    `agent_id` BIGINT COMMENT 'Identifier of the agent or correspondent office affected by this network event. References the agent master entity.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier affected by this network event. References the carrier master entity.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Network events often affect specific carrier services (e.g., flight delays, vessel schedule changes, service suspensions). This link enables service-level event tracking and impact analysis. Nullable ',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Network disruptions caused by safety incidents (facility closures, route suspensions, carrier service interruptions) require linking to the incident for root cause analysis, customer communication, an',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to network.hub_gateway. Business justification: Network events frequently occur at specific hub/gateway locations (e.g., port congestion, airport closures, hub facility issues). This link enables location-based event tracking and impact analysis. N',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that reported this network event.',
    `related_network_event_id` BIGINT COMMENT 'Self-referencing FK on network_event (related_network_event_id)',
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
    `partner_name` STRING COMMENT 'Name of the partner organization affected by the network event, including carriers, agents, or third-party logistics (3PL) providers.',
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
    `employee_id` BIGINT COMMENT 'Reference to the internal employee responsible for managing this onboarding process. Primary point of accountability.',
    `quaternary_partner_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this onboarding record. Establishes accountability for changes.',
    `tertiary_partner_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the user who provided final approval for partner activation. Establishes accountability for the approval decision.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_tariff` (
    `partner_tariff_id` BIGINT COMMENT 'Unique identifier for the partner tariff master record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Partner tariffs are defined in contract agreements. Currently has contract_reference_number (string) but needs proper FK for referential integrity. The contract_reference_number can remain as a busine',
    `employee_id` BIGINT COMMENT 'Identifier of the user or procurement manager who approved this tariff for operational use.',
    `partner_id` BIGINT COMMENT 'Reference to the network partner (carrier, agent, 3PL provider) to whom this tariff applies.',
    `superseded_partner_tariff_id` BIGINT COMMENT 'Self-referencing FK on partner_tariff (superseded_partner_tariff_id)',
    `approval_date` DATE COMMENT 'Date on which the tariff was formally approved and authorized for use in procurement and rate calculation.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the tariff automatically renews upon expiry or requires explicit renegotiation.',
    `base_rate` DECIMAL(18,2) COMMENT 'The foundational rate amount per unit as negotiated with the partner, excluding surcharges and adjustments.',
    `contract_reference_number` STRING COMMENT 'Reference to the master contract or agreement document under which this tariff is governed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tariff master record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the tariff rates are denominated.. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_included_flag` BOOLEAN COMMENT 'Indicates whether customs brokerage and clearance services are included in the tariff or charged separately.',
    `dangerous_goods_applicable_flag` BOOLEAN COMMENT 'Indicates whether this tariff applies to shipments containing dangerous goods as classified under IMDG or IATA DGR.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code representing the destination geography for this tariff scope.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base rate as part of the negotiated tariff agreement.',
    `effective_date` DATE COMMENT 'The date from which this tariff becomes valid and applicable for rate calculation.',
    `escalation_clause` STRING COMMENT 'Description of any rate escalation or adjustment mechanism tied to external indices (e.g., fuel price index, inflation index, GRI).',
    `expiry_date` DATE COMMENT 'The date on which this tariff ceases to be valid, after which rates must be renegotiated or renewed.',
    `fuel_surcharge_included_flag` BOOLEAN COMMENT 'Indicates whether fuel surcharge (BAF for ocean, FSC for air/road) is included in the base rate or applied separately.',
    `geographic_scope` STRING COMMENT 'Breadth of geographic coverage for the tariff structure.. Valid values are `global|regional|country|city_pair|port_pair|lane_specific`',
    `incoterm` STRING COMMENT 'The Incoterm governing the allocation of costs, risks, and responsibilities between Transport Shipping and the partner under this tariff. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_included_flag` BOOLEAN COMMENT 'Indicates whether cargo insurance coverage is included in the tariff rate or must be purchased separately.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tariff master record was last updated or modified.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum charge cap applicable per shipment or transaction under this tariff structure.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount applicable per shipment or transaction under this tariff, regardless of actual weight or volume.',
    `minimum_volume_commitment` DECIMAL(18,2) COMMENT 'Minimum volume (in units consistent with rate_basis) that Transport Shipping commits to procure under this tariff during the validity period.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or operational notes related to the tariff.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code representing the origin geography for this tariff scope.. Valid values are `^[A-Z]{3}$`',
    `payment_term_days` STRING COMMENT 'Number of days from invoice date within which Transport Shipping must settle payment to the partner under this tariff.',
    `rate_basis` STRING COMMENT 'Unit of measure on which the tariff rate is calculated (e.g., per kilogram, per TEU, per cubic meter). [ENUM-REF-CANDIDATE: per_kg|per_teu|per_cbm|per_pallet|per_shipment|per_container|per_mile|per_km — 8 candidates stripped; promote to reference product]',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiry by which either party must provide notice if they do not wish to renew the tariff.',
    `security_surcharge_included_flag` BOOLEAN COMMENT 'Indicates whether security-related surcharges are included in the base rate or applied separately.',
    `service_type` STRING COMMENT 'Type of logistics service covered by the tariff (e.g., express, standard, economy, FCL, LCL, FTL, LTL).',
    `tariff_name` STRING COMMENT 'Descriptive name of the tariff structure for business identification and reporting purposes.',
    `tariff_reference_number` STRING COMMENT 'External business identifier for the tariff, typically provided by the partner or assigned during negotiation.',
    `tariff_status` STRING COMMENT 'Current lifecycle status of the tariff master record.. Valid values are `draft|active|suspended|expired|terminated|pending_approval`',
    `tariff_type` STRING COMMENT 'Classification of the tariff structure governing the rate agreement type.. Valid values are `buy_rate|spot_rate|contract_rate|volume_rate|seasonal_rate|promotional_rate`',
    `temperature_controlled_applicable_flag` BOOLEAN COMMENT 'Indicates whether this tariff applies to temperature-controlled or refrigerated shipments.',
    `terminal_handling_included_flag` BOOLEAN COMMENT 'Indicates whether terminal handling charges are included in the base tariff rate or billed separately.',
    `trade_lane` STRING COMMENT 'Specific trade lane or route corridor covered by this tariff (e.g., Asia-Europe, Transpacific, Transatlantic).',
    `transport_mode` STRING COMMENT 'Primary mode of transport covered by this tariff structure.. Valid values are `air|ocean|road|rail|multimodal|courier`',
    `validity_period_days` STRING COMMENT 'Total number of days for which the tariff remains valid, calculated from effective date to expiry date.',
    `volume_commitment_required_flag` BOOLEAN COMMENT 'Indicates whether this tariff requires Transport Shipping to commit to a minimum volume or revenue threshold.',
    `volume_commitment_unit` STRING COMMENT 'Unit of measure for the minimum volume commitment (aligned with rate_basis).. Valid values are `kg|teu|cbm|shipments|pallets|containers`',
    CONSTRAINT pk_partner_tariff PRIMARY KEY(`partner_tariff_id`)
) COMMENT 'Master record for buy-side tariff structures negotiated with network partners (carriers, agents, 3PL providers) governing the rates Transport Shipping pays for procured transport and logistics services. Captures partner reference, tariff name, transport mode, trade lane or geographic scope, service type, rate basis (per kg, per TEU, per CBM, per pallet), base rate, currency, surcharge inclusions, validity period, and tariff status. Distinct from pricing.carrier_buy_rate (which is the rate line level) — this is the tariff master governing the rate structure.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_settlement` (
    `partner_settlement_id` BIGINT COMMENT 'Unique identifier for the partner settlement transaction. Primary key for the partner settlement record.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this settlement for payment processing.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`coverage` (
    `coverage_id` BIGINT COMMENT 'Unique identifier for the network coverage record. Primary key.',
    `agent_id` BIGINT COMMENT 'Agent providing service in this coverage area when carrier is not directly servicing.',
    `coverage_backup_agent_id` BIGINT COMMENT 'Secondary or backup agent available for this coverage area when primary agent is unavailable.',
    `carrier_id` BIGINT COMMENT 'Secondary or backup carrier available for this coverage area when primary partner is unavailable or at capacity.',
    `coverage_carrier_id` BIGINT COMMENT 'Primary carrier or partner providing service in this coverage area.',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Coverage defines geographic service coverage provided by network partners. Currently only carrier and agent are referenced. In logistics, 3PL providers also provide geographic coverage and should be t',
    `parent_coverage_id` BIGINT COMMENT 'Self-referencing FK on coverage (parent_coverage_id)',
    `city_name` STRING COMMENT 'City or municipality name covered by this service area.',
    `cod_available` BOOLEAN COMMENT 'Indicates whether Cash on Delivery payment collection service is available in this coverage area.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the coverage territory.. Valid values are `^[A-Z]{3}$`',
    `coverage_code` STRING COMMENT 'Business identifier code for the coverage area, used for operational reference and partner communication.. Valid values are `^[A-Z0-9]{6,12}$`',
    `coverage_status` STRING COMMENT 'Current operational status of coverage in this area: active (full service), limited (restricted capacity or service days), suspended (temporarily unavailable), inactive (no longer serviced), or planned (future launch).. Valid values are `active|limited|suspended|inactive|planned`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network coverage record was first created in the system.',
    `customs_clearance_available` BOOLEAN COMMENT 'Indicates whether customs brokerage and clearance services are available through this partner in this coverage area.',
    `cutoff_time_local` STRING COMMENT 'Local cutoff time (HH:MM format) for same-day or next-service dispatch in this coverage area.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `dangerous_goods_accepted` BOOLEAN COMMENT 'Indicates whether dangerous goods (hazardous materials) are accepted for transport in this coverage area.',
    `dg_classes_accepted` STRING COMMENT 'Comma-separated list of UN dangerous goods classes accepted (e.g., 1,3,4,5,6,8,9). Empty if dangerous goods not accepted.',
    `effective_date` DATE COMMENT 'Date when this coverage arrangement becomes active and operational.',
    `expiry_date` DATE COMMENT 'Date when this coverage arrangement expires or is scheduled for review. Null for indefinite coverage.',
    `granularity` STRING COMMENT 'Level of geographic precision for this coverage record: country-level, region/state-level, city-level, postal zone-level, or address-level.. Valid values are `country|region|city|postal_zone|address`',
    `insurance_available` BOOLEAN COMMENT 'Indicates whether cargo insurance coverage is available for shipments in this coverage area.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this network coverage record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this coverage arrangement was last reviewed or audited for performance and compliance.',
    `max_dimensions_cm` STRING COMMENT 'Maximum shipment dimensions in centimeters, formatted as LxWxH (e.g., 120x80x100).',
    `max_transit_time_hours` STRING COMMENT 'Maximum expected transit time in hours from origin to destination within this coverage area, accounting for delays and routing variations.',
    `max_volume_cbm` DECIMAL(18,2) COMMENT 'Maximum shipment volume in cubic meters accepted for this coverage area and service type.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum shipment weight in kilograms accepted for this coverage area and service type.',
    `min_transit_time_hours` STRING COMMENT 'Minimum expected transit time in hours from origin to destination within this coverage area under optimal conditions.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next performance review or coverage audit.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or coverage-specific remarks.',
    `partner_type` STRING COMMENT 'Type of partner providing coverage: carrier (direct transport operator), agent (local representative), 3PL (third-party logistics provider), NVOCC (non-vessel operating common carrier), correspondent (overseas office), or interline (partner carrier under agreement).. Valid values are `carrier|agent|3pl|nvocc|correspondent|interline`',
    `performance_rating` STRING COMMENT 'Current performance tier or rating of the partner for this coverage area based on historical OTD, claims ratio, and service quality.. Valid values are `platinum|gold|silver|bronze|unrated`',
    `pod_electronic_available` BOOLEAN COMMENT 'Indicates whether electronic proof of delivery (digital signature, photo) is available in this coverage area.',
    `postal_zone` STRING COMMENT 'Postal code or postal zone range covered (e.g., 10001-10299, M5H*, SW1A). Supports wildcard patterns for zone ranges.',
    `primary_partner_flag` BOOLEAN COMMENT 'Indicates whether this partner is the primary/preferred provider for this coverage area (true) or a secondary/backup option (false).',
    `real_time_tracking_available` BOOLEAN COMMENT 'Indicates whether real-time GPS or IoT-based shipment tracking is available in this coverage area.',
    `region_code` STRING COMMENT 'Sub-national region, state, or province code within the country (e.g., CA for California, ON for Ontario).. Valid values are `^[A-Z0-9]{2,6}$`',
    `service_days` STRING COMMENT 'Days of the week when service is available (e.g., Mon-Fri, Mon-Sat, Daily). Free-text field to accommodate various patterns.',
    `service_frequency` STRING COMMENT 'Frequency of service availability in this coverage area: daily, weekly, biweekly, monthly, on_demand (as requested), or scheduled (fixed timetable).. Valid values are `daily|weekly|biweekly|monthly|on_demand|scheduled`',
    `service_scope` STRING COMMENT 'Geographic scope of service: domestic (within country), international (between countries), cross_border (customs clearance included), or regional (multi-country zone).. Valid values are `domestic|international|cross_border|regional`',
    `service_type` STRING COMMENT 'Type of service offered in this coverage area: express (time-definite), standard (deferred), economy (lowest cost), freight (bulk/palletized), last_mile (final delivery), or D2D (door-to-door).. Valid values are `express|standard|economy|freight|last_mile|d2d`',
    `sla_otd_target_pct` DECIMAL(18,2) COMMENT 'Target on-time delivery percentage committed by the partner for this coverage area, expressed as a percentage (e.g., 95.00 for 95%).',
    `standard_transit_time_hours` STRING COMMENT 'Typical or average transit time in hours used for planning and customer communication.',
    `suspension_end_date` DATE COMMENT 'Expected date when coverage will resume after suspension, if known.',
    `suspension_reason` STRING COMMENT 'Reason for coverage suspension if status is suspended (e.g., partner capacity constraints, regulatory restrictions, seasonal closure, force majeure).',
    `suspension_start_date` DATE COMMENT 'Date when coverage suspension began, if applicable.',
    `temperature_controlled_available` BOOLEAN COMMENT 'Indicates whether temperature-controlled (reefer) transport is available in this coverage area.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the coverage area (e.g., America/New_York, Europe/London, Asia/Singapore).',
    `transport_mode` STRING COMMENT 'Primary mode of transport used for this coverage area: air, ocean (sea freight), road (trucking), rail, or multimodal (combination).. Valid values are `air|ocean|road|rail|multimodal`',
    CONSTRAINT pk_coverage PRIMARY KEY(`coverage_id`)
) COMMENT 'Reference master defining the geographic service coverage provided by the Transport Shipping partner network, mapping countries, cities, and postal zones to the carriers, agents, and 3PL providers that service them. Captures coverage territory (country, region, city, postal zone), transport mode, service type, primary carrier or partner, secondary/backup partner, transit time range, service frequency, and coverage status (active, limited, suspended). Enables origin-destination serviceability checks and partner selection for specific geographies.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_sla` (
    `partner_sla_id` BIGINT COMMENT 'Unique identifier for the partner service level agreement record.',
    `agent_id` BIGINT COMMENT 'Reference to the agent if the partner is an agent entity.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier if the partner is a carrier entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or authority who approved this partner SLA commitment.',
    `partner_id` BIGINT COMMENT 'Reference to the network partner (carrier, agent, 3PL provider) to whom this SLA applies.',
    `partner_tier_id` BIGINT COMMENT 'Foreign key linking to network.partner_tier. Business justification: Partner SLAs should reference the partner tier to establish baseline service level expectations. Different tiers (e.g., platinum, gold, silver) typically have different SLA commitments. This link enab',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_incident` (
    `partner_incident_id` BIGINT COMMENT 'Unique identifier for the partner incident record. Primary key.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Partner incidents are often tied to specific carrier services (e.g., repeated delays on a particular service, quality issues on a specific route). This link enables service-level incident tracking and',
    `partner_id` BIGINT COMMENT 'Reference to the network partner (carrier, agent, 3PL, NVOCC) against whom this incident is raised. Links to the partner master entity.',
    `partner_sla_id` BIGINT COMMENT 'Foreign key linking to network.partner_sla. Business justification: Partner incidents often represent SLA breaches (partner_incident already has sla_breach_flag). Linking to the specific SLA that was breached enables proper SLA breach tracking, penalty calculation, an',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or employee who reported and logged this incident.',
    `incident_id` BIGINT COMMENT 'Reference to a previous or related incident record if this is a recurrence or linked issue.',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Partner incidents that escalate to HSE recordable events must link to the formal incident record for OSHA reporting, regulatory compliance, investigation coordination, and corrective action tracking. ',
    `tertiary_partner_assigned_to_user_employee_id` BIGINT COMMENT 'Reference to the internal user or case manager currently responsible for managing this incident through resolution.',
    `related_partner_incident_id` BIGINT COMMENT 'Self-referencing FK on partner_incident (related_partner_incident_id)',
    `affected_shipment_references` STRING COMMENT 'Comma-separated list of shipment identifiers (AWB, BOL, tracking numbers) that were impacted by this incident. Enables impact quantification.',
    `affected_trade_lanes` STRING COMMENT 'Comma-separated list of trade lane codes or origin-destination pairs affected by this incident. Used for geographic impact analysis.',
    `closure_date` DATE COMMENT 'The date on which the incident record was formally closed after all follow-up actions were completed.',
    `contract_reference` STRING COMMENT 'Reference to the contract or agreement under which this partner operates and against which SLA compliance is measured.',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which the partner must implement the required corrective action. Used for compliance tracking.',
    `corrective_action_required` STRING COMMENT 'Description of the corrective action plan required from the partner to prevent recurrence of this incident type.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this incident record was first created in the system. Used for audit trail and lifecycle tracking.',
    `customer_impact_flag` BOOLEAN COMMENT 'Indicates whether this partner incident resulted in direct impact to end customers (delays, damage, service failures).',
    `escalation_date` DATE COMMENT 'The date on which the incident was escalated to a higher management tier or executive level.',
    `escalation_level` STRING COMMENT 'The escalation tier to which this incident has been raised based on severity and partner responsiveness.. Valid values are `none|tier_1|tier_2|executive`',
    `financial_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `financial_impact_estimate_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the incident in the specified currency. Includes direct costs, penalties, and potential revenue loss.',
    `incident_date` DATE COMMENT 'The date on which the incident occurred or was first identified. Used for trend analysis and partner performance evaluation.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident, including what happened, when, and the immediate impact observed.',
    `incident_reference_number` STRING COMMENT 'Externally visible unique reference number assigned to this incident for tracking and communication purposes.. Valid values are `^INC-[A-Z0-9]{8,12}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident. Tracks progression from initial report through resolution and closure.. Valid values are `open|under_investigation|partner_response_pending|corrective_action_pending|resolved|closed`',
    `incident_type` STRING COMMENT 'Classification of the incident raised against the partner. Determines the handling workflow and escalation path.. Valid values are `service_failure|capacity_default|documentation_error|compliance_breach|safety_incident|quality_issue`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this incident record was last updated. Tracks the most recent change to any field in the record.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or observations related to the incident investigation and resolution process.',
    `partner_response` STRING COMMENT 'The partners formal response to the incident, including their explanation, acknowledgment, and proposed remediation.',
    `partner_response_date` DATE COMMENT 'The date on which the partner provided their formal response to the incident.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty amount assessed against the partner for this incident, if applicable.',
    `penalty_applied_flag` BOOLEAN COMMENT 'Indicates whether a contractual penalty or financial deduction was applied to the partner as a result of this incident.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this incident is a recurrence of a previously reported and resolved incident with the same partner.',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier of the regulatory report filed for this incident, if applicable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this incident must be reported to regulatory authorities (e.g., safety incidents, dangerous goods violations, customs breaches).',
    `reported_date` DATE COMMENT 'The date on which the incident was formally reported and logged into the system.',
    `resolution_date` DATE COMMENT 'The date on which the incident was resolved and corrective actions were verified as complete.',
    `root_cause` STRING COMMENT 'Identified root cause of the incident after investigation. May be populated after initial report during investigation phase.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause for trend analysis and corrective action planning. [ENUM-REF-CANDIDATE: operational|process|system|human_error|external|capacity|documentation — 7 candidates stripped; promote to reference product]',
    `severity_level` STRING COMMENT 'Business impact severity classification of the incident. Critical incidents require immediate escalation and corrective action.. Valid values are `critical|high|medium|low`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this incident constitutes a breach of contractual SLA commitments.',
    CONSTRAINT pk_partner_incident PRIMARY KEY(`partner_incident_id`)
) COMMENT 'Transactional record capturing formal incidents raised against network partners for service failures, compliance breaches, capacity defaults, or operational non-conformances. Captures partner reference, incident type (service failure, capacity default, documentation error, compliance breach, safety incident), incident date, affected shipments or trade lanes, severity level, financial impact estimate, root cause, corrective action required, partner response, and resolution status. Drives partner accountability and feeds into partner performance scoring.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`edi_connection` (
    `edi_connection_id` BIGINT COMMENT 'Unique identifier for the EDI or API integration connection record. Primary key.',
    `partner_id` BIGINT COMMENT 'Reference to the network partner (carrier, agent, or third-party logistics provider) for whom this EDI connection is established.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this EDI connection record.',
    `fallback_edi_connection_id` BIGINT COMMENT 'Self-referencing FK on edi_connection (fallback_edi_connection_id)',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_tier` (
    `partner_tier_id` BIGINT COMMENT 'Unique identifier for the partner tier classification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this tier classification definition for operational use.',
    `superseded_partner_tier_id` BIGINT COMMENT 'Self-referencing FK on partner_tier (superseded_partner_tier_id)',
    `api_integration_priority_flag` BOOLEAN COMMENT 'Indicates whether partners in this tier receive priority support for API integration projects and technical enablement.',
    `approval_date` DATE COMMENT 'Date when this tier classification definition was formally approved for use in partner management.',
    `auto_upgrade_eligible_flag` BOOLEAN COMMENT 'Indicates whether partners in this tier are automatically considered for upgrade to a higher tier when they meet the next tier criteria.',
    `carbon_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether partners must provide regular carbon emissions reporting (CO2e) for their operations to qualify for this tier.',
    `certification_requirements` STRING COMMENT 'Comma-separated list of required certifications partners must hold to qualify for this tier (e.g., ISO 9001, C-TPAT, AEO, IATA, dangerous goods certifications).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier classification record was first created in the system.',
    `customs_brokerage_capability_required_flag` BOOLEAN COMMENT 'Indicates whether partners must provide customs brokerage services to qualify for this tier.',
    `dangerous_goods_certification_required_flag` BOOLEAN COMMENT 'Indicates whether partners must hold dangerous goods handling certifications to qualify for this tier.',
    `dedicated_account_management_flag` BOOLEAN COMMENT 'Indicates whether partners in this tier receive dedicated account management support and a named account manager.',
    `downgrade_criteria` STRING COMMENT 'Detailed description of the conditions and performance failures that would trigger a partner downgrade from this tier to a lower tier.',
    `edi_integration_required_flag` BOOLEAN COMMENT 'Indicates whether partners must support EDI integration for automated data exchange to qualify for this tier.',
    `effective_date` DATE COMMENT 'Date when this tier classification definition became active and available for partner assignments.',
    `expiry_date` DATE COMMENT 'Date when this tier classification definition is scheduled to expire or be retired. Null indicates no planned expiration.',
    `extended_payment_terms_days` STRING COMMENT 'Number of additional payment term days extended to partners in this tier beyond standard payment terms.',
    `financial_stability_rating_minimum` STRING COMMENT 'Minimum acceptable financial stability or credit rating (e.g., A, B+, C) that partners must hold to qualify for this tier.. Valid values are `^[A-D][+-]?$`',
    `geographic_coverage_requirement` STRING COMMENT 'Minimum geographic service coverage scope required for partners to qualify for this tier (global, regional, national, or local).. Valid values are `global|regional|national|local`',
    `insurance_coverage_requirement_usd` DECIMAL(18,2) COMMENT 'Minimum insurance coverage amount in USD that partners must maintain to qualify for this tier.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier classification record was most recently updated or modified.',
    `marketing_co_branding_flag` BOOLEAN COMMENT 'Indicates whether partners in this tier are eligible for co-branded marketing initiatives and joint promotional activities.',
    `maximum_claims_ratio_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable claims ratio percentage (claims value divided by total shipment value) that partners in this tier may have before being downgraded.',
    `minimum_contract_term_months` STRING COMMENT 'Minimum contract duration in months required for partners to be assigned to this tier classification.',
    `minimum_otd_percentage` DECIMAL(18,2) COMMENT 'Minimum required on-time delivery performance percentage threshold that partners must maintain to qualify for or remain in this tier.',
    `minimum_revenue_threshold_usd` DECIMAL(18,2) COMMENT 'Minimum annual revenue commitment in USD that partners must generate to qualify for or maintain this tier classification.',
    `minimum_volume_threshold` DECIMAL(18,2) COMMENT 'Minimum shipment volume threshold required for partners to qualify for this tier, measured in the unit specified by volume_threshold_unit.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or contextual information about this tier classification that may be relevant for partner management teams.',
    `performance_review_frequency` STRING COMMENT 'Frequency at which partners assigned to this tier undergo formal performance evaluation and tier reassessment.. Valid values are `monthly|quarterly|semi_annually|annually`',
    `preferential_rates_flag` BOOLEAN COMMENT 'Indicates whether partners in this tier are eligible for preferential pricing rates and discounts on services.',
    `priority_capacity_access_flag` BOOLEAN COMMENT 'Indicates whether partners in this tier receive priority access to available capacity during peak periods or capacity constraints.',
    `probation_period_months` STRING COMMENT 'Number of months partners must remain in this tier before being eligible for upgrade or subject to downgrade review. Applicable primarily to probationary tiers.',
    `real_time_tracking_required_flag` BOOLEAN COMMENT 'Indicates whether partners must provide real-time shipment tracking capabilities to qualify for this tier.',
    `sustainability_certification_required_flag` BOOLEAN COMMENT 'Indicates whether partners must hold sustainability or environmental certifications (e.g., ISO 14001, carbon neutral certification) to qualify for this tier.',
    `temperature_controlled_capability_required_flag` BOOLEAN COMMENT 'Indicates whether partners must have temperature-controlled transport and storage capabilities to qualify for this tier.',
    `tier_benefits_summary` STRING COMMENT 'Comprehensive textual summary of all benefits, privileges, and advantages that partners receive when assigned to this tier.',
    `tier_category` STRING COMMENT 'High-level classification grouping of the tier indicating the nature of the partnership relationship.. Valid values are `strategic|operational|transactional|probationary|inactive`',
    `tier_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the tier classification (e.g., PREF, STRAT, APPR, PROB, SUSP).. Valid values are `^[A-Z0-9]{2,10}$`',
    `tier_description` STRING COMMENT 'Detailed business description of the tier classification, its purpose, and the characteristics of partners assigned to this tier.',
    `tier_level` STRING COMMENT 'Numeric ranking of the tier where lower numbers indicate higher strategic importance (e.g., 1=Strategic, 2=Preferred, 3=Approved).',
    `tier_name` STRING COMMENT 'Full descriptive name of the partner tier (e.g., Preferred, Strategic, Approved, Probationary, Suspended).',
    `tier_obligations_summary` STRING COMMENT 'Comprehensive textual summary of all obligations, commitments, and requirements that partners must fulfill to maintain this tier classification.',
    `tier_status` STRING COMMENT 'Current lifecycle status of the tier classification indicating whether it is actively used for partner assignments.. Valid values are `active|inactive|suspended|under_review|deprecated`',
    `transport_mode_requirements` STRING COMMENT 'Comma-separated list of transport modes partners must support to qualify for this tier (e.g., air, ocean, road, rail, multimodal).',
    `upgrade_criteria` STRING COMMENT 'Detailed description of the conditions and performance achievements that would qualify a partner for upgrade from this tier to a higher tier.',
    `volume_threshold_unit` STRING COMMENT 'Unit of measure for the minimum volume threshold (Twenty-foot Equivalent Unit, shipment count, kilograms, cubic meters, or pallets).. Valid values are `TEU|shipments|kg|cbm|pallets`',
    CONSTRAINT pk_partner_tier PRIMARY KEY(`partner_tier_id`)
) COMMENT 'Reference master defining the partner tiering classification framework used to categorize network partners by strategic importance, performance, and commercial relationship depth. Captures tier name (Preferred, Strategic, Approved, Probationary, Suspended), tier criteria (minimum performance thresholds, volume thresholds, certification requirements), benefits associated with each tier (priority capacity access, preferential rates, dedicated account management), review frequency, and tier status. Governs how partners are classified and managed across the network.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` (
    `gsa_agreement_id` BIGINT COMMENT 'Unique identifier for the GSA agreement record. Primary key.',
    `agent_id` BIGINT COMMENT 'Reference to the agent entity authorized under this GSA agreement to sell capacity on behalf of the principal.',
    `employee_id` BIGINT COMMENT 'Reference to the user or authority who approved the GSA agreement for execution.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or Transport Shipping entity whose capacity the GSA is authorized to sell.',
    `renewed_gsa_agreement_id` BIGINT COMMENT 'Self-referencing FK on gsa_agreement (renewed_gsa_agreement_id)',
    `agreement_reference_number` STRING COMMENT 'Externally-known unique reference number for the GSA agreement, used in contracts and communications.. Valid values are `^GSA-[A-Z0-9]{8,15}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the GSA agreement: draft (being prepared), pending_approval (awaiting authorization), active (in force), suspended (temporarily halted), terminated (ended early), or expired (reached end date).. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `agreement_type` STRING COMMENT 'Classification of the GSA agreement based on exclusivity terms: exclusive (sole agent in territory), non-exclusive (multiple agents allowed), or semi-exclusive (limited number of agents).. Valid values are `exclusive|non_exclusive|semi_exclusive`',
    `approval_date` DATE COMMENT 'Date when the GSA agreement was formally approved by the authorized signatory or governance body.',
    `authorized_products` STRING COMMENT 'Specific product codes or service offerings the GSA is permitted to market and sell under this agreement.',
    `authorized_service_lines` STRING COMMENT 'Comma-separated list of Transport Shipping service lines the GSA is authorized to sell (e.g., express parcel, air freight, ocean freight, contract logistics).',
    `authorized_transport_modes` STRING COMMENT 'Comma-separated list of transport modes the GSA may sell: air, ocean, road, rail, multimodal.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiry unless either party provides termination notice. True if auto-renewing, false otherwise.',
    `commission_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which commission payments are denominated.. Valid values are `^[A-Z]{3}$`',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Standard commission rate expressed as a percentage of revenue (e.g., 5.00 for 5%). Applicable when commission structure is percentage-based.',
    `commission_structure_type` STRING COMMENT 'Method by which the GSA earns commission: percentage of revenue (rate applied to sales value), flat fee per unit (fixed amount per shipment/TEU), tiered percentage (rate varies by volume), or hybrid (combination).. Valid values are `percentage_of_revenue|flat_fee_per_unit|tiered_percentage|hybrid`',
    `commitment_period_months` STRING COMMENT 'Duration in months over which the minimum sales target must be achieved (e.g., 12 for annual target).',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a confidentiality or non-disclosure clause binding the GSA. True if present, false otherwise.',
    `contract_document_reference` STRING COMMENT 'File path, document management system identifier, or URL pointing to the signed GSA agreement document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GSA agreement record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'Agreed method for resolving disputes arising from the agreement: arbitration, mediation, litigation, or negotiation.. Valid values are `arbitration|mediation|litigation|negotiation`',
    `effective_date` DATE COMMENT 'Date when the GSA agreement becomes binding and the agent is authorized to commence sales activities.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the GSA has exclusive rights to sell the principals capacity in the defined territory. True if exclusive, false otherwise.',
    `expiry_date` DATE COMMENT 'Date when the GSA agreement terminates. Nullable for open-ended agreements subject to notice termination.',
    `flat_fee_per_unit_amount` DECIMAL(18,2) COMMENT 'Fixed commission amount paid per unit (shipment, TEU, kilogram) when commission structure is flat-fee-based.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law under which the GSA agreement is interpreted and enforced (e.g., English Law, New York Law).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the GSA agreement record was last updated in the system.',
    `max_sub_agents_allowed` STRING COMMENT 'Maximum number of sub-agents the GSA may appoint, if sub-agent authorization is granted. Null if unlimited or not applicable.',
    `minimum_sales_target_amount` DECIMAL(18,2) COMMENT 'Minimum revenue or volume the GSA must achieve within the commitment period to maintain the agreement in good standing.',
    `minimum_sales_target_unit` STRING COMMENT 'Unit of measure for the minimum sales target: revenue (monetary value), shipments (count), TEU (container units), weight in kilograms, or volume in cubic meters.. Valid values are `revenue|shipments|teu|weight_kg|volume_cbm`',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or operational notes related to the GSA agreement.',
    `penalty_for_non_compliance` STRING COMMENT 'Description of financial or contractual penalties imposed if the GSA fails to meet minimum sales targets or other obligations.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the performance bond or guarantee the GSA must provide, if required.',
    `performance_bond_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the performance bond is denominated.. Valid values are `^[A-Z]{3}$`',
    `performance_bond_required_flag` BOOLEAN COMMENT 'Indicates whether the GSA must post a performance bond or financial guarantee to secure the agreement. True if required, false otherwise.',
    `performance_review_frequency` STRING COMMENT 'Frequency at which the principals performance review of the GSA is conducted: monthly, quarterly, semi-annual, or annual.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `renewal_notice_period_days` STRING COMMENT 'Number of days before expiry that either party must provide notice if they do not wish to renew the agreement.',
    `reporting_frequency` STRING COMMENT 'Frequency at which the GSA must submit sales and activity reports to the principal: daily, weekly, monthly, or quarterly.. Valid values are `daily|weekly|monthly|quarterly`',
    `reporting_obligations` STRING COMMENT 'Detailed description of the reports and data the GSA must provide to the principal (e.g., sales volume, customer lists, market intelligence).',
    `sub_agent_authorization_flag` BOOLEAN COMMENT 'Indicates whether the GSA is permitted to appoint sub-agents to sell on their behalf within the territory. True if authorized, false otherwise.',
    `termination_date` DATE COMMENT 'Actual date the agreement was terminated, if terminated before the scheduled expiry date. Null if agreement is active or expired naturally.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement before its natural expiry.',
    `termination_reason` STRING COMMENT 'Explanation for early termination of the agreement (e.g., performance failure, breach of contract, mutual consent, strategic change).',
    `territory_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code defining the geographic territory where the GSA is authorized to operate.. Valid values are `^[A-Z]{3}$`',
    `territory_region` STRING COMMENT 'Regional subdivision or multi-country zone within the territory (e.g., state, province, economic zone) where the GSA has sales authority.',
    `territory_scope` STRING COMMENT 'Granularity of the geographic territory: national (entire country), regional (sub-national area), city (specific urban area), or multi-country (cross-border zone).. Valid values are `national|regional|city|multi_country`',
    CONSTRAINT pk_gsa_agreement PRIMARY KEY(`gsa_agreement_id`)
) COMMENT 'Master record for General Sales Agent (GSA) agreements authorizing an agent to sell Transport Shipping or carrier capacity on a commission basis within a defined territory. Captures GSA reference, principal carrier or Transport Shipping entity, territory (country/region), authorized products and service lines, commission structure (percentage of revenue, flat fee per unit), minimum sales targets, exclusivity terms, sub-agent authorization rights, reporting obligations, effective and expiry dates, and agreement status. Distinct from agent_appointment (which covers operational authority) — GSA agreements are commercial sales mandates.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`partner_audit` (
    `partner_audit_id` BIGINT COMMENT 'Unique identifier for the partner audit record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_audit. Business justification: Partner audits conducted by safety teams should reference the formal safety audit record to avoid duplicate audit tracking, ensure consistent finding management, and enable consolidated safety reporti',
    `employee_id` BIGINT COMMENT 'Reference to the Transport Shipping user or manager who reviewed and approved the audit report and outcome.',
    `partner_id` BIGINT COMMENT 'Reference to the network partner being audited (carrier, agent, Third-Party Logistics (3PL) provider, or correspondent office).',
    `followup_partner_audit_id` BIGINT COMMENT 'Self-referencing FK on partner_audit (followup_partner_audit_id)',
    `approval_date` DATE COMMENT 'Date when the audit report and outcome were formally approved by Transport Shipping management.',
    `audit_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to conduct the audit, including auditor fees, travel expenses, and administrative costs.',
    `audit_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `audit_criteria` STRING COMMENT 'Standards, regulations, or contractual requirements against which the partner was audited (e.g., ISO 9001, Customs-Trade Partnership Against Terrorism (C-TPAT), Authorized Economic Operator (AEO), International Air Transport Association (IATA) standards, Transport Shipping service level agreements).',
    `audit_date` DATE COMMENT 'The principal date on which the audit was conducted or commenced. Represents the primary business event timestamp for this audit transaction.',
    `audit_end_date` DATE COMMENT 'Date when the audit fieldwork or on-site assessment was completed.',
    `audit_frequency_months` STRING COMMENT 'Required frequency of audits for this partner, expressed in months (e.g., 12 for annual audits, 24 for biennial audits).',
    `audit_methodology` STRING COMMENT 'Method used to conduct the audit: on-site (physical visit to partner facilities), remote (virtual audit via video conference and document review), hybrid (combination of on-site and remote), document review (desk audit of submitted documentation), or surveillance (ongoing monitoring audit).. Valid values are `on_site|remote|hybrid|document_review|surveillance`',
    `audit_outcome` STRING COMMENT 'Overall outcome of the audit: pass (partner meets all requirements), conditional pass (partner meets requirements subject to completion of minor corrective actions), fail (partner does not meet requirements and major corrective actions are required), or not applicable (audit was informational or advisory only).. Valid values are `pass|conditional_pass|fail|not_applicable`',
    `audit_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this audit for tracking and documentation purposes.',
    `audit_report_document_reference` STRING COMMENT 'Reference identifier or file path to the formal audit report document stored in the document management system.',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope, including specific processes, facilities, transport modes, trade lanes, or operational areas covered by the audit.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score or rating assigned to the partner based on audit performance, typically expressed as a percentage or on a defined scale.',
    `audit_start_date` DATE COMMENT 'Date when the audit fieldwork or on-site assessment began.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: scheduled (planned but not started), in progress (audit fieldwork underway), completed (audit finalized and report issued), cancelled (audit terminated before completion), or deferred (postponed to a later date).. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `audit_type` STRING COMMENT 'Category of audit conducted: operational (service delivery and performance), financial (billing and payment accuracy), compliance (regulatory adherence), security (Customs-Trade Partnership Against Terrorism (C-TPAT) or Authorized Economic Operator (AEO)), safety (International Maritime Organization (IMO) or International Air Transport Association (IATA) standards), quality (ISO 9001), or environmental (Greenhouse Gas (GHG) emissions and sustainability). [ENUM-REF-CANDIDATE: operational|financial|compliance|security|safety|quality|environmental — 7 candidates stripped; promote to reference product]',
    `auditor_certification` STRING COMMENT 'Professional certification or accreditation held by the auditor (e.g., Certified Internal Auditor (CIA), ISO 9001 Lead Auditor, Customs-Trade Partnership Against Terrorism (C-TPAT) Certified Auditor).',
    `auditor_name` STRING COMMENT 'Full name of the lead auditor or audit team leader responsible for conducting the audit.',
    `auditor_organization` STRING COMMENT 'Name of the organization or entity that conducted the audit (internal audit team, third-party certification body, or regulatory authority).',
    `certification_expiry_date` DATE COMMENT 'Date when the certification granted or renewed as a result of this audit will expire, requiring re-audit.',
    `certification_status` STRING COMMENT 'Certification status resulting from the audit: certified (partner meets certification requirements), provisional (temporary certification pending corrective actions), suspended (certification temporarily withdrawn), revoked (certification permanently withdrawn), or not certified (partner does not meet certification requirements).. Valid values are `certified|provisional|suspended|revoked|not_certified`',
    `contract_reference` STRING COMMENT 'Reference to the partner contract or agreement under which this audit was conducted and against which compliance was assessed.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the partner must complete all corrective actions to address audit findings.',
    `corrective_action_plan_agreed` BOOLEAN COMMENT 'Indicates whether a corrective action plan has been agreed upon with the partner to address identified non-conformances (True if agreed, False if not agreed or not applicable).',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan implementation: not required (no corrective actions needed), pending (plan agreed but not started), in progress (actions being implemented), completed (partner reports completion), overdue (past due date), or verified (Transport Shipping has verified completion).. Valid values are `not_required|pending|in_progress|completed|overdue|verified`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system.',
    `facilities_audited` STRING COMMENT 'List of partner facilities, warehouses, terminals, or offices included in the audit scope.',
    `findings_summary` STRING COMMENT 'High-level summary of the audit findings, including key observations, strengths identified, and areas of concern.',
    `follow_up_audit_date` DATE COMMENT 'Scheduled date for the follow-up audit to verify corrective action implementation and closure of non-conformances.',
    `follow_up_audit_required` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify implementation of corrective actions (True if required, False if not required).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last updated or modified in the system.',
    `major_non_conformances` STRING COMMENT 'Count of major non-conformances that represent significant deviations from requirements or pose serious risk to operations, compliance, or safety.',
    `minor_non_conformances` STRING COMMENT 'Count of minor non-conformances that represent less significant deviations or isolated incidents that do not pose immediate risk.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next regular audit of this partner, based on audit frequency requirements and the outcome of this audit.',
    `non_conformances_identified` STRING COMMENT 'Total count of non-conformances (deviations from standards or requirements) identified during the audit.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to the audit, including special circumstances, escalations, or follow-up actions.',
    `observations_count` STRING COMMENT 'Count of audit observations or opportunities for improvement that do not constitute non-conformances but warrant attention.',
    `partner_type` STRING COMMENT 'Classification of the partner being audited (carrier, agent, Third-Party Logistics (3PL) provider, Non-Vessel Operating Common Carrier (NVOCC), customs broker, or correspondent office).. Valid values are `carrier|agent|3pl_provider|correspondent|nvocc|customs_broker`',
    `regulatory_authority_name` STRING COMMENT 'Name of the regulatory authority or government agency that was notified of audit findings or that mandated the audit.',
    `regulatory_authority_notified` BOOLEAN COMMENT 'Indicates whether relevant regulatory authorities (e.g., customs, aviation, maritime) were notified of audit findings (True if notified, False if not notified).',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the partner based on audit findings: low (minimal risk), medium (moderate risk requiring monitoring), high (significant risk requiring corrective action), or critical (severe risk requiring immediate action or suspension).. Valid values are `low|medium|high|critical`',
    `transport_modes_audited` STRING COMMENT 'Comma-separated list of transport modes covered in the audit scope (air, ocean, road, rail, multimodal).',
    CONSTRAINT pk_partner_audit PRIMARY KEY(`partner_audit_id`)
) COMMENT 'Transactional record for formal audits conducted on network partners to verify compliance with Transport Shipping standards, regulatory requirements, and contractual obligations. Captures partner reference, audit type (operational, financial, compliance, security, safety), audit date, auditor name and organization, audit scope, findings summary, non-conformances identified, corrective action plan agreed, follow-up audit date, and audit outcome (pass, conditional pass, fail). Ensures ongoing partner compliance and supports regulatory due diligence.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`hub_gateway` (
    `hub_gateway_id` BIGINT COMMENT 'Unique identifier for the hub or gateway facility. Primary key for the hub_gateway product.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: When a hub/gateway is operated by a network partner (indicated by operator_type), this should be a formal FK relationship enabling partner-based hub management and performance tracking. Removes operat',
    `parent_hub_gateway_id` BIGINT COMMENT 'Self-referencing FK on hub_gateway (parent_hub_gateway_id)',
    `aeo_certified` BOOLEAN COMMENT 'Indicates whether the hub or gateway holds AEO certification for trusted trader status and expedited customs processing.',
    `api_integration_available` BOOLEAN COMMENT 'Indicates whether the hub or gateway provides API endpoints for real-time integration with external systems and partners.',
    `bonded_warehouse_available` BOOLEAN COMMENT 'Indicates whether the hub or gateway includes bonded warehouse facilities for duty-deferred storage of international cargo.',
    `carbon_neutral_certified` BOOLEAN COMMENT 'Indicates whether the hub or gateway has achieved carbon neutral certification through emissions reduction and offsetting programs.',
    `city` STRING COMMENT 'Name of the city where the hub or gateway facility is located.',
    `closure_date` DATE COMMENT 'Date when the hub or gateway ceased operations or was removed from the active network, if applicable.',
    `cold_chain_capable` BOOLEAN COMMENT 'Indicates whether the hub or gateway has temperature-controlled facilities for handling perishable and pharmaceutical shipments.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the hub or gateway is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hub or gateway record was first created in the system.',
    `ctpat_certified` BOOLEAN COMMENT 'Indicates whether the hub or gateway is C-TPAT certified for enhanced supply chain security to the United States.',
    `customs_clearance_capable` BOOLEAN COMMENT 'Indicates whether the hub or gateway has on-site customs clearance facilities and authorization for import/export processing.',
    `dangerous_goods_certified` BOOLEAN COMMENT 'Indicates whether the hub or gateway is certified and equipped to handle dangerous goods shipments per international regulations.',
    `dg_classes_handled` STRING COMMENT 'Comma-separated list of UN dangerous goods classes that the hub or gateway is authorized and equipped to handle.',
    `edi_capable` BOOLEAN COMMENT 'Indicates whether the hub or gateway supports EDI integration for automated data exchange with carriers and customers.',
    `effective_date` DATE COMMENT 'Date when the hub or gateway became operational and available for shipment processing in the Transport Shipping network.',
    `environmental_certification` STRING COMMENT 'Environmental certifications held by the hub or gateway, such as ISO 14001, LEED, or carbon neutral certification.',
    `ftz_status` BOOLEAN COMMENT 'Indicates whether the hub or gateway is located within or operates as a Free Trade Zone with special customs treatment.',
    `geographic_region` STRING COMMENT 'Macro-geographic region classification for network planning and regional performance analysis.. Valid values are `north_america|south_america|europe|middle_east|africa|asia_pacific`',
    `handling_capacity_teu` DECIMAL(18,2) COMMENT 'Maximum container handling capacity of the hub or gateway expressed in TEU per year for ocean and intermodal facilities.',
    `handling_capacity_tonnes` DECIMAL(18,2) COMMENT 'Maximum freight handling capacity of the hub or gateway expressed in metric tonnes per year for air and road facilities.',
    `hub_code` STRING COMMENT 'Unique business code assigned to the hub or gateway facility for operational reference and system integration.. Valid values are `^[A-Z0-9]{3,10}$`',
    `hub_name` STRING COMMENT 'Official name of the hub or gateway facility as recognized in operational and commercial documentation.',
    `hub_type` STRING COMMENT 'Classification of the hub or gateway by primary transport mode and facility function. ICD = Inland Container Depot, CFS = Container Freight Station.. Valid values are `air_hub|ocean_gateway|road_hub|rail_terminal|icd|cfs`',
    `iata_code` STRING COMMENT 'Three-letter IATA airport code for air hubs and gateways, used for air waybill routing and flight operations.. Valid values are `^[A-Z]{3}$`',
    `icao_code` STRING COMMENT 'Four-letter ICAO airport code for air hubs, used in flight planning and air traffic control communications.. Valid values are `^[A-Z]{4}$`',
    `iso_28000_certified` BOOLEAN COMMENT 'Indicates whether the hub or gateway holds ISO 28000 certification for supply chain security management.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the hub or gateway holds ISO 9001 certification for quality management systems.',
    `last_audit_date` DATE COMMENT 'Date of the most recent operational, security, or compliance audit conducted at the hub or gateway facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hub or gateway record was most recently updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the hub or gateway facility in decimal degrees for mapping and route optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the hub or gateway facility in decimal degrees for mapping and route optimization.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next operational, security, or compliance audit at the hub or gateway facility.',
    `operates_24_7` BOOLEAN COMMENT 'Indicates whether the hub or gateway operates continuously 24 hours per day, 7 days per week.',
    `operating_hours` STRING COMMENT 'Standard operating hours of the hub or gateway facility, including days of week and time ranges in local time.',
    `operational_status` STRING COMMENT 'Current operational state of the hub or gateway facility indicating availability for shipment processing and handling.. Valid values are `operational|suspended|closed|under_construction|planned|seasonal`',
    `operator_type` STRING COMMENT 'Classification of the operational ownership and control model for the hub or gateway facility.. Valid values are `owned|partner_operated|third_party|joint_venture|leased`',
    `real_time_tracking_available` BOOLEAN COMMENT 'Indicates whether the hub or gateway provides real-time shipment tracking and visibility capabilities through GPS, RFID, or IoT sensors.',
    `security_level` STRING COMMENT 'Security classification level of the hub or gateway facility based on certifications and security protocols implemented.. Valid values are `standard|enhanced|high_security|regulated_agent`',
    `state_province` STRING COMMENT 'State, province, or administrative region where the hub or gateway is located.',
    `storage_area_sqm` DECIMAL(18,2) COMMENT 'Total covered and open storage area available at the hub or gateway facility in square meters.',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature capability of cold chain facilities at the hub or gateway, expressed in degrees Celsius.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature capability of cold chain facilities at the hub or gateway, expressed in degrees Celsius.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the hub or gateway location, used for scheduling and cutoff time calculations.',
    `tms_platform` STRING COMMENT 'Name and version of the transportation management system used at the hub or gateway for shipment planning and execution.',
    `un_locode` STRING COMMENT 'Five-character UN location code identifying the hub or gateway for international trade and transport documentation.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}$`',
    `wms_platform` STRING COMMENT 'Name and version of the warehouse management system deployed at the hub or gateway for inventory and operations management.',
    CONSTRAINT pk_hub_gateway PRIMARY KEY(`hub_gateway_id`)
) COMMENT 'Master record for hub airports, gateway ports, and major transhipment nodes operated or utilized by Transport Shipping and its network partners. Captures hub/gateway name, location (city, country, IATA/UN LOCODE), hub type (air hub, ocean gateway, road hub, rail terminal, ICD, CFS), operator (Transport Shipping owned, partner operated, third-party), handling capacity, operating hours, customs clearance capability, dangerous goods handling capability, cold chain capability, and operational status. Distinct from route.network_node (which covers all network nodes) — this focuses on major hub and gateway facilities with their operational capabilities.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` (
    `carrier_service_agreement_id` BIGINT COMMENT 'Unique identifier for this carrier service agreement record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier partner providing transportation services',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Carrier service agreements define contractual terms for specific transport services. Linking to carrier_service identifies which specific service (route, mode, frequency) the agreement covers. The agr',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier (shipper) who is contracting carrier services',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this carrier service agreement (draft, active, suspended, expired, terminated).',
    `contract_reference_number` STRING COMMENT 'External reference number for the master contract or rate agreement document that governs this service agreement.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this carrier service agreement record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this carrier service agreement becomes active and rates/terms take effect.',
    `expiry_date` DATE COMMENT 'Date when this carrier service agreement expires and requires renewal or renegotiation. Null indicates evergreen agreement.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this carrier service agreement record was last modified.',
    `on_time_delivery_target_pct` DECIMAL(18,2) COMMENT 'Target on-time delivery percentage committed by carrier for this agreement (e.g., 95.00 for 95%). Part of the SLA.',
    `performance_tier` STRING COMMENT 'Service level or performance tier negotiated for this agreement (platinum, gold, silver, bronze, standard). Defines SLA commitments, priority handling, and escalation procedures.',
    `rate` DECIMAL(18,2) COMMENT 'Negotiated rate for this service type and trade lane. Unit depends on service type (per kg, per shipment, per container, per mile). Currency specified in rate_currency.',
    `rate_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the negotiated rate.',
    `rate_unit` STRING COMMENT 'Unit of measure for the rate (per kg, per shipment, per container, per mile, per pallet).',
    `service_type` STRING COMMENT 'Type of transportation service covered by this agreement (express, standard, economy, dedicated, LTL, FTL, air freight, ocean freight). Defines the service level commitment.',
    `trade_lane` STRING COMMENT 'Geographic trade lane or route covered by this agreement, typically expressed as origin-destination pair or region-to-region (e.g., US-EU, Asia-Pacific-North America, domestic-US-East).',
    `transit_time_commitment_days` BIGINT COMMENT 'Committed transit time in days for this service type and trade lane. Part of the SLA.',
    `volume_commitment` DECIMAL(18,2) COMMENT 'Minimum volume commitment from supplier to carrier under this agreement, expressed in volume_commitment_unit. Used for volume-based pricing tiers.',
    `volume_commitment_unit` STRING COMMENT 'Unit of measure for volume commitment (kg, shipments, containers, TEU).',
    CONSTRAINT pk_carrier_service_agreement PRIMARY KEY(`carrier_service_agreement_id`)
) COMMENT 'This association product represents the contractual service agreement between a supplier (shipper) and a carrier partner. It captures lane-specific rates, service commitments, volume agreements, and performance tiers that exist only in the context of this specific supplier-carrier relationship. Each record links one supplier to one carrier with commercial terms, service levels, and operational parameters negotiated for specific trade lanes or service types.. Existence Justification: In logistics operations, suppliers (shippers) contract with multiple carrier partners to cover different trade lanes, service types, and geographic regions, while carriers serve multiple supplier clients. Each supplier-carrier relationship is governed by specific service agreements that define lane-specific rates, service commitments, volume targets, and performance SLAs. This is the operational Carrier Service Agreement or Lane Rate Agreement business concept that procurement and network teams actively manage.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` (
    `carrier_offset_participation_id` BIGINT COMMENT 'Unique identifier for this carrier-program participation record. Primary key.',
    `carbon_offset_program_id` BIGINT COMMENT 'Foreign key linking to the carbon offset program that the carrier participates in',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier partner participating in the offset program',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the carriers total carbon offset requirement allocated to this specific program. Used for portfolio diversification and risk management across multiple offset sources.',
    `committed_volume_tco2e` DECIMAL(18,2) COMMENT 'The total quantity of carbon offset credits (in metric tonnes CO2e) that the carrier has committed to procure from this program under the participation agreement. This is the carrier-specific commitment, distinct from the programs total available credits.',
    `compliance_mandate` STRING COMMENT 'The regulatory or business mandate driving this carriers participation in this offset program. Examples: CORSIA (aviation), EU_ETS (European emissions trading), voluntary (corporate sustainability), state_mandate, customer_requirement.',
    `contract_end_date` DATE COMMENT 'The date when this carriers participation agreement for this specific carbon offset program expires or is scheduled for renewal. Null indicates an open-ended or evergreen participation.',
    `contract_start_date` DATE COMMENT 'The date when this carriers participation agreement for this specific carbon offset program became effective. Distinct from the programs overall contract dates, this represents the carrier-specific participation start.',
    `cost_center_code` STRING COMMENT 'The internal cost center or budget code to which this carriers offset program costs are allocated for financial reporting and cost allocation purposes.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this carrier-program participation record was created in the system.',
    `credits_allocated_tco2e` DECIMAL(18,2) COMMENT 'The quantity of carbon offset credits (in tonnes CO2e) from this program that have been allocated to this carriers account or inventory. Tracks the carriers share of program credits.',
    `credits_retired_by_carrier_tco2e` DECIMAL(18,2) COMMENT 'The quantity of carbon offset credits (in tonnes CO2e) from this program that this carrier has permanently retired for compliance or voluntary offsetting purposes.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this carrier-program participation record was last updated.',
    `participation_status` STRING COMMENT 'The current lifecycle status of this carriers participation in the carbon offset program. Values: active, suspended, completed, cancelled, pending_renewal.',
    `pricing_tier` STRING COMMENT 'The pricing tier or discount category applicable to this carriers participation in the program, reflecting volume commitments, contract timing, or negotiated terms. Examples: standard, volume_discount, early_bird, spot_market, negotiated.',
    CONSTRAINT pk_carrier_offset_participation PRIMARY KEY(`carrier_offset_participation_id`)
) COMMENT 'This association product represents the participation contract between a carrier and a carbon offset program. It captures the commercial and operational terms under which a specific carrier procures, allocates, and retires carbon offset credits from a specific program. Each record links one carrier to one carbon offset program with attributes that exist only in the context of this participation relationship, including committed volumes, allocation percentages, pricing tiers, and contract lifecycle dates.. Existence Justification: In the logistics industry, carbon offset program participation operates as a true many-to-many relationship. Multiple carriers participate in the same industry-wide or regional carbon offset programs (e.g., CORSIA-eligible programs for aviation carriers, shared renewable energy projects), and each carrier diversifies its offset portfolio across multiple programs to manage risk, cost, and compliance requirements across different project types, vintages, and geographies. The business actively manages these participation relationships with carrier-specific terms including committed volumes, allocation percentages, pricing tiers, and contract dates.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`contractor` (
    `contractor_id` BIGINT COMMENT 'Primary key for contractor',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: Contractor is an external organization that should be linked to the unified partner master. This eliminates the contractor silo and enables consistent partner management. No columns removed as contrac',
    `parent_contractor_id` BIGINT COMMENT 'Self-referencing FK on contractor (parent_contractor_id)',
    `contractor_address_line1` STRING COMMENT 'Primary address line for the contractors location.',
    `contractor_address_line2` STRING COMMENT 'Secondary address line for the contractors location.',
    `contractor_bank_account_number` STRING COMMENT 'Bank account number for payments to the contractor.',
    `contractor_bank_iban` STRING COMMENT 'IBAN of the contractors bank account.',
    `contractor_bank_name` STRING COMMENT 'Name of the bank holding the contractors account.',
    `contractor_bank_swift` STRING COMMENT 'SWIFT code of the contractors bank.',
    `contractor_capacity` DECIMAL(18,2) COMMENT 'Maximum capacity the contractor can handle (e.g., in TEU or tons).',
    `contractor_capacity_unit` STRING COMMENT 'Unit of measurement for the contractors capacity.',
    `contractor_certification_dates` DATE COMMENT 'Dates when the contractors certifications were issued or renewed.',
    `contractor_certifications` STRING COMMENT 'List of certifications held by the contractor (e.g., ISO 9001, ISO 14001).',
    `contractor_city` STRING COMMENT 'City of the contractors location.',
    `contractor_contact_email` STRING COMMENT 'Email address of the primary contact person.',
    `contractor_contact_name` STRING COMMENT 'Name of the primary contact person at the contractor.',
    `contractor_contact_phone` STRING COMMENT 'Phone number of the primary contact person.',
    `contractor_contract_end_date` DATE COMMENT 'Date when the contractors contract expires or was terminated.',
    `contractor_contract_number` STRING COMMENT 'Unique identifier for the contractors contract.',
    `contractor_contract_start_date` DATE COMMENT 'Date when the contractors contract became effective.',
    `contractor_contract_status` STRING COMMENT 'Current status of the contractors contract.',
    `contractor_contract_terms` STRING COMMENT 'Detailed terms and conditions of the contractors contract.',
    `contractor_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the contractors location.',
    `contractor_country_of_operation` STRING COMMENT 'Country where the contractor primarily operates.',
    `contractor_created_at` TIMESTAMP COMMENT 'Timestamp when the contractor record was first created.',
    `contractor_currency` STRING COMMENT 'ISO 4217 currency code used by the contractor for transactions.',
    `contractor_email` STRING COMMENT 'Primary contact email address for the contractor.',
    `contractor_geo_coverage` STRING COMMENT 'List of regions or countries the contractor serves.',
    `contractor_geo_coverage_type` STRING COMMENT 'Scope of the contractors geographic coverage.',
    `contractor_insurance_expiry_date` DATE COMMENT 'Expiration date of the contractors insurance policy.',
    `contractor_insurance_policy_number` STRING COMMENT 'Insurance policy number covering the contractors operations.',
    `contractor_name` STRING COMMENT 'Human-readable name of the contractor.',
    `contractor_operational_modes` STRING COMMENT 'Modes of transport the contractor operates (e.g., air, sea, road, rail).',
    `contractor_payment_currency` STRING COMMENT 'Currency used for payments to the contractor.',
    `contractor_payment_method` STRING COMMENT 'Preferred method of payment to the contractor.',
    `contractor_payment_terms` STRING COMMENT 'Payment terms agreed with the contractor (e.g., net30).',
    `contractor_phone` STRING COMMENT 'Primary contact phone number for the contractor.',
    `contractor_postal_code` STRING COMMENT 'Postal code of the contractors location.',
    `contractor_registration_number` STRING COMMENT 'Official registration number of the contractor.',
    `contractor_risk_rating` STRING COMMENT 'Internal risk rating assigned to the contractor (e.g., 1-5).',
    `contractor_service_level_agreement` STRING COMMENT 'Description of the service level agreement terms with the contractor.',
    `contractor_state` STRING COMMENT 'State or province of the contractors location.',
    `contractor_status` STRING COMMENT 'Current lifecycle status of the contractor.',
    `contractor_tax_number` STRING COMMENT 'Tax identification number assigned to the contractor.',
    `contractor_termination_date` TIMESTAMP COMMENT 'Timestamp when the contractor relationship was terminated, if applicable.',
    `contractor_type` STRING COMMENT 'Category of the contractor within the network.',
    `contractor_updated_at` TIMESTAMP COMMENT 'Timestamp when the contractor record was last updated.',
    CONSTRAINT pk_contractor PRIMARY KEY(`contractor_id`)
) COMMENT 'Master reference table for contractor. Referenced by contractor_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`network`.`training_provider` (
    `training_provider_id` BIGINT COMMENT 'Primary key for training_provider',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: Training provider is a thin reference table that is currently siloed. Linking to partner eliminates the silo and recognizes that training providers are external organizations in the network. No column',
    `parent_training_provider_id` BIGINT COMMENT 'Self-referencing FK on training_provider (parent_training_provider_id)',
    CONSTRAINT pk_training_provider PRIMARY KEY(`training_provider_id`)
) COMMENT 'Master reference table for training_provider. Referenced by training_provider_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ADD CONSTRAINT `fk_network_carrier_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ADD CONSTRAINT `fk_network_carrier_parent_carrier_id` FOREIGN KEY (`parent_carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ADD CONSTRAINT `fk_network_carrier_profile_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` ADD CONSTRAINT `fk_network_carrier_profile_superseded_carrier_profile_id` FOREIGN KEY (`superseded_carrier_profile_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_profile`(`carrier_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ADD CONSTRAINT `fk_network_agent_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ADD CONSTRAINT `fk_network_agent_parent_agent_id` FOREIGN KEY (`parent_agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ADD CONSTRAINT `fk_network_agent_appointment_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ADD CONSTRAINT `fk_network_agent_appointment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ADD CONSTRAINT `fk_network_agent_appointment_renewed_agent_appointment_id` FOREIGN KEY (`renewed_agent_appointment_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent_appointment`(`agent_appointment_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ADD CONSTRAINT `fk_network_correspondent_office_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ADD CONSTRAINT `fk_network_correspondent_office_parent_correspondent_office_id` FOREIGN KEY (`parent_correspondent_office_id`) REFERENCES `transport_shipping_ecm`.`network`.`correspondent_office`(`correspondent_office_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ADD CONSTRAINT `fk_network_interline_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ADD CONSTRAINT `fk_network_interline_agreement_renewed_interline_agreement_id` FOREIGN KEY (`renewed_interline_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ADD CONSTRAINT `fk_network_interline_prorate_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ADD CONSTRAINT `fk_network_interline_prorate_partner_settlement_id` FOREIGN KEY (`partner_settlement_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_settlement`(`partner_settlement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ADD CONSTRAINT `fk_network_interline_prorate_reversed_interline_prorate_id` FOREIGN KEY (`reversed_interline_prorate_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_prorate`(`interline_prorate_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ADD CONSTRAINT `fk_network_tpl_provider_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ADD CONSTRAINT `fk_network_tpl_provider_parent_tpl_provider_id` FOREIGN KEY (`parent_tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ADD CONSTRAINT `fk_network_tpl_capability_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ADD CONSTRAINT `fk_network_tpl_capability_parent_tpl_capability_id` FOREIGN KEY (`parent_tpl_capability_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_capability`(`tpl_capability_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ADD CONSTRAINT `fk_network_partner_partner_tier_id` FOREIGN KEY (`partner_tier_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_tier`(`partner_tier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ADD CONSTRAINT `fk_network_partner_parent_partner_id` FOREIGN KEY (`parent_partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ADD CONSTRAINT `fk_network_partner_certification_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` ADD CONSTRAINT `fk_network_partner_certification_renewed_partner_certification_id` FOREIGN KEY (`renewed_partner_certification_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_certification`(`partner_certification_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ADD CONSTRAINT `fk_network_partner_performance_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ADD CONSTRAINT `fk_network_partner_performance_partner_tier_id` FOREIGN KEY (`partner_tier_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_tier`(`partner_tier_id`);
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
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ADD CONSTRAINT `fk_network_network_event_hub_gateway_id` FOREIGN KEY (`hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ADD CONSTRAINT `fk_network_network_event_related_network_event_id` FOREIGN KEY (`related_network_event_id`) REFERENCES `transport_shipping_ecm`.`network`.`network_event`(`network_event_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ADD CONSTRAINT `fk_network_partner_onboarding_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ADD CONSTRAINT `fk_network_partner_onboarding_reactivation_partner_onboarding_id` FOREIGN KEY (`reactivation_partner_onboarding_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_onboarding`(`partner_onboarding_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ADD CONSTRAINT `fk_network_partner_tariff_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ADD CONSTRAINT `fk_network_partner_tariff_superseded_partner_tariff_id` FOREIGN KEY (`superseded_partner_tariff_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_tariff`(`partner_tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ADD CONSTRAINT `fk_network_partner_settlement_interline_agreement_id` FOREIGN KEY (`interline_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`interline_agreement`(`interline_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ADD CONSTRAINT `fk_network_partner_settlement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ADD CONSTRAINT `fk_network_partner_settlement_reversed_partner_settlement_id` FOREIGN KEY (`reversed_partner_settlement_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_settlement`(`partner_settlement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ADD CONSTRAINT `fk_network_coverage_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ADD CONSTRAINT `fk_network_coverage_coverage_backup_agent_id` FOREIGN KEY (`coverage_backup_agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ADD CONSTRAINT `fk_network_coverage_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ADD CONSTRAINT `fk_network_coverage_coverage_carrier_id` FOREIGN KEY (`coverage_carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ADD CONSTRAINT `fk_network_coverage_tpl_provider_id` FOREIGN KEY (`tpl_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`tpl_provider`(`tpl_provider_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ADD CONSTRAINT `fk_network_coverage_parent_coverage_id` FOREIGN KEY (`parent_coverage_id`) REFERENCES `transport_shipping_ecm`.`network`.`coverage`(`coverage_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ADD CONSTRAINT `fk_network_partner_sla_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ADD CONSTRAINT `fk_network_partner_sla_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ADD CONSTRAINT `fk_network_partner_sla_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ADD CONSTRAINT `fk_network_partner_sla_partner_tier_id` FOREIGN KEY (`partner_tier_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_tier`(`partner_tier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ADD CONSTRAINT `fk_network_partner_sla_superseded_partner_sla_id` FOREIGN KEY (`superseded_partner_sla_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_sla`(`partner_sla_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ADD CONSTRAINT `fk_network_partner_incident_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ADD CONSTRAINT `fk_network_partner_incident_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ADD CONSTRAINT `fk_network_partner_incident_partner_sla_id` FOREIGN KEY (`partner_sla_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_sla`(`partner_sla_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ADD CONSTRAINT `fk_network_partner_incident_related_partner_incident_id` FOREIGN KEY (`related_partner_incident_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_incident`(`partner_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ADD CONSTRAINT `fk_network_edi_connection_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ADD CONSTRAINT `fk_network_edi_connection_fallback_edi_connection_id` FOREIGN KEY (`fallback_edi_connection_id`) REFERENCES `transport_shipping_ecm`.`network`.`edi_connection`(`edi_connection_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ADD CONSTRAINT `fk_network_partner_tier_superseded_partner_tier_id` FOREIGN KEY (`superseded_partner_tier_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_tier`(`partner_tier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ADD CONSTRAINT `fk_network_gsa_agreement_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `transport_shipping_ecm`.`network`.`agent`(`agent_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ADD CONSTRAINT `fk_network_gsa_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ADD CONSTRAINT `fk_network_gsa_agreement_renewed_gsa_agreement_id` FOREIGN KEY (`renewed_gsa_agreement_id`) REFERENCES `transport_shipping_ecm`.`network`.`gsa_agreement`(`gsa_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ADD CONSTRAINT `fk_network_partner_audit_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ADD CONSTRAINT `fk_network_partner_audit_followup_partner_audit_id` FOREIGN KEY (`followup_partner_audit_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner_audit`(`partner_audit_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ADD CONSTRAINT `fk_network_hub_gateway_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ADD CONSTRAINT `fk_network_hub_gateway_parent_hub_gateway_id` FOREIGN KEY (`parent_hub_gateway_id`) REFERENCES `transport_shipping_ecm`.`network`.`hub_gateway`(`hub_gateway_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ADD CONSTRAINT `fk_network_carrier_service_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ADD CONSTRAINT `fk_network_carrier_service_agreement_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ADD CONSTRAINT `fk_network_carrier_offset_participation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `transport_shipping_ecm`.`network`.`carrier`(`carrier_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ADD CONSTRAINT `fk_network_contractor_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ADD CONSTRAINT `fk_network_contractor_parent_contractor_id` FOREIGN KEY (`parent_contractor_id`) REFERENCES `transport_shipping_ecm`.`network`.`contractor`(`contractor_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`training_provider` ADD CONSTRAINT `fk_network_training_provider_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `transport_shipping_ecm`.`network`.`partner`(`partner_id`);
ALTER TABLE `transport_shipping_ecm`.`network`.`training_provider` ADD CONSTRAINT `fk_network_training_provider_parent_training_provider_id` FOREIGN KEY (`parent_training_provider_id`) REFERENCES `transport_shipping_ecm`.`network`.`training_provider`(`training_provider_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`network` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `transport_shipping_ecm`.`network` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_operations');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier` ALTER COLUMN `parent_carrier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_profile` SET TAGS ('dbx_subdomain' = 'carrier_operations');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` SET TAGS ('dbx_subdomain' = 'agent_management');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent` ALTER COLUMN `parent_agent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` SET TAGS ('dbx_subdomain' = 'agent_management');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `agent_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Appointment Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Appointed Agent Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Appointing Party Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`agent_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` SET TAGS ('dbx_subdomain' = 'agent_management');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `correspondent_office_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Office ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `parent_correspondent_office_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `agreement_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Renewal Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `customs_clearance_capability` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Capability');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `iata_office_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Office Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `iata_office_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{7}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `language_support` SET TAGS ('dbx_business_glossary_term' = 'Language Support');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_email` SET TAGS ('dbx_business_glossary_term' = 'Office Email');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_fax` SET TAGS ('dbx_business_glossary_term' = 'Office Fax');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_fax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_name` SET TAGS ('dbx_business_glossary_term' = 'Office Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_phone` SET TAGS ('dbx_business_glossary_term' = 'Office Phone');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_type` SET TAGS ('dbx_business_glossary_term' = 'Office Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `office_type` SET TAGS ('dbx_value_regex' = 'correspondent|representative|branch|franchise|agent|affiliate');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_activation|terminated');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `representation_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `representation_agreement_type` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|limited_scope|full_service');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Sharing Model');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_value_regex' = 'commission|fixed_fee|profit_share|hybrid|cost_plus');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `services_offered` SET TAGS ('dbx_business_glossary_term' = 'Services Offered');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `transport_modes_supported` SET TAGS ('dbx_business_glossary_term' = 'Transport Modes Supported');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `warehouse_facility_available` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Facility Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`correspondent_office` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` SET TAGS ('dbx_subdomain' = 'capacity_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `interline_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` SET TAGS ('dbx_subdomain' = 'capacity_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `interline_prorate_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Prorate ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `interline_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `partner_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `reversed_interline_prorate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `billing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `billing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Commodity Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `destination_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `destination_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Segment Distance in Kilometers (KM)');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `origin_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `origin_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `origin_station_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `origin_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `prorate_amount` SET TAGS ('dbx_business_glossary_term' = 'Prorate Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `prorate_basis` SET TAGS ('dbx_business_glossary_term' = 'Prorate Basis Method');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `prorate_basis` SET TAGS ('dbx_value_regex' = 'weight|revenue|distance|flat_rate|negotiated|mileage');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `prorate_factor` SET TAGS ('dbx_business_glossary_term' = 'Prorate Factor');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `prorate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Prorate Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `receiving_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `receiving_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Prorate Remarks');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `segment_sequence` SET TAGS ('dbx_business_glossary_term' = 'Segment Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'express|standard|economy|charter|dedicated');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `settlement_period` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `settlement_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `total_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`network`.`interline_prorate` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Provider ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_provider` ALTER COLUMN `parent_tpl_provider_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `tpl_capability_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Capability ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Provider ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `parent_tpl_capability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `api_integration_available` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `bonded_warehouse_certified` SET TAGS ('dbx_business_glossary_term' = 'Bonded Warehouse Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `capability_code` SET TAGS ('dbx_business_glossary_term' = 'Capability Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `capability_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `capability_name` SET TAGS ('dbx_business_glossary_term' = 'Capability Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `capability_status` SET TAGS ('dbx_business_glossary_term' = 'Capability Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `capability_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|decommissioned|under_review');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `capability_type` SET TAGS ('dbx_business_glossary_term' = 'Capability Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `capability_type` SET TAGS ('dbx_value_regex' = 'warehousing|cold_storage|bonded_warehouse|cross_docking|kitting|returns_processing');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Capacity Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Capacity Pallet Positions');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `capacity_sqm` SET TAGS ('dbx_business_glossary_term' = 'Capacity Square Meters (SQM)');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `cost_per_pallet_per_month` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Pallet Per Month');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `cost_per_pallet_per_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `cost_per_unit_handled` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit Handled');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `cost_per_unit_handled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `edi_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `equipment_types` SET TAGS ('dbx_business_glossary_term' = 'Equipment Types Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `ftz_certified` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `iot_enabled` SET TAGS ('dbx_business_glossary_term' = 'Internet of Things (IoT) Enabled');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `iso_28000_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 28000 Supply Chain Security Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Management Certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Capability Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `rfid_enabled` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Service Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|premium|express|economy');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum Celsius');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum Celsius');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `throughput_units_per_day` SET TAGS ('dbx_business_glossary_term' = 'Throughput Units Per Day');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `tms_system_name` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `transport_modes_supported` SET TAGS ('dbx_business_glossary_term' = 'Transport Modes Supported');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `value_added_services` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Services');
ALTER TABLE `transport_shipping_ecm`.`network`.`tpl_capability` ALTER COLUMN `wms_system_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner` ALTER COLUMN `partner_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_certification` SET TAGS ('dbx_subdomain' = 'partner_governance');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `partner_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `partner_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` SET TAGS ('dbx_subdomain' = 'capacity_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `capacity_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Allocation Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `blocked_space_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Blocked Space Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`capacity_allocation` ALTER COLUMN `revised_capacity_allocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` SET TAGS ('dbx_subdomain' = 'capacity_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `blocked_space_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Blocked Space Agreement (BSA) ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`blocked_space_agreement` ALTER COLUMN `renewed_blocked_space_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service` SET TAGS ('dbx_subdomain' = 'carrier_operations');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` SET TAGS ('dbx_subdomain' = 'carrier_operations');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_business_glossary_term' = 'Secondary Email Address');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` SET TAGS ('dbx_subdomain' = 'coverage_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `network_event_id` SET TAGS ('dbx_business_glossary_term' = 'Network Event ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Causing Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Gateway Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By User ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `related_network_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`network_event` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Name');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `partner_onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Onboarding ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Manager ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `quaternary_partner_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `quaternary_partner_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `quaternary_partner_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `tertiary_partner_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `tertiary_partner_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_onboarding` ALTER COLUMN `tertiary_partner_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` SET TAGS ('dbx_subdomain' = 'capacity_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `partner_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Tariff ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `superseded_partner_tariff_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `customs_clearance_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Included Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `dangerous_goods_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `fuel_surcharge_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Included Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country|city_pair|port_pair|lane_specific');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `insurance_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Included Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `payment_term_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `security_surcharge_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Surcharge Included Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Tariff Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `tariff_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Tariff Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `tariff_status` SET TAGS ('dbx_business_glossary_term' = 'Tariff Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `tariff_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|pending_approval');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `tariff_type` SET TAGS ('dbx_business_glossary_term' = 'Tariff Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `tariff_type` SET TAGS ('dbx_value_regex' = 'buy_rate|spot_rate|contract_rate|volume_rate|seasonal_rate|promotional_rate');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `temperature_controlled_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `terminal_handling_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Terminal Handling Charge (THC) Included Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `trade_lane` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|courier');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `volume_commitment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tariff` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_value_regex' = 'kg|teu|cbm|shipments|pallets|containers');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` SET TAGS ('dbx_subdomain' = 'capacity_agreements');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `partner_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` SET TAGS ('dbx_subdomain' = 'coverage_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Network Coverage ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `coverage_backup_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Agent ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `coverage_carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `parent_coverage_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `city_name` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `cod_available` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `coverage_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `coverage_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|limited|suspended|inactive|planned');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `customs_clearance_available` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `cutoff_time_local` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Time Local');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `cutoff_time_local` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `dangerous_goods_accepted` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Accepted');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `dg_classes_accepted` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Classes Accepted');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `granularity` SET TAGS ('dbx_business_glossary_term' = 'Coverage Granularity');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `granularity` SET TAGS ('dbx_value_regex' = 'country|region|city|postal_zone|address');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `insurance_available` SET TAGS ('dbx_business_glossary_term' = 'Insurance Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `max_dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dimensions Centimeters (cm)');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `max_transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transit Time Hours');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `max_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `min_transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transit Time Hours');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'carrier|agent|3pl|nvocc|correspondent|interline');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|unrated');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `pod_electronic_available` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `postal_zone` SET TAGS ('dbx_business_glossary_term' = 'Postal Zone');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `primary_partner_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Partner Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `real_time_tracking_available` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Tracking Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `service_days` SET TAGS ('dbx_business_glossary_term' = 'Service Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `service_frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `service_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand|scheduled');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `service_scope` SET TAGS ('dbx_value_regex' = 'domestic|international|cross_border|regional');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'express|standard|economy|freight|last_mile|d2d');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `sla_otd_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On-Time Delivery (OTD) Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `standard_transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Standard Transit Time Hours');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `temperature_controlled_available` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Available');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`network`.`coverage` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `partner_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Service Level Agreement (SLA) ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_sla` ALTER COLUMN `partner_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `partner_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Incident Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `partner_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Sla Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `tertiary_partner_assigned_to_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `tertiary_partner_assigned_to_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `tertiary_partner_assigned_to_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `related_partner_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `affected_shipment_references` SET TAGS ('dbx_business_glossary_term' = 'Affected Shipment References');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `affected_trade_lanes` SET TAGS ('dbx_business_glossary_term' = 'Affected Trade Lanes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|tier_1|tier_2|executive');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `financial_impact_estimate_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `financial_impact_estimate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_value_regex' = '^INC-[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|partner_response_pending|corrective_action_pending|resolved|closed');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'service_failure|capacity_default|documentation_error|compliance_breach|safety_incident|quality_issue');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `partner_response` SET TAGS ('dbx_business_glossary_term' = 'Partner Response');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `partner_response_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Response Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `penalty_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Applied Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_incident` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` SET TAGS ('dbx_subdomain' = 'coverage_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `edi_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Connection ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`edi_connection` ALTER COLUMN `fallback_edi_connection_id` SET TAGS ('dbx_self_ref_fk' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `partner_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `superseded_partner_tier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `api_integration_priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Priority Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `auto_upgrade_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Upgrade Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `carbon_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Reporting Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `customs_brokerage_capability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Brokerage Capability Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `dangerous_goods_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Certification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `dedicated_account_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Account Management Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `downgrade_criteria` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Criteria');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `edi_integration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Integration Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `extended_payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Extended Payment Terms Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `financial_stability_rating_minimum` SET TAGS ('dbx_business_glossary_term' = 'Financial Stability Rating Minimum');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `financial_stability_rating_minimum` SET TAGS ('dbx_value_regex' = '^[A-D][+-]?$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `geographic_coverage_requirement` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Requirement');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `geographic_coverage_requirement` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `insurance_coverage_requirement_usd` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Requirement United States Dollars (USD)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `marketing_co_branding_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Co-Branding Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `maximum_claims_ratio_percentage` SET TAGS ('dbx_business_glossary_term' = 'Maximum Claims Ratio Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `minimum_contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Contract Term Months');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `minimum_otd_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum On-Time Delivery (OTD) Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `minimum_revenue_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Minimum Revenue Threshold United States Dollars (USD)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `minimum_volume_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Threshold');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `preferential_rates_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferential Rates Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `priority_capacity_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Capacity Access Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `probation_period_months` SET TAGS ('dbx_business_glossary_term' = 'Probation Period Months');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `real_time_tracking_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Tracking Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `sustainability_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `temperature_controlled_capability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Capability Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Tier Benefits Summary');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_category` SET TAGS ('dbx_business_glossary_term' = 'Tier Category');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_category` SET TAGS ('dbx_value_regex' = 'strategic|operational|transactional|probationary|inactive');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_description` SET TAGS ('dbx_business_glossary_term' = 'Tier Description');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_obligations_summary` SET TAGS ('dbx_business_glossary_term' = 'Tier Obligations Summary');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|deprecated');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `transport_mode_requirements` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode Requirements');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `upgrade_criteria` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Criteria');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `volume_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_tier` ALTER COLUMN `volume_threshold_unit` SET TAGS ('dbx_value_regex' = 'TEU|shipments|kg|cbm|pallets');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` SET TAGS ('dbx_subdomain' = 'agent_management');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `gsa_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'General Sales Agent (GSA) Agreement Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Appointed Agent Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Carrier Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `renewed_gsa_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `agreement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `agreement_reference_number` SET TAGS ('dbx_value_regex' = '^GSA-[A-Z0-9]{8,15}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|semi_exclusive');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `authorized_products` SET TAGS ('dbx_business_glossary_term' = 'Authorized Products');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `authorized_service_lines` SET TAGS ('dbx_business_glossary_term' = 'Authorized Service Lines');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `authorized_transport_modes` SET TAGS ('dbx_business_glossary_term' = 'Authorized Transport Modes');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `commission_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `commission_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `commission_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Structure Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `commission_structure_type` SET TAGS ('dbx_value_regex' = 'percentage_of_revenue|flat_fee_per_unit|tiered_percentage|hybrid');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `commitment_period_months` SET TAGS ('dbx_business_glossary_term' = 'Commitment Period Months');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|negotiation');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `flat_fee_per_unit_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Per Unit Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `max_sub_agents_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Sub-Agents Allowed');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `minimum_sales_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Sales Target Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `minimum_sales_target_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Sales Target Unit');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `minimum_sales_target_unit` SET TAGS ('dbx_value_regex' = 'revenue|shipments|teu|weight_kg|volume_cbm');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `performance_bond_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `performance_bond_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `performance_bond_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `reporting_obligations` SET TAGS ('dbx_business_glossary_term' = 'Reporting Obligations');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `sub_agent_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Sub-Agent Authorization Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `territory_country_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `territory_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `territory_region` SET TAGS ('dbx_business_glossary_term' = 'Territory Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`gsa_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_value_regex' = 'national|regional|city|multi_country');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `partner_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Audit Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `followup_partner_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_criteria` SET TAGS ('dbx_business_glossary_term' = 'Audit Criteria');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|document_review|surveillance');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document Reference');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `auditor_certification` SET TAGS ('dbx_business_glossary_term' = 'Auditor Certification');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|provisional|suspended|revoked|not_certified');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `corrective_action_plan_agreed` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Agreed Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overdue|verified');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `facilities_audited` SET TAGS ('dbx_business_glossary_term' = 'Facilities Audited');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `follow_up_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `follow_up_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `major_non_conformances` SET TAGS ('dbx_business_glossary_term' = 'Major Non-Conformances');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `minor_non_conformances` SET TAGS ('dbx_business_glossary_term' = 'Minor Non-Conformances');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `non_conformances_identified` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformances Identified');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `observations_count` SET TAGS ('dbx_business_glossary_term' = 'Observations Count');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'carrier|agent|3pl_provider|correspondent|nvocc|customs_broker');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `regulatory_authority_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notified Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`network`.`partner_audit` ALTER COLUMN `transport_modes_audited` SET TAGS ('dbx_business_glossary_term' = 'Transport Modes Audited');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` SET TAGS ('dbx_subdomain' = 'coverage_infrastructure');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Gateway Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `parent_hub_gateway_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `api_integration_available` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Availability Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `bonded_warehouse_available` SET TAGS ('dbx_business_glossary_term' = 'Bonded Warehouse Availability Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `carbon_neutral_certified` SET TAGS ('dbx_business_glossary_term' = 'Carbon Neutral Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `cold_chain_capable` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Capability Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `customs_clearance_capable` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Capability Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `dangerous_goods_certified` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `dg_classes_handled` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Classes Handled');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `edi_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capability Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `ftz_status` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Status Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|south_america|europe|middle_east|africa|asia_pacific');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `handling_capacity_teu` SET TAGS ('dbx_business_glossary_term' = 'Handling Capacity in Twenty-foot Equivalent Units (TEU)');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `handling_capacity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Handling Capacity in Metric Tonnes');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `hub_code` SET TAGS ('dbx_business_glossary_term' = 'Hub Gateway Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `hub_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `hub_name` SET TAGS ('dbx_business_glossary_term' = 'Hub Gateway Name');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `hub_type` SET TAGS ('dbx_business_glossary_term' = 'Hub Gateway Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `hub_type` SET TAGS ('dbx_value_regex' = 'air_hub|ocean_gateway|road_hub|rail_terminal|icd|cfs');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `icao_code` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `icao_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `iso_28000_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 28000 Supply Chain Security Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Management Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `operates_24_7` SET TAGS ('dbx_business_glossary_term' = 'Operates 24/7 Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|suspended|closed|under_construction|planned|seasonal');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `operator_type` SET TAGS ('dbx_business_glossary_term' = 'Operator Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `operator_type` SET TAGS ('dbx_value_regex' = 'owned|partner_operated|third_party|joint_venture|leased');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `real_time_tracking_available` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Tracking Availability Flag');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level Classification');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|high_security|regulated_agent');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `storage_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Storage Area in Square Meters');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Range in Celsius');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Range in Celsius');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `tms_platform` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Platform');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `un_locode` SET TAGS ('dbx_business_glossary_term' = 'United Nations Code for Trade and Transport Locations (UN LOCODE)');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `un_locode` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}$');
ALTER TABLE `transport_shipping_ecm`.`network`.`hub_gateway` ALTER COLUMN `wms_platform` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Platform');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` SET TAGS ('dbx_subdomain' = 'carrier_operations');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` SET TAGS ('dbx_association_edges' = 'procurement.supplier,network.carrier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `carrier_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Agreement - Carrier Id');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Agreement - Supplier Id');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `on_time_delivery_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `rate` SET TAGS ('dbx_business_glossary_term' = 'Rate');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `trade_lane` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `transit_time_commitment_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Commitment Days');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_service_agreement` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` SET TAGS ('dbx_subdomain' = 'carrier_operations');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` SET TAGS ('dbx_association_edges' = 'sustainability.carbon_offset_program,network.carrier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `carrier_offset_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Offset Participation Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Offset Participation - Carbon Offset Program Id');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Offset Participation - Carrier Id');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `committed_volume_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume in Tonnes CO2e');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `compliance_mandate` SET TAGS ('dbx_business_glossary_term' = 'Compliance Mandate');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Contract End Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Contract Start Date');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `credits_allocated_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Credits Allocated to Carrier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `credits_retired_by_carrier_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Credits Retired by Carrier');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `transport_shipping_ecm`.`network`.`carrier_offset_participation` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `parent_contractor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`contractor` ALTER COLUMN `contractor_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`network`.`training_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`network`.`training_provider` SET TAGS ('dbx_subdomain' = 'partner_governance');
ALTER TABLE `transport_shipping_ecm`.`network`.`training_provider` ALTER COLUMN `training_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Identifier');
ALTER TABLE `transport_shipping_ecm`.`network`.`training_provider` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`network`.`training_provider` ALTER COLUMN `parent_training_provider_id` SET TAGS ('dbx_self_ref_fk' = 'true');
