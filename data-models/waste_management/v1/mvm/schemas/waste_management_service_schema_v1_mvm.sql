-- Schema for Domain: service | Business: Waste Management | Version: v1_mvm
-- Generated on: 2026-05-07 22:44:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`service` COMMENT 'Defines the complete catalog of waste management service offerings — residential pickup plans, commercial dumpster services, roll-off container rentals, recycling programs, hazardous waste collection events, WTE programs, and specialty services. Owns service codes, pricing tiers, service frequency definitions, container types (CID), and SRF/WTE product definitions. Acts as the SSOT for what the business offers, referenced by billing, contract, and collection domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`offering` (
    `offering_id` BIGINT COMMENT 'Unique identifier for the waste management service offering. Primary key.',
    `code_id` BIGINT COMMENT 'Foreign key linking to service.service_code. Business justification: Offering should reference the standardized service_code registry for code assignment. The offering table currently has a service_code STRING attribute that should be replaced with a FK to the servic',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Offering references a default container type. The offering table has a STRING column default_container_type that should be replaced with a proper FK to container_type.container_type_id. This normali',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Offering references a default frequency plan. The offering table has a STRING column default_service_frequency that should be replaced with a proper FK to frequency_plan.frequency_plan_id. This norm',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.service_line. Business justification: Offering belongs to a service_line for hierarchical grouping. The offering table has a STRING column service_line that should be replaced with a proper FK to service_line.service_line_id. This estab',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Waste service offerings require specific operating permits (e.g., hazardous waste collection requires RCRA Part B permit, medical waste requires state-specific permits). Operations cannot execute offe',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: A service offering (e.g., hazardous waste collection, medical waste disposal) is governed by a specific regulatory requirement beyond just its permit. Product managers and compliance teams must link o',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Service offerings specify required asset class for delivery (e.g., hazmat service requires hazmat-certified container class, compaction service requires compactor-class assets). Drives asset eligibili',
    `inspection_checklist_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_checklist. Business justification: Hazmat, medical, and special-waste offerings mandate specific DOT/RCRA container inspection protocols. Linking offering to the required inspection checklist enables compliance auditing, ensures correc',
    `training_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.training_requirement. Business justification: offering.requires_customer_training flag indicates training is needed but doesnt reference which training requirement applies. Hazardous waste service offerings mandate specific customer/operator tra',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Offering is associated with a waste stream type. The offering table has a STRING column waste_stream_type that should be replaced with a proper FK to service_waste_stream.service_waste_stream_id. Th',
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
    `training_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.training_requirement. Business justification: service.code has training_certification_required flag but no FK to the specific training requirement. Service codes for hazardous/medical waste operations reference a mandatory training certification ',
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
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Container types in service catalog map to asset classes for financial tracking (depreciation, capitalization thresholds, GL accounts). Links service catalog specifications to asset accounting rules, e',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Container type specifications (DOT hazmat certification, UN packaging codes, leak-proof standards) are mandated by specific regulatory requirements. Environmental services equipment managers must link',
    `inspection_checklist_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_checklist. Business justification: Container inspection programs are driven by container type (e.g., hazmat-certified containers require DOT inspection checklists; compactors require OSHA safety checklists). This link determines which ',
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
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: RCRA and state regulations mandate minimum pickup frequencies for hazardous waste generators. Frequency plans must reference the regulatory requirement that sets the minimum service interval, enabling',
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
    `commodity_id` BIGINT COMMENT 'Foreign key linking to recycling.commodity. Business justification: Recycling service rates often include revenue-share or commodity-indexed pricing tied to specific recyclable commodities (OCC, PET, aluminum). Required for dynamic pricing models and customer contract',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Rate schedule applies to a specific container size/type. The service_rate_schedule table has a STRING column container_size that should be replaced with a proper FK to container_type.container_type_',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Rate schedule is associated with a frequency plan. The service_rate_schedule table has a STRING column service_frequency that should be replaced with a proper FK to frequency_plan.frequency_plan_id.',
    `offering_id` BIGINT COMMENT 'Reference to the specific waste management service offering (residential pickup, commercial dumpster, roll-off rental, recycling program, hazardous waste collection, WTE program) for which this rate schedule applies.',
    `superseded_by_schedule_service_rate_schedule_id` BIGINT COMMENT 'Reference to the newer rate schedule that replaces this one. Null if this is the current active version.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Rate schedules in waste management are fundamentally waste-stream-specific: MSW tipping fees, recycling commodity adjustments, C&D surcharges, and hazardous waste handling fees all differ by waste str',
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
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Service bundles currently have container_type_included STRING attribute and default_container_id FK to asset.container. The bundle should reference container_type (the master reference for contain',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Service bundles currently have a service_frequency STRING attribute that should be normalized to reference the frequency_plan table. This ensures bundles use standardized frequency definitions rathe',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.service_line. Business justification: Service bundles are organizational constructs that belong to a service line for categorization and management. Since bundles group offerings and offerings belong to service_lines, bundles should also ',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.class. Business justification: Bundle fulfillment and deployment planning requires knowing which asset class (e.g., front-load, roll-off) the bundle mandates. Asset inventory planners use this to ensure sufficient container stock b',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: A bundle is designed for a specific waste stream context (e.g., a residential recycling bundle targets MSW/recyclables, a hazardous waste bundle targets RCRA-regulated streams). Adding waste_stream_id',
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
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each waste stream has specific regulatory requirements defining handling, transport, disposal (e.g., EPA waste code K-listed requires RCRA Subtitle C compliance, asbestos requires NESHAP). Regulatory ',
    `inspection_checklist_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_checklist. Business justification: RCRA and DOT regulations mandate specific container inspection protocols per waste stream (e.g., hazardous, medical, universal waste). This link drives compliance reporting, ensures correct checklists',
    `training_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.training_requirement. Business justification: Waste streams (hazardous, medical, universal waste) require specific handler training certifications. The waste stream catalog must reference the applicable training requirement so that driver/operato',
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

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`area` (
    `area_id` BIGINT COMMENT 'Unique identifier for the service area. Primary key for the service area entity.',
    `district_id` BIGINT COMMENT 'Identifier of the operational district responsible for service delivery in this area. Links to the district master for routing, fleet assignment, and workforce planning.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Service areas operate under municipal franchise agreements that are formalized as permits. Franchise permit defines service obligations, rate structures, performance standards, and geographic boundari',
    `facility_id` BIGINT COMMENT 'Identifier of the primary landfill or disposal facility serving this service area. Used for haul routing and tipping fee calculation.',
    `primary_mrf_facility_id` BIGINT COMMENT 'Identifier of the primary MRF processing recyclable materials from this service area.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Service areas operate under jurisdiction-specific regulatory requirements (state/county environmental mandates beyond the franchise permit). Area managers need to link each service area to its primary',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Service_territory and service_area represent a hierarchical geographic relationship. Territories are broader planning zones (franchise boundaries, municipal contracts), while service_areas are operati',
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
    `line_id` BIGINT COMMENT 'Foreign key linking to service.line. Business justification: SLA definitions in waste management are established at two levels: (1) per specific offering (already modeled via sla_definition.service_offering_id → offering) and (2) per service line (e.g., all res',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Certain SLA response times (e.g., emergency hazardous spill response, missed hazardous waste pickup resolution) are directly mandated by regulatory requirements. Compliance officers must trace SLA def',
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

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the service territory. Primary key.',
    `district_id` BIGINT COMMENT 'Identifier of the operational district to which this service territory is assigned for management purposes.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Territories require operating permits from local regulatory authorities (municipal franchise agreements, county solid waste permits). Territory activation depends on permit issuance. Route planning an',
    `parent_territory_id` BIGINT COMMENT 'Self-referencing FK on territory (parent_territory_id)',
    `facility_id` BIGINT COMMENT 'Identifier of the primary landfill facility designated for waste disposal from this territory.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Territories span regulatory jurisdictions with distinct environmental compliance obligations. Territory-level regulatory requirement linkage enables compliance managers to generate jurisdiction-specif',
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

CREATE OR REPLACE TABLE `waste_management_ecm`.`service`.`bundle_composition` (
    `bundle_composition_id` BIGINT COMMENT 'Primary key for the bundle_composition association',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to the parent service bundle that contains this offering component.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to the service offering that is a component of the bundle.',
    `effective_end_date` DATE COMMENT 'Date when this offering was removed from the bundle composition. Null if the offering is currently active within the bundle. Enables historical bundle composition queries.',
    `effective_start_date` DATE COMMENT 'Date when this offering was added to the bundle composition. Supports versioned bundle definitions where components change over time without invalidating historical contracts.',
    `is_primary_offering_flag` BOOLEAN COMMENT 'Indicates whether this offering is the anchor or lead service within the bundle (e.g., the core collection service in a residential bundle). Used for fulfillment prioritization and marketing display.',
    `pricing_contribution_amount` DECIMAL(18,2) COMMENT 'The dollar amount this offering contributes to the bundles total price. Distinct from the offerings standalone base_price_amount and the bundles aggregate base_price. Enables bundle pricing decomposition and margin analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units of this offering included in the bundle (e.g., 2 recycling carts, 1 curbside pickup). Supports bundles where the same offering appears at different quantities.',
    `sequence_order` BIGINT COMMENT 'Ordinal position of this offering within the bundle for display, fulfillment sequencing, and contract line ordering. Lower values appear first.',
    CONSTRAINT pk_bundle_composition PRIMARY KEY(`bundle_composition_id`)
) COMMENT 'This association product represents the Composition relationship between a service bundle and its constituent service offerings. It captures which offerings are included in each bundle, in what quantity, at what pricing contribution, and in what sequence — data that exists only in the context of a specific bundle-offering membership. Each record defines one offerings role within one bundle, supporting catalog governance, bundle pricing calculation, fulfillment orchestration, and versioned bundle lifecycle management.. Existence Justification: In waste management product catalog operations, a service bundle is explicitly defined as a packaged combination of multiple individual service offerings (e.g., residential collection + recycling cart + yard waste pickup). A single bundle contains many offerings, and a single offering (e.g., curbside recycling) can appear in multiple bundles (e.g., Residential Basic Pack, Residential Complete Care Pack, Commercial Eco Bundle). This is a textbook product composition M:N — the business actively creates, manages, and prices these bundle-offering memberships as part of catalog governance.';

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
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ADD CONSTRAINT `fk_service_bundle_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ADD CONSTRAINT `fk_service_bundle_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ADD CONSTRAINT `fk_service_bundle_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ADD CONSTRAINT `fk_service_bundle_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `waste_management_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_parent_territory_id` FOREIGN KEY (`parent_territory_id`) REFERENCES `waste_management_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ADD CONSTRAINT `fk_service_bundle_composition_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `waste_management_ecm`.`service`.`bundle`(`bundle_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ADD CONSTRAINT `fk_service_bundle_composition_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`service` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `waste_management_ecm`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `waste_management_ecm`.`service`.`offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`service`.`offering` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `code_id` SET TAGS ('dbx_business_glossary_term' = 'Service Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Default Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Default Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Required Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Required Inspection Checklist Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`offering` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`service`.`line` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`line` ALTER COLUMN `parent_service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Line Identifier (ID)');
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
ALTER TABLE `waste_management_ecm`.`service`.`code` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `code_id` SET TAGS ('dbx_business_glossary_term' = 'Service Code ID');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `container_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Required Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`code` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`service`.`container_type` SET TAGS ('dbx_subdomain' = 'territory_coverage');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Required Inspection Checklist Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule ID');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `superseded_by_schedule_service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule ID');
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`service`.`bundle` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Service Bundle Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Required Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Service Waste Stream ID');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Required Inspection Checklist Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`service`.`area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`service`.`area` SET TAGS ('dbx_subdomain' = 'territory_coverage');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'Operational District Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Landfill Facility Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `primary_mrf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Materials Recovery Facility (MRF) Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`area` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition ID');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`service`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`service`.`territory` SET TAGS ('dbx_subdomain' = 'territory_coverage');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `parent_territory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Landfill Facility Identifier');
ALTER TABLE `waste_management_ecm`.`service`.`territory` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` SET TAGS ('dbx_association_edges' = 'service.bundle,service.offering');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `bundle_composition_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Composition - Bundle Composition Id');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Composition - Bundle Id');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Composition - Offering Id');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Component Effective End Date');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Component Effective Start Date');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `is_primary_offering_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Offering Flag');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `pricing_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Pricing Contribution');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `waste_management_ecm`.`service`.`bundle_composition` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Component Sequence');
