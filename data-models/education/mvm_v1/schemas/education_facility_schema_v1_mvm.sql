-- Schema for Domain: facility | Business: Education | Version: v1_mvm
-- Generated on: 2026-05-06 15:14:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`facility` COMMENT 'Manages campus physical infrastructure including buildings, classrooms, laboratories, residence halls, utilities, and grounds. Tracks space inventory, room utilization, maintenance work orders, capital projects, energy management, and space planning. Supports Archibus operations, ADA compliance, and F&A cost rate space calculations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`facility`.`building` (
    `building_id` BIGINT COMMENT 'Unique identifier for the building. Primary key for the building master record.',
    `campus_id` BIGINT COMMENT 'Reference to the campus on which this building is located. Links to the campus master record.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: FICM (Facilities Inventory and Classification Manual) reporting and utilities/maintenance budget allocation require identifying the primary administrative org unit responsible for each building. Highe',
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
    `floor_id` BIGINT COMMENT 'Foreign key linking to facility.floor. Business justification: A room physically exists on a specific floor within a building. The floor table is the authoritative master reference for floors (floor_id, floor_number, floor_name, floor_type, etc.). room.floor_leve',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic or administrative department to which this room is assigned or allocated. Used for space charge-back, F&A cost allocation, and departmental space reporting.',
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
    `course_id` BIGINT COMMENT 'Foreign key linking to curriculum.course. Business justification: Dedicated instructional labs (chemistry, nursing simulation, engineering) are permanently assigned to specific courses. Accreditation bodies (ABET, ACEN) require lab-to-course ratio documentation. spa',
    `employee_id` BIGINT COMMENT 'Reference to the user or administrator who approved the space assignment. Links to institutional user directory for accountability and audit purposes.',
    `advancement_fund_id` BIGINT COMMENT 'Foreign key linking to advancement.advancement_fund. Business justification: Endowed chairs, named research centers, and program-specific spaces are funded by advancement gifts/endowments. Space assignment records must track which advancement fund supports each space allocatio',
    `grant_account_id` BIGINT COMMENT 'Reference to the sponsored research grant or award funding the space assignment. Applicable for research space assignments funded by external sponsors (NSF, NIH, etc.). Null for institutionally-funded assignments.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic or administrative department to which the space is assigned.',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the faculty member or researcher serving as the principal investigator for research space assignments. Null for non-research assignments. Links to faculty master data.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Space assignments for research labs, clinical spaces, and animal research facilities are governed by specific regulatory requirements (IACUC, biosafety, HIPAA, DEA). The existing animal_research_flag ',
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
    `primary_room_employee_id` BIGINT COMMENT 'Identifier of the person who submitted the room booking request. May be faculty, staff, student, or external party.',
    `recruitment_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.recruitment_event. Business justification: Room bookings for recruitment events link facility reservations to enrollment activities. Event management, space planning, and cross-functional coordination between admissions and facilities require ',
    `room_id` BIGINT COMMENT 'Identifier of the physical room or space being reserved. Links to the room master data in the facility domain.',
    `section_id` BIGINT COMMENT 'Foreign key linking to curriculum.section. Business justification: Exam scheduling, makeup sessions, and special academic events require linking room bookings to the course section they serve. Registrar scheduling reports and ADA accommodation workflows depend on kno',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Work orders are assigned to specific maintenance staff employees for dispatch, accountability, and labor tracking. Essential for facilities management operations, workload balancing, and performance r',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Work orders are generated as corrective actions from audit findings. Linking work_order to the originating audit supports audit remediation tracking, corrective action plan closure, and follow-up audi',
    `building_id` BIGINT COMMENT 'Identifier of the campus building where the work is to be performed, linking to the building master data for location context and space inventory.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to facility.capital_project. Business justification: Work orders are frequently generated as part of capital construction, renovation, or infrastructure improvement projects. Linking work_order to capital_project enables project cost roll-up (labor, mat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work orders need structured cost_center link for facilities maintenance cost allocation, departmental chargebacks, and budget tracking. The charge_to_account text field should be replaced with proper ',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Work order costs must post to specific GL accounts (maintenance expense, repairs, utilities) for financial reporting, budget vs. actual analysis, and NACUBO functional classification. Structured ledge',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic or administrative department that requested the work order, used for cost allocation and service tracking.',
    `pm_schedule_id` BIGINT COMMENT 'Identifier linking the work order to a recurring preventive maintenance schedule or program, used to track compliance with planned maintenance cycles.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Work orders are frequently generated to achieve regulatory compliance (ADA remediation, fire code corrections, OSHA mandates). Linking work_order to the governing regulatory_requirement enables compli',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Work orders for lab repairs, modifications, and equipment maintenance are charged to research awards. Facilities billing, cost recovery, and award budget management require award tracking on work orde',
    `room_id` BIGINT COMMENT 'Identifier of the specific room or space within the building where the work is to be performed, linking to room inventory for precise location and space type.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external contractor or vendor assigned to perform the work, used when work is outsourced rather than performed by internal staff.',
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
    `floor_id` BIGINT COMMENT 'Reference to the specific floor within the building where the asset is located, enabling granular space utilization and maintenance tracking.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic or administrative department responsible for funding or overseeing this preventive maintenance schedule, used for cost allocation and accountability.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PM schedules need structured cost_center link for preventive maintenance budget planning, cost allocation, and departmental chargeback billing. Replacing cost_center_code text field with proper FK ena',
    `employee_id` BIGINT COMMENT 'Reference to the facilities management staff member or system administrator who created this preventive maintenance schedule record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Preventive maintenance schedules are mandated by regulatory requirements (OSHA elevator inspections, EPA equipment checks, fire code testing). The existing plain-text regulatory_standard field is a de',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Preventive maintenance for award-funded research equipment is charged back to awards. Cost recovery systems require award linkage on PM schedules for billing specialized equipment maintenance to spons',
    `room_id` BIGINT COMMENT 'Reference to the specific room or space where the asset is located, supporting detailed space inventory and maintenance coordination.',
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
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Specialized equipment (electron microscopes, flight simulators, surgical mannequins) is owned and managed at the academic program level. Accreditation bodies (ABET, ACEN, CAEP) require program-level e',
    `building_id` BIGINT COMMENT 'Identifier of the building where the asset is physically located. Links to the building master record for space planning and Facilities and Administrative (F&A) cost allocation.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to facility.capital_project. Business justification: Assets are frequently procured, installed, or commissioned as part of capital construction or renovation projects. Linking asset to capital_project enables tracking of which assets were acquired under',
    `employee_id` BIGINT COMMENT 'Identifier of the faculty or staff member designated as the primary custodian or responsible party for the asset. Used for accountability and communication regarding asset status.',
    `floor_id` BIGINT COMMENT 'Foreign key linking to facility.floor. Business justification: A physical facility asset (HVAC unit, elevator, boiler, etc.) is located on a specific floor within a building. The floor table is the authoritative reference for floor-level location data. asset.floo',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic or administrative department responsible for the asset. Used for cost allocation and maintenance charge-back.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulated assets (elevators, boilers, fume hoods, radiation equipment, biosafety cabinets) are subject to specific regulatory requirements (OSHA, EPA, state codes). Linking asset to its governing regu',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to advancement.campaign. Business justification: Major facility construction/renovation projects are typically funded through capital campaigns. Linking capital_project to campaign enables tracking campaign progress, gift counting, donor stewardship',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Capital project managers are internal employees with budget authority and accountability. Critical for project governance, financial reporting, and compliance tracking. project_manager is currently ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Capital construction projects must comply with building codes, ADA accessibility standards, environmental regulations (NEPA, wetlands), historic preservation requirements, and state construction stand',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Capital projects in higher-ed are initiated and governed by a sponsoring academic or administrative unit (college, department). Budget approval workflows, space planning, and project governance report',
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

CREATE OR REPLACE TABLE `education_ecm`.`facility`.`floor` (
    `floor_id` BIGINT COMMENT 'Primary key for floor',
    `building_id` BIGINT COMMENT 'Reference to the building that contains this floor. Links floor to its parent building structure.',
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
    `finish_type` STRING COMMENT 'Primary flooring material or finish type on the floor. Impacts maintenance costs, cleaning schedules, and replacement planning.',
    `fire_zone` STRING COMMENT 'Fire safety zone designation for the floor. Used for fire alarm system configuration, emergency response planning, and code compliance.',
    `floor_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the floor within the institutions facility coding system. Used for space accounting and reporting.',
    `floor_name` STRING COMMENT 'Common or official name of the floor (e.g., Main Floor, Engineering Wing, Administrative Level). Used for wayfinding and communication.',
    `floor_number` STRING COMMENT 'The floor number or level designation within the building (e.g., 1, 2, B1 for basement, M for mezzanine, G for ground). May include alphanumeric codes for special levels.',
    `floor_status` STRING COMMENT 'Current operational status of the floor. Indicates availability for space assignment and occupancy.',
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
    `usable_area_sqft` DECIMAL(18,2) COMMENT 'Usable square footage including assignable space plus circulation areas on the floor. Excludes only major vertical penetrations and building service areas.',
    `wireless_coverage` BOOLEAN COMMENT 'Indicates whether the floor has complete wireless network coverage. Important for academic technology planning and student services.',
    CONSTRAINT pk_floor PRIMARY KEY(`floor_id`)
) COMMENT 'Master reference table for floor. Referenced by floor_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_campus_id` FOREIGN KEY (`campus_id`) REFERENCES `education_ecm`.`facility`.`campus`(`campus_id`);
ALTER TABLE `education_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `education_ecm`.`facility`.`floor`(`floor_id`);
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ADD CONSTRAINT `fk_facility_space_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_parent_booking_room_booking_id` FOREIGN KEY (`parent_booking_room_booking_id`) REFERENCES `education_ecm`.`facility`.`room_booking`(`room_booking_id`);
ALTER TABLE `education_ecm`.`facility`.`room_booking` ADD CONSTRAINT `fk_facility_room_booking_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `education_ecm`.`facility`.`asset`(`asset_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `education_ecm`.`facility`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `education_ecm`.`facility`.`work_order` ADD CONSTRAINT `fk_facility_work_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `education_ecm`.`facility`.`asset`(`asset_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `education_ecm`.`facility`.`floor`(`floor_id`);
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `education_ecm`.`facility`.`capital_project`(`capital_project_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `education_ecm`.`facility`.`floor`(`floor_id`);
ALTER TABLE `education_ecm`.`facility`.`asset` ADD CONSTRAINT `fk_facility_asset_room_id` FOREIGN KEY (`room_id`) REFERENCES `education_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `education_ecm`.`facility`.`capital_project` ADD CONSTRAINT `fk_facility_capital_project_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`floor` ADD CONSTRAINT `fk_facility_floor_building_id` FOREIGN KEY (`building_id`) REFERENCES `education_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `education_ecm`.`facility`.`floor` ADD CONSTRAINT `fk_facility_floor_parent_floor_id` FOREIGN KEY (`parent_floor_id`) REFERENCES `education_ecm`.`facility`.`floor`(`floor_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`facility` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `education_ecm`.`facility` SET TAGS ('dbx_domain' = 'facility');
ALTER TABLE `education_ecm`.`facility`.`building` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`building` SET TAGS ('dbx_subdomain' = 'campus_infrastructure');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`building` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`facility`.`room` SET TAGS ('dbx_subdomain' = 'campus_infrastructure');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `floor_id` SET TAGS ('dbx_business_glossary_term' = 'Floor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`room` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
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
ALTER TABLE `education_ecm`.`facility`.`campus` SET TAGS ('dbx_subdomain' = 'campus_infrastructure');
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
ALTER TABLE `education_ecm`.`facility`.`space_assignment` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `space_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Space Assignment Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Advancement Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `education_ecm`.`facility`.`space_assignment` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`facility`.`room_booking` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `room_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Room Booking ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `parent_booking_room_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Booking ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `primary_room_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `primary_room_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `primary_room_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `recruitment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `education_ecm`.`facility`.`room_booking` ALTER COLUMN `section_id` SET TAGS ('dbx_business_glossary_term' = 'Section Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`facility`.`work_order` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `education_ecm`.`facility`.`work_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
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
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `floor_id` SET TAGS ('dbx_business_glossary_term' = 'Floor ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`pm_schedule` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
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
ALTER TABLE `education_ecm`.`facility`.`asset` SET TAGS ('dbx_subdomain' = 'campus_infrastructure');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Asset ID');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Employee ID');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `floor_id` SET TAGS ('dbx_business_glossary_term' = 'Floor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`facility`.`asset` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`facility`.`capital_project` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project ID');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Campaign Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`facility`.`capital_project` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Org Unit Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`facility`.`floor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`facility`.`floor` SET TAGS ('dbx_subdomain' = 'campus_infrastructure');
ALTER TABLE `education_ecm`.`facility`.`floor` ALTER COLUMN `floor_id` SET TAGS ('dbx_business_glossary_term' = 'Floor Identifier');
ALTER TABLE `education_ecm`.`facility`.`floor` ALTER COLUMN `parent_floor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
