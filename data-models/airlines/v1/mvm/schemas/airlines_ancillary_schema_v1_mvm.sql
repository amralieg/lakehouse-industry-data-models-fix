-- Schema for Domain: ancillary | Business: Airlines | Version: v1_mvm
-- Generated on: 2026-05-07 15:14:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`ancillary` COMMENT 'Ancillary services and revenue products sold beyond the base fare including baggage fees, seat selection and upgrades, priority boarding, lounge access, in-flight meals and retail, Wi-Fi, travel insurance, car rentals, hotel bookings, bundled fare products, and EMD-linked ancillary charge records. Manages ancillary product catalog, pricing, and unbundled fare strategy.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`product_catalog` (
    `product_catalog_id` BIGINT COMMENT 'Primary key for product_catalog',
    `category_id` BIGINT COMMENT 'Foreign key linking to ancillary.category. Business justification: Every ancillary product should be classified into a category from the reference taxonomy. The product_catalog table has product_category and product_subcategory as STRING columns, which are denormaliz',
    `base_price_amount` DECIMAL(18,2) COMMENT 'Standard base price for the ancillary product in the default currency, before taxes, fees, and channel-specific adjustments. Used as reference price for revenue management and dynamic pricing.',
    `base_price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the base price amount (e.g., USD, EUR, GBP). Defines the currency in which the product is priced in the master catalog.. Valid values are `^[A-Z]{3}$`',
    `booking_window_end_hours` STRING COMMENT 'Number of hours before scheduled departure when the ancillary product is no longer available for purchase (e.g., 24 hours before departure for baggage, 2 hours for seat selection). Null if available until departure.',
    `booking_window_start_hours` STRING COMMENT 'Number of hours before scheduled departure when the ancillary product becomes available for purchase. Null if available immediately upon flight booking. Used for time-sensitive products like seat upgrades.',
    `cabin_class_eligibility` STRING COMMENT 'Comma-separated list of cabin classes for which this ancillary product is available (e.g., economy,premium_economy,business,first). Used to restrict or target products by travel class.',
    `channel_availability` STRING COMMENT 'Comma-separated list of sales channels where the ancillary product is available for purchase (e.g., web,mobile,airport,call_center,gds). Used to control distribution and channel-specific merchandising.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage commission rate paid to sales agents, travel agencies, or distribution partners for selling this ancillary product. Used for partner settlement and revenue sharing calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ancillary product record was first created in the catalog system. Used for audit trail and product lifecycle tracking.',
    `effective_end_date` DATE COMMENT 'Date after which the ancillary product is no longer available for new bookings. Null for products with indefinite availability. Used for limited-time offers and product phase-outs.',
    `effective_start_date` DATE COMMENT 'Date from which the ancillary product becomes available for sale and booking. Used for seasonal products, new product launches, and promotional offerings.',
    `fare_family_eligibility` STRING COMMENT 'Comma-separated list of fare families or branded fare products for which this ancillary is available or included (e.g., basic,standard,flex,premium). Used for unbundled fare strategy and fare family differentiation.',
    `iata_emd_service_type` STRING COMMENT 'IATA-standardized service type code used for EMD issuance and settlement. Maps ancillary products to industry-standard codes for interline billing and BSP/ARC settlement (e.g., 0CC for baggage, 0G1 for lounge).. Valid values are `^[A-Z0-9]{2,4}$`',
    `iata_ssim_service_code` STRING COMMENT 'IATA SSIM service code used for schedule and service data exchange. Identifies ancillary services in GDS and reservation systems.. Valid values are `^[A-Z0-9]{2,4}$`',
    `inventory_controlled_flag` BOOLEAN COMMENT 'Indicates whether the ancillary product is subject to inventory control and capacity limits (e.g., lounge seats, premium seats, onboard meal quantities). True if inventory-controlled; false if unlimited availability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ancillary product record was last updated. Used for change tracking, audit trail, and data synchronization across systems.',
    `maximum_quantity` STRING COMMENT 'Maximum number of units that can be purchased per passenger or per booking. Used to enforce business rules and prevent inventory abuse (e.g., maximum 3 checked bags per passenger).',
    `minimum_quantity` STRING COMMENT 'Minimum number of units that must be purchased in a single transaction. Typically 1 for most ancillary products; may be higher for bulk or group purchases.',
    `modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified the product record. Used for audit trail and accountability.',
    `partner_product_flag` BOOLEAN COMMENT 'Indicates whether the ancillary product is provided by a third-party partner (e.g., car rental, hotel, travel insurance) rather than directly by the airline. True if partner product; false if airline-owned product.',
    `passenger_type_eligibility` STRING COMMENT 'Comma-separated list of passenger types eligible to purchase this ancillary product (e.g., adult,child,infant,senior,military,ffp_elite). Used to enforce eligibility rules and targeted merchandising.',
    `pricing_model` STRING COMMENT 'Pricing strategy applied to the ancillary product. Fixed pricing uses a constant price; dynamic pricing varies by demand, route, or booking class; tiered pricing offers volume discounts; bundled pricing includes multiple products; promotional pricing applies temporary discounts.. Valid values are `fixed|dynamic|tiered|bundled|promotional`',
    `product_code` STRING COMMENT 'Unique alphanumeric code identifying the ancillary product across all systems. Used for inventory, pricing, and settlement. Aligns with IATA EMD service type codes where applicable.. Valid values are `^[A-Z0-9]{4,12}$`',
    `product_description` STRING COMMENT 'Detailed description of the ancillary product, including features, benefits, terms, and conditions. Used for customer-facing marketing and internal reference.',
    `product_name` STRING COMMENT 'Full business name of the ancillary product as displayed to customers and used in internal systems (e.g., Priority Boarding, Extra Baggage 23kg, Lounge Access Day Pass).',
    `product_short_name` STRING COMMENT 'Abbreviated or shortened display name for the product, used in space-constrained interfaces such as mobile apps, boarding passes, and receipts.',
    `product_status` STRING COMMENT 'Current lifecycle status of the ancillary product in the catalog. Active products are available for sale; inactive products are temporarily unavailable; suspended products are under review; discontinued products are permanently retired; pending_approval products await commercial approval.. Valid values are `active|inactive|suspended|discontinued|pending_approval`',
    `refundable_flag` BOOLEAN COMMENT 'Indicates whether the ancillary product purchase is refundable if the passenger cancels or changes their booking. True if refundable; false if non-refundable.',
    `revenue_accounting_code` STRING COMMENT 'Internal accounting code used to classify ancillary revenue for financial reporting, revenue management, and general ledger posting. Maps to specific GL accounts in SAP FI/CO.. Valid values are `^[A-Z0-9]{4,10}$`',
    `route_applicability` STRING COMMENT 'Defines the geographic or route scope where the ancillary product is available. Values include all routes, domestic only, international only, regional (e.g., intra-Europe), or specific routes defined in separate route mapping tables.. Valid values are `all|domestic|international|regional|specific_routes`',
    `ssr_code` STRING COMMENT 'Four-letter IATA SSR code used in PNR and reservation systems to request and track special services (e.g., BAGP for prepaid baggage, SEAT for seat assignment, MEAL for meal preference).. Valid values are `^[A-Z]{4}$`',
    `tax_category_code` STRING COMMENT 'Tax classification code used to determine applicable taxes, VAT, GST, or other government charges for the ancillary product. Maps to tax calculation rules in revenue accounting systems.. Valid values are `^[A-Z0-9]{2,6}$`',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the ancillary product can be transferred to another passenger or booking. True if transferable; false if non-transferable and tied to the original purchaser.',
    `unit_of_measure` STRING COMMENT 'Unit by which the ancillary product is quantified and sold (e.g., each for lounge access, kilogram for baggage weight, hour for Wi-Fi, segment for seat selection, piece for baggage count). [ENUM-REF-CANDIDATE: each|kilogram|pound|hour|day|trip|segment|piece — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_product_catalog PRIMARY KEY(`product_catalog_id`)
) COMMENT 'Master catalog of all ancillary products and services offered by the airline beyond the base fare, including baggage fees, seat upgrades, priority boarding, lounge access, in-flight meals, Wi-Fi, travel insurance, car rentals, hotel bookings, and bundled fare add-ons. Defines the product identity, category, IATA SSIM/EMD service type codes, channel availability, and lifecycle status for each ancillary offering.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`category` (
    `category_id` BIGINT COMMENT 'Unique identifier for the ancillary product category. Primary key.',
    `parent_category_ancillary_category_id` BIGINT COMMENT 'Foreign key reference to a parent ancillary category, enabling hierarchical taxonomy structures (e.g., Baggage as parent, Checked Baggage and Carry-On Baggage as children).',
    `ancillary_category_status` STRING COMMENT 'Current lifecycle status of the ancillary category indicating whether it is actively used in merchandising and revenue systems.. Valid values are `active|inactive|deprecated|pending_approval`',
    `atpco_service_group` STRING COMMENT 'ATPCO Optional Services service group classification for the ancillary category, used for fare filing and distribution through GDS channels.',
    `category_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the ancillary category, aligned with IATA PADIS and ATPCO Optional Services taxonomy (e.g., BAG for baggage, SEAT for seat selection, LOUNGE for lounge access).. Valid values are `^[A-Z0-9]{2,10}$`',
    `category_description` STRING COMMENT 'Detailed textual description of the ancillary category, including scope, typical products included, and business purpose.',
    `category_level` STRING COMMENT 'Numeric indicator of the hierarchical level of this category within the taxonomy (e.g., 1 for top-level, 2 for sub-category, 3 for detailed classification).',
    `category_name` STRING COMMENT 'Human-readable name of the ancillary category (e.g., Baggage, Seat Selection, Priority Boarding, Lounge Access, In-Flight Meals, Wi-Fi Connectivity).',
    `category_type` STRING COMMENT 'High-level classification of the ancillary category distinguishing between service-based, product-based, bundled offerings, insurance, ground transport, or accommodation.. Valid values are `service|product|bundle|insurance|transport|accommodation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ancillary category record was first created in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `direct_channel_only_flag` BOOLEAN COMMENT 'Indicates whether this category is exclusively sold through direct airline channels (website, mobile app, call center) and not available via third-party distributors.',
    `display_sequence` STRING COMMENT 'Numeric ordering for display of this category in user interfaces, merchandising platforms, and reporting hierarchies.',
    `dot_reportable_flag` BOOLEAN COMMENT 'Indicates whether revenue from this ancillary category must be reported to the US Department of Transportation (DOT) in quarterly ancillary revenue disclosures.',
    `effective_end_date` DATE COMMENT 'Date after which this ancillary category is no longer effective and should not be used for new product assignments. Null indicates open-ended validity.',
    `effective_start_date` DATE COMMENT 'Date from which this ancillary category becomes effective and available for use in product catalog and merchandising systems.',
    `emd_eligible_flag` BOOLEAN COMMENT 'Indicates whether ancillary products in this category are eligible for issuance via Electronic Miscellaneous Document (EMD) per IATA standards.',
    `emd_type` STRING COMMENT 'Specifies the EMD type applicable to this category: EMD-S (standalone, not linked to e-ticket) or EMD-A (associated with e-ticket). Not applicable if EMD is not used.. Valid values are `EMD-S|EMD-A|not_applicable`',
    `gds_distribution_flag` BOOLEAN COMMENT 'Indicates whether ancillary products in this category are distributed through Global Distribution Systems (GDS) such as Amadeus, Sabre, and Travelport.',
    `iata_padis_code` STRING COMMENT 'IATA PADIS standard code for the ancillary category, enabling interoperability across Global Distribution Systems (GDS) and Passenger Service Systems (PSS).. Valid values are `^[A-Z0-9]{2,6}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ancillary category record was last updated, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `merchandising_priority` STRING COMMENT 'Numeric ranking indicating the priority of this category in merchandising and upsell workflows, with lower numbers representing higher priority.',
    `ndc_compatible_flag` BOOLEAN COMMENT 'Indicates whether this ancillary category is compatible with IATA New Distribution Capability (NDC) standards for modern retailing and distribution.',
    `refundable_flag` BOOLEAN COMMENT 'Indicates whether ancillary products in this category are generally refundable per airline policy and fare rules.',
    `regulatory_compliance_notes` STRING COMMENT 'Free-text field capturing any regulatory compliance considerations specific to this ancillary category, including Department of Transportation (DOT), Federal Aviation Administration (FAA), European Union Aviation Safety Agency (EASA), or consumer protection requirements.',
    `service_delivery_point` STRING COMMENT 'Indicates the primary point in the passenger journey where the ancillary service is delivered (e.g., pre-flight for advance seat selection, in-flight for meals, airport for lounge access).. Valid values are `pre_flight|in_flight|post_flight|airport|online|multi_point`',
    `ssr_code` STRING COMMENT 'Four-letter IATA Special Service Request (SSR) code associated with this ancillary category for communication between airlines and service providers (e.g., WCHR for wheelchair, PETC for pet in cabin).. Valid values are `^[A-Z]{4}$`',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether ancillary products in this category can be transferred to another passenger or booking.',
    `unbundled_fare_component_flag` BOOLEAN COMMENT 'Indicates whether this category represents a component of an unbundled fare strategy, where services traditionally included in the base fare are sold separately.',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Reference taxonomy classifying ancillary products into standardized categories aligned with IATA PADIS and ATPCO Optional Services standards — e.g., baggage, seat, boarding, lounge, catering, connectivity, ground transport, accommodation, insurance, bundles. Drives merchandising logic, reporting hierarchies, and EMD issuance rules.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`price` (
    `price_id` BIGINT COMMENT 'Primary key for price',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Ancillary pricing varies by cabin class (premium seat selection costs more, business class baggage allowances differ). Revenue management pricing requires formal cabin class linkage for price rule app',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Ancillary prices are governed by the selling legal entity (company code) for BSP/ARC settlement, tax jurisdiction, and multi-entity revenue reporting. Aviation domain experts expect price records to b',
    `fare_class_bucket_id` BIGINT COMMENT 'Foreign key linking to inventory.fare_class_bucket. Business justification: Ancillary pricing rules are enforced per fare class bucket (RBD) in airline RM systems. Revenue management teams report ancillary price applicability by fare bucket to ensure correct pricing is applie',
    `product_catalog_id` BIGINT COMMENT 'Reference to the ancillary product being priced (e.g., baggage, seat selection, lounge access, Wi-Fi).',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Ancillary pricing varies by route (distance bands, regional regulations, competitive dynamics). Revenue management systems require route-level price configuration for baggage, seats, meals. Real busin',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: Ancillary prices are reviewed and updated each IATA schedule season — seasonal demand patterns drive ancillary fee adjustments. The price product has travel_date_from/to but no season FK. A revenue ma',
    `booking_class` STRING COMMENT 'Single-letter booking class (fare class) code for which this price applies. Used in yield-linked pricing strategies. Null if price applies across all booking classes.. Valid values are `^[A-Z]{1}$`',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission percentage paid to the sales channel or agent for selling this ancillary product at this price. Expressed as a percentage (e.g., 5.00 for 5%).',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this price record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this price record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the fare amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the destination of the route or market where this price applies. Null if price is not route-specific.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which this price becomes valid and can be used in offer generation and booking.',
    `emd_type` STRING COMMENT 'Type of EMD (Electronic Miscellaneous Document) used to record this ancillary charge: EMD-S (standalone) or EMD-A (associated with e-ticket). Null if not EMD-linked.. Valid values are `emd_s|emd_a`',
    `expiration_date` DATE COMMENT 'The date after which this price is no longer valid. Null for open-ended prices.',
    `fare_amount` DECIMAL(18,2) COMMENT 'The base price amount for the ancillary product in the specified currency. Does not include taxes or fees.',
    `fare_basis_code` STRING COMMENT 'Fare basis code that this ancillary price is linked to, used in yield-linked pricing strategies. Null for flat-fee or non-fare-linked pricing.. Valid values are `^[A-Z0-9]{4,16}$`',
    `market_code` STRING COMMENT 'Geographic market or region code where this price applies (e.g., origin-destination pair, country, or region). Used when price is market-specific rather than route-specific.. Valid values are `^[A-Z]{2,6}$`',
    `maximum_quantity` STRING COMMENT 'Maximum number of units that can be purchased at this price. Null if no maximum limit applies.',
    `minimum_quantity` STRING COMMENT 'Minimum number of units that must be purchased for this price to apply. Typically 1 for most ancillary products. Used for volume-based pricing.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the origin of the route or market where this price applies. Null if price is not route-specific.. Valid values are `^[A-Z]{3}$`',
    `passenger_type_code` STRING COMMENT 'Three-letter passenger type code indicating the passenger category for which this price applies (e.g., ADT for adult, CHD for child, INF for infant, SRC for senior). Null if price applies to all passenger types.. Valid values are `^[A-Z]{3}$`',
    `price_code` STRING COMMENT 'Business identifier for the price record, used in revenue management and offer generation systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `price_description` STRING COMMENT 'Detailed textual description of the price, including any special conditions, restrictions, or promotional messaging. Used for customer-facing display.',
    `price_status` STRING COMMENT 'Current lifecycle status of the price record: active (in use), inactive (not currently offered), pending (scheduled for future activation), expired (past expiration date), or suspended (temporarily disabled).. Valid values are `active|inactive|pending|expired|suspended`',
    `price_type` STRING COMMENT 'Classification of the pricing strategy: flat fee (fixed amount), yield-linked (varies with fare class), dynamic (real-time demand-based), bundled (part of fare package), promotional (temporary discount), or seasonal (time-based).. Valid values are `flat_fee|yield_linked|dynamic|bundled|promotional|seasonal`',
    `priority_rank` STRING COMMENT 'Ranking or priority order for this price when multiple prices are available for the same product and conditions. Lower numbers indicate higher priority. Used in offer generation logic.',
    `refundable_flag` BOOLEAN COMMENT 'Indicates whether the ancillary product purchased at this price is refundable. True if refundable, False if non-refundable.',
    `rfisc_code` STRING COMMENT 'IATA Reason For Issuance Sub-Code identifying the specific ancillary service type (e.g., 0CC for checked baggage, 0B5 for seat selection). Used in EMD processing and settlement.. Valid values are `^[A-Z0-9]{3,4}$`',
    `service_type` STRING COMMENT 'High-level category of the ancillary service being priced: baggage, seat selection, meal, lounge access, Wi-Fi, travel insurance, priority boarding, fast track security, cabin upgrade, or other. [ENUM-REF-CANDIDATE: baggage|seat|meal|lounge|wifi|insurance|priority_boarding|fast_track|upgrade|other — 10 candidates stripped; promote to reference product]',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the ancillary product price, including VAT, GST, or other jurisdiction-specific taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total price including base fare amount and all applicable taxes and fees.',
    `travel_date_from` DATE COMMENT 'The earliest travel date for which this price is applicable. Used for seasonal or date-restricted pricing. Null if no travel date restriction applies.',
    `travel_date_to` DATE COMMENT 'The latest travel date for which this price is applicable. Used for seasonal or date-restricted pricing. Null if no travel date restriction applies.',
    `updated_by_user` STRING COMMENT 'User identifier or system account that last modified this price record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this price record was last modified.',
    CONSTRAINT pk_price PRIMARY KEY(`price_id`)
) COMMENT 'Pricing records for ancillary products defining the fare amount, currency, applicable route or market, cabin class, passenger type code (PTC), booking class, sales channel, and effective date range. Supports dynamic and static ancillary pricing strategies including yield-linked and flat-fee models. Source of truth for ancillary price points used in offer generation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`bundle` (
    `bundle_id` BIGINT COMMENT 'Primary key for bundle',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Fare bundles define service levels aligned with cabin classes (Basic Economy, Main Cabin, Premium). Fare family design and merchandising require formal cabin class linkage for bundle eligibility rules',
    `category_id` BIGINT COMMENT 'Foreign key linking to ancillary.ancillary_category. Business justification: bundle defines bundled ancillary fare products (Basic, Standard, Flex, Premium). ancillary_category provides the IATA PAD-aligned taxonomy for classifying ancillary products. Bundles are a distinct ca',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Fare bundles are sold by a specific airline legal entity; company code governs revenue recognition, VAT treatment, and BSP settlement for bundle sales. Multi-entity airlines require this for entity-le',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Fare bundles (Basic Economy, Premium Economy, etc.) require GL mapping for revenue allocation across bundled components. Critical for unbundling revenue recognition and compliance with ASC 606 / IFRS ',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Fare bundles are configured per route or route group (transatlantic vs domestic bundles differ in included services). Real business process: route-specific bundle definition for fare family merchandis',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: Airline fare bundle portfolios (e.g., Basic, Standard, Flex) are launched and retired each IATA schedule season. Bundle effective_date/expiration_date exist but no season FK. A product management anal',
    `baggage_allowance_pieces` STRING COMMENT 'Number of checked baggage pieces included in the bundle entitlement. Null if baggage is not included or uses weight-based allowance.',
    `baggage_allowance_weight_kg` DECIMAL(18,2) COMMENT 'Total weight allowance in kilograms for checked baggage included in the bundle. Null if baggage is not included or uses piece-based allowance.',
    `base_price_amount` DECIMAL(18,2) COMMENT 'The base price of the bundle product before any adjustments, taxes, or dynamic pricing modifiers are applied.',
    `booking_channel_restriction` STRING COMMENT 'Specifies any restrictions on which booking channels can sell this bundle (e.g., direct channels only, GDS excluded, mobile app exclusive). Empty if available on all channels. [ENUM-REF-CANDIDATE: all_channels|direct_only|gds_only|mobile_only|web_only|call_center_only|travel_agent_excluded — promote to reference product]',
    `bundle_code` STRING COMMENT 'Unique business identifier code for the bundle product used in reservation systems and merchandising platforms (e.g., BASIC_ECO, FLEX_PLUS, PREMIUM_BIZ).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `bundle_description` STRING COMMENT 'Detailed description of the bundle product including all included services, entitlements, restrictions, and value proposition for customer communication.',
    `bundle_name` STRING COMMENT 'Marketing name of the bundle displayed to customers during booking and merchandising (e.g., Basic Economy, Flex Plus, Premium Business).',
    `bundle_status` STRING COMMENT 'Current lifecycle status of the bundle product indicating its availability for sale and merchandising.. Valid values are `draft|active|suspended|discontinued|archived`',
    `bundle_tier` STRING COMMENT 'Hierarchical tier level of the bundle within the airlines branded fare structure, indicating the level of service and entitlements included.. Valid values are `basic|standard|flex|premium|luxury|elite`',
    `bundle_type` STRING COMMENT 'Classification of the bundle product by its primary business purpose and composition strategy.. Valid values are `fare_bundle|service_bundle|upgrade_bundle|seasonal_bundle|promotional_bundle|loyalty_bundle`',
    `cancellation_refundable_flag` BOOLEAN COMMENT 'Indicates whether tickets purchased with this bundle are refundable upon cancellation (True) or non-refundable (False).',
    `change_fee_waived_flag` BOOLEAN COMMENT 'Indicates whether ticket change fees are waived for bookings purchased with this bundle (True) or standard change fees apply (False).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bundle product record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the bundle pricing (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which this bundle product becomes active and available for sale in reservation systems.',
    `expiration_date` DATE COMMENT 'The date on which this bundle product expires and is no longer available for sale. Null for bundles with no planned expiration.',
    `included_services_count` STRING COMMENT 'The total number of distinct ancillary services included in this bundle composition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this bundle product record was last updated or modified.',
    `lounge_access_included_flag` BOOLEAN COMMENT 'Indicates whether airport lounge access is included as an entitlement in this bundle (True) or not (False).',
    `maximum_advance_purchase_days` STRING COMMENT 'The maximum number of days before departure that this bundle can be purchased. Null if no maximum advance purchase restriction exists.',
    `meal_service_included_flag` BOOLEAN COMMENT 'Indicates whether complimentary in-flight meal service is included in this bundle (True) or meals must be purchased separately (False).',
    `mileage_accrual_percentage` DECIMAL(18,2) COMMENT 'The percentage of flown miles that accrue to the passengers Frequent Flyer Program (FFP) account when traveling on this bundle (e.g., 100.00 for full accrual, 50.00 for half accrual).',
    `minimum_advance_purchase_days` STRING COMMENT 'The minimum number of days before departure that this bundle must be purchased. Null if no advance purchase requirement exists.',
    `pricing_strategy` STRING COMMENT 'The pricing methodology applied to this bundle indicating whether pricing is fixed, dynamically adjusted based on demand, or subject to yield management rules.. Valid values are `fixed|dynamic|yield_managed|promotional|seasonal`',
    `priority_boarding_included_flag` BOOLEAN COMMENT 'Indicates whether priority boarding privileges are included in this bundle entitlement (True) or not (False).',
    `route_restriction_type` STRING COMMENT 'Indicates whether this bundle is available on all routes or restricted to specific route types (domestic, international, regional, or specific route list).. Valid values are `none|domestic_only|international_only|regional|specific_routes`',
    `seat_selection_included_flag` BOOLEAN COMMENT 'Indicates whether advance seat selection is included as an entitlement in this bundle (True) or must be purchased separately (False).',
    `seat_selection_type` STRING COMMENT 'The category of seats available for selection under this bundle entitlement (standard, preferred, extra legroom, or any seat).. Valid values are `standard|preferred|extra_legroom|any`',
    `standby_priority_level` STRING COMMENT 'The priority level assigned to passengers on this bundle when placed on standby lists for earlier or alternative flights. Lower numbers indicate higher priority.',
    `travel_date_restriction_end` DATE COMMENT 'The latest travel date for which this bundle is valid and can be applied to bookings. Null if no end date restriction exists.',
    `travel_date_restriction_start` DATE COMMENT 'The earliest travel date for which this bundle is valid and can be applied to bookings. Null if no start date restriction exists.',
    `upgrade_eligible_flag` BOOLEAN COMMENT 'Indicates whether passengers purchasing this bundle are eligible for cabin upgrades using miles, vouchers, or operational upgrades (True) or not (False).',
    `wifi_included_flag` BOOLEAN COMMENT 'Indicates whether complimentary in-flight Wi-Fi connectivity is included in this bundle entitlement (True) or not (False).',
    CONSTRAINT pk_bundle PRIMARY KEY(`bundle_id`)
) COMMENT 'Defines bundled ancillary fare products (e.g., Basic, Standard, Flex, Premium bundles) that package multiple ancillary services into a single purchasable offer. Captures bundle composition rules, included service entitlements, pricing tiers, and unbundling eligibility. Supports the airlines unbundled fare strategy and branded fare merchandising.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`bundle_component` (
    `bundle_component_id` BIGINT COMMENT 'Unique identifier for the bundle component junction record linking a bundle to a constituent ancillary product.',
    `bundle_id` BIGINT COMMENT 'Reference to the parent bundle (branded fare product) that contains this component.',
    `product_catalog_id` BIGINT COMMENT 'Reference to the specific ancillary product or service included in this bundle component.',
    `ancillary_bundle_component_status` STRING COMMENT 'Current lifecycle status of this bundle component: active (available for sale), inactive (not offered), suspended (temporarily unavailable), pending_approval (awaiting commercial approval), deprecated (being phased out), seasonal_inactive (off-season).. Valid values are `active|inactive|suspended|pending_approval|deprecated|seasonal_inactive`',
    `booking_channel_restriction` STRING COMMENT 'Booking channel restriction for this component. Defines which distribution channels can sell bundles containing this component. All indicates no restriction. [ENUM-REF-CANDIDATE: all|web|mobile|gds|call_center|airport|travel_agent|corporate_booking_tool — 8 candidates stripped; promote to reference product]',
    `cabin_class_restriction` STRING COMMENT 'Cabin class restriction for this component. Defines which cabin classes this component applies to within the bundle. All indicates no restriction.. Valid values are `all|economy|premium_economy|business|first|economy_plus`',
    `charge_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the incremental charge amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether this component is eligible for travel agent or distribution partner commission. True if commissionable; false if non-commissionable.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Commission rate percentage applicable to this component if commission_eligible is true. Null if not commissionable.',
    `component_sequence` STRING COMMENT 'Merchandising display order for this component within the bundle presentation, used for consistent UI rendering and fare comparison displays.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bundle component record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this component becomes active within the bundle composition. Used for seasonal or promotional component changes.',
    `emd_type` STRING COMMENT 'Type of EMD (Electronic Miscellaneous Document) issued for this component: emd_s (standalone, not linked to ticket), emd_a (associated with ticket), not_applicable (no EMD required).. Valid values are `emd_s|emd_a|not_applicable`',
    `entitlement_unit` STRING COMMENT 'Unit of measure for the quantity entitlement: piece (baggage items), kilogram (weight allowance), segment (per flight leg), trip (round-trip), hour (lounge time), day (rental period), access (single entry), selection (seat choice), upgrade (cabin class). [ENUM-REF-CANDIDATE: piece|kilogram|segment|trip|hour|day|access|selection|upgrade — 9 candidates stripped; promote to reference product]',
    `expiry_date` DATE COMMENT 'Date on which this component is removed from the bundle composition. Null indicates no expiration. Used for time-limited promotional components.',
    `fulfillment_timing` STRING COMMENT 'Defines when this component is delivered or activated in the customer journey: at_booking (immediate), pre_departure (before travel date), at_checkin (during check-in), at_gate (boarding area), onboard (during flight), post_flight (after arrival), on_demand (customer-initiated). [ENUM-REF-CANDIDATE: at_booking|pre_departure|at_checkin|at_gate|onboard|post_flight|on_demand — 7 candidates stripped; promote to reference product]',
    `inclusion_type` STRING COMMENT 'Defines how this ancillary product is included in the bundle: mandatory (always included), optional (customer may decline), upgradeable (customer may enhance), conditional (subject to availability or route), promotional (limited-time offer), or seasonal (specific travel periods).. Valid values are `mandatory|optional|upgradeable|conditional|promotional|seasonal`',
    `incremental_charge_amount` DECIMAL(18,2) COMMENT 'Additional charge amount for this component if is_chargeable is true. Null or zero if component is fully included in bundle base price.',
    `is_chargeable` BOOLEAN COMMENT 'Indicates whether this component incurs an additional charge beyond the bundle base price. True if customer must pay extra for this component; false if fully included in bundle price.',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether this component is refundable if the bundle is cancelled or downgraded. True if customer can receive refund for this component; false if non-refundable.',
    `is_transferable` BOOLEAN COMMENT 'Indicates whether this component entitlement can be transferred to another passenger or booking. True if transferable; false if restricted to original purchaser.',
    `marketing_description` STRING COMMENT 'Customer-facing marketing description of this component for bundle merchandising displays, fare comparison tools, and booking flow presentation.',
    `maximum_advance_purchase_days` STRING COMMENT 'Maximum number of days before departure that the bundle containing this component can be purchased. Null indicates no maximum restriction.',
    `minimum_advance_purchase_days` STRING COMMENT 'Minimum number of days before departure that the bundle containing this component must be purchased. Null or zero indicates no advance purchase requirement.',
    `passenger_type_restriction` STRING COMMENT 'Passenger type restriction for this component. Defines which passenger types are eligible for this component within the bundle. All indicates no restriction. [ENUM-REF-CANDIDATE: all|adult|child|infant|senior|student|military|corporate — 8 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Priority ranking for this component within the bundle for operational fulfillment and service delivery sequencing. Lower numbers indicate higher priority.',
    `quantity_entitlement` STRING COMMENT 'Number of units of this ancillary product included in the bundle entitlement (e.g., 1 for one checked bag, 2 for two lounge passes). Zero indicates unlimited or not-applicable.',
    `rfisc_code` STRING COMMENT 'Four-character IATA RFISC code identifying the specific ancillary service type for EMD issuance and settlement (e.g., 0CC1 for checked baggage, 0B5A for seat selection).. Valid values are `^[A-Z0-9]{4}$`',
    `route_applicability` STRING COMMENT 'Defines the route scope where this component is applicable: all (all routes), domestic (within country), international (cross-border), regional (within geographic region), intercontinental (long-haul), specific_routes (defined route list).. Valid values are `all|domestic|international|regional|intercontinental|specific_routes`',
    `service_fee_code` STRING COMMENT 'Internal or IATA service fee code for revenue accounting and settlement of this component within the bundle.',
    `terms_and_conditions_url` STRING COMMENT 'URL link to the detailed terms and conditions governing this component within the bundle, for customer disclosure and regulatory compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this bundle component record was last modified.',
    CONSTRAINT pk_bundle_component PRIMARY KEY(`bundle_component_id`)
) COMMENT 'Junction entity linking bundles to their constituent ancillary products, defining the specific services included in each bundle with quantity entitlements (e.g., 1x checked bag, 1x seat selection), inclusion type (mandatory/optional/upgradeable), and merchandising display sequence. Resolves the many-to-many relationship between bundles and products. Enables flexible bundle composition, entitlement validation at service delivery, and branded fare comparison displays.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`ancillary_order` (
    `ancillary_order_id` BIGINT COMMENT 'Unique identifier for the ancillary order. Primary key for the order entity.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Ancillary orders sold on credit (corporate accounts, agency billing) create AR entries. Links order to receivable for payment tracking, aging analysis, and reconciliation with BSP/ARC settlement files',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to ancillary.bundle. Business justification: Orders can be for bundled ancillary products (e.g., Premium bundle including baggage + seat + lounge). The order table has ancillary_bundle_code (STRING) but no FK. Adding this FK enables proper bundl',
    `booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: Links ancillary orders to specific booking passengers for passenger-level ancillary purchase tracking, service delivery, and loyalty credit. Essential for passenger service history and personalization',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Ancillary orders must be attributed to a legal entity (company code) for revenue recognition, statutory reporting, and multi-entity consolidation. Critical for IFRS compliance and intercompany elimina',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Ancillary revenue must be allocated to cost centers for financial reporting. This FK enables revenue recognition and P&L tracking by business unit/cost center.',
    `fare_class_bucket_id` BIGINT COMMENT 'Foreign key linking to inventory.fare_class_bucket. Business justification: Post-sale ancillary revenue attribution by fare class bucket is a standard airline RM report. Knowing which fare bucket was active when an ancillary was sold enables yield analysis and ancillary reven',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: Ancillary orders must link to FFP member for mileage accrual on purchases, tier-based pricing/benefits application, and member purchase history tracking. Critical for loyalty program integration with ',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Ancillary order fulfillment, IROP rebooking, and revenue reconciliation all require tracing an ancillary order to the specific operated flight leg. Operations teams use this link to void/rebook ancill',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Ancillary orders are associated with specific flight numbers for ancillary revenue attribution per flight number — a standard airline revenue accounting and BSP settlement requirement. The existing fl',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Ancillary orders generate revenue postings to GL for IFRS 15 revenue recognition. Airlines post ancillary order totals (base, tax, fee amounts) directly to GL entries. Aviation finance teams require t',
    `profile_id` BIGINT COMMENT 'Internal identifier linking the ancillary order to the passenger master record. Enables customer-level ancillary revenue analysis.',
    `pnr_id` BIGINT COMMENT 'Foreign key linking to reservation.pnr. Business justification: Links ancillary orders to booking records for revenue reconciliation, order fulfillment tracking, and BSP/ARC settlement reporting. Essential for matching ancillary revenue to base ticket sales.',
    `e_ticket_id` BIGINT COMMENT 'Foreign key linking to reservation.e_ticket. Business justification: Associates ancillary orders with e-tickets for ticket-to-ancillary revenue linkage, BSP/ARC settlement, and passenger billing. Essential for integrated ticket and ancillary revenue reporting.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Ancillary orders are sold and fulfilled at specific stations. Critical for station-level revenue reporting, inventory management, cost allocation, and operational performance tracking. Aviation domain',
    `base_amount` DECIMAL(18,2) COMMENT 'Total base price of all ancillary services in the order before taxes, fees, and discounts. Represents the gross ancillary revenue component.',
    `booking_class` STRING COMMENT 'Single-letter fare class code of the base ticket to which this ancillary order is linked. Used for bundled fare product eligibility and ancillary pricing rules.. Valid values are `^[A-Z]{1}$`',
    `cabin_class` STRING COMMENT 'Cabin class of the base ticket to which this ancillary order is linked. Influences ancillary product eligibility and pricing.. Valid values are `economy|premium_economy|business|first`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ancillary order record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the ancillary order was priced and paid (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `departure_date` DATE COMMENT 'Scheduled departure date of the flight to which the ancillary service applies. Null if the ancillary is not flight-specific.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the destination of the journey for which the ancillary service was purchased. Null if the ancillary is not flight-specific.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the ancillary order, including promotional discounts, loyalty member discounts, and bundled fare reductions.',
    `emd_number` STRING COMMENT 'Thirteen-digit EMD number issued for this ancillary order. Links the order to the official IATA-compliant revenue document for settlement and reporting.. Valid values are `^[0-9]{13}$`',
    `emd_type` STRING COMMENT 'Type of EMD issued: EMD-S (standalone, not linked to a flight coupon) or EMD-A (associated with a specific flight coupon).. Valid values are `emd_s|emd_a`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged on the ancillary order, including booking fees, service charges, and payment processing fees.',
    `fulfillment_date` TIMESTAMP COMMENT 'Timestamp when the ancillary service was delivered or consumed by the passenger. Null if not yet fulfilled.',
    `fulfillment_status` STRING COMMENT 'Status indicating whether the ancillary service has been delivered to the passenger (e.g., baggage checked, seat assigned, meal served).. Valid values are `pending|in_progress|fulfilled|not_fulfilled|cancelled`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ancillary order record was last modified. Used for audit trail and change tracking.',
    `order_date` TIMESTAMP COMMENT 'Timestamp when the ancillary order was placed by the passenger or agent. Represents the principal business event time for revenue recognition.',
    `order_number` STRING COMMENT 'Externally-visible unique order number assigned to this ancillary purchase. Used for customer service, refunds, and revenue reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the ancillary order. Tracks progression from initial booking through fulfillment or cancellation.. Valid values are `pending|confirmed|fulfilled|cancelled|refunded|partially_refunded`',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the origin of the journey for which the ancillary service was purchased. Null if the ancillary is not flight-specific.. Valid values are `^[A-Z]{3}$`',
    `payment_method` STRING COMMENT 'Payment instrument used to settle the ancillary order. Distinguishes between card payments, electronic transfers, loyalty miles, and other tender types. [ENUM-REF-CANDIDATE: credit_card|debit_card|bank_transfer|paypal|miles_redemption|voucher|cash|corporate_account — 8 candidates stripped; promote to reference product]',
    `payment_reference` STRING COMMENT 'External reference number or transaction identifier from the payment gateway or processor. Used for payment reconciliation and dispute resolution.. Valid values are `^[A-Z0-9]{8,30}$`',
    `payment_status` STRING COMMENT 'Current status of the payment transaction for this ancillary order. Tracks payment lifecycle from authorization through settlement or refund. [ENUM-REF-CANDIDATE: pending|authorized|captured|settled|failed|refunded|partially_refunded — 7 candidates stripped; promote to reference product]',
    `point_of_sale_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country where the ancillary order was sold. Used for revenue allocation and tax jurisdiction determination.. Valid values are `^[A-Z]{3}$`',
    `promotion_code` STRING COMMENT 'Promotional or discount code applied to the ancillary order. Used for marketing campaign tracking and discount validation.. Valid values are `^[A-Z0-9]{4,15}$`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to the passenger for this ancillary order. Null if no refund has been processed.',
    `refund_date` TIMESTAMP COMMENT 'Timestamp when the refund was processed for this ancillary order. Null if no refund has been issued.',
    `refund_eligibility` BOOLEAN COMMENT 'Indicates whether the ancillary order is eligible for refund based on fare rules, timing, and fulfillment status.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total taxes applied to the ancillary order, including sales tax, value-added tax (VAT), goods and services tax (GST), and other jurisdiction-specific levies.',
    `total_amount` DECIMAL(18,2) COMMENT 'Net total amount payable for the ancillary order after applying taxes, fees, and discounts. Represents the final revenue recognized for this transaction.',
    CONSTRAINT pk_ancillary_order PRIMARY KEY(`ancillary_order_id`)
) COMMENT 'Transactional record of a passengers purchase of one or more ancillary services, linked to a PNR and e-ticket. Captures order date, sales channel (GDS, NDC, direct, airport), total amount, currency, payment reference, order status, and the originating booking context. Acts as the commercial anchor for ancillary revenue recognition and EMD issuance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`order_item` (
    `order_item_id` BIGINT COMMENT 'Primary key for order_item',
    `ancillary_emd_id` BIGINT COMMENT 'Foreign key linking to ancillary.ancillary_emd. Business justification: Order items can be documented via EMD issuance. The order_item table has emd_number (STRING) but no FK. Adding this FK links order fulfillment to EMD documentation for settlement and accounting.',
    `ancillary_order_id` BIGINT COMMENT 'Reference to the parent ancillary order header that contains this line item. Links the item to its order context.',
    `booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: Associates order items with booking passengers for item-level passenger attribution, service fulfillment, and purchase history. Required for passenger-specific ancillary sales analysis.',
    `checkin_session_id` BIGINT COMMENT 'Foreign key linking to airport.checkin_session. Business justification: Excess baggage fees, seat selection, and special service ancillaries are purchased during check-in. Linking order_item to checkin_session enables check-in channel ancillary revenue attribution, baggag',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Line-item level company code attribution enables accurate revenue allocation in multi-entity airline groups, especially for codeshare and interline ancillary sales where different items may belong to ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Ancillary revenue line items must be attributed to cost centres for airline management accounting (CASK/RASK reporting by business unit). Aviation controllers require cost centre on order items to all',
    `fare_class_bucket_id` BIGINT COMMENT 'Foreign key linking to inventory.fare_class_bucket. Business justification: Ancillary attach rate analysis by fare class bucket is a core airline RM report — identifying which RBDs generate highest ancillary revenue per passenger. order_item has booking_class as a plain denor',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Ancillary order items (seat selection, baggage, meals) are sold against specific flight inventory. Revenue management and inventory control require tracking which flights inventory each ancillary sal',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Ancillary service fulfillment (seat assignment, meal delivery, baggage handling) occurs on the actual operating flight. Linking order_item to flight_leg enables ground ops and cabin crew to reconcile ',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Order items have station-specific fulfillment points (baggage charges at check-in, lounge access at specific airports). Essential for station performance tracking, revenue attribution by location, and',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Each ancillary order line item (base_amount, tax_amount, commission_amount) posts to a specific GL account for granular revenue recognition. Aviation revenue accounting requires line-item GL attributi',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to reservation.itinerary_segment. Business justification: Links ancillary order items to specific flight segments for segment-level revenue attribution, service delivery, and operational reporting. Required for per-segment ancillary sales analysis.',
    `profile_id` BIGINT COMMENT 'Reference to the specific passenger who is the recipient or beneficiary of this ancillary service.',
    `pnr_id` BIGINT COMMENT 'Foreign key linking to reservation.pnr. Business justification: Enables item-level traceability to booking for ancillary revenue attribution, refund processing, and passenger service history. Required for detailed ancillary sales reporting by booking.',
    `product_catalog_id` BIGINT COMMENT 'Reference to the specific ancillary product or service purchased in this line item from the ancillary product catalog.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Order items must link to route for ancillary revenue allocation, operational fulfillment planning, and route profitability analysis. Real business process: ancillary revenue reporting by route, servic',
    `scheduled_flight_id` BIGINT COMMENT 'Reference to the specific flight leg or segment to which this ancillary service applies. Nullable for non-flight-specific services.',
    `terminal_facility_id` BIGINT COMMENT 'Foreign key linking to airport.terminal_facility. Business justification: Lounge access, fast-track security, and terminal retail ancillary items are fulfilled at specific terminal facilities. This link enables terminal-level ancillary revenue reporting and facility utiliza',
    `base_amount` DECIMAL(18,2) COMMENT 'Total base amount for this line item (unit price multiplied by quantity), excluding taxes and fees.',
    `booking_timestamp` TIMESTAMP COMMENT 'Date and time when this ancillary service was booked or added to the order, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission amount payable to the sales agent or distribution channel for this ancillary line item.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Commission rate as a percentage of the base amount payable to the sales agent or distribution channel.',
    `confirmation_number` STRING COMMENT 'Confirmation or reference number issued upon successful booking of the ancillary service.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this order item record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this line item (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the destination of the flight segment associated with this ancillary item.. Valid values are `^[A-Z]{3}$`',
    `emd_type` STRING COMMENT 'Type of EMD issued: EMD-S (standalone, not linked to a ticket) or EMD-A (associated with an e-ticket).. Valid values are `EMD-S|EMD-A`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Additional fees or surcharges applied to this ancillary line item (e.g., processing fees, service charges).',
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight to which this ancillary service applies, in yyyy-MM-dd format.',
    `flight_number` STRING COMMENT 'Flight number (carrier code + numeric flight identifier) to which this ancillary service is linked, if applicable.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$`',
    `fulfilment_reference` STRING COMMENT 'Reference identifier used by operational systems to track delivery or fulfilment of the ancillary service (e.g., baggage tag number, seat assignment, lounge access code).',
    `issued_timestamp` TIMESTAMP COMMENT 'Date and time when the EMD or service document was issued for this ancillary item, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `line_number` STRING COMMENT 'Sequential ordering number of this item within the parent ancillary order. Used for display and processing order.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the origin of the flight segment associated with this ancillary item.. Valid values are `^[A-Z]{3}$`',
    `passenger_name` STRING COMMENT 'Full name of the passenger associated with this ancillary service item, as recorded in the PNR.',
    `product_code` STRING COMMENT 'Business code identifying the ancillary product type. May align with RFIC (Reason for Issuance Code) and RFISC (Reason for Issuance Sub-Code) standards.. Valid values are `^[A-Z0-9]{2,10}$`',
    `product_name` STRING COMMENT 'Human-readable name of the ancillary service purchased, such as Extra Baggage 23kg, Premium Seat 12A, Priority Boarding, or Wi-Fi Access.',
    `quantity` STRING COMMENT 'Quantity or count of the ancillary service purchased (e.g., 2 bags, 1 seat, 3 meal vouchers).',
    `refund_eligibility` BOOLEAN COMMENT 'Indicates whether this ancillary service is eligible for refund according to the fare rules and service terms. True if refundable, False if non-refundable.',
    `sales_channel` STRING COMMENT 'Channel through which the ancillary service was sold: web (airline website), mobile_app (airline mobile application), airport_counter (airport check-in or sales desk), call_center (reservation center), gds (Global Distribution System), travel_agent (third-party agent), or kiosk (self-service kiosk). [ENUM-REF-CANDIDATE: web|mobile_app|airport_counter|call_center|gds|travel_agent|kiosk — 7 candidates stripped; promote to reference product]',
    `service_status` STRING COMMENT 'Current status of the ancillary service: confirmed (service guaranteed), waitlisted (pending availability), cancelled (service cancelled), refunded (payment returned), pending (awaiting confirmation), or delivered (service fulfilled).. Valid values are `confirmed|waitlisted|cancelled|refunded|pending|delivered`',
    `ssr_code` STRING COMMENT 'Four-letter IATA SSR code representing the ancillary service type (e.g., BAGD for baggage, SEAT for seat selection, MEAL for meal preference).. Valid values are `^[A-Z]{4}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this ancillary line item, including VAT, GST, or other applicable taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount for this line item including base amount, taxes, and fees. Represents the full revenue for this ancillary service.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the ancillary service before taxes and fees, in the transaction currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this order item record was last modified in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    CONSTRAINT pk_order_item PRIMARY KEY(`order_item_id`)
) COMMENT 'Line-item detail of each ancillary service within an ancillary order. Captures the specific ancillary product purchased, quantity, unit price, total amount, applicable flight segment, passenger association, SSR code, service status (confirmed, waitlisted, cancelled), and fulfilment reference. Enables per-service revenue tracking and operational delivery coordination.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` (
    `ancillary_emd_id` BIGINT COMMENT 'Unique identifier for the Electronic Miscellaneous Document record. Primary key for the ancillary EMD product.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: EMDs issued on credit terms create receivables requiring tracking and collection. Essential for BSP billing, agency debt management, and reconciliation of EMD issuance with cash collection.',
    `ancillary_order_id` BIGINT COMMENT 'Foreign key linking to ancillary.ancillary_order. Business justification: ancillary_emd is an Electronic Miscellaneous Document issued for ancillary services sold. ancillary_order is the transactional purchase record that triggers EMD issuance. Linking ancillary_emd to its ',
    `booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: Links EMDs to booking passengers for passenger-specific EMD issuance, service entitlement, and refund processing. Essential for EMD passenger association and service delivery.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: EMDs are financial instruments requiring legal entity attribution for statutory reporting, tax compliance, and BSP/ARC settlement. Each EMD must be issued by a specific company code for regulatory and',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: EMD financial values (face_value_amount, commission_amount) must be attributed to cost centres for airline management accounting. Aviation controllers allocate EMD revenue to issuing station or produc',
    `e_ticket_id` BIGINT COMMENT 'Foreign key linking to reservation.e_ticket. Business justification: IATA EMD standard requires EMDs to reference the conjunction e-ticket for BSP settlement and revenue accounting. An EMD is always issued in association with a specific ticket. Aviation revenue account',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: IATA EMD coupon status (open/used/void) must be reconciled against the operated flight leg for revenue accounting and regulatory compliance. Revenue accounting teams require EMD-to-flight-leg traceabi',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: EMDs (Electronic Miscellaneous Documents) are issued against specific flight numbers per IATA Resolution 636 and BSP/ARC settlement rules. The existing flight_number column is denormalized text. A rev',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: EMDs are IATA financial instruments; each EMD issuance, exchange, or refund posts to GL for revenue recognition and BSP settlement reconciliation. Aviation finance requires direct GL linkage on EMDs f',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to reservation.itinerary_segment. Business justification: IATA EMD coupons are segment-specific (e.g., excess baggage on a particular flight leg). Interline EMD settlement and proration require the EMD to reference the specific itinerary segment. ancillary_e',
    `pnr_id` BIGINT COMMENT 'Foreign key linking to reservation.pnr. Business justification: Links EMDs to booking records for IATA BSP/ARC settlement, revenue accounting, and EMD-to-ticket association. Mandatory for EMD lifecycle management and financial reconciliation.',
    `ticket_coupon_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket_coupon. Business justification: IATA EMD standard requires EMDs to be associated with specific ticket coupons (EMD-A associated type). BSP settlement and revenue accounting depend on this coupon-level EMD linkage. An IATA revenue ',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: EMDs (Electronic Miscellaneous Documents) are issued in conjunction with tickets for ancillary services. This FK links the ancillary EMD to the base ticket for complete passenger revenue tracking and ',
    `ancillary_service_code` STRING COMMENT 'IATA RFIC (Reason for Issuance Code) or RFISC (Reason for Issuance Sub-Code) identifying the specific ancillary service. Examples: 0CC=baggage, 0B5=seat selection, 0G1=lounge access.. Valid values are `^[A-Z0-9]{4}$`',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission amount payable to the issuing agent or agency for selling the ancillary service. Used for agent settlement and revenue accounting.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Commission rate as a percentage of the face value. Used to calculate agent compensation for ancillary sales.',
    `coupon_number` STRING COMMENT 'Sequential coupon number within the EMD. An EMD may have multiple coupons for multi-segment or multi-service purchases. Typically 1 for single-service EMDs.',
    `coupon_status` STRING COMMENT 'Current status of the individual EMD coupon. Tracks the lifecycle state of each service component within the EMD. [ENUM-REF-CANDIDATE: open|used|refunded|exchanged|void|airport_control|checked_in|flown|suspended|irregular — 10 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'ISO 4217 3-letter currency code in which the EMD was issued. Identifies the monetary unit for all amounts on the document.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'IATA 3-letter airport code of the destination for the service. Identifies where the ancillary service ends or is delivered.. Valid values are `^[A-Z]{3}$`',
    `emd_number` STRING COMMENT '13-digit IATA-standard EMD number uniquely identifying the document globally. Format follows IATA Resolution 722 structure with airline code prefix and sequential number.. Valid values are `^[0-9]{13}$`',
    `emd_status` STRING COMMENT 'Current lifecycle status of the EMD coupon. Open indicates unused, used indicates service consumed, refunded indicates money returned, exchanged indicates replaced with new EMD, void indicates cancelled before use, expired indicates validity period lapsed.. Valid values are `open|used|refunded|exchanged|void|expired`',
    `emd_type` STRING COMMENT 'Type of EMD issued. EMD-S (standalone) is issued independently for ancillary services. EMD-A (associated) is linked to a base e-ticket for bundled services.. Valid values are `EMD-S|EMD-A`',
    `endorsement_restrictions` STRING COMMENT 'Free-text field containing endorsement and restriction information. Specifies conditions, limitations, or special handling instructions for the EMD.',
    `exchange_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the EMD is exchangeable. True if the ancillary service can be exchanged for another service or flight, false if non-exchangeable.',
    `face_value_amount` DECIMAL(18,2) COMMENT 'Total face value amount of the EMD in the currency of issuance. Represents the gross charge for the ancillary service before any adjustments or taxes.',
    `form_of_payment` STRING COMMENT 'Detailed form of payment string including masked card number or payment reference. Format follows IATA FOP standards. Contains partial payment card data.',
    `issue_date` DATE COMMENT 'Date on which the EMD was issued. Marks the creation of the document and start of validity period.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the EMD was issued in the issuing system. Used for audit trail and transaction sequencing.',
    `issuing_airline_code` STRING COMMENT 'IATA 2-letter or 3-letter airline code of the carrier that issued the EMD. Identifies the airline responsible for the document and settlement.. Valid values are `^[A-Z0-9]{2,3}$`',
    `origin_airport_code` STRING COMMENT 'IATA 3-letter airport code of the origin for the service. Identifies where the ancillary service begins or is consumed.. Valid values are `^[A-Z]{3}$`',
    `original_issue_date` DATE COMMENT 'Original issue date for exchanged or reissued EMDs. Tracks the first issuance date when an EMD has been modified or replaced.',
    `passenger_name` STRING COMMENT 'Full name of the passenger for whom the ancillary service EMD was issued. Format typically follows surname/given name convention per IATA standards.',
    `passenger_type_code` STRING COMMENT 'IATA passenger type code. ADT=adult, CHD=child, INF=infant, SRC=senior citizen, MIL=military, STU=student. Determines eligibility for certain ancillary services and pricing.. Valid values are `ADT|CHD|INF|SRC|MIL|STU`',
    `payment_method` STRING COMMENT 'Method of payment used to purchase the EMD. Identifies the financial instrument used for settlement. [ENUM-REF-CANDIDATE: cash|credit_card|debit_card|miles|voucher|corporate_account|bank_transfer — 7 candidates stripped; promote to reference product]',
    `refund_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the EMD is refundable. True if the ancillary service can be refunded per fare rules, false if non-refundable.',
    `service_date` DATE COMMENT 'Date on which the ancillary service is scheduled to be consumed or delivered. For flight-related services, typically matches the flight departure date.',
    `service_description` STRING COMMENT 'Human-readable description of the ancillary service purchased. Examples: Extra Baggage 23kg, Premium Seat 12A, Priority Boarding, Lounge Access.',
    `service_quantity` STRING COMMENT 'Quantity of the ancillary service purchased. For example, number of baggage pieces, number of meal vouchers, or 1 for single-use services like lounge access.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the EMD. Sum of all applicable taxes such as VAT, GST, or service taxes on the ancillary service.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount payable for the EMD including face value, taxes, and any fees. This is the final charge to the passenger.',
    `tour_code` STRING COMMENT 'Tour or promotional code associated with the EMD. Used for tracking special offers, packages, or corporate agreements.',
    `validity_end_date` DATE COMMENT 'Last date on which the EMD is valid for use. After this date, the EMD expires and cannot be consumed or refunded.',
    `validity_start_date` DATE COMMENT 'First date on which the EMD is valid for use. Defines the beginning of the service consumption window.',
    CONSTRAINT pk_ancillary_emd PRIMARY KEY(`ancillary_emd_id`)
) COMMENT 'Electronic Miscellaneous Document (EMD) master record issued for ancillary services sold separately from the base e-ticket. Captures EMD number (13-digit IATA format), EMD type (EMD-S standalone or EMD-A associated), issuing airline, issuing office/GDS, associated ticket number, passenger name, total face value, currency, issuance date, validity period, and current coupon status. SSOT for EMD lifecycle management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`seat_product` (
    `seat_product_id` BIGINT COMMENT 'Unique identifier for the commercial seat product definition. Primary key for the seat product catalog.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Seat products (sellable seat types) are aircraft-type-specific for merchandising and pricing. Airlines price "A350 Premium Economy" differently from "777 Premium Economy" due to seat specifications. R',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Seat products are cabin-specific (business extra legroom vs economy preferred seats). Seat merchandising and inventory control require formal cabin class linkage for product applicability and pricing.',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Seat product merchandising (extra legroom, preferred seats) must reference the specific cabin configuration to identify qualifying physical seats. A single aircraft type can have multiple configuratio',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Seat products (extra legroom, preferred, exit row) are sold ancillaries requiring GL account mapping for revenue recognition. Parallel to product_catalog GL mapping; seat products need dedicated reven',
    `tier_status_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier_status. Business justification: Seat product tier eligibility: seat products (exit rows, premium economy seats) are complimentary or discounted for members above a minimum tier. This FK replaces the denormalized ffp_tier_eligibility',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to ancillary.product_catalog. Business justification: seat_product defines commercial seat products available for ancillary purchase. product_catalog is the master catalog of all ancillary products and services. A seat product IS an ancillary product and',
    `advance_selection_window_hours` STRING COMMENT 'Number of hours before departure that advance seat selection opens for this product. Null if no time restriction applies.',
    `base_price_usd` DECIMAL(18,2) COMMENT 'Standard base price for this seat product in USD. Actual pricing may vary by route, fare class, and dynamic pricing rules. Used as reference price for revenue attribution.',
    `bundle_eligibility` STRING COMMENT 'Comma-separated list of fare bundle codes that include this seat product as a complimentary benefit (e.g., BASIC,STANDARD,PREMIUM,BUSINESS). Empty if not included in any bundle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this seat product record was first created in the ancillary catalog system. Used for audit trail and product lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base price (e.g., USD, EUR, GBP). Supports multi-currency pricing strategies.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this seat product is discontinued or removed from sale. Null for products with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this seat product becomes available for sale and merchandising. Supports seasonal product launches and fleet configuration changes.',
    `emd_type` STRING COMMENT 'Type of EMD issued for this seat product purchase. EMD-S (standalone) for ancillary-only purchases; EMD-A (associated) when linked to an e-ticket.. Valid values are `EMD-S|EMD-A`',
    `fare_class_eligibility` STRING COMMENT 'Comma-separated list of fare class codes eligible to purchase or select this seat product (e.g., Y,B,M,H,Q,V,W). Empty indicates available to all fare classes.',
    `in_seat_entertainment` BOOLEAN COMMENT 'Indicates whether this seat product includes a personal in-flight entertainment (IFE) screen. Key amenity for merchandising and customer experience differentiation.',
    `is_advance_selection_allowed` BOOLEAN COMMENT 'Indicates whether passengers can select this seat product in advance during booking or check-in. False for seats assigned only at gate or by operational staff.',
    `is_bassinet_compatible` BOOLEAN COMMENT 'Indicates whether this seat product supports bassinet attachment for infant passengers. Typically applies to bulkhead seats in long-haul configurations.',
    `is_bulkhead` BOOLEAN COMMENT 'Indicates whether this seat product is located at a bulkhead position (wall or divider in front). Affects legroom, storage, and bassinet availability.',
    `is_chargeable` BOOLEAN COMMENT 'Indicates whether this seat product incurs a charge for passengers. False for complimentary seat assignments included in fare bundles or elite status benefits.',
    `is_exit_row` BOOLEAN COMMENT 'Indicates whether this seat product is located in an emergency exit row. Triggers regulatory eligibility checks and safety briefing requirements per FAA/EASA regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this seat product record was last updated. Tracks pricing changes, configuration updates, and status transitions.',
    `merchandising_priority` STRING COMMENT 'Numeric ranking for display priority in seat selection interfaces and upsell offers. Lower numbers indicate higher priority for merchandising presentation.',
    `power_outlet_type` STRING COMMENT 'Type of power outlet available at this seat product for passenger device charging. Key amenity for merchandising premium seat products.. Valid values are `none|AC_110V|AC_230V|USB_A|USB_C|universal`',
    `pricing_tier` STRING COMMENT 'Revenue tier classification for this seat product. References pricing rules and fare class eligibility in revenue management systems.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|complimentary`',
    `product_status` STRING COMMENT 'Current lifecycle status of the seat product in the ancillary catalog. Controls availability for merchandising and booking channels.. Valid values are `active|inactive|suspended|discontinued|pending_approval|seasonal`',
    `recline_inches` DECIMAL(18,2) COMMENT 'Maximum recline distance of the seat in inches. Null for non-reclining seats (e.g., exit row, bulkhead).',
    `refundability_flag` BOOLEAN COMMENT 'Indicates whether the seat product purchase is refundable if the passenger cancels or changes their seat selection. Subject to fare rules and timing restrictions.',
    `rfisc_code` STRING COMMENT 'Three-character IATA RFISC code identifying the ancillary service type for EMD issuance and settlement (e.g., 0B5 for preferred seat, 0B6 for extra legroom seat).. Valid values are `^[A-Z0-9]{3}$`',
    `seat_pitch_inches` DECIMAL(18,2) COMMENT 'Distance from one point on a seat to the same point on the seat in front or behind, measured in inches. Key comfort metric for merchandising and customer communication.',
    `seat_type` STRING COMMENT 'Primary classification of the seat product defining its physical and commercial characteristics. Drives merchandising strategy and revenue attribution. [ENUM-REF-CANDIDATE: standard|preferred|extra_legroom|exit_row|bulkhead|bassinet|window|aisle|middle — 9 candidates stripped; promote to reference product]',
    `seat_width_inches` DECIMAL(18,2) COMMENT 'Width of the seat measured in inches. Key comfort specification for merchandising and customer communication.',
    `service_type_code` STRING COMMENT 'Two-letter IATA service type code for ancillary categorization and reporting (e.g., SA for seat assignment, SB for seat upgrade).. Valid values are `^[A-Z]{2}$`',
    `special_service_request_code` STRING COMMENT 'Four-letter IATA SSR code associated with this seat product for GDS and Passenger Service System (PSS) integration (e.g., EXST for extra seat, BLND for blind passenger). Null if no SSR applies.. Valid values are `^[A-Z]{4}$`',
    `transferability_flag` BOOLEAN COMMENT 'Indicates whether the seat product can be transferred to another passenger on the same Passenger Name Record (PNR) or flight. Typically false for personalized seat assignments.',
    `wifi_access_included` BOOLEAN COMMENT 'Indicates whether complimentary Wi-Fi access is included with this seat product. False if Wi-Fi requires separate purchase or is not available.',
    `zone_classification` STRING COMMENT 'Cabin zone or section identifier where this seat product is typically located (e.g., Forward Cabin, Mid Cabin, Aft Cabin, Zone A, Zone B). Used for operational boarding and merchandising segmentation.',
    CONSTRAINT pk_seat_product PRIMARY KEY(`seat_product_id`)
) COMMENT 'Commercial seat product definitions available for ancillary purchase or upgrade, defining seat types (standard, preferred, extra legroom, exit row, bulkhead), zone classifications, pitch/width specifications, applicable aircraft types, cabin class associations, and pricing tier references. This is the sellable seat product catalog — distinct from the physical seat map (fleet domain) and operational seat assignment (reservation domain). Drives seat merchandising offers and revenue attribution by seat tier.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`seat_assignment` (
    `seat_assignment_id` BIGINT COMMENT 'Primary key for seat_assignment',
    `ancillary_emd_id` BIGINT COMMENT 'Foreign key linking to ancillary.ancillary_emd. Business justification: Paid seat assignments are documented via EMD. The seat_assignment table has emd_number (STRING) but no FK. Adding this FK links seat assignment transactions to EMD documentation for revenue accounting',
    `order_item_id` BIGINT COMMENT 'Reference to the ancillary order item if this seat assignment was purchased as a paid ancillary product. Null for complimentary or auto-assigned seats.',
    `booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking_passenger. Business justification: Seat assignments are per-passenger per-segment. DCS/CUTE systems must resolve seat assignments to a specific booking passenger for boarding pass issuance and manifest generation. seat_assignment alrea',
    `checkin_session_id` BIGINT COMMENT 'Foreign key linking to airport.checkin_session. Business justification: Seat assignments are confirmed or changed during check-in. Linking seat_assignment to checkin_session enables seat change audit trails, check-in channel attribution for seat fees, and passenger servic',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: Elite complimentary seat assignment: seat assignments for loyalty elite members are created without an ancillary_order (complimentary benefit). Direct FK enables tier-based seat benefit fulfillment, e',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Seat assignments consume physical seat inventory on specific flights. Departure control and seat map management require linking assignments to flight inventory for real-time availability tracking. Ope',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Cabin crew and gate agents require seat assignments mapped to the actual operating flight (not just reservation segment) for boarding, service delivery, and operational seat map management. Flight_leg',
    `itinerary_segment_id` BIGINT COMMENT 'Reference to the specific flight segment for which the seat is assigned.',
    `mel_deferral_id` BIGINT COMMENT 'Foreign key linking to maintenance.mel_deferral. Business justification: When a seat is deferred under MEL (seat inoperative), the seat_assignment record must reference the active mel_deferral to document why the seat is blocked. Aviation ops teams and auditors require thi',
    `profile_id` BIGINT COMMENT 'Reference to the individual passenger for whom this seat is assigned.',
    `pnr_id` BIGINT COMMENT 'Reference to the passenger name record under which this seat assignment was made.',
    `seat_map_id` BIGINT COMMENT 'Foreign key linking to fleet.seat_map. Business justification: Seat assignments must reference the physical seat record from the seat map to enable operational reporting on seat characteristics (exit rows, accessibility, bulkhead) and enforce assignment rules. Cr',
    `seat_product_id` BIGINT COMMENT 'Foreign key linking to ancillary.seat_product. Business justification: Seat assignments reference commercial seat product definitions (e.g., Extra Legroom, Preferred, Standard). The seat_assignment table has seat_product_type (STRING) but no FK. Adding this FK normalizes',
    `ticket_coupon_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket_coupon. Business justification: Seat assignments are made against specific ticket coupons in airline departure control systems. This link is required for check-in processing, boarding pass generation, and post-flight revenue settlem',
    `upgrade_transaction_id` BIGINT COMMENT 'Foreign key linking to ancillary.upgrade_transaction. Business justification: seat_assignment records paid or complimentary seat assignments for passengers. When a cabin upgrade is processed via upgrade_transaction, a new seat assignment is created in the upgraded cabin. Linkin',
    `assignment_method` STRING COMMENT 'The method or channel through which the seat assignment was made, indicating whether it was passenger self-service, agent-assisted, or system auto-assigned. [ENUM-REF-CANDIDATE: self_select|agent_assigned|auto_assigned|kiosk|mobile_app|web|gate — 7 candidates stripped; promote to reference product]',
    `assignment_source_system` STRING COMMENT 'The source system or channel that originated the seat assignment transaction (PSS=Passenger Service System, DCS=Departure Control System, GDS=Global Distribution System). [ENUM-REF-CANDIDATE: pss|dcs|kiosk|mobile_app|web|gds|api — 7 candidates stripped; promote to reference product]',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the seat assignment indicating whether it is active, cancelled, or in transition.. Valid values are `confirmed|pending|cancelled|changed|blocked|released`',
    `assignment_timestamp` TIMESTAMP COMMENT 'The date and time when the seat assignment was created or last modified. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `block_reason` STRING COMMENT 'Free-text description of the reason why the seat is blocked if is_blocked is true. Examples include crew rest, broken seat, social distancing, etc.',
    `boarding_zone` STRING COMMENT 'The boarding zone or group assigned to this seat, used for boarding sequence management. May be numeric or alphabetic depending on airline policy.. Valid values are `^[1-9]$|^[A-Z]$`',
    `cabin_class_code` STRING COMMENT 'Single-letter IATA cabin class code indicating the service class of the assigned seat (F=First, J=Business, W=Premium Economy, Y=Economy).. Valid values are `^[A-Z]{1}$`',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when this seat assignment was cancelled or released. Null if the assignment is still active. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `change_reason_code` STRING COMMENT 'Code indicating the reason for a seat assignment change if the seat was reassigned after initial assignment. [ENUM-REF-CANDIDATE: passenger_request|operational|equipment_change|overbooking|upgrade|downgrade|irop|other — 8 candidates stripped; promote to reference product]',
    `check_in_sequence_number` STRING COMMENT 'The sequence number assigned during check-in process, used for boarding pass generation and boarding order.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this seat assignment record was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deck_level` STRING COMMENT 'The deck or level of the aircraft where the seat is located. Relevant for wide-body aircraft with multiple decks.. Valid values are `main|upper|lower`',
    `group_booking_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this seat assignment is part of a group booking, which may have special handling or pricing rules.',
    `infant_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether an infant (lap child) is associated with this seat assignment, which may restrict certain seat types such as exit rows.',
    `is_blocked` BOOLEAN COMMENT 'Boolean flag indicating whether the seat is blocked from assignment due to operational, safety, or commercial reasons.',
    `is_complimentary` BOOLEAN COMMENT 'Boolean flag indicating whether the seat assignment was provided at no charge (true) or as a paid ancillary service (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this seat assignment record was last updated or modified. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `loyalty_tier_at_assignment` STRING COMMENT 'The passengers loyalty program tier status at the time of seat assignment, which may influence seat selection privileges and complimentary upgrades.',
    `previous_seat_number` STRING COMMENT 'The seat number previously assigned to this passenger on this flight segment before a change was made. Null if this is the first assignment.. Valid values are `^[1-9][0-9]{0,2}[A-K]$`',
    `seat_characteristics` STRING COMMENT 'Comma-separated list of seat characteristics or attributes such as window, aisle, extra legroom, power outlet, restricted recline, etc.',
    `seat_fee_amount` DECIMAL(18,2) COMMENT 'The monetary amount charged for the seat assignment if it was a paid ancillary product. Zero or null for complimentary assignments.',
    `seat_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the seat assignment fee amount.. Valid values are `^[A-Z]{3}$`',
    `seat_number` STRING COMMENT 'The alphanumeric seat identifier consisting of row number and seat letter (e.g., 12A, 34F). Follows standard aircraft seat numbering convention.. Valid values are `^[1-9][0-9]{0,2}[A-K]$`',
    `special_service_request_code` STRING COMMENT 'Four-letter IATA SSR code associated with the seat assignment for special needs or requests (e.g., WCHR for wheelchair, PETC for pet in cabin).. Valid values are `^[A-Z]{4}$`',
    `upgrade_type` STRING COMMENT 'Indicates the type of upgrade applied if the seat assignment represents an upgrade from the originally booked cabin or seat type. Null or none if no upgrade. [ENUM-REF-CANDIDATE: paid|complimentary|operational|elite_status|voucher|bid|none — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_seat_assignment PRIMARY KEY(`seat_assignment_id`)
) COMMENT 'Transactional record of a paid or complimentary seat assignment made for a passenger on a specific flight segment. Captures seat number, deck, cabin, seat product type, assignment method (self-select, agent-assigned, auto-assigned), assignment timestamp, associated ancillary order item reference, upgrade type if applicable, and current assignment status. Enables seat revenue tracking and operational manifest generation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` (
    `baggage_allowance_id` BIGINT COMMENT 'Primary key for baggage_allowance',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Baggage allowances are defined per cabin class in fare construction rules (business 2 pieces, economy 1 piece). Fare rule application and ticketing require formal cabin class linkage. Fare constructio',
    `category_id` BIGINT COMMENT 'Foreign key linking to ancillary.category. Business justification: Baggage allowances should be classified by ancillary category (e.g., Baggage, Checked Bag, Carry-On). The baggage_allowance table has baggage_category (STRING) but no FK. Adding this FK normalizes the',
    `interline_agreement_id` BIGINT COMMENT 'Foreign key linking to route.interline_agreement. Business justification: Baggage allowances under interline agreements are governed by specific interline agreement terms — IATA Resolution 302 requires carriers to honor partner baggage allowances per interline agreement. Th',
    `tier_status_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier_status. Business justification: Elite baggage benefit assignment: baggage allowances are defined per loyalty tier (Platinum gets 3 free bags, Gold gets 2). This FK replaces the denormalized ffp_tier_code text field and enables autom',
    `allowance_code` STRING COMMENT 'Unique business identifier for the baggage allowance rule, used for reference in fare products and ancillary catalogs.. Valid values are `^[A-Z0-9]{3,10}$`',
    `allowance_name` STRING COMMENT 'Human-readable name of the baggage allowance rule (e.g., Economy Standard 2PC, Business Premium 3PC 32KG).',
    `allowance_type` STRING COMMENT 'The allowance model applied: piece_concept (number of bags), weight_concept (total weight limit), or hybrid (combination of both).. Valid values are `piece_concept|weight_concept|hybrid`',
    `applicable_ptc` STRING COMMENT 'Passenger Type Code this allowance applies to (e.g., ADT=adult, CHD=child, INF=infant, MIL=military). Null if applies to all passenger types.. Valid values are `^[A-Z]{3}$`',
    `baggage_allowance_status` STRING COMMENT 'Current lifecycle status of the baggage allowance rule: active (in use), inactive (not in use), pending (scheduled for future), expired (past validity), suspended (temporarily disabled).. Valid values are `active|inactive|pending|expired|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this baggage allowance record was first created in the system.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code for the destination of travel. Null if not country-specific.. Valid values are `^[A-Z]{2}$`',
    `destination_region_code` STRING COMMENT 'IATA region or sub-region code for the destination (e.g., TC1=North America, TC2=Europe, TC3=Asia). Null if not region-specific.. Valid values are `^[A-Z]{2,5}$`',
    `dimension_limit_cm` STRING COMMENT 'Maximum dimensions allowed for each piece in centimeters, expressed as LxWxH (e.g., 158x90x75). Null if no dimension restriction applies.. Valid values are `^d{1,3}xd{1,3}xd{1,3}$`',
    `dimension_limit_inches` STRING COMMENT 'Maximum dimensions allowed for each piece in inches, expressed as LxWxH (e.g., 62x35x30). Provided for markets using imperial units.. Valid values are `^d{1,3}xd{1,3}xd{1,3}$`',
    `effective_date` DATE COMMENT 'Date from which this baggage allowance rule becomes active and applicable to bookings.',
    `emd_type` STRING COMMENT 'Type of EMD used to document this baggage allowance when purchased as ancillary: EMD-S (standalone) or EMD-A (associated with e-ticket).. Valid values are `EMD-S|EMD-A`',
    `expiry_date` DATE COMMENT 'Date on which this baggage allowance rule ceases to be valid. Null for open-ended rules.',
    `fare_brand_code` STRING COMMENT 'Fare brand or product code associated with this allowance (e.g., BASIC, STANDARD, FLEX, PREMIUM). Null if not brand-specific.. Valid values are `^[A-Z0-9]{2,10}$`',
    `is_combinable` BOOLEAN COMMENT 'Indicates whether this allowance can be combined with other allowances (e.g., fare allowance + FFP tier allowance). True if combinable, false if exclusive.',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether the baggage allowance (if purchased as ancillary) is refundable. True if refundable, false if non-refundable.',
    `is_transferable` BOOLEAN COMMENT 'Indicates whether this baggage allowance can be transferred to another passenger or booking. True if transferable, false if non-transferable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this baggage allowance record was last updated or modified.',
    `linear_dimension_limit_cm` STRING COMMENT 'Maximum sum of length, width, and height in centimeters (L+W+H). Common standard is 158 cm for international checked baggage.',
    `linear_dimension_limit_inches` STRING COMMENT 'Maximum sum of length, width, and height in inches (L+W+H). Common standard is 62 inches for international checked baggage.',
    `marketing_carrier_code` STRING COMMENT 'IATA two-letter airline code of the marketing carrier for which this allowance applies. Null if applies to all carriers.. Valid values are `^[A-Z0-9]{2}$`',
    `operating_carrier_code` STRING COMMENT 'IATA two-letter airline code of the operating carrier for which this allowance applies. Null if applies to all carriers.. Valid values are `^[A-Z0-9]{2}$`',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code for the origin of travel. Null if not country-specific.. Valid values are `^[A-Z]{2}$`',
    `origin_region_code` STRING COMMENT 'IATA region or sub-region code for the origin (e.g., TC1=North America, TC2=Europe, TC3=Asia). Null if not region-specific.. Valid values are `^[A-Z]{2,5}$`',
    `piece_count` STRING COMMENT 'Number of baggage pieces allowed under this rule (applicable for piece concept allowances). Null if weight concept only.',
    `priority_rank` STRING COMMENT 'Priority ranking used to resolve conflicts when multiple allowance rules apply to the same booking context. Lower number = higher priority.',
    `rfisc_code` STRING COMMENT 'IATA RFISC code identifying the specific ancillary service type for baggage (e.g., 0CC1=first checked bag, 0CC2=second checked bag).. Valid values are `^[A-Z0-9]{4}$`',
    `route_group_code` STRING COMMENT 'Route group or geographic zone code this allowance applies to (e.g., DOM=domestic, INTL=international, TRANSATLANTIC). Null if applies globally.. Valid values are `^[A-Z0-9]{2,10}$`',
    `special_conditions` STRING COMMENT 'Free-text field describing any special conditions, restrictions, or notes applicable to this baggage allowance (e.g., Applies only to direct flights, Excludes codeshare partners).',
    `weight_limit_kg` DECIMAL(18,2) COMMENT 'Maximum weight allowed per piece or total weight limit in kilograms. Applicable for weight concept or per-piece weight restrictions.',
    `weight_limit_lbs` DECIMAL(18,2) COMMENT 'Maximum weight allowed per piece or total weight limit in pounds. Provided for markets using imperial units.',
    CONSTRAINT pk_baggage_allowance PRIMARY KEY(`baggage_allowance_id`)
) COMMENT 'Defines the baggage entitlement rules associated with a fare product, frequent flyer tier, or ancillary purchase — including number of pieces, weight limits (kg/lbs), size restrictions, and applicable route/cabin/PTC combinations. Supports both piece concept and weight concept allowance models per IATA Resolution 302. Used for entitlement validation at check-in and ancillary upsell logic.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` (
    `upgrade_offer_id` BIGINT COMMENT 'Unique identifier for the upgrade offer record. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Upgrade offer eligibility is restricted by aircraft type in real airline merchandising (e.g., lie-flat upgrades only on widebody aircraft). upgrade_offer.aircraft_type_restriction is a denormalized te',
    `tier_status_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier_status. Business justification: Upgrade offer eligibility enforcement: upgrade offers are restricted to members at or above a minimum loyalty tier (e.g., only Gold+ eligible for bid upgrades). This FK replaces the denormalized ffp_t',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to ancillary.product_catalog. Business justification: upgrade_offer defines commercial upgrade offers (e.g., Economy to Business cabin upgrades) which are ancillary revenue products. product_catalog is the master catalog for all ancillary products. Linki',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Revenue management configures upgrade offers per route — long-haul vs. short-haul routes have distinct upgrade pricing and availability. route_restriction is a denormalized text representation of this',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: Upgrade offer campaigns are planned and activated per IATA schedule season — airlines launch seasonal upgrade promotions aligned to schedule season cycles. upgrade_offer has effective_start_date/end_d',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Upgrade offers specify source cabin class for eligibility (economy to business, business to first). Upgrade program design and offer targeting require formal cabin class linkage for source eligibility',
    `channel_availability` STRING COMMENT 'Comma-separated list of distribution channels where this upgrade offer is available (e.g., web, mobile app, airport kiosk, call center, Global Distribution System (GDS)). Defines merchandising channel strategy.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this upgrade offer record. Audit field for accountability and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this upgrade offer record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this offer (minimum bid, maximum bid, fixed price).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this upgrade offer expires and is no longer valid. Null indicates an open-ended offer with no expiration. Defines the end of the offers lifecycle.',
    `effective_start_date` DATE COMMENT 'The date from which this upgrade offer becomes valid and available for presentation to passengers. Defines the beginning of the offers lifecycle.',
    `eligible_fare_classes` STRING COMMENT 'Comma-separated list of fare class codes (booking classes) that qualify for this upgrade offer. Fare classes determine revenue management eligibility and upgrade priority.',
    `emd_type_code` STRING COMMENT 'IATA Electronic Miscellaneous Document (EMD) type code associated with this upgrade offer when issued as an ancillary charge. Typically A for EMD-A (standalone) or S for EMD-S (associated with e-ticket).. Valid values are `^[A-Z]{1}$`',
    `fixed_price_amount` DECIMAL(18,2) COMMENT 'The fixed monetary price for instant upgrade offers. Null for bid-based or miles-based offers. Represents the non-negotiable purchase price.',
    `inventory_controlled_flag` BOOLEAN COMMENT 'Boolean indicator whether this upgrade offer is subject to real-time inventory availability checks in the target cabin. True means offer availability depends on seat inventory; false means offer is always available regardless of inventory.',
    `last_modified_by_user` STRING COMMENT 'User identifier or system account that last modified this upgrade offer record. Audit field for change accountability and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this upgrade offer record was last updated. Audit field for change tracking and data quality monitoring.',
    `maximum_bid_amount` DECIMAL(18,2) COMMENT 'The maximum monetary bid amount allowed for bid-based upgrade offers. Null for non-bid offer types. Represents the ceiling price for competitive bidding.',
    `miles_required` STRING COMMENT 'Number of Frequent Flyer Program (FFP) miles required to redeem this upgrade offer. Null for non-miles-based offers.',
    `minimum_bid_amount` DECIMAL(18,2) COMMENT 'The minimum monetary bid amount required for bid-based upgrade offers. Null for non-bid offer types. Represents the floor price for competitive bidding.',
    `offer_close_hours` STRING COMMENT 'Number of hours before scheduled departure when this upgrade offer closes and is no longer available for purchase or bidding. Defines the closing of the offer window.',
    `offer_code` STRING COMMENT 'Externally-known unique code identifying this upgrade offer in merchandising and revenue management systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `offer_description` STRING COMMENT 'Detailed description of the upgrade offer including benefits, terms, and conditions presented to passengers during the offer flow.',
    `offer_name` STRING COMMENT 'Marketing name or title of the upgrade offer displayed to passengers in booking channels and merchandising platforms.',
    `offer_status` STRING COMMENT 'Current lifecycle status of the upgrade offer. Active offers are available for purchase or bidding; inactive offers are not currently presented; expired offers have passed their validity window; suspended offers are temporarily paused; withdrawn offers have been permanently removed.. Valid values are `active|inactive|expired|suspended|withdrawn`',
    `offer_type` STRING COMMENT 'Classification of the upgrade offer mechanism. Bid upgrade allows passengers to submit competitive bids; instant upgrade is fixed-price immediate purchase; miles upgrade uses Frequent Flyer Program (FFP) miles; operational upgrade is airline-initiated for operational reasons; points upgrade uses loyalty points; voucher upgrade redeems a voucher or certificate.. Valid values are `bid_upgrade|instant_upgrade|miles_upgrade|operational_upgrade|points_upgrade|voucher_upgrade`',
    `offer_window_hours` STRING COMMENT 'Number of hours before scheduled departure that this upgrade offer becomes available to eligible passengers. Defines the opening of the offer window.',
    `points_required` STRING COMMENT 'Number of loyalty points required to redeem this upgrade offer. Null for non-points-based offers. Distinct from miles for coalition or partner loyalty programs.',
    `priority_level` STRING COMMENT 'Numeric priority ranking for this upgrade offer when multiple offers are available. Lower numbers indicate higher priority. Used for offer sequencing and conflict resolution.',
    `revenue_accounting_code` STRING COMMENT 'Internal accounting code used to classify and track revenue generated from this upgrade offer in financial reporting and revenue management systems.. Valid values are `^[A-Z0-9]{4,10}$`',
    `target_cabin_class` STRING COMMENT 'The destination cabin class to which the passenger will be upgraded if the offer is accepted and confirmed.. Valid values are `premium_economy|business|first`',
    `terms_and_conditions_url` STRING COMMENT 'Web URL linking to the full legal terms and conditions governing this upgrade offer. Required for consumer protection and transparency compliance.. Valid values are `^https?://.*`',
    CONSTRAINT pk_upgrade_offer PRIMARY KEY(`upgrade_offer_id`)
) COMMENT 'Defines commercial upgrade offers presented to passengers for cabin upgrades (e.g., Economy to Business) via bid, fixed-price, or miles-based mechanisms. Captures offer type (bid upgrade, instant upgrade, miles upgrade, operational upgrade), eligible fare classes, minimum and maximum bid amounts, offer window (hours before departure), target cabin, and channel availability. Supports revenue-optimized upgrade merchandising programs.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` (
    `upgrade_transaction_id` BIGINT COMMENT 'Primary key for upgrade_transaction',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Paid upgrade transactions (cash bids, miles+cash) create AR entries for collection tracking. Aviation finance requires AR linkage on upgrade transactions for payment reconciliation, dunning, and BSP s',
    `ancillary_emd_id` BIGINT COMMENT 'Foreign key linking to ancillary.ancillary_emd. Business justification: Paid upgrade transactions are documented via EMD. The upgrade_transaction table has emd_number (STRING) but no FK. Adding this FK links upgrade transactions to EMD documentation for revenue accounting',
    `booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: Associates upgrade transactions with booking passengers for passenger-specific upgrade tracking, bid management, and service delivery. Required for upgrade program passenger attribution.',
    `checkin_session_id` BIGINT COMMENT 'Foreign key linking to airport.checkin_session. Business justification: Operational upgrades are frequently processed at check-in counters. Linking upgrade_transaction to checkin_session enables upgrade audit trails tied to specific check-in events, supports IROPS upgrade',
    `fare_class_bucket_id` BIGINT COMMENT 'Foreign key linking to inventory.fare_class_bucket. Business justification: Upgrade clearance tracking by destination fare class bucket is a core RM process — upgrades consume inventory in the destination RBD bucket. upgrade_transaction has destination_fare_class as a plain d',
    `e_ticket_id` BIGINT COMMENT 'Foreign key linking to reservation.e_ticket. Business justification: Paid or bid upgrades require ticket reissuance or EMD generation tied to a specific e-ticket. Revenue accounting and audit trails for upgrade transactions must reference the resulting/associated e-tic',
    `ffp_member_id` BIGINT COMMENT 'Unique identifier for the loyalty program member account used for miles redemption or status-based upgrade eligibility.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Paid upgrades (bid_amount, upgrade_amount) generate revenue postings to GL for IFRS 15 recognition. Aviation revenue accounting teams post upgrade revenue separately from base fare; direct GL link on ',
    `inventory_leg_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_leg. Business justification: Upgrade transactions affect inventory capacity on specific legs — the destination cabin gains a booking while the origin cabin releases one. Linking upgrade_transaction to inventory_leg enables RM sys',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to reservation.itinerary_segment. Business justification: Associates upgrade transactions with flight segments for segment-specific upgrade tracking, inventory control, and operational reporting. Required for per-segment upgrade management.',
    `profile_id` BIGINT COMMENT 'Unique identifier for the passenger who received or purchased the upgrade.',
    `pnr_id` BIGINT COMMENT 'Foreign key linking to reservation.pnr. Business justification: Associates upgrade transactions with booking for upgrade revenue tracking, bid management, and passenger service history. Essential for upgrade program reporting and revenue optimization.',
    `scheduled_flight_id` BIGINT COMMENT 'Unique identifier for the scheduled flight on which the upgrade was applied.',
    `upgrade_offer_id` BIGINT COMMENT 'Foreign key linking to ancillary.upgrade_offer. Business justification: Upgrade transactions are based on specific upgrade offers (e.g., bid upgrade, mileage upgrade, paid upgrade). No FK currently exists. Adding this FK links transactions to their originating offer defin',
    `bid_acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the upgrade bid was accepted and confirmed by the system. Null for non-bid or unsuccessful bid upgrades.',
    `bid_amount` DECIMAL(18,2) COMMENT 'Amount bid by the passenger in an upgrade auction or bid program. Null for non-bid upgrades.',
    `bid_submission_timestamp` TIMESTAMP COMMENT 'Date and time when the passenger submitted the upgrade bid. Null for non-bid upgrades.',
    `booking_channel` STRING COMMENT 'Channel through which the upgrade transaction was initiated: web (airline website), mobile_app (airline mobile application), call_center (phone reservation), airport_kiosk (self-service kiosk), gds (Global Distribution System), travel_agent (third-party agent), partner (codeshare or alliance partner). [ENUM-REF-CANDIDATE: web|mobile_app|call_center|airport_kiosk|gds|travel_agent|partner — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the upgrade transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the upgrade transaction amount.. Valid values are `^[A-Z]{3}$`',
    `denial_reason_code` STRING COMMENT 'Standardized code explaining why the upgrade was denied: insufficient_inventory (no seats available), low_priority (other passengers cleared first), payment_failed (transaction declined), ineligible_fare (fare class not eligible), system_error (technical issue), expired (offer expired), cancelled_by_pax (passenger cancelled). Null if upgrade not denied. [ENUM-REF-CANDIDATE: insufficient_inventory|low_priority|payment_failed|ineligible_fare|system_error|expired|cancelled_by_pax — 7 candidates stripped; promote to reference product]',
    `destination_cabin_class` STRING COMMENT 'The target cabin class to which the passenger is upgrading (economy, premium_economy, business, first).. Valid values are `economy|premium_economy|business|first`',
    `destination_fare_class` STRING COMMENT 'Single-letter fare class code assigned after the upgrade is confirmed.. Valid values are `^[A-Z]{1}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the upgrade transaction record was last updated, reflecting status changes or data corrections.',
    `miles_redeemed` BIGINT COMMENT 'Number of frequent flyer miles consumed for the upgrade. Zero for non-mileage upgrades.',
    `origin_cabin_class` STRING COMMENT 'The original cabin class from which the passenger is upgrading (economy, premium_economy, business, first).. Valid values are `economy|premium_economy|business|first`',
    `origin_fare_class` STRING COMMENT 'Single-letter fare class code of the original booking, determining upgrade eligibility and priority.. Valid values are `^[A-Z]{1}$`',
    `payment_method` STRING COMMENT 'Payment instrument used for the upgrade transaction: credit_card, debit_card, miles (FFP miles), voucher (upgrade certificate), cash, bank_transfer, none (complimentary or operational). [ENUM-REF-CANDIDATE: credit_card|debit_card|miles|voucher|cash|bank_transfer|none — 7 candidates stripped; promote to reference product]',
    `priority_score` STRING COMMENT 'Calculated priority score determining upgrade clearance order, based on fare class, elite status, bid amount, and other factors.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to the passenger if the upgrade was cancelled or denied after payment, in the transaction currency. Zero if no refund issued.',
    `refund_processed_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was processed and returned to the passenger. Null if no refund issued.',
    `seat_number_destination` STRING COMMENT 'New seat assignment after the upgrade is cleared (e.g., 2A, 8D).. Valid values are `^[0-9]{1,3}[A-K]{1}$`',
    `seat_number_origin` STRING COMMENT 'Original seat assignment before the upgrade (e.g., 23A, 45F).. Valid values are `^[0-9]{1,3}[A-K]{1}$`',
    `upgrade_amount` DECIMAL(18,2) COMMENT 'Monetary amount paid by the passenger for the upgrade, in the transaction currency. Zero for non-purchased upgrades (miles, operational, complimentary).',
    `upgrade_cleared_timestamp` TIMESTAMP COMMENT 'Date and time when the upgrade was fully processed, seat assigned, and boarding pass updated.',
    `upgrade_confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the upgrade was confirmed and guaranteed to the passenger.',
    `upgrade_request_timestamp` TIMESTAMP COMMENT 'Date and time when the upgrade transaction was initiated or requested by the passenger or system.',
    `upgrade_status` STRING COMMENT 'Current lifecycle status of the upgrade transaction: pending (submitted awaiting processing), confirmed (upgrade guaranteed), waitlisted (on standby list), cleared (upgrade processed and seat assigned), denied (upgrade request rejected), cancelled (customer or system cancelled), expired (upgrade offer or bid expired). [ENUM-REF-CANDIDATE: pending|confirmed|waitlisted|cleared|denied|cancelled|expired — 7 candidates stripped; promote to reference product]',
    `upgrade_transaction_number` STRING COMMENT 'Externally-visible unique transaction number for the upgrade event, used for customer service reference and audit tracking.. Valid values are `^UPG[0-9]{10}$`',
    `upgrade_type` STRING COMMENT 'Classification of the upgrade method: purchased (paid cash upgrade), bid_won (successful upgrade bid), miles_redeemed (FFP miles used), operational (involuntary operational upgrade), complimentary (airline-initiated goodwill), status_based (elite status automatic upgrade), voucher (upgrade certificate or voucher applied). [ENUM-REF-CANDIDATE: purchased|bid_won|miles_redeemed|operational|complimentary|status_based|voucher — 7 candidates stripped; promote to reference product]',
    `voucher_code` STRING COMMENT 'Alphanumeric code of the upgrade voucher or certificate applied to this transaction. Null if no voucher used.. Valid values are `^[A-Z0-9]{8,16}$`',
    `waitlist_position` STRING COMMENT 'Passengers position on the upgrade waitlist at the time of transaction creation. Null if not waitlisted.',
    CONSTRAINT pk_upgrade_transaction PRIMARY KEY(`upgrade_transaction_id`)
) COMMENT 'Transactional record of a passenger cabin upgrade event, whether purchased, bid-won, miles-redeemed, or operationally assigned. Captures upgrade type, origin cabin, destination cabin, amount paid or miles consumed, bid submission and acceptance timestamps, flight segment, passenger reference, and upgrade status (pending, confirmed, waitlisted, cleared, denied). Enables upgrade revenue tracking and yield impact analysis.';

