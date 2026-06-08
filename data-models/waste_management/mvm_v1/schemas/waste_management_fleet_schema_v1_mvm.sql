-- Schema for Domain: fleet | Business: Waste Management | Version: v1_mvm
-- Generated on: 2026-05-07 22:44:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`fleet` COMMENT 'Management of all mobile assets including collection trucks (ASL, FEL, REL), transfer vehicles, roll-off trucks, CNG/RNG-fueled units, and support vehicles. Tracks vehicle inventory, specifications, fuel types (diesel, CNG, RNG), telematics data (GPS, fuel consumption, idle time), driver behavior, DOT compliance, CDL driver assignments, vehicle registration, and utilization metrics. Integrates with Geotab Fleet Telematics and Infor EAM. Supports DOT/FMCSA regulatory compliance and fleet KPI reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'Unique identifier for the vehicle. Primary key for the vehicle master record.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Vehicles are assigned to service areas for operational planning, territory coverage, franchise compliance, and vehicle deployment optimization. Essential for territory-based fleet management and regul',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Dedicated fleet model: vehicles assigned exclusively to specific customer contracts for guaranteed service capacity. Critical for contract compliance tracking, cost allocation, and SLA performance mea',
    `district_id` BIGINT COMMENT 'Identifier of the operational district to which this vehicle is assigned.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Every vehicle is a capitalized fixed asset requiring depreciation tracking, book value reporting, and financial statement presentation. This link is fundamental to asset accounting and enables total c',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.franchise_agreement. Business justification: Franchise agreements specify fleet_composition_requirements (vehicle types, emissions standards, body types). Linking vehicle to franchise_agreement enables municipal compliance reporting on fleet com',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: Vehicles designated for specific inter-facility hauling contracts, tracking which trucks are authorized/qualified for contracted hauling lanes. Essential for hauling agreement compliance, insurance ve',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Fleet dispatch and route planning assign vehicles a primary disposal site. Tipping fee billing, permitted waste stream compliance, and daily route optimization all depend on knowing which landfill a v',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Vehicles are domiciled at a specific yard/facility for dispatch, maintenance cost center allocation, and regulatory compliance reporting. Fleet managers and finance teams require vehicle-to-facility a',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Waste collection vehicles require operating permits for air emissions, hazmat transport, and noise ordinances. Regulatory compliance officers track permit status per vehicle for DOT/EPA audits. Natura',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.line. Business justification: Vehicles are physically configured and permitted for specific service lines (residential, commercial, roll-off, hazmat). Fleet dispatch, capacity planning, and regulatory compliance reports require kn',
    `transporter_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.transporter_registration. Business justification: RCRA/DOT compliance requires each hazmat vehicle to operate under a registered transporters EPA/DOT authority. This FK enables dispatch eligibility checks — confirming the vehicle is authorized under',
    `vehicle_class_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_class. Business justification: Vehicle references its classification for standardized specifications, PM intervals, cost benchmarks, and operational parameters. The vehicle table currently has a vehicle_class STRING attribute that ',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Individual vehicles carry certifications, permits, and equipment configurations tied to specific waste streams (e.g., hazmat-certified tanker, organics collection truck). Regulatory compliance, insura',
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
    `district_id` BIGINT COMMENT 'Reference to the primary operational district where the driver is based. Used for route assignment and workforce planning.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Drivers are assigned to a home yard/facility for dispatch scheduling, payroll cost center allocation, and DOT compliance reporting. Environmental services operations require knowing which facility a d',
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
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Vehicle assignments are dispatched from a specific yard/facility. Linking to asset.facility enables facility-level dispatch reporting, shift cost allocation by yard, and operational capacity planning.',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Vehicle assignments for disposal runs (hauling waste to landfill/transfer station) must reference the disposal agreement for tipping fee reconciliation, contracted tonnage tracking against maximum/min',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Each shift assignment targets a specific landfill for waste disposal. Dispatch, tipping fee accrual, permitted daily tonnage tracking, and end-of-shift reconciliation all require knowing which landfil',
    `driver_id` BIGINT COMMENT 'Identifier of the driver assigned to operate the vehicle during this shift. References the driver master record.',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.franchise_agreement. Business justification: Vehicle assignments in franchise territories must reference the governing franchise agreement for municipal compliance reporting — service delivery counts, diversion rate tracking, and fleet compositi',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: A vehicle assignment executing a hauling run must reference the governing hauling agreement for BOL compliance, rate billing reconciliation, and DOT safety requirement verification. A vehicles defaul',
    `mrf_facility_id` BIGINT COMMENT 'Foreign key linking to recycling.mrf_facility. Business justification: Dispatch planning and MRF gate scheduling require knowing which MRF facility a vehicle assignment is destined for. Enables facility-level throughput management, gate arrival coordination, and vehicle ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: A vehicle assignment executes a specific service offering (e.g., residential recycling, commercial MSW, hazmat collection). Operations, billing reconciliation, SLA compliance tracking, and diversion r',
    `program_id` BIGINT COMMENT 'Foreign key linking to recycling.recycling_program. Business justification: Vehicle assignments for recycling collection are tied to specific recycling programs (curbside, commercial single-stream, etc.). Required for program-level collection performance reporting, SLA compli',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: Vehicle assignments correspond to specific route execution instances. Linking vehicle_assignment to route_execution enables direct tracing of vehicle utilization, fuel consumption, and safety incident',
    `route_id` BIGINT COMMENT 'Identifier of the collection route or run assigned to this driver-vehicle combination for the shift. May be null for non-route assignments such as maintenance runs or standby.',
    `service_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_service_commitment. Business justification: Each vehicle assignment executes a specific contracted service commitment. This link enables SLA compliance tracking, service delivery confirmation against contracted frequency, and billing verificati',
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
    `failure_mode_id` BIGINT COMMENT 'Foreign key linking to maintenance.failure_mode. Business justification: Telematics OBD fault codes and engine alerts map directly to maintenance failure modes for predictive maintenance triggering. Linking telematics_event to failure_mode enables automated work order gene',
    `mrf_facility_id` BIGINT COMMENT 'Foreign key linking to recycling.mrf_facility. Business justification: Geofence-based MRF arrival/departure detection uses telematics events to calculate facility dwell time, queue wait times, and gate throughput KPIs. Environmental services operations universally use th',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: Telematics events (speeding, harsh braking, idle time) must be attributed to specific route executions for per-run KPI reporting, driver scorecards, and fuel efficiency analysis. route_id alone is ins',
    `route_id` BIGINT COMMENT 'Identifier of the planned collection route the vehicle was assigned to at the time of the event.',
    `vehicle_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_assignment. Business justification: Telematics events (GPS pings, harsh braking, speeding flags, idle time) are generated during active vehicle assignments/shifts. One vehicle_assignment produces thousands of telematics_event records. L',
    `vehicle_id` BIGINT COMMENT 'Identifier of the fleet vehicle that generated this telematics event.',
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
    `driver_id` BIGINT COMMENT 'Identifier of the driver who performed the fueling transaction. Links to driver master record.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Fuel transactions at company-owned yards must be linked to the dispensing facility for underground storage tank (UST) compliance reporting, EPA environmental tracking, facility-level fuel cost allocat',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: Fuel cost allocation per route execution is a core operational finance process. Linking fuel_transaction to route_execution enables cost-per-run reporting, contract billing reconciliation, and GHG emi',
    `route_id` BIGINT COMMENT 'Identifier of the collection route the vehicle was assigned to at the time of fueling. Links fuel consumption to operational route performance.',
    `vehicle_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_assignment. Business justification: Fuel transactions occur during specific vehicle assignments/shifts. Linking fuel_transaction to vehicle_assignment enables per-shift fuel cost analysis, driver fuel efficiency tracking, and reconcilia',
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

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`dot_inspection` (
    `dot_inspection_id` BIGINT COMMENT 'Unique identifier for the DOT inspection record. Primary key.',
    `driver_id` BIGINT COMMENT 'Reference to the driver who was operating the vehicle at the time of inspection.',
    `failure_mode_id` BIGINT COMMENT 'Foreign key linking to maintenance.failure_mode. Business justification: DOT roadside inspection violations map to specific failure modes for CSA score management and corrective action planning. Linking fleet_dot_inspection to failure_mode enables violation pattern analysi',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: DOT inspections assess asset condition and may trigger impairment or retirement decisions. Results must be recorded in the asset condition history for regulatory compliance, valuation support, and aud',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.franchise_agreement. Business justification: Franchise agreements specify fleet inspection requirements and municipalities require DOT inspection compliance reporting. Linking fleet_dot_inspection to franchise_agreement enables regulatory compli',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: DOT inspections on vehicles performing hauling runs directly affect the hauling agreements safety_rating and may trigger performance_penalty_clause provisions. Linking enables contract-level DOT comp',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: DOT roadside inspections of hazmat loads must reference the manifest being transported for compliance verification per 49 CFR 177.817. Critical for documenting placarding violations, shipping paper ac',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: DOT roadside inspections are conducted under specific FMCSA regulations (49 CFR Part 396). Fleet safety managers use this link for CSA score analysis by regulation and to identify which regulatory req',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: Roadside DOT inspections occur during active route executions. Linking fleet_dot_inspection to route_execution enables compliance reporting that ties inspection outcomes and out-of-service events to s',
    `vehicle_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_assignment. Business justification: DOT roadside inspections occur while a vehicle is on an active assignment. Linking fleet_dot_inspection to vehicle_assignment provides the operational context (route, shift, driver assignment) under w',
    `vehicle_id` BIGINT COMMENT 'Reference to the fleet vehicle that was inspected.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: DOT roadside inspections that result in out-of-service orders or citations generate formal violation notices. Safety directors link inspection reports to notices for penalty tracking and corrective ac',
    `waste_shipment_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_shipment. Business justification: DOT roadside inspections of hazmat vehicles during active transport must be linked to the specific waste shipment for FMCSA/EPA compliance records and CSA scoring. manifest_id alone lacks shipment ope',
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
    CONSTRAINT pk_dot_inspection PRIMARY KEY(`dot_inspection_id`)
) COMMENT 'Records of DOT roadside inspections and annual vehicle inspections (CVSA — Commercial Vehicle Safety Alliance) for fleet units. Captures inspection date, inspection type (Level I–VI CVSA, Annual DOT, State Patrol), inspection location, inspector name and badge number, inspection result (pass, out-of-service, warning), number of violations cited, violation codes (FMCSA OOS criteria), corrective action required flag, corrective action completion date, and inspection report number. Critical for FMCSA compliance tracking and CSA (Compliance Safety Accountability) score management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` (
    `pre_post_trip_inspection_id` BIGINT COMMENT 'Unique identifier for the pre-trip or post-trip vehicle inspection record.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver who performed the inspection.',
    `failure_mode_id` BIGINT COMMENT 'Foreign key linking to maintenance.failure_mode. Business justification: Pre/post-trip inspection defects must be classified against standard failure modes for trend analysis and recurrence tracking. Linking inspection defects to failure_mode enables FMEA-driven maintenanc',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Pre/post-trip inspections are conducted at the home yard facility before and after each shift. Linking to the facility enables facility-level FMCSA compliance reporting, safety audit aggregation by ya',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: Pre/post-trip inspections are performed at the start and end of each route execution. Linking pre_post_trip_inspection to route_execution enables DOT compliance verification per run, defect-to-executi',
    `route_id` BIGINT COMMENT 'Identifier of the collection route associated with this inspection, linking the inspection to the planned or completed route.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle (collection truck, transfer vehicle, roll-off truck, or support vehicle) that was inspected.',
    `waste_shipment_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_shipment. Business justification: 49 CFR Part 392 requires documented pre-trip inspection before hazmat transport. This FK creates the regulatory audit trail linking the inspection record to the specific waste shipment it preceded, en',
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
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: HOS logs are generated during route executions. DOT compliance audits cross-reference driving hours against specific route runs to verify legal compliance. Linking hos_log to route_execution enables a',
    `vehicle_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_assignment. Business justification: An HOS log entry records duty status changes that occur within the context of a specific driver-vehicle shift (vehicle_assignment). One vehicle_assignment generates many HOS log entries (e.g., on-duty',
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
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Accidents occurring within a franchise service area must be reported to the municipal franchise holder per franchise agreement terms. Franchise compliance reporting, insurance liability allocation, an',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Accidents occurring while servicing specific customer contracts must be tracked for liability determination, insurance claims, customer notification requirements, and contract performance impact analy',
    `driver_id` BIGINT COMMENT 'Identifier of the driver operating the vehicle at the time of the accident. Links to driver master record.',
    `ehs_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.ehs_incident. Business justification: Vehicle accidents trigger mandatory EHS incident records for OSHA recordability determination and regulatory reporting. Linking accident_report to the resulting ehs_incident supports post-accident inv',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Accidents with material property damage trigger asset impairment testing per IAS 36, insurance claim processing against the fixed asset record, and condition reassessment. This link enables finance to',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.franchise_agreement. Business justification: Accidents involving vehicles operating in franchise territories must be reported to municipalities per franchise agreement terms. This link enables franchise compliance reporting, performance bond cla',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: Accidents during hauling runs affect the hauling agreements safety_rating and may trigger performance_penalty_clause provisions. Insurance claim processing under hauling agreement insurance_certifica',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Accidents occurring on landfill property require site-level OSHA/DOT incident reporting, landfill operator liability tracking, and regulatory notification to the site permit holder. Linking accident_r',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Accidents involving hazmat shipments require manifest reference for NRC reporting (40 CFR 302), spill response coordination, insurance claims, and determining if DOT reportable quantities were release',
    `mrf_facility_id` BIGINT COMMENT 'Foreign key linking to recycling.mrf_facility. Business justification: Accidents on MRF facility premises require facility-specific OSHA reporting, safety performance tracking by facility, and facility management notification. A domain expert expects accident_report to r',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: Accidents occur during specific route executions. OSHA and DOT regulatory filings, insurance claims, and safety investigations require linking accident reports to the specific operational run during w',
    `vehicle_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_assignment. Business justification: Vehicle accidents occur during specific driver-vehicle assignments. Linking accident_report to vehicle_assignment provides the full operational context of the incident — which route was being run, wha',
    `vehicle_id` BIGINT COMMENT 'Identifier of the fleet vehicle involved in the accident. Links to the fleet vehicle master record.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Accidents with moving violations, hazmat releases, or DOT-reportable incidents generate violation notices from regulatory agencies. Risk managers link accident reports to notices for claims defense an',
    `waste_shipment_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_shipment. Business justification: 49 CFR 171.15/171.16 requires immediate notification and written reports for hazmat incidents. This FK links the accident report to the specific waste shipment being transported, providing shipment de',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Post-accident vehicle repair is a named business process requiring a work order. Linking accident_report to the resulting work_order enables insurance claim reconciliation, repair cost attribution to ',
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
    `location_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the accident location, captured from telematics or manually entered.',
    `location_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the accident location, captured from telematics or manually entered.',
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

CREATE OR REPLACE TABLE `waste_management_ecm`.`fleet`.`vehicle_class` (
    `vehicle_class_id` BIGINT COMMENT 'Unique identifier for the vehicle class reference record. Primary key.',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Vehicle class lift mechanism and body type must be compatible with container types (front-load, rear-load, roll-off). Fleet procurement and route planning require this link to ensure vehicles can serv',
    `dot_hazmat_classification_id` BIGINT COMMENT 'Foreign key linking to hazmat.dot_hazmat_classification. Business justification: Dispatch eligibility rules require that only vehicle classes certified for a specific DOT hazmat classification (e.g., Class 3 tanker, Class 8 bulk carrier) can be assigned to matching hazmat shipment',
    `parent_vehicle_class_id` BIGINT COMMENT 'Self-referencing FK on vehicle_class (parent_vehicle_class_id)',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Vehicle classes are governed by specific regulatory requirements (EPA emissions standards, DOT axle/weight regulations). Fleet procurement and compliance officers use this link to determine applicable',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.line. Business justification: Vehicle classes are defined per service line (e.g., rear-loader for residential MSW, roll-off for commercial). Fleet procurement, budgeting, and route planning depend on this link. service.line.fleet_',
    `training_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.training_requirement. Business justification: Vehicle classes mandate specific driver training (CDL class, hazmat endorsement, specialized equipment certification). Linking vehicle_class to training_requirement enables automated training gap anal',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Vehicle classes are engineered for specific waste streams (organics, MSW, hazmat, recyclables). Fleet procurement, driver PPE requirements, and DOT/EPA compliance reporting require knowing which waste',
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
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Preventive maintenance schedules are asset maintenance strategies that drive condition-based maintenance planning, asset reliability analysis, and maintenance cost capitalization decisions per IAS 16.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_schedule. Business justification: Fleet-domain maintenance schedules are governed by maintenance-domain PM plans. Linking fleet.maintenance_schedule to maintenance.pm_schedule allows fleet managers to trace which master PM plan drives',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: maintenance_schedule has fmcsa_required_flag and dot_inspection_flag indicating regulatory-driven schedules, but no FK to the specific regulatory_requirement mandating them. Compliance officers need t',
    `route_id` BIGINT COMMENT 'Foreign key linking to collection.route. Business justification: Preventive maintenance scheduling in waste management is route-aware — PM windows must avoid disrupting high-priority routes. Linking maintenance_schedule to route enables route-impact analysis during',
    `superseded_maintenance_schedule_id` BIGINT COMMENT 'Self-referencing FK on maintenance_schedule (superseded_maintenance_schedule_id)',
    `type_id` BIGINT COMMENT 'Foreign key linking to maintenance.type. Business justification: fleet.maintenance_schedule.pm_type is a denormalized plain-text field. Replacing it with a FK to maintenance.type normalizes the PM type classification, enabling consistent work order type assignment,',
    `vehicle_class_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_class. Business justification: Preventive maintenance schedules in fleet operations are defined at both the individual vehicle level AND the vehicle class level. A vehicle_class defines PM intervals (pm_interval_days, pm_interval_m',
    `vehicle_id` BIGINT COMMENT 'Reference to the vehicle assigned to this maintenance schedule.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Fleet PM schedule completion generates a maintenance work order. Linking fleet.maintenance_schedule to the resulting work_order enables closed-loop PM tracking — schedulers verify the work was execute',
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
    `priority` STRING COMMENT 'The priority level assigned to this preventive maintenance schedule entry.. Valid values are `low|medium|high|critical`',
    `schedule_number` STRING COMMENT 'Business identifier for the preventive maintenance schedule, used for tracking and reference in Infor EAM.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the maintenance schedule entry.. Valid values are `scheduled|due|overdue|in_progress|completed|cancelled`',
    `scheduled_date` DATE COMMENT 'The date on which this preventive maintenance is scheduled to be performed.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise timestamp when this preventive maintenance is scheduled to begin.',
    `trigger_type` STRING COMMENT 'The basis for triggering this preventive maintenance event: mileage-based, engine hours-based, calendar-based, or combined criteria per FMCSA requirements.. Valid values are `mileage|engine_hours|calendar|combined`',
    CONSTRAINT pk_maintenance_schedule PRIMARY KEY(`maintenance_schedule_id`)
) COMMENT 'Fleet-specific preventive maintenance schedule linking vehicles to PM intervals based on mileage, engine hours, and calendar triggers per FMCSA requirements';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ADD CONSTRAINT `fk_fleet_vehicle_registration_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ADD CONSTRAINT `fk_fleet_vehicle_class_parent_vehicle_class_id` FOREIGN KEY (`parent_vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_superseded_maintenance_schedule_id` FOREIGN KEY (`superseded_maintenance_schedule_id`) REFERENCES `waste_management_ecm`.`fleet`.`maintenance_schedule`(`maintenance_schedule_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`fleet` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `waste_management_ecm`.`fleet` SET TAGS ('dbx_domain' = 'fleet');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Home Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Home Yard Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `transporter_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `vehicle_class_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `training_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Cdl Training Certification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'Home District Identifier');
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Home Yard Facility Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `mrf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Mrf Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Recycling Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ALTER COLUMN `service_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Commitment Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `telematics_event_id` SET TAGS ('dbx_business_glossary_term' = 'Telematics Event ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `failure_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `mrf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Mrf Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `fuel_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Transaction ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fueling Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `dot_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Department of Transportation (DOT) Inspection ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `failure_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `waste_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Shipment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `basic_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Safety Accountability (CSA) Behavior Analysis and Safety Improvement Category (BASIC)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `carrier_dot_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Department of Transportation (DOT) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `carrier_dot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'Not Required|Pending|In Progress|Completed|Overdue|Verified');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `csa_score_impact` SET TAGS ('dbx_business_glossary_term' = 'Compliance Safety Accountability (CSA) Score Impact');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `driver_license_state` SET TAGS ('dbx_business_glossary_term' = 'Driver License State');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `driver_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `driver_license_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `driver_license_state` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `driver_oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Driver Out-of-Service Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_category` SET TAGS ('dbx_business_glossary_term' = 'Inspection Category');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_category` SET TAGS ('dbx_value_regex' = 'Roadside|Annual DOT|State Patrol|Terminal Audit|Compliance Review|Random');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_document_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Document Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration Minutes');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_report_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_report_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'Pass|Out-of-Service|Warning Issued|Violation Cited|Conditional Pass');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_state` SET TAGS ('dbx_business_glossary_term' = 'Inspection State');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Commercial Vehicle Safety Alliance (CVSA) Inspection Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'Level I|Level II|Level III|Level IV|Level V|Level VI');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspector_agency` SET TAGS ('dbx_business_glossary_term' = 'Inspector Agency');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspector_badge_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Badge Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspector_badge_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `oos_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Service Violation Count');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `out_of_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Service (OOS) Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `severity_weight` SET TAGS ('dbx_business_glossary_term' = 'Severity Weight');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `vehicle_odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Odometer Reading');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `vehicle_oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Out-of-Service Flag');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `violation_codes` SET TAGS ('dbx_business_glossary_term' = 'Violation Codes');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `pre_post_trip_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Pre-Post Trip Inspection ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `failure_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ALTER COLUMN `waste_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Shipment Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `hos_log_id` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Log ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` SET TAGS ('dbx_subdomain' = 'driver_operations');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `accident_report_id` SET TAGS ('dbx_business_glossary_term' = 'Accident Report ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `ehs_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Ehs Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `mrf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Mrf Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `waste_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Shipment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `vehicle_class_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `dot_hazmat_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Dot Hazmat Classification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `parent_vehicle_class_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `superseded_maintenance_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `type_id` SET TAGS ('dbx_business_glossary_term' = 'Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `vehicle_class_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Number');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'scheduled|due|overdue|in_progress|completed|cancelled');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Trigger Type');
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'mileage|engine_hours|calendar|combined');
