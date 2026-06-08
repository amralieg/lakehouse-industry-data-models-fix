-- Schema for Domain: pricing | Business: Transport Shipping | Version: v1_mvm
-- Generated on: 2026-05-08 22:35:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`pricing` COMMENT 'SSOT for all tariff structures, rate cards, surcharge schedules, and dynamic pricing rules governing freight forwarding, express delivery, and contract logistics. Owns base rates, DIM weight calculations, fuel surcharges, GRI/BAF adjustments, THC, accessorial charges, Incoterms-based charge allocation (DDP, DAP, FOB, CIF, EXW), spot quote generation, and contract pricing. Feeds billing and contract domains for revenue recognition.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`rate_card` (
    `rate_card_id` BIGINT COMMENT 'Unique identifier for the rate card. Primary key. [ROLE: MASTER_RESOURCE]',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Rate cards are frequently negotiated as part of customer agreements. Linking enables contract-specific pricing enforcement, audit trails for negotiated rates, and ensures rate card versions align with',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Rate cards are often carrier-specific published tariffs. Pricing teams need carrier_id to distinguish carrier buy rates from sell rates, perform margin analysis, and manage carrier-specific GRI update',
    `dim_weight_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.dim_weight_rule. Business justification: rate_card has dim_weight_divisor: INT, which defines the volumetric divisor for DIM weight calculations on this rate card. This is exactly what dim_weight_rule captures. Adding dim_weight_rule_id norm',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Rate cards define pricing for specific origin-destination lanes. Lane_id anchors rate structures to network routes, enabling rate lookup by lane for freight costing and quote generation.',
    `superseded_by_rate_card_id` BIGINT COMMENT 'Identifier of the rate card that replaces this one, supporting version control and rate card lifecycle management. Null if this is the current version.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Rate cards reference carrier-suppliers who provide capacity. Business need: rate approval workflows verify supplier qualifications and performance ratings before publishing rates to customers.',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: A rate card is frequently published under or governed by a carrier tariff in freight forwarding. The tariff defines the official pricing structure, while the rate card operationalizes it for a specifi',
    `accessorial_charges_included` BOOLEAN COMMENT 'Indicates whether common accessorial charges (e.g., liftgate, residential delivery, inside delivery, appointment) are included in the base rate or billed separately.',
    `approval_status` STRING COMMENT 'Approval workflow state: not_submitted (not yet submitted for approval), pending (under review), approved (authorized for use), rejected (not approved), conditional (approved with conditions).. Valid values are `not_submitted|pending|approved|rejected|conditional`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card was approved, supporting audit trail and compliance requirements.',
    `base_rate_maximum` DECIMAL(18,2) COMMENT 'Maximum base freight rate per unit (as defined by rate_basis) applicable under this rate card. Used for ceiling pricing and rate cap enforcement.',
    `base_rate_minimum` DECIMAL(18,2) COMMENT 'Minimum base freight rate per unit (as defined by rate_basis) applicable under this rate card. Used for floor pricing and minimum charge calculations.',
    `contract_reference` STRING COMMENT 'Reference to the master contract or service agreement under which this rate card is issued. Applicable for contract-type rate cards.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rate card record was first created in the system, supporting audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all rates on this card are denominated (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment or tier for this rate card (e.g., Enterprise, SMB, E-Commerce, Retail, Government). Used for customer-specific or segment-specific pricing.',
    `effective_date` DATE COMMENT 'Date from which this rate card becomes active and applicable for pricing shipments. Part of the validity lifecycle.',
    `expiry_date` DATE COMMENT 'Date on which this rate card ceases to be valid. Nullable for open-ended rate cards. Part of the validity lifecycle.',
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether fuel surcharge (Bunker Adjustment Factor for ocean, fuel surcharge for air/road) is applicable to shipments priced under this rate card.',
    `fuel_surcharge_type` STRING COMMENT 'Type of fuel surcharge mechanism: BAF (Bunker Adjustment Factor for ocean), FSC (Fuel Surcharge for air/road), fixed_percentage (static percentage), index_linked (tied to fuel price index).. Valid values are `baf|fsc|fixed_percentage|index_linked`',
    `gri_applicable` BOOLEAN COMMENT 'Indicates whether General Rate Increase adjustments apply to this rate card. GRI is a carrier-announced across-the-board rate increase, common in ocean freight.',
    `hazmat_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a surcharge applies for shipments containing dangerous goods or hazardous materials under this rate card.',
    `incoterms_default` STRING COMMENT 'Default International Commercial Terms (Incoterms 2020) rule applied to shipments under this rate card, defining cost and risk allocation between buyer and seller (e.g., FOB, CIF, DDP, DAP, EXW). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rate card record was last updated, supporting change tracking and audit compliance.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum total charge cap per shipment under this rate card, used for contract pricing or promotional rate cards.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum total charge per shipment under this rate card, regardless of weight or volume. Ensures cost recovery for small shipments.',
    `notes` STRING COMMENT 'Free-text field for additional terms, conditions, exclusions, or special instructions applicable to this rate card (e.g., Excludes remote area surcharges, Subject to space availability).',
    `peak_season_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether peak season surcharges (e.g., holiday season, Chinese New Year) apply to shipments priced under this rate card.',
    `published_date` DATE COMMENT 'Date when this rate card was officially published or released to customers, sales teams, or operational systems.',
    `rate_basis` STRING COMMENT 'Unit of measure on which the base rate is calculated: per kilogram, per cubic meter (CBM), per twenty-foot equivalent unit (TEU), per shipment, per pallet, per mile, per kilometer, or per hour. [ENUM-REF-CANDIDATE: per_kg|per_cbm|per_teu|per_shipment|per_pallet|per_mile|per_km|per_hour — 8 candidates stripped; promote to reference product]',
    `rate_card_name` STRING COMMENT 'Human-readable name of the rate card, typically describing the service type, trade lane, or customer segment (e.g., Asia-Europe Ocean FCL Q1 2024, Express Air Domestic Standard).',
    `rate_card_number` STRING COMMENT 'Externally-known unique business identifier for the rate card, used in contracts, quotes, and billing references. Format: RC- followed by alphanumeric code.. Valid values are `^RC-[A-Z0-9]{8,12}$`',
    `rate_card_status` STRING COMMENT 'Current lifecycle state of the rate card: draft (under construction), pending_approval (awaiting authorization), active (in use), suspended (temporarily inactive), expired (past validity), superseded (replaced by newer version), archived (historical record). [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|superseded|archived — 7 candidates stripped; promote to reference product]',
    `rate_card_type` STRING COMMENT 'Classification of the rate card by pricing model: published (standard public rates), contract (customer-specific negotiated rates), spot (one-time market rates), promotional (limited-time discount rates), seasonal (peak/off-peak rates).. Valid values are `published|contract|spot|promotional|seasonal`',
    `security_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether security-related surcharges (e.g., TSA, C-TPAT, AEO compliance fees) apply to shipments under this rate card.',
    `service_mode` STRING COMMENT 'Primary transportation mode covered by this rate card: air freight, ocean freight, road transport, rail transport, multimodal (combination), or express parcel delivery.. Valid values are `air|ocean|road|rail|multimodal|express_parcel`',
    `service_type` STRING COMMENT 'Specific service offering within the mode (e.g., Standard, Express, Economy, Premium, Next Day, Deferred, FCL, LCL, FTL, LTL). Aligns with service level agreements and delivery commitments.',
    `thc_included` BOOLEAN COMMENT 'Indicates whether Terminal Handling Charges (origin and destination terminal fees) are included in the base rate or billed separately.',
    `version` STRING COMMENT 'Version identifier for the rate card, supporting version control and supersession tracking (e.g., v1.0, 2.1, 3.0.1).. Valid values are `^v?[0-9]+.[0-9]+(.[0-9]+)?$`',
    `weight_break_structure` STRING COMMENT 'Pricing structure model for weight-based rates: flat (single rate regardless of weight), tiered (discrete weight bands with fixed rates), banded (progressive discounts by weight range), continuous (formula-based).. Valid values are `flat|tiered|banded|continuous`',
    CONSTRAINT pk_rate_card PRIMARY KEY(`rate_card_id`)
) COMMENT 'Master rate card defining published or contracted base freight rates for a specific service type, trade lane, and validity period. Serves as the foundational pricing instrument across freight forwarding, express delivery, and contract logistics. Captures rate card name, version, effective/expiry dates, service mode (air/ocean/road/rail), rate basis (per kg, per CBM, per TEU, per shipment), currency, approval status, and zone structure. Includes validity lifecycle (activation, expiry, extension, supersession). SSOT for all base rate structures feeding spot quote generation, contract pricing, and billing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`rate_line` (
    `rate_line_id` BIGINT COMMENT 'Unique identifier for the rate line item within the rate card structure. Primary key for the rate line entity.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Rate lines price specific carrier service products (e.g., Maersk AE7, FedEx Priority). Operational rating engines must link rates to exact services for accurate quote generation, transit time calculat',
    `dim_weight_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.dim_weight_rule. Business justification: rate_line has dim_weight_factor: DECIMAL(10,2), which is the volumetric divisor used for DIM weight calculation. This is exactly what dim_weight_rule.dim_factor captures. Adding dim_weight_rule_id nor',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Individual rate lines price specific lanes with weight/volume breaks. Lane_id enables direct rate lookup by lane for shipment costing, quote generation, and freight audit processes.',
    `rate_card_id` BIGINT COMMENT 'Reference to the parent rate card that contains this rate line. Establishes the header-detail relationship for tariff structures.',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Rate lines can price multi-leg corridors (e.g., Asia-Europe via Middle East hub). Service_corridor_id enables corridor-level pricing for complex multi-modal movements requiring consolidated rating.',
    `all_in_rate_flag` BOOLEAN COMMENT 'Indicates whether this rate line represents an all-inclusive rate covering all charges (true) or a component rate requiring additional surcharges and fees (false).',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate line was approved for use in production pricing. Supports governance and approval workflow tracking.',
    `charge_type` STRING COMMENT 'Classification of the charge represented by this rate line. Distinguishes between base freight rates, surcharges, accessorial charges, and fees.. Valid values are `base_freight|fuel_surcharge|security_fee|handling_charge|documentation_fee|customs_clearance`',
    `commodity_class` STRING COMMENT 'Classification of goods type or freight class applicable to this rate line. May reference NMFC class codes, IATA commodity codes, or internal classification schemes.',
    `container_type` STRING COMMENT 'Specific container or equipment type applicable to this rate line. May reference TEU, FEU, 20ft, 40ft, 40HC, reefer, flat rack, or other ISO container codes for ocean freight.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate line record was first created in the system. Supports audit trail and rate history tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate value and minimum charge. Defines the monetary unit for all financial amounts on this rate line.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Date when this rate line becomes active and applicable for pricing. Supports temporal rate management and historical rate tracking.',
    `effective_to_date` DATE COMMENT 'Date when this rate line expires or is superseded. Null indicates the rate line is currently active with no defined end date.',
    `fuel_surcharge_pct` DECIMAL(18,2) COMMENT 'Percentage fuel surcharge applied to the base rate. Reflects fluctuations in fuel costs and may be updated periodically based on fuel price indices.',
    `hazmat_surcharge_pct` DECIMAL(18,2) COMMENT 'Percentage surcharge applied to the base rate for dangerous goods or hazardous materials shipments. Null if not applicable to this rate line.',
    `incoterms_code` STRING COMMENT 'Incoterms 2020 code defining the allocation of costs, risks, and responsibilities between buyer and seller. Determines which charges are included in this rate line. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `line_sequence` STRING COMMENT 'Sequential ordering of rate lines within the parent rate card. Used for display and processing order of tiered pricing structures.',
    `load_type` STRING COMMENT 'Shipment load classification for this rate line. Distinguishes between Full Container Load (FCL), Less than Container Load (LCL), Full Truckload (FTL), Less than Truckload (LTL), or parcel shipments.. Valid values are `FCL|LCL|FTL|LTL|parcel`',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount that applies to this rate line regardless of actual weight or volume. Ensures a floor revenue for small shipments.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate line record was last modified. Tracks the most recent update to any attribute of the rate line.',
    `negotiated_rate_flag` BOOLEAN COMMENT 'Indicates whether this rate line was individually negotiated with a specific customer (true) or represents a standard published tariff rate (false).',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, exceptions, or special instructions for this rate line. Used for internal documentation and communication.',
    `peak_season_surcharge_pct` DECIMAL(18,2) COMMENT 'Percentage surcharge applied during peak shipping seasons or high-demand periods. Null if not applicable to this rate line.',
    `priority_rank` STRING COMMENT 'Priority ranking for rate line selection when multiple overlapping rate lines match a shipment. Lower numbers indicate higher priority.',
    `rate_basis_description` STRING COMMENT 'Detailed explanation of how the rate is calculated and applied. Provides context for complex pricing rules, tiered structures, or special conditions.',
    `rate_line_status` STRING COMMENT 'Current lifecycle status of the rate line. Indicates whether the rate is available for use in pricing calculations and quote generation.. Valid values are `active|inactive|pending|expired|suspended`',
    `rate_unit_of_measure` STRING COMMENT 'Unit of measure for the rate value. Defines how the rate is applied (per kilogram, per cubic meter, per TEU container, per shipment, per pallet, or per mile).. Valid values are `per_kg|per_cbm|per_teu|per_shipment|per_pallet|per_mile`',
    `rate_value` DECIMAL(18,2) COMMENT 'The charge amount for this rate line. Represents the base rate applied per unit of measure for the defined lane, service level, and weight/volume tier.',
    `service_level` STRING COMMENT 'Service tier or speed classification for this rate line. Differentiates pricing based on delivery speed and service quality commitments.. Valid values are `next_day|priority|economy|deferred|standard|express`',
    `special_handling_code` STRING COMMENT 'Code indicating special handling requirements that affect this rate line. May reference temperature control, fragile handling, security escort, or other specialized services.',
    `spot_rate_flag` BOOLEAN COMMENT 'Indicates whether this rate line represents a spot market rate (true) subject to immediate market conditions or a contract rate (false) with longer-term stability.',
    `transit_time_days` STRING COMMENT 'Expected transit time in days for shipments using this rate line. Represents the standard delivery timeframe for the origin-destination lane and service level.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation covered by this rate line. Determines the freight forwarding method and associated cost structure.. Valid values are `air|ocean|road|rail|multimodal`',
    `volume_break_max_cbm` DECIMAL(18,2) COMMENT 'Maximum volume threshold in cubic meters (CBM) for this rate tier. Defines the upper bound of the volume band for dimensional pricing structures. Null indicates no upper limit.',
    `volume_break_min_cbm` DECIMAL(18,2) COMMENT 'Minimum volume threshold in cubic meters (CBM) for this rate tier. Defines the lower bound of the volume band for dimensional pricing structures.',
    `volume_discount_pct` DECIMAL(18,2) COMMENT 'Percentage discount applied for high-volume shipments meeting the weight or volume break thresholds. Incentivizes larger shipment consolidation.',
    `weight_break_max_kg` DECIMAL(18,2) COMMENT 'Maximum weight threshold in kilograms for this rate tier. Defines the upper bound of the weight band for tiered pricing structures. Null indicates no upper limit.',
    `weight_break_min_kg` DECIMAL(18,2) COMMENT 'Minimum weight threshold in kilograms for this rate tier. Defines the lower bound of the weight band for tiered pricing structures.',
    CONSTRAINT pk_rate_line PRIMARY KEY(`rate_line_id`)
) COMMENT 'Individual rate line item within a rate card, capturing the specific charge amount for a defined origin-destination lane, weight/volume break tier, commodity class, and service level. Stores rate value, unit of measure (per kg, per CBM, per TEU), minimum charge, currency, transit time, applicable Incoterms, weight break thresholds (min/max weight or volume bands), and service level differentiation (Next Day, Economy, Priority, Deferred). Supports tiered pricing with inline break definitions and volume discounts. Child entity of rate_card.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`tariff` (
    `tariff_id` BIGINT COMMENT 'Unique identifier for the tariff schedule. Primary key.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Tariffs are frequently published by agents under GSA agreements in specific territories. Agent_id tracks the publishing/managing agent for compliance, commission calculation, and territory-specific ra',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Tariffs can be agreement-specific (negotiated tariff schedules vs. published). Linking supports contract compliance validation, regulatory filing requirements, and enables agreement-specific tariff te',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier or logistics service provider that publishes and operates under this tariff. Links to carrier master data.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Tariffs publish rates for specific lanes. Lane_id links published pricing to network routes, enabling tariff-based rate lookup for regulatory compliance and customer rate sheets.',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Tariffs publish rates for service corridors. Service_corridor_id links published pricing to multi-leg routes, enabling corridor-based tariff lookup for international freight movements.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Tariffs published by carrier-suppliers. Business need: tariff compliance audits require linking published rates to supplier master data for regulatory filing verification and supplier performance trac',
    `accessorial_charges_included` BOOLEAN COMMENT 'Indicates whether accessorial charges (e.g., liftgate service, inside delivery, residential delivery, hazmat handling) are included in the base tariff or billed separately.',
    `approval_date` DATE COMMENT 'Date on which the tariff received internal or regulatory approval. Part of the tariff lifecycle audit trail.',
    `base_rate_structure` STRING COMMENT 'Methodology used to calculate base freight charges (e.g., flat rate per shipment, weight-based per kg, distance-based per km, zone-to-zone matrix, dimensional weight). Defines the pricing model foundation.. Valid values are `flat|weight_based|distance_based|zone_based|dimensional|hybrid`',
    `commodity_restrictions` STRING COMMENT 'Description of any commodity-specific restrictions or exclusions under this tariff (e.g., No perishables, Hazmat Class 1 excluded, Electronics only). Nullable if no restrictions apply.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tariff record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which tariff rates are denominated (e.g., USD, EUR, CNY). All rates within this tariff are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_included` BOOLEAN COMMENT 'Indicates whether customs brokerage and clearance services are included in the tariff rate or billed separately. Relevant for cross-border and international tariffs.',
    `dim_weight_divisor` DECIMAL(18,2) COMMENT 'Divisor used to calculate dimensional weight from volumetric measurements (length x width x height / divisor). Common values: 5000 for air freight (cm), 166 for express (in). Nullable if tariff does not use DIM weight.',
    `distance_unit` STRING COMMENT 'Standard unit of measure for distance used in distance-based tariffs (e.g., kilometers, miles, nautical miles). Nullable if tariff is not distance-based.. Valid values are `km|mile|nautical_mile`',
    `effective_date` DATE COMMENT 'Date from which the tariff rates and rules become valid and enforceable for new shipments. Must comply with regulatory notice periods.',
    `expiry_date` DATE COMMENT 'Date on which the tariff ceases to be valid. Nullable for open-ended tariffs that remain in effect until superseded or withdrawn.',
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a fuel surcharge (BAF for ocean, fuel surcharge for air/road) is applied on top of base rates under this tariff. True if fuel adjustment is part of the tariff structure.',
    `governing_body` STRING COMMENT 'Regulatory authority or industry body that oversees or approves this tariff (e.g., FMC, IATA, IMO, DOT). Determines compliance requirements and filing procedures.',
    `governing_body_reference` STRING COMMENT 'Official reference number or filing identifier assigned by the governing body (e.g., FMC tariff number, IATA resolution reference). Used for regulatory traceability.',
    `gri_applicable` BOOLEAN COMMENT 'Indicates whether General Rate Increases (periodic across-the-board rate adjustments) are applicable to this tariff. Common in ocean freight and contract logistics.',
    `incoterms_default` STRING COMMENT 'Default International Commercial Terms (Incoterms) rule applied under this tariff, defining the allocation of costs, risks, and responsibilities between buyer and seller. Nullable if tariff does not specify a default. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_included` BOOLEAN COMMENT 'Indicates whether cargo insurance coverage is included in the tariff rate or offered as an optional add-on. Relevant for high-value or international shipments.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or revision to the tariff. Supports version control and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the tariff record was last updated. Supports change tracking and audit compliance.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum freight charge applicable per shipment under this tariff, regardless of weight or distance. Ensures cost recovery for small shipments.',
    `publication_date` DATE COMMENT 'Date on which the tariff was officially published or filed with the governing body. Used for regulatory compliance and audit trail.',
    `publication_status` STRING COMMENT 'Current lifecycle status of the tariff. Published tariffs are active and enforceable; filed tariffs are submitted to regulatory bodies; approved tariffs have received regulatory clearance. [ENUM-REF-CANDIDATE: draft|published|filed|approved|suspended|withdrawn|archived — 7 candidates stripped; promote to reference product]',
    `service_product_type` STRING COMMENT 'Service level or product category this tariff applies to (e.g., express parcel, standard freight, economy ocean). Defines speed, handling, and service commitments. [ENUM-REF-CANDIDATE: express|standard|economy|freight|ltl|ftl|fcl|lcl — 8 candidates stripped; promote to reference product]',
    `special_conditions` STRING COMMENT 'Free-text field capturing any special terms, restrictions, or conditions applicable to this tariff (e.g., Applies only to contract customers, Excludes hazardous materials, Minimum volume commitment required).',
    `tariff_description` STRING COMMENT 'Detailed textual description of the tariff scope, coverage, special terms, and conditions. Provides context for tariff application and interpretation.',
    `tariff_name` STRING COMMENT 'Human-readable name or title of the tariff schedule (e.g., Asia-Pacific Express Air Tariff 2024, North America LTL Standard Rates).',
    `tariff_number` STRING COMMENT 'Externally published tariff identification number used for regulatory filing and customer reference. Unique business identifier for the tariff schedule.. Valid values are `^[A-Z0-9]{6,20}$`',
    `tariff_type` STRING COMMENT 'Classification of the tariff based on trade direction and geographic scope. Determines applicable regulatory framework and pricing structure.. Valid values are `import|export|domestic|cross_border|international`',
    `thc_included` BOOLEAN COMMENT 'Indicates whether Terminal Handling Charges (fees for loading/unloading at port or terminal) are included in the tariff base rate or billed separately. Relevant for ocean and air freight.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation covered by this tariff schedule. Determines applicable service standards, transit times, and rate calculation methodology.. Valid values are `air|ocean|road|rail|multimodal|parcel`',
    `version` STRING COMMENT 'Version number of the tariff schedule. Incremented with each amendment or revision. Supports historical tracking and audit compliance.. Valid values are `^[0-9]{1,3}(.[0-9]{1,2})?$`',
    `volume_unit` STRING COMMENT 'Standard unit of measure for volume used in this tariff (e.g., cubic meters, cubic feet). Relevant for LCL, LTL, and dimensional weight calculations.. Valid values are `cbm|cft|liter`',
    `weight_unit` STRING COMMENT 'Standard unit of measure for weight used in this tariff (e.g., kilograms, pounds, metric tonnes). All weight-based rates are expressed in this unit.. Valid values are `kg|lb|ton|tonne`',
    CONSTRAINT pk_tariff PRIMARY KEY(`tariff_id`)
) COMMENT 'Published tariff schedule representing the official pricing structure for a carrier, service product, or trade lane. Captures tariff name, tariff type (import/export/domestic/cross-border), applicable transport mode, governing body reference (IATA, FMC, IMO), effective date, expiry date, currency, and publication status. Distinct from negotiated rate cards — tariffs represent the publicly filed or carrier-published rate basis before customer-specific discounts.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`surcharge` (
    `surcharge_id` BIGINT COMMENT 'Primary key for surcharge',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Surcharges are frequently negotiated at agreement level (waived, capped, or custom rates). Linking enables contract-specific surcharge application rules, supports billing dispute resolution, and enfor',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Many surcharges (BAF, CAF, PSS, GRI) are carrier-imposed and carrier-specific. Pricing must track which carrier announced each surcharge for accurate cost attribution, customer billing transparency, a',
    `fuel_index_id` BIGINT COMMENT 'Foreign key linking to pricing.fuel_index. Business justification: surcharge has fuel_index_linked_flag (BOOLEAN) and fuel_index_source (STRING), strongly indicating that fuel surcharges are linked to a specific fuel_index record. Normalizing this with a FK to fuel_i',
    `charge_code_id` BIGINT COMMENT 'Foreign key linking to pricing.charge_code. Business justification: Surcharges (fuel, security, GRI, peak season) must map to standardized charge codes for billing system integration, revenue recognition, and financial reporting. While surcharge maintains its own surc',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Surcharges applied by carrier-suppliers. Business need: surcharge dispute resolution requires linking to supplier contracts and performance data; supplier scorecards track surcharge frequency and vali',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: surcharge has governing_body_reference: STRING, indicating surcharges are often mandated or published under a governing tariff (e.g., IATA fuel surcharge tables, carrier BAF schedules). Adding tariff_',
    `applicable_service_type` STRING COMMENT 'Service type(s) to which this surcharge applies. Express includes time-definite delivery; standard includes regular service; economy includes deferred service; freight_forwarding includes forwarding services; contract_logistics includes warehousing and distribution; all indicates universal applicability.. Valid values are `express|standard|economy|freight_forwarding|contract_logistics|all`',
    `applicable_transport_mode` STRING COMMENT 'Transport mode(s) to which this surcharge applies. Air includes air freight; ocean includes FCL/LCL; road includes FTL/LTL; rail includes intermodal rail; multimodal includes combined transport; all indicates surcharge applies across all modes.. Valid values are `air|ocean|road|rail|multimodal|all`',
    `applies_to_dim_weight_flag` BOOLEAN COMMENT 'Indicates whether this surcharge is calculated based on dimensional weight (true) or actual weight (false). Relevant for air freight and express parcel surcharges where volumetric weight may exceed actual weight.',
    `applies_to_hazmat_flag` BOOLEAN COMMENT 'Indicates whether this surcharge applies specifically to hazardous materials shipments (true) or to all shipments (false). Hazmat surcharges cover additional handling, documentation, and compliance costs.',
    `applies_to_oversize_flag` BOOLEAN COMMENT 'Indicates whether this surcharge applies to oversize or out-of-gauge shipments (true) or to standard shipments (false). Oversize surcharges cover special handling and equipment requirements.',
    `applies_to_temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this surcharge applies to temperature-controlled (reefer) shipments (true) or to all shipments (false). Temperature-controlled surcharges cover refrigeration equipment and monitoring costs.',
    `approval_status` STRING COMMENT 'Workflow approval status for this surcharge definition. Draft indicates work in progress; pending_approval indicates submitted for review; approved indicates ready for activation; rejected indicates not approved.. Valid values are `draft|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this surcharge definition was approved. Null if not yet approved. Used for audit trail and compliance reporting.',
    `approved_by_user` STRING COMMENT 'User ID or name of the person who approved this surcharge definition. Null if not yet approved. Used for audit trail and governance.',
    `calculation_formula` STRING COMMENT 'Custom formula or algorithm used when calculation_method is formula_based. May reference fuel index, base freight, weight, volume, or other variables. Null for standard calculation methods.',
    `calculation_method` STRING COMMENT 'Method used to calculate the surcharge amount. Flat_rate applies a fixed amount; percentage applies a rate to base freight; per_unit applies a rate per weight/volume/TEU; tiered applies different rates based on thresholds; formula_based uses a custom calculation (e.g., fuel index-linked).. Valid values are `flat_rate|percentage|per_unit|tiered|formula_based`',
    `charge_allocation_party` STRING COMMENT 'Party responsible for paying the surcharge. Shipper indicates origin party pays; consignee indicates destination party pays; carrier indicates carrier absorbs; third_party indicates a third party (e.g., freight forwarder) pays; negotiable indicates allocation is determined per contract or shipment.. Valid values are `shipper|consignee|carrier|third_party|negotiable`',
    `compounding_allowed_flag` BOOLEAN COMMENT 'Indicates whether this surcharge can be compounded with other surcharges (true) or is mutually exclusive (false). Compounding affects total charge calculation when multiple surcharges apply to a single shipment.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this surcharge definition. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this surcharge definition record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary amounts (e.g., USD, EUR, GBP, CNY). Applies to flat_rate_amount, per_unit_rate, and minimum/maximum charge amounts.. Valid values are `^[A-Z]{3}$`',
    `customer_visibility_flag` BOOLEAN COMMENT 'Indicates whether this surcharge is displayed as a separate line item on customer invoices and quotes (true) or is bundled into total freight charges (false). Affects billing transparency and customer communication.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for destination restriction. Null if surcharge applies regardless of destination. Used for lane-specific or country-specific surcharges.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date on which this surcharge definition expires or is superseded. Null for open-ended surcharges. Used for time-bound surcharges such as peak season or temporary fuel adjustments.',
    `effective_start_date` DATE COMMENT 'Date from which this surcharge definition becomes active and applicable to shipments. Aligns with rate card effective dates and GRI announcement schedules.',
    `flat_rate_amount` DECIMAL(18,2) COMMENT 'Fixed surcharge amount when calculation_method is flat_rate. Expressed in the currency specified by currency_code. Null for non-flat-rate surcharges.',
    `fuel_index_linked_flag` BOOLEAN COMMENT 'Indicates whether this surcharge is dynamically linked to a fuel price index (true) or is a static rate (false). Applicable primarily to BAF (Bunker Adjustment Factor) surcharges.',
    `governing_body_reference` STRING COMMENT 'Reference to the regulatory body, industry association, or standard that governs or mandates this surcharge (e.g., IATA Resolution 600a, FMC Docket Number, IMO MARPOL Annex VI for environmental surcharges). Null for carrier-specific surcharges.',
    `incoterms_applicability` STRING COMMENT 'Incoterms rule(s) under which this surcharge applies. Determines which party (shipper or consignee) bears the surcharge cost. EXW=Ex Works, FCA=Free Carrier, CPT=Carriage Paid To, CIP=Carriage and Insurance Paid To, DAP=Delivered at Place, DPU=Delivered at Place Unloaded, DDP=Delivered Duty Paid, FAS=Free Alongside Ship, FOB=Free on Board, CFR=Cost and Freight, CIF=Cost Insurance and Freight. All indicates surcharge applies regardless of Incoterms. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF|all — 12 candidates stripped; promote to reference product]',
    `internal_notes` STRING COMMENT 'Internal operational notes or comments about the surcharge definition, including implementation guidance, system mapping instructions, or historical context. Not visible to customers.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this surcharge definition. Used for audit trail and change management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this surcharge definition record was last updated. Used for audit trail and change tracking.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum surcharge amount that will be applied, capping the calculation result. Expressed in currency_code. Null if no maximum applies.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum surcharge amount that will be applied, regardless of calculation result. Expressed in currency_code. Null if no minimum applies.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for origin restriction. Null if surcharge applies regardless of origin. Used for lane-specific or country-specific surcharges.. Valid values are `^[A-Z]{3}$`',
    `per_unit_rate` DECIMAL(18,2) COMMENT 'Rate applied per unit of measure when calculation_method is per_unit. Unit of measure specified in unit_of_measure field. Null for non-per-unit surcharges.',
    `percentage_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to base freight when calculation_method is percentage. Expressed as a decimal (e.g., 15.00 for 15%). Null for non-percentage surcharges.',
    `priority_sequence` STRING COMMENT 'Numeric sequence indicating the order in which this surcharge is applied when multiple surcharges are compounded. Lower numbers are applied first. Used to ensure correct calculation order (e.g., base freight → GRI → BAF → THC).',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether this surcharge is mandated by a regulatory body (true) or is a carrier-discretionary surcharge (false). Regulatory surcharges include security fees, customs processing fees, environmental levies.',
    `surcharge_category` STRING COMMENT 'High-level classification of the surcharge type. Fuel includes BAF; rate_adjustment includes GRI; terminal includes THC; seasonal includes peak season; security includes security fees; risk includes war risk and insurance; regulatory includes customs and compliance fees; operational includes handling and storage; accessorial includes special services. [ENUM-REF-CANDIDATE: fuel|rate_adjustment|terminal|seasonal|security|risk|regulatory|operational|accessorial — 9 candidates stripped; promote to reference product]',
    `surcharge_code` STRING COMMENT 'Unique business identifier for the surcharge type (e.g., BAF, GRI, PSS, SEC, THC, WAR). Used across rate cards, spot quotes, and billing systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `surcharge_description` STRING COMMENT 'Detailed business description of the surcharge, including purpose, rationale, and any special conditions or exclusions. Used for customer communication and internal documentation.',
    `surcharge_name` STRING COMMENT 'Full descriptive name of the surcharge (e.g., Bunker Adjustment Factor, General Rate Increase, Peak Season Surcharge, Security Surcharge, Terminal Handling Charge, War Risk Surcharge).',
    `surcharge_status` STRING COMMENT 'Current lifecycle status of the surcharge definition. Active indicates currently in use; inactive indicates not in use; pending indicates scheduled for future activation; expired indicates past effective_end_date; suspended indicates temporarily disabled.. Valid values are `active|inactive|pending|expired|suspended`',
    `trade_lane_scope` STRING COMMENT 'Geographic scope of the surcharge applicability. Global applies worldwide; regional applies to specific regions (e.g., Asia-Pacific, Europe); country_specific applies to individual countries; lane_specific applies to origin-destination pairs.. Valid values are `global|regional|country_specific|lane_specific`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for per_unit_rate calculation. KG=kilogram, LB=pound, CBM=cubic meter, CFT=cubic feet, TEU=twenty-foot equivalent unit, FEU=forty-foot equivalent unit. Applicable only when calculation_method is per_unit. [ENUM-REF-CANDIDATE: kg|lb|cbm|cft|teu|feu|shipment|container|pallet — 9 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Version number of this surcharge definition, incremented with each modification. Supports change tracking and historical analysis of surcharge evolution.',
    CONSTRAINT pk_surcharge PRIMARY KEY(`surcharge_id`)
) COMMENT 'Master definition of all surcharge types applicable to freight and express shipments, including fuel surcharges (BAF), general rate increases (GRI), terminal handling charges (THC), peak season surcharges, security surcharges, and war risk surcharges. Captures surcharge code, surcharge name, surcharge category, calculation method (flat, percentage, per unit), applicable transport mode, trade lane scope, and governing body reference. SSOT for surcharge definitions used across rate cards and spot quotes.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` (
    `pricing_surcharge_schedule_id` BIGINT COMMENT 'Unique identifier for the surcharge schedule record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to a specific customer contract if this surcharge schedule is contract-specific rather than general tariff. Nullable for public tariff schedules.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Surcharge schedules vary by carrier service level (express vs economy, direct vs consolidated). Linking to carrier_service enables precise surcharge application in rating engines based on the exact se',
    `fuel_index_id` BIGINT COMMENT 'Foreign key linking to pricing.fuel_index. Business justification: pricing_surcharge_schedule tracks index_base_value, index_current_value, and index_reference_name — all of which indicate the schedule is tied to a fuel or commodity index. Adding fuel_index_id normal',
    `surcharge_id` BIGINT COMMENT 'Reference to the parent surcharge definition that this schedule implements. Links to the master surcharge type configuration.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Surcharge schedules in logistics are published per customer segment (e.g., premium segments receive capped fuel surcharges). The pricing_surcharge_schedule.customer_segment_code is a denormalized segm',
    `superseded_by_schedule_pricing_surcharge_schedule_id` BIGINT COMMENT 'Reference to the newer surcharge schedule that replaces this one. Nullable if this is the current active schedule.',
    `approval_status` STRING COMMENT 'Current approval state of this surcharge schedule: draft (being prepared), pending_approval (submitted for review), approved (active and enforceable), rejected (not approved), superseded (replaced by newer schedule), expired (past effective_to_date).. Valid values are `draft|pending_approval|approved|rejected|superseded|expired`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge schedule was approved. Critical for regulatory compliance and audit trail.',
    `commodity_group_code` STRING COMMENT 'Business classification code for commodity types this surcharge applies to (e.g., DG for dangerous goods, PERISHABLE, GENERAL).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge schedule record was first created in the system.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for shipment destination. Defines geographic scope of surcharge applicability.. Valid values are `^[A-Z]{3}$`',
    `destination_port_code` STRING COMMENT 'Five-letter UN/LOCODE for destination port or airport. Specifies exact terminal where surcharge applies (e.g., USLAX, CNSHA).. Valid values are `^[A-Z]{5}$`',
    `destination_region_code` STRING COMMENT 'Business-defined region code for destination (e.g., APAC, EMEA, AMER). Used when surcharge applies to a broader geographic area.',
    `effective_from_date` DATE COMMENT 'Date when this surcharge schedule becomes active and applicable to shipments. Aligns with tariff publication requirements.',
    `effective_to_date` DATE COMMENT 'Date when this surcharge schedule expires or is superseded. Nullable for open-ended schedules.',
    `incoterm_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining cost and risk allocation. Determines which party bears the surcharge (e.g., DDP, FOB, CIF, EXW). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `index_base_value` DECIMAL(18,2) COMMENT 'Baseline index value used as reference point for indexed surcharge calculations. Changes in index relative to this base drive surcharge adjustments.',
    `index_current_value` DECIMAL(18,2) COMMENT 'Current index value at time of schedule creation or last update. Used to calculate indexed surcharge amount.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum surcharge cap to limit exposure on high-value or high-volume shipments. Nullable if no cap applies.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum surcharge amount that must be applied regardless of calculated value. Ensures cost recovery for small shipments.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge schedule record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or business rationale for this surcharge schedule (e.g., Reflects Q1 fuel cost increase, Temporary COVID-19 surcharge).',
    `origin_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for shipment origin. Defines geographic scope of surcharge applicability.. Valid values are `^[A-Z]{3}$`',
    `origin_port_code` STRING COMMENT 'Five-letter UN/LOCODE for origin port or airport. Specifies exact terminal where surcharge applies (e.g., USLAX, CNSHA).. Valid values are `^[A-Z]{5}$`',
    `origin_region_code` STRING COMMENT 'Business-defined region code for origin (e.g., APAC, EMEA, AMER). Used when surcharge applies to a broader geographic area.',
    `published_flag` BOOLEAN COMMENT 'Indicates whether this surcharge schedule has been published to customers and external systems. True if published, False if internal-only.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge schedule was published externally. Required for regulatory compliance with advance notice requirements.',
    `rate_amount` DECIMAL(18,2) COMMENT 'The surcharge rate value. Interpretation depends on rate_type: absolute monetary amount per unit, or percentage multiplier.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the surcharge rate (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `rate_type` STRING COMMENT 'Method of surcharge calculation: flat (fixed amount), percentage (% of base rate), tiered (varies by band), indexed (linked to external index like fuel price).. Valid values are `flat|percentage|tiered|indexed`',
    `rate_unit_of_measure` STRING COMMENT 'Unit basis for the surcharge rate: per kilogram, per cubic meter (CBM), per Twenty-foot Equivalent Unit (TEU), per shipment, per container, per pallet.. Valid values are `per_kg|per_cbm|per_teu|per_shipment|per_container|per_pallet`',
    `schedule_code` STRING COMMENT 'Business identifier for this surcharge schedule. Used for external communication and system integration (e.g., BAF_2024Q1, GRI_ASIA_JAN, THC_LAX_V3).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `schedule_name` STRING COMMENT 'Human-readable name describing this surcharge schedule (e.g., Q1 2024 Bunker Adjustment Factor - Asia Pacific, Terminal Handling Charge - Los Angeles).',
    `service_mode` STRING COMMENT 'Transportation mode this surcharge applies to: air freight, ocean freight, road transport, rail transport, or multimodal combinations.. Valid values are `air|ocean|road|rail|multimodal`',
    `service_type` STRING COMMENT 'Service level this surcharge applies to: express, standard, economy, Full Container Load (FCL), Less than Container Load (LCL), Full Truckload (FTL), Less Than Truckload (LTL). [ENUM-REF-CANDIDATE: express|standard|economy|fcl|lcl|ftl|ltl — 7 candidates stripped; promote to reference product]',
    `surcharge_type` STRING COMMENT 'Category of surcharge: BAF (Bunker Adjustment Factor), GRI (General Rate Increase), THC (Terminal Handling Charge), FSC (Fuel Surcharge), PSS (Peak Season Surcharge), EBS (Emergency Bunker Surcharge).. Valid values are `BAF|GRI|THC|FSC|PSS|EBS`',
    `trade_lane_code` STRING COMMENT 'Business identifier for the trade lane or service corridor this surcharge applies to (e.g., ASIA_US_WEST, TRANSATLANTIC_NORTH).',
    `version_number` STRING COMMENT 'Sequential version number for this surcharge schedule. Increments with each revision to track schedule evolution over time.',
    `volume_break_max_cbm` DECIMAL(18,2) COMMENT 'Maximum volume threshold in cubic meters for this surcharge schedule. Nullable for open-ended top tier.',
    `volume_break_min_cbm` DECIMAL(18,2) COMMENT 'Minimum volume threshold in cubic meters (CBM) for this surcharge schedule to apply. Used for volumetric pricing.',
    `weight_break_max_kg` DECIMAL(18,2) COMMENT 'Maximum weight threshold in kilograms for this surcharge schedule. Nullable for open-ended top tier.',
    `weight_break_min_kg` DECIMAL(18,2) COMMENT 'Minimum weight threshold in kilograms for this surcharge schedule to apply. Used for tiered pricing structures.',
    CONSTRAINT pk_pricing_surcharge_schedule PRIMARY KEY(`pricing_surcharge_schedule_id`)
) COMMENT 'Time-bound schedule of active surcharge rates for a specific surcharge type, trade lane, and validity period. Captures the effective surcharge amount or percentage, currency, applicable weight/volume bands, origin and destination scope, and approval status. Enables tracking of BAF index changes, GRI announcements, and THC revisions over time. Links surcharge definitions to their current and historical rate values.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` (
    `fuel_index_id` BIGINT COMMENT 'Unique identifier for the fuel index record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Fuel indices are often carrier-published or carrier-specific (different carriers use different index sources/formulas). Carrier_id enables correct fuel surcharge calculation per carrier contract and s',
    `adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier or adjustment factor applied to the index value for specific trade lanes, service types, or contractual agreements (e.g., 1.05 for 5% premium on express services).',
    `baseline_index_value` DECIMAL(18,2) COMMENT 'Reference baseline value used to calculate percentage change or delta for surcharge formulas. Typically set at contract inception or annually.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel index record was first created in the system. Supports audit trail and data lineage.',
    `data_source_system` STRING COMMENT 'Name of the operational system or data feed from which the fuel index record was ingested (e.g., SAP TM, Oracle TMS, external API feed).',
    `effective_from_date` DATE COMMENT 'Start date from which this fuel index value is effective for surcharge calculations. Supports lagged application of index changes (e.g., index published on 1st, effective from 15th).',
    `effective_to_date` DATE COMMENT 'End date until which this fuel index value is effective for surcharge calculations. Null indicates the index is currently active.',
    `fuel_type` STRING COMMENT 'Type of fuel measured by this index. Jet fuel for air freight, bunker fuel (IFO380/VLSFO) for ocean freight, diesel for road freight, LNG for alternative fuel vehicles.. Valid values are `jet_fuel|bunker_ifo380|bunker_vlsfo|diesel|gasoline|lng`',
    `index_change_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage change from the baseline index value. Used directly in BAF and fuel surcharge formulas (e.g., +15.25% triggers tier-based surcharge).',
    `index_code` STRING COMMENT 'Business identifier code for the fuel index (e.g., IATA_JET_FUEL, PLATTS_IFO380, MOPS_DIESEL). Used for external reference and integration with pricing systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `index_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the index value is denominated (e.g., USD, EUR, SGD).. Valid values are `^[A-Z]{3}$`',
    `index_date` DATE COMMENT 'The date for which this fuel index value is published. Represents the business event timestamp for the index observation.',
    `index_name` STRING COMMENT 'Human-readable name of the fuel index (e.g., IATA Jet Fuel Index - Singapore, Platts Brent Crude).',
    `index_publication_timestamp` TIMESTAMP COMMENT 'Timestamp when the index was officially published by the source organization. Distinct from index_date (the date the index represents) and created_timestamp (when the record was ingested).',
    `index_source` STRING COMMENT 'Source organization or exchange publishing the fuel index. IATA (International Air Transport Association), Platts (S&P Global Platts), MOPS (Mean of Platts Singapore), EIA (US Energy Information Administration), ICE (Intercontinental Exchange), NYMEX (New York Mercantile Exchange). [ENUM-REF-CANDIDATE: iata|platts|mops|eia|ice|nymex|other — 7 candidates stripped; promote to reference product]',
    `index_source_url` STRING COMMENT 'URL or reference link to the official publication source of the fuel index. Supports audit trail and verification.',
    `index_status` STRING COMMENT 'Current lifecycle status of the fuel index record. Active indices are used for surcharge calculations; superseded indices are replaced by newer values; archived indices are retained for audit; pending verification indices await approval.. Valid values are `active|superseded|archived|pending_verification`',
    `index_value` DECIMAL(18,2) COMMENT 'The published fuel price index value for the index date. Precision supports fractional currency units and per-unit pricing (e.g., USD per gallon, USD per metric ton).',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the fuel index record. May include explanations for anomalies, corrections, or special handling instructions.',
    `publication_frequency` STRING COMMENT 'Frequency at which the index source publishes updates (daily, weekly, monthly, quarterly). Drives automated surcharge recalculation cycles.. Valid values are `daily|weekly|monthly|quarterly`',
    `region_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country/region code where the index applies (e.g., USA, SGP, EUR). Used to localize fuel surcharge calculations by geography.. Valid values are `^[A-Z]{2,3}$`',
    `surcharge_tier` STRING COMMENT 'Surcharge tier or bracket assigned based on index value or change percentage (e.g., Tier 1, Tier 2, Tier 3). Maps to predefined surcharge rate tables.',
    `trade_lane` STRING COMMENT 'Applicable trade lane or geographic corridor for this fuel index (e.g., Trans-Pacific, Asia-Europe, US Domestic). May be null for global indices.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the index value (e.g., per gallon, per liter, per barrel, per metric ton, per MMBTU). Critical for converting index values to freight surcharge calculations.. Valid values are `gallon|liter|barrel|metric_ton|kilogram|mmbtu`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel index record was last updated. Supports audit trail and change tracking.',
    `verification_status` STRING COMMENT 'Indicates whether the index value has been verified against the official source. Supports data quality and audit compliance.. Valid values are `verified|unverified|disputed|corrected`',
    `verified_timestamp` TIMESTAMP COMMENT 'Timestamp when the index value was verified. Null if verification_status is unverified.',
    CONSTRAINT pk_fuel_index PRIMARY KEY(`fuel_index_id`)
) COMMENT 'Periodic fuel price index records from external sources used to calculate and adjust BAF (Bunker Adjustment Factor) and fuel surcharges for air, ocean, and road freight. Captures index date, fuel type (jet fuel, bunker fuel IFO380/VLSFO, diesel), index value, index source (IATA, Platts, MOPS, EIA), currency, applicable trade lane or region, effective period, and index publication frequency. Drives automated surcharge recalculation cycles (typically monthly for ocean, weekly for road) and provides audit trail for fuel surcharge adjustments.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` (
    `accessorial_charge_id` BIGINT COMMENT 'Unique identifier for the accessorial charge definition. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Accessorial charges are commonly negotiated in customer agreements (included, waived, or discounted). Linking supports contract enforcement, enables agreement-specific accessorial pricing, and facilit',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Many accessorial charges are carrier-specific (e.g., carrier-imposed security fees, residential delivery surcharges). Carrier_id enables accurate cost pass-through and carrier-specific charge applicat',
    `charge_code_id` BIGINT COMMENT 'Foreign key linking to pricing.charge_code. Business justification: Accessorial charges are a specialized type of charge and must reference the master charge code catalog for standardized charge code assignment, revenue account mapping, tax treatment, and EDI/IATA cod',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: accessorial_charge has published_tariff_flag: BOOLEAN, indicating that some accessorial charges are formally published under a carrier tariff. Adding tariff_id normalizes this relationship so publishe',
    `accessorial_charge_status` STRING COMMENT 'Current lifecycle status of the accessorial charge definition. Active charges are available for use in rating and billing; inactive or deprecated charges are retained for historical reference only.. Valid values are `active|inactive|pending|deprecated|suspended`',
    `applicable_incoterms` STRING COMMENT 'Comma-separated list of Incoterms under which this charge applies (e.g., DDP, DAP, FOB, CIF, EXW, FCA). Determines which party (shipper or consignee) is responsible for the charge. Empty if applicable to all Incoterms.',
    `applicable_modes` STRING COMMENT 'Comma-separated list of transportation modes to which this charge applies (e.g., air, ocean, road, rail, multimodal). Empty if applicable to all modes.',
    `applicable_service_types` STRING COMMENT 'Comma-separated list of service types to which this accessorial charge applies (e.g., express_parcel, freight_forwarding, LTL, FTL, air_freight, ocean_freight, last_mile). Empty if applicable to all services.',
    `auto_apply_conditions` STRING COMMENT 'Business rules or conditions that trigger automatic application of this charge (e.g., delivery_address_type=residential, package_weight>70kg, requires_signature=true, contains_hazmat=true). Stored as structured text or rule expression.',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether this accessorial charge is automatically applied by the rating engine when conditions are met (True) or requires manual addition by operations staff (False).',
    `calculation_basis` STRING COMMENT 'Method by which the accessorial charge is calculated: flat fee (fixed amount), per shipment, per package, per kilogram, per pound, percentage of base freight charge, per cubic meter (CBM), or per pallet. [ENUM-REF-CANDIDATE: flat_fee|per_shipment|per_package|per_kg|per_lb|percentage_of_freight|per_cbm|per_pallet — 8 candidates stripped; promote to reference product]',
    `charge_amount` DECIMAL(18,2) COMMENT 'Standard charge amount in the base currency. For flat fees, this is the fixed amount. For rate-based charges, this is the rate per unit (e.g., per kg, per package). Null if calculation is percentage-based.',
    `charge_bearer` STRING COMMENT 'Party responsible for paying the accessorial charge: shipper (sender), consignee (receiver), third_party (bill-to party), or as_per_incoterm (determined by Incoterms agreement).. Valid values are `shipper|consignee|third_party|as_per_incoterm`',
    `charge_category` STRING COMMENT 'Classification of the accessorial charge into functional categories for reporting and analysis. [ENUM-REF-CANDIDATE: delivery_surcharge|handling_fee|documentation_fee|special_service|address_correction|dimensional_adjustment|fuel_related|insurance_fee|storage_fee|customs_fee|security_fee|temperature_control|weekend_delivery|holiday_delivery — promote to reference product]',
    `charge_description` STRING COMMENT 'Detailed description of the accessorial charge, including conditions under which it applies and any exclusions or special terms.',
    `charge_name` STRING COMMENT 'Human-readable name of the accessorial charge (e.g., Residential Delivery Surcharge, Address Correction Fee, Signature Required Fee, Hazmat Handling Fee).',
    `charge_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to base freight charge when calculation_basis is percentage_of_freight. Expressed as a decimal (e.g., 15.00 for 15%). Null for non-percentage charges.',
    `charge_tier` STRING COMMENT 'Service tier or level associated with this accessorial charge, used for tiered pricing structures and service differentiation.. Valid values are `standard|premium|economy|express`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accessorial charge record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_visibility_flag` BOOLEAN COMMENT 'Indicates whether this accessorial charge is visible to customers in quotes, invoices, and online portals (True) or is an internal charge not disclosed to customers (False).',
    `destination_country_codes` STRING COMMENT 'Comma-separated list of three-letter ISO 3166-1 alpha-3 country codes where this charge applies to shipments destined. Empty if applicable to all destinations.',
    `dim_weight_applicable` BOOLEAN COMMENT 'Indicates whether this accessorial charge calculation considers dimensional weight in addition to actual weight. Relevant for oversize or low-density shipments.',
    `dispute_eligible_flag` BOOLEAN COMMENT 'Indicates whether customers can dispute this accessorial charge through the claims or billing dispute process. True if disputable, False if non-disputable.',
    `effective_from_date` DATE COMMENT 'Date from which this accessorial charge definition becomes active and applicable to shipments.',
    `effective_to_date` DATE COMMENT 'Date until which this accessorial charge definition remains active. Null indicates no expiration (open-ended).',
    `geographic_scope` STRING COMMENT 'Geographic applicability of the accessorial charge: domestic (within country), international (cross-border), regional (specific trade lanes or regions), or global (all geographies).. Valid values are `domestic|international|regional|global`',
    `gl_account_code` STRING COMMENT 'General ledger account code to which revenue from this accessorial charge is posted in the financial system.. Valid values are `^[0-9]{4,10}$`',
    `hazmat_class_applicable` STRING COMMENT 'Comma-separated list of hazmat classes (per IMDG, ICAO, or DOT classifications) to which this charge applies. Empty if not hazmat-specific. Used for dangerous goods handling fees.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this accessorial charge definition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accessorial charge record was last updated.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum charge amount that will be applied regardless of calculated value. Caps the accessorial charge at a ceiling value.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount that will be applied regardless of calculated value. Ensures a floor for the accessorial charge.',
    `origin_country_codes` STRING COMMENT 'Comma-separated list of three-letter ISO 3166-1 alpha-3 country codes where this charge applies to shipments originating. Empty if applicable to all origins.',
    `published_tariff_flag` BOOLEAN COMMENT 'Indicates whether this accessorial charge is part of the published tariff available to all customers (True) or is a negotiated/contract-specific charge (False).',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for regulatory tariff filings with governing bodies (e.g., FMC tariff number, IATA resolution reference). Required for published tariffs in regulated markets.',
    `revenue_recognition_category` STRING COMMENT 'Accounting classification for revenue recognition purposes. Determines how the charge is recognized in financial statements.. Valid values are `ancillary_revenue|freight_revenue|service_revenue|handling_revenue`',
    `seasonal_end_date` DATE COMMENT 'End date of the seasonal period during which this charge applies. Null if not seasonal or if seasonal_flag is False.',
    `seasonal_flag` BOOLEAN COMMENT 'Indicates whether this accessorial charge is seasonal or temporary (e.g., peak season surcharge, holiday delivery fee). True if seasonal, False if year-round.',
    `seasonal_start_date` DATE COMMENT 'Start date of the seasonal period during which this charge applies. Null if not seasonal or if seasonal_flag is False.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether the accessorial charge is subject to sales tax, VAT, or GST. True if taxable, False if exempt.',
    `version_number` STRING COMMENT 'Version number of this accessorial charge definition, incremented with each modification. Supports change tracking and audit history.',
    `volume_threshold_applicable` BOOLEAN COMMENT 'Indicates whether volume-based discounts or thresholds apply to this accessorial charge. True if charge amount varies based on shipment volume or customer commitment levels.',
    `waivable_flag` BOOLEAN COMMENT 'Indicates whether this accessorial charge can be waived or discounted at the discretion of sales or operations staff. True if waivable, False if mandatory.',
    `waiver_approval_required` BOOLEAN COMMENT 'Indicates whether waiving this charge requires managerial or executive approval. True if approval is required, False if staff can waive without escalation.',
    `zone_applicable` STRING COMMENT 'Comma-separated list of delivery zones or postal code zones to which this accessorial charge applies (e.g., remote_area, extended_delivery, urban, rural). Empty if not zone-specific.',
    CONSTRAINT pk_accessorial_charge PRIMARY KEY(`accessorial_charge_id`)
) COMMENT 'Master catalog of accessorial and ancillary charges applicable beyond base freight rates, including residential delivery surcharges, address correction fees, signature required fees, hazmat handling fees, oversize/overweight charges, liftgate fees, inside delivery, and COD fees. Captures charge code, charge name, charge category, calculation basis (flat fee, per shipment, per kg, percentage), applicable service types, and effective dates. SSOT for all non-base-rate charge definitions.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` (
    `dim_weight_rule_id` BIGINT COMMENT 'Unique identifier for the dimensional weight calculation rule. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the customer contract under which this dimensional weight rule is defined. Null if this is a standard tariff rule applicable to all customers.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Dimensional weight rules vary by carrier (different divisors: 5000, 6000, etc.). Carrier_id links the rule to the carrier whose policy it represents, enabling accurate chargeable weight calculation pe',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Dim weight rules are segment-specific in logistics (e.g., e-commerce segments use 5000 divisor, standard segments use 6000). The dim_weight_rule.customer_segment plain attribute is a denormalized segm',
    `superseded_by_rule_dim_weight_rule_id` BIGINT COMMENT 'Reference to the dimensional weight rule that replaces this rule when it expires or is superseded, enabling rule version tracking.',
    `tariff_id` BIGINT COMMENT 'Reference to the tariff or rate card structure to which this dimensional weight rule belongs.',
    `applies_to_returns` BOOLEAN COMMENT 'Boolean flag indicating whether this dimensional weight rule applies to return shipments (RMA) or only to forward shipments.',
    `approval_status` STRING COMMENT 'Approval workflow status for the dimensional weight rule, ensuring governance and compliance before activation.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this dimensional weight rule was approved for use in production pricing systems.',
    `commodity_type` STRING COMMENT 'Type or category of commodity to which this dimensional weight rule applies (e.g., general cargo, perishables, high-value goods, dangerous goods).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dimensional weight rule record was first created in the system.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code for the shipment destination to which this rule applies. Empty if rule applies globally.. Valid values are `^[A-Z]{3}$`',
    `destination_region` STRING COMMENT 'Geographic region or trade lane destination classification to which this rule applies (e.g., North America, Europe, Asia Pacific, Middle East).',
    `dim_factor` DECIMAL(18,2) COMMENT 'Volumetric divisor used to calculate dimensional weight from package dimensions. Common values: 5000 for air freight (cm³/kg), 6000 for express (cm³/kg), 4000 for premium express. Formula: DIM Weight = (Length × Width × Height) / DIM Factor.',
    `effective_date` DATE COMMENT 'Date from which this dimensional weight rule becomes active and applicable to shipment pricing calculations.',
    `expiration_date` DATE COMMENT 'Date on which this dimensional weight rule ceases to be active. Null if the rule has no defined end date.',
    `incoterm` STRING COMMENT 'International Commercial Terms code defining the allocation of costs and risks between buyer and seller, which may influence dimensional weight charge allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_default_rule` BOOLEAN COMMENT 'Boolean flag indicating whether this is the default dimensional weight rule applied when no more specific rule matches the shipment criteria.',
    `length_unit` STRING COMMENT 'Unit of measure for package length dimension used in the dimensional weight calculation (centimeters, inches, or meters).. Valid values are `cm|in|m`',
    `maximum_chargeable_weight` DECIMAL(18,2) COMMENT 'Maximum weight threshold above which the dimensional weight rule does not apply or special handling is required, expressed in the weight unit of measure.',
    `minimum_chargeable_weight` DECIMAL(18,2) COMMENT 'Minimum weight threshold below which the dimensional weight rule does not apply or a floor chargeable weight is enforced, expressed in the weight unit of measure.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this dimensional weight rule record was last modified, supporting audit trail and change tracking requirements.',
    `notes` STRING COMMENT 'Free-text field for additional business notes, special instructions, or context regarding the application of this dimensional weight rule.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code for the shipment origin to which this rule applies. Empty if rule applies globally.. Valid values are `^[A-Z]{3}$`',
    `origin_region` STRING COMMENT 'Geographic region or trade lane origin classification to which this rule applies (e.g., North America, Europe, Asia Pacific, Middle East).',
    `packaging_type` STRING COMMENT 'Type of packaging to which this rule applies (e.g., parcel, pallet, container, crate, envelope), as packaging affects dimensional weight applicability.',
    `priority_rank` STRING COMMENT 'Priority ranking used to resolve conflicts when multiple dimensional weight rules could apply to the same shipment. Lower numbers indicate higher priority.',
    `rounding_method` STRING COMMENT 'Method used to round the calculated dimensional weight to determine chargeable weight (round up to next whole unit, round down, round to nearest, or round half up).. Valid values are `round_up|round_down|round_nearest|round_half_up`',
    `rounding_precision` DECIMAL(18,2) COMMENT 'Precision to which the dimensional weight is rounded (e.g., 0.5 for half-kilogram increments, 1.0 for whole kilogram increments).',
    `rule_code` STRING COMMENT 'Business identifier code for the dimensional weight rule, used for external reference and system integration.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rule_description` STRING COMMENT 'Detailed explanation of the dimensional weight calculation rule, including business context and application scenarios.',
    `rule_name` STRING COMMENT 'Descriptive name of the dimensional weight rule for business user identification and reporting purposes.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the dimensional weight rule indicating whether it is actively applied in pricing calculations.. Valid values are `active|inactive|pending|expired|superseded`',
    `service_type` STRING COMMENT 'Specific service type or product line to which this rule applies (e.g., Next Day Air, International Express, Standard Ground, Economy Ocean FCL).',
    `transport_mode` STRING COMMENT 'Mode of transportation to which this dimensional weight rule applies (air freight, ocean freight, road transport, rail transport, express parcel, or multimodal).. Valid values are `air|ocean|road|rail|express|multimodal`',
    `unit_system` STRING COMMENT 'Measurement system used for dimensional weight calculation: metric (centimeters and kilograms) or imperial (inches and pounds).. Valid values are `metric|imperial`',
    `version_number` STRING COMMENT 'Version number of this dimensional weight rule, incremented with each modification to support change tracking and audit requirements.',
    `weight_unit` STRING COMMENT 'Unit of measure for weight used in the dimensional weight calculation and comparison with actual weight (kilograms, pounds, or grams).. Valid values are `kg|lb|g`',
    CONSTRAINT pk_dim_weight_rule PRIMARY KEY(`dim_weight_rule_id`)
) COMMENT 'Dimensional weight (DIM weight) calculation rules defining the volumetric divisor and rounding conventions applied per service type, transport mode, and customer segment. Captures DIM factor (e.g., 5000 for air, 4000 for express), unit system (metric/imperial), rounding method, minimum chargeable weight, applicable service codes, and effective date range. Critical for revenue integrity in express parcel and air freight pricing where chargeable weight = max(actual weight, DIM weight).';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` (
    `spot_quote_id` BIGINT COMMENT 'Unique identifier for the spot quote. Primary key for the spot quote entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Spot quotes often reference existing customer agreements for pricing context, credit terms, service scope, and payment terms. Linking enables agreement-aware quoting, supports credit limit enforcement',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Spot quotes are typically for a specific carriers service. Sales teams need carrier_id for capacity confirmation, service availability validation, and SLA communication. Essential for quote-to-bookin',
    `consignee_id` BIGINT COMMENT 'Identifier of the consignee party receiving the goods at destination. Used for delivery coordination and customs clearance.',
    `consignee_profile_id` BIGINT COMMENT 'Foreign key linking to customer.consignee_profile. Business justification: Spot quotes for DDP or door-to-door shipments require consignee-specific data (delivery window, DDP authorization, signature requirements) from the consignee_profile to accurately price last-mile char',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer or prospect requesting the spot quote. Links to the customer master for account details and relationship history.',
    `dim_weight_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.dim_weight_rule. Business justification: spot_quote captures dim_weight_kg and chargeable_weight_kg, indicating DIM weight calculations are applied during quoting. Adding dim_weight_rule_id links the spot quote to the specific DIM weight rul',
    `agent_id` BIGINT COMMENT 'Identifier of the sales agent, pricing analyst, or customer service representative who prepared and issued the spot quote. Used for performance tracking and commission calculation.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Spot quotes price specific lane movements. Lane_id captures the quoted route, enabling quote-to-lane analysis, win/loss tracking by lane, and spot rate benchmarking against lane performance.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: A spot quote, while issued outside standard contracts, is typically based on or benchmarked against a published rate card. Adding rate_card_id to spot_quote allows the system to trace which rate card ',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to procurement.rfq. Business justification: Spot quotes for non-contracted lanes often originate from RFQ processes. Business need: procurement analytics track quote-to-RFQ conversion rates and sourcing event effectiveness for capacity planning',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Spot quotes can price corridor movements (multi-leg international). Service_corridor_id captures multi-leg quoted routes, enabling corridor-level quote analysis and win/loss tracking for complex movem',
    `shipper_profile_id` BIGINT COMMENT 'Identifier of the shipper party responsible for tendering the goods. May differ from the customer if the customer is acting as a freight forwarder or broker.',
    `supplier_quote_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_quote. Business justification: Links customer-facing spot quotes to supplier quotes received during procurement. Business need: margin analysis compares sell-side pricing to buy-side costs; quote comparison reports for pricing stra',
    `base_freight_rate` DECIMAL(18,2) COMMENT 'Core transportation charge per unit (per kg, per TEU, per shipment) before surcharges and accessorial fees. Foundation of the all-in quoted rate.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The greater of gross weight or dimensional weight, used as the basis for freight rate calculation. Ensures carriers are compensated fairly for both heavy and bulky shipments.',
    `commodity_description` STRING COMMENT 'General description of the goods being shipped. Used for rate classification, dangerous goods screening, and customs documentation.',
    `container_type` STRING COMMENT 'Type and size of container for ocean freight shipments. Common types include 20GP (20-foot General Purpose), 40GP, 40HC (High Cube), 20RF (Reefer), or LCL (Less than Container Load) for consolidated cargo. [ENUM-REF-CANDIDATE: 20GP|40GP|40HC|45HC|20RF|40RF|20OT|40OT|LCL — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the spot quote record was first created in the system. Used for audit trail and quote aging analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the quote (e.g., USD, EUR, GBP). Used for financial reporting and multi-currency rate management.. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_fee` DECIMAL(18,2) COMMENT 'Fee for customs brokerage services including declaration preparation, duty calculation, and regulatory filings (AMS, ISF). Applicable for cross-border shipments.',
    `delivery_date` DATE COMMENT 'Estimated or committed date for cargo delivery at destination. Used for customer planning and OTD (On-Time Delivery) performance measurement.',
    `dim_weight_kg` DECIMAL(18,2) COMMENT 'Volumetric weight calculated by applying the dimensional weight factor (typically 167 or 200 for air, 333 for ocean LCL) to the shipment volume. Used to determine chargeable weight for low-density cargo.',
    `documentation_fee` DECIMAL(18,2) COMMENT 'Administrative charge for preparation and processing of shipping documents including AWB (Air Waybill), BOL (Bill of Lading), commercial invoice, packing list, and certificate of origin.',
    `estimated_transit_days` STRING COMMENT 'Expected number of calendar days from origin pickup to destination delivery. Used for customer planning and SLA (Service Level Agreement) commitments.',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Variable surcharge to offset fluctuations in fuel costs. Typically calculated as a percentage of base freight or a fixed amount per unit. Also known as BAF (Bunker Adjustment Factor) for ocean freight.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment including packaging, expressed in kilograms. Used as one input for chargeable weight calculation.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the commodity. Used for customs clearance, duty calculation, and trade compliance. Typically 6-10 digits depending on jurisdiction.. Valid values are `^[0-9]{6,10}$`',
    `incoterm` STRING COMMENT 'International Commercial Terms rule governing the allocation of costs, risks, and responsibilities between buyer and seller. Determines which charges are included in the quoted price. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_premium` DECIMAL(18,2) COMMENT 'Optional cargo insurance premium to cover loss or damage during transit. Typically calculated as a percentage of declared cargo value.',
    `is_dangerous_goods` BOOLEAN COMMENT 'Flag indicating whether the shipment contains dangerous goods (DG) requiring special handling, packaging, labeling, and documentation per IMDG (International Maritime Dangerous Goods) or IATA (International Air Transport Association) regulations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the spot quote record was last updated. Used for audit trail and change tracking.',
    `pickup_date` DATE COMMENT 'Requested or scheduled date for cargo pickup at origin. Used for capacity planning and operational scheduling.',
    `piece_count` STRING COMMENT 'Total number of individual pieces, packages, or handling units in the shipment. Used for handling charges and operational planning.',
    `quote_issued_timestamp` TIMESTAMP COMMENT 'Date and time when the spot quote was formally issued to the customer. Marks the start of the validity period and SLA (Service Level Agreement) measurement for quote response time.',
    `quote_number` STRING COMMENT 'Externally-visible unique business identifier for the spot quote, typically formatted as SQ followed by numeric sequence. Used for customer communication and reference.. Valid values are `^SQ[0-9]{8,12}$`',
    `quote_request_date` DATE COMMENT 'Date when the customer or prospect submitted the request for quotation. Used to track response time and quote aging.',
    `quote_source` STRING COMMENT 'Channel or system through which the quote request was received. Used for channel effectiveness analysis and digital transformation tracking.. Valid values are `web_portal|email|phone|api|crm|rfq`',
    `quote_status` STRING COMMENT 'Current lifecycle status of the spot quote. Tracks progression from draft through issuance to final disposition (accepted, expired, rejected, or cancelled).. Valid values are `draft|issued|accepted|expired|rejected|cancelled`',
    `quote_valid_from_date` DATE COMMENT 'Start date of the quote validity period. The quoted rates are guaranteed from this date.',
    `quote_valid_until_date` DATE COMMENT 'Expiration date of the quote validity period. After this date, the quoted rates are no longer guaranteed and the quote status typically transitions to expired.',
    `sales_office_code` STRING COMMENT 'Code identifying the sales office or branch that issued the quote. Used for regional performance reporting and revenue allocation.. Valid values are `^[A-Z0-9]{3,6}$`',
    `security_surcharge_amount` DECIMAL(18,2) COMMENT 'Charge to cover security screening, compliance programs (C-TPAT, AEO), and regulatory security requirements. Common in air and ocean freight.',
    `service_level` STRING COMMENT 'Speed and priority tier of the quoted service. Impacts pricing, transit time commitments, and SLA (Service Level Agreement) guarantees.. Valid values are `express|standard|economy|deferred|same_day|next_day`',
    `shipment_type` STRING COMMENT 'Classification of shipment based on load consolidation. FCL (Full Container Load) and FTL (Full Truckload) are dedicated, while LCL (Less than Container Load) and LTL (Less Than Truckload) are consolidated with other shippers cargo.. Valid values are `FCL|LCL|FTL|LTL|parcel|pallet`',
    `special_instructions` STRING COMMENT 'Free-text field for customer-specific handling requirements, delivery instructions, or operational notes that affect pricing or service delivery.',
    `terminal_handling_charge` DECIMAL(18,2) COMMENT 'Fee for cargo handling at the origin or destination terminal, including loading, unloading, and container yard operations. Common in ocean freight.',
    `total_quoted_amount` DECIMAL(18,2) COMMENT 'All-in total price quoted to the customer, including base freight, all surcharges, accessorial fees, and applicable taxes. This is the final amount the customer will pay if the quote is accepted.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for the quoted shipment. Determines applicable rate structures, transit times, and regulatory requirements.. Valid values are `air|ocean|road|rail|multimodal|courier`',
    `un_number` STRING COMMENT 'Four-digit UN identification number for dangerous goods. Required for DG (Dangerous Goods) shipments to identify the specific hazardous material.. Valid values are `^UN[0-9]{4}$`',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the shipment expressed in cubic meters. Used for volumetric weight calculation and capacity planning.',
    CONSTRAINT pk_spot_quote PRIMARY KEY(`spot_quote_id`)
) COMMENT 'Transactional spot quote issued to a customer or prospect for a specific shipment request outside standing contract rates. Captures quote reference, requesting customer, origin/destination, transport mode, commodity, weight, volume, chargeable weight, quoted all-in rate, itemized charges (via spot_quote_line), validity period, quote status (draft/issued/accepted/expired/rejected), issuing agent, and DIM weight calculation applied. SSOT for ad-hoc pricing events. Feeds billing and contract domains for revenue recognition and potential contract conversion.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` (
    `spot_quote_line_id` BIGINT COMMENT 'Unique identifier for the spot quote line item. Primary key.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Each spot quote line may use a different carrier service (main haul vs last mile). Carrier_service_id links the charge to the specific service being priced, replacing the generic unlinked service_prov',
    `charge_code_id` BIGINT COMMENT 'Foreign key linking to pricing.charge_code. Business justification: Spot quote line items reference specific charge codes for each component of the quoted price (base freight, fuel surcharge, THC, documentation fee, etc.). Currently uses STRING business key reference;',
    `rate_line_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_line. Business justification: A spot_quote_line is an individual charge component of a spot quote. When the quote is based on a rate card, each line item corresponds to a specific rate_line from that rate card. Adding rate_line_id',
    `spot_quote_id` BIGINT COMMENT 'Reference to the parent spot quote header. Links this line item to the overall quote.',
    `billable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this charge line is billable to the customer (True) or non-billable/informational (False). Non-billable lines may represent internal costs, waived charges, or informational breakdowns.',
    `charge_category` STRING COMMENT 'High-level categorization of the charge for grouping and reporting purposes. Classifies charges into freight, surcharges, accessorial services, origin/destination charges, customs fees, insurance, handling, documentation, storage, or other. [ENUM-REF-CANDIDATE: freight|surcharge|accessorial|origin_charge|destination_charge|customs_fee|insurance|handling|documentation|storage|other — 11 candidates stripped; promote to reference product]',
    `charge_description` STRING COMMENT 'Detailed human-readable description of the charge line item. Provides clarity on what the charge covers, such as Base Ocean Freight - FCL 20ft, Fuel Surcharge - 15%, Terminal Handling Charge - Origin Port, or Customs Clearance Fee.',
    `charge_type` STRING COMMENT 'Specific type of charge within the category. Provides granular classification such as base freight, fuel surcharge (FSC), terminal handling charge (THC), bunker adjustment factor (BAF), general rate increase (GRI), security fees, customs duties, customs clearance, origin pickup, destination delivery, warehousing, insurance premium, documentation fees, inspection fees, demurrage, detention, or other. [ENUM-REF-CANDIDATE: base_freight|fuel_surcharge|terminal_handling|bunker_adjustment|general_rate_increase|security_fee|customs_duty|customs_clearance|origin_pickup|destination_delivery|warehousing|insurance_premium|documentation_fee|inspection_fee|demurrage|detention|other — 17 candidates stripped; promote to reference product]',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Chargeable weight in kilograms used for rate calculation. The greater of actual weight or dimensional (DIM) weight. Determines the weight basis for freight charges.',
    `commodity_code` STRING COMMENT 'Harmonized System (HS) code or other commodity classification code relevant to this charge. Used for customs duties, tariff classification, and regulatory compliance. Applicable when the charge is commodity-specific.',
    `container_type` STRING COMMENT 'Type of container for container-based charges. Examples: 20GP (20-foot General Purpose), 40GP (40-foot General Purpose), 40HC (40-foot High Cube), 45HC (45-foot High Cube), 20RF (20-foot Refrigerated), 40RF (40-foot Refrigerated), 20OT (20-foot Open Top), 40OT (40-foot Open Top), 20FR (20-foot Flat Rack), 40FR (40-foot Flat Rack). Applicable for FCL (Full Container Load) shipments. [ENUM-REF-CANDIDATE: 20GP|40GP|40HC|45HC|20RF|40RF|20OT|40OT|20FR|40FR — 10 candidates stripped; promote to reference product]',
    `cost_allocation_party` STRING COMMENT 'Party responsible for paying this charge as per the Incoterm and contract terms. Identifies whether the shipper, consignee, carrier, a third party, or shared responsibility applies to this charge line.. Valid values are `shipper|consignee|carrier|third_party|shared`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this spot quote line record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line amount. Examples: USD, EUR, GBP, CNY, JPY. Indicates the currency in which this charge is quoted.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Code identifying the destination location for this charge. May be a UN/LOCODE, IATA airport code, or internal location identifier. Relevant for destination-specific charges such as destination terminal handling or delivery fees.',
    `dim_weight_factor` DECIMAL(18,2) COMMENT 'Dimensional weight factor applied to calculate chargeable weight for this line. Commonly 5000 or 6000 for air freight (dividing volume in cubic centimeters by this factor to get kg). Used when dimensional weight exceeds actual weight.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount applied to this charge line item. Represents negotiated discounts, promotional reductions, or volume-based adjustments specific to this line.',
    `equipment_type` STRING COMMENT 'Type of equipment or packaging associated with this charge. Examples: container, pallet, crate, box, drum, bag, roll, bundle, or other. Relevant for handling and accessorial charges. [ENUM-REF-CANDIDATE: container|pallet|crate|box|drum|bag|roll|bundle|other — 9 candidates stripped; promote to reference product]',
    `included_in_all_in_rate_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this charge is included in the all-in quoted rate (True) or quoted separately as an additional charge (False). Enables transparency in pricing structure and supports itemized billing reconciliation.',
    `incoterm` STRING COMMENT 'Incoterm applicable to this charge line, determining the allocation of costs and risks between buyer and seller. Examples: EXW (Ex Works), FCA (Free Carrier), CPT (Carriage Paid To), CIP (Carriage and Insurance Paid To), DAP (Delivered at Place), DPU (Delivered at Place Unloaded), DDP (Delivered Duty Paid), FAS (Free Alongside Ship), FOB (Free on Board), CFR (Cost and Freight), CIF (Cost Insurance and Freight). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `line_amount` DECIMAL(18,2) COMMENT 'Total amount for this charge line item before taxes and adjustments. Calculated as quantity multiplied by unit_rate, adjusted for any line-level discounts or surcharges.',
    `line_number` STRING COMMENT 'Sequential line number within the spot quote. Determines the display order of charge line items.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this spot quote line record was last modified. Supports audit trail and change tracking.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount for this charge line after applying discounts and taxes. Calculated as line_amount minus discount_amount plus tax_amount. Represents the final billable amount for this line.',
    `notes` STRING COMMENT 'Free-text notes or comments specific to this charge line. Provides additional context, explanations, or special instructions related to the charge.',
    `origin_location_code` STRING COMMENT 'Code identifying the origin location for this charge. May be a UN/LOCODE, IATA airport code, or internal location identifier. Relevant for origin-specific charges such as origin terminal handling or pickup fees.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of units to which the charge applies. For example, 2 containers, 1500 kg, 10 CBM, or 1 shipment. Used in conjunction with unit_of_measure and unit_rate to calculate the total charge amount.',
    `rate_basis` STRING COMMENT 'Basis on which the rate is calculated. Defines the pricing structure: per shipment, per container, per TEU, per kilogram, per CBM, per pallet, per package, per hour, per day, flat rate, or as a percentage of another charge. Aligns with unit_of_measure. [ENUM-REF-CANDIDATE: per_shipment|per_container|per_teu|per_kg|per_cbm|per_pallet|per_package|per_hour|per_day|flat_rate|percentage — 11 candidates stripped; promote to reference product]',
    `rate_effective_date` DATE COMMENT 'Date from which the rate for this charge line is effective. Supports rate versioning and ensures correct pricing based on quote date.',
    `rate_expiry_date` DATE COMMENT 'Date until which the rate for this charge line is valid. After this date, the rate may change or require re-negotiation. Null if the rate has no expiry.',
    `rate_source` STRING COMMENT 'Source of the rate applied to this charge line. Indicates whether the rate comes from a contract, tariff, spot market, negotiated agreement, published rate card, or market rate. Supports audit and pricing transparency.. Valid values are `contract|tariff|spot|negotiated|published|market`',
    `service_level` STRING COMMENT 'Service level associated with this charge line. Defines the speed and priority of service: express, standard, economy, same-day, next-day, or deferred. Impacts pricing and SLA commitments.. Valid values are `express|standard|economy|same_day|next_day|deferred`',
    `service_provider_name` STRING COMMENT 'Name of the service provider or vendor associated with this charge line. Provides human-readable identification of the party delivering the service.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this charge line item. Includes VAT, GST, sales tax, or other applicable taxes based on jurisdiction and charge type.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate percentage applied to this charge line. Expressed as a percentage (e.g., 20.00 for 20% VAT). Used to calculate tax_amount from line_amount.',
    `transport_mode` STRING COMMENT 'Mode of transportation for this charge line. Examples: air, ocean, road, rail, multimodal, or courier. Determines applicable rates, surcharges, and regulatory requirements.. Valid values are `air|ocean|road|rail|multimodal|courier`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the charge calculation. Defines how the charge is quantified: per shipment, per container, per TEU (Twenty-foot Equivalent Unit), per CBM (Cubic Meter), per kilogram, per pound, per pallet, per package, per hour, per day, flat rate, or as a percentage of another charge. [ENUM-REF-CANDIDATE: shipment|container|teu|cbm|kg|lb|pallet|package|hour|day|flat|percentage — 12 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate charged per unit of measure. The price per unit (e.g., $1500 per TEU, $0.50 per kg, $200 per CBM). Multiplied by quantity to derive the line amount before adjustments.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Volume in cubic meters (CBM) associated with this charge line. Relevant for volume-based charges in ocean freight (LCL) or air freight. Used in dimensional weight calculations and volume-based pricing.',
    `weight_break_max_kg` DECIMAL(18,2) COMMENT 'Maximum weight threshold in kilograms for this charge rate tier. Used in weight-based pricing structures where rates vary by weight bracket. Null if not applicable or if this is the highest tier.',
    `weight_break_min_kg` DECIMAL(18,2) COMMENT 'Minimum weight threshold in kilograms for this charge rate tier. Used in weight-based pricing structures where rates vary by weight bracket. Null if not applicable.',
    CONSTRAINT pk_spot_quote_line PRIMARY KEY(`spot_quote_line_id`)
) COMMENT 'Individual charge line item within a spot quote, detailing each component of the quoted price including base freight, fuel surcharge, THC, origin/destination charges, customs fees, and accessorial charges. Captures charge type, charge description, unit of measure, quantity, unit rate, total amount, currency, and whether the charge is included in the all-in rate or quoted separately. Enables full cost transparency and itemized billing reconciliation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` (
    `contract_rate_id` BIGINT COMMENT 'Unique identifier for the contract rate record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent service contract or rate agreement under which this rate is negotiated.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Contract rates are negotiated with specific carriers. Carrier_id is essential for routing decisions, margin analysis against carrier buy rates, and contract compliance monitoring. Core to contract rat',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Contract rates should specify the exact carrier service they apply to (not just carrier). This precision is required for automated rating systems to match customer service selection to contracted rate',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for whom this contract rate applies.',
    `dim_weight_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.dim_weight_rule. Business justification: contract_rate has dim_weight_divisor: INT, which is the DIM weight calculation divisor for the contracted rate. This is exactly what dim_weight_rule captures. Adding dim_weight_rule_id normalizes this',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Contract rates negotiate pricing for specific customer lanes. Lane_id anchors contracted pricing to network routes, enabling contract rate application during shipment rating and customer billing.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Contract pricing analysts track which published rate card served as baseline for negotiated contract rates to calculate discount percentages, maintain rate floor compliance, and justify pricing during',
    `rate_line_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_line. Business justification: A contract_rate is a negotiated rate that is often derived from or benchmarked against a specific rate_line within the referenced rate_card. contract_rate already has rate_card_id; adding rate_line_id',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Contract rates can cover entire corridors (e.g., trans-Pacific service). Service_corridor_id anchors contracted corridor pricing, enabling corridor-level rate application for multi-leg contracted move',
    `shipper_profile_id` BIGINT COMMENT 'Foreign key linking to customer.shipper_profile. Business justification: Contract rates are negotiated for specific shippers. The rating engine applies contracted rates by resolving shipper_profile at booking time. Linking contract_rate→shipper_profile enables direct contr',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Contract rates often reference published tariffs as baseline or fallback. Linking supports regulatory compliance, enables rate justification for audits, and facilitates tariff-based contract rate upda',
    `transit_time_standard_id` BIGINT COMMENT 'Foreign key linking to route.transit_time_standard. Business justification: Contracted rates include negotiated transit time commitments. Linking enables SLA compliance validation, rate-vs-performance analysis, and contract breach identification. Essential for customer contra',
    `approval_date` DATE COMMENT 'Date on which this contract rate was approved by the authorizing authority.',
    `approval_status` STRING COMMENT 'Approval workflow status for rates requiring management authorization (e.g., below-floor rates, emergency rates, special commodity rates).. Valid values are `not_required|pending|approved|rejected`',
    `base_rate` DECIMAL(18,2) COMMENT 'Negotiated base rate amount per unit as defined by rate_basis, excluding surcharges and accessorial charges.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract rate record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the rate is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether this rate represents a deviation from standard pricing policy (e.g., below-floor approval, emergency rate, special commodity exception).',
    `deviation_reason` STRING COMMENT 'Business justification for rate deviation, including reason code and narrative explanation (e.g., competitive match, strategic account, volume commitment, market conditions).',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied off the published tariff rate to arrive at this contract rate.',
    `effective_end_date` DATE COMMENT 'Date on which this contract rate expires and is no longer valid for new shipments. Null indicates open-ended validity.',
    `effective_start_date` DATE COMMENT 'Date from which this contract rate becomes valid and can be applied to shipments.',
    `floor_rate` DECIMAL(18,2) COMMENT 'Minimum allowable rate threshold below which special approval is required. Used for deviation tracking and margin protection.',
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a fuel surcharge (BAF for ocean, fuel surcharge for air/road) is applicable on top of the base rate.',
    `gri_applicable` BOOLEAN COMMENT 'Indicates whether General Rate Increase adjustments apply to this contract rate.',
    `incoterm` STRING COMMENT 'Incoterms rule governing the allocation of costs, risks, and responsibilities between buyer and seller (e.g., EXW, FOB, CIF, DDP, DAP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum charge cap that applies to a shipment under this contract rate, if applicable.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount that applies to a shipment under this contract rate, regardless of weight or volume.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this contract rate record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract rate record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional rate terms, conditions, restrictions, or operational instructions relevant to this contract rate.',
    `priority_level` STRING COMMENT 'Priority classification of the customer or rate agreement (standard, preferred, strategic, VIP) affecting rate application precedence.. Valid values are `standard|preferred|strategic|vip`',
    `rate_basis` STRING COMMENT 'Unit of measure on which the rate is calculated (e.g., per kilogram, per cubic meter, per TEU, per shipment, per pallet, per unit).. Valid values are `per_kg|per_cbm|per_teu|per_shipment|per_pallet|per_unit`',
    `rate_code` STRING COMMENT 'Business identifier for the contract rate, used for billing and operational reference.',
    `rate_name` STRING COMMENT 'Descriptive name of the contract rate for business user identification.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the contract rate (draft, pending approval, active, suspended, expired, terminated).. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `rate_type` STRING COMMENT 'Classification of the rate by its commercial nature (standard contract rate, promotional rate, spot quote rate, emergency rate, seasonal rate).. Valid values are `standard|promotional|spot|emergency|seasonal`',
    `service_type` STRING COMMENT 'Type of service covered by this contract rate (e.g., express, standard, economy, same-day, next-day, deferred).. Valid values are `express|standard|economy|same_day|next_day|deferred`',
    `shipment_type` STRING COMMENT 'Type of shipment covered by this rate: parcel, freight, LTL (Less Than Truckload), FTL (Full Truckload), FCL (Full Container Load), LCL (Less Than Container Load).. Valid values are `parcel|freight|ltl|ftl|fcl|lcl`',
    `thc_included` BOOLEAN COMMENT 'Indicates whether Terminal Handling Charges are included in the base rate or billed separately.',
    `transport_mode` STRING COMMENT 'Mode of transportation for which this rate applies (air, ocean, road, rail, multimodal).. Valid values are `air|ocean|road|rail|multimodal`',
    `volume_commitment_min` DECIMAL(18,2) COMMENT 'Minimum volume commitment (in units defined by rate_basis) that the customer must meet to qualify for this contract rate.',
    `weight_break_max` DECIMAL(18,2) COMMENT 'Maximum weight threshold (in kilograms or pounds) for which this rate applies, used in tiered pricing structures.',
    `weight_break_min` DECIMAL(18,2) COMMENT 'Minimum weight threshold (in kilograms or pounds) for which this rate applies, used in tiered pricing structures.',
    `created_by` STRING COMMENT 'User identifier or system account that created this contract rate record.',
    CONSTRAINT pk_contract_rate PRIMARY KEY(`contract_rate_id`)
) COMMENT 'Negotiated contract-specific rate agreed with a customer under a service contract or rate agreement. Captures contract reference, customer account, origin-destination lane, service type, transport mode, commodity, negotiated rate, discount percentage off tariff, minimum volume commitment, rate validity period, approval status, and deviation tracking (below-floor approvals, emergency rates, special commodity rates with business justification and approving authority). Distinct from published tariffs and spot quotes — represents the binding commercial rate for a specific customer relationship. Feeds billing domain for invoice generation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` (
    `rate_rule_id` BIGINT COMMENT 'Primary key for rate_rule',
    `charge_code_id` BIGINT COMMENT 'Foreign key linking to pricing.charge_code. Business justification: Pricing rules define automated rate adjustment logic based on specific charge types. The rule must reference the authoritative charge code definition to determine applicability, calculation basis, rev',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: rate_rule defines dynamic pricing adjustment logic and conditional pricing triggers. These rules are typically scoped to a specific rate card — they define how rates within that card are adjusted base',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Rate rules are applied by customer segment in logistics pricing engines (e.g., e-commerce segment gets volume discount rules, enterprise segment gets GRI waivers). The rate_rule.customer_tier plain at',
    `adjustment_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for flat amount adjustments. Null for percentage and multiplier adjustment types.. Valid values are `^[A-Z]{3}$`',
    `adjustment_type` STRING COMMENT 'Method by which the rule modifies the base rate: flat amount (fixed currency value), percentage (of base rate), tiered (stepped based on volume/weight), or multiplier (factor applied to base).. Valid values are `flat_amount|percentage|tiered|multiplier`',
    `adjustment_value` DECIMAL(18,2) COMMENT 'Numeric value defining the magnitude of the rate adjustment. Interpretation depends on adjustment_type: currency amount for flat, percentage for percentage, multiplier for multiplier.',
    `applicable_incoterm` STRING COMMENT 'Incoterms to which this rule applies, controlling charge allocation between shipper and consignee. Pipe-separated if multiple. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `applicable_service_mode` STRING COMMENT 'Transportation mode(s) to which this rule applies. Pipe-separated list if multiple. [ENUM-REF-CANDIDATE: air|ocean|road|rail|intermodal|express_parcel|LTL|FTL|FCL|LCL — promote to reference product]',
    `applicable_trade_lane` STRING COMMENT 'Geographic trade lane or route corridor to which this rule applies (e.g., Asia-Europe, Transpacific Eastbound, US Domestic). Null if rule is global.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether application of this rule requires manual approval by pricing manager before being applied to customer quotes or invoices. Used for high-value discounts and exceptions.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the rule was approved for activation. Null if approval not required or rule is in draft status.',
    `approved_by` STRING COMMENT 'User ID or name of the pricing manager or authorized approver who approved this rule for activation. Null if approval not required or rule is in draft status.',
    `business_justification` STRING COMMENT 'Rationale for creating this pricing rule, including market conditions, competitive positioning, cost recovery objectives, or strategic customer retention goals.',
    `commodity_hs_code` STRING COMMENT 'Harmonized System tariff classification code for commodities to which this rule applies. Used for commodity-specific surcharges (e.g., hazardous materials, refrigerated cargo). Null if rule is commodity-agnostic.. Valid values are `^[0-9]{6,10}$`',
    `compound_rule_flag` BOOLEAN COMMENT 'Indicates whether this rule can be combined with other rules (true) or is mutually exclusive (false). Controls rule stacking behavior in the rating engine.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing rule record was first created in the system.',
    `destination_region_code` STRING COMMENT 'ISO country or region code for shipment destination to which this rule applies. Null if rule is destination-agnostic.. Valid values are `^[A-Z]{2,3}$`',
    `dim_weight_factor` DECIMAL(18,2) COMMENT 'Volumetric weight conversion factor applied by this rule for DIM weight pricing calculations. Standard factors: 5000 for ocean, 6000 for air (CBM to KG). Null if rule does not involve DIM weight.',
    `effective_from_date` DATE COMMENT 'Date when the pricing rule becomes active and eligible for application in rate calculations. Aligns with GRI (General Rate Increase) and BAF (Bunker Adjustment Factor) effective dates.',
    `effective_to_date` DATE COMMENT 'Date when the pricing rule expires and is no longer applied in rate calculations. Nullable for open-ended rules.',
    `external_rule_code` STRING COMMENT 'Unique identifier for this pricing rule in the source operational system. Used for data lineage and reconciliation with SAP TM or Oracle TMS.',
    `maximum_threshold_value` DECIMAL(18,2) COMMENT 'Upper bound value beyond which the rule no longer applies or transitions to next tier. Used for tiered pricing structures.',
    `minimum_threshold_value` DECIMAL(18,2) COMMENT 'Lower bound value that must be met for the rule to apply. Used for volume discounts (minimum TEU, CBM, weight) or minimum charge thresholds.',
    `origin_region_code` STRING COMMENT 'ISO country or region code for shipment origin to which this rule applies. Null if rule is origin-agnostic.. Valid values are `^[A-Z]{2,3}$`',
    `priority_order` STRING COMMENT 'Execution sequence number determining the order in which multiple applicable rules are evaluated and applied. Lower numbers execute first. Critical for cascading discount and surcharge logic.',
    `proration_method` STRING COMMENT 'Method for prorating charges when rule is applied mid-period or to partial volumes. Used for contract pricing and subscription-based logistics services.. Valid values are `daily|monthly|per_shipment|none`',
    `rule_code` STRING COMMENT 'Externally-known unique business identifier for the pricing rule used in SAP TM charge calculation engine and rate management systems.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `rule_description` STRING COMMENT 'Detailed business explanation of the pricing rule purpose, calculation logic, and intended use cases. Provides context for pricing analysts and auditors.',
    `rule_name` STRING COMMENT 'Human-readable name of the pricing rule describing its business purpose (e.g., Volume Discount - Asia Pacific FCL, Peak Season Surcharge Q4).',
    `rule_status` STRING COMMENT 'Current lifecycle state of the pricing rule. Only active rules are executed by the rating engine during freight order charge calculation.. Valid values are `draft|active|suspended|expired|archived`',
    `rule_type` STRING COMMENT 'Classification of the pricing rule defining the category of rate adjustment logic applied. Determines which calculation engine module processes the rule in SAP TM.. Valid values are `volume_discount|lane_based_adjustment|customer_tier_discount|peak_surcharge|promotional_rate|fuel_surcharge`',
    `source_system` STRING COMMENT 'Operational system of record where this pricing rule was originally created and is maintained (e.g., SAP TM, Oracle TMS, Custom Rating Engine).',
    `threshold_unit` STRING COMMENT 'Unit of measure for minimum and maximum threshold values. Aligns with standard logistics units: TEU (Twenty-foot Equivalent Unit), CBM (Cubic Meter), weight units, or shipment count.. Valid values are `TEU|CBM|KG|LBS|SHIPMENT|PALLET`',
    `trigger_condition` STRING COMMENT 'Business logic expression defining when the rule is applicable. May reference shipment attributes (weight, volume, TEU, origin, destination, service level, customer tier, commodity HS code). Evaluated by SAP TM rules engine.',
    `updated_by` STRING COMMENT 'User ID or name of the pricing analyst or system user who last modified this pricing rule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing rule record was last modified.',
    `version_number` STRING COMMENT 'Version sequence number for this pricing rule. Incremented each time the rule is modified. Supports audit trail and rollback capabilities.',
    CONSTRAINT pk_rate_rule PRIMARY KEY(`rate_rule_id`)
) COMMENT 'Dynamic pricing rule defining automated rate adjustment logic, conditional pricing triggers, and business rules governing how rates are calculated or modified. Captures rule name, rule type (volume discount, lane-based adjustment, customer tier discount, peak surcharge, promotional rate), trigger conditions, adjustment type (flat, percentage, tiered), priority order, effective dates, and active status. Enables rule-based pricing engine execution in SAP TM charge calculation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` (
    `lane_rate_zone_id` BIGINT COMMENT 'Unique identifier for the lane rate zone definition. Primary key.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Zone-based rates reference the lanes they apply to. Lane_id links zone pricing to network lanes, enabling zone-to-lane rate lookup for postal code-based rating and remote area surcharge application.',
    `route_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to route.route_delivery_zone. Business justification: Lane rate zones define pricing boundaries; delivery zones define operational service areas. Linking enables accurate zone-based rate application, last-mile pricing, and delivery cost allocation. Essen',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: lane_rate_zone defines geographic rate zones mapping postal codes, cities, and countries to rate zones. In freight pricing, these zone definitions are published as part of a carrier tariff. Adding tar',
    `city_name` STRING COMMENT 'Name of the city or metropolitan area covered by this zone, used for urban and last-mile delivery zone definitions.',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the primary country this zone covers. Used for customs, trade compliance, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this zone definition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the default currency used in rate cards associated with this zone.. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether shipments to or from this zone require customs clearance, affecting pricing and documentation requirements.',
    `data_source_system` STRING COMMENT 'Name of the operational system of record from which this zone definition was sourced (e.g., SAP TM, Oracle TMS).',
    `distance_from_hub_km` DECIMAL(18,2) COMMENT 'Average distance in kilometers from the primary distribution hub or gateway to locations within this zone. Used for distance-based pricing calculations.',
    `effective_from_date` DATE COMMENT 'Date from which this zone definition becomes active and applicable for rate card matching. Supports temporal zone versioning.',
    `effective_to_date` DATE COMMENT 'Date until which this zone definition remains active. Null indicates no expiration. Supports temporal zone versioning and GRI/BAF adjustments.',
    `free_trade_zone_flag` BOOLEAN COMMENT 'Indicates whether this zone includes or is adjacent to a Free Trade Zone, which may affect duty and tax calculations in pricing.',
    `fuel_surcharge_region` STRING COMMENT 'Code identifying the fuel surcharge region this zone belongs to. Links to fuel index tables for Bunker Adjustment Factor (BAF) and fuel surcharge calculations.',
    `geographic_scope` STRING COMMENT 'Defines the geographic coverage of the zone: domestic (within-country), international (cross-border), regional (multi-country area), or global.. Valid values are `domestic|international|regional|global`',
    `hazmat_restricted_flag` BOOLEAN COMMENT 'Indicates whether this zone has restrictions on hazardous materials shipments, affecting service availability and surcharge applicability.',
    `incoterm_default` STRING COMMENT 'Default International Commercial Term (Incoterm) applied to shipments in this zone, affecting charge allocation between shipper and consignee (e.g., DDP, DAP, FOB, CIF, EXW).',
    `postal_code_pattern` STRING COMMENT 'Regular expression or wildcard pattern defining the postal codes included in this zone (e.g., 10*** for all codes starting with 10). Enables efficient postal code to zone resolution.',
    `postal_code_range_end` STRING COMMENT 'Ending postal code in a contiguous range included in this zone. Used with postal_code_range_start for range-based zone matching.',
    `postal_code_range_start` STRING COMMENT 'Starting postal code in a contiguous range included in this zone. Used with postal_code_range_end for range-based zone matching.',
    `priority_sequence` STRING COMMENT 'Numeric priority for zone matching when multiple zones could apply to the same location. Lower numbers indicate higher priority.',
    `region_code` STRING COMMENT 'Code representing a sub-national region, state, province, or administrative division within the country.',
    `remote_area_flag` BOOLEAN COMMENT 'Indicates whether this zone is classified as a remote or extended delivery area, which typically incurs additional surcharges.',
    `service_type` STRING COMMENT 'The logistics service type this zone applies to (e.g., express parcel, freight forwarding, LTL, FTL, FCL, LCL). Enables service-specific zone definitions. [ENUM-REF-CANDIDATE: express_parcel|freight_forwarding|ltl|ftl|fcl|lcl|last_mile|white_glove|economy|standard|premium — promote to reference product]',
    `transit_time_days` STRING COMMENT 'Standard transit time in days for shipments to or from this zone. Used for service level agreement (SLA) calculations and estimated time of arrival (ETA) predictions.',
    `transport_mode` STRING COMMENT 'The primary mode of transportation this zone definition applies to. Aligns with IATA (air), IMO (ocean), and DOT (road/rail) classifications.. Valid values are `air|ocean|road|rail|multimodal|express`',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated this zone definition record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this zone definition record was last modified in the system.',
    `zone_code` STRING COMMENT 'Unique alphanumeric code identifying the rate zone. Used as a lookup key in rate card and tariff matching operations.. Valid values are `^[A-Z0-9]{2,10}$`',
    `zone_description` STRING COMMENT 'Detailed textual description of the zone coverage, including specific geographic boundaries, exceptions, and business rules for zone assignment.',
    `zone_hierarchy_level` STRING COMMENT 'Numeric level in the zone hierarchy structure. Level 1 is the broadest (e.g., continent), higher numbers represent finer granularity (e.g., postal code).',
    `zone_name` STRING COMMENT 'Human-readable descriptive name of the rate zone for business user identification and reporting purposes.',
    `zone_status` STRING COMMENT 'Current lifecycle status of the zone definition. Only active zones are used in rate card lookups.. Valid values are `active|inactive|suspended|pending`',
    `zone_type` STRING COMMENT 'Indicates whether the zone applies to origin locations, destination locations, or both directions in lane-based pricing.. Valid values are `origin|destination|bidirectional`',
    CONSTRAINT pk_lane_rate_zone PRIMARY KEY(`lane_rate_zone_id`)
) COMMENT 'Geographic rate zone definition mapping origin and destination postal codes, cities, countries, or regions to pricing zones used in rate card lookups. Captures zone code, zone name, zone type (origin/destination/both), geographic scope (domestic/international), applicable transport mode, and zone hierarchy level. Enables efficient rate lookup by resolving shipment origins and destinations to zone pairs for tariff and rate card matching.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`charge_code` (
    `charge_code_id` BIGINT COMMENT 'Primary key for charge_code',
    `superseded_by_charge_code_id` BIGINT COMMENT 'Reference to the newer charge code that replaces this one when this charge is deprecated or superseded. Supports charge code version lineage tracking.',
    `applicable_incoterms` STRING COMMENT 'Comma-separated list of Incoterms (International Commercial Terms) under which this charge is applicable (e.g., DDP, DAP, FOB, CIF, EXW, FCA). Determines charge bearer responsibility.',
    `applicable_service_lines` STRING COMMENT 'Comma-separated list of service product types to which this charge applies (e.g., express parcel, air freight, ocean freight, road freight, rail freight, contract logistics, e-commerce fulfillment, last-mile delivery).',
    `applicable_transport_modes` STRING COMMENT 'Comma-separated list of transport modes to which this charge applies (e.g., air, ocean, road, rail, multimodal).',
    `approval_status` STRING COMMENT 'Workflow approval state for new or modified charge codes. Draft charges are under development; pending charges await finance or pricing approval; approved charges are ready for activation.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this charge code was approved for production use. Used for audit trail and SOX compliance.',
    `auto_apply_conditions` STRING COMMENT 'Business rules or conditions that trigger automatic application of this charge (e.g., shipment weight exceeds 500kg, destination is residential, delivery requires liftgate).',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether this charge is automatically applied by the rating engine when applicable conditions are met, or requires manual addition by operations staff.',
    `calculation_basis` STRING COMMENT 'Unit or method by which the charge is calculated (e.g., flat fee, per kilogram, per cubic meter, per TEU, percentage of freight, per shipment, per mile, per hour). [ENUM-REF-CANDIDATE: flat|per_kg|per_cbm|per_teu|per_shipment|per_package|percentage|per_mile|per_hour — 9 candidates stripped; promote to reference product]',
    `charge_bearer` STRING COMMENT 'Party responsible for paying this charge. Prepaid indicates shipper pays; collect indicates consignee pays; third_party indicates another party pays per agreement.. Valid values are `shipper|consignee|carrier|third_party|prepaid|collect`',
    `charge_category` STRING COMMENT 'High-level classification of the charge type. Freight covers base transportation; surcharge includes fuel, GRI, BAF; accessorial covers value-added services; customs includes duties and brokerage; handling includes THC, CFS, ICD fees. [ENUM-REF-CANDIDATE: freight|surcharge|accessorial|customs|insurance|handling|storage|documentation — 8 candidates stripped; promote to reference product]',
    `charge_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the charge type (e.g., FRT for freight, FSC for fuel surcharge, THC for terminal handling charge). Used across billing, rating, and EDI transactions.. Valid values are `^[A-Z0-9]{2,10}$`',
    `charge_description` STRING COMMENT 'Detailed explanation of the charge purpose, applicability conditions, and calculation basis. Used for customer communication and internal training.',
    `charge_name` STRING COMMENT 'Full business name of the charge type (e.g., Freight Charge, Fuel Surcharge, Terminal Handling Charge, Customs Clearance Fee).',
    `charge_status` STRING COMMENT 'Current lifecycle status of the charge code. Active charges are available for rating and billing; inactive charges are retired; pending charges await approval; deprecated charges are phased out; superseded charges are replaced by newer versions.. Valid values are `active|inactive|pending|deprecated|superseded`',
    `charge_subcategory` STRING COMMENT 'Granular classification within the charge category (e.g., under surcharge: fuel, currency, security, peak season; under accessorial: liftgate, inside delivery, residential).',
    `cost_account_code` STRING COMMENT 'General Ledger (GL) cost account code for expense allocation when this charge represents a pass-through or cost recovery item.. Valid values are `^[0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this charge code record was first created in the system. Used for audit trail and data lineage.',
    `customer_visibility_flag` BOOLEAN COMMENT 'Indicates whether this charge is displayed to customers on invoices, quotes, and online portals, or is an internal cost allocation not shown externally.',
    `customs_hs_code_applicable` BOOLEAN COMMENT 'Indicates whether this charge requires Harmonized System (HS) code classification for customs declaration and duty calculation purposes.',
    `default_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which this charge is typically denominated (e.g., USD, EUR, GBP). May be overridden at tariff or contract level.. Valid values are `^[A-Z]{3}$`',
    `dim_weight_applicable` BOOLEAN COMMENT 'Indicates whether this charge calculation considers dimensional weight (volumetric weight) in addition to actual weight, common in air and express freight.',
    `dispute_eligible_flag` BOOLEAN COMMENT 'Indicates whether this charge type is eligible for customer dispute and freight audit review processes.',
    `edifact_charge_code` STRING COMMENT 'UN/EDIFACT standard charge code used in electronic data interchange (EDI) messages for freight and logistics (e.g., IFTMIN, IFTMBC, INVOIC).. Valid values are `^[A-Z0-9]{1,3}$`',
    `effective_date` DATE COMMENT 'Date from which this charge code becomes valid and available for use in rating, quoting, and billing operations.',
    `expiration_date` DATE COMMENT 'Date after which this charge code is no longer valid for new transactions. Nullable for charges with indefinite validity.',
    `hazmat_applicable` BOOLEAN COMMENT 'Indicates whether this charge applies specifically to hazardous materials (dangerous goods) shipments requiring special handling per IMDG, IATA DGR, or ADR regulations.',
    `iata_charge_code` STRING COMMENT 'Two-letter IATA standard charge code used in air waybill (AWB) and cargo-IMP messaging (e.g., MY for miscellaneous charge due carrier, PP for prepaid, CC for collect).. Valid values are `^[A-Z]{2}$`',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum monetary cap for this charge. If calculated charge exceeds this threshold, the maximum is applied.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum monetary value for this charge regardless of calculation basis. If calculated charge is below this threshold, the minimum is applied.',
    `modified_by` STRING COMMENT 'User identifier or name of the pricing analyst or system administrator who last modified this charge code record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this charge code record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or business context regarding this charge code (e.g., seasonal applicability, customer-specific usage, regulatory considerations).',
    `published_tariff_flag` BOOLEAN COMMENT 'Indicates whether this charge is part of a publicly filed tariff with regulatory authorities (e.g., Federal Maritime Commission for ocean freight, DOT for domestic trucking).',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for the regulatory tariff filing or rate publication with governing bodies (e.g., FMC tariff number, DOT docket number).',
    `revenue_account_code` STRING COMMENT 'General Ledger (GL) revenue account code to which this charge type posts. Used for financial reporting and revenue recognition per IFRS 15.. Valid values are `^[0-9]{4,10}$`',
    `revenue_recognition_category` STRING COMMENT 'Classification determining how and when revenue from this charge is recognized per IFRS 15 and ASC 606 (e.g., service revenue recognized over time, pass-through recognized net, reimbursable recognized gross).. Valid values are `service_revenue|pass_through|reimbursable|deferred|immediate`',
    `tax_category_code` STRING COMMENT 'Tax classification code for this charge type (e.g., standard rate, reduced rate, exempt, zero-rated). Used for automated tax calculation.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether this charge is subject to value-added tax (VAT), goods and services tax (GST), or sales tax per jurisdiction tax regulations.',
    `version_number` STRING COMMENT 'Sequential version number for this charge code. Incremented each time the charge definition is modified and re-approved. Supports change tracking and audit history.',
    `waivable_flag` BOOLEAN COMMENT 'Indicates whether this charge can be waived or discounted under certain circumstances (e.g., customer contract terms, service recovery, promotional campaigns).',
    `waiver_approval_required` BOOLEAN COMMENT 'Indicates whether waiving this charge requires managerial or finance approval per internal controls and SOX compliance.',
    `created_by` STRING COMMENT 'User identifier or name of the pricing analyst or system administrator who created this charge code record.',
    CONSTRAINT pk_charge_code PRIMARY KEY(`charge_code_id`)
) COMMENT 'Standardized charge code reference catalog defining all billable charge types used across freight, express, and logistics services. Captures charge code, charge name, charge category (freight/surcharge/accessorial/customs/insurance/handling), revenue account mapping, applicable service lines, taxable flag, EDI code mapping (IATA charge codes, UN/EDIFACT charge codes), and active status. SSOT for charge type standardization across billing, rate cards, and spot quotes.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` (
    `carrier_buy_rate_id` BIGINT COMMENT 'Unique identifier for the carrier buy rate record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the procurement contract or capacity agreement under which this buy rate is negotiated. Links to contract master.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Procurement teams managing carrier contracts link buy rates specifically to carrier agreements (vs generic agreements) for carrier performance analysis, rate benchmarking, and margin calculation on ca',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier, airline, shipping line, or subcontractor providing capacity. Links to the carrier master entity.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Buy rates are negotiated for specific carrier service products (not just carrier-level). Carrier_service_id enables precise cost matching when rating shipments, supporting accurate margin calculation ',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Carrier buy rates are negotiated per lane. Lane_id links carrier cost to specific routes, enabling buy-sell margin analysis, carrier selection optimization, and cost-to-serve reporting by lane.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Buy rates formalized through capacity purchase orders with carrier-suppliers. Business need: financial reconciliation matches buy rate commitments to PO obligations; accrual management for contracted ',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Carrier buy rates negotiated for corridors (multi-leg carrier services). Service_corridor_id links carrier cost to multi-leg routes, enabling corridor-level margin analysis and carrier performance eva',
    `superseded_by_rate_carrier_buy_rate_id` BIGINT COMMENT 'Reference to the newer buy rate that replaces this one. Used to maintain rate lineage and history.',
    `supplier_quote_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_quote. Business justification: Buy rates sourced from supplier quotes during carrier procurement. Business need: cost basis tracking links negotiated buy rates to original supplier quotes for margin calculation and procurement audi',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Buy-side rates paid to carriers are governed by carrier tariffs in freight forwarding. carrier_buy_rate already has carrier_id and carrier_agreement_id, but lacks a direct reference to the tariff sche',
    `approval_status` STRING COMMENT 'Approval workflow status for this buy rate. Rates must be approved before use in cost calculation and freight procurement.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this buy rate was approved for operational use.',
    `buy_rate_amount` DECIMAL(18,2) COMMENT 'The cost amount Transport Shipping pays to the carrier per unit. This is the base buy-side rate before surcharges.',
    `commodity_group_code` STRING COMMENT 'Code representing the commodity or product group this buy rate applies to (e.g., general cargo, hazmat, perishables, high-value).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this buy rate record was first created in the system.',
    `data_source_system` STRING COMMENT 'Name of the source system from which this buy rate was loaded (e.g., SAP TM, Oracle TMS, Coupa). Used for data lineage and reconciliation.',
    `effective_from_date` DATE COMMENT 'Date from which this buy rate becomes valid and can be used for cost calculation and freight procurement.',
    `effective_to_date` DATE COMMENT 'Date until which this buy rate remains valid. Null indicates open-ended validity.',
    `equipment_type` STRING COMMENT 'Type of equipment or container required for this buy rate (e.g., 20ft dry, 40ft reefer, flatbed truck, aircraft type). Relevant for ocean and road freight.',
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a fuel surcharge (BAF for ocean, fuel surcharge for air/road) is applicable on top of this buy rate.',
    `gri_applicable` BOOLEAN COMMENT 'Indicates whether General Rate Increase (GRI) adjustments apply to this buy rate. Common in ocean freight contracts.',
    `incoterm_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the allocation of costs and risks between Transport Shipping and the carrier. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `margin_floor_percentage` DECIMAL(18,2) COMMENT 'Minimum margin percentage that must be maintained when pricing sell-side rates based on this buy rate. Used for margin management and pricing guardrails.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum charge cap for this buy rate, if applicable. Used for volume-based rate capping agreements.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum charge the carrier will invoice regardless of shipment size or weight. Floor for cost calculation.',
    `notes` STRING COMMENT 'Free-text notes capturing special conditions, restrictions, or business context for this buy rate (e.g., volume commitments, seasonal restrictions, carrier requirements).',
    `rate_basis` STRING COMMENT 'Unit of measure for the buy rate (e.g., per kg, per shipment, per container, per TEU, per CBM, per mile). [ENUM-REF-CANDIDATE: per_kg|per_shipment|per_container|per_teu|per_cbm|per_mile|per_km — 7 candidates stripped; promote to reference product]',
    `rate_code` STRING COMMENT 'Unique business identifier for this buy rate, used for operational reference and carrier invoice reconciliation.',
    `rate_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the buy rate amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `rate_name` STRING COMMENT 'Descriptive name for the buy rate, typically including lane, mode, and service type for easy identification.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the buy rate (active, inactive, pending approval, expired, suspended, superseded).. Valid values are `active|inactive|pending|expired|suspended|superseded`',
    `service_type` STRING COMMENT 'Type of service provided by the carrier (e.g., express, standard, economy). Determines transit time and service level.. Valid values are `express|standard|economy|deferred|next_day|two_day`',
    `thc_included` BOOLEAN COMMENT 'Indicates whether Terminal Handling Charges (THC) are included in the buy rate or billed separately by the carrier.',
    `transit_time_days` STRING COMMENT 'Standard transit time in days committed by the carrier for this lane and service type. Used for service level planning.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this buy rate (air, ocean, road, rail, multimodal).. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this buy rate record was last modified. Used for change tracking and audit trail.',
    `version_number` STRING COMMENT 'Version number of this buy rate record. Incremented when rate is amended or renegotiated. Supports rate history tracking.',
    `volume_break_max_cbm` DECIMAL(18,2) COMMENT 'Maximum volume threshold in cubic meters (CBM) for this rate tier. Null indicates no upper limit.',
    `volume_break_min_cbm` DECIMAL(18,2) COMMENT 'Minimum volume threshold in cubic meters (CBM) for this rate tier. Used for volumetric pricing.',
    `volume_commitment_max` DECIMAL(18,2) COMMENT 'Maximum volume commitment (in rate basis units) covered by this buy rate. Exceeding this may trigger renegotiation.',
    `volume_commitment_min` DECIMAL(18,2) COMMENT 'Minimum volume commitment (in rate basis units) required to maintain this buy rate. Part of carrier capacity agreements.',
    `weight_break_max_kg` DECIMAL(18,2) COMMENT 'Maximum weight threshold in kilograms for this rate tier. Null indicates no upper limit.',
    `weight_break_min_kg` DECIMAL(18,2) COMMENT 'Minimum weight threshold in kilograms for this rate tier. Used for tiered pricing structures.',
    CONSTRAINT pk_carrier_buy_rate PRIMARY KEY(`carrier_buy_rate_id`)
) COMMENT 'Buy-side rate representing the cost Transport Shipping pays to carriers, airlines, shipping lines, and subcontractors for capacity procurement. Captures carrier reference, service type, transport mode, origin-destination lane, buy rate amount, currency, rate basis, contract reference, validity period, margin floor, and volume tier pricing. Enables sell/buy rate spread analysis, margin management, carrier cost benchmarking, and freight audit against carrier invoices. Distinct from sell-side rate_card — this is the cost basis for all pricing decisions and margin calculations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_superseded_by_rate_card_id` FOREIGN KEY (`superseded_by_rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ADD CONSTRAINT `fk_pricing_rate_line_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ADD CONSTRAINT `fk_pricing_rate_line_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ADD CONSTRAINT `fk_pricing_surcharge_fuel_index_id` FOREIGN KEY (`fuel_index_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`fuel_index`(`fuel_index_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ADD CONSTRAINT `fk_pricing_surcharge_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ADD CONSTRAINT `fk_pricing_surcharge_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_fuel_index_id` FOREIGN KEY (`fuel_index_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`fuel_index`(`fuel_index_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_superseded_by_schedule_pricing_surcharge_schedule_id` FOREIGN KEY (`superseded_by_schedule_pricing_surcharge_schedule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule`(`pricing_surcharge_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ADD CONSTRAINT `fk_pricing_accessorial_charge_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ADD CONSTRAINT `fk_pricing_accessorial_charge_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ADD CONSTRAINT `fk_pricing_dim_weight_rule_superseded_by_rule_dim_weight_rule_id` FOREIGN KEY (`superseded_by_rule_dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ADD CONSTRAINT `fk_pricing_dim_weight_rule_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ADD CONSTRAINT `fk_pricing_spot_quote_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ADD CONSTRAINT `fk_pricing_spot_quote_line_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ADD CONSTRAINT `fk_pricing_spot_quote_line_rate_line_id` FOREIGN KEY (`rate_line_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_line`(`rate_line_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ADD CONSTRAINT `fk_pricing_spot_quote_line_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_dim_weight_rule_id` FOREIGN KEY (`dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_rate_line_id` FOREIGN KEY (`rate_line_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_line`(`rate_line_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ADD CONSTRAINT `fk_pricing_rate_rule_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ADD CONSTRAINT `fk_pricing_rate_rule_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ADD CONSTRAINT `fk_pricing_lane_rate_zone_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ADD CONSTRAINT `fk_pricing_charge_code_superseded_by_charge_code_id` FOREIGN KEY (`superseded_by_charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_superseded_by_rate_carrier_buy_rate_id` FOREIGN KEY (`superseded_by_rate_carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`pricing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `transport_shipping_ecm`.`pricing` SET TAGS ('dbx_domain' = 'pricing');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `dim_weight_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dim Weight Rule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `superseded_by_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate Card Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `accessorial_charges_included` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Included Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected|conditional');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `base_rate_maximum` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Maximum');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `base_rate_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `base_rate_minimum` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Minimum');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `base_rate_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `fuel_surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `fuel_surcharge_type` SET TAGS ('dbx_value_regex' = 'baf|fsc|fixed_percentage|index_linked');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `gri_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `hazmat_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Surcharge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `incoterms_default` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Default');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `peak_season_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Peak Season Surcharge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_value_regex' = '^RC-[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_card_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_card_type` SET TAGS ('dbx_value_regex' = 'published|contract|spot|promotional|seasonal');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `security_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Security Surcharge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `service_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|express_parcel');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `thc_included` SET TAGS ('dbx_business_glossary_term' = 'Terminal Handling Charge (THC) Included Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Version');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^v?[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `weight_break_structure` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Structure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `weight_break_structure` SET TAGS ('dbx_value_regex' = 'flat|tiered|banded|continuous');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `rate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Line Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `dim_weight_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dim Weight Rule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `all_in_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Rate Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'base_freight|fuel_surcharge|security_fee|handling_charge|documentation_fee|customs_clearance');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `commodity_class` SET TAGS ('dbx_business_glossary_term' = 'Commodity Class');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `fuel_surcharge_pct` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `hazmat_surcharge_pct` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Surcharge Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'FCL|LCL|FTL|LTL|parcel');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `negotiated_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Rate Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Line Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `peak_season_surcharge_pct` SET TAGS ('dbx_business_glossary_term' = 'Peak Season Surcharge Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `rate_basis_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `rate_line_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Line Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `rate_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `rate_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `rate_unit_of_measure` SET TAGS ('dbx_value_regex' = 'per_kg|per_cbm|per_teu|per_shipment|per_pallet|per_mile');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Rate Value');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'next_day|priority|economy|deferred|standard|express');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `spot_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time (Days)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `volume_break_max_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Break Maximum (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `volume_break_min_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Break Minimum (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `volume_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `weight_break_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `weight_break_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Identifier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `accessorial_charges_included` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Included Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `base_rate_structure` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Structure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `base_rate_structure` SET TAGS ('dbx_value_regex' = 'flat|weight_based|distance_based|zone_based|dimensional|hybrid');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `commodity_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Commodity Restrictions');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `customs_clearance_included` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Included Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `dim_weight_divisor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Weight Divisor');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `distance_unit` SET TAGS ('dbx_business_glossary_term' = 'Distance Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `distance_unit` SET TAGS ('dbx_value_regex' = 'km|mile|nautical_mile');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `governing_body_reference` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Reference Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `gri_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `incoterms_default` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Default');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `insurance_included` SET TAGS ('dbx_business_glossary_term' = 'Insurance Included Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `service_product_type` SET TAGS ('dbx_business_glossary_term' = 'Service Product Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `tariff_description` SET TAGS ('dbx_business_glossary_term' = 'Tariff Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Tariff Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `tariff_number` SET TAGS ('dbx_business_glossary_term' = 'Tariff Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `tariff_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `tariff_type` SET TAGS ('dbx_business_glossary_term' = 'Tariff Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `tariff_type` SET TAGS ('dbx_value_regex' = 'import|export|domestic|cross_border|international');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `thc_included` SET TAGS ('dbx_business_glossary_term' = 'Terminal Handling Charge (THC) Included Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|parcel');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Tariff Version');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}(.[0-9]{1,2})?$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'cbm|cft|liter');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|tonne');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` SET TAGS ('dbx_subdomain' = 'surcharge_administration');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Identifier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `fuel_index_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Charge Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `applicable_service_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `applicable_service_type` SET TAGS ('dbx_value_regex' = 'express|standard|economy|freight_forwarding|contract_logistics|all');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `applicable_transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `applicable_transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|all');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `applies_to_dim_weight_flag` SET TAGS ('dbx_business_glossary_term' = 'Applies to Dimensional (DIM) Weight Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `applies_to_hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Applies to Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `applies_to_oversize_flag` SET TAGS ('dbx_business_glossary_term' = 'Applies to Oversize Shipments Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `applies_to_temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Applies to Temperature Controlled Shipments Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat_rate|percentage|per_unit|tiered|formula_based');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `charge_allocation_party` SET TAGS ('dbx_business_glossary_term' = 'Charge Allocation Party');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `charge_allocation_party` SET TAGS ('dbx_value_regex' = 'shipper|consignee|carrier|third_party|negotiable');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `compounding_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compounding Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `customer_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Visibility Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `flat_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Rate Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `fuel_index_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Linked Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `governing_body_reference` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Reference');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `incoterms_applicability` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms) Applicability');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `per_unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Unit Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `percentage_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `priority_sequence` SET TAGS ('dbx_business_glossary_term' = 'Priority Sequence');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_category` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Category');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_code` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_description` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_name` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_status` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `trade_lane_scope` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `trade_lane_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country_specific|lane_specific');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` SET TAGS ('dbx_subdomain' = 'surcharge_administration');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `pricing_surcharge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Surcharge Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `fuel_index_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Definition ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `superseded_by_schedule_pricing_surcharge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|superseded|expired');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `commodity_group_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `destination_port_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Port Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `destination_port_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `destination_region_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Region Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `index_base_value` SET TAGS ('dbx_business_glossary_term' = 'Index Base Value');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `index_current_value` SET TAGS ('dbx_business_glossary_term' = 'Index Current Value');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `origin_port_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Port Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `origin_port_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `origin_region_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Region Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `published_flag` SET TAGS ('dbx_business_glossary_term' = 'Published Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'flat|percentage|tiered|indexed');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `rate_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `rate_unit_of_measure` SET TAGS ('dbx_value_regex' = 'per_kg|per_cbm|per_teu|per_shipment|per_container|per_pallet');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `service_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_value_regex' = 'BAF|GRI|THC|FSC|PSS|EBS');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `trade_lane_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `volume_break_max_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Break Maximum (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `volume_break_min_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Break Minimum (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `weight_break_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `weight_break_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` SET TAGS ('dbx_subdomain' = 'surcharge_administration');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `fuel_index_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Factor');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `baseline_index_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Index Value');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'jet_fuel|bunker_ifo380|bunker_vlsfo|diesel|gasoline|lng');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Index Change Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_currency` SET TAGS ('dbx_business_glossary_term' = 'Index Currency');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_date` SET TAGS ('dbx_business_glossary_term' = 'Index Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_name` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Index Publication Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_source` SET TAGS ('dbx_business_glossary_term' = 'Index Source');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_source_url` SET TAGS ('dbx_business_glossary_term' = 'Index Source URL (Uniform Resource Locator)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_status` SET TAGS ('dbx_business_glossary_term' = 'Index Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_status` SET TAGS ('dbx_value_regex' = 'active|superseded|archived|pending_verification');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `index_value` SET TAGS ('dbx_business_glossary_term' = 'Index Value');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `publication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Publication Frequency');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `publication_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `surcharge_tier` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Tier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `trade_lane` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallon|liter|barrel|metric_ton|kilogram|mmbtu');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|disputed|corrected');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` SET TAGS ('dbx_subdomain' = 'surcharge_administration');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Charge Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `accessorial_charge_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `accessorial_charge_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|suspended');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `applicable_incoterms` SET TAGS ('dbx_business_glossary_term' = 'Applicable Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `applicable_modes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transportation Modes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `applicable_service_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Types');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `auto_apply_conditions` SET TAGS ('dbx_business_glossary_term' = 'Auto-Apply Conditions');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Apply Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_bearer` SET TAGS ('dbx_business_glossary_term' = 'Charge Bearer');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_bearer` SET TAGS ('dbx_value_regex' = 'shipper|consignee|third_party|as_per_incoterm');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_name` SET TAGS ('dbx_business_glossary_term' = 'Charge Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Charge Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_tier` SET TAGS ('dbx_business_glossary_term' = 'Charge Tier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|economy|express');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `customer_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Visibility Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `destination_country_codes` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Codes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `dim_weight_applicable` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Weight Applicable');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `dispute_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'domestic|international|regional|global');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `hazmat_class_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (Hazmat) Class Applicable');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `origin_country_codes` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Codes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `published_tariff_flag` SET TAGS ('dbx_business_glossary_term' = 'Published Tariff Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_value_regex' = 'ancillary_revenue|freight_revenue|service_revenue|handling_revenue');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `seasonal_end_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal End Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `seasonal_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `seasonal_start_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Start Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `volume_threshold_applicable` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Applicable');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `waivable_flag` SET TAGS ('dbx_business_glossary_term' = 'Waivable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `waiver_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Required');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `zone_applicable` SET TAGS ('dbx_business_glossary_term' = 'Zone Applicable');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` SET TAGS ('dbx_subdomain' = 'surcharge_administration');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `dim_weight_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (DIM Weight) Rule ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `superseded_by_rule_dim_weight_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rule ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `applies_to_returns` SET TAGS ('dbx_business_glossary_term' = 'Applies to Returns Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Destination Region');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `dim_factor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Factor');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `is_default_rule` SET TAGS ('dbx_business_glossary_term' = 'Is Default Rule Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `length_unit` SET TAGS ('dbx_business_glossary_term' = 'Length Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `length_unit` SET TAGS ('dbx_value_regex' = 'cm|in|m');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `maximum_chargeable_weight` SET TAGS ('dbx_business_glossary_term' = 'Maximum Chargeable Weight');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `minimum_chargeable_weight` SET TAGS ('dbx_business_glossary_term' = 'Minimum Chargeable Weight');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `rounding_method` SET TAGS ('dbx_business_glossary_term' = 'Rounding Method');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `rounding_method` SET TAGS ('dbx_value_regex' = 'round_up|round_down|round_nearest|round_half_up');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `rounding_precision` SET TAGS ('dbx_business_glossary_term' = 'Rounding Precision');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|express|multimodal');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `unit_system` SET TAGS ('dbx_business_glossary_term' = 'Unit System');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `unit_system` SET TAGS ('dbx_value_regex' = 'metric|imperial');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|g');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` SET TAGS ('dbx_subdomain' = 'quote_processing');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `spot_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `consignee_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `dim_weight_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dim Weight Rule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agent ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `supplier_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quote Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `base_freight_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Freight Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `customs_clearance_fee` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Fee');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `dim_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (DIM Weight) in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `documentation_fee` SET TAGS ('dbx_business_glossary_term' = 'Documentation Fee');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `estimated_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Days');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `insurance_premium` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Pickup Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `piece_count` SET TAGS ('dbx_business_glossary_term' = 'Piece Count');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `quote_issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Issued Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_value_regex' = '^SQ[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `quote_request_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Request Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `quote_source` SET TAGS ('dbx_business_glossary_term' = 'Quote Source');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `quote_source` SET TAGS ('dbx_value_regex' = 'web_portal|email|phone|api|crm|rfq');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_value_regex' = 'draft|issued|accepted|expired|rejected|cancelled');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `quote_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `quote_valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid Until Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `sales_office_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Office Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `sales_office_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `security_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Surcharge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'express|standard|economy|deferred|same_day|next_day');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'FCL|LCL|FTL|LTL|parcel|pallet');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `terminal_handling_charge` SET TAGS ('dbx_business_glossary_term' = 'Terminal Handling Charge (THC)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `total_quoted_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Quoted Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|courier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` SET TAGS ('dbx_subdomain' = 'quote_processing');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `spot_quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Line Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Charge Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `rate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `spot_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Commodity Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `cost_allocation_party` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Party');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `cost_allocation_party` SET TAGS ('dbx_value_regex' = 'shipper|consignee|carrier|third_party|shared');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `dim_weight_factor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Weight Factor');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `included_in_all_in_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Included in All-In Rate Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Charge Line Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `rate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `rate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'contract|tariff|spot|negotiated|published|market');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'express|standard|economy|same_day|next_day|deferred');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `service_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|courier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters - CBM)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `weight_break_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `weight_break_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `contract_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `dim_weight_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dim Weight Rule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `transit_time_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Standard Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `deviation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deviation Reason');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `floor_rate` SET TAGS ('dbx_business_glossary_term' = 'Floor Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `gri_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Applicable');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|preferred|strategic|vip');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'per_kg|per_cbm|per_teu|per_shipment|per_pallet|per_unit');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'standard|promotional|spot|emergency|seasonal');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'express|standard|economy|same_day|next_day|deferred');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'parcel|freight|ltl|ftl|fcl|lcl');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `thc_included` SET TAGS ('dbx_business_glossary_term' = 'Terminal Handling Charge (THC) Included');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `volume_commitment_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Minimum');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `weight_break_max` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `weight_break_min` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `rate_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Rule Identifier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Charge Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `adjustment_currency` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Currency');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `adjustment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'flat_amount|percentage|tiered|multiplier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `adjustment_value` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Value');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `applicable_incoterm` SET TAGS ('dbx_business_glossary_term' = 'Applicable Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `applicable_service_mode` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `applicable_trade_lane` SET TAGS ('dbx_business_glossary_term' = 'Applicable Trade Lane');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `commodity_hs_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `commodity_hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `compound_rule_flag` SET TAGS ('dbx_business_glossary_term' = 'Compound Rule Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `destination_region_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Region Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `destination_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `dim_weight_factor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Weight Factor');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `external_rule_code` SET TAGS ('dbx_business_glossary_term' = 'External Rule ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `maximum_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Threshold Value');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `minimum_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Threshold Value');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `origin_region_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Region Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `origin_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `priority_order` SET TAGS ('dbx_business_glossary_term' = 'Priority Order');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `proration_method` SET TAGS ('dbx_business_glossary_term' = 'Proration Method');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `proration_method` SET TAGS ('dbx_value_regex' = 'daily|monthly|per_shipment|none');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|archived');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'volume_discount|lane_based_adjustment|customer_tier_discount|peak_surcharge|promotional_rate|fuel_surcharge');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'TEU|CBM|KG|LBS|SHIPMENT|PALLET');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `trigger_condition` SET TAGS ('dbx_business_glossary_term' = 'Trigger Condition');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `lane_rate_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Rate Zone ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `route_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Route Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `city_name` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `customs_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `distance_from_hub_km` SET TAGS ('dbx_business_glossary_term' = 'Distance From Hub (Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `free_trade_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `fuel_surcharge_region` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Region');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'domestic|international|regional|global');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `hazmat_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Restricted Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `incoterm_default` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Default');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `postal_code_pattern` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Pattern');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `postal_code_pattern` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `postal_code_pattern` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `postal_code_range_end` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Range End');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `postal_code_range_end` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `postal_code_range_end` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `postal_code_range_start` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Range Start');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `postal_code_range_start` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `postal_code_range_start` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `priority_sequence` SET TAGS ('dbx_business_glossary_term' = 'Priority Sequence');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `remote_area_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Area Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time (Days)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|express');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `zone_description` SET TAGS ('dbx_business_glossary_term' = 'Zone Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `zone_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Zone Hierarchy Level');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Zone Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'origin|destination|bidirectional');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` SET TAGS ('dbx_subdomain' = 'surcharge_administration');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Code Identifier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `superseded_by_charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Charge Code ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `applicable_incoterms` SET TAGS ('dbx_business_glossary_term' = 'Applicable Incoterms');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `applicable_service_lines` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Lines');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `applicable_transport_modes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transport Modes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `auto_apply_conditions` SET TAGS ('dbx_business_glossary_term' = 'Auto Apply Conditions');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Apply Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_bearer` SET TAGS ('dbx_business_glossary_term' = 'Charge Bearer');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_bearer` SET TAGS ('dbx_value_regex' = 'shipper|consignee|carrier|third_party|prepaid|collect');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_name` SET TAGS ('dbx_business_glossary_term' = 'Charge Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|superseded');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Charge Subcategory');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `cost_account_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `cost_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `customer_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Visibility Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `customs_hs_code_applicable` SET TAGS ('dbx_business_glossary_term' = 'Customs HS (Harmonized System) Code Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `default_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Default Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `default_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `dim_weight_applicable` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Weight Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `dispute_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `edifact_charge_code` SET TAGS ('dbx_business_glossary_term' = 'UN/EDIFACT (Electronic Data Interchange For Administration, Commerce and Transport) Charge Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `edifact_charge_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `hazmat_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `iata_charge_code` SET TAGS ('dbx_business_glossary_term' = 'IATA (International Air Transport Association) Charge Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `iata_charge_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `published_tariff_flag` SET TAGS ('dbx_business_glossary_term' = 'Published Tariff Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `revenue_account_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Account Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `revenue_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_value_regex' = 'service_revenue|pass_through|reimbursable|deferred|immediate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `waivable_flag` SET TAGS ('dbx_business_glossary_term' = 'Waivable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `waiver_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Buy Rate ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `superseded_by_rate_carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `supplier_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quote Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `buy_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Buy Rate Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `commodity_group_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `gri_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `margin_floor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Margin Floor Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `margin_floor_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended|superseded');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'express|standard|economy|deferred|next_day|two_day');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `thc_included` SET TAGS ('dbx_business_glossary_term' = 'Terminal Handling Charge (THC) Included Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time (Days)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `volume_break_max_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Break Maximum (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `volume_break_min_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Break Minimum (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `volume_commitment_max` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Maximum');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `volume_commitment_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Minimum');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `weight_break_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `weight_break_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum (Kilograms)');
