-- Schema for Domain: logistics | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`logistics` COMMENT 'Coordinates inbound and outbound transportation, freight forwarding, customs clearance, HS code compliance, GSP utilization, LDP calculations, carrier management, routing guides, and last-mile delivery tracking. Manages 3PL partnerships, shipment milestones, SLAs, and distribution network optimization via Manhattan Associates WMS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment record. Primary key for the logistics shipment entity.',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Freight transport is a major Scope 3 emission source (Category 4 upstream, Category 9 downstream). Apparel companies track carbon footprint per shipment for CDP disclosure, SBTi target tracking, and E',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier or logistics service provider responsible for moving the shipment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Shipment coordinators create and manage shipments for accountability, performance tracking, and audit trails. Essential for logistics operations reporting and workforce productivity analysis in appare',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight costs are allocated to cost centers for departmental budgeting and P&L tracking. Monthly cost center reporting requires shipment-level freight allocation to calculate actual vs budget variance',
    `distribution_center_id` BIGINT COMMENT 'Identifier of the facility, warehouse, store, or customer location to which the shipment is destined.',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: Shipments are classified by HS code for customs and duty purposes. N:1 relationship. Normalizes hs_code string to FK for referential integrity and to enable HS code master data management.',
    `order_purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order associated with this inbound shipment from supplier to warehouse.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Inbound shipments from supplier factories require direct factory tracking for origin verification, GSP/duty calculations, factory OTIF performance metrics, and compliance audits. Multi-factory vendors',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to production.factory. Business justification: Outbound shipments from factories require origin factory tracking for customs country-of-origin certification, GSP eligibility validation, factory OTIF performance measurement, and freight cost alloca',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Shipments serve specific channels/brands tracked via profit centers. Channel profitability analysis requires linking shipment costs to profit centers to calculate true landed cost by channel for margi',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: Sample shipments for RFQ evaluation require traceability to originating RFQ for quality validation, vendor performance tracking, and sample cost reconciliation in apparel sourcing operations.',
    `routing_guide_id` BIGINT COMMENT 'Foreign key linking to logistics.routing_guide. Business justification: Shipments should follow approved routing guide rules for carrier and lane selection. N:1 relationship. Enables routing compliance analysis and SLA tracking against routing guide targets.',
    `sales_order_id` BIGINT COMMENT 'Identifier of the sales order associated with this outbound shipment to customer or store.',
    `shipment_distribution_center_id` BIGINT COMMENT 'Identifier of the facility, warehouse, or manufacturing location from which the shipment originates.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Core operational link - inbound shipments of finished goods originate from sourcing POs; essential for ASN matching, receiving reconciliation, OTIF measurement, and landed cost allocation in apparel s',
    `third_party_logistics_id` BIGINT COMMENT 'Identifier of the 3PL partner managing logistics operations for this shipment, if applicable.',
    `trade_compliance_record_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_record. Business justification: Pre-shipment compliance screening requires validating each shipment against trade compliance records for HS classification, duty rates, and origin determination before customs clearance. Critical for ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Inbound finished goods shipments from factories must reference originating work orders for landed cost allocation, duty calculation per PO/WO, and end-to-end production-to-delivery traceability requir',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the shipment arrived at the destination facility or port.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the shipment departed from the origin facility or port.',
    `bill_of_lading_number` STRING COMMENT 'Legal document number issued by the carrier acknowledging receipt of cargo for shipment.',
    `booking_reference` STRING COMMENT 'Carrier or freight forwarder booking reference number for the shipment reservation.',
    `carton_count` STRING COMMENT 'Total number of cartons or packages included in the shipment.',
    `container_number` STRING COMMENT 'Unique identifier of the shipping container (for ocean FCL shipments), following ISO 6346 standard.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system.',
    `cubic_volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment measured in cubic meters, used for freight cost calculation.',
    `current_milestone` STRING COMMENT 'Most recent shipment milestone or checkpoint reached in the logistics journey (e.g., departed origin, in customs, out for delivery).',
    `customs_entry_number` STRING COMMENT 'Customs declaration or entry number assigned by customs authorities for international shipments.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code of the shipment destination location.. Valid values are `^[A-Z]{3}$`',
    `duty_amount` DECIMAL(18,2) COMMENT 'Total customs duty amount paid or payable for the shipment in the companys reporting currency.',
    `estimated_arrival_timestamp` TIMESTAMP COMMENT 'Planned or estimated timestamp when the shipment is expected to arrive at the destination facility or port.',
    `estimated_departure_timestamp` TIMESTAMP COMMENT 'Planned or estimated timestamp when the shipment is expected to depart from the origin facility or port.',
    `freight_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated freight transportation cost for the shipment in the companys reporting currency.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment including packaging, measured in kilograms.',
    `gsp_eligible_flag` BOOLEAN COMMENT 'Indicates whether the shipment qualifies for GSP tariff preferences, reducing or eliminating customs duties.',
    `incoterm` STRING COMMENT 'International commercial term defining the responsibilities of buyers and sellers for the delivery of goods (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_value` DECIMAL(18,2) COMMENT 'Declared value of the shipment for insurance purposes in the companys reporting currency.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was most recently modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to the shipment handling, routing, or delivery requirements.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code of the shipment origin location.. Valid values are `^[A-Z]{3}$`',
    `otif_compliant_flag` BOOLEAN COMMENT 'Indicates whether the shipment was delivered on time and in full per the agreed service level agreement.',
    `pallet_count` STRING COMMENT 'Total number of pallets included in the shipment.',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether this shipment has been flagged as high priority requiring expedited handling.',
    `shipment_number` STRING COMMENT 'Externally-known unique business identifier for the shipment, used across systems and with external partners.. Valid values are `^SHP[0-9]{10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment in the logistics workflow.. Valid values are `planned|booked|in_transit|customs_clearance|delivered|cancelled`',
    `shipment_type` STRING COMMENT 'Classification of the shipment based on commercial terms and destination type. FOB (Free on Board), LDP (Landed Duty Paid), DTC (Direct-to-Consumer), wholesale, inter-facility transfer, or RTV (Return to Vendor).. Valid values are `FOB|LDP|DTC|wholesale|inter_facility_transfer|return_to_vendor`',
    `sla_delivery_date` DATE COMMENT 'Target delivery date per the service level agreement with the customer or internal business unit.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for real-time shipment visibility and last-mile delivery tracking.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for the shipment. FCL (Full Container Load), LCL (Less than Container Load). [ENUM-REF-CANDIDATE: ocean_fcl|ocean_lcl|air|ground|courier|rail|intermodal — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Core master record for every inbound and outbound shipment movement in the apparel supply chain. Captures shipment type (FOB, LDP, DTC, wholesale, inter-facility transfer), origin and destination facilities, carrier assignment, transport mode (ocean FCL/LCL, air, ground, courier, rail), booking reference, ETD/ETA and actual departure/arrival timestamps, carton count, gross weight, cubic volume, freight cost estimate, insurance value, current milestone status, and priority flag. Serves as the SSOT for shipment identity across the logistics domain, linking to purchase orders, sales orders, 3PL partners, customs entries, and freight bookings. Supports both pre-retail (factory-to-DC) and post-retail (DC-to-store, DC-to-consumer) movements.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` (
    `shipment_milestone_id` BIGINT COMMENT 'Unique identifier for the shipment milestone event record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Shipment milestones are recorded by carriers at various transit points. N:1 relationship. Normalizes carrier_scac_code string to FK for carrier performance tracking by milestone.',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to production.factory. Business justification: Milestones occurring at factory locations (ex-factory departure, production complete, factory inspection) require factory reference for location validation, factory performance tracking, and TNA miles',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment for which this milestone event was recorded.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Milestone tracking (ex-factory, in-transit, customs clearance, in-DC) is performed at sourcing PO level for TNA compliance monitoring, OTIF measurement, and delay escalation in apparel supply chain.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Milestone verification requires employee accountability for customs clearance sign-offs, container inspections, and quality gates. Critical for compliance audits and operational performance tracking i',
    `actual_timestamp` TIMESTAMP COMMENT 'The actual date and time when the shipment reached this milestone status, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `city` STRING COMMENT 'City name where the milestone location is situated.',
    `container_number` STRING COMMENT 'Unique identifier for the shipping container or trailer associated with this milestone, used for ocean and intermodal freight tracking.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the milestone location is situated (e.g., USA, CHN, VNM).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts recorded at this milestone (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `customs_cleared_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether customs clearance was completed at this milestone, applicable for international shipments.',
    `data_source` STRING COMMENT 'System or channel from which this milestone data was captured (e.g., WMS, EDI, CARRIER_API, GPS_TRACKER, MANUAL_ENTRY, CUSTOMS_SYSTEM).. Valid values are `WMS|EDI|CARRIER_API|GPS_TRACKER|MANUAL_ENTRY|CUSTOMS_SYSTEM`',
    `duty_amount` DECIMAL(18,2) COMMENT 'Total customs duty amount assessed at this milestone for international shipments, used for Landed Duty Paid (LDP) calculations.',
    `edi_transaction_set` STRING COMMENT 'Electronic Data Interchange (EDI) transaction set code that provided this milestone data (e.g., 214 for Transportation Carrier Shipment Status Message).',
    `exception_code` STRING COMMENT 'Standardized code identifying the type of exception or issue encountered at this milestone (e.g., WEATHER_DELAY, CUSTOMS_HOLD, DAMAGED_GOODS, ADDRESS_CORRECTION).',
    `exception_description` STRING COMMENT 'Detailed text description of the exception or issue encountered, providing context for root cause analysis and resolution.',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this milestone represents an exception or deviation from the planned shipment flow (e.g., delay, damage, customs hold).',
    `gsp_eligible_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the shipment qualifies for Generalized System of Preferences (GSP) duty-free treatment.',
    `hs_code` STRING COMMENT 'Harmonized System (HS) code used for customs classification of the goods in this shipment, required for international trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `humidity_reading` DECIMAL(18,2) COMMENT 'Relative humidity percentage recorded at this milestone, applicable for shipments requiring controlled environmental conditions.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the milestone location in decimal degrees, used for GPS tracking and route optimization.',
    `location_code` STRING COMMENT 'Standardized code identifying the specific facility, port, or address where the milestone event occurred (e.g., UN/LOCODE for ports, internal facility codes for warehouses and stores).',
    `location_name` STRING COMMENT 'Human-readable name of the location where the milestone occurred (e.g., Port of Los Angeles, Memphis Distribution Center, Store #1234).',
    `location_type` STRING COMMENT 'Classification of the location where the milestone occurred (e.g., PORT, WAREHOUSE, DISTRIBUTION_CENTER, STORE, CUSTOMER_ADDRESS, TRANSSHIPMENT_HUB, CUSTOMS_FACILITY). [ENUM-REF-CANDIDATE: PORT|WAREHOUSE|DISTRIBUTION_CENTER|STORE|CUSTOMER_ADDRESS|TRANSSHIPMENT_HUB|CUSTOMS_FACILITY|CARRIER_FACILITY — 8 candidates stripped; promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the milestone location in decimal degrees, used for GPS tracking and route optimization.',
    `milestone_code` STRING COMMENT 'Standardized code representing the milestone status reached by the shipment (e.g., BOOKED, DEPARTED_ORIGIN, ARRIVED_TRANSSHIPMENT, CUSTOMS_CLEARED, ARRIVED_DC, DELIVERED). [ENUM-REF-CANDIDATE: BOOKED|DEPARTED_ORIGIN|IN_TRANSIT|ARRIVED_TRANSSHIPMENT|CUSTOMS_CLEARED|ARRIVED_DC|OUT_FOR_DELIVERY|DELIVERED|EXCEPTION|CANCELLED — 10 candidates stripped; promote to reference product]',
    `milestone_name` STRING COMMENT 'Human-readable description of the milestone event (e.g., Departed Origin Port, Customs Cleared, Delivered to Store).',
    `milestone_sequence` STRING COMMENT 'Sequential order of this milestone within the shipment lifecycle, used to track progression through the supply chain.',
    `notes` STRING COMMENT 'Free-form text notes or comments providing additional context about this milestone event, used for operational communication and issue resolution.',
    `otif_compliant_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this milestone meets On Time In Full (OTIF) delivery criteria for the shipment.',
    `planned_timestamp` TIMESTAMP COMMENT 'The originally planned or scheduled date and time for this milestone, used to calculate variance and On Time In Full (OTIF) performance.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the milestone location, used for geographic analysis and last-mile delivery tracking.',
    `recorded_by_user` STRING COMMENT 'Username or identifier of the system user or automated process that recorded this milestone event.',
    `responsible_party_code` STRING COMMENT 'Unique identifier or code for the specific carrier, Third-Party Logistics (3PL) provider, customs broker, or other party responsible for this milestone.',
    `responsible_party_name` STRING COMMENT 'Name of the carrier, Third-Party Logistics (3PL) provider, customs broker, freight forwarder, or other party responsible for this milestone.',
    `responsible_party_type` STRING COMMENT 'Classification of the party responsible for executing or recording this milestone (e.g., CARRIER, 3PL, CUSTOMS_BROKER, FREIGHT_FORWARDER, WAREHOUSE_OPERATOR). [ENUM-REF-CANDIDATE: CARRIER|3PL|CUSTOMS_BROKER|FREIGHT_FORWARDER|WAREHOUSE_OPERATOR|INTERNAL|CUSTOMER — 7 candidates stripped; promote to reference product]',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this milestone was achieved within the Service Level Agreement (SLA) time window.',
    `state_province` STRING COMMENT 'State or province code where the milestone location is situated.',
    `temperature_reading` DECIMAL(18,2) COMMENT 'Temperature reading in Celsius recorded at this milestone, applicable for temperature-controlled shipments of apparel with special storage requirements.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking or waybill number for this shipment leg, used for parcel and courier shipments.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the shipment leg associated with this milestone (e.g., OCEAN, AIR, TRUCK, RAIL, INTERMODAL, PARCEL). [ENUM-REF-CANDIDATE: OCEAN|AIR|TRUCK|RAIL|INTERMODAL|PARCEL|COURIER — 7 candidates stripped; promote to reference product]',
    `variance_hours` DECIMAL(18,2) COMMENT 'The time difference in hours between planned and actual milestone timestamp, used for Service Level Agreement (SLA) compliance tracking. Positive values indicate delay, negative values indicate early arrival.',
    `vessel_voyage_number` STRING COMMENT 'Identifier for the vessel, flight, or voyage number associated with this milestone, applicable for ocean and air freight.',
    CONSTRAINT pk_shipment_milestone PRIMARY KEY(`shipment_milestone_id`)
) COMMENT 'Transactional event log capturing every status milestone reached by a shipment throughout its lifecycle — booked, departed origin port, arrived transshipment hub, customs cleared, arrived destination DC, delivered to store or customer. Records milestone code, actual timestamp, location (port, facility, GPS coordinates), responsible party (carrier, 3PL, customs broker), exception flag, and variance from planned milestone date. Enables OTIF tracking and SLA compliance monitoring for apparel shipments.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` (
    `freight_booking_id` BIGINT COMMENT 'Unique identifier for the freight booking record. Primary key for the logistics freight booking entity.',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Booking-level emission tracking enables pre-shipment carbon estimation and mode optimization decisions (air vs. ocean freight). Supports proactive carbon management and low-carbon logistics procuremen',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or freight forwarder responsible for transporting the shipment. Links to the carrier master data.',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: Freight bookings declare HS codes for cargo classification and customs pre-clearance. N:1 relationship. Normalizes hs_code string to FK.',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the purchase order associated with this freight booking. Links the booking to the procurement transaction driving the shipment.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Freight bookings for factory shipments need factory origin for routing guide selection, port-of-loading determination, and factory-specific consolidation planning. Vendor_id insufficient when vendor o',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created this freight booking record. Supports audit and accountability.',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to production.factory. Business justification: Freight bookings for export shipments originate from factories. Factory reference enables factory-level freight cost analysis, capacity planning coordination between production and logistics, and rout',
    `routing_guide_id` BIGINT COMMENT 'Foreign key linking to logistics.routing_guide. Business justification: Freight bookings should follow approved routing guide rules for carrier selection and lane assignment. N:1 relationship (many bookings follow one routing guide). Enables compliance tracking and rate v',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment that this booking covers. Links to the shipment master record for tracking goods movement.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Freight bookings for inbound shipments are created based on sourcing PO ship windows, ex-factory dates, and delivery requirements to ensure on-time arrival for apparel seasonal launches.',
    `third_party_logistics_id` BIGINT COMMENT 'Reference to the 3PL provider managing the freight booking and logistics coordination. Links to the 3PL partner master data.',
    `vendor_id` BIGINT COMMENT 'Reference to the customs broker responsible for clearing the shipment through customs at the destination. Links to the customs broker master data.',
    `booking_date` DATE COMMENT 'Date when the freight booking was formally placed with the carrier or freight forwarder. Represents the principal business event timestamp for this transaction.',
    `booking_notes` STRING COMMENT 'Additional notes or comments related to the freight booking. Captures operational details, exceptions, or coordination information.',
    `booking_reference_number` STRING COMMENT 'Externally-known unique booking reference number assigned by the carrier or freight forwarder. Used for tracking and communication with logistics partners.. Valid values are `^[A-Z0-9]{8,20}$`',
    `booking_status` STRING COMMENT 'Current lifecycle status of the freight booking. Tracks progression from draft through confirmation, execution, and completion or cancellation.. Valid values are `DRAFT|CONFIRMED|PENDING|CANCELLED|COMPLETED|ON_HOLD`',
    `collection_season_code` STRING COMMENT 'Code identifying the apparel collection season (e.g., Spring/Summer 2024, Fall/Winter 2024) that this freight booking supports. Critical for seasonal collection launch planning.',
    `confirmed_space_allocation` DECIMAL(18,2) COMMENT 'Confirmed cargo space allocated by the carrier for this booking, measured in cubic meters (CBM) or container equivalent units (TEU). Supports capacity planning.',
    `container_quantity` STRING COMMENT 'Number of containers booked for this freight booking. Applicable for FCL (Full Container Load) shipments.',
    `container_type` STRING COMMENT 'Type of shipping container used for the booking. Includes standard dry containers, high-cube, refrigerated (reefer), and specialized containers. Applicable for ocean freight FCL bookings.. Valid values are `20FT_DRY|40FT_DRY|40FT_HC|20FT_REEFER|40FT_REEFER|FLAT_RACK`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight booking record was first created in the system. Audit trail for record creation.',
    `cut_off_date` DATE COMMENT 'Final date and time by which cargo must be delivered to the carrier or terminal to meet the scheduled departure. Critical for operational planning.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the destination country where the shipment will be delivered. Three-letter uppercase code.. Valid values are `^[A-Z]{3}$`',
    `estimated_arrival_date` DATE COMMENT 'Estimated date when the carrier is scheduled to arrive at the port of discharge or destination terminal.',
    `estimated_departure_date` DATE COMMENT 'Estimated date when the carrier is scheduled to depart from the port of loading or origin terminal.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight charge amount for this booking as per the rate agreement. Excludes surcharges, duties, and taxes.',
    `freight_charge_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the freight charge amount. Indicates the currency in which the freight charge is denominated.. Valid values are `^[A-Z]{3}$`',
    `gsp_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the shipment is eligible for GSP duty-free treatment. True if eligible, False otherwise. Supports duty optimization.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the shipment contains hazardous materials requiring special handling and documentation. True if hazardous, False otherwise.',
    `incoterm_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the responsibilities, costs, and risks between buyer and seller for this shipment. Examples: FOB (Free on Board), CIF (Cost Insurance and Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether cargo insurance is required for this booking. True if insurance is required, False otherwise.',
    `insurance_value_amount` DECIMAL(18,2) COMMENT 'Declared value of the cargo for insurance purposes. Used to calculate insurance premiums and coverage limits.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight booking record was last updated. Audit trail for record modifications.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country of origin where the shipment originates. Three-letter uppercase code.. Valid values are `^[A-Z]{3}$`',
    `port_of_discharge_code` STRING COMMENT 'UN/LOCODE for the port or terminal where goods are unloaded from the carrier. Five-character alphanumeric code.. Valid values are `^[A-Z]{5}$`',
    `port_of_loading_code` STRING COMMENT 'UN/LOCODE (United Nations Code for Trade and Transport Locations) for the port or terminal where goods are loaded onto the carrier. Five-character alphanumeric code.. Valid values are `^[A-Z]{5}$`',
    `rate_agreement_reference` STRING COMMENT 'Reference number of the negotiated rate agreement or contract with the carrier that governs pricing for this booking. Links to carrier contract master data.',
    `service_type` STRING COMMENT 'Type of freight service booked. FCL (Full Container Load), LCL (Less than Container Load), air charter, express courier, ocean freight, road freight, rail freight, or courier service. [ENUM-REF-CANDIDATE: FCL|LCL|AIR_CHARTER|AIR_EXPRESS|OCEAN_FREIGHT|ROAD_FREIGHT|RAIL_FREIGHT|COURIER — 8 candidates stripped; promote to reference product]',
    `space_allocation_unit` STRING COMMENT 'Unit of measure for the confirmed space allocation. CBM (Cubic Meters), TEU (Twenty-foot Equivalent Unit), FEU (Forty-foot Equivalent Unit), KG (Kilograms), or LBS (Pounds).. Valid values are `CBM|TEU|FEU|KG|LBS`',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling requirements for the shipment, such as temperature control, fragile handling, hazardous materials, or priority processing.',
    `vessel_name` STRING COMMENT 'Name of the vessel (for ocean freight) or flight number (for air freight) assigned to transport the shipment. Null for road or rail freight.',
    `voyage_number` STRING COMMENT 'Voyage number for ocean freight or flight number for air freight. Identifies the specific journey leg for the shipment.',
    CONSTRAINT pk_freight_booking PRIMARY KEY(`freight_booking_id`)
) COMMENT 'Records the formal booking of freight capacity with a carrier or freight forwarder for apparel shipments. Captures booking reference number, carrier/forwarder identity, service type (FCL, LCL, air charter, express courier), vessel or flight details, port of loading, port of discharge, booking date, cut-off date, confirmed space allocation, rate agreement reference, and booking status. Supports capacity planning and carrier performance management for seasonal collection launches.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` (
    `customs_entry_id` BIGINT COMMENT 'Unique identifier for the customs entry declaration record.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: Customs entries reference the bill of lading for the arriving cargo. N:1 relationship (multiple customs entry line items can reference one BOL). Normalizes bill_of_lading_number string to FK.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Customs entry records the carrier that transported the goods. Currently stored as carrier_code string; normalize to FK for referential integrity and to enable carrier performance analysis by customs c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Import duties are allocated to requesting departments for cost accountability. Cost center managers need visibility into duty costs for their purchase orders to manage budgets and explain variances.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Customs broker/specialist who filed entry must be tracked for regulatory compliance, CBP audits, and performance metrics. Required for trade compliance reporting and broker certification tracking in a',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Duty payments post to specific GL accounts for financial reporting. Month-end close requires customs duty accrual and payment posting to correct GL accounts for balance sheet and P&L accuracy.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Customs entries are filed for specific shipments arriving at port. N:1 relationship (multiple customs entries can relate to one consolidated shipment). Normalizes bill_of_lading_number which can be re',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Customs entries must reference sourcing PO for duty calculation, landed cost allocation, compliance documentation, and reconciling declared values with PO terms in apparel import operations.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Customs entries require supplier factory-of-origin for certificate-of-origin validation, GSP eligibility verification, factory-specific duty rates, and compliance with country-of-origin marking requir',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: Customs entries are filed by customs brokers, which are a type of 3PL service provider. N:1 relationship. Normalizes customs_broker_name and customs_broker_license_number to FK. The third_party_logist',
    `trade_compliance_record_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_record. Business justification: Every customs entry filing must reference the trade compliance classification that determined the declared HS code, duty rate, and origin. Core customs clearance workflow ensuring duty calculations ma',
    `arrival_date` DATE COMMENT 'Date when the vessel or aircraft arrived at the U.S. port. Establishes the timeline for entry filing and duty payment deadlines.',
    `bond_amount_usd` DECIMAL(18,2) COMMENT 'Face value of the customs bond in U.S. dollars. For single transaction bonds, typically 2-3 times the estimated duties. For continuous bonds, minimum $50,000 or 10% of duties paid in prior year, whichever is greater.',
    `bond_type` STRING COMMENT 'Type of customs bond securing the entry. Single: covers one transaction; Continuous: covers all transactions for one year (minimum $50,000); None: no bond required (e.g., informal entries under $2,500). Bonds guarantee payment of duties and compliance with regulations.. Valid values are `single|continuous|none`',
    `certificate_of_origin_number` STRING COMMENT 'Reference number of the certificate of origin document supporting the claimed country of origin and trade preference eligibility. Required for many FTA and GSP claims. Format varies by issuing authority.',
    `clearance_status` STRING COMMENT 'Current processing status of the customs entry. Filed: submitted to CBP; Accepted: entry accepted for processing; Hold: flagged for review; Exam: selected for physical or documentary examination; Released: goods authorized for delivery; Liquidated: final duty determination made; Cancelled: entry voided. [ENUM-REF-CANDIDATE: filed|accepted|hold|exam|released|liquidated|cancelled — 7 candidates stripped; promote to reference product]',
    `commercial_invoice_number` STRING COMMENT 'Reference number of the commercial invoice from the foreign seller. Primary document supporting the declared value and description of goods. Required for all formal entries.',
    `country_of_origin` STRING COMMENT 'Two-letter ISO 3166-1 alpha-2 country code identifying where the goods were manufactured, produced, or grown. Determines applicable duty rates and eligibility for trade preference programs. Critical for FTC country-of-origin labeling compliance for apparel.. Valid values are `^[A-Z]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this customs entry record was first created in the system. Represents initial data capture, not the customs filing date.',
    `declared_value_usd` DECIMAL(18,2) COMMENT 'Total declared customs value of the imported goods in U.S. dollars. Represents the transaction value (price paid or payable) adjusted for international freight, insurance, and other costs as required by customs valuation rules. Basis for duty calculation.',
    `duty_amount_usd` DECIMAL(18,2) COMMENT 'Total customs duty assessed on the entry in U.S. dollars. Calculated by applying the applicable tariff rate to the dutiable value. May be reduced or eliminated under trade preference programs.',
    `entry_filing_date` DATE COMMENT 'Date when the customs entry was officially filed with the customs authority. Critical for calculating duty payment deadlines and compliance with entry filing timelines.',
    `entry_number` STRING COMMENT 'Official customs entry number assigned by customs authority. Format: XXX-NNNNNNN-N (port code, sequential number, check digit). Required for all formal entries and used as the primary reference for customs clearance tracking and audit.. Valid values are `^[A-Z0-9]{3}-[0-9]{7}-[0-9]$`',
    `entry_summary_date` DATE COMMENT 'Date when the entry summary (CBP Form 7501) was filed with CBP. Must be filed within 10 working days of entry release. Contains final classification, valuation, and duty calculation.',
    `entry_type` STRING COMMENT 'Classification of customs entry based on value threshold and processing requirements. Formal entries required for shipments over $2,500 USD; informal for lower values; in-bond for goods in transit; warehouse for deferred duty payment; FTZ (Free Trade Zone) for goods entering foreign trade zones.. Valid values are `formal|informal|in-bond|warehouse|ftz`',
    `exam_type` STRING COMMENT 'Type of physical or documentary examination conducted by CBP or Partner Government Agency. Intensive: full container exam; Tailored: targeted inspection; Compliance: verification of entry accuracy; PGA: inspection by FDA, USDA, or other agency; None: no exam required.. Valid values are `intensive|tailored|compliance|pga|none`',
    `ftz_admission_number` STRING COMMENT 'Admission number assigned when goods are admitted into a Foreign Trade Zone. Allows duty deferral or elimination. Null if goods did not enter an FTZ.',
    `harbor_maintenance_fee_usd` DECIMAL(18,2) COMMENT 'Fee assessed at 0.125% of cargo value for commercial cargo shipped through identified U.S. ports. Used to fund harbor maintenance and dredging. Not applicable to air shipments.',
    `hold_reason_code` STRING COMMENT 'CBP-assigned code indicating the reason for entry hold or exam. Examples: 01 (intensive exam), 02 (tailored exam), 03 (compliance measurement), PGA (Partner Government Agency hold). Null if no hold.. Valid values are `^[A-Z0-9]{2,4}$`',
    `importer_of_record_name` STRING COMMENT 'Legal name of the entity responsible for ensuring imported goods comply with all laws and regulations and for paying duties, taxes, and fees. The IOR is legally liable for the accuracy of the customs declaration.',
    `importer_of_record_number` STRING COMMENT 'IRS-assigned Employer Identification Number (EIN) or CBP-assigned importer number used to identify the importer of record. Format: XX-NNNNNNN.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `isf_filing_number` STRING COMMENT 'Reference number for the ISF (10+2) filing submitted to CBP at least 24 hours before ocean cargo is loaded at foreign port. Required for all ocean shipments to the U.S. Links security data to the entry.',
    `line_item_count` STRING COMMENT 'Total number of line items (distinct HS code classifications) on this customs entry. Each line represents a different product classification with its own duty rate and origin.',
    `liquidation_date` DATE COMMENT 'Date when CBP made the final determination of duties, taxes, and fees owed. Liquidation typically occurs within 314 days of entry but may be extended. After liquidation, the entry is considered final unless protested.',
    `merchandise_processing_fee_usd` DECIMAL(18,2) COMMENT 'CBP-assessed fee for processing formal entries. Calculated as 0.3464% of entered value with minimum $27.75 and maximum $538.40 per entry (rates subject to periodic adjustment). Informal entries have fixed MPF rates.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this customs entry record was last updated. Tracks changes to entry status, liquidation, or other attributes throughout the entry lifecycle.',
    `payment_due_date` DATE COMMENT 'Date by which estimated duties, taxes, and fees must be paid to CBP. Typically 10 working days after entry release for non-periodic monthly statement filers. Late payment incurs interest charges.',
    `payment_method` STRING COMMENT 'Method used to pay customs duties and fees. ACH (Automated Clearing House): electronic funds transfer; Check: paper check; Statement: periodic monthly statement for approved importers; Bond: continuous customs bond for deferred payment; Other: alternative payment arrangements.. Valid values are `ach|check|statement|bond|other`',
    `port_of_entry_code` STRING COMMENT 'Four-digit Schedule D port code identifying the U.S. port where goods are entered for customs clearance. Examples: 2704 (Los Angeles/Long Beach), 4601 (New York/Newark), 5301 (Miami).. Valid values are `^[0-9]{4}$`',
    `port_of_unlading_code` STRING COMMENT 'Four-digit Schedule D port code identifying where goods were physically unloaded from the arriving vessel or aircraft. May differ from port of entry for in-bond shipments.. Valid values are `^[0-9]{4}$`',
    `protest_filed_indicator` BOOLEAN COMMENT 'Indicates whether a formal protest has been filed challenging CBPs liquidation decision. Protests must be filed within 180 days of liquidation. True if protest filed; False if no protest.',
    `reconciliation_indicator` BOOLEAN COMMENT 'Indicates whether this entry is filed under CBPs reconciliation program, which allows importers to file entries with estimated data and reconcile with final data within 15 months. True if reconciliation entry; False if standard entry.',
    `release_date` DATE COMMENT 'Date when CBP authorized release of the goods from customs custody, allowing delivery to the importer. Critical for calculating dwell time and measuring OTIF (On Time In Full) performance against carrier and 3PL (Third-Party Logistics) SLAs (Service Level Agreements).',
    `surety_code` STRING COMMENT 'Three-digit code identifying the surety company that issued the customs bond. Surety must be on the Treasury Departments list of approved sureties.. Valid values are `^[0-9]{3}$`',
    `total_quantity` DECIMAL(18,2) COMMENT 'Total quantity of goods covered by this entry, summed across all line items. Unit of measure varies by commodity (pieces, dozens, kilograms, square meters, etc.).',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms, including packaging. Used for freight calculation and certain duty assessments. Required for all entries.',
    `trade_program_code` STRING COMMENT 'Code identifying the trade preference program under which duty reduction or elimination is claimed. GSP (Generalized System of Preferences), USMCA (United States-Mexico-Canada Agreement), FTA (Free Trade Agreement), AGOA (African Growth and Opportunity Act), CBI (Caribbean Basin Initiative), ATPA (Andean Trade Preference Act), NONE (no preference claimed). [ENUM-REF-CANDIDATE: GSP|USMCA|FTA|AGOA|CBI|ATPA|NONE — 7 candidates stripped; promote to reference product]',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used to bring goods into the U.S. Ocean: vessel; Air: aircraft; Truck: highway; Rail: railroad; Courier: express consignment. Affects processing requirements and fee calculations.. Valid values are `ocean|air|truck|rail|courier`',
    `voyage_flight_number` STRING COMMENT 'Vessel voyage number or aircraft flight number on which the goods arrived. Links the entry to the specific conveyance manifest filed by the carrier.',
    CONSTRAINT pk_customs_entry PRIMARY KEY(`customs_entry_id`)
) COMMENT 'Manages customs clearance declarations for apparel and footwear imports and exports. Stores entry type (formal, informal, in-bond), entry number, filing date, port of entry, importer of record, customs broker, declared value, duty amount, applicable trade program (GSP, FTA), HS code references, country of origin, and clearance status. Tracks holds, exams, and release dates. Manages associated trade compliance documents including certificates of origin, commercial invoices, and ISF (10+2) filings as structured attributes. Critical for FTC labeling compliance and trade compliance reporting across all sourcing countries.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` (
    `hs_code_id` BIGINT COMMENT 'Unique identifier for the HS code record. Primary key.',
    `labeling_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.labeling_requirement. Business justification: HS codes trigger specific FTC labeling requirements by product category (textile, wool, fur) and jurisdiction. Customs clearance and retail compliance verification require matching HS classification t',
    `antidumping_duty_flag` BOOLEAN COMMENT 'Indicates whether this HS code is subject to antidumping duties for imports from specific countries due to unfair pricing practices.',
    `chapter` STRING COMMENT 'The two-digit chapter number of the HS code representing the broad product category (e.g., Chapter 61 for knitted apparel, Chapter 62 for woven apparel, Chapter 64 for footwear).. Valid values are `^[0-9]{2}$`',
    `countervailing_duty_flag` BOOLEAN COMMENT 'Indicates whether this HS code is subject to countervailing duties for imports from specific countries due to foreign government subsidies.',
    `cpsc_regulated_flag` BOOLEAN COMMENT 'Indicates whether products under this HS code are subject to CPSC safety standards and testing requirements (e.g., flammability standards for childrens sleepwear, lead content limits).',
    `cpsc_regulation_reference` STRING COMMENT 'Specific CPSC regulation citation applicable to this HS code (e.g., 16 CFR 1610 for flammability, 16 CFR 1501 for small parts). Null if not CPSC regulated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HS code record was first created in the system. Used for audit trail and data lineage tracking.',
    `duty_rate_unit` STRING COMMENT 'Indicates whether the duty rate is ad valorem (percentage of value), specific (per unit/weight), or compound (combination of both).. Valid values are `percentage|specific|compound`',
    `effective_from_date` DATE COMMENT 'The date from which this HS code classification and associated duty rates become effective. Critical for time-based duty calculations and compliance.',
    `effective_to_date` DATE COMMENT 'The date until which this HS code classification and duty rates remain valid. Null for currently active codes. Used to manage HS code changes during WCO amendment cycles.',
    `environmental_certification_required` STRING COMMENT 'Environmental or sustainability certifications required or recommended for products under this HS code (e.g., OEKO-TEX Standard 100, GOTS, BCI). Null if no specific requirements.',
    `ftc_labeling_required_flag` BOOLEAN COMMENT 'Indicates whether products under this HS code require FTC-mandated fiber content labeling, country of origin marking, or care labeling per Textile and Wool Acts.',
    `ftc_labeling_requirement` STRING COMMENT 'Specific FTC labeling requirements for this HS code including fiber content disclosure, country of origin, manufacturer identification, and care instructions. Null if not required.',
    `general_duty_rate` DECIMAL(18,2) COMMENT 'The standard Most Favored Nation (MFN) duty rate expressed as a percentage or specific rate applicable to imports from countries without preferential trade agreements. Used for Landed Duty Paid (LDP) calculations.',
    `gsp_beneficiary_countries` STRING COMMENT 'Comma-separated list of ISO 3-letter country codes eligible for GSP treatment for this HS code. Null if GSP not applicable.',
    `gsp_eligible_flag` BOOLEAN COMMENT 'Indicates whether this HS code is eligible for duty-free treatment under the US Generalized System of Preferences program when imported from designated beneficiary developing countries.',
    `heading` STRING COMMENT 'The four-digit heading number providing a more specific product classification within the chapter (e.g., 6109 for T-shirts, singlets, and other vests).. Valid values are `^[0-9]{4}$`',
    `hs_code` STRING COMMENT 'The full Harmonized System tariff classification code (6 to 10 digits) used for international trade classification of apparel, footwear, and accessories. This code determines duty rates, trade statistics, and regulatory requirements.. Valid values are `^[0-9]{6,10}$`',
    `hs_code_description` STRING COMMENT 'Full official description of the product classification including material composition, construction method, and intended use as defined by the Harmonized System nomenclature.',
    `hs_code_status` STRING COMMENT 'Current lifecycle status of this HS code. Active codes are used for current classifications. Deprecated codes have been replaced by new codes in HS updates. Superseded codes reference the replacement code. Pending codes are scheduled for future activation.. Valid values are `active|deprecated|superseded|pending`',
    `hs_version` STRING COMMENT 'The version year of the Harmonized System nomenclature (e.g., HS2017, HS2022) under which this code is classified. WCO updates the HS every 5 years.. Valid values are `^HS[0-9]{4}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this HS code record was last modified. Updated whenever duty rates, descriptions, or regulatory flags change. Critical for maintaining accurate duty calculations.',
    `national_extension` STRING COMMENT 'Additional digits beyond the 6-digit subheading added by individual countries for more granular classification (e.g., US uses 10-digit HTS codes). May be null for base 6-digit codes.',
    `notes` STRING COMMENT 'Additional notes, guidance, or special instructions for proper classification under this HS code including exclusions, inclusions, and edge cases. Used by customs brokers and compliance teams.',
    `origin_criteria` STRING COMMENT 'Rules of origin criteria that must be met for products under this HS code to qualify for preferential duty treatment (e.g., tariff shift rules, regional value content thresholds, substantial transformation tests).',
    `preferential_duty_rate` DECIMAL(18,2) COMMENT 'Reduced duty rate available under preferential trade agreements such as USMCA, GSP, or bilateral free trade agreements. Null if no preferential rate applies.',
    `restricted_flag` BOOLEAN COMMENT 'Indicates whether this HS code is subject to import or export restrictions, quotas, licensing requirements, or prohibitions by customs authorities.',
    `restriction_type` STRING COMMENT 'Type of restriction or special requirement applicable to this HS code. Null if restricted_flag is false.. Valid values are `quota|license|prohibition|embargo|antidumping|countervailing`',
    `section_301_duty_flag` BOOLEAN COMMENT 'Indicates whether this HS code is subject to additional Section 301 tariffs imposed on imports from specific countries (e.g., China tariffs).',
    `section_301_duty_rate` DECIMAL(18,2) COMMENT 'Additional duty rate percentage imposed under Section 301 trade actions. Null if not subject to Section 301 duties.',
    `short_description` STRING COMMENT 'Abbreviated description of the HS code for operational use in warehouse management, shipping documents, and internal systems.',
    `subheading` STRING COMMENT 'The six-digit subheading providing internationally standardized product classification. This is the minimum level required for international trade.. Valid values are `^[0-9]{6}$`',
    `superseded_by_hs_code` STRING COMMENT 'The new HS code that replaces this code when status is superseded. Used to maintain continuity during HS version transitions. Null for active codes.',
    `textile_category` STRING COMMENT 'Textile category classification used for quota administration and trade monitoring (historically used for Multi-Fiber Arrangement, still relevant for certain trade agreements).',
    `trade_agreement` STRING COMMENT 'Name of the trade agreement or preferential program under which the preferential duty rate applies (e.g., USMCA, GSP, CAFTA-DR, EU-FTA). Null if general duty rate applies.',
    `unit_of_quantity` STRING COMMENT 'The unit of measure required for statistical reporting and quota tracking for this HS code (e.g., dozens for shirts, pairs for footwear, kilograms for fabric).. Valid values are `pieces|dozens|kilograms|pairs|square_meters|linear_meters`',
    CONSTRAINT pk_hs_code PRIMARY KEY(`hs_code_id`)
) COMMENT 'Reference master for Harmonized System (HS) tariff classification codes applicable to apparel, footwear, and accessories. Stores HS code, chapter, heading, subheading, full description, applicable duty rate, preferential duty rates by trade agreement, restricted/prohibited flag, CPSC safety classification, FTC fiber content labeling requirement flag, and effective date range. Enables accurate duty calculation, GSP utilization, and customs entry filing across all import/export lanes.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` (
    `duty_calculation_id` BIGINT COMMENT 'Unique identifier for the duty calculation record. Primary key for the duty calculation transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Duty costs are allocated to cost centers for budgeting and variance analysis. Cost center managers track landed cost components against budget to manage total product acquisition costs by department.',
    `customs_entry_id` BIGINT COMMENT 'Foreign key linking to logistics.customs_entry. Business justification: Duty calculations are performed for specific customs entries. N:1 relationship (multiple duty calculations can exist per customs entry for different line items or recalculations). Normalizes customs_e',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Landed cost components (duty, freight, insurance) post to specific GL accounts. Month-end close requires duty calculations to post to correct GL accounts for COGS and inventory valuation accuracy.',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: Duty calculations use HS codes to determine duty rates. N:1 relationship to hs_code master table. Normalizes hs_code string and duty_rate_percentage which can be retrieved from hs_code.general_duty_ra',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the purchase order for which duty is being calculated. Links to the procurement transaction in SAP MM.',
    `employee_id` BIGINT COMMENT 'Reference to the system user or customs specialist who performed or approved the duty calculation.',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to production.factory. Business justification: Duty calculations require factory reference to determine country of origin for tariff classification, validate trade agreement eligibility (USMCA, GSP), and allocate landed costs back to production fa',
    `shipment_id` BIGINT COMMENT 'Reference to the inbound shipment associated with this duty calculation. Links to logistics shipment tracking in Manhattan Associates WMS.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Duty calculations are performed per sourcing PO to determine landed costs, allocate duty to specific SKU receipts, and reconcile with PO-level FOB values in apparel costing.',
    `third_party_logistics_id` BIGINT COMMENT 'Reference to the 3PL partner managing the logistics and customs clearance for this shipment.',
    `vendor_id` BIGINT COMMENT 'Reference to the licensed customs broker who prepared and submitted the customs entry and duty calculation.',
    `anti_dumping_duty_amount` DECIMAL(18,2) COMMENT 'Additional duty imposed to offset unfair pricing practices when goods are sold below fair market value. Applied on top of standard duties.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the duty calculation was approved for submission. Part of audit trail for compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `base_duty_amount` DECIMAL(18,2) COMMENT 'Standard import duty calculated by applying the duty rate percentage to the CIF value, before any trade preferences or additional duties.',
    `calculation_number` STRING COMMENT 'Business-readable unique identifier for the duty calculation, used for reference in customs documentation and financial reporting. Format: DC-XXXXXXXXXX.. Valid values are `^DC-[0-9]{10}$`',
    `calculation_status` STRING COMMENT 'Current lifecycle status of the duty calculation. Tracks progression from initial calculation through customs approval and payment reconciliation. [ENUM-REF-CANDIDATE: draft|calculated|submitted|approved|rejected|paid|reconciled — 7 candidates stripped; promote to reference product]',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when the duty calculation was performed. Critical for audit trail and compliance reporting. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cif_value` DECIMAL(18,2) COMMENT 'Total customs value including FOB value, freight, and insurance. The dutiable value upon which import duties and taxes are calculated.',
    `countervailing_duty_amount` DECIMAL(18,2) COMMENT 'Additional duty imposed to offset foreign government subsidies that unfairly benefit exporters. Applied on top of standard duties.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the goods were manufactured or produced. Determines eligibility for trade preferences and duty rates.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this duty calculation record was first created in the database. Part of audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this calculation (e.g., USD, EUR, GBP). All amounts are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `destination_country` STRING COMMENT 'Three-letter ISO country code indicating the country where goods are being imported. Determines applicable customs regulations and duty rates.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert foreign currency amounts to the reporting currency. Used when FOB value is in a different currency than destination.',
    `excise_tax_amount` DECIMAL(18,2) COMMENT 'Special excise taxes on specific product categories (e.g., luxury goods, alcohol, tobacco). Applied based on product classification.',
    `fob_value` DECIMAL(18,2) COMMENT 'The value of goods at the point of shipment, excluding freight and insurance. Base value for duty calculation before transportation costs.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost from origin to destination port. Added to FOB value to calculate CIF value for duty assessment.',
    `fta_claimed_flag` BOOLEAN COMMENT 'Indicates whether preferential duty treatment under a Free Trade Agreement was claimed. FTAs provide reduced or zero duty rates for qualifying goods.',
    `fta_name` STRING COMMENT 'Name of the specific Free Trade Agreement under which preferential treatment is claimed (e.g., USMCA, CAFTA-DR, Korea FTA).',
    `fta_reduction_amount` DECIMAL(18,2) COMMENT 'Duty reduction amount granted under FTA preferential treatment. Reduces the base duty amount when FTA eligibility is confirmed.',
    `gsp_claimed_flag` BOOLEAN COMMENT 'Indicates whether GSP preferential duty treatment was claimed for this shipment. GSP provides duty-free treatment for eligible products from developing countries.',
    `gsp_reduction_amount` DECIMAL(18,2) COMMENT 'Duty reduction amount granted under GSP preferential treatment. Reduces the base duty amount when GSP eligibility is confirmed.',
    `hmf_amount` DECIMAL(18,2) COMMENT 'U.S. fee assessed on cargo shipped through U.S. ports to fund harbor maintenance. Calculated as a percentage of cargo value.',
    `insurance_cost` DECIMAL(18,2) COMMENT 'Insurance premium for goods in transit. Added to FOB and freight to calculate CIF value for customs valuation.',
    `ldp_total_amount` DECIMAL(18,2) COMMENT 'Total landed cost including CIF value, all duties, taxes, and fees. Represents the complete cost to bring goods into the destination country.',
    `ldp_unit_cost` DECIMAL(18,2) COMMENT 'Per-unit landed cost calculated by dividing LDP total amount by quantity. Used for COGS calculation and margin analysis in SAP FI/CO.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this duty calculation record was last updated. Tracks data lineage and change history. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mpf_amount` DECIMAL(18,2) COMMENT 'U.S. Customs fee for processing imported merchandise. Calculated as a percentage of shipment value with minimum and maximum caps.',
    `notes` STRING COMMENT 'Free-text notes capturing special circumstances, assumptions, or clarifications related to the duty calculation. Used for audit trail.',
    `other_fees_amount` DECIMAL(18,2) COMMENT 'Miscellaneous customs fees, inspection charges, or regulatory fees not captured in standard duty and tax categories.',
    `payment_date` DATE COMMENT 'Actual date when duty and tax payment was made to customs authority. Used for reconciliation and cash flow tracking. Format: yyyy-MM-dd.',
    `payment_due_date` DATE COMMENT 'Date by which duty and tax payment must be made to customs authority to avoid penalties. Format: yyyy-MM-dd.',
    `payment_reference_number` STRING COMMENT 'Official payment confirmation or transaction reference number from customs authority or payment processor.',
    `port_of_entry` STRING COMMENT 'Official customs port or border crossing where goods entered the destination country. Impacts processing times and local regulations.',
    `quantity` DECIMAL(18,2) COMMENT 'Total quantity of units in the shipment for which duty is calculated. Used to derive per-unit landed costs.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation between calculated duty amounts and actual amounts paid or invoiced by customs. Tracks variance resolution.. Valid values are `pending|matched|variance|resolved`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the duty calculation was submitted to customs authorities. Critical for compliance and SLA tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `total_duty_amount` DECIMAL(18,2) COMMENT 'Sum of all duty components including base duty, anti-dumping, countervailing duties, less any GSP or FTA reductions. Excludes taxes and fees.',
    `total_fees_amount` DECIMAL(18,2) COMMENT 'Sum of all customs processing fees including MPF, HMF, and other regulatory fees.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Sum of all tax components including VAT, excise taxes, and other applicable import taxes.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field. Common values: EA (each), DZ (dozen), CS (case), KG (kilogram), LB (pound), M (meter), YD (yard). [ENUM-REF-CANDIDATE: EA|DZ|CS|KG|LB|M|YD — 7 candidates stripped; promote to reference product]',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between calculated duty amount and actual amount assessed by customs. Positive indicates underpayment, negative indicates overpayment.',
    `variance_reason` STRING COMMENT 'Explanation for any variance between calculated and actual duty amounts. Used for process improvement and dispute resolution.',
    `vat_amount` DECIMAL(18,2) COMMENT 'Import VAT or sales tax assessed on the total landed value including duties. Applicable in jurisdictions with VAT systems.',
    CONSTRAINT pk_duty_calculation PRIMARY KEY(`duty_calculation_id`)
) COMMENT 'Transactional record of landed duty paid (LDP) calculations performed for apparel purchase orders and shipments. Captures FOB value, freight cost, insurance, CIF value, applicable HS code, duty rate applied, GSP or FTA preference claimed, anti-dumping/countervailing duty amounts, MPF, HMF, total duty and tax, calculated LDP unit cost, and calculation timestamp. Feeds COGS and financial planning in Anaplan and SAP FI/CO for accurate margin management.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Unique identifier for the transportation carrier. Primary key for the carrier master record.',
    `api_integration_flag` BOOLEAN COMMENT 'Indicates whether the carrier provides API integration for real-time tracking, rate quotes, and booking automation (True/False).',
    `carrier_name` STRING COMMENT 'Full legal name of the transportation carrier or logistics service provider (e.g., Maersk Line, FedEx Corporation, United Parcel Service).',
    `carrier_status` STRING COMMENT 'Current operational and business relationship status of the carrier. Preferred carriers receive priority routing; approved carriers meet minimum standards; probation indicates performance issues under review; suspended carriers are temporarily blocked; inactive carriers are no longer used.. Valid values are `preferred|approved|probation|suspended|inactive`',
    `carrier_type` STRING COMMENT 'Primary classification of the carrier based on transportation mode: ocean shipping line, air freight carrier, ground less-than-truckload (LTL), ground full-truckload (FTL), rail operator, last-mile courier, third-party logistics provider (3PL), or freight forwarder. [ENUM-REF-CANDIDATE: ocean|air|ground_ltl|ground_ftl|rail|courier|3pl|freight_forwarder — 8 candidates stripped; promote to reference product]',
    `contract_effective_date` DATE COMMENT 'Date when the current carrier contract or service agreement became effective.',
    `contract_expiration_date` DATE COMMENT 'Date when the current carrier contract or service agreement expires. Null for open-ended or evergreen agreements.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the master service agreement or transportation contract governing the business relationship with this carrier.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for invoicing and payment transactions with this carrier (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `damage_claim_rate` DECIMAL(18,2) COMMENT 'Percentage of shipments handled by this carrier that resulted in damage claims. Lower rates indicate better handling quality.',
    `dot_number` STRING COMMENT 'US Department of Transportation identification number assigned to commercial motor carriers. Required for regulatory compliance and safety tracking.. Valid values are `^[0-9]{1,8}$`',
    `edi_capability_flag` BOOLEAN COMMENT 'Indicates whether the carrier supports EDI for automated booking, shipment status updates, and invoicing (True/False).',
    `geographic_coverage` STRING COMMENT 'Description of the geographic regions, countries, or trade lanes served by this carrier (e.g., North America, Trans-Pacific, Europe-Asia, Last-Mile USA).',
    `headquarters_address_line1` STRING COMMENT 'First line of the carriers headquarters street address.',
    `headquarters_city` STRING COMMENT 'City where the carriers headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the carriers headquarters location (e.g., USA, CHN, DEU).. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code of the carriers headquarters address.',
    `headquarters_state_province` STRING COMMENT 'State, province, or region where the carriers headquarters is located.',
    `iata_code` STRING COMMENT 'Two or three-character airline designator code assigned by IATA for air freight carriers.. Valid values are `^[A-Z0-9]{2,3}$`',
    `insurance_certificate_number` STRING COMMENT 'Certificate number of the carriers cargo insurance or liability insurance policy on file. Required for risk management and compliance.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum liability coverage amount provided by the carriers insurance policy, typically in USD. Used to assess risk exposure for high-value shipments.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the carriers current insurance certificate. Monitored to ensure continuous coverage.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the carrier is currently active and available for new shipment bookings (True) or inactive (False).',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review or scorecard evaluation of the carrier.',
    `mc_number` STRING COMMENT 'Motor Carrier operating authority number issued by FMCSA for interstate commerce in the United States.. Valid values are `^[0-9]{1,8}$`',
    `on_time_performance_score` DECIMAL(18,2) COMMENT 'Percentage score (0.00 to 100.00) representing the carriers on-time delivery performance based on historical shipment data. Used for carrier selection and routing optimization.',
    `onboarding_date` DATE COMMENT 'Date when the carrier was first onboarded and approved for use in the logistics network.',
    `otif_score` DECIMAL(18,2) COMMENT 'Percentage score (0.00 to 100.00) representing the carriers performance in delivering shipments both on time and in full (complete quantity, undamaged). Key performance indicator for carrier evaluation.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the carrier (e.g., Net 30, Net 45, Net 60, prepaid, upon delivery). Governs accounts payable processing.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the carrier for operational communication, booking confirmations, and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or account manager at the carrier organization.',
    `primary_contact_phone` STRING COMMENT 'Primary phone number of the carrier contact for urgent operational matters and escalations.',
    `scac_code` STRING COMMENT 'Unique two-to-four-letter code used to identify transportation companies in North America. Required for EDI transactions and customs documentation.. Valid values are `^[A-Z]{2,4}$`',
    `service_mode` STRING COMMENT 'Comma-separated list of service modes offered by the carrier (e.g., express, standard, economy, next-day, two-day, international, domestic, white-glove).',
    `short_name` STRING COMMENT 'Abbreviated or trade name of the carrier used in operational systems and documentation (e.g., Maersk, FedEx, UPS, DHL).',
    `sla_target_days` STRING COMMENT 'Standard number of days committed by the carrier for delivery under the service level agreement. Used for shipment planning and performance measurement.',
    `sustainability_certification` STRING COMMENT 'Environmental or sustainability certifications held by the carrier (e.g., SmartWay, ISO 14001, Carbon Neutral Certified). Supports corporate sustainability reporting.',
    `tax_identifier` STRING COMMENT 'Tax identification number (TIN, EIN, VAT number) of the carrier entity. Used for invoicing, tax reporting, and compliance.',
    `tracking_url_template` STRING COMMENT 'URL template for shipment tracking on the carriers website. Placeholder tokens (e.g., {tracking_number}) are replaced with actual shipment identifiers.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier record was last modified or updated.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record for all transportation carriers engaged by the apparel business — ocean shipping lines (Maersk, MSC, CMA CGM), air freight carriers, domestic LTL/FTL truckers, last-mile couriers (FedEx, UPS, DHL), and rail operators. Stores SCAC code, DOT number, carrier name, carrier type, service modes, contract reference, preferred/approved/probation status, insurance certificate, on-time performance score, and active status. SSOT for carrier identity referenced by freight bookings, shipments, routing guides, SLAs, and freight invoices.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` (
    `routing_guide_id` BIGINT COMMENT 'Unique identifier for the routing guide rule. Primary key.',
    `distribution_center_id` BIGINT COMMENT 'Reference to the destination distribution center, warehouse, or retail store receiving the shipment.',
    `lane_id` BIGINT COMMENT 'Reference to the transportation lane this routing guide applies to, linking origin-destination pairs.',
    `carrier_id` BIGINT COMMENT 'Reference to the preferred carrier assigned to this lane as the first choice for transportation.',
    `primary_routing_distribution_center_id` BIGINT COMMENT 'Reference to the specific origin facility, warehouse, or manufacturing plant from which shipments originate.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created this routing guide record.',
    `tertiary_routing_last_mile_carrier_id` BIGINT COMMENT 'Reference to the carrier responsible for final delivery to the destination, used for multi-leg shipments.',
    `third_party_logistics_id` BIGINT COMMENT 'Reference to the 3PL partner managing logistics execution for this routing guide, if applicable.',
    `carrier_contract_number` STRING COMMENT 'Reference number of the carrier contract governing rates and terms for this routing guide.',
    `compliance_required_flag` BOOLEAN COMMENT 'Indicates whether this routing guide has mandatory compliance requirements such as customs clearance, HS code validation, or GSP utilization.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for the cost per unit amount.. Valid values are `^[A-Z]{3}$`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard transportation cost per unit (carton, pallet, or weight unit) for this routing guide, used for cost control and budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing guide record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date after which this routing guide rule is no longer valid, allowing for seasonal or contract-based routing changes.',
    `effective_start_date` DATE COMMENT 'Date from which this routing guide rule becomes active and applicable for shipment planning.',
    `freight_terms` STRING COMMENT 'Payment and responsibility terms for freight charges, defining who pays transportation costs and when ownership transfers.. Valid values are `FOB|prepaid|collect|third_party|DDP|LDP`',
    `gsp_eligible_flag` BOOLEAN COMMENT 'Indicates whether this routing guide supports shipments eligible for GSP duty-free treatment under trade preference programs.',
    `guide_code` STRING COMMENT 'Business identifier for the routing guide rule, used for external reference and operational lookup.. Valid values are `^RG-[A-Z0-9]{6,12}$`',
    `guide_name` STRING COMMENT 'Descriptive name of the routing guide rule for business user identification.',
    `hs_code_validation_required` BOOLEAN COMMENT 'Flag indicating whether shipments using this routing guide must have validated HS codes for customs clearance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this routing guide record.',
    `ldp_calculation_required` BOOLEAN COMMENT 'Flag indicating whether landed cost calculations including duties, taxes, and fees must be computed for this routing guide.',
    `max_transit_days` STRING COMMENT 'Maximum number of calendar days allowed for shipment transit from origin to destination under this routing guide.',
    `minimum_shipment_volume` DECIMAL(18,2) COMMENT 'Minimum shipment volume or weight required to utilize this routing guide, enforcing carrier minimum order quantity (MOQ) requirements.',
    `mode_of_transport` STRING COMMENT 'Primary transportation method to be used for shipments following this routing guide.. Valid values are `ocean|air|truck|rail|intermodal|parcel`',
    `priority_rank` STRING COMMENT 'Numeric ranking to determine routing guide selection order when multiple guides match the same lane criteria (lower number = higher priority).',
    `routing_guide_status` STRING COMMENT 'Current lifecycle state of the routing guide rule, controlling whether it is available for shipment assignment.. Valid values are `active|inactive|pending|expired|suspended`',
    `routing_notes` STRING COMMENT 'Free-text field for additional routing instructions, special handling requirements, or operational notes for logistics teams.',
    `season_code` STRING COMMENT 'Apparel season identifier for which this routing guide is applicable (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).. Valid values are `^(SS|FW|HO|SP)[0-9]{2}$`',
    `service_level` STRING COMMENT 'Transportation service tier defining speed and priority of delivery for this routing guide.. Valid values are `standard|expedited|express|direct|economy`',
    `shipment_type` STRING COMMENT 'Classification of shipment flow direction and purpose within the supply chain network.. Valid values are `inbound|outbound|transfer|return|sample`',
    `sla_target_otif_percent` DECIMAL(18,2) COMMENT 'Target percentage for on-time and in-full delivery performance that carriers must meet under this routing guide.',
    `volume_uom` STRING COMMENT 'Unit of measure for minimum shipment volume (cartons, pallets, kilograms, pounds, cubic meters, cubic feet).. Valid values are `cartons|pallets|kg|lbs|cbm|cuft`',
    CONSTRAINT pk_routing_guide PRIMARY KEY(`routing_guide_id`)
) COMMENT 'Defines the approved transportation routing rules and carrier assignments for apparel shipments by lane, origin-destination pair, shipment type, and season. Captures lane origin region, destination DC or store, preferred carrier, backup carrier, service level (standard, expedite, direct), mode of transport, maximum transit days, freight terms (FOB, prepaid, collect), effective date range, and compliance requirement flag. Used by sourcing and logistics teams to enforce carrier compliance and cost controls.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` (
    `distribution_center_id` BIGINT COMMENT 'Unique identifier for the distribution center. Primary key for the distribution center entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each DC operates as a cost center for expense tracking. DC operating expenses (labor, utilities, rent, equipment) are tracked via cost center for budget variance analysis and cost-per-unit calculation',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: DCs may serve specific channels tracked as profit centers. Channel-specific DCs (wholesale vs DTC vs outlet) roll up operating costs to profit center P&L for true channel profitability analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: DC site manager is accountable for facility operations, workforce planning, and escalations. Essential for org charts, staffing models, and operational accountability in apparel distribution network m',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: Distribution centers are operated by 3PL providers. N:1 relationship (many DCs can be operated by one 3PL). Normalizes three_pl_provider_name string to FK for 3PL performance tracking and contract man',
    `address_line_1` STRING COMMENT 'Primary street address line for the distribution center facility. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit information. Organizational contact data classified as confidential.',
    `automation_level` STRING COMMENT 'Degree of warehouse automation deployed at the distribution center. Manual: labor-intensive operations. Semi-automated: conveyor systems and sortation. Fully automated: automated storage and retrieval systems (AS/RS). Robotic: autonomous mobile robots and advanced automation.. Valid values are `manual|semi_automated|fully_automated|robotic`',
    `bulk_storage_capacity_sqft` DECIMAL(18,2) COMMENT 'Square footage allocated to bulk pallet storage zone for high-volume inventory.',
    `city` STRING COMMENT 'City or municipality where the distribution center is located. Organizational contact data classified as confidential.',
    `cold_storage_capacity_sqft` DECIMAL(18,2) COMMENT 'Square footage allocated to temperature-controlled storage for specialty materials or products requiring climate control.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the distribution center location (e.g., USA, CAN, MEX, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution center record was first created in the system. Audit trail for data governance.',
    `customs_bonded_warehouse_flag` BOOLEAN COMMENT 'Indicates whether the distribution center is a customs bonded warehouse authorized to store imported goods before duties are paid. Critical for international trade and Landed Duty Paid (LDP) calculations.',
    `dc_code` STRING COMMENT 'Business identifier code for the distribution center used across operational systems and documentation. Externally-known unique code for facility identification.. Valid values are `^[A-Z0-9]{3,10}$`',
    `decommission_date` DATE COMMENT 'Date when the distribution center was decommissioned and ceased operations. Null for active facilities.',
    `email_address` STRING COMMENT 'Primary email contact for distribution center operations and coordination. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `facility_name` STRING COMMENT 'Official name of the distribution center or fulfillment facility.',
    `facility_type` STRING COMMENT 'Classification of the distribution center by operational model and purpose. Owned DC: company-owned distribution center. 3PL-operated: Third-Party Logistics (3PL) operated facility. Cross-dock: transshipment facility. Returns center: dedicated returns processing. Forward stocking location: regional inventory buffer. Fulfillment center: e-commerce order fulfillment.. Valid values are `owned_dc|3pl_operated|cross_dock|returns_center|forward_stocking_location|fulfillment_center`',
    `go_live_date` DATE COMMENT 'Date when the distribution center became operational and began processing inventory and shipments.',
    `hanging_storage_capacity_sqft` DECIMAL(18,2) COMMENT 'Square footage allocated to hanging garment storage on rails for apparel that requires hanging to maintain quality.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution center record was last updated. Audit trail for data governance and change tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the distribution center for routing, distance calculations, and network optimization.',
    `lease_expiration_date` DATE COMMENT 'Date when the facility lease expires for leased distribution centers. Null for owned facilities. Used for real estate planning and renewal negotiations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the distribution center for routing, distance calculations, and network optimization.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the distribution center (e.g., 24/7, Mon-Fri 6AM-6PM, Mon-Sat 8AM-8PM). Used for scheduling and service level planning.',
    `operational_status` STRING COMMENT 'Current operational state of the distribution center in the logistics network lifecycle.. Valid values are `active|inactive|seasonal|under_construction|decommissioned|temporarily_closed`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the distribution center facility. Organizational contact data classified as confidential.',
    `pick_zone_capacity_sqft` DECIMAL(18,2) COMMENT 'Square footage allocated to active picking zones for order fulfillment operations.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the distribution center address. Organizational contact data classified as confidential.',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether the distribution center is equipped with Radio Frequency Identification (RFID) technology for automated inventory tracking and visibility.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the distribution center location. Organizational contact data classified as confidential.',
    `supports_dtc_channel` BOOLEAN COMMENT 'Indicates whether this distribution center supports Direct-to-Consumer (DTC) e-commerce order fulfillment.',
    `supports_outlet_channel` BOOLEAN COMMENT 'Indicates whether this distribution center supports outlet store fulfillment for clearance and off-season merchandise.',
    `supports_retail_replenishment_channel` BOOLEAN COMMENT 'Indicates whether this distribution center supports replenishment shipments to company-owned retail stores.',
    `supports_wholesale_channel` BOOLEAN COMMENT 'Indicates whether this distribution center supports wholesale distribution to retail partners and department stores.',
    `sustainability_certification` STRING COMMENT 'Environmental or sustainability certifications held by the facility (e.g., LEED, ISO 14001, Carbon Neutral). Supports corporate sustainability reporting and compliance.',
    `throughput_capacity_units_per_day` STRING COMMENT 'Maximum daily processing capacity measured in units that can be received, stored, picked, packed, and shipped. Used for capacity planning and load balancing.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the distribution center location used for scheduling, cutoff times, and operational planning (e.g., America/New_York, Europe/London).',
    `total_square_footage` DECIMAL(18,2) COMMENT 'Total facility area in square feet including warehouse, office, and support spaces. Used for capacity planning and cost allocation.',
    `wms_instance_code` STRING COMMENT 'Identifier for the Manhattan Associates WMS instance managing this distribution center. Links facility to specific WMS deployment.',
    CONSTRAINT pk_distribution_center PRIMARY KEY(`distribution_center_id`)
) COMMENT 'Master record for all distribution centers, fulfillment centers, cross-dock facilities, and returns processing centers in the apparel logistics network. Captures DC code, facility name, full address, facility type (owned DC, 3PL-operated, cross-dock, returns center, forward stocking location), total square footage, storage capacity by zone (bulk, pick, hanging, cold), throughput capacity (units/day), WMS instance (Manhattan Associates), operating hours, supported channels (wholesale, DTC, retail replenishment, outlet), and active status. SSOT for facility identity referenced by inventory, shipment, and allocation processes.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` (
    `third_party_logistics_id` BIGINT COMMENT 'Primary key for third_party_logistics',
    `company_name` STRING COMMENT 'Legal registered name of the third-party logistics provider company.',
    `contract_reference` STRING COMMENT 'Reference identifier for the master service agreement or contract governing the relationship with this 3PL partner.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this 3PL partner record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial transactions with this 3PL partner (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customs_broker_license_number` STRING COMMENT 'Government-issued license number authorizing the 3PL partner to perform customs brokerage services. Applicable only when service_type includes customs brokerage.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet DUNS number uniquely identifying the 3PL partner organization for business credit and verification purposes.. Valid values are `^[0-9]{9}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether the 3PL partner supports EDI transaction sets for automated data exchange (warehouse shipping orders, shipment status, inventory advice).',
    `effective_end_date` DATE COMMENT 'Date when the 3PL partnership relationship ended or is scheduled to end. Null for ongoing relationships.',
    `effective_start_date` DATE COMMENT 'Date when the 3PL partnership relationship became or will become effective and operational.',
    `freight_forwarder_code` STRING COMMENT 'Standard Carrier Alpha Code (SCAC) or International Air Transport Association (IATA) code for the 3PL partner when acting as a freight forwarder.',
    `geographic_coverage` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing the regions where this 3PL partner operates and provides services (e.g., USA,CAN,MEX for North America coverage).',
    `headquarters_address_line1` STRING COMMENT 'First line of the street address for the 3PL partners headquarters or primary business office.',
    `headquarters_city` STRING COMMENT 'City where the 3PL partners headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the 3PL partners headquarters location (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the 3PL partners headquarters location.',
    `headquarters_state_province` STRING COMMENT 'State or province where the 3PL partners headquarters is located.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum liability insurance coverage amount in USD that the 3PL partner maintains for cargo loss, damage, or liability claims.',
    `last_audit_date` DATE COMMENT 'Date of the most recent operational or compliance audit conducted on this 3PL partners facilities and processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this 3PL partner record was last updated or modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next business review or performance evaluation of this 3PL partnership.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special handling instructions, or partnership-specific details about the 3PL provider.',
    `onboarding_status` STRING COMMENT 'Current lifecycle status of the 3PL partner relationship. Prospective indicates evaluation phase, onboarding indicates setup in progress, active indicates operational, suspended indicates temporary hold, terminated indicates contract ended, and inactive indicates no longer used.. Valid values are `prospective|onboarding|active|suspended|terminated|inactive`',
    `partner_code` STRING COMMENT 'Externally-known unique business identifier for the 3PL partner, used in EDI transactions, WMS integrations, and operational communications.. Valid values are `^[A-Z0-9]{4,12}$`',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days for invoices from this 3PL partner (e.g., 30, 45, 60 days net).',
    `performance_rating` DECIMAL(18,2) COMMENT 'Composite performance score (0.00 to 100.00) calculated from key metrics including On-Time In-Full (OTIF) delivery rate, order accuracy, damage rate, and responsiveness. Updated quarterly based on operational KPIs.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the 3PL partner for operational communications and escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or account manager at the 3PL partner organization.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact at the 3PL partner for urgent operational matters.',
    `quality_certification` STRING COMMENT 'Comma-separated list of quality management certifications held by the 3PL partner (e.g., ISO 9001, WRAP, FLA). [ENUM-REF-CANDIDATE: ISO_9001|ISO_14001|ISO_45001|WRAP|FLA|CTPAT|AEO|TAPA — promote to reference product]',
    `returns_processing_capable_flag` BOOLEAN COMMENT 'Indicates whether the 3PL partner has capabilities to process customer returns, including inspection, restocking, and disposition management.',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether the 3PL partners facilities are equipped with RFID technology for automated inventory tracking and shipment verification.',
    `service_type` STRING COMMENT 'Primary category of logistics services provided by the 3PL partner. Warehousing covers storage operations, fulfillment includes pick-pack-ship, freight forwarding manages international shipping, customs brokerage handles clearance and compliance, last-mile delivery covers final delivery to consumer, and integrated provides multiple service types.. Valid values are `warehousing|fulfillment|freight_forwarding|customs_brokerage|last_mile_delivery|integrated`',
    `sla_tier` STRING COMMENT 'Contractual service level tier defining performance commitments, response times, and quality standards for this 3PL partnership.. Valid values are `platinum|gold|silver|bronze|standard`',
    `sustainability_certified_flag` BOOLEAN COMMENT 'Indicates whether the 3PL partner holds recognized sustainability or environmental certifications (e.g., ISO 14001, SmartWay, LEED).',
    `tax_id_number` STRING COMMENT 'Tax identification number (EIN, VAT, GST) for the 3PL partner used for tax reporting and compliance.',
    `total_warehouse_sqft` DECIMAL(18,2) COMMENT 'Total warehouse storage capacity in square feet across all facilities operated by this 3PL partner.',
    `vendor_managed_inventory_flag` BOOLEAN COMMENT 'Indicates whether the 3PL partner participates in vendor-managed inventory programs where they monitor and replenish stock levels autonomously.',
    `warehouse_count` STRING COMMENT 'Total number of warehouse or distribution center facilities operated by this 3PL partner within their coverage regions.',
    `wms_integration_type` STRING COMMENT 'Technical integration method used to connect the 3PL partners WMS with internal systems. API indicates real-time REST/SOAP integration, EDI 940/945 uses standard warehouse transaction sets, flat file uses CSV/XML batch files, SFTP uses secure file transfer, and none indicates manual processes.. Valid values are `api|edi_940_945|flat_file|sftp|none`',
    CONSTRAINT pk_third_party_logistics PRIMARY KEY(`third_party_logistics_id`)
) COMMENT 'Master record for all third-party logistics (3PL) providers engaged to operate warehousing, fulfillment, transportation, or customs brokerage services for the apparel business. Stores 3PL partner identifier, company name, service type (warehousing, fulfillment, freight forwarding, customs brokerage, last-mile delivery), contract reference, geographic coverage regions, EDI capability flag, WMS integration type (API, EDI 940/945, flat file), SLA tier, composite performance rating, insurance coverage amount, onboarding status, and relationship effective dates. Distinct from the supplier domain which covers manufacturing vendors — this entity specifically governs logistics service providers. Note: PK uses legacy _3pl_partner_id naming convention pending infrastructure-level schema generation fix.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` (
    `sla_agreement_id` BIGINT COMMENT 'Unique identifier for the service level agreement record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SLA account manager negotiates carrier/3PL contracts and monitors performance. Required for accountability in vendor management, performance reviews, and escalation workflows in apparel logistics oper',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: SLA agreements with carriers define service level commitments. N:1 relationship. Adds dedicated FK for carrier-type SLAs to eliminate silo. counterparty_id and counterparty_type remain for polymorphic',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: SLA agreements with 3PL providers define warehouse and fulfillment service level commitments. N:1 relationship. Adds dedicated FK for 3PL-type SLAs. counterparty_id remains for other counterparty type',
    `vendor_id` BIGINT COMMENT 'Identifier of the logistics partner, carrier, or 3PL provider bound by this SLA.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the SLA automatically renews at expiration unless terminated by either party.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Monetary bonus amount per measurement period when SLA performance exceeds upper threshold.',
    `bonus_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for bonus amounts.. Valid values are `^[A-Z]{3}$`',
    `bonus_structure` STRING COMMENT 'Description of financial or operational incentives awarded when SLA targets are exceeded.',
    `breach_notification_flag` BOOLEAN COMMENT 'Indicates whether automated notifications are enabled when SLA thresholds are breached.',
    `contract_reference_number` STRING COMMENT 'Reference number of the master contract or agreement under which this SLA is governed.',
    `counterparty_type` STRING COMMENT 'Classification of the service provider bound by this SLA. 3PL = Third-Party Logistics.. Valid values are `3pl|carrier|freight_forwarder|customs_broker|warehouse|distribution_center`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA agreement record was first created in the system.',
    `destination_location_code` STRING COMMENT 'Code identifying the destination facility, port, or distribution center for lane-specific SLAs.. Valid values are `^[A-Z0-9]{3,10}$`',
    `effective_date` DATE COMMENT 'Date when the SLA agreement becomes active and enforceable.',
    `escalation_contact_email` STRING COMMENT 'Email address of the escalation contact for SLA performance issues.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_contact_name` STRING COMMENT 'Name of the primary contact person for SLA breach escalations and dispute resolution.',
    `escalation_contact_phone` STRING COMMENT 'Phone number of the escalation contact for urgent SLA breach notifications.',
    `expiration_date` DATE COMMENT 'Date when the SLA agreement expires or terminates. Null for open-ended agreements.',
    `measurement_frequency` STRING COMMENT 'Cadence at which SLA performance is measured and reported.. Valid values are `daily|weekly|monthly|quarterly|per_shipment|rolling_30_days`',
    `measurement_method` STRING COMMENT 'Description of how the metric is calculated, including data sources and calculation logic.',
    `metric_name` STRING COMMENT 'Name of the performance metric being measured (e.g., On-Time Delivery Rate, Transit Time, Damage Rate).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal SLA review meeting or assessment.',
    `notes` STRING COMMENT 'Additional free-text notes, special conditions, or exceptions related to this SLA agreement.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required to terminate or modify the SLA agreement.',
    `origin_location_code` STRING COMMENT 'Code identifying the origin facility, port, or distribution center for lane-specific SLAs.. Valid values are `^[A-Z0-9]{3,10}$`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount per breach or per measurement period when SLA is not met.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for penalty amounts.. Valid values are `^[A-Z]{3}$`',
    `penalty_structure` STRING COMMENT 'Description of financial or operational penalties applied when SLA targets are not met.',
    `reporting_system` STRING COMMENT 'Name of the system or platform used to track and report SLA performance metrics (e.g., Manhattan Associates WMS, EDI feed).',
    `review_cycle` STRING COMMENT 'Frequency at which the SLA terms and performance are formally reviewed by both parties.. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `scope_description` STRING COMMENT 'Detailed textual description of the lanes, facilities, regions, or service types covered by this SLA.',
    `scope_type` STRING COMMENT 'Defines the operational scope to which this SLA applies (e.g., specific shipping lane, warehouse facility, geographic region).. Valid values are `lane|facility|region|global|service_type`',
    `service_mode` STRING COMMENT 'Transportation mode covered by this SLA. LTL = Less Than Truckload, FTL = Full Truckload. [ENUM-REF-CANDIDATE: air|ocean|ground|rail|intermodal|parcel|ltl|ftl — 8 candidates stripped; promote to reference product]',
    `sla_agreement_status` STRING COMMENT 'Current lifecycle state of the SLA agreement.. Valid values are `draft|active|suspended|expired|terminated|under_review`',
    `sla_name` STRING COMMENT 'Human-readable name or title of the SLA agreement for easy identification.',
    `sla_number` STRING COMMENT 'Externally-known business identifier for the SLA agreement, used in contracts and communications.. Valid values are `^SLA-[A-Z0-9]{8,12}$`',
    `sla_type` STRING COMMENT 'Category of service level commitment being measured. OTIF = On Time In Full.. Valid values are `transit_time|otif|order_accuracy|damage_rate|customs_clearance|delivery_window`',
    `target_unit` STRING COMMENT 'Unit of measure for the target value (e.g., percentage for OTIF, days for transit time).. Valid values are `percentage|hours|days|count|rate`',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target or threshold value that the service provider commits to achieve.',
    `threshold_lower_bound` DECIMAL(18,2) COMMENT 'Minimum acceptable performance level before penalties or escalations are triggered.',
    `threshold_upper_bound` DECIMAL(18,2) COMMENT 'Performance level above which bonus or incentive structures may apply.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA agreement record was last modified.',
    CONSTRAINT pk_sla_agreement PRIMARY KEY(`sla_agreement_id`)
) COMMENT 'Defines the service level agreements governing logistics performance commitments between the apparel business and its 3PL partners, carriers, and distribution network nodes. Captures SLA type (transit time, OTIF, order accuracy, damage rate, customs clearance time), counterparty identity, applicable lane or facility scope, target metric value, measurement frequency, penalty structure, bonus structure, effective date range, and review cycle. Enables automated SLA breach detection and carrier scorecard generation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` (
    `return_shipment_id` BIGINT COMMENT 'Unique identifier for the return shipment record. Primary key for reverse logistics tracking.',
    `address_id` BIGINT COMMENT 'Identifier of the facility, store, or customer location from which the return shipment originates.',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier handling the return shipment transportation.',
    `circular_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_program. Business justification: Returns feed circular economy programs (resale, recycling, take-back initiatives). Linking enables tracking of product recovery rates, material circularity metrics, and circular program performance. E',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Return freight costs are charged to cost centers for accountability. Returns processing costs are allocated to responsible departments (customer service, quality, merchandising) to track and reduce re',
    `customs_entry_id` BIGINT COMMENT 'Foreign key linking to logistics.customs_entry. Business justification: International return shipments require customs entry for re-import or export. N:1 relationship. Normalizes customs_entry_number string to FK.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.quality_defect. Business justification: Returns cite specific defect codes for root cause analysis and trending. Standard process: return reason codes map to quality defect taxonomy for supplier scorecards and product improvement. Links ret',
    `distribution_center_id` BIGINT COMMENT 'Identifier of the distribution center, warehouse, or vendor facility receiving the returned merchandise.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Return freight and restocking fees post to specific GL accounts. Returns accounting requires GL posting for freight, restocking fees, and duty recovery to accurately reflect net revenue and COGS.',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: Return shipments crossing international borders require HS code classification. N:1 relationship. Normalizes hs_code string to FK.',
    `non_conformance_id` BIGINT COMMENT 'Foreign key linking to quality.non_conformance. Business justification: Returns often result from quality defects; NCR tracks root cause and supplier accountability. Standard process: customer returns trigger non-conformance reports for CAPA and supplier chargebacks. Link',
    `order_purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order for RTV (Return-to-Vendor) shipments returning defective or excess inventory to suppliers.',
    `shipment_id` BIGINT COMMENT 'Identifier of the original outbound shipment that delivered the items now being returned.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Returns due to safety failures (flammability, lead content, choking hazards) must link to the failed test record. Critical for product recall management, remediation tracking, and regulatory reporting',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to production.factory. Business justification: Returns shipped to factories for rework, inspection, or disposal require factory destination tracking for return authorization routing, factory rework capacity planning, and quality issue resolution w',
    `profile_id` BIGINT COMMENT 'Identifier of the customer initiating the return for consumer RMA shipments.',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Return shipments trigger quality inspections to determine disposition (restock, rework, scrap). Standard RMA workflow: all returns are inspected upon receipt to assess condition and determine credit e',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Returns coordinator processes RMA authorizations and manages disposition decisions. Essential for customer service accountability, returns processing metrics, and inventory control in apparel reverse ',
    `sales_order_id` BIGINT COMMENT 'Identifier of the original sales order or digital order associated with the items being returned.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: RTV shipments must reference original sourcing PO for vendor credit processing, quality defect tracking, and vendor performance scorecarding in apparel quality management and vendor compliance.',
    `third_party_logistics_id` BIGINT COMMENT 'Identifier of the 3PL partner managing the reverse logistics operations for this return shipment.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor receiving the RTV (Return-to-Vendor) shipment for defective or excess merchandise.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Returns linked to original work orders enable defect root cause analysis, production quality feedback loops, factory performance scoring based on return rates, and rework cost allocation to original p',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the return shipment was received at the destination facility. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `carton_count` STRING COMMENT 'Total number of cartons or packages in the return shipment.',
    `condition_grade` STRING COMMENT 'Quality grade assigned to returned merchandise: A (like new, resellable at full price), B (minor defects, resellable at discount), C (significant wear, outlet only), D (unsellable, dispose/donate).. Valid values are `A|B|C|D`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this return shipment record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cubic_volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the return shipment in cubic meters, used for freight cost calculation and capacity planning.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code of the return shipment destination facility.. Valid values are `^[A-Z]{3}$`',
    `destination_facility_type` STRING COMMENT 'Type of destination facility: distribution center, dedicated returns center, vendor location, refurbishment center, or outlet warehouse.. Valid values are `distribution_center|returns_center|vendor|refurbishment_center|outlet_warehouse`',
    `disposition_outcome` STRING COMMENT 'Final disposition decision for the returned merchandise: restock to primary inventory, refurbish for resale, transfer to outlet channel, donate to charity, destroy, or return to vendor.. Valid values are `restock|refurbish|outlet|donate|destroy|return_to_vendor`',
    `duty_amount` DECIMAL(18,2) COMMENT 'Customs duty amount paid or refunded for international return shipments, in the companys reporting currency.',
    `estimated_arrival_date` DATE COMMENT 'Estimated date when the return shipment is expected to arrive at the destination facility. Format: yyyy-MM-dd.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost incurred for the return shipment transportation, in the companys reporting currency.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the return shipment in kilograms, including packaging materials.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the return shipment was initiated by the customer, store, or vendor. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `inspection_completed_timestamp` TIMESTAMP COMMENT 'Date and time when quality inspection and condition grading of the returned items was completed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `item_count` STRING COMMENT 'Total number of individual items (SKUs) included in the return shipment.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this return shipment record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code of the return shipment origin location.. Valid values are `^[A-Z]{3}$`',
    `origin_location_type` STRING COMMENT 'Type of origin location: customer address, retail store, distribution center, vendor facility, or warehouse.. Valid values are `customer|retail_store|distribution_center|vendor|warehouse`',
    `priority_flag` BOOLEAN COMMENT 'Boolean indicator of whether this return shipment requires expedited processing due to high-value items, VIP customer status, or quality escalation. True for priority handling, False for standard processing.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total refund amount issued to the customer for the returned merchandise, in the companys reporting currency.',
    `restocking_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether the returned items are eligible for restocking into available-to-sell (ATS) inventory. True if items can be resold, False if they require alternative disposition.',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Restocking fee charged to the customer or deducted from refund, if applicable per return policy.',
    `return_authorization_number` STRING COMMENT 'Externally-known unique authorization number issued to approve the return. Format: RMA followed by 10 digits.. Valid values are `^RMA[0-9]{10}$`',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the reason for the return: fit issue, quality defect, wrong item shipped, customer changed mind, damaged in transit, or not as described.. Valid values are `fit_issue|quality_defect|wrong_item|changed_mind|damaged|not_as_described`',
    `return_reason_notes` STRING COMMENT 'Free-text notes providing additional context or details about the reason for the return.',
    `return_type` STRING COMMENT 'Classification of the return shipment: consumer RMA (customer return), RTV (Return-to-Vendor), store recall (store-to-DC consolidation), quality reject (failed inspection), warranty claim, or inter-facility transfer of returned goods.. Valid values are `consumer_rma|rtv|store_recall|quality_reject|warranty_claim|inter_facility_transfer`',
    `shipment_notes` STRING COMMENT 'Free-text operational notes or special handling instructions for the return shipment.',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the return shipment in the reverse logistics workflow.. Valid values are `initiated|in_transit|customs_clearance|delivered|cancelled|exception`',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the return shipment met the defined SLA for processing time and customer refund turnaround. True if compliant, False if SLA was breached.',
    `tracking_number` STRING COMMENT 'Unique tracking number provided by the carrier for shipment visibility and last-mile delivery tracking.',
    CONSTRAINT pk_return_shipment PRIMARY KEY(`return_shipment_id`)
) COMMENT 'Manages reverse logistics shipments for consumer returns, Return-to-Vendor (RTV), store-to-DC consolidation returns, and inter-facility transfers of returned apparel merchandise. Captures return authorization number, return type (consumer RMA, RTV, store recall, quality reject, warranty claim), origin location, destination DC or vendor, carrier, return reason code (fit, quality, wrong item, changed mind), item count, condition grade (A/B/C/D), restocking eligibility, and disposition outcome (restock, refurbish, outlet, donate, destroy). Critical for managing the 20-40% return rate typical in DTC apparel.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` (
    `freight_invoice_id` BIGINT COMMENT 'Unique identifier for the freight invoice record. Primary key.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Freight invoices from carriers become AP invoices for payment processing. Three-way match (freight booking, shipment, invoice) is required before payment approval to ensure accurate freight cost accru',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AP specialist reviews and approves freight invoices for payment. Required for financial controls, audit trails, and accounts payable workflow management in apparel logistics cost accounting.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: Freight invoices reference the bill of lading for the shipment being billed. N:1 relationship. Normalizes bill_of_lading_number and master_bill_of_lading_number strings to FK.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier or logistics service provider who issued this freight invoice. Links to the carrier master data.',
    `third_party_logistics_id` BIGINT COMMENT 'Reference to the 3PL provider if the invoice is from a third-party logistics partner rather than a direct carrier. Nullable if invoice is from direct carrier.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Freight costs are allocated to profit centers for channel P&L reporting. Profit center managers track freight spend against budget to calculate true channel profitability including all logistics costs',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Freight invoices are issued for specific shipments. N:1 relationship enables direct linkage from invoice to shipment for cost reconciliation and freight audit. shipment_reference_list remains as it ma',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Freight invoices for inbound shipments are matched to sourcing POs for landed cost allocation, accrual reconciliation, and validating freight charges against PO incoterms in apparel costing.',
    `accessorial_charges` DECIMAL(18,2) COMMENT 'Total amount of accessorial charges for additional services such as liftgate, inside delivery, residential delivery, limited access, redelivery, or special handling.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The amount approved for payment after freight audit and rate validation. May differ from total invoiced amount if discrepancies or disputes are identified.',
    `base_freight_charge` DECIMAL(18,2) COMMENT 'The base transportation charge before surcharges, accessorials, and adjustments. Core component of freight cost.',
    `billing_period_end_date` DATE COMMENT 'The end date of the billing period covered by this freight invoice. Used for consolidated invoices covering multiple shipments over a time range.',
    `billing_period_start_date` DATE COMMENT 'The start date of the billing period covered by this freight invoice. Used for consolidated invoices covering multiple shipments over a time range.',
    `container_number` STRING COMMENT 'The shipping container number for ocean freight shipments. ISO 6346 standard container identification.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'The contracted rate per unit (per kg, per shipment, per container) agreed with the carrier. Used for rate compliance validation during freight audit.',
    `cost_center_code` STRING COMMENT 'The cost center code to which this freight expense is allocated. Used for internal cost tracking and departmental budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this freight invoice record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this freight invoice. Used for multi-currency freight spend management.. Valid values are `^[A-Z]{3}$`',
    `customs_brokerage_fee` DECIMAL(18,2) COMMENT 'Fee charged by freight forwarder or customs broker for customs clearance services. Covers documentation, filing, and compliance activities.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code for the destination country of the shipment. Used for customs and trade compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'The code or identifier for the destination location of the shipment. May be facility code, port code, or airport code depending on transport mode.',
    `detention_demurrage_charges` DECIMAL(18,2) COMMENT 'Charges for detention (delay in returning equipment) or demurrage (delay in unloading cargo at port or terminal). Penalty charges for exceeding free time allowances.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator whether this freight invoice is under dispute. True if discrepancies have been identified and are being contested with the service provider.',
    `dispute_notes` STRING COMMENT 'Free-text notes documenting the details of the invoice dispute, including specific discrepancies identified and resolution actions taken.',
    `dispute_reason` STRING COMMENT 'The reason code for the invoice dispute. Categorizes the nature of the discrepancy or issue requiring resolution with the service provider. [ENUM-REF-CANDIDATE: rate_discrepancy|incorrect_charges|duplicate_invoice|service_failure|damaged_goods|missing_documentation|other — 7 candidates stripped; promote to reference product]',
    `due_date` DATE COMMENT 'The date by which payment is due to the service provider per the agreed payment terms. Used for cash flow planning and payables management.',
    `duty_amount` DECIMAL(18,2) COMMENT 'Total customs duty amount paid or payable on the imported goods covered by this freight invoice. Based on HS code classification and country of origin.',
    `fuel_surcharge` DECIMAL(18,2) COMMENT 'The fuel surcharge amount applied to the freight invoice. Variable charge based on fuel price indices.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this freight invoice is posted. Used for financial reporting and cost allocation.',
    `incoterm` STRING COMMENT 'The International Commercial Terms (Incoterms) code defining the division of costs and responsibilities between buyer and seller. Determines who pays freight charges. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_charge` DECIMAL(18,2) COMMENT 'Freight insurance charge for cargo coverage during transit. Protects against loss or damage to goods.',
    `invoice_date` DATE COMMENT 'The date the freight invoice was issued by the service provider. Principal business event timestamp for the invoice.',
    `invoice_number` STRING COMMENT 'The externally-known invoice number assigned by the carrier, freight forwarder, or 3PL provider. Business identifier for the freight invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the freight invoice in the accounts payable workflow. Tracks progression from receipt through audit, approval, dispute resolution, and payment. [ENUM-REF-CANDIDATE: received|under_audit|approved|disputed|rejected|paid|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the freight invoice document type. Standard invoices represent normal billing, credit memos represent refunds or adjustments, debit memos represent additional charges, pro forma are preliminary estimates, consolidated combine multiple shipments, and supplemental cover additional charges after initial billing.. Valid values are `standard|credit_memo|debit_memo|pro_forma|consolidated|supplemental`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this freight invoice record was last modified. Audit trail for record changes.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code for the origin country of the shipment. Used for customs and trade compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `origin_location_code` STRING COMMENT 'The code or identifier for the origin location of the shipment. May be facility code, port code, or airport code depending on transport mode.',
    `payment_date` DATE COMMENT 'The date payment was made to the service provider. Nullable if invoice is not yet paid.',
    `payment_reference_number` STRING COMMENT 'The payment document number or check number used for payment to the service provider. Links to accounts payable payment transaction.',
    `payment_status` STRING COMMENT 'Current payment status of the freight invoice in accounts payable. Tracks whether invoice has been paid, is pending payment, or is on hold.. Valid values are `unpaid|partially_paid|paid|on_hold|cancelled`',
    `purchase_order_reference` STRING COMMENT 'Reference to the purchase order number associated with the shipment(s) covered by this freight invoice. Used for three-way matching and cost allocation.',
    `service_level` STRING COMMENT 'The contracted service level for the transportation service. Impacts pricing and delivery commitments.. Valid values are `standard|expedited|express|economy|next_day|two_day`',
    `shipment_reference_list` STRING COMMENT 'Comma-separated list of shipment numbers or identifiers covered by this freight invoice. Links the invoice to one or more logistics shipments. May reference multiple shipments for consolidated invoices.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the freight invoice, including VAT, GST, or other applicable taxes on transportation services.',
    `total_invoiced_amount` DECIMAL(18,2) COMMENT 'The total amount invoiced by the service provider, including all charges, surcharges, fees, duties, and taxes. Sum of all charge components.',
    `transport_mode` STRING COMMENT 'The primary mode of transportation for the shipment(s) covered by this freight invoice. Determines applicable rate structures and service level expectations.. Valid values are `ocean|air|ground|rail|intermodal|courier`',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between total invoiced amount and approved amount. Represents overcharges, undercharges, or disputed amounts identified during freight audit.',
    CONSTRAINT pk_freight_invoice PRIMARY KEY(`freight_invoice_id`)
) COMMENT 'Records freight invoices and credit memos received from carriers, freight forwarders, and 3PL providers for transportation and logistics services rendered. Captures invoice number, service provider identity, invoice date, billing period, shipment references covered, charge breakdown (base freight, fuel surcharge, accessorial charges, detention/demurrage, customs fees), currency, total invoiced amount, approved amount after audit, variance from contracted rate, dispute flag and reason, payment status, and GL account coding. Feeds AP processing in SAP FI/CO, freight spend analytics, and carrier rate compliance reporting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` (
    `packing_list_id` BIGINT COMMENT 'Unique identifier for the packing list record. Primary key.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: Packing lists are covered by bills of lading. N:1 relationship (multiple packing lists can be consolidated under one BOL for container shipments). Normalizes bill_of_lading_number string to FK.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Packing lists for certified products (GOTS, OEKO-TEX, organic) must reference the certification for customs clearance and retail verification. Required documentation for certified shipments to prove c',
    `distribution_center_id` BIGINT COMMENT 'Reference to the distribution center or store where goods will be received. Used for inbound planning and receiving workflow.',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Packing lists reference final pre-shipment inspections conducted at factory before ex-factory date. Standard apparel process: inline or final inspections are documented and packing list certifies insp',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: Packing lists declare HS codes for the goods being shipped. N:1 relationship. Normalizes hs_code string to FK.',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that this packing list fulfills. Used for procurement reconciliation and three-way matching with invoice and receipt.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Packing lists show factory-of-origin for receiving verification, quality inspection routing by factory certification level, and factory performance tracking (packing accuracy, carton labeling complian',
    `packaging_sustainability_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_sustainability. Business justification: Packing materials used per shipment link to packaging sustainability metrics. Enables tracking of recycled content usage, plastic reduction targets, FSC-certified material adoption, and EPR compliance',
    `primary_packing_distribution_center_id` BIGINT COMMENT 'Reference to the manufacturing facility or warehouse where goods were packed. Used for sourcing analytics and quality traceability.',
    `employee_id` BIGINT COMMENT 'Reference to the user or employee who prepared and finalized this packing list. Used for accountability and audit trail.',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to production.factory. Business justification: Packing lists originate from factories and require factory reference for customs country-of-origin documentation, certificate of origin validation, factory compliance audit trails, and GSP eligibility',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment that this packing list documents. Links to the logistics shipment record for transportation and customs tracking.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Packing lists document what was shipped against sourcing PO; critical for receiving reconciliation, discrepancy management, and validating ordered vs. shipped quantities in apparel receiving operation',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturer who prepared this packing list. Used for vendor performance tracking and compliance auditing.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Packing lists document finished goods from specific work orders. Work order linkage enables production-to-shipment quantity reconciliation, quality traceability from production defects to shipped unit',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the packing list was approved for shipment. Used for workflow tracking and SLA monitoring.',
    `carton_label_format` STRING COMMENT 'Barcode or label standard used on cartons. GS1-128 for standard supply chain labels, SSCC for serial shipping container codes, UCC-128 for legacy format, custom for proprietary labels.. Valid values are `gs1_128|sscc|ucc_128|custom`',
    `certificate_of_origin_number` STRING COMMENT 'Reference number of the certificate of origin document accompanying this shipment. Required for preferential trade agreement claims and customs clearance.',
    `commercial_invoice_number` STRING COMMENT 'Reference number of the commercial invoice associated with this packing list. Used for customs valuation and financial reconciliation.',
    `container_number` STRING COMMENT 'Unique ISO 6346 container identification number for ocean freight shipments. Used for container tracking and customs clearance.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `container_type` STRING COMMENT 'Type of shipping container or transport mode used. 20ft/40ft/40ft_hc for standard ocean containers, lcl for less-than-container-load, air_freight for air shipments, truck for ground transport.. Valid values are `20ft|40ft|40ft_hc|lcl|air_freight|truck`',
    `country_of_origin_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating where the goods were manufactured or substantially transformed. Used for GSP eligibility and trade agreement compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this packing list record was first created in the system. Used for audit trail and data lineage.',
    `discrepancy_notes` STRING COMMENT 'Free-text description of any receiving discrepancies, damages, or quality issues identified. Used for supplier performance tracking and claims processing.',
    `gsp_eligible_flag` BOOLEAN COMMENT 'Indicates whether the goods qualify for GSP duty-free treatment. True if eligible for preferential tariff rates under GSP program.',
    `incoterm` STRING COMMENT 'Incoterms 2020 rule defining the division of costs and risks between buyer and seller. Common values: FOB (Free on Board), CIF (Cost Insurance Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the invoice value. Used for foreign exchange conversion and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this packing list record was last modified. Used for change tracking and data freshness monitoring.',
    `notes` STRING COMMENT 'General free-text notes or comments about this packing list. Used for additional context, special instructions, or operational remarks.',
    `packing_date` DATE COMMENT 'Date when the goods were physically packed and the packing list was prepared. Used for lead time calculation and production schedule tracking.',
    `packing_list_number` STRING COMMENT 'Externally-known unique business identifier for the packing list document. Used for customs clearance, DC receiving, and cross-referencing with commercial invoice and bill of lading.. Valid values are `^PL-[A-Z0-9]{8,12}$`',
    `packing_list_status` STRING COMMENT 'Current lifecycle status of the packing list document. Draft indicates in-progress, finalized means ready for shipment, submitted means sent to customs/receiver, received means acknowledged by DC, discrepancy indicates receiving variance, closed means reconciled.. Valid values are `draft|finalized|submitted|received|discrepancy|closed`',
    `packing_list_type` STRING COMMENT 'Classification of packing list document. Master for container-level summary, detailed for SKU-level breakdown, consolidated for multi-PO shipments, sample for pre-production shipments.. Valid values are `master|detailed|consolidated|sample`',
    `packing_method` STRING COMMENT 'Method used to pack the apparel or footwear goods. Flat pack for folded garments, hanging for garments on hangers, polybag for individual poly-bagged items, boxed for footwear in shoeboxes, mixed for combination methods.. Valid values are `flat_pack|hanging|polybag|boxed|mixed`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether goods in this packing list require quality inspection upon receipt. True if inspection is mandatory before putaway.',
    `quarantine_hold_flag` BOOLEAN COMMENT 'Indicates whether goods must be placed in quarantine hold upon receipt pending inspection or compliance verification. True if quarantine is required.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the packing list was acknowledged as received at the destination facility. Used for OTIF compliance and transit time calculation.',
    `receiving_discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was identified during receiving (quantity variance, damage, quality issue). True if discrepancy exists and requires resolution.',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether cartons in this packing list are tagged with RFID labels for automated scanning at DC receiving. True if RFID tags are applied.',
    `seal_number` STRING COMMENT 'Security seal number applied to the container or truck. Used for tamper detection and customs security verification.',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements such as fragile items, temperature control, hazmat, or security protocols. Used by warehouse and logistics teams.',
    `total_carton_count` STRING COMMENT 'Total number of cartons or packages included in this packing list. Used for receiving verification and freight planning.',
    `total_cubic_volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment measured in cubic meters. Used for container utilization analysis and dimensional weight pricing.',
    `total_gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment including packaging materials, measured in kilograms. Used for freight cost calculation and carrier capacity planning.',
    `total_invoice_value` DECIMAL(18,2) COMMENT 'Total declared value of goods on the commercial invoice for this packing list. Used for customs valuation, duty calculation, and insurance coverage.',
    `total_net_weight_kg` DECIMAL(18,2) COMMENT 'Total net weight of the goods excluding packaging materials, measured in kilograms. Used for customs valuation and duty calculation.',
    `total_pallet_count` STRING COMMENT 'Total number of pallets included in this packing list. Used for warehouse space planning and material handling resource allocation.',
    `total_unit_quantity` STRING COMMENT 'Total number of individual units (pieces) across all SKUs in this packing list. Used for inventory reconciliation and PO fulfillment verification.',
    CONSTRAINT pk_packing_list PRIMARY KEY(`packing_list_id`)
) COMMENT 'Shipping document record capturing the detailed contents of each shipment carton or container for apparel and footwear exports. Stores packing list number, associated shipment reference, carton count, total units, SKU-level breakdown (style, color, size, quantity per carton), gross weight, net weight, cubic measurement, carton dimensions, and packing method (flat pack, hanging, polybag). Required for customs clearance, DC receiving, and RFID-enabled carton scanning at Manhattan Associates WMS.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` (
    `bill_of_lading_id` BIGINT COMMENT 'Unique identifier for the bill of lading record. Primary key.',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: BOL documents freight movements and transport legs. Linking enables carbon footprint calculation per shipment leg for Scope 3 Category 4 (upstream transport) and Category 9 (downstream distribution) r',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier company responsible for moving the cargo.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Bills of lading for certified shipments must reference certifications for customs clearance and audit trail. Ensures certified products maintain chain of custody documentation throughout international',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to logistics.hs_code. Business justification: Bills of lading declare HS codes for the commodity being transported. N:1 relationship. Normalizes hs_code string to FK.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: BOL requires factory origin for customs documentation accuracy, certificate-of-origin cross-validation, and freight consolidation planning by factory location. Factory address on BOL must match suppli',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to production.factory. Business justification: Bills of lading document shipments from factory origins. Factory reference required for customs shipper verification, freight audit allocation to production facilities, and compliance with factory-spe',
    `shipment_id` BIGINT COMMENT 'Reference to the associated logistics shipment record tracked in the warehouse management system.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Shipping coordinator prepares and validates BOL documents for export/import compliance. Required for audit trails, customs documentation accountability, and trade compliance reporting in apparel inter',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: Bills of lading reference the freight forwarder arranging the shipment. Freight forwarders are a type of 3PL. N:1 relationship. freight_forwarder_reference is kept as it represents a transaction-speci',
    `bol_number` STRING COMMENT 'Externally-known unique document number issued by the carrier for this shipment. Required for customs entry filing and letter of credit negotiation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `bol_status` STRING COMMENT 'Current lifecycle status of the BOL document and associated shipment.. Valid values are `draft|issued|in_transit|delivered|surrendered|cancelled`',
    `bol_type` STRING COMMENT 'Classification of the BOL document type indicating release method and legal status. Original requires physical document for cargo release; telex/express allow electronic release.. Valid values are `original|telex_release|express_release|seaway_bill|house|master`',
    `commercial_invoice_number` STRING COMMENT 'Reference number of the associated commercial invoice required for customs clearance and letter of credit negotiation.',
    `commodity_description` STRING COMMENT 'Detailed description of the apparel cargo being shipped, including product type, material composition, and any special characteristics. Required for customs classification.',
    `consignee_address` STRING COMMENT 'Complete delivery address of the consignee including street, city, state/province, postal code, and country.',
    `consignee_name` STRING COMMENT 'Legal name of the party to whom the goods are being shipped and who will take title upon delivery.',
    `container_number` STRING COMMENT 'ISO 6346 standard eleven-character identifier for the shipping container, consisting of four-letter owner code and seven-digit serial number with check digit.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 code identifying the country where the apparel goods were manufactured or substantially transformed. Required for customs entry and GSP determination.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOL record was first created in the system.',
    `cubic_volume_m3` DECIMAL(18,2) COMMENT 'Total volumetric measurement of the cargo in cubic meters, used for dimensional weight pricing and container utilization planning.',
    `declared_value` DECIMAL(18,2) COMMENT 'Total commercial value of the cargo declared for insurance and customs purposes. Used to calculate duty, insurance premiums, and carrier liability limits.',
    `declared_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the declared cargo value.. Valid values are `^[A-Z]{3}$`',
    `freight_forwarder_reference` STRING COMMENT 'Internal reference number assigned by the freight forwarder or customs broker managing this shipment.',
    `freight_terms` STRING COMMENT 'Indicates whether freight charges are prepaid by shipper, collect from consignee, or billed to a third party. Critical for customs valuation.. Valid values are `prepaid|collect|third_party`',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the cargo including packaging materials, measured in kilograms. Required for freight cost calculation and customs declaration.',
    `gsp_eligible_flag` BOOLEAN COMMENT 'Indicates whether this shipment qualifies for duty-free treatment under GSP based on origin country and HS code. Critical for landed duty paid calculation.',
    `incoterm` STRING COMMENT 'Three-letter Incoterms 2020 code defining the division of costs, risks, and responsibilities between buyer and seller in international trade. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'Date when the carrier issued the BOL and acknowledged receipt of cargo. Critical for letter of credit compliance and title transfer timing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOL record was last updated, tracking document amendments and corrections.',
    `letter_of_credit_number` STRING COMMENT 'Reference number of the letter of credit under which this shipment is being financed. BOL must be presented to bank for LC negotiation.',
    `notify_party_contact` STRING COMMENT 'Phone number or email address for the notify party to coordinate cargo release and customs clearance.',
    `notify_party_name` STRING COMMENT 'Name of the party to be notified upon cargo arrival, often a customs broker or freight forwarder acting on behalf of the consignee.',
    `package_count` STRING COMMENT 'Total count of cartons, boxes, pallets, or other shipping units included in this BOL. Used for cargo verification and tally.',
    `package_type` STRING COMMENT 'Type of packaging used for the apparel cargo, with special handling codes for hanging garments and fragile accessories. [ENUM-REF-CANDIDATE: carton|pallet|crate|bundle|roll|hanging_garment|polybag — 7 candidates stripped; promote to reference product]',
    `place_of_delivery` STRING COMMENT 'Final destination location where the carrier will deliver the cargo to the consignee, which may differ from port of discharge.',
    `place_of_receipt` STRING COMMENT 'Location where the carrier first received the cargo from the shipper, which may differ from port of loading for multimodal transport.',
    `port_of_discharge_code` STRING COMMENT 'UN/LOCODE five-character code identifying the port or location where cargo will be unloaded from the vessel or vehicle.. Valid values are `^[A-Z]{5}$`',
    `port_of_loading_code` STRING COMMENT 'UN/LOCODE five-character code identifying the port or location where cargo was loaded onto the vessel or vehicle.. Valid values are `^[A-Z]{5}$`',
    `purchase_order_number` STRING COMMENT 'Buyers purchase order number associated with this shipment, used for order matching and accounts payable reconciliation.',
    `seal_number` STRING COMMENT 'Unique identifier of the security seal applied to the container or cargo, used to verify cargo integrity and detect tampering.',
    `shipper_address` STRING COMMENT 'Complete address of the shipper including street, city, state/province, postal code, and country.',
    `shipper_name` STRING COMMENT 'Legal name of the party shipping the goods, typically the manufacturer or exporter. Appears on customs documentation.',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for carrier regarding special handling requirements such as hanging garments, fragile accessories, temperature control, or hazardous materials.',
    `vessel_name` STRING COMMENT 'Name of the ocean vessel, aircraft, truck, or rail car transporting the cargo. Required for ocean and air BOLs.',
    `voyage_number` STRING COMMENT 'Voyage number for ocean shipments or flight number for air cargo, identifying the specific transport journey.',
    CONSTRAINT pk_bill_of_lading PRIMARY KEY(`bill_of_lading_id`)
) COMMENT 'Legal shipping document issued by a carrier acknowledging receipt of apparel cargo for transport. Captures BOL number, shipper, consignee, notify party, carrier, vessel or vehicle details, port of loading, port of discharge, freight terms (prepaid/collect), commodity description, HS code reference, declared value, number of packages, gross weight, special handling instructions (e.g., hanging garments, fragile accessories), original/telex/express release status, and associated commercial invoice reference. Required for customs entry filing, title transfer, and letter of credit negotiation in international apparel trade.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` (
    `carrier_service_agreement_id` BIGINT COMMENT 'Unique identifier for this carrier-factory service agreement. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier providing transportation services under this agreement',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to the factory being served by the carrier under this agreement',
    `agreement_status` STRING COMMENT 'Current operational status of this carrier-factory service agreement (active, suspended, expired, pending, terminated).',
    `contracted_rate` DECIMAL(18,2) COMMENT 'Negotiated freight rate for this carrier-factory service agreement. Rate is specific to the carrier-factory combination and service level. Explicitly identified in detection reasoning as relationship data.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this carrier-factory service agreement record was created in the system.',
    `destination_location` STRING COMMENT 'Destination location, port, or distribution center covered by this service agreement.',
    `effective_date` DATE COMMENT 'Date when this carrier-factory service agreement becomes effective. Explicitly identified in detection reasoning as relationship data.',
    `expiration_date` DATE COMMENT 'Date when this carrier-factory service agreement expires. Null for open-ended agreements. Explicitly identified in detection reasoning as relationship data.',
    `lane_priority` STRING COMMENT 'Priority ranking for this carrier on this factory lane (1=first choice, 2=backup, etc.). Used in routing guide logic for freight booking decisions. Explicitly identified in detection reasoning as relationship data.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this carrier-factory service agreement record was last modified.',
    `minimum_volume_commitment` DECIMAL(18,2) COMMENT 'Minimum shipment volume commitment required under this agreement (if applicable). Null if no minimum commitment.',
    `notes` STRING COMMENT 'Free-text notes or special terms specific to this carrier-factory service agreement.',
    `origin_location` STRING COMMENT 'Specific origin location or port for this service agreement (may be more specific than factory address, e.g., nearest port or pickup point).',
    `rate_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the contracted rate (e.g., USD, EUR, CNY). Required to interpret contracted_rate correctly.',
    `rate_unit` STRING COMMENT 'Unit of measure for the contracted rate (per_kg, per_cbm, per_container, per_shipment, per_pallet). Required to interpret contracted_rate correctly.',
    `service_level` STRING COMMENT 'Contracted service level for this carrier-factory lane (express, standard, economy, premium, dedicated). Explicitly identified in detection reasoning as relationship data.',
    `transit_days` STRING COMMENT 'Committed transit time in days from factory pickup to destination delivery for this carrier-factory service agreement. Explicitly identified in detection reasoning as relationship data.',
    `volume_unit` STRING COMMENT 'Unit of measure for minimum volume commitment (kg, cbm, containers, shipments, pallets).',
    CONSTRAINT pk_carrier_service_agreement PRIMARY KEY(`carrier_service_agreement_id`)
) COMMENT 'This association product represents the contractual service agreement between a carrier and a factory for freight transportation services. It captures lane-specific routing arrangements, negotiated rates, service level commitments, and transit time expectations. Each record links one carrier to one factory with attributes that exist only in the context of this specific service relationship, enabling routing guide configuration and freight booking decisions.. Existence Justification: In apparel fashion logistics, factories ship finished goods via multiple carriers depending on destination, mode (ocean/air/truck), cost, and service level requirements. Carriers serve multiple factories across their network. The business actively manages carrier-factory service agreements that specify lane-specific negotiated rates, transit times, service levels, and priority rankings. These agreements are referenced by routing guides to make freight booking decisions.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`lane` (
    `lane_id` BIGINT COMMENT 'Primary key for lane',
    `carrier_id` BIGINT COMMENT 'Primary carrier assigned to service this lane.',
    `contract_id` BIGINT COMMENT 'Identifier for the carrier contract governing rates and terms for this lane.',
    `destination_location_distribution_center_id` BIGINT COMMENT 'Identifier for the destination location (warehouse, distribution center, store, or port) where shipments end.',
    `distribution_center_id` BIGINT COMMENT 'Identifier for the origin location (warehouse, distribution center, or port) where shipments begin.',
    `third_party_logistics_id` BIGINT COMMENT 'Identifier for the 3PL partner managing logistics operations for this lane.',
    `return_lane_id` BIGINT COMMENT 'Self-referencing FK on lane (return_lane_id)',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'Standard base freight rate for this lane before surcharges and adjustments.',
    `capacity_volume_cbm` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity available on this lane per shipment cycle, measured in cubic meters.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity available on this lane per shipment cycle, measured in kilograms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lane record was first created in the system.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code for the destination location.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance of the lane route measured in kilometers.',
    `effective_end_date` DATE COMMENT 'Date when this lane configuration expires or is no longer available for shipment routing.',
    `effective_start_date` DATE COMMENT 'Date when this lane configuration becomes active and available for shipment routing.',
    `gsp_eligible` BOOLEAN COMMENT 'Indicates whether this lane qualifies for GSP duty-free treatment under trade preference programs.',
    `hazmat_approved` BOOLEAN COMMENT 'Indicates whether this lane is approved for transporting hazardous materials.',
    `incoterm` STRING COMMENT 'Standard Incoterm that defines responsibility and risk transfer for shipments on this lane.',
    `landed_duty_paid` BOOLEAN COMMENT 'Indicates whether the lane rate includes all duties, taxes, and customs fees (LDP calculation).',
    `lane_code` STRING COMMENT 'Business identifier code for the lane, typically combining origin and destination codes.',
    `lane_name` STRING COMMENT 'Human-readable name of the shipping lane, typically origin to destination description.',
    `lane_type` STRING COMMENT 'Classification of the lane based on geographic scope and routing characteristics.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lane record was last updated.',
    `last_rate_update_date` DATE COMMENT 'Date when the lane rate was last updated or renegotiated.',
    `notes` STRING COMMENT 'Additional operational notes, restrictions, or special handling instructions for this lane.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO currency code for the lane rate.',
    `rate_unit_of_measure` STRING COMMENT 'Unit of measure basis for the lane rate calculation.',
    `requires_customs_clearance` BOOLEAN COMMENT 'Indicates whether shipments on this lane require customs clearance procedures.',
    `routing_guide_priority` STRING COMMENT 'Priority ranking of this lane in the routing guide for shipment allocation decisions.',
    `service_level` STRING COMMENT 'Speed and priority classification for shipments on this lane.',
    `sla_on_time_delivery_pct` DECIMAL(18,2) COMMENT 'Target percentage for on-time delivery performance as defined in the carrier SLA for this lane.',
    `lane_status` STRING COMMENT 'Current operational status of the lane in the routing network.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether this lane provides temperature-controlled transport capabilities.',
    `transit_time_days` DECIMAL(18,2) COMMENT 'Standard transit time for shipments on this lane, measured in days.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for this lane.',
    CONSTRAINT pk_lane PRIMARY KEY(`lane_id`)
) COMMENT 'Master reference table for lane. Referenced by lane_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`logistics`.`contract` (
    `contract_id` BIGINT COMMENT 'Primary key for contract',
    `master_contract_id` BIGINT COMMENT 'Self-referencing FK on contract (master_contract_id)',
    `approval_status` STRING COMMENT 'Current approval status of the contract in the internal approval workflow.',
    `approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved this contract. Nullable if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the contract was approved. Nullable if not yet approved.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of its term unless terminated.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'Base rate or minimum charge amount per unit of service (per shipment, per container, per kilogram, etc.) as negotiated in the contract.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the contract, used in communications with carriers, 3PLs, and freight forwarders.',
    `contract_owner_employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing and overseeing this contract.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract indicating its operational state.',
    `contract_type` STRING COMMENT 'Classification of the logistics contract by service provider type: carrier (transportation), 3PL (third-party logistics), freight forwarder, customs broker, warehouse, or last-mile delivery.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract.',
    `customs_clearance_included` BOOLEAN COMMENT 'Indicates whether customs clearance services are included in the contract scope.',
    `effective_end_date` DATE COMMENT 'Date when the contract expires or terminates. Nullable for open-ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes legally binding and operational.',
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether fuel surcharges are applicable under this contract.',
    `fuel_surcharge_percentage` DECIMAL(18,2) COMMENT 'Percentage of fuel surcharge applied to base rate when applicable. Nullable if not applicable.',
    `generalized_system_preferences_utilization` BOOLEAN COMMENT 'Indicates whether the contract includes GSP utilization services to reduce or eliminate customs duties.',
    `geographic_coverage` STRING COMMENT 'Geographic regions, countries, or trade lanes covered by this contract (e.g., USA-CHN, EU-APAC, North America).',
    `harmonized_system_code_compliance` BOOLEAN COMMENT 'Indicates whether the contract requires HS code compliance and classification services for customs clearance.',
    `insurance_coverage_included` BOOLEAN COMMENT 'Indicates whether cargo insurance coverage is included in the contract terms.',
    `insurance_coverage_limit` DECIMAL(18,2) COMMENT 'Maximum insurance coverage limit per shipment or per incident. Nullable if insurance is not included.',
    `landed_duty_paid_calculation_included` BOOLEAN COMMENT 'Indicates whether LDP calculation and management services are included in the contract.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contract record was last updated.',
    `minimum_volume_commitment` DECIMAL(18,2) COMMENT 'Minimum volume or quantity of shipments committed under this contract to qualify for negotiated rates.',
    `notes` STRING COMMENT 'Free-text notes and comments about the contract, including special terms, exceptions, or operational considerations.',
    `on_time_delivery_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage for on-time delivery performance as specified in the SLA.',
    `payment_terms` STRING COMMENT 'Payment terms negotiated in the contract (e.g., Net 30, Net 60, prepaid, cash on delivery).',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount per SLA breach incident. Nullable if penalty clause is not applicable.',
    `penalty_clause_applicable` BOOLEAN COMMENT 'Indicates whether penalty clauses for SLA breaches are included in this contract.',
    `rate_unit_of_measure` STRING COMMENT 'Unit of measure for the base rate (per shipment, per container, per kilogram, per cubic meter, per pallet, per mile).',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required for contract renewal or termination. Nullable if auto-renewal is not enabled.',
    `routing_guide_compliance_required` BOOLEAN COMMENT 'Indicates whether the carrier must comply with the shippers routing guide specifications.',
    `service_level_agreement_target` STRING COMMENT 'Service level agreement targets defined in the contract, including transit time commitments, on-time delivery percentages, and performance metrics.',
    `service_scope` STRING COMMENT 'Detailed description of the logistics services covered under this contract, including transportation modes, geographic coverage, and service levels.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required to terminate the contract before its expiration date.',
    `tracking_visibility_level` STRING COMMENT 'Level of shipment tracking and visibility provided under this contract: basic (origin/destination only), milestone (key checkpoints), real-time (continuous GPS), or advanced (predictive analytics).',
    `transit_time_days` STRING COMMENT 'Standard transit time in days committed under this contract for the covered service scope.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation covered by this contract.',
    `vendor_id` BIGINT COMMENT 'Reference to the logistics service provider (carrier, 3PL, freight forwarder, customs broker) party to this contract.',
    `volume_commitment_unit` STRING COMMENT 'Unit of measure for the minimum volume commitment (shipments, containers, kilograms, cubic meters, pallets).',
    `wms_integration_required` BOOLEAN COMMENT 'Indicates whether integration with Manhattan Associates WMS or other warehouse management systems is required under this contract.',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Master reference table for contract. Referenced by contract_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_shipment_distribution_center_id` FOREIGN KEY (`shipment_distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ADD CONSTRAINT `fk_logistics_shipment_milestone_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ADD CONSTRAINT `fk_logistics_shipment_milestone_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_routing_guide_id` FOREIGN KEY (`routing_guide_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`routing_guide`(`routing_guide_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ADD CONSTRAINT `fk_logistics_freight_booking_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ADD CONSTRAINT `fk_logistics_customs_entry_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_customs_entry_id` FOREIGN KEY (`customs_entry_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`customs_entry`(`customs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ADD CONSTRAINT `fk_logistics_duty_calculation_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ADD CONSTRAINT `fk_logistics_routing_guide_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ADD CONSTRAINT `fk_logistics_routing_guide_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ADD CONSTRAINT `fk_logistics_routing_guide_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ADD CONSTRAINT `fk_logistics_routing_guide_primary_routing_distribution_center_id` FOREIGN KEY (`primary_routing_distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ADD CONSTRAINT `fk_logistics_routing_guide_tertiary_routing_last_mile_carrier_id` FOREIGN KEY (`tertiary_routing_last_mile_carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ADD CONSTRAINT `fk_logistics_routing_guide_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ADD CONSTRAINT `fk_logistics_distribution_center_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ADD CONSTRAINT `fk_logistics_sla_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ADD CONSTRAINT `fk_logistics_sla_agreement_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_customs_entry_id` FOREIGN KEY (`customs_entry_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`customs_entry`(`customs_entry_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ADD CONSTRAINT `fk_logistics_return_shipment_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_primary_packing_distribution_center_id` FOREIGN KEY (`primary_packing_distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ADD CONSTRAINT `fk_logistics_packing_list_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`hs_code`(`hs_code_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ADD CONSTRAINT `fk_logistics_carrier_service_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`contract`(`contract_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_destination_location_distribution_center_id` FOREIGN KEY (`destination_location_distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_third_party_logistics_id` FOREIGN KEY (`third_party_logistics_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`third_party_logistics`(`third_party_logistics_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ADD CONSTRAINT `fk_logistics_lane_return_lane_id` FOREIGN KEY (`return_lane_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ADD CONSTRAINT `fk_logistics_contract_master_contract_id` FOREIGN KEY (`master_contract_id`) REFERENCES `apparel_fashion_ecm`.`logistics`.`contract`(`contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `apparel_fashion_ecm`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Coordinator Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Factory Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `routing_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Partner ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Time of Arrival (ATA)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Time of Departure (ATD)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `carton_count` SET TAGS ('dbx_business_glossary_term' = 'Carton Count');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `cubic_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Cubic Volume (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `current_milestone` SET TAGS ('dbx_business_glossary_term' = 'Current Milestone');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Duty Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `estimated_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `estimated_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Departure (ETD)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `freight_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Estimate');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `gsp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `insurance_value` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shipment Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `otif_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'planned|booked|in_transit|customs_clearance|delivered|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'FOB|LDP|DTC|wholesale|inter_facility_transfer|return_to_vendor');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `sla_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `shipment_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Milestone ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `customs_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Cleared Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'WMS|EDI|CARRIER_API|GPS_TRACKER|MANUAL_ENTRY|CUSTOMS_SYSTEM');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Duty Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `gsp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `humidity_reading` SET TAGS ('dbx_business_glossary_term' = 'Humidity Reading Percentage');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `milestone_sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `otif_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `planned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `recorded_by_user` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `responsible_party_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `temperature_reading` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `variance_hours` SET TAGS ('dbx_business_glossary_term' = 'Milestone Variance Hours');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`shipment_milestone` ALTER COLUMN `vessel_voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Vessel or Voyage Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `freight_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Freight Booking Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Factory Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `routing_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Provider Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `booking_notes` SET TAGS ('dbx_business_glossary_term' = 'Booking Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `booking_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `booking_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'DRAFT|CONFIRMED|PENDING|CANCELLED|COMPLETED|ON_HOLD');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `collection_season_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Season Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `confirmed_space_allocation` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Space Allocation');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `container_quantity` SET TAGS ('dbx_business_glossary_term' = 'Container Quantity');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = '20FT_DRY|40FT_DRY|40FT_HC|20FT_REEFER|40FT_REEFER|FLAT_RACK');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `cut_off_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Cut-Off Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Date (ETA)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `estimated_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Departure Date (ETD)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `freight_charge_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `freight_charge_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `gsp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `insurance_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `port_of_discharge_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `port_of_discharge_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `port_of_loading_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `port_of_loading_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `rate_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Agreement Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Service Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `space_allocation_unit` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `space_allocation_unit` SET TAGS ('dbx_value_regex' = 'CBM|TEU|FEU|KG|LBS');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel or Flight Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_booking` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage or Flight Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `customs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Identifier');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Conveyance Arrival Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `bond_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Customs Bond Amount United States Dollars (USD)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `bond_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Bond Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'single|continuous|none');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `certificate_of_origin_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `commercial_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Invoice Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `declared_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Declared Value United States Dollars (USD)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `declared_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `duty_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Duty Amount United States Dollars (USD)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `duty_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `entry_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Filing Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}-[0-9]{7}-[0-9]$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `entry_summary_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Summary Filing Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'formal|informal|in-bond|warehouse|ftz');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `exam_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Examination Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `exam_type` SET TAGS ('dbx_value_regex' = 'intensive|tailored|compliance|pga|none');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `ftz_admission_number` SET TAGS ('dbx_business_glossary_term' = 'Foreign Trade Zone (FTZ) Admission Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `harbor_maintenance_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Harbor Maintenance Fee (HMF) United States Dollars (USD)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `harbor_maintenance_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `importer_of_record_name` SET TAGS ('dbx_business_glossary_term' = 'Importer of Record (IOR) Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `importer_of_record_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `importer_of_record_number` SET TAGS ('dbx_business_glossary_term' = 'Importer of Record (IOR) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `importer_of_record_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `importer_of_record_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `isf_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Importer Security Filing (ISF) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Entry Line Item Count');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `liquidation_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Liquidation Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `merchandise_processing_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Processing Fee (MPF) United States Dollars (USD)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `merchandise_processing_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Duty Payment Due Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Duty Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|check|statement|bond|other');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `port_of_entry_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Entry Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `port_of_entry_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `port_of_unlading_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Unlading Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `port_of_unlading_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `protest_filed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Protest Filed Indicator');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `reconciliation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Entry Reconciliation Indicator');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Release Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `surety_code` SET TAGS ('dbx_business_glossary_term' = 'Surety Company Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `surety_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Entry Quantity');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Entry Weight Kilograms (KG)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `trade_program_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Preference Program Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transportation');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'ocean|air|truck|rail|courier');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`customs_entry` ALTER COLUMN `voyage_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage or Flight Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `labeling_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Requirement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `antidumping_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Antidumping Duty Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `chapter` SET TAGS ('dbx_business_glossary_term' = 'HS Chapter');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `countervailing_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Countervailing Duty Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `cpsc_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Product Safety Commission (CPSC) Regulated Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `cpsc_regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'CPSC Regulation Reference');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `duty_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `duty_rate_unit` SET TAGS ('dbx_value_regex' = 'percentage|specific|compound');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `environmental_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification Requirements');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `ftc_labeling_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Labeling Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `ftc_labeling_requirement` SET TAGS ('dbx_business_glossary_term' = 'FTC Labeling Requirement Details');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `general_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'General Duty Rate');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `gsp_beneficiary_countries` SET TAGS ('dbx_business_glossary_term' = 'GSP Beneficiary Countries List');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `gsp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `heading` SET TAGS ('dbx_business_glossary_term' = 'HS Heading');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `heading` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `hs_code_description` SET TAGS ('dbx_business_glossary_term' = 'HS Code Description');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `hs_code_status` SET TAGS ('dbx_business_glossary_term' = 'HS Code Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `hs_code_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|superseded|pending');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `hs_version` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System Version');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `hs_version` SET TAGS ('dbx_value_regex' = '^HS[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `national_extension` SET TAGS ('dbx_business_glossary_term' = 'National Extension Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Classification Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `origin_criteria` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Criteria');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `preferential_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferential Duty Rate');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Import/Export Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'quota|license|prohibition|embargo|antidumping|countervailing');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `section_301_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Section 301 Additional Duty Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `section_301_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Section 301 Additional Duty Rate');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'HS Code Short Description');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `subheading` SET TAGS ('dbx_business_glossary_term' = 'HS Subheading');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `subheading` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `superseded_by_hs_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded By HS Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `textile_category` SET TAGS ('dbx_business_glossary_term' = 'Textile Category Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `trade_agreement` SET TAGS ('dbx_business_glossary_term' = 'Applicable Trade Agreement');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `unit_of_quantity` SET TAGS ('dbx_business_glossary_term' = 'Statistical Unit of Quantity');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`hs_code` ALTER COLUMN `unit_of_quantity` SET TAGS ('dbx_value_regex' = 'pieces|dozens|kilograms|pairs|square_meters|linear_meters');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `duty_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Calculation Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `customs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Calculated By User Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Provider Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `anti_dumping_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Anti-Dumping (AD) Duty Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `base_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Duty Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `calculation_number` SET TAGS ('dbx_business_glossary_term' = 'Duty Calculation Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `calculation_number` SET TAGS ('dbx_value_regex' = '^DC-[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `cif_value` SET TAGS ('dbx_business_glossary_term' = 'Cost Insurance and Freight (CIF) Value');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `countervailing_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Countervailing Duty (CVD) Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `destination_country` SET TAGS ('dbx_business_glossary_term' = 'Destination Country');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `destination_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `excise_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Excise Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `fob_value` SET TAGS ('dbx_business_glossary_term' = 'Free on Board (FOB) Value');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `fta_claimed_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Agreement (FTA) Claimed Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `fta_name` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Agreement (FTA) Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `fta_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Agreement (FTA) Reduction Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `gsp_claimed_flag` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Claimed Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `gsp_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Reduction Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `hmf_amount` SET TAGS ('dbx_business_glossary_term' = 'Harbor Maintenance Fee (HMF) Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `insurance_cost` SET TAGS ('dbx_business_glossary_term' = 'Insurance Cost');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `ldp_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Total Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `ldp_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `mpf_amount` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Processing Fee (MPF) Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Calculation Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `other_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Fees Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `port_of_entry` SET TAGS ('dbx_business_glossary_term' = 'Port of Entry');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|variance|resolved');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `total_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Duty Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `total_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fees Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`duty_calculation` ALTER COLUMN `vat_amount` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `api_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Legal Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_value_regex' = 'preferred|approved|probation|suspended|inactive');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `damage_claim_rate` SET TAGS ('dbx_business_glossary_term' = 'Damage Claim Rate');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `edi_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capability Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_business_glossary_term' = 'Motor Carrier (MC) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `on_time_performance_score` SET TAGS ('dbx_business_glossary_term' = 'On-Time Performance Score');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `otif_score` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Score');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Short Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_business_glossary_term' = 'Tracking Uniform Resource Locator (URL) Template');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `routing_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `primary_routing_distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `tertiary_routing_last_mile_carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Carrier ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Partner ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `carrier_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `carrier_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms (Free on Board / Landed Duty Paid)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'FOB|prepaid|collect|third_party|DDP|LDP');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `gsp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `guide_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `guide_code` SET TAGS ('dbx_value_regex' = '^RG-[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `guide_name` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `hs_code_validation_required` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Validation Required');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `ldp_calculation_required` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Calculation Required');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `max_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transit Days');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `minimum_shipment_volume` SET TAGS ('dbx_business_glossary_term' = 'Minimum Shipment Volume');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transport');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_value_regex' = 'ocean|air|truck|rail|intermodal|parcel');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `routing_guide_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `routing_guide_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `routing_notes` SET TAGS ('dbx_business_glossary_term' = 'Routing Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|HO|SP)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|express|direct|economy');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound|transfer|return|sample');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `sla_target_otif_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target On Time In Full (OTIF) Percent');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`routing_guide` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'cartons|pallets|kg|lbs|cbm|cuft');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Three Pl Partner Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated|robotic');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `bulk_storage_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Bulk Storage Capacity (Square Feet)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `cold_storage_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Cold Storage Capacity (Square Feet)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `customs_bonded_warehouse_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Bonded Warehouse Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `dc_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `dc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'owned_dc|3pl_operated|cross_dock|returns_center|forward_stocking_location|fulfillment_center');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `hanging_storage_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Hanging Storage Capacity (Square Feet)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|under_construction|decommissioned|temporarily_closed');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `pick_zone_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Pick Zone Capacity (Square Feet)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `supports_dtc_channel` SET TAGS ('dbx_business_glossary_term' = 'Supports Direct-to-Consumer (DTC) Channel');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `supports_outlet_channel` SET TAGS ('dbx_business_glossary_term' = 'Supports Outlet Channel');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `supports_retail_replenishment_channel` SET TAGS ('dbx_business_glossary_term' = 'Supports Retail Replenishment Channel');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `supports_wholesale_channel` SET TAGS ('dbx_business_glossary_term' = 'Supports Wholesale Channel');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `throughput_capacity_units_per_day` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity (Units Per Day)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `total_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Total Square Footage');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`distribution_center` ALTER COLUMN `wms_instance_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Instance ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Logistics Identifier');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Company Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `customs_broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `customs_broker_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `freight_forwarder_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Regions');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'prospective|onboarding|active|suspended|terminated|inactive');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `partner_code` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Partner Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Composite Performance Rating');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `returns_processing_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Returns Processing Capable Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'warehousing|fulfillment|freight_forwarding|customs_brokerage|last_mile_delivery|integrated');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `sustainability_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `total_warehouse_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Warehouse Square Footage');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `total_warehouse_sqft` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `vendor_managed_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `warehouse_count` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Count');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `wms_integration_type` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Integration Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`third_party_logistics` ALTER COLUMN `wms_integration_type` SET TAGS ('dbx_value_regex' = 'api|edi_940_945|flat_file|sftp|none');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Agreement ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Three Pl Partner Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `bonus_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Bonus Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `bonus_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `bonus_structure` SET TAGS ('dbx_business_glossary_term' = 'Bonus Structure');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `bonus_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `breach_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = '3pl|carrier|freight_forwarder|customs_broker|warehouse|distribution_center');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|per_shipment|rolling_30_days');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `penalty_structure` SET TAGS ('dbx_business_glossary_term' = 'Penalty Structure');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `penalty_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `reporting_system` SET TAGS ('dbx_business_glossary_term' = 'Reporting System');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Scope Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'lane|facility|region|global|service_type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `sla_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `sla_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|under_review');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `sla_number` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `sla_number` SET TAGS ('dbx_value_regex' = '^SLA-[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'transit_time|otif|order_accuracy|damage_rate|customs_clearance|delivery_window');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = 'percentage|hours|days|count|rate');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `threshold_lower_bound` SET TAGS ('dbx_business_glossary_term' = 'Threshold Lower Bound');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `threshold_upper_bound` SET TAGS ('dbx_business_glossary_term' = 'Threshold Upper Bound');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`sla_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `circular_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `customs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non Conformance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Outbound Shipment ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Return Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Coordinator Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Original Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Partner ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `carton_count` SET TAGS ('dbx_business_glossary_term' = 'Carton Count');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Condition Grade');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `cubic_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Cubic Volume (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `destination_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `destination_facility_type` SET TAGS ('dbx_value_regex' = 'distribution_center|returns_center|vendor|refurbishment_center|outlet_warehouse');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_business_glossary_term' = 'Disposition Outcome');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_value_regex' = 'restock|refurbish|outlet|donate|destroy|return_to_vendor');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Initiation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `inspection_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `origin_location_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `origin_location_type` SET TAGS ('dbx_value_regex' = 'customer|retail_store|distribution_center|vendor|warehouse');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Return Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Customer Refund Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `restocking_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Restocking Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_value_regex' = '^RMA[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'fit_issue|quality_defect|wrong_item|changed_mind|damaged|not_as_described');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'consumer_rma|rtv|store_recall|quality_reject|warranty_claim|inter_facility_transfer');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `shipment_notes` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'initiated|in_transit|customs_clearance|delivered|cancelled|exception');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`return_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Specialist Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Partner ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `accessorial_charges` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `base_freight_charge` SET TAGS ('dbx_business_glossary_term' = 'Base Freight Charge');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `customs_brokerage_fee` SET TAGS ('dbx_business_glossary_term' = 'Customs Brokerage Fee');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `detention_demurrage_charges` SET TAGS ('dbx_business_glossary_term' = 'Detention and Demurrage Charges');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Duty Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `fuel_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `insurance_charge` SET TAGS ('dbx_business_glossary_term' = 'Insurance Charge');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|pro_forma|consolidated|supplemental');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|paid|on_hold|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `purchase_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Reference');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|express|economy|next_day|two_day');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `shipment_reference_list` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference List');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `total_invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoiced Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'ocean|air|ground|rail|intermodal|courier');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packing_list_id` SET TAGS ('dbx_business_glossary_term' = 'Packing List ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Final Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Factory Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packaging_sustainability_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Sustainability Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `primary_packing_distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `carton_label_format` SET TAGS ('dbx_business_glossary_term' = 'Carton Label Format');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `carton_label_format` SET TAGS ('dbx_value_regex' = 'gs1_128|sscc|ucc_128|custom');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `certificate_of_origin_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `commercial_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Invoice Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = '20ft|40ft|40ft_hc|lcl|air_freight|truck');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `gsp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `invoice_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `invoice_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Packing List Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packing_date` SET TAGS ('dbx_business_glossary_term' = 'Packing Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packing_list_number` SET TAGS ('dbx_business_glossary_term' = 'Packing List Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packing_list_number` SET TAGS ('dbx_value_regex' = '^PL-[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packing_list_status` SET TAGS ('dbx_business_glossary_term' = 'Packing List Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packing_list_status` SET TAGS ('dbx_value_regex' = 'draft|finalized|submitted|received|discrepancy|closed');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packing_list_type` SET TAGS ('dbx_business_glossary_term' = 'Packing List Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packing_list_type` SET TAGS ('dbx_value_regex' = 'master|detailed|consolidated|sample');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packing_method` SET TAGS ('dbx_business_glossary_term' = 'Packing Method');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `packing_method` SET TAGS ('dbx_value_regex' = 'flat_pack|hanging|polybag|boxed|mixed');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `quarantine_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Hold Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `receiving_discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Receiving Discrepancy Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `total_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Total Carton Count');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `total_cubic_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Cubic Volume (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight (Kilograms)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `total_invoice_value` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Value');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `total_net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Net Weight (Kilograms)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `total_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Total Pallet Count');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`packing_list` ALTER COLUMN `total_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Quantity');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Factory Supplier Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Coordinator Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_status` SET TAGS ('dbx_value_regex' = 'draft|issued|in_transit|delivered|surrendered|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_type` SET TAGS ('dbx_value_regex' = 'original|telex_release|express_release|seaway_bill|house|master');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `commercial_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Invoice Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_address` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `cubic_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Cubic Volume in Cubic Meters (m³)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Cargo Value');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_forwarder_reference` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (kg)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `gsp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Issue Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `letter_of_credit_number` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `letter_of_credit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `notify_party_contact` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Contact Information');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `notify_party_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `notify_party_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `place_of_delivery` SET TAGS ('dbx_business_glossary_term' = 'Place of Delivery');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `place_of_receipt` SET TAGS ('dbx_business_glossary_term' = 'Place of Receipt');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `port_of_discharge_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `port_of_discharge_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `port_of_loading_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `port_of_loading_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Container Seal Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_address` SET TAGS ('dbx_business_glossary_term' = 'Shipper Address');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `shipper_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel or Vehicle Name');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage or Flight Number');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` SET TAGS ('dbx_association_edges' = 'logistics.carrier,production.factory');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `carrier_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Agreement ID');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Agreement - Carrier Id');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Agreement - Factory Id');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `lane_priority` SET TAGS ('dbx_business_glossary_term' = 'Lane Priority');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `transit_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Days');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`carrier_service_agreement` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` SET TAGS ('dbx_subdomain' = 'freight_movement');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Identifier');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`lane` ALTER COLUMN `return_lane_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ALTER COLUMN `master_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ALTER COLUMN `base_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ALTER COLUMN `fuel_surcharge_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ALTER COLUMN `insurance_coverage_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`logistics`.`contract` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
