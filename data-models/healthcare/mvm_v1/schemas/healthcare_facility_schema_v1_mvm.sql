-- Schema for Domain: facility | Business: Healthcare | Version: v1_mvm
-- Generated on: 2026-05-04 19:04:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm`.`facility` COMMENT 'Healthcare facility and physical infrastructure management. Owns hospitals, clinics, outpatient centers, care sites, bed management, room/unit configuration, OR/ICU/ED space, equipment assets, biomedical engineering, preventive maintenance, environmental services, facility licensing, and accreditation status. Supports multi-site integrated delivery networks. Integrates with SAP PM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`care_site` (
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care delivery location within the integrated delivery network (IDN). Primary key for the care site entity.',
    `organization_id` BIGINT COMMENT 'Foreign key linking to facility.organization. Business justification: A care site (hospital, clinic, outpatient center) belongs to a parent organization (health system or IDN). Adding organization_id to care_site establishes the ownership link between a physical care de',
    `parent_care_site_id` BIGINT COMMENT 'Reference to the parent care site in the organizational hierarchy, enabling health system→region→market→campus→site relationships. Null for top-level health system entities.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Care sites are enrolled in specific compliance programs (CMS CoP, TJC, state health department). Compliance officers must know which programs govern each care site for audit scheduling, obligation tra',
    `npi_registry_id` BIGINT COMMENT 'Federal Employer Identification Number (EIN) assigned by the IRS for tax reporting and revenue cycle operations. Used in claims submission and payer contracting.',
    `accreditation_body` STRING COMMENT 'Organization providing voluntary accreditation for the care site. Accreditation demonstrates compliance with national quality and safety standards and may satisfy CMS deemed status requirements.. Valid values are `the_joint_commission|dnv_healthcare|hfap|cihq|aaahc|not_accredited`',
    `accreditation_expiration_date` DATE COMMENT 'Date the current accreditation expires. Triggers survey preparation and ensures continuous deemed status for Medicare participation.',
    `accreditation_status` STRING COMMENT 'Current status of voluntary accreditation. Accredited status may grant deemed status for Medicare Conditions of Participation and is often required for payer contracting.. Valid values are `accredited|provisional|denied|withdrawn|not_applicable`',
    `address_line_1` STRING COMMENT 'Primary street address of the care site including street number, street name, and unit/suite if applicable. Used for facility licensing, patient navigation, and emergency services dispatch.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building name, floor, department, or mail stop. Optional field for complex campus environments.',
    `ccn` STRING COMMENT 'Six-character CMS Certification Number (formerly Provider Number) assigned to Medicare-certified facilities. First two digits indicate state, third-fourth indicate facility type.. Valid values are `^[0-9A-Z]{6}$`',
    `city` STRING COMMENT 'City or municipality where the care site is physically located. Used for geographic reporting, service area analysis, and regulatory jurisdiction determination.',
    `closure_date` DATE COMMENT 'Date the care site permanently ceased operations. Used for historical analysis, medical records retention planning, and network capacity reporting.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code. Supports international IDN operations and cross-border care coordination.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish where the care site is located. Used for public health reporting, certificate of need (CON) analysis, and regional health planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this care site record was first created in the system. Used for audit trail and data lineage tracking.',
    `critical_access_hospital` BOOLEAN COMMENT 'Indicates whether the facility is designated as a Critical Access Hospital under the Medicare Rural Hospital Flexibility Program. CAH status provides cost-based reimbursement and reduced regulatory requirements.',
    `disproportionate_share_hospital` BOOLEAN COMMENT 'Indicates whether the facility qualifies for Medicare DSH payments due to serving a disproportionate share of low-income patients. Affects Medicare reimbursement rates.',
    `email_address` STRING COMMENT 'Primary email address for administrative and clinical correspondence. Used for referral notifications, quality reporting, and payer communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_services_available` BOOLEAN COMMENT 'Indicates whether the care site operates a 24/7 emergency department. Determines EMTALA obligations, EMS transport protocols, and trauma network participation.',
    `facility_type` STRING COMMENT 'Classification of the care delivery location based on services provided and regulatory designation. Determines applicable licensing, staffing, and quality reporting requirements. [ENUM-REF-CANDIDATE: acute_care_hospital|critical_access_hospital|ambulatory_surgery_center|clinic|urgent_care|rehabilitation_facility|skilled_nursing_facility — 7 candidates stripped; promote to reference product]',
    `fax_number` STRING COMMENT 'Fax number for medical records requests, prior authorizations, and clinical documentation exchange. Still widely used in healthcare for HIPAA-compliant transmission.',
    `go_live_date` DATE COMMENT 'Date the care site began operations and started accepting patients. Used for historical trending, market entry analysis, and anniversary planning.',
    `hierarchy_effective_date` DATE COMMENT 'Date the current organizational hierarchy relationship became effective. Supports time-variant hierarchy reporting for mergers, acquisitions, and reorganizations.',
    `hierarchy_level` STRING COMMENT 'Position of this care site within the IDN organizational hierarchy. Supports multi-level reporting, cost allocation, and governance structure representation.. Valid values are `health_system|region|market|campus|site`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this care site record was most recently modified. Used for change tracking, data quality monitoring, and downstream system synchronization.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the care site in decimal degrees. Used for geospatial analysis, service area mapping, and distance-based referral routing.',
    `license_effective_date` DATE COMMENT 'Date the current facility license became effective. Used to track license renewal cycles and ensure continuous compliance.',
    `license_expiration_date` DATE COMMENT 'Date the current facility license expires. Triggers renewal workflows and compliance monitoring to prevent operational disruption.',
    `license_number` STRING COMMENT 'State-issued facility license number. Required for legal operation and must be displayed publicly per state regulations.',
    `licensed_bed_capacity` STRING COMMENT 'Total number of inpatient beds the facility is licensed to operate by the state health department. Determines staffing requirements, certificate of need compliance, and CMS cost report bed counts.',
    `licensure_status` STRING COMMENT 'Current state of the facility license issued by the state health department. Active status is required for legal operation and Medicare/Medicaid participation.. Valid values are `active|provisional|suspended|revoked|expired`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the care site in decimal degrees. Used for geospatial analysis, service area mapping, and distance-based referral routing.',
    `medicaid_provider_number` STRING COMMENT 'State-specific Medicaid provider identification number. Required for Medicaid claims submission and varies by state Medicaid program.',
    `medicare_provider_number` STRING COMMENT 'Legacy Medicare provider identification number, now replaced by CCN but still used in some legacy systems and historical reporting.',
    `operational_status` STRING COMMENT 'Current operational state of the care site. Active status indicates the site is open and accepting patients. Used for capacity planning, referral routing, and network adequacy reporting.. Valid values are `active|inactive|under_construction|temporarily_closed|permanently_closed`',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the care site. Determines tax status, regulatory oversight, and eligibility for certain federal programs and grants.. Valid values are `government_federal|government_state|government_local|nonprofit|for_profit|physician_owned`',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the care site. Used for patient inquiries, referral coordination, and emergency contact.',
    `postal_code` STRING COMMENT 'Five-digit or nine-digit ZIP code for the care site location. Used for geographic market segmentation, service area mapping, and population health analytics.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `site_name` STRING COMMENT 'Official business name of the care delivery location as registered with state licensing authorities and used in patient-facing communications.',
    `site_npi` STRING COMMENT 'Type 2 NPI assigned to the organizational care site by CMS for billing and identification purposes. Required for Medicare/Medicaid claims submission.. Valid values are `^[0-9]{10}$`',
    `sole_community_hospital` BOOLEAN COMMENT 'Indicates whether the facility is designated as a Sole Community Hospital, providing enhanced Medicare reimbursement for rural hospitals that are the sole source of care in their area.',
    `staffed_bed_capacity` STRING COMMENT 'Number of beds currently staffed and available for patient occupancy. May be less than licensed capacity due to staffing constraints or seasonal demand patterns.',
    `state` STRING COMMENT 'Two-letter US state or territory postal abbreviation. Determines applicable state licensing board, Medicaid program, and health department jurisdiction.. Valid values are `^[A-Z]{2}$`',
    `teaching_status` BOOLEAN COMMENT 'Indicates whether the facility is a teaching hospital with approved residency programs. Teaching status affects CMS reimbursement through Graduate Medical Education (GME) payments and indirect medical education (IME) adjustments.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the care site location. Used for scheduling, appointment coordination, and timestamp normalization across multi-site IDN operations.',
    `trauma_level` STRING COMMENT 'American College of Surgeons trauma center verification level. Indicates capability to provide comprehensive trauma care and determines EMS transport protocols.. Valid values are `level_1|level_2|level_3|level_4|level_5|not_designated`',
    `website_url` STRING COMMENT 'Public-facing website URL for the care site. Provides patient access to services information, provider directories, and online scheduling.',
    CONSTRAINT pk_care_site PRIMARY KEY(`care_site_id`)
) COMMENT 'Master record for every physical care delivery location within the integrated delivery network (IDN), including hospitals, clinics, outpatient centers, urgent care sites, ambulatory surgery centers, rehabilitation facilities, and specialty care locations. Captures site name, NPI, CMS certification number (CCN), facility type, tax ID, physical address, licensure status, accreditation body (TJC, DNV, HFAP), accreditation expiration, licensed bed capacity, trauma level designation, teaching status, ownership entity, operational status, go-live date, and operating hours configuration. Supports IDN organizational hierarchy via self-referential parent site reference defining health system→region→market→campus→site relationships, with hierarchy level and effective dating. Catalogs clinical services and programs offered at the site (cardiac surgery, trauma level, comprehensive stroke center, NICU level, radiation oncology, behavioral health, telehealth) with service line, CMS service type code, accreditation/certification requirements, and active status. SSOT for facility identity, organizational hierarchy, service capability, and site operating configuration across the enterprise.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`building` (
    `building_id` BIGINT COMMENT 'Unique identifier for the building. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the care site or facility that owns or operates this building.',
    `ada_compliant` BOOLEAN COMMENT 'Indicates whether the building meets Americans with Disabilities Act accessibility requirements including ramps, elevators, restrooms, and signage.',
    `address_line_1` STRING COMMENT 'Primary street address of the building including street number and name. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building designation. Organizational contact data classified as confidential.',
    `annual_property_tax_amount` DECIMAL(18,2) COMMENT 'Annual property tax liability for the building in US dollars. Used for budgeting and financial planning.',
    `building_code` STRING COMMENT 'Unique alphanumeric code assigned to the building for internal identification and facility management systems. Used in SAP PM and facility operations.. Valid values are `^[A-Z0-9]{2,20}$`',
    `building_name` STRING COMMENT 'Official name of the building as recognized by the organization and used in signage, wayfinding, and facility documentation.',
    `building_type` STRING COMMENT 'Primary functional classification of the building indicating its predominant use within the healthcare delivery network.. Valid values are `clinical|administrative|research|parking|mixed_use|support`',
    `city` STRING COMMENT 'City or municipality where the building is located. Organizational contact data classified as confidential.',
    `cms_certification_number` STRING COMMENT 'CMS-issued certification number (CCN) authorizing participation in Medicare and Medicaid programs. Required for federal reimbursement.',
    `construction_year` STRING COMMENT 'Year the building was originally constructed. Used for capital planning, depreciation calculations, and facility lifecycle management.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the building is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this building record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when the building record became active in the system or when the building was placed into service.',
    `electrical_service_capacity_kva` DECIMAL(18,2) COMMENT 'Total electrical service capacity of the building measured in kilovolt-amperes. Used for load planning, equipment installation approval, and utility management.',
    `emergency_generator_capacity_kw` DECIMAL(18,2) COMMENT 'Total capacity of emergency backup generator systems in kilowatts. Critical for life safety systems, operating rooms, intensive care units, and emergency departments.',
    `emergency_generator_coverage_type` STRING COMMENT 'Scope of building systems and areas covered by emergency generator backup power. Determines operational resilience during utility outages.. Valid values are `full_building|life_safety_only|critical_systems|partial`',
    `facility_license_expiration_date` DATE COMMENT 'Expiration date of the state facility license. Tracked for renewal planning and regulatory compliance monitoring.',
    `facility_license_number` STRING COMMENT 'State-issued license number authorizing operation of healthcare services within the building. Required for regulatory compliance and reimbursement.',
    `fire_safety_classification` STRING COMMENT 'Building construction type classification based on fire resistance ratings and combustibility of structural elements per International Building Code.. Valid values are `type_i|type_ii|type_iii|type_iv|type_v`',
    `gross_square_footage` DECIMAL(18,2) COMMENT 'Total interior floor area of the building measured in square feet, including all floors and spaces. Used for space utilization analysis and facility cost allocation.',
    `helipad_available` BOOLEAN COMMENT 'Indicates whether the building has a rooftop or ground-level helipad for emergency medical transport. Critical for trauma centers and tertiary care facilities.',
    `hvac_system_type` STRING COMMENT 'Primary type of heating, ventilation, and air conditioning system serving the building. Critical for infection control, environmental services, and energy management.. Valid values are `central_chilled_water|variable_air_volume|constant_air_volume|heat_pump|split_system|packaged_unit`',
    `insurance_policy_number` STRING COMMENT 'Property and casualty insurance policy number covering the building. Used for risk management and claims processing.',
    `joint_commission_accreditation_expiration_date` DATE COMMENT 'Expiration date of The Joint Commission accreditation. Tracked for survey preparation and continuous compliance.',
    `joint_commission_accreditation_status` STRING COMMENT 'Current accreditation status from The Joint Commission indicating compliance with national healthcare quality and safety standards.. Valid values are `accredited|provisional|denied|not_applicable|pending`',
    `last_major_renovation_year` STRING COMMENT 'Year of the most recent major renovation or significant capital improvement project affecting the building structure or systems.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this building record was most recently modified. Used for audit trail and change tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the building in decimal degrees. Used for mapping, emergency response, and logistics planning.',
    `leed_certification_level` STRING COMMENT 'Level of LEED green building certification achieved by the building. Indicates sustainability performance and environmental design standards.. Valid values are `certified|silver|gold|platinum|not_certified`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the building in decimal degrees. Used for mapping, emergency response, and logistics planning.',
    `medical_gas_system_installed` BOOLEAN COMMENT 'Indicates whether the building has a medical gas distribution system for oxygen, medical air, nitrous oxide, and vacuum services. Required for clinical buildings.',
    `net_usable_square_footage` DECIMAL(18,2) COMMENT 'Usable interior floor area excluding mechanical spaces, circulation, and structural elements. Used for space planning and departmental allocation.',
    `number_of_elevators` STRING COMMENT 'Total count of passenger and service elevators installed in the building. Used for vertical transportation capacity planning and maintenance scheduling.',
    `number_of_floors` STRING COMMENT 'Total count of floors in the building including basement and sub-basement levels. Used for elevator planning, emergency evacuation, and vertical transportation analysis.',
    `operational_status` STRING COMMENT 'Current operational state of the building indicating whether it is in service, under construction, renovation, or decommissioned.. Valid values are `active|inactive|under_construction|under_renovation|decommissioned|planned`',
    `ownership_type` STRING COMMENT 'Legal ownership or control arrangement for the building. Impacts financial reporting, capital planning, and operational decision-making.. Valid values are `owned|leased|ground_lease|joint_venture|managed`',
    `parking_spaces_count` STRING COMMENT 'Total number of parking spaces associated with or adjacent to the building. Used for access planning, patient experience, and workforce management.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the building location. Organizational contact data classified as confidential.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `property_tax_parcel_number` STRING COMMENT 'Local government assessor parcel number used for property tax assessment and real estate records.',
    `replacement_value_amount` DECIMAL(18,2) COMMENT 'Estimated cost to replace the building at current construction prices. Used for insurance coverage determination and capital planning.',
    `seismic_zone` STRING COMMENT 'Seismic design category or zone classification indicating the level of earthquake risk and required structural design standards for the building location.. Valid values are `zone_0|zone_1|zone_2|zone_3|zone_4`',
    `sprinkler_system_type` STRING COMMENT 'Type of automatic fire sprinkler system installed in the building. Critical for fire safety compliance and insurance underwriting.. Valid values are `wet_pipe|dry_pipe|pre_action|deluge|none`',
    `state_province` STRING COMMENT 'Two-letter state or province code where the building is located. Organizational contact data classified as confidential.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date when the building was decommissioned, sold, or otherwise removed from active service. Null for active buildings.',
    CONSTRAINT pk_building PRIMARY KEY(`building_id`)
) COMMENT 'Physical building or structure associated with a care site. Tracks building name, code, address, construction year, square footage, number of floors, building type (clinical, administrative, research, parking), fire safety classification, seismic zone, HVAC system type, electrical capacity, emergency generator coverage, and current operational status. Supports facilities management, capital planning, and environmental services operations.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`unit` (
    `unit_id` BIGINT COMMENT 'Unique identifier for the clinical or administrative unit within the healthcare facility. Primary key.',
    `accreditation_status_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_status. Business justification: Clinical units (Chest Pain Center, Stroke Unit, NICU) hold unit-level accreditation status (ACC, AHA, state designations). accreditation_status links to care_site but not unit. Unit-level accreditatio',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: A clinical or administrative unit (ICU, ED, OR suite floor) physically resides within a specific building. While unit already links to care_site, a care site may span multiple buildings, so the unit-t',
    `care_site_id` BIGINT COMMENT 'Reference to the parent facility or building where this unit is located. Links to the facility master data product.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Unit management accountability requires linking the manager to their clinician record for credentialing verification, privileging status, and regulatory reporting. Hospitals must track which credentia',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Clinical units (ICU, ED, NICU) are governed by specific compliance programs (CMS Conditions of Participation, infection control programs). Compliance officers track unit-level program enrollment for d',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Hospital units are organized by specialty service line (cardiology, oncology, neurology). Linking unit to specialty supports specialty-based staffing models, nurse-to-patient ratio planning, and servi',
    `accepts_admissions` BOOLEAN COMMENT 'Boolean flag indicating whether the unit is currently accepting new patient admissions. False when the unit is at capacity, under diversion, or temporarily closed to new admissions.',
    `accepts_transfers` BOOLEAN COMMENT 'Boolean flag indicating whether the unit is currently accepting patient transfers from other units or facilities. Used in bed management and patient flow coordination.',
    `acuity_level` STRING COMMENT 'Typical patient acuity level served by the unit. Critical (ICU, CCU), acute (step-down, telemetry), intermediate (med-surg), general (rehab, skilled nursing), ambulatory (outpatient clinics).. Valid values are `critical|acute|intermediate|general|ambulatory`',
    `age_restriction` STRING COMMENT 'Age restriction policy for the unit. Pediatric-only (NICU, PICU, pediatric floors), adult-only (most general units), geriatric-only (specialized elder care), or all ages (ED, some outpatient clinics).. Valid values are `pediatric_only|adult_only|geriatric_only|all_ages`',
    `air_changes_per_hour` STRING COMMENT 'Number of complete air changes per hour in the unit. Minimum 6 ACH for general patient rooms, 12+ ACH for isolation rooms, 15+ ACH for operating rooms per ASHRAE and CDC guidelines.',
    `chest_pain_center_accreditation` BOOLEAN COMMENT 'Boolean flag indicating whether the unit (typically ED or cardiac unit) holds accreditation as a Chest Pain Center from the American College of Cardiology or Society of Cardiovascular Patient Care.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the unit record was first created in the system. Used for audit trail and data lineage tracking.',
    `department_code` STRING COMMENT 'Short alphanumeric department code used in operational systems for grouping units into clinical or administrative departments. Used for reporting, scheduling, and organizational hierarchy.. Valid values are `^[A-Z0-9]{2,8}$`',
    `effective_date` DATE COMMENT 'Date when the unit became operational or when the current configuration became effective. Used for historical tracking and regulatory reporting.',
    `electronic_health_record_system` STRING COMMENT 'Name and version of the Electronic Health Record (EHR) system used in the unit, such as Epic Hyperspace 2023, Cerner Millennium PowerChart, or MEDITECH Expanse. Used for interoperability and training planning.',
    `emergency_power_backup` BOOLEAN COMMENT 'Boolean flag indicating whether the unit has emergency generator backup power. Required for critical care units (ICU, OR, ED, NICU) per NFPA 99 and Joint Commission Life Safety Standards.',
    `expiration_date` DATE COMMENT 'Date when the unit was closed, decommissioned, or when the current configuration expired. Null for active units. Used for historical tracking and capacity planning.',
    `floor_number` STRING COMMENT 'Physical floor or level within the building where the unit is located. May be numeric (1, 2, 3) or alphanumeric (G for ground, B1 for basement 1, M for mezzanine).',
    `gender_restriction` STRING COMMENT 'Gender restriction policy for the unit. Male-only or female-only for certain inpatient units (e.g., obstetrics, urology). Mixed for most units. Not applicable for procedural or diagnostic units.. Valid values are `male_only|female_only|mixed|not_applicable`',
    `hvac_system_type` STRING COMMENT 'Type of HVAC system serving the unit, such as Central Air, Variable Air Volume (VAV), Dedicated Outdoor Air System (DOAS), or Negative Pressure Isolation System. Critical for infection control and environmental safety.',
    `infection_control_zone` STRING COMMENT 'Infection control risk classification for the unit. Standard (general units), enhanced (oncology, transplant), high-risk (ICU, burn unit), isolation (dedicated infectious disease units). Drives environmental services protocols.. Valid values are `standard|enhanced|high_risk|isolation`',
    `is_twenty_four_seven` BOOLEAN COMMENT 'Boolean flag indicating whether the unit operates 24 hours a day, 7 days a week. True for ICU, ED, inpatient floors. False for outpatient clinics, procedural units with scheduled hours.',
    `isolation_room_count` STRING COMMENT 'Number of isolation rooms within the unit designed for patients requiring infection control precautions (contact, droplet, or airborne isolation). Critical for infection prevention and Healthcare-Associated Infection (HAI) management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the unit record was last updated in the system. Used for audit trail, change tracking, and data quality monitoring.',
    `licensed_bed_count` STRING COMMENT 'Total number of beds the unit is licensed to operate by state or federal regulatory authorities. This is the maximum legal capacity and is reported to CMS and state health departments.',
    `magnet_recognition` BOOLEAN COMMENT 'Boolean flag indicating whether the unit is part of a Magnet-recognized nursing program by the American Nurses Credentialing Center (ANCC). Magnet recognition signifies excellence in nursing care and patient outcomes.',
    `medical_gas_system` STRING COMMENT 'Type of medical gas system installed in the unit, such as Oxygen, Medical Air, Vacuum, Full Surgical Suite Gases (O2, N2O, Medical Air, Vacuum), or None. Critical for clinical operations and safety inspections.',
    `negative_pressure_room_count` STRING COMMENT 'Number of negative pressure (airborne infection isolation) rooms within the unit, used for patients with airborne infectious diseases such as tuberculosis, measles, or COVID-19. Subset of isolation rooms.',
    `nurse_call_system_type` STRING COMMENT 'Type of nurse call system installed in the unit, such as Wired Pillow Speaker, Wireless Badge System, Integrated EMR Alert System, or Mobile App-Based. Used for patient safety and response time monitoring.',
    `nurse_to_patient_ratio` STRING COMMENT 'Target nurse-to-patient staffing ratio for the unit, expressed as 1:X (e.g., 1:2 for ICU, 1:4 for step-down, 1:6 for med-surg). Used for staffing planning and quality benchmarking.. Valid values are `^1:[0-9]{1,2}$`',
    `operational_hours_end` STRING COMMENT 'Daily end time for unit operations in HH:MM 24-hour format. For 24/7 units, this is typically 23:59. For outpatient or procedural units, this reflects scheduled closing time.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `operational_hours_start` STRING COMMENT 'Daily start time for unit operations in HH:MM 24-hour format. For 24/7 units (ICU, ED), this is typically 00:00. For outpatient or procedural units, this reflects scheduled opening time.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `revenue_center_code` STRING COMMENT 'Four-digit revenue center code used on UB-04 claims for billing and reimbursement. Maps to CMS revenue code standards (e.g., 0100-0219 for room and board, 0300-0329 for laboratory).. Valid values are `^[0-9]{4}$`',
    `square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the units physical space. Used for facility planning, space utilization analysis, and environmental services scheduling.',
    `staffed_bed_count` STRING COMMENT 'Number of beds currently staffed and available for patient occupancy. Staffed bed count is typically less than or equal to licensed bed count and reflects actual operational capacity based on workforce availability.',
    `stroke_center_designation` STRING COMMENT 'Stroke center certification level for units providing acute stroke care. Comprehensive (highest), primary, acute stroke ready, or not designated. Impacts patient routing and quality reporting.. Valid values are `comprehensive|primary|acute_ready|not_designated`',
    `teaching_unit_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the unit is designated as a teaching unit where medical residents, fellows, nursing students, or other trainees receive clinical education. Impacts staffing models and documentation requirements.',
    `telemetry_monitoring_capability` BOOLEAN COMMENT 'Boolean flag indicating whether the unit has continuous cardiac telemetry monitoring capability. True for ICU, CCU, step-down, and telemetry units. False for general med-surg and outpatient units.',
    `trauma_level` STRING COMMENT 'Trauma center level designation for Emergency Department (ED) units. Level 1 is highest capability (comprehensive trauma care), Level 4 is basic. Not applicable for non-ED units.. Valid values are `level_1|level_2|level_3|level_4|not_applicable`',
    `unit_code` STRING COMMENT 'Short alphanumeric code used to identify the unit in operational systems, scheduling, and Admit Discharge Transfer (ADT) workflows. Typically 2-10 characters.. Valid values are `^[A-Z0-9]{2,10}$`',
    `unit_name` STRING COMMENT 'Full descriptive name of the unit, such as Medical Surgical Floor 3 West, Intensive Care Unit (ICU) North, Emergency Department (ED) Main, or Operating Room (OR) Suite B.',
    `unit_status` STRING COMMENT 'Current operational status of the unit. Active units are open and accepting patients. Inactive or temporarily closed units are not operational. Under construction units are being built or renovated. Decommissioned units are permanently closed.. Valid values are `active|inactive|under_construction|temporarily_closed|decommissioned`',
    `unit_type` STRING COMMENT 'High-level classification of the units operational purpose: inpatient (patient stays overnight), outpatient (same-day care), procedural (OR, cath lab), diagnostic (radiology, lab), administrative (offices), or support (pharmacy, supply).. Valid values are `inpatient|outpatient|procedural|diagnostic|administrative|support`',
    `wing_or_section` STRING COMMENT 'Wing, section, or zone designation within the floor, such as North, South, East, West, Tower A, Pavilion B. Used for wayfinding and spatial organization.',
    CONSTRAINT pk_unit PRIMARY KEY(`unit_id`)
) COMMENT 'Clinical or administrative unit within a building, such as ICU, ED, OR suite, NICU, med-surg floor, radiology department, pharmacy, or administrative wing. Captures unit name, unit code, unit type (inpatient, outpatient, procedural, diagnostic, administrative), specialty service line, licensed bed count, staffed bed count, isolation room count, negative pressure room count, unit manager, and operational hours. Supports ADT workflows, bed management, and staffing.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`room` (
    `room_id` BIGINT COMMENT 'Unique identifier for the room. Primary key for the room entity.',
    `care_site_id` BIGINT COMMENT 'Reference to the parent facility or hospital where this room is located. Links to the facility master data.',
    `unit_id` BIGINT COMMENT 'Reference to the parent unit or department within the facility where this room is located. Links to the unit master data.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the room by relevant accrediting bodies (e.g., The Joint Commission, AAAHC). Impacts operational authorization and reimbursement eligibility.. Valid values are `accredited|provisional|not_accredited|pending`',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the room is currently active and available for use in operational systems. Supports soft-delete patterns and historical record retention.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the room meets ADA accessibility requirements for patients and staff with disabilities. Required for regulatory compliance and patient access.',
    `bariatric_capable_flag` BOOLEAN COMMENT 'Indicates whether the room is equipped and structurally reinforced to accommodate bariatric patients (typically over 350 lbs). Includes specialized beds, lifts, and wider doorways.',
    `bed_count` STRING COMMENT 'Number of patient beds or stretchers that can be accommodated in the room. Used for bed management, capacity planning, and CMS reporting.',
    `boom_configuration` STRING COMMENT 'Description of ceiling-mounted equipment boom configuration in the room (e.g., single boom, dual boom, articulating arm). Relevant for OR and ICU rooms with suspended equipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the room record was first created in the system. Audit trail for data lineage and compliance.',
    `effective_from_date` DATE COMMENT 'Date from which the current room configuration, assignment, or status became effective. Supports temporal tracking and historical analysis.',
    `effective_to_date` DATE COMMENT 'Date until which the current room configuration, assignment, or status is valid. Null indicates current/active record. Supports temporal tracking and historical analysis.',
    `emergency_power_flag` BOOLEAN COMMENT 'Indicates whether the room is connected to emergency backup power systems. Critical for life-safety equipment in ORs, ICUs, and emergency departments.',
    `hand_hygiene_station_count` STRING COMMENT 'Number of hand hygiene stations (sinks or alcohol-based hand rub dispensers) in the room. Critical for infection prevention compliance and Joint Commission accreditation.',
    `hvac_air_exchange_rate` DECIMAL(18,2) COMMENT 'Number of complete air changes per hour (ACH) provided by the HVAC system. Critical for infection control, OR sterility, and regulatory compliance per ASHRAE 170.',
    `imaging_integration_flag` BOOLEAN COMMENT 'Indicates whether the room has integrated imaging equipment (e.g., C-arm, fluoroscopy, intraoperative CT/MRI). Common in hybrid ORs and interventional procedure rooms.',
    `isolation_capable_flag` BOOLEAN COMMENT 'Indicates whether the room is equipped and certified for isolation of infectious patients. Critical for infection prevention and control workflows.',
    `last_deep_clean_date` DATE COMMENT 'Date of the most recent terminal or deep cleaning of the room. Used for infection prevention tracking, environmental services scheduling, and outbreak investigation.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection of the room. Used for compliance tracking and accreditation readiness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the room record was last updated. Audit trail for data lineage and change tracking.',
    `lease_ownership_indicator` STRING COMMENT 'Indicates whether the room space is owned by the organization, leased from a third party, shared with another entity, or contracted. Impacts financial reporting and cost allocation.. Valid values are `owned|leased|shared|contracted`',
    `license_number` STRING COMMENT 'State or regulatory license number for the room, if applicable (e.g., for surgical suites, radiology rooms). Required for compliance and accreditation tracking.',
    `medical_air_outlet_count` STRING COMMENT 'Number of medical air outlets for compressed air delivery. Used for respiratory therapy and surgical equipment.',
    `monthly_space_cost` DECIMAL(18,2) COMMENT 'Allocated monthly cost for the room space, including lease payments, depreciation, utilities, and maintenance. Used for cost center chargebacks and financial analysis.',
    `negative_pressure_flag` BOOLEAN COMMENT 'Indicates whether the room has negative pressure ventilation to prevent airborne pathogen spread. Required for airborne isolation (e.g., tuberculosis, COVID-19).',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance activity for the room or its equipment. Supports biomedical engineering and facilities management workflows.',
    `nitrous_oxide_outlet_count` STRING COMMENT 'Number of nitrous oxide gas outlets. Typically present in operating rooms and dental procedure rooms for anesthesia delivery.',
    `nurse_call_system_flag` BOOLEAN COMMENT 'Indicates whether the room is equipped with a nurse call system for patient-to-staff communication. Standard for patient rooms and required for CMS compliance.',
    `occupancy_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of time the room is occupied over a reporting period. Key performance indicator for space utilization and capacity management.',
    `or_airflow_class` STRING COMMENT 'ISO cleanroom classification for operating room air quality and particulate control. Defines laminar airflow requirements for surgical sterility. Applicable only to OR rooms.. Valid values are `iso_5|iso_6|iso_7|iso_8|standard`',
    `oxygen_outlet_count` STRING COMMENT 'Number of medical gas outlets for oxygen delivery. Essential for patient care capacity planning and emergency preparedness.',
    `room_class` STRING COMMENT 'Classification of the room based on occupancy and privacy level. Impacts billing, patient preference, and infection control protocols.. Valid values are `private|semi_private|ward|suite|isolation|observation`',
    `room_name` STRING COMMENT 'Human-readable name or description of the room, often used for scheduling and communication (e.g., Cardiac Cath Lab 1, Pediatric Exam Room B).',
    `room_number` STRING COMMENT 'The official room number or identifier used for wayfinding, signage, and operational reference. May include alphanumeric codes (e.g., 3A-201, OR-5, ICU-12).',
    `room_status` STRING COMMENT 'Current operational status of the room. Drives bed management, ADT workflows, and scheduling availability.. Valid values are `available|occupied|cleaning|out_of_service|maintenance|reserved`',
    `room_type` STRING COMMENT 'Classification of the room based on its primary clinical or operational function. Determines equipment requirements, staffing, and scheduling rules. [ENUM-REF-CANDIDATE: patient|operating_room|procedure_room|exam_room|consultation_room|support_room|isolation_room|negative_pressure_room — 8 candidates stripped; promote to reference product]',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the room measured in square feet. Used for space utilization analysis, cost allocation, and compliance with facility design standards.',
    `telemetry_capable_flag` BOOLEAN COMMENT 'Indicates whether the room is equipped with telemetry monitoring infrastructure for continuous cardiac and vital sign monitoring.',
    `vacuum_outlet_count` STRING COMMENT 'Number of medical vacuum outlets for suctioning. Required for surgical, procedural, and critical care rooms.',
    `ventilator_outlet_count` STRING COMMENT 'Number of electrical outlets dedicated to ventilator equipment. Critical for ICU and critical care room planning and patient placement.',
    CONSTRAINT pk_room PRIMARY KEY(`room_id`)
) COMMENT 'Individual room within a unit, including patient rooms, procedure rooms, operating rooms (OR suites with laminar airflow class, imaging integration, boom configuration), exam rooms, consultation rooms, and support rooms. Tracks room number, room name, room type (patient, OR, procedure, exam, consultation, support, isolation, negative pressure), room class (private, semi-private, ward), square footage, isolation capability, negative pressure flag, telemetry capability, ventilator outlet count, medical gas outlets (O2, vacuum, air, N2O), hand hygiene station count, OR-specific features (airflow class, HVAC air exchange rate per ASHRAE 170, equipment inventory), current room status (available, occupied, cleaning, out-of-service), last deep-clean date, and assigned department. Also captures space allocation and occupancy assignments linking rooms to departments, cost centers, and service lines with effective dating, allocated square footage, occupancy percentage, lease/ownership indicator, and monthly space cost. Supports ADT workflows, perioperative scheduling, bed management, space utilization analysis, infection prevention (isolation room tracking), and cost center chargebacks.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`bed` (
    `bed_id` BIGINT COMMENT 'Unique identifier for the individual patient bed. Primary key for the bed entity.',
    `building_id` BIGINT COMMENT 'FK to facility.building',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where this bed is located.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient currently assigned to this bed. Null when bed status is available, dirty, blocked, or out_of_service. Links to Master Patient Index (MPI) for ADT event tracking.',
    `room_id` BIGINT COMMENT 'Reference to the specific room or unit where this bed is physically located.',
    `unit_id` BIGINT COMMENT 'FK to facility.unit',
    `visit_id` BIGINT COMMENT 'Reference to the current inpatient visit or encounter associated with the bed assignment. Null when bed is unoccupied. Used for linking bed utilization to clinical and billing events.',
    `age_restriction` STRING COMMENT 'Age-based restriction for patient assignment to this bed, driven by clinical care model and equipment. Values: adult (18+ years), pediatric (0-17 years), neonatal (newborn to 28 days), any (no restriction).. Valid values are `adult|pediatric|neonatal|any`',
    `asset_tag` STRING COMMENT 'Physical asset tag or serial number affixed to the bed frame for equipment tracking, preventive maintenance scheduling, and biomedical engineering inventory management.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the current patient was assigned to this bed. Used for calculating patient length of stay in specific bed/unit and bed utilization analytics.',
    `bed_category` STRING COMMENT 'Clinical service line or specialty category of the bed. Used for capacity planning by service line, regulatory reporting, and patient placement algorithms. Values: medical, surgical, pediatric, maternity, psychiatric, rehabilitation.. Valid values are `medical|surgical|pediatric|maternity|psychiatric|rehabilitation`',
    `bed_status` STRING COMMENT 'Current operational status of the bed. Core field for real-time bed management and ADT (Admit, Discharge, Transfer) operations. Values: available (ready for patient assignment), occupied (patient currently assigned), dirty (patient discharged, awaiting environmental services cleaning), blocked (administratively held), out_of_service (maintenance or repair required), housekeeping (cleaning in progress).. Valid values are `available|occupied|dirty|blocked|out_of_service|housekeeping`',
    `bed_type` STRING COMMENT 'Classification of the bed based on clinical care level and purpose. Determines staffing ratios, reimbursement categories, and capacity reporting. Values: acute (general medical-surgical), icu (intensive care unit), observation (short-stay monitoring), ed (emergency department), or_table (operating room table), procedure (procedure room bed), bariatric (high weight capacity), low_bed (fall prevention), bassinet (neonatal/pediatric). [ENUM-REF-CANDIDATE: acute|icu|observation|ed|or_table|procedure|bariatric|low_bed|bassinet — 9 candidates stripped; promote to reference product]',
    `blocked_reason` STRING COMMENT 'Free-text explanation for why the bed is administratively blocked from patient assignment (e.g., construction, equipment failure, infection control hold, staffing shortage). Populated only when bed_status is blocked.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this bed record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `discharge_ready_timestamp` TIMESTAMP COMMENT 'Date and time when the clinical team marked the patient as medically ready for discharge. Used to calculate discharge delays, bed turnover bottlenecks, and length of stay (LOS) optimization metrics.',
    `effective_end_date` DATE COMMENT 'Date when the bed was permanently removed from service or decommissioned. Null for active beds. Used for historical capacity reporting and facility planning analysis.',
    `effective_start_date` DATE COMMENT 'Date when the bed was first placed into service or added to the facility inventory. Used for bed lifecycle tracking and historical capacity analysis.',
    `expected_available_timestamp` TIMESTAMP COMMENT 'Estimated date and time when a currently unavailable bed (dirty, blocked, out_of_service, housekeeping) is expected to become available for patient assignment. Used for bed demand forecasting and patient placement planning.',
    `floor_number` STRING COMMENT 'Physical floor or level within the facility where the bed is located (e.g., 1, 2, 3, B1 for basement, G for ground). Used for wayfinding, emergency response, and facility planning.',
    `gender_restriction` STRING COMMENT 'Gender restriction for patient assignment to this bed, typically driven by shared room configurations or unit policies. Values: male (male patients only), female (female patients only), any (no restriction).. Valid values are `male|female|any`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the bed record is currently active in the system. Inactive beds are permanently removed from inventory (e.g., facility closure, unit reconfiguration). Used for historical reporting and capacity trend analysis.',
    `is_air_fluidized` BOOLEAN COMMENT 'Indicates whether the bed is an air-fluidized therapy bed used for severe pressure ulcer treatment and prevention. Specialized equipment requiring clinical justification and authorization.',
    `is_bariatric_capable` BOOLEAN COMMENT 'Indicates whether the bed is equipped to safely accommodate bariatric patients (typically weight capacity 350+ lbs). Impacts patient placement decisions and equipment requirements.',
    `is_isolation_capable` BOOLEAN COMMENT 'Indicates whether the bed is in a room suitable for isolation precautions (contact, droplet, or airborne). Supports infection control protocols and patient placement decisions.',
    `is_licensed` BOOLEAN COMMENT 'Indicates whether the bed is included in the facilitys licensed bed count as approved by state health department. Impacts regulatory reporting, reimbursement, and capacity planning.',
    `is_low_bed` BOOLEAN COMMENT 'Indicates whether the bed is a low-height bed designed for fall prevention, typically used for high-risk patients (elderly, confused, post-operative). Supports patient safety protocols.',
    `is_negative_pressure_room` BOOLEAN COMMENT 'Indicates whether the bed is located in a negative pressure isolation room designed for airborne infection control (e.g., tuberculosis, COVID-19, measles). Critical for infection prevention and control.',
    `is_private_room` BOOLEAN COMMENT 'Indicates whether the bed is in a private (single-occupancy) room. Impacts patient satisfaction, infection control, and room charge billing.',
    `is_staffed` BOOLEAN COMMENT 'Indicates whether the bed is currently staffed and operationally available for patient assignment. A bed may be licensed but not staffed due to nursing shortages or seasonal demand fluctuations.',
    `is_telemetry_capable` BOOLEAN COMMENT 'Indicates whether the bed location is equipped with continuous cardiac telemetry monitoring capability. Determines appropriate placement for patients requiring cardiac monitoring.',
    `label` STRING COMMENT 'Human-readable identifier for the bed, typically including unit, room, and bed position (e.g., 4-West-201-A, ICU-12-B, ED-Bay-3). Used for operational communication and bed board displays.',
    `last_cleaned_timestamp` TIMESTAMP COMMENT 'Date and time when environmental services completed cleaning and disinfection of the bed and room. Critical for infection control, bed turnover tracking, and housekeeping performance metrics.',
    `last_maintenance_date` DATE COMMENT 'Date when the bed last received preventive maintenance inspection by biomedical engineering or facilities management. Used for compliance with equipment maintenance schedules and patient safety protocols.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this bed record was most recently modified. Audit field for change tracking and data quality monitoring.',
    `next_maintenance_due_date` DATE COMMENT 'Date when the bed is next scheduled for preventive maintenance inspection. Used for proactive maintenance planning and regulatory compliance tracking.',
    `out_of_service_reason` STRING COMMENT 'Free-text explanation for why the bed is out of service (e.g., biomedical equipment repair, structural maintenance, permanent closure). Populated only when bed_status is out_of_service.',
    `position` STRING COMMENT 'Position identifier within a multi-bed room (e.g., A, B, C, 1, 2, Window, Door). Used for precise bed identification and patient placement communication.',
    `status_timestamp` TIMESTAMP COMMENT 'Date and time when the bed last changed status. Critical for calculating discharge-to-clean cycle time, bed turnover metrics, and hospital command center operations.',
    `weight_capacity_lbs` DECIMAL(18,2) COMMENT 'Maximum safe patient weight capacity of the bed in pounds. Used for patient placement decisions and equipment safety compliance. Standard beds typically 350-500 lbs, bariatric beds 500-1000+ lbs.',
    CONSTRAINT pk_bed PRIMARY KEY(`bed_id`)
) COMMENT 'Individual patient bed within a room. Captures bed label (e.g., 4-West-201-A), bed type (acute, ICU, observation, ED, OR table, procedure, bariatric, low-bed, bassinet/crib), bed status (available, occupied, dirty, blocked, out-of-service, housekeeping-in-progress), bed feature flags (bariatric-capable, low-bed, air-fluidized, telemetry-capable, negative-pressure-room, isolation), last status change timestamp, current patient assignment reference, and discharge-ready timestamp. Core entity for real-time bed management, ADT operations, capacity planning, and discharge-to-clean cycle time tracking. Supports bed board dashboards, hospital command center operations, and CMS bed count reporting.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`bed_status_event` (
    `bed_status_event_id` BIGINT COMMENT 'Unique identifier for each bed status change event. Primary key for the bed status event transactional record.',
    `adt_event_id` BIGINT COMMENT 'Foreign key linking to encounter.adt_event. Business justification: Bed management workflows require linking bed status changes to the specific ADT event that triggered them (admit, transfer, discharge). Bed board systems and EVS dispatch use this to correlate bed sta',
    `bed_id` BIGINT COMMENT 'Reference to the specific bed that experienced the status change. Links to the bed master resource.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the bed is located. Supports multi-site integrated delivery network tracking.',
    `maintenance_order_id` BIGINT COMMENT 'Reference to the biomedical engineering or facilities maintenance work order if the bed requires repair or preventive maintenance.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient associated with this bed status event (e.g., patient being admitted or discharged). Null for non-patient-related events like maintenance.',
    `unit_id` BIGINT COMMENT 'Reference to the nursing unit or department where the bed resides (e.g., ICU, ED, Medical-Surgical).',
    `room_id` BIGINT COMMENT 'Reference to the specific room containing the bed. Supports room-level capacity and configuration tracking.',
    `visit_id` BIGINT COMMENT 'Reference to the specific patient encounter or visit associated with this bed event. Links to ADT (Admit-Discharge-Transfer) workflow.',
    `actual_availability_timestamp` TIMESTAMP COMMENT 'Actual date and time when the bed became available after cleaning or maintenance. Enables cycle time variance analysis.',
    `acuity_level` STRING COMMENT 'Clinical acuity level associated with the bed at the time of the event. Aligns bed capacity with patient care intensity requirements.. Valid values are `critical|acute|intermediate|observation|general`',
    `adt_event_type` STRING COMMENT 'Type of ADT event that triggered this bed status change. Aligns with HL7 ADT message types for interoperability.. Valid values are `admit|discharge|transfer|cancel|update`',
    `bed_assignment_method` STRING COMMENT 'Method used to assign or change the bed status (manual by staff, automated by system algorithm, or hybrid). Supports workflow optimization analysis.. Valid values are `manual|automated|hybrid`',
    `blocked_reason_category` STRING COMMENT 'High-level category for why a bed is blocked or unavailable. Supports root cause analysis of capacity constraints.. Valid values are `construction|equipment_failure|staffing_shortage|infection_control|administrative|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bed status event record was first created in the system. Supports audit trail and data lineage tracking.',
    `duration_minutes` STRING COMMENT 'Duration in minutes that the bed remained in the prior status before this event. Calculated field for cycle time analysis.',
    `event_sequence_number` STRING COMMENT 'Sequential number indicating the order of status changes for this bed. Supports chronological event reconstruction and audit trails.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the bed status change occurred. Critical for discharge-to-clean cycle time analysis and real-time bed board operations.',
    `expected_availability_timestamp` TIMESTAMP COMMENT 'Projected date and time when the bed will become available for the next patient. Used for bed turnover forecasting and transfer planning.',
    `initiating_user_role` STRING COMMENT 'Role or job function of the user who initiated the status change (e.g., Registered Nurse, Environmental Services Technician, Bed Coordinator).',
    `is_elective_flag` BOOLEAN COMMENT 'Indicates whether this bed status change is related to a scheduled or elective admission (e.g., planned surgery).',
    `is_emergency_flag` BOOLEAN COMMENT 'Indicates whether this bed status change is related to an emergency department admission or urgent care scenario.',
    `isolation_type` STRING COMMENT 'Type of infection control isolation precaution applied to the bed (e.g., contact, droplet, airborne, protective). Critical for infection prevention and bed assignment logic.. Valid values are `contact|droplet|airborne|protective|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bed status event record was last updated. Enables change tracking and data quality monitoring.',
    `new_status_code` STRING COMMENT 'The bed status after this event. Core field for real-time bed availability tracking and capacity management. [ENUM-REF-CANDIDATE: occupied|available|cleaning|maintenance|blocked|reserved|isolation — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments entered by staff regarding this bed status change. Provides qualitative context for operational review.',
    `prior_status_code` STRING COMMENT 'The bed status immediately before this event. Enables state transition analysis and workflow tracking. [ENUM-REF-CANDIDATE: occupied|available|cleaning|maintenance|blocked|reserved|isolation — 7 candidates stripped; promote to reference product]',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether this bed status change is high-priority (e.g., emergency department hold, urgent transfer). Supports command center escalation workflows.',
    `reason_code` STRING COMMENT 'Standardized code indicating why the bed status changed (e.g., patient discharge, cleaning request, maintenance hold, isolation precaution, blocked for construction, reserved for transfer). [ENUM-REF-CANDIDATE: patient_discharge|patient_admission|cleaning_request|maintenance_hold|isolation_precaution|construction_block|transfer_reserved|emergency_hold — 8 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text explanation providing additional context for the status change. Supplements the standardized reason code.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system that generated this bed status event (e.g., Epic ADT, Cerner Millennium, bed management system).',
    `source_system_event_code` STRING COMMENT 'Unique identifier from the source system for this event. Enables traceability and reconciliation with operational systems.',
    CONSTRAINT pk_bed_status_event PRIMARY KEY(`bed_status_event_id`)
) COMMENT 'Transactional record of every bed status change event, capturing the bed reference, prior status, new status, reason code (patient discharge, cleaning request, maintenance hold, isolation precaution, blocked for construction, reserved for transfer), timestamp, initiating user, and associated housekeeping or maintenance work order reference. Enables real-time bed board operations, discharge-to-clean cycle time analysis, average length of stay (ALOS) tracking, and throughput optimization. Supports ADT event-driven workflows and hospital command center dashboards.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`or_suite` (
    `or_suite_id` BIGINT COMMENT 'Unique identifier for the operating room suite. Primary key for the OR suite master data.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: OR suites are physical spaces within buildings. Adding building_id enables facility management operations (building maintenance schedules, HVAC systems, emergency power), space planning, and building-',
    `care_site_id` BIGINT COMMENT 'Reference to the parent healthcare facility or hospital campus where this OR suite is located. Links to the facility master for multi-site integrated delivery networks.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: OR suites are governed by specific accreditation/compliance programs (AAAHC, TJC surgical standards, CMS ASC CoP). Surgical compliance officers track which program governs each OR suite for accreditat',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: An OR suite is a specialized configuration of a physical room. Linking or_suite to its corresponding room record in the room master enables cross-referencing OR suite operational data (laminar airflow',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: OR suites are designated for specific surgical specialties (cardiac OR, orthopedic OR, neurosurgery OR). Linking or_suite to specialty supports surgical block scheduling, OR utilization reporting by s',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: OR suites are clinical units within the facility hierarchy. Adding unit_id enables proper organizational hierarchy (care_site → building → unit → OR suite) and supports unit-level operational reportin',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the OR suite or parent surgical services program by The Joint Commission (TJC), AAAHC, or other accrediting body. Accreditation is required for many payer contracts and demonstrates compliance with quality and safety standards.. Valid values are `accredited|provisional|not_accredited|pending_survey`',
    `anesthesia_machine_model` STRING COMMENT 'Manufacturer and model of the anesthesia delivery system installed in the OR. Critical for anesthesia provider training, maintenance scheduling, and gas scavenging system compatibility.',
    `boom_configuration` STRING COMMENT 'Type and configuration of ceiling-mounted or wall-mounted booms for surgical lights, anesthesia equipment, monitors, and power/data connections. Dual booms provide greater flexibility for complex procedures. Configuration impacts room layout and equipment access.. Valid values are `none|single_ceiling_boom|dual_ceiling_boom|articulating_arm|wall_mounted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this OR suite record was first created in the system. Used for audit trail and data lineage tracking.',
    `emergency_power_backup_flag` BOOLEAN COMMENT 'Indicates whether the OR is connected to the emergency power system (generator or UPS) to maintain critical functions during power outages. Required for life safety and continuation of surgical procedures.',
    `emergency_use_flag` BOOLEAN COMMENT 'Indicates whether this OR is designated for emergency and trauma cases. Emergency ORs are held open or have priority access rules in surgical scheduling systems to ensure rapid availability for urgent cases.',
    `equipment_inventory_list` STRING COMMENT 'Comma-separated or structured list of major fixed and mobile equipment assigned to this OR suite (e.g., surgical table model, anesthesia machine, electrosurgical unit, video tower, microscope). Used for preventive maintenance scheduling and equipment tracking.',
    `fire_suppression_system_type` STRING COMMENT 'Type of fire suppression system installed in the OR suite. Clean agent systems (e.g., FM-200, Novec 1230) are preferred for ORs to avoid water damage to sensitive equipment. Sprinkler systems are common but may require equipment protection. Critical for life safety and regulatory compliance.. Valid values are `sprinkler|clean_agent|water_mist|none`',
    `hvac_air_exchange_rate_per_hour` STRING COMMENT 'Number of complete air changes per hour in the operating room. Minimum 15 air changes per hour is required for ORs per FGI guidelines; higher rates (20-25) are used in ultra-clean environments. Critical for infection control and regulatory compliance.',
    `imaging_integration_type` STRING COMMENT 'Type of intraoperative imaging equipment integrated into the OR suite. Hybrid ORs combine surgical and interventional radiology capabilities. C-arm fluoroscopy is common in orthopedic and spine procedures. Intraoperative MRI/CT enable real-time image-guided neurosurgery.. Valid values are `none|c_arm|intraoperative_mri|intraoperative_ct|fluoroscopy|hybrid_angio`',
    `isolation_capable_flag` BOOLEAN COMMENT 'Indicates whether the OR can be configured for airborne or contact isolation procedures (e.g., negative pressure for tuberculosis cases, enhanced PPE protocols for infectious diseases). Critical for infection control and pandemic preparedness.',
    `laminar_airflow_class` STRING COMMENT 'ISO 14644-1 cleanroom classification for the operating room air quality. ISO Class 5 (Class 100) is the highest standard for ultra-clean orthopedic and implant surgeries. ISO Class 7 (Class 10,000) is typical for general surgery. Laminar airflow reduces surgical site infection (SSI) risk.. Valid values are `iso_5|iso_6|iso_7|iso_8|standard`',
    `last_accreditation_survey_date` DATE COMMENT 'Date of the most recent accreditation survey or inspection for the surgical services program. Used to track compliance cycles and prepare for upcoming surveys.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent completed preventive maintenance or deep cleaning cycle for the OR suite. Used to track compliance with maintenance schedules and regulatory requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this OR suite record was most recently modified. Used for audit trail, change tracking, and data quality monitoring.',
    `license_expiration_date` DATE COMMENT 'Expiration date of the facility license for this OR suite. Alerts compliance teams to renew licenses before expiration to avoid regulatory penalties or loss of reimbursement eligibility.',
    `license_number` STRING COMMENT 'State or local regulatory license number for the operating room suite. Required for Medicare/Medicaid reimbursement and state health department inspections. Tracked per OR or per facility depending on jurisdiction.',
    `medical_gas_outlets_count` STRING COMMENT 'Total number of medical gas outlets (oxygen, nitrous oxide, medical air, vacuum, WAGD) installed in the OR suite. Minimum outlet counts are specified by FGI guidelines based on OR type and size.',
    `next_accreditation_survey_due_date` DATE COMMENT 'Scheduled or estimated date for the next accreditation survey. Alerts quality and compliance teams to prepare documentation and conduct internal readiness assessments.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance cycle. Alerts facility management and surgical scheduling teams to plan around maintenance downtime.',
    `operational_status` STRING COMMENT 'Current operational state of the OR suite. Active ORs are available for surgical scheduling. Inactive ORs are temporarily unavailable (e.g., equipment failure, staffing shortage). Maintenance and renovation statuses block scheduling for planned downtime. Decommissioned ORs are permanently closed.. Valid values are `active|inactive|maintenance|renovation|decommissioned`',
    `or_name` STRING COMMENT 'Descriptive name for the operating room suite, may include location or specialty designation (e.g., Main OR 5, Cardiac Surgery Suite A, Hybrid OR West Wing).',
    `or_number` STRING COMMENT 'Business identifier for the operating room suite, typically displayed as OR1, OR2, OR10, etc. Used in surgical scheduling systems like Epic OpTime and Cerner SurgiNet.. Valid values are `^OR[0-9]{1,4}$`',
    `or_type` STRING COMMENT 'Classification of the operating room by surgical specialty or capability. Determines equipment requirements, staffing models, and scheduling rules. General ORs support multiple specialties; specialized ORs are configured for specific procedures.. Valid values are `general|cardiac|orthopedic|neurosurgery|hybrid|endoscopy`',
    `pediatric_capable_flag` BOOLEAN COMMENT 'Indicates whether the OR is equipped and staffed to support pediatric surgical cases. Requires specialized equipment (pediatric anesthesia circuits, warming devices, smaller instruments) and trained perioperative staff.',
    `positive_pressure_maintained_flag` BOOLEAN COMMENT 'Indicates whether the OR maintains positive air pressure relative to adjacent corridors and support spaces. Positive pressure prevents contaminated air from entering the sterile field. Required for most ORs; negative pressure is used only for airborne isolation procedures.',
    `robotic_surgery_compatible_flag` BOOLEAN COMMENT 'Indicates whether the OR suite is configured and equipped to support robotic-assisted surgical systems (e.g., da Vinci Surgical System). Requires additional space, power, and structural support.',
    `room_height_feet` DECIMAL(18,2) COMMENT 'Ceiling height of the operating room in feet. Critical for surgical light placement, boom configuration, and laminar airflow system design.',
    `room_length_feet` DECIMAL(18,2) COMMENT 'Physical length dimension of the operating room in feet. Used for space planning, equipment placement, and compliance with facility design standards.',
    `room_width_feet` DECIMAL(18,2) COMMENT 'Physical width dimension of the operating room in feet. Minimum dimensions are regulated for different OR types to ensure safe equipment access and staff movement.',
    `scheduled_maintenance_window` STRING COMMENT 'Recurring time block reserved for preventive maintenance, deep cleaning, and equipment calibration (e.g., Every Sunday 6:00 AM - 12:00 PM, First Monday of month). OR is unavailable for surgical scheduling during this window.',
    `status_effective_timestamp` TIMESTAMP COMMENT 'Date and time when the current operational status became effective. Used to track OR availability history and calculate downtime metrics for capacity management.',
    `status_reason_code` STRING COMMENT 'Coded reason for the current operational status (e.g., EQUIP_FAIL for equipment failure, STAFF_SHORT for staffing shortage, SCHED_MAINT for scheduled maintenance, RENO for renovation). Supports root cause analysis of OR unavailability.',
    `surgical_table_type` STRING COMMENT 'Model or type of the primary surgical table installed in the OR (e.g., general surgery table, orthopedic fracture table, neurosurgery head frame table, robotic surgery table). Table type determines compatible procedures and patient positioning capabilities.',
    `video_integration_capability_flag` BOOLEAN COMMENT 'Indicates whether the OR has integrated video capture, recording, and display systems for endoscopic, laparoscopic, or robotic surgery. Supports surgical education, quality review, and telemedicine consultation.',
    CONSTRAINT pk_or_suite PRIMARY KEY(`or_suite_id`)
) COMMENT 'Operating room suite configuration master, capturing OR number, OR name, OR type (general, cardiac, orthopedic, neurosurgery, hybrid, endoscopy, cath lab), room dimensions, imaging integration (C-arm, intraoperative MRI), laminar airflow class, HVAC air exchange rate, boom configuration, equipment inventory list, scheduled maintenance window, and current operational status. Supports OpTime surgical scheduling and perioperative capacity management.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`equipment_asset` (
    `equipment_asset_id` BIGINT COMMENT 'Unique identifier for the equipment asset record. Primary key.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Normalization: equipment_asset currently has current_location_building as STRING. Replacing with building_id FK enables referential integrity, supports equipment location tracking, facilitates buildin',
    `care_site_id` BIGINT COMMENT 'Identifier of the care site (hospital, clinic, facility) where the equipment is currently located.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Durable medical equipment (DME) assets require HCPCS Level II codes for Medicare/Medicaid billing and charge capture. Revenue cycle and compliance teams link each billable equipment asset to its HCPCS',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Medical equipment assets correspond to material master records for serialized/UDI-tracked devices. Linking enables capital asset tracking against supply catalog, UDI compliance for FDA-regulated devic',
    `or_suite_id` BIGINT COMMENT 'Foreign key linking to facility.or_suite. Business justification: Biomedical and facility equipment assets (anesthesia machines, surgical robots, imaging systems) are often permanently assigned to specific OR suites. While equipment_asset already has room_id, an OR ',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Normalization: equipment_asset currently has current_location_room as STRING. Replacing with room_id FK enables referential integrity, supports room-level equipment tracking (critical for OR suites, I',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Normalization: equipment_asset currently has current_location_unit as STRING. Replacing with unit_id FK enables referential integrity, supports unit-level equipment allocation tracking, facilitates un',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: Equipment assets have service contracts tracked via service_contract_number and service_contract_vendor (plain text). Normalizing to vendor_contract_id supports contract compliance, renewal alerts, an',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or capitalized cost of the equipment in USD. Basis for depreciation and capital planning.',
    `acquisition_date` DATE COMMENT 'Date the equipment was acquired or placed into service. Used for depreciation calculations and lifecycle planning.',
    `asset_tag` STRING COMMENT 'Externally visible unique asset tag identifier affixed to the physical equipment. Used for tracking and inventory management.. Valid values are `^[A-Z0-9]{6,20}$`',
    `calibration_required_flag` BOOLEAN COMMENT 'Indicates whether the equipment requires periodic calibration to maintain measurement accuracy and regulatory compliance.',
    `current_location_floor` STRING COMMENT 'Floor level within the building where the equipment is located.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the equipment asset over its useful life.. Valid values are `straight_line|declining_balance|units_of_production|not_applicable`',
    `disposal_method` STRING COMMENT 'Method used to dispose of retired equipment. Required for environmental compliance and asset accounting.. Valid values are `sold|donated|recycled|destroyed|returned_to_vendor|not_applicable`',
    `environmental_requirements` STRING COMMENT 'Special environmental conditions required for equipment operation (temperature range, humidity, ventilation). Important for facility infrastructure planning.',
    `equipment_category` STRING COMMENT 'High-level classification of equipment type for portfolio management and reporting. [ENUM-REF-CANDIDATE: biomedical|imaging|surgical|patient_monitoring|life_support|laboratory|facility_infrastructure|sterilization|therapeutic — 9 candidates stripped; promote to reference product]',
    `equipment_name` STRING COMMENT 'Common business name or description of the equipment asset (e.g., Ventilator, MRI Scanner, Infusion Pump).',
    `equipment_type` STRING COMMENT 'Detailed equipment type or subclass within the category (e.g., CT Scanner, Infusion Pump, Defibrillator).',
    `fda_device_class` STRING COMMENT 'FDA regulatory classification indicating the level of control necessary to assure safety and effectiveness. Class I (low risk), Class II (moderate risk), Class III (high risk).. Valid values are `class_i|class_ii|class_iii|not_applicable`',
    `infection_control_category` STRING COMMENT 'Spaulding classification for infection control and sterilization requirements. Critical items enter sterile tissue, semi-critical contact mucous membranes, non-critical contact intact skin.. Valid values are `critical|semi_critical|non_critical|not_applicable`',
    `installation_date` DATE COMMENT 'Date when the equipment was physically installed and commissioned at the current or original location.',
    `last_calibration_date` DATE COMMENT 'Date when the most recent calibration was performed on this equipment.',
    `last_pm_date` DATE COMMENT 'Date when the most recent preventive maintenance was completed on this equipment.',
    `manufacturer` STRING COMMENT 'Name of the equipment manufacturer or original equipment manufacturer (OEM).',
    `mobility_indicator` STRING COMMENT 'Indicates whether the equipment is permanently installed (fixed), can be moved by staff (portable), or is mounted on wheels/cart (mobile). Impacts tracking and location management requirements.. Valid values are `fixed|portable|mobile`',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for this equipment type.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration activity. Overdue calibration may result in equipment being taken out of service.',
    `next_pm_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity. Critical for compliance with TJC equipment management standards.',
    `notes` STRING COMMENT 'Free-text field for additional information, special handling instructions, or historical context about the equipment asset.',
    `operational_status` STRING COMMENT 'Current operational state of the equipment asset. Determines availability for clinical use and maintenance scheduling.. Valid values are `in_service|out_of_service|under_repair|retired|condemned|quarantined`',
    `pm_compliance_status` STRING COMMENT 'Current compliance status of preventive maintenance schedule. Overdue status triggers escalation and may impact accreditation.. Valid values are `compliant|overdue|upcoming|not_applicable`',
    `pm_frequency_days` STRING COMMENT 'Number of days between scheduled preventive maintenance activities. Determined by manufacturer recommendations and risk category.',
    `power_requirements` STRING COMMENT 'Electrical power specifications for the equipment (voltage, amperage, phase). Critical for facility planning and electrical safety.',
    `recall_date` DATE COMMENT 'Date when the FDA recall was issued for this equipment model.',
    `recall_number` STRING COMMENT 'FDA-assigned recall identification number if the equipment is subject to an active recall.',
    `recall_remediation_date` DATE COMMENT 'Date when recall remediation actions (repair, replacement, software update) were completed for this equipment unit.',
    `recall_status` STRING COMMENT 'Current FDA recall or safety alert status for this equipment. Active recalls require immediate action and reporting.. Valid values are `no_recall|active_recall|recall_remediated|under_investigation`',
    `retirement_date` DATE COMMENT 'Date when the equipment was retired from active service. Used for asset disposal tracking and capital planning.',
    `risk_category` STRING COMMENT 'Clinical and operational risk classification based on potential impact to patient safety and care delivery if equipment fails. Aligns with ECRI and AAMI risk stratification frameworks.. Valid values are `critical|high|medium|low`',
    `sap_equipment_number` STRING COMMENT 'Equipment master record number in SAP PM (Plant Maintenance) module. Primary integration key for work orders, maintenance plans, and cost tracking.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for the equipment unit. Critical for warranty claims, recalls, and service history tracking.',
    `service_contract_expiration_date` DATE COMMENT 'Date when the current service contract expires. Used for contract renewal planning.',
    `udi` STRING COMMENT 'FDA-mandated Unique Device Identifier for medical devices. Enables traceability throughout the device lifecycle and supports recall management.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the equipment in years for depreciation and replacement planning purposes.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty coverage expires. Critical for service contract planning and repair cost management.',
    CONSTRAINT pk_equipment_asset PRIMARY KEY(`equipment_asset_id`)
) COMMENT 'Biomedical and facility equipment asset master, representing every capital and tracked equipment item including ventilators, infusion pumps, imaging systems (CT, MRI, X-ray, ultrasound), surgical robots, patient monitors, defibrillators, sterilizers, HVAC units, generators, elevators, and fire suppression systems. Captures asset tag, serial number, manufacturer, model, FDA device class, UDI (Unique Device Identifier), acquisition date, acquisition cost, useful life, depreciation method, current location (care site, building, unit, room), assigned department, warranty expiration, service contract reference, last PM date, next PM due date, PM compliance status, risk category (critical, high, medium, low per ECRI/AAMI), recall status, and operational status (in service, out of service, retired, condemned). Integrates with SAP PM equipment master. Supports biomedical engineering asset management, capital equipment planning, FDA recall tracking, and TJC EC.02.04.01 compliance.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`maintenance_order` (
    `maintenance_order_id` BIGINT COMMENT 'Unique identifier for the maintenance work order. Primary key for the maintenance order entity.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Building-level maintenance work orders (roof repairs, elevator servicing, HVAC plant maintenance, fire suppression system testing) are a core function of healthcare facility management. The maintenanc',
    `care_site_id` BIGINT COMMENT 'Reference to the facility location (room, unit, building) where the maintenance work is to be performed. Used when work order applies to infrastructure rather than a specific asset.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Corrective action plans from compliance findings (life safety, equipment deficiencies) generate maintenance work orders to remediate findings. Linking maintenance_order to corrective_action_plan enabl',
    `equipment_asset_id` BIGINT COMMENT 'Reference to the specific facility asset or biomedical equipment that is the subject of this maintenance work order. Links to the asset master data for equipment specifications and history.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Maintenance orders consume parts and materials tracked in the supply material master. Linking to material_master enables inventory deduction for maintenance parts, cost tracking, and parts availabilit',
    `pm_schedule_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule definition that generated this work order. Null for corrective, emergency, or ad-hoc work orders. Links to the PM schedule template for compliance tracking.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Maintenance work orders are driven by specific compliance policies (NFPA 99, TJC EC standards, CMS life safety). Linking maintenance_order to compliance_policy enables direct traceability from work ex',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Maintenance orders generate purchase orders for parts and vendor services. Normalizing purchase_order_number (plain text) to a proper FK enables three-way match, invoice reconciliation, and maintenanc',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Maintenance work orders in healthcare facilities are issued not only for equipment assets but also for physical rooms (HVAC servicing, deep cleaning, plumbing repairs, electrical work). The maintenanc',
    `vendor_id` BIGINT COMMENT 'Reference to the external vendor or contractor who performed the maintenance work. Null for work performed by internal staff. Links to vendor master data.',
    `actual_completion_datetime` TIMESTAMP COMMENT 'Actual date and time when the maintenance work was completed and the asset or location was returned to service. Used for calculating actual labor duration and PM compliance rates.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the technician began work on the maintenance order. Captured by technician check-in or mobile work order system.',
    `approval_datetime` TIMESTAMP COMMENT 'Date and time when the maintenance work order was approved. Used for tracking approval cycle time and work order lifecycle metrics.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this maintenance work order requires management or budget approval before work can commence. Typically true for high-cost repairs or capital improvements.',
    `completion_notes` STRING COMMENT 'Detailed narrative notes entered by the technician upon work order completion, documenting work performed, parts replaced, findings, and any follow-up recommendations.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this maintenance order record was first created in the data platform. Used for data lineage and audit trail purposes.',
    `downtime_minutes` STRING COMMENT 'Total duration in minutes that the asset or location was out of service due to this maintenance activity. Used for calculating equipment availability and operational impact metrics.',
    `failure_code` STRING COMMENT 'Standardized code classifying the type of equipment failure or maintenance issue. Used for failure mode analysis, trend reporting, and root cause analysis. Follows facility-specific or manufacturer failure taxonomy.. Valid values are `^[A-Z0-9]{2,10}$`',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost for the maintenance work order, calculated from labor hours and technician hourly rates. Used for total cost of ownership analysis and budget tracking.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended by technicians to complete the maintenance work order. Used for cost calculation, productivity analysis, and PM schedule estimation.',
    `order_status` STRING COMMENT 'Current lifecycle status of the maintenance work order. Tracks progression from creation through assignment, execution, completion, and closure. On-hold indicates temporary suspension pending parts or access. [ENUM-REF-CANDIDATE: created|assigned|in_progress|on_hold|completed|cancelled|closed — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the maintenance work order by its purpose: preventive (scheduled routine maintenance), corrective (repair of identified failure), emergency (urgent unplanned repair), inspection (regulatory or safety inspection), or recall (manufacturer-driven equipment recall).. Valid values are `preventive|corrective|emergency|inspection|recall`',
    `parts_cost` DECIMAL(18,2) COMMENT 'Total cost of parts, materials, and consumables used in the maintenance work order. Aggregated from parts consumption records linked to this work order.',
    `priority_level` STRING COMMENT 'Business priority classification indicating the urgency and criticality of the maintenance work order. Critical indicates immediate patient safety or facility operations impact; urgent requires same-day response; routine is standard priority; scheduled is planned preventive maintenance.. Valid values are `critical|urgent|routine|scheduled`',
    `problem_description` STRING COMMENT 'Detailed narrative description of the maintenance issue, failure symptoms, or preventive maintenance task to be performed. Captured by the requestor or automatically populated from PM schedule template.',
    `regulatory_driver` STRING COMMENT 'Identification of the regulatory requirement, accreditation standard, or compliance framework that mandates this maintenance activity. Examples include TJC EC.02.04.01 (environment of care), CMS conditions of participation, NFPA 99 (healthcare facilities code), NFPA 101 (life safety code), or state department of health regulations.',
    `request_datetime` TIMESTAMP COMMENT 'Date and time when the maintenance work order was originally requested or created in the system. Used for calculating response time and work order aging metrics.',
    `risk_assessment_score` STRING COMMENT 'Quantitative risk score assigned to the asset or maintenance activity based on risk-based assessment methodology such as Alternative Equipment Maintenance (AEM) or Authority Having Jurisdiction (AHJ) criteria. Higher scores indicate greater patient safety or operational risk.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether this maintenance work order was triggered by or resulted in a safety incident, patient safety event, or environmental hazard. Used for safety reporting and root cause analysis.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the maintenance work is scheduled to be completed. Used for resource planning and downtime coordination with clinical operations.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the maintenance work is scheduled to begin. For preventive maintenance, this is calculated from the PM schedule frequency and last completion date.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the maintenance work order, including labor cost, parts cost, and any additional charges (contractor fees, disposal fees). Used for asset lifecycle cost analysis and facilities management KPIs.',
    `trade_type` STRING COMMENT 'Classification of the skilled trade or technical specialty required to perform the maintenance work. Biomedical covers medical equipment; other trades cover facility infrastructure systems.. Valid values are `biomedical|electrical|plumbing|hvac|carpentry|fire_protection`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this maintenance order record was last modified in the data platform. Used for data lineage, change tracking, and audit trail purposes.',
    `vendor_service_flag` BOOLEAN COMMENT 'Indicates whether this maintenance work order was performed by an external vendor or contractor rather than internal facilities staff. Used for cost allocation and vendor performance tracking.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this maintenance work order is eligible for warranty claim or manufacturer reimbursement. Used for tracking warranty utilization and cost recovery.',
    `work_order_number` STRING COMMENT 'Externally-known unique business identifier for the maintenance work order, used for tracking and reference across systems and by technicians.. Valid values are `^[A-Z0-9]{8,20}$`',
    CONSTRAINT pk_maintenance_order PRIMARY KEY(`maintenance_order_id`)
) COMMENT 'Preventive and corrective maintenance work order for facility infrastructure and biomedical equipment, including the preventive maintenance schedule definitions that drive recurring work order generation. For work orders: captures work order number, order type (preventive, corrective, emergency, inspection-driven, recall-driven), priority level (critical, urgent, routine, scheduled), asset or location reference, problem description, failure code, assigned technician, trade type (biomedical, electrical, plumbing, HVAC, carpentry, fire protection), scheduled start and end datetime, actual start and completion datetime, labor hours, parts consumed with cost, total cost, and completion status. For PM schedules: captures schedule name, maintenance task template, frequency (daily, weekly, monthly, quarterly, semi-annual, annual), estimated labor hours, required trade, regulatory driver (TJC EC.02.04.01, CMS, NFPA 99, NFPA 101, state DOH), risk-based assessment score (AEM/AHJ), last completed date, next due date, and schedule active status. Integrates with SAP PM work order management and drives automated PM work order generation. Supports biomedical engineering PM compliance rates, facilities management KPIs, and regulatory audit evidence.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Building-level preventive maintenance schedules (elevator inspections, fire suppression system tests, emergency generator load tests, HVAC plant servicing) are standard in healthcare facility manageme',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the equipment asset is located.',
    `equipment_asset_id` BIGINT COMMENT 'Reference to the equipment asset or facility system covered by this preventive maintenance schedule.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Preventive maintenance schedules specify required parts that must be pre-staged from supply inventory. Linking to material_master normalizes parts specification (currently plain text parts_required) f',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Preventive maintenance schedules are mandated by compliance policies (NFPA 99, TJC EC.02.04.01, CMS CoP). pm_schedule has plain-text regulatory_citation and regulatory_driver — a FK to compliance_poli',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Preventive maintenance schedules in healthcare facilities apply to rooms as well as equipment assets. Room-level PM schedules include HVAC air exchange rate verification, negative pressure room testin',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: PM schedules are governed by vendor service contracts for medical equipment (OEM service agreements, biomedical maintenance contracts). Linking to vendor_contract supports service contract compliance ',
    `auto_generate_work_order` BOOLEAN COMMENT 'Boolean flag indicating whether work orders should be automatically generated in SAP PM when the next due date is reached.',
    `cost_center` STRING COMMENT 'Financial cost center to which preventive maintenance labor and materials costs should be charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this preventive maintenance schedule record was first created in the system.',
    `documentation_required` STRING COMMENT 'Type of documentation that must be completed and retained after maintenance (e.g., calibration certificate, inspection checklist, test results, compliance log).',
    `downtime_required` BOOLEAN COMMENT 'Boolean flag indicating whether the equipment or facility system must be taken offline or out of service to perform the maintenance task.',
    `equipment_category` STRING COMMENT 'Classification of the equipment or facility system (e.g., biomedical equipment, HVAC system, electrical system, plumbing system, fire safety system, medical gas system).',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours the equipment or system will be unavailable during maintenance, used for operational planning and patient care continuity.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete the preventive maintenance task, used for resource planning and scheduling.',
    `frequency` STRING COMMENT 'Recurring interval at which the preventive maintenance task must be performed. [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|semiannual|annual — 7 candidates stripped; promote to reference product]',
    `frequency_interval` STRING COMMENT 'Numeric value representing the interval count for the maintenance frequency (e.g., every 3 months, every 6 weeks).',
    `frequency_unit` STRING COMMENT 'Unit of measure for the frequency interval (time-based or usage-based).. Valid values are `days|weeks|months|years|hours|cycles`',
    `last_completed_date` DATE COMMENT 'Date when the preventive maintenance task was last successfully completed, used to calculate the next due date.',
    `lead_time_days` STRING COMMENT 'Number of days before the next due date that the work order should be generated, allowing time for scheduling and resource allocation.',
    `maintenance_task_description` STRING COMMENT 'Detailed description of the preventive maintenance tasks to be performed, including inspection points, calibration steps, cleaning procedures, and safety checks.',
    `maintenance_type` STRING COMMENT 'Category of preventive maintenance activity to be performed on the equipment or facility system.. Valid values are `inspection|calibration|cleaning|lubrication|testing|replacement`',
    `manufacturer_recommendation` STRING COMMENT 'Manufacturer-recommended maintenance schedule or service bulletin reference that informs this preventive maintenance plan.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this preventive maintenance schedule record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this preventive maintenance schedule record was last modified.',
    `next_due_date` DATE COMMENT 'Calculated date when the next preventive maintenance task is due, based on frequency and last completed date. Drives automated work order generation.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this preventive maintenance schedule.',
    `notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether stakeholder notification is required when work orders are generated or when maintenance is due.',
    `parts_required` STRING COMMENT 'List or description of spare parts, consumables, or materials required to complete the preventive maintenance task.',
    `planner_group` STRING COMMENT 'Maintenance planning group responsible for scheduling and coordinating this preventive maintenance activity.',
    `priority` STRING COMMENT 'Priority level of the preventive maintenance schedule, indicating urgency and impact on patient safety and facility operations.. Valid values are `critical|high|medium|low`',
    `regulatory_citation` STRING COMMENT 'Specific regulatory standard, code section, or citation that mandates this preventive maintenance requirement.',
    `regulatory_driver` STRING COMMENT 'Regulatory body or standard requiring this preventive maintenance activity (e.g., The Joint Commission (TJC), Centers for Medicare and Medicaid Services (CMS), National Fire Protection Association (NFPA), state Department of Health (DOH), Food and Drug Administration (FDA)).',
    `required_trade` STRING COMMENT 'Specific trade, skill, or certification required to perform the maintenance task (e.g., biomedical engineer, HVAC technician, electrician, plumber).',
    `safety_precautions` STRING COMMENT 'Required safety precautions, personal protective equipment (PPE), lockout/tagout procedures, or infection control measures that must be followed during maintenance.',
    `schedule_code` STRING COMMENT 'Unique business identifier or code for the preventive maintenance schedule, often used for integration with SAP PM and work order systems.',
    `schedule_end_date` DATE COMMENT 'Date when this preventive maintenance schedule expires or is no longer active. Null indicates an ongoing schedule.',
    `schedule_name` STRING COMMENT 'Descriptive name of the preventive maintenance schedule for identification and reporting purposes.',
    `schedule_start_date` DATE COMMENT 'Date when this preventive maintenance schedule becomes active and begins generating work orders.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the preventive maintenance schedule, indicating whether it is actively generating work orders.. Valid values are `active|inactive|suspended|completed`',
    `work_order_type` STRING COMMENT 'Type of work order to be generated for this preventive maintenance schedule in SAP PM (e.g., PM01 for preventive maintenance, PM02 for inspection).',
    `created_by` STRING COMMENT 'User ID or name of the person who created this preventive maintenance schedule record.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Preventive maintenance schedule defining the recurring maintenance plan for an equipment asset or facility system. Captures schedule name, associated asset or system, maintenance task description, frequency (daily, weekly, monthly, quarterly, annual), estimated labor hours, required trade, regulatory driver (TJC, CMS, NFPA, state DOH), last completed date, next due date, and schedule active status. Drives automated work order generation in SAP PM.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`license_accreditation` (
    `license_accreditation_id` BIGINT COMMENT 'Unique identifier for the facility license or accreditation credential record.',
    `accreditation_status_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_status. Business justification: Facility-level licenses and accreditations (building permits, OR certifications, unit-specific credentials) must link to enterprise accreditation tracking for deemed status verification, CMS certifica',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Many licenses and permits are building-specific (occupancy permits, building operating licenses, fire safety certificates, elevator permits). Adding building_id enables building-level credential track',
    `care_site_id` BIGINT COMMENT 'Reference to the care site or facility location to which this license or accreditation applies.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: License and accreditation records are issued under specific compliance programs (TJC, DNV, state licensure programs). Linking license_accreditation to compliance_program enables traceability from a fa',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Facility licenses and accreditations in healthcare can be scoped to specific clinical units, not just the overall care site or building. Examples include stroke center designation for a neurology unit',
    `accreditation_level` STRING COMMENT 'The level or tier of accreditation granted, if applicable. Examples include full accreditation, provisional accreditation, conditional accreditation, or specific program-level designations such as Level I Trauma Center or Primary Stroke Center.',
    `attestation_by` STRING COMMENT 'The name or identifier of the authorized individual who attested to the credential information.',
    `attestation_date` DATE COMMENT 'The date on which an authorized facility representative attested to the accuracy and completeness of the credential information for compliance or reporting purposes.',
    `bed_capacity_authorized` STRING COMMENT 'The number of licensed beds authorized under this credential, if applicable. Critical for hospital and inpatient facility licenses.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this license or accreditation credential record was first created in the system.',
    `credential_name` STRING COMMENT 'The full name or title of the license or accreditation credential as issued by the authority.',
    `credential_number` STRING COMMENT 'The unique license, certificate, or accreditation number issued by the governing authority. This is the externally-known identifier for the credential.',
    `credential_type` STRING COMMENT 'Type of license or accreditation credential. Examples include state hospital license, CMS Medicare certification, TJC accreditation, DNV accreditation, CLIA laboratory certificate, state pharmacy license, trauma center designation, stroke center certification. [ENUM-REF-CANDIDATE: state_hospital_license|cms_medicare_certification|tjc_accreditation|dnv_accreditation|clia_laboratory_certificate|state_pharmacy_license|trauma_center_designation|stroke_center_certification|ambulatory_surgery_center_license|behavioral_health_license|home_health_license|hospice_license|imaging_center_license|dialysis_facility_certification — promote to reference product]. Valid values are `state_hospital_license|cms_medicare_certification|tjc_accreditation|dnv_accreditation|clia_laboratory_certificate|state_pharmacy_license`',
    `deemed_status_flag` BOOLEAN COMMENT 'Indicates whether the facility has deemed status, meaning accreditation by an approved organization (e.g., The Joint Commission, DNV) satisfies CMS Medicare certification requirements.',
    `deeming_organization` STRING COMMENT 'The name of the accreditation organization that provides deemed status for CMS certification, if applicable. Examples include The Joint Commission, DNV Healthcare, HFAP.',
    `deficiency_count` STRING COMMENT 'The number of deficiencies or non-compliance findings identified during the most recent survey or inspection.',
    `document_reference_url` STRING COMMENT 'URL or file path reference to the scanned or electronic copy of the license or accreditation certificate document.',
    `effective_date` DATE COMMENT 'The date from which the license or accreditation becomes valid and enforceable for operational and regulatory purposes.',
    `expiration_date` DATE COMMENT 'The date on which the license or accreditation credential expires and must be renewed to maintain compliance.',
    `issue_date` DATE COMMENT 'The date on which the license or accreditation credential was originally issued or granted by the authority.',
    `issuing_authority` STRING COMMENT 'The name of the regulatory body, accreditation organization, or government agency that issued the credential. Examples include state departments of health, CMS, The Joint Commission, DNV, CLIA.',
    `issuing_authority_code` STRING COMMENT 'Standardized code representing the issuing authority for system integration and reporting purposes.',
    `license_accreditation_status` STRING COMMENT 'Current lifecycle status of the license or accreditation credential. Indicates whether the credential is active, pending renewal, expired, suspended, revoked, or inactive.. Valid values are `active|pending_renewal|expired|suspended|revoked|inactive`',
    `medicaid_provider_number` STRING COMMENT 'The state-assigned Medicaid provider number associated with this credential, if applicable.',
    `medicare_provider_number` STRING COMMENT 'The CMS-assigned Medicare provider number associated with this credential, if applicable. Critical for billing and reimbursement.',
    `next_survey_date` DATE COMMENT 'The scheduled or anticipated date for the next on-site survey, inspection, or audit by the issuing authority.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context related to the license or accreditation credential. May include special conditions, restrictions, or historical context.',
    `payer_contract_requirement_flag` BOOLEAN COMMENT 'Indicates whether this credential is required for payer contracting or network participation agreements.',
    `plan_of_correction_approved_date` DATE COMMENT 'The date on which the issuing authority approved the facilitys plan of correction.',
    `plan_of_correction_due_date` DATE COMMENT 'The date by which the facility must submit a plan of correction to address identified deficiencies or non-compliance findings.',
    `plan_of_correction_submitted_date` DATE COMMENT 'The date on which the facility submitted its plan of correction to the issuing authority.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this credential information is publicly disclosed or reported to regulatory agencies, quality reporting organizations, or consumer transparency platforms.',
    `renewal_application_date` DATE COMMENT 'The date on which the renewal application for the license or accreditation was submitted to the issuing authority.',
    `renewal_due_date` DATE COMMENT 'The date by which the renewal application must be submitted to avoid lapse in credential status.',
    `scope_of_credential` STRING COMMENT 'Description of the services, procedures, or operational scope covered by the license or accreditation. May include bed capacity limits, service line restrictions, or specific procedural authorizations.',
    `status_effective_date` DATE COMMENT 'The date on which the current status became effective.',
    `status_reason` STRING COMMENT 'Explanation or reason for the current status, particularly for suspended, revoked, or inactive credentials. May include regulatory findings, compliance failures, or voluntary surrender.',
    `survey_date` DATE COMMENT 'The date of the most recent on-site survey, inspection, or audit conducted by the issuing authority to assess compliance with standards.',
    `survey_outcome` STRING COMMENT 'The result or outcome of the most recent survey or inspection. May include findings such as full compliance, deficiencies identified, conditional status, or immediate jeopardy.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this license or accreditation credential record was last updated or modified in the system.',
    CONSTRAINT pk_license_accreditation PRIMARY KEY(`license_accreditation_id`)
) COMMENT 'Facility license and accreditation credential record. Tracks credential type (state hospital license, CMS Medicare certification, TJC accreditation, DNV accreditation, CLIA laboratory certificate, state pharmacy license, trauma center designation, stroke center certification), issuing authority, license or certificate number, issue date, expiration date, renewal application date, current status (active, pending renewal, suspended, revoked), and associated care site. Critical for regulatory compliance and payer contracting.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`service` (
    `service_id` BIGINT COMMENT 'Unique identifier for the facility service record. Primary key.',
    `accreditation_status_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_status. Business justification: Clinical service lines (NICU Level III, Chest Pain Center, Stroke Center) hold their own accreditation status records distinct from the facility. Linking service to accreditation_status enables servic',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Clinical services are often building-specific (Cardiac Surgery in Main Hospital Building, Outpatient Dialysis in Ambulatory Building). Adding building_id enables building-level service catalog managem',
    `care_site_id` BIGINT COMMENT 'Reference to the care site or facility where this service is offered.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Service line contracting: clinical service lines are frequently operated by contracted provider groups (hospitalist groups, radiology groups, anesthesia groups). Linking service to group supports serv',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Service line governance and accreditation requirements mandate a named medical director for each clinical service. Links to clinician record for credentialing verification, privileging confirmation, a',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Clinical service lines (cancer program, chest pain center, trauma) are enrolled in specific compliance programs (CoC, ACC, ACS). Service has denormalized accreditation_body/date/level attributes that ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Network adequacy reporting and payer directory management require mapping facility service lines to clinical specialties. facility.service.clinical_specialty is a denormalized text field; normalizing ',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Clinical services are often unit-specific (Cardiac Surgery in OR Unit 3, Interventional Cardiology in Cath Lab Unit). Adding unit_id enables unit-level service delivery tracking, supports unit-specifi',
    `accreditation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the service requires specific accreditation or certification from an external body such as The Joint Commission, American College of Surgeons, or specialty-specific accrediting organizations.',
    `bariatric_surgery_accreditation` STRING COMMENT 'Metabolic and Bariatric Surgery Accreditation and Quality Improvement Program (MBSAQIP) accreditation status for bariatric surgery services.',
    `cancer_program_accreditation` STRING COMMENT 'Commission on Cancer accreditation status or designation for oncology services, such as Comprehensive Community Cancer Program, Academic Comprehensive Cancer Program, or Community Cancer Program.',
    `chest_pain_center_accreditation` STRING COMMENT 'Accreditation status for chest pain or cardiac emergency services, such as Chest Pain Center with PCI or Chest Pain Center accreditation from the American College of Cardiology or Society of Cardiovascular Patient Care.',
    `cms_service_type_code` STRING COMMENT 'CMS-defined service type code used for billing, claims processing, and regulatory reporting to identify the nature of the service provided.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this facility service record was first created in the system.',
    `emergency_service_flag` BOOLEAN COMMENT 'Boolean indicator of whether the service is classified as an emergency service subject to Emergency Medical Treatment and Labor Act (EMTALA) requirements.',
    `end_date` DATE COMMENT 'Date on which the service was discontinued or is planned to be discontinued at the care site. Null if the service is ongoing.',
    `license_expiration_date` DATE COMMENT 'Date on which the service license expires and must be renewed to continue legal operation of the service.',
    `license_number` STRING COMMENT 'Official license number issued by the state or federal regulatory authority for services that require specific licensure to operate.',
    `license_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the service requires a specific state or federal license to operate legally, such as a radiation therapy license or behavioral health program license.',
    `line` STRING COMMENT 'High-level service line grouping such as Cardiovascular, Neurosciences, Oncology, Womens Health, Pediatrics, Behavioral Health, Emergency Services, or Surgical Services.',
    `nicu_level` STRING COMMENT 'American Academy of Pediatrics NICU level designation (Level I through Level IV) indicating the complexity of neonatal care capabilities. Not applicable for non-neonatal services.. Valid values are `level_i|level_ii|level_iii|level_iv|not_applicable`',
    `patient_access_phone` STRING COMMENT 'Primary phone number for patients or referring providers to contact for scheduling, inquiries, or referrals to this service.',
    `payer_contracted_flag` BOOLEAN COMMENT 'Boolean indicator of whether the service is included in payer contracts and eligible for reimbursement under managed care agreements.',
    `referral_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether patients require a physician referral or prior authorization to access this service, commonly used for specialty services and payer contracting.',
    `service_category` STRING COMMENT 'Broad category of service delivery model indicating whether the service is provided on an inpatient, outpatient, ambulatory, emergency, telehealth, or home health basis.. Valid values are `inpatient|outpatient|ambulatory|emergency|telehealth|home_health`',
    `service_code` STRING COMMENT 'Unique alphanumeric code identifying the clinical service or program within the organizations service catalog.',
    `service_description` STRING COMMENT 'Detailed narrative description of the clinical service or program, including scope of care, patient populations served, and key capabilities or technologies available.',
    `service_name` STRING COMMENT 'Full descriptive name of the clinical service or program offered at the care site, such as Cardiac Surgery, Level I Trauma Center, Comprehensive Stroke Center, NICU Level III, Radiation Oncology, Behavioral Health, or Telehealth.',
    `service_status` STRING COMMENT 'Current operational status of the service indicating whether it is actively offered, temporarily suspended, planned for future launch, or discontinued.. Valid values are `active|inactive|suspended|planned|discontinued`',
    `start_date` DATE COMMENT 'Date on which the service was first made available to patients at the care site, marking the operational launch of the service or program.',
    `stroke_center_designation` STRING COMMENT 'The Joint Commission stroke center certification level indicating the facilitys capability to provide stroke care, such as Comprehensive Stroke Center, Primary Stroke Center, Acute Stroke Ready, or Thrombectomy-Capable. Not applicable for non-stroke services.. Valid values are `comprehensive|primary|acute_ready|thrombectomy_capable|not_applicable`',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Boolean indicator of whether the service can be delivered via telehealth or virtual care modalities, supporting remote patient access.',
    `trauma_level` STRING COMMENT 'American College of Surgeons trauma center designation level (Level I through Level V) indicating the capability and resources available for trauma care. Not applicable for non-trauma services.. Valid values are `level_i|level_ii|level_iii|level_iv|level_v|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this facility service record was last modified or updated in the system.',
    `url` STRING COMMENT 'Web address or URL providing public-facing information about the service, used for patient education, referral routing, and marketing purposes.',
    `volume_annual` STRING COMMENT 'Estimated or actual annual volume of patients or procedures served by this service, used for capacity planning, quality benchmarking, and payer contracting negotiations.',
    CONSTRAINT pk_service PRIMARY KEY(`service_id`)
) COMMENT 'Catalog of services and clinical programs offered at a care site, such as cardiac surgery, level I trauma, comprehensive stroke center, NICU level III, radiation oncology, behavioral health, and telehealth. Captures service name, service line, clinical specialty, service category, CMS service type code, start date, end date, accreditation or certification required, and active status. Supports patient access, referral routing, and payer contracting.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`facility`.`organization` (
    `organization_id` BIGINT COMMENT 'Primary key for organization',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Organizations (health systems, hospital groups) hold Type 2 NPIs used in CMS claims submission, provider directory maintenance, and NPPES validation. Linking organization to npi_registry normalizes th',
    `accreditation_effective_date` DATE COMMENT 'Date when current accreditation status became effective.',
    `accreditation_expiration_date` DATE COMMENT 'Date when current accreditation expires and renewal is required.',
    `accreditation_status` STRING COMMENT 'Current accreditation standing with recognized healthcare accrediting bodies.',
    `accrediting_body` STRING COMMENT 'Name of the primary accreditation organization (e.g., Joint Commission, DNV, HFAP).',
    `address_line_1` STRING COMMENT 'Primary street address of the organization facility.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number.',
    `city` STRING COMMENT 'City where the organization facility is located.',
    `closure_date` DATE COMMENT 'Date when the organization ceased operations, if applicable.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the organization is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organization record was first created in the system.',
    `critical_access_hospital_indicator` BOOLEAN COMMENT 'Indicates whether the facility is designated as a Critical Access Hospital under Medicare.',
    `doing_business_as_name` STRING COMMENT 'Trade name or DBA name under which the organization operates, if different from legal name.',
    `email_address` STRING COMMENT 'Primary email address for organizational communication.',
    `emergency_services_indicator` BOOLEAN COMMENT 'Indicates whether the facility provides emergency department services.',
    `established_date` DATE COMMENT 'Date when the organization was originally established or founded.',
    `facility_type` STRING COMMENT 'Specific facility classification based on care delivery focus and patient population served.',
    `fax_number` STRING COMMENT 'Fax number for document transmission to the organization.',
    `health_system_name` STRING COMMENT 'Name of the integrated delivery network or health system to which this organization belongs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organization record was last updated.',
    `license_effective_date` DATE COMMENT 'Date when the current facility license became effective.',
    `license_expiration_date` DATE COMMENT 'Date when the current facility license expires.',
    `license_number` STRING COMMENT 'State-issued license number authorizing the organization to operate as a healthcare facility.',
    `license_status` STRING COMMENT 'Current status of the facility operating license.',
    `medicaid_provider_number` STRING COMMENT 'State-issued Medicaid provider identification number for billing and reimbursement.',
    `medicare_provider_number` STRING COMMENT 'Six-digit CMS Certification Number (CCN) identifying the organization for Medicare billing.',
    `operational_start_date` DATE COMMENT 'Date when the facility began active operations and patient care delivery.',
    `operational_status` STRING COMMENT 'Current operational state of the organization in its lifecycle.',
    `organization_name` STRING COMMENT 'Official legal name of the healthcare organization, facility, or entity.',
    `organization_type` STRING COMMENT 'Classification of the healthcare organization based on primary service delivery model.',
    `ownership_type` STRING COMMENT 'Legal ownership structure and governance model of the organization.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the organization.',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the facility address.',
    `service_area_description` STRING COMMENT 'Geographic description of the primary service area or catchment area served by the organization.',
    `staffed_bed_count` STRING COMMENT 'Number of beds that are currently staffed and available for patient use.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the facility is located.',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID assigned by the IRS.',
    `teaching_hospital_indicator` BOOLEAN COMMENT 'Indicates whether the facility is affiliated with a medical school and provides graduate medical education.',
    `total_bed_count` STRING COMMENT 'Total number of licensed beds available across all units in the facility.',
    `trauma_level` STRING COMMENT 'Trauma center designation level indicating capability to treat severe injuries.',
    `website_url` STRING COMMENT 'Official website URL for the organization.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Master reference table for organization. Referenced by organization_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `healthcare_ecm`.`facility`.`organization`(`organization_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_parent_care_site_id` FOREIGN KEY (`parent_care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `healthcare_ecm`.`facility`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `healthcare_ecm`.`facility`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm`.`facility`.`unit`(`unit_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm`.`facility` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm`.`facility` SET TAGS ('dbx_domain' = 'facility');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` SET TAGS ('dbx_subdomain' = 'care_locations');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `parent_care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Care Site Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_value_regex' = 'the_joint_commission|dnv_healthcare|hfap|cihq|aaahc|not_accredited');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|denied|withdrawn|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `ccn` SET TAGS ('dbx_business_glossary_term' = 'CMS Certification Number (CCN)');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `ccn` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{6}$');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `critical_access_hospital` SET TAGS ('dbx_business_glossary_term' = 'Critical Access Hospital (CAH) Status');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `disproportionate_share_hospital` SET TAGS ('dbx_business_glossary_term' = 'Disproportionate Share Hospital (DSH) Status');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `emergency_services_available` SET TAGS ('dbx_business_glossary_term' = 'Emergency Services Available');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `hierarchy_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Effective Date');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_value_regex' = 'health_system|region|market|campus|site');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('dbx_business_glossary_term' = 'Licensed Bed Capacity');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `licensure_status` SET TAGS ('dbx_business_glossary_term' = 'Licensure Status');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `licensure_status` SET TAGS ('dbx_value_regex' = 'active|provisional|suspended|revoked|expired');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `medicaid_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Provider Number');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `medicare_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Provider Number');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|temporarily_closed|permanently_closed');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'government_federal|government_state|government_local|nonprofit|for_profit|physician_owned');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Care Site Name');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `sole_community_hospital` SET TAGS ('dbx_business_glossary_term' = 'Sole Community Hospital (SCH) Status');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('dbx_business_glossary_term' = 'Staffed Bed Capacity');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `teaching_status` SET TAGS ('dbx_business_glossary_term' = 'Teaching Status');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Level Designation');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|level_5|not_designated');
ALTER TABLE `healthcare_ecm`.`facility`.`care_site` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `healthcare_ecm`.`facility`.`building` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`building` SET TAGS ('dbx_subdomain' = 'care_locations');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `annual_property_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Property Tax Amount');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `annual_property_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `building_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `building_type` SET TAGS ('dbx_value_regex' = 'clinical|administrative|research|parking|mixed_use|support');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `cms_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Certification Number');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('dbx_business_glossary_term' = 'Electrical Service Capacity in Kilovolt-Amperes (kVA)');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Emergency Generator Capacity in Kilowatts (kW)');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `emergency_generator_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Emergency Generator Coverage Type');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `emergency_generator_coverage_type` SET TAGS ('dbx_value_regex' = 'full_building|life_safety_only|critical_systems|partial');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `facility_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Facility License Expiration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('dbx_business_glossary_term' = 'Facility License Number');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `fire_safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Classification');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `fire_safety_classification` SET TAGS ('dbx_value_regex' = 'type_i|type_ii|type_iii|type_iv|type_v');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `gross_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Gross Square Footage');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `helipad_available` SET TAGS ('dbx_business_glossary_term' = 'Helipad Available');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `hvac_system_type` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) System Type');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `hvac_system_type` SET TAGS ('dbx_value_regex' = 'central_chilled_water|variable_air_volume|constant_air_volume|heat_pump|split_system|packaged_unit');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Joint Commission Accreditation Expiration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Joint Commission Accreditation Status');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|denied|not_applicable|pending');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `last_major_renovation_year` SET TAGS ('dbx_business_glossary_term' = 'Last Major Renovation Year');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Level');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum|not_certified');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('dbx_business_glossary_term' = 'Medical Gas System Installed');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `net_usable_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Net Usable Square Footage');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `number_of_elevators` SET TAGS ('dbx_business_glossary_term' = 'Number of Elevators');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `number_of_floors` SET TAGS ('dbx_business_glossary_term' = 'Number of Floors');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|under_renovation|decommissioned|planned');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|ground_lease|joint_venture|managed');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `parking_spaces_count` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces Count');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `property_tax_parcel_number` SET TAGS ('dbx_business_glossary_term' = 'Property Tax Parcel Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `replacement_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Replacement Value Amount');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `replacement_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `seismic_zone` SET TAGS ('dbx_business_glossary_term' = 'Seismic Zone');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `seismic_zone` SET TAGS ('dbx_value_regex' = 'zone_0|zone_1|zone_2|zone_3|zone_4');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `sprinkler_system_type` SET TAGS ('dbx_business_glossary_term' = 'Sprinkler System Type');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `sprinkler_system_type` SET TAGS ('dbx_value_regex' = 'wet_pipe|dry_pipe|pre_action|deluge|none');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`building` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` SET TAGS ('dbx_subdomain' = 'care_locations');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `accreditation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Manager Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `accepts_admissions` SET TAGS ('dbx_business_glossary_term' = 'Accepts Admissions Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `accepts_transfers` SET TAGS ('dbx_business_glossary_term' = 'Accepts Transfers Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `acuity_level` SET TAGS ('dbx_business_glossary_term' = 'Patient Acuity Level');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `acuity_level` SET TAGS ('dbx_value_regex' = 'critical|acute|intermediate|general|ambulatory');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `age_restriction` SET TAGS ('dbx_value_regex' = 'pediatric_only|adult_only|geriatric_only|all_ages');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `air_changes_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Air Changes Per Hour (ACH)');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `chest_pain_center_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Chest Pain Center Accreditation Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) System');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `emergency_power_backup` SET TAGS ('dbx_business_glossary_term' = 'Emergency Power Backup Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'male_only|female_only|mixed|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `hvac_system_type` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) System Type');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `infection_control_zone` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Zone');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `infection_control_zone` SET TAGS ('dbx_value_regex' = 'standard|enhanced|high_risk|isolation');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `is_twenty_four_seven` SET TAGS ('dbx_business_glossary_term' = 'Is Twenty-Four Seven (24/7) Unit');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `isolation_room_count` SET TAGS ('dbx_business_glossary_term' = 'Isolation Room Count');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `licensed_bed_count` SET TAGS ('dbx_business_glossary_term' = 'Licensed Bed Count');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `magnet_recognition` SET TAGS ('dbx_business_glossary_term' = 'Magnet Recognition Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('dbx_business_glossary_term' = 'Medical Gas System Type');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `negative_pressure_room_count` SET TAGS ('dbx_business_glossary_term' = 'Negative Pressure Room Count');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `nurse_call_system_type` SET TAGS ('dbx_business_glossary_term' = 'Nurse Call System Type');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('dbx_business_glossary_term' = 'Nurse to Patient Ratio');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('dbx_value_regex' = '^1:[0-9]{1,2}$');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `operational_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours End Time');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `operational_hours_end` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `operational_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours Start Time');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `operational_hours_start` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `staffed_bed_count` SET TAGS ('dbx_business_glossary_term' = 'Staffed Bed Count');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `stroke_center_designation` SET TAGS ('dbx_business_glossary_term' = 'Stroke Center Designation');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `stroke_center_designation` SET TAGS ('dbx_value_regex' = 'comprehensive|primary|acute_ready|not_designated');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `teaching_unit_flag` SET TAGS ('dbx_business_glossary_term' = 'Teaching Unit Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `telemetry_monitoring_capability` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Monitoring Capability Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Level Designation');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Code');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Operational Status');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|temporarily_closed|decommissioned');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Unit Type');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|procedural|diagnostic|administrative|support');
ALTER TABLE `healthcare_ecm`.`facility`.`unit` ALTER COLUMN `wing_or_section` SET TAGS ('dbx_business_glossary_term' = 'Wing or Section');
ALTER TABLE `healthcare_ecm`.`facility`.`room` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`room` SET TAGS ('dbx_subdomain' = 'care_locations');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|not_accredited|pending');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `bariatric_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Bariatric Capable Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Bed Count');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `boom_configuration` SET TAGS ('dbx_business_glossary_term' = 'Boom Configuration');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `emergency_power_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Power Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `hand_hygiene_station_count` SET TAGS ('dbx_business_glossary_term' = 'Hand Hygiene Station Count');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `hvac_air_exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) Air Exchange Rate');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `imaging_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Imaging Integration Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `isolation_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Isolation Capable Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `last_deep_clean_date` SET TAGS ('dbx_business_glossary_term' = 'Last Deep Clean Date');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `lease_ownership_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lease Ownership Indicator');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `lease_ownership_indicator` SET TAGS ('dbx_value_regex' = 'owned|leased|shared|contracted');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Medical Air Outlet Count');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `monthly_space_cost` SET TAGS ('dbx_business_glossary_term' = 'Monthly Space Cost');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `monthly_space_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `negative_pressure_flag` SET TAGS ('dbx_business_glossary_term' = 'Negative Pressure Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `nitrous_oxide_outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Nitrous Oxide (N2O) Outlet Count');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `nurse_call_system_flag` SET TAGS ('dbx_business_glossary_term' = 'Nurse Call System Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `occupancy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Percentage');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `or_airflow_class` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Airflow Class');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `or_airflow_class` SET TAGS ('dbx_value_regex' = 'iso_5|iso_6|iso_7|iso_8|standard');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `oxygen_outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Oxygen (O2) Outlet Count');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `room_class` SET TAGS ('dbx_business_glossary_term' = 'Room Class');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `room_class` SET TAGS ('dbx_value_regex' = 'private|semi_private|ward|suite|isolation|observation');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('dbx_business_glossary_term' = 'Room Name');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `room_status` SET TAGS ('dbx_business_glossary_term' = 'Room Status');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `room_status` SET TAGS ('dbx_value_regex' = 'available|occupied|cleaning|out_of_service|maintenance|reserved');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `room_type` SET TAGS ('dbx_business_glossary_term' = 'Room Type');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `telemetry_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Capable Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `vacuum_outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Vacuum Outlet Count');
ALTER TABLE `healthcare_ecm`.`facility`.`room` ALTER COLUMN `ventilator_outlet_count` SET TAGS ('dbx_business_glossary_term' = 'Ventilator Outlet Count');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` SET TAGS ('dbx_subdomain' = 'care_locations');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `bed_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `building_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `age_restriction` SET TAGS ('dbx_value_regex' = 'adult|pediatric|neonatal|any');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Bed Asset Tag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `bed_category` SET TAGS ('dbx_business_glossary_term' = 'Bed Category');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `bed_category` SET TAGS ('dbx_value_regex' = 'medical|surgical|pediatric|maternity|psychiatric|rehabilitation');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `bed_status` SET TAGS ('dbx_business_glossary_term' = 'Bed Status');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `bed_status` SET TAGS ('dbx_value_regex' = 'available|occupied|dirty|blocked|out_of_service|housekeeping');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `bed_type` SET TAGS ('dbx_business_glossary_term' = 'Bed Type');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `discharge_ready_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Ready Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `expected_available_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Available Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'male|female|any');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Bed Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `is_air_fluidized` SET TAGS ('dbx_business_glossary_term' = 'Air Fluidized Bed Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `is_bariatric_capable` SET TAGS ('dbx_business_glossary_term' = 'Bariatric Capable Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `is_isolation_capable` SET TAGS ('dbx_business_glossary_term' = 'Isolation Capable Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `is_licensed` SET TAGS ('dbx_business_glossary_term' = 'Licensed Bed Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `is_low_bed` SET TAGS ('dbx_business_glossary_term' = 'Low Bed Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `is_negative_pressure_room` SET TAGS ('dbx_business_glossary_term' = 'Negative Pressure Room Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `is_private_room` SET TAGS ('dbx_business_glossary_term' = 'Private Room Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `is_staffed` SET TAGS ('dbx_business_glossary_term' = 'Staffed Bed Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `is_telemetry_capable` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Capable Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Bed Label');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `last_cleaned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Cleaned Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `out_of_service_reason` SET TAGS ('dbx_business_glossary_term' = 'Out of Service Reason');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Bed Position');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `status_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bed Status Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity (Pounds)');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` SET TAGS ('dbx_subdomain' = 'care_locations');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `bed_status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Bed Status Event ID');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `adt_event_id` SET TAGS ('dbx_business_glossary_term' = 'Adt Event Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `bed_id` SET TAGS ('dbx_business_glossary_term' = 'Bed ID');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order ID');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `actual_availability_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Availability Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `acuity_level` SET TAGS ('dbx_business_glossary_term' = 'Acuity Level');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `acuity_level` SET TAGS ('dbx_value_regex' = 'critical|acute|intermediate|observation|general');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `adt_event_type` SET TAGS ('dbx_business_glossary_term' = 'ADT (Admit-Discharge-Transfer) Event Type');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `adt_event_type` SET TAGS ('dbx_value_regex' = 'admit|discharge|transfer|cancel|update');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `bed_assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Bed Assignment Method');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `bed_assignment_method` SET TAGS ('dbx_value_regex' = 'manual|automated|hybrid');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `blocked_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason Category');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `blocked_reason_category` SET TAGS ('dbx_value_regex' = 'construction|equipment_failure|staffing_shortage|infection_control|administrative|other');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `expected_availability_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Availability Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('dbx_business_glossary_term' = 'Initiating User Role');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `is_elective_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Elective Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `is_emergency_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `isolation_type` SET TAGS ('dbx_business_glossary_term' = 'Isolation Type');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `isolation_type` SET TAGS ('dbx_value_regex' = 'contact|droplet|airborne|protective|none');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `new_status_code` SET TAGS ('dbx_business_glossary_term' = 'New Status Code');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `prior_status_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Status Code');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `healthcare_ecm`.`facility`.`bed_status_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` SET TAGS ('dbx_subdomain' = 'care_locations');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Suite Identifier');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|not_accredited|pending_survey');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `anesthesia_machine_model` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Machine Model');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `boom_configuration` SET TAGS ('dbx_business_glossary_term' = 'Surgical Boom Configuration');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `boom_configuration` SET TAGS ('dbx_value_regex' = 'none|single_ceiling_boom|dual_ceiling_boom|articulating_arm|wall_mounted');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `emergency_power_backup_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Power Backup Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `emergency_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Use Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `equipment_inventory_list` SET TAGS ('dbx_business_glossary_term' = 'Equipment Inventory List');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_value_regex' = 'sprinkler|clean_agent|water_mist|none');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `hvac_air_exchange_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) Air Exchange Rate Per Hour');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `imaging_integration_type` SET TAGS ('dbx_business_glossary_term' = 'Imaging Integration Type');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `imaging_integration_type` SET TAGS ('dbx_value_regex' = 'none|c_arm|intraoperative_mri|intraoperative_ct|fluoroscopy|hybrid_angio');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `isolation_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Isolation Capable Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `laminar_airflow_class` SET TAGS ('dbx_business_glossary_term' = 'Laminar Airflow Cleanroom Classification (ISO)');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `laminar_airflow_class` SET TAGS ('dbx_value_regex' = 'iso_5|iso_6|iso_7|iso_8|standard');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `last_accreditation_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Accreditation Survey Date');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Facility License Number');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('dbx_business_glossary_term' = 'Medical Gas Outlets Count');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `next_accreditation_survey_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Accreditation Survey Due Date');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|renovation|decommissioned');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Name');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `or_number` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Number');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `or_number` SET TAGS ('dbx_value_regex' = '^OR[0-9]{1,4}$');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `or_type` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Type');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `or_type` SET TAGS ('dbx_value_regex' = 'general|cardiac|orthopedic|neurosurgery|hybrid|endoscopy');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `pediatric_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Pediatric Capable Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `positive_pressure_maintained_flag` SET TAGS ('dbx_business_glossary_term' = 'Positive Pressure Maintained Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `robotic_surgery_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Robotic Surgery Compatible Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `room_height_feet` SET TAGS ('dbx_business_glossary_term' = 'Room Height in Feet');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `room_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Room Length in Feet');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `room_width_feet` SET TAGS ('dbx_business_glossary_term' = 'Room Width in Feet');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `scheduled_maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Maintenance Window');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `status_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `status_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Reason Code');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `surgical_table_type` SET TAGS ('dbx_business_glossary_term' = 'Surgical Table Type');
ALTER TABLE `healthcare_ecm`.`facility`.`or_suite` ALTER COLUMN `video_integration_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Video Integration Capability Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` SET TAGS ('dbx_subdomain' = 'asset_maintenance');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Current Location Care Site ID');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Or Suite Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `calibration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `current_location_floor` SET TAGS ('dbx_business_glossary_term' = 'Current Location Floor');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|donated|recycled|destroyed|returned_to_vendor|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `environmental_requirements` SET TAGS ('dbx_business_glossary_term' = 'Environmental Requirements');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `fda_device_class` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Device Class');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `fda_device_class` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `infection_control_category` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Category');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `infection_control_category` SET TAGS ('dbx_value_regex' = 'critical|semi_critical|non_critical|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `last_pm_date` SET TAGS ('dbx_business_glossary_term' = 'Last Preventive Maintenance (PM) Date');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `mobility_indicator` SET TAGS ('dbx_business_glossary_term' = 'Mobility Indicator');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `mobility_indicator` SET TAGS ('dbx_value_regex' = 'fixed|portable|mobile');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `next_pm_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Preventive Maintenance (PM) Due Date');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Equipment Notes');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|under_repair|retired|condemned|quarantined');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `pm_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Compliance Status');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `pm_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|overdue|upcoming|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `pm_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Frequency in Days');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `power_requirements` SET TAGS ('dbx_business_glossary_term' = 'Power Requirements');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Recall Number');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `recall_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Remediation Date');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'no_recall|active_recall|recall_remediated|under_investigation');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `sap_equipment_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Equipment Number');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Expiration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `udi` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier (UDI)');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `healthcare_ecm`.`facility`.`equipment_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` SET TAGS ('dbx_subdomain' = 'asset_maintenance');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `actual_completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date and Time');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `approval_datetime` SET TAGS ('dbx_business_glossary_term' = 'Approval Date and Time');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime Minutes');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Failure Code');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Status');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Type');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|emergency|inspection|recall');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority Level');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|urgent|routine|scheduled');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `problem_description` SET TAGS ('dbx_business_glossary_term' = 'Problem Description');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `request_datetime` SET TAGS ('dbx_business_glossary_term' = 'Request Date and Time');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Maintenance Cost');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `trade_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Type');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `trade_type` SET TAGS ('dbx_value_regex' = 'biomedical|electrical|plumbing|hvac|carpentry|fire_protection');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `vendor_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Service Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `healthcare_ecm`.`facility`.`maintenance_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'asset_maintenance');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `auto_generate_work_order` SET TAGS ('dbx_business_glossary_term' = 'Auto Generate Work Order Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `downtime_required` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Unit');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_value_regex' = 'days|weeks|months|years|hours|cycles');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `last_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Date');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `maintenance_task_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Task Description');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'inspection|calibration|cleaning|lubrication|testing|replacement');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `manufacturer_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Recommendation');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `parts_required` SET TAGS ('dbx_business_glossary_term' = 'Parts Required');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `planner_group` SET TAGS ('dbx_business_glossary_term' = 'Planner Group');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `required_trade` SET TAGS ('dbx_business_glossary_term' = 'Required Trade or Skill');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `safety_precautions` SET TAGS ('dbx_business_glossary_term' = 'Safety Precautions');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Code');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule End Date');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Name');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Date');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|completed');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `healthcare_ecm`.`facility`.`pm_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` SET TAGS ('dbx_subdomain' = 'service_compliance');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'License Accreditation Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `accreditation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `accreditation_level` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Level');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `attestation_by` SET TAGS ('dbx_business_glossary_term' = 'Attestation By');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `bed_capacity_authorized` SET TAGS ('dbx_business_glossary_term' = 'Bed Capacity Authorized');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `credential_name` SET TAGS ('dbx_business_glossary_term' = 'Credential Name');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `credential_number` SET TAGS ('dbx_business_glossary_term' = 'Credential Number');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'state_hospital_license|cms_medicare_certification|tjc_accreditation|dnv_accreditation|clia_laboratory_certificate|state_pharmacy_license');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `deemed_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Deemed Status Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `deeming_organization` SET TAGS ('dbx_business_glossary_term' = 'Deeming Organization');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `document_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Uniform Resource Locator (URL)');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `issuing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Code');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_status` SET TAGS ('dbx_value_regex' = 'active|pending_renewal|expired|suspended|revoked|inactive');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `medicaid_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Provider Number');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `medicare_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Provider Number');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `next_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Next Survey Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `payer_contract_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Requirement Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `plan_of_correction_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (POC) Approved Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `plan_of_correction_due_date` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (POC) Due Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `plan_of_correction_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Plan of Correction (POC) Submitted Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `scope_of_credential` SET TAGS ('dbx_business_glossary_term' = 'Scope of Credential');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `survey_outcome` SET TAGS ('dbx_business_glossary_term' = 'Survey Outcome');
ALTER TABLE `healthcare_ecm`.`facility`.`license_accreditation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`service` SET TAGS ('dbx_subdomain' = 'service_compliance');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Service Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `accreditation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Director Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `accreditation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Required Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `bariatric_surgery_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Bariatric Surgery Accreditation');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `cancer_program_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Cancer Program Accreditation');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `chest_pain_center_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Chest Pain Center Accreditation');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `cms_service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Service Type Code');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `emergency_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Service Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'License Required Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `nicu_level` SET TAGS ('dbx_business_glossary_term' = 'Neonatal Intensive Care Unit (NICU) Level');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `nicu_level` SET TAGS ('dbx_value_regex' = 'level_i|level_ii|level_iii|level_iv|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `patient_access_phone` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Phone Number');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `patient_access_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `patient_access_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `payer_contracted_flag` SET TAGS ('dbx_business_glossary_term' = 'Payer Contracted Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ambulatory|emergency|telehealth|home_health');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|discontinued');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `stroke_center_designation` SET TAGS ('dbx_business_glossary_term' = 'Stroke Center Designation');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `stroke_center_designation` SET TAGS ('dbx_value_regex' = 'comprehensive|primary|acute_ready|thrombectomy_capable|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `trauma_level` SET TAGS ('dbx_business_glossary_term' = 'Trauma Level');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `trauma_level` SET TAGS ('dbx_value_regex' = 'level_i|level_ii|level_iii|level_iv|level_v|not_applicable');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Service Uniform Resource Locator (URL)');
ALTER TABLE `healthcare_ecm`.`facility`.`service` ALTER COLUMN `volume_annual` SET TAGS ('dbx_business_glossary_term' = 'Service Volume Annual');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` SET TAGS ('dbx_subdomain' = 'service_compliance');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Identifier');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `health_system_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `health_system_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm`.`facility`.`organization` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
