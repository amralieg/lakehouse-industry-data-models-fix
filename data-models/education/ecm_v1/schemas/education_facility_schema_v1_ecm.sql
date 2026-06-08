-- Schema for Domain: facility | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:28:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`facility` COMMENT 'Manages campus physical infrastructure including buildings, classrooms, laboratories, residence halls, utilities, and grounds. Tracks space inventory, room utilization, maintenance work orders, capital projects, energy management, and space planning. Supports Archibus operations, ADA compliance, and F&A cost rate space calculations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`facility`.`building` (
    `building_id` BIGINT COMMENT 'Unique identifier for the building. Primary key for the building master record.',
    `campus_id` BIGINT COMMENT 'Reference to the campus on which this building is located. Links to the campus master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Building managers are employees responsible for day-to-day operations, emergency response, and work order coordination. Essential for facilities accountability, contact routing, and org chart integrat',
    `ada_compliance_date` DATE COMMENT 'Date on which the building was certified as ADA compliant or most recent ADA compliance assessment date.',
    `ada_compliant` BOOLEAN COMMENT 'Indicates whether the building meets ADA accessibility requirements including accessible entrances, elevators, restrooms, and pathways.',
    `annual_operating_cost` DECIMAL(18,2) COMMENT 'Total annual operating cost for the building including utilities, maintenance, custodial services, and routine repairs.',
    `assignable_square_feet` DECIMAL(18,2) COMMENT 'Net assignable square footage available for occupancy and functional use, excluding circulation, mechanical, and structural areas. Critical for Facilities and Administrative (F&A) cost rate calculations reported to federal sponsors.',
    `automation_system` STRING COMMENT 'Name or type of the building automation system used to control HVAC, lighting, and other building systems.',
    `bike_parking_spaces` STRING COMMENT 'Number of bicycle parking spaces available at or near the building.',
    `building_code` STRING COMMENT 'Short alphanumeric code used to uniquely identify the building in campus systems and signage. This is the externally-known business identifier used in room numbering, wayfinding, and operational systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `building_name` STRING COMMENT 'Official name of the building, often honoring a donor, historical figure, or reflecting the buildings primary function.',
    `building_type` STRING COMMENT 'Primary functional classification of the building indicating its predominant use category. [ENUM-REF-CANDIDATE: academic|residential|administrative|research|athletic|library|student_services|dining|parking|utility — 10 candidates stripped; promote to reference product]',
    `city` STRING COMMENT 'City in which the building is located.',
    `construction_year` STRING COMMENT 'Year in which the building was originally constructed and completed.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the building location.. Valid values are `^[A-Z]{3}$`',
    `deferred_maintenance_backlog` DECIMAL(18,2) COMMENT 'Estimated dollar value of accumulated deferred maintenance and capital renewal needs for the building.',
    `effective_date` DATE COMMENT 'Date on which this building record became effective in the system, typically the date the building was added to the institutional inventory.',
    `emergency_generator` BOOLEAN COMMENT 'Indicates whether the building is equipped with an emergency backup generator for power continuity during outages.',
    `end_date` DATE COMMENT 'Date on which this building record was retired or decommissioned. Null for active buildings.',
    `energy_star_score` STRING COMMENT 'EPA Energy Star portfolio manager score (1-100) indicating the buildings energy performance relative to similar buildings nationwide.',
    `facility_condition_index` DECIMAL(18,2) COMMENT 'Ratio of deferred maintenance backlog to replacement value, indicating the relative condition of the building. Lower values indicate better condition.',
    `fire_suppression_system_type` STRING COMMENT 'Type of fire suppression system installed in the building for life safety compliance. [ENUM-REF-CANDIDATE: none|wet_pipe_sprinkler|dry_pipe_sprinkler|pre_action|deluge|clean_agent|combination — 7 candidates stripped; promote to reference product]',
    `gross_square_feet` DECIMAL(18,2) COMMENT 'Total gross square footage of the building measured from exterior wall to exterior wall, including all floors. Used for space inventory and capital planning.',
    `historic_designation` STRING COMMENT 'Historic preservation status indicating whether the building is listed on national, state, or local historic registers, which may impose renovation and maintenance restrictions.. Valid values are `none|national_register|state_register|local_landmark|contributing_structure`',
    `last_major_renovation_year` STRING COMMENT 'Year of the most recent major renovation or capital improvement project affecting the building structure or systems.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the building centroid in decimal degrees.',
    `leed_certification_date` DATE COMMENT 'Date on which the building received its LEED certification.',
    `leed_certification_level` STRING COMMENT 'LEED green building certification level achieved by the building, indicating sustainability and environmental performance.. Valid values are `none|certified|silver|gold|platinum`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the building centroid in decimal degrees.',
    `number_of_floors` STRING COMMENT 'Total count of floors in the building including basement and sub-basement levels.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the building indicating whether it is in service, under construction, or retired from use.. Valid values are `active|inactive|under_construction|under_renovation|decommissioned|planned`',
    `ownership_status` STRING COMMENT 'Legal ownership or control status of the building indicating whether the institution owns, leases, or has other rights to the property.. Valid values are `owned|leased|ground_lease|joint_use|donated`',
    `parking_spaces` STRING COMMENT 'Number of parking spaces associated with or adjacent to the building.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the building location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `primary_hvac_system_type` STRING COMMENT 'Description of the primary heating, ventilation, and air conditioning system type serving the building.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this building record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this building record was last modified in the system.',
    `replacement_value` DECIMAL(18,2) COMMENT 'Estimated current replacement value of the building in US dollars, used for insurance and capital planning purposes.',
    `space_utilization_rate` DECIMAL(18,2) COMMENT 'Percentage of assignable square footage that is actively utilized, calculated from room scheduling and occupancy data.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the building is located.. Valid values are `^[A-Z]{2}$`',
    `street_address` STRING COMMENT 'Physical street address of the building including street number and street name.',
    `wireless_coverage` BOOLEAN COMMENT 'Indicates whether the building has comprehensive wireless network coverage for institutional network access.',
    CONSTRAINT pk_building PRIMARY KEY(`building_id`)
) COMMENT 'Master record for every campus building and structure. Captures building code, name, address, construction year, gross square footage, assignable square footage, building type (academic, residential, administrative, research, athletic), ownership status (owned, leased, ground-lease), historic designation, ADA compliance status, LEED certification level, and operational status. Serves as the authoritative SSOT for all building-level space inventory and F&A cost rate space calculations reported to federal sponsors.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`room` (
    `room_id` BIGINT COMMENT 'Unique identifier for the room or space within the institutions facilities inventory. Primary key for the room entity.',
    `building_id` BIGINT COMMENT 'Reference to the building in which this room is located. Links to the building master record for campus facility hierarchy.',
    `collection_id` BIGINT COMMENT 'Foreign key linking to library.collection. Business justification: Academic libraries assign physical collections to specific rooms (special collections rooms, rare book vaults, archives). Required for space allocation planning, environmental control specifications f',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic or administrative department to which this room is assigned or allocated. Used for space charge-back, F&A cost allocation, and departmental space reporting.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Rooms have specific compliance requirements based on use: biosafety levels for labs, ADA accessibility standards, clinical space regulations, hazmat storage requirements. Environmental health and safe',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the room record is currently active (True) in the facilities inventory or has been deactivated/archived (False). Used for data management and reporting scope control.',
    `ada_accessible_flag` BOOLEAN COMMENT 'Indicates whether the room meets ADA accessibility standards (True) or not (False). Includes considerations for wheelchair access, assistive listening systems, and accessible fixtures.',
    `ada_features` STRING COMMENT 'Detailed description of ADA accessibility features present in the room (e.g., Wheelchair accessible seating, Assistive listening system, Accessible restroom, Adjustable height workstations).',
    `assignable_flag` BOOLEAN COMMENT 'Indicates whether the room is assignable space (True) or non-assignable space (False) per FICM standards. Assignable spaces are used for specific institutional functions; non-assignable includes circulation, mechanical, and structural areas.',
    `av_equipment_description` STRING COMMENT 'Detailed inventory of audio-visual equipment installed in the room (e.g., Epson projector, Extron control system, wireless microphone, Blu-ray player, document camera).',
    `av_equipment_level` STRING COMMENT 'Classification of the audio-visual technology infrastructure installed in the room. None=no AV; Basic=projector only; Standard=projector + audio; Advanced=smart classroom with document camera and control system; Premium=full multimedia suite with video conferencing and recording.. Valid values are `none|basic|standard|advanced|premium`',
    `biosafety_level` STRING COMMENT 'The biosafety level classification for laboratories handling biological agents, as defined by CDC/NIH guidelines. BSL-1=minimal hazard; BSL-2=moderate hazard; BSL-3=serious/potentially lethal; BSL-4=dangerous/exotic agents. Not_applicable for non-laboratory spaces.. Valid values are `BSL-1|BSL-2|BSL-3|BSL-4|not_applicable`',
    `ceiling_height_feet` DECIMAL(18,2) COMMENT 'The height of the ceiling in feet, measured from floor to ceiling. Relevant for space planning, AV equipment installation, and building code compliance.',
    `climate_control_type` STRING COMMENT 'The type of heating, ventilation, and air conditioning system serving the room. Central=building-wide system; Individual=room-specific unit; None=no climate control; VAV=variable air volume; CAV=constant air volume.. Valid values are `central|individual|none|variable_air_volume|constant_air_volume`',
    `condition` STRING COMMENT 'Assessment of the physical condition of the room based on facilities inspections. Excellent=like new; Good=well maintained; Fair=minor issues; Poor=significant deficiencies; Critical=immediate attention required.. Valid values are `excellent|good|fair|poor|critical`',
    `construction_year` STRING COMMENT 'The year the room was originally constructed as part of the building. Used for historical tracking, depreciation calculations, and facilities planning.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this room record was first created in the facilities management system. Used for audit trail and data lineage tracking.',
    `design_capacity` STRING COMMENT 'The maximum number of occupants the room is designed to accommodate based on fire code, seating configuration, and functional design. Used for course scheduling, event planning, and safety compliance.',
    `effective_end_date` DATE COMMENT 'The date this room record ceased to be effective, typically due to decommissioning, repurposing, or demolition. Null for currently active rooms.',
    `effective_start_date` DATE COMMENT 'The date this room record became effective in the facilities inventory system. Used for temporal tracking and historical space analysis.',
    `emergency_equipment` STRING COMMENT 'Description of emergency safety equipment installed in the room (e.g., Emergency shower, eyewash station, fire extinguisher, first aid kit, spill kit).',
    `fire_safety_rating` STRING COMMENT 'Fire safety compliance status of the room based on fire marshal inspections and NFPA standards. Compliant=meets all requirements; Non_compliant=deficiencies identified; Exempt=not subject to inspection; Pending_inspection=awaiting assessment.. Valid values are `compliant|non_compliant|exempt|pending_inspection`',
    `floor_level` STRING COMMENT 'The floor or level on which the room is located. May include basement (B), ground (G), mezzanine (M), or numeric floor designations (1, 2, 3, etc.).',
    `fume_hood_count` STRING COMMENT 'The number of fume hoods or chemical exhaust systems installed in the room. Relevant for chemistry and biology laboratories. Used for safety compliance and laboratory capacity planning.',
    `furniture_description` STRING COMMENT 'Detailed description of furniture and fixtures in the room (e.g., 30 tablet arm chairs, instructor podium, whiteboard, storage cabinets).',
    `gross_square_feet` DECIMAL(18,2) COMMENT 'The total gross square footage of the room, including walls and structural elements. Used for building-level space accounting and capital planning.',
    `hazardous_materials_flag` BOOLEAN COMMENT 'Indicates whether the room is approved for storage or use of hazardous materials (True) or not (False). Relevant for laboratories, research spaces, and facilities requiring special safety protocols.',
    `hvac_zone` STRING COMMENT 'The HVAC zone or control area to which this room belongs. Used for energy management, temperature control, and facilities maintenance planning.',
    `last_inspection_date` DATE COMMENT 'The date of the most recent facilities inspection or condition assessment of the room. Used for compliance tracking and maintenance planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this room record was most recently updated. Used for change tracking and data quality monitoring.',
    `natural_light_flag` BOOLEAN COMMENT 'Indicates whether the room has windows or skylights providing natural daylight (True) or is an interior room without natural light (False). Relevant for occupant comfort, energy efficiency, and space quality assessments.',
    `net_assignable_square_feet` DECIMAL(18,2) COMMENT 'The net assignable square footage of the room, measured per FICM standards. Used for space utilization analysis, Facilities and Administrative (F&A) cost rate calculations, and IPEDS reporting.',
    `occupancy_status` STRING COMMENT 'Current occupancy or availability status of the room. Occupied=assigned to a department or individual; Vacant=available for assignment; Reserved=scheduled for specific use; Under_renovation=temporarily unavailable due to construction; Decommissioned=no longer in service; Temporary_closure=short-term unavailability.. Valid values are `occupied|vacant|reserved|under_renovation|decommissioned|temporary_closure`',
    `renovation_date` DATE COMMENT 'The date of the most recent major renovation or refurbishment of the room. Used for capital planning, deferred maintenance tracking, and space quality assessment.',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual, department, or unit responsible for the rooms management, maintenance, and scheduling. May be a facilities manager, department chair, or administrative contact.',
    `room_name` STRING COMMENT 'Descriptive name or title of the room, often used for named lecture halls, laboratories, or conference rooms (e.g., Smith Auditorium, Chemistry Lab A, Board Room).',
    `room_number` STRING COMMENT 'The official room number or identifier as displayed on signage and used in campus navigation. May include alphanumeric characters and floor prefixes (e.g., 201A, B-105, L3-220).',
    `room_type` STRING COMMENT 'High-level categorical classification of the rooms primary function. Used for space utilization reporting, scheduling eligibility, and facilities planning. [ENUM-REF-CANDIDATE: classroom|laboratory|office|conference_room|study_room|residence_hall_unit|common_area|storage|mechanical|restroom|auditorium|library_space|athletic_facility|dining_facility|healthcare_facility|other — 16 candidates stripped; promote to reference product]',
    `scheduling_eligible_flag` BOOLEAN COMMENT 'Indicates whether the room is available for centralized scheduling through the registrar or scheduling office (True) or is managed independently by a department (False). Relevant for course scheduling and event management.',
    `scheduling_priority` STRING COMMENT 'The primary scheduling priority or use category for the room. Academic=prioritized for course instruction; Administrative=departmental meetings and operations; Event=special events and conferences; Research=research activities; Mixed_use=multiple purposes.. Valid values are `academic|administrative|event|research|mixed_use`',
    `seating_configuration` STRING COMMENT 'The physical arrangement and type of seating in the room. Fixed=permanent seating; Movable=chairs and tables that can be rearranged; Tiered=lecture hall style; Seminar=conference table; Laboratory=lab benches; Theater=auditorium seating. [ENUM-REF-CANDIDATE: fixed|movable|tiered|seminar|laboratory|conference|theater|flexible|other — 9 candidates stripped; promote to reference product]',
    `smart_classroom_flag` BOOLEAN COMMENT 'Indicates whether the room is equipped as a smart classroom with integrated technology for teaching and learning (True) or not (False). Smart classrooms typically include projection systems, document cameras, audio systems, and network connectivity.',
    `station_count` STRING COMMENT 'The number of fixed workstations, seats, or positions available in the room. Relevant for classrooms, laboratories, computer labs, and study spaces. Used for scheduling and utilization metrics.',
    `subtype` STRING COMMENT 'Secondary classification providing additional granularity within the room type (e.g., Wet Lab, Dry Lab, Smart Classroom, Seminar Room, Single Occupancy, Double Occupancy).',
    `technology_infrastructure` STRING COMMENT 'Description of network, power, and technology infrastructure available in the room (e.g., Gigabit Ethernet, WiFi 6, 20 power outlets, USB charging stations, HDMI connectivity).',
    `use_code` STRING COMMENT 'Standardized code classifying the primary functional use of the room according to Facilities Inventory and Classification Manual (FICM) or institutional taxonomy (e.g., 110=Classroom, 210=Class Laboratory, 310=Research Laboratory, 410=Study Room, 610=Office).',
    `window_count` STRING COMMENT 'The number of windows in the room. Used for natural light assessment, energy modeling, and space quality evaluation.',
    CONSTRAINT pk_room PRIMARY KEY(`room_id`)
) COMMENT 'Master record for every assignable and non-assignable room or space within a building. Captures room number, floor, room use code (per FICM classification), room type (classroom, laboratory, office, residence hall unit, common area), design capacity, station count, net assignable square footage, ADA accessibility features, technology infrastructure (smart classroom, AV equipment), and current occupancy status. Foundational entity for space utilization, course scheduling, and F&A indirect cost rate calculations.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`campus` (
    `campus_id` BIGINT COMMENT 'Unique identifier for the campus record. Primary key.',
    `accreditation_date` DATE COMMENT 'Date when the campus received its current accreditation status. Used for tracking accreditation cycles and reaffirmation timelines.',
    `accreditation_status` STRING COMMENT 'Current accreditation standing of the campus with its regional accrediting body. Accredited indicates full approval; candidate indicates provisional status; probation indicates conditional approval with required improvements; not accredited indicates no current accreditation; pending review indicates evaluation in progress.. Valid values are `accredited|candidate|probation|not accredited|pending review`',
    `accreditor_name` STRING COMMENT 'Name of the regional or specialized accrediting agency responsible for evaluating the campus. Examples include Higher Learning Commission (HLC), Southern Association of Colleges and Schools Commission on Colleges (SACSCOC), Middle States Commission on Higher Education (MSCHE).',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the campus meets ADA accessibility requirements. True indicates full compliance; False indicates non-compliance or partial compliance. Used for compliance reporting and facilities planning.',
    `address_line_1` STRING COMMENT 'Primary street address of the campus including building number and street name. Used for official correspondence, accreditation documentation, and facilities management.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite number, building name, or department. Optional field for additional address details.',
    `assignable_square_feet` DECIMAL(18,2) COMMENT 'Total assignable square footage available for occupancy and specific use. Excludes circulation, mechanical, and structural areas. Used for space allocation, utilization metrics, and indirect cost rate calculations.',
    `athletic_facilities_flag` BOOLEAN COMMENT 'Indicates whether the campus has dedicated athletic or recreation facilities. True indicates athletic facilities are present; False indicates no athletic facilities. Used for student services planning and NCAA compliance.',
    `building_count` STRING COMMENT 'Total number of buildings located on the campus. Includes academic, administrative, residential, and auxiliary buildings. Used for facilities inventory and capital planning.',
    `campus_code` STRING COMMENT 'Institution-assigned unique alphanumeric code for the campus. Used in Student Information System (SIS) and Facilities Management System (FMS) for campus identification.. Valid values are `^[A-Z0-9]{2,10}$`',
    `campus_name` STRING COMMENT 'Official name of the campus or instructional site as registered with the institution and accrediting bodies.',
    `campus_type` STRING COMMENT 'Classification of the campus based on its operational role within the institution. Main campus is the primary instructional and administrative site; branch campus is a geographically separate location with independent operations; regional campus serves a specific geographic area; extension center offers limited programs; online campus is virtual; off-campus center is a satellite instructional site.. Valid values are `main|branch|regional|extension|online|off-campus center`',
    `city` STRING COMMENT 'City or municipality where the campus is located. Required for IPEDS reporting and accreditation documentation.',
    `closure_date` DATE COMMENT 'Date when the campus ceased operations or was officially closed. Null for active campuses. Used for historical tracking and IPEDS reporting of closed locations.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the campus is located. Required for international campuses and IPEDS reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campus record was first created in the system. Used for audit trail and data lineage tracking.',
    `email_address` STRING COMMENT 'Primary email address for campus administrative contact. Used for official correspondence and public inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Name of the primary emergency contact person or office for the campus. Used for crisis management and emergency response coordination.',
    `emergency_contact_phone` STRING COMMENT '24/7 emergency contact phone number for the campus. Used for crisis situations, security incidents, and emergency notifications.',
    `established_date` DATE COMMENT 'Date when the campus was officially established or opened for instruction. Used for historical records and institutional milestone tracking.',
    `fax_number` STRING COMMENT 'Fax number for the campus administrative office. Used for official document transmission and legacy communication channels.',
    `ipeds_unit_code` STRING COMMENT 'Six-digit unique identifier assigned by the National Center for Education Statistics (NCES) for IPEDS reporting. Required for all Title IV eligible institutions and their branch campuses.. Valid values are `^[0-9]{6}$`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the campus in decimal degrees. Used for mapping, geographic analysis, and location-based services.',
    `library_flag` BOOLEAN COMMENT 'Indicates whether the campus has a physical library facility. True indicates a library is present; False indicates no library. Used for academic resource planning and accreditation documentation.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the campus in decimal degrees. Used for mapping, geographic analysis, and location-based services.',
    `next_accreditation_review_date` DATE COMMENT 'Scheduled date for the next comprehensive accreditation review or reaffirmation visit. Typically occurs on a 5-10 year cycle depending on the accrediting body.',
    `notes` STRING COMMENT 'Free-form text field for additional campus information, special characteristics, or administrative notes. Used for documenting unique campus attributes not captured in structured fields.',
    `operational_status` STRING COMMENT 'Current operational state of the campus. Active indicates the campus is fully operational and offering instruction; inactive indicates the campus is not currently in use; planned indicates future campus under development; under construction indicates physical development in progress; decommissioned indicates permanent closure; temporary closure indicates short-term suspension of operations.. Valid values are `active|inactive|planned|under construction|decommissioned|temporary closure`',
    `parking_spaces_count` STRING COMMENT 'Total number of parking spaces available on the campus. Includes student, faculty, staff, visitor, and accessible parking. Used for transportation planning and parking management.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the campus. Used for general inquiries, emergency contact, and directory listings.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the campus location. Used for mail delivery, geographic analysis, and regional reporting.',
    `residence_hall_capacity` STRING COMMENT 'Total number of students that can be housed in on-campus residence halls at this campus. Used for housing planning, enrollment management, and student life operations.',
    `security_flag` BOOLEAN COMMENT 'Indicates whether the campus has a dedicated campus security or police department. True indicates security presence; False indicates no dedicated security. Used for Clery Act reporting and safety planning.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the campus is located. Uses USPS state abbreviations for U.S. locations or ISO 3166-2 codes for international locations.. Valid values are `^[A-Z]{2}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the campus location. Used for scheduling, course registration, event management, and system timestamp conversions. Examples: America/New_York, America/Chicago, America/Los_Angeles.',
    `total_acreage` DECIMAL(18,2) COMMENT 'Total land area of the campus in acres. Includes all owned and leased property. Used for facilities planning, capital project planning, and IPEDS reporting.',
    `total_gross_square_feet` DECIMAL(18,2) COMMENT 'Total gross square footage of all buildings on the campus. Measured per FICM standards. Used for space utilization analysis, Facilities and Administrative (F&A) cost rate calculations, and capital planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the campus record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `website_url` STRING COMMENT 'Official website URL for the campus. Provides public access to campus information, programs, and services.',
    CONSTRAINT pk_campus PRIMARY KEY(`campus_id`)
) COMMENT 'Master record for each distinct campus or off-campus instructional site operated by the institution. Captures campus code, campus name, campus type (main campus, branch campus, off-campus center, online), physical address, total acreage, total gross square footage, accreditation status with regional accreditor, IPEDS unit ID, and operational status. Serves as the top-level geographic hierarchy node above buildings for space inventory, IPEDS reporting, and multi-campus institutional planning.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`space_assignment` (
    `space_assignment_id` BIGINT COMMENT 'Unique identifier for the space assignment record. Primary key for the space assignment entity.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program or degree program utilizing the assigned space. Used for program-level space utilization analysis and accreditation reporting.',
    `accreditation_review_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_review. Business justification: Accreditation reviews evaluate whether programs have adequate and appropriate space (lab space for science programs, clinical space for health professions, studio space for arts). Accreditation coordi',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Space assignments need structured cost_center link for space chargeback billing, indirect cost rate calculations, and facilities cost allocation. The cost center being charged may differ from org_unit',
    `collection_id` BIGINT COMMENT 'Foreign key linking to library.collection. Business justification: Space assignments track which organizational units house which library collections for indirect cost recovery calculations, federal space utilization surveys (FICM reporting), and facilities charge-ba',
    `employee_id` BIGINT COMMENT 'Reference to the user or administrator who approved the space assignment. Links to institutional user directory for accountability and audit purposes.',
    `advancement_fund_id` BIGINT COMMENT 'Foreign key linking to advancement.advancement_fund. Business justification: Endowed chairs, named research centers, and program-specific spaces are funded by advancement gifts/endowments. Space assignment records must track which advancement fund supports each space allocatio',
    `grant_account_id` BIGINT COMMENT 'Reference to the sponsored research grant or award funding the space assignment. Applicable for research space assignments funded by external sponsors (NSF, NIH, etc.). Null for institutionally-funded assignments.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic or administrative department to which the space is assigned.',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the faculty member or researcher serving as the principal investigator for research space assignments. Null for non-research assignments. Links to faculty master data.',
    `room_id` BIGINT COMMENT 'Reference to the physical room or space being assigned. Links to the space inventory master.',
    `accreditation_reportable_flag` BOOLEAN COMMENT 'Boolean indicator that this space assignment should be included in accreditation self-study reports and site visit documentation. Used for regional and programmatic accreditation compliance (SACSCOC, HLC, ABET, AACSB, etc.).',
    `ada_compliance_required` BOOLEAN COMMENT 'Boolean flag indicating whether this space assignment requires ADA accessibility compliance due to occupant needs or program requirements. Used for facilities planning and accommodation tracking.',
    `animal_research_flag` BOOLEAN COMMENT 'Boolean indicator that the assigned space will be used for animal research activities. Requires IACUC (Institutional Animal Care and Use Committee) approval and specialized facility standards.',
    `annual_chargeback_amount` DECIMAL(18,2) COMMENT 'The total annual chargeback amount for this space assignment, calculated as assigned square footage multiplied by chargeback rate. Used for budgeting and financial planning.',
    `assigned_square_footage` DECIMAL(18,2) COMMENT 'The net assignable square feet (NASF) allocated to the organizational unit under this assignment. For shared assignments, represents the proportional allocation. Critical for Facilities and Administrative (F&A) cost rate calculations per OMB Uniform Guidance 2 CFR 200.',
    `assignment_approval_date` DATE COMMENT 'The date on which the space assignment was formally approved by the space management authority or facilities committee. Used for audit trail and governance tracking.',
    `assignment_end_date` DATE COMMENT 'The date on which the space assignment terminates. Null for open-ended assignments. Critical for space planning and reallocation cycles.',
    `assignment_notes` STRING COMMENT 'Free-text field for additional context, special conditions, or administrative notes related to the space assignment. May include renovation plans, temporary arrangements, or compliance considerations.',
    `assignment_priority` STRING COMMENT 'Numeric priority ranking for this assignment when multiple assignments exist for the same space. Lower numbers indicate higher priority. Used for conflict resolution and space reallocation decisions.',
    `assignment_start_date` DATE COMMENT 'The date on which the space assignment becomes effective and the organizational unit takes occupancy or responsibility for the space.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the space assignment indicating whether it is currently active, pending approval, expired, cancelled before completion, or temporarily suspended.. Valid values are `active|pending|expired|cancelled|suspended`',
    `assignment_type` STRING COMMENT 'Classification of the assignment indicating whether the space is assigned as primary occupancy, shared among multiple units, swing space during renovation, temporary assignment, seasonal use, or reserved for future allocation.. Valid values are `primary|shared|swing|temporary|seasonal|reserved`',
    `chargeback_rate` DECIMAL(18,2) COMMENT 'The internal chargeback rate per square foot per year applied to this space assignment for cost recovery purposes. Used in institutional chargeback models where departments are billed for space occupancy.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this space assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `ficm_room_use_code` STRING COMMENT 'Three-digit code from the FICM standard indicating the functional use of the space during this assignment period (e.g., 110 for classroom, 250 for research laboratory, 310 for office). Used for IPEDS facilities reporting and F&A rate space surveys.. Valid values are `^[0-9]{3}$`',
    `hazardous_materials_flag` BOOLEAN COMMENT 'Boolean indicator that the assigned space will be used for activities involving hazardous materials, chemicals, or biohazards. Triggers additional safety, environmental, and regulatory compliance requirements.',
    `human_subjects_research_flag` BOOLEAN COMMENT 'Boolean indicator that the assigned space will be used for research involving human subjects. Requires IRB (Institutional Review Board) approval and compliance with HIPAA and FERPA as applicable.',
    `ipeds_reportable_flag` BOOLEAN COMMENT 'Boolean indicator that this space assignment should be included in IPEDS facilities reporting. Used to filter assignments for federal reporting compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this space assignment record was most recently updated. Used for change tracking and audit purposes.',
    `occupancy_percentage` DECIMAL(18,2) COMMENT 'The percentage of the space allocated to this assignment, expressed as a decimal (e.g., 50.00 for 50% occupancy). Used for shared space assignments where multiple organizational units share a single room. Sum of all assignments for a room should equal 100.00.',
    `purpose_code` STRING COMMENT 'Classification of the space assignment purpose for indirect cost allocation: instruction (teaching activities), research (sponsored research projects), other sponsored (non-research sponsored activities), institutional (administrative support), or unallowable (activities not eligible for F&A recovery). Required for OMB Uniform Guidance compliance.. Valid values are `instruction|research|other_sponsored|institutional|unallowable`',
    `renewal_date` DATE COMMENT 'The date by which the space assignment must be renewed or revalidated. Null if renewal is not required. Used for proactive space management and reallocation planning.',
    `renewal_required_flag` BOOLEAN COMMENT 'Boolean indicator that this space assignment requires periodic renewal or revalidation. Used for temporary assignments, grant-funded space, or assignments subject to annual review.',
    `space_survey_period` STRING COMMENT 'The fiscal year or survey period (YYYY format) during which this space assignment was recorded for F&A rate calculation purposes. Required for OMB Uniform Guidance space surveys conducted biennially or as required by federal sponsors.. Valid values are `^[0-9]{4}$`',
    CONSTRAINT pk_space_assignment PRIMARY KEY(`space_assignment_id`)
) COMMENT 'Tracks the organizational assignment of rooms and spaces to departments, programs, research projects, or individuals for a defined period. Records the assigned organizational unit, PI or department head, assignment type (primary, shared, swing), assigned square footage, FICM room use code during assignment period, assignment start and end dates, and purpose code (instruction, research, other sponsored, institutional, unallowable). Critical for F&A indirect cost rate space surveys per OMB Uniform Guidance (2 CFR 200), accreditation space reporting, and IPEDS facilities data submissions. Serves as the bridge between physical space inventory and organizational cost allocation.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`room_booking` (
    `room_booking_id` BIGINT COMMENT 'Unique identifier for the room booking reservation record. Primary key for the room booking entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the person responsible for reviewing and approving the booking request. Typically a facilities manager, department head, or space coordinator.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Room bookings requiring billing need structured cost_center link for event billing, interdepartmental chargebacks, and revenue recognition. The billing_account_code text field should be replaced with ',
    `building_id` BIGINT COMMENT 'Identifier of the building where the reserved room is located. Supports building-level reporting and space analytics.',
    `event_id` BIGINT COMMENT 'Identifier from an external system or integration partner. Used to maintain linkage with source systems and support bi-directional synchronization.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic or administrative department sponsoring or responsible for the booking. Used for chargeback and utilization reporting.',
    `parent_booking_room_booking_id` BIGINT COMMENT 'Identifier of the parent or master booking record for recurring series. Links individual occurrences to the series definition. Null for standalone bookings.',
    `patron_id` BIGINT COMMENT 'Foreign key linking to library.patron. Business justification: Library patrons book study rooms, group study spaces, media rooms, and presentation practice rooms through integrated library-facility systems. Core business process for library patron services, room ',
    `primary_room_employee_id` BIGINT COMMENT 'Identifier of the person who submitted the room booking request. May be faculty, staff, student, or external party.',
    `recruitment_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.recruitment_event. Business justification: Room bookings for recruitment events link facility reservations to enrollment activities. Event management, space planning, and cross-functional coordination between admissions and facilities require ',
    `room_id` BIGINT COMMENT 'Identifier of the physical room or space being reserved. Links to the room master data in the facility domain.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to student.profile. Business justification: Student organizations and individual students book rooms for events, study groups, and meetings. Distinct from employee_id (staff bookings). Required for student activity tracking, space utilization a',
    `accessibility_requirements` STRING COMMENT 'Specific accessibility accommodations needed for the event such as wheelchair access, assistive listening devices, sign language interpreters, or other ADA (Americans with Disabilities Act) compliance needs.',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the event concluded or the room was vacated. Used for utilization analysis and billing accuracy.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the event began or the room was accessed. Captured via check-in systems or manual confirmation.',
    `approval_datetime` TIMESTAMP COMMENT 'Date and time when the booking was formally approved. Null if approval is not required or booking is still pending.',
    `approval_notes` STRING COMMENT 'Comments or conditions provided by the approver during the approval process. May include special instructions or restrictions.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the booking requires formal approval before confirmation. Driven by room policies, event type, or requestor authorization level.',
    `av_equipment_notes` STRING COMMENT 'Detailed list or description of specific AV equipment needed such as projectors, microphones, video conferencing, recording equipment, or technical support.',
    `av_equipment_required` BOOLEAN COMMENT 'Indicates whether audio-visual equipment or technical support is needed for the event. Triggers AV service coordination.',
    `billing_amount` DECIMAL(18,2) COMMENT 'Total amount to be charged for the room booking including base rental, setup fees, AV charges, and other services. Null if no billing applies.',
    `billing_required` BOOLEAN COMMENT 'Indicates whether the booking incurs charges that must be billed to the requestor or sponsoring department. Drives chargeback and cost recovery processes.',
    `booking_number` STRING COMMENT 'Human-readable external booking reference number provided to requestors for confirmation and communication. Format: BK followed by 8 digits.. Valid values are `^BK[0-9]{8}$`',
    `booking_status` STRING COMMENT 'Current lifecycle status of the room booking reservation. Tracks progression from initial request through completion or cancellation. [ENUM-REF-CANDIDATE: requested|pending_approval|confirmed|checked_in|completed|cancelled|no_show — 7 candidates stripped; promote to reference product]',
    `cancellation_datetime` TIMESTAMP COMMENT 'Date and time when the booking was cancelled. Null for active or completed bookings. Used to track cancellation patterns and no-show trends.',
    `cancellation_reason` STRING COMMENT 'Explanation or reason code for why the booking was cancelled. Supports analysis of cancellation drivers and policy refinement.',
    `catering_notes` STRING COMMENT 'Details of catering requirements including menu preferences, dietary restrictions, service times, and vendor information.',
    `catering_required` BOOLEAN COMMENT 'Indicates whether food and beverage service is requested for the event. May trigger coordination with campus dining or external caterers.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when the booking record was first created in the system. Audit timestamp for record creation.',
    `event_description` STRING COMMENT 'Detailed description of the event purpose, agenda, or special requirements. Provides context for approval and setup coordination.',
    `event_type` STRING COMMENT 'Classification of the event or activity type. Supports space utilization analysis and setup planning. Excludes regular course sections which are managed in the enrollment domain. [ENUM-REF-CANDIDATE: meeting|seminar|workshop|conference|exam|social_event|rehearsal|other — 8 candidates stripped; promote to reference product]',
    `expected_attendance` STRING COMMENT 'Anticipated number of attendees or participants for the event. Used to validate room capacity and setup requirements.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this booking is part of a recurring series of reservations. Used to link related bookings and manage series-level changes.',
    `modified_datetime` TIMESTAMP COMMENT 'Date and time when the booking record was last updated. Tracks most recent change for audit and synchronization purposes.',
    `recurrence_pattern` STRING COMMENT 'Description of the recurrence schedule for recurring bookings such as daily, weekly, bi-weekly, monthly, or custom patterns. Null for one-time bookings.',
    `requestor_email` STRING COMMENT 'Email address of the booking requestor used for confirmation notifications, reminders, and booking-related communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_name` STRING COMMENT 'Full name of the individual who requested the room booking. Captured for confirmation communications and audit trail.',
    `requestor_phone` STRING COMMENT 'Contact phone number for the booking requestor. Used for urgent communications or day-of-event coordination.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Date and time when the room reservation is scheduled to conclude. Used to calculate booking duration and prevent scheduling conflicts.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Date and time when the room reservation is scheduled to begin. Represents the principal business event timestamp for the booking.',
    `setup_notes` STRING COMMENT 'Additional instructions or special requirements for room setup, including furniture placement, accessibility accommodations, or custom configurations.',
    `setup_type` STRING COMMENT 'Requested furniture and seating arrangement configuration for the event. Drives facilities setup work orders and labor planning. [ENUM-REF-CANDIDATE: classroom|theater|banquet|conference|u_shape|hollow_square|reception|exam|custom — 9 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Name or identifier of the system from which the booking record originated such as Archibus, campus event management portal, or third-party scheduling integration.',
    CONSTRAINT pk_room_booking PRIMARY KEY(`room_booking_id`)
) COMMENT 'Transactional record of a scheduled reservation of a room or space for a specific event, class session, meeting, or activity. Captures requestor, booking purpose, event type, requested setup configuration, expected attendance, start and end datetime, approval status, and any special equipment or AV needs. Distinct from course section scheduling (owned by enrollment domain); covers ad-hoc and event-driven reservations managed through Archibus room scheduling.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the facilities work order. Primary key for the work order entity.',
    `asset_id` BIGINT COMMENT 'Identifier of the specific equipment or facility asset requiring maintenance or repair, linking to asset inventory for equipment history and specifications.',
    `crew_id` BIGINT COMMENT 'Identifier of the facilities maintenance crew or team assigned to the work order, linking to crew master data for scheduling and resource management.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Work orders are assigned to specific maintenance staff employees for dispatch, accountability, and labor tracking. Essential for facilities management operations, workload balancing, and performance r',
    `building_id` BIGINT COMMENT 'Identifier of the campus building where the work is to be performed, linking to the building master data for location context and space inventory.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work orders need structured cost_center link for facilities maintenance cost allocation, departmental chargebacks, and budget tracking. The charge_to_account text field should be replaced with proper ',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Corrective actions from audits, accreditation reviews, or regulatory inspections often require physical remediation work (fix fire safety deficiencies, install accessibility features, remediate enviro',
    `finance_vendor_id` BIGINT COMMENT 'Identifier of the external contractor or vendor assigned to perform the work, used when work is outsourced rather than performed by internal staff.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Work order costs must post to specific GL accounts (maintenance expense, repairs, utilities) for financial reporting, budget vs. actual analysis, and NACUBO functional classification. Structured ledge',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic or administrative department that requested the work order, used for cost allocation and service tracking.',
    `pm_schedule_id` BIGINT COMMENT 'Identifier linking the work order to a recurring preventive maintenance schedule or program, used to track compliance with planned maintenance cycles.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Work orders for lab repairs, modifications, and equipment maintenance are charged to research awards. Facilities billing, cost recovery, and award budget management require award tracking on work orde',
    `room_id` BIGINT COMMENT 'Identifier of the specific room or space within the building where the work is to be performed, linking to room inventory for precise location and space type.',
    `actual_completion_date` DATE COMMENT 'Actual date when work was finished and the work order was marked complete, used for cycle time analysis and SLA compliance reporting.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Total number of labor hours actually expended on the work order, captured from time sheets and used for cost accounting and productivity analysis.',
    `actual_start_date` DATE COMMENT 'Actual date when work commenced, used to calculate response time and compare against scheduled start for performance analysis.',
    `ada_compliance_flag` BOOLEAN COMMENT 'Indicates whether the work order is related to Americans with Disabilities Act (ADA) compliance requirements, accessibility improvements, or accommodations.',
    `closed_by` STRING COMMENT 'Name or identifier of the person who closed the work order, typically a supervisor or facilities manager who verified completion and quality.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was officially closed and archived, marking the end of the work order lifecycle and enabling cycle time analysis.',
    `completion_notes` STRING COMMENT 'Narrative notes entered by the technician upon completion describing work performed, findings, recommendations, or follow-up actions required.',
    `contractor_cost` DECIMAL(18,2) COMMENT 'Total cost paid to external contractors or vendors for work performed, including labor, materials, and markup.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was first created in the Archibus system, used for audit trail and response time calculation.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Number of hours that the facility, equipment, or space was out of service due to the issue or during repair, used for availability and reliability metrics.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Projected number of labor hours required to complete the work order, used for resource planning and initial cost estimation.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total cost of labor for the work order, calculated from actual labor hours and applicable wage rates, used for maintenance cost analysis and Facilities and Administrative (F&A) cost allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was last updated, used for audit trail and tracking status changes throughout the work order lifecycle.',
    `materials_cost` DECIMAL(18,2) COMMENT 'Total cost of parts, materials, and supplies consumed in completing the work order, sourced from inventory or purchasing records.',
    `priority_level` STRING COMMENT 'Business priority assigned to the work order based on urgency, safety impact, and operational criticality. Critical indicates immediate life-safety or mission-critical system failure.. Valid values are `critical|high|medium|low`',
    `problem_description` STRING COMMENT 'Detailed narrative description of the issue, defect, or work requirement as reported by the requester or observed during inspection.',
    `request_date` DATE COMMENT 'Date when the work order was originally requested or initiated by the requesting department or system.',
    `requested_by` STRING COMMENT 'Name or identifier of the person who submitted the work order request, typically a faculty member, staff member, or facilities coordinator.',
    `requester_satisfaction_rating` STRING COMMENT 'Satisfaction score provided by the requester after work completion, typically on a scale of 1-5, used for service quality assessment and Key Performance Indicator (KPI) tracking.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether the work order was triggered by a safety incident, hazard, or Occupational Safety and Health Administration (OSHA) compliance issue requiring immediate attention.',
    `scheduled_completion_date` DATE COMMENT 'Target date by which the work order is expected to be completed, used for Service Level Agreement (SLA) tracking and backlog management.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work is scheduled to begin, used for crew scheduling and resource planning.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the work order including labor, materials, and contractor expenses, used for budget tracking, cost recovery, and maintenance cost analysis by building or system.',
    `trade_category` STRING COMMENT 'Skilled trade or craft discipline required to complete the work order, used for crew assignment and labor cost classification. [ENUM-REF-CANDIDATE: electrical|plumbing|hvac|carpentry|painting|grounds|custodial|locksmith|general — 9 candidates stripped; promote to reference product]',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether the work order is covered under equipment or contractor warranty, affecting cost recovery and vendor accountability.',
    `work_description` STRING COMMENT 'Detailed description of the work to be performed, including scope, methods, and materials, typically completed by the assigned technician or supervisor.',
    `work_order_number` STRING COMMENT 'Externally-visible business identifier for the work order, typically formatted as WO-YYYYNNNN for tracking and reference in Archibus and communications.. Valid values are `^WO-[0-9]{8}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle state of the work order: open (newly created), assigned (dispatched to crew), in_progress (work underway), on_hold (awaiting parts or approval), completed (work finished), closed (verified and archived), or cancelled (no longer required). [ENUM-REF-CANDIDATE: open|assigned|in_progress|on_hold|completed|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the work order by maintenance category: corrective (reactive repair), preventive (scheduled maintenance), emergency (urgent response), project (capital improvement), inspection (compliance or condition assessment), or deferred (backlog).. Valid values are `corrective|preventive|emergency|project|inspection|deferred`',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core operational record for a maintenance, repair, or facilities service request managed through Archibus. Captures work order number, request type (corrective, preventive, emergency, project), priority level, description of work, requesting department, assigned trade crew or contractor, estimated and actual labor hours, parts and materials used, work order status lifecycle (open, assigned, in-progress, completed, closed), completion date, and total cost. Links to facility assets for equipment-specific maintenance and to buildings/rooms for location context. Primary transactional entity for day-to-day facilities operations, KPI tracking (response time, completion rate, backlog), and maintenance cost analysis by building, system, or trade.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record.',
    `asset_id` BIGINT COMMENT 'Reference to the physical asset or equipment item subject to this preventive maintenance schedule.',
    `building_id` BIGINT COMMENT 'Reference to the campus building where the asset subject to this preventive maintenance schedule is located, supporting space-based reporting and capital planning.',
    `employee_id` BIGINT COMMENT 'Reference to the facilities management staff member or system administrator who created this preventive maintenance schedule record.',
    `floor_id` BIGINT COMMENT 'Reference to the specific floor within the building where the asset is located, enabling granular space utilization and maintenance tracking.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the facilities management staff member or system administrator who most recently modified this preventive maintenance schedule record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic or administrative department responsible for funding or overseeing this preventive maintenance schedule, used for cost allocation and accountability.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PM schedules need structured cost_center link for preventive maintenance budget planning, cost allocation, and departmental chargeback billing. Replacing cost_center_code text field with proper FK ena',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Preventive maintenance for award-funded research equipment is charged back to awards. Cost recovery systems require award linkage on PM schedules for billing specialized equipment maintenance to spons',
    `room_id` BIGINT COMMENT 'Reference to the specific room or space where the asset is located, supporting detailed space inventory and maintenance coordination.',
    `work_order_template_id` BIGINT COMMENT 'Reference to the standard work order template used when auto-generating work orders from this preventive maintenance schedule, ensuring consistency in task instructions and documentation.',
    `auto_generate_work_order` BOOLEAN COMMENT 'Boolean flag indicating whether Archibus should automatically generate work orders when the next due date is reached (True) or require manual work order creation (False).',
    `compliance_category` STRING COMMENT 'High-level categorization of the compliance domain this preventive maintenance schedule supports (life safety, environmental, accessibility, energy management, health/sanitation, general operations).. Valid values are `life_safety|environmental|accessibility|energy|health|general`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this preventive maintenance schedule record was first created in the system.',
    `deferred_maintenance_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether missed occurrences of this preventive maintenance schedule should be tracked as deferred maintenance (True) for capital planning and National Association of College and University Business Officers (NACUBO) reporting.',
    `downtime_required` BOOLEAN COMMENT 'Boolean flag indicating whether the preventive maintenance task requires taking the asset or system offline (True), necessitating coordination with building occupants and academic schedules.',
    `energy_impact_category` STRING COMMENT 'Classification of the preventive maintenance schedules impact on building energy efficiency and sustainability goals (high impact tasks directly affect energy consumption, low impact tasks have minimal energy implications).. Valid values are `high|medium|low|none`',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the asset or system will be unavailable during preventive maintenance, used for scheduling and impact assessment.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Estimated labor cost for each occurrence of the preventive maintenance task, calculated from estimated labor hours and trade skill rates, used for budget planning.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete the preventive maintenance task, used for resource planning and work order scheduling.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated cost of materials, parts, and supplies required for each occurrence of the preventive maintenance task, used for budget planning and deferred maintenance tracking.',
    `frequency_interval` STRING COMMENT 'Numeric multiplier for the frequency type (e.g., 2 for bi-weekly when frequency_type is weekly, 3 for quarterly when frequency_type is monthly).',
    `frequency_type` STRING COMMENT 'Recurrence interval for the preventive maintenance task (daily, weekly, monthly, quarterly, semi-annual, annual, biennial). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|biennial — 7 candidates stripped; promote to reference product]',
    `last_completed_date` DATE COMMENT 'Date when the preventive maintenance task was most recently completed, used to calculate the next due date and track schedule adherence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this preventive maintenance schedule record was most recently updated, supporting change tracking and audit compliance.',
    `lead_time_days` STRING COMMENT 'Number of days before the next due date that the system should generate the work order, allowing time for scheduling and resource allocation.',
    `next_due_date` DATE COMMENT 'Calculated date when the next occurrence of this preventive maintenance task is due, driving automatic work order generation in Archibus.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, historical context, or coordination requirements related to this preventive maintenance schedule.',
    `notification_lead_days` STRING COMMENT 'Number of days in advance that notification should be sent to affected parties before the preventive maintenance activity occurs.',
    `notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether building occupants, faculty, or students must be notified in advance of this preventive maintenance activity (True), typically for activities causing disruption or requiring access restrictions.',
    `priority_level` STRING COMMENT 'Business priority assigned to the preventive maintenance schedule, influencing work order generation sequence and resource allocation.. Valid values are `critical|high|medium|low`',
    `regulatory_standard` STRING COMMENT 'Applicable regulatory or compliance standard governing this preventive maintenance activity (e.g., NFPA 25 for fire protection systems, OSHA 1910.147 for lockout/tagout, ASHRAE 62.1 for ventilation, ADA for accessibility equipment).',
    `required_trade_skill` STRING COMMENT 'Specific trade or technical skill required to perform the maintenance task (e.g., HVAC Technician, Electrician, Plumber, Carpenter, Locksmith, Fire Safety Specialist).',
    `safety_requirements` STRING COMMENT 'Specific safety protocols, personal protective equipment (PPE), or lockout/tagout procedures required when performing this preventive maintenance task, ensuring OSHA compliance.',
    `schedule_code` STRING COMMENT 'Business identifier for the preventive maintenance schedule, typically assigned by the Archibus system or facilities management team.. Valid values are `^PM-[A-Z0-9]{6,12}$`',
    `schedule_name` STRING COMMENT 'Human-readable name or title for the preventive maintenance schedule (e.g., HVAC Filter Replacement - Monthly, Fire Alarm Inspection - Annual).',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the preventive maintenance schedule: active (generating work orders), suspended (temporarily paused), inactive (not generating work orders), pending review (awaiting approval), or retired (permanently discontinued).. Valid values are `active|suspended|inactive|pending_review|retired`',
    `schedule_type` STRING COMMENT 'Classification of the preventive maintenance schedule trigger: time-based (calendar intervals), usage-based (operating hours or cycles), condition-based (sensor thresholds), or regulatory (compliance-driven).. Valid values are `time_based|usage_based|condition_based|regulatory`',
    `seasonal_restriction` STRING COMMENT 'Scheduling constraint indicating whether this preventive maintenance task should be performed only during specific academic calendar periods (e.g., summer only, avoid finals week) to minimize disruption to teaching and research.. Valid values are `none|academic_year_only|summer_only|winter_break|spring_break|avoid_finals`',
    `task_description` STRING COMMENT 'Detailed description of the preventive maintenance task to be performed, including specific procedures, inspection points, and expected outcomes.',
    `warranty_related` BOOLEAN COMMENT 'Boolean flag indicating whether this preventive maintenance schedule is required to maintain manufacturer warranty coverage (True), ensuring compliance with warranty terms.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Defines the recurring preventive maintenance program for a specific asset or equipment item. Captures maintenance task description, frequency (daily, weekly, monthly, annual), estimated labor hours, required trade skill, applicable regulatory standard (e.g., NFPA, OSHA), last completed date, next due date, and active status. Drives automatic work order generation in Archibus and supports deferred maintenance tracking for capital planning.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`asset` (
    `asset_id` BIGINT COMMENT 'Unique identifier for the facility asset record. Primary key for the facility asset entity.',
    `building_id` BIGINT COMMENT 'Identifier of the building where the asset is physically located. Links to the building master record for space planning and Facilities and Administrative (F&A) cost allocation.',
    `employee_id` BIGINT COMMENT 'Identifier of the faculty or staff member designated as the primary custodian or responsible party for the asset. Used for accountability and communication regarding asset status.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic or administrative department responsible for the asset. Used for cost allocation and maintenance charge-back.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Research equipment assets are purchased with award funds. Property management, depreciation tracking, federal property reporting (annual equipment inventories), and disposition approvals require award',
    `room_id` BIGINT COMMENT 'Identifier of the specific room or space where the asset is located. Used for precise asset location tracking and space utilization analysis.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or acquisition cost of the asset at the time of procurement. Used for historical cost tracking and depreciation calculations. Amount in USD.',
    `acquisition_date` DATE COMMENT 'Date when the institution acquired ownership or control of the asset. May differ from installation date if asset was purchased but not immediately deployed.',
    `ada_compliant` BOOLEAN COMMENT 'Indicates whether the asset meets Americans with Disabilities Act accessibility requirements. Critical for compliance reporting and facility accessibility audits.',
    `asset_category` STRING COMMENT 'High-level classification of the facility asset type. Used for grouping assets for maintenance planning and capital renewal forecasting. [ENUM-REF-CANDIDATE: HVAC|Elevator|Boiler|Generator|Fire Suppression|Laboratory Equipment|Building Automation — 7 candidates stripped; promote to reference product]',
    `asset_name` STRING COMMENT 'Human-readable descriptive name of the facility asset. Used for identification in work orders and maintenance schedules.',
    `barcode` STRING COMMENT 'Machine-readable barcode identifier affixed to the asset for rapid scanning and inventory management. May be the same as or different from the asset tag number.',
    `condition_rating` STRING COMMENT 'Current physical and operational condition assessment of the asset. Used to prioritize maintenance and replacement decisions.. Valid values are `Excellent|Good|Fair|Poor|Critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility asset record was first created in the system. Used for data lineage and audit trail purposes.',
    `criticality_level` STRING COMMENT 'Assessment of the assets importance to institutional operations and the impact of its failure. Critical assets receive priority for maintenance and replacement.. Valid values are `Critical|High|Medium|Low`',
    `disposal_date` DATE COMMENT 'Date when the asset was removed from service and disposed of or transferred. Used for asset lifecycle tracking and capital asset reporting.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed of at end of life. Used for asset disposition tracking and sustainability reporting.. Valid values are `Sold|Scrapped|Donated|Transferred|Recycled`',
    `energy_star_certified` BOOLEAN COMMENT 'Indicates whether the asset meets Energy Star certification standards for energy efficiency. Used for sustainability reporting and energy management initiatives.',
    `expected_useful_life_years` STRING COMMENT 'Estimated number of years the asset is expected to remain in productive service under normal operating conditions. Used for capital renewal planning and depreciation schedules.',
    `floor_level` STRING COMMENT 'Floor or level designation within the building where the asset is located. Supports maintenance routing and emergency response planning.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Indicates whether the asset contains or uses hazardous materials requiring special handling, maintenance, or disposal procedures. Used for environmental health and safety compliance.',
    `installation_date` DATE COMMENT 'Date when the asset was installed and placed into service. Used to calculate asset age and plan lifecycle replacement.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent preventive or corrective maintenance was performed on the asset. Used to schedule next maintenance cycle.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility asset record was most recently modified. Used for change tracking and data quality monitoring.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the asset in its lifecycle. Indicates whether the asset is actively in use or unavailable.. Valid values are `In Service|Out of Service|Under Maintenance|Decommissioned|Pending Installation`',
    `maintenance_frequency_days` STRING COMMENT 'Number of days between scheduled preventive maintenance activities. Defines the recurring maintenance cycle for the asset.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the facility asset. Used for warranty claims and parts sourcing.',
    `model_number` STRING COMMENT 'Manufacturer-assigned model identifier for the asset. Critical for obtaining correct replacement parts and service documentation.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date when the next preventive maintenance activity is scheduled for the asset. Used for maintenance planning and resource allocation.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special handling instructions, or historical notes about the asset. Used by facilities staff for operational context.',
    `replacement_cost` DECIMAL(18,2) COMMENT 'Estimated current cost to replace the asset with a functionally equivalent unit. Used for capital renewal budgeting and insurance valuation. Amount in USD.',
    `rfid_tag` STRING COMMENT 'RFID tag identifier for automated asset tracking and location monitoring. Used in advanced asset management systems for real-time inventory visibility.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the specific asset unit. Used for warranty validation and service history tracking.',
    `service_contract_number` STRING COMMENT 'Reference number for any active maintenance or service contract covering the asset. Links to contract management system for service level agreement tracking.',
    `subcategory` STRING COMMENT 'Detailed classification within the asset category. Provides granular segmentation for specialized maintenance and compliance tracking.',
    `tag_number` STRING COMMENT 'Externally visible unique identifier assigned to the physical asset for tracking and inventory purposes. Typically affixed to the equipment as a barcode or RFID tag.. Valid values are `^[A-Z0-9]{6,20}$`',
    `vendor_name` STRING COMMENT 'Name of the vendor or supplier from whom the asset was purchased. Used for vendor performance tracking and future procurement decisions.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty coverage ends. Used to determine if repairs are covered under warranty.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Master record for a physical facility asset or piece of equipment (HVAC unit, elevator, boiler, generator, fire suppression system, laboratory fume hood, etc.). Captures asset tag number, asset category, manufacturer, model, serial number, installation date, warranty expiration, replacement cost, condition rating, location (building and room), and lifecycle status. Distinct from financial fixed assets (owned by finance domain); this is the operational facilities asset register used for maintenance planning and capital renewal forecasting.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`capital_project` (
    `capital_project_id` BIGINT COMMENT 'Unique identifier for the capital construction, renovation, or infrastructure improvement project. Primary key.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Capital projects are often built for specific academic programs (e.g., new nursing simulation center, engineering lab building). Links project justification to enrollment growth, accreditation require',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Capital projects are typically scoped to specific buildings (renovations, additions, system upgrades). The existing building_code (STRING) attribute should be replaced with a proper FK to building.bui',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capital projects are sponsored by and charged to specific departmental cost centers. Project budgeting, cost allocation, financial reporting, and budget vs. actual analysis all require linking project',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Capital projects are funded from specific funds (bond proceeds, state capital appropriations, donor gifts). Fund accounting compliance, donor restriction tracking, and bond covenant reporting all requ',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Capital projects must track which GL accounts receive capitalized costs for GASB/FASB compliance. Project closeout requires posting to specific asset accounts (buildings, equipment, construction-in-pr',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: Buildings and major facilities are frequently named for principal donors as recognition for transformational gifts. Capital project records must track naming donor for stewardship obligations, signage',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to advancement.campaign. Business justification: Major facility construction/renovation projects are typically funded through capital campaigns. Linking capital_project to campaign enables tracking campaign progress, gift counting, donor stewardship',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Capital project managers are internal employees with budget authority and accountability. Critical for project governance, financial reporting, and compliance tracking. project_manager is currently ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Capital construction projects must comply with building codes, ADA accessibility standards, environmental regulations (NEPA, wetlands), historic preservation requirements, and state construction stand',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Capital projects are frequently funded by research awards (NSF MRI, NIH equipment grants, facility improvement awards). Project accounting, financial reporting, and property management require award l',
    `actual_completion_date` DATE COMMENT 'Actual date when substantial completion was achieved and certificate of occupancy was issued. Null if project is not yet complete.',
    `actual_expenditures_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures posted to the project through the current reporting period, including all invoices paid and accruals.',
    `actual_start_date` DATE COMMENT 'Actual date when project work commenced or construction began. Null if project has not yet started.',
    `ada_compliance_required` BOOLEAN COMMENT 'Indicates whether the project includes ADA accessibility improvements or compliance upgrades required by federal law.',
    `architect_of_record` STRING COMMENT 'Name of the architectural firm serving as architect of record for the project design and construction administration.',
    `assignable_square_footage` STRING COMMENT 'Total assignable square footage (net usable space) affected by the project, measured per FICM standards for Facilities and Administrative (F&A) cost rate calculations.',
    `board_approval_date` DATE COMMENT 'Date when the Board of Trustees formally approved the project scope and budget authorization.',
    `budget_variance` DECIMAL(18,2) COMMENT 'Difference between total authorized budget and sum of actual expenditures plus current encumbrances. Positive indicates funds remaining; negative indicates overrun.',
    `certificate_of_occupancy_date` DATE COMMENT 'Date when certificate of occupancy was issued by local building authority, certifying the building is safe for occupancy.',
    `contractor_of_record` STRING COMMENT 'Name of the general contractor or construction manager responsible for project execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was first created in the system.',
    `current_encumbrance` DECIMAL(18,2) COMMENT 'Total amount currently encumbered through purchase orders, contracts, and commitments against the project budget.',
    `design_approval_date` DATE COMMENT 'Date when final design documents were approved by institutional stakeholders and state oversight agencies (if applicable).',
    `final_closeout_date` DATE COMMENT 'Date when all punch list items were completed, final payment was made, and project was administratively closed.',
    `gross_square_footage` STRING COMMENT 'Total gross square footage of building space affected by the project, measured per ANSI/BOMA standards.',
    `groundbreaking_date` DATE COMMENT 'Date of official groundbreaking ceremony or commencement of site work.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was last modified, reflecting the most recent status, budget, or schedule update.',
    `leed_certification_target` STRING COMMENT 'Target LEED certification level for the project: not applicable, certified, silver, gold, or platinum.. Valid values are `not_applicable|certified|silver|gold|platinum`',
    `permit_issuance_date` DATE COMMENT 'Date when building permit was issued by local jurisdiction, authorizing construction to commence.',
    `planned_completion_date` DATE COMMENT 'Originally planned date for substantial completion and occupancy as approved in the project charter.',
    `planned_start_date` DATE COMMENT 'Originally planned date for project initiation or construction commencement as approved in the project charter.',
    `project_name` STRING COMMENT 'Human-readable name of the capital project (e.g., Engineering Building Renovation, Campus Chiller Plant Upgrade).',
    `project_number` STRING COMMENT 'Externally-known unique business identifier for the capital project, used in Board of Trustees reporting and state facilities oversight communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `project_phase` STRING COMMENT 'Current lifecycle phase of the capital project: planning, design, permitting, procurement, construction, closeout, completed, or cancelled. [ENUM-REF-CANDIDATE: planning|design|permitting|procurement|construction|closeout|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `project_priority` STRING COMMENT 'Institutional priority ranking for the project: critical (life safety or regulatory compliance), high (strategic initiative), medium (planned improvement), or low (deferred maintenance).. Valid values are `critical|high|medium|low`',
    `project_status` STRING COMMENT 'Current operational status of the capital project indicating health and progress: active, on hold, delayed, at risk, completed, or cancelled.. Valid values are `active|on_hold|delayed|at_risk|completed|cancelled`',
    `project_type` STRING COMMENT 'Classification of the capital project by nature of work: new construction, major renovation, deferred maintenance, infrastructure upgrade, demolition, or site improvement.. Valid values are `new_construction|major_renovation|deferred_maintenance|infrastructure_upgrade|demolition|site_improvement`',
    `projected_completion_date` DATE COMMENT 'Current forecast completion date based on actual progress, schedule changes, and known delays. Updated regularly during construction.',
    `risk_level` STRING COMMENT 'Overall risk assessment for the project based on complexity, budget, schedule, and stakeholder impact: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `schedule_variance_days` STRING COMMENT 'Number of days the project is ahead (negative) or behind (positive) the planned completion date. Calculated as projected or actual completion date minus planned completion date.',
    `scope_description` STRING COMMENT 'Detailed narrative description of the project scope, deliverables, and objectives. Includes square footage, building systems affected, and functional improvements.',
    `state_approval_date` DATE COMMENT 'Date when state facilities oversight agency approved the project (applicable for public institutions with state capital project approval requirements).',
    `substantial_completion_date` DATE COMMENT 'Date when the work reached substantial completion per AIA contract terms, allowing occupancy and use.',
    `sustainability_features` STRING COMMENT 'Narrative description of sustainability and energy efficiency features incorporated into the project design (e.g., geothermal HVAC, solar panels, green roof, rainwater harvesting).',
    `total_authorized_budget` DECIMAL(18,2) COMMENT 'Total budget amount authorized by the Board of Trustees or state oversight agency for the capital project, including all phases and contingencies.',
    `variance_notes` STRING COMMENT 'Narrative explanation of significant budget or schedule variances, including root causes, corrective actions, and impact assessments.',
    CONSTRAINT pk_capital_project PRIMARY KEY(`capital_project_id`)
) COMMENT 'Master record for a capital construction, renovation, or infrastructure improvement project including milestone and phase tracking. Captures project number, project name, project type (new construction, major renovation, deferred maintenance, infrastructure upgrade), scope description, funding source, total authorized budget, current encumbrance, actual expenditures to date, project phase (planning, design, construction, closeout), architect/contractor of record, projected and actual completion dates. Tracks individual milestones and phase gates (design approval, permit issuance, groundbreaking, substantial completion, certificate of occupancy, final closeout) with planned vs actual dates and variance notes. Managed in Archibus capital projects module and linked to PeopleSoft Financials for budget control. Supports project schedule reporting to the Board of Trustees and state facilities oversight agencies.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`space_utilization_survey` (
    `space_utilization_survey_id` BIGINT COMMENT 'Unique identifier for the space utilization survey record. Primary key for the survey instance.',
    `building_id` BIGINT COMMENT 'Reference to the building containing the surveyed space. Used for aggregation and reporting at the building level.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic or administrative department that has primary responsibility for the space during the survey period. Used for cost allocation and chargeback.',
    `employee_id` BIGINT COMMENT 'Reference to the faculty or staff member who is the primary occupant or responsible party for the space during the survey period. Used for detailed space assignment tracking.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Space utilization surveys allocate room usage percentages to specific awards for F&A rate calculations. Federal cost accounting (OMB Uniform Guidance) requires award-level space attribution for organi',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the staff member who reviewed and validated the survey data. Required for compliance with institutional quality assurance procedures.',
    `room_id` BIGINT COMMENT 'Reference to the specific room or space being surveyed. Links to the room inventory in the facilities management system.',
    `survey_period_id` BIGINT COMMENT 'Reference to the survey period during which this observation was recorded. Typically corresponds to an academic term or fiscal year.',
    `academic_term` STRING COMMENT 'The academic term during which the survey was conducted. Used to align space utilization data with instructional activity patterns.. Valid values are `fall|spring|summer|winter|full_year`',
    `approved_date` DATE COMMENT 'The date when the survey data was approved for submission to federal agencies. Final step in the internal review process.',
    `confidence_level` STRING COMMENT 'The surveyors assessment of the confidence level in the accuracy of the utilization data. Based on sample size, data quality, and observation conditions.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this survey record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_source` STRING COMMENT 'The source of the space utilization data. Indicates whether the data was collected through direct observation, departmental reporting, automated systems, or other methods.. Valid values are `direct_observation|department_report|class_schedule|card_access|sensor_data|manual_entry`',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this survey record contains exceptions or anomalies that require special review or explanation. Used to flag unusual utilization patterns for audit purposes.',
    `exception_reason` STRING COMMENT 'Explanation of the exception or anomaly flagged in this survey record. Required when exception_flag is true.',
    `federal_agency_submitted` STRING COMMENT 'The federal agency to which this survey data was submitted as part of the F&A rate negotiation package. Multiple agencies may receive the same data. [ENUM-REF-CANDIDATE: NSF|NIH|DOE|DOD|NASA|USDA|ED|HHS|not_submitted — 9 candidates stripped; promote to reference product]',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this survey data applies. Used for multi-year trend analysis and F&A rate calculation periods.',
    `instruction_percentage` DECIMAL(18,2) COMMENT 'Percentage of time the space was used for instruction activities during the survey period. Includes classroom teaching, laboratory instruction, and direct student contact. Used for F&A rate allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this survey record was last updated. Used for audit trail and change tracking.',
    `observation_date` DATE COMMENT 'The specific date when the space utilization observation was recorded. Used for detailed time-series analysis within the survey period.',
    `organized_research_percentage` DECIMAL(18,2) COMMENT 'Percentage of time the space was used for organized research activities during the survey period. Includes sponsored research projects, departmental research, and research centers. Critical for F&A rate calculations.',
    `other_institutional_activities_percentage` DECIMAL(18,2) COMMENT 'Percentage of time the space was used for other institutional activities not classified in the above categories. Includes general administration, student services, and auxiliary operations.',
    `other_sponsored_activities_percentage` DECIMAL(18,2) COMMENT 'Percentage of time the space was used for other sponsored activities during the survey period. Includes sponsored training programs, public service projects, and other externally funded activities that are not research or instruction.',
    `reviewed_date` DATE COMMENT 'The date when the survey data was reviewed and validated by the reviewer. Part of the quality assurance workflow.',
    `room_use_classification` STRING COMMENT 'The functional classification of the room during the survey period based on predominant activity. Aligns with NACUBO and IPEDS space reporting categories for F&A rate calculations. [ENUM-REF-CANDIDATE: instruction|research|other_sponsored|public_service|academic_support|student_services|institutional_support|operation_maintenance|auxiliary|hospital|independent_operations|unassigned — 12 candidates stripped; promote to reference product]',
    `sample_size` STRING COMMENT 'The number of observations or data points collected for this space during the survey period. Used to assess the statistical validity of the utilization percentages.',
    `square_footage_surveyed` DECIMAL(18,2) COMMENT 'The net assignable square footage of the space covered by this survey record. Used for space utilization rate calculations and F&A cost allocation.',
    `submission_date` DATE COMMENT 'The date when the survey data was submitted to the federal agency for F&A rate negotiation. Used for compliance tracking and audit trail.',
    `survey_end_date` DATE COMMENT 'The date when the survey period ended. Used to define the observation window for space utilization analysis.',
    `survey_methodology` STRING COMMENT 'The methodology used to conduct the space utilization survey. Actual Use: direct observation and documentation; Modified Traditional: simplified sampling approach; Simplified: basic classification; Detailed Analysis: comprehensive time-motion study.. Valid values are `actual_use|modified_traditional|simplified|detailed_analysis`',
    `survey_notes` STRING COMMENT 'Free-text notes and observations recorded by the surveyor during the space utilization survey. Captures contextual information, exceptions, and special circumstances.',
    `survey_number` STRING COMMENT 'Business identifier for the survey record. Format: SUS-YYYY-NNNNNN where YYYY is the fiscal year and NNNNNN is a sequential number.. Valid values are `^SUS-[0-9]{4}-[0-9]{6}$`',
    `survey_start_date` DATE COMMENT 'The date when the survey period began. Typically aligns with the start of an academic term or fiscal year for consistency in F&A rate calculations.',
    `survey_status` STRING COMMENT 'Current workflow status of the survey record. Tracks the survey through data collection, review, approval, and submission to federal agencies for F&A rate negotiation.. Valid values are `draft|in_progress|completed|reviewed|approved|submitted`',
    `unallowable_activities_percentage` DECIMAL(18,2) COMMENT 'Percentage of time the space was used for activities that are unallowable for F&A cost recovery under federal regulations. Includes fundraising, lobbying, entertainment, and certain administrative functions.',
    `vacant_percentage` DECIMAL(18,2) COMMENT 'Percentage of time the space was vacant or unused during the survey period. Used to assess space efficiency and utilization rates.',
    CONSTRAINT pk_space_utilization_survey PRIMARY KEY(`space_utilization_survey_id`)
) COMMENT 'Records the results of periodic space utilization surveys conducted for F&A indirect cost rate calculations and accreditation space reporting. Captures survey period, survey methodology (actual use, modified traditional, simplified), room use classification during the survey period, percentage of time used for instruction, research, other sponsored activities, and unallowable activities. Required for OMB Uniform Guidance (2 CFR 200) F&A rate negotiations with federal agencies (NSF, NIH, DOE).';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`utility_meter` (
    `utility_meter_id` BIGINT COMMENT 'Unique identifier for the utility meter. Primary key for the utility meter entity.',
    `building_id` BIGINT COMMENT 'Reference to the building or facility where this meter is installed. Links meter to physical campus location for space planning and cost allocation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Utility meters need structured cost_center link for utility cost allocation, energy management reporting, and departmental chargeback billing. Replacing cost_center text field with proper FK enables a',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Utility meters support compliance with EPA greenhouse gas reporting requirements, state energy efficiency mandates, and federal energy management regulations (EISA, EO 13834). Sustainability offices t',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Utility meter readings must post to specific GL accounts (electricity expense, natural gas, water/sewer) for financial reporting and budget tracking. Structured ledger_account link enables automated j',
    `ada_accessible_flag` BOOLEAN COMMENT 'Indicates whether the physical meter location is accessible for reading and maintenance by personnel with disabilities. Used for ADA compliance tracking and maintenance planning.',
    `baseline_consumption` DECIMAL(18,2) COMMENT 'Historical baseline consumption value used as reference point for energy conservation goal tracking and performance measurement. Typically represents average annual consumption during a baseline year.',
    `baseline_year` STRING COMMENT 'Calendar year used to establish baseline consumption for energy conservation goal tracking. Common baseline years align with institutional sustainability commitments or regulatory requirements.',
    `billing_account_number` STRING COMMENT 'Account number assigned by the utility provider for billing purposes. Used to reconcile meter readings with utility invoices and allocate costs to departments or grants.',
    `communication_protocol` STRING COMMENT 'Technical protocol used for automated meter data transmission (e.g., Modbus, BACnet, LonWorks, cellular). Relevant for AMR/AMI meters integrated with building management or energy management systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter record was first created in the system. Used for data lineage, audit trails, and record lifecycle tracking.',
    `data_source` STRING COMMENT 'Method by which meter readings are captured. AMR (Automatic Meter Reading) and AMI (Advanced Metering Infrastructure) indicate automated collection; manual indicates physical inspection; BMS (Building Management System) indicates integration with building controls.. Valid values are `manual_read|AMR|AMI|BMS|utility_bill|estimated`',
    `decommission_date` DATE COMMENT 'Date when the meter was removed from service or deactivated. Marks the end of the meters operational lifecycle for historical reporting.',
    `department_code` STRING COMMENT 'Primary academic or administrative department responsible for the space served by this meter. Used for utility cost allocation and departmental chargeback in Facilities and Administrative (F&A) cost calculations.',
    `emission_factor` DECIMAL(18,2) COMMENT 'Carbon dioxide equivalent (CO2e) emission factor per unit of consumption for this meter type and utility source. Used to convert consumption data to greenhouse gas emissions for sustainability reporting. Units vary by meter type (e.g., kg CO2e per kWh for electricity).',
    `energy_star_eligible_flag` BOOLEAN COMMENT 'Indicates whether this meters data is included in ENERGY STAR Portfolio Manager benchmarking submissions. True for meters serving buildings tracked for sustainability reporting and certification.',
    `grant_eligible_flag` BOOLEAN COMMENT 'Indicates whether utility costs from this meter can be allocated to sponsored research grants as Facilities and Administrative (F&A) costs. True if meter serves research space included in F&A rate calculation.',
    `greenhouse_gas_scope` STRING COMMENT 'Classification of greenhouse gas emissions associated with this meter under GHG Protocol standards. Scope 1 (direct emissions from owned sources), Scope 2 (indirect emissions from purchased energy), Scope 3 (other indirect emissions). Used for carbon footprint reporting and climate action plan tracking.. Valid values are `scope_1|scope_2|scope_3|not_applicable`',
    `installation_date` DATE COMMENT 'Date when the meter was physically installed and commissioned. Used for warranty tracking, calibration scheduling, and lifecycle management.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the meter device for automated data collection. Used for AMI meters connected to campus network infrastructure.',
    `last_calibration_date` DATE COMMENT 'Date when the meter was last calibrated or tested for accuracy. Used to ensure data quality and compliance with utility billing accuracy requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter record was most recently modified. Used for change tracking, data quality monitoring, and synchronization with source systems.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the meter location in decimal degrees. Used for GIS mapping, spatial analysis of utility infrastructure, and mobile work order routing.',
    `location_description` STRING COMMENT 'Detailed physical location description for the meter (e.g., Basement mechanical room, north wall, Exterior east side near loading dock). Used by facilities staff to locate meter for reading, maintenance, or emergency response.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the meter location in decimal degrees. Used for GIS mapping, spatial analysis of utility infrastructure, and mobile work order routing.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the meter device. Used for warranty tracking, maintenance scheduling, and replacement part sourcing.',
    `meter_multiplier` DECIMAL(18,2) COMMENT 'Conversion factor applied to raw meter readings to calculate actual consumption. Common for high-capacity electric meters with current transformers (CT) or potential transformers (PT).',
    `meter_name` STRING COMMENT 'Human-readable name or label for the meter, typically indicating location or purpose (e.g., Science Building Main Electric, Residence Hall A Chilled Water).',
    `meter_number` STRING COMMENT 'External identifier or serial number assigned by the utility provider or manufacturer. Used for utility billing reconciliation and vendor communication.',
    `meter_status` STRING COMMENT 'Current operational status of the meter. Determines whether readings are expected and whether meter data should be included in consumption reporting.. Valid values are `active|inactive|decommissioned|maintenance|pending_installation`',
    `meter_type` STRING COMMENT 'Classification of the utility being metered. Determines unit of measure, billing structure, and sustainability reporting category. [ENUM-REF-CANDIDATE: electric|natural_gas|steam|chilled_water|domestic_water|reclaimed_water|sewer|fuel_oil — 8 candidates stripped; promote to reference product]',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the meter device. Used for technical specifications lookup, calibration procedures, and replacement planning.',
    `next_calibration_date` DATE COMMENT 'Scheduled date for the next meter calibration or accuracy test. Used for preventive maintenance planning and data quality assurance.',
    `notes` STRING COMMENT 'Free-form text field for additional information about the meter, including special reading instructions, known issues, maintenance history, or operational context not captured in structured fields.',
    `reading_frequency` STRING COMMENT 'Expected interval at which consumption readings are captured. Determines data granularity for energy management analysis and billing cycle alignment. [ENUM-REF-CANDIDATE: real_time|hourly|daily|weekly|monthly|quarterly|annual — 7 candidates stripped; promote to reference product]',
    `target_reduction_percentage` DECIMAL(18,2) COMMENT 'Percentage reduction goal for this meters consumption relative to baseline. Used to track progress toward institutional energy conservation and carbon neutrality commitments.',
    `unit_of_measure` STRING COMMENT 'Standard unit used to quantify consumption readings for this meter type. Determines how consumption data is aggregated and reported for sustainability and cost analysis. [ENUM-REF-CANDIDATE: kWh|therms|ccf|gallons|ton_hours|pounds|mmbtu — 7 candidates stripped; promote to reference product]',
    `utility_provider` STRING COMMENT 'Name of the external utility company or internal utility plant that supplies the metered resource. Used for vendor management and billing reconciliation.',
    `zone_code` STRING COMMENT 'Campus zone or district identifier for grouping meters by geographic area, utility distribution system, or cost allocation boundary. Supports zone-level energy analysis and chargeback.',
    CONSTRAINT pk_utility_meter PRIMARY KEY(`utility_meter_id`)
) COMMENT 'Master record for a utility metering point on campus, including time-series consumption readings and billing data. Captures meter identifier, meter type (electric, natural gas, steam, chilled water, domestic water, reclaimed water), associated building or zone, meter manufacturer and model, installation date, billing account number, and active status. Also tracks periodic consumption readings including start/end dates, quantity and unit of measure (kWh, therms, gallons, ton-hours), demand peaks, period costs, and data source (manual read, AMR/AMI automated). Foundation for energy management, ENERGY STAR benchmarking, greenhouse gas emissions reporting, sustainability goal tracking, and utility cost allocation to departments and research grants.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`accessibility_feature` (
    `accessibility_feature_id` BIGINT COMMENT 'Primary key for accessibility_feature',
    `ada_accommodation_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_accommodation. Business justification: When ADA accommodations are approved for students or employees, specific physical features must be installed or modified (ramps, elevators, assistive technology). Disability services offices track whi',
    `building_id` BIGINT COMMENT 'Identifier of the building where this accessibility feature is located. Links to the building master data in Archibus.',
    `capital_project_id` BIGINT COMMENT 'Identifier of the capital project funding the installation or remediation of this accessibility feature.',
    `employee_id` BIGINT COMMENT 'Identifier of the facilities manager responsible for maintaining this accessibility feature and ensuring ongoing compliance.',
    `room_id` BIGINT COMMENT 'Identifier of the specific room where this accessibility feature is located. Nullable for building-level features such as accessible entrances or elevators.',
    `work_order_id` BIGINT COMMENT 'Identifier of the active or most recent work order associated with maintenance or remediation of this feature.',
    `actual_remediation_cost` DECIMAL(18,2) COMMENT 'Actual cost in USD incurred for remediation work. Populated after remediation project completion.',
    `ada_coordinator_notes` STRING COMMENT 'Free-text notes from the institutional ADA coordinator regarding this feature, including special considerations or historical context.',
    `alternative_accommodation_available` BOOLEAN COMMENT 'Indicates whether an alternative accessibility accommodation is available if this feature is non-compliant or out of service (True/False).',
    `alternative_accommodation_description` STRING COMMENT 'Description of the alternative accessibility accommodation available when this feature is unavailable.',
    `compliance_standard` STRING COMMENT 'Specific ADA standard section or institutional policy that this feature must comply with (e.g., ADA 2010 Section 206.4).',
    `compliance_status` STRING COMMENT 'Current compliance status of the accessibility feature relative to ADA standards and institutional accessibility policies.. Valid values are `compliant|non-compliant|remediation-planned|remediation-in-progress|partially-compliant|not-applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accessibility feature record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the accessibility feature was decommissioned or removed from service. Null if feature is still active.',
    `decommission_reason` STRING COMMENT 'Explanation for why the accessibility feature was decommissioned (e.g., building renovation, feature replacement, space repurposing).',
    `deficiency_description` STRING COMMENT 'Detailed description of any compliance deficiencies or barriers identified during inspection. Null if feature is fully compliant.',
    `estimated_remediation_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD to remediate the accessibility feature and bring it into full compliance with ADA standards.',
    `feature_code` STRING COMMENT 'Standardized code identifying the type of accessibility feature. Used for reporting and compliance tracking.. Valid values are `^[A-Z]{3,10}$`',
    `feature_description` STRING COMMENT 'Detailed description of the accessibility feature including specifications, location details, and any special characteristics.',
    `feature_name` STRING COMMENT 'Descriptive name of the accessibility feature for identification and reporting purposes.',
    `feature_type` STRING COMMENT 'Classification of the accessibility feature type. Defines the specific accommodation provided to support individuals with disabilities. [ENUM-REF-CANDIDATE: accessible-entrance|elevator|accessible-restroom|hearing-loop|tactile-signage|accessible-parking|ramp|wheelchair-lift|automatic-door|braille-signage|visual-alarm — 11 candidates stripped; promote to reference product]',
    `funding_source` STRING COMMENT 'Source of funding for the accessibility feature installation or remediation (e.g., institutional capital budget, federal grant, state allocation).',
    `inspection_frequency_months` STRING COMMENT 'Required frequency in months between compliance inspections for this accessibility feature type.',
    `inspector_name` STRING COMMENT 'Name of the individual or organization that conducted the last compliance inspection.',
    `installation_date` DATE COMMENT 'Date when the accessibility feature was originally installed or constructed.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the accessibility feature is currently active and available for use (True) or decommissioned/out-of-service (False).',
    `is_temporary` BOOLEAN COMMENT 'Indicates whether this is a temporary accessibility accommodation (True) or a permanent installation (False).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection or assessment of this accessibility feature.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accessibility feature record was last updated in the system.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this accessibility feature record.',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next compliance inspection or assessment of this accessibility feature.',
    `public_notice_required` BOOLEAN COMMENT 'Indicates whether public notice is required when this feature is out of service or undergoing remediation (True/False).',
    `remediation_completion_date` DATE COMMENT 'Date when remediation work was completed and the feature was brought into compliance.',
    `remediation_plan_description` STRING COMMENT 'Detailed description of the planned remediation actions to bring the feature into compliance.',
    `remediation_priority` STRING COMMENT 'Priority level assigned for remediation of non-compliant features based on severity, usage, and institutional risk assessment.. Valid values are `critical|high|medium|low|deferred`',
    `remediation_start_date` DATE COMMENT 'Date when remediation work began or is scheduled to begin.',
    `report_date` DATE COMMENT 'Date when a compliance deficiency or accessibility barrier was reported by a user or identified during inspection.',
    `reported_by_user` STRING COMMENT 'Name or identifier of the individual who reported a deficiency or requested this accessibility feature. Used for grievance tracking.',
    `usage_count` STRING COMMENT 'Estimated or measured count of individuals using this accessibility feature per day or per semester. Used for prioritization and impact assessment.',
    CONSTRAINT pk_accessibility_feature PRIMARY KEY(`accessibility_feature_id`)
) COMMENT 'Tracks ADA (Americans with Disabilities Act) accessibility features and compliance status for individual rooms and buildings. Captures feature type (accessible entrance, elevator, accessible restroom, hearing loop, tactile signage, accessible parking, ramp), compliance status (compliant, non-compliant, remediation-planned), last inspection date, remediation priority, estimated remediation cost, and responsible facilities manager. Supports ADA transition plan management and compliance reporting to the Office for Civil Rights.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`lease_agreement` (
    `lease_agreement_id` BIGINT COMMENT 'Unique identifier for the lease agreement record. Primary key for the lease agreement entity.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Lease agreements where the institution is the lessor (leasing out space to external parties) often involve campus buildings. Adding building_id FK (nullable) links these agreements to the building mas',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lease agreements require cost_center link for GASB 87 lease accounting, departmental space cost allocation, and budget tracking. The cost center is responsible for funding the leased space and must be',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Lease agreements need structured fund link for fund accounting compliance and restricted fund management. Replacing fund_code text field with proper FK ensures lease obligations are tracked against co',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Lease agreements require structured ledger_account link for GASB 87 compliance (right-of-use assets, lease liabilities) and lease payment accounting. Replacing gl_account_code text field with proper F',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Leased facilities must meet institutional compliance standards (ADA accessibility, fire safety codes, environmental health standards) before occupancy. Real estate and compliance offices track which r',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the leased property meets ADA accessibility requirements. Critical for compliance with federal disability access regulations.',
    `annual_base_rent` DECIMAL(18,2) COMMENT 'Annual base rent payment amount specified in the lease agreement, excluding variable costs such as utilities, maintenance, or percentage rent. Used for budgeting and GASB 87 lease liability calculation.',
    `commencement_date` DATE COMMENT 'Date when the lease term begins and the lessee gains the right to use the leased asset. Used to calculate lease liability and right-of-use asset under GASB 87.',
    `counterparty_contact_name` STRING COMMENT 'Primary contact person at the counterparty organization for lease administration and communication.',
    `counterparty_email` STRING COMMENT 'Primary email address for counterparty contact regarding lease matters.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `counterparty_name` STRING COMMENT 'Legal name of the other party to the lease agreement. If institution is lessee, this is the landlord/lessor; if institution is lessor, this is the tenant/lessee.',
    `counterparty_phone` STRING COMMENT 'Primary phone number for counterparty contact regarding lease matters.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lease agreement record was first created in the system. Used for audit trail and data lineage.',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'Interest rate used to calculate the present value of lease payments for GASB 87 lease liability. Typically the rate implicit in the lease or the institutions incremental borrowing rate.',
    `escalation_rate_percent` DECIMAL(18,2) COMMENT 'Annual percentage increase applied to base rent if escalation type is fixed percentage. Used to project future lease payments for GASB 87 liability calculation.',
    `escalation_type` STRING COMMENT 'Method by which lease payments increase over the lease term. Fixed percentage applies a set annual increase; CPI-indexed ties increases to Consumer Price Index; fair market value resets to market rates at specified intervals.. Valid values are `fixed_percentage|cpi_indexed|fair_market_value|none`',
    `expiration_date` DATE COMMENT 'Date when the lease term ends unless renewed or extended. Used to calculate lease term and determine lease classification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the lease agreement record was last updated. Used for audit trail and change tracking.',
    `lease_liability_value` DECIMAL(18,2) COMMENT 'Present value of future lease payments over the lease term, discounted using the rate the lessor charges the lessee or the institutions incremental borrowing rate. Required for GASB 87 financial statement reporting.',
    `lease_number` STRING COMMENT 'Externally-known business identifier for the lease agreement. Used for reference in contracts, invoices, and financial reporting.',
    `lease_status` STRING COMMENT 'Current lifecycle status of the lease agreement. Tracks progression from draft through active operation to termination or renewal.. Valid values are `draft|active|expired|terminated|renewed|pending_approval`',
    `lease_term_months` STRING COMMENT 'Total duration of the lease agreement in months, including any reasonably certain renewal periods. Used for GASB 87 lease liability calculation.',
    `lease_type` STRING COMMENT 'Classification of the lease agreement according to accounting standards. Operating leases are rental arrangements; finance/capital leases transfer substantially all risks and rewards of ownership.. Valid values are `operating|finance|capital|short_term|sublease`',
    `leased_square_footage` DECIMAL(18,2) COMMENT 'Total square footage of space covered by the lease agreement. Critical for space inventory reporting to IPEDS and Facilities and Administrative (F&A) cost rate calculations.',
    `lessor_lessee_indicator` STRING COMMENT 'Indicates whether the institution is the lessor (property owner leasing to others) or lessee (tenant leasing from others). Critical for determining accounting treatment and financial statement presentation.. Valid values are `lessor|lessee`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the person who last modified the lease agreement record. Used for audit trail and accountability.',
    `payment_frequency` STRING COMMENT 'Frequency of lease payment obligations (monthly, quarterly, etc.). Used for cash flow planning and accounts payable scheduling.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `permitted_use` STRING COMMENT 'Contractual description of the allowed uses of the leased property as specified in the lease agreement. May include restrictions on activities, hours of operation, or modifications.',
    `property_address_line1` STRING COMMENT 'Street address of the leased property.',
    `property_address_line2` STRING COMMENT 'Additional address information for the leased property (suite, floor, building number).',
    `property_city` STRING COMMENT 'City where the leased property is located.',
    `property_country_code` STRING COMMENT 'Three-letter ISO country code for the leased property location.. Valid values are `^[A-Z]{3}$`',
    `property_description` STRING COMMENT 'Detailed description of the leased property including building name, address, and specific spaces covered by the lease (e.g., floors, suites, rooms).',
    `property_postal_code` STRING COMMENT 'Postal or ZIP code for the leased property location.',
    `property_state_province` STRING COMMENT 'State or province where the leased property is located.',
    `renewal_option_count` STRING COMMENT 'Number of renewal periods available under the lease agreement. Used to assess whether renewal options are reasonably certain to be exercised for GASB 87 lease term determination.',
    `renewal_option_term_months` STRING COMMENT 'Duration in months of each renewal option period. Used to calculate extended lease term if renewal is reasonably certain.',
    `responsible_department` STRING COMMENT 'Academic or administrative department responsible for the leased space and associated lease payments. Used for cost allocation and budget management.',
    `right_of_use_asset_value` DECIMAL(18,2) COMMENT 'Initial measurement of the right-of-use asset under GASB 87, calculated as the initial lease liability plus any payments made before commencement, initial direct costs, and less any lease incentives received. Reported on the statement of net position.',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Amount of security deposit paid or received under the lease agreement. Recorded as an asset (if lessee) or liability (if lessor) on the balance sheet.',
    `space_use_category` STRING COMMENT 'Functional classification of the leased space according to institutional space planning standards. Used for IPEDS reporting and F&A cost allocation. [ENUM-REF-CANDIDATE: classroom|laboratory|office|research|residential|athletic|library|other — 8 candidates stripped; promote to reference product]',
    `termination_option_flag` BOOLEAN COMMENT 'Indicates whether the lease agreement includes an early termination option. Affects lease term determination under GASB 87.',
    `termination_penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty for early termination of the lease if termination option exists. Used to assess likelihood of exercising termination option.',
    `variable_payment_description` STRING COMMENT 'Description of any variable lease payments not included in the lease liability calculation, such as payments based on usage, performance, or index changes beyond the initial measurement.',
    CONSTRAINT pk_lease_agreement PRIMARY KEY(`lease_agreement_id`)
) COMMENT 'Master record for real property leases where the institution is either lessor or lessee. Captures lease number, property description, counterparty name, lease type (operating, finance/capital), leased square footage, annual base rent, escalation terms, lease commencement and expiration dates, renewal options, permitted use, and GASB 87 right-of-use asset and lease liability values. Supports GASB 87 financial reporting compliance and space inventory for IPEDS.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`inspection` (
    `inspection_id` BIGINT COMMENT 'Unique identifier for the facility inspection record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Facility inspections (fire marshal, environmental health, accreditation site visits) generate findings that become formal audit findings requiring corrective action plans. Compliance offices track whi',
    `building_id` BIGINT COMMENT 'Reference to the building that was inspected. Links to the building master data in the facility domain.',
    `room_id` BIGINT COMMENT 'Reference to the specific room or space that was inspected, if applicable. Null for building-level or system-level inspections.',
    `work_order_id` BIGINT COMMENT 'Reference to the corrective maintenance work order generated as a result of this inspection, if applicable.',
    `accreditation_relevant_flag` BOOLEAN COMMENT 'Indicates whether this inspection data is required for institutional or programmatic accreditation self-studies and site visits.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the inspected space or facility meets ADA accessibility standards. Critical for Title II compliance reporting.',
    `compliance_standard` STRING COMMENT 'Specific code, standard, or regulation against which the inspection was conducted (e.g., NFPA 101 Life Safety Code, OSHA 1910.1450 Laboratory Standard, ADA Standards for Accessible Design).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system. Audit trail field.',
    `critical_deficiency_count` STRING COMMENT 'Number of deficiencies rated as critical or life-safety issues requiring immediate remediation.',
    `deficiency_count` STRING COMMENT 'Total number of deficiency findings identified during this inspection. Used for trend analysis and capital planning prioritization.',
    `environmental_health_compliant_flag` BOOLEAN COMMENT 'Indicates whether the inspected space meets environmental health and safety standards (ventilation, chemical storage, waste disposal, air quality).',
    `estimated_renewal_cost` DECIMAL(18,2) COMMENT 'Total estimated cost in USD to remediate all deficiencies identified in this inspection. Aggregated from individual deficiency cost estimates. Used for capital budget requests and deferred maintenance reporting.',
    `fci_score` DECIMAL(18,2) COMMENT 'Calculated ratio of deferred maintenance cost to current replacement value for the inspected asset. Lower scores indicate better condition. Industry benchmark metric for accreditation self-studies.',
    `follow_up_due_date` DATE COMMENT 'Deadline by which required follow-up actions must be completed. Typically driven by regulatory timelines for critical deficiencies.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether follow-up actions, re-inspection, or corrective work orders are required as a result of this inspection.',
    `frequency_months` STRING COMMENT 'Required interval in months between inspections of this type, as mandated by regulatory authority or institutional policy.',
    `funding_source` STRING COMMENT 'Identified source of funding for remediation of deficiencies (e.g., capital budget, deferred maintenance fund, grant, insurance claim, departmental budget).',
    `funding_status` STRING COMMENT 'Current status of funding allocation for remediation work identified in this inspection.. Valid values are `funded|pending_approval|unfunded|deferred`',
    `inspection_date` DATE COMMENT 'The date on which the inspection was conducted. This is the principal business event timestamp for the inspection transaction.',
    `inspection_number` STRING COMMENT 'Externally-visible unique business identifier for the inspection, typically formatted as INS-YYYYMMDD or similar institutional convention.. Valid values are `^INS-[0-9]{8}$`',
    `inspection_scope` STRING COMMENT 'Detailed description of what systems, areas, or components were included in the inspection. Defines the boundaries of the inspection effort.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection. Tracks progression from scheduling through completion or cancellation.. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `inspection_type` STRING COMMENT 'Category of inspection performed. Determines the regulatory framework, inspection protocol, and required credentials for the inspector. [ENUM-REF-CANDIDATE: fire_safety|elevator|boiler|environmental_health|ada_compliance|general_condition|laboratory_safety|hvac_system|electrical_system|plumbing_system — 10 candidates stripped; promote to reference product]',
    `inspector_credentials` STRING COMMENT 'Professional certifications, licenses, or qualifications held by the inspector (e.g., Certified Fire Inspector, PE license, APPA Certified Educational Facilities Professional).',
    `inspector_name` STRING COMMENT 'Full name of the individual who conducted the inspection. May be internal facilities staff or external certified inspector.',
    `inspector_organization` STRING COMMENT 'Name of the organization or company employing the inspector. May be the institution itself or an external inspection firm.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was most recently updated. Audit trail field.',
    `life_safety_compliant_flag` BOOLEAN COMMENT 'Indicates whether the inspected facility meets life safety code requirements (fire exits, sprinklers, alarms, emergency lighting).',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this inspection record. Audit trail field.',
    `next_inspection_due_date` DATE COMMENT 'The date by which the next inspection of this type must be completed to maintain regulatory compliance. Calculated based on inspection frequency requirements.',
    `notes` STRING COMMENT 'Free-text field for inspector observations, contextual information, or additional comments not captured in structured deficiency records.',
    `overall_rating` STRING COMMENT 'Summary assessment of the inspected facility, system, or space. Used to calculate Facilities Condition Index (FCI) for APPA benchmarking.. Valid values are `excellent|good|fair|poor|critical`',
    `pass_fail_determination` STRING COMMENT 'Binary or conditional outcome indicating whether the inspected entity met the required standards. Critical for regulatory compliance reporting.. Valid values are `pass|fail|conditional_pass`',
    `recommended_remediation_year` STRING COMMENT 'Fiscal year in which remediation of identified deficiencies is recommended to occur, based on severity and capital planning priorities.',
    `regulatory_authority` STRING COMMENT 'Name of the governing body or regulatory agency requiring this inspection (e.g., State Fire Marshal, OSHA, Local Building Department, Environmental Health Department).',
    `report_url` STRING COMMENT 'Link to the full inspection report document stored in the institutional document management system or Archibus document repository.',
    `scheduled_date` DATE COMMENT 'The date on which the inspection was originally scheduled to occur. May differ from actual inspection_date if rescheduled.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of inspection, relevant for exterior building envelope and roofing inspections.',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Transactional record of formal inspections of buildings, rooms, systems, or assets, including resulting deficiency findings and deferred maintenance items. Captures inspection type (fire safety, elevator, boiler, environmental health, ADA, general condition assessment, laboratory safety), inspection date, inspector name and credentials, overall rating, pass/fail determination, and required follow-up actions. Records individual deficiency findings with severity rating, affected building system (roofing, HVAC, electrical, plumbing, envelope, life safety), estimated renewal cost, recommended remediation year, funding status, and current disposition. Supports regulatory compliance with OSHA, state fire marshal, and local building code authorities. Aggregated deficiency data produces the institutions Facilities Condition Index (FCI) for APPA benchmarking, accreditation self-studies, and capital budget requests.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`hazmat_inventory` (
    `hazmat_inventory_id` BIGINT COMMENT 'Primary key for hazmat_inventory',
    `bib_record_id` BIGINT COMMENT 'Foreign key linking to library.bib_record. Business justification: Rare books and special collections may contain hazardous materials (arsenic in Victorian-era bindings, lead-based inks, mold contamination). Required for environmental health compliance, preservation ',
    `building_id` BIGINT COMMENT 'Reference to the campus building where the hazardous material is stored.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic or administrative department responsible for the hazardous material.',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the Principal Investigator (PI) or faculty member responsible for the hazardous material in research laboratories.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Hazardous materials are subject to specific EPA (Tier II reporting), OSHA (hazard communication), and state environmental regulations. Environmental health and safety officers track which regulations ',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Hazardous materials are purchased and managed under specific research awards. Safety compliance, cost tracking, disposal accounting, and sponsor reporting require award linkage. Essential for tracking',
    `room_id` BIGINT COMMENT 'Reference to the specific room or laboratory where the hazardous material is stored.',
    `cas_number` STRING COMMENT 'The unique Chemical Abstracts Service (CAS) registry number identifying the chemical substance.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `chemical_name` STRING COMMENT 'The common or IUPAC name of the hazardous chemical or material.',
    `container_size` DECIMAL(18,2) COMMENT 'The size or capacity of the storage container.',
    `container_type` STRING COMMENT 'The type of container used for storage (bottle, drum, cylinder, tank, carboy, or vial).. Valid values are `bottle|drum|cylinder|tank|carboy|vial`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the hazardous material inventory record was first created in the system.',
    `disposal_method` STRING COMMENT 'The approved method for disposing of the hazardous material (e.g., chemical waste pickup, neutralization, incineration, special handling).',
    `epa_tier_ii_reportable` BOOLEAN COMMENT 'Indicates whether the material is subject to EPA Tier II hazardous chemical inventory reporting requirements.',
    `epa_tier_ii_threshold_quantity` DECIMAL(18,2) COMMENT 'The EPA Tier II reporting threshold quantity for this material, above which reporting is required.',
    `expiration_date` DATE COMMENT 'The expiration or shelf-life date of the hazardous material, after which it should not be used.',
    `ghs_pictogram_codes` STRING COMMENT 'Comma-separated list of GHS pictogram codes (e.g., GHS02, GHS05, GHS06) indicating hazard types.',
    `hazard_classification` STRING COMMENT 'The primary hazard classification of the material (flammable, corrosive, toxic, reactive, oxidizer, or carcinogen) per OSHA Hazard Communication Standard.. Valid values are `flammable|corrosive|toxic|reactive|oxidizer|carcinogen`',
    `hazmat_inventory_status` STRING COMMENT 'The current status of the hazardous material inventory record (active, depleted, expired, disposed, or quarantined).. Valid values are `active|depleted|expired|disposed|quarantined`',
    `inventory_number` STRING COMMENT 'The institution-assigned inventory tracking number or barcode for the hazardous material container.',
    `last_inspection_date` DATE COMMENT 'The date the hazardous material container was last inspected for integrity, labeling, and compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the hazardous material inventory record was last modified.',
    `manufacturer_name` STRING COMMENT 'The name of the chemical manufacturer or supplier.',
    `next_inspection_date` DATE COMMENT 'The scheduled date for the next inspection of the hazardous material container.',
    `nfpa_flammability_rating` STRING COMMENT 'NFPA 704 flammability hazard rating (0-4 scale, where 0 is minimal hazard and 4 is severe hazard).',
    `nfpa_health_rating` STRING COMMENT 'NFPA 704 health hazard rating (0-4 scale, where 0 is minimal hazard and 4 is severe hazard).',
    `nfpa_reactivity_rating` STRING COMMENT 'NFPA 704 reactivity hazard rating (0-4 scale, where 0 is minimal hazard and 4 is severe hazard).',
    `nfpa_special_hazard` STRING COMMENT 'NFPA 704 special hazard code (W=water reactive, OX=oxidizer, SA=simple asphyxiant, COR=corrosive, ACID=acid, ALK=alkali, BIO=biological hazard, POI=poison, RAD=radioactive). [ENUM-REF-CANDIDATE: W|OX|SA|COR|ACID|ALK|BIO|POI|RAD — 9 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional notes or comments about the hazardous material, storage conditions, or special handling requirements.',
    `purchase_date` DATE COMMENT 'The date the hazardous material was purchased or received.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The current quantity of the hazardous material in inventory.',
    `sara_threshold_quantity` DECIMAL(18,2) COMMENT 'The SARA Title III reporting threshold quantity for this material, above which reporting is required.',
    `sara_title_iii_reportable` BOOLEAN COMMENT 'Indicates whether the material is subject to SARA Title III (Emergency Planning and Community Right-to-Know Act) reporting requirements.',
    `sds_document_reference` STRING COMMENT 'Reference identifier or URL to the Safety Data Sheet (SDS) document for the hazardous material.',
    `sds_revision_date` DATE COMMENT 'The date the Safety Data Sheet (SDS) was last revised by the manufacturer.',
    `storage_location_description` STRING COMMENT 'Detailed description of the storage location within the room (e.g., flammable cabinet A, fume hood 3, refrigerator B).',
    `storage_requirements` STRING COMMENT 'Special storage requirements for the material (e.g., refrigeration, ventilation, segregation from incompatible materials, flammable cabinet).',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity (grams, kilograms, liters, milliliters, pounds, gallons, cubic feet, or units). [ENUM-REF-CANDIDATE: grams|kilograms|liters|milliliters|pounds|gallons|cubic_feet|units — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_hazmat_inventory PRIMARY KEY(`hazmat_inventory_id`)
) COMMENT 'Tracks hazardous materials stored and used in campus laboratories, maintenance shops, and other facilities. Captures chemical name, CAS number, storage location (building and room), quantity on hand, unit of measure, hazard classification (flammable, corrosive, toxic, reactive, carcinogen), storage requirements, responsible PI or department, SDS (Safety Data Sheet) reference, and regulatory reporting thresholds (SARA Title III, EPA Tier II). Supports EHS compliance, OSHA laboratory standard, and emergency response planning.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`project_funding` (
    `project_funding_id` BIGINT COMMENT 'Unique identifier for this fund allocation record. Primary key for the project funding association.',
    `advancement_fund_id` BIGINT COMMENT 'Foreign key linking to the advancement fund providing funding for this allocation',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to the capital project receiving funding from this allocation',
    `actual_expenditure_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures charged against this specific fund allocation. Tracked separately from total project expenditures to support fund-specific financial reporting and donor stewardship.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Dollar amount allocated from this advancement fund to this capital project. Represents the committed funding from this specific fund source.',
    `allocation_authorization_date` DATE COMMENT 'Date when the allocation of this fund to this project was officially authorized by advancement leadership or Board. Establishes the commitment date for stewardship purposes.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total project budget represented by this fund allocation. Used for proportional reporting and fund utilization analysis.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this fund allocation. Values: pending (authorized but not disbursed), active (funds available for expenditure), fully_disbursed (allocation exhausted), closed (project complete), reallocated (funds moved to different project).',
    `disbursement_date` DATE COMMENT 'Date when funds were disbursed from the advancement fund to the capital project budget. May differ from project expenditure dates. Supports cash flow tracking and stewardship reporting.',
    `donor_recognition_required_flag` BOOLEAN COMMENT 'Indicates whether this fund allocation requires donor recognition signage, naming rights, or public acknowledgment on the project. Drives facilities coordination with advancement for donor stewardship.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this fund allocation was authorized and recorded. Format: FY2024. Used for annual fund utilization reporting to donors and Board.',
    `remaining_allocation` DECIMAL(18,2) COMMENT 'Unspent balance of this fund allocation (allocation_amount minus actual_expenditure_to_date). Used to monitor fund utilization and identify under-utilized allocations.',
    `restriction_compliance_status` STRING COMMENT 'Current compliance status of project expenditures against donor-imposed fund restrictions. Values: compliant, under_review, variance_approved, non_compliant. Tracked per fund-project pair because each fund has unique restriction terms.',
    `stewardship_report_date` DATE COMMENT 'Date of most recent stewardship report provided to fund donors showing utilization of their gift on this specific project. Supports advancement donor relations tracking.',
    CONSTRAINT pk_project_funding PRIMARY KEY(`project_funding_id`)
) COMMENT 'This association product represents the funding relationship between capital projects and advancement funds. It captures the allocation of donor-restricted and institutional funds to specific capital construction, renovation, or infrastructure projects. Each record links one capital project to one advancement fund with allocation amounts, restriction compliance tracking, and disbursement schedules that exist only in the context of this funding relationship. Supports Board reporting on fund utilization and donor stewardship reporting on gift impact.. Existence Justification: In higher education capital project financing, a single capital project is routinely funded by multiple advancement funds (endowments, annual giving, corporate gifts, foundation grants), and individual advancement funds commonly support multiple capital projects over time. The business actively manages fund allocations as operational records, tracking allocation amounts, disbursement schedules, restriction compliance per donor terms, and expenditure against each fund source for Board reporting and donor stewardship.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`asset_compliance` (
    `asset_compliance_id` BIGINT COMMENT 'Primary key for the asset_compliance association',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the facility asset that must comply with the regulatory requirement',
    `employee_id` BIGINT COMMENT 'Identifier of the facilities technician or staff member assigned primary responsibility for maintaining this assets compliance with this specific requirement.',
    `facility_asset_id` BIGINT COMMENT 'Foreign key to facility_asset',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement that applies to the facility asset',
    `certification_expiration_date` DATE COMMENT 'Date when the current certification or compliance approval expires for this asset under this requirement. Used to trigger recertification processes and prevent lapses in compliance.',
    `certification_number` STRING COMMENT 'Official certification or permit number issued by the regulatory body confirming this assets compliance with this specific requirement. Used for audit documentation and regulatory reporting.',
    `compliance_status` STRING COMMENT 'Current compliance status of this specific asset with this specific regulatory requirement. Tracks whether the asset meets the requirements standards at the current point in time.',
    `inspection_frequency_days` STRING COMMENT 'Number of days between required inspections for this specific asset-requirement pair. May differ from the general requirement frequency based on asset condition, risk level, or prior inspection findings.',
    `inspector_name` STRING COMMENT 'Name of the inspector or inspection firm that performed the most recent compliance assessment for this asset-requirement combination. Used for inspector performance tracking and audit trail.',
    `last_inspection_date` DATE COMMENT 'Date when the most recent inspection or compliance assessment was performed for this asset against this specific regulatory requirement. Used to calculate time since last inspection and determine next inspection due date.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date when the next compliance inspection or assessment is due for this asset under this regulatory requirement. Used for inspection planning and to identify overdue inspections.',
    `non_compliance_notes` STRING COMMENT 'Detailed notes describing any non-compliance findings, deficiencies identified, or corrective actions required for this asset to meet this regulatory requirement.',
    `remediation_due_date` DATE COMMENT 'Deadline by which identified non-compliance issues must be corrected to avoid penalties or enforcement actions under this regulatory requirement.',
    `waiver_expiration_date` DATE COMMENT 'Date when any granted waiver or exemption expires, after which the asset must comply with the full requirement or obtain a waiver renewal.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a formal waiver or exemption has been granted by the regulatory body exempting this specific asset from this specific requirement.',
    CONSTRAINT pk_asset_compliance PRIMARY KEY(`asset_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between facility assets and regulatory requirements. It captures the ongoing compliance status, inspection schedules, and certification records for each asset-requirement pair. Each record links one facility asset to one regulatory requirement with attributes that track inspection history, compliance status, and certification details specific to that assets obligation under that regulation.. Existence Justification: In higher education facilities management, individual physical assets (elevators, boilers, fume hoods, autoclaves, fire suppression systems) must comply with multiple distinct regulatory requirements (ADA, OSHA, EPA, fire codes, pressure vessel regulations, laboratory safety standards). Simultaneously, each regulatory requirement applies to multiple assets across campus. Facilities teams actively manage compliance for each asset-requirement pair, tracking inspection schedules, certification status, and remediation activities as operational business processes.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`floor` (
    `floor_id` BIGINT COMMENT 'Primary key for floor',
    `building_id` BIGINT COMMENT 'Reference to the building that contains this floor. Links floor to its parent building structure.',
    `utility_meter_id` BIGINT COMMENT 'Identifier for the energy metering system monitoring this floor. Used for utility cost allocation and energy management reporting.',
    `org_unit_id` BIGINT COMMENT 'Primary academic or administrative department assigned to or responsible for the floor. Used for space allocation and chargeback.',
    `parent_floor_id` BIGINT COMMENT 'Self-referencing FK on floor (parent_floor_id)',
    `ada_accessible` BOOLEAN COMMENT 'Indicates whether the floor is fully accessible to individuals with disabilities per ADA requirements. Includes elevator access, accessible restrooms, and compliant pathways.',
    `ceiling_finish_type` STRING COMMENT 'Primary ceiling finish or construction type on the floor. Affects acoustics, lighting, and maintenance requirements.',
    `ceiling_height_feet` DECIMAL(18,2) COMMENT 'Average ceiling height on the floor measured in feet. Important for space utilization, HVAC design, and ADA compliance.',
    `circulation_area_sqft` DECIMAL(18,2) COMMENT 'Square footage dedicated to corridors, hallways, lobbies, and other circulation spaces on the floor. Used for space efficiency analysis.',
    `construction_year` STRING COMMENT 'Year the floor was originally constructed. Used for capital planning, renovation scheduling, and historical facility records.',
    `cost_center_code` STRING COMMENT 'Financial cost center code for charging maintenance, utilities, and facility costs associated with the floor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the floor record was first created in the system. Used for data lineage and audit purposes.',
    `effective_date` DATE COMMENT 'Date when the current floor configuration and attributes became effective. Used for historical space tracking and audit trails.',
    `elevation_feet` DECIMAL(18,2) COMMENT 'Vertical elevation of the floor level above a reference datum (typically ground level or building entrance). Used for accessibility planning and emergency response.',
    `emergency_exit_count` STRING COMMENT 'Number of emergency exits available on the floor. Used for life safety compliance and emergency evacuation planning.',
    `expiration_date` DATE COMMENT 'Date when the current floor record expires or is superseded. Null for currently active records. Supports historical space analysis.',
    `fire_zone` STRING COMMENT 'Fire safety zone designation for the floor. Used for fire alarm system configuration, emergency response planning, and code compliance.',
    `floor_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the floor within the institutions facility coding system. Used for space accounting and reporting.',
    `floor_finish_type` STRING COMMENT 'Primary flooring material or finish type on the floor. Impacts maintenance costs, cleaning schedules, and replacement planning.',
    `floor_name` STRING COMMENT 'Common or official name of the floor (e.g., Main Floor, Engineering Wing, Administrative Level). Used for wayfinding and communication.',
    `floor_number` STRING COMMENT 'The floor number or level designation within the building (e.g., 1, 2, B1 for basement, M for mezzanine, G for ground). May include alphanumeric codes for special levels.',
    `floor_type` STRING COMMENT 'Primary functional classification of the floor based on predominant use. Determines space allocation policies and cost recovery rates.',
    `gross_area_sqft` DECIMAL(18,2) COMMENT 'Total gross square footage of the floor measured from exterior wall to exterior wall. Used for facility cost allocation and space planning.',
    `hvac_zone` STRING COMMENT 'HVAC control zone identifier for the floor. Used for energy management, temperature control, and utility cost allocation.',
    `last_renovation_year` STRING COMMENT 'Year of the most recent major renovation or remodeling of the floor. Used for deferred maintenance planning and lifecycle analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the floor record. Used for change tracking and data quality monitoring.',
    `maintenance_zone` STRING COMMENT 'Facilities maintenance zone assignment for work order routing and custodial service scheduling.',
    `mechanical_area_sqft` DECIMAL(18,2) COMMENT 'Square footage occupied by mechanical systems, HVAC equipment, electrical rooms, and building service areas on the floor.',
    `natural_light_availability` STRING COMMENT 'Assessment of natural daylight availability on the floor. Impacts energy efficiency, occupant well-being, and space desirability.',
    `net_assignable_area_sqft` DECIMAL(18,2) COMMENT 'Net assignable square footage available for functional use, excluding circulation, mechanical, and structural spaces. Used for Facilities and Administrative (F&A) cost rate calculations.',
    `notes` STRING COMMENT 'Free-text notes capturing additional information about the floor, including special characteristics, restrictions, or historical context.',
    `occupancy_capacity` STRING COMMENT 'Maximum number of occupants permitted on the floor based on building code, fire safety regulations, and egress capacity. Used for emergency planning.',
    `restroom_count` STRING COMMENT 'Total number of restroom facilities on the floor. Used for occupancy planning and ADA compliance verification.',
    `room_count` STRING COMMENT 'Total number of individual rooms or spaces on the floor. Used for space inventory and utilization tracking.',
    `security_zone` STRING COMMENT 'Security access control zone designation. Determines access card permissions, surveillance coverage, and security protocols.',
    `space_use_category` STRING COMMENT 'Facilities and Administrative (F&A) cost rate space use category code. Used for federal indirect cost rate calculations and sponsored research administration.',
    `floor_status` STRING COMMENT 'Current operational status of the floor. Indicates availability for space assignment and occupancy.',
    `usable_area_sqft` DECIMAL(18,2) COMMENT 'Usable square footage including assignable space plus circulation areas on the floor. Excludes only major vertical penetrations and building service areas.',
    `wireless_coverage` BOOLEAN COMMENT 'Indicates whether the floor has complete wireless network coverage. Important for academic technology planning and student services.',
    CONSTRAINT pk_floor PRIMARY KEY(`floor_id`)
) COMMENT 'Master reference table for floor. Referenced by floor_id.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`work_order_template` (
    `work_order_template_id` BIGINT COMMENT 'Primary key for work_order_template',
    `parent_work_order_template_id` BIGINT COMMENT 'Self-referencing FK on work_order_template (parent_work_order_template_id)',
    `approval_level` STRING COMMENT 'Organizational level required to approve work orders created from this template.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether work orders created from this template require supervisory or management approval before execution.',
    `asset_type_applicable` STRING COMMENT 'Type of facility asset or equipment this template is designed for (e.g., HVAC Unit, Elevator, Boiler, Roof).',
    `building_system` STRING COMMENT 'Building system or infrastructure category this template applies to (e.g., Mechanical, Electrical, Plumbing, Structural, Life Safety).',
    `work_order_template_category` STRING COMMENT 'Functional category or discipline of work (e.g., HVAC, Electrical, Plumbing, Grounds, Custodial).',
    `checklist_items` STRING COMMENT 'List of inspection or completion checklist items to be verified during work order execution.',
    `compliance_requirement` STRING COMMENT 'Regulatory or compliance standard that this work order template helps satisfy (e.g., ADA, OSHA, EPA, fire code).',
    `cost_center_code` STRING COMMENT 'Default cost center or budget code for charging expenses related to work orders from this template.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this work order template record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this work order template is no longer active or has been superseded by a newer version.',
    `effective_start_date` DATE COMMENT 'Date when this work order template becomes active and available for use.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD for completing work orders based on this template, including labor and materials.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Expected time in hours required to complete work orders created from this template.',
    `frequency_interval` STRING COMMENT 'Numeric interval for recurring work orders (e.g., every 3 months, every 6 weeks).',
    `frequency_type` STRING COMMENT 'Recurrence pattern for preventive maintenance work orders generated from this template.',
    `gl_account_code` STRING COMMENT 'Default general ledger account code for financial transactions related to work orders from this template.',
    `labor_hours_required` DECIMAL(18,2) COMMENT 'Standard labor hours required to complete work orders created from this template.',
    `materials_required` STRING COMMENT 'List of materials, parts, or supplies typically required for work orders created from this template.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this work order template.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this work order template record was last updated in the system.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this work order template.',
    `notification_recipients` STRING COMMENT 'List of roles or individuals who should be notified when work orders are created from this template.',
    `permit_type` STRING COMMENT 'Type of permit required if applicable (e.g., Hot Work, Confined Space, Electrical Lockout).',
    `priority_level` STRING COMMENT 'Default priority level assigned to work orders created from this template.',
    `requires_downtime` BOOLEAN COMMENT 'Indicates whether work orders from this template require facility or system downtime.',
    `requires_permit` BOOLEAN COMMENT 'Indicates whether work orders from this template require a work permit or authorization before execution.',
    `safety_requirements` STRING COMMENT 'Safety protocols, personal protective equipment (PPE), and precautions required for work orders created from this template.',
    `skill_level_required` STRING COMMENT 'Minimum skill or certification level required for personnel assigned to work orders from this template.',
    `sla_completion_hours` DECIMAL(18,2) COMMENT 'Target completion time in hours for work orders created from this template per service level agreement.',
    `sla_response_hours` DECIMAL(18,2) COMMENT 'Target response time in hours for work orders created from this template per service level agreement.',
    `space_type_applicable` STRING COMMENT 'Type of campus space this template is designed for (e.g., Classroom, Laboratory, Residence Hall, Office, Athletic Facility).',
    `standard_procedures` STRING COMMENT 'Detailed step-by-step procedures or instructions for completing work orders based on this template.',
    `work_order_template_status` STRING COMMENT 'Current lifecycle status of the work order template indicating whether it is available for use.',
    `template_code` STRING COMMENT 'Unique alphanumeric code assigned to the work order template for external reference and system integration.',
    `template_description` STRING COMMENT 'Detailed description of the work order template including scope, procedures, and expected outcomes.',
    `template_name` STRING COMMENT 'Human-readable name of the work order template describing its purpose or scope.',
    `tools_required` STRING COMMENT 'List of tools and equipment required to complete work orders based on this template.',
    `trade_specialty` STRING COMMENT 'Specific trade or craft specialty required to execute work orders from this template (e.g., Electrician, Plumber, Carpenter).',
    `version_number` STRING COMMENT 'Version number of the work order template for tracking revisions and updates.',
    `work_type` STRING COMMENT 'Classification of the type of work this template represents.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this work order template.',
    CONSTRAINT pk_work_order_template PRIMARY KEY(`work_order_template_id`)
) COMMENT 'Master reference table for work_order_template. Referenced by work_order_template_id.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`survey_period` (
    `survey_period_id` BIGINT COMMENT 'Primary key for survey_period',
    `comparison_period_id` BIGINT COMMENT 'Reference to a prior survey period used for year-over-year or period-over-period comparative analysis.',
    `prior_survey_period_id` BIGINT COMMENT 'Self-referencing FK on survey_period (prior_survey_period_id)',
    `academic_year` STRING COMMENT 'The academic year associated with this survey period (e.g., 2023-24), used for aligning space data with enrollment and instructional activities.',
    `archibus_integration_flag` BOOLEAN COMMENT 'Indicates whether this survey period data is integrated with or sourced from the Archibus facilities management system.',
    `baseline_period_flag` BOOLEAN COMMENT 'Indicates whether this survey period serves as a baseline reference for future comparative analysis and trend reporting.',
    `certification_date` DATE COMMENT 'The date when the survey data for this period was officially certified as complete and accurate by authorized personnel.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether formal certification or sign-off by authorized personnel is required for survey data collected during this period.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this survey period record was first created in the system.',
    `data_collection_method` STRING COMMENT 'The primary method used for collecting survey data during this period (e.g., manual walkthroughs, automated sensors, third-party audits).',
    `end_date` DATE COMMENT 'The date when the survey period officially ends and data collection must be completed.',
    `fa_cost_rate_flag` BOOLEAN COMMENT 'Indicates whether this survey period is used for F&A cost rate calculations and space allocation for federal indirect cost recovery.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this survey period is assigned for budgeting and financial reporting purposes.',
    `ipeds_reporting_flag` BOOLEAN COMMENT 'Indicates whether this survey period data will be used for IPEDS facilities reporting to the National Center for Education Statistics.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this survey period record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this survey period, including any deviations from standard procedures or data quality issues.',
    `period_code` STRING COMMENT 'Business identifier code for the survey period, used for external reference and reporting (e.g., FY2024Q1, AY2023-24).',
    `period_name` STRING COMMENT 'Human-readable name of the survey period (e.g., Fall 2024 Space Survey, Annual Facilities Assessment 2024).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this survey period is used for mandatory regulatory or governmental reporting (e.g., IPEDS, state facilities reports).',
    `reporting_term` STRING COMMENT 'The academic or calendar term designation for this survey period, used for cyclical reporting requirements.',
    `responsible_department` STRING COMMENT 'The organizational department or unit responsible for coordinating and executing the survey during this period.',
    `scope_description` STRING COMMENT 'Detailed description of the scope, objectives, and coverage of the survey for this period, including specific buildings, spaces, or data elements to be collected.',
    `start_date` DATE COMMENT 'The date when the survey period officially begins and data collection is authorized to commence.',
    `survey_period_status` STRING COMMENT 'Current lifecycle status of the survey period. Tracks progression from planning through completion.',
    `submission_deadline` DATE COMMENT 'The final date by which all survey data must be submitted and validated for this period.',
    `survey_coordinator_email` STRING COMMENT 'The email address of the survey coordinator for communication and coordination purposes.',
    `survey_coordinator_name` STRING COMMENT 'The name of the individual serving as the primary coordinator or point of contact for this survey period.',
    `survey_type` STRING COMMENT 'Classification of the survey being conducted during this period. Determines the scope and data collection requirements.',
    CONSTRAINT pk_survey_period PRIMARY KEY(`survey_period_id`)
) COMMENT 'Master reference table for survey_period. Referenced by survey_period_id.';

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`crew` (
    `crew_id` BIGINT COMMENT 'Primary key for crew',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who supervises this crew.',
    `building_id` BIGINT COMMENT 'Identifier of the primary building or facility where the crew is based.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the facilities department to which this crew is assigned.',
    `supervisor_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `parent_crew_id` BIGINT COMMENT 'Self-referencing FK on crew (parent_crew_id)',
    `active_work_order_count` STRING COMMENT 'Current number of open work orders assigned to the crew, used for workload balancing and capacity planning.',
    `ada_compliance_trained` BOOLEAN COMMENT 'Indicates whether crew members have received training on ADA accessibility requirements and compliance standards for facility modifications and maintenance.',
    `average_work_order_completion_days` DECIMAL(18,2) COMMENT 'Mean number of days the crew takes to complete assigned work orders, used as a key performance indicator (KPI) for crew efficiency.',
    `certification_requirements` STRING COMMENT 'List of required certifications, licenses, or training credentials that crew members must hold (e.g., EPA 608 Universal, Licensed Electrician, Forklift Operator, Asbestos Awareness).',
    `contact_email` STRING COMMENT 'Email address for crew communications and work order notifications.',
    `contact_phone` STRING COMMENT 'Primary phone number to reach the crew or crew supervisor during work hours.',
    `cost_center_code` STRING COMMENT 'Financial accounting cost center code to which crew labor and expenses are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was first created in the system.',
    `crew_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the crew for identification in work orders and scheduling systems.',
    `crew_name` STRING COMMENT 'Human-readable name of the crew (e.g., HVAC Maintenance Team A, Electrical Services Crew 3).',
    `crew_size` STRING COMMENT 'Number of personnel assigned to the crew.',
    `crew_status` STRING COMMENT 'Current operational status of the crew in its lifecycle.',
    `crew_type` STRING COMMENT 'Classification of the crew based on primary function: maintenance (HVAC, electrical, plumbing), custodial (cleaning, sanitation), grounds (landscaping, snow removal), utilities (energy systems), construction (capital projects), or emergency response (safety, incident management).',
    `effective_end_date` DATE COMMENT 'Date when the crew was disbanded or deactivated, if applicable. Null for active crews.',
    `effective_start_date` DATE COMMENT 'Date when the crew was officially formed and became operational.',
    `emergency_response_capable` BOOLEAN COMMENT 'Indicates whether the crew is trained and equipped to respond to emergency situations (e.g., power outages, water leaks, HVAC failures, safety incidents).',
    `equipment_assigned` STRING COMMENT 'Major tools, vehicles, or equipment permanently assigned to the crew (e.g., Truck #45, Scissor Lift, Welding Kit).',
    `hourly_labor_rate` DECIMAL(18,2) COMMENT 'Standard blended hourly labor rate for the crew used in work order costing and Facilities and Administrative (F&A) cost calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was most recently updated.',
    `last_safety_training_date` DATE COMMENT 'Date when the crew last completed mandatory safety training, used to track compliance with OSHA and institutional safety requirements.',
    `notes` STRING COMMENT 'Free-text field for additional information about the crew, including special capabilities, restrictions, or operational notes.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether crew members are eligible for overtime compensation under Fair Labor Standards Act (FLSA) regulations.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the crew based on work quality, timeliness, safety record, and customer satisfaction.',
    `radio_channel` STRING COMMENT 'Two-way radio channel or frequency assigned to the crew for field communications.',
    `safety_incident_count` STRING COMMENT 'Cumulative number of recordable safety incidents involving this crew, tracked for OSHA reporting and safety performance metrics.',
    `service_area` STRING COMMENT 'Geographic or functional area of campus that the crew is responsible for servicing (e.g., North Campus, Medical Center Complex, Athletic Facilities).',
    `shift_end_time` STRING COMMENT 'Standard end time for the crews work shift in HH:MM format (24-hour clock).',
    `shift_schedule` STRING COMMENT 'Primary work shift pattern for the crew.',
    `shift_start_time` STRING COMMENT 'Standard start time for the crews work shift in HH:MM format (24-hour clock).',
    `specialization` STRING COMMENT 'Specific technical specialization or trade expertise of the crew (e.g., HVAC Systems, Electrical Distribution, Plumbing and Piping, Carpentry, Locksmith Services).',
    `union_affiliation` STRING COMMENT 'Name of labor union representing crew members, if applicable (e.g., International Union of Operating Engineers, Service Employees International Union).',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Master reference table for crew. Referenced by assigned_crew_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_parent_booking_room_booking_id` FOREIGN KEY (`parent_booking_room_booking_id`) REFERENCES `education_ecm`.`facility`.`room_booking`(`room_booking_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `education_ecm`.`facility`.`asset`(`asset_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `education_ecm`.`facility`.`crew`(`crew_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `education_ecm`.`facility`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `education_ecm`.`facility`.`asset`(`asset_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `education_ecm`.`facility`.`floor`(`floor_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_work_order_template_id` FOREIGN KEY (`work_order_template_id`) REFERENCES `education_ecm`.`facility`.`work_order_template`(`work_order_template_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ADD CONSTRAINT `fk_facility_space_utilization_survey_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ADD CONSTRAINT `fk_facility_space_utilization_survey_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ADD CONSTRAINT `fk_facility_space_utilization_survey_survey_period_id` FOREIGN KEY (`survey_period_id`) REFERENCES `education_ecm`.`facility`.`survey_period`(`survey_period_id`);
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ADD CONSTRAINT `fk_facility_utility_meter_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ADD CONSTRAINT `fk_facility_accessibility_feature_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ADD CONSTRAINT `fk_facility_accessibility_feature_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ADD CONSTRAINT `fk_facility_accessibility_feature_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ADD CONSTRAINT `fk_facility_accessibility_feature_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `education_ecm`.`facility`.`work_order`(`work_order_id`);
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ADD CONSTRAINT `fk_facility_lease_agreement_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`inspection` ADD CONSTRAINT `fk_facility_inspection_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`inspection` ADD CONSTRAINT `fk_facility_inspection_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`inspection` ADD CONSTRAINT `fk_facility_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `education_ecm`.`facility`.`work_order`(`work_order_id`);
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ADD CONSTRAINT `fk_facility_hazmat_inventory_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ADD CONSTRAINT `fk_facility_hazmat_inventory_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`project_funding` ADD CONSTRAINT `fk_facility_project_funding_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ADD CONSTRAINT `fk_facility_asset_compliance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `education_ecm`.`facility`.`asset`(`asset_id`);
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ADD CONSTRAINT `fk_facility_asset_compliance_facility_asset_id` FOREIGN KEY (`facility_asset_id`) REFERENCES `education_ecm`.`facility`.`asset`(`asset_id`);
ALTER TABLE `education_ecm`.`facility`.`floor` ADD CONSTRAINT `fk_facility_floor_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`floor` ADD CONSTRAINT `fk_facility_floor_utility_meter_id` FOREIGN KEY (`utility_meter_id`) REFERENCES `education_ecm`.`facility`.`utility_meter`(`utility_meter_id`);
ALTER TABLE `education_ecm`.`facility`.`floor` ADD CONSTRAINT `fk_facility_floor_parent_floor_id` FOREIGN KEY (`parent_floor_id`) REFERENCES `education_ecm`.`facility`.`floor`(`floor_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order_template` ADD CONSTRAINT `fk_facility_work_order_template_parent_work_order_template_id` FOREIGN KEY (`parent_work_order_template_id`) REFERENCES `education_ecm`.`facility`.`work_order_template`(`work_order_template_id`);
ALTER TABLE `education_ecm`.`facility`.`survey_period` ADD CONSTRAINT `fk_facility_survey_period_comparison_period_id` FOREIGN KEY (`comparison_period_id`) REFERENCES `education_ecm`.`facility`.`survey_period`(`survey_period_id`);
ALTER TABLE `education_ecm`.`facility`.`survey_period` ADD CONSTRAINT `fk_facility_survey_period_prior_survey_period_id` FOREIGN KEY (`prior_survey_period_id`) REFERENCES `education_ecm`.`facility`.`survey_period`(`survey_period_id`);
ALTER TABLE `education_ecm`.`facility`.`crew` ADD CONSTRAINT `fk_facility_crew_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`crew` ADD CONSTRAINT `fk_facility_crew_parent_crew_id` FOREIGN KEY (`parent_crew_id`) REFERENCES `education_ecm`.`facility`.`crew`(`crew_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`facility` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `education_ecm`.`facility` SET TAGS ('dbx_domain' = 'facility');
ALTER TABLE `education_ecm`.`facility`.`building` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`building` SET TAGS ('dbx_subdomain' = 'space_management');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Building Manager Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `ada_compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Date');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `annual_operating_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Cost');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `annual_operating_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `assignable_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Assignable Square Feet (ASF)');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `automation_system` SET TAGS ('dbx_business_glossary_term' = 'Building Automation System (BAS)');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `bike_parking_spaces` SET TAGS ('dbx_business_glossary_term' = 'Bike Parking Spaces');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `building_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `deferred_maintenance_backlog` SET TAGS ('dbx_business_glossary_term' = 'Deferred Maintenance Backlog');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `deferred_maintenance_backlog` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `emergency_generator` SET TAGS ('dbx_business_glossary_term' = 'Emergency Generator');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `energy_star_score` SET TAGS ('dbx_business_glossary_term' = 'Energy Star Score');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `facility_condition_index` SET TAGS ('dbx_business_glossary_term' = 'Facility Condition Index (FCI)');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `gross_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Gross Square Feet (GSF)');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `historic_designation` SET TAGS ('dbx_business_glossary_term' = 'Historic Designation');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `historic_designation` SET TAGS ('dbx_value_regex' = 'none|national_register|state_register|local_landmark|contributing_structure');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `last_major_renovation_year` SET TAGS ('dbx_business_glossary_term' = 'Last Major Renovation Year');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `leed_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Date');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Level');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_value_regex' = 'none|certified|silver|gold|platinum');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `number_of_floors` SET TAGS ('dbx_business_glossary_term' = 'Number of Floors');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|under_renovation|decommissioned|planned');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Status');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'owned|leased|ground_lease|joint_use|donated');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `parking_spaces` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `primary_hvac_system_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Heating Ventilation and Air Conditioning (HVAC) System Type');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `replacement_value` SET TAGS ('dbx_business_glossary_term' = 'Replacement Value');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `replacement_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `space_utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Space Utilization Rate');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `wireless_coverage` SET TAGS ('dbx_business_glossary_term' = 'Wireless Coverage');
ALTER TABLE `education_ecm`.`facility`.`room` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`room` SET TAGS ('dbx_subdomain' = 'space_management');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `ada_accessible_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accessible Flag');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `ada_features` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Features');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `assignable_flag` SET TAGS ('dbx_business_glossary_term' = 'Assignable Space Flag');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `av_equipment_description` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Equipment Description');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `av_equipment_level` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Equipment Level');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `av_equipment_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|advanced|premium');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `biosafety_level` SET TAGS ('dbx_business_glossary_term' = 'Biosafety Level (BSL)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `biosafety_level` SET TAGS ('dbx_value_regex' = 'BSL-1|BSL-2|BSL-3|BSL-4|not_applicable');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `ceiling_height_feet` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Height (Feet)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `climate_control_type` SET TAGS ('dbx_business_glossary_term' = 'Climate Control Type');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `climate_control_type` SET TAGS ('dbx_value_regex' = 'central|individual|none|variable_air_volume|constant_air_volume');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Room Condition');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `design_capacity` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `emergency_equipment` SET TAGS ('dbx_business_glossary_term' = 'Emergency Equipment');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `fire_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Rating');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `fire_safety_rating` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|pending_inspection');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `fume_hood_count` SET TAGS ('dbx_business_glossary_term' = 'Fume Hood Count');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `furniture_description` SET TAGS ('dbx_business_glossary_term' = 'Furniture Description');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `gross_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Gross Square Feet (GSF)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `hazardous_materials_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Flag');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `hvac_zone` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) Zone');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `natural_light_flag` SET TAGS ('dbx_business_glossary_term' = 'Natural Light Flag');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `net_assignable_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Net Assignable Square Feet (NASF)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'occupied|vacant|reserved|under_renovation|decommissioned|temporary_closure');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Renovation Date');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('dbx_business_glossary_term' = 'Room Name');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `room_type` SET TAGS ('dbx_business_glossary_term' = 'Room Type');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `scheduling_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Eligible Flag');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `scheduling_priority` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Priority');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `scheduling_priority` SET TAGS ('dbx_value_regex' = 'academic|administrative|event|research|mixed_use');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `seating_configuration` SET TAGS ('dbx_business_glossary_term' = 'Seating Configuration');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `smart_classroom_flag` SET TAGS ('dbx_business_glossary_term' = 'Smart Classroom Flag');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `station_count` SET TAGS ('dbx_business_glossary_term' = 'Station Count');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Room Subtype');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `technology_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Technology Infrastructure');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `use_code` SET TAGS ('dbx_business_glossary_term' = 'Room Use Code');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `window_count` SET TAGS ('dbx_business_glossary_term' = 'Window Count');
ALTER TABLE `education_ecm`.`facility`.`campus` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`campus` SET TAGS ('dbx_subdomain' = 'space_management');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Date');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|candidate|probation|not accredited|pending review');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `accreditor_name` SET TAGS ('dbx_business_glossary_term' = 'Accreditor Name');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `assignable_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Assignable Square Feet (ASF)');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `athletic_facilities_flag` SET TAGS ('dbx_business_glossary_term' = 'Athletic Facilities Flag');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `building_count` SET TAGS ('dbx_business_glossary_term' = 'Building Count');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `campus_code` SET TAGS ('dbx_business_glossary_term' = 'Campus Code');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `campus_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `campus_name` SET TAGS ('dbx_business_glossary_term' = 'Campus Name');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `campus_type` SET TAGS ('dbx_business_glossary_term' = 'Campus Type');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `campus_type` SET TAGS ('dbx_value_regex' = 'main|branch|regional|extension|online|off-campus center');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Campus Closure Date');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Campus Email Address');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Campus Established Date');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Campus Fax Number');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `ipeds_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Unit Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `ipeds_unit_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `library_flag` SET TAGS ('dbx_business_glossary_term' = 'Library Facility Flag');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `next_accreditation_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Accreditation Review Date');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campus Notes');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|under construction|decommissioned|temporary closure');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `parking_spaces_count` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces Count');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Campus Phone Number');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `residence_hall_capacity` SET TAGS ('dbx_business_glossary_term' = 'Residence Hall Capacity');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `security_flag` SET TAGS ('dbx_business_glossary_term' = 'Campus Security Flag');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `total_acreage` SET TAGS ('dbx_business_glossary_term' = 'Total Campus Acreage');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `total_gross_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Square Feet (GSF)');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`facility`.`campus` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Campus Website Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` SET TAGS ('dbx_subdomain' = 'space_management');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `space_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Space Assignment Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Advancement Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `accreditation_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Reportable Flag');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `ada_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Required');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `animal_research_flag` SET TAGS ('dbx_business_glossary_term' = 'Animal Research Flag');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `annual_chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Chargeback Amount');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `assigned_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Assigned Square Footage');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `assignment_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Date');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|cancelled|suspended');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|shared|swing|temporary|seasonal|reserved');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `chargeback_rate` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Rate');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `ficm_room_use_code` SET TAGS ('dbx_business_glossary_term' = 'Facilities Inventory and Classification Manual (FICM) Room Use Code');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `ficm_room_use_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `hazardous_materials_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Flag');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `human_subjects_research_flag` SET TAGS ('dbx_business_glossary_term' = 'Human Subjects Research Flag');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `ipeds_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reportable Flag');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `occupancy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Percentage');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `purpose_code` SET TAGS ('dbx_business_glossary_term' = 'Space Purpose Code');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `purpose_code` SET TAGS ('dbx_value_regex' = 'instruction|research|other_sponsored|institutional|unallowable');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `space_survey_period` SET TAGS ('dbx_business_glossary_term' = 'Space Survey Period');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `space_survey_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `education_ecm`.`facility`.`room_booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`facility`.`room_booking` SET TAGS ('dbx_subdomain' = 'space_management');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `room_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Room Booking ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `parent_booking_room_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Booking ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Patron Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `primary_room_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `primary_room_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `primary_room_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `recruitment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Profile Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `accessibility_requirements` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Requirements');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `approval_datetime` SET TAGS ('dbx_business_glossary_term' = 'Approval Date and Time');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `av_equipment_notes` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Equipment Notes');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `av_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Equipment Required Flag');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Amount');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `billing_required` SET TAGS ('dbx_business_glossary_term' = 'Billing Required Flag');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_value_regex' = '^BK[0-9]{8}$');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date and Time');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `catering_notes` SET TAGS ('dbx_business_glossary_term' = 'Catering Service Notes');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `catering_required` SET TAGS ('dbx_business_glossary_term' = 'Catering Required Flag');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `expected_attendance` SET TAGS ('dbx_business_glossary_term' = 'Expected Attendance Count');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Booking Flag');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Date and Time');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Full Name');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `requestor_phone` SET TAGS ('dbx_business_glossary_term' = 'Requestor Phone Number');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `requestor_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `requestor_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `setup_notes` SET TAGS ('dbx_business_glossary_term' = 'Setup Special Instructions');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `setup_type` SET TAGS ('dbx_business_glossary_term' = 'Room Setup Type');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`facility`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`facility`.`work_order` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `finance_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `ada_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Flag');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Closed By');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `contractor_cost` SET TAGS ('dbx_business_glossary_term' = 'Contractor Cost');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `materials_cost` SET TAGS ('dbx_business_glossary_term' = 'Materials Cost');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `problem_description` SET TAGS ('dbx_business_glossary_term' = 'Problem Description');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `requester_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Requester Satisfaction Rating');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `trade_category` SET TAGS ('dbx_business_glossary_term' = 'Trade Category');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8}$');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|emergency|project|inspection|deferred');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `floor_id` SET TAGS ('dbx_business_glossary_term' = 'Floor ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `work_order_template_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Template ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `auto_generate_work_order` SET TAGS ('dbx_business_glossary_term' = 'Auto-Generate Work Order Flag');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'life_safety|environmental|accessibility|energy|health|general');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `deferred_maintenance_eligible` SET TAGS ('dbx_business_glossary_term' = 'Deferred Maintenance Eligible Flag');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `downtime_required` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `energy_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Energy Impact Category');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `energy_impact_category` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `frequency_type` SET TAGS ('dbx_business_glossary_term' = 'Frequency Type');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `last_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Date');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `notification_lead_days` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Days');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `required_trade_skill` SET TAGS ('dbx_business_glossary_term' = 'Required Trade Skill');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Code');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^PM-[A-Z0-9]{6,12}$');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|pending_review|retired');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'time_based|usage_based|condition_based|regulatory');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `seasonal_restriction` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Restriction');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `seasonal_restriction` SET TAGS ('dbx_value_regex' = 'none|academic_year_only|summer_only|winter_break|spring_break|avoid_finals');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Task Description');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `warranty_related` SET TAGS ('dbx_business_glossary_term' = 'Warranty Related Flag');
ALTER TABLE `education_ecm`.`facility`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`asset` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Asset ID');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Employee ID');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'Excellent|Good|Fair|Poor|Critical');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'Sold|Scrapped|Donated|Transferred|Recycled');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `energy_star_certified` SET TAGS ('dbx_business_glossary_term' = 'Energy Star Certified');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life (Years)');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'In Service|Out of Service|Under Maintenance|Decommissioned|Pending Installation');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency (Days)');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Asset Notes');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Asset Subcategory');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`capital_project` SET TAGS ('dbx_subdomain' = 'project_funding');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project ID');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Naming Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Campaign Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `actual_expenditures_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditures to Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `ada_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Required');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `architect_of_record` SET TAGS ('dbx_business_glossary_term' = 'Architect of Record');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `assignable_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Assignable Square Footage (ASF)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board of Trustees Approval Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `budget_variance` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `certificate_of_occupancy_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Occupancy (CO) Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `contractor_of_record` SET TAGS ('dbx_business_glossary_term' = 'Contractor of Record');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `current_encumbrance` SET TAGS ('dbx_business_glossary_term' = 'Current Encumbrance');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `design_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Design Approval Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `final_closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Final Closeout Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `gross_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Gross Square Footage (GSF)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `groundbreaking_date` SET TAGS ('dbx_business_glossary_term' = 'Groundbreaking Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `leed_certification_target` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Target');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `leed_certification_target` SET TAGS ('dbx_value_regex' = 'not_applicable|certified|silver|gold|platinum');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `permit_issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issuance Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `project_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `project_priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `project_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|delayed|at_risk|completed|cancelled');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_construction|major_renovation|deferred_maintenance|infrastructure_upgrade|demolition|site_improvement');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `projected_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Projected Completion Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance Days');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `state_approval_date` SET TAGS ('dbx_business_glossary_term' = 'State Oversight Agency Approval Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `substantial_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Substantial Completion Date');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `sustainability_features` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Features');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `total_authorized_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Authorized Budget');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` SET TAGS ('dbx_subdomain' = 'space_management');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `space_utilization_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Space Utilization Survey Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Department Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Occupant Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `survey_period_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Period Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `academic_term` SET TAGS ('dbx_business_glossary_term' = 'Academic Term');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `academic_term` SET TAGS ('dbx_value_regex' = 'fall|spring|summer|winter|full_year');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'direct_observation|department_report|class_schedule|card_access|sensor_data|manual_entry');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `federal_agency_submitted` SET TAGS ('dbx_business_glossary_term' = 'Federal Agency Submitted');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `instruction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Instruction Percentage');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `observation_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Date');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `organized_research_percentage` SET TAGS ('dbx_business_glossary_term' = 'Organized Research Percentage');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `other_institutional_activities_percentage` SET TAGS ('dbx_business_glossary_term' = 'Other Institutional Activities Percentage');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `other_sponsored_activities_percentage` SET TAGS ('dbx_business_glossary_term' = 'Other Sponsored Activities Percentage');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Date');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `room_use_classification` SET TAGS ('dbx_business_glossary_term' = 'Room Use Classification');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `square_footage_surveyed` SET TAGS ('dbx_business_glossary_term' = 'Square Footage Surveyed');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `survey_end_date` SET TAGS ('dbx_business_glossary_term' = 'Survey End Date');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `survey_methodology` SET TAGS ('dbx_business_glossary_term' = 'Survey Methodology');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `survey_methodology` SET TAGS ('dbx_value_regex' = 'actual_use|modified_traditional|simplified|detailed_analysis');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `survey_notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `survey_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Number');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `survey_number` SET TAGS ('dbx_value_regex' = '^SUS-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `survey_start_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Start Date');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|reviewed|approved|submitted');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `unallowable_activities_percentage` SET TAGS ('dbx_business_glossary_term' = 'Unallowable Activities Percentage');
ALTER TABLE `education_ecm`.`facility`.`space_utilization_survey` ALTER COLUMN `vacant_percentage` SET TAGS ('dbx_business_glossary_term' = 'Vacant Percentage');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `utility_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Utility Meter Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Utility Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `ada_accessible_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accessible Flag');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `baseline_consumption` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `billing_account_number` SET TAGS ('dbx_business_glossary_term' = 'Utility Billing Account Number');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `billing_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Meter Communication Protocol');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Meter Data Source');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'manual_read|AMR|AMI|BMS|utility_bill|estimated');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Decommission Date');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `energy_star_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'ENERGY STAR Eligible Flag');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `grant_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Eligible Flag');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `greenhouse_gas_scope` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Scope');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `greenhouse_gas_scope` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3|not_applicable');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Date');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Meter Internet Protocol (IP) Address');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Meter Latitude');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Meter Location Description');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Meter Longitude');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Meter Manufacturer');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `meter_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Meter Multiplier');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `meter_name` SET TAGS ('dbx_business_glossary_term' = 'Meter Name');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `meter_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Number');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `meter_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Status');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `meter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|maintenance|pending_installation');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Model Number');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `next_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Date');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Meter Notes');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `reading_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Frequency');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `target_reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Reduction Percentage');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `utility_provider` SET TAGS ('dbx_business_glossary_term' = 'Utility Provider Name');
ALTER TABLE `education_ecm`.`facility`.`utility_meter` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Utility Zone Code');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` SET TAGS ('dbx_subdomain' = 'space_management');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `accessibility_feature_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Feature Identifier');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `ada_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Accommodation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project ID');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Facilities Manager ID');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `actual_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Remediation Cost');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `actual_remediation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `ada_coordinator_notes` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Coordinator Notes');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `alternative_accommodation_available` SET TAGS ('dbx_business_glossary_term' = 'Alternative Accommodation Available Indicator');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `alternative_accommodation_description` SET TAGS ('dbx_business_glossary_term' = 'Alternative Accommodation Description');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard Reference');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Status');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|remediation-planned|remediation-in-progress|partially-compliant|not-applicable');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deficiency Description');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `feature_code` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Feature Code');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `feature_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,10}$');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `feature_description` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Feature Description');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `feature_name` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Feature Name');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `feature_type` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Feature Type');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `inspection_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency in Months');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Feature Installation Date');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Feature Indicator');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `is_temporary` SET TAGS ('dbx_business_glossary_term' = 'Temporary Feature Indicator');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `public_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Required Indicator');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `remediation_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Description');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `remediation_priority` SET TAGS ('dbx_business_glossary_term' = 'Remediation Priority Level');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `remediation_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|deferred');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `remediation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Start Date');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Report Date');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `reported_by_user` SET TAGS ('dbx_business_glossary_term' = 'Reported By User');
ALTER TABLE `education_ecm`.`facility`.`accessibility_feature` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Feature Usage Count');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` SET TAGS ('dbx_subdomain' = 'space_management');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `annual_base_rent` SET TAGS ('dbx_business_glossary_term' = 'Annual Base Rent Amount');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `annual_base_rent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `annual_base_rent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Contact Name');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_email` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Email Address');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_phone` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Phone Number');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `counterparty_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `discount_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `escalation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Rate Percentage');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Type');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `escalation_type` SET TAGS ('dbx_value_regex' = 'fixed_percentage|cpi_indexed|fair_market_value|none');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lease_liability_value` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Value');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lease_liability_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lease_liability_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lease_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Number');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Status');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lease_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|renewed|pending_approval');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Lease Term in Months');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'operating|finance|capital|short_term|sublease');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `leased_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Leased Square Footage');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lessor_lessee_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lessor or Lessee Indicator');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `lessor_lessee_indicator` SET TAGS ('dbx_value_regex' = 'lessor|lessee');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rent Payment Frequency');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `permitted_use` SET TAGS ('dbx_business_glossary_term' = 'Permitted Use');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Property Address Line 1');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Property Address Line 2');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_city` SET TAGS ('dbx_business_glossary_term' = 'Property City');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_country_code` SET TAGS ('dbx_business_glossary_term' = 'Property Country Code');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_description` SET TAGS ('dbx_business_glossary_term' = 'Property Description');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Property Postal Code');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `property_state_province` SET TAGS ('dbx_business_glossary_term' = 'Property State or Province');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `renewal_option_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Renewal Options');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `renewal_option_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Term in Months');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `right_of_use_asset_value` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Value');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `right_of_use_asset_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `right_of_use_asset_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `space_use_category` SET TAGS ('dbx_business_glossary_term' = 'Space Use Category');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `termination_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination Option Flag');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Termination Penalty Amount');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`facility`.`lease_agreement` ALTER COLUMN `variable_payment_description` SET TAGS ('dbx_business_glossary_term' = 'Variable Payment Description');
ALTER TABLE `education_ecm`.`facility`.`inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`facility`.`inspection` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Inspection Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `accreditation_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Relevant Flag');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `critical_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiency Count');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `environmental_health_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Health Compliant Flag');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `environmental_health_compliant_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `environmental_health_compliant_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `estimated_renewal_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Renewal Cost');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `fci_score` SET TAGS ('dbx_business_glossary_term' = 'Facilities Condition Index (FCI) Score');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency in Months');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source for Remediation');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `funding_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Status for Remediation');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `funding_status` SET TAGS ('dbx_value_regex' = 'funded|pending_approval|unfunded|deferred');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^INS-[0-9]{8}$');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspector_credentials` SET TAGS ('dbx_business_glossary_term' = 'Inspector Credentials');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `inspector_organization` SET TAGS ('dbx_business_glossary_term' = 'Inspector Organization');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `life_safety_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Safety Compliant Flag');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Inspection Rating');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `pass_fail_determination` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Determination');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `pass_fail_determination` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `recommended_remediation_year` SET TAGS ('dbx_business_glossary_term' = 'Recommended Remediation Year');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Inspection Date');
ALTER TABLE `education_ecm`.`facility`.`inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions During Inspection');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `hazmat_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Inventory Identifier');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_business_glossary_term' = 'Bib Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) ID');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `container_size` SET TAGS ('dbx_business_glossary_term' = 'Container Size');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'bottle|drum|cylinder|tank|carboy|vial');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `epa_tier_ii_reportable` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Tier II Reportable');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `epa_tier_ii_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Tier II Threshold Quantity');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `ghs_pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Pictogram Codes');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|toxic|reactive|oxidizer|carcinogen');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `hazmat_inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `hazmat_inventory_status` SET TAGS ('dbx_value_regex' = 'active|depleted|expired|disposed|quarantined');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `inventory_number` SET TAGS ('dbx_business_glossary_term' = 'Inventory Number');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `nfpa_flammability_rating` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) Flammability Rating');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `nfpa_health_rating` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) Health Rating');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `nfpa_health_rating` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `nfpa_health_rating` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `nfpa_reactivity_rating` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) Reactivity Rating');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `nfpa_special_hazard` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) Special Hazard');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `sara_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Superfund Amendments and Reauthorization Act (SARA) Threshold Quantity');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `sara_title_iii_reportable` SET TAGS ('dbx_business_glossary_term' = 'Superfund Amendments and Reauthorization Act (SARA) Title III Reportable');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `sds_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Reference');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `sds_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Revision Date');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `storage_location_description` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Description');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `education_ecm`.`facility`.`hazmat_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `education_ecm`.`facility`.`project_funding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`facility`.`project_funding` SET TAGS ('dbx_subdomain' = 'project_funding');
ALTER TABLE `education_ecm`.`facility`.`project_funding` SET TAGS ('dbx_association_edges' = 'facility.capital_project,advancement.advancement_fund');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `project_funding_id` SET TAGS ('dbx_business_glossary_term' = 'Project Funding Identifier');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Project Funding - Advancement Fund Id');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Funding - Capital Project Id');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `actual_expenditure_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure from Fund');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Funding Amount');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `allocation_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Authorization Date');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Disbursement Date');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `donor_recognition_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Recognition Required');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Allocation Fiscal Year');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `remaining_allocation` SET TAGS ('dbx_business_glossary_term' = 'Remaining Fund Allocation');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `restriction_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Restriction Compliance Status');
ALTER TABLE `education_ecm`.`facility`.`project_funding` ALTER COLUMN `stewardship_report_date` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Report Date');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` SET TAGS ('dbx_association_edges' = 'facility.facility_asset,compliance.regulatory_requirement');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `asset_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Compliance - Asset Compliance Id');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Compliance - Facility Asset Id');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Technician Identifier');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `facility_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Asset Identifier');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Compliance - Regulatory Requirement Id');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `non_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Notes');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `education_ecm`.`facility`.`asset_compliance` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `education_ecm`.`facility`.`floor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`floor` SET TAGS ('dbx_subdomain' = 'space_management');
ALTER TABLE `education_ecm`.`facility`.`floor` ALTER COLUMN `floor_id` SET TAGS ('dbx_business_glossary_term' = 'Floor Identifier');
ALTER TABLE `education_ecm`.`facility`.`floor` ALTER COLUMN `parent_floor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`facility`.`work_order_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`work_order_template` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`facility`.`work_order_template` ALTER COLUMN `work_order_template_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Template Identifier');
ALTER TABLE `education_ecm`.`facility`.`work_order_template` ALTER COLUMN `parent_work_order_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`facility`.`survey_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`survey_period` SET TAGS ('dbx_subdomain' = 'environmental_compliance');
ALTER TABLE `education_ecm`.`facility`.`survey_period` ALTER COLUMN `survey_period_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Period Identifier');
ALTER TABLE `education_ecm`.`facility`.`survey_period` ALTER COLUMN `prior_survey_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`facility`.`survey_period` ALTER COLUMN `survey_coordinator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`survey_period` ALTER COLUMN `survey_coordinator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`facility`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`crew` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `education_ecm`.`facility`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier');
ALTER TABLE `education_ecm`.`facility`.`crew` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`facility`.`crew` ALTER COLUMN `parent_crew_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`facility`.`crew` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`crew` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`facility`.`crew` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`crew` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`facility`.`crew` ALTER COLUMN `hourly_labor_rate` SET TAGS ('dbx_confidential' = 'true');
