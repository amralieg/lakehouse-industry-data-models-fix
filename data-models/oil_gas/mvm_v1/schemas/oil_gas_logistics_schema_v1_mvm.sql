-- Schema for Domain: logistics | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`logistics` COMMENT 'Manages transportation and movement of crude oil, natural gas, LNG, LPG, NGLs, and refined products across pipelines, tankers, trucks, and rail. Owns shipping schedules, pipeline nominations, FPSO liftings, custody transfer records, tariff rates, delivery scheduling, and carrier management. Aligns with PHMSA pipeline safety regulations and FERC tariff reporting requirements. Integrates with SCADA pipeline monitoring systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment record. Primary key for the shipment entity.',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: A shipment is the physical execution of a cargo nomination. Schedulers must reconcile nominated vs. actual shipment volumes, laycan compliance, and quality against the originating nomination. This is ',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier or service provider responsible for moving the shipment. Links to carrier/vendor master data.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Shipments are executed for/to specific customers. Essential for revenue recognition, customer service tracking, delivery performance monitoring, and customer satisfaction reporting. Oil & gas operatio',
    `customer_term_contract_id` BIGINT COMMENT 'Foreign key linking to customer.customer_term_contract. Business justification: Shipments are executed under customer term contracts governing pricing, volume, and delivery terms. Required for contract performance tracking, minimum offtake monitoring, and pricing formula applicat',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Shipments are delivered to a specific customer delivery point. destination_location_name is a denormalization of delivery_point. Used in transportation planning, delivery confirmation, and tariff calc',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility, terminal, refinery, or delivery point where the shipment is destined. Links to facility master data.',
    `eor_scheme_id` BIGINT COMMENT 'Foreign key linking to reservoir.eor_scheme. Business justification: Shipments of EOR injectants (CO2, polymer, steam condensate) are tied to a specific EOR scheme for supply chain traceability and CAPEX/OPEX cost allocation. A reservoir/logistics engineer expects inje',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Shipments generate invoices — the shipment is the physical delivery event and the invoice is the billing document. This is one of the most fundamental logistics-to-revenue links in oil & gas. Shipment',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Shipments from joint venture assets require JOA reference for partner cost allocation, lifting entitlement reconciliation, custody transfer validation, and JIB billing. Essential for overlift/underlif',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Crude/gas shipments originate from leased production areas. Operators must track originating lease for royalty calculation, revenue allocation to working interest owners, and JIB statement preparation',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: Each equity crude shipment by a JOA/PSA partner executes against a specific lifting entitlement. This link is required for over/underlift reconciliation reports and partner equity accounting — a funda',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Shipments are executed against customer nominations in oil-and-gas trading operations. Used in nomination-to-shipment reconciliation, nomination status updates, and cargo tracking. Domain experts expe',
    `overlift_underlift_id` BIGINT COMMENT 'Foreign key linking to venture.overlift_underlift. Business justification: Shipment volumes are the primary input to overlift/underlift position calculations. Linking shipment to the overlift_underlift record provides the audit trail from physical cargo movement to imbalance',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Shipments of hazardous crude/refined products require environmental and transport permits. Operations verify permit validity before authorizing shipment. Real-world compliance tracking links each ship',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Shipments represent product movements that impact profit center P&L through freight costs and revenue realization, required for segment reporting and profitability analysis.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA-governed shipments must distinguish cost recovery oil/gas from profit oil/gas for contractor/government entitlement calculation, fiscal regime compliance, and government take reporting. Critical f',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Shipments must comply with destination quality specifications (refinery intake specs, export terminal specs). The quality_spec defines acceptance criteria against which the shipment is measured, drivi',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Crude oil and gas shipments must track source reservoir for custody transfer documentation, royalty calculations, production accounting, and PSA/JOA revenue allocation. Essential for fiscal metering a',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: Equipment and consumables (drill bits, BHA components, mud additives, fuel) are shipped directly to rig locations, especially offshore. Enables rig-specific logistics tracking, supply vessel schedulin',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to product.safety_data_sheet. Business justification: Petroleum product shipments require the SDS as a mandatory transport document per DOT/IMDG/ADR hazmat regulations. The SDS must accompany the cargo for emergency response, customs clearance, and carri',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Shipments fulfill sales orders. The order-to-cash process requires linking shipment execution directly to the sales order for billing trigger, revenue recognition, and order fulfillment status. voyage',
    `well_test_id` BIGINT COMMENT 'Foreign key linking to reservoir.well_test. Business justification: Extended well test (EWT) operations produce hydrocarbons that are shipped via tanker or truck. The shipment record for EWT cargo must reference the well_test for revenue recognition, regulatory report',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment arrived at the destination facility. Used for on-time delivery metrics and demurrage calculations.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment departed from the origin facility. Critical for performance tracking and demurrage calculations.',
    `actual_volume` DECIMAL(18,2) COMMENT 'Actual quantity of product shipped as measured at custody transfer point. May differ from nominated volume due to operational constraints or measurement adjustments.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement of the crude oil or petroleum product, indicating its density relative to water. Critical quality parameter for pricing and refining yield calculations.',
    `bill_of_lading_number` STRING COMMENT 'Unique document number for the bill of lading or waybill that serves as the legal contract of carriage and receipt for the shipment. Required for custody transfer and legal compliance.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `bsw_percentage` DECIMAL(18,2) COMMENT 'Percentage of basic sediment and water content in the crude oil shipment. Critical quality parameter affecting net volume calculations and product value.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment record was first created in the system. Used for audit trail and data lineage tracking.',
    `custody_transfer_status` STRING COMMENT 'Status of the custody transfer process indicating whether ownership and responsibility for the product has been formally transferred at origin and destination measurement points.. Valid values are `pending|origin_transferred|in_transit|destination_received|completed|disputed`',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: A pipeline nomination is submitted to a pipeline operator (carrier). The carrier in pipeline context is the pipeline operator who transports the nominated volumes. Linking pipeline_nomination to carri',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_term_contract. Business justification: Pipeline nominations are made under commercial term contracts that specify transportation rates, volume commitments, and product specifications. FERC tariff compliance and take-or-pay volume tracking ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pipeline nominations may incur imbalance costs or penalties requiring cost center allocation for pipeline operations accounting and transportation expense tracking.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Pipeline nominations identify the shipper/customer counterparty for FERC reporting, tariff billing, and imbalance tracking. shipper_contact_name/email/phone are denormalizations of the customer_counte',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Pipeline nominations for crude specify the grade being nominated, as pipeline tariff rates, quality banking rules, and proration calculations are grade-specific. FERC/PHMSA reporting requires grade-le',
    `delivery_point_id` BIGINT COMMENT 'Identifier of the physical location or delivery point where the product will exit the pipeline system after transportation.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Pipeline nominations from joint venture fields require JOA reference for partner entitlement allocation, nomination rights verification, tariff cost sharing, and capacity allocation per working intere',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Pipeline nominations specify originating lease for production transported through pipelines. Required for tariff billing allocation, royalty owner revenue distribution, FERC/PHMSA regulatory reporting',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Pipeline operations require operating permits from FERC/state agencies. Nominations must reference the permit authorizing transport on that segment. Compliance teams verify permit coverage before acce',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Pipeline nominations specify exact product being transported through pipeline system; FK needed for FERC tariff rate application, quality specification enforcement, contract compliance verification, a',
    `pipeline_segment_id` BIGINT COMMENT 'Identifier of the specific pipeline segment or route through which the product will be transported.',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Pipeline nominations are submitted for volumes from specific production facilities as the receipt point. This link is required for gas balancing, FERC tariff compliance, and facility-level nomination ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Pipeline nominations represent product movements that impact profit center economics through transportation costs and product delivery performance.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Pipeline nominations must reference the applicable quality specification (pipeline tariff quality requirements) to validate that nominated product meets pipeline acceptance criteria. FERC tariff compl',
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
    `transportation_rate` DECIMAL(18,2) COMMENT 'The tariff rate charged for transporting the product through the pipeline, typically expressed per unit volume (e.g., dollars per barrel or dollars per MCF).',
    `transportation_rate_uom` STRING COMMENT 'Unit of measure for the transportation rate, such as USD per barrel for crude oil or USD per thousand cubic feet for natural gas.. Valid values are `USD_per_BBL|USD_per_MCF|USD_per_MMCF`',
    `water_content_lbs_per_mmcf` DECIMAL(18,2) COMMENT 'The water content in the gas stream measured in pounds per million cubic feet, critical for preventing hydrate formation and pipeline corrosion.',
    CONSTRAINT pk_pipeline_nomination PRIMARY KEY(`pipeline_nomination_id`)
) COMMENT 'Transactional record of a shippers nomination to move a specified volume of crude oil or natural gas through a pipeline segment during a scheduling cycle. Captures nomination reference, shipper ID, pipeline segment, nomination cycle (intraday, daily, monthly), nominated volume (BOPD or MMCFD), confirmed volume, priority class, gas quality specifications, nomination status (submitted, confirmed, cut, scheduled), FERC tariff code, and PHMSA pipeline ID. Integrates with SCADA pipeline monitoring and FERC tariff reporting requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` (
    `logistics_lifting_schedule_id` BIGINT COMMENT 'Unique identifier for the logistics lifting schedule record. Primary key for the lifting schedule master planning entity.',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Logistics lifting schedules are operationalized from cargo nominations. Schedulers need to trace each lifting slot back to the originating nomination for entitlement reconciliation, overlift/underlift',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Lifting schedules coordinate customer offtake under PSAs and JOAs. Essential for entitlement tracking, customer relationship management, and equity allocation. Links operational lifting plans to custo',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Lifting schedules are organized by crude grade — each lifting slot is assigned a specific grade for vessel compatibility, destination refinery requirements, and PSA/JOA entitlement allocation. Grade-l',
    `field_id` BIGINT COMMENT 'FK to production.field',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Lifting schedules for JV production require JOA reference for partner nomination rights, laycan allocation, overlift/underlift tracking, and equity holder cargo assignment. Drives partner-level liftin',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Lifting schedules are structured around lease production entitlements and JOA lifting rights. O&G land and commercial teams allocate lifting volumes by lease for royalty calculation, production entitl',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: Equity lifting scheduling: the logistics lifting schedule is the operational execution plan for a partners lifting entitlement under JOA/PSA. Linking these enables over/underlift monitoring and entit',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Lifting schedules for offshore platforms, FPSOs, and onshore tank farms must reference the originating asset facility directly — not just a terminal — for production-logistics integration, JOA entitle',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Lifting schedules plan loading of specific petroleum products from FPSOs; FK required for vessel compatibility verification, quality planning, pricing determination, and cargo optimization. Product_ty',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Lifting schedules are tied to specific production facilities (FPSOs, offshore platforms) where cargo is loaded. This is a fundamental operational link for cargo scheduling, berth planning, and FPSO li',
    `production_forecast_id` BIGINT COMMENT 'Foreign key linking to reservoir.production_forecast. Business justification: Monthly cargo lifting schedules are derived from the reservoir production forecast. Planners need to trace which forecast underpins each lifting program for JOA entitlement allocation, PSA lifting rig',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Liftings represent crude oil sales that must be tracked by profit center for upstream revenue recognition, production performance, and segment reporting.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA lifting schedules determine contractor vs government entitlement liftings, cost recovery cargo allocation, and profit oil/gas splits. Essential for PSA fiscal regime compliance and government take',
    `revenue_allocation_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_allocation. Business justification: Lifting schedules drive partner entitlement-based revenue allocation in PSA/JOA environments. The schedule determines which partner lifts what volume, directly feeding overlift/underlift revenue_alloc',
    `shipping_schedule_id` BIGINT COMMENT 'Foreign key linking to logistics.shipping_schedule. Business justification: A logistics lifting schedule is a component of the broader shipping schedule. The shipping_schedule is the master planning entity for all vessel movements, while logistics_lifting_schedule governs ind',
    `vessel_id` BIGINT COMMENT 'FK to logistics.vessel',
    `api_gravity` DECIMAL(18,2) COMMENT 'The API gravity of the crude oil or liquid hydrocarbon being lifted, measured in degrees API. Indicates the density and quality of the crude, affecting pricing, refining yield, and transportation requirements.',
    `approval_date` DATE COMMENT 'The date on which this lifting schedule version was formally approved by the authorized planning or operations manager. Marks the transition from draft to approved status.',
    `approved_by` STRING COMMENT 'Name or identifier of the manager, planner, or authorized person who approved this lifting schedule version. Provides accountability for schedule commitments.',
    `berth_assignment` STRING COMMENT 'The specific berth, jetty, or loading terminal position assigned for this lifting operation. Identifies the physical loading point at the FPSO, offshore terminal, or onshore export facility.',
    `bill_of_lading_number` STRING COMMENT 'The unique identifier for the bill of lading document issued for this cargo lifting. Serves as the legal receipt and title document for the transported hydrocarbons.',
    `cargo_number` STRING COMMENT 'Unique identifier for the specific cargo or parcel of crude oil, LNG, LPG, or NGL being lifted. Used for custody transfer tracking and bill of lading reconciliation.',
    `charter_party_type` STRING COMMENT 'The type of vessel charter agreement governing this lifting. Voyage charter for single-trip hire; time charter for vessel hire over a period; bareboat charter for vessel lease without crew. Determines cost allocation and operational responsibility.. Valid values are `voyage|time|bareboat`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lifting schedule record was first created in the system. Provides audit trail for schedule planning lifecycle.',
    `custody_transfer_method` STRING COMMENT 'The method used to measure and verify the volume of hydrocarbons transferred during the lifting operation. Metered for flow meter measurement; gauged for tank level measurement; calculated for derived volumes from multiple measurements. Determines the basis for commercial settlement and revenue allocation.. Valid values are `metered|gauged|calculated`',
    `demurrage_rate_usd_per_day` DECIMAL(18,2) COMMENT 'The daily rate charged if the vessel is detained beyond the agreed laytime for loading or unloading operations, measured in USD per day. Represents the financial penalty for delays in cargo operations.',
    `destination_port` STRING COMMENT 'Name of the destination port, refinery, or receiving terminal where the cargo will be delivered. Identifies the endpoint of the marine transportation leg.',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Custody transfer records must identify the receiving customer account for accounts receivable posting, revenue recognition, and credit exposure monitoring. Domain experts expect the customer account o',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Custody transfer is the physical settlement event for a cargo nomination. Oil & gas schedulers and traders reconcile nominated vs. actual transferred volumes per nomination for invoicing and demurrage',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Custody transfer records the handover of petroleum product to a specific customer counterparty. Required for royalty calculation, revenue recognition, regulatory reporting, and quality claim managemen',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Custody transfer of crude oil requires grade identification for pricing differential application, royalty/fiscal measurement calculations, and quality acceptance at the transfer point. Grade determine',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Custody transfer occurs at a specific delivery point where metering and quality inspection take place. Required for fiscal metering compliance, regulatory reporting, and tariff calculation. Domain exp',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Custody transfer of wellhead production must reference the producing well for royalty calculation, production allocation to JV partners, and regulatory production reporting. Operators and regulators r',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Custody transfer events generate invoices for the transferred volumes. The invoice captures billing for the physical title transfer. This is a core accounts-receivable process — custody transfer compl',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Custody transfers at joint venture measurement points drive partner volumetric allocation, JIB cost recovery, imbalance tracking, and royalty calculation. JOA reference enables proper partner entitlem',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Custody transfer events (meter tickets, pipeline receipts) must reference originating lease for royalty disbursement calculation, revenue allocation to interest owners, and audit trail compliance. Cor',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: Custody transfer is the authoritative measurement event that fulfills a partners lifting entitlement. Linking these supports entitlement reconciliation, imbalance calculation, and royalty/profit-oil ',
    `lng_cargo_id` BIGINT COMMENT 'Foreign key linking to logistics.lng_cargo. Business justification: An LNG cargo undergoes custody transfer at both the loading terminal (liquefaction) and the receiving terminal (regasification). Linking custody_transfer to lng_cargo enables direct traceability betwe',
    `logistics_lifting_schedule_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_lifting_schedule. Business justification: A custody transfer is the fiscal measurement event that validates a planned lifting. Linking custody_transfer to logistics_lifting_schedule enables comparison of planned lifting volumes against actual',
    `overlift_underlift_id` BIGINT COMMENT 'Foreign key linking to venture.overlift_underlift. Business justification: Custody transfer volumes are the metered basis for overlift/underlift calculations. Linking custody_transfer to overlift_underlift provides the authoritative measurement traceability required for imba',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Custody transfers record ownership change of specific petroleum products; FK essential for product valuation, royalty calculation, JIB allocation, quality reconciliation against specifications, and fi',
    `pipeline_nomination_id` BIGINT COMMENT 'Reference to the pipeline nomination or scheduling request that authorized this custody transfer, used for pipeline capacity allocation and FERC reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Custody transfers represent revenue/cost events that impact profit center P&L through product sales, royalty calculations, and JIB allocations.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA custody transfers determine cost oil vs profit oil volumes for contractor/government splits, cost recovery ceiling compliance, and fiscal regime reporting. Essential for international upstream fis',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Custody transfer quality verification requires the applicable quality specification to determine pass/fail status, trigger quality claims, and support fiscal measurement compliance. The quality_spec d',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Custody transfer events require source reservoir tracking for joint venture accounting, revenue allocation, and regulatory compliance. Critical for PSA entitlement calculations and SEC reserves reconc',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: A custody transfer records the official transfer of title and custody of petroleum products, which occurs as part of a shipment movement. Linking custody_transfer to shipment enables reconciliation be',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: A vessel is operated by a carrier (shipping company). vessel currently has operator_company (STRING) which is a denormalized string reference to the operating company. Replacing this with carrier_id F',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Vessels maintain shipboard oil pollution emergency plans (SOPEP). Vessel references current plan for IMO compliance and port state control inspections.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Owned/leased vessels are capitalized fixed assets requiring depreciation tracking, asset retirement obligations, impairment testing, and balance sheet reporting per GAAP/IFRS. SEC reserve reporting an',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to product.safety_data_sheet. Business justification: Vessels carrying petroleum products must have the applicable SDS on board per SOLAS/MARPOL requirements. The SDS governs emergency response procedures, cargo handling, and port state control inspectio',
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
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: A voyage executes a cargo nomination. Marine operations teams track laycan compliance, demurrage, and freight settlement against the originating nomination. This link is essential for voyage P&L repor',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: A voyage is operated by a carrier (shipping company or vessel operator). voyage has charter_party_reference (STRING) but no FK to the carrier master entity. Adding carrier_id normalizes the carrier re',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Voyages are executed for a specific cargo buyer/charterer counterparty. Required for freight invoicing, demurrage claim issuance, voyage P&L reporting, and charter party management. A voyage P&L repor',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Voyages carrying crude reference a specific grade for freight rate calculation (grade-specific freight differentials), laytime calculation, and commercial settlement. Voyage P&L reporting and demurrag',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Voyage costs and revenues post to specific GL accounts for financial statement preparation, freight expense recognition, and demurrage/despatch accounting.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Voyages carrying JV crude/LNG require JOA reference for demurrage cost allocation to partners, freight cost sharing, and partner cargo tracking. Drives JIB billing for voyage-related costs and partner',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: A voyage transports a partners equity crude cargo against their lifting entitlement. Linking voyage to lifting_entitlement enables the commercial/venture team to confirm entitlement fulfillment per v',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: A voyage begins at a loading terminal where cargo is taken on board. Linking voyage to the loading terminal enables port charge calculation, berth scheduling, laytime tracking, and terminal throughput',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Voyages are chartered to fulfill specific customer cargo nominations in oil-and-gas. The nomination drives laycan, vessel assignment, and loading port. Used in voyage management, demurrage settlement,',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Voyages generate profit/loss that must be tracked by profit center for crude marketing performance, segment reporting, and voyage economics analysis.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Voyages trigger customs declarations and export filings. Voyage records link to the regulatory filing for audit trail, ensuring all international voyages are properly reported to customs authorities a',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Voyages execute sales order deliveries (especially spot cargoes and FOB sales). Critical for delivery performance tracking, demurrage/despatch allocation to sales transactions, customer-specific freig',
    `shipping_schedule_id` BIGINT COMMENT 'Foreign key linking to logistics.shipping_schedule. Business justification: A voyage is the execution of a planned vessel movement within a shipping schedule. Linking voyage to shipping_schedule establishes the plan-to-execution hierarchy: shipping_schedule (master plan) -> v',
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
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Terminal facilities are built on land parcels governed by leases. O&G land departments track which lease covers a terminals footprint for delay rental payments, lease compliance, HBP status, and land',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Terminals operate under specific operating licenses issued by state/federal agencies. Compliance teams track license status per terminal for renewal management and regulatory inspections. Real-world o',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Terminal records carry operator_name as a plain denormalized text attribute. Linking to land.operator (the canonical operator registry) supports regulatory reporting, license tracking, and operator pe',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Terminals require multiple permits (air quality, water discharge, SPCC, operating license). Compliance teams track primary permit per terminal for renewal management and inspection scheduling. Real-wo',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Terminals typically have primary product specialization affecting tariff rates, storage design, safety protocols, and operational procedures; FK enables terminal classification, tariff determination, ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Terminals generate throughput revenue and incur costs, requiring profit center assignment for P&L tracking, segment reporting, and asset profitability analysis.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Terminals enforce specific quality specifications for product receipt and delivery. Terminal operators reference the applicable quality spec to accept or reject incoming cargoes, ensuring pipeline/exp',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Terminal sites require surface use agreements with surface owners governing access, compensation, and reclamation obligations. O&G land departments maintain SUA records for terminal sites; linking ter',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`delivery_order` (
    `delivery_order_id` BIGINT COMMENT 'Unique system identifier for the delivery order record. Primary key.',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Delivery orders authorize physical product release against a cargo nomination. In oil & gas terminal operations, the delivery order is issued per nomination; linking them enables volume authorization ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: A delivery order specifies which carrier will execute the delivery. delivery_order currently has carrier_reference (STRING) which is a denormalized string reference to the carrier. Replacing this with',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Delivery orders for crude specify the grade to be delivered, determining pricing differentials, quality acceptance criteria at the delivery point, and contract compliance verification. Grade identific',
    `delivery_point_id` BIGINT COMMENT 'Reference to the terminal, storage facility, or custody transfer point where product will be released. Links to facility or location master data.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Delivery orders for drilling materials (casing, mud chemicals, completion equipment) are issued against specific wells for well cost management and AFE tracking. Direct well reference on delivery_orde',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Delivery orders for JV production require JOA reference for entitlement verification, partner authorization, and lifting rights validation. Ensures delivery volumes align with partner working interest',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Delivery orders authorize product release against a leases production entitlement. O&G land and revenue teams require lease context on delivery orders for royalty allocation, severance tax reporting,',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: A delivery order authorizes product release against a partners lifting entitlement. Linking these ensures the authorized volume is tracked against the entitlement record, supporting entitlement utili',
    `logistics_lifting_schedule_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_lifting_schedule. Business justification: A delivery order is often issued against a specific lifting schedule in FPSO and terminal operations. The lifting schedule governs the planned liftings, and delivery orders are the execution documents',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Delivery orders authorize physical delivery against a customer nomination. nomination_reference_number on delivery_order is a denormalization of the nomination PK. Used in nomination fulfillment track',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Delivery orders for regulated products require permits (export license, hazmat transport). Operations verify permit coverage before authorizing delivery. Real-world compliance tracking links each orde',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Delivery orders authorize delivery of specific petroleum products; FK required for pricing basis determination, quality specification enforcement, regulatory permit validation, incoterms application, ',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Delivery orders specify the production facility from which product is to be released and delivered. This link is required for cargo scheduling, entitlement management, and facility-level delivery trac',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Delivery orders represent product sales/transfers that impact profit center revenue through product deliveries and customer fulfillment.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Delivery orders specify quality requirements for the product to be delivered. The existing quality_specification_reference plain-text column is a denormalized representation of quality_spec. This FK r',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: Delivery orders for drilling supplies specify the rig as the physical delivery destination. Rig-level delivery tracking is essential for supply chain management, rig inventory control, and logistics c',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Delivery orders are issued to fulfill sales orders in oil & gas product distribution. The order-to-cash process requires linking delivery authorization to the originating sales order for billing, reve',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: A delivery order authorizes the release and delivery of petroleum products, and is fulfilled by a specific shipment. Adding shipment_id to delivery_order creates the execution link between the authori',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the delivery order was officially approved for execution. Represents a key lifecycle event for audit and compliance.',
    `authorized_volume` DECIMAL(18,2) COMMENT 'Total quantity of product authorized for delivery under this order. Measured in the unit specified by volume_unit_of_measure.',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading or shipping document number issued for this delivery. Serves as receipt and title document for transported goods.',
    `cancellation_date` DATE COMMENT 'Date when the delivery order was officially cancelled. Populated only when delivery_status = cancelled.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the delivery order was cancelled, if applicable. Populated only when delivery_status = cancelled.',
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
    `notes` STRING COMMENT 'General free-text notes or comments related to this delivery order. Used for operational coordination and documentation of special circumstances.',
    `payment_terms` STRING COMMENT 'Contractual payment terms governing settlement for this delivery (e.g., Net 30, COD, Letter of Credit, Prepaid). Defines timing and method of payment.',
    `price_differential` DECIMAL(18,2) COMMENT 'Plus or minus adjustment to the pricing basis index, expressed in currency per unit. Represents quality, location, or contractual adjustments to benchmark pricing.',
    `pricing_basis` STRING COMMENT 'Index or benchmark used for pricing this delivery. WTI = West Texas Intermediate, Brent = Brent Crude, Platts = Platts pricing service, Argus = Argus Media pricing, NYMEX = New York Mercantile Exchange, ICE = Intercontinental Exchange. [ENUM-REF-CANDIDATE: wti|brent|platts|argus|nymex|ice|fixed — 7 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Business priority classification for scheduling and execution of this delivery order. Influences allocation of transportation capacity and terminal slots.. Valid values are `standard|high|urgent|critical`',
    `regulatory_permit_number` STRING COMMENT 'Reference to any regulatory permit or authorization required for this delivery (e.g., EPA transport permit, PHMSA pipeline authorization, export license).',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling, safety, or operational instructions for this delivery (e.g., temperature control, inert gas blanketing, H2S precautions).',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for product delivery. FPSO = Floating Production Storage and Offloading vessel.. Valid values are `pipeline|tanker|truck|rail|barge|fpso`',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for the authorized volume. BBL = Barrels, MT = Metric Tons, GAL = Gallons, M3 = Cubic Meters, MMBTU = Million British Thermal Units, MCF = Thousand Cubic Feet.. Valid values are `BBL|MT|GAL|M3|MMBTU|MCF`',
    CONSTRAINT pk_delivery_order PRIMARY KEY(`delivery_order_id`)
) COMMENT 'Transactional document authorizing the release and delivery of a specified quantity of petroleum product from a terminal or storage facility to a buyer or consignee. Captures delivery order number, issuance date, seller or terminal operator, buyer or consignee, product type and grade, authorized volume (BBL or MT), delivery window start and end, delivery point, transport mode, carrier reference, pricing basis (WTI, Brent, Platts), price differential, payment terms, and delivery status (issued, partially delivered, completed, cancelled). Links to custody transfer and commercial contracts.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Unique identifier for the transportation carrier. Primary key for the carrier master data entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carrier management activities (vetting, audits) incur costs that must be allocated to cost centers for logistics administration expense tracking.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` (
    `shipping_schedule_id` BIGINT COMMENT 'Unique identifier for the shipping schedule. Primary key for the shipping schedule master planning entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shipping schedule planning activities incur costs that must be allocated to cost centers for logistics planning expense tracking and operations overhead management.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Shipping schedules are prepared for specific customer counterparties under term lifting programs. Used in annual lifting program planning, customer entitlement allocation, and schedule publication. Do',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` (
    `storage_inventory_id` BIGINT COMMENT 'Unique identifier for the storage inventory transaction record. Primary key for the storage inventory product.',
    `accrual_id` BIGINT COMMENT 'Foreign key linking to revenue.accrual. Business justification: Storage inventory valuations drive revenue accruals — for inventory sold but not yet delivered (bill-and-hold) or for storage fee revenue at period end. Finance accrues revenue referencing the invento',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory storage costs (tank rental, heating, losses) must be charged to cost centers for working capital management, LOE tracking, and operational expense control.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Tank inventory management requires crude grade identification to prevent commingling, support inventory valuation at grade-specific prices, and enable blending optimization. Terminal operators track w',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Storage inventory records are tank-specific. Linking to the equipment record for that tank enables tank integrity management, calibration certificate tracking, and API 653 inspection scheduling. tank_',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Joint venture storage inventory requires JOA reference for partner ownership allocation, working capital valuation per partner, and inventory imbalance tracking. Drives partner-level balance sheet rep',
    `measurement_point_id` BIGINT COMMENT 'Foreign key linking to logistics.measurement_point. Business justification: Storage inventory tracks daily inventory positions measured at specific physical or fiscal measurement locations. Linking storage_inventory to measurement_point establishes which meter or gauge is use',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Storage tanks require permits (air emissions, SPCC, tank registration). Inventory records reference the permit authorizing storage. Real-world operations link inventory to permit for compliance verifi',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Storage inventory tracks specific petroleum products in tanks; FK essential for inventory valuation, working capital calculation, quality monitoring against specifications, loss/gain analysis, and fin',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Storage inventory at terminals receives product from production facilities. Linking storage_inventory to production_facility enables production-to-inventory reconciliation, facility throughput trackin',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Inventory positions impact profit center working capital and must be valued for segment reporting, crude marketing performance, and balance sheet management.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Storage inventory quality management requires reference to the applicable quality specification to flag out-of-spec inventory, trigger blending or remediation actions, and support regulatory reporting',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` (
    `pipeline_throughput_id` BIGINT COMMENT 'Unique identifier for the pipeline throughput record. Primary key for this transactional entity capturing daily or monthly measured volumes on pipeline segments.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_term_contract. Business justification: Pipeline throughput volumes must be reconciled against commercial term contract volume commitments for FERC reporting, take-or-pay compliance, and tariff billing. This link is required for monthly vol',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pipeline throughput operations incur costs (compression, pumping, losses) requiring cost center allocation for pipeline operations accounting and FERC reporting.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Pipeline throughput records require crude grade for quality banking, imbalance resolution, and PHMSA regulatory reporting. The existing product_grade plain-text column is a denormalized representation',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Pipeline throughput records deliveries at specific customer delivery points. Required for gas balancing, imbalance reporting, FERC tariff billing, and customer delivery confirmation. Domain experts ex',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pipeline throughput revenues post to specific GL accounts for transportation revenue recognition, FERC compliance, and financial statement preparation.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Pipeline throughput is the metered basis for FERC-regulated tariff invoices and interruptible transportation invoices. The throughput record drives the invoice for transportation services rendered. Pi',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Throughput measurement at JV delivery points drives partner entitlement calculations, imbalance tracking, and JIB cost allocation. JOA reference enables working interest-based volume splits and tariff',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Pipeline throughput measurements must tie to originating leases for production allocation, royalty calculation, and reconciliation of lease production with pipeline volumes. Enables lease-level accoun',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Pipeline throughput requires operating permits from FERC/state agencies. Throughput records reference the permit authorizing transport. Compliance teams verify permit coverage for all throughput, ensu',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Pipeline throughput records actual measured volumes on a pipeline segment, while pipeline_nomination records the shippers nominated volumes. These are directly related: throughput is the actuals agai',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: PHMSA reporting, tariff billing, and integrity management all require throughput volumes tied to a specific pipeline segment. Every metered throughput record must reference the physical segment it tra',
    `measurement_point_id` BIGINT COMMENT 'Identifier of the custody transfer measurement point where the product entered the pipeline segment. Links to the measurement point registry.',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Pipeline throughput records track volumes flowing from production facilities through pipelines. The production_facility is the receipt/origin point for pipeline throughput — required for production-to',
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
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: LNG cargoes are the physical execution of LNG cargo nominations. Volume reconciliation, boil-off gas accounting, demurrage calculation, and invoice generation all require linking the LNG cargo record ',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: LNG cargo buyer must be identified for revenue recognition, cargo valuation, SPA compliance, and regulatory reporting. Domain experts expect the buying counterparty on every LNG cargo record for invoi',
    `delivery_order_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_order. Business justification: An LNG cargo is authorized for delivery by a delivery order. The delivery order specifies the authorized volume, delivery window, and incoterms for the LNG cargo delivery. Linking lng_cargo to deliver',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: LNG cargo revenues and costs post to specific GL accounts for revenue recognition, COGS accounting, and financial statement preparation under GAAP/IFRS.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: LNG cargoes from joint venture liquefaction facilities require JOA reference for partner entitlement allocation, cost recovery, and overlift/underlift tracking. Drives partner-level cargo value distri',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: LNG cargo liftings by PSA/JOA partners are reconciled against their gas entitlement positions. This link is standard in LNG equity lifting operations for over/underlift tracking, profit-gas split sett',
    `logistics_lifting_schedule_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_lifting_schedule. Business justification: An LNG cargo is planned and governed by a logistics lifting schedule. The lifting schedule defines the planned loading dates, nominated volumes, and vessel assignments for LNG cargoes. Linking lng_car',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: LNG cargoes are scheduled and executed against customer nominations. The nomination drives cargo laycan, volume, vessel assignment, and discharge port. Used in LNG cargo scheduling, nomination confirm',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: LNG cargoes require export/import permits and facility permits. Cargo records reference permit numbers for compliance verification. Real-world operations link each cargo to its authorizing permit, ens',
    `terminal_id` BIGINT COMMENT 'Reference to the export terminal where the LNG cargo is loaded onto the vessel.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: LNG cargoes are high-value transactions that must be tracked by profit center for LNG business segment reporting, cargo economics, and profitability analysis.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA-governed LNG projects need cargo-level PSA tracking for cost recovery vs profit gas allocation, contractor/government entitlement splits, and fiscal regime compliance. Essential for international ',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: LNG cargoes must meet destination terminal quality specifications (heating value limits, wobbe index range, composition constraints). The quality_spec defines acceptance criteria for LNG delivery, dri',
    `receiving_terminal_id` BIGINT COMMENT 'Reference to the import terminal where the LNG cargo is discharged for regasification.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: LNG cargoes trigger DOE export filings and customs declarations. Cargo operations link to the regulatory filing for audit trail, ensuring all LNG exports are properly reported to federal authorities a',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: LNG spot trades result in specific LNG cargo movements. P&L attribution, mark-to-market valuation, and settlement of LNG spot trades require linking the physical cargo to the originating spot trade. T',
    `vessel_id` BIGINT COMMENT 'Reference to the LNG carrier vessel transporting the cargo.',
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
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Allocation measurement points are placed at exploration block boundaries for JOA cost allocation and government royalty metering. Regulators and JOA partners require block-level metering attribution f',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_term_contract. Business justification: Fiscal measurement points are contractually designated in commercial term contracts as the custody transfer location. Linking measurement_point to commercial_term_contract enables contract-specific me',
    `contract_id` BIGINT COMMENT 'Reference to the commercial contract or transportation agreement governing the use of this measurement point for custody transfer and tariff calculations.',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Measurement points physically define or co-locate with customer delivery points in pipeline and terminal operations. Used in gas balancing, custody metering, and nomination confirmation. Domain expert',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to hse.emission_source. Business justification: Emission sources (flare stacks, vents, fugitive sources) are physically located at measurement points (meter stations, custody transfer points). EPA GHG reporting and LDAR programs require linking emi',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Fiscal measurement points are installed at exploration well test sites for DST/EWT metering. Regulatory bodies and PSA cost recovery audits require linking each measurement point to the exploration we',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Measurement points (LACT units, lease meters) are often installed at lease custody transfer points. Tying meters to leases enables automated production allocation, royalty calculation, and regulatory ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Measurement points require calibration permits and custody transfer approvals. Meter records reference the permit authorizing fiscal measurement. Real-world operations link each measurement point to i',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Fiscal meters and PHMSA-regulated measurement points are physically installed at specific pipeline segment boundaries. Linking measurement_point to pipeline_segment is required for tariff billing reco',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: A measurement point is physically located at a terminal (marine terminal, pipeline terminal, or storage terminal). Linking measurement_point to terminal establishes the physical location hierarchy: te',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` (
    `vessel_schedule_assignment_id` BIGINT COMMENT 'Unique identifier for this vessel schedule assignment record. Primary key.',
    `shipping_schedule_id` BIGINT COMMENT 'Foreign key to logistics.shipping_schedule. Links this assignment to the parent shipping schedule.',
    `vessel_id` BIGINT COMMENT 'Foreign key to logistics.vessel. Links this assignment to the assigned vessel.',
    `assigned_by` STRING COMMENT 'Name or identifier of the marine logistics planner or scheduler who made this vessel assignment decision.',
    `assignment_date` DATE COMMENT 'Date when this vessel was assigned to the shipping schedule by the marine logistics planner. Tracks when the assignment decision was made.',
    `assignment_notes` STRING COMMENT 'Free-text notes capturing specific considerations, constraints, or special instructions for this vessel assignment (e.g., cargo compatibility, port restrictions, weather considerations).',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this vessel assignment. Values: proposed (initial planning), confirmed (vessel committed), in_progress (loading underway), completed (lifting finished), cancelled (assignment cancelled), substituted (vessel replaced).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this vessel schedule assignment record was first created. Audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this vessel schedule assignment record was last updated. Audit trail for tracking changes to assignments.',
    `laycan_end_date` DATE COMMENT 'Latest date of the laytime cancelling date range (laycan) by which the vessel must arrive at the loading port. Failure to arrive within laycan may allow charterer to cancel.',
    `laycan_start_date` DATE COMMENT 'Earliest date of the laytime cancelling date range (laycan) during which the vessel must arrive at the loading port. Part of charter party terms.',
    `planned_loading_date` DATE COMMENT 'Planned date when this vessel is scheduled to commence loading operations for this shipping schedule. Critical for berth planning and terminal coordination.',
    `planned_volume_bbl` DECIMAL(18,2) COMMENT 'Planned cargo volume in barrels that this vessel is assigned to lift under this shipping schedule. Used for capacity planning and entitlement allocation.',
    `vessel_role` STRING COMMENT 'Role of the vessel in this shipping schedule assignment. Values: primary_lifter (main vessel for scheduled liftings), backup_vessel (contingency vessel), spot_charter (short-term charter), term_charter (long-term charter agreement).',
    CONSTRAINT pk_vessel_schedule_assignment PRIMARY KEY(`vessel_schedule_assignment_id`)
) COMMENT 'This association product represents the operational assignment between a shipping schedule and a vessel. It captures the specific assignment of a vessel to execute liftings within a consolidated shipping schedule for a given planning horizon. Each record links one shipping schedule to one vessel with attributes that exist only in the context of this assignment, including assignment dates, vessel role, planned loading dates, planned volumes, and assignment status.. Existence Justification: In oil and gas marine logistics, a shipping schedule is a consolidated master plan covering multiple vessel movements across a planning horizon (monthly/quarterly), and each vessel can participate in multiple shipping schedules over time. The business actively manages vessel schedule assignments as operational records with specific assignment dates, vessel roles, planned loading dates, planned volumes, and assignment statuses. The explicit presence of number_of_vessels_assigned on shipping_schedule confirms that schedules routinely involve multiple vessels, and vessels are reused across different schedules.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` (
    `schedule_port_call_id` BIGINT COMMENT 'Unique identifier for this schedule port call. Primary key.',
    `shipping_schedule_id` BIGINT COMMENT 'Foreign key linking to the parent shipping schedule that governs this port call',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to the terminal where this port call will occur',
    `berth_assignment` STRING COMMENT 'Specific berth or loading position assigned at the terminal for this port call (e.g., Berth 3, North Dock)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule port call record was first created in the system',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule port call record was last modified',
    `planned_arrival_date` TIMESTAMP COMMENT 'Planned date and time when the vessel is scheduled to arrive at this terminal for loading or discharge operations',
    `planned_departure_date` TIMESTAMP COMMENT 'Planned date and time when the vessel is scheduled to depart from this terminal after completing cargo operations',
    `planned_volume_bbl` DECIMAL(18,2) COMMENT 'Planned cargo volume in barrels to be loaded or discharged at this terminal during this port call',
    `port_call_sequence` STRING COMMENT 'Sequential order of this port call within the shipping schedule (1 for first port, 2 for second, etc.)',
    `port_call_status` STRING COMMENT 'Current operational status of this port call indicating its execution state',
    CONSTRAINT pk_schedule_port_call PRIMARY KEY(`schedule_port_call_id`)
) COMMENT 'This association product represents the operational port call event between a shipping schedule and a terminal. It captures the planned vessel arrival, departure, berth assignment, and volume for each terminal included in a multi-port shipping schedule. Each record links one shipping schedule to one terminal with attributes that exist only in the context of this specific port call within the schedule.. Existence Justification: In oil and gas marine logistics, a shipping schedule is a consolidated master plan that encompasses multiple port calls across different terminals during a planning horizon (monthly or quarterly). Each shipping schedule includes planned vessel movements to multiple terminals for cargo liftings, and each terminal hosts multiple shipping schedules over time. The business actively manages schedule port calls as operational planning entities with specific arrival/departure dates, berth assignments, and planned volumes for each terminal visit within a schedule.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_shipping_schedule_id` FOREIGN KEY (`shipping_schedule_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipping_schedule`(`shipping_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_lng_cargo_id` FOREIGN KEY (`lng_cargo_id`) REFERENCES `oil_gas_ecm`.`logistics`.`lng_cargo`(`lng_cargo_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_logistics_lifting_schedule_id` FOREIGN KEY (`logistics_lifting_schedule_id`) REFERENCES `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule`(`logistics_lifting_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ADD CONSTRAINT `fk_logistics_vessel_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_shipping_schedule_id` FOREIGN KEY (`shipping_schedule_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipping_schedule`(`shipping_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_logistics_lifting_schedule_id` FOREIGN KEY (`logistics_lifting_schedule_id`) REFERENCES `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule`(`logistics_lifting_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `oil_gas_ecm`.`logistics`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `oil_gas_ecm`.`logistics`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `oil_gas_ecm`.`logistics`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_logistics_lifting_schedule_id` FOREIGN KEY (`logistics_lifting_schedule_id`) REFERENCES `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule`(`logistics_lifting_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_receiving_terminal_id` FOREIGN KEY (`receiving_terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ADD CONSTRAINT `fk_logistics_vessel_schedule_assignment_shipping_schedule_id` FOREIGN KEY (`shipping_schedule_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipping_schedule`(`shipping_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ADD CONSTRAINT `fk_logistics_vessel_schedule_assignment_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ADD CONSTRAINT `fk_logistics_schedule_port_call_shipping_schedule_id` FOREIGN KEY (`shipping_schedule_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipping_schedule`(`shipping_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ADD CONSTRAINT `fk_logistics_schedule_port_call_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` SET TAGS ('dbx_subdomain' = 'marine_logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `customer_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Scheme Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `overlift_underlift_id` SET TAGS ('dbx_business_glossary_term' = 'Overlift Underlift Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ALTER COLUMN `well_test_id` SET TAGS ('dbx_business_glossary_term' = 'Well Test Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `transportation_rate` SET TAGS ('dbx_business_glossary_term' = 'Transportation Rate');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `transportation_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `transportation_rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Transportation Rate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `transportation_rate_uom` SET TAGS ('dbx_value_regex' = 'USD_per_BBL|USD_per_MCF|USD_per_MMCF');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ALTER COLUMN `water_content_lbs_per_mmcf` SET TAGS ('dbx_business_glossary_term' = 'Water Content Pounds (LBS) per Million Cubic Feet (MMCF)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` SET TAGS ('dbx_subdomain' = 'marine_logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `logistics_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Lifting Schedule ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `field_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `production_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Production Forecast Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `revenue_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `shipping_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `vessel_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approval Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `custody_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `lng_cargo_id` SET TAGS ('dbx_business_glossary_term' = 'Lng Cargo Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `logistics_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Lifting Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `overlift_underlift_id` SET TAGS ('dbx_business_glossary_term' = 'Overlift Underlift Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` SET TAGS ('dbx_subdomain' = 'marine_logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` SET TAGS ('dbx_subdomain' = 'marine_logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ALTER COLUMN `shipping_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Schedule Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `logistics_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Lifting Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `authorized_volume` SET TAGS ('dbx_business_glossary_term' = 'Authorized Volume');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `price_differential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority Level');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|critical');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `regulatory_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Number');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'pipeline|tanker|truck|rail|barge|fpso');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'BBL|MT|GAL|M3|MMBTU|MCF');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'marine_logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` SET TAGS ('dbx_subdomain' = 'marine_logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `shipping_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Schedule ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `storage_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Inventory ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `pipeline_throughput_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Throughput ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Receipt Measurement Point ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` SET TAGS ('dbx_subdomain' = 'marine_logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `lng_cargo_id` SET TAGS ('dbx_business_glossary_term' = 'Liquefied Natural Gas (LNG) Cargo Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `logistics_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Lifting Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Terminal Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `receiving_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Terminal Identifier');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` SET TAGS ('dbx_subdomain' = 'terminal_operations');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` SET TAGS ('dbx_subdomain' = 'marine_logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` SET TAGS ('dbx_association_edges' = 'logistics.shipping_schedule,logistics.vessel');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `vessel_schedule_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Schedule Assignment ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `shipping_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Schedule ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `laycan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan End Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `laycan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan Start Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `planned_loading_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Loading Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `planned_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume BBL');
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_schedule_assignment` ALTER COLUMN `vessel_role` SET TAGS ('dbx_business_glossary_term' = 'Vessel Role');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` SET TAGS ('dbx_subdomain' = 'marine_logistics');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` SET TAGS ('dbx_association_edges' = 'logistics.shipping_schedule,logistics.terminal');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `schedule_port_call_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Port Call ID');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `shipping_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Port Call - Shipping Schedule Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Port Call - Terminal Id');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `berth_assignment` SET TAGS ('dbx_business_glossary_term' = 'Berth Assignment');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `planned_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `planned_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Date');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `planned_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume BBL');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `port_call_sequence` SET TAGS ('dbx_business_glossary_term' = 'Port Call Sequence');
ALTER TABLE `oil_gas_ecm`.`logistics`.`schedule_port_call` ALTER COLUMN `port_call_status` SET TAGS ('dbx_business_glossary_term' = 'Port Call Status');