CREATE OR REPLACE TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` (
    `eligibility_rule_id` BIGINT COMMENT 'Primary key for eligibility_rule',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Ancillary eligibility rules must be scoped to specific cabin configurations when airlines retrofit aircraft (e.g., new premium economy cabin). Rules like seat selection product X eligible only on con',
    `category_id` BIGINT COMMENT 'Foreign key linking to ancillary.ancillary_category. Business justification: eligibility_rule defines business rules governing which passengers, fare classes, routes, and booking windows can access ancillary products. While eligibility_rule already links to product_catalog for',
    `mel_item_id` BIGINT COMMENT 'Foreign key linking to maintenance.mel_item. Business justification: Ancillary eligibility rules must suppress product sales (wifi, IFE, specific seat features) when the corresponding equipment is on MEL. Revenue management teams create eligibility rules referencing th',
    `product_catalog_id` BIGINT COMMENT 'Reference to the specific ancillary product or service to which this eligibility rule applies.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Eligibility rules restrict ancillary availability by specific routes (e.g., premium seats only on long-haul, lounge access on international). Real business process: merchandising rules engine evaluate',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: Ancillary product eligibility rules are configured per IATA schedule season — winter season rules differ from summer (e.g., ski equipment, seasonal fare class eligibility). Revenue management reviews ',
    `aircraft_type_list` STRING COMMENT 'Comma-separated list of IATA aircraft type codes (e.g., 737, 777, A320) for which this ancillary product is eligible. Empty indicates no aircraft restriction.',
    `booking_date_from` DATE COMMENT 'Start date of the booking window during which this eligibility rule is active. Null indicates no booking start date restriction.',
    `booking_date_to` DATE COMMENT 'End date of the booking window during which this eligibility rule is active. Null indicates no booking end date restriction.',
    `cabin_class_list` STRING COMMENT 'Comma-separated list of cabin classes (First, Business, Premium Economy, Economy) eligible for this ancillary product. Empty indicates no cabin restriction.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this eligibility rule record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this eligibility rule record was first created in the system.',
    `destination_airport_list` STRING COMMENT 'Comma-separated list of IATA airport codes representing eligible destination points. Empty indicates no destination restriction.',
    `destination_country_list` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-2 country codes representing eligible destination countries. Empty indicates no destination country restriction.',
    `effective_date` DATE COMMENT 'Date from which this eligibility rule becomes active and enforceable in all sales channels.',
    `exclusion_rule_flag` BOOLEAN COMMENT 'Indicates whether this is an exclusion rule (true) that prevents eligibility, or an inclusion rule (false) that grants eligibility.',
    `expiration_date` DATE COMMENT 'Date after which this eligibility rule is no longer active. Null indicates an open-ended rule.',
    `fare_class_list` STRING COMMENT 'Comma-separated list of booking class codes (RBD - Revenue Booking Designator) to which this rule applies. Empty indicates no fare class restriction.',
    `ffp_tier_list` STRING COMMENT 'Comma-separated list of loyalty program tier codes (e.g., Gold, Platinum, Diamond) eligible for this ancillary product. Empty indicates no tier restriction.',
    `is_combinable` BOOLEAN COMMENT 'Indicates whether this eligibility rule can be combined with other rules (true) or must be evaluated independently (false).',
    `last_modified_by_user` STRING COMMENT 'User identifier or system account that most recently modified this eligibility rule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this eligibility rule record was most recently updated.',
    `marketing_carrier_list` STRING COMMENT 'Comma-separated list of IATA airline codes representing marketing carriers for which this rule applies. Empty indicates all carriers.',
    `maximum_advance_purchase_days` STRING COMMENT 'Maximum number of days before departure that the ancillary product may be purchased. Null indicates no maximum advance purchase restriction.',
    `minimum_advance_purchase_days` STRING COMMENT 'Minimum number of days before departure that the ancillary product must be purchased. Null indicates no minimum advance purchase requirement.',
    `operating_carrier_list` STRING COMMENT 'Comma-separated list of IATA airline codes representing operating carriers for which this rule applies. Empty indicates all carriers.',
    `origin_airport_list` STRING COMMENT 'Comma-separated list of IATA airport codes representing eligible origin points. Empty indicates no origin restriction.',
    `origin_country_list` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-2 country codes representing eligible origin countries. Empty indicates no origin country restriction.',
    `override_allowed_flag` BOOLEAN COMMENT 'Indicates whether authorized agents or systems may override this eligibility rule under exceptional circumstances.',
    `passenger_type_code_list` STRING COMMENT 'Comma-separated list of IATA passenger type codes (ADT, CHD, INF, MIL, SRC, etc.) eligible for this ancillary product. Empty indicates no passenger type restriction.',
    `priority_rank` STRING COMMENT 'Numeric priority order for rule evaluation when multiple rules apply to the same ancillary product. Lower numbers indicate higher priority.',
    `rule_code` STRING COMMENT 'Business-assigned unique code identifying this eligibility rule for operational reference and system integration.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `rule_description` STRING COMMENT 'Detailed business description of the eligibility rule, including rationale, business context, and any special conditions or exceptions.',
    `rule_logic_expression` STRING COMMENT 'Complex logical expression or formula defining advanced eligibility conditions beyond standard attribute filters. Used for multi-condition rules requiring AND/OR/NOT logic.',
    `rule_name` STRING COMMENT 'Human-readable name describing the purpose and scope of this eligibility rule.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the eligibility rule indicating whether it is actively enforced in sales channels.. Valid values are `active|inactive|suspended|pending|expired`',
    `rule_type` STRING COMMENT 'Classification of the eligibility rule defining the primary dimension of restriction or entitlement (fare class, route, FFP tier, booking window, passenger type, or cabin).. Valid values are `fare_class_restriction|route_restriction|tier_based_entitlement|advance_purchase_window|passenger_type_restriction|cabin_restriction`',
    `sales_channel_list` STRING COMMENT 'Comma-separated list of sales channels (web, mobile, GDS, call_center, airport, agency) through which this ancillary product may be purchased. Empty indicates all channels.',
    `terms_and_conditions_url` STRING COMMENT 'Web address linking to the full terms and conditions document governing this eligibility rule for customer transparency and regulatory compliance.',
    `travel_date_from` DATE COMMENT 'Start date of the travel period during which this eligibility rule applies. Null indicates no start date restriction.',
    `travel_date_to` DATE COMMENT 'End date of the travel period during which this eligibility rule applies. Null indicates no end date restriction.',
    CONSTRAINT pk_eligibility_rule PRIMARY KEY(`eligibility_rule_id`)
) COMMENT 'Business rules defining which passengers, fare classes, routes, cabin types, booking windows, and FFP tiers are eligible to purchase specific ancillary products. Captures rule type (fare-class restriction, route restriction, tier-based entitlement, advance-purchase window, passenger-type restriction), effective date range, priority order, and override flags. Drives real-time ancillary offer eligibility checks across all sales channels.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ADD CONSTRAINT `fk_ancillary_product_catalog_category_id` FOREIGN KEY (`category_id`) REFERENCES `airlines_ecm`.`ancillary`.`category`(`category_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ADD CONSTRAINT `fk_ancillary_category_parent_category_ancillary_category_id` FOREIGN KEY (`parent_category_ancillary_category_id`) REFERENCES `airlines_ecm`.`ancillary`.`category`(`category_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ADD CONSTRAINT `fk_ancillary_price_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ADD CONSTRAINT `fk_ancillary_bundle_category_id` FOREIGN KEY (`category_id`) REFERENCES `airlines_ecm`.`ancillary`.`category`(`category_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ADD CONSTRAINT `fk_ancillary_bundle_component_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `airlines_ecm`.`ancillary`.`bundle`(`bundle_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ADD CONSTRAINT `fk_ancillary_bundle_component_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ADD CONSTRAINT `fk_ancillary_ancillary_order_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `airlines_ecm`.`ancillary`.`bundle`(`bundle_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_ancillary_emd_id` FOREIGN KEY (`ancillary_emd_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_emd`(`ancillary_emd_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_ancillary_order_id` FOREIGN KEY (`ancillary_order_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_order`(`ancillary_order_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ADD CONSTRAINT `fk_ancillary_order_item_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ADD CONSTRAINT `fk_ancillary_ancillary_emd_ancillary_order_id` FOREIGN KEY (`ancillary_order_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_order`(`ancillary_order_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ADD CONSTRAINT `fk_ancillary_seat_product_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_ancillary_emd_id` FOREIGN KEY (`ancillary_emd_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_emd`(`ancillary_emd_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `airlines_ecm`.`ancillary`.`order_item`(`order_item_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_seat_product_id` FOREIGN KEY (`seat_product_id`) REFERENCES `airlines_ecm`.`ancillary`.`seat_product`(`seat_product_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ADD CONSTRAINT `fk_ancillary_seat_assignment_upgrade_transaction_id` FOREIGN KEY (`upgrade_transaction_id`) REFERENCES `airlines_ecm`.`ancillary`.`upgrade_transaction`(`upgrade_transaction_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ADD CONSTRAINT `fk_ancillary_baggage_allowance_category_id` FOREIGN KEY (`category_id`) REFERENCES `airlines_ecm`.`ancillary`.`category`(`category_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ADD CONSTRAINT `fk_ancillary_upgrade_offer_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_ancillary_emd_id` FOREIGN KEY (`ancillary_emd_id`) REFERENCES `airlines_ecm`.`ancillary`.`ancillary_emd`(`ancillary_emd_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ADD CONSTRAINT `fk_ancillary_upgrade_transaction_upgrade_offer_id` FOREIGN KEY (`upgrade_offer_id`) REFERENCES `airlines_ecm`.`ancillary`.`upgrade_offer`(`upgrade_offer_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ADD CONSTRAINT `fk_ancillary_eligibility_rule_category_id` FOREIGN KEY (`category_id`) REFERENCES `airlines_ecm`.`ancillary`.`category`(`category_id`);
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ADD CONSTRAINT `fk_ancillary_eligibility_rule_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `airlines_ecm`.`ancillary`.`product_catalog`(`product_catalog_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`ancillary` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `airlines_ecm`.`ancillary` SET TAGS ('dbx_domain' = 'ancillary');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Identifier');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `base_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Price Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `base_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Price Currency Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `base_price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `booking_window_end_hours` SET TAGS ('dbx_business_glossary_term' = 'Booking Window End Hours Before Departure');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `booking_window_start_hours` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Start Hours Before Departure');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `cabin_class_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Eligibility');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Availability');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `fare_family_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Eligibility');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `iata_emd_service_type` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Electronic Miscellaneous Document (EMD) Service Type Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `iata_emd_service_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `iata_ssim_service_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Standard Schedules Information Manual (SSIM) Service Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `iata_ssim_service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `inventory_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Controlled Indicator Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `maximum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Purchase Quantity');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `partner_product_flag` SET TAGS ('dbx_business_glossary_term' = 'Partner Product Indicator Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `passenger_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Eligibility');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'fixed|dynamic|tiered|bundled|promotional');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `product_short_name` SET TAGS ('dbx_business_glossary_term' = 'Product Short Name');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `product_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `product_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|discontinued|pending_approval');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `refundable_flag` SET TAGS ('dbx_business_glossary_term' = 'Refundable Indicator Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `revenue_accounting_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Accounting Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `revenue_accounting_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `route_applicability` SET TAGS ('dbx_business_glossary_term' = 'Route Applicability Scope');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `route_applicability` SET TAGS ('dbx_value_regex' = 'all|domestic|international|regional|specific_routes');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `ssr_code` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `ssr_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Indicator Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`product_catalog` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Category Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `parent_category_ancillary_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `ancillary_category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `ancillary_category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `atpco_service_group` SET TAGS ('dbx_business_glossary_term' = 'Airline Tariff Publishing Company (ATPCO) Service Group');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Level');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'service|product|bundle|insurance|transport|accommodation');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `direct_channel_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Channel Only Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `dot_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Reportable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `emd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Eligible Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `emd_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `emd_type` SET TAGS ('dbx_value_regex' = 'EMD-S|EMD-A|not_applicable');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `gds_distribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Distribution Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `iata_padis_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Passenger and Airport Data Interchange Standards (PADIS) Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `iata_padis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `merchandising_priority` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Priority');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `ndc_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'New Distribution Capability (NDC) Compatible Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `refundable_flag` SET TAGS ('dbx_business_glossary_term' = 'Refundable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `service_delivery_point` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Point');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `service_delivery_point` SET TAGS ('dbx_value_regex' = 'pre_flight|in_flight|post_flight|airport|online|multi_point');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `ssr_code` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `ssr_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`category` ALTER COLUMN `unbundled_fare_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Unbundled Fare Component Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Identifier');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `fare_class_bucket_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Bucket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Product Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `booking_class` SET TAGS ('dbx_business_glossary_term' = 'Booking Class');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `booking_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `emd_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `emd_type` SET TAGS ('dbx_value_regex' = 'emd_s|emd_a');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Fare Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,16}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `market_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `maximum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `price_code` SET TAGS ('dbx_business_glossary_term' = 'Price Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `price_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `price_description` SET TAGS ('dbx_business_glossary_term' = 'Price Description');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'flat_fee|yield_linked|dynamic|bundled|promotional|seasonal');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `refundable_flag` SET TAGS ('dbx_business_glossary_term' = 'Refundable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `rfisc_code` SET TAGS ('dbx_business_glossary_term' = 'Reason For Issuance Sub-Code (RFISC)');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `rfisc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `travel_date_from` SET TAGS ('dbx_business_glossary_term' = 'Travel Date From');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `travel_date_to` SET TAGS ('dbx_business_glossary_term' = 'Travel Date To');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `airlines_ecm`.`ancillary`.`price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `baggage_allowance_pieces` SET TAGS ('dbx_business_glossary_term' = 'Baggage Allowance Pieces');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `baggage_allowance_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Baggage Allowance Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `base_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Price Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `booking_channel_restriction` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Restriction');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_business_glossary_term' = 'Bundle Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_description` SET TAGS ('dbx_business_glossary_term' = 'Bundle Description');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_name` SET TAGS ('dbx_business_glossary_term' = 'Bundle Name');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_status` SET TAGS ('dbx_business_glossary_term' = 'Bundle Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|discontinued|archived');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_tier` SET TAGS ('dbx_business_glossary_term' = 'Bundle Tier');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|flex|premium|luxury|elite');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_business_glossary_term' = 'Bundle Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_value_regex' = 'fare_bundle|service_bundle|upgrade_bundle|seasonal_bundle|promotional_bundle|loyalty_bundle');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `cancellation_refundable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Refundable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `change_fee_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Fee Waived Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `included_services_count` SET TAGS ('dbx_business_glossary_term' = 'Included Services Count');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `lounge_access_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Lounge Access Included Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `maximum_advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Advance Purchase Days');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `meal_service_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Service Included Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `mileage_accrual_percentage` SET TAGS ('dbx_business_glossary_term' = 'Mileage Accrual Percentage');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `minimum_advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Purchase Days');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'fixed|dynamic|yield_managed|promotional|seasonal');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `priority_boarding_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Boarding Included Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `route_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Route Restriction Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `route_restriction_type` SET TAGS ('dbx_value_regex' = 'none|domestic_only|international_only|regional|specific_routes');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `seat_selection_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Seat Selection Included Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `seat_selection_type` SET TAGS ('dbx_business_glossary_term' = 'Seat Selection Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `seat_selection_type` SET TAGS ('dbx_value_regex' = 'standard|preferred|extra_legroom|any');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `standby_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Standby Priority Level');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `travel_date_restriction_end` SET TAGS ('dbx_business_glossary_term' = 'Travel Date Restriction End');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `travel_date_restriction_start` SET TAGS ('dbx_business_glossary_term' = 'Travel Date Restriction Start');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `upgrade_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligible Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle` ALTER COLUMN `wifi_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Wi-Fi Included Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `bundle_component_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Product Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `ancillary_bundle_component_status` SET TAGS ('dbx_business_glossary_term' = 'Component Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `ancillary_bundle_component_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|deprecated|seasonal_inactive');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `booking_channel_restriction` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Restriction');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `cabin_class_restriction` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Restriction');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `cabin_class_restriction` SET TAGS ('dbx_value_regex' = 'all|economy|premium_economy|business|first|economy_plus');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `charge_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Currency Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `charge_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `component_sequence` SET TAGS ('dbx_business_glossary_term' = 'Component Display Sequence');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Component Effective Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `emd_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `emd_type` SET TAGS ('dbx_value_regex' = 'emd_s|emd_a|not_applicable');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `entitlement_unit` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Unit of Measure');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Component Expiry Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `fulfillment_timing` SET TAGS ('dbx_business_glossary_term' = 'Component Fulfillment Timing');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `inclusion_type` SET TAGS ('dbx_business_glossary_term' = 'Component Inclusion Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `inclusion_type` SET TAGS ('dbx_value_regex' = 'mandatory|optional|upgradeable|conditional|promotional|seasonal');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `incremental_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Incremental Charge Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `is_chargeable` SET TAGS ('dbx_business_glossary_term' = 'Component Chargeable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `is_refundable` SET TAGS ('dbx_business_glossary_term' = 'Component Refundable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `is_transferable` SET TAGS ('dbx_business_glossary_term' = 'Component Transferable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `marketing_description` SET TAGS ('dbx_business_glossary_term' = 'Component Marketing Description');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `maximum_advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Advance Purchase Days');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `minimum_advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Purchase Days');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `passenger_type_restriction` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Restriction');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Component Priority Level');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `quantity_entitlement` SET TAGS ('dbx_business_glossary_term' = 'Quantity Entitlement');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `rfisc_code` SET TAGS ('dbx_business_glossary_term' = 'Reason For Issuance Sub-Code (RFISC)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `rfisc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `route_applicability` SET TAGS ('dbx_business_glossary_term' = 'Route Applicability Scope');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `route_applicability` SET TAGS ('dbx_value_regex' = 'all|domestic|international|regional|intercontinental|specific_routes');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `service_fee_code` SET TAGS ('dbx_business_glossary_term' = 'Service Fee Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`ancillary`.`bundle_component` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `ancillary_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Order Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Bundle Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `fare_class_bucket_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Bucket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Pnr Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `e_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation E Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `base_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `booking_class` SET TAGS ('dbx_business_glossary_term' = 'Booking Class');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `booking_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `emd_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `emd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `emd_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `emd_type` SET TAGS ('dbx_value_regex' = 'emd_s|emd_a');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date and Time');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|fulfilled|not_fulfilled|cancelled');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date and Time');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Order Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|fulfilled|cancelled|refunded|partially_refunded');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `payment_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `payment_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `point_of_sale_country` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Country');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `point_of_sale_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date and Time');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `refund_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligibility Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item Identifier');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `ancillary_emd_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Emd Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `ancillary_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Order Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `checkin_session_id` SET TAGS ('dbx_business_glossary_term' = 'Checkin Session Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `fare_class_bucket_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Bucket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Pnr Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Product Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `terminal_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Facility Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `base_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Service Confirmation Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `emd_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `emd_type` SET TAGS ('dbx_value_regex' = 'EMD-S|EMD-A');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Departure Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `fulfilment_reference` SET TAGS ('dbx_business_glossary_term' = 'Fulfilment Reference');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issuance Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Sequence Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `passenger_name` SET TAGS ('dbx_business_glossary_term' = 'Passenger Full Name');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `passenger_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `passenger_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Product Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Product Name');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Quantity');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `refund_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligibility Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'confirmed|waitlisted|cancelled|refunded|pending|delivered');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `ssr_code` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `ssr_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Line Item Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`order_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `ancillary_emd_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Electronic Miscellaneous Document (EMD) ID');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `ancillary_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `e_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'E Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Pnr Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `ticket_coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Coupon Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `ancillary_service_code` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `ancillary_service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `coupon_number` SET TAGS ('dbx_business_glossary_term' = 'Coupon Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `coupon_status` SET TAGS ('dbx_business_glossary_term' = 'Coupon Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `emd_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `emd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `emd_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `emd_status` SET TAGS ('dbx_value_regex' = 'open|used|refunded|exchanged|void|expired');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `emd_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `emd_type` SET TAGS ('dbx_value_regex' = 'EMD-S|EMD-A');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `endorsement_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Restrictions');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `exchange_indicator` SET TAGS ('dbx_business_glossary_term' = 'Exchange Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `face_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Face Value Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `form_of_payment` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment (FOP)');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `form_of_payment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `form_of_payment` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `issuing_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Airline Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `issuing_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `original_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Original Issue Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `passenger_name` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `passenger_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `passenger_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_value_regex' = 'ADT|CHD|INF|SRC|MIL|STU');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `refund_indicator` SET TAGS ('dbx_business_glossary_term' = 'Refund Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `service_quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Quantity');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `tour_code` SET TAGS ('dbx_business_glossary_term' = 'Tour Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`ancillary_emd` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` SET TAGS ('dbx_subdomain' = 'seat_upgrades');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `seat_product_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Product Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `tier_status_id` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tier Status Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `advance_selection_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Advance Selection Window (Hours)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `base_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Base Price (United States Dollar - USD)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `bundle_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Fare Bundle Eligibility');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `emd_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `emd_type` SET TAGS ('dbx_value_regex' = 'EMD-S|EMD-A');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `fare_class_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Eligibility');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `in_seat_entertainment` SET TAGS ('dbx_business_glossary_term' = 'In-Seat Entertainment Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `is_advance_selection_allowed` SET TAGS ('dbx_business_glossary_term' = 'Advance Selection Allowed Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `is_bassinet_compatible` SET TAGS ('dbx_business_glossary_term' = 'Bassinet Compatible Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `is_bulkhead` SET TAGS ('dbx_business_glossary_term' = 'Bulkhead Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `is_chargeable` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `is_exit_row` SET TAGS ('dbx_business_glossary_term' = 'Exit Row Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `merchandising_priority` SET TAGS ('dbx_business_glossary_term' = 'Merchandising Priority Rank');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `power_outlet_type` SET TAGS ('dbx_business_glossary_term' = 'Power Outlet Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `power_outlet_type` SET TAGS ('dbx_value_regex' = 'none|AC_110V|AC_230V|USB_A|USB_C|universal');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Classification');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|complimentary');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `product_status` SET TAGS ('dbx_business_glossary_term' = 'Seat Product Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `product_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|discontinued|pending_approval|seasonal');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `recline_inches` SET TAGS ('dbx_business_glossary_term' = 'Seat Recline (Inches)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `refundability_flag` SET TAGS ('dbx_business_glossary_term' = 'Refundability Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `rfisc_code` SET TAGS ('dbx_business_glossary_term' = 'Reason For Issuance Sub-Code (RFISC)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `rfisc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `seat_pitch_inches` SET TAGS ('dbx_business_glossary_term' = 'Seat Pitch (Inches)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `seat_type` SET TAGS ('dbx_business_glossary_term' = 'Seat Type Classification');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `seat_width_inches` SET TAGS ('dbx_business_glossary_term' = 'Seat Width (Inches)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Type Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `service_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `special_service_request_code` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `special_service_request_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `transferability_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferability Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `wifi_access_included` SET TAGS ('dbx_business_glossary_term' = 'Wi-Fi Access Included Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_product` ALTER COLUMN `zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Cabin Zone Classification');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` SET TAGS ('dbx_subdomain' = 'seat_upgrades');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `seat_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Assignment Identifier');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `ancillary_emd_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Emd Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Order Item Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `checkin_session_id` SET TAGS ('dbx_business_glossary_term' = 'Checkin Session Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Segment Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `mel_deferral_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Deferral Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `seat_map_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Map Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `seat_product_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Product Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `ticket_coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Coupon Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `upgrade_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Transaction Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Seat Assignment Method');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `assignment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source System');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Seat Assignment Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'confirmed|pending|cancelled|changed|blocked|released');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Seat Assignment Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `block_reason` SET TAGS ('dbx_business_glossary_term' = 'Seat Block Reason');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `boarding_zone` SET TAGS ('dbx_business_glossary_term' = 'Boarding Zone');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `boarding_zone` SET TAGS ('dbx_value_regex' = '^[1-9]$|^[A-Z]$');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `cabin_class_code` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `cabin_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Seat Assignment Cancelled Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Seat Change Reason Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `check_in_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Check-In Sequence Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `deck_level` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Deck Level');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `deck_level` SET TAGS ('dbx_value_regex' = 'main|upper|lower');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `group_booking_indicator` SET TAGS ('dbx_business_glossary_term' = 'Group Booking Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `infant_indicator` SET TAGS ('dbx_business_glossary_term' = 'Infant Indicator');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Is Seat Blocked');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `is_complimentary` SET TAGS ('dbx_business_glossary_term' = 'Is Complimentary Seat Assignment');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `loyalty_tier_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Loyalty Tier at Assignment');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `previous_seat_number` SET TAGS ('dbx_business_glossary_term' = 'Previous Seat Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `previous_seat_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{0,2}[A-K]$');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `seat_characteristics` SET TAGS ('dbx_business_glossary_term' = 'Seat Characteristics');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `seat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Seat Assignment Fee Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `seat_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Seat Fee Currency Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `seat_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `seat_number` SET TAGS ('dbx_business_glossary_term' = 'Seat Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `seat_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{0,2}[A-K]$');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `special_service_request_code` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `special_service_request_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`seat_assignment` ALTER COLUMN `upgrade_type` SET TAGS ('dbx_business_glossary_term' = 'Seat Upgrade Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` SET TAGS ('dbx_subdomain' = 'seat_upgrades');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `baggage_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Baggage Allowance Identifier');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `interline_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `tier_status_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Status Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `allowance_code` SET TAGS ('dbx_business_glossary_term' = 'Baggage Allowance Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `allowance_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `allowance_name` SET TAGS ('dbx_business_glossary_term' = 'Baggage Allowance Name');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Baggage Allowance Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'piece_concept|weight_concept|hybrid');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `applicable_ptc` SET TAGS ('dbx_business_glossary_term' = 'Applicable Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `applicable_ptc` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `baggage_allowance_status` SET TAGS ('dbx_business_glossary_term' = 'Allowance Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `baggage_allowance_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `destination_region_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Region Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `destination_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `dimension_limit_cm` SET TAGS ('dbx_business_glossary_term' = 'Dimension Limit (Centimeters)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `dimension_limit_cm` SET TAGS ('dbx_value_regex' = '^d{1,3}xd{1,3}xd{1,3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `dimension_limit_inches` SET TAGS ('dbx_business_glossary_term' = 'Dimension Limit (Inches)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `dimension_limit_inches` SET TAGS ('dbx_value_regex' = '^d{1,3}xd{1,3}xd{1,3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `emd_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `emd_type` SET TAGS ('dbx_value_regex' = 'EMD-S|EMD-A');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `fare_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Brand Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `fare_brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `is_combinable` SET TAGS ('dbx_business_glossary_term' = 'Is Combinable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `is_refundable` SET TAGS ('dbx_business_glossary_term' = 'Is Refundable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `is_transferable` SET TAGS ('dbx_business_glossary_term' = 'Is Transferable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `linear_dimension_limit_cm` SET TAGS ('dbx_business_glossary_term' = 'Linear Dimension Limit (Centimeters)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `linear_dimension_limit_inches` SET TAGS ('dbx_business_glossary_term' = 'Linear Dimension Limit (Inches)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `origin_region_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Region Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `origin_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `piece_count` SET TAGS ('dbx_business_glossary_term' = 'Piece Count');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `rfisc_code` SET TAGS ('dbx_business_glossary_term' = 'Reason for Issuance Sub-Code (RFISC)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `rfisc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `route_group_code` SET TAGS ('dbx_business_glossary_term' = 'Route Group Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `route_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `weight_limit_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Limit (Kilograms)');
ALTER TABLE `airlines_ecm`.`ancillary`.`baggage_allowance` ALTER COLUMN `weight_limit_lbs` SET TAGS ('dbx_business_glossary_term' = 'Weight Limit (Pounds)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` SET TAGS ('dbx_subdomain' = 'seat_upgrades');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `upgrade_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Offer Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `tier_status_id` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tier Status Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Source Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Channel Availability');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `eligible_fare_classes` SET TAGS ('dbx_business_glossary_term' = 'Eligible Fare Classes');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `emd_type_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Type Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `emd_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `fixed_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Price Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `inventory_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Controlled Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `maximum_bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bid Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `miles_required` SET TAGS ('dbx_business_glossary_term' = 'Miles Required');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `minimum_bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Bid Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `offer_close_hours` SET TAGS ('dbx_business_glossary_term' = 'Offer Close Hours');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Offer Name');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|withdrawn');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'bid_upgrade|instant_upgrade|miles_upgrade|operational_upgrade|points_upgrade|voucher_upgrade');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `offer_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Offer Window Hours');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `points_required` SET TAGS ('dbx_business_glossary_term' = 'Points Required');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `revenue_accounting_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Accounting Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `revenue_accounting_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `target_cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Target Cabin Class');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `target_cabin_class` SET TAGS ('dbx_value_regex' = 'premium_economy|business|first');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_offer` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` SET TAGS ('dbx_subdomain' = 'seat_upgrades');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `upgrade_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Transaction Identifier');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `ancillary_emd_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Emd Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `checkin_session_id` SET TAGS ('dbx_business_glossary_term' = 'Checkin Session Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `fare_class_bucket_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Fare Class Bucket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `e_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'E Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `inventory_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Pnr Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Flight ID');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `upgrade_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Offer Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `bid_acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Acceptance Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `bid_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `destination_cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Destination Cabin Class');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `destination_cabin_class` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `destination_fare_class` SET TAGS ('dbx_business_glossary_term' = 'Destination Fare Class');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `destination_fare_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `miles_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Miles Redeemed');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `origin_cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Origin Cabin Class');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `origin_cabin_class` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `origin_fare_class` SET TAGS ('dbx_business_glossary_term' = 'Origin Fare Class');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `origin_fare_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `priority_score` SET TAGS ('dbx_business_glossary_term' = 'Priority Score');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `refund_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `seat_number_destination` SET TAGS ('dbx_business_glossary_term' = 'Seat Number Destination');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `seat_number_destination` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}[A-K]{1}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `seat_number_origin` SET TAGS ('dbx_business_glossary_term' = 'Seat Number Origin');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `seat_number_origin` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}[A-K]{1}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `upgrade_amount` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Amount');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `upgrade_cleared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Cleared Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `upgrade_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Confirmed Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `upgrade_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Request Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `upgrade_status` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `upgrade_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Transaction Number');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `upgrade_transaction_number` SET TAGS ('dbx_value_regex' = '^UPG[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `upgrade_type` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `voucher_code` SET TAGS ('dbx_business_glossary_term' = 'Voucher Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `voucher_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`upgrade_transaction` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Identifier');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `mel_item_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Item Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Product Identifier (ID)');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `aircraft_type_list` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `booking_date_from` SET TAGS ('dbx_business_glossary_term' = 'Booking Date From');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `booking_date_to` SET TAGS ('dbx_business_glossary_term' = 'Booking Date To');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `cabin_class_list` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `destination_airport_list` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `destination_country_list` SET TAGS ('dbx_business_glossary_term' = 'Destination Country List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `exclusion_rule_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rule Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `fare_class_list` SET TAGS ('dbx_business_glossary_term' = 'Fare Class List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `ffp_tier_list` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Tier List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `is_combinable` SET TAGS ('dbx_business_glossary_term' = 'Is Combinable Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `marketing_carrier_list` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `maximum_advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Advance Purchase Days');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `minimum_advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Purchase Days');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `operating_carrier_list` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `origin_airport_list` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `origin_country_list` SET TAGS ('dbx_business_glossary_term' = 'Origin Country List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `override_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `passenger_type_code_list` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC) List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `rule_logic_expression` SET TAGS ('dbx_business_glossary_term' = 'Rule Logic Expression');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|expired');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'fare_class_restriction|route_restriction|tier_based_entitlement|advance_purchase_window|passenger_type_restriction|cabin_restriction');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `sales_channel_list` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel List');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `travel_date_from` SET TAGS ('dbx_business_glossary_term' = 'Travel Date From');
ALTER TABLE `airlines_ecm`.`ancillary`.`eligibility_rule` ALTER COLUMN `travel_date_to` SET TAGS ('dbx_business_glossary_term' = 'Travel Date To');
