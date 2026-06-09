-- Schema for Domain: fleet | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`fleet` COMMENT 'Management of all mobile assets including collection trucks (ASL, FEL, REL), transfer vehicles, roll-off trucks, CNG/RNG-fueled units, and support vehicles. Tracks vehicle inventory, specifications, fuel types (diesel, CNG, RNG), telematics data (GPS, fuel consumption, idle time), driver behavior, DOT compliance, CDL driver assignments, vehicle registration, and utilization metrics. Integrates with Geotab Fleet Telematics and Infor EAM. Supports DOT/FMCSA regulatory compliance and fleet KPI reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'Unique identifier for the vehicle. Primary key for the vehicle master record.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Vehicles are assigned to service areas for operational planning, territory coverage, franchise compliance, and vehicle deployment optimization. Essential for territory-based fleet management and regul',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Dedicated fleet model: vehicles assigned exclusively to specific customer contracts for guaranteed service capacity. Critical for contract compliance tracking, cost allocation, and SLA performance mea',
    `district_id` BIGINT COMMENT 'Identifier of the operational district to which this vehicle is assigned.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: Fleet vehicles are direct Scope 1 mobile emission sources under EPA GHGRP and GHG Protocol. Each vehicle must link to its emission_source record for regulatory reporting, carbon accounting, and ESG di',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Every vehicle is a capitalized fixed asset requiring depreciation tracking, book value reporting, and financial statement presentation. This link is fundamental to asset accounting and enables total c',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: Vehicles designated for specific inter-facility hauling contracts, tracking which trucks are authorized/qualified for contracted hauling lanes. Essential for hauling agreement compliance, insurance ve',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Vehicles undergo DOT roadside inspections, annual emissions testing, and safety inspections. Fleet managers track last inspection results to schedule corrective actions and maintain CSA scores. Direct',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Waste collection vehicles require operating permits for air emissions, hazmat transport, and noise ordinances. Regulatory compliance officers track permit status per vehicle for DOT/EPA audits. Natura',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fleet operations track primary assigned operator for maintenance scheduling, insurance rating, asset accountability, and lifecycle cost allocation beyond temporary driver assignments in vehicle_assign',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Waste collection vehicles are often assigned to deliver to specific WTE facilities as their primary disposal destination. Operations teams need to track which vehicles regularly service which energy f',
    `vehicle_class_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_class. Business justification: Vehicle references its classification for standardized specifications, PM intervals, cost benchmarks, and operational parameters. The vehicle table currently has a vehicle_class STRING attribute that ',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire the vehicle including purchase price, taxes, and fees, measured in USD.',
    `acquisition_date` DATE COMMENT 'Date the vehicle was acquired by Waste Management through purchase, lease, or other means.',
    `axle_configuration` STRING COMMENT 'Axle arrangement of the vehicle (e.g., 4x2, 6x4, 8x4) indicating total wheels and driven wheels.',
    `body_capacity_cubic_yards` DECIMAL(18,2) COMMENT 'Maximum volume capacity of the vehicle body measured in cubic yards.',
    `body_type` STRING COMMENT 'Type of vehicle body configuration. ASL = Automated Side Loader, FEL = Front End Loader, REL = Rear End Loader. [ENUM-REF-CANDIDATE: ASL|FEL|REL|Roll-Off|Transfer Tractor|Service Truck|Pickup|Van|Other — 9 candidates stripped; promote to reference product]',
    `cdl_required_flag` BOOLEAN COMMENT 'Indicates whether a Commercial Driver License (CDL) is required to operate this vehicle based on GVWR and vehicle class.',
    `compaction_type` STRING COMMENT 'Type of waste compaction mechanism installed on the vehicle body.. Valid values are `Packer|Compactor|Non-Compacting|N/A`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vehicle record was first created in the system.',
    `current_engine_hours` STRING COMMENT 'Most recent engine hour meter reading recorded for the vehicle.',
    `current_odometer_miles` STRING COMMENT 'Most recent odometer reading recorded for the vehicle, measured in miles.',
    `disposal_date` DATE COMMENT 'Date the vehicle was retired, sold, or otherwise disposed of from the active fleet.',
    `dot_number` STRING COMMENT 'DOT registration number assigned to the vehicle for interstate commerce compliance.',
    `emissions_certification` STRING COMMENT 'EPA emissions standard certification level (e.g., EPA 2010, EPA 2021, CARB compliant).',
    `engine_make` STRING COMMENT 'Manufacturer of the engine installed in the vehicle (e.g., Cummins, Detroit Diesel, Paccar).',
    `engine_model` STRING COMMENT 'Specific model designation of the engine.',
    `engine_serial_number` STRING COMMENT 'Unique serial number assigned to the engine by the manufacturer for warranty and service tracking.',
    `fuel_tank_capacity_gallons` DECIMAL(18,2) COMMENT 'Total fuel tank capacity measured in gallons (or gallon-equivalent for CNG/RNG).',
    `fuel_type` STRING COMMENT 'Primary fuel type used by the vehicle. CNG = Compressed Natural Gas, RNG = Renewable Natural Gas.. Valid values are `Diesel|CNG|RNG|Gasoline|Electric|Hybrid`',
    `gvwr` STRING COMMENT 'Maximum operating weight of the vehicle including chassis, body, engine, fuel, driver, passengers, and cargo, measured in pounds.',
    `home_yard_location` STRING COMMENT 'Name or identifier of the primary yard or facility where the vehicle is based for daily operations.',
    `hydraulic_system_type` STRING COMMENT 'Type of hydraulic system used for compaction and lifting operations (applicable to collection vehicles).',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance coverage for this vehicle.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent DOT or safety inspection performed on the vehicle.',
    `license_plate` STRING COMMENT 'Current license plate number registered with the Department of Transportation (DOT) for this vehicle.',
    `lift_mechanism` STRING COMMENT 'Type of lifting mechanism used to pick up and empty containers or bins. [ENUM-REF-CANDIDATE: Automated Arm|Manual|Front Forks|Rear Forks|Hook Lift|Cable Hoist|N/A — 7 candidates stripped; promote to reference product]',
    `make` STRING COMMENT 'Manufacturer of the vehicle (e.g., Mack, Peterbilt, Freightliner, International).',
    `model` STRING COMMENT 'Specific model designation of the vehicle as assigned by the manufacturer.',
    `model_year` STRING COMMENT 'Year the vehicle was manufactured as designated by the manufacturer.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vehicle record was last modified in the system.',
    `next_pm_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance service based on time or usage intervals.',
    `operational_status` STRING COMMENT 'Current operational status of the vehicle in the fleet lifecycle.. Valid values are `Active|Out of Service|Maintenance|Retired|Sold|Totaled`',
    `ownership_type` STRING COMMENT 'Indicates whether the vehicle is owned outright, leased, or rented by Waste Management.. Valid values are `Owned|Leased|Rental`',
    `payload_capacity_lbs` STRING COMMENT 'Maximum weight of waste or cargo the vehicle can legally carry, measured in pounds.',
    `registration_expiration_date` DATE COMMENT 'Date when the current DOT vehicle registration expires and must be renewed.',
    `telematics_device_code` STRING COMMENT 'Unique identifier of the GPS/telematics device installed on the vehicle for tracking and monitoring (e.g., Geotab device ID).',
    `transmission_type` STRING COMMENT 'Type of transmission installed in the vehicle.. Valid values are `Manual|Automatic|Automated Manual`',
    `unit_number` STRING COMMENT 'Fleet-assigned unique unit identifier displayed on the vehicle for operational tracking and dispatch purposes.. Valid values are `^[A-Z0-9]{4,12}$`',
    `vin` STRING COMMENT '17-character Vehicle Identification Number assigned by the manufacturer. Used for registration, insurance, and warranty tracking.. Valid values are `^[A-HJ-NPR-Z0-9]{17}$`',
    CONSTRAINT pk_vehicle PRIMARY KEY(`vehicle_id`)
) COMMENT 'Master record for every mobile asset in the Waste Management fleet including ASL (Automated Side Loader), FEL (Front End Loader), REL (Rear End Loader), roll-off trucks, transfer tractors, CNG/RNG-fueled units, and support vehicles. Captures vehicle identification (VIN, unit number, license plate), make, model, year, body type, fuel type, GVWR, axle configuration, DOT registration number, acquisition date and cost, current odometer and engine hours, operational status, assigned district/division, home yard, and detailed technical specifications (engine, transmission, hydraulic system, compaction type, lift mechanism, body capacity, payload capacity, fuel tank capacity, emissions certification). This is the SSOT for vehicle identity and specifications in the fleet domain.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` (
    `vehicle_registration_id` BIGINT COMMENT 'Unique identifier for the vehicle registration record. Primary key.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: IFTA, IRP, and UCR registrations are regulatory permits/authorizations required for interstate commerce. Fleet compliance managers track registration permits alongside facility operating permits for u',
    `vehicle_id` BIGINT COMMENT 'Reference to the fleet vehicle unit that this registration record applies to.',
    `annual_inspection_due_date` DATE COMMENT 'Date by which the vehicle must complete its annual DOT safety inspection to maintain compliance. Failure to inspect by this date results in out-of-service status.',
    `cab_card_storage_location` STRING COMMENT 'Physical or digital location where the IRP cab card (registration document) is stored. Cab cards must be carried in the vehicle at all times for roadside inspection readiness.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vehicle registration record was first created in the system. Used for audit trail and data lineage.',
    `dot_number` STRING COMMENT 'Unique identifier assigned by the Federal Motor Carrier Safety Administration (FMCSA) to commercial motor carriers. Required for interstate commerce and displayed on vehicle.. Valid values are `^[0-9]{1,8}$`',
    `effective_date` DATE COMMENT 'Date when the vehicle registration becomes valid and the vehicle is legally authorized to operate on public roads.',
    `expiration_date` DATE COMMENT 'Date when the vehicle registration expires and must be renewed to maintain legal operation. Critical for compliance tracking and renewal scheduling.',
    `fuel_type` STRING COMMENT 'Primary fuel type for the vehicle as recorded on the registration. CNG = Compressed Natural Gas, RNG = Renewable Natural Gas. Impacts IFTA reporting and environmental compliance.. Valid values are `diesel|CNG|RNG|gasoline|electric|hybrid`',
    `gross_vehicle_weight` STRING COMMENT 'Maximum allowable weight of the vehicle including cargo, as registered with the state DMV. Measured in pounds. Determines registration class and fee structure.',
    `ifta_decal_number` STRING COMMENT 'Unique identifier for the IFTA decal affixed to the vehicle. IFTA simplifies fuel tax reporting for commercial vehicles operating across multiple jurisdictions.. Valid values are `^[A-Z0-9]{1,20}$`',
    `ifta_expiration_date` DATE COMMENT 'Date when the IFTA decal expires and must be renewed. Typically aligns with calendar year end.',
    `irp_apportioned_flag` BOOLEAN COMMENT 'Indicates whether this vehicle is registered under the International Registration Plan (IRP), which allows commercial vehicles to travel across multiple jurisdictions with a single registration and apportioned fees.',
    `irp_base_jurisdiction` STRING COMMENT 'Two-letter state or province code representing the base jurisdiction for IRP apportionment. This is where the carrier maintains its principal place of business.. Valid values are `^[A-Z]{2}$`',
    `irp_fleet_number` STRING COMMENT 'Unique fleet identifier assigned under the IRP program. Used for tracking and reporting across multiple jurisdictions.. Valid values are `^[A-Z0-9]{1,15}$`',
    `issuing_state` STRING COMMENT 'Two-letter state code where the vehicle registration was issued (e.g., TX, CA, IL).. Valid values are `^[A-Z]{2}$`',
    `last_inspection_date` DATE COMMENT 'Date when the vehicle last completed a DOT annual safety inspection. Used to calculate next inspection due date.',
    `lien_holder_name` STRING COMMENT 'Name of the financial institution or entity holding a lien on the vehicle, if applicable. Recorded on the title and registration documents.',
    `mc_number` STRING COMMENT 'Operating authority number issued by FMCSA for carriers transporting regulated commodities in interstate commerce. Not all vehicles require an MC number.. Valid values are `^MC[0-9]{1,8}$`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or remarks related to the vehicle registration (e.g., temporary permits, exemptions, pending renewals).',
    `registered_owner_address` STRING COMMENT 'Mailing address of the registered owner as recorded on the vehicle registration document. Organizational contact data classified as confidential.',
    `registered_owner_name` STRING COMMENT 'Legal name of the entity or individual listed as the registered owner on the vehicle registration. Typically the company name for fleet vehicles.',
    `registration_class` STRING COMMENT 'Classification of the vehicle registration as defined by state DMV regulations. Determines fee structure and operational restrictions.. Valid values are `commercial|private|government|farm|exempt`',
    `registration_document_url` STRING COMMENT 'URL or file path to the digital copy of the vehicle registration document. Used for electronic record-keeping and roadside inspection readiness.. Valid values are `^https?://.*$`',
    `registration_fee_amount` DECIMAL(18,2) COMMENT 'Total fee paid for the vehicle registration, including base registration, IRP apportionment fees, and any applicable surcharges. Denominated in USD.',
    `registration_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the registration fee. Typically USD for U.S. operations.. Valid values are `^[A-Z]{3}$`',
    `registration_number` STRING COMMENT 'The official license plate or registration number issued by the state Department of Motor Vehicles (DMV). This is the externally-known identifier displayed on the vehicle.. Valid values are `^[A-Z0-9]{1,10}$`',
    `registration_status` STRING COMMENT 'Current lifecycle status of the vehicle registration. Active registrations are compliant for road operation; expired or suspended registrations require immediate attention to maintain DOT compliance.. Valid values are `active|expired|suspended|revoked|pending|cancelled`',
    `renewal_date` DATE COMMENT 'Date when the registration was last renewed. Used to track renewal history and calculate next renewal cycle.',
    `title_number` STRING COMMENT 'Unique identifier for the vehicle title document issued by the state. Links registration to proof of ownership.. Valid values are `^[A-Z0-9]{1,20}$`',
    `ucr_registration_year` STRING COMMENT 'Calendar year for which the UCR registration is valid. UCR must be renewed annually.',
    `ucr_status` STRING COMMENT 'Current status of the Unified Carrier Registration for this vehicle. UCR is a federally-mandated registration system for commercial motor carriers operating in interstate commerce.. Valid values are `current|expired|pending|not_required`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vehicle registration record was last modified. Used for audit trail and change tracking.',
    `vehicle_type` STRING COMMENT 'Classification of the vehicle type as recorded on the registration (e.g., ASL = Automated Side Loader, FEL = Front End Loader, REL = Rear End Loader, roll-off truck, transfer vehicle).',
    `vehicle_year` STRING COMMENT 'Model year of the vehicle as recorded on the registration document.',
    `vin` STRING COMMENT '17-character alphanumeric Vehicle Identification Number assigned by the manufacturer. Unique global identifier for the vehicle, recorded on registration documents.. Valid values are `^[A-HJ-NPR-Z0-9]{17}$`',
    CONSTRAINT pk_vehicle_registration PRIMARY KEY(`vehicle_registration_id`)
) COMMENT 'DOT and state motor vehicle registration records for each fleet unit. Tracks registration number, issuing state, registration class, expiration date, renewal date, IRP (International Registration Plan) apportionment details, IFTA (International Fuel Tax Agreement) decal number, UCR (Unified Carrier Registration) status, DOT number, MC number (if applicable), annual inspection due date, and cab card storage location. Critical for DOT/FMCSA regulatory compliance and roadside inspection readiness.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`driver` (
    `driver_id` BIGINT COMMENT 'Unique identifier for the driver record. Primary key for the driver entity within the fleet domain.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Drivers are assigned to service territories for route planning, CDL compliance by jurisdiction, labor deployment, and territory-based performance management. Critical for workforce planning and regula',
    `training_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.training_certification. Business justification: CDL licenses, hazmat endorsements, and DOT medical certifications are regulatory training certifications. Driver qualification files require linking to certification records for FMCSA compliance audit',
    `employee_id` BIGINT COMMENT 'Reference to the employee record in the workforce domain. Links driver to their HR profile in Workday HCM.',
    `district_id` BIGINT COMMENT 'Reference to the primary operational district where the driver is based. Used for route assignment and workforce planning.',
    `cdl_class` STRING COMMENT 'Classification of the Commercial Driver License indicating the types of vehicles the driver is authorized to operate. Class A for combination vehicles, Class B for heavy straight vehicles, Class C for smaller vehicles requiring placards or designed to transport 16+ passengers.. Valid values are `A|B|C|Non-CDL`',
    `cdl_endorsements` STRING COMMENT 'Comma-separated list of CDL endorsements held by the driver (e.g., H for Hazmat, N for Tanker, T for Doubles/Triples, P for Passenger). Determines specialized vehicle and cargo authorization.',
    `cdl_expiration_date` DATE COMMENT 'Date when the Commercial Driver License expires and must be renewed. Critical for DOT compliance monitoring.',
    `cdl_issue_date` DATE COMMENT 'Date when the current Commercial Driver License was issued by the state authority.',
    `cdl_number` STRING COMMENT 'Unique Commercial Driver License number issued by the state licensing authority. Required for all drivers operating commercial motor vehicles.',
    `cdl_state` STRING COMMENT 'Two-letter state code where the Commercial Driver License was issued (e.g., CA, TX, NY).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the driver record was first created in the fleet management system.',
    `dot_physical_expiration_date` DATE COMMENT 'Date when the DOT medical examiner certificate expires. Drivers must maintain current medical certification to operate commercial vehicles.',
    `dot_physical_issue_date` DATE COMMENT 'Date when the current DOT medical examiner certificate was issued.',
    `drug_alcohol_program_enrollment_date` DATE COMMENT 'Date when the driver was enrolled in the DOT drug and alcohol testing program.',
    `drug_alcohol_program_enrollment_flag` BOOLEAN COMMENT 'Indicates whether the driver is enrolled in the DOT-mandated drug and alcohol testing program. Required for all CDL drivers.',
    `hazmat_clearance_expiration_date` DATE COMMENT 'Expiration date of the drivers TSA security threat assessment clearance required for Hazmat endorsement. Must be renewed every five years.',
    `hazmat_endorsement_flag` BOOLEAN COMMENT 'Indicates whether the driver holds a valid Hazmat endorsement on their CDL, required for transporting hazardous waste materials subject to RCRA regulations.',
    `hire_date` DATE COMMENT 'Date when the driver was hired by Waste Management. Used for seniority, tenure analysis, and route assignment priority.',
    `last_alcohol_test_date` DATE COMMENT 'Date of the drivers most recent alcohol test (pre-employment, random, post-accident, reasonable suspicion, or return-to-duty).',
    `last_alcohol_test_result` STRING COMMENT 'Result of the drivers most recent alcohol test. Positive results (BAC >= 0.04) or refusals trigger disqualification.. Valid values are `negative|positive|refused|pending`',
    `last_drug_test_date` DATE COMMENT 'Date of the drivers most recent drug test (pre-employment, random, post-accident, reasonable suspicion, or return-to-duty).',
    `last_drug_test_result` STRING COMMENT 'Result of the drivers most recent drug test. Positive results or refusals trigger disqualification and return-to-duty protocols.. Valid values are `negative|positive|refused|pending`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the driver record was last updated. Used for data lineage and audit trail.',
    `last_qualification_review_date` DATE COMMENT 'Date when the drivers qualification file was last reviewed for completeness and compliance with DOT requirements.',
    `medical_examiner_certificate_number` STRING COMMENT 'Unique identifier for the drivers DOT medical examiner certificate. Required to demonstrate physical fitness to operate commercial motor vehicles.',
    `medical_examiner_name` STRING COMMENT 'Name of the certified medical examiner who issued the DOT physical certificate.',
    `mvr_last_review_date` DATE COMMENT 'Date when the drivers Motor Vehicle Record was last reviewed by the fleet safety department. DOT requires annual MVR reviews.',
    `mvr_next_review_due_date` DATE COMMENT 'Date when the next Motor Vehicle Record review is due. Used for compliance tracking and proactive safety management.',
    `mvr_status` STRING COMMENT 'Current status of the drivers Motor Vehicle Record based on the most recent review. Indicates driving history and violation status for risk assessment and DOT compliance.. Valid values are `clear|minor_violations|major_violations|suspended|revoked`',
    `next_qualification_review_due_date` DATE COMMENT 'Date when the next driver qualification file review is due. Used for proactive compliance management.',
    `operational_status` STRING COMMENT 'Current operational status of the driver within the fleet. Indicates availability for route assignments and vehicle operations.. Valid values are `active|inactive|on_leave|terminated|suspended`',
    `primary_route_type` STRING COMMENT 'Primary type of collection route the driver is assigned to. Determines vehicle type and operational requirements.. Valid values are `residential|commercial|roll_off|transfer|hazmat|recycling`',
    `qualification_status` STRING COMMENT 'Current qualification status of the driver based on DOT requirements, medical certification, license validity, and company safety standards. Determines whether the driver is authorized to operate fleet vehicles.. Valid values are `qualified|disqualified|suspended|pending_review|expired`',
    `safety_score` DECIMAL(18,2) COMMENT 'Composite safety score based on driving behavior, incident history, and compliance metrics captured from Geotab Fleet Telematics. Scale 0-100, higher is better.',
    `termination_date` DATE COMMENT 'Date when the drivers employment was terminated. Null for active drivers.',
    `total_miles_driven` DECIMAL(18,2) COMMENT 'Cumulative total miles driven by the driver across all fleet vehicles since hire date. Used for experience assessment and performance analysis.',
    CONSTRAINT pk_driver PRIMARY KEY(`driver_id`)
) COMMENT 'Master record for all CDL (Commercial Driver License) holders and non-CDL operators assigned to fleet vehicles. Captures driver employee ID (FK to workforce domain), CDL number, class (A/B/C), state of issuance, expiration date, endorsements (Hazmat, Tanker, Doubles/Triples), medical examiner certificate details, DOT physical due date, MVR status, HazMat clearance, drug/alcohol program enrollment, current qualification status, last qualification review date, next review due date, and operational status. SSOT for driver identity and qualification records within the fleet domain.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` (
    `vehicle_assignment_id` BIGINT COMMENT 'Unique identifier for the vehicle assignment record. Primary key for the vehicle assignment entity.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Daily vehicle assignments include deliveries to WTE facilities. Dispatch and operations need to track which vehicle/driver delivered waste to which energy facility on each shift for load reconciliatio',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Dispatchers assign vehicles to routes and drivers daily, critical for operational accountability, shift planning, HOS compliance verification, and route optimization decisions.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver assigned to operate the vehicle during this shift. References the driver master record.',
    `pre_post_trip_inspection_id` BIGINT COMMENT 'Foreign key linking to fleet.pre_post_trip_inspection. Business justification: Vehicle assignments require pre-trip inspections per FMCSA 49 CFR Part 396.11. The vehicle_assignment table currently has pre_trip_inspection_completed BOOLEAN and pre_trip_inspection_timestamp, but n',
    `route_id` BIGINT COMMENT 'Identifier of the collection route or run assigned to this driver-vehicle combination for the shift. May be null for non-route assignments such as maintenance runs or standby.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle unit assigned for this operational shift. References the fleet vehicle master record.',
    `actual_end_time` TIMESTAMP COMMENT 'The actual timestamp when the driver completed the shift and returned the vehicle, as recorded by telematics or dispatch system. May differ from scheduled shift end time.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual timestamp when the driver began the shift and took control of the vehicle, as recorded by telematics or dispatch system. May differ from scheduled shift start time.',
    `assignment_date` DATE COMMENT 'The calendar date for which this vehicle assignment is effective. Represents the operational day of the assignment.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the vehicle assignment. Tracks progression from scheduled through active operation to completion or cancellation.. Valid values are `scheduled|active|completed|cancelled|no_show|reassigned`',
    `assignment_type` STRING COMMENT 'Classification of the assignment purpose. Indicates whether the vehicle is assigned for route collection, transfer haul, roll-off service, maintenance run, standby duty, or emergency response.. Valid values are `route|transfer|rolloff|maintenance|standby|emergency`',
    `cdl_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the drivers Commercial Driver License (CDL) was verified as valid and appropriate for the vehicle class at the time of assignment. Required for DOT compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vehicle assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `defect_description` STRING COMMENT 'Free-text description of any vehicle defects or maintenance issues identified during the assignment. Used to generate work orders for corrective maintenance.',
    `defects_reported` BOOLEAN COMMENT 'Boolean flag indicating whether any vehicle defects or maintenance issues were reported during the pre-trip or post-trip inspection for this assignment.',
    `dispatch_location` STRING COMMENT 'The facility or yard location from which the vehicle was dispatched for this assignment. Typically the operating base or depot.',
    `engine_hours_end` DECIMAL(18,2) COMMENT 'The cumulative engine operating hours at the end of the assignment. Used for preventive maintenance scheduling and asset lifecycle management.',
    `engine_hours_start` DECIMAL(18,2) COMMENT 'The cumulative engine operating hours at the beginning of the assignment. Used for preventive maintenance scheduling and asset lifecycle management.',
    `fuel_level_end_percent` DECIMAL(18,2) COMMENT 'The fuel tank level as a percentage at the end of the assignment. Used for fuel consumption tracking and refueling planning.',
    `fuel_level_start_percent` DECIMAL(18,2) COMMENT 'The fuel tank level as a percentage at the beginning of the assignment. Used for fuel consumption tracking and refueling planning.',
    `hos_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the driver was in compliance with Hours of Service (HOS) regulations at the time of assignment. Ensures driver has adequate rest and is within allowable driving hours.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vehicle assignment record was last modified in the system. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the vehicle assignment. May include special instructions, operational observations, or other relevant information.',
    `odometer_end` DECIMAL(18,2) COMMENT 'The vehicle odometer reading in miles at the end of the assignment. Used to calculate distance traveled during the shift for utilization and maintenance tracking.',
    `odometer_start` DECIMAL(18,2) COMMENT 'The vehicle odometer reading in miles at the beginning of the assignment. Used to calculate distance traveled during the shift for utilization and maintenance tracking.',
    `post_trip_inspection_completed` BOOLEAN COMMENT 'Boolean flag indicating whether the driver completed the mandatory post-trip vehicle inspection after completing the shift. Required for DOT compliance and vehicle maintenance tracking.',
    `post_trip_inspection_timestamp` TIMESTAMP COMMENT 'The timestamp when the post-trip inspection was completed and recorded. Used for compliance audit trail.',
    `pre_trip_inspection_completed` BOOLEAN COMMENT 'Boolean flag indicating whether the driver completed the mandatory pre-trip vehicle inspection before beginning the shift. Required for DOT compliance.',
    `return_location` STRING COMMENT 'The facility or yard location to which the vehicle was returned at the end of the assignment. May differ from dispatch location for transfer operations.',
    `safety_incident_occurred` BOOLEAN COMMENT 'Boolean flag indicating whether any safety incident, accident, or near-miss event occurred during this vehicle assignment. Triggers incident investigation and reporting workflow.',
    `shift_end_time` TIMESTAMP COMMENT 'The timestamp when the driver is scheduled to complete the shift and return the vehicle. Used for Hours of Service (HOS) tracking and shift duration calculation.',
    `shift_start_time` TIMESTAMP COMMENT 'The timestamp when the driver is scheduled to begin the shift and take control of the vehicle. Used for Hours of Service (HOS) tracking and shift duration calculation.',
    CONSTRAINT pk_vehicle_assignment PRIMARY KEY(`vehicle_assignment_id`)
) COMMENT 'Transactional record of driver-to-vehicle assignments for each operational shift or day. Captures assigned driver, assigned vehicle unit, assignment date, shift start time, shift end time, route or run assignment reference, pre-trip inspection completion flag, post-trip inspection completion flag, odometer at assignment start, odometer at assignment end, engine hours at start, engine hours at end, and assignment status. Supports HOS (Hours of Service) tracking, vehicle utilization reporting, and driver accountability.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`telematics_event` (
    `telematics_event_id` BIGINT COMMENT 'Unique identifier for each telematics event record captured from the vehicle tracking system.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver assigned to the vehicle at the time of the event.',
    `geofence_zone_id` BIGINT COMMENT 'Identifier of the geographic boundary zone the vehicle was within at the time of the event.',
    `route_id` BIGINT COMMENT 'Identifier of the planned collection route the vehicle was assigned to at the time of the event.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the fleet vehicle that generated this telematics event.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Telematics systems use geofencing to track vehicle arrival, dwell time, and departure at WTE facilities. Operations need this link for facility queue management, driver behavior monitoring at tipping ',
    `altitude_feet` DECIMAL(18,2) COMMENT 'Elevation of the vehicle above sea level measured in feet at the time of the event.',
    `battery_voltage` DECIMAL(18,2) COMMENT 'Vehicle battery voltage measured in volts at the time of the event.',
    `coolant_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Engine coolant temperature measured in degrees Fahrenheit at the time of the event.',
    `data_source_system` STRING COMMENT 'Name of the telematics platform or system that captured and transmitted this event record.',
    `device_serial_number` STRING COMMENT 'Unique serial number of the telematics tracking device installed in the vehicle.',
    `engine_load_percent` DECIMAL(18,2) COMMENT 'Percentage of maximum engine load being utilized at the time of the event.',
    `engine_rpm` STRING COMMENT 'Engine speed measured in revolutions per minute at the time of the event.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the telematics event was captured by the vehicle tracking device.',
    `event_type` STRING COMMENT 'Classification of the telematics event indicating the trigger or reason for the event record. [ENUM-REF-CANDIDATE: gps_ping|ignition_on|ignition_off|harsh_event|idle_alert|geofence_entry|geofence_exit — 7 candidates stripped; promote to reference product]',
    `fuel_consumption_gallons` DECIMAL(18,2) COMMENT 'Cumulative fuel consumed by the vehicle measured in gallons since the last reset or event.',
    `fuel_level_percent` DECIMAL(18,2) COMMENT 'Percentage of fuel remaining in the vehicle tank at the time of the event.',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'Estimated accuracy of the GPS coordinates measured in meters indicating the precision of the location data.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the vehicle at the time of the event in decimal degrees.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the vehicle at the time of the event in decimal degrees.',
    `harsh_acceleration_flag` BOOLEAN COMMENT 'Indicator of whether a harsh acceleration event occurred based on acceleration thresholds.',
    `harsh_braking_flag` BOOLEAN COMMENT 'Indicator of whether a harsh braking event occurred based on deceleration thresholds.',
    `heading_degrees` STRING COMMENT 'Compass direction the vehicle is traveling measured in degrees from 0 to 359 where 0 is north.',
    `idle_duration_flag` BOOLEAN COMMENT 'Indicator of whether the vehicle was idling for an extended period at the time of the event.',
    `idle_time_minutes` DECIMAL(18,2) COMMENT 'Duration of time the vehicle engine was running while stationary measured in minutes.',
    `ignition_status` STRING COMMENT 'Current state of the vehicle ignition indicating whether the engine is running or off.. Valid values are `on|off`',
    `odometer_miles` DECIMAL(18,2) COMMENT 'Total cumulative distance traveled by the vehicle in miles as recorded at the time of the event.',
    `posted_speed_limit_mph` STRING COMMENT 'Legal speed limit at the vehicles location at the time of the event in miles per hour.',
    `pto_status` STRING COMMENT 'Current state of the power take-off mechanism indicating whether it is engaged for auxiliary equipment operation.. Valid values are `engaged|disengaged|unknown`',
    `satellite_count` STRING COMMENT 'Number of GPS satellites used to determine the vehicles location at the time of the event.',
    `seatbelt_status` STRING COMMENT 'Current state of the driver seatbelt indicating whether it is fastened or unfastened.. Valid values are `fastened|unfastened|unknown`',
    `speeding_flag` BOOLEAN COMMENT 'Indicator of whether the vehicle was exceeding the posted speed limit at the time of the event.',
    `vehicle_speed_mph` DECIMAL(18,2) COMMENT 'Instantaneous speed of the vehicle at the time of the event measured in miles per hour.',
    CONSTRAINT pk_telematics_event PRIMARY KEY(`telematics_event_id`)
) COMMENT 'High-frequency GPS and telematics event records sourced from Geotab Fleet Telematics for each vehicle. Captures event timestamp, vehicle unit, GPS latitude, GPS longitude, vehicle speed, posted speed limit, heading, ignition status, engine RPM, engine load percentage, coolant temperature, battery voltage, odometer reading at event, fuel level, idle duration flag, harsh braking event flag, harsh acceleration event flag, seatbelt status, PTO (Power Take-Off) status, and geofence zone identifier. Foundational for route compliance, driver behavior scoring, and fuel consumption analysis.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` (
    `fuel_transaction_id` BIGINT COMMENT 'Unique identifier for the fuel transaction record. Primary key.',
    `air_emission_event_id` BIGINT COMMENT 'Foreign key linking to compliance.air_emission_event. Business justification: Fuel dispensing events can trigger vapor recovery system failures, spills, or overfill events reportable under air quality permits. Environmental compliance officers link fuel transactions to emission',
    `driver_id` BIGINT COMMENT 'Identifier of the driver who performed the fueling transaction. Links to driver master record.',
    `fuel_purchase_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_purchase. Business justification: Individual vehicle fuel transactions must reconcile against bulk fuel purchases for inventory management, cost allocation, and variance analysis. Essential for fuel accounting and detecting shrinkage/',
    `fueling_station_id` BIGINT COMMENT 'Identifier of the fueling location. May be internal yard pump ID or external commercial station identifier from fuel card network.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Many WTE facilities have on-site fueling stations for fleet vehicles. Fuel transactions need to link to the WTE facility where fueling occurred for cost allocation, facility-specific fuel inventory ma',
    `route_id` BIGINT COMMENT 'Identifier of the collection route the vehicle was assigned to at the time of fueling. Links fuel consumption to operational route performance.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the work shift during which the fueling occurred. Supports labor cost allocation and shift-based fuel consumption analysis.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the fleet vehicle that was fueled in this transaction. Links to the vehicle master record.',
    `authorization_code` STRING COMMENT 'Authorization or approval code from the fuel card processor or yard pump system. Used for transaction reconciliation and dispute resolution.',
    `cost_center` STRING COMMENT 'SAP cost center to which this fuel transaction cost is allocated. Supports financial reporting and budget tracking by operational unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel transaction record was first created in the system. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the transaction cost (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `def_quantity_dispensed` DECIMAL(18,2) COMMENT 'Volume of DEF (Diesel Exhaust Fluid) dispensed in gallons during this transaction. Required for diesel vehicles with SCR emissions systems to meet EPA standards.',
    `engine_hours` DECIMAL(18,2) COMMENT 'Cumulative engine operating hours at time of fueling. Critical for maintenance scheduling and fuel efficiency analysis for heavy equipment.',
    `fuel_card_number` STRING COMMENT 'Fleet fuel card number used for the transaction. Masked or tokenized for security. Used to reconcile with fuel card provider statements.',
    `fuel_grade` STRING COMMENT 'Grade or specification of the fuel dispensed. ULSD = Ultra-Low Sulfur Diesel; B5/B20 = biodiesel blend percentages. Ensures compliance with vehicle manufacturer specifications.. Valid values are `regular|midgrade|premium|ulsd|b5|b20`',
    `fuel_type` STRING COMMENT 'Type of fuel dispensed in this transaction. CNG = Compressed Natural Gas, RNG = Renewable Natural Gas.. Valid values are `diesel|cng|rng|gasoline|biodiesel|electric`',
    `gl_account` STRING COMMENT 'General ledger account code for fuel expense posting in SAP FI. Varies by fuel type and vehicle class.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the fueling location. Captured from vehicle telematics or fuel card network. Used to validate station location and detect anomalies.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the fueling location. Captured from vehicle telematics or fuel card network. Used to validate station location and detect anomalies.',
    `ifta_jurisdiction` STRING COMMENT 'Two-letter state/province code where fuel was purchased. Required for IFTA quarterly fuel tax reporting for interstate commercial vehicles.. Valid values are `^[A-Z]{2}$`',
    `invoice_number` STRING COMMENT 'Vendor invoice or receipt number for this fuel transaction. Used for accounts payable reconciliation and audit trail.',
    `is_emergency_fuel` BOOLEAN COMMENT 'Flag indicating whether this was an unplanned emergency fueling event (e.g., vehicle ran low on route). Used to identify route planning issues and driver behavior patterns.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel transaction record was last modified. Tracks updates for reconciliation, corrections, or status changes.',
    `notes` STRING COMMENT 'Free-text notes or comments about the fuel transaction. May include driver remarks, exception explanations, or reconciliation notes.',
    `odometer_reading` STRING COMMENT 'Vehicle odometer reading in miles at the time of fueling. Used to calculate fuel economy (MPG or MPGe) and validate vehicle utilization.',
    `pre_tax_amount` DECIMAL(18,2) COMMENT 'Transaction cost before fuel taxes. Calculated as total_cost minus tax_amount. Used for cost analysis and vendor invoice reconciliation.',
    `pump_number` STRING COMMENT 'Identifier of the specific fuel pump or dispenser used at the fueling station. Supports pump-level performance tracking and maintenance.',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Volume or energy-equivalent quantity of fuel dispensed. For liquid fuels measured in gallons; for CNG/RNG measured in GGE (Gasoline Gallon Equivalent).',
    `source_system` STRING COMMENT 'Name of the source system that originated this transaction record (e.g., Geotab, WEX FleetCard, internal yard pump system). Supports data lineage and integration troubleshooting.',
    `source_transaction_reference` STRING COMMENT 'Original transaction identifier from the source system. Maintains traceability to upstream system for reconciliation and issue resolution.',
    `station_type` STRING COMMENT 'Classification of the fueling station. Company yard = internal fleet facility; public station = commercial retail; CNG station = specialized compressed natural gas facility.. Valid values are `company_yard|public_station|cng_station|private_contract`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total fuel tax included in the transaction cost. Includes federal, state, and local fuel excise taxes. Used for IFTA reporting and tax reconciliation.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the fuel transaction (quantity × unit cost). Used for cost allocation and budget tracking.',
    `transaction_source` STRING COMMENT 'System or method that captured this fuel transaction. Fleet card = commercial fuel card network; yard pump = internal automated pump; telematics = vehicle onboard system; manual entry = driver-reported.. Valid values are `fleet_card|yard_pump|cng_station|manual_entry|telematics`',
    `transaction_status` STRING COMMENT 'Current processing status of the fuel transaction. Approved = validated and posted; pending = awaiting review; disputed = flagged for investigation; reconciled = matched to invoice.. Valid values are `approved|pending|rejected|reconciled|disputed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel dispensing transaction occurred. Captured from fuel card system or yard pump controller.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of fuel at the time of transaction (price per gallon, GGE, or kWh).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity dispensed. GGE = Gasoline Gallon Equivalent used for CNG/RNG; kWh for electric charging.. Valid values are `gallons|gge|liters|kwh`',
    `vendor_name` STRING COMMENT 'Name of the fuel vendor or station operator (e.g., Shell, BP, internal fleet services). Used for vendor performance analysis and contract compliance.',
    CONSTRAINT pk_fuel_transaction PRIMARY KEY(`fuel_transaction_id`)
) COMMENT 'Individual fuel dispensing transaction records for all fleet vehicles covering diesel, CNG (Compressed Natural Gas), and RNG (Renewable Natural Gas) fueling events. Captures transaction date and time, vehicle unit, driver, fuel type, quantity dispensed (gallons or GGE), unit cost, total cost, fuel card number, fueling station identifier (company yard or public station), odometer at fueling, engine hours at fueling, DEF quantity dispensed, and transaction source (fleet card, yard pump, CNG station). Integrates with SAP MM for cost allocation and supports IFTA fuel tax reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` (
    `fleet_dot_inspection_id` BIGINT COMMENT 'Unique identifier for the DOT inspection record. Primary key.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: DOT inspection violations generate corrective actions tracked in safety system for closure verification, compliance tracking, and CSA score management. Critical for FMCSA compliance.',
    `driver_id` BIGINT COMMENT 'Reference to the driver who was operating the vehicle at the time of inspection.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: DOT inspections assess asset condition and may trigger impairment or retirement decisions. Results must be recorded in the asset condition history for regulatory compliance, valuation support, and aud',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: DOT inspections performed by third-party certified inspection vendors require vendor tracking for certification validation, performance management, and payment processing. Role-prefixed to distinguish',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: DOT roadside inspections of hazmat loads must reference the manifest being transported for compliance verification per 49 CFR 177.817. Critical for documenting placarding violations, shipping paper ac',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Internal review of DOT roadside inspections by safety managers is required for CSA score management, corrective action tracking, and FMCSA compliance audits.',
    `vehicle_id` BIGINT COMMENT 'Reference to the fleet vehicle that was inspected.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: DOT roadside inspections that result in out-of-service orders or citations generate formal violation notices. Safety directors link inspection reports to notices for penalty tracking and corrective ac',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order created to address inspection violations.',
    `basic_category` STRING COMMENT 'CSA BASIC category that the violations fall under (e.g., Unsafe Driving, Hours of Service Compliance, Vehicle Maintenance, Controlled Substances/Alcohol, Driver Fitness, Hazardous Materials Compliance, Crash Indicator). [ENUM-REF-CANDIDATE: Unsafe Driving|Hours of Service|Vehicle Maintenance|Controlled Substances|Driver Fitness|Hazardous Materials|Crash Indicator — promote to reference product]',
    `carrier_dot_number` STRING COMMENT 'USDOT number of the carrier at the time of inspection. Seven-digit identifier assigned by FMCSA.. Valid values are `^[0-9]{7}$`',
    `corrective_action_completed_date` DATE COMMENT 'Date when all required corrective actions were completed and verified.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective actions required to address the violations.',
    `corrective_action_due_date` DATE COMMENT 'Date by which corrective actions must be completed.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required to address violations found during the inspection.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action process.. Valid values are `Not Required|Pending|In Progress|Completed|Overdue|Verified`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system.',
    `csa_score_impact` DECIMAL(18,2) COMMENT 'Calculated impact of this inspection on the carriers CSA score.',
    `driver_license_number` STRING COMMENT 'CDL number of the driver at the time of inspection. Recorded for compliance tracking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `driver_license_state` STRING COMMENT 'Two-letter state code of the issuing state for the drivers CDL.. Valid values are `^[A-Z]{2}$`',
    `driver_oos_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the driver specifically was placed out of service.',
    `inspection_category` STRING COMMENT 'Category or context of the inspection event (roadside stop, scheduled annual inspection, state patrol enforcement, terminal audit, compliance review, or random selection).. Valid values are `Roadside|Annual DOT|State Patrol|Terminal Audit|Compliance Review|Random`',
    `inspection_date` DATE COMMENT 'Date when the DOT inspection was performed.',
    `inspection_document_url` STRING COMMENT 'URL or file path to the scanned or digital copy of the official inspection report.. Valid values are `^https?://.*$`',
    `inspection_duration_minutes` STRING COMMENT 'Total duration of the inspection in minutes.',
    `inspection_location` STRING COMMENT 'Physical location where the inspection was conducted (address, weigh station name, or facility identifier).',
    `inspection_notes` STRING COMMENT 'Additional notes or comments recorded by the inspector during the inspection.',
    `inspection_report_number` STRING COMMENT 'Official inspection report number issued by the inspector or enforcement agency. Unique identifier for the inspection event in DOT/CVSA systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `inspection_result` STRING COMMENT 'Overall result of the DOT inspection. Pass indicates no violations; Out-of-Service indicates vehicle or driver was placed out of service; Warning Issued indicates minor issues noted; Violation Cited indicates formal citation; Conditional Pass indicates pass with follow-up required.. Valid values are `Pass|Out-of-Service|Warning Issued|Violation Cited|Conditional Pass`',
    `inspection_state` STRING COMMENT 'Two-letter state code where the inspection occurred.. Valid values are `^[A-Z]{2}$`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the DOT inspection was initiated.',
    `inspection_type` STRING COMMENT 'Type of CVSA inspection performed. Level I (North American Standard Inspection - full vehicle and driver), Level II (Walk-Around Driver/Vehicle Inspection), Level III (Driver-Only Inspection), Level IV (Special Inspections), Level V (Vehicle-Only Inspection), Level VI (Enhanced NAS Inspection for Radioactive Shipments).. Valid values are `Level I|Level II|Level III|Level IV|Level V|Level VI`',
    `inspector_agency` STRING COMMENT 'Name of the enforcement agency or organization that conducted the inspection (e.g., State Highway Patrol, DOT, CVSA).',
    `inspector_badge_number` STRING COMMENT 'Official badge or identification number of the inspector.. Valid values are `^[A-Z0-9]{4,15}$`',
    `inspector_name` STRING COMMENT 'Full name of the inspector who performed the DOT inspection.',
    `oos_violation_count` STRING COMMENT 'Number of violations that met FMCSA out-of-service criteria.',
    `out_of_service_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the vehicle or driver was placed out of service as a result of the inspection. True if OOS order was issued.',
    `severity_weight` STRING COMMENT 'Severity weight assigned to the violations for CSA scoring purposes (1-10 scale, with 10 being most severe).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last updated in the system.',
    `vehicle_odometer_reading` STRING COMMENT 'Odometer reading of the vehicle at the time of inspection, in miles.',
    `vehicle_oos_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the vehicle specifically was placed out of service.',
    `violation_codes` STRING COMMENT 'Comma-separated list of FMCSA violation codes cited during the inspection (e.g., 393.75B, 396.3A1).',
    `violation_count` STRING COMMENT 'Total number of violations cited during the inspection.',
    `violation_description` STRING COMMENT 'Detailed description of the violations found during the inspection, including inspector notes.',
    CONSTRAINT pk_fleet_dot_inspection PRIMARY KEY(`fleet_dot_inspection_id`)
) COMMENT 'Records of DOT roadside inspections and annual vehicle inspections (CVSA — Commercial Vehicle Safety Alliance) for fleet units. Captures inspection date, inspection type (Level I–VI CVSA, Annual DOT, State Patrol), inspection location, inspector name and badge number, inspection result (pass, out-of-service, warning), number of violations cited, violation codes (FMCSA OOS criteria), corrective action required flag, corrective action completion date, and inspection report number. Critical for FMCSA compliance tracking and CSA (Compliance Safety Accountability) score management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` (
    `pre_post_trip_inspection_id` BIGINT COMMENT 'Unique identifier for the pre-trip or post-trip vehicle inspection record.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver who performed the inspection.',
    `employee_id` BIGINT COMMENT 'Identifier of the mechanic who reviewed and acknowledged the inspection report and any reported defects.',
    `route_id` BIGINT COMMENT 'Identifier of the collection route associated with this inspection, linking the inspection to the planned or completed route.',
    `transfer_trailer_id` BIGINT COMMENT 'Identifier of the trailer unit attached to the vehicle during inspection, if applicable.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle (collection truck, transfer vehicle, roll-off truck, or support vehicle) that was inspected.',
    `work_order_id` BIGINT COMMENT 'Identifier of the maintenance work order generated from reported defects in this inspection, linking inspection to corrective action.',
    `body_frame_status` STRING COMMENT 'Inspection result for the vehicle body, frame, and structural integrity including container body, hydraulic systems, and visible damage.. Valid values are `pass|fail|not_applicable`',
    `brakes_status` STRING COMMENT 'Inspection result for the vehicle braking system including service brakes, parking brake, and emergency brake.. Valid values are `pass|fail|not_applicable`',
    `cdl_number` STRING COMMENT 'The Commercial Driver License number of the driver performing the inspection, required for DOT compliance verification.',
    `coupling_devices_status` STRING COMMENT 'Inspection result for fifth wheel, pintle hook, or other coupling devices used to attach trailers.. Valid values are `pass|fail|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inspection record was first created in the system.',
    `defect_description` STRING COMMENT 'Detailed description of any defects, safety concerns, or maintenance issues identified during the inspection.',
    `defect_reported_flag` BOOLEAN COMMENT 'Indicates whether any defects or safety concerns were identified during the inspection that require maintenance attention.',
    `defect_severity` STRING COMMENT 'Classification of the defect severity: critical (vehicle out-of-service), major (requires immediate attention), or minor (can be scheduled for repair).. Valid values are `critical|major|minor`',
    `driver_signature_timestamp` TIMESTAMP COMMENT 'The date and time when the driver electronically signed or certified the inspection report.',
    `emergency_equipment_status` STRING COMMENT 'Inspection result for emergency equipment including fire extinguisher, warning triangles, first aid kit, and spill kit.. Valid values are `pass|fail|not_applicable`',
    `exhaust_system_status` STRING COMMENT 'Inspection result for the exhaust system including muffler, pipes, and emissions control components.. Valid values are `pass|fail|not_applicable`',
    `fuel_system_status` STRING COMMENT 'Inspection result for the fuel system including tank, lines, and connections for leaks or damage. Applies to diesel, CNG, and RNG fuel systems.. Valid values are `pass|fail|not_applicable`',
    `horn_status` STRING COMMENT 'Inspection result for the vehicle horn functionality.. Valid values are `pass|fail|not_applicable`',
    `inspection_date` DATE COMMENT 'The calendar date on which the inspection was performed.',
    `inspection_location` STRING COMMENT 'The facility, depot, or geographic location where the inspection was performed.',
    `inspection_number` STRING COMMENT 'Business-facing unique inspection number or reference code assigned to this inspection event for tracking and audit purposes.',
    `inspection_source` STRING COMMENT 'The method or system used to capture the inspection data: mobile application, paper form (later digitized), or telematics system.. Valid values are `mobile_app|paper_form|telematics`',
    `inspection_timestamp` TIMESTAMP COMMENT 'The precise date and time when the inspection was completed by the driver.',
    `inspection_type` STRING COMMENT 'Indicates whether this is a pre-trip inspection (conducted before route departure) or post-trip inspection (conducted after route completion).. Valid values are `pre-trip|post-trip`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this inspection record was last updated or modified.',
    `lights_status` STRING COMMENT 'Inspection result for all vehicle lighting including headlights, taillights, brake lights, turn signals, and hazard lights.. Valid values are `pass|fail|not_applicable`',
    `mechanic_acknowledgment_timestamp` TIMESTAMP COMMENT 'The date and time when the mechanic reviewed and acknowledged the inspection report, required for regulatory compliance.',
    `mirrors_status` STRING COMMENT 'Inspection result for all vehicle mirrors including side mirrors and rearview mirrors for proper adjustment and condition.. Valid values are `pass|fail|not_applicable`',
    `odometer_reading` DECIMAL(18,2) COMMENT 'The vehicle odometer reading in miles at the time of inspection, used for maintenance scheduling and utilization tracking.',
    `out_of_service_flag` BOOLEAN COMMENT 'Indicates whether the vehicle was placed out of service due to critical safety defects that must be repaired before the vehicle can be operated.',
    `steering_status` STRING COMMENT 'Inspection result for the steering system including steering wheel, linkage, and power steering operation.. Valid values are `pass|fail|not_applicable`',
    `suspension_status` STRING COMMENT 'Inspection result for the vehicle suspension system including springs, shocks, and air suspension components.. Valid values are `pass|fail|not_applicable`',
    `tires_status` STRING COMMENT 'Inspection result for all vehicle tires including tread depth, inflation, and visible damage.. Valid values are `pass|fail|not_applicable`',
    `trailer_unit_number` STRING COMMENT 'The fleet unit number or asset tag of the trailer inspected, if applicable.',
    `wipers_status` STRING COMMENT 'Inspection result for windshield wipers and washer system functionality.. Valid values are `pass|fail|not_applicable`',
    CONSTRAINT pk_pre_post_trip_inspection PRIMARY KEY(`pre_post_trip_inspection_id`)
) COMMENT 'Driver-completed pre-trip and post-trip vehicle inspection records as required by FMCSA 49 CFR Part 396.11. Captures inspection date, inspection type (pre-trip or post-trip), driver, vehicle unit, trailer unit (if applicable), odometer reading, each inspection item result (brakes, lights, tires, mirrors, horn, wipers, coupling devices, emergency equipment, body/frame), defect reported flag, defect description, defect severity, driver signature timestamp, and mechanic acknowledgment timestamp. Feeds directly into maintenance work order generation for reported defects.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`hos_log` (
    `hos_log_id` BIGINT COMMENT 'Unique identifier for the Hours of Service log record. Primary key for the HOS log entry.',
    `driver_id` BIGINT COMMENT 'Identifier of the Commercial Drivers License (CDL) driver who generated this HOS log entry.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Safety managers review HOS logs for FMCSA compliance violations, ELD audit trails, driver qualification file maintenance, and hours-of-service enforcement per DOT regulations.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle unit (truck) operated during this duty status period.',
    `break_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the driver has taken the required 30-minute break after 8 hours of driving time, as mandated by FMCSA.',
    `certification_status` STRING COMMENT 'The certification status of this HOS log entry: certified by the driver, uncertified (pending driver review), or rejected by the driver.. Valid values are `certified|uncertified|rejected`',
    `certification_timestamp` TIMESTAMP COMMENT 'The timestamp when the driver certified this HOS log entry, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `cumulative_driving_hours_8day` DECIMAL(18,2) COMMENT 'The cumulative driving hours accumulated by the driver in the rolling 8-day window at the time of this log entry, used to enforce the 60/70-hour rule.',
    `cumulative_on_duty_hours_8day` DECIMAL(18,2) COMMENT 'The cumulative on-duty hours (driving plus on-duty not driving) accumulated by the driver in the rolling 8-day window at the time of this log entry.',
    `data_source` STRING COMMENT 'The source of this HOS log entry: automatically captured by ELD, manually entered by driver, or edited by carrier.. Valid values are `eld_automatic|driver_manual|carrier_edit`',
    `duration_minutes` STRING COMMENT 'The total duration in minutes that the driver remained in this duty status.',
    `duty_status` STRING COMMENT 'The duty status category as defined by FMCSA: off duty, sleeper berth, driving, or on-duty not driving.. Valid values are `off_duty|sleeper_berth|driving|on_duty_not_driving`',
    `duty_status_end_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the driver exited this duty status, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Null if the status is still active.',
    `duty_status_start_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the driver entered this duty status, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `edit_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this HOS log entry has been manually edited by the driver or carrier after initial creation.',
    `edit_reason` STRING COMMENT 'The reason provided for any manual edit made to this HOS log entry, as required by FMCSA regulations.',
    `eld_device_code` STRING COMMENT 'The unique identifier of the Electronic Logging Device (ELD) that recorded this HOS log entry.',
    `eld_serial_number` STRING COMMENT 'The manufacturer serial number of the ELD device used to capture this log entry.',
    `gps_latitude_end` DECIMAL(18,2) COMMENT 'The GPS latitude coordinate at the end of this duty status period, captured by the ELD device.',
    `gps_latitude_start` DECIMAL(18,2) COMMENT 'The GPS latitude coordinate at the start of this duty status period, captured by the ELD device.',
    `gps_longitude_end` DECIMAL(18,2) COMMENT 'The GPS longitude coordinate at the end of this duty status period, captured by the ELD device.',
    `gps_longitude_start` DECIMAL(18,2) COMMENT 'The GPS longitude coordinate at the start of this duty status period, captured by the ELD device.',
    `hos_violation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this log entry resulted in an HOS violation (exceeding driving hours, on-duty hours, or missing required breaks).',
    `location_end` STRING COMMENT 'The geographic location (city, state) where the driver ended this duty status period.',
    `location_start` STRING COMMENT 'The geographic location (city, state) where the driver began this duty status period.',
    `log_date` DATE COMMENT 'The calendar date for which this HOS log entry applies, in yyyy-MM-dd format.',
    `odometer_end` STRING COMMENT 'The vehicle odometer reading in miles at the end of this duty status period.',
    `odometer_start` STRING COMMENT 'The vehicle odometer reading in miles at the start of this duty status period.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this HOS log record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this HOS log record was last updated in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `remarks` STRING COMMENT 'Free-text remarks or annotations entered by the driver to provide additional context for this duty status period.',
    `shipping_document_number` STRING COMMENT 'The reference number of the shipping document or Bill of Lading (BOL) associated with the load being transported during this duty period.',
    `trailer_number` STRING COMMENT 'The identification number of the trailer being hauled during this duty status period, if applicable.',
    `violation_type_code` STRING COMMENT 'The specific type of HOS violation detected: 11-hour driving limit, 14-hour on-duty limit, 30-minute break requirement, 60/70-hour limit, or none if no violation occurred.. Valid values are `11_hour_driving|14_hour_on_duty|30_min_break|60_70_hour_limit|none`',
    CONSTRAINT pk_hos_log PRIMARY KEY(`hos_log_id`)
) COMMENT 'Hours of Service (HOS) log records for CDL drivers as mandated by FMCSA ELD (Electronic Logging Device) rules under 49 CFR Part 395. Captures log date, driver, vehicle unit, duty status (off duty, sleeper berth, driving, on-duty not driving), duty status start timestamp, duty status end timestamp, duration in status, cumulative driving hours in 8-day window, cumulative on-duty hours in 8-day window, 30-minute break compliance flag, ELD device identifier, co-driver identifier, shipping document reference, and HOS violation flag with violation type code. Supports FMCSA compliance and driver safety management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`accident_report` (
    `accident_report_id` BIGINT COMMENT 'Unique identifier for the accident report record. Primary key.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Accidents occurring while servicing specific customer contracts must be tracked for liability determination, insurance claims, customer notification requirements, and contract performance impact analy',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Accident investigations generate corrective actions (driver retraining, vehicle modifications, policy changes) tracked in safety system for closure verification and preventive measure effectiveness.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver operating the vehicle at the time of the accident. Links to driver master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the safety manager or investigator assigned to conduct the accident investigation.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Accidents with material property damage trigger asset impairment testing per IAS 36, insurance claim processing against the fixed asset record, and condition reassessment. This link enables finance to',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Fleet accidents are also safety incidents requiring unified case management for investigation, workers comp, OSHA recordability determination, and integrated safety performance reporting.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Accidents occurring at WTE facility locations (tipping floor, access roads, queuing areas) must be linked to the facility for safety reporting, facility-specific incident rate tracking, insurance clai',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Accidents involving hazmat shipments require manifest reference for NRC reporting (40 CFR 302), spill response coordination, insurance claims, and determining if DOT reportable quantities were release',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Accident repairs performed by third-party body shops/collision repair vendors. Essential for repair cost tracking, vendor performance evaluation, insurance claim documentation, and payment processing.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the fleet vehicle involved in the accident. Links to the fleet vehicle master record.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Accidents with moving violations, hazmat releases, or DOT-reportable incidents generate violation notices from regulatory agencies. Risk managers link accident reports to notices for claims defense an',
    `accident_description` STRING COMMENT 'Detailed narrative description of how the accident occurred, including sequence of events, contributing factors, and circumstances.',
    `citation_description` STRING COMMENT 'Description of the traffic violation or citation issued, including violation code and description if applicable.',
    `citation_issued_flag` BOOLEAN COMMENT 'Indicates whether a traffic citation or ticket was issued to the driver as a result of the accident.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this accident report record was first created in the system.',
    `csa_reportable_flag` BOOLEAN COMMENT 'Indicates whether the accident is reportable under FMCSA CSA program and will impact the carriers safety score.',
    `dot_reportable_flag` BOOLEAN COMMENT 'Indicates whether the accident meets DOT reportability criteria (fatality, injury requiring immediate medical treatment away from scene, or disabling damage requiring tow-away).',
    `driver_at_fault_flag` BOOLEAN COMMENT 'Indicates whether the company driver was determined to be at fault for the accident based on investigation findings.',
    `estimated_property_damage_amount` DECIMAL(18,2) COMMENT 'Estimated total dollar amount of property damage resulting from the accident, including damage to company vehicle, other vehicles, and third-party property.',
    `incident_date` DATE COMMENT 'The calendar date on which the accident occurred.',
    `incident_severity` STRING COMMENT 'Overall severity classification of the accident based on injuries, fatalities, and property damage.. Valid values are `minor|moderate|severe|catastrophic`',
    `incident_time` TIMESTAMP COMMENT 'The precise date and time when the accident occurred, including timezone information.',
    `incident_type` STRING COMMENT 'Classification of the type of accident that occurred (collision with another vehicle, rollover, backing incident, pedestrian involvement, property damage only, single vehicle incident).. Valid values are `collision|rollover|backing_incident|pedestrian|property_damage|single_vehicle`',
    `insurance_carrier` STRING COMMENT 'Name of the insurance company handling the claim for this accident.',
    `insurance_claim_number` STRING COMMENT 'Claim number assigned by the insurance carrier for processing the accident claim.',
    `investigation_completed_date` DATE COMMENT 'Date when the internal accident investigation was completed and findings documented.',
    `investigation_status` STRING COMMENT 'Current status of the internal accident investigation process.. Valid values are `pending|in_progress|completed|closed`',
    `light_conditions` STRING COMMENT 'Lighting conditions at the time of the accident.. Valid values are `daylight|dawn|dusk|dark_lighted|dark_unlighted`',
    `location_address` STRING COMMENT 'Street address or location description where the accident occurred.',
    `location_city` STRING COMMENT 'City where the accident occurred.',
    `location_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the accident location, captured from telematics or manually entered.',
    `location_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the accident location, captured from telematics or manually entered.',
    `location_state` STRING COMMENT 'Two-letter state code where the accident occurred.. Valid values are `^[A-Z]{2}$`',
    `location_zip_code` STRING COMMENT 'ZIP or postal code where the accident occurred.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `number_of_fatalities` STRING COMMENT 'Total count of fatalities resulting from the accident.',
    `number_of_injuries` STRING COMMENT 'Total count of individuals injured in the accident, including driver, passengers, pedestrians, and occupants of other vehicles.',
    `police_department` STRING COMMENT 'Name of the law enforcement agency that responded to and documented the accident.',
    `police_report_number` STRING COMMENT 'Official police report or case number assigned by law enforcement agency responding to the accident scene.',
    `post_accident_test_completed_flag` BOOLEAN COMMENT 'Indicates whether the required post-accident drug and alcohol test was completed within the regulatory timeframe.',
    `post_accident_test_date` DATE COMMENT 'Date when the post-accident drug and alcohol test was administered.',
    `post_accident_test_required_flag` BOOLEAN COMMENT 'Indicates whether a post-accident drug and alcohol test is required per FMCSA regulations (49 CFR Part 382) based on accident severity and circumstances.',
    `post_accident_test_result` STRING COMMENT 'Result of the post-accident drug and alcohol test (negative, positive, refused, or not completed).. Valid values are `negative|positive|refused|not_completed`',
    `preventable_flag` BOOLEAN COMMENT 'Indicates whether the accident was determined to be preventable by the driver through proper defensive driving techniques, based on investigation findings.',
    `reported_date` DATE COMMENT 'Date when the accident was first reported to the company by the driver or other party.',
    `road_conditions` STRING COMMENT 'Road surface conditions at the time and location of the accident.. Valid values are `dry|wet|icy|snow_covered|muddy|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this accident report record was last modified in the system.',
    `vehicle_speed_mph` STRING COMMENT 'Estimated or recorded speed of the company vehicle in miles per hour at the time of the accident, captured from telematics or driver report.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time and location of the accident. [ENUM-REF-CANDIDATE: clear|rain|snow|fog|ice|wind|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_accident_report PRIMARY KEY(`accident_report_id`)
) COMMENT 'DOT-reportable and non-reportable vehicle accident and incident records for fleet units. Captures incident date and time, vehicle unit, driver, incident location (address, GPS coordinates), incident type (collision, rollover, backing incident, pedestrian, property damage), DOT reportability flag (fatality, injury, tow-away), number of injuries, number of fatalities, estimated property damage amount, police report number, citation issued flag, citation description, drug and alcohol post-accident test required flag, test completion status, insurance claim number, and incident investigation status. Required for FMCSA accident register (49 CFR 390.15) and CSA score management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` (
    `driver_behavior_event_id` BIGINT COMMENT 'Primary key for driver_behavior_event',
    `driver_id` BIGINT COMMENT 'Identifier of the driver who triggered the behavior event.',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or fleet manager who reviewed the driver behavior event.',
    `route_id` BIGINT COMMENT 'Identifier of the collection route being executed when the behavior event occurred.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the driver shift during which the behavior event occurred.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle unit in which the event occurred.',
    `actual_speed_mph` DECIMAL(18,2) COMMENT 'Actual vehicle speed in miles per hour at the time of the speeding event, captured from telematics.',
    `address_text` STRING COMMENT 'Human-readable street address or location description where the driver behavior event occurred, reverse-geocoded from GPS (Global Positioning System) coordinates.',
    `city` STRING COMMENT 'City where the driver behavior event occurred, derived from GPS (Global Positioning System) coordinates.',
    `coaching_completed_date` DATE COMMENT 'Date when driver coaching or corrective action was completed for this behavior event.',
    `coaching_completed_flag` BOOLEAN COMMENT 'Indicates whether required driver coaching or corrective action has been completed following the behavior event.',
    `coaching_required_flag` BOOLEAN COMMENT 'Indicates whether driver coaching or corrective action is required based on the severity and frequency of the behavior event.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the driver behavior event occurred.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the driver behavior event record was first created in the system.',
    `dot_reportable_flag` BOOLEAN COMMENT 'Indicates whether this driver behavior event meets DOT (Department of Transportation) reporting thresholds for regulatory compliance.',
    `driver_score_impact` DECIMAL(18,2) COMMENT 'Numeric impact of this behavior event on the drivers overall safety score, used for performance evaluation and incentive programs.',
    `engine_hours` DECIMAL(18,2) COMMENT 'Cumulative engine hours at the time of the behavior event, captured from telematics.',
    `event_duration_seconds` DECIMAL(18,2) COMMENT 'Duration of the behavior event in seconds, applicable to events such as excessive idle or distracted driving.',
    `event_notes` STRING COMMENT 'Free-text notes or comments regarding the driver behavior event, including driver explanations or supervisor observations.',
    `event_severity` STRING COMMENT 'Severity level assigned to the driver behavior event based on risk assessment algorithms.. Valid values are `low|medium|high|critical`',
    `event_source_system` STRING COMMENT 'Name of the source system that generated the driver behavior event record, typically Geotab Fleet Telematics.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the driver behavior event occurred, captured from telematics system.',
    `event_type` STRING COMMENT 'Classification of the driver behavior event captured by telematics system. [ENUM-REF-CANDIDATE: harsh_braking|harsh_acceleration|harsh_cornering|speeding|excessive_idle|seatbelt_violation|distracted_driving|after_hours_operation — 8 candidates stripped; promote to reference product]',
    `fuel_level_percent` DECIMAL(18,2) COMMENT 'Fuel level as a percentage of tank capacity at the time of the behavior event, captured from telematics.',
    `g_force_value` DECIMAL(18,2) COMMENT 'Gravitational force measurement in g-units for harsh braking, acceleration, or cornering events, indicating severity of the maneuver.',
    `idle_duration_minutes` DECIMAL(18,2) COMMENT 'Duration of excessive idle time in minutes for idle events, used to track fuel efficiency and driver behavior.',
    `incident_flag` BOOLEAN COMMENT 'Indicates whether this driver behavior event resulted in or contributed to a safety incident or accident.',
    `insurance_claim_flag` BOOLEAN COMMENT 'Indicates whether this driver behavior event resulted in or contributed to an insurance claim.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate where the driver behavior event occurred, captured from GPS (Global Positioning System).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate where the driver behavior event occurred, captured from GPS (Global Positioning System).',
    `postal_code` STRING COMMENT 'Postal code where the driver behavior event occurred, derived from GPS (Global Positioning System) coordinates.',
    `posted_speed_limit_mph` STRING COMMENT 'Posted speed limit in miles per hour at the location where the speeding event occurred, derived from map data.',
    `reviewed_by_supervisor_flag` BOOLEAN COMMENT 'Indicates whether the driver behavior event has been reviewed by a supervisor or fleet manager.',
    `reviewed_date` DATE COMMENT 'Date when the driver behavior event was reviewed by a supervisor or fleet manager.',
    `road_type` STRING COMMENT 'Classification of the road type where the driver behavior event occurred, used for contextual risk analysis.. Valid values are `highway|arterial|residential|industrial|rural|parking_lot`',
    `speed_over_limit_mph` DECIMAL(18,2) COMMENT 'Amount by which the actual speed exceeded the posted speed limit in miles per hour, calculated for speeding events.',
    `state_province` STRING COMMENT 'State or province where the driver behavior event occurred, derived from GPS (Global Positioning System) coordinates.',
    `telematics_device_code` STRING COMMENT 'Unique identifier of the Geotab telematics device that captured the behavior event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the driver behavior event record was last updated in the system.',
    `vehicle_odometer_miles` DECIMAL(18,2) COMMENT 'Vehicle odometer reading in miles at the time of the behavior event, captured from telematics.',
    `weather_condition` STRING COMMENT 'Weather condition at the time and location of the driver behavior event, if available from integrated weather data sources.',
    CONSTRAINT pk_driver_behavior_event PRIMARY KEY(`driver_behavior_event_id`)
) COMMENT 'Scored driver behavior events derived from Geotab telematics data capturing individual unsafe or inefficient driving behaviors. Captures event timestamp, driver, vehicle unit, event type (harsh braking, harsh acceleration, harsh cornering, speeding, excessive idle, seatbelt violation, distracted driving, after-hours operation), event severity (low, medium, high), event duration (seconds), GPS location at event, posted speed limit (for speeding events), actual speed (for speeding events), idle duration minutes (for idle events), and coaching required flag. Supports driver safety programs, insurance risk management, and fuel efficiency initiatives.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` (
    `vehicle_utilization_id` BIGINT COMMENT 'Unique identifier for the daily vehicle utilization summary record.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Measuring vehicle productivity and utilization rates by customer contract enables performance monitoring against SLA commitments, validates pricing models, and supports contract renewal negotiations. ',
    `district_id` BIGINT COMMENT 'Reference to the operational district or service area where the vehicle operated.',
    `driver_id` BIGINT COMMENT 'Reference to the Commercial Driver License (CDL) driver assigned to operate the vehicle on this date.',
    `facility_id` BIGINT COMMENT 'Reference to the depot or facility from which the vehicle was dispatched.',
    `route_id` BIGINT COMMENT 'Primary route assignment for the vehicle on this operational day.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Shift supervisors are accountable for daily vehicle utilization metrics, route completion status, operational efficiency reporting, and driver performance management at district level.',
    `vehicle_id` BIGINT COMMENT 'Reference to the fleet vehicle unit for which utilization is being tracked.',
    `assigned_route_count` STRING COMMENT 'Total number of routes assigned to the vehicle during the operational day.',
    `available_hours` DECIMAL(18,2) COMMENT 'Total hours the vehicle was available for operational use during the scheduled shift.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vehicle utilization record was first created in the system.',
    `deadhead_miles` DECIMAL(18,2) COMMENT 'Non-revenue miles driven, including travel to/from depot, between routes, or repositioning.',
    `dot_compliance_status` STRING COMMENT 'Compliance status of the vehicle operation with DOT and FMCSA regulations for this operational day.. Valid values are `compliant|non_compliant|pending_review`',
    `driving_hours` DECIMAL(18,2) COMMENT 'Hours the vehicle was actively in motion during the operational day.',
    `fuel_consumed_gallons` DECIMAL(18,2) COMMENT 'Total fuel consumed during the operational day, measured in gallons for diesel or Gasoline Gallon Equivalent (GGE) for Compressed Natural Gas (CNG) or Renewable Natural Gas (RNG).',
    `fuel_efficiency_mpg` DECIMAL(18,2) COMMENT 'Calculated fuel efficiency in miles per gallon (MPG) or miles per gasoline gallon equivalent (MPGe) for alternative fuel vehicles.',
    `fuel_type` STRING COMMENT 'Type of fuel used by the vehicle: diesel, Compressed Natural Gas (CNG), Renewable Natural Gas (RNG), gasoline, electric, or hybrid.. Valid values are `diesel|CNG|RNG|gasoline|electric|hybrid`',
    `gps_tracking_enabled` BOOLEAN COMMENT 'Indicates whether GPS tracking was active and operational for the vehicle during this utilization period.',
    `idle_hours` DECIMAL(18,2) COMMENT 'Hours the vehicle engine was running while stationary, excluding Power Take-Off (PTO) operations.',
    `lift_count` STRING COMMENT 'Total number of container lifts or pickups performed by the vehicle during the operational day.',
    `maintenance_flag` BOOLEAN COMMENT 'Indicates whether the vehicle was flagged for maintenance or experienced a maintenance event during this operational day.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding vehicle utilization, operational issues, or special circumstances for this operational day.',
    `odometer_end` DECIMAL(18,2) COMMENT 'Vehicle odometer reading at the end of the operational day, measured in miles.',
    `odometer_start` DECIMAL(18,2) COMMENT 'Vehicle odometer reading at the start of the operational day, measured in miles.',
    `payload_tons_collected` DECIMAL(18,2) COMMENT 'Total weight of waste collected during the operational day, measured in tons, captured from onboard scales where available.',
    `pto_hours` DECIMAL(18,2) COMMENT 'Hours the vehicle Power Take-Off system was engaged for collection operations (compactor, hydraulic lifts).',
    `revenue_miles` DECIMAL(18,2) COMMENT 'Miles driven while performing revenue-generating collection or hauling activities.',
    `route_completion_status` STRING COMMENT 'Status of route completion for the assigned routes: completed, partial, cancelled, or rescheduled.. Valid values are `completed|partial|cancelled|rescheduled`',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident or violation was recorded for the vehicle during this operational day.',
    `service_stop_count` STRING COMMENT 'Total number of service stops completed during the operational day.',
    `shift_end_time` TIMESTAMP COMMENT 'Timestamp when the vehicle operational shift ended.',
    `shift_start_time` TIMESTAMP COMMENT 'Timestamp when the vehicle operational shift began.',
    `telematics_data_quality` STRING COMMENT 'Quality assessment of telematics data captured for this utilization record: complete, partial, missing, or error.. Valid values are `complete|partial|missing|error`',
    `total_engine_hours` DECIMAL(18,2) COMMENT 'Total hours the vehicle engine was running during the operational day.',
    `total_miles_driven` DECIMAL(18,2) COMMENT 'Total distance traveled by the vehicle during the operational day, measured in miles.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vehicle utilization record was last modified.',
    `utilization_date` DATE COMMENT 'The operational date for which vehicle utilization metrics are captured.',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of available hours that the vehicle was actively utilized, calculated as (total_engine_hours / available_hours) * 100.',
    `vehicle_type` STRING COMMENT 'Classification of the vehicle unit: Automated Side Loader (ASL), Front End Loader (FEL), Rear End Loader (REL), roll-off truck, transfer vehicle, or support vehicle.. Valid values are `ASL|FEL|REL|roll_off|transfer|support`',
    CONSTRAINT pk_vehicle_utilization PRIMARY KEY(`vehicle_utilization_id`)
) COMMENT 'Daily vehicle utilization summary records capturing operational performance metrics for each fleet unit per operational day. Captures utilization date, vehicle unit, assigned route count, total miles driven, revenue miles, deadhead miles, total engine hours, driving hours, idle hours, PTO hours, fuel consumed (gallons or GGE), fuel efficiency (MPG or MPGe), payload tons collected (where available from onboard scales), number of lifts/pickups, number of service stops, and utilization rate percentage (actual hours vs. available hours). Supports fleet right-sizing, route efficiency analysis, and capital planning.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` (
    `drug_alcohol_test_id` BIGINT COMMENT 'Unique identifier for the drug and alcohol test record. Primary key.',
    `accident_report_id` BIGINT COMMENT 'Reference to the accident record if this test was conducted as a post-accident test. Null if not accident-related.',
    `driver_id` BIGINT COMMENT 'Reference to the Commercial Drivers License (CDL) driver who was tested.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: HR/safety managers review test results for FMCSA compliance, SAP referrals, return-to-duty clearances, and FMCSA Drug & Alcohol Clearinghouse reporting requirements.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Drug/alcohol testing performed by contracted laboratories and collection sites. Essential for vendor certification tracking, FMCSA compliance, payment processing. Role-prefixed; removes denormalized c',
    `training_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.training_certification. Business justification: DOT drug/alcohol clearances and SAP return-to-duty certifications are regulatory certifications tracked in driver qualification files. HR and safety directors link test results to certification record',
    `accident_related` BOOLEAN COMMENT 'Indicates whether this test was conducted as a post-accident test following a DOT-reportable accident involving fatality, injury requiring immediate medical treatment away from the scene, or disabling damage to any vehicle requiring tow-away.',
    `alcohol_concentration` DECIMAL(18,2) COMMENT 'The measured blood alcohol concentration (BAC) level if an alcohol test was performed, expressed as a decimal (e.g., 0.040 for 0.04%). Null if drug-only test.',
    `chain_of_custody_number` STRING COMMENT 'The Federal CCF (Custody and Control Form) number used to track the specimen from collection through laboratory analysis.',
    `clearinghouse_report_date` DATE COMMENT 'The date the test result was reported to the FMCSA Drug and Alcohol Clearinghouse. Null if not yet reported or not reportable.',
    `collection_method` STRING COMMENT 'The specimen type or method used for collection: urine (drug test), breath (alcohol), oral fluid (drug or alcohol), or blood (rare, post-accident).. Valid values are `urine|breath|oral fluid|blood`',
    `collection_site_address` STRING COMMENT 'The physical address of the collection site, including street, city, state, and postal code.',
    `collector_name` STRING COMMENT 'The full name of the certified specimen collector who performed the collection procedure.',
    `confirmation_test_date` DATE COMMENT 'The date the confirmation test was conducted, if applicable. Null if no confirmation test was required.',
    `confirmation_test_performed` BOOLEAN COMMENT 'Indicates whether a confirmation test (GC/MS for drugs, evidential breath test for alcohol) was performed following a non-negative screening result.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this drug and alcohol test record was first created in the system.',
    `driver_notification_date` DATE COMMENT 'The date the driver was notified of the test result by the employer or MRO.',
    `fmcsa_reported` BOOLEAN COMMENT 'Indicates whether this test result has been reported to the FMCSA Drug and Alcohol Clearinghouse as required for positive, refused, adulterated, or substituted results.',
    `follow_up_test_count_required` STRING COMMENT 'The minimum number of follow-up tests prescribed by the SAP (typically 6 tests in the first 12 months). Null if no follow-up testing is required.',
    `follow_up_testing_end_date` DATE COMMENT 'The date when the follow-up testing period prescribed by the SAP is scheduled to end (12 to 60 months from return-to-duty). Null if not applicable.',
    `follow_up_testing_required` BOOLEAN COMMENT 'Indicates whether the driver is subject to unannounced follow-up testing for a minimum of 12 months (up to 60 months) as prescribed by the SAP.',
    `laboratory_accreditation_number` STRING COMMENT 'The SAMHSA certification or accreditation number of the testing laboratory.',
    `mro_name` STRING COMMENT 'The full name of the licensed physician (Medical Review Officer) who reviewed and verified the drug test result.',
    `mro_phone` STRING COMMENT 'The contact phone number for the Medical Review Officer who verified the test result.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to the test (e.g., shy bladder, split specimen requested, driver comments).',
    `positive_substance_identified` STRING COMMENT 'The specific controlled substance(s) detected if the test result was positive (e.g., marijuana, cocaine, opiates, amphetamines, PCP). Null if negative or alcohol-only test.',
    `reasonable_suspicion_documented` BOOLEAN COMMENT 'Indicates whether a trained supervisor documented specific, contemporaneous observations of driver behavior, appearance, or conduct that led to a reasonable suspicion test.',
    `record_retention_date` DATE COMMENT 'The date through which this test record must be retained per DOT regulations (typically 5 years from test date for negative results, longer for positive results).',
    `return_to_duty_clearance_date` DATE COMMENT 'The date the driver was cleared by the SAP and passed a return-to-duty test, allowing them to resume safety-sensitive functions. Null if not applicable.',
    `sap_evaluation_date` DATE COMMENT 'The date the driver completed the initial SAP evaluation, if required. Null if no SAP referral was made.',
    `sap_name` STRING COMMENT 'The full name of the Substance Abuse Professional assigned to evaluate and recommend treatment for the driver, if applicable.',
    `sap_referral_required` BOOLEAN COMMENT 'Indicates whether the driver must be referred to a Substance Abuse Professional (SAP) for evaluation and treatment following a positive, adulterated, substituted, or refused test.',
    `specimen_number` STRING COMMENT 'The unique identifier assigned to the specimen (urine, breath, oral fluid) for chain-of-custody tracking.',
    `substance_tested` STRING COMMENT 'Indicates whether the test screened for drugs (5-panel or 10-panel), alcohol (breath or saliva), or both substances.. Valid values are `drug panel|alcohol|both`',
    `supervisor_name` STRING COMMENT 'The name of the trained supervisor who made the reasonable suspicion determination, if applicable. Null if not a reasonable suspicion test.',
    `test_date` DATE COMMENT 'The date on which the drug or alcohol test was conducted.',
    `test_result` STRING COMMENT 'The final outcome of the test as determined by the MRO or Breath Alcohol Technician (BAT): negative (no substances detected), positive (substance detected above threshold), dilute (specimen too diluted), substituted (not human urine), adulterated (specimen tampered), cancelled (invalid test), or refused (driver refused to test). [ENUM-REF-CANDIDATE: negative|positive|dilute|substituted|adulterated|cancelled|refused — 7 candidates stripped; promote to reference product]',
    `test_status` STRING COMMENT 'The current administrative status of the test record: scheduled (test appointment set), completed (result finalized), cancelled (test invalidated), refused (driver refused to test), or pending review (awaiting MRO verification).. Valid values are `scheduled|completed|cancelled|refused|pending review`',
    `test_time` TIMESTAMP COMMENT 'The precise timestamp when the specimen was collected or breath test was administered.',
    `test_type` STRING COMMENT 'The category of DOT-mandated test: pre-employment (before hire), random (unannounced selection), post-accident (after qualifying incident), reasonable suspicion (supervisor-initiated), return-to-duty (after violation), or follow-up (ongoing monitoring).. Valid values are `pre-employment|random|post-accident|reasonable suspicion|return-to-duty|follow-up`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this drug and alcohol test record was last modified in the system.',
    CONSTRAINT pk_drug_alcohol_test PRIMARY KEY(`drug_alcohol_test_id`)
) COMMENT 'DOT-mandated drug and alcohol testing records for CDL drivers under 49 CFR Part 382 (FMCSA) and Part 40 (DOT). Captures test date, driver, test type (pre-employment, random, post-accident, reasonable suspicion, return-to-duty, follow-up), substance tested (drug panel, alcohol, or both), collection site, collection method (urine, breath, oral fluid), MRO (Medical Review Officer) name, test result (negative, positive, dilute, substituted, adulterated, cancelled), alcohol concentration (BAC) if applicable, positive substance identified (if applicable), SAP (Substance Abuse Professional) referral flag, and return-to-duty clearance date. Critical for FMCSA compliance and driver qualification file maintenance.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Primary key for cost_allocation',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Fundamental business process: allocating fleet operating costs (fuel, maintenance, depreciation) to customer contracts for profitability analysis, pricing validation, and contract renewal decisions. E',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this cost allocation for posting, for audit and accountability.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Fleet costs are allocated to specific service offerings for profitability analysis, rate setting, cost-to-serve calculations, and offering-level P&L reporting. Essential for financial management and p',
    `original_allocation_cost_allocation_id` BIGINT COMMENT 'Reference to the original cost allocation record if this record is a reversal or correction.',
    `route_id` BIGINT COMMENT 'Reference to the specific collection route to which the cost is allocated, if applicable.',
    `vehicle_id` BIGINT COMMENT 'Reference to the vehicle unit for which costs are being allocated.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order associated with this cost allocation, if the cost is maintenance-related.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Fleet operating costs are allocated to WTE facilities for internal cost accounting and profitability analysis. Finance needs to attribute vehicle costs (fuel, maintenance, depreciation) to the specifi',
    `allocation_basis_quantity` DECIMAL(18,2) COMMENT 'The quantity of the allocation basis used (miles driven, hours operated, tons hauled) for the allocation calculation.',
    `allocation_basis_unit` STRING COMMENT 'The unit of measure for the allocation basis quantity (miles, kilometers, hours, tons, trips, percentage).. Valid values are `miles|kilometers|hours|tons|trips|percentage`',
    `allocation_method` STRING COMMENT 'The methodology used to allocate the cost (actual, standard rate, mileage-based, hours-based, tonnage-based, equal distribution).. Valid values are `actual|standard_rate|mileage_based|hours_based|tonnage_based|equal_distribution`',
    `allocation_notes` STRING COMMENT 'Free-text notes or comments explaining special circumstances, adjustments, or rationale for this cost allocation.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of total cost allocated to this cost center or service line when using percentage-based allocation (0.00 to 100.00).',
    `allocation_period_end_date` DATE COMMENT 'The last day of the period for which costs are being allocated (typically month or year end).',
    `allocation_period_start_date` DATE COMMENT 'The first day of the period for which costs are being allocated (typically month or year start).',
    `allocation_rate` DECIMAL(18,2) COMMENT 'The rate applied per unit of allocation basis (e.g., cost per mile, cost per hour) used to calculate the allocated amount.',
    `allocation_status` STRING COMMENT 'The current workflow status of the cost allocation record (draft, pending approval, approved, posted, reversed, cancelled).. Valid values are `draft|pending_approval|approved|posted|reversed|cancelled`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation was approved for posting.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the cost being allocated for this category and period, in USD.',
    `cost_category` STRING COMMENT 'The category of fleet operating cost being allocated (fuel, preventive maintenance, corrective repair, tires, insurance, registration, depreciation, lease, other). [ENUM-REF-CANDIDATE: fuel|preventive_maintenance|corrective_repair|tires|insurance|registration|depreciation|lease|other — 9 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'The SAP cost center code to which the fleet cost is allocated (operational cost center, route, district).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation record was first created in the system.',
    `district_code` STRING COMMENT 'The operational district code to which the cost is allocated for geographic reporting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year to which this cost allocation belongs (1-12).',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this cost allocation belongs for annual financial reporting.',
    `fuel_consumed_gallons` DECIMAL(18,2) COMMENT 'The total fuel consumed in gallons during the allocation period, sourced from Geotab telematics or fuel card transactions.',
    `fuel_type` STRING COMMENT 'The fuel type of the vehicle (diesel, CNG - Compressed Natural Gas, RNG - Renewable Natural Gas, gasoline, electric, hybrid) for sustainability and cost analysis.. Valid values are `diesel|cng|rng|gasoline|electric|hybrid`',
    `gl_account_code` STRING COMMENT 'The SAP General Ledger account code to which this cost is posted for financial statement reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation record was last updated or modified.',
    `mileage_driven` DECIMAL(18,2) COMMENT 'The total miles driven by the vehicle during the allocation period, sourced from Geotab telematics.',
    `operating_hours` DECIMAL(18,2) COMMENT 'The total operating hours logged by the vehicle during the allocation period, sourced from Geotab telematics.',
    `profit_center_code` STRING COMMENT 'The SAP profit center code for segment reporting and profitability analysis.',
    `reversal_reason` STRING COMMENT 'The reason for reversing or cancelling this cost allocation, if applicable (e.g., data error, period adjustment, reallocation).',
    `sap_cost_document_number` STRING COMMENT 'The SAP FI/CO document number that records this cost allocation transaction for financial reporting and audit trail.',
    `sap_posting_date` DATE COMMENT 'The date on which the cost allocation was posted in SAP FI/CO for financial period assignment.',
    `service_line` STRING COMMENT 'The business service line to which the cost is allocated (residential, commercial, roll-off, recycling, hazmat, transfer) for COGS and EBITDA analysis.. Valid values are `residential|commercial|roll_off|recycling|hazmat|transfer`',
    `tonnage_hauled` DECIMAL(18,2) COMMENT 'The total tonnage hauled by the vehicle during the allocation period, measured in tons, for tonnage-based cost allocation.',
    `trips_completed` STRING COMMENT 'The total number of trips or runs completed by the vehicle during the allocation period.',
    `vehicle_type` STRING COMMENT 'The type of vehicle for which costs are allocated (ASL - Automated Side Loader, FEL - Front End Loader, REL - Rear End Loader, roll-off, transfer, support).',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Periodic cost allocation records distributing fleet operating costs (fuel, maintenance, depreciation, insurance, licensing) to operational cost centers, routes, districts, and service lines. Captures allocation period (month/year), vehicle unit, cost category (fuel, preventive maintenance, corrective repair, tires, insurance, registration, depreciation), cost amount, cost center code, district code, service line (residential, commercial, roll-off), allocation method (actual, standard rate, mileage-based), SAP cost document reference, and allocation status. Integrates with SAP FI/CO for financial reporting and supports COGS and EBITDA analysis by service line.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` (
    `vehicle_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the vehicle lifecycle event record. Primary key.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: Vehicle commissioning/decommissioning events trigger emission source inventory updates. When vehicles enter/exit fleet, corresponding emission_source records must be created/retired for accurate GHG i',
    `employee_id` BIGINT COMMENT 'Reference to the manager or supervisor who authorized or approved this lifecycle event. Provides accountability and audit trail.',
    `district_id` BIGINT COMMENT 'Reference to the operational district or service area associated with this lifecycle event. Relevant for transfer, assignment, and deployment events.',
    `vehicle_id` BIGINT COMMENT 'Reference to the fleet vehicle unit that this lifecycle event pertains to. Links to the vehicle master record.',
    `tertiary_vehicle_transfer_to_district_id` BIGINT COMMENT 'Reference to the destination district for vehicle transfer events. Null for non-transfer events.',
    `location_id` BIGINT COMMENT 'Reference to the physical yard, depot, or maintenance facility where the vehicle was located at the time of this event.',
    `accident_claim_number` STRING COMMENT 'The insurance claim number associated with accident damage events. Links to insurance and risk management systems.',
    `actual_return_to_service_date` DATE COMMENT 'The actual date when the vehicle was returned to operational service. Enables comparison against estimated date for performance tracking.',
    `data_source_system` STRING COMMENT 'The name of the source operational system from which this lifecycle event record originated (e.g., Infor EAM, Geotab, SAP MM).',
    `disposal_method` STRING COMMENT 'The method by which the vehicle was disposed of at end-of-life. Applicable only for decommissioned, sold, scrapped, or totaled event types.. Valid values are `sold|scrapped|donated|traded|totaled|recycled`',
    `disposal_vendor_name` STRING COMMENT 'The name of the third-party vendor, buyer, or salvage company involved in the vehicle disposal transaction.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'The total number of hours the vehicle was unavailable for service due to this lifecycle event. Used for fleet availability and utilization KPI reporting.',
    `engine_hours` STRING COMMENT 'The cumulative engine operating hours at the time of the lifecycle event. Critical for maintenance scheduling and asset valuation.',
    `estimated_return_to_service_date` DATE COMMENT 'The projected date when the vehicle is expected to return to operational service. Used for fleet availability planning and resource allocation.',
    `event_date` DATE COMMENT 'The calendar date on which the lifecycle event occurred or was recorded. Principal business event timestamp for this transaction.',
    `event_description` STRING COMMENT 'Detailed narrative description of the lifecycle event, including context, circumstances, and any relevant operational notes.',
    `event_notes` STRING COMMENT 'Additional free-form notes, comments, or observations related to the lifecycle event. Captures supplementary information not covered by structured fields.',
    `event_type` STRING COMMENT 'The type of lifecycle milestone event. Categorizes the nature of the vehicle status transition or operational change. [ENUM-REF-CANDIDATE: ordered|received|commissioned|placed_in_service|out_of_service|returned_to_service|transferred|refurbished|decommissioned|sold|scrapped|totaled — 12 candidates stripped; promote to reference product]',
    `new_status` STRING COMMENT 'The vehicle operational status resulting from this lifecycle event. Represents the current state after the event. [ENUM-REF-CANDIDATE: ordered|in_transit|commissioned|in_service|out_of_service|transferred|refurbished|decommissioned|disposed — 9 candidates stripped; promote to reference product]',
    `odometer_reading_miles` STRING COMMENT 'The vehicle odometer reading in miles at the time of the lifecycle event. Provides mileage-based lifecycle tracking.',
    `oos_reason_category` STRING COMMENT 'The primary reason category for an out-of-service event. Applicable only when event_type is out_of_service. Supports DOT and FMCSA compliance tracking. [ENUM-REF-CANDIDATE: dot_order|mechanical_failure|scheduled_pm|accident_damage|awaiting_parts|regulatory_hold|safety_inspection|body_repair|engine_overhaul|transmission_repair — 10 candidates stripped; promote to reference product]',
    `oos_reason_detail` STRING COMMENT 'Detailed explanation of the specific reason for the out-of-service status, including technical diagnosis, failure mode, or regulatory citation.',
    `prior_status` STRING COMMENT 'The vehicle operational status immediately before this lifecycle event occurred. Provides audit trail of status transitions. [ENUM-REF-CANDIDATE: ordered|in_transit|commissioned|in_service|out_of_service|transferred|refurbished|decommissioned|disposed — 9 candidates stripped; promote to reference product]',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with vehicle acquisition or major refurbishment events. Links to SAP MM procurement records.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this lifecycle event record was first created in the system. Audit trail for data governance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this lifecycle event record was last modified. Audit trail for data governance.',
    `regulatory_citation` STRING COMMENT 'The specific regulatory code, standard, or citation that triggered or governs this lifecycle event. Applicable for compliance-driven events.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event was triggered by or related to regulatory compliance requirements (DOT, EPA, OSHA). True if compliance-related, False otherwise.',
    `replacement_vehicle_assigned_flag` BOOLEAN COMMENT 'Indicates whether a replacement vehicle was assigned to cover the operational capacity during an out-of-service period. True if replacement assigned, False otherwise.',
    `transaction_value_usd` DECIMAL(18,2) COMMENT 'The monetary value associated with the lifecycle event in US Dollars. Applicable for acquisition, sale, disposal, or refurbishment events. Null for non-financial events.',
    `work_order_number` STRING COMMENT 'The maintenance or repair work order number associated with this lifecycle event. Links to Infor EAM work order records for maintenance-related events.',
    CONSTRAINT pk_vehicle_lifecycle_event PRIMARY KEY(`vehicle_lifecycle_event_id`)
) COMMENT 'Milestone lifecycle event records tracking the full cradle-to-grave history of each fleet vehicle from acquisition through disposal, including out-of-service periods. Captures event date, vehicle unit, event type (ordered, received, commissioned, placed-in-service, out-of-service, returned-to-service, transferred, refurbished, decommissioned, sold, scrapped, totaled), event description, prior and new status, associated district/yard, OOS reason category (DOT order, mechanical failure, scheduled PM, accident damage, awaiting parts, regulatory hold), estimated and actual return-to-service dates, replacement vehicle assigned flag, transaction value, disposal method, and authorizing manager. Provides complete vehicle lifecycle and availability audit trail.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`vehicle_class` (
    `vehicle_class_id` BIGINT COMMENT 'Unique identifier for the vehicle class reference record. Primary key.',
    `emission_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_factor. Business justification: Vehicle class characteristics (fuel type, engine specs, body type) determine applicable EPA emission factors for mobile source calculations. Business process: emission factor assignment for fleet GHG ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fleet managers define vehicle class specifications, PM intervals, lifecycle policies, and procurement standards for fleet standardization, total cost of ownership analysis, and capital planning.',
    `parent_vehicle_class_id` BIGINT COMMENT 'Self-referencing FK on vehicle_class (parent_vehicle_class_id)',
    `annual_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether vehicles in this class require annual DOT safety inspections. True if required, False if not.',
    `average_acquisition_cost_usd` DECIMAL(18,2) COMMENT 'Average acquisition cost for a new vehicle in this class, measured in US dollars. Used for capital planning and budgeting.',
    `average_annual_operating_cost_usd` DECIMAL(18,2) COMMENT 'Average annual operating cost for vehicles in this class including fuel, maintenance, insurance, and depreciation, measured in US dollars.',
    `average_stops_per_shift` STRING COMMENT 'Typical number of service stops this vehicle class can complete in a standard shift. Used for route planning and capacity modeling.',
    `average_tons_per_day` DECIMAL(18,2) COMMENT 'Average tonnage of waste this vehicle class typically collects per operating day. TPD = Tons Per Day.',
    `axle_configuration` STRING COMMENT 'Axle configuration of the vehicle class (e.g., 4x2, 6x4, 8x4). Format is drive_axles x total_axles.. Valid values are `^[0-9]{1}x[0-9]{1}$`',
    `backup_camera_required_flag` BOOLEAN COMMENT 'Indicates whether backup cameras are required safety equipment for this vehicle class. True if required, False if not.',
    `body_capacity_cubic_yards` DECIMAL(18,2) COMMENT 'Standard body capacity of the vehicle class measured in cubic yards. Represents the volume of waste the vehicle can hold.',
    `body_manufacturer` STRING COMMENT 'Typical or preferred body manufacturer for vehicles in this class (e.g., McNeilus, Heil, Labrie, New Way).',
    `body_type` STRING COMMENT 'Type of vehicle body configuration. ASL = Automated Side Loader, FEL = Front End Loader, REL = Rear End Loader. [ENUM-REF-CANDIDATE: ASL|FEL|REL|roll-off|transfer|hook-lift|grapple|compactor|flatbed|service — 10 candidates stripped; promote to reference product]',
    `cdl_class_required` STRING COMMENT 'Minimum CDL class required to operate vehicles in this class (A, B, C, or none if no CDL required).. Valid values are `A|B|C|none`',
    `cdl_required_flag` BOOLEAN COMMENT 'Indicates whether a Commercial Driver License is required to operate vehicles in this class. True if CDL is required, False if not.',
    `class_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the vehicle class (e.g., ASL-20, FEL-30, REL-25, ROLLOFF-40). Used as the business identifier for classification.. Valid values are `^[A-Z0-9]{2,10}$`',
    `class_name` STRING COMMENT 'Full descriptive name of the vehicle class (e.g., Automated Side Loader 20-Yard, Front End Loader 30-Yard, Rear End Loader 25-Yard, Roll-Off Truck 40-Yard).',
    `compaction_ratio` DECIMAL(18,2) COMMENT 'Typical compaction ratio achieved by this vehicle class (e.g., 3.5:1 means 3.5 cubic yards of loose waste compacts to 1 cubic yard). Null for non-compacting vehicles.',
    `compaction_type` STRING COMMENT 'Type of compaction system used in the vehicle body (packer for rear loaders, compactor for side loaders, non-compacting for roll-offs, stationary for transfer vehicles).. Valid values are `packer|compactor|non_compacting|stationary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vehicle class record was first created in the system.',
    `crew_size` STRING COMMENT 'Standard crew size for vehicles in this class (e.g., 1 for automated side loaders, 2-3 for rear loaders with helpers).',
    `dot_vehicle_class` STRING COMMENT 'DOT vehicle classification number (1-8) based on GVWR. Class 1-2: light duty, 3-6: medium duty, 7-8: heavy duty.. Valid values are `^[1-8]$`',
    `effective_date` DATE COMMENT 'Date when this vehicle class definition became effective and available for fleet planning and procurement.',
    `emissions_standard` STRING COMMENT 'EPA emissions standard certification level for this vehicle class (e.g., EPA 2010, EPA 2021, CARB Ultra-Low NOx).',
    `end_date` DATE COMMENT 'Date when this vehicle class was deprecated or discontinued. Null for active classes.',
    `endorsements_required` STRING COMMENT 'Comma-separated list of CDL endorsements required for this vehicle class (e.g., H for hazmat, N for tank, X for hazmat+tank). Null if no endorsements required.',
    `expected_useful_life_miles` STRING COMMENT 'Expected useful life of vehicles in this class measured in miles before replacement is typically required.',
    `expected_useful_life_years` STRING COMMENT 'Expected useful life of vehicles in this class measured in years before replacement is typically required.',
    `fuel_tank_capacity_gallons` DECIMAL(18,2) COMMENT 'Standard fuel tank capacity for this vehicle class measured in gallons. For CNG vehicles, this represents gasoline gallon equivalent (GGE).',
    `fuel_type` STRING COMMENT 'Primary fuel type for this vehicle class. CNG = Compressed Natural Gas, RNG = Renewable Natural Gas.. Valid values are `diesel|CNG|RNG|electric|hybrid|gasoline`',
    `gvwr_lbs` STRING COMMENT 'Gross Vehicle Weight Rating in pounds. Maximum total weight of the vehicle including chassis, body, fuel, and payload as specified by the manufacturer.',
    `hydraulic_system_type` STRING COMMENT 'Type of hydraulic system used for lifting and compaction operations (single-stage, two-stage, or none for non-hydraulic vehicles).. Valid values are `single_stage|two_stage|none`',
    `lift_mechanism` STRING COMMENT 'Type of lifting mechanism used by this vehicle class to handle containers or waste (automated arm for ASL, front forks for FEL, rear forks for REL, hook/cable for roll-off, grapple for transfer, none for non-collection vehicles). [ENUM-REF-CANDIDATE: automated_arm|front_forks|rear_forks|hook|cable|grapple|none — 7 candidates stripped; promote to reference product]',
    `manufacturer_make` STRING COMMENT 'Typical or preferred manufacturer make for vehicles in this class (e.g., Peterbilt, Mack, Freightliner, Autocar).',
    `notes` STRING COMMENT 'Additional notes, specifications, or operational guidance for this vehicle class.',
    `payload_capacity_lbs` STRING COMMENT 'Maximum payload weight capacity in pounds that the vehicle class is rated to carry safely.',
    `pm_interval_days` STRING COMMENT 'Standard preventive maintenance interval in calendar days for vehicles in this class. PM = Preventive Maintenance.',
    `pm_interval_miles` STRING COMMENT 'Standard preventive maintenance interval in miles for vehicles in this class. PM = Preventive Maintenance.',
    `pto_equipped_flag` BOOLEAN COMMENT 'Indicates whether vehicles in this class are equipped with Power Take-Off systems for hydraulic operations. True if PTO-equipped, False if not.',
    `service_line` STRING COMMENT 'Primary service line this vehicle class is designed to support (residential, commercial, industrial, recycling, hazardous waste, landfill operations).. Valid values are `residential|commercial|industrial|recycling|hazardous|landfill`',
    `telematics_required_flag` BOOLEAN COMMENT 'Indicates whether telematics devices are required for vehicles in this class. True if required, False if optional.',
    `typical_route_type` STRING COMMENT 'Typical route type this vehicle class is optimized for (residential collection, commercial collection, industrial, transfer haul, landfill operations, or mixed use).. Valid values are `residential|commercial|industrial|transfer|landfill|mixed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vehicle class record was last modified.',
    `vehicle_category` STRING COMMENT 'High-level operational category of the vehicle class (collection, transfer, roll-off, support, administrative).. Valid values are `collection|transfer|roll-off|support|administrative`',
    `vehicle_class_status` STRING COMMENT 'Current lifecycle status of this vehicle class. Active = currently in use, Inactive = no longer procuring but existing vehicles still operational, Deprecated = phased out, Planned = future class not yet deployed.. Valid values are `active|inactive|deprecated|planned`',
    CONSTRAINT pk_vehicle_class PRIMARY KEY(`vehicle_class_id`)
) COMMENT 'Reference classification of fleet vehicle types and body configurations (ASL, FEL, REL, roll-off, CNG, RNG, electric) with capacity specs, weight ratings, and operational parameters';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` (
    `maintenance_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule entry. Primary key.',
    `facility_id` BIGINT COMMENT 'Reference to the maintenance facility or yard where this preventive maintenance is scheduled to be performed.',
    `employee_id` BIGINT COMMENT 'Reference to the mechanic or technician assigned to perform this preventive maintenance.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Preventive maintenance schedules are asset maintenance strategies that drive condition-based maintenance planning, asset reliability analysis, and maintenance cost capitalization decisions per IAS 16.',
    `service_checklist_template_id` BIGINT COMMENT 'Reference to the standardized service checklist template that defines the tasks and inspections to be performed during this preventive maintenance.',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_contract. Business justification: Preventive maintenance services (oil changes, tire rotations, hydraulic service) are often executed under master service agreements. Links scheduled maintenance to contracted service terms for complia',
    `vehicle_id` BIGINT COMMENT 'Reference to the vehicle assigned to this maintenance schedule.',
    `superseded_maintenance_schedule_id` BIGINT COMMENT 'Self-referencing FK on maintenance_schedule (superseded_maintenance_schedule_id)',
    `actual_completion_date` DATE COMMENT 'The actual date when this preventive maintenance was completed.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this preventive maintenance was completed.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'The actual duration (in hours) taken to complete this preventive maintenance service.',
    `calendar_interval_days` STRING COMMENT 'The calendar-based interval (in days) at which this preventive maintenance is scheduled to occur.',
    `certification_number` STRING COMMENT 'The certification or inspection number issued upon successful completion of this preventive maintenance, particularly for DOT or emissions inspections.',
    `completion_engine_hours` STRING COMMENT 'The vehicle engine hours at the time this preventive maintenance was completed.',
    `completion_odometer_miles` STRING COMMENT 'The vehicle odometer reading (in miles) at the time this preventive maintenance was completed.',
    `cost_currency` STRING COMMENT 'The ISO 4217 three-letter currency code for cost amounts (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this maintenance schedule record was first created in the system.',
    `defects_description` STRING COMMENT 'Detailed description of any defects or issues identified during this preventive maintenance service.',
    `defects_found_flag` BOOLEAN COMMENT 'Indicates whether any defects or issues were identified during this preventive maintenance service.',
    `dot_inspection_flag` BOOLEAN COMMENT 'Indicates whether this preventive maintenance includes a DOT annual inspection requirement.',
    `emissions_inspection_flag` BOOLEAN COMMENT 'Indicates whether this preventive maintenance includes an emissions inspection requirement per EPA and state regulations.',
    `engine_hours_interval` STRING COMMENT 'The engine hours interval at which this preventive maintenance is scheduled to occur.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'The estimated duration (in hours) required to complete this preventive maintenance service.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'The estimated labor cost for this preventive maintenance service.',
    `estimated_parts_cost` DECIMAL(18,2) COMMENT 'The estimated cost of parts required for this preventive maintenance service.',
    `fmcsa_required_flag` BOOLEAN COMMENT 'Indicates whether this preventive maintenance is required by FMCSA regulations for DOT compliance.',
    `last_completed_date` DATE COMMENT 'The date when this preventive maintenance was last completed.',
    `last_completed_engine_hours` STRING COMMENT 'The vehicle engine hours at the time this preventive maintenance was last completed.',
    `last_completed_odometer_miles` STRING COMMENT 'The vehicle odometer reading (in miles) at the time this preventive maintenance was last completed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this maintenance schedule record was last modified.',
    `mileage_interval` STRING COMMENT 'The mileage interval (in miles) at which this preventive maintenance is scheduled to occur.',
    `next_due_date` DATE COMMENT 'The calculated date when this preventive maintenance is next due based on calendar interval.',
    `next_due_engine_hours` STRING COMMENT 'The calculated engine hours at which this preventive maintenance is next due based on engine hours interval.',
    `next_due_odometer_miles` STRING COMMENT 'The calculated odometer reading (in miles) at which this preventive maintenance is next due based on mileage interval.',
    `notes` STRING COMMENT 'Additional notes or comments related to this preventive maintenance schedule entry.',
    `out_of_service_flag` BOOLEAN COMMENT 'Indicates whether the vehicle was placed out of service as a result of findings during this preventive maintenance.',
    `pm_type` STRING COMMENT 'Classification of the preventive maintenance service level (A-service for minor, B-service for intermediate, C-service for major overhaul, annual inspection, DOT inspection, emissions inspection).. Valid values are `a_service|b_service|c_service|annual_inspection|dot_inspection|emissions_inspection`',
    `priority` STRING COMMENT 'The priority level assigned to this preventive maintenance schedule entry.. Valid values are `low|medium|high|critical`',
    `schedule_number` STRING COMMENT 'Business identifier for the preventive maintenance schedule, used for tracking and reference in Infor EAM.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the maintenance schedule entry.. Valid values are `scheduled|due|overdue|in_progress|completed|cancelled`',
    `scheduled_date` DATE COMMENT 'The date on which this preventive maintenance is scheduled to be performed.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise timestamp when this preventive maintenance is scheduled to begin.',
    `trigger_type` STRING COMMENT 'The basis for triggering this preventive maintenance event: mileage-based, engine hours-based, calendar-based, or combined criteria per FMCSA requirements.. Valid values are `mileage|engine_hours|calendar|combined`',
    CONSTRAINT pk_maintenance_schedule PRIMARY KEY(`maintenance_schedule_id`)
) COMMENT 'Fleet-specific preventive maintenance schedule linking vehicles to PM intervals based on mileage, engine hours, and calendar triggers per FMCSA requirements';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` (
    `fleet_insurance_id` BIGINT COMMENT 'Unique identifier for the fleet insurance policy record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Insurance carriers are vendors providing insurance services. Critical for vendor management, policy renewal tracking, claims processing, payment management. Role-prefixed to distinguish from other ven',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Fleet insurance policies cover specific fixed assets and must reconcile insured value vs. book value for risk management and certificate of insurance generation. This link enables finance to identify ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: DOT insurance filings (MCS-90, BMC-91X) and certificates of insurance are regulatory permits/authorizations. Compliance officers track insurance permits alongside operating permits for unified DOT/FMC',
    `vehicle_id` BIGINT COMMENT 'Reference to the vehicle covered by this insurance policy.',
    `renewed_fleet_insurance_id` BIGINT COMMENT 'Self-referencing FK on fleet_insurance (renewed_fleet_insurance_id)',
    `additional_insured_parties` STRING COMMENT 'Names of any additional parties covered under this insurance policy.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the policy is set to automatically renew at expiration.',
    `broker_contact_email` STRING COMMENT 'Primary email address for contacting the insurance broker.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `broker_contact_phone` STRING COMMENT 'Primary phone number for contacting the insurance broker.',
    `broker_name` STRING COMMENT 'Name of the insurance broker or agent who facilitated this policy.',
    `cancellation_date` DATE COMMENT 'Date when the policy was cancelled before its natural expiration.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the insurance policy was cancelled.',
    `cargo_coverage_limit` DECIMAL(18,2) COMMENT 'Maximum amount the insurer will pay for damage to cargo being transported.',
    `carrier_policy_number` STRING COMMENT 'Insurance carriers internal identifier for this policy.',
    `certificate_issue_date` DATE COMMENT 'Date when the certificate of insurance was issued.',
    `certificate_of_insurance_number` STRING COMMENT 'Unique identifier for the certificate of insurance document issued for this policy.',
    `claims_phone_number` STRING COMMENT 'Phone number to contact the insurance carrier for filing claims.',
    `coverage_territory` STRING COMMENT 'Geographic territories where the insurance coverage is valid (e.g., USA, Canada, Mexico).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this insurance policy record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this policy.. Valid values are `^[A-Z]{3}$`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount the insured must pay out-of-pocket before insurance coverage applies.',
    `dot_filing_type` STRING COMMENT 'Type of DOT insurance filing form submitted to demonstrate financial responsibility.. Valid values are `bmcr_91|mcs_90|bmcr_91x|not_required`',
    `dot_minimum_compliance_flag` BOOLEAN COMMENT 'Indicates whether this policy meets DOT minimum financial responsibility requirements for commercial motor vehicles.',
    `effective_date` DATE COMMENT 'Date when the insurance coverage becomes active and binding.',
    `excluded_drivers` STRING COMMENT 'List of drivers explicitly excluded from coverage under this policy.',
    `expiration_date` DATE COMMENT 'Date when the insurance coverage terminates unless renewed.',
    `last_audit_date` DATE COMMENT 'Date of the most recent insurance audit conducted for premium adjustment purposes.',
    `liability_coverage_limit` DECIMAL(18,2) COMMENT 'Maximum amount the insurer will pay for liability claims per occurrence.',
    `loss_payee_name` STRING COMMENT 'Name of the party (typically a lender or lessor) designated to receive insurance claim payments.',
    `named_insured` STRING COMMENT 'Legal name of the entity or person listed as the insured party on the policy.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next insurance audit.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this insurance policy.',
    `physical_damage_coverage_limit` DECIMAL(18,2) COMMENT 'Maximum amount the insurer will pay for physical damage to the insured vehicle.',
    `policy_document_url` STRING COMMENT 'URL or file path to the digital copy of the insurance policy document.',
    `policy_endorsements` STRING COMMENT 'Additional endorsements or riders attached to the base policy that modify coverage terms.',
    `policy_number` STRING COMMENT 'Unique policy number assigned by the insurance carrier for this commercial auto insurance policy.. Valid values are `^[A-Z0-9]{8,20}$`',
    `policy_status` STRING COMMENT 'Current lifecycle status of the insurance policy.. Valid values are `active|pending|expired|cancelled|suspended|lapsed`',
    `policy_type` STRING COMMENT 'Type of commercial auto insurance coverage provided by this policy.. Valid values are `liability|physical_damage|comprehensive|collision|cargo|uninsured_motorist`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount charged for this insurance policy coverage period.',
    `premium_frequency` STRING COMMENT 'Frequency at which insurance premium payments are due.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `radius_of_operation` STRING COMMENT 'Geographic operating radius covered by the policy (local, regional, or nationwide).. Valid values are `local|intermediate|long_haul|unrestricted`',
    `renewal_date` DATE COMMENT 'Scheduled date for policy renewal evaluation and processing.',
    `uninsured_motorist_coverage_limit` DECIMAL(18,2) COMMENT 'Maximum amount the insurer will pay for damages caused by uninsured or underinsured motorists.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this insurance policy record was last modified in the system.',
    `vehicle_use_classification` STRING COMMENT 'Classification of how the insured vehicle is used, affecting coverage terms and premium.. Valid values are `commercial|service|business|personal`',
    CONSTRAINT pk_fleet_insurance PRIMARY KEY(`fleet_insurance_id`)
) COMMENT 'Commercial auto insurance policy records for fleet vehicles including liability, physical damage, cargo coverage, and DOT minimum financial responsibility compliance';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` (
    `driver_initiative_participation_id` BIGINT COMMENT 'Unique identifier for this driver-initiative participation record. Primary key for the association.',
    `carbon_initiative_id` BIGINT COMMENT 'Foreign key linking to the carbon reduction initiative in which the driver is enrolled',
    `driver_id` BIGINT COMMENT 'Foreign key linking to the driver participating in the carbon initiative',
    `behavior_score_baseline` DECIMAL(18,2) COMMENT 'Drivers baseline eco-driving behavior score measured before participation in this initiative. Used to calculate improvement and initiative effectiveness. Scale typically 0-100.',
    `behavior_score_current` DECIMAL(18,2) COMMENT 'Drivers current eco-driving behavior score while participating in this initiative. Updated periodically based on telematics data. Scale typically 0-100.',
    `certification_date` DATE COMMENT 'Date when the driver achieved certification for this eco-driving or sustainability initiative. Null if not yet certified.',
    `certification_expiration_date` DATE COMMENT 'Date when the drivers certification for this initiative expires and requires renewal. Null if certification does not expire or driver is not certified.',
    `certification_status` STRING COMMENT 'Current certification status of the driver for this specific initiative: not_certified (no certification obtained), in_progress (working toward certification), certified (holds valid certification), expired (certification lapsed), revoked (certification removed).',
    `co2e_reduction_contribution_tons` DECIMAL(18,2) COMMENT 'Estimated metric tons of CO2 equivalent emissions reduced by this specific drivers participation in this initiative. Aggregated across all drivers to measure total initiative impact.',
    `enrollment_date` DATE COMMENT 'Date when the driver was enrolled in this specific carbon initiative or eco-driving program.',
    `fuel_efficiency_improvement_percent` DECIMAL(18,2) COMMENT 'Percentage improvement in fuel efficiency achieved by this driver through participation in this initiative, calculated as (current_mpg - baseline_mpg) / baseline_mpg * 100. Used for ROI calculation and driver performance tracking.',
    `idle_time_reduction_percent` DECIMAL(18,2) COMMENT 'Percentage reduction in vehicle idle time achieved by this driver through participation in idle reduction initiatives. Calculated from telematics data comparing baseline to current period.',
    `incentive_earned_amount` DECIMAL(18,2) COMMENT 'Total monetary incentive or bonus earned by this driver for achieving performance targets in this carbon initiative. Used for driver engagement and program ROI tracking.',
    `last_performance_review_date` DATE COMMENT 'Date when this drivers performance in this initiative was last reviewed by the program manager or sustainability team.',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next performance review of this drivers participation in this initiative.',
    `notes` STRING COMMENT 'Free-text notes about this drivers participation in this initiative, including special circumstances, accommodations, or performance observations.',
    `participation_status` STRING COMMENT 'Current status of the drivers participation in this initiative: enrolled (registered but not started), active (currently participating), completed (finished program), withdrawn (voluntarily left), suspended (temporarily inactive).',
    `training_completion_date` DATE COMMENT 'Date when the driver completed the required training for this carbon initiative. Null if training is not yet complete or not required.',
    CONSTRAINT pk_driver_initiative_participation PRIMARY KEY(`driver_initiative_participation_id`)
) COMMENT 'This association product represents the participation relationship between drivers and carbon reduction initiatives. It captures driver enrollment in eco-driving programs, idle reduction training, and other sustainability initiatives. Each record links one driver to one carbon initiative with training completion status, certification details, and performance metrics that exist only in the context of this participation.. Existence Justification: In waste management operations, drivers participate in multiple concurrent carbon reduction initiatives (idle reduction, eco-driving training, speed management, route efficiency programs), and each initiative enrolls hundreds of drivers across the fleet. The business actively manages these participations as operational records with training completion, certification status, performance metrics, and incentive tracking. This is not a derived correlation but an operational enrollment process managed by sustainability and fleet safety teams.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`fueling_station` (
    `fueling_station_id` BIGINT COMMENT 'Primary key for fueling_station',
    `facility_id` BIGINT COMMENT 'Reference to the parent facility or operational site where this fueling station is located.',
    `parent_fueling_station_id` BIGINT COMMENT 'Self-referencing FK on fueling_station (parent_fueling_station_id)',
    `address_line_1` STRING COMMENT 'Primary street address of the fueling station location.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or unit number.',
    `city` STRING COMMENT 'City where the fueling station is located.',
    `contact_email` STRING COMMENT 'Primary email address for fueling station communications and operational coordination.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the fueling station operations or management.',
    `contract_end_date` DATE COMMENT 'Expiration or termination date of the fueling station contract or service agreement.',
    `contract_number` STRING COMMENT 'Reference number for the contract or agreement governing the use of this fueling station.',
    `contract_start_date` DATE COMMENT 'Effective start date of the fueling station contract or service agreement.',
    `cost_per_gallon_cng` DECIMAL(18,2) COMMENT 'Current negotiated or market cost per gallon equivalent for CNG fuel at this station.',
    `cost_per_gallon_diesel` DECIMAL(18,2) COMMENT 'Current negotiated or market cost per gallon for diesel fuel at this station, used for fleet cost analysis.',
    `cost_per_kwh_electric` DECIMAL(18,2) COMMENT 'Current cost per kilowatt-hour for electric vehicle charging at this station.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the fueling station location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fueling station record was first created in the system.',
    `daily_throughput_capacity_gallons` DECIMAL(18,2) COMMENT 'Maximum daily fuel dispensing capacity in gallons, used for fleet scheduling and station utilization analysis.',
    `decommissioned_date` DATE COMMENT 'Date when the fueling station was permanently taken out of service, if applicable.',
    `environmental_certification` STRING COMMENT 'Environmental certifications or compliance standards met by the fueling station (e.g., EPA Tier 3, CARB, LEED).',
    `fuel_types_available` STRING COMMENT 'Comma-separated list of fuel types available at this station (e.g., diesel, CNG, RNG, gasoline, electric). [ENUM-REF-CANDIDATE: diesel|cng|rng|gasoline|electric|biodiesel|lng|hydrogen — promote to reference product]',
    `hazmat_permit_number` STRING COMMENT 'Permit number for handling and storing hazardous materials at the fueling station, required for compliance.',
    `is_24_hour_access` BOOLEAN COMMENT 'Indicates whether the fueling station provides round-the-clock access for fleet vehicles.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fueling station record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the fueling station for GPS routing and telematics integration.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the fueling station for GPS routing and telematics integration.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required safety or regulatory inspection of the fueling station.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special instructions, or station-specific information.',
    `number_of_cng_dispensers` STRING COMMENT 'Count of CNG-specific dispensers at the station, critical for CNG fleet capacity planning.',
    `number_of_electric_chargers` STRING COMMENT 'Count of electric vehicle charging stations available for electric fleet vehicles.',
    `number_of_pumps` STRING COMMENT 'Total count of fueling pumps or dispensers available at the station.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the fueling station (e.g., 24/7, Mon-Fri 6am-10pm), used for fleet scheduling.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the fueling station indicating its availability for fleet operations.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the fueling station address.',
    `primary_fuel_type` STRING COMMENT 'The predominant fuel type dispensed at this station, used for fleet routing and capacity planning.',
    `region_code` STRING COMMENT 'Business region or district code for organizational reporting and fleet management hierarchy.',
    `safety_inspection_date` DATE COMMENT 'Date of the most recent safety inspection for the fueling station, required for regulatory compliance.',
    `state_province` STRING COMMENT 'Two-letter state or province code for the fueling station location.',
    `station_code` STRING COMMENT 'Externally-known unique business identifier for the fueling station, used for operational reference and reporting.',
    `station_name` STRING COMMENT 'Human-readable name of the fueling station for identification and display purposes.',
    `station_type` STRING COMMENT 'Classification of the fueling station based on ownership and access model.',
    `storage_capacity_gallons` DECIMAL(18,2) COMMENT 'Total fuel storage capacity at the station measured in gallons, used for inventory and supply chain planning.',
    `vendor_name` STRING COMMENT 'Name of the third-party vendor or operator managing the fueling station, if applicable.',
    CONSTRAINT pk_fueling_station PRIMARY KEY(`fueling_station_id`)
) COMMENT 'Master reference table for fueling_station. Referenced by fueling_station_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`geofence_zone` (
    `geofence_zone_id` BIGINT COMMENT 'Primary key for geofence_zone',
    `facility_id` BIGINT COMMENT 'Reference to the facility associated with this geofence zone (e.g., landfill, transfer station, depot).',
    `service_area_id` BIGINT COMMENT 'Reference to the service area that this geofence zone belongs to or supports.',
    `parent_geofence_zone_id` BIGINT COMMENT 'Self-referencing FK on geofence_zone (parent_geofence_zone_id)',
    `address_line_1` STRING COMMENT 'Primary street address or location descriptor for the geofence zone (organizational contact data).',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or unit number for the geofence zone (organizational contact data).',
    `alert_on_entry` BOOLEAN COMMENT 'Indicates whether an alert should be triggered when a vehicle enters this geofence zone.',
    `alert_on_exit` BOOLEAN COMMENT 'Indicates whether an alert should be triggered when a vehicle exits this geofence zone.',
    `allowed_vehicle_types` STRING COMMENT 'Comma-separated list or description of vehicle types permitted to operate within this geofence zone (e.g., ASL, FEL, REL, roll-off, CNG, RNG).',
    `area_square_meters` DECIMAL(18,2) COMMENT 'Total area covered by the geofence zone in square meters, calculated from the defined geometry.',
    `boundary_coordinates` STRING COMMENT 'Serialized representation of the geofence boundary coordinates (e.g., WKT, GeoJSON string) defining the polygon or custom shape.',
    `center_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the geofence zone center point in decimal degrees (WGS84).',
    `center_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the geofence zone center point in decimal degrees (WGS84).',
    `city` STRING COMMENT 'City or municipality where the geofence zone is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the geofence zone is located (e.g., USA, CAN, MEX).',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this geofence zone record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this geofence zone record was first created in the system.',
    `dot_compliance_required` BOOLEAN COMMENT 'Indicates whether operations within this geofence zone are subject to DOT/FMCSA compliance monitoring and reporting.',
    `effective_end_date` DATE COMMENT 'Date when this geofence zone is deactivated or retired. Null for zones with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this geofence zone becomes active and begins being monitored by telematics systems.',
    `external_zone_code` STRING COMMENT 'Identifier for this geofence zone in the external telematics or fleet management system (e.g., Geotab zone ID).',
    `geometry_type` STRING COMMENT 'The geometric shape type used to define the geofence zone boundaries (e.g., circle, polygon, rectangle, custom).',
    `hazmat_zone` BOOLEAN COMMENT 'Indicates whether this geofence zone is designated for hazardous waste handling and requires special compliance monitoring.',
    `idle_time_threshold_minutes` STRING COMMENT 'Maximum allowed idle time in minutes for vehicles within this geofence zone before triggering an alert or compliance violation.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this geofence zone record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this geofence zone record was last modified or updated.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or operational instructions related to this geofence zone.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the geofence zone location (organizational contact data).',
    `priority_level` STRING COMMENT 'Priority classification for monitoring and alerting when vehicles enter or exit this geofence zone.',
    `radius_meters` DECIMAL(18,2) COMMENT 'Radius of the geofence zone in meters, applicable when geometry_type is circle. Null for non-circular zones.',
    `requires_cdl` BOOLEAN COMMENT 'Indicates whether drivers operating within this geofence zone must hold a valid Commercial Driver License (CDL).',
    `restricted_hours` STRING COMMENT 'Time ranges during which access to or operations within the geofence zone are restricted (e.g., 22:00-06:00 for noise ordinances).',
    `speed_limit_mph` STRING COMMENT 'Maximum allowed speed in miles per hour for vehicles operating within this geofence zone. Used for compliance monitoring.',
    `state_province` STRING COMMENT 'State, province, or region where the geofence zone is located.',
    `telematics_provider` STRING COMMENT 'Name of the telematics system provider that monitors this geofence zone (e.g., Geotab Fleet Telematics).',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the geofence zone (e.g., America/New_York, America/Chicago) used for timestamp interpretation.',
    `zone_code` STRING COMMENT 'Externally-known unique code or identifier for the geofence zone used in operational systems and reporting.',
    `zone_description` STRING COMMENT 'Detailed textual description of the geofence zone, including its purpose, boundaries, and operational context.',
    `zone_name` STRING COMMENT 'Human-readable name or label for the geofence zone (e.g., Downtown Collection District, Landfill Perimeter, Customer Service Area 5).',
    `zone_status` STRING COMMENT 'Current lifecycle status of the geofence zone indicating whether it is actively monitored and enforced.',
    `zone_type` STRING COMMENT 'Classification of the geofence zone based on its operational purpose (e.g., service area, facility perimeter, restricted zone, customer site, depot, transfer station).',
    CONSTRAINT pk_geofence_zone PRIMARY KEY(`geofence_zone_id`)
) COMMENT 'Master reference table for geofence_zone. Referenced by geofence_zone_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ADD CONSTRAINT `fk_fleet_vehicle_registration_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_pre_post_trip_inspection_id` FOREIGN KEY (`pre_post_trip_inspection_id`) REFERENCES `waste_management_ecm`.`fleet`.`pre_post_trip_inspection`(`pre_post_trip_inspection_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_geofence_zone_id` FOREIGN KEY (`geofence_zone_id`) REFERENCES `waste_management_ecm`.`fleet`.`geofence_zone`(`geofence_zone_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_fueling_station_id` FOREIGN KEY (`fueling_station_id`) REFERENCES `waste_management_ecm`.`fleet`.`fueling_station`(`fueling_station_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ADD CONSTRAINT `fk_fleet_fleet_dot_inspection_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ADD CONSTRAINT `fk_fleet_fleet_dot_inspection_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ADD CONSTRAINT `fk_fleet_driver_behavior_event_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ADD CONSTRAINT `fk_fleet_driver_behavior_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ADD CONSTRAINT `fk_fleet_vehicle_utilization_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ADD CONSTRAINT `fk_fleet_vehicle_utilization_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ADD CONSTRAINT `fk_fleet_drug_alcohol_test_accident_report_id` FOREIGN KEY (`accident_report_id`) REFERENCES `waste_management_ecm`.`fleet`.`accident_report`(`accident_report_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ADD CONSTRAINT `fk_fleet_drug_alcohol_test_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ADD CONSTRAINT `fk_fleet_cost_allocation_original_allocation_cost_allocation_id` FOREIGN KEY (`original_allocation_cost_allocation_id`) REFERENCES `waste_management_ecm`.`fleet`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ADD CONSTRAINT `fk_fleet_cost_allocation_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ADD CONSTRAINT `fk_fleet_vehicle_lifecycle_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ADD CONSTRAINT `fk_fleet_vehicle_class_parent_vehicle_class_id` FOREIGN KEY (`parent_vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_superseded_maintenance_schedule_id` FOREIGN KEY (`superseded_maintenance_schedule_id`) REFERENCES `waste_management_ecm`.`fleet`.`maintenance_schedule`(`maintenance_schedule_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ADD CONSTRAINT `fk_fleet_fleet_insurance_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ADD CONSTRAINT `fk_fleet_fleet_insurance_renewed_fleet_insurance_id` FOREIGN KEY (`renewed_fleet_insurance_id`) REFERENCES `waste_management_ecm`.`fleet`.`fleet_insurance`(`fleet_insurance_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ADD CONSTRAINT `fk_fleet_driver_initiative_participation_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ADD CONSTRAINT `fk_fleet_fueling_station_parent_fueling_station_id` FOREIGN KEY (`parent_fueling_station_id`) REFERENCES `waste_management_ecm`.`fleet`.`fueling_station`(`fueling_station_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ADD CONSTRAINT `fk_fleet_geofence_zone_parent_geofence_zone_id` FOREIGN KEY (`parent_geofence_zone_id`) REFERENCES `waste_management_ecm`.`fleet`.`geofence_zone`(`geofence_zone_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`fleet` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `waste_management_ecm`.`fleet` SET TAGS ('dbx_domain' = 'fleet');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Operator Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `vehicle_class_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `axle_configuration` SET TAGS ('dbx_business_glossary_term' = 'Axle Configuration');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `body_capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Body Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `body_type` SET TAGS ('dbx_business_glossary_term' = 'Body Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `cdl_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `compaction_type` SET TAGS ('dbx_business_glossary_term' = 'Compaction Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `compaction_type` SET TAGS ('dbx_value_regex' = 'Packer|Compactor|Non-Compacting|N/A');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `current_engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Current Engine Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `current_odometer_miles` SET TAGS ('dbx_business_glossary_term' = 'Current Odometer (Miles)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `dot_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `emissions_certification` SET TAGS ('dbx_business_glossary_term' = 'Emissions Certification');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `engine_make` SET TAGS ('dbx_business_glossary_term' = 'Engine Make');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `engine_model` SET TAGS ('dbx_business_glossary_term' = 'Engine Model');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `engine_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Engine Serial Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `engine_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `fuel_tank_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Fuel Tank Capacity (Gallons)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'Diesel|CNG|RNG|Gasoline|Electric|Hybrid');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `gvwr` SET TAGS ('dbx_business_glossary_term' = 'Gross Vehicle Weight Rating (GVWR)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `home_yard_location` SET TAGS ('dbx_business_glossary_term' = 'Home Yard Location');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `hydraulic_system_type` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic System Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `license_plate` SET TAGS ('dbx_business_glossary_term' = 'License Plate Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `lift_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Lift Mechanism');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `make` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Make');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `next_pm_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Preventive Maintenance (PM) Due Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Active|Out of Service|Maintenance|Retired|Sold|Totaled');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'Owned|Leased|Rental');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `payload_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Payload Capacity (Pounds)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `registration_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Expiration Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_business_glossary_term' = 'Telematics Device Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `transmission_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `transmission_type` SET TAGS ('dbx_value_regex' = 'Manual|Automatic|Automated Manual');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `unit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `vin` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9]{17}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `vin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `vehicle_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Registration ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `annual_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `cab_card_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Cab Card Storage Location');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `dot_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `dot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|CNG|RNG|gasoline|electric|hybrid');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `gross_vehicle_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Vehicle Weight (GVW)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `ifta_decal_number` SET TAGS ('dbx_business_glossary_term' = 'International Fuel Tax Agreement (IFTA) Decal Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `ifta_decal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `ifta_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'International Fuel Tax Agreement (IFTA) Expiration Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `irp_apportioned_flag` SET TAGS ('dbx_business_glossary_term' = 'International Registration Plan (IRP) Apportioned Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `irp_base_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'International Registration Plan (IRP) Base Jurisdiction');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `irp_base_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `irp_fleet_number` SET TAGS ('dbx_business_glossary_term' = 'International Registration Plan (IRP) Fleet Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `irp_fleet_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,15}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `issuing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `lien_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Lien Holder Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `mc_number` SET TAGS ('dbx_business_glossary_term' = 'Motor Carrier (MC) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `mc_number` SET TAGS ('dbx_value_regex' = '^MC[0-9]{1,8}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registered_owner_address` SET TAGS ('dbx_business_glossary_term' = 'Registered Owner Address');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registered_owner_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registered_owner_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registered_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Registered Owner Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_class` SET TAGS ('dbx_business_glossary_term' = 'Registration Class');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_class` SET TAGS ('dbx_value_regex' = 'commercial|private|government|farm|exempt');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_document_url` SET TAGS ('dbx_business_glossary_term' = 'Registration Document URL');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Registration Fee Amount');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Registration Fee Currency');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|cancelled');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `title_number` SET TAGS ('dbx_business_glossary_term' = 'Title Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `title_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `ucr_registration_year` SET TAGS ('dbx_business_glossary_term' = 'Unified Carrier Registration (UCR) Registration Year');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `ucr_status` SET TAGS ('dbx_business_glossary_term' = 'Unified Carrier Registration (UCR) Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `ucr_status` SET TAGS ('dbx_value_regex' = 'current|expired|pending|not_required');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `vehicle_year` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Year');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ALTER COLUMN `vin` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9]{17}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `training_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Cdl Training Certification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'Home District Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `cdl_class` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Class');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `cdl_class` SET TAGS ('dbx_value_regex' = 'A|B|C|Non-CDL');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `cdl_endorsements` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Endorsements');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `cdl_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Expiration Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `cdl_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Issue Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `cdl_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `cdl_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `cdl_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `cdl_state` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) State of Issuance');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `dot_physical_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Physical Expiration Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `dot_physical_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Physical Issue Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `drug_alcohol_program_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Program Enrollment Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `drug_alcohol_program_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Program Enrollment Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `hazmat_clearance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Clearance Expiration Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `hazmat_endorsement_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Endorsement Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Driver Hire Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_alcohol_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Alcohol Test Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_alcohol_test_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_alcohol_test_result` SET TAGS ('dbx_business_glossary_term' = 'Last Alcohol Test Result');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_alcohol_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|pending');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_alcohol_test_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_drug_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drug Test Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_drug_test_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_drug_test_result` SET TAGS ('dbx_business_glossary_term' = 'Last Drug Test Result');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_drug_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|pending');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_drug_test_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `last_qualification_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualification Review Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `medical_examiner_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Examiner Certificate Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `medical_examiner_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `medical_examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Examiner Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `medical_examiner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `mvr_last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Motor Vehicle Record (MVR) Last Review Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `mvr_next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Motor Vehicle Record (MVR) Next Review Due Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `mvr_status` SET TAGS ('dbx_business_glossary_term' = 'Motor Vehicle Record (MVR) Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `mvr_status` SET TAGS ('dbx_value_regex' = 'clear|minor_violations|major_violations|suspended|revoked');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `next_qualification_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Qualification Review Due Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Driver Operational Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated|suspended');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `primary_route_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Route Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `primary_route_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|roll_off|transfer|hazmat|recycling');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Driver Qualification Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|disqualified|suspended|pending_review|expired');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `safety_score` SET TAGS ('dbx_business_glossary_term' = 'Driver Safety Score');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Driver Termination Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `total_miles_driven` SET TAGS ('dbx_business_glossary_term' = 'Total Miles Driven');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatcher Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `pre_post_trip_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Trip Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift End Time');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift Start Time');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'scheduled|active|completed|cancelled|no_show|reassigned');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'route|transfer|rolloff|maintenance|standby|emergency');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `cdl_verified` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Verified Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Defect Description');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `defects_reported` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Defects Reported Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `dispatch_location` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Location');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `engine_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Engine Hours at Assignment End');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `engine_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Engine Hours at Assignment Start');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `fuel_level_end_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Level at Assignment End (Percent)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `fuel_level_start_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Level at Assignment Start (Percent)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `hos_compliant` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Compliant Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `odometer_end` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading at Assignment End');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `odometer_start` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading at Assignment Start');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `post_trip_inspection_completed` SET TAGS ('dbx_business_glossary_term' = 'Post-Trip Inspection Completed Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `post_trip_inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Post-Trip Inspection Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `pre_trip_inspection_completed` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trip Inspection Completed Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `return_location` SET TAGS ('dbx_business_glossary_term' = 'Return Location');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `safety_incident_occurred` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Occurred Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `telematics_event_id` SET TAGS ('dbx_business_glossary_term' = 'Telematics Event ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `geofence_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Geofence Zone ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `altitude_feet` SET TAGS ('dbx_business_glossary_term' = 'Altitude Feet');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `battery_voltage` SET TAGS ('dbx_business_glossary_term' = 'Battery Voltage');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `coolant_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Coolant Temperature Fahrenheit');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `engine_load_percent` SET TAGS ('dbx_business_glossary_term' = 'Engine Load Percentage');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `engine_rpm` SET TAGS ('dbx_business_glossary_term' = 'Engine Revolutions Per Minute (RPM)');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `fuel_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Gallons');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `fuel_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Level Percentage');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Accuracy Meters');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `harsh_acceleration_flag` SET TAGS ('dbx_business_glossary_term' = 'Harsh Acceleration Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `harsh_braking_flag` SET TAGS ('dbx_business_glossary_term' = 'Harsh Braking Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `heading_degrees` SET TAGS ('dbx_business_glossary_term' = 'Heading Degrees');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `idle_duration_flag` SET TAGS ('dbx_business_glossary_term' = 'Idle Duration Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `idle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Idle Time Minutes');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `ignition_status` SET TAGS ('dbx_business_glossary_term' = 'Ignition Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `ignition_status` SET TAGS ('dbx_value_regex' = 'on|off');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `odometer_miles` SET TAGS ('dbx_business_glossary_term' = 'Odometer Miles');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `posted_speed_limit_mph` SET TAGS ('dbx_business_glossary_term' = 'Posted Speed Limit Miles Per Hour (MPH)');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `pto_status` SET TAGS ('dbx_business_glossary_term' = 'Power Take-Off (PTO) Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `pto_status` SET TAGS ('dbx_value_regex' = 'engaged|disengaged|unknown');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `satellite_count` SET TAGS ('dbx_business_glossary_term' = 'Satellite Count');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `seatbelt_status` SET TAGS ('dbx_business_glossary_term' = 'Seatbelt Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `seatbelt_status` SET TAGS ('dbx_value_regex' = 'fastened|unfastened|unknown');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `speeding_flag` SET TAGS ('dbx_business_glossary_term' = 'Speeding Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `vehicle_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Speed Miles Per Hour (MPH)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Transaction ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `air_emission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Air Emission Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_purchase_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Purchase Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fueling_station_id` SET TAGS ('dbx_business_glossary_term' = 'Fueling Station ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fueling Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `def_quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Diesel Exhaust Fluid (DEF) Quantity Dispensed');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Engine Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Card Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_value_regex' = 'regular|midgrade|premium|ulsd|b5|b20');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|cng|rng|gasoline|biodiesel|electric');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `ifta_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'International Fuel Tax Agreement (IFTA) Jurisdiction');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `ifta_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `is_emergency_fuel` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Fuel');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `pre_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Amount');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `pump_number` SET TAGS ('dbx_business_glossary_term' = 'Pump Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Station Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `station_type` SET TAGS ('dbx_value_regex' = 'company_yard|public_station|cng_station|private_contract');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transaction_source` SET TAGS ('dbx_business_glossary_term' = 'Transaction Source');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transaction_source` SET TAGS ('dbx_value_regex' = 'fleet_card|yard_pump|cng_station|manual_entry|telematics');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|reconciled|disputed');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|gge|liters|kwh');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `fleet_dot_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Department of Transportation (DOT) Inspection ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `basic_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Safety Accountability (CSA) Behavior Analysis and Safety Improvement Category (BASIC)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `carrier_dot_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Department of Transportation (DOT) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `carrier_dot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'Not Required|Pending|In Progress|Completed|Overdue|Verified');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `csa_score_impact` SET TAGS ('dbx_business_glossary_term' = 'Compliance Safety Accountability (CSA) Score Impact');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `driver_license_state` SET TAGS ('dbx_business_glossary_term' = 'Driver License State');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `driver_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `driver_license_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `driver_license_state` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `driver_oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Driver Out-of-Service Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_category` SET TAGS ('dbx_business_glossary_term' = 'Inspection Category');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_category` SET TAGS ('dbx_value_regex' = 'Roadside|Annual DOT|State Patrol|Terminal Audit|Compliance Review|Random');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_document_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Document Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration Minutes');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_report_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_report_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'Pass|Out-of-Service|Warning Issued|Violation Cited|Conditional Pass');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_state` SET TAGS ('dbx_business_glossary_term' = 'Inspection State');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Commercial Vehicle Safety Alliance (CVSA) Inspection Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'Level I|Level II|Level III|Level IV|Level V|Level VI');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspector_agency` SET TAGS ('dbx_business_glossary_term' = 'Inspector Agency');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspector_badge_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Badge Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspector_badge_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `oos_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Service Violation Count');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `out_of_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Service (OOS) Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `severity_weight` SET TAGS ('dbx_business_glossary_term' = 'Severity Weight');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `vehicle_odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Odometer Reading');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `vehicle_oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Out-of-Service Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `violation_codes` SET TAGS ('dbx_business_glossary_term' = 'Violation Codes');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_dot_inspection` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `pre_post_trip_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Pre-Post Trip Inspection ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Mechanic ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `transfer_trailer_id` SET TAGS ('dbx_business_glossary_term' = 'Trailer ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `body_frame_status` SET TAGS ('dbx_business_glossary_term' = 'Body and Frame Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `body_frame_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `brakes_status` SET TAGS ('dbx_business_glossary_term' = 'Brakes Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `brakes_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `cdl_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `cdl_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `cdl_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `coupling_devices_status` SET TAGS ('dbx_business_glossary_term' = 'Coupling Devices Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `coupling_devices_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `defect_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Defect Reported Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `driver_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Driver Signature Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `emergency_equipment_status` SET TAGS ('dbx_business_glossary_term' = 'Emergency Equipment Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `emergency_equipment_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `exhaust_system_status` SET TAGS ('dbx_business_glossary_term' = 'Exhaust System Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `exhaust_system_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `fuel_system_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel System Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `fuel_system_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `horn_status` SET TAGS ('dbx_business_glossary_term' = 'Horn Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `horn_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `inspection_source` SET TAGS ('dbx_business_glossary_term' = 'Inspection Source');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `inspection_source` SET TAGS ('dbx_value_regex' = 'mobile_app|paper_form|telematics');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'pre-trip|post-trip');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `lights_status` SET TAGS ('dbx_business_glossary_term' = 'Lights Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `lights_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `mechanic_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mechanic Acknowledgment Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `mirrors_status` SET TAGS ('dbx_business_glossary_term' = 'Mirrors Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `mirrors_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `out_of_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Service Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `steering_status` SET TAGS ('dbx_business_glossary_term' = 'Steering Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `steering_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `suspension_status` SET TAGS ('dbx_business_glossary_term' = 'Suspension Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `suspension_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `tires_status` SET TAGS ('dbx_business_glossary_term' = 'Tires Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `tires_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `trailer_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Unit Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `wipers_status` SET TAGS ('dbx_business_glossary_term' = 'Wipers Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `wipers_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `hos_log_id` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Log ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `break_compliance_flag` SET TAGS ('dbx_business_glossary_term' = '30-Minute Break Compliance Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|uncertified|rejected');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Certification Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `cumulative_driving_hours_8day` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Driving Hours (8-Day Window)');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `cumulative_on_duty_hours_8day` SET TAGS ('dbx_business_glossary_term' = 'Cumulative On-Duty Hours (8-Day Window)');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'eld_automatic|driver_manual|carrier_edit');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `duty_status` SET TAGS ('dbx_business_glossary_term' = 'Duty Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `duty_status` SET TAGS ('dbx_value_regex' = 'off_duty|sleeper_berth|driving|on_duty_not_driving');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `duty_status_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Duty Status End Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `duty_status_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Duty Status Start Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `edit_flag` SET TAGS ('dbx_business_glossary_term' = 'Edit Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `edit_reason` SET TAGS ('dbx_business_glossary_term' = 'Edit Reason');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `eld_device_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Logging Device (ELD) Device ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `eld_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `eld_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `eld_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Logging Device (ELD) Serial Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_latitude_end` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude End');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_latitude_end` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_latitude_end` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_latitude_start` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude Start');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_latitude_start` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_latitude_start` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_longitude_end` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude End');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_longitude_end` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_longitude_end` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_longitude_start` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude Start');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_longitude_start` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `gps_longitude_start` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `hos_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Violation Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `location_end` SET TAGS ('dbx_business_glossary_term' = 'End Location');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `location_start` SET TAGS ('dbx_business_glossary_term' = 'Start Location');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `log_date` SET TAGS ('dbx_business_glossary_term' = 'Log Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `odometer_end` SET TAGS ('dbx_business_glossary_term' = 'Odometer End Reading');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `odometer_start` SET TAGS ('dbx_business_glossary_term' = 'Odometer Start Reading');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `shipping_document_number` SET TAGS ('dbx_business_glossary_term' = 'Shipping Document Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `violation_type_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Type Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `violation_type_code` SET TAGS ('dbx_value_regex' = '11_hour_driving|14_hour_on_duty|30_min_break|60_70_hour_limit|none');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `accident_report_id` SET TAGS ('dbx_business_glossary_term' = 'Accident Report ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `accident_description` SET TAGS ('dbx_business_glossary_term' = 'Accident Description');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `citation_description` SET TAGS ('dbx_business_glossary_term' = 'Citation Description');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `citation_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Citation Issued Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `csa_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Safety Accountability (CSA) Reportable Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `dot_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Reportable Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `driver_at_fault_flag` SET TAGS ('dbx_business_glossary_term' = 'Driver At Fault Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `estimated_property_damage_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Property Damage Amount');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `incident_severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `incident_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|severe|catastrophic');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'collision|rollover|backing_incident|pedestrian|property_damage|single_vehicle');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `insurance_carrier` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `light_conditions` SET TAGS ('dbx_business_glossary_term' = 'Light Conditions');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `light_conditions` SET TAGS ('dbx_value_regex' = 'daylight|dawn|dusk|dark_lighted|dark_unlighted');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Location Address');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_state` SET TAGS ('dbx_business_glossary_term' = 'Location State');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_zip_code` SET TAGS ('dbx_business_glossary_term' = 'Location ZIP Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `number_of_fatalities` SET TAGS ('dbx_business_glossary_term' = 'Number of Fatalities');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `number_of_injuries` SET TAGS ('dbx_business_glossary_term' = 'Number of Injuries');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `police_department` SET TAGS ('dbx_business_glossary_term' = 'Police Department');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `police_report_number` SET TAGS ('dbx_business_glossary_term' = 'Police Report Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `post_accident_test_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Accident Drug and Alcohol Test Completed Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `post_accident_test_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Accident Drug and Alcohol Test Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `post_accident_test_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Accident Drug and Alcohol Test Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `post_accident_test_result` SET TAGS ('dbx_business_glossary_term' = 'Post-Accident Drug and Alcohol Test Result');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `post_accident_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|not_completed');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `post_accident_test_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `preventable_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventable Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `road_conditions` SET TAGS ('dbx_business_glossary_term' = 'Road Conditions');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `road_conditions` SET TAGS ('dbx_value_regex' = 'dry|wet|icy|snow_covered|muddy|other');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `vehicle_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Speed (MPH)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `driver_behavior_event_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Behavior Event Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed by User ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Unit ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `actual_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Actual Speed Miles Per Hour (MPH)');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `address_text` SET TAGS ('dbx_business_glossary_term' = 'Address Text');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `address_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `address_text` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `coaching_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Coaching Completed Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `coaching_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Coaching Completed Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `coaching_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Coaching Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `dot_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'DOT (Department of Transportation) Reportable Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `driver_score_impact` SET TAGS ('dbx_business_glossary_term' = 'Driver Score Impact');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Engine Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `event_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Event Duration Seconds');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `event_source_system` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `fuel_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Level Percent');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `g_force_value` SET TAGS ('dbx_business_glossary_term' = 'G-Force Value');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `idle_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Idle Duration Minutes');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `insurance_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `posted_speed_limit_mph` SET TAGS ('dbx_business_glossary_term' = 'Posted Speed Limit Miles Per Hour (MPH)');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `reviewed_by_supervisor_flag` SET TAGS ('dbx_business_glossary_term' = 'Reviewed by Supervisor Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `road_type` SET TAGS ('dbx_business_glossary_term' = 'Road Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `road_type` SET TAGS ('dbx_value_regex' = 'highway|arterial|residential|industrial|rural|parking_lot');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `speed_over_limit_mph` SET TAGS ('dbx_business_glossary_term' = 'Speed Over Limit Miles Per Hour (MPH)');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_business_glossary_term' = 'Telematics Device ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `vehicle_odometer_miles` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Odometer Miles');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_behavior_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `vehicle_utilization_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Utilization ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Depot ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `assigned_route_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Route Count');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `available_hours` SET TAGS ('dbx_business_glossary_term' = 'Available Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `deadhead_miles` SET TAGS ('dbx_business_glossary_term' = 'Deadhead Miles');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `dot_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Compliance Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `dot_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `driving_hours` SET TAGS ('dbx_business_glossary_term' = 'Driving Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `fuel_consumed_gallons` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed (Gallons)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `fuel_efficiency_mpg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency (Miles Per Gallon)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|CNG|RNG|gasoline|electric|hybrid');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `gps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Tracking Enabled');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `idle_hours` SET TAGS ('dbx_business_glossary_term' = 'Idle Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `lift_count` SET TAGS ('dbx_business_glossary_term' = 'Lift Count');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `maintenance_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Utilization Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `odometer_end` SET TAGS ('dbx_business_glossary_term' = 'Odometer End Reading');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `odometer_start` SET TAGS ('dbx_business_glossary_term' = 'Odometer Start Reading');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `payload_tons_collected` SET TAGS ('dbx_business_glossary_term' = 'Payload Tons Collected');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `pto_hours` SET TAGS ('dbx_business_glossary_term' = 'Power Take-Off (PTO) Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `revenue_miles` SET TAGS ('dbx_business_glossary_term' = 'Revenue Miles');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `route_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Route Completion Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `route_completion_status` SET TAGS ('dbx_value_regex' = 'completed|partial|cancelled|rescheduled');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `service_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Service Stop Count');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `telematics_data_quality` SET TAGS ('dbx_business_glossary_term' = 'Telematics Data Quality');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `telematics_data_quality` SET TAGS ('dbx_value_regex' = 'complete|partial|missing|error');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `total_engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Engine Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `total_miles_driven` SET TAGS ('dbx_business_glossary_term' = 'Total Miles Driven');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `utilization_date` SET TAGS ('dbx_business_glossary_term' = 'Utilization Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percentage');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_utilization` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_value_regex' = 'ASL|FEL|REL|roll_off|transfer|support');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `drug_alcohol_test_id` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Test ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `accident_report_id` SET TAGS ('dbx_business_glossary_term' = 'Accident ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Testing Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `training_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Training Certification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `accident_related` SET TAGS ('dbx_business_glossary_term' = 'Accident Related Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `alcohol_concentration` SET TAGS ('dbx_business_glossary_term' = 'Blood Alcohol Concentration (BAC)');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `clearinghouse_report_date` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Report Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'urine|breath|oral fluid|blood');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `collection_site_address` SET TAGS ('dbx_business_glossary_term' = 'Collection Site Address');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `collection_site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `collection_site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `collector_name` SET TAGS ('dbx_business_glossary_term' = 'Collector Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `confirmation_test_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Test Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `confirmation_test_performed` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Test Performed Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `driver_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Driver Notification Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `fmcsa_reported` SET TAGS ('dbx_business_glossary_term' = 'Federal Motor Carrier Safety Administration (FMCSA) Reported Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `follow_up_test_count_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Test Count Required');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `follow_up_testing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Testing End Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `follow_up_testing_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Testing Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `laboratory_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `mro_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Officer (MRO) Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `mro_phone` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Officer (MRO) Phone Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `mro_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `mro_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `positive_substance_identified` SET TAGS ('dbx_business_glossary_term' = 'Positive Substance Identified');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `positive_substance_identified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `positive_substance_identified` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `reasonable_suspicion_documented` SET TAGS ('dbx_business_glossary_term' = 'Reasonable Suspicion Documented Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `record_retention_date` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `return_to_duty_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Duty Clearance Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `sap_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Professional (SAP) Evaluation Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `sap_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Professional (SAP) Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `sap_referral_required` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Professional (SAP) Referral Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `specimen_number` SET TAGS ('dbx_business_glossary_term' = 'Specimen ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `specimen_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `specimen_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `substance_tested` SET TAGS ('dbx_business_glossary_term' = 'Substance Tested');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `substance_tested` SET TAGS ('dbx_value_regex' = 'drug panel|alcohol|both');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|cancelled|refused|pending review');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `test_time` SET TAGS ('dbx_business_glossary_term' = 'Test Time');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'pre-employment|random|post-accident|reasonable suspicion|return-to-duty|follow-up');
ALTER TABLE `waste_management_ecm`.`fleet`.`drug_alcohol_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `original_allocation_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Original Allocation ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_basis_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Quantity');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_basis_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Unit');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_basis_unit` SET TAGS ('dbx_value_regex' = 'miles|kilometers|hours|tons|trips|percentage');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'actual|standard_rate|mileage_based|hours_based|tonnage_based|equal_distribution');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period End Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Start Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_rate` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rate');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|cancelled');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `district_code` SET TAGS ('dbx_business_glossary_term' = 'District Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `fuel_consumed_gallons` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed (Gallons)');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|cng|rng|gasoline|electric|hybrid');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `mileage_driven` SET TAGS ('dbx_business_glossary_term' = 'Mileage Driven');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `sap_cost_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Document Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `sap_posting_date` SET TAGS ('dbx_business_glossary_term' = 'SAP Posting Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `service_line` SET TAGS ('dbx_value_regex' = 'residential|commercial|roll_off|recycling|hazmat|transfer');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `tonnage_hauled` SET TAGS ('dbx_business_glossary_term' = 'Tonnage Hauled (Tons Per Day - TPD)');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `trips_completed` SET TAGS ('dbx_business_glossary_term' = 'Trips Completed');
ALTER TABLE `waste_management_ecm`.`fleet`.`cost_allocation` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `vehicle_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Lifecycle Event ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Manager ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `tertiary_vehicle_transfer_to_district_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer To District ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Yard Location ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `accident_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Accident Claim Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `accident_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `actual_return_to_service_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return-to-Service Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|scrapped|donated|traded|totaled|recycled');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `disposal_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Vendor Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Engine Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `estimated_return_to_service_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Return-to-Service Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `odometer_reading_miles` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading (Miles)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `oos_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Service (OOS) Reason Category');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `oos_reason_detail` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Service (OOS) Reason Detail');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `replacement_vehicle_assigned_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Vehicle Assigned Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `transaction_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Transaction Value (USD)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `transaction_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_lifecycle_event` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `vehicle_class_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `emission_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Manager Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `parent_vehicle_class_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `annual_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Annual DOT Inspection Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `average_acquisition_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Acquisition Cost (United States Dollars)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `average_acquisition_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `average_annual_operating_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Annual Operating Cost (United States Dollars)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `average_annual_operating_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `average_stops_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Average Stops Per Shift');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `average_tons_per_day` SET TAGS ('dbx_business_glossary_term' = 'Average Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `axle_configuration` SET TAGS ('dbx_business_glossary_term' = 'Axle Configuration');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `axle_configuration` SET TAGS ('dbx_value_regex' = '^[0-9]{1}x[0-9]{1}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `backup_camera_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Camera Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `body_capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Body Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `body_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Typical Body Manufacturer');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `body_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Body Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `cdl_class_required` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Class Required');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `cdl_class_required` SET TAGS ('dbx_value_regex' = 'A|B|C|none');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `cdl_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `compaction_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compaction Ratio');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `compaction_type` SET TAGS ('dbx_business_glossary_term' = 'Compaction Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `compaction_type` SET TAGS ('dbx_value_regex' = 'packer|compactor|non_compacting|stationary');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Standard Crew Size');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `dot_vehicle_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Vehicle Class');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `dot_vehicle_class` SET TAGS ('dbx_value_regex' = '^[1-8]$');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_business_glossary_term' = 'Emissions Certification Standard');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `endorsements_required` SET TAGS ('dbx_business_glossary_term' = 'CDL Endorsements Required');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `expected_useful_life_miles` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life in Miles');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life in Years');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `fuel_tank_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Fuel Tank Capacity (Gallons)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|CNG|RNG|electric|hybrid|gasoline');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `gvwr_lbs` SET TAGS ('dbx_business_glossary_term' = 'Gross Vehicle Weight Rating (GVWR) in Pounds');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `hydraulic_system_type` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic System Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `hydraulic_system_type` SET TAGS ('dbx_value_regex' = 'single_stage|two_stage|none');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `lift_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Lift Mechanism Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `manufacturer_make` SET TAGS ('dbx_business_glossary_term' = 'Typical Manufacturer Make');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `payload_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Payload Capacity (Pounds)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `pm_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Interval in Days');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `pm_interval_miles` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Interval in Miles');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `pto_equipped_flag` SET TAGS ('dbx_business_glossary_term' = 'Power Take-Off (PTO) Equipped Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `service_line` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|recycling|hazardous|landfill');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `telematics_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Telematics Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `typical_route_type` SET TAGS ('dbx_business_glossary_term' = 'Typical Route Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `typical_route_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|transfer|landfill|mixed');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `vehicle_category` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Category');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `vehicle_category` SET TAGS ('dbx_value_regex' = 'collection|transfer|roll-off|support|administrative');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `vehicle_class_status` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `vehicle_class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|planned');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `maintenance_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Facility ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Mechanic ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `service_checklist_template_id` SET TAGS ('dbx_business_glossary_term' = 'Service Checklist Template ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `superseded_maintenance_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `calendar_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calendar Interval Days');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `completion_engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Completion Engine Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `completion_odometer_miles` SET TAGS ('dbx_business_glossary_term' = 'Completion Odometer Miles');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `defects_description` SET TAGS ('dbx_business_glossary_term' = 'Defects Description');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `defects_found_flag` SET TAGS ('dbx_business_glossary_term' = 'Defects Found Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `dot_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Inspection Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `emissions_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Emissions Inspection Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `engine_hours_interval` SET TAGS ('dbx_business_glossary_term' = 'Engine Hours Interval');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `estimated_parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Parts Cost');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `fmcsa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Motor Carrier Safety Administration (FMCSA) Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `last_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `last_completed_engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Engine Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `last_completed_odometer_miles` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Odometer Miles');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `mileage_interval` SET TAGS ('dbx_business_glossary_term' = 'Mileage Interval');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `next_due_engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Next Due Engine Hours');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `next_due_odometer_miles` SET TAGS ('dbx_business_glossary_term' = 'Next Due Odometer Miles');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `out_of_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Service (OOS) Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `pm_type` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `pm_type` SET TAGS ('dbx_value_regex' = 'a_service|b_service|c_service|annual_inspection|dot_inspection|emissions_inspection');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'scheduled|due|overdue|in_progress|completed|cancelled');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Trigger Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'mileage|engine_hours|calendar|combined');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `fleet_insurance_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Insurance ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `renewed_fleet_insurance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `additional_insured_parties` SET TAGS ('dbx_business_glossary_term' = 'Additional Insured Parties');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Email Address');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Cancellation Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Policy Cancellation Reason');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `cargo_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Cargo Coverage Limit');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `certificate_of_insurance_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `claims_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Claims Phone Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `claims_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `claims_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `coverage_territory` SET TAGS ('dbx_business_glossary_term' = 'Coverage Territory');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Deductible Amount');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `dot_filing_type` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Filing Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `dot_filing_type` SET TAGS ('dbx_value_regex' = 'bmcr_91|mcs_90|bmcr_91x|not_required');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `dot_minimum_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Minimum Compliance Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `excluded_drivers` SET TAGS ('dbx_business_glossary_term' = 'Excluded Drivers');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `liability_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Liability Coverage Limit');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `loss_payee_name` SET TAGS ('dbx_business_glossary_term' = 'Loss Payee Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `named_insured` SET TAGS ('dbx_business_glossary_term' = 'Named Insured Party');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `physical_damage_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Physical Damage Coverage Limit');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `policy_document_url` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `policy_endorsements` SET TAGS ('dbx_business_glossary_term' = 'Policy Endorsements');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|cancelled|suspended|lapsed');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'liability|physical_damage|comprehensive|collision|cargo|uninsured_motorist');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium Amount');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `radius_of_operation` SET TAGS ('dbx_business_glossary_term' = 'Radius of Operation');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `radius_of_operation` SET TAGS ('dbx_value_regex' = 'local|intermediate|long_haul|unrestricted');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `uninsured_motorist_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Uninsured Motorist Coverage Limit');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `vehicle_use_classification` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Use Classification');
ALTER TABLE `waste_management_ecm`.`fleet`.`fleet_insurance` ALTER COLUMN `vehicle_use_classification` SET TAGS ('dbx_value_regex' = 'commercial|service|business|personal');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` SET TAGS ('dbx_subdomain' = 'operational_performance');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` SET TAGS ('dbx_association_edges' = 'fleet.driver,sustainability.carbon_initiative');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `driver_initiative_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Initiative Participation ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Initiative Participation - Carbon Initiative Id');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Initiative Participation - Driver Id');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `behavior_score_baseline` SET TAGS ('dbx_business_glossary_term' = 'Behavior Score Baseline');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `behavior_score_current` SET TAGS ('dbx_business_glossary_term' = 'Behavior Score Current');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `co2e_reduction_contribution_tons` SET TAGS ('dbx_business_glossary_term' = 'CO2e Reduction Contribution Tons');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `fuel_efficiency_improvement_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency Improvement Percent');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `idle_time_reduction_percent` SET TAGS ('dbx_business_glossary_term' = 'Idle Time Reduction Percent');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `incentive_earned_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Earned Amount');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Participation Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver_initiative_participation` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `fueling_station_id` SET TAGS ('dbx_business_glossary_term' = 'Fueling Station Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `parent_fueling_station_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `cost_per_gallon_cng` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `cost_per_gallon_diesel` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `cost_per_kwh_electric` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`fueling_station` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `geofence_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Geofence Zone Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `parent_geofence_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`geofence_zone` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
