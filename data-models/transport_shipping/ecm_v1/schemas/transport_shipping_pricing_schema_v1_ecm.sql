-- Schema for Domain: pricing | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`pricing` COMMENT 'SSOT for all tariff structures, rate cards, surcharge schedules, and dynamic pricing rules governing freight forwarding, express delivery, and contract logistics. Owns base rates, DIM weight calculations, fuel surcharges, GRI/BAF adjustments, THC, accessorial charges, Incoterms-based charge allocation (DDP, DAP, FOB, CIF, EXW), spot quote generation, and contract pricing. Feeds billing and contract domains for revenue recognition.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`rate_card` (
    `rate_card_id` BIGINT COMMENT 'Unique identifier for the rate card. Primary key. [ROLE: MASTER_RESOURCE]',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Rate cards are often carrier-specific published tariffs. Pricing teams need carrier_id to distinguish carrier buy rates from sell rates, perform margin analysis, and manage carrier-specific GRI update',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Rate cards are published by specific legal entities (company codes) for regulatory compliance, revenue recognition, and intercompany billing. Multi-entity carriers must track which legal entity owns e',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Rate cards for green/carbon-neutral service tiers require emission factors to calculate carbon costs and provide customer carbon reporting. Essential for EU ETS and CORSIA compliance pricing.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the person or role who approved this rate card for publication or use.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Rate cards define pricing for specific origin-destination lanes. Lane_id anchors rate structures to network routes, enabling rate lookup by lane for freight costing and quote generation.',
    `superseded_by_rate_card_id` BIGINT COMMENT 'Identifier of the rate card that replaces this one, supporting version control and rate card lifecycle management. Null if this is the current version.',
    `template_id` BIGINT COMMENT 'Foreign key linking to document.document_template. Business justification: Rate cards reference standard document templates for customer-facing rate sheets, tariff publications, and regulatory filings. Real business process: tariff publication workflow where rate cards must ',
    `accessorial_charges_included` BOOLEAN COMMENT 'Indicates whether common accessorial charges (e.g., liftgate, residential delivery, inside delivery, appointment) are included in the base rate or billed separately.',
    `approval_status` STRING COMMENT 'Approval workflow state: not_submitted (not yet submitted for approval), pending (under review), approved (authorized for use), rejected (not approved), conditional (approved with conditions).. Valid values are `not_submitted|pending|approved|rejected|conditional`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card was approved, supporting audit trail and compliance requirements.',
    `base_rate_maximum` DECIMAL(18,2) COMMENT 'Maximum base freight rate per unit (as defined by rate_basis) applicable under this rate card. Used for ceiling pricing and rate cap enforcement.',
    `base_rate_minimum` DECIMAL(18,2) COMMENT 'Minimum base freight rate per unit (as defined by rate_basis) applicable under this rate card. Used for floor pricing and minimum charge calculations.',
    `contract_reference` STRING COMMENT 'Reference to the master contract or service agreement under which this rate card is issued. Applicable for contract-type rate cards.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rate card record was first created in the system, supporting audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all rates on this card are denominated (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment or tier for this rate card (e.g., Enterprise, SMB, E-Commerce, Retail, Government). Used for customer-specific or segment-specific pricing.',
    `dim_weight_divisor` STRING COMMENT 'Divisor used to calculate dimensional weight from volumetric measurements (length × width × height ÷ divisor). Common values: 5000 (air freight), 6000 (express parcel). Null if DIM weight does not apply.',
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
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Rate lines define mode/lane-specific pricing; linking emission factors enables lane-specific carbon intensity calculations for customer carbon reports and green lane optimization.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this rate line for production use. Supports accountability and audit requirements.',
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
    `dim_weight_factor` DECIMAL(18,2) COMMENT 'Dimensional weight divisor used to calculate chargeable weight from volume. Applied when dimensional weight exceeds actual weight for low-density shipments.',
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
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier or logistics service provider that publishes and operates under this tariff. Links to carrier master data.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Tariffs are legal instruments published by specific company codes, required for regulatory filings with authorities (FMC, IATA), revenue accounting by legal entity, and audit trails. Business process:',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Published tariffs must incorporate mode-specific emission factors for regulatory carbon pricing (EU ETS allowances, CORSIA offsetting obligations) and customer sustainability reporting requirements.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the individual or role that approved the tariff for publication. Supports governance and accountability.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Tariffs publish rates for specific lanes. Lane_id links published pricing to network routes, enabling tariff-based rate lookup for regulatory compliance and customer rate sheets.',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Tariffs publish rates for service corridors. Service_corridor_id links published pricing to multi-leg routes, enabling corridor-based tariff lookup for international freight movements.',
    `template_id` BIGINT COMMENT 'Foreign key linking to document.document_template. Business justification: Tariffs are published using standardized regulatory templates mandated by governing bodies (FMC for ocean, IATA for air). Real business process: regulatory tariff filing where format compliance is leg',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Many surcharges (BAF, CAF, PSS, GRI) are carrier-imposed and carrier-specific. Pricing must track which carrier announced each surcharge for accurate cost attribution, customer billing transparency, a',
    `charge_code_id` BIGINT COMMENT 'Foreign key linking to pricing.charge_code. Business justification: Surcharges (fuel, security, GRI, peak season) must map to standardized charge codes for billing system integration, revenue recognition, and financial reporting. While surcharge maintains its own surc',
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
    `fuel_index_source` STRING COMMENT 'Name of the fuel price index or benchmark used for dynamic calculation (e.g., Platts Brent Crude, US DOE Diesel Price Index, Singapore Bunker Price). Null if fuel_index_linked_flag is false.',
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
    `carbon_offset_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_program. Business justification: Carbon offset surcharge schedules must link to specific offset programs for customer transparency, verification of offset quality (CORSIA-eligible, registry serial numbers), and audit compliance.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Surcharge schedules vary by carrier service level (express vs economy, direct vs consolidated). Linking to carrier_service enables precise surcharge application in rating engines based on the exact se',
    `surcharge_id` BIGINT COMMENT 'Reference to the parent surcharge definition that this schedule implements. Links to the master surcharge type configuration.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this surcharge schedule. Required for audit trail and compliance with pricing governance policies.',
    `superseded_by_schedule_pricing_surcharge_schedule_id` BIGINT COMMENT 'Reference to the newer surcharge schedule that replaces this one. Nullable if this is the current active schedule.',
    `tertiary_pricing_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this surcharge schedule record. Required for audit trail.',
    `dg_incident_id` BIGINT COMMENT 'Foreign key linking to safety.dg_incident. Business justification: Dangerous goods incidents trigger surcharge schedule revisions (new hazmat handling fees, security surcharges). Logistics operators link surcharge changes to triggering DG incidents for regulatory rep',
    `approval_status` STRING COMMENT 'Current approval state of this surcharge schedule: draft (being prepared), pending_approval (submitted for review), approved (active and enforceable), rejected (not approved), superseded (replaced by newer schedule), expired (past effective_to_date).. Valid values are `draft|pending_approval|approved|rejected|superseded|expired`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge schedule was approved. Critical for regulatory compliance and audit trail.',
    `commodity_group_code` STRING COMMENT 'Business classification code for commodity types this surcharge applies to (e.g., DG for dangerous goods, PERISHABLE, GENERAL).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge schedule record was first created in the system.',
    `customer_segment_code` STRING COMMENT 'Customer segment or tier this surcharge schedule applies to (e.g., ENTERPRISE, SMB, RETAIL). Enables differential pricing by customer class.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for shipment destination. Defines geographic scope of surcharge applicability.. Valid values are `^[A-Z]{3}$`',
    `destination_port_code` STRING COMMENT 'Five-letter UN/LOCODE for destination port or airport. Specifies exact terminal where surcharge applies (e.g., USLAX, CNSHA).. Valid values are `^[A-Z]{5}$`',
    `destination_region_code` STRING COMMENT 'Business-defined region code for destination (e.g., APAC, EMEA, AMER). Used when surcharge applies to a broader geographic area.',
    `effective_from_date` DATE COMMENT 'Date when this surcharge schedule becomes active and applicable to shipments. Aligns with tariff publication requirements.',
    `effective_to_date` DATE COMMENT 'Date when this surcharge schedule expires or is superseded. Nullable for open-ended schedules.',
    `incoterm_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining cost and risk allocation. Determines which party bears the surcharge (e.g., DDP, FOB, CIF, EXW). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `index_base_value` DECIMAL(18,2) COMMENT 'Baseline index value used as reference point for indexed surcharge calculations. Changes in index relative to this base drive surcharge adjustments.',
    `index_current_value` DECIMAL(18,2) COMMENT 'Current index value at time of schedule creation or last update. Used to calculate indexed surcharge amount.',
    `index_reference_name` STRING COMMENT 'Name of external index this surcharge is linked to (e.g., Brent Crude Oil Price, Singapore Bunker Index). Used for indexed surcharge types like BAF.',
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
    `employee_id` BIGINT COMMENT 'User ID or system identifier of the person or process that verified the index value. Supports audit trail.',
    `fuel_consumption_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.fuel_consumption_record. Business justification: Fuel surcharge indices must correlate with actual fuel consumption records for carbon accounting reconciliation, Scope 1 emissions verification, and fuel efficiency variance analysis.',
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
    `carbon_offset_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_program. Business justification: Carbon-neutral service accessorial charges must reference the offset program for customer invoice transparency, regulatory audit trail, and verification of offset retirement.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Many accessorial charges are carrier-specific (e.g., carrier-imposed security fees, residential delivery surcharges). Carrier_id enables accurate cost pass-through and carrier-specific charge applicat',
    `employee_id` BIGINT COMMENT 'Username or identifier of the user who created this accessorial charge definition.',
    `charge_code_id` BIGINT COMMENT 'Foreign key linking to pricing.charge_code. Business justification: Accessorial charges are a specialized type of charge and must reference the master charge code catalog for standardized charge code assignment, revenue account mapping, tax treatment, and EDI/IATA cod',
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
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Dimensional weight rules affect chargeable weight calculations, which directly impact carbon intensity per shipment (gCO2e per tonne-km) for accurate customer carbon reporting.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the business user or role who approved this dimensional weight rule for activation.',
    `superseded_by_rule_dim_weight_rule_id` BIGINT COMMENT 'Reference to the dimensional weight rule that replaces this rule when it expires or is superseded, enabling rule version tracking.',
    `tariff_id` BIGINT COMMENT 'Reference to the tariff or rate card structure to which this dimensional weight rule belongs.',
    `applies_to_returns` BOOLEAN COMMENT 'Boolean flag indicating whether this dimensional weight rule applies to return shipments (RMA) or only to forward shipments.',
    `approval_status` STRING COMMENT 'Approval workflow status for the dimensional weight rule, ensuring governance and compliance before activation.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this dimensional weight rule was approved for use in production pricing systems.',
    `commodity_type` STRING COMMENT 'Type or category of commodity to which this dimensional weight rule applies (e.g., general cargo, perishables, high-value goods, dangerous goods).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dimensional weight rule record was first created in the system.',
    `customer_segment` STRING COMMENT 'Customer segment classification to which this dimensional weight rule applies, enabling segment-specific pricing strategies.. Valid values are `retail|enterprise|ecommerce|3pl|government|all`',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Spot quotes are typically for a specific carriers service. Sales teams need carrier_id for capacity confirmation, service availability validation, and SLA communication. Essential for quote-to-bookin',
    `consignee_id` BIGINT COMMENT 'Identifier of the consignee party receiving the goods at destination. Used for delivery coordination and customs clearance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Spot quotes require cost center allocation for internal pricing analysis, margin tracking by business unit, and sales performance management. Real process: sales teams track quote activity, conversion',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer or prospect requesting the spot quote. Links to the customer master for account details and relationship history.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Accepted spot quotes convert to invoices in the quote-to-cash process. Logistics operators must track which invoice originated from which quote for revenue recognition, sales commission calculation, a',
    `agent_id` BIGINT COMMENT 'Identifier of the sales agent, pricing analyst, or customer service representative who prepared and issued the spot quote. Used for performance tracking and commission calculation.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Spot quotes price specific lane movements. Lane_id captures the quoted route, enabling quote-to-lane analysis, win/loss tracking by lane, and spot rate benchmarking against lane performance.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Spot quotes generate route plans when accepted. Route_plan_id links quote to executed routing, enabling quote-to-execution tracking, planned vs. actual cost variance analysis, and quote accuracy measu',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Quotes must be attributed to profit centers for P&L forecasting, pipeline reporting, and segment profitability analysis. Real process: finance consolidates quote pipeline by profit center for monthly ',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Spot quotes can price corridor movements (multi-leg international). Service_corridor_id captures multi-leg quoted routes, enabling corridor-level quote analysis and win/loss tracking for complex movem',
    `shipper_profile_id` BIGINT COMMENT 'Identifier of the shipper party responsible for tendering the goods. May differ from the customer if the customer is acting as a freight forwarder or broker.',
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
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Individual quote line items (by mode, leg, service) require emission factors for itemized carbon disclosure, enabling customers to compare carbon impact of service options.',
    `charge_code_id` BIGINT COMMENT 'Foreign key linking to pricing.charge_code. Business justification: Spot quote line items reference specific charge codes for each component of the quoted price (base freight, fuel surcharge, THC, documentation fee, etc.). Currently uses STRING business key reference;',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created this spot quote line record. Supports audit trail and accountability.',
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
    `carbon_offset_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_program. Business justification: Contract rates with carbon-neutral service commitments must reference specific offset programs for customer verification, audit trail, and cost reconciliation of offset premiums.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Contract rates are negotiated with specific carriers. Carrier_id is essential for routing decisions, margin analysis against carrier buy rates, and contract compliance monitoring. Core to contract rat',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Contract rates should specify the exact carrier service they apply to (not just carrier). This precision is required for automated rating systems to match customer service selection to contracted rate',
    `commodity_rate_class_id` BIGINT COMMENT 'Foreign key linking to pricing.commodity_rate_class. Business justification: Contract pricing teams link negotiated rates to standard commodity classifications for hazmat surcharges, special handling requirements, insurance thresholds, and freight class validation ensuring rat',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for whom this contract rate applies.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the approving authority who authorized this contract rate, especially for deviation approvals.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Contract rates negotiate pricing for specific customer lanes. Lane_id anchors contracted pricing to network routes, enabling contract rate application during shipment rating and customer billing.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Contract rates drive revenue streams that must be allocated to profit centers for segment reporting, EBITDA tracking, and business unit performance management. Business need: contract revenue attribut',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Contract pricing analysts track which published rate card served as baseline for negotiated contract rates to calculate discount percentages, maintain rate floor compliance, and justify pricing during',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Contract rates can cover entire corridors (e.g., trans-Pacific service). Service_corridor_id anchors contracted corridor pricing, enabling corridor-level rate application for multi-leg contracted move',
    `trade_document_id` BIGINT COMMENT 'Foreign key linking to document.trade_document. Business justification: Contract rates require supporting trade documentation (certificates of origin, commercial invoices) for customs valuation and duty calculation. Real business process: customs clearance where contracte',
    `approval_date` DATE COMMENT 'Date on which this contract rate was approved by the authorizing authority.',
    `approval_status` STRING COMMENT 'Approval workflow status for rates requiring management authorization (e.g., below-floor rates, emergency rates, special commodity rates).. Valid values are `not_required|pending|approved|rejected`',
    `base_rate` DECIMAL(18,2) COMMENT 'Negotiated base rate amount per unit as defined by rate_basis, excluding surcharges and accessorial charges.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract rate record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the rate is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether this rate represents a deviation from standard pricing policy (e.g., below-floor approval, emergency rate, special commodity exception).',
    `deviation_reason` STRING COMMENT 'Business justification for rate deviation, including reason code and narrative explanation (e.g., competitive match, strategic account, volume commitment, market conditions).',
    `dim_weight_divisor` STRING COMMENT 'Divisor used to calculate dimensional weight from volumetric measurements (length x width x height / divisor). Common values: 5000 for air, 6000 for express.',
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
    `employee_id` BIGINT COMMENT 'User ID or name of the pricing analyst or system user who created this pricing rule record.',
    `charge_code_id` BIGINT COMMENT 'Foreign key linking to pricing.charge_code. Business justification: Pricing rules define automated rate adjustment logic based on specific charge types. The rule must reference the authoritative charge code definition to determine applicability, calculation basis, rev',
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
    `customer_tier` STRING COMMENT 'Customer segmentation tier to which this rule applies. Used for tier-based discount rules. Null if rule applies to all customers.. Valid values are `platinum|gold|silver|bronze|standard`',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` (
    `incoterms_charge_allocation_id` BIGINT COMMENT 'Unique identifier for the Incoterms charge allocation rule. Primary key.',
    `employee_id` BIGINT COMMENT 'Username or identifier of the user who created this allocation rule record.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the charge allocated to the responsible party (0.00 to 100.00). Used when charges are split between parties.',
    `allocation_rule_description` STRING COMMENT 'Detailed business description of how this charge is allocated under the Incoterms rule, including any special conditions or exceptions.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this charge allocation rule (active, inactive, pending approval, superseded by newer rule).. Valid values are `active|inactive|pending|superseded`',
    `charge_category` STRING COMMENT 'Category of freight charge being allocated (e.g., origin charges, main carriage, destination charges, customs duties, insurance, terminal handling). [ENUM-REF-CANDIDATE: origin_charges|main_carriage|destination_charges|customs_duties|insurance|terminal_handling|documentation|inspection — 8 candidates stripped; promote to reference product]',
    `charge_sequence` STRING COMMENT 'Sequence number indicating the order in which charges are applied or displayed within the Incoterms rule.',
    `charge_subcategory` STRING COMMENT 'Detailed subcategory of the charge (e.g., THC, BAF, GRI, export clearance, import clearance, delivery to door).',
    `compliance_notes` STRING COMMENT 'Additional notes regarding regulatory compliance, customs requirements, or trade compliance considerations for this allocation rule.',
    `cost_center_code` STRING COMMENT 'Cost center code for internal cost allocation and P&L reporting of this charge category.',
    `cost_transfer_point` STRING COMMENT 'Physical location or event at which cost responsibility transfers from seller to buyer under this Incoterms rule.. Valid values are `seller_premises|carrier_terminal|port_of_loading|port_of_discharge|destination_terminal|buyer_premises`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation rule record was first created in the system.',
    `customs_clearance_responsibility` STRING COMMENT 'Party responsible for customs clearance formalities under this Incoterms rule (seller, buyer, shared, or not applicable).. Valid values are `seller|buyer|shared|not_applicable`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the shipment destination. Used to determine jurisdiction-specific charge allocation rules.',
    `effective_from_date` DATE COMMENT 'Date from which this charge allocation rule becomes effective and should be applied to shipments.',
    `effective_to_date` DATE COMMENT 'Date until which this charge allocation rule remains effective. Null indicates the rule is currently active with no planned end date.',
    `exception_handling_rule` STRING COMMENT 'Instructions for handling exceptions or special cases that deviate from the standard allocation rule.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this charge category should be posted for financial reporting.',
    `incoterms_code` STRING COMMENT 'Three-letter Incoterms 2020 rule code defining the allocation of costs, risks, and responsibilities between buyer and seller in international trade. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_name` STRING COMMENT 'Full descriptive name of the Incoterms rule (e.g., Delivered Duty Paid, Free on Board).',
    `incoterms_version` STRING COMMENT 'Version year of the Incoterms rules being applied (e.g., 2020, 2010).. Valid values are `2020|2010|2000`',
    `insurance_responsibility` STRING COMMENT 'Party responsible for arranging cargo insurance under this Incoterms rule (seller, buyer, optional, or not required).. Valid values are `seller|buyer|optional|not_required`',
    `is_billable_to_customer` BOOLEAN COMMENT 'Indicates whether this charge should appear on the customer invoice (true) or is absorbed by the carrier (false).',
    `is_mandatory_charge` BOOLEAN COMMENT 'Indicates whether this charge is mandatory under the Incoterms rule (true) or optional/negotiable (false).',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the shipment origin. Used to determine jurisdiction-specific charge allocation rules.',
    `priority_rank` STRING COMMENT 'Priority ranking used to resolve conflicts when multiple allocation rules could apply to the same charge. Lower numbers indicate higher priority.',
    `responsible_party` STRING COMMENT 'Party responsible for paying this charge category under the specified Incoterms rule (shipper, consignee, carrier, seller, buyer).. Valid values are `shipper|consignee|carrier|seller|buyer`',
    `revenue_recognition_rule` STRING COMMENT 'Timing rule for when revenue from this charge category should be recognized (at origin, at destination, over transit period, at delivery, at customs clearance).. Valid values are `at_origin|at_destination|over_transit|at_delivery|at_customs_clearance`',
    `risk_transfer_point` STRING COMMENT 'Physical location or event at which risk transfers from seller to buyer under this Incoterms rule (e.g., seller premises, carrier terminal, port of loading).. Valid values are `seller_premises|carrier_terminal|port_of_loading|port_of_discharge|destination_terminal|buyer_premises`',
    `shipment_direction` STRING COMMENT 'Direction of shipment flow for which this allocation applies (export, import, domestic, cross-border).. Valid values are `export|import|domestic|cross_border`',
    `trade_lane_code` STRING COMMENT 'Code identifying the specific trade lane or route corridor (e.g., USEU for US-Europe) for which this allocation rule applies.',
    `transport_mode` STRING COMMENT 'Mode of transport to which this allocation rule applies (air, ocean, road, rail, multimodal, or any mode).. Valid values are `air|ocean|road|rail|multimodal|any`',
    `updated_by` STRING COMMENT 'Username or identifier of the user who last updated this allocation rule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation rule record was last modified in the system.',
    CONSTRAINT pk_incoterms_charge_allocation PRIMARY KEY(`incoterms_charge_allocation_id`)
) COMMENT 'Reference table defining how freight charges are allocated between shipper and consignee under each Incoterms rule (EXW, FOB, CIF, DDP, DAP, FCA, CPT, CIP, DAT, CFR). Captures Incoterms code, charge category (origin charges, main carriage, destination charges, customs duties, insurance), responsible party (shipper/consignee/carrier), and applicable transport modes. Critical for cross-border pricing, DDP/DAP billing, and revenue recognition in the billing domain.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` (
    `lane_rate_zone_id` BIGINT COMMENT 'Unique identifier for the lane rate zone definition. Primary key.',
    `employee_id` BIGINT COMMENT 'User ID or system identifier of the person or process that created this zone definition record.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Zone-based rates reference the lanes they apply to. Lane_id links zone pricing to network lanes, enabling zone-to-lane rate lookup for postal code-based rating and remote area surcharge application.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` (
    `rate_audit_id` BIGINT COMMENT 'Unique identifier for the rate audit record. Primary key.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Rate changes may be initiated by agents in their territories under GSA authority. Agent_id tracks the agent responsible for the change, enabling accountability and performance monitoring of agent-mana',
    `agreement_id` BIGINT COMMENT 'Identifier of the customer contract affected by this rate change. Null for general tariff or rate card changes not tied to a specific contract.',
    `agreement_version_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_version. Business justification: Compliance and audit teams track which specific agreement version was in effect when rate changes occurred for regulatory audit trails, SOX compliance, and dispute resolution requiring point-in-time c',
    `billing_dispute_id` BIGINT COMMENT 'Reference to a billing dispute case that triggered this audit review or rate correction. Links to the dispute resolution system.',
    `carbon_offset_transaction_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_transaction. Business justification: Rate changes affecting carbon offset charges must be auditable to specific offset transactions for financial reconciliation, customer billing disputes, and regulatory compliance verification.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Rate changes often result from carrier GRI announcements or contract amendments. Carrier_id enables audit trail of carrier-initiated rate changes for compliance, dispute resolution, and carrier perfor',
    `compliance_review_id` BIGINT COMMENT 'Foreign key linking to contract.compliance_review. Business justification: Compliance officers conducting contract compliance reviews reference rate audit trails to verify pricing changes were executed according to contract terms, approval workflows, and regulatory requireme',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account affected by this rate change. Null for general tariff changes applicable to all customers.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Rate changes must be tracked within fiscal periods for SOX compliance audit trails, period-over-period variance analysis, and revenue impact reconciliation. Real process: finance reconciles rate chang',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Rate audits track changes to lane-specific rates. Lane_id provides audit trail for lane pricing changes, enabling rate change history by lane for compliance, dispute resolution, and pricing governance',
    `employee_id` BIGINT COMMENT 'System identifier of the user who executed the rate change. Links to the user management system for accountability and audit trail.',
    `superseded_by_audit_rate_audit_id` BIGINT COMMENT 'Reference to the subsequent audit record that supersedes this change. Creates a chain of rate modifications for complete lineage tracking.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Rate audits reference specific transport documents (AWB, BOL) to verify charges applied match contracted rates. Real business process: freight bill audit and dispute resolution where auditors compare ',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Rate audits track incident-driven pricing adjustments (e.g., hazmat surcharge increases after spills). Logistics operators trace rate changes to triggering HSE incidents for compliance reporting, cost',
    `approval_status` STRING COMMENT 'Current approval state of the rate change. Tracks whether the modification has been reviewed and authorized per pricing governance policies.. Valid values are `pending|approved|rejected|auto_approved|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the rate change was approved. Null if approval is not required or still pending.',
    `approved_by_user_name` STRING COMMENT 'Full name of the user who approved the rate change. Human-readable identifier for audit and compliance reporting.',
    `audit_timestamp` TIMESTAMP COMMENT 'Date and time when the rate change event was recorded in the audit trail. Represents the exact moment the modification was captured in the system.',
    `change_event_type` STRING COMMENT 'Type of rate modification event being audited. Categorizes the nature of the pricing change for tracking and analysis purposes.. Valid values are `rate_update|surcharge_adjustment|gri_application|baf_adjustment|thc_update|contract_rate_revision`',
    `change_magnitude` DECIMAL(18,2) COMMENT 'Numeric difference between new and previous values for quantitative fields. Calculated as new_value minus previous_value for amounts, rates, and percentages.',
    `change_percentage` DECIMAL(18,2) COMMENT 'Percentage change from previous to new value. Calculated as ((new_value - previous_value) / previous_value) * 100 for rate increases or decreases.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the rate change. Used for categorizing and analyzing pricing change drivers.. Valid values are `market_adjustment|cost_increase|competitive_pressure|contract_renewal|regulatory_compliance|correction`',
    `change_reason_description` STRING COMMENT 'Detailed explanation of why the rate change was made. Free-text field capturing business justification for audit and compliance purposes.',
    `change_source` STRING COMMENT 'The mechanism or channel through which the rate change was initiated. Distinguishes between manual updates, automated processes, and external system feeds.. Valid values are `manual|automated|edi_feed|api_integration|bulk_upload|system_calculation`',
    `change_source_system` STRING COMMENT 'The name or identifier of the system that originated the rate change. References operational systems such as SAP TM, Oracle TMS, or pricing management platforms.',
    `changed_by_role` STRING COMMENT 'The organizational role or job function of the user who made the change. Examples include Pricing Analyst, Revenue Manager, System Administrator.',
    `changed_by_user_name` STRING COMMENT 'Full name of the user who executed the rate change. Human-readable identifier for audit reports and dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this audit record was first created in the lakehouse. Represents data ingestion time, distinct from the business event timestamp.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate values. Indicates the currency in which previous and new values are denominated.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'The operational system of record from which this audit record was captured. Examples include SAP TM, Oracle TMS, or proprietary pricing platforms.',
    `effective_date` DATE COMMENT 'The date when the rate change becomes active and applicable to new shipments or contracts. Critical for revenue recognition and billing accuracy.',
    `entity_reference_code` STRING COMMENT 'The unique identifier of the specific pricing entity that was changed. References the primary key of the modified rate card, tariff, surcharge, or contract rate record.',
    `entity_type` STRING COMMENT 'The type of pricing entity that was modified. Identifies which pricing component was changed in the rate structure. [ENUM-REF-CANDIDATE: rate_card|tariff|surcharge_schedule|contract_rate|spot_quote|accessorial_charge|dim_weight_rule|fuel_index — 8 candidates stripped; promote to reference product]',
    `expiration_date` DATE COMMENT 'The date when the rate change is superseded or no longer valid. Null for open-ended rate changes.',
    `field_label` STRING COMMENT 'Business-friendly label for the modified field. Human-readable description of what was changed for reporting and dispute resolution.',
    `field_name` STRING COMMENT 'The specific attribute or field within the pricing entity that was modified. Technical field name from the source pricing table.',
    `impact_assessment` STRING COMMENT 'Analysis of the business impact of this rate change. May include estimated revenue impact, affected shipment volume, or customer notification requirements.',
    `incoterm` STRING COMMENT 'The Incoterm governing charge allocation for this rate change. Determines which party bears freight costs and risk transfer points. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `new_value` DECIMAL(18,2) COMMENT 'The value of the field after the change was applied. Stored as string to accommodate various data types across different pricing entities.',
    `notes` STRING COMMENT 'Additional free-text comments or context about the rate change. Used for capturing special circumstances, exceptions, or supplementary information.',
    `previous_value` DECIMAL(18,2) COMMENT 'The value of the field before the change was applied. Stored as string to accommodate various data types across different pricing entities.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this rate change was driven by regulatory or compliance requirements. True for changes mandated by FMC, DOT, WCO, or other governing bodies.',
    `service_type` STRING COMMENT 'The logistics service type affected by the rate change. Examples include express delivery, freight forwarding, warehousing, last-mile delivery.',
    `transport_mode` STRING COMMENT 'The mode of transportation affected by the rate change. Aligns with IATA, IMO, and DOT transport mode classifications.. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this audit record was last modified in the lakehouse. Tracks any corrections or enrichments applied post-ingestion.',
    `version_number` STRING COMMENT 'Sequential version number of the pricing entity after this change. Increments with each modification to track rate evolution over time.',
    CONSTRAINT pk_rate_audit PRIMARY KEY(`rate_audit_id`)
) COMMENT 'Audit trail of rate card and tariff changes, capturing every modification event including rate updates, surcharge adjustments, GRI applications, and contract rate revisions. Records the changed entity type, entity reference, previous value, new value, change reason, change source (manual/automated/EDI feed), changed by user, and timestamp. Supports regulatory compliance, revenue audit, and dispute resolution for billing discrepancies.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`rate_request` (
    `rate_request_id` BIGINT COMMENT 'Unique identifier for the rate request record. Primary key.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Customers or sales may request rates from specific agents in remote markets. Agent_id tracks the agent responsible for providing the quote, enabling agent performance tracking and territory-based rate',
    `agreement_id` BIGINT COMMENT 'Reference to the master contract or customer agreement under which this rate request is being processed. Links to contract terms, volume commitments, and service level agreements (SLA).',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Rate requests are often directed to specific carriers for capacity or service feasibility assessment. Carrier_id tracks which carrier the request targets, enabling carrier response tracking and rate r',
    `contract_dispute_id` BIGINT COMMENT 'Foreign key linking to contract.contract_dispute. Business justification: Customer service teams handling contract disputes reference original rate requests that led to disputed contract rates for root cause analysis, demonstrating pricing intent, and supporting resolution ',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for which the rate is being requested. Links to the customer master data for account-specific pricing rules and contract terms.',
    `employee_id` BIGINT COMMENT 'Name or user ID of the pricing manager or authority who approved the rate request. Used for audit trail and accountability in pricing decisions.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Rate requests specify lanes needing pricing. Lane_id captures the requested route, enabling rate request tracking by lane, request fulfillment analysis, and lane-level pricing gap identification.',
    `approval_date` DATE COMMENT 'Date when the rate request was formally approved by the authorized pricing manager or committee. Null if request is pending, rejected, or withdrawn.',
    `approved_rate_amount` DECIMAL(18,2) COMMENT 'Final rate amount approved by the pricing authority. May differ from the requested rate based on cost analysis, margin requirements, and competitive positioning. Null if request is not yet approved.',
    `approved_rate_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the approved rate amount. Typically matches the requested currency but may differ based on contract terms or multi-currency agreements.. Valid values are `^[A-Z]{3}$`',
    `business_justification` STRING COMMENT 'Detailed explanation of the business rationale for the rate request, including competitive pressures, customer retention, market conditions, volume commitments, or strategic account considerations. Used by pricing analysts and approvers to evaluate the request.',
    `commodity_type` STRING COMMENT 'General classification of the goods to be shipped, such as electronics, perishables, hazardous materials, or general cargo. Influences handling requirements, insurance rates, and applicable surcharges.',
    `competitive_benchmark_rate` DECIMAL(18,2) COMMENT 'Market rate or competitor rate used as a reference point for pricing decision. Confidential business intelligence used to assess competitiveness of the requested rate.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the rate request record was first created in the pricing system. Used for audit trail and request age analysis.',
    `estimated_shipment_count` STRING COMMENT 'Projected number of shipments over the contract period or rate validity period. Used for volume commitment pricing and tiered rate structures.',
    `estimated_volume` DECIMAL(18,2) COMMENT 'Estimated cubic volume of the shipment in the unit specified by volume_unit. Used for volumetric weight calculation and container/vehicle capacity planning.',
    `estimated_weight` DECIMAL(18,2) COMMENT 'Estimated gross weight of the shipment in the unit specified by weight_unit. Used for rate calculation, capacity planning, and dimensional weight (DIM weight) comparison.',
    `hs_code` STRING COMMENT 'International standardized system of names and numbers for classifying traded products. Used for customs declarations, duty calculation, and trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `incoterm` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyers and sellers for the delivery of goods, including cost allocation, risk transfer, and charge responsibility. Influences which party pays for freight, insurance, and customs duties. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_hazardous` BOOLEAN COMMENT 'Flag indicating whether the commodity is classified as dangerous goods requiring special handling, documentation, and surcharges per IMDG Code or ICAO Technical Instructions.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the rate request record was last updated. Tracks changes to request details, status transitions, and approval decisions.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or clarifications related to the rate request. Used by sales, operations, and pricing teams for context and decision support.',
    `rate_basis` STRING COMMENT 'Unit basis on which the rate is calculated and charged: per kilogram, per shipment, per container (FCL/LCL), per pallet, per cubic meter (CBM), per Twenty-foot Equivalent Unit (TEU), per mile, or per hour for time-based services. [ENUM-REF-CANDIDATE: per_kg|per_shipment|per_container|per_pallet|per_cbm|per_teu|per_mile|per_hour — 8 candidates stripped; promote to reference product]',
    `rejection_reason` STRING COMMENT 'Explanation provided when a rate request is rejected, including reasons such as below-cost pricing, insufficient margin, lack of capacity, or non-compliance with pricing policy. Null if request is not rejected.',
    `request_date` DATE COMMENT 'Date when the rate request was formally submitted into the pricing system. Represents the business event timestamp for the request initiation.',
    `request_status` STRING COMMENT 'Current lifecycle status of the rate request in the approval workflow. Tracks progression from submission through review, approval decision, and final disposition. [ENUM-REF-CANDIDATE: submitted|under_review|pending_approval|approved|rejected|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Classification of the rate request indicating the nature of the pricing inquiry: spot quote for one-time shipments, contract rate for ongoing agreements, tariff revision for published rate updates, lane rate for specific trade lane pricing, volume commitment for tiered pricing, or special service for accessorial charges.. Valid values are `spot_quote|contract_rate|tariff_revision|lane_rate|volume_commitment|special_service`',
    `requested_effective_date` DATE COMMENT 'Date from which the requestor wants the new or revised rate to become effective and applicable to shipments.',
    `requested_rate_amount` DECIMAL(18,2) COMMENT 'Target rate amount proposed by the requestor for the specified service and trade lane. May be used as a negotiation starting point or benchmark for pricing approval.',
    `requested_rate_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the requested rate amount. Must align with customer billing currency and contract terms.. Valid values are `^[A-Z]{3}$`',
    `requestor_email` STRING COMMENT 'Primary email address of the rate request submitter for communication regarding the request status, clarifications, and final rate decision.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_name` STRING COMMENT 'Full name of the individual or organization submitting the rate request. For internal requests, this is the employee name; for external requests, this is the customer or partner contact name.',
    `requestor_phone` STRING COMMENT 'Contact phone number of the rate request submitter for urgent communications and clarifications during the review process.',
    `requestor_type` STRING COMMENT 'Classification of the party submitting the rate request: internal sales team, direct customer inquiry, operations team for capacity planning, carrier for backhaul rates, broker for spot market, or partner for alliance pricing.. Valid values are `internal_sales|customer_direct|operations|carrier|broker|partner`',
    `resolution_date` DATE COMMENT 'Date when the rate request reached a final disposition: approved, rejected, or withdrawn. Used for cycle time analysis and SLA compliance tracking.',
    `service_type` STRING COMMENT 'Type of logistics service for which the rate is being requested. Determines applicable rate structures, surcharges, and service level agreements (SLA). [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|multimodal|last_mile|warehousing|customs_brokerage — 9 candidates stripped; promote to reference product]',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for the requested rate. Influences base rate calculation, transit time, and applicable surcharges such as Bunker Adjustment Factor (BAF) for ocean or fuel surcharge for road.. Valid values are `air|ocean|road|rail|multimodal|courier`',
    `urgency_level` STRING COMMENT 'Priority classification indicating how quickly the rate request needs to be processed and approved. Critical requests require immediate attention, typically for time-sensitive customer opportunities.. Valid values are `critical|high|medium|low`',
    `valid_from_date` DATE COMMENT 'Start date of the approved rate validity period. Shipments on or after this date are eligible for the approved rate. Null if request is not yet approved.',
    `valid_to_date` DATE COMMENT 'End date of the approved rate validity period. Shipments after this date require a new rate request or revert to standard tariff rates. Null for open-ended rates or pending requests.',
    `volume_unit` STRING COMMENT 'Unit of measure for the estimated volume: cubic meters (cbm), cubic feet (cft), or liters. Used in conjunction with DIM weight rules and container load calculations.. Valid values are `cbm|cft|liter`',
    `weight_unit` STRING COMMENT 'Unit of measure for the estimated weight: kilograms (kg), pounds (lb), short tons (ton), or metric tons (mt). Must align with the applicable tariff and DIM weight rule.. Valid values are `kg|lb|ton|mt`',
    CONSTRAINT pk_rate_request PRIMARY KEY(`rate_request_id`)
) COMMENT 'Formal rate request submitted by sales, operations, or customers for a new or revised rate on a specific trade lane or service. Captures request reference, requestor type (internal sales/customer/carrier), requested service type, origin-destination, commodity, estimated volume, requested rate, business justification, urgency level, request status (submitted/under review/approved/rejected), and resolution date. Manages the pricing approval workflow in SAP TM and Salesforce CRM.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` (
    `gri_announcement_id` BIGINT COMMENT 'Unique identifier for the GRI announcement record.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Agents may announce GRIs on behalf of their principal carriers in their territories under GSA agreements. Agent_id tracks the announcing party for GSA compliance, commission calculation, and territory',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Carrier contract managers track which GRIs apply to specific carrier agreements for rate adjustment negotiations and contract amendment workflows. Links market-driven rate increases to contractual car',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier or shipping line issuing the GRI announcement.',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: General Rate Increase announcements affect carbon cost pass-through calculations; linking emission factors enables carbon-inclusive GRI impact assessment for customer contract amendments.',
    `employee_id` BIGINT COMMENT 'Name or identifier of the person or role who approved the acceptance decision.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: GRI (General Rate Increase) announcements are time-bound events impacting revenue forecasts and must be tracked by fiscal period for financial planning, quarterly guidance, and investor communications',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: GRI announcements apply to specific lanes. Lane_id scopes general rate increases to affected routes, enabling lane-level GRI impact analysis, customer notification by lane, and rate card update automa',
    `superseded_by_gri_gri_announcement_id` BIGINT COMMENT 'Reference to a subsequent GRI announcement that replaces or supersedes this one.',
    `transport_document_id` BIGINT COMMENT 'Identifier of the stored document or attachment containing the official GRI announcement.',
    `environmental_incident_id` BIGINT COMMENT 'Foreign key linking to safety.environmental_incident. Business justification: Carriers announce GRIs to recover costs from major environmental incidents (fuel spills, hazmat cleanup). Transport operators track which environmental incidents triggered rate increases for customer ',
    `acceptance_date` DATE COMMENT 'Date when the organization formally accepted or rejected the GRI announcement.',
    `acceptance_status` STRING COMMENT 'Internal status indicating whether the organization has accepted or rejected this carrier GRI for incorporation into pricing.. Valid values are `pending|accepted|rejected|partially_accepted|negotiated`',
    `announcement_source_url` STRING COMMENT 'Web URL or document reference where the original GRI announcement was published.',
    `announcement_status` STRING COMMENT 'Current lifecycle status of the GRI announcement indicating its acceptance and implementation state.. Valid values are `draft|published|accepted|rejected|withdrawn|superseded`',
    `announcing_party_type` STRING COMMENT 'Classification of the entity issuing the GRI announcement.. Valid values are `carrier|trade_body|industry_association|regulatory_authority|market_consortium`',
    `applies_to_contract` BOOLEAN COMMENT 'Indicates whether this GRI applies to existing contract pricing or only to spot rates.',
    `applies_to_spot` BOOLEAN COMMENT 'Indicates whether this GRI applies to spot quote pricing.',
    `commodity_scope` STRING COMMENT 'Specific commodity types or HS code ranges to which this GRI applies, or ALL for universal application.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this GRI announcement record was first created in the system.',
    `customer_notification_date` DATE COMMENT 'Date when customers were notified of this GRI and its impact on their pricing.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether customer notification workflows must be triggered for this GRI.',
    `customer_segment_scope` STRING COMMENT 'Customer segments or tiers to which this GRI applies, or ALL for universal application.',
    `data_source_system` STRING COMMENT 'Name of the operational system or external feed from which this GRI announcement was ingested.',
    `effective_date` DATE COMMENT 'Date from which the GRI becomes applicable to new bookings and shipments.',
    `equipment_type_scope` STRING COMMENT 'Container or equipment types affected by this GRI, such as 20GP, 40HC, reefer, or ALL.',
    `expiration_date` DATE COMMENT 'Date when the GRI ceases to be applicable, nullable for indefinite GRIs.',
    `gri_amount` DECIMAL(18,2) COMMENT 'Flat monetary increase amount per unit when GRI type is flat_amount.',
    `gri_currency` STRING COMMENT 'Three-letter ISO currency code for the GRI amount.. Valid values are `^[A-Z]{3}$`',
    `gri_name` STRING COMMENT 'Human-readable name or title of the GRI announcement for identification purposes.',
    `gri_percentage` DECIMAL(18,2) COMMENT 'Percentage increase applied to base rates when GRI type is percentage.',
    `gri_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this GRI announcement by the carrier or trade body.. Valid values are `^GRI-[A-Z0-9]{6,20}$`',
    `gri_type` STRING COMMENT 'Classification of how the GRI increase is structured and calculated.. Valid values are `flat_amount|percentage|tiered|variable`',
    `impact_assessment` STRING COMMENT 'Internal assessment of the financial and operational impact of this GRI on the organizations freight forwarding margins and customer pricing.',
    `incoterm_scope` STRING COMMENT 'Incoterms to which this GRI applies, such as FOB, CIF, DDP, or ALL.',
    `market_justification` STRING COMMENT 'Textual explanation provided by the carrier or trade body for the rate increase, such as fuel cost escalation or capacity constraints.',
    `notes` STRING COMMENT 'Free-text field for additional comments, exceptions, or internal observations about this GRI announcement.',
    `notice_date` DATE COMMENT 'Date when the GRI announcement was officially published or communicated to the market.',
    `notice_period_days` STRING COMMENT 'Number of days between notice date and effective date, representing advance notice provided to customers.',
    `priority_rank` STRING COMMENT 'Numeric ranking used to resolve conflicts when multiple GRIs apply to the same trade lane and date range.',
    `rate_card_update_status` STRING COMMENT 'Status of automated updates to rate_card records triggered by this GRI announcement.. Valid values are `pending|in_progress|completed|failed`',
    `service_type` STRING COMMENT 'Specific service category within the transport mode affected by this GRI. [ENUM-REF-CANDIDATE: FCL|LCL|FTL|LTL|express|standard|economy — 7 candidates stripped; promote to reference product]',
    `surcharge_schedule_update_status` STRING COMMENT 'Status of automated updates to surcharge_schedule records triggered by this GRI announcement.. Valid values are `pending|in_progress|completed|failed`',
    `transport_mode` STRING COMMENT 'Primary mode of transportation to which this GRI applies.. Valid values are `ocean|air|road|rail|multimodal`',
    `unit_of_measure` STRING COMMENT 'Unit basis for the GRI amount calculation.. Valid values are `TEU|CBM|kg|ton|shipment|container`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this GRI announcement record was last modified.',
    CONSTRAINT pk_gri_announcement PRIMARY KEY(`gri_announcement_id`)
) COMMENT 'General Rate Increase (GRI) announcement record capturing carrier-issued or market-wide rate increase notifications for ocean and air freight. Captures GRI reference number, announcing carrier or trade body, applicable trade lane, transport mode, GRI amount (flat or percentage), effective date, notice date, and acceptance status. Drives automated updates to surcharge_schedule and rate_card records. Critical for freight forwarding margin management and customer notification workflows.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` (
    `commodity_rate_class_id` BIGINT COMMENT 'Unique identifier for the commodity rate class record. Primary key.',
    `employee_id` BIGINT COMMENT 'Username or identifier of the pricing manager or system administrator who approved this commodity rate class.',
    `superseded_by_class_commodity_rate_class_id` BIGINT COMMENT 'Reference to the commodity rate class that replaces this one when it expires or is deprecated. Enables version tracking and migration.',
    `applicable_transport_modes` STRING COMMENT 'Comma-separated list of transport modes applicable for this commodity (e.g., AIR, OCEAN, ROAD, RAIL). Determines which rate cards and tariffs apply. [ENUM-REF-CANDIDATE: AIR|OCEAN|ROAD|RAIL|MULTIMODAL|COURIER|PARCEL — promote to reference product]',
    `approval_status` STRING COMMENT 'Approval workflow status for this commodity rate class. Only approved classifications are used in production pricing.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this commodity rate class was approved for use in production pricing systems.',
    `classification_status` STRING COMMENT 'Current lifecycle status of this commodity rate class. Active classifications are used in pricing; inactive are retained for historical reference.. Valid values are `active|inactive|pending_review|deprecated`',
    `commodity_code` STRING COMMENT 'Internal unique code identifying the commodity type for rating purposes. Used as business identifier in rate card lookups and pricing systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `commodity_description` STRING COMMENT 'Detailed description of the commodity type, including characteristics, typical packaging, and handling considerations.',
    `commodity_name` STRING COMMENT 'Human-readable name of the commodity type (e.g., Electronics, Apparel, Perishables, Machinery).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this commodity rate class record was first created in the system.',
    `customs_inspection_likelihood` STRING COMMENT 'Estimated likelihood of customs inspection for this commodity type. Affects transit time estimates and customs clearance planning.. Valid values are `low|medium|high|very_high`',
    `default_dim_factor` STRING COMMENT 'Default dimensional weight divisor for this commodity class. Common values: 5000 for air freight, 6000 for express parcels. Used when commodity-specific DIM rules apply.',
    `density_class` STRING COMMENT 'Classification of commodity based on weight-to-volume ratio. Affects dimensional weight calculations and space-based pricing.. Valid values are `high_density|medium_density|low_density|very_low_density`',
    `effective_date` DATE COMMENT 'Date from which this commodity rate class becomes effective for pricing and rating purposes.',
    `expiration_date` DATE COMMENT 'Date on which this commodity rate class expires and is no longer valid for new shipments. Null indicates no expiration.',
    `export_controlled_flag` BOOLEAN COMMENT 'Indicates whether the commodity is subject to export control regulations requiring special licenses or permits.',
    `fragile_flag` BOOLEAN COMMENT 'Indicates whether the commodity is fragile and requires special handling to prevent damage.',
    `freight_class` STRING COMMENT 'National Motor Freight Classification (NMFC) freight class for road freight rating. Classes range from 50 (densest) to 500 (least dense). Used primarily for LTL (Less Than Truckload) pricing.. Valid values are `^(50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500)$`',
    `hazmat_class` STRING COMMENT 'UN hazardous material classification class (e.g., Class 3 for flammable liquids, Class 8 for corrosives). Applicable only when hazmat_flag is true.. Valid values are `^(1|2.1|2.2|2.3|3|4.1|4.2|4.3|5.1|5.2|6.1|6.2|7|8|9)?$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the commodity is classified as hazardous material requiring special handling, documentation, and surcharges.',
    `high_value_flag` BOOLEAN COMMENT 'Indicates whether the commodity is classified as high-value cargo requiring additional insurance, security measures, and handling surcharges.',
    `high_value_threshold` DECIMAL(18,2) COMMENT 'Monetary threshold above which the commodity is considered high-value. Expressed in the currency specified in threshold_currency.',
    `hs_code_range_end` STRING COMMENT 'Ending HS code in the range applicable to this commodity rate class. Defines the upper bound of the HS code range for this commodity.. Valid values are `^[0-9]{6,10}$`',
    `hs_code_range_start` STRING COMMENT 'Starting HS code in the range applicable to this commodity rate class. HS codes are used for customs classification and tariff determination.. Valid values are `^[0-9]{6,10}$`',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether cargo insurance is mandatory for this commodity type due to value or risk profile.',
    `minimum_charge_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the minimum charge override amount.. Valid values are `^[A-Z]{3}$`',
    `minimum_charge_override` DECIMAL(18,2) COMMENT 'Commodity-specific minimum charge that overrides standard tariff minimums. Expressed in the currency specified in minimum_charge_currency.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this commodity rate class record was last modified.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, exceptions, or special instructions for this commodity rate class.',
    `packaging_requirements` STRING COMMENT 'Description of mandatory packaging requirements for this commodity (e.g., UN-certified packaging for hazmat, wooden crates for fragile items).',
    `perishable_flag` BOOLEAN COMMENT 'Indicates whether the commodity is perishable and requires expedited handling and time-sensitive delivery.',
    `prohibited_countries` STRING COMMENT 'Comma-separated list of three-letter ISO country codes where this commodity is prohibited from import or export due to regulatory restrictions.',
    `rate_class` STRING COMMENT 'Internal rate class code used for pricing lookup in rate cards. Maps commodity to specific pricing tier or treatment (e.g., CLASS_A, CLASS_B, PREMIUM, STANDARD).. Valid values are `^[A-Z0-9]{1,6}$`',
    `rate_class_description` STRING COMMENT 'Description of the rate class and its pricing treatment characteristics.',
    `rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base rates for this commodity class. Values greater than 1.0 indicate premium pricing; less than 1.0 indicate discounted pricing.',
    `restricted_transport_modes` STRING COMMENT 'Comma-separated list of transport modes NOT permitted for this commodity due to regulatory or safety restrictions (e.g., AIR for certain hazmat classes).',
    `special_handling_requirements` STRING COMMENT 'Free-text description of special handling requirements for this commodity (e.g., keep upright, protect from moisture, requires tail-lift delivery).',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether the commodity can be stacked during transport and warehousing. Affects loading optimization and space utilization.',
    `surcharge_applicability` STRING COMMENT 'Comma-separated list of surcharge types applicable to this commodity (e.g., HAZMAT, REEFER, HIGH_VALUE, OVERSIZE, SECURITY). Drives accessorial charge calculations.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the commodity requires temperature-controlled transport (refrigerated or heated). Triggers reefer surcharges and specialized equipment requirements.',
    `temperature_range_max` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius required for temperature-controlled commodities. Applicable only when temperature_controlled_flag is true.',
    `temperature_range_min` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius required for temperature-controlled commodities. Applicable only when temperature_controlled_flag is true.',
    `threshold_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the high value threshold amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous substance (e.g., UN1203 for gasoline). Applicable only for hazardous commodities.. Valid values are `^UN[0-9]{4}$`',
    `version_number` STRING COMMENT 'Version number of this commodity rate class definition. Incremented when classification rules or attributes are updated.',
    CONSTRAINT pk_commodity_rate_class PRIMARY KEY(`commodity_rate_class_id`)
) COMMENT 'Commodity classification for freight rating purposes, mapping commodity types to rate classes, freight classes (NMFC for road freight), and applicable pricing treatments. Captures commodity code, commodity description, HS code range, freight class, rate class, hazmat flag, temperature-controlled flag, high-value flag, applicable transport modes, and special handling requirements. Drives commodity-specific rate lookups and surcharge applicability in rate cards.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`charge_code` (
    `charge_code_id` BIGINT COMMENT 'Primary key for charge_code',
    `employee_id` BIGINT COMMENT 'Name or user identifier of the pricing manager, finance director, or authorized approver who approved this charge code for production use.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carrier buy rates represent cost of goods sold that must be allocated to cost centers for expense tracking, budget variance analysis, and cost center performance management. Real process: procurement ',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this buy rate. Links to user or employee master for audit trail.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Carrier buy rates are negotiated per lane. Lane_id links carrier cost to specific routes, enabling buy-sell margin analysis, carrier selection optimization, and cost-to-serve reporting by lane.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Buy rates impact gross margin calculations that roll up to profit center P&L statements for segment profitability analysis. Business need: segment EBITDA reporting requires buy rate costs attributed t',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Carrier buy rates negotiated for corridors (multi-leg carrier services). Service_corridor_id links carrier cost to multi-leg routes, enabling corridor-level margin analysis and carrier performance eva',
    `superseded_by_rate_carrier_buy_rate_id` BIGINT COMMENT 'Reference to the newer buy rate that replaces this one. Used to maintain rate lineage and history.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` (
    `service_level_rate_id` BIGINT COMMENT 'Unique identifier for the service level rate record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Service level rates are carrier-specific (each carrier has different service tiers). Carrier_id is required to match customer service selection to the correct carriers rates for accurate quote genera',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Service level rates should link directly to the carrier_service they price. This is the most precise link for operational rating engines, enabling exact service matching and transit time calculation.',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Service level pricing (express vs. economy) must incorporate mode-specific emission factors for green service tier differentiation and carbon-based pricing premiums.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this service level rate for publication and use.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Service level pricing varies by lane (express, standard, economy). Lane_id connects premium service rates to routes, enabling service-level rate lookup during quote generation and shipment rating.',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Service level pricing for corridors (express corridor vs. standard). Service_corridor_id connects premium rates to multi-leg routes, enabling service-level corridor pricing for international express s',
    `all_in_rate_flag` BOOLEAN COMMENT 'Indicates whether this is an all-inclusive rate with no additional surcharges. True if all costs are included, False if surcharges apply separately.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this service level rate was approved for use.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'Base rate amount for the service level before surcharges and adjustments. Represents the starting price for the service.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this service level rate record was first created in the system.',
    `customer_segment` STRING COMMENT 'Customer segment this rate applies to (retail, commercial, enterprise, government, ecommerce). Used for segment-specific pricing.. Valid values are `retail|commercial|enterprise|government|ecommerce`',
    `delivery_time_window_end` STRING COMMENT 'End time of the delivery window commitment in HH:MM format (e.g., 10:30 for 10:30 AM delivery window end).. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `delivery_time_window_start` STRING COMMENT 'Start time of the delivery window commitment in HH:MM format (e.g., 08:00 for 8:00 AM delivery window start).. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `dim_weight_applicable` BOOLEAN COMMENT 'Indicates whether dimensional weight calculation applies to this service level. True if DIM weight pricing is used, False if only actual weight is used.',
    `dim_weight_divisor` STRING COMMENT 'Divisor used to calculate dimensional weight from volume (e.g., 5000 for air freight, 6000 for express). Volume in cubic cm divided by this value yields DIM weight in kg.',
    `effective_date` DATE COMMENT 'Date from which this service level rate becomes active and applicable for pricing.',
    `expiration_date` DATE COMMENT 'Date on which this service level rate expires and is no longer applicable. Null for open-ended rates.',
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether fuel surcharge applies to this service level rate. True if fuel surcharge is added, False if rate is all-in.',
    `fuel_surcharge_percentage` DECIMAL(18,2) COMMENT 'Percentage of base rate applied as fuel surcharge (e.g., 15.50 for 15.5%). Null if fuel surcharge is not applicable or calculated separately.',
    `gri_applicable` BOOLEAN COMMENT 'Indicates whether General Rate Increase adjustments apply to this service level. True if GRI is applicable, False otherwise.',
    `incoterm_code` STRING COMMENT 'Three-letter Incoterms code defining cost and risk allocation (e.g., DDP, DAP, FOB, CIF, EXW). Determines which party bears freight charges.. Valid values are `^[A-Z]{3}$`',
    `insurance_included` BOOLEAN COMMENT 'Indicates whether cargo insurance is included in the service level rate. True if insurance is included, False if insurance is optional or charged separately.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum charge amount cap for this service level. Used to limit pricing exposure on high-value or high-weight shipments.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum charge amount that applies regardless of shipment weight or volume. Ensures minimum revenue per shipment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this service level rate record was last modified.',
    `peak_season_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether peak season surcharge applies to this service level during high-demand periods. True if applicable, False otherwise.',
    `per_cbm_rate` DECIMAL(18,2) COMMENT 'Rate charged per cubic meter of shipment volume. Used for volume-based pricing calculation.',
    `per_kg_rate` DECIMAL(18,2) COMMENT 'Rate charged per kilogram of shipment weight. Used for weight-based pricing calculation.',
    `priority_rank` STRING COMMENT 'Priority ranking for rate selection when multiple rates apply. Lower numbers indicate higher priority (1 = highest priority).',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO currency code in which the rate is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `rate_status` STRING COMMENT 'Current lifecycle status of the rate: draft (pending approval), active (in use), suspended (temporarily inactive), expired (past expiration date), superseded (replaced by newer rate).. Valid values are `draft|active|suspended|expired|superseded`',
    `rate_type` STRING COMMENT 'Classification of rate: published (standard tariff), contract (negotiated agreement), spot (one-time quote), promotional (temporary discount).. Valid values are `published|contract|spot|promotional`',
    `saturday_delivery_available` BOOLEAN COMMENT 'Indicates whether Saturday delivery is available for this service level. True if available, False otherwise.',
    `service_level_code` STRING COMMENT 'Unique business identifier code for the service level (e.g., NDA, 2DAY, ECO, PRI, DEF). Used for operational reference and system integration.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `service_level_name` STRING COMMENT 'Human-readable name of the service level (e.g., Next Day Air, 2-Day Express, Economy Ground, Priority Overnight, Deferred Delivery).',
    `service_type` STRING COMMENT 'Category of service offering this rate applies to (express, courier, parcel, freight, specialized).. Valid values are `express|courier|parcel|freight|specialized`',
    `signature_required` BOOLEAN COMMENT 'Indicates whether delivery signature is required for this service level. True if signature is mandatory, False if signature is optional or not required.',
    `sla_commitment_type` STRING COMMENT 'Type of SLA commitment for this service level: guaranteed (money-back guarantee), target (best effort with tracking), best_effort (no commitment).. Valid values are `guaranteed|target|best_effort`',
    `sla_penalty_rate` DECIMAL(18,2) COMMENT 'Penalty amount or refund rate applied when SLA commitment is not met. Null if no penalty applies.',
    `sla_penalty_type` STRING COMMENT 'Type of penalty applied for SLA breach: full_refund (100% refund), partial_refund (percentage refund), credit (account credit), none (no penalty).. Valid values are `full_refund|partial_refund|credit|none`',
    `sunday_delivery_available` BOOLEAN COMMENT 'Indicates whether Sunday delivery is available for this service level. True if available, False otherwise.',
    `tracking_visibility_level` STRING COMMENT 'Level of shipment tracking visibility provided with this service level: basic (milestone updates), enhanced (frequent scans), real_time (GPS tracking).. Valid values are `basic|enhanced|real_time`',
    `transit_time_days` STRING COMMENT 'Committed transit time in business days from pickup to delivery for this service level.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this service level (air, road, rail, ocean, multimodal).. Valid values are `air|road|rail|ocean|multimodal`',
    `volume_unit` STRING COMMENT 'Unit of measure for volume used in rate calculation (cbm for cubic meters, cft for cubic feet).. Valid values are `cbm|cft`',
    `weight_unit` STRING COMMENT 'Unit of measure for weight used in rate calculation (kg for kilograms, lb for pounds, ton for metric tons).. Valid values are `kg|lb|ton`',
    CONSTRAINT pk_service_level_rate PRIMARY KEY(`service_level_rate_id`)
) COMMENT 'Rate structure specific to a defined service level (e.g., Next Day, 2-Day, Economy, Priority, Deferred) within express parcel and courier services. Captures service level code, service level name, transit time commitment, delivery time window, applicable origin-destination zones, base rate, per-kg rate, minimum charge, fuel surcharge applicability, and SLA penalty rate. Supports express delivery pricing differentiation across service tiers.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` (
    `pricing_volume_commitment_id` BIGINT COMMENT 'Unique identifier for the customer volume commitment record. Primary key for the pricing volume commitment entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or pricing agreement under which this volume commitment is established.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Volume commitments have associated budget allocations or revenue targets that must be tracked for budget vs. actual variance analysis and performance management. Real process: finance monitors volume ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Volume commitments are often made to specific carriers in exchange for preferential rates. Carrier_id tracks the commitment party for volume reconciliation, penalty/bonus calculation, and carrier rela',
    `contract_volume_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_volume_commitment. Business justification: Revenue management teams reconcile pricing-side volume commitments (rate calculation basis) with contract-side volume commitments (legal obligations) for the same agreement to ensure consistency and t',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that holds this volume commitment agreement.',
    `employee_id` BIGINT COMMENT 'Reference to the user or account manager who approved this volume commitment agreement.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Volume commitments may be with 3PL partners, agents, or other network partners, not just carriers. Network_partner_id broadens the scope to all partner types for comprehensive commitment tracking.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Volume commitments with carbon intensity reduction targets (e.g., 10% reduction per tonne-km) require linkage to corporate sustainability targets for performance tracking and bonus/penalty calculation',
    `actual_revenue_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual revenue generated by the customer during the current commitment period, applicable for revenue-based commitments.',
    `actual_volume_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual volume shipped by the customer during the current commitment period, measured in the same unit as committed_volume_quantity.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this volume commitment was approved and became effective.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this volume commitment automatically renews for the next period if not explicitly cancelled.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Calculated or fixed bonus amount awarded to the customer for exceeding the volume commitment.',
    `bonus_clause_applicable` BOOLEAN COMMENT 'Indicates whether a bonus or incentive clause is in effect for exceeding the committed volume.',
    `bonus_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for bonus amounts.. Valid values are `^[A-Z]{3}$`',
    `bonus_type` STRING COMMENT 'Type of bonus or incentive awarded when commitment is exceeded: volume rebate, additional discount, credit note, or future rate reduction.. Valid values are `rebate|discount|credit_note|rate_reduction|none`',
    `commitment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for revenue-based commitments and financial thresholds.. Valid values are `^[A-Z]{3}$`',
    `commitment_end_date` DATE COMMENT 'The date when this volume commitment period ends and final reconciliation occurs.',
    `commitment_period_type` STRING COMMENT 'Frequency or duration type of the commitment measurement period (monthly, quarterly, annual).. Valid values are `monthly|quarterly|semi_annual|annual|custom`',
    `commitment_reference_number` STRING COMMENT 'Business-readable unique reference number for this volume commitment, used in customer communications and billing reconciliation.',
    `commitment_start_date` DATE COMMENT 'The date when this volume commitment period begins and measurement starts.',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the volume commitment: active (in progress), pending (not yet started), fulfilled (met exactly), shortfall (under target), overachieved (exceeded target), expired, or cancelled. [ENUM-REF-CANDIDATE: active|pending|fulfilled|shortfall|overachieved|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `commitment_type` STRING COMMENT 'Classification of the commitment basis: volume-based (weight/TEU), revenue-based (minimum spend), shipment count, or mixed criteria.. Valid values are `volume_based|revenue_based|shipment_count|weight_based|teu_based|mixed`',
    `commitment_unit_of_measure` STRING COMMENT 'Unit of measure for the committed volume: kilograms, TEU (Twenty-foot Equivalent Unit), CBM (Cubic Meter), shipment count, or revenue currency. [ENUM-REF-CANDIDATE: kg|teu|cbm|shipments|revenue_usd|revenue_eur|pallets — 7 candidates stripped; promote to reference product]',
    `committed_revenue_amount` DECIMAL(18,2) COMMENT 'The agreed minimum revenue amount the customer commits to generate during the commitment period, applicable for revenue-based commitments.',
    `committed_volume_quantity` DECIMAL(18,2) COMMENT 'The agreed minimum volume quantity the customer commits to ship during the commitment period. Unit specified in commitment_unit_of_measure.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this volume commitment record was first created in the system.',
    `destination_region_scope` STRING COMMENT 'Destination region(s) to which this commitment applies. Null indicates all destinations.',
    `last_measurement_date` DATE COMMENT 'Date when the actual volume and variance were last calculated and updated.',
    `measurement_frequency` STRING COMMENT 'Frequency at which actual volume is measured and compared against the commitment for tracking and reporting purposes.. Valid values are `daily|weekly|monthly|quarterly|annual|continuous`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this volume commitment record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or clarifications related to this volume commitment.',
    `notification_threshold_percentage` DECIMAL(18,2) COMMENT 'Percentage of commitment achievement at which automated alerts are triggered to notify account managers and customers (e.g., 80% to warn of potential shortfall).',
    `origin_region_scope` STRING COMMENT 'Origin region(s) to which this commitment applies. Null indicates all origins.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Calculated or fixed penalty amount charged to the customer for failing to meet the volume commitment.',
    `penalty_clause_applicable` BOOLEAN COMMENT 'Indicates whether a penalty clause is in effect for shortfall against the committed volume.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for penalty amounts.. Valid values are `^[A-Z]{3}$`',
    `penalty_type` STRING COMMENT 'Type of penalty applied when commitment is not met: fixed fee, percentage of shortfall value, rate adjustment (loss of discount), or rebate forfeiture.. Valid values are `fixed_fee|percentage_of_shortfall|rate_adjustment|rebate_forfeiture|none`',
    `reconciliation_date` DATE COMMENT 'Date when the final reconciliation of actual versus committed volume was completed and penalties or bonuses were finalized.',
    `reconciliation_status` STRING COMMENT 'Status of the final reconciliation process at the end of the commitment period, including penalty or bonus calculation and billing adjustments.. Valid values are `pending|in_progress|completed|disputed|adjusted`',
    `service_mode_scope` STRING COMMENT 'Transport mode(s) to which this volume commitment applies: air freight, ocean freight, road, rail, multimodal, or all modes.. Valid values are `air|ocean|road|rail|multimodal|all`',
    `threshold_tier` STRING COMMENT 'Tiered threshold level or bracket for this commitment (e.g., bronze, silver, gold) if the contract uses tiered volume commitments with different rates or benefits.',
    `trade_lane_scope` STRING COMMENT 'Specific trade lane(s) or geographic scope to which this commitment applies (e.g., Asia-Europe, Transpacific, Domestic US). Null indicates all lanes.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between actual and committed volume, calculated as (actual - committed) / committed * 100.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between committed volume and actual volume to date (actual minus committed). Negative values indicate shortfall, positive indicate overachievement.',
    CONSTRAINT pk_pricing_volume_commitment PRIMARY KEY(`pricing_volume_commitment_id`)
) COMMENT 'Customer volume commitment record capturing agreed minimum shipment volumes or revenue thresholds tied to contract rates and pricing agreements. Captures commitment reference, customer account, commitment period (monthly/quarterly/annual), committed volume (TEUs, kg, shipments, revenue), actual volume to date, variance, penalty clause for shortfall, bonus clause for overachievement, and commitment status. Feeds contract domain for SLA monitoring and billing domain for volume rebate calculations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` (
    `rate_sustainability_contribution_id` BIGINT COMMENT 'Unique identifier for this rate-target contribution relationship. Primary key.',
    `contract_rate_id` BIGINT COMMENT 'Foreign key linking to the contract rate that contributes to the sustainability target',
    `target_id` BIGINT COMMENT 'Foreign key linking to the sustainability target being supported by this contract rate',
    `actual_emissions_tco2e` DECIMAL(18,2) COMMENT 'Actual cumulative emissions in tonnes CO2 equivalent for shipments under this contract rate since contribution tracking began. Updated at each measurement cycle.',
    `baseline_emissions_tco2e` DECIMAL(18,2) COMMENT 'Baseline emissions in tonnes CO2 equivalent for shipments under this contract rate, measured in the target baseline year. Used to calculate reduction progress. Identified in detection phase.',
    `bonus_rate` DECIMAL(18,2) COMMENT 'Financial bonus rate (in currency per tCO2e) awarded if emissions performance under this contract rate exceeds the target trajectory. Part of sustainability-linked pricing incentive. Identified in detection phase.',
    `contribution_status` STRING COMMENT 'Current status of this contribution relationship: active (rate is contributing to target), suspended (temporarily paused), achieved (target met), discontinued (rate no longer contributes).',
    `effective_end_date` DATE COMMENT 'Date on which this contract rate stopped contributing to the sustainability target. Null if contribution is ongoing.',
    `effective_start_date` DATE COMMENT 'Date from which this contract rate began contributing to the sustainability target. May differ from the rates own effective_start_date if sustainability tracking was added later.',
    `incentive_amount_ytd` DECIMAL(18,2) COMMENT 'Year-to-date financial incentive amount (bonus or penalty) accrued based on emissions performance under this contract rate relative to target.',
    `last_measurement_date` DATE COMMENT 'Date of the most recent emissions measurement and performance assessment for this rate-target contribution.',
    `measurement_frequency` STRING COMMENT 'Frequency at which emissions performance under this contract rate is measured and reported against the sustainability target (monthly, quarterly, semi-annual, annual). Identified in detection phase.',
    `notes` STRING COMMENT 'Free-text notes documenting special circumstances, methodology adjustments, or business context for this rate-target contribution relationship.',
    `penalty_rate` DECIMAL(18,2) COMMENT 'Financial penalty rate (in currency per tCO2e) applied if emissions performance under this contract rate fails to meet the target trajectory. Part of sustainability-linked pricing structure. Identified in detection phase.',
    `performance_variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between actual emissions performance and target trajectory. Negative values indicate better-than-target performance (emissions below target).',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual or team responsible for managing this rate-target contribution relationship and ensuring performance tracking.',
    `target_contribution_percentage` DECIMAL(18,2) COMMENT 'The percentage of the sustainability target that this contract rate is expected to contribute toward achieving (e.g., 2.5% of total Scope 3 reduction target). Identified in detection phase.',
    `target_emissions_tco2e` DECIMAL(18,2) COMMENT 'Target emissions in tonnes CO2 equivalent for shipments under this contract rate by the target year. Represents the emissions reduction commitment embedded in this rate agreement. Identified in detection phase.',
    CONSTRAINT pk_rate_sustainability_contribution PRIMARY KEY(`rate_sustainability_contribution_id`)
) COMMENT 'This association product represents the contribution relationship between contract_rate and sustainability_target. It captures how specific negotiated contract rates contribute to corporate sustainability targets through modal shift incentives, low-carbon service adoption, and emissions reduction commitments embedded in customer agreements. Each record links one contract rate to one sustainability target with measurement and incentive attributes that exist only in the context of this relationship.. Existence Justification: In logistics sustainability programs, contract rates can be designed to contribute to multiple corporate sustainability targets simultaneously (e.g., a low-carbon ocean freight rate contributes to both Scope 3 Category 4 reduction targets and modal shift targets), and each sustainability target is achieved through the aggregated contribution of multiple contract rates across different customers, lanes, and service types. The business actively manages these contribution relationships with measurement cycles, performance tracking, and financial incentives (penalties/bonuses) tied to emissions performance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` (
    `rate_card_assignment_id` BIGINT COMMENT 'Unique identifier for this rate card assignment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the pricing analyst or account manager who created this rate card assignment. Used for audit trail and accountability.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to the customer account to which this rate card is assigned',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to the rate card being assigned to the customer',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when this rate card assignment was created in the system. Used for audit trail and compliance reporting.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the rate card assignment: active (currently in effect), suspended (temporarily inactive), expired (past effective_to_date), superseded (replaced by a newer assignment). Used to manage assignment lifecycle.',
    `contract_reference_number` STRING COMMENT 'External reference to the commercial contract or pricing agreement that authorizes this rate card assignment. Nullable for published tariff assignments. Used to link pricing to legal agreements.',
    `effective_from_date` DATE COMMENT 'Date from which this rate card assignment becomes active for the customer account. Used to manage temporal validity of pricing agreements.',
    `effective_to_date` DATE COMMENT 'Date on which this rate card assignment ceases to be valid for the customer account. Nullable for open-ended assignments. Used to manage contract expiry and rate card transitions.',
    `priority_rank` STRING COMMENT 'Priority ranking used to resolve conflicts when multiple rate cards are valid for the same customer at the same time. Lower numbers indicate higher priority. Used in quote generation to select the applicable rate card.',
    `service_mode_scope` STRING COMMENT 'Restricts this rate card assignment to specific service modes (e.g., air freight, ocean freight, road, rail). Nullable if the assignment applies to all modes covered by the rate card. Used to limit rate card applicability by transportation mode.',
    `trade_lane_scope` STRING COMMENT 'Restricts this rate card assignment to specific trade lanes or origin-destination pairs (e.g., Asia-Europe, US-Domestic). Nullable if the assignment applies to all lanes covered by the rate card. Used to limit rate card applicability by geographic scope.',
    CONSTRAINT pk_rate_card_assignment PRIMARY KEY(`rate_card_assignment_id`)
) COMMENT 'This association product represents the contractual assignment of a rate card to a customer account in the Transport Shipping logistics network. It captures which rate cards are active for which customers, with temporal validity, priority rules for overlapping cards, and scope restrictions by service mode and trade lane. Each record links one customer_account to one rate_card with attributes that exist only in the context of this commercial pricing relationship.. Existence Justification: In Transport Shipping logistics operations, large enterprise customers are assigned multiple rate cards simultaneously based on different service modes (air vs ocean), trade lanes (Asia-Europe vs US-Domestic), and time periods (seasonal rates, contract renewals). Conversely, published tariff rate cards and segment-based rate cards apply to multiple customer accounts. The business actively manages Rate Card Assignments as a distinct operational concept with effective dates, priority rules for overlapping cards, and scope restrictions.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ADD CONSTRAINT `fk_pricing_rate_card_superseded_by_rate_card_id` FOREIGN KEY (`superseded_by_rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ADD CONSTRAINT `fk_pricing_rate_line_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ADD CONSTRAINT `fk_pricing_surcharge_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`surcharge`(`surcharge_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ADD CONSTRAINT `fk_pricing_pricing_surcharge_schedule_superseded_by_schedule_pricing_surcharge_schedule_id` FOREIGN KEY (`superseded_by_schedule_pricing_surcharge_schedule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule`(`pricing_surcharge_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ADD CONSTRAINT `fk_pricing_accessorial_charge_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ADD CONSTRAINT `fk_pricing_dim_weight_rule_superseded_by_rule_dim_weight_rule_id` FOREIGN KEY (`superseded_by_rule_dim_weight_rule_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`dim_weight_rule`(`dim_weight_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ADD CONSTRAINT `fk_pricing_dim_weight_rule_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`tariff`(`tariff_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ADD CONSTRAINT `fk_pricing_spot_quote_line_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ADD CONSTRAINT `fk_pricing_spot_quote_line_spot_quote_id` FOREIGN KEY (`spot_quote_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`spot_quote`(`spot_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_commodity_rate_class_id` FOREIGN KEY (`commodity_rate_class_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`commodity_rate_class`(`commodity_rate_class_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ADD CONSTRAINT `fk_pricing_contract_rate_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ADD CONSTRAINT `fk_pricing_rate_rule_charge_code_id` FOREIGN KEY (`charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ADD CONSTRAINT `fk_pricing_rate_audit_superseded_by_audit_rate_audit_id` FOREIGN KEY (`superseded_by_audit_rate_audit_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_audit`(`rate_audit_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ADD CONSTRAINT `fk_pricing_gri_announcement_superseded_by_gri_gri_announcement_id` FOREIGN KEY (`superseded_by_gri_gri_announcement_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`gri_announcement`(`gri_announcement_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ADD CONSTRAINT `fk_pricing_commodity_rate_class_superseded_by_class_commodity_rate_class_id` FOREIGN KEY (`superseded_by_class_commodity_rate_class_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`commodity_rate_class`(`commodity_rate_class_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ADD CONSTRAINT `fk_pricing_charge_code_superseded_by_charge_code_id` FOREIGN KEY (`superseded_by_charge_code_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`charge_code`(`charge_code_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ADD CONSTRAINT `fk_pricing_carrier_buy_rate_superseded_by_rate_carrier_buy_rate_id` FOREIGN KEY (`superseded_by_rate_carrier_buy_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`carrier_buy_rate`(`carrier_buy_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ADD CONSTRAINT `fk_pricing_rate_sustainability_contribution_contract_rate_id` FOREIGN KEY (`contract_rate_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`contract_rate`(`contract_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ADD CONSTRAINT `fk_pricing_rate_card_assignment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `transport_shipping_ecm`.`pricing`.`rate_card`(`rate_card_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`pricing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `transport_shipping_ecm`.`pricing` SET TAGS ('dbx_domain' = 'pricing');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `superseded_by_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate Card Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Document Template Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card` ALTER COLUMN `dim_weight_divisor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Weight Divisor');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_line` ALTER COLUMN `dim_weight_factor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Weight Factor');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`tariff` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Document Template Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` SET TAGS ('dbx_subdomain' = 'charge_supplements');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Identifier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Charge Code Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`surcharge` ALTER COLUMN `fuel_index_source` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Source');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` SET TAGS ('dbx_subdomain' = 'charge_supplements');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `pricing_surcharge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Surcharge Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Definition ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `superseded_by_schedule_pricing_surcharge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `tertiary_pricing_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `tertiary_pricing_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `tertiary_pricing_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `dg_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Dg Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|superseded|expired');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `commodity_group_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_surcharge_schedule` ALTER COLUMN `index_reference_name` SET TAGS ('dbx_business_glossary_term' = 'Index Reference Name');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` SET TAGS ('dbx_subdomain' = 'charge_supplements');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `fuel_index_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`fuel_index` ALTER COLUMN `fuel_consumption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Record Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` SET TAGS ('dbx_subdomain' = 'charge_supplements');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`accessorial_charge` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Charge Code Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` SET TAGS ('dbx_subdomain' = 'quote_negotiation');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `dim_weight_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (DIM Weight) Rule ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `superseded_by_rule_dim_weight_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rule ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `applies_to_returns` SET TAGS ('dbx_business_glossary_term' = 'Applies to Returns Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`dim_weight_rule` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'retail|enterprise|ecommerce|3pl|government|all');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` SET TAGS ('dbx_subdomain' = 'quote_negotiation');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `spot_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agent ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper ID');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` SET TAGS ('dbx_subdomain' = 'quote_negotiation');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `spot_quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Line Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Charge Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`spot_quote_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `commodity_rate_class_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Rate Class Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `trade_document_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `deviation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deviation Reason');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`contract_rate` ALTER COLUMN `dim_weight_divisor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Weight Divisor');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Charge Code Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `customer_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Tier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_rule` ALTER COLUMN `customer_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` SET TAGS ('dbx_subdomain' = 'charge_supplements');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `incoterms_charge_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Charge Allocation ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `allocation_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `charge_sequence` SET TAGS ('dbx_business_glossary_term' = 'Charge Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `charge_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Charge Subcategory');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `cost_transfer_point` SET TAGS ('dbx_business_glossary_term' = 'Cost Transfer Point');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `cost_transfer_point` SET TAGS ('dbx_value_regex' = 'seller_premises|carrier_terminal|port_of_loading|port_of_discharge|destination_terminal|buyer_premises');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `customs_clearance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Responsibility');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `customs_clearance_responsibility` SET TAGS ('dbx_value_regex' = 'seller|buyer|shared|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `exception_handling_rule` SET TAGS ('dbx_business_glossary_term' = 'Exception Handling Rule');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `incoterms_name` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Full Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `incoterms_version` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Version');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `incoterms_version` SET TAGS ('dbx_value_regex' = '2020|2010|2000');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `insurance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Insurance Responsibility');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `insurance_responsibility` SET TAGS ('dbx_value_regex' = 'seller|buyer|optional|not_required');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `is_billable_to_customer` SET TAGS ('dbx_business_glossary_term' = 'Is Billable to Customer Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `is_mandatory_charge` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Charge Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'shipper|consignee|carrier|seller|buyer');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Rule');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_value_regex' = 'at_origin|at_destination|over_transit|at_delivery|at_customs_clearance');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `risk_transfer_point` SET TAGS ('dbx_business_glossary_term' = 'Risk Transfer Point');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `risk_transfer_point` SET TAGS ('dbx_value_regex' = 'seller_premises|carrier_terminal|port_of_loading|port_of_discharge|destination_terminal|buyer_premises');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `shipment_direction` SET TAGS ('dbx_business_glossary_term' = 'Shipment Direction');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `shipment_direction` SET TAGS ('dbx_value_regex' = 'export|import|domestic|cross_border');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `trade_lane_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|any');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`incoterms_charge_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `lane_rate_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Rate Zone ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`lane_rate_zone` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `rate_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Audit ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `agreement_version_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `carbon_offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Transaction Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `compliance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Changed By User ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `superseded_by_audit_rate_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Audit ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|auto_approved|not_required');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `change_event_type` SET TAGS ('dbx_business_glossary_term' = 'Change Event Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `change_event_type` SET TAGS ('dbx_value_regex' = 'rate_update|surcharge_adjustment|gri_application|baf_adjustment|thc_update|contract_rate_revision');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `change_magnitude` SET TAGS ('dbx_business_glossary_term' = 'Change Magnitude');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Change Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'market_adjustment|cost_increase|competitive_pressure|contract_renewal|regulatory_compliance|correction');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `change_source` SET TAGS ('dbx_business_glossary_term' = 'Change Source');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `change_source` SET TAGS ('dbx_value_regex' = 'manual|automated|edi_feed|api_integration|bulk_upload|system_calculation');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `change_source_system` SET TAGS ('dbx_business_glossary_term' = 'Change Source System');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `changed_by_role` SET TAGS ('dbx_business_glossary_term' = 'Changed By Role');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Changed By User Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `entity_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Entity Reference ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `field_label` SET TAGS ('dbx_business_glossary_term' = 'Field Label');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `previous_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Value');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_audit` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `rate_request_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Request ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `contract_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Dispute Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `approved_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Rate Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `approved_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Approved Rate Currency');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `approved_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `competitive_benchmark_rate` SET TAGS ('dbx_business_glossary_term' = 'Competitive Benchmark Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `competitive_benchmark_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `estimated_shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Shipment Count');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `estimated_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `estimated_weight` SET TAGS ('dbx_business_glossary_term' = 'Estimated Weight');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Request Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Request Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Request Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'spot_quote|contract_rate|tariff_revision|lane_rate|volume_commitment|special_service');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requested_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Effective Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requested_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Rate Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requested_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Requested Rate Currency');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requested_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requestor_phone` SET TAGS ('dbx_business_glossary_term' = 'Requestor Phone Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requestor_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requestor_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requestor_type` SET TAGS ('dbx_business_glossary_term' = 'Requestor Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `requestor_type` SET TAGS ('dbx_value_regex' = 'internal_sales|customer_direct|operations|carrier|broker|partner');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|courier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'cbm|cft|liter');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_request` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|mt');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `gri_announcement_id` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Announcement ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Accepted By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `superseded_by_gri_gri_announcement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By General Rate Increase (GRI) ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Announcement Document ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `environmental_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Environmental Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|partially_accepted|negotiated');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `announcement_source_url` SET TAGS ('dbx_business_glossary_term' = 'Announcement Source Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `announcement_status` SET TAGS ('dbx_business_glossary_term' = 'Announcement Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `announcement_status` SET TAGS ('dbx_value_regex' = 'draft|published|accepted|rejected|withdrawn|superseded');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `announcing_party_type` SET TAGS ('dbx_business_glossary_term' = 'Announcing Party Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `announcing_party_type` SET TAGS ('dbx_value_regex' = 'carrier|trade_body|industry_association|regulatory_authority|market_consortium');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `applies_to_contract` SET TAGS ('dbx_business_glossary_term' = 'Applies to Contract');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `applies_to_spot` SET TAGS ('dbx_business_glossary_term' = 'Applies to Spot');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `commodity_scope` SET TAGS ('dbx_business_glossary_term' = 'Commodity Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `customer_segment_scope` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `equipment_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `gri_amount` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `gri_currency` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Currency');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `gri_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `gri_name` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `gri_percentage` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `gri_reference_number` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Reference Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `gri_reference_number` SET TAGS ('dbx_value_regex' = '^GRI-[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `gri_type` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `gri_type` SET TAGS ('dbx_value_regex' = 'flat_amount|percentage|tiered|variable');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `incoterm_scope` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `market_justification` SET TAGS ('dbx_business_glossary_term' = 'Market Justification');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `rate_card_update_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Update Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `rate_card_update_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `surcharge_schedule_update_status` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Schedule Update Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `surcharge_schedule_update_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'ocean|air|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'TEU|CBM|kg|ton|shipment|container');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`gri_announcement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` SET TAGS ('dbx_subdomain' = 'quote_negotiation');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `commodity_rate_class_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Rate Class ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `superseded_by_class_commodity_rate_class_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Class ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `applicable_transport_modes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transport Modes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `classification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review|deprecated');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `commodity_name` SET TAGS ('dbx_business_glossary_term' = 'Commodity Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `customs_inspection_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Customs Inspection Likelihood');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `customs_inspection_likelihood` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `default_dim_factor` SET TAGS ('dbx_business_glossary_term' = 'Default Dimensional (DIM) Factor');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `density_class` SET TAGS ('dbx_business_glossary_term' = 'Density Class');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `density_class` SET TAGS ('dbx_value_regex' = 'high_density|medium_density|low_density|very_low_density');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `export_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `fragile_flag` SET TAGS ('dbx_business_glossary_term' = 'Fragile Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'Freight Class');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `freight_class` SET TAGS ('dbx_value_regex' = '^(50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500)$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Class');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_value_regex' = '^(1|2.1|2.2|2.3|3|4.1|4.2|4.3|5.1|5.2|6.1|6.2|7|8|9)?$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `high_value_flag` SET TAGS ('dbx_business_glossary_term' = 'High Value Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `high_value_threshold` SET TAGS ('dbx_business_glossary_term' = 'High Value Threshold Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `hs_code_range_end` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Range End');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `hs_code_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `hs_code_range_start` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Range Start');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `hs_code_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `minimum_charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `minimum_charge_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `minimum_charge_override` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Override Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Classification Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `packaging_requirements` SET TAGS ('dbx_business_glossary_term' = 'Packaging Requirements');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `perishable_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `prohibited_countries` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Countries');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `rate_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `rate_class_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Class Description');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Rate Multiplier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `restricted_transport_modes` SET TAGS ('dbx_business_glossary_term' = 'Restricted Transport Modes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `surcharge_applicability` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Applicability');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `temperature_range_max` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `temperature_range_min` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`commodity_rate_class` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` SET TAGS ('dbx_subdomain' = 'charge_supplements');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Code Identifier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`charge_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` SET TAGS ('dbx_subdomain' = 'quote_negotiation');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Buy Rate ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`carrier_buy_rate` ALTER COLUMN `superseded_by_rate_carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate ID');
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
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` SET TAGS ('dbx_subdomain' = 'quote_negotiation');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `service_level_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Rate ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `all_in_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Rate Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `base_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'retail|commercial|enterprise|government|ecommerce');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `delivery_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Time Window End');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `delivery_time_window_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `delivery_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Time Window Start');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `delivery_time_window_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `dim_weight_applicable` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Weight Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `dim_weight_divisor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional (DIM) Weight Divisor');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `fuel_surcharge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `gri_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `insurance_included` SET TAGS ('dbx_business_glossary_term' = 'Insurance Included Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `peak_season_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Peak Season Surcharge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `per_cbm_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Cubic Meter (CBM) Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `per_kg_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Kilogram (KG) Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|superseded');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'published|contract|spot|promotional');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `saturday_delivery_available` SET TAGS ('dbx_business_glossary_term' = 'Saturday Delivery Available Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `service_level_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `service_level_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `service_level_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Name');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'express|courier|parcel|freight|specialized');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `signature_required` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `sla_commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Commitment Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `sla_commitment_type` SET TAGS ('dbx_value_regex' = 'guaranteed|target|best_effort');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `sla_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Penalty Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `sla_penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Penalty Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `sla_penalty_type` SET TAGS ('dbx_value_regex' = 'full_refund|partial_refund|credit|none');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `sunday_delivery_available` SET TAGS ('dbx_business_glossary_term' = 'Sunday Delivery Available Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `tracking_visibility_level` SET TAGS ('dbx_business_glossary_term' = 'Tracking Visibility Level');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `tracking_visibility_level` SET TAGS ('dbx_value_regex' = 'basic|enhanced|real_time');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Days');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|road|rail|ocean|multimodal');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'cbm|cft');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`service_level_rate` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|ton');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` SET TAGS ('dbx_subdomain' = 'quote_negotiation');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `pricing_volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Volume Commitment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `contract_volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Volume Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `actual_revenue_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Revenue to Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `actual_volume_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume to Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `bonus_clause_applicable` SET TAGS ('dbx_business_glossary_term' = 'Bonus Clause Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `bonus_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Bonus Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `bonus_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `bonus_type` SET TAGS ('dbx_business_glossary_term' = 'Bonus Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `bonus_type` SET TAGS ('dbx_value_regex' = 'rebate|discount|credit_note|rate_reduction|none');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Commitment Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment End Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_period_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Period Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|custom');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Start Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'volume_based|revenue_based|shipment_count|weight_based|teu_based|mixed');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `commitment_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Commitment Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `committed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Revenue Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `committed_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume Quantity');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `destination_region_scope` SET TAGS ('dbx_business_glossary_term' = 'Destination Region Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `last_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Measurement Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|continuous');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `notification_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Notification Threshold Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `origin_region_scope` SET TAGS ('dbx_business_glossary_term' = 'Origin Region Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `penalty_clause_applicable` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'fixed_fee|percentage_of_shortfall|rate_adjustment|rebate_forfeiture|none');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|disputed|adjusted');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `service_mode_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Mode Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `service_mode_scope` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|all');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `threshold_tier` SET TAGS ('dbx_business_glossary_term' = 'Threshold Tier');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `trade_lane_scope` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane Scope');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`pricing_volume_commitment` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` SET TAGS ('dbx_association_edges' = 'pricing.contract_rate,sustainability.sustainability_target');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `rate_sustainability_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Sustainability Contribution ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `contract_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Sustainability Contribution - Contract Rate Id');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Sustainability Contribution - Sustainability Target Id');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `actual_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Actual Emissions to Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `baseline_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Baseline Emissions');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `bonus_rate` SET TAGS ('dbx_business_glossary_term' = 'Bonus Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `contribution_status` SET TAGS ('dbx_business_glossary_term' = 'Contribution Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `incentive_amount_ytd` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount Year-to-Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `last_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Measurement Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contribution Notes');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Penalty Rate');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `performance_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Performance Variance Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `target_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Contribution Percentage');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_sustainability_contribution` ALTER COLUMN `target_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Target Emissions');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` SET TAGS ('dbx_association_edges' = 'customer.customer_account,pricing.rate_card');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `rate_card_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Assignment ID');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Assignment - Customer Account Id');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Assignment - Rate Card Id');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Priority Rank');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `service_mode_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Mode Scope Restriction');
ALTER TABLE `transport_shipping_ecm`.`pricing`.`rate_card_assignment` ALTER COLUMN `trade_lane_scope` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane Scope Restriction');
