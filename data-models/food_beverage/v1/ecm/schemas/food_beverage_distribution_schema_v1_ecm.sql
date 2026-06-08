-- Schema for Domain: distribution | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`distribution` COMMENT 'Owns physical distribution and outbound logistics execution — DC operations, WMS transactions, order fulfillment, carrier management, route optimization, OTIF/fill rate KPIs, cold chain compliance, ASN processing, 3PL performance, cross-docking, DSD route management, proof of delivery, and last-mile logistics for retail, foodservice, and DTC fulfillment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`center` (
    `center_id` BIGINT COMMENT 'Unique identifier for the distribution center. Primary key for the distribution center master record.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Links each distribution center to its pricing zone, supporting regional price‑zone based pricing strategies and zone‑specific cost allocation reports.',
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
    `gfsi_certification_expiry_date` DATE COMMENT 'Expiration date of the current GFSI certification. Used for compliance monitoring and audit scheduling.',
    `gfsi_certification_scheme` STRING COMMENT 'Specific GFSI-recognized certification scheme held by the facility (e.g., SQF Level 2, BRC Storage and Distribution, FSSC 22000). Nullable if not certified. [ENUM-REF-CANDIDATE: SQF|BRC|FSSC_22000|IFS|GLOBALG.A.P.|GRMS|PrimusGFS|CanadaGAP — promote to reference product]',
    `gfsi_certification_status` STRING COMMENT 'Current status of GFSI-recognized certification (e.g., SQF, BRC, FSSC 22000) for the distribution center. Critical for food safety compliance and customer requirements.. Valid values are `certified|not_certified|in_progress|expired`',
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
    `primary_service_region` STRING COMMENT 'Geographic region or market area primarily served by this distribution center for distribution network planning and territory management.',
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
    `asset_id` BIGINT COMMENT 'Reference to the specific vehicle (truck, trailer, van) assigned to this route execution. Populated for execution records, may be null for route master templates.',
    `center_id` BIGINT COMMENT 'Reference to the distribution center or warehouse that serves as the origin point for this route. All deliveries on this route originate from this DC.',
    `employee_id` BIGINT COMMENT 'Reference to the driver assigned to execute this route instance. Populated for execution records, may be null for route master templates.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Supports Route Planning for R&D sample kit deliveries, required by the Sample Distribution Schedule.',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Order attribution to marketing campaigns is required for sales‑to‑campaign performance reporting.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier or third-party logistics (3PL) provider assigned to transport this order. Used for carrier performance tracking and freight cost allocation.',
    `center_id` BIGINT COMMENT 'Reference to the distribution center or warehouse facility responsible for fulfilling this order. Identifies the source location for inventory picking and shipping operations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Captures the employee who created the order, supporting auditability and accountability in order processing.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Required for the Order Pricing Audit report, which tracks which price list version was applied to each fulfillment order for compliance and margin analysis.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Traceability report links each fulfillment order to the production order that created the shipped product.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Assigns revenue from each fulfillment order to a profit center for profitability analysis and reporting.',
    `delivery_route_id` BIGINT COMMENT 'Identifier for the delivery route to which this fulfillment order has been assigned. Used for Direct Store Delivery (DSD) route optimization and last-mile logistics planning.',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order that triggered this fulfillment order. Links the distribution execution back to the commercial transaction.',
    `ship_to_location_id` BIGINT COMMENT 'Reference to the destination location where goods will be delivered. May represent a retail store, distribution center, foodservice location, or direct-to-consumer address.',
    `shipment_id` BIGINT COMMENT 'Identifier for the consolidated shipment that includes this fulfillment order. Multiple orders may be combined into a single shipment for transportation efficiency.',
    `wave_id` BIGINT COMMENT 'Identifier for the picking wave or batch to which this fulfillment order has been assigned. Waves group multiple orders for efficient picking and resource optimization.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse associate who picked this line. Used for labor tracking and picker performance analysis.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order header. Links this line to its parent order document.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to ingredient.lot. Business justification: Recall Management Process: order lines need the exact ingredient lot to enable precise product recalls.',
    `pallet_id` BIGINT COMMENT 'Identifier for the pallet or shipping unit containing this line item. Used for pallet-level tracking and cross-docking operations.. Valid values are `^[A-Z0-9]{10,20}$`',
    `price_list_line_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_line. Business justification: Captures the exact price list line used for each order line, enabling line‑level margin calculations and price change impact reporting.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Line‑level traceability ties each order line to the specific production order that produced the SKU.',
    `promotion_line_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_line. Business justification: Each order line may be driven by a specific promotion line; linking enables accurate promotion ROI and claim reconciliation.',
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
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Regulatory batch traceability links shipments to the originating batch record for recall management.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand KPI report requires each shipment linked to its primary brand for on‑time‑in‑full and cost analysis.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaign fulfillment tracking needs to tie shipments generated by a specific marketing campaign to measure lift and ROI.',
    `carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_footprint. Business justification: Required for logistics GHG reporting per shipment (Scope 3 emissions) used in ESG disclosures and carbon accounting.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for moving the shipment.',
    `center_id` BIGINT COMMENT 'Identifier of the distribution center or warehouse from which the shipment originates.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for freight cost allocation to internal cost centers for accurate expense reporting per shipment.',
    `delivery_route_id` BIGINT COMMENT 'Identifier of the delivery route or multi-stop tour that this shipment is part of, used for route optimization and DSD operations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed to assign internal drivers to shipments for safety incident tracking and driver performance dashboards.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Needed to post freight expense of each shipment to the appropriate GL account for financial statements.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Logistics planning requires knowing the originating plant for each shipment.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Associates shipments with the pricing zone of origin, needed for freight cost allocation and OTIF compliance reporting by zone.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Required for New Product Launch Shipment Tracking report linking each shipment to its originating R&D project.',
    `retailer_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.retailer_agreement. Business justification: Compliance reporting requires each shipment to be linked to the retailer agreement governing delivery windows, fees, and penalties.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Required for Shipment‑Order reconciliation report used in OTIF compliance; each shipment must be tied to the originating sales order.',
    `ship_to_location_id` BIGINT COMMENT 'Identifier of the destination location (customer site, retail store, or receiving facility) for the shipment.',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` (
    `shipment_stop_id` BIGINT COMMENT 'Unique identifier for the shipment stop record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer or location receiving the delivery or providing the pickup. Links to the customer master for account and contact details.',
    `asset_id` BIGINT COMMENT 'Reference to the vehicle (truck, van, trailer) used for this stop. Used for vehicle utilization, maintenance scheduling, and cold chain equipment tracking.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or 3PL (Third-Party Logistics) provider executing this stop. Used for carrier performance tracking and cost allocation.',
    `delivery_route_id` BIGINT COMMENT 'Reference to the planned route or DSD (Direct Store Delivery) route that this stop belongs to. Used for route optimization and performance analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the driver who executed this stop. Used for driver performance tracking, training needs, and labor cost allocation.',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment or route that this stop belongs to. Links to the shipment header for multi-stop delivery routes.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Required for dock planning and inventory visibility: each shipment stop must be linked to a defined storage location in inventory.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Each inbound shipment stop occurs at a supplier site; linking enables logistics planning and carrier‑supplier coordination.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time the vehicle arrived at the stop location. Captured via driver mobile app, GPS telematics, or manual entry. Used for OTIF calculation.',
    `actual_cases_delivered` STRING COMMENT 'Number of cases actually delivered and accepted at this stop. Used for fill rate and OTIF measurement.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time the vehicle departed from the stop location after completing delivery or pickup. Used for dwell time and route efficiency analysis.',
    `actual_volume_m3` DECIMAL(18,2) COMMENT 'Actual volume in cubic meters of goods delivered or picked up at this stop. May differ from planned due to refusals or adjustments.',
    `actual_weight_kg` DECIMAL(18,2) COMMENT 'Actual weight in kilograms of goods delivered or picked up at this stop. May differ from planned due to refusals or adjustments.',
    `asn_number` STRING COMMENT 'Advanced Shipping Notice number sent to the customer prior to delivery via EDI (Electronic Data Interchange). Used for customer receiving preparation and cross-reference.',
    `cases_picked_up` STRING COMMENT 'Number of cases picked up from the customer location (e.g., returns, empties, reverse logistics). Applicable when stop_type is pickup or return.',
    `cases_refused` STRING COMMENT 'Number of cases refused by the customer at delivery due to damage, temperature excursion, incorrect product, or other quality issues. Triggers return and credit processes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment stop record was first created in the system. Used for audit trail and data lineage.',
    `delivery_instructions` STRING COMMENT 'Special instructions for the driver at this stop (e.g., use rear entrance, call upon arrival, leave at loading dock). Provided by customer or route planner.',
    `dwell_time_minutes` STRING COMMENT 'Total time in minutes spent at the stop location, calculated as the difference between actual_arrival_timestamp and actual_departure_timestamp. Used for route efficiency and driver productivity analysis.',
    `failure_notes` STRING COMMENT 'Free-text notes explaining the failure reason in detail. Captured by driver or dispatcher when a stop cannot be completed.',
    `failure_reason_code` STRING COMMENT 'Standardized code indicating why the stop failed if stop_status is failed. Used for root cause analysis and service improvement. [ENUM-REF-CANDIDATE: customer_closed|access_denied|address_incorrect|product_refused|vehicle_breakdown|weather|other — 7 candidates stripped; promote to reference product]',
    `in_full_flag` BOOLEAN COMMENT 'Indicates whether the full planned quantity was delivered (True = actual_cases_delivered equals planned_cases_delivered, False = short delivery). Used for OTIF KPI calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment stop record was last updated. Used for audit trail and change tracking.',
    `on_time_flag` BOOLEAN COMMENT 'Indicates whether the stop was completed on time (True = arrival within scheduled window, False = late or early outside tolerance). Used for OTIF KPI calculation.',
    `planned_cases_delivered` STRING COMMENT 'Number of cases scheduled for delivery at this stop according to the route plan. Used for load planning and fill rate calculation.',
    `planned_volume_m3` DECIMAL(18,2) COMMENT 'Total planned volume in cubic meters of goods to be delivered or picked up at this stop. Used for vehicle capacity planning and cube utilization.',
    `planned_weight_kg` DECIMAL(18,2) COMMENT 'Total planned weight in kilograms of goods to be delivered or picked up at this stop. Used for vehicle load planning and compliance with weight regulations.',
    `pod_photo_captured_flag` BOOLEAN COMMENT 'Indicates whether a photo proof of delivery was captured at this stop (True = photo taken, False = no photo). Used for contactless delivery verification.',
    `pod_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether a proof of delivery signature was captured at this stop (True = signature obtained, False = no signature). Required for delivery confirmation and dispute resolution.',
    `pod_signature_name` STRING COMMENT 'Name of the person who signed for the delivery. Captured via driver mobile app or paper manifest. Used for delivery verification.',
    `pod_timestamp` TIMESTAMP COMMENT 'Date and time when the proof of delivery was captured. May differ slightly from actual_departure_timestamp if signature is obtained before final vehicle departure.',
    `scheduled_arrival_date` DATE COMMENT 'Planned date for arrival at the stop location. Used for customer communication and route planning.',
    `scheduled_arrival_time_end` TIMESTAMP COMMENT 'End of the scheduled arrival time window. Defines the latest acceptable arrival time for on-time performance measurement.',
    `scheduled_arrival_time_start` TIMESTAMP COMMENT 'Beginning of the scheduled arrival time window. Used for customer appointment scheduling and OTIF (On Time In Full) measurement.',
    `stop_number` STRING COMMENT 'Business identifier for the stop, typically a sequential or formatted code used in route planning and driver manifests.',
    `stop_sequence` STRING COMMENT 'Ordinal position of this stop within the shipment route. Used for route optimization and execution order (e.g., 1, 2, 3).',
    `stop_status` STRING COMMENT 'Current lifecycle status of the stop: scheduled (planned but not started), in_transit (en route), arrived (vehicle at location), completed (delivery/pickup finished), failed (unable to complete), cancelled (stop removed from route).. Valid values are `scheduled|in_transit|arrived|completed|failed|cancelled`',
    `stop_type` STRING COMMENT 'Classification of the stop activity: delivery (outbound to customer), pickup (inbound from supplier or return), cross-dock (transfer between vehicles), return (product return), or inspection (quality check point).. Valid values are `delivery|pickup|cross_dock|return|inspection`',
    `temperature_at_delivery_c` DECIMAL(18,2) COMMENT 'Product temperature in Celsius recorded at the time of delivery. Captured via temperature monitoring device or manual thermometer reading. Required for cold chain compliance.',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicates whether the delivery maintained required cold chain temperature throughout the stop (True = compliant, False = excursion detected). Critical for food safety and FSMA compliance.',
    CONSTRAINT pk_shipment_stop PRIMARY KEY(`shipment_stop_id`)
) COMMENT 'Individual stop on a multi-stop shipment or DSD route, representing a delivery or pickup event at a specific customer location. Captures stop sequence, stop type (delivery, pickup, cross-dock), customer location, scheduled arrival window, actual arrival time, actual departure time, cases delivered, cases refused, POD signature captured flag, and stop status. Enables route execution tracking and OTIF measurement at the stop level.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` (
    `proof_of_delivery_id` BIGINT COMMENT 'Unique identifier for the proof of delivery record.',
    `account_id` BIGINT COMMENT 'Reference to the customer who received the delivery.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or third-party logistics (3PL) provider that executed the delivery.',
    `order_id` BIGINT COMMENT 'Reference to the delivery order fulfilled by this delivery.',
    `delivery_route_id` BIGINT COMMENT 'Reference to the delivery route on which this delivery was executed, used for Direct Store Delivery (DSD) route management.',
    `ship_to_location_id` BIGINT COMMENT 'Reference to the specific delivery location (store, warehouse, distribution center) where goods were received.',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment that this proof of delivery confirms.',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` (
    `advance_ship_notice_id` BIGINT COMMENT 'Unique identifier for the advanced shipping notice record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for delivering this shipment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns ASN processing costs to a cost center, enabling accurate cost allocation for inbound logistics.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks the employee responsible for ASN creation, required for traceability and regulatory audit reports.',
    `edi_trading_partner_id` BIGINT COMMENT 'Identifier of the trading partner (customer, retailer, supplier, or co-packer) associated with this ASN. For outbound ASNs, this is the recipient; for inbound ASNs, this is the sender.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the fulfillment order that this ASN is fulfilling. Links ASN to the originating customer order or purchase order.',
    `location_id` BIGINT COMMENT 'Identifier of the originating facility (distribution center, manufacturing plant, co-packer, or supplier warehouse) from which goods are shipped.',
    `ship_to_location_id` BIGINT COMMENT 'Identifier of the destination facility (customer DC, retail store, foodservice location, or receiving warehouse) where goods will be delivered.',
    `shipment_id` BIGINT COMMENT 'Reference to the physical shipment record associated with this ASN. Links ASN to warehouse management and transportation execution systems.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: ASN processing uses SKU to validate shipment contents, enabling accurate inventory allocation and regulatory compliance checks.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: ASN originates from the supplying vendor; linking to supplier supports performance tracking and compliance reporting.',
    `actual_ship_date` DATE COMMENT 'Actual date when the shipment departed from the origin facility. Used for OTIF performance measurement.',
    `asn_number` STRING COMMENT 'Business identifier for the ASN transmitted to customers or received from suppliers. Externally-known unique reference number.',
    `asn_status` STRING COMMENT 'Current lifecycle status of the ASN. Tracks progression from creation through transmission, acknowledgment, and final receipt or rejection. [ENUM-REF-CANDIDATE: draft|transmitted|acknowledged|in_transit|received|rejected|cancelled — 7 candidates stripped; promote to reference product]',
    `asn_type` STRING COMMENT 'Classification of the ASN direction and purpose. Outbound ASNs are sent to customers/retailers; inbound ASNs are received from suppliers, co-packers, or contract manufacturers.. Valid values are `outbound_to_customer|inbound_from_supplier|inbound_from_copacker|intercompany_transfer|return_shipment|sample_shipment`',
    `bill_of_lading_number` STRING COMMENT 'Carrier-issued bill of lading number for the shipment. Legal document serving as receipt and contract of carriage.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether continuous temperature monitoring and cold chain documentation is required for this shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ASN record was first created in the system.',
    `edi_acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the trading partner acknowledged receipt of the ASN via EDI 997 functional acknowledgment.',
    `edi_control_number` STRING COMMENT 'Unique control number assigned to the EDI 856 transaction for tracking and reconciliation purposes.',
    `edi_transaction_set` STRING COMMENT 'EDI transaction set identifier. ASNs use the 856 Ship Notice/Manifest transaction set.. Valid values are `^856$`',
    `edi_transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the ASN was transmitted via EDI to the trading partner. Used for compliance and SLA tracking.',
    `expected_delivery_date` DATE COMMENT 'Planned date when the shipment will arrive at the destination facility. Critical for DC receiving planning and retailer compliance.',
    `expected_delivery_time_window_end` TIMESTAMP COMMENT 'End of the delivery appointment window. Late arrivals may result in chargebacks or rejected shipments.',
    `expected_delivery_time_window_start` TIMESTAMP COMMENT 'Start of the delivery appointment window. Many retailers require precise time-slot delivery for dock scheduling.',
    `expected_ship_date` DATE COMMENT 'Planned date when the shipment will depart from the origin facility.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling and documentation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ASN record was last modified. Used for audit trail and data synchronization.',
    `purchase_order_number` STRING COMMENT 'Customer or supplier purchase order number that this ASN is fulfilling. Used for cross-reference and compliance validation.',
    `ship_to_address_line1` STRING COMMENT 'Primary street address line of the destination location. Organizational contact data classified as confidential.',
    `ship_to_city` STRING COMMENT 'City of the destination location. Organizational contact data classified as confidential.',
    `ship_to_country_code` STRING COMMENT 'Three-letter ISO country code of the destination location.. Valid values are `^[A-Z]{3}$`',
    `ship_to_postal_code` STRING COMMENT 'Postal or ZIP code of the destination location. Organizational contact data classified as confidential.',
    `ship_to_state_province` STRING COMMENT 'State or province code of the destination location. Organizational contact data classified as confidential.',
    `temperature_zone` STRING COMMENT 'Required temperature control zone for the shipment. Critical for cold chain compliance and food safety.. Valid values are `ambient|refrigerated|frozen|controlled_ambient`',
    `total_carton_count` STRING COMMENT 'Total number of cartons or cases included in this shipment. Used for receiving verification and inventory accuracy.',
    `total_pallet_count` STRING COMMENT 'Total number of pallets included in this shipment. Used for dock space planning and receiving resource allocation.',
    `total_volume` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment. Used for trailer utilization and warehouse space planning.',
    `total_weight` DECIMAL(18,2) COMMENT 'Total weight of the shipment including packaging. Used for freight cost validation and carrier capacity planning.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for real-time shipment visibility and proof of delivery.',
    `volume_uom` STRING COMMENT 'Unit of measure for shipment volume. CF=cubic feet, CBM=cubic meters, L=liters.. Valid values are `CF|CBM|L`',
    `weight_uom` STRING COMMENT 'Unit of measure for shipment weight. LB=pounds, KG=kilograms, TON=US tons, MT=metric tonnes.. Valid values are `LB|KG|TON|MT`',
    CONSTRAINT pk_advance_ship_notice PRIMARY KEY(`advance_ship_notice_id`)
) COMMENT 'Advanced Shipping Notice (ASN) record transmitted to customers or received from suppliers/co-packers prior to shipment arrival. Captures ASN number, ASN type (outbound to customer, inbound from supplier), trading partner, shipment reference, expected arrival date, SKU/GTIN list, lot numbers, quantities, pallet labels (SSCC), and EDI 856 transaction status. Supports retailer compliance, DC receiving, and FSMA traceability requirements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` (
    `wms_transaction_id` BIGINT COMMENT 'Unique identifier for the WMS transaction record. Primary key for all warehouse movement events within distribution centers.',
    `carton_id` BIGINT COMMENT 'Carton or case identifier for case-level tracking. Used for serialized shipment tracking and ASN generation.',
    `center_id` BIGINT COMMENT 'Identifier of the distribution center where this transaction occurred.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allocates labor and equipment costs captured in WMS transactions to the responsible cost center for internal cost tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse operator or picker who executed this transaction. Used for productivity tracking and accountability.',
    `experimental_formula_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formula. Business justification: Enables inventory traceability of experimental formula batches during pilot manufacturing.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the fulfillment order associated with this transaction. Populated for pick, loading, and wave release transactions.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to ingredient.lot. Business justification: Warehouse Transaction Traceability: linking WMS moves to ingredient lot supports audit of lot handling.',
    `lifecycle_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.lifecycle_assessment. Business justification: Links warehouse transactions to product LCA data to calculate real‑time carbon intensity per move.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Warehouse transaction reconciliation with production orders ensures inventory accuracy.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: WMS transactions record receipt and movement of inventory against a specific purchase order for traceability and audit.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: WMS transaction reporting requires linking each inventory movement to the master SKU for traceability, costing, and compliance reports.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Regulatory and audit need: WMS transaction must reference the specific stock position moved to ensure traceability and accurate valuation.',
    `asn_number` STRING COMMENT 'Advanced Shipping Notice number for inbound receipt transactions. Links WMS receipts to supplier shipment notifications via EDI.',
    `catch_weight` DECIMAL(18,2) COMMENT 'Actual weight for variable-weight products (meat, produce, cheese). Used when product weight varies from standard case weight.',
    `catch_weight_uom` STRING COMMENT 'Unit of measure for catch weight: lb (pounds), kg (kilograms), oz (ounces), g (grams).. Valid values are `lb|kg|oz|g`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data lakehouse. Audit field for data lineage tracking.',
    `dock_door` STRING COMMENT 'Dock door number for receipt and loading transactions. Used for yard management and carrier coordination.',
    `expiration_date` DATE COMMENT 'Product expiration or best-by date. Used for FEFO (First Expired First Out) picking logic and shelf life management.',
    `fefo_compliance_flag` BOOLEAN COMMENT 'Indicates whether this pick transaction followed FEFO logic (picking the lot with the nearest expiration date first). Critical for food safety and waste reduction.',
    `from_location` STRING COMMENT 'Source warehouse location for the transaction. Format typically zone-aisle-bay-level (e.g., A-12-05-C). Null for receipt transactions.',
    `gtin` STRING COMMENT 'Global Trade Item Number for the product. Standardized product identifier used across the supply chain (GTIN-8, UPC-12, EAN-13, or GTIN-14 format).. Valid values are `^d{8}$|^d{12}$|^d{13}$|^d{14}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the product in this transaction is classified as hazardous material requiring special handling and storage.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last modified in the data lakehouse. Audit field for change tracking.',
    `pallet_code` STRING COMMENT 'License plate or pallet identifier for the handling unit. Used for pallet-level tracking and cross-docking operations.',
    `po_number` STRING COMMENT 'Purchase order number for receipt transactions. Links warehouse receipts to procurement orders.',
    `quality_inspection_flag` BOOLEAN COMMENT 'Indicates whether this transaction triggered or required a quality inspection. Used for GMP and HACCP compliance tracking.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of product moved in this transaction. Positive for receipts and putaways, negative for picks and adjustments out.',
    `reason_code` STRING COMMENT 'Reason code for adjustment and transfer transactions: damage (product damage), expiration (expired product), quality_hold (QA hold), customer_return (returned goods), overage (excess inventory), shortage (missing inventory), cycle_count_variance (count discrepancy), system_correction (ERP sync adjustment). [ENUM-REF-CANDIDATE: damage|expiration|quality_hold|customer_return|overage|shortage|cycle_count_variance|system_correction — 8 candidates stripped; promote to reference product]',
    `reference` STRING COMMENT 'Original transaction identifier from the source WMS system. Used for audit trail and reconciliation with operational WMS.',
    `storage_zone` STRING COMMENT 'Warehouse zone classification for the transaction location: reserve (long-term storage), pick_face (active picking area), bulk (pallet storage), cross_dock (direct transfer), quarantine (quality hold), staging (outbound prep), returns (customer returns), damaged (defective goods). [ENUM-REF-CANDIDATE: reserve|pick_face|bulk|cross_dock|quarantine|staging|returns|damaged — 8 candidates stripped; promote to reference product]',
    `temperature_zone` STRING COMMENT 'Temperature control zone for cold chain compliance: ambient (room temperature), refrigerated (35-45°F), frozen (0°F or below), controlled (specific temperature range). Critical for food safety and quality assurance.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `to_location` STRING COMMENT 'Destination warehouse location for the transaction. Format typically zone-aisle-bay-level (e.g., B-08-12-A). Null for pick and loading transactions.',
    `transaction_status` STRING COMMENT 'Current status of the WMS transaction: pending (queued for execution), in_progress (being executed), completed (successfully finished), cancelled (aborted), error (system failure).. Valid values are `pending|in_progress|completed|cancelled|error`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the warehouse transaction was executed in the WMS. This is the operational event time, distinct from audit timestamps.',
    `transaction_type` STRING COMMENT 'Type of warehouse movement transaction: receipt (inbound goods arrival), putaway (placement into storage), pick (order fulfillment selection), replenishment (stock movement to pick face), transfer (location-to-location movement), cycle_count (inventory verification), adjustment (inventory correction), wave_release (batch order release), loading (dock door staging). [ENUM-REF-CANDIDATE: receipt|putaway|pick|replenishment|transfer|cycle_count|adjustment|wave_release|loading — 9 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'Unit of measure for the transaction quantity: each (individual unit), case (shipping case), pallet (full pallet), layer (pallet layer), inner_pack (multi-pack), display_unit (retail display).. Valid values are `each|case|pallet|layer|inner_pack|display_unit`',
    `wave_code` STRING COMMENT 'Wave or batch identifier for grouped order fulfillment. Links pick transactions to wave planning and release events. Null for non-pick transactions.',
    `wms_source_system` STRING COMMENT 'Source WMS system identifier (e.g., Manhattan, Blue Yonder, SAP EWM, HighJump). Used for multi-WMS environments and data lineage.',
    CONSTRAINT pk_wms_transaction PRIMARY KEY(`wms_transaction_id`)
) COMMENT 'Granular WMS (Warehouse Management System) transaction record capturing all warehouse movements within a DC — receipts, putaways, picks, replenishments, transfers, cycle counts, adjustments, wave/batch releases, and dock door loading events. Captures transaction type, transaction datetime, DC, storage location (zone/aisle/bay/level), SKU, lot, quantity, UOM, operator ID, equipment ID, wave/batch ID, dock door reference, and WMS source system reference. Wave/batch release transactions serve as the operational record for wave planning within the DC (wave ID, wave release time, orders in wave, wave completion status). Provides the operational audit trail for all inventory movements, pick operations, and wave execution within distribution facilities. Supports lot traceability, FEFO compliance verification, DC productivity measurement, and wave performance analysis.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` (
    `cold_chain_event_id` BIGINT COMMENT 'Unique identifier for the cold chain monitoring event record.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Cold‑chain compliance monitoring per batch requires linking temperature events to the batch record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Temperature compliance reports are often brand‑specific; linking events to brand enables brand‑wise quality monitoring.',
    `carrier_id` BIGINT COMMENT 'Unique identifier for the transportation carrier responsible for the cold chain asset during transit.',
    `employee_id` BIGINT COMMENT 'User identifier of the quality assurance or food safety personnel who reviewed the cold chain event and made the disposition decision.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Temperature excursion reports must reference the product registration to satisfy FDA and FSMA traceability requirements.',
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment or load associated with this cold chain monitoring event.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Cold‑chain monitoring must associate temperature excursions with the specific SKU to satisfy FSMA/HACCP audit and product recall processes.',
    `alert_notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether an automated alert notification was sent to responsible personnel when the excursion was detected (True if sent, False if not sent).',
    `alert_recipient_list` STRING COMMENT 'Comma-separated list of email addresses or user IDs that received the temperature excursion alert notification.',
    `asset_identifier` STRING COMMENT 'Unique identifier or code for the specific cold chain asset (e.g., trailer number, zone code, reefer unit serial number).',
    `asset_type` STRING COMMENT 'Type of cold chain asset being monitored (trailer, distribution center zone, reefer unit, container, warehouse room, or transport vehicle).. Valid values are `trailer|dc_zone|reefer_unit|container|warehouse_room|transport_vehicle`',
    `brix_measurement` DECIMAL(18,2) COMMENT 'Sugar content measurement in degrees Brix if applicable to the product being monitored (primarily for beverages and fruit products).',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective action implemented in response to a temperature excursion or monitoring alert.',
    `corrective_action_timestamp` TIMESTAMP COMMENT 'Date and time when corrective action was initiated in response to the temperature excursion.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cold chain event record was first created in the system.',
    `destination_location_code` STRING COMMENT 'Code identifying the destination location (retail store, distribution center, or customer site) for the cold chain shipment.',
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
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the product being monitored for traceability purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the cold chain event record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the cold chain event, excursion circumstances, or corrective actions taken.',
    `origin_location_code` STRING COMMENT 'Code identifying the origin location (distribution center, manufacturing plant, or warehouse) where the cold chain monitoring began.',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` (
    `freight_invoice_id` BIGINT COMMENT 'Unique identifier for the freight invoice record. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Cost allocation to brands for freight spend is required for brand profitability and budgeting.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier who provided the transportation service and issued this invoice.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Ensures freight invoice amounts are charged to the correct cost center, supporting cost accounting and budgeting.',
    `employee_id` BIGINT COMMENT 'The user ID of the person or system that completed the freight audit for this invoice.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Links each freight invoice to the GL account for proper posting of freight expense in the general ledger.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Freight invoices are billed to the purchase order that initiated the shipment, enabling financial reconciliation and OTIF analysis.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment record for which this freight invoice was issued.',
    `accessorial_charges` DECIMAL(18,2) COMMENT 'Total of all accessorial charges (liftgate, inside delivery, residential delivery, detention, redelivery, etc.).',
    `approved_payment_amount` DECIMAL(18,2) COMMENT 'The amount approved for payment after audit and dispute resolution. May differ from total billed amount if short-paid or adjusted.',
    `audit_status` STRING COMMENT 'The current status of the freight audit process for this invoice. Indicates whether the invoice has been reviewed, approved, or flagged for dispute.. Valid values are `Pending|Approved|Disputed|Short-Paid|Rejected|Under Review`',
    `audited_timestamp` TIMESTAMP COMMENT 'The timestamp when the freight audit was completed for this invoice.',
    `bol_number` STRING COMMENT 'The Bill of Lading number associated with this shipment. Legal document issued by carrier to shipper.',
    `contracted_rate_amount` DECIMAL(18,2) COMMENT 'The expected total amount based on the contracted rate agreement with the carrier for this shipment profile.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this freight invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for all monetary amounts on this invoice (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'The date the shipment was delivered to the destination location.',
    `destination_city` STRING COMMENT 'The city to which the shipment was delivered.',
    `destination_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code to which the shipment was delivered (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'The code identifying the shipment destination location (customer DC, retail store, or end customer).',
    `destination_postal_code` STRING COMMENT 'The postal code to which the shipment was delivered.',
    `destination_state_province` STRING COMMENT 'The state or province to which the shipment was delivered.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the invoice based on contracted rates or promotional agreements.',
    `dispute_notes` STRING COMMENT 'Free-text notes describing the details of the dispute, including supporting documentation references and resolution actions.',
    `dispute_reason_code` STRING COMMENT 'The code identifying the reason for disputing this invoice (e.g., rate discrepancy, duplicate charge, incorrect accessorial, service failure).',
    `distance_miles` DECIMAL(18,2) COMMENT 'The distance traveled for this shipment in miles, as calculated by the carrier.',
    `fuel_surcharge` DECIMAL(18,2) COMMENT 'The fuel surcharge applied to the shipment based on current fuel prices and carrier fuel surcharge tables.',
    `invoice_date` DATE COMMENT 'The date the carrier issued the freight invoice.',
    `invoice_due_date` DATE COMMENT 'The date by which payment is due to the carrier per the payment terms.',
    `invoice_number` STRING COMMENT 'The carrier-issued invoice number. This is the externally-known unique identifier for this freight invoice.',
    `line_haul_charge` DECIMAL(18,2) COMMENT 'The base transportation charge for moving the freight from origin to destination, excluding accessorials and surcharges.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this freight invoice record was last modified.',
    `origin_city` STRING COMMENT 'The city from which the shipment originated.',
    `origin_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code from which the shipment originated (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `origin_location_code` STRING COMMENT 'The code identifying the shipment origin location (DC, plant, or supplier facility).',
    `origin_postal_code` STRING COMMENT 'The postal code from which the shipment originated.',
    `origin_state_province` STRING COMMENT 'The state or province from which the shipment originated.',
    `payment_date` DATE COMMENT 'The date payment was issued to the carrier for this invoice.',
    `payment_reference_number` STRING COMMENT 'The reference number of the payment transaction (check number, wire transfer ID, ACH trace number) used to pay this invoice.',
    `payment_status` STRING COMMENT 'The current payment status of this freight invoice.. Valid values are `Unpaid|Paid|Partially Paid|Pending|Cancelled`',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date until payment is due (e.g., Net 30, Net 45).',
    `pro_number` STRING COMMENT 'The carrier-assigned Progressive Rotating Order (PRO) number used to track the shipment. Standard identifier in LTL and truckload freight.',
    `rate_variance_amount` DECIMAL(18,2) COMMENT 'The variance between the billed amount and the contracted rate amount. Positive values indicate overbilling; negative values indicate underbilling.',
    `received_timestamp` TIMESTAMP COMMENT 'The timestamp when the freight invoice was received by the organization (via EDI, email, or carrier portal).',
    `service_level` STRING COMMENT 'The specific service level provided by the carrier (e.g., Standard, Expedited, Next Day, Two Day, White Glove, Temperature Controlled).',
    `service_mode` STRING COMMENT 'The mode of transportation service provided (Full Truckload, Less Than Truckload, Parcel, Intermodal, Air, Ocean, Rail, Courier). [ENUM-REF-CANDIDATE: FTL|LTL|Parcel|Intermodal|Air|Ocean|Rail|Courier — 8 candidates stripped; promote to reference product]',
    `shipment_date` DATE COMMENT 'The date the shipment was picked up by the carrier from the origin location.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'The total amount billed by the carrier on this invoice, including line haul, fuel surcharge, accessorials, and any adjustments.',
    `weight_actual` DECIMAL(18,2) COMMENT 'The actual weight of the shipment as measured or certified by the carrier.',
    `weight_uom` STRING COMMENT 'The unit of measure for the shipment weight (pounds, kilograms, tons, metric tons).. Valid values are `LB|KG|TON|MT`',
    CONSTRAINT pk_freight_invoice PRIMARY KEY(`freight_invoice_id`)
) COMMENT 'Carrier freight invoice record for transportation services rendered. Captures invoice number, carrier, invoice date, payment due date, shipment references, billed charges (line haul, fuel surcharge, accessorials), contracted rate reference, variance amount (billed vs. contracted), audit status (approved, disputed, short-paid), and payment status. Supports freight audit and payment (FAP) processes and carrier cost management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`otif_record` (
    `otif_record_id` BIGINT COMMENT 'Unique identifier for the OTIF performance measurement record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand‑level OTIF scorecards need a direct link from OTIF records to the brand of the product shipped.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier responsible for transporting the shipment.',
    `center_id` BIGINT COMMENT 'Reference to the distribution center that fulfilled the order and is responsible for the OTIF performance.',
    `account_id` BIGINT COMMENT 'Reference to the customer account for which OTIF performance is being measured.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the fulfillment order that this OTIF record measures performance against.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Identifies the employee accountable for OTIF compliance, used in OTIF performance and penalty reporting.',
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
    `delivery_address_line1` STRING COMMENT 'First line of the delivery destination address.',
    `delivery_city` STRING COMMENT 'City of the delivery destination.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the delivery destination (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `delivery_destination_type` STRING COMMENT 'The type of destination location for the delivery (e.g., retail store, distribution center, foodservice, direct-to-consumer).. Valid values are `retail_store|distribution_center|foodservice|direct_to_consumer|cross_dock`',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code of the delivery destination.',
    `delivery_state_province` STRING COMMENT 'State or province of the delivery destination.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this OTIF failure has been escalated to senior management due to severity or repeat occurrence.',
    `fill_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of ordered cases that were successfully delivered, calculated as (cases_delivered / cases_ordered) * 100.',
    `in_full_flag` BOOLEAN COMMENT 'Boolean indicator of whether the full ordered quantity was delivered without shortages (True = in-full, False = short).',
    `measurement_date` DATE COMMENT 'The date on which the OTIF performance was measured and recorded.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this OTIF record was last updated with new information (e.g., root cause, corrective action).',
    `on_time_flag` BOOLEAN COMMENT 'Boolean indicator of whether the delivery was completed within the committed time window (True = on-time, False = late).',
    `otif_composite_score` DECIMAL(18,2) COMMENT 'The composite OTIF performance score, typically expressed as a percentage (0-100), representing the combined on-time and in-full achievement.',
    `penalty_fine_amount` DECIMAL(18,2) COMMENT 'The monetary penalty or fine amount assessed by the retailer for OTIF non-compliance.',
    `proof_of_delivery_reference` STRING COMMENT 'Reference to the proof of delivery document or electronic signature confirming receipt.',
    `record_status` STRING COMMENT 'Current lifecycle status of the OTIF record (e.g., created, under investigation, resolved, penalty paid, closed). [ENUM-REF-CANDIDATE: created|under_investigation|root_cause_identified|corrective_action_assigned|resolved|penalty_paid|closed — 7 candidates stripped; promote to reference product]',
    `responsible_party` STRING COMMENT 'The organizational unit or individual responsible for managing this OTIF record and corrective actions.',
    `retailer_otif_program` STRING COMMENT 'The specific retailer OTIF compliance program under which this delivery performance is measured (e.g., Walmart OTIF, Target In-Stock, Kroger On-Time Delivery).. Valid values are `Walmart OTIF|Target In-Stock|Kroger OTD|Costco Delivery Compliance|Amazon OTIF|Other`',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the OTIF miss (e.g., carrier delay, DC late release, inventory shortage, weather event). [ENUM-REF-CANDIDATE: carrier_delay|dc_late_release|inventory_short|weather|traffic|equipment_failure|labor_shortage|system_error|other — 9 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis for the OTIF failure.',
    `shipment_reference` STRING COMMENT 'The shipment identifier associated with this OTIF measurement, linking to the physical delivery.',
    `temperature_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether cold chain temperature requirements were maintained throughout delivery (True = compliant, False = breach).',
    CONSTRAINT pk_otif_record PRIMARY KEY(`otif_record_id`)
) COMMENT 'On-Time In-Full (OTIF) performance measurement record capturing delivery performance against customer-committed windows at the shipment or fulfillment order level. Captures measurement date, customer account, retailer OTIF program (Walmart OTIF, Target In-Stock, Kroger OTD, Costco delivery compliance), shipment reference, fulfillment order reference, committed delivery window, actual delivery datetime, on-time flag, in-full flag, OTIF composite score, cases ordered, cases delivered, fill rate percentage, penalty/fine amount, chargeback reference, root cause code for misses (carrier delay, DC late release, inventory short, weather), and corrective action reference. Each record has an independent lifecycle: created at measurement, updated with root cause and corrective action, closed upon resolution or penalty payment. Supports retailer scorecard compliance, chargeback/penalty management, and continuous improvement programs.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` (
    `returns_receipt_id` BIGINT COMMENT 'Unique identifier for the returns receipt record. Primary key.',
    `account_id` BIGINT COMMENT 'Identifier of the customer or account returning the product. Null for internal transfers or unattributed returns.',
    `center_id` BIGINT COMMENT 'Identifier of the distribution center where the return was received.',
    `delivery_route_id` BIGINT COMMENT 'Identifier of the DSD route from which the product was returned. Applicable for DSD return source types.',
    `order_id` BIGINT COMMENT 'Identifier of the original customer order that included this product. Used for order-to-cash reconciliation.',
    `shipment_id` BIGINT COMMENT 'Identifier of the original outbound shipment from which this product is being returned. Used for root cause analysis and OTIF tracking.',
    `price_list_line_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_line. Business justification: References the original price list line for the returned SKU, allowing accurate refund calculations and return‑impact financial analysis.',
    `employee_id` BIGINT COMMENT 'Identifier of the quality inspector who evaluated the returned product.',
    `sku_id` BIGINT COMMENT 'Internal unique identifier linking to the product master record.',
    `cold_chain_compliant_flag` BOOLEAN COMMENT 'Indicates whether the returned product maintained proper temperature control during transit and storage. False indicates potential quality compromise.',
    `condition_code` STRING COMMENT 'The physical and quality condition of the returned product upon receipt. Determines disposition path.. Valid values are `saleable|damaged|expired|destroyed|contaminated|recalled`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this returns receipt record was first created in the system.',
    `credit_memo_reference` STRING COMMENT 'Reference number of the credit memo issued to the customer for this return. Links to accounts receivable and financial reconciliation.. Valid values are `^CM[0-9]{10}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the return value amount.. Valid values are `^[A-Z]{3}$`',
    `disposition_decision` STRING COMMENT 'The final decision on how the returned product will be handled. Drives inventory adjustment and financial accounting.. Valid values are `restock|donate|destroy|rework|quarantine|return_to_vendor`',
    `disposition_timestamp` TIMESTAMP COMMENT 'The date and time when the disposition decision was executed (restocked, destroyed, donated, etc.).',
    `expiration_date` DATE COMMENT 'The expiration or best-by date of the returned product. Used to determine disposition and FEFO compliance.',
    `gtin` STRING COMMENT 'The 14-digit global trade item number for the returned product. Used for cross-system reconciliation and traceability.. Valid values are `^[0-9]{14}$`',
    `inspection_timestamp` TIMESTAMP COMMENT 'The date and time when quality inspection was completed for the returned product.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the returned product. Critical for traceability, recall management, and FSMA compliance.. Valid values are `^LOT[0-9A-Z]{6,15}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this returns receipt record was last updated.',
    `pallet_code` STRING COMMENT 'Identifier of the pallet on which the returned product was received. Used for warehouse location tracking.. Valid values are `^PLT[0-9A-Z]{8,12}$`',
    `production_date` DATE COMMENT 'The date the product was manufactured. Supports shelf life calculation and traceability.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the returned product requires quality inspection before disposition decision is finalized.',
    `quantity_returned` DECIMAL(18,2) COMMENT 'The quantity of product returned, expressed in the unit of measure specified.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this return is part of a product recall event. Triggers special handling and regulatory reporting.',
    `recall_number` STRING COMMENT 'Official recall event identifier if this return is associated with a product recall. Used for regulatory reporting and traceability.. Valid values are `^RCL[0-9]{8}$`',
    `receipt_timestamp` TIMESTAMP COMMENT 'The date and time when the returned product was physically received at the distribution center. Critical for FEFO compliance and shelf life tracking.',
    `return_authorization_number` STRING COMMENT 'The externally-known authorization number issued to approve the return. Used for tracking and reconciliation with customer service and sales systems.. Valid values are `^RMA[0-9]{10}$`',
    `return_reason_notes` STRING COMMENT 'Free-text notes providing additional context on the reason for the return. Captured from customer service or driver input.',
    `return_source_type` STRING COMMENT 'The type of originating source from which the product was returned.. Valid values are `retail_customer|foodservice_customer|dsd_route|distributor|internal_transfer`',
    `return_type` STRING COMMENT 'Classification of the reason for the return. Drives disposition logic and financial treatment.. Valid values are `unsold|damaged|expired|recall|quality_issue|wrong_shipment`',
    `return_value_amount` DECIMAL(18,2) COMMENT 'The monetary value of the returned product, used for credit calculation and financial reporting.',
    `returns_receipt_status` STRING COMMENT 'Current lifecycle status of the returns receipt record. Tracks progression from receipt through final disposition.. Valid values are `received|inspecting|pending_disposition|disposed|closed`',
    `sku` STRING COMMENT 'Internal stock keeping unit code identifying the returned product at the item level.. Valid values are `^[A-Z0-9]{8,12}$`',
    `temperature_zone` STRING COMMENT 'The required storage temperature zone for the returned product. Critical for cold chain compliance and food safety.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `uom` STRING COMMENT 'The unit of measure for the returned quantity (Each, Case, Pallet, Pound, Kilogram, Gallon, Liter). [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|GAL|LTR — 7 candidates stripped; promote to reference product]',
    `warehouse_location` STRING COMMENT 'The specific bin, aisle, or zone location within the DC where the returned product is stored pending disposition.. Valid values are `^[A-Z0-9]{2,4}-[A-Z0-9]{2,4}-[A-Z0-9]{2,4}$`',
    CONSTRAINT pk_returns_receipt PRIMARY KEY(`returns_receipt_id`)
) COMMENT 'Inbound returns receipt record for product returned from customers, retailers, or DSD routes back to a DC. Captures return authorization number, return type (unsold, damaged, expired, recall), customer/route source, receipt datetime, DC, SKU/GTIN, lot number, quantity returned, condition code (saleable, damaged, expired, destroyed), disposition decision (restock, donate, destroy, rework), and credit memo reference. Supports FEFO compliance, recall management, and reverse logistics.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`yard_management` (
    `yard_management_id` BIGINT COMMENT 'System-generated unique identifier for each yard management event record.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier responsible for the trailer; links to the carrier master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Charges yard handling activities to the appropriate cost center for expense control and performance measurement.',
    `employee_id` BIGINT COMMENT 'Reference to the driver operating the trailer; links to driver master data.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Captures yard events (detention, loading) for inbound/outbound pilot trial shipments tied to a specific R&D project.',
    `previous_yard_management_id` BIGINT COMMENT 'Self-referencing FK on yard_management (previous_yard_management_id)',
    `appointment_reference` STRING COMMENT 'External appointment or booking number tied to the trailers scheduled yard time.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the yard management record was first created in the system.',
    `detention_end_timestamp` TIMESTAMP COMMENT 'Date‑time when detention ended; null if still detained.',
    `detention_start_timestamp` TIMESTAMP COMMENT 'Date‑time when detention or demurrage clock started for the trailer.',
    `dock_door_assigned` STRING COMMENT 'Identifier of the dock door where the trailer is staged or loaded.',
    `driver_name` STRING COMMENT 'Full name of the driver associated with the yard event.',
    `event_number` STRING COMMENT 'Business-assigned sequential identifier for the yard event, used for tracking and reference.',
    `event_status` STRING COMMENT 'Current lifecycle status of the yard event record.. Valid values are `pending|completed|cancelled`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the yard event occurred.',
    `event_type` STRING COMMENT 'Type of yard activity captured (e.g., trailer check‑in, dock assignment, internal yard move, or check‑out).. Valid values are `check_in|dock_assignment|yard_move|check_out`',
    `humidity_percentage` DECIMAL(18,2) COMMENT 'Relative humidity measured in the yard area during the event.',
    `is_detained` BOOLEAN COMMENT 'True if the trailer is currently under detention or demurrage.',
    `load_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the cargo loaded onto the trailer, measured in kilograms.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the yard management record.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by yard personnel.',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether the trailer/event is marked as high priority for processing.',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the trailer for tamper evidence.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Recorded ambient temperature of the trailer or yard spot at event time.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'True if the trailer requires temperature control (refrigerated or frozen).',
    `trailer_number` STRING COMMENT 'Unique identifier printed on the trailer chassis, used for logistics and compliance.',
    `trailer_status` STRING COMMENT 'Current operational status of the trailer within the yard.. Valid values are `loaded_inbound|empty|loaded_outbound|live_unload|drop`',
    `unload_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the cargo removed from the trailer, measured in kilograms.',
    `yard_move_distance_meters` STRING COMMENT 'Distance the trailer was moved within the yard, measured in meters.',
    `yard_spot_location` STRING COMMENT 'Alphanumeric code of the specific yard spot or parking location assigned to the trailer.',
    CONSTRAINT pk_yard_management PRIMARY KEY(`yard_management_id`)
) COMMENT 'Yard management transaction record tracking trailer and vehicle movements within DC yard boundaries. Captures yard event type (check-in, dock assignment, yard move, check-out), trailer number, carrier, arrival datetime, dock door assigned, yard spot location, trailer status (loaded inbound, empty, loaded outbound, live unload, drop), seal number verification, detention/demurrage start time, driver check-in/out, appointment reference, priority flag, temperature-controlled trailer flag, and yard event status. Supports yard visibility, dock door utilization optimization, detention cost management, and trailer turn-time KPIs at high-volume F&B distribution centers.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `parent_location_id` BIGINT COMMENT 'Self-referencing FK on location (parent_location_id)',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `capacity_sqft` DECIMAL(18,2) COMMENT 'Total usable square‑footage capacity of the facility.',
    `city` STRING COMMENT 'City where the location resides.',
    `close_date` DATE COMMENT 'Date the location ceased operations (null if still active).',
    `close_time` STRING COMMENT 'Daily closing time in HH:mm (24‑hour) format.',
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
    `location_type` STRING COMMENT 'Category of the location indicating its operational role.',
    `longitude` DOUBLE COMMENT 'Geographic longitude in decimal degrees.',
    `manager_contact_phone` STRING COMMENT 'Contact phone number for the location manager.',
    `manager_email` STRING COMMENT 'Email address for the location manager.',
    `manager_name` STRING COMMENT 'Name of the person responsible for day‑to‑day operations.',
    `location_name` STRING COMMENT 'Human‑readable name of the facility, warehouse, store, or distribution point.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions for the location.',
    `open_date` DATE COMMENT 'Date the location began operations.',
    `open_time` STRING COMMENT 'Daily opening time in HH:mm (24‑hour) format.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the location.',
    `receiving_bays` STRING COMMENT 'Count of bays used for inbound receipt of goods.',
    `region` STRING COMMENT 'Broad region (e.g., North America, EMEA) for reporting aggregation.',
    `security_level` STRING COMMENT 'Security classification of the site.',
    `state` STRING COMMENT 'State or province of the location.',
    `location_status` STRING COMMENT 'Current lifecycle status of the location.',
    `temperature_control` BOOLEAN COMMENT 'Indicates whether the location has temperature‑controlled storage.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the location (e.g., America/New_York).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the location record.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master reference table for location. Referenced by ship_from_location_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`wave` (
    `wave_id` BIGINT COMMENT 'Primary key for wave',
    `carrier_id` BIGINT COMMENT 'FK to distribution.carrier',
    `delivery_route_id` BIGINT COMMENT 'Identifier of the primary transportation route assigned to the wave.',
    `consolidated_wave_id` BIGINT COMMENT 'Self-referencing FK on wave (consolidated_wave_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date‑time when wave processing completed.',
    `actual_quantity` BIGINT COMMENT 'Actual number of units processed in the wave.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date‑time when wave processing began.',
    `actual_weight_kg` DECIMAL(18,2) COMMENT 'Total actual weight of items processed in the wave, expressed in kilograms.',
    `compliance_flag` STRING COMMENT 'Indicates whether the wave meets required regulatory or quality compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the wave record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the wave is scheduled to end or be retired (nullable for open‑ended waves).',
    `effective_start_date` DATE COMMENT 'Date when the wave becomes active for execution.',
    `is_expedited` BOOLEAN COMMENT 'Indicates whether the wave is marked for expedited handling.',
    `notes` STRING COMMENT 'Free‑form notes or comments entered by operations staff.',
    `planned_quantity` BIGINT COMMENT 'Total number of units planned to be processed in the wave.',
    `planned_weight_kg` DECIMAL(18,2) COMMENT 'Total planned weight of all items in the wave, expressed in kilograms.',
    `priority` STRING COMMENT 'Business priority level of the wave.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date‑time for wave execution.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date‑time for wave execution.',
    `wave_status` STRING COMMENT 'Current lifecycle status of the wave.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature requirement for the wave.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature requirement for the wave (e.g., cold‑chain compliance).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the wave record.',
    `wave_category` STRING COMMENT 'Higher‑level classification of the wave (e.g., seasonal, promotional, replenishment).',
    `wave_code` STRING COMMENT 'External business code or reference number assigned to the wave by the distribution system.',
    `wave_description` STRING COMMENT 'Detailed description of the wave purpose and scope.',
    `wave_name` STRING COMMENT 'Human‑readable name of the wave used for reporting and operational planning.',
    `wave_type` STRING COMMENT 'Category of the wave indicating the primary logistics activity (e.g., pick, pack, load, dispatch).',
    CONSTRAINT pk_wave PRIMARY KEY(`wave_id`)
) COMMENT 'Master reference table for wave. Referenced by wave_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`pallet` (
    `pallet_id` BIGINT COMMENT 'Primary key for pallet',
    `parent_pallet_id` BIGINT COMMENT 'Self-referencing FK on pallet (parent_pallet_id)',
    `barcode` STRING COMMENT 'Scannable barcode representing the pallets external identifier.',
    `condition` STRING COMMENT 'Physical condition assessment of the pallet.',
    `current_location_code` STRING COMMENT 'Identifier of the warehouse, dock, or carrier location where the pallet is presently situated.',
    `expiration_date` DATE COMMENT 'Date after which the pallet should be retired or inspected for compliance.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the pallet in centimeters.',
    `is_refrigerated` BOOLEAN COMMENT 'Indicates whether the pallet is designed for temperature‑controlled shipments.',
    `label` STRING COMMENT 'Human‑readable label or name assigned to the pallet for easy identification.',
    `last_inspection_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent inspection performed on the pallet.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the pallet in centimeters.',
    `manufacture_date` DATE COMMENT 'Date the pallet was manufactured.',
    `material` STRING COMMENT 'Primary material from which the pallet is constructed.',
    `max_load_kg` DECIMAL(18,2) COMMENT 'Maximum weight the pallet can safely carry, in kilograms.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance or inspection.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or observations about the pallet.',
    `owner_department` STRING COMMENT 'Internal department responsible for the pallet.',
    `pallet_type` STRING COMMENT 'Category of pallet based on construction and purpose.',
    `pallet_status` STRING COMMENT 'Current lifecycle status of the pallet within distribution operations.',
    `temperature_range_c` STRING COMMENT 'Operational temperature range for refrigerated pallets, expressed as min‑max in Celsius.',
    `usage_count` STRING COMMENT 'Number of times the pallet has been used in shipments.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Actual weight of the empty pallet in kilograms.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the pallet in centimeters.',
    CONSTRAINT pk_pallet PRIMARY KEY(`pallet_id`)
) COMMENT 'Master reference table for pallet. Referenced by pallet_id.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`distribution`.`carton` (
    `carton_id` BIGINT COMMENT 'Primary key for carton',
    `supplier_id` BIGINT COMMENT 'FK to procurement.supplier',
    `parent_carton_id` BIGINT COMMENT 'Self-referencing FK on carton (parent_carton_id)',
    `carton_code` STRING COMMENT 'Business code or barcode representing the carton type.',
    `carton_type` STRING COMMENT 'Classification of the carton based on usage and design.',
    `cold_chain_compliant` BOOLEAN COMMENT 'Indicates if the carton meets cold chain requirements for temperature-sensitive goods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carton record was created.',
    `carton_description` STRING COMMENT 'Textual description of the carton.',
    `dimensions_height_cm` DECIMAL(18,2) COMMENT 'Physical height of the carton in centimeters.',
    `dimensions_length_cm` DECIMAL(18,2) COMMENT 'Physical length of the carton in centimeters.',
    `dimensions_width_cm` DECIMAL(18,2) COMMENT 'Physical width of the carton in centimeters.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection of the carton.',
    `is_reusable` BOOLEAN COMMENT 'Indicates whether the carton is designed for reuse.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the carton.',
    `manufacturer` STRING COMMENT 'Name of the entity that manufactures the carton.',
    `material` STRING COMMENT 'Primary material composition of the carton.',
    `max_load_kg` DECIMAL(18,2) COMMENT 'Maximum load weight the carton can safely hold.',
    `carton_status` STRING COMMENT 'Current lifecycle status of the carton.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the carton record.',
    `volume_cubic_m` DECIMAL(18,2) COMMENT 'Internal volume capacity of the carton in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Empty weight of the carton in kilograms.',
    CONSTRAINT pk_carton PRIMARY KEY(`carton_id`)
) COMMENT 'Master reference table for carton. Referenced by carton_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ADD CONSTRAINT `fk_distribution_delivery_route_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ADD CONSTRAINT `fk_distribution_fulfillment_order_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `food_beverage_ecm`.`distribution`.`wave`(`wave_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `food_beverage_ecm`.`distribution`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_pallet_id` FOREIGN KEY (`pallet_id`) REFERENCES `food_beverage_ecm`.`distribution`.`pallet`(`pallet_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ADD CONSTRAINT `fk_distribution_fulfillment_order_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ADD CONSTRAINT `fk_distribution_shipment_stop_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ADD CONSTRAINT `fk_distribution_shipment_stop_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ADD CONSTRAINT `fk_distribution_shipment_stop_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ADD CONSTRAINT `fk_distribution_proof_of_delivery_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ADD CONSTRAINT `fk_distribution_advance_ship_notice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ADD CONSTRAINT `fk_distribution_advance_ship_notice_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `food_beverage_ecm`.`distribution`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ADD CONSTRAINT `fk_distribution_advance_ship_notice_location_id` FOREIGN KEY (`location_id`) REFERENCES `food_beverage_ecm`.`distribution`.`location`(`location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ADD CONSTRAINT `fk_distribution_advance_ship_notice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_carton_id` FOREIGN KEY (`carton_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carton`(`carton_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ADD CONSTRAINT `fk_distribution_wms_transaction_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `food_beverage_ecm`.`distribution`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ADD CONSTRAINT `fk_distribution_cold_chain_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ADD CONSTRAINT `fk_distribution_freight_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ADD CONSTRAINT `fk_distribution_freight_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ADD CONSTRAINT `fk_distribution_otif_record_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `food_beverage_ecm`.`distribution`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_center_id` FOREIGN KEY (`center_id`) REFERENCES `food_beverage_ecm`.`distribution`.`center`(`center_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ADD CONSTRAINT `fk_distribution_returns_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `food_beverage_ecm`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ADD CONSTRAINT `fk_distribution_yard_management_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ADD CONSTRAINT `fk_distribution_yard_management_previous_yard_management_id` FOREIGN KEY (`previous_yard_management_id`) REFERENCES `food_beverage_ecm`.`distribution`.`yard_management`(`yard_management_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ADD CONSTRAINT `fk_distribution_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `food_beverage_ecm`.`distribution`.`location`(`location_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wave` ADD CONSTRAINT `fk_distribution_wave_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carrier`(`carrier_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wave` ADD CONSTRAINT `fk_distribution_wave_delivery_route_id` FOREIGN KEY (`delivery_route_id`) REFERENCES `food_beverage_ecm`.`distribution`.`delivery_route`(`delivery_route_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`wave` ADD CONSTRAINT `fk_distribution_wave_consolidated_wave_id` FOREIGN KEY (`consolidated_wave_id`) REFERENCES `food_beverage_ecm`.`distribution`.`wave`(`wave_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`pallet` ADD CONSTRAINT `fk_distribution_pallet_parent_pallet_id` FOREIGN KEY (`parent_pallet_id`) REFERENCES `food_beverage_ecm`.`distribution`.`pallet`(`pallet_id`);
ALTER TABLE `food_beverage_ecm`.`distribution`.`carton` ADD CONSTRAINT `fk_distribution_carton_parent_carton_id` FOREIGN KEY (`parent_carton_id`) REFERENCES `food_beverage_ecm`.`distribution`.`carton`(`carton_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `gfsi_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Certification Expiry Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `gfsi_certification_scheme` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Certification Scheme');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `gfsi_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Certification Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `gfsi_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|in_progress|expired');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`center` ALTER COLUMN `primary_service_region` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Region');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`delivery_route` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Picker ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `pallet_id` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `pallet_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `price_list_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`fulfillment_order_line` ALTER COLUMN `promotion_line_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Line Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Distribution Center (DC) Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `retailer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer Agreement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` SET TAGS ('dbx_subdomain' = 'transportation_management');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `shipment_stop_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Stop ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `actual_cases_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Cases Delivered');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `actual_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume (Cubic Meters)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `actual_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight (Kilograms)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `cases_picked_up` SET TAGS ('dbx_business_glossary_term' = 'Cases Picked Up');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `cases_refused` SET TAGS ('dbx_business_glossary_term' = 'Cases Refused');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time (Minutes)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `failure_notes` SET TAGS ('dbx_business_glossary_term' = 'Failure Notes');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `planned_cases_delivered` SET TAGS ('dbx_business_glossary_term' = 'Planned Cases Delivered');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `planned_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume (Cubic Meters)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `planned_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Planned Weight (Kilograms)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `pod_photo_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Photo Captured Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `pod_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signature Captured Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `pod_signature_name` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signature Name');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `pod_signature_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `pod_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `scheduled_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `scheduled_arrival_time_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Time End');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `scheduled_arrival_time_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Time Start');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `stop_number` SET TAGS ('dbx_business_glossary_term' = 'Stop Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `stop_sequence` SET TAGS ('dbx_business_glossary_term' = 'Stop Sequence');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `stop_status` SET TAGS ('dbx_business_glossary_term' = 'Stop Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `stop_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_transit|arrived|completed|failed|cancelled');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `stop_type` SET TAGS ('dbx_business_glossary_term' = 'Stop Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `stop_type` SET TAGS ('dbx_value_regex' = 'delivery|pickup|cross_dock|return|inspection');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `temperature_at_delivery_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Delivery (Celsius)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`shipment_stop` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` SET TAGS ('dbx_subdomain' = 'transportation_management');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`proof_of_delivery` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` SET TAGS ('dbx_subdomain' = 'transportation_management');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `advance_ship_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `edi_trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship From Location ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Location ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `asn_status` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `asn_type` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `asn_type` SET TAGS ('dbx_value_regex' = 'outbound_to_customer|inbound_from_supplier|inbound_from_copacker|intercompany_transfer|return_shipment|sample_shipment');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `edi_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Acknowledgment Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `edi_control_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Control Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_value_regex' = '^856$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `edi_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `expected_delivery_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Time Window End');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `expected_delivery_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Time Window Start');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `expected_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Ship Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Line 1');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_business_glossary_term' = 'Ship To City');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship To Country Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Ship To Postal Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_business_glossary_term' = 'Ship To State or Province');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_ambient');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `total_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Total Carton Count');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `total_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Total Pallet Count');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `total_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Volume');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `total_weight` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Weight');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'CF|CBM|L');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`advance_ship_notice` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'LB|KG|TON|MT');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `wms_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Transaction ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `carton_id` SET TAGS ('dbx_business_glossary_term' = 'Carton ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Operator ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `experimental_formula_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formula Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `lifecycle_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Lca Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `catch_weight` SET TAGS ('dbx_business_glossary_term' = 'Catch Weight');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `catch_weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Catch Weight Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `catch_weight_uom` SET TAGS ('dbx_value_regex' = 'lb|kg|oz|g');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `dock_door` SET TAGS ('dbx_business_glossary_term' = 'Dock Door');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `fefo_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `from_location` SET TAGS ('dbx_business_glossary_term' = 'From Location');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^d{8}$|^d{12}$|^d{13}$|^d{14}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `quality_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Quantity');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reason Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'WMS Transaction Reference');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `storage_zone` SET TAGS ('dbx_business_glossary_term' = 'Storage Zone');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `to_location` SET TAGS ('dbx_business_glossary_term' = 'To Location');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|error');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'WMS Transaction Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'each|case|pallet|layer|inner_pack|display_unit');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `wave_code` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wms_transaction` ALTER COLUMN `wms_source_system` SET TAGS ('dbx_business_glossary_term' = 'WMS Source System');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `cold_chain_event_id` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Event ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `food_beverage_ecm`.`distribution`.`cold_chain_event` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` SET TAGS ('dbx_subdomain' = 'transportation_management');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audited By User ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `accessorial_charges` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `approved_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Payment Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Disputed|Short-Paid|Rejected|Under Review');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `audited_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audited Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `dispute_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance in Miles');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `fuel_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `invoice_due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `line_haul_charge` SET TAGS ('dbx_business_glossary_term' = 'Line Haul Charge');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `origin_city` SET TAGS ('dbx_business_glossary_term' = 'Origin City');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `origin_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Postal Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `origin_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `origin_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `origin_state_province` SET TAGS ('dbx_business_glossary_term' = 'Origin State or Province');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'Unpaid|Paid|Partially Paid|Pending|Cancelled');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `rate_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Variance Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `weight_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`freight_invoice` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'LB|KG|TON|MT');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` SET TAGS ('dbx_subdomain' = 'transportation_management');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `otif_record_id` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Record ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_destination_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_destination_type` SET TAGS ('dbx_value_regex' = 'retail_store|distribution_center|foodservice|direct_to_consumer|cross_dock');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Full Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `otif_composite_score` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Composite Score');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `penalty_fine_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Fine Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `penalty_fine_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `proof_of_delivery_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Reference');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `retailer_otif_program` SET TAGS ('dbx_business_glossary_term' = 'Retailer On-Time In-Full (OTIF) Program');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `retailer_otif_program` SET TAGS ('dbx_value_regex' = 'Walmart OTIF|Target In-Stock|Kroger OTD|Costco Delivery Compliance|Amazon OTIF|Other');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`otif_record` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `returns_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Receipt ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Route ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Original Order ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Shipment ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `price_list_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `cold_chain_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = 'saleable|damaged|expired|destroyed|contaminated|recalled');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `credit_memo_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reference');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `credit_memo_reference` SET TAGS ('dbx_value_regex' = '^CM[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'restock|donate|destroy|rework|quarantine|return_to_vendor');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^LOT[0-9A-Z]{6,15}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `pallet_code` SET TAGS ('dbx_value_regex' = '^PLT[0-9A-Z]{8,12}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `recall_number` SET TAGS ('dbx_value_regex' = '^RCL[0-9]{8}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_value_regex' = '^RMA[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `return_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Notes');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `return_source_type` SET TAGS ('dbx_business_glossary_term' = 'Return Source Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `return_source_type` SET TAGS ('dbx_value_regex' = 'retail_customer|foodservice_customer|dsd_route|distributor|internal_transfer');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'unsold|damaged|expired|recall|quality_issue|wrong_shipment');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `return_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Value Amount');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `returns_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Returns Receipt Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `returns_receipt_status` SET TAGS ('dbx_value_regex' = 'received|inspecting|pending_disposition|disposed|closed');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `food_beverage_ecm`.`distribution`.`returns_receipt` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[A-Z0-9]{2,4}-[A-Z0-9]{2,4}$');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `yard_management_id` SET TAGS ('dbx_business_glossary_term' = 'Yard Management Record ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `previous_yard_management_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `appointment_reference` SET TAGS ('dbx_business_glossary_term' = 'Appointment Reference');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `detention_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detention End Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `detention_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detention Start Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `dock_door_assigned` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Assigned');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `driver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Yard Event Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Yard Event Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Yard Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Yard Event Type');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'check_in|dock_assignment|yard_move|check_out');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `humidity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `is_detained` SET TAGS ('dbx_business_glossary_term' = 'Is Detained Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `load_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Load Weight (kg)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Yard Event Notes');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature‑Controlled Flag');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `trailer_status` SET TAGS ('dbx_business_glossary_term' = 'Trailer Status');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `trailer_status` SET TAGS ('dbx_value_regex' = 'loaded_inbound|empty|loaded_outbound|live_unload|drop');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `unload_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Unload Weight (kg)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `yard_move_distance_meters` SET TAGS ('dbx_business_glossary_term' = 'Yard Move Distance (m)');
ALTER TABLE `food_beverage_ecm`.`distribution`.`yard_management` ALTER COLUMN `yard_spot_location` SET TAGS ('dbx_business_glossary_term' = 'Yard Spot Location');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`location` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wave` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wave` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wave` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wave` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`wave` ALTER COLUMN `consolidated_wave_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`pallet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`pallet` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `food_beverage_ecm`.`distribution`.`pallet` ALTER COLUMN `pallet_id` SET TAGS ('dbx_business_glossary_term' = 'Pallet Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`pallet` ALTER COLUMN `parent_pallet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carton` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carton` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carton` ALTER COLUMN `carton_id` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carton` ALTER COLUMN `supplier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`distribution`.`carton` ALTER COLUMN `parent_carton_id` SET TAGS ('dbx_self_ref_fk' = 'true');
