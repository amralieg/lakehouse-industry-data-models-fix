-- Schema for Domain: distribution | Business: Food Beverage | Version: v1_mvm
-- Generated on: 2026-05-05 23:22:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`distribution` COMMENT 'Owns physical distribution and outbound logistics execution — DC operations, WMS transactions, order fulfillment, carrier management, route optimization, OTIF/fill rate KPIs, cold chain compliance, ASN processing, 3PL performance, cross-docking, DSD route management, proof of delivery, and last-mile logistics for retail, foodservice, and DTC fulfillment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`center` (
    `center_id` BIGINT COMMENT 'Unique identifier for the distribution center. Primary key for the distribution center master record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: In multi-entity F&B companies, each DC belongs to a legal entity (company code) driving intercompany billing, tax jurisdiction assignment, and statutory financial reporting. Domain experts expect comp',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each DC is a cost center in F&B — warehouse labor, utilities, and lease costs are allocated by cost center. Finance runs cost-per-case and overhead absorption reports by DC. A domain expert would expe',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Distribution centers storing food products must be registered as food facilities under FDA 21 CFR Part 1, Subpart H. Linking center to its establishment_registration enables renewal tracking, inspecti',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: Distribution centers are assigned to serve specific geographic markets. Brand and marketing teams use DC-to-market mapping for launch readiness, distribution coverage analysis, and ACV reporting — a s',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: DC-to-territory alignment drives sales quota assignment, route planning, and coverage reporting in F&B. The center has primary_service_region as a denormalized text field; a proper FK to sales.territo',
    `address_line_1` STRING COMMENT 'Primary street address line for the distribution center physical location including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as building, suite, or unit number. Nullable.',
    `ambient_zone_flag` BOOLEAN COMMENT 'Indicates whether the distribution center has ambient temperature storage zones for dry goods and shelf-stable products.',
    `center_name` STRING COMMENT 'Official business name of the distribution center facility.',
    `city` STRING COMMENT 'City or municipality where the distribution center is located.',
    `contact_email_address` STRING COMMENT 'Primary contact email address for the distribution center facility for operational communications and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone_number` STRING COMMENT 'Primary contact phone number for the distribution center facility for operational coordination and emergency contact.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the distribution center location (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution center record was first created in the system. Used for data lineage and audit trail.',
    `cross_dock_capable_flag` BOOLEAN COMMENT 'Indicates whether the distribution center has cross-docking capabilities to transfer products directly from inbound to outbound without storage.',
    `cubic_capacity` DECIMAL(18,2) COMMENT 'Total cubic footage storage capacity of the distribution center for volumetric capacity planning.',
    `dc_code` STRING COMMENT 'Business identifier code for the distribution center used across operational systems and external communications. Typically alphanumeric facility code.. Valid values are `^[A-Z0-9]{4,12}$`',
    `direct_store_delivery_hub_flag` BOOLEAN COMMENT 'Indicates whether the distribution center serves as a hub for Direct Store Delivery operations to retail locations.',
    `dock_door_count` STRING COMMENT 'Total number of loading dock doors available for inbound and outbound shipments. Critical for throughput capacity analysis.',
    `ecommerce_fulfillment_flag` BOOLEAN COMMENT 'Indicates whether the distribution center handles direct-to-consumer e-commerce order fulfillment and last-mile delivery.',
    `erp_plant_code` STRING COMMENT 'Plant or location code in the ERP system (SAP S/4HANA) representing this distribution center for financial and supply chain transactions.',
    `facility_type` STRING COMMENT 'Classification of the distribution center based on primary storage and handling capability. Ambient for dry goods, refrigerated for chilled products, frozen for sub-zero storage, multi-temperature for mixed zones, cross-dock for flow-through operations, consolidation for order aggregation.. Valid values are `ambient|refrigerated|frozen|multi_temperature|cross_dock|consolidation`',
    `frozen_zone_flag` BOOLEAN COMMENT 'Indicates whether the distribution center has frozen storage zones for products requiring sub-zero temperature storage.',
    `haccp_certified_flag` BOOLEAN COMMENT 'Indicates whether the distribution center has HACCP certification for food safety management. Required for facilities handling high-risk food products.',
    `inbound_dock_door_count` STRING COMMENT 'Number of dock doors dedicated to receiving inbound shipments from suppliers and manufacturing plants.',
    `iso_9001_certified_flag` BOOLEAN COMMENT 'Indicates whether the distribution center has ISO 9001 quality management system certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution center record was last updated in the system. Used for change tracking and data quality monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the distribution center in decimal degrees for geospatial analysis and route optimization.',
    `lease_expiry_date` DATE COMMENT 'Expiration date of the facility lease agreement for leased distribution centers. Nullable for owned facilities. Used for real estate planning and renewal management.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the distribution center in decimal degrees for geospatial analysis and route optimization.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for weekdays (Monday-Friday) in format HH:MM-HH:MM (e.g., 06:00-22:00). Used for scheduling and service level planning.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for weekends (Saturday-Sunday) in format HH:MM-HH:MM. Nullable if facility does not operate on weekends.',
    `operational_start_date` DATE COMMENT 'Date when the distribution center began operational activities and started processing inventory and shipments.',
    `operational_status` STRING COMMENT 'Current operational state of the distribution center in its lifecycle. Active indicates full operations, inactive for non-operational but maintained, under construction for facilities being built, decommissioned for permanently closed, seasonal for periodic operations, temporarily closed for short-term shutdowns.. Valid values are `active|inactive|under_construction|decommissioned|seasonal|temporarily_closed`',
    `outbound_dock_door_count` STRING COMMENT 'Number of dock doors dedicated to shipping outbound orders to customers, retail stores, and distribution points.',
    `ownership_model` STRING COMMENT 'Ownership and operational control model for the distribution center. Company-owned for internal facilities, third-party logistics (3PL) for outsourced operations, leased for rented facilities with internal operations, co-managed for hybrid arrangements.. Valid values are `company_owned|third_party_logistics|leased|co_managed`',
    `pallet_position_capacity` STRING COMMENT 'Maximum number of pallet positions available for storage in the distribution center. Key metric for inventory capacity planning.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the distribution center location used for shipping and logistics routing.',
    `refrigerated_zone_flag` BOOLEAN COMMENT 'Indicates whether the distribution center has refrigerated storage zones for chilled products requiring cold chain management.',
    `state_province` STRING COMMENT 'State, province, or primary administrative division where the distribution center is located.',
    `storage_square_footage` DECIMAL(18,2) COMMENT 'Square footage dedicated to product storage areas excluding staging, dock, and administrative space.',
    `temperature_zone_count` STRING COMMENT 'Number of distinct temperature-controlled zones within the distribution center for managing products with different storage requirements.',
    `third_party_logistics_provider` STRING COMMENT 'Name of the third-party logistics provider managing the facility if ownership model is 3PL or co-managed. Null for company-owned facilities.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the distribution center location used for scheduling and operational time calculations (e.g., America/New_York, America/Chicago).',
    `total_square_footage` DECIMAL(18,2) COMMENT 'Total building square footage of the distribution center facility including all storage, staging, and administrative areas.',
    `twenty_four_seven_operation_flag` BOOLEAN COMMENT 'Indicates whether the distribution center operates 24 hours a day, 7 days a week for continuous fulfillment operations.',
    `wms_system_identifier` STRING COMMENT 'Identifier for the Warehouse Management System instance managing this distribution center. Used for system integration and data reconciliation.',
    CONSTRAINT pk_center PRIMARY KEY(`center_id`)
) COMMENT 'Master record for each Distribution Center (DC) in the F&B network — physical facility attributes including location, type (ambient, refrigerated, frozen, cross-dock), storage capacity (pallet positions, cubic footage), temperature zones, dock door count, WMS system identifier, 3PL-managed flag, FDA facility registration number, GFSI certification status, and operational hours. SSOT for DC identity across the distribution domain.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Unique identifier for the transportation carrier. Primary key for the carrier master record.',
    `fsma_record_id` BIGINT COMMENT 'Foreign key linking to regulatory.fsma_record. Business justification: FSMA Sanitary Transportation rule (21 CFR Part 1, Subpart O) requires food carriers to maintain records of temperature controls, cleaning procedures, and sanitation. Linking carrier to fsma_record ena',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Freight carriers in F&B are contracted through procurement via freight/3PL purchase contracts. Linking carrier to its governing purchase contract enables contract compliance monitoring, rate validatio',
    `carrier_name` STRING COMMENT 'Full legal name of the transportation carrier organization as registered with regulatory authorities.',
    `carrier_status` STRING COMMENT 'Current operational status of the carrier in the approved carrier network. Controls eligibility for load assignment.. Valid values are `active|inactive|suspended|pending_approval|disqualified`',
    `carrier_type` STRING COMMENT 'Classification of carrier business model: asset-based (owns equipment), non-asset-based (brokerage), third-party logistics provider, private fleet (company-owned), or Direct Store Delivery fleet.. Valid values are `asset_based|non_asset_based|broker|3pl|private_fleet|dsd_fleet`',
    `claims_ratio_percentage` DECIMAL(18,2) COMMENT 'Percentage of shipments resulting in damage, loss, or shortage claims over the past 12 months. Used for carrier risk assessment.',
    `cold_chain_capable_flag` BOOLEAN COMMENT 'Indicates whether the carrier has temperature-controlled equipment and processes certified for transporting refrigerated and frozen food products.',
    `contracted_rate_tier` STRING COMMENT 'Rate tier classification based on contracted pricing agreement. Tier 1 represents preferred pricing, spot market represents non-contracted rates.. Valid values are `tier_1|tier_2|tier_3|spot_market`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier master record was first created in the system. Used for data lineage and audit trail.',
    `dispatch_phone` STRING COMMENT '24/7 dispatch phone number for load tendering, driver coordination, and real-time shipment tracking.',
    `dot_number` STRING COMMENT 'Unique identifier issued by the US Department of Transportation Federal Motor Carrier Safety Administration for interstate commercial carriers.. Valid values are `^[0-9]{1,8}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether the carrier supports EDI transaction sets for load tendering, status updates, and Advanced Shipping Notice (ASN) processing.',
    `edi_protocol` STRING COMMENT 'Technical protocol used for electronic data interchange with the carrier: ANSI X12, EDIFACT, API integration, or none.. Valid values are `ansi_x12|edifact|api|none`',
    `fleet_size` STRING COMMENT 'Total number of power units (tractors, trucks) operated by the carrier. Used for capacity planning and carrier capability assessment.',
    `fsma_certification_date` DATE COMMENT 'Date when the carrier received FSMA Sanitary Transportation compliance certification. Used to track recertification cycles.',
    `fsma_compliant_flag` BOOLEAN COMMENT 'Indicates whether the carrier meets FSMA Sanitary Transportation of Human and Animal Food requirements including temperature control, equipment sanitation, and training documentation.',
    `fsma_expiration_date` DATE COMMENT 'Expiration date of the carriers FSMA Sanitary Transportation compliance certification. Triggers recertification workflow.',
    `headquarters_address_line1` STRING COMMENT 'Primary street address line for the carriers corporate headquarters location.',
    `headquarters_city` STRING COMMENT 'City where the carriers corporate headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the carriers headquarters location (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the carriers corporate headquarters location.',
    `headquarters_state_province` STRING COMMENT 'State or province code where the carriers corporate headquarters is located.',
    `insurance_certificate_number` STRING COMMENT 'Reference number for the carriers liability and cargo insurance certificate on file. Required for carrier qualification.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total liability coverage amount in USD provided by the carriers insurance policy. Must meet minimum threshold for carrier approval.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the carriers current insurance policy. Carrier status automatically suspended if insurance lapses.',
    `last_audit_date` DATE COMMENT 'Date of the most recent carrier compliance audit covering safety, food safety, insurance, and operational standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier master record was most recently updated. Used for change tracking and data synchronization.',
    `mc_number` STRING COMMENT 'Operating authority number issued by FMCSA for for-hire interstate carriers. Required for carriers transporting regulated commodities.. Valid values are `^[0-9]{1,8}$`',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next carrier compliance audit. Used to trigger audit planning and carrier notification.',
    `onboarding_date` DATE COMMENT 'Date when the carrier was approved and onboarded into the approved carrier network. Marks the start of the business relationship.',
    `otif_percentage` DECIMAL(18,2) COMMENT 'Rolling 12-month percentage of shipments delivered on-time and in-full without damage or shortage. Key performance indicator for carrier evaluation.',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days from invoice date for carrier freight charges (e.g., Net 30, Net 45).',
    `performance_tier` STRING COMMENT 'Performance classification based on On-Time In-Full (OTIF) delivery, claims ratio, and service quality metrics. Determines load allocation priority.. Valid values are `platinum|gold|silver|bronze|probationary`',
    `preferred_carrier_flag` BOOLEAN COMMENT 'Indicates whether the carrier is designated as a preferred partner with priority load allocation and strategic relationship status.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary carrier contact for operational communications and load coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the carrier organization for operational coordination and issue escalation.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary carrier contact for urgent operational issues and load coordination.',
    `safety_rating` STRING COMMENT 'Federal Motor Carrier Safety Administration safety rating based on compliance review. Satisfactory rating required for carrier approval.. Valid values are `satisfactory|conditional|unsatisfactory|not_rated`',
    `scac_code` STRING COMMENT 'Four-letter unique identifier assigned by the National Motor Freight Traffic Association (NMFTA) for transportation companies. Used in EDI transactions and shipping documentation.. Valid values are `^[A-Z]{2,4}$`',
    `service_coverage_region` STRING COMMENT 'Geographic regions where the carrier provides transportation services. Free-text description of coverage area (e.g., US Midwest, Eastern Seaboard, National).',
    `service_mode` STRING COMMENT 'Primary mode of transportation service offered by the carrier. Defines equipment type and service level capability. [ENUM-REF-CANDIDATE: truckload|less_than_truckload|parcel|intermodal|refrigerated|dry_van|flatbed|tanker — 8 candidates stripped; promote to reference product]',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius that the carriers refrigerated equipment can maintain. Critical for chilled food distribution.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius that the carriers refrigerated equipment can maintain. Critical for frozen food distribution.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record for all transportation carriers (TL, LTL, parcel, refrigerated, DSD fleet) used in outbound distribution. Captures SCAC code, DOT/MC number, carrier type, service modes, insurance certificates, FSMA Sanitary Transportation compliance status, cold chain capability flags, EDI capability, contracted rate tier, and performance tier classification. SSOT for carrier identity in the distribution domain.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`delivery_route` (
    `delivery_route_id` BIGINT COMMENT 'Unique identifier for the delivery route. Primary key for the delivery route entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to distribution.carrier. Business justification: A delivery route (especially DSD routes) is executed by a specific carrier or fleet. delivery_route has vehicle_type_required and cold_chain_required attributes but no FK to the carrier master. Adding',
    `center_id` BIGINT COMMENT 'Reference to the distribution center or warehouse that serves as the origin point for this route. All deliveries on this route originate from this DC.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: In F&B DSD operations, each delivery route is assigned a cost center for route profitability analysis — driver wages, fuel, and vehicle costs are allocated by route. Finance uses this for cost-per-sto',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: Route planning aligns to geographic markets for ACV distribution tracking and market penetration reporting. F&B distribution planners and brand teams jointly review route coverage by market during new',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: In F&B pre-sell DSD operations, delivery routes are coordinated with assigned sales reps who pre-sell the route stops. Linking route to rep enables rep-level route performance reporting, commission ca',
    `territory_id` BIGINT COMMENT 'Reference to the sales or distribution territory to which this route is assigned. Used for territory management and sales alignment.',
    `actual_mileage` DECIMAL(18,2) COMMENT 'Actual total mileage driven during route execution, captured from vehicle telematics or odometer readings. Used for cost analysis and route optimization.',
    `cases_delivered` STRING COMMENT 'Total number of product cases successfully delivered to customers during route execution. Used for fill rate calculation and revenue recognition.',
    `cases_loaded` STRING COMMENT 'Total number of product cases loaded onto the vehicle at route start. Used for inventory reconciliation and load planning analysis.',
    `cases_refused` STRING COMMENT 'Total number of product cases refused by customers during delivery due to quality issues, order discrepancies, or receiving problems. Subset of cases_returned.',
    `cases_returned` STRING COMMENT 'Total number of product cases returned to the distribution center undelivered. Includes unsold inventory from DSD routes and refused deliveries.',
    `cash_collected` DECIMAL(18,2) COMMENT 'Total cash payments collected from customers during route execution. Applicable primarily to DSD routes with cash-on-delivery transactions. Used for cash reconciliation.',
    `check_collected` DECIMAL(18,2) COMMENT 'Total check payments collected from customers during route execution. Applicable primarily to DSD routes. Used for accounts receivable reconciliation.',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this route requires temperature-controlled (refrigerated or frozen) transportation to maintain product quality and food safety compliance. True if any stop requires cold chain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when this route master definition became active and available for scheduling. Used for route lifecycle management and historical analysis.',
    `end_time` TIMESTAMP COMMENT 'Actual timestamp when the driver returned to the distribution center and completed route execution. Used for route duration analysis and driver shift management.',
    `estimated_duration_minutes` STRING COMMENT 'Planned total duration for route completion in minutes, including drive time, stop time, and loading/unloading. Used for driver scheduling and shift planning.',
    `estimated_mileage` DECIMAL(18,2) COMMENT 'Planned total mileage for the route in miles, based on stop sequence and routing optimization. Used for cost estimation and vehicle assignment.',
    `execution_date` DATE COMMENT 'The specific date on which this route instance was executed. For route execution records, this is the primary business event date. For route master records, this field may be null.',
    `expiration_date` DATE COMMENT 'Date when this route master definition is scheduled to be retired or replaced. Null for routes with no planned end date. Used for route lifecycle management.',
    `fill_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of ordered cases that were successfully delivered on this route. Calculated as (cases_delivered / cases_loaded) * 100. Key metric for order fulfillment performance.',
    `frequency` STRING COMMENT 'Scheduled frequency at which this route is executed. DAILY for every business day, WEEKLY for once per week, BIWEEKLY for every two weeks, MONTHLY for once per month, ON_DEMAND for ad-hoc execution.. Valid values are `DAILY|WEEKLY|BIWEEKLY|MONTHLY|ON_DEMAND`',
    `fuel_consumed_gallons` DECIMAL(18,2) COMMENT 'Total fuel consumed during route execution in gallons. Captured from vehicle telematics or fuel card transactions. Used for cost allocation and sustainability reporting.',
    `handheld_device_code` STRING COMMENT 'Identifier of the mobile handheld device (scanner, tablet, or mobile computer) used by the driver for proof of delivery, order capture, and route tracking.',
    `hazmat_required` BOOLEAN COMMENT 'Indicates whether this route transports hazardous materials requiring special handling, placarding, and driver certification per DOT regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was last updated. Used for audit trail and change tracking.',
    `otif_performance_pct` DECIMAL(18,2) COMMENT 'Percentage of deliveries on this route that met both on-time and in-full criteria. Key performance indicator for distribution service level. Calculated as (on-time and in-full deliveries / total planned deliveries) * 100.',
    `route_code` STRING COMMENT 'Business identifier for the route, used for operational reference and scheduling. Typically alphanumeric code assigned by transportation management system.. Valid values are `^[A-Z0-9]{6,12}$`',
    `route_completion_status` STRING COMMENT 'Overall completion status of the route execution instance. COMPLETED indicates all planned stops were attempted, PARTIAL indicates some stops were skipped, CANCELLED indicates route was aborted, IN_PROGRESS indicates route is currently being executed, NOT_STARTED indicates route has not yet begun.. Valid values are `COMPLETED|PARTIAL|CANCELLED|IN_PROGRESS|NOT_STARTED`',
    `route_name` STRING COMMENT 'Human-readable name or description of the route, often including geographic or customer references (e.g., Downtown Chicago Loop, Northeast Territory A).',
    `route_status` STRING COMMENT 'Current lifecycle status of the route template. ACTIVE routes are in regular operation, INACTIVE are temporarily not in use, SUSPENDED are on hold pending review, PLANNED are designed but not yet operational, RETIRED are permanently discontinued.. Valid values are `ACTIVE|INACTIVE|SUSPENDED|PLANNED|RETIRED`',
    `route_type` STRING COMMENT 'Classification of the route based on delivery model. DSD (Direct Store Delivery) for direct-to-retail routes, DC_TO_RETAIL for distribution center to retail, FOODSERVICE for restaurant/institutional delivery, DTC for direct-to-consumer, CROSS_DOCK for cross-docking operations, BACKHAUL for return logistics.. Valid values are `DSD|DC_TO_RETAIL|FOODSERVICE|DTC|CROSS_DOCK|BACKHAUL`',
    `scheduled_days_of_week` STRING COMMENT 'Comma-separated list of days when route is scheduled to run (e.g., MON,WED,FRI). Applicable for WEEKLY and BIWEEKLY frequency routes.',
    `start_time` TIMESTAMP COMMENT 'Actual timestamp when the driver departed the distribution center to begin route execution. Used for OTIF (On Time In Full) performance tracking.',
    `stop_count` STRING COMMENT 'Number of planned delivery stops on this route. Used for route complexity assessment and driver workload planning.',
    `stops_completed` STRING COMMENT 'Number of delivery stops successfully completed during this route execution. Used to calculate route completion rate and identify service failures.',
    `stops_planned` STRING COMMENT 'Number of delivery stops planned for this route execution instance. Used to calculate route completion rate.',
    `temperature_range_max_f` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Fahrenheit for cold chain routes. Used for temperature monitoring and compliance verification. Null for non-cold-chain routes.',
    `temperature_range_min_f` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Fahrenheit for cold chain routes. Used for temperature monitoring and compliance verification. Null for non-cold-chain routes.',
    `vehicle_type_required` STRING COMMENT 'Type of vehicle required to execute this route based on cargo volume, weight, and special handling requirements. Determines vehicle assignment from fleet.. Valid values are `STRAIGHT_TRUCK|TRACTOR_TRAILER|REFRIGERATED_TRUCK|BOX_TRUCK|SPRINTER_VAN|CARGO_VAN`',
    CONSTRAINT pk_delivery_route PRIMARY KEY(`delivery_route_id`)
) COMMENT 'Master definition and execution record for recurring outbound delivery routes used in DSD (Direct Store Delivery) and DC-to-customer distribution. Master attributes (relatively static, updated infrequently): route code, route type (DSD, DC-to-retail, foodservice, DTC), assigned territory, stop sequence template, estimated mileage, frequency, vehicle type requirement, cold chain requirement, and active status. Execution attributes (one record per route-day execution instance): execution date, driver, vehicle, start/end times, stops planned vs completed, cases loaded/delivered/returned/refused, cash/check collections, handheld device ID, and route completion status. The master portion defines the route template; execution instances capture daily operational performance against that template. SSOT for all route definition and route execution data in the distribution domain, including DSD operational performance. Supports route optimization, driver assignment, territory management, and DSD operational reporting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` (
    `fulfillment_order_id` BIGINT COMMENT 'Unique identifier for the fulfillment order record. Primary key for the fulfillment order entity representing a customer order released to the distribution center for picking, packing, and shipping.',
    `account_id` BIGINT COMMENT 'Reference to the customer account receiving this fulfillment. Identifies the buyer or consignee for the order.',
    `bill_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.bill_to_location. Business justification: Order-to-invoice matching in F&B requires linking fulfillment orders to the bill-to entity at order creation. Retail chains use centralized billing (bill-to differs from ship-to). Enables invoice gene',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Order attribution to marketing campaigns is required for sales‑to‑campaign performance reporting.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier or third-party logistics (3PL) provider assigned to transport this order. Used for carrier performance tracking and freight cost allocation.',
    `center_id` BIGINT COMMENT 'Reference to the distribution center or warehouse facility responsible for fulfilling this order. Identifies the source location for inventory picking and shipping operations.',
    `delivery_route_id` BIGINT COMMENT 'Identifier for the delivery route to which this fulfillment order has been assigned. Used for Direct Store Delivery (DSD) route optimization and last-mile logistics planning.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Traceability report links each fulfillment order to the production order that created the shipped product.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Assigns revenue from each fulfillment order to a profit center for profitability analysis and reporting.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: In F&B trade execution, fulfillment orders are generated to support specific promotional events (incremental display stock, feature shipments). Linking enables OTIF measurement against promotional com',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: Fulfillment orders must comply with retailer agreement service level commitments (OTIF targets, fill rate thresholds, delivery windows). Direct FK enables agreement-level compliance tracking at the fu',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order that triggered this fulfillment order. Links the distribution execution back to the commercial transaction.',
    `ship_to_location_id` BIGINT COMMENT 'Reference to the destination location where goods will be delivered. May represent a retail store, distribution center, foodservice location, or direct-to-consumer address.',
    `shipment_id` BIGINT COMMENT 'Identifier for the consolidated shipment that includes this fulfillment order. Multiple orders may be combined into a single shipment for transportation efficiency.',
    `store_id` BIGINT COMMENT 'Foreign key linking to sales.store. Business justification: Fulfillment orders in F&B retail replenishment are destined for specific stores. Store-level fill rate and OTIF reporting requires linking fulfillment orders to stores. The existing ship_to_location_i',
    `actual_delivery_date` DATE COMMENT 'The actual date the order was delivered to the customer location. Captured from proof of delivery (POD) or carrier tracking systems. Used for OTIF performance measurement.',
    `actual_ship_date` DATE COMMENT 'The actual date the order shipped from the distribution center. Used for OTIF performance measurement and variance analysis against planned and requested dates.',
    `asn_number` STRING COMMENT 'Advanced Shipping Notice document number transmitted to the customer via Electronic Data Interchange (EDI) prior to shipment arrival. Enables customer receiving preparation and inventory planning.',
    `asn_sent_timestamp` TIMESTAMP COMMENT 'The date and time the Advanced Shipping Notice was transmitted to the customer. Used for EDI compliance tracking and customer service level measurement.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether this fulfillment order contains temperature-sensitive products requiring cold chain compliance throughout storage and transportation. True indicates refrigerated or frozen handling required; false indicates ambient temperature handling.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this fulfillment order record was first created in the system. Used for audit trail and data lineage tracking.',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether this fulfillment order is designated for cross-docking operations, where goods move directly from receiving to shipping without intermediate storage. True indicates cross-dock handling; false indicates standard warehouse flow with putaway and storage.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The precise date and time the order was delivered to the customer. Captured from proof of delivery or carrier tracking. Used for OTIF measurement and service level compliance.',
    `exception_code` STRING COMMENT 'Code identifying the type of exception or disruption encountered during fulfillment execution. Examples include inventory shortage, damaged product, carrier delay, address error, or customer request change. Used for root cause analysis and process improvement.',
    `exception_description` STRING COMMENT 'Detailed description of the exception or disruption encountered during fulfillment. Provides context for resolution actions and root cause investigation.',
    `exception_resolution_status` STRING COMMENT 'Current status of exception resolution efforts. Open indicates exception has been identified but not yet addressed; in_progress indicates resolution actions are underway; resolved indicates exception has been successfully resolved; escalated indicates exception requires management intervention.. Valid values are `open|in_progress|resolved|escalated`',
    `fill_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of the order quantity that was successfully fulfilled and shipped. Calculated as shipped quantity divided by ordered quantity. Used for service level measurement and inventory availability analysis.',
    `fulfillment_channel` STRING COMMENT 'The business channel through which this order is being fulfilled. Determines handling requirements, service level expectations, and routing logic. Retail represents traditional grocery and mass merchandiser channels; foodservice represents restaurant and institutional channels; direct-to-consumer (DTC) represents online orders shipped to individual consumers; direct store delivery (DSD) represents orders delivered directly to retail stores bypassing DC consolidation.. Valid values are `retail|foodservice|direct_to_consumer|direct_store_delivery|ecommerce|wholesale`',
    `fulfillment_order_number` STRING COMMENT 'Business-readable unique identifier for the fulfillment order. Used for operational tracking, communication with warehouse staff, and customer service inquiries.',
    `fulfillment_status` STRING COMMENT 'Current lifecycle status of the fulfillment order within the distribution execution process. Released indicates order is available for wave assignment; wave_assigned indicates order is assigned to a picking wave; picking indicates order is actively being picked; picked indicates picking is complete; packing indicates order is being packed; packed indicates packing is complete; staged indicates order is staged for loading; loaded indicates order is loaded on carrier vehicle; shipped indicates order has departed the DC; in_transit indicates order is en route to destination; delivered indicates order has been received by customer; exception indicates order has encountered a problem requiring intervention; cancelled indicates order has been cancelled. [ENUM-REF-CANDIDATE: released|wave_assigned|picking|picked|packing|packed|staged|loaded|shipped|in_transit|delivered|exception|cancelled — 13 candidates stripped; promote to reference product]',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this fulfillment order contains hazardous materials requiring special handling, labeling, and transportation compliance. True indicates hazmat present; false indicates no hazmat.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time this fulfillment order record was last updated. Used for change tracking and data synchronization.',
    `order_release_timestamp` TIMESTAMP COMMENT 'The date and time the fulfillment order was released from the order management system to the warehouse management system for execution. Marks the start of the fulfillment lifecycle.',
    `order_type` STRING COMMENT 'Classification of the fulfillment order based on handling and processing requirements. Standard represents normal replenishment orders; rush represents expedited orders requiring priority handling; cross-dock represents orders that bypass storage and move directly from receiving to shipping; drop-ship represents orders shipped directly from supplier to customer; sample represents non-commercial product samples; promotional represents orders tied to marketing campaigns or trade promotions.. Valid values are `standard|rush|cross_dock|drop_ship|sample|promotional`',
    `otif_target_flag` BOOLEAN COMMENT 'Indicates whether this fulfillment order is included in On-Time In-Full performance measurement. True indicates order is subject to OTIF service level agreements; false indicates order is excluded from OTIF metrics (e.g., sample orders, internal transfers).',
    `picking_complete_timestamp` TIMESTAMP COMMENT 'The date and time when all picking operations were completed for this fulfillment order. Used for cycle time analysis and throughput measurement.',
    `picking_start_timestamp` TIMESTAMP COMMENT 'The date and time when picking operations began for this fulfillment order. Used for cycle time analysis and warehouse productivity measurement.',
    `planned_ship_date` DATE COMMENT 'The date the distribution center plans to ship the order based on capacity, inventory availability, and carrier schedules. May differ from requested ship date due to operational constraints.',
    `priority_code` STRING COMMENT 'Priority level assigned to the fulfillment order for warehouse resource allocation and sequencing. Critical represents emergency orders requiring immediate processing; high represents time-sensitive orders with tight delivery windows; normal represents standard priority orders; low represents orders that can be delayed if capacity constraints exist.. Valid values are `critical|high|normal|low`',
    `promised_delivery_date` DATE COMMENT 'The date committed to the customer for delivery of the order. Used for On-Time In-Full (OTIF) performance measurement and customer service level tracking.',
    `requested_ship_date` DATE COMMENT 'The date the customer or sales order requested the order to ship from the distribution center. Used for planning and scheduling warehouse operations.',
    `ship_timestamp` TIMESTAMP COMMENT 'The precise date and time the order departed the distribution center. Used for transit time calculation and carrier performance tracking.',
    `total_order_cases` STRING COMMENT 'The total number of cases or cartons in the fulfillment order. Used for warehouse productivity measurement, handling cost allocation, and load planning.',
    `total_order_lines` STRING COMMENT 'The total number of distinct line items or SKUs in the fulfillment order. Used for picking complexity assessment and labor planning.',
    `total_order_pallets` DECIMAL(18,2) COMMENT 'The total number of pallets in the fulfillment order, including partial pallets expressed as decimal values. Used for transportation planning, dock scheduling, and freight cost calculation.',
    `total_order_volume_m3` DECIMAL(18,2) COMMENT 'The total cubic volume of the fulfillment order in cubic meters. Used for warehouse space planning, vehicle capacity utilization, and freight cost calculation.',
    `total_order_weight_kg` DECIMAL(18,2) COMMENT 'The total gross weight of the fulfillment order in kilograms, including product and packaging. Used for carrier selection, freight cost calculation, and load planning.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for shipment visibility and proof of delivery. Used for customer service inquiries and delivery status monitoring.',
    CONSTRAINT pk_fulfillment_order PRIMARY KEY(`fulfillment_order_id`)
) COMMENT 'Core outbound fulfillment order record representing a customer order released to the DC for picking, packing, and shipping. Captures fulfillment order number, source sales order reference, customer account, ship-to location, requested ship date, promised delivery date, fulfillment channel (retail, foodservice, DTC, DSD), order priority, wave/batch assignment, cross-dock flag, fulfillment status (released, wave-assigned, picking, packed, staged, shipped, delivered, exception), OTIF target flag, total order weight/cube, and any exception/disruption codes with resolution status. SSOT for outbound order execution lifecycle in the distribution domain.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` (
    `fulfillment_order_line_id` BIGINT COMMENT 'Unique identifier for the fulfillment order line item. Primary key for this entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: FSMA lot traceability requires knowing which manufacturing batch was picked for each fulfillment order line. Enables recall execution, regulatory reporting, and shelf-life/FEFO compliance at the order',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order header. Links this line to its parent order document.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: In F&B revenue recognition, each fulfillment order line maps to a GL account for product category revenue and COGS posting. Supports ASC 606 line-level revenue recognition and accurate P&L reporting b',
    `lot_id` BIGINT COMMENT 'Foreign key linking to ingredient.lot. Business justification: Recall Management Process: order lines need the exact ingredient lot to enable precise product recalls.',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.packaging_spec. Business justification: Warehouse pick/pack/ship process: packaging_spec defines units_per_case, pallet_ti_hi, cases_per_layer, and gross_weight_g used to calculate carton_count, pallet builds, and cube/weight on each fulfil',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Line‑level traceability ties each order line to the specific production order that produced the SKU.',
    `promotion_line_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_line. Business justification: Each order line may be driven by a specific promotion line; linking enables accurate promotion ROI and claim reconciliation.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: During a product recall, fulfillment order lines containing affected SKUs and lot numbers must be identified, quarantined, and reported. FSMA recall traceability requirements mandate linking shipped l',
    `shelf_life_spec_id` BIGINT COMMENT 'Foreign key linking to product.shelf_life_spec. Business justification: FEFO picking and retailer MRSL compliance: shelf_life_spec defines mrsl_days, dc_receiving_standard, and rotation_rule that govern which lot is picked for each order line. Retailer chargebacks for sho',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: Partial shipments require linking each line to the shipment it was shipped on; many lines per shipment, each line may appear on multiple shipments, so child side gets FK.',
    `sku_id` BIGINT COMMENT 'Reference to the master product record. Links this line to the product master data for detailed product attributes.',
    `allocated_timestamp` TIMESTAMP COMMENT 'Date and time when inventory was allocated to this line. Marks the beginning of the fulfillment process.',
    `backorder_flag` BOOLEAN COMMENT 'Indicates whether unfulfilled quantity from this line was placed on backorder for future fulfillment. Used for backorder management and customer service.',
    `carton_count` STRING COMMENT 'Number of cartons or cases used to fulfill this line. Used for packaging and freight calculation.',
    `catch_weight_actual` DECIMAL(18,2) COMMENT 'Actual weight for catch-weight items where weight varies by unit. Used for variable-weight products like fresh produce, meat, or cheese.',
    `catch_weight_uom` STRING COMMENT 'Unit of measure for catch weight. Defines whether weight is expressed in pounds, kilograms, ounces, or grams.. Valid values are `lb|kg|oz|g`',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU confirmed for fulfillment and actually picked. May differ from ordered quantity due to inventory availability or allocation rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fulfillment order line record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the line amount. Supports multi-currency operations for international distribution.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'Product expiration or best-by date for the lot being fulfilled. Used for FEFO picking logic and shelf life management.',
    `fefo_pick_flag` BOOLEAN COMMENT 'Indicates whether this line was picked using FEFO logic to ensure oldest expiration dates are shipped first. Critical for perishable food and beverage products.',
    `gtin` STRING COMMENT 'Global trade item number (UPC/EAN) for the product. Standardized identifier used across the supply chain for product identification.. Valid values are `^[0-9]{8,14}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the product is classified as hazardous material requiring special handling and shipping compliance. Relevant for certain cleaning chemicals or alcohol products.',
    `line_number` STRING COMMENT 'Sequential line number within the fulfillment order. Determines the ordering and position of this line item in the order.',
    `line_status` STRING COMMENT 'Current fulfillment status of the order line. Tracks the line through the warehouse execution lifecycle from allocation to shipment. [ENUM-REF-CANDIDATE: pending|allocated|picked|packed|shipped|cancelled|short_shipped — 7 candidates stripped; promote to reference product]',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value for this line (quantity × unit price). Used for order value calculation and financial reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fulfillment order line record was last modified. Used for change tracking and audit purposes.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU originally ordered by the customer. Represents the requested amount before any adjustments or shortages.',
    `original_sku` STRING COMMENT 'Original SKU that was ordered if a substitution was made. Null if no substitution occurred.. Valid values are `^[A-Z0-9]{6,20}$`',
    `packed_timestamp` TIMESTAMP COMMENT 'Date and time when the line was packed for shipment. Used for packing efficiency and order completion tracking.',
    `pick_zone` STRING COMMENT 'Warehouse zone or area where the product was picked. Used for labor planning and zone-based picking strategies.',
    `picked_timestamp` TIMESTAMP COMMENT 'Date and time when the line was physically picked from warehouse inventory. Used for pick productivity and cycle time analysis.',
    `production_date` DATE COMMENT 'Date the product was manufactured or packaged. Used for shelf life calculation and quality tracking.',
    `promotion_code` STRING COMMENT 'Trade promotion or discount code applied to this line. Used for TPM tracking and promotional effectiveness analysis.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `quality_inspection_flag` BOOLEAN COMMENT 'Indicates whether this line underwent quality inspection before shipment. Used for quality assurance and food safety compliance.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items. Used for high-value products requiring individual unit tracking.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU shipped to the customer. Final quantity that left the distribution center.',
    `shipped_timestamp` TIMESTAMP COMMENT 'Date and time when the line was shipped from the distribution center. Used for OTIF calculation and ASN generation.',
    `short_ship_reason_code` STRING COMMENT 'Reason code explaining why the line was short-shipped or not fully fulfilled. Used for fill rate analysis and root cause investigation.. Valid values are `out_of_stock|damaged_inventory|allocation_rule|customer_request|quality_hold|expired_product`',
    `sku` STRING COMMENT 'Internal stock keeping unit code identifying the specific product variant being fulfilled. Used for inventory tracking and warehouse operations.. Valid values are `^[A-Z0-9]{6,20}$`',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether a product substitution was made for this line due to stockout or customer approval. Used for substitution rate tracking.',
    `temperature_zone` STRING COMMENT 'Required temperature zone for the product. Critical for cold chain compliance and proper storage of perishable food and beverage items.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit for this line item. Used for invoice generation and revenue recognition.',
    `uom` STRING COMMENT 'Unit of measure for the line quantity. Defines whether quantities are expressed in cases, eaches, pallets, or other packaging units.. Valid values are `case|each|pallet|layer|inner_pack|display_unit`',
    `warehouse_location` STRING COMMENT 'Specific warehouse bin or location from which the product was picked. Used for inventory accuracy and slotting optimization.. Valid values are `^[A-Z0-9-]{3,20}$`',
    CONSTRAINT pk_fulfillment_order_line PRIMARY KEY(`fulfillment_order_line_id`)
) COMMENT 'Line-level detail for each SKU within a fulfillment order. Captures line number, SKU/GTIN, ordered quantity (cases/eaches), confirmed quantity, UOM, lot number, expiration date, FEFO pick flag, catch-weight actual, line status, and any short-ship reason code. Enables lot traceability and FEFO compliance at the line level.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the physical shipment record. Primary key for the shipment entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Retailer OTIF compliance programs and chargeback management require linking shipments directly to the customer account (the contractual party), not just the ship-to location. Enables account-level shi',
    `bill_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.bill_to_location. Business justification: Freight billing and chargeback reconciliation in F&B require each shipment to reference the bill-to entity directly. Retail chains centralize billing (HQ bill-to differs from store ship-to). Enables a',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand KPI report requires each shipment linked to its primary brand for on‑time‑in‑full and cost analysis.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaign fulfillment tracking needs to tie shipments generated by a specific marketing campaign to measure lift and ROI.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for moving the shipment.',
    `center_id` BIGINT COMMENT 'Identifier of the distribution center or warehouse from which the shipment originates.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for freight cost allocation to internal cost centers for accurate expense reporting per shipment.',
    `delivery_route_id` BIGINT COMMENT 'Identifier of the delivery route or multi-stop tour that this shipment is part of, used for route optimization and DSD operations.',
    `edi_trading_partner_id` BIGINT COMMENT 'Foreign key linking to customer.edi_trading_partner. Business justification: Each shipment triggers an ASN (EDI 856 transaction) routed to the customers EDI trading partner. Shipment already tracks asn_sent_flag and asn_sent_datetime; direct FK to edi_trading_partner enables ',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: FDA requires food shipments to originate from registered establishments (21 CFR Part 1). Linking shipment to establishment_registration enables FSMA compliance verification and regulatory audit trails',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Needed to post freight expense of each shipment to the appropriate GL account for financial statements.',
    `import_export_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.import_export_permit. Business justification: International shipments require an active import/export permit for customs clearance and FDA prior notice compliance. FSMA and CBP regulations mandate linking each cross-border shipment to its governi',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: Market-level shipment volume, freight cost, and OTIF reporting is a standard F&B supply chain KPI used jointly by distribution and brand/marketing teams. No existing FK on shipment points to market; s',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Logistics planning requires knowing the originating plant for each shipment.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Inbound supplier shipments arriving at DCs must be matched to purchase orders for FSMA traceability, three-way match (PO/shipment/invoice), and inbound logistics planning. F&B supply chain teams routi',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: Recall coordinators must identify all shipments containing recalled product for interception or retrieval. Linking shipment to recall_event enables distribution scope analysis, carrier notification, a',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: Compliance reporting requires each shipment to be linked to the retailer agreement governing delivery windows, fees, and penalties.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Required for Shipment‑Order reconciliation report used in OTIF compliance; each shipment must be tied to the originating sales order.',
    `location_id` BIGINT COMMENT 'Foreign key linking to distribution.location. Business justification: The domain description for the location product explicitly states it is Referenced by ship_from_location_id, confirming this FK is intentionally designed. shipment already has ship_to_location_id → ',
    `ship_to_location_id` BIGINT COMMENT 'Identifier of the destination location (customer site, retail store, or receiving facility) for the shipment.',
    `store_id` BIGINT COMMENT 'Foreign key linking to sales.store. Business justification: Store-level shipment tracking is fundamental to F&B retail execution and DSD compliance reporting. Retailers require store-level ASN and delivery confirmation. The existing ship_to_location_id (custom',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Inbound receipt of goods from a supplier to a distribution center is tracked in shipments for inventory, quality, and compliance reporting.',
    `actual_delivery_datetime` TIMESTAMP COMMENT 'Actual date and time when the shipment was delivered to the destination location, used for OTIF and SLA compliance tracking.',
    `actual_pickup_datetime` TIMESTAMP COMMENT 'Actual date and time when the carrier picked up the shipment from the origin DC, used for OTIF performance tracking.',
    `asn_sent_datetime` TIMESTAMP COMMENT 'Date and time when the ASN was transmitted to the customer, used for EDI compliance and customer notification tracking.',
    `asn_sent_flag` BOOLEAN COMMENT 'Indicates whether an EDI 856 Advanced Shipping Notice has been transmitted to the customer or receiving facility.',
    `case_count` STRING COMMENT 'Total number of cases or cartons included in the shipment across all pallets.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment record was first created in the WMS or TMS system.',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether this shipment was processed through a cross-docking operation without long-term storage at the DC.',
    `delivery_exception_code` STRING COMMENT 'Code indicating any delivery exception or issue encountered during shipment (e.g., damaged product, refused delivery, address error, weather delay).',
    `delivery_exception_notes` STRING COMMENT 'Free-text notes describing any delivery exceptions, issues, or special circumstances encountered during shipment execution.',
    `dsd_route_flag` BOOLEAN COMMENT 'Indicates whether this shipment is part of a DSD route where products are delivered directly to retail stores, bypassing retailer DCs.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost charged by the carrier for this shipment, used for freight spend analysis and accrual.',
    `freight_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight cost amount.. Valid values are `^[A-Z]{3}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling, labeling, and carrier certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment record was last updated, used for change tracking and data synchronization.',
    `loading_sequence` STRING COMMENT 'Instructions or sequence identifier for how pallets should be loaded into the trailer to optimize delivery route and unloading efficiency.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in Celsius for the shipment to maintain product quality and safety during transit.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in Celsius for the shipment to maintain product quality and safety during transit.',
    `otif_compliant_flag` BOOLEAN COMMENT 'Indicates whether the shipment met OTIF performance criteria (delivered on time and with complete order quantity), a key supply chain KPI.',
    `pallet_count` STRING COMMENT 'Total number of pallets or handling units included in the shipment.',
    `pod_signature_name` STRING COMMENT 'Name of the person who signed for the delivery at the destination location, captured as part of proof of delivery.',
    `pod_timestamp` TIMESTAMP COMMENT 'Date and time when the proof of delivery was captured, typically matching or closely following the actual delivery datetime.',
    `proof_of_delivery_received_flag` BOOLEAN COMMENT 'Indicates whether proof of delivery documentation (signature, photo, or electronic confirmation) has been received from the carrier or customer.',
    `scheduled_delivery_datetime` TIMESTAMP COMMENT 'Planned date and time when the shipment is scheduled to arrive at the destination location.',
    `scheduled_pickup_datetime` TIMESTAMP COMMENT 'Planned date and time when the carrier is scheduled to pick up the shipment from the origin DC.',
    `seal_number` STRING COMMENT 'Security seal number applied to the trailer or container to ensure tamper-evidence and cargo integrity during transit.',
    `service_level` STRING COMMENT 'The transportation service level or speed tier selected for this shipment (e.g., standard ground, expedited, next-day).. Valid values are `standard|expedited|next_day|two_day|same_day|economy`',
    `shipment_number` STRING COMMENT 'Externally-known business identifier for the shipment, used for tracking and communication with carriers and customers.. Valid values are `^SHP[0-9]{10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment in the outbound logistics workflow.. Valid values are `planned|ready_to_ship|in_transit|delivered|cancelled|on_hold`',
    `stop_sequence` STRING COMMENT 'The sequence number of this delivery stop within the overall route, used for route planning and driver instructions.',
    `temperature_requirement` STRING COMMENT 'Temperature control requirement for the shipment to maintain cold chain compliance and product quality (ambient, refrigerated, frozen, or controlled).. Valid values are `ambient|refrigerated|frozen|controlled`',
    `temperature_zone_segregation_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains products requiring segregation into multiple temperature zones within the same trailer.',
    `third_party_logistics_flag` BOOLEAN COMMENT 'Indicates whether this shipment was fulfilled by a third-party logistics provider rather than a company-owned distribution center.',
    `total_cube_m3` DECIMAL(18,2) COMMENT 'Total volumetric cube of the shipment in cubic meters, used for load planning and carrier billing.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms, including product, packaging, and pallets.',
    `trailer_number` STRING COMMENT 'The trailer, container, or vehicle identification number assigned to this shipment for physical transport.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of trailer or container capacity utilized by this shipment, calculated based on weight or cube constraints.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Physical shipment record consolidating one or more fulfillment orders onto a single carrier move, including load configuration details. Captures shipment number, carrier, service level, trailer/container number, seal number, origin DC, destination, scheduled/actual pickup and delivery datetimes, total weight, total cube, pallet count, utilization percentage, loading sequence, freight cost, temperature requirement (ambient/refrigerated/frozen), temperature zone segregation, and shipment status. Supports outbound logistics execution, carrier performance tracking, freight cost management, and cold chain compliance documentation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` (
    `proof_of_delivery_id` BIGINT COMMENT 'Unique identifier for the proof of delivery record.',
    `account_id` BIGINT COMMENT 'Reference to the customer who received the delivery.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: POD is required to clear AR invoices and resolve retailer deductions in F&B O2C. Finance matches PODs to AR invoices to release payment holds, clear open items, and dispute short-payments. Core collec',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or third-party logistics (3PL) provider that executed the delivery.',
    `order_id` BIGINT COMMENT 'Reference to the delivery order fulfilled by this delivery.',
    `delivery_route_id` BIGINT COMMENT 'Reference to the delivery route on which this delivery was executed, used for Direct Store Delivery (DSD) route management.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to sales.invoice. Business justification: POD confirmation triggers invoice release for payment in F&B AR processes. The proof_of_delivery has an invoice_matched boolean flag but no FK to the actual invoice record. Accounts receivable teams m',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: POD records are primary supporting documentation for promotional compliance validation and deduction dispute resolution in F&B. Retailers submit deductions based on promotional delivery compliance; PO',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: POD records validate delivery compliance against retailer agreement terms (delivery condition requirements, time window commitments, penalty thresholds). Direct FK enables automated agreement complian',
    `ship_to_location_id` BIGINT COMMENT 'Reference to the specific delivery location (store, warehouse, distribution center) where goods were received.',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment that this proof of delivery confirms.',
    `store_id` BIGINT COMMENT 'Foreign key linking to sales.store. Business justification: In F&B DSD operations, PODs are captured at the store level for store-level delivery compliance and retail execution reporting. Linking POD to store enables store-level OTIF, refusal rate, and cold-ch',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the delivery was completed and goods were received, critical for OTIF measurement and invoice matching.',
    `asn_number` STRING COMMENT 'Advanced Shipping Notice number associated with this delivery, used for Electronic Data Interchange (EDI) processing and pre-receipt notification.',
    `cases_delivered_quantity` DECIMAL(18,2) COMMENT 'Actual number of cases successfully delivered and accepted by the receiver, used for fill rate calculation.',
    `cases_ordered_quantity` DECIMAL(18,2) COMMENT 'Total number of cases that were originally ordered and scheduled for delivery.',
    `cases_refused_quantity` DECIMAL(18,2) COMMENT 'Number of cases refused or rejected by the receiver at the time of delivery.',
    `cold_chain_compliant` BOOLEAN COMMENT 'Indicates whether the delivery met cold chain temperature requirements throughout transit and at delivery, ensuring food safety and quality for perishable products.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the proof of delivery record was first created in the system.',
    `delivery_condition_code` STRING COMMENT 'Standardized code indicating the overall condition of the delivered goods at the time of receipt.. Valid values are `good|damaged|partial_damage|temperature_excursion|packaging_issue|acceptable_with_notes`',
    `delivery_condition_notes` STRING COMMENT 'Free-text notes describing the condition of the delivered goods, including any damage, quality concerns, or packaging issues observed at delivery.',
    `delivery_photo_captured` BOOLEAN COMMENT 'Indicates whether photographic evidence of the delivery was captured via mobile device or ePOD system.',
    `delivery_photo_url` STRING COMMENT 'URL or storage path to the delivery photo image file, used for proof of delivery and dispute resolution.',
    `delivery_status` STRING COMMENT 'Current status of the delivery in its lifecycle workflow.. Valid values are `delivered|partially_delivered|refused|failed|in_transit|scheduled`',
    `dispute_raised` BOOLEAN COMMENT 'Indicates whether a delivery dispute has been raised by the customer or carrier regarding this proof of delivery.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate captured at the time of delivery, used for delivery verification and route optimization analytics.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate captured at the time of delivery, used for delivery verification and route optimization analytics.',
    `in_full_flag` BOOLEAN COMMENT 'Indicates whether the full ordered quantity was delivered without shortages, used for fill rate and in-full delivery KPI measurement.',
    `invoice_matched` BOOLEAN COMMENT 'Indicates whether the proof of delivery has been successfully matched to the corresponding invoice for three-way matching (PO, receipt, invoice).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the proof of delivery record was last updated or modified.',
    `on_time_flag` BOOLEAN COMMENT 'Indicates whether the delivery was completed within the scheduled time window, used for on-time delivery KPI measurement.',
    `otif_compliant` BOOLEAN COMMENT 'Indicates whether the delivery met On Time In Full (OTIF) performance criteria: delivered on scheduled date within time window and with full ordered quantity.',
    `pod_capture_method` STRING COMMENT 'Method used to capture the proof of delivery: electronic POD device, paper scan, EDI 214 Transportation Carrier Shipment Status Message, mobile application, or no signature required.. Valid values are `epod|paper_scan|edi_214|mobile_app|no_signature`',
    `pod_number` STRING COMMENT 'Externally-known unique business identifier for the proof of delivery document, used for tracking and dispute resolution.',
    `receiver_name` STRING COMMENT 'Full name of the individual who received and signed for the delivery at the customer location.',
    `receiver_signature_captured` BOOLEAN COMMENT 'Indicates whether a digital or physical signature was captured from the receiver as proof of receipt.',
    `receiver_title` STRING COMMENT 'Job title or role of the individual who received the delivery (e.g., Store Manager, Receiving Clerk, Warehouse Supervisor).',
    `refusal_reason_code` STRING COMMENT 'Standardized code indicating the reason for refusal or rejection of delivered goods. [ENUM-REF-CANDIDATE: damaged|expired|wrong_product|overage|quality_issue|no_order|other — 7 candidates stripped; promote to reference product]',
    `refusal_reason_notes` STRING COMMENT 'Free-text notes providing additional detail about the reason for refusal, used for dispute resolution and quality investigation.',
    `scheduled_delivery_date` DATE COMMENT 'Planned date for the delivery, used for On Time In Full (OTIF) measurement and Service Level Agreement (SLA) tracking.',
    `scheduled_delivery_time_window_end` TIMESTAMP COMMENT 'End of the scheduled delivery time window, used for precise delivery appointment tracking.',
    `scheduled_delivery_time_window_start` TIMESTAMP COMMENT 'Start of the scheduled delivery time window, used for precise delivery appointment tracking.',
    `signature_image_url` STRING COMMENT 'URL or storage path to the digital signature image file captured via electronic Proof of Delivery (ePOD) device.',
    `stop_sequence_number` STRING COMMENT 'Sequential stop number on the delivery route, used for route optimization and last-mile logistics tracking.',
    `temperature_at_delivery_celsius` DECIMAL(18,2) COMMENT 'Recorded temperature of the delivery at the time of receipt, critical for cold chain compliance and food safety verification for refrigerated and frozen products.',
    `temperature_excursion_flag` BOOLEAN COMMENT 'Indicates whether a temperature excursion (deviation from acceptable range) occurred during transit or at delivery, requiring quality review.',
    CONSTRAINT pk_proof_of_delivery PRIMARY KEY(`proof_of_delivery_id`)
) COMMENT 'Electronic or paper Proof of Delivery (POD) record confirming receipt of goods at the customer location. Captures POD number, shipment reference, stop reference, delivery datetime, receiver name, receiver signature (digital), cases received, cases refused, refusal reason, temperature at delivery (cold chain), condition notes, and POD capture method (ePOD, paper scan, EDI 214). Critical for OTIF measurement, dispute resolution, and invoice matching.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` (
    `cold_chain_event_id` BIGINT COMMENT 'Unique identifier for the cold chain monitoring event record.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Cold‑chain compliance monitoring per batch requires linking temperature events to the batch record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Temperature compliance reports are often brand‑specific; linking events to brand enables brand‑wise quality monitoring.',
    `carrier_id` BIGINT COMMENT 'Unique identifier for the transportation carrier responsible for the cold chain asset during transit.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cold chain excursions in F&B trigger product write-offs, disposal costs, and insurance claims posted to cost centers. Finance tracks cold chain compliance costs by cost center for P&L impact, insuranc',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to quality.critical_control_point. Business justification: FSMA Sanitary Transportation and HACCP require cold chain events to be evaluated against defined CCP critical limits (e.g., max temperature thresholds). cold_chain_event.haccp_compliant_flag implies C',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: Cold chain events are monitored as Critical Control Points (CCPs) under HACCP food safety plans. The cold_chain_event has haccp_compliant_flag and fsma_compliant_flag but no link to the governing plan',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Quality disposition after cold chain excursion: cold_chain_event records brix_measurement and ph_measurement that must be compared against formulation targets (target_brix, target_ph_min/max, water_ac',
    `location_id` BIGINT COMMENT 'Foreign key linking to distribution.location. Business justification: cold_chain_event.origin_location_code is a STRING field representing the origin facility of a cold chain event. The location table is the master reference for distribution locations (with location_cod',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Temperature excursion reports must reference the product registration to satisfy FDA and FSMA traceability requirements.',
    `shelf_life_spec_id` BIGINT COMMENT 'Foreign key linking to product.shelf_life_spec. Business justification: FSMA cold chain disposition process: when a temperature excursion occurs, the shelf_life_spec provides storage_temperature_max/min_celsius, temperature_excursion_tolerance_hours, and quality_hold_thre',
    `ship_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.ship_to_location. Business justification: FSMA cold chain compliance requires associating temperature excursion events with the specific customer ship-to location where they occurred. Enables liability determination, regulatory documentation,',
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment or load associated with this cold chain monitoring event.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Cold‑chain monitoring must associate temperature excursions with the specific SKU to satisfy FSMA/HACCP audit and product recall processes.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Cold chain excursions on inbound supplier deliveries must be directly attributed to the responsible supplier for FSMA compliance reporting, HACCP corrective actions, and supplier scorecard deductions.',
    `alert_notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether an automated alert notification was sent to responsible personnel when the excursion was detected (True if sent, False if not sent).',
    `alert_recipient_list` STRING COMMENT 'Comma-separated list of email addresses or user IDs that received the temperature excursion alert notification.',
    `asset_identifier` STRING COMMENT 'Unique identifier or code for the specific cold chain asset (e.g., trailer number, zone code, reefer unit serial number).',
    `asset_type` STRING COMMENT 'Type of cold chain asset being monitored (trailer, distribution center zone, reefer unit, container, warehouse room, or transport vehicle).. Valid values are `trailer|dc_zone|reefer_unit|container|warehouse_room|transport_vehicle`',
    `brix_measurement` DECIMAL(18,2) COMMENT 'Sugar content measurement in degrees Brix if applicable to the product being monitored (primarily for beverages and fruit products).',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective action implemented in response to a temperature excursion or monitoring alert.',
    `corrective_action_timestamp` TIMESTAMP COMMENT 'Date and time when corrective action was initiated in response to the temperature excursion.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cold chain event record was first created in the system.',
    `disposition_status` STRING COMMENT 'Final disposition decision for the product following temperature excursion review (approved for sale, rejected, quarantined, pending review, or destroyed).. Valid values are `approved|rejected|quarantine|pending_review|destroyed`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the temperature monitoring event was recorded in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `excursion_duration_minutes` STRING COMMENT 'Total duration in minutes that the temperature remained outside the acceptable range during the excursion event.',
    `excursion_flag` BOOLEAN COMMENT 'Boolean indicator of whether the recorded temperature exceeded the acceptable range (True if excursion occurred, False if within range).',
    `excursion_severity` STRING COMMENT 'Classification of the temperature excursion severity based on duration and deviation magnitude (minor, moderate, major, or critical).. Valid values are `minor|moderate|major|critical`',
    `fsma_compliant_flag` BOOLEAN COMMENT 'Boolean indicator of whether the cold chain event monitoring and response met FSMA compliance requirements (True if compliant, False if non-compliant).',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the cold chain asset at the time of the temperature reading.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the cold chain asset at the time of the temperature reading.',
    `haccp_compliant_flag` BOOLEAN COMMENT 'Boolean indicator of whether the cold chain event monitoring and response met HACCP critical control point requirements (True if compliant, False if non-compliant).',
    `humidity_percentage` DECIMAL(18,2) COMMENT 'Relative humidity percentage in the cold chain environment if monitored alongside temperature.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the cold chain event record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the cold chain event, excursion circumstances, or corrective actions taken.',
    `ph_measurement` DECIMAL(18,2) COMMENT 'Acidity or alkalinity measurement on the pH scale if applicable to the product being monitored (critical for food safety and quality).',
    `product_category` STRING COMMENT 'High-level category of food or beverage product being transported or stored in the cold chain asset. [ENUM-REF-CANDIDATE: dairy|beverage|frozen|fresh_produce|meat|seafood|prepared_foods — 7 candidates stripped; promote to reference product]',
    `quality_hold_flag` BOOLEAN COMMENT 'Boolean indicator of whether the product was placed on quality hold due to the temperature excursion (True if on hold, False if released).',
    `recorded_temperature_celsius` DECIMAL(18,2) COMMENT 'Actual temperature reading captured by the sensor in degrees Celsius.',
    `recorded_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Actual temperature reading captured by the sensor in degrees Fahrenheit.',
    `regulatory_report_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the temperature excursion severity requires reporting to regulatory authorities such as FDA or USDA (True if reporting required, False if not required).',
    `regulatory_report_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory report was submitted to the appropriate governing body if required.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the cold chain event was reviewed and disposition decision was made.',
    `sensor_code` STRING COMMENT 'Unique identifier for the temperature monitoring sensor or device that captured the reading.',
    `target_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature threshold for the cold chain asset in degrees Celsius.',
    `target_temperature_max_fahrenheit` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature threshold for the cold chain asset in degrees Fahrenheit.',
    `target_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature threshold for the cold chain asset in degrees Celsius.',
    `target_temperature_min_fahrenheit` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature threshold for the cold chain asset in degrees Fahrenheit.',
    CONSTRAINT pk_cold_chain_event PRIMARY KEY(`cold_chain_event_id`)
) COMMENT 'Temperature monitoring event record for cold chain compliance during storage and transit. Captures event datetime, asset type (trailer, DC zone, reefer unit), asset identifier, sensor ID, recorded temperature (°F/°C), target temperature range (min/max), Brix or pH if applicable, excursion flag, excursion duration (minutes), corrective action taken, and FSMA/HACCP compliance status. Critical for food safety regulatory compliance and cold chain SLA management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`otif_record` (
    `otif_record_id` BIGINT COMMENT 'Unique identifier for the OTIF performance measurement record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand‑level OTIF scorecards need a direct link from OTIF records to the brand of the product shipped.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaign-period OTIF dashboards are a named F&B KPI — brand and trade marketing teams measure OTIF performance specifically during promotional campaigns to assess execution quality. No existing FK on ',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier responsible for transporting the shipment.',
    `center_id` BIGINT COMMENT 'Reference to the distribution center that fulfilled the order and is responsible for the OTIF performance.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Retailer OTIF penalty terms are embedded in sales contracts in F&B. OTIF chargebacks are reconciled against the governing sales contract to validate penalty applicability and thresholds. The otif_reco',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OTIF penalties and chargebacks (penalty_fine_amount on otif_record) are posted to cost centers for accountability tracking in F&B. Finance allocates retailer penalty costs to responsible distribution ',
    `account_id` BIGINT COMMENT 'Reference to the customer account for which OTIF performance is being measured.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the fulfillment order that this OTIF record measures performance against.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: OTIF penalty amounts require GL account assignment for financial posting (e.g., customer penalty expense GL). Finance posts retailer chargebacks to specific GL accounts for P&L visibility and trade sp',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: Retailer OTIF compliance programs (e.g., Walmart, Kroger) are market-specific. F&B companies report OTIF scores by market for penalty management and retailer scorecards. otif_record has delivery addre',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Retailer OTIF programs (Walmart, Kroger) issue chargebacks tied to specific sales orders. OTIF analysts reconcile penalty records against originating sales orders for dispute resolution and root-cause',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: F&B retailers impose OTIF penalties specifically during promotional event windows. Linking otif_record to promotion_event enables direct measurement of OTIF performance during trade promotions, drivin',
    `proof_of_delivery_id` BIGINT COMMENT 'Foreign key linking to distribution.proof_of_delivery. Business justification: otif_record.proof_of_delivery_reference is a STRING field that references the POD confirming delivery for OTIF measurement. Replacing it with proof_of_delivery_id (FK → distribution.proof_of_delivery.',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: OTIF records are governed by retailer agreement penalty clauses and OTIF thresholds. Direct FK enables automated penalty calculation, compliance scoring against agreement terms, and retailer scorecard',
    `ship_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.ship_to_location. Business justification: Retailer OTIF programs (Walmart, Kroger, Target) measure compliance at the individual store/DC location level. Direct FK to ship_to_location enables location-level OTIF scorecards, penalty calculation',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: otif_record.shipment_reference is a STRING field that clearly references the physical shipment associated with an OTIF measurement. Replacing it with shipment_id (FK → distribution.shipment.shipment_i',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The actual date and time when the shipment was delivered to the customer location.',
    `asn_number` STRING COMMENT 'The ASN number sent to the customer prior to shipment arrival, used for receiving coordination.',
    `cases_delivered` DECIMAL(18,2) COMMENT 'The actual number of cases delivered to the customer, used to calculate fill rate.',
    `cases_ordered` DECIMAL(18,2) COMMENT 'The total number of cases ordered by the customer in the fulfillment order.',
    `chargeback_reference` STRING COMMENT 'Reference number for the retailer chargeback or deduction associated with this OTIF failure.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this OTIF record was closed after resolution or penalty payment.',
    `committed_delivery_window_end` TIMESTAMP COMMENT 'The end of the delivery time window committed to the customer, used to determine on-time performance.',
    `committed_delivery_window_start` TIMESTAMP COMMENT 'The start of the delivery time window committed to the customer, used to determine on-time performance.',
    `corrective_action_reference` STRING COMMENT 'Reference to the corrective action plan or ticket created to address the root cause and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this OTIF record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_destination_type` STRING COMMENT 'The type of destination location for the delivery (e.g., retail store, distribution center, foodservice, direct-to-consumer).. Valid values are `retail_store|distribution_center|foodservice|direct_to_consumer|cross_dock`',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this OTIF failure has been escalated to senior management due to severity or repeat occurrence.',
    `fill_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of ordered cases that were successfully delivered, calculated as (cases_delivered / cases_ordered) * 100.',
    `in_full_flag` BOOLEAN COMMENT 'Boolean indicator of whether the full ordered quantity was delivered without shortages (True = in-full, False = short).',
    `measurement_date` DATE COMMENT 'The date on which the OTIF performance was measured and recorded.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this OTIF record was last updated with new information (e.g., root cause, corrective action).',
    `on_time_flag` BOOLEAN COMMENT 'Boolean indicator of whether the delivery was completed within the committed time window (True = on-time, False = late).',
    `otif_composite_score` DECIMAL(18,2) COMMENT 'The composite OTIF performance score, typically expressed as a percentage (0-100), representing the combined on-time and in-full achievement.',
    `penalty_fine_amount` DECIMAL(18,2) COMMENT 'The monetary penalty or fine amount assessed by the retailer for OTIF non-compliance.',
    `record_status` STRING COMMENT 'Current lifecycle status of the OTIF record (e.g., created, under investigation, resolved, penalty paid, closed). [ENUM-REF-CANDIDATE: created|under_investigation|root_cause_identified|corrective_action_assigned|resolved|penalty_paid|closed — 7 candidates stripped; promote to reference product]',
    `responsible_party` STRING COMMENT 'The organizational unit or individual responsible for managing this OTIF record and corrective actions.',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the OTIF miss (e.g., carrier delay, DC late release, inventory shortage, weather event). [ENUM-REF-CANDIDATE: carrier_delay|dc_late_release|inventory_short|weather|traffic|equipment_failure|labor_shortage|system_error|other — 9 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis for the OTIF failure.',
    `temperature_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether cold chain temperature requirements were maintained throughout delivery (True = compliant, False = breach).',
    CONSTRAINT pk_otif_record PRIMARY KEY(`otif_record_id`)
) COMMENT 'On-Time In-Full (OTIF) performance measurement record capturing delivery performance against customer-committed windows at the shipment or fulfillment order level. Captures measurement date, customer account, retailer OTIF program (Walmart OTIF, Target In-Stock, Kroger OTD, Costco delivery compliance), shipment reference, fulfillment order reference, committed delivery window, actual delivery datetime, on-time flag, in-full flag, OTIF composite score, cases ordered, cases delivered, fill rate percentage, penalty/fine amount, chargeback reference, root cause code for misses (carrier delay, DC late release, inventory short, weather), and corrective action reference. Each record has an independent lifecycle: created at measurement, updated with root cause and corrective action, closed upon resolution or penalty payment. Supports retailer scorecard compliance, chargeback/penalty management, and continuous improvement programs.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Distribution locations (warehouses, cross-docks, staging areas) handling food products require FDA food facility registration under 21 CFR Part 1. Linking location to establishment_registration enable',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: Distribution locations (DCs, staging, cross-docks) serve defined geographic markets. Brand launch planning and distribution coverage analysis require knowing which market each location serves — a stan',
    `parent_location_id` BIGINT COMMENT 'Self-referencing FK on location (parent_location_id)',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Distribution locations (cross-docks, staging hubs) are aligned to sales territories for network coverage planning and sales-ops coordination in F&B. Enables territory-level distribution footprint repo',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `capacity_sqft` DECIMAL(18,2) COMMENT 'Total usable square‑footage capacity of the facility.',
    `city` STRING COMMENT 'City where the location resides.',
    `close_date` DATE COMMENT 'Date the location ceased operations (null if still active).',
    `close_time` TIMESTAMP COMMENT 'Daily closing time in HH:mm (24‑hour) format.',
    `cold_chain_compliant` BOOLEAN COMMENT 'True if the site meets cold‑chain regulatory requirements.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of certifications (e.g., ISO 22000, SQF).',
    `country` STRING COMMENT 'Three‑letter ISO country code of the location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created.',
    `dock_count` STRING COMMENT 'Number of loading docks available at the location.',
    `effective_from` DATE COMMENT 'Date from which the location information is considered valid.',
    `effective_until` DATE COMMENT 'Date after which the location information is no longer valid (null for open‑ended).',
    `is_primary` BOOLEAN COMMENT 'True if this location is the primary hub for its business unit.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude in decimal degrees.',
    `loading_bays` STRING COMMENT 'Count of dedicated loading bays for outbound shipments.',
    `location_code` STRING COMMENT 'Business‑assigned alphanumeric code used externally to reference the location.',
    `location_name` STRING COMMENT 'Human‑readable name of the facility, warehouse, store, or distribution point.',
    `location_status` STRING COMMENT 'Current lifecycle status of the location.',
    `location_type` STRING COMMENT 'Category of the location indicating its operational role.',
    `longitude` DOUBLE COMMENT 'Geographic longitude in decimal degrees.',
    `manager_contact_phone` STRING COMMENT 'Contact phone number for the location manager.',
    `manager_email` STRING COMMENT 'Email address for the location manager.',
    `manager_name` STRING COMMENT 'Name of the person responsible for day‑to‑day operations.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions for the location.',
    `open_date` DATE COMMENT 'Date the location began operations.',
    `open_time` TIMESTAMP COMMENT 'Daily opening time in HH:mm (24‑hour) format.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the location.',
    `receiving_bays` STRING COMMENT 'Count of bays used for inbound receipt of goods.',
    `region` STRING COMMENT 'Broad region (e.g., North America, EMEA) for reporting aggregation.',
    `security_level` STRING COMMENT 'Security classification of the site.',
    `state` STRING COMMENT 'State or province of the location.',
    `temperature_control` BOOLEAN COMMENT 'Indicates whether the location has temperature‑controlled storage.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the location (e.g., America/New_York).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the location record.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master reference table for location. Referenced by ship_from_location_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `food_beverage_ecm`.`distribution`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_location_id` FOREIGN KEY (`location_id`) REFERENCES `food_beverage_ecm`.`distribution`.`location`(`location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `food_beverage_ecm`.`distribution`.`location`(`location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `food_beverage_ecm`.`distribution`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_proof_of_delivery_id` FOREIGN KEY (`proof_of_delivery_id`) REFERENCES `food_beverage_ecm`.`distribution`.`proof_of_delivery`(`proof_of_delivery_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ADD CONSTRAINT `fk_distribution_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `food_beverage_ecm`.`distribution`.`location`(`location_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `ambient_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Ambient Zone Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `center_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Name');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `cross_dock_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Capable Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `cubic_capacity` SET TAGS ('dbx_business_glossary_term' = 'Cubic Capacity');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `dc_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `dc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `direct_store_delivery_hub_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Hub Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `dock_door_count` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Count');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `ecommerce_fulfillment_flag` SET TAGS ('dbx_business_glossary_term' = 'E-commerce Fulfillment Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `erp_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Plant Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi_temperature|cross_dock|consolidation');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `frozen_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Frozen Zone Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `haccp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Certified Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `inbound_dock_door_count` SET TAGS ('dbx_business_glossary_term' = 'Inbound Dock Door Count');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `iso_9001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 9001 Certified Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `operational_start_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Start Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|seasonal|temporarily_closed');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `outbound_dock_door_count` SET TAGS ('dbx_business_glossary_term' = 'Outbound Dock Door Count');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Ownership Model');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `ownership_model` SET TAGS ('dbx_value_regex' = 'company_owned|third_party_logistics|leased|co_managed');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `pallet_position_capacity` SET TAGS ('dbx_business_glossary_term' = 'Pallet Position Capacity');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `refrigerated_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Refrigerated Zone Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `storage_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Storage Square Footage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `temperature_zone_count` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Count');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `third_party_logistics_provider` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Provider');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `total_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Total Square Footage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `twenty_four_seven_operation_flag` SET TAGS ('dbx_business_glossary_term' = '24/7 Operation Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `wms_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) System Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` SET TAGS ('dbx_subdomain' = 'transportation_management');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `fsma_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fsma Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Legal Name');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|disqualified');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type Classification');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'asset_based|non_asset_based|broker|3pl|private_fleet|dsd_fleet');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `claims_ratio_percentage` SET TAGS ('dbx_business_glossary_term' = 'Claims Ratio Percentage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `cold_chain_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Capability Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `contracted_rate_tier` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate Tier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `contracted_rate_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|spot_market');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `dispatch_phone` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Phone Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `dispatch_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `dispatch_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capability Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `edi_protocol` SET TAGS ('dbx_business_glossary_term' = 'EDI Protocol Standard');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `edi_protocol` SET TAGS ('dbx_value_regex' = 'ansi_x12|edifact|api|none');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `fleet_size` SET TAGS ('dbx_business_glossary_term' = 'Fleet Size');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `fsma_certification_date` SET TAGS ('dbx_business_glossary_term' = 'FSMA Certification Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `fsma_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Modernization Act (FSMA) Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `fsma_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'FSMA Certification Expiration Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Expiration Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_business_glossary_term' = 'Motor Carrier (MC) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Onboarding Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `otif_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Percentage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Carrier Performance Tier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|probationary');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `preferred_carrier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'FMCSA Safety Rating');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|conditional|unsatisfactory|not_rated');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `service_coverage_region` SET TAGS ('dbx_business_glossary_term' = 'Service Coverage Region');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Service Mode');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Range Celsius');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carrier` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Range Celsius');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` SET TAGS ('dbx_subdomain' = 'transportation_management');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Route ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `actual_mileage` SET TAGS ('dbx_business_glossary_term' = 'Actual Mileage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `cases_delivered` SET TAGS ('dbx_business_glossary_term' = 'Cases Delivered');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `cases_loaded` SET TAGS ('dbx_business_glossary_term' = 'Cases Loaded');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `cases_refused` SET TAGS ('dbx_business_glossary_term' = 'Cases Refused');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `cases_returned` SET TAGS ('dbx_business_glossary_term' = 'Cases Returned');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `cash_collected` SET TAGS ('dbx_business_glossary_term' = 'Cash Collected');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `cash_collected` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `check_collected` SET TAGS ('dbx_business_glossary_term' = 'Check Collected');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `check_collected` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Route End Time');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `estimated_mileage` SET TAGS ('dbx_business_glossary_term' = 'Estimated Mileage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Route Frequency');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'DAILY|WEEKLY|BIWEEKLY|MONTHLY|ON_DEMAND');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `fuel_consumed_gallons` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed (Gallons)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `handheld_device_code` SET TAGS ('dbx_business_glossary_term' = 'Handheld Device ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `handheld_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `handheld_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `hazmat_required` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Required');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `otif_performance_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Performance Percentage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `route_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Route Completion Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `route_completion_status` SET TAGS ('dbx_value_regex' = 'COMPLETED|PARTIAL|CANCELLED|IN_PROGRESS|NOT_STARTED');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|SUSPENDED|PLANNED|RETIRED');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'DSD|DC_TO_RETAIL|FOODSERVICE|DTC|CROSS_DOCK|BACKHAUL');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `scheduled_days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Days of Week');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Route Start Time');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `stop_count` SET TAGS ('dbx_business_glossary_term' = 'Stop Count');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `stops_completed` SET TAGS ('dbx_business_glossary_term' = 'Stops Completed');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `stops_planned` SET TAGS ('dbx_business_glossary_term' = 'Stops Planned');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `temperature_range_max_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Fahrenheit)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `temperature_range_min_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Fahrenheit)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `vehicle_type_required` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type Required');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `vehicle_type_required` SET TAGS ('dbx_value_regex' = 'STRAIGHT_TRUCK|TRACTOR_TRAILER|REFRIGERATED_TRUCK|BOX_TRUCK|SPRINTER_VAN|CARGO_VAN');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `bill_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bill To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `asn_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Sent Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `exception_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Resolution Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `exception_resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|escalated');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channel');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_value_regex' = 'retail|foodservice|direct_to_consumer|direct_store_delivery|ecommerce|wholesale');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `fulfillment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `order_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Release Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|rush|cross_dock|drop_ship|sample|promotional');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `otif_target_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Target Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `picking_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picking Complete Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `picking_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picking Start Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `planned_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Ship Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `total_order_cases` SET TAGS ('dbx_business_glossary_term' = 'Total Order Cases');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `total_order_lines` SET TAGS ('dbx_business_glossary_term' = 'Total Order Lines');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `total_order_pallets` SET TAGS ('dbx_business_glossary_term' = 'Total Order Pallets');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `total_order_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Order Volume (Cubic Meters)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `total_order_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Order Weight (Kilograms)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `fulfillment_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Line ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Spec Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `promotion_line_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `shelf_life_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Spec Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `allocated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocated Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `carton_count` SET TAGS ('dbx_business_glossary_term' = 'Carton Count');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `catch_weight_actual` SET TAGS ('dbx_business_glossary_term' = 'Catch Weight Actual');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `catch_weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Catch Weight Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `catch_weight_uom` SET TAGS ('dbx_value_regex' = 'lb|kg|oz|g');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `fefo_pick_flag` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Pick Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `original_sku` SET TAGS ('dbx_business_glossary_term' = 'Original Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `original_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `packed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packed Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `pick_zone` SET TAGS ('dbx_business_glossary_term' = 'Pick Zone');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `picked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picked Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `quality_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `shipped_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipped Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `short_ship_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Short Ship Reason Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `short_ship_reason_code` SET TAGS ('dbx_value_regex' = 'out_of_stock|damaged_inventory|allocation_rule|customer_request|quality_hold|expired_product');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'case|each|pallet|layer|inner_pack|display_unit');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` SET TAGS ('dbx_subdomain' = 'transportation_management');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `bill_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bill To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Distribution Center (DC) Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `edi_trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Edi Trading Partner Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `import_export_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Import Export Permit Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship From Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `actual_delivery_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date and Time');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `actual_pickup_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Pickup Date and Time');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `asn_sent_datetime` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Sent Date and Time');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `asn_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Sent Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `case_count` SET TAGS ('dbx_business_glossary_term' = 'Case Count');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `delivery_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Exception Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `delivery_exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Exception Notes');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `dsd_route_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Route Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `freight_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `loading_sequence` SET TAGS ('dbx_business_glossary_term' = 'Loading Sequence Instructions');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Celsius');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Celsius');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `otif_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `pod_signature_name` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signature Name');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `pod_signature_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `pod_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `proof_of_delivery_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Received Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `scheduled_delivery_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date and Time');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `scheduled_pickup_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Pickup Date and Time');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|next_day|two_day|same_day|economy');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'planned|ready_to_ship|in_transit|delivered|cancelled|on_hold');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `stop_sequence` SET TAGS ('dbx_business_glossary_term' = 'Stop Sequence Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `temperature_zone_segregation_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Segregation Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `third_party_logistics_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `total_cube_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Cube in Cubic Meters');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Weight in Kilograms');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer or Container Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Trailer Utilization Percentage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `cases_delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cases Delivered Quantity');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `cases_ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cases Ordered Quantity');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `cases_refused_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cases Refused Quantity');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `cold_chain_compliant` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `delivery_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Condition Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `delivery_condition_code` SET TAGS ('dbx_value_regex' = 'good|damaged|partial_damage|temperature_excursion|packaging_issue|acceptable_with_notes');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `delivery_condition_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Condition Notes');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `delivery_photo_captured` SET TAGS ('dbx_business_glossary_term' = 'Delivery Photo Captured Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `delivery_photo_url` SET TAGS ('dbx_business_glossary_term' = 'Delivery Photo URL');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `delivery_photo_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'delivered|partially_delivered|refused|failed|in_transit|scheduled');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `dispute_raised` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Delivery Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `invoice_matched` SET TAGS ('dbx_business_glossary_term' = 'Invoice Matched Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `otif_compliant` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `pod_capture_method` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Capture Method');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `pod_capture_method` SET TAGS ('dbx_value_regex' = 'epod|paper_scan|edi_214|mobile_app|no_signature');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `pod_number` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `receiver_name` SET TAGS ('dbx_business_glossary_term' = 'Receiver Name');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `receiver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `receiver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `receiver_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Receiver Signature Captured Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `receiver_title` SET TAGS ('dbx_business_glossary_term' = 'Receiver Title');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `refusal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refusal Reason Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `refusal_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Refusal Reason Notes');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `scheduled_delivery_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Time Window End');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `scheduled_delivery_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Time Window Start');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_business_glossary_term' = 'Signature Image URL');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `stop_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Stop Sequence Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `temperature_at_delivery_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Delivery (Celsius)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `temperature_excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `cold_chain_event_id` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Event ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `shelf_life_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Spec Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `alert_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Notification Sent Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `alert_recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Alert Recipient List');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `alert_recipient_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `alert_recipient_list` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `asset_identifier` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'trailer|dc_zone|reefer_unit|container|warehouse_room|transport_vehicle');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `brix_measurement` SET TAGS ('dbx_business_glossary_term' = 'Brix (Sugar Content) Measurement');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `corrective_action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Product Disposition Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|quarantine|pending_review|destroyed');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `excursion_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Excursion Duration (Minutes)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `excursion_severity` SET TAGS ('dbx_business_glossary_term' = 'Excursion Severity Level');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `excursion_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `fsma_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'FSMA (Food Safety Modernization Act) Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `haccp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `humidity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity Percentage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `ph_measurement` SET TAGS ('dbx_business_glossary_term' = 'pH (Potential of Hydrogen) Measurement');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `recorded_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Recorded Temperature (Celsius)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `recorded_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Recorded Temperature (Fahrenheit)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `regulatory_report_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Required Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `regulatory_report_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `target_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Maximum (Celsius)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `target_temperature_max_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Maximum (Fahrenheit)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `target_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Minimum (Celsius)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `target_temperature_min_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Minimum (Fahrenheit)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `otif_record_id` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Record ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `cases_delivered` SET TAGS ('dbx_business_glossary_term' = 'Cases Delivered');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `cases_ordered` SET TAGS ('dbx_business_glossary_term' = 'Cases Ordered');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `chargeback_reference` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reference Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `committed_delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Window End');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `committed_delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Window Start');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `corrective_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Reference');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_destination_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_destination_type` SET TAGS ('dbx_value_regex' = 'retail_store|distribution_center|foodservice|direct_to_consumer|cross_dock');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Full Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `otif_composite_score` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Composite Score');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `penalty_fine_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Fine Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `penalty_fine_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
