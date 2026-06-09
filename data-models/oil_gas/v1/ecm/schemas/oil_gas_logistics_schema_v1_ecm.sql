-- Schema for Domain: logistics | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`logistics` COMMENT 'Manages transportation and movement of crude oil, natural gas, LNG, LPG, NGLs, and refined products across pipelines, tankers, trucks, and rail. Owns shipping schedules, pipeline nominations, FPSO liftings, custody transfer records, tariff rates, delivery scheduling, and carrier management. Aligns with PHMSA pipeline safety regulations and FERC tariff reporting requirements. Integrates with SCADA pipeline monitoring systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment record. Primary key for the shipment entity.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier or service provider responsible for moving the shipment. Links to carrier/vendor master data.',
    `commercial_term_contract_id` BIGINT COMMENT 'Identifier of the sales contract, offtake agreement, or transportation service agreement under which this shipment is executed. Links to contract master data.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: International shipments trigger customs declarations, export control filings, and hazmat notifications. Compliance teams link shipment to the regulatory filing for audit trail, ensuring all cross-bord',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shipments incur freight costs that must be allocated to cost centers for operational expense tracking, AFE accounting, and budget variance analysis in oil & gas operations.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Shipments are executed for/to specific customers. Essential for revenue recognition, customer service tracking, delivery performance monitoring, and customer satisfaction reporting. Oil & gas operatio',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility, terminal, refinery, or delivery point where the shipment is destined. Links to facility master data.',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key linking to drilling.afe. Business justification: Drilling shipments are authorized and budgeted under specific AFEs. Links freight costs to capital authorization for budget variance tracking, JIB allocation, and working interest billing. Required fo',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Drilling materials (casing, cement, mud chemicals, BOP equipment) are shipped to specific well locations. Links shipment to well for AFE cost tracking, material receipt verification, and supply chain ',
    `employee_id` BIGINT COMMENT 'Identifier of the driver assigned to the truck shipment. Applicable only for truck transport mode. Used for driver performance tracking and DOT compliance.',
    `hse_training_record_id` BIGINT COMMENT 'Foreign key linking to hse.training_record. Business justification: Shipments require trained personnel (hazmat certification, confined space). Links shipment to operator training record for competency verification and regulatory compliance (DOT, OSHA).',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Shipments from joint venture assets require JOA reference for partner cost allocation, lifting entitlement reconciliation, custody transfer validation, and JIB billing. Essential for overlift/underlif',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Crude/gas shipments originate from leased production areas. Operators must track originating lease for royalty calculation, revenue allocation to working interest owners, and JIB statement preparation',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Early production systems (EPS) and extended well tests ship crude/gas directly from exploration wells before field development. Required for production accounting, revenue allocation, and regulatory r',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Shipments originate from terminals (marine terminals, pipeline terminals). Adding origin_terminal_id FK allows joining to get terminal details (capacity, operator, location). Removes denormalized orig',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Shipments of hazardous crude/refined products require environmental and transport permits. Operations verify permit validity before authorizing shipment. Real-world compliance tracking links each ship',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Shipments involving hot work, confined space entry at terminals require PTW. Links shipment to safety authorization for work scope definition and hazard control verification.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Shipments transport specific petroleum products; FK required for pricing calculation, quality specification verification, regulatory compliance (EPA fuel category, hazmat classification), tariff deter',
    `pipeline_nomination_id` BIGINT COMMENT 'Identifier linking this shipment to the pipeline nomination record submitted to the pipeline operator. Applicable only for pipeline transport mode. Critical for FERC compliance and capacity allocation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Shipments represent product movements that impact profit center P&L through freight costs and revenue realization, required for segment reporting and profitability analysis.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA-governed shipments must distinguish cost recovery oil/gas from profit oil/gas for contractor/government entitlement calculation, fiscal regime compliance, and government take reporting. Critical f',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Crude oil and gas shipments must track source reservoir for custody transfer documentation, royalty calculations, production accounting, and PSA/JOA revenue allocation. Essential for fiscal metering a',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: Equipment and consumables (drill bits, BHA components, mud additives, fuel) are shipped directly to rig locations, especially offshore. Enables rig-specific logistics tracking, supply vessel schedulin',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.settlement. Business justification: Shipments require price/volume settlements when final measurements differ from nominations. Links logistics actuals to revenue adjustments for true-up billing and contract compliance.',
    `shipment_asset_facility_id` BIGINT COMMENT 'Identifier of the facility, terminal, wellhead, or production site where the shipment originates. Links to facility master data.',
    `shipper_id` BIGINT COMMENT 'Foreign key linking to logistics.shipper. Business justification: Shipment must reference the owning shipper; shipper was previously isolated. Adding shipment.shipper_id creates a valid 1:N relationship (many shipments per shipper) without causing a bidirectional li',
    `truck_ticket_id` BIGINT COMMENT 'Foreign key linking to logistics.truck_ticket. Business justification: Truck shipments generate truck tickets. Adding truck_ticket_id FK allows joining to get detailed truck loading/dispatch information. Removes denormalized truck_ticket_number string.',
    `voyage_id` BIGINT COMMENT 'Foreign key linking to logistics.voyage. Business justification: Marine shipments are executed via voyages. Adding voyage_id FK allows joining to get voyage details (vessel, charter party, freight terms). Removes denormalized marine_voyage_reference string.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment arrived at the destination facility. Used for on-time delivery metrics and demurrage calculations.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment departed from the origin facility. Critical for performance tracking and demurrage calculations.',
    `actual_volume` DECIMAL(18,2) COMMENT 'Actual quantity of product shipped as measured at custody transfer point. May differ from nominated volume due to operational constraints or measurement adjustments.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement of the crude oil or petroleum product, indicating its density relative to water. Critical quality parameter for pricing and refining yield calculations.',
    `bill_of_lading_number` STRING COMMENT 'Unique document number for the bill of lading or waybill that serves as the legal contract of carriage and receipt for the shipment. Required for custody transfer and legal compliance.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `bsw_percentage` DECIMAL(18,2) COMMENT 'Percentage of basic sediment and water content in the crude oil shipment. Critical quality parameter affecting net volume calculations and product value.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment record was first created in the system. Used for audit trail and data lineage tracking.',
    `custody_transfer_status` STRING COMMENT 'Status of the custody transfer process indicating whether ownership and responsibility for the product has been formally transferred at origin and destination measurement points.. Valid values are `pending|origin_transferred|in_transit|destination_received|completed|disputed`',
    `destination_location_name` STRING COMMENT 'Human-readable name of the destination facility or terminal for business user reference and reporting.',
    `fpso_lifting_reference` STRING COMMENT 'Unique reference number for the crude oil lifting operation from an FPSO vessel. Applicable only for FPSO lifting transport mode. Used for offshore production tracking and cargo scheduling.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Total freight transportation cost for this shipment. Calculated based on tariff rate, volume, and distance. Critical for OPEX tracking and profitability analysis.',
    `freight_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight cost amount.. Valid values are `^[A-Z]{3}$`',
    `hse_incident_flag` BOOLEAN COMMENT 'Boolean indicator of whether any HSE incident (spill, release, injury, near-miss) occurred during this shipment. True indicates an incident was reported. Used for safety performance tracking and regulatory reporting.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining the responsibilities of buyers and sellers for delivery, risk transfer, and cost allocation in international shipments. EXW (Ex Works), FCA (Free Carrier), FOB (Free On Board), CIF (Cost Insurance and Freight), etc. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `loading_rack_number` STRING COMMENT 'Identifier of the loading rack or bay at the origin terminal where the truck was loaded. Applicable for truck transport mode. Used for operational tracking and throughput analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment record was last modified. Used for audit trail and change tracking.',
    `nominated_volume` DECIMAL(18,2) COMMENT 'Planned or nominated quantity of product to be shipped, expressed in the unit of measure specified. Used for capacity planning and pipeline nominations.',
    `rail_car_initial` STRING COMMENT 'Reporting mark or initial letters identifying the owner or lessor of the rail car. Applicable only for rail transport mode.. Valid values are `^[A-Z]{2,4}$`',
    `rail_car_number` STRING COMMENT 'Unique numeric identifier of the rail car used for the shipment. Combined with rail car initial forms the complete rail car identification. Applicable only for rail transport mode.. Valid values are `^[0-9]{1,6}$`',
    `rail_gross_weight` DECIMAL(18,2) COMMENT 'Total gross weight of the rail shipment including product and rail car tare weight, typically in pounds or metric tons. Applicable for rail transport mode.',
    `rail_net_weight` DECIMAL(18,2) COMMENT 'Net weight of the product after subtracting rail car tare weight. Represents the actual product weight for billing and custody transfer. Applicable for rail transport mode.',
    `rail_number_of_cars` STRING COMMENT 'Total number of rail cars in the shipment consist or unit train. Applicable only for rail transport mode.',
    `rail_scac_code` STRING COMMENT 'Four-letter code identifying the railroad carrier for rail shipments. Required for rail waybill processing and freight billing. Applicable only for rail transport mode.. Valid values are `^[A-Z]{2,4}$`',
    `rail_un_hazmat_number` STRING COMMENT 'Four-digit UN number identifying the hazardous material classification for the rail shipment (e.g., UN1203 for gasoline, UN1267 for crude oil). Required for DOT/PHMSA hazmat compliance. Applicable for rail transport mode.. Valid values are `^UN[0-9]{4}$`',
    `reference_number` STRING COMMENT 'Externally-known unique business identifier for the shipment used across systems and with external parties. Typically alphanumeric code assigned at shipment creation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `scheduled_arrival_timestamp` TIMESTAMP COMMENT 'Planned date and time when the shipment is scheduled to arrive at the destination facility. Used for receiving planning and resource allocation.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned date and time when the shipment is scheduled to depart from the origin facility. Used for logistics planning and coordination.',
    `seal_numbers` STRING COMMENT 'Comma-separated list of security seal numbers applied to the shipment container, truck, rail car, or pipeline valve. Used for tamper detection and chain of custody verification.',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment indicating its position in the transportation workflow from planning through completion or cancellation. [ENUM-REF-CANDIDATE: planned|nominated|scheduled|in_transit|arrived|completed|cancelled|delayed|on_hold — 9 candidates stripped; promote to reference product]',
    `tariff_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tariff rate (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `tariff_rate` DECIMAL(18,2) COMMENT 'Transportation tariff rate applied to this shipment, typically expressed per unit of volume or distance. Used for freight cost calculation and FERC tariff compliance reporting.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Temperature of the product at the time of measurement or loading, expressed in degrees Fahrenheit. Required for volume correction calculations per API standards.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used for this shipment. Determines applicable regulations, cost structures, and operational procedures.. Valid values are `pipeline|tanker|truck|rail|barge|fpso_lifting`',
    `truck_gross_volume` DECIMAL(18,2) COMMENT 'Gross volume loaded into the truck before adjustments for temperature, BS&W, or other factors. Applicable for truck transport mode.',
    `truck_net_volume` DECIMAL(18,2) COMMENT 'Net volume after adjustments for temperature, BS&W, and other quality factors. Represents the actual saleable product volume. Applicable for truck transport mode.',
    `truck_registration_number` STRING COMMENT 'License plate or registration number of the truck used for the shipment. Applicable only for truck transport mode. Required for DOT compliance and incident tracking.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for the nominated and actual volumes. BBL (Barrel), BOE (Barrel of Oil Equivalent), MMBTU (Million British Thermal Units), MCF (Thousand Cubic Feet), MMCF (Million Cubic Feet), GAL (Gallon), MT (Metric Ton), LB (Pound). [ENUM-REF-CANDIDATE: BBL|BOE|MMBTU|MCF|MMCF|GAL|MT|LB — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Core master entity representing a discrete movement of petroleum products (crude oil, LNG, LPG, NGLs, refined products) from origin to destination across all transport modes. Captures shipment reference number, cargo type, product grade, nominated and actual volumes (BOE/BBL/MMCFD), origin and destination terminals or facilities, transport mode (pipeline, tanker, truck, rail, FPSO lifting), scheduled and actual departure/arrival timestamps, shipment status, carrier assignment, bill of lading or waybill number, custody transfer status, INCOTERMS, and mode-specific detail records: for truck — driver ID, truck registration, loading rack, gross/net volume, API gravity, temperature, BS&W, seal numbers, ticket number; for rail — railroad SCAC code, car initial and number, UN hazmat number, number of cars, gross/net weight, hazmat placard requirements, waybill number and status; for marine — voyage reference. Serves as the SSOT for cargo movement identity across the logistics domain regardless of transport mode, with DOT/PHMSA compliance for road and rail movements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` (
    `pipeline_nomination_id` BIGINT COMMENT 'Unique identifier for the pipeline nomination transaction. Primary key for the pipeline nomination record.',
    `commercial_counterparty_id` BIGINT COMMENT 'Identifier of the shipper or customer submitting the nomination to transport product through the pipeline.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pipeline nominations may incur imbalance costs or penalties requiring cost center allocation for pipeline operations accounting and transportation expense tracking.',
    `delivery_point_id` BIGINT COMMENT 'Identifier of the physical location or delivery point where the product will exit the pipeline system after transportation.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Pipeline nominations from joint venture fields require JOA reference for partner entitlement allocation, nomination rights verification, tariff cost sharing, and capacity allocation per working intere',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Pipeline nominations specify originating lease for production transported through pipelines. Required for tariff billing allocation, royalty owner revenue distribution, FERC/PHMSA regulatory reporting',
    `measurement_point_id` BIGINT COMMENT 'Identifier of the physical location or delivery point where the product will enter the pipeline system for transportation.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Pipeline operations require operating permits from FERC/state agencies. Nominations must reference the permit authorizing transport on that segment. Compliance teams verify permit coverage before acce',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Pipeline nominations specify exact product being transported through pipeline system; FK needed for FERC tariff rate application, quality specification enforcement, contract compliance verification, a',
    `pipeline_segment_id` BIGINT COMMENT 'Identifier of the specific pipeline segment or route through which the product will be transported.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Pipeline nominations represent product movements that impact profit center economics through transportation costs and product delivery performance.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Pipeline nominations specify source reservoir for production scheduling, allocation among joint venture partners, and contract compliance. Operators must track which reservoir supplies are nominated f',
    `co2_content_percent` DECIMAL(18,2) COMMENT 'The percentage of carbon dioxide in the gas stream, a key quality specification affecting heating value and pipeline corrosion potential.',
    `confirmed_volume` DECIMAL(18,2) COMMENT 'The actual volume confirmed by the pipeline operator after capacity allocation and scheduling, which may differ from the nominated volume due to pipeline constraints or pro-rationing.',
    `confirmed_volume_uom` STRING COMMENT 'Unit of measure for the confirmed volume, matching the nominated volume unit of measure convention.. Valid values are `BOPD|MMCFD|MCFD|BBL|MCF|MMCF`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this nomination record was first created in the system for audit trail and data lineage purposes.',
    `crude_api_gravity` DECIMAL(18,2) COMMENT 'The API gravity of crude oil, a measure of density relative to water. Higher API gravity indicates lighter, more valuable crude oil.',
    `crude_sulfur_content_percent` DECIMAL(18,2) COMMENT 'The percentage of sulfur in crude oil. Lower sulfur content indicates sweet crude, higher content indicates sour crude, affecting refining requirements and product value.',
    `cut_volume` DECIMAL(18,2) COMMENT 'The volume reduction applied to the nomination due to pipeline capacity constraints, calculated as nominated volume minus confirmed volume.',
    `ferc_tariff_code` STRING COMMENT 'The FERC tariff code applicable to this nomination, defining the transportation rate, terms, and conditions under which the product will be transported.',
    `gas_heating_value_btu_per_scf` DECIMAL(18,2) COMMENT 'The heating value of natural gas in BTU per standard cubic foot, a key quality specification for gas pipeline nominations to ensure the gas meets pipeline quality standards.',
    `gas_specific_gravity` DECIMAL(18,2) COMMENT 'The specific gravity of natural gas relative to air, used to characterize gas composition and quality for pipeline transportation.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'The concentration of hydrogen sulfide in the gas stream measured in parts per million. Critical safety and quality parameter as H2S is toxic and corrosive.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this nomination record was last updated in the system, tracking the most recent change for audit and data quality purposes.',
    `nominated_volume` DECIMAL(18,2) COMMENT 'The volume of crude oil or natural gas that the shipper requests to transport through the pipeline segment during the scheduling cycle.',
    `nominated_volume_uom` STRING COMMENT 'Unit of measure for the nominated volume. BOPD for crude oil (Barrels of Oil Per Day), MMCFD for natural gas (Million Cubic Feet per Day), MCFD (Thousand Cubic Feet per Day), BBL (Barrels), MCF (Thousand Cubic Feet), MMCF (Million Cubic Feet).. Valid values are `BOPD|MMCFD|MCFD|BBL|MCF|MMCF`',
    `nomination_cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the nomination was cancelled by either the shipper or pipeline operator, if applicable.',
    `nomination_confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the pipeline operator confirmed the nomination and communicated the scheduled volume back to the shipper.',
    `nomination_cycle_type` STRING COMMENT 'The scheduling cycle period for the nomination indicating the frequency and timing window for pipeline capacity allocation.. Valid values are `intraday|daily|monthly|weekly`',
    `nomination_effective_date` DATE COMMENT 'The gas day or operational date for which the nominated volume is scheduled to flow through the pipeline.',
    `nomination_reference_number` STRING COMMENT 'External business identifier for the nomination used by shippers and pipeline operators for tracking and communication purposes.',
    `nomination_status` STRING COMMENT 'Current lifecycle status of the nomination indicating its position in the pipeline scheduling workflow from submission through final confirmation or rejection.. Valid values are `submitted|confirmed|cut|scheduled|rejected|cancelled`',
    `nomination_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the shipper submitted the nomination to the pipeline operator for scheduling consideration.',
    `operator_notes` STRING COMMENT 'Free-text notes entered by the pipeline operator regarding special handling, scheduling constraints, quality issues, or other operational considerations for this nomination.',
    `phmsa_pipeline_code` STRING COMMENT 'The PHMSA operator identification number for the pipeline system, required for regulatory reporting and safety compliance tracking.',
    `priority_class` STRING COMMENT 'The service priority level of the nomination determining scheduling precedence. Firm service has highest priority, interruptible service is subject to curtailment, and secondary service uses available capacity.. Valid values are `firm|interruptible|secondary`',
    `proration_factor` DECIMAL(18,2) COMMENT 'The proration or allocation factor applied when pipeline capacity is oversubscribed, calculated as confirmed volume divided by nominated volume. A factor less than 1.0 indicates the nomination was cut.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether this nomination is integrated with the SCADA pipeline monitoring system for real-time flow measurement and custody transfer validation.',
    `shipper_contact_email` STRING COMMENT 'Email address of the shipper contact for nomination confirmations, scheduling updates, and operational communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `shipper_contact_name` STRING COMMENT 'Name of the shipper representative or scheduler who submitted the nomination for operational coordination and communication purposes.',
    `shipper_contact_phone` STRING COMMENT 'Phone number of the shipper contact for operational coordination and urgent communication regarding the nomination.',
    `transportation_rate` DECIMAL(18,2) COMMENT 'The tariff rate charged for transporting the product through the pipeline, typically expressed per unit volume (e.g., dollars per barrel or dollars per MCF).',
    `transportation_rate_uom` STRING COMMENT 'Unit of measure for the transportation rate, such as USD per barrel for crude oil or USD per thousand cubic feet for natural gas.. Valid values are `USD_per_BBL|USD_per_MCF|USD_per_MMCF`',
    `water_content_lbs_per_mmcf` DECIMAL(18,2) COMMENT 'The water content in the gas stream measured in pounds per million cubic feet, critical for preventing hydrate formation and pipeline corrosion.',
    CONSTRAINT pk_pipeline_nomination PRIMARY KEY(`pipeline_nomination_id`)
) COMMENT 'Transactional record of a shippers nomination to move a specified volume of crude oil or natural gas through a pipeline segment during a scheduling cycle. Captures nomination reference, shipper ID, pipeline segment, nomination cycle (intraday, daily, monthly), nominated volume (BOPD or MMCFD), confirmed volume, priority class, gas quality specifications, nomination status (submitted, confirmed, cut, scheduled), FERC tariff code, and PHMSA pipeline ID. Integrates with SCADA pipeline monitoring and FERC tariff reporting requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` (
    `logistics_lifting_schedule_id` BIGINT COMMENT 'Unique identifier for the logistics lifting schedule record. Primary key for the lifting schedule master planning entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lifting operations incur costs (demurrage, freight) that must be charged to cost centers for upstream operations accounting and production expense tracking.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Lifting schedules coordinate customer offtake under PSAs and JOAs. Essential for entitlement tracking, customer relationship management, and equity allocation. Links operational lifting plans to custo',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Lifting schedules for JV production require JOA reference for partner nomination rights, laycan allocation, overlift/underlift tracking, and equity holder cargo assignment. Drives partner-level liftin',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Lifting schedules specify loading terminals. Adding loading_terminal_id FK allows joining to get terminal details (operator, capacity, berths). Removes denormalized loading_port string. Labeled as loa',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Lifting schedules plan loading of specific petroleum products from FPSOs; FK required for vessel compatibility verification, quality planning, pricing determination, and cargo optimization. Product_ty',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Liftings represent crude oil sales that must be tracked by profit center for upstream revenue recognition, production performance, and segment reporting.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA lifting schedules determine contractor vs government entitlement liftings, cost recovery cargo allocation, and profit oil/gas splits. Essential for PSA fiscal regime compliance and government take',
    `vessel_id` BIGINT COMMENT 'FK to logistics.vessel',
    `api_gravity` DECIMAL(18,2) COMMENT 'The API gravity of the crude oil or liquid hydrocarbon being lifted, measured in degrees API. Indicates the density and quality of the crude, affecting pricing, refining yield, and transportation requirements.',
    `approval_date` DATE COMMENT 'The date on which this lifting schedule version was formally approved by the authorized planning or operations manager. Marks the transition from draft to approved status.',
    `approved_by` STRING COMMENT 'Name or identifier of the manager, planner, or authorized person who approved this lifting schedule version. Provides accountability for schedule commitments.',
    `associated_lifting_program_reference` STRING COMMENT 'Reference to related or parent lifting program documents, annual lifting agreements, or multi-period planning frameworks. Provides traceability to higher-level strategic lifting commitments and Production Sharing Agreement (PSA) entitlements.',
    `berth_assignment` STRING COMMENT 'The specific berth, jetty, or loading terminal position assigned for this lifting operation. Identifies the physical loading point at the FPSO, offshore terminal, or onshore export facility.',
    `bill_of_lading_number` STRING COMMENT 'The unique identifier for the bill of lading document issued for this cargo lifting. Serves as the legal receipt and title document for the transported hydrocarbons.',
    `cargo_number` STRING COMMENT 'Unique identifier for the specific cargo or parcel of crude oil, LNG, LPG, or NGL being lifted. Used for custody transfer tracking and bill of lading reconciliation.',
    `charter_party_type` STRING COMMENT 'The type of vessel charter agreement governing this lifting. Voyage charter for single-trip hire; time charter for vessel hire over a period; bareboat charter for vessel lease without crew. Determines cost allocation and operational responsibility.. Valid values are `voyage|time|bareboat`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lifting schedule record was first created in the system. Provides audit trail for schedule planning lifecycle.',
    `custody_transfer_method` STRING COMMENT 'The method used to measure and verify the volume of hydrocarbons transferred during the lifting operation. Metered for flow meter measurement; gauged for tank level measurement; calculated for derived volumes from multiple measurements. Determines the basis for commercial settlement and revenue allocation.. Valid values are `metered|gauged|calculated`',
    `demurrage_rate_usd_per_day` DECIMAL(18,2) COMMENT 'The daily rate charged if the vessel is detained beyond the agreed laytime for loading or unloading operations, measured in USD per day. Represents the financial penalty for delays in cargo operations.',
    `destination_port` STRING COMMENT 'Name of the destination port, refinery, or receiving terminal where the cargo will be delivered. Identifies the endpoint of the marine transportation leg.',
    `field_name` STRING COMMENT 'Name of the oil or gas field associated with this lifting schedule. Identifies the upstream production asset feeding the FPSO or terminal.',
    `fpso_name` STRING COMMENT 'Name of the FPSO facility or offshore terminal from which crude oil or natural gas liquids are being lifted. Identifies the production source location for marine logistics coordination.',
    `freight_rate_usd_per_bbl` DECIMAL(18,2) COMMENT 'The transportation cost per barrel for this cargo lifting, measured in USD per BBL. Represents the marine logistics cost component for moving crude oil or liquid hydrocarbons from the loading point to the destination.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this lifting schedule record was most recently updated. Tracks the currency of schedule information and supports change management.',
    `laycan_end_date` DATE COMMENT 'The latest date within the laycan window when the vessel must arrive to commence loading, beyond which the charterer may cancel the lifting. Defines the closing of the scheduled lifting window.',
    `laycan_start_date` DATE COMMENT 'The earliest date within the laycan (lay days canceling) window when the vessel may arrive and commence loading operations. Defines the opening of the scheduled lifting window.',
    `lifting_month` STRING COMMENT 'The calendar month for which this lifting schedule is planned, in MM-YYYY format. Represents the primary planning period for cargo liftings.. Valid values are `^(0[1-9]|1[0-2])-d{4}$`',
    `lifting_program_reference` STRING COMMENT 'External reference number or code identifying the lifting program to which this schedule belongs. Links to broader lifting program planning documents and Production Sharing Agreement (PSA) or Joint Operating Agreement (JOA) entitlements.',
    `lifting_status` STRING COMMENT 'Current operational status of this individual cargo lifting. Tracks progression from initial planning through confirmation, execution, or deferral. Planned indicates initial nomination; confirmed indicates vessel assignment and laycan agreement; completed indicates successful cargo transfer; deferred indicates postponement to a future period; cancelled indicates lifting will not occur.. Valid values are `planned|confirmed|completed|deferred|cancelled`',
    `nominated_volume_bbl` DECIMAL(18,2) COMMENT 'The volume of crude oil or liquid hydrocarbons nominated for lifting in this cargo, measured in barrels (BBL). Represents the planned cargo size based on production forecasts and entitlement calculations.',
    `number_of_vessels_assigned` STRING COMMENT 'The count of vessels assigned to execute liftings during this planning period. Used for fleet capacity planning and logistics resource management.',
    `planning_period_type` STRING COMMENT 'The time horizon granularity for this lifting schedule: monthly for short-term operational plans, quarterly for medium-term coordination, or annual for strategic capacity planning.. Valid values are `monthly|quarterly|annual`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, operational constraints, or exceptions related to this lifting schedule. Captures context not represented in structured fields.',
    `schedule_status` STRING COMMENT 'Overall status of this lifting schedule version in the planning and approval workflow. Draft indicates work in progress; approved indicates management sign-off; published indicates distribution to stakeholders and operational teams; revised indicates changes after initial publication.. Valid values are `draft|approved|published|revised`',
    `schedule_version` STRING COMMENT 'Version number of this lifting schedule. Increments with each revision to track changes over the planning cycle as nominations are confirmed, vessels are assigned, or liftings are deferred.',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'The allowable percentage variance (plus or minus) from the nominated volume that is acceptable for this lifting. Reflects contractual flexibility in cargo size due to production variability, vessel capacity constraints, or custody transfer measurement tolerances.',
    `total_planned_liftings` STRING COMMENT 'The total number of individual cargo liftings planned for the period covered by this schedule. Used for capacity planning and logistics resource allocation.',
    `total_planned_volume_bbl` DECIMAL(18,2) COMMENT 'The aggregate volume of all planned liftings for the period, measured in barrels (BBL). Represents the total crude oil or liquid hydrocarbon volume to be lifted across all cargoes in the schedule.',
    CONSTRAINT pk_logistics_lifting_schedule PRIMARY KEY(`logistics_lifting_schedule_id`)
) COMMENT 'Master planning entity governing FPSO and terminal crude oil liftings and the consolidated marine logistics schedule for a given planning horizon. Captures lifting program reference, field or FPSO name, lifting month, planning period (monthly or quarterly), schedule version, cargo number, scheduled lifting date range (laycan), nominated volume (BBL), total planned liftings and volume for the period, equity holder or buyer, vessel assignment, berth assignment, loading port, number of vessels assigned, lifting status (planned, confirmed, completed, deferred), schedule status (draft, approved, published, revised), approval date, approved by, tolerance percentage, and associated lifting program references. Aligns with production sharing agreement (PSA) and joint operating agreement (JOA) lifting entitlements. Serves as the single operational master plan for marine logistics coordination, replacing separate shipping schedule and lifting program concepts.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` (
    `custody_transfer_id` BIGINT COMMENT 'Unique identifier for the custody transfer transaction record. Primary key for the custody transfer entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Custody transfers may incur measurement/inspection costs that must be allocated to cost centers for quality assurance expense tracking and operational cost management.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Custody transfers at joint venture measurement points drive partner volumetric allocation, JIB cost recovery, imbalance tracking, and royalty calculation. JOA reference enables proper partner entitlem',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Custody transfer events (meter tickets, pipeline receipts) must reference originating lease for royalty disbursement calculation, revenue allocation to interest owners, and audit trail compliance. Cor',
    `measurement_point_id` BIGINT COMMENT 'Reference to the physical location where custody transfer measurement occurred (meter station, loading rack, pipeline interconnect, FPSO offloading point).',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Custody transfers record ownership change of specific petroleum products; FK essential for product valuation, royalty calculation, JIB allocation, quality reconciliation against specifications, and fi',
    `pipeline_nomination_id` BIGINT COMMENT 'Reference to the pipeline nomination or scheduling request that authorized this custody transfer, used for pipeline capacity allocation and FERC reporting.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the party relinquishing custody and title of the petroleum product (seller, shipper, or upstream operator).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Custody transfers represent revenue/cost events that impact profit center P&L through product sales, royalty calculations, and JIB allocations.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA custody transfers determine cost oil vs profit oil volumes for contractor/government splits, cost recovery ceiling compliance, and fiscal regime reporting. Essential for international upstream fis',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Custody transfer events require source reservoir tracking for joint venture accounting, revenue allocation, and regulatory compliance. Critical for PSA entitlement calculations and SEC reserves reconc',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Custody transfers occur at terminals (marine terminals, pipeline terminals). Adding terminal_id FK allows joining to get terminal details (operator, capacity, location). Removes denormalized inspectio',
    `api_gravity` DECIMAL(18,2) COMMENT 'Measure of petroleum liquid density relative to water, expressed in API degrees, used for volume correction and product valuation.',
    `bsw_percentage` DECIMAL(18,2) COMMENT 'Percentage of non-hydrocarbon impurities (sediment and water) in the product, deducted from gross volume to calculate net volume for custody transfer.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the custody transfer record was first created in the system, used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for tariff rates and financial settlements associated with the custody transfer.. Valid values are `USD|EUR|GBP|CAD|AUD`',
    `draft_survey_result` DECIMAL(18,2) COMMENT 'Quantity determined by marine draft survey method (vessel displacement measurement), used as independent verification for cargo transfers, expressed in metric tons or barrels.',
    `gross_observed_volume` DECIMAL(18,2) COMMENT 'Total volume of product measured at observed temperature and pressure conditions before any corrections, expressed in barrels or cubic meters.',
    `gross_standard_volume` DECIMAL(18,2) COMMENT 'Total volume of product corrected to standard temperature (60°F or 15°C) and pressure conditions, including all impurities, expressed in barrels or cubic meters.',
    `independent_inspector_company` STRING COMMENT 'Name of the third-party inspection company that performed independent verification of quantity and quality (e.g., SGS, Intertek, Bureau Veritas).',
    `inspection_certificate_number` STRING COMMENT 'Unique identifier for the independent inspection certificate issued by the third-party inspector, required for customs clearance and payment release.',
    `inspection_date` DATE COMMENT 'Date on which the independent inspection was performed, may differ from transfer date for pre-shipment or post-discharge inspections.',
    `inspection_type` STRING COMMENT 'Type of independent inspection performed (quantity verification, quality analysis, draft survey for marine cargo, ullage survey for tank measurement, or combined).. Valid values are `quantity|quality|draft_survey|ullage_survey|combined`',
    `inspector_name` STRING COMMENT 'Full name of the certified inspector who performed the custody transfer verification, used for accountability and dispute resolution.',
    `jib_allocation_status` STRING COMMENT 'Status of the custody transfer in the joint interest billing process, tracking allocation to working interest owners and billing completion.. Valid values are `pending|allocated|billed|paid|disputed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the custody transfer record was last updated, used for audit trail and change tracking.',
    `meter_ticket_number` STRING COMMENT 'Unique identifier for the meter run ticket or gauge sheet documenting the physical measurement, used for audit and dispute resolution.',
    `net_standard_volume` DECIMAL(18,2) COMMENT 'Volume of product corrected to standard conditions and adjusted for impurities (BS&W deducted), representing the saleable quantity for revenue calculation.',
    `observed_pressure` DECIMAL(18,2) COMMENT 'Pressure of the product at the time of measurement, used for volume correction to standard conditions, expressed in PSI or kPa.',
    `observed_temperature` DECIMAL(18,2) COMMENT 'Temperature of the product at the time of measurement, used for volume correction to standard conditions, expressed in degrees Fahrenheit or Celsius.',
    `pressure_unit_of_measure` STRING COMMENT 'Unit of measurement for pressure (pounds per square inch, kilopascals, or bar).. Valid values are `psi|kpa|bar`',
    `quality_claim_flag` BOOLEAN COMMENT 'Indicates whether a quality dispute or claim has been filed regarding this custody transfer, triggering investigation and potential financial adjustment.',
    `quantity_variance_flag` BOOLEAN COMMENT 'Indicates whether a significant variance exists between transferor and transferee measurements, requiring reconciliation per custody transfer agreement tolerance limits.',
    `royalty_calculation_flag` BOOLEAN COMMENT 'Indicates whether this custody transfer triggers royalty payment obligations to mineral rights owners or government entities.',
    `seal_numbers` STRING COMMENT 'Comma-separated list of tamper-evident seal identifiers applied to measurement equipment, valves, or cargo hatches to ensure measurement integrity.',
    `seal_verification_status` STRING COMMENT 'Status of seal integrity verification at the time of custody transfer, critical for detecting tampering or measurement disputes.. Valid values are `intact|broken|missing|not_applicable`',
    `sulfur_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of sulfur by weight in the product, critical for quality specification, pricing differentials, and environmental compliance.',
    `tariff_rate` DECIMAL(18,2) COMMENT 'Transportation or handling fee per unit of volume for the custody transfer, expressed in currency per barrel or per cubic meter, subject to FERC regulation for interstate pipelines.',
    `temperature_unit_of_measure` STRING COMMENT 'Unit of measurement for temperature (Fahrenheit or Celsius).. Valid values are `F|C`',
    `transfer_date` DATE COMMENT 'Calendar date on which the custody transfer occurred, used for daily production allocation and revenue recognition.',
    `transfer_reference_number` STRING COMMENT 'External business identifier for the custody transfer transaction, used for cross-party reconciliation and audit trails.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the custody transfer transaction, governing revenue recognition and JIB processing.. Valid values are `pending|in_progress|completed|disputed|cancelled|reversed`',
    `transfer_timestamp` TIMESTAMP COMMENT 'Precise date and time when custody transfer was completed and title passed between parties, critical for JIB and revenue recognition.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measurement for volume quantities (barrels, cubic meters, gallons, thousand cubic feet, million cubic feet).. Valid values are `bbl|m3|gal|mcf|mmcf`',
    CONSTRAINT pk_custody_transfer PRIMARY KEY(`custody_transfer_id`)
) COMMENT 'Transactional record capturing the official transfer of title and custody of petroleum products between parties at a defined measurement point, including independent inspection verification and cargo inspection details. Records transfer reference, transfer date/time, measurement point ID, transferor and transferee parties, product type and grade, gross observed volume (GOV), gross standard volume (GSV), net standard volume (NSV), API gravity, BS&W percentage, sulfur content, temperature, pressure, meter ticket number, seal numbers and verification, independent inspector details (company, inspector name, inspection type — quantity/quality/draft survey/ullage survey, certificate number), draft survey results, inspection date, inspection port (load or discharge), and transfer status. Critical for revenue recognition, JIB, quality claims, royalty calculations, and custody transfer dispute resolution.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`vessel` (
    `vessel_id` BIGINT COMMENT 'Unique system identifier for the vessel. Primary key for the vessel master data entity.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Vessels require certifications (class society, flag state, vetting). Vessel records track primary certification for renewal management. Real-world operations link vessel to its master certification, e',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Vessels maintain shipboard oil pollution emergency plans (SOPEP). Vessel references current plan for IMO compliance and port state control inspections.',
    `beam_m` DECIMAL(18,2) COMMENT 'Maximum width of the vessel measured in meters at the widest point. Critical dimension for canal transit (Panama Canal beam limit 49m for Panamax, 55m for Neo-Panamax), port berth allocation, and lock compatibility.',
    `cargo_capacity_bbl` DECIMAL(18,2) COMMENT 'Total cargo carrying capacity measured in barrels of oil equivalent. Used for crude oil and refined product tankers. One barrel equals 42 US gallons or approximately 159 liters. Critical for cargo planning, nomination scheduling, and freight calculations.',
    `cargo_capacity_cbm` DECIMAL(18,2) COMMENT 'Total cargo carrying capacity measured in cubic meters. Primary capacity metric for LNG carriers, LPG carriers, and chemical tankers where volume is more relevant than weight. Used for cargo planning and commercial negotiations.',
    `cargo_heating_capability` BOOLEAN COMMENT 'Indicates whether the vessel is equipped with cargo heating coils to maintain or raise the temperature of heavy crude oils, fuel oils, or bitumen that solidify at ambient temperatures. Essential for high-viscosity cargoes that require heating for pumping and discharge.',
    `cargo_tank_count` STRING COMMENT 'Number of separate cargo tanks on the vessel. Typical crude tankers have 8-16 center tanks plus wing tanks. Multiple tanks enable cargo segregation for different crude grades, ballast management, and stability control. LNG carriers typically have 4-5 membrane or spherical tanks.',
    `class_notation` STRING COMMENT 'Alphanumeric code assigned by the classification society indicating the vessels design standards, construction quality, and operational capabilities. Examples include +1A1 (Lloyds Register highest class), +A1 (ABS highest class), and additional notations for ice class, dynamic positioning, or special cargo handling.',
    `classification_society` STRING COMMENT 'Independent organization that establishes and maintains technical standards for the construction and operation of ships. Conducts surveys and inspections to verify compliance. Major societies include Lloyds Register (LR), American Bureau of Shipping (ABS), Det Norske Veritas (DNV), Bureau Veritas (BV), and Nippon Kaiji Kyokai (ClassNK). Required for insurance and port entry.',
    `commercial_manager` STRING COMMENT 'Company responsible for chartering, voyage planning, freight negotiations, and commercial operations. Handles fixture negotiations, laytime calculations, demurrage claims, and customer relationships. May be the owner, operator, or a specialized commercial management firm.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this vessel record was first created in the master data system. Used for data lineage, audit trails, and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crude_oil_washing_system` BOOLEAN COMMENT 'Indicates whether the vessel is equipped with a crude oil washing system that uses the cargo itself to clean tank walls during discharge, reducing sludge and improving cargo outturn. Mandatory for crude tankers over 20,000 DWT under MARPOL Annex I.',
    `deadweight_tonnage` DECIMAL(18,2) COMMENT 'Maximum weight in metric tons that the vessel can safely carry, including cargo, fuel, fresh water, ballast water, provisions, passengers, and crew. Key metric for chartering decisions and freight rate calculations. Measured at summer load line in saltwater.',
    `draft_m` DECIMAL(18,2) COMMENT 'Vertical distance in meters between the waterline and the bottom of the hull (keel) when the vessel is fully loaded. Determines port accessibility, channel depth requirements, and loading limits. Suez Canal maximum draft is 20.1m, Panama Canal is 15.2m.',
    `flag_state` STRING COMMENT 'Three-letter ISO country code representing the nation under whose laws the vessel is registered. Determines applicable maritime regulations, safety standards, labor laws, and taxation. Common flags include LBR (Liberia), PAN (Panama), MHL (Marshall Islands), SGP (Singapore), USA (United States).. Valid values are `^[A-Z]{3}$`',
    `fuel_consumption_mt_per_day` DECIMAL(18,2) COMMENT 'Average daily fuel consumption in metric tons at service speed under normal laden conditions. Critical for voyage cost estimation, bunker planning, and carbon emissions calculations. Typical VLCC consumes 60-80 MT/day, Aframax 35-45 MT/day.',
    `fuel_type` STRING COMMENT 'Primary fuel used for main propulsion. Options include Heavy Fuel Oil (HFO/IFO380), Marine Gas Oil (MGO), Low Sulfur Fuel Oil (LSFO), Very Low Sulfur Fuel Oil (VLSFO 0.5%), Liquefied Natural Gas (LNG), and dual-fuel configurations. Critical for emissions compliance with IMO 2020 sulfur cap regulations and Emission Control Area (ECA) requirements.',
    `gross_tonnage` DECIMAL(18,2) COMMENT 'Measure of the overall internal volume of the vessel expressed in register tons (100 cubic feet). Used for regulatory compliance, port fees, canal tolls, and insurance premiums. Calculated according to the International Convention on Tonnage Measurement of Ships 1969.',
    `hull_type` STRING COMMENT 'Structural design of the vessels hull. Double Hull construction features two complete layers of watertight hull surface providing enhanced protection against oil spills in case of collision or grounding. Required for all new tankers under MARPOL regulations since 1996. Single Hull vessels are being phased out globally.. Valid values are `Single Hull|Double Hull|Double Bottom|Double Sided`',
    `ice_class` STRING COMMENT 'Notation indicating the vessels capability to operate in ice-covered waters. Classifications range from basic ice strengthening to polar class for year-round Arctic operations. Examples include 1A Super (Finnish-Swedish Ice Class), PC1-PC7 (Polar Class), and IACS Polar Class. Critical for operations in northern Russia, Alaska, and Canadian Arctic.',
    `imo_number` STRING COMMENT 'Unique seven-digit ship identification number assigned by the International Maritime Organization. Permanent identifier that remains unchanged through changes of ownership, flag, or name. Required for vessels over 100 gross tonnage engaged in international voyages.. Valid values are `^IMO[0-9]{7}$`',
    `inert_gas_system` BOOLEAN COMMENT 'Indicates whether the vessel is equipped with an inert gas system that replaces oxygen in cargo tanks with inert gas (typically nitrogen or scrubbed exhaust gas) to prevent explosive atmospheres. Mandatory for crude oil tankers over 20,000 DWT under SOLAS regulations.',
    `last_drydock_date` DATE COMMENT 'Date of the most recent drydocking when the vessel was taken out of water for hull inspection, cleaning, painting, and underwater repairs. Classification societies require drydocking at intervals not exceeding 5 years for hull surveys. Recent drydocking is a positive vetting indicator.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this vessel record was most recently updated. Tracks changes to vessel attributes such as ownership, operator, vetting status, or operational status. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_sire_inspection_date` DATE COMMENT 'Date of the most recent SIRE inspection conducted by an OCIMF-accredited inspector. SIRE inspections assess vessel condition, safety management systems, crew competence, and operational procedures. Inspections are valid for 6 months; vessels require re-inspection for continued employment by major charterers.',
    `length_overall_m` DECIMAL(18,2) COMMENT 'Maximum length of the vessel measured in meters from the foremost point of the bow to the aftermost point of the stern. Used to determine canal transit eligibility (Suez, Panama), port berth compatibility, and pilotage requirements.',
    `main_engine_type` STRING COMMENT 'Manufacturer and model designation of the primary propulsion engine. Common types include MAN B&W two-stroke diesel, Wärtsilä medium-speed diesel, and steam turbines for older LNG carriers. Impacts fuel consumption, maintenance costs, and emissions profile.',
    `net_tonnage` DECIMAL(18,2) COMMENT 'Measure of the usable cargo volume of the vessel, calculated by subtracting non-cargo spaces from gross tonnage. Used for port dues, pilotage fees, and regulatory assessments. Represents the earning capacity of the vessel.',
    `next_special_survey_due_date` DATE COMMENT 'Date by which the next comprehensive classification society survey must be completed. Special surveys are conducted every 5 years and involve detailed inspection of hull structure, machinery, safety equipment, and cargo systems. Vessels cannot trade beyond the special survey due date without survey completion.',
    `operational_status` STRING COMMENT 'Current operational state of the vessel. In Service indicates active trading. Laid Up indicates temporary withdrawal from service due to market conditions. Under Repair indicates scheduled or unscheduled maintenance. Drydocked indicates the vessel is in drydock for survey or repairs. Scrapped indicates the vessel has been sold for demolition.. Valid values are `In Service|Laid Up|Under Repair|Drydocked|Scrapped|Under Construction`',
    `operator_company` STRING COMMENT 'Company responsible for the day-to-day technical management and operation of the vessel, including crewing, maintenance, dry-docking, and regulatory compliance. May be the owner, a third-party ship management company, or a bareboat charterer.',
    `owner_company` STRING COMMENT 'Legal entity that holds title to the vessel. May be a single-ship company (special purpose vehicle) for financing purposes, a shipping company, or an integrated oil company. Owner is responsible for capital expenditures, major repairs, and vessel disposal decisions.',
    `propulsion_power_kw` DECIMAL(18,2) COMMENT 'Maximum continuous rated power output of the main propulsion engine measured in kilowatts. Determines vessel speed capability, fuel consumption rate, and Energy Efficiency Design Index (EEDI) calculations for IMO emissions compliance.',
    `protection_indemnity_club` STRING COMMENT 'Mutual insurance association providing liability coverage for shipowners, including third-party claims for pollution, cargo damage, crew injury, collision, and wreck removal. Major P&I clubs include Gard, Skuld, UK P&I Club, and American Club. Membership is a key vetting criterion.',
    `segregated_ballast_tanks` BOOLEAN COMMENT 'Indicates whether the vessel has dedicated ballast tanks that are completely separated from cargo oil and fuel oil systems. Prevents contamination of ballast water with oil and reduces operational oil pollution. Required for tankers over 20,000 DWT under MARPOL Annex I.',
    `service_speed_knots` DECIMAL(18,2) COMMENT 'Normal operating speed of the vessel measured in nautical miles per hour (knots) under typical laden conditions with 85% engine power. Used for voyage planning, ETA calculations, and charter party speed warranties. One knot equals 1.852 kilometers per hour.',
    `shipyard` STRING COMMENT 'Name of the shipbuilding facility where the vessel was constructed. Provides insight into build quality, design standards, and potential sister vessels. Major shipyards include Hyundai Heavy Industries, Samsung Heavy Industries, Daewoo Shipbuilding, and COSCO Shipyard.',
    `sire_inspection_result` STRING COMMENT 'Overall outcome of the most recent SIRE inspection. Acceptable indicates no significant deficiencies. Acceptable with Observations indicates minor issues that do not prevent employment. Unacceptable indicates serious deficiencies requiring immediate rectification before the vessel can be chartered.. Valid values are `Acceptable|Acceptable with Observations|Unacceptable`',
    `vessel_name` STRING COMMENT 'Official registered name of the vessel as recorded with the flag state maritime authority. Used for operational identification, chartering documentation, and regulatory reporting.',
    `vessel_type` STRING COMMENT 'Classification of vessel by design and cargo capacity. VLCC (Very Large Crude Carrier) for 200,000+ DWT crude oil transport, Suezmax for 120,000-200,000 DWT, Aframax for 80,000-120,000 DWT, LNG Carrier for liquefied natural gas, LPG Carrier for liquefied petroleum gas, FPSO (Floating Production Storage and Offloading) for offshore production and storage, FSO (Floating Storage and Offloading) for storage only, Product Tanker for refined petroleum products. [ENUM-REF-CANDIDATE: VLCC|Suezmax|Aframax|Panamax|Handymax|LNG Carrier|LPG Carrier|Product Tanker|Chemical Tanker|FPSO|FSO|Shuttle Tanker — 12 candidates stripped; promote to reference product]',
    `vetting_status` STRING COMMENT 'Current approval status based on the most recent Ship Inspection Report (SIRE) or Chemical Distribution Institute (CDI) inspection. Major oil companies and charterers maintain approved vessel lists based on vetting results. Approved status is required for employment by most major charterers.. Valid values are `Approved|Conditional|Rejected|Pending|Not Vetted`',
    `year_built` STRING COMMENT 'Calendar year in which the vessel was constructed and delivered from the shipyard. Critical for assessing vessel age, remaining economic life, vetting eligibility, insurance premiums, and compliance with age-restricted port regulations. Many ports and charterers impose age limits (typically 15-20 years for crude tankers, 25 years for product tankers).',
    CONSTRAINT pk_vessel PRIMARY KEY(`vessel_id`)
) COMMENT 'Master data entity for tankers, LNG carriers, LPG vessels, and FSOs/FPSOs used in petroleum product transportation. Captures IMO number, vessel name, vessel type (VLCC, Suezmax, Aframax, LNG carrier, LPG carrier, product tanker), flag state, deadweight tonnage (DWT), cargo capacity (BBL or CBM), year built, classification society, P&I club, vetting status (SIRE/CDI inspection date and result), last dry-dock date, owner, operator, and commercial manager. Supports vessel vetting and chartering operations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`voyage` (
    `voyage_id` BIGINT COMMENT 'Unique identifier for the voyage record. Primary key.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Voyages trigger customs declarations and export filings. Voyage records link to the regulatory filing for audit trail, ensuring all international voyages are properly reported to customs authorities a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Voyage costs (freight, bunker, port charges) must be allocated to cost centers for marine logistics accounting, budget tracking, and transportation expense management.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Voyage costs and revenues post to specific GL accounts for financial statement preparation, freight expense recognition, and demurrage/despatch accounting.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Marine voyages track incidents (collisions, groundings, spills) for maritime safety compliance, P&I club reporting, and demurrage impact analysis. Essential for charter party claims and vetting status',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Voyages carrying JV crude/LNG require JOA reference for demurrage cost allocation to partners, freight cost sharing, and partner cargo tracking. Drives JIB billing for voyage-related costs and partner',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Vessel master accountability is mandatory for ISM Code compliance, STCW certification tracking, voyage safety oversight, and HSE incident investigation. Oil-and-gas tanker operations require designate',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Voyages transport specific petroleum products; FK required for charter party terms (product-specific freight rates), marine insurance classification, port compatibility verification, vessel suitabilit',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Voyages generate profit/loss that must be tracked by profit center for crude marketing performance, segment reporting, and voyage economics analysis.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: Voyages trigger regulatory submissions (ballast water reporting, MARPOL, port state declarations). Links voyage to submission for compliance documentation and port clearance.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Voyages execute sales order deliveries (especially spot cargoes and FOB sales). Critical for delivery performance tracking, demurrage/despatch allocation to sales transactions, customer-specific freig',
    `vessel_id` BIGINT COMMENT 'Reference to the vessel performing this voyage. Links to the vessel master data.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the charterer (the party hiring the vessel). Links to customer or counterparty master data.',
    `voyage_shipowner_commercial_counterparty_id` BIGINT COMMENT 'Reference to the shipowner (the party providing the vessel). Links to supplier or counterparty master data.',
    `bill_of_lading_number` STRING COMMENT 'Master bill of lading number issued for the cargo transported on this voyage. Primary shipping document and title of goods.',
    `bunker_consumption_mt` DECIMAL(18,2) COMMENT 'Total bunker fuel consumed during the voyage, expressed in metric tons. Includes all fuel types (HFO, MGO, VLSFO, etc.).',
    `bunker_cost` DECIMAL(18,2) COMMENT 'Total cost of bunker fuel consumed during the voyage. Expressed in freight currency. Major component of voyage costs.',
    `canal_fees` DECIMAL(18,2) COMMENT 'Total fees paid for canal transits (e.g., Suez Canal, Panama Canal) during the voyage. Expressed in freight currency.',
    `cargo_quantity` DECIMAL(18,2) COMMENT 'Total quantity of cargo loaded for this voyage. Unit of measure is specified in cargo_quantity_uom.',
    `cargo_quantity_uom` STRING COMMENT 'Unit of measure for cargo quantity. BBL = Barrels, MT = Metric Tons, M3 = Cubic Meters, MMBTU = Million British Thermal Units, GAL = Gallons.. Valid values are `BBL|MT|M3|MMBTU|GAL`',
    `charter_party_reference` STRING COMMENT 'Reference number or identifier of the charter party agreement governing this voyage. Links to contract management system.',
    `charter_type` STRING COMMENT 'Type of charter party agreement governing this voyage. Voyage charter is for a single voyage, time charter is for a period, bareboat charter transfers operational control, contract of affreightment is for multiple voyages, and spot is an ad-hoc arrangement.. Valid values are `voyage_charter|time_charter|bareboat_charter|contract_of_affreightment|spot`',
    `commencement_date` TIMESTAMP COMMENT 'Timestamp when the voyage officially commenced, typically when the vessel departed the first load port or when loading operations began.',
    `completion_date` TIMESTAMP COMMENT 'Timestamp when the voyage was completed, typically when discharge operations finished at the final discharge port and the vessel was released.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this voyage record was first created in the system.',
    `demurrage_amount` DECIMAL(18,2) COMMENT 'Total demurrage amount payable by the charterer, calculated from demurrage hours and rate. Expressed in freight currency.',
    `demurrage_claim_amount` DECIMAL(18,2) COMMENT 'Total amount claimed in the demurrage claim, which may differ from the calculated demurrage_amount due to negotiations or disputes. Expressed in freight currency.',
    `demurrage_claim_reference` STRING COMMENT 'Unique reference number for the demurrage claim submitted by the shipowner to the charterer.',
    `demurrage_claim_status` STRING COMMENT 'Current status of the demurrage claim in the settlement process. Tracks progression from draft through to final settlement or withdrawal.. Valid values are `draft|submitted|disputed|agreed|settled|withdrawn`',
    `demurrage_dispute_reason` STRING COMMENT 'Description of the reason for dispute if the demurrage claim is contested by the charterer. Includes details of disagreements on laytime calculations, exceptions, or force majeure events.',
    `demurrage_hours` DECIMAL(18,2) COMMENT 'Total demurrage hours incurred when laytime used exceeds laytime allowed. Demurrage is a penalty paid by the charterer for exceeding allowed time.',
    `demurrage_rate_per_day` DECIMAL(18,2) COMMENT 'Agreed daily rate for demurrage charges, expressed in the freight currency. Used to calculate total demurrage amount.',
    `demurrage_settlement_date` DATE COMMENT 'Date when the demurrage claim was finally settled and payment was made or agreed.',
    `despatch_amount` DECIMAL(18,2) COMMENT 'Total despatch amount payable by the shipowner to the charterer, calculated from despatch hours and rate. Expressed in freight currency.',
    `despatch_hours` DECIMAL(18,2) COMMENT 'Total despatch hours earned when laytime used is less than laytime allowed. Despatch is a bonus paid by the shipowner to the charterer for saving time.',
    `despatch_rate_per_day` DECIMAL(18,2) COMMENT 'Agreed daily rate for despatch payments, typically half the demurrage rate. Expressed in the freight currency.',
    `fixture_date` DATE COMMENT 'Date when the charter party agreement was fixed and agreed between the charterer and shipowner.',
    `freight_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight rate and voyage financial amounts.. Valid values are `^[A-Z]{3}$`',
    `freight_rate` DECIMAL(18,2) COMMENT 'The agreed freight rate for the voyage. Interpretation depends on freight_rate_basis (e.g., Worldscale points, lump sum amount, or per-unit rate).',
    `freight_rate_basis` STRING COMMENT 'Basis on which freight is calculated. Worldscale is a standard tanker rate index, lump sum is a fixed amount for the voyage, per-unit rates are based on cargo volume or weight.. Valid values are `worldscale|lump_sum|per_ton|per_barrel|per_cubic_meter`',
    `governing_law` STRING COMMENT 'The legal jurisdiction and law governing the charter party agreement (e.g., English Law, New York Law).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this voyage record was last updated in the system.',
    `laycan_end_date` DATE COMMENT 'End date of the laycan window. If the vessel does not arrive by this date, the charterer may have the right to cancel the charter.',
    `laycan_start_date` DATE COMMENT 'Start date of the laycan (laydays and canceling) window. The earliest date the vessel is expected to arrive at the load port.',
    `payment_terms` STRING COMMENT 'Terms and conditions for freight payment, including timing, method, and any advance or retention clauses.',
    `port_charges_total` DECIMAL(18,2) COMMENT 'Total port charges incurred across all port calls during the voyage, including port dues, pilotage, tugs, and agency fees. Expressed in freight currency.',
    `profit_loss` DECIMAL(18,2) COMMENT 'Net profit or loss for the voyage, calculated as freight revenue minus voyage costs (bunker, port charges, canal fees, demurrage/despatch net). Expressed in freight currency. Business-confidential financial metric.',
    `total_laytime_allowed_hours` DECIMAL(18,2) COMMENT 'Total laytime (loading and discharge time) allowed under the charter party terms, expressed in hours. Laytime is the time allowed for cargo operations.',
    `total_laytime_used_hours` DECIMAL(18,2) COMMENT 'Total laytime actually used across all load and discharge ports, expressed in hours. Calculated from port call records.',
    `voyage_number` STRING COMMENT 'Business identifier for the voyage, typically assigned by the commercial or operations team. Used for external communication and documentation.',
    `voyage_status` STRING COMMENT 'Current operational status of the voyage. Tracks the voyage lifecycle from planning through completion or cancellation.. Valid values are `planned|in_progress|completed|cancelled|suspended`',
    CONSTRAINT pk_voyage PRIMARY KEY(`voyage_id`)
) COMMENT 'Transactional record representing a vessels complete commercial and operational journey from fixture to settlement. Captures voyage number, vessel ID, charter party terms (charter type, fixture date, charterer, shipowner, freight rate basis — Worldscale or lump sum, governing law, payment terms), laycan, port call sequence (load/discharge/bunker ports with ETA, ATA, NOR tendered, berthing, operations commencement/completion, departure, port agent, PDA, port state control results), commencement and completion of loading/discharge, total laytime used per port, demurrage or despatch hours and rates, demurrage claim details (claim reference, claim amount, claim status — draft/submitted/disputed/agreed/settled, counterparty, dispute reason, settlement date), freight rate, voyage status, and voyage P&L. Serves as the single lifecycle record integrating charter party terms, port calls, laytime statements, demurrage claims, and freight invoicing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`terminal` (
    `terminal_id` BIGINT COMMENT 'Unique identifier for the terminal. Primary key for the terminal entity.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Terminals are physical facilities requiring asset management. Links terminal infrastructure to asset register for maintenance planning, integrity management, turnaround scheduling, asset retirement ob',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Terminals are operational facilities with associated costs (labor, utilities, maintenance) that must be tracked by cost center for budget management and operational expense control.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to hse.emission_source. Business justification: Terminals are emission sources (loading racks, storage tanks). Terminal references primary emission source for GHG reporting (EPA GHGRP) and air permit compliance.',
    `objective_id` BIGINT COMMENT 'Foreign key linking to hse.objective. Business justification: Terminals track HSE objectives (TRIR reduction, spill prevention). Terminal references current objectives for performance tracking and management review.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Terminal manager is designated responsible party for OSHA PSM compliance, EPA RMP reporting, HSE incident accountability, operational decisions, and custody transfer oversight. Required for regulatory',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Terminals operate under specific operating licenses issued by state/federal agencies. Compliance teams track license status per terminal for renewal management and regulatory inspections. Real-world o',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Terminals require multiple permits (air quality, water discharge, SPCC, operating license). Compliance teams track primary permit per terminal for renewal management and inspection scheduling. Real-wo',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Terminals typically have primary product specialization affecting tariff rates, storage design, safety protocols, and operational procedures; FK enables terminal classification, tariff determination, ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Terminals generate throughput revenue and incur costs, requiring profit center assignment for P&L tracking, segment reporting, and asset profitability analysis.',
    `address_line_1` STRING COMMENT 'Primary street address line for the terminal facility location.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as building number or suite.',
    `city` STRING COMMENT 'City or municipality where the terminal facility is located.',
    `commissioning_date` DATE COMMENT 'Date when the terminal facility was commissioned and began commercial operations.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the terminal is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the terminal record was first created in the system.',
    `custody_transfer_metering` BOOLEAN COMMENT 'Indicates whether the terminal has certified custody transfer metering systems for accurate measurement and allocation of product volumes during ownership transfer.',
    `environmental_permit_number` STRING COMMENT 'Primary environmental operating permit number issued by EPA or state environmental agency authorizing terminal operations.',
    `epa_rmp_registration` STRING COMMENT 'EPA Risk Management Plan registration number for facilities handling threshold quantities of regulated substances under the Clean Air Act Section 112(r).',
    `hse_incident_count_ytd` STRING COMMENT 'Total count of reportable HSE incidents at the terminal facility in the current calendar year, used for safety performance tracking.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal safety inspection of the terminal facility and storage tanks.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the terminal location in decimal degrees format for GIS mapping and logistics planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the terminal location in decimal degrees format for GIS mapping and logistics planning.',
    `maximum_draft_meters` DECIMAL(18,2) COMMENT 'Maximum vessel draft in meters that can be safely accommodated at the marine terminal berth, critical for vessel acceptance and scheduling. Null for non-marine terminals.',
    `maximum_vessel_size_dwt` DECIMAL(18,2) COMMENT 'Maximum deadweight tonnage (DWT) of vessels that can be accommodated at the marine terminal, used for vessel scheduling and FPSO lifting planning. Null for non-marine terminals.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the terminal record was last modified in the system.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required regulatory or internal safety inspection of the terminal facility.',
    `number_of_berths` STRING COMMENT 'Number of vessel berths or docking positions available at marine terminals for loading and discharge operations. Null for non-marine terminals.',
    `number_of_loading_arms` STRING COMMENT 'Total count of loading arms or loading bays available for product transfer operations at the terminal, applicable to marine, truck rack, and rail terminals.',
    `number_of_tanks` STRING COMMENT 'Total count of storage tanks at the terminal facility used for inventory management and capacity planning.',
    `operational_status` STRING COMMENT 'Current operational state of the terminal facility indicating availability for loading, discharge, and storage operations.. Valid values are `operational|maintenance|idle|decommissioned|under_construction|suspended`',
    `operator_name` STRING COMMENT 'Name of the company or entity responsible for operating and managing the terminal facility.',
    `osha_psm_covered` BOOLEAN COMMENT 'Indicates whether the terminal is subject to OSHA Process Safety Management requirements due to handling threshold quantities of highly hazardous chemicals.',
    `owner_name` STRING COMMENT 'Name of the legal owner of the terminal facility, which may differ from the operator in joint venture or leased arrangements.',
    `pipeline_system_connection` STRING COMMENT 'Name or identifier of the pipeline system(s) connected to the terminal for product receipt or delivery, used for nomination and scheduling coordination.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the terminal facility address.',
    `product_types_handled` STRING COMMENT 'Comma-separated list of product types handled at the terminal such as crude oil, gasoline, diesel, jet fuel, LNG, LPG, NGLs, petrochemicals. Used for product compatibility and scheduling.',
    `scada_integration_enabled` BOOLEAN COMMENT 'Indicates whether the terminal is integrated with SCADA systems for real-time monitoring of inventory, flow rates, and operational parameters.',
    `spcc_plan_revision_date` DATE COMMENT 'Date of the most recent revision to the facility SPCC plan required under EPA regulations for oil storage facilities.',
    `state_province` STRING COMMENT 'State or province where the terminal is located, used for regulatory jurisdiction and tax reporting.',
    `tariff_rate_usd_per_bbl` DECIMAL(18,2) COMMENT 'Published tariff rate in US dollars per barrel for storage and handling services at the terminal, subject to FERC regulation for interstate facilities.',
    `terminal_code` STRING COMMENT 'Unique business identifier code for the terminal used in operational systems and logistics planning.',
    `terminal_name` STRING COMMENT 'Official business name of the storage and loading/discharge terminal.',
    `terminal_type` STRING COMMENT 'Classification of terminal by primary mode of transportation: marine terminal for vessel operations, pipeline injection/delivery point, truck loading rack, rail terminal, or multimodal facility supporting multiple modes.. Valid values are `marine|pipeline|truck_rack|rail|multimodal`',
    `throughput_capacity_bopd` DECIMAL(18,2) COMMENT 'Maximum daily throughput capacity of the terminal in barrels of oil per day (BOPD), representing the maximum volume that can be loaded or discharged in a 24-hour period.',
    `throughput_capacity_mcfd` DECIMAL(18,2) COMMENT 'Maximum daily throughput capacity of the terminal in thousand cubic feet per day (MCFD) for natural gas and gas products.',
    `total_storage_capacity_bbl` DECIMAL(18,2) COMMENT 'Total storage capacity of the terminal in barrels (BBL) for crude oil, refined products, and NGLs. Represents the sum of all tank capacities at the facility.',
    `total_storage_capacity_cbm` DECIMAL(18,2) COMMENT 'Total storage capacity of the terminal in cubic meters (CBM) for natural gas, LNG, and other products measured volumetrically in metric units.',
    `uscg_facility_number` STRING COMMENT 'USCG-assigned facility identification number for marine terminals subject to Maritime Transportation Security Act (MTSA) regulations. Required for US marine terminals.',
    CONSTRAINT pk_terminal PRIMARY KEY(`terminal_id`)
) COMMENT 'Master data entity for storage and loading/discharge terminals including marine terminals, pipeline injection points, truck loading racks, and rail terminals, with daily storage inventory tracking at tank level. Captures terminal ID, terminal name, terminal type (marine, pipeline, truck rack, rail), location (latitude/longitude), country and state, operator, storage capacity (BBL or CBM), number of berths or loading arms, maximum vessel size (DWT), product types handled, throughput capacity (BOPD), USCG facility number, EPA RMP registration, operational status, and periodic tank-level inventory positions (inventory date, tank ID, product type and grade, opening inventory, receipts, deliveries, closing inventory, tank capacity, ullage, water bottom, temperature, API gravity, inventory status). Serves as the SSOT for terminal identity, terminal infrastructure, and storage position across logistics and supply chain. Supports supply chain balancing, custody reconciliation, and working capital management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` (
    `tariff_rate_id` BIGINT COMMENT 'Unique identifier for the tariff rate record. Primary key for the tariff rate entity.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Contract-specific tariff rates (volume discounts, negotiated transportation rates) differ from published tariffs. Critical for contract margin modeling, transportation cost forecasting, and contract p',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tariff revenues and costs must be allocated to cost centers for pipeline/terminal operations accounting, FERC reporting, and transportation service cost tracking.',
    `ferc_tariff_id` BIGINT COMMENT 'Foreign key linking to compliance.ferc_tariff. Business justification: Tariff rates implement FERC-approved tariffs. Rate schedules reference the regulatory tariff filing for audit and rate case support. Real-world operations link each rate to its authorizing FERC tariff',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Tariff revenues post to specific GL accounts (transportation revenue, tariff income) for revenue recognition, FERC compliance, and financial statement preparation.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Tariff rates for JV-operated pipelines/terminals are JIB-recoverable costs requiring JOA reference for partner allocation, overhead rate application, and cost recovery. Drives partner-level transporta',
    `pipeline_segment_id` BIGINT COMMENT 'Reference to the specific pipeline segment or route to which this tariff rate applies.',
    `superseded_tariff_rate_id` BIGINT COMMENT 'Reference to the previous tariff rate record that this rate supersedes or replaces. Null if this is an initial filing.',
    `terminal_id` BIGINT COMMENT 'Reference to the terminal facility to which this tariff rate applies. Applicable for terminalling and storage tariffs.',
    `base_rate` DECIMAL(18,2) COMMENT 'The base monetary rate charged per unit as defined by the rate basis. Does not include adjustments or surcharges.',
    `commodity_type` STRING COMMENT 'Type of petroleum product or natural gas commodity covered by this tariff rate. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|ngl|lng|lpg|refined_products|condensate — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tariff rate record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tariff rate. Typically USD for FERC-regulated tariffs.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `destination_location` STRING COMMENT 'Geographic destination point or delivery location for the transportation service covered by this tariff. May be a terminal, refinery, or interconnect point.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base rate for negotiated or volume-based agreements. Expressed as a decimal (e.g., 0.1000 for 10%).',
    `distance_miles` DECIMAL(18,2) COMMENT 'Transportation distance in miles between origin and destination. Used for distance-based rate calculations.',
    `effective_date` DATE COMMENT 'Date when the tariff rate becomes effective and applicable for billing purposes.',
    `expiration_date` DATE COMMENT 'Date when the tariff rate expires or is superseded. Null for open-ended tariffs.',
    `filing_date` DATE COMMENT 'Date when the tariff rate was originally filed with FERC or the applicable regulatory body.',
    `fuel_retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of product volume retained by the pipeline operator as in-kind compensation for fuel and energy costs. Expressed as a decimal (e.g., 0.0150 for 1.5%).',
    `index_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this tariff rate is subject to periodic index-based adjustments (e.g., inflation index, commodity price index).',
    `index_type` STRING COMMENT 'Type of index used for rate adjustments if index_adjustment_flag is true. Examples include Consumer Price Index (CPI), Producer Price Index (PPI), West Texas Intermediate (WTI), or Henry Hub natural gas price.. Valid values are `cpi|ppi|wti|henry_hub|fixed|none`',
    `last_revision_date` DATE COMMENT 'Date of the most recent revision or amendment to this tariff rate.',
    `loss_allowance_percentage` DECIMAL(18,2) COMMENT 'Percentage of product volume allowed for normal operational losses during transportation or storage. Expressed as a decimal (e.g., 0.0025 for 0.25%).',
    `maximum_tender_volume` DECIMAL(18,2) COMMENT 'Maximum volume quantity allowed for a single tender under this tariff rate. Null if no maximum applies.',
    `minimum_tender_volume` DECIMAL(18,2) COMMENT 'Minimum volume quantity required for a shipper to tender product under this tariff rate. Volume unit corresponds to the rate basis.',
    `notes` STRING COMMENT 'Additional notes, terms, conditions, or special provisions associated with this tariff rate. May include operational constraints or billing instructions.',
    `origin_location` STRING COMMENT 'Geographic origin point or receipt location for the transportation service covered by this tariff. May be a terminal, field, or interconnect point.',
    `quality_specification` STRING COMMENT 'Product quality requirements or specifications that must be met for this tariff rate to apply. May reference API gravity, sulfur content, or other quality parameters.',
    `rate_basis` STRING COMMENT 'Unit of measure basis for the tariff rate calculation. Defines how the rate is applied per unit of volume, energy, or time.. Valid values are `per_bbl|per_mmbtu|per_mcf|per_ton|per_gallon|per_day`',
    `rate_schedule_reference` STRING COMMENT 'Reference code or identifier for the broader rate schedule or tariff book that contains this specific rate.',
    `regulatory_approval_date` DATE COMMENT 'Date when the tariff rate received formal approval from FERC or other applicable regulatory authority.',
    `shipper_class` STRING COMMENT 'Classification of shipper service type to which this tariff rate applies. Firm service has priority; interruptible service may be curtailed.. Valid values are `firm|interruptible|all`',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Additional surcharge amount applied on top of the base rate. May be used for temporary adjustments, environmental fees, or regulatory cost recovery.',
    `tariff_name` STRING COMMENT 'Business name or title of the tariff rate schedule as filed with the regulatory body.',
    `tariff_status` STRING COMMENT 'Current regulatory and operational status of the tariff rate in its lifecycle.. Valid values are `filed|effective|suspended|superseded|withdrawn|pending_approval`',
    `tariff_type` STRING COMMENT 'Classification of the tariff service type. Defines the nature of the service being charged.. Valid values are `pipeline_transportation|terminalling|storage|throughput|gathering|processing`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tariff rate record was last modified in the system.',
    CONSTRAINT pk_tariff_rate PRIMARY KEY(`tariff_rate_id`)
) COMMENT 'Reference data entity capturing pipeline and terminal tariff rates filed with FERC or applicable regulatory bodies. Records tariff rate ID, tariff name, tariff type (pipeline transportation, terminalling, storage, throughput), effective date, expiration date, pipeline segment or terminal ID, commodity type, rate basis (per BBL, per MMBTU, per MCF), base rate, fuel retention percentage, loss allowance percentage, minimum tender volume, FERC tariff filing number, and rate status (filed, effective, superseded). Supports FERC tariff reporting and shipper invoicing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`delivery_order` (
    `delivery_order_id` BIGINT COMMENT 'Unique system identifier for the delivery order record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Delivery orders may incur fulfillment costs that must be charged to cost centers for order processing expense tracking and logistics operations accounting.',
    `customer_lifting_schedule_id` BIGINT COMMENT 'Reference to the lifting schedule entry for FPSO or terminal liftings. Links to production offtake scheduling system.',
    `delivery_point_id` BIGINT COMMENT 'Reference to the terminal, storage facility, or custody transfer point where product will be released. Links to facility or location master data.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who authorized and approved this delivery order for execution. Used for audit trail and SOX compliance.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Delivery orders for JV production require JOA reference for entitlement verification, partner authorization, and lifting rights validation. Ensures delivery volumes align with partner working interest',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Delivery orders for regulated products require permits (export license, hazmat transport). Operations verify permit coverage before authorizing delivery. Real-world compliance tracking links each orde',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Delivery orders authorize delivery of specific petroleum products; FK required for pricing basis determination, quality specification enforcement, regulatory permit validation, incoterms application, ',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the party or terminal operator issuing and fulfilling the delivery order. Links to party master data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Delivery orders represent product sales/transfers that impact profit center revenue through product deliveries and customer fulfillment.',
    `tertiary_delivery_consignee_party_commercial_counterparty_id` BIGINT COMMENT 'Reference to the ultimate consignee party receiving physical delivery, which may differ from the buyer in triangular trade scenarios. Links to party master data.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the delivery order was officially approved for execution. Represents a key lifecycle event for audit and compliance.',
    `authorized_volume` DECIMAL(18,2) COMMENT 'Total quantity of product authorized for delivery under this order. Measured in the unit specified by volume_unit_of_measure.',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading or shipping document number issued for this delivery. Serves as receipt and title document for transported goods.',
    `cancellation_date` DATE COMMENT 'Date when the delivery order was officially cancelled. Populated only when delivery_status = cancelled.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the delivery order was cancelled, if applicable. Populated only when delivery_status = cancelled.',
    `carrier_reference` STRING COMMENT 'External reference identifier for the carrier or transportation provider executing the delivery (e.g., vessel name, truck fleet number, pipeline operator code).',
    `contract_reference_number` STRING COMMENT 'Reference to the master sales contract, term contract, or spot trade agreement under which this delivery order is issued. Links to commercial contract documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery order record was first created in the system. Audit trail field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values on this delivery order.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `customs_declaration_number` STRING COMMENT 'Customs or border control declaration number for cross-border deliveries. Required for international shipments and export/import compliance.',
    `delivery_order_number` STRING COMMENT 'Externally-known business identifier for the delivery order, typically formatted as DO- followed by numeric sequence. Used for customer communication and documentation.. Valid values are `^DO-[0-9]{8,12}$`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery order in the fulfillment workflow. Tracks progression from issuance through completion or cancellation.. Valid values are `issued|scheduled|in_transit|partially_delivered|completed|cancelled`',
    `delivery_window_end_date` DATE COMMENT 'Latest date by which delivery must be completed under the terms of this order. Defines the end of the contractual delivery period.',
    `delivery_window_start_date` DATE COMMENT 'Earliest date when delivery may commence under the terms of this order. Defines the beginning of the contractual delivery period.',
    `incoterms_code` STRING COMMENT 'Incoterms 2020 code defining the division of costs, risks, and responsibilities between seller and buyer for this delivery. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issuance_date` DATE COMMENT 'Date when the delivery order was officially issued and authorized for execution. Represents the principal business event timestamp for this transaction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery order record was most recently updated. Audit trail field for change tracking and compliance.',
    `nomination_reference_number` STRING COMMENT 'Reference to the pipeline nomination or shipping nomination that scheduled this delivery. Used for pipeline capacity allocation and FERC reporting.',
    `notes` STRING COMMENT 'General free-text notes or comments related to this delivery order. Used for operational coordination and documentation of special circumstances.',
    `payment_terms` STRING COMMENT 'Contractual payment terms governing settlement for this delivery (e.g., Net 30, COD, Letter of Credit, Prepaid). Defines timing and method of payment.',
    `price_differential` DECIMAL(18,2) COMMENT 'Plus or minus adjustment to the pricing basis index, expressed in currency per unit. Represents quality, location, or contractual adjustments to benchmark pricing.',
    `pricing_basis` STRING COMMENT 'Index or benchmark used for pricing this delivery. WTI = West Texas Intermediate, Brent = Brent Crude, Platts = Platts pricing service, Argus = Argus Media pricing, NYMEX = New York Mercantile Exchange, ICE = Intercontinental Exchange. [ENUM-REF-CANDIDATE: wti|brent|platts|argus|nymex|ice|fixed — 7 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Business priority classification for scheduling and execution of this delivery order. Influences allocation of transportation capacity and terminal slots.. Valid values are `standard|high|urgent|critical`',
    `quality_specification_reference` STRING COMMENT 'Reference to the detailed quality specification document or standard defining acceptable product parameters (API gravity, sulfur content, vapor pressure, etc.).',
    `regulatory_permit_number` STRING COMMENT 'Reference to any regulatory permit or authorization required for this delivery (e.g., EPA transport permit, PHMSA pipeline authorization, export license).',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling, safety, or operational instructions for this delivery (e.g., temperature control, inert gas blanketing, H2S precautions).',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for product delivery. FPSO = Floating Production Storage and Offloading vessel.. Valid values are `pipeline|tanker|truck|rail|barge|fpso`',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for the authorized volume. BBL = Barrels, MT = Metric Tons, GAL = Gallons, M3 = Cubic Meters, MMBTU = Million British Thermal Units, MCF = Thousand Cubic Feet.. Valid values are `BBL|MT|GAL|M3|MMBTU|MCF`',
    CONSTRAINT pk_delivery_order PRIMARY KEY(`delivery_order_id`)
) COMMENT 'Transactional document authorizing the release and delivery of a specified quantity of petroleum product from a terminal or storage facility to a buyer or consignee. Captures delivery order number, issuance date, seller or terminal operator, buyer or consignee, product type and grade, authorized volume (BBL or MT), delivery window start and end, delivery point, transport mode, carrier reference, pricing basis (WTI, Brent, Platts), price differential, payment terms, and delivery status (issued, partially delivered, completed, cancelled). Links to custody transfer and commercial contracts.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Unique identifier for the transportation carrier. Primary key for the carrier master data entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carrier management activities (vetting, audits) incur costs that must be allocated to cost centers for logistics administration expense tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Carrier vetting process requires identified safety manager for DOT compliance verification, safety rating assessment, hazmat certification tracking, and contractor HSE performance management. Critical',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Carriers (trucking companies, railroads, barge operators, shipping lines) are vendors providing transportation services under procurement contracts. Real business process: carrier qualification/vettin',
    `carrier_status` STRING COMMENT 'The current operational and approval status of the carrier within the companys transportation network.. Valid values are `active|suspended|blacklisted|pending_approval|inactive`',
    `carrier_type` STRING COMMENT 'The primary mode of transportation provided by the carrier. Categorizes carriers by their operational capability and infrastructure.. Valid values are `pipeline|marine|truck|rail|barge|air`',
    `contract_effective_date` DATE COMMENT 'The date on which the transportation services contract with the carrier becomes legally effective and operational.',
    `contract_expiry_date` DATE COMMENT 'The date on which the current transportation services contract with the carrier expires or is scheduled for renewal.',
    `country_of_registration` STRING COMMENT 'The three-letter ISO country code representing the country where the carrier is legally registered and domiciled.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the carrier record was first created in the system.',
    `dot_number` STRING COMMENT 'The unique identifier assigned by the U.S. Department of Transportation for interstate carrier registration and safety monitoring.. Valid values are `^[0-9]{7}$`',
    `hazmat_certification_expiry_date` DATE COMMENT 'The date on which the carriers hazardous materials transportation certification expires and requires renewal.',
    `hazmat_certification_number` STRING COMMENT 'The unique certification number issued by the regulatory authority confirming the carriers authorization to transport hazardous materials.',
    `hazmat_certification_status` STRING COMMENT 'Indicates whether the carrier holds valid certification to transport hazardous materials including crude oil, natural gas liquids, and petrochemical products.. Valid values are `certified|expired|pending|not_certified`',
    `headquarters_address` STRING COMMENT 'The full street address of the carriers corporate headquarters or principal place of business.',
    `headquarters_city` STRING COMMENT 'The city where the carriers corporate headquarters or principal place of business is located.',
    `headquarters_country` STRING COMMENT 'The three-letter ISO country code representing the country where the carriers corporate headquarters is located.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'The postal or ZIP code of the carriers corporate headquarters or principal place of business.',
    `headquarters_state_province` STRING COMMENT 'The state or province where the carriers corporate headquarters or principal place of business is located.',
    `imo_number` STRING COMMENT 'The unique seven-digit identifier assigned by the International Maritime Organization to shipping companies and registered ship owners.. Valid values are `^IMO[0-9]{7}$`',
    `insurance_certificate_number` STRING COMMENT 'The unique identifier for the carriers liability and cargo insurance certificate on file.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the carriers insurance coverage for liability and cargo loss or damage.',
    `insurance_currency_code` STRING COMMENT 'The three-letter ISO currency code representing the currency in which the insurance coverage amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `insurance_expiry_date` DATE COMMENT 'The date on which the carriers current insurance certificate expires and requires renewal or replacement.',
    `insurance_provider_name` STRING COMMENT 'The name of the insurance company providing liability and cargo coverage for the carriers transportation operations.',
    `last_audit_date` DATE COMMENT 'The date on which the carriers operations, safety, and compliance were last audited by the company or a third-party auditor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the carrier record was most recently updated or modified in the system.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the carriers next operational, safety, and compliance audit.',
    `performance_score` DECIMAL(18,2) COMMENT 'The internal performance score assigned to the carrier based on on-time delivery, incident rate, quality of service, and compliance metrics. Typically scored on a 0-100 scale.',
    `preferred_carrier_flag` BOOLEAN COMMENT 'Boolean indicator of whether the carrier has been designated as a preferred or strategic partner based on performance, reliability, and commercial terms.',
    `primary_contact_email` STRING COMMENT 'The email address of the primary business contact at the carrier organization for operational communication and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact person at the carrier organization for operational coordination and communication.',
    `primary_contact_phone` STRING COMMENT 'The telephone number of the primary business contact at the carrier organization for operational communication and coordination.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the carriers operations, restrictions, or business relationship.',
    `safety_rating` STRING COMMENT 'The carriers safety performance rating as assigned by regulatory authorities based on compliance history and safety audits.. Valid values are `satisfactory|conditional|unsatisfactory|not_rated`',
    `safety_rating_date` DATE COMMENT 'The date on which the carriers current safety rating was assigned or last updated by the regulatory authority.',
    `scac_code` STRING COMMENT 'The unique two-to-four letter code assigned by the National Motor Freight Traffic Association to identify transportation companies in North America.. Valid values are `^[A-Z]{2,4}$`',
    `vetting_approval_date` DATE COMMENT 'The date on which the carrier successfully completed the vetting process and was approved for transportation services.',
    `vetting_approval_status` STRING COMMENT 'The current status of the carriers vetting and qualification process, indicating whether the carrier has passed safety, financial, and operational assessments.. Valid values are `approved|pending|rejected|expired|under_review`',
    `vetting_expiry_date` DATE COMMENT 'The date on which the carriers current vetting approval expires and requires renewal or re-assessment.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master data entity for transportation carriers including pipeline operators, shipping companies, trucking companies, and rail operators engaged to move petroleum products. Captures carrier ID, carrier name, carrier type (pipeline, marine, truck, rail), DOT/PHMSA carrier number, SCAC code, IMO company number, country of registration, insurance certificate details, hazmat certification status, vetting approval status, approved product types, contract reference, and carrier status (active, suspended, blacklisted). Serves as the SSOT for carrier identity in logistics operations and supports carrier qualification, vetting, and performance management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` (
    `freight_invoice_id` BIGINT COMMENT 'Unique system identifier for the freight invoice record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Freight invoice approval requires designated employee for financial controls, GL account validation, AFE authorization, and payment release. Critical for cost control and financial accountability in o',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier or freight broker who provided the transportation service and issued this invoice.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Freight invoices for international shipments trigger customs declarations and export control filings. Finance links invoice to the regulatory filing for audit trail, ensuring all cross-border freight ',
    `contract_id` BIGINT COMMENT 'Reference to the transportation contract or tariff agreement under which this freight service was provided and invoiced.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight invoices are operating expenses that must be charged to specific cost centers for budget tracking, variance analysis, and AFE cost control in oil & gas.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Freight invoices post to specific GL accounts (freight expense, accrued freight) for financial statement preparation, audit trails, and GAAP/IFRS compliance.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Freight costs for JV shipments are allocated to partners via JIB billing. JOA reference enables working interest-based cost allocation, JIB line item creation, and partner cost recovery in joint opera',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Freight invoices charge for transportation of specific petroleum products; FK required for tariff rate determination (product-specific rates), cost allocation to product lines, GL account coding, and ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Freight costs impact profit center profitability and must be allocated for segment reporting, crude marketing performance tracking, and management decision-making.',
    `accessorial_charges` DECIMAL(18,2) COMMENT 'Additional charges for ancillary services such as detention, storage, special handling, or equipment rental.',
    `afe_number` STRING COMMENT 'Authorization for Expenditure (AFE) number under which this freight cost is authorized and tracked, applicable for capital or major operational projects.',
    `approval_date` DATE COMMENT 'Date the freight invoice was approved for payment.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the freight invoice for payment.',
    `base_freight_amount` DECIMAL(18,2) COMMENT 'Base freight charge calculated as shipped volume multiplied by freight rate, before any additional charges or credits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the freight invoice is denominated. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|AUD|JPY|CNY — 7 candidates stripped; promote to reference product]',
    `demurrage_charge` DECIMAL(18,2) COMMENT 'Additional charge assessed for delays in loading or unloading beyond the agreed laytime, typically applicable to marine vessel and truck transportation.',
    `despatch_credit` DECIMAL(18,2) COMMENT 'Credit issued to the shipper for completing loading or unloading operations faster than the agreed laytime, reducing the total invoice amount.',
    `destination_location` STRING COMMENT 'Name or identifier of the destination location where the freight was delivered (refinery, terminal, port, or delivery point).',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this freight invoice is under dispute due to billing discrepancies, service quality issues, or contractual disagreements.',
    `dispute_reason` STRING COMMENT 'Description of the reason for the invoice dispute, such as incorrect volume, rate discrepancy, or service quality issue.',
    `freight_rate` DECIMAL(18,2) COMMENT 'Unit freight rate charged by the carrier per the rate basis (e.g., dollars per barrel, dollars per MCF).',
    `freight_rate_basis` STRING COMMENT 'Basis on which the freight rate is calculated: per barrel, per MCF, per ton, per mile, lump sum, or worldscale (for tanker charters).. Valid values are `per_barrel|per_mcf|per_ton|per_mile|lumpsum|worldscale`',
    `fuel_surcharge` DECIMAL(18,2) COMMENT 'Additional charge to cover fluctuations in fuel costs, typically applied to truck and rail transportation.',
    `invoice_date` DATE COMMENT 'Date the freight invoice was issued by the carrier or freight broker.',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice number issued by the carrier or freight broker for this transportation service billing document.',
    `invoice_receipt_date` DATE COMMENT 'Date the freight invoice was received by the accounts payable department for processing.',
    `invoice_status` STRING COMMENT 'Current processing status of the freight invoice in the accounts payable workflow: draft, submitted, approved, rejected, processed, or cancelled.. Valid values are `draft|submitted|approved|rejected|processed|cancelled`',
    `jib_allocation_status` STRING COMMENT 'Status of allocation of this freight invoice cost to joint venture partners under Joint Interest Billing (JIB) arrangements: pending, allocated, completed, or not applicable.. Valid values are `pending|allocated|completed|not_applicable`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight invoice record was last modified or updated.',
    `origin_location` STRING COMMENT 'Name or identifier of the origin location where the freight movement originated (production facility, terminal, port, or custody transfer point).',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid to date against this freight invoice, supporting partial payment tracking.',
    `payment_date` DATE COMMENT 'Actual date the freight invoice was paid or partially paid.',
    `payment_due_date` DATE COMMENT 'Date by which payment is due to the carrier per the payment terms.',
    `payment_status` STRING COMMENT 'Current payment status of the freight invoice: pending, paid, partial (partially paid), overdue, disputed, or cancelled.. Valid values are `pending|paid|partial|overdue|disputed|cancelled`',
    `payment_terms` STRING COMMENT 'Payment terms specified on the invoice, such as Net 30, Net 60, or Due on Receipt.',
    `pda_charge` DECIMAL(18,2) COMMENT 'Port disbursement account charges covering port fees, pilotage, tugs, and other port-related expenses incurred during marine vessel operations.',
    `purchase_order_number` STRING COMMENT 'Purchase order number against which this freight invoice is matched for three-way matching (PO, receipt, invoice) in accounts payable processing.',
    `shipped_volume` DECIMAL(18,2) COMMENT 'Total volume of product transported under this freight invoice.',
    `total_invoice_amount` DECIMAL(18,2) COMMENT 'Total amount due on the freight invoice, calculated as base freight amount plus demurrage, fuel surcharge, PDA charges, accessorial charges, minus despatch credits.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the freight movement: pipeline, tanker (marine vessel), truck, rail, barge, or FPSO (Floating Production Storage and Offloading).. Valid values are `pipeline|tanker|truck|rail|barge|fpso`',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for the shipped volume: BBL (barrels), MCF (thousand cubic feet), MMCF (million cubic feet), GAL (gallons), MT (metric tons), M3 (cubic meters).. Valid values are `BBL|MCF|MMCF|GAL|MT|M3`',
    CONSTRAINT pk_freight_invoice PRIMARY KEY(`freight_invoice_id`)
) COMMENT 'Transactional billing document issued by a carrier or freight broker to the shipper for transportation services rendered across all transport modes. Captures invoice number, invoice date, carrier ID, voyage or shipment reference, transport mode, freight rate basis, base freight amount, demurrage charges, despatch credits, port disbursement account (PDA) charges, fuel surcharge, currency, payment due date, payment status, dispute flag, and cost allocation to specific cargoes and cost centers. Supports accounts payable processing, freight cost management, and carrier performance tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` (
    `demurrage_claim_id` BIGINT COMMENT 'Unique identifier for the demurrage claim record. Primary key for the demurrage claim entity.',
    `charter_party_id` BIGINT COMMENT 'Reference to the charter party agreement governing the terms of vessel hire, laytime allowances, and demurrage rates for this voyage.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Claims analyst prepares demurrage calculations, negotiates settlements, and manages dispute resolution. Financial accountability for demurrage/despatch claims, laytime analysis, and charter party inte',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the counterparty (charterer, shipper, or consignee) against whom the demurrage claim is being raised. Represents the party reference required for transaction headers.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Demurrage disputes on regulated pipelines may require FERC notification. Claims reference the regulatory filing for dispute resolution and rate case support. Real-world operations link significant cla',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Demurrage costs are unplanned expenses that must be charged to responsible cost centers for performance tracking, accountability, and operational efficiency improvement initiatives.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Demurrage posts to specific GL accounts (demurrage expense, accrued demurrage) for financial reporting, audit compliance, and expense recognition under GAAP/IFRS.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Demurrage claims on JV liftings are allocated to partners via JIB based on working interest. JOA reference enables cost recovery, partner billing, and dispute resolution per joint operating agreement ',
    `port_call_id` BIGINT COMMENT 'Foreign key linking to logistics.port_call. Business justification: Demurrage claims arise from specific port call delays. Adding port_call_id FK allows joining to get port call details (arrival, departure, laytime). Removes denormalized port_id and port_name.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Demurrage impacts profit center economics and must be tracked for operational efficiency metrics, crude marketing performance, and management KPI reporting.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Approved demurrage claims generate invoices to counterparties for laytime overruns. Essential for monetizing vessel delays and tracking demurrage receivables in tanker operations.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Demurrage costs arising from customer-driven delays (late vessel arrival, slow discharge) must be allocated to sales transactions for profitability analysis and potential customer cost recovery per sa',
    `voyage_id` BIGINT COMMENT 'Reference to the specific voyage during which the demurrage event occurred. Links to the voyage master record for vessel movement tracking.',
    `agreed_amount` DECIMAL(18,2) COMMENT 'Final demurrage amount agreed between parties after negotiation or dispute resolution. May differ from the original claim amount if a settlement was reached.',
    `cargo_volume` DECIMAL(18,2) COMMENT 'Total volume of cargo loaded or discharged during the operation, relevant for calculating demurrage exposure and commercial impact.',
    `cargo_volume_uom` STRING COMMENT 'Unit of measure for cargo volume: barrels (BBL), cubic meters (M3), metric tons (MT), or million British thermal units (MMBTU) for gas.. Valid values are `BBL|M3|MT|MMBTU`',
    `claim_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the demurrage claim calculated as (demurrage_hours / 24) * demurrage_rate_per_day, or despatch payment if negative. Represents the net total for this transaction.',
    `claim_date` DATE COMMENT 'Date when the demurrage claim was formally raised or submitted to the counterparty. Represents the principal business event timestamp for this transaction.',
    `claim_notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding the demurrage claim, including negotiation history, special circumstances, or internal observations.',
    `claim_reference_number` STRING COMMENT 'Externally-known business identifier for the demurrage claim, used in communications with counterparties and in charter party documentation.',
    `claim_status` STRING COMMENT 'Current lifecycle status of the demurrage claim in the settlement workflow. Tracks progression from initial draft through final settlement or rejection. [ENUM-REF-CANDIDATE: draft|submitted|under_review|disputed|agreed|settled|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this demurrage claim record was first created in the system. Represents the record audit created timestamp.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the claim amount and demurrage rates. Most charter parties denominate demurrage in USD. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|AED|SGD — 7 candidates stripped; promote to reference product]',
    `demurrage_hours` DECIMAL(18,2) COMMENT 'Number of hours by which laytime used exceeded laytime allowed, forming the basis for demurrage charge calculation. Positive value indicates demurrage owed.',
    `demurrage_rate_per_day` DECIMAL(18,2) COMMENT 'Contractual demurrage rate specified in the charter party, expressed as currency amount per day. Used to calculate total demurrage charges based on demurrage hours.',
    `despatch_hours` DECIMAL(18,2) COMMENT 'Number of hours by which laytime used was less than laytime allowed, forming the basis for despatch payment calculation. Positive value indicates despatch earned.',
    `despatch_rate_per_day` DECIMAL(18,2) COMMENT 'Contractual despatch rate specified in the charter party, typically calculated as a percentage (often 50%) of the demurrage rate, expressed as currency amount per day.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the counterparty has disputed the demurrage claim. True indicates an active dispute requiring resolution.',
    `dispute_raised_date` DATE COMMENT 'Date when the counterparty formally raised a dispute against the demurrage claim.',
    `dispute_reason` STRING COMMENT 'Detailed explanation provided by the counterparty for disputing the demurrage claim, including specific objections to laytime calculations, rate applications, or time exceptions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this demurrage claim record was last updated. Represents the record audit updated timestamp for tracking changes through the claim lifecycle.',
    `laytime_allowed_hours` DECIMAL(18,2) COMMENT 'Total laytime hours contractually allowed under the charter party agreement for loading or discharge operations before demurrage charges begin to accrue.',
    `laytime_calculation_method` STRING COMMENT 'Method specified in the charter party for calculating laytime across loading and discharge ports: reversible (combined), irreversible (separate), average, or separate calculations.. Valid values are `reversible|irreversible|average|separate`',
    `laytime_used_hours` DECIMAL(18,2) COMMENT 'Actual laytime hours consumed during the loading or discharge operation, calculated from Notice of Readiness (NOR) to completion of cargo operations.',
    `notice_of_readiness_timestamp` TIMESTAMP COMMENT 'Date and time when the vessel tendered Notice of Readiness to the port or terminal, marking the official start of laytime calculation.',
    `operations_commenced_timestamp` TIMESTAMP COMMENT 'Date and time when actual cargo loading or discharge operations began at the port or terminal.',
    `operations_completed_timestamp` TIMESTAMP COMMENT 'Date and time when cargo loading or discharge operations were completed and the vessel was ready to depart, marking the end of laytime calculation.',
    `payment_due_date` DATE COMMENT 'Contractual date by which the counterparty must remit payment for the agreed demurrage amount, typically specified in the charter party terms.',
    `payment_received_date` DATE COMMENT 'Actual date when payment for the demurrage claim was received and reconciled in the financial system.',
    `port_operation_type` STRING COMMENT 'Type of port operation during which demurrage occurred: loading operations, discharge operations, or both.. Valid values are `loading|discharge|both`',
    `product_type` STRING COMMENT 'Type of petroleum product being transported during the voyage that incurred demurrage charges. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|lng|lpg|ngl|gasoline|diesel|jet_fuel|fuel_oil|petrochemicals — 10 candidates stripped; promote to reference product]',
    `responsible_party` STRING COMMENT 'Name or identifier of the internal business unit, department, or individual responsible for managing and pursuing this demurrage claim.',
    `settlement_date` DATE COMMENT 'Date when the demurrage claim was fully settled and payment was received or agreed upon by both parties.',
    `statement_of_facts_reference` STRING COMMENT 'Reference number or identifier for the Statement of Facts document, which provides the official chronological record of vessel activities and time usage at the port.',
    `supporting_documentation` STRING COMMENT 'References to supporting documents for the demurrage claim, including time sheets, statements of facts, NOR copies, port logs, and correspondence with the counterparty.',
    `time_exceptions_hours` DECIMAL(18,2) COMMENT 'Total hours excluded from laytime calculation due to exceptions specified in the charter party (weather delays, equipment breakdown, force majeure, holidays, etc.).',
    `time_exceptions_reason` STRING COMMENT 'Detailed explanation of the reasons for time exceptions, including weather events, mechanical failures, port congestion, or other force majeure circumstances.',
    `vessel_imo_number` STRING COMMENT 'Unique seven-digit IMO ship identification number assigned by the International Maritime Organization for permanent vessel identification.. Valid values are `^IMO[0-9]{7}$`',
    `vessel_name` STRING COMMENT 'Name of the vessel (tanker, LNG carrier, FPSO, or other marine transport asset) involved in the demurrage event.',
    CONSTRAINT pk_demurrage_claim PRIMARY KEY(`demurrage_claim_id`)
) COMMENT 'Transactional record tracking demurrage and despatch claims arising from vessel delays at load or discharge ports beyond the agreed laytime. Captures claim reference, voyage ID, vessel name, port (load or discharge), laytime allowed (hours), laytime used (hours), demurrage or despatch hours, demurrage rate (USD per day), claim amount, claim status (draft, submitted, disputed, agreed, settled), counterparty, dispute reason, and settlement date. Critical for freight cost management and charter party compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` (
    `shipping_schedule_id` BIGINT COMMENT 'Unique identifier for the shipping schedule. Primary key for the shipping schedule master planning entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shipping schedule planning activities incur costs that must be allocated to cost centers for logistics planning expense tracking and operations overhead management.',
    `lifting_program_id` BIGINT COMMENT 'Reference to the parent lifting program that governs the allocation and entitlements driving this shipping schedule.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Shipping schedules coordinate product movements that impact profit center P&L through crude oil sales, freight costs, and lifting performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipping schedule record was first created in the system. Audit trail for data lineage and compliance.',
    `demurrage_risk_assessment` STRING COMMENT 'Assessment of demurrage risk exposure for this schedule based on port congestion, vessel availability, and operational constraints.. Valid values are `low|medium|high|critical`',
    `ferc_tariff_compliance_flag` BOOLEAN COMMENT 'Boolean indicator whether this schedule must comply with Federal Energy Regulatory Commission (FERC) tariff reporting requirements for interstate pipeline and marine transportation.',
    `fpso_lifting_flag` BOOLEAN COMMENT 'Boolean indicator whether this schedule includes liftings from Floating Production Storage and Offloading (FPSO) vessels in offshore operations.',
    `joa_allocation_basis` STRING COMMENT 'Basis for allocating lifting volumes among Joint Operating Agreement (JOA) partners: working interest (WI), net revenue interest (NRI), production entitlement, or equal share.. Valid values are `working_interest|net_revenue_interest|production_entitlement|equal_share`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipping schedule record was last modified or updated. Audit trail for change tracking and compliance.',
    `number_of_vessels_assigned` STRING COMMENT 'Count of unique vessels assigned to execute liftings within this shipping schedule planning period.',
    `phmsa_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator whether this schedule requires reporting to Pipeline and Hazardous Materials Safety Administration (PHMSA) for pipeline safety and hazardous materials transportation compliance.',
    `pipeline_integration_flag` BOOLEAN COMMENT 'Boolean indicator whether this shipping schedule is integrated with pipeline nomination and SCADA systems for coordinated logistics.',
    `planning_horizon_type` STRING COMMENT 'Classification of the planning period duration and frequency (monthly, quarterly, annual, or rolling window).. Valid values are `monthly|quarterly|annual|rolling`',
    `planning_period_end_date` DATE COMMENT 'End date of the planning horizon covered by this shipping schedule, typically the last day of the month or quarter.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning horizon covered by this shipping schedule, typically the first day of the month or quarter.',
    `primary_product_type` STRING COMMENT 'Dominant product type being transported in this shipping schedule (crude oil, natural gas, LNG, LPG, NGLs, refined products, or petrochemicals). [ENUM-REF-CANDIDATE: crude_oil|natural_gas|lng|lpg|ngl|refined_products|petrochemicals — 7 candidates stripped; promote to reference product]',
    `psa_entitlement_flag` BOOLEAN COMMENT 'Boolean indicator whether this schedule includes liftings governed by Production Sharing Agreement (PSA) entitlements with host governments or national oil companies (NOCs).',
    `scada_integration_status` STRING COMMENT 'Status of integration with Supervisory Control and Data Acquisition (SCADA) pipeline monitoring systems for real-time coordination of vessel movements and pipeline flows.. Valid values are `integrated|partial|not_integrated|pending`',
    `schedule_approved_by` STRING COMMENT 'Name or identifier of the authorized approver who approved this shipping schedule for publication and execution.',
    `schedule_approved_date` DATE COMMENT 'Date when the shipping schedule received formal approval and was authorized for publication to operational teams.',
    `schedule_notes` STRING COMMENT 'Free-text notes capturing additional context, constraints, assumptions, or special instructions relevant to this shipping schedule.',
    `schedule_optimization_method` STRING COMMENT 'Method used to optimize the shipping schedule: manual planning, rule-based system, mathematical optimization algorithm, or AI/ML-driven planning.. Valid values are `manual|rule_based|optimization_algorithm|ai_ml`',
    `schedule_prepared_by` STRING COMMENT 'Name or identifier of the marine logistics planner or team responsible for preparing this shipping schedule.',
    `schedule_prepared_date` DATE COMMENT 'Date when the shipping schedule was initially prepared and drafted by the planning team.',
    `schedule_published_date` DATE COMMENT 'Date when the approved shipping schedule was published and communicated to vessel operators, terminals, and logistics partners.',
    `schedule_reference_number` STRING COMMENT 'Externally-known unique business identifier for the shipping schedule, typically formatted as SS-YYYY-NNNNNN where YYYY is year and NNNNNN is sequence number.. Valid values are `^SS-[0-9]{4}-[0-9]{6}$`',
    `schedule_revision_reason` STRING COMMENT 'Business justification or explanation for revisions made to the shipping schedule after initial publication (e.g., weather delays, production changes, vessel availability).',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the shipping schedule indicating its approval and publication state in the planning workflow.. Valid values are `draft|approved|published|revised|cancelled|archived`',
    `schedule_version` STRING COMMENT 'Version number of the shipping schedule to track revisions and updates to the master plan. Increments with each revision.',
    `total_planned_liftings` STRING COMMENT 'Total number of planned vessel cargo liftings scheduled within this planning period across all vessels and products.',
    `total_planned_volume_bbl` DECIMAL(18,2) COMMENT 'Total planned cargo volume across all liftings in this schedule, measured in barrels (BBL). Represents aggregate lifting capacity for the planning period.',
    `total_planned_volume_boe` DECIMAL(18,2) COMMENT 'Total planned cargo volume converted to Barrel of Oil Equivalent (BOE) for standardized reporting across crude oil, natural gas, LNG, LPG, and NGLs.',
    `weather_contingency_buffer_days` STRING COMMENT 'Number of buffer days built into the schedule to accommodate weather-related delays and ensure operational resilience.',
    CONSTRAINT pk_shipping_schedule PRIMARY KEY(`shipping_schedule_id`)
) COMMENT 'Master planning entity representing the consolidated schedule of all planned vessel movements and cargo liftings for a given planning horizon (monthly or quarterly). Captures schedule reference, planning period, schedule version, total planned liftings, total planned volume (BBL), number of vessels assigned, schedule status (draft, approved, published, revised), approval date, approved by, and associated lifting program references. Serves as the operational master plan for marine logistics coordination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` (
    `truck_ticket_id` BIGINT COMMENT 'Unique identifier for the truck ticket record. Primary key for the truck ticket transaction.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier or trucking company responsible for the delivery.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Truck loading operations incur costs (labor, rack maintenance) that must be charged to cost centers for terminal operations accounting and operational expense tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the driver who operated the truck and received the loaded product. Personally identifiable information.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Truck loadings from tank batteries must tie to originating lease for royalty calculation and production accounting. Enables proper revenue distribution to working interest and royalty owners based on ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Truck loadings require facility operating permits and hazmat transport permits. Tickets reference permit numbers for compliance verification. Real-world operations link each ticket to the authorizing ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Truck tickets record loading of specific petroleum products; FK essential for DOT hazmat classification, UN number determination, emergency response procedures, tariff rate application, and quality ve',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Truck deliveries represent product sales/transfers that impact profit center P&L through product revenue and transportation costs.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Truck loadings of crude oil track source reservoir for quality certification and allocation in multi-reservoir lease operations. Essential for accurate production accounting and royalty calculations w',
    `terminal_id` BIGINT COMMENT 'Reference to the terminal, well pad, or loading facility where the truck was loaded.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement of the loaded crude oil or petroleum product, indicating density relative to water. Higher values indicate lighter products.',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading number associated with this truck shipment for legal custody transfer documentation.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `bsw_percentage` DECIMAL(18,2) COMMENT 'Percentage of bottom sediment and water content in the loaded product, deducted from gross volume to determine net volume for custody transfer.',
    `consignee_name` STRING COMMENT 'Name of the consignee or receiving party at the destination facility.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this truck ticket record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for tariff rate and financial amounts.. Valid values are `^[A-Z]{3}$`',
    `destination_address` STRING COMMENT 'Full street address of the delivery destination. Business-confidential organizational contact data.',
    `driver_license_number` STRING COMMENT 'Commercial driver license number of the operator. Personally identifiable information required for regulatory compliance.',
    `driver_name` STRING COMMENT 'Full name of the driver who received the loaded product at the truck rack. Personally identifiable information.',
    `emergency_response_guide_number` STRING COMMENT 'Three-digit Emergency Response Guidebook number for first responders in case of incident.. Valid values are `^[0-9]{3}$`',
    `gross_volume` DECIMAL(18,2) COMMENT 'Total observed volume of product loaded onto the truck at observed temperature and pressure conditions.',
    `hazmat_class` STRING COMMENT 'Department of Transportation hazardous material classification for the loaded product.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this truck ticket record was last updated or modified.',
    `loading_end_timestamp` TIMESTAMP COMMENT 'Date and time when the truck loading operation was completed and sealed.',
    `loading_rack_code` STRING COMMENT 'Specific loading rack or bay identifier within the terminal where the truck was loaded.. Valid values are `^[A-Z0-9-]{3,15}$`',
    `loading_start_timestamp` TIMESTAMP COMMENT 'Date and time when the truck loading operation commenced at the rack.',
    `net_volume` DECIMAL(18,2) COMMENT 'Net standard volume of product after adjusting for temperature, pressure, and deducting bottom sediment and water (BS&W). Used for custody transfer and billing.',
    `observed_temperature` DECIMAL(18,2) COMMENT 'Temperature of the product at the time of loading, used for volume correction calculations.',
    `operator_notes` STRING COMMENT 'Free-text notes entered by the loading rack operator regarding special conditions, observations, or instructions for this ticket.',
    `seal_numbers` STRING COMMENT 'Comma-separated list of security seal numbers applied to the truck compartments or valves to ensure product integrity during transit.',
    `seal_verification_status` STRING COMMENT 'Status of seal verification at loading, indicating whether seals were intact and properly applied.. Valid values are `verified|broken|missing|not_applicable`',
    `sulfur_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of sulfur content in the loaded product, critical for product quality specification and environmental compliance.',
    `tariff_rate` DECIMAL(18,2) COMMENT 'Transportation tariff rate applied to this truck delivery, expressed per unit of volume.',
    `temperature_uom` STRING COMMENT 'Unit of measure for temperature. F = Fahrenheit, C = Celsius.. Valid values are `F|C`',
    `ticket_date` DATE COMMENT 'Calendar date when the truck loading transaction occurred at the terminal or well pad loading rack.',
    `ticket_number` STRING COMMENT 'Externally-known unique ticket number assigned at the loading rack for custody transfer documentation and audit trail.. Valid values are `^[A-Z0-9]{6,20}$`',
    `ticket_status` STRING COMMENT 'Current lifecycle status of the truck ticket in the dispatch and delivery workflow.. Valid values are `draft|loaded|in_transit|delivered|cancelled|disputed`',
    `ticket_timestamp` TIMESTAMP COMMENT 'Precise date and time when the truck loading was completed and the ticket was issued, representing the principal business event timestamp for custody transfer.',
    `trailer_number` STRING COMMENT 'Trailer or tank unit number attached to the truck for product transport.. Valid values are `^[A-Z0-9-]{3,15}$`',
    `truck_registration_number` STRING COMMENT 'Vehicle registration or license plate number of the truck tanker used for transportation.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `truck_unit_number` STRING COMMENT 'Fleet unit number or internal identifier assigned to the truck by the carrier.. Valid values are `^[A-Z0-9-]{3,15}$`',
    `un_number` STRING COMMENT 'Four-digit UN identification number for the hazardous material being transported.. Valid values are `^UN[0-9]{4}$`',
    `volume_uom` STRING COMMENT 'Unit of measure for the volume quantities. BBL = Barrels, GAL = Gallons, L = Liters, M3 = Cubic Meters.. Valid values are `BBL|GAL|L|M3`',
    CONSTRAINT pk_truck_ticket PRIMARY KEY(`truck_ticket_id`)
) COMMENT 'Transactional record capturing the loading and dispatch of petroleum products via road tanker from a terminal or well pad truck loading rack. Records ticket number, ticket date and time, terminal or loading point, driver ID, truck registration, carrier ID, product type and grade, gross volume loaded (BBL or gallons), net volume, API gravity, temperature, BS&W, seal numbers, destination facility, consignee, and ticket status. Supports custody transfer at truck rack and last-mile delivery tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` (
    `pipeline_batch_id` BIGINT COMMENT 'Unique identifier for the pipeline batch record. Primary key for the pipeline batch entity.',
    `commercial_counterparty_id` BIGINT COMMENT 'Identifier of the shipper or party who owns the product being transported in this batch.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pipeline batch movements incur transportation costs that must be allocated to cost centers for pipeline operations accounting and FERC cost-of-service reporting.',
    `delivery_point_id` BIGINT COMMENT 'Identifier of the physical location where the batch is scheduled to be delivered from the pipeline system.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Pipeline batches from JV assets need JOA tracking for volumetric allocation to partners, line loss/fuel gas cost sharing, and imbalance reconciliation. Essential for partner-level throughput accountin',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Pipeline batches track crude/gas from originating leases through midstream system for volumetric reconciliation, shrinkage allocation, and royalty payment. Batch-to-lease tracking enables lease-level ',
    `measurement_point_id` BIGINT COMMENT 'Identifier of the physical location where the batch was injected into the pipeline system.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Pipeline batches require operating permits from FERC/state agencies. Batch records reference the permit authorizing transport. Compliance teams verify permit coverage for each batch, ensuring regulato',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Pipeline batches move specific products through pipeline systems; FK required for interface management instructions, product compatibility verification, quality tracking, tariff rate application, and ',
    `pipeline_segment_id` BIGINT COMMENT 'Identifier of the pipeline segment through which this batch is transported.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Pipeline batches represent product movements that impact profit center economics through transportation costs, line losses, and fuel gas consumption.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Pipeline batches track back to source reservoir for quality specifications (API gravity, sulfur content), custody transfer accuracy, and revenue allocation in multi-reservoir field operations. Essenti',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Pipeline batches fulfill sales orders; tracking this link enables delivery confirmation, volume reconciliation against sales order quantities, revenue recognition timing, and customer-specific deliver',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Pipeline scheduler manages nomination confirmations, batch sequencing, interface management, and SCADA coordination. Operational accountability for pipeline throughput optimization, shipper allocation',
    `spill_event_id` BIGINT COMMENT 'Foreign key linking to hse.spill_event. Business justification: Pipeline batches track loss of primary containment events for volume reconciliation and environmental reporting. Essential for PHMSA reporting and liability determination.',
    `actual_injected_volume` DECIMAL(18,2) COMMENT 'Actual volume of product injected into the pipeline at the injection point, as measured by custody transfer meters.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement of the crude oil or liquid product, indicating density and quality for pricing and allocation purposes.',
    `batch_reference_number` STRING COMMENT 'Externally-known business identifier for the pipeline batch, used for operational tracking and communication with shippers and operators.',
    `batch_sequence_number` STRING COMMENT 'Sequential ordering number of this batch within the pipeline segment for a given time period, used for tracking batch progression and interface management.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the pipeline batch in the transportation workflow.. Valid values are `scheduled|injecting|in_transit|delivering|delivered|cancelled`',
    `bsw_percentage` DECIMAL(18,2) COMMENT 'Percentage of basic sediment and water content in crude oil, used for net volume calculation and quality assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pipeline batch record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this batch record.. Valid values are `^[A-Z]{3}$`',
    `delivery_end_timestamp` TIMESTAMP COMMENT 'Date and time when the batch delivery from the pipeline was completed at the delivery point.',
    `delivery_start_timestamp` TIMESTAMP COMMENT 'Date and time when the batch delivery from the pipeline began at the delivery point.',
    `fuel_gas_used_volume` DECIMAL(18,2) COMMENT 'Volume of natural gas consumed as fuel for pipeline compression and pumping operations during batch transportation.',
    `gas_specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of natural gas relative to air, used for flow measurement and energy calculations.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide content in parts per million, critical for safety and corrosion management in sour gas handling.',
    `heating_value_btu_per_scf` DECIMAL(18,2) COMMENT 'Heating value of natural gas in BTU per standard cubic foot, used for energy content measurement and pricing.',
    `imbalance_volume` DECIMAL(18,2) COMMENT 'Difference between nominated volume and actual delivered volume, used for shipper imbalance tracking and settlement.',
    `injection_end_timestamp` TIMESTAMP COMMENT 'Date and time when the batch injection into the pipeline was completed.',
    `injection_start_timestamp` TIMESTAMP COMMENT 'Date and time when the batch injection into the pipeline began, representing the start of the transportation event.',
    `interface_management_instruction` STRING COMMENT 'Operational instructions for managing the interface between this batch and adjacent batches to minimize product contamination and quality degradation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pipeline batch record was last updated, used for audit trail and data lineage tracking.',
    `line_loss_volume` DECIMAL(18,2) COMMENT 'Volume lost during transportation due to evaporation, leakage, or measurement variance. Negative values indicate line gain.',
    `metered_delivery_volume` DECIMAL(18,2) COMMENT 'Volume measured at the delivery meter point, used for custody transfer reconciliation and volume accounting.',
    `metered_receipt_volume` DECIMAL(18,2) COMMENT 'Volume measured at the receipt/injection meter point, used for custody transfer and shipper allocation calculations.',
    `nominated_volume` DECIMAL(18,2) COMMENT 'Volume of product that the shipper nominated for transportation in this batch, representing the requested capacity allocation.',
    `nominated_volume_uom` STRING COMMENT 'Unit of measure for the nominated volume (BBL for barrels, MMCF for million cubic feet, etc.). [ENUM-REF-CANDIDATE: BBL|MBBL|MMCF|BCF|MCF|GAL|M3 — 7 candidates stripped; promote to reference product]',
    `operator_notes` STRING COMMENT 'Free-text field for pipeline operators to record observations, issues, or special handling instructions related to this batch.',
    `phmsa_pipeline_code` STRING COMMENT 'PHMSA-assigned identifier for the pipeline system, used for regulatory reporting and safety compliance tracking.',
    `rvp_psi` DECIMAL(18,2) COMMENT 'Reid Vapor Pressure measurement in PSI for gasoline and light products, used for quality control and safety compliance.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether this batch is integrated with SCADA systems for real-time monitoring and control.',
    `shrinkage_volume` DECIMAL(18,2) COMMENT 'Volume reduction due to temperature and pressure changes, phase transitions, or processing losses during transportation.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Percentage of sulfur content in the product, critical for quality specification compliance and environmental regulations.',
    `tariff_rate` DECIMAL(18,2) COMMENT 'Transportation tariff rate applied to this batch for revenue calculation, expressed per unit volume.',
    `tariff_rate_uom` STRING COMMENT 'Unit of measure for the tariff rate (e.g., USD per barrel, USD per MMBTU).. Valid values are `USD_PER_BBL|USD_PER_MMBTU|USD_PER_MCF`',
    `volume_uom` STRING COMMENT 'Unit of measure for all actual volume measurements in this batch record. [ENUM-REF-CANDIDATE: BBL|MBBL|MMCF|BCF|MCF|GAL|M3 — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_pipeline_batch PRIMARY KEY(`pipeline_batch_id`)
) COMMENT 'Transactional record representing a discrete batch of petroleum product injected into and transported through a pipeline system, including throughput measurement, shipper allocation, and volume reconciliation. Captures batch ID, pipeline segment ID, batch sequence number, product type and grade, shipper ID, injection and delivery points, injection start/end timestamps, nominated volume (BBL or MMCFD), actual injected volume, metered receipt and delivery volumes, daily and monthly throughput aggregations, line loss or gain, fuel gas used, shrinkage, imbalance volume, batch quality specifications (API gravity, sulfur content, RVP), interface management instructions, measurement point references, and batch status. Supports pipeline scheduling, quality tracking, shipper allocation, shipper imbalance management, FERC Form 6 reporting, and tariff revenue calculation. Serves as the SSOT for all pipeline volume tracking from nomination fulfillment through delivery reconciliation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` (
    `storage_inventory_id` BIGINT COMMENT 'Unique identifier for the storage inventory transaction record. Primary key for the storage inventory product.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Inventory held under term contracts (strategic reserves, take-or-pay obligations) must be tracked for contract performance monitoring, deficiency payment calculations, and working capital allocation t',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Inventory levels trigger EIA storage reports and state production filings. Inventory snapshots link to the regulatory filing for audit trail, ensuring accurate reporting of stored volumes and supporti',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory storage costs (tank rental, heating, losses) must be charged to cost centers for working capital management, LOE tracking, and operational expense control.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Inventory controller manages tank gauging, custody transfer reconciliation, working capital valuation, and loss control. Critical for financial reporting, audit compliance, and operational accountabil',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Joint venture storage inventory requires JOA reference for partner ownership allocation, working capital valuation per partner, and inventory imbalance tracking. Drives partner-level balance sheet rep',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Tank farm inventory often holds commingled production from multiple leases. Tracking lease-level inventory allocation enables proper revenue distribution when product is sold and accurate royalty disb',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Storage tanks require permits (air emissions, SPCC, tank registration). Inventory records reference the permit authorizing storage. Real-world operations link inventory to permit for compliance verifi',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Storage inventory tracks specific petroleum products in tanks; FK essential for inventory valuation, working capital calculation, quality monitoring against specifications, loss/gain analysis, and fin',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Inventory positions impact profit center working capital and must be valued for segment reporting, crude marketing performance, and balance sheet management.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Tank inventories segregate crude/condensate by source reservoir due to quality differences (API gravity, sulfur content). Required for blending operations, custody transfer accuracy, and working capit',
    `terminal_id` BIGINT COMMENT 'Identifier of the terminal, tank farm, or floating storage unit where the inventory is held.',
    `api_gravity` DECIMAL(18,2) COMMENT 'Measure of petroleum liquid density relative to water, expressed in API degrees. Higher API gravity indicates lighter, more valuable crude oil.',
    `bsw_percentage` DECIMAL(18,2) COMMENT 'Percentage of basic sediment and water content in the crude oil or product, critical for quality specification and net volume calculation.',
    `closing_inventory_bbl` DECIMAL(18,2) COMMENT 'Inventory volume in barrels at the end of the inventory period, calculated as opening inventory plus receipts minus deliveries, adjusted for any gains or losses.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage inventory record was first created in the system.',
    `custody_transfer_flag` BOOLEAN COMMENT 'Indicates whether this inventory record is associated with a custody transfer event requiring regulatory-grade measurement accuracy and documentation.',
    `deliveries_bbl` DECIMAL(18,2) COMMENT 'Total volume in barrels delivered out of the tank during the inventory period to customers, pipelines, vessels, or other destinations.',
    `gauge_reference_height` DECIMAL(18,2) COMMENT 'Reference height measurement from the tank datum point to the liquid surface, used in manual or automatic tank gauging calculations.',
    `gross_observed_volume_bbl` DECIMAL(18,2) COMMENT 'Total measured volume in barrels at observed temperature and pressure conditions, including water and sediment, before any corrections or adjustments.',
    `gross_standard_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume in barrels corrected to standard temperature (60°F) and pressure conditions, including water and sediment.',
    `inspection_date` DATE COMMENT 'Date when the independent inspection and quality testing of the inventory was performed.',
    `inspector_company` STRING COMMENT 'Name of the independent inspection company that performed quality testing and quantity verification for this inventory position.',
    `inventory_date` DATE COMMENT 'The business date for which this inventory position is recorded, typically end-of-day snapshot.',
    `inventory_status` STRING COMMENT 'Current operational status of the inventory position. Available for sale or delivery, allocated to specific contracts, in transit, quarantined for quality issues, contaminated, or reserved for future commitments.. Valid values are `available|allocated|in_transit|quarantined|contaminated|reserved`',
    `inventory_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the inventory measurement was taken or recorded in the system.',
    `inventory_variance_bbl` DECIMAL(18,2) COMMENT 'Difference in barrels between calculated closing inventory and physically measured closing inventory, indicating gains, losses, or measurement discrepancies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage inventory record was last updated or modified in the system.',
    `measurement_method` STRING COMMENT 'Method used to measure tank inventory. Manual gauge, ATG (Automatic Tank Gauge), radar level sensor, servo gauge, or hydrostatic pressure measurement.. Valid values are `manual_gauge|atg|radar|servo|hydrostatic`',
    `net_standard_volume_bbl` DECIMAL(18,2) COMMENT 'Net product volume in barrels at standard conditions (60°F, 14.696 psia) after deducting water and sediment, used for custody transfer and commercial transactions.',
    `observed_pressure` DECIMAL(18,2) COMMENT 'Pressure of the product at the time of measurement, relevant for pressurized storage of LPG, LNG, and natural gas liquids.',
    `observed_temperature` DECIMAL(18,2) COMMENT 'Temperature of the product at the time of measurement, used for volume correction calculations to standard conditions.',
    `opening_inventory_bbl` DECIMAL(18,2) COMMENT 'Inventory volume in barrels at the beginning of the inventory period, carried forward from the previous period closing balance.',
    `pressure_uom` STRING COMMENT 'Unit of measure for pressure. PSI (Pounds per Square Inch), PSIA (Pounds per Square Inch Absolute), BAR, KPA (Kilopascals), MPA (Megapascals).. Valid values are `PSI|PSIA|BAR|KPA|MPA`',
    `quality_certificate_number` STRING COMMENT 'Reference number of the quality inspection certificate documenting the products specifications and test results for this inventory batch.',
    `receipts_bbl` DECIMAL(18,2) COMMENT 'Total volume in barrels received into the tank during the inventory period from pipelines, vessels, trucks, or other sources.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to this inventory position, such as quality issues, operational constraints, or reconciliation notes.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether this inventory record is automatically integrated with SCADA pipeline monitoring systems for real-time data capture.',
    `sulfur_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of sulfur content in the petroleum product, important for quality grading, pricing, and environmental compliance.',
    `tank_capacity_bbl` DECIMAL(18,2) COMMENT 'Maximum working capacity of the storage tank in barrels, representing the safe operational limit for product storage.',
    `tank_code` BIGINT COMMENT 'Identifier of the specific storage tank holding the petroleum product inventory.',
    `tank_strapping_table_code` STRING COMMENT 'Identifier of the calibration table used to convert gauge height to volume, based on the tanks physical dimensions and geometry.',
    `temperature_uom` STRING COMMENT 'Unit of measure for temperature. F (Fahrenheit), C (Celsius), K (Kelvin).. Valid values are `F|C|K`',
    `ullage_bbl` DECIMAL(18,2) COMMENT 'Empty space in barrels between the top of the liquid product and the tank roof or reference point, used to calculate available storage capacity.',
    `valuation_price_per_bbl` DECIMAL(18,2) COMMENT 'Unit price per barrel used for inventory valuation, typically based on market index prices or weighted average cost method.',
    `volume_uom` STRING COMMENT 'Unit of measure for volume quantities. BBL (Barrels), GAL (Gallons), M3 (Cubic Meters), L (Liters).. Valid values are `BBL|GAL|M3|L`',
    `water_bottom_bbl` DECIMAL(18,2) COMMENT 'Volume of water in barrels accumulated at the bottom of the tank, measured separately from the product volume for custody transfer and quality purposes.',
    `working_capital_value_usd` DECIMAL(18,2) COMMENT 'Estimated financial value of the inventory position in US Dollars, calculated using current market prices for working capital and financial reporting purposes.',
    CONSTRAINT pk_storage_inventory PRIMARY KEY(`storage_inventory_id`)
) COMMENT 'Transactional record tracking the daily inventory position of petroleum products held in storage tanks at terminals, tank farms, and floating storage units. Captures inventory date, terminal ID, tank ID, product type and grade, opening inventory (BBL), receipts (BBL), deliveries (BBL), closing inventory (BBL), tank capacity (BBL), ullage (BBL), water bottom (BBL), temperature, API gravity, and inventory status. Supports supply chain balancing, custody reconciliation, and working capital management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`charter_party` (
    `charter_party_id` BIGINT COMMENT 'Unique identifier for the charter party contract. Primary key for the charter party entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Charter manager negotiates fixture terms, manages laytime provisions, and oversees demurrage/despatch settlements. Commercial accountability for tanker charter party execution and freight cost managem',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Charter party costs (freight, demurrage) must be allocated to cost centers for marine operations accounting, budget tracking, and shipping expense management.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Charter costs and revenues post to specific GL accounts for freight expense/revenue recognition, financial statement preparation, and GAAP/IFRS compliance.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Vessel charters for offshore operations require permits (export license, offshore loading). Charter agreements reference permit coverage. Real-world operations link charter to permit for compliance ve',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the party hiring the vessel. The charterer is responsible for cargo operations and freight payment under the charter party terms.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Charter parties represent significant commercial commitments that impact profit center economics through freight costs and voyage profitability.',
    `vessel_id` BIGINT COMMENT 'Reference to the vessel chartered under this agreement. Links to vessel master data containing vessel specifications and registration details.',
    `arbitration_clause` STRING COMMENT 'Arbitration terms for dispute resolution, including arbitration location (London, New York, Singapore) and applicable arbitration rules (LMAA, SMA, SCMA).',
    `broker_name` STRING COMMENT 'Name of the shipbroker or brokerage firm that facilitated the charter party negotiation and fixture.',
    `cargo_description` STRING COMMENT 'Detailed description of the petroleum cargo to be transported, including product type, grade, and quality specifications.',
    `cargo_quantity` DECIMAL(18,2) COMMENT 'Contracted quantity of petroleum cargo to be loaded and transported under this charter party. Expressed in barrels or metric tons depending on product type.',
    `cargo_quantity_uom` STRING COMMENT 'Unit of measure for the cargo quantity. BBL for barrels (crude oil and refined products), MT for metric tons (LNG, LPG), CBM for cubic meters (gas products).. Valid values are `BBL|MT|CBM`',
    `cargo_tolerance_percentage` DECIMAL(18,2) COMMENT 'Allowable variance percentage above or below the contracted cargo quantity. Typically expressed as plus/minus percentage (e.g., 5% means charterer option to load 95-105% of nominated quantity).',
    `charter_status` STRING COMMENT 'Current lifecycle status of the charter party contract. Tracks progression from initial negotiation through execution and completion. [ENUM-REF-CANDIDATE: draft|negotiation|fixed|executed|in_progress|completed|cancelled|disputed — 8 candidates stripped; promote to reference product]',
    `charter_type` STRING COMMENT 'Classification of the charter party agreement defining the nature of vessel hire arrangement. Voyage charter covers single voyage, time charter covers vessel hire for period, bareboat charter transfers full operational control, contract of affreightment covers multiple voyages.. Valid values are `voyage_charter|time_charter|bareboat_charter|contract_of_affreightment`',
    `contract_effective_date` DATE COMMENT 'Date when the charter party contract becomes legally effective and binding on both parties. May differ from fixture date if subject to conditions precedent.',
    `contract_expiry_date` DATE COMMENT 'Date when the charter party contract expires or terminates. For voyage charters, typically upon cargo discharge completion. For time charters, the end of the charter period.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the charter party record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in the charter party agreement. Typically USD for international petroleum shipping.. Valid values are `^[A-Z]{3}$`',
    `demurrage_rate` DECIMAL(18,2) COMMENT 'Daily rate payable by the charterer to the shipowner when loading or discharge operations exceed the allowed laytime. Expressed in currency per day.',
    `despatch_rate` DECIMAL(18,2) COMMENT 'Daily rate payable by the shipowner to the charterer when loading or discharge operations are completed before the allowed laytime expires. Typically half the demurrage rate.',
    `discharge_port` STRING COMMENT 'Name of the port or terminal where the petroleum cargo will be discharged from the vessel. May include berth or jetty designation.',
    `discharge_port_country` STRING COMMENT 'Country where the discharge port is located. Three-letter ISO country code.',
    `fixture_date` DATE COMMENT 'Date when the charter party agreement was concluded and the vessel was fixed for the voyage or time period. Marks the contractual commitment date.',
    `form` STRING COMMENT 'Standard charter party form used as the basis for the agreement. Common forms include ASBATANKVOY, SHELLVOY, BP VOY, INTERTANKVOY for tankers.',
    `freight_rate` DECIMAL(18,2) COMMENT 'Rate of payment for the transportation service. For voyage charters, expressed as Worldscale points or lump sum. For time charters, expressed as daily hire rate.',
    `freight_rate_basis` STRING COMMENT 'Basis on which the freight rate is calculated. Worldscale for tanker voyage charters, lump sum for fixed voyage payment, per-unit rates for cargo-based payment, daily hire for time charters.. Valid values are `worldscale|lump_sum|usd_per_bbl|usd_per_mt|daily_hire`',
    `governing_law` STRING COMMENT 'Legal jurisdiction and law governing the charter party contract. Commonly English law, New York law, or other maritime jurisdiction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the charter party record was last updated. Tracks the most recent change to any field in the record for audit and version control purposes.',
    `laycan_end_date` DATE COMMENT 'Latest date within the laycan window when the vessel must arrive at the load port. Charterer may cancel the charter if vessel does not arrive by this date.',
    `laycan_start_date` DATE COMMENT 'Earliest date within the laycan window when the vessel must arrive at the load port and be ready to load. Start of the acceptable arrival window.',
    `laytime_allowed_hours` DECIMAL(18,2) COMMENT 'Total time allowed for loading and discharge operations before demurrage begins to accrue. Expressed in hours or days. May be calculated based on cargo quantity and loading rate.',
    `laytime_terms` STRING COMMENT 'Detailed terms governing laytime calculation, including whether time counts as running time, weather working days, Sundays and holidays excluded, and notice of readiness requirements.',
    `load_port` STRING COMMENT 'Name of the port or terminal where the petroleum cargo will be loaded onto the vessel. May include berth or jetty designation.',
    `load_port_country` STRING COMMENT 'Country where the load port is located. Three-letter ISO country code.',
    `payment_terms` STRING COMMENT 'Terms and conditions for freight payment, including payment timing (advance, on completion, within X days of bill of lading), payment method, and bank details.',
    `product_type` STRING COMMENT 'Classification of the petroleum product being transported. Defines the cargo category for operational and regulatory purposes. [ENUM-REF-CANDIDATE: crude_oil|lng|lpg|ngl|gasoline|diesel|jet_fuel|fuel_oil|naphtha|condensate — 10 candidates stripped; promote to reference product]',
    `reference` STRING COMMENT 'External business reference number or contract code assigned to the charter party agreement. Used for business communication and contract tracking.',
    `shipowner_name` STRING COMMENT 'Legal name of the vessel owner or shipping company providing the vessel under this charter party agreement.',
    `special_clauses` STRING COMMENT 'Additional negotiated clauses or riders appended to the standard charter party form, including war risk clauses, ice clauses, deviation clauses, and other special terms.',
    `total_freight_amount` DECIMAL(18,2) COMMENT 'Total freight payment amount for the charter party. Calculated based on freight rate, cargo quantity, and rate basis. Excludes demurrage and other additional charges.',
    CONSTRAINT pk_charter_party PRIMARY KEY(`charter_party_id`)
) COMMENT 'Master contract entity governing the terms under which a vessel is hired for the transportation of petroleum cargoes. Captures charter party reference, charter type (voyage charter, time charter, bareboat), vessel ID, charterer, shipowner, fixture date, laycan, load port, discharge port, cargo description, quantity (BBL or MT), freight rate (Worldscale or lump sum), demurrage rate (USD/day), laytime allowed (hours), payment terms, governing law, and charter status. Serves as the contractual basis for voyage execution and freight invoicing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`port_call` (
    `port_call_id` BIGINT COMMENT 'Unique identifier for the port call record. Primary key.',
    `charter_party_id` BIGINT COMMENT 'Foreign key linking to logistics.charter_party. Business justification: Port calls are executed under charter party terms (laytime, demurrage rates). Adding charter_party_id FK allows joining to get charter party details. Removes denormalized charter_party_reference strin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Port calls incur costs (port charges, agency fees, disbursements) requiring cost center allocation for marine operations accounting and voyage expense tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Port disbursements post to specific GL accounts (port charges, agency fees) for expense recognition, financial statement preparation, and audit compliance.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Port calls for JV cargo operations require JOA tracking for port cost allocation, laytime calculation per partner, and disbursement account cost recovery. Drives partner-level port expense billing via',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Port calls require berth permits and environmental permits (ballast water, emissions). Port operations track permit compliance per call. Real-world operations link each port call to the authorizing pe',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Port agents are service vendors managing vessel operations, customs clearance, and port disbursement accounts. Real business process: port cost accrual, vendor invoice matching for agency fees/port ch',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Port captain coordinates vessel berthing, cargo operations, laytime management, and port agent oversight. Essential operational role for tanker port calls, demurrage management, and cargo custody tran',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Port call costs impact voyage profitability and must be tracked by profit center for crude marketing performance and voyage economics analysis.',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Port calls occur at specific terminals. Adding terminal_id FK allows joining to get terminal details (operator, capacity, location, berths). Removes denormalized terminal_name, port_name, and port_cod',
    `vessel_id` BIGINT COMMENT 'Reference to the vessel making the port call. Identifies the tanker, LNG carrier, or other marine transport asset.',
    `actual_time_of_arrival` TIMESTAMP COMMENT 'Actual timestamp when the vessel arrived at the port or anchorage. Recorded by port authority or vessel agent.',
    `berth_number` STRING COMMENT 'Specific berth or jetty number where the vessel was moored during the port call.',
    `berthing_timestamp` TIMESTAMP COMMENT 'Timestamp when the vessel was secured alongside the berth and mooring operations were completed.',
    `bill_of_lading_number` STRING COMMENT 'Reference number of the Bill of Lading issued for cargo loaded or discharged during this port call. Links to custody transfer documentation.',
    `cargo_volume_discharged` DECIMAL(18,2) COMMENT 'Total volume of cargo discharged from the vessel during this port call, measured in barrels or cubic meters depending on product type.',
    `cargo_volume_loaded` DECIMAL(18,2) COMMENT 'Total volume of cargo loaded onto the vessel during this port call, measured in barrels or cubic meters depending on product type.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this port call record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for port disbursement amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `demurrage_incurred_hours` DECIMAL(18,2) COMMENT 'Hours of demurrage incurred when laytime used exceeds laytime allowed. Demurrage is payable by the charterer to the vessel owner.',
    `demurrage_rate_per_day` DECIMAL(18,2) COMMENT 'Daily demurrage rate specified in the charter party, payable for time used beyond allowed laytime.',
    `departure_timestamp` TIMESTAMP COMMENT 'Timestamp when the vessel departed the berth and left the port. Marks the end of the port call.',
    `despatch_earned_hours` DECIMAL(18,2) COMMENT 'Hours of despatch earned when laytime used is less than laytime allowed. Despatch is payable by the vessel owner to the charterer, typically at half the demurrage rate.',
    `estimated_time_of_arrival` TIMESTAMP COMMENT 'Estimated timestamp when the vessel is expected to arrive at the port or anchorage. Updated as voyage progresses.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this port call record was last updated in the system.',
    `laytime_allowed_hours` DECIMAL(18,2) COMMENT 'Total laytime allowed under the charter party terms for loading or discharging operations, expressed in hours.',
    `laytime_used_hours` DECIMAL(18,2) COMMENT 'Actual laytime consumed during loading or discharging operations, calculated from NOR acceptance to operations completion, excluding exceptions.',
    `notice_of_readiness_accepted_timestamp` TIMESTAMP COMMENT 'Timestamp when the charterer or terminal accepted the Notice of Readiness, marking the commencement of laytime counting.',
    `notice_of_readiness_tendered_timestamp` TIMESTAMP COMMENT 'Timestamp when the vessel master tendered Notice of Readiness to the charterer or terminal, indicating the vessel is ready to load or discharge. Critical for laytime calculation.',
    `operations_commencement_timestamp` TIMESTAMP COMMENT 'Timestamp when cargo loading or discharging operations commenced. Marks the start of productive time.',
    `operations_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when all cargo loading or discharging operations were completed and hoses/arms were disconnected.',
    `port_agent_contact_email` STRING COMMENT 'Email address of the port agent contact for documentation and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `port_agent_contact_name` STRING COMMENT 'Name of the primary contact person at the port agent company handling this port call.',
    `port_agent_contact_phone` STRING COMMENT 'Phone number of the port agent contact for coordination and emergency communication during the port call.',
    `port_call_status` STRING COMMENT 'Current lifecycle status of the port call: scheduled (planned), arrived (vessel at anchorage), berthed (vessel at berth), operations_in_progress (loading/discharging), completed (operations finished), departed (vessel left port), cancelled (port call cancelled). [ENUM-REF-CANDIDATE: scheduled|arrived|berthed|operations_in_progress|completed|departed|cancelled — 7 candidates stripped; promote to reference product]',
    `port_call_type` STRING COMMENT 'Classification of the port call purpose: load (loading cargo), discharge (unloading cargo), bunker (refueling), transit (passing through), repair (maintenance), or layup (storage).. Valid values are `load|discharge|bunker|transit|repair|layup`',
    `port_disbursement_account_actual` DECIMAL(18,2) COMMENT 'Actual total port costs and disbursements incurred for this port call, reconciled after departure based on final invoices.',
    `port_disbursement_account_estimate` DECIMAL(18,2) COMMENT 'Estimated total port costs and disbursements for this port call, including port dues, pilotage, towage, agency fees, and other charges. Provided by port agent before arrival.',
    `port_state_control_inspection_flag` BOOLEAN COMMENT 'Indicates whether the vessel was subject to a Port State Control inspection during this port call (True/False).',
    `port_state_control_inspection_result` STRING COMMENT 'Outcome of the Port State Control inspection: not_inspected, no_deficiency (clean inspection), deficiency_rectified (issues fixed before departure), deficiency_pending (issues to be addressed), detention (vessel detained).. Valid values are `not_inspected|no_deficiency|deficiency_rectified|deficiency_pending|detention`',
    `product_grade` STRING COMMENT 'Specific grade or quality specification of the product (e.g., WTI, Brent, Arab Light, ULSD, Premium Unleaded 95 RON).',
    `product_type` STRING COMMENT 'Type of petroleum product handled during the port call (e.g., crude oil, LNG, LPG, gasoline, diesel, jet fuel, NGL).',
    `reference_number` STRING COMMENT 'External business reference number or code assigned to this port call by the port authority, terminal operator, or internal logistics system.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to the port call (e.g., weather delays, equipment failures, operational issues).',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for cargo volumes: BBL (barrels), M3 (cubic meters), GAL (gallons), LTR (liters).. Valid values are `BBL|M3|GAL|LTR`',
    CONSTRAINT pk_port_call PRIMARY KEY(`port_call_id`)
) COMMENT 'Transactional record capturing a vessels call at a port or terminal for loading, discharging, bunkering, or other operations. Records port call ID, voyage ID, vessel ID, port name, terminal berth, port call type (load, discharge, bunker, transit), estimated time of arrival (ETA), actual time of arrival (ATA), notice of readiness (NOR) tendered, berthing time, operations commencement, operations completion, departure time, port agent, port disbursement account (PDA) estimate, and port state control inspection result. Supports laytime calculation and port cost management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` (
    `pipeline_throughput_id` BIGINT COMMENT 'Unique identifier for the pipeline throughput record. Primary key for this transactional entity capturing daily or monthly measured volumes on pipeline segments.',
    `commercial_counterparty_id` BIGINT COMMENT 'Identifier of the shipper or transportation customer whose volumes are being measured and reconciled. Links to commercial counterparty master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pipeline throughput operations incur costs (compression, pumping, losses) requiring cost center allocation for pipeline operations accounting and FERC reporting.',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to hse.ghg_emission. Business justification: Pipeline throughput drives GHG emissions (compressor fuel gas, fugitive methane). Links throughput to emission calculation for EPA GHGRP reporting and carbon accounting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pipeline throughput revenues post to specific GL accounts for transportation revenue recognition, FERC compliance, and financial statement preparation.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Throughput measurement at JV delivery points drives partner entitlement calculations, imbalance tracking, and JIB cost allocation. JOA reference enables working interest-based volume splits and tariff',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Pipeline throughput measurements must tie to originating leases for production allocation, royalty calculation, and reconciliation of lease production with pipeline volumes. Enables lease-level accoun',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Pipeline throughput requires operating permits from FERC/state agencies. Throughput records reference the permit authorizing transport. Compliance teams verify permit coverage for all throughput, ensu',
    `measurement_point_id` BIGINT COMMENT 'Identifier of the custody transfer measurement point where the product entered the pipeline segment. Links to the measurement point registry.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Pipeline throughput generates transportation revenue that must be tracked by profit center for midstream segment reporting and pipeline profitability analysis.',
    `api_gravity` DECIMAL(18,2) COMMENT 'The API gravity of the crude oil or liquid hydrocarbon product measured during this throughput period, used for volume correction and quality verification.',
    `co2_content_percent` DECIMAL(18,2) COMMENT 'The carbon dioxide content in natural gas expressed as a percentage by volume, affecting heating value and pipeline corrosion considerations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this throughput record was first created in the system, used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for tariff rates and revenue calculations, typically USD for US pipeline operations.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `ferc_tariff_code` STRING COMMENT 'The FERC-approved tariff code or rate schedule identifier applicable to this throughput transaction, used for regulatory compliance and billing.',
    `fuel_gas_used_volume` DECIMAL(18,2) COMMENT 'The volume of natural gas consumed as fuel to power compressor stations and other pipeline equipment during the transportation process.',
    `gas_heating_value_btu_per_scf` DECIMAL(18,2) COMMENT 'The heating value or energy content of natural gas measured in BTU per standard cubic foot, used for energy-based billing and quality specifications.',
    `gas_specific_gravity` DECIMAL(18,2) COMMENT 'The specific gravity of natural gas relative to air, used for volume correction and flow calculations in gas pipeline operations.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'The concentration of hydrogen sulfide in natural gas measured in parts per million, critical for safety and quality specifications.',
    `imbalance_status` STRING COMMENT 'The current status of the volume imbalance for this shipper and measurement period, indicating whether the shipper is in balance, has over-delivered, or under-delivered relative to their nomination.. Valid values are `balanced|over_delivered|under_delivered|pending_resolution`',
    `imbalance_volume` DECIMAL(18,2) COMMENT 'The difference between the shippers nominated volume and the actual metered volume delivered, used for imbalance management and settlement calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this throughput record was last updated or modified, used for audit trail and change tracking.',
    `line_loss_volume` DECIMAL(18,2) COMMENT 'The volume lost during transportation through the pipeline segment, calculated as the difference between receipt and delivery volumes adjusted for fuel gas and shrinkage. Negative values indicate line gain.',
    `measurement_period_type` STRING COMMENT 'The time granularity of the throughput measurement: daily for operational monitoring, monthly for regulatory reporting and billing cycles.. Valid values are `daily|monthly|weekly|hourly`',
    `metered_delivery_volume` DECIMAL(18,2) COMMENT 'The actual volume measured at the delivery or outlet measurement point of the pipeline segment, as recorded by custody transfer meters.',
    `metered_receipt_volume` DECIMAL(18,2) COMMENT 'The actual volume measured at the receipt or inlet measurement point of the pipeline segment, as recorded by custody transfer meters.',
    `metered_volume_uom` STRING COMMENT 'The unit of measure for the metered receipt and delivery volumes, standardized to volume units rather than rate units.. Valid values are `bbl|mcf|mmcf|m3|gal`',
    `nominated_volume` DECIMAL(18,2) COMMENT 'The volume that the shipper nominated or scheduled for transportation through the pipeline segment during this period, expressed in the appropriate unit of measure.',
    `nominated_volume_uom` STRING COMMENT 'The unit of measure for the nominated volume. Common units include barrels (BBL), barrels of oil per day (BOPD), thousand cubic feet (MCF), million cubic feet per day (MMCFD). [ENUM-REF-CANDIDATE: bbl|bopd|mcf|mcfd|mmcf|mmcfd|m3|gal — 8 candidates stripped; promote to reference product]',
    `observed_pressure` DECIMAL(18,2) COMMENT 'The pressure of the product at the measurement point during throughput measurement, used for volume correction to standard conditions and flow calculations.',
    `observed_temperature` DECIMAL(18,2) COMMENT 'The temperature of the product at the measurement point during throughput measurement, used for volume correction to standard conditions.',
    `operator_notes` STRING COMMENT 'Free-text field for pipeline operators to record comments, explanations for variances, operational issues, or other relevant information about this throughput measurement.',
    `phmsa_pipeline_code` STRING COMMENT 'The PHMSA-assigned identifier for the pipeline system, required for regulatory reporting and safety compliance tracking.',
    `pressure_uom` STRING COMMENT 'The unit of measure for pressure readings, such as pounds per square inch (PSI), bar, or kilopascals (kPa).. Valid values are `psi|psig|psia|bar|kpa|mpa`',
    `product_grade` STRING COMMENT 'The specific grade or quality specification of the product transported, such as WTI crude, Brent crude, or specific natural gas quality specifications.',
    `product_type` STRING COMMENT 'The category of hydrocarbon product transported through the pipeline segment during this measurement period. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|ngl|lng|lpg|refined_products|condensate — 7 candidates stripped; promote to reference product]',
    `reconciliation_status` STRING COMMENT 'The current status of the throughput reconciliation process between nominated and actual volumes, indicating whether the record is pending review, reconciled, or under dispute.. Valid values are `pending|reconciled|disputed|adjusted|approved`',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether this throughput record was automatically integrated from the SCADA pipeline monitoring system or manually entered. True indicates SCADA integration.',
    `shrinkage_volume` DECIMAL(18,2) COMMENT 'The volume reduction due to extraction of natural gas liquids (NGLs) or other processing activities during transportation, typically applicable to natural gas pipelines.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'The sulfur content of crude oil or refined products expressed as a percentage by weight, critical for quality specifications and environmental compliance.',
    `tariff_rate` DECIMAL(18,2) COMMENT 'The transportation rate charged to the shipper for moving product through this pipeline segment, expressed per unit of volume. Used for revenue calculation and shipper billing.',
    `tariff_rate_uom` STRING COMMENT 'The unit of measure for the tariff rate, typically dollars per barrel for liquids or dollars per thousand cubic feet for gas.. Valid values are `usd_per_bbl|usd_per_mcf|usd_per_mmcf|usd_per_mmbtu`',
    `temperature_uom` STRING COMMENT 'The unit of measure for temperature readings, typically Fahrenheit in US operations or Celsius in international operations.. Valid values are `fahrenheit|celsius|kelvin`',
    `throughput_date` DATE COMMENT 'The calendar date on which the throughput volumes were measured. For monthly aggregations, this represents the last day of the reporting month.',
    `throughput_reference_number` STRING COMMENT 'Business identifier for the throughput measurement record, used for external reporting and reconciliation with shippers and regulatory bodies.',
    `water_content_lbs_per_mmcf` DECIMAL(18,2) COMMENT 'The water vapor content in natural gas measured in pounds per million cubic feet, critical for preventing hydrate formation and pipeline corrosion.',
    CONSTRAINT pk_pipeline_throughput PRIMARY KEY(`pipeline_throughput_id`)
) COMMENT 'Transactional record capturing the measured daily or monthly throughput volumes on each pipeline segment, reconciling nominated versus actual volumes for each shipper. Records throughput date, pipeline segment ID, shipper ID, product type, nominated volume (BOPD or MMCFD), metered receipt volume, metered delivery volume, line loss or gain, fuel gas used, shrinkage, imbalance volume, and measurement point references. Supports FERC Form 6 reporting, shipper imbalance management, and tariff revenue calculation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` (
    `lng_cargo_id` BIGINT COMMENT 'Unique identifier for the LNG cargo shipment from liquefaction to regasification.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the LNG liquefaction plant or train where the cargo was produced.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: LNG cargo superintendent oversees loading/discharge operations, BOG management, quality control, and heel management. Technical accountability for LNG cargo operations, safety oversight, and commercia',
    `charter_party_id` BIGINT COMMENT 'Reference to the vessel charter contract governing the transportation of this LNG cargo.',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the LNG sales and purchase agreement under which this cargo is delivered.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: LNG cargoes trigger DOE export filings and customs declarations. Cargo operations link to the regulatory filing for audit trail, ensuring all LNG exports are properly reported to federal authorities a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: LNG cargo operations incur significant costs (liquefaction, shipping, regasification) requiring cost center tracking for LNG business unit accounting and operational expense management.',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to hse.ghg_emission. Business justification: LNG cargoes generate GHG emissions (boil-off gas, regasification). Links cargo to emission record for Scope 3 reporting and carbon intensity calculation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: LNG cargo revenues and costs post to specific GL accounts for revenue recognition, COGS accounting, and financial statement preparation under GAAP/IFRS.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: LNG cargo inspectors are specialized vendors providing quality certification for high-value cargoes. Real business process: vendor pre-qualification for LNG services, service contract compliance, invo',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: LNG cargoes from joint venture liquefaction facilities require JOA reference for partner entitlement allocation, cost recovery, and overlift/underlift tracking. Drives partner-level cargo value distri',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: LNG cargoes source gas feedstock from upstream leases. Tracking lease origin enables revenue allocation to working interest owners and royalty disbursement for the gas volumes liquefied and exported, ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: LNG cargoes require export/import permits and facility permits. Cargo records reference permit numbers for compliance verification. Real-world operations link each cargo to its authorizing permit, ens',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: LNG cargos are specific petroleum products requiring FK to link to lng_specification, quality requirements, pricing benchmarks, and regulatory classifications. Enables quality verification, cargo valu',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the commercial entity purchasing the LNG cargo.',
    `terminal_id` BIGINT COMMENT 'Reference to the export terminal where the LNG cargo is loaded onto the vessel.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: LNG cargoes are high-value transactions that must be tracked by profit center for LNG business segment reporting, cargo economics, and profitability analysis.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA-governed LNG projects need cargo-level PSA tracking for cost recovery vs profit gas allocation, contractor/government entitlement splits, and fiscal regime compliance. Essential for international ',
    `receiving_terminal_id` BIGINT COMMENT 'Reference to the import terminal where the LNG cargo is discharged for regasification.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: LNG cargoes must track source gas reservoir for quality certification (heating value, composition), reserves booking, and production accounting. Required for long-term sales contract compliance and SE',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: LNG cargoes generate high-value product sale invoices. Critical for LNG revenue recognition, linking cargo volumes/quality to billing, and tracking multi-million dollar receivables.',
    `spill_event_id` BIGINT COMMENT 'Foreign key linking to hse.spill_event. Business justification: LNG cargoes track boil-off gas releases and spills during loading/discharge for environmental compliance. Links cargo to spill for regulatory reporting (USCG, IMO).',
    `vessel_id` BIGINT COMMENT 'Reference to the LNG carrier vessel transporting the cargo.',
    `voyage_id` BIGINT COMMENT 'Foreign key linking to logistics.voyage. Business justification: LNG cargoes are transported via voyages. Adding voyage_id FK allows joining to get voyage details (charter party, freight terms, laytime). lng_cargo already has vessel_id (the asset); voyage_id captur',
    `actual_boil_off_gas_percent` DECIMAL(18,2) COMMENT 'Actual percentage of LNG cargo that vaporized during transportation.',
    `actual_discharge_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when LNG cargo discharge operations were completed at the receiving terminal.',
    `actual_discharge_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when LNG cargo discharge operations commenced at the receiving terminal.',
    `actual_discharged_volume_cbm` DECIMAL(18,2) COMMENT 'Actual physical volume of the LNG cargo discharged at the receiving terminal expressed in cubic meters.',
    `actual_discharged_volume_mmbtu` DECIMAL(18,2) COMMENT 'Actual energy content of the LNG cargo discharged at the receiving terminal expressed in million British thermal units.',
    `actual_loaded_volume_cbm` DECIMAL(18,2) COMMENT 'Actual physical volume of the LNG cargo loaded onto the vessel expressed in cubic meters.',
    `actual_loaded_volume_mmbtu` DECIMAL(18,2) COMMENT 'Actual energy content of the LNG cargo loaded onto the vessel expressed in million British thermal units.',
    `actual_loading_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when LNG cargo loading operations were completed at the export terminal.',
    `actual_loading_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when LNG cargo loading operations commenced at the export terminal.',
    `bill_of_lading_number` STRING COMMENT 'Legal document number issued by the carrier acknowledging receipt of the LNG cargo for shipment.',
    `boil_off_gas_estimate_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of LNG cargo that will vaporize during transportation due to heat ingress into the cargo tanks.',
    `cargo_reference_number` STRING COMMENT 'Business identifier for the LNG cargo used for tracking and documentation across the supply chain.',
    `cargo_status` STRING COMMENT 'Current lifecycle status of the LNG cargo shipment. [ENUM-REF-CANDIDATE: planned|nominated|loading|in_transit|discharging|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `cargo_value_usd` DECIMAL(18,2) COMMENT 'Total commercial value of the LNG cargo expressed in United States dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the LNG cargo record was first created in the system.',
    `demurrage_cost_usd` DECIMAL(18,2) COMMENT 'Charges incurred for delays in loading or discharge operations beyond the agreed laytime, expressed in United States dollars.',
    `ethane_content_percent` DECIMAL(18,2) COMMENT 'Percentage of ethane in the LNG cargo composition.',
    `freight_cost_usd` DECIMAL(18,2) COMMENT 'Transportation cost for shipping the LNG cargo from loading to receiving terminal, expressed in United States dollars.',
    `gross_heating_value_btu_per_scf` DECIMAL(18,2) COMMENT 'Total energy content of the LNG cargo when combusted including the latent heat of water vapor, expressed in BTU per standard cubic foot.',
    `heel_volume_cbm` DECIMAL(18,2) COMMENT 'Volume of LNG remaining in the vessel tanks prior to loading to maintain tank temperature and pressure, expressed in cubic meters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the LNG cargo record was last updated in the system.',
    `methane_content_percent` DECIMAL(18,2) COMMENT 'Percentage of methane in the LNG cargo composition, primary component determining energy content and quality.',
    `nitrogen_content_percent` DECIMAL(18,2) COMMENT 'Percentage of nitrogen in the LNG cargo composition, affects heating value and combustion characteristics.',
    `nominated_volume_cbm` DECIMAL(18,2) COMMENT 'Planned physical volume of the LNG cargo expressed in cubic meters at standard conditions.',
    `nominated_volume_mmbtu` DECIMAL(18,2) COMMENT 'Planned energy content of the LNG cargo expressed in million British thermal units.',
    `propane_content_percent` DECIMAL(18,2) COMMENT 'Percentage of propane in the LNG cargo composition.',
    `quality_certificate_number` STRING COMMENT 'Reference number of the independent inspection certificate documenting the LNG cargo quality specifications.',
    `regasification_rate_mmcfd` DECIMAL(18,2) COMMENT 'Planned rate at which the LNG cargo will be converted back to gaseous state at the receiving terminal, expressed in million cubic feet per day.',
    `scheduled_discharge_date` DATE COMMENT 'Planned date for the LNG cargo discharge operations to commence at the receiving terminal.',
    `scheduled_loading_date` DATE COMMENT 'Planned date for the LNG cargo loading operations to commence at the export terminal.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Ratio of the density of the LNG cargo to the density of air at standard conditions, used for interchangeability calculations.',
    `wobbe_index` DECIMAL(18,2) COMMENT 'Measure of the interchangeability of fuel gases such as natural gas, calculated as the heating value divided by the square root of the specific gravity.',
    CONSTRAINT pk_lng_cargo PRIMARY KEY(`lng_cargo_id`)
) COMMENT 'Master data entity representing a discrete LNG cargo from liquefaction to regasification, tracking the full LNG supply chain. Captures cargo reference, LNG train or liquefaction facility, loading terminal, receiving terminal, vessel (LNG carrier), scheduled loading date, actual loading date, cargo volume (MMBTU and CBM), boil-off gas (BOG) estimate, cargo quality (methane content, Wobbe index, GCV), heel volume, discharge terminal, regasification rate, and cargo status. Supports LNG trading, shipping, and gas quality management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`measurement_point` (
    `measurement_point_id` BIGINT COMMENT 'Unique identifier for the measurement point. Primary key for the measurement point master data entity.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the parent facility or asset where this measurement point is installed. Links to facility master data for location hierarchy and operational context.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Custody transfer and fiscal measurement require certified technician accountability for meter calibration, proving operations, and API MPMS compliance. Critical for audit trails, revenue assurance, an',
    `contract_id` BIGINT COMMENT 'Reference to the commercial contract or transportation agreement governing the use of this measurement point for custody transfer and tariff calculations.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Measurement points (LACT units, lease meters) are often installed at lease custody transfer points. Tying meters to leases enables automated production allocation, royalty calculation, and regulatory ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Measurement points require calibration permits and custody transfer approvals. Meter records reference the permit authorizing fiscal measurement. Real-world operations link each measurement point to i',
    `base_pressure_psi` DECIMAL(18,2) COMMENT 'Standard reference pressure in PSI used for volume correction calculations when converting observed volumes to standard conditions, typically 14.73 psia for natural gas.',
    `base_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Standard reference temperature in degrees Fahrenheit used for volume correction calculations when converting observed volumes to standard conditions, typically 60°F for petroleum products.',
    `calibration_certificate_number` STRING COMMENT 'Reference number of the official calibration certificate issued by the calibration authority or service provider for audit trail and compliance verification.',
    `calibration_due_date` DATE COMMENT 'Next scheduled date by which the measurement point must be calibrated or proven to maintain accuracy certification and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this measurement point record was first created in the system, used for audit trail and data lineage tracking.',
    `custody_transfer_flag` BOOLEAN COMMENT 'Indicates whether this measurement point is used for custody transfer (change of ownership) requiring higher accuracy standards and independent verification per API MPMS standards.',
    `decommission_date` DATE COMMENT 'Date when the measurement point was permanently taken out of service and decommissioned, used for asset lifecycle tracking and historical analysis.',
    `ferc_reporting_flag` BOOLEAN COMMENT 'Indicates whether this measurement point is subject to FERC tariff reporting requirements for interstate natural gas or oil pipeline transportation.',
    `fiscal_measurement_flag` BOOLEAN COMMENT 'Indicates whether this measurement point is used for fiscal (revenue) purposes requiring enhanced accuracy, audit trails, and regulatory compliance for royalty and tax calculations.',
    `flow_direction` STRING COMMENT 'Directional flow capability of the measurement point: forward (single direction), reverse (opposite direction), or bidirectional (both directions).. Valid values are `forward|reverse|bidirectional`',
    `flow_rate_unit_of_measure` STRING COMMENT 'Unit of measure for flow rate specifications: barrels per day (BOPD), barrels per hour, thousand cubic feet per day (MCFD), cubic meters per hour, or gallons per minute.. Valid values are `bbl_per_day|bbl_per_hour|mcf_per_day|m3_per_hour|gal_per_min`',
    `installation_date` DATE COMMENT 'Date when the measurement point was originally installed and commissioned for operational use.',
    `last_calibration_date` DATE COMMENT 'Date when the most recent calibration or proving was performed on the measurement point, establishing the baseline for accuracy certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this measurement point record was most recently updated, used for change tracking and audit compliance.',
    `location_type` STRING COMMENT 'Type of facility or infrastructure where the measurement point is physically installed: terminal, pipeline, wellhead, FPSO (Floating Production Storage and Offloading), refinery, or processing plant.. Valid values are `terminal|pipeline|wellhead|fpso|refinery|processing_plant`',
    `maximum_flow_rate` DECIMAL(18,2) COMMENT 'Maximum rated flow rate capacity of the meter before accuracy degradation or equipment damage, used for operational limits and safety management.',
    `measurement_point_code` STRING COMMENT 'Externally-known unique business identifier or code assigned to the measurement point for custody transfer documentation and regulatory reporting.',
    `measurement_point_name` STRING COMMENT 'Human-readable name or designation of the measurement point for operational identification and reporting purposes.',
    `meter_factor` DECIMAL(18,2) COMMENT 'Calibration correction factor (K-factor) applied to raw meter readings to calculate accurate volume, derived from proving runs and used in custody transfer calculations.',
    `meter_manufacturer` STRING COMMENT 'Name of the company that manufactured the metering device, used for warranty management, spare parts procurement, and technical support.',
    `meter_model_number` STRING COMMENT 'Manufacturer model or part number of the metering device for technical specifications reference and maintenance procedures.',
    `meter_serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the physical metering device for asset tracking, maintenance scheduling, and calibration history.',
    `meter_size_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the meter in inches, indicating the flow capacity and pipeline connection size.',
    `meter_type` STRING COMMENT 'Technology type of the metering device installed at this measurement point: turbine, ultrasonic, Coriolis, orifice, positive displacement, or vortex meter.. Valid values are `turbine|ultrasonic|coriolis|orifice|positive_displacement|vortex`',
    `minimum_flow_rate` DECIMAL(18,2) COMMENT 'Minimum measurable flow rate for the meter to maintain accuracy within specified uncertainty limits, used for operational planning and custody transfer validation.',
    `operational_status` STRING COMMENT 'Current operational state of the measurement point: active (in service), inactive (temporarily offline), maintenance (under repair/calibration), out of service (not operational), or decommissioned (permanently retired).. Valid values are `active|inactive|maintenance|out_of_service|decommissioned`',
    `phmsa_meter_code` STRING COMMENT 'Unique identifier assigned by PHMSA for pipeline meters subject to federal safety regulations and reporting requirements under 49 CFR Part 195.',
    `point_type` STRING COMMENT 'Classification of the measurement point based on its operational purpose: fiscal meter (revenue measurement), allocation meter (production allocation), check meter (verification), tank gauge (inventory), wellhead meter (well production), or custody transfer meter (ownership transfer).. Valid values are `fiscal_meter|allocation_meter|check_meter|tank_gauge|wellhead_meter|custody_transfer_meter`',
    `pressure_compensation_flag` BOOLEAN COMMENT 'Indicates whether the measurement point applies pressure compensation to convert observed volumes to standard conditions for custody transfer calculations.',
    `product_type` STRING COMMENT 'Type of petroleum product being measured at this point: crude oil, natural gas, LNG (Liquefied Natural Gas), LPG (Liquefied Petroleum Gas), NGL (Natural Gas Liquids), refined products, or condensate. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|lng|lpg|ngl|refined_products|condensate — 7 candidates stripped; promote to reference product]',
    `proving_method` STRING COMMENT 'Method used to calibrate and prove the accuracy of the meter: pipe prover, tank prover, master meter comparison, or volumetric prover, as defined by API MPMS Chapter 4.. Valid values are `pipe_prover|tank_prover|master_meter|volumetric_prover`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, operational considerations, or historical context related to the measurement point.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether this measurement point is integrated with SCADA systems for real-time monitoring, data acquisition, and operational control.',
    `scada_tag_code` STRING COMMENT 'Unique tag identifier in the SCADA or PI System historian used to retrieve real-time and historical measurement data for this point.',
    `temperature_compensation_flag` BOOLEAN COMMENT 'Indicates whether the measurement point applies temperature compensation to convert observed volumes to standard conditions for custody transfer calculations.',
    `uncertainty_percentage` DECIMAL(18,2) COMMENT 'Statistical uncertainty or tolerance of the measurement point expressed as a percentage, representing the accuracy range for volume measurements used in custody transfer calculations.',
    CONSTRAINT pk_measurement_point PRIMARY KEY(`measurement_point_id`)
) COMMENT 'Master data entity representing a physical or fiscal measurement location where petroleum product volumes and qualities are measured for custody transfer, allocation, or regulatory reporting. Captures measurement point ID, point name, point type (fiscal meter, allocation meter, check meter, tank gauge), location (terminal, pipeline, wellhead, FPSO), product type, meter type (turbine, ultrasonic, Coriolis, orifice), meter serial number, calibration due date, last calibration date, uncertainty percentage, PHMSA meter ID, and operational status. Serves as the SSOT for measurement infrastructure.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` (
    `rail_waybill_id` BIGINT COMMENT 'Unique identifier for the rail waybill record. Primary key for the rail waybill transactional document.',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the master transportation contract or service agreement governing this rail shipment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rail freight costs must be allocated to cost centers for transportation expense tracking, budget management, and rail logistics operations accounting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Rail freight expenses post to specific GL accounts for transportation cost accounting, financial statement preparation, and expense recognition.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Rail shipments of crude oil from production areas reference originating lease for royalty calculation and revenue allocation. Similar to truck tickets, enables proper distribution of sales proceeds to',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Rail shipments of hazardous materials require transport permits. Waybills reference permit numbers for compliance verification. Real-world operations link each waybill to the authorizing permit, ensur',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Rail waybills document shipment of specific petroleum products; FK required for hazmat classification (UN number, hazard class), tariff rate determination, quality specification enforcement, and emerg',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the party shipping the petroleum product. The consignor or originating party in the rail transportation contract.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Rail shipments impact profit center economics through freight costs and product movements, required for segment reporting and profitability analysis.',
    `tariff_rate_id` BIGINT COMMENT 'Reference to the applicable tariff rate used to calculate freight charges for this rail movement.',
    `waste_manifest_id` BIGINT COMMENT 'Foreign key linking to hse.waste_manifest. Business justification: Rail waybills for hazardous waste reference manifest for DOT compliance. Links waybill to waste tracking document for regulatory compliance and chain of custody.',
    `actual_arrival_date` DATE COMMENT 'The actual date the rail cars arrived at the destination station.',
    `actual_departure_date` DATE COMMENT 'The actual date the rail cars departed from the origin station.',
    `api_gravity` DECIMAL(18,2) COMMENT 'The API gravity measurement of crude oil or refined product. Indicates the density and quality of the petroleum product.',
    `bill_of_lading_number` STRING COMMENT 'The bill of lading document number associated with this rail shipment. Links the waybill to the custody transfer documentation.',
    `car_initial` STRING COMMENT 'The alphabetic reporting mark or initial identifying the owner or lessor of the rail car. Typically two to four letters assigned by the Association of American Railroads.. Valid values are `^[A-Z]{2,4}$`',
    `car_number` STRING COMMENT 'The numeric identifier assigned to the specific rail car. Combined with car initial forms the unique rail car identification.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rail waybill record was first created in the system. Audit trail for record creation.',
    `destination_station_code` STRING COMMENT 'Railroad station code or facility identifier where the shipment is destined. Identifies the unloading point for the rail cars.',
    `destination_station_name` STRING COMMENT 'Full name of the destination railroad station or unloading facility.',
    `emergency_response_contact_name` STRING COMMENT 'Name of the person or organization to contact in case of emergency during rail transportation.',
    `emergency_response_contact_phone` STRING COMMENT '24-hour emergency contact phone number for hazmat incidents during rail transportation. Required for DOT/PHMSA compliance.',
    `freight_charges` DECIMAL(18,2) COMMENT 'The total freight transportation charges for this rail shipment. Denominated in the currency specified in freight_currency_code.',
    `freight_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for freight charges (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `gross_weight` DECIMAL(18,2) COMMENT 'The total weight of the shipment including product, rail car, and any packaging. Measured in the unit specified in weight_unit_of_measure.',
    `hazmat_class` STRING COMMENT 'The DOT hazard class designation for the material (e.g., Class 3 Flammable Liquids, Class 2 Gases). Determines placarding and handling requirements.',
    `hazmat_placard_required` BOOLEAN COMMENT 'Indicates whether hazmat placards are required on the rail cars for this shipment per DOT/PHMSA regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this rail waybill record was last updated in the system. Audit trail for record changes.',
    `net_weight` DECIMAL(18,2) COMMENT 'The weight of the product only, excluding the rail car and packaging. Measured in the unit specified in weight_unit_of_measure.',
    `number_of_cars` STRING COMMENT 'Total count of rail cars included in this waybill shipment.',
    `origin_station_code` STRING COMMENT 'Railroad station code or facility identifier where the shipment originates. Identifies the loading point for the rail cars.',
    `origin_station_name` STRING COMMENT 'Full name of the origin railroad station or loading facility.',
    `railroad_scac_code` STRING COMMENT 'The Standard Carrier Alpha Code identifying the railroad carrier responsible for transportation. Two to four letter code assigned by the National Motor Freight Traffic Association.. Valid values are `^[A-Z]{2,4}$`',
    `remarks` STRING COMMENT 'Free-form text field for additional notes, special instructions, or comments related to the rail waybill and shipment.',
    `scheduled_arrival_date` DATE COMMENT 'The planned date for the rail cars to arrive at the destination station.',
    `scheduled_departure_date` DATE COMMENT 'The planned date for the rail cars to depart from the origin station.',
    `seal_numbers` STRING COMMENT 'Comma-separated list of security seal numbers applied to the rail cars to ensure product integrity during transit.',
    `seal_verification_status` STRING COMMENT 'Status of seal integrity verification upon arrival at destination. Indicates whether seals were intact or compromised.. Valid values are `verified|broken|missing|not_applicable`',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'The sulfur content of the product expressed as a percentage by weight. Critical quality parameter for crude oil and refined products.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'The observed temperature of the product at loading, measured in degrees Fahrenheit. Critical for volume correction calculations.',
    `total_volume` DECIMAL(18,2) COMMENT 'The total volume of product being shipped across all rail cars on this waybill. Measured in the unit specified in volume_unit_of_measure.',
    `un_hazmat_number` STRING COMMENT 'The four-digit UN identification number for the hazardous material being transported. Required for DOT/PHMSA hazmat compliance and emergency response.. Valid values are `^UN[0-9]{4}$`',
    `volume_unit_of_measure` STRING COMMENT 'The unit of measure for the volume quantity. Common units include BBL (barrels), GAL (gallons), L (liters), M3 (cubic meters).. Valid values are `BBL|GAL|L|M3`',
    `waybill_date` DATE COMMENT 'The date the waybill was issued or created. Represents the principal business event timestamp for this transportation contract.',
    `waybill_number` STRING COMMENT 'The externally-known unique waybill document number assigned by the railroad or shipper. Serves as the business identifier for the contract of carriage.',
    `waybill_status` STRING COMMENT 'Current lifecycle status of the rail waybill document in the transportation workflow.. Valid values are `draft|submitted|in_transit|delivered|cancelled|disputed`',
    `weight_unit_of_measure` STRING COMMENT 'The unit of measure for weight quantities. Common units include LBS (pounds), KG (kilograms), MT (metric tons), TON (short tons).. Valid values are `LBS|KG|MT|TON`',
    CONSTRAINT pk_rail_waybill PRIMARY KEY(`rail_waybill_id`)
) COMMENT 'Transactional document governing the movement of petroleum products by rail, serving as the contract of carriage between shipper and railroad. Captures waybill number, waybill date, railroad SCAC code, shipper, consignee, origin station, destination station, car initial and number, product type (crude oil, LPG, ethanol), UN hazmat number, number of cars, total volume (BBL or gallons), gross weight, net weight, freight charges, hazmat placard requirements, and waybill status. Supports DOT/PHMSA rail safety compliance and freight cost tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` (
    `cargo_inspection_id` BIGINT COMMENT 'Unique identifier for the cargo inspection record. Primary key for the cargo inspection entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection costs must be charged to cost centers for quality assurance expense tracking, cargo operations accounting, and operational cost management.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Cargo inspections are performed for customer acceptance, quality verification, and dispute resolution. Essential for customer complaint management, quality claim processing, and customer satisfaction ',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_monitoring. Business justification: Cargo inspections may trigger environmental monitoring (air quality, water sampling) for compliance verification. Links inspection to monitoring for regulatory compliance and quality assurance.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Inspection fees post to specific GL accounts (inspection expense, quality assurance) for cost accounting, financial statement preparation, and expense recognition.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Inspection coordinator manages independent inspector appointments, quality certificate review, and quantity/quality dispute resolution. Operational accountability for cargo quality assurance and custo',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Cargo inspections for JV shipments require JOA reference for quality dispute resolution, partner acceptance validation, and inspection cost allocation. Drives partner-level quality claim management an',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Cargo inspections verify quality of specific petroleum products; FK essential to link inspection results to product quality specifications, enable quality_test_result association, certificate_of_quali',
    `port_call_id` BIGINT COMMENT 'Foreign key linking to logistics.port_call. Business justification: Cargo inspections happen at specific port calls. Adding port_call_id FK allows joining to get port call details (terminal, berth, timestamps). Removes denormalized port_name and port_country_code.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Inspection costs impact cargo profitability and must be tracked by profit center for crude marketing performance and voyage economics analysis.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Quality inspections validate product specifications in sales contracts; inspection certificates are contractual delivery requirements. Links inspection results to sales order quality specifications fo',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment record associated with this cargo inspection. Links the inspection to the broader logistics movement.',
    `vendor_id` BIGINT COMMENT 'Reference to the independent third-party inspection company that performed the cargo inspection. Typically an internationally recognized surveyor.',
    `voyage_id` BIGINT COMMENT 'Foreign key linking to logistics.voyage. Business justification: Cargo inspections occur during voyages (at load or discharge ports). Adding voyage_id FK allows joining to get voyage and vessel details. Removes denormalized vessel_name and vessel_imo_number (availa',
    `api_gravity` DECIMAL(18,2) COMMENT 'The API gravity measurement of the petroleum product, indicating its density relative to water. Higher API gravity indicates lighter, more valuable crude oil. Measured in degrees API at 60°F.',
    `bsw_percentage` DECIMAL(18,2) COMMENT 'The percentage by volume of basic sediment and water content in the petroleum product. Critical for determining net volume and product quality. Expressed as a percentage.',
    `cargo_reference_number` STRING COMMENT 'Business reference number identifying the specific cargo parcel being inspected. May correspond to a bill of lading, cargo nomination, or lifting schedule reference.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this cargo inspection record was first created in the data platform, supporting audit trail and data lineage requirements.',
    `density_at_15c` DECIMAL(18,2) COMMENT 'The density of the petroleum product at the standard reference temperature of 15°C, expressed in kilograms per cubic meter (kg/m³) or grams per milliliter (g/mL).',
    `draft_survey_result` STRING COMMENT 'The outcome of the draft survey inspection method, which calculates cargo quantity based on vessel displacement measurements before and after loading/discharge.. Valid values are `pass|fail|inconclusive|not_performed`',
    `gross_observed_volume` DECIMAL(18,2) COMMENT 'The total volume of liquid measured in the tank or vessel at observed temperature and pressure conditions, including all water and sediment. Measured in barrels or cubic meters.',
    `gross_standard_volume` DECIMAL(18,2) COMMENT 'The total volume of liquid corrected to standard temperature (60°F or 15°C) and pressure conditions, including all water and sediment. Used for custody transfer calculations.',
    `inspection_certificate_number` STRING COMMENT 'The unique certificate or report number issued by the inspection company documenting the inspection findings. Used for legal and custody transfer documentation.',
    `inspection_date` DATE COMMENT 'The calendar date on which the cargo inspection was performed at the load or discharge port.',
    `inspection_location_type` STRING COMMENT 'The type of location where the inspection was performed: load port, discharge port, FPSO (Floating Production Storage and Offloading), pipeline custody transfer point, or storage terminal.. Valid values are `load_port|discharge_port|fpso|pipeline_custody_transfer_point|storage_terminal|vessel_at_sea`',
    `inspection_purpose` STRING COMMENT 'The business reason for conducting the inspection: custody transfer validation, quality claim investigation, regulatory compliance, insurance documentation, or routine monitoring.. Valid values are `custody_transfer|quality_verification|regulatory_compliance|dispute_resolution|insurance_claim|routine_monitoring`',
    `inspection_reference_number` STRING COMMENT 'External reference number assigned by the inspection company or port authority to uniquely identify this inspection event. Used for cross-referencing with inspection certificates and custody transfer documentation.',
    `inspection_remarks` STRING COMMENT 'Free-text field capturing additional observations, exceptions, weather conditions, operational constraints, or other contextual information noted by the inspector during the cargo inspection.',
    `inspection_status` STRING COMMENT 'The current lifecycle status of the cargo inspection: scheduled (planned but not started), in progress (inspection underway), completed (inspection finished and certified), cancelled (inspection not performed), or disputed (findings contested).. Valid values are `scheduled|in_progress|completed|cancelled|disputed`',
    `inspection_timestamp` TIMESTAMP COMMENT 'The precise date and time when the cargo inspection was completed, including time zone information. Represents the principal business event timestamp for this transaction.',
    `inspection_type` STRING COMMENT 'The category of inspection performed: quantity (volume measurement), quality (product specification verification), draft survey (vessel displacement measurement), ullage survey (tank measurement), or combined inspections. [ENUM-REF-CANDIDATE: quantity|quality|draft_survey|ullage_survey|combined_quantity_quality|pre_loading|post_discharge|in_transit — 8 candidates stripped; promote to reference product]',
    `inspector_certification_number` STRING COMMENT 'The professional certification or license number of the inspector, validating their qualifications to perform petroleum cargo inspections.',
    `inspector_name` STRING COMMENT 'The full name of the certified inspector who performed the cargo inspection on behalf of the inspection company.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when this cargo inspection record was most recently updated, supporting audit trail and change tracking requirements.',
    `net_standard_volume` DECIMAL(18,2) COMMENT 'The volume of petroleum product corrected to standard conditions and excluding water and sediment content. Represents the commercially transferable quantity for custody transfer and billing purposes.',
    `observed_pressure` DECIMAL(18,2) COMMENT 'The pressure of the petroleum product at the time of measurement, particularly relevant for LNG, LPG, and NGL inspections where pressure significantly affects volume.',
    `observed_temperature` DECIMAL(18,2) COMMENT 'The temperature of the petroleum product at the time of measurement, used for volume correction calculations to standard conditions.',
    `pressure_unit_of_measure` STRING COMMENT 'The unit of measurement for pressure: PSI (pounds per square inch), BAR (bar), KPA (kilopascals), or MPA (megapascals).. Valid values are `PSI|BAR|KPA|MPA`',
    `quality_claim_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether a quality claim or dispute has been raised based on the inspection findings, triggering commercial or legal resolution processes.',
    `quantity_variance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether a significant quantity variance was detected between nominated volume and inspected volume, potentially triggering custody transfer adjustments.',
    `seal_numbers` STRING COMMENT 'Comma-separated list of security seal identification numbers applied to vessel hatches, tank valves, or pipeline connections to ensure cargo integrity and prevent tampering during transport.',
    `seal_verification_status` STRING COMMENT 'The condition of security seals at the time of inspection: intact (seals unbroken), broken (seals compromised), missing (seals not present), or not applicable (no seals required).. Valid values are `intact|broken|missing|not_applicable`',
    `sulfur_content_percentage` DECIMAL(18,2) COMMENT 'The sulfur content of the petroleum product expressed as a weight percentage. Critical quality parameter affecting product value and environmental compliance. Sweet crude has <0.5% sulfur; sour crude has >0.5%.',
    `temperature_unit_of_measure` STRING COMMENT 'The unit of measurement for temperature: F (Fahrenheit), C (Celsius), or K (Kelvin).. Valid values are `F|C|K`',
    `ullage_measurement` DECIMAL(18,2) COMMENT 'The distance from the top of the tank or vessel to the surface of the liquid, measured in feet, meters, or inches. Used to calculate cargo volume in conjunction with tank calibration tables.',
    `variance_tolerance_percentage` DECIMAL(18,2) COMMENT 'The acceptable percentage variance between nominated and measured quantities as defined in the commercial contract or industry standard, beyond which a quantity variance flag is raised.',
    `volume_unit_of_measure` STRING COMMENT 'The unit of measurement for volume quantities: BBL (barrels), M3 (cubic meters), GAL (gallons), or L (liters).. Valid values are `BBL|M3|GAL|L`',
    CONSTRAINT pk_cargo_inspection PRIMARY KEY(`cargo_inspection_id`)
) COMMENT 'Transactional record of an independent inspection performed on a petroleum cargo at load or discharge port to verify quantity and quality. Captures inspection reference, inspection date, cargo or shipment reference, inspection company, inspector name, inspection type (quantity, quality, draft survey, ullage survey), port (load or discharge), gross observed volume (GOV), gross standard volume (GSV), net standard volume (NSV), API gravity, BS&W, sulfur content, temperature, pressure, seal verification, and inspection certificate number. Supports custody transfer disputes and quality claims.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` (
    `terminal_access_agreement_id` BIGINT COMMENT 'Unique identifier for the terminal access agreement record. Primary key for the association.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to the customer counterparty receiving terminal access rights',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to the terminal providing storage and throughput services',
    `access_rights_type` STRING COMMENT 'Classification of the access rights granted to the customer: dedicated (exclusive capacity), shared (pro-rata with other customers), interruptible (subject to curtailment), firm (guaranteed), or non-firm (best-effort basis). Determines priority during capacity constraints.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the terminal access agreement. Active agreements are in force; suspended agreements are temporarily inactive; expired agreements have passed their effective_until date; terminated agreements were cancelled before expiration.',
    `allocated_capacity_bbl` DECIMAL(18,2) COMMENT 'Storage capacity in barrels (BBL) allocated to this customer under the terminal service agreement. Represents the customers reserved or contracted capacity at this specific terminal.',
    `contract_reference_number` STRING COMMENT 'External reference number of the master terminal service agreement or contract document that governs this access arrangement. Links operational data to legal contract documentation.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this terminal access agreement record was created in the system.',
    `effective_from` DATE COMMENT 'Start date from which the terminal access agreement becomes active and the customer can exercise their access rights and allocated capacity.',
    `effective_until` DATE COMMENT 'End date of the terminal access agreement. After this date, the customers access rights, allocated capacity, and priority level expire unless renewed.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this terminal access agreement record.',
    `minimum_throughput_commitment_bopd` DECIMAL(18,2) COMMENT 'Minimum daily throughput volume in barrels of oil per day (BOPD) that the customer has committed to move through the terminal. Used for take-or-pay provisions and capacity reservation enforcement.',
    `nomination_rights` STRING COMMENT 'Defines the customers rights to nominate volumes for loading or discharge at the terminal. Full rights allow unrestricted nominations up to allocated capacity; restricted rights require operator approval; none indicates capacity is operator-scheduled.',
    `priority_level` STRING COMMENT 'Customers priority ranking for terminal access and scheduling during capacity constraints or operational disruptions. Priority_1 customers receive preferential treatment for loading/discharge scheduling and capacity allocation.',
    `tariff_rate_override` DECIMAL(18,2) COMMENT 'Customer-specific tariff rate per barrel for storage and throughput services, overriding the standard published terminal tariff. Reflects negotiated commercial terms based on volume commitments or strategic relationship.',
    CONSTRAINT pk_terminal_access_agreement PRIMARY KEY(`terminal_access_agreement_id`)
) COMMENT 'This association product represents the contractual agreement between a terminal and a customer counterparty for storage and throughput services. It captures customer-specific capacity allocations, access rights, priority levels, tariff rate overrides, and nomination rights under terminal service agreements. Each record links one terminal to one customer counterparty with attributes that exist only in the context of this commercial relationship.. Existence Justification: In oil and gas terminal operations, a single terminal serves multiple customer counterparties (IOCs, NOCs, traders, refiners) with contractually allocated storage capacity and throughput rights. Simultaneously, each customer counterparty typically has access agreements with multiple terminals across different geographic locations to support their supply chain network. These are formal commercial arrangements with customer-specific terms including allocated capacity, priority levels, tariff overrides, and nomination rights that cannot be stored on either the terminal or customer entity alone.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` (
    `carrier_product_authorization_id` BIGINT COMMENT 'Unique identifier for the carrier-product authorization record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier master record',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the user who approved this carrier-product authorization. Provides audit trail for approval decisions.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to the petroleum product master record',
    `approval_date` DATE COMMENT 'The date on which the carrier was approved to transport this specific petroleum product. Marks the beginning of the authorization period.',
    `approval_status` STRING COMMENT 'Current status of the carriers authorization to transport this specific petroleum product. Tracks the lifecycle of the approval from pending through active to revoked/expired states.',
    `approved_product_types` STRING COMMENT 'Comma-separated list of petroleum product types that the carrier is approved and qualified to transport, such as crude oil, LNG, LPG, NGL, refined products, and petrochemicals. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|lng|lpg|ngl|gasoline|diesel|jet_fuel|fuel_oil|petrochemicals|condensate — promote to reference product] [Moved from carrier: This comma-separated list attribute in carrier is a denormalized representation of the many-to-many relationship. The proper model is to have individual authorization records for each carrier-product combination rather than a text list. This enables proper tracking of product-specific approval dates, certifications, and performance metrics.]',
    `expiration_date` DATE COMMENT 'The date on which the carriers authorization to transport this specific petroleum product expires and requires renewal or re-certification.',
    `handling_rate_capability` DECIMAL(18,2) COMMENT 'The maximum volume or throughput rate (in barrels per day or metric tons per day) that the carrier is capable of handling for this specific petroleum product. Reflects equipment capacity, loading/unloading capabilities, and operational constraints specific to the product type.',
    `hazmat_certification_level` STRING COMMENT 'The specific level of hazardous materials certification required and held by the carrier for transporting this particular petroleum product. Different products may require different certification levels based on hazard class and handling complexity.',
    `insurance_coverage_limit` DECIMAL(18,2) COMMENT 'The minimum insurance coverage amount required for the carrier to transport this specific petroleum product. High-value or high-risk products may require higher coverage limits than the carriers general insurance.',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent performance review for this carrier-product combination. Used to track periodic assessments of carrier performance for specific product types.',
    `notes` STRING COMMENT 'Free-text notes capturing special conditions, restrictions, or requirements specific to this carrier-product authorization (e.g., Approved for coastal routes only, Requires escort for quantities >10,000 bbl).',
    `performance_rating` DECIMAL(18,2) COMMENT 'Performance rating score (0.00 to 5.00) for this carriers handling of this specific petroleum product. Tracks product-specific performance metrics such as on-time delivery, product quality maintenance, safety incidents, and compliance.',
    CONSTRAINT pk_carrier_product_authorization PRIMARY KEY(`carrier_product_authorization_id`)
) COMMENT 'This association product represents the Authorization/Approval between carrier and petroleum_product. It captures the carriers qualification and approval to transport specific petroleum products with product-specific certifications, insurance coverage, handling capabilities, and performance tracking. Each record links one carrier to one petroleum_product with attributes that exist only in the context of this authorization relationship.. Existence Justification: In oil and gas logistics operations, carriers must be individually qualified and approved to transport specific petroleum products due to varying hazmat certifications, insurance requirements, and handling capabilities. A carrier (pipeline, marine, truck, rail) can be authorized to transport multiple petroleum products (crude grades, refined fuels, petrochemicals), and each petroleum product can be transported by multiple carriers. The business actively manages these authorizations with product-specific approval dates, certification levels, insurance limits, and performance ratings.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` (
    `carrier_product_approval_id` BIGINT COMMENT 'Unique surrogate identifier for each carrier-product approval record',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the transportation carrier that has been approved and certified to handle the specific petrochemical product',
    `employee_id` BIGINT COMMENT 'Identifier of the user or approver who authorized this carrier to transport this specific petrochemical product',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to the petrochemical product that requires specific handling certification and carrier approval',
    `approval_expiry_date` DATE COMMENT 'The date on which the carriers approval to transport this specific petrochemical product expires and requires renewal',
    `approval_status` STRING COMMENT 'Current status of the carriers approval to handle this specific petrochemical product. Indicates whether the carrier is currently authorized to transport the product.',
    `approved_date` DATE COMMENT 'The date on which the carrier was approved to transport this specific petrochemical product, following successful completion of vetting and certification requirements',
    `certification_authority` STRING COMMENT 'The regulatory body or certification organization that issued the product handling certification for this carrier-product combination (e.g., DOT, PHMSA, Coast Guard, industry body)',
    `hazmat_endorsement_number` STRING COMMENT 'The unique hazardous materials endorsement or permit number specific to this carrier-product combination, issued by the relevant regulatory authority (DOT, PHMSA, etc.)',
    `incident_count` BIGINT COMMENT 'Total number of safety incidents, spills, or compliance violations recorded for this carrier when transporting this specific petrochemical product',
    `last_audit_date` DATE COMMENT 'The date of the most recent safety and compliance audit conducted for this carriers handling of this specific petrochemical product',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next required audit of the carriers handling procedures and compliance for this specific petrochemical product',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, conditions, or restrictions related to this carrier-product approval',
    `performance_rating` STRING COMMENT 'Performance evaluation rating for this carriers handling of this specific petrochemical product, based on safety record, on-time delivery, incident history, and compliance metrics',
    `product_handling_certification` STRING COMMENT 'The specific certification or qualification credential that authorizes the carrier to handle this petrochemical product, including certification body and credential number',
    `special_handling_requirements` STRING COMMENT 'Any additional handling, equipment, or procedural requirements specific to this carriers transportation of this petrochemical product (e.g., temperature control, inert gas blanketing, dedicated equipment)',
    CONSTRAINT pk_carrier_product_approval PRIMARY KEY(`carrier_product_approval_id`)
) COMMENT 'This association product represents the approval and certification relationship between petrochemical products and transportation carriers. It captures the regulatory approval, handling certification, and performance management for each carrier-product combination. Each record links one petrochemical product to one carrier with attributes that exist only in the context of this specific approval relationship, including certification dates, hazmat endorsements, audit history, and performance ratings.. Existence Justification: In oil and gas petrochemical operations, carriers must obtain specific approvals and certifications to transport each type of petrochemical product due to varying hazmat classifications, handling requirements, and regulatory constraints. A single carrier (pipeline operator, marine shipper, trucking company) is certified to handle multiple petrochemical products (ethylene, propylene, benzene, polymers), and each petrochemical product requires multiple approved carriers to ensure supply chain resilience and competitive routing. The business actively manages these approvals as Carrier Product Approvals with certification tracking, audit schedules, and performance ratings per carrier-product combination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` (
    `vessel_cargo_compatibility_id` BIGINT COMMENT 'Unique system identifier for the vessel-product compatibility record. Primary key for the association.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to the petroleum product master catalog',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to the vessel master data entity',
    `approval_authority` STRING COMMENT 'Organization or individual who granted the compatibility approval (e.g., Fleet Manager, Marine Superintendent, Oil Major Vetting Inspector, Classification Society).',
    `cargo_compatibility_rating` STRING COMMENT 'Operational approval status for carrying this specific petroleum product on this vessel. APPROVED indicates full clearance, RESTRICTED indicates conditional approval with limitations, PROHIBITED indicates vessel cannot carry this product, PENDING_REVIEW indicates vetting in progress.',
    `contamination_risk_level` STRING COMMENT 'Assessment of contamination risk for this product on this vessel based on previous cargo history, tank cleaning effectiveness, and product sensitivity. HIGH or CRITICAL may require additional cleaning or prohibit loading.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this compatibility record was created in the system.',
    `heating_capability_required` BOOLEAN COMMENT 'Indicates whether cargo heating is required for this product on this vessel based on product viscosity, pour point, and vessel heating system capabilities. Used for voyage planning and operational feasibility assessment.',
    `last_cargo_carried_date` DATE COMMENT 'Most recent date this vessel carried this specific petroleum product. Used for contamination risk assessment, previous cargo history analysis, and tank cleaning requirement determination.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this compatibility record was last modified.',
    `max_cargo_quantity_bbl` DECIMAL(18,2) COMMENT 'Maximum quantity of this specific product that can be loaded on this vessel in barrels, considering product density, vessel stability limits, and regulatory constraints. May differ from vessels total cargo capacity.',
    `notes` STRING COMMENT 'Additional operational notes, restrictions, or historical information relevant to this vessel-product compatibility relationship.',
    `segregation_capability` STRING COMMENT 'Vessels ability to segregate this product from other cargoes. FULL_SEGREGATION indicates dedicated tanks with independent systems, PARTIAL_SEGREGATION indicates shared systems with cleaning protocols, NO_SEGREGATION indicates single-product-only capability.',
    `special_handling_requirements` STRING COMMENT 'Free-text field capturing product-specific operational requirements for this vessel (e.g., nitrogen blanketing required, temperature range 40-60C, shore tank cleaning mandatory, COW required before discharge).',
    `tank_coating_compatibility` STRING COMMENT 'Assessment of whether the vessels tank coating material is suitable for this petroleum product. COMPATIBLE indicates coating approved for product, MARGINAL indicates limited exposure acceptable, INCOMPATIBLE indicates coating degradation risk.',
    `vetting_approval_date` DATE COMMENT 'Date of most recent product-specific vetting approval. Used to track approval currency and trigger re-vetting requirements.',
    `vetting_approval_status` STRING COMMENT 'Product-specific vetting approval status from SIRE/CDI inspections or oil major vetting programs. Some products require additional vetting beyond general vessel approval (e.g., LNG, chemicals, high-value clean products).',
    `vetting_expiry_date` DATE COMMENT 'Expiration date of product-specific vetting approval. After this date, vessel requires re-inspection before carrying this product.',
    CONSTRAINT pk_vessel_cargo_compatibility PRIMARY KEY(`vessel_cargo_compatibility_id`)
) COMMENT 'This association product represents the operational approval and compatibility relationship between vessels and petroleum products. It captures vessel-product compatibility ratings, segregation capabilities, tank coating suitability, heating requirements, and vetting approval status. Each record links one vessel to one petroleum product with attributes that exist only in the context of this compatibility relationship. This is actively managed by marine operations and vetting teams to ensure safe cargo operations and regulatory compliance.. Existence Justification: In oil and gas marine operations, vessels are approved to carry multiple petroleum product types (crude grades, refined products, LNG, LPG, chemicals), and each product can be transported by multiple vessels. The business actively manages vessel-product compatibility through vetting programs, tank coating assessments, segregation capability reviews, and previous cargo history tracking. This is not a theoretical relationship but an operational necessity managed by marine operations, chartering, and vetting teams who maintain compatibility matrices to ensure safe cargo operations and regulatory compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` (
    `carrier_contract_engagement_id` BIGINT COMMENT 'Unique identifier for this carrier-contract engagement record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the transportation carrier providing services under this contract engagement',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to the term contract under which this carrier is engaged',
    `approved_product_types` STRING COMMENT 'Comma-separated list of petroleum product types this carrier is approved to transport under this specific contract engagement. May be a subset of the carriers overall approved products.',
    `approved_routes` STRING COMMENT 'Comma-separated list or text description of specific routes, origin-destination pairs, or geographic regions this carrier is approved to service under this contract.',
    `capacity_allocation_pct` DECIMAL(18,2) COMMENT 'The percentage of total contract volume allocated to this carrier, used in multi-carrier sourcing strategies.',
    `contract_effective_date` DATE COMMENT 'The date when this specific carrier engagement under the term contract becomes effective and the carrier begins providing services.',
    `contract_expiry_date` DATE COMMENT 'The date when this specific carrier engagement under the term contract expires or is scheduled to end.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'The negotiated transportation rate for this specific carrier under this term contract, expressed per unit (per barrel-mile, per ton-mile, per shipment). This rate is carrier-specific and may differ from other carriers engaged under the same contract.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this carrier engagement record was created in the system.',
    `engagement_status` STRING COMMENT 'Current status of this carrier engagement: active (carrier is providing services), suspended (temporarily paused), terminated (ended early), pending_activation (approved but not yet started), expired (contract period ended).',
    `insurance_requirement_met_flag` BOOLEAN COMMENT 'Indicates whether the carrier has met the specific insurance coverage requirements stipulated in this term contract.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this carrier engagement record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this carrier engagement record was last modified.',
    `on_time_delivery_target_pct` DECIMAL(18,2) COMMENT 'The percentage of shipments that must be delivered on-time to meet SLA requirements for this carrier under this contract.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due to this carrier for services rendered under this contract.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the performance bond or guarantee posted by the carrier for this contract engagement, if required.',
    `performance_bond_currency_code` STRING COMMENT 'Three-letter ISO currency code for the performance bond amount.',
    `primary_carrier_flag` BOOLEAN COMMENT 'Indicates whether this carrier is designated as the primary or preferred carrier for this term contract. Used for routing and allocation decisions.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the contracted rate is denominated.',
    `rate_uom` STRING COMMENT 'Unit of measure for the contracted rate (e.g., per BBL-mile, per MT-km, per shipment, per day).',
    `service_level_agreement` STRING COMMENT 'Text description or reference to the service level agreement terms specific to this carrier engagement, including transit time commitments, on-time delivery targets, communication protocols, and performance penalties.',
    `transit_time_commitment_hours` STRING COMMENT 'Maximum transit time in hours that this carrier commits to for deliveries under this contract.',
    `volume_commitment` DECIMAL(18,2) COMMENT 'The volume commitment allocated to this specific carrier under the term contract. Represents the quantity this carrier is contracted to transport over the contract period.',
    `volume_commitment_uom` STRING COMMENT 'Unit of measure for the carrier-specific volume commitment (BBL, MT, MMBTU, etc.).',
    `created_by` STRING COMMENT 'User ID or name of the person who created this carrier engagement record.',
    CONSTRAINT pk_carrier_contract_engagement PRIMARY KEY(`carrier_contract_engagement_id`)
) COMMENT 'This association product represents the contractual engagement between a transportation carrier and a term contract. It captures carrier-specific commercial terms, volume commitments, service level agreements, and rates negotiated for transportation services under each term contract. Each record links one carrier to one term contract with attributes that exist only in the context of this specific carrier-contract relationship, enabling multi-carrier sourcing strategies and carrier performance management per contract.. Existence Justification: In oil and gas logistics operations, term contracts for petroleum product transportation routinely engage multiple carriers to ensure capacity redundancy, geographic coverage, and competitive pricing. Each carrier operates under carrier-specific rates, volume allocations, and service level agreements within the same master contract. Conversely, a single carrier typically provides services under multiple term contracts serving different customers, routes, or product types. This is an operational procurement pattern where logistics teams actively manage carrier engagements, track performance against contract-specific SLAs, and optimize multi-carrier sourcing strategies.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`shipper` (
    `shipper_id` BIGINT COMMENT 'Primary key for shipper',
    `tax_entity_id` BIGINT COMMENT 'Government‑issued tax identifier for the shipper (e.g., EIN).',
    `parent_shipper_id` BIGINT COMMENT 'Self-referencing FK on shipper (parent_shipper_id)',
    `address_line1` STRING COMMENT 'First line of the shippers street address.',
    `address_line2` STRING COMMENT 'Second line of the shippers street address (optional).',
    `carrier_code` STRING COMMENT 'Internal code used to identify the carrier within the logistics system.',
    `city` STRING COMMENT 'City component of the shippers address.',
    `classification` STRING COMMENT 'Indicates whether the shipper operates domestically or internationally.',
    `compliance_last_audit_date` DATE COMMENT 'Date of the most recent compliance audit performed on the shipper.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the shipper with FERC and PHMSA regulations.',
    `contract_term_months` STRING COMMENT 'Length of the shippers contract in months.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the shippers location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the shipper record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount extended to the shipper.',
    `credit_limit_currency` STRING COMMENT 'Currency in which the credit limit is expressed.',
    `effective_from` DATE COMMENT 'Date when the shipper relationship becomes effective.',
    `effective_until` DATE COMMENT 'Date when the shipper relationship ends (null if open‑ended).',
    `external_system_reference` STRING COMMENT 'Identifier of the shipper in an external ERP or TMS system.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the shippers liability insurance policy.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the shippers liability insurance.',
    `is_hazardous_material_allowed` BOOLEAN COMMENT 'Indicates whether the shipper is authorized to transport hazardous materials.',
    `last_contract_review_date` DATE COMMENT 'Date when the shippers contract was last reviewed.',
    `legal_name` STRING COMMENT 'Full legal name of the shipper as registered with regulatory authorities.',
    `max_daily_volume` DECIMAL(18,2) COMMENT 'Maximum volume (in specified unit) the shipper can handle per day.',
    `max_daily_volume_unit` STRING COMMENT 'Unit of measure for the maximum daily volume (barrels or cubic meters).',
    `shipper_name` STRING COMMENT 'Common name used to refer to the shipper.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the shipper.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the shippers address.',
    `preferred_payment_method` STRING COMMENT 'Default method used to settle invoices with the shipper.',
    `primary_contact_email` STRING COMMENT 'Email address for the primary contact.',
    `primary_contact_name` STRING COMMENT 'Name of the primary person to contact at the shipper organization.',
    `primary_contact_phone` STRING COMMENT 'Telephone number for the primary contact.',
    `rating_date` DATE COMMENT 'Date when the current rating score became effective.',
    `rating_score` DECIMAL(18,2) COMMENT 'Aggregated performance rating (0‑5) based on delivery reliability and safety.',
    `registration_number` STRING COMMENT 'Official registration number assigned by the jurisdiction of incorporation.',
    `safety_certification_expiry` DATE COMMENT 'Expiration date of the shippers most recent safety certification.',
    `safety_certification_status` STRING COMMENT 'Current status of the shippers safety certifications required by PHMSA.',
    `shipper_type` STRING COMMENT 'Categorizes the shipper as a carrier, broker, internal entity, or third‑party.',
    `short_name` STRING COMMENT 'Abbreviated or short version of the shipper name for display purposes.',
    `state` STRING COMMENT 'State or province component of the shippers address.',
    `shipper_status` STRING COMMENT 'Current lifecycle status of the shipper record.',
    `tariff_rate_code` STRING COMMENT 'Code referencing the applicable tariff rate for the shippers shipments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the shipper record.',
    CONSTRAINT pk_shipper PRIMARY KEY(`shipper_id`)
) COMMENT 'Master reference table for shipper. Referenced by shipper_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`cargo` (
    `cargo_id` BIGINT COMMENT 'Primary key for cargo',
    `parent_cargo_id` BIGINT COMMENT 'Self-referencing FK on cargo (parent_cargo_id)',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Timestamp when cargo actually arrived at destination.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Timestamp when cargo actually left the origin.',
    `cargo_code` STRING COMMENT 'Business‑assigned code used in contracts and scheduling systems.',
    `cargo_description` STRING COMMENT 'Free‑form description of cargo characteristics.',
    `cargo_name` STRING COMMENT 'Human‑readable name or title of the cargo (e.g., West Texas Crude).',
    `cargo_type` STRING COMMENT 'Classification of the cargo commodity.',
    `carrier_name` STRING COMMENT 'Name of the transportation carrier (pipeline operator, shipping line, trucking firm).',
    `commodity_code` STRING COMMENT 'Standard industry code (e.g., NAICS, HS) identifying the commodity.',
    `compliance_status` STRING COMMENT 'Current compliance status with PHMSA/FERC regulations.',
    `contract_number` STRING COMMENT 'Reference to the commercial contract governing the cargo movement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cargo record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `data_source` STRING COMMENT 'Logical source classification (e.g., SCADA, ERP, manual entry).',
    `destination_location` STRING COMMENT 'Name or code of the discharge location.',
    `discharge_port` STRING COMMENT 'Port or terminal where cargo is discharged.',
    `estimated_value_usd` DECIMAL(18,2) COMMENT 'Monetary estimate of cargo value in US dollars.',
    `hazard_class` STRING COMMENT 'Regulatory hazard class of the cargo.',
    `insurance_policy_number` STRING COMMENT 'Policy identifier for cargo insurance coverage.',
    `is_exempt_from_tariff` BOOLEAN COMMENT 'Indicates if the cargo is exempt from standard tariff rates.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the cargo is classified as hazardous.',
    `is_insured` BOOLEAN COMMENT 'Indicates whether the cargo is covered by insurance.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or regulatory inspection.',
    `last_inspection_type` STRING COMMENT 'Type of the most recent inspection (e.g., safety, environmental).',
    `loading_port` STRING COMMENT 'Port or terminal where cargo is loaded.',
    `origin_location` STRING COMMENT 'Name or code of the loading location (e.g., field, terminal).',
    `pressure_bar` DECIMAL(18,2) COMMENT 'Measured pressure of the cargo during transport.',
    `priority_level` STRING COMMENT 'Operational priority assigned to the cargo shipment.',
    `remarks` STRING COMMENT 'Additional free‑form notes about the cargo.',
    `scheduled_arrival_date` DATE COMMENT 'Planned date for cargo arrival at destination.',
    `scheduled_departure_date` DATE COMMENT 'Planned date for cargo departure from origin.',
    `source_system` STRING COMMENT 'Name of the upstream operational system that supplied the record.',
    `cargo_status` STRING COMMENT 'Current lifecycle state of the cargo.',
    `tariff_rate` DECIMAL(18,2) COMMENT 'Applicable tariff rate for the cargo movement (per unit).',
    `temperature_c` DECIMAL(18,2) COMMENT 'Measured temperature of the cargo during transport.',
    `unit_of_measure` STRING COMMENT 'Unit used for volume or weight measurements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cargo record.',
    `vessel_imo_number` STRING COMMENT 'International Maritime Organization number of the vessel transporting the cargo.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Measured volume of the cargo in cubic meters.',
    `weight_tons` DECIMAL(18,2) COMMENT 'Weight of the cargo in metric tons.',
    `created_by` STRING COMMENT 'User or system identifier that created the cargo record.',
    CONSTRAINT pk_cargo PRIMARY KEY(`cargo_id`)
) COMMENT 'Master reference table for cargo. Referenced by cargo_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipper`(`shipper_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_truck_ticket_id` FOREIGN KEY (`truck_ticket_id`) REFERENCES `oil_gas_ecm`.`logistics`.`truck_ticket`(`truck_ticket_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `oil_gas_ecm`.`logistics`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `oil_gas_ecm`.`logistics`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ADD CONSTRAINT `fk_logistics_tariff_rate_superseded_tariff_rate_id` FOREIGN KEY (`superseded_tariff_rate_id`) REFERENCES `oil_gas_ecm`.`logistics`.`tariff_rate`(`tariff_rate_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ADD CONSTRAINT `fk_logistics_tariff_rate_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_charter_party_id` FOREIGN KEY (`charter_party_id`) REFERENCES `oil_gas_ecm`.`logistics`.`charter_party`(`charter_party_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_port_call_id` FOREIGN KEY (`port_call_id`) REFERENCES `oil_gas_ecm`.`logistics`.`port_call`(`port_call_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ADD CONSTRAINT `fk_logistics_truck_ticket_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ADD CONSTRAINT `fk_logistics_truck_ticket_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `oil_gas_ecm`.`logistics`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ADD CONSTRAINT `fk_logistics_charter_party_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ADD CONSTRAINT `fk_logistics_port_call_charter_party_id` FOREIGN KEY (`charter_party_id`) REFERENCES `oil_gas_ecm`.`logistics`.`charter_party`(`charter_party_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ADD CONSTRAINT `fk_logistics_port_call_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ADD CONSTRAINT `fk_logistics_port_call_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `oil_gas_ecm`.`logistics`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_charter_party_id` FOREIGN KEY (`charter_party_id`) REFERENCES `oil_gas_ecm`.`logistics`.`charter_party`(`charter_party_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_receiving_terminal_id` FOREIGN KEY (`receiving_terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ADD CONSTRAINT `fk_logistics_rail_waybill_tariff_rate_id` FOREIGN KEY (`tariff_rate_id`) REFERENCES `oil_gas_ecm`.`logistics`.`tariff_rate`(`tariff_rate_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_port_call_id` FOREIGN KEY (`port_call_id`) REFERENCES `oil_gas_ecm`.`logistics`.`port_call`(`port_call_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ADD CONSTRAINT `fk_logistics_terminal_access_agreement_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ADD CONSTRAINT `fk_logistics_carrier_product_authorization_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ADD CONSTRAINT `fk_logistics_carrier_product_approval_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ADD CONSTRAINT `fk_logistics_vessel_cargo_compatibility_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ADD CONSTRAINT `fk_logistics_carrier_contract_engagement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ADD CONSTRAINT `fk_logistics_shipper_parent_shipper_id` FOREIGN KEY (`parent_shipper_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipper`(`shipper_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo` ADD CONSTRAINT `fk_logistics_cargo_parent_cargo_id` FOREIGN KEY (`parent_cargo_id`) REFERENCES `oil_gas_ecm`.`logistics`.`cargo`(`cargo_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Driver Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `hse_training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `truck_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Ticket Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `actual_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `bsw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Basic Sediment and Water (BS&W) Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `custody_transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `custody_transfer_status` SET TAGS ('dbx_value_regex' = 'pending|origin_transferred|in_transit|destination_received|completed|disputed');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `destination_location_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `fpso_lifting_reference` SET TAGS ('dbx_business_glossary_term' = 'Floating Production Storage and Offloading (FPSO) Lifting Reference');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `hse_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (INCOTERMS)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `loading_rack_number` SET TAGS ('dbx_business_glossary_term' = 'Loading Rack Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `nominated_volume` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_car_initial` SET TAGS ('dbx_business_glossary_term' = 'Rail Car Initial');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_car_initial` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_car_number` SET TAGS ('dbx_business_glossary_term' = 'Rail Car Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_car_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,6}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Rail Gross Weight');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_net_weight` SET TAGS ('dbx_business_glossary_term' = 'Rail Net Weight');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_number_of_cars` SET TAGS ('dbx_business_glossary_term' = 'Rail Number of Cars');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_un_hazmat_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Hazardous Materials Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rail_un_hazmat_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `scheduled_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `seal_numbers` SET TAGS ('dbx_business_glossary_term' = 'Seal Numbers');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `tariff_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Tariff Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `tariff_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'pipeline|tanker|truck|rail|barge|fpso_lifting');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `truck_gross_volume` SET TAGS ('dbx_business_glossary_term' = 'Truck Gross Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `truck_net_volume` SET TAGS ('dbx_business_glossary_term' = 'Truck Net Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `truck_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Truck Registration Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Receipt Location Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `co2_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Content Percent');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `confirmed_volume` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `confirmed_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `confirmed_volume_uom` SET TAGS ('dbx_value_regex' = 'BOPD|MMCFD|MCFD|BBL|MCF|MMCF');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `crude_api_gravity` SET TAGS ('dbx_business_glossary_term' = 'Crude American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `crude_sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Crude Sulfur Content Percent');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `cut_volume` SET TAGS ('dbx_business_glossary_term' = 'Cut Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `ferc_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Tariff Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `gas_heating_value_btu_per_scf` SET TAGS ('dbx_business_glossary_term' = 'Gas Heating Value British Thermal Units (BTU) per Standard Cubic Foot (SCF)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `gas_specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Gas Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nominated_volume` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nominated_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nominated_volume_uom` SET TAGS ('dbx_value_regex' = 'BOPD|MMCFD|MCFD|BBL|MCF|MMCF');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nomination_cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Nomination Cancelled Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nomination_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Nomination Confirmed Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nomination_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Nomination Cycle Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nomination_cycle_type` SET TAGS ('dbx_value_regex' = 'intraday|daily|monthly|weekly');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nomination_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Effective Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nomination_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Nomination Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_business_glossary_term' = 'Nomination Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_value_regex' = 'submitted|confirmed|cut|scheduled|rejected|cancelled');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `nomination_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Nomination Submitted Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `operator_notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `phmsa_pipeline_code` SET TAGS ('dbx_business_glossary_term' = 'Pipeline and Hazardous Materials Safety Administration (PHMSA) Pipeline Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `priority_class` SET TAGS ('dbx_value_regex' = 'firm|interruptible|secondary');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `proration_factor` SET TAGS ('dbx_business_glossary_term' = 'Proration Factor');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `shipper_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Shipper Contact Email Address');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `shipper_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `shipper_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `shipper_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `shipper_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Contact Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `shipper_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `shipper_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Shipper Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `shipper_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `shipper_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `transportation_rate` SET TAGS ('dbx_business_glossary_term' = 'Transportation Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `transportation_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `transportation_rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Transportation Rate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `transportation_rate_uom` SET TAGS ('dbx_value_regex' = 'USD_per_BBL|USD_per_MCF|USD_per_MMCF');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `water_content_lbs_per_mmcf` SET TAGS ('dbx_business_glossary_term' = 'Water Content Pounds (LBS) per Million Cubic Feet (MMCF)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `logistics_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Lifting Schedule ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `vessel_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approval Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `associated_lifting_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Associated Lifting Program Reference');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `berth_assignment` SET TAGS ('dbx_business_glossary_term' = 'Berth Assignment');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `cargo_number` SET TAGS ('dbx_business_glossary_term' = 'Cargo Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `charter_party_type` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `charter_party_type` SET TAGS ('dbx_value_regex' = 'voyage|time|bareboat');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `custody_transfer_method` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Measurement Method');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `custody_transfer_method` SET TAGS ('dbx_value_regex' = 'metered|gauged|calculated');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `demurrage_rate_usd_per_day` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Rate in United States Dollars (USD) Per Day');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `demurrage_rate_usd_per_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `destination_port` SET TAGS ('dbx_business_glossary_term' = 'Destination Port or Refinery');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Oil or Gas Field Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `fpso_name` SET TAGS ('dbx_business_glossary_term' = 'Floating Production Storage and Offloading (FPSO) Facility Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `freight_rate_usd_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate in United States Dollars (USD) Per Barrel (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `freight_rate_usd_per_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `laycan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan End Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `laycan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan Start Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `lifting_month` SET TAGS ('dbx_business_glossary_term' = 'Lifting Month');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `lifting_month` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-2])-d{4}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `lifting_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `lifting_status` SET TAGS ('dbx_business_glossary_term' = 'Lifting Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `lifting_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|completed|deferred|cancelled');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `nominated_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `number_of_vessels_assigned` SET TAGS ('dbx_business_glossary_term' = 'Number of Vessels Assigned');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Schedule Remarks');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|approved|published|revised');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Volume Tolerance Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `total_planned_liftings` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Liftings Count');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `total_planned_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `custody_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Transferor Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `bsw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Basic Sediment and Water (BS&W) Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `draft_survey_result` SET TAGS ('dbx_business_glossary_term' = 'Draft Survey Result');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `gross_observed_volume` SET TAGS ('dbx_business_glossary_term' = 'Gross Observed Volume (GOV)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `gross_standard_volume` SET TAGS ('dbx_business_glossary_term' = 'Gross Standard Volume (GSV)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `independent_inspector_company` SET TAGS ('dbx_business_glossary_term' = 'Independent Inspector Company');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'quantity|quality|draft_survey|ullage_survey|combined');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `jib_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Allocation Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `jib_allocation_status` SET TAGS ('dbx_value_regex' = 'pending|allocated|billed|paid|disputed');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `meter_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Ticket Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `net_standard_volume` SET TAGS ('dbx_business_glossary_term' = 'Net Standard Volume (NSV)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `observed_pressure` SET TAGS ('dbx_business_glossary_term' = 'Observed Pressure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `observed_temperature` SET TAGS ('dbx_business_glossary_term' = 'Observed Temperature');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `pressure_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Pressure Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `pressure_unit_of_measure` SET TAGS ('dbx_value_regex' = 'psi|kpa|bar');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `quality_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Claim Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `quantity_variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `royalty_calculation_flag` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `seal_numbers` SET TAGS ('dbx_business_glossary_term' = 'Seal Numbers');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `seal_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Seal Verification Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `seal_verification_status` SET TAGS ('dbx_value_regex' = 'intact|broken|missing|not_applicable');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `sulfur_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `temperature_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `temperature_unit_of_measure` SET TAGS ('dbx_value_regex' = 'F|C');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `transfer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|disputed|cancelled|reversed');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'bbl|m3|gal|mcf|mmcf');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `beam_m` SET TAGS ('dbx_business_glossary_term' = 'Beam in Meters');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `cargo_capacity_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cargo Capacity in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `cargo_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Cargo Capacity in Cubic Meters (CBM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `cargo_heating_capability` SET TAGS ('dbx_business_glossary_term' = 'Cargo Heating Capability');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `cargo_tank_count` SET TAGS ('dbx_business_glossary_term' = 'Cargo Tank Count');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `class_notation` SET TAGS ('dbx_business_glossary_term' = 'Class Notation');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `classification_society` SET TAGS ('dbx_business_glossary_term' = 'Classification Society');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `commercial_manager` SET TAGS ('dbx_business_glossary_term' = 'Commercial Manager');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `crude_oil_washing_system` SET TAGS ('dbx_business_glossary_term' = 'Crude Oil Washing (COW) System');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `deadweight_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Deadweight Tonnage (DWT)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `draft_m` SET TAGS ('dbx_business_glossary_term' = 'Draft in Meters');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `flag_state` SET TAGS ('dbx_business_glossary_term' = 'Flag State');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `flag_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `fuel_consumption_mt_per_day` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption in Metric Tons per Day');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `gross_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Gross Tonnage (GT)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `hull_type` SET TAGS ('dbx_business_glossary_term' = 'Hull Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `hull_type` SET TAGS ('dbx_value_regex' = 'Single Hull|Double Hull|Double Bottom|Double Sided');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `ice_class` SET TAGS ('dbx_business_glossary_term' = 'Ice Class');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `imo_number` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Organization (IMO) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `inert_gas_system` SET TAGS ('dbx_business_glossary_term' = 'Inert Gas System (IGS)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `last_drydock_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drydock Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `last_sire_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Inspection Report (SIRE) Inspection Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `length_overall_m` SET TAGS ('dbx_business_glossary_term' = 'Length Overall in Meters (LOA)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `main_engine_type` SET TAGS ('dbx_business_glossary_term' = 'Main Engine Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `net_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Net Tonnage (NT)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `next_special_survey_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Special Survey Due Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'In Service|Laid Up|Under Repair|Drydocked|Scrapped|Under Construction');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `operator_company` SET TAGS ('dbx_business_glossary_term' = 'Operator Company');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `owner_company` SET TAGS ('dbx_business_glossary_term' = 'Owner Company');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `propulsion_power_kw` SET TAGS ('dbx_business_glossary_term' = 'Propulsion Power in Kilowatts (kW)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `protection_indemnity_club` SET TAGS ('dbx_business_glossary_term' = 'Protection and Indemnity (P&I) Club');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `segregated_ballast_tanks` SET TAGS ('dbx_business_glossary_term' = 'Segregated Ballast Tanks (SBT)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `service_speed_knots` SET TAGS ('dbx_business_glossary_term' = 'Service Speed in Knots');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `shipyard` SET TAGS ('dbx_business_glossary_term' = 'Shipyard');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `sire_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Ship Inspection Report (SIRE) Inspection Result');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `sire_inspection_result` SET TAGS ('dbx_value_regex' = 'Acceptable|Acceptable with Observations|Unacceptable');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `vessel_type` SET TAGS ('dbx_business_glossary_term' = 'Vessel Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `vetting_status` SET TAGS ('dbx_business_glossary_term' = 'Vetting Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `vetting_status` SET TAGS ('dbx_value_regex' = 'Approved|Conditional|Rejected|Pending|Not Vetted');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Master Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Charterer Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `voyage_shipowner_commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Shipowner Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (B/L) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `bunker_consumption_mt` SET TAGS ('dbx_business_glossary_term' = 'Bunker Consumption Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `bunker_cost` SET TAGS ('dbx_business_glossary_term' = 'Bunker Cost');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `canal_fees` SET TAGS ('dbx_business_glossary_term' = 'Canal Fees');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `cargo_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cargo Quantity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `cargo_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Cargo Quantity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `cargo_quantity_uom` SET TAGS ('dbx_value_regex' = 'BBL|MT|M3|MMBTU|GAL');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `charter_party_reference` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Reference');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `charter_type` SET TAGS ('dbx_business_glossary_term' = 'Charter Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `charter_type` SET TAGS ('dbx_value_regex' = 'voyage_charter|time_charter|bareboat_charter|contract_of_affreightment|spot');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Voyage Commencement Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Voyage Completion Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `demurrage_amount` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `demurrage_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Claim Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `demurrage_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Claim Reference');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `demurrage_claim_status` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Claim Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `demurrage_claim_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|disputed|agreed|settled|withdrawn');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `demurrage_dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `demurrage_hours` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Hours');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `demurrage_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Rate Per Day');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `demurrage_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Settlement Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `despatch_amount` SET TAGS ('dbx_business_glossary_term' = 'Despatch Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `despatch_hours` SET TAGS ('dbx_business_glossary_term' = 'Despatch Hours');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `despatch_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Despatch Rate Per Day');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `fixture_date` SET TAGS ('dbx_business_glossary_term' = 'Fixture Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `freight_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `freight_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `freight_rate` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `freight_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Basis');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `freight_rate_basis` SET TAGS ('dbx_value_regex' = 'worldscale|lump_sum|per_ton|per_barrel|per_cubic_meter');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `laycan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan End Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `laycan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan Start Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `port_charges_total` SET TAGS ('dbx_business_glossary_term' = 'Port Charges Total');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `profit_loss` SET TAGS ('dbx_business_glossary_term' = 'Voyage Profit and Loss (P&L)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `profit_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `total_laytime_allowed_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Laytime Allowed Hours');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `total_laytime_used_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Laytime Used Hours');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `voyage_status` SET TAGS ('dbx_business_glossary_term' = 'Voyage Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `voyage_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|suspended');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `objective_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Objective Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Manager Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `custody_transfer_metering` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Metering');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `epa_rmp_registration` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Risk Management Plan (RMP) Registration');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `hse_incident_count_ytd` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Count Year-to-Date (YTD)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `maximum_draft_meters` SET TAGS ('dbx_business_glossary_term' = 'Maximum Draft (Meters)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `maximum_vessel_size_dwt` SET TAGS ('dbx_business_glossary_term' = 'Maximum Vessel Size (DWT)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `number_of_berths` SET TAGS ('dbx_business_glossary_term' = 'Number of Berths');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `number_of_loading_arms` SET TAGS ('dbx_business_glossary_term' = 'Number of Loading Arms');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `number_of_tanks` SET TAGS ('dbx_business_glossary_term' = 'Number of Storage Tanks');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|maintenance|idle|decommissioned|under_construction|suspended');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `osha_psm_covered` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Process Safety Management (PSM) Covered');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `pipeline_system_connection` SET TAGS ('dbx_business_glossary_term' = 'Pipeline System Connection');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `product_types_handled` SET TAGS ('dbx_business_glossary_term' = 'Product Types Handled');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `scada_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Enabled');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `spcc_plan_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Spill Prevention Control and Countermeasure (SPCC) Plan Revision Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `tariff_rate_usd_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate (USD per BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `tariff_rate_usd_per_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Terminal Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `terminal_name` SET TAGS ('dbx_business_glossary_term' = 'Terminal Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `terminal_type` SET TAGS ('dbx_value_regex' = 'marine|pipeline|truck_rack|rail|multimodal');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `throughput_capacity_bopd` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity (BOPD)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `throughput_capacity_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity (MCFD)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `total_storage_capacity_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Capacity (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `total_storage_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Capacity (CBM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `uscg_facility_number` SET TAGS ('dbx_business_glossary_term' = 'United States Coast Guard (USCG) Facility Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` SET TAGS ('dbx_subdomain' = 'financial_billing');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `ferc_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Ferc Tariff Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `superseded_tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Tariff Rate Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Tariff Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance in Miles');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tariff Effective Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tariff Expiration Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Tariff Filing Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `fuel_retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fuel Retention Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `index_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Index Adjustment Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `index_type` SET TAGS ('dbx_business_glossary_term' = 'Index Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `index_type` SET TAGS ('dbx_value_regex' = 'cpi|ppi|wti|henry_hub|fixed|none');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `loss_allowance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Loss Allowance Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `maximum_tender_volume` SET TAGS ('dbx_business_glossary_term' = 'Maximum Tender Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `minimum_tender_volume` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tender Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `quality_specification` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'per_bbl|per_mmbtu|per_mcf|per_ton|per_gallon|per_day');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `rate_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Reference');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `shipper_class` SET TAGS ('dbx_business_glossary_term' = 'Shipper Class');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `shipper_class` SET TAGS ('dbx_value_regex' = 'firm|interruptible|all');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Tariff Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `tariff_status` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `tariff_status` SET TAGS ('dbx_value_regex' = 'filed|effective|suspended|superseded|withdrawn|pending_approval');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `tariff_type` SET TAGS ('dbx_business_glossary_term' = 'Tariff Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `tariff_type` SET TAGS ('dbx_value_regex' = 'pipeline_transportation|terminalling|storage|throughput|gathering|processing');
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `customer_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Schedule Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `tertiary_delivery_consignee_party_commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `authorized_volume` SET TAGS ('dbx_business_glossary_term' = 'Authorized Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `carrier_reference` SET TAGS ('dbx_business_glossary_term' = 'Carrier Reference');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `delivery_order_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `delivery_order_number` SET TAGS ('dbx_value_regex' = '^DO-[0-9]{8,12}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'issued|scheduled|in_transit|partially_delivered|completed|cancelled');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `delivery_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `delivery_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Issuance Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `nomination_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Nomination Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `price_differential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority Level');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|critical');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `quality_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Reference');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `regulatory_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'pipeline|tanker|truck|rail|barge|fpso');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'BBL|MT|GAL|M3|MMBTU|MCF');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Manager Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_value_regex' = 'active|suspended|blacklisted|pending_approval|inactive');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'pipeline|marine|truck|rail|barge|air');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_business_glossary_term' = 'Country of Registration');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `country_of_registration` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `hazmat_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certification Expiry Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `hazmat_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certification Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `hazmat_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certification Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `hazmat_certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|pending|not_certified');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `imo_number` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Organization (IMO) Company Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `preferred_carrier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Carrier Remarks');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|conditional|unsatisfactory|not_rated');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `safety_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `vetting_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Vetting Approval Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `vetting_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Vetting Approval Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `vetting_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|expired|under_review');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `vetting_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Vetting Expiry Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` SET TAGS ('dbx_subdomain' = 'financial_billing');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `accessorial_charges` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `base_freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Freight Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `demurrage_charge` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Charge');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `despatch_credit` SET TAGS ('dbx_business_glossary_term' = 'Despatch Credit');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_rate` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Basis');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_rate_basis` SET TAGS ('dbx_value_regex' = 'per_barrel|per_mcf|per_ton|per_mile|lumpsum|worldscale');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `fuel_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|processed|cancelled');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `jib_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Allocation Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `jib_allocation_status` SET TAGS ('dbx_value_regex' = 'pending|allocated|completed|not_applicable');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|partial|overdue|disputed|cancelled');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `pda_charge` SET TAGS ('dbx_business_glossary_term' = 'Port Disbursement Account (PDA) Charge');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `shipped_volume` SET TAGS ('dbx_business_glossary_term' = 'Shipped Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `total_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'pipeline|tanker|truck|rail|barge|fpso');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'BBL|MCF|MMCF|GAL|MT|M3');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` SET TAGS ('dbx_subdomain' = 'financial_billing');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `demurrage_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Claim Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `charter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Claims Analyst Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `port_call_id` SET TAGS ('dbx_business_glossary_term' = 'Port Call Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `agreed_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `cargo_volume` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `cargo_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `cargo_volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|M3|MT|MMBTU');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `claim_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `claim_notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `demurrage_hours` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Hours');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `demurrage_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Rate Per Day');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `despatch_hours` SET TAGS ('dbx_business_glossary_term' = 'Despatch Hours');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `despatch_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Despatch Rate Per Day');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `laytime_allowed_hours` SET TAGS ('dbx_business_glossary_term' = 'Laytime Allowed Hours');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `laytime_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Laytime Calculation Method');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `laytime_calculation_method` SET TAGS ('dbx_value_regex' = 'reversible|irreversible|average|separate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `laytime_used_hours` SET TAGS ('dbx_business_glossary_term' = 'Laytime Used Hours');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `notice_of_readiness_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notice of Readiness (NOR) Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `operations_commenced_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operations Commenced Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `operations_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operations Completed Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `port_operation_type` SET TAGS ('dbx_business_glossary_term' = 'Port Operation Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `port_operation_type` SET TAGS ('dbx_value_regex' = 'loading|discharge|both');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `statement_of_facts_reference` SET TAGS ('dbx_business_glossary_term' = 'Statement of Facts Reference');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `supporting_documentation` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `time_exceptions_hours` SET TAGS ('dbx_business_glossary_term' = 'Time Exceptions Hours');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `time_exceptions_reason` SET TAGS ('dbx_business_glossary_term' = 'Time Exceptions Reason');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_business_glossary_term' = 'Vessel International Maritime Organization (IMO) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `shipping_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Schedule ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `lifting_program_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `demurrage_risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Risk Assessment');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `demurrage_risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `ferc_tariff_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Tariff Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `fpso_lifting_flag` SET TAGS ('dbx_business_glossary_term' = 'Floating Production Storage and Offloading (FPSO) Lifting Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `joa_allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Allocation Basis');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `joa_allocation_basis` SET TAGS ('dbx_value_regex' = 'working_interest|net_revenue_interest|production_entitlement|equal_share');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `number_of_vessels_assigned` SET TAGS ('dbx_business_glossary_term' = 'Number of Vessels Assigned');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `phmsa_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pipeline and Hazardous Materials Safety Administration (PHMSA) Reporting Required Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `pipeline_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Integration Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `planning_horizon_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `planning_horizon_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|rolling');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `primary_product_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `psa_entitlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Entitlement Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `scada_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `scada_integration_status` SET TAGS ('dbx_value_regex' = 'integrated|partial|not_integrated|pending');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approved By');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approved Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_optimization_method` SET TAGS ('dbx_business_glossary_term' = 'Schedule Optimization Method');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_optimization_method` SET TAGS ('dbx_value_regex' = 'manual|rule_based|optimization_algorithm|ai_ml');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Schedule Prepared By');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_prepared_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Prepared Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_published_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Published Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_reference_number` SET TAGS ('dbx_value_regex' = '^SS-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Schedule Revision Reason');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|approved|published|revised|cancelled|archived');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `total_planned_liftings` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Liftings Count');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `total_planned_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `total_planned_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Volume (Barrel of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `weather_contingency_buffer_days` SET TAGS ('dbx_business_glossary_term' = 'Weather Contingency Buffer Days');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `truck_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Ticket Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `bsw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bottom Sediment and Water (BS&W) Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `destination_address` SET TAGS ('dbx_business_glossary_term' = 'Destination Address');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `destination_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `destination_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_business_glossary_term' = 'Driver License Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `driver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `emergency_response_guide_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Guide (ERG) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `emergency_response_guide_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `gross_volume` SET TAGS ('dbx_business_glossary_term' = 'Gross Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Class');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `loading_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loading End Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `loading_rack_code` SET TAGS ('dbx_business_glossary_term' = 'Loading Rack Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `loading_rack_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,15}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `loading_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loading Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `net_volume` SET TAGS ('dbx_business_glossary_term' = 'Net Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `observed_temperature` SET TAGS ('dbx_business_glossary_term' = 'Observed Temperature');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `operator_notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `seal_numbers` SET TAGS ('dbx_business_glossary_term' = 'Seal Numbers');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `seal_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Seal Verification Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `seal_verification_status` SET TAGS ('dbx_value_regex' = 'verified|broken|missing|not_applicable');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `sulfur_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_value_regex' = 'F|C');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `ticket_date` SET TAGS ('dbx_business_glossary_term' = 'Ticket Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Ticket Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_value_regex' = 'draft|loaded|in_transit|delivered|cancelled|disputed');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `ticket_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,15}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `truck_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Truck Registration Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `truck_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `truck_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Truck Unit Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `truck_unit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,15}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|GAL|L|M3');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `pipeline_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Batch Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduler Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `actual_injected_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Injected Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `batch_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `batch_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'scheduled|injecting|in_transit|delivering|delivered|cancelled');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `bsw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Basic Sediment and Water (BS&W) Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `delivery_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery End Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `delivery_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `fuel_gas_used_volume` SET TAGS ('dbx_business_glossary_term' = 'Fuel Gas Used Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `gas_specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Gas Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `heating_value_btu_per_scf` SET TAGS ('dbx_business_glossary_term' = 'Heating Value in British Thermal Units (BTU) per Standard Cubic Foot (SCF)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `imbalance_volume` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `injection_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Injection End Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `injection_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Injection Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `interface_management_instruction` SET TAGS ('dbx_business_glossary_term' = 'Interface Management Instruction');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `line_loss_volume` SET TAGS ('dbx_business_glossary_term' = 'Line Loss Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `metered_delivery_volume` SET TAGS ('dbx_business_glossary_term' = 'Metered Delivery Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `metered_receipt_volume` SET TAGS ('dbx_business_glossary_term' = 'Metered Receipt Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `nominated_volume` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `nominated_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `operator_notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `phmsa_pipeline_code` SET TAGS ('dbx_business_glossary_term' = 'Pipeline and Hazardous Materials Safety Administration (PHMSA) Pipeline Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `rvp_psi` SET TAGS ('dbx_business_glossary_term' = 'Reid Vapor Pressure (RVP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `shrinkage_volume` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `tariff_rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `tariff_rate_uom` SET TAGS ('dbx_value_regex' = 'USD_PER_BBL|USD_PER_MMBTU|USD_PER_MCF');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `storage_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Inventory ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Controller Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'API (American Petroleum Institute) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `bsw_percentage` SET TAGS ('dbx_business_glossary_term' = 'BSW (Basic Sediment and Water) Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `closing_inventory_bbl` SET TAGS ('dbx_business_glossary_term' = 'Closing Inventory (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `custody_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `deliveries_bbl` SET TAGS ('dbx_business_glossary_term' = 'Deliveries (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `gauge_reference_height` SET TAGS ('dbx_business_glossary_term' = 'Gauge Reference Height');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `gross_observed_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Observed Volume (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `gross_standard_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Standard Volume (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `inspector_company` SET TAGS ('dbx_business_glossary_term' = 'Inspector Company');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|allocated|in_transit|quarantined|contaminated|reserved');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `inventory_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inventory Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `inventory_variance_bbl` SET TAGS ('dbx_business_glossary_term' = 'Inventory Variance (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'manual_gauge|atg|radar|servo|hydrostatic');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `net_standard_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Net Standard Volume (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `observed_pressure` SET TAGS ('dbx_business_glossary_term' = 'Observed Pressure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `observed_temperature` SET TAGS ('dbx_business_glossary_term' = 'Observed Temperature');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `opening_inventory_bbl` SET TAGS ('dbx_business_glossary_term' = 'Opening Inventory (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `pressure_uom` SET TAGS ('dbx_business_glossary_term' = 'Pressure Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `pressure_uom` SET TAGS ('dbx_value_regex' = 'PSI|PSIA|BAR|KPA|MPA');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `receipts_bbl` SET TAGS ('dbx_business_glossary_term' = 'Receipts (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) Integration Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `sulfur_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `tank_capacity_bbl` SET TAGS ('dbx_business_glossary_term' = 'Tank Capacity (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `tank_code` SET TAGS ('dbx_business_glossary_term' = 'Tank ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `tank_strapping_table_code` SET TAGS ('dbx_business_glossary_term' = 'Tank Strapping Table ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_value_regex' = 'F|C|K');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `ullage_bbl` SET TAGS ('dbx_business_glossary_term' = 'Ullage (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `valuation_price_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Valuation Price per Barrel');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `valuation_price_per_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|GAL|M3|L');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `water_bottom_bbl` SET TAGS ('dbx_business_glossary_term' = 'Water Bottom (BBL)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `working_capital_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Working Capital Value (USD)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `working_capital_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `charter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Charter Manager Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Charterer Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `arbitration_clause` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Clause');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Shipbroker Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `cargo_description` SET TAGS ('dbx_business_glossary_term' = 'Cargo Description');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `cargo_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cargo Quantity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `cargo_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Cargo Quantity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `cargo_quantity_uom` SET TAGS ('dbx_value_regex' = 'BBL|MT|CBM');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `cargo_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cargo Tolerance Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `charter_status` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `charter_type` SET TAGS ('dbx_business_glossary_term' = 'Charter Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `charter_type` SET TAGS ('dbx_value_regex' = 'voyage_charter|time_charter|bareboat_charter|contract_of_affreightment');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `demurrage_rate` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `demurrage_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `despatch_rate` SET TAGS ('dbx_business_glossary_term' = 'Despatch Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `despatch_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `discharge_port` SET TAGS ('dbx_business_glossary_term' = 'Discharge Port');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `discharge_port_country` SET TAGS ('dbx_business_glossary_term' = 'Discharge Port Country');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `fixture_date` SET TAGS ('dbx_business_glossary_term' = 'Fixture Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `form` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Form');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `freight_rate` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `freight_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `freight_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Basis');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `freight_rate_basis` SET TAGS ('dbx_value_regex' = 'worldscale|lump_sum|usd_per_bbl|usd_per_mt|daily_hire');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `laycan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan End Date (Laytime Cancelling)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `laycan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan Start Date (Laytime Cancelling)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `laytime_allowed_hours` SET TAGS ('dbx_business_glossary_term' = 'Laytime Allowed (Hours)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `laytime_terms` SET TAGS ('dbx_business_glossary_term' = 'Laytime Terms');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `load_port` SET TAGS ('dbx_business_glossary_term' = 'Load Port');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `load_port_country` SET TAGS ('dbx_business_glossary_term' = 'Load Port Country');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `shipowner_name` SET TAGS ('dbx_business_glossary_term' = 'Shipowner Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `shipowner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `special_clauses` SET TAGS ('dbx_business_glossary_term' = 'Special Clauses');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `total_freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ALTER COLUMN `total_freight_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_call_id` SET TAGS ('dbx_business_glossary_term' = 'Port Call Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `charter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Port Agent Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Port Captain Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `actual_time_of_arrival` SET TAGS ('dbx_business_glossary_term' = 'Actual Time of Arrival (ATA)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `berth_number` SET TAGS ('dbx_business_glossary_term' = 'Berth Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `berthing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Berthing Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (B/L) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `cargo_volume_discharged` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume Discharged');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `cargo_volume_loaded` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume Loaded');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `demurrage_incurred_hours` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Incurred (Hours)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `demurrage_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Rate Per Day');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `demurrage_rate_per_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Departure Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `despatch_earned_hours` SET TAGS ('dbx_business_glossary_term' = 'Despatch Earned (Hours)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `estimated_time_of_arrival` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `laytime_allowed_hours` SET TAGS ('dbx_business_glossary_term' = 'Laytime Allowed (Hours)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `laytime_used_hours` SET TAGS ('dbx_business_glossary_term' = 'Laytime Used (Hours)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `notice_of_readiness_accepted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notice of Readiness (NOR) Accepted Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `notice_of_readiness_tendered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notice of Readiness (NOR) Tendered Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `operations_commencement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operations Commencement Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `operations_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operations Completion Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_agent_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Port Agent Contact Email Address');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_agent_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_agent_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_agent_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_agent_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Port Agent Contact Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_agent_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_agent_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Port Agent Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_agent_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_agent_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_call_status` SET TAGS ('dbx_business_glossary_term' = 'Port Call Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_call_type` SET TAGS ('dbx_business_glossary_term' = 'Port Call Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_call_type` SET TAGS ('dbx_value_regex' = 'load|discharge|bunker|transit|repair|layup');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_disbursement_account_actual` SET TAGS ('dbx_business_glossary_term' = 'Port Disbursement Account (PDA) Actual');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_disbursement_account_actual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_disbursement_account_estimate` SET TAGS ('dbx_business_glossary_term' = 'Port Disbursement Account (PDA) Estimate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_disbursement_account_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_state_control_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Port State Control (PSC) Inspection Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_state_control_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Port State Control (PSC) Inspection Result');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `port_state_control_inspection_result` SET TAGS ('dbx_value_regex' = 'not_inspected|no_deficiency|deficiency_rectified|deficiency_pending|detention');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Port Call Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Port Call Remarks');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'BBL|M3|GAL|LTR');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `pipeline_throughput_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Throughput ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Receipt Measurement Point ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `co2_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Content Percent');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `ferc_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Tariff Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `fuel_gas_used_volume` SET TAGS ('dbx_business_glossary_term' = 'Fuel Gas Used Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `gas_heating_value_btu_per_scf` SET TAGS ('dbx_business_glossary_term' = 'Gas Heating Value British Thermal Units (BTU) per Standard Cubic Foot (SCF)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `gas_specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Gas Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `imbalance_status` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `imbalance_status` SET TAGS ('dbx_value_regex' = 'balanced|over_delivered|under_delivered|pending_resolution');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `imbalance_volume` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `line_loss_volume` SET TAGS ('dbx_business_glossary_term' = 'Line Loss Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'daily|monthly|weekly|hourly');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `metered_delivery_volume` SET TAGS ('dbx_business_glossary_term' = 'Metered Delivery Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `metered_receipt_volume` SET TAGS ('dbx_business_glossary_term' = 'Metered Receipt Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `metered_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Metered Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `metered_volume_uom` SET TAGS ('dbx_value_regex' = 'bbl|mcf|mmcf|m3|gal');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `nominated_volume` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `nominated_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `observed_pressure` SET TAGS ('dbx_business_glossary_term' = 'Observed Pressure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `observed_temperature` SET TAGS ('dbx_business_glossary_term' = 'Observed Temperature');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `operator_notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `phmsa_pipeline_code` SET TAGS ('dbx_business_glossary_term' = 'Pipeline and Hazardous Materials Safety Administration (PHMSA) Pipeline ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `pressure_uom` SET TAGS ('dbx_business_glossary_term' = 'Pressure Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `pressure_uom` SET TAGS ('dbx_value_regex' = 'psi|psig|psia|bar|kpa|mpa');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|disputed|adjusted|approved');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `shrinkage_volume` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percent');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `tariff_rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `tariff_rate_uom` SET TAGS ('dbx_value_regex' = 'usd_per_bbl|usd_per_mcf|usd_per_mmcf|usd_per_mmbtu');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_value_regex' = 'fahrenheit|celsius|kelvin');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `throughput_date` SET TAGS ('dbx_business_glossary_term' = 'Throughput Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `throughput_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Throughput Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `water_content_lbs_per_mmcf` SET TAGS ('dbx_business_glossary_term' = 'Water Content Pounds (LBS) per Million Cubic Feet (MMCF)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `lng_cargo_id` SET TAGS ('dbx_business_glossary_term' = 'Liquefied Natural Gas (LNG) Cargo Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Liquefaction Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Superintendent Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `charter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Charter Party Agreement Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Party Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Terminal Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `receiving_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Terminal Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `actual_boil_off_gas_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Boil-Off Gas (BOG) Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `actual_discharge_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Discharge Completion Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `actual_discharge_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Discharge Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `actual_discharged_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Actual Discharged Volume Cubic Meters (CBM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `actual_discharged_volume_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Actual Discharged Volume Million British Thermal Units (MMBTU)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `actual_loaded_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Actual Loaded Volume Cubic Meters (CBM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `actual_loaded_volume_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Actual Loaded Volume Million British Thermal Units (MMBTU)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `actual_loading_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Loading Completion Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `actual_loading_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Loading Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `boil_off_gas_estimate_percent` SET TAGS ('dbx_business_glossary_term' = 'Boil-Off Gas (BOG) Estimate Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `cargo_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Cargo Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `cargo_status` SET TAGS ('dbx_business_glossary_term' = 'Cargo Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `cargo_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Cargo Value United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `cargo_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `demurrage_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `demurrage_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `ethane_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Ethane Content Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `freight_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `freight_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `gross_heating_value_btu_per_scf` SET TAGS ('dbx_business_glossary_term' = 'Gross Heating Value British Thermal Units (BTU) per Standard Cubic Foot (SCF)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `heel_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Heel Volume Cubic Meters (CBM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `methane_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Methane Content Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `nitrogen_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Content Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `nominated_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume Cubic Meters (CBM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `nominated_volume_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume Million British Thermal Units (MMBTU)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `propane_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Propane Content Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `regasification_rate_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Regasification Rate Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `scheduled_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Discharge Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `scheduled_loading_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Loading Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `wobbe_index` SET TAGS ('dbx_business_glossary_term' = 'Wobbe Index');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Technician Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `base_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Base Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `base_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Base Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `calibration_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `custody_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `ferc_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `fiscal_measurement_flag` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Measurement Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `flow_direction` SET TAGS ('dbx_business_glossary_term' = 'Flow Direction');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `flow_direction` SET TAGS ('dbx_value_regex' = 'forward|reverse|bidirectional');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `flow_rate_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `flow_rate_unit_of_measure` SET TAGS ('dbx_value_regex' = 'bbl_per_day|bbl_per_hour|mcf_per_day|m3_per_hour|gal_per_min');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Location Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'terminal|pipeline|wellhead|fpso|refinery|processing_plant');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `maximum_flow_rate` SET TAGS ('dbx_business_glossary_term' = 'Maximum Flow Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `measurement_point_code` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `measurement_point_name` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `meter_factor` SET TAGS ('dbx_business_glossary_term' = 'Meter Factor (K-Factor)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `meter_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Meter Manufacturer');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `meter_model_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Model Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `meter_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Serial Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `meter_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size (Inches)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'turbine|ultrasonic|coriolis|orifice|positive_displacement|vortex');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `minimum_flow_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Flow Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|out_of_service|decommissioned');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `phmsa_meter_code` SET TAGS ('dbx_business_glossary_term' = 'Pipeline and Hazardous Materials Safety Administration (PHMSA) Meter Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `point_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `point_type` SET TAGS ('dbx_value_regex' = 'fiscal_meter|allocation_meter|check_meter|tank_gauge|wellhead_meter|custody_transfer_meter');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `pressure_compensation_flag` SET TAGS ('dbx_business_glossary_term' = 'Pressure Compensation Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `pressure_compensation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `pressure_compensation_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `proving_method` SET TAGS ('dbx_business_glossary_term' = 'Proving Method');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `proving_method` SET TAGS ('dbx_value_regex' = 'pipe_prover|tank_prover|master_meter|volumetric_prover');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `scada_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `temperature_compensation_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compensation Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `temperature_compensation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `temperature_compensation_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `uncertainty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` SET TAGS ('dbx_subdomain' = 'transport_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `rail_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Rail Waybill Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `waste_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Manifest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `actual_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `car_initial` SET TAGS ('dbx_business_glossary_term' = 'Rail Car Initial');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `car_initial` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `car_number` SET TAGS ('dbx_business_glossary_term' = 'Rail Car Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `destination_station_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `emergency_response_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Contact Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `emergency_response_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `emergency_response_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `emergency_response_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `emergency_response_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `emergency_response_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `freight_charges` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Class');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `hazmat_placard_required` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Placard Required Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `number_of_cars` SET TAGS ('dbx_business_glossary_term' = 'Number of Rail Cars');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `origin_station_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `origin_station_name` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `railroad_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Railroad Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `railroad_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `scheduled_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `scheduled_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `seal_numbers` SET TAGS ('dbx_business_glossary_term' = 'Seal Numbers');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `seal_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Seal Verification Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `seal_verification_status` SET TAGS ('dbx_value_regex' = 'verified|broken|missing|not_applicable');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `total_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `un_hazmat_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Hazardous Materials Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `un_hazmat_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'BBL|GAL|L|M3');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `waybill_date` SET TAGS ('dbx_business_glossary_term' = 'Waybill Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `waybill_number` SET TAGS ('dbx_business_glossary_term' = 'Waybill Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `waybill_status` SET TAGS ('dbx_business_glossary_term' = 'Waybill Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `waybill_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|in_transit|delivered|cancelled|disputed');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_value_regex' = 'LBS|KG|MT|TON');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `cargo_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Inspection Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Coordinator Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `port_call_id` SET TAGS ('dbx_business_glossary_term' = 'Port Call Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Company Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `bsw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Basic Sediment and Water (BS&W) Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `cargo_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Cargo Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `density_at_15c` SET TAGS ('dbx_business_glossary_term' = 'Density at 15 Degrees Celsius');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `draft_survey_result` SET TAGS ('dbx_business_glossary_term' = 'Draft Survey Result');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `draft_survey_result` SET TAGS ('dbx_value_regex' = 'pass|fail|inconclusive|not_performed');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `gross_observed_volume` SET TAGS ('dbx_business_glossary_term' = 'Gross Observed Volume (GOV)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `gross_standard_volume` SET TAGS ('dbx_business_glossary_term' = 'Gross Standard Volume (GSV)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_location_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_location_type` SET TAGS ('dbx_value_regex' = 'load_port|discharge_port|fpso|pipeline_custody_transfer_point|storage_terminal|vessel_at_sea');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_purpose` SET TAGS ('dbx_business_glossary_term' = 'Inspection Purpose');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_purpose` SET TAGS ('dbx_value_regex' = 'custody_transfer|quality_verification|regulatory_compliance|dispute_resolution|insurance_claim|routine_monitoring');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_remarks` SET TAGS ('dbx_business_glossary_term' = 'Inspection Remarks');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|disputed');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `net_standard_volume` SET TAGS ('dbx_business_glossary_term' = 'Net Standard Volume (NSV)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `observed_pressure` SET TAGS ('dbx_business_glossary_term' = 'Observed Pressure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `observed_temperature` SET TAGS ('dbx_business_glossary_term' = 'Observed Temperature');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `pressure_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Pressure Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `pressure_unit_of_measure` SET TAGS ('dbx_value_regex' = 'PSI|BAR|KPA|MPA');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `quality_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Claim Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `quantity_variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `seal_numbers` SET TAGS ('dbx_business_glossary_term' = 'Seal Numbers');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `seal_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Seal Verification Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `seal_verification_status` SET TAGS ('dbx_value_regex' = 'intact|broken|missing|not_applicable');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `sulfur_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `temperature_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `temperature_unit_of_measure` SET TAGS ('dbx_value_regex' = 'F|C|K');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `ullage_measurement` SET TAGS ('dbx_business_glossary_term' = 'Ullage Measurement');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `variance_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Tolerance Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'BBL|M3|GAL|L');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` SET TAGS ('dbx_association_edges' = 'logistics.terminal,customer.customer_counterparty');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `terminal_access_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Access Agreement ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Access Agreement - Customer Counterparty Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Access Agreement - Terminal Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `access_rights_type` SET TAGS ('dbx_business_glossary_term' = 'Access Rights Type');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `allocated_capacity_bbl` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity BBL');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `minimum_throughput_commitment_bopd` SET TAGS ('dbx_business_glossary_term' = 'Minimum Throughput Commitment BOPD');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `nomination_rights` SET TAGS ('dbx_business_glossary_term' = 'Nomination Rights');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ALTER COLUMN `tariff_rate_override` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Override');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` SET TAGS ('dbx_association_edges' = 'logistics.carrier,product.petroleum_product');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `carrier_product_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Product Authorization ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Product Authorization - Carrier Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Product Authorization - Petroleum Product Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `approved_product_types` SET TAGS ('dbx_business_glossary_term' = 'Approved Product Types');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `handling_rate_capability` SET TAGS ('dbx_business_glossary_term' = 'Handling Rate Capability');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `hazmat_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Certification Level');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `insurance_coverage_limit` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Limit');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` SET TAGS ('dbx_association_edges' = 'petrochemical.product_catalog,logistics.carrier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `carrier_product_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Product Approval ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Product Approval - Carrier Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Product Approval - Petchem Product Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `certification_authority` SET TAGS ('dbx_business_glossary_term' = 'Certification Authority');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `hazmat_endorsement_number` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Endorsement Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `product_handling_certification` SET TAGS ('dbx_business_glossary_term' = 'Product Handling Certification');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` SET TAGS ('dbx_association_edges' = 'logistics.vessel,product.petroleum_product');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `vessel_cargo_compatibility_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Cargo Compatibility ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Cargo Compatibility - Petroleum Product Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Cargo Compatibility - Vessel Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `cargo_compatibility_rating` SET TAGS ('dbx_business_glossary_term' = 'Cargo Compatibility Rating');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `contamination_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Contamination Risk Level');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `heating_capability_required` SET TAGS ('dbx_business_glossary_term' = 'Heating Capability Required');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `last_cargo_carried_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cargo Carried Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `max_cargo_quantity_bbl` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cargo Quantity Barrels');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `segregation_capability` SET TAGS ('dbx_business_glossary_term' = 'Segregation Capability');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `tank_coating_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Tank Coating Compatibility');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `vetting_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Vetting Approval Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `vetting_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Vetting Approval Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ALTER COLUMN `vetting_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Vetting Expiry Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` SET TAGS ('dbx_association_edges' = 'logistics.carrier,commercial.term_contract');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `carrier_contract_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Engagement ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Engagement - Carrier Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Engagement - Term Contract Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `approved_product_types` SET TAGS ('dbx_business_glossary_term' = 'Approved Product Types for Engagement');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `approved_routes` SET TAGS ('dbx_business_glossary_term' = 'Approved Routes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `capacity_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Allocation Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Engagement Effective Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Engagement Expiry Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Transportation Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Record Created Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Engagement Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `insurance_requirement_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Met Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Engagement Record Last Modified By');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Record Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `on_time_delivery_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Target Percentage');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payment Terms Days');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `performance_bond_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `primary_carrier_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier Flag');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `transit_time_commitment_hours` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Commitment');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Carrier Volume Commitment');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `volume_commitment_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Engagement Record Created By');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `tax_entity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `tax_entity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `parent_shipper_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo` ALTER COLUMN `cargo_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo` ALTER COLUMN `parent_cargo_id` SET TAGS ('dbx_self_ref_fk' = 'true');
