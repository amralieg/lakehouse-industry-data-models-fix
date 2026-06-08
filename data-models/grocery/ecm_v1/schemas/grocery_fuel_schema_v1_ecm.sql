-- Schema for Domain: fuel | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`fuel` COMMENT 'Fuel center operations including pump management, fuel inventory and tank levels, fuel grade pricing, EPA emissions compliance, RFID fleet card transactions, delivery schedules, and loyalty-linked fuel discount redemptions. Manages price change events, volume sales, and equipment maintenance schedules. Integrates with POS and loyalty systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`center` (
    `center_id` BIGINT COMMENT 'Unique identifier for the fuel center location. Primary key for the fuel center master record. Serves as the anchor for all fuel domain operations and relationships.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating fuel center operating expenses to the cost center in budgeting and expense reporting.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier. Business justification: Fuel procurement contracts assign a primary carrier per fuel center; this FK supports carrier performance and contract compliance reporting.',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Store Operations Dashboard combines fuel and grocery metrics; linking fuel_center to its fulfillment node enables unified reporting of sales, inventory, and labor.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Posts fuel center sales revenue to the appropriate GL account for financial statements.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Maps each fuel center to its legal entity for corporate tax filing and regulatory compliance.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Required for Fuel Center Manager staffing report; each center has a manager associate for labor budgeting and compliance.',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: Each fuel center is assigned a primary pricing rule that governs fuel price calculations and compliance, needed for rule‑driven price updates.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Zone‑based fuel pricing strategy requires each fuel center to be linked to a price zone for consistent pricing across locations.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables profit‑center revenue reporting for each fuel center in profit‑and‑loss statements.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Required for the Fuel Center Compliance Assignment process that maps each center to its EPA/state compliance program for reporting and audits.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Associates a fuel discount campaign with a particular fuel center for campaign performance analysis and localized marketing.',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Cluster-level fuel pricing and promotion planning report aggregates fuel_center data by store cluster, requiring direct FK to store_cluster.',
    `store_location_id` BIGINT COMMENT 'Foreign key reference to the parent store location that operates this fuel center. Links fuel center operations to the primary retail store entity.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: PROCUREMENT: Fuel center tracks primary fuel supplier for contract management and compliance reporting, a standard practice in grocery fuel operations.',
    `address_line_1` STRING COMMENT 'Primary street address of the fuel center location. First line of the physical site address including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address information for the fuel center location. Optional field for suite, building, or additional location details.',
    `alternative_fuel_available_flag` BOOLEAN COMMENT 'Indicates whether alternative fuels such as E85, biodiesel, or compressed natural gas are available at this fuel center. True if any alternative fuel is offered.',
    `canopy_configuration` STRING COMMENT 'Physical canopy structure configuration covering the fuel dispensing area. Describes the overhead shelter arrangement for customer protection.. Valid values are `single_canopy|dual_canopy|multi_canopy|no_canopy`',
    `car_wash_available_flag` BOOLEAN COMMENT 'Indicates whether a car wash facility is available at this fuel center location. True if car wash services are offered.',
    `city` STRING COMMENT 'City or municipality where the fuel center is located. Part of the complete physical address for the facility.',
    `convenience_store_attached_flag` BOOLEAN COMMENT 'Indicates whether a convenience store or retail shop is physically attached to the fuel center. True if convenience store is present.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the fuel center location. Identifies the country where the facility operates.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel center record was first created in the system. Used for data lineage and audit trail purposes.',
    `diesel_available_flag` BOOLEAN COMMENT 'Indicates whether diesel fuel is available at this fuel center. True if diesel is offered, false otherwise.',
    `dispenser_count` STRING COMMENT 'Total number of individual fuel dispensers (pumps) at the fuel center. Represents the maximum number of vehicles that can fuel simultaneously.',
    `facility_status` STRING COMMENT 'Current operational status of the fuel center facility. Indicates whether the location is actively serving customers or in a non-operational state.. Valid values are `active|inactive|under_construction|temporarily_closed|permanently_closed|under_maintenance`',
    `fuel_center_code` STRING COMMENT 'Unique business identifier code for the fuel center. Externally-known alphanumeric code used in operational systems, reporting, and vendor communications. Format: FC followed by 6 digits.. Valid values are `^FC[0-9]{6}$`',
    `fuel_center_name` STRING COMMENT 'Business name or designation of the fuel center location. Human-readable identifier used for operational reference and customer communication.',
    `fuel_grades_offered` STRING COMMENT 'Comma-separated list of fuel grades available at this fuel center. Examples: Regular 87, Mid-Grade 89, Premium 91, Diesel, E85. Defines the product mix for pricing and inventory management.',
    `last_equipment_maintenance_date` DATE COMMENT 'Date of the most recent preventive maintenance performed on fuel dispensing equipment. Used for equipment lifecycle management and reliability tracking.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection conducted at the fuel center. Used for compliance tracking and maintenance scheduling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel center record was last updated in the system. Used for data lineage and change tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the fuel center location. Used for mapping, routing, and proximity analysis. Decimal degrees format.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the fuel center location. Used for mapping, routing, and proximity analysis. Decimal degrees format.',
    `loyalty_discount_enabled_flag` BOOLEAN COMMENT 'Indicates whether the fuel center participates in the loyalty program fuel discount redemption. True if loyalty-linked fuel discounts are available at this location.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required regulatory or safety inspection. Used for compliance planning and operational scheduling.',
    `opening_date` DATE COMMENT 'Date when the fuel center first opened for business operations. Used for lifecycle tracking and performance analysis.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for the fuel center on weekdays (Monday through Friday). Format: HH:MM-HH:MM or 24/7 for continuous operation.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for the fuel center on weekends (Saturday and Sunday). Format: HH:MM-HH:MM or 24/7 for continuous operation.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the fuel center location. Used for operational communication and customer inquiries.',
    `pos_integration_enabled_flag` BOOLEAN COMMENT 'Indicates whether the fuel center is integrated with the store POS system for payment processing and transaction reconciliation. True if POS integration is active.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the fuel center location. Five-digit or ZIP+4 format for US locations.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `premium_fuel_available_flag` BOOLEAN COMMENT 'Indicates whether premium grade fuel is available at this fuel center. True if premium fuel is offered, false otherwise.',
    `pump_island_count` STRING COMMENT 'Total number of pump islands at the fuel center. Each island typically contains multiple dispensers. Used for capacity planning and operational analysis.',
    `rfid_fleet_card_enabled_flag` BOOLEAN COMMENT 'Indicates whether the fuel center supports RFID-enabled fleet card transactions for commercial customers. True if RFID fleet card processing is available.',
    `state_petroleum_license_number` STRING COMMENT 'State-issued license number authorizing the fuel center to sell petroleum products. Required for regulatory compliance and operational authorization.',
    `state_province_code` STRING COMMENT 'Two-letter state or province code for the fuel center location. ISO 3166-2 standard subdivision code.. Valid values are `^[A-Z]{2}$`',
    `tank_count` STRING COMMENT 'Total number of underground storage tanks at the fuel center. Used for inventory management, compliance tracking, and capacity planning.',
    `total_storage_capacity_gallons` DECIMAL(18,2) COMMENT 'Total fuel storage capacity across all underground tanks at the fuel center, measured in gallons. Represents maximum inventory holding capacity.',
    `twenty_four_hour_operation_flag` BOOLEAN COMMENT 'Indicates whether the fuel center operates 24 hours per day, 7 days per week. True for continuous operation, false for limited hours.',
    `ust_registration_number` STRING COMMENT 'Underground Storage Tank registration number issued by state or federal authorities. Required for environmental compliance and tank monitoring.',
    CONSTRAINT pk_center PRIMARY KEY(`center_id`)
) COMMENT 'Master record for each fuel center location operated by Grocery, including physical site address, number of pump islands, canopy configuration, fuel grades offered, operating hours, EPA facility ID (UST registration number), state petroleum license number, and FK to the parent store location. Serves as the SSOT for fuel center identity, site-level attributes, regulatory registration references, and the anchor entity for all fuel domain operations.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`pump` (
    `pump_id` BIGINT COMMENT 'Unique identifier for the fuel dispenser pump. Primary key for the pump master record.',
    `center_id` BIGINT COMMENT 'Reference to the fuel center location where this pump is installed.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: ASSET MANAGEMENT: Pump equipment warranty and maintenance contracts require linking each pump to its equipment supplier.',
    `ada_compliant` BOOLEAN COMMENT 'Indicates whether the pump meets ADA accessibility requirements for customers with disabilities, including reach range, controls placement, and signage.',
    `certified_accuracy` DECIMAL(18,2) COMMENT 'Certified measurement accuracy of the fuel dispenser meter as a decimal percentage (e.g., 0.9995 represents 99.95% accuracy). Must meet EPA and state weights and measures standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pump master record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the fuel dispenser was permanently removed from service and decommissioned. Null for active pumps.',
    `decommission_reason` STRING COMMENT 'Business reason for decommissioning the fuel dispenser, such as equipment failure, technology upgrade, fuel center closure, or regulatory non-compliance.',
    `emergency_shutoff_type` STRING COMMENT 'Type of emergency fuel shutoff mechanism installed on the pump. Manual requires physical button activation. Automatic triggers on impact or fire detection. Both provides redundant safety systems.. Valid values are `manual|automatic|both`',
    `epa_certification_number` STRING COMMENT 'EPA-issued certification number for the fuel dispenser equipment, verifying compliance with federal emissions and vapor recovery standards.',
    `fleet_card_enabled` BOOLEAN COMMENT 'Indicates whether the pump supports RFID fleet card transactions for commercial fleet customers.',
    `fuel_grade_capacity` STRING COMMENT 'Number of different fuel grades (octane levels or fuel types) that this pump can dispense. Common values are 3 (regular, mid-grade, premium) or 4 (including diesel).',
    `installation_date` DATE COMMENT 'Date when the fuel dispenser was installed and commissioned at the fuel center location.',
    `last_calibration_date` DATE COMMENT 'Date when the fuel dispenser meter was last calibrated and certified by a licensed technician. Required for EPA compliance and state weights and measures regulations.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent preventive or corrective maintenance was performed on the fuel dispenser.',
    `loyalty_integration_enabled` BOOLEAN COMMENT 'Indicates whether the pump supports loyalty program integration for fuel discount redemptions and rewards point accrual at the pump.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the fuel dispenser equipment.',
    `model` STRING COMMENT 'Manufacturer model number or designation for the fuel dispenser unit.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration and certification of the fuel dispenser meter. Typically required annually or per state regulation.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance service on the fuel dispenser.',
    `nozzle_count` STRING COMMENT 'Number of fuel nozzles (hoses) available on this dispenser unit. Typically ranges from 1 to 8 nozzles per pump.',
    `operational_status` STRING COMMENT 'Current operational state of the fuel dispenser. Active indicates the pump is available for customer use. Maintenance indicates temporary unavailability for servicing. Out of service indicates equipment failure. Decommissioned indicates permanent removal from service.. Valid values are `active|inactive|maintenance|out_of_service|decommissioned`',
    `payment_terminal_type` STRING COMMENT 'Type of payment technology supported by the pump terminal. RFID supports Radio Frequency Identification fleet cards. EMV supports chip-based credit/debit cards. NFC supports contactless mobile payments. Magnetic stripe supports legacy swipe cards. Hybrid supports multiple technologies.. Valid values are `rfid|emv|nfc|magnetic_stripe|hybrid`',
    `pos_integration_enabled` BOOLEAN COMMENT 'Indicates whether the pump is integrated with the store POS system for real-time transaction processing and inventory management.',
    `prepay_only_mode` BOOLEAN COMMENT 'Indicates whether the pump is configured to require prepayment before fuel dispensing, typically enabled during high-risk hours to prevent drive-offs.',
    `pump_number` STRING COMMENT 'Business identifier for the pump, typically displayed on the dispenser unit for customer reference. Unique within a fuel center.. Valid values are `^[A-Z0-9]{1,10}$`',
    `remote_shutoff_capable` BOOLEAN COMMENT 'Indicates whether the pump can be remotely disabled from the fuel center control console or store POS system in emergency situations.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific dispenser unit. Used for warranty tracking and equipment lifecycle management.',
    `state_certification_number` STRING COMMENT 'State weights and measures certification number for the fuel dispenser meter accuracy, issued by the state regulatory authority.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pump master record was last modified in the system.',
    `vapor_recovery_system` STRING COMMENT 'Type of EPA-mandated vapor recovery system installed on the pump. Stage 1 captures vapors during fuel delivery to underground tanks. Stage 2 captures vapors during customer fueling. Required for EPA emissions compliance.. Valid values are `stage_1|stage_2|stage_1_and_2|none`',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty coverage for the fuel dispenser equipment expires.',
    CONSTRAINT pk_pump PRIMARY KEY(`pump_id`)
) COMMENT 'Master record for each individual fuel dispenser (pump) at a fuel center, capturing pump number, manufacturer, model, serial number, installation date, certified measurement accuracy, payment terminal type (RFID/EMV/NFC), operational status, and last calibration date. Supports equipment lifecycle management and EPA compliance tracking.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`grade` (
    `grade_id` BIGINT COMMENT 'Unique identifier for the fuel grade. Primary key for the fuel grade reference catalog.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: QUALITY & Sourcing: Each fuel grade is sourced from a specific supplier; linking enables quality certification and rebate calculations.',
    `api_gravity` DECIMAL(18,2) COMMENT 'Measure of how heavy or light a petroleum liquid is compared to water. Higher API gravity indicates lighter, less dense fuel. Typical range: 30-45 for gasoline, 30-42 for diesel. Used for inventory volume-to-weight conversions and quality control.',
    `biodiesel_blend_percentage` DECIMAL(18,2) COMMENT 'Percentage of biodiesel (fatty acid methyl esters) blended into diesel fuel. Common blends include B5 (5%), B10 (10%), B20 (20%). Null for gasoline and non-diesel products.',
    `carbon_intensity_score` DECIMAL(18,2) COMMENT 'Lifecycle greenhouse gas emissions intensity measured in grams of CO2 equivalent per megajoule of energy. Used for Low Carbon Fuel Standard (LCFS) compliance in California and other jurisdictions. Lower scores indicate cleaner fuels.',
    `cetane_number` STRING COMMENT 'Measure of the combustion quality of diesel fuel during compression ignition. Higher cetane numbers indicate shorter ignition delay and better combustion. Typical range: 40-55. Null for gasoline and non-diesel products.',
    `color_code` STRING COMMENT 'Hexadecimal color code used for visual identification of the fuel grade on pump displays, signage, and digital interfaces. Standardized colors help customers quickly identify fuel types (e.g., green for diesel, yellow for mid-grade).. Valid values are `^#[0-9A-F]{6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel grade record was first created in the system. Used for audit trail and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `display_sequence` STRING COMMENT 'Integer value controlling the display order of fuel grades on pump interfaces, POS screens, and customer-facing applications. Lower values appear first. Typically ordered by octane rating or customer preference (e.g., 1=Regular, 2=Mid-Grade, 3=Premium).',
    `effective_end_date` DATE COMMENT 'Date when this fuel grade was discontinued or became unavailable for sale. Null for currently active grades. Used for historical analysis and regulatory reporting. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date when this fuel grade became available for sale across fuel centers. Used for historical tracking and seasonal blend transitions. Format: yyyy-MM-dd.',
    `energy_content_btu_per_gallon` STRING COMMENT 'Energy content of the fuel measured in British Thermal Units per gallon. Gasoline typically 115,000-125,000 BTU/gal; diesel typically 130,000-138,000 BTU/gal; E85 approximately 81,000 BTU/gal. Used for energy equivalency calculations and fleet efficiency analysis.',
    `epa_fuel_category` STRING COMMENT 'EPA regulatory classification of the fuel product for emissions compliance and reporting. Categories include conventional gasoline, reformulated gasoline (RFG), ULSD, renewable diesel, and alternative fuels. Used for environmental compliance tracking.',
    `ethanol_blend_percentage` DECIMAL(18,2) COMMENT 'Percentage of ethanol blended into the gasoline product. Standard unleaded typically contains up to 10% (E10); E85 contains 51-83% ethanol. Null for diesel and non-ethanol products.',
    `flash_point_fahrenheit` STRING COMMENT 'Lowest temperature at which vapors of the fuel will ignite when exposed to an ignition source. Critical safety parameter for storage and handling. Gasoline typically -45°F; diesel typically 125-180°F.',
    `fleet_card_accepted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this fuel grade is available for purchase using RFID-enabled fleet cards and commercial fuel cards. True if accepted for fleet transactions; False if restricted to retail consumer purchases only.',
    `grade_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the fuel grade within the system (e.g., REG87, MID89, PREM93, DSL, E85, DEF). Used for operational lookup and integration with POS and pricing systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `grade_description` STRING COMMENT 'Detailed textual description of the fuel grade including key characteristics, intended use, performance benefits, and any special handling or regulatory notes. Used for customer communication, training materials, and internal documentation.',
    `grade_name` STRING COMMENT 'Full business name of the fuel grade as displayed to customers and used in reporting (e.g., Regular Unleaded, Mid-Grade, Premium, Diesel, E85 Flex Fuel, Diesel Exhaust Fluid).',
    `grade_status` STRING COMMENT 'Current lifecycle status of the fuel grade. Active grades are available for sale; inactive grades are temporarily unavailable; discontinued grades are permanently retired; seasonal grades are available only during specific periods (e.g., winter blends).. Valid values are `active|inactive|discontinued|seasonal`',
    `grade_type` STRING COMMENT 'High-level classification of the fuel product type. Gasoline includes unleaded grades; diesel includes standard and bio-diesel blends; alternative fuel includes E85, CNG, electric; additive includes DEF and other supplemental products.. Valid values are `gasoline|diesel|alternative_fuel|additive`',
    `gtin` STRING COMMENT '14-digit Global Trade Item Number used for supply chain and EDI transactions. Provides globally unique identification for fuel products across trading partners and distribution channels.. Valid values are `^[0-9]{14}$`',
    `hazmat_classification` STRING COMMENT 'Department of Transportation hazardous materials classification code for the fuel grade. Used for transportation, storage, and emergency response planning. Example: UN1203 for gasoline, UN1202 for diesel fuel.',
    `loyalty_discount_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether purchases of this fuel grade qualify for loyalty program fuel discount redemptions. Typically True for standard gasoline and diesel grades; may be False for premium or specialty fuels depending on program rules.',
    `octane_rating` STRING COMMENT 'The octane number representing the fuels resistance to knocking or pinging during combustion. Typical values: 87 (Regular), 89 (Mid-Grade), 91-93 (Premium). Null for non-gasoline products such as diesel or DEF.',
    `reformulated_gasoline_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the fuel grade is reformulated gasoline designed to reduce smog-forming and toxic air pollutants. RFG is required in certain metropolitan areas with severe ozone pollution. True if RFG; False otherwise.',
    `renewable_identification_number` STRING COMMENT '38-character unique identifier assigned to batches of renewable fuel under the EPA Renewable Fuel Standard. Used to track and trade renewable fuel credits for compliance with federal mandates. Null for non-renewable fuels.. Valid values are `^[0-9]{38}$`',
    `sulfur_content_ppm` STRING COMMENT 'Sulfur content measured in parts per million. EPA Ultra-Low Sulfur Diesel (ULSD) standard requires maximum 15 ppm. Gasoline typically contains less than 10 ppm under Tier 3 standards. Critical for emissions compliance.',
    `supplier_product_code` STRING COMMENT 'Product code or SKU used by the primary fuel supplier or refiner to identify this grade in purchase orders, invoices, and EDI transactions. Facilitates supply chain integration and vendor reconciliation.',
    `tax_category_code` STRING COMMENT 'Code identifying the applicable federal and state excise tax category for the fuel grade. Different grades and blends may have different tax rates (e.g., gasoline vs diesel vs alternative fuels). Used for tax calculation and regulatory reporting.',
    `upc_code` STRING COMMENT '12-digit Universal Product Code used for point-of-sale scanning and inventory tracking. Aligns with GS1 standards for retail fuel products sold in packaged form or tracked via loyalty systems.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel grade record was last modified. Updated whenever any attribute changes. Used for change tracking and data synchronization. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `winter_blend_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the fuel grade is formulated as a winter blend with higher Reid Vapor Pressure (RVP) to improve cold-weather starting and performance. True if winter blend; False if summer blend or year-round formulation.',
    CONSTRAINT pk_grade PRIMARY KEY(`grade_id`)
) COMMENT 'Reference catalog of all fuel grades and product types offered across fuel centers, including grade name (Regular Unleaded, Mid-Grade, Premium, Diesel, E85, DEF), octane rating, ethanol blend percentage, product code, applicable regulatory classification, and whether the grade qualifies for loyalty fuel discount redemption.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`tank` (
    `tank_id` BIGINT COMMENT 'Unique identifier for the underground storage tank (UST). Primary key.',
    `center_id` BIGINT COMMENT 'Reference to the fuel center location where this tank is installed.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: COMPLIANCE: Tank ownership/manufacturer tracking is needed for EPA compliance, inspections, and service agreements.',
    `capacity_gallons` DECIMAL(18,2) COMMENT 'Maximum storage capacity of the tank measured in gallons. Critical for inventory management and refill scheduling.',
    `cathodic_protection_test_date` DATE COMMENT 'Date of the most recent cathodic protection system test. Required every three years for tanks with cathodic protection per EPA regulations.',
    `corrosion_protection_type` STRING COMMENT 'Method of corrosion protection applied to the tank (e.g., cathodic protection, protective coating, inherently non-corrosive material). EPA requires corrosion protection for steel tanks.. Valid values are `cathodic_protection|coated_steel|fiberglass|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tank record was first created in the system. Used for audit trail and data lineage.',
    `current_volume_gallons` DECIMAL(18,2) COMMENT 'Current fuel volume in the tank measured in gallons. Updated by automatic tank gauging systems. Used for inventory management and reorder triggers.',
    `decommission_date` DATE COMMENT 'Date when the tank was permanently removed from service and decommissioned per EPA closure requirements. Null for active tanks.',
    `decommission_method` STRING COMMENT 'Method used to decommission the tank (e.g., removed from ground, filled in place with inert material). EPA requires proper closure procedures.. Valid values are `removed|filled_in_place|none`',
    `epa_ust_registration_number` STRING COMMENT 'Official EPA registration number for this underground storage tank, required for federal compliance tracking and reporting.',
    `fuel_grade` STRING COMMENT 'Type of fuel grade stored in this tank (e.g., regular unleaded, premium, diesel). Determines pricing and customer selection at pump.. Valid values are `regular_unleaded|mid_grade|premium|diesel|e85|biodiesel`',
    `high_level_alarm_threshold_gallons` DECIMAL(18,2) COMMENT 'Fuel volume level that triggers a high-level alarm during delivery to prevent overfill. Typically set at 90-95% of capacity.',
    `installation_date` DATE COMMENT 'Date when the tank was originally installed at the fuel center. Used to track tank age and plan replacement schedules per EPA guidelines.',
    `last_cleaning_date` DATE COMMENT 'Date when the tank was last cleaned and inspected internally. Periodic cleaning removes sediment and water accumulation that can cause fuel quality issues.',
    `last_delivery_date` DATE COMMENT 'Date of the most recent fuel delivery to this tank. Used for inventory reconciliation and delivery scheduling.',
    `last_delivery_volume_gallons` DECIMAL(18,2) COMMENT 'Volume of fuel delivered during the most recent delivery. Used for inventory reconciliation and variance analysis.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal inspection of the tank and associated equipment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tank record was most recently updated. Used for audit trail and change tracking.',
    `last_tightness_test_date` DATE COMMENT 'Date of the most recent precision tightness test performed on the tank to verify structural integrity and absence of leaks. EPA requires periodic testing.',
    `leak_detection_method` STRING COMMENT 'EPA-approved method used to detect leaks from this tank (e.g., automatic tank gauging, vapor monitoring, interstitial monitoring). Required for EPA compliance.. Valid values are `automatic_tank_gauging|vapor_monitoring|groundwater_monitoring|interstitial_monitoring|statistical_inventory_reconciliation`',
    `lining_type` STRING COMMENT 'Type of protective lining installed inside the tank to prevent corrosion and leakage (e.g., epoxy, polyurethane). Critical for EPA compliance and leak prevention.',
    `low_level_alarm_threshold_gallons` DECIMAL(18,2) COMMENT 'Fuel volume level that triggers a low-level alarm. Set above reorder threshold to provide early warning of potential stockout.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured the tank. Used for warranty tracking and technical support.',
    `material` STRING COMMENT 'Primary construction material of the tank shell (e.g., steel, fiberglass, composite). Impacts corrosion risk and maintenance requirements.. Valid values are `steel|fiberglass|composite`',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for this tank type. Used for parts ordering and technical specifications.',
    `next_cleaning_due_date` DATE COMMENT 'Scheduled date for the next tank cleaning. Typically performed every 3-5 years depending on fuel quality and contamination risk.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection. Critical for maintaining EPA compliance and avoiding penalties.',
    `next_tightness_test_due_date` DATE COMMENT 'Scheduled date for the next required tightness test. Used for compliance tracking and maintenance scheduling.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, maintenance history, or special handling instructions for this tank.',
    `operational_status` STRING COMMENT 'Current operational state of the tank. Active tanks are in use; inactive tanks are installed but not currently dispensing; out-of-service tanks require repair; decommissioned tanks have been permanently removed from service.. Valid values are `active|inactive|out_of_service|decommissioned|under_maintenance|temporarily_closed`',
    `overfill_prevention_device` STRING COMMENT 'Type of overfill prevention equipment installed on the tank (e.g., automatic shutoff, high-level alarm). EPA requires overfill prevention for all USTs.. Valid values are `automatic_shutoff|high_level_alarm|ball_float_valve|none`',
    `reorder_threshold_gallons` DECIMAL(18,2) COMMENT 'Minimum fuel volume that triggers a reorder or delivery request. Set based on daily sales velocity and delivery lead time to prevent stockouts.',
    `secondary_containment_flag` BOOLEAN COMMENT 'Indicates whether the tank has secondary containment (double-walled construction or external containment system). Reduces environmental risk and may lower insurance premiums.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer. Used for warranty claims and equipment tracking.',
    `spill_prevention_device` STRING COMMENT 'Type of spill prevention equipment installed at the fill pipe (e.g., catchment basin, spill bucket). EPA requires spill prevention for all USTs.. Valid values are `catchment_basin|spill_bucket|none`',
    `tank_number` STRING COMMENT 'Business identifier for the tank, typically a sequential number assigned at the fuel center (e.g., Tank 1, Tank 2). Used for operational reference and signage.',
    `temperature_monitoring_flag` BOOLEAN COMMENT 'Indicates whether the tank is equipped with temperature monitoring sensors. Temperature data is used for volume compensation and leak detection.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty expires. Used for maintenance planning and cost forecasting.',
    `water_detection_flag` BOOLEAN COMMENT 'Indicates whether the tank is equipped with water detection sensors at the bottom. Water accumulation can cause fuel quality issues and microbial growth.',
    CONSTRAINT pk_tank PRIMARY KEY(`tank_id`)
) COMMENT 'Master record for each underground storage tank (UST) at a fuel center, including tank number, capacity in gallons, fuel grade stored, tank material and lining type, installation date, EPA UST registration number, leak detection method, last tightness test date, and current operational status. Critical for EPA UST compliance and Cold Chain integrity.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`tank_level_reading` (
    `tank_level_reading_id` BIGINT COMMENT 'Unique identifier for the tank level reading record. Primary key for this event log entity.',
    `inventory_reconciliation_id` BIGINT COMMENT 'Identifier of the inventory reconciliation period to which this reading belongs. Links to daily or shift-level reconciliation cycles.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the fuel center and tank are located.',
    `tank_id` BIGINT COMMENT 'Identifier of the fuel storage tank from which this reading was captured. Links to the fuel tank master resource.',
    `alarm_status` STRING COMMENT 'Alarm or alert status reported by the ATG system at the time of reading. Indicates operational issues requiring attention. [ENUM-REF-CANDIDATE: normal|low_level|high_level|water_detected|leak_suspected|sensor_fault|overfill_warning — 7 candidates stripped; promote to reference product]',
    `atg_device_code` STRING COMMENT 'Identifier of the ATG device or sensor that captured this reading. Used for equipment maintenance tracking and data quality auditing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reading record was first inserted into the data system. Distinct from reading_timestamp which is the business event time.',
    `data_quality_flag` STRING COMMENT 'Quality assessment flag indicating the reliability of this reading. Suspect or invalid readings are excluded from compliance reporting and inventory calculations.. Valid values are `valid|suspect|invalid|calibration_required|sensor_error`',
    `delivery_in_progress_flag` BOOLEAN COMMENT 'Indicates whether a fuel delivery was in progress at the time of this reading. True if delivery active; False otherwise. Used to exclude readings during delivery from leak detection calculations.',
    `fuel_grade` STRING COMMENT 'Grade or type of fuel stored in the tank at the time of reading. Octane rating for gasoline or fuel type designation. [ENUM-REF-CANDIDATE: regular_87|midgrade_89|premium_91|premium_93|diesel|e85|e15 — 7 candidates stripped; promote to reference product]',
    `fuel_height_inches` DECIMAL(18,2) COMMENT 'Height of fuel in the tank measured in inches from the tank bottom. Raw measurement used in conjunction with tank strapping tables to calculate volume.',
    `fuel_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Temperature of the fuel in the tank measured in degrees Fahrenheit. Used for temperature correction calculations to derive net volume.',
    `gross_volume_gallons` DECIMAL(18,2) COMMENT 'Total volume of fuel in the tank measured in gallons, not adjusted for temperature. Raw measurement from the ATG probe.',
    `leak_detection_status` STRING COMMENT 'Result of the automatic leak detection test performed by the ATG system. EPA requires continuous leak detection monitoring for underground storage tanks.. Valid values are `pass|fail|inconclusive|test_not_run|system_disabled`',
    `net_volume_gallons` DECIMAL(18,2) COMMENT 'Temperature-corrected volume of fuel in the tank measured in gallons. Adjusted to standard temperature (60°F) for accurate inventory accounting and reconciliation.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by operators or technicians regarding this reading. May include context for alarms, manual interventions, or unusual conditions.',
    `reading_sequence_number` STRING COMMENT 'Sequential number of this reading within the day or shift for the specific tank. Used to order readings chronologically and detect missing observations.',
    `reading_source` STRING COMMENT 'Source or method by which the tank level reading was obtained. ATG automated readings are continuous; manual dipstick readings are performed during inspections or system failures.. Valid values are `ATG_automated|manual_dipstick|calibration|inspection`',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the tank level reading was captured by the ATG system or manual measurement. Primary business event timestamp for this observation.',
    `ullage_gallons` DECIMAL(18,2) COMMENT 'Available capacity remaining in the tank measured in gallons. Calculated as tank capacity minus current gross volume. Used to determine reorder timing and delivery scheduling.',
    `variance_gallons` DECIMAL(18,2) COMMENT 'Calculated variance between expected inventory level and actual measured level in gallons. Used for inventory reconciliation and shrink analysis. Positive variance indicates gain; negative indicates loss.',
    `water_level_inches` DECIMAL(18,2) COMMENT 'Height of water detected at the bottom of the tank measured in inches. Water accumulation indicates contamination risk and must be monitored for EPA compliance and product quality.',
    CONSTRAINT pk_tank_level_reading PRIMARY KEY(`tank_level_reading_id`)
) COMMENT 'Time-series transactional records of tank inventory level readings captured by automatic tank gauges (ATG), including timestamp, tank identifier, gross volume in gallons, net volume (temperature-corrected), water level, ullage (available capacity), and reading source (ATG automated vs. manual dip stick). Supports inventory reconciliation, reorder triggering, and EPA leak detection compliance.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`price` (
    `price_id` BIGINT COMMENT 'Unique identifier for the fuel price record. Primary key for the fuel_price product.',
    `associate_id` BIGINT COMMENT 'Identifier of the manager who approved this price change. Required for manual overrides and discretionary pricing decisions. Supports audit trail and accountability for pricing decisions.',
    `center_id` BIGINT COMMENT 'Identifier of the fuel center location where this price applies. Links to the fuel center master data.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Price changes affect GL entries for cost of goods sold and margin calculations.',
    `grade_id` BIGINT COMMENT 'FK to fuel.fuel_grade',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: Fuel price records must reference the specific pricing rule used to generate the price for audit and optimization reporting.',
    `price_zone_id` BIGINT COMMENT 'FK to pricing.price_zone',
    `promo_offer_id` BIGINT COMMENT 'Identifier of the promotional campaign associated with this price record. Links to promotion master data for campaign tracking and ROI analysis. Null for non-promotional pricing.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: PRICING NEGOTIATION: Fuel price records must reference the supplying vendor for price negotiations, audit trails, and regulatory price filing.',
    `change_amount` DECIMAL(18,2) COMMENT 'Net change in street price per gallon (current price minus prior price). Positive values indicate price increases, negative values indicate decreases.',
    `change_reason_code` STRING COMMENT 'Business reason for the price change event. Competitive response to nearby stations, rack price index threshold breach, promotional campaign, manual manager override, scheduled adjustment, or cost recovery action.. Valid values are `COMPETITIVE|RACK_MOVEMENT|PROMOTIONAL|MANUAL_OVERRIDE|SCHEDULED|COST_RECOVERY`',
    `change_trigger_source` STRING COMMENT 'System or process that initiated the price change. Automated competitive pricing feed, rack index threshold alert, manual manager decision, centralized pricing system recommendation, or promotional calendar event.. Valid values are `AUTOMATED_COMPETITIVE_FEED|RACK_INDEX_THRESHOLD|MANAGER_DECISION|PRICING_SYSTEM|PROMOTIONAL_CALENDAR`',
    `competitor_price_reference` DECIMAL(18,2) COMMENT 'Reference price from competitive intelligence feed representing nearby competitor pricing. Used to justify competitive response price changes and maintain market positioning.',
    `cost_per_gallon` DECIMAL(18,2) COMMENT 'Wholesale cost per gallon paid to the supplier or based on rack pricing. Used for margin calculation and profitability analysis. Business-confidential pricing data.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this price record was first created in the system. Distinct from effective timestamp; represents data capture time for audit and reconciliation purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record. USD for United States Dollar. Supports potential future international expansion.. Valid values are `USD`',
    `effective_timestamp` TIMESTAMP COMMENT 'Date and time when this fuel price becomes active and is displayed on signage and charged at the pump. Supports intraday price changes in response to competitive moves or rack price fluctuations.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when this fuel price is superseded by a new price record. Null for the current active price. Enables complete price history reconstruction and temporal queries.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this price record was last updated. Tracks corrections, adjustments, or status changes after initial creation. Supports data quality audit and change tracking.',
    `loyalty_discount_eligible_flag` BOOLEAN COMMENT 'Indicates whether this fuel grade and price point is eligible for loyalty program fuel discount redemptions. True allows loyalty members to apply cents-per-gallon discounts earned through grocery purchases.',
    `margin_per_gallon` DECIMAL(18,2) COMMENT 'Gross profit margin per gallon calculated as street price minus cost per gallon. Key metric for fuel center profitability and pricing strategy effectiveness.',
    `max_loyalty_discount_cents` DECIMAL(18,2) COMMENT 'Maximum cents-per-gallon discount that can be applied through loyalty program redemption for this fuel grade. Caps the discount to protect margin floors and prevent negative pricing.',
    `notes` STRING COMMENT 'Free-text notes or comments explaining the business context for this price change. Used by pricing managers to document competitive intelligence, market conditions, or special circumstances.',
    `pos_sync_status` STRING COMMENT 'Status of price synchronization to the fuel center POS system and pump controllers. Confirmed indicates successful deployment, failed indicates synchronization error requiring intervention.. Valid values are `PENDING|CONFIRMED|FAILED|ROLLBACK`',
    `pos_sync_timestamp` TIMESTAMP COMMENT 'Date and time when the price change was successfully synchronized to the POS system and pump controllers. Critical for reconciling price effective time with actual system deployment.',
    `prior_street_price` DECIMAL(18,2) COMMENT 'Previous street price per gallon before this price change event. Used for price change magnitude analysis and competitive response tracking.',
    `promotional_price_flag` BOOLEAN COMMENT 'Indicates whether this price is part of a temporary promotional campaign. True for limited-time offers, grand opening specials, or competitive market entry pricing.',
    `rack_price_index` DECIMAL(18,2) COMMENT 'Wholesale terminal rack price index at the time of this price record. Used as a benchmark for cost-based pricing strategies and margin protection rules.',
    `regulatory_posting_required_flag` BOOLEAN COMMENT 'Indicates whether this price change requires regulatory notification or public posting under state fuel pricing transparency laws. True triggers compliance workflow for jurisdictions with price-posting requirements.',
    `regulatory_posting_timestamp` TIMESTAMP COMMENT 'Date and time when the price change was reported to regulatory authorities or posted to public transparency portals. Required for compliance audit trail in regulated jurisdictions.',
    `source_system` STRING COMMENT 'Name of the source system or pricing platform that generated this price record. Examples include Oracle Retail Price Management, proprietary pricing engine, or manual entry system identifier.',
    `street_price` DECIMAL(18,2) COMMENT 'Customer-facing retail price per gallon displayed on the fuel center sign and charged at the pump. This is the base price before any loyalty discounts or promotions.',
    `version_number` STRING COMMENT 'Sequential version number for price changes within the same fuel center and fuel grade. Increments with each price change event to support complete audit trail and change frequency analysis.',
    CONSTRAINT pk_price PRIMARY KEY(`price_id`)
) COMMENT 'Current and historical fuel price records per fuel grade per fuel center, serving as the single source of truth for all pricing and price change event history. Each record captures street price, cost per gallon, margin, effective date/time, expiration date/time, and price zone assignment. Price change audit trail includes prior price, new price, price change reason code (competitive response, rack movement, promotional, manual override), change trigger source (automated competitive feed, rack index threshold, manager decision), approving manager, POS synchronization confirmation status and timestamp. Supports pricing compliance audits, margin analysis, competitive response tracking, and regulatory price-posting requirements.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`price_change_event` (
    `price_change_event_id` BIGINT COMMENT 'Unique identifier for the fuel price change event. Primary key.',
    `associate_id` BIGINT COMMENT 'Identifier of the manager or authorized personnel who approved this price change. Required for audit trail and compliance with pricing authorization policies.',
    `center_id` BIGINT COMMENT 'Identifier of the fuel center location where the price change occurred.',
    `grade_id` BIGINT COMMENT 'Identifier of the fuel grade (regular, mid-grade, premium, diesel) affected by this price change.',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the promotional campaign associated with this price change, if the change was triggered by a marketing promotion or loyalty fuel discount program.',
    `change_trigger` STRING COMMENT 'The business reason or trigger that initiated this price change event. Competitive response indicates reaction to competitor pricing, rack price movement indicates wholesale cost changes, promotional indicates marketing campaign, manual override indicates manager discretion, scheduled adjustment indicates planned periodic changes, cost recovery indicates margin protection.. Valid values are `competitive_response|rack_price_movement|promotional|manual_override|scheduled_adjustment|cost_recovery`',
    `competitor_name` STRING COMMENT 'The name of the competitor whose pricing was referenced for this price change, if applicable.',
    `competitor_reference_price` DECIMAL(18,2) COMMENT 'The competitor fuel price that was used as a reference or benchmark for this price change decision, if applicable. Used for competitive positioning analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this price change event record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record. Typically USD for US-based grocery retail fuel operations.. Valid values are `USD`',
    `effective_timestamp` TIMESTAMP COMMENT 'The exact date and time when the new fuel price became effective at the pump. This is the principal business event timestamp for the price change.',
    `event_number` STRING COMMENT 'Business-facing unique identifier or sequence number for the price change event, used for audit and reference purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this price change event record was last modified or updated. Used for audit trail and change tracking.',
    `loyalty_discount_applied` BOOLEAN COMMENT 'Boolean flag indicating whether this price change includes or is related to a loyalty program fuel discount redemption structure.',
    `margin_per_gallon` DECIMAL(18,2) COMMENT 'The calculated gross margin per gallon (new_price minus rack_price minus taxes and fees). Critical metric for profitability analysis and pricing strategy.',
    `new_price` DECIMAL(18,2) COMMENT 'The new fuel price per gallon that became effective with this price change event.',
    `pos_sync_status` STRING COMMENT 'Confirmation status indicating whether the price change has been successfully synchronized to the fuel center POS system and pump controllers. Critical for ensuring price accuracy at transaction time.. Valid values are `pending|synchronized|failed|manual_intervention_required`',
    `pos_sync_timestamp` TIMESTAMP COMMENT 'The date and time when the price change was successfully synchronized to the POS system. Used to measure synchronization lag and ensure pricing integrity.',
    `price_change_amount` DECIMAL(18,2) COMMENT 'The absolute difference between the new price and prior price (new_price minus prior_price). Positive values indicate price increase, negative values indicate price decrease.',
    `price_change_notes` STRING COMMENT 'Free-text notes or comments from the approving manager or pricing analyst explaining the rationale, context, or special circumstances for this price change.',
    `price_change_percentage` DECIMAL(18,2) COMMENT 'The percentage change in price calculated as ((new_price - prior_price) / prior_price) * 100. Used for margin and competitive analysis.',
    `price_sign_update_timestamp` TIMESTAMP COMMENT 'The date and time when the fuel center price sign was updated to display the new price.',
    `price_sign_updated` BOOLEAN COMMENT 'Boolean flag indicating whether the physical or digital price sign at the fuel center has been updated to reflect the new price. Required for customer transparency and regulatory compliance.',
    `prior_price` DECIMAL(18,2) COMMENT 'The fuel price per gallon that was in effect immediately before this price change event.',
    `rack_price` DECIMAL(18,2) COMMENT 'The wholesale terminal or rack price for this fuel grade at the time of the price change. Used for margin analysis and cost-based pricing decisions.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this price change was reviewed for compliance with state and federal fuel pricing regulations, including price gouging laws and EPA requirements.',
    CONSTRAINT pk_price_change_event PRIMARY KEY(`price_change_event_id`)
) COMMENT 'Transactional record of every fuel price change event at a fuel center, capturing the prior price, new price, fuel grade, effective timestamp, change trigger (competitive response, rack price movement, promotional, manual override), approving manager, and POS synchronization confirmation status. Provides a full audit trail for pricing compliance and margin analysis.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`fuel_transaction` (
    `fuel_transaction_id` BIGINT COMMENT 'Unique identifier for each fuel dispensing transaction event. Primary key for the fuel transaction record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allocates transaction revenue to the cost center for expense tracking and budgeting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each fuel sale must be posted to a GL account for revenue recognition.',
    `grade_id` BIGINT COMMENT 'FK to fuel.fuel_grade',
    `household_id` BIGINT COMMENT 'Foreign key linking to customer.household. Business justification: Needed for household‑level fuel rewards program: aggregate fuel spend per household to determine eligibility, tier status, and regulatory reporting of SNAP/EBT usage.',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.payment_method. Business justification: REQUIRED: Link fuel sale to stored payment method for refunds, tokenization, and loyalty reward calculations.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: REQUIRED: Integrated POS transaction linking fuel sale to grocery order for combined loyalty points, sales reporting, and financial reconciliation.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: REQUIRED: Reconcile each fuel sale with its POS payment record for daily financial reporting and settlement.',
    `associate_id` BIGINT COMMENT 'Driver identifier captured during fleet card transaction. Used for driver-level fuel consumption reporting and expense allocation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Links each fuel sale to a profit center for profitability analysis.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Required for tracking which promo offer discounts a fuel transaction used, enabling redemption reporting and financial reconciliation.',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to customer.shopper. Business justification: Required for loyalty and CLTV reporting: each fuel purchase must be linked to the shopper who made it to calculate rewards, churn risk, and compliance with fuel discount regulations.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the fuel center is located. Links to the store master data.',
    `authorization_code` STRING COMMENT 'Payment authorization code received from payment processor. Used for payment reconciliation and dispute resolution.. Valid values are `^[A-Z0-9]{6,12}$`',
    `carwash_bundled_flag` BOOLEAN COMMENT 'Indicates whether a carwash service was bundled with this fuel purchase. Used for cross-sell analytics and bundled promotion tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this transaction record was first created in the database. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction. Typically USD for US operations.. Valid values are `^[A-Z]{3}$`',
    `epa_reporting_flag` BOOLEAN COMMENT 'Indicates whether this transaction requires inclusion in EPA emissions compliance reporting. Used for regulatory reporting and environmental compliance tracking.',
    `federal_excise_tax` DECIMAL(18,2) COMMENT 'Federal excise tax amount collected on this fuel transaction. Required for IRS Form 720 quarterly federal excise tax reporting.',
    `fleet_card_number` STRING COMMENT 'Fleet card number used for commercial vehicle fuel purchases. Supports RFID fleet card transaction processing and fleet account reconciliation.. Valid values are `^[A-Z0-9]{10,20}$`',
    `fuel_discount_cents_per_gallon` DECIMAL(18,2) COMMENT 'Discount amount in cents per gallon applied through loyalty program redemption. Used for loyalty-linked fuel discount reconciliation and program cost tracking.',
    `gallons_dispensed` DECIMAL(18,2) COMMENT 'Volume of fuel dispensed in gallons. Primary measure for volume sales reporting, inventory depletion, and tank level management.',
    `gross_sale_amount` DECIMAL(18,2) COMMENT 'Total sale amount before any discounts or loyalty redemptions are applied. Calculated as gallons dispensed multiplied by unit price.',
    `local_excise_tax` DECIMAL(18,2) COMMENT 'Local or municipal excise tax amount collected on this fuel transaction where applicable.',
    `loyalty_card_number` STRING COMMENT 'Customer loyalty card number used for this transaction. Links to customer loyalty profile for discount redemption and points accrual tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this transaction record was last modified. Used for audit trail and change tracking.',
    `net_amount_charged` DECIMAL(18,2) COMMENT 'Final amount charged to the customer after all discounts are applied. This is the revenue recognized for the transaction.',
    `payment_method` STRING COMMENT 'Payment instrument used for the transaction. Distinguishes between credit card, debit card, fleet card, Electronic Benefits Transfer (EBT), cash, and mobile payment methods.. Valid values are `credit|debit|fleet_card|ebt|cash|mobile_payment`',
    `pos_transaction_reference` STRING COMMENT 'Reference number linking this fuel transaction to the corresponding POS system transaction record for payment reconciliation and receipt generation.. Valid values are `^[A-Z0-9-]{1,50}$`',
    `prepay_flag` BOOLEAN COMMENT 'Indicates whether this was a prepay transaction where payment was authorized before fuel dispensing. Used for fraud prevention and payment processing workflow.',
    `promotion_code` STRING COMMENT 'Promotional campaign code applied to this transaction. Used for tracking effectiveness of fuel pricing promotions and temporary price reductions.. Valid values are `^[A-Z0-9]{4,20}$`',
    `pump_number` STRING COMMENT 'Physical pump identifier at the fuel center where fuel was dispensed. Used for equipment tracking and maintenance scheduling.. Valid values are `^[A-Z0-9]{1,10}$`',
    `receipt_number` STRING COMMENT 'Unique receipt number printed for the customer. Used for customer service inquiries and transaction lookup.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `state_excise_tax` DECIMAL(18,2) COMMENT 'State excise tax amount collected on this fuel transaction. Required for state-level fuel tax reporting and remittance.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the transaction. Includes federal, state, and local fuel excise taxes for regulatory reporting and remittance.',
    `terminal_code` STRING COMMENT 'Payment terminal identifier where the transaction was processed. Used for terminal reconciliation and equipment tracking.. Valid values are `^[A-Z0-9]{5,15}$`',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of discount applied to this transaction. Calculated as fuel discount cents per gallon multiplied by gallons dispensed.',
    `transaction_status` STRING COMMENT 'Current status of the fuel transaction in its lifecycle. Tracks whether transaction was successfully completed, voided, refunded, or failed.. Valid values are `completed|voided|refunded|pending|failed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel dispensing transaction occurred at the pump. Primary business event timestamp for volume sales reporting and reconciliation.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per gallon at the time of transaction. Reflects current fuel grade pricing including any temporary price reductions or promotional pricing.',
    `vehicle_identification_number` STRING COMMENT 'Vehicle identification number for fleet card transactions. Standard 17-character VIN used for fleet vehicle tracking and reporting.. Valid values are `^[A-HJ-NPR-Z0-9]{17}$`',
    `vehicle_odometer_reading` STRING COMMENT 'Odometer reading captured at time of fleet card transaction. Used for fleet management reporting and mileage tracking.',
    CONSTRAINT pk_fuel_transaction PRIMARY KEY(`fuel_transaction_id`)
) COMMENT 'Core transactional record for every fuel dispensing event at a pump, capturing transaction date and time, pump number, fuel grade, gallons dispensed, unit price, gross sale amount, payment method (credit/debit/fleet card/EBT/cash), loyalty card number, fuel discount applied (cents-per-gallon), net amount charged, and POS transaction reference. Primary source for volume sales reporting and loyalty redemption reconciliation.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`fleet_card_account` (
    `fleet_card_account_id` BIGINT COMMENT 'Unique identifier for the fleet card account. Primary key.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Account manager associate oversees fleet card accounts; required for account audit and billing responsibility reports.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fuel.fuel_center. Business justification: Fleet card accounts are managed per fuel center; linking provides clear ownership and reporting.',
    `account_close_date` DATE COMMENT 'Date when the fleet card account was closed or terminated. Null for active accounts.',
    `account_number` STRING COMMENT 'Externally-known unique account number assigned to the fleet operator for billing and identification purposes.. Valid values are `^[A-Z0-9]{8,16}$`',
    `account_open_date` DATE COMMENT 'Date when the fleet card account was first opened and activated for use.',
    `account_status` STRING COMMENT 'Current lifecycle status of the fleet card account indicating whether it is operational, suspended, or closed.. Valid values are `active|suspended|closed|pending_activation|delinquent|frozen`',
    `active_cards_count` STRING COMMENT 'Current count of active fleet cards under this account that are authorized for transactions.',
    `authorized_fuel_grades` STRING COMMENT 'Comma-separated list of fuel grades (regular, mid-grade, premium, diesel) that cards under this account are authorized to purchase. [ENUM-REF-CANDIDATE: regular|mid_grade|premium|diesel|e85|biodiesel|cng — promote to reference product]',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the fleet card account contract automatically renews upon expiration.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for invoice delivery and account correspondence.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (suite, unit, building number).',
    `billing_city` STRING COMMENT 'City name for the billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_cycle_day` STRING COMMENT 'Day of the month (1-31) when the billing cycle closes and invoices are generated for this fleet account.',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `billing_state_province` STRING COMMENT 'Two-letter state or province code for the billing address.. Valid values are `^[A-Z]{2}$`',
    `card_program_type` STRING COMMENT 'Type of fleet card program under which this account operates (proprietary store-branded, WEX, Voyager, Mastercard Fleet, Visa Fleet, Fleet One).. Valid values are `proprietary|wex|voyager|mastercard_fleet|visa_fleet|fleet_one`',
    `contract_expiration_date` DATE COMMENT 'Date when the current fleet card contract or agreement expires and requires renewal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fleet card account record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit limit extended to the fleet account for fuel purchases and related transactions.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this account (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `daily_transaction_limit_count` STRING COMMENT 'Maximum number of fuel transactions allowed per card per day under this account.',
    `daily_volume_limit_gallons` DECIMAL(18,2) COMMENT 'Maximum total fuel volume (in gallons) that can be purchased per card per day under this account.',
    `discount_rate_per_gallon` DECIMAL(18,2) COMMENT 'Per-gallon discount rate (in currency units) applied to fuel purchases for this fleet account.',
    `discount_tier` STRING COMMENT 'Pricing tier or discount level assigned to the fleet account based on volume commitments or negotiated contracts.. Valid values are `standard|bronze|silver|gold|platinum`',
    `fleet_operator_name` STRING COMMENT 'Legal or business name of the commercial fleet operator or company holding this account.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fleet card account record was last updated or modified.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent fuel transaction processed under this fleet account.',
    `loyalty_program_linked_flag` BOOLEAN COMMENT 'Indicates whether this fleet account is linked to the retailers loyalty program for additional fuel discount redemptions.',
    `notes` STRING COMMENT 'Free-text field for internal notes, special instructions, or account-specific comments related to this fleet account.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due (e.g., Net 30, Net 15).',
    `per_fill_volume_cap_gallons` DECIMAL(18,2) COMMENT 'Maximum fuel volume (in gallons) allowed for a single transaction per card under this account.',
    `pin_required_flag` BOOLEAN COMMENT 'Indicates whether a PIN is required for all card transactions under this account for enhanced security.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for account communications, billing notifications, and support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person for this fleet account (fleet manager or account administrator).',
    `primary_contact_phone` STRING COMMENT 'Primary phone number for the fleet account contact person.. Valid values are `^+?[0-9]{10,15}$`',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether the fleet cards under this account use RFID technology for contactless pump authorization.',
    `tax_id_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID for the fleet operator, used for tax reporting and compliance.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `total_cards_issued` STRING COMMENT 'Total number of individual fleet cards issued under this account across all vehicles and drivers.',
    `weekly_spending_limit_amount` DECIMAL(18,2) COMMENT 'Maximum total spending allowed per card per week under this account.',
    CONSTRAINT pk_fleet_card_account PRIMARY KEY(`fleet_card_account_id`)
) COMMENT 'Master record for RFID fleet card accounts and all associated individual fleet cards used by commercial fleet customers at fuel centers. Account level: account number, fleet operator name, card program type (proprietary/WEX/Voyager/Mastercard Fleet), credit limit, billing cycle, discount tier, and account status. Card level: card number, vehicle ID or driver ID, card issue and expiration dates, PIN status, authorized fuel grades, per-fill volume cap, daily/weekly transaction limits, and card status (active/suspended/lost/expired). Serves as the SSOT for fleet card program management including account setup, card issuance lifecycle, RFID-based pump authorization, per-vehicle and per-driver fueling controls, fleet billing reconciliation, and card suspension/replacement workflows.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`fleet_card` (
    `fleet_card_id` BIGINT COMMENT 'Unique identifier for the fleet card record. Primary key.',
    `associate_id` BIGINT COMMENT 'Identifier of the driver or employee associated with this fleet card. Used for driver-specific cards to track fuel purchases per individual. Nullable for vehicle-specific cards.',
    `fleet_card_account_id` BIGINT COMMENT 'Reference to the parent fleet card account that this individual card belongs to. Links to the fleet_card_account product.',
    `authorized_fuel_grades` STRING COMMENT 'Comma-separated list of fuel grades that this fleet card is authorized to purchase (e.g., regular, mid-grade, premium, diesel). Used to enforce fuel type restrictions at the pump.',
    `cancellation_date` DATE COMMENT 'The date when the fleet card was permanently cancelled and removed from service. Nullable if the card is still active or suspended.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the fleet card was cancelled (e.g., vehicle sold, driver terminated, account closed). Nullable if card is not cancelled.',
    `card_format` STRING COMMENT 'The physical format and technology of the fleet card: magnetic stripe, chip (EMV), RFID, contactless (NFC), or hybrid (multiple technologies).. Valid values are `magnetic_stripe|chip|rfid|contactless|hybrid`',
    `card_number` STRING COMMENT 'The unique RFID fleet card number embossed or encoded on the physical card. Used for transaction authorization at fuel pumps.',
    `card_replacement_reason` STRING COMMENT 'Reason why this fleet card was issued as a replacement for a previous card. Tracks the history of card reissuance events. [ENUM-REF-CANDIDATE: lost|stolen|damaged|expired|compromised|upgrade|none — 7 candidates stripped; promote to reference product]',
    `card_status` STRING COMMENT 'Current lifecycle status of the fleet card indicating whether it is active and authorized for use, or inactive due to suspension, loss, theft, expiration, or cancellation.. Valid values are `active|suspended|lost|stolen|expired|cancelled`',
    `card_type` STRING COMMENT 'Classification of the fleet card indicating its intended use: vehicle-specific, driver-specific, universal (any vehicle/driver), temporary, emergency, or contractor card.. Valid values are `vehicle|driver|universal|temporary|emergency|contractor`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fleet card record was first created in the system. Used for audit trail and data lineage tracking.',
    `daily_spend_limit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount that can be spent per day using this fleet card. Used for budget control and fraud prevention. Nullable if no limit is set.',
    `daily_transaction_limit` STRING COMMENT 'Maximum number of fuel transactions allowed per day using this fleet card. Used to detect and prevent fraudulent activity. Nullable if no limit is set.',
    `day_of_week_restrictions` STRING COMMENT 'Days of the week when this fleet card is authorized for use (e.g., Monday-Friday for weekday-only vehicles). Formatted as comma-separated day names or codes. Nullable if no day restrictions apply.',
    `expiration_date` DATE COMMENT 'The date when the fleet card expires and is no longer valid for transactions. Cards must be renewed or replaced before this date.',
    `issue_date` DATE COMMENT 'The date when the fleet card was issued and activated for use.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this fleet card record was last updated. Used for audit trail and change tracking.',
    `loyalty_discount_eligible_flag` BOOLEAN COMMENT 'Indicates whether transactions using this fleet card are eligible for loyalty-linked fuel discount redemptions. True if eligible, false if excluded from loyalty programs.',
    `merchant_category_restrictions` STRING COMMENT 'Comma-separated list of merchant category codes (MCC) where this fleet card is authorized or restricted. Used to limit card usage to fuel purchases only or allow additional categories like maintenance.',
    `odometer_prompt_required_flag` BOOLEAN COMMENT 'Indicates whether the driver must enter the vehicle odometer reading at the pump when using this fleet card. True if odometer entry is mandatory, false otherwise.',
    `per_fill_volume_cap_gallons` DECIMAL(18,2) COMMENT 'Maximum number of gallons that can be purchased in a single transaction using this fleet card. Used to prevent fraud and enforce fueling limits. Nullable if no cap is set.',
    `pin_enabled_flag` BOOLEAN COMMENT 'Indicates whether a PIN is required for transactions using this fleet card. True if PIN authentication is enabled, false if card can be used without PIN.',
    `pin_last_changed_date` DATE COMMENT 'The date when the PIN for this fleet card was last changed or reset. Used for security auditing and PIN rotation policy enforcement.',
    `replaced_card_number` STRING COMMENT 'The card number of the previous fleet card that this card replaces. Used to maintain card replacement history and link transactions across card generations. Nullable if this is the original card.',
    `rfid_technology_type` STRING COMMENT 'The type of RFID technology used in the fleet card: passive (no battery, powered by reader), active (battery-powered), or semi-passive (battery-assisted passive).. Valid values are `passive|active|semi_passive`',
    `suspension_date` DATE COMMENT 'The date when the fleet card was suspended. Nullable if the card has never been suspended or is currently active.',
    `suspension_reason` STRING COMMENT 'Free-text explanation of why the fleet card was suspended (e.g., suspected fraud, policy violation, vehicle out of service). Nullable if card is not suspended.',
    `time_of_day_restrictions` STRING COMMENT 'Time windows when this fleet card is authorized for use (e.g., 06:00-22:00 for day-shift drivers). Formatted as comma-separated time ranges. Nullable if no time restrictions apply.',
    `vehicle_number` STRING COMMENT 'Identifier of the vehicle associated with this fleet card. Used for vehicle-specific cards to track fuel consumption per vehicle. Nullable for driver-specific or universal cards.',
    CONSTRAINT pk_fleet_card PRIMARY KEY(`fleet_card_id`)
) COMMENT 'Individual RFID fleet card record linked to a fleet card account, capturing card number, vehicle ID or driver ID associated with the card, card issue date, expiration date, PIN status, authorized fuel grades, per-fill volume cap, and card status (active/suspended/lost/expired). Enables per-vehicle or per-driver fueling controls and transaction attribution.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` (
    `loyalty_fuel_redemption_id` BIGINT COMMENT 'Unique identifier for the loyalty fuel redemption transaction. Primary key.',
    `fuel_transaction_id` BIGINT COMMENT 'Reference to the Point of Sale (POS) fuel transaction at the pump where the discount was applied.',
    `membership_id` BIGINT COMMENT 'Identifier of the loyalty program member who redeemed the fuel discount.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: REQUIRED: Tie fuel loyalty redemption to the overall order to reflect total loyalty activity in order‑level reports and customer satisfaction metrics.',
    `program_config_id` BIGINT COMMENT 'Identifier of the external partner loyalty program (e.g., airline miles, credit card rewards) if the discount originated from a partner reward. Null if internal loyalty only.',
    `promo_offer_id` BIGINT COMMENT 'Identifier of the promotional campaign or offer that enabled this fuel discount. Null if not part of a specific promotion.',
    `pump_id` BIGINT COMMENT 'Identifier of the specific fuel pump where the redemption was processed.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the fuel center is located and the redemption occurred.',
    `channel` STRING COMMENT 'Channel or interface through which the loyalty discount was activated or redeemed (at-pump, mobile app, kiosk, cashier-assisted).. Valid values are `pump|mobile_app|kiosk|cashier`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount amount. Typically USD for US-based grocery retail operations.. Valid values are `USD`',
    `discount_expiration_date` DATE COMMENT 'Date by which the fuel discount offer must be redeemed. Format: yyyy-MM-dd. Null if no expiration.',
    `discount_rate_cents_per_gallon` DECIMAL(18,2) COMMENT 'The discount rate applied to the fuel purchase, expressed in cents per gallon (e.g., 10 cents off per gallon).',
    `fleet_card_number_masked` STRING COMMENT 'Masked fleet card number used for the transaction (e.g., last 4 digits only). Applicable for fleet card transactions tracked via Radio Frequency Identification (RFID).',
    `fuel_grade` STRING COMMENT 'The grade or type of fuel purchased (e.g., regular, midgrade, premium, diesel) to which the discount was applied.. Valid values are `regular|midgrade|premium|diesel|e85|unleaded`',
    `gallons_discounted` DECIMAL(18,2) COMMENT 'Total number of gallons of fuel to which the loyalty discount was applied during this transaction.',
    `loyalty_tier` STRING COMMENT 'Loyalty program tier or membership level of the customer at the time of redemption (e.g., silver, gold, platinum). May influence discount eligibility or rate.',
    `max_discount_limit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount of discount allowed per transaction based on loyalty program rules or promotional terms. Used to cap total discount.',
    `max_gallons_limit` DECIMAL(18,2) COMMENT 'Maximum number of gallons eligible for discount per transaction based on loyalty program rules or promotional terms.',
    `payment_method` STRING COMMENT 'Payment instrument used for the fuel transaction (credit card, debit card, fleet card, mobile payment, cash). Distinct from redemption source.. Valid values are `credit_card|debit_card|fleet_card|mobile_payment|cash`',
    `points_balance_after` BIGINT COMMENT 'Loyalty members points balance immediately after this fuel discount redemption.',
    `points_balance_before` BIGINT COMMENT 'Loyalty members points balance immediately before this fuel discount redemption.',
    `points_redeemed` BIGINT COMMENT 'Number of loyalty program points redeemed to obtain this fuel discount. Null if discount source is not loyalty points.',
    `pos_terminal_code` STRING COMMENT 'Identifier of the Point of Sale (POS) terminal or pump controller that processed the redemption transaction.',
    `reconciliation_date` DATE COMMENT 'Date when the fuel redemption transaction was reconciled with the loyalty program system. Format: yyyy-MM-dd.',
    `reconciliation_status` STRING COMMENT 'Status of the redemption record in the loyalty program reconciliation process (reconciled with loyalty system, pending, discrepancy identified, adjusted).. Valid values are `reconciled|pending|discrepancy|adjusted`',
    `redemption_source` STRING COMMENT 'Source or origin of the fuel discount being redeemed (e.g., loyalty points accumulated, promotional offer, partner reward program, credit card linked discount).. Valid values are `loyalty_points|promotional_offer|partner_reward|credit_card_linked|fleet_card|bonus_points`',
    `redemption_status` STRING COMMENT 'Current status of the fuel discount redemption transaction in its lifecycle (completed, pending, reversed, failed, expired).. Valid values are `completed|pending|reversed|failed|expired`',
    `redemption_timestamp` TIMESTAMP COMMENT 'Date and time when the loyalty fuel discount was redeemed at the pump. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `reversal_reason` STRING COMMENT 'Reason for reversing or voiding the fuel discount redemption, if applicable. Null if redemption was not reversed.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Total dollar value of the fuel discount redeemed in this transaction (calculated as discount rate × gallons discounted).',
    `transaction_receipt_number` STRING COMMENT 'Receipt or confirmation number printed for the customer at the pump, linking the fuel purchase to the loyalty redemption.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    CONSTRAINT pk_loyalty_fuel_redemption PRIMARY KEY(`loyalty_fuel_redemption_id`)
) COMMENT 'Transactional record of loyalty-linked fuel discount redemptions at the pump, capturing redemption date and time, loyalty member identifier, fuel transaction reference, discount rate (cents-per-gallon), total gallons discounted, total discount dollar value, redemption source (loyalty points, promotional offer, partner reward), and post-redemption points balance impact. Links fuel domain to the loyalty domain for program reconciliation.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`delivery` (
    `delivery_id` BIGINT COMMENT 'Unique identifier for the fuel delivery record. Primary key for the fuel delivery lifecycle from order placement through receipt confirmation.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier delivering the fuel. May be the same as distributor or a third-party logistics provider.',
    `center_id` BIGINT COMMENT 'Identifier of the fuel center receiving the delivery. Links to the fuel center location where fuel is being replenished.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns fuel delivery expense to the cost center responsible for inventory replenishment.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Needed for driver performance, safety incident, and EPA reporting; delivery driver is an associate employee.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Delivery costs are posted to a GL account for cost of goods sold.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Fuel procurement uses purchase orders; linking deliveries to orders enables spend reporting and order‑to‑receipt reconciliation.',
    `supplier_id` BIGINT COMMENT 'Identifier of the fuel distributor or supplier fulfilling the delivery. Links to the vendor providing the fuel.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: TRACEABILITY: Delivery manifests record the exact supplier site of origin for tax, traceability, and inventory reconciliation.',
    `tank_id` BIGINT COMMENT 'Identifier of the underground storage tank receiving the fuel delivery. Links to the specific tank within the fuel center.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the fuel delivery occurred. Used for reconciliation and variance analysis against scheduled date.',
    `actual_delivery_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the fuel delivery was completed. Marks the end of the physical fuel transfer and receipt confirmation.',
    `actual_delivery_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the fuel delivery began. Marks the start of the physical fuel transfer process.',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading number for the fuel shipment. Legal document issued by the carrier acknowledging receipt of cargo for shipment.. Valid values are `^[A-Z0-9]{8,25}$`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost of the fuel delivery in USD. Includes fuel product cost and may include transportation charges.',
    `cost_per_gallon` DECIMAL(18,2) COMMENT 'Unit cost per gallon of fuel delivered in USD. Used for inventory valuation and margin analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fuel delivery record was first created in the system. Marks the beginning of the delivery lifecycle tracking.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the fuel delivery. Tracks the delivery from scheduling through completion or cancellation. [ENUM-REF-CANDIDATE: scheduled|in_transit|arrived|in_progress|completed|cancelled|failed — 7 candidates stripped; promote to reference product]',
    `distributor_name` STRING COMMENT 'Name of the fuel distributor or supplier company. Business name of the vendor fulfilling the delivery.',
    `driver_signature_captured` BOOLEAN COMMENT 'Indicates whether the driver signature was captured electronically or on paper at delivery completion. Used for proof of delivery validation.',
    `epa_compliance_verified` BOOLEAN COMMENT 'Indicates whether EPA emissions and environmental compliance was verified for the delivery. Tracks adherence to underground storage tank regulations.',
    `estimated_gallons_ordered` DECIMAL(18,2) COMMENT 'Estimated volume of fuel ordered in gallons. Represents the planned quantity at the time of order placement.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Separate freight or transportation charge for the delivery in USD. May be itemized separately from fuel product cost.',
    `fuel_grade` STRING COMMENT 'Grade or type of fuel being delivered. Indicates octane rating for gasoline or fuel type classification. [ENUM-REF-CANDIDATE: regular_87|midgrade_89|premium_91|premium_93|diesel|e85|e15 — 7 candidates stripped; promote to reference product]',
    `gross_gallons_delivered` DECIMAL(18,2) COMMENT 'Gross volume of fuel delivered in gallons before temperature correction. Raw measurement from the delivery truck meter.',
    `invoice_number` STRING COMMENT 'Vendor invoice number for the fuel delivery. Links the delivery to accounts payable for payment processing.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fuel delivery record was last updated. Tracks the most recent change to any delivery attribute.',
    `net_gallons_delivered` DECIMAL(18,2) COMMENT 'Net volume of fuel delivered in gallons after temperature correction to 60°F. Temperature-adjusted volume used for inventory and billing.',
    `notes` STRING COMMENT 'Free-text notes or comments about the delivery. Captures exceptions, issues, or special circumstances during delivery execution.',
    `order_confirmation_reference` STRING COMMENT 'Confirmation reference number from the fuel order placement system. Links the delivery to the original replenishment order.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `post_delivery_tank_level_gallons` DECIMAL(18,2) COMMENT 'Fuel tank level in gallons after the delivery was completed. Final measurement from Automatic Tank Gauge (ATG) system used for reconciliation and shrink analysis.',
    `pre_delivery_tank_level_gallons` DECIMAL(18,2) COMMENT 'Fuel tank level in gallons before the delivery began. Baseline measurement from Automatic Tank Gauge (ATG) system used for reconciliation.',
    `quality_test_passed` BOOLEAN COMMENT 'Indicates whether the delivered fuel passed quality testing at receipt. Used for quality assurance and compliance tracking.',
    `reorder_trigger_type` STRING COMMENT 'Method that triggered the fuel replenishment order. Indicates whether order was automated via Automatic Tank Gauge (ATG) system, Computer-Assisted Ordering (CAO), or manually placed.. Valid values are `atg_automated|cao_automated|manual_order|emergency_order`',
    `scheduled_delivery_date` DATE COMMENT 'Planned date for the fuel delivery. Used for supply planning and fuel availability management.',
    `scheduled_delivery_end_time` TIMESTAMP COMMENT 'End of the scheduled delivery time window. Defines the latest expected time for delivery completion.',
    `scheduled_delivery_start_time` TIMESTAMP COMMENT 'Beginning of the scheduled delivery time window. Precise timestamp for when the delivery is expected to begin.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Temperature of the fuel at the time of delivery in degrees Fahrenheit. Used for temperature correction calculations to determine net gallons.',
    `ticket_number` STRING COMMENT 'External delivery ticket number issued by the carrier or distributor. Serves as the business identifier for the delivery transaction.. Valid values are `^[A-Z0-9]{6,20}$`',
    `truck_number` STRING COMMENT 'Identification number of the delivery truck or tanker. Vehicle identifier for tracking and compliance purposes.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `variance_gallons` DECIMAL(18,2) COMMENT 'Difference between estimated gallons ordered and net gallons delivered. Used for supply planning accuracy analysis and shrink detection.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between estimated and actual delivery quantity. Calculated as (variance_gallons / estimated_gallons_ordered) * 100.',
    CONSTRAINT pk_delivery PRIMARY KEY(`delivery_id`)
) COMMENT 'Complete lifecycle record of fuel replenishment from planning through delivery receipt for each fuel center. Schedule phase: scheduled delivery date/time window, fuel grade, estimated gallons ordered, distributor/carrier assignment, reorder trigger (ATG-automated CAO vs manual), order status, and confirmation reference. Delivery execution phase: actual delivery date/time, carrier/distributor name, bill of lading number, gross gallons delivered, net gallons (temperature-corrected), delivery ticket number, pre-delivery and post-delivery tank levels, driver signature confirmation, and variance from scheduled quantity. Serves as the SSOT for the entire fuel replenishment lifecycle from order placement through receipt confirmation, supporting supply planning, fuel availability management, inventory reconciliation, and shrink analysis.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the fuel delivery schedule record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for delivering the fuel shipment.',
    `center_id` BIGINT COMMENT 'Identifier of the fuel center location receiving the delivery.',
    `store_location_id` BIGINT COMMENT 'Identifier of the parent store location associated with the fuel center.',
    `supplier_id` BIGINT COMMENT 'Identifier of the fuel distributor or vendor assigned to fulfill this delivery.',
    `tank_id` BIGINT COMMENT 'Identifier of the specific underground storage tank at the fuel center that will receive this delivery.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The actual date and time when the fuel delivery was completed, if applicable.',
    `actual_gallons_delivered` DECIMAL(18,2) COMMENT 'The actual volume of fuel in gallons that was delivered, recorded upon completion.',
    `bill_of_lading_number` STRING COMMENT 'The bill of lading number issued by the carrier for this fuel shipment, serving as a receipt and contract.. Valid values are `^BOL-[A-Z0-9]{8,20}$`',
    `cancelled_reason` STRING COMMENT 'Explanation or reason code if the delivery schedule was cancelled (e.g., supplier issue, weather, tank maintenance).',
    `confirmation_reference` STRING COMMENT 'External confirmation number or reference code provided by the distributor or carrier for this scheduled delivery.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `contact_name` STRING COMMENT 'Name of the on-site contact person at the fuel center for coordinating the delivery.',
    `contact_phone` STRING COMMENT 'Phone number of the on-site contact person for delivery coordination.. Valid values are `^+?[0-9]{10,15}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user or automated process that created this delivery schedule record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the delivery cost (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `current_tank_level_gallons` DECIMAL(18,2) COMMENT 'The current fuel inventory level in gallons in the target tank at the time the delivery was scheduled.',
    `delivery_instructions` STRING COMMENT 'Special instructions or notes for the carrier regarding site access, safety protocols, or delivery procedures.',
    `driver_name` STRING COMMENT 'Name of the driver who delivered the fuel shipment.',
    `epa_compliance_flag` BOOLEAN COMMENT 'Indicates whether this delivery meets EPA environmental and emissions compliance requirements (True/False).',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The estimated total cost in USD for this fuel delivery, including product and transportation charges.',
    `estimated_gallons` DECIMAL(18,2) COMMENT 'The estimated volume of fuel in gallons ordered for this delivery.',
    `fuel_grade` STRING COMMENT 'The grade or type of fuel scheduled for delivery (e.g., Regular, Premium, Diesel).. Valid values are `Regular|Midgrade|Premium|Diesel|E85|Unleaded`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user or automated process that last modified this delivery schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery schedule record was last updated or modified.',
    `order_number` STRING COMMENT 'Business identifier for the fuel order associated with this delivery schedule.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the delivery schedule (e.g., Scheduled, Confirmed, In Transit, Delivered, Cancelled, Delayed).. Valid values are `Scheduled|Confirmed|In_Transit|Delivered|Cancelled|Delayed`',
    `priority_level` STRING COMMENT 'The urgency or priority level assigned to this delivery to prevent out-of-stock (OOS) conditions.. Valid values are `Standard|High|Critical|Emergency`',
    `quality_certification_number` STRING COMMENT 'Certification or quality assurance reference number confirming the fuel meets EPA and industry standards.. Valid values are `^QC-[A-Z0-9]{6,20}$`',
    `reorder_threshold_gallons` DECIMAL(18,2) COMMENT 'The inventory level in gallons at which a reorder is automatically triggered to prevent stockouts.',
    `reorder_trigger_type` STRING COMMENT 'The method that triggered the reorder: ATG (Automatic Tank Gauge) automated, CAO (Computer-Assisted Ordering) automated, manual, or emergency.. Valid values are `ATG_Automated|CAO_Automated|Manual|Emergency`',
    `rescheduled_from_date` DATE COMMENT 'The original scheduled delivery date if this delivery was rescheduled from a prior date.',
    `scheduled_delivery_date` DATE COMMENT 'The planned date on which the fuel delivery is scheduled to occur.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The end of the scheduled delivery time window, including date and time.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The beginning of the scheduled delivery time window, including date and time.',
    `temperature_at_delivery` DECIMAL(18,2) COMMENT 'The fuel temperature in degrees Fahrenheit recorded at the time of delivery, used for volume correction calculations.',
    `unit_price_per_gallon` DECIMAL(18,2) COMMENT 'The contracted or estimated price per gallon in USD for the fuel being delivered.',
    `variance_gallons` DECIMAL(18,2) COMMENT 'The difference in gallons between the estimated and actual delivered quantities (actual minus estimated).',
    `vehicle_number` STRING COMMENT 'Identifier or license plate number of the delivery vehicle (tanker truck) used for this shipment.. Valid values are `^[A-Z0-9-]{4,20}$`',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Master schedule of planned fuel deliveries for each fuel center, capturing scheduled delivery date and time window, fuel grade, estimated gallons ordered, distributor/carrier assignment, reorder trigger (ATG-automated CAO vs. manual), order status, and confirmation reference. Supports supply planning and ensures fuel availability to prevent out-of-stock (OOS) conditions at the pump.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` (
    `inventory_reconciliation_id` BIGINT COMMENT 'Unique identifier for the fuel inventory reconciliation record. Primary key for this entity.',
    `associate_id` BIGINT COMMENT 'Identifier of the user who approved or closed the reconciliation record. Links to workforce associate master data for audit trail.',
    `fiscal_period_id` BIGINT COMMENT 'Identifier of the fiscal period to which this reconciliation belongs. Links to fiscal calendar for financial reporting and period-over-period analysis.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the fuel center and tank are located.',
    `tank_id` BIGINT COMMENT 'Identifier of the fuel storage tank being reconciled. Links to the fuel tank master data.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the reconciliation was approved or closed. Part of audit trail for compliance and internal controls.',
    `atg_physical_volume_gallons` DECIMAL(18,2) COMMENT 'Physical inventory volume in gallons measured by the Automatic Tank Gauge (ATG) system at the end of the reconciliation period. Represents actual measured inventory in the tank.',
    `atg_system_code` STRING COMMENT 'Identifier of the ATG system or device that provided the physical volume reading. Used for equipment tracking and calibration audit trails.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `average_tank_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Average fuel temperature in the tank during the reconciliation period measured in degrees Fahrenheit. Used for temperature compensation calculations and thermal expansion adjustments.',
    `closing_book_volume_gallons` DECIMAL(18,2) COMMENT 'Calculated book inventory volume in gallons at the end of the reconciliation period. Formula: opening_book_volume + total_deliveries - total_dispensed. Represents theoretical ending inventory.',
    `cost_of_variance_amount` DECIMAL(18,2) COMMENT 'Financial impact of the inventory variance calculated by multiplying variance volume by the weighted average cost per gallon for the period. Used for shrink cost reporting and Profit and Loss (P&L) impact analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this reconciliation record was first created in the system. Part of audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost of variance amount. Typically USD for US operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_count` STRING COMMENT 'Number of fuel delivery transactions received during the reconciliation period. Used to validate delivery volume totals and identify delivery frequency patterns.',
    `fuel_grade_code` STRING COMMENT 'Code representing the fuel grade or product type stored in the tank (e.g., Regular 87, Premium 93, Diesel). Standardized fuel product classification.. Valid values are `^[A-Z0-9]{2,10}$`',
    `investigation_notes` STRING COMMENT 'Free-text notes documenting investigation findings, root cause analysis, corrective actions taken, and resolution details for variances requiring investigation.',
    `investigation_required_flag` BOOLEAN COMMENT 'Boolean indicator whether the variance requires formal investigation by operations or compliance teams. True triggers investigation workflow and root cause analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this reconciliation record was last updated. Part of audit trail for change tracking and compliance.',
    `leak_detection_compliance_flag` BOOLEAN COMMENT 'Boolean indicator whether this reconciliation meets EPA Underground Storage Tank (UST) leak detection compliance requirements. True indicates compliance, False indicates potential leak or non-compliance requiring immediate action.',
    `opening_book_volume_gallons` DECIMAL(18,2) COMMENT 'Book inventory volume in gallons at the start of the reconciliation period. Represents the theoretical starting inventory based on prior period closing balance.',
    `reconciliation_method` STRING COMMENT 'Method used to perform the inventory reconciliation. Manual indicates human-performed reconciliation, automated indicates system-generated reconciliation, hybrid indicates combination of both.. Valid values are `manual|automated|hybrid`',
    `reconciliation_period_end_date` DATE COMMENT 'End date of the inventory reconciliation period. Defines the close of the measurement window for this reconciliation cycle.',
    `reconciliation_period_start_date` DATE COMMENT 'Start date of the inventory reconciliation period. Defines the beginning of the measurement window for this reconciliation cycle.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the inventory reconciliation record. Tracks approval workflow and investigation state.. Valid values are `pending|approved|rejected|under_investigation|closed`',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Date and time when the physical inventory reconciliation was performed and recorded. Primary business event timestamp for this reconciliation.',
    `shrink_category` STRING COMMENT 'Classification of the inventory variance into business-defined shrink categories based on variance magnitude and direction. Used for shrink management reporting and escalation workflows.. Valid values are `within_tolerance|minor_shrink|major_shrink|overage|suspected_leak`',
    `temperature_compensation_applied_flag` BOOLEAN COMMENT 'Boolean indicator whether temperature compensation was applied to volume measurements to adjust for thermal expansion/contraction of fuel. True indicates volumes are temperature-corrected to standard conditions.',
    `total_deliveries_volume_gallons` DECIMAL(18,2) COMMENT 'Total volume of fuel delivered to the tank during the reconciliation period in gallons. Sum of all delivery receipts for this tank and fuel grade.',
    `total_dispensed_volume_gallons` DECIMAL(18,2) COMMENT 'Total volume of fuel dispensed from the tank during the reconciliation period in gallons. Sum of all Point of Sale (POS) transactions for this tank and fuel grade.',
    `transaction_count` STRING COMMENT 'Number of Point of Sale (POS) fuel dispensing transactions during the reconciliation period. Used to validate dispensed volume totals and assess transaction activity.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Inventory variance expressed as a percentage of closing book volume. Formula: (variance_volume / closing_book_volume) * 100. Used to assess materiality of variance and trigger investigation thresholds.',
    `variance_threshold_exceeded_flag` BOOLEAN COMMENT 'Boolean indicator whether the variance exceeds the acceptable threshold defined by business policy or EPA leak detection requirements. True indicates variance requires investigation.',
    `variance_volume_gallons` DECIMAL(18,2) COMMENT 'Inventory variance in gallons between book and physical inventory. Formula: atg_physical_volume - closing_book_volume. Positive values indicate overage (gain), negative values indicate shrink (loss).',
    `water_level_inches` DECIMAL(18,2) COMMENT 'Water level detected at the bottom of the tank measured in inches. Water accumulation can indicate tank integrity issues or contamination. Part of EPA compliance monitoring.',
    CONSTRAINT pk_inventory_reconciliation PRIMARY KEY(`inventory_reconciliation_id`)
) COMMENT 'Periodic fuel inventory reconciliation record comparing book inventory (opening stock + deliveries - sales) against physical ATG readings to compute variance (shrink/overage) per tank per fuel grade, capturing reconciliation period, opening volume, total deliveries, total dispensed volume, closing book volume, ATG physical volume, variance in gallons, variance percentage, and reconciliation status. Supports EPA leak detection compliance and shrink management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`pump_maintenance` (
    `pump_maintenance_id` BIGINT COMMENT 'Unique identifier for the pump maintenance record. Primary key for the pump maintenance transaction.',
    `associate_id` BIGINT COMMENT 'Identifier of the technician or associate who performed the maintenance work. May be internal staff or vendor technician.',
    `center_id` BIGINT COMMENT 'Identifier of the fuel center location where the pump is installed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links pump maintenance expenses to the cost center that owns the pump.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Maintenance costs are recorded in a GL account for expense tracking.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Maintenance work orders are driven by specific compliance obligations (e.g., calibration, leak detection) tracked in compliance_obligation.',
    `pump_id` BIGINT COMMENT 'Identifier of the fuel dispenser pump that received maintenance. Links to the pump master resource.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external vendor or service provider who performed the maintenance, if applicable. Null for internal maintenance.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the maintenance work was completed and the pump was ready for return to service.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the maintenance work actually began. Principal business event timestamp for this transaction.',
    `calibration_certificate_number` STRING COMMENT 'Certificate number issued by the calibration authority or weights and measures inspector, if calibration was performed.',
    `calibration_performed_flag` BOOLEAN COMMENT 'Indicates whether pump calibration was performed during this maintenance activity. Critical for regulatory compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance record was first created in the system.',
    `downtime_duration_minutes` STRING COMMENT 'Total duration in minutes that the pump was out of service due to this maintenance activity. Critical for availability tracking and revenue impact analysis.',
    `failure_mode` STRING COMMENT 'Classification of the failure or issue type (e.g., mechanical failure, electrical fault, calibration drift, leak detection). Used for root cause analysis and equipment reliability tracking.',
    `inspection_passed_flag` BOOLEAN COMMENT 'Indicates whether the pump passed inspection during this maintenance activity. False indicates failure requiring follow-up.',
    `issue_description` STRING COMMENT 'Detailed description of the problem, defect, or reason for maintenance. For preventive maintenance, describes the scheduled service performed.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for the maintenance activity, in USD. Includes internal labor or vendor service fees.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance record was last updated in the system.',
    `maintenance_status` STRING COMMENT 'Current lifecycle status of the maintenance work order.. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `maintenance_type` STRING COMMENT 'Classification of the maintenance activity: preventive (scheduled routine), corrective (repair), calibration (accuracy adjustment), inspection (regulatory check), emergency (unplanned critical), or compliance (regulatory requirement).. Valid values are `preventive|corrective|calibration|inspection|emergency|compliance`',
    `next_scheduled_date` DATE COMMENT 'Date when the next preventive maintenance or inspection is scheduled for this pump, based on maintenance intervals.',
    `notes` STRING COMMENT 'Additional notes, observations, or comments from the technician regarding the maintenance activity.',
    `parts_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of parts and materials used in the maintenance activity, in USD.',
    `parts_replaced` STRING COMMENT 'Comma-separated list or description of parts and components replaced during the maintenance activity. Used for inventory tracking and warranty management.',
    `priority_level` STRING COMMENT 'Priority classification of the maintenance work order. Critical indicates immediate safety or compliance issue.. Valid values are `critical|high|medium|low`',
    `resolution_description` STRING COMMENT 'Detailed description of the corrective actions taken, repairs completed, and final resolution of the maintenance activity.',
    `return_to_service_timestamp` TIMESTAMP COMMENT 'Timestamp when the pump was officially returned to operational service and made available for customer transactions.',
    `root_cause` STRING COMMENT 'Identified root cause of the issue requiring maintenance. Used for preventive maintenance planning and equipment lifecycle management.',
    `scheduled_date` DATE COMMENT 'Date when the maintenance activity was originally scheduled to occur.',
    `total_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of the maintenance activity including parts, labor, and any additional fees, in USD.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this maintenance activity is covered under manufacturer or vendor warranty.',
    `warranty_claim_number` STRING COMMENT 'Warranty claim reference number if this maintenance is being claimed under warranty.',
    `work_order_number` STRING COMMENT 'Externally-known work order number assigned to this maintenance activity. Used for tracking and vendor billing.. Valid values are `^WO-[0-9]{8,12}$`',
    CONSTRAINT pk_pump_maintenance PRIMARY KEY(`pump_maintenance_id`)
) COMMENT 'Transactional record of all maintenance activities performed on fuel dispensers, including maintenance type (preventive/corrective/calibration/inspection), work order number, maintenance date, technician or vendor performing work, issue description, resolution, parts replaced, downtime duration, and return-to-service timestamp. Supports equipment lifecycle management and regulatory calibration compliance.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` (
    `epa_compliance_report_id` BIGINT COMMENT 'Unique identifier for the EPA compliance report record.',
    `center_id` BIGINT COMMENT 'Identifier of the fuel center location where this compliance report or incident occurred.',
    `affected_media` STRING COMMENT 'Environmental medium impacted by the incident: soil for subsurface contamination, groundwater for aquifer pollution, surface water for waterway impact, air for vapor emissions, or multiple media for incidents affecting more than one medium. Null for routine compliance reports.. Valid values are `soil|groundwater|surface_water|air|multiple_media`',
    `compliance_category` STRING COMMENT 'EPA-mandated compliance category: leak detection for Underground Storage Tank (UST) monitoring systems, release reporting for fuel discharge events, spill/overfill prevention for equipment safeguards, corrosion protection for tank integrity, financial responsibility for liability coverage, or operator training for certification requirements.. Valid values are `leak_detection|release_reporting|spill_overfill_prevention|corrosion_protection|financial_responsibility|operator_training`',
    `compliance_status` STRING COMMENT 'Current lifecycle status of the compliance report or incident: compliant for meeting all requirements, non-compliant for violations identified, pending review for submissions under agency evaluation, corrective action required for mandated remediation, remediation in progress for active cleanup, or closed for completed incidents.. Valid values are `compliant|non_compliant|pending_review|corrective_action_required|remediation_in_progress|closed`',
    `corrective_action_description` STRING COMMENT 'Detailed description of corrective actions or remediation measures required by the regulatory agency, including equipment repairs, system upgrades, soil excavation, groundwater treatment, or monitoring well installation. Null if no corrective action required.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which corrective action or remediation must be completed as mandated by the regulatory agency. Null if no corrective action required.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action or remediation is mandated by the regulatory agency. True if action is required, False if no action needed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance report record was first created in the system.',
    `estimated_remediation_cost` DECIMAL(18,2) COMMENT 'Estimated total cost of remediation and corrective actions in USD, including cleanup, equipment replacement, monitoring, and regulatory compliance expenses. Null if no remediation required or cost not yet estimated.',
    `fuel_grade` STRING COMMENT 'Type of fuel product involved in the incident or compliance report: regular unleaded, mid-grade, premium, diesel, E85 ethanol blend, or biodiesel.. Valid values are `regular_unleaded|mid_grade|premium|diesel|e85|biodiesel`',
    `immediate_response_actions` STRING COMMENT 'Description of immediate containment, cleanup, and safety actions taken upon discovery of the incident, including emergency shutdowns, spill containment, and site securing. Null for routine compliance reports.',
    `incident_closure_date` DATE COMMENT 'Date when the regulatory agency formally closed the incident or compliance case, indicating all corrective actions completed and remediation verified. Null for open incidents or routine compliance reports.',
    `incident_date` DATE COMMENT 'Date when the environmental incident or compliance violation occurred. Null for routine compliance reports.',
    `incident_time` TIMESTAMP COMMENT 'Precise timestamp when the environmental incident or compliance violation was detected. Null for routine compliance reports.',
    `incident_type` STRING COMMENT 'Classification of environmental incident: fuel spill for surface discharge, tank leak for Underground Storage Tank (UST) breach, vapor release for airborne emissions, soil contamination for subsurface pollution, groundwater contamination for aquifer impact, or surface water contamination for waterway pollution. Null for routine compliance reports.. Valid values are `fuel_spill|tank_leak|vapor_release|soil_contamination|groundwater_contamination|surface_water_contamination`',
    `inspection_date` DATE COMMENT 'Date when the regulatory inspection or compliance audit was conducted. Null for incident reports without formal inspection.',
    `inspection_findings` STRING COMMENT 'Summary of findings from regulatory inspection or compliance audit, including violations identified, equipment deficiencies, and procedural gaps. Null for reports without formal inspection.',
    `insurance_claim_number` STRING COMMENT 'Insurance claim reference number for financial responsibility coverage related to the incident or remediation. Null if no insurance claim filed.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance report record was last modified, reflecting updates to compliance status, remediation progress, or regulatory actions.',
    `next_due_date` DATE COMMENT 'Date when the next compliance report, follow-up submission, or remediation status update is due to the regulatory agency. Null for closed incidents or one-time reports.',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency overseeing this compliance report or incident, typically EPA regional office or state environmental agency with delegated Underground Storage Tank (UST) program authority.',
    `regulatory_notification_date` DATE COMMENT 'Date when the regulatory agency was formally notified of the incident or compliance issue, as required by EPA 24-hour release reporting requirements. Null for routine compliance reports.',
    `regulatory_reference_number` STRING COMMENT 'Official reference number or case identifier assigned by the regulatory agency for tracking this compliance report, incident, or enforcement action.',
    `remediation_plan_reference` STRING COMMENT 'Reference number or identifier for the formal remediation plan submitted to the regulatory agency, linking to detailed cleanup strategy and timeline. Null if no remediation plan required.',
    `remediation_status` STRING COMMENT 'Current status of remediation activities: not started for approved plans awaiting execution, in progress for active cleanup, monitoring for post-cleanup observation, completed for finished remediation awaiting verification, or verified closed for agency-approved closure. Null if no remediation required.. Valid values are `not_started|in_progress|monitoring|completed|verified_closed`',
    `report_number` STRING COMMENT 'Business identifier for the compliance report or incident, used for external regulatory reference and tracking.',
    `report_type` STRING COMMENT 'Classification of the EPA report: compliance reporting for routine submissions, environmental incident for release events, inspection finding for regulatory audit results, corrective action for required remediation, or remediation status for ongoing cleanup tracking.. Valid values are `compliance_reporting|environmental_incident|inspection_finding|corrective_action|remediation_status`',
    `reporting_period_end_date` DATE COMMENT 'End date of the compliance reporting period covered by this report.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the compliance reporting period covered by this report.',
    `responsible_party` STRING COMMENT 'Name of the legal entity or party responsible for the Underground Storage Tank (UST) system and compliance obligations, typically the fuel center operator or corporate owner.',
    `submission_date` DATE COMMENT 'Date when the compliance report or incident notification was submitted to the regulatory agency.',
    `tank_number` STRING COMMENT 'Physical tank number or designation at the fuel center involved in the incident or compliance report.',
    `ust_system_code` STRING COMMENT 'Identifier of the specific Underground Storage Tank system involved in the incident or compliance report, linking to tank registration and equipment records.',
    `volume_released_gallons` DECIMAL(18,2) COMMENT 'Quantity of fuel or petroleum product released during the incident, measured in gallons. Null for routine compliance reports or incidents where volume cannot be determined.',
    CONSTRAINT pk_epa_compliance_report PRIMARY KEY(`epa_compliance_report_id`)
) COMMENT 'Comprehensive regulatory compliance and environmental incident record capturing all EPA-mandated reporting for underground storage tank (UST) operations at fuel centers. Compliance reporting: reporting period, compliance category (leak detection, release reporting, spill/overfill prevention, corrosion protection, financial responsibility), compliance status, inspection findings, corrective action required, submission date, regulatory agency reference number, and next due date. Environmental incidents: incident date/time, incident type (fuel spill, tank leak, vapor release, soil/groundwater contamination), volume released, affected media (soil/groundwater/surface water), immediate response actions, regulatory notification date, remediation plan reference, remediation status, and incident closure date. Serves as the single source of truth for all EPA UST program compliance, state environmental agency requirements, release reporting obligations, and environmental incident management from detection through remediation closure.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`environmental_incident` (
    `environmental_incident_id` BIGINT COMMENT 'Unique identifier for the environmental incident record. Primary key.',
    `center_id` BIGINT COMMENT 'Identifier of the fuel center where the environmental incident occurred.',
    `associate_id` BIGINT COMMENT 'Identifier of the associate who reported the environmental incident.',
    `affected_media` STRING COMMENT 'Environmental media impacted by the release (soil, groundwater, surface water, air). Determines scope of remediation and regulatory notification requirements.. Valid values are `soil|groundwater|surface_water|air|multiple`',
    `cause_category` STRING COMMENT 'Root cause category of the environmental incident. Used for trend analysis and preventive maintenance planning. [ENUM-REF-CANDIDATE: equipment_failure|corrosion|overfill|delivery_error|vandalism|natural_disaster|operator_error|unknown — 8 candidates stripped; promote to reference product]',
    `cause_description` STRING COMMENT 'Detailed narrative description of the root cause and circumstances leading to the environmental incident.',
    `closure_approved_by` STRING COMMENT 'Name of the regulatory authority or official who approved the incident closure.',
    `closure_date` DATE COMMENT 'Date when the environmental incident was officially closed by regulatory authorities, indicating all remediation and monitoring requirements have been satisfied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental incident record was first created in the system.',
    `discovery_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental incident was discovered by personnel or monitoring systems.',
    `emergency_responder_notified` BOOLEAN COMMENT 'Indicates whether local emergency responders (fire department, hazmat team) were notified of the incident.',
    `emergency_responder_timestamp` TIMESTAMP COMMENT 'Date and time when emergency responders were notified of the environmental incident.',
    `epa_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the EPA was notified of the environmental incident. Must be within 24 hours of discovery for reportable releases.',
    `epa_notified` BOOLEAN COMMENT 'Indicates whether the EPA was notified of the environmental release as required by federal regulations.',
    `fuel_grade_released` STRING COMMENT 'Type of fuel grade involved in the release. Determines environmental impact assessment and remediation approach.. Valid values are `regular_unleaded|mid_grade|premium|diesel|e85|kerosene`',
    `immediate_response_actions` STRING COMMENT 'Description of immediate containment and response actions taken at the time of incident discovery, including emergency shutoff, spill containment, and site securing.',
    `incident_number` STRING COMMENT 'Externally-known unique business identifier for the environmental incident, used for regulatory reporting and internal tracking.. Valid values are `^[A-Z]{3}-[0-9]{4}-[0-9]{6}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the environmental incident in the response and remediation workflow.. Valid values are `reported|under_investigation|remediation_in_progress|monitoring|closed|regulatory_review`',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental incident occurred or was first detected. Principal business event timestamp for regulatory reporting.',
    `incident_type` STRING COMMENT 'Classification of the environmental incident type. Determines regulatory reporting requirements and remediation protocols.. Valid values are `fuel_spill|tank_leak|vapor_release|groundwater_contamination|soil_contamination|surface_water_contamination`',
    `insurance_claim_number` STRING COMMENT 'Insurance claim number associated with the environmental incident for cost recovery purposes.',
    `monitoring_end_date` DATE COMMENT 'Scheduled or actual end date for post-remediation environmental monitoring activities.',
    `monitoring_required` BOOLEAN COMMENT 'Indicates whether ongoing environmental monitoring is required following remediation completion.',
    `nrc_report_number` STRING COMMENT 'National Response Center report number assigned when the incident was reported to the federal hotline for oil and hazardous substance releases.. Valid values are `^[0-9]{7,10}$`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Total amount of regulatory penalties or fines assessed for the environmental incident, in USD.',
    `regulatory_penalty_assessed` BOOLEAN COMMENT 'Indicates whether regulatory penalties or fines were assessed against the company for the environmental incident.',
    `remediation_completion_date` DATE COMMENT 'Date when remediation activities were completed and site restoration was achieved.',
    `remediation_contractor` STRING COMMENT 'Name of the environmental remediation contractor engaged to perform cleanup and restoration activities.',
    `remediation_plan_reference` STRING COMMENT 'Reference identifier or document number for the approved remediation plan addressing the environmental contamination.',
    `remediation_start_date` DATE COMMENT 'Date when active remediation activities commenced at the incident site.',
    `source_equipment_code` STRING COMMENT 'Identifier or serial number of the specific equipment unit that was the source of the release.',
    `source_equipment_type` STRING COMMENT 'Type of fuel center equipment that was the source of the environmental release. [ENUM-REF-CANDIDATE: underground_storage_tank|dispenser|piping|vent_system|delivery_connection|spill_bucket|overfill_prevention — 7 candidates stripped; promote to reference product]',
    `state_agency_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the state environmental agency was notified of the environmental incident.',
    `state_agency_notified` BOOLEAN COMMENT 'Indicates whether the state environmental agency was notified of the environmental release as required by state regulations.',
    `total_remediation_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for environmental remediation, monitoring, and regulatory compliance activities related to the incident, in USD.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental incident record was last modified in the system.',
    `volume_released` DECIMAL(18,2) COMMENT 'Estimated or measured volume of fuel or hazardous material released during the incident, in gallons. Critical for EPA release reporting thresholds.',
    CONSTRAINT pk_environmental_incident PRIMARY KEY(`environmental_incident_id`)
) COMMENT 'Record of environmental incidents at fuel centers including fuel spills, tank leaks, vapor release events, and soil/groundwater contamination reports, capturing incident date and time, incident type, volume released, affected media (soil/groundwater/surface water), immediate response actions taken, regulatory notification date, remediation plan reference, and incident closure date. Required for EPA release reporting and state environmental agency notifications.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` (
    `competitor_fuel_price_id` BIGINT COMMENT 'Unique identifier for each competitor fuel price observation record.',
    `center_id` BIGINT COMMENT 'The Grocery fuel center location being benchmarked against competitor or wholesale pricing.',
    `competitive_position` STRING COMMENT 'The calculated competitive pricing position of the Grocery fuel center relative to this observation: below_market (Grocery price is lower), at_market (prices are equal within tolerance), above_market (Grocery price is higher).. Valid values are `below_market|at_market|above_market`',
    `competitor_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the competitor fuel center. Enables distance calculations and competitive radius mapping.',
    `competitor_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the competitor fuel center. Enables distance calculations and competitive radius mapping.',
    `competitor_name` STRING COMMENT 'The brand or business name of the competitor fuel retailer whose street price is being observed. Null for wholesale/rack price sources.',
    `competitor_site_address` STRING COMMENT 'The street address of the competitor fuel center location. Used for geographic proximity analysis and market segmentation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this competitor fuel price record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the observed price. Typically USD for US operations.. Valid values are `USD`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A calculated quality score (0.00 to 1.00) for this price observation based on source reliability, observation recency, and data completeness. Used to weight pricing decisions.',
    `distance_to_fuel_center_miles` DECIMAL(18,2) COMMENT 'The calculated distance in miles from the competitor site to the benchmarked Grocery fuel center. Used for competitive radius analysis.',
    `distributor_source` STRING COMMENT 'The fuel distributor or supplier name associated with the wholesale rack or terminal price. Null for competitor street price observations.',
    `fuel_grade` STRING COMMENT 'The specific fuel product grade being priced: regular unleaded (87 octane), midgrade (89 octane), premium (91-93 octane), diesel, E85 (85% ethanol blend), or E15 (15% ethanol blend).. Valid values are `regular|midgrade|premium|diesel|e85|e15`',
    `geographic_market` STRING COMMENT 'The regional market or metropolitan area identifier for this pricing observation. Used to segment pricing intelligence by local market dynamics.',
    `index_provider` STRING COMMENT 'The third-party pricing index or data provider name for wholesale rack prices: OPIS (Oil Price Information Service), Platts, or DTN (Data Transmission Network).. Valid values are `OPIS|Platts|DTN`',
    `notes` STRING COMMENT 'Free-text notes or comments about the price observation, including context such as promotional signage, payment method restrictions, or unusual market conditions.',
    `observation_method` STRING COMMENT 'The method by which the price data was collected: manual field survey, automated web scraping, API data feed, email report from provider, or phone call to terminal.. Valid values are `manual_survey|automated_scrape|api_feed|email_report|phone_call`',
    `observation_timestamp` TIMESTAMP COMMENT 'The exact date and time when the competitor price or wholesale rack price was observed or recorded.',
    `observed_price_per_gallon` DECIMAL(18,2) COMMENT 'The fuel price per gallon observed at the competitor site or reported by the wholesale index/terminal. Expressed in USD per gallon with three decimal precision.',
    `observer_name` STRING COMMENT 'The name of the person or system that recorded the competitor price observation. Used for data quality auditing and manual survey accountability.',
    `price_basis` STRING COMMENT 'The pricing level being captured: street_retail (consumer pump price at competitor), terminal_rack (wholesale terminal rack price), spot_market (commodity spot market price), or contract (negotiated supplier contract price).. Valid values are `street_retail|terminal_rack|spot_market|contract`',
    `price_change_trigger_flag` BOOLEAN COMMENT 'Boolean indicator whether this observation triggered an automated price change recommendation or alert based on competitive pricing rules and thresholds.',
    `price_differential_cents` DECIMAL(18,2) COMMENT 'The calculated price difference in cents per gallon between the observed competitor/wholesale price and the current Grocery fuel center price for the same grade. Positive values indicate Grocery is more expensive.',
    `source_identifier` STRING COMMENT 'The specific name or code of the pricing source: competitor site name and location for surveys, data provider name for automated feeds, terminal or index name for rack/wholesale prices.',
    `source_type` STRING COMMENT 'The category of pricing intelligence source: competitor survey (manual street price observation), automated feed (third-party data provider), rack index (OPIS/Platts/DTN terminal rack price), spot market (real-time commodity market price), or contract terminal price (negotiated supplier terminal price).. Valid values are `competitor_survey|automated_feed|rack_index|spot_market|contract_terminal`',
    `terminal_name` STRING COMMENT 'The specific fuel terminal or distribution point name for wholesale rack prices. Null for competitor street price observations.',
    `verification_status` STRING COMMENT 'The validation status of the price observation: verified (confirmed accurate), unverified (not yet validated), flagged (requires review due to anomaly), rejected (determined to be erroneous).. Valid values are `verified|unverified|flagged|rejected`',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when the price observation was verified or reviewed by a pricing analyst or automated validation process.',
    CONSTRAINT pk_competitor_fuel_price PRIMARY KEY(`competitor_fuel_price_id`)
) COMMENT 'Transactional record of all external fuel pricing intelligence including observed competitor street prices and wholesale rack/index prices (OPIS, Platts, DTN). Captures observation date and time, source type (competitor survey, automated feed, rack index, spot market, contract terminal price), source identifier (competitor site name or index/terminal name), fuel grade, observed price per gallon, price basis (terminal/spot/contract), geographic market, distributor source, and the Grocery fuel center being benchmarked. Serves as the single source of truth for all external pricing data — both competitive intelligence and cost-basis rack/wholesale prices — driving street price decisions, margin calculations, cost-of-goods determination, and automated price change triggers.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`rack_price` (
    `rack_price_id` BIGINT COMMENT 'Unique identifier for the rack price record.',
    `grade_id` BIGINT COMMENT 'Identifier for the fuel grade (regular, mid-grade, premium, diesel) to which this rack price applies.',
    `approval_status` STRING COMMENT 'The approval status for this rack price record, supporting workflow controls for price changes.. Valid values are `approved|pending_approval|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the manager or system user who approved this rack price for use in pricing decisions.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when this rack price record was approved for use.',
    `contract_number` STRING COMMENT 'The contract or agreement number under which this rack price is provided, if applicable.',
    `contract_term_end_date` DATE COMMENT 'The end date of the contract term for negotiated rack pricing agreements.',
    `contract_term_start_date` DATE COMMENT 'The start date of the contract term for negotiated rack pricing agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rack price record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rack price (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The method or channel by which this rack price data was received: EDI (Electronic Data Interchange), API, Manual entry, Email, or FTP.. Valid values are `EDI|API|Manual|Email|FTP`',
    `distributor_code` STRING COMMENT 'The internal or industry-standard code identifying the petroleum distributor.',
    `distributor_name` STRING COMMENT 'The name of the petroleum distributor or supplier providing this rack price.',
    `effective_date` DATE COMMENT 'The date on which this rack price becomes effective for pricing and margin calculations.',
    `effective_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this rack price becomes effective, supporting intraday price changes.',
    `environmental_fee_per_gallon` DECIMAL(18,2) COMMENT 'Environmental or regulatory fees per gallon (e.g., underground storage tank fees, emissions fees) applicable to this rack price.',
    `expiration_date` DATE COMMENT 'The date on which this rack price expires and is superseded by a new price, nullable for open-ended pricing.',
    `freight_cost_per_gallon` DECIMAL(18,2) COMMENT 'The freight or transportation cost per gallon from the terminal to the fuel center, used to calculate delivered cost.',
    `geographic_market` STRING COMMENT 'The applicable geographic market or region for this rack price (e.g., Gulf Coast, Midwest, West Coast).',
    `index_source` STRING COMMENT 'The published market index source for the rack price (e.g., OPIS, Platts, DTN, Argus) or Internal for proprietary pricing.. Valid values are `OPIS|Platts|DTN|Argus|Internal`',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this rack price record, capturing context, exceptions, or special conditions.',
    `per_gallon` DECIMAL(18,2) COMMENT 'The wholesale petroleum rack price per gallon from the distributor or spot market index, serving as the cost basis for fuel margin calculation.',
    `price_adjustment_factor` DECIMAL(18,2) COMMENT 'A multiplier or adjustment factor applied to the base rack price for volume discounts, loyalty programs, or contract terms.',
    `price_basis` STRING COMMENT 'The basis or source type for the rack price: terminal (local terminal rack), spot (spot market), contract (negotiated contract), or index (published index).. Valid values are `terminal|spot|contract|index`',
    `price_change_reason` STRING COMMENT 'The business reason or trigger for this rack price change (e.g., market volatility, contract renewal, seasonal adjustment, regulatory change).',
    `price_status` STRING COMMENT 'The current lifecycle status of this rack price record: active (in use), pending (scheduled future), expired (past effective period), superseded (replaced by newer price), or cancelled.. Valid values are `active|pending|expired|superseded|cancelled`',
    `price_type` STRING COMMENT 'The classification of the price: wholesale (distributor rack), retail_reference (suggested retail), cost_plus (cost plus markup), or market_index (published index).. Valid values are `wholesale|retail_reference|cost_plus|market_index`',
    `published_date` DATE COMMENT 'The date on which this rack price was published or announced by the distributor or index source.',
    `received_timestamp` TIMESTAMP COMMENT 'The timestamp when this rack price record was received or ingested into the system from the distributor or index feed.',
    `tax_per_gallon` DECIMAL(18,2) COMMENT 'The applicable federal, state, and local excise tax per gallon included in or added to the rack price.',
    `terminal_city` STRING COMMENT 'The city where the petroleum terminal is located.',
    `terminal_location` STRING COMMENT 'The name or identifier of the petroleum terminal or distribution point where this rack price applies.',
    `terminal_state_province_code` STRING COMMENT 'The state or province code where the petroleum terminal is located.',
    `total_delivered_cost_per_gallon` DECIMAL(18,2) COMMENT 'The total delivered cost per gallon including rack price, freight, taxes, and fees, representing the true cost basis for margin calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this rack price record was last modified or updated.',
    `volume_tier` STRING COMMENT 'The volume tier or bracket that qualifies for this rack price (e.g., 0-10000 gallons, 10001-50000 gallons), supporting tiered pricing structures.',
    CONSTRAINT pk_rack_price PRIMARY KEY(`rack_price_id`)
) COMMENT 'Reference record of wholesale petroleum rack prices from petroleum distributors and spot market indices (OPIS, Platts), capturing effective date, fuel grade, rack price per gallon, price basis (terminal/spot/contract), distributor or index source, and applicable geographic market. Used as the cost basis for fuel margin calculation and street price setting decisions.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`tax` (
    `tax_id` BIGINT COMMENT 'System-generated unique identifier for each fuel tax record.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fuel.fuel_center. Business justification: Fuel tax rules apply to specific fuel centers; linking tax to center enables compliance reporting and eliminates silo.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns fuel tax expense to the cost center responsible for the fuel operation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Tax liabilities are posted to a dedicated GL account for tax reporting.',
    `superseded_tax_id` BIGINT COMMENT 'Self-referencing FK on tax (superseded_tax_id)',
    `applicability` STRING COMMENT 'Specifies whether the tax applies at the point of sale, during delivery, or both.. Valid values are `sale|delivery|both`',
    `audit_status` STRING COMMENT 'Result of internal audit of the tax record.. Valid values are `approved|rejected|under_review`',
    `audit_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent audit was performed.',
    `category_code` STRING COMMENT 'Internal code representing the tax category for reporting and accounting purposes.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the tax record complies with current regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the tax rate becomes effective.',
    `exempt_reason_code` STRING COMMENT 'Code representing the reason for tax exemption (e.g., SNAP, EBT).',
    `exempt_reason_description` STRING COMMENT 'Detailed description of the exemption reason.',
    `exempt_transaction_flag` BOOLEAN COMMENT 'True if the tax does not apply to the transaction under the exemption rules.',
    `exemption_rule_description` STRING COMMENT 'Narrative description of rules that qualify a transaction for tax exemption.',
    `expiration_date` DATE COMMENT 'Date on which the tax rate expires or is superseded; null if indefinite.',
    `filing_deadline_day` STRING COMMENT 'Day of the month by which the tax filing must be submitted.',
    `id_number` STRING COMMENT 'Government‑issued identifier for the tax (e.g., state tax ID).',
    `jurisdiction_code` STRING COMMENT 'Standard code identifying the jurisdiction (e.g., state abbreviation, FIPS county code).',
    `jurisdiction_level` STRING COMMENT 'Level of government imposing the tax: federal, state, county, or city.. Valid values are `federal|state|county|city`',
    `jurisdiction_name` STRING COMMENT 'Human‑readable name of the jurisdiction imposing the tax.',
    `last_effective_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the effective date or rate was last modified.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the tax record.',
    `rate_currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the tax rate (e.g., USD).',
    `rate_effective_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the tax rate became effective.',
    `rate_per_gallon` DECIMAL(18,2) COMMENT 'Monetary amount of tax charged per gallon of fuel, expressed in the applicable currency.',
    `remittance_account` STRING COMMENT 'Internal finance account used for remitting the tax to the authority.',
    `remittance_frequency` STRING COMMENT 'How often the tax must be remitted to the governing authority.. Valid values are `monthly|quarterly|annual|semiannual`',
    `source_system` STRING COMMENT 'Originating system that supplied the tax data (e.g., SAP FI, Oracle Retail).',
    `tax_status` STRING COMMENT 'Current lifecycle status of the tax record.. Valid values are `active|inactive|pending|retired`',
    `tax_type` STRING COMMENT 'Classification of the tax, such as excise, environmental surcharge, underground storage tank (UST) fee, or other applicable tax.. Valid values are `excise|environmental|ust_fee|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tax record.',
    CONSTRAINT pk_tax PRIMARY KEY(`tax_id`)
) COMMENT 'Master and transactional record of fuel excise taxes, state motor fuel taxes, UST fees, environmental surcharges, and inspection fees applicable per fuel grade per jurisdiction. Captures tax type, rate per gallon, effective date, jurisdiction (federal/state/county/city), remittance frequency, filing deadline, and tax-exempt transaction handling rules. Critical for fuel tax remittance reporting to state revenue departments and IRS excise tax filings.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fuel`.`fuel_pricing` (
    `fuel_pricing_id` BIGINT COMMENT 'Primary key for the FuelPricing association',
    `center_id` BIGINT COMMENT 'Foreign key linking to fuel_center',
    `grade_id` BIGINT COMMENT 'Foreign key linking to fuel_grade',
    `cost_per_gallon` DECIMAL(18,2) COMMENT 'Wholesale cost per gallon for the center',
    `effective_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing becomes effective',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing expires',
    `margin_per_gallon` DECIMAL(18,2) COMMENT 'Margin earned per gallon (price minus cost)',
    `street_price` DECIMAL(18,2) COMMENT 'Retail price per gallon at the pump',
    CONSTRAINT pk_fuel_pricing PRIMARY KEY(`fuel_pricing_id`)
) COMMENT 'Represents the pricing relationship between a fuel_center and a fuel_grade. Each record captures the price, cost, margin and the effective time period for a specific grade at a specific center.. Existence Justification: Fuel centers sell multiple fuel grades and each fuel grade is offered at multiple fuel centers. The business actively manages pricing for each center‑grade combination, tracking street price, cost, margin, and effective dates.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ADD CONSTRAINT `fk_fuel_pump_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ADD CONSTRAINT `fk_fuel_tank_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ADD CONSTRAINT `fk_fuel_tank_level_reading_inventory_reconciliation_id` FOREIGN KEY (`inventory_reconciliation_id`) REFERENCES `grocery_ecm`.`fuel`.`inventory_reconciliation`(`inventory_reconciliation_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ADD CONSTRAINT `fk_fuel_tank_level_reading_tank_id` FOREIGN KEY (`tank_id`) REFERENCES `grocery_ecm`.`fuel`.`tank`(`tank_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price` ADD CONSTRAINT `fk_fuel_price_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price` ADD CONSTRAINT `fk_fuel_price_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grocery_ecm`.`fuel`.`grade`(`grade_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ADD CONSTRAINT `fk_fuel_price_change_event_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ADD CONSTRAINT `fk_fuel_price_change_event_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grocery_ecm`.`fuel`.`grade`(`grade_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ADD CONSTRAINT `fk_fuel_fuel_transaction_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grocery_ecm`.`fuel`.`grade`(`grade_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ADD CONSTRAINT `fk_fuel_fleet_card_account_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ADD CONSTRAINT `fk_fuel_fleet_card_fleet_card_account_id` FOREIGN KEY (`fleet_card_account_id`) REFERENCES `grocery_ecm`.`fuel`.`fleet_card_account`(`fleet_card_account_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ADD CONSTRAINT `fk_fuel_loyalty_fuel_redemption_fuel_transaction_id` FOREIGN KEY (`fuel_transaction_id`) REFERENCES `grocery_ecm`.`fuel`.`fuel_transaction`(`fuel_transaction_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ADD CONSTRAINT `fk_fuel_loyalty_fuel_redemption_pump_id` FOREIGN KEY (`pump_id`) REFERENCES `grocery_ecm`.`fuel`.`pump`(`pump_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ADD CONSTRAINT `fk_fuel_delivery_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ADD CONSTRAINT `fk_fuel_delivery_tank_id` FOREIGN KEY (`tank_id`) REFERENCES `grocery_ecm`.`fuel`.`tank`(`tank_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ADD CONSTRAINT `fk_fuel_delivery_schedule_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ADD CONSTRAINT `fk_fuel_delivery_schedule_tank_id` FOREIGN KEY (`tank_id`) REFERENCES `grocery_ecm`.`fuel`.`tank`(`tank_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ADD CONSTRAINT `fk_fuel_inventory_reconciliation_tank_id` FOREIGN KEY (`tank_id`) REFERENCES `grocery_ecm`.`fuel`.`tank`(`tank_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ADD CONSTRAINT `fk_fuel_pump_maintenance_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ADD CONSTRAINT `fk_fuel_pump_maintenance_pump_id` FOREIGN KEY (`pump_id`) REFERENCES `grocery_ecm`.`fuel`.`pump`(`pump_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ADD CONSTRAINT `fk_fuel_epa_compliance_report_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ADD CONSTRAINT `fk_fuel_environmental_incident_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ADD CONSTRAINT `fk_fuel_competitor_fuel_price_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ADD CONSTRAINT `fk_fuel_rack_price_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grocery_ecm`.`fuel`.`grade`(`grade_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ADD CONSTRAINT `fk_fuel_tax_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ADD CONSTRAINT `fk_fuel_tax_superseded_tax_id` FOREIGN KEY (`superseded_tax_id`) REFERENCES `grocery_ecm`.`fuel`.`tax`(`tax_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ADD CONSTRAINT `fk_fuel_fuel_pricing_center_id` FOREIGN KEY (`center_id`) REFERENCES `grocery_ecm`.`fuel`.`center`(`center_id`);
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ADD CONSTRAINT `fk_fuel_fuel_pricing_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grocery_ecm`.`fuel`.`grade`(`grade_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`fuel` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `grocery_ecm`.`fuel` SET TAGS ('dbx_domain' = 'fuel');
ALTER TABLE `grocery_ecm`.`fuel`.`center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fuel`.`center` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center ID');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Default Fuel Carrier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Price Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `alternative_fuel_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fuel Available Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `canopy_configuration` SET TAGS ('dbx_business_glossary_term' = 'Canopy Configuration');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `canopy_configuration` SET TAGS ('dbx_value_regex' = 'single_canopy|dual_canopy|multi_canopy|no_canopy');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `car_wash_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Car Wash Available Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `convenience_store_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Convenience Store Attached Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `diesel_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Diesel Available Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `dispenser_count` SET TAGS ('dbx_business_glossary_term' = 'Dispenser Count');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Status');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|temporarily_closed|permanently_closed|under_maintenance');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `fuel_center_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Code');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `fuel_center_code` SET TAGS ('dbx_value_regex' = '^FC[0-9]{6}$');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `fuel_center_name` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Name');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `fuel_grades_offered` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grades Offered');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `last_equipment_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Equipment Maintenance Date');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `loyalty_discount_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Discount Enabled Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `pos_integration_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'POS (Point of Sale) Integration Enabled Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `premium_fuel_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Premium Fuel Available Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `pump_island_count` SET TAGS ('dbx_business_glossary_term' = 'Pump Island Count');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `rfid_fleet_card_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Fleet Card Enabled Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `state_petroleum_license_number` SET TAGS ('dbx_business_glossary_term' = 'State Petroleum License Number');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `tank_count` SET TAGS ('dbx_business_glossary_term' = 'Tank Count');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `total_storage_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Capacity Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `twenty_four_hour_operation_flag` SET TAGS ('dbx_business_glossary_term' = 'Twenty-Four Hour Operation Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`center` ALTER COLUMN `ust_registration_number` SET TAGS ('dbx_business_glossary_term' = 'UST (Underground Storage Tank) Registration Number');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `pump_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `certified_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Certified Measurement Accuracy');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `emergency_shutoff_type` SET TAGS ('dbx_business_glossary_term' = 'Emergency Shutoff Type');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `emergency_shutoff_type` SET TAGS ('dbx_value_regex' = 'manual|automatic|both');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `epa_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Certification Number');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `fleet_card_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fleet Card Enabled');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `fuel_grade_capacity` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Capacity');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Pump Installation Date');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `loyalty_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Integration Enabled');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Pump Manufacturer');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Pump Model');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `nozzle_count` SET TAGS ('dbx_business_glossary_term' = 'Nozzle Count');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Pump Operational Status');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|out_of_service|decommissioned');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `payment_terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Terminal Type');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `payment_terminal_type` SET TAGS ('dbx_value_regex' = 'rfid|emv|nfc|magnetic_stripe|hybrid');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `pos_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Integration Enabled');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `prepay_only_mode` SET TAGS ('dbx_business_glossary_term' = 'Prepay Only Mode');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `pump_number` SET TAGS ('dbx_business_glossary_term' = 'Pump Number');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `pump_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `remote_shutoff_capable` SET TAGS ('dbx_business_glossary_term' = 'Remote Shutoff Capable');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Pump Serial Number');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `state_certification_number` SET TAGS ('dbx_business_glossary_term' = 'State Certification Number');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `vapor_recovery_system` SET TAGS ('dbx_business_glossary_term' = 'Vapor Recovery System Type');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `vapor_recovery_system` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_1_and_2|none');
ALTER TABLE `grocery_ecm`.`fuel`.`pump` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade ID');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'API (American Petroleum Institute) Gravity');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `biodiesel_blend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Biodiesel Blend Percentage');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `carbon_intensity_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity Score (gCO2e per MJ)');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `cetane_number` SET TAGS ('dbx_business_glossary_term' = 'Cetane Number');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Color Code');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `color_code` SET TAGS ('dbx_value_regex' = '^#[0-9A-F]{6}$');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `energy_content_btu_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Energy Content (BTU - British Thermal Unit per Gallon)');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `epa_fuel_category` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) Fuel Category');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `ethanol_blend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ethanol Blend Percentage');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `flash_point_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `fleet_card_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Fleet Card Accepted Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `grade_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Code');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `grade_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `grade_description` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Description');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `grade_name` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Name');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `grade_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Status');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `grade_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|seasonal');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `grade_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Type');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `grade_type` SET TAGS ('dbx_value_regex' = 'gasoline|diesel|alternative_fuel|additive');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'GTIN (Global Trade Item Number)');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'HAZMAT (Hazardous Materials) Classification');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `loyalty_discount_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Discount Eligible Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `octane_rating` SET TAGS ('dbx_business_glossary_term' = 'Octane Rating');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `reformulated_gasoline_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reformulated Gasoline (RFG) Indicator');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `renewable_identification_number` SET TAGS ('dbx_business_glossary_term' = 'RIN (Renewable Identification Number)');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `renewable_identification_number` SET TAGS ('dbx_value_regex' = '^[0-9]{38}$');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `sulfur_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content (PPM - Parts Per Million)');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `supplier_product_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Product Code');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `upc_code` SET TAGS ('dbx_business_glossary_term' = 'UPC (Universal Product Code)');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `upc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`grade` ALTER COLUMN `winter_blend_indicator` SET TAGS ('dbx_business_glossary_term' = 'Winter Blend Indicator');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `tank_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Identifier');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Identifier');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Tank Capacity in Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `cathodic_protection_test_date` SET TAGS ('dbx_business_glossary_term' = 'Cathodic Protection Test Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `corrosion_protection_type` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Protection Type');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `corrosion_protection_type` SET TAGS ('dbx_value_regex' = 'cathodic_protection|coated_steel|fiberglass|none');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `current_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Current Volume in Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Tank Decommission Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `decommission_method` SET TAGS ('dbx_business_glossary_term' = 'Tank Decommission Method');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `decommission_method` SET TAGS ('dbx_value_regex' = 'removed|filled_in_place|none');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `epa_ust_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Underground Storage Tank (UST) Registration Number');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Type');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_value_regex' = 'regular_unleaded|mid_grade|premium|diesel|e85|biodiesel');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `high_level_alarm_threshold_gallons` SET TAGS ('dbx_business_glossary_term' = 'High Level Alarm Threshold in Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Tank Installation Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `last_cleaning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Tank Cleaning Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `last_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Last Fuel Delivery Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `last_delivery_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Last Delivery Volume in Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `last_tightness_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Tightness Test Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `leak_detection_method` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Method');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `leak_detection_method` SET TAGS ('dbx_value_regex' = 'automatic_tank_gauging|vapor_monitoring|groundwater_monitoring|interstitial_monitoring|statistical_inventory_reconciliation');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `lining_type` SET TAGS ('dbx_business_glossary_term' = 'Tank Lining Type');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `low_level_alarm_threshold_gallons` SET TAGS ('dbx_business_glossary_term' = 'Low Level Alarm Threshold in Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Tank Manufacturer Name');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Tank Construction Material');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `material` SET TAGS ('dbx_value_regex' = 'steel|fiberglass|composite');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Tank Model Number');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `next_cleaning_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Tank Cleaning Due Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `next_tightness_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Tightness Test Due Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tank Notes');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Tank Operational Status');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|out_of_service|decommissioned|under_maintenance|temporarily_closed');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `overfill_prevention_device` SET TAGS ('dbx_business_glossary_term' = 'Overfill Prevention Device Type');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `overfill_prevention_device` SET TAGS ('dbx_value_regex' = 'automatic_shutoff|high_level_alarm|ball_float_valve|none');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `reorder_threshold_gallons` SET TAGS ('dbx_business_glossary_term' = 'Reorder Threshold in Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `secondary_containment_flag` SET TAGS ('dbx_business_glossary_term' = 'Secondary Containment Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Tank Serial Number');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `spill_prevention_device` SET TAGS ('dbx_business_glossary_term' = 'Spill Prevention Device Type');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `spill_prevention_device` SET TAGS ('dbx_value_regex' = 'catchment_basin|spill_bucket|none');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `tank_number` SET TAGS ('dbx_business_glossary_term' = 'Tank Number');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `temperature_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `grocery_ecm`.`fuel`.`tank` ALTER COLUMN `water_detection_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Detection Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `tank_level_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Level Reading ID');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `inventory_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period ID');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `tank_id` SET TAGS ('dbx_business_glossary_term' = 'Tank ID');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `alarm_status` SET TAGS ('dbx_business_glossary_term' = 'Alarm Status');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `atg_device_code` SET TAGS ('dbx_business_glossary_term' = 'Automatic Tank Gauge (ATG) Device ID');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `atg_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `atg_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|calibration_required|sensor_error');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `delivery_in_progress_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery In Progress Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `fuel_height_inches` SET TAGS ('dbx_business_glossary_term' = 'Fuel Height (Inches)');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `fuel_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Temperature (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `gross_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Gross Volume (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `leak_detection_status` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Status');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `leak_detection_status` SET TAGS ('dbx_value_regex' = 'pass|fail|inconclusive|test_not_run|system_disabled');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `net_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Net Volume (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reading Notes');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `reading_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Reading Sequence Number');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `reading_source` SET TAGS ('dbx_business_glossary_term' = 'Reading Source');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `reading_source` SET TAGS ('dbx_value_regex' = 'ATG_automated|manual_dipstick|calibration|inspection');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `ullage_gallons` SET TAGS ('dbx_business_glossary_term' = 'Ullage (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `variance_gallons` SET TAGS ('dbx_business_glossary_term' = 'Variance (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`tank_level_reading` ALTER COLUMN `water_level_inches` SET TAGS ('dbx_business_glossary_term' = 'Water Level (Inches)');
ALTER TABLE `grocery_ecm`.`fuel`.`price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fuel`.`price` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Price ID');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager ID');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center ID');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `grade_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason Code');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'COMPETITIVE|RACK_MOVEMENT|PROMOTIONAL|MANUAL_OVERRIDE|SCHEDULED|COST_RECOVERY');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `change_trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Change Trigger Source');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `change_trigger_source` SET TAGS ('dbx_value_regex' = 'AUTOMATED_COMPETITIVE_FEED|RACK_INDEX_THRESHOLD|MANAGER_DECISION|PRICING_SYSTEM|PROMOTIONAL_CALENDAR');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `competitor_price_reference` SET TAGS ('dbx_business_glossary_term' = 'Competitor Price Reference');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `cost_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `cost_per_gallon` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `loyalty_discount_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Discount Eligible Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `margin_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Margin Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `margin_per_gallon` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `max_loyalty_discount_cents` SET TAGS ('dbx_business_glossary_term' = 'Maximum Loyalty Discount Cents Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Price Change Notes');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `pos_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Synchronization Status');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `pos_sync_status` SET TAGS ('dbx_value_regex' = 'PENDING|CONFIRMED|FAILED|ROLLBACK');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `pos_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Synchronization Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `prior_street_price` SET TAGS ('dbx_business_glossary_term' = 'Prior Street Price Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `prior_street_price` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `prior_street_price` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `promotional_price_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `rack_price_index` SET TAGS ('dbx_business_glossary_term' = 'Rack Price Index');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `rack_price_index` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `regulatory_posting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Posting Required Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `regulatory_posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Posting Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Price Source System');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `street_price` SET TAGS ('dbx_business_glossary_term' = 'Street Price Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `street_price` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `street_price` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Price Version Number');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `price_change_event_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Event ID');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager ID');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center ID');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade ID');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `change_trigger` SET TAGS ('dbx_business_glossary_term' = 'Price Change Trigger');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `change_trigger` SET TAGS ('dbx_value_regex' = 'competitive_response|rack_price_movement|promotional|manual_override|scheduled_adjustment|cost_recovery');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `competitor_reference_price` SET TAGS ('dbx_business_glossary_term' = 'Competitor Reference Price');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Price Change Event Number');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `loyalty_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Discount Applied Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `margin_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Margin Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `margin_per_gallon` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `new_price` SET TAGS ('dbx_business_glossary_term' = 'New Price Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `pos_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Synchronization Status');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `pos_sync_status` SET TAGS ('dbx_value_regex' = 'pending|synchronized|failed|manual_intervention_required');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `pos_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Synchronization Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `price_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `price_change_notes` SET TAGS ('dbx_business_glossary_term' = 'Price Change Notes');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `price_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `price_sign_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Sign Update Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `price_sign_updated` SET TAGS ('dbx_business_glossary_term' = 'Price Sign Updated Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `prior_price` SET TAGS ('dbx_business_glossary_term' = 'Prior Price Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `rack_price` SET TAGS ('dbx_business_glossary_term' = 'Rack Price Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `rack_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`price_change_event` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `fuel_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Transaction ID');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `grade_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `associate_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `associate_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `carwash_bundled_flag` SET TAGS ('dbx_business_glossary_term' = 'Carwash Bundled Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `epa_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Reporting Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `federal_excise_tax` SET TAGS ('dbx_business_glossary_term' = 'Federal Excise Tax');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `fleet_card_number` SET TAGS ('dbx_business_glossary_term' = 'Fleet Card Number');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `fleet_card_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `fleet_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `fleet_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `fuel_discount_cents_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Fuel Discount Cents Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `gallons_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Gallons Dispensed');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `gross_sale_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sale Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `local_excise_tax` SET TAGS ('dbx_business_glossary_term' = 'Local Excise Tax');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Card Number');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `net_amount_charged` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Charged');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit|debit|fleet_card|ebt|cash|mobile_payment');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `pos_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction Reference');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `pos_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,50}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `prepay_flag` SET TAGS ('dbx_business_glossary_term' = 'Prepay Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `pump_number` SET TAGS ('dbx_business_glossary_term' = 'Pump Number');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `pump_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `state_excise_tax` SET TAGS ('dbx_business_glossary_term' = 'State Excise Tax');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `terminal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,15}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|voided|refunded|pending|failed');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `vehicle_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `vehicle_identification_number` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9]{17}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `vehicle_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_transaction` ALTER COLUMN `vehicle_odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Odometer Reading');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` SET TAGS ('dbx_subdomain' = 'fleet_services');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `fleet_card_account_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Card Account ID');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `account_close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Fleet Account Number');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `account_open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Fleet Account Status');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_activation|delinquent|frozen');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `active_cards_count` SET TAGS ('dbx_business_glossary_term' = 'Active Cards Count');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `authorized_fuel_grades` SET TAGS ('dbx_business_glossary_term' = 'Authorized Fuel Grades');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `card_program_type` SET TAGS ('dbx_business_glossary_term' = 'Card Program Type');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `card_program_type` SET TAGS ('dbx_value_regex' = 'proprietary|wex|voyager|mastercard_fleet|visa_fleet|fleet_one');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `daily_transaction_limit_count` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit Count');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `daily_volume_limit_gallons` SET TAGS ('dbx_business_glossary_term' = 'Daily Volume Limit Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `discount_rate_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `discount_rate_per_gallon` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `discount_tier` SET TAGS ('dbx_business_glossary_term' = 'Discount Tier');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `discount_tier` SET TAGS ('dbx_value_regex' = 'standard|bronze|silver|gold|platinum');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `fleet_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Fleet Operator Name');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `fleet_operator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `loyalty_program_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Linked Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `per_fill_volume_cap_gallons` SET TAGS ('dbx_business_glossary_term' = 'Per-Fill Volume Cap Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `pin_required_flag` SET TAGS ('dbx_business_glossary_term' = 'PIN (Personal Identification Number) Required Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Enabled Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `total_cards_issued` SET TAGS ('dbx_business_glossary_term' = 'Total Cards Issued');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card_account` ALTER COLUMN `weekly_spending_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Weekly Spending Limit Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` SET TAGS ('dbx_subdomain' = 'fleet_services');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `fleet_card_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Card ID');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `associate_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `associate_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `fleet_card_account_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Card Account ID');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `authorized_fuel_grades` SET TAGS ('dbx_business_glossary_term' = 'Authorized Fuel Grades');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Card Cancellation Date');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Card Cancellation Reason');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `card_format` SET TAGS ('dbx_business_glossary_term' = 'Card Format');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `card_format` SET TAGS ('dbx_value_regex' = 'magnetic_stripe|chip|rfid|contactless|hybrid');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `card_number` SET TAGS ('dbx_business_glossary_term' = 'Fleet Card Number');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `card_replacement_reason` SET TAGS ('dbx_business_glossary_term' = 'Card Replacement Reason');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `card_status` SET TAGS ('dbx_business_glossary_term' = 'Fleet Card Status');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `card_status` SET TAGS ('dbx_value_regex' = 'active|suspended|lost|stolen|expired|cancelled');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Fleet Card Type');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'vehicle|driver|universal|temporary|emergency|contractor');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `daily_spend_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Spend Limit Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `day_of_week_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Day of Week Restrictions');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Card Expiration Date');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Card Issue Date');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `loyalty_discount_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Discount Eligible Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `merchant_category_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Restrictions');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `odometer_prompt_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Odometer Prompt Required Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `per_fill_volume_cap_gallons` SET TAGS ('dbx_business_glossary_term' = 'Per-Fill Volume Cap (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `pin_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'PIN (Personal Identification Number) Enabled Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `pin_last_changed_date` SET TAGS ('dbx_business_glossary_term' = 'PIN (Personal Identification Number) Last Changed Date');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `replaced_card_number` SET TAGS ('dbx_business_glossary_term' = 'Replaced Card Number');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `replaced_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `replaced_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `rfid_technology_type` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Technology Type');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `rfid_technology_type` SET TAGS ('dbx_value_regex' = 'passive|active|semi_passive');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Card Suspension Date');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Card Suspension Reason');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `time_of_day_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Time of Day Restrictions');
ALTER TABLE `grocery_ecm`.`fuel`.`fleet_card` ALTER COLUMN `vehicle_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` SET TAGS ('dbx_subdomain' = 'fleet_services');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `loyalty_fuel_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Fuel Redemption ID');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `fuel_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Transaction ID');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `membership_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `program_config_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Program ID');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `pump_id` SET TAGS ('dbx_business_glossary_term' = 'Pump ID');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'pump|mobile_app|kiosk|cashier');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `discount_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Discount Expiration Date');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `discount_rate_cents_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (Cents Per Gallon)');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `fleet_card_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Fleet Card Number (Masked)');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `fleet_card_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `fleet_card_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_value_regex' = 'regular|midgrade|premium|diesel|e85|unleaded');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `gallons_discounted` SET TAGS ('dbx_business_glossary_term' = 'Gallons Discounted');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `max_discount_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Limit Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `max_gallons_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Gallons Limit');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|fleet_card|mobile_payment|cash');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `points_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Points Balance After Redemption');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `points_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Points Balance Before Redemption');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|discrepancy|adjusted');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `redemption_source` SET TAGS ('dbx_business_glossary_term' = 'Redemption Source');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `redemption_source` SET TAGS ('dbx_value_regex' = 'loyalty_points|promotional_offer|partner_reward|credit_card_linked|fleet_card|bonus_points');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'completed|pending|reversed|failed|expired');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `transaction_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Receipt Number');
ALTER TABLE `grocery_ecm`.`fuel`.`loyalty_fuel_redemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Delivery ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `tank_id` SET TAGS ('dbx_business_glossary_term' = 'Tank ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `actual_delivery_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery End Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `actual_delivery_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Start Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,25}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Cost Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `cost_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `cost_per_gallon` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `driver_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Driver Signature Captured');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `epa_compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'EPA Compliance Verified');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `estimated_gallons_ordered` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gallons Ordered');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `gross_gallons_delivered` SET TAGS ('dbx_business_glossary_term' = 'Gross Gallons Delivered');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `net_gallons_delivered` SET TAGS ('dbx_business_glossary_term' = 'Net Gallons Delivered');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `order_confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmation Reference');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `order_confirmation_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `post_delivery_tank_level_gallons` SET TAGS ('dbx_business_glossary_term' = 'Post-Delivery Tank Level (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `pre_delivery_tank_level_gallons` SET TAGS ('dbx_business_glossary_term' = 'Pre-Delivery Tank Level (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `quality_test_passed` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Passed');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `reorder_trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Reorder Trigger Type');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `reorder_trigger_type` SET TAGS ('dbx_value_regex' = 'atg_automated|cao_automated|manual_order|emergency_order');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `scheduled_delivery_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery End Time');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `scheduled_delivery_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Start Time');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Delivery Temperature (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Ticket Number');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `truck_number` SET TAGS ('dbx_business_glossary_term' = 'Truck Number');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `truck_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `variance_gallons` SET TAGS ('dbx_business_glossary_term' = 'Variance (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `tank_id` SET TAGS ('dbx_business_glossary_term' = 'Tank ID');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `actual_gallons_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Gallons Delivered');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^BOL-[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `cancelled_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Reason');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Reference');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `confirmation_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `current_tank_level_gallons` SET TAGS ('dbx_business_glossary_term' = 'Current Tank Level Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `driver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `epa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) Compliance Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `estimated_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_value_regex' = 'Regular|Midgrade|Premium|Diesel|E85|Unleaded');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'Scheduled|Confirmed|In_Transit|Delivered|Cancelled|Delayed');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'Standard|High|Critical|Emergency');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `quality_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Number');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `quality_certification_number` SET TAGS ('dbx_value_regex' = '^QC-[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `reorder_threshold_gallons` SET TAGS ('dbx_business_glossary_term' = 'Reorder Threshold Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `reorder_trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Reorder Trigger Type');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `reorder_trigger_type` SET TAGS ('dbx_value_regex' = 'ATG_Automated|CAO_Automated|Manual|Emergency');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `rescheduled_from_date` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled From Date');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `temperature_at_delivery` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Delivery');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `unit_price_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `variance_gallons` SET TAGS ('dbx_business_glossary_term' = 'Variance Gallons');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `vehicle_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Number');
ALTER TABLE `grocery_ecm`.`fuel`.`delivery_schedule` ALTER COLUMN `vehicle_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `inventory_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reconciliation ID');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period ID');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `tank_id` SET TAGS ('dbx_business_glossary_term' = 'Tank ID');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `atg_physical_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Automatic Tank Gauge (ATG) Physical Volume (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `atg_system_code` SET TAGS ('dbx_business_glossary_term' = 'Automatic Tank Gauge (ATG) System ID');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `atg_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `average_tank_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Average Tank Temperature (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `closing_book_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Closing Book Volume (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `cost_of_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Variance Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `cost_of_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Count');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `fuel_grade_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Code');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `fuel_grade_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `leak_detection_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detection Compliance Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `opening_book_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Opening Book Volume (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_value_regex' = 'manual|automated|hybrid');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `reconciliation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `reconciliation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_investigation|closed');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `shrink_category` SET TAGS ('dbx_business_glossary_term' = 'Shrink Category');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `shrink_category` SET TAGS ('dbx_value_regex' = 'within_tolerance|minor_shrink|major_shrink|overage|suspected_leak');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `temperature_compensation_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compensation Applied Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `temperature_compensation_applied_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `temperature_compensation_applied_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `total_deliveries_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Total Deliveries Volume (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `total_dispensed_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Total Dispensed Volume (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `variance_threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Exceeded Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `variance_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Variance Volume (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`inventory_reconciliation` ALTER COLUMN `water_level_inches` SET TAGS ('dbx_business_glossary_term' = 'Water Level (Inches)');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `pump_maintenance_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Maintenance ID');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center ID');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `pump_id` SET TAGS ('dbx_business_glossary_term' = 'Pump ID');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `calibration_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `calibration_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Performed Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `inspection_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Passed Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|calibration|inspection|emergency|compliance');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Notes');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `parts_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `parts_replaced` SET TAGS ('dbx_business_glossary_term' = 'Parts Replaced');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `return_to_service_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return to Service Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Maintenance Date');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `grocery_ecm`.`fuel`.`pump_maintenance` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8,12}$');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `epa_compliance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Compliance Report ID');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center ID');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `affected_media` SET TAGS ('dbx_business_glossary_term' = 'Affected Media');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `affected_media` SET TAGS ('dbx_value_regex' = 'soil|groundwater|surface_water|air|multiple_media');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'leak_detection|release_reporting|spill_overfill_prevention|corrosion_protection|financial_responsibility|operator_training');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|corrective_action_required|remediation_in_progress|closed');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_value_regex' = 'regular_unleaded|mid_grade|premium|diesel|e85|biodiesel');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `immediate_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Immediate Response Actions');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `incident_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Closure Date');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'fuel_spill|tank_leak|vapor_release|soil_contamination|groundwater_contamination|surface_water_contamination');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `inspection_findings` SET TAGS ('dbx_business_glossary_term' = 'Inspection Findings');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `remediation_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Reference');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|monitoring|completed|verified_closed');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'EPA Report Number');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'compliance_reporting|environmental_incident|inspection_finding|corrective_action|remediation_status');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `tank_number` SET TAGS ('dbx_business_glossary_term' = 'Tank Number');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `ust_system_code` SET TAGS ('dbx_business_glossary_term' = 'Underground Storage Tank (UST) System ID');
ALTER TABLE `grocery_ecm`.`fuel`.`epa_compliance_report` ALTER COLUMN `volume_released_gallons` SET TAGS ('dbx_business_glossary_term' = 'Volume Released (Gallons)');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `environmental_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident ID');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center ID');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Associate ID');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `affected_media` SET TAGS ('dbx_business_glossary_term' = 'Affected Media');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `affected_media` SET TAGS ('dbx_value_regex' = 'soil|groundwater|surface_water|air|multiple');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `cause_category` SET TAGS ('dbx_business_glossary_term' = 'Cause Category');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Cause Description');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `closure_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Closure Approved By');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Closure Date');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `emergency_responder_notified` SET TAGS ('dbx_business_glossary_term' = 'Emergency Responder Notified');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `emergency_responder_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Emergency Responder Notification Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `epa_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) Notification Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `epa_notified` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) Notified');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `fuel_grade_released` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade Released');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `fuel_grade_released` SET TAGS ('dbx_value_regex' = 'regular_unleaded|mid_grade|premium|diesel|e85|kerosene');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `immediate_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Immediate Response Actions');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|remediation_in_progress|monitoring|closed|regulatory_review');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'fuel_spill|tank_leak|vapor_release|groundwater_contamination|soil_contamination|surface_water_contamination');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `monitoring_end_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring End Date');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Required');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `nrc_report_number` SET TAGS ('dbx_business_glossary_term' = 'NRC (National Response Center) Report Number');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `nrc_report_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,10}$');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `regulatory_penalty_assessed` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Assessed');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `remediation_contractor` SET TAGS ('dbx_business_glossary_term' = 'Remediation Contractor');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `remediation_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Reference');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `remediation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Start Date');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `source_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Source Equipment ID');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `source_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Source Equipment Type');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `state_agency_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'State Environmental Agency Notification Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `state_agency_notified` SET TAGS ('dbx_business_glossary_term' = 'State Environmental Agency Notified');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `total_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Remediation Cost');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `total_remediation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`environmental_incident` ALTER COLUMN `volume_released` SET TAGS ('dbx_business_glossary_term' = 'Volume Released');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_fuel_price_id` SET TAGS ('dbx_business_glossary_term' = 'Competitor Fuel Price ID');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center ID');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitive_position` SET TAGS ('dbx_business_glossary_term' = 'Competitive Position');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitive_position` SET TAGS ('dbx_value_regex' = 'below_market|at_market|above_market');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_latitude` SET TAGS ('dbx_business_glossary_term' = 'Competitor Site Latitude');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_longitude` SET TAGS ('dbx_business_glossary_term' = 'Competitor Site Longitude');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_site_address` SET TAGS ('dbx_business_glossary_term' = 'Competitor Site Address');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `competitor_site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `distance_to_fuel_center_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance to Fuel Center (Miles)');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `distributor_source` SET TAGS ('dbx_business_glossary_term' = 'Distributor Source');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_value_regex' = 'regular|midgrade|premium|diesel|e85|e15');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `index_provider` SET TAGS ('dbx_business_glossary_term' = 'Index Provider');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `index_provider` SET TAGS ('dbx_value_regex' = 'OPIS|Platts|DTN');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Observation Notes');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `observation_method` SET TAGS ('dbx_business_glossary_term' = 'Observation Method');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `observation_method` SET TAGS ('dbx_value_regex' = 'manual_survey|automated_scrape|api_feed|email_report|phone_call');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `observed_price_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Observed Price Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `observer_name` SET TAGS ('dbx_business_glossary_term' = 'Observer Name');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'street_retail|terminal_rack|spot_market|contract');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `price_change_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Change Trigger Flag');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `price_differential_cents` SET TAGS ('dbx_business_glossary_term' = 'Price Differential (Cents)');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `source_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source Identifier');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Price Source Type');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'competitor_survey|automated_feed|rack_index|spot_market|contract_terminal');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `terminal_name` SET TAGS ('dbx_business_glossary_term' = 'Terminal Name');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|flagged|rejected');
ALTER TABLE `grocery_ecm`.`fuel`.`competitor_fuel_price` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `rack_price_id` SET TAGS ('dbx_business_glossary_term' = 'Rack Price ID');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade ID');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `contract_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Term End Date');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `contract_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Start Date');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'EDI|API|Manual|Email|FTP');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `distributor_code` SET TAGS ('dbx_business_glossary_term' = 'Distributor Code');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `environmental_fee_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `freight_cost_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `index_source` SET TAGS ('dbx_business_glossary_term' = 'Index Source');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `index_source` SET TAGS ('dbx_value_regex' = 'OPIS|Platts|DTN|Argus|Internal');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Rack Price Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `price_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Factor');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'terminal|spot|contract|index');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|superseded|cancelled');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'wholesale|retail_reference|cost_plus|market_index');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `tax_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Tax Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `terminal_city` SET TAGS ('dbx_business_glossary_term' = 'Terminal City');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `terminal_location` SET TAGS ('dbx_business_glossary_term' = 'Terminal Location');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `terminal_state_province_code` SET TAGS ('dbx_business_glossary_term' = 'Terminal State or Province Code');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `total_delivered_cost_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Total Delivered Cost Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`rack_price` ALTER COLUMN `volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Tax Record Identifier');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `superseded_tax_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `applicability` SET TAGS ('dbx_business_glossary_term' = 'Tax Applicability Scope (SCOPE)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `applicability` SET TAGS ('dbx_value_regex' = 'sale|delivery|both');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Audit Status (STATUS)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|under_review');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Timestamp (TS)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Tax Category Code (CODE)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (FLAG)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (TS)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Effective Date (DATE)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `exempt_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason Code (CODE)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `exempt_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason Description (DESC)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `exempt_transaction_flag` SET TAGS ('dbx_business_glossary_term' = 'Exempt Transaction Indicator (FLAG)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `exemption_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Rule Description (DESC)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Expiration Date (DATE)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `filing_deadline_day` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Deadline Day (DAY)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (ID)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code (CODE)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Level (LEVEL)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_value_regex' = 'federal|state|county|city');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Name (NAME)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `last_effective_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Effective Change Timestamp (TS)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTE)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Currency Code (ISO)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `rate_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Effective Timestamp (TS)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `rate_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Fuel Tax Rate Per Gallon (RATE)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `remittance_account` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Account (ACCOUNT)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `remittance_account` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `remittance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Frequency (FREQ)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `remittance_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|semiannual');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SYSTEM)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel Tax Record Status (STATUS)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `tax_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Tax Type (TYPE)');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'excise|environmental|ust_fee|other');
ALTER TABLE `grocery_ecm`.`fuel`.`tax` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (TS)');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` SET TAGS ('dbx_subdomain' = 'fuel_operations');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` SET TAGS ('dbx_association_edges' = 'fuel.fuel_center,fuel.fuel_grade');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ALTER COLUMN `fuel_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Fuelpricing - Fuel Pricing Id');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuelpricing - Fuel Center Id');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Fuelpricing - Fuel Grade Id');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ALTER COLUMN `cost_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ALTER COLUMN `margin_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Margin Per Gallon');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ALTER COLUMN `street_price` SET TAGS ('dbx_business_glossary_term' = 'Street Price');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ALTER COLUMN `street_price` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fuel`.`fuel_pricing` ALTER COLUMN `street_price` SET TAGS ('dbx_pii_address' = 'true');
