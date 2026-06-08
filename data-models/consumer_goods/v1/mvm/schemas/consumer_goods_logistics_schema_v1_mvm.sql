-- Schema for Domain: logistics | Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`logistics` COMMENT 'Owns transportation management, freight optimization, and delivery execution across inbound and outbound networks. Manages carrier contracts, shipment planning, route optimization, freight audit, track-and-trace, 3PL coordination, proof of delivery, cold-chain compliance, and transportation cost tracking. Distinct from distribution (warehouse-focused) — logistics covers inter-facility and last-mile movement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Unique surrogate identifier for the transportation carrier record in the Consumer Goods logistics master data. Primary key for all carrier-related references across shipments, freight orders, contracts, and invoices.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Carrier compliance management requires linking carriers to their primary operating jurisdiction for regulatory authority validation (FMCSA, DOT, EU transport regulations). Consumer Goods logistics tea',
    `supplier_id` BIGINT COMMENT 'Reference to the corresponding vendor/supplier master record in the ERP system (SAP S/4HANA or Oracle Cloud ERP) for this carrier. Links the carrier master to the procurement and accounts payable vendor record for freight invoice processing and payment.',
    `api_tracking_capable` BOOLEAN COMMENT 'Indicates whether the carrier provides a real-time shipment tracking API for track-and-trace integration. Enables automated shipment status updates in the TMS without manual EDI 214 processing. Used in carrier technology capability assessment.',
    `carrier_status` STRING COMMENT 'Current lifecycle status of the carrier in the Consumer Goods approved carrier program. Active carriers are eligible for shipment tendering. Suspended carriers are temporarily blocked pending compliance review. Blacklisted carriers are permanently disqualified. Drives carrier selection eligibility in TMS routing.. Valid values are `active|inactive|suspended|pending_approval|blacklisted`',
    `carrier_type` STRING COMMENT 'Primary transportation mode classification of the carrier. Drives rate card selection, shipment planning rules, and EDI transaction sets. TL (Truckload), LTL (Less-Than-Truckload), parcel, rail, ocean, air, intermodal, and courier are the standard classifications in consumer goods logistics. [ENUM-REF-CANDIDATE: truckload|less_than_truckload|parcel|rail|ocean|air|intermodal|courier — promote to reference product]',
    `cold_chain_capable` BOOLEAN COMMENT 'Indicates whether the carrier has certified temperature-controlled transportation capability (refrigerated or frozen) for cold-chain compliant shipments of health, hygiene, and personal care products requiring temperature management. Critical for product safety and regulatory compliance.',
    `contract_end_date` DATE COMMENT 'Expiry date of the current master transportation services agreement. Triggers contract renewal workflows and rate renegotiation processes. Shipment tendering to the carrier may be restricted after this date if no renewal is in place.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current master transportation services agreement between Consumer Goods and the carrier. Defines the period during which contracted rates and service commitments are valid.',
    `country_of_registration` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the carrier is legally registered and incorporated. Used for cross-border compliance checks, customs documentation, and carrier eligibility for specific trade lanes.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier master record was first created in the Consumer Goods logistics data platform. Provides audit trail for record provenance and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which freight rates and invoices are denominated for this carrier. Used in multi-currency freight cost management, FX conversion, and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `dot_number` STRING COMMENT 'Unique identifier assigned by the U.S. Federal Motor Carrier Safety Administration (FMCSA) to commercial motor carriers operating in interstate commerce. Required for regulatory compliance verification and safety rating lookup. Mandatory for US-based trucking carriers.. Valid values are `^[0-9]{1,8}$`',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet Data Universal Numbering System (DUNS) number uniquely identifying the carriers business entity globally. Used for supplier risk assessment, credit verification, and EDI trading partner identification.. Valid values are `^[0-9]{9}$`',
    `edi_capable` BOOLEAN COMMENT 'Indicates whether the carrier supports Electronic Data Interchange (EDI) for automated exchange of shipment tenders (204), load tenders (990), shipment status (214), and freight invoices (210). EDI-capable carriers are preferred for high-volume automated tendering in the TMS.',
    `edi_code` STRING COMMENT 'Carriers EDI interchange identifier used in the ISA segment of X12 EDI transactions. Combined with the EDI qualifier, this uniquely identifies the carrier as an EDI trading partner. Required for automated tender and status message routing.',
    `edi_qualifier` STRING COMMENT 'Two-digit qualifier code identifying the type of EDI sender/receiver identifier used in ISA segment of X12 EDI transactions (e.g., 02 = DUNS, 08 = UCC/EAN, ZZ = Mutually Defined). Required for EDI trading partner setup and message routing.. Valid values are `^[0-9]{2}$`',
    `fmcsa_rating_date` DATE COMMENT 'Date on which the current FMCSA safety rating was issued or last updated. Used to assess rating currency and trigger re-evaluation workflows when ratings are older than the compliance review threshold.',
    `fmcsa_safety_rating` STRING COMMENT 'Official safety fitness rating assigned by the FMCSA to motor carriers based on compliance reviews and safety audits. Satisfactory rating is required for carrier approval in Consumer Goods carrier program. Conditional or Unsatisfactory ratings trigger carrier review or suspension. Mandatory compliance field for US trucking carriers.. Valid values are `satisfactory|conditional|unsatisfactory|not_rated`',
    `geographic_coverage` STRING COMMENT 'Description of the carriers operational geographic coverage scope, including regions, countries, or trade lanes served. Used in TMS routing logic to filter eligible carriers by origin-destination pair. Examples: Continental US, US-Canada cross-border, Trans-Pacific, EU domestic.',
    `hazmat_cert_expiry_date` DATE COMMENT 'Expiry date of the carriers hazardous materials transportation certification. Triggers compliance alerts and blocks HAZMAT shipment tendering to the carrier if certification has lapsed.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the carrier holds valid certification to transport hazardous materials (HAZMAT) as defined by DOT 49 CFR. Required for shipments of aerosols, flammable products, and chemical-based consumer goods. Validated against DOT HAZMAT registration database.',
    `headquarters_address` STRING COMMENT 'Full street address of the carriers principal place of business or corporate headquarters. Used for legal correspondence, contract execution, and regulatory filings. Includes street, city, state/province, postal code, and country.',
    `iata_code` STRING COMMENT '2-3 character alphanumeric code assigned by IATA to identify air freight carriers. Used for air waybill generation, air freight booking, and international air cargo tracking. Applicable only to air freight carriers.. Valid values are `^[A-Z0-9]{2,3}$`',
    `insurance_cargo_amount` DECIMAL(18,2) COMMENT 'Maximum coverage amount (in USD) of the carriers cargo insurance policy covering loss or damage to goods in transit. Consumer Goods mandates minimum cargo insurance thresholds based on shipment value profiles. Critical for high-value CPG product shipments.',
    `insurance_certificate_number` STRING COMMENT 'Reference number of the carriers current certificate of insurance (COI) on file with Consumer Goods. Used for insurance verification, claims processing, and audit trail of carrier compliance documentation.',
    `insurance_expiry_date` DATE COMMENT 'Date on which the carriers insurance certificate expires. Triggers automated renewal reminder workflows and carrier status suspension if insurance lapses. Critical compliance field for carrier program management.',
    `insurance_liability_amount` DECIMAL(18,2) COMMENT 'Maximum coverage amount (in USD) of the carriers general liability insurance policy. Consumer Goods requires minimum liability coverage thresholds as a condition of carrier approval. Validated during carrier onboarding and annual renewal.',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent compliance review conducted for this carrier, covering safety ratings, insurance certificates, HAZMAT certifications, and contractual obligations. Used to schedule periodic re-evaluations and flag overdue reviews.',
    `legal_name` STRING COMMENT 'Full legal registered business name of the transportation carrier as filed with regulatory authorities (FMCSA, state business registry). Used in contracts, freight invoices, and regulatory filings. Must match the name on the carriers operating authority.',
    `max_payload_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity in kilograms that the carriers standard equipment can transport per shipment. Used in load planning, shipment consolidation, and carrier eligibility checks to prevent overweight violations.',
    `mc_number` STRING COMMENT 'Operating authority number issued by the FMCSA to for-hire motor carriers transporting regulated commodities in interstate commerce. Distinct from DOT number — MC number grants operating authority while DOT number is for safety registration. Used in carrier compliance validation.. Valid values are `^MC-[0-9]{1,7}$`',
    `onboarding_date` DATE COMMENT 'Date on which the carrier was formally approved and onboarded into Consumer Goods carrier program, completing all compliance checks, insurance verification, and EDI/API setup. Marks the start of the carriers operational eligibility.',
    `payment_terms` STRING COMMENT 'Contractual payment terms agreed with the carrier for freight invoice settlement. Drives accounts payable scheduling and cash flow planning. Standard terms in consumer goods logistics range from Net 15 to Net 60 days.. Valid values are `net_15|net_30|net_45|net_60|immediate`',
    `preferred_carrier` BOOLEAN COMMENT 'Indicates whether the carrier has been designated as a preferred carrier in Consumer Goods carrier program, typically based on negotiated rates, service performance, and strategic partnership status. Preferred carriers receive priority in TMS automated tendering sequences.',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary carrier contact for operational communications, tender notifications, and account management. Used in EDI onboarding and carrier portal access provisioning.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the carrier organization responsible for account management, contract negotiations, and escalation handling. Used in carrier relationship management and communication workflows.',
    `primary_contact_phone` STRING COMMENT 'Primary business telephone number for the carrier contact, used for operational coordination, shipment tracking inquiries, and exception management. Formatted per E.164 international standard.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `scac_code` STRING COMMENT 'Unique 2-4 character alpha code assigned by the National Motor Freight Traffic Association (NMFTA) to identify transportation carriers in North America. Used in EDI transactions (204, 214, 990) and freight billing. Mandatory for motor carriers operating in the US.. Valid values are `^[A-Z]{2,4}$`',
    `service_area_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing the countries in which the carrier provides transportation services. Used for international shipment routing, customs compliance validation, and carrier eligibility filtering in cross-border logistics.',
    `service_mode` STRING COMMENT 'Service level classification offered by the carrier indicating transit speed and handling commitment. Drives SLA assignment, freight cost tier selection, and shipment routing logic in the TMS. Used in OTIF (On Time In Full) performance measurement.. Valid values are `standard|expedited|overnight|same_day|deferred|white_glove`',
    `tax_number` STRING COMMENT 'Federal tax identification number (EIN/TIN) or VAT registration number of the carrier, used for tax compliance, 1099 reporting, and cross-border customs documentation. Required for freight invoice processing and IRS reporting.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature (in degrees Celsius) that the carriers cold-chain equipment can maintain during transit. Combined with the minimum temperature range, defines the carriers certified temperature corridor for cold-chain shipments.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature (in degrees Celsius) that the carriers cold-chain equipment can maintain during transit. Used to validate carrier eligibility for temperature-sensitive product shipments and cold-chain compliance verification.',
    `tracking_url_template` STRING COMMENT 'URL template for the carriers web-based shipment tracking portal, with a placeholder (e.g., {tracking_number}) for dynamic substitution. Used to generate direct tracking links in shipment notifications, customer portals, and internal TMS dashboards.',
    `trade_name` STRING COMMENT 'Doing-business-as (DBA) or trade name used by the carrier in commercial operations, which may differ from the legal registered name. Used in operational communications, carrier portals, and reporting where the trade name is more recognizable.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record for all transportation carriers (trucking, rail, ocean, air, parcel) contracted by Consumer Goods. Captures carrier identity, SCAC/IATA codes, carrier type, service modes, geographic coverage, insurance certificates, safety ratings (FMCSA/DOT), EDI capability flags, and contractual status. SSOT for carrier identity referenced by shipments, freight orders, contracts, and invoices across inbound and outbound networks.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` (
    `carrier_contract_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the carrier contract record in the logistics data platform. Primary key for the carrier_contract entity.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (transportation service provider) party who is the counterparty to this freight contract. Links to the carrier master record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Carrier contracts are legally owned by a specific company code entity in multi-national consumer goods companies. This determines the contracting legal entity for tax, intercompany freight billing, an',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Cross-border carrier contracts are governed by jurisdiction-specific transport regulations (liability limits, customs compliance, OTIF penalty enforceability). Legal and regulatory teams must validate',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: In consumer goods, premium or specialized brands (e.g., cold-chain skincare, infant nutrition) negotiate dedicated brand-specific carrier contracts with distinct SLAs, temperature requirements, and li',
    `accessorial_schedule_code` STRING COMMENT 'Reference code identifying the accessorial charge schedule applicable to this contract. Accessorial charges include liftgate, residential delivery, inside delivery, detention, layover, hazmat handling, and temperature-controlled surcharges. Links to the accessorial rate table for freight audit and cost estimation.',
    `approval_date` DATE COMMENT 'Date on which the carrier contract was formally approved by the authorized approver. Used in contract governance, SOX audit trails, and procurement compliance reporting.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the authorized approver who signed off on this carrier contract. Required for SOX financial controls compliance and procurement governance. Supports audit trail for contract authorization.',
    `auto_renewal` BOOLEAN COMMENT 'Indicates whether this carrier contract automatically renews at expiry unless terminated with advance notice. When true, the renewal_notice_days field defines the required notice period. Supports contract lifecycle management and procurement planning.',
    `base_rate` DECIMAL(18,2) COMMENT 'The primary negotiated freight rate under this contract before surcharges and accessorial charges are applied. The unit of measure for this rate is defined by the rate_type field (e.g., per mile, per CWT, per pallet, flat). Used as the foundation for freight cost estimation and freight audit rate lookup.',
    `billing_frequency` STRING COMMENT 'Frequency at which the carrier submits freight invoices under this contract. Per-shipment billing generates an invoice for each delivery; weekly/bi-weekly/monthly billing consolidates charges into periodic invoices. Impacts freight audit workflow and accounts payable processing.. Valid values are `per_shipment|weekly|bi_weekly|monthly`',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this contract covers temperature-controlled (cold chain) shipments requiring refrigerated or frozen transport. When true, cold chain compliance monitoring, temperature logging, and FEFO inventory management protocols apply. Relevant for health, hygiene, and perishable consumer goods.',
    `contract_number` STRING COMMENT 'Externally-known, human-readable contract reference number assigned by the procurement or logistics team. Used in EDI communications, freight audit, and carrier correspondence. Aligns with SAP S/4HANA MM contract document number.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the carrier contract. Draft indicates contract is being authored; pending_approval is awaiting sign-off; active means the contract is in force; suspended means temporarily halted; expired means the term has lapsed; terminated means the contract was ended before expiry.. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `contract_type` STRING COMMENT 'Classification of the freight contract by commercial arrangement type. Spot contracts cover single-shipment rates; committed contracts lock volume at negotiated rates; preferred carrier agreements define priority tender; dedicated contracts reserve capacity; intermodal covers multi-mode arrangements; 3PL master covers third-party logistics umbrella agreements.. Valid values are `spot|committed|preferred|dedicated|intermodal|3pl_master`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier contract record was first created in the logistics data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trail, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all rates, charges, and financial commitments under this contract are denominated (e.g., USD, EUR, GBP). Required for multi-currency freight cost management and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the destination country covered by this contract. Used for cross-border freight classification, customs compliance, and international rate applicability.. Valid values are `^[A-Z]{3}$`',
    `destination_region` STRING COMMENT 'Geographic destination zone or region covered by this contract for lane-level rate applicability. May represent a state, ZIP zone, city cluster, or carrier-defined zone code. Used in freight cost estimation and tender evaluation.',
    `detention_free_time_hours` STRING COMMENT 'Number of hours the carriers equipment (trailer/container) may remain at a Consumer Goods facility for loading or unloading without incurring detention charges. Exceeding this threshold triggers accessorial detention fees per the contract rate schedule.',
    `edi_capable` BOOLEAN COMMENT 'Indicates whether the carrier supports EDI (Electronic Data Interchange) for automated tender, shipment status, and invoice exchange under this contract. EDI-capable carriers enable automated load tendering (EDI 204), shipment status updates (EDI 214), and freight invoice processing (EDI 210).',
    `effective_date` DATE COMMENT 'The date on which the carrier contract becomes legally binding and rates become applicable for freight tendering and cost estimation. Aligns with SAP S/4HANA MM contract validity start date.',
    `expiry_date` DATE COMMENT 'The date on which the carrier contract ceases to be valid and rates are no longer applicable. Nullable for evergreen contracts with no fixed end date. Aligns with SAP S/4HANA MM contract validity end date.',
    `fuel_surcharge_basis` STRING COMMENT 'Defines how the fuel surcharge is calculated and applied: as a percentage of the base freight rate, a flat amount per mile, a flat amount per shipment, or dynamically linked to the DOE diesel fuel price index. Determines the fuel surcharge computation method in freight audit.. Valid values are `percentage_of_base|flat_per_mile|flat_per_shipment|doe_index_linked`',
    `fuel_surcharge_rate` DECIMAL(18,2) COMMENT 'Contracted fuel surcharge rate expressed as a percentage of the base rate or as a fixed amount per unit, applied on top of the base freight rate to account for fuel cost variability. Linked to a fuel index table or DOE diesel price index. Critical for freight cost estimation and audit.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the carrier is certified and authorized under this contract to transport hazardous materials (hazmat) including flammable, corrosive, or toxic consumer goods ingredients. When true, DOT/IATA hazmat compliance documentation is required.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum cargo insurance coverage amount provided by the carrier under this contract, expressed in the contract currency. Defines the financial liability limit for cargo loss or damage claims. Used in risk management and claims processing.',
    `liability_limit_per_kg` DECIMAL(18,2) COMMENT 'Contractual carrier liability limit per kilogram of cargo for loss or damage claims, expressed in the contract currency. Used in freight claims management to calculate maximum recoverable amounts for damaged or lost shipments.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum shipment weight in kilograms at which this contract rate applies. Defines the upper bound of the weight break tier. Null indicates no upper limit (applies to all weights above the minimum). Used in freight cost estimation and audit.',
    `min_weight_kg` DECIMAL(18,2) COMMENT 'Minimum shipment weight in kilograms at which this contract rate applies. Defines the lower bound of the weight break tier for rate applicability. Used in freight cost estimation and audit to validate correct rate application.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the origin country covered by this contract. Used for cross-border freight classification, customs compliance, and international rate applicability.. Valid values are `^[A-Z]{3}$`',
    `origin_region` STRING COMMENT 'Geographic origin zone or region covered by this contract for lane-level rate applicability. May represent a state, ZIP zone, city cluster, or carrier-defined zone code. Used in freight cost estimation and tender evaluation.',
    `otif_penalty_rate` DECIMAL(18,2) COMMENT 'Contractual penalty rate applied to the carrier for OTIF (On Time In Full) failures, expressed as a percentage of the invoice value or a fixed amount per incident. OTIF is a key KPI in consumer goods supply chain performance management. Supports carrier performance management and deduction processing.',
    `otif_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum OTIF performance percentage the carrier must achieve to avoid penalty charges under this contract. Expressed as a percentage (e.g., 98.5 means 98.5% OTIF compliance required). Below this threshold, the otif_penalty_rate is triggered.',
    `payment_terms` STRING COMMENT 'Contractual payment terms defining when freight invoices must be settled after receipt. Net_30 means payment due within 30 days of invoice date. 2/10 Net 30 means a 2% discount if paid within 10 days. Drives accounts payable scheduling and freight audit payment processing.. Valid values are `net_15|net_30|net_45|net_60|immediate|2_10_net_30`',
    `pickup_lead_time_hours` STRING COMMENT 'Contracted lead time in hours from tender acceptance to carrier pickup at the origin facility. Used in shipment planning, load scheduling, and Blue Yonder WMS labor planning for dock door assignment.',
    `rate_type` STRING COMMENT 'Defines the unit basis on which the base_rate is charged. Per-mile rates apply to distance-based pricing; per-CWT (hundredweight) applies to weight-based LTL pricing; per-pallet applies to unit-load pricing; flat rate is a fixed charge per shipment regardless of weight or distance; per-kg and per-lb are weight-based variants used in air and parcel freight. [ENUM-REF-CANDIDATE: per_mile|per_cwt|per_pallet|per_shipment|flat|per_kg|per_lb — 7 candidates stripped; promote to reference product]',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days advance notice required to terminate or renegotiate this contract before auto-renewal. Applicable only when auto_renewal is true. Used in contract lifecycle management to trigger procurement review workflows.',
    `service_level` STRING COMMENT 'Contracted service level defining the speed and handling tier for shipments under this agreement. Drives SLA commitments, OTIF measurement thresholds, and rate applicability. Examples: standard ground, expedited, overnight, two-day, deferred, white-glove.. Valid values are `standard|expedited|overnight|two_day|deferred|white_glove`',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in degrees Celsius that must be maintained throughout transit for cold chain shipments under this contract. Applicable only when cold_chain_required is true. Exceedance triggers non-conformance reporting and potential product rejection.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in degrees Celsius that must be maintained throughout transit for cold chain shipments under this contract. Applicable only when cold_chain_required is true. Used for cold chain compliance monitoring and carrier performance audits.',
    `track_trace_method` STRING COMMENT 'Method by which shipment tracking and status updates are provided by the carrier under this contract. EDI 214 is the standard electronic shipment status transaction; API enables real-time integration; portal requires manual check-in; email is manual notification. Drives track-and-trace capability in logistics operations.. Valid values are `edi_214|api|portal|email|none`',
    `transit_time_days` STRING COMMENT 'Contracted standard transit time in calendar days from pickup to delivery for shipments under this contract and lane. Used as the SLA baseline for OTIF measurement, delivery promise, and ATP/CTP calculations in demand planning.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation covered by this contract. TL (Truckload), LTL (Less-than-Truckload), intermodal, rail, ocean freight, air freight, parcel/small package, or drayage (port/terminal moves). Drives rate table applicability and freight audit logic. [ENUM-REF-CANDIDATE: truckload|ltl|intermodal|rail|ocean|air|parcel|drayage — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier contract record was most recently modified in the logistics data platform. Follows ISO 8601 format. Used for change data capture (CDC), data lineage, and audit trail in the Databricks Silver layer.',
    `volume_commitment_units` DECIMAL(18,2) COMMENT 'Contracted minimum volume commitment by Consumer Goods to the carrier over the contract term, expressed in the unit defined by volume_commitment_uom (e.g., shipments, pallets, CWT, revenue miles). Failure to meet this commitment may trigger shortfall penalties or rate renegotiation.',
    `volume_commitment_uom` STRING COMMENT 'Unit of measure for the volume_commitment_units field. Defines whether the volume commitment is expressed in number of shipments, pallets, hundredweight (CWT), revenue miles, kilograms, or truckloads.. Valid values are `shipments|pallets|cwt|revenue_miles|kg|loads`',
    CONSTRAINT pk_carrier_contract PRIMARY KEY(`carrier_contract_id`)
) COMMENT 'Freight contract, rate agreement, and granular rate schedule between Consumer Goods and a carrier. Captures contract term dates, lane coverage, mode of transport, negotiated base rates, fuel surcharge tables, accessorial charge schedules, volume commitments, OTIF penalty clauses, contract status, and detailed rate records including rate type (per-mile/per-cwt/per-pallet/flat), origin/destination zones, weight breaks, effective/expiry dates, and currency. Supports freight cost estimation, tender evaluation, freight audit rate lookup, and carrier performance management.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`lane` (
    `lane_id` BIGINT COMMENT 'Unique system-generated identifier for the transportation lane record. Primary key for the lane entity in the logistics domain.',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier contract or rate agreement governing freight pricing and service terms on this lane. Links to the carrier contract master in the logistics domain.',
    `network_node_id` BIGINT COMMENT 'Reference to the destination facility, distribution center, retail store, or customer location where freight is delivered on this lane. Links to the location master in the logistics domain.',
    `carrier_id` BIGINT COMMENT 'Reference to the secondary/backup carrier for this lane, used when the preferred carrier declines the tender or is unavailable. Represents the second position in the routing guide.',
    `lane_preferred_carrier_id` BIGINT COMMENT 'Reference to the primary/preferred carrier assigned to this lane for freight tendering. Represents the first-tender carrier in the routing guide hierarchy. Links to the carrier master in the logistics domain.',
    `lane_supply_network_node_id` BIGINT COMMENT 'Reference to the origin facility, distribution center, plant, or supplier location from which freight departs on this lane. Links to the location master in the logistics domain.',
    `annual_volume_loads` STRING COMMENT 'Historical or planned annual shipment volume on this lane expressed in number of loads (truckloads, containers, or equivalent units). Used for carrier contract negotiations, network design, and freight spend forecasting.',
    `annual_volume_weight_kg` DECIMAL(18,2) COMMENT 'Historical or planned annual freight weight moved on this lane in kilograms. Used for carrier contract negotiations, modal optimization, and carbon emissions intensity calculations per ISO 14001.',
    `benchmark_rate_flat` DECIMAL(18,2) COMMENT 'Lane-level flat cost benchmark (all-in rate per load/shipment) in the operating currency. Used for truckload lanes where per-km pricing is not applicable. Supports freight audit and carrier contract negotiation.',
    `benchmark_rate_per_km` DECIMAL(18,2) COMMENT 'Lane-level cost benchmark expressed as rate per kilometer in the operating currency. Used for freight audit, carrier performance benchmarking, and transportation cost variance analysis. Confidential as it reflects negotiated contract intelligence.',
    `carbon_emission_factor` DECIMAL(18,2) COMMENT 'Lane-level carbon emission intensity factor expressed as kilograms of CO2 equivalent per kilometer, based on transport mode and equipment type. Used for Scope 3 emissions reporting, sustainability KPIs, and ESG disclosures per ISO 14001 and EPA Greenhouse Gas Reporting Program.',
    `classification` STRING COMMENT 'Directional and functional classification of the lane within the supply chain network. Inbound covers supplier-to-plant/DC movements; outbound covers DC-to-customer/retailer; inter-facility covers plant-to-DC or DC-to-DC; last-mile covers final delivery to end consumer or store; reverse covers returns flow.. Valid values are `inbound|outbound|inter_facility|last_mile|reverse`',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this lane requires temperature-controlled transportation to maintain product integrity. When true, cold-chain compliance monitoring, temperature logging, and qualified carrier requirements apply. Critical for health, hygiene, and perishable consumer goods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lane record was first created in the system. Used for data lineage, audit trail, and record lifecycle management. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `cross_border` BOOLEAN COMMENT 'Indicates whether this lane crosses an international border, requiring customs documentation, import/export compliance, and potentially additional transit time for border clearance. Drives customs broker assignment and trade compliance workflows.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the lane benchmark rates and cost data (e.g., USD, EUR, GBP). Required for multi-currency freight cost consolidation and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `customs_trade_zone` STRING COMMENT 'Trade zone or customs agreement applicable to this cross-border lane (e.g., USMCA, EU Single Market, ASEAN). Determines duty rates, documentation requirements, and customs clearance procedures. Populated only for cross-border lanes.',
    `destination_city` STRING COMMENT 'City name of the lane destination point. Used for geographic lane analysis, carrier rate zone determination, and network design reporting.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the lane destination. Required for cross-border lane classification, customs documentation, and international freight rate benchmarking.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Business-facing code for the destination location (e.g., customer DC code, store code, or GS1 Global Location Number). Used in EDI transactions, carrier communications, and freight audit matching.',
    `destination_state_province` STRING COMMENT 'ISO 3166-2 state or province code for the lane destination. Used in carrier rate zone mapping and freight cost benchmarking.. Valid values are `^[A-Z]{2,3}$`',
    `distance_km` DECIMAL(18,2) COMMENT 'Measured or calculated road/route distance between origin and destination in kilometers. Used for transit time estimation, fuel surcharge calculation, carrier rate benchmarking, and carbon emissions reporting per ISO 14001 and EPA guidelines.',
    `dsd_eligible` BOOLEAN COMMENT 'Indicates whether this lane supports Direct Store Delivery (DSD), where product is delivered directly from the manufacturer or distributor to the retail store, bypassing the retailers distribution center. Relevant for high-velocity CPG categories.',
    `effective_date` DATE COMMENT 'Date from which this lane definition becomes active and available for freight planning, carrier assignment, and cost benchmarking. Used to manage lane versioning and contract period alignment.',
    `equipment_type` STRING COMMENT 'Type of transportation equipment required for this lane. Refrigerated (reefer) equipment is critical for cold-chain compliance in temperature-sensitive consumer goods. Drives carrier qualification and cost benchmarking. [ENUM-REF-CANDIDATE: dry_van|refrigerated|flatbed|tanker|container_20ft|container_40ft|container_45ft|parcel|bulk — promote to reference product]',
    `expiry_date` DATE COMMENT 'Date after which this lane definition is no longer valid for freight planning. Nullable for open-ended lanes. Used to manage contract renewals, network redesigns, and lane decommissioning.',
    `hazmat_required` BOOLEAN COMMENT 'Indicates whether this lane requires carriers certified for hazardous materials (HAZMAT) transport. Applicable for lanes carrying chemical, aerosol, or regulated consumer goods. Triggers carrier qualification checks and regulatory documentation requirements per DOT/EPA/OSHA.',
    `lane_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the transportation lane, used in carrier contracts, freight tenders, and TMS systems. Typically formatted as ORIGIN-DEST-MODE (e.g., CHI-NYC-TL). Aligns with SAP TM lane master data.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `lane_name` STRING COMMENT 'Human-readable descriptive name for the transportation lane, typically combining origin and destination location names and transport mode (e.g., Chicago DC to New York RDC - Truckload). Used in reporting and carrier communication.',
    `lane_status` STRING COMMENT 'Current lifecycle status of the transportation lane. Active lanes are available for freight tendering and route optimization. Inactive or suspended lanes are excluded from planning runs.. Valid values are `active|inactive|suspended|pending_approval`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lane record was last updated. Used for change tracking, data freshness monitoring, and incremental ETL processing in the Databricks Silver Layer.',
    `network_region` STRING COMMENT 'Geographic or operational network region to which this lane belongs (e.g., Northeast, Southeast, Midwest, West Coast, EMEA, APAC). Used for network design segmentation, regional freight cost analysis, and carrier portfolio management.',
    `origin_city` STRING COMMENT 'City name of the lane origin point. Used for geographic lane analysis, carrier rate zone determination, and network design reporting.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the lane origin. Required for cross-border lane classification, customs documentation, and international freight rate benchmarking.. Valid values are `^[A-Z]{3}$`',
    `origin_location_code` STRING COMMENT 'Business-facing code for the origin location (e.g., plant code, DC code, or GS1 Global Location Number). Used in EDI transactions, carrier communications, and freight audit matching.',
    `origin_state_province` STRING COMMENT 'ISO 3166-2 state or province code for the lane origin. Used in carrier rate zone mapping, regulatory compliance (e.g., CARB emissions zones), and freight cost benchmarking.. Valid values are `^[A-Z]{2,3}$`',
    `otif_target_pct` DECIMAL(18,2) COMMENT 'Target OTIF (On Time In Full) performance percentage for this lane, representing the contractual or operational delivery reliability goal. Used as the KPI baseline for carrier performance scorecards and SLA compliance reporting.',
    `routing_guide_rank` STRING COMMENT 'Numeric rank of the preferred carrier in the lane routing guide sequence. Rank 1 is the primary carrier; higher ranks are fallback options. Used in automated freight tendering workflows to determine tender sequence.',
    `service_level` STRING COMMENT 'Contracted service level for this lane defining the speed and priority of freight movement. Standard is regular scheduled service; expedited is premium fast transit; economy is cost-optimized slower service; dedicated is exclusive carrier capacity; spot is ad-hoc market rate.. Valid values are `standard|expedited|economy|dedicated|spot`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this lane record originated (e.g., SAP Transportation Management, Blue Yonder WMS). Used for data lineage tracking and reconciliation in the Databricks Silver Layer.. Valid values are `SAP_TM|BLUE_YONDER|ORACLE_TMS|MANUAL`',
    `standard_transit_days` STRING COMMENT 'Contractually agreed or operationally standard number of calendar days for freight to travel from origin to destination on this lane. Used as the baseline for OTIF (On Time In Full) measurement, delivery promise, and ATP/CTP calculations in SAP IBP.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold-chain lanes. Freight must be maintained at or below this threshold throughout transit. Used for carrier qualification, SLA monitoring, and regulatory compliance under FDA and GMP guidelines.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for cold-chain lanes. Freight must be maintained at or above this threshold throughout transit. Used for carrier qualification, SLA monitoring, and regulatory compliance under FDA and GMP guidelines.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used on this lane. Determines carrier pool, equipment type, transit time standards, and freight cost benchmarks. Truckload (TL) and Less-than-Truckload (LTL) are most common in CPG domestic networks. [ENUM-REF-CANDIDATE: truckload|less_than_truckload|intermodal|rail|air|ocean|parcel|courier|drayage — promote to reference product]',
    CONSTRAINT pk_lane PRIMARY KEY(`lane_id`)
) COMMENT 'Defined origin-to-destination transportation lane used for freight planning, carrier assignment, and cost benchmarking. Captures origin and destination location codes, transport mode, distance, transit time standard, lane classification (inbound/outbound/inter-facility/last-mile), preferred carrier assignments, volume history, and lane-level cost benchmarks. Foundational reference for route optimization, freight tendering, and network design.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` (
    `logistics_shipment_id` BIGINT COMMENT 'Unique surrogate identifier for the logistics shipment record in the lakehouse Silver layer. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Reference to the contracted carrier (trucking company, ocean liner, air freight provider, parcel carrier) responsible for executing this shipment.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the facility (distribution center, retail store, customer location, or 3PL node) to which the shipment is consigned.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Required for Promotion Execution Report linking shipments to promotion events for spend attribution and compliance.',
    `freight_rate_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_rate. Business justification: A logistics shipment is executed at a specific freight rate from the rate schedule. Linking logistics_shipment to freight_rate enables direct rate-to-actuals reconciliation — comparing the contracted ',
    `lane_id` BIGINT COMMENT 'Reference to the contracted transportation lane (origin-destination pair) governing rate, transit time, and carrier assignment for this shipment.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Traceability: link each shipment to its originating manufacturing facility for cost allocation and regulatory reporting.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Enables brand‑level logistics KPI aggregation (OTIF, cost) by associating every shipment with the owning brand of the shipped SKU.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to customer.trade_account. Business justification: Shipment origin account is needed for cost attribution, SLA reporting, and regulatory shipment origin documentation.',
    `primary_logistics_distribution_facility_id` BIGINT COMMENT 'Reference to the facility (plant, distribution center, warehouse, or supplier location) from which the shipment departs.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Required for shipment compliance verification: each shipment must reference the products regulatory registration to confirm valid registration at shipping time.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Shipment tracking must reference the originating sales order for fulfillment status and revenue reconciliation.',
    `actual_delivery_date` DATE COMMENT 'The actual date the shipment was received and confirmed at the destination facility. Used for OTIF (On Time In Full) KPI calculation and carrier performance scorecarding.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Precise date and time the shipment was delivered and signed for at the destination, as captured by the carriers POD (Proof of Delivery) system or electronic signature device. Enables time-window compliance measurement.',
    `actual_ship_date` DATE COMMENT 'The actual date the shipment physically departed from the origin facility, as confirmed by the WMS or carrier. Used for OTIF (On Time In Full) measurement and freight audit.',
    `bol_number` STRING COMMENT 'Bill of Lading number issued by the carrier as the legal contract of carriage and receipt of goods. Required for freight audit, customs clearance, and proof of delivery. Key document in SAP S/4HANA SD and Blue Yonder WMS.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this shipment requires temperature-controlled cold chain handling throughout transit. Triggers cold chain compliance monitoring, reefer equipment assignment, and regulatory documentation for applicable product categories (e.g., perishables, pharmaceuticals).',
    `container_number` STRING COMMENT 'ISO 6346 standardized container identification number for ocean freight shipments (e.g., MSCU1234567). Used for port tracking, customs clearance, and demurrage/detention management.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the source system (TMS/ERP/WMS). Used for audit trail, data lineage, and SLA measurement from order-to-ship cycle time analysis.',
    `direction` STRING COMMENT 'Indicates the direction of the shipment relative to the enterprise network: inbound (from supplier), outbound (to customer/retailer), interplant (between internal facilities), or return (reverse logistics).. Valid values are `inbound|outbound|interplant|return`',
    `exception_code` STRING COMMENT 'Standardized code identifying the reason for a shipment exception or delay (e.g., weather delay, carrier capacity, customs hold, address correction, damaged goods). Used for root cause analysis and carrier performance management. [ENUM-REF-CANDIDATE: weather_delay|carrier_capacity|customs_hold|address_correction|damaged_goods|mechanical_failure|other — promote to reference product]',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total contracted or invoiced freight cost for this shipment in the transaction currency. Used for freight cost allocation to COGS (Cost of Goods Sold), carrier spend analytics, and freight audit reconciliation.',
    `freight_cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the freight cost amount (e.g., USD, EUR, GBP). Required for multi-currency freight spend reporting and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `freight_terms` STRING COMMENT 'Freight payment terms indicating who bears the freight cost: prepaid (shipper pays), collect (consignee pays), or third_party (a designated third party pays). Drives freight invoice routing and cost allocation.. Valid values are `prepaid|collect|third_party`',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Carrier-applied fuel surcharge amount for this shipment, separate from the base freight rate. Used for freight audit, cost variance analysis, and carrier contract compliance.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling, labeling, and documentation per DOT/IATA/IMDG regulations. Triggers HAZMAT compliance workflow and carrier notification.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the transfer of risk, cost responsibility, and delivery obligations between shipper and consignee. Governs freight cost allocation and insurance requirements. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `otif_in_full` BOOLEAN COMMENT 'Indicates whether the shipment was delivered with the complete ordered quantity, contributing to the OTIF (On Time In Full) KPI. Supports retailer compliance scorecarding and deduction management.',
    `otif_on_time` BOOLEAN COMMENT 'Indicates whether the shipment was delivered on or before the planned delivery date, contributing to the OTIF (On Time In Full) KPI. Derived from planned vs. actual delivery date comparison and stored for reporting efficiency.',
    `planned_delivery_date` DATE COMMENT 'The date on which the shipment is expected to arrive at the destination facility, based on contracted transit time and lane performance.',
    `planned_ship_date` DATE COMMENT 'The date on which the shipment is scheduled to depart from the origin facility, as determined by the transportation plan or S&OP (Sales and Operations Planning) process.',
    `pod_received` BOOLEAN COMMENT 'Indicates whether a signed Proof of Delivery (POD) document has been received and validated for this shipment. Required for freight invoice payment release and dispute resolution.',
    `pod_timestamp` TIMESTAMP COMMENT 'Date and time the Proof of Delivery (POD) was electronically captured or received, as recorded by the carriers mobile device or ePOD system. Used for freight audit and dispute resolution timelines.',
    `pro_number` STRING COMMENT 'Carrier-assigned Progressive (PRO) number used to track LTL (Less-Than-Truckload) shipments through the carriers network. Essential for freight audit and claims management.. Valid values are `^[A-Z0-9-]{4,25}$`',
    `service_level` STRING COMMENT 'Contracted carrier service level for this shipment, determining transit time commitment and freight rate tier. Drives SLA (Service Level Agreement) compliance measurement.. Valid values are `standard|expedited|overnight|same_day|economy`',
    `ship_timestamp` TIMESTAMP COMMENT 'Precise date and time the shipment departed the origin facility, as recorded by the WMS or gate system. Used for transit time calculation and carrier SLA compliance.',
    `shipment_number` STRING COMMENT 'Externally-known business identifier for the shipment, typically generated by the TMS or ERP (e.g., SAP outbound delivery number or transportation order number). Used for track-and-trace and carrier communication.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment. Drives OTIF (On Time In Full) measurement, exception management, and track-and-trace visibility. [ENUM-REF-CANDIDATE: planned|tendered|confirmed|in_transit|out_for_delivery|delivered|cancelled|exception — promote to reference product]',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold chain shipments. Exceedances trigger quality holds, product disposition reviews, and regulatory notifications.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for cold chain shipments. Used for reefer equipment configuration, carrier instructions, and cold chain compliance auditing.',
    `three_pl_reference` STRING COMMENT 'Reference number assigned by the 3PL (Third-Party Logistics) provider for this shipment in their WMS or TMS. Enables cross-system reconciliation and 3PL billing validation.. Valid values are `^[A-Z0-9-]{4,40}$`',
    `total_cases` STRING COMMENT 'Total number of cases (cartons) included in the shipment. Used for pick/pack verification, receiving reconciliation, and OTIF (On Time In Full) quantity compliance.',
    `total_pallets` STRING COMMENT 'Total number of pallets included in the shipment. Used for dock scheduling, trailer loading planning, and carrier billing for LTL shipments.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment in cubic meters. Used for dimensional weight calculation, trailer utilization, and freight cost optimization.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms, including packaging and pallets. Used for freight rate calculation, carrier billing, and compliance with road weight limits.',
    `tracking_number` STRING COMMENT 'Carrier-assigned tracking number for parcel or express shipments (e.g., UPS, FedEx, DHL tracking number). Enables real-time track-and-trace via carrier APIs and customer-facing shipment visibility portals.. Valid values are `^[A-Z0-9]{8,35}$`',
    `transport_mode` STRING COMMENT 'Mode of transportation used for this shipment. TL = Truckload, LTL = Less-Than-Truckload, parcel = small package carrier, ocean = sea freight, air = air freight, rail = rail freight. Drives freight cost allocation and transit time expectations.. Valid values are `TL|LTL|parcel|ocean|air|rail`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipment record in the source system. Used for incremental data loading, change detection, and audit trail in the Silver layer lakehouse.',
    CONSTRAINT pk_logistics_shipment PRIMARY KEY(`logistics_shipment_id`)
) COMMENT 'Core transactional record representing a physical movement of goods from origin to destination. Captures shipment number, BOL (Bill of Lading), PRO number, carrier assignment, mode of transport (TL/LTL/parcel/ocean/air/rail), origin and destination facility, planned and actual ship/delivery dates, total weight and volume, freight terms (prepaid/collect/third-party), shipment status lifecycle, incoterms, cold-chain flag, and consolidation references. Central entity for track-and-trace, OTIF measurement, and freight cost allocation. References carrier, lane, and freight order.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` (
    `shipment_item_id` BIGINT COMMENT 'Unique surrogate identifier for each shipment line item record in the logistics data platform. Primary key for the shipment_item entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: FDA/EU GMP lot traceability requires linking each shipped line item to its manufacturing batch record. Enables lot-level recall execution, expiry date validation, and regulatory audit trails. Consumer',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center from which this item was picked and dispatched. Used for inventory depletion tracking, warehouse performance analytics, and DRP (Distribution Requirements Planning).',
    `event_sku_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event_sku. Business justification: Needed for Promotional SKU shipment reconciliation to calculate allocated vs actual promotional volume per shipment.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Required for lot traceability report linking inspected lots to shipped items, enabling recall and compliance verification.',
    `label_version_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_version. Business justification: Consumer Goods regulatory compliance requires that shipped products carry the jurisdiction-approved label version for the destination market. This link enables label compliance audits, recall traceabi',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent shipment header record. Establishes the header-to-line relationship for all items within a single shipment dispatch event. Aligns with SAP SD delivery document header.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: FDA/FSMA traceability and recall management require direct lot/batch identification on shipped items. Consumer goods recall coordinators query shipment items by lot to determine distribution scope. ex',
    `pack_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.pack_hierarchy. Business justification: SSCC labeling, pallet configuration validation, and carrier compliance in consumer goods require knowing the exact pack level (each/case/pallet) being shipped. Pack hierarchy defines TI/HI, GTIN, and ',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: Freight audit, carrier compliance, and OTIF reporting require knowing which packaging spec (dimensions, weight, hazmat, cold-chain flags) was used for each shipment line. Consumer goods logistics team',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: shipment_item.purchase_order_number is a denormalized text reference to the originating PO line. Replacing with a proper FK to po_line enables OTIF measurement at PO line level, goods receipt reconcil',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to inventory.recall_event. Business justification: During a product recall, consumer goods recall coordinators must identify all shipment items containing affected lots in the distribution network. Direct recall_event_id on shipment_item enables recal',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Needed for item‑level compliance reporting; links each shipped item to its regulatory registration for traceability and audit.',
    `sds_id` BIGINT COMMENT 'Foreign key linking to regulatory.sds. Business justification: ADR/IATA/IMDG regulations mandate that Safety Data Sheets accompany hazardous shipment items in transit. Consumer Goods compliance teams must verify the correct SDS version is associated with each haz',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for shipping manifest and inventory reconciliation; each shipment line must reference the master SKU to enable traceability, OTIF reporting, and regulatory compliance.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Needed for Pick Allocation process linking each shipment item to the specific stock position it was sourced from, supporting inventory reservation and traceability.',
    `supply_replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_replenishment_order. Business justification: Shipment items represent line-level shipped quantities that must be reconciled against replenishment order lines for goods receipt confirmation and over/under-shipment resolution — a standard consumer',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed as received by the consignee at the delivery destination, captured from proof of delivery (POD) or EDI 214 acknowledgment. Used for invoice reconciliation and OTIF final measurement.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating where the product was manufactured or substantially transformed. Required for customs declarations, import duty determination, and trade compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipment item record was first created in the data platform, in ISO 8601 format with timezone offset. Used for data lineage, audit trail, and SLA measurement.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which unit_cost and line_value are expressed. Enables multi-currency financial consolidation and FX reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_document_number` STRING COMMENT 'ERP delivery document number (e.g., SAP outbound delivery number) associated with this shipment line. Serves as the primary cross-reference between the logistics execution system and the financial/order management system.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of this shipment line item in kilograms, including product, inner packaging, and outer packaging. Used for freight cost calculation, carrier capacity planning, and customs declarations.',
    `harmonized_tariff_code` STRING COMMENT 'Harmonized System (HS) tariff classification code for the product, used for customs clearance, import duty calculation, and international trade compliance. Typically 6-10 digits per WCO HS nomenclature.. Valid values are `^[0-9]{6,10}$`',
    `is_controlled_substance` BOOLEAN COMMENT 'Indicates whether this item contains a controlled substance subject to DEA scheduling, FDA drug regulations, or equivalent international narcotics controls. Triggers enhanced chain-of-custody documentation requirements.',
    `is_dsd` BOOLEAN COMMENT 'Indicates whether this item is fulfilled via Direct Store Delivery (DSD) channel, bypassing the retailers distribution center and delivering directly to the store. Impacts route planning, SFA integration, and trade promotion settlement.',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether this shipment item is classified as a hazardous material requiring special handling, labeling, and transport documentation per DOT, IATA, or IMDG regulations. Triggers mandatory SDS (Safety Data Sheet) attachment.',
    `is_temperature_sensitive` BOOLEAN COMMENT 'Indicates whether this item requires temperature-controlled handling and transport (cold chain). When true, temperature range requirements and cold-chain compliance monitoring are enforced throughout the shipment lifecycle.',
    `item_description` STRING COMMENT 'Human-readable description of the product being shipped, including product name, variant, and pack size. Used on shipping documents, proof of delivery, and freight audit records.',
    `item_status` STRING COMMENT 'Current lifecycle status of this shipment line item. Tracks progression from warehouse picking through delivery confirmation. [ENUM-REF-CANDIDATE: planned|picked|loaded|in_transit|delivered|short_shipped|cancelled — promote to reference product]',
    `line_number` STRING COMMENT 'Sequential line number of this item within the parent shipment, used for ordering and referencing individual line items. Corresponds to SAP SD delivery item position number.',
    `line_value` DECIMAL(18,2) COMMENT 'Total declared value of this shipment line item (shipped_quantity × unit_cost), used for customs valuation, cargo insurance, and financial reporting. Expressed in the shipment currency.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for storage and transport of this item. Applicable when is_temperature_sensitive is true. Exceedances trigger quality holds and non-conformance reporting.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for storage and transport of this item. Applicable when is_temperature_sensitive is true. Used to configure cold-chain monitoring alerts and carrier SLA requirements.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the product content only in kilograms, excluding all packaging materials. Required for regulatory labeling compliance, customs documentation, and COGS (Cost of Goods Sold) reporting.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of this item originally ordered by the customer or requested in the purchase order. Used for OTIF (On Time In Full) calculation and order fulfillment rate reporting.',
    `packaging_type` STRING COMMENT 'Type of packaging unit in which the item is shipped. Determines handling requirements, stacking rules, and warehouse slotting. Aligns with GS1 packaging hierarchy levels.. Valid values are `each|inner_pack|case|display|pallet|bulk`',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether this shipment line item has been placed on a quality hold due to a failed QC inspection, temperature exceedance, or regulatory non-conformance. Items on hold must not be delivered until released by QA.',
    `regulatory_approval_number` STRING COMMENT 'Product registration or regulatory approval number required for cross-border shipments of regulated consumer goods (e.g., FDA registration, EPA registration, EU REACH authorization). Stored for customs and import compliance documentation.',
    `rejection_reason` STRING COMMENT 'Reason code or description for any quantity rejected or short-shipped on this line item, such as OOS (Out of Stock), quality hold, weight discrepancy, or carrier refusal. Used for root cause analysis and OTIF exception reporting.',
    `sales_order_line` STRING COMMENT 'Line item number within the originating sales order corresponding to this shipment item. Used for precise order-to-shipment reconciliation and partial fulfillment tracking.',
    `sales_order_number` STRING COMMENT 'Reference to the originating sales order number from the ERP system (SAP SD) that triggered this shipment line. Enables order-to-delivery traceability and OTIF measurement at the order line level.',
    `serial_number` STRING COMMENT 'Unique serial number assigned to an individual product unit, applicable for serialized items requiring unit-level traceability (e.g., high-value consumer electronics, regulated health products). Null for non-serialized bulk items.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of this item loaded and dispatched in the shipment. May differ from ordered quantity due to partial fulfillment, OOS (Out of Stock) conditions, or substitution. Core metric for OTIF compliance.',
    `sscc` STRING COMMENT 'GS1 Serial Shipping Container Code (SSCC) — an 18-digit identifier assigned to the logistic unit (pallet, case) containing this item. Enables pallet-level traceability and EDI 856 ASN compliance with retail trading partners.. Valid values are `^[0-9]{18}$`',
    `storage_location` STRING COMMENT 'Specific storage location or bin within the warehouse from which this item was picked, as recorded in the WMS. Used for warehouse slotting optimization and pick path efficiency analysis.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of measure for this item at time of shipment, used for COGS (Cost of Goods Sold) calculation, inventory valuation, and freight cost allocation. Sourced from SAP S/4HANA CO standard cost.',
    `unit_of_measure` STRING COMMENT 'Unit of measure in which the shipped quantity is expressed. Common values include EA (each), CS (case), PL (pallet), KG (kilogram), LB (pound), L (litre), GAL (gallon). Aligns with GS1 UOM codes. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this shipment item record, in ISO 8601 format with timezone offset. Used for change data capture (CDC), incremental ETL processing, and audit trail maintenance.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Cubic volume of this shipment line item in cubic metres, used for truck load planning, container utilization optimization, and freight rate calculation based on dimensional weight.',
    CONSTRAINT pk_shipment_item PRIMARY KEY(`shipment_item_id`)
) COMMENT 'Line-item detail of goods included in a shipment. Captures SKU/GTIN, product description, ordered quantity, shipped quantity, unit of measure, gross weight, net weight, volume, hazmat flag, temperature-sensitive flag, lot/batch number, expiry date (FEFO compliance), and packaging type. Enables item-level traceability and cold-chain compliance tracking.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`delivery` (
    `delivery_id` BIGINT COMMENT 'Unique surrogate identifier for each delivery execution record in the Silver layer lakehouse. Primary key for the delivery data product.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotional delivery OTIF compliance: consumer goods TPM requires tracking whether deliveries arrived within the promotion event window. Direct FK enables promotion event OTIF dashboards and retailer ',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to sales.invoice. Business justification: Accounts receivable teams match delivery confirmations to invoices for payment release, dispute resolution, and DSO tracking. OTIF delivery status directly affects invoice dispute flags. Consumer good',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent shipment record from which this delivery was dispatched. Links delivery execution back to the shipment planning record.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Deliveries are executed to specific retail store locations. Store-level OTIF compliance reporting, DSD route execution, and planogram delivery verification all require linking each delivery to the ret',
    `route_id` BIGINT COMMENT 'Reference to the planned delivery route assigned to this delivery. Enables route optimization analysis and OTIF (On Time In Full) performance measurement.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Delivery execution is tied to a specific sales order; the link supports delivery confirmation and invoicing workflows.',
    `supply_replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_replenishment_order. Business justification: Confirmed deliveries trigger replenishment order closure and inventory receipt posting. Linking delivery to supply_replenishment_order enables automatic order status updates and OTIF measurement again',
    `trade_account_id` BIGINT COMMENT 'Reference to the consignee (receiving party) account — typically a retail store, distribution center, or wholesale customer — to whom the goods are delivered.',
    `vehicle_id` BIGINT COMMENT 'Reference to the vehicle or transport unit used for this delivery. Supports fleet management, cold-chain compliance, and route analytics.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Deliveries in consumer goods dispatch from a specific warehouse. Warehouse-level delivery performance reporting (OTIF by dispatch warehouse), dock scheduling, and inventory reservation at dispatch all',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The actual date and time the delivery was completed at the consignee location, as recorded by the driver via DSD handheld, e-POD app, or paper scan. Principal business event timestamp for OTIF calculation and dispute resolution.',
    `actual_temperature_c` DECIMAL(18,2) COMMENT 'Actual temperature in degrees Celsius recorded during delivery, captured by IoT sensor or driver log. Used to verify cold-chain compliance and support FDA/EU GDP regulatory reporting for temperature-sensitive goods.',
    `carrier_code` STRING COMMENT 'Standardized code identifying the carrier or 3PL (Third-Party Logistics) provider responsible for executing the delivery. Used for carrier performance scorecarding, freight audit, and contract compliance.',
    `carrier_tracking_number` STRING COMMENT 'External tracking number assigned by the carrier for track-and-trace visibility. Enables real-time shipment monitoring and customer-facing delivery status updates.',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this delivery requires temperature-controlled cold-chain logistics (True) — applicable for perishable food, pharmaceutical, or temperature-sensitive consumer goods. Drives vehicle assignment and compliance monitoring.',
    `consignee_name` STRING COMMENT 'Legal or trading name of the receiving party (store, warehouse, or customer) at the delivery destination. Used for POD (Proof of Delivery) documentation and dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery record was first created in the source system (SAP S/4HANA SD outbound delivery creation). Audit trail field for data lineage and SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the freight cost amount (e.g., USD, EUR, GBP). Required for multi-currency freight cost reporting and financial consolidation.. Valid values are `[A-Z]{3}`',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of goods physically delivered and accepted at the consignee location. Core metric for OTIF (On Time In Full) in-full measurement, fill rate KPI, and invoice reconciliation.',
    `delivery_number` STRING COMMENT 'Externally-known business identifier for the delivery, typically sourced from SAP S/4HANA SD outbound delivery document (e.g., 80XXXXXXXX). Used in EDI communications, carrier coordination, and customer-facing tracking.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery execution. full = all ordered quantities delivered; partial = some quantities delivered; failed = delivery attempt unsuccessful; refused = consignee rejected delivery; pending = delivery not yet attempted. Core field for OTIF (On Time In Full) calculation.. Valid values are `full|partial|failed|refused|pending`',
    `delivery_type` STRING COMMENT 'Classification of the delivery method. DSD (Direct Store Delivery) = manufacturer delivers directly to retail shelf; warehouse = delivery to distribution center; cross_dock = transit without storage; drop_ship = vendor ships directly to consignee; returns = reverse logistics delivery. [ENUM-REF-CANDIDATE: DSD|warehouse|cross_dock|drop_ship|returns — promote to reference product]. Valid values are `DSD|warehouse|cross_dock|drop_ship|returns`',
    `electronic_signature_flag` BOOLEAN COMMENT 'Indicates whether the POD (Proof of Delivery) signature was captured electronically (True) via e-POD app or DSD handheld, or obtained on paper (False). Determines evidentiary strength for dispute resolution.',
    `exception_code` STRING COMMENT 'Standardized exception code identifying the reason for delivery failure, partial delivery, or refusal (e.g., CONSIGNEE_CLOSED, ADDRESS_NOT_FOUND, CAPACITY_EXCEEDED, REFUSED_QUALITY). Sourced from carrier or DSD system exception taxonomy. [ENUM-REF-CANDIDATE: promote to reference product]',
    `exception_notes` STRING COMMENT 'Free-text notes describing delivery discrepancies, exceptions, or special circumstances recorded by the driver or dispatcher. Supplements the structured exception code for dispute resolution and root cause analysis.',
    `first_attempt_timestamp` TIMESTAMP COMMENT 'Date and time of the first delivery attempt at the consignee location. Relevant when the delivery required multiple attempts (e.g., failed first attempt followed by successful re-delivery). Supports carrier performance analytics.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost incurred for this delivery in the transaction currency. Used for freight audit, carrier invoice reconciliation, COGS (Cost of Goods Sold) allocation, and logistics cost-to-serve analytics.',
    `goods_condition_code` STRING COMMENT 'Condition of goods as assessed at point of delivery receipt. good = acceptable; damaged = physical damage observed; partial_damage = some units damaged; temperature_breach = cold-chain violation detected; contaminated = product integrity compromised. Triggers quality investigation and regulatory reporting. [ENUM-REF-CANDIDATE: good|damaged|partial_damage|temperature_breach|contaminated — promote to reference product]. Valid values are `good|damaged|partial_damage|temperature_breach|contaminated`',
    `in_full_flag` BOOLEAN COMMENT 'Indicates whether the full ordered quantity was delivered (True). Component of the OTIF (On Time In Full) KPI, enabling separate on-time vs. in-full root cause analysis and fill rate reporting.',
    `on_time_flag` BOOLEAN COMMENT 'Indicates whether the delivery was completed on or before the scheduled delivery date/time (True). Component of the OTIF (On Time In Full) KPI, enabling separate on-time vs. in-full root cause analysis.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Total quantity of goods ordered for this delivery as per the originating sales order. Baseline for OTIF (On Time In Full) in-full calculation and delivery fill rate measurement.',
    `otif_flag` BOOLEAN COMMENT 'Indicates whether this delivery met the OTIF (On Time In Full) KPI criteria — True if delivered on or before the scheduled date AND at 100% of ordered quantity. Core retail compliance metric for major retailers (e.g., Walmart OTIF penalty program).',
    `photo_attachment_reference` STRING COMMENT 'Storage reference or URL to photo evidence captured at delivery (e.g., goods condition, placement, damaged packaging). Supports POD (Proof of Delivery) documentation and insurance claims.',
    `pod_source` STRING COMMENT 'System or method used to capture the POD (Proof of Delivery). DSD_handheld = Direct Store Delivery device; epod_app = electronic POD mobile application; paper_scan = digitized paper document; EDI = Electronic Data Interchange confirmation; manual = manually entered. Determines data quality and evidentiary weight.. Valid values are `DSD_handheld|epod_app|paper_scan|EDI|manual`',
    `quantity_uom` STRING COMMENT 'Unit of measure for ordered and delivered quantities (e.g., EA=each, CS=case, PAL=pallet, KG=kilogram). Aligns with GS1 unit of measure codes and SAP base unit of measure configuration. [ENUM-REF-CANDIDATE: EA|CS|PAL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `recipient_name` STRING COMMENT 'Full name of the individual who physically received and signed for the delivery at the consignee location. Core POD (Proof of Delivery) field for dispute resolution and legal evidence.',
    `refused_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods refused or rejected by the consignee at point of delivery. Triggers reverse logistics, credit memo processing, and quality investigation workflows.',
    `scheduled_delivery_date` DATE COMMENT 'The planned calendar date on which the delivery was scheduled to arrive at the consignee location. Used as the baseline for OTIF (On Time In Full) on-time measurement and SLA compliance.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'The precise planned date and time window start for delivery at the consignee location. Supports time-window compliance measurement and carrier SLA (Service Level Agreement) tracking.',
    `signature_reference` STRING COMMENT 'Storage reference or URL pointing to the captured electronic or scanned signature image for this delivery. Used as legal evidence in POD (Proof of Delivery) dispute resolution.',
    `sscc` STRING COMMENT 'GS1 Serial Shipping Container Code (SSCC) — 18-digit identifier assigned to the shipping unit (pallet, case, or container) for this delivery. Enables end-to-end supply chain traceability per GS1 standards.. Valid values are `^d{18}$`',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold-chain delivery compliance. Compared against actual recorded temperature to detect cold-chain breaches and trigger regulatory reporting.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for cold-chain delivery compliance. Compared against actual recorded temperature to detect cold-chain breaches and trigger regulatory reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the delivery record in the source system. Supports incremental data loading, audit trails, and change detection in the Silver layer.',
    CONSTRAINT pk_delivery PRIMARY KEY(`delivery_id`)
) COMMENT 'Record of final delivery execution and proof of delivery (POD) at the consignee location. Captures delivery number, shipment reference, consignee account, delivery address, scheduled and actual delivery timestamps, delivered quantity, delivery status (full/partial/failed/refused), recipient name and signature, electronic signature flag, condition of goods at receipt, photo attachment references, discrepancy notes, POD source (DSD handheld, e-POD app, paper scan), driver/vehicle reference, and exception codes. SSOT for last-mile delivery outcomes, OTIF calculation, and dispute resolution evidence.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` (
    `proof_of_delivery_id` BIGINT COMMENT 'Unique system-generated identifier for the proof of delivery record. Primary key for this entity.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: POD is the primary evidence for AR dispute and deduction management in consumer goods. Finance AR teams directly reference POD records when resolving customer short-payment claims, billing disputes, a',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or 3PL responsible for executing the delivery. Used for freight audit, carrier performance tracking, and dispute resolution.',
    `delivery_id` BIGINT COMMENT 'Reference to the delivery order (SAP outbound delivery document) associated with this POD. Enables traceability from POD back to the originating delivery instruction.',
    `route_id` BIGINT COMMENT 'Reference to the planned delivery route on which this POD was captured. Enables route-level performance analysis, stop sequencing, and DSD route compliance reporting.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: POD is a legal document directly tied to a sales order for OTIF confirmation, dispute resolution, and revenue recognition. Consumer goods order-to-cash processes require direct POD-to-order linkage fo',
    `trade_account_id` BIGINT COMMENT 'Reference to the consignee (retail customer, distributor, or DC) who received the goods. Supports PARTY_REFERENCE requirement for TRANSACTION_HEADER role.',
    `bill_of_lading_number` STRING COMMENT 'The bill of lading number issued by the carrier for this shipment. Serves as the primary legal transport document reference and is used in freight audit, customs compliance, and dispute resolution.',
    `carrier_scan_timestamp` TIMESTAMP COMMENT 'Timestamp of the carriers own barcode or RFID scan event at the point of delivery, as transmitted via EDI or carrier portal. May differ from receipt_timestamp if there is a lag between physical delivery and system capture.',
    `cold_chain_compliant_flag` BOOLEAN COMMENT 'Indicates whether the delivery maintained required cold-chain temperature conditions throughout transit (True = compliant). Critical for temperature-sensitive consumer goods (e.g., dairy, frozen, pharmaceutical). Supports FDA and ISO 22716 compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this POD record was first created in the system, either by a DSD handheld, e-POD app, or paper scan ingestion process. Supports audit trail and data lineage.',
    `customer_reference_number` STRING COMMENT 'The consignees own purchase order or reference number for this delivery. Enables cross-referencing between the suppliers POD and the customers receiving records for EDI reconciliation and dispute resolution.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of goods confirmed as received by the consignee at the time of delivery. Used to calculate OTIF (On Time In Full) fill rate and identify quantity discrepancies against the ordered quantity.',
    `delivery_location_gln` STRING COMMENT 'GS1 Global Location Number (GLN) of the delivery destination. Provides a globally unique, standardized identifier for the consignee location, enabling interoperability with trading partners and EDI systems.. Valid values are `^[0-9]{13}$`',
    `delivery_location_name` STRING COMMENT 'Name of the physical delivery location (e.g., store name, distribution center name, warehouse name). Provides human-readable identification of the delivery destination for reporting and operations.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery event. Drives freight audit workflows, OTIF (On Time In Full) reporting, and dispute resolution processes. [ENUM-REF-CANDIDATE: pending|delivered|partially_delivered|failed|disputed|cancelled — promote to reference product if additional statuses are required]. Valid values are `pending|delivered|partially_delivered|failed|disputed|cancelled`',
    `delivery_temperature_c` DECIMAL(18,2) COMMENT 'Recorded temperature in degrees Celsius at the point of delivery for temperature-sensitive goods. Used to verify cold-chain compliance and support FDA regulatory reporting for perishable or pharmaceutical consumer goods.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was identified at the time of delivery (True = discrepancy exists). Triggers downstream dispute resolution, freight audit, and claims workflows.',
    `discrepancy_notes` STRING COMMENT 'Free-text description of any discrepancy observed at delivery, such as quantity shortages, damaged packaging, wrong items, or temperature excursions. Used in dispute resolution and freight audit processes.',
    `discrepancy_type` STRING COMMENT 'Categorical classification of the type of discrepancy identified at delivery. Enables structured reporting and root cause analysis across the logistics network. [ENUM-REF-CANDIDATE: quantity_shortage|overage|damaged_goods|wrong_item|temperature_breach|missing_documentation — promote to reference product]. Valid values are `quantity_shortage|overage|damaged_goods|wrong_item|temperature_breach|missing_documentation`',
    `dispute_resolution_date` DATE COMMENT 'The date on which a delivery dispute was formally resolved. Used to measure dispute resolution cycle time and SLA compliance for freight audit and carrier management.',
    `dispute_status` STRING COMMENT 'Current status of any freight or delivery dispute associated with this POD. Tracks the lifecycle of dispute resolution from identification through closure. Supports freight audit and carrier claims management.. Valid values are `no_dispute|open|under_review|resolved|escalated`',
    `dsd_route_stop_sequence` STRING COMMENT 'The sequential stop number of this delivery within the DSD route. Used for route optimization analysis, driver performance measurement, and DSD compliance reporting in Salesforce Consumer Goods Cloud.',
    `electronic_signature_flag` BOOLEAN COMMENT 'Indicates whether the POD was captured via electronic signature (True) or via paper-based signature (False). Drives e-POD compliance reporting and DSD handheld audit workflows.',
    `freight_bill_number` STRING COMMENT 'The carrier-issued freight bill or bill of lading (BOL) number associated with this delivery. Used to match POD records to freight invoices during freight audit and payment processes.',
    `geofence_validated_flag` BOOLEAN COMMENT 'Indicates whether the GPS coordinates captured at delivery were within the expected geofence boundary of the consignee location (True = within geofence). Used to detect fraudulent or erroneous POD captures in DSD operations.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate captured at the time of delivery confirmation. Used for geofencing validation, proof of delivery location verification, and DSD compliance auditing.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate captured at the time of delivery confirmation. Used alongside latitude for geofencing validation, delivery location verification, and DSD compliance auditing.',
    `goods_condition` STRING COMMENT 'Condition of the goods as assessed at the point of delivery by the recipient. Drives claims processing, carrier liability assessment, and quality incident reporting. [ENUM-REF-CANDIDATE: intact|damaged|partial_damage|refused|short_delivered — promote to reference product if additional conditions are required]. Valid values are `intact|damaged|partial_damage|refused|short_delivered`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of goods that was originally ordered and expected to be delivered. Compared against delivered_quantity to compute fill rate and identify shortages or overages for OTIF reporting.',
    `otif_flag` BOOLEAN COMMENT 'Indicates whether this delivery met the OTIF (On Time In Full) criteria — delivered on or before the scheduled date and at the full ordered quantity (True = OTIF achieved). Core KPI for supply chain performance reporting.',
    `photo_attachment_count` STRING COMMENT 'Number of photo attachments captured and associated with this POD record. Indicates the volume of photographic evidence available for dispute resolution and claims processing.',
    `photo_attachment_urls` STRING COMMENT 'Comma-separated list of URL or file path references to photo images captured at delivery (e.g., photos of damaged goods, delivery location, pallet condition). Stored in secure document repository and referenced for dispute resolution.',
    `pod_confirmation_method` STRING COMMENT 'The method used to confirm delivery receipt (e.g., signature, PIN code, photo-only, verbal confirmation, unattended drop). Supports compliance with carrier SLA requirements and DSD operational standards.. Valid values are `signature|pin_code|photo_only|verbal_confirmation|unattended`',
    `pod_number` STRING COMMENT 'Externally-known business reference number for this POD document. Used in freight audit, dispute resolution, and EDI acknowledgement exchanges with carriers and customers.. Valid values are `^POD-[A-Z0-9]{6,20}$`',
    `pod_source` STRING COMMENT 'The channel or method through which the POD was captured. Distinguishes between DSD (Direct Store Delivery) handheld devices, e-POD mobile applications, scanned paper documents, EDI transmissions, or carrier portal uploads. Critical for DSD compliance and data quality assessment.. Valid values are `dsd_handheld|epod_app|paper_scan|edi|carrier_portal`',
    `quantity_uom` STRING COMMENT 'Unit of measure for the delivered and ordered quantities (e.g., EA = Each, CS = Case, PAL = Pallet, KG = Kilogram). Ensures consistent quantity comparison across SKUs and delivery types. [ENUM-REF-CANDIDATE: EA|CS|PAL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `receipt_timestamp` TIMESTAMP COMMENT 'The exact date and time at which the consignee acknowledged receipt of the goods. This is the principal business event timestamp for the POD and is the authoritative time used for OTIF measurement and freight audit.',
    `recipient_name` STRING COMMENT 'Full name of the individual at the consignee location who physically received and signed for the goods. Required for legal proof of delivery and dispute resolution.',
    `recipient_title` STRING COMMENT 'Job title or role of the individual who received the goods (e.g., Receiving Manager, Store Associate, Warehouse Clerk). Provides context for authorization level of the signatory.',
    `scheduled_delivery_date` DATE COMMENT 'The planned delivery date as agreed in the delivery order or carrier SLA. Used to calculate on-time performance against the OTIF (On Time In Full) KPI.',
    `signature_image_url` STRING COMMENT 'URL or file path reference to the stored digital image of the recipients signature. Used as legal evidence in freight disputes and customer claims. Stored in secure document repository.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this POD record, such as status updates, discrepancy note additions, or signature capture. Supports audit trail and dispute resolution.',
    `vehicle_code` STRING COMMENT 'Identifier of the vehicle or transport unit used for the delivery (e.g., truck registration number, fleet asset ID). Used for route optimization analysis, cold-chain compliance, and carrier audit.',
    CONSTRAINT pk_proof_of_delivery PRIMARY KEY(`proof_of_delivery_id`)
) COMMENT 'Formal POD record capturing evidence of successful goods receipt at the consignee. Captures delivery reference, recipient name and signature, timestamp of receipt, condition of goods at delivery (intact/damaged), photo attachment references, electronic signature flag, discrepancy notes, and POD source (DSD handheld, e-POD app, paper scan). Critical for dispute resolution, freight audit, and DSD compliance.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`freight_order` (
    `freight_order_id` BIGINT COMMENT 'Unique surrogate identifier for the freight order record in the lakehouse silver layer. Primary key for this entity.',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier rate agreement or contract under which this freight order is priced. Null for spot-tendered orders without a pre-negotiated contract.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (trucking company, parcel carrier, or 3PL) assigned to execute this freight order. Links to the carrier master.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns internal cost center to freight orders for budgeting and chargeback of transportation expenses.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotional freight cost allocation: freight orders executed for promotional events must be directly linked to the promotion_event for trade spend reconciliation, OTIF penalty attribution, and freight',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Cross-border freight orders require jurisdiction-specific customs clearance and import/export regulatory compliance. Consumer Goods trade compliance teams use this link to validate freight orders agai',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: A freight order is issued for transportation on a specific origin-to-destination lane. The lane defines the routing guide rank, standard transit days, equipment type, and OTIF targets that govern the ',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Freight orders originate from manufacturing plants (plant-to-DC, plant-to-customer). Plant-level freight cost allocation and carrier performance reporting by facility are standard consumer goods suppl',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Freight orders in consumer goods are raised to move inventory out of a specific warehouse. The origin warehouse drives dock scheduling, inventory reservation, and freight cost allocation to warehouse ',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Freight orders are created to execute supply plans. Linking freight_order to the originating supply plan enables freight cost tracking against supply plans, S&OP execution monitoring, and freight audi',
    `network_node_id` BIGINT COMMENT 'Reference to the delivery/destination location (retailer DC, customer warehouse, store, or end-consumer address) to which the freight order is directed.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: In Consumer Goods inbound logistics, freight orders are created to move purchased materials from supplier to plant/DC against a specific PO. This link enables inbound freight cost allocation to PO, su',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Freight order creation is driven by a sales order; linking enables transport planning and order‑to‑shipment reporting.',
    `trade_account_id` BIGINT COMMENT 'Reference to the internal business unit or facility acting as the shipper/consignor for this freight order.',
    `accessorial_charges_amount` DECIMAL(18,2) COMMENT 'Total accessorial charges (e.g., liftgate, detention, residential delivery, inside delivery, hazmat handling) applied to this freight order beyond the base rate and fuel surcharge.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The actual date and time the carrier completed delivery at the destination location. Core field for OTIF (On Time In Full) measurement, carrier scorecard, and proof-of-delivery reconciliation.',
    `actual_pickup_timestamp` TIMESTAMP COMMENT 'The actual date and time the carrier picked up the freight at the origin location. Compared against the pickup window to determine on-time pickup performance for OTIF reporting.',
    `agreed_freight_rate` DECIMAL(18,2) COMMENT 'The negotiated or spot-quoted rate agreed with the carrier for executing this freight order, expressed in the transaction currency. Used for freight cost accrual, freight audit, and carrier rate benchmarking.',
    `bill_of_lading_number` STRING COMMENT 'Bill of Lading (BOL) number serving as the legal contract of carriage between the shipper and carrier. Required for freight claims, customs clearance, and proof-of-delivery documentation.',
    `carrier_invoice_number` STRING COMMENT 'Invoice number issued by the carrier for this freight order. Used for freight audit and payment matching in accounts payable. Populated upon receipt of carrier invoice.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight order record was first created in the source TMS system. Used for audit trail, data lineage, and SLA measurement from order creation to carrier acceptance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the agreed freight rate and all monetary amounts on this freight order (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_window_end` TIMESTAMP COMMENT 'End of the agreed delivery time window at the destination location. Defines the latest acceptable delivery time per retailer or customer SLA.',
    `delivery_window_start` TIMESTAMP COMMENT 'Start of the agreed delivery time window at the destination location. Defines the earliest acceptable delivery time per retailer or customer SLA.',
    `direction` STRING COMMENT 'Indicates the direction of the freight movement relative to the companys network: inbound (from supplier to plant/DC), outbound (from plant/DC to customer/retailer), or interplant (between internal facilities).. Valid values are `inbound|outbound|interplant`',
    `equipment_type` STRING COMMENT 'Type of transportation equipment required for this freight order (e.g., dry van, refrigerated/reefer, flatbed, tanker, intermodal container). Critical for cold-chain compliance for temperature-sensitive consumer goods. [ENUM-REF-CANDIDATE: dry_van|reefer|flatbed|tanker|intermodal|curtainsider|box_truck — promote to reference product]',
    `freight_audit_status` STRING COMMENT 'Status of the freight invoice audit process for this freight order. Tracks whether the carrier invoice has been received, validated against the agreed rate, approved for payment, or disputed due to discrepancies.. Valid values are `pending|approved|disputed|paid|written_off`',
    `freight_order_number` STRING COMMENT 'Externally-visible, human-readable business identifier for the freight order as issued by the Transportation Management System (TMS). Used in carrier communications, EDI transactions, and proof-of-delivery documents.. Valid values are `^FO-[0-9]{10}$`',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Fuel surcharge applied to this freight order by the carrier, expressed in the transaction currency. Fuel surcharges are typically indexed to DOE diesel fuel price indices and are a standard component of carrier invoicing.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms, including product, packaging, and pallet weight. Used for carrier rate calculation, weight-based freight billing, and regulatory compliance for road transport weight limits.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the transfer of risk, cost responsibility, and delivery obligations between buyer and seller for this freight order. Governs freight cost ownership and insurance responsibility. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_cold_chain` BOOLEAN COMMENT 'Indicates whether this freight order requires temperature-controlled cold-chain transportation (e.g., refrigerated or frozen consumer goods). Triggers reefer equipment assignment and temperature monitoring requirements.',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether this freight order contains hazardous materials (hazmat) requiring special handling, placarding, and regulatory documentation per DOT 49 CFR and IATA/IMDG regulations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight order record was last modified in the source TMS system. Used for incremental data loading, change detection, and audit trail in the lakehouse silver layer.',
    `load_type` STRING COMMENT 'Classification of the shipment load mode. FTL (Full Truckload) indicates the carriers entire trailer is dedicated to this shipment; LTL (Less-than-Truckload) indicates shared trailer space; parcel indicates small-package carrier service; intermodal indicates multi-modal container movement; rail indicates rail freight.. Valid values are `FTL|LTL|parcel|intermodal|rail`',
    `order_status` STRING COMMENT 'Current lifecycle state of the freight order. Tracks progression from tendering to carrier through acceptance, in-transit movement, and final delivery or cancellation. [ENUM-REF-CANDIDATE: tendered|accepted|rejected|in_transit|delivered|cancelled — promote to reference product]. Valid values are `tendered|accepted|rejected|in_transit|delivered|cancelled`',
    `pallet_count` STRING COMMENT 'Number of pallets included in this freight order. Used for dock scheduling, trailer space planning, and carrier rate calculation for pallet-based pricing agreements.',
    `pickup_window_end` TIMESTAMP COMMENT 'End of the agreed pickup time window at the origin location. Defines the latest time the carrier may arrive for loading without incurring a late pickup penalty.',
    `pickup_window_start` TIMESTAMP COMMENT 'Start of the agreed pickup time window at the origin location. Defines the earliest time the carrier may arrive for loading. Used for dock scheduling and carrier compliance measurement.',
    `pod_received` BOOLEAN COMMENT 'Indicates whether a signed Proof of Delivery (POD) document has been received and recorded for this freight order. Required for freight payment release, dispute resolution, and retailer compliance.',
    `pod_timestamp` TIMESTAMP COMMENT 'Date and time the Proof of Delivery (POD) was received and confirmed. Used for delivery confirmation, OTIF (On Time In Full) final measurement, and freight payment processing.',
    `pro_number` STRING COMMENT 'Carrier-assigned Progressive (PRO) number used as the primary tracking identifier for LTL (Less-than-Truckload) shipments. Issued by the carrier upon freight pickup and used for track-and-trace and freight claims.',
    `requested_delivery_date` DATE COMMENT 'The date on which the shipper requests delivery at the destination location. Core input for OTIF (On Time In Full) performance measurement and retailer compliance scoring.',
    `requested_pickup_date` DATE COMMENT 'The date on which the shipper requests the carrier to pick up the freight at the origin location. Used for OTIF (On Time In Full) measurement and carrier performance tracking.',
    `service_level` STRING COMMENT 'Contracted service level for this freight order defining the expected transit time commitment (e.g., standard ground, expedited 2-day, overnight, same-day). Drives carrier selection and freight cost.. Valid values are `standard|expedited|overnight|same_day|economy`',
    `shipment_reference_number` STRING COMMENT 'External reference number used by the carrier or 3PL to identify this shipment in their system. Enables cross-system track-and-trace and carrier invoice reconciliation via EDI (Electronic Data Interchange).',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold-chain shipments. Applicable when is_cold_chain is True. Exceedance triggers a quality hold and potential product rejection per GMP (Good Manufacturing Practice) standards.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for cold-chain shipments. Applicable when is_cold_chain is True. Used for carrier compliance verification and cold-chain excursion detection.',
    `tendering_method` STRING COMMENT 'Method used to tender the freight order to a carrier. Contract indicates a pre-negotiated rate agreement; spot indicates a one-time market rate; load_board indicates posting to a freight exchange; dedicated indicates a committed fleet arrangement; auction indicates a competitive bidding process.. Valid values are `spot|contract|load_board|dedicated|auction`',
    `tms_source_system` STRING COMMENT 'Identifies the source Transportation Management System (TMS) from which this freight order record was ingested into the lakehouse. Supports data lineage, reconciliation, and multi-system integration auditing.. Valid values are `SAP_TM|Blue_Yonder_TMS|Oracle_TMS|manual`',
    `total_freight_cost` DECIMAL(18,2) COMMENT 'Total cost of this freight order including base rate, fuel surcharge, and all accessorial charges. Used for COGS (Cost of Goods Sold) allocation, freight budget vs. actuals reporting, and carrier invoice audit.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this freight order. Drives regulatory requirements, transit time expectations, and carbon emissions calculation for sustainability reporting.. Valid values are `road|rail|ocean|air|intermodal`',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment in cubic meters. Used for LTL (Less-than-Truckload) dimensional weight calculation, trailer utilization analysis, and freight cost optimization.',
    CONSTRAINT pk_freight_order PRIMARY KEY(`freight_order_id`)
) COMMENT 'Transportation planning and tendering record issued to a carrier for a specific shipment movement. Captures freight order number, tendering method (spot/contract/load board), carrier assignment, load type (FTL/LTL/parcel), pickup and delivery locations, requested pickup window, freight order status (tendered/accepted/rejected/in-transit/delivered), agreed rate, and equipment type required. Sourced from SAP TM / Blue Yonder TMS.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`route` (
    `route_id` BIGINT COMMENT 'Unique system-generated identifier for the delivery route plan. Primary key for the route entity in the logistics domain.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or 3PL partner responsible for executing this route. Relevant for outsourced last-mile and DSD operations.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the originating depot, distribution center, or warehouse from which this route departs. Links to the facility/location master.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: DSD routes are planned and executed within sales territories in consumer goods. Territory-based route efficiency reporting, sales rep coverage alignment, and call frequency compliance all require link',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle. Business justification: A route is executed by a specific vehicle — this is a fundamental operational relationship in last-mile and DSD logistics. The route table already has a `vehicle_code` column typed as BIGINT, which is',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Route planning in consumer goods requires knowing the originating warehouse for dock scheduling, load sequencing, and inventory availability checks. A logistics planner cannot plan a DSD or replenishm',
    `actual_departure_time` TIMESTAMP COMMENT 'Actual timestamp at which the vehicle departed the depot. Compared against planned_departure_time to measure on-time departure performance and identify dispatch delays.',
    `actual_distance_km` DECIMAL(18,2) COMMENT 'Actual driving distance recorded for the route in kilometers, typically captured via telematics or GPS. Compared against planned distance for route efficiency analysis.',
    `actual_duration_min` STRING COMMENT 'Actual total route duration in minutes from depot departure to return. Used to measure route execution efficiency and identify deviations from plan.',
    `actual_return_time` TIMESTAMP COMMENT 'Actual timestamp at which the vehicle returned to the depot. Used to calculate total route duration, driver overtime, and vehicle utilization.',
    `co2_emissions_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide emissions in kilograms for this route, calculated from fuel consumption and vehicle type. Supports sustainability reporting, ESG disclosures, and ISO 14001 environmental management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was first created in the system, typically when the route plan was generated by the optimization engine or manually by a dispatcher.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the freight_cost field (e.g., USD, EUR, GBP). Supports multi-currency operations across global distribution networks.. Valid values are `^[A-Z]{3}$`',
    `freight_cost` DECIMAL(18,2) COMMENT 'Total planned or actual freight cost for this route in the operating currency. Used for transportation cost tracking, carrier invoice reconciliation, and freight audit processes.',
    `fuel_consumption_liters` DECIMAL(18,2) COMMENT 'Estimated or actual fuel consumed in liters for this route. Used for fleet cost management, carbon emissions calculation, and sustainability reporting under ISO 14001.',
    `hazmat_indicator` BOOLEAN COMMENT 'Indicates whether this route carries hazardous materials (e.g., aerosols, flammable cleaning products) requiring special handling, placarding, and regulatory compliance under DOT and EPA regulations.',
    `is_cold_chain` BOOLEAN COMMENT 'Indicates whether this route requires cold-chain compliance (temperature-controlled vehicle and handling). Critical for perishable consumer goods, dairy, frozen foods, and pharmaceutical products subject to FDA and GMP requirements.',
    `is_dsd` BOOLEAN COMMENT 'Indicates whether this route is a Direct Store Delivery (DSD) route, where the manufacturer delivers directly to retail store shelves bypassing the retailers distribution center. Drives specific execution workflows in Salesforce Consumer Goods Cloud.',
    `notes` STRING COMMENT 'Free-text operational notes or instructions for the route, such as special handling requirements, access restrictions, or dispatcher comments. Visible to drivers via mobile dispatch applications.',
    `optimization_algorithm` STRING COMMENT 'Name or identifier of the route optimization algorithm or engine used to generate this route plan (e.g., VRP-TW, Clarke-Wright, Blue Yonder Optimizer v4.2). Supports algorithm performance benchmarking and audit.',
    `optimization_run_timestamp` TIMESTAMP COMMENT 'Timestamp when the route optimization algorithm was executed to generate this route plan. Used to track plan freshness and identify routes built on stale demand data.',
    `otif_compliant` BOOLEAN COMMENT 'Indicates whether this route achieved full OTIF (On Time In Full) compliance — all stops were serviced within the agreed time windows and all ordered quantities were delivered. Key KPI for retailer scorecards.',
    `planned_departure_time` TIMESTAMP COMMENT 'Scheduled timestamp at which the vehicle is planned to depart the depot for this route. Used for driver scheduling, dock door allocation, and on-time departure KPI tracking.',
    `planned_distance_km` DECIMAL(18,2) COMMENT 'Total planned driving distance for the route in kilometers, as calculated by the route optimization algorithm. Used for fuel cost estimation, carbon footprint calculation, and driver pay.',
    `planned_duration_min` STRING COMMENT 'Total planned route duration in minutes, including drive time and estimated stop dwell times. Used for driver scheduling and OTIF planning.',
    `planned_return_time` TIMESTAMP COMMENT 'Scheduled timestamp at which the vehicle is expected to return to the depot after completing all stops. Used for driver hours-of-service compliance and dock planning.',
    `proof_of_delivery_required` BOOLEAN COMMENT 'Indicates whether electronic or physical proof of delivery (POD) must be captured at each stop on this route. Drives mobile app workflows for drivers and supports dispute resolution.',
    `route_date` DATE COMMENT 'The calendar date on which this route is planned to be executed. Used for daily route scheduling, driver dispatch, and OTIF performance tracking.',
    `route_name` STRING COMMENT 'Human-readable descriptive name for the route, typically reflecting the geographic territory or customer cluster served (e.g., Northeast Metro DSD Run).',
    `route_number` STRING COMMENT 'Externally-known business identifier for the route, used in operational communications, driver manifests, and carrier EDI exchanges. May align with SAP Transportation Management route codes.',
    `route_status` STRING COMMENT 'Current lifecycle state of the route. Tracks progression from planning through dispatch, active execution, and completion or cancellation. Supports real-time track-and-trace and operational dashboards.. Valid values are `planned|dispatched|in_progress|completed|cancelled`',
    `route_type` STRING COMMENT 'Classification of the route by operational purpose. DSD (Direct Store Delivery) routes serve retail outlets directly; mixed routes combine deliveries and pickups; cross-dock routes transfer goods between facilities. [ENUM-REF-CANDIDATE: delivery|pickup|mixed|cross_dock|dsd|milk_run — promote to reference product if additional types are needed]. Valid values are `delivery|pickup|mixed|cross_dock|dsd`',
    `service_time_window_end` TIMESTAMP COMMENT 'Latest allowable timestamp for the route to complete servicing stops. Breaching this window results in OTIF failures and potential retailer chargebacks.',
    `service_time_window_start` TIMESTAMP COMMENT 'Earliest allowable timestamp for the route to begin servicing stops, as defined by customer or retailer receiving window constraints. Used as an input constraint in the route optimization algorithm.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable cargo temperature in degrees Celsius for cold-chain routes. Breaches trigger non-conformance events and potential product quarantine per GMP and FDA requirements.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable cargo temperature in degrees Celsius for cold-chain routes. Enforced during transit to maintain product integrity and regulatory compliance.',
    `total_cases_delivered` STRING COMMENT 'Actual number of cases delivered across all stops on this route. Compared against total_cases_planned to compute fill rate and identify short-shipments.',
    `total_cases_planned` STRING COMMENT 'Total number of cases (selling units) planned for delivery across all stops on this route. Used for vehicle load planning and OTIF measurement.',
    `total_pallets_planned` STRING COMMENT 'Total number of pallets planned for loading on this route. Used for vehicle capacity utilization and dock door planning.',
    `total_stops_completed` STRING COMMENT 'Actual number of stops successfully completed during route execution. Compared against total_stops_planned to measure route completion rate and identify failed deliveries.',
    `total_stops_planned` STRING COMMENT 'Total number of delivery or pickup stops planned for this route. Used for workload balancing, route complexity scoring, and driver capacity planning.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total planned cargo volume in cubic meters for the route. Used alongside total_weight_kg to assess vehicle cube utilization and prevent overloading.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total planned payload weight in kilograms for the route. Used to verify compliance with vehicle gross vehicle weight (GVW) regulations and optimize load efficiency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this route record, such as stop additions, driver reassignments, or status updates. Supports audit trail and data lineage requirements.',
    `vehicle_capacity_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the vehicles rated payload capacity utilized by the planned load on this route. Key metric for fleet efficiency and freight cost optimization.',
    CONSTRAINT pk_route PRIMARY KEY(`route_id`)
) COMMENT 'Optimized delivery route plan for a vehicle or driver covering multiple sequential stops. Captures route ID, route date, vehicle/trailer assignment, driver reference, total planned distance and duration, planned departure time, route optimization algorithm used, route status (planned/dispatched/in-progress/completed), and ordered stop details including stop sequence, consignee reference, delivery address, planned/actual arrival and departure times, stop type (delivery/pickup/cross-dock), cases/pallets to deliver, stop status, and dwell time. Supports last-mile route optimization, DSD execution, and stop-level performance tracking.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` (
    `freight_invoice_id` BIGINT COMMENT 'Unique surrogate identifier for the freight invoice record in the Consumer Goods lakehouse silver layer. Primary key for this entity.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Freight audit and payment processing in consumer goods requires matching carrier freight invoices to AP invoices for 3-way match, payment release, and accrual reconciliation. Finance teams directly re',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier rate contract against which this invoice is audited. Used in freight audit and pay (FAP) to validate invoiced charges against contracted rates.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (transportation service provider) who issued this freight invoice. Links to the carrier master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed to allocate freight invoice expense to the appropriate cost center for internal cost tracking and budgeting.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: A freight invoice is the carriers billing document for services rendered on a specific freight order. Linking freight_invoice directly to freight_order enables freight audit workflows — comparing the',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for posting freight invoices to the general ledger; finance GL accounts are used for financial reporting of freight costs.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the shipment record associated with this freight invoice. Enables reconciliation between transportation execution and billing.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Freight invoices must be allocated to the originating manufacturing facility for plant-level freight cost accounting, cost center reconciliation, and logistics spend-by-plant management reports. freig',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Allows assignment of freight invoice expense to profit center for profitability analysis of logistics services.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to sales.invoice. Business justification: Freight cost allocation to sales invoices is required for landed cost calculation, gross margin reporting, and trade spend reconciliation. Consumer goods finance teams match carrier freight invoices t',
    `supply_replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_replenishment_order. Business justification: Freight invoices must be matched to replenishment orders for freight cost allocation and 3-way matching (replenishment order, shipment, invoice) — a standard accounts payable and supply chain finance ',
    `accessorial_amount` DECIMAL(18,2) COMMENT 'Total amount of accessorial charges on the invoice, including but not limited to liftgate, residential delivery, inside delivery, detention, redelivery, and hazmat fees. Audited against contracted accessorial schedules.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Amount approved for payment to the carrier after freight audit review and any adjustments. May differ from invoiced total if disputes or corrections were applied. This is the amount that flows to accounts payable for payment.',
    `audit_completed_timestamp` TIMESTAMP COMMENT 'Date and time the freight audit review was completed for this invoice. Marks the transition from under_audit to approved or disputed status in the freight audit and pay (FAP) workflow.',
    `bol_number` STRING COMMENT 'Bill of Lading number issued by the carrier for the associated shipment. Key cross-reference document linking the freight invoice to the physical shipment and proof of delivery.',
    `contracted_amount` DECIMAL(18,2) COMMENT 'Expected freight charge calculated from the applicable carrier contract rate for this lane, mode, and service level. Used as the benchmark in freight audit to identify billing variances.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight invoice record was first created in the Consumer Goods data platform. Supports audit trail, data lineage, and SLA tracking for invoice processing.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this freight invoice (e.g., USD, EUR, GBP). Required for multi-currency freight operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the shipment destination. Required for cross-border freight, customs compliance, and international freight cost reporting.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Code identifying the shipment destination facility (customer DC, retail store, or consumer address) to which the freight was delivered. Used for lane-level freight cost analysis.',
    `dispute_notes` STRING COMMENT 'Free-text notes describing the reason for disputing the freight invoice, including specific discrepancies identified during freight audit. Supports carrier communication and dispute resolution.',
    `dispute_reason_code` STRING COMMENT 'Standardized code indicating the reason for disputing the freight invoice (e.g., rate discrepancy, duplicate invoice, service failure, unauthorized accessorial). Populated when invoice_status is disputed. [ENUM-REF-CANDIDATE: rate_discrepancy|duplicate_invoice|service_failure|unauthorized_accessorial|weight_discrepancy|missing_bol — promote to reference product]',
    `edi_transaction_code` STRING COMMENT 'EDI (Electronic Data Interchange) transaction set identifier for invoices received electronically via EDI 210 (Motor Carrier Freight Invoice) or equivalent. Enables traceability of electronic invoice transmission.',
    `freight_class` STRING COMMENT 'National Motor Freight Classification (NMFC) freight class assigned to the shipment (e.g., 50, 70, 100, 150). Determines LTL (Less-Than-Truckload) base rates and is a key audit point for freight invoice validation.',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Carrier-applied fuel surcharge amount added to the base line-haul charge. Typically calculated as a percentage of line-haul based on the DOE (Department of Energy) fuel index. Key component for freight cost variance analysis.',
    `invoice_date` DATE COMMENT 'Date the carrier issued the freight invoice. Used to calculate payment due date, aging, and Days Sales Outstanding (DSO) metrics in freight payables.',
    `invoice_number` STRING COMMENT 'Carrier-assigned invoice number as printed on the freight invoice document. Externally known identifier used for carrier communication, dispute resolution, and payment remittance.',
    `invoice_source` STRING COMMENT 'Channel through which the freight invoice was received by Consumer Goods. Used to track EDI adoption rates and identify manual processing inefficiencies.. Valid values are `edi|carrier_portal|email|paper|api`',
    `invoice_status` STRING COMMENT 'Current workflow status of the freight invoice within the freight audit and pay (FAP) process. Drives processing actions and reporting.. Valid values are `received|under_audit|approved|disputed|paid|cancelled`',
    `invoice_type` STRING COMMENT 'Classification of the freight invoice by document type. Distinguishes standard carrier invoices from credit memos, debit memos, rebills, and adjustments for accurate financial processing.. Valid values are `standard|credit_memo|debit_memo|rebill|adjustment`',
    `invoiced_total_amount` DECIMAL(18,2) COMMENT 'Total gross amount invoiced by the carrier, inclusive of line-haul, fuel surcharge, accessorials, and taxes. This is the amount the carrier is requesting for payment before audit adjustments.',
    `is_cold_chain` BOOLEAN COMMENT 'Indicates whether this freight invoice covers a temperature-controlled (cold chain) shipment requiring refrigerated or frozen transport. Relevant for Consumer Goods products with cold-chain compliance requirements.',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether the shipment covered by this invoice contains hazardous materials requiring special handling, labeling, and regulatory compliance. Triggers validation of hazmat accessorial charges.',
    `line_haul_amount` DECIMAL(18,2) COMMENT 'Base transportation charge for moving freight from origin to destination, excluding surcharges and accessorials. Core component of the freight invoice monetary triplet.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the shipment origin. Required for cross-border freight, customs compliance, and international freight cost reporting.. Valid values are `^[A-Z]{3}$`',
    `origin_location_code` STRING COMMENT 'Code identifying the shipment origin facility (plant, warehouse, or distribution center) from which the freight movement originated. Used for lane-level freight cost analysis and carrier performance reporting.',
    `paid_date` DATE COMMENT 'Date the payment was issued to the carrier for this freight invoice. Used to calculate Days Sales Outstanding (DSO), confirm on-time payment, and support carrier relationship management.',
    `payment_due_date` DATE COMMENT 'Date by which payment must be made to the carrier per the contracted payment terms. Critical for cash flow management and avoiding late payment penalties.',
    `payment_reference` STRING COMMENT 'Internal payment document or check/ACH reference number assigned when the invoice was paid. Used to reconcile freight invoices against bank statements and carrier remittance advice.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the carrier (e.g., Net30, Net45, 2/10Net30). Determines the payment due date and any early payment discount eligibility.',
    `pro_number` STRING COMMENT 'Carrier-assigned Progressive (PRO) number used to track the shipment within the carriers system. Standard identifier in LTL and TL freight for track-and-trace and invoice matching.',
    `purchase_order_number` STRING COMMENT 'Consumer Goods internal purchase order number associated with the freight services procured. Used for three-way match in accounts payable and freight audit.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time the freight invoice was received by Consumer Goods from the carrier, either via EDI (Electronic Data Interchange), email, or carrier portal. Marks the start of the freight audit and pay (FAP) cycle.',
    `service_date` DATE COMMENT 'Date the transportation service was rendered (pickup or delivery date). Used to match the invoice to the correct accounting period and validate service delivery.',
    `service_level` STRING COMMENT 'Carrier service level or product code for the transportation service rendered (e.g., standard ground, expedited, next-day, two-day). Used to validate that the invoiced service matches the contracted service level agreement (SLA).',
    `shipment_weight_kg` DECIMAL(18,2) COMMENT 'Actual or billed shipment weight in kilograms as stated on the freight invoice. Used to validate weight-based freight charges against contracted rates and detect weight discrepancies.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the freight invoice, including applicable federal, state, and local taxes on transportation services. Required for accurate financial reporting and tax compliance.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the shipment covered by this invoice. [ENUM-REF-CANDIDATE: TL|LTL|parcel|intermodal|air|ocean|rail — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight invoice record was last modified in the Consumer Goods data platform. Used for change tracking, incremental data loads, and audit compliance.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary difference between the invoiced total amount and the contracted rate amount (invoiced_total_amount minus contracted_amount). Positive value indicates overbilling by carrier; negative indicates underbilling. Central metric in the freight audit and pay (FAP) process.',
    CONSTRAINT pk_freight_invoice PRIMARY KEY(`freight_invoice_id`)
) COMMENT 'Carrier-issued freight invoice submitted to Consumer Goods for transportation services rendered. Captures invoice number, carrier reference, invoice date, payment due date, shipment/BOL references, invoiced charges (line-haul, fuel surcharge, accessorials), currency, invoice status (received/under-audit/approved/disputed/paid), and variance amount vs. contracted rate. Central to freight audit and pay (FAP) process.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` (
    `tracking_event_id` BIGINT COMMENT 'Unique surrogate identifier for each shipment tracking event record in the silver layer lakehouse. Primary key for the tracking_event data product.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (trucking company, parcel carrier, ocean liner, air freight provider) that generated or reported this tracking event.',
    `lane_id` BIGINT COMMENT 'Reference to the transportation lane on which this tracking event occurred, enabling lane-level performance and exception analysis.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the parent shipment record to which this tracking event belongs. Links the event to the full shipment context including origin, destination, carrier, and BOL details.',
    `supply_replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_replenishment_order. Business justification: Tracking events on in-transit replenishment shipments update supply visibility — ETA updates, exception alerts, and in-transit inventory positions. Supply planners monitor replenishment order status v',
    `carrier_event_code` STRING COMMENT 'The carriers native status or event code as transmitted via EDI 214/990 or carrier API (e.g., X1, D1, AF, OFD). Preserves the source system code for carrier-specific reporting and reconciliation against carrier invoices and SLA commitments.',
    `carrier_sla_met` BOOLEAN COMMENT 'Indicates whether the carrier met the contracted Service Level Agreement (SLA) milestone at this event (e.g., on-time pickup, on-time delivery). Derived from comparison of event_timestamp against planned_event_timestamp and carrier contract terms. Feeds carrier performance scorecards and SLA penalty/incentive calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tracking event record was first ingested and created in the silver layer lakehouse. Distinct from event_timestamp (when the event occurred in the real world). Used for data latency monitoring and SLA measurement of carrier EDI/API feed timeliness.',
    `customs_status` STRING COMMENT 'The customs clearance status of the shipment at the time of this tracking event, applicable to cross-border shipments. Indicates whether the shipment has cleared customs, is held for inspection, pending documentation, released after hold, or seized. Critical for international supply chain visibility and compliance.. Valid values are `cleared|held|pending|released|seized`',
    `data_source` STRING COMMENT 'The originating system or channel that generated this tracking event. Distinguishes between carrier EDI transmissions (214/990), GPS telematics feeds, IoT sensor readings, carrier API webhooks, WMS scan events, and manual entries. Critical for data lineage and source reliability scoring. [ENUM-REF-CANDIDATE: edi_214|edi_990|gps_telematics|iot_sensor|carrier_api|manual_entry|wms_scan — promote to reference product]',
    `dwell_time_minutes` STRING COMMENT 'The number of minutes the shipment or vehicle dwelled at the event location (e.g., carrier terminal, cross-dock, customer dock) before the next movement event. Supports carrier performance analysis, dock scheduling optimization, and detention charge identification.',
    `edi_interchange_control_number` STRING COMMENT 'The unique interchange control number from the EDI envelope (ISA segment) of the source EDI transmission that generated this tracking event. Enables end-to-end EDI message traceability and duplicate detection.',
    `edi_transaction_set` STRING COMMENT 'The ANSI X12 EDI transaction set number associated with the source message that generated this tracking event (e.g., 214 = Transportation Carrier Shipment Status, 990 = Response to a Load Tender). Supports EDI audit trail and carrier integration troubleshooting.. Valid values are `214|990|204|210|997`',
    `equipment_code` STRING COMMENT 'The identifier of the transportation equipment (trailer number, container number, railcar number, vessel IMO number) associated with this tracking event. Enables equipment-level tracking, utilization analysis, and cross-referencing with carrier equipment records.',
    `event_city` STRING COMMENT 'The city where the tracking event occurred, as reported by the carrier or GPS system. Used for geographic visualization of shipment progress and lane-level exception analysis.',
    `event_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country where the tracking event occurred (e.g., USA, CAN, MEX). Required for cross-border shipment tracking and customs compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `event_state_province` STRING COMMENT 'The state or province where the tracking event occurred, using standard postal abbreviations (e.g., CA, TX, ON). Supports regional performance reporting and regulatory compliance tracking.',
    `event_status` STRING COMMENT 'Lifecycle status of this tracking event record indicating whether it is the current authoritative event (active), has been superseded by a correction, cancelled, or identified as a duplicate. Supports data quality management in the silver layer.. Valid values are `active|superseded|cancelled|duplicate`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time (in ISO 8601 format with timezone offset) at which the tracking event occurred in the real world, as reported by the carrier, GPS telematics system, or IoT sensor. This is the principal business event time, distinct from record ingestion timestamps.',
    `event_type` STRING COMMENT 'Standardized classification of the shipment tracking event representing the current milestone or status change in the shipment lifecycle. Drives track-and-trace visibility and exception management workflows. [ENUM-REF-CANDIDATE: picked_up|in_transit|out_for_delivery|delivered|exception|delay|damage|refused — promote to reference product]',
    `exception_description` STRING COMMENT 'Free-text narrative description of the exception condition, providing additional context beyond the root cause code. May include carrier notes, driver comments, or system-generated messages explaining the nature of the delay, damage, or refusal.',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator that this tracking event represents or triggered a shipment exception condition (e.g., delay, damage, refused delivery, missed pickup, temperature breach). Drives exception management workflows and carrier performance scorecards.',
    `exception_root_cause_code` STRING COMMENT 'Standardized root cause code categorizing the reason for a shipment exception (e.g., WEATHER, CARRIER_DELAY, CUSTOMS_HOLD, MECHANICAL_FAILURE, INCORRECT_ADDRESS, REFUSED_BY_CONSIGNEE, DAMAGED_IN_TRANSIT). Used for exception trend analysis and carrier performance management. [ENUM-REF-CANDIDATE: WEATHER|CARRIER_DELAY|CUSTOMS_HOLD|MECHANICAL_FAILURE|INCORRECT_ADDRESS|REFUSED_BY_CONSIGNEE|DAMAGED_IN_TRANSIT — promote to reference product]',
    `facility_code` STRING COMMENT 'The code identifying the carrier terminal, cross-dock, distribution center, port, or customer facility where the tracking event occurred (e.g., carrier hub code, GLN). Supports facility-level dwell time and throughput analysis.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of the financial impact associated with this tracking event exception (e.g., cost of delay, damage claim value, re-delivery cost, expedite surcharge). Used for freight cost variance analysis and carrier chargeback management. Expressed in the currency defined by financial_impact_currency.',
    `financial_impact_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the financial impact amount (e.g., USD, EUR, GBP). Required for multi-currency operations across global consumer goods distribution networks.. Valid values are `^[A-Z]{3}$`',
    `geofence_zone` STRING COMMENT 'The named geofence zone or virtual boundary that triggered this tracking event (e.g., CUSTOMER_DC_INBOUND, CARRIER_TERMINAL_CHICAGO, PORT_OF_LA_GATE). Populated for GPS telematics events generated by geofence entry/exit triggers. Supports automated milestone detection without manual carrier check-ins.',
    `humidity_pct` DECIMAL(18,2) COMMENT 'Relative humidity percentage reading captured at the time of the tracking event by an IoT sensor. Relevant for moisture-sensitive consumer goods (e.g., hygiene products, paper-based packaging). Null for shipments without humidity monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees, WGS84 datum) of the location where the tracking event was recorded by GPS telematics or IoT sensor. Enables precise geospatial mapping of shipment progress and route deviation detection.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees, WGS84 datum) of the location where the tracking event was recorded by GPS telematics or IoT sensor. Paired with latitude for precise geospatial analysis.',
    `planned_event_timestamp` TIMESTAMP COMMENT 'The originally scheduled or planned date and time for this event milestone (e.g., planned pickup time, planned delivery window). Compared against event_timestamp to calculate schedule adherence and On-Time In-Full (OTIF) performance at the event level.',
    `pod_method` STRING COMMENT 'The method by which Proof of Delivery (POD) was captured for a delivered event (electronic signature, paper signature, photo confirmation, or no-signature-required). Supports POD compliance tracking and carrier contract enforcement.. Valid values are `electronic|paper|photo|no_signature_required`',
    `pod_signature_name` STRING COMMENT 'The name of the individual who signed for the delivery at the consignee location, as captured on the Proof of Delivery (POD) document. Populated only for delivered event types. Supports dispute resolution and delivery confirmation.',
    `pro_number` STRING COMMENT 'The carrier-assigned Progressive (PRO) number used to identify and track a freight shipment within the carriers system. Serves as the primary external reference for LTL and TL carrier tracking and freight audit reconciliation.',
    `resolution_action_code` STRING COMMENT 'Standardized code identifying the corrective action taken to resolve the exception associated with this tracking event (e.g., REROUTED, REDELIVERY_SCHEDULED, CLAIM_FILED, PRODUCT_QUARANTINED, CARRIER_NOTIFIED, EXPEDITED). Supports exception resolution tracking and SLA compliance measurement. [ENUM-REF-CANDIDATE: REROUTED|REDELIVERY_SCHEDULED|CLAIM_FILED|PRODUCT_QUARANTINED|CARRIER_NOTIFIED|EXPEDITED — promote to reference product]',
    `resolution_timestamp` TIMESTAMP COMMENT 'The date and time at which the exception associated with this tracking event was resolved or closed. Used to calculate exception resolution cycle time and measure carrier SLA compliance for exception handling.',
    `shipment_leg_number` STRING COMMENT 'Sequential leg number within a multi-leg shipment (e.g., leg 1 = origin DC to cross-dock, leg 2 = cross-dock to destination). Enables granular tracking of multi-modal or relay shipments across the inbound and outbound network.',
    `speed_kmh` DECIMAL(18,2) COMMENT 'The speed of the transport vehicle in kilometers per hour at the time of the GPS telematics event. Used for route compliance monitoring, driver safety analytics, and detection of unauthorized stops or route deviations. Null for non-GPS-sourced events.',
    `temperature_breach` BOOLEAN COMMENT 'Indicates whether the temperature reading at this event exceeded the shipments defined cold-chain temperature range (temperature_min_c to temperature_max_c as defined on the parent shipment). True signals a cold-chain compliance violation requiring exception management and potential product quarantine.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient or product temperature reading in degrees Celsius captured at the time of the tracking event by an IoT sensor or cold-chain monitoring device. Critical for cold-chain compliance monitoring of temperature-sensitive consumer goods (e.g., personal care, food, pharmaceutical products). Null for non-cold-chain shipments.',
    `tracking_number` STRING COMMENT 'The carrier-issued parcel or shipment tracking number (e.g., UPS, FedEx, USPS tracking number) used for consumer-facing and operational track-and-trace. Distinct from PRO number which is used for freight/LTL.',
    `transport_mode` STRING COMMENT 'The mode of transportation active at the time of this tracking event. Relevant for multi-modal shipments where the mode may change between legs (e.g., ocean to rail to truckload). Drives mode-specific SLA and performance benchmarking. [ENUM-REF-CANDIDATE: truckload|ltl|parcel|rail|ocean|air|intermodal — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this tracking event record was last modified in the silver layer lakehouse (e.g., due to a carrier correction, status update, or exception resolution). Supports data lineage, audit trail, and change detection for downstream consumers.',
    CONSTRAINT pk_tracking_event PRIMARY KEY(`tracking_event_id`)
) COMMENT 'Real-time or near-real-time shipment tracking event captured from carrier EDI (214/990), GPS telematics, or IoT sensors. Captures event timestamp, shipment/leg reference, event type (picked-up, in-transit, out-for-delivery, delivered, exception, delay, damage, refused), location (city/state/GPS coordinates), carrier event code, temperature reading (cold-chain), exception root cause code, financial impact estimate, resolution action and timestamp, and data source. Powers track-and-trace visibility, cold-chain compliance monitoring, exception management, and carrier performance measurement.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` (
    `freight_rate_id` BIGINT COMMENT 'Unique system-generated identifier for a freight rate record. Primary key for the freight_rate data product.',
    `carrier_contract_id` BIGINT COMMENT 'Reference to the carrier contract under which this freight rate is established. Links rate to the governing contractual agreement.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier associated with this freight rate. Links to the carrier master for contract and service details.',
    `lane_id` BIGINT COMMENT 'Reference to the transportation lane (origin-destination pair) to which this freight rate applies.',
    `accessorial_schedule_code` STRING COMMENT 'Reference code identifying the accessorial charge schedule applicable to this freight rate. Accessorials include liftgate, inside delivery, residential delivery, detention, and other ancillary charges defined in the carrier tariff.',
    `base_rate` DECIMAL(18,2) COMMENT 'The core freight rate amount per unit as defined by the rate_type (e.g., cost per mile, cost per CWT, cost per pallet, or flat amount). This is the primary rate value used in freight cost estimation before surcharges and accessorials are applied.',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this freight rate applies to cold-chain (temperature-controlled) shipments. Critical for consumer goods categories such as perishable food, beverages, and pharmaceutical products requiring refrigerated transport.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight rate record was first created in the system. Used for audit trail, data lineage, and rate history tracking.',
    `cross_border` BOOLEAN COMMENT 'Indicates whether this freight rate applies to cross-border (international) shipments. Cross-border rates include additional cost components for customs, duties, and border crossing fees not present in domestic rates.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the freight rate is denominated (e.g., USD, EUR, GBP). Required for multi-currency freight cost management and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the destination of the freight lane. Required for cross-border rate determination and import/export compliance.. Valid values are `^[A-Z]{3}$`',
    `destination_postal_code_from` STRING COMMENT 'Starting postal code of the destination zone range for this freight rate. Used for zone-based rate determination when the rate applies to a range of destination postal codes.',
    `destination_postal_code_to` STRING COMMENT 'Ending postal code of the destination zone range for this freight rate. Together with destination_postal_code_from, defines the geographic destination band to which this rate applies.',
    `destination_zone_code` STRING COMMENT 'Carrier-defined zone code for the destination geography. Used in conjunction with origin_zone_code for zone-pair rate determination in carrier tariff structures.',
    `distance_km` DECIMAL(18,2) COMMENT 'Standard distance in kilometers for the origin-to-destination lane associated with this rate. Used in per-mile/per-km rate calculations and freight cost benchmarking.',
    `effective_date` DATE COMMENT 'Date from which this freight rate becomes valid and applicable for shipment cost estimation. Rates with effective_date in the future are pre-loaded for upcoming contract periods.',
    `equipment_type` STRING COMMENT 'Type of transportation equipment required for this rate. Reefer (refrigerated) equipment is critical for cold-chain compliance in consumer goods. Drives rate differentiation and carrier selection.. Valid values are `dry_van|reefer|flatbed|tanker|container|intermodal`',
    `expiry_date` DATE COMMENT 'Date after which this freight rate is no longer valid. Null indicates an open-ended rate with no defined expiration. Used to enforce rate validity windows in freight cost estimation and carrier contract management.',
    `fuel_surcharge_basis` STRING COMMENT 'Method by which the fuel surcharge is calculated and applied: as a percentage of the base rate, a flat amount per mile, or a flat amount per shipment. Determines how fuel_surcharge_rate is interpreted in cost computation.. Valid values are `percentage|flat_per_mile|flat_per_shipment`',
    `fuel_surcharge_rate` DECIMAL(18,2) COMMENT 'Fuel surcharge rate expressed as a percentage or fixed amount applied on top of the base freight rate. Reflects carrier fuel cost pass-through and is typically indexed to a published fuel price index (e.g., DOE weekly diesel).',
    `hazmat_applicable` BOOLEAN COMMENT 'Indicates whether this freight rate applies to hazardous materials (hazmat) shipments. Consumer goods with hazmat classification (e.g., aerosols, flammable products) require specialized rates and carrier certifications per DOT and EPA regulations.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the allocation of freight costs, risks, and responsibilities between shipper and consignee under this rate. Governs which party bears the freight cost represented by this rate. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `max_charge` DECIMAL(18,2) COMMENT 'Maximum charge amount that applies as a cap for this rate, regardless of shipment weight or distance. Null indicates no cap. Used in negotiated contract rates to protect shippers from excessive charges on large shipments.',
    `min_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount that applies regardless of shipment weight or distance. Ensures the carrier recovers a floor cost for any shipment under this rate. Used in freight cost estimation to enforce rate floor.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the origin of the freight lane. Required for cross-border rate determination and customs/regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `origin_postal_code_from` STRING COMMENT 'Starting postal code of the origin zone range for this freight rate. Used for zone-based rate determination when the rate applies to a range of origin postal codes rather than a single location.',
    `origin_postal_code_to` STRING COMMENT 'Ending postal code of the origin zone range for this freight rate. Together with origin_postal_code_from, defines the geographic origin band to which this rate applies.',
    `origin_zone_code` STRING COMMENT 'Carrier-defined zone code for the origin geography. Zone codes are used in carrier tariff structures to group postal codes into pricing zones for simplified rate lookup.',
    `rate_basis_uom` STRING COMMENT 'Unit of measure that defines the denominator for the base_rate. Specifies what one unit of the rate_type represents (e.g., KG for per-kilogram rates, CWT for hundredweight, PALLET for per-pallet rates). Essential for correct freight cost computation. [ENUM-REF-CANDIDATE: KG|CWT|PALLET|MILE|KM|UNIT|SHIPMENT|CONTAINER — 8 candidates stripped; promote to reference product]',
    `rate_number` STRING COMMENT 'Externally-known business identifier for this freight rate record, used in carrier communications, freight audit, and cost estimation workflows. Typically sourced from the carrier tariff or contract schedule.',
    `rate_source` STRING COMMENT 'Origin of the freight rate — whether derived from a negotiated carrier contract, spot market quote, published tariff, or benchmark rate. Used to distinguish contracted rates from market rates in freight cost analysis.. Valid values are `contract|spot_market|tariff|benchmark|spot_quote`',
    `rate_status` STRING COMMENT 'Current lifecycle status of the freight rate record. Indicates whether the rate is currently applicable for freight cost estimation and shipment planning.. Valid values are `active|pending|expired|suspended|cancelled`',
    `rate_type` STRING COMMENT 'Classification of how the freight rate is calculated and applied. Determines the unit basis for cost computation: per-mile (distance-based), per-CWT (hundredweight), per-pallet (handling unit), per-kg (weight-based), flat (fixed regardless of volume), or per-unit. [ENUM-REF-CANDIDATE: per_mile|per_cwt|per_pallet|per_kg|flat|per_unit|per_container|per_shipment — promote to reference product]. Valid values are `per_mile|per_cwt|per_pallet|per_kg|flat|per_unit`',
    `service_level` STRING COMMENT 'Carrier service level associated with this freight rate, defining the speed and priority of delivery. Impacts rate amount and transit time commitments.. Valid values are `standard|expedited|overnight|economy|same_day`',
    `spot_quote_reference` STRING COMMENT 'Reference number for the spot market quote when rate_source is spot_market or spot_quote. Enables traceability back to the original carrier quote for audit and freight cost reconciliation purposes.',
    `tariff_name` STRING COMMENT 'Name or identifier of the carriers published tariff schedule from which this rate is derived. Used when rate_source is tariff to reference the specific tariff document governing the rate.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold-chain shipments under this rate. Applicable when cold_chain_required is true. Defines the upper bound of the acceptable temperature range for product integrity.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum required temperature in degrees Celsius for cold-chain shipments under this rate. Applicable when cold_chain_required is true. Used for reefer equipment specification and cold-chain compliance monitoring.',
    `transit_days` STRING COMMENT 'Standard number of business days for transit from origin to destination under this rate and service level. Used in delivery date estimation, OTIF (On Time In Full) planning, and S&OP (Sales and Operations Planning).',
    `transport_mode` STRING COMMENT 'Mode of transportation to which this freight rate applies. TL = Truckload, LTL = Less-than-Truckload. Determines applicable rate structure and carrier service type. [ENUM-REF-CANDIDATE: TL|LTL|parcel|rail|ocean|air|intermodal — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight rate record was last modified. Used for change tracking, audit compliance, and incremental data pipeline processing in the Databricks Silver Layer.',
    `weight_break_max_kg` DECIMAL(18,2) COMMENT 'Maximum shipment weight in kilograms for this rate to apply. Defines the upper bound of the weight break tier. Null indicates no upper limit (applies to all weights above the minimum).',
    `weight_break_min_kg` DECIMAL(18,2) COMMENT 'Minimum shipment weight in kilograms for this rate to apply. Defines the lower bound of the weight break tier. Used in LTL and CWT-based rate structures to determine applicable rate.',
    CONSTRAINT pk_freight_rate PRIMARY KEY(`freight_rate_id`)
) COMMENT 'Granular freight rate record defining the cost per unit of transport for a specific lane, carrier, mode, and shipment characteristic. Captures rate type (per-mile, per-cwt, per-pallet, flat), origin/destination zone or postal code range, weight break, effective and expiry dates, base rate, fuel surcharge rate, accessorial rate schedule reference, and currency. Sourced from carrier contracts and spot market quotes for freight cost estimation.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`logistics`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'Primary key for vehicle',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: A vehicle is owned or operated by a carrier — this is a foundational master data relationship in transportation management. Linking vehicle to carrier enables carrier fleet visibility, compliance trac',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Owned fleet vehicles are capitalized as fixed assets in consumer goods. Linking vehicle to fixed_asset enables depreciation tracking, net book value reporting, capex vs. opex analysis, and asset dispo',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: In consumer goods DSD (Direct Store Delivery) operations, delivery vehicles carry brand livery and are assigned to specific brands. Brand managers track branded fleet assets for marketing compliance, ',
    `towing_vehicle_id` BIGINT COMMENT 'Self-referencing FK on vehicle (towing_vehicle_id)',
    `acquisition_date` DATE COMMENT 'Date the vehicle was purchased or otherwise acquired.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle record was first created in the data lake.',
    `current_fuel_level_liters` DECIMAL(18,2) COMMENT 'Fuel volume currently in the tank, measured during last reading.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the vehicles value over time.',
    `depreciation_value` DECIMAL(18,2) COMMENT 'Total depreciation amount recorded to date.',
    `emissions_standard` STRING COMMENT 'Regulatory emissions compliance level applicable to the vehicle.',
    `fuel_capacity_liters` DECIMAL(18,2) COMMENT 'Maximum volume of fuel the vehicles tank can hold.',
    `fuel_type` STRING COMMENT 'Primary energy source used by the vehicle.',
    `gps_device_code` STRING COMMENT 'Unique identifier of the GPS tracking unit installed on the vehicle.',
    `gps_last_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent location report from the GPS device.',
    `insurance_expiry_date` DATE COMMENT 'Date on which the current insurance coverage ends.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the active insurance policy covering the vehicle.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the vehicle record is currently active in the system.',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which scheduled maintenance was performed.',
    `lease_end_date` DATE COMMENT 'Date when the lease term expires and the vehicle must be returned.',
    `lease_flag` BOOLEAN COMMENT 'True if the vehicle is obtained under a lease agreement.',
    `license_plate` STRING COMMENT 'Alphanumeric plate identifier displayed on the vehicle.',
    `next_service_date` DATE COMMENT 'Planned date for the next preventive maintenance activity.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks, exceptions, or operational comments.',
    `odometer_reading_km` BIGINT COMMENT 'Cumulative distance traveled by the vehicle, recorded by the odometer.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the vehicle within logistics operations.',
    `owner_company` STRING COMMENT 'Legal entity that owns the vehicle (useful for multi‑entity groups).',
    `payload_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight the vehicle can safely carry.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Original acquisition cost of the vehicle.',
    `refrigerated_flag` BOOLEAN COMMENT 'Indicates whether the vehicle is equipped for temperature‑controlled transport.',
    `registration_number` STRING COMMENT 'Official registration number issued by the transport authority.',
    `retirement_date` DATE COMMENT 'Date the vehicle was removed from active service or disposed of.',
    `service_interval_km` STRING COMMENT 'Mileage interval after which the vehicle must undergo service.',
    `temperature_range_c` STRING COMMENT 'Allowed temperature range for refrigerated cargo, expressed as "min‑max".',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vehicle record.',
    `vehicle_name` STRING COMMENT 'Human‑readable name or label assigned to the vehicle for easy reference.',
    `vehicle_type` STRING COMMENT 'Category of the vehicle based on body style and purpose.',
    `vin` STRING COMMENT 'Globally unique 17‑character identifier assigned by the manufacturer.',
    CONSTRAINT pk_vehicle PRIMARY KEY(`vehicle_id`)
) COMMENT 'Master reference table for vehicle. Referenced by vehicle_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_lane_preferred_carrier_id` FOREIGN KEY (`lane_preferred_carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_freight_rate_id` FOREIGN KEY (`freight_rate_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`freight_rate`(`freight_rate_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_route_id` FOREIGN KEY (`route_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`route`(`route_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`delivery`(`delivery_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_route_id` FOREIGN KEY (`route_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`route`(`route_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_carrier_contract_id` FOREIGN KEY (`carrier_contract_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier_contract`(`carrier_contract_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_towing_vehicle_id` FOREIGN KEY (`towing_vehicle_id`) REFERENCES `consumer_goods_ecm`.`logistics`.`vehicle`(`vehicle_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `consumer_goods_ecm`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `api_tracking_capable` SET TAGS ('dbx_business_glossary_term' = 'API Tracking Capable Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blacklisted');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `cold_chain_capable` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Capable Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract End Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Start Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_business_glossary_term' = 'Country of Registration');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet (DUNS) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `edi_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `edi_code` SET TAGS ('dbx_business_glossary_term' = 'EDI Interchange ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `edi_qualifier` SET TAGS ('dbx_business_glossary_term' = 'EDI Interchange Qualifier');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `edi_qualifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `fmcsa_rating_date` SET TAGS ('dbx_business_glossary_term' = 'FMCSA Safety Rating Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `fmcsa_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Federal Motor Carrier Safety Administration (FMCSA) Safety Rating');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `fmcsa_safety_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|conditional|unsatisfactory|not_rated');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Carrier Geographic Coverage');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `hazmat_cert_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'HAZMAT Certification Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Carrier Headquarters Address');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Carrier Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_cargo_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier Cargo Insurance Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_cargo_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Insurance Certificate Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Insurance Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier Liability Insurance Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_liability_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Legal Name');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `max_payload_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Payload Capacity (Kilograms)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_business_glossary_term' = 'Motor Carrier (MC) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_value_regex' = '^MC-[0-9]{1,7}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Onboarding Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payment Terms');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|immediate');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `preferred_carrier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Carrier Primary Contact Email');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Primary Contact Name');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Carrier Primary Contact Phone');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `service_area_countries` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Area Countries');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Mode');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `service_mode` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|same_day|deferred|white_glove');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tax Identification Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Range (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Range (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking URL Template');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Trade Name (DBA)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `accessorial_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Schedule Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Contract Approved By');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `auto_renewal` SET TAGS ('dbx_business_glossary_term' = 'Contract Auto-Renewal Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Base Rate');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `base_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Freight Billing Frequency');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'per_shipment|weekly|bi_weekly|monthly');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliance Required');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'spot|committed|preferred|dedicated|intermodal|3pl_master');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Contract Destination Region / Zone');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `detention_free_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Detention Free Time (Hours)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `edi_capable` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_basis` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Basis');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_basis` SET TAGS ('dbx_value_regex' = 'percentage_of_base|flat_per_mile|flat_per_shipment|doe_index_linked');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Rate');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Certified');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier Insurance Coverage Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `liability_limit_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Carrier Liability Limit per Kilogram');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `liability_limit_per_kg` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Break (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `min_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Weight Break (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Contract Origin Region / Zone');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `otif_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Penalty Rate');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `otif_penalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `otif_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Threshold Percentage');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Payment Terms');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|immediate|2_10_net_30');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `pickup_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Pickup Lead Time (Hours)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Notice Period (Days)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Freight Service Level');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|two_day|deferred|white_glove');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Requirement (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Requirement (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `track_trace_method` SET TAGS ('dbx_business_glossary_term' = 'Track and Trace Method');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `track_trace_method` SET TAGS ('dbx_value_regex' = 'edi_214|api|portal|email|none');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Contracted Transit Time (Days)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transport');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_units` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Units');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_units` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`carrier_contract` ALTER COLUMN `volume_commitment_uom` SET TAGS ('dbx_value_regex' = 'shipments|pallets|cwt|revenue_miles|kg|loads');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `lane_preferred_carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `lane_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `annual_volume_loads` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume (Loads)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `annual_volume_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Weight (Kilograms)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `benchmark_rate_flat` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Flat Lane Rate');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `benchmark_rate_flat` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `benchmark_rate_per_km` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Freight Rate per Kilometer');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `benchmark_rate_per_km` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `carbon_emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Factor (kg CO2e per km)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Lane Classification');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'inbound|outbound|inter_facility|last_mile|reverse');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Lane Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `customs_trade_zone` SET TAGS ('dbx_business_glossary_term' = 'Customs Trade Zone');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Lane Distance (Kilometers)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `dsd_eligible` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Lane Effective Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lane Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `hazmat_required` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Handling Required Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `lane_code` SET TAGS ('dbx_business_glossary_term' = 'Lane Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `lane_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `lane_name` SET TAGS ('dbx_business_glossary_term' = 'Lane Name');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `lane_status` SET TAGS ('dbx_business_glossary_term' = 'Lane Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `lane_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `network_region` SET TAGS ('dbx_business_glossary_term' = 'Network Region');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `origin_city` SET TAGS ('dbx_business_glossary_term' = 'Origin City');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `origin_state_province` SET TAGS ('dbx_business_glossary_term' = 'Origin State or Province Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `origin_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `routing_guide_rank` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Rank');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|economy|dedicated|spot');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_TM|BLUE_YONDER|ORACLE_TMS|MANUAL');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `standard_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Transit Days');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Requirement (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Requirement (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`lane` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `primary_logistics_distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `bol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Ocean Container Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Shipment Direction');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|interplant|return');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Shipment Exception Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `otif_in_full` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) - In Full Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `otif_on_time` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) - On Time Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `planned_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Ship Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `pod_received` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Received Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `pod_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,25}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|same_day|economy');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Required Temperature (°C)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Temperature (°C)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `three_pl_reference` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Reference Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `three_pl_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,40}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `total_cases` SET TAGS ('dbx_business_glossary_term' = 'Total Case Count');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `total_pallets` SET TAGS ('dbx_business_glossary_term' = 'Total Pallet Count');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Volume (m³)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Weight (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,35}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transport');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'TL|LTL|parcel|ocean|air|rail');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`logistics_shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `shipment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Warehouse ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `event_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `pack_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Hierarchy Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `supply_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivered Quantity');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `delivery_document_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `is_dsd` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (Hazmat) Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `is_temperature_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Temperature Sensitive Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Description');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Item Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `line_value` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Value');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `line_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (°C)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (°C)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'each|inner_pack|case|display|pallet|bulk');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Item Rejection Reason');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `sales_order_line` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Product Serial Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`shipment_item` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `supply_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Account ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `actual_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Recorded Temperature (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `carrier_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `consignee_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'full|partial|failed|refused|pending');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `delivery_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `delivery_type` SET TAGS ('dbx_value_regex' = 'DSD|warehouse|cross_dock|drop_ship|returns');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `electronic_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Exception Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Exception Notes');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `first_attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Delivery Attempt Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `goods_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Goods Condition Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `goods_condition_code` SET TAGS ('dbx_value_regex' = 'good|damaged|partial_damage|temperature_breach|contaminated');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Delivery Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `otif_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `photo_attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment Reference');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `pod_source` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Source');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `pod_source` SET TAGS ('dbx_value_regex' = 'DSD_handheld|epod_app|paper_scan|EDI|manual');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `refused_quantity` SET TAGS ('dbx_business_glossary_term' = 'Refused Quantity');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Signature Reference');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `signature_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^d{18}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Required Temperature (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Temperature (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `carrier_scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Carrier Scan Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `cold_chain_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `customer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Reference Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_location_gln` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Global Location Number (GLN)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_location_gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_location_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Name');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|delivered|partially_delivered|failed|disputed|cancelled');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `delivery_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Delivery Temperature (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Discrepancy Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Discrepancy Notes');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Discrepancy Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'quantity_shortage|overage|damaged_goods|wrong_item|temperature_breach|missing_documentation');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'no_dispute|open|under_review|resolved|escalated');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `dsd_route_stop_sequence` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Route Stop Sequence');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `electronic_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `freight_bill_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Bill Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `geofence_validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Geofence Validation Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Geolocation Latitude');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Geolocation Longitude');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `goods_condition` SET TAGS ('dbx_business_glossary_term' = 'Goods Condition at Delivery');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `goods_condition` SET TAGS ('dbx_value_regex' = 'intact|damaged|partial_damage|refused|short_delivered');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `otif_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `photo_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment Count');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `photo_attachment_urls` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment URLs');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'POD Confirmation Method');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_confirmation_method` SET TAGS ('dbx_value_regex' = 'signature|pin_code|photo_only|verbal_confirmation|unattended');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_number` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_number` SET TAGS ('dbx_value_regex' = '^POD-[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_source` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Source');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `pod_source` SET TAGS ('dbx_value_regex' = 'dsd_handheld|epod_app|paper_scan|edi|carrier_portal');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `recipient_title` SET TAGS ('dbx_business_glossary_term' = 'Recipient Job Title');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_business_glossary_term' = 'Signature Image URL');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`proof_of_delivery` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Warehouse Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `actual_pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Pickup Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `agreed_freight_rate` SET TAGS ('dbx_business_glossary_term' = 'Agreed Freight Rate');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `agreed_freight_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Invoice Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Freight Direction');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|interplant');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_audit_status` SET TAGS ('dbx_value_regex' = 'pending|approved|disputed|paid|written_off');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_number` SET TAGS ('dbx_value_regex' = '^FO-[0-9]{10}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `is_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'FTL|LTL|parcel|intermodal|rail');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'tendered|accepted|rejected|in_transit|delivered|cancelled');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `pickup_window_end` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window End Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `pickup_window_start` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window Start Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `pod_received` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Received Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `pod_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `requested_pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Pickup Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|same_day|economy');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `shipment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `tendering_method` SET TAGS ('dbx_business_glossary_term' = 'Tendering Method');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `tendering_method` SET TAGS ('dbx_value_regex' = 'spot|contract|load_board|dedicated|auction');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `tms_source_system` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Source System');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `tms_source_system` SET TAGS ('dbx_value_regex' = 'SAP_TM|Blue_Yonder_TMS|Oracle_TMS|manual');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `total_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Cost');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `total_freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|ocean|air|intermodal');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_order` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Depot ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `actual_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Time');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `actual_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Actual Distance (km)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `actual_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `actual_return_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Time');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `co2_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'CO2 Emissions (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `fuel_consumption_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption (Liters)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Indicator');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `is_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Route Indicator');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `is_dsd` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Indicator');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Route Notes');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `optimization_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Algorithm');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `optimization_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Optimization Run Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `otif_compliant` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Indicator');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `planned_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Time');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `planned_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Planned Distance (km)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `planned_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `planned_return_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Return Time');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `proof_of_delivery_required` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Required Indicator');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `route_date` SET TAGS ('dbx_business_glossary_term' = 'Route Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `route_number` SET TAGS ('dbx_business_glossary_term' = 'Route Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'planned|dispatched|in_progress|completed|cancelled');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'delivery|pickup|mixed|cross_dock|dsd');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `service_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Service Time Window End');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `service_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Service Time Window Start');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Required Temperature (°C)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Temperature (°C)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `total_cases_delivered` SET TAGS ('dbx_business_glossary_term' = 'Total Cases Delivered');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `total_cases_planned` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Cases');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `total_pallets_planned` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Pallets');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `total_stops_completed` SET TAGS ('dbx_business_glossary_term' = 'Total Completed Stops');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `total_stops_planned` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Stops');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Route Volume (m³)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Route Weight (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`route` ALTER COLUMN `vehicle_capacity_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Capacity Utilization Percentage');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Invoice Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `supply_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `accessorial_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `accessorial_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Payment Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `audit_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Completed Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `contracted_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `contracted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `edi_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'National Motor Freight Classification (NMFC) Freight Class');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_source` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Source');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_source` SET TAGS ('dbx_value_regex' = 'edi|carrier_portal|email|paper|api');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'received|under_audit|approved|disputed|paid|cancelled');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|rebill|adjustment');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoiced_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Total Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoiced_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `is_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Shipment Indicator');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Indicator');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `line_haul_amount` SET TAGS ('dbx_business_glossary_term' = 'Line-Haul Charge Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `line_haul_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `paid_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `shipment_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Variance Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `tracking_event_id` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `supply_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `carrier_event_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Event Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `carrier_sla_met` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level Agreement (SLA) Met Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `customs_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `customs_status` SET TAGS ('dbx_value_regex' = 'cleared|held|pending|released|seized');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `edi_interchange_control_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Interchange Control Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_value_regex' = '214|990|204|210|997');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_city` SET TAGS ('dbx_business_glossary_term' = 'Event City');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_country_code` SET TAGS ('dbx_business_glossary_term' = 'Event Country Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_state_province` SET TAGS ('dbx_business_glossary_term' = 'Event State or Province');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Record Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'active|superseded|cancelled|duplicate');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Tracking Event Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `exception_root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Root Cause Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `geofence_zone` SET TAGS ('dbx_business_glossary_term' = 'Geofence Zone');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity Percentage');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `planned_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Event Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `pod_method` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Method');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `pod_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|photo|no_signature_required');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `pod_signature_name` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signatory Name');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive Number (PRO Number)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `resolution_action_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `shipment_leg_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `speed_kmh` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Speed (km/h)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `temperature_breach` SET TAGS ('dbx_business_glossary_term' = 'Temperature Breach Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`tracking_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `accessorial_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Schedule Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Freight Rate');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `base_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Rate Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_from` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code Range Start');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_from` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_from` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_to` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code Range End');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_to` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `destination_postal_code_to` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `destination_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Zone Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Lane Distance (km)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'dry_van|reefer|flatbed|tanker|container|intermodal');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_basis` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Basis');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_basis` SET TAGS ('dbx_value_regex' = 'percentage|flat_per_mile|flat_per_shipment');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Rate');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `hazmat_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Applicable Flag');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `max_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Freight Charge');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `max_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `min_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Freight Charge');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `min_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_from` SET TAGS ('dbx_business_glossary_term' = 'Origin Postal Code Range Start');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_from` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_from` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_to` SET TAGS ('dbx_business_glossary_term' = 'Origin Postal Code Range End');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_to` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `origin_postal_code_to` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `origin_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Zone Code');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_basis_uom` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Source');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'contract|spot_market|tariff|benchmark|spot_quote');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Status');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|cancelled');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Type');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'per_mile|per_cwt|per_pallet|per_kg|flat|per_unit');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|overnight|economy|same_day');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `spot_quote_reference` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Reference Number');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tariff Name');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `transit_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Days');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `weight_break_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`freight_rate` ALTER COLUMN `weight_break_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum (kg)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`logistics`.`vehicle` ALTER COLUMN `towing_vehicle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
