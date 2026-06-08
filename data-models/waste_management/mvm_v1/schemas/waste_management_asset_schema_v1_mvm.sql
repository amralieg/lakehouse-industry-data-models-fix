-- Schema for Domain: asset | Business: Waste Management | Version: v1_mvm
-- Generated on: 2026-05-07 22:44:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`asset` COMMENT 'Fixed asset and infrastructure management including containers (dumpsters, roll-offs, carts identified by CID/RFID), landfill sites, MRF facilities, transfer stations, WTE plants, maintenance shops, stationary equipment (compactors, balers, scales), and administrative buildings. Tracks asset master records, acquisition, depreciation, location, condition, utilization, BOM, RFID/GPS tracking, and lifecycle. Distinct from fleet (rolling stock) which has its own DOT compliance requirements. Integrates with Infor EAM and SAP PM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for all fixed assets owned or leased by Waste Management including containers, stationary equipment, facility infrastructure, and administrative buildings.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Fixed_asset currently has asset_class and asset_subclass as STRING attributes, but asset_class table exists with full classification hierarchy, depreciation rules, GL accounts, and compliance requirem',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Fixed assets are physically located at facilities (landfills, MRFs, transfer stations, maintenance shops). Currently fixed_asset has plant_code STRING, but facility table exists with facility_code and',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Fixed assets permanently installed at customer sites (compactors, balers, enclosures) must reference the customer service_address for maintenance dispatch, service scheduling, and billing. Existing fa',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized since the asset was placed in service. Used to calculate current book value and remaining depreciable base.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost to acquire the asset including purchase price, delivery, installation, and any other costs necessary to place the asset in service. Basis for depreciation calculations.',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired by Waste Management through purchase, lease, or other means. Used for asset age calculations and lifecycle planning.',
    `asset_description` STRING COMMENT 'Detailed business description of the fixed asset including make, model, capacity, and distinguishing characteristics. Used for identification and reporting purposes.',
    `asset_number` STRING COMMENT 'Externally-known unique business identifier for the asset. Used across SAP FI-AA, Infor EAM, and operational systems for asset tracking and reference.. Valid values are `^[A-Z0-9]{8,15}$`',
    `capacity_unit` STRING COMMENT 'Unit of measure for the capacity value. Must align with industry standards and operational reporting requirements.. Valid values are `cubic_yards|tons_per_day|gallons|square_feet|kilowatts|each`',
    `capacity_value` DECIMAL(18,2) COMMENT 'Rated capacity or size of the asset in appropriate units. Examples: cubic yards for containers, tons per day for processing equipment, square feet for buildings.',
    `capitalization_date` DATE COMMENT 'Date the asset was placed in service and capitalized on the balance sheet. Marks the start of depreciation calculations per GAAP/IFRS standards.',
    `cid` STRING COMMENT 'Container Identification number used for tracking dumpsters, roll-offs, and carts. Unique identifier printed on container and linked to RFID tags for automated tracking.. Valid values are `^CID[0-9]{10}$`',
    `condition_rating` STRING COMMENT 'Current physical condition assessment of the asset based on inspection and maintenance history. Used for replacement planning and risk assessment.. Valid values are `excellent|good|fair|poor|critical`',
    `cost_center` STRING COMMENT 'SAP Controlling (CO) cost center to which the asset is assigned. Used for depreciation expense allocation and management reporting.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset master record was first created in the system. Used for data lineage and audit trail purposes.',
    `current_book_value` DECIMAL(18,2) COMMENT 'Current net book value of the asset after accumulated depreciation. Calculated as acquisition cost minus accumulated depreciation. Updated with each depreciation run.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate periodic depreciation expense. Must comply with GAAP/IFRS standards and IRS regulations for tax reporting.. Valid values are `straight_line|declining_balance|sum_of_years_digits|units_of_production|macrs`',
    `disposal_date` DATE COMMENT 'Date the asset was retired, sold, scrapped, or otherwise disposed of. Marks the end of the assets lifecycle and triggers final accounting entries.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed of. Used for accounting treatment, tax reporting, and asset lifecycle analysis.. Valid values are `sold|scrapped|donated|traded|lost|stolen`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from sale or disposal of the asset. Used to calculate gain or loss on disposal for financial reporting.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the asset requires environmental compliance monitoring per EPA, RCRA, or state regulations. Used for regulatory reporting and inspection scheduling.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the assets current or primary location. Used for asset tracking, route optimization, and geographic analysis.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the assets current or primary location. Used for asset tracking, route optimization, and geographic analysis.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering the asset. Used for risk management, claims processing, and insurance compliance tracking.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection or condition assessment of the asset. Used for compliance tracking and maintenance scheduling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset master record was last updated. Used for change tracking and data quality monitoring.',
    `lease_contract_number` STRING COMMENT 'Contract number for leased assets. Links to lease agreement master data for payment tracking and lease accounting compliance.',
    `location_description` STRING COMMENT 'Detailed physical location description of where the asset is deployed or stored. Examples: customer site address, facility name, yard location, route assignment.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured or produced the asset. Used for warranty claims, parts sourcing, and vendor management.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for the asset. Used for parts compatibility, maintenance procedures, and specifications lookup.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection or condition assessment. Used for preventive maintenance planning and regulatory compliance.',
    `ownership_type` STRING COMMENT 'Legal ownership status of the asset. Determines accounting treatment, balance sheet classification, and lease accounting compliance per ASC 842 or IFRS 16.. Valid values are `owned|capital_lease|operating_lease|rental`',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Used in depreciation calculations to determine depreciable base.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for the asset. Used for warranty tracking, parts ordering, and equipment identification.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years for depreciation purposes. Determined by asset class and regulatory guidelines per IRS Publication 946 or IFRS standards.',
    `warranty_expiration_date` DATE COMMENT 'Date when manufacturer or vendor warranty coverage expires. Used for maintenance cost planning and warranty claim eligibility.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Master record for all fixed assets owned or leased by Waste Management, including containers (dumpsters, roll-offs, carts identified by CID/RFID), stationary equipment (compactors, balers, scales), facility infrastructure, and administrative buildings. Tracks asset number, description, asset class, acquisition date, capitalization date, useful life, salvage value, current book value, depreciation method, cost center, plant/location, serial number, manufacturer, model, condition rating, and operational status. Sourced from SAP S/4HANA Asset Accounting (FI-AA) and Infor EAM as the authoritative SSOT for all fixed asset master data.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`class` (
    `class_id` BIGINT COMMENT 'Unique identifier for the asset class. Primary key for the asset class reference hierarchy.',
    `parent_asset_class_id` BIGINT COMMENT 'Reference to the parent asset class in the classification hierarchy, enabling multi-level asset categorization (e.g., Containers > Roll-Off Containers > 20-Yard Roll-Offs).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Asset classes in waste management are governed by specific regulations (all underground storage tanks subject to RCRA Subtitle I, all roll-off containers subject to DOT 49 CFR). class has rcra_regulat',
    `asset_category` STRING COMMENT 'High-level categorization of the asset class aligned with Waste Management operational divisions. Containers include dumpsters, roll-offs, carts; stationary equipment includes compactors, balers, scales; infrastructure includes landfill cells, liners, caps, leachate systems. [ENUM-REF-CANDIDATE: container|stationary_equipment|landfill_infrastructure|mrf_equipment|wte_equipment|transfer_station_equipment|building|land|vehicle_attachment|other — 10 candidates stripped; promote to reference product]',
    `asset_class_code` STRING COMMENT 'External business identifier for the asset class used in SAP and financial reporting. Typically a 4-12 character alphanumeric code aligned with chart of accounts structure.. Valid values are `^[A-Z0-9]{4,12}$`',
    `asset_class_description` STRING COMMENT 'Detailed description of the asset class including scope, typical assets included, and business purpose.',
    `asset_class_name` STRING COMMENT 'Full descriptive name of the asset class (e.g., Roll-Off Containers, Front-End Loaders, Compactors, Landfill Infrastructure, MRF Equipment).',
    `asset_type` STRING COMMENT 'Specific type within the asset category providing granular classification (e.g., Front-End Loader, Rear-End Loader, Automated Side Loader, Stationary Compactor, Baler, Weighbridge, Landfill Cell, MRF Sorting Line).',
    `capitalization_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum acquisition cost required for an asset in this class to be capitalized rather than expensed, aligned with GAAP/IFRS policies and company materiality thresholds.',
    `capitalization_threshold_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the capitalization threshold amount (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `class_status` STRING COMMENT 'Current lifecycle status of the asset class in the master data system. Active classes are available for new asset creation; deprecated classes are retained for historical assets only.. Valid values are `active|inactive|deprecated|pending_approval`',
    `cost_center_default` STRING COMMENT 'Default cost center code for assets in this class, used for management accounting and operational expense allocation in SAP CO.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Business criticality classification for assets in this class based on operational impact of failure. Critical assets require immediate response; low criticality assets can tolerate longer downtime.. Valid values are `critical|high|medium|low`',
    `depreciation_method` STRING COMMENT 'Default depreciation calculation method for assets in this class. Straight-line is most common for buildings and infrastructure; units of production may apply to equipment with measurable usage (e.g., compactors by cycle count).. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits|none`',
    `effective_end_date` DATE COMMENT 'Date after which this asset class configuration is no longer valid for new asset creation. Null for currently active configurations.',
    `effective_start_date` DATE COMMENT 'Date from which this asset class configuration becomes effective for new asset creation and depreciation calculation.',
    `energy_consumption_tracked` BOOLEAN COMMENT 'Indicates whether energy consumption (electricity, natural gas, diesel) is tracked at the asset class level for sustainability reporting and cost allocation.',
    `environmental_impact_category` STRING COMMENT 'Classification of potential environmental impact from failure or improper operation of assets in this class. High for landfill liners and leachate systems; medium for compactors and balers; low for administrative assets.. Valid values are `high|medium|low|none`',
    `epa_reporting_required` BOOLEAN COMMENT 'Indicates whether assets in this class must be included in EPA regulatory reporting (e.g., landfill gas collection systems, leachate treatment equipment, air emission control devices).',
    `ghg_emission_source` BOOLEAN COMMENT 'Indicates whether assets in this class are direct sources of greenhouse gas emissions requiring monitoring and reporting (e.g., landfill gas collection systems, WTE combustion equipment, stationary engines).',
    `gl_accumulated_depreciation_account` STRING COMMENT 'General Ledger contra-asset account number for accumulated depreciation of assets in this class. Maps to SAP FI chart of accounts.. Valid values are `^[0-9]{4,10}$`',
    `gl_asset_account` STRING COMMENT 'General Ledger account number for capitalizing assets in this class on the balance sheet. Maps to SAP FI chart of accounts.. Valid values are `^[0-9]{4,10}$`',
    `gl_depreciation_account` STRING COMMENT 'General Ledger account number for recording depreciation expense for assets in this class. Maps to SAP FI chart of accounts.. Valid values are `^[0-9]{4,10}$`',
    `gl_gain_loss_account` STRING COMMENT 'General Ledger account number for recording gains or losses on disposal or retirement of assets in this class.. Valid values are `^[0-9]{4,10}$`',
    `inspection_frequency_days` STRING COMMENT 'Standard interval in days between required inspections for assets in this class. Null if periodic inspection is not required.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether assets in this class must carry specific insurance coverage beyond general property insurance (e.g., environmental liability insurance for landfill cells, equipment breakdown insurance for WTE plants).',
    `insurance_type` STRING COMMENT 'Type of insurance coverage required for assets in this class (e.g., Environmental Liability, Equipment Breakdown, Pollution Legal Liability, Property and Casualty). Null if no specific insurance required.',
    `maintenance_strategy` STRING COMMENT 'Default maintenance approach for assets in this class. Preventive for scheduled maintenance; predictive for sensor-monitored equipment; reactive for low-criticality items; condition-based for inspection-driven maintenance.. Valid values are `preventive|predictive|reactive|condition_based|run_to_failure`',
    `manufacturer_warranty_months` STRING COMMENT 'Typical manufacturer warranty period in months for new assets in this class. Used for warranty tracking and maintenance planning during warranty period.',
    `modified_by` STRING COMMENT 'User ID or system account that last modified this asset class record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was last modified.',
    `rcra_regulated` BOOLEAN COMMENT 'Indicates whether assets in this class are subject to RCRA hazardous waste management regulations (e.g., hazardous waste storage containers, treatment equipment, TSDF infrastructure).',
    `requires_gps_tracking` BOOLEAN COMMENT 'Indicates whether assets in this class require GPS tracking devices for location monitoring. May apply to mobile equipment and high-value portable assets.',
    `requires_periodic_inspection` BOOLEAN COMMENT 'Indicates whether assets in this class are subject to mandatory periodic safety or compliance inspections (e.g., pressure vessels, lifting equipment, hazardous waste storage units).',
    `requires_rfid_tracking` BOOLEAN COMMENT 'Indicates whether assets in this class must be equipped with RFID tags for automated tracking and inventory management. Typically true for containers (CID tracking), false for fixed infrastructure.',
    `salvage_value_percentage` DECIMAL(18,2) COMMENT 'Expected residual value as a percentage of original cost at end of useful life. Containers and equipment may have 5-15% salvage value; buildings typically higher; landfill cells near zero.',
    `serialized_tracking_required` BOOLEAN COMMENT 'Indicates whether individual assets in this class must be tracked by unique serial number in addition to asset ID. True for high-value equipment and containers; false for bulk infrastructure.',
    `useful_life_years_default` STRING COMMENT 'Standard useful life in years applied by default when creating new assets in this class, typically the midpoint or most common value within the min-max range.',
    `useful_life_years_max` STRING COMMENT 'Maximum expected useful life in years for assets in this class, providing a range for depreciation planning based on usage intensity and maintenance quality.',
    `useful_life_years_min` STRING COMMENT 'Minimum expected useful life in years for assets in this class, used for depreciation calculation and asset lifecycle planning.',
    `created_by` STRING COMMENT 'User ID or system account that created this asset class record.',
    CONSTRAINT pk_class PRIMARY KEY(`class_id`)
) COMMENT 'Reference classification hierarchy for fixed assets aligned with SAP asset class configuration and GAAP/IFRS capitalization policies. Defines asset categories such as containers, compactors, balers, weighing scales, landfill infrastructure, MRF equipment, WTE plant equipment, transfer station equipment, and buildings. Each class carries depreciation method defaults, useful life ranges, capitalization thresholds, GL account assignments, and RCRA/EPA reporting flags. Enables consistent depreciation calculation and regulatory asset reporting across all Waste Management facilities.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`asset_container` (
    `asset_container_id` BIGINT COMMENT 'Unique identifier for the waste container. Primary key. This is the system-generated surrogate key that uniquely identifies each container record in the enterprise data warehouse.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Containers must be approved for specific waste profiles based on material compatibility, DOT ratings, and waste characteristics. Links containers to approved waste profiles for safe deployment, regula',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Container types (front-load, rear-load, roll-off) should be classified within the asset class hierarchy for consistent depreciation rules, capitalization thresholds, and GL account mapping. Currently ',
    `customer_account_id` BIGINT COMMENT 'Foreign key reference to the customer account that is currently being serviced by this container. Links to customer.customer_account. Null if container is not currently assigned to a customer.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Container is a specialized type of fixed asset. Containers have acquisition_date, acquisition_cost, depreciation_method, useful_life_years, accumulated_depreciation, net_book_value, sap_asset_number, ',
    `route_id` BIGINT COMMENT 'Foreign key reference to the collection route that services this container. Links to collection.route. Used for route optimization and service scheduling.',
    `service_address_id` BIGINT COMMENT 'Foreign key reference to the service address where this container is currently deployed. Links to customer.service_address. Null if container is not currently deployed (e.g., in inventory or maintenance).',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle. Business justification: Containers are serviced by specific vehicles on routes. While route_id exists, direct vehicle linkage enables container-to-vehicle assignment validation, RFID read reconciliation for billing disputes,',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The total depreciation expense recognized to date for this container asset in USD. Used to calculate net book value. Confidential financial data.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'The original purchase price or capitalized cost of the container in USD. Used for depreciation calculations, asset valuation, and financial reporting. Confidential business financial data.',
    `acquisition_date` DATE COMMENT 'The date the container was acquired by Waste Management, either through purchase or lease inception. Used for depreciation calculations and asset lifecycle tracking.',
    `amcs_container_reference` STRING COMMENT 'The external identifier for this container in the AMCS Platform system. Used for integration and cross-system reconciliation between the enterprise data warehouse and the operational AMCS system.',
    `capacity_cubic_yards` DECIMAL(18,2) COMMENT 'The volumetric capacity of the container measured in cubic yards. Standard sizes include 2, 4, 6, 8 cubic yards for front/rear-load dumpsters; 10, 20, 30, 40 cubic yards for roll-off boxes; and 32, 64, 96 gallons (converted to cubic yards) for residential carts. This is the principal quantitative measurement for the container resource.',
    `cid` STRING COMMENT 'The externally-known unique business identifier for the container, typically an alphanumeric code printed on the container and used by field operations, customer service, and AMCS Platform for tracking. This is the operational identifier used in day-to-day business processes.. Valid values are `^[A-Z0-9]{8,12}$`',
    `color` STRING COMMENT 'The exterior color of the container, often used to designate waste stream type (e.g., blue for recycling, green for organics, black for MSW). Color coding helps drivers and customers identify the correct container for each waste stream. [ENUM-REF-CANDIDATE: green|blue|black|gray|brown|yellow|red — 7 candidates stripped; promote to reference product]',
    `compaction_ratio` DECIMAL(18,2) COMMENT 'The volume reduction ratio achieved by compactor units. For example, a ratio of 4.0 means the compactor reduces waste volume by 4:1. Only applicable to compactor_unit container types. Used to calculate effective capacity and optimize service frequency.',
    `condition_grade` STRING COMMENT 'Assessment of the physical condition of the container based on inspection findings. Excellent means like-new; good means minor wear; fair means functional with visible wear; poor means needs repair soon; critical means unsafe or non-functional.. Valid values are `excellent|good|fair|poor|critical`',
    `container_type` STRING COMMENT 'Classification of the container by its operational design and collection method. Front-load dumpsters are serviced by Front End Loader (FEL) trucks, rear-load by Rear End Loader (REL) trucks, roll-offs by specialized roll-off trucks, residential carts by Automated Side Loader (ASL) trucks, and compactor units are stationary compression equipment.. Valid values are `front_load_dumpster|rear_load_dumpster|roll_off_box|residential_cart|compactor_unit|recycling_cart`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this container record was first created in the system. Used for audit trail and data lineage tracking. Immutable after initial creation.',
    `deployment_date` DATE COMMENT 'The date this container was most recently deployed to a customer service address. Used to track deployment history and calculate time-in-service metrics.',
    `gps_device_code` STRING COMMENT 'Identifier for the GPS tracking device installed on high-value containers (typically roll-offs and compactors) for real-time location monitoring via Geotab Fleet Telematics or similar systems.',
    `infor_eam_asset_reference` STRING COMMENT 'The asset identifier for this container in the Infor EAM system. Used for maintenance work order management, preventive maintenance scheduling, and parts inventory tracking.',
    `is_gps_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this container is equipped with an active GPS tracking device. True means GPS device is installed and transmitting; false means no GPS tracking.',
    `is_rfid_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this container is equipped with an active RFID tag for automated scanning. True means RFID tag is attached and functional; false means no RFID capability.',
    `last_inspection_date` DATE COMMENT 'The date of the most recent physical inspection of the container. Regular inspections are required for safety, compliance, and preventive maintenance. Inspection frequency varies by container type and regulatory requirements.',
    `lid_type` STRING COMMENT 'The type of lid or cover on the container. Lids help control odor, prevent unauthorized dumping, and keep out rain. Locking lids provide security for customer-specific waste. Some roll-offs have no lids.. Valid values are `hinged|sliding|dome|flat|locking|none`',
    `manufacturer` STRING COMMENT 'The name of the company that manufactured the container. Used for warranty tracking, parts sourcing, and quality analysis.',
    `material` STRING COMMENT 'The primary construction material of the container body. Steel is common for commercial dumpsters and roll-offs; plastic (high-density polyethylene) for residential carts; fiberglass for specialized applications; aluminum for lightweight applications.. Valid values are `steel|plastic|fiberglass|aluminum`',
    `model_number` STRING COMMENT 'The manufacturers model or part number for this container design. Used for parts compatibility, warranty claims, and standardization.',
    `net_book_value` DECIMAL(18,2) COMMENT 'The current book value of the container calculated as acquisition cost minus accumulated depreciation in USD. Used for financial reporting and asset valuation. Confidential financial data.',
    `next_inspection_due_date` DATE COMMENT 'The scheduled date for the next required inspection of the container. Used for preventive maintenance scheduling and compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or observations about the container. May include placement instructions, access restrictions, damage reports, or customer-specific requirements.',
    `ownership_status` STRING COMMENT 'Indicates whether the container is owned by Waste Management, leased from a third party, or owned by the customer. Owned containers are capitalized assets; leased containers have associated lease obligations; customer-owned containers are tracked for service purposes but not capitalized.. Valid values are `owned|leased|customer_owned`',
    `retrieval_date` DATE COMMENT 'The date this container was retrieved from a customer service address and returned to inventory or maintenance. Null if container is currently deployed.',
    `rfid_tag` STRING COMMENT 'The RFID tag identifier embedded in or attached to the container for automated tracking and scanning during collection operations. Used by AMCS Platform and collection vehicles equipped with RFID readers.. Valid values are `^[A-F0-9]{24}$`',
    `sap_asset_number` STRING COMMENT 'The asset number assigned to this container in the SAP S/4HANA Fixed Assets (FI-AA) module. Used for financial asset tracking, depreciation runs, and general ledger integration.',
    `serial_number` STRING COMMENT 'The manufacturers unique serial number for this specific container unit. Used for warranty tracking, recall management, and asset verification.',
    `service_frequency` STRING COMMENT 'The scheduled frequency at which this container is serviced (emptied). Daily is common for high-volume commercial accounts; weekly/biweekly for residential; on-demand for roll-offs.. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `tare_weight_lbs` DECIMAL(18,2) COMMENT 'The empty weight of the container in pounds. Used to calculate net waste weight by subtracting tare weight from gross weight measured at scales. Critical for accurate tonnage reporting and billing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this container record was most recently updated. Used for audit trail, change tracking, and data synchronization. Updated automatically on any record modification.',
    `waste_stream_type` STRING COMMENT 'The type of waste this container is designated to hold. MSW is Municipal Solid Waste (general trash); recycling for recyclable materials; organics for compostable waste; C&D for Construction and Demolition debris; hazardous for RCRA-regulated waste; universal waste for batteries, electronics, etc.. Valid values are `msw|recycling|organics|c_and_d|hazardous|universal_waste`',
    CONSTRAINT pk_asset_container PRIMARY KEY(`asset_container_id`)
) COMMENT 'Master record for all waste containers deployed in the field, including front-load dumpsters, rear-load dumpsters, roll-off boxes, residential carts, and compactor units. Each container is identified by a unique CID (Container Identification) and optionally an RFID tag or GPS device. Tracks container type, size (cubic yards), material, color, lid type, ownership (owned/leased/customer-owned), deployment status, current service address, last inspection date, condition grade, tare weight, and AMCS container tracking reference. Distinct from fleet (rolling stock) — containers are stationary assets placed at customer sites.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`facility` (
    `facility_id` BIGINT COMMENT 'Unique identifier for the facility. Primary key.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Facilities (landfills, MRFs, transfer stations, WTE plants) are fixed assets and should be classified in the asset class hierarchy. Facility types have distinct depreciation rules, capitalization thre',
    `acquisition_date` DATE COMMENT 'Date when the facility was acquired, purchased, or brought into service by Waste Management.',
    `address_line_1` STRING COMMENT 'Primary street address of the facility (street number and name).',
    `address_line_2` STRING COMMENT 'Secondary address information (suite, building, unit) if applicable.',
    `air_permit_number` STRING COMMENT 'Permit number issued under the Clean Air Act (CAA) for facilities with air emissions (e.g., landfills with LFG flares, WTE plants).',
    `city` STRING COMMENT 'City or municipality where the facility is located.',
    `commissioning_date` DATE COMMENT 'Date when the facility became fully operational and began accepting waste or providing services.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the facility is located (USA, CAN, MEX).. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the system.',
    `decommissioning_date` DATE COMMENT 'Date when the facility was permanently closed and decommissioned. Null for active facilities.',
    `email_address` STRING COMMENT 'Primary email address for facility correspondence and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `epa_facility_number` STRING COMMENT 'Unique identifier assigned by the U.S. EPA for tracking environmental compliance and reporting (e.g., FRS Registry ID).',
    `facility_code` STRING COMMENT 'Short alphanumeric code used for internal identification and reporting (e.g., LF-001, MRF-023).',
    `facility_name` STRING COMMENT 'Official business name of the facility (e.g., Metro East Landfill, Riverside MRF).',
    `facility_type` STRING COMMENT 'Classification of the facility by operational purpose: landfill (Municipal Solid Waste disposal site), MRF (Materials Recovery Facility for recycling), WTE (Waste-to-Energy conversion plant), transfer_station (intermediate collection point), TSDF (Treatment Storage and Disposal Facility for hazardous waste), maintenance_shop (fleet and equipment repair), administrative_office (corporate/regional office). [ENUM-REF-CANDIDATE: landfill|mrf|wte|transfer_station|tsdf|maintenance_shop|administrative_office — 7 candidates stripped; promote to reference product]',
    `fax_number` STRING COMMENT 'Fax number for the facility, if applicable.',
    `hazmat_facility_flag` BOOLEAN COMMENT 'Indicates whether the facility is authorized to handle, store, or treat hazardous waste under RCRA Subtitle C (True/False).',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 14001 certification for environmental management systems (True/False).',
    `iso_45001_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 45001 certification for occupational health and safety management (True/False).',
    `landfill_closure_date` DATE COMMENT 'Projected or actual date when the landfill will reach capacity and cease accepting waste. Null for non-landfill facilities.',
    `landfill_remaining_capacity_tons` DECIMAL(18,2) COMMENT 'Estimated remaining disposal capacity in tons for landfill facilities. Null for non-landfill facility types.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility in decimal degrees (WGS84 datum).',
    `lea_jurisdiction` STRING COMMENT 'Name of the Local Enforcement Agency (LEA) or county environmental health department with regulatory oversight of the facility.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility in decimal degrees (WGS84 datum).',
    `manager_name` STRING COMMENT 'Full name of the facility manager or site superintendent responsible for day-to-day operations.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, or historical context about the facility.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the facility (e.g., Mon-Fri 7:00-17:00, 24/7). Free-text field to accommodate varied schedules.',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the facility: owned (company-owned asset), leased (leased from third party), operated_under_contract (operated on behalf of municipality or other entity), joint_venture (co-owned with partner).. Valid values are `owned|leased|operated_under_contract|joint_venture`',
    `permitted_capacity_tpd` DECIMAL(18,2) COMMENT 'Maximum daily waste processing or disposal capacity in tons per day (TPD) as authorized by regulatory permits. Applicable to landfills, MRFs, WTE plants, and transfer stations.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the facility.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the facility address.',
    `site_area_acres` DECIMAL(18,2) COMMENT 'Total land area of the facility site in acres, including operational areas, buffer zones, and administrative buildings.',
    `solid_waste_permit_number` STRING COMMENT 'Primary operating permit number issued by state or local authority under RCRA Subtitle D (non-hazardous) or Subtitle C (hazardous) for waste management operations.',
    `state_province` STRING COMMENT 'State or province code (e.g., CA, TX, ON) where the facility is located.',
    `swis_number` STRING COMMENT 'State-issued identifier for solid waste facilities used for regulatory tracking and reporting (varies by state).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was last modified.',
    `water_permit_number` STRING COMMENT 'Permit number issued under the Clean Water Act (CWA) for facilities that discharge wastewater or manage leachate (e.g., NPDES permit).',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master record for all Waste Management fixed facilities including landfill sites, MRF (Materials Recovery Facility) plants, WTE (Waste-to-Energy) plants, transfer stations, hazardous waste TSDFs (Treatment Storage and Disposal Facilities), maintenance shops, and administrative offices. Tracks facility name, type, physical address, GPS coordinates, permitted capacity (TPD), operating hours, regulatory permit numbers (air, water, solid waste), LEA (Local Enforcement Agency) jurisdiction, SWIS number, EPA facility ID, operational status, and owning business unit. Serves as the geographic and operational anchor for all site-level asset and compliance data.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the asset location record. Primary key.',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.asset_container. Business justification: The location table is the authoritative tracker of physical placement for all assets in the Waste Management network. While location.fixed_asset_id already links to the fixed_asset master, containers ',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with this asset location. Applicable when the asset is placed at a customer site for service delivery.',
    `district_id` BIGINT COMMENT 'Identifier of the operational district or service area where the asset is located. Used for regional management and reporting.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility where the asset is located. Applicable for stationary equipment, containers in yards, or assets at MRF, landfill, WTE, or transfer stations.',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the asset (container, equipment, facility) whose location is being tracked. Links to the asset master record in Infor EAM or SAP PM.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver who placed or delivered the asset to this location. Links to driver master for accountability and audit trail.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle used to transport and place the asset at this location. Links to fleet vehicle master.',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order that authorized or executed the asset placement at this location. Links to field service work order system.',
    `route_id` BIGINT COMMENT 'Identifier of the collection route that services this asset location. Links to route master for operational planning and optimization.',
    `service_address_id` BIGINT COMMENT 'Identifier of the customer service address where the asset is located. Applicable for containers placed at customer sites. Links to customer service address master.',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Asset location records track deployed container/equipment positions tied to active service enrollments. Billing verification, service audit, and diversion reporting require direct linkage between a de',
    `address_line_1` STRING COMMENT 'Primary street address line of the asset location. Includes street number and street name.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as suite, unit, or building number.',
    `assignment_reason` STRING COMMENT 'Business reason for assigning the asset to this location. Supports root cause analysis for location changes and utilization patterns. [ENUM-REF-CANDIDATE: new_service|service_change|replacement|maintenance|temporary_placement|customer_request|route_optimization|lost_recovery|seasonal — 9 candidates stripped; promote to reference product]',
    `bay_or_pad_number` STRING COMMENT 'Specific bay, pad, or designated area within a building or facility where the asset is positioned. Used for precise location tracking of stationary equipment like compactors, balers, and scales.. Valid values are `^[A-Z0-9-]{1,10}$`',
    `building_code` STRING COMMENT 'Code identifying the specific building or structure within a facility where the asset is located. Used for maintenance shops, administrative buildings, and multi-building facilities.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cid` STRING COMMENT 'Container Identification number - unique alphanumeric identifier assigned to containers (dumpsters, roll-offs, carts) for tracking and service management. Industry-standard identifier used across AMCS and Waste Logics platforms.. Valid values are `^[A-Z0-9]{8,12}$`',
    `city` STRING COMMENT 'City or municipality where the asset is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the asset is located. Primary operations in USA and CAN.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this asset location record was first created in the system. Audit trail for record creation.',
    `effective_end_date` DATE COMMENT 'Date when the asset was removed from or moved away from this location. Null indicates the asset is currently at this location.',
    `effective_start_date` DATE COMMENT 'Date when the asset was placed at or moved to this location. Marks the beginning of the location assignment period.',
    `geofence_zone_code` BIGINT COMMENT 'Identifier of the geofence zone that encompasses this asset location. Used for automated location alerts and compliance monitoring.',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'Accuracy of the GPS coordinates in meters. Indicates the precision of the location data captured from telemetry systems.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the asset location in decimal degrees. Captured from Geotab GPS telemetry or AMCS container tracking.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the asset location in decimal degrees. Captured from Geotab GPS telemetry or AMCS container tracking.',
    `is_billable_location` BOOLEAN COMMENT 'Flag indicating whether the asset placement at this location is billable to a customer. True for customer sites with active service; false for internal facility locations.',
    `is_primary_location` BOOLEAN COMMENT 'Flag indicating whether this is the primary or home location for the asset. True for the main assigned location; false for temporary or secondary locations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this asset location record was last updated. Audit trail for record changes.',
    `last_service_date` DATE COMMENT 'Date when the asset at this location was last serviced (e.g., container emptied, equipment maintained). Used for service frequency analysis.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Date and time when the asset location was last verified or confirmed. Updated by RFID scans, GPS pings, or manual audits.',
    `location_status` STRING COMMENT 'Current status of the asset at this location. Indicates whether the asset is actively in service, temporarily placed, awaiting pickup, or lost/missing.. Valid values are `active|inactive|temporary|pending_pickup|lost|retired`',
    `location_type` STRING COMMENT 'Classification of the location where the asset is currently positioned. Distinguishes between customer sites, internal facilities, and transit states. [ENUM-REF-CANDIDATE: customer_site|facility|yard|transfer_station|landfill|mrf|wte_plant|maintenance_shop|in_transit|storage — 10 candidates stripped; promote to reference product]',
    `next_scheduled_service_date` DATE COMMENT 'Date when the asset at this location is next scheduled for service. Supports route planning and customer service level agreement (SLA) compliance.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the asset location, such as access instructions, site conditions, or special handling requirements.',
    `placement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the asset was placed at this location. Captured from driver mobile app, RFID scan, or GPS telemetry.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the asset location. US format supports 5-digit or 9-digit ZIP codes.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `rfid_tag` STRING COMMENT 'RFID tag identifier attached to the asset for automated tracking and scanning during collection operations. Hexadecimal format.. Valid values are `^[A-F0-9]{24}$`',
    `source_system` STRING COMMENT 'System or method that captured or recorded this asset location. Indicates data lineage and reliability of location information. [ENUM-REF-CANDIDATE: amcs|geotab|waste_logics|infor_eam|manual_entry|rfid_scan|gps_telemetry — 7 candidates stripped; promote to reference product]',
    `state_province` STRING COMMENT 'Two-letter state or province code where the asset is located. US state codes follow USPS standard.. Valid values are `^[A-Z]{2}$`',
    `utilization_status` STRING COMMENT 'Current utilization state of the asset at this location. Indicates whether the asset is actively being used, idle, or available for redeployment.. Valid values are `in_use|idle|available|reserved|under_maintenance|decommissioned`',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Tracks the current and historical physical location of each asset within the Waste Management network. For containers, records the service address, GPS coordinates, and customer site. For stationary equipment, records the facility, building, bay, or pad location. Captures location type (customer site, facility, yard, in-transit), effective date, and the business reason for the location assignment. Enables real-time asset location visibility, utilization analysis, and lost/missing container investigations. Integrates with AMCS container tracking and Geotab GPS telemetry.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`acquisition` (
    `acquisition_id` BIGINT COMMENT 'Unique identifier for the asset acquisition event. Primary key for the acquisition record.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset master record that was acquired through this acquisition event. Links to the asset master upon capitalization.',
    `acquisition_trade_in_asset_fixed_asset_id` BIGINT COMMENT 'Reference to the existing asset that was traded in as part of this acquisition. Links to the disposed asset record for gain/loss calculation.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project or CapEx initiative under which this asset was acquired. Links to capital planning and budget tracking systems.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Acquisition has asset_class STRING indicating the class of the asset being acquired, but asset_class table exists with capitalization thresholds, depreciation rules, and GL accounts. Adding asset_clas',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Fixed asset acquisitions (vehicles, containers, facility equipment) in waste management are executed under procurement contracts. Linking acquisition to contract enables capital expenditure tracking a',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Capital asset acquisitions generate vendor invoices tracked in the billing system. The AP/capital expenditure process requires linking each acquisition record to its billing invoice for payment reconc',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired and placed into service. Used as the start date for depreciation calculation and asset lifecycle tracking.',
    `acquisition_method` STRING COMMENT 'Method by which the asset was acquired. Determines capitalization treatment and accounting entries per GAAP/IFRS standards.. Valid values are `purchase|lease|construction|donation|transfer|trade_in`',
    `acquisition_number` STRING COMMENT 'Business identifier for the acquisition transaction. Externally-known reference number used in procurement and accounting documentation.',
    `acquisition_status` STRING COMMENT 'Current status of the acquisition transaction in its lifecycle. Tracks progression from approval through capitalization or cancellation. [ENUM-REF-CANDIDATE: pending|approved|in_transit|received|installed|capitalized|cancelled — 7 candidates stripped; promote to reference product]',
    `approval_authority` STRING COMMENT 'Name or title of the individual or committee that approved the asset acquisition. Supports SOX compliance and capital expenditure governance.',
    `approval_date` DATE COMMENT 'Date the asset acquisition was formally approved by the designated authority. Part of the audit trail for capital expenditure controls.',
    `budget_line_item` STRING COMMENT 'Specific budget line item or cost center code against which the acquisition was charged. Used for budget variance analysis and financial control.',
    `capitalization_date` DATE COMMENT 'Date the asset was capitalized in the general ledger and added to the fixed asset register. May differ from acquisition date for constructed assets.',
    `cost` DECIMAL(18,2) COMMENT 'Base purchase price of the asset before additional costs. Represents the invoice amount paid to the vendor excluding freight, installation, and other capitalizable costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the acquisition record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the acquisition transaction. Primarily USD for domestic operations, with CAD and MXN for North American facilities.. Valid values are `USD|CAD|MXN|EUR|GBP`',
    `depreciation_method` STRING COMMENT 'Depreciation method applied to the asset for financial reporting. Straight-line is most common for waste management fixed assets per GAAP.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation and shipping costs incurred to deliver the asset to its installation location. Capitalized as part of total asset cost per GAAP.',
    `funding_source` STRING COMMENT 'Source of funds used to finance the asset acquisition. Tracks whether the asset was funded through operating budget, capital expenditure budget, grants, or financing arrangements.. Valid values are `operating_budget|capital_budget|grant|lease_financing|bond_proceeds|internal_cash`',
    `installation_cost` DECIMAL(18,2) COMMENT 'Costs incurred to install, configure, and prepare the asset for its intended use. Includes labor, materials, and contractor fees. Capitalized per GAAP.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified the acquisition record. Supports audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the acquisition record was last modified. Tracks changes for audit and data quality purposes.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context about the acquisition, such as special terms, conditions, or justification for the purchase.',
    `purchase_order_number` STRING COMMENT 'Purchase order number issued to procure the asset. Links to SAP MM purchasing documents for procurement audit trail.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Used in depreciation calculation to determine depreciable basis.',
    `sap_asset_document_number` STRING COMMENT 'SAP asset acquisition document number generated when the asset was capitalized in SAP FI-AA. Links to SAP fixed asset master and depreciation runs.',
    `total_capitalized_cost` DECIMAL(18,2) COMMENT 'Total cost capitalized for the asset, including acquisition cost, freight, installation, and other capitalizable costs. This is the depreciable basis for the asset.',
    `trade_in_value` DECIMAL(18,2) COMMENT 'Credit or allowance received for the trade-in asset, reducing the net acquisition cost. Used in gain/loss calculation on asset disposal.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years, used for depreciation calculation. Determined by asset class and company depreciation policy.',
    `warranty_end_date` DATE COMMENT 'Date the manufacturer or vendor warranty coverage expires. Triggers transition to internal maintenance or extended warranty consideration.',
    `warranty_start_date` DATE COMMENT 'Date the manufacturer or vendor warranty coverage begins for the acquired asset. Used for maintenance planning and warranty claim tracking.',
    `warranty_terms` STRING COMMENT 'Description of warranty coverage terms, including what is covered, exclusions, and claim procedures. Supports warranty management and cost avoidance.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created the acquisition record. Supports audit trail and accountability for data entry.',
    CONSTRAINT pk_acquisition PRIMARY KEY(`acquisition_id`)
) COMMENT 'Records the procurement and capitalization events for fixed assets, capturing how each asset was acquired (purchase, lease, construction, donation, transfer). Tracks acquisition date, vendor/supplier reference, purchase order number, invoice number, acquisition cost, freight and installation costs, total capitalized cost, funding source, approval authority, and SAP asset acquisition document number. Links to the fixed_asset master upon capitalization. Supports GAAP/IFRS asset capitalization policy compliance and capital expenditure (CapEx) tracking against approved budgets.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`retirement` (
    `retirement_id` BIGINT COMMENT 'Unique identifier for the asset retirement record. Primary key for the asset retirement transaction.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Retiring certain assets in waste management requires permit authorization (RCRA closure permit for hazardous waste storage units, post-closure care permit for landfill cells). retirement has no permit',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Asset retirement in waste management is governed by specific regulations (RCRA closure requirements for hazardous waste units, EPA decommissioning procedures for landfill cells). retirement has enviro',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset being retired from the asset register. Links to the master asset record in the asset management system.',
    `retirement_replacement_asset_fixed_asset_id` BIGINT COMMENT 'Reference to the new asset that replaced the retired asset, if applicable. Used for asset lifecycle planning, capacity management, and capital expenditure tracking.',
    `rfid_tag_id` BIGINT COMMENT 'The RFID tag identifier assigned to the retired asset for automated tracking and inventory management. Tag should be deactivated or recovered upon retirement.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The total depreciation expense recognized on the asset from acquisition date through retirement date. Used to calculate net book value at retirement.',
    `approval_date` DATE COMMENT 'The date when the asset retirement was formally approved by the authorized signatory. Must precede or match the retirement date for control compliance.',
    `approving_authority_name` STRING COMMENT 'The name of the manager or executive who authorized the asset retirement. Required for governance and internal control compliance.',
    `asset_category` STRING COMMENT 'High-level classification of the retired asset type: CONTAINER (dumpsters, roll-offs, carts), EQUIPMENT (compactors, balers, scales), FACILITY (landfill, MRF, transfer station, WTE plant), VEHICLE (fleet rolling stock), BUILDING (administrative, maintenance shops).. Valid values are `CONTAINER|EQUIPMENT|FACILITY|VEHICLE|BUILDING`',
    `asset_subcategory` STRING COMMENT 'Detailed classification within the asset category (e.g., Front End Loader (FEL) container, stationary compactor, Materials Recovery Facility (MRF), Automated Side Loader (ASL) truck). Provides granular asset type for reporting and analysis.',
    `buyer_contact_information` STRING COMMENT 'Contact details (phone, email, address) for the buyer of the retired asset. Used for transaction documentation and warranty transfer. Business-confidential organizational contact data.',
    `buyer_name` STRING COMMENT 'The name of the individual or organization that purchased the retired asset. Applicable when retirement reason is SALE. Used for Bill of Lading (BOL) and transfer documentation.',
    `cost_center_code` STRING COMMENT 'The cost center responsible for the retired asset. Used for management accounting, budget tracking, and departmental performance analysis.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when the asset retirement record was first created in the database. Used for audit trail and data lineage tracking.',
    `disposal_cost_amount` DECIMAL(18,2) COMMENT 'The cost incurred to dispose of the retired asset, including transportation, environmental remediation, hazardous waste handling fees, and TSDF tipping fees. Reduces net proceeds in gain/loss calculation.',
    `disposal_method` STRING COMMENT 'The method used to dispose of the retired asset: AUCTION (public/private auction), TRADE_IN (traded for new equipment), DONATION (donated to charity/municipality), LANDFILL (disposed in company landfill), RECYCLING (sent to MRF for material recovery), HAZMAT_DISPOSAL (sent to TSDF for hazardous waste disposal), SALVAGE (sold for parts/scrap value). [ENUM-REF-CANDIDATE: AUCTION|TRADE_IN|DONATION|LANDFILL|RECYCLING|HAZMAT_DISPOSAL|SALVAGE — 7 candidates stripped; promote to reference product]',
    `document_number` STRING COMMENT 'The official document number generated in SAP FI-AA (Fixed Asset Accounting) module for the asset retirement transaction. Used for audit trail and financial reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `environmental_disposal_certification_number` STRING COMMENT 'The certification or manifest number issued by the EPA, state environmental agency, or TSDF confirming compliant disposal of assets containing hazardous materials (e.g., compactors with hydraulic fluid, equipment with refrigerants). Required for RCRA and CERCLA compliance.. Valid values are `^[A-Z0-9-]{8,25}$`',
    `gain_loss_amount` DECIMAL(18,2) COMMENT 'The financial gain (positive) or loss (negative) recognized on asset retirement, calculated as (sale proceeds - disposal costs - net book value). Posted to the General Ledger (GL) for financial reporting.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code in SAP FI where the gain or loss on disposal is posted. Ensures proper financial statement classification and audit trail.. Valid values are `^[0-9]{4,10}$`',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the retired asset contained or was contaminated with hazardous materials requiring special disposal procedures under RCRA or OSHA regulations. True if hazardous, False otherwise.',
    `hazardous_material_type` STRING COMMENT 'Description of the type of hazardous material contained in the retired asset (e.g., hydraulic fluid, refrigerant, lead-acid battery, PCB-containing transformer). Required for EPA manifest and TSDF acceptance.',
    `insurance_claim_number` STRING COMMENT 'The insurance claim number if the asset retirement was due to theft, damage, or casualty loss covered by insurance. Links to insurance recovery and subrogation processes.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `insurance_recovery_amount` DECIMAL(18,2) COMMENT 'The amount recovered from insurance for the retired asset. Offsets the loss on disposal in financial reporting and may affect gain/loss calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when the asset retirement record was last updated. Used for change tracking, audit trail, and data quality monitoring.',
    `net_book_value` DECIMAL(18,2) COMMENT 'The carrying value of the asset at retirement date, calculated as original acquisition cost minus accumulated depreciation. Represents the undepreciated balance being removed from the books.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special circumstances, or operational details related to the asset retirement. Provides context for future reference and audit inquiries.',
    `original_acquisition_cost` DECIMAL(18,2) COMMENT 'The original purchase price or capitalized cost of the asset when it was first acquired and placed in service. Used to calculate gain or loss on disposal.',
    `physical_location_at_retirement` STRING COMMENT 'The physical site, facility, or yard where the asset was located at the time of retirement. Used for asset tracking, inventory reconciliation, and logistics planning.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for asset retirement: SALE (sold to third party), SCRAP (scrapped/disposed), THEFT (stolen/lost), DAMAGE (irreparable damage), EOL (end of useful life), OBSOLETE (technologically obsolete).. Valid values are `SALE|SCRAP|THEFT|DAMAGE|EOL|OBSOLETE`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances and business justification for retiring the asset. Provides context beyond the standardized reason code.',
    `retirement_date` DATE COMMENT 'The effective date when the asset was officially retired from service and removed from the active asset register. Used for depreciation calculation cutoff and financial reporting.',
    `retirement_status` STRING COMMENT 'Current workflow status of the retirement transaction: PENDING (awaiting approval), APPROVED (authorized but not yet processed), COMPLETED (fully processed and posted to GL), CANCELLED (retirement request withdrawn).. Valid values are `PENDING|APPROVED|COMPLETED|CANCELLED`',
    `sale_invoice_number` STRING COMMENT 'The invoice number issued to the buyer for the sale of the retired asset. Links to Oracle Revenue Management for Accounts Receivable (AR) tracking and revenue recognition.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `sale_proceeds_amount` DECIMAL(18,2) COMMENT 'The cash or fair market value received from the sale or disposal of the retired asset. Null if asset was scrapped with no salvage value. Used to calculate gain or loss on disposal.',
    `serial_number` STRING COMMENT 'The manufacturer serial number or Container Identification (CID) number of the retired asset. Used for warranty claims, recall tracking, and disposal documentation.. Valid values are `^[A-Z0-9-]{6,30}$`',
    CONSTRAINT pk_retirement PRIMARY KEY(`retirement_id`)
) COMMENT 'Records the retirement, disposal, or write-off of fixed assets from the Waste Management asset register. Captures retirement date, retirement reason (sale, scrapping, theft, damage, end-of-life), proceeds from sale (if any), gain/loss on disposal, retirement document number in SAP FI-AA, approving authority, and environmental disposal certification (for assets containing hazardous materials such as compactors with hydraulic fluid). Ensures complete asset lifecycle closure and supports GAAP/IFRS derecognition accounting and EPA/RCRA disposal compliance.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`transfer` (
    `transfer_id` BIGINT COMMENT 'Unique identifier for the asset transfer transaction. Primary key for the asset transfer record.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset being transferred. Links to the asset master record in the asset domain.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created in Infor EAM for post-transfer maintenance or inspection. Links transfer event to maintenance execution.',
    `facility_id` BIGINT COMMENT 'Reference to the facility, plant, yard, or customer site to which the asset is being transferred. Destination location in the transfer transaction.',
    `rfid_tag_id` BIGINT COMMENT 'RFID tag identifier attached to the asset for automated tracking and scanning. Used to capture transfer events and location updates throughout the asset lifecycle.',
    `sending_facility_id` BIGINT COMMENT 'Reference to the facility, plant, yard, or customer site from which the asset is being transferred. Source location in the transfer transaction.',
    `actual_transfer_timestamp` TIMESTAMP COMMENT 'Precise date and time when the asset physically arrived at the receiving facility and custody was transferred. Captured from RFID scan, GPS telematics, or manual confirmation.',
    `approval_date` DATE COMMENT 'Date when the asset transfer was formally approved by the authorizing employee. Marks transition from pending to approved status.',
    `asset_book_value_at_transfer` DECIMAL(18,2) COMMENT 'Net book value (acquisition cost minus accumulated depreciation) of the asset at the transfer date. Used for intercompany accounting entries and financial reporting.',
    `asset_condition_at_transfer` STRING COMMENT 'Physical and operational condition assessment of the asset at the time of transfer. Used to determine maintenance requirements at receiving location and validate transfer appropriateness.. Valid values are `excellent|good|fair|poor|damaged|non_operational`',
    `carrier_name` STRING COMMENT 'Name of the transportation company or internal fleet unit responsible for moving the asset. Applicable when shipping method involves a carrier.',
    `container_cid` STRING COMMENT 'Container Identification number for waste containers (dumpsters, roll-offs, carts). Applicable when the transferred asset is a container. Links to RFID tracking systems.. Valid values are `^[A-Z0-9]{6,15}$`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to execute the asset transfer, including transportation, labor, inspection, and administrative expenses. Allocated to receiving cost center.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transfer cost amount. Typically USD for Waste Management domestic operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the asset transfer record was first created in the system. Audit trail field for data lineage and compliance.',
    `document_number` STRING COMMENT 'Externally-known business document number for the asset transfer, generated by SAP FI-AA or Infor EAM. Used for audit trail and intercompany accounting reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the asset transfer occurred. Used for financial reporting period assignment and depreciation calculation.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the asset transfer occurred. Used for financial reporting period assignment and depreciation calculation.',
    `gps_latitude_at_transfer` DECIMAL(18,2) COMMENT 'GPS latitude coordinate where the asset transfer was physically executed. Captured from Geotab telematics or AMCS platform for location verification.',
    `gps_longitude_at_transfer` DECIMAL(18,2) COMMENT 'GPS longitude coordinate where the asset transfer was physically executed. Captured from Geotab telematics or AMCS platform for location verification.',
    `intercompany_accounting_document` STRING COMMENT 'SAP FI-AA document number for the intercompany accounting entry generated by the asset transfer. Used for financial reconciliation and audit trail.. Valid values are `^[A-Z0-9]{10,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the asset transfer record was most recently updated. Audit trail field for change tracking and compliance.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special handling instructions, or observations related to the asset transfer. Used by operations and asset management teams.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business justification for the asset transfer (e.g., utilization optimization, customer contract change, facility closure, equipment upgrade, damage repair routing).. Valid values are `^[A-Z0-9]{2,10}$`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of why the asset transfer was initiated. Provides business context beyond the standardized reason code.',
    `receiving_company_code` STRING COMMENT 'SAP company code of the legal entity assuming asset ownership. Required for intercompany transfers to generate proper accounting entries.. Valid values are `^[A-Z0-9]{4}$`',
    `receiving_cost_center` STRING COMMENT 'SAP FI-CO cost center code of the receiving organizational unit. Used for intercompany accounting entries and depreciation allocation after transfer.. Valid values are `^[A-Z0-9]{4,12}$`',
    `requires_maintenance_flag` BOOLEAN COMMENT 'Indicator whether the asset requires preventive maintenance (PM) or repair work order (WO) upon arrival at receiving facility. Triggers work order creation in Infor EAM.',
    `scheduled_transfer_date` DATE COMMENT 'Planned date for the physical movement and custody change of the asset. May differ from actual transfer date due to logistics or operational constraints.',
    `sending_company_code` STRING COMMENT 'SAP company code of the legal entity relinquishing asset ownership. Required for intercompany transfers to generate proper accounting entries.. Valid values are `^[A-Z0-9]{4}$`',
    `sending_cost_center` STRING COMMENT 'SAP FI-CO cost center code of the sending organizational unit. Used for intercompany accounting entries and depreciation allocation prior to transfer.. Valid values are `^[A-Z0-9]{4,12}$`',
    `shipping_method` STRING COMMENT 'Mode of transportation used to physically move the asset from sending to receiving location. Impacts transit time and cost allocation.. Valid values are `company_fleet|third_party_carrier|customer_pickup|direct_delivery|rail|barge`',
    `source_system` STRING COMMENT 'Operational system of record that originated this asset transfer transaction. Identifies data lineage for integration and reconciliation purposes.. Valid values are `SAP_FI_AA|INFOR_EAM|AMCS_PLATFORM|MANUAL_ENTRY`',
    `source_system_record_reference` STRING COMMENT 'Primary key or unique identifier of this asset transfer record in the source operational system. Enables traceability and reconciliation back to source.. Valid values are `^[A-Z0-9]{1,50}$`',
    `tracking_number` STRING COMMENT 'Shipment tracking identifier provided by carrier or logistics system. Enables real-time visibility of asset location during transit.. Valid values are `^[A-Z0-9]{8,30}$`',
    `transfer_date` DATE COMMENT 'The business date when the asset transfer was executed and ownership/custody changed from sending to receiving facility. Used for financial period assignment and depreciation calculation cutoff in SAP FI-AA.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the asset transfer transaction. Tracks workflow progression from initiation through completion or cancellation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_transit|completed|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `transfer_type` STRING COMMENT 'Classification of the transfer transaction based on organizational scope and business purpose. Determines accounting treatment and approval workflow. [ENUM-REF-CANDIDATE: intercompany|interplant|interlocation|redeployment|consolidation|disposal_routing|customer_site_swap — 7 candidates stripped; promote to reference product]',
    `value_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the asset book value at transfer. Typically USD for Waste Management domestic operations.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_transfer PRIMARY KEY(`transfer_id`)
) COMMENT 'Records the inter-company, inter-plant, or inter-location transfer of fixed assets within the Waste Management network. Captures transfer date, sending facility, receiving facility, transfer reason (redeployment, consolidation, disposal routing), transfer document number, asset condition at transfer, and approving authority. For containers, tracks redeployment from one customer site or yard to another. Supports asset utilization optimization, intercompany accounting entries in SAP FI-AA, and container inventory balancing across districts.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`asset_inspection` (
    `asset_inspection_id` BIGINT COMMENT 'Unique identifier for the asset inspection record. Primary key.',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.asset_container. Business justification: Container inspections are among the most frequent inspection activities in Waste Management operations — containers are inspected for damage, graffiti, lid condition, and regulatory compliance. While ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Inspections are performed at specific Waste Management facilities (landfills, MRFs, transfer stations, WTE plants, maintenance shops). The asset_inspection table currently has a free-text location S',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the fixed asset being inspected (container, compactor, baler, scale, facility infrastructure, etc.).',
    `inspection_checklist_id` BIGINT COMMENT 'Identifier of the standardized inspection checklist or template used for this inspection, ensuring consistency and completeness of inspection procedures.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Individual permit conditions directly mandate specific asset inspections (Condition 4.2: inspect leachate collection system monthly; Condition 7.1: inspect landfill gas flare weekly). Linking asset_in',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Facility permits in waste management mandate specific asset inspections (landfill permit requires quarterly liner inspection, air permit requires monthly stack inspection). asset_inspection has no per',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Asset inspections in waste management are mandated by specific regulations (RCRA requires weekly container inspections, EPA requires annual tank inspections). asset_inspection has regulatory_reference',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Container and equipment inspections conducted at customer premises must reference the service_address for scheduling, customer notification, and compliance documentation. Existing facility_id covers W',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order generated as a result of this inspection, if corrective action was required. Links inspection findings to maintenance execution.',
    `approval_date` DATE COMMENT 'Date on which the inspection results were reviewed and approved by the designated authority.',
    `asset_out_of_service_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the asset was taken out of service as a result of this inspection due to safety concerns, regulatory non-compliance, or critical defects. Triggers asset status update in Infor EAM.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective actions recommended or required, including repair scope, parts needed, estimated labor hours, and priority level. Used to generate work orders and allocate maintenance resources.',
    `corrective_action_priority` STRING COMMENT 'Priority level for corrective action: critical (immediate safety or regulatory risk), high (significant operational impact), medium (scheduled repair), or low (cosmetic or deferred maintenance).. Valid values are `critical|high|medium|low`',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether corrective action (repair, replacement, or remediation) is required as a result of this inspection. Triggers work order generation in Infor EAM.',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred for performing the inspection, including labor, materials, equipment, and contractor fees. Used for cost allocation and budgeting.',
    `defect_findings` STRING COMMENT 'Free-text or structured description of specific defects identified during inspection, such as dents, cracks, leaks, rust, graffiti, missing lids, broken hinges, worn seals, hydraulic leaks, structural damage, or electrical faults. Supports root cause analysis and maintenance planning.',
    `duration_minutes` STRING COMMENT 'Total time in minutes required to complete the inspection, used for labor cost allocation, productivity analysis, and scheduling optimization.',
    `inspection_date` DATE COMMENT 'Date on which the physical inspection was performed.',
    `inspection_method` STRING COMMENT 'Method or technique used to perform the inspection: visual (walk-around observation), manual (hands-on testing), automated (RFID scan, IoT sensor), sensor_based (remote monitoring), or third_party (external contractor or certification body).. Valid values are `visual|manual|automated|sensor_based|third_party`',
    `inspection_number` STRING COMMENT 'Business-facing unique inspection number or code used for tracking and reference in work orders and compliance documentation.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection: scheduled (planned but not started), in_progress (underway), completed (finished and recorded), cancelled (not performed), or failed (inspection could not be completed due to access or safety issues).. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection was completed, supporting shift-level and real-time tracking.',
    `inspection_type` STRING COMMENT 'Category of inspection performed: routine (scheduled periodic), pre-deployment (before asset is placed in service), post-incident (after damage or accident), regulatory (mandated by EPA, OSHA, DOT), preventive maintenance (PM-driven), safety (OSHA compliance), or quality assurance. [ENUM-REF-CANDIDATE: routine|pre_deployment|post_incident|regulatory|preventive_maintenance|safety|quality_assurance — 7 candidates stripped; promote to reference product]',
    `inspector_certification_number` STRING COMMENT 'Certification or license number of the inspector, if required by regulation (e.g., DOT inspector certification, OSHA competent person designation, EPA-certified technician). Validates inspector qualifications.',
    `location` STRING COMMENT 'Physical location where the inspection was performed, such as facility name, yard, maintenance shop, customer site, or field location. Supports geographic analysis and compliance documentation.',
    `next_scheduled_inspection_date` DATE COMMENT 'Date on which the next inspection of this asset is scheduled, based on regulatory requirements, preventive maintenance schedules, or asset condition. Supports compliance tracking and proactive maintenance planning.',
    `notes` STRING COMMENT 'Additional free-text notes or observations recorded by the inspector, including context, environmental conditions, access issues, or recommendations not captured in structured fields.',
    `overall_condition_grade` STRING COMMENT 'Numeric condition rating on a 1-5 scale where 1=Excellent (no defects), 2=Good (minor wear), 3=Fair (moderate wear, functional), 4=Poor (significant defects, repair needed), 5=Critical (unsafe, immediate action required). Used for asset lifecycle and replacement planning.',
    `pass_fail_determination` STRING COMMENT 'Binary or conditional outcome of the inspection: pass (asset meets all criteria), fail (asset does not meet criteria and cannot be used), or conditional_pass (asset can be used with restrictions or minor repairs).. Valid values are `pass|fail|conditional_pass`',
    `photo_documentation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether photographic evidence was captured during the inspection. Photos are typically stored in a separate document management system and linked via inspection_id.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system, supporting audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last modified, supporting audit trail and change tracking.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this inspection was performed to satisfy a regulatory requirement from EPA, OSHA, DOT, or local enforcement agencies. Used for audit trail and compliance reporting.',
    `safety_incident_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether a safety incident or near-miss occurred during the inspection. Triggers incident reporting workflow in Enviance EHS.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection (e.g., clear, rain, snow, extreme heat), relevant for outdoor asset inspections where environmental factors may affect inspection quality or asset condition assessment.',
    CONSTRAINT pk_asset_inspection PRIMARY KEY(`asset_inspection_id`)
) COMMENT 'Records physical condition inspections performed on fixed assets including containers, compactors, balers, scales, and facility infrastructure. Captures inspection date, inspector ID, inspection type (routine, pre-deployment, post-incident, regulatory), overall condition grade (1-5 scale), specific defect findings (dents, cracks, leaks, graffiti, missing lids), pass/fail determination, corrective action required flag, and next scheduled inspection date. Integrates with Infor EAM inspection management and supports OSHA, DOT, and EPA regulatory inspection documentation requirements.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`valuation` (
    `valuation_id` BIGINT COMMENT 'Unique identifier for the asset valuation record. Primary key.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset being valued (container, facility, equipment, building, etc.).',
    `appraised_value` DECIMAL(18,2) COMMENT 'The monetary value assigned to the asset by the appraiser or valuation methodology at the valuation date, expressed in the reporting currency.',
    `appraiser_certification` STRING COMMENT 'Professional certification or credential of the appraiser (e.g., ASA, MAI, CPA, internal certification reference).',
    `appraiser_firm` STRING COMMENT 'Name of the external appraisal firm or internal department that conducted the valuation.',
    `appraiser_name` STRING COMMENT 'Name of the individual or firm that performed the valuation (internal valuation team member or external certified appraiser).',
    `approval_date` DATE COMMENT 'The date on which the valuation was formally approved for use in financial reporting or insurance negotiations.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the valuation (e.g., CFO, Controller, Asset Manager).',
    `carrying_amount` DECIMAL(18,2) COMMENT 'The book value (net book value after accumulated depreciation) of the asset at the valuation date, used for impairment comparison.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the appraised value (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `depreciation_method_used` STRING COMMENT 'The depreciation method applied in the valuation calculation: straight line, declining balance, units of production, sum of years digits, or none (for land or non-depreciable assets).. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits|none`',
    `economic_obsolescence_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the asset exhibits economic obsolescence (loss of value due to external market or regulatory factors beyond the assets control).',
    `functional_obsolescence_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the asset exhibits functional obsolescence (outdated design, inefficiency, or inability to meet current operational requirements).',
    `impairment_indicator_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this valuation identified an impairment condition (appraised value below carrying amount) requiring a write-down per GAAP ASC 360.',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'The calculated impairment loss amount if an impairment was identified (carrying amount minus fair value). Null if no impairment.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The insurance coverage amount recommended or established based on this valuation, used for property and casualty insurance policy limits.',
    `market_value_adjustment_pct` DECIMAL(18,2) COMMENT 'Percentage adjustment applied to the base valuation to reflect current market conditions, expressed as a percentage (e.g., 5.00 for 5% increase, -10.00 for 10% decrease).',
    `methodology` STRING COMMENT 'The technical approach used to determine the appraised value: cost approach (replacement cost less depreciation), market approach (comparable sales), income approach (discounted cash flow), or other industry-standard methodology.. Valid values are `cost_approach|market_approach|income_approach|depreciated_replacement_cost|comparable_sales|discounted_cash_flow`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation record was last modified.',
    `next_valuation_due_date` DATE COMMENT 'The scheduled date for the next valuation of this asset, based on policy requirements (e.g., annual insurance appraisals, quarterly impairment testing).',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, assumptions, limitations, or special considerations documented by the appraiser or valuation team.',
    `physical_condition_rating` STRING COMMENT 'Appraiser assessment of the physical condition of the asset at the valuation date: excellent (like new), good (minor wear), fair (moderate wear), poor (significant deterioration), critical (near end of life).. Valid values are `excellent|good|fair|poor|critical`',
    `purpose` STRING COMMENT 'Free-text description of the business purpose for this valuation (e.g., annual insurance renewal, quarterly impairment testing, pre-disposal assessment, merger and acquisition due diligence).',
    `replacement_cost_new` DECIMAL(18,2) COMMENT 'The estimated cost to replace the asset with a new equivalent asset at current market prices, used for insurance and capital planning.',
    `report_reference` STRING COMMENT 'Document reference number or file path to the detailed valuation report supporting this valuation record.',
    `salvage_value` DECIMAL(18,2) COMMENT 'The estimated residual value of the asset at the end of its useful life, used in depreciation and replacement cost calculations.',
    `useful_life_remaining_years` DECIMAL(18,2) COMMENT 'The estimated remaining useful life of the asset in years at the valuation date, as assessed by the appraiser.',
    `valuation_date` DATE COMMENT 'The date on which the asset valuation was performed or effective.',
    `valuation_number` STRING COMMENT 'Business identifier for the valuation event, often assigned by appraiser or internal valuation team.',
    `valuation_status` STRING COMMENT 'Current lifecycle status of the valuation record: draft (in progress), pending review (submitted for approval), approved (finalized and accepted), rejected (not accepted), superseded (replaced by a newer valuation).. Valid values are `draft|pending_review|approved|rejected|superseded`',
    `valuation_type` STRING COMMENT 'The purpose or methodology category of the valuation: insurance appraisal for coverage renewal, fair market value for financial reporting, impairment test per ASC 360, replacement cost for capital planning, liquidation value for disposal scenarios, or book value reconciliation.. Valid values are `insurance_appraisal|fair_market_value|impairment_test|replacement_cost|liquidation_value|book_value`',
    CONSTRAINT pk_valuation PRIMARY KEY(`valuation_id`)
) COMMENT 'Stores point-in-time valuation snapshots for fixed assets beyond standard depreciation, including insurance appraisals, fair market value assessments, impairment testing results, and replacement cost estimates. Captures valuation date, valuation type (insurance, impairment, fair value, replacement cost), appraised value, valuation methodology, appraiser reference, and whether an impairment write-down was triggered. Supports GAAP ASC 360 impairment testing, insurance renewal negotiations, and capital planning for asset replacement programs.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`bom` (
    `bom_id` BIGINT COMMENT 'Unique identifier for the bill of materials record.',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the parent fixed asset or stationary equipment that this BOM defines. References the complex asset (compactor, baler, WTE boiler, MRF sorting equipment) that is composed of the component parts listed in this BOM.',
    `bom_level` STRING COMMENT 'Hierarchical level of the component within the BOM structure. Level 0 is the parent asset; level 1 is a direct child assembly; level 2 is a sub-assembly of level 1, etc. Supports multi-level BOM explosion.',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM line item: active (in use), inactive (temporarily disabled), obsolete (superseded by newer component), or pending approval (engineering change pending).. Valid values are `active|inactive|obsolete|pending_approval`',
    `component_description` STRING COMMENT 'Detailed textual description of the component part, including specifications, model information, and functional purpose within the parent asset.',
    `component_part_number` STRING COMMENT 'Internal part number or SKU identifying the component part or sub-assembly within the BOM structure. Used for inventory lookup and procurement.',
    `component_type` STRING COMMENT 'Classification of the component within the BOM hierarchy: assembly (major sub-system), sub-assembly (grouped parts), part (individual component), consumable (regularly replaced item), fluid (lubricant, hydraulic fluid), or fastener (bolt, nut, washer).. Valid values are `assembly|sub_assembly|part|consumable|fluid|fastener`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM record was first created in the source system. Supports audit trail and data lineage.',
    `criticality_rating` STRING COMMENT 'Business criticality of the component to asset operation. Critical components cause immediate downtime if failed; low criticality components have minimal operational impact. Drives spare parts stocking strategy.. Valid values are `critical|high|medium|low`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost (e.g., USD, CAD, EUR). Supports multi-currency procurement.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date on which this BOM line item is superseded or retired. Null for currently active BOM lines. Enables historical BOM reconstruction for legacy assets.',
    `effective_start_date` DATE COMMENT 'Date from which this BOM line item is effective. Supports BOM versioning when component specifications change due to engineering updates or supplier changes.',
    `ehs_notes` STRING COMMENT 'Free-text field capturing environmental, health, and safety considerations for the component, including PPE requirements, disposal instructions, and regulatory compliance notes.',
    `hazmat_indicator` BOOLEAN COMMENT 'Indicates whether the component is classified as hazardous material under RCRA, DOT, or OSHA regulations (e.g., batteries, hydraulic fluids, refrigerants). Requires special handling, storage, and disposal procedures.',
    `interchangeable_part_numbers` STRING COMMENT 'Comma-separated list of alternative or equivalent part numbers that can substitute for this component. Supports flexible sourcing and reduces downtime when primary part is unavailable.',
    `is_capital_spare` BOOLEAN COMMENT 'Indicates whether the component is classified as a capital spare (high-value, long-lead-time item stocked for emergency replacement) versus a consumable or routine spare. Capital spares are capitalized on the balance sheet.',
    `is_consumable` BOOLEAN COMMENT 'Indicates whether the component is a consumable item (regularly replaced during preventive maintenance, such as filters, belts, fluids) versus a durable part. Consumables are expensed immediately.',
    `last_modified_by` STRING COMMENT 'Username or employee identifier of the person who last modified this BOM record. Tracks engineering change ownership.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM record was last updated in the source system. Tracks engineering changes and BOM revisions.',
    `lead_time_days` STRING COMMENT 'Average number of days required to procure and receive the component from the supplier. Used for preventive maintenance planning and spare parts inventory optimization.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or supplier of the component part.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer (OEM) part number for the component. Used for sourcing genuine replacement parts and warranty claims.',
    `mean_time_between_failures_hours` STRING COMMENT 'Average operating hours between failures for this component, based on historical maintenance data. Used for predictive maintenance scheduling and reliability analysis.',
    `parent_component_part_number` STRING COMMENT 'Part number of the immediate parent component in a multi-level BOM. Null for level-1 components that report directly to the parent asset. Enables hierarchical BOM navigation.',
    `position_reference` STRING COMMENT 'Physical location or position identifier of the component within the parent asset (e.g., Front Left Wheel, Hydraulic Pump #2, Conveyor Belt Section A). Aids field technicians during maintenance.',
    `quantity_required` DECIMAL(18,2) COMMENT 'Number of units of this component required to assemble or maintain one unit of the parent asset. Supports fractional quantities for consumables.',
    `recommended_replacement_interval_hours` STRING COMMENT 'Manufacturer-recommended or company-standard operating hours between scheduled replacements for this component. Drives preventive maintenance (PM) work order generation.',
    `source_system` STRING COMMENT 'Operational system of record from which this BOM record was sourced: Infor EAM (asset management), SAP PM (plant maintenance), or manual entry.. Valid values are `infor_eam|sap_pm|manual_entry`',
    `source_system_code` STRING COMMENT 'Unique identifier of this BOM record in the source operational system. Enables traceability and reconciliation with upstream systems.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of the component in US dollars. Used for total cost of ownership analysis, maintenance budgeting, and spare parts valuation.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the component quantity (e.g., each, gallon, kilogram). Aligns with inventory and procurement systems. [ENUM-REF-CANDIDATE: each|set|pair|gallon|liter|pound|kilogram|meter|foot|box|roll|sheet — 12 candidates stripped; promote to reference product]',
    `warranty_months` STRING COMMENT 'Duration of manufacturer warranty coverage for the component in months from date of installation. Used for warranty claim tracking and cost recovery.',
    `created_by` STRING COMMENT 'Username or employee identifier of the person who created this BOM record. Supports accountability and audit requirements.',
    CONSTRAINT pk_bom PRIMARY KEY(`bom_id`)
) COMMENT 'Bill of Materials (BOM) for complex fixed assets and stationary equipment, defining the component parts and sub-assemblies that make up each asset. Tracks parent asset, component part number, component description, quantity, unit of measure, manufacturer part number, criticality rating, lead time for replacement, and whether the component is a consumable or capital spare. Sourced from Infor EAM BOM management and SAP PM equipment BOM. Enables preventive maintenance planning, spare parts inventory management, and total cost of ownership analysis for compactors, balers, WTE boilers, and MRF sorting equipment.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`rfid_tag` (
    `rfid_tag_id` BIGINT COMMENT 'Unique identifier for the RFID tag record. Primary key.',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.container. Business justification: RFID_tag currently has container_id_cid STRING attribute storing the container CID, but container table exists with cid as a unique identifier. This should be a proper FK relationship (rfid_tag.contai',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key reference to the asset (container, equipment, or other trackable item) to which this RFID tag is currently attached. Null if the tag is in inventory and not yet assigned.',
    `replaced_by_tag_id` BIGINT COMMENT 'Foreign key reference to the new RFID tag that replaced this tag. Creates a chain of custody for container tracking history. Null if the tag is still active or was retired without replacement.',
    `assigned_asset_type` STRING COMMENT 'The category of asset to which this RFID tag is attached. Container is most common for waste management operations. Equipment includes compactors, balers, and scales. Vehicle tags are used for non-fleet tracking (fleet has separate DOT-compliant systems).. Valid values are `container|equipment|vehicle|facility_component|tool|other`',
    `assignment_date` DATE COMMENT 'The date when this RFID tag was assigned to a specific asset (container, equipment, or other trackable item). Marks the beginning of the tag-asset relationship for tracking and billing purposes.',
    `batch_number` STRING COMMENT 'The manufacturer batch or lot number for this RFID tag. Used for quality control, recall management, and performance analysis by production batch. If a batch shows high failure rates, all tags from that batch can be identified and replaced proactively.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this RFID tag record was first created in the system. Used for audit trails and data lineage tracking.',
    `encryption_enabled_flag` BOOLEAN COMMENT 'Indicates whether the RFID tag uses encrypted communication protocols. True for tags with built-in encryption capabilities. Encryption enhances security for sensitive applications and prevents unauthorized tag cloning.',
    `environmental_rating` STRING COMMENT 'The IP (Ingress Protection) rating indicating the tags resistance to dust and water. Waste container RFID tags typically require IP67 or higher for outdoor exposure, pressure washing, and harsh environmental conditions.. Valid values are `ip65|ip66|ip67|ip68|ip69k`',
    `epc_code` STRING COMMENT 'The unique EPC identifier encoded in the RFID tag, typically a 96-bit or 128-bit hexadecimal value conforming to GS1 EPC standards. This is the actual data read from the tag during scanning operations.. Valid values are `^[0-9A-F]{24}$`',
    `expected_lifespan_years` DECIMAL(18,2) COMMENT 'The manufacturer-specified expected operational lifespan of the RFID tag in years under normal operating conditions. Passive tags typically last 10-20 years; active tags with batteries last 3-7 years. Used for replacement forecasting and total cost of ownership calculations.',
    `frequency_band` STRING COMMENT 'The radio frequency band on which the tag operates. UHF (860-960 MHz) is standard for waste container tracking due to long read range and fast read rates. Frequency band determines reader compatibility and regulatory compliance.. Valid values are `lf_125_134_khz|hf_13_56_mhz|uhf_860_960_mhz|microwave_2_45_ghz`',
    `installation_date` DATE COMMENT 'The date when the RFID tag was physically installed or affixed to the asset. May differ from assignment_date if the tag was pre-assigned before physical installation.',
    `installation_location` STRING COMMENT 'Describes where on the asset the RFID tag is physically mounted (e.g., front panel, lid interior, side wall, handle). Important for troubleshooting read failures and ensuring consistent tag placement across the fleet.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this RFID tag record was most recently updated. Used for change tracking and data synchronization across systems.',
    `last_read_location_latitude` DECIMAL(18,2) COMMENT 'The geographic latitude coordinate where the RFID tag was last successfully read. Captured from GPS-enabled mobile readers on collection vehicles or fixed readers at facilities.',
    `last_read_location_longitude` DECIMAL(18,2) COMMENT 'The geographic longitude coordinate where the RFID tag was last successfully read. Used in conjunction with latitude for geospatial analysis and container location tracking.',
    `last_read_reader_code` STRING COMMENT 'Identifier of the RFID reader device that performed the last successful read. May be a vehicle-mounted reader, handheld scanner, or fixed portal reader. Used for reader performance analysis and troubleshooting.',
    `last_read_timestamp` TIMESTAMP COMMENT 'The most recent date and time when this RFID tag was successfully read by an RFID reader during a collection event, yard inventory scan, or other tracking operation. Used to identify potentially damaged or lost tags.',
    `memory_capacity_bytes` STRING COMMENT 'The total memory capacity of the RFID tag in bytes. Typical passive UHF tags have 96-512 bits (12-64 bytes). Larger memory allows storage of additional data such as service history, container specifications, or maintenance records directly on the tag.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, observations, or special handling instructions related to this RFID tag. May include installation challenges, special mounting requirements, or historical context.',
    `operating_temperature_max_c` DECIMAL(18,2) COMMENT 'The maximum ambient temperature in Celsius at which the RFID tag is rated to operate reliably. Important for tags on containers exposed to direct sunlight, hot climates, or high-temperature waste streams.',
    `operating_temperature_min_c` DECIMAL(18,2) COMMENT 'The minimum ambient temperature in Celsius at which the RFID tag is rated to operate reliably. Critical for tags deployed in extreme cold climates or refrigerated waste applications.',
    `purchase_order_number` STRING COMMENT 'The purchase order number under which this RFID tag was procured. Links to procurement records for vendor management, cost tracking, and audit trails.',
    `read_failure_count` STRING COMMENT 'The total number of attempted reads that failed for this RFID tag. High failure counts indicate potential tag damage, environmental interference, or reader issues requiring investigation.',
    `read_success_count` STRING COMMENT 'The total number of successful reads recorded for this RFID tag since installation. Used to assess tag performance, durability, and expected remaining lifespan.',
    `replacement_date` DATE COMMENT 'The date when this RFID tag was replaced with a new tag. Marks the end of the tags active service life. Used in conjunction with installation_date to calculate actual tag lifespan for performance analysis.',
    `replacement_reason` STRING COMMENT 'Free-text description of why the RFID tag was replaced or retired. Common reasons include physical damage, read failures, container disposal, tag upgrade, or end of service life. Used for root cause analysis and tag durability improvement.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'The signal strength of the last successful RFID tag read, measured in dBm. Typical values range from -70 dBm (weak) to -30 dBm (strong). Declining signal strength over time may indicate tag degradation or environmental factors affecting readability.',
    `tag_manufacturer` STRING COMMENT 'The name of the company that manufactured the RFID tag hardware (e.g., Alien Technology, Impinj, Avery Dennison, Confidex). Important for warranty tracking, performance characteristics, and replacement sourcing.',
    `tag_model` STRING COMMENT 'The specific model or part number of the RFID tag. Different models have varying read ranges, durability ratings, and environmental tolerances critical for outdoor waste container applications.',
    `tag_status` STRING COMMENT 'Current operational status of the RFID tag. Active tags are in service and readable. Damaged tags have been identified as non-functional during read attempts. Replaced tags have been swapped out. Retired tags are decommissioned. Lost tags cannot be located. Quarantined tags are temporarily suspended pending investigation.. Valid values are `active|damaged|replaced|retired|lost|quarantined`',
    `tag_type` STRING COMMENT 'The technology type of the RFID tag. Passive UHF tags are most common for container tracking in waste management, offering long read ranges (up to 40 feet) without battery power. Active tags include battery for extended range and sensor capabilities.. Valid values are `passive_uhf|active_uhf|passive_hf|active_hf|semi_passive|nfc`',
    `unit_cost_usd` DECIMAL(18,2) COMMENT 'The purchase cost of the individual RFID tag in USD. Used for asset valuation, inventory accounting, and cost-benefit analysis of RFID tracking programs. Passive UHF tags typically cost $0.10-$2.00; active tags cost $10-$50.',
    `warranty_expiration_date` DATE COMMENT 'The date when the manufacturer warranty for this RFID tag expires. Used for warranty claim processing and replacement planning. Typical RFID tag warranties range from 1-5 years depending on tag type and application.',
    `write_protected_flag` BOOLEAN COMMENT 'Indicates whether the RFID tag memory is write-protected (locked). True means the tag is read-only and cannot be reprogrammed. False means the tag can be rewritten. Write protection prevents accidental or malicious data modification.',
    CONSTRAINT pk_rfid_tag PRIMARY KEY(`rfid_tag_id`)
) COMMENT 'Master record for RFID tags assigned to containers and other trackable assets. Captures RFID tag ID (EPC code), tag type (passive UHF, active), tag manufacturer, tag status (active, damaged, replaced, retired), assignment date, asset it is attached to, and last read timestamp. Enables automated container identification during collection events, yard inventory counts, and customer billing verification. Integrates with AMCS Platform container tracking and Waste Logics customer portal for container-level service confirmation.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`lease` (
    `lease_id` BIGINT COMMENT 'Unique identifier for the lease contract record. Primary key.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Lease has leased_asset_category STRING describing the type of leased asset, but this should map to the asset_class hierarchy for consistent classification. Adding asset_class_id FK enables lease accou',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Equipment leases in waste management are governed by master contracts. Replacing the denormalized `contract_number` string with a proper FK to contract enables financial reporting, lease vs. contract ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key reference to the asset master record in the asset management system (Infor EAM or SAP PM). Links the lease contract to the specific asset instance being leased. May be null if lease covers multiple assets or asset not yet registered.',
    `classification_date` DATE COMMENT 'Date on which the lease was classified as operating or finance lease per ASC 842/IFRS 16 criteria. Typically the lease commencement date or the date of initial recognition.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity that is the lessee under this lease contract. Used for financial consolidation and reporting in SAP S/4HANA FI module.',
    `cost_center` STRING COMMENT 'Cost center to which lease expenses are allocated for internal management accounting and cost control. Aligns with SAP S/4HANA CO module cost center hierarchy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lease record was first created in the system. Used for audit trail and data lineage tracking.',
    `document_url` STRING COMMENT 'URL or file path to the scanned lease contract document stored in the enterprise document management system. Provides access to the original signed lease agreement for audit and reference purposes.',
    `end_date` DATE COMMENT 'Scheduled end date of the lease contract term. May be extended if renewal options are exercised. Null for perpetual or indefinite leases.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting lease expense or ROU asset amortization. Aligns with the chart of accounts in SAP S/4HANA FI module.',
    `implicit_interest_rate` DECIMAL(18,2) COMMENT 'Implicit interest rate in the lease contract, if determinable. Used to discount lease payments to present value for ROU asset and lease liability calculation. If not determinable, the lessees incremental borrowing rate is used instead.',
    `incremental_borrowing_rate` DECIMAL(18,2) COMMENT 'The rate of interest that the lessee would have to pay to borrow funds on a collateralized basis over a similar term to obtain an asset of similar value. Used as the discount rate when the implicit rate is not readily determinable.',
    `lease_status` STRING COMMENT 'Current lifecycle status of the lease contract. Active indicates the lease is in force; terminated indicates early termination; expired indicates natural end of term; renewed indicates transition to a new lease term.. Valid values are `draft|active|suspended|terminated|expired|renewed`',
    `lease_type` STRING COMMENT 'Classification of the lease as operating lease, finance lease, or capital lease per ASC 842 (US GAAP) and IFRS 16 accounting standards. Determines accounting treatment for right-of-use asset and lease liability recognition.. Valid values are `operating|finance|capital`',
    `leased_asset_description` STRING COMMENT 'Detailed description of the asset(s) covered by this lease contract. May include containers (dumpsters, roll-offs, carts), compactors, balers, scales, or other equipment used in waste collection and processing operations.',
    `liability_balance` DECIMAL(18,2) COMMENT 'Current outstanding lease liability balance on the balance sheet. Represents the present value of remaining lease payments. Reduced by principal portion of each lease payment and increased by interest accretion.',
    `modification_date` DATE COMMENT 'Date of the most recent lease modification that changed the scope or consideration of the lease. Lease modifications require remeasurement of the lease liability and ROU asset per ASC 842/IFRS 16.',
    `modification_description` STRING COMMENT 'Description of the most recent lease modification, including changes to lease term, payment amounts, or scope of leased assets. Null if no modifications have occurred.',
    `monthly_lease_payment` DECIMAL(18,2) COMMENT 'Fixed monthly payment amount due to the lessor under the lease contract. Excludes variable payments based on usage or performance. Denominated in the currency specified in payment_currency_code.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the lease contract. Used for capturing information not covered by structured fields.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for lease payment amounts (e.g., USD, CAD, EUR). All monetary fields in this lease record are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `payment_frequency` STRING COMMENT 'Frequency of lease payment obligations. Most leases are monthly; some may be quarterly or annually depending on contract terms.. Valid values are `monthly|quarterly|annually|semi_annually`',
    `purchase_option_flag` BOOLEAN COMMENT 'Indicates whether the lease contract includes an option for the lessee to purchase the leased asset at the end of the lease term or during the lease period. True if purchase option exists; False otherwise.',
    `purchase_option_price` DECIMAL(18,2) COMMENT 'Fixed purchase price or formula for calculating the purchase price if the lessee exercises the purchase option. Null if no purchase option exists or price is not predetermined.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the lease contract includes an option for the lessee to renew the lease term beyond the initial end date. True if renewal option exists; False otherwise.',
    `renewal_option_terms` STRING COMMENT 'Detailed description of renewal option terms, including renewal period duration, payment adjustments, and conditions for exercising the renewal. Null if no renewal option exists.',
    `rou_asset_value` DECIMAL(18,2) COMMENT 'Initial right-of-use asset value recognized on the balance sheet at lease commencement per ASC 842/IFRS 16. Calculated as the present value of lease payments plus initial direct costs. Amortized over the lease term.',
    `sap_lease_contract_reference` STRING COMMENT 'Reference number or document ID for the lease contract in SAP S/4HANA lease accounting module. Used for integration and reconciliation between lakehouse and SAP system of record.',
    `start_date` DATE COMMENT 'Effective start date of the lease contract. Marks the commencement of the lease term and the beginning of lease payment obligations and right-of-use asset recognition per ASC 842/IFRS 16.',
    `term_months` STRING COMMENT 'Total duration of the lease contract in months from start date to end date. Used for lease accounting calculations and amortization schedules.',
    `termination_option_flag` BOOLEAN COMMENT 'Indicates whether the lessee has the right to terminate the lease before the scheduled end date. True if early termination option exists; False otherwise.',
    `termination_penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty or fee payable by the lessee if the lease is terminated early. Null if no termination penalty applies or if termination is not permitted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this lease record was last modified. Used for audit trail, change tracking, and data synchronization.',
    CONSTRAINT pk_lease PRIMARY KEY(`lease_id`)
) COMMENT 'Master record for operating and finance leases on assets used by Waste Management, including leased containers, compactors, balers, and facility equipment. Captures lessor name, lease type (operating/finance per ASC 842/IFRS 16), lease start and end dates, monthly lease payment, right-of-use (ROU) asset value, lease liability balance, implicit interest rate, renewal options, purchase options, and SAP lease contract reference. Supports IFRS 16/ASC 842 lease accounting compliance, lease vs. buy analysis, and lease portfolio management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`warranty` (
    `warranty_id` BIGINT COMMENT 'Unique identifier for the asset warranty record. Primary key.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Equipment warranties on compactors, containers, and processing equipment are negotiated within procurement contracts. Replacing the denormalized `contract_document_reference` string with a proper FK e',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset or equipment covered by this warranty. Links to the asset master record in Infor EAM or SAP PM.',
    `claim_limit_amount` DECIMAL(18,2) COMMENT 'Maximum total dollar amount that can be claimed under this warranty over its lifetime. Null indicates unlimited coverage. Critical for high-value equipment like MRF sorting systems and WTE boilers.',
    `claim_limit_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the claim limit amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `claims_approved_count` STRING COMMENT 'Total number of warranty claims that were approved and paid by the warranty provider. Used to calculate claim approval rate and assess warranty provider responsiveness.',
    `claims_filed_count` STRING COMMENT 'Total number of warranty claims filed against this warranty to date. Used for warranty utilization tracking and vendor performance assessment.',
    `contact_email` STRING COMMENT 'Primary email address for warranty claim submission and service coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person at the warranty provider for claim submission and service coordination.',
    `contact_phone` STRING COMMENT 'Primary phone number for warranty claim submission and service requests. Critical for emergency equipment failures at MRF and WTE facilities.',
    `cost` DECIMAL(18,2) COMMENT 'Total cost paid for the warranty coverage. Zero for manufacturer warranties included with asset purchase; non-zero for extended warranties and service contracts. Used for warranty ROI analysis.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the warranty cost (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `coverage_duration_months` STRING COMMENT 'Total duration of warranty coverage expressed in months. Standard manufacturer warranties are typically 12-36 months; extended warranties may range from 12-120 months for high-value equipment.',
    `coverage_end_date` DATE COMMENT 'Date when warranty coverage expires. Critical for proactive warranty utilization planning and determining when assets transition to out-of-warranty maintenance.',
    `coverage_start_date` DATE COMMENT 'Date when warranty coverage becomes effective. Typically the asset acquisition date for manufacturer warranties or the purchase date for extended warranties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this warranty record was first created in the system. Used for audit trail and data lineage tracking.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount that must be paid by Waste Management before warranty coverage applies to each claim. Zero indicates no deductible. Common for extended warranties on high-value equipment.',
    `deductible_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deductible amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `exclusions` STRING COMMENT 'Specific items, conditions, or circumstances not covered by the warranty. Common exclusions include consumables, normal wear and tear, misuse, unauthorized modifications, and environmental damage from landfill leachate or corrosive waste.',
    `labor_coverage_flag` BOOLEAN COMMENT 'Indicates whether the warranty covers labor costs for repairs and service. True means labor is covered; false means labor must be paid separately.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this warranty record. Links to Workday HCM user master for audit purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this warranty record was last modified. Updated whenever any field in the record changes. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form notes about the warranty including special conditions, claim history, provider performance issues, or maintenance requirements to maintain warranty validity.',
    `parts_coverage_flag` BOOLEAN COMMENT 'Indicates whether the warranty covers replacement parts costs. True means parts are covered; false means parts must be purchased separately.',
    `provider_name` STRING COMMENT 'Name of the company or organization providing the warranty coverage. May be the original equipment manufacturer (OEM), third-party warranty provider, or service contractor.',
    `purchase_order_number` STRING COMMENT 'Purchase order number used to procure the extended warranty or service contract. Links to SAP MM procurement documents. Null for manufacturer warranties included with asset purchase.',
    `renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether this warranty is eligible for renewal upon expiration. True means renewal option is available; false means warranty cannot be renewed.',
    `renewal_notification_date` DATE COMMENT 'Date when Waste Management should be notified about warranty renewal options. Typically 60-90 days before coverage end date to allow procurement lead time.',
    `service_response_time_hours` STRING COMMENT 'Guaranteed maximum time in hours for warranty provider to respond to a service request. Part of warranty Service Level Agreement (SLA). Critical for high-availability equipment like MRF sorting lines and WTE boilers.',
    `terms_and_conditions` STRING COMMENT 'Full text or summary of warranty terms, conditions, exclusions, and limitations. Includes coverage scope, maintenance requirements, claim procedures, and exclusions (e.g., misuse, environmental damage, normal wear).',
    `total_claims_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total claims value (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `total_claims_value` DECIMAL(18,2) COMMENT 'Cumulative dollar value of all approved warranty claims paid under this warranty. Used for warranty ROI calculation and vendor performance assessment.',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the warranty can be transferred to a new owner if the asset is sold or relocated. True means warranty transfers with the asset; false means warranty is non-transferable.',
    `travel_coverage_flag` BOOLEAN COMMENT 'Indicates whether the warranty covers technician travel and trip charges for on-site service. Particularly relevant for remote landfill sites, transfer stations, and MRF facilities.',
    `warranty_number` STRING COMMENT 'Unique warranty certificate or policy number issued by the warranty provider. Used for warranty claim reference and tracking.',
    `warranty_status` STRING COMMENT 'Current lifecycle status of the warranty. Active indicates coverage is in effect; expired indicates coverage period has ended; cancelled indicates warranty was terminated early; suspended indicates temporary hold; pending activation indicates warranty purchased but not yet effective.. Valid values are `active|expired|cancelled|suspended|pending_activation`',
    `warranty_type` STRING COMMENT 'Classification of warranty coverage. Manufacturer warranty is included with asset purchase; extended warranty is purchased separately; comprehensive covers parts and labor; parts-only covers replacement parts; labor-only covers service labor; service contract is ongoing maintenance agreement.. Valid values are `manufacturer|extended|comprehensive|parts_only|labor_only|service_contract`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this warranty record. Links to Workday HCM user master for audit purposes.',
    CONSTRAINT pk_warranty PRIMARY KEY(`warranty_id`)
) COMMENT 'Warranty records for fixed assets and equipment, tracking manufacturer and extended warranty coverage. Captures warranty provider, warranty type (parts, labor, comprehensive), coverage start and end dates, warranty terms and conditions, claim limit, deductible amount, warranty contact information, and number of claims filed. Enables proactive warranty utilization before expiration, warranty claim tracking, and vendor performance assessment. Particularly relevant for high-value MRF sorting equipment, WTE boilers, compactors, and balers.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`capital_project` (
    `capital_project_id` BIGINT COMMENT 'Unique identifier for the capital expenditure project. Primary key.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Capital_project has asset_class STRING attribute indicating the asset class of the asset being constructed/improved, but asset_class table exists with full classification hierarchy and accounting rule',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Capital projects (landfill cell construction, MRF expansions) are executed under EPC or construction contracts. Replacing the denormalized `contract_number` with a proper FK enables capital spend trac',
    `facility_id` BIGINT COMMENT 'Reference to the primary facility or site where the capital project is being executed (landfill, MRF, transfer station, WTE plant, maintenance shop).',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the fixed asset master record created when the capital project is capitalized and transferred to the asset register.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Capital projects in waste management (landfill expansion, new transfer station, MRF upgrade) require environmental permits before construction. capital_project has permit_number and permit_status as p',
    `actual_completion_date` DATE COMMENT 'Actual date when the project was completed and ready for capitalization or operational handover.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure incurred to date on the capital project, including committed and posted costs.',
    `actual_start_date` DATE COMMENT 'Actual date when project execution commenced (first work order issued or first cost posted).',
    `approval_authority` STRING COMMENT 'Name or title of the individual or committee that approved the capital project budget (e.g., CFO, Board of Directors, Capital Committee).',
    `approval_date` DATE COMMENT 'Date when the capital project budget and scope were formally approved by the designated authority.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total capital expenditure budget approved for the project by the investment committee or board. Represents the authorized spending limit.',
    `capitalization_date` DATE COMMENT 'Date when the completed project was capitalized and transferred to fixed assets, triggering depreciation.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total amount committed via purchase orders and contracts but not yet invoiced or paid.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this project (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `environmental_permit_required` BOOLEAN COMMENT 'Indicates whether the capital project requires environmental permits from EPA, state, or local authorities (e.g., air quality permit, water discharge permit, solid waste permit).',
    `funding_source` STRING COMMENT 'Primary source of capital funding for the project: internal cash (retained earnings), debt financing (bonds/loans), equity (shareholder capital), grant (government/foundation), lease (capital lease arrangement), or public-private partnership.. Valid values are `internal_cash|debt_financing|equity|grant|lease|public_private_partnership`',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified the capital project record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was last modified.',
    `planned_completion_date` DATE COMMENT 'Target date for project completion as defined in the approved project schedule.',
    `planned_start_date` DATE COMMENT 'Scheduled date for project execution to begin, as defined in the project plan.',
    `project_name` STRING COMMENT 'Descriptive name of the capital project (e.g., Landfill Cell 7 Construction, MRF Baler Upgrade).',
    `project_notes` STRING COMMENT 'Free-form notes capturing important project milestones, issues, decisions, or other relevant information for audit and knowledge management.',
    `project_number` STRING COMMENT 'Business-facing unique project number or code assigned to the capital project for external reference and tracking.',
    `project_priority` STRING COMMENT 'Business priority ranking of the capital project: critical (regulatory/safety), high (strategic), medium (operational improvement), low (discretionary).. Valid values are `critical|high|medium|low`',
    `project_scope_description` STRING COMMENT 'Detailed narrative description of the capital project scope, objectives, deliverables, and expected business outcomes.',
    `project_status` STRING COMMENT 'Current lifecycle status of the capital project: planning (pre-approval), approved (budget authorized), in_progress (active execution), on_hold (temporarily suspended), completed (construction finished), cancelled (terminated before completion), closed (financially settled and capitalized). [ENUM-REF-CANDIDATE: planning|approved|in_progress|on_hold|completed|cancelled|closed — 7 candidates stripped; promote to reference product]',
    `project_type` STRING COMMENT 'Classification of the capital project by nature of work: new construction (greenfield facility), expansion (capacity increase), rehabilitation (major repair/refurbishment), technology upgrade (system modernization), equipment replacement (asset renewal), or environmental compliance (regulatory-driven improvements).. Valid values are `new_construction|expansion|rehabilitation|technology_upgrade|equipment_replacement|environmental_compliance`',
    `risk_level` STRING COMMENT 'Overall risk assessment of the capital project considering technical complexity, regulatory exposure, schedule constraints, and financial impact.. Valid values are `low|medium|high|critical`',
    `sap_internal_order_number` STRING COMMENT 'SAP internal order number used for cost collection and tracking for smaller capital projects not requiring full WBS structure.',
    `sap_wbs_element` STRING COMMENT 'SAP WBS element identifier for complex capital projects structured with hierarchical work breakdown for cost and schedule control.',
    `schedule_variance_days` STRING COMMENT 'Schedule variance in days calculated as actual completion date minus planned completion date. Positive values indicate delay, negative values indicate early completion.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Budget variance calculated as actual spend minus approved budget. Positive values indicate over-budget, negative values indicate under-budget.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Budget variance expressed as a percentage of approved budget: (actual spend / approved budget - 1) * 100.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created the capital project record.',
    CONSTRAINT pk_capital_project PRIMARY KEY(`capital_project_id`)
) COMMENT 'Tracks capital expenditure (CapEx) projects for asset construction, major improvements, and infrastructure expansion at Waste Management facilities. Captures project name, project type (new construction, expansion, rehabilitation, technology upgrade), sponsoring facility, approved budget, actual spend to date, project manager, start date, expected completion date, project status, and SAP internal order or WBS element reference. Manages the lifecycle from CapEx approval through asset capitalization, including landfill cell construction, MRF equipment upgrades, and WTE plant expansions.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` (
    `capital_project_expenditure_id` BIGINT COMMENT 'Unique identifier for the capital project expenditure line item. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key reference to the parent capital project (WBS element or internal order) against which this expenditure is posted. Links to the capital project master record tracking the overall asset construction or acquisition initiative.',
    `facility_id` BIGINT COMMENT 'Foreign key reference to the facility or site where the capital asset is being constructed or installed. Links expenditure to the physical location (landfill, MRF, transfer station, WTE plant, maintenance shop).',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Capital project expenditures are paid against vendor invoices. The capital project accounting process requires linking each expenditure line to its billing invoice for budget variance reporting, payme',
    `asset_class` STRING COMMENT 'The asset class or category to which the capitalized expenditure will be assigned upon asset creation. Determines depreciation method, useful life, and general ledger account assignment (e.g., Buildings, Machinery, Vehicles, Landfill Infrastructure, MRF Equipment).',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'The variance between this expenditure and the budgeted amount for the associated budget line item. Positive values indicate over-budget spending; negative values indicate under-budget. Supports project cost control and variance reporting.',
    `capitalization_eligible_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this expenditure is eligible for capitalization as part of the fixed asset cost basis. True indicates the cost will be capitalized; False indicates it will be expensed. Drives the asset acquisition cost calculation and financial statement treatment.',
    `capitalization_reason_code` STRING COMMENT 'Code indicating the reason for the capitalization eligibility determination. Values include: direct_material (materials incorporated into the asset), direct_labor (labor directly attributable to asset construction), freight_delivery (transportation costs), installation (installation and commissioning), site_preparation (site work required for asset placement), engineering_design (design and engineering services), permits_fees (regulatory permits and fees), interest_during_construction (financing costs during construction period), overhead_allocation (allocated indirect costs), non_capitalizable_expense (operating expense not eligible for capitalization), maintenance_repair (routine maintenance or repair costs). [ENUM-REF-CANDIDATE: direct_material|direct_labor|freight_delivery|installation|site_preparation|engineering_design|permits_fees|interest_during_construction|overhead_allocation|non_capitalizable_expense|maintenance_repair — 11 candidates stripped; promote to reference product]',
    `commitment_document_number` STRING COMMENT 'The document number representing the financial commitment (purchase requisition, purchase order, or contract) that reserved budget for this expenditure. Supports commitment accounting and funds reservation tracking.',
    `company_code` STRING COMMENT 'The company code (legal entity) to which this expenditure is posted. Supports multi-entity financial consolidation and legal entity-level reporting.',
    `cost_element` STRING COMMENT 'The cost element or general ledger account code to which this expenditure is classified. Represents the nature of the cost (e.g., materials, labor, equipment rental, professional services, freight). Aligns with the chart of accounts and cost accounting structure.',
    `cost_element_description` STRING COMMENT 'Human-readable description of the cost element, providing business context for the type of expenditure (e.g., Construction Materials, Engineering Services, Equipment Purchase, Site Preparation).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this expenditure record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the expenditure amount (e.g., USD, EUR, CAD). Supports multi-currency capital projects and foreign exchange tracking.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date of the originating source document (invoice date, goods receipt date, timesheet date) that triggered this expenditure posting. Used for audit trail and variance analysis between document and posting dates.',
    `expenditure_amount` DECIMAL(18,2) COMMENT 'The monetary value of this expenditure line item in the transaction currency. Represents the gross cost posted to the capital project before any adjustments, taxes, or allocations.',
    `expenditure_date` DATE COMMENT 'The date on which this expenditure was posted to the capital project in the financial system. Represents the accounting date for cost recognition, distinct from the document date or goods receipt date.',
    `expenditure_number` STRING COMMENT 'Business-readable identifier or line number for this expenditure transaction within the project accounting system. May correspond to a journal entry line, goods receipt line, or invoice line.',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number that confirmed physical receipt of materials or completion of services. Links expenditure to the three-way match process (PO, GR, Invoice) and inventory movements.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this expenditure record. Supports change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this expenditure record was last modified. Tracks the most recent change for audit and data quality purposes.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context about this expenditure. May include justification for capitalization decision, variance explanations, or special handling instructions.',
    `payment_date` DATE COMMENT 'The date on which payment was made to the vendor for this expenditure. Supports cash flow analysis and working capital management for capital projects.',
    `payment_document_number` STRING COMMENT 'The financial document number for the payment that settled this expenditure. Links to accounts payable payment run and cash management.',
    `posting_status` STRING COMMENT 'The current posting status of this expenditure in the financial system. Values: posted (successfully posted to GL and project), pending (awaiting approval or posting), reversed (posting has been reversed), cancelled (transaction cancelled before posting), parked (saved as draft, not yet posted).. Valid values are `posted|pending|reversed|cancelled|parked`',
    `purchase_order_line_item` STRING COMMENT 'The specific line item number within the purchase order that this expenditure relates to. Provides granular linkage to the ordered material or service specification.',
    `purchase_order_number` STRING COMMENT 'The purchase order number that authorized this expenditure. Links the expenditure to the procurement process and enables traceability to contract terms, pricing, and delivery schedules.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of goods or services received for this expenditure line item. Used in conjunction with unit_of_measure for materials management and unit cost analysis.',
    `reversal_date` DATE COMMENT 'The date on which this expenditure posting was reversed. Used for period-end reconciliation and financial statement adjustments.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this expenditure posting has been reversed (True) or is active (False). Supports audit trail and correction tracking.',
    `reversed_document_number` STRING COMMENT 'The document number of the reversal transaction if this expenditure has been reversed. Provides audit trail linkage between original and reversal postings.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount (sales tax, VAT, GST) associated with this expenditure. Supports tax accounting, compliance reporting, and determination of capitalizable vs. expensed tax costs.',
    `tax_code` STRING COMMENT 'The tax jurisdiction or tax code applied to this expenditure. Determines tax rate, tax type, and tax account assignment.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of measure for this expenditure. Calculated as expenditure_amount divided by quantity. Supports unit cost benchmarking and price variance analysis.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity field (e.g., EA for each, TON for tons, HR for hours, M3 for cubic meters, FT for feet). Standardizes quantity reporting across diverse materials and services.',
    `work_breakdown_structure_element` STRING COMMENT 'The WBS element code within the project hierarchy to which this expenditure is assigned. Provides granular project phase or deliverable-level cost tracking (e.g., Design Phase, Site Preparation, Equipment Installation, Commissioning).',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this expenditure record. Supports accountability and audit compliance.',
    CONSTRAINT pk_capital_project_expenditure PRIMARY KEY(`capital_project_expenditure_id`)
) COMMENT 'Line-level expenditure records posted against capital projects, capturing individual cost transactions that accumulate toward asset capitalization. Records expenditure date, cost element, vendor or internal cost center, amount, purchase order reference, goods receipt reference, and capitalization eligibility flag. Supports project cost tracking, budget variance analysis, and the determination of total capitalized cost when the asset is placed in service. Integrates with SAP FI-CO project accounting and the procurement domain PO/GR process.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`container_inventory` (
    `container_inventory_id` BIGINT COMMENT 'Unique identifier for the container inventory snapshot record.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Container_inventory tracks inventory by container_type and container_size, but these should map to asset_class for consistent valuation and accounting. Adding asset_class_id FK enables inventory valua',
    `facility_id` BIGINT COMMENT 'Identifier of the yard, maintenance shop, or staging area where the container inventory is held.',
    `average_daily_deployment` DECIMAL(18,2) COMMENT 'The average number of containers of this type and size deployed per day over the last 30 days.',
    `container_size` STRING COMMENT 'The size or capacity of the container (e.g., 2-yard, 4-yard, 6-yard, 8-yard, 10-yard, 20-yard, 30-yard, 40-yard, 64-gallon, 96-gallon).',
    `container_type` STRING COMMENT 'The type of container being inventoried (e.g., front load, rear load, roll-off, cart, compactor, recycling bin).. Valid values are `front_load|rear_load|roll_off|cart|compactor|recycling_bin`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for inventory valuation (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `cycle_count_frequency_days` STRING COMMENT 'The number of days between scheduled cycle counts for this container type and size.',
    `days_of_supply` DECIMAL(18,2) COMMENT 'The number of days the current available inventory can support based on average daily deployment rate.',
    `inventory_date` DATE COMMENT 'The date for which this inventory snapshot was recorded.',
    `inventory_status` STRING COMMENT 'The current status of this inventory record (active, inactive, frozen, under review).. Valid values are `active|inactive|frozen|under_review`',
    `last_physical_count_by` STRING COMMENT 'Name or identifier of the employee who performed the last physical inventory count.',
    `last_physical_count_date` DATE COMMENT 'The date when the last physical inventory count was performed for this container type and size at this location.',
    `lead_time_days` STRING COMMENT 'The typical lead time in days from order placement to delivery for this container type and size.',
    `material_number` STRING COMMENT 'The SAP material master number or SKU for this container type and size.',
    `next_scheduled_count_date` DATE COMMENT 'The date when the next physical inventory count is scheduled for this container type and size.',
    `notes` STRING COMMENT 'Additional notes or comments regarding this inventory record.',
    `quantity_available` STRING COMMENT 'Number of containers available for immediate deployment to customer sites.',
    `quantity_condemned` STRING COMMENT 'Number of containers marked as condemned or awaiting disposal due to irreparable damage or end of useful life.',
    `quantity_in_repair` STRING COMMENT 'Number of containers currently undergoing maintenance or repair.',
    `quantity_in_transit` STRING COMMENT 'Number of containers in transit between facilities or being relocated.',
    `quantity_on_hand` STRING COMMENT 'Total number of containers of this type and size currently in stock at the yard location.',
    `quantity_reserved` STRING COMMENT 'Number of containers reserved for scheduled deployment or customer orders.',
    `reorder_point` STRING COMMENT 'The minimum inventory level that triggers a reorder or procurement action for this container type and size.',
    `reorder_quantity` STRING COMMENT 'The standard quantity to order when inventory falls below the reorder point.',
    `storage_location_code` STRING COMMENT 'The specific storage location or bin code within the yard facility where containers are stored.',
    `total_inventory_value` DECIMAL(18,2) COMMENT 'The total value of the inventory on hand (quantity_on_hand multiplied by unit_cost).',
    `unit_cost` DECIMAL(18,2) COMMENT 'The average cost per container unit for this type and size, used for inventory valuation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory record was last updated.',
    `variance_quantity` STRING COMMENT 'The difference between the system inventory count and the last physical count (positive or negative).',
    CONSTRAINT pk_container_inventory PRIMARY KEY(`container_inventory_id`)
) COMMENT 'Snapshot inventory records of container stock held at Waste Management yards, maintenance shops, and staging areas. Tracks yard location, container type, container size, quantity on hand, quantity reserved for deployment, quantity awaiting repair, quantity condemned, and last physical count date. Enables container inventory management, reorder planning, and deployment scheduling. Supports the AMCS Platform container pool management and Waste Logics container availability queries for customer service representatives.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`asset`.`inspection_checklist` (
    `inspection_checklist_id` BIGINT COMMENT 'Primary key for inspection_checklist',
    `parent_inspection_checklist_id` BIGINT COMMENT 'Self-referencing FK on inspection_checklist (parent_inspection_checklist_id)',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Inspection checklists in waste management are built to satisfy specific regulatory requirements (RCRA Part 264 daily inspection checklist, Clean Air Act Title V equipment checklist). inspection_checkl',
    `applicable_regions` STRING COMMENT 'Comma-separated list of geographic regions, states, or jurisdictions where this inspection checklist is applicable.',
    `approved_by` STRING COMMENT 'Username or identifier of the authorized person who approved this inspection checklist for operational use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection checklist was formally approved for use.',
    `asset_subtype` STRING COMMENT 'Specific subtype or category of asset within the asset type classification (e.g., roll-off, front-load, compactor for containers).',
    `asset_type` STRING COMMENT 'Type of asset this inspection checklist applies to within the waste management infrastructure.',
    `checklist_code` STRING COMMENT 'Unique business identifier code for the inspection checklist used across systems and documentation.',
    `checklist_description` STRING COMMENT 'Detailed description of the inspection checklist including its objectives, scope, and application context.',
    `checklist_name` STRING COMMENT 'Human-readable name of the inspection checklist describing its purpose and scope.',
    `checklist_version` STRING COMMENT 'Version number of the inspection checklist to track revisions and updates over time.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection checklist record was first created in the system.',
    `critical_items` STRING COMMENT 'Number of items in the checklist that are classified as critical for safety or compliance purposes.',
    `document_url` STRING COMMENT 'Web address or file path to the detailed inspection checklist document or form template.',
    `effective_date` DATE COMMENT 'Date when this inspection checklist version becomes active and available for use.',
    `escalation_threshold` STRING COMMENT 'Number of failed critical items that triggers automatic escalation to management or safety personnel.',
    `estimated_duration_minutes` STRING COMMENT 'Expected time in minutes required to complete an inspection using this checklist.',
    `expiration_date` DATE COMMENT 'Date when this inspection checklist version is no longer valid or has been superseded by a newer version.',
    `failure_action_required` STRING COMMENT 'Mandatory action to be taken when an inspection item fails or does not meet acceptance criteria.',
    `inspection_checklist_status` STRING COMMENT 'Current lifecycle status of the inspection checklist indicating its availability for use.',
    `inspection_frequency` STRING COMMENT 'Recommended or required frequency for performing inspections using this checklist.',
    `inspection_type` STRING COMMENT 'Category of inspection this checklist supports (preventive maintenance, safety audit, regulatory compliance, etc.).',
    `integration_system` STRING COMMENT 'Enterprise asset management or maintenance system that this checklist integrates with for work order generation and tracking.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language of the checklist content.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who most recently updated this inspection checklist.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection checklist record was last updated in the system.',
    `mobile_enabled_flag` BOOLEAN COMMENT 'Indicates whether this checklist is available for use on mobile devices or field tablets.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review and update of this inspection checklist.',
    `notes` STRING COMMENT 'Additional notes, instructions, or contextual information about the inspection checklist usage and application.',
    `owner_department` STRING COMMENT 'Business department or functional area responsible for maintaining and updating this inspection checklist.',
    `photo_required_flag` BOOLEAN COMMENT 'Indicates whether photographic documentation is required as part of the inspection process.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or authority that mandates this inspection if applicable (e.g., EPA, OSHA, state environmental agency).',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this inspection checklist is mandated by regulatory or compliance requirements.',
    `required_certifications` STRING COMMENT 'Comma-separated list of certifications or qualifications required for personnel performing inspections with this checklist.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory reviews of this inspection checklist to ensure continued relevance and accuracy.',
    `safety_equipment_required` STRING COMMENT 'Personal protective equipment (PPE) and safety gear required when performing inspections using this checklist.',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether inspector signature or digital approval is required upon completion of the checklist.',
    `total_items` STRING COMMENT 'Total number of inspection items or checkpoints included in this checklist.',
    `created_by` STRING COMMENT 'Username or identifier of the person who originally created this inspection checklist.',
    CONSTRAINT pk_inspection_checklist PRIMARY KEY(`inspection_checklist_id`)
) COMMENT 'Master reference table for inspection_checklist. Referenced by checklist_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ADD CONSTRAINT `fk_asset_fixed_asset_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ADD CONSTRAINT `fk_asset_fixed_asset_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`class` ADD CONSTRAINT `fk_asset_class_parent_asset_class_id` FOREIGN KEY (`parent_asset_class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ADD CONSTRAINT `fk_asset_facility_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_acquisition_trade_in_asset_fixed_asset_id` FOREIGN KEY (`acquisition_trade_in_asset_fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `waste_management_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ADD CONSTRAINT `fk_asset_retirement_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ADD CONSTRAINT `fk_asset_retirement_retirement_replacement_asset_fixed_asset_id` FOREIGN KEY (`retirement_replacement_asset_fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ADD CONSTRAINT `fk_asset_retirement_rfid_tag_id` FOREIGN KEY (`rfid_tag_id`) REFERENCES `waste_management_ecm`.`asset`.`rfid_tag`(`rfid_tag_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ADD CONSTRAINT `fk_asset_transfer_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ADD CONSTRAINT `fk_asset_transfer_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ADD CONSTRAINT `fk_asset_transfer_rfid_tag_id` FOREIGN KEY (`rfid_tag_id`) REFERENCES `waste_management_ecm`.`asset`.`rfid_tag`(`rfid_tag_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ADD CONSTRAINT `fk_asset_transfer_sending_facility_id` FOREIGN KEY (`sending_facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ADD CONSTRAINT `fk_asset_valuation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ADD CONSTRAINT `fk_asset_bom_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ADD CONSTRAINT `fk_asset_rfid_tag_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ADD CONSTRAINT `fk_asset_rfid_tag_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ADD CONSTRAINT `fk_asset_rfid_tag_replaced_by_tag_id` FOREIGN KEY (`replaced_by_tag_id`) REFERENCES `waste_management_ecm`.`asset`.`rfid_tag`(`rfid_tag_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ADD CONSTRAINT `fk_asset_lease_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ADD CONSTRAINT `fk_asset_lease_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ADD CONSTRAINT `fk_asset_capital_project_expenditure_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `waste_management_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ADD CONSTRAINT `fk_asset_capital_project_expenditure_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ADD CONSTRAINT `fk_asset_container_inventory_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ADD CONSTRAINT `fk_asset_container_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`inspection_checklist` ADD CONSTRAINT `fk_asset_inspection_checklist_parent_inspection_checklist_id` FOREIGN KEY (`parent_inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `waste_management_ecm`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'cubic_yards|tons_per_day|gallons|square_feet|kilowatts|each');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `capacity_value` SET TAGS ('dbx_business_glossary_term' = 'Capacity Value');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `cid` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID) Number');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `cid` SET TAGS ('dbx_value_regex' = '^CID[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `current_book_value` SET TAGS ('dbx_business_glossary_term' = 'Current Book Value');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|sum_of_years_digits|units_of_production|macrs');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|scrapped|donated|traded|lost|stolen');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `lease_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Number');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|capital_lease|operating_lease|rental');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `waste_management_ecm`.`asset`.`class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`asset`.`class` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `parent_asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Class Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `asset_class_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Description');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `asset_class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `capitalization_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `capitalization_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `capitalization_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Currency');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `capitalization_threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `class_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Status');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `cost_center_default` SET TAGS ('dbx_business_glossary_term' = 'Default Cost Center');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `cost_center_default` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits|none');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `energy_consumption_tracked` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Tracked Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `environmental_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Category');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `environmental_impact_category` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `epa_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Reporting Required Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `ghg_emission_source` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emission Source Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `gl_accumulated_depreciation_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Accumulated Depreciation Account');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `gl_accumulated_depreciation_account` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `gl_asset_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Asset Account');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `gl_asset_account` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `gl_depreciation_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Depreciation Expense Account');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `gl_depreciation_account` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `gl_gain_loss_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Gain/Loss on Disposal Account');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `gl_gain_loss_account` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency in Days');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `insurance_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Type');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|reactive|condition_based|run_to_failure');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `manufacturer_warranty_months` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Warranty Period in Months');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `rcra_regulated` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Regulated Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `requires_gps_tracking` SET TAGS ('dbx_business_glossary_term' = 'Requires Global Positioning System (GPS) Tracking Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `requires_periodic_inspection` SET TAGS ('dbx_business_glossary_term' = 'Requires Periodic Inspection Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `requires_rfid_tracking` SET TAGS ('dbx_business_glossary_term' = 'Requires Radio Frequency Identification (RFID) Tracking Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `salvage_value_percentage` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value Percentage');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `serialized_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Serialized Tracking Required Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `useful_life_years_default` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Default Years');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `useful_life_years_max` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Maximum Years');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `useful_life_years_min` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Minimum Years');
ALTER TABLE `waste_management_ecm`.`asset`.`class` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Route Identifier');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Service Vehicle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation in United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Container Acquisition Cost in United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Container Acquisition Date');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `amcs_container_reference` SET TAGS ('dbx_business_glossary_term' = 'AMCS Platform Container Reference');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Container Capacity in Cubic Yards');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `cid` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID) Number');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `cid` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Container Color');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `compaction_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compaction Ratio');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Container Condition Grade');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'front_load_dumpster|rear_load_dumpster|roll_off_box|residential_cart|compactor_unit|recycling_cart');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Container Deployment Date');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Device Identifier');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `gps_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `infor_eam_asset_reference` SET TAGS ('dbx_business_glossary_term' = 'Infor Enterprise Asset Management (EAM) Asset Identifier');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `is_gps_enabled` SET TAGS ('dbx_business_glossary_term' = 'GPS Enabled Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `is_rfid_enabled` SET TAGS ('dbx_business_glossary_term' = 'RFID Enabled Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `lid_type` SET TAGS ('dbx_business_glossary_term' = 'Container Lid Type');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `lid_type` SET TAGS ('dbx_value_regex' = 'hinged|sliding|dome|flat|locking|none');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Container Manufacturer');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Container Material');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `material` SET TAGS ('dbx_value_regex' = 'steel|plastic|fiberglass|aluminum');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Container Model Number');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value in United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Container Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Container Ownership Status');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'owned|leased|customer_owned');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `retrieval_date` SET TAGS ('dbx_business_glossary_term' = 'Container Retrieval Date');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{24}$');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `sap_asset_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Number');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Container Serial Number');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `service_frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `service_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `tare_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight in Pounds (lbs)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_value_regex' = 'msw|recycling|organics|c_and_d|hazardous|universal_waste');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `air_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Air Quality Permit Number');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Facility Email Address');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `epa_facility_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Facility Identifier');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Facility Fax Number');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `hazmat_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Facility Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Environmental Management System Certified');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `iso_45001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Occupational Health and Safety Certified');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `landfill_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Landfill Projected Closure Date');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `landfill_remaining_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Landfill Remaining Capacity in Tons');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `lea_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Local Enforcement Agency (LEA) Jurisdiction');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Name');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Facility Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|operated_under_contract|joint_venture');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `permitted_capacity_tpd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Facility Phone Number');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `site_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Site Area in Acres');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `solid_waste_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Solid Waste Permit Number');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `swis_number` SET TAGS ('dbx_business_glossary_term' = 'Solid Waste Information System (SWIS) Number');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`facility` ALTER COLUMN `water_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Water Discharge Permit Number');
ALTER TABLE `waste_management_ecm`.`asset`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`location` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Driver ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Vehicle ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Location Assignment Reason');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `bay_or_pad_number` SET TAGS ('dbx_business_glossary_term' = 'Bay or Pad Number');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `bay_or_pad_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,10}$');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `building_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `cid` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID)');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `cid` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `geofence_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Geofence Zone ID');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Accuracy in Meters');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Latitude');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Longitude');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `is_billable_location` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Location');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `is_primary_location` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Location');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Date');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|temporary|pending_pickup|lost|retired');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `next_scheduled_service_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Service Date');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Location Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `placement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Placement Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{24}$');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Location Source System');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `utilization_status` SET TAGS ('dbx_business_glossary_term' = 'Utilization Status');
ALTER TABLE `waste_management_ecm`.`asset`.`location` ALTER COLUMN `utilization_status` SET TAGS ('dbx_value_regex' = 'in_use|idle|available|reserved|under_maintenance|decommissioned');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` SET TAGS ('dbx_subdomain' = 'capital_lifecycle');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition ID');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `acquisition_trade_in_asset_fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Trade-In Asset ID');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project ID');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'purchase|lease|construction|donation|transfer|trade_in');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `acquisition_number` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Number');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `budget_line_item` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Item');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN|EUR|GBP');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'operating_budget|capital_budget|grant|lease_financing|bond_proceeds|internal_cash');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `installation_cost` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `sap_asset_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Document Number');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `total_capitalized_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Capitalized Cost');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `trade_in_value` SET TAGS ('dbx_business_glossary_term' = 'Trade-In Value');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` SET TAGS ('dbx_subdomain' = 'capital_lifecycle');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `retirement_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Retirement Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `retirement_replacement_asset_fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Asset Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `approving_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Name');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'CONTAINER|EQUIPMENT|FACILITY|VEHICLE|BUILDING');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `asset_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Asset Subcategory');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `buyer_contact_information` SET TAGS ('dbx_business_glossary_term' = 'Buyer Contact Information');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `buyer_contact_information` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `disposal_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Retirement Document Number');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `environmental_disposal_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Disposal Certification Number');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `environmental_disposal_certification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,25}$');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `gain_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Gain or Loss on Disposal Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `hazardous_material_type` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Type');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `insurance_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Recovery Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Retirement Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `original_acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Acquisition Cost');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `physical_location_at_retirement` SET TAGS ('dbx_business_glossary_term' = 'Physical Location at Retirement');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason Code');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'SALE|SCRAP|THEFT|DAMAGE|EOL|OBSOLETE');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason Description');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `retirement_status` SET TAGS ('dbx_business_glossary_term' = 'Retirement Status');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `retirement_status` SET TAGS ('dbx_value_regex' = 'PENDING|APPROVED|COMPLETED|CANCELLED');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `sale_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Sale Invoice Number');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `sale_invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `sale_proceeds_amount` SET TAGS ('dbx_business_glossary_term' = 'Sale Proceeds Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` SET TAGS ('dbx_subdomain' = 'capital_lifecycle');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Transfer Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `sending_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `actual_transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Transfer Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `asset_book_value_at_transfer` SET TAGS ('dbx_business_glossary_term' = 'Asset Book Value at Transfer');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `asset_book_value_at_transfer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `asset_condition_at_transfer` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition at Transfer');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `asset_condition_at_transfer` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|damaged|non_operational');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `container_cid` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID)');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `container_cid` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Cost Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Cost Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Document Number');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `gps_latitude_at_transfer` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude at Transfer');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `gps_latitude_at_transfer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `gps_latitude_at_transfer` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `gps_longitude_at_transfer` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude at Transfer');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `gps_longitude_at_transfer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `gps_longitude_at_transfer` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `intercompany_accounting_document` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Accounting Document');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `intercompany_accounting_document` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `intercompany_accounting_document` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Code');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Description');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `receiving_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Receiving Cost Center');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `receiving_cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `requires_maintenance_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Maintenance Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `scheduled_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Transfer Date');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `sending_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Sending Cost Center');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `sending_cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'company_fleet|third_party_carrier|customer_pickup|direct_delivery|rail|barge');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_FI_AA|INFOR_EAM|AMCS_PLATFORM|MANUAL_ENTRY');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,50}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Value Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ALTER COLUMN `value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` SET TAGS ('dbx_subdomain' = 'inspection_compliance');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `asset_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Inspection Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `asset_out_of_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset Out of Service Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `corrective_action_priority` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Priority');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `corrective_action_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `defect_findings` SET TAGS ('dbx_business_glossary_term' = 'Defect Findings');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration in Minutes');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'visual|manual|automated|sensor_based|third_party');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `next_scheduled_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `overall_condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Overall Condition Grade');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `pass_fail_determination` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Determination');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `pass_fail_determination` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `photo_documentation_flag` SET TAGS ('dbx_business_glossary_term' = 'Photo Documentation Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` SET TAGS ('dbx_subdomain' = 'capital_lifecycle');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Valuation ID');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `appraised_value` SET TAGS ('dbx_business_glossary_term' = 'Appraised Value');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `appraiser_certification` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Certification');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `appraiser_firm` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Firm');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `appraiser_name` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Name');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `carrying_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrying Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `depreciation_method_used` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method Used');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `depreciation_method_used` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits|none');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `economic_obsolescence_flag` SET TAGS ('dbx_business_glossary_term' = 'Economic Obsolescence Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `functional_obsolescence_flag` SET TAGS ('dbx_business_glossary_term' = 'Functional Obsolescence Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `impairment_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `market_value_adjustment_pct` SET TAGS ('dbx_business_glossary_term' = 'Market Value Adjustment Percentage');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Valuation Methodology');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'cost_approach|market_approach|income_approach|depreciated_replacement_cost|comparable_sales|discounted_cash_flow');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `next_valuation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Valuation Due Date');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Valuation Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `physical_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Physical Condition Rating');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `physical_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Valuation Purpose');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `replacement_cost_new` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost New');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `report_reference` SET TAGS ('dbx_business_glossary_term' = 'Valuation Report Reference');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `useful_life_remaining_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Remaining (Years)');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_number` SET TAGS ('dbx_business_glossary_term' = 'Valuation Number');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|superseded');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `waste_management_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'insurance_appraisal|fair_market_value|impairment_test|replacement_cost|liquidation_value|book_value');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `bom_level` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Level');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `component_part_number` SET TAGS ('dbx_business_glossary_term' = 'Component Part Number');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'assembly|sub_assembly|part|consumable|fluid|fastener');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `ehs_notes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Health and Safety (EHS) Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `interchangeable_part_numbers` SET TAGS ('dbx_business_glossary_term' = 'Interchangeable Part Numbers');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `is_capital_spare` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Spare Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `is_consumable` SET TAGS ('dbx_business_glossary_term' = 'Is Consumable Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Hours');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `parent_component_part_number` SET TAGS ('dbx_business_glossary_term' = 'Parent Component Part Number');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `position_reference` SET TAGS ('dbx_business_glossary_term' = 'Position Reference');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `quantity_required` SET TAGS ('dbx_business_glossary_term' = 'Quantity Required');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `recommended_replacement_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'Recommended Replacement Interval (Hours)');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'infor_eam|sap_pm|manual_entry');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost (USD)');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `warranty_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `waste_management_ecm`.`asset`.`bom` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Asset ID');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `replaced_by_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Replaced By Tag ID');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `assigned_asset_type` SET TAGS ('dbx_business_glossary_term' = 'Assigned Asset Type');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `assigned_asset_type` SET TAGS ('dbx_value_regex' = 'container|equipment|vehicle|facility_component|tool|other');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Date');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Batch Number');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `encryption_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `environmental_rating` SET TAGS ('dbx_business_glossary_term' = 'Ingress Protection (IP) Environmental Rating');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `environmental_rating` SET TAGS ('dbx_value_regex' = 'ip65|ip66|ip67|ip68|ip69k');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `epc_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Product Code (EPC)');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `epc_code` SET TAGS ('dbx_value_regex' = '^[0-9A-F]{24}$');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `expected_lifespan_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Tag Lifespan in Years');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency (RF) Band');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `frequency_band` SET TAGS ('dbx_value_regex' = 'lf_125_134_khz|hf_13_56_mhz|uhf_860_960_mhz|microwave_2_45_ghz');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Tag Installation Date');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `installation_location` SET TAGS ('dbx_business_glossary_term' = 'Tag Installation Location on Asset');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `last_read_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Last Read Location Latitude');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `last_read_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `last_read_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `last_read_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Last Read Location Longitude');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `last_read_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `last_read_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `last_read_reader_code` SET TAGS ('dbx_business_glossary_term' = 'Last Read RFID Reader ID');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `last_read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Read Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `memory_capacity_bytes` SET TAGS ('dbx_business_glossary_term' = 'Tag Memory Capacity in Bytes');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tag Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `operating_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Temperature in Celsius');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `operating_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Temperature in Celsius');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `read_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Read Failure Count');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `read_success_count` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Read Success Count');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Tag Replacement Date');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `replacement_reason` SET TAGS ('dbx_business_glossary_term' = 'Tag Replacement Reason');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Last Read Signal Strength in Decibels-Milliwatts (dBm)');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `tag_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Tag Manufacturer Name');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `tag_model` SET TAGS ('dbx_business_glossary_term' = 'Tag Model Number');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `tag_status` SET TAGS ('dbx_business_glossary_term' = 'RFID Tag Status');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `tag_status` SET TAGS ('dbx_value_regex' = 'active|damaged|replaced|retired|lost|quarantined');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `tag_type` SET TAGS ('dbx_business_glossary_term' = 'RFID Tag Type');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `tag_type` SET TAGS ('dbx_value_regex' = 'passive_uhf|active_uhf|passive_hf|active_hf|semi_passive|nfc');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Tag Unit Cost in United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `unit_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tag Warranty Expiration Date');
ALTER TABLE `waste_management_ecm`.`asset`.`rfid_tag` ALTER COLUMN `write_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'Write Protection Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `classification_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Classification Date');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Lease Document URL');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `implicit_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Implicit Interest Rate');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `incremental_borrowing_rate` SET TAGS ('dbx_business_glossary_term' = 'Incremental Borrowing Rate');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Status');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|renewed');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'operating|finance|capital');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `leased_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Leased Asset Description');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `liability_balance` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Balance');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `modification_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Modification Date');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `modification_description` SET TAGS ('dbx_business_glossary_term' = 'Lease Modification Description');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `monthly_lease_payment` SET TAGS ('dbx_business_glossary_term' = 'Monthly Lease Payment Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lease Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|semi_annually');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `purchase_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Purchase Option Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `purchase_option_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Option Price');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `renewal_option_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Terms');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `rou_asset_value` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Value');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `sap_lease_contract_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Lease Contract Reference');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Start Date');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Lease Term in Months');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `termination_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination Option Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Termination Penalty Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Warranty Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `claim_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Limit Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `claim_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Limit Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `claim_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `claims_approved_count` SET TAGS ('dbx_business_glossary_term' = 'Claims Approved Count');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `claims_filed_count` SET TAGS ('dbx_business_glossary_term' = 'Claims Filed Count');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Warranty Contact Email Address');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Warranty Contact Name');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Warranty Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Warranty Cost');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Warranty Cost Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `coverage_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Coverage Duration in Months');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `deductible_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Deductible Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `deductible_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Warranty Exclusions');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `labor_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Labor Coverage Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warranty Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `parts_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts Coverage Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Warranty Provider Name');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligible Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `renewal_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Date');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `service_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Response Time in Hours');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms and Conditions');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `total_claims_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Total Claims Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `total_claims_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `total_claims_value` SET TAGS ('dbx_business_glossary_term' = 'Total Claims Value');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `travel_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Travel Coverage Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Number');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|suspended|pending_activation');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'manufacturer|extended|comprehensive|parts_only|labor_only|service_contract');
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` SET TAGS ('dbx_subdomain' = 'capital_lifecycle');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project ID');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `environmental_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Required');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal_cash|debt_financing|equity|grant|lease|public_private_partnership');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `project_notes` SET TAGS ('dbx_business_glossary_term' = 'Project Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `project_priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `project_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `project_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Project Scope Description');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_construction|expansion|rehabilitation|technology_upgrade|equipment_replacement|environmental_compliance');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `sap_internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Internal Order Number');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance Days');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` SET TAGS ('dbx_subdomain' = 'capital_lifecycle');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `capital_project_expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Expenditure ID');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project ID');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Class');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `capitalization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligible Flag');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `capitalization_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Reason Code');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `commitment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Document Number');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `cost_element_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Description');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Source Document Date');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `expenditure_date` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Posting Date');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `expenditure_number` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Line Number');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|cancelled|parked');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `purchase_order_line_item` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Quantity');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `work_breakdown_structure_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `container_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Container Inventory ID');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Yard Facility ID');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `average_daily_deployment` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Deployment');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `container_size` SET TAGS ('dbx_business_glossary_term' = 'Container Size');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'front_load|rear_load|roll_off|cart|compactor|recycling_bin');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency Days');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Date');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|frozen|under_review');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `last_physical_count_by` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count By');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `next_scheduled_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Count Date');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `quantity_condemned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Condemned');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `quantity_in_repair` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Repair');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `quantity_in_transit` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Transit');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`asset`.`container_inventory` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `waste_management_ecm`.`asset`.`inspection_checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`asset`.`inspection_checklist` SET TAGS ('dbx_subdomain' = 'inspection_compliance');
ALTER TABLE `waste_management_ecm`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Identifier');
ALTER TABLE `waste_management_ecm`.`asset`.`inspection_checklist` ALTER COLUMN `parent_inspection_checklist_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`inspection_checklist` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`asset`.`inspection_checklist` ALTER COLUMN `mobile_enabled_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`asset`.`inspection_checklist` ALTER COLUMN `mobile_enabled_flag` SET TAGS ('dbx_pii_phone' = 'true');
