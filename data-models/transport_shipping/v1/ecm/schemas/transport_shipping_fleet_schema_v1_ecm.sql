-- Schema for Domain: fleet | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`fleet` COMMENT 'Fleet and transport asset management covering the full lifecycle of owned and leased vehicles, aircraft, vessels, and containers. Owns asset master data, GPS telematics, RFID tagging, maintenance scheduling, fuel consumption, driver assignment, regulatory compliance (DOT, ICAO), CAPEX/OPEX asset tracking, and fleet utilization KPIs. Integrates with TMS for route execution and IoT sensor data for real-time visibility.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` (
    `transport_asset_id` BIGINT COMMENT 'Unique identifier for the transport asset. Primary key for the transport asset master record.',
    `asset_type_id` BIGINT COMMENT 'Foreign key linking to fleet.asset_type. Business justification: transport_asset currently has asset_type (STRING) and asset_subtype (STRING) storing the asset classification as free text. The asset_type reference table provides the authoritative taxonomy with asse',
    `depot_id` BIGINT COMMENT 'Identifier of the depot, hub, or facility where the transport asset is currently based or assigned for operational purposes.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fleet assets incur operational expenses (fuel, maintenance, insurance, depreciation) that must be allocated to cost centers for budget tracking, variance analysis, and departmental P&L reporting - fun',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Transport assets generate revenue through freight assignments and must be tracked by profit center for segment profitability analysis, EBITDA reporting, and service line performance measurement - core',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Capital expenditure (CAPEX) value of the transport asset at the time of acquisition. Recorded in the organizations base currency for financial reporting and depreciation calculation.',
    `acquisition_date` DATE COMMENT 'Date when the transport asset was acquired, purchased, or leased by the organization. Used for depreciation and lifecycle tracking.',
    `asset_name` STRING COMMENT 'Human-readable name or designation of the transport asset for operational identification and reporting purposes.',
    `asset_number` STRING COMMENT 'Externally-known unique asset identification number or registration code assigned to the transport asset. Used for tracking, compliance, and operational reference.. Valid values are `^[A-Z0-9]{6,20}$`',
    `co2_emission_rate_g_per_km` DECIMAL(18,2) COMMENT 'Carbon dioxide equivalent (CO2e) emission rate in grams per kilometer. Used for greenhouse gas (GHG) reporting and sustainability KPI (Key Performance Indicator) tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transport asset record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost and financial values associated with the transport asset.. Valid values are `^[A-Z]{3}$`',
    `current_location` STRING COMMENT 'Real-time or last known location of the transport asset. Updated via GPS telematics or manual check-in for visibility and tracking.',
    `decommission_date` DATE COMMENT 'Date when the transport asset was retired from active service or decommissioned. Marks the end of the assets operational lifecycle.',
    `disposal_date` DATE COMMENT 'Date when the transport asset was sold, scrapped, or otherwise disposed of. Used for final financial accounting and asset register closure.',
    `disposal_value` DECIMAL(18,2) COMMENT 'Salvage or resale value realized when the transport asset was disposed of. Used for capital expenditure (CAPEX) recovery tracking and financial reporting.',
    `emission_standard` STRING COMMENT 'Environmental emission standard or certification that the transport asset complies with (e.g., Euro 6, EPA Tier 4). Required for regulatory compliance and sustainability reporting.',
    `engine_power_kw` DECIMAL(18,2) COMMENT 'Engine power output measured in kilowatts. Indicates performance capability and operational efficiency of the transport asset.',
    `engine_type` STRING COMMENT 'Engine model or type specification for the transport asset. Used for maintenance planning, parts sourcing, and performance tracking.',
    `fuel_capacity_liters` DECIMAL(18,2) COMMENT 'Maximum fuel tank capacity in liters. Used for range calculation and refueling planning.',
    `fuel_type` STRING COMMENT 'Primary fuel or energy source used by the transport asset. Determines refueling infrastructure requirements and greenhouse gas (GHG) emissions calculations. [ENUM-REF-CANDIDATE: diesel|gasoline|electric|hybrid|cng|lng|jet_fuel|marine_fuel — 8 candidates stripped; promote to reference product]',
    `height_meters` DECIMAL(18,2) COMMENT 'Physical height of the transport asset in meters. Critical for bridge clearance, tunnel access, and loading dock compatibility.',
    `home_location` STRING COMMENT 'Primary base location or home terminal for the transport asset. Used for route planning and operational assignment.',
    `insurance_expiry_date` DATE COMMENT 'Date when the current insurance policy for the transport asset expires. Used for compliance tracking and renewal scheduling.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering the transport asset for liability, damage, and loss. Required for risk management and claims processing.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent scheduled or unscheduled maintenance was performed on the transport asset. Used for maintenance interval tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the transport asset record was last updated in the system. Used for audit trail and change tracking.',
    `length_meters` DECIMAL(18,2) COMMENT 'Physical length of the transport asset in meters. Used for parking allocation, route clearance, and infrastructure compatibility.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer or builder of the transport asset. Used for warranty tracking, parts sourcing, and maintenance planning.',
    `model` STRING COMMENT 'Manufacturers model designation or series name for the transport asset. Identifies specific design and capability specifications.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance service on the transport asset. Critical for operational planning and compliance with safety regulations.',
    `odometer_reading` DECIMAL(18,2) COMMENT 'Current odometer or mileage reading for road vehicles, or equivalent usage metric (flight hours for aircraft, engine hours for vessels). Used for maintenance scheduling and utilization tracking.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the transport asset indicating availability for operations, maintenance, or retirement status.. Valid values are `active|in_maintenance|idle|decommissioned|reserved|out_of_service`',
    `ownership_type` STRING COMMENT 'Legal ownership or control arrangement for the transport asset. Determines financial treatment and operational flexibility.. Valid values are `owned|leased|chartered|rented`',
    `payload_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity in kilograms that the transport asset can carry. Critical for load planning and compliance with weight regulations.',
    `registration_country` STRING COMMENT 'Three-letter ISO country code where the transport asset is registered. Determines applicable regulatory jurisdiction and compliance requirements.. Valid values are `^[A-Z]{3}$`',
    `registration_expiry_date` DATE COMMENT 'Date when the current registration or license for the transport asset expires. Used for compliance tracking and renewal scheduling.',
    `registration_number` STRING COMMENT 'Government-issued registration or license plate number for the transport asset. Required for legal operation and regulatory compliance (DOT, ICAO, IMO).',
    `rfid_tag` STRING COMMENT 'RFID (Radio Frequency Identification) tag identifier attached to the transport asset for automated identification, access control, and yard management.. Valid values are `^[A-F0-9]{24}$`',
    `telematics_device_code` STRING COMMENT 'Unique identifier of the GPS (Global Positioning System) telematics device installed on the transport asset for real-time tracking, route monitoring, and IoT (Internet of Things) sensor data collection.. Valid values are `^[A-Z0-9]{8,20}$`',
    `teu_capacity` DECIMAL(18,2) COMMENT 'Container capacity measured in TEU (Twenty-foot Equivalent Unit) for vessels and rail units. Standard measure for container shipping capacity.',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of time the transport asset is actively deployed in operations versus idle or available time. Key performance indicator (KPI) for fleet efficiency and return on investment (ROI).',
    `vin_serial_number` STRING COMMENT 'Unique vehicle identification number (VIN) for road vehicles or manufacturer serial number for aircraft, vessels, and rail units. Used for registration, insurance, and theft prevention.. Valid values are `^[A-HJ-NPR-Z0-9]{17}$`',
    `volume_capacity_cbm` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity in cubic meters (CBM) that the transport asset can accommodate. Used for space optimization and dimensional weight (DIM weight) calculations.',
    `width_meters` DECIMAL(18,2) COMMENT 'Physical width of the transport asset in meters. Used for route clearance and infrastructure compatibility assessment.',
    `year_of_manufacture` STRING COMMENT 'Calendar year when the transport asset was manufactured or built. Used for age-based maintenance scheduling and regulatory compliance.',
    CONSTRAINT pk_transport_asset PRIMARY KEY(`transport_asset_id`)
) COMMENT 'Master record for all owned and leased transport assets in the fleet including vehicles (trucks, vans, motorcycles), aircraft, vessels, and rail units. Captures asset identity, classification, registration, ownership type (owned/leased/chartered), acquisition date, CAPEX value, current operational status, assigned depot/hub, telematics device ID, RFID tag, DOT/ICAO registration numbers, payload capacity, dimensional specs (CBM, DIM weight), fuel type, engine specs, and full lifecycle state (active, in-maintenance, decommissioned). This is the SSOT for all fleet asset master data.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`container_unit` (
    `container_unit_id` BIGINT COMMENT 'Unique identifier for the container unit. Primary key for the container_unit data product.',
    `asset_type_id` BIGINT COMMENT 'Foreign key linking to fleet.asset_type. Business justification: container_unit currently has container_type (STRING) storing the container classification as free text. Containers are a category of fleet assets and should reference the asset_type taxonomy. The asse',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Container units are capital assets with maintenance, storage, and handling costs that must be allocated to cost centers for operational expense tracking and budget management in container logistics op',
    `depot_id` BIGINT COMMENT 'Foreign key linking to fleet.depot. Business justification: Containers have a current location (current_location_type, current_location_code). When a container is at a fleet depot, this FK provides a structured link. Nullable because containers can be at ports',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Containers generate revenue through leasing, per-diem charges, and freight assignments; profit center tracking enables container fleet profitability analysis and lease-vs-own financial decision-making',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire the container, including purchase price or initial lease payment. Used for CAPEX tracking, asset valuation, and return on investment analysis.',
    `acquisition_date` DATE COMMENT 'Date the container was acquired by the company (purchase or lease commencement). Used for asset tracking, depreciation schedules, and fleet age analysis.',
    `availability_status` STRING COMMENT 'Current operational status of the container. Available for booking, in use on a shipment, in transit empty, under repair/maintenance, retired from service, or lost/missing. Critical for inventory management and booking systems.. Valid values are `available|in_use|in_transit|under_repair|retired|lost`',
    `condition_grade` STRING COMMENT 'Physical condition assessment of the container. Grade A (excellent, cargo-worthy), B (good, minor wear), C (fair, requires monitoring), D (poor, repair needed), Scrap (end of life). Determines suitability for cargo types and repair priority.. Valid values are `A|B|C|D|scrap`',
    `container_number` STRING COMMENT 'Unique container identification number following ISO 6346 standard format (4 letter owner code + 6 digit serial number + 1 check digit). This is the globally recognized identifier for the container unit.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this container unit record was first created in the system. Used for audit trail and data lineage tracking.',
    `csc_certification_date` DATE COMMENT 'Date the current CSC safety certification was issued. Used to track certification validity and schedule re-inspection.',
    `csc_certification_number` STRING COMMENT 'Unique certification number issued under the International Convention for Safe Containers (CSC). Certifies the container meets structural safety standards for international transport.',
    `csc_expiry_date` DATE COMMENT 'Expiration date of the CSC safety certification. Containers must be re-inspected and re-certified before this date to remain in service. Non-compliance prevents international movement.',
    `current_book_value` DECIMAL(18,2) COMMENT 'Current accounting book value of the container after depreciation. Updated periodically based on depreciation schedule. Used for financial reporting and asset disposal decisions.',
    `current_location_code` STRING COMMENT 'Unique code identifying the specific facility, terminal, depot, or geographic location where the container is currently positioned. May be UN/LOCODE for ports or internal facility codes.',
    `current_location_country` STRING COMMENT 'Three-letter ISO country code of the containers current location. Used for geographic fleet distribution analysis and repositioning planning.. Valid values are `^[A-Z]{3}$`',
    `current_location_type` STRING COMMENT 'Type of facility or mode where the container is currently located. Depot (storage yard), port (marine terminal), vessel (on ship), rail yard, customer site, or in transit between locations.. Valid values are `depot|port|vessel|rail_yard|customer_site|in_transit`',
    `disposal_date` DATE COMMENT 'Date the container was disposed of (sold, scrapped, or otherwise removed from company ownership). Null if still owned. Used for asset lifecycle closure and financial reconciliation.',
    `food_grade_certified` BOOLEAN COMMENT 'Indicates whether the container is certified for transporting food products, meeting hygiene and contamination prevention standards. True if food-grade certified, false otherwise.',
    `gps_enabled` BOOLEAN COMMENT 'Indicates whether the container is equipped with GPS tracking device for real-time location monitoring. True if GPS-enabled, false otherwise.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the container is certified to carry hazardous materials (dangerous goods) per IMDG Code and ICAO Technical Instructions. True if certified, false otherwise.',
    `height_ft` DECIMAL(18,2) COMMENT 'External height of the container in feet. Standard height is 8.5 feet; high-cube containers are 9.5 feet. Determines stacking compatibility and clearance requirements.',
    `internal_volume_cbm` DECIMAL(18,2) COMMENT 'Internal cargo capacity of the container in cubic meters (CBM). Used for volumetric load planning and dimensional weight calculations.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the container. Inspections verify structural integrity, door seals, flooring, and compliance with safety standards.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance or repair work performed on the container. Tracks maintenance history and informs future service intervals.',
    `last_movement_date` TIMESTAMP COMMENT 'Timestamp of the most recent movement or position update for the container. Used for tracking, dwell time calculation, and real-time visibility.',
    `lease_agreement_reference` STRING COMMENT 'Reference number or identifier of the lease agreement if the container is leased. Links to contract terms, lessor details, and financial obligations. Null for owned containers.',
    `length_ft` STRING COMMENT 'External length of the container in feet. Standard sizes are 10, 20, 40, 45, 48, or 53 feet. Critical for transport planning, stacking, and terminal slot allocation.',
    `manufacture_date` DATE COMMENT 'Date the container was manufactured. Used to calculate asset age, depreciation, and remaining useful life for maintenance and replacement planning.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the container. Used for quality tracking, warranty claims, and supplier performance analysis.',
    `max_gross_weight_kg` DECIMAL(18,2) COMMENT 'Maximum permissible combined weight of the container and its cargo in kilograms. Enforced for safety, regulatory compliance (SOLAS VGM), and transport mode restrictions.',
    `max_payload_kg` DECIMAL(18,2) COMMENT 'Maximum cargo weight the container can carry, calculated as max gross weight minus tare weight. Used for load planning and customer quoting.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory inspection. Used for preventive maintenance planning and compliance tracking.',
    `owner_code` STRING COMMENT 'Four-letter code identifying the container owner or operator, as registered with the Bureau International des Containers (BIC). First three letters identify the owner; fourth letter is the equipment category (U for freight container).. Valid values are `^[A-Z]{4}$`',
    `ownership_type` STRING COMMENT 'Indicates whether the container is owned by the carrier, leased from a lessor, owned by a customer (SOC - Shipper Owned Container), or part of a shared pool arrangement. Impacts cost allocation, maintenance responsibility, and repositioning strategy.. Valid values are `owned|leased|customer_owned|pool`',
    `reefer_capable` BOOLEAN COMMENT 'Indicates whether the container has refrigeration capability for temperature-controlled cargo. True for reefer containers, false for dry and other non-refrigerated types.',
    `retirement_date` DATE COMMENT 'Date the container was retired from active service. Null if the container is still in service. Used for fleet lifecycle management and disposal tracking.',
    `rfid_tag_code` STRING COMMENT 'Unique identifier of the RFID tag attached to the container for automated tracking at gates, terminals, and checkpoints. Null if container is not RFID-tagged.',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'Empty weight of the container in kilograms, excluding cargo. Used to calculate net cargo weight and verify compliance with gross weight limits.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature the container can maintain in Celsius. Applicable only to refrigerated (reefer) containers. Null for non-reefer units.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature the container can maintain in Celsius. Applicable only to refrigerated (reefer) containers. Null for non-reefer units.',
    `teu_size` DECIMAL(18,2) COMMENT 'Container size expressed in TEU (Twenty-foot Equivalent Unit). Standard values: 1.0 for 20ft, 2.0 for 40ft, 2.25 for 45ft. Used for capacity planning and vessel/terminal utilization calculations.',
    `total_distance_km` DECIMAL(18,2) COMMENT 'Cumulative distance the container has traveled in kilometers since acquisition. Used for wear analysis, maintenance scheduling, and asset performance evaluation.',
    `total_trips_completed` STRING COMMENT 'Cumulative count of completed shipment trips (loaded movements) the container has performed since acquisition. Used for utilization analysis and lifecycle tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this container unit record was last modified. Used for audit trail, change tracking, and data freshness monitoring.',
    `width_ft` DECIMAL(18,2) COMMENT 'External width of the container in feet. Standard width is 8.0 feet; high-cube and specialized containers may be 8.5 feet.',
    CONSTRAINT pk_container_unit PRIMARY KEY(`container_unit_id`)
) COMMENT 'Master record for intermodal containers and unit load devices (ULDs) managed within the fleet. Tracks container number (ISO 6346), TEU size classification (20ft, 40ft, 45ft), container type (dry, reefer, open-top, flat-rack, tank), tare weight, max gross weight, CSC certification expiry, current location (port/depot/vessel), availability status, lease agreement reference, and last inspection date. Distinct from transport_asset as containers are cargo-carrying units with their own ISO standards and lifecycle separate from traction units.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` (
    `asset_assignment_id` BIGINT COMMENT 'Unique identifier for the asset assignment record. Primary key for the asset assignment transaction.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Asset assignments execute contracted service commitments. Operations teams validate assignment compliance with customer/carrier agreements for rate validation, SLA tracking, and billing reconciliation',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each asset assignment incurs direct costs (fuel, tolls, driver labor) that must be allocated to a cost center for activity-based costing, route profitability analysis, and operational budget control.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Asset assignments frequently use external carriers for line-haul or last-mile segments. Carrier selection, performance tracking, cost allocation, and SLA compliance depend on this link. Essential for ',
    `charge_event_id` BIGINT COMMENT 'Foreign key linking to billing.charge_event. Business justification: Asset assignments are primary service delivery events generating billable charges in logistics. Real business process: shipment-based charge generation. Enables linking operational assignments to bill',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Asset assignments (trips/jobs) involving cross-border freight require customs declarations. Links operational dispatch to regulatory compliance, supports driver briefings on customs requirements, and ',
    `depot_id` BIGINT COMMENT 'Reference to the depot, terminal, or facility where the assignment is scheduled to end. The ending location for the asset assignment. Null for open-ended assignments such as depot standby. Links to warehouse or facility master data.',
    `driver_profile_id` BIGINT COMMENT 'Reference to the driver or crew member assigned to operate the asset during this assignment. Null for uncrewed assignments such as container assignments or depot standby. Links to workforce driver master data.',
    `freight_order_id` BIGINT COMMENT 'Reference to the TMS freight order that this asset is assigned to execute. Null for non-route assignments such as depot standby or maintenance hold. Enables TMS-to-fleet reconciliation.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Asset assignments (trips/jobs) generate billable services that result in customer invoices. Real business process: trip-based billing for transport services. Enables linking completed assignments to t',
    `origin_depot_id` BIGINT COMMENT 'Reference to the depot, terminal, or facility where the assignment originates. The starting location for the asset assignment. Links to warehouse or facility master data.',
    `plan_id` BIGINT COMMENT 'Reference to the planned route that the asset is assigned to execute. Applicable for route execution assignments. Links to route master data for origin, destination, and waypoints.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that created this assignment record. Used for audit trail and accountability. Links to user management or workforce systems.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: High-risk asset assignments (hazmat transport, cross-border operations, oversized loads) require pre-assignment risk assessments for route approval, driver qualification verification, and emergency re',
    `transport_asset_id` BIGINT COMMENT 'Reference to the transport asset (vehicle, aircraft, vessel, container) being assigned. Links to the fleet asset master data.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Asset assignments reference shipping documents (BOL, AWB), route plans, and assignment authorizations. Essential for linking fleet operations to shipment documentation and proof of asset utilization.',
    `trip_id` BIGINT COMMENT 'Foreign key linking to fleet.trip. Business justification: Asset assignments represent the allocation of a transport asset to an operational run. Linking to trip provides the trip-level context. fleet_driver_assignment already has trip_id; asset_assignment sh',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the asset assignment ended. Captured from GPS telematics, RFID tag reads, or manual check-out. Used for On-Time In-Full (OTIF) performance measurement and variance analysis against planned end. Null for in-progress assignments.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the asset assignment began. Captured from GPS telematics, RFID tag reads, or manual check-in. Used for On-Time Departure (OTD) performance measurement and variance analysis against planned start.',
    `assignment_cost_amount` DECIMAL(18,2) COMMENT 'Total operational cost incurred for this assignment including fuel, driver wages, tolls, and maintenance. Used for OPEX tracking, profitability analysis, and cost-per-kilometer KPI calculation. Captured in the companys base currency.',
    `assignment_duration_hours` DECIMAL(18,2) COMMENT 'Planned or actual duration of the assignment in hours. Used for fleet utilization KPI calculation, driver hours-of-service compliance, and asset availability forecasting. Calculated from start and end datetimes.',
    `assignment_number` STRING COMMENT 'Business-readable unique identifier for the assignment, typically generated by the Transportation Management System (TMS). Used for operational tracking and communication.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the assignment. Planned indicates scheduled but not confirmed, confirmed for approved assignments, in progress for active assignments, completed for finished assignments, cancelled for voided assignments, suspended for temporarily halted assignments, failed for assignments that could not be completed. [ENUM-REF-CANDIDATE: planned|confirmed|in_progress|completed|cancelled|suspended|failed — 7 candidates stripped; promote to reference product]',
    `assignment_type` STRING COMMENT 'Classification of the assignment purpose. Route execution indicates active transport duty, depot standby for available assets, charter for third-party rental, maintenance hold for scheduled service, repair for unscheduled fixes, inspection for regulatory checks, lease out for external rental, reserve for contingency, training for crew qualification, emergency deployment for urgent needs. [ENUM-REF-CANDIDATE: route_execution|depot_standby|charter|maintenance_hold|repair|inspection|lease_out|reserve|training|emergency_deployment — 10 candidates stripped; promote to reference product]',
    `cargo_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of cargo loaded on the asset during this assignment in cubic meters. Used for capacity utilization analysis and dimensional weight (DIM weight) calculations. Null for non-cargo assignments.',
    `cargo_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of cargo loaded on the asset during this assignment in kilograms. Used for load optimization, weight compliance checks, and fuel consumption correlation analysis. Null for non-cargo assignments.',
    `co2_emissions_kg` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions in kilograms of CO2 equivalent produced during this assignment. Calculated from fuel consumption using emission factors. Used for sustainability reporting, EU Emissions Trading System (EU ETS) compliance, and Carbon Offsetting and Reduction Scheme for International Aviation (CORSIA) reporting.',
    `compliance_check_status` STRING COMMENT 'Status of regulatory compliance checks for this assignment including DOT inspections, ICAO airworthiness, IMO safety checks, and customs pre-clearance. Passed indicates all checks cleared, failed for violations, pending for in-progress checks, not required for exempt assignments, waived for authorized exceptions.. Valid values are `passed|failed|pending|not_required|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this assignment record was first created in the system. Used for audit trail, data lineage tracking, and record lifecycle management. Automatically populated by the system.',
    `cross_border_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the assignment involves crossing international borders requiring customs clearance and trade compliance. True for international assignments, false for domestic.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the assignment cost amount. Typically the companys base operating currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delay_duration_minutes` STRING COMMENT 'Total duration of delays in minutes. Calculated as the difference between planned and actual completion times. Used for Service Level Agreement (SLA) compliance measurement and root cause analysis. Zero if no delay occurred.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for any delay in completing the assignment. Weather for adverse conditions, traffic for congestion, mechanical for breakdowns, customs for clearance delays, loading delay for shipper delays, driver unavailable for crew issues, route change for diversions, accident for incidents, other for miscellaneous, none if no delay occurred. [ENUM-REF-CANDIDATE: weather|traffic|mechanical|customs|loading_delay|driver_unavailable|route_change|accident|other|none — 10 candidates stripped; promote to reference product]',
    `distance_km` DECIMAL(18,2) COMMENT 'Planned or actual distance covered during the assignment in kilometers. Used for fuel consumption analysis, maintenance scheduling based on mileage, and route optimization. Captured from GPS telematics or route planning systems.',
    `fuel_consumed_liters` DECIMAL(18,2) COMMENT 'Actual fuel consumed during the assignment in liters. Captured from vehicle telematics, fuel card transactions, or manual fuel logs. Used for OPEX tracking, Carbon Dioxide Equivalent (CO2e) emissions calculation, and fuel efficiency KPIs.',
    `gps_tracking_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether real-time GPS tracking is enabled for this assignment. True if telematics data is being captured, false otherwise. Used for real-time visibility and predictive ETA calculation.',
    `hazmat_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the assignment involves transport of hazardous materials requiring special handling, placarding, and regulatory compliance. True if hazmat cargo is present, false otherwise.',
    `incident_reported_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether any incident (accident, breakdown, delay, cargo damage, security breach) was reported during this assignment. True if an incident occurred, false otherwise. Links to incident or claims management systems.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection performed on the asset prior to or during this assignment. Used for compliance tracking and maintenance scheduling. Null if no inspection has been performed.',
    `load_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the assets maximum capacity utilized during this assignment. Calculated as (actual cargo weight or volume / maximum capacity) * 100. Key performance indicator for fleet efficiency and load optimization.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this assignment record was last modified. Used for audit trail, change tracking, and data synchronization. Automatically updated by the system on any change.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or comments related to the assignment. Used for communication between dispatchers, drivers, and operations teams. May include handling instructions, customer requirements, or incident details.',
    `planned_end_datetime` TIMESTAMP COMMENT 'Scheduled date and time when the asset assignment is planned to end. Used for capacity planning and turnaround time calculation. Corresponds to Estimated Time of Arrival (ETA) for route assignments. Null for open-ended assignments.',
    `planned_start_datetime` TIMESTAMP COMMENT 'Scheduled date and time when the asset assignment is planned to begin. Used for capacity planning and resource scheduling. Corresponds to Estimated Time of Departure (ETD) for route assignments.',
    `priority_level` STRING COMMENT 'Business priority of the assignment. Critical for time-sensitive or high-value shipments, high for express delivery, normal for standard service, low for deferred or backhaul assignments. Influences resource allocation and scheduling decisions.. Valid values are `critical|high|normal|low`',
    `rfid_tag_code` STRING COMMENT 'Unique identifier of the RFID tag attached to the asset for automated tracking and identification. Used for gate-in/gate-out automation, asset location tracking, and inventory management. Null if RFID is not used.',
    `seal_number` STRING COMMENT 'Unique identifier of the security seal applied to the asset (container, trailer, or cargo compartment) to ensure cargo integrity and prevent tampering. Required for customs compliance and high-security shipments. Null if no seal is applied.',
    `service_level` STRING COMMENT 'Service level agreement (SLA) tier for this assignment. Express for next-day or same-day delivery, standard for 2-5 day delivery, economy for 5+ day delivery, charter for exclusive use, dedicated for contract logistics. Determines performance targets and pricing.. Valid values are `express|standard|economy|charter|dedicated`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that originated this assignment. SAP TM for SAP Transportation Management, ORACLE TMS for Oracle Transportation Management System, MANHATTAN WMS for warehouse-initiated assignments, FOURKITES for visibility platform assignments, MANUAL for manually created assignments, OTHER for miscellaneous sources. Used for data lineage and system integration tracking.. Valid values are `SAP_TM|ORACLE_TMS|MANHATTAN_WMS|FOURKITES|MANUAL|OTHER`',
    `temperature_controlled_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the assignment requires temperature-controlled transport (refrigerated or heated). True for cold chain or temperature-sensitive cargo, false otherwise.',
    CONSTRAINT pk_asset_assignment PRIMARY KEY(`asset_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a transport asset (vehicle, aircraft, vessel) to a specific route, freight order, driver, or operational depot for a defined period. Tracks assignment type (route execution, depot standby, charter, maintenance hold), assigned driver/crew reference, origin depot, destination, planned start/end datetime, actual start/end datetime, TMS freight order reference, and assignment status. Enables fleet utilization tracking and TMS-to-fleet reconciliation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` (
    `telematics_event_id` BIGINT COMMENT 'Unique identifier for the telematics event record. Primary key for the telematics event stream.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: When assets are operated by contracted carriers, telematics events must track carrier for liability determination, performance monitoring (speed, idling, route adherence), and billing reconciliation. ',
    `consignment_id` BIGINT COMMENT 'Identifier of the active shipment being transported by the asset at the time of the event. Links telemetry to freight orders for predictive ETA and exception management.',
    `driver_profile_id` BIGINT COMMENT 'Identifier of the driver assigned to the asset at the time of the event. Used for driver behavior scoring, hours-of-service compliance, and workforce analytics.',
    `geofence_zone_id` BIGINT COMMENT 'Identifier of the geofence zone associated with entry/exit events. References predefined geographic boundaries such as customer sites, terminals, or restricted zones.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Telematics events capture GPS positions that map to network nodes (depots, hubs, terminals) for location-based analytics, geofence validation, and milestone tracking in real-time visibility systems.',
    `plan_id` BIGINT COMMENT 'Identifier of the planned route being executed by the asset. Used for route deviation detection and on-time delivery performance analysis.',
    `transport_asset_id` BIGINT COMMENT 'Identifier of the fleet asset (vehicle, aircraft, vessel, container) from which this telemetry event was captured.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Critical telematics events (temperature excursions, security breaches, geofence violations) trigger exception reports and compliance documents. Required for cold chain compliance, security incident do',
    `altitude_m` DECIMAL(18,2) COMMENT 'Altitude of the asset above sea level in meters at the time of the event. Particularly relevant for aircraft and mountainous terrain routing.',
    `battery_voltage` DECIMAL(18,2) COMMENT 'Voltage level of the asset battery in volts. Used for predictive maintenance and device health monitoring.',
    `data_quality_flag` STRING COMMENT 'Indicator of the data quality and reliability of the event. Suspect or invalid flags may indicate GPS signal loss, sensor malfunction, or data transmission errors.. Valid values are `valid|suspect|invalid|interpolated`',
    `device_code` STRING COMMENT 'Unique identifier of the onboard telematics device (GPS/IoT unit) that generated this event. May be IMEI, MAC address, or vendor-specific serial number.',
    `diagnostic_trouble_code` STRING COMMENT 'Standardized engine diagnostic trouble code reported by the onboard diagnostics system. Used for predictive maintenance and fleet health monitoring.',
    `engine_hours` DECIMAL(18,2) COMMENT 'Cumulative engine operating hours as reported by the asset. Used for maintenance scheduling based on usage rather than calendar time.',
    `engine_rpm` STRING COMMENT 'Engine speed in revolutions per minute at the time of the event. Used for fuel efficiency analysis and engine health monitoring.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the telematics event was captured by the device, in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Represents the real-world observation time, distinct from ingestion time.',
    `event_type` STRING COMMENT 'Classification of the telematics event indicating the nature of the observation or trigger condition. [ENUM-REF-CANDIDATE: gps_position|ignition_on|ignition_off|harsh_braking|harsh_acceleration|geofence_entry|geofence_exit|temperature_alert|fuel_level|engine_diagnostic — 10 candidates stripped; promote to reference product]',
    `fuel_level_percent` DECIMAL(18,2) COMMENT 'Remaining fuel level as a percentage of tank capacity (0-100). Used for fuel consumption tracking, refueling planning, and OPEX analysis.',
    `geofence_event_type` STRING COMMENT 'Indicates whether the event represents entry into or exit from a geofence zone. Used for automated proof of delivery and dwell time analysis.. Valid values are `entry|exit`',
    `gps_accuracy_m` DECIMAL(18,2) COMMENT 'Estimated horizontal accuracy of the GPS position in meters. Lower values indicate higher precision.',
    `gps_satellite_count` STRING COMMENT 'Number of GPS satellites used to calculate the position fix. Higher counts indicate better position accuracy.',
    `harsh_acceleration_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) that a harsh acceleration event was detected based on acceleration threshold. Used for driver behavior scoring and fuel efficiency analysis.',
    `harsh_braking_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) that a harsh braking event was detected based on deceleration threshold. Used for driver behavior scoring and safety analysis.',
    `heading_degrees` DECIMAL(18,2) COMMENT 'Compass heading of the asset in degrees (0-360), where 0/360 is North, 90 is East, 180 is South, and 270 is West. Used for route deviation detection.',
    `ignition_state` STRING COMMENT 'Current state of the asset ignition system. Used to distinguish active operation from idle or parked states.. Valid values are `on|off|accessory`',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Date and time when the event was received and ingested into the FourKites platform, in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used to calculate transmission latency and data freshness.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the asset at the time of the event, in decimal degrees. Positive values represent North, negative values represent South.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the asset at the time of the event, in decimal degrees. Positive values represent East, negative values represent West.',
    `network_type` STRING COMMENT 'Type of network connection used by the telematics device to transmit the event. Impacts data latency and coverage in remote areas.. Valid values are `cellular|satellite|wifi`',
    `odometer_km` DECIMAL(18,2) COMMENT 'Cumulative distance traveled by the asset in kilometers as reported by the onboard odometer. Used for maintenance scheduling and asset utilization tracking.',
    `payload_json` STRING COMMENT 'Raw JSON payload from the telematics device containing additional vendor-specific sensor data and metadata not parsed into structured fields. Retained for audit and advanced analytics.',
    `signal_strength` STRING COMMENT 'Network signal strength indicator (typically in dBm or percentage). Used to assess connectivity quality and predict data transmission reliability.',
    `source_system` STRING COMMENT 'Name or identifier of the source telematics platform or vendor system that originated the event (e.g., FourKites, Geotab, Samsara). Used for multi-vendor fleet integration.',
    `speed_kmh` DECIMAL(18,2) COMMENT 'Instantaneous speed of the asset in kilometers per hour at the time of the event. Used for route optimization, ETA prediction, and driver behavior scoring.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature reading in degrees Celsius from onboard sensor. Critical for refrigerated (reefer) units transporting temperature-sensitive cargo such as pharmaceuticals or perishables.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature setting for refrigerated units in degrees Celsius. Used to detect temperature excursions and compliance violations.',
    CONSTRAINT pk_telematics_event PRIMARY KEY(`telematics_event_id`)
) COMMENT 'High-frequency IoT/GPS telemetry event records streamed from onboard telematics devices fitted to fleet assets. Captures asset ID, device ID, event timestamp (yyyy-MM-ddTHH:mm:ss.SSSXXX), GPS coordinates (latitude, longitude, altitude), speed, heading, odometer reading, engine RPM, fuel level, ignition state, harsh braking/acceleration flags, geofence entry/exit events, temperature sensor readings (for reefer units), and raw IoT payload reference. Sourced from FourKites real-time visibility platform. Enables predictive ETA, route deviation detection, and driver behavior scoring.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` (
    `driver_profile_id` BIGINT COMMENT 'Unique identifier for the driver profile record. Primary key.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Drivers (especially owner-operators or contractors) may be registered as customs trade parties with their own importer/exporter numbers, C-TPAT certifications, or AEO status. Supports driver-level cus',
    `driver_licence_type_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_licence_type. Business justification: driver_profile currently has license_class (STRING) storing the licence category/class as free text. The driver_licence_type reference table provides the authoritative taxonomy of licence types with r',
    `employee_id` BIGINT COMMENT 'Employee identifier from Workday HCM system. Links driver profile to core HR record for payroll, benefits, and workforce planning. Null for contractor drivers.',
    `depot_id` BIGINT COMMENT 'FK to fleet.fleet_depot',
    `supplier_id` BIGINT COMMENT 'Contractor identifier for third-party or independent drivers not on company payroll. Null for employee drivers.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Drivers require license documents, medical certificates, training records, hazmat endorsements, and background check reports for regulatory compliance. Essential for driver qualification file (DQF) ma',
    `assignment_status` STRING COMMENT 'Current operational status of the driver. Active: available for route assignment. Inactive: not currently assigned. On Leave: temporary absence. Suspended: compliance or disciplinary hold. Terminated: no longer employed or contracted.. Valid values are `active|inactive|on_leave|suspended|terminated`',
    `background_check_date` DATE COMMENT 'Date the most recent background check was completed for the driver. Required for C-TPAT, AEO, and other security programs.',
    `background_check_status` STRING COMMENT 'Result status of the most recent background check. Cleared: passed all checks. Pending: in progress. Failed: did not meet security criteria. Expired: check is outdated and must be renewed.. Valid values are `cleared|pending|failed|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this driver profile record was first created in the system.',
    `data_source_system` STRING COMMENT 'Name of the source system from which this driver profile record originated (e.g., Workday HCM, SAP TM, internal fleet management system).',
    `disciplinary_flag` BOOLEAN COMMENT 'Indicates whether the driver has active disciplinary actions or compliance violations on record. True if disciplinary action exists, False otherwise. Used for assignment restrictions and compliance monitoring.',
    `driver_name` STRING COMMENT 'Full legal name of the driver as it appears on their commercial driver license or operating permit.',
    `drug_test_date` DATE COMMENT 'Date of the most recent drug and alcohol screening test. Required for DOT-regulated drivers in the United States.',
    `drug_test_result` STRING COMMENT 'Result of the most recent drug and alcohol screening test. Negative: passed. Positive: failed. Pending: awaiting results. Refused: driver refused to test.. Valid values are `negative|positive|pending|refused`',
    `email_address` STRING COMMENT 'Email address for driver communications, electronic proof of delivery (ePOD) notifications, and system access credentials.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the drivers designated emergency contact person.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the drivers designated emergency contact person.',
    `employment_type` STRING COMMENT 'Classification of the drivers employment relationship with Transport Shipping. Determines payroll, benefits, liability, and compliance obligations.. Valid values are `full_time_employee|part_time_employee|contractor|owner_operator|temporary`',
    `gps_device_code` STRING COMMENT 'Identifier of the GPS telematics device currently assigned to the driver for real-time location tracking and route monitoring. Null if no device assigned.',
    `hire_date` DATE COMMENT 'Date the driver was hired or contracted by Transport Shipping. Used for tenure calculation, anniversary tracking, and retention analytics.',
    `language_proficiency` STRING COMMENT 'Comma-separated list of languages the driver is proficient in, using ISO 639-1 two-letter codes (e.g., EN, ES, FR, DE). Used for customer-facing delivery roles and cross-border operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this driver profile record was last updated.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review for the driver.',
    `license_categories` STRING COMMENT 'Comma-separated list of vehicle categories or endorsements the driver is authorized to operate (e.g., H-Hazmat, N-Tank, P-Passenger, T-Double/Triple Trailers for road; type ratings for aviation; vessel types for maritime).',
    `license_expiry_date` DATE COMMENT 'Date the driver license expires and must be renewed. Critical for compliance monitoring and driver assignment eligibility.',
    `license_issue_date` DATE COMMENT 'Date the current driver license was issued by the licensing authority.',
    `license_issuing_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the authority that issued the driver license.. Valid values are `^[A-Z]{3}$`',
    `license_issuing_state` STRING COMMENT 'State, province, or regional authority within the issuing country that issued the driver license. Applicable for federal jurisdictions like USA, Canada, Australia.',
    `license_number` STRING COMMENT 'Commercial driver license (CDL) or equivalent operating license number issued by the licensing authority. Required for all drivers operating commercial vehicles.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the driver based on on-time delivery (OTD), safety record, customer feedback, and compliance adherence.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `primary_contact_phone` STRING COMMENT 'Primary mobile or telephone number for reaching the driver for dispatch, route updates, and emergency contact.',
    `rfid_tag_code` STRING COMMENT 'Identifier of the RFID tag assigned to the driver for facility access control, time tracking, and asset assignment. Null if no tag assigned.',
    `termination_date` DATE COMMENT 'Date the drivers employment or contract was terminated. Null for active drivers.',
    `vehicle_type_authorization` STRING COMMENT 'Comma-separated list of vehicle types the driver is authorized and trained to operate (e.g., tractor_trailer, straight_truck, cargo_van, aircraft, vessel). Derived from license class, endorsements, and internal training records.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of professional driving experience in commercial transport operations. Used for risk assessment, insurance rating, and assignment to high-value or complex routes.',
    CONSTRAINT pk_driver_profile PRIMARY KEY(`driver_profile_id`)
) COMMENT 'Master record for all drivers and vehicle operators employed or contracted by Transport Shipping. Captures driver identity (employee/contractor ID from Workday HCM), license number, license class and categories, license issuing country, license expiry date, DOT medical certificate expiry, hazmat endorsement flag, IATA dangerous goods certification, years of experience, current assignment status, home depot, language proficiency, and disciplinary flag. Distinct from the workforce domain employee record — this is the fleet-specific operational driver profile with licensing and compliance attributes not held in HCM.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` (
    `fleet_driver_assignment_id` BIGINT COMMENT 'Unique identifier for the driver assignment record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Driver labor costs and assignment expenses must be allocated to cost centers for operational budget control; removes denormalized cost_center_code. Role prefix distinguishes from depot cost center FK.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Driver assignments often involve contracted carrier drivers (owner-operators, subcontractors). Tracking carrier affiliation is essential for compliance (HOS, licensing), insurance coverage verificatio',
    `charge_event_id` BIGINT COMMENT 'Foreign key linking to billing.charge_event. Business justification: Driver assignments represent service delivery events that trigger billing charge generation. Real business process: service event-based billing trigger. Enables tracking which driver assignment genera',
    `depot_id` BIGINT COMMENT 'Reference to the ending location for this driver assignment (depot, warehouse, terminal, customer site). Links to the location master.',
    `fatigue_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.fatigue_risk_assessment. Business justification: Driver assignments exceeding HOS thresholds or involving long-haul routes trigger fatigue risk assessments before dispatch approval. Real-world operational safety decision: assessment outcome determin',
    `plan_id` BIGINT COMMENT 'Reference to the planned route for this assignment. Links to the route master.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the transport asset (vehicle, truck, aircraft, vessel) assigned for this run. Links to the fleet asset master.',
    `primary_fleet_depot_id` BIGINT COMMENT 'Reference to the starting location for this driver assignment (depot, warehouse, terminal). Links to the location master.',
    `driver_profile_id` BIGINT COMMENT 'Reference to the driver assigned to this transport run. Links to the driver master profile.',
    `employee_id` BIGINT COMMENT 'Reference to the dispatcher or operations staff member who assigned this driver to the trip. Links to the employee master.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Driver assignments execute service commitments under customer/carrier agreements. Operations verifies driver qualifications (certifications, endorsements, background checks) match contract requirement',
    `shift_schedule_id` BIGINT COMMENT 'Reference to the operational shift or duty period that this assignment belongs to. Links to the shift schedule master.',
    `tertiary_fleet_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the system user who last modified this driver assignment record. Used for audit trail and change accountability.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Driver assignments reference trip manifests, delivery receipts, authorization documents, and route plans. Required for proof of delivery, driver authorization verification, and trip documentation.',
    `trip_id` BIGINT COMMENT 'Reference to the operational trip or run that this driver assignment supports. Links to the trip/run master record.',
    `actual_departure_datetime` TIMESTAMP COMMENT 'Actual date and time when the driver departed with the assigned asset. Captured from GPS telematics or driver check-in. Used for on-time departure KPI tracking.',
    `actual_return_datetime` TIMESTAMP COMMENT 'Actual date and time when the driver returned and completed the assignment. Captured from GPS telematics or driver check-out. Used for on-time completion KPI tracking.',
    `assignment_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the assignment in hours, calculated from actual departure to actual return. Used for driver utilization reporting and payroll.',
    `assignment_number` STRING COMMENT 'Business-readable unique identifier for the driver assignment, used for operational tracking and communication.',
    `assignment_outcome` STRING COMMENT 'Final outcome status of the driver assignment. Captures whether the assignment was completed successfully, cancelled, or suspended, and the reason. Used for driver performance evaluation and operational analytics. [ENUM-REF-CANDIDATE: completed_on_time|completed_late|cancelled_by_ops|cancelled_by_driver|suspended_hos|suspended_mechanical|no_show — 7 candidates stripped; promote to reference product]',
    `assignment_priority` STRING COMMENT 'Business priority level for this driver assignment. Critical for time-sensitive or high-value shipments, high for expedited service, normal for standard operations, low for non-urgent tasks.. Valid values are `critical|high|normal|low`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the driver assignment. Tracks progression from scheduling through completion or cancellation.. Valid values are `scheduled|dispatched|in_progress|completed|cancelled|suspended`',
    `assignment_type` STRING COMMENT 'Type of transport assignment. FTL (Full Truckload) haul, LTL (Less Than Truckload) multi-drop, last-mile delivery, linehaul long-distance, shuttle short-distance, relay driver handoff, or dedicated contract route. [ENUM-REF-CANDIDATE: FTL|LTL|last_mile|linehaul|shuttle|relay|dedicated — 7 candidates stripped; promote to reference product]',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the assignment was cancelled or suspended. Populated when assignment_outcome indicates cancellation or suspension.',
    `co2_emissions_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide equivalent emissions in kilograms for this assignment, calculated from fuel consumption. Used for sustainability reporting and carbon footprint tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this driver assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_feedback_score` STRING COMMENT 'Customer satisfaction score for this assignment, typically on a scale of 1-5. Captured from customer surveys or delivery feedback. Used for service quality monitoring.',
    `dispatch_datetime` TIMESTAMP COMMENT 'Date and time when the assignment was dispatched to the driver by the operations team. Marks the transition from scheduled to active status.',
    `distance_actual_km` DECIMAL(18,2) COMMENT 'Actual total distance traveled during this assignment in kilometers, captured from GPS telematics. Used for fuel consumption analysis and route optimization.',
    `distance_planned_km` DECIMAL(18,2) COMMENT 'Planned total distance for this assignment in kilometers, based on route planning. Used for fuel budgeting and driver scheduling.',
    `driver_rating` STRING COMMENT 'Performance rating assigned to the driver for this assignment, typically on a scale of 1-5. Based on factors such as on-time performance, fuel efficiency, safety, and customer feedback. Used for driver performance management.',
    `driving_hours` DECIMAL(18,2) COMMENT 'Total hours spent actively driving during this assignment. Captured from GPS telematics or electronic logging device (ELD). Used for HOS compliance and driver productivity analysis.',
    `fuel_consumed_liters` DECIMAL(18,2) COMMENT 'Total fuel consumed during this assignment in liters, captured from vehicle telematics or fuel card transactions. Used for fuel efficiency KPI tracking and cost allocation.',
    `hos_counter_at_end` DECIMAL(18,2) COMMENT 'Cumulative hours of service logged by the driver at the end of this assignment. Used for DOT hours-of-service compliance tracking and fatigue management.',
    `hos_counter_at_start` DECIMAL(18,2) COMMENT 'Cumulative hours of service logged by the driver at the start of this assignment. Used for DOT hours-of-service compliance tracking and fatigue management.',
    `hos_violation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment resulted in a DOT hours-of-service violation. True if violation occurred, False otherwise. Used for compliance monitoring and driver safety management.',
    `hos_violation_type` STRING COMMENT 'Description of the type of HOS violation that occurred (e.g., exceeded 11-hour driving limit, insufficient rest break, exceeded 14-hour on-duty limit). Populated when hos_violation_flag is True.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this driver assignment record was last modified in the system. Used for audit trail and change tracking.',
    `planned_departure_datetime` TIMESTAMP COMMENT 'Scheduled date and time when the driver is expected to depart with the assigned asset. Used for route planning and resource scheduling.',
    `planned_return_datetime` TIMESTAMP COMMENT 'Scheduled date and time when the driver is expected to return and complete the assignment. Used for shift planning and asset availability forecasting.',
    `rest_break_hours` DECIMAL(18,2) COMMENT 'Total hours spent on mandatory rest breaks during this assignment. Used for DOT compliance verification and fatigue management.',
    `safety_incident_description` STRING COMMENT 'Free-text description of the safety incident that occurred during this assignment. Populated when safety_incident_flag is True.',
    `safety_incident_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a safety incident (accident, near-miss, traffic violation) occurred during this assignment. True if incident occurred, False otherwise. Used for driver safety scoring and risk management.',
    `special_instructions` STRING COMMENT 'Free-text field for operational notes, special handling requirements, or driver-specific instructions for this assignment (e.g., hazmat handling, customer access codes, delivery restrictions).',
    CONSTRAINT pk_fleet_driver_assignment PRIMARY KEY(`fleet_driver_assignment_id`)
) COMMENT 'Transactional record linking a driver to a specific transport asset and operational run for a defined shift or trip. Captures driver profile reference, asset reference, trip/run reference, planned departure datetime, actual departure datetime, planned return datetime, actual return datetime, assignment type (FTL haul, LTL multi-drop, last-mile, linehaul), hours of service (HOS) counter at assignment start, and assignment outcome status. Supports DOT hours-of-service compliance tracking and driver utilization reporting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` (
    `maintenance_order_id` BIGINT COMMENT 'Unique identifier for the maintenance order record. Primary key for the maintenance order entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Maintenance work may be performed under warranty or vendor service agreements. Finance tracks which maintenance costs are recoverable under contracts vs. operational expense. Critical for cost allocat',
    `carrier_payable_id` BIGINT COMMENT 'Foreign key linking to billing.carrier_payable. Business justification: External maintenance performed by carrier-vendors is settled via carrier payables. Real business process: vendor maintenance cost settlement. Enables reconciling maintenance orders to carrier invoices',
    `depot_id` BIGINT COMMENT 'Reference to the internal workshop or facility location where the maintenance work is being performed, applicable when maintenance_provider_type is internal_workshop.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Maintenance costs under service contracts or lease agreements are invoiced to customers. Real business process: maintenance cost recovery billing. Enables tracking which customer invoice covers specif',
    `maintenance_schedule_id` BIGINT COMMENT 'Foreign key linking to fleet.maintenance_schedule. Business justification: Maintenance orders can be auto-generated from maintenance schedules (maintenance_schedule has auto_generate_order_flag). This FK tracks which preventive maintenance schedule triggered the work order. ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_permit. Business justification: Maintenance activities involving hot work (welding, cutting), confined space entry (tank cleaning), or lockout/tagout require safety permits before work authorization. Real-world compliance workflow: ',
    `employee_id` BIGINT COMMENT 'Reference to the primary technician or mechanic assigned to perform the maintenance work, used for accountability, quality tracking, and workforce management.',
    `quaternary_maintenance_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this maintenance order record, used for accountability and audit purposes.',
    `supplier_id` BIGINT COMMENT 'Reference to the external vendor or service provider performing the maintenance work, applicable when maintenance_provider_type is external_vendor, oem_service_center, or authorized_dealer.',
    `tertiary_maintenance_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this maintenance order record, used for accountability and audit purposes.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the fleet asset (vehicle, aircraft, vessel, container) that is the subject of this maintenance order.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Maintenance orders generate service invoices, warranty claim documents, and inspection certificates that must be retained for audit trails and asset history. Essential for maintenance cost reconciliat',
    `waste_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_record. Business justification: Maintenance operations generate regulated waste streams (used oil, filters, batteries, parts) requiring ESG disclosure and environmental compliance tracking. Links maintenance activities to waste disp',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'The actual date and time when maintenance work was finished and the asset was released back to operational status, used for downtime calculation and SLA compliance.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when maintenance work physically commenced, used for labor tracking and performance analysis against scheduled start.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which this maintenance orders OPEX costs are allocated, used for departmental budgeting and financial reporting integration with SAP S/4HANA Finance.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this maintenance order record was first created in the database, used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this maintenance order (parts_cost, labor_cost, external_service_cost, total_maintenance_cost).. Valid values are `^[A-Z]{3}$`',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total number of hours the asset was out of service due to this maintenance activity, calculated from the time the asset was taken offline until it was returned to operational status, used for availability KPIs and operational impact analysis.',
    `engine_hours` DECIMAL(18,2) COMMENT 'Engine operating hours or flight hours of the asset at the time maintenance was performed, applicable to aircraft, vessels, and heavy equipment, used for time-based maintenance scheduling.',
    `external_service_cost` DECIMAL(18,2) COMMENT 'Cost charged by external vendors or service providers for maintenance work, applicable when maintenance is outsourced, representing third-party service fees in maintenance OPEX.',
    `fault_code` STRING COMMENT 'Standardized diagnostic trouble code or fault identifier from the assets onboard diagnostic system or maintenance taxonomy, used for root cause analysis and trend identification.. Valid values are `^[A-Z0-9]{4,10}$`',
    `fault_description` STRING COMMENT 'Detailed narrative description of the fault, defect, or maintenance requirement that triggered this work order, including symptoms, error codes, and operator observations.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting maintenance costs in the financial system, enabling integration with SAP S/4HANA Finance for OPEX tracking and financial statement preparation.. Valid values are `^[0-9]{4,10}$`',
    `inspection_certificate_number` STRING COMMENT 'Official certificate or approval number issued by the regulatory authority upon successful completion of a statutory inspection, used for compliance documentation and audit trail.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `inspection_expiry_date` DATE COMMENT 'Date when the regulatory inspection certificate expires and the asset requires re-inspection to maintain compliance and operational authorization.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total cost of labor for this maintenance order, calculated from labor hours and applicable labor rates (internal or vendor), representing the direct labor component of maintenance OPEX.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total number of labor hours expended on this maintenance order, including technician time for diagnosis, repair, testing, and documentation, used for cost calculation and productivity analysis.',
    `maintenance_category` STRING COMMENT 'Technical category of the maintenance work, indicating the system or component area being serviced (e.g., mechanical, electrical, hydraulic, structural, avionics, engine, transmission, brakes, tires, body, interior, safety systems). [ENUM-REF-CANDIDATE: mechanical|electrical|hydraulic|structural|avionics|engine|transmission|brakes|tires|body|interior|safety_systems — 12 candidates stripped; promote to reference product]',
    `maintenance_order_status` STRING COMMENT 'Current lifecycle state of the maintenance order: draft (being prepared), scheduled (approved and planned), in_progress (work underway), on_hold (temporarily suspended), completed (work finished and asset released), cancelled (order voided).. Valid values are `draft|scheduled|in_progress|on_hold|completed|cancelled`',
    `maintenance_provider_type` STRING COMMENT 'Classification of the entity performing the maintenance work: internal_workshop (company-owned facility), external_vendor (third-party service provider), oem_service_center (original equipment manufacturer facility), authorized_dealer (franchised service location).. Valid values are `internal_workshop|external_vendor|oem_service_center|authorized_dealer`',
    `maintenance_type` STRING COMMENT 'Classification of the maintenance work order by its nature: preventive (scheduled routine maintenance), corrective (repair of known defect), statutory_inspection (regulatory compliance inspection such as DOT annual inspection or ICAO airworthiness check), or breakdown (emergency unplanned repair).. Valid values are `preventive|corrective|statutory_inspection|breakdown`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this maintenance order record was last updated, used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or observations related to the maintenance order that do not fit structured fields.',
    `odometer_reading` DECIMAL(18,2) COMMENT 'Odometer or mileage reading of the asset at the time maintenance was performed, applicable to road vehicles, used for preventive maintenance scheduling and lifecycle tracking.',
    `parts_cost` DECIMAL(18,2) COMMENT 'Total cost of parts and materials consumed in this maintenance order, representing the direct material component of maintenance OPEX.',
    `parts_replaced_list` STRING COMMENT 'Comma-separated or structured list of part numbers and descriptions for components replaced during the maintenance activity, used for inventory management and warranty tracking.',
    `post_maintenance_status` STRING COMMENT 'Operational status of the asset immediately following completion of maintenance work: operational (fully serviceable), limited_service (operational with restrictions), out_of_service (not cleared for use), pending_inspection (awaiting final certification), scrapped (asset retired).. Valid values are `operational|limited_service|out_of_service|pending_inspection|scrapped`',
    `priority` STRING COMMENT 'Business priority level assigned to the maintenance order, determining urgency and resource allocation (critical for safety or operational impact, high for near-term service impact, medium for scheduled work, low for deferred maintenance).. Valid values are `critical|high|medium|low`',
    `raised_date` DATE COMMENT 'The date when the maintenance order was first created or raised in the system, representing the business event timestamp when the need for maintenance was identified.',
    `regulatory_inspection_type` STRING COMMENT 'Type of regulatory or statutory inspection performed as part of this maintenance order: dot_annual (DOT annual vehicle inspection), icao_airworthiness (ICAO airworthiness check), maritime_survey (vessel classification survey), emissions_test (environmental compliance test), safety_certification (safety system certification), none (not a regulatory inspection).. Valid values are `dot_annual|icao_airworthiness|maritime_survey|emissions_test|safety_certification|none`',
    `scheduled_completion_date` DATE COMMENT 'The planned date when maintenance work is expected to be completed and the asset returned to service, used for operational planning and customer commitments.',
    `scheduled_start_date` DATE COMMENT 'The planned date when maintenance work is scheduled to begin, used for resource planning and asset availability forecasting.',
    `total_maintenance_cost` DECIMAL(18,2) COMMENT 'Total cost of the maintenance order including parts, labor, external services, and any other direct costs, representing the complete OPEX impact of this maintenance event for financial reporting and asset lifecycle costing.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Boolean indicator whether this maintenance order is associated with a warranty claim against the asset manufacturer or component supplier, used for cost recovery tracking.',
    `warranty_claim_number` STRING COMMENT 'Reference number for the associated warranty claim submitted to the manufacturer or supplier, applicable when warranty_claim_flag is true.. Valid values are `^WC-[A-Z0-9]{8,12}$`',
    `work_order_number` STRING COMMENT 'Externally-known unique business identifier for the maintenance work order, used for tracking and reference across systems and with external vendors.. Valid values are `^WO-[A-Z0-9]{8,12}$`',
    `work_performed_description` STRING COMMENT 'Detailed narrative of the actual maintenance work performed, including procedures followed, parts replaced, adjustments made, and test results, completed upon work order closure.',
    CONSTRAINT pk_maintenance_order PRIMARY KEY(`maintenance_order_id`)
) COMMENT 'Transactional record for all planned and unplanned maintenance work orders raised against fleet assets. Captures asset reference, maintenance type (preventive, corrective, statutory inspection, DOT annual inspection, ICAO airworthiness check), work order number, raised date, scheduled date, completion date, maintenance provider (internal workshop or external vendor reference), fault description, parts replaced, labor hours, total maintenance cost (OPEX), downtime duration, and post-maintenance asset status. Integrates with SAP TM for asset availability updates and SAP S/4HANA Finance for OPEX cost posting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` (
    `maintenance_schedule_id` BIGINT COMMENT 'Unique identifier for the maintenance schedule record. Primary key.',
    `asset_type_id` BIGINT COMMENT 'Foreign key linking to fleet.asset_type. Business justification: maintenance_schedule currently has asset_type (STRING) storing the asset type as free text. Maintenance schedules are often defined at the asset type level (e.g., all trucks of type X need service ev',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Scheduled maintenance generates budgeted costs that must be allocated to cost centers for preventive maintenance budget planning, cost forecasting, and variance analysis against actual maintenance ord',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Maintenance schedule governance requires tracking which employee created preventive maintenance plans for accountability, quality control, and regulatory compliance audits. Text field created_by sho',
    `facility_id` BIGINT COMMENT 'Reference to the maintenance facility, depot, or service center where this maintenance is scheduled to be performed.',
    `supplier_id` BIGINT COMMENT 'Reference to the preferred maintenance vendor or service provider for this scheduled maintenance. Null if performed in-house.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the fleet asset (vehicle, aircraft, vessel, container) to which this maintenance schedule applies.',
    `auto_generate_order_flag` BOOLEAN COMMENT 'Indicates whether the system should automatically generate a maintenance work order when the schedule trigger conditions are met (True) or require manual creation (False).',
    `compliance_mandatory_flag` BOOLEAN COMMENT 'Indicates whether this maintenance schedule is mandated by regulatory compliance requirements (True) or is discretionary preventive maintenance (False).',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance schedule record was first created in the system.',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether the asset must be taken out of service (True) or can remain operational during maintenance (False).',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost in base currency for completing this scheduled maintenance service, including labor and parts.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated time in hours required to complete this maintenance service.',
    `interval_unit` STRING COMMENT 'Unit of measure for the maintenance interval value (miles, kilometers, engine hours, calendar days, operating cycles).. Valid values are `miles|kilometers|hours|days|cycles`',
    `interval_value` DECIMAL(18,2) COMMENT 'Numeric value of the maintenance interval (e.g., 5000 for 5000 miles, 100 for 100 engine hours, 365 for 365 days).',
    `last_completed_date` DATE COMMENT 'The date when this maintenance service was last completed for the asset.',
    `last_completed_hours` DECIMAL(18,2) COMMENT 'The engine hour meter reading when this maintenance service was last completed. Null if not applicable.',
    `last_completed_mileage` DECIMAL(18,2) COMMENT 'The odometer mileage reading when this maintenance service was last completed. Null if not applicable.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this maintenance schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance schedule record was last updated in the system.',
    `lead_time_days` STRING COMMENT 'Number of days advance notice required before the scheduled maintenance due date to allow for planning, parts procurement, and resource allocation.',
    `next_due_date` DATE COMMENT 'The calendar date by which the next scheduled maintenance service must be completed. Null if trigger basis is not calendar-based.',
    `next_due_hours` DECIMAL(18,2) COMMENT 'The engine hour meter reading at which the next scheduled maintenance service is due. Null if trigger basis is not engine hours or flight hours.',
    `next_due_mileage` DECIMAL(18,2) COMMENT 'The odometer mileage reading at which the next scheduled maintenance service is due. Null if trigger basis is not mileage.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments related to this maintenance schedule.',
    `parts_required_flag` BOOLEAN COMMENT 'Indicates whether replacement parts or consumables are required for this maintenance service (True) or if it is inspection/labor only (False).',
    `priority_level` STRING COMMENT 'Business priority level assigned to this maintenance schedule based on asset criticality and operational impact.. Valid values are `critical|high|medium|low`',
    `regulation_reference` STRING COMMENT 'Specific regulation, code section, or standard that mandates this maintenance schedule (e.g., 49 CFR 396.17, ICAO Annex 6 Part I, IMO SOLAS Chapter II-1).',
    `regulatory_body` STRING COMMENT 'The governing regulatory body that mandates this maintenance requirement (DOT, ICAO, IMO, FAA, FMCSA, EASA, IATA). Null if not compliance-driven. [ENUM-REF-CANDIDATE: DOT|ICAO|IMO|FAA|FMCSA|EASA|IATA — 7 candidates stripped; promote to reference product]',
    `schedule_effective_date` DATE COMMENT 'The date from which this maintenance schedule becomes active and applicable to the asset.',
    `schedule_expiry_date` DATE COMMENT 'The date on which this maintenance schedule is no longer applicable (e.g., asset retirement, schedule superseded by new regulation). Null for open-ended schedules.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the maintenance schedule (active, suspended, completed, overdue, cancelled).. Valid values are `active|suspended|completed|overdue|cancelled`',
    `service_description` STRING COMMENT 'Detailed description of the maintenance service activities and scope of work included in this schedule.',
    `service_type` STRING COMMENT 'Type of preventive maintenance service defined in this schedule (e.g., oil change, tire rotation, brake inspection, DOT annual inspection, ICAO 100-hour check, engine overhaul).. Valid values are `oil_change|tire_rotation|brake_inspection|engine_overhaul|dot_annual_inspection|icao_100_hour_check`',
    `tolerance_after_days` STRING COMMENT 'Number of days after the due date that the maintenance service may be performed late before the asset is considered non-compliant or overdue.',
    `tolerance_before_days` STRING COMMENT 'Number of days before the due date that the maintenance service may be performed early without resetting the schedule interval.',
    `trigger_basis` STRING COMMENT 'The measurement basis that triggers this maintenance service (mileage interval, engine hours, calendar days, flight hours, operating cycles).. Valid values are `mileage|engine_hours|calendar_days|flight_hours|operating_cycles`',
    CONSTRAINT pk_maintenance_schedule PRIMARY KEY(`maintenance_schedule_id`)
) COMMENT 'Master record defining the preventive maintenance schedule and service intervals for each fleet asset type. Captures asset type, service type (oil change, tyre rotation, brake inspection, DOT annual inspection, ICAO 100-hour check), trigger basis (mileage interval, engine hours, calendar days), next due mileage/hours/date, last completed date, compliance mandatory flag, regulatory body (DOT, ICAO, IMO), and schedule status. Drives automated maintenance_order generation and ensures regulatory compliance with DOT, ICAO, and IMO inspection requirements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` (
    `fuel_transaction_id` BIGINT COMMENT 'Unique identifier for the fuel transaction record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fuel is a major operating expense requiring cost center allocation for budget control and variance analysis; removes denormalized cost_center_code in favor of proper FK for GL posting and financial re',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Fuel purchases during cross-border trips must be associated with customs declarations for duty drawback claims, cost allocation to specific shipments, and compliance with fuel tax treaties. Supports f',
    `depot_id` BIGINT COMMENT 'Foreign key linking to fleet.depot. Business justification: Fuel transactions can occur at fleet depot fuel stations (on-site fueling). Adding depot_id links fuel uplifts to the specific depot. Nullable because many fuel transactions occur at external commerci',
    `driver_profile_id` BIGINT COMMENT 'Reference to the driver or operator who authorized or performed the fuel transaction. May be null for automated or depot-based refueling.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Fuel purchases may be governed by fuel supply agreements with negotiated rates and volume commitments. Procurement validates transaction pricing against contracted fuel rates, surcharge schedules, and',
    `fuel_index_id` BIGINT COMMENT 'Foreign key linking to pricing.fuel_index. Business justification: Fuel surcharge billing reconciliation requires linking actual fuel transactions to the published fuel index used for customer surcharge calculation. Finance teams reconcile fuel costs against index-ba',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Fuel costs and surcharges are billed to customers as line items on freight invoices. Real business process: fuel surcharge billing and cost recovery. Enables reconciliation of fuel transactions to cus',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Fuel suppliers are network partners in logistics operations. While supplier_id links to procurement.supplier, network_partner is the natural logistics domain entity for partner performance tracking, s',
    `plan_id` BIGINT COMMENT 'Reference to the route or trip during which this fuel transaction occurred. Links to route execution data for cost allocation.',
    `supplier_id` BIGINT COMMENT 'Reference to the fuel supplier or energy provider. Links to supplier master data for procurement and payables.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the fleet asset (vehicle, aircraft, vessel, container) that received fuel or energy. Links to the transport_asset master data.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Fuel purchases generate receipts and supplier invoices that must be linked for expense reconciliation, tax reporting, and fuel card audit. Essential for fuel cost management and financial reconciliati',
    `trip_id` BIGINT COMMENT 'Reference to the specific trip or journey during which this fuel transaction occurred. Used for trip-level cost analysis.',
    `authorization_code` STRING COMMENT 'Authorization or approval code issued by the fuel card provider or payment processor at the time of transaction.',
    `co2e_emission_factor` DECIMAL(18,2) COMMENT 'CO2e emission factor applied to calculate greenhouse gas emissions from this fuel consumption. Expressed in kg CO2e per unit of fuel. Used for sustainability reporting under EU ETS and CORSIA.',
    `co2e_emissions_kg` DECIMAL(18,2) COMMENT 'Total CO2e emissions generated by this fuel transaction, calculated as quantity multiplied by emission factor. Feeds sustainability domain for GHG reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel transaction record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount or rebate amount applied to the transaction based on supplier agreements or fuel card programs.',
    `fuel_card_number` STRING COMMENT 'Fuel card or fleet card number used for the transaction. Masked or tokenized for security. Used for reconciliation with supplier invoices.',
    `fuel_card_provider` STRING COMMENT 'Name of the fuel card provider or fleet card issuer (e.g., Shell Fleet, BP Fuel Card, WEX).',
    `fuel_efficiency` DECIMAL(18,2) COMMENT 'Calculated fuel efficiency for this transaction (e.g., km per litre, miles per gallon). Derived from odometer change and fuel quantity. Used for fleet performance KPIs.',
    `fuel_grade` STRING COMMENT 'Grade or quality specification of the fuel (e.g., premium, regular, ultra-low sulfur diesel). Used for asset maintenance and performance tracking.',
    `fuel_station_code` BIGINT COMMENT 'Reference to the fuel station, depot, or charging station where the transaction occurred. Links to location or supplier facility master data.',
    `fuel_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the fuel station is located. Used for tax and regulatory compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `fuel_station_location` STRING COMMENT 'Geographic location description of the fuel station (city, region, or address). Used for route analysis and cost allocation.',
    `fuel_station_name` STRING COMMENT 'Name of the fuel station, depot, or charging facility where the transaction took place.',
    `fuel_type` STRING COMMENT 'Type of fuel or energy consumed. Includes diesel, petrol (gasoline), LNG (Liquefied Natural Gas), CNG (Compressed Natural Gas), SAF (Sustainable Aviation Fuel), electric charge, hydrogen, or biodiesel. Critical for sustainability and emissions reporting. [ENUM-REF-CANDIDATE: diesel|petrol|lng|cng|saf|electric|hydrogen|biodiesel — 8 candidates stripped; promote to reference product]',
    `general_ledger_account` STRING COMMENT 'General ledger account code for fuel expense posting. Used for financial accounting and P&L reporting.',
    `is_emergency_refuel` BOOLEAN COMMENT 'Flag indicating whether this was an emergency or unplanned refueling event outside of normal depot operations. Used for exception analysis.',
    `is_reconciled` BOOLEAN COMMENT 'Flag indicating whether this transaction has been reconciled with supplier invoices and financial records.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel transaction record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about the fuel transaction. May include driver remarks, exception explanations, or audit notes.',
    `odometer_reading` DECIMAL(18,2) COMMENT 'Odometer or hour-meter reading of the asset at the time of fuel uplift. Used for fuel efficiency analysis and maintenance scheduling.',
    `odometer_unit` STRING COMMENT 'Unit of measure for the odometer reading (kilometers, miles, or operating hours for aircraft/vessels).. Valid values are `km|miles|hours`',
    `payment_method` STRING COMMENT 'Method of payment used for the fuel transaction (fuel card, credit card, cash, invoice, direct debit).. Valid values are `fuel_card|credit_card|cash|invoice|direct_debit`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of fuel or energy consumed in the transaction. Measured in litres for liquid fuels or kWh for electric charging.',
    `reconciliation_date` DATE COMMENT 'Date when the transaction was reconciled with supplier invoices and approved for payment.',
    `source_system` STRING COMMENT 'Name of the source system or fuel card provider system from which this transaction was captured (e.g., SAP TM, fuel card provider API, telematics system).',
    `supplier_invoice_number` STRING COMMENT 'Invoice number issued by the fuel supplier for this transaction. Used for accounts payable reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the fuel transaction. Includes VAT, excise duty, or other applicable fuel taxes.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the fuel transaction including base fuel cost and any applicable surcharges or taxes. Represents the net amount payable.',
    `transaction_datetime` TIMESTAMP COMMENT 'The date and time when the fuel uplift or energy charge event occurred. Principal business event timestamp.',
    `transaction_number` STRING COMMENT 'Externally-known unique transaction number or receipt number issued by the fuel supplier or fuel card provider.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the fuel transaction. Indicates whether the transaction has been completed, is pending reconciliation, disputed, cancelled, or reversed.. Valid values are `completed|pending|disputed|cancelled|reversed`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of fuel or energy (e.g., cost per litre, cost per kWh). Used for cost analysis and budgeting.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the fuel quantity. Typically litres or gallons for liquid fuels, kWh for electric, kg for hydrogen, or m3 for gas.. Valid values are `litres|gallons|kwh|kg|m3`',
    CONSTRAINT pk_fuel_transaction PRIMARY KEY(`fuel_transaction_id`)
) COMMENT 'Transactional record capturing every fuel uplift and energy consumption event for fleet assets. Tracks asset reference, driver reference, transaction datetime, fuel station/depot location, fuel type (diesel, petrol, LNG, SAF — Sustainable Aviation Fuel, electric charge), quantity (litres or kWh), unit cost, total cost, odometer reading at fill, fuel card number, supplier reference, and CO2e emission factor applied. Feeds sustainability domain for GHG reporting under EU ETS and CORSIA, and finance domain for OPEX fuel cost allocation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` (
    `asset_inspection_id` BIGINT COMMENT 'Unique identifier for the asset inspection record. Primary key.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to customs.compliance_program. Business justification: Asset inspections (security seals, container integrity, GPS functionality) are mandatory for customs compliance programs (C-TPAT, AEO). Inspection certificates must be maintained as evidence of progra',
    `depot_id` BIGINT COMMENT 'Foreign key linking to fleet.depot. Business justification: Inspections are often conducted at fleet depots/workshops. Adding depot_id allows tracking which depot performed the inspection. Nullable because inspections can also occur at external regulatory auth',
    `transport_asset_id` BIGINT COMMENT 'Reference to the fleet asset (vehicle, aircraft, vessel, container) that was inspected.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Inspections produce regulatory certificates, compliance reports, and inspection records that must be linked to the inspection event for regulatory filings and compliance verification. Required for DOT',
    `certificate_expiry_date` DATE COMMENT 'The date on which the issued regulatory certificate expires, triggering the need for a subsequent inspection to maintain compliance.',
    `certificate_issue_date` DATE COMMENT 'The date the regulatory certificate or compliance document was officially issued following successful inspection.',
    `certificate_number` STRING COMMENT 'Unique identifier of the regulatory certificate or compliance document issued. Used for regulatory reporting and audit verification.',
    `corrective_action_deadline` DATE COMMENT 'The date by which all required corrective actions must be completed to maintain regulatory compliance and operational status.',
    `corrective_actions_required` STRING COMMENT 'Detailed description of corrective actions, repairs, or remediation work required to address identified defects and achieve compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system. Used for audit trail and data lineage tracking.',
    `critical_defects_count` STRING COMMENT 'Number of critical or safety-related defects that require immediate corrective action and may result in asset being placed out of service.',
    `defects_description` STRING COMMENT 'Detailed narrative description of all defects, non-conformances, and observations identified during the inspection. Includes severity classification and affected components.',
    `defects_identified_count` STRING COMMENT 'Total number of defects, non-conformances, or discrepancies identified during the inspection. Zero indicates no issues found.',
    `inspection_checklist_reference` STRING COMMENT 'Reference identifier for the standardized inspection checklist or procedure document used to conduct this inspection.',
    `inspection_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the inspection, including labor, materials, third-party fees, and administrative overhead.',
    `inspection_cost_currency` STRING COMMENT 'Three-letter ISO currency code for the inspection cost amount.. Valid values are `^[A-Z]{3}$`',
    `inspection_date` DATE COMMENT 'The calendar date on which the inspection was conducted. This is the principal business event timestamp for regulatory compliance and audit purposes.',
    `inspection_document_url` STRING COMMENT 'URL or file path to the digital inspection report, certificate scan, or supporting documentation stored in the document management system.',
    `inspection_end_time` TIMESTAMP COMMENT 'Precise timestamp when the inspection was completed. Used to calculate inspection duration and resource utilization.',
    `inspection_location` STRING COMMENT 'Physical location where the inspection was performed (e.g., depot name, roadside checkpoint, port facility, maintenance hangar).',
    `inspection_location_country` STRING COMMENT 'Three-letter ISO country code of the jurisdiction where the inspection took place. Critical for determining applicable regulatory framework.. Valid values are `^[A-Z]{3}$`',
    `inspection_notes` STRING COMMENT 'Additional free-text notes, observations, or comments recorded by the inspector that provide context beyond structured fields.',
    `inspection_number` STRING COMMENT 'Externally-known unique identifier or reference number for this inspection event, often used for regulatory reporting and audit trails.',
    `inspection_outcome` STRING COMMENT 'Overall result of the inspection. Pass indicates full compliance; fail indicates critical defects requiring immediate action; conditional pass indicates minor defects with corrective action required within a specified timeframe.. Valid values are `pass|fail|conditional pass|not applicable`',
    `inspection_start_time` TIMESTAMP COMMENT 'Precise timestamp when the inspection commenced. Used for operational tracking and labor cost allocation.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection event. Tracks progression from scheduling through completion or cancellation.. Valid values are `scheduled|in progress|completed|cancelled|deferred`',
    `inspection_type` STRING COMMENT 'Category of inspection conducted. Determines the regulatory framework, scope, and compliance requirements applicable to this inspection event.. Valid values are `DOT roadside inspection|ICAO airworthiness check|IMO vessel survey|pre-trip inspection|annual safety inspection|C-TPAT security inspection`',
    `inspector_authority` STRING COMMENT 'The organization or regulatory body under whose authority the inspection was conducted (e.g., DOT, ICAO, IMO, internal fleet safety team, third-party auditor).',
    `inspector_certification_number` STRING COMMENT 'Official certification or license number of the inspector, required for regulatory inspections to validate inspector qualifications.',
    `inspector_name` STRING COMMENT 'Full name of the individual who conducted the inspection. May be an internal employee or external regulatory authority representative.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last updated. Used for audit trail and change tracking.',
    `next_inspection_due_date` DATE COMMENT 'The date by which the next scheduled inspection of this type must be conducted to maintain regulatory compliance and operational certification.',
    `odometer_reading_at_inspection` DECIMAL(18,2) COMMENT 'Odometer or usage meter reading (kilometers, miles, flight hours, engine hours) recorded at the time of inspection. Used for maintenance interval tracking.',
    `out_of_service_flag` BOOLEAN COMMENT 'Indicates whether the asset was placed out of service as a result of this inspection due to critical safety defects or regulatory non-compliance.',
    `out_of_service_start_date` DATE COMMENT 'The date the asset was officially placed out of service following the inspection. Null if asset was not taken out of service.',
    `regulatory_certificate_issued` STRING COMMENT 'Name or type of regulatory certificate, permit, or compliance document issued as a result of passing this inspection (e.g., DOT Annual Inspection Certificate, ICAO Certificate of Airworthiness, IMO Safety Equipment Certificate).',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for any regulatory filing, report, or submission made to authorities as a result of this inspection (e.g., DOT inspection report number, ICAO occurrence report).',
    `reinspection_due_date` DATE COMMENT 'The date by which the reinspection must be conducted to verify corrective action completion. Null if no reinspection is required.',
    `reinspection_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up reinspection is required to verify that corrective actions have been completed and defects resolved.',
    CONSTRAINT pk_asset_inspection PRIMARY KEY(`asset_inspection_id`)
) COMMENT 'Transactional record for all formal regulatory and operational inspections conducted on fleet assets. Captures asset reference, inspection type (DOT roadside inspection, ICAO airworthiness check, IMO vessel survey, pre-trip inspection, annual safety inspection, C-TPAT security inspection), inspection date, inspector name/authority, inspection outcome (pass, fail, conditional), defects identified, corrective actions required, reinspection due date, and regulatory certificate issued. Distinct from maintenance_order — inspections are compliance events that may or may not trigger maintenance work.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` (
    `asset_licence_id` BIGINT COMMENT 'Unique identifier for the asset licence record. Primary key.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the fleet asset (vehicle, aircraft, vessel, container) to which this licence applies.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Asset licenses reference supporting documents including license applications, renewal certificates, and regulatory approval letters. Essential for license compliance tracking and renewal management in',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this licence record was first created in the system. Audit trail for data lineage and compliance reporting.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the scanned or digital copy of the physical licence certificate or permit document stored in the document management system.',
    `effective_date` DATE COMMENT 'Date from which the licence becomes legally valid and enforceable. May differ from issue_date if there is a grace period or delayed activation.',
    `endorsements` STRING COMMENT 'Additional endorsements, restrictions, or special conditions attached to the licence (e.g., hazmat endorsement, night flight restriction, coastal waters only). Free-text field for regulatory notes.',
    `expiry_date` DATE COMMENT 'Date on which the licence or permit expires and is no longer valid. Null for licences with indefinite validity or those that do not expire.',
    `inspection_authority` STRING COMMENT 'Name of the agency or third-party organization authorized to conduct inspections for this licence (e.g., FAA Designated Airworthiness Representative, Port State Control Inspector).',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a physical inspection or audit by the regulatory authority is required as part of the licence issuance or renewal process. True = inspection required; False = no inspection required.',
    `issue_date` DATE COMMENT 'Date on which the licence or permit was officially issued by the regulatory authority. Marks the start of the licence validity period.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body, government agency, or certification authority that issued the licence or permit (e.g., Federal Aviation Administration, Department of Motor Vehicles, Port State Control).',
    `issuing_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction that issued the licence (e.g., USA, GBR, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `jurisdiction` STRING COMMENT 'Specific jurisdiction, state, province, or region within the issuing country where the licence is valid (e.g., California, Ontario, Bavaria). Null if the licence is valid nationwide.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection or audit conducted for this licence. Null if no inspection has been performed.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this licence record. Tracks data modification history for audit and compliance purposes.',
    `licence_category` STRING COMMENT 'Sub-classification or category code within the licence type (e.g., for vehicle registration: commercial, private, heavy goods; for airworthiness: transport category, restricted category).',
    `licence_class` STRING COMMENT 'Class designation within the licence category, defining specific operational limits or capabilities (e.g., Class 1 for heavy trucks, Class A for multi-engine aircraft).',
    `licence_fee_amount` DECIMAL(18,2) COMMENT 'Total fee paid to the issuing authority for the issuance or renewal of this licence. Excludes taxes and processing charges.',
    `licence_fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the licence fee amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `licence_number` STRING COMMENT 'The official licence, permit, or certificate number issued by the regulatory authority. This is the externally-known unique identifier for the licence.',
    `licence_type` STRING COMMENT 'Classification of the licence or permit. Defines the regulatory purpose and scope of the licence (e.g., vehicle registration for road use, airworthiness certificate for aircraft operation, dangerous goods permit for hazardous cargo transport). [ENUM-REF-CANDIDATE: vehicle_registration|operating_licence|airworthiness_certificate|vessel_class_certificate|dangerous_goods_permit|oversize_overweight_permit|cross_border_transit_permit|emission_certificate|insurance_certificate|roadworthiness_certificate — 10 candidates stripped; promote to reference product]',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory inspection or audit required to maintain licence validity. Null if no future inspection is scheduled.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or operational notes related to this licence (e.g., pending appeal, conditional approval, temporary exemption granted).',
    `payment_reference` STRING COMMENT 'Payment transaction reference or receipt number for the licence fee payment. Used for audit and reconciliation purposes.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, statute, or legal framework under which this licence is issued (e.g., 49 CFR Part 383, ICAO Annex 8, SOLAS Chapter II-1).',
    `renewal_due_date` DATE COMMENT 'Target date by which the licence renewal process must be initiated to avoid lapse. Typically set ahead of expiry_date to allow processing time.',
    `renewal_reminder_days` STRING COMMENT 'Number of days before expiry_date when automated renewal reminders should be triggered to fleet managers and compliance officers.',
    `responsible_party` STRING COMMENT 'Name or employee ID of the fleet manager, compliance officer, or department responsible for managing and renewing this licence.',
    `validity_status` STRING COMMENT 'Current validity state of the licence. Indicates whether the asset is legally compliant to operate under this licence. Valid = currently active and compliant; Expired = past expiry date; Suspended = temporarily invalid; Revoked = permanently cancelled; Pending Renewal = renewal application submitted; Pending Approval = initial application under review.. Valid values are `valid|expired|suspended|revoked|pending_renewal|pending_approval`',
    CONSTRAINT pk_asset_licence PRIMARY KEY(`asset_licence_id`)
) COMMENT 'Master record tracking all regulatory licences, permits, certificates, and registrations associated with individual fleet assets. Captures asset reference, licence/permit type (vehicle registration, operating licence, airworthiness certificate, vessel class certificate, dangerous goods transport permit, oversize/overweight permit, cross-border transit permit), issuing authority, issue date, expiry date, licence number, jurisdiction/country, renewal reminder days, and current validity status. Ensures DOT, ICAO, IMO, and national transport authority compliance across the global fleet.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier for the fleet incident record. Primary key.',
    `asset_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.asset_assignment. Business justification: Incidents occur during specific operational assignments (asset_assignment represents a vehicle assigned to a freight order/route). Linking incident to asset_assignment provides full operational contex',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Incidents involving contracted carrier assets or drivers require carrier linkage for liability determination, insurance claims processing, carrier performance impact assessment, and regulatory reporti',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment being transported at the time of the incident (if applicable). Links to cargo damage claims.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Incidents during cross-border transport (accidents, cargo damage, theft) must be reported in relation to customs declarations for insurance claims, duty adjustments, and regulatory investigations. Req',
    `driver_profile_id` BIGINT COMMENT 'Reference to the driver or operator assigned to the asset at the time of the incident.',
    `geofence_zone_id` BIGINT COMMENT 'Foreign key linking to fleet.geofence_zone. Business justification: Incidents have location coordinates (latitude/longitude). Linking to geofence_zone identifies which monitored zone the incident occurred in, supporting zone-based safety analysis, regulatory complianc',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Fleet incidents (vehicle accidents, collisions, cargo damage) are a specialized subset of HSE incidents. Linking enables unified incident management, root cause analysis, and regulatory reporting (OSH',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the insurance claim filed for this incident (if applicable). Links to the claim domain for processing.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the transport asset (vehicle, aircraft, vessel, container) involved in the incident.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Incidents generate police reports, insurance claim documents, investigation reports, and DOT regulatory filings. Critical for incident management, insurance claims processing, and regulatory complianc',
    `trip_id` BIGINT COMMENT 'Foreign key linking to fleet.trip. Business justification: Incidents (accidents, near-misses, cargo damage) occur during specific trips. Adding trip_id links the incident to the trip record for trip-level safety analysis and reporting. Nullable for incidents ',
    `asset_damage_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the asset damage estimated cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `asset_damage_estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost of damage to the transport asset (vehicle, aircraft, vessel, container) in the incident currency. Includes repair or replacement costs.',
    `cargo_damage_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cargo damage estimated cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cargo_damage_estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost of damage to cargo or goods in the incident currency. Used for cargo claim processing.',
    `cargo_damage_flag` BOOLEAN COMMENT 'Indicates whether cargo or goods being transported were damaged in the incident. True if cargo damaged, False otherwise.',
    `corrective_action_description` STRING COMMENT 'Detailed description of corrective actions taken or planned to prevent recurrence, including training, maintenance, policy changes, or process improvements.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required to prevent recurrence of similar incidents. True if corrective actions required, False otherwise.',
    `corrective_action_status` STRING COMMENT 'Current status of corrective actions identified for this incident. Not_required: no actions needed. Pending: actions identified but not started. In_progress: actions being implemented. Completed: all actions finished. Overdue: actions past due date.. Valid values are `not_required|pending|in_progress|completed|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this incident record was first created in the fleet management system.',
    `datetime` TIMESTAMP COMMENT 'The date and time when the incident occurred in the field. This is the real-world event timestamp, distinct from when the incident was reported or recorded in the system.',
    `dot_report_submitted_date` DATE COMMENT 'Date when the DOT accident report was submitted to the regulatory authority (if applicable).',
    `dot_reportable_flag` BOOLEAN COMMENT 'Indicates whether this incident meets the US Department of Transportation (DOT) criteria for mandatory accident reporting. True if DOT reportable, False otherwise.',
    `fatality_count` STRING COMMENT 'Total number of fatalities resulting from the incident.',
    `incident_number` STRING COMMENT 'Externally-visible unique incident reference number used for tracking and reporting. Format: INC-XXXXXXXXXX.. Valid values are `^INC-[0-9]{10}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident record. Reported: initial notification received. Under_investigation: active investigation in progress. Pending_review: investigation complete, awaiting management review. Closed: incident resolved and closed. Reopened: closed incident reopened for additional investigation.. Valid values are `reported|under_investigation|pending_review|closed|reopened`',
    `incident_type` STRING COMMENT 'Classification of the incident: accident (collision or crash), near_miss (potential accident avoided), breakdown (mechanical failure), cargo_damage (damage to goods), security_incident (unauthorized access or threat), theft (asset or cargo stolen).. Valid values are `accident|near_miss|breakdown|cargo_damage|security_incident|theft`',
    `injuries_reported_flag` BOOLEAN COMMENT 'Indicates whether any injuries (to driver, passengers, or third parties) were reported as a result of the incident. True if injuries reported, False otherwise.',
    `injury_count` STRING COMMENT 'Total number of individuals injured in the incident, including driver, passengers, and third parties.',
    `investigation_assigned_to` STRING COMMENT 'Name or identifier of the safety officer, manager, or team assigned to investigate this incident.',
    `investigation_completed_date` DATE COMMENT 'Date when the incident investigation was completed and findings documented.',
    `location_address` STRING COMMENT 'Human-readable street address or location description where the incident occurred. May include route number, mile marker, or landmark.',
    `location_city` STRING COMMENT 'City or municipality where the incident occurred.',
    `location_country_code` STRING COMMENT 'Three-letter ISO country code where the incident occurred (e.g., USA, CAN, MEX, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `location_latitude` DECIMAL(18,2) COMMENT 'GPS (Global Positioning System) latitude coordinate of the incident location in decimal degrees. Range: -90 to +90.',
    `location_longitude` DECIMAL(18,2) COMMENT 'GPS (Global Positioning System) longitude coordinate of the incident location in decimal degrees. Range: -180 to +180.',
    `location_postal_code` STRING COMMENT 'Postal or ZIP code of the incident location.',
    `location_state_province` STRING COMMENT 'State, province, or administrative region where the incident occurred.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, witness statements, or supplementary information about the incident.',
    `police_department` STRING COMMENT 'Name of the law enforcement agency or police department that responded to the incident.',
    `police_report_filed_flag` BOOLEAN COMMENT 'Indicates whether a police report was filed for this incident. True if police report filed, False otherwise.',
    `police_report_number` STRING COMMENT 'Official police report or case number assigned by law enforcement agency (if applicable).',
    `reported_datetime` TIMESTAMP COMMENT 'The date and time when the incident was first reported to the fleet management system or control center.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause of the incident. Driver_error: human error by driver. Mechanical_failure: asset malfunction. Road_conditions: poor road surface or infrastructure. Weather: adverse weather conditions. Third_party_fault: caused by external party. Cargo_shift: improper cargo loading or securing. Unknown: cause not yet determined. [ENUM-REF-CANDIDATE: driver_error|mechanical_failure|road_conditions|weather|third_party_fault|cargo_shift|unknown — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings and contributing factors to the incident.',
    `severity` STRING COMMENT 'Severity classification of the incident based on impact to personnel, asset, cargo, and operations. Minor: no injuries, minimal damage. Moderate: minor injuries, moderate damage. Major: serious injuries, significant damage. Critical: fatalities or catastrophic damage.. Valid values are `minor|moderate|major|critical`',
    `third_party_contact` STRING COMMENT 'Contact phone number or email address for the third party involved in the incident.',
    `third_party_insurance_provider` STRING COMMENT 'Name of the insurance company covering the third party involved in the incident.',
    `third_party_involved_flag` BOOLEAN COMMENT 'Indicates whether a third party (another vehicle, pedestrian, property owner, or external entity) was involved in the incident. True if third party involved, False otherwise.',
    `third_party_name` STRING COMMENT 'Name of the third party individual or organization involved in the incident (if applicable).',
    `third_party_policy_number` STRING COMMENT 'Insurance policy number of the third party involved in the incident.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this incident record was last modified or updated.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Transactional record capturing all fleet-related incidents including road accidents, near-misses, cargo damage events, vehicle breakdowns, and security incidents. Tracks incident datetime, location (GPS coordinates and address), asset reference, driver reference, incident type, severity classification, third-party involvement flag, police report number, injuries reported, estimated asset damage cost, cargo damage reference, insurance claim reference, root cause classification, and corrective action status. Feeds the claim domain for cargo insurance processing and supports DOT accident reporting obligations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` (
    `asset_utilisation_id` BIGINT COMMENT 'Unique identifier for the asset utilisation record. Primary key for this operational snapshot.',
    `depot_id` BIGINT COMMENT 'Reference to the depot, terminal, or home location where the asset is based during the reporting period.',
    `driver_profile_id` BIGINT COMMENT 'Reference to the primary driver or operator assigned to the asset during the reporting period. Links to workforce management for driver assignment tracking.',
    `plan_id` BIGINT COMMENT 'Reference to the primary route or network lane the asset operated on during the reporting period. Links to route and network domain for route execution analysis.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the transport asset (vehicle, aircraft, vessel, container) for which utilisation is being tracked.',
    `actual_payload_kg` DECIMAL(18,2) COMMENT 'Total actual payload weight carried by the asset during the reporting period, measured in kilograms.',
    `co2_emissions_kg` DECIMAL(18,2) COMMENT 'Total greenhouse gas (GHG) emissions produced by the asset during the reporting period, measured in kilograms of carbon dioxide equivalent (CO2e). Critical for sustainability reporting and compliance with EU Emissions Trading System (EU ETS) and Carbon Offsetting and Reduction Scheme for International Aviation (CORSIA).',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the asset during the reporting period. Indicates whether the asset met Department of Transportation (DOT), International Civil Aviation Organization (ICAO), International Maritime Organization (IMO), or other applicable regulatory requirements.. Valid values are `compliant|non_compliant|pending_inspection|exempted`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for revenue and cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `distance_travelled_km` DECIMAL(18,2) COMMENT 'Total distance travelled by the asset during the reporting period, measured in kilometers. Captured from GPS (Global Positioning System) telematics or odometer readings.',
    `distance_travelled_miles` DECIMAL(18,2) COMMENT 'Total distance travelled by the asset during the reporting period, measured in miles. Provided for regions using imperial units.',
    `fuel_consumed_liters` DECIMAL(18,2) COMMENT 'Total fuel consumed by the asset during the reporting period, measured in liters.',
    `fuel_efficiency_liters_per_100km` DECIMAL(18,2) COMMENT 'Fuel efficiency metric representing liters consumed per 100 kilometers travelled. Key operational expense (OPEX) and sustainability metric.',
    `fuel_efficiency_mpg` DECIMAL(18,2) COMMENT 'Fuel efficiency metric representing miles per gallon (MPG). Provided for regions using imperial units.',
    `load_factor_percent` DECIMAL(18,2) COMMENT 'Percentage representing the ratio of actual payload to maximum payload capacity. Key performance indicator (KPI) for asset efficiency.',
    `notes` STRING COMMENT 'Free-text field for operational notes, exceptions, or contextual information about the asset utilisation during the reporting period.',
    `number_of_trips` STRING COMMENT 'Total count of completed trips or delivery runs performed by the asset during the reporting period.',
    `on_time_delivery_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of trips completed on time during the reporting period. Key service level agreement (SLA) metric for customer satisfaction.',
    `operating_cost` DECIMAL(18,2) COMMENT 'Total operating expenditure (OPEX) incurred by the asset during the reporting period, including fuel, maintenance, tolls, and driver costs.',
    `operational_status` STRING COMMENT 'Current operational state of the asset during the reporting period. Indicates whether the asset was actively deployed, idle, under maintenance, experiencing breakdown, retired, or reserved.. Valid values are `active|idle|maintenance|breakdown|retired|reserved`',
    `payload_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum payload capacity of the asset in kilograms. Used to calculate load factor.',
    `period_type` STRING COMMENT 'The granularity of the reporting period: daily, weekly, or monthly snapshot.. Valid values are `daily|weekly|monthly`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this utilisation record was first created in the system. Audit trail for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this utilisation record was last modified. Audit trail for data lineage and compliance.',
    `reporting_period_date` DATE COMMENT 'The date for which this utilisation snapshot is recorded. Represents the business event date for daily or weekly operational reporting.',
    `revenue_generated` DECIMAL(18,2) COMMENT 'Total revenue generated by the asset during the reporting period. Used for profitability and return on investment (ROI) analysis.',
    `safety_incidents_count` STRING COMMENT 'Total number of safety incidents or accidents involving the asset during the reporting period. Critical for risk management and insurance reporting.',
    `telematics_data_quality_score` DECIMAL(18,2) COMMENT 'Quality score (0-100) representing the completeness and accuracy of GPS (Global Positioning System) telematics and Internet of Things (IoT) sensor data captured during the reporting period. Used to assess data reliability for analytics.',
    `total_available_hours` DECIMAL(18,2) COMMENT 'Total number of hours the asset was available for operational use during the reporting period, excluding scheduled downtime.',
    `total_breakdown_hours` DECIMAL(18,2) COMMENT 'Total number of hours the asset was unavailable due to unplanned breakdowns or failures during the reporting period.',
    `total_downtime_hours` DECIMAL(18,2) COMMENT 'Total number of hours the asset was out of service during the reporting period, combining maintenance and breakdown hours.',
    `total_idle_hours` DECIMAL(18,2) COMMENT 'Total number of hours the asset was idle (available but not in use) during the reporting period.',
    `total_maintenance_hours` DECIMAL(18,2) COMMENT 'Total number of hours the asset was undergoing scheduled or preventive maintenance during the reporting period.',
    `total_operational_hours` DECIMAL(18,2) COMMENT 'Total number of hours the asset was actively in operation (moving, transporting cargo, or performing its primary function) during the reporting period.',
    `utilisation_rate_percent` DECIMAL(18,2) COMMENT 'Overall utilisation rate calculated as the ratio of operational hours to available hours, expressed as a percentage. Primary KPI for fleet management decisions.',
    `volume_capacity_cbm` DECIMAL(18,2) COMMENT 'Maximum volume capacity of the asset in cubic meters (CBM). Used to calculate volume utilisation rate.',
    `volume_utilised_cbm` DECIMAL(18,2) COMMENT 'Total cargo volume utilised during the reporting period, measured in cubic meters (CBM). Relevant for container and warehouse assets.',
    CONSTRAINT pk_asset_utilisation PRIMARY KEY(`asset_utilisation_id`)
) COMMENT 'Periodic operational record (daily/weekly snapshot) capturing fleet utilisation metrics for each transport asset. Tracks asset reference, reporting period (date), total available hours, total operational hours, total idle hours, total downtime hours (maintenance + breakdown), distance travelled (km/miles), load factor (actual payload vs capacity), number of trips completed, fuel efficiency (litres per 100km or MPG), and utilisation rate percentage. This is an operational Silver Layer record — NOT an analytics aggregate — representing the daily operational state of each asset for fleet management decisions.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` (
    `asset_acquisition_id` BIGINT COMMENT 'Unique identifier for the asset acquisition record. Primary key for the asset acquisition data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Asset purchases and leases are governed by acquisition contracts. Finance and fleet management link assets to governing purchase/lease agreements for depreciation schedules, payment tracking, lease li',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Capital expenditure approval workflows require tracking which employee authorized asset purchases/leases for financial controls, audit trails, and delegation-of-authority compliance. Text field appro',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Links fleet operational asset records to finance fixed asset register for capitalization, depreciation calculation, asset accounting, and financial statement reporting - required for IFRS/GAAP complia',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Asset suppliers (leasing companies, OEMs, brokers) are network partners. Enables integrated partner performance tracking across procurement and operations, supports vendor consolidation analysis, and ',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom the asset was purchased. Links to procurement domain supplier master data.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the transport asset being acquired. Links to the transport_asset master record in the fleet domain.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Asset acquisitions generate purchase contracts, lease agreements, invoices, and financing documents that must be retained for financial audit and asset accounting. Required for IFRS 16 lease accountin',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The total depreciation expense accumulated since acquisition date. Updated periodically based on depreciation method and rate.',
    `acquisition_approval_date` DATE COMMENT 'The date on which the acquisition was approved by the appropriate authority (e.g., CAPEX committee, CFO). Used for governance and audit trails.',
    `acquisition_date` DATE COMMENT 'The date on which the asset was acquired or the purchase transaction was completed. Used as the basis for depreciation calculation and fixed asset accounting.',
    `acquisition_notes` STRING COMMENT 'Free-text notes or comments related to the acquisition transaction. Captures special terms, conditions, or contextual information.',
    `acquisition_number` STRING COMMENT 'Business-facing unique reference number for the acquisition transaction. Used for tracking and reporting purposes across finance and procurement systems.',
    `acquisition_status` STRING COMMENT 'Current lifecycle status of the acquisition transaction. Tracks progression from planning through completion or cancellation.. Valid values are `planned|approved|in_progress|completed|cancelled|terminated`',
    `acquisition_type` STRING COMMENT 'Classification of the acquisition method. Determines accounting treatment under IFRS 16 and impacts CAPEX vs OPEX classification.. Valid values are `outright_purchase|finance_lease|operating_lease|hire_purchase|capital_lease|sale_and_leaseback`',
    `asset_class` STRING COMMENT 'The fixed asset class or category for accounting purposes (e.g., vehicles, aircraft, vessels, containers). Used for financial reporting and asset grouping.',
    `capex_budget_code` STRING COMMENT 'The budget code or cost center code to which this CAPEX acquisition is allocated. Links to finance domain budget and cost center master data.',
    `contract_end_date` DATE COMMENT 'The scheduled end date of the lease or hire purchase contract. Null for outright purchases. Used to calculate lease term and residual value obligations.',
    `contract_reference_number` STRING COMMENT 'The unique reference number of the lease or purchase contract. Used for contract management and compliance tracking.',
    `contract_start_date` DATE COMMENT 'The effective start date of the lease or purchase contract. For leases, this is the commencement date under IFRS 16.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this acquisition record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this acquisition record (purchase_price, lease_value, residual_value, etc.).. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'The accounting method used to depreciate the asset over its useful life. Determines how the asset value is expensed over time for financial reporting.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `depreciation_rate_percent` DECIMAL(18,2) COMMENT 'The annual depreciation rate expressed as a percentage. Used in conjunction with depreciation_method to calculate periodic depreciation expense.',
    `disposal_date` DATE COMMENT 'The date on which the asset was disposed of, sold, or returned to the lessor. Marks the end of the assets lifecycle in the fleet.',
    `disposal_method` STRING COMMENT 'The method by which the asset was disposed of at the end of its lifecycle. Impacts accounting treatment and gain/loss calculation.. Valid values are `sale|lease_return|scrap|trade_in|donation|transfer`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'The amount received from the sale or disposal of the asset. Used to calculate gain or loss on disposal for financial reporting.',
    `down_payment` DECIMAL(18,2) COMMENT 'The initial down payment or deposit made at the time of acquisition. Reduces the financed amount or lease liability.',
    `financing_institution` STRING COMMENT 'The name of the bank or financial institution providing financing for the acquisition. Applicable for financed purchases and leases.',
    `gain_loss_on_disposal` DECIMAL(18,2) COMMENT 'The calculated gain or loss on asset disposal, computed as disposal_proceeds minus net_book_value at disposal date. Impacts P&L reporting.',
    `ifrs16_lease_liability` DECIMAL(18,2) COMMENT 'The calculated lease liability under IFRS 16, representing the present value of future lease payments. Recorded on the balance sheet for finance and operating leases.',
    `ifrs16_right_of_use_asset` DECIMAL(18,2) COMMENT 'The calculated right-of-use asset value under IFRS 16 for lease accounting. Represents the lessees right to use the leased asset over the lease term.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'The annual interest rate applied to the lease or financing agreement. Used for lease liability calculation under IFRS 16.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this acquisition record was last modified. Used for audit trail and change tracking.',
    `lease_value` DECIMAL(18,2) COMMENT 'The total value of the lease agreement, including all lease payments over the lease term. Used for IFRS 16 right-of-use asset and lease liability calculation.',
    `monthly_lease_payment` DECIMAL(18,2) COMMENT 'The recurring monthly payment amount for leased assets. Used for OPEX tracking and cash flow forecasting.',
    `net_book_value` DECIMAL(18,2) COMMENT 'The current book value of the asset calculated as purchase_price minus accumulated_depreciation. Represents the assets carrying value on the balance sheet.',
    `purchase_order_number` STRING COMMENT 'The purchase order number issued to the supplier or lessor for this acquisition. Links to procurement domain purchase order records.',
    `purchase_price` DECIMAL(18,2) COMMENT 'The total purchase price paid for the asset in the case of outright purchase. Represents the CAPEX investment and forms the basis for fixed asset capitalization.',
    `residual_value` DECIMAL(18,2) COMMENT 'The estimated value of the asset at the end of its useful life or lease term. Used for depreciation calculation and lease accounting under IFRS 16.',
    `tax_depreciation_method` STRING COMMENT 'The depreciation method used for tax reporting purposes, which may differ from the book depreciation method. Used for tax compliance and deferred tax calculation.. Valid values are `straight_line|declining_balance|macrs|accelerated`',
    `useful_life_years` STRING COMMENT 'The estimated useful life of the asset in years. Used to calculate depreciation and determine the assets economic lifespan for fleet planning.',
    `warranty_end_date` DATE COMMENT 'The date on which the manufacturer or supplier warranty coverage expires. Triggers transition to self-funded maintenance.',
    `warranty_start_date` DATE COMMENT 'The date on which the manufacturer or supplier warranty coverage begins. Used for maintenance planning and cost management.',
    CONSTRAINT pk_asset_acquisition PRIMARY KEY(`asset_acquisition_id`)
) COMMENT 'Master record capturing the full CAPEX lifecycle of fleet asset acquisitions including new purchases, finance leases, and operating leases. Tracks asset reference, acquisition type (outright purchase, finance lease, operating lease, hire purchase), supplier/lessor reference (links to procurement domain), acquisition date, contract start/end date, purchase price or lease value, residual value, depreciation method, depreciation rate, accumulated depreciation, net book value, CAPEX budget code (links to finance domain), and disposal/return date. Supports SAP S/4HANA Finance fixed asset accounting and IFRS 16 lease accounting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` (
    `asset_disposal_id` BIGINT COMMENT 'Unique identifier for the asset disposal transaction. Primary key for the asset disposal record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset disposal approval workflows require tracking which employee authorized disposal for financial controls, environmental compliance, and audit trails. Text field approved_by should be replaced wi',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Asset disposals may be governed by lease return agreements or sale contracts. Finance tracks disposal proceeds against contract terms, residual value commitments, and early termination penalties. Esse',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Disposal transactions must update the fixed asset register to calculate gain/loss on disposal, remove accumulated depreciation, and adjust book value - required for accurate financial statements and t',
    `transport_asset_id` BIGINT COMMENT 'Reference to the fleet asset being disposed. Links to the transport asset master record.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Asset disposals require decommissioning certificates, environmental compliance documents, sale agreements, and deregistration confirmations. Essential for disposal audit trails and environmental compl',
    `waste_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_record. Business justification: Asset decommissioning generates hazardous and recyclable waste requiring regulatory compliance tracking. Links disposal events to waste management records for environmental reporting, circular economy',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation charged against the asset from acquisition through disposal date. Removed from the balance sheet upon disposal.',
    `approval_date` DATE COMMENT 'Date when the disposal transaction was formally approved by authorized management. Part of the disposal workflow audit trail.',
    `book_value_at_disposal` DECIMAL(18,2) COMMENT 'The net book value (original cost minus accumulated depreciation) of the asset at the time of disposal. Used to calculate gain or loss on disposal.',
    `buyer_recipient_name` STRING COMMENT 'Name of the party acquiring the asset (for sales or trade-ins), receiving the donation, or processing the scrap. Null for write-offs.',
    `buyer_recipient_reference` STRING COMMENT 'External identifier or account number for the buyer, recipient, or scrap processor. Used for contract and payment tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposal record was first created in the system. Part of the audit trail for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this disposal transaction.. Valid values are `^[A-Z]{3}$`',
    `decommissioning_certificate_number` STRING COMMENT 'Reference number of the official certificate or document confirming regulatory decommissioning and compliance with disposal regulations.',
    `deregistration_authority` STRING COMMENT 'Name of the regulatory body or government agency that processed the asset deregistration (e.g., FAA, DVLA, national maritime authority).',
    `deregistration_date` DATE COMMENT 'Date when the asset was officially deregistered from regulatory authorities (e.g., DOT for vehicles, ICAO for aircraft, IMO for vessels). Required for compliance closure.',
    `disposal_costs` DECIMAL(18,2) COMMENT 'Total costs incurred to execute the disposal including transportation, decommissioning, environmental remediation, and administrative fees.',
    `disposal_country_code` STRING COMMENT 'Three-letter ISO 3166 country code where the disposal transaction occurred. Required for cross-border regulatory compliance and tax reporting.. Valid values are `^[A-Z]{3}$`',
    `disposal_date` DATE COMMENT 'The date when the asset disposal transaction was executed and ownership transferred or asset decommissioned. Principal business event timestamp for the disposal.',
    `disposal_location` STRING COMMENT 'Physical location or facility where the disposal transaction took place (e.g., depot, scrap yard, auction house, buyer premises).',
    `disposal_notes` STRING COMMENT 'Free-text field for additional comments, special circumstances, or operational details related to the disposal transaction.',
    `disposal_number` STRING COMMENT 'Externally-known business identifier for the disposal transaction. Used for tracking and audit purposes.. Valid values are `^DSP-[0-9]{8}$`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'The gross amount received from the disposal transaction before any deductions. Zero for scrapping, write-offs, or donations.',
    `disposal_reason` STRING COMMENT 'Business justification for disposing of the asset. May include end of useful life, excessive maintenance costs, fleet optimization, regulatory non-compliance, or accident damage.',
    `disposal_status` STRING COMMENT 'Current lifecycle status of the disposal transaction. Tracks the disposal workflow from initiation through completion.. Valid values are `initiated|approved|in_progress|completed|cancelled`',
    `disposal_type` STRING COMMENT 'Classification of the disposal method. Determines the financial treatment and regulatory requirements for the asset disposal.. Valid values are `sale|scrap|lease_return|write_off|donation|trade_in`',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the disposal was executed in compliance with environmental regulations including hazardous materials handling, waste disposal, and emissions standards. True if compliant, False if non-compliant or pending verification.',
    `environmental_disposal_method` STRING COMMENT 'Description of the environmentally-compliant disposal method used (e.g., certified recycling, authorized scrap yard, hazardous waste facility, parts recovery).',
    `finance_journal_entry_reference` STRING COMMENT 'Reference number of the general ledger journal entry created to record the disposal transaction, gain/loss, and asset removal from the balance sheet.',
    `gain_loss_on_disposal` DECIMAL(18,2) COMMENT 'Financial result of the disposal calculated as net disposal proceeds minus book value at disposal. Positive values represent gains, negative values represent losses.',
    `hazardous_materials_flag` BOOLEAN COMMENT 'Indicates whether the disposed asset contained hazardous materials requiring special handling (e.g., fuel, batteries, refrigerants, asbestos). True if hazardous materials were present.',
    `insurance_claim_reference` STRING COMMENT 'Reference number of any insurance claim associated with the disposal (e.g., for accident damage, theft, or total loss). Null if no insurance claim involved.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposal record was last modified. Tracks changes throughout the disposal workflow from initiation to completion.',
    `net_disposal_proceeds` DECIMAL(18,2) COMMENT 'Net amount realized from disposal after deducting disposal costs from gross proceeds. Used for gain/loss calculation.',
    `odometer_reading_at_disposal` DECIMAL(18,2) COMMENT 'Final odometer or usage meter reading at the time of disposal. Used for lifecycle analysis and residual value assessment. Applicable to vehicles and mobile equipment.',
    CONSTRAINT pk_asset_disposal PRIMARY KEY(`asset_disposal_id`)
) COMMENT 'Transactional record capturing the end-of-life disposal, sale, or return of fleet assets. Tracks asset reference, disposal type (sale, scrap, lease return, write-off, donation), disposal date, disposal proceeds, book value at disposal, gain/loss on disposal, disposal reason, buyer/recipient reference, deregistration date, regulatory decommissioning certificate reference, and environmental disposal compliance flag (e.g., hazardous materials handling). Closes the CAPEX lifecycle initiated in asset_acquisition and triggers finance domain journal entries.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` (
    `rfid_scan_id` BIGINT COMMENT 'Unique identifier for the RFID scan event record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: RFID scans at carrier handover points (terminals, cross-docks) must track which carrier took custody. Essential for chain-of-custody verification, exception management (missing scans, delays), carrier',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with this RFID scan event. Links the scan to the active shipment being tracked through the network.',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: RFID scans track containers passing through readers. rfid_scan has container_number (STRING) which is denormalized. Adding container_unit_id FK normalizes this relationship and allows direct join to c',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: RFID scans track container/asset movements through customs-controlled zones (ports, border crossings, FTZs). Essential for automated customs clearance, chain-of-custody verification, and supporting el',
    `depot_id` BIGINT COMMENT 'Reference to the specific facility, depot, warehouse, port, or checkpoint where the scan occurred. Links to the location master data.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator or personnel who initiated or supervised the scan event. Used for accountability and audit trail.',
    `freight_order_id` BIGINT COMMENT 'Reference to the freight order associated with this RFID scan event. Links the scan to the freight booking or order being executed.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the transport asset (vehicle, aircraft, vessel, container) that was scanned. Links to the fleet transport asset master data.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: RFID scans at checkpoints trigger document generation including gate receipts, custody transfer documents, and checkpoint confirmations. Required for chain of custody documentation and checkpoint veri',
    `antenna_code` STRING COMMENT 'Identifier of the specific antenna on the reader device that captured the scan. Used for precise location tracking within the scan zone.',
    `awb_number` STRING COMMENT 'Air Waybill number associated with the scanned asset if applicable. Used for air freight tracking and documentation.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with the scanned asset if applicable. Used for ocean and ground freight documentation.',
    `chain_of_custody_verified` BOOLEAN COMMENT 'Boolean indicator of whether the chain of custody was verified and validated at this scan point. Used for high-value or regulated cargo.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RFID scan record was first created in the system. Used for audit trail and data lineage tracking.',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator of whether this scan triggered an exception or alert condition (e.g., unexpected location, unauthorized movement, missing expected scan).',
    `exception_reason` STRING COMMENT 'Description of the exception or alert condition if the exception flag is true. Provides context for investigation and resolution.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the scan location. Provides geographic positioning for mobile or field-based RFID readers.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the scan location. Provides geographic positioning for mobile or field-based RFID readers.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage recorded at the time of scan. Used for environmental monitoring of sensitive cargo.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the RFID scan event. Used for capturing additional context, observations, or special handling instructions.',
    `processing_status` STRING COMMENT 'Current processing status of the RFID scan record in the data pipeline. Tracks the lifecycle of the scan event from capture to integration.. Valid values are `pending|processed|validated|rejected|archived`',
    `read_count` STRING COMMENT 'Number of times the RFID tag was read during this scan event. Multiple reads may occur as the asset passes through the reader field.',
    `reader_device_code` STRING COMMENT 'Unique identifier of the RFID reader device that captured the scan. Used for device tracking, maintenance, and audit purposes.. Valid values are `^[A-Z0-9_-]{6,20}$`',
    `rfid_tag_code` STRING COMMENT 'Unique identifier of the RFID tag that was scanned. Typically an Electronic Product Code (EPC) or proprietary tag identifier encoded in the RFID chip.. Valid values are `^[A-Z0-9]{8,24}$`',
    `scan_direction` STRING COMMENT 'Direction of asset movement at the time of scan. Indicates whether the asset is entering (inbound), leaving (outbound), or being transferred internally within the facility.. Valid values are `inbound|outbound|internal_transfer|unknown`',
    `scan_event_type` STRING COMMENT 'Type of business event that triggered the RFID scan. Categorizes the purpose and context of the scan within the logistics workflow. [ENUM-REF-CANDIDATE: gate_entry|gate_exit|dock_arrival|dock_departure|checkpoint_pass|inventory_count|exception_scan — 7 candidates stripped; promote to reference product]',
    `scan_location_name` STRING COMMENT 'Human-readable name of the facility or checkpoint where the RFID scan occurred.',
    `scan_location_type` STRING COMMENT 'Type of facility or checkpoint where the RFID scan occurred. Categorizes the scanning location within the logistics network. [ENUM-REF-CANDIDATE: depot|warehouse|port|gate|checkpoint|dock_door|terminal|hub|cross_dock|customs — 10 candidates stripped; promote to reference product]',
    `scan_source_system` STRING COMMENT 'Name or identifier of the source system that generated the RFID scan record (e.g., WMS, TMS, gate automation system, IoT platform).',
    `scan_status` STRING COMMENT 'Status of the RFID scan operation. Indicates whether the scan was successfully captured and processed or encountered issues.. Valid values are `successful|failed|partial|duplicate|exception`',
    `scan_timestamp` TIMESTAMP COMMENT 'Date and time when the RFID tag was scanned by the reader device. Represents the real-world event time of the scan occurrence.',
    `scan_zone` STRING COMMENT 'Specific zone, gate number, dock door, or checkpoint identifier within the facility where the scan occurred (e.g., Gate 5, Dock Door 12, Zone A).',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Radio frequency signal strength measured in decibels-milliwatts (dBm) at the time of scan. Used for quality assessment and reader optimization.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient temperature in Celsius recorded by the RFID reader or associated sensor at the time of scan. Used for cold chain monitoring and environmental compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this RFID scan record was last modified or updated. Used for audit trail and change tracking.',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the RFID scan record was validated and confirmed by the system. Used for data quality and audit purposes.',
    CONSTRAINT pk_rfid_scan PRIMARY KEY(`rfid_scan_id`)
) COMMENT 'Transactional record capturing RFID tag scan events for fleet assets and containers as they pass through depots, warehouses, ports, and checkpoints. Tracks asset/container reference, RFID tag ID, scan datetime, scan location (depot, gate, dock door, checkpoint), reader device ID, scan direction (inbound/outbound), and associated shipment or freight order reference. Enables real-time asset location tracking, gate automation, and chain-of-custody verification across the logistics network.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` (
    `tyre_record_id` BIGINT COMMENT 'Unique identifier for the tyre record. Primary key for the tyre lifecycle tracking entity.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the vehicle or transport asset to which this tyre is or was fitted.',
    `waste_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_record. Business justification: End-of-life tyre disposal is a regulated waste stream requiring tracking for environmental compliance and circular economy reporting. Links tyre lifecycle records to waste management for ESG disclosur',
    `condition_status` STRING COMMENT 'Current operational condition of the tyre: serviceable=fit for continued use, worn=approaching replacement threshold, damaged=requires repair or replacement, retreaded=has undergone retreading process, condemned=unsafe and must be disposed.. Valid values are `serviceable|worn|damaged|retreaded|condemned`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tyre record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_tread_depth_mm` DECIMAL(18,2) COMMENT 'Most recent tread depth measurement in millimeters. Updated during periodic inspections. Legal minimum is typically 1.6mm for passenger vehicles and 1.0mm for commercial vehicles in most jurisdictions.',
    `disposal_date` DATE COMMENT 'Date when the tyre was permanently disposed of or scrapped. Marks the end of the tyres total lifecycle.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the tyre: recycling=processed for material recovery, landfill=disposed in landfill, energy_recovery=used as fuel in cement kilns or energy plants, resale=sold as used tyre.. Valid values are `recycling|landfill|energy_recovery|resale`',
    `disposal_reason` STRING COMMENT 'Reason code indicating why the tyre was removed from service and disposed: end_of_life=normal wear completion, damage=physical damage beyond repair, safety_failure=failed safety inspection, irregular_wear=abnormal wear pattern, sidewall_damage=sidewall structural failure, puncture=irreparable puncture.. Valid values are `end_of_life|damage|safety_failure|irregular_wear|sidewall_damage|puncture`',
    `fitment_date` DATE COMMENT 'Date when the tyre was fitted or installed onto the vehicle. Marks the start of the tyres active service lifecycle on this asset.',
    `fitment_odometer_reading` DECIMAL(18,2) COMMENT 'Vehicle odometer reading in kilometers at the time of tyre fitment. Used to calculate tyre mileage and wear rate.',
    `initial_tread_depth_mm` DECIMAL(18,2) COMMENT 'Tread depth in millimeters measured at the time of fitment. For new tyres, typically 16-18mm for commercial vehicles; for retreaded tyres, typically 12-14mm.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent tyre inspection when tread depth, pressure, and condition were assessed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tyre record was most recently updated in the system.',
    `last_retread_date` DATE COMMENT 'Date when the tyre was most recently retreaded. Nullable if the tyre has never been retreaded.',
    `last_rotation_date` DATE COMMENT 'Date when the tyre was last rotated to a different position on the vehicle.',
    `load_index` STRING COMMENT 'Numerical code indicating the maximum load capacity the tyre can safely carry at the speed indicated by its speed rating.. Valid values are `^[0-9]{2,3}$`',
    `manufacturer` STRING COMMENT 'Name of the tyre manufacturer or brand (e.g., Michelin, Bridgestone, Goodyear, Continental).',
    `model` STRING COMMENT 'Manufacturer model or product line designation for the tyre (e.g., X Multi Energy D, R-Drive, Fuel Max).',
    `notes` STRING COMMENT 'Free-text field for additional observations, maintenance notes, or special handling instructions related to this tyre.',
    `position_code` STRING COMMENT 'Code indicating the physical position of the tyre on the vehicle: FL=Front Left, FR=Front Right, RL1=Rear Left Outer, RL2=Rear Left Inner, RR1=Rear Right Outer, RR2=Rear Right Inner, SPARE=Spare Tyre.. Valid values are `^(FL|FR|RL1|RL2|RR1|RR2|SPARE)$`',
    `pressure_rating_psi` STRING COMMENT 'Manufacturer-recommended tyre inflation pressure in pounds per square inch (PSI) for optimal performance and safety.',
    `purchase_cost` DECIMAL(18,2) COMMENT 'Original purchase cost of the tyre in the specified currency. Used for CAPEX tracking and cost-per-kilometer analysis.',
    `purchase_date` DATE COMMENT 'Date when the tyre was purchased or acquired by the fleet operator.',
    `removal_date` DATE COMMENT 'Date when the tyre was removed from the vehicle. Nullable until removal occurs. Marks the end of the tyres active service lifecycle on this asset.',
    `removal_odometer_reading` DECIMAL(18,2) COMMENT 'Vehicle odometer reading in kilometers at the time of tyre removal. Used to calculate total tyre mileage and cost per kilometer.',
    `retread_count` STRING COMMENT 'Number of times this tyre casing has been retreaded. Commercial truck tyres can typically be retreaded 2-3 times if the casing remains structurally sound.',
    `retread_vendor` STRING COMMENT 'Name of the vendor or facility that performed the most recent retreading service.',
    `rfid_tag` STRING COMMENT 'Unique RFID tag identifier embedded in or attached to the tyre for automated tracking and inventory management.. Valid values are `^[A-Z0-9]{16,24}$`',
    `rotation_sequence_number` STRING COMMENT 'Sequential counter tracking how many times this tyre has been rotated to different positions on the vehicle to promote even wear.',
    `season_type` STRING COMMENT 'Seasonal classification of the tyre indicating optimal operating temperature range and weather conditions.. Valid values are `all_season|summer|winter`',
    `serial_number` STRING COMMENT 'Unique manufacturer-issued serial number or DOT code identifying the individual tyre unit. Used for warranty claims, recall tracking, and lifecycle traceability.. Valid values are `^[A-Z0-9]{10,20}$`',
    `size_specification` STRING COMMENT 'Standard tyre size designation indicating width, aspect ratio, and rim diameter (e.g., 315/80R22.5 for commercial truck tyres).. Valid values are `^[0-9]{3}/[0-9]{2}R[0-9]{2}$`',
    `speed_rating` STRING COMMENT 'Letter code indicating the maximum speed capability of the tyre (e.g., J=100 km/h, L=120 km/h for commercial vehicles).. Valid values are `^[A-Z]$`',
    `supplier_name` STRING COMMENT 'Name of the supplier or vendor from whom the tyre was purchased.',
    `tread_pattern` STRING COMMENT 'Tread pattern type or code indicating the design optimized for specific road conditions and applications (e.g., highway, regional, on/off-road).',
    `tyre_mileage_km` DECIMAL(18,2) COMMENT 'Total distance in kilometers accumulated by this tyre during its service on the vehicle. Calculated as removal_odometer_reading minus fitment_odometer_reading.',
    `tyre_type` STRING COMMENT 'Construction type of the tyre indicating internal structure and performance characteristics.. Valid values are `radial|bias|run_flat`',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturers warranty coverage for this tyre expires. Nullable if no warranty applies.',
    CONSTRAINT pk_tyre_record PRIMARY KEY(`tyre_record_id`)
) COMMENT 'Master record tracking the lifecycle of individual tyres fitted to road fleet vehicles. Captures tyre serial number, manufacturer, size specification, tyre position on vehicle (axle/position code), fitment date, removal date, tread depth at fitment, current tread depth, mileage at fitment, total mileage accumulated, condition status (serviceable, worn, damaged, retreaded), retreading history, and disposal reason. Enables tyre cost management, safety compliance (minimum tread depth regulations), and predictive replacement scheduling.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`hos_log` (
    `hos_log_id` BIGINT COMMENT 'Unique identifier for the hours-of-service log record. Primary key.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Hours-of-service logs for cross-border drivers may be required as supporting documentation for customs declarations, especially for high-value or time-sensitive shipments. Provides proof-of-transit ti',
    `fatigue_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.fatigue_risk_assessment. Business justification: HOS logs are primary data source for fatigue risk assessments. Real-world process: ELD data (driving hours, rest breaks, violations) feeds fatigue scoring algorithms; assessments reference specific HO',
    `fleet_driver_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.fleet_driver_assignment. Business justification: HOS log entries are generated during specific driver-asset assignments. Linking to fleet_driver_assignment provides the full context of which driver was assigned to which asset for which run when the ',
    `driver_profile_id` BIGINT COMMENT 'Reference to the commercial driver who generated this HOS log entry.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the commercial motor vehicle (truck, tractor, or other CMV) operated during this log period.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Hours-of-service logs are regulatory documents that must be retained for FMCSA compliance and DOT audits. Essential for driver duty status documentation and regulatory compliance verification.',
    `trip_id` BIGINT COMMENT 'Foreign key linking to fleet.trip. Business justification: HOS log entries record driver duty status during trips. Linking to trip provides the operational trip context for each HOS record. hos_log has shipment_reference_number (STRING) but no structured trip',
    `break_compliance_flag` BOOLEAN COMMENT 'Indicates whether the driver has taken the required 30-minute break within the first 8 hours of driving. True if compliant, False if violation detected.',
    `carrier_name` STRING COMMENT 'The legal name of the motor carrier responsible for this HOS log entry.',
    `carrier_usdot_number` STRING COMMENT 'The USDOT number assigned to the motor carrier operating the commercial vehicle. Mandatory for all interstate carriers.. Valid values are `^[0-9]{7,8}$`',
    `certification_flag` BOOLEAN COMMENT 'Indicates whether the driver has certified this log as accurate and complete. True if certified, False if pending certification.',
    `certification_timestamp` TIMESTAMP COMMENT 'The date and time when the driver certified this log entry, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this HOS log record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `cycle_hours_60_7` DECIMAL(18,2) COMMENT 'Cumulative on-duty hours over the preceding 7 days (rolling 7-day period). Used to enforce the 60-hour/7-day cycle limit for carriers operating every day of the week.',
    `cycle_hours_70_8` DECIMAL(18,2) COMMENT 'Cumulative on-duty hours over the preceding 7 days (rolling 8-day period). Used to enforce the 70-hour/8-day cycle limit for carriers not operating every day of the week.',
    `data_source` STRING COMMENT 'Indicates how this log entry was created: automatic (captured by ELD), manual (entered by driver), edited (modified after initial capture).. Valid values are `automatic|manual|edited`',
    `destination_location` STRING COMMENT 'The ending location (city, state, or facility) where the driver concluded the duty period covered by this log.',
    `distance_driven_miles` DECIMAL(18,2) COMMENT 'The total distance driven in miles during the driving duty status segment.',
    `driving_hours_day` DECIMAL(18,2) COMMENT 'Total hours spent in driving status for the current log date. Used to enforce the 11-hour daily driving limit.',
    `duty_status` STRING COMMENT 'The drivers current duty status as defined by FMCSA regulations: off_duty (not working), sleeper_berth (resting in sleeper), driving (operating CMV), on_duty_not_driving (working but not driving).. Valid values are `off_duty|sleeper_berth|driving|on_duty_not_driving`',
    `duty_status_duration_minutes` STRING COMMENT 'The total duration in minutes that the driver remained in this duty status segment.',
    `duty_status_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the driver exited the current duty status, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Null if status is still active.',
    `duty_status_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the driver entered the current duty status, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `edit_flag` BOOLEAN COMMENT 'Indicates whether this log entry has been edited after initial creation. True if edited, False if original.',
    `edit_reason` STRING COMMENT 'The reason provided by the driver or dispatcher for editing this log entry, as required by FMCSA regulations.',
    `edit_timestamp` TIMESTAMP COMMENT 'The date and time when this log entry was last edited, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `eld_device_code` STRING COMMENT 'The unique identifier of the ELD hardware device that captured this log entry. Required for FMCSA ELD mandate compliance.',
    `eld_firmware_version` STRING COMMENT 'The firmware version of the ELD device at the time this log was recorded. Used for audit and compliance verification.',
    `eld_manufacturer` STRING COMMENT 'The name of the manufacturer of the ELD device used to record this log.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'The GPS latitude coordinate of the vehicle at the time of this duty status change, in decimal degrees.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'The GPS longitude coordinate of the vehicle at the time of this duty status change, in decimal degrees.',
    `last_break_timestamp` TIMESTAMP COMMENT 'The date and time when the driver last took a qualifying break (off-duty or sleeper berth of at least 30 minutes), in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this HOS log record was last modified in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `log_date` DATE COMMENT 'The calendar date for which this hours-of-service log applies, in yyyy-MM-dd format.',
    `odometer_end` STRING COMMENT 'The vehicle odometer reading in miles at the end of the duty status segment.',
    `odometer_start` STRING COMMENT 'The vehicle odometer reading in miles at the start of the duty status segment.',
    `on_duty_hours_day` DECIMAL(18,2) COMMENT 'Total hours spent on duty (driving + on-duty not driving) for the current log date. Used to enforce the 14-hour on-duty limit.',
    `origin_location` STRING COMMENT 'The starting location (city, state, or facility) where the driver began the duty period covered by this log.',
    `record_status` STRING COMMENT 'The current lifecycle status of this HOS log record in the system.. Valid values are `active|inactive|archived`',
    `remarks` STRING COMMENT 'Free-text notes or comments entered by the driver or dispatcher regarding this log entry, such as reasons for edits or special circumstances.',
    `shipment_reference_number` STRING COMMENT 'The shipment or load number associated with this duty period, linking the HOS log to freight operations.',
    `trailer_number` STRING COMMENT 'The identification number of the trailer being hauled during this duty period, if applicable.',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether any HOS violation occurred during this log period. True if violation detected, False if compliant.',
    `violation_severity` STRING COMMENT 'The severity classification of the HOS violation for compliance reporting and enforcement prioritization.. Valid values are `minor|moderate|major|critical`',
    `violation_type` STRING COMMENT 'The specific type of HOS violation detected: 11_hour_driving (exceeded 11-hour driving limit), 14_hour_on_duty (exceeded 14-hour on-duty window), 70_hour_8_day (exceeded 70-hour/8-day cycle), 60_hour_7_day (exceeded 60-hour/7-day cycle), 30_min_break (failed to take required break), 10_hour_off_duty (insufficient off-duty time before shift).. Valid values are `11_hour_driving|14_hour_on_duty|70_hour_8_day|60_hour_7_day|30_min_break|10_hour_off_duty`',
    CONSTRAINT pk_hos_log PRIMARY KEY(`hos_log_id`)
) COMMENT 'Transactional record capturing electronic logging device (ELD) hours-of-service data for commercial vehicle drivers in compliance with DOT FMCSA regulations. Tracks driver reference, asset reference, log date, duty status segments (off-duty, sleeper berth, driving, on-duty not driving), driving hours for the day, cumulative 70-hour/8-day cycle hours, break periods, violation flags (HOS breach), ELD device ID, and carrier USDOT number. Mandatory for DOT FMCSA compliance for all commercial motor vehicle operations in the US.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`depot` (
    `depot_id` BIGINT COMMENT 'Unique identifier for the fleet depot. Primary key for the fleet depot entity.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `address_line_1` STRING COMMENT 'Primary street address line for the depot location including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as building name, suite number, or floor.',
    `city` STRING COMMENT 'City or municipality where the depot is located.',
    `commissioning_date` DATE COMMENT 'Date when the depot was officially commissioned and began operational service for fleet management activities.',
    `contact_email` STRING COMMENT 'Primary email address for the depot used for operational communications and administrative correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the depot used for operational coordination and emergency communications.',
    `container_capacity_teu` STRING COMMENT 'Maximum container storage capacity expressed in TEU (Twenty-foot Equivalent Units), applicable for container yards and ICDs.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the depot is located.. Valid values are `^[A-Z]{3}$`',
    `covered_area_sqm` DECIMAL(18,2) COMMENT 'Total covered or indoor area of the depot measured in square meters, including maintenance workshops, warehouses, and covered parking structures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this depot record was first created in the system.',
    `customs_bonded_facility_flag` BOOLEAN COMMENT 'Indicates whether this depot is a customs-bonded facility authorized to store goods under customs supervision without immediate duty payment. Applicable for ICDs and container yards handling international freight.',
    `decommissioning_date` DATE COMMENT 'Date when the depot was or is planned to be decommissioned and removed from active operational service.',
    `depot_code` STRING COMMENT 'Unique business identifier code for the depot used across operational systems and documentation. Typically a short alphanumeric code assigned by the business.. Valid values are `^[A-Z0-9]{3,10}$`',
    `depot_name` STRING COMMENT 'Full business name of the fleet depot, vehicle yard, maintenance workshop, or staging area.',
    `depot_type` STRING COMMENT 'Classification of the depot based on its primary operational function. Vehicle depot for fleet parking and assignment, maintenance workshop for repairs and servicing, fuel station for refueling operations, container yard for container storage, inland container depot (ICD) for customs clearance and container handling, or staging area for temporary asset holding.. Valid values are `vehicle_depot|maintenance_workshop|fuel_station|container_yard|inland_container_depot|staging_area`',
    `electric_charging_stations` STRING COMMENT 'Number of electric vehicle charging stations available at this depot for electric and hybrid fleet assets.',
    `environmental_certification` STRING COMMENT 'Environmental management system certification held by the depot (e.g., ISO 14001, LEED certification) demonstrating compliance with sustainability and environmental protection standards.',
    `ftz_designation` STRING COMMENT 'Free Trade Zone designation or license number if this depot operates within or as an FTZ, allowing duty-deferred or duty-exempt storage and processing of goods.',
    `fuel_types_available` STRING COMMENT 'Comma-separated list of fuel types available at this depot for refueling operations (e.g., diesel, petrol, CNG, LNG, electric charging).',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the depot is certified and equipped to handle, store, and process hazardous materials in compliance with IMDG, IATA Dangerous Goods, and DOT regulations.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety, compliance, or operational inspection conducted at this depot by internal auditors or regulatory authorities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this depot record was most recently updated or modified in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the depot location in decimal degrees format, used for GPS tracking, route planning, and geospatial analytics.',
    `lease_expiry_date` DATE COMMENT 'Date when the current lease agreement for this depot expires, applicable only for leased facilities. Used for lease renewal planning and CAPEX forecasting.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the depot location in decimal degrees format, used for GPS tracking, route planning, and geospatial analytics.',
    `maintenance_bays` STRING COMMENT 'Number of maintenance bays or service stations available at this depot for vehicle and equipment servicing and repairs.',
    `managing_business_unit` STRING COMMENT 'Name or code of the business unit, division, or department responsible for managing and operating this depot.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory safety, compliance, or operational inspection of the depot facility.',
    `notes` STRING COMMENT 'Free-text field for capturing additional operational notes, special instructions, facility constraints, or other relevant information about the depot that does not fit structured fields.',
    `operates_24_7_flag` BOOLEAN COMMENT 'Indicates whether the depot operates continuously 24 hours a day, 7 days a week. True for round-the-clock operations, False for limited operating hours.',
    `operating_hours_end` STRING COMMENT 'Daily end time of depot operations in HH:MM format (24-hour clock). Used for scheduling asset assignments and maintenance activities.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operating_hours_start` STRING COMMENT 'Daily start time of depot operations in HH:MM format (24-hour clock). Used for scheduling asset assignments and maintenance activities.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operational_status` STRING COMMENT 'Current operational status of the depot indicating whether it is actively serving fleet operations, temporarily unavailable, or permanently closed.. Valid values are `active|inactive|under_construction|temporarily_closed|decommissioned|planned`',
    `ownership_type` STRING COMMENT 'Legal ownership or operational arrangement for the depot facility. Owned indicates company-owned property, leased indicates rental arrangement, operated under contract indicates third-party management, joint venture indicates shared ownership.. Valid values are `owned|leased|operated_under_contract|joint_venture`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the depot address used for mail delivery and geographic sorting.',
    `region` STRING COMMENT 'Business-defined geographic region or territory to which this depot belongs for organizational reporting and management purposes.',
    `security_level` STRING COMMENT 'Classification of physical security measures and access controls implemented at the depot. Relevant for high-value asset storage and compliance with C-TPAT and AEO security requirements.. Valid values are `standard|enhanced|high_security|restricted_access`',
    `state_province` STRING COMMENT 'State, province, or administrative region where the depot is located.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the depot location used for scheduling maintenance windows, operating hours, and coordinating cross-regional operations.',
    `total_area_sqm` DECIMAL(18,2) COMMENT 'Total land area of the depot facility measured in square meters, including parking areas, buildings, maintenance bays, and storage yards.',
    `vehicle_capacity` STRING COMMENT 'Maximum number of vehicles (trucks, vans, cars) that can be parked or stored at this depot simultaneously.',
    CONSTRAINT pk_depot PRIMARY KEY(`depot_id`)
) COMMENT 'Master record for all fleet depots, vehicle yards, maintenance workshops, and staging areas that serve as home bases or operational hubs for fleet assets. Captures depot name, depot code, depot type (vehicle depot, maintenance workshop, fuel station, container yard, ICD), address, GPS coordinates, country, region, capacity (number of vehicles/containers), available maintenance bays, fuel types available, operating hours, and managing business unit. Provides the geographic and operational context for asset assignment and maintenance planning.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`asset_type` (
    `asset_type_id` BIGINT COMMENT 'Unique identifier for the asset type classification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Master data governance for asset type definitions requires tracking which employee created asset classifications for data quality accountability, regulatory compliance (IATA/IMO/DOT codes), and audit ',
    `asset_category` STRING COMMENT 'High-level classification of the asset type: road vehicle, aircraft, vessel, rail unit, container, Unit Load Device (ULD), or handling equipment. [ENUM-REF-CANDIDATE: road_vehicle|aircraft|vessel|rail_unit|container|uld|handling_equipment — 7 candidates stripped; promote to reference product]',
    `asset_subcategory` STRING COMMENT 'Detailed subcategory within the asset category (e.g., rigid truck, articulated truck, cargo aircraft, container ship, flatcar, dry container, reefer container). [ENUM-REF-CANDIDATE: rigid_truck|articulated_truck|van|cargo_aircraft|passenger_aircraft|container_ship|bulk_carrier|tanker|flatcar|boxcar|dry_container|reefer_container|tank_container|flat_rack|open_top|pallet|igloo_uld|forklift|reach_stacker — promote to reference product]',
    `asset_type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the asset type (e.g., TRUCK-RIG, CARGO-AC, CONT-20FT). Used as business identifier across systems.. Valid values are `^[A-Z0-9]{3,10}$`',
    `asset_type_description` STRING COMMENT 'Detailed description of the asset type, including technical specifications, typical use cases, and operational characteristics.',
    `asset_type_name` STRING COMMENT 'Full descriptive name of the asset type (e.g., Rigid Truck, Cargo Aircraft, Twenty-Foot Container).',
    `asset_type_status` STRING COMMENT 'Current lifecycle status of this asset type classification: active (in use), inactive (no longer procured but existing assets remain), deprecated (phased out), or under review.. Valid values are `active|inactive|deprecated|under_review`',
    `average_acquisition_cost` DECIMAL(18,2) COMMENT 'Average acquisition cost for this asset type in the base currency, used for budgeting and Capital Expenditure (CAPEX) planning.',
    `certification_interval_months` STRING COMMENT 'Standard interval in months between required certifications for this asset type (e.g., 60 months for CSC container certification).',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether this asset type requires periodic regulatory certification (e.g., CSC for containers, airworthiness for aircraft).',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the average acquisition cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset type record was first created in the system.',
    `depreciation_method` STRING COMMENT 'Standard depreciation method applied to this asset type for financial reporting: straight-line, declining balance, units of production, or not applicable.. Valid values are `straight_line|declining_balance|units_of_production|not_applicable`',
    `dot_classification_code` STRING COMMENT 'US DOT standard classification code for road vehicles and rail units, used for regulatory compliance and safety reporting.. Valid values are `^[A-Z0-9]{2,8}$`',
    `effective_date` DATE COMMENT 'Date from which this asset type classification became effective and available for use in asset master data.',
    `emission_standard` STRING COMMENT 'Applicable emission standard for this asset type (e.g., Euro 6, EPA Tier 4, ICAO Annex 16). [ENUM-REF-CANDIDATE: euro_3|euro_4|euro_5|euro_6|epa_tier_3|epa_tier_4|icao_annex_16|imo_tier_ii|imo_tier_iii — promote to reference product]',
    `end_date` DATE COMMENT 'Date on which this asset type classification was retired or deprecated. Null for active asset types.',
    `fuel_type_standard` STRING COMMENT 'Standard fuel or energy type used by this asset type: diesel, gasoline, electric, hybrid, Liquefied Natural Gas (LNG), Compressed Natural Gas (CNG), hydrogen, or jet fuel. [ENUM-REF-CANDIDATE: diesel|gasoline|electric|hybrid|lng|cng|hydrogen|jet_fuel — 8 candidates stripped; promote to reference product]',
    `hazmat_capable_flag` BOOLEAN COMMENT 'Indicates whether this asset type is certified and equipped to transport hazardous materials under IMDG Code or ICAO Technical Instructions.',
    `iata_classification_code` STRING COMMENT 'IATA standard classification code for aircraft and ULD types, used for air freight operations and regulatory compliance.. Valid values are `^[A-Z0-9]{2,6}$`',
    `imo_classification_code` STRING COMMENT 'IMO standard classification code for vessel types, used for maritime operations and regulatory compliance.. Valid values are `^[A-Z0-9]{2,8}$`',
    `iso_container_code` STRING COMMENT 'ISO 6346 standard container type code (e.g., 22G1 for 20ft dry container, 45R1 for 40ft reefer).. Valid values are `^[A-Z0-9]{2,4}$`',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this asset type record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset type record was last modified in the system.',
    `maintenance_interval_days` STRING COMMENT 'Typical scheduled maintenance interval in days for this asset type under normal operating conditions.',
    `maintenance_interval_hours` STRING COMMENT 'Typical scheduled maintenance interval in operating hours for this asset type (primarily for aircraft and vessels).',
    `maintenance_interval_km` STRING COMMENT 'Typical scheduled maintenance interval in kilometers or nautical miles for this asset type.',
    `ownership_model` STRING COMMENT 'Typical ownership model for this asset type: owned (company-owned), leased (operating or finance lease), mixed, or third-party (contracted).. Valid values are `owned|leased|mixed|third_party`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework governing this asset type: Department of Transportation (DOT), International Civil Aviation Organization (ICAO), International Maritime Organization (IMO), ISO standards, Federal Maritime Commission (FMC), or mixed.. Valid values are `dot|icao|imo|iso|fmc|mixed`',
    `rfid_tagging_standard_flag` BOOLEAN COMMENT 'Indicates whether this asset type is standardly equipped with RFID tags for automated identification and tracking.',
    `standard_height_m` DECIMAL(18,2) COMMENT 'Standard height dimension in meters for this asset type.',
    `standard_length_m` DECIMAL(18,2) COMMENT 'Standard length dimension in meters for this asset type.',
    `standard_payload_capacity_kg` DECIMAL(18,2) COMMENT 'Standard maximum payload capacity in kilograms for this asset type under normal operating conditions.',
    `standard_temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius that this asset type can maintain (for temperature-controlled assets).',
    `standard_temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius that this asset type can maintain (for temperature-controlled assets).',
    `standard_teu_capacity` DECIMAL(18,2) COMMENT 'Standard capacity measured in Twenty-foot Equivalent Units (TEU), primarily used for vessels and rail units.',
    `standard_useful_life_years` STRING COMMENT 'Standard useful life in years for this asset type, used for depreciation and Capital Expenditure (CAPEX) planning.',
    `standard_volume_capacity_cbm` DECIMAL(18,2) COMMENT 'Standard internal volume capacity in cubic meters (CBM) for cargo storage.',
    `standard_width_m` DECIMAL(18,2) COMMENT 'Standard width dimension in meters for this asset type.',
    `telematics_capable_flag` BOOLEAN COMMENT 'Indicates whether this asset type is typically equipped with GPS telematics and IoT sensor capabilities for real-time tracking.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this asset type has built-in temperature control capabilities (reefer containers, refrigerated trucks).',
    CONSTRAINT pk_asset_type PRIMARY KEY(`asset_type_id`)
) COMMENT 'Reference data defining the classification taxonomy for all fleet asset types used by Transport Shipping. Captures asset type code, asset category (road vehicle, aircraft, vessel, rail unit, container, ULD), sub-category (rigid truck, articulated truck, cargo aircraft, container ship, flatcar), IATA/IMO/DOT classification code, standard payload capacity, standard CBM capacity, fuel type standard, applicable regulatory framework (DOT, ICAO, IMO), and typical maintenance interval. Provides standardized classification used across transport_asset, maintenance_schedule, and asset_acquisition.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` (
    `driver_licence_type_id` BIGINT COMMENT 'Unique identifier for the driver licence type record. Primary key.',
    `superseded_by_licence_type_driver_licence_type_id` BIGINT COMMENT 'Reference to the licence type that supersedes this one if deprecated. Null if not superseded.',
    `active_status` STRING COMMENT 'Current status of this licence type in the system (active, inactive, deprecated, pending).. Valid values are `active|inactive|deprecated|pending`',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a criminal background check is required to obtain this licence type (True/False).',
    `compliance_notes` STRING COMMENT 'Additional compliance requirements, restrictions, or notes specific to this licence type.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this licence type record was first created in the system.',
    `double_triple_trailer_eligible` BOOLEAN COMMENT 'Indicates whether this licence type is eligible for double or triple trailer endorsement (True/False).',
    `effective_date` DATE COMMENT 'Date from which this licence type definition became effective in the system.',
    `expiry_date` DATE COMMENT 'Date on which this licence type definition expires or was deprecated. Null if currently active.',
    `flight_hours_required` DECIMAL(18,2) COMMENT 'Minimum number of flight hours required for aviation licences. Null if not applicable.',
    `hazmat_endorsement_eligible` BOOLEAN COMMENT 'Indicates whether this licence type is eligible for hazardous materials endorsement (True/False).',
    `international_recognition_scope` STRING COMMENT 'Description of international recognition scope (e.g., ICAO member states, EU member states, bilateral agreements). Null if not internationally recognized.',
    `issuing_country` STRING COMMENT 'Three-letter ISO country code of the issuing authority (e.g., USA, GBR, DEU, CAN).. Valid values are `^[A-Z]{3}$`',
    `issuing_jurisdiction` STRING COMMENT 'Country or state/province code where this licence type is issued (e.g., USA-CA, GBR, DEU, CAN-ON). Uses ISO 3166-1 alpha-3 country codes with optional subdivision.. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{2,5})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this licence type record was last modified.',
    `licence_category_name` STRING COMMENT 'Full descriptive name of the licence category (e.g., Commercial Drivers License Class A, Airline Transport Pilot Licence, Officer of the Watch Unlimited).',
    `licence_class` STRING COMMENT 'Standardized classification of the licence type for grouping and filtering (e.g., Class A, Class B, ATPL, CPL, MCA OOW). [ENUM-REF-CANDIDATE: class_a|class_b|class_c|atpl|cpl|ppl|mca_oow|mca_master|other — 9 candidates stripped; promote to reference product]',
    `licence_type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the licence type within the system (e.g., CDL-A, CDL-B, ATPL, CPL, OOW).. Valid values are `^[A-Z0-9]{2,10}$`',
    `licence_validity_period_years` STRING COMMENT 'Standard validity period in years for this licence type before renewal is required. Null if indefinite or variable.',
    `max_vehicle_weight_kg` DECIMAL(18,2) COMMENT 'Maximum gross vehicle weight in kilograms that this licence type permits the holder to operate. Null if not applicable to the transport mode.',
    `medical_certificate_class` STRING COMMENT 'Class or type of medical certificate required (e.g., Class 1, Class 2, DOT Medical Examiner Certificate). Null if no medical certificate required.',
    `medical_certificate_required` BOOLEAN COMMENT 'Indicates whether a valid medical certificate is required to hold this licence type (True/False).',
    `medical_renewal_interval_months` STRING COMMENT 'Frequency in months at which the medical certificate must be renewed. Null if no medical certificate required.',
    `minimum_age_years` STRING COMMENT 'Minimum age in years required to hold this licence type.',
    `passenger_capacity_permitted` STRING COMMENT 'Maximum number of passengers the licence holder is permitted to transport. Null if not applicable.',
    `practical_exam_required` BOOLEAN COMMENT 'Indicates whether a practical skills examination is required to obtain this licence type (True/False).',
    `reciprocity_recognized` BOOLEAN COMMENT 'Indicates whether this licence type is recognized under reciprocity agreements with other jurisdictions (True/False).',
    `regulation_reference` STRING COMMENT 'Specific regulation, code, or legal reference governing this licence type (e.g., 49 CFR Part 383, ICAO Annex 1, STCW Convention Chapter II).',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority governing this licence type (e.g., DOT FMCSA, ICAO, MCA, Transport Canada).',
    `renewal_grace_period_days` STRING COMMENT 'Number of days after expiry during which the licence can be renewed without re-examination. Null if no grace period.',
    `sea_service_months_required` STRING COMMENT 'Minimum number of months of sea service required for maritime licences. Null if not applicable.',
    `tanker_endorsement_eligible` BOOLEAN COMMENT 'Indicates whether this licence type is eligible for tanker vehicle endorsement (True/False).',
    `training_hours_required` DECIMAL(18,2) COMMENT 'Minimum number of training hours required to qualify for this licence type. Null if not specified.',
    `transport_mode` STRING COMMENT 'Primary mode of transport this licence type applies to (road, air, sea, rail, multimodal).. Valid values are `road|air|sea|rail|multimodal`',
    `vehicle_types_permitted` STRING COMMENT 'Comma-separated list of vehicle, aircraft, or vessel types this licence permits operation of (e.g., combination vehicles, tanker trucks, Boeing 737, container vessels).',
    `written_exam_required` BOOLEAN COMMENT 'Indicates whether a written examination is required to obtain this licence type (True/False).',
    CONSTRAINT pk_driver_licence_type PRIMARY KEY(`driver_licence_type_id`)
) COMMENT 'Reference data defining the classification of commercial driver licence categories, endorsements, and certifications recognized across jurisdictions where Transport Shipping operates. Captures licence type code, licence category name (CDL Class A, CDL Class B, ATPL, CPL, MCA OOW), issuing jurisdiction/country, vehicle/aircraft/vessel types permitted, hazmat endorsement eligibility, minimum age requirement, medical certificate requirement, and applicable regulatory body (DOT FMCSA, ICAO, MCA). Used to validate driver_profile licence compliance against asset_assignment requirements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` (
    `geofence_zone_id` BIGINT COMMENT 'Unique identifier for the geofence zone. Primary key for the geofence zone master record.',
    `facility_id` BIGINT COMMENT 'Reference to the facility or depot associated with this geofence zone. Used for depot perimeter zones and facility-based monitoring. Null for non-facility zones.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Geofence zones with hazmat restrictions, speed limits, emission standards, or access controls are defined by hazard assessments. Real-world process: hazard register identifies risk (e.g., school zone,',
    `parent_zone_geofence_zone_id` BIGINT COMMENT 'Reference to a parent geofence zone if this zone is nested within a larger zone. Supports hierarchical zone structures. Null for top-level zones.',
    `access_restriction_level` STRING COMMENT 'Level of access control enforced for this zone. Values: unrestricted (open access), authorized_only (requires authorization), permit_required (requires permit or credential), prohibited (no entry allowed).. Valid values are `unrestricted|authorized_only|permit_required|prohibited`',
    `active_status` STRING COMMENT 'Current operational status of the geofence zone. Values: active (zone is operational and monitored), inactive (zone is not currently enforced), suspended (temporarily disabled), planned (zone defined but not yet active).. Valid values are `active|inactive|suspended|planned`',
    `applicable_asset_types` STRING COMMENT 'Comma-separated list of transport asset types to which this geofence zone applies. Examples: truck, van, container, vessel, aircraft. Used to filter zone monitoring by asset category.',
    `boundary_geometry` STRING COMMENT 'Geographic boundary definition of the zone stored as GeoJSON polygon coordinates. Contains latitude/longitude coordinate pairs defining the zone perimeter for geospatial matching against GPS telematics data.',
    `center_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the zones geographic center point in decimal degrees. Used for proximity calculations and zone visualization.',
    `center_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the zones geographic center point in decimal degrees. Used for proximity calculations and zone visualization.',
    `city_name` STRING COMMENT 'Name of the city or municipality where the zone is located. Used for geographic reporting and operational planning.',
    `coordinate_system` STRING COMMENT 'Geographic coordinate reference system used for boundary geometry. Standard values: WGS84 (World Geodetic System 1984 - global standard), NAD83 (North American Datum 1983), ETRS89 (European Terrestrial Reference System 1989).. Valid values are `WGS84|NAD83|ETRS89`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the zone is located. Examples: USA, GBR, DEU, CHN. Used for jurisdictional compliance and reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this geofence zone record was first created in the system. Used for audit trail and data lineage.',
    `curfew_end_time` TIMESTAMP COMMENT 'Time of day when curfew restrictions end within the zone. Format: HH:MM (24-hour). Null if no curfew applies.',
    `curfew_start_time` TIMESTAMP COMMENT 'Time of day when curfew restrictions begin within the zone. Format: HH:MM (24-hour). Null if no curfew applies.',
    `dwell_time_threshold_minutes` STRING COMMENT 'Maximum permitted dwell time within the zone in minutes before an alert is triggered. Used for monitoring loading/unloading efficiency and unauthorized stops. Null if no dwell time restriction applies.',
    `effective_date` DATE COMMENT 'Date when the geofence zone becomes or became active and enforceable. Used for historical tracking and compliance reporting.',
    `emission_standard_required` STRING COMMENT 'Minimum vehicle emission standard required for entry into the zone. Values: EURO_3, EURO_4, EURO_5, EURO_6 (European standards), EPA_2007, EPA_2010 (US EPA standards). Used for low emission zone compliance.. Valid values are `EURO_3|EURO_4|EURO_5|EURO_6|EPA_2007|EPA_2010`',
    `entry_alert_enabled` BOOLEAN COMMENT 'Indicates whether real-time alerts should be generated when an asset enters this zone. True triggers telematics event notifications for zone entry.',
    `exit_alert_enabled` BOOLEAN COMMENT 'Indicates whether real-time alerts should be generated when an asset exits this zone. True triggers telematics event notifications for zone exit.',
    `expiry_date` DATE COMMENT 'Date when the geofence zone is scheduled to expire or be deactivated. Null for permanent zones. Used for temporary zone management.',
    `hazmat_classes_prohibited` STRING COMMENT 'Comma-separated list of UN hazmat classes prohibited in this zone. Examples: 1 (explosives), 2.1 (flammable gases), 7 (radioactive materials). Null if no hazmat restrictions apply.',
    `hazmat_restriction_flag` BOOLEAN COMMENT 'Indicates whether transport of hazardous materials is restricted or prohibited within this zone. True means hazmat restrictions apply.',
    `height_limit_meters` DECIMAL(18,2) COMMENT 'Maximum vehicle height permitted within the zone in meters. Used for tunnel and bridge clearance compliance. Null if no height restriction applies.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this geofence zone record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this geofence zone record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or context about the geofence zone. Used for documentation and knowledge transfer.',
    `operational_hours` STRING COMMENT 'Operating hours or time windows when the zone restrictions are active. Format: Mon-Fri 06:00-22:00 or 24/7. Used for time-based compliance monitoring.',
    `postal_code` STRING COMMENT 'Postal or ZIP code associated with the zone location. Used for address-based routing and regional analysis.',
    `priority_level` STRING COMMENT 'Business priority level for monitoring and alert escalation. Values: critical (immediate action required), high (urgent attention), medium (standard monitoring), low (informational only).. Valid values are `critical|high|medium|low`',
    `regulatory_authority` STRING COMMENT 'Name of the governing body or authority that enforces regulations for this zone. Examples: Port Authority of New York and New Jersey, Transport for London, US Customs and Border Protection, ICAO.',
    `regulatory_basis` STRING COMMENT 'Legal or regulatory framework that mandates or governs this geofence zone. Examples: EU Regulation 2016/679 (GDPR), IMO SOLAS Chapter XI-2, US DOT FMCSA Hours of Service, London LEZ Regulations 2008. Used for compliance tracking and audit trails.',
    `speed_limit_kmh` STRING COMMENT 'Maximum permitted speed within the zone in kilometers per hour. Used for speed compliance monitoring and driver safety alerts. Null if no speed restriction applies.',
    `state_province_code` STRING COMMENT 'State or province code within the country where the zone is located. Examples: CA (California), NY (New York), ON (Ontario). Used for regional compliance and reporting.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the zone location. Examples: America/New_York, Europe/London, Asia/Shanghai. Used for timestamp normalization and scheduling.',
    `weight_limit_kg` STRING COMMENT 'Maximum gross vehicle weight permitted within the zone in kilograms. Used for bridge and road weight restriction compliance. Null if no weight restriction applies.',
    `zone_area_sqkm` DECIMAL(18,2) COMMENT 'Total geographic area covered by the zone in square kilometers. Calculated from boundary geometry for reporting and capacity planning.',
    `zone_code` STRING COMMENT 'Unique business identifier code for the geofence zone used in operational systems and reporting. Alphanumeric code following organizational naming standards.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `zone_name` STRING COMMENT 'Human-readable name of the geofence zone for display and operational reference. Examples: JFK Airport Perimeter, London Low Emission Zone, Port of Rotterdam Customs Area.',
    `zone_radius_meters` DECIMAL(18,2) COMMENT 'Approximate radius of the zone in meters from the center point. Used for circular geofence zones or as a reference dimension for polygon zones.',
    `zone_subtype` STRING COMMENT 'Secondary classification providing additional granularity for the zone type. Examples: ULEZ (Ultra Low Emission Zone), CAZ (Clean Air Zone), AEO Facility, Bonded Warehouse.',
    `zone_type` STRING COMMENT 'Classification of the geofence zone by operational purpose. Values: depot_perimeter (facility boundary), restricted_area (access-controlled zone), customs_zone (customs inspection area), ftz (Free Trade Zone), low_emission_zone (environmental compliance zone), speed_restriction_zone (speed limit enforcement area). [ENUM-REF-CANDIDATE: depot_perimeter|restricted_area|customs_zone|ftz|low_emission_zone|speed_restriction_zone|curfew_zone|port_authority_zone|hazmat_restricted_zone|weigh_station_zone|border_crossing_zone — promote to reference product]. Valid values are `depot_perimeter|restricted_area|customs_zone|ftz|low_emission_zone|speed_restriction_zone`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this geofence zone record. Used for audit trail and accountability.',
    CONSTRAINT pk_geofence_zone PRIMARY KEY(`geofence_zone_id`)
) COMMENT 'Master record defining geographic boundary zones used for fleet telematics monitoring, compliance enforcement, and operational control. Captures zone name, zone type (depot perimeter, restricted area, customs zone, FTZ, low-emission zone, speed restriction zone, curfew zone), polygon boundary coordinates (GeoJSON), applicable asset types, speed limit within zone, entry/exit alert rules, regulatory basis (e.g., EU LEZ regulations, port authority rules), and active status. Drives geofence entry/exit events in telematics_event and supports route compliance monitoring.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` (
    `asset_cost_record_id` BIGINT COMMENT 'Unique identifier for the asset cost record. Primary key for this transactional cost event.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fleet cost approval workflows require tracking which employee authorized expenditures for budget controls, variance analysis, and financial audit trails. Text field approved_by should be replaced wi',
    `carrier_payable_id` BIGINT COMMENT 'Foreign key linking to billing.carrier_payable. Business justification: Asset operating costs incurred by third-party carriers are reconciled against carrier payables. Real business process: carrier cost reconciliation and settlement. Enables matching asset-specific costs',
    `maintenance_order_id` BIGINT COMMENT 'Reference to the maintenance work order that generated this cost, if applicable. Links to maintenance_order in fleet domain.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or service provider who performed the service or supplied the goods. Links to vendor/supplier master data in procurement domain.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the fleet asset (vehicle, aircraft, vessel, container) that incurred this cost. Links to transport_asset or container_unit in the fleet domain.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Cost records reference invoices, receipts, and payment documents that must be linked for financial audit and expense reconciliation. Required for asset cost accounting and audit trail documentation.',
    `approval_date` DATE COMMENT 'The date this cost record was approved for payment.',
    `approval_status` STRING COMMENT 'Current approval status of this cost record in the workflow. Tracks whether the cost has been reviewed and approved for payment.. Valid values are `pending|approved|rejected|auto_approved`',
    `budget_code` STRING COMMENT 'The budget line or project code against which this cost is tracked for budget variance analysis.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the cost event before any adjustments, in the specified currency.',
    `cost_category` STRING COMMENT 'Classification of the operational expenditure type. Maintenance covers repairs and servicing; tyre_replacement for tyre costs; insurance for premiums; toll for road tolls; THC (Terminal Handling Charge) for port/terminal fees; parking for parking fees; cleaning for vehicle cleaning; inspection for regulatory inspections. Fuel costs are tracked separately in fuel_transaction. [ENUM-REF-CANDIDATE: maintenance|tyre_replacement|insurance|toll|thc|parking|cleaning|inspection — 8 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'The finance cost center to which this expense is allocated for budgeting and P&L tracking. Links to finance domain cost center master data.',
    `cost_date` DATE COMMENT 'The business date when the cost event occurred or the service was performed. This is the principal business event timestamp for this transaction.',
    `cost_description` STRING COMMENT 'Detailed textual description of the cost event, service performed, or goods supplied. Provides context for the expenditure.',
    `cost_record_number` STRING COMMENT 'Externally-known unique business identifier for this cost record, used for tracking and reference in financial systems and vendor communications.. Valid values are `^ACR-[0-9]{10}$`',
    `cost_subcategory` STRING COMMENT 'Detailed subcategory within the cost category for granular expense tracking (e.g., engine_repair, brake_service, hull_insurance, congestion_charge).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost record was first created in the system. Audit trail field for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `engine_hours` DECIMAL(18,2) COMMENT 'The cumulative engine operating hours of the asset at the time the cost was incurred. Relevant for aircraft, vessels, and heavy equipment.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which this cost is recognized (e.g., 1-12 for months, 1-4 for quarters).',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this cost is recognized for financial reporting purposes (e.g., 2024).',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this cost is posted in the financial system for accounting and reporting purposes.',
    `insurance_claim_flag` BOOLEAN COMMENT 'Indicates whether this cost is covered under insurance and a claim has been filed. True if insurance claim applies, False otherwise.',
    `insurance_claim_number` STRING COMMENT 'The insurance claim reference number if this cost is being recovered under an insurance policy.',
    `invoice_date` DATE COMMENT 'The date the vendor invoice was issued.',
    `invoice_number` STRING COMMENT 'The supplier invoice number associated with this cost event, used for invoice reconciliation and audit trail. Links to procurement/AP domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost record was last updated or modified. Audit trail field for record changes.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this cost record for audit trail and context.',
    `odometer_reading` DECIMAL(18,2) COMMENT 'The odometer or mileage reading of the asset at the time the cost was incurred, in kilometers. Used for cost-per-km analysis.',
    `payment_date` DATE COMMENT 'The date the payment was made to the vendor for this cost, if applicable.',
    `payment_reference` STRING COMMENT 'The payment transaction reference or check number used to pay this cost, for reconciliation purposes.',
    `payment_status` STRING COMMENT 'Current payment status of this cost record. Tracks whether the invoice has been paid, is pending payment, overdue, under dispute, or cancelled.. Valid values are `pending|paid|overdue|disputed|cancelled`',
    `purchase_order_number` STRING COMMENT 'The purchase order number authorizing this expenditure, if applicable. Links to procurement domain.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of items or units associated with this cost (e.g., number of tyres replaced, hours of labor, liters of cleaning fluid).',
    `service_location` STRING COMMENT 'The location (depot, workshop, port, terminal) where the service was performed or the cost was incurred.',
    `service_location_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the service location (e.g., USA, GBR, CHN).. Valid values are `^[A-Z]{3}$`',
    `source_record_reference` STRING COMMENT 'The unique identifier of this cost record in the source system, used for traceability and reconciliation.',
    `source_system` STRING COMMENT 'The operational system from which this cost record originated (e.g., SAP TM, Coupa, Oracle TMS, Manhattan WMS).',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to this cost (VAT, GST, sales tax, etc.), in the specified currency.',
    `total_cost_amount` DECIMAL(18,2) COMMENT 'The net total cost including all taxes and adjustments, in the specified currency. Represents the final amount paid or accrued.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of measure, calculated as cost_amount divided by quantity. Used for rate analysis and benchmarking.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity field (e.g., each, hours, liters, kg).',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this cost is covered under warranty and a claim has been filed. True if warranty claim applies, False otherwise.',
    `warranty_claim_number` STRING COMMENT 'The warranty claim reference number if this cost is being recovered under manufacturer or supplier warranty.',
    CONSTRAINT pk_asset_cost_record PRIMARY KEY(`asset_cost_record_id`)
) COMMENT 'Transactional record capturing all OPEX cost events associated with individual fleet assets beyond fuel (which is tracked in fuel_transaction). Covers maintenance costs, tyre replacements, insurance premiums, road tolls, port/terminal handling charges (THC), parking fees, cleaning costs, and miscellaneous operational expenses. Tracks asset reference, cost category, cost date, amount, currency, cost centre reference (links to finance domain), supplier invoice reference (links to procurement domain), and GL account code. Enables per-asset total cost of ownership (TCO) analysis and OPEX budget tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` (
    `reefer_monitoring_id` BIGINT COMMENT 'Unique identifier for the reefer monitoring record. Primary key for the reefer monitoring transactional event.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment being transported in this reefer unit. Links monitoring data to the specific cargo movement.',
    `container_unit_id` BIGINT COMMENT 'Reference to the refrigerated container unit being monitored. Links to the container master data.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Temperature-controlled shipments (food, pharmaceuticals) require continuous monitoring data to be submitted with customs declarations as proof of cold-chain integrity. Regulatory requirement for peris',
    `transport_asset_id` BIGINT COMMENT 'Reference to the temperature-controlled vehicle or asset being monitored. Used when monitoring vehicle-based reefer units rather than containers.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Temperature-controlled shipments require monitoring reports and compliance certificates for regulatory compliance and insurance claims. Essential for cold chain documentation, FDA compliance, and temp',
    `actual_temperature_c` DECIMAL(18,2) COMMENT 'Actual measured temperature in Celsius at the primary sensor location. Primary metric for cold-chain compliance verification.',
    `alarm_flag` BOOLEAN COMMENT 'Indicates whether any alarm condition has been triggered. Primary indicator for exception management and immediate response requirements.',
    `alarm_severity` STRING COMMENT 'Severity level of the alarm condition. Determines escalation procedures and response time requirements.. Valid values are `critical|high|medium|low`',
    `alarm_type` STRING COMMENT 'Classification of the alarm condition that was triggered. Enables prioritized response and root cause analysis.. Valid values are `temperature_excursion|power_failure|door_open|humidity_deviation|equipment_malfunction|sensor_fault`',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'External environmental temperature outside the reefer unit. Used to assess refrigeration load and equipment performance under varying conditions.',
    `battery_level_percent` DECIMAL(18,2) COMMENT 'Remaining battery charge percentage for battery-powered monitoring devices. Critical for ensuring continuous monitoring capability.',
    `cargo_type` STRING COMMENT 'Classification of cargo being transported. Different cargo types have different temperature tolerance requirements and compliance standards.. Valid values are `pharmaceutical|perishable_food|frozen_food|fresh_produce|chemicals|biologics`',
    `co2_level_ppm` STRING COMMENT 'Carbon dioxide concentration in parts per million. Used for modified atmosphere containers transporting fresh produce and perishables.',
    `communication_method` STRING COMMENT 'Method by which the monitoring data was transmitted from the reefer unit to the central system.. Valid values are `satellite|cellular|wifi|manual`',
    `compliance_status` STRING COMMENT 'Assessment of whether this monitoring record meets cold-chain compliance requirements. Used for regulatory reporting and quality assurance.. Valid values are `compliant|non_compliant|warning|under_review`',
    `compressor_running_flag` BOOLEAN COMMENT 'Indicates whether the refrigeration compressor is currently running. Used for equipment performance analysis and energy consumption tracking.',
    `data_quality_flag` STRING COMMENT 'Quality assessment of the monitoring data. Identifies readings that may be unreliable due to sensor issues or communication problems.. Valid values are `valid|suspect|invalid|estimated`',
    `defrost_cycle_active_flag` BOOLEAN COMMENT 'Indicates whether the unit is currently in a defrost cycle. Defrost cycles temporarily raise temperature and must be tracked for compliance.',
    `door_open_flag` BOOLEAN COMMENT 'Indicates whether the reefer unit door is currently open. Door openings cause temperature fluctuations and must be tracked.',
    `excursion_duration_minutes` STRING COMMENT 'Cumulative duration in minutes that temperature has been outside acceptable range. Used to determine cargo viability and insurance claims.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the reefer unit at time of reading. Enables location-based cold-chain analysis.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the reefer unit at time of reading. Enables location-based cold-chain analysis.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage inside the reefer unit. Critical for perishable goods that require specific moisture levels.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Date and time when this monitoring record was received and ingested into the central data platform. Used for data latency analysis.',
    `monitoring_timestamp` TIMESTAMP COMMENT 'Date and time when the temperature and environmental readings were captured by the monitoring system. Critical for cold-chain compliance audit trails.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when shipper notification was sent. Used to measure notification response time and SLA compliance.',
    `o2_level_percent` DECIMAL(18,2) COMMENT 'Oxygen concentration percentage. Monitored in controlled atmosphere containers to extend shelf life of fresh produce.',
    `power_source_status` STRING COMMENT 'Current power source supplying the refrigeration unit. Critical for identifying power interruptions that could compromise cargo.. Valid values are `plugged_in|genset|battery|offline`',
    `power_voltage` DECIMAL(18,2) COMMENT 'Electrical voltage being supplied to the reefer unit. Used for power quality monitoring and equipment diagnostics.',
    `regulatory_regime` STRING COMMENT 'Applicable regulatory framework governing this cold-chain shipment. Determines compliance thresholds and documentation requirements.. Valid values are `fda|eu_gdp|who_prequalification|haccp|fsma`',
    `return_air_temperature_c` DECIMAL(18,2) COMMENT 'Temperature of air returning from the cargo space to the refrigeration unit. Indicates cargo heat load and circulation effectiveness.',
    `sensor_code` STRING COMMENT 'Unique identifier of the physical sensor device that captured this reading. Enables sensor-level diagnostics and calibration tracking.',
    `setpoint_temperature_c` DECIMAL(18,2) COMMENT 'Target temperature in Celsius that the reefer unit is configured to maintain. Defined by shipper requirements and cargo specifications.',
    `shipper_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the shipper has been notified of an alarm or exception condition. Tracks compliance with customer notification Service Level Agreements (SLAs).',
    `source_system` STRING COMMENT 'Name of the source system or IoT platform that generated this monitoring record. Enables multi-vendor integration and data lineage tracking.',
    `supply_air_temperature_c` DECIMAL(18,2) COMMENT 'Temperature of air being supplied into the cargo space by the refrigeration unit. Used for advanced diagnostics and airflow analysis.',
    `temperature_deviation_c` DECIMAL(18,2) COMMENT 'Calculated difference between setpoint and actual temperature. Positive values indicate warmer than setpoint, negative indicates colder.',
    CONSTRAINT pk_reefer_monitoring PRIMARY KEY(`reefer_monitoring_id`)
) COMMENT 'Transactional record capturing continuous temperature and humidity monitoring data for refrigerated (reefer) containers and temperature-controlled vehicles. Tracks container/asset reference, monitoring datetime, set point temperature, actual temperature (multiple sensor zones), humidity reading, CO2 level (for modified atmosphere containers), power source status (plugged-in/genset/battery), alarm flag, alarm type (temperature excursion, power failure, door open), and shipper notification sent flag. Critical for pharmaceutical, perishable food, and cold-chain logistics compliance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`toll_record` (
    `toll_record_id` BIGINT COMMENT 'Unique identifier for the toll transaction record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Toll transactions for carrier-operated assets must track carrier for cost allocation, reimbursement processing, and carrier settlement. Essential for accurate freight costing, carrier invoice reconcil',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Toll expenses must be allocated to cost centers for route cost analysis and budget tracking; removes denormalized cost_center_code in favor of proper FK for GL posting integration.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Toll records on cross-border routes provide independent proof-of-transit for customs purposes, supporting duty drawback claims and verifying declared routes. Used in customs audits to validate shipmen',
    `driver_profile_id` BIGINT COMMENT 'Reference to the driver operating the vehicle at the time of the toll event.',
    `freight_order_id` BIGINT COMMENT 'Reference to the freight order or shipment associated with this toll event, enabling cost allocation to specific customer shipments.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Toll costs are passed through to customers as accessorial charges on freight invoices. Real business process: toll cost recovery billing. Enables tracking which customer invoice includes specific toll',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Toll records must be allocated to freight order route plans for customer billing, cost recovery, and route profitability analysis—standard practice in transport cost accounting.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Toll costs may be governed by toll service provider agreements or customer contracts specifying toll reimbursement terms. Finance allocates toll costs to correct contract for billing recovery and vali',
    `transport_asset_id` BIGINT COMMENT 'Reference to the fleet vehicle, vessel, or aircraft that incurred the toll charge.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Toll transactions generate invoices and receipts from toll operators that must be linked for expense reconciliation and cost allocation. Required for toll expense management and financial reconciliati',
    `trip_id` BIGINT COMMENT 'Reference to the specific trip or route execution during which the toll was incurred.',
    `axle_count` STRING COMMENT 'Number of axles on the vehicle as recorded by the toll system, which may affect the toll rate for heavy vehicles.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the toll transaction, supporting multi-currency fleet operations.. Valid values are `^[A-Z]{3}$`',
    `direction_of_travel` STRING COMMENT 'Direction of travel through the toll point, relevant for directional tolls and route analysis.. Valid values are `northbound|southbound|eastbound|westbound|inbound|outbound`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to the toll charge due to fleet agreements, transponder usage, or volume commitments.',
    `dispute_date` DATE COMMENT 'Date when the dispute was raised with the toll operator, in yyyy-MM-dd format.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the toll charge is under dispute with the toll operator (True/False).',
    `dispute_reason` STRING COMMENT 'Reason for disputing the toll charge, such as incorrect vehicle classification, duplicate charge, or system error.',
    `gl_account_code` STRING COMMENT 'General ledger account code for toll expenses, used for financial accounting and reporting in the ERP system.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Date and time when the toll record was ingested into the data platform, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `invoice_date` DATE COMMENT 'Date the toll invoice was issued by the operator, in yyyy-MM-dd format.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the toll point, supporting geospatial analysis and route optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the toll point, supporting geospatial analysis and route optimization.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the toll transaction, such as special circumstances, manual adjustments, or audit findings.',
    `payment_date` DATE COMMENT 'Date when payment was made to the toll operator, in yyyy-MM-dd format.',
    `payment_due_date` DATE COMMENT 'Date by which payment is due to the toll operator, in yyyy-MM-dd format.',
    `payment_method` STRING COMMENT 'Method used to pay the toll: electronic transponder, cash, credit card, fleet account, or invoice billing.. Valid values are `transponder|cash|credit_card|fleet_account|invoice`',
    `payment_reference` STRING COMMENT 'Payment reference number or transaction ID from the accounts payable system, linking the toll charge to the payment record.',
    `payment_status` STRING COMMENT 'Current payment status of the toll charge: pending, paid, disputed, overdue, waived, or refunded.. Valid values are `pending|paid|disputed|overdue|waived|refunded`',
    `source_system` STRING COMMENT 'Name of the source system or toll operator platform from which the toll record was ingested (e.g., E-ZPass, Telepass, TMS integration).',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Additional surcharge applied to the toll, such as peak-hour surcharge, heavy vehicle surcharge, or environmental levy.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Value-added tax (VAT), goods and services tax (GST), or other applicable taxes on the toll charge.',
    `toll_amount` DECIMAL(18,2) COMMENT 'Base toll charge amount before any adjustments, discounts, or surcharges.',
    `toll_city` STRING COMMENT 'City or municipality where the toll was incurred, particularly relevant for urban congestion charges.',
    `toll_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the toll was incurred, supporting multi-country fleet operations and tax reporting.. Valid values are `^[A-Z]{3}$`',
    `toll_invoice_number` STRING COMMENT 'Invoice number issued by the toll operator for account-based or post-paid toll transactions, used for accounts payable reconciliation.',
    `toll_location_code` STRING COMMENT 'Standardized code or identifier for the toll location used for reporting and cost analysis by route segment.',
    `toll_location_name` STRING COMMENT 'Name of the specific toll location, road segment, bridge, tunnel, port gate, or congestion zone where the charge was incurred.',
    `toll_location_type` STRING COMMENT 'Classification of the toll point: road toll, bridge toll, tunnel toll, port access charge, congestion charge zone, or border crossing fee.. Valid values are `road|bridge|tunnel|port|congestion_zone|border_crossing`',
    `toll_operator_code` STRING COMMENT 'Standardized code or identifier for the toll operator used for accounts payable processing and vendor reconciliation.',
    `toll_operator_name` STRING COMMENT 'Name of the toll authority, road operator, port authority, or congestion charge agency that levied the charge.',
    `toll_plaza_lane` STRING COMMENT 'Specific lane number or identifier at the toll plaza where the transaction occurred, used for audit and dispute resolution.',
    `toll_state_province` STRING COMMENT 'State, province, or administrative region where the toll was incurred, used for regional cost analysis and compliance reporting.',
    `toll_transaction_number` STRING COMMENT 'External transaction identifier provided by the toll operator or payment system for reconciliation and audit purposes.',
    `total_toll_amount` DECIMAL(18,2) COMMENT 'Net total toll charge including base toll, surcharges, discounts, and taxes. This is the final amount payable to the toll operator.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the toll transaction occurred, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). This is the principal business event time for the toll charge.',
    `transponder_code` STRING COMMENT 'Unique identifier of the electronic toll collection transponder or RFID tag used for automatic toll payment.',
    `vehicle_class` STRING COMMENT 'Toll operators classification of the vehicle (e.g., Class 2, Class 5, heavy goods vehicle) used to determine the toll rate.',
    CONSTRAINT pk_toll_record PRIMARY KEY(`toll_record_id`)
) COMMENT 'Transactional record capturing road toll, congestion charge, bridge/tunnel fee, and port access charge events incurred by fleet vehicles. Tracks asset reference, driver reference, toll operator, toll location (road/bridge/tunnel name, country), transaction datetime, toll amount, currency, payment method (transponder, cash, account), transponder ID, and associated trip/freight order reference. Enables accurate toll cost allocation to shipments and freight orders, and supports accounts payable reconciliation with toll operators.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` (
    `asset_insurance_id` BIGINT COMMENT 'Unique identifier for the asset insurance policy record. Primary key for the asset insurance master data.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Insurance policies for carrier-operated assets (especially leased or subcontracted) must track carrier for coverage verification, claims processing, and liability determination. Critical for risk mana',
    `container_unit_id` BIGINT COMMENT 'Reference to the specific container unit covered by this insurance policy. Null if this is a fleet-wide blanket policy or covers non-container assets.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Insurance premiums are operating expenses that must be allocated to cost centers for budget management; removes denormalized cost_center_code in favor of proper FK for financial reporting.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Insurance policies ARE contracts. Risk management links insurance coverage to governing insurance agreement for premium tracking, claims management, coverage verification, and regulatory compliance. E',
    `transport_asset_id` BIGINT COMMENT 'Reference to the specific transport asset covered by this insurance policy. Null if this is a fleet-wide blanket policy not tied to a single asset.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Insurance policies are legal documents that must be linked to insured assets for claims processing, compliance verification, and certificate of insurance issuance. Critical for insurance management an',
    `aggregate_limit` DECIMAL(18,2) COMMENT 'The maximum total amount the insurer will pay for all claims during the policy period. Once reached, no further claims are covered until renewal.',
    `broker_name` STRING COMMENT 'The name of the insurance broker or intermediary who arranged the policy, if applicable.',
    `broker_reference` STRING COMMENT 'The brokers internal reference number for this policy. Used for coordination with the broker on claims and renewals.',
    `cancellation_date` DATE COMMENT 'The date when the policy was cancelled, if applicable. Null for active policies.',
    `cancellation_reason` STRING COMMENT 'The reason for policy cancellation, if applicable. Examples: non-payment of premium, asset disposal, insurer cancellation, policyholder request, regulatory non-compliance.',
    `certificate_number` STRING COMMENT 'The certificate of insurance number issued as proof of coverage. Often required for regulatory compliance and customer contracts.',
    `claims_history_count` STRING COMMENT 'The total number of claims filed against this policy since inception. Used for risk assessment and premium calculation at renewal.',
    `coverage_end_date` DATE COMMENT 'The date when insurance coverage expires. Claims occurring after this date are not covered unless the policy is renewed.',
    `coverage_limit` DECIMAL(18,2) COMMENT 'The maximum amount the insurer will pay per claim or per policy period. May differ from insured value for liability policies.',
    `coverage_start_date` DATE COMMENT 'The date when insurance coverage becomes effective. Claims occurring before this date are not covered.',
    `coverage_territory` STRING COMMENT 'The geographic scope of coverage. May be global, regional (e.g., Europe, North America), or country-specific. Defines where claims are valid.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this insurance policy record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this policy (insured value, premium, deductible).. Valid values are `^[A-Z]{3}$`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The amount the policyholder must pay out-of-pocket before the insurance coverage applies. Also known as excess in some jurisdictions.',
    `endorsements` STRING COMMENT 'Additional coverage endorsements or riders attached to the base policy. Examples: hazmat coverage, refrigerated cargo, high-value goods, war risk, terrorism coverage.',
    `exclusions` STRING COMMENT 'Specific exclusions or limitations in coverage. Examples: acts of war, nuclear incidents, intentional damage, wear and tear, specific geographic regions.',
    `fleet_wide_policy_flag` BOOLEAN COMMENT 'Indicates whether this is a blanket policy covering the entire fleet (True) or a policy specific to individual assets (False). Fleet-wide policies have null asset references.',
    `gl_account_code` STRING COMMENT 'The general ledger account code for recording insurance premium expenses and claim recoveries in the financial system.',
    `insured_value` DECIMAL(18,2) COMMENT 'The declared value of the asset or fleet covered by the policy. This is the maximum amount the insurer will pay for a total loss.',
    `insurer_code` STRING COMMENT 'Internal or industry-standard code identifying the insurance provider. Used for standardized reporting and system integration.',
    `insurer_name` STRING COMMENT 'The legal name of the insurance company providing the coverage.',
    `last_claim_date` DATE COMMENT 'The date of the most recent claim filed under this policy. Used for risk assessment and claims-free discount eligibility.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this insurance policy record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes capturing additional policy details, special conditions, renewal negotiations, or other relevant information not captured in structured fields.',
    `policy_document_reference` STRING COMMENT 'Reference to the stored policy document (contract, terms and conditions). May be a document management system identifier or file path.',
    `policy_issue_date` DATE COMMENT 'The date when the insurance policy was officially issued by the insurer. May differ from coverage start date.',
    `policy_number` STRING COMMENT 'The unique policy number assigned by the insurer. This is the externally-known identifier for the insurance contract.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the insurance policy. Active policies provide coverage; expired policies have passed their end date; cancelled policies were terminated early; pending renewal policies are awaiting renewal processing; suspended policies are temporarily inactive; lapsed policies were not renewed.. Valid values are `active|expired|cancelled|pending_renewal|suspended|lapsed`',
    `policy_type` STRING COMMENT 'The type of insurance coverage provided. Comprehensive covers all risks; third-party liability covers damage to others; cargo liability covers goods in transit; hull covers aircraft/vessel structure; physical damage covers vehicle damage; business interruption covers operational losses.. Valid values are `comprehensive|third_party_liability|cargo_liability|hull|physical_damage|business_interruption`',
    `premium_amount` DECIMAL(18,2) COMMENT 'The total premium amount paid or payable for this insurance policy. This is the cost of the insurance coverage.',
    `premium_frequency` STRING COMMENT 'The frequency at which premium payments are made. Annual policies are paid once per year; semi-annual twice per year; quarterly four times per year; monthly twelve times per year.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `regulatory_authority` STRING COMMENT 'The regulatory body requiring this insurance coverage, if applicable. Examples: DOT (Department of Transportation), ICAO (International Civil Aviation Organization), IMO (International Maritime Organization), FMC (Federal Maritime Commission).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this policy meets mandatory regulatory insurance requirements (True) or is voluntary additional coverage (False). Relevant for DOT, ICAO, IMO compliance.',
    `renewal_date` DATE COMMENT 'The scheduled date for policy renewal. Used for planning and ensuring continuous coverage without gaps.',
    `total_claims_paid` DECIMAL(18,2) COMMENT 'The cumulative amount paid by the insurer for all claims under this policy. Used for loss ratio analysis and renewal pricing.',
    `underwriter_name` STRING COMMENT 'The name of the underwriter at the insurance company who assessed and approved this policy.',
    CONSTRAINT pk_asset_insurance PRIMARY KEY(`asset_insurance_id`)
) COMMENT 'Master record tracking insurance policies covering fleet assets against physical damage, third-party liability, cargo liability, and business interruption. Captures asset reference (or fleet-wide policy flag), insurer name, policy number, policy type (comprehensive, third-party liability, cargo, hull — for aircraft/vessels), coverage start/end date, insured value, premium amount, deductible amount, currency, policy renewal date, broker reference, and claims history count. Distinct from the claim domain which manages individual claim events — this is the policy master record.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` (
    `driver_performance_id` BIGINT COMMENT 'Unique identifier for the driver performance record. Primary key for this periodic operational record capturing driver behavior and performance metrics.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Driver performance for contracted carrier drivers must link to carrier for benchmarking, SLA compliance verification, and carrier scorecard aggregation. Supports carrier selection decisions, contract ',
    `driver_profile_id` BIGINT COMMENT 'Reference to the driver being evaluated. Links to the driver profile master data.',
    `driver_safety_event_id` BIGINT COMMENT 'Foreign key linking to safety.driver_safety_event. Business justification: Driver performance evaluations aggregate safety events (harsh braking, speeding, seatbelt violations) for coaching, incentive programs, and disciplinary actions. Real-world process: telematics events ',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or fleet manager who reviewed and approved this performance record.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Driver performance metrics (safety scores, fuel efficiency, on-time delivery) are evaluated against specific route plans to measure adherence, identify deviations, and target coaching interventions.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the primary vehicle or asset operated by the driver during the evaluation period.',
    `trip_id` BIGINT COMMENT 'Reference to the specific trip or assignment if this performance record is trip-based rather than daily aggregated.',
    `co2_emissions_kg` DECIMAL(18,2) COMMENT 'Estimated CO2 emissions in kilograms produced during the evaluation period, calculated from fuel consumption and vehicle emission factors.',
    `coaching_required_flag` BOOLEAN COMMENT 'Indicates whether the drivers performance during this period triggers a requirement for coaching or corrective training. True = coaching needed, False = no coaching required.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this performance record was first created in the system.',
    `customer_feedback_score` DECIMAL(18,2) COMMENT 'Average customer satisfaction score for deliveries completed during the evaluation period, typically on a scale of 1-5 or 1-10.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quality score reflecting the completeness and reliability of telematics data for this evaluation period. Lower scores may indicate GPS signal loss, device malfunction, or data gaps.',
    `eco_driving_score` DECIMAL(18,2) COMMENT 'Score reflecting the drivers fuel-efficient and environmentally conscious driving behavior, based on factors such as smooth acceleration, optimal speed, and reduced idling.',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period. For single-day records this equals the start date; for multi-day aggregations this captures the period end.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period. For trip-based records this is the trip start date; for daily records this is the calendar date.',
    `evaluation_status` STRING COMMENT 'Current status of the performance evaluation record in the review and approval workflow.. Valid values are `draft|pending_review|reviewed|approved|disputed`',
    `evaluation_type` STRING COMMENT 'Granularity of the performance record: trip-level, daily aggregation, weekly summary, or monthly rollup.. Valid values are `trip|daily|weekly|monthly`',
    `fatigue_alert_count` STRING COMMENT 'Number of driver fatigue alerts triggered by telematics or in-cab monitoring systems during the evaluation period.',
    `forward_collision_warning_count` STRING COMMENT 'Number of forward collision warnings issued by ADAS during the evaluation period, indicating potential rear-end collision risk.',
    `fuel_consumed_liters` DECIMAL(18,2) COMMENT 'Total fuel consumed in liters during the evaluation period, captured from telematics or fuel management systems.',
    `fuel_efficiency_actual_km_per_liter` DECIMAL(18,2) COMMENT 'Actual fuel efficiency achieved by the driver during the evaluation period, calculated as total distance divided by fuel consumed.',
    `fuel_efficiency_benchmark_km_per_liter` DECIMAL(18,2) COMMENT 'Expected or benchmark fuel efficiency for the vehicle type and route conditions, used to compare against actual performance.',
    `fuel_efficiency_variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance between actual and benchmark fuel efficiency. Positive values indicate better-than-expected performance; negative values indicate underperformance.',
    `geofence_violation_count` STRING COMMENT 'Number of times the driver entered or exited restricted geofenced areas without authorization during the evaluation period.',
    `harsh_acceleration_events_count` STRING COMMENT 'Number of harsh acceleration events detected by telematics during the evaluation period. Harsh acceleration is typically defined as acceleration exceeding a threshold (e.g., +0.3g).',
    `harsh_braking_events_count` STRING COMMENT 'Number of harsh braking events detected by telematics during the evaluation period. Harsh braking is typically defined as deceleration exceeding a threshold (e.g., -0.3g).',
    `hos_available_drive_time_hours` DECIMAL(18,2) COMMENT 'Remaining available driving hours at the end of the evaluation period, based on HOS regulations and the drivers duty cycle.',
    `hos_compliance_flag` BOOLEAN COMMENT 'Indicates whether the driver remained compliant with Hours of Service regulations during the evaluation period. True = compliant, False = violation detected.',
    `hos_violation_type` STRING COMMENT 'Type of HOS violation if hos_compliance_flag is False. Captures the specific regulation breached (e.g., 11-hour driving limit, 14-hour duty limit, mandatory break).. Valid values are `none|11_hour_driving_limit|14_hour_duty_limit|30_minute_break|60_70_hour_limit|sleeper_berth`',
    `idling_time_minutes` STRING COMMENT 'Total time in minutes the vehicle engine was running while stationary (idling). Excessive idling impacts fuel efficiency and emissions.',
    `incentive_eligible_flag` BOOLEAN COMMENT 'Indicates whether the driver qualifies for performance-based incentives or bonuses based on this evaluation periods metrics. True = eligible, False = not eligible.',
    `incident_reported_flag` BOOLEAN COMMENT 'Indicates whether any safety incidents, accidents, or near-misses were reported during the evaluation period. True = incident occurred, False = no incidents.',
    `incident_severity` STRING COMMENT 'Severity classification of the most serious incident during the evaluation period, if any incident occurred.. Valid values are `none|minor|moderate|major|critical`',
    `lane_departure_count` STRING COMMENT 'Number of unintentional lane departure events detected by advanced driver assistance systems (ADAS) during the evaluation period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this performance record was last updated or modified.',
    `mobile_phone_usage_events_count` STRING COMMENT 'Number of mobile phone usage events detected while the vehicle was in motion, where telematics systems support this detection capability.',
    `night_driving_hours` DECIMAL(18,2) COMMENT 'Total hours driven during night-time hours (typically defined as 10 PM to 6 AM), which may carry higher risk and fatigue factors.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the drivers performance during this evaluation period, including coaching feedback or incident details.',
    `on_time_delivery_flag` BOOLEAN COMMENT 'Indicates whether deliveries during the evaluation period met the scheduled time windows. True = on-time, False = late.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the performance record was reviewed and approved by the supervisor.',
    `route_deviation_count` STRING COMMENT 'Number of times the driver deviated from the planned or optimized route during the evaluation period.',
    `safety_rating` STRING COMMENT 'Categorical safety rating derived from the safety score, used for driver coaching and incentive programs.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `safety_score` DECIMAL(18,2) COMMENT 'Composite safety score calculated from weighted factors including harsh events, speeding, HOS compliance, and other safety metrics. Typically scored 0-100, with higher scores indicating safer driving.',
    `seatbelt_violation_count` STRING COMMENT 'Number of instances where the driver operated the vehicle without wearing a seatbelt, detected via telematics sensors.',
    `speeding_duration_minutes` STRING COMMENT 'Total time in minutes the driver spent exceeding speed limits during the evaluation period.',
    `speeding_events_count` STRING COMMENT 'Number of speeding violations detected during the evaluation period, where vehicle speed exceeded posted speed limits or company policy thresholds.',
    `telematics_device_code` STRING COMMENT 'Identifier of the telematics device that captured the performance data for this evaluation period.',
    `total_distance_km` DECIMAL(18,2) COMMENT 'Total distance driven by the driver during the evaluation period, measured in kilometers. Derived from telematics odometer readings.',
    `total_driving_time_hours` DECIMAL(18,2) COMMENT 'Total hours the driver spent actively driving (ignition on, vehicle in motion) during the evaluation period.',
    CONSTRAINT pk_driver_performance PRIMARY KEY(`driver_performance_id`)
) COMMENT 'Periodic operational record (per trip or per day) capturing driver behaviour and performance metrics derived from telematics and HOS data. Tracks driver reference, asset reference, evaluation period, total distance driven, harsh braking events count, harsh acceleration events count, speeding events count, idling time (minutes), fuel efficiency (actual vs benchmark), HOS compliance flag, geofence violation count, mobile phone usage events (where detectable), and overall safety score. Supports driver coaching programmes, incentive schemes, and DOT safety compliance management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`asset_position` (
    `asset_position_id` BIGINT COMMENT 'Unique identifier for the asset position record. Primary key.',
    `asset_assignment_id` BIGINT COMMENT 'Reference to the active asset assignment or trip the asset is currently executing.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Real-time asset positions for carrier-operated assets must track carrier for visibility dashboards, exception management (geofence violations, delays), customer communication, and carrier performance ',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment currently being transported by this asset, enabling customer-facing tracking.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Real-time asset positions verify cross-border movements and support customs declarations with GPS-based proof-of-transit. Critical for automated border crossings, trusted trader programs, and customs ',
    `driver_profile_id` BIGINT COMMENT 'Reference to the driver currently operating or assigned to this asset.',
    `freight_order_id` BIGINT COMMENT 'Reference to the freight order or transport order the asset is currently fulfilling.',
    `geofence_zone_id` BIGINT COMMENT 'Reference to the geofence zone the asset is currently within, used for location-based alerts and compliance monitoring.',
    `network_node_id` BIGINT COMMENT 'Reference to the next planned stop or waypoint on the assets route.',
    `plan_id` BIGINT COMMENT 'Reference to the planned route the asset is currently following.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the fleet asset (vehicle, aircraft, vessel, container) whose position is being tracked.',
    `altitude_m` DECIMAL(18,2) COMMENT 'Altitude of the asset above sea level in meters, relevant for aircraft and mountainous terrain tracking.',
    `asset_number` STRING COMMENT 'Business identifier of the asset for operational reference and display purposes.',
    `asset_type` STRING COMMENT 'Classification of the fleet asset type being tracked. [ENUM-REF-CANDIDATE: truck|trailer|van|aircraft|vessel|container|railcar|other — 8 candidates stripped; promote to reference product]',
    `battery_voltage` DECIMAL(18,2) COMMENT 'Current battery voltage of the asset or telematics device, used for health monitoring and maintenance alerts.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the asset is currently located, critical for customs and cross-border compliance.. Valid values are `^[A-Z]{3}$`',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and reliability of this position record, used to filter or weight data in analytics.. Valid values are `valid|suspect|stale|interpolated|estimated`',
    `data_source` STRING COMMENT 'Source system or method by which this position data was captured (GPS telematics, RFID scan, manual update, AIS for vessels, ADS-B for aircraft). [ENUM-REF-CANDIDATE: gps|rfid|manual|ais|ads-b|cellular|wifi — 7 candidates stripped; promote to reference product]',
    `distance_to_next_waypoint_km` DECIMAL(18,2) COMMENT 'Remaining distance in kilometers from current position to the next waypoint.',
    `eta_next_waypoint` TIMESTAMP COMMENT 'Predicted arrival date and time at the next waypoint, calculated from current position, speed, and route. Critical for customer notifications and SLA monitoring.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this position triggered any exception or alert condition (geofence breach, delay, route deviation, out-of-contact).',
    `exception_type` STRING COMMENT 'Classification of the exception or alert triggered by this position (e.g., geofence-exit, delay, route-deviation, speed-violation, temperature-excursion). [ENUM-REF-CANDIDATE: geofence-exit|geofence-entry|delay|route-deviation|speed-violation|temperature-excursion|unauthorized-stop|out-of-contact|harsh-braking|harsh-acceleration — promote to reference product]',
    `fuel_level_percent` DECIMAL(18,2) COMMENT 'Current fuel level as a percentage of tank capacity, used for refueling planning and range estimation.',
    `gps_accuracy_m` DECIMAL(18,2) COMMENT 'Accuracy radius of the GPS position fix in meters, indicating the reliability of the location data.',
    `gps_satellite_count` STRING COMMENT 'Number of GPS satellites used to calculate the current position, affecting accuracy and reliability.',
    `heading_degrees` DECIMAL(18,2) COMMENT 'Current compass heading or direction of travel in degrees (0-360), where 0/360 is North, 90 is East, 180 is South, 270 is West.',
    `ignition_state` STRING COMMENT 'Current state of the vehicle ignition, indicating whether the engine is running.. Valid values are `on|off|unknown`',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Date and time when this position record was ingested into the lakehouse platform, used for data lineage and latency monitoring.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this position record was last modified or refreshed in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the assets current position in decimal degrees (WGS84).',
    `location_code` STRING COMMENT 'Business code identifying the specific facility, depot, or site where the asset is currently located.',
    `location_type` STRING COMMENT 'Classification of the current location type where the asset is positioned. [ENUM-REF-CANDIDATE: depot|warehouse|customer-site|port|airport|border-crossing|rest-area|in-transit|unknown — 9 candidates stripped; promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the assets current position in decimal degrees (WGS84).',
    `next_waypoint_name` STRING COMMENT 'Name of the next planned stop or destination for operational display.',
    `odometer_km` DECIMAL(18,2) COMMENT 'Cumulative odometer reading in kilometers at the time of this position capture, used for maintenance scheduling and utilization tracking.',
    `operational_status` STRING COMMENT 'Current operational state of the asset indicating its activity and availability. Critical for fleet visibility and dispatch decisions. [ENUM-REF-CANDIDATE: in-transit|idle|at-depot|in-maintenance|out-of-contact|loading|unloading — 7 candidates stripped; promote to reference product]',
    `position_age_minutes` STRING COMMENT 'Number of minutes elapsed since this position was captured, indicating data freshness for real-time visibility.',
    `position_timestamp` TIMESTAMP COMMENT 'The date and time when this position was recorded or last updated. This is the principal business event timestamp representing when the asset was at this location.',
    `rfid_tag_code` STRING COMMENT 'RFID tag identifier associated with the asset for automated scanning and tracking at checkpoints.',
    `source_system` STRING COMMENT 'Name of the operational system that provided this position data (e.g., FourKites, Samsara, Geotab).',
    `speed_kmh` DECIMAL(18,2) COMMENT 'Current speed of the asset in kilometers per hour at the time of position capture.',
    `telematics_device_code` STRING COMMENT 'Identifier of the telematics or GPS tracking device that captured this position data.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Current cargo or ambient temperature in Celsius for temperature-controlled assets (reefer containers, refrigerated trucks).',
    CONSTRAINT pk_asset_position PRIMARY KEY(`asset_position_id`)
) COMMENT 'Near-real-time master record holding the CURRENT known position and status of each fleet asset, updated from telematics_event stream via FourKites. Captures asset reference, last known GPS coordinates, last update timestamp, current speed, current heading, current geofence zone, current assignment reference, estimated arrival datetime (ETA) at next waypoint, asset operational status (in-transit, idle, at-depot, in-maintenance, out-of-contact), and data source (GPS, RFID, manual update). Serves as the live fleet visibility layer for TMS dispatchers and customer-facing shipment tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` (
    `depot_initiative_implementation_id` BIGINT COMMENT 'Unique identifier for this depot-initiative implementation record. Primary key.',
    `depot_id` BIGINT COMMENT 'Foreign key linking to the fleet depot where this sustainability initiative is being implemented.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to the sustainability initiative being implemented at this depot.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for leading and coordinating the implementation of this sustainability initiative at this depot. Establishes accountability at the site level.',
    `baseline_co2e_emissions_tco2e` DECIMAL(18,2) COMMENT 'Baseline annual GHG emissions in metric tonnes of CO2 equivalent (tCO2e) at this depot before initiative implementation. Used to calculate actual reduction achieved.',
    `baseline_measurement_date` DATE COMMENT 'Date when the baseline environmental performance measurement was taken at this depot for this initiative. Establishes the reference point for measuring emissions reduction impact.',
    `capex_allocated` DECIMAL(18,2) COMMENT 'Capital expenditure allocated or spent for implementing this sustainability initiative at this specific depot. Enables site-level investment tracking and ROI analysis.',
    `co2e_reduction_actual_tco2e` DECIMAL(18,2) COMMENT 'Actual measured annual greenhouse gas emissions reduction in metric tonnes of CO2 equivalent (tCO2e) achieved by this initiative at this specific depot. Enables site-level performance tracking against targets.',
    `co2e_reduction_target_tco2e` DECIMAL(18,2) COMMENT 'Target annual greenhouse gas emissions reduction in metric tonnes of CO2 equivalent (tCO2e) for this initiative at this specific depot. Site-level contribution to overall initiative target.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this depot-initiative implementation record was created in the system.',
    `implementation_completion_date` DATE COMMENT 'Actual date when the sustainability initiative implementation was completed at this depot and became fully operational. Tracks site-level delivery timeline.',
    `implementation_start_date` DATE COMMENT 'Date when the sustainability initiative implementation commenced at this specific depot site. Tracks site-level rollout timeline.',
    `implementation_status` STRING COMMENT 'Current status of the sustainability initiative implementation at this depot: planned, in-progress, completed, on-hold, or cancelled. Enables site-level progress tracking independent of overall initiative status.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this depot-initiative implementation record was last modified.',
    `notes` STRING COMMENT 'Free-text notes capturing site-specific implementation details, challenges, lessons learned, or other contextual information relevant to this depot-initiative combination.',
    `opex_allocated` DECIMAL(18,2) COMMENT 'Operating expenditure allocated or spent for implementing this sustainability initiative at this specific depot. Tracks ongoing operational costs at the site level.',
    CONSTRAINT pk_depot_initiative_implementation PRIMARY KEY(`depot_initiative_implementation_id`)
) COMMENT 'This association product represents the implementation of a sustainability initiative at a specific fleet depot. It captures the site-specific execution details, investment allocation, and emissions reduction performance for each depot-initiative combination. Each record links one fleet depot to one sustainability initiative with attributes that exist only in the context of this site-level implementation, enabling capital planning, ROI tracking, and sustainability target monitoring at the depot level.. Existence Justification: In logistics operations, sustainability initiatives such as solar panel installation, LED lighting retrofit, EV charging infrastructure deployment, and waste reduction programs are implemented across multiple depot sites, with each depot hosting multiple concurrent initiatives. The business actively manages site-specific implementation records to track rollout progress, allocate capital investment by location, measure site-level emissions reductions, and report on sustainability target achievement at the depot level for ESG compliance and capital planning.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` (
    `depot_certification_id` BIGINT COMMENT 'Primary key for the depot certification association record',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to the compliance program under which the depot is certified',
    `depot_id` BIGINT COMMENT 'Foreign key linking to the fleet depot being certified',
    `fleet_depot_id` BIGINT COMMENT 'Foreign key to fleet_depot',
    `audit_date` DATE COMMENT 'Date of the most recent compliance audit conducted at this specific depot for this program. Each depot-program combination has its own audit schedule.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score or rating assigned to this depot during the most recent audit for this compliance program. Measures facility-specific compliance performance.',
    `certification_notes` STRING COMMENT 'Free-text notes capturing facility-specific conditions, exceptions, or observations related to this depots certification under this program.',
    `certification_status` STRING COMMENT 'Current status of this specific depots certification under this compliance program. Tracks the lifecycle state of the facility-specific certification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification relationship record was created in the system.',
    `expiry_date` DATE COMMENT 'Date when this depots certification under this program expires. Facility-specific expiry may differ from program-level expiry based on audit cycles.',
    `facility_certification_date` DATE COMMENT 'Date when this specific depot received certification under this compliance program. Distinct from the programs general issue_date as each facility is certified individually.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification relationship record was last modified.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next compliance audit at this depot for this program.',
    `security_level` STRING COMMENT 'Security classification assigned to this depot under this specific compliance program. Different programs may assign different security levels to the same facility.',
    CONSTRAINT pk_depot_certification PRIMARY KEY(`depot_certification_id`)
) COMMENT 'This association product represents the certification relationship between fleet depots and compliance programs. It captures facility-specific certification status, audit history, and security assessments for each depot under each compliance program (C-TPAT, AEO, bonded warehouse status). Each record links one fleet depot to one compliance program with attributes that exist only in the context of this specific certification relationship.. Existence Justification: In logistics operations, fleet depots (terminals, warehouses, maintenance facilities) are independently certified under multiple compliance programs simultaneously - a single depot may hold C-TPAT facility security certification, AEO site certification, and bonded warehouse status concurrently. Conversely, each compliance program certifies many facilities across the network. Each depot-program certification is managed independently with its own audit schedule, certification dates, security assessments, and compliance status.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` (
    `driver_certification_id` BIGINT COMMENT 'Unique identifier for this driver-program certification record. Primary key.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key to customs.compliance_program. Identifies which compliance program this certification is for.',
    `driver_profile_id` BIGINT COMMENT 'Foreign key to fleet.driver_profile. Identifies which driver holds this certification.',
    `background_check_date` DATE COMMENT 'Date when the background check specific to this compliance program was completed for this driver. Distinct from the general background check in driver_profile as each program may have unique vetting requirements.',
    `background_check_status` STRING COMMENT 'Result status of the program-specific background check. Cleared: passed all program requirements. Pending: under review. Failed: did not meet program criteria. Expired: check is outdated per program rules.',
    `certification_date` DATE COMMENT 'Date when the driver was certified or approved under this specific compliance program. Represents when the driver met all program requirements.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the drivers certification under this program. Active: driver is certified and compliant. Expired: certification lapsed. Suspended: temporarily invalid. Pending: application submitted. Revoked: certification withdrawn.',
    `certifying_officer` STRING COMMENT 'Name or identifier of the compliance officer or fleet manager who approved this driver certification under this program.',
    `dangerous_goods_certification_expiry_date` DATE COMMENT 'Expiry date of the IATA dangerous goods certification. Null if driver does not hold this certification. [Moved from driver_profile: This attribute represents the expiry date of the IATA dangerous goods certificate. It should move to driver_certification as expiry_date where certificate_type=Dangerous Goods, enabling unified certificate lifecycle management.]',
    `dangerous_goods_certification_flag` BOOLEAN COMMENT 'Indicates whether the driver holds IATA dangerous goods training certification for air cargo handling and transport. True if certified, False otherwise. [Moved from driver_profile: This flag indicates whether a driver holds an IATA dangerous goods certificate. This should be represented as a record in driver_certification where certificate_type=Dangerous Goods with certification_status=Active rather than as a boolean flag.]',
    `expiry_date` DATE COMMENT 'Date when this drivers certification under this specific program expires and must be renewed. May differ from the programs overall expiry date as driver certifications often have individual renewal cycles.',
    `hazmat_endorsement_expiry_date` DATE COMMENT 'Expiry date of the hazmat endorsement. Null if driver does not hold hazmat endorsement. [Moved from driver_profile: This attribute represents the expiry date of the hazmat certificate. It should move to driver_certification as expiry_date where certificate_type=Hazmat Endorsement, consistent with the normalized certificate tracking model.]',
    `hazmat_endorsement_flag` BOOLEAN COMMENT 'Indicates whether the driver holds a valid hazmat endorsement allowing them to transport dangerous goods by road. True if endorsed, False otherwise. [Moved from driver_profile: This flag indicates whether a driver holds a hazmat certificate. This should be represented as a record in driver_certification where certificate_type=Hazmat Endorsement with certification_status=Active rather than as a boolean flag on the driver profile.]',
    `last_safety_training_date` DATE COMMENT 'Date the driver last completed mandatory safety training. Used to ensure compliance with periodic training requirements. [Moved from driver_profile: This represents the completion date of safety training, which results in a training certificate. It should move to driver_certification as training_completion_date where certificate_type=Safety Training Certificate.]',
    `medical_certificate_expiry_date` DATE COMMENT 'Expiry date of the drivers DOT medical examiner certificate (US) or equivalent medical fitness certificate required for commercial vehicle operation. Drivers must maintain valid medical certification to operate. [Moved from driver_profile: This attribute represents the expiry date of a specific certificate (DOT medical certificate) held by a driver. It should move to the driver_certification association as expiry_date where certificate_type=Medical Certificate. This allows tracking of multiple certificate types with their individual expiry dates in a normalized structure.]',
    `next_safety_training_due_date` DATE COMMENT 'Date by which the driver must complete their next mandatory safety training to maintain compliance. [Moved from driver_profile: This represents when the next safety training is due, which is effectively the renewal date for the safety training certificate. It should move to driver_certification as next_renewal_due_date where certificate_type=Safety Training Certificate.]',
    `next_training_due_date` DATE COMMENT 'Date by which the driver must complete recurrent training for this compliance program to maintain certification status.',
    `notes` STRING COMMENT 'Free-text notes regarding this specific driver-program certification, including any special conditions, restrictions, or audit findings.',
    `training_completion_date` DATE COMMENT 'Date when the driver completed all mandatory training requirements specific to this compliance program (e.g., C-TPAT security awareness, AEO procedures).',
    CONSTRAINT pk_driver_certification PRIMARY KEY(`driver_certification_id`)
) COMMENT 'This association product represents the certification relationship between driver_profile and compliance_program. It captures the driver-specific certification status, training completion, and background check requirements for each customs compliance program (C-TPAT, AEO, FAST). Each record links one driver to one compliance program with certification dates, status, and expiry tracking that exist only in the context of this driver-program relationship.. Existence Justification: In cross-border logistics operations, drivers must be individually certified under multiple customs compliance programs (C-TPAT, AEO, FAST) to operate specific routes, and each program certifies many drivers with program-specific training, background checks, and expiry dates. Fleet managers actively manage these driver-program certifications to ensure route assignment compliance, tracking certification status, training completion, and renewal cycles per driver per program.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` (
    `driver_engagement_id` BIGINT COMMENT 'Unique identifier for this driver-carrier engagement record. Primary key for the association.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier partner in the network domain. Identifies which carrier partner the driver is engaged with.',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to the driver profile in the fleet domain. Identifies which driver is engaged in this carrier relationship.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this driver-carrier engagement is currently active. True: driver is actively working for this carrier. False: engagement has ended or is suspended. Used for quick filtering of current engagements.',
    `carrier_specific_training_completed_flag` BOOLEAN COMMENT 'Indicates whether the driver has completed mandatory training specific to this carriers operations, systems, and procedures. Many carriers require proprietary training beyond general licensing.',
    `carrier_specific_training_date` DATE COMMENT 'Date when the driver completed carrier-specific training for this engagement. Null if training not yet completed.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Percentage commission rate paid to the driver for deliveries or routes completed under this carrier engagement. Expressed as percentage (e.g., 15.50 for 15.5%). Varies by carrier and driver negotiation.',
    `compliance_status` STRING COMMENT 'Current compliance status of the driver for this specific carrier engagement. Tracks whether driver has completed carrier-specific training, insurance requirements, and regulatory certifications required by this carrier. Compliant: all requirements met. Pending-documents: awaiting documentation. Suspended: temporarily not eligible for assignments. Non-compliant: missing critical requirements.',
    `contract_reference_number` STRING COMMENT 'Reference number of the legal contract or agreement document governing this driver-carrier engagement. Links to contract management system or document repository.',
    `driver_engagement_type` STRING COMMENT 'Classification of the engagement relationship. Exclusive: driver works only for this carrier. Non-exclusive: driver can work for multiple carriers simultaneously. Platform: gig-economy platform engagement. Seasonal: temporary engagement for peak periods. Project-based: engagement for specific routes or projects.',
    `end_date` DATE COMMENT 'Date when the driver-carrier engagement ended or is scheduled to end. Null for active ongoing engagements. Critical for tracking engagement history and sequential carrier relationships.',
    `last_assignment_date` DATE COMMENT 'Date of the most recent route or shipment assignment given to this driver by this carrier. Used to track engagement activity and identify dormant relationships.',
    `performance_tier` STRING COMMENT 'Performance classification of the driver within this specific carrier engagement. Platinum: top performer with premium rates. Gold: above-average performance. Silver: standard performance. Bronze: below expectations. Probationary: new or under review. Performance tier may differ across carriers for the same driver.',
    `start_date` DATE COMMENT 'Date when the driver began working for or was contracted by this carrier partner. Tracks the beginning of the engagement relationship.',
    `total_assignments_completed` BIGINT COMMENT 'Cumulative count of route assignments or deliveries completed by this driver for this specific carrier. Performance metric tracked per engagement.',
    CONSTRAINT pk_driver_engagement PRIMARY KEY(`driver_engagement_id`)
) COMMENT 'This association product represents the contractual engagement between a driver and a carrier partner in the Transport Shipping network. It captures the business relationship when drivers work as owner-operators or independent contractors for multiple carrier partners simultaneously or sequentially. Each record links one driver_profile to one carrier with engagement terms, performance tracking, and compliance status that exist only in the context of this specific driver-carrier relationship.. Existence Justification: In the logistics industry, particularly in gig economy and contractor models, drivers frequently work as owner-operators or independent contractors who can be simultaneously engaged with multiple carrier partners (e.g., a driver working for both FedEx Ground and regional carriers, or platform drivers on multiple apps). Each carrier engagement has its own contract terms, commission rates, performance tracking, and compliance requirements. Carriers manage rosters of many drivers. This is a true operational many-to-many relationship where the business actively manages driver-carrier engagements as distinct business entities.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` (
    `fleet_training_completion_id` BIGINT COMMENT 'Primary key for fleet_training_completion',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to the driver who completed the training',
    `workforce_training_completion_id` BIGINT COMMENT 'Unique identifier for this training completion record. Primary key.',
    `training_id` BIGINT COMMENT 'Foreign key linking to the safety training course that was completed',
    `assessment_score` DECIMAL(18,2) COMMENT 'Percentage score achieved by the driver on the competency assessment for this training course. Explicitly identified in detection phase relationship data.',
    `attendance_hours` DECIMAL(18,2) COMMENT 'Actual hours the driver attended the training session. May differ from standard duration_hours if partial attendance or extended session.',
    `certificate_expiry_date` DATE COMMENT 'Date the training certificate expires and recertification is required. Calculated based on completion_date plus certification_validity_months from the training course. Explicitly identified in detection phase relationship data.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued upon successful completion of the training course. Explicitly identified in detection phase relationship data.',
    `completion_date` DATE COMMENT 'Date the driver successfully completed the safety training course. Explicitly identified in detection phase relationship data.',
    `compliance_status` STRING COMMENT 'Current compliance status of this training completion record. Current: certificate is valid. Expiring Soon: within 30 days of expiry. Expired: past expiry date. Pending Recertification: refresher training scheduled. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this training completion record was created in the safety management system.',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator who delivered this training session to the driver.',
    `pass_fail_status` STRING COMMENT 'Final outcome of the training assessment. Pass: met passing score. Fail: did not meet passing score. Incomplete: training started but not finished. Waived: requirement waived by authority.',
    `recertification_due_date` DATE COMMENT 'Date by which the driver must complete refresher training to maintain compliance. Calculated from completion_date plus refresher_frequency_months.',
    `training_location` STRING COMMENT 'Physical location, facility, or online platform where the training was delivered (e.g., depot code, training center, LMS platform).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this training completion record was last updated.',
    CONSTRAINT pk_fleet_training_completion PRIMARY KEY(`fleet_training_completion_id`)
) COMMENT 'This association product represents the completion event between driver_profile and safety_training. It captures the operational record of a driver completing a specific safety training course, including assessment results, certification details, and compliance status. Each record links one driver to one training course completion instance with attributes that exist only in the context of this completion relationship.. Existence Justification: In Transport Shipping operations, drivers complete multiple safety training courses throughout their careers (defensive driving, hazmat handling, first aid, emergency response, fatigue management), and each training course is completed by many different drivers. The business actively manages training completion records as operational entities, tracking completion dates, assessment scores, certificate numbers, expiry dates, and compliance status for each driver-course combination. Safety officers query training matrices, schedule recertifications, and generate compliance reports based on these completion records.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`fleet`.`trip` (
    `trip_id` BIGINT COMMENT 'Primary key for trip',
    `cargo_id` BIGINT COMMENT 'Identifier of the cargo or shipment being moved on the trip.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the shipper or customer associated with the trip.',
    `driver_profile_id` BIGINT COMMENT 'Identifier of the driver assigned to the trip.',
    `plan_id` BIGINT COMMENT 'Identifier of the planned route for the trip.',
    `transport_asset_id` BIGINT COMMENT 'Identifier of the vehicle (truck, van, etc.) used for the trip.',
    `return_trip_id` BIGINT COMMENT 'Self-referencing FK on trip (return_trip_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Real end time when the vehicle arrived at the destination.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Real start time when the vehicle departed.',
    `average_speed_kmh` DECIMAL(18,2) COMMENT 'Average speed of the vehicle over the trip.',
    `cargo_type` STRING COMMENT 'Classification of cargo being moved.',
    `cargo_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the cargo transported on the trip.',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the trip.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `destination_location_code` STRING COMMENT 'Three‑letter code representing the trip destination.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total planned or actual distance traveled in kilometers.',
    `emissions_kg_co2` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide emissions for the trip.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary trip event (e.g., actual departure time).',
    `fuel_consumed_liters` DECIMAL(18,2) COMMENT 'Quantity of fuel used during the trip.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total billed amount before taxes and adjustments.',
    `is_expedited` BOOLEAN COMMENT 'Indicates whether the trip was expedited (true) or standard (false).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after taxes and adjustments.',
    `number_of_stops` STRING COMMENT 'Count of intermediate stops made during the trip.',
    `origin_location_code` STRING COMMENT 'Three‑letter code (e.g., IATA/UN/port) representing the trip origin.',
    `priority_level` STRING COMMENT 'Business priority assigned to the trip.',
    `reason_code` STRING COMMENT 'Code indicating the primary reason for the trip.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the trip record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the trip record.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end time of the trip as per the schedule.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start time of the trip as per the schedule.',
    `trip_status` STRING COMMENT 'Current lifecycle status of the trip.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the trip billing.',
    `trip_number` STRING COMMENT 'Business-assigned alphanumeric identifier for the trip, used in operational systems and customer communications.',
    CONSTRAINT pk_trip PRIMARY KEY(`trip_id`)
) COMMENT 'Master reference table for trip. Referenced by trip_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ADD CONSTRAINT `fk_fleet_transport_asset_asset_type_id` FOREIGN KEY (`asset_type_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`asset_type`(`asset_type_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ADD CONSTRAINT `fk_fleet_transport_asset_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ADD CONSTRAINT `fk_fleet_container_unit_asset_type_id` FOREIGN KEY (`asset_type_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`asset_type`(`asset_type_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ADD CONSTRAINT `fk_fleet_container_unit_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_origin_depot_id` FOREIGN KEY (`origin_depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ADD CONSTRAINT `fk_fleet_asset_assignment_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_geofence_zone_id` FOREIGN KEY (`geofence_zone_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`geofence_zone`(`geofence_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_driver_licence_type_id` FOREIGN KEY (`driver_licence_type_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_licence_type`(`driver_licence_type_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ADD CONSTRAINT `fk_fleet_driver_profile_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_primary_fleet_depot_id` FOREIGN KEY (`primary_fleet_depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ADD CONSTRAINT `fk_fleet_fleet_driver_assignment_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_maintenance_schedule_id` FOREIGN KEY (`maintenance_schedule_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`maintenance_schedule`(`maintenance_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ADD CONSTRAINT `fk_fleet_maintenance_order_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_asset_type_id` FOREIGN KEY (`asset_type_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`asset_type`(`asset_type_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ADD CONSTRAINT `fk_fleet_asset_inspection_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ADD CONSTRAINT `fk_fleet_asset_inspection_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ADD CONSTRAINT `fk_fleet_asset_licence_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_asset_assignment_id` FOREIGN KEY (`asset_assignment_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`asset_assignment`(`asset_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_geofence_zone_id` FOREIGN KEY (`geofence_zone_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`geofence_zone`(`geofence_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ADD CONSTRAINT `fk_fleet_incident_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ADD CONSTRAINT `fk_fleet_asset_utilisation_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ADD CONSTRAINT `fk_fleet_asset_utilisation_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ADD CONSTRAINT `fk_fleet_asset_utilisation_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ADD CONSTRAINT `fk_fleet_asset_acquisition_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ADD CONSTRAINT `fk_fleet_asset_disposal_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ADD CONSTRAINT `fk_fleet_rfid_scan_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ADD CONSTRAINT `fk_fleet_rfid_scan_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ADD CONSTRAINT `fk_fleet_rfid_scan_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ADD CONSTRAINT `fk_fleet_tyre_record_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_fleet_driver_assignment_id` FOREIGN KEY (`fleet_driver_assignment_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment`(`fleet_driver_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ADD CONSTRAINT `fk_fleet_driver_licence_type_superseded_by_licence_type_driver_licence_type_id` FOREIGN KEY (`superseded_by_licence_type_driver_licence_type_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_licence_type`(`driver_licence_type_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ADD CONSTRAINT `fk_fleet_geofence_zone_parent_zone_geofence_zone_id` FOREIGN KEY (`parent_zone_geofence_zone_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`geofence_zone`(`geofence_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ADD CONSTRAINT `fk_fleet_asset_cost_record_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ADD CONSTRAINT `fk_fleet_asset_cost_record_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ADD CONSTRAINT `fk_fleet_reefer_monitoring_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ADD CONSTRAINT `fk_fleet_reefer_monitoring_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ADD CONSTRAINT `fk_fleet_toll_record_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ADD CONSTRAINT `fk_fleet_asset_insurance_container_unit_id` FOREIGN KEY (`container_unit_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`container_unit`(`container_unit_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ADD CONSTRAINT `fk_fleet_asset_insurance_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ADD CONSTRAINT `fk_fleet_driver_performance_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ADD CONSTRAINT `fk_fleet_driver_performance_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ADD CONSTRAINT `fk_fleet_driver_performance_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ADD CONSTRAINT `fk_fleet_asset_position_asset_assignment_id` FOREIGN KEY (`asset_assignment_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`asset_assignment`(`asset_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ADD CONSTRAINT `fk_fleet_asset_position_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ADD CONSTRAINT `fk_fleet_asset_position_geofence_zone_id` FOREIGN KEY (`geofence_zone_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`geofence_zone`(`geofence_zone_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ADD CONSTRAINT `fk_fleet_asset_position_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ADD CONSTRAINT `fk_fleet_depot_initiative_implementation_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ADD CONSTRAINT `fk_fleet_depot_certification_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ADD CONSTRAINT `fk_fleet_depot_certification_fleet_depot_id` FOREIGN KEY (`fleet_depot_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`depot`(`depot_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ADD CONSTRAINT `fk_fleet_driver_certification_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ADD CONSTRAINT `fk_fleet_driver_engagement_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ADD CONSTRAINT `fk_fleet_fleet_training_completion_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_driver_profile_id` FOREIGN KEY (`driver_profile_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`driver_profile`(`driver_profile_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_transport_asset_id` FOREIGN KEY (`transport_asset_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`transport_asset`(`transport_asset_id`);
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ADD CONSTRAINT `fk_fleet_trip_return_trip_id` FOREIGN KEY (`return_trip_id`) REFERENCES `transport_shipping_ecm`.`fleet`.`trip`(`trip_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`fleet` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `transport_shipping_ecm`.`fleet` SET TAGS ('dbx_domain' = 'fleet');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` SET TAGS ('dbx_subdomain' = 'asset_lifecycle');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `asset_type_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Type Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Depot ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `co2_emission_rate_g_per_km` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emission Rate (Grams per Kilometer)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `current_location` SET TAGS ('dbx_business_glossary_term' = 'Current Location');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `disposal_value` SET TAGS ('dbx_business_glossary_term' = 'Disposal Value');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `disposal_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `emission_standard` SET TAGS ('dbx_business_glossary_term' = 'Emission Standard');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `engine_power_kw` SET TAGS ('dbx_business_glossary_term' = 'Engine Power (Kilowatts)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `engine_type` SET TAGS ('dbx_business_glossary_term' = 'Engine Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `fuel_capacity_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Capacity (Liters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `height_meters` SET TAGS ('dbx_business_glossary_term' = 'Height (Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `home_location` SET TAGS ('dbx_business_glossary_term' = 'Home Location');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `length_meters` SET TAGS ('dbx_business_glossary_term' = 'Length (Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Model');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|in_maintenance|idle|decommissioned|reserved|out_of_service');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|chartered|rented');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `payload_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Payload Capacity (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `registration_country` SET TAGS ('dbx_business_glossary_term' = 'Registration Country');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `registration_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `registration_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{24}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_business_glossary_term' = 'Telematics Device ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `teu_capacity` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Capacity');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate (Percent)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `vin_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN) / Serial Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `vin_serial_number` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9]{17}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `vin_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `volume_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Capacity (Cubic Meters / CBM)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `width_meters` SET TAGS ('dbx_business_glossary_term' = 'Width (Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`transport_asset` ALTER COLUMN `year_of_manufacture` SET TAGS ('dbx_business_glossary_term' = 'Year of Manufacture');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` SET TAGS ('dbx_subdomain' = 'asset_lifecycle');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `asset_type_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Type Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Current Depot Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|in_use|in_transit|under_repair|retired|lost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|scrap');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number (ISO 6346)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `csc_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Container Safety Convention (CSC) Certification Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `csc_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Container Safety Convention (CSC) Certification Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `csc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Container Safety Convention (CSC) Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `current_book_value` SET TAGS ('dbx_business_glossary_term' = 'Current Book Value');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `current_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `current_location_code` SET TAGS ('dbx_business_glossary_term' = 'Current Location Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `current_location_country` SET TAGS ('dbx_business_glossary_term' = 'Current Location Country');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `current_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `current_location_type` SET TAGS ('dbx_business_glossary_term' = 'Current Location Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `current_location_type` SET TAGS ('dbx_value_regex' = 'depot|port|vessel|rail_yard|customer_site|in_transit');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `food_grade_certified` SET TAGS ('dbx_business_glossary_term' = 'Food Grade Certified');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `gps_enabled` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Enabled');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `height_ft` SET TAGS ('dbx_business_glossary_term' = 'Container Height (Feet)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `internal_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Internal Volume (Cubic Meters - CBM)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `lease_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `length_ft` SET TAGS ('dbx_business_glossary_term' = 'Container Length (Feet)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Container Manufacturer');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `max_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Gross Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `max_payload_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Payload Capacity (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `owner_code` SET TAGS ('dbx_business_glossary_term' = 'Owner Code (ISO 6346)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `owner_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|customer_owned|pool');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `reefer_capable` SET TAGS ('dbx_business_glossary_term' = 'Refrigerated (Reefer) Capable');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `rfid_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `tare_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Range (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Range (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `teu_size` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Size');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `total_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Total Distance Traveled (Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `total_trips_completed` SET TAGS ('dbx_business_glossary_term' = 'Total Trips Completed');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`container_unit` ALTER COLUMN `width_ft` SET TAGS ('dbx_business_glossary_term' = 'Container Width (Feet)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` SET TAGS ('dbx_subdomain' = 'cost_routing');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `asset_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Assignment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `charge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Event Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Depot Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `origin_depot_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Depot Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `trip_id` SET TAGS ('dbx_business_glossary_term' = 'Trip Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `assignment_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Assignment Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `assignment_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `assignment_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Assignment Duration in Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `cargo_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `cargo_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `co2_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required|waived');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `cross_border_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Indicator');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `delay_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration in Minutes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance in Kilometers (km)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `fuel_consumed_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed in Liters');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `gps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Tracking Enabled');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Indicator');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `incident_reported_indicator` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Indicator');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `load_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Load Utilization Percentage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `planned_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date and Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `planned_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date and Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `rfid_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'express|standard|economy|charter|dedicated');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_TM|ORACLE_TMS|MANHATTAN_WMS|FOURKITES|MANUAL|OTHER');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_assignment` ALTER COLUMN `temperature_controlled_indicator` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Indicator');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` SET TAGS ('dbx_subdomain' = 'tracking_monitoring');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `telematics_event_id` SET TAGS ('dbx_business_glossary_term' = 'Telematics Event ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `geofence_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Geofence ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `altitude_m` SET TAGS ('dbx_business_glossary_term' = 'Altitude (Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `battery_voltage` SET TAGS ('dbx_business_glossary_term' = 'Battery Voltage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|interpolated');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Telematics Device ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `diagnostic_trouble_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnostic Trouble Code (DTC)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Engine Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `engine_rpm` SET TAGS ('dbx_business_glossary_term' = 'Engine Revolutions Per Minute (RPM)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `fuel_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Level (Percent)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `geofence_event_type` SET TAGS ('dbx_business_glossary_term' = 'Geofence Event Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `geofence_event_type` SET TAGS ('dbx_value_regex' = 'entry|exit');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `gps_accuracy_m` SET TAGS ('dbx_business_glossary_term' = 'GPS Accuracy (Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `gps_satellite_count` SET TAGS ('dbx_business_glossary_term' = 'GPS Satellite Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `harsh_acceleration_flag` SET TAGS ('dbx_business_glossary_term' = 'Harsh Acceleration Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `harsh_braking_flag` SET TAGS ('dbx_business_glossary_term' = 'Harsh Braking Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `heading_degrees` SET TAGS ('dbx_business_glossary_term' = 'Heading (Degrees)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `ignition_state` SET TAGS ('dbx_business_glossary_term' = 'Ignition State');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `ignition_state` SET TAGS ('dbx_value_regex' = 'on|off|accessory');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'cellular|satellite|wifi');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `odometer_km` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading (Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `payload_json` SET TAGS ('dbx_business_glossary_term' = 'Raw IoT Payload (JSON)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `signal_strength` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `speed_kmh` SET TAGS ('dbx_business_glossary_term' = 'Speed (Kilometers per Hour)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`telematics_event` ALTER COLUMN `temperature_setpoint_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Profile ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `driver_licence_type_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Licence Type Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `depot_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Driver Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|suspended|terminated');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|failed|expired');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `disciplinary_flag` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Full Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `driver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `drug_test_date` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `drug_test_result` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Result');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `drug_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|pending|refused');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `drug_test_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Driver Email Address');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time_employee|part_time_employee|contractor|owner_operator|temporary');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_business_glossary_term' = 'GPS Device ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Driver Hire Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `language_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `license_categories` SET TAGS ('dbx_business_glossary_term' = 'License Categories');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `license_issue_date` SET TAGS ('dbx_business_glossary_term' = 'License Issue Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `license_issuing_country` SET TAGS ('dbx_business_glossary_term' = 'License Issuing Country');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `license_issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `license_issuing_state` SET TAGS ('dbx_business_glossary_term' = 'License Issuing State or Province');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Driver License Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Driver Performance Rating');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Driver Primary Contact Phone');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `rfid_tag_code` SET TAGS ('dbx_business_glossary_term' = 'RFID Tag ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Driver Termination Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `vehicle_type_authorization` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type Authorization');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_profile` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Driving Experience');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `fleet_driver_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Assignment ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `charge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Event Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `fatigue_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Assessment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `primary_fleet_depot_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatcher ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `tertiary_fleet_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `tertiary_fleet_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `tertiary_fleet_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `trip_id` SET TAGS ('dbx_business_glossary_term' = 'Trip ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `actual_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Datetime');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `actual_return_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Datetime');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `assignment_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Assignment Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `assignment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assignment Outcome');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'scheduled|dispatched|in_progress|completed|cancelled|suspended');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `co2_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions Kilograms');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `customer_feedback_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Score');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `dispatch_datetime` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Datetime');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `distance_actual_km` SET TAGS ('dbx_business_glossary_term' = 'Distance Actual Kilometers');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `distance_planned_km` SET TAGS ('dbx_business_glossary_term' = 'Distance Planned Kilometers');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `driver_rating` SET TAGS ('dbx_business_glossary_term' = 'Driver Rating');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `driving_hours` SET TAGS ('dbx_business_glossary_term' = 'Driving Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `fuel_consumed_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed Liters');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `hos_counter_at_end` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Counter at End');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `hos_counter_at_start` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Counter at Start');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `hos_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Violation Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `hos_violation_type` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Violation Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `planned_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Datetime');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `planned_return_datetime` SET TAGS ('dbx_business_glossary_term' = 'Planned Return Datetime');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `rest_break_hours` SET TAGS ('dbx_business_glossary_term' = 'Rest Break Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `safety_incident_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Description');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_driver_assignment` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` SET TAGS ('dbx_subdomain' = 'maintenance_compliance');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Workshop Location ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `maintenance_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `quaternary_maintenance_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `quaternary_maintenance_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `quaternary_maintenance_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Engine Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `external_service_cost` SET TAGS ('dbx_business_glossary_term' = 'External Service Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `fault_code` SET TAGS ('dbx_business_glossary_term' = 'Fault Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `fault_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `fault_description` SET TAGS ('dbx_business_glossary_term' = 'Fault Description');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `inspection_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `maintenance_category` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Category');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `maintenance_order_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `maintenance_order_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|in_progress|on_hold|completed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `maintenance_provider_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Provider Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `maintenance_provider_type` SET TAGS ('dbx_value_regex' = 'internal_workshop|external_vendor|oem_service_center|authorized_dealer');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|statutory_inspection|breakdown');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `parts_replaced_list` SET TAGS ('dbx_business_glossary_term' = 'Parts Replaced List');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `post_maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Maintenance Asset Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `post_maintenance_status` SET TAGS ('dbx_value_regex' = 'operational|limited_service|out_of_service|pending_inspection|scrapped');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `raised_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Raised Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `regulatory_inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `regulatory_inspection_type` SET TAGS ('dbx_value_regex' = 'dot_annual|icao_airworthiness|maritime_survey|emissions_test|safety_certification|none');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `total_maintenance_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Maintenance Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_value_regex' = '^WC-[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_order` ALTER COLUMN `work_performed_description` SET TAGS ('dbx_business_glossary_term' = 'Work Performed Description');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_compliance');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `maintenance_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `asset_type_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Type Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Facility ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `auto_generate_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Generate Order Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `compliance_mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Mandatory Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `downtime_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Interval Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_value_regex' = 'miles|kilometers|hours|days|cycles');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `interval_value` SET TAGS ('dbx_business_glossary_term' = 'Interval Value');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `last_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `last_completed_hours` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Engine Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `last_completed_mileage` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Mileage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `next_due_hours` SET TAGS ('dbx_business_glossary_term' = 'Next Due Engine Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `next_due_mileage` SET TAGS ('dbx_business_glossary_term' = 'Next Due Mileage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `parts_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `schedule_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Effective Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `schedule_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|completed|overdue|cancelled');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'oil_change|tire_rotation|brake_inspection|engine_overhaul|dot_annual_inspection|icao_100_hour_check');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `tolerance_after_days` SET TAGS ('dbx_business_glossary_term' = 'Tolerance After Days');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `tolerance_before_days` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Before Days');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `trigger_basis` SET TAGS ('dbx_business_glossary_term' = 'Trigger Basis');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `trigger_basis` SET TAGS ('dbx_value_regex' = 'mileage|engine_hours|calendar_days|flight_hours|operating_cycles');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` SET TAGS ('dbx_subdomain' = 'cost_routing');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Transaction ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_index_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `trip_id` SET TAGS ('dbx_business_glossary_term' = 'Trip ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `co2e_emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emission Factor');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `co2e_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Card Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_card_provider` SET TAGS ('dbx_business_glossary_term' = 'Fuel Card Provider');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_efficiency` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_station_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Station ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Station Country Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_station_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_station_location` SET TAGS ('dbx_business_glossary_term' = 'Fuel Station Location');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_station_name` SET TAGS ('dbx_business_glossary_term' = 'Fuel Station Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `is_emergency_refuel` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Refuel');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Is Reconciled');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `odometer_unit` SET TAGS ('dbx_business_glossary_term' = 'Odometer Unit');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `odometer_unit` SET TAGS ('dbx_value_regex' = 'km|miles|hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'fuel_card|credit_card|cash|invoice|direct_debit');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `supplier_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transaction_datetime` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date and Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|pending|disputed|cancelled|reversed');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'litres|gallons|kwh|kg|m3');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` SET TAGS ('dbx_subdomain' = 'maintenance_compliance');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `asset_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Inspection ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Compliance Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `critical_defects_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defects Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `defects_description` SET TAGS ('dbx_business_glossary_term' = 'Defects Description');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `defects_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Defects Identified Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_checklist_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_cost` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost Currency');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_document_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Document URL');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_location_country` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location Country');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional pass|not applicable');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in progress|completed|cancelled|deferred');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'DOT roadside inspection|ICAO airworthiness check|IMO vessel survey|pre-trip inspection|annual safety inspection|C-TPAT security inspection');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspector_authority` SET TAGS ('dbx_business_glossary_term' = 'Inspector Authority');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `odometer_reading_at_inspection` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading at Inspection');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `out_of_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Service Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `out_of_service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Out of Service Start Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `regulatory_certificate_issued` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Certificate Issued');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `reinspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_inspection` ALTER COLUMN `reinspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` SET TAGS ('dbx_subdomain' = 'asset_lifecycle');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `asset_licence_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Licence ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `endorsements` SET TAGS ('dbx_business_glossary_term' = 'Endorsements');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `inspection_authority` SET TAGS ('dbx_business_glossary_term' = 'Inspection Authority');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `licence_category` SET TAGS ('dbx_business_glossary_term' = 'Licence Category');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `licence_class` SET TAGS ('dbx_business_glossary_term' = 'Licence Class');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `licence_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Licence Fee Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `licence_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Licence Fee Currency');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `licence_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `licence_number` SET TAGS ('dbx_business_glossary_term' = 'Licence Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `licence_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `licence_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `licence_type` SET TAGS ('dbx_business_glossary_term' = 'Licence Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `renewal_reminder_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reminder Days');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `validity_status` SET TAGS ('dbx_business_glossary_term' = 'Validity Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_licence` ALTER COLUMN `validity_status` SET TAGS ('dbx_value_regex' = 'valid|expired|suspended|revoked|pending_renewal|pending_approval');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` SET TAGS ('dbx_subdomain' = 'maintenance_compliance');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Incident ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `asset_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Assignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `geofence_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Geofence Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `trip_id` SET TAGS ('dbx_business_glossary_term' = 'Trip Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `asset_damage_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Damage Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `asset_damage_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `asset_damage_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Asset Damage Estimated Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `cargo_damage_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cargo Damage Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `cargo_damage_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `cargo_damage_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Cargo Damage Estimated Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `cargo_damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Cargo Damage Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overdue');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Incident Date and Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `dot_report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'DOT (Department of Transportation) Report Submitted Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `dot_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'DOT (Department of Transportation) Reportable Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `fatality_count` SET TAGS ('dbx_business_glossary_term' = 'Fatality Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|pending_review|closed|reopened');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'accident|near_miss|breakdown|cargo_damage|security_incident|theft');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `injuries_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Injuries Reported Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `injury_count` SET TAGS ('dbx_business_glossary_term' = 'Injury Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `investigation_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assigned To');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Location Address');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Location Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `location_state_province` SET TAGS ('dbx_business_glossary_term' = 'Location State or Province');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Incident Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `police_department` SET TAGS ('dbx_business_glossary_term' = 'Police Department');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `police_report_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Police Report Filed Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `police_report_number` SET TAGS ('dbx_business_glossary_term' = 'Police Report Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `reported_datetime` SET TAGS ('dbx_business_glossary_term' = 'Reported Date and Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `third_party_contact` SET TAGS ('dbx_business_glossary_term' = 'Third Party Contact');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `third_party_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `third_party_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `third_party_insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Third Party Insurance Provider');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `third_party_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Involved Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `third_party_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `third_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `third_party_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Third Party Policy Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `third_party_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` SET TAGS ('dbx_subdomain' = 'tracking_monitoring');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `asset_utilisation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Utilisation ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Depot ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Driver ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `actual_payload_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Payload (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `co2_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_inspection|exempted');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `distance_travelled_km` SET TAGS ('dbx_business_glossary_term' = 'Distance Travelled (Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `distance_travelled_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance Travelled (Miles)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `fuel_consumed_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed (Liters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `fuel_efficiency_liters_per_100km` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency (Liters per 100 Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `fuel_efficiency_mpg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency (Miles Per Gallon)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `load_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Load Factor Percentage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Utilisation Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `number_of_trips` SET TAGS ('dbx_business_glossary_term' = 'Number of Trips');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `on_time_delivery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `operating_cost` SET TAGS ('dbx_business_glossary_term' = 'Operating Cost (OPEX)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `operating_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|idle|maintenance|breakdown|retired|reserved');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `payload_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Payload Capacity (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `reporting_period_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `revenue_generated` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generated');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `revenue_generated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `safety_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incidents Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `telematics_data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Telematics Data Quality Score');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `total_available_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Available Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `total_breakdown_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Breakdown Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `total_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Downtime Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `total_idle_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Idle Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `total_maintenance_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Maintenance Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `total_operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Operational Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `utilisation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilisation Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `volume_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Capacity (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_utilisation` ALTER COLUMN `volume_utilised_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Utilised (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` SET TAGS ('dbx_subdomain' = 'asset_lifecycle');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `asset_acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `acquisition_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Approval Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `acquisition_notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `acquisition_number` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Reference Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_progress|completed|cancelled|terminated');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_value_regex' = 'outright_purchase|finance_lease|operating_lease|hire_purchase|capital_lease|sale_and_leaseback');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `capex_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `depreciation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|lease_return|scrap|trade_in|donation|transfer');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `down_payment` SET TAGS ('dbx_business_glossary_term' = 'Down Payment');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `financing_institution` SET TAGS ('dbx_business_glossary_term' = 'Financing Institution');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `gain_loss_on_disposal` SET TAGS ('dbx_business_glossary_term' = 'Gain or Loss on Disposal');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `ifrs16_lease_liability` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Lease Liability');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `ifrs16_right_of_use_asset` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Right-of-Use (ROU) Asset');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `lease_value` SET TAGS ('dbx_business_glossary_term' = 'Lease Value');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `monthly_lease_payment` SET TAGS ('dbx_business_glossary_term' = 'Monthly Lease Payment');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `residual_value` SET TAGS ('dbx_business_glossary_term' = 'Residual Value');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Method');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|macrs|accelerated');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_acquisition` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` SET TAGS ('dbx_subdomain' = 'asset_lifecycle');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `asset_disposal_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Disposal ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `book_value_at_disposal` SET TAGS ('dbx_business_glossary_term' = 'Book Value at Disposal');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `buyer_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer or Recipient Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `buyer_recipient_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `buyer_recipient_reference` SET TAGS ('dbx_business_glossary_term' = 'Buyer or Recipient Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `decommissioning_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `deregistration_authority` SET TAGS ('dbx_business_glossary_term' = 'Deregistration Authority');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `deregistration_date` SET TAGS ('dbx_business_glossary_term' = 'Deregistration Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_costs` SET TAGS ('dbx_business_glossary_term' = 'Disposal Costs');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_country_code` SET TAGS ('dbx_business_glossary_term' = 'Disposal Country Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_location` SET TAGS ('dbx_business_glossary_term' = 'Disposal Location');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposal Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Reference Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_number` SET TAGS ('dbx_value_regex' = '^DSP-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposal Reason');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_status` SET TAGS ('dbx_business_glossary_term' = 'Disposal Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_status` SET TAGS ('dbx_value_regex' = 'initiated|approved|in_progress|completed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_type` SET TAGS ('dbx_business_glossary_term' = 'Disposal Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `disposal_type` SET TAGS ('dbx_value_regex' = 'sale|scrap|lease_return|write_off|donation|trade_in');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `environmental_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Environmental Disposal Method');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `finance_journal_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Finance Journal Entry Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `gain_loss_on_disposal` SET TAGS ('dbx_business_glossary_term' = 'Gain or Loss on Disposal');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `hazardous_materials_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `insurance_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `net_disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Net Disposal Proceeds');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_disposal` ALTER COLUMN `odometer_reading_at_disposal` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading at Disposal');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` SET TAGS ('dbx_subdomain' = 'tracking_monitoring');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `rfid_scan_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Scan ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Scan Location ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `antenna_code` SET TAGS ('dbx_business_glossary_term' = 'Antenna ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `chain_of_custody_verified` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Verified');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'pending|processed|validated|rejected|archived');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `read_count` SET TAGS ('dbx_business_glossary_term' = 'Read Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `reader_device_code` SET TAGS ('dbx_business_glossary_term' = 'Reader Device ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `reader_device_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `reader_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `reader_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `rfid_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `rfid_tag_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,24}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `scan_direction` SET TAGS ('dbx_business_glossary_term' = 'Scan Direction');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `scan_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|internal_transfer|unknown');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `scan_event_type` SET TAGS ('dbx_business_glossary_term' = 'Scan Event Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `scan_location_name` SET TAGS ('dbx_business_glossary_term' = 'Scan Location Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `scan_location_type` SET TAGS ('dbx_business_glossary_term' = 'Scan Location Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `scan_source_system` SET TAGS ('dbx_business_glossary_term' = 'Scan Source System');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `scan_status` SET TAGS ('dbx_business_glossary_term' = 'Scan Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `scan_status` SET TAGS ('dbx_value_regex' = 'successful|failed|partial|duplicate|exception');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scan Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `scan_zone` SET TAGS ('dbx_business_glossary_term' = 'Scan Zone');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength (dBm)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`rfid_scan` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` SET TAGS ('dbx_subdomain' = 'asset_lifecycle');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `tyre_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tyre Record ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Tyre Condition Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'serviceable|worn|damaged|retreaded|condemned');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `current_tread_depth_mm` SET TAGS ('dbx_business_glossary_term' = 'Current Tread Depth (Millimeters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Tyre Disposal Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'recycling|landfill|energy_recovery|resale');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `disposal_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposal Reason Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `disposal_reason` SET TAGS ('dbx_value_regex' = 'end_of_life|damage|safety_failure|irregular_wear|sidewall_damage|puncture');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `fitment_date` SET TAGS ('dbx_business_glossary_term' = 'Tyre Fitment Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `fitment_odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading at Fitment');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `initial_tread_depth_mm` SET TAGS ('dbx_business_glossary_term' = 'Initial Tread Depth (Millimeters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Tyre Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `last_retread_date` SET TAGS ('dbx_business_glossary_term' = 'Last Retread Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `last_rotation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Tyre Rotation Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `load_index` SET TAGS ('dbx_business_glossary_term' = 'Tyre Load Index');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `load_index` SET TAGS ('dbx_value_regex' = '^[0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Tyre Manufacturer');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Tyre Model');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tyre Record Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Axle Position Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^(FL|FR|RL1|RL2|RR1|RR2|SPARE)$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Recommended Tyre Pressure (PSI)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `purchase_cost` SET TAGS ('dbx_business_glossary_term' = 'Tyre Purchase Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Tyre Purchase Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Tyre Removal Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `removal_odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading at Removal');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `retread_count` SET TAGS ('dbx_business_glossary_term' = 'Retread Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `retread_vendor` SET TAGS ('dbx_business_glossary_term' = 'Retread Vendor Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Tag ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{16,24}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `rotation_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Tyre Rotation Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `season_type` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Tyre Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `season_type` SET TAGS ('dbx_value_regex' = 'all_season|summer|winter');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Tyre Serial Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `size_specification` SET TAGS ('dbx_business_glossary_term' = 'Tyre Size Specification');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `size_specification` SET TAGS ('dbx_value_regex' = '^[0-9]{3}/[0-9]{2}R[0-9]{2}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `speed_rating` SET TAGS ('dbx_business_glossary_term' = 'Tyre Speed Rating');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `speed_rating` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Tyre Supplier Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `tread_pattern` SET TAGS ('dbx_business_glossary_term' = 'Tread Pattern Designation');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `tyre_mileage_km` SET TAGS ('dbx_business_glossary_term' = 'Tyre Accumulated Mileage (Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `tyre_type` SET TAGS ('dbx_business_glossary_term' = 'Tyre Construction Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `tyre_type` SET TAGS ('dbx_value_regex' = 'radial|bias|run_flat');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`tyre_record` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `hos_log_id` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Log ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `fatigue_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Assessment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `fleet_driver_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Driver Assignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `trip_id` SET TAGS ('dbx_business_glossary_term' = 'Trip Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `break_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Break Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `carrier_usdot_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier United States Department of Transportation (USDOT) Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `carrier_usdot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,8}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Certification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `cycle_hours_60_7` SET TAGS ('dbx_business_glossary_term' = 'Cycle Hours 60/7');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `cycle_hours_70_8` SET TAGS ('dbx_business_glossary_term' = 'Cycle Hours 70/8');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'automatic|manual|edited');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `distance_driven_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance Driven Miles');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `driving_hours_day` SET TAGS ('dbx_business_glossary_term' = 'Driving Hours Day');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `duty_status` SET TAGS ('dbx_business_glossary_term' = 'Duty Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `duty_status` SET TAGS ('dbx_value_regex' = 'off_duty|sleeper_berth|driving|on_duty_not_driving');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `duty_status_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duty Status Duration Minutes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `duty_status_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Duty Status End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `duty_status_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Duty Status Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `edit_flag` SET TAGS ('dbx_business_glossary_term' = 'Edit Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `edit_reason` SET TAGS ('dbx_business_glossary_term' = 'Edit Reason');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `edit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Edit Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `eld_device_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Logging Device (ELD) Device ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `eld_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `eld_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `eld_firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Logging Device (ELD) Firmware Version');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `eld_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Electronic Logging Device (ELD) Manufacturer');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `last_break_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Break Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `log_date` SET TAGS ('dbx_business_glossary_term' = 'Log Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `odometer_end` SET TAGS ('dbx_business_glossary_term' = 'Odometer End');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `odometer_start` SET TAGS ('dbx_business_glossary_term' = 'Odometer Start');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `on_duty_hours_day` SET TAGS ('dbx_business_glossary_term' = 'On-Duty Hours Day');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `shipment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `violation_severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `violation_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`hos_log` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = '11_hour_driving|14_hour_on_duty|70_hour_8_day|60_hour_7_day|30_min_break|10_hour_off_duty');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` SET TAGS ('dbx_subdomain' = 'maintenance_compliance');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Depot Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `container_capacity_teu` SET TAGS ('dbx_business_glossary_term' = 'Container Capacity in Twenty-foot Equivalent Units (TEU)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `covered_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Covered Area in Square Meters');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `customs_bonded_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Bonded Facility Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `depot_code` SET TAGS ('dbx_business_glossary_term' = 'Depot Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `depot_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `depot_name` SET TAGS ('dbx_business_glossary_term' = 'Depot Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `depot_type` SET TAGS ('dbx_business_glossary_term' = 'Depot Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `depot_type` SET TAGS ('dbx_value_regex' = 'vehicle_depot|maintenance_workshop|fuel_station|container_yard|inland_container_depot|staging_area');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `electric_charging_stations` SET TAGS ('dbx_business_glossary_term' = 'Electric Charging Stations');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `ftz_designation` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Designation');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `fuel_types_available` SET TAGS ('dbx_business_glossary_term' = 'Fuel Types Available');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `maintenance_bays` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Bays');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `managing_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Managing Business Unit');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `operates_24_7_flag` SET TAGS ('dbx_business_glossary_term' = 'Operates 24/7 Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|temporarily_closed|decommissioned|planned');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|operated_under_contract|joint_venture');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Business Region');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|high_security|restricted_access');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `total_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Total Area in Square Meters');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot` ALTER COLUMN `vehicle_capacity` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Capacity');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` SET TAGS ('dbx_subdomain' = 'asset_lifecycle');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `asset_type_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Type ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `asset_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Asset Subcategory');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `asset_type_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Type Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `asset_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `asset_type_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Type Description');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `asset_type_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Type Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `asset_type_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Type Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `asset_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `average_acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Average Acquisition Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `average_acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `certification_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Certification Interval (Months)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `dot_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Classification Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `dot_classification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `emission_standard` SET TAGS ('dbx_business_glossary_term' = 'Emission Standard');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `fuel_type_standard` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type Standard');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `hazmat_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Capable Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `iata_classification_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Classification Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `iata_classification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `imo_classification_code` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Organization (IMO) Classification Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `imo_classification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `iso_container_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Container Type Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `iso_container_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Typical Maintenance Interval (Days)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `maintenance_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'Typical Maintenance Interval (Operating Hours)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `maintenance_interval_km` SET TAGS ('dbx_business_glossary_term' = 'Typical Maintenance Interval (Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Ownership Model');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `ownership_model` SET TAGS ('dbx_value_regex' = 'owned|leased|mixed|third_party');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'dot|icao|imo|iso|fmc|mixed');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `rfid_tagging_standard_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tagging Standard Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `standard_height_m` SET TAGS ('dbx_business_glossary_term' = 'Standard Height (Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `standard_length_m` SET TAGS ('dbx_business_glossary_term' = 'Standard Length (Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `standard_payload_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Standard Payload Capacity (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `standard_temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Standard Temperature Range Maximum (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `standard_temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Standard Temperature Range Minimum (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `standard_teu_capacity` SET TAGS ('dbx_business_glossary_term' = 'Standard Twenty-Foot Equivalent Unit (TEU) Capacity');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `standard_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Standard Useful Life (Years)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `standard_volume_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Standard Volume Capacity (Cubic Meters / CBM)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `standard_width_m` SET TAGS ('dbx_business_glossary_term' = 'Standard Width (Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `telematics_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Telematics Capable Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_type` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `driver_licence_type_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Licence Type ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `superseded_by_licence_type_driver_licence_type_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Licence Type ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `double_triple_trailer_eligible` SET TAGS ('dbx_business_glossary_term' = 'Double/Triple Trailer Endorsement Eligible');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `flight_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Flight Hours Required');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `hazmat_endorsement_eligible` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Endorsement Eligible');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `international_recognition_scope` SET TAGS ('dbx_business_glossary_term' = 'International Recognition Scope');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `issuing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `issuing_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{2,5})?$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `licence_category_name` SET TAGS ('dbx_business_glossary_term' = 'Licence Category Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `licence_class` SET TAGS ('dbx_business_glossary_term' = 'Licence Class');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `licence_type_code` SET TAGS ('dbx_business_glossary_term' = 'Licence Type Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `licence_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `licence_validity_period_years` SET TAGS ('dbx_business_glossary_term' = 'Licence Validity Period (Years)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `max_vehicle_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Vehicle Weight (kg)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `medical_certificate_class` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Class');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `medical_certificate_class` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `medical_certificate_class` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Required');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `medical_renewal_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Renewal Interval (Months)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `medical_renewal_interval_months` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `medical_renewal_interval_months` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `minimum_age_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age (Years)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `passenger_capacity_permitted` SET TAGS ('dbx_business_glossary_term' = 'Passenger Capacity Permitted');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `practical_exam_required` SET TAGS ('dbx_business_glossary_term' = 'Practical Examination Required');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `reciprocity_recognized` SET TAGS ('dbx_business_glossary_term' = 'Reciprocity Recognized');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `renewal_grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Grace Period (Days)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `sea_service_months_required` SET TAGS ('dbx_business_glossary_term' = 'Sea Service Months Required');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `tanker_endorsement_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tanker Endorsement Eligible');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `training_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Required');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|air|sea|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `vehicle_types_permitted` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Types Permitted');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_licence_type` ALTER COLUMN `written_exam_required` SET TAGS ('dbx_business_glossary_term' = 'Written Examination Required');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` SET TAGS ('dbx_subdomain' = 'tracking_monitoring');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `geofence_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Geofence Zone ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `parent_zone_geofence_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Zone ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_value_regex' = 'unrestricted|authorized_only|permit_required|prohibited');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `applicable_asset_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Asset Types');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `boundary_geometry` SET TAGS ('dbx_business_glossary_term' = 'Boundary Geometry');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `center_latitude` SET TAGS ('dbx_business_glossary_term' = 'Center Latitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `center_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `center_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `center_longitude` SET TAGS ('dbx_business_glossary_term' = 'Center Longitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `center_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `center_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `city_name` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_value_regex' = 'WGS84|NAD83|ETRS89');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `curfew_end_time` SET TAGS ('dbx_business_glossary_term' = 'Curfew End Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `curfew_start_time` SET TAGS ('dbx_business_glossary_term' = 'Curfew Start Time');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `dwell_time_threshold_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time Threshold Minutes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `emission_standard_required` SET TAGS ('dbx_business_glossary_term' = 'Emission Standard Required');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `emission_standard_required` SET TAGS ('dbx_value_regex' = 'EURO_3|EURO_4|EURO_5|EURO_6|EPA_2007|EPA_2010');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `entry_alert_enabled` SET TAGS ('dbx_business_glossary_term' = 'Entry Alert Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `exit_alert_enabled` SET TAGS ('dbx_business_glossary_term' = 'Exit Alert Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `hazmat_classes_prohibited` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Classes Prohibited');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `hazmat_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Restriction Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `height_limit_meters` SET TAGS ('dbx_business_glossary_term' = 'Height Limit Meters');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `speed_limit_kmh` SET TAGS ('dbx_business_glossary_term' = 'Speed Limit Kilometers Per Hour (KMH)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State Province Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `weight_limit_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Limit Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `zone_area_sqkm` SET TAGS ('dbx_business_glossary_term' = 'Zone Area Square Kilometers');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `zone_radius_meters` SET TAGS ('dbx_business_glossary_term' = 'Zone Radius Meters');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `zone_subtype` SET TAGS ('dbx_business_glossary_term' = 'Zone Subtype');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'depot_perimeter|restricted_area|customs_zone|ftz|low_emission_zone|speed_restriction_zone');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` SET TAGS ('dbx_subdomain' = 'cost_routing');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `asset_cost_record_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Cost Record ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|auto_approved');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `cost_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `cost_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Description');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `cost_record_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Cost Record Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `cost_record_number` SET TAGS ('dbx_value_regex' = '^ACR-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `cost_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Cost Subcategory');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Engine Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `insurance_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading (km)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|overdue|disputed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `service_location` SET TAGS ('dbx_business_glossary_term' = 'Service Location');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `service_location_country` SET TAGS ('dbx_business_glossary_term' = 'Service Location Country');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `service_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_cost_record` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` SET TAGS ('dbx_subdomain' = 'tracking_monitoring');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `reefer_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Reefer Monitoring ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `actual_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `alarm_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `alarm_severity` SET TAGS ('dbx_business_glossary_term' = 'Alarm Severity');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `alarm_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `alarm_type` SET TAGS ('dbx_value_regex' = 'temperature_excursion|power_failure|door_open|humidity_deviation|equipment_malfunction|sensor_fault');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery Level Percentage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `cargo_type` SET TAGS ('dbx_business_glossary_term' = 'Cargo Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `cargo_type` SET TAGS ('dbx_value_regex' = 'pharmaceutical|perishable_food|frozen_food|fresh_produce|chemicals|biologics');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `co2_level_ppm` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Level (Parts Per Million)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `communication_method` SET TAGS ('dbx_business_glossary_term' = 'Communication Method');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `communication_method` SET TAGS ('dbx_value_regex' = 'satellite|cellular|wifi|manual');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|warning|under_review');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `compressor_running_flag` SET TAGS ('dbx_business_glossary_term' = 'Compressor Running Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|estimated');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `defrost_cycle_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Defrost Cycle Active Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `door_open_flag` SET TAGS ('dbx_business_glossary_term' = 'Door Open Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `excursion_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Excursion Duration (Minutes)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `monitoring_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `o2_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Oxygen (O2) Level Percentage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `power_source_status` SET TAGS ('dbx_business_glossary_term' = 'Power Source Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `power_source_status` SET TAGS ('dbx_value_regex' = 'plugged_in|genset|battery|offline');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `power_voltage` SET TAGS ('dbx_business_glossary_term' = 'Power Voltage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `regulatory_regime` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Regime');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `regulatory_regime` SET TAGS ('dbx_value_regex' = 'fda|eu_gdp|who_prequalification|haccp|fsma');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `return_air_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Return Air Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `setpoint_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `shipper_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Shipper Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `supply_air_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Supply Air Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`reefer_monitoring` ALTER COLUMN `temperature_deviation_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Deviation (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` SET TAGS ('dbx_subdomain' = 'cost_routing');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Toll Record ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Toll Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `trip_id` SET TAGS ('dbx_business_glossary_term' = 'Trip ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `axle_count` SET TAGS ('dbx_business_glossary_term' = 'Axle Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `direction_of_travel` SET TAGS ('dbx_business_glossary_term' = 'Direction of Travel');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `direction_of_travel` SET TAGS ('dbx_value_regex' = 'northbound|southbound|eastbound|westbound|inbound|outbound');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'transponder|cash|credit_card|fleet_account|invoice');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|disputed|overdue|waived|refunded');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_amount` SET TAGS ('dbx_business_glossary_term' = 'Toll Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_city` SET TAGS ('dbx_business_glossary_term' = 'Toll City');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_country_code` SET TAGS ('dbx_business_glossary_term' = 'Toll Country Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Toll Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_location_code` SET TAGS ('dbx_business_glossary_term' = 'Toll Location Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_location_name` SET TAGS ('dbx_business_glossary_term' = 'Toll Location Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_location_type` SET TAGS ('dbx_business_glossary_term' = 'Toll Location Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_location_type` SET TAGS ('dbx_value_regex' = 'road|bridge|tunnel|port|congestion_zone|border_crossing');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_operator_code` SET TAGS ('dbx_business_glossary_term' = 'Toll Operator Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Toll Operator Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_plaza_lane` SET TAGS ('dbx_business_glossary_term' = 'Toll Plaza Lane');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_state_province` SET TAGS ('dbx_business_glossary_term' = 'Toll State or Province');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `toll_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Toll Transaction Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `total_toll_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Toll Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `transponder_code` SET TAGS ('dbx_business_glossary_term' = 'Transponder ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`toll_record` ALTER COLUMN `vehicle_class` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` SET TAGS ('dbx_subdomain' = 'asset_lifecycle');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `asset_insurance_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Insurance ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `aggregate_limit` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Coverage Limit');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `broker_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Reference Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Cancellation Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Policy Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `claims_history_count` SET TAGS ('dbx_business_glossary_term' = 'Claims History Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `coverage_territory` SET TAGS ('dbx_business_glossary_term' = 'Coverage Geographic Territory');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Deductible Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `endorsements` SET TAGS ('dbx_business_glossary_term' = 'Policy Endorsements');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Policy Exclusions');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `fleet_wide_policy_flag` SET TAGS ('dbx_business_glossary_term' = 'Fleet-Wide Policy Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `insured_value` SET TAGS ('dbx_business_glossary_term' = 'Insured Asset Value');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `insurer_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `last_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Last Claim Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `policy_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Reference');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `policy_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Issue Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|pending_renewal|suspended|lapsed');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'comprehensive|third_party_liability|cargo_liability|hull|physical_damage|business_interruption');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `total_claims_paid` SET TAGS ('dbx_business_glossary_term' = 'Total Claims Paid Amount');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_insurance` ALTER COLUMN `underwriter_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Underwriter Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `driver_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Performance ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `driver_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Safety Event Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Supervisor ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `trip_id` SET TAGS ('dbx_business_glossary_term' = 'Trip ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `co2_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `coaching_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Coaching Required Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `customer_feedback_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Score');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `eco_driving_score` SET TAGS ('dbx_business_glossary_term' = 'Eco-Driving Score');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|reviewed|approved|disputed');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'trip|daily|weekly|monthly');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `fatigue_alert_count` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Alert Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `forward_collision_warning_count` SET TAGS ('dbx_business_glossary_term' = 'Forward Collision Warning (FCW) Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `fuel_consumed_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed Liters');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `fuel_efficiency_actual_km_per_liter` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency Actual Kilometers Per Liter (KM/L)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `fuel_efficiency_benchmark_km_per_liter` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency Benchmark Kilometers Per Liter (KM/L)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `fuel_efficiency_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency Variance Percent');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `geofence_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Geofence Violation Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `harsh_acceleration_events_count` SET TAGS ('dbx_business_glossary_term' = 'Harsh Acceleration Events Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `harsh_braking_events_count` SET TAGS ('dbx_business_glossary_term' = 'Harsh Braking Events Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `hos_available_drive_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Available Drive Time Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `hos_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `hos_violation_type` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Violation Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `hos_violation_type` SET TAGS ('dbx_value_regex' = 'none|11_hour_driving_limit|14_hour_duty_limit|30_minute_break|60_70_hour_limit|sleeper_berth');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `idling_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Idling Time Minutes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `incentive_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `incident_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `incident_severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `incident_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|critical');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `lane_departure_count` SET TAGS ('dbx_business_glossary_term' = 'Lane Departure Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `mobile_phone_usage_events_count` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Usage Events Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `mobile_phone_usage_events_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `mobile_phone_usage_events_count` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `night_driving_hours` SET TAGS ('dbx_business_glossary_term' = 'Night Driving Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `on_time_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `route_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Route Deviation Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `safety_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Safety Score');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `seatbelt_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Seatbelt Violation Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `speeding_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Speeding Duration Minutes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `speeding_events_count` SET TAGS ('dbx_business_glossary_term' = 'Speeding Events Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_business_glossary_term' = 'Telematics Device ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `total_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Total Distance Kilometers (KM)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_performance` ALTER COLUMN `total_driving_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Driving Time Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` SET TAGS ('dbx_subdomain' = 'tracking_monitoring');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `asset_position_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Position ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `asset_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Current Assignment ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `geofence_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Geofence Zone ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Next Waypoint Location ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `altitude_m` SET TAGS ('dbx_business_glossary_term' = 'Altitude (Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `battery_voltage` SET TAGS ('dbx_business_glossary_term' = 'Battery Voltage');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|stale|interpolated|estimated');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `distance_to_next_waypoint_km` SET TAGS ('dbx_business_glossary_term' = 'Distance to Next Waypoint (Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `eta_next_waypoint` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA) Next Waypoint');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `fuel_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Level (Percent)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `gps_accuracy_m` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Accuracy (Meters)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `gps_satellite_count` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Satellite Count');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `heading_degrees` SET TAGS ('dbx_business_glossary_term' = 'Heading (Degrees)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `ignition_state` SET TAGS ('dbx_business_glossary_term' = 'Ignition State');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `ignition_state` SET TAGS ('dbx_value_regex' = 'on|off|unknown');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `next_waypoint_name` SET TAGS ('dbx_business_glossary_term' = 'Next Waypoint Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `odometer_km` SET TAGS ('dbx_business_glossary_term' = 'Odometer (Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `position_age_minutes` SET TAGS ('dbx_business_glossary_term' = 'Position Age (Minutes)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `position_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Position Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `rfid_tag_code` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Tag ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `speed_kmh` SET TAGS ('dbx_business_glossary_term' = 'Speed (Kilometers per Hour)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_business_glossary_term' = 'Telematics Device ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`asset_position` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` SET TAGS ('dbx_subdomain' = 'maintenance_compliance');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` SET TAGS ('dbx_association_edges' = 'fleet.fleet_depot,sustainability.sustainability_initiative');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `depot_initiative_implementation_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Initiative Implementation ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Initiative Implementation - Fleet Depot Id');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Initiative Implementation - Sustainability Initiative Id');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Site Lead Employee ID');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `baseline_co2e_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Baseline CO2e Emissions');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `baseline_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Measurement Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `capex_allocated` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Allocated');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `co2e_reduction_actual_tco2e` SET TAGS ('dbx_business_glossary_term' = 'CO2e Reduction Actual');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `co2e_reduction_target_tco2e` SET TAGS ('dbx_business_glossary_term' = 'CO2e Reduction Target');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `implementation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `implementation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Implementation Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_initiative_implementation` ALTER COLUMN `opex_allocated` SET TAGS ('dbx_business_glossary_term' = 'OPEX Allocated');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` SET TAGS ('dbx_subdomain' = 'maintenance_compliance');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` SET TAGS ('dbx_association_edges' = 'fleet.fleet_depot,customs.compliance_program');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `depot_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Certification Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Certification - Compliance Program Id');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Certification - Fleet Depot Id');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `fleet_depot_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Depot Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Audit Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Facility Audit Score');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `certification_notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `facility_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Certification Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Facility Audit Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`depot_certification` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Facility Security Level');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` SET TAGS ('dbx_association_edges' = 'fleet.driver_profile,customs.compliance_program');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `driver_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Certification Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Profile Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Program-Specific Background Check Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `certifying_officer` SET TAGS ('dbx_business_glossary_term' = 'Certifying Officer');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `dangerous_goods_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `dangerous_goods_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'IATA Dangerous Goods Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `hazmat_endorsement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Endorsement Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `hazmat_endorsement_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Endorsement Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `last_safety_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Training Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'DOT Medical Certificate Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `next_safety_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Safety Training Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `next_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` SET TAGS ('dbx_association_edges' = 'fleet.driver_profile,network.carrier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `driver_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Engagement Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Engagement - Carrier Id');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Engagement - Driver Profile Id');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Engagement Flag');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `carrier_specific_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Carrier-Specific Training Completed');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `carrier_specific_training_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier-Specific Training Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `driver_engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `last_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assignment Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`driver_engagement` ALTER COLUMN `total_assignments_completed` SET TAGS ('dbx_business_glossary_term' = 'Total Assignments Completed');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` SET TAGS ('dbx_association_edges' = 'fleet.driver_profile,safety.safety_training');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `fleet_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'fleet_training_completion Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Driver Profile Id');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `workforce_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Safety Training Id');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `attendance_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Attendance Hours');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Training Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Training Instructor Name');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Training Pass/Fail Status');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Location');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`fleet_training_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` SET TAGS ('dbx_subdomain' = 'cost_routing');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ALTER COLUMN `trip_id` SET TAGS ('dbx_business_glossary_term' = 'Trip Identifier');
ALTER TABLE `transport_shipping_ecm`.`fleet`.`trip` ALTER COLUMN `return_trip_id` SET TAGS ('dbx_self_ref_fk' = 'true');
