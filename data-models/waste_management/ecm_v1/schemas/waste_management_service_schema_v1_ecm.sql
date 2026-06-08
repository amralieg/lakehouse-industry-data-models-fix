-- Schema for Domain: service | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`service` COMMENT 'Defines the complete catalog of waste management service offerings — residential pickup plans, commercial dumpster services, roll-off container rentals, recycling programs, hazardous waste collection events, WTE programs, and specialty services. Owns service codes, pricing tiers, service frequency definitions, container types (CID), and SRF/WTE product definitions. Acts as the SSOT for what the business offers, referenced by billing, contract, and collection domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`offering` (
    `offering_id` BIGINT COMMENT 'Unique identifier for the waste management service offering. Primary key.',
    `code_id` BIGINT COMMENT 'Foreign key linking to service.service_code. Business justification: Offering should reference the standardized service_code registry for code assignment. The offering table currently has a service_code STRING attribute that should be replaced with a FK to the servic',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Offering references a default container type. The offering table has a STRING column default_container_type that should be replaced with a proper FK to container_type.container_type_id. This normali',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Offering references a default frequency plan. The offering table has a STRING column default_service_frequency that should be replaced with a proper FK to frequency_plan.frequency_plan_id. This norm',
    `emission_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_factor. Business justification: Service offerings require standard emission factors for carbon footprint calculations and customer sustainability reporting. Each service type (collection, processing, disposal) has characteristic emi',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.service_line. Business justification: Offering belongs to a service_line for hierarchical grouping. The offering table has a STRING column service_line that should be replaced with a proper FK to service_line.service_line_id. This estab',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Waste service offerings require specific operating permits (e.g., hazardous waste collection requires RCRA Part B permit, medical waste requires state-specific permits). Operations cannot execute offe',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Service offerings specify required asset class for delivery (e.g., hazmat service requires hazmat-certified container class, compaction service requires compactor-class assets). Drives asset eligibili',
    `certification_id` BIGINT COMMENT 'Foreign key linking to workforce.certification. Business justification: Hazmat, medical waste, and specialized services require specific certifications (HAZWOPER, CDL-A, DOT hazmat endorsement). Drives crew assignment eligibility, service delivery compliance, and regulato',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Service offerings often require vendor partnerships for delivery (e.g., TSDF disposal, specialized equipment rental). Real business process: vendor selection and capability assessment for service deli',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Offering is associated with a waste stream type. The offering table has a STRING column waste_stream_type that should be replaced with a proper FK to service_waste_stream.service_waste_stream_id. Th',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Service offerings for waste-to-energy disposal must reference the accepting WTE facility for customer quoting, waste routing decisions, service catalog configuration, and capacity planning. Domain exp',
    `amcs_service_code` STRING COMMENT 'AMCS Platform service code used for route optimization, dispatching, and container tracking integration.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether contracts for this service offering automatically renew at the end of the term unless cancelled.',
    `base_price_amount` DECIMAL(18,2) COMMENT 'Standard base price for the service offering before adjustments, surcharges, or discounts. Currency is USD for all operations.',
    `cancellation_notice_days` STRING COMMENT 'Number of days advance notice required for service cancellation. Null if no notice period applies.',
    `carbon_offset_eligible` BOOLEAN COMMENT 'Indicates whether this service qualifies for carbon offset credits or greenhouse gas (GHG) reduction reporting (e.g., WTE, RNG, landfill gas capture services).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service offering record was first created in the system.',
    `diversion_rate_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of waste diverted from landfill for this service offering (applicable to recycling, composting, and WTE services). Null for disposal-only services.',
    `dot_hazard_class` STRING COMMENT 'DOT hazard class for transportation of materials handled by this service (e.g., Class 3 Flammable Liquids, Class 6 Toxic Substances, Class 9 Miscellaneous). Null for non-hazardous services.',
    `effective_end_date` DATE COMMENT 'Date when this service offering was or will be discontinued. Null for active offerings with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this service offering became or will become available for sale and delivery.',
    `epa_waste_code` STRING COMMENT 'EPA hazardous waste code(s) applicable to this service offering if it handles RCRA-regulated materials (e.g., D001, F001, K001, P001, U001). Null for non-hazardous services.. Valid values are `^[DKPUF][0-9]{3}$`',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this service offering record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service offering record was last updated.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the service offering indicating availability for sale and delivery.. Valid values are `active|inactive|pending|discontinued|seasonal|pilot`',
    `minimum_contract_term_months` STRING COMMENT 'Minimum contract duration in months required for this service offering. Null for services with no minimum term.',
    `oracle_rate_code` STRING COMMENT 'Oracle Revenue Management system rate code identifier used for billing and invoicing.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `pricing_unit` STRING COMMENT 'Unit of measure for pricing calculation (e.g., per month, per pickup, per ton, per yard, per event, per gallon, per container, flat rate). [ENUM-REF-CANDIDATE: per_month|per_pickup|per_ton|per_yard|per_event|per_gallon|per_container|flat_rate — 8 candidates stripped; promote to reference product]',
    `regulatory_classification` STRING COMMENT 'Regulatory status of the service offering indicating compliance requirements (e.g., non-regulated, RCRA-regulated, DOT-regulated, TSDF-required, universal waste, state-regulated).. Valid values are `non_regulated|rcra_regulated|dot_regulated|tsdf_required|universal_waste|state_regulated`',
    `requires_customer_training` BOOLEAN COMMENT 'Indicates whether this service requires customer training on proper waste segregation, container usage, or safety procedures.',
    `requires_manifest` BOOLEAN COMMENT 'Indicates whether this service requires hazardous waste tracking manifest documentation per RCRA regulations.',
    `requires_site_assessment` BOOLEAN COMMENT 'Indicates whether this service requires an on-site assessment before service initiation (common for commercial, industrial, and hazardous waste services).',
    `requires_special_permit` BOOLEAN COMMENT 'Indicates whether this service requires special permits or licenses from regulatory authorities (EPA, state, or local).',
    `salesforce_product_code` STRING COMMENT 'Salesforce CRM product record identifier (18-character Salesforce ID) used in opportunity and contract management.. Valid values are `^[a-zA-Z0-9]{18}$`',
    `sap_sd_condition_type` STRING COMMENT 'SAP S/4HANA SD pricing condition type code used for rate calculation and billing (e.g., ZPR0 for base price, ZFEE for fees, ZSUR for surcharges).. Valid values are `^[A-Z0-9]{4}$`',
    `sap_sd_material_number` STRING COMMENT 'SAP S/4HANA SD module material master number for this service offering used in sales orders and billing.. Valid values are `^[0-9]{10}$`',
    `service_area_restriction` STRING COMMENT 'Geographic or operational restrictions on where this service can be delivered (e.g., specific districts, municipalities, or facility service areas). Null if no restrictions apply.',
    `service_category` STRING COMMENT 'High-level classification of the service offering by customer segment.. Valid values are `residential|commercial|industrial|municipal|specialty`',
    `service_code` STRING COMMENT 'Unique business identifier for the service offering used across operational systems. Externally-known code used in contracts, billing, and customer communications.. Valid values are `^[A-Z0-9]{4,12}$`',
    `service_description` STRING COMMENT 'Detailed description of the service offering including scope, inclusions, exclusions, and operational details.',
    `service_name` STRING COMMENT 'Human-readable name of the waste management service offering (e.g., Residential Curbside Pickup - Weekly, Commercial Front-End-Load 8-Yard, Roll-Off 30-Yard Rental).',
    `service_type` STRING COMMENT 'Operational service type indicating the collection method or service delivery mechanism (e.g., curbside, FEL, REL, ASL, roll-off, compactor, recycling, hazmat collection, WTE feedstock, on-demand). [ENUM-REF-CANDIDATE: curbside|front_end_load|rear_end_load|automated_side_load|roll_off|compactor|recycling|hazmat_collection|wte_feedstock|on_demand — 10 candidates stripped; promote to reference product]',
    `sustainability_program_flag` BOOLEAN COMMENT 'Indicates whether this service is part of a sustainability or environmental stewardship program (e.g., recycling, WTE, RNG, carbon offset programs).',
    CONSTRAINT pk_offering PRIMARY KEY(`offering_id`)
) COMMENT 'Master catalog of all waste management service offerings available for sale or subscription. Each record represents a distinct, sellable service identified by a unique service code — including residential curbside pickup plans, commercial front-end-load (FEL) dumpster services, roll-off container rentals, recycling programs, hazardous waste collection, WTE feedstock acceptance, and specialty/on-demand services. Attributes include service code, description, service category, service line classification, default container type, default frequency, regulatory classification (RCRA-regulated, non-regulated), lifecycle status, and system cross-references (SAP SD condition type, Oracle Revenue Management rate code). This is the SSOT for what the business offers — referenced by billing, contract, collection, and compliance domains.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`line` (
    `line_id` BIGINT COMMENT 'Unique identifier for the service line. Primary key for the service line entity.',
    `parent_service_line_id` BIGINT COMMENT 'Reference to a parent service line if this service line is a sub-category or specialization. Enables hierarchical service line taxonomy. Null for top-level service lines.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Service lines must comply with specific regulations (e.g., medical waste service line follows OSHA 29 CFR 1910.1030, hazmat follows DOT 49 CFR). Regulatory requirement defines operational constraints,',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Service lines map to procurement spend categories for budget allocation, cost center management, and financial reporting. Real business process: annual budget planning, spend analysis by service line,',
    `job_position_id` BIGINT COMMENT 'Foreign key linking to workforce.job_position. Business justification: Service lines define workforce requirements: residential collection needs CDL-B drivers, industrial hazmat needs certified technicians. Drives headcount planning, job requisition creation, labor cost ',
    `base_price_usd` DECIMAL(18,2) COMMENT 'Standard base price or starting price point for this service line in USD. Actual customer pricing may vary based on contract terms, volume commitments, and market conditions. Used for financial planning and margin analysis.',
    `business_unit` STRING COMMENT 'Primary business unit or customer segment this service line serves. Aligns with organizational structure and market segmentation strategy.. Valid values are `residential|commercial|industrial|municipal|institutional`',
    `carbon_offset_eligible_flag` BOOLEAN COMMENT 'Indicates whether this service line generates activities eligible for carbon offset credits or renewable energy certificates. True for LFG-to-energy, RNG production, and WTE operations.',
    `collection_frequency_standard` STRING COMMENT 'Standard or default collection frequency for this service line. Actual customer frequency may vary based on contract terms. On-demand applies to roll-off and specialty services; scheduled event applies to hazardous waste collection events.. Valid values are `daily|weekly|biweekly|monthly|on_demand|scheduled_event`',
    `container_type_category` STRING COMMENT 'Primary container or equipment types used to deliver this service line. Examples: carts (residential), dumpsters (commercial front-load), compactors (high-volume commercial), roll-off containers (construction), specialized containers (hazardous waste). Supports operational planning and asset allocation. [ENUM-REF-CANDIDATE: cart|dumpster|compactor|roll_off|specialized_container|bulk_pickup|curbside|drop_off_center — promote to reference product]',
    `contract_template_code` STRING COMMENT 'Reference to the standard contract template used for this service line in Salesforce CRM. Supports contract generation and legal compliance.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `cost_center_code` STRING COMMENT 'General Ledger (GL) cost center code for tracking operational expenses associated with this service line. Links to SAP FI/CO for financial reporting and profitability analysis.. Valid values are `^[0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service line record was first created in the system. Used for audit trail and data lineage.',
    `customer_portal_enabled_flag` BOOLEAN COMMENT 'Indicates whether customers can self-service this service line through the online customer portal (Waste Logics). True for standard services with online scheduling and account management; false for specialized services requiring direct sales engagement.',
    `display_order` STRING COMMENT 'Numeric sort order for displaying service lines in customer-facing interfaces, reports, and catalogs. Lower numbers appear first.',
    `diversion_rate_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of waste diverted from landfill for this service line. Applicable to recycling, composting, and WTE programs. Expressed as percentage (e.g., 75.00 for 75% diversion). Null for non-diversion service lines.',
    `dot_hazmat_class` STRING COMMENT 'DOT hazardous materials classification if this service line involves transportation of regulated materials. Examples: Class 3 (flammable liquids), Class 6 (toxic substances), Class 9 (miscellaneous). Empty for non-hazmat service lines.',
    `driver_cdl_requirement` STRING COMMENT 'Minimum CDL class and endorsements required for drivers operating this service line. Class A for combination vehicles, Class B for heavy straight trucks, HAZMAT endorsement for hazardous waste transport.. Valid values are `none|class_a|class_b|class_c|hazmat_endorsement`',
    `effective_end_date` DATE COMMENT 'Date when this service line was discontinued or sunset. Null for active service lines. Used for historical reporting and contract transition planning.',
    `effective_start_date` DATE COMMENT 'Date when this service line became available for sale and delivery. Used for historical analysis and service lifecycle tracking.',
    `epa_waste_code_category` STRING COMMENT 'Primary EPA waste code category or categories applicable to this service line. Examples: D-list (characteristic hazardous), F-list (non-specific source), K-list (specific source), P/U-list (discarded commercial products). Empty for non-hazardous service lines.',
    `fleet_type_requirement` STRING COMMENT 'Primary fleet vehicle types required to deliver this service line. Examples: ASL (Automated Side Loader) for residential carts, FEL (Front End Loader) for commercial dumpsters, REL (Rear End Loader) for manual collection, roll-off trucks, specialized hazmat vehicles. Supports fleet planning and maintenance scheduling. [ENUM-REF-CANDIDATE: asl|fel|rel|roll_off_truck|hazmat_vehicle|transfer_trailer|specialty_equipment — promote to reference product]',
    `ghg_reduction_contribution_flag` BOOLEAN COMMENT 'Indicates whether this service line contributes to greenhouse gas emission reduction goals. True for WTE, RNG, recycling, and CNG fleet operations.',
    `insurance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this service line requires specialized insurance coverage beyond standard general liability. True for hazardous waste, high-value assets, and environmental liability exposures.',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified this service line record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service line record was last modified. Used for audit trail and change tracking.',
    `permit_requirement_flag` BOOLEAN COMMENT 'Indicates whether this service line requires specific environmental permits, licenses, or certifications to operate. True for hazardous waste, WTE, TSDF operations; false for standard residential collection.',
    `ppe_requirement_level` STRING COMMENT 'Level of PPE required for workers delivering this service line. Standard for routine collection, enhanced for heavy industrial, HAZMAT for hazardous waste handling, specialized for WTE or TSDF operations.. Valid values are `standard|enhanced|hazmat|specialized`',
    `pricing_model` STRING COMMENT 'Primary pricing structure for this service line. Flat rate for fixed subscription fees, tiered for volume-based pricing bands, usage-based for per-pickup charges, weight-based for tonnage fees, volume-based for container size pricing, hybrid for combinations.. Valid values are `flat_rate|tiered|usage_based|weight_based|volume_based|hybrid`',
    `profit_margin_target_percent` DECIMAL(18,2) COMMENT 'Target profit margin percentage for this service line. Used for pricing strategy, contract negotiations, and performance evaluation. Expressed as percentage (e.g., 25.00 for 25%).',
    `regulatory_classification` STRING COMMENT 'Primary regulatory classification of waste streams handled by this service line. Determines applicable EPA, RCRA, DOT, and state regulations. MSW (Municipal Solid Waste) for standard waste; hazardous for RCRA-regulated materials; universal waste for batteries, electronics, lamps; special waste for C&D, industrial non-hazardous.. Valid values are `msw|hazardous|universal_waste|special_waste|recyclable|non_regulated`',
    `revenue_account_code` STRING COMMENT 'General Ledger (GL) revenue account code for posting revenue from this service line. Supports financial reporting, revenue recognition, and EBITDA analysis.. Valid values are `^[0-9]{4,10}$`',
    `revenue_category` STRING COMMENT 'Revenue recognition model for this service line. Determines billing frequency, invoicing approach, and financial reporting classification.. Valid values are `subscription|transactional|project_based|contract|event_based`',
    `route_optimization_eligible_flag` BOOLEAN COMMENT 'Indicates whether this service line is eligible for automated route optimization and dynamic dispatching. True for scheduled collection services; false for on-demand or event-based services.',
    `service_line_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the service line for external reference and system integration. Examples: RES-COL, COM-COL, ROLL-OFF, RECYCLE, HAZ-WASTE, WTE.. Valid values are `^[A-Z0-9]{2,10}$`',
    `service_line_description` STRING COMMENT 'Detailed description of the service line, including scope, target customer segments, and key service characteristics.',
    `service_line_name` STRING COMMENT 'Full business name of the service line. Examples: Residential Collection, Commercial Collection, Roll-Off Services, Recycling Programs, Hazardous Waste Management, Waste-to-Energy (WTE), Specialty Services.',
    `service_line_status` STRING COMMENT 'Current lifecycle status of the service line. Active lines are available for sale and delivery; inactive lines are discontinued; pilot lines are in testing; sunset lines are being phased out; seasonal lines operate during specific periods.. Valid values are `active|inactive|pilot|sunset|seasonal`',
    `service_line_type` STRING COMMENT 'High-level classification of the service line by operational category. Determines operational model, resource requirements, and regulatory framework.. Valid values are `collection|disposal|recycling|specialty|energy_recovery|consulting`',
    `sla_response_time_hours` STRING COMMENT 'Standard response time commitment in hours for service requests or issues related to this service line. Used for customer service performance tracking and contract compliance.',
    `sustainability_program_flag` BOOLEAN COMMENT 'Indicates whether this service line is part of the companys sustainability initiatives and contributes to environmental impact reduction goals. True for recycling, WTE, RNG, and diversion programs.',
    `training_certification_required` STRING COMMENT 'Specific training certifications or qualifications required for personnel delivering this service line. Examples: HAZWOPER 40-hour, DOT HAZMAT, OSHA confined space, forklift operator. Empty for services with no specialized training requirements.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Defines the high-level service lines or business lines under which individual offerings are grouped. Examples include Residential Collection, Commercial Collection, Roll-Off, Recycling, Hazardous Waste, WTE, and Specialty Services. Acts as the top-level classification hierarchy for the service catalog, enabling reporting and pricing segmentation by line of business. Owned by the service domain as the SSOT for service line taxonomy.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`code` (
    `code_id` BIGINT COMMENT 'Unique identifier for the service code record. Primary key.',
    `container_type_id` BIGINT COMMENT 'FK to service.container_type',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Service_code currently has service_frequency STRING attribute that should be normalized to reference the frequency_plan table. This ensures service codes use standardized frequency definitions rathe',
    `line_id` BIGINT COMMENT 'FK to service.service_line',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Service codes define asset class requirements for operational fulfillment and resource planning. Used in route optimization (match service codes to vehicle/container classes), capacity planning, and s',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Service_code currently has waste_stream STRING attribute that should be normalized to reference the service_waste_stream table. This ensures service codes use standardized waste stream classificatio',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether management approval is required before this service can be sold to customers (True) or not (False). Typically True for high-value or specialized services.',
    `base_rate` DECIMAL(18,2) COMMENT 'Standard base rate for this service in USD. Represents the starting price before surcharges, taxes, or discounts. Null if pricing is fully variable or contract-specific.',
    `cogs_account` STRING COMMENT 'General Ledger account number for Cost of Goods Sold associated with delivering this service.. Valid values are `^[0-9]{4,10}$`',
    `container_size` STRING COMMENT 'Size specification of the container (e.g., 96 gallons, 2 cubic yards, 20 cubic yards). Includes unit of measure.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this service code record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service code record was first created in the system.',
    `customer_portal_visible_flag` BOOLEAN COMMENT 'Indicates whether this service is visible and available for self-service ordering in the customer portal (True) or restricted to internal sales channels only (False).',
    `diversion_credit_eligible_flag` BOOLEAN COMMENT 'Indicates whether tonnage from this service counts toward landfill diversion rate calculations (True) or not (False). True for recycling, composting, and waste-to-energy services.',
    `dot_hazmat_class` STRING COMMENT 'DOT hazardous materials classification for transportation purposes (e.g., Class 3 Flammable Liquids, Class 9 Miscellaneous). Null for non-hazardous services.',
    `effective_end_date` DATE COMMENT 'Date on which this service code is no longer effective. Null indicates the service is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date on which this service code becomes effective and available for use in contracts and billing.',
    `epa_waste_category` STRING COMMENT 'EPA waste category classification for reporting and compliance purposes (e.g., MSW, C&D, industrial non-hazardous, hazardous).',
    `equipment_type` STRING COMMENT 'Type of collection equipment required: Automated Side Loader (ASL), Rear End Loader (REL), Front End Loader (FEL), Roll-Off truck, Compactor truck, or Vacuum truck.. Valid values are `asl|rel|fel|roll_off|compactor|vacuum`',
    `ghg_reduction_eligible_flag` BOOLEAN COMMENT 'Indicates whether this service contributes to greenhouse gas (GHG) emission reductions and is eligible for carbon credit or offset programs (True) or not (False). Applies to recycling, composting, and WTE services.',
    `gl_revenue_account` STRING COMMENT 'General Ledger account number to which revenue from this service is posted in the financial system.. Valid values are `^[0-9]{4,10}$`',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this service code record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service code record was last updated.',
    `manifest_required_flag` BOOLEAN COMMENT 'Indicates whether a hazardous waste manifest (tracking document) is required for this service (True) or not (False). Mandated for RCRA-regulated hazardous waste transportation.',
    `minimum_service_term_months` STRING COMMENT 'Minimum contract term required for this service, expressed in months. Zero indicates no minimum term (month-to-month service).',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments about this service code.',
    `oracle_rate_code` STRING COMMENT 'Oracle Revenue Management rate code mapped to this service code for billing and invoicing integration.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether a special permit or license is required to provide this service (True) or not (False). Applies to hazardous waste, medical waste, and certain industrial services.',
    `pickup_days_per_week` STRING COMMENT 'Number of scheduled pickup days per week for this service (0-7). Zero indicates on-call or non-recurring services.',
    `pricing_model` STRING COMMENT 'Pricing structure for this service: flat monthly rate, per-pickup charge, per-ton tipping fee, per-cubic-yard charge, tiered pricing, or usage-based billing.. Valid values are `flat_rate|per_pickup|per_ton|per_yard|tiered|usage_based`',
    `rate_unit` STRING COMMENT 'Unit of measure for the base rate: per month, per pickup, per ton, per cubic yard, per gallon, or per event.. Valid values are `per_month|per_pickup|per_ton|per_yard|per_gallon|per_event`',
    `rcra_waste_code` STRING COMMENT 'RCRA hazardous waste code(s) applicable to this service, if regulated under RCRA (e.g., D001 for ignitable waste, F001-F005 for spent solvents). Null for non-RCRA services.',
    `regulatory_classification` STRING COMMENT 'Regulatory status of the service under federal and state environmental law: non-regulated, RCRA-regulated, Treatment Storage and Disposal Facility (TSDF), universal waste, or hazardous materials (Hazmat).. Valid values are `non_regulated|rcra_regulated|tsdf|universal_waste|hazmat`',
    `sap_sd_condition_type` STRING COMMENT 'SAP SD condition type code mapped to this service code for pricing and billing integration in SAP S/4HANA.',
    `service_category` STRING COMMENT 'High-level categorization of the service by customer segment (residential, commercial, industrial, municipal, special event, temporary).. Valid values are `residential|commercial|industrial|municipal|special_event|temporary`',
    `service_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying a specific waste management service offering. Used across billing, collection, contract, and compliance systems as the universal service identifier.. Valid values are `^[A-Z0-9]{4,12}$`',
    `service_description` STRING COMMENT 'Detailed description of the service offering, including scope, frequency, container types, and any special handling requirements.',
    `service_name` STRING COMMENT 'Human-readable name of the service offering (e.g., Residential Weekly Curbside Collection, Commercial Front-Load Service, Roll-Off Container Rental).',
    `service_status` STRING COMMENT 'Current lifecycle status of the service code: active (available for sale), inactive (temporarily unavailable), suspended (on hold), discontinued (no longer offered), or pending approval (awaiting activation).. Valid values are `active|inactive|suspended|discontinued|pending_approval`',
    `service_type` STRING COMMENT 'Classification of the service by operational type: collection (pickup), recycling (MRF processing), disposal (landfill), hazardous waste handling, waste-to-energy (WTE), or composting.. Valid values are `collection|recycling|disposal|hazardous_waste|wte|composting`',
    `sustainability_program_flag` BOOLEAN COMMENT 'Indicates whether this service is part of a sustainability or environmental stewardship program (True) or a standard service (False). Used for ESG reporting and marketing.',
    CONSTRAINT pk_code PRIMARY KEY(`code_id`)
) COMMENT 'Standardized service code registry that assigns unique alphanumeric codes to every service offering. Serves as the universal identifier used across billing, collection, contract, and compliance systems to reference a specific service type. Includes the code value, description, effective date range, regulatory classification (e.g., RCRA-regulated, non-regulated), and mapping to SAP SD condition types and Oracle Revenue Management rate codes. This is the SSOT for service code definitions.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`container_type` (
    `container_type_id` BIGINT COMMENT 'Unique identifier for the container type. Primary key for the container type master reference.',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: Containers are procured materials with material master records, inventory management, and supplier relationships. Real business process: container procurement, inventory replenishment, and asset track',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Container types in service catalog map to asset classes for financial tracking (depreciation, capitalization thresholds, GL accounts). Links service catalog specifications to asset accounting rules, e',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Container type is designed for a specific waste stream. The container_type table has a STRING column waste_stream_type that should be replaced with a proper FK to service_waste_stream.service_waste_',
    `capacity_cubic_yards` DECIMAL(18,2) COMMENT 'Volumetric capacity of the container measured in cubic yards. Standard industry measurement for container sizing.',
    `capacity_gallons` DECIMAL(18,2) COMMENT 'Volumetric capacity of the container measured in gallons. Commonly used for residential carts and smaller bins.',
    `certification_standards` STRING COMMENT 'Industry certifications and standards this container type meets (e.g., ANSI Z245.60, ISO 14001, RCRA compliance). Comma-separated list.',
    `color_standard` STRING COMMENT 'Standard color designation for this container type. Often used for waste stream identification (e.g., blue for recycling, green for organics, black for MSW).',
    `commercial_use_flag` BOOLEAN COMMENT 'Indicates whether this container type is designed and approved for commercial service delivery.',
    `compaction_capable_flag` BOOLEAN COMMENT 'Indicates whether this container type includes or supports compaction mechanisms to increase waste density and reduce collection frequency.',
    `compaction_ratio` DECIMAL(18,2) COMMENT 'Volume reduction ratio achieved by compaction (e.g., 4:1 means waste is compressed to 25% of original volume). Null for non-compacting containers.',
    `container_category` STRING COMMENT 'High-level classification of the container type by form factor and use case.. Valid values are `dumpster|roll_off|residential_cart|recycling_bin|compactor|specialty`',
    `container_type_code` STRING COMMENT 'Unique alphanumeric code identifying the container type in operational systems. Used for Container Identification (CID) classification and cross-system reference.. Valid values are `^[A-Z0-9]{3,12}$`',
    `container_type_name` STRING COMMENT 'Business-friendly name of the container type (e.g., 10 Yard Roll-Off, 96 Gallon Residential Cart, 40 Yard Compactor).',
    `container_type_status` STRING COMMENT 'Current lifecycle status of this container type in the service catalog. Active types are available for new service orders.. Valid values are `active|inactive|discontinued|pending_approval`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this container type record was first created in the system. Used for audit trail and data lineage.',
    `dot_hazmat_class` STRING COMMENT 'DOT hazard class designation if container is certified for hazardous materials (e.g., Class 3 Flammable Liquids, Class 9 Miscellaneous). Null for non-hazmat containers.',
    `effective_end_date` DATE COMMENT 'Date this container type was discontinued or removed from the service catalog. Null for currently active types.',
    `effective_start_date` DATE COMMENT 'Date this container type became available in the service catalog. Used for historical analysis and service offering evolution tracking.',
    `estimated_useful_life_years` DECIMAL(18,2) COMMENT 'Expected service life of this container type in years under normal operating conditions. Used for depreciation and replacement planning.',
    `gps_tracking_compatible_flag` BOOLEAN COMMENT 'Indicates whether this container type supports GPS tracking devices for real-time location monitoring.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether this container type is certified for hazardous waste handling per RCRA and DOT regulations.',
    `industrial_use_flag` BOOLEAN COMMENT 'Indicates whether this container type is designed and approved for industrial facility service delivery.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this container type record was last updated. Used for audit trail and change tracking.',
    `leak_proof_flag` BOOLEAN COMMENT 'Indicates whether the container is designed with leak-proof seals and construction to prevent leachate or liquid waste escape.',
    `lid_type` STRING COMMENT 'Type of lid or cover mechanism on the container. Impacts containment, odor control, and environmental compliance.. Valid values are `hinged|attached|detached|sliding|none`',
    `lift_mechanism_compatibility` STRING COMMENT 'Type of truck lift mechanism compatible with this container. ASL = Automated Side Loader, FEL = Front End Loader, REL = Rear End Loader. Critical for route planning and fleet assignment.. Valid values are `asl|fel|rel|manual|hook_lift|cable_hoist`',
    `maintenance_interval_months` STRING COMMENT 'Recommended preventive maintenance interval in months for this container type. Used for asset maintenance scheduling.',
    `manufacturer_name` STRING COMMENT 'Name of the primary manufacturer or supplier of this container type. Used for procurement and warranty management.',
    `material_construction` STRING COMMENT 'Primary material used in container construction. Impacts durability, weight, and lifecycle cost.. Valid values are `steel|plastic|aluminum|composite|fiberglass`',
    `model_number` STRING COMMENT 'Manufacturer model or part number for this container type. Used for procurement, parts ordering, and warranty claims.',
    `notes` STRING COMMENT 'Additional operational notes, special handling instructions, or business context for this container type.',
    `purchase_eligible_flag` BOOLEAN COMMENT 'Indicates whether this container type is available for customer purchase rather than rental or service-included provision.',
    `rental_eligible_flag` BOOLEAN COMMENT 'Indicates whether this container type is available for temporary rental services (e.g., roll-off rentals for construction projects).',
    `residential_use_flag` BOOLEAN COMMENT 'Indicates whether this container type is designed and approved for residential service delivery.',
    `rfid_compatible_flag` BOOLEAN COMMENT 'Indicates whether this container type is designed to accommodate RFID tags for automated tracking and identification.',
    `service_frequency_default` STRING COMMENT 'Default collection frequency typically associated with this container type. Used for service planning and contract setup.. Valid values are `daily|weekly|biweekly|monthly|on_demand|event_based`',
    `standard_unit_cost` DECIMAL(18,2) COMMENT 'Standard acquisition or replacement cost per unit for this container type. Used for asset valuation and capital planning.',
    `tare_weight_lbs` DECIMAL(18,2) COMMENT 'Empty weight of the container in pounds. Used to calculate net waste weight for billing and tonnage reporting.',
    `un_packaging_code` STRING COMMENT 'UN packaging identification code for hazmat-certified containers (e.g., 1A1 for steel drums). Null for non-hazmat containers.. Valid values are `^[0-9]{4}[A-Z]{1,2}[0-9]{0,3}$`',
    `weather_resistant_flag` BOOLEAN COMMENT 'Indicates whether the container is designed to withstand outdoor weather conditions including rain, snow, UV exposure, and temperature extremes.',
    `weight_capacity_lbs` DECIMAL(18,2) COMMENT 'Maximum safe working load capacity of the container in pounds. Critical for DOT compliance and fleet safety.',
    `wheel_configuration` STRING COMMENT 'Wheel configuration for container mobility. Relevant for residential carts and smaller commercial bins.. Valid values are `two_wheel|four_wheel|stationary|none`',
    CONSTRAINT pk_container_type PRIMARY KEY(`container_type_id`)
) COMMENT 'Master reference for all container types (CID-classified) used in service delivery. Defines dumpsters, roll-off containers, residential carts, recycling bins, compactors, and specialty containers by size (cubic yards), material, lift compatibility (ASL, FEL, REL), weight capacity, and intended waste stream (MSW, C&D, recyclables, hazmat). This is the SSOT for container type definitions referenced by collection, asset, and contract domains. Distinct from individual container asset instances tracked in the asset domain.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`frequency_plan` (
    `frequency_plan_id` BIGINT COMMENT 'Unique identifier for the service frequency plan configuration. Primary key.',
    `approval_date` DATE COMMENT 'The date when this frequency plan was approved for operational use by authorized management. Format: yyyy-MM-dd.',
    `approved_by` STRING COMMENT 'The username or identifier of the manager or administrator who approved this frequency plan for operational use. Required for plans in active status.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether contracts using this frequency plan automatically renew at the end of the commitment period. True if auto-renewal is enabled, False if explicit renewal is required.',
    `billing_frequency` STRING COMMENT 'Defines how often customers are billed for this frequency plan: per individual pickup, weekly, monthly, quarterly, or annually. Used by billing systems to generate invoices.. Valid values are `per_pickup|weekly|monthly|quarterly|annually`',
    `cancellation_notice_days` STRING COMMENT 'The number of days advance notice required for customers to cancel or modify service under this frequency plan. Used for contract enforcement and scheduling adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this frequency plan record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_end_date` DATE COMMENT 'The date when this frequency plan is no longer available for new service contracts. Existing contracts may continue beyond this date. Null indicates no planned end date. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'The date when this frequency plan becomes available for use in new service contracts and billing configurations. Format: yyyy-MM-dd.',
    `extra_pickup_allowed_flag` BOOLEAN COMMENT 'Indicates whether customers can request additional pickups beyond the standard frequency under this plan. True if extra pickups are permitted (typically with additional charges), False otherwise.',
    `frequency_plan_status` STRING COMMENT 'Current lifecycle status of the frequency plan: active (available for new contracts), inactive (not available but existing contracts continue), deprecated (being phased out), pending approval (awaiting management approval), or suspended (temporarily unavailable).. Valid values are `active|inactive|deprecated|pending_approval|suspended`',
    `frequency_type` STRING COMMENT 'The base frequency pattern for service pickups: daily, weekly, bi-weekly (every two weeks), monthly, on-call (customer-initiated), or event-based (scheduled events).. Valid values are `daily|weekly|bi_weekly|monthly|on_call|event_based`',
    `friday_service_flag` BOOLEAN COMMENT 'Indicates whether this frequency plan includes service pickups on Fridays. True if Friday is an eligible service day, False otherwise.',
    `holiday_adjustment_rule` STRING COMMENT 'Defines how service is adjusted when a scheduled pickup falls on a recognized holiday: no service provided, shifted to next business day, shifted to prior business day, service on same day regardless, or customer chooses adjustment method.. Valid values are `no_service|next_business_day|prior_business_day|same_day|customer_choice`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this frequency plan record was last updated. Used for change tracking and audit purposes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `maximum_commitment_period` STRING COMMENT 'The maximum number of months a customer can commit to this frequency plan in a single contract term. Null indicates no maximum limit.',
    `maximum_skips_per_year` STRING COMMENT 'The maximum number of scheduled pickups a customer can skip in a 12-month period under this frequency plan. Null indicates no limit or skip_allowed_flag is False.',
    `minimum_commitment_period` STRING COMMENT 'The minimum number of months a customer must commit to this frequency plan when entering a service contract. Used for contract term enforcement and early termination calculations.',
    `monday_service_flag` BOOLEAN COMMENT 'Indicates whether this frequency plan includes service pickups on Mondays. True if Monday is an eligible service day, False otherwise.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational considerations related to this frequency plan. Used for internal documentation and knowledge transfer.',
    `period_unit` STRING COMMENT 'The time unit that defines the frequency period: day, week, month, quarter, or year. Used in conjunction with pickups_per_period to calculate service frequency.. Valid values are `day|week|month|quarter|year`',
    `pickups_per_period` STRING COMMENT 'The number of pickups scheduled within the defined frequency period. For weekly service this is typically 1, for bi-weekly this is 1 per two-week period, for daily this is 5-7 depending on operating days.',
    `plan_code` STRING COMMENT 'Business identifier code for the frequency plan used in billing, contracts, and operational systems. Externally visible unique code.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plan_description` STRING COMMENT 'Detailed description of the frequency plan including service scope, pickup schedule details, and any special conditions or restrictions.',
    `plan_name` STRING COMMENT 'Human-readable name of the frequency plan (e.g., Weekly Residential Pickup, Bi-Weekly Commercial Service, Daily MSW Collection).',
    `proration_allowed_flag` BOOLEAN COMMENT 'Indicates whether billing can be prorated for partial periods when service starts or ends mid-cycle. True if proration is allowed, False if full-period billing applies.',
    `saturday_service_flag` BOOLEAN COMMENT 'Indicates whether this frequency plan includes service pickups on Saturdays. True if Saturday is an eligible service day, False otherwise.',
    `service_type` STRING COMMENT 'Classification of the service type this frequency plan applies to: residential curbside, commercial dumpster, industrial hauling, municipal contracts, roll-off container rental, or recycling programs.. Valid values are `residential|commercial|industrial|municipal|roll_off|recycling`',
    `service_window_end_time` TIMESTAMP COMMENT 'The latest time of day (HH:MM format, 24-hour) that service pickups must be completed for this frequency plan. Used for route scheduling and SLA compliance monitoring.',
    `service_window_start_time` TIMESTAMP COMMENT 'The earliest time of day (HH:MM format, 24-hour) that service pickups can begin for this frequency plan. Used for route scheduling and customer communication.',
    `skip_allowed_flag` BOOLEAN COMMENT 'Indicates whether customers can request to skip scheduled pickups under this frequency plan (e.g., for vacation holds). True if skips are permitted, False otherwise.',
    `sunday_service_flag` BOOLEAN COMMENT 'Indicates whether this frequency plan includes service pickups on Sundays. True if Sunday is an eligible service day, False otherwise.',
    `thursday_service_flag` BOOLEAN COMMENT 'Indicates whether this frequency plan includes service pickups on Thursdays. True if Thursday is an eligible service day, False otherwise.',
    `tuesday_service_flag` BOOLEAN COMMENT 'Indicates whether this frequency plan includes service pickups on Tuesdays. True if Tuesday is an eligible service day, False otherwise.',
    `version_number` STRING COMMENT 'Version number of this frequency plan configuration. Incremented with each modification to support change history and rollback capabilities.',
    `wednesday_service_flag` BOOLEAN COMMENT 'Indicates whether this frequency plan includes service pickups on Wednesdays. True if Wednesday is an eligible service day, False otherwise.',
    CONSTRAINT pk_frequency_plan PRIMARY KEY(`frequency_plan_id`)
) COMMENT 'Defines all service frequency configurations available for waste collection services. Captures pickup frequency (daily, weekly, bi-weekly, monthly, on-call, event-based), number of pickups per period, applicable days of week, holiday adjustment rules, and minimum service commitment periods. Used by collection routing, billing rate calculation, and contract terms. This is the SSOT for service frequency definitions referenced across billing and collection domains.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`service_rate_schedule` (
    `service_rate_schedule_id` BIGINT COMMENT 'Unique identifier for the service rate schedule record. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Rate schedule applies to a specific service area. The service_rate_schedule table has a STRING column service_area_code that should be replaced with a proper FK to service_area.service_area_id. This',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.container. Business justification: Rate schedules for rental/lease pricing models track individual container assets (not just types) to calculate usage-based charges, asset-specific surcharges, and depreciation recovery. Critical for e',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to recycling.commodity. Business justification: Recycling service rates often include revenue-share or commodity-indexed pricing tied to specific recyclable commodities (OCC, PET, aluminum). Required for dynamic pricing models and customer contract',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Rate schedule applies to a specific container size/type. The service_rate_schedule table has a STRING column container_size that should be replaced with a proper FK to container_type.container_type_',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Service rate schedules frequently vary by disposal site due to differential tipping fees, transportation costs, and host community agreements. This link is essential for accurate service pricing, marg',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Rate schedule is associated with a frequency plan. The service_rate_schedule table has a STRING column service_frequency that should be replaced with a proper FK to frequency_plan.frequency_plan_id.',
    `offering_id` BIGINT COMMENT 'Reference to the specific waste management service offering (residential pickup, commercial dumpster, roll-off rental, recycling program, hazardous waste collection, WTE program) for which this rate schedule applies.',
    `superseded_by_schedule_service_rate_schedule_id` BIGINT COMMENT 'Reference to the newer rate schedule that replaces this one. Null if this is the current active version.',
    `approval_date` DATE COMMENT 'Date when this rate schedule was approved by pricing authority or regulatory body. Required before status can be set to active.',
    `approved_by` STRING COMMENT 'Name or identifier of the pricing manager or regulatory authority who approved this rate schedule.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'Core service charge amount before any surcharges, fees, or taxes. Represents the fundamental pricing for the service offering.',
    `base_rate_unit` STRING COMMENT 'Unit of measure for the base rate amount. Defines how the service is priced (monthly subscription, per-pickup, tonnage-based, volume-based). [ENUM-REF-CANDIDATE: per_month|per_pickup|per_ton|per_yard|per_gallon|per_event|per_container — 7 candidates stripped; promote to reference product]',
    `contamination_surcharge` DECIMAL(18,2) COMMENT 'Surcharge applied when recycling or waste streams contain contamination above acceptable thresholds. Covers additional sorting and disposal costs.',
    `contamination_threshold_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable contamination percentage in recycling or waste stream before contamination surcharge applies. Typically 5-10% for recycling programs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate schedule. Typically USD for US operations.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Customer segment classification for which this rate schedule applies. Determines eligibility and pricing tier structure.. Valid values are `residential|commercial|industrial|municipal|institutional|special_event`',
    `effective_end_date` DATE COMMENT 'Date when this rate schedule expires and is no longer applicable for new contracts. Nullable for open-ended schedules.',
    `effective_start_date` DATE COMMENT 'Date when this rate schedule becomes active and applicable for billing. Supports time-bound rate versioning for annual adjustments.',
    `environmental_fee_method` STRING COMMENT 'Method used to calculate environmental recovery fee component. Fixed amount or percentage of base rate.. Valid values are `fixed_amount|percentage|none`',
    `environmental_recovery_fee` DECIMAL(18,2) COMMENT 'Fee charged to recover costs of environmental compliance, monitoring, and sustainability programs. May be fixed or calculated as percentage of base rate.',
    `fuel_index_adjustment_rate` DECIMAL(18,2) COMMENT 'Rate multiplier applied to the difference between current DOE diesel price and threshold to calculate surcharge. Used when fuel_surcharge_method is index_linked.',
    `fuel_index_threshold` DECIMAL(18,2) COMMENT 'DOE diesel price per gallon threshold above which index-linked fuel surcharge applies. Used when fuel_surcharge_method is index_linked.',
    `fuel_surcharge_base_amount` DECIMAL(18,2) COMMENT 'Fixed fuel surcharge amount when method is fixed_amount, or base amount for percentage calculation. Null when method is index_linked or none.',
    `fuel_surcharge_method` STRING COMMENT 'Method used to calculate fuel surcharge component. Index-linked typically references DOE diesel price index with threshold and adjustment formula.. Valid values are `fixed_amount|percentage|index_linked|none`',
    `fuel_surcharge_percentage` DECIMAL(18,2) COMMENT 'Percentage of base rate applied as fuel surcharge when method is percentage. Null for other methods.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was last updated. Used for audit trail and change tracking.',
    `minimum_service_charge` DECIMAL(18,2) COMMENT 'Minimum monthly or per-service charge regardless of usage or volume. Ensures cost recovery for low-volume customers.',
    `notes` STRING COMMENT 'Free-text notes documenting special conditions, exceptions, promotional terms, or other relevant information about this rate schedule.',
    `overweight_fee` DECIMAL(18,2) COMMENT 'Fee charged per unit (ton or pound) when container or load weight exceeds the standard weight limit included in base rate.',
    `rate_schedule_code` STRING COMMENT 'Unique business identifier for the rate schedule used in billing systems and customer contracts. Typically follows format SERVICE-SEGMENT-GEO-VERSION.. Valid values are `^[A-Z0-9]{6,12}$`',
    `rate_schedule_name` STRING COMMENT 'Human-readable descriptive name of the rate schedule for business user identification and reporting purposes.',
    `rate_schedule_status` STRING COMMENT 'Current lifecycle status of the rate schedule. Active schedules are available for new contracts; expired or superseded schedules are retained for historical billing.. Valid values are `draft|active|suspended|expired|superseded`',
    `rate_version` STRING COMMENT 'Version number for this rate schedule. Increments with each revision to support time-bound rate versioning for annual adjustments.',
    `regulatory_compliance_fee` DECIMAL(18,2) COMMENT 'Fee charged to cover costs of regulatory compliance including RCRA, CERCLA, state and local permit requirements, and reporting obligations.',
    `sales_tax_rate` DECIMAL(18,2) COMMENT 'Applicable sales tax rate as decimal for this service area and customer segment. Null if tax_inclusive_flag is true or service is tax-exempt.',
    `standard_weight_limit` DECIMAL(18,2) COMMENT 'Maximum weight in tons or pounds included in the base rate before overweight fees apply. Varies by service type and container size.',
    `tax_inclusive_flag` BOOLEAN COMMENT 'Indicates whether the base rate and fees include applicable taxes (true) or taxes are calculated separately (false).',
    `tipping_fee_method` STRING COMMENT 'Method for calculating and applying tipping fee charges. Fixed per ton, actual cost pass-through, included in base rate, or not applicable.. Valid values are `fixed_per_ton|actual_cost|included_in_base|none`',
    `tipping_fee_passthrough` DECIMAL(18,2) COMMENT 'Landfill or disposal facility tipping fee per ton passed through to customer. Reflects actual disposal costs at destination facility.',
    `weight_unit` STRING COMMENT 'Unit of measure for weight-based pricing components including standard weight limit and overweight fees.. Valid values are `tons|pounds|kilograms`',
    CONSTRAINT pk_service_rate_schedule PRIMARY KEY(`service_rate_schedule_id`)
) COMMENT 'Master rate schedule defining the complete pricing structure for each service offering by customer segment, geography, and effective period. Captures base rates, fuel surcharges (indexed to DOE diesel price), environmental recovery fees, regulatory compliance fees, contamination surcharges, overweight fees, tipping fee pass-throughs, and applicable taxes. Each surcharge/fee component includes calculation method (flat fee, percentage, index-linked) and effective date range. Supports time-bound rate versioning for annual adjustments. This is the SSOT for service pricing referenced by billing, contract, and sales domains.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`bundle` (
    `bundle_id` BIGINT COMMENT 'Unique identifier for the service bundle. Primary key.',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.container. Business justification: Service bundles (e.g., Small Business Starter Package) include specific pre-assigned container assets as part of the offering. Links catalog product to physical asset for order fulfillment, deployme',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Service bundles currently have container_type_included STRING attribute and default_container_id FK to asset.container. The bundle should reference container_type (the master reference for contain',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Service bundles currently have a service_frequency STRING attribute that should be normalized to reference the frequency_plan table. This ensures bundles use standardized frequency definitions rathe',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.service_line. Business justification: Service bundles are organizational constructs that belong to a service line for categorization and management. Since bundles group offerings and offerings belong to service_lines, bundles should also ',
    `approval_status` STRING COMMENT 'Approval status of the service bundle in the product governance workflow.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this service bundle for catalog inclusion.',
    `approved_date` DATE COMMENT 'Date when the service bundle was approved for inclusion in the active catalog.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether contracts using this bundle automatically renew at the end of the term (True) or require explicit renewal (False).',
    `base_price` DECIMAL(18,2) COMMENT 'Base price of the service bundle before any discounts, surcharges, or taxes. Expressed in USD.',
    `bundle_category` STRING COMMENT 'Primary service category that the bundle addresses (collection-only, recycling-focused, comprehensive waste management, etc.).. Valid values are `collection|recycling|disposal|hazmat|wte|comprehensive`',
    `bundle_code` STRING COMMENT 'Externally-known unique code for the service bundle used in contracts, billing, and customer communications.. Valid values are `^[A-Z0-9]{6,12}$`',
    `bundle_description` STRING COMMENT 'Detailed description of the service bundle, including what services are included and the value proposition for customers.',
    `bundle_name` STRING COMMENT 'Human-readable name of the service bundle (e.g., Residential Complete Care Package, Commercial Waste & Recycling Bundle).',
    `bundle_type` STRING COMMENT 'Classification of the service bundle by customer segment and offering type.. Valid values are `residential|commercial|industrial|municipal|specialty|promotional`',
    `cancellation_notice_days` STRING COMMENT 'Number of days advance notice required to cancel a contract using this bundle. Null if no notice period applies.',
    `container_quantity` STRING COMMENT 'Number of containers included in the bundle. Null if container quantity is variable or negotiated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service bundle record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed dollar discount applied to the bundle. Null if percentage discount or no discount applies. Expressed in USD.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied when purchasing the bundle versus buying component services individually. Null if no discount applies.',
    `diversion_rate_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of waste diverted from landfill through recycling and recovery services included in this bundle. Null if not applicable.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee charged if the customer terminates the bundle contract before the minimum term expires. Null if no early termination fee applies. Expressed in USD.',
    `effective_end_date` DATE COMMENT 'Date when this service bundle is discontinued and no longer available for new sales. Null if currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this service bundle becomes active and available for sale in the catalog.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which customers are eligible to purchase this bundle (e.g., Residential customers in service zones A-D, Commercial accounts with minimum 2-yard container).',
    `geographic_availability` STRING COMMENT 'Geographic regions, service zones, or districts where this bundle is available for sale and fulfillment.',
    `ghg_reduction_co2e_tons` DECIMAL(18,2) COMMENT 'Estimated annual greenhouse gas reduction in CO2e tons achieved by customers using this bundle (e.g., through recycling diversion, waste-to-energy conversion). Null if not applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service bundle record was last updated.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the service bundle indicating availability for sale and fulfillment.. Valid values are `draft|active|suspended|discontinued|archived`',
    `marketing_campaign_code` STRING COMMENT 'Code identifying the marketing campaign associated with this bundle. Null if not part of a specific campaign.',
    `minimum_contract_term_months` STRING COMMENT 'Minimum contract duration in months required to purchase this bundle. Null if no minimum term applies.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this service bundle record.',
    `notes` STRING COMMENT 'Additional notes or comments about the service bundle for internal reference.',
    `pricing_model` STRING COMMENT 'Pricing logic applied to the bundle: flat rate (fixed price regardless of components), component sum (sum of individual service prices), discounted sum (sum with bundle discount applied), tiered (varies by volume/frequency), or custom (negotiated pricing).. Valid values are `flat_rate|component_sum|discounted_sum|tiered|custom`',
    `product_manager_name` STRING COMMENT 'Name of the product manager responsible for this service bundle.',
    `promotion_end_date` DATE COMMENT 'Date when the promotional bundle is no longer available for new sales. Null if not a promotional bundle or if open-ended.',
    `promotion_start_date` DATE COMMENT 'Date when the promotional bundle becomes available for sale. Null if not a promotional bundle.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this bundle is a limited-time promotional offering (True) or a standard catalog offering (False).',
    `regulatory_compliance_notes` STRING COMMENT 'Notes on regulatory compliance requirements or certifications associated with this bundle (e.g., RCRA compliance for hazardous waste components, EPA reporting requirements).',
    `sales_channel` STRING COMMENT 'Primary sales channel through which this bundle is marketed and sold.. Valid values are `direct|partner|online|call_center|field_sales`',
    `sla_response_time_hours` STRING COMMENT 'Maximum response time in hours guaranteed under the SLA for service requests related to this bundle. Null if no SLA applies.',
    `sustainability_certified_flag` BOOLEAN COMMENT 'Indicates whether this bundle includes sustainability-certified services (e.g., carbon-neutral collection, renewable natural gas fleet, zero-waste-to-landfill programs).',
    `version_number` STRING COMMENT 'Version number of the service bundle definition, incremented when bundle composition or pricing changes.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_bundle PRIMARY KEY(`bundle_id`)
) COMMENT 'Defines packaged combinations of individual service offerings sold together as a bundle (e.g., residential collection + recycling cart + yard waste pickup). Captures bundle name, component offerings with quantity and pricing contribution (included, add-on, discounted), bundle pricing logic (flat rate vs. component sum discount), eligibility rules, and promotional period. Each bundle has its own lifecycle independent of component offerings. Referenced by contract and billing domains for bundle-level pricing and fulfillment.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`waste_stream` (
    `waste_stream_id` BIGINT COMMENT 'Unique identifier for the waste stream classification record. Primary key.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Waste streams must be validated against WTE facility acceptance criteria, permits, and technology capabilities. Critical for automated waste acceptance screening, regulatory compliance, feedstock plan',
    `emission_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_factor. Business justification: Waste streams have material-specific emission factors for decomposition, processing, and transport. Critical for Scope 3 emissions calculations, waste-specific carbon footprinting, and diversion credi',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each waste stream has specific regulatory requirements defining handling, transport, disposal (e.g., EPA waste code K-listed requires RCRA Subtitle C compliance, asbestos requires NESHAP). Regulatory ',
    `accepted_container_types` STRING COMMENT 'Comma-separated list of container types (Container Identification - CID codes) that are approved for this waste stream (e.g., 96-GAL-CART, 2-YD-DUMPSTER, 20-YD-ROLLOFF, COMPACTOR). References container master data.',
    `commodity_value_flag` BOOLEAN COMMENT 'Indicates whether this waste stream has commodity market value (True) or represents a disposal cost (False). Applies to recyclable materials with resale value (paper, metal, plastic).',
    `compaction_ratio_avg` DECIMAL(18,2) COMMENT 'Average compaction ratio (volume reduction factor) for this waste stream when compacted in collection vehicles or at disposal facilities. Used for capacity planning and route optimization.',
    `compostable_flag` BOOLEAN COMMENT 'Indicates whether this waste stream is suitable for composting operations (True) or not (False). Applies to organic waste, food waste, and yard waste streams.',
    `contamination_threshold_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable contamination percentage for this waste stream before it is rejected or reclassified (e.g., 10% contamination threshold for single-stream recycling). Used for quality control at MRF facilities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste stream classification record was first created in the system. Used for audit trail and data lineage.',
    `density_lbs_per_cubic_yard` DECIMAL(18,2) COMMENT 'Average density of this waste stream measured in pounds per cubic yard. Used for weight estimation, capacity planning, and tipping fee calculations.',
    `disposal_pathway` STRING COMMENT 'Primary disposal or processing pathway for this waste stream: Landfill, Materials Recovery Facility (MRF), Waste-to-Energy (WTE), Treatment Storage and Disposal Facility (TSDF), Composting, or Recycling.. Valid values are `Landfill|MRF|WTE|TSDF|Composting|Recycling`',
    `diversion_credit_percentage` DECIMAL(18,2) COMMENT 'Percentage of this waste stream that counts toward landfill diversion rate calculations (0-100%). Reflects the portion that is recycled, composted, or converted to energy rather than landfilled.',
    `diversion_eligible_flag` BOOLEAN COMMENT 'Indicates whether this waste stream is eligible for diversion from landfill (True) or must be landfilled (False). Used to calculate diversion rates and sustainability metrics.',
    `effective_end_date` DATE COMMENT 'Date when this waste stream classification was discontinued or superseded. Null for currently active waste streams. Used for historical analysis and regulatory reporting.',
    `effective_start_date` DATE COMMENT 'Date when this waste stream classification became effective and available for service offerings. Used for historical tracking and regulatory compliance.',
    `epa_waste_code` STRING COMMENT 'EPA hazardous waste code if applicable (e.g., D001 for ignitable waste, F001-F005 for spent solvents, P and U codes for acutely hazardous waste). Null for non-hazardous streams.. Valid values are `^[DFKPU][0-9]{3}$|^$`',
    `ghg_emission_factor_co2e_per_ton` DECIMAL(18,2) COMMENT 'Greenhouse Gas (GHG) emission factor for this waste stream expressed as kilograms of Carbon Dioxide Equivalent (CO2e) per ton of waste. Used for sustainability reporting and carbon footprint calculations.',
    `hazard_class` STRING COMMENT 'Department of Transportation (DOT) hazard class for transportation purposes if the waste stream is hazardous (e.g., Class 3 Flammable Liquids, Class 6 Toxic Substances, Class 9 Miscellaneous). Null for non-hazardous streams.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste stream classification record was last updated. Used for audit trail and change tracking.',
    `manifest_required_flag` BOOLEAN COMMENT 'Indicates whether a hazardous waste manifest (tracking document) is required for this waste stream under RCRA regulations (True) or not (False). Applies to hazardous and universal waste streams.',
    `ppe_requirements` STRING COMMENT 'Description of Personal Protective Equipment (PPE) required for handling this waste stream (e.g., gloves, respirators, chemical suits, eye protection). Null for streams with no special PPE requirements.',
    `rcra_subtitle` STRING COMMENT 'RCRA subtitle classification: C for hazardous waste, D for non-hazardous solid waste, N/A for streams not regulated under RCRA.. Valid values are `C|D|N/A`',
    `recyclable_flag` BOOLEAN COMMENT 'Indicates whether this waste stream contains recyclable materials (True) or is non-recyclable (False). Drives routing to MRF facilities and recycling programs.',
    `regulatory_classification` STRING COMMENT 'Federal and state regulatory classification code (e.g., RCRA Subtitle C for hazardous waste, RCRA Subtitle D for non-hazardous solid waste, state-specific codes). Determines handling, transport, and disposal requirements.',
    `regulatory_notes` STRING COMMENT 'Free-text field capturing additional regulatory requirements, restrictions, or compliance notes specific to this waste stream (e.g., state-specific handling requirements, permit conditions, reporting obligations).',
    `seasonal_variation_flag` BOOLEAN COMMENT 'Indicates whether this waste stream exhibits significant seasonal volume variations (True) or has consistent year-round volumes (False). Examples include yard waste (seasonal) and MSW (consistent).',
    `special_handling_required_flag` BOOLEAN COMMENT 'Indicates whether this waste stream requires special handling procedures, equipment, or certifications (True) or can be handled through standard collection processes (False).',
    `subcategory` STRING COMMENT 'Detailed subcategory within the waste stream (e.g., Paper, Plastic, Metal, Glass, Food Waste, Yard Waste, Concrete, Asphalt, Wood). Provides granular classification for material recovery and processing.',
    `tclp_testing_required_flag` BOOLEAN COMMENT 'Indicates whether Toxicity Characteristic Leaching Procedure (TCLP) testing is required to determine hazardous characteristics (True) or not (False). Used for waste characterization and regulatory compliance.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials transport (e.g., UN1203 for gasoline, UN1090 for acetone). Required for hazardous waste manifests and transportation. Null for non-hazardous streams.. Valid values are `^UN[0-9]{4}$|^$`',
    `waste_stream_category` STRING COMMENT 'High-level classification of the waste stream: Municipal Solid Waste (MSW), Construction and Demolition (C&D), Recyclable, Organic, Hazardous, Universal Waste, or Electronic Waste (E-Waste). [ENUM-REF-CANDIDATE: MSW|C&D|Recyclable|Organic|Hazardous|Universal|E-Waste — 7 candidates stripped; promote to reference product]',
    `waste_stream_code` STRING COMMENT 'Business identifier code for the waste stream type (e.g., MSW-001, CD-002, RCY-PLT-01). Used across operational systems for waste classification.. Valid values are `^[A-Z0-9]{3,12}$`',
    `waste_stream_name` STRING COMMENT 'Full descriptive name of the waste stream (e.g., Municipal Solid Waste, Construction and Demolition Debris, Mixed Recyclables).',
    `waste_stream_status` STRING COMMENT 'Current operational status of this waste stream classification: Active (currently accepted), Inactive (temporarily not accepted), Restricted (accepted with limitations), or Phased Out (no longer accepted).. Valid values are `Active|Inactive|Restricted|Phased Out`',
    `wte_feedstock_flag` BOOLEAN COMMENT 'Indicates whether this waste stream is acceptable as feedstock for Waste-to-Energy (WTE) or Solid Recovered Fuel (SRF) conversion processes (True) or not (False).',
    CONSTRAINT pk_waste_stream PRIMARY KEY(`waste_stream_id`)
) COMMENT 'Reference catalog of waste stream classifications managed by the business. Defines MSW, C&D, recyclables (paper, plastic, metal, glass), organic/food waste, yard waste, hazardous waste (RCRA Subtitle C), universal waste, e-waste, and SRF/WTE feedstock streams. Each record includes the waste stream code, regulatory classification (EPA/RCRA/state), accepted container types, disposal pathway (landfill, MRF, WTE, TSDF), and diversion eligibility. This is the SSOT for waste stream taxonomy referenced across collection, recycling, landfill, and hazmat domains.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`srf_product` (
    `srf_product_id` BIGINT COMMENT 'Unique identifier for the SRF product specification. Primary key.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: SRF products are sold to external buyers (cement kilns, power plants) who are vendors in the system. Real business process: commodity sales, buyer relationship management, and revenue tracking. Critic',
    `facility_id` BIGINT COMMENT 'Identifier of the primary Materials Recovery Facility (MRF) or processing facility where this SRF product is manufactured.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: SRF production requires air quality permits (emissions from processing), solid waste processing permits, and potentially RCRA permits depending on feedstock. Product cannot be manufactured or sold wit',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: SRF products must meet regulatory quality standards (EN 15359 in EU, state-specific standards in US). Regulatory requirement defines calorific value limits, contaminant thresholds, testing protocols. ',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: SRF product is produced from a specific waste stream. The srf_product table has a STRING column source_waste_stream that should be replaced with a proper FK to service_waste_stream.service_waste_str',
    `srf_production_line_id` BIGINT COMMENT 'Foreign key linking to energy.srf_production_line. Business justification: SRF products are manufactured outputs of specific production lines. Essential for product quality tracking, production planning, batch traceability, inventory management, and customer fulfillment. Dom',
    `ash_content_max_percent` DECIMAL(18,2) COMMENT 'Maximum allowable ash content for this SRF product grade. Quality control threshold.',
    `ash_content_percent` DECIMAL(18,2) COMMENT 'Target ash content of the SRF product as a percentage of dry mass. Lower ash content reduces disposal costs and improves fuel quality.',
    `bulk_density_kg_m3` DECIMAL(18,2) COMMENT 'Target bulk density of the SRF product measured in kilograms per cubic meter. Important for transportation logistics and storage planning.',
    `cadmium_content_max_mg_kg` DECIMAL(18,2) COMMENT 'Maximum allowable cadmium content for this SRF product grade. Regulatory heavy metal limit.',
    `cadmium_content_mg_kg` DECIMAL(18,2) COMMENT 'Target cadmium content of the SRF product measured in milligrams per kilogram of dry mass. Heavy metal specification for environmental compliance.',
    `calorific_value_max_mj_kg` DECIMAL(18,2) COMMENT 'Maximum net calorific value specification for this SRF product grade. Upper bound for quality classification.',
    `calorific_value_min_mj_kg` DECIMAL(18,2) COMMENT 'Minimum acceptable net calorific value for this SRF product grade. Quality control threshold for product acceptance.',
    `calorific_value_mj_kg` DECIMAL(18,2) COMMENT 'Net calorific value (lower heating value) of the SRF product measured in megajoules per kilogram. Critical specification for energy content and pricing.',
    `certification_body` STRING COMMENT 'Name of the third-party certification or testing organization that has certified this SRF product specification (if applicable).',
    `certification_date` DATE COMMENT 'Date when this SRF product specification was certified by the certification body or approved for production.',
    `certification_expiry_date` DATE COMMENT 'Date when the current certification for this SRF product specification expires and requires renewal.',
    `chlorine_content_max_percent` DECIMAL(18,2) COMMENT 'Maximum allowable chlorine content for this SRF product grade. Regulatory and customer specification limit.',
    `chlorine_content_percent` DECIMAL(18,2) COMMENT 'Target chlorine content of the SRF product as a percentage of dry mass. Critical for emissions control and boiler corrosion prevention.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SRF product specification record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this SRF product specification was discontinued or superseded by a new version. Null for currently active products.',
    `effective_start_date` DATE COMMENT 'Date when this SRF product specification became active and available for production and sale.',
    `en_15359_class` STRING COMMENT 'Three-digit EN 15359 classification code representing net calorific value class, chlorine content class, and mercury content class (e.g., 1-1-1 for highest quality).',
    `lead_content_max_mg_kg` DECIMAL(18,2) COMMENT 'Maximum allowable lead content for this SRF product grade. Regulatory heavy metal limit.',
    `lead_content_mg_kg` DECIMAL(18,2) COMMENT 'Target lead content of the SRF product measured in milligrams per kilogram of dry mass. Heavy metal specification for environmental compliance.',
    `mercury_content_max_mg_kg` DECIMAL(18,2) COMMENT 'Maximum allowable mercury content for this SRF product grade. EPA and Clean Air Act compliance threshold.',
    `mercury_content_mg_kg` DECIMAL(18,2) COMMENT 'Target mercury content of the SRF product measured in milligrams per kilogram of dry mass. Critical heavy metal specification for environmental compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SRF product specification record was last modified.',
    `moisture_content_max_percent` DECIMAL(18,2) COMMENT 'Maximum allowable moisture content for this SRF product grade. Quality control threshold.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Target moisture content of the SRF product as a percentage of total mass. Lower moisture improves combustion efficiency.',
    `particle_size_max_mm` DECIMAL(18,2) COMMENT 'Maximum allowable particle size for this SRF product grade. Quality control specification for customer equipment compatibility.',
    `particle_size_mm` DECIMAL(18,2) COMMENT 'Target particle size of the SRF product measured in millimeters. Affects combustion efficiency and handling characteristics.',
    `product_code` STRING COMMENT 'Externally-known unique business identifier for the SRF product grade. Used in sales orders, contracts, and quality certificates.. Valid values are `^SRF-[A-Z0-9]{6,12}$`',
    `product_description` STRING COMMENT 'Detailed description of the SRF product including intended use, key characteristics, and differentiating features.',
    `product_grade` STRING COMMENT 'Classification tier of the SRF product based on quality specifications and target market segment.. Valid values are `premium|standard|industrial|utility|custom`',
    `product_name` STRING COMMENT 'Human-readable name of the SRF product grade (e.g., Premium Grade SRF, Industrial Grade SRF, Cement Kiln Fuel).',
    `product_status` STRING COMMENT 'Current lifecycle status of the SRF product in the catalog. Active products are available for sale; development products are in testing phase.. Valid values are `active|inactive|development|discontinued|suspended|certified`',
    `quality_standard` STRING COMMENT 'Primary quality standard or specification framework that this SRF product conforms to (e.g., EN 15359 European standard, ASTM E2617 US standard).. Valid values are `EN_15359|ASTM_E2617|ISO_21640|custom`',
    `safety_data_sheet_url` STRING COMMENT 'URL or document reference to the Safety Data Sheet (SDS) for this SRF product, required for hazardous material handling.',
    `sulfur_content_max_percent` DECIMAL(18,2) COMMENT 'Maximum allowable sulfur content for this SRF product grade. Regulatory emissions limit.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Target sulfur content of the SRF product as a percentage of dry mass. Important for emissions compliance and air quality.',
    `target_market` STRING COMMENT 'Primary market segment or customer type for this SRF product (e.g., Cement Kilns, Waste-to-Energy Facilities, Industrial Boilers, Power Generation).',
    `technical_data_sheet_url` STRING COMMENT 'URL or document reference to the complete technical data sheet for this SRF product specification.',
    CONSTRAINT pk_srf_product PRIMARY KEY(`srf_product_id`)
) COMMENT 'Defines Solid Recovered Fuel (SRF) product specifications produced from processed waste streams for sale to WTE facilities and industrial consumers. Captures SRF product grade, calorific value (MJ/kg), moisture content, chlorine content, ash content, heavy metal limits, and applicable EN 15359 or ASTM quality standards. Each SRF product represents a distinct marketable fuel grade with its own quality specification and pricing. This is the SSOT for SRF product definitions — the catalog of fuel products the business manufactures and sells.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`area` (
    `area_id` BIGINT COMMENT 'Unique identifier for the service area. Primary key for the service area entity.',
    `circular_economy_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_economy_program. Business justification: Circular economy programs operate within defined service areas. Geographic scope determines participating customers, collection infrastructure, and regulatory framework for extended producer responsib',
    `district_id` BIGINT COMMENT 'Identifier of the operational district responsible for service delivery in this area. Links to the district master for routing, fleet assignment, and workforce planning.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Service areas operate under municipal franchise agreements that are formalized as permits. Franchise permit defines service obligations, rate structures, performance standards, and geographic boundari',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Service areas define reporting boundaries for GHG inventories under EPA GHGRP and GHG Protocol. Franchise territories align with facility-level reporting requirements; area-level emissions roll up int',
    `facility_id` BIGINT COMMENT 'Identifier of the primary landfill or disposal facility serving this service area. Used for haul routing and tipping fee calculation.',
    `primary_mrf_facility_id` BIGINT COMMENT 'Identifier of the primary MRF processing recyclable materials from this service area.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Service areas route collected waste to designated WTE facilities based on franchise agreements, transportation economics, and facility capacity. Critical for route optimization, franchise compliance, ',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Service areas must comply with jurisdiction-specific safety programs (state OSHA plans vary; California has Cal/OSHA). Operations managers reference required programs when planning service delivery an',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Service_territory and service_area represent a hierarchical geographic relationship. Territories are broader planning zones (franchise boundaries, municipal contracts), while service_areas are operati',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Service areas have assigned territory managers for customer escalations, franchise compliance oversight, and performance accountability. Reuses existing territory_manager_name as denormalized data. Es',
    `area_code` STRING COMMENT 'Business identifier code for the service area used in operational systems and customer communications. Typically follows a regional or district-based naming convention.. Valid values are `^[A-Z0-9]{4,12}$`',
    `area_name` STRING COMMENT 'Human-readable name of the service area, typically reflecting the municipality, county, or region served (e.g., Downtown Chicago, Orange County North).',
    `area_type` STRING COMMENT 'Classification of the service area based on the predominant customer segment and waste generation profile. Determines service offerings, equipment types, and routing strategies.. Valid values are `residential|commercial|industrial|mixed|rural|urban`',
    `census_tract_list` STRING COMMENT 'Comma-separated list of U.S. Census tract identifiers covered by this service area. Used for demographic analysis and environmental justice reporting.',
    `commercial_account_count` STRING COMMENT 'Number of active commercial waste collection accounts within the service area. Used for route density analysis and sales planning.',
    `county_fips_code` STRING COMMENT 'Five-digit FIPS code identifying the county in which the service area is located. Used for geographic analysis and regulatory reporting.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service area record was first created in the system.',
    `diversion_rate_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of waste diverted from landfill through recycling, composting, and waste-to-energy programs. Often mandated by municipal sustainability goals.',
    `franchise_agreement_number` STRING COMMENT 'Reference number of the franchise or municipal contract authorizing waste collection services in this area. Links to the master contract repository.',
    `franchise_expiration_date` DATE COMMENT 'Date on which the current franchise agreement expires. Critical for contract renewal planning and service continuity.',
    `geographic_boundary_wkt` STRING COMMENT 'Well-Known Text representation of the service area polygon boundary. Used for GIS mapping, route optimization, and spatial eligibility checks.',
    `gps_tracking_required` BOOLEAN COMMENT 'Indicates whether GPS tracking is mandated for all collection vehicles operating in this service area (may be required by franchise agreement).',
    `hazmat_collection_available` BOOLEAN COMMENT 'Indicates whether hazardous waste collection events or services are offered in this service area.',
    `household_count_estimate` STRING COMMENT 'Estimated number of residential households in the service area. Key metric for residential service planning and revenue forecasting.',
    `lea_agency_name` STRING COMMENT 'Name of the Local Enforcement Agency responsible for solid waste compliance oversight in this service area.',
    `municipality_code` STRING COMMENT 'Official code identifying the municipality or local government jurisdiction. Used for regulatory reporting and franchise compliance.. Valid values are `^[A-Z0-9]{2,10}$`',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or historical context relevant to this service area.',
    `operational_status` STRING COMMENT 'Current operational status of the service area. Active areas are currently serviced; planned areas are under contract negotiation; suspended areas have temporary service holds; discontinued areas are no longer serviced.. Valid values are `active|inactive|suspended|planned|discontinued`',
    `organics_program_available` BOOLEAN COMMENT 'Indicates whether organic waste collection (yard waste, food scraps) is available in this service area.',
    `permit_expiration_date` DATE COMMENT 'Date on which the operating permit expires. Critical for compliance tracking and renewal planning.',
    `permit_number` STRING COMMENT 'Permit or license number authorizing waste collection operations in this service area. Required for regulatory compliance.',
    `population_estimate` STRING COMMENT 'Estimated total population residing within the service area boundaries. Used for capacity planning and market analysis.',
    `recycling_program_available` BOOLEAN COMMENT 'Indicates whether curbside recycling services are available to customers in this service area.',
    `regulatory_jurisdiction` STRING COMMENT 'Name of the primary regulatory authority governing waste management operations in this area (e.g., state environmental agency, local enforcement agency).',
    `route_optimization_enabled` BOOLEAN COMMENT 'Indicates whether automated route optimization algorithms are applied to collection routes in this service area.',
    `service_end_date` DATE COMMENT 'Date on which services were discontinued in this area. Null for active service areas.',
    `service_frequency_residential` STRING COMMENT 'Standard collection frequency for residential customers in this service area. Determines route scheduling and capacity requirements.. Valid values are `once_weekly|twice_weekly|biweekly|on_demand`',
    `service_start_date` DATE COMMENT 'Date on which waste management services were first provided in this service area.',
    `sla_response_time_hours` STRING COMMENT 'Maximum number of hours allowed to respond to customer service requests in this area, as defined by franchise agreement or internal standards.',
    `square_miles` DECIMAL(18,2) COMMENT 'Total geographic area covered by this service area in square miles. Used for density analysis and resource planning.',
    `state_code` STRING COMMENT 'Two-letter U.S. state abbreviation for the service area location.. Valid values are `^[A-Z]{2}$`',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last modified this service area record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service area record was last modified.',
    `zip_code_list` STRING COMMENT 'Comma-separated list of ZIP codes fully or partially covered by this service area. Used for customer address validation and service eligibility determination.',
    CONSTRAINT pk_area PRIMARY KEY(`area_id`)
) COMMENT 'Defines the geographic territories in which the business is authorized to provide waste management services. Each service area represents a distinct operational territory identified by geographic boundaries (ZIP codes, census tracts, municipality codes, county FIPS), applicable franchise agreement, regulatory jurisdiction, and operational district assignment. Supports service eligibility validation at the customer address level — determining which offerings are available at a given location. Referenced by collection (route planning), contract (franchise compliance), and billing (geographic rate differentiation) domains.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`sla_definition` (
    `sla_definition_id` BIGINT COMMENT 'Unique identifier for the SLA definition record. Primary key.',
    `job_position_id` BIGINT COMMENT 'Foreign key linking to workforce.job_position. Business justification: SLA response times drive staffing requirements: 2-hour hazmat response needs on-call certified technicians, 4-hour missed pickup resolution needs route supervisors. Essential for workforce capacity pl',
    `offering_id` BIGINT COMMENT 'Reference to the service offering to which this SLA applies (e.g., residential pickup, commercial dumpster, roll-off rental).',
    `auto_credit_enabled_flag` BOOLEAN COMMENT 'Indicates whether SLA breach credits are automatically applied to customer accounts (true) or require manual approval (false).',
    `complaint_resolution_window_hours` DECIMAL(18,2) COMMENT 'Maximum time in hours to resolve a customer complaint or service issue to customer satisfaction.',
    `container_delivery_lead_time_days` STRING COMMENT 'Maximum number of business days to deliver a container after order placement (e.g., 2 days for roll-off, 1 day for commercial dumpster).',
    `container_pickup_lead_time_days` STRING COMMENT 'Maximum number of business days to pick up a container after customer request (e.g., 1 day for standard service, same-day for premium).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA definition record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this SLA definition expires or is no longer applicable. Null for open-ended SLAs.',
    `effective_start_date` DATE COMMENT 'Date when this SLA definition becomes effective and applicable to contracts.',
    `escalation_threshold_hours` DECIMAL(18,2) COMMENT 'Time in hours after which an unresolved service issue is automatically escalated to management or specialized team.',
    `exclusions` STRING COMMENT 'List of conditions or circumstances under which the SLA does not apply (e.g., weather emergencies, road closures, customer access issues).',
    `late_delivery_penalty_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount credited or refunded for late container delivery beyond committed lead time.',
    `late_delivery_penalty_pct` DECIMAL(18,2) COMMENT 'Percentage of service charge credited or refunded for late container delivery beyond committed lead time.',
    `measurement_method` STRING COMMENT 'Description of how SLA compliance is measured and calculated (e.g., GPS timestamp validation, driver confirmation, customer acknowledgment).',
    `missed_pickup_credit_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount credited to customer account for each missed pickup that breaches SLA.',
    `missed_pickup_credit_pct` DECIMAL(18,2) COMMENT 'Percentage of service charge credited to customer account for each missed pickup that breaches SLA (alternative to fixed amount).',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this SLA definition record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA definition record was last modified.',
    `notification_enabled_flag` BOOLEAN COMMENT 'Indicates whether customers receive automated notifications for SLA breaches or service delays (true/false).',
    `on_time_service_rate_target_pct` DECIMAL(18,2) COMMENT 'Target percentage for on-time service delivery (e.g., 98.5% for premium tier). Measured as percentage of scheduled pickups completed within service window.',
    `reporting_frequency` STRING COMMENT 'Frequency at which SLA performance reports are generated and shared with customers or stakeholders.. Valid values are `daily|weekly|monthly|quarterly`',
    `resolution_time_hours` DECIMAL(18,2) COMMENT 'Maximum time in hours to resolve a service issue or complaint (e.g., 48 hours for missed pickup resolution).',
    `response_time_hours` DECIMAL(18,2) COMMENT 'Maximum time in hours to respond to a service request or missed pickup complaint (e.g., 24 hours for standard residential).',
    `service_window_end_time` TIMESTAMP COMMENT 'End time of the committed service window for pickup or delivery (HH:MM format, e.g., 17:00 for 5 PM end).',
    `service_window_start_time` TIMESTAMP COMMENT 'Start time of the committed service window for pickup or delivery (HH:MM format, e.g., 07:00 for 7 AM start).',
    `service_window_tolerance_minutes` STRING COMMENT 'Allowable grace period in minutes beyond the service window end time before SLA breach is recorded (e.g., 30 minutes).',
    `sla_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the SLA definition for system integration and reporting.',
    `sla_definition_description` STRING COMMENT 'Detailed description of the SLA terms, commitments, and conditions. Includes any special provisions or exclusions.',
    `sla_definition_status` STRING COMMENT 'Current lifecycle status of the SLA definition (active, inactive, draft, retired).. Valid values are `active|inactive|draft|retired`',
    `sla_name` STRING COMMENT 'Business-friendly name of the SLA definition (e.g., Standard Residential Pickup SLA, Premium Commercial Service SLA).',
    `sla_type` STRING COMMENT 'Classification of the SLA tier (standard, premium, enterprise, custom).. Valid values are `standard|premium|enterprise|custom`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this SLA definition record.',
    CONSTRAINT pk_sla_definition PRIMARY KEY(`sla_definition_id`)
) COMMENT 'Defines Service Level Agreement (SLA) standards associated with each service offering. Captures SLA name, service offering reference, response time commitments (e.g., missed pickup resolution within 24 hours), on-time service rate targets, container delivery lead times, complaint resolution windows, and penalty/credit terms for SLA breaches. This is the SSOT for SLA definitions referenced by contract, billing, and customer service domains. Sourced from Salesforce CRM contract SLA configurations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`surcharge_definition` (
    `surcharge_definition_id` BIGINT COMMENT 'Unique identifier for the surcharge definition record. Primary key.',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.line. Business justification: Surcharges are typically defined at the service line level and then applied to offerings within that line. Adding line_id FK breaks the silo for surcharge_definition. Note: The existing applicable_ser',
    `applicable_container_types` STRING COMMENT 'Comma-separated list of Container Identification (CID) types or container categories to which this surcharge applies. Null if not container-specific.',
    `applicable_geographic_zones` STRING COMMENT 'Comma-separated list of geographic zone codes, districts, or service areas where this surcharge is applicable. Null if applies universally.',
    `applicable_service_lines` STRING COMMENT 'Comma-separated list of service line codes or categories to which this surcharge applies (e.g., residential, commercial, roll-off, recycling, hazardous waste). Empty if applies to all services.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether application of this surcharge to a customer account requires managerial or compliance approval (true) or can be applied automatically (false).',
    `calculation_method` STRING COMMENT 'Method used to calculate the surcharge amount (e.g., flat fee per service, percentage of base rate, indexed to external price index such as DOE diesel price, tiered based on thresholds, per unit of service, weight-based for overweight fees).. Valid values are `flat_fee|percentage_of_base|index_linked|tiered|per_unit|weight_based`',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the surcharge for internal cost allocation and profitability analysis.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this surcharge definition record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this surcharge definition record was first created in the system.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Indicates whether customers must be notified in advance when this surcharge is applied (true) or notification is not required (false).',
    `display_on_invoice_flag` BOOLEAN COMMENT 'Indicates whether this surcharge should be displayed as a separate line item on customer invoices (true) or rolled into base service charge (false).',
    `effective_end_date` DATE COMMENT 'Date after which this surcharge definition is no longer active. Null if currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this surcharge definition becomes active and applicable to new services or billing cycles.',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount charged when calculation method is flat fee. Null if not applicable.',
    `index_formula` STRING COMMENT 'Mathematical formula or business rule defining how the index value translates to surcharge amount. Null if not index-linked.',
    `index_source` STRING COMMENT 'External price index or data source used for index-linked surcharges (e.g., DOE Diesel Price Index, EPA Environmental Index). Null if not index-linked.',
    `invoice_line_description` STRING COMMENT 'Customer-facing description text that appears on invoices when this surcharge is applied. Null if not displayed separately.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this surcharge definition record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this surcharge definition record was last updated.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum dollar amount cap for the surcharge. Null if no maximum applies.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum dollar amount that will be charged regardless of calculation result. Null if no minimum applies.',
    `notes` STRING COMMENT 'Free-form internal notes or comments about this surcharge definition for operational reference.',
    `notification_days_advance` STRING COMMENT 'Number of days advance notice required before applying this surcharge to customer accounts. Null if notification is not required.',
    `percentage_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to base service charge when calculation method is percentage-based (e.g., 8.50 for 8.5%). Null if not applicable.',
    `proration_allowed_flag` BOOLEAN COMMENT 'Indicates whether this surcharge can be prorated for partial billing periods (true) or must be charged in full (false).',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or governmental authority mandating this surcharge (e.g., EPA, State DEQ, Local Solid Waste Authority). Null if not regulatory-mandated.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether this surcharge is mandated by regulatory or governmental authority (true) or is a business-discretionary fee (false).',
    `regulatory_reference_number` STRING COMMENT 'Official regulation, statute, or ordinance number authorizing or requiring this surcharge. Null if not regulatory-mandated.',
    `revenue_account_code` STRING COMMENT 'General Ledger account code to which surcharge revenue is posted for financial reporting and accounting purposes.. Valid values are `^[0-9]{4,10}$`',
    `surcharge_category` STRING COMMENT 'High-level classification of the surcharge type for grouping and reporting purposes. [ENUM-REF-CANDIDATE: fuel|environmental|regulatory|contamination|overweight|extra_service|late_fee — 7 candidates stripped; promote to reference product]',
    `surcharge_definition_status` STRING COMMENT 'Current lifecycle status of the surcharge definition record.. Valid values are `active|inactive|pending|retired|suspended`',
    `surcharge_description` STRING COMMENT 'Detailed business description explaining the purpose, applicability, and calculation basis of the surcharge.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether this surcharge amount is subject to sales tax or other applicable taxes (true) or is tax-exempt (false).',
    `version_number` STRING COMMENT 'Version number of this surcharge definition for tracking changes and maintaining historical versions.',
    `waivable_flag` BOOLEAN COMMENT 'Indicates whether this surcharge can be waived under certain circumstances or customer service discretion (true) or is non-waivable (false).',
    `waiver_approval_level` STRING COMMENT 'Organizational approval level required to waive this surcharge. Null if surcharge is not waivable.. Valid values are `none|supervisor|manager|director|executive`',
    CONSTRAINT pk_surcharge_definition PRIMARY KEY(`surcharge_definition_id`)
) COMMENT 'Defines all surcharges and ancillary fees that can be applied to service offerings beyond the base rate. Includes fuel surcharges (indexed to DOE diesel price), environmental recovery fees, regulatory compliance fees, contamination surcharges (recycling), overweight fees (roll-off), extra pickup fees, and late set-out fees. Captures surcharge code, calculation method (flat fee, percentage of base, index-linked), applicable service lines, and effective date range. Referenced by billing and contract domains.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`restriction` (
    `restriction_id` BIGINT COMMENT 'Unique identifier for the service restriction record. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Service restriction applies to a specific service area. The service_restriction table has a STRING column affected_service_area that should be replaced with a proper FK to service_area.service_area_',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Service restriction applies to a specific waste stream. The service_restriction table has a STRING column affected_waste_stream that should be replaced with a proper FK to service_waste_stream.servi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Service restrictions may specify approved vendors for regulatory compliance (e.g., only certain TSDFs approved for specific EPA waste codes). Real business process: regulatory compliance, approved ven',
    `contract_id` BIGINT COMMENT 'Reference to a specific contract or franchise agreement that mandates this restriction. Null if restriction is not contract-driven.',
    `facility_id` BIGINT COMMENT 'Reference to the specific facility (landfill, transfer station, MRF, WTE plant) where the restriction applies. Null if restriction is not facility-specific.',
    `jha_id` BIGINT COMMENT 'Foreign key linking to safety.jha. Business justification: Restrictions may mandate completion of specific JHAs before service can resume (e.g., confined space entry JHA required before servicing underground compactor). Safety and operations teams coordinate ',
    `offering_id` BIGINT COMMENT 'Reference to an alternative service offering that customers can use if the primary offering is restricted. Null if no alternative is available.',
    `restriction_offering_id` BIGINT COMMENT 'Reference to the service offering that is subject to this restriction. Links to the service offering catalog.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Service restrictions are often imposed following safety incidents (e.g., suspending hazmat collection after spill incident). Operations teams reference the triggering incident when documenting restric',
    `affected_customer_segment` STRING COMMENT 'Customer type or segment to which the restriction applies. Null if restriction applies universally.. Valid values are `residential|commercial|industrial|municipal|all`',
    `amcs_restriction_flag` STRING COMMENT 'AMCS platform flag or code used to enforce this restriction in route optimization and dispatching. Null if not applicable to AMCS.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `compliance_validation_rule` STRING COMMENT 'Business rule or validation logic used to enforce this restriction in customer eligibility and order entry systems (e.g., block_order_if_waste_code_matches, require_permit_check, check_service_area_boundary).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this restriction record was first created in the system.',
    `dot_hazard_class` STRING COMMENT 'DOT hazard classification if the restriction applies to materials regulated for transport (e.g., Class 3 Flammable Liquids, Class 9 Miscellaneous). Null if not DOT-regulated.',
    `effective_end_date` DATE COMMENT 'Date when the restriction expires or is no longer enforced. Null for open-ended restrictions.',
    `effective_start_date` DATE COMMENT 'Date when the restriction becomes active and enforceable.',
    `epa_waste_code` STRING COMMENT 'EPA hazardous waste code if the restriction applies to a specific hazardous waste category (e.g., D001 for ignitable waste, F001 for spent halogenated solvents). Null if not hazardous waste related.. Valid values are `^[DKPUF][0-9]{3}$`',
    `frequency_limit` STRING COMMENT 'Maximum service frequency allowed under the restriction (e.g., once per month, quarterly only). Null if no frequency limit applies.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this restriction record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this restriction record was last updated.',
    `notification_message` STRING COMMENT 'Standard message text to be displayed to customers when this restriction is triggered (e.g., This service is not available for hazardous waste in your area. Please contact our hazardous waste team.). Null if no notification is required.',
    `notification_required` BOOLEAN COMMENT 'Indicates whether customers must be notified of this restriction (True) or if it is enforced silently in backend systems (False).',
    `override_approval_role` STRING COMMENT 'Role or position authorized to approve an override of this restriction (e.g., Regional Operations Manager, Environmental Compliance Officer, VP of Operations). Null if no override is permitted.',
    `override_authorization_required` BOOLEAN COMMENT 'Indicates whether the restriction can be overridden with special authorization (True) or is absolute (False).',
    `reason` STRING COMMENT 'Detailed business or regulatory rationale for the restriction (e.g., EPA hazardous waste exclusion, franchise agreement moratorium, facility capacity constraint, seasonal road closure).',
    `regulatory_citation` STRING COMMENT 'Legal or regulatory reference supporting the restriction (e.g., RCRA 40 CFR 261, state environmental code section, local ordinance number). Null if restriction is operational rather than regulatory.',
    `restriction_code` STRING COMMENT 'Unique business code identifying the type of restriction (e.g., HAZ-EXCL-RES, CND-XFER-LIMIT, FRAN-MORATORIUM).. Valid values are `^[A-Z0-9]{4,12}$`',
    `restriction_name` STRING COMMENT 'Human-readable name of the restriction (e.g., Hazardous Waste Exclusion - Residential Curbside, Construction and Demolition Debris Transfer Station Restriction).',
    `restriction_scope` STRING COMMENT 'Extent of the restriction: full_exclusion (service not available), partial_limitation (service available with conditions), conditional_approval (requires special authorization), volume_cap (quantity limit), frequency_cap (service frequency limit).. Valid values are `full_exclusion|partial_limitation|conditional_approval|volume_cap|frequency_cap`',
    `restriction_status` STRING COMMENT 'Current lifecycle status of the restriction. Active restrictions are enforced in eligibility checks.. Valid values are `active|inactive|pending|suspended|expired`',
    `restriction_type` STRING COMMENT 'Category of restriction: geographic (area-based), customer_type (residential vs commercial), waste_stream (material-based), regulatory (compliance mandate), operational (capacity or resource constraint), seasonal (time-based).. Valid values are `geographic|customer_type|waste_stream|regulatory|operational|seasonal`',
    `salesforce_restriction_code` STRING COMMENT 'Salesforce CRM record ID for this restriction, used to enforce eligibility rules in customer service and contract management workflows. Null if not synced to Salesforce.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `sap_ehs_restriction_code` STRING COMMENT 'SAP EHS module restriction code or rule identifier used to enforce this restriction in the ERP system. Null if not mapped to SAP.',
    `seasonal_end_date` DATE COMMENT 'Recurring annual end date for seasonal restrictions (MM-DD format, e.g., 03-31 for March 31st). Null if restriction is not seasonal.',
    `seasonal_start_date` DATE COMMENT 'Recurring annual start date for seasonal restrictions (MM-DD format, e.g., 11-01 for November 1st). Null if restriction is not seasonal.',
    `volume_limit_tons` DECIMAL(18,2) COMMENT 'Maximum volume or weight limit in tons if the restriction imposes a quantity cap. Null if no volume limit applies.',
    CONSTRAINT pk_restriction PRIMARY KEY(`restriction_id`)
) COMMENT 'Captures restrictions and exclusions applied to service offerings by geography, customer type, waste stream, or regulatory mandate. Examples include hazardous waste exclusions from residential curbside, C&D debris restrictions at certain transfer stations, and service suspensions in areas under franchise moratorium. Captures restriction type, affected offering, affected service area, restriction reason, regulatory citation, effective date, and override authorization process. Supports compliance validation and customer eligibility checks.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`eligibility_rule` (
    `eligibility_rule_id` BIGINT COMMENT 'Unique identifier for the eligibility rule. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Eligibility rule applies to a specific service area. The eligibility_rule table has a STRING column service_area_code that should be replaced with a proper FK to service_area.service_area_id. This n',
    `facility_id` BIGINT COMMENT 'Reference to the specific facility (landfill, Materials Recovery Facility (MRF), Waste-to-Energy (WTE) plant, Treatment Storage and Disposal Facility (TSDF)) to which this eligibility rule applies, if facility-specific.',
    `line_id` BIGINT COMMENT 'Reference to the service line to which this eligibility rule applies, if applicable at the service line level rather than individual offering level.',
    `offering_id` BIGINT COMMENT 'Reference to the service offering to which this eligibility rule applies.',
    `jha_id` BIGINT COMMENT 'Foreign key linking to safety.jha. Business justification: Eligibility rules for high-hazard services (hazmat, confined space work) require documented JHAs before service can be offered. Sales and safety teams verify JHA completion during service qualificatio',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Eligibility rules may require specific vendor certifications or capabilities for service delivery. Real business process: vendor qualification, service delivery constraints, and regulatory compliance.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Eligibility rule applies to a specific waste stream. The eligibility_rule table has a STRING column waste_stream_code that should be replaced with a proper FK to service_waste_stream.service_waste_s',
    `parent_eligibility_rule_id` BIGINT COMMENT 'Self-referencing FK on eligibility_rule (parent_eligibility_rule_id)',
    `compliance_validation_rule` STRING COMMENT 'Technical expression or business logic used to validate compliance with this eligibility rule, such as SQL expression, decision tree logic, or validation checklist reference.',
    `container_type_restriction` STRING COMMENT 'Comma-separated list of container types (Container Identification (CID) codes) that are eligible or restricted under this rule, depending on rule_category.',
    `county_fips_code` STRING COMMENT 'Five-digit FIPS code identifying the county to which this eligibility rule applies, if geographic_scope is county.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility rule record was first created in the system.',
    `customer_segment` STRING COMMENT 'Customer segment to which this eligibility rule applies: residential, commercial, industrial, municipal, institutional, or all segments.. Valid values are `residential|commercial|industrial|municipal|institutional|all`',
    `effective_end_date` DATE COMMENT 'Date when this eligibility rule ceases to be effective and is no longer enforced. Null indicates an open-ended rule.',
    `effective_start_date` DATE COMMENT 'Date when this eligibility rule becomes effective and begins to be enforced.',
    `epa_waste_code` STRING COMMENT 'EPA-assigned waste code that this eligibility rule applies to, used for regulatory compliance and hazardous waste classification under Resource Conservation and Recovery Act (RCRA).',
    `geographic_scope` STRING COMMENT 'Geographic boundary level at which this eligibility rule applies: national, state, county, municipality, defined service area, zip code, or custom boundary. [ENUM-REF-CANDIDATE: national|state|county|municipality|service_area|zip_code|custom — 7 candidates stripped; promote to reference product]',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this eligibility rule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility rule record was last updated or modified.',
    `maximum_volume_cubic_yards` DECIMAL(18,2) COMMENT 'Maximum waste volume in cubic yards allowed under this eligibility rule, used for operational capacity constraints and facility limits.',
    `maximum_weight_tons` DECIMAL(18,2) COMMENT 'Maximum waste weight in tons allowed under this eligibility rule, used for facility capacity constraints and regulatory limits.',
    `minimum_volume_cubic_yards` DECIMAL(18,2) COMMENT 'Minimum waste volume in cubic yards required for eligibility under this rule, used for operational capacity planning and service viability.',
    `minimum_weight_tons` DECIMAL(18,2) COMMENT 'Minimum waste weight in tons required for eligibility under this rule, used for Tons Per Day (TPD) capacity planning and service viability.',
    `notification_message` STRING COMMENT 'Standard message text to be communicated to customers when this eligibility rule applies or restricts their service eligibility.',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether customer notification is required when this eligibility rule affects their service eligibility.',
    `override_approval_role` STRING COMMENT 'Job role or position authorized to approve overrides of this eligibility rule (e.g., Regional Manager, Compliance Officer, VP Operations).',
    `override_authorization_required` BOOLEAN COMMENT 'Indicates whether management authorization is required to override or waive this eligibility rule for exceptional cases.',
    `permit_requirement_flag` BOOLEAN COMMENT 'Indicates whether a special permit is required for customers or facilities to be eligible for this service offering under this rule.',
    `permit_type` STRING COMMENT 'Type of permit required for eligibility, such as Treatment Storage and Disposal Facility (TSDF) permit, hazardous waste generator permit, or local franchise agreement.',
    `priority_level` STRING COMMENT 'Numeric priority or precedence level for this rule when multiple eligibility rules may apply to the same scenario. Lower numbers indicate higher priority.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or Local Enforcement Agency (LEA) that mandates or governs this eligibility rule (e.g., EPA, state environmental agency, local solid waste authority).',
    `regulatory_citation` STRING COMMENT 'Legal citation or reference to the regulation, statute, or permit condition that establishes this eligibility rule (e.g., RCRA Section 3001, 40 CFR Part 261, state code section).',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of waste materials governed by this eligibility rule, determining handling, transport, and disposal requirements.. Valid values are `non_hazardous|hazardous|universal_waste|special_waste|medical_waste`',
    `rule_category` STRING COMMENT 'Indicates whether the rule defines inclusion criteria (who IS eligible), exclusion criteria (who is NOT eligible), or conditional eligibility (eligible under specific circumstances).. Valid values are `inclusion|exclusion|conditional`',
    `rule_code` STRING COMMENT 'Business-assigned unique code identifying this eligibility rule for operational reference and system integration.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `rule_description` STRING COMMENT 'Detailed explanation of the eligibility rule, including business rationale, conditions, and application context.',
    `rule_name` STRING COMMENT 'Human-readable name of the eligibility rule describing its purpose and scope.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the eligibility rule: active (in force), inactive (not enforced), pending (awaiting approval or effective date), suspended (temporarily not enforced), or expired (past effective period).. Valid values are `active|inactive|pending|suspended|expired`',
    `rule_type` STRING COMMENT 'Classification of the eligibility rule by its primary constraint dimension: geographic (service area restrictions), customer_segment (business vs residential), waste_stream (material type restrictions), regulatory (permit or compliance-based), operational (capacity or resource constraints), or contractual (agreement-based restrictions).. Valid values are `geographic|customer_segment|waste_stream|regulatory|operational|contractual`',
    `seasonal_end_date` DATE COMMENT 'End date for seasonal eligibility rules that recur annually (e.g., yard waste collection eligibility until November 30 each year). Month and day are significant; year may be ignored for recurring rules.',
    `seasonal_start_date` DATE COMMENT 'Start date for seasonal eligibility rules that recur annually (e.g., yard waste collection eligibility from April 1 each year). Month and day are significant; year may be ignored for recurring rules.',
    `service_frequency_restriction` STRING COMMENT 'Service frequency requirements or restrictions under this eligibility rule (e.g., minimum once per week, maximum twice per week).',
    `state_code` STRING COMMENT 'Two-letter US state code to which this eligibility rule applies, if geographic_scope is state.. Valid values are `^[A-Z]{2}$`',
    `zip_code_list` STRING COMMENT 'Comma-separated list of ZIP codes to which this eligibility rule applies, if geographic_scope is zip_code.',
    CONSTRAINT pk_eligibility_rule PRIMARY KEY(`eligibility_rule_id`)
) COMMENT 'Defines rules governing which customers, geographies, or waste streams are eligible for specific service offerings based on regulatory, operational, or business constraints';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`pricing_tier` (
    `pricing_tier_id` BIGINT COMMENT 'Unique identifier for the pricing tier record. Primary key.',
    `service_rate_schedule_id` BIGINT COMMENT 'Reference to the parent service rate schedule to which this pricing tier belongs.',
    `parent_pricing_tier_id` BIGINT COMMENT 'Self-referencing FK on pricing_tier (parent_pricing_tier_id)',
    `applicable_customer_segment` STRING COMMENT 'Customer segment(s) eligible for this pricing tier: residential, commercial, industrial, municipal, institutional, or all segments.. Valid values are `residential|commercial|industrial|municipal|institutional|all`',
    `applicable_service_area_codes` STRING COMMENT 'Comma-separated list of service area codes where this pricing tier is available. Null if tier applies to all service areas.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether management approval is required before a customer can be assigned to this pricing tier (True) or can be assigned automatically (False).',
    `approval_role` STRING COMMENT 'Role or position authorized to approve customer assignment to this tier (e.g., Regional Manager, Pricing Director). Null if no approval required.',
    `auto_downgrade_enabled_flag` BOOLEAN COMMENT 'Indicates whether customers are automatically downgraded from this tier when they no longer meet the qualification criteria (True) or remain at current tier (False).',
    `auto_upgrade_enabled_flag` BOOLEAN COMMENT 'Indicates whether customers are automatically upgraded to this tier when they meet the qualification criteria (True) or require manual approval (False).',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this pricing tier record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing tier record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tier rate amount (e.g., USD, CAD, MXN).. Valid values are `USD|CAD|MXN|EUR|GBP`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed dollar discount applied at this tier. Null if tier uses percentage discount or absolute pricing.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied at this tier relative to the base rate. Null if tier uses absolute pricing rather than discount-based pricing.',
    `diversion_rate_requirement_pct` DECIMAL(18,2) COMMENT 'Minimum waste diversion rate percentage required to qualify for or maintain this pricing tier. Null if no diversion requirement applies.',
    `effective_end_date` DATE COMMENT 'Date when this pricing tier expires and is no longer available. Null for open-ended tiers.',
    `effective_start_date` DATE COMMENT 'Date when this pricing tier becomes effective and available for use in billing and contract management.',
    `gl_revenue_account_code` STRING COMMENT 'General Ledger account code to which revenue from this pricing tier is posted.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this pricing tier record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing tier record was last modified.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum charge amount cap for this tier. Null if no maximum cap applies.',
    `maximum_pickups_per_period` STRING COMMENT 'Maximum number of service pickups per billing period for this tier. Null if tier has no upper limit or is not frequency-based.',
    `maximum_volume_tons` DECIMAL(18,2) COMMENT 'Maximum waste volume in tons for this pricing tier. Null if tier has no upper limit or is not volume-based.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum charge amount that applies to this tier regardless of actual usage or volume. Null if no minimum applies.',
    `minimum_commitment_months` STRING COMMENT 'Minimum contract commitment period in months required to qualify for this pricing tier. Null if tier is not commitment-based.',
    `minimum_pickups_per_period` STRING COMMENT 'Minimum number of service pickups per billing period required to qualify for this tier. Null if tier is not frequency-based.',
    `minimum_volume_tons` DECIMAL(18,2) COMMENT 'Minimum waste volume in tons required to qualify for this pricing tier. Null if tier is not volume-based.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this pricing tier.',
    `oracle_rate_tier_code` STRING COMMENT 'Oracle Revenue Management rate tier code for billing system integration.',
    `promotion_code` STRING COMMENT 'Marketing promotion code associated with this tier if it is promotional. Null for non-promotional tiers.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this tier is part of a promotional campaign (True) or a standard ongoing tier (False).',
    `proration_allowed_flag` BOOLEAN COMMENT 'Indicates whether charges for this tier can be prorated for partial billing periods (True) or must be charged in full (False).',
    `rate_unit` STRING COMMENT 'Unit of measure for the tier rate amount (e.g., per ton, per cubic yard, per pickup, per month, per container, flat fee).. Valid values are `per_ton|per_cubic_yard|per_pickup|per_month|per_container|flat_fee`',
    `sap_sd_condition_type` STRING COMMENT 'SAP SD condition type code used for pricing calculation and billing integration for this tier.',
    `sustainability_incentive_flag` BOOLEAN COMMENT 'Indicates whether this tier includes pricing incentives for sustainability goals such as diversion rate targets or Greenhouse Gas (GHG) reduction (True) or is standard pricing (False).',
    `tier_code` STRING COMMENT 'Unique business code identifying this pricing tier within the rate schedule. Used for operational reference and system integration.',
    `tier_description` STRING COMMENT 'Detailed description of the pricing tier, including eligibility criteria, benefits, and applicable conditions.',
    `tier_name` STRING COMMENT 'Human-readable name of the pricing tier (e.g., Bronze, Silver, Gold, Volume Tier 1, Commitment Tier 3).',
    `tier_rate_amount` DECIMAL(18,2) COMMENT 'The pricing rate applicable to this tier. Interpretation depends on rate_unit (e.g., dollars per ton, dollars per pickup, flat monthly fee).',
    `tier_sequence` STRING COMMENT 'Ordinal position of this tier within the rate schedule, used for sorting and display purposes (e.g., 1 for lowest tier, 2 for next tier).',
    `tier_status` STRING COMMENT 'Current lifecycle status of the pricing tier: active (in use), inactive (not available), pending (awaiting approval), expired (past effective date), suspended (temporarily unavailable).. Valid values are `active|inactive|pending|expired|suspended`',
    `tier_type` STRING COMMENT 'Classification of the pricing tier basis: volume-based (tonnage thresholds), commitment-based (contract term), frequency-based (pickup frequency), hybrid (multiple factors), promotional (temporary offer), or standard (default tier).. Valid values are `volume|commitment|frequency|hybrid|promotional|standard`',
    CONSTRAINT pk_pricing_tier PRIMARY KEY(`pricing_tier_id`)
) COMMENT 'Defines volume-based and commitment-based pricing tiers within service rate schedules, enabling tiered pricing for commercial and municipal customers based on tonnage or pickup frequency';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`channel` (
    `channel_id` BIGINT COMMENT 'Unique identifier for the service delivery channel. Primary key.',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.service_line. Business justification: Service channels (delivery models like residential curbside, commercial roll-off, drop-off centers) are typically organized by service line. A channel like residential curbside aligns with the resid',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Service channel has a standard frequency plan. The service_channel table has a STRING column service_frequency_standard that should be replaced with a proper FK to frequency_plan.frequency_plan_id. ',
    `parent_channel_id` BIGINT COMMENT 'Self-referencing FK on channel (parent_channel_id)',
    `amcs_channel_code` STRING COMMENT 'Service channel code used in AMCS Platform for route optimization, dispatching, and operational management.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether service contracts sold through this channel automatically renew at the end of the initial term unless cancelled.',
    `billing_frequency` STRING COMMENT 'Standard billing cycle for services delivered through this channel (monthly recurring, quarterly, annual prepay, per-service event, in arrears after service).. Valid values are `monthly|quarterly|annual|per_service|arrears`',
    `cancellation_notice_days` STRING COMMENT 'Number of days advance notice required for customers to cancel or terminate service through this channel.',
    `cdl_requirement` STRING COMMENT 'Minimum Commercial Driver License class required for drivers operating in this service channel under DOT regulations.. Valid values are `none|class_c|class_b|class_a`',
    `channel_category` STRING COMMENT 'Operational category defining how the service is delivered to the customer (e.g., curbside pickup, on-site container service, customer drop-off).. Valid values are `curbside|onsite|dropoff|project_based|event_based|subscription`',
    `channel_code` STRING COMMENT 'Unique business code identifying the service delivery channel (e.g., RES_CURBSIDE, COM_ONSITE, MUNICIPAL_CONTRACT).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `channel_description` STRING COMMENT 'Detailed description of the service delivery channel, including operational characteristics and target customer segments.',
    `channel_name` STRING COMMENT 'Human-readable name of the service delivery channel (e.g., Residential Curbside, Commercial On-Site, Municipal Contract).',
    `channel_status` STRING COMMENT 'Current operational status of the service channel (active and available, inactive, temporarily suspended, pilot testing phase, being phased out).. Valid values are `active|inactive|suspended|pilot|sunset`',
    `channel_type` STRING COMMENT 'Classification of the service delivery channel by primary customer segment and delivery model.. Valid values are `residential|commercial|municipal|industrial|self_haul|special_event`',
    `container_ownership_model` STRING COMMENT 'Defines who owns the waste containers used in this service channel (company-owned and provided, customer-owned, rental from company, lease agreement, shared municipal containers).. Valid values are `company_owned|customer_owned|rental|lease|shared`',
    `contract_type` STRING COMMENT 'Type of contractual agreement governing service delivery through this channel (standard terms, custom negotiated, franchise agreement, municipal contract, master service agreement).. Valid values are `standard|custom|franchise|municipal_contract|master_service_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service channel record was first created in the system.',
    `customer_portal_enabled` BOOLEAN COMMENT 'Indicates whether customers using this channel have access to online self-service portal for scheduling, billing, and service management.',
    `customer_segment` STRING COMMENT 'Primary customer segment targeted by this service channel (residential households, small business, large commercial, industrial, municipal government, institutional).. Valid values are `residential|small_business|commercial|industrial|municipal|institutional`',
    `delivery_model` STRING COMMENT 'Defines the temporal pattern of service delivery (scheduled recurring, on-demand request, continuous access, seasonal, temporary project).. Valid values are `scheduled|on_demand|continuous|seasonal|temporary`',
    `diversion_rate_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of waste diverted from landfill disposal for services delivered through this channel, supporting sustainability goals.',
    `dot_hazmat_endorsement_required` BOOLEAN COMMENT 'Indicates whether drivers must hold a DOT HAZMAT endorsement to operate in this service channel due to hazardous waste handling.',
    `effective_end_date` DATE COMMENT 'Date when this service channel was or will be discontinued and no longer available for new customer enrollment. Null indicates indefinite availability.',
    `effective_start_date` DATE COMMENT 'Date when this service channel became or will become available for customer enrollment and service delivery.',
    `franchise_agreement_required` BOOLEAN COMMENT 'Indicates whether a municipal franchise agreement is required to provide services through this channel in specific geographic areas.',
    `geographic_availability` STRING COMMENT 'Description of geographic areas where this service channel is available (e.g., specific states, counties, municipalities, or service area codes).',
    `gps_tracking_required` BOOLEAN COMMENT 'Indicates whether GPS tracking of service vehicles is required for this channel to ensure service verification and compliance.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who most recently modified this service channel record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service channel record was most recently updated.',
    `manager_name` STRING COMMENT 'Name of the business manager or product owner responsible for this service channel.',
    `manifest_required` BOOLEAN COMMENT 'Indicates whether hazardous waste manifests (tracking documents) are required for services delivered through this channel under RCRA regulations.',
    `minimum_service_commitment_months` STRING COMMENT 'Minimum contract term in months required for customers subscribing to services through this channel.',
    `online_booking_enabled` BOOLEAN COMMENT 'Indicates whether customers can book and schedule services through this channel via online self-service without human interaction.',
    `permit_required` BOOLEAN COMMENT 'Indicates whether a regulatory permit or authorization is required to operate services through this channel.',
    `pricing_model` STRING COMMENT 'The pricing structure applied to services sold through this channel (flat monthly rate, volume-based per cubic yard, weight-based per ton, frequency-based per pickup, tiered by volume, usage-based actual consumption).. Valid values are `flat_rate|volume_based|weight_based|frequency_based|tiered|usage_based`',
    `regulatory_classification` STRING COMMENT 'Primary regulatory classification of waste streams handled through this channel under EPA and RCRA guidelines (Municipal Solid Waste, recyclable materials, organic waste, hazardous waste, universal waste, special waste).. Valid values are `msw|recyclable|organic|hazardous|universal_waste|special_waste`',
    `rfid_tracking_enabled` BOOLEAN COMMENT 'Indicates whether RFID container tracking is enabled for this service channel to capture container-level service events and waste stream data.',
    `route_optimization_enabled` BOOLEAN COMMENT 'Indicates whether services delivered through this channel are subject to automated route optimization and dynamic scheduling.',
    `sales_channel` STRING COMMENT 'The sales channel through which this service is sold and contracted (direct field sales, inside sales team, customer self-service portal, partner/reseller, broker, municipal competitive bid).. Valid values are `direct_sales|inside_sales|online_portal|partner|broker|municipal_bid`',
    `salesforce_channel_code` STRING COMMENT 'External identifier for this service channel in Salesforce CRM system for sales process and opportunity management integration.',
    `sap_sd_distribution_channel` STRING COMMENT 'SAP S/4HANA distribution channel code representing this service delivery channel in the ERP system.',
    `sap_sd_sales_org` STRING COMMENT 'SAP S/4HANA Sales and Distribution sales organization code associated with this service channel for order processing and revenue recognition.',
    `service_location_type` STRING COMMENT 'Defines where the service is physically delivered (at customer site, at company facility such as transfer station or landfill, at public drop-off location, or mobile/roving service).. Valid values are `customer_site|company_facility|public_location|mobile`',
    `sla_resolution_time_hours` DECIMAL(18,2) COMMENT 'Standard resolution time commitment in hours for service issues reported through this channel, as defined in customer SLAs.',
    `sla_response_time_hours` DECIMAL(18,2) COMMENT 'Standard response time commitment in hours for service requests placed through this channel, as defined in customer SLAs.',
    `sustainability_program_eligible` BOOLEAN COMMENT 'Indicates whether services delivered through this channel are eligible for sustainability programs, carbon offset credits, or green certifications.',
    CONSTRAINT pk_channel PRIMARY KEY(`channel_id`)
) COMMENT 'Defines the delivery channels through which services are sold and provisioned — residential curbside, commercial on-site, municipal contract, industrial project-based, and self-haul';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the service territory. Primary key.',
    `circular_economy_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_economy_program. Business justification: Programs are deployed by territory to align with franchise agreements, municipal partnerships, and regional material markets. Territory boundaries define program eligibility, customer enrollment, infr',
    `district_id` BIGINT COMMENT 'Identifier of the operational district to which this service territory is assigned for management purposes.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Territories require operating permits from local regulatory authorities (municipal franchise agreements, county solid waste permits). Territory activation depends on permit issuance. Route planning an',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Territories define operational boundaries for emissions reporting. Each territorys collection, transfer, and disposal activities contribute to consolidated GHG inventories required for EPA reporting,',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Territories have assigned managers for operational oversight, franchise agreement compliance, and customer relationship management. Reuses existing territory_manager_name as denormalized data. Core to',
    `facility_id` BIGINT COMMENT 'Identifier of the primary landfill facility designated for waste disposal from this territory.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Service territories route waste to designated WTE facilities for disposal. Essential for franchise compliance, route optimization, capacity planning, and operational waste flow management. Domain expe',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Service territories have mandatory safety program compliance requirements based on regulatory jurisdiction (federal vs. state OSHA). Territory managers track program adherence for franchise agreement ',
    `parent_territory_id` BIGINT COMMENT 'Self-referencing FK on territory (parent_territory_id)',
    `area_square_miles` DECIMAL(18,2) COMMENT 'Total geographic area of the service territory measured in square miles for capacity planning.',
    `census_tract_list` STRING COMMENT 'Comma-separated list of census tract identifiers within this territory for demographic analysis and planning.',
    `commercial_account_count` STRING COMMENT 'Number of active commercial customer accounts within this service territory.',
    `county_fips_code` STRING COMMENT 'Five-digit FIPS code uniquely identifying the county for regulatory and reporting purposes.. Valid values are `^[0-9]{5}$`',
    `county_name` STRING COMMENT 'Name of the county in which the service territory is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service territory record was first created in the system.',
    `diversion_rate_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of waste diverted from landfill through recycling and composting programs in this territory.',
    `effective_end_date` DATE COMMENT 'Date when the service territory ceases or will cease to be active. Null for open-ended territories.',
    `effective_start_date` DATE COMMENT 'Date when the service territory became or will become active for service delivery.',
    `franchise_agreement_number` STRING COMMENT 'Reference number of the franchise agreement governing this territory, if applicable.',
    `franchise_expiration_date` DATE COMMENT 'Date when the franchise agreement expires and requires renewal or renegotiation.',
    `geographic_boundary_wkt` STRING COMMENT 'Well-Known Text representation of the territory polygon boundary for GIS mapping and spatial analysis.',
    `gps_tracking_required` BOOLEAN COMMENT 'Indicates whether GPS tracking of collection vehicles is mandated for operations in this territory.',
    `hazmat_collection_available` BOOLEAN COMMENT 'Indicates whether hazardous waste collection services are offered in this territory.',
    `household_count_estimate` STRING COMMENT 'Estimated number of residential households in the territory for residential service planning.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this service territory record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service territory record was most recently updated.',
    `lea_agency_name` STRING COMMENT 'Name of the Local Enforcement Agency responsible for solid waste compliance oversight in this territory.',
    `municipality_name` STRING COMMENT 'Name of the municipality or local government entity associated with this territory.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special conditions, or operational considerations for this territory.',
    `operational_status` STRING COMMENT 'Current operational state of the service territory in the business lifecycle.. Valid values are `active|inactive|pending|suspended|planned`',
    `organics_program_available` BOOLEAN COMMENT 'Indicates whether organic waste collection and composting services are available in this territory.',
    `permit_expiration_date` DATE COMMENT 'Date when the operating permit expires and requires renewal to continue service operations.',
    `permit_number` STRING COMMENT 'Primary operating permit number authorizing waste collection services in this territory.',
    `population_estimate` STRING COMMENT 'Estimated total population within the service territory for demand forecasting and resource allocation.',
    `recycling_program_available` BOOLEAN COMMENT 'Indicates whether curbside recycling collection services are available in this territory.',
    `regulatory_jurisdiction` STRING COMMENT 'Name of the primary regulatory authority or jurisdiction governing waste management operations in this territory.',
    `route_optimization_enabled` BOOLEAN COMMENT 'Indicates whether automated route optimization is enabled for collection operations in this territory.',
    `service_frequency_residential` STRING COMMENT 'Standard service frequency for residential waste collection in this territory (e.g., weekly, twice-weekly).',
    `sla_response_time_hours` STRING COMMENT 'Maximum number of hours allowed to respond to service requests or complaints in this territory per SLA.',
    `state_code` STRING COMMENT 'Two-letter postal abbreviation for the state in which the territory is located.. Valid values are `^[A-Z]{2}$`',
    `territory_code` STRING COMMENT 'Business identifier code for the service territory used in operational systems and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `territory_name` STRING COMMENT 'Human-readable name of the service territory for identification and reporting purposes.',
    `territory_type` STRING COMMENT 'Classification of the territory based on service delivery model and contractual arrangement.. Valid values are `franchise|municipal_contract|open_market|exclusive|non_exclusive|hybrid`',
    `zip_code_list` STRING COMMENT 'Comma-separated list of ZIP codes covered by this service territory for address matching and routing.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Defines geographic territories and zones for service delivery planning, franchise boundaries, and municipal contract coverage areas with GIS polygon references';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`offering_compliance` (
    `offering_compliance_id` BIGINT COMMENT 'Unique identifier for this offering-requirement compliance record. Primary key.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the service offering that is subject to regulatory compliance requirements',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement that applies to this service offering',
    `applicability_notes` STRING COMMENT 'Free-text notes explaining how and why this regulatory requirement applies to this specific service offering, including any special conditions, exemptions, or interpretations relevant to this pairing.',
    `compliance_status` STRING COMMENT 'Current compliance status for this offering-requirement pairing indicating whether the service offering meets the regulatory requirement (Compliant, Non-Compliant, In Remediation, Under Review, Not Applicable, Pending Assessment).',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this compliance mapping record was created in the system.',
    `documentation_reference` STRING COMMENT 'Reference to compliance documentation, evidence, or records demonstrating how this service offering meets this regulatory requirement (e.g., permit numbers, certification IDs, document management system references, audit report IDs).',
    `effective_date` DATE COMMENT 'The date when this regulatory requirement became applicable to this specific service offering. May differ from the regulations general effective date if the offering was introduced later or scope changed.',
    `expiration_date` DATE COMMENT 'The date when this regulatory requirement ceased to apply to this service offering (e.g., offering discontinued, regulation superseded, or scope changed). Null for active compliance obligations.',
    `last_audit_date` DATE COMMENT 'The date of the most recent compliance audit or assessment conducted for this offering-requirement pairing. Used to track audit frequency and schedule next reviews.',
    `last_updated_by` STRING COMMENT 'User or system identifier that last updated this compliance mapping record.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this compliance mapping record.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next compliance audit or review of this offering-requirement pairing, calculated based on compliance_frequency from the regulatory requirement and last audit results.',
    `non_compliance_risk_level` STRING COMMENT 'Risk severity classification for non-compliance with this requirement for this offering (Critical, High, Medium, Low), considering potential penalties, operational impact, and reputational risk.',
    `responsible_party` STRING COMMENT 'The individual, role, or department responsible for ensuring compliance with this regulatory requirement for this specific service offering (e.g., Environmental Compliance Manager, Operations Director - Hazmat Services, employee ID).',
    `created_by` STRING COMMENT 'User or system identifier that created this compliance mapping record.',
    CONSTRAINT pk_offering_compliance PRIMARY KEY(`offering_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between service offerings and regulatory requirements in waste management operations. It captures the Service Compliance Matrix — tracking which regulatory requirements apply to which service offerings, the compliance status of each pairing, audit history, and responsible parties. Each record links one offering to one regulatory requirement with attributes that exist only in the context of this specific compliance obligation.. Existence Justification: In waste management operations, a single service offering must comply with multiple regulatory requirements simultaneously (e.g., hazardous waste collection complies with DOT 49 CFR transport rules, EPA RCRA handling requirements, OSHA 1910.120 worker safety standards, and state-specific regulations). Conversely, a single regulatory requirement applies to multiple service offerings (e.g., DOT hazmat transport rules apply to all hazmat collection services, medical waste services, and industrial waste services). The compliance team actively manages the Service Compliance Matrix as an operational artifact, tracking compliance status, conducting audits, maintaining documentation, and assigning responsible parties for each offering-requirement pairing.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Unique identifier for the employee-to-service-offering assignment record. Primary key.',
    `assigned_by_employee_id` BIGINT COMMENT 'Employee identifier of the manager or supervisor who authorized this assignment. Used for audit trail and accountability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who is assigned to deliver the service offering',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the service offering that the employee is assigned to deliver',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees working time allocated to this service offering. Used for capacity planning, labor cost allocation, and workload balancing. Sum across all active assignments for an employee should not exceed 100%.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment indicating whether the employee is currently authorized to deliver this service offering. Values: Active, Inactive, Suspended, Pending Certification, Expired.',
    `certification_expiration_date` DATE COMMENT 'Expiration date of the certification required for this service offering assignment. Used for compliance monitoring and proactive recertification scheduling. Null if no certification required.',
    `certification_number` STRING COMMENT 'Certification or license number specific to this service offering assignment (e.g., hazmat certification number, medical waste handler ID). Null if no certification required.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether this assignment requires specific certifications or licenses (e.g., hazmat handling, medical waste transport). Used for compliance monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment record was created. Used for audit trail.',
    `end_date` DATE COMMENT 'Date when the employee assignment to this service offering ended or the qualification expired. Null for active assignments. Used for historical tracking and compliance auditing.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment record was last modified. Used for audit trail and change tracking.',
    `primary_flag` BOOLEAN COMMENT 'Indicates whether this service offering is the employees primary assignment or specialty. Used for workforce planning and scheduling prioritization.',
    `proficiency_level` STRING COMMENT 'Employees proficiency or skill level for delivering this specific service offering. Used for route assignment optimization, quality assurance, and training needs assessment. Values: Trainee, Qualified, Proficient, Expert, Master.',
    `reason` STRING COMMENT 'Business reason or context for this assignment (e.g., Cross-training, Seasonal demand, Permanent transfer, Certification renewal). Used for workforce analytics.',
    `start_date` DATE COMMENT 'Date when the employee was assigned to or became qualified to deliver this service offering. Used for compliance tracking and workforce planning.',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'This association product represents the Assignment between offering and employee. It captures the operational assignment of employees to specific service offerings they are qualified and authorized to deliver. Each record links one offering to one employee with attributes that exist only in the context of this assignment relationship, including proficiency levels, assignment dates, and allocation percentages for workforce planning and compliance tracking.. Existence Justification: In Waste Management operations, employees are cross-trained and assigned to deliver multiple service offerings (e.g., a CDL driver may handle residential curbside, commercial FEL, and roll-off services), and each service offering requires multiple employees with different roles and proficiency levels (e.g., medical waste service requires dedicated technicians, drivers, and supervisors). The business actively manages these assignments with proficiency tracking, certification requirements, allocation percentages, and assignment dates for workforce planning, compliance, and route optimization.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` (
    `offering_safety_compliance_id` BIGINT COMMENT 'Unique identifier for this offering-safety program compliance record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the EHS employee responsible for monitoring and maintaining compliance of this specific offering with this specific safety program. May differ from the program owner for specialized offerings.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the waste management service offering that must comply with the safety program',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to the occupational health and safety program with which the offering must comply',
    `audit_frequency_override` STRING COMMENT 'Override value in months for audit frequency specific to this offering-program combination. When set, overrides the default audit_frequency_months from the safety_program. Used when certain high-risk offerings require more frequent audits for specific programs.',
    `certification_date` DATE COMMENT 'Date when this service offering was certified as compliant with this safety program. Null if not yet certified.',
    `certification_expiry_date` DATE COMMENT 'Date when the compliance certification for this offering-program combination expires and requires renewal. Null for programs without expiration.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance issues, remediation actions, waiver justifications, or special conditions for this offering-program relationship.',
    `compliance_status` STRING COMMENT 'Current compliance status of this service offering with respect to this specific safety program. Tracks whether the offering meets all program requirements.',
    `effective_date` DATE COMMENT 'Date when this service offering became subject to this safety program. Used to track when compliance requirements were imposed.',
    `last_compliance_review_date` DATE COMMENT 'Most recent date when compliance of this service offering with this safety program was formally reviewed by EHS staff or auditors. Used to track review currency.',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next formal compliance review of this offering-program combination. Calculated based on last review date and audit frequency.',
    `termination_date` DATE COMMENT 'Date when this service offering was no longer subject to this safety program (e.g., offering discontinued, program superseded, regulatory exemption granted). Null for active compliance relationships.',
    `training_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of employees working on this service offering who have completed the required training for this safety program. Calculated as (trained_employees / total_employees_on_offering) * 100.',
    CONSTRAINT pk_offering_safety_compliance PRIMARY KEY(`offering_safety_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between waste management service offerings and formal occupational health and safety programs. It captures the regulatory and operational requirement for each service offering to comply with specific safety programs, tracking certification status, audit schedules, and training completion. Each record links one offering to one safety_program with attributes that exist only in the context of this compliance relationship.. Existence Justification: In waste management operations, service offerings must comply with multiple safety programs based on the nature of the service (e.g., hazardous waste collection requires OSHA Hazmat, DOT, EPA RCRA, and state-specific programs), and each safety program applies to multiple service offerings across residential, commercial, and specialty services. The business actively manages this compliance relationship through certification tracking, audit scheduling, training completion monitoring, and status reporting—operations managers monitor program compliance across their service portfolio while safety managers track offering coverage across programs.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`disposal_network` (
    `disposal_network_id` BIGINT COMMENT 'Unique identifier for this service area to landfill site disposal network configuration record. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to the service area being configured for disposal routing',
    `employee_id` BIGINT COMMENT 'Identifier of the operations manager or district supervisor who approved this disposal network configuration. Required for audit trail and accountability in routing strategy decisions.',
    `site_id` BIGINT COMMENT 'Foreign key linking to the landfill site designated for this service area',
    `approval_date` DATE COMMENT 'Date on which this disposal network configuration was formally approved by operations management. Used for compliance tracking and change management audit.',
    `average_haul_distance_miles` DECIMAL(18,2) COMMENT 'Typical one-way distance in miles from the service area centroid to the landfill site. Used for route planning, fuel cost estimation, and disposal cost allocation. Updated periodically based on actual route data.',
    `configuration_status` STRING COMMENT 'Current operational status of this disposal network configuration. Active configurations are in use for routing decisions. Suspended configurations are temporarily inactive but may be reactivated. Planned configurations are approved but not yet effective. Retired configurations are historical records.',
    `designation_type` STRING COMMENT 'Classification of the sites role in serving this service area. Primary sites receive the majority of tonnage under normal operations. Secondary sites provide overflow capacity. Backup sites are used when primary is unavailable. Seasonal sites handle peak volume periods. Emergency sites are contingency options.',
    `effective_end_date` DATE COMMENT 'Date on which this service area to site routing configuration was discontinued. Null for currently active configurations. Used to maintain historical disposal network records for cost analysis and compliance reporting.',
    `effective_start_date` DATE COMMENT 'Date on which this service area to site routing configuration became active. Used to track historical changes in disposal network strategy and support time-based routing decisions.',
    `estimated_annual_tonnage` DECIMAL(18,2) COMMENT 'Projected annual tonnage in short tons expected to be disposed from this service area to this site under normal operating conditions. Used for site capacity planning, host community agreement compliance, and financial forecasting. Updated annually during budget planning cycles.',
    `notes` STRING COMMENT 'Free-text field for operational notes regarding this service area to site configuration. May include seasonal restrictions, weight limits, waste type restrictions, or special routing instructions.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the preference order for routing loads from this service area to available sites. Lower numbers indicate higher priority. Used by route optimization systems to determine disposal destination when multiple sites are available.',
    CONSTRAINT pk_disposal_network PRIMARY KEY(`disposal_network_id`)
) COMMENT 'This association product represents the operational disposal network configuration between service areas and landfill sites. It captures the multi-site disposal strategy for each service area, including primary and backup site designations, routing priorities, haul distance logistics, and tonnage allocation planning. Each record links one service area to one landfill site with attributes that govern route optimization, capacity planning, and disposal cost management. This is actively managed by operations teams to balance site capacity utilization, minimize haul costs, and ensure disposal continuity.. Existence Justification: In waste management operations, service areas require multi-site disposal strategies for operational resilience and capacity management. A service area routes waste to multiple landfill sites (primary for daily operations, secondary for overflow, backup for contingencies, seasonal for peak periods), and each landfill site receives waste from multiple service areas based on geographic proximity and capacity availability. Operations teams actively manage these disposal network configurations, adjusting site designations, priority rankings, and tonnage allocations based on site capacity, haul economics, and franchise agreement requirements.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` (
    `area_regulatory_compliance_id` BIGINT COMMENT 'Primary key for the area_regulatory_compliance association',
    `area_id` BIGINT COMMENT 'Foreign key linking to the service area subject to this regulatory requirement',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance manager or regulatory affairs officer responsible for ensuring compliance with this requirement in this service area.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement applicable to this service area',
    `compliance_status` STRING COMMENT 'The current compliance status for this specific requirement in this specific service area. Tracks whether the company is meeting its obligations for this area-requirement combination.',
    `effective_date` DATE COMMENT 'The date on which this regulatory requirement became applicable to this specific service area. May differ from the regulations general effective_date due to phased rollout, franchise agreement terms, or jurisdictional adoption timing.',
    `enforcement_authority` STRING COMMENT 'The name of the specific regulatory agency or local enforcement authority responsible for enforcing this requirement in this service area. May be the LEA (Local Enforcement Agency), county health department, state environmental agency, or EPA regional office depending on jurisdiction.',
    `inspection_frequency` STRING COMMENT 'The required frequency of inspections or compliance audits for this requirement in this service area. Frequency may vary by jurisdiction even for the same underlying regulation.',
    `jurisdiction_level` STRING COMMENT 'The specific jurisdictional level at which this requirement applies to this service area (Federal, State, County, Municipal, Local). A service area may be subject to the same requirement at multiple jurisdictional levels with different enforcement authorities.',
    `last_inspection_date` DATE COMMENT 'The date of the most recent inspection or compliance audit conducted by the enforcement authority for this requirement in this service area.',
    `next_inspection_due_date` DATE COMMENT 'The date by which the next inspection or compliance verification is due for this requirement in this service area.',
    `notes` STRING COMMENT 'Free-text notes documenting area-specific compliance considerations, enforcement history, corrective actions, or special conditions for this requirement in this service area.',
    `reporting_deadline` STRING COMMENT 'The specific reporting deadline or schedule for compliance reporting to the enforcement authority for this service area. May be expressed as a date, day-of-month, or relative deadline (e.g., 30 days after quarter end).',
    `waiver_expiration_date` DATE COMMENT 'The date on which any granted waiver or exemption expires, after which full compliance is required.',
    `waiver_granted` BOOLEAN COMMENT 'Indicates whether a waiver or exemption has been granted for this requirement in this service area. Waivers may be granted due to franchise agreement terms, operational constraints, or alternative compliance methods.',
    CONSTRAINT pk_area_regulatory_compliance PRIMARY KEY(`area_regulatory_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between service_area and regulatory_requirement. It captures the jurisdiction-specific regulatory obligations that apply to each geographic service territory. Each record links one service area to one regulatory requirement with enforcement details, inspection schedules, and compliance tracking attributes that exist only in the context of this territorial compliance relationship. Used by regulatory affairs to manage area-specific compliance obligations and by operations to ensure service delivery meets all applicable regulatory standards.. Existence Justification: In waste management operations, each service area is subject to multiple regulatory requirements from different jurisdictional levels (federal EPA rules, state environmental codes, county solid waste plans, municipal ordinances). Conversely, each regulatory requirement applies to multiple service areas across different geographic territories. The business actively manages this territorial compliance register, tracking jurisdiction-specific enforcement authorities, inspection schedules, reporting deadlines, and compliance status for each area-requirement combination.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`bundle_composition` (
    `bundle_composition_id` BIGINT COMMENT 'Unique identifier for this bundle composition record. Primary key.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to the service bundle that contains this offering as a component',
    `offering_id` BIGINT COMMENT 'Foreign key to offering. Identifies which service offering is included as a component in this bundle.',
    `service_bundle_id` BIGINT COMMENT 'Foreign key to service_bundle. Identifies which bundle this composition record belongs to.',
    `bundle_price_override` DECIMAL(18,2) COMMENT 'Bundle-specific price override for this offering component. Null if standard offering price applies. Allows bundle-specific pricing that differs from standalone offering price. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bundle composition record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this offering was or will be removed from this bundle composition. Null for currently active components. Supports historical tracking of bundle changes. Explicitly identified in detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'Date when this offering became or will become part of this bundle composition. Supports versioning of bundle configurations over time. Explicitly identified in detection phase relationship data.',
    `inclusion_type` STRING COMMENT 'Classification of how this offering is included in the bundle: included (part of base bundle), add-on (additional charge), optional (customer choice), discounted (reduced price). Derived from service_bundle.bundle_description mention of included, add-on, discounted.',
    `is_primary_service_flag` BOOLEAN COMMENT 'Indicates whether this offering is the primary/anchor service in the bundle versus an add-on or supplementary service. Explicitly identified in detection phase relationship data.',
    `quantity` STRING COMMENT 'Number of units of this offering included in the bundle (e.g., 2 carts, 1 dumpster). Explicitly identified in detection phase relationship data.',
    `sequence_number` STRING COMMENT 'Display order or sequence position of this offering within the bundle for presentation and documentation purposes. Explicitly identified in detection phase relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this bundle composition record was last modified.',
    CONSTRAINT pk_bundle_composition PRIMARY KEY(`bundle_composition_id`)
) COMMENT 'This association product represents the composition relationship between service bundles and their component offerings. It captures which individual service offerings are included in each bundle package, along with bundle-specific configuration and pricing details. Each record links one service bundle to one component offering with attributes that define how that offering is packaged, priced, and delivered within the bundle context.. Existence Justification: Service bundles are packaged combinations of multiple individual service offerings (e.g., residential collection + recycling cart + yard waste pickup), and individual offerings can be components of multiple different bundles. The business actively manages bundle composition as a core product catalog function, tracking which offerings are included in which bundles with bundle-specific configuration (quantity, pricing overrides, inclusion type, sequence). This is an operational business entity that product managers create, version, and maintain as part of service packaging strategy.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_code_id` FOREIGN KEY (`code_id`) REFERENCES `waste_management_ecm`.`service`.`code`(`code_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`service`.`line` ADD CONSTRAINT `fk_service_line_parent_service_line_id` FOREIGN KEY (`parent_service_line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`service`.`code` ADD CONSTRAINT `fk_service_code_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`service`.`code` ADD CONSTRAINT `fk_service_code_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`service`.`code` ADD CONSTRAINT `fk_service_code_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`service`.`code` ADD CONSTRAINT `fk_service_code_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ADD CONSTRAINT `fk_service_container_type_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_superseded_by_schedule_service_rate_schedule_id` FOREIGN KEY (`superseded_by_schedule_service_rate_schedule_id`) REFERENCES `waste_management_ecm`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ADD CONSTRAINT `fk_service_bundle_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ADD CONSTRAINT `fk_service_bundle_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ADD CONSTRAINT `fk_service_bundle_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ADD CONSTRAINT `fk_service_srf_product_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `waste_management_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ADD CONSTRAINT `fk_service_surcharge_definition_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ADD CONSTRAINT `fk_service_restriction_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ADD CONSTRAINT `fk_service_restriction_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ADD CONSTRAINT `fk_service_restriction_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ADD CONSTRAINT `fk_service_restriction_restriction_offering_id` FOREIGN KEY (`restriction_offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_parent_eligibility_rule_id` FOREIGN KEY (`parent_eligibility_rule_id`) REFERENCES `waste_management_ecm`.`service`.`eligibility_rule`(`eligibility_rule_id`);
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ADD CONSTRAINT `fk_service_pricing_tier_service_rate_schedule_id` FOREIGN KEY (`service_rate_schedule_id`) REFERENCES `waste_management_ecm`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ADD CONSTRAINT `fk_service_pricing_tier_parent_pricing_tier_id` FOREIGN KEY (`parent_pricing_tier_id`) REFERENCES `waste_management_ecm`.`service`.`pricing_tier`(`pricing_tier_id`);
ALTER TABLE `waste_management_ecm`.`service`.`channel` ADD CONSTRAINT `fk_service_channel_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`service`.`channel` ADD CONSTRAINT `fk_service_channel_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`service`.`channel` ADD CONSTRAINT `fk_service_channel_parent_channel_id` FOREIGN KEY (`parent_channel_id`) REFERENCES `waste_management_ecm`.`service`.`channel`(`channel_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_parent_territory_id` FOREIGN KEY (`parent_territory_id`) REFERENCES `waste_management_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ADD CONSTRAINT `fk_service_offering_compliance_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ADD CONSTRAINT `fk_service_assignment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ADD CONSTRAINT `fk_service_offering_safety_compliance_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ADD CONSTRAINT `fk_service_disposal_network_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ADD CONSTRAINT `fk_service_area_regulatory_compliance_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ADD CONSTRAINT `fk_service_bundle_composition_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `waste_management_ecm`.`service`.`bundle`(`bundle_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ADD CONSTRAINT `fk_service_bundle_composition_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ADD CONSTRAINT `fk_service_bundle_composition_service_bundle_id` FOREIGN KEY (`service_bundle_id`) REFERENCES `waste_management_ecm`.`service`.`bundle`(`bundle_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`service` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `waste_management_ecm`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `waste_management_ecm`.`service`.`offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`service`.`offering` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `code_id` SET TAGS ('dbx_business_glossary_term' = 'Service Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Default Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Default Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `emission_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Required Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Required Certification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `amcs_service_code` SET TAGS ('dbx_business_glossary_term' = 'AMCS Platform Service Code');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `base_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Price Amount');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `base_price_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `cancellation_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Period (Days)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `carbon_offset_eligible` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Eligible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `diversion_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Target (Percentage)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Code');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_value_regex' = '^[DKPUF][0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued|seasonal|pilot');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `minimum_contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Contract Term (Months)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `oracle_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle Revenue Management Rate Code');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `oracle_rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `pricing_unit` SET TAGS ('dbx_business_glossary_term' = 'Pricing Unit');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'non_regulated|rcra_regulated|dot_regulated|tsdf_required|universal_waste|state_regulated');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `requires_customer_training` SET TAGS ('dbx_business_glossary_term' = 'Requires Customer Training Flag');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `requires_manifest` SET TAGS ('dbx_business_glossary_term' = 'Requires Manifest Flag');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `requires_site_assessment` SET TAGS ('dbx_business_glossary_term' = 'Requires Site Assessment Flag');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `requires_special_permit` SET TAGS ('dbx_business_glossary_term' = 'Requires Special Permit Flag');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `salesforce_product_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Customer Relationship Management (CRM) Product Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `salesforce_product_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{18}$');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `sap_sd_condition_type` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Condition Type');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `sap_sd_condition_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `sap_sd_material_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Material Number');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `sap_sd_material_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `service_area_restriction` SET TAGS ('dbx_business_glossary_term' = 'Service Area Restriction');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|specialty');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `sustainability_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Program Flag');
ALTER TABLE `waste_management_ecm`.`service`.`line` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`line` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `parent_service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Line Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `job_position_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Job Position Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `base_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Base Price United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `base_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `business_unit` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|institutional');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `carbon_offset_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Eligible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `collection_frequency_standard` SET TAGS ('dbx_business_glossary_term' = 'Collection Frequency Standard');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `collection_frequency_standard` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand|scheduled_event');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `container_type_category` SET TAGS ('dbx_business_glossary_term' = 'Container Type Category');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `contract_template_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Template Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `contract_template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `customer_portal_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Portal Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `diversion_rate_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Target Percent');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `dot_hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazardous Materials (HAZMAT) Class');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `driver_cdl_requirement` SET TAGS ('dbx_business_glossary_term' = 'Driver Commercial Driver License (CDL) Requirement');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `driver_cdl_requirement` SET TAGS ('dbx_value_regex' = 'none|class_a|class_b|class_c|hazmat_endorsement');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `epa_waste_code_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Code Category');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `fleet_type_requirement` SET TAGS ('dbx_business_glossary_term' = 'Fleet Type Requirement');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `ghg_reduction_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Reduction Contribution Flag');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `insurance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Flag');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `permit_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Requirement Flag');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `ppe_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirement Level');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `ppe_requirement_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|hazmat|specialized');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|usage_based|weight_based|volume_based|hybrid');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `profit_margin_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin Target Percent');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `profit_margin_target_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'msw|hazardous|universal_waste|special_waste|recyclable|non_regulated');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `revenue_account_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Account Code');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `revenue_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'subscription|transactional|project_based|contract|event_based');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `route_optimization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Eligible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `service_line_code` SET TAGS ('dbx_business_glossary_term' = 'Service Line Code');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `service_line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `service_line_description` SET TAGS ('dbx_business_glossary_term' = 'Service Line Description');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `service_line_name` SET TAGS ('dbx_business_glossary_term' = 'Service Line Name');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `service_line_status` SET TAGS ('dbx_business_glossary_term' = 'Service Line Status');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `service_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pilot|sunset|seasonal');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `service_line_type` SET TAGS ('dbx_business_glossary_term' = 'Service Line Type');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `service_line_type` SET TAGS ('dbx_value_regex' = 'collection|disposal|recycling|specialty|energy_recovery|consulting');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `sustainability_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Program Flag');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `training_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Training Certification Required');
ALTER TABLE `waste_management_ecm`.`service`.`code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`code` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `code_id` SET TAGS ('dbx_business_glossary_term' = 'Service Code ID');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `container_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Required Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `base_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `cogs_account` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Account');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `cogs_account` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `container_size` SET TAGS ('dbx_business_glossary_term' = 'Container Size');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `customer_portal_visible_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Portal Visible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `diversion_credit_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversion Credit Eligible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `dot_hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazardous Materials (Hazmat) Class');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `epa_waste_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Category');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'asl|rel|fel|roll_off|compactor|vacuum');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `ghg_reduction_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Reduction Eligible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `gl_revenue_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Revenue Account');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `gl_revenue_account` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `manifest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Manifest Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `minimum_service_term_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Service Term (Months)');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `oracle_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle Rate Code');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `pickup_days_per_week` SET TAGS ('dbx_business_glossary_term' = 'Pickup Days Per Week');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|per_pickup|per_ton|per_yard|tiered|usage_based');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'per_month|per_pickup|per_ton|per_yard|per_gallon|per_event');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `rcra_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Waste Code');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'non_regulated|rcra_regulated|tsdf|universal_waste|hazmat');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `sap_sd_condition_type` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Condition Type');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|special_event|temporary');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|discontinued|pending_approval');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'collection|recycling|disposal|hazardous_waste|wte|composting');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `sustainability_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Program Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Capacity in Cubic Yards');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Capacity in Gallons');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `certification_standards` SET TAGS ('dbx_business_glossary_term' = 'Certification Standards');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `color_standard` SET TAGS ('dbx_business_glossary_term' = 'Color Standard');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `commercial_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Use Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `compaction_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Compaction Capable Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `compaction_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compaction Ratio');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `container_category` SET TAGS ('dbx_business_glossary_term' = 'Container Category');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `container_category` SET TAGS ('dbx_value_regex' = 'dumpster|roll_off|residential_cart|recycling_bin|compactor|specialty');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `container_type_code` SET TAGS ('dbx_business_glossary_term' = 'Container Type Code');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `container_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `container_type_name` SET TAGS ('dbx_business_glossary_term' = 'Container Type Name');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `container_type_status` SET TAGS ('dbx_business_glossary_term' = 'Container Type Status');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `container_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_approval');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `dot_hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazardous Material (HAZMAT) Class');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `estimated_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Estimated Useful Life in Years');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `gps_tracking_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Tracking Compatible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Certified Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `industrial_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Industrial Use Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `leak_proof_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Proof Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `lid_type` SET TAGS ('dbx_business_glossary_term' = 'Lid Type');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `lid_type` SET TAGS ('dbx_value_regex' = 'hinged|attached|detached|sliding|none');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `lift_mechanism_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Lift Mechanism Compatibility');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `lift_mechanism_compatibility` SET TAGS ('dbx_value_regex' = 'asl|fel|rel|manual|hook_lift|cable_hoist');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `maintenance_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval in Months');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `material_construction` SET TAGS ('dbx_business_glossary_term' = 'Material Construction');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `material_construction` SET TAGS ('dbx_value_regex' = 'steel|plastic|aluminum|composite|fiberglass');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Container Type Notes');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `purchase_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Purchase Eligible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `rental_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rental Eligible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `residential_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Residential Use Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `rfid_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Compatible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `service_frequency_default` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency Default');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `service_frequency_default` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand|event_based');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `standard_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit Cost');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `standard_unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `tare_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight in Pounds (lbs)');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `un_packaging_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Packaging Code');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `un_packaging_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[A-Z]{1,2}[0-9]{0,3}$');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `weather_resistant_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Resistant Flag');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity in Pounds (lbs)');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `wheel_configuration` SET TAGS ('dbx_business_glossary_term' = 'Wheel Configuration');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `wheel_configuration` SET TAGS ('dbx_value_regex' = 'two_wheel|four_wheel|stationary|none');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Renewal Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency Cycle');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'per_pickup|weekly|monthly|quarterly|annually');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `cancellation_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Period (Days)');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `extra_pickup_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Extra Pickup Allowed Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `frequency_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Status');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `frequency_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval|suspended');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `frequency_type` SET TAGS ('dbx_business_glossary_term' = 'Pickup Frequency Type');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `frequency_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|bi_weekly|monthly|on_call|event_based');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `friday_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Friday Service Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `holiday_adjustment_rule` SET TAGS ('dbx_business_glossary_term' = 'Holiday Service Adjustment Rule');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `holiday_adjustment_rule` SET TAGS ('dbx_value_regex' = 'no_service|next_business_day|prior_business_day|same_day|customer_choice');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `maximum_commitment_period` SET TAGS ('dbx_business_glossary_term' = 'Maximum Service Commitment Period (Months)');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `maximum_skips_per_year` SET TAGS ('dbx_business_glossary_term' = 'Maximum Service Skips Per Year');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `minimum_commitment_period` SET TAGS ('dbx_business_glossary_term' = 'Minimum Service Commitment Period (Months)');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `monday_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Monday Service Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Notes');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `period_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Period Unit');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `period_unit` SET TAGS ('dbx_value_regex' = 'day|week|month|quarter|year');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `pickups_per_period` SET TAGS ('dbx_business_glossary_term' = 'Number of Pickups Per Period');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Code');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Description');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Name');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `proration_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Proration Allowed Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `saturday_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Saturday Service Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type Classification');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|roll_off|recycling');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `service_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Service Window End Time');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `service_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Window Start Time');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `skip_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Skip Allowed Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `sunday_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunday Service Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `thursday_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Thursday Service Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `tuesday_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Tuesday Service Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Version Number');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `wednesday_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Wednesday Service Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` SET TAGS ('dbx_subdomain' = 'pricing_configuration');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule ID');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `superseded_by_schedule_service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule ID');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `base_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `base_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Unit of Measure');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `contamination_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Contamination Surcharge');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `contamination_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contamination Threshold Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|institutional|special_event');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `environmental_fee_method` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee Calculation Method');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `environmental_fee_method` SET TAGS ('dbx_value_regex' = 'fixed_amount|percentage|none');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `environmental_recovery_fee` SET TAGS ('dbx_business_glossary_term' = 'Environmental Recovery Fee');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `fuel_index_adjustment_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Adjustment Rate');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `fuel_index_threshold` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Threshold Price');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `fuel_surcharge_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Base Amount');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `fuel_surcharge_method` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Calculation Method');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `fuel_surcharge_method` SET TAGS ('dbx_value_regex' = 'fixed_amount|percentage|index_linked|none');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `fuel_surcharge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `minimum_service_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Service Charge');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Notes');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `overweight_fee` SET TAGS ('dbx_business_glossary_term' = 'Overweight Fee');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `rate_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Status');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|superseded');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `rate_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version Number');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `regulatory_compliance_fee` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Fee');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `sales_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Sales Tax Rate');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `standard_weight_limit` SET TAGS ('dbx_business_glossary_term' = 'Standard Weight Limit');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `tax_inclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive Flag');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `tipping_fee_method` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Calculation Method');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `tipping_fee_method` SET TAGS ('dbx_value_regex' = 'fixed_per_ton|actual_cost|included_in_base|none');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `tipping_fee_passthrough` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Pass-Through Amount');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'tons|pounds|kilograms');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Service Bundle Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Default Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Bundle Approval Status');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Bundle Base Price');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `bundle_category` SET TAGS ('dbx_business_glossary_term' = 'Service Bundle Category');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `bundle_category` SET TAGS ('dbx_value_regex' = 'collection|recycling|disposal|hazmat|wte|comprehensive');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_business_glossary_term' = 'Service Bundle Code');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `bundle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `bundle_description` SET TAGS ('dbx_business_glossary_term' = 'Service Bundle Description');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `bundle_name` SET TAGS ('dbx_business_glossary_term' = 'Service Bundle Name');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_business_glossary_term' = 'Service Bundle Type');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `bundle_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|specialty|promotional');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `cancellation_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Period (Days)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `container_quantity` SET TAGS ('dbx_business_glossary_term' = 'Container Quantity');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Bundle Discount Amount');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bundle Discount Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `diversion_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Target Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Bundle Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Bundle Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Bundle Eligibility Criteria');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `ghg_reduction_co2e_tons` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Reduction Carbon Dioxide Equivalent (CO2e) Tons');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Bundle Lifecycle Status');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|discontinued|archived');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Code');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `minimum_contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Contract Term (Months)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Bundle Notes');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Bundle Pricing Model');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|component_sum|discounted_sum|tiered|custom');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `product_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Name');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `promotion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `promotion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Bundle Flag');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|partner|online|call_center|field_sales');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time (Hours)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `sustainability_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Bundle Version Number');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Service Waste Stream ID');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `emission_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `accepted_container_types` SET TAGS ('dbx_business_glossary_term' = 'Accepted Container Types');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `commodity_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Commodity Value Flag');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `compaction_ratio_avg` SET TAGS ('dbx_business_glossary_term' = 'Average Compaction Ratio');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `compostable_flag` SET TAGS ('dbx_business_glossary_term' = 'Compostable Flag');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `contamination_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contamination Threshold Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `density_lbs_per_cubic_yard` SET TAGS ('dbx_business_glossary_term' = 'Density (Pounds per Cubic Yard)');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `disposal_pathway` SET TAGS ('dbx_business_glossary_term' = 'Disposal Pathway');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `disposal_pathway` SET TAGS ('dbx_value_regex' = 'Landfill|MRF|WTE|TSDF|Composting|Recycling');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `diversion_credit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Diversion Credit Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `diversion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversion Eligible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Code');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_value_regex' = '^[DFKPU][0-9]{3}$|^$');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `ghg_emission_factor_co2e_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emission Factor (Carbon Dioxide Equivalent - CO2e per Ton)');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `manifest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Manifest Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `rcra_subtitle` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Subtitle');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `rcra_subtitle` SET TAGS ('dbx_value_regex' = 'C|D|N/A');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `recyclable_flag` SET TAGS ('dbx_business_glossary_term' = 'Recyclable Flag');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `regulatory_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notes');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `seasonal_variation_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Variation Flag');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `special_handling_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Subcategory');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `tclp_testing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Toxicity Characteristic Leaching Procedure (TCLP) Testing Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$|^$');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `waste_stream_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Category');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `waste_stream_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Code');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `waste_stream_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `waste_stream_name` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Name');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `waste_stream_status` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Status');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `waste_stream_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Restricted|Phased Out');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `wte_feedstock_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste-to-Energy (WTE) Feedstock Flag');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `srf_product_id` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Product ID');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility ID');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Production Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Source Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `srf_production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Srf Production Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `ash_content_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Ash Content (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `ash_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Content (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `bulk_density_kg_m3` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density (Kilograms per Cubic Meter)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `cadmium_content_max_mg_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cadmium Content (Milligrams per Kilogram)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `cadmium_content_mg_kg` SET TAGS ('dbx_business_glossary_term' = 'Cadmium Content (Milligrams per Kilogram)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `calorific_value_max_mj_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Net Calorific Value (Megajoules per Kilogram)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `calorific_value_min_mj_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Net Calorific Value (Megajoules per Kilogram)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `calorific_value_mj_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Calorific Value (Megajoules per Kilogram)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `chlorine_content_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Chlorine Content (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `chlorine_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Chlorine Content (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `en_15359_class` SET TAGS ('dbx_business_glossary_term' = 'EN 15359 Classification Code');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `lead_content_max_mg_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lead Content (Milligrams per Kilogram)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `lead_content_mg_kg` SET TAGS ('dbx_business_glossary_term' = 'Lead Content (Milligrams per Kilogram)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `mercury_content_max_mg_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Mercury Content (Milligrams per Kilogram)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `mercury_content_mg_kg` SET TAGS ('dbx_business_glossary_term' = 'Mercury Content (Milligrams per Kilogram)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `moisture_content_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Moisture Content (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `particle_size_max_mm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Particle Size (Millimeters)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `particle_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Particle Size (Millimeters)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Product Code');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^SRF-[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Product Grade');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `product_grade` SET TAGS ('dbx_value_regex' = 'premium|standard|industrial|utility|custom');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Product Name');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `product_status` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Product Status');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `product_status` SET TAGS ('dbx_value_regex' = 'active|inactive|development|discontinued|suspended|certified');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `quality_standard` SET TAGS ('dbx_value_regex' = 'EN_15359|ASTM_E2617|ISO_21640|custom');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `safety_data_sheet_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) URL');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `sulfur_content_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Sulfur Content (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `waste_management_ecm`.`service`.`srf_product` ALTER COLUMN `technical_data_sheet_url` SET TAGS ('dbx_business_glossary_term' = 'Technical Data Sheet URL');
ALTER TABLE `waste_management_ecm`.`service`.`area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`service`.`area` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `circular_economy_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'Operational District Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Landfill Facility Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `primary_mrf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Materials Recovery Facility (MRF) Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Required Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Manager Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Service Area Code');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `area_name` SET TAGS ('dbx_business_glossary_term' = 'Service Area Name');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `area_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|mixed|rural|urban');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `census_tract_list` SET TAGS ('dbx_business_glossary_term' = 'Census Tract List');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `commercial_account_count` SET TAGS ('dbx_business_glossary_term' = 'Commercial Account Count');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_business_glossary_term' = 'County Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `diversion_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Target Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Expiration Date');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `geographic_boundary_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Well-Known Text (WKT)');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `gps_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'GPS Tracking Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `hazmat_collection_available` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Collection Available Flag');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `household_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Household Count Estimate');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `lea_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Local Enforcement Agency (LEA) Name');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `municipality_code` SET TAGS ('dbx_business_glossary_term' = 'Municipality Code');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `municipality_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Area Notes');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|discontinued');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `organics_program_available` SET TAGS ('dbx_business_glossary_term' = 'Organics Program Available Flag');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Number');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Population Estimate');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `recycling_program_available` SET TAGS ('dbx_business_glossary_term' = 'Recycling Program Available Flag');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `route_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `service_frequency_residential` SET TAGS ('dbx_business_glossary_term' = 'Residential Service Frequency');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `service_frequency_residential` SET TAGS ('dbx_value_regex' = 'once_weekly|twice_weekly|biweekly|on_demand');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `square_miles` SET TAGS ('dbx_business_glossary_term' = 'Service Area Square Miles');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code List');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` SET TAGS ('dbx_subdomain' = 'operational_standards');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition ID');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `job_position_id` SET TAGS ('dbx_business_glossary_term' = 'Required Job Position Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering ID');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `auto_credit_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Credit Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `complaint_resolution_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Complaint Resolution Window (Hours)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `container_delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Container Delivery Lead Time (Days)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `container_pickup_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Container Pickup Lead Time (Days)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `escalation_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold (Hours)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Exclusions');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `late_delivery_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Delivery Penalty Amount');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `late_delivery_penalty_pct` SET TAGS ('dbx_business_glossary_term' = 'Late Delivery Penalty (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `missed_pickup_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Missed Pickup Credit Amount');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `missed_pickup_credit_pct` SET TAGS ('dbx_business_glossary_term' = 'Missed Pickup Credit (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `notification_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `on_time_service_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Service Rate Target (Percent)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time (Hours)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time (Hours)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `service_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Service Window End Time');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `service_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Window Start Time');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `service_window_tolerance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Window Tolerance (Minutes)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Description');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise|custom');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` SET TAGS ('dbx_subdomain' = 'pricing_configuration');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `surcharge_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Definition ID');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `applicable_container_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Container Types');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `applicable_geographic_zones` SET TAGS ('dbx_business_glossary_term' = 'Applicable Geographic Zones');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `applicable_service_lines` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Lines');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat_fee|percentage_of_base|index_linked|tiered|per_unit|weight_based');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `display_on_invoice_flag` SET TAGS ('dbx_business_glossary_term' = 'Display on Invoice Flag');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `index_formula` SET TAGS ('dbx_business_glossary_term' = 'Index Formula');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `index_source` SET TAGS ('dbx_business_glossary_term' = 'Index Source');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `invoice_line_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Description');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `notification_days_advance` SET TAGS ('dbx_business_glossary_term' = 'Notification Days in Advance');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `percentage_rate` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rate');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `proration_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Proration Allowed Flag');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `revenue_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Revenue Account Code');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `revenue_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `surcharge_category` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Category');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `surcharge_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Definition Status');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `surcharge_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|suspended');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `surcharge_description` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Description');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `waivable_flag` SET TAGS ('dbx_business_glossary_term' = 'Waivable Flag');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `waiver_approval_level` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Level');
ALTER TABLE `waste_management_ecm`.`service`.`surcharge_definition` ALTER COLUMN `waiver_approval_level` SET TAGS ('dbx_value_regex' = 'none|supervisor|manager|director|executive');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` SET TAGS ('dbx_subdomain' = 'operational_standards');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Service Restriction Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Required Jha Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Alternative Service Offering Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `affected_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Segment');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `affected_customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|all');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `amcs_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'AMCS Platform Restriction Flag');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `amcs_restriction_flag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `compliance_validation_rule` SET TAGS ('dbx_business_glossary_term' = 'Compliance Validation Rule');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Code');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_value_regex' = '^[DKPUF][0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `frequency_limit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Limit');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `notification_message` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Message');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `override_approval_role` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Role');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `override_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Override Authorization Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Restriction Reason');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Restriction Code');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_name` SET TAGS ('dbx_business_glossary_term' = 'Restriction Name');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_business_glossary_term' = 'Restriction Scope');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_value_regex' = 'full_exclusion|partial_limitation|conditional_approval|volume_cap|frequency_cap');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Restriction Status');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'geographic|customer_type|waste_stream|regulatory|operational|seasonal');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `salesforce_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Customer Relationship Management (CRM) Restriction Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `salesforce_restriction_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `sap_ehs_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Environmental Health and Safety (EHS) Restriction Code');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `seasonal_end_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal End Date (MM-DD)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `seasonal_start_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Start Date (MM-DD)');
ALTER TABLE `waste_management_ecm`.`service`.`restriction` ALTER COLUMN `volume_limit_tons` SET TAGS ('dbx_business_glossary_term' = 'Volume Limit in Tons');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` SET TAGS ('dbx_subdomain' = 'operational_standards');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Required Jha Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Required Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `parent_eligibility_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `compliance_validation_rule` SET TAGS ('dbx_business_glossary_term' = 'Compliance Validation Rule');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `container_type_restriction` SET TAGS ('dbx_business_glossary_term' = 'Container Type Restriction');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_business_glossary_term' = 'County Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|institutional|all');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Code');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `maximum_volume_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `maximum_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `minimum_volume_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `minimum_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Minimum Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `notification_message` SET TAGS ('dbx_business_glossary_term' = 'Notification Message');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `override_approval_role` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Role');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `override_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Override Authorization Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `permit_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Requirement Flag');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'non_hazardous|hazardous|universal_waste|special_waste|medical_waste');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'inclusion|exclusion|conditional');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'geographic|customer_segment|waste_stream|regulatory|operational|contractual');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `seasonal_end_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal End Date');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `seasonal_start_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `service_frequency_restriction` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency Restriction');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code List');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`eligibility_rule` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` SET TAGS ('dbx_subdomain' = 'pricing_configuration');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `pricing_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `parent_pricing_tier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `applicable_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segment');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `applicable_customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|institutional|all');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `applicable_service_area_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Area Codes');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `approval_role` SET TAGS ('dbx_business_glossary_term' = 'Approval Role');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `auto_downgrade_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Downgrade Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `auto_upgrade_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Upgrade Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN|EUR|GBP');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `diversion_rate_requirement_pct` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Requirement Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `gl_revenue_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Revenue Account Code');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `maximum_pickups_per_period` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pickups Per Period');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `maximum_volume_tons` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `minimum_commitment_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Months');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `minimum_pickups_per_period` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pickups Per Period');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `minimum_volume_tons` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `oracle_rate_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle Rate Tier Code');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `proration_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Proration Allowed Flag');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'per_ton|per_cubic_yard|per_pickup|per_month|per_container|flat_fee');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `sap_sd_condition_type` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Condition Type');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `sustainability_incentive_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Incentive Flag');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `tier_description` SET TAGS ('dbx_business_glossary_term' = 'Tier Description');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `tier_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier Rate Amount');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `tier_sequence` SET TAGS ('dbx_business_glossary_term' = 'Tier Sequence Number');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_business_glossary_term' = 'Tier Type');
ALTER TABLE `waste_management_ecm`.`service`.`pricing_tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_value_regex' = 'volume|commitment|frequency|hybrid|promotional|standard');
ALTER TABLE `waste_management_ecm`.`service`.`channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`service`.`channel` SET TAGS ('dbx_subdomain' = 'operational_standards');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Service Channel Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `parent_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `amcs_channel_code` SET TAGS ('dbx_business_glossary_term' = 'AMCS Platform Channel Code');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Renewal Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|per_service|arrears');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `cancellation_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Period in Days');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `cdl_requirement` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Requirement');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `cdl_requirement` SET TAGS ('dbx_value_regex' = 'none|class_c|class_b|class_a');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_business_glossary_term' = 'Service Channel Category');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_value_regex' = 'curbside|onsite|dropoff|project_based|event_based|subscription');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Service Channel Code');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_description` SET TAGS ('dbx_business_glossary_term' = 'Service Channel Description');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Service Channel Name');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Service Channel Status');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pilot|sunset');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Service Channel Type');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|municipal|industrial|self_haul|special_event');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `container_ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Container Ownership Model');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `container_ownership_model` SET TAGS ('dbx_value_regex' = 'company_owned|customer_owned|rental|lease|shared');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'standard|custom|franchise|municipal_contract|master_service_agreement');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `customer_portal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Customer Portal Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'residential|small_business|commercial|industrial|municipal|institutional');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Model');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `delivery_model` SET TAGS ('dbx_value_regex' = 'scheduled|on_demand|continuous|seasonal|temporary');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `diversion_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Target Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `dot_hazmat_endorsement_required` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazardous Materials (HAZMAT) Endorsement Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `franchise_agreement_required` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `gps_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Tracking Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Service Channel Manager Name');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `manifest_required` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Manifest Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `minimum_service_commitment_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Service Commitment in Months');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `online_booking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `permit_required` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|volume_based|weight_based|frequency_based|tiered|usage_based');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'msw|recyclable|organic|hazardous|universal_waste|special_waste');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `rfid_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tracking Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `route_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct_sales|inside_sales|online_portal|partner|broker|municipal_bid');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `salesforce_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Customer Relationship Management (CRM) Channel Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `sap_sd_distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Distribution Channel Code');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `sap_sd_sales_org` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Sales Organization Code');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `service_location_type` SET TAGS ('dbx_business_glossary_term' = 'Service Location Type');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `service_location_type` SET TAGS ('dbx_value_regex' = 'customer_site|company_facility|public_location|mobile');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `sla_resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Time in Hours');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Hours');
ALTER TABLE `waste_management_ecm`.`service`.`channel` ALTER COLUMN `sustainability_program_eligible` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Program Eligible Flag');
ALTER TABLE `waste_management_ecm`.`service`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`service`.`territory` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `circular_economy_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Manager Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Landfill Facility Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Required Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `parent_territory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `area_square_miles` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Miles');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `census_tract_list` SET TAGS ('dbx_business_glossary_term' = 'Census Tract List');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `commercial_account_count` SET TAGS ('dbx_business_glossary_term' = 'Commercial Account Count');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_business_glossary_term' = 'County Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `diversion_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Target Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Expiration Date');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `geographic_boundary_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Well-Known Text (WKT)');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `gps_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Tracking Required Flag');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `hazmat_collection_available` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Collection Available Flag');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `household_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Household Count Estimate');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `lea_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Local Enforcement Agency (LEA) Name');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `municipality_name` SET TAGS ('dbx_business_glossary_term' = 'Municipality Name');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|planned');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `organics_program_available` SET TAGS ('dbx_business_glossary_term' = 'Organics Program Available Flag');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Number');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Population Estimate');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `recycling_program_available` SET TAGS ('dbx_business_glossary_term' = 'Recycling Program Available Flag');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `route_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Enabled Flag');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `service_frequency_residential` SET TAGS ('dbx_business_glossary_term' = 'Residential Service Frequency');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Hours');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'franchise|municipal_contract|open_market|exclusive|non_exclusive|hybrid');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code List');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` SET TAGS ('dbx_association_edges' = 'service.offering,compliance.regulatory_requirement');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `offering_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Compliance Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Compliance - Offering Id');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Compliance - Regulatory Requirement Id');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `applicability_notes` SET TAGS ('dbx_business_glossary_term' = 'Applicability Notes');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documentation Reference');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Effective Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Expiration Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated By');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `non_compliance_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Risk Level');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Compliance Responsible Party');
ALTER TABLE `waste_management_ecm`.`service`.`offering_compliance` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` SET TAGS ('dbx_association_edges' = 'service.offering,workforce.employee');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `assigned_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigning Manager Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `assigned_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `assigned_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment - Employee Id');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment - Offering Id');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Workforce Allocation Percentage');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `primary_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Service Proficiency Level');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `waste_management_ecm`.`service`.`assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` SET TAGS ('dbx_association_edges' = 'service.offering,safety.safety_program');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `offering_safety_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Safety Compliance Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Compliance Officer');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Safety Compliance - Offering Id');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Safety Compliance - Safety Program Id');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `audit_frequency_override` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency Override');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Program Compliance Status');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Effective Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Termination Date');
ALTER TABLE `waste_management_ecm`.`service`.`offering_safety_compliance` ALTER COLUMN `training_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Rate');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` SET TAGS ('dbx_association_edges' = 'service.service_area,landfill.site');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `disposal_network_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Network Configuration ID');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Network - Service Area Id');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Approver');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Network - Site Id');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Approval Date');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `average_haul_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Average Haul Distance');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `designation_type` SET TAGS ('dbx_business_glossary_term' = 'Site Designation Type');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Network Configuration Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Network Configuration Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `estimated_annual_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Tonnage Allocation');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `waste_management_ecm`.`service`.`disposal_network` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Site Priority Rank');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` SET TAGS ('dbx_association_edges' = 'service.service_area,compliance.regulatory_requirement');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `area_regulatory_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Area Regulatory Compliance - Area Regulatory Compliance Id');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Regulatory Compliance - Service Area Id');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Compliance Manager');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Area Regulatory Compliance - Regulatory Requirement Id');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Effective Date');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `enforcement_authority` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Authority');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdictional Level');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `reporting_deadline` SET TAGS ('dbx_business_glossary_term' = 'Reporting Deadline');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `waste_management_ecm`.`service`.`area_regulatory_compliance` ALTER COLUMN `waiver_granted` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` SET TAGS ('dbx_subdomain' = 'territory_planning');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` SET TAGS ('dbx_association_edges' = 'service.service_bundle,service.offering');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `bundle_composition_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Composition Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Composition - Service Bundle Id');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `service_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Service Bundle Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `bundle_price_override` SET TAGS ('dbx_business_glossary_term' = 'Bundle Price Override');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Composition Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Composition Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `inclusion_type` SET TAGS ('dbx_business_glossary_term' = 'Component Inclusion Type');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `is_primary_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Indicator');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Component Sequence Number');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
