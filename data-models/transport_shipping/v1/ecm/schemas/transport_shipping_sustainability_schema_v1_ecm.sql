-- Schema for Domain: sustainability | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`sustainability` COMMENT 'Tracks and reports on environmental, social, and governance (ESG) performance including GHG emissions (CO2e), carbon offsetting programs, fuel efficiency, and regulatory compliance with EU ETS and CORSIA. Owns emissions factors, shipment-level carbon footprint calculations, sustainability KPIs, and ESG disclosure data. Supports green logistics initiatives, customer-facing carbon reporting, and regulatory environmental reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` (
    `emissions_factor_id` BIGINT COMMENT 'Unique identifier for the emissions factor record. Primary key.',
    `superseded_by_factor_emissions_factor_id` BIGINT COMMENT 'Reference to the emissions factor ID that supersedes this record, enabling version lineage tracking. Null if this is the current active version.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this emissions factor for use in carbon footprint calculations.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this emissions factor was approved for operational use.',
    `biofuel_blend_percentage` DECIMAL(18,2) COMMENT 'Percentage of biofuel or sustainable aviation fuel (SAF) blended into the fuel mix for this emissions factor. Null if not applicable or 0% biofuel.',
    `calculation_methodology` STRING COMMENT 'Description of the methodology or formula used to derive this emissions factor (e.g., Well-to-wheel analysis, Tank-to-wheel, Fuel combustion only).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emissions factor record was first created in the system.',
    `data_quality_rating` STRING COMMENT 'Quality rating of the emissions factor data based on source reliability, measurement precision, and representativeness.. Valid values are `high|medium|low|estimated`',
    `effective_from_date` DATE COMMENT 'Date from which this emissions factor becomes valid and should be used for carbon footprint calculations.',
    `effective_to_date` DATE COMMENT 'Date until which this emissions factor remains valid. Null indicates the factor is currently active with no defined end date.',
    `emission_intensity_value` DECIMAL(18,2) COMMENT 'Numeric value of the emissions factor representing grams of CO2e per unit of activity (e.g., per tonne-km, per liter, per kWh).',
    `emissions_factor_status` STRING COMMENT 'Current lifecycle status of the emissions factor record.. Valid values are `active|deprecated|draft|under_review|archived`',
    `factor_code` STRING COMMENT 'Unique business identifier code for the emissions factor, used for external reference and integration with carbon calculation systems.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `factor_name` STRING COMMENT 'Human-readable descriptive name of the emissions factor (e.g., Air Freight - Boeing 747 - Jet Fuel, Ocean Freight - Container Vessel - HFO).',
    `fuel_type` STRING COMMENT 'Type of fuel or energy source used (e.g., Jet A-1, Heavy Fuel Oil, Diesel, LNG, Electricity, Biofuel blend).',
    `geographic_scope` STRING COMMENT 'Geographic region or country to which this emissions factor applies (e.g., Global, USA, EUR, CHN). Use 3-letter ISO country codes or Global for worldwide applicability.',
    `gwp_multiplier_ch4` DECIMAL(18,2) COMMENT 'Global Warming Potential multiplier for methane relative to CO2e over 100-year time horizon.',
    `gwp_multiplier_co2` DECIMAL(18,2) COMMENT 'Global Warming Potential multiplier for carbon dioxide relative to CO2e. Typically 1.0 for CO2.',
    `gwp_multiplier_n2o` DECIMAL(18,2) COMMENT 'Global Warming Potential multiplier for nitrous oxide relative to CO2e over 100-year time horizon.',
    `intensity_unit` STRING COMMENT 'Unit of measure for the emission intensity value, defining the activity basis for carbon calculation.. Valid values are `gCO2e/tonne-km|gCO2e/liter|gCO2e/kWh|kgCO2e/TEU-km|gCO2e/pkm|kgCO2e/shipment`',
    `load_factor_assumption` DECIMAL(18,2) COMMENT 'Assumed load factor or capacity utilization percentage used in the emissions factor calculation (e.g., 70.0 represents 70% capacity). Null if not applicable.',
    `notes` STRING COMMENT 'Additional notes, assumptions, or context regarding this emissions factor, including any special conditions or limitations on its use.',
    `publication_year` STRING COMMENT 'Year the source publication or emissions factor dataset was released.',
    `regulatory_framework` STRING COMMENT 'Regulatory or compliance framework this emissions factor aligns with (e.g., EU ETS, CORSIA, UK SECR, CDP Climate Change). [ENUM-REF-CANDIDATE: EU_ETS|CORSIA|UK_SECR|CDP|TCFD|GRI|SASB|CSRD — promote to reference product]',
    `scope_3_category` STRING COMMENT 'Specific Scope 3 category per GHG Protocol (e.g., Category 4: Upstream transportation, Category 9: Downstream transportation). Null for Scope 1 and 2.',
    `scope_classification` STRING COMMENT 'GHG Protocol scope classification: Scope 1 (direct emissions), Scope 2 (purchased energy), Scope 3 (value chain emissions).. Valid values are `scope_1|scope_2|scope_3`',
    `source_authority` STRING COMMENT 'Authoritative source or standard body that published or certified this emissions factor (e.g., IPCC, IATA, IMO, DEFRA, EPA, GLEC Framework). [ENUM-REF-CANDIDATE: IPCC|IATA|IMO|DEFRA|EPA|GLEC|EEA|custom — 8 candidates stripped; promote to reference product]',
    `source_publication` STRING COMMENT 'Specific publication, report, or database from which this emissions factor was sourced (e.g., IPCC AR5 WG3, DEFRA 2023 Conversion Factors, IATA CO2 Connect).',
    `transport_mode` STRING COMMENT 'Primary mode of transportation or facility type to which this emissions factor applies.. Valid values are `air|ocean|road|rail|multimodal|facility`',
    `uncertainty_percentage` DECIMAL(18,2) COMMENT 'Estimated uncertainty or margin of error for this emissions factor, expressed as a percentage (e.g., 10.5 represents ±10.5% uncertainty).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this emissions factor record was last modified.',
    `vehicle_category` STRING COMMENT 'Specific category or class of vehicle, vessel, or aircraft (e.g., Wide-body jet, Container ship 8000+ TEU, Heavy-duty truck, Electric locomotive).',
    `version_number` STRING COMMENT 'Version identifier for this emissions factor, supporting version lineage and change tracking (e.g., 1.0, 2.1).. Valid values are `^[0-9]+.[0-9]+$`',
    `well_to_tank_included` BOOLEAN COMMENT 'Indicates whether upstream well-to-tank emissions (fuel production and distribution) are included in this factor. True if WTT is included, False if only tank-to-wheel (combustion) emissions are covered.',
    CONSTRAINT pk_emissions_factor PRIMARY KEY(`emissions_factor_id`)
) COMMENT 'Master reference table for GHG emissions conversion factors used to calculate CO2e across transport modes (air, ocean, road, rail) and facility operations. Stores emission intensity values per tonne-km, fuel type, aircraft type, vessel class, vehicle category, and energy source aligned to IATA, IMO, and GLEC Framework standards. Includes scope classification (Scope 1, 2, 3), GWP multipliers, effective date ranges, source authority (IPCC, IATA, IMO, DEFRA), and version lineage. This is the authoritative emissions factor library for all carbon footprint calculations across the organization.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` (
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Unique identifier for the shipment carbon footprint calculation record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (airline, shipping line, trucking company, rail operator) that performed this transport leg. Enables carrier-level emissions benchmarking.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment for which carbon footprint is calculated. Links to the shipment transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carbon footprint calculations are allocated to cost centers for internal carbon pricing, departmental sustainability KPIs, and cost allocation in logistics operations. Essential for management account',
    `customer_carbon_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.customer_carbon_report. Business justification: Individual shipment carbon footprints are aggregated into customer carbon reports. This FK provides direct traceability from each footprint to the customer report it feeds into. The existing customer_',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Carbon footprint calculations are included in shipment documentation packages for CORSIA/EU ETS regulatory compliance and customer ESG reporting. Transport operators assemble complete documentation pa',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Shipment carbon footprint calculations reference the master emissions factor table. The calculation uses emissions_factor_co2e_per_tonne_km which is derived from the emissions_factor master. Standard ',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Shipment carbon footprint records (Scope 3 Category 9 - downstream transportation) are aggregated into periodic GHG inventories for corporate ESG reporting. Each shipment footprint contributes to the ',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: Parcel weight, dimensions, and routing drive transport emissions calculations. Real logistics operations calculate carbon intensity per parcel for accurate customer billing and carrier emissions alloc',
    `parcel_manifest_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel_manifest. Business justification: Manifests aggregate parcels for carrier handoff; carbon footprints are calculated at manifest level for carrier billing, emissions allocation, and supplier emissions disclosure. Real business process ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Carbon emissions tracked by profit center for service line sustainability reporting and profitability analysis including carbon costs. Required for segment-level carbon intensity metrics and green ser',
    `shipment_leg_id` BIGINT COMMENT 'Reference to the specific shipment leg (segment) for which carbon footprint is calculated. Nullable if calculation is for full journey.',
    `actual_weight_kg` DECIMAL(18,2) COMMENT 'Actual physical weight of the shipment in kilograms. Used for tonne-km calculation when greater than dimensional weight.',
    `calculation_methodology_version` STRING COMMENT 'Version identifier of the carbon footprint calculation methodology applied (e.g., GLEC v3.0, ISO 14083:2023). Ensures auditability and comparability over time.',
    `calculation_notes` STRING COMMENT 'Free-text notes documenting assumptions, exceptions, or special considerations applied during carbon footprint calculation.',
    `calculation_run_code` BIGINT COMMENT 'Reference to the batch calculation run that produced this carbon footprint record. Enables traceability and reprocessing.',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when the carbon footprint calculation was performed. Principal business event timestamp for this record.',
    `carbon_offset_kg` DECIMAL(18,2) COMMENT 'Amount of CO2e emissions offset through carbon offset programs (e.g., reforestation, renewable energy credits) in kilograms.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The greater of actual weight or dimensional weight, used for carbon footprint calculation. Represents the weight basis for emissions allocation.',
    `compliance_status` STRING COMMENT 'Compliance status of this shipment leg with applicable environmental regulations: compliant, non-compliant, exempt, or pending review.. Valid values are `compliant|non_compliant|exempt|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon footprint record was first created in the system. Audit trail field.',
    `data_quality_tier` STRING COMMENT 'Quality tier of the carbon footprint data: measured (primary data from actual fuel consumption), modeled (activity-based with specific factors), or default (industry average factors).. Valid values are `measured|modeled|default`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the destination location. Supports regulatory reporting by jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'IATA, UN/LOCODE, or internal code for the destination location of this shipment leg. Supports geographic emissions analysis.',
    `dim_weight_kg` DECIMAL(18,2) COMMENT 'Dimensional (volumetric) weight of the shipment in kilograms, calculated from package dimensions. Used for tonne-km calculation when greater than actual weight.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance traveled for this shipment leg in kilometers. Used in tonne-km calculation for carbon footprint.',
    `emissions_factor_co2e_per_tonne_km` DECIMAL(18,2) COMMENT 'Carbon dioxide equivalent emissions factor applied, expressed as kg CO2e per tonne-km. Sourced from GLEC, DEFRA, or carrier-specific data.',
    `emissions_factor_source` STRING COMMENT 'Source of the emissions factor used: GLEC default, DEFRA, carrier-specific data, EPA, or custom calculation.. Valid values are `glec|defra|carrier_specific|epa|custom`',
    `fuel_consumed_liters` DECIMAL(18,2) COMMENT 'Actual fuel consumed for this shipment leg in liters, if measured. Supports primary (measured) data quality tier.',
    `fuel_type` STRING COMMENT 'Type of fuel consumed during transport. Critical for selecting correct emissions factor and supporting alternative fuel tracking. [ENUM-REF-CANDIDATE: diesel|gasoline|jet_fuel|heavy_fuel_oil|lng|electric|hydrogen|biofuel|hybrid — 9 candidates stripped; promote to reference product]',
    `green_logistics_sla_flag` BOOLEAN COMMENT 'Indicates whether this shipment is subject to a green logistics SLA commitment with the customer (True/False).',
    `gross_co2e_kg` DECIMAL(18,2) COMMENT 'Total gross CO2 equivalent emissions for this shipment leg in kilograms, before any carbon offsets are applied.',
    `load_factor_percent` DECIMAL(18,2) COMMENT 'Percentage of vehicle/vessel capacity utilized for this shipment. Used to allocate emissions proportionally. Range 0-100.',
    `net_co2e_kg` DECIMAL(18,2) COMMENT 'Net CO2 equivalent emissions after applying carbon offsets, in kilograms. Represents the final carbon footprint reported to customers.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the origin location. Supports regulatory reporting by jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `origin_location_code` STRING COMMENT 'IATA, UN/LOCODE, or internal code for the origin location of this shipment leg. Supports geographic emissions analysis.',
    `regulatory_program` STRING COMMENT 'Applicable regulatory carbon program for this shipment leg: EU ETS (Emissions Trading System), CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation), or none.. Valid values are `eu_ets|corsia|none`',
    `scope_classification` STRING COMMENT 'GHG Protocol scope classification: Scope 1 (direct emissions from owned/controlled sources), Scope 2 (indirect emissions from purchased energy), Scope 3 (other indirect emissions in value chain).. Valid values are `scope_1|scope_2|scope_3`',
    `service_level` STRING COMMENT 'Service level for this shipment (e.g., express, standard, economy). Supports analysis of emissions by service tier.',
    `tonne_km` DECIMAL(18,2) COMMENT 'Product of chargeable weight (in tonnes) and distance (in km). Core metric for transport work and emissions calculation.',
    `transport_mode` STRING COMMENT 'Primary mode of transport for this shipment leg: air, ocean, road, rail, or multimodal. Determines applicable emissions factors.. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon footprint record was last updated. Audit trail field.',
    `vehicle_type` STRING COMMENT 'Specific vehicle or vessel type used for transport (e.g., Boeing 747, container ship, articulated truck, electric van). Provides granularity for emissions factor selection.',
    `verification_body` STRING COMMENT 'Name of the third-party verification body that verified this carbon footprint calculation, if applicable.',
    `verification_date` DATE COMMENT 'Date when the carbon footprint calculation was verified by a third-party body, if applicable.',
    `verification_status` STRING COMMENT 'Third-party verification status of the carbon footprint calculation: verified, unverified, pending verification, or rejected.. Valid values are `verified|unverified|pending|rejected`',
    CONSTRAINT pk_shipment_carbon_footprint PRIMARY KEY(`shipment_carbon_footprint_id`)
) COMMENT 'Transactional record capturing the calculated CO2e carbon footprint for each individual shipment leg or full shipment journey. Stores tonne-km distance, fuel consumed, emissions factor applied, gross CO2e (kg), net CO2e after offsets, transport mode, load factor, DIM weight vs actual weight used, calculation methodology version, and data quality tier (measured, modelled, default). Supports customer-facing carbon reporting, regulatory disclosure under EU ETS and CORSIA, and green logistics SLA tracking. One record per shipment leg per calculation run.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` (
    `carbon_offset_program_id` BIGINT COMMENT 'Unique identifier for the carbon offset program. Primary key.',
    `additionality_verified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the carbon offset project has been verified to meet additionality criteria (i.e., the reductions would not have occurred without the project).',
    `approval_date` DATE COMMENT 'The date when the carbon offset program was approved by Transport Shipping for credit procurement.',
    `approved_by` STRING COMMENT 'The name or identifier of the Transport Shipping employee or role who approved the carbon offset program for procurement.',
    `certifying_body` STRING COMMENT 'The independent third-party organization that certifies and validates the carbon offset program (e.g., Gold Standard, VCS/Verra, CDM, ACR, CAR, Plan Vivo). [ENUM-REF-CANDIDATE: Gold Standard|VCS|Verra|CDM|ACR|CAR|Plan Vivo — 7 candidates stripped; promote to reference product]',
    `co_benefits` STRING COMMENT 'Additional environmental, social, or economic benefits delivered by the carbon offset project beyond GHG reductions (e.g., biodiversity protection, community employment, water quality improvement).',
    `contract_end_date` DATE COMMENT 'The date when Transport Shippings contractual agreement with the carbon offset program provider expires or is scheduled to end. Nullable for open-ended agreements.',
    `contract_start_date` DATE COMMENT 'The date when Transport Shippings contractual agreement with the carbon offset program provider became effective.',
    `corsia_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the carbon offset program is eligible for use under ICAOs CORSIA scheme for international aviation emissions offsetting.',
    `country_of_origin` STRING COMMENT 'The country where the carbon offset project is physically located, using ISO 3166-1 alpha-3 country code.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this carbon offset program record was first created in the system.',
    `credits_purchased` DECIMAL(18,2) COMMENT 'The total quantity of carbon offset credits (in tonnes CO2e) that Transport Shipping has purchased from this program to date.',
    `credits_reserved` DECIMAL(18,2) COMMENT 'The quantity of carbon offset credits (in tonnes CO2e) currently reserved or allocated for future retirement but not yet retired.',
    `credits_retired` DECIMAL(18,2) COMMENT 'The total quantity of carbon offset credits (in tonnes CO2e) that have been permanently retired or cancelled to offset Transport Shippings emissions.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the price per tonne (e.g., USD, EUR, GBP).',
    `eu_ets_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the carbon offset program is eligible for use under the EU Emissions Trading System for compliance purposes.',
    `internal_approval_status` STRING COMMENT 'The status of Transport Shippings internal approval process for procuring credits from this carbon offset program (e.g., Pending, Approved, Rejected, Under Review).. Valid values are `Pending|Approved|Rejected|Under Review`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this carbon offset program record was last updated or modified in the system.',
    `last_verification_date` DATE COMMENT 'The date of the most recent third-party verification or audit of the carbon offset projects GHG reductions.',
    `next_verification_due_date` DATE COMMENT 'The scheduled date for the next third-party verification or audit of the carbon offset projects GHG reductions.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the carbon offset program.',
    `permanence_risk_rating` STRING COMMENT 'Assessment of the risk that the carbon reductions or removals may be reversed over time (e.g., Low, Medium, High). Particularly relevant for forestry and land-use projects.. Valid values are `Low|Medium|High`',
    `price_per_tonne_co2e` DECIMAL(18,2) COMMENT 'The purchase price per metric tonne of CO2e offset credit in the programs currency. Used for procurement cost calculations.',
    `program_code` STRING COMMENT 'Unique external identifier or registry code assigned to the carbon offset program by the certifying body.',
    `program_name` STRING COMMENT 'Official name of the carbon offset program or project that Transport Shipping participates in or procures credits from.',
    `program_status` STRING COMMENT 'The current lifecycle status of the carbon offset program within Transport Shippings portfolio (e.g., Active, Suspended, Completed, Cancelled, Under Review, Approved).. Valid values are `Active|Suspended|Completed|Cancelled|Under Review|Approved`',
    `project_description` STRING COMMENT 'Detailed narrative description of the carbon offset project, including its objectives, methodology, and environmental impact.',
    `project_type` STRING COMMENT 'The category of carbon offset project (e.g., reforestation, renewable energy, methane capture, energy efficiency, avoided deforestation, carbon sequestration).. Valid values are `Reforestation|Renewable Energy|Methane Capture|Energy Efficiency|Avoided Deforestation|Carbon Sequestration`',
    `registry_url` STRING COMMENT 'The web URL link to the public registry entry or project page for this carbon offset program, enabling transparency and traceability.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal numbers that the carbon offset project contributes to (e.g., SDG 7, SDG 13, SDG 15).',
    `total_credits_available` DECIMAL(18,2) COMMENT 'The total quantity of carbon offset credits (in tonnes CO2e) available for procurement from this program.',
    `verification_standard` STRING COMMENT 'The specific verification or validation standard applied to the carbon offset project (e.g., ISO 14064-3, VCS Standard, Gold Standard for Global Goals).',
    `vintage_year_end` STRING COMMENT 'The ending year of the vintage period during which the carbon reductions or removals were achieved. Nullable for ongoing projects.',
    `vintage_year_start` STRING COMMENT 'The starting year of the vintage period during which the carbon reductions or removals were achieved.',
    CONSTRAINT pk_carbon_offset_program PRIMARY KEY(`carbon_offset_program_id`)
) COMMENT 'Master record for carbon offset programs and projects that Transport Shipping participates in or procures credits from. Captures program name, certifying body (Gold Standard, VCS/Verra, CDM), project type (reforestation, renewable energy, methane capture), country of origin, vintage year range, price per tonne CO2e, total credits available, credits retired, program status, and CORSIA eligibility flag. Serves as the catalog of approved offset instruments for procurement and retirement workflows.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` (
    `carbon_offset_transaction_id` BIGINT COMMENT 'Unique identifier for the carbon offset transaction record. Primary key.',
    `carbon_offset_program_id` BIGINT COMMENT 'Reference to the carbon offset program or project from which the credits originated (e.g., renewable energy, reforestation, methane capture).',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Carbon offset transactions must be posted to specific GL accounts for financial statement preparation and carbon asset accounting. Required for balance sheet recognition of carbon credits and P&L expe',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carbon offset purchases are charged to specific cost centers as operational expenses for sustainability budget management and cost allocation. Real business process: departmental carbon offset budget ',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this carbon offset transaction, used for customer-facing carbon reporting and green shipping certificates.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Carbon offset transactions are recorded in specific fiscal periods for financial close, period-end accruals, and financial statement preparation. Required for matching carbon offset expenses to the co',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Carbon offset transactions are allocated to specific GHG inventory periods for accounting and reporting purposes. Offsets purchased or retired in a given year are aggregated into the annual GHG invent',
    `green_shipment_certificate_id` BIGINT COMMENT 'Foreign key linking to sustainability.green_shipment_certificate. Business justification: When carbon offset credits are retired to support a customer-facing green shipment certificate, the transaction should reference which certificate it supports. This provides traceability from the offs',
    `certificate_id` BIGINT COMMENT 'Unique identifier of the retirement certificate issued by the registry when credits are permanently retired, used for customer green shipping certificates and compliance reporting.',
    `shipment_leg_id` BIGINT COMMENT 'Reference to the specific shipment for which carbon offsets were purchased or retired, enabling shipment-level carbon footprint reporting.',
    `awb_number` STRING COMMENT 'Air Waybill number associated with the shipment for which carbon offsets were purchased, used for air freight carbon reporting.',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with the shipment for which carbon offsets were purchased, used for ocean and ground freight carbon reporting.',
    `buyer_name` STRING COMMENT 'Name of the entity or account that purchased or received the carbon credits.',
    `compliance_scheme` STRING COMMENT 'Regulatory compliance scheme the transaction supports: CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation), EU ETS (European Union Emissions Trading System), voluntary (non-regulatory), or other.. Valid values are `CORSIA|EU_ETS|voluntary|other`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created the carbon offset transaction record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the carbon offset transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the carbon offset transaction record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the carbon offset transaction record was last modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount paid or received for the carbon offset transaction after fees and adjustments.',
    `notes` STRING COMMENT 'Free-text notes or comments about the carbon offset transaction, used for audit trails and internal documentation.',
    `offset_standard` STRING COMMENT 'Carbon offset certification standard under which the credits were issued: VCS (Verified Carbon Standard), Gold Standard, CDM (Clean Development Mechanism), CAR (Climate Action Reserve), ACR (American Carbon Registry), Plan Vivo, or other. [ENUM-REF-CANDIDATE: VCS|Gold Standard|CDM|CAR|ACR|Plan Vivo|other — 7 candidates stripped; promote to reference product]',
    `project_location_country` STRING COMMENT 'Three-letter ISO country code where the carbon offset project is located.. Valid values are `^[A-Z]{3}$`',
    `project_type` STRING COMMENT 'Type of carbon offset project: renewable energy (wind, solar), forestry (reforestation, avoided deforestation), methane capture (landfill, agriculture), energy efficiency, cookstoves, or other.. Valid values are `renewable_energy|forestry|methane_capture|energy_efficiency|cookstoves|other`',
    `quantity_tco2e` DECIMAL(18,2) COMMENT 'Quantity of carbon credits involved in the transaction, measured in metric tons of carbon dioxide equivalent (tCO2e).',
    `registry_name` STRING COMMENT 'Name of the carbon offset registry where the transaction was recorded (e.g., Verra Registry, Gold Standard Registry, UNFCCC CDM Registry).',
    `registry_serial_number` STRING COMMENT 'Unique serial number or batch identifier assigned by the carbon offset registry to the credits involved in this transaction.',
    `retirement_reason` STRING COMMENT 'Business reason or beneficiary statement for retiring the carbon credits (e.g., Offset for shipment AWB-12345 on behalf of Customer XYZ).',
    `seller_name` STRING COMMENT 'Name of the entity or broker from whom the carbon credits were purchased.',
    `settlement_date` DATE COMMENT 'Date when the carbon offset transaction was finalized and credits were transferred or retired in the registry.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the carbon offset transaction (quantity multiplied by unit price), before any fees or adjustments.',
    `transaction_date` DATE COMMENT 'Date when the carbon offset transaction was executed or recorded in the registry.',
    `transaction_fee` DECIMAL(18,2) COMMENT 'Registry or broker fee charged for processing the carbon offset transaction.',
    `transaction_number` STRING COMMENT 'Externally-visible business identifier for the carbon offset transaction, used for audit trails and customer reporting.',
    `transaction_purpose` STRING COMMENT 'Business purpose for the carbon offset transaction: voluntary customer offset (customer-paid green shipping), regulatory compliance (CORSIA, EU ETS), internal neutrality target (corporate sustainability goals), corporate commitment, customer request, or other.. Valid values are `voluntary_customer_offset|regulatory_compliance|internal_neutrality|corporate_commitment|customer_request|other`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the carbon offset transaction in the processing workflow.. Valid values are `pending|confirmed|settled|cancelled|failed|under_review`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the carbon offset transaction was executed, used for audit and compliance reporting.',
    `transaction_type` STRING COMMENT 'Type of carbon offset transaction: purchase (acquiring credits), retirement (permanently removing credits from circulation), transfer (moving credits between accounts), cancellation (voiding credits), issuance (initial credit creation), or reversal (correcting erroneous transaction).. Valid values are `purchase|retirement|transfer|cancellation|issuance|reversal`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per metric ton of CO2e for the carbon credits in this transaction.',
    `verification_date` DATE COMMENT 'Date when the carbon offset transaction or credits were verified by a third-party auditor.',
    `verification_status` STRING COMMENT 'Status of third-party verification for the carbon offset transaction and underlying credits.. Valid values are `verified|pending_verification|rejected|not_applicable`',
    `verifier_name` STRING COMMENT 'Name of the third-party verification body that audited the carbon offset transaction or credits.',
    `vintage_year` STRING COMMENT 'Year in which the carbon offset credits were generated or verified, used for compliance eligibility and pricing.',
    CONSTRAINT pk_carbon_offset_transaction PRIMARY KEY(`carbon_offset_transaction_id`)
) COMMENT 'Transactional record of each carbon credit purchase, retirement, or transfer event. Captures offset program reference, quantity of credits (tCO2e), transaction date, unit price, total cost, registry serial numbers, retirement certificate ID, purpose (voluntary customer offset, regulatory compliance, internal neutrality target), and associated shipment or customer account. Supports CORSIA compliance reporting, EU ETS surrender records, and customer green shipping certificate issuance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` (
    `fuel_consumption_record_id` BIGINT COMMENT 'Unique identifier for the fuel consumption record. Primary key for this entity.',
    `certificate_id` BIGINT COMMENT 'Identifier of the carbon offset certificate applied to this fuel consumption record. Links to the carbon offset registry.',
    `consignment_id` BIGINT COMMENT 'Identifier of the shipment being transported during this fuel consumption event. Used for shipment-level carbon footprint allocation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fuel consumption costs are allocated to fleet or operational cost centers for cost management, budgeting, and variance analysis. Essential for fleet operating expense tracking and fuel efficiency prog',
    `dispatch_run_id` BIGINT COMMENT 'Foreign key linking to fulfillment.dispatch_run. Business justification: Dispatch runs represent complete vehicle routes with measurable fuel consumption. Essential for fleet emissions tracking, route optimization, and regulatory reporting. Real operations track fuel per r',
    `driver_profile_id` BIGINT COMMENT 'Identifier of the driver, pilot, or captain operating the asset during fuel consumption. Used for driver performance analysis and training.',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Fuel consumption records calculate CO2e emissions using emissions factors from the master table. The emission_factor DECIMAL attribute stores the calculated value for audit, while emission_factor_sour',
    `freight_leg_id` BIGINT COMMENT 'Identifier of the trip, voyage, or flight during which fuel was consumed. Links to the operational trip record.',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Fuel consumption records represent Scope 1 emissions (direct combustion) and are aggregated into periodic GHG inventories. Each fuel consumption event contributes to the total Scope 1 emissions in the',
    `last_mile_dispatch_id` BIGINT COMMENT 'Foreign key linking to fulfillment.last_mile_dispatch. Business justification: Last-mile delivery vehicles consume fuel tracked for Scope 1 emissions reporting and cost allocation. Real operations link dispatch events to fuel consumption for carbon accounting, driver performance',
    `saf_procurement_id` BIGINT COMMENT 'Foreign key linking to sustainability.saf_procurement. Business justification: When aviation fuel consumption includes Sustainable Aviation Fuel (SAF), the fuel consumption record should reference the SAF procurement batch. This provides traceability from operational fuel usage ',
    `transport_asset_id` BIGINT COMMENT 'Identifier of the vehicle, vessel, or aircraft that consumed the fuel. Links to the fleet asset master.',
    `ambient_temperature` DECIMAL(18,2) COMMENT 'Ambient temperature during fuel consumption in degrees Celsius. Temperature affects fuel efficiency and is used for performance normalization.',
    `carbon_offset_applied` BOOLEAN COMMENT 'Indicates whether carbon offsets have been applied to neutralize the emissions from this fuel consumption. Used for net-zero reporting and customer carbon-neutral shipping programs.',
    `cargo_weight` DECIMAL(18,2) COMMENT 'Total weight of cargo carried during this fuel consumption period. Used for emissions intensity calculations (grams CO2e per tonne-kilometre).',
    `cargo_weight_unit` STRING COMMENT 'Unit of measure for cargo weight. Typically kilograms or tonnes.. Valid values are `kilograms|tonnes|pounds`',
    `co2e_emissions` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions in kilograms of CO2 equivalent (CO2e) calculated from this fuel consumption using applicable emission factors. Primary metric for Scope 1 emissions reporting.',
    `consumption_date` DATE COMMENT 'Date of fuel consumption event. Used for daily aggregation and reporting.',
    `consumption_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel consumption was recorded or occurred. Primary business event timestamp for this record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel consumption record was first created in the system. Used for audit trail and data lineage.',
    `data_quality_flag` STRING COMMENT 'Quality indicator for this fuel consumption record. Verified data has been validated, estimated data uses proxy values, incomplete data has missing fields, anomaly indicates outlier values requiring review.. Valid values are `verified|estimated|incomplete|anomaly|pending_review`',
    `data_source` STRING COMMENT 'Source from which the fuel consumption data was obtained. IoT telemetry provides real-time sensor data, manual entry from driver logs, EDI from carrier systems, fuel card transactions, supplier invoices, or estimated values.. Valid values are `iot_telemetry|manual_entry|edi_carrier|fuel_card|invoice|estimated`',
    `destination_location_code` STRING COMMENT 'Code of the destination location for this fuel consumption segment. IATA airport code, UN/LOCODE port code, or internal facility code.',
    `distance_travelled` DECIMAL(18,2) COMMENT 'Total distance travelled by the asset during the fuel consumption period. Used to calculate fuel efficiency metrics (litres per 100 km, miles per gallon).',
    `distance_unit` STRING COMMENT 'Unit of measure for distance travelled. Typically kilometres for road/rail, nautical miles for ocean/air.. Valid values are `kilometres|miles|nautical_miles`',
    `emission_factor` DECIMAL(18,2) COMMENT 'Emission factor applied to calculate CO2e emissions from fuel quantity. Expressed as kilograms CO2e per litre or kilogram of fuel. Varies by fuel type and regulatory framework.',
    `emission_factor_source` STRING COMMENT 'Source or standard from which the emission factor was obtained. Ensures traceability and compliance with regulatory requirements.. Valid values are `ipcc|defra|epa|corsia|eu_ets|custom`',
    `engine_hours` DECIMAL(18,2) COMMENT 'Total engine operating hours during this fuel consumption period. Used for maintenance scheduling and fuel efficiency analysis.',
    `fuel_cost` DECIMAL(18,2) COMMENT 'Total cost of fuel consumed in this record. Used for cost allocation and profitability analysis.',
    `fuel_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the fuel cost amount.. Valid values are `^[A-Z]{3}$`',
    `fuel_efficiency` DECIMAL(18,2) COMMENT 'Calculated fuel efficiency for this trip. Expressed as litres per 100 kilometres, miles per gallon, or grams per tonne-kilometre depending on asset type.',
    `fuel_quantity` DECIMAL(18,2) COMMENT 'Quantity of fuel consumed during the trip or operational period. Measured in litres, kilograms, or kilowatt-hours depending on fuel type.',
    `fuel_quantity_unit` STRING COMMENT 'Unit of measure for the fuel quantity consumed. Typically litres for liquid fuels, kilograms for LNG, kilowatt-hours (kWh) for electric.. Valid values are `litres|kilograms|kwh|gallons|tonnes`',
    `fuel_supplier` STRING COMMENT 'Name of the fuel supplier or refueling station. Used for supplier performance analysis and invoice reconciliation.',
    `fuel_type` STRING COMMENT 'Type of fuel consumed. Includes conventional fuels (Jet-A, marine Heavy Fuel Oil (HFO), diesel), alternative fuels (Sustainable Aviation Fuel (SAF), Liquefied Natural Gas (LNG), biodiesel), and electric energy (kWh). [ENUM-REF-CANDIDATE: jet_a|jet_a1|avgas|marine_hfo|marine_mgo|marine_lng|diesel|biodiesel|gasoline|electric_kwh|saf — 11 candidates stripped; promote to reference product]',
    `invoice_number` STRING COMMENT 'Invoice number from the fuel supplier. Used for financial reconciliation and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel consumption record was last updated. Used for audit trail and change tracking.',
    `load_factor` DECIMAL(18,2) COMMENT 'Percentage of asset capacity utilized during this trip. Used to allocate fuel consumption and emissions to cargo vs. empty running. Expressed as percentage (0-100).',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this record. Used for audit trail and accountability.',
    `notes` STRING COMMENT 'Free-text notes or comments about this fuel consumption record. Used to capture anomalies, special circumstances, or data quality issues.',
    `operational_mode` STRING COMMENT 'Operational mode of the asset during fuel consumption. Different modes have different fuel consumption profiles and emission factors. [ENUM-REF-CANDIDATE: cruise|idle|taxiing|loading|unloading|maneuvering|berthing — 7 candidates stripped; promote to reference product]',
    `origin_location_code` STRING COMMENT 'Code of the origin location for this fuel consumption segment. IATA airport code, UN/LOCODE port code, or internal facility code.',
    `refueling_location` STRING COMMENT 'Physical location where refueling occurred. Airport, port, depot, or station name.',
    `reporting_period` STRING COMMENT 'Regulatory reporting period to which this fuel consumption record belongs. Format YYYY-MM or YYYY-QQ for monthly or quarterly reporting.',
    `route_segment` STRING COMMENT 'Specific route segment or leg identifier for this fuel consumption record. Enables segment-level fuel efficiency analysis.',
    `scope_classification` STRING COMMENT 'GHG Protocol scope classification for this fuel consumption. Scope 1 for direct emissions from owned/controlled assets, Scope 2 for purchased electricity, Scope 3 for carrier emissions.. Valid values are `scope_1|scope_2|scope_3`',
    `verification_status` STRING COMMENT 'Verification status of the fuel consumption record for regulatory reporting. Audited records have been reviewed by third-party verifiers for EU ETS or CORSIA compliance.. Valid values are `unverified|verified|audited|disputed`',
    `weather_condition` STRING COMMENT 'Weather condition during the trip. Weather impacts fuel consumption and is used for efficiency analysis and anomaly detection.. Valid values are `clear|rain|snow|fog|wind|storm`',
    CONSTRAINT pk_fuel_consumption_record PRIMARY KEY(`fuel_consumption_record_id`)
) COMMENT 'Operational record capturing actual fuel consumption data at the vehicle, vessel, or aircraft level per trip, voyage, or flight. Stores asset ID, fuel type (jet-A, marine HFO, diesel, SAF, LNG, electric kWh), quantity consumed (litres or kg), distance travelled, route segment, load factor, operational mode (cruise, idle, taxiing), data source (IoT telemetry, manual entry, EDI from carrier), and data quality flag. Primary input for bottom-up Scope 1 emissions calculations and fleet fuel efficiency KPIs.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`target` (
    `target_id` BIGINT COMMENT 'Unique identifier for the sustainability target record. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the business unit or division responsible for achieving this target (e.g., global operations, regional division, specific country operation). Links to organizational hierarchy. Null if target is corporate-wide.',
    `approval_date` DATE COMMENT 'Date on which the target was formally approved by the governing authority. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Internal approval status of the target. Pending targets are awaiting executive or board approval; approved targets have been formally endorsed by leadership; rejected targets were not approved.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the executive, committee, or board that approved the target (e.g., Board of Directors, Chief Sustainability Officer, Executive Committee). Null if not yet approved.',
    `baseline_recalculation_policy` STRING COMMENT 'Policy for recalculating the baseline in response to structural changes such as mergers, acquisitions, divestitures, or changes in calculation methodology (e.g., Baseline will be recalculated if structural changes result in a change of more than 5% in baseline emissions, No recalculation policy - baseline is fixed).',
    `baseline_value` DECIMAL(18,2) COMMENT 'The quantitative baseline measurement in the baseline year (e.g., 500000 tCO2e, 75 tCO2e per TEU, 15% renewable energy). This is the starting point from which reduction or improvement is measured.',
    `baseline_year` STRING COMMENT 'The reference year against which progress is measured (e.g., 2019, 2020). Baseline year establishes the starting point for reduction targets.',
    `boundary_definition` STRING COMMENT 'Description of the organizational and operational boundaries included in the target (e.g., All wholly-owned subsidiaries and operations where Transport Shipping has operational control, Excludes joint ventures and franchises). Defines what is in and out of scope.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sustainability target record was first created in the system.',
    `current_value` DECIMAL(18,2) COMMENT 'The most recent actual measurement value for tracking progress against the target (e.g., current year emissions, current renewable energy percentage). Updated periodically as new data becomes available.',
    `current_value_year` STRING COMMENT 'The year to which the current_value corresponds (e.g., 2023). Indicates the reporting period of the most recent progress measurement.',
    `disclosure_channel` STRING COMMENT 'The channel or platform through which the target was publicly disclosed (e.g., Annual Sustainability Report, CDP Climate Change Response, Investor Presentation, Press Release, Corporate Website). Null if not publicly disclosed.',
    `disclosure_date` DATE COMMENT 'Date on which the target was first publicly disclosed. Null if not publicly disclosed or if public_disclosure_flag is False.',
    `geographic_region` STRING COMMENT 'If geographic_scope is regional or country_specific, this field specifies the region or country (e.g., Europe, North America, USA, DEU). Use ISO 3166-1 alpha-3 country codes for country-specific targets. Null for global or facility-specific targets.',
    `geographic_scope` STRING COMMENT 'The geographic coverage of the target. Global targets apply to all operations worldwide; regional targets apply to a specific region (e.g., Europe, Asia-Pacific); country_specific targets apply to operations in a single country; facility_specific targets apply to individual facilities or sites.. Valid values are `global|regional|country_specific|facility_specific`',
    `governing_framework` STRING COMMENT 'The external standard, initiative, or framework under which this target is set and reported. SBTi (Science Based Targets initiative) for science-based targets; CDP for Carbon Disclosure Project reporting; GHG Protocol for GHG Protocol-aligned targets; ISO 14064 for ISO GHG accounting standard; EU ETS for European Union Emissions Trading System; CORSIA for Carbon Offsetting and Reduction Scheme for International Aviation; TCFD for Task Force on Climate-related Financial Disclosures; GRI for Global Reporting Initiative; SASB for Sustainability Accounting Standards Board; internal for company-defined targets not aligned to external framework. [ENUM-REF-CANDIDATE: sbti|cdp|ghg_protocol|iso_14064|eu_ets|corsia|tcfd|gri|sasb|internal — 10 candidates stripped; promote to reference product]',
    `interim_milestone_value` DECIMAL(18,2) COMMENT 'The quantitative value to be achieved by the interim milestone year. Null if no interim milestones are defined.',
    `interim_milestone_year` STRING COMMENT 'Optional interim year for progress checkpoints between baseline and target year (e.g., 2025 as a milestone toward a 2030 target). Null if no interim milestones are defined.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sustainability target record was most recently modified.',
    `linked_incentive_flag` BOOLEAN COMMENT 'Indicates whether achievement of this target is linked to executive compensation, employee bonuses, or other financial incentives. True if linked to incentives; False if not.',
    `methodology` STRING COMMENT 'The calculation methodology or approach used to set the target (e.g., Absolute Contraction Approach, Sectoral Decarbonization Approach (SDA), Economic Intensity Approach). Describes how the target value was determined.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context about the target, including assumptions, dependencies, risks, or special considerations.',
    `offsetting_allowed_flag` BOOLEAN COMMENT 'Indicates whether carbon offsets or credits are permitted to count toward achieving this target. True if offsets are allowed; False if target must be met through direct emissions reductions only.',
    `offsetting_limit_percentage` DECIMAL(18,2) COMMENT 'If offsetting_allowed_flag is True, this field specifies the maximum percentage of the target that can be met through offsets (e.g., 10.00 means up to 10% of reductions can come from offsets). Null if offsets are not allowed or no limit is defined.',
    `progress_percentage` DECIMAL(18,2) COMMENT 'Percentage of progress toward the target, calculated as ((baseline_value - current_value) / (baseline_value - target_value)) * 100. Values over 100 indicate target has been exceeded. Null if current_value is not available.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this target has been publicly disclosed in sustainability reports, CDP submissions, investor communications, or other public channels. True if publicly disclosed; False if internal only.',
    `record_version` STRING COMMENT 'Version number of this record, incremented with each update. Supports change tracking and audit trail.',
    `reduction_percentage` DECIMAL(18,2) COMMENT 'The percentage reduction from baseline to target (e.g., 50.00 for 50% reduction, 30.00 for 30% reduction). Calculated as ((baseline_value - target_value) / baseline_value) * 100. Null for non-reduction targets.',
    `renewable_energy_source_types` STRING COMMENT 'For renewable energy targets, specifies the types of renewable energy sources that count toward the target (e.g., Solar, Wind, Hydro, All renewable sources per RE100 criteria). Null for non-renewable-energy targets.',
    `responsible_party` STRING COMMENT 'Name or title of the individual, team, or department responsible for achieving this target (e.g., Chief Sustainability Officer, Global Operations Team, Regional Sustainability Manager). Accountability owner for target delivery.',
    `sbti_validation_status` STRING COMMENT 'If governing_framework is SBTi, this field tracks the validation status with the Science Based Targets initiative. Not_submitted targets have not been submitted for validation; submitted targets are under review; validated targets have been approved by SBTi; rejected targets did not meet SBTi criteria; expired targets have passed their validation period. Null for non-SBTi targets.. Valid values are `not_submitted|submitted|validated|rejected|expired`',
    `scope_3_category` STRING COMMENT 'If scope_coverage is scope_3_category_specific, this field specifies which of the 15 GHG Protocol Scope 3 categories the target applies to (e.g., Category 4: Upstream transportation and distribution, Category 9: Downstream transportation and distribution, Category 1: Purchased goods and services). Null if target covers all Scope 3 or is not Scope 3 specific.',
    `scope_coverage` STRING COMMENT 'The GHG Protocol scopes covered by this target. Scope 1 covers direct emissions from owned or controlled sources; Scope 2 covers indirect emissions from purchased electricity, steam, heating, and cooling; Scope 3 covers all other indirect emissions in the value chain; scope_1_2 covers both Scope 1 and 2; scope_1_2_3 covers all three scopes; scope_3_category_specific targets a specific Scope 3 category (e.g., upstream transportation, downstream transportation).. Valid values are `scope_1|scope_2|scope_3|scope_1_2|scope_1_2_3|scope_3_category_specific`',
    `target_code` STRING COMMENT 'Unique business identifier or code for the target used in reporting and tracking systems (e.g., TGT-2030-SCOPE12, RE-2025).',
    `target_description` STRING COMMENT 'Detailed narrative description of the target, including context, rationale, methodology, and any specific conditions or assumptions (e.g., Reduce absolute Scope 1 and 2 GHG emissions by 50% from 2019 baseline by 2030, aligned with 1.5°C pathway. Baseline recalculated to account for acquisitions and divestitures using the GHG Protocol guidance.).',
    `target_name` STRING COMMENT 'Human-readable name or title of the sustainability target (e.g., Net Zero by 2050, Scope 1+2 Reduction 2030, Renewable Energy 50% by 2025).',
    `target_status` STRING COMMENT 'Current lifecycle status of the sustainability target. Draft targets are under development; approved targets have been formally endorsed; active targets are in progress; on_track targets are progressing as planned; at_risk targets are behind schedule; achieved targets have been met; expired targets have passed their target year without achievement; cancelled targets have been withdrawn. [ENUM-REF-CANDIDATE: draft|approved|active|on_track|at_risk|achieved|expired|cancelled — 8 candidates stripped; promote to reference product]',
    `target_type` STRING COMMENT 'Classification of the sustainability target type. Absolute emissions reduction targets reduce total emissions; intensity reduction targets reduce emissions per unit of activity; renewable energy percentage targets increase share of renewable energy; net-zero pledge commits to net-zero emissions by target year; SBTi-aligned targets meet Science Based Targets initiative criteria; carbon neutral targets achieve carbon neutrality through reduction and offsetting.. Valid values are `absolute_emissions_reduction|intensity_reduction|renewable_energy_percentage|net_zero_pledge|sbti_aligned|carbon_neutral`',
    `target_value` DECIMAL(18,2) COMMENT 'The quantitative target measurement to be achieved by the target year (e.g., 250000 tCO2e for 50% reduction, 50 tCO2e per TEU, 50% renewable energy). This is the goal value.',
    `unit_of_measure` STRING COMMENT 'The unit in which baseline and target values are expressed (e.g., tCO2e for tonnes of carbon dioxide equivalent, % for percentage, tCO2e/TEU for intensity per twenty-foot equivalent unit, kWh for kilowatt-hours, MWh for megawatt-hours).',
    `updated_by` STRING COMMENT 'Identifier or name of the user or system that last updated this record (e.g., user ID, system account name).',
    `year` STRING COMMENT 'The year by which the target is to be achieved (e.g., 2030, 2040, 2050). This is the deadline for meeting the commitment.',
    CONSTRAINT pk_target PRIMARY KEY(`target_id`)
) COMMENT 'Master record for corporate and business-unit sustainability targets and commitments. Captures target name, target type (absolute emissions reduction, intensity reduction, renewable energy %, net-zero pledge, SBTi-aligned), baseline year, baseline value, target year, target value, unit of measure (tCO2e, %, kWh), scope coverage (Scope 1/2/3), responsible business unit, governing framework (SBTi, CDP, GHG Protocol), approval status, and public disclosure flag. Enables tracking of progress against ESG commitments and regulatory pledges.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` (
    `esg_disclosure_id` BIGINT COMMENT 'Unique identifier for the ESG disclosure record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Identifier of the legal entity or business unit submitting this ESG disclosure.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: ESG disclosures are tied to fiscal periods for integrated reporting aligned with financial statement periods. Required for annual report coordination and regulatory filing deadlines. Complements exist',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: ESG disclosures reference the underlying GHG inventory data for the reporting period. The disclosure reports the inventory results to external stakeholders (regulators, investors, rating agencies). Th',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: ESG disclosures reference document packages containing transport documents as evidence for emissions calculations and regulatory submissions. Real business process: ESG audit trail requires linking di',
    `approval_date` DATE COMMENT 'Date on which this ESG disclosure was formally approved by the responsible governance body.',
    `approved_by_name` STRING COMMENT 'Name of the executive or governance body that formally approved this ESG disclosure for submission and publication.',
    `assurance_level` STRING COMMENT 'Level of external assurance obtained for this ESG disclosure. None = no external assurance, Limited = limited assurance engagement, Reasonable = reasonable assurance engagement (equivalent to financial audit).. Valid values are `none|limited|reasonable`',
    `assurance_opinion` STRING COMMENT 'Type of opinion issued by the external auditor. Unqualified = clean opinion with no material misstatements, Qualified = opinion with exceptions, Adverse = material misstatements present, Disclaimer = auditor unable to form an opinion.. Valid values are `unqualified|qualified|adverse|disclaimer`',
    `board_independence_percentage` DECIMAL(18,2) COMMENT 'Percentage of board members classified as independent directors according to applicable corporate governance standards.',
    `carbon_offset_credits_tonnes` DECIMAL(18,2) COMMENT 'Total volume of verified carbon offset credits purchased or retired during the reporting period to compensate for emissions, expressed in metric tonnes of CO2 equivalent.',
    `corsia_compliance_flag` BOOLEAN COMMENT 'Indicates whether the reporting entity is subject to and compliant with CORSIA requirements for international aviation emissions offsetting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ESG disclosure record was first created in the system.',
    `data_privacy_incidents_count` STRING COMMENT 'Total number of substantiated data privacy breaches or incidents during the reporting period.',
    `disclosure_framework` STRING COMMENT 'The ESG reporting framework or standard under which this disclosure is prepared. GRI = Global Reporting Initiative, TCFD = Task Force on Climate-related Financial Disclosures, CDP = Carbon Disclosure Project, EU_CSRD = EU Corporate Sustainability Reporting Directive, SASB_TRANSPORT = Sustainability Accounting Standards Board Transport sector, UNGC = UN Global Compact, ISO_14064 = Greenhouse Gas Accounting Standard. [ENUM-REF-CANDIDATE: GRI|TCFD|CDP|EU_CSRD|SASB_TRANSPORT|INTEGRATED_REPORTING|UNGC|ISO_14064 — 8 candidates stripped; promote to reference product]',
    `disclosure_reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this ESG disclosure submission for tracking and citation purposes.',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the ESG disclosure record. [ENUM-REF-CANDIDATE: draft|under_review|approved|submitted|published|amended|withdrawn — 7 candidates stripped; promote to reference product]',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total energy consumed from all sources during the reporting period, expressed in megawatt hours.',
    `ethics_training_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of employees who completed mandatory ethics and compliance training during the reporting period.',
    `eu_ets_compliance_flag` BOOLEAN COMMENT 'Indicates whether the reporting entity is subject to and compliant with EU ETS cap-and-trade requirements for greenhouse gas emissions.',
    `external_auditor_name` STRING COMMENT 'Name of the independent third-party firm that provided external assurance for this ESG disclosure, if applicable.',
    `female_workforce_percentage` DECIMAL(18,2) COMMENT 'Percentage of total workforce identifying as female at the end of the reporting period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ESG disclosure record was last updated in the system.',
    `lost_time_injury_rate` DECIMAL(18,2) COMMENT 'Number of lost time injuries per million hours worked during the reporting period. Lost time injury is a work-related injury resulting in the employee being unable to attend work for at least one full day after the injury.',
    `net_zero_target_year` STRING COMMENT 'Calendar year by which the reporting entity has committed to achieve net-zero greenhouse gas emissions, if applicable.',
    `notes` STRING COMMENT 'Additional explanatory notes, methodological details, or contextual information relevant to this ESG disclosure.',
    `prepared_by_name` STRING COMMENT 'Name of the individual or team responsible for preparing this ESG disclosure.',
    `publication_date` DATE COMMENT 'Date on which the ESG disclosure was made publicly available.',
    `publication_url` STRING COMMENT 'Web address where the full ESG disclosure report is publicly accessible.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Indicates whether this ESG disclosure is mandated by regulatory requirements (True) or is voluntary (False).',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Percentage of total energy consumption sourced from renewable energy sources during the reporting period.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts reported in this ESG disclosure.. Valid values are `^[A-Z]{3}$`',
    `reporting_entity_name` STRING COMMENT 'Full legal name of the entity submitting the ESG disclosure.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period covered by this ESG disclosure.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period covered by this ESG disclosure.',
    `science_based_targets_flag` BOOLEAN COMMENT 'Indicates whether the reporting entity has committed to and set emissions reduction targets validated by the Science Based Targets initiative.',
    `scope_1_emissions_co2e_tonnes` DECIMAL(18,2) COMMENT 'Total direct greenhouse gas emissions from owned or controlled sources during the reporting period, expressed in metric tonnes of CO2 equivalent.',
    `scope_2_emissions_co2e_tonnes` DECIMAL(18,2) COMMENT 'Total indirect greenhouse gas emissions from purchased electricity, steam, heating, and cooling during the reporting period, expressed in metric tonnes of CO2 equivalent.',
    `scope_3_emissions_co2e_tonnes` DECIMAL(18,2) COMMENT 'Total indirect greenhouse gas emissions from value chain activities (upstream and downstream) during the reporting period, expressed in metric tonnes of CO2 equivalent.',
    `submission_date` DATE COMMENT 'Date on which the ESG disclosure was formally submitted to the regulatory body, stock exchange, or voluntary reporting platform.',
    `sustainability_investment_amount` DECIMAL(18,2) COMMENT 'Total capital expenditure and operating expenditure invested in sustainability initiatives, green technologies, and ESG programs during the reporting period, expressed in reporting currency.',
    `total_emissions_co2e_tonnes` DECIMAL(18,2) COMMENT 'Sum of Scope 1, Scope 2, and Scope 3 emissions for the reporting period, expressed in metric tonnes of CO2 equivalent.',
    `total_workforce_fte` DECIMAL(18,2) COMMENT 'Total number of employees expressed as full-time equivalents at the end of the reporting period.',
    `version_number` STRING COMMENT 'Version identifier for this ESG disclosure document, used to track amendments and revisions.',
    `waste_generated_tonnes` DECIMAL(18,2) COMMENT 'Total weight of waste generated during the reporting period, expressed in metric tonnes.',
    `waste_recycled_percentage` DECIMAL(18,2) COMMENT 'Percentage of total waste generated that was recycled or diverted from landfill during the reporting period.',
    `water_consumption_cubic_meters` DECIMAL(18,2) COMMENT 'Total volume of water consumed during the reporting period, expressed in cubic meters.',
    `workforce_diversity_percentage` DECIMAL(18,2) COMMENT 'Percentage of workforce from underrepresented groups (gender, ethnicity, disability) as defined by applicable diversity frameworks and regulations.',
    CONSTRAINT pk_esg_disclosure PRIMARY KEY(`esg_disclosure_id`)
) COMMENT 'Master record for formal ESG disclosure submissions made to regulatory bodies, stock exchanges, or voluntary reporting frameworks. Captures reporting period, disclosure framework (GRI, TCFD, CDP, EU CSRD, SASB Transport), submission date, submitting entity, total Scope 1/2/3 emissions, energy consumption, water usage, waste generated, social metrics (FTE count, injury rate, diversity %), governance metrics, assurance level (limited/reasonable), external auditor, and publication URL. Serves as the authoritative record of all public ESG disclosures.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` (
    `ghg_inventory_id` BIGINT COMMENT 'Unique identifier for the GHG inventory record. Primary key.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: GHG inventory is prepared for specific fiscal periods to align with financial reporting cycles for integrated financial and sustainability reporting. Required for annual report preparation and regulat',
    `approval_date` DATE COMMENT 'The date on which this GHG inventory was formally approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or authority who approved this GHG inventory for publication or submission.',
    `base_year` STRING COMMENT 'The historical year against which GHG emissions are tracked and reduction targets are measured.',
    `base_year_emissions_tco2e` DECIMAL(18,2) COMMENT 'Total GHG emissions in the base year, used as the reference point for tracking emissions reductions over time.',
    `base_year_recalculation_flag` BOOLEAN COMMENT 'Indicates whether the base year emissions have been recalculated due to structural changes, methodology improvements, or data quality improvements.',
    `biogenic_co2_emissions_tco2e` DECIMAL(18,2) COMMENT 'Total biogenic CO2 emissions from the combustion or biodegradation of biomass, reported separately from fossil-based emissions.',
    `carbon_offsets_purchased_tco2e` DECIMAL(18,2) COMMENT 'Total carbon offsets purchased and retired during the reporting period to compensate for GHG emissions, expressed in tonnes of CO2 equivalent.',
    `carbon_removals_tco2e` DECIMAL(18,2) COMMENT 'Total carbon dioxide removals from the atmosphere through activities such as afforestation, reforestation, or direct air capture, expressed in tonnes of CO2 equivalent.',
    `cdp_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this inventory was disclosed through the CDP climate change questionnaire.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this GHG inventory record was first created in the system.',
    `intensity_ratio_tco2e_per_fte` DECIMAL(18,2) COMMENT 'GHG emissions intensity expressed as tonnes of CO2 equivalent per full-time equivalent employee.',
    `intensity_ratio_tco2e_per_revenue_million` DECIMAL(18,2) COMMENT 'GHG emissions intensity expressed as tonnes of CO2 equivalent per million units of revenue, used for benchmarking and trend analysis.',
    `intensity_ratio_tco2e_per_tonne_km` DECIMAL(18,2) COMMENT 'GHG emissions intensity expressed as tonnes of CO2 equivalent per tonne-kilometer of freight transported, a key logistics industry metric.',
    `inventory_status` STRING COMMENT 'Current lifecycle status of the GHG inventory record.. Valid values are `draft|submitted|verified|published|archived`',
    `inventory_year` STRING COMMENT 'The calendar year for which this GHG inventory is reported (e.g., 2023).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this GHG inventory record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, assumptions, exclusions, or contextual information relevant to this GHG inventory.',
    `organizational_boundary_method` STRING COMMENT 'The consolidation approach used to define the organizational boundary for this inventory (operational control, financial control, or equity share).. Valid values are `operational_control|financial_control|equity_share`',
    `prepared_by` STRING COMMENT 'Name or identifier of the individual or team responsible for preparing this GHG inventory.',
    `publication_date` DATE COMMENT 'The date on which this GHG inventory was published or made publicly available.',
    `regulatory_submission_date` DATE COMMENT 'The date on which this inventory was submitted to the regulatory authority.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this inventory was submitted to a regulatory authority for compliance purposes (e.g., EU ETS, CORSIA).',
    `reporting_framework` STRING COMMENT 'The primary GHG accounting and reporting framework or standard used for this inventory (e.g., GHG Protocol Corporate Standard, ISO 14064-1, CDP). [ENUM-REF-CANDIDATE: ghg_protocol_corporate|iso_14064_1|cdp|tcfd|gri|sasb|eu_ets|corsia — promote to reference product]',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period covered by this inventory.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period covered by this inventory.',
    `scope_1_total_tco2e` DECIMAL(18,2) COMMENT 'Total Scope 1 direct GHG emissions from sources owned or controlled by the organization, expressed in tonnes of CO2 equivalent.',
    `scope_2_location_based_tco2e` DECIMAL(18,2) COMMENT 'Total Scope 2 indirect GHG emissions from purchased electricity, heat, steam, and cooling, calculated using location-based emission factors.',
    `scope_2_market_based_tco2e` DECIMAL(18,2) COMMENT 'Total Scope 2 indirect GHG emissions from purchased electricity, heat, steam, and cooling, calculated using market-based emission factors reflecting contractual instruments.',
    `scope_3_category_15_tco2e` DECIMAL(18,2) COMMENT 'Scope 3 emissions associated with the organizations investments, including equity and debt investments and project finance.',
    `scope_3_category_1_tco2e` DECIMAL(18,2) COMMENT 'Scope 3 emissions from extraction, production, and transportation of goods and services purchased by the organization.',
    `scope_3_category_2_tco2e` DECIMAL(18,2) COMMENT 'Scope 3 emissions from extraction, production, and transportation of capital goods purchased by the organization.',
    `scope_3_category_3_tco2e` DECIMAL(18,2) COMMENT 'Scope 3 emissions from extraction, production, and transportation of fuels and energy purchased, including upstream emissions and transmission and distribution losses.',
    `scope_3_category_4_tco2e` DECIMAL(18,2) COMMENT 'Scope 3 emissions from transportation and distribution of products purchased by the organization in vehicles not owned or operated by the organization.',
    `scope_3_category_5_tco2e` DECIMAL(18,2) COMMENT 'Scope 3 emissions from disposal and treatment of waste generated in the organizations operations.',
    `scope_3_category_6_tco2e` DECIMAL(18,2) COMMENT 'Scope 3 emissions from transportation of employees for business-related activities in vehicles not owned or operated by the organization.',
    `scope_3_category_7_tco2e` DECIMAL(18,2) COMMENT 'Scope 3 emissions from transportation of employees between their homes and worksites.',
    `scope_3_category_9_tco2e` DECIMAL(18,2) COMMENT 'Scope 3 emissions from transportation and distribution of products sold by the organization between the organizations operations and the end consumer in vehicles not owned or operated by the organization.',
    `scope_3_total_tco2e` DECIMAL(18,2) COMMENT 'Total Scope 3 indirect GHG emissions from value chain activities not owned or controlled by the organization, aggregated across all relevant categories.',
    `tcfd_alignment_flag` BOOLEAN COMMENT 'Indicates whether this inventory aligns with TCFD recommendations for climate-related financial disclosures.',
    `total_gross_emissions_tco2e` DECIMAL(18,2) COMMENT 'Sum of Scope 1, Scope 2 (location-based or market-based as per reporting choice), and Scope 3 emissions, representing total gross GHG emissions before any offsets or removals.',
    `total_net_emissions_tco2e` DECIMAL(18,2) COMMENT 'Total gross emissions minus carbon removals and any purchased carbon offsets, representing the net GHG emissions position.',
    `verification_date` DATE COMMENT 'The date on which the third-party verification of this GHG inventory was completed.',
    `verification_statement_url` STRING COMMENT 'URL or file path to the verification statement or assurance report issued by the third-party verifier.',
    `verification_status` STRING COMMENT 'The level of third-party verification or assurance applied to this GHG inventory (not verified, limited assurance, or reasonable assurance).. Valid values are `not_verified|limited_assurance|reasonable_assurance`',
    `verifier_name` STRING COMMENT 'The name of the third-party verification body or auditor that verified this GHG inventory, if applicable.',
    CONSTRAINT pk_ghg_inventory PRIMARY KEY(`ghg_inventory_id`)
) COMMENT 'Periodic GHG inventory record aggregating total Scope 1, Scope 2 (location-based and market-based), and Scope 3 emissions for a defined organizational boundary and reporting period. Captures inventory year, organizational boundary method (operational control, equity share, financial control), total tCO2e by scope and category, biogenic emissions, removals, intensity ratios (tCO2e per tonne-km, per revenue), verification status, and verifier identity. This is the master emissions ledger used for regulatory reporting and CDP/TCFD disclosures.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` (
    `eu_ets_allowance_id` BIGINT COMMENT 'Unique identifier for the EU ETS allowance record. Primary key for tracking allowance holdings, allocations, and surrender obligations across compliance periods.',
    `compliance_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.compliance_period. Business justification: EU ETS allowances operate within defined compliance periods. Adding compliance_period_id links EU ETS records to the regulatory compliance period they belong to, consistent with how corsia_compliance_',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: EU ETS allowance records reference the GHG inventory for verified emissions. The verified_emissions_co2e reported to EU ETS is derived from the Scope 1 emissions in the GHG inventory. This provides da',
    `allocated_allowances` DECIMAL(18,2) COMMENT 'Number of allowances allocated free of charge by the EU to the operator for this compliance period. Measured in tonnes of Carbon Dioxide Equivalent (CO2e). Aviation operators receive limited free allocations; maritime allocations are being phased in.',
    `allowance_type` STRING COMMENT 'Type of emission allowance held. EUA = EU Allowance (general), EUAA = EU Aviation Allowance, CER = Certified Emission Reduction (Kyoto), ERU = Emission Reduction Unit (Kyoto). Aviation operators primarily use EUAA; maritime operators use EUA.. Valid values are `EUA|EUAA|CER|ERU`',
    `average_allowance_price` DECIMAL(18,2) COMMENT 'Weighted average price paid per allowance (per tonne CO2e) for purchased allowances during the compliance period. Used for financial reporting and carbon cost analysis. Expressed in EUR.',
    `competent_authority` STRING COMMENT 'National regulatory authority responsible for overseeing EU ETS compliance for this operator. Typically the environmental or aviation authority of the member state where the operator is registered.',
    `compliance_period_year` STRING COMMENT 'The calendar year for which this allowance record applies. EU ETS operates on annual compliance cycles requiring surrender of allowances by April 30 of the following year.',
    `compliance_status` STRING COMMENT 'Current compliance status for the period. Compliant = sufficient allowances surrendered; non_compliant = failed to surrender by deadline; pending_verification = awaiting emissions verification; pending_surrender = verified but not yet surrendered; at_risk = insufficient allowances to cover verified emissions.. Valid values are `compliant|non_compliant|pending_verification|pending_surrender|at_risk`',
    `corsia_eligible_flag` BOOLEAN COMMENT 'Indicates whether this allowance record is also subject to CORSIA offsetting requirements for international flights outside the EEA. True if operator has CORSIA obligations; false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allowance record was first created in the system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage.',
    `member_state_code` STRING COMMENT 'ISO 3166-1 alpha-2 code of the EU member state under whose jurisdiction this operator falls for EU ETS purposes. Examples: DE (Germany), FR (France), NL (Netherlands).',
    `notes` STRING COMMENT 'Free-text field for additional context, exceptions, or explanatory information related to this allowance record. Used for audit trail and internal documentation.',
    `operator_code` BIGINT COMMENT 'Identifier for the Transport Shipping operational entity (aviation or maritime operator) subject to EU ETS obligations. Links to the internal operator master data.',
    `operator_name` STRING COMMENT 'Legal name of the aviation or maritime operator holding the allowances. Must match the name registered in the EU ETS registry.',
    `outstanding_obligation_co2e` DECIMAL(18,2) COMMENT 'Remaining surrender obligation not yet covered by allowances. Calculated as verified_emissions_co2e minus surrendered_allowances. A positive value indicates a shortfall requiring additional allowance purchases. Measured in tonnes of CO2e.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty imposed for non-compliance (failure to surrender sufficient allowances by the deadline). Penalty is €100 per tonne of CO2e shortfall (adjusted for inflation). Expressed in EUR.',
    `penalty_currency` STRING COMMENT 'Currency in which penalties are denominated. EU ETS penalties are always in EUR.. Valid values are `EUR`',
    `purchased_allowances` DECIMAL(18,2) COMMENT 'Number of allowances purchased by the operator through auctions or secondary markets to cover emissions obligations. Measured in tonnes of CO2e.',
    `registry_account_number` STRING COMMENT 'Unique account identifier in the EU ETS Union Registry where allowances are held. Format follows EU Registry specifications for operator holding accounts.',
    `reporting_entity` STRING COMMENT 'Legal entity within Transport Shipping responsible for EU ETS reporting and compliance for this record. May differ from operator_name in cases of group structures.',
    `sector` STRING COMMENT 'The transport sector to which this allowance record applies. Aviation covers flights within the European Economic Area (EEA); maritime covers vessels under EU MRV (Monitoring, Reporting, Verification) regulation.. Valid values are `aviation|maritime`',
    `surplus_allowances` DECIMAL(18,2) COMMENT 'Excess allowances held after meeting surrender obligations. Can be banked for future compliance periods or sold. Calculated as total_available_allowances minus verified_emissions_co2e. Measured in tonnes of CO2e.',
    `surrender_date` DATE COMMENT 'Actual date when allowances were surrendered to the EU Registry to cover emissions obligations. Must be on or before the surrender_deadline_date to avoid penalties.',
    `surrender_deadline_date` DATE COMMENT 'Regulatory deadline by which allowances must be surrendered for the compliance period. Typically April 30 of the year following the compliance period.',
    `surrendered_allowances` DECIMAL(18,2) COMMENT 'Number of allowances surrendered by the operator to cover verified emissions for the compliance period. Must be submitted by April 30 of the following year. Measured in tonnes of CO2e.',
    `total_allowance_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for purchasing allowances during the compliance period. Calculated as purchased_allowances multiplied by average_allowance_price. Expressed in EUR.',
    `total_available_allowances` DECIMAL(18,2) COMMENT 'Total number of allowances available in the operators account for surrender. Calculated as allocated + purchased + transferred_in - transferred_out. Measured in tonnes of CO2e.',
    `transferred_in_allowances` DECIMAL(18,2) COMMENT 'Number of allowances transferred into the operators registry account from other accounts during the compliance period. Measured in tonnes of CO2e.',
    `transferred_out_allowances` DECIMAL(18,2) COMMENT 'Number of allowances transferred out of the operators registry account to other accounts during the compliance period. Measured in tonnes of CO2e.',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this allowance record was last modified. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and change tracking.',
    `verification_date` DATE COMMENT 'Date when the emissions report was verified by an accredited verifier. Verification must be completed before allowances can be surrendered.',
    `verified_emissions_co2e` DECIMAL(18,2) COMMENT 'Total verified greenhouse gas emissions for the compliance period, expressed in tonnes of CO2e. This is the amount of allowances that must be surrendered. Verified by an accredited verifier per EU MRV requirements.',
    `verifier_accreditation_number` STRING COMMENT 'Official accreditation number of the verifier issued by the national accreditation body. Required for regulatory reporting and audit trail.',
    `verifier_name` STRING COMMENT 'Name of the accredited third-party verifier who verified the emissions report for this compliance period. Must be accredited under EU ETS verification regulations.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this record. Used for audit trail and accountability.',
    CONSTRAINT pk_eu_ets_allowance PRIMARY KEY(`eu_ets_allowance_id`)
) COMMENT 'Master record tracking EU Emissions Trading System (EU ETS) allowance holdings, allocations, and surrender obligations for Transport Shippings aviation and maritime operations. Captures compliance period, allowance type (EUA, EUAA), allocated allowances, purchased allowances, surrendered allowances, outstanding obligation, registry account ID, operator ID, and compliance status. Supports annual EU ETS surrender workflow and regulatory penalty avoidance for flights within the European Economic Area and maritime routes under EU MRV.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` (
    `corsia_compliance_record_id` BIGINT COMMENT 'Unique identifier for the CORSIA compliance record. Primary key for this transactional compliance entity tracking ICAO CORSIA obligations per compliance period.',
    `carrier_id` BIGINT COMMENT 'Reference to the airline operator subject to CORSIA compliance obligations. Links to the carrier or airline entity responsible for international aviation emissions.',
    `compliance_period_id` BIGINT COMMENT 'Reference to the CORSIA compliance period (e.g., Phase 1: 2021-2023, Phase 2: 2024-2026, Phase 3: 2027-2035). Links to the regulatory period definition.',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: CORSIA compliance records draw aviation emissions data from the GHG inventory. The annual_emissions_tco2e reported to ICAO CORSIA is derived from the Scope 1 aviation emissions in the GHG inventory. T',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: CORSIA compliance records must reference the actual air waybills and transport documents that generated the emissions being offset. Aviation emissions compliance verification requires linking complian',
    `annual_emissions_tco2e` DECIMAL(18,2) COMMENT 'Total CO2 equivalent emissions reported by the airline operator for the reporting year, covering all international aviation routes subject to CORSIA.',
    `baseline_emissions_tco2e` DECIMAL(18,2) COMMENT 'The baseline emissions level in tonnes of CO2 equivalent established for the operator, typically based on 2019-2020 average emissions. Used to calculate growth factor and offsetting obligations.',
    `competent_authority` STRING COMMENT 'The national or regional regulatory authority responsible for overseeing CORSIA compliance for the airline operator (e.g., FAA, EASA, CAAC).',
    `competent_authority_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the competent authority jurisdiction (e.g., USA, GBR, CHN).. Valid values are `^[A-Z]{3}$`',
    `compliance_phase` STRING COMMENT 'The CORSIA implementation phase applicable to this compliance record. Phase 1 (2021-2023) is pilot/voluntary, Phase 2 (2024-2026) expands participation, Phase 3 (2027-2035) is full implementation.. Valid values are `Phase 1|Phase 2|Phase 3`',
    `compliance_record_number` STRING COMMENT 'Externally-known unique business identifier for this CORSIA compliance record, used for regulatory submissions and audit trails.. Valid values are `^CORSIA-[A-Z0-9]{8,20}$`',
    `compliance_status` STRING COMMENT 'Current status of the CORSIA compliance record in its lifecycle. Tracks progression from draft through submission, review, and final determination of compliance or non-compliance.. Valid values are `draft|submitted|under_review|compliant|non_compliant|pending_remediation`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this CORSIA compliance record was first created in the system. Supports audit trail and data lineage.',
    `eligible_units_retired_tco2e` DECIMAL(18,2) COMMENT 'The quantity of CORSIA-eligible carbon offset units (in tCO2e) that have been retired by the operator to meet their offsetting obligation. Must come from ICAO-approved carbon offset programs.',
    `exemption_applied` BOOLEAN COMMENT 'Indicates whether any exemptions or special provisions were applied to this compliance record (e.g., small operator exemption, humanitarian flight exemption).',
    `exemption_reason` STRING COMMENT 'Description of the reason for any exemption applied, including regulatory basis and justification.',
    `growth_factor` DECIMAL(18,2) COMMENT 'The calculated growth factor representing the ratio of annual emissions to baseline emissions. Used to determine the operators share of offsetting obligations under CORSIA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this CORSIA compliance record was last updated or modified. Supports audit trail and change tracking.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this compliance record. Supports audit and accountability.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this CORSIA compliance record, including special circumstances, clarifications, or additional context.',
    `offset_unit_type` STRING COMMENT 'The type or category of carbon offset units retired (e.g., VCS, Gold Standard, CAR, ACR). Must be from ICAO CORSIA-eligible carbon crediting programs.',
    `offsetting_obligation_tco2e` DECIMAL(18,2) COMMENT 'The total carbon offsetting obligation in tonnes of CO2 equivalent that the airline operator must retire to achieve CORSIA compliance for the reporting period.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed for non-compliance with CORSIA obligations, if applicable. Currency is typically in the operators reporting currency or the competent authoritys currency.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `registry_confirmation_number` STRING COMMENT 'The unique confirmation or transaction number issued by the carbon offset registry confirming the retirement of eligible units. Used for audit and verification purposes.',
    `registry_name` STRING COMMENT 'The name of the carbon offset registry where the eligible units were retired (e.g., Verra Registry, Gold Standard Registry, American Carbon Registry).',
    `remediation_deadline` DATE COMMENT 'The deadline by which the operator must complete remediation actions to achieve compliance, if a shortfall or non-compliance was identified.',
    `remediation_plan_submitted` BOOLEAN COMMENT 'Indicates whether a remediation plan has been submitted to address any compliance shortfall or non-compliance issues.',
    `reporting_year` STRING COMMENT 'The calendar year for which this CORSIA compliance record applies. Annual reporting is required under CORSIA for international aviation emissions.',
    `retirement_date` DATE COMMENT 'The date on which the carbon offset units were officially retired in the registry to fulfill the CORSIA offsetting obligation.',
    `shortfall_tco2e` DECIMAL(18,2) COMMENT 'The difference between the offsetting obligation and the eligible units retired, representing any shortfall in compliance. Zero or null indicates full compliance.',
    `submission_date` DATE COMMENT 'The date on which the CORSIA compliance record was submitted to the competent authority or ICAO for review and verification.',
    `submission_deadline` DATE COMMENT 'The regulatory deadline by which the CORSIA compliance record must be submitted to the competent authority. Typically annual submission is required.',
    `verification_date` DATE COMMENT 'The date on which the third-party verification of the CORSIA compliance record was completed.',
    `verification_report_reference` STRING COMMENT 'Reference number or identifier of the verification report issued by the accredited verification body.',
    `verification_status` STRING COMMENT 'Status of third-party verification of the emissions data and offset retirement. CORSIA requires independent verification of emissions reports.. Valid values are `not_verified|verified|verification_failed`',
    `verifier_name` STRING COMMENT 'Name of the accredited third-party verification body that verified the emissions data and compliance record.',
    CONSTRAINT pk_corsia_compliance_record PRIMARY KEY(`corsia_compliance_record_id`)
) COMMENT 'Transactional compliance record for ICAO CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation) obligations per compliance period. Captures airline operator ID, compliance period (Phase 1, Phase 2), baseline emissions (tCO2e), growth factor, offsetting obligation (tCO2e), eligible units retired, registry confirmation, submission date, competent authority, and compliance status. Supports ICAO CORSIA annual reporting and offset retirement verification for international aviation routes.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` (
    `green_shipment_certificate_id` BIGINT COMMENT 'Unique identifier for the green shipment certificate record. Primary key.',
    `carbon_offset_program_id` BIGINT COMMENT 'Unique identifier or registry ID of the carbon offset program or project.',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Green certificates are issued per consignment for carbon-neutral shipping products. Customers request certificates for specific AWB/BOL shipments for their scope 3 reporting. Direct FK to consignment ',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that purchased the green shipment service and received this certificate.',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Green shipment certificates are bundled with shipment documentation packages for customer delivery as part of green logistics service offerings. Real business process: customers receive complete docum',
    `employee_id` BIGINT COMMENT 'Reference to the system user or automated process that issued this certificate.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.order. Business justification: Green certificates are issued per order when customers purchase carbon offsets or premium green logistics services. Real business process for carbon-neutral shipping programs. Certificate must referen',
    `saf_procurement_id` BIGINT COMMENT 'Foreign key linking to sustainability.saf_procurement. Business justification: When a green shipment certificate is issued for an air freight shipment that used Sustainable Aviation Fuel (SAF), the certificate should reference the SAF procurement batch. The saf_percentage attrib',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: A green shipment certificate is issued based on the calculated carbon footprint for a shipment. The certificates gross_co2e_kg, offset_co2e_kg, and net_co2e_kg are derived from the footprint calculat',
    `carbon_intensity_gco2e_per_tkm` DECIMAL(18,2) COMMENT 'Carbon intensity of the shipment, measured in grams of CO2 equivalent per tonne-kilometer.',
    `certificate_number` STRING COMMENT 'Externally-visible unique certificate number issued to the customer for this carbon-neutral or carbon-reduced shipment. Format: GSC-XXXXXXXXXX.. Valid values are `^GSC-[0-9]{10}$`',
    `certificate_pdf_url` STRING COMMENT 'URL to download the PDF version of the green shipment certificate for customer records and ESG reporting.. Valid values are `^https?://.*.pdf$`',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the green shipment certificate.. Valid values are `issued|active|expired|revoked|suspended`',
    `certificate_type` STRING COMMENT 'Type of green shipment certificate issued, indicating the level of carbon mitigation or sustainable transport option used. [ENUM-REF-CANDIDATE: carbon_neutral|carbon_reduced|saf_powered|green_freight|sustainable_ocean|sustainable_air|sustainable_road — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate record was first created in the system.',
    `customer_esg_report_flag` BOOLEAN COMMENT 'Indicates whether this certificate has been included in the customers ESG or sustainability reporting.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the shipment destination.. Valid values are `^[A-Z]{3}$`',
    `emission_factor_source` STRING COMMENT 'Source or standard used to calculate the emission factors for this shipment (e.g., GLEC Framework, DEFRA, EPA).',
    `green_product_tier` STRING COMMENT 'Commercial tier or level of the green logistics product purchased by the customer (e.g., carbon neutral, carbon reduced, SAF-powered).. Valid values are `carbon_neutral|carbon_reduced|saf_powered|eco_standard|eco_premium`',
    `gross_co2e_kg` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions generated by the shipment before any offsets or mitigation, measured in kilograms of CO2 equivalent.',
    `invoice_number` STRING COMMENT 'Reference to the invoice that includes the green shipment service charge.',
    `issuance_date` DATE COMMENT 'Date when the green shipment certificate was issued to the customer.',
    `issuance_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the certificate was generated and issued, including time zone.',
    `issuing_organization` STRING COMMENT 'Name of the Transport Shipping business unit or legal entity that issued the certificate.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate record was last updated in the system.',
    `net_co2e_kg` DECIMAL(18,2) COMMENT 'Net greenhouse gas emissions after applying offsets. Calculated as gross_co2e_kg minus offset_co2e_kg.',
    `notes` STRING COMMENT 'Additional notes or comments related to the green shipment certificate issuance or special circumstances.',
    `offset_co2e_kg` DECIMAL(18,2) COMMENT 'Quantity of CO2e offsets applied to this shipment through carbon offset programs, measured in kilograms.',
    `offset_credit_serial_number` STRING COMMENT 'Serial number or unique identifier of the carbon credit(s) retired or allocated to this shipment.',
    `offset_program_name` STRING COMMENT 'Name of the carbon offset program or project used to neutralize or reduce the shipment emissions (e.g., Gold Standard, Verified Carbon Standard, reforestation project).',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the shipment origin.. Valid values are `^[A-Z]{3}$`',
    `purchase_amount` DECIMAL(18,2) COMMENT 'Amount paid by the customer for the green shipment service or carbon offset purchase.',
    `purchase_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the purchase amount.. Valid values are `^[A-Z]{3}$`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this certificate has been used for regulatory compliance reporting (e.g., EU ETS, CORSIA).',
    `saf_percentage` DECIMAL(18,2) COMMENT 'Percentage of Sustainable Aviation Fuel used in the shipment, if applicable. Null for non-air shipments.',
    `shipment_distance_km` DECIMAL(18,2) COMMENT 'Total distance traveled by the shipment in kilometers, used for emissions calculation.',
    `shipment_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms, used for emissions calculation.',
    `transport_mode` STRING COMMENT 'Primary mode of transport used for the shipment covered by this certificate.. Valid values are `air|ocean|road|rail|multimodal`',
    `valid_from_date` DATE COMMENT 'Start date of the certificate validity period.',
    `valid_until_date` DATE COMMENT 'End date of the certificate validity period. Nullable for perpetual certificates.',
    `verification_qr_code` STRING COMMENT 'QR code data or reference that can be scanned to verify the certificate digitally.',
    `verification_url` STRING COMMENT 'URL where the customer or third party can digitally verify the authenticity and details of this green shipment certificate.. Valid values are `^https?://.*$`',
    CONSTRAINT pk_green_shipment_certificate PRIMARY KEY(`green_shipment_certificate_id`)
) COMMENT 'Customer-facing record of a carbon-neutral or carbon-reduced shipment certificate issued to a shipper upon purchase of carbon offsets or use of sustainable transport options. Captures certificate number, issuance date, customer account, shipment reference, gross CO2e, offset quantity applied, net CO2e, offset program used, certificate validity period, green product tier (carbon neutral, carbon reduced, SAF-powered), and digital verification URL. Supports customer ESG reporting and green logistics commercial propositions.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` (
    `saf_procurement_id` BIGINT COMMENT 'Unique identifier for the SAF procurement transaction record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the supplier contract or agreement under which this SAF procurement was executed.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Sustainable Aviation Fuel procurement is allocated to specific carriers for CORSIA compliance and carbon reduction commitments. Airlines procure SAF through book-and-claim or physical delivery for spe',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: SAF purchases require GL account posting for inventory valuation and expense recognition in financial statements. Real business process: alternative fuel inventory accounting and cost of goods sold ca',
    `compliance_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.compliance_period. Business justification: SAF procurement directly supports CORSIA compliance obligations (corsia_eligible_flag exists on the record). Linking SAF procurement to the compliance period it serves enables tracking of how much SAF',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sustainable Aviation Fuel procurement costs are allocated to aviation operations cost centers for alternative fuel program cost tracking and budget management. Required for SAF program financial perfo',
    `employee_id` BIGINT COMMENT 'User identifier of the person or system that created this SAF procurement record.',
    `facility_id` BIGINT COMMENT 'Identifier of the warehouse or storage facility where the SAF is stored after delivery.',
    `supplier_id` BIGINT COMMENT 'Identifier of the SAF supplier or producer providing the fuel.',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: SAF procurement requires sustainability certification documents (CORSIA batch certificates, ISCC EU certification, RSB certification). Real business process: sustainable aviation fuel compliance verif',
    `blending_ratio_percentage` DECIMAL(18,2) COMMENT 'Percentage of SAF blended with conventional jet fuel for operational use, typically ranging from 0% to 50% per ASTM D7566 specifications.',
    `book_and_claim_certificate_reference` STRING COMMENT 'Reference number for the Book-and-Claim certificate associated with this SAF procurement, enabling physical and environmental attribute separation.',
    `certification_number` STRING COMMENT 'Unique certification number or identifier issued by the certification scheme for this SAF batch.',
    `certification_scheme` STRING COMMENT 'Sustainability certification scheme under which this SAF is certified. ISCC = International Sustainability and Carbon Certification, RSB = Roundtable on Sustainable Biomaterials, SCS = Scientific Certification Systems, LCFS = Low Carbon Fuel Standard, RED II = Renewable Energy Directive II, RTFO = Renewable Transport Fuel Obligation.. Valid values are `ISCC|RSB|SCS|LCFS|RED_II|RTFO`',
    `conventional_jet_fuel_displaced_litres` DECIMAL(18,2) COMMENT 'Volume of conventional jet fuel displaced by this SAF procurement, measured in litres. Used for calculating Scope 1 emissions reductions.',
    `corsia_batch_number` STRING COMMENT 'CORSIA-registered batch identifier for this SAF procurement, used for regulatory reporting and traceability.',
    `corsia_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SAF procurement meets CORSIA eligibility criteria and can be used for CORSIA compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SAF procurement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the procurement transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_allocation_flag` BOOLEAN COMMENT 'Indicates whether this SAF procurement has been allocated to specific customer shipments for customer-facing carbon reporting.',
    `delivery_date` DATE COMMENT 'Date when the SAF was delivered to the designated airport, depot, or storage facility.',
    `delivery_location_code` STRING COMMENT 'IATA airport code or facility code where the SAF was delivered (e.g., JFK, LHR, AMS).. Valid values are `^[A-Z]{3,4}$`',
    `delivery_location_name` STRING COMMENT 'Full name of the airport, depot, or storage facility where the SAF was delivered.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the SAF delivery was completed, used for operational tracking and SLA compliance.',
    `energy_content_mj` DECIMAL(18,2) COMMENT 'Total energy content of the procured SAF measured in megajoules, used for lifecycle emissions intensity calculations.',
    `feedstock_origin` STRING COMMENT 'Geographic origin or source description of the feedstock used in SAF production (e.g., used cooking oil from Europe, municipal solid waste from USA).',
    `feedstock_type` STRING COMMENT 'Type of feedstock and production pathway used to produce the SAF. HEFA = Hydroprocessed Esters and Fatty Acids, ATJ = Alcohol-to-Jet, FT-SPK = Fischer-Tropsch Synthetic Paraffinic Kerosene, SIP = Synthesized Iso-Paraffins, CHJ = Catalytic Hydrothermolysis Jet.. Valid values are `HEFA|ATJ|FT-SPK|SIP|CHJ|HEFA-SPK`',
    `ghg_emissions_reduction_tonnes_co2e` DECIMAL(18,2) COMMENT 'Total GHG emissions reduction achieved by this SAF procurement compared to conventional jet fuel baseline, measured in tonnes of CO2 equivalent.',
    `intended_use` STRING COMMENT 'Intended use case for the procured SAF: operational blending for direct use in aircraft, book-and-claim for environmental attribute transfer, carbon offset programs, or research and development.. Valid values are `operational_blending|book_and_claim|carbon_offset|research_development`',
    `invoice_number` STRING COMMENT 'Supplier invoice number associated with this SAF procurement transaction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SAF procurement record was last updated or modified.',
    `lifecycle_ghg_intensity_gco2e_per_mj` DECIMAL(18,2) COMMENT 'Lifecycle greenhouse gas emissions intensity of the SAF, measured in grams of CO2 equivalent per megajoule of energy. This value includes well-to-wake emissions and is used to calculate emissions reductions versus conventional jet fuel.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this SAF procurement transaction, including special handling instructions or exceptions.',
    `payment_due_date` DATE COMMENT 'Date by which payment is due to the SAF supplier per contract terms.',
    `payment_status` STRING COMMENT 'Current payment status for this SAF procurement transaction.. Valid values are `pending|paid|partially_paid|overdue|disputed`',
    `procurement_date` DATE COMMENT 'Date when the SAF procurement transaction was initiated or confirmed with the supplier.',
    `procurement_reference_number` STRING COMMENT 'Externally-known business identifier for this SAF procurement transaction, used for supplier coordination and audit trails.. Valid values are `^SAF-[0-9]{8}-[A-Z0-9]{6}$`',
    `procurement_status` STRING COMMENT 'Current lifecycle status of the SAF procurement transaction. [ENUM-REF-CANDIDATE: draft|confirmed|in_transit|delivered|invoiced|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `purchase_order_number` STRING COMMENT 'Purchase order number from the procurement system (e.g., Coupa) associated with this SAF procurement.',
    `saf_volume_gallons` DECIMAL(18,2) COMMENT 'Total volume of SAF procured in this transaction, measured in US gallons, for regions using imperial units.',
    `saf_volume_litres` DECIMAL(18,2) COMMENT 'Total volume of SAF procured in this transaction, measured in litres.',
    `sustainability_report_flag` BOOLEAN COMMENT 'Indicates whether this SAF procurement has been included in external sustainability or ESG reporting disclosures.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the SAF procurement transaction, including all charges and fees.',
    `unit_price_per_litre` DECIMAL(18,2) COMMENT 'Price per litre of SAF in the procurement transaction currency.',
    CONSTRAINT pk_saf_procurement PRIMARY KEY(`saf_procurement_id`)
) COMMENT 'Transactional record for Sustainable Aviation Fuel (SAF) procurement events. Captures SAF supplier, feedstock type (HEFA, AtJ, FT-SPK), SAF volume (litres), energy content, lifecycle GHG intensity (gCO2e/MJ), conventional jet fuel displaced, CORSIA eligibility, Book-and-Claim certificate reference, delivery date, airport/depot, unit price, total cost, and certification scheme (ISCC, RSB, SCS). Supports SAF blending compliance, CORSIA eligible fuel tracking, and Scope 1 emissions reduction accounting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` (
    `renewable_energy_certificate_id` BIGINT COMMENT 'Unique identifier for the renewable energy certificate record. Primary key.',
    `facility_inspection_id` BIGINT COMMENT 'Foreign key linking to safety.facility_inspection. Business justification: Solar panel installations, wind turbines, battery energy storage systems require regular safety inspections for fire code compliance, electrical safety, structural integrity. Renewable energy procurem',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: RECs directly support Scope 2 market-based emissions reductions reported in the GHG inventory. Linking RECs to the GHG inventory they contribute to enables traceability of renewable energy claims in e',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: RECs are procured to cover energy consumption at facilities operated by network partners (warehouses, hubs, terminals). Scope 3 emissions reporting requires tracking which partners facilities are cov',
    `cdp_reportable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this certificate is eligible for reporting in CDP Climate Change disclosures (True/False).',
    `certificate_number` STRING COMMENT 'The externally-issued unique certificate number or serial number assigned by the issuing registry (e.g., APX, M-RETS, I-REC). This is the business identifier for the certificate.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the certificate: active (available for use), retired (applied to emissions accounting), cancelled (voided), expired (past validity period), pending (awaiting registry confirmation).. Valid values are `active|retired|cancelled|expired|pending`',
    `certificate_type` STRING COMMENT 'Type of renewable energy certificate: REC (Renewable Energy Certificate - North America), GO (Guarantee of Origin - Europe), I-REC (International REC), TIGR (The International Greenhouse Gas Registry), LGC (Large-scale Generation Certificate - Australia), or Other.. Valid values are `REC|GO|I-REC|TIGR|LGC|Other`',
    `co2e_avoided_tonnes` DECIMAL(18,2) COMMENT 'Quantity of Scope 2 greenhouse gas emissions avoided (in metric tonnes CO2e) by applying this renewable energy certificate under the market-based method. Calculated as energy_quantity_mwh multiplied by the grid emission factor for the facility location.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the procurement contract or Power Purchase Agreement (PPA) under which this certificate was acquired, if applicable.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost paid to procure this certificate, in the transaction currency.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_per_mwh` DECIMAL(18,2) COMMENT 'Unit cost per megawatt-hour (cost_amount divided by energy_quantity_mwh), used for cost benchmarking and procurement analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate record was first created in the system.',
    `energy_quantity_mwh` DECIMAL(18,2) COMMENT 'Quantity of renewable electricity covered by this certificate, measured in megawatt-hours (MWh). Typically one certificate represents 1 MWh.',
    `energy_source` STRING COMMENT 'Type of renewable energy source that generated the electricity covered by this certificate: solar, wind, hydro, biomass, geothermal, tidal, or Other. [ENUM-REF-CANDIDATE: solar|wind|hydro|biomass|geothermal|tidal|Other — 7 candidates stripped; promote to reference product]',
    `expiry_date` DATE COMMENT 'Date after which the certificate is no longer valid for retirement or use in emissions accounting, per registry rules.',
    `facility_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the facility covered by this certificate (e.g., USA, DEU, CHN). Used for market-based Scope 2 accounting by geography.. Valid values are `^[A-Z]{3}$`',
    `facility_covered` STRING COMMENT 'Name or identifier of the Transport Shipping facility (warehouse, office, distribution center, ground operations hub) whose electricity consumption this certificate is applied to.',
    `generating_facility_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the generating facility is located (e.g., USA, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `generating_facility_location` STRING COMMENT 'Geographic location of the generating facility, typically city and state/province or region.',
    `generating_facility_name` STRING COMMENT 'Name of the renewable energy generating facility or power plant that produced the electricity covered by this certificate.',
    `generation_end_date` DATE COMMENT 'End date of the generation period covered by this certificate.',
    `generation_start_date` DATE COMMENT 'Start date of the generation period covered by this certificate.',
    `grid_emission_factor_kg_co2e_per_mwh` DECIMAL(18,2) COMMENT 'The location-based grid emission factor (kg CO2e per MWh) for the facilitys electricity grid, used to calculate the emissions avoided by this certificate.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about this certificate (e.g., special procurement circumstances, allocation decisions, audit findings).',
    `procurement_date` DATE COMMENT 'Date when the organization procured or purchased this certificate.',
    `procurement_method` STRING COMMENT 'Method by which the certificate was procured: direct_purchase (spot market), PPA (Power Purchase Agreement), unbundled (certificate only), bundled (with electricity delivery), or Other.. Valid values are `direct_purchase|PPA|unbundled|bundled|Other`',
    `re100_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this certificate meets RE100 technical criteria for renewable electricity sourcing commitments (True/False).',
    `registry_account_number` STRING COMMENT 'The organizations account number or identifier in the certificate registry where this certificate is held.',
    `registry_name` STRING COMMENT 'Name of the certificate registry or tracking system that issued and tracks this certificate (e.g., APX, M-RETS, I-REC Registry, AIB Hub).',
    `reporting_period` STRING COMMENT 'The fiscal or calendar reporting period (e.g., FY2023, Q1 2024, 2023) to which this certificate is allocated for emissions accounting.',
    `retirement_date` DATE COMMENT 'Date when the certificate was retired in the registry to claim the environmental attributes for Scope 2 emissions accounting. Retired certificates cannot be resold or reused.',
    `retirement_reason` STRING COMMENT 'Business reason or purpose for retiring the certificate (e.g., Scope 2 market-based accounting for FY2023, RE100 commitment, Customer carbon reporting).',
    `supplier_name` STRING COMMENT 'Name of the supplier or broker from whom the certificate was purchased.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate record was last updated in the system.',
    `verification_date` DATE COMMENT 'Date when third-party verification of this certificate was completed.',
    `verification_status` STRING COMMENT 'Status of third-party verification or audit of this certificate for ESG reporting: verified (audited and confirmed), pending (under review), not_verified (not yet audited).. Valid values are `verified|pending|not_verified`',
    `verifier_name` STRING COMMENT 'Name of the third-party verifier or auditor who verified this certificate for ESG reporting, if applicable.',
    `vintage_year` STRING COMMENT 'The calendar year in which the renewable electricity was generated. Critical for matching certificate vintage to reporting period per GHG Protocol.',
    CONSTRAINT pk_renewable_energy_certificate PRIMARY KEY(`renewable_energy_certificate_id`)
) COMMENT 'Master record for Renewable Energy Certificates (RECs) or Guarantees of Origin (GOs) procured to cover electricity consumption at warehouses, offices, and ground operations. Captures certificate type (REC, GO, I-REC), energy source (solar, wind, hydro), generating facility, country, vintage year, MWh quantity, registry account, retirement date, facility covered, and market-based Scope 2 accounting impact (tCO2e avoided). Supports market-based Scope 2 emissions reporting under GHG Protocol and RE100 commitment tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` (
    `waste_record_id` BIGINT COMMENT 'Unique identifier for the waste record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Waste disposal costs are allocated to facility cost centers for operating expense management. Reuses existing cost_center_id(unlinked) column. Required for facility cost allocation and waste managemen',
    `environmental_incident_id` BIGINT COMMENT 'Foreign key linking to safety.environmental_incident. Business justification: Waste disposal incidents (spills, improper disposal, container failures, hazmat releases) trigger environmental incident reports. Regulatory compliance (RCRA, Basel Convention, EU Waste Directive) req',
    `facility_id` BIGINT COMMENT 'Identifier of the facility (warehouse, depot, office, hub, terminal) where the waste was generated.',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Waste records with GHG emissions (Scope 3 Category 5 - waste generated in operations) are aggregated into periodic GHG inventories. Waste disposal methods (landfill, incineration) generate GHG emissio',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the waste record.',
    `supplier_id` BIGINT COMMENT 'Identifier of the third-party waste management contractor responsible for collection and disposal.',
    `tertiary_waste_approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who approved the waste record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste record was approved for ESG reporting and compliance purposes.',
    `audit_notes` STRING COMMENT 'Free-text notes for audit purposes, capturing any exceptions, issues, or additional context related to the waste record.',
    `collection_date` DATE COMMENT 'Date when the waste was collected from the facility by the waste contractor.',
    `compliance_status` STRING COMMENT 'Status indicating whether the waste record meets regulatory compliance requirements (e.g., compliant, non-compliant, pending review, exempt).. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost incurred for waste collection and disposal services during the reporting period.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the waste disposal cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste record was first created in the system.',
    `disposal_date` DATE COMMENT 'Date when the waste was disposed of or processed by the waste contractor.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the waste (e.g., recycling, landfill, incineration, composting, reuse, energy recovery).. Valid values are `recycling|landfill|incineration|composting|reuse|energy_recovery`',
    `diversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of waste diverted from landfill through recycling, composting, or reuse. Key metric for zero-waste-to-landfill targets.',
    `emissions_factor_source` STRING COMMENT 'Source of the emissions factor used to calculate GHG emissions (e.g., GHG Protocol, DEFRA, EPA, custom factor).',
    `esg_reporting_category` STRING COMMENT 'ESG reporting category to which this waste record contributes (environmental, social, governance). Primarily environmental for waste management.. Valid values are `environmental|social|governance`',
    `ghg_emissions_tco2e` DECIMAL(18,2) COMMENT 'Greenhouse gas emissions associated with the waste disposal method, measured in tonnes of carbon dioxide equivalent (tCO2e). Used for ESG reporting and carbon footprint calculations.',
    `is_hazardous` BOOLEAN COMMENT 'Flag indicating whether the waste is classified as hazardous under applicable regulations (True/False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste record was last modified.',
    `record_status` STRING COMMENT 'Current lifecycle status of the waste record (e.g., draft, submitted, approved, rejected, archived).. Valid values are `draft|submitted|approved|rejected|archived`',
    `regulatory_classification_code` STRING COMMENT 'Regulatory classification code for the waste type, such as IMDG (International Maritime Dangerous Goods) hazardous waste codes or local waste classification codes.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period for which waste data is captured.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period for which waste data is captured.',
    `waste_certificate_number` STRING COMMENT 'Certificate or consignment note number issued by the waste contractor as proof of proper disposal, required for regulatory compliance and audit trails.',
    `waste_contractor_name` STRING COMMENT 'Name of the waste management contractor responsible for handling the waste stream.',
    `waste_description` STRING COMMENT 'Detailed description of the waste material, including composition, contamination level, and any special handling requirements.',
    `waste_quantity` DECIMAL(18,2) COMMENT 'Quantity of waste generated during the reporting period, measured in the unit specified by waste_quantity_unit.',
    `waste_quantity_unit` STRING COMMENT 'Unit of measure for the waste quantity (e.g., kg, tonnes, cubic meters, liters).. Valid values are `kg|tonnes|m3|liters`',
    `waste_record_number` STRING COMMENT 'Business identifier for the waste record, used for tracking and audit purposes.',
    `waste_source_area` STRING COMMENT 'Specific area or department within the facility where the waste was generated (e.g., warehouse floor, office, cafeteria, loading dock, maintenance shop).',
    `waste_stream_type` STRING COMMENT 'Classification of the waste stream generated (e.g., cardboard, plastic, hazardous, e-waste, food, general waste).. Valid values are `cardboard|plastic|hazardous|e-waste|food|general`',
    `zero_waste_target_contribution` BOOLEAN COMMENT 'Flag indicating whether this waste record contributes positively toward the organizations zero-waste-to-landfill target (True/False).',
    CONSTRAINT pk_waste_record PRIMARY KEY(`waste_record_id`)
) COMMENT 'Operational record capturing waste generation and disposal data at facility level (warehouse, depot, office, hub). Stores facility ID, reporting period, waste stream type (cardboard, plastic, hazardous, e-waste, food), quantity (kg or tonnes), disposal method (recycling, landfill, incineration, composting, reuse), waste contractor, diversion rate %, regulatory classification (IMDG hazardous waste codes), and associated GHG emissions (tCO2e). Supports ESG social and environmental reporting, ISO 14001 compliance, and zero-waste-to-landfill target tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` (
    `energy_consumption_record_id` BIGINT COMMENT 'Unique identifier for the energy consumption record. Primary key for this operational record capturing energy usage at facility or asset level.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Energy costs are allocated to facility or fleet cost centers for utility cost management and energy efficiency program ROI calculation. Essential for facility operating expense tracking and budget var',
    `emissions_factor_id` BIGINT COMMENT 'Identifier of the emission factor used to calculate CO2e emissions from this energy consumption. Links to the emission factor reference table containing conversion coefficients by energy type, region, and reporting year.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility (warehouse, distribution center, terminal, office) where energy was consumed. Links to facility master data.',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Energy consumption records represent Scope 2 emissions (purchased electricity, heating, cooling) and are aggregated into periodic GHG inventories. Each energy consumption event contributes to the tota',
    `transport_asset_id` BIGINT COMMENT 'Identifier of the specific asset or equipment (vehicle, forklift, HVAC unit, conveyor) consuming energy. Nullable when consumption is facility-level rather than asset-specific.',
    `baseline_year` STRING COMMENT 'Reference year against which energy consumption and emissions reductions are measured. Used to track progress toward sustainability targets and regulatory compliance (e.g., EU ETS baseline, CORSIA baseline).',
    `consumption_quantity` DECIMAL(18,2) COMMENT 'Quantity of energy consumed during the measurement period. Numeric value representing the amount of energy used, expressed in the unit specified in consumption_unit.',
    `consumption_unit` STRING COMMENT 'Unit of measure for the consumption quantity. Specifies whether energy is measured in kilowatt-hours (kWh), megawatt-hours (MWh), gigajoules (GJ), litres, gallons, cubic meters (m3), or kilograms (kg). [ENUM-REF-CANDIDATE: kWh|MWh|GJ|litre|gallon|m3|kg — 7 candidates stripped; promote to reference product]',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this energy consumption in the billing currency. Includes base energy charges, distribution charges, and applicable taxes. Used for energy spend analysis and cost allocation.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP). Specifies the currency in which energy costs are denominated.. Valid values are `^[A-Z]{3}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the energy consumption occurred. Used to apply region-specific emission factors and comply with national reporting requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this energy consumption record was first created in the system. Audit trail field for data lineage and compliance.',
    `customer_facing_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this energy consumption record contributes to customer-facing carbon footprint reporting (e.g., shipment-level CO2e disclosure). True if the record is used in customer carbon reports; false otherwise.',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and reliability of the consumption data. Flags records that are verified (high confidence), estimated (modeled or interpolated), incomplete (missing fields), anomalous (outlier detection triggered), or pending review (awaiting validation).. Valid values are `verified|estimated|incomplete|anomaly|pending_review`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall quality and completeness of this consumption record, ranging from 0.00 (lowest quality) to 100.00 (highest quality). Calculated based on metering source reliability, completeness of fields, and validation checks.',
    `energy_intensity_denominator` DECIMAL(18,2) COMMENT 'Denominator value used to calculate energy intensity ratio (e.g., number of shipments, TEUs handled, square meters of warehouse space, vehicle kilometers traveled). Enables normalization of energy consumption for benchmarking.',
    `energy_intensity_unit` STRING COMMENT 'Unit of measure for the energy intensity denominator (e.g., shipment, TEU, square_meter, vehicle_km). Specifies the operational metric against which energy consumption is normalized.',
    `energy_type` STRING COMMENT 'Type of energy consumed. Categorizes the fuel or energy source used during the measurement period. Critical for Scope 1 vs Scope 2 emissions classification per GHG Protocol.. Valid values are `electricity|natural_gas|diesel|gasoline|lpg|district_heat`',
    `invoice_number` STRING COMMENT 'Invoice number from the energy supplier corresponding to this consumption record. Nullable when consumption is metered directly rather than derived from invoice.',
    `measurement_period_end` TIMESTAMP COMMENT 'End date and time of the energy consumption measurement period. Defines the conclusion of the interval for which energy usage is recorded.',
    `measurement_period_start` TIMESTAMP COMMENT 'Start date and time of the energy consumption measurement period. Defines the beginning of the interval for which energy usage is recorded.',
    `meter_code` STRING COMMENT 'Unique identifier of the physical or virtual meter that recorded the consumption. Nullable when consumption is derived from invoice or estimate rather than direct metering.',
    `metering_source` STRING COMMENT 'Source or method by which the energy consumption data was captured. Indicates whether the measurement came from a smart meter, manual meter reading, utility invoice, estimation model, IoT sensor, or vehicle telematics system.. Valid values are `smart_meter|manual_meter|invoice|estimate|iot_sensor|telematics`',
    `notes` STRING COMMENT 'Free-text field for additional context, explanations, or annotations related to this energy consumption record. May include details about anomalies, estimation methodologies, or special circumstances.',
    `operational_context` STRING COMMENT 'Description of the operational activity or process associated with this energy consumption (e.g., warehouse operations, last-mile delivery, line-haul transport, office administration). Enables activity-based energy intensity analysis.',
    `region_code` STRING COMMENT 'Sub-national region or state code where the energy consumption occurred. Used for regional energy intensity benchmarking and grid-specific emission factor application.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this energy consumption record is included in mandatory regulatory reporting (e.g., EU ETS, CORSIA, national GHG inventories). True if the record is part of a regulatory submission; false otherwise.',
    `renewable_energy_share_percent` DECIMAL(18,2) COMMENT 'Percentage of the consumed energy that came from renewable sources (solar, wind, hydro, biomass). Used to calculate net emissions and support green logistics reporting. Value between 0.00 and 100.00.',
    `reporting_period` STRING COMMENT 'Reporting period granularity for this consumption record (quarterly, monthly, or annual). Aligns with internal and external sustainability reporting cycles.. Valid values are `Q1|Q2|Q3|Q4|monthly|annual`',
    `reporting_year` STRING COMMENT 'Calendar or fiscal year to which this energy consumption record is attributed for regulatory and sustainability reporting purposes. Used to aggregate annual energy and emissions inventories.',
    `scope_1_emissions_tco2e` DECIMAL(18,2) COMMENT 'Direct greenhouse gas emissions in metric tons of carbon dioxide equivalent (tCO2e) resulting from this energy consumption. Applies to combustion of fossil fuels owned or controlled by the organization (diesel, natural gas, LPG). Calculated using emission factors per GHG Protocol.',
    `scope_2_emissions_tco2e` DECIMAL(18,2) COMMENT 'Indirect greenhouse gas emissions in metric tons of carbon dioxide equivalent (tCO2e) from purchased electricity, heat, or steam. Calculated using grid emission factors adjusted for renewable energy share per GHG Protocol Scope 2 Guidance.',
    `supplier_account_number` STRING COMMENT 'Account number or customer reference assigned by the energy supplier. Used to reconcile consumption records with utility invoices.',
    `supplier_name` STRING COMMENT 'Name of the utility company or energy supplier providing the energy. Used for supplier performance tracking and contract management.',
    `tariff_name` STRING COMMENT 'Name or identifier of the energy tariff or rate plan under which this consumption was billed. Examples include time-of-use tariffs, flat-rate plans, or demand-based pricing structures.',
    `updated_by` STRING COMMENT 'Identifier of the user, system, or process that last modified this energy consumption record. Audit trail field for accountability and data governance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this energy consumption record was last modified. Audit trail field for data lineage and compliance.',
    `verification_date` DATE COMMENT 'Date on which this energy consumption record was verified or audited. Nullable for unverified records.',
    `verification_status` STRING COMMENT 'Status indicating the level of verification or assurance applied to this energy consumption record. Unverified records have not been reviewed; internally verified records passed internal quality checks; third-party verified records were validated by external auditors; audited records are part of a formal compliance audit.. Valid values are `unverified|internally_verified|third_party_verified|audited`',
    `verified_by` STRING COMMENT 'Name or identifier of the individual, team, or third-party organization that verified this energy consumption record. Nullable for unverified records.',
    `created_by` STRING COMMENT 'Identifier of the user, system, or process that created this energy consumption record. Audit trail field for accountability and data governance.',
    CONSTRAINT pk_energy_consumption_record PRIMARY KEY(`energy_consumption_record_id`)
) COMMENT 'Operational record capturing energy consumption at facility or asset level for a defined period. Stores facility or asset ID, energy type (electricity, natural gas, diesel, LPG, district heat), consumption quantity (kWh, GJ, or litres), metering source (smart meter, invoice, estimate), renewable energy share %, associated Scope 1 or Scope 2 emissions (tCO2e), tariff or supplier, and data quality flag. Primary input for Scope 1 and Scope 2 GHG inventory calculations and energy intensity benchmarking across the logistics network.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`initiative` (
    `initiative_id` BIGINT COMMENT 'Unique identifier for the sustainability initiative. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Sustainability initiatives often target specific carrier partnerships for modal shift programs, fleet electrification, or efficiency improvements. Tracking carrier-specific initiatives is essential fo',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Sustainability initiatives are launched to achieve specific sustainability targets. Each initiative is designed to contribute to target achievement (e.g., EV fleet initiative supports Scope 1 emission',
    `actual_co2e_reduction_tco2e_per_year` DECIMAL(18,2) COMMENT 'Measured annual reduction in greenhouse gas emissions in metric tonnes of CO2 equivalent (tCO2e) achieved by the initiative based on actual performance data. Null if initiative has not yet delivered measurable reductions.',
    `actual_completion_date` DATE COMMENT 'Actual date when the sustainability initiative was completed and became fully operational. Null if initiative is not yet completed.',
    `approval_date` DATE COMMENT 'Date when the sustainability initiative was formally approved by management or the sustainability governance committee.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive, manager, or committee that approved the sustainability initiative.',
    `baseline_co2e_emissions_tco2e_per_year` DECIMAL(18,2) COMMENT 'Baseline annual GHG emissions in metric tonnes of CO2 equivalent (tCO2e) measured before the initiative was implemented, used as the reference point for calculating emission reductions.',
    `baseline_measurement_date` DATE COMMENT 'Date when the baseline environmental performance measurement was taken, against which the initiatives impact will be compared.',
    `capex_investment_amount` DECIMAL(18,2) COMMENT 'Total capital expenditure investment allocated or spent on the sustainability initiative, including costs for equipment, infrastructure, and long-term assets.',
    `corporate_sustainability_target_alignment` STRING COMMENT 'Description of how this initiative aligns with and contributes to the organizations corporate sustainability targets, such as net-zero commitments, Science Based Targets initiative (SBTi) goals, or specific ESG objectives.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sustainability initiative record was first created in the system.',
    `customer_facing_flag` BOOLEAN COMMENT 'Indicates whether this sustainability initiative is customer-facing and contributes to customer carbon reporting, green logistics offerings, or ESG disclosure to clients.',
    `expected_completion_date` DATE COMMENT 'Planned or forecasted date by which the sustainability initiative is expected to be fully implemented and operational.',
    `external_certification_target` STRING COMMENT 'Name of external certification, accreditation, or recognition program that this initiative aims to achieve (e.g., ISO 14001, LEED certification, Carbon Neutral certification, EcoVadis rating).',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the sustainability initiative, indicating whether it applies globally, regionally (e.g., Europe, Asia-Pacific), or to specific countries or facilities.',
    `initiative_category` STRING COMMENT 'Classification of the sustainability initiative type: fleet electrification (transition to electric vehicles), route optimisation (fuel-efficient routing), packaging reduction (waste minimization), modal shift (air to ocean/rail), SAF adoption (Sustainable Aviation Fuel), or solar installation (renewable energy infrastructure).. Valid values are `fleet_electrification|route_optimisation|packaging_reduction|modal_shift|saf_adoption|solar_installation`',
    `initiative_code` STRING COMMENT 'Externally-known unique business identifier for the sustainability initiative, used for tracking and reporting across systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `initiative_description` STRING COMMENT 'Detailed narrative description of the sustainability initiative, including objectives, scope, implementation approach, and expected environmental benefits.',
    `initiative_name` STRING COMMENT 'Human-readable name of the sustainability initiative describing the green logistics project or decarbonisation effort.',
    `initiative_status` STRING COMMENT 'Current lifecycle status of the sustainability initiative indicating whether it is planned, actively in progress, completed, cancelled, or temporarily on hold.. Valid values are `planned|in_progress|completed|cancelled|on_hold`',
    `investment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the CAPEX and OPEX investment amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `key_performance_indicator` STRING COMMENT 'Primary KPI or metric used to measure the success and environmental impact of the sustainability initiative (e.g., tCO2e reduced per year, percentage reduction in fuel consumption, renewable energy percentage).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sustainability initiative record was last updated or modified in the system.',
    `last_review_date` DATE COMMENT 'Date when the sustainability initiative was last reviewed for performance, progress, and alignment with corporate sustainability goals.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the sustainability initiatives performance and progress.',
    `opex_investment_amount` DECIMAL(18,2) COMMENT 'Total operating expenditure investment allocated or spent on the sustainability initiative, including recurring costs for operations, maintenance, and program management.',
    `owner_email` STRING COMMENT 'Email address of the initiative owner for communication and coordination purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Name of the individual or role responsible for leading and managing the sustainability initiative.',
    `projected_co2e_reduction_tco2e_per_year` DECIMAL(18,2) COMMENT 'Estimated annual reduction in greenhouse gas emissions measured in metric tonnes of CO2 equivalent (tCO2e) that the initiative is projected to achieve once fully implemented.',
    `regulatory_compliance_driver` STRING COMMENT 'Specific regulatory requirement, compliance framework, or environmental legislation that drives or mandates this sustainability initiative (e.g., EU ETS, CORSIA, national carbon tax, local emissions standards).',
    `risk_assessment_summary` STRING COMMENT 'Summary of key risks, challenges, and mitigation strategies associated with the implementation and success of the sustainability initiative.',
    `roi_payback_period_months` STRING COMMENT 'Estimated or actual payback period in months for the sustainability initiative investment, calculated based on cost savings and financial benefits.',
    `scope_1_impact_flag` BOOLEAN COMMENT 'Indicates whether this initiative directly impacts Scope 1 emissions (direct GHG emissions from owned or controlled sources such as company-owned vehicles and facilities).',
    `scope_2_impact_flag` BOOLEAN COMMENT 'Indicates whether this initiative directly impacts Scope 2 emissions (indirect GHG emissions from purchased electricity, steam, heating, and cooling).',
    `scope_3_impact_flag` BOOLEAN COMMENT 'Indicates whether this initiative directly impacts Scope 3 emissions (all other indirect GHG emissions in the value chain, including upstream and downstream activities).',
    `sponsoring_business_unit` STRING COMMENT 'Name or code of the business unit, division, or department that sponsors and owns this sustainability initiative (e.g., Express Parcel Delivery, Freight Forwarding, Warehouse Operations).',
    `start_date` DATE COMMENT 'Date when the sustainability initiative officially commenced or is planned to commence.',
    CONSTRAINT pk_initiative PRIMARY KEY(`initiative_id`)
) COMMENT 'Master record for internal green logistics initiatives and decarbonisation projects. Captures initiative name, category (fleet electrification, route optimisation, packaging reduction, modal shift, SAF adoption, solar installation), sponsoring business unit, start date, expected completion date, projected CO2e reduction (tCO2e/year), actual CO2e reduction achieved, CAPEX/OPEX investment, status (planned, in-progress, completed, cancelled), and alignment to corporate sustainability target. Enables portfolio management of green initiatives and ROI tracking for ESG investment.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` (
    `supplier_emissions_disclosure_id` BIGINT COMMENT 'Unique identifier for the supplier emissions disclosure record.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier if the disclosure is specific to a transportation carrier partner.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Supplier emissions data is collected and reported by fiscal period for Scope 3 reporting aligned with financial reporting cycles. Required for integrated supply chain sustainability and financial perf',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Supplier emissions disclosures (Scope 3 Category 4 - upstream transportation and distribution) are aggregated into the companys GHG inventory. Each supplier disclosure contributes to the total Scope ',
    `shipment_carrier_assignment_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_carrier_assignment. Business justification: Carrier emissions disclosures validate emission factors used in shipment carbon footprint calculations. Auditors and sustainability teams trace specific carrier assignments to disclosed emission inten',
    `supplier_id` BIGINT COMMENT 'Identifier of the carrier, third-party logistics (3PL) provider, or supplier submitting the emissions disclosure.',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: Supplier emissions disclosures require third-party verification certificates for CDP reporting and supply chain emissions assurance. Real business process: Scope 3 Category 4 (upstream transportation)',
    `acceptance_date` DATE COMMENT 'Date when the emissions disclosure was accepted by Transport Shipping for inclusion in Scope 3 emissions accounting.',
    `alternative_fuel_usage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the suppliers fleet or operations using alternative fuels (biofuels, electric, hydrogen, etc.) during the reporting period.',
    `calculation_approach` STRING COMMENT 'Approach used by the supplier to calculate emissions (fuel-based, distance-based, spend-based, activity-based, or hybrid).. Valid values are `fuel_based|distance_based|spend_based|activity_based|hybrid`',
    `cdp_disclosure_year` STRING COMMENT 'Year of the CDP disclosure corresponding to the CDP score.',
    `cdp_score` STRING COMMENT 'The suppliers most recent Carbon Disclosure Project (CDP) climate change score, indicating their level of environmental disclosure and performance. [ENUM-REF-CANDIDATE: A|A-|B|B-|C|C-|D|D-|F — 9 candidates stripped; promote to reference product]',
    `corsia_eligible_flag` BOOLEAN COMMENT 'Flag indicating whether the suppliers emissions data and methodology are eligible for use under the Carbon Offsetting and Reduction Scheme for International Aviation (CORSIA).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier emissions disclosure record was first created in the system.',
    `data_completeness_percentage` DECIMAL(18,2) COMMENT 'Percentage of the suppliers operations covered by the disclosed emissions data, indicating the completeness of the disclosure.',
    `data_quality_tier` STRING COMMENT 'Quality tier of the emissions data disclosed by the supplier, ranging from Tier 1 (primary/measured data) to Tier 4 (proxy/industry average data).. Valid values are `tier_1_primary|tier_2_secondary|tier_3_estimated|tier_4_proxy`',
    `disclosure_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any financial data included in the disclosure (e.g., carbon pricing, offset costs).. Valid values are `^[A-Z]{3}$`',
    `disclosure_document_url` STRING COMMENT 'URL or file path to the suppliers full emissions disclosure document or report.',
    `disclosure_methodology` STRING COMMENT 'Methodology or framework used by the supplier to calculate and report greenhouse gas emissions.. Valid values are `ghg_protocol|glec_framework|iso_14064|cdp_questionnaire|sbti_methodology|custom`',
    `disclosure_reference_number` STRING COMMENT 'External reference number or identifier assigned by the supplier to this emissions disclosure submission.',
    `disclosure_status` STRING COMMENT 'Current status of the emissions disclosure in Transport Shippings review and acceptance workflow.. Valid values are `submitted|under_review|accepted|rejected|revision_requested`',
    `disclosure_submission_date` DATE COMMENT 'Date when the supplier submitted the emissions disclosure to Transport Shipping.',
    `emissions_intensity_gco2e_per_shipment` DECIMAL(18,2) COMMENT 'Emissions intensity metric expressed as grams of carbon dioxide equivalent per shipment, representing the average carbon footprint per shipment handled by the supplier.',
    `emissions_intensity_gco2e_per_tonne_km` DECIMAL(18,2) COMMENT 'Emissions intensity metric expressed as grams of carbon dioxide equivalent per tonne-kilometer, representing the efficiency of freight transportation services provided by the supplier.',
    `eu_ets_participant_flag` BOOLEAN COMMENT 'Flag indicating whether the supplier participates in the European Union Emissions Trading System (EU ETS).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier emissions disclosure record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the supplier emissions disclosure.',
    `rejection_reason` STRING COMMENT 'Reason provided if the emissions disclosure was rejected or revision was requested.',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Percentage of the suppliers energy consumption sourced from renewable energy during the reporting period.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period covered by this emissions disclosure.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period covered by this emissions disclosure.',
    `review_date` DATE COMMENT 'Date when the emissions disclosure was reviewed by Transport Shipping.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the Transport Shipping sustainability team member who reviewed the disclosure.',
    `sbti_commitment_status` STRING COMMENT 'Status of the suppliers commitment to the Science Based Targets initiative (SBTi), indicating whether they have committed to, set, or had science-based emissions reduction targets approved.. Valid values are `committed|targets_set|targets_approved|no_commitment`',
    `sbti_target_year` STRING COMMENT 'Target year by which the supplier has committed to achieve their science-based emissions reduction targets.',
    `scope_1_emissions_tco2e` DECIMAL(18,2) COMMENT 'Total Scope 1 direct greenhouse gas emissions disclosed by the supplier in tonnes of carbon dioxide equivalent (tCO2e) for the reporting period.',
    `scope_2_emissions_tco2e` DECIMAL(18,2) COMMENT 'Total Scope 2 indirect greenhouse gas emissions from purchased energy disclosed by the supplier in tonnes of carbon dioxide equivalent (tCO2e) for the reporting period.',
    `scope_3_category_4_applicable_flag` BOOLEAN COMMENT 'Flag indicating whether this disclosure is applicable to Scope 3 Category 4 (upstream transportation and distribution) emissions accounting for Transport Shipping.',
    `scope_3_category_9_applicable_flag` BOOLEAN COMMENT 'Flag indicating whether this disclosure is applicable to Scope 3 Category 9 (downstream transportation and distribution) emissions accounting for Transport Shipping.',
    `scope_3_emissions_tco2e` DECIMAL(18,2) COMMENT 'Total Scope 3 other indirect greenhouse gas emissions disclosed by the supplier in tonnes of carbon dioxide equivalent (tCO2e) for the reporting period.',
    `supplier_sustainability_rating` STRING COMMENT 'Internal sustainability rating assigned to the supplier based on their emissions disclosure and overall environmental performance.. Valid values are `A|B|C|D|F|not_rated`',
    `total_freight_volume_tonne_km` DECIMAL(18,2) COMMENT 'Total freight volume transported by the supplier during the reporting period, measured in tonne-kilometers.',
    `total_shipment_count` BIGINT COMMENT 'Total number of shipments handled by the supplier during the reporting period.',
    `verification_body` STRING COMMENT 'Name of the independent third-party organization that verified or assured the suppliers emissions disclosure.',
    `verification_date` DATE COMMENT 'Date when the emissions disclosure was verified or assured by the third-party verification body.',
    `verification_status` STRING COMMENT 'Status indicating whether the disclosed emissions data has been independently verified or assured by a third party.. Valid values are `verified|limited_assurance|reasonable_assurance|self_reported|not_verified`',
    CONSTRAINT pk_supplier_emissions_disclosure PRIMARY KEY(`supplier_emissions_disclosure_id`)
) COMMENT 'Transactional record capturing GHG emissions disclosures received from carriers, 3PL partners, and suppliers as part of Scope 3 Category 4 (upstream transportation) and Category 9 (downstream transportation) data collection. Stores supplier/carrier ID, reporting period, disclosed Scope 1 emissions (tCO2e), emissions intensity (gCO2e per tonne-km), disclosure methodology, data quality tier, CDP score, SBTi commitment status, and verification status. Supports Scope 3 supply chain emissions accounting and supplier sustainability scorecarding.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` (
    `packaging_sustainability_id` BIGINT COMMENT 'Primary key for packaging_sustainability',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer who received the shipment with this sustainable packaging.',
    `emissions_factor_id` BIGINT COMMENT 'Reference to the emissions factor used to calculate the CO2e impact of the packaging material.',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse or fulfillment center where packaging was applied.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the e-commerce order associated with this packaging record.',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Packaging sustainability records have co2e_impact_kg which contributes to the companys GHG inventory (Scope 3 category 1 - purchased goods). Consistent with waste_record, energy_consumption_record, a',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier entity providing the packaging material.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_permit. Business justification: Reusable packaging cleaning operations (chemical wash, high-pressure steam, confined space entry) require hot work permits and confined space permits. Operational safety compliance and OSHA recordkeep',
    `shipment_leg_id` BIGINT COMMENT 'Reference to the shipment or order batch associated with this packaging record.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to warehouse.sku. Business justification: Enables SKU-level carbon footprint reporting and packaging material compliance tracking. Customers request product-specific emissions data; packaging optimization initiatives target high-volume SKUs. ',
    `biodegradable_flag` BOOLEAN COMMENT 'Indicates whether the packaging material is biodegradable (True) or not (False).',
    `co2e_impact_kg` DECIMAL(18,2) COMMENT 'Carbon footprint of the packaging material expressed in kilograms of CO2 equivalent, calculated from production through disposal.',
    `compostable_flag` BOOLEAN COMMENT 'Indicates whether the packaging material is certified compostable (True) or not (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging sustainability record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the packaging cost.. Valid values are `^[A-Z]{3}$`',
    `customer_green_commitment_flag` BOOLEAN COMMENT 'Indicates whether this packaging was used to fulfill a customer-specific green packaging commitment or sustainability requirement (True) or standard packaging (False).',
    `data_quality_rating` STRING COMMENT 'Quality rating of the packaging sustainability data (high, medium, low, estimated, verified), indicating confidence level in the measurements and calculations.. Valid values are `high|medium|low|estimated|verified`',
    `end_of_life_treatment` STRING COMMENT 'Expected or actual end-of-life treatment method for the packaging material (recycled, composted, landfill, incinerated, reused, returned).. Valid values are `recycled|composted|landfill|incinerated|reused|returned`',
    `esg_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this packaging record is included in external ESG disclosure reporting (True) or internal tracking only (False).',
    `fsc_certification_code` STRING COMMENT 'FSC certification code for forest-based packaging materials, ensuring responsible forest management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging sustainability record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the packaging sustainability record, including special handling, exceptions, or observations.',
    `packaging_cost` DECIMAL(18,2) COMMENT 'Total cost of the sustainable packaging material for this shipment or order batch.',
    `packaging_date` DATE COMMENT 'Date when the packaging was applied to the shipment or order batch.',
    `packaging_lifecycle_stage` STRING COMMENT 'Current lifecycle stage of the packaging material being tracked (production, distribution, use, end-of-life, recycling, disposal).. Valid values are `production|distribution|use|end_of_life|recycling|disposal`',
    `packaging_material_type` STRING COMMENT 'Type of sustainable packaging material used (e.g., recycled cardboard, biodegradable filler, reusable container, plastic-free). [ENUM-REF-CANDIDATE: recycled_cardboard|biodegradable_filler|reusable_container|plastic_free|compostable|paper_based|plant_based|recycled_plastic|ocean_bound_plastic|mushroom_packaging|seaweed_packaging — promote to reference product]',
    `packaging_optimization_score` DECIMAL(18,2) COMMENT 'Score representing how efficiently the packaging was optimized for the shipment (0-100), considering material usage, volume efficiency, and sustainability.',
    `packaging_standard_compliance` STRING COMMENT 'Certification or standard compliance for the packaging material (e.g., FSC, PEFC, EU Packaging Directive, Cradle to Cradle, BPI Compostable).. Valid values are `FSC|PEFC|EU_Packaging_Directive|Cradle_to_Cradle|BPI_Compostable|OK_Compost`',
    `packaging_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the packaging was applied to the shipment or order batch.',
    `packaging_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of packaging material used, measured in cubic meters (CBM).',
    `packaging_waste_generated_kg` DECIMAL(18,2) COMMENT 'Estimated weight of packaging waste generated after product delivery, measured in kilograms.',
    `packaging_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of packaging material used for this shipment or order batch, measured in kilograms.',
    `plastic_free_flag` BOOLEAN COMMENT 'Indicates whether the packaging is completely free of plastic materials (True) or contains plastic (False).',
    `recycled_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of recycled material content in the packaging (0-100%).',
    `regulatory_compliance_status` STRING COMMENT 'Status of regulatory compliance for this packaging record against applicable environmental regulations (compliant, non-compliant, pending review, exempt, not applicable).. Valid values are `compliant|non_compliant|pending_review|exempt|not_applicable`',
    `reporting_period` STRING COMMENT 'Reporting period for sustainability metrics (format: YYYY-QN for quarterly, YYYY-MM for monthly, YYYY for annual).. Valid values are `^d{4}-Q[1-4]$|^d{4}-d{2}$|^d{4}$`',
    `return_reuse_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of reusable packaging that is successfully returned and reused (0-100%). Applicable only when reusable_packaging_flag is True.',
    `reusable_packaging_flag` BOOLEAN COMMENT 'Indicates whether the packaging is designed for reuse (True) or single-use (False).',
    `sdg_alignment` STRING COMMENT 'United Nations Sustainable Development Goals that this packaging initiative supports (e.g., SDG 12: Responsible Consumption and Production, SDG 13: Climate Action).',
    CONSTRAINT pk_packaging_sustainability PRIMARY KEY(`packaging_sustainability_id`)
) COMMENT 'Operational record tracking sustainable packaging usage and performance at the shipment or order batch level. Captures packaging material type (recycled cardboard, biodegradable filler, reusable container, plastic-free), recycled content %, weight (kg), packaging supplier, packaging standard compliance (FSC, PEFC, EU Packaging Directive), CO2e impact of packaging material, packaging waste generated, and return/reuse rate for reusable packaging. Supports e-commerce fulfillment sustainability reporting and customer green packaging commitments.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` (
    `customer_carbon_report_id` BIGINT COMMENT 'Unique identifier for the customer carbon report record.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for which this carbon report was generated.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Customer carbon reports are generated for fiscal periods to align with customer billing cycles and financial reporting. Required for revenue recognition period matching and customer sustainability rep',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.order. Business justification: Customer carbon reports aggregate emissions across orders for a customer account. Direct link needed to trace report data back to source orders for audit, dispute resolution, and detailed customer inq',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Customer carbon reports are derived from the companys GHG inventory data for the reporting period. Linking to ghg_inventory provides traceability to the verified corporate emissions data that underpi',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Customer carbon reports reference the underlying document packages containing shipment data used in emissions calculations. Real business process: customer ESG reporting verification requires audit tr',
    `air_freight_co2e_kg` DECIMAL(18,2) COMMENT 'Total CO2 equivalent emissions in kilograms attributable to air freight transport mode for this reporting period.',
    `calculation_methodology` STRING COMMENT 'The carbon accounting methodology and standard used to calculate emissions for this report.. Valid values are `ISO 14083|GLEC Framework|GHG Protocol|IATA Recommended Practice|IMO Guidelines|Custom`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this customer carbon report record was first created in the system.',
    `customer_acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the customer formally accepted or acknowledged receipt of this carbon report.',
    `customer_esg_framework` STRING COMMENT 'The ESG reporting framework or standard that the customer uses, to which this carbon report is aligned (e.g., GRI, CDP, TCFD, SASB).',
    `customer_notes` STRING COMMENT 'Free-text notes or comments provided by the customer regarding this carbon report, including feedback, questions, or acceptance remarks.',
    `data_quality_rating` STRING COMMENT 'Assessment of the quality and accuracy of the underlying emissions data used in this report, based on data completeness, source reliability, and calculation precision.. Valid values are `high|medium|low`',
    `emissions_intensity_gco2e_per_kg` DECIMAL(18,2) COMMENT 'Carbon emissions intensity expressed as grams of CO2 equivalent per kilogram of freight shipped, a key performance indicator for green logistics.',
    `emissions_intensity_gco2e_per_tonne_km` DECIMAL(18,2) COMMENT 'Carbon emissions intensity expressed as grams of CO2 equivalent per tonne-kilometer, the standard metric for freight transport carbon efficiency.',
    `gross_co2e_kg` DECIMAL(18,2) COMMENT 'Total gross greenhouse gas emissions in kilograms of CO2 equivalent before any carbon offsets are applied.',
    `internal_notes` STRING COMMENT 'Internal operational notes or comments regarding the generation, delivery, or special circumstances of this carbon report.',
    `last_mile_co2e_kg` DECIMAL(18,2) COMMENT 'Total CO2 equivalent emissions in kilograms attributable to last-mile delivery operations for this reporting period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this customer carbon report record was last updated or modified.',
    `methodology_version` STRING COMMENT 'Version number or identifier of the calculation methodology used, ensuring traceability and consistency over time.',
    `net_co2e_kg` DECIMAL(18,2) COMMENT 'Net greenhouse gas emissions in kilograms of CO2 equivalent after carbon offsets have been applied (gross minus offset).',
    `ocean_freight_co2e_kg` DECIMAL(18,2) COMMENT 'Total CO2 equivalent emissions in kilograms attributable to ocean freight transport mode for this reporting period.',
    `offset_certificates_applied` STRING COMMENT 'Number of carbon offset certificates or credits applied to this customer report to achieve net emissions reduction.',
    `offset_co2e_kg` DECIMAL(18,2) COMMENT 'Total carbon offsets applied in kilograms of CO2 equivalent through carbon offset programs.',
    `offset_program_names` STRING COMMENT 'Comma-separated list of carbon offset program names from which credits were applied to this report.',
    `rail_freight_co2e_kg` DECIMAL(18,2) COMMENT 'Total CO2 equivalent emissions in kilograms attributable to rail freight transport mode for this reporting period.',
    `regulatory_compliance_flags` STRING COMMENT 'Comma-separated list of regulatory frameworks or compliance schemes this report satisfies (e.g., EU ETS, CORSIA, CDP disclosure).',
    `report_delivery_timestamp` TIMESTAMP COMMENT 'Date and time when this carbon report was delivered to the customer.',
    `report_format` STRING COMMENT 'Format in which the carbon report was delivered to the customer (PDF document, Excel spreadsheet, API payload, EDI message, etc.).. Valid values are `PDF|Excel|JSON|XML|API|EDI`',
    `report_generation_timestamp` TIMESTAMP COMMENT 'Date and time when this carbon report was generated by the system.',
    `report_language` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which the report was generated for the customer.',
    `report_number` STRING COMMENT 'Externally-known unique business identifier for this carbon report, used for customer reference and tracking.',
    `report_status` STRING COMMENT 'Current lifecycle status of the carbon report in the delivery and acceptance workflow.. Valid values are `draft|generated|delivered|accepted|rejected|revised`',
    `reporting_period_end_date` DATE COMMENT 'End date of the period covered by this carbon footprint report.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the period covered by this carbon footprint report.',
    `road_freight_co2e_kg` DECIMAL(18,2) COMMENT 'Total CO2 equivalent emissions in kilograms attributable to road freight transport mode for this reporting period.',
    `scope_1_co2e_kg` DECIMAL(18,2) COMMENT 'Direct greenhouse gas emissions from owned or controlled sources (e.g., company-owned fleet fuel combustion) in kilograms of CO2 equivalent.',
    `scope_2_co2e_kg` DECIMAL(18,2) COMMENT 'Indirect greenhouse gas emissions from purchased electricity, heat, or steam consumed in operations (e.g., warehouse energy) in kilograms of CO2 equivalent.',
    `scope_3_co2e_kg` DECIMAL(18,2) COMMENT 'Indirect greenhouse gas emissions from value chain activities including contracted carriers, third-party logistics providers, and upstream/downstream transport in kilograms of CO2 equivalent.',
    `total_distance_km` DECIMAL(18,2) COMMENT 'Total distance in kilometers traveled by all shipments included in this carbon report.',
    `total_shipments` STRING COMMENT 'Total number of shipments included in this carbon report for the reporting period.',
    `total_tonne_km` DECIMAL(18,2) COMMENT 'Total tonne-kilometers (weight multiplied by distance) for all shipments, a key metric for freight carbon intensity.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms of all shipments included in this carbon report.',
    `uncertainty_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage uncertainty or margin of error in the reported carbon emissions calculations, reflecting data quality and methodology limitations.',
    `verification_date` DATE COMMENT 'Date on which the carbon emissions data was verified or audited.',
    `verification_status` STRING COMMENT 'Indicates whether the carbon data in this report has been verified or audited by internal or external parties.. Valid values are `not_verified|internally_verified|third_party_verified|certified`',
    `verifier_name` STRING COMMENT 'Name of the third-party organization or internal team that verified the carbon emissions data in this report.',
    `warehouse_co2e_kg` DECIMAL(18,2) COMMENT 'Total CO2 equivalent emissions in kilograms attributable to warehouse and distribution center operations for this reporting period.',
    CONSTRAINT pk_customer_carbon_report PRIMARY KEY(`customer_carbon_report_id`)
) COMMENT 'Business-facing record of a periodic carbon footprint report delivered to a customer account summarising the CO2e emissions associated with their shipments over a defined period. Captures customer account ID, reporting period, total shipments, total tonne-km, gross CO2e (kg), net CO2e after offsets, emissions by transport mode, emissions intensity (gCO2e per kg shipped), offset certificates applied, methodology used (ISO 14083, GLEC), report format (PDF, API, EDI), delivery date, and customer acceptance status. Supports customer ESG reporting obligations and green logistics commercial differentiation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` (
    `esg_rating_record_id` BIGINT COMMENT 'Unique identifier for the ESG rating record. Primary key for this entity.',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: ESG ratings are assigned by external agencies based on ESG disclosures submitted by the company. The rating references the specific disclosure that was assessed. This provides traceability from the ra',
    `approval_date` DATE COMMENT 'Date when internal approval was granted for using this ESG rating in external communications and business activities.',
    `approved_by` STRING COMMENT 'Name or identifier of the internal stakeholder (e.g., Chief Sustainability Officer, VP Investor Relations) who approved this rating for external use.',
    `assessment_date` DATE COMMENT 'Date when the ESG rating assessment was conducted or published by the rating agency.',
    `assessment_scope` STRING COMMENT 'Description of the organizational scope covered by the assessment (e.g., global operations, specific regions, business units). Defines boundaries of the rating.',
    `certification_status` STRING COMMENT 'Status of any formal ESG certification or recognition associated with this rating (e.g., certified for DJSI membership, provisional approval, under review).. Valid values are `certified|provisional|under_review|expired|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ESG rating record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_reporting_use_flag` BOOLEAN COMMENT 'Indicates whether this rating is approved for sharing with customers as part of customer-facing carbon reporting and sustainability communications.',
    `data_quality_rating` STRING COMMENT 'Assessment of the quality and completeness of data provided by Transport Shipping for the rating evaluation. Higher quality data typically results in more accurate ratings.. Valid values are `high|medium|low|not_rated`',
    `disclosure_url` STRING COMMENT 'URL link to the public disclosure document or rating report published by the agency or Transport Shipping. Null if not publicly disclosed.',
    `environmental_score` DECIMAL(18,2) COMMENT 'Score for the Environmental pillar covering GHG emissions, energy efficiency, waste management, water usage, biodiversity impact, and environmental compliance.',
    `governance_score` DECIMAL(18,2) COMMENT 'Score for the Governance pillar covering board composition, executive compensation, shareholder rights, business ethics, anti-corruption policies, and regulatory compliance.',
    `improvement_recommendations` STRING COMMENT 'Specific recommendations provided by the rating agency for improving ESG performance and achieving higher ratings in future assessments.',
    `industry_percentile` DECIMAL(18,2) COMMENT 'Percentile ranking within the logistics industry peer group (0-100). Higher percentiles indicate better relative performance.',
    `industry_rank` STRING COMMENT 'Numerical rank of Transport Shipping within the logistics industry peer group as determined by the rating agency. Lower numbers indicate better performance.',
    `internal_approval_status` STRING COMMENT 'Internal approval status for using this rating in external communications and business development activities. Ensures governance over ESG credential usage.. Valid values are `approved|pending_review|rejected|draft`',
    `investor_relations_use_flag` BOOLEAN COMMENT 'Indicates whether this rating is approved for use in investor relations communications, annual reports, and shareholder presentations.',
    `key_strengths` STRING COMMENT 'Summary of key strengths and positive performance areas highlighted by the rating agency in their assessment. Used for internal improvement tracking and external communications.',
    `key_weaknesses` STRING COMMENT 'Summary of key weaknesses, gaps, and areas for improvement identified by the rating agency. Used for action planning and continuous improvement initiatives.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ESG rating record was last updated or modified. Used for audit trail and change tracking.',
    `methodology_version` STRING COMMENT 'Version identifier of the rating methodology used by the agency for this assessment. Critical for ensuring comparability across assessment periods.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next ESG rating assessment by this agency. Used for planning data collection and submission activities.',
    `notes` STRING COMMENT 'Additional notes, context, or commentary regarding this ESG rating record. May include internal observations, action items, or special circumstances.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite ESG score assigned by the rating agency representing overall environmental, social, and governance performance. Scale and range vary by rating agency.',
    `overall_score_scale` STRING COMMENT 'Description of the scoring scale used by the rating agency (e.g., 0-100, AAA-CCC, Advanced-Beginner). Provides context for interpreting the overall score.',
    `peer_group_size` STRING COMMENT 'Total number of companies in the logistics industry peer group used for benchmarking and ranking by the rating agency.',
    `prior_period_overall_score` DECIMAL(18,2) COMMENT 'Overall ESG score from the previous assessment period, enabling year-over-year performance comparison and trend analysis.',
    `prior_period_rating_tier` STRING COMMENT 'Rating tier or grade from the previous assessment period for trend analysis and performance tracking.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this ESG rating has been publicly disclosed by Transport Shipping or the rating agency. True if publicly available; False if confidential.',
    `rating_agency` STRING COMMENT 'Name of the third-party ESG rating agency or framework that issued the rating. Includes MSCI, Sustainalytics, EcoVadis, CDP (Carbon Disclosure Project), DJSI (Dow Jones Sustainability Index), and ISS (Institutional Shareholder Services).. Valid values are `MSCI|Sustainalytics|EcoVadis|CDP|DJSI|ISS`',
    `rating_agency_code` STRING COMMENT 'Standardized code or abbreviation for the rating agency used for system integration and reporting.',
    `rating_tier` STRING COMMENT 'Categorical rating tier or grade assigned by the agency (e.g., AAA, AA, A, BBB for MSCI; Leader, Advanced, Intermediate for EcoVadis). Provides qualitative assessment of ESG performance.',
    `rating_validity_end_date` DATE COMMENT 'Date when this ESG rating expires or is no longer considered current by the rating agency. Ratings typically have annual or biennial validity periods.',
    `report_reference_number` STRING COMMENT 'Unique reference number or identifier assigned by the rating agency to the assessment report for tracking and retrieval purposes.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period covered by this ESG rating assessment.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period covered by this ESG rating assessment.',
    `score_change` DECIMAL(18,2) COMMENT 'Numerical change in overall ESG score compared to the prior period. Positive values indicate improvement; negative values indicate decline.',
    `social_score` DECIMAL(18,2) COMMENT 'Score for the Social pillar covering labor practices, health and safety, diversity and inclusion, human rights, community engagement, and supply chain labor standards.',
    `tender_qualification_use_flag` BOOLEAN COMMENT 'Indicates whether this rating is approved for inclusion in tender submissions and customer procurement qualification responses requiring ESG credentials.',
    `verification_body` STRING COMMENT 'Name of the independent third-party organization that verified or audited the ESG rating data and assessment process.',
    `verification_date` DATE COMMENT 'Date when the independent verification or audit of the ESG rating was completed.',
    `verification_status` STRING COMMENT 'Indicates whether the rating has been independently verified or audited by a third party. Verified ratings carry higher credibility for stakeholder communications.. Valid values are `verified|unverified|partially_verified|pending`',
    CONSTRAINT pk_esg_rating_record PRIMARY KEY(`esg_rating_record_id`)
) COMMENT 'Record capturing external ESG ratings, scores, and rankings assigned to Transport Shipping by third-party agencies and voluntary frameworks. Stores rating agency (MSCI, Sustainalytics, EcoVadis, CDP, DJSI, ISS), assessment date, overall score, E/S/G pillar scores, rating tier, industry rank, prior period comparison, methodology version, and public disclosure reference. Used for investor relations reporting, customer procurement qualification responses, tender submissions requiring ESG credentials, and competitive benchmarking against logistics industry peers.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` (
    `water_consumption_record_id` BIGINT COMMENT 'Unique identifier for the water consumption record.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where water consumption is measured. Links to warehouse, distribution center, terminal, or office location.',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Water consumption records are part of the environmental data reported in GHG inventories and ESG disclosures. For consistency with other operational environmental records (waste_record, energy_consump',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Water consumption at facilities operated by network partners (3PL warehouses, correspondent offices, hub operators) must be tracked for Scope 3 Category 8 (upstream leased assets) ESG disclosure and G',
    `compliance_status` STRING COMMENT 'Status of compliance with local water use regulations, discharge permits, and environmental standards during the reporting period.. Valid values are `compliant|non_compliant|under_review|exempted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the water consumption record was first created in the system.',
    `data_quality_rating` STRING COMMENT 'Assessment of the reliability and accuracy of the water consumption data based on measurement method and source documentation.. Valid values are `high|medium|low`',
    `discharge_destination_type` STRING COMMENT 'Type of destination where treated or untreated wastewater is discharged.. Valid values are `surface_water|groundwater|seawater|municipal_sewer|third_party|land_application`',
    `discharge_water_quality_standard` STRING COMMENT 'Water quality standard or regulatory threshold applied to discharged water (e.g., EPA effluent guidelines, local environmental authority standards).',
    `esg_reporting_flag` BOOLEAN COMMENT 'Indicates whether this water consumption record is included in external ESG or sustainability reporting disclosures.',
    `facility_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the facility location.. Valid values are `^[A-Z]{3}$`',
    `facility_region` STRING COMMENT 'Geographic region or state/province where the facility is located.',
    `facility_type` STRING COMMENT 'Type of logistics facility where water consumption is recorded.. Valid values are `warehouse|distribution_center|office|terminal|sorting_facility|maintenance_depot`',
    `gri_303_disclosure_category` STRING COMMENT 'GRI 303 disclosure category that this water consumption record supports (303-1 Interactions with water, 303-2 Management approach, 303-3 Withdrawal, 303-4 Discharge, 303-5 Consumption).. Valid values are `303_1|303_2|303_3|303_4|303_5`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the water consumption record was last updated or modified.',
    `measurement_method` STRING COMMENT 'Method used to measure or estimate water consumption (direct metering, engineering calculation, utility invoice, or estimation).. Valid values are `metered|estimated|calculated|supplier_invoice`',
    `non_compliance_incident_count` STRING COMMENT 'Number of regulatory non-compliance incidents related to water use or discharge during the reporting period.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the water consumption record, including explanations for anomalies or data quality issues.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the water use or discharge permit.',
    `regulatory_permit_reference` STRING COMMENT 'Reference number or identifier of the environmental permit or license authorizing water withdrawal and discharge at this facility.',
    `reporting_period_end_date` DATE COMMENT 'End date of the water consumption reporting period.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the water consumption reporting period.',
    `supplier_name` STRING COMMENT 'Name of the water utility or supplier providing water to the facility.',
    `total_water_withdrawn_m3` DECIMAL(18,2) COMMENT 'Total volume of water withdrawn from all sources during the reporting period, measured in cubic meters.',
    `verification_body` STRING COMMENT 'Name of the third-party organization that verified the water consumption data.',
    `verification_date` DATE COMMENT 'Date when the water consumption data was verified by a third-party auditor.',
    `verification_status` STRING COMMENT 'Status of third-party verification or audit of the water consumption data.. Valid values are `verified|unverified|pending_verification|not_required`',
    `wastewater_treatment_method` STRING COMMENT 'Method used to treat wastewater before discharge. Indicates whether treatment is performed on-site, by municipal systems, or by third-party providers.. Valid values are `on_site_treatment|municipal_treatment|third_party_treatment|no_treatment|septic_system|direct_discharge`',
    `water_consumed_m3` DECIMAL(18,2) COMMENT 'Net water consumption calculated as total withdrawn minus discharged and recycled, measured in cubic meters. Represents water that is evaporated, incorporated into products, or otherwise not returned to the source.',
    `water_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of water consumed during the reporting period, including supply charges, wastewater treatment fees, and discharge fees.',
    `water_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for water cost amount.. Valid values are `^[A-Z]{3}$`',
    `water_discharged_m3` DECIMAL(18,2) COMMENT 'Total volume of water discharged from the facility during the reporting period, measured in cubic meters.',
    `water_intensity_per_employee` DECIMAL(18,2) COMMENT 'Water consumption intensity normalized by number of employees, measured in cubic meters per Full-Time Equivalent (FTE). Supports operational efficiency analysis.',
    `water_intensity_per_sqm` DECIMAL(18,2) COMMENT 'Water consumption intensity normalized by facility floor area, measured in cubic meters per square meter. Supports benchmarking and efficiency tracking.',
    `water_recycled_m3` DECIMAL(18,2) COMMENT 'Volume of water recycled or reused within the facility during the reporting period, measured in cubic meters.',
    `water_source_type` STRING COMMENT 'Type of water source from which water is withdrawn. Categories align with GRI 303 disclosure requirements.. Valid values are `municipal|groundwater|rainwater_harvesting|surface_water|seawater|third_party`',
    `water_stewardship_program_flag` BOOLEAN COMMENT 'Indicates whether the facility participates in a formal water stewardship or conservation program (e.g., Alliance for Water Stewardship certification).',
    `water_stress_area_flag` BOOLEAN COMMENT 'Indicates whether the facility is located in a water-stressed area based on World Resources Institute (WRI) Aqueduct tool classification.',
    `water_stress_level` STRING COMMENT 'Classification of water stress level at the facility location based on WRI Aqueduct baseline water stress indicator.. Valid values are `low|low_to_medium|medium_to_high|high|extremely_high`',
    CONSTRAINT pk_water_consumption_record PRIMARY KEY(`water_consumption_record_id`)
) COMMENT 'Operational record capturing water consumption and discharge data at facility level for a defined reporting period. Stores facility ID, reporting period, water source (municipal, groundwater, rainwater harvesting), total water withdrawn (m3), water recycled/reused (m3), water discharged (m3), water stress area flag (based on WRI Aqueduct), wastewater treatment method, regulatory permit reference, and associated GRI 303 disclosure category. Supports ESG social and environmental reporting, ISO 14001 compliance, and water stewardship commitments.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`sustainability`.`compliance_period` (
    `compliance_period_id` BIGINT COMMENT 'Primary key for compliance_period',
    `prior_compliance_period_id` BIGINT COMMENT 'Self-referencing FK on compliance_period (prior_compliance_period_id)',
    `applicable_transport_mode` STRING COMMENT 'The transport mode(s) to which this compliance period applies, relevant for mode-specific schemes such as CORSIA (aviation), EU ETS maritime extension, or IMO DCS (shipping).',
    `baseline_emissions_tonnes_co2e` DECIMAL(18,2) COMMENT 'The reference baseline emissions level against which reductions or growth are measured for this compliance period, expressed in metric tonnes of CO2 equivalent.',
    `compliance_period_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the compliance period within the regulatory scheme (e.g., EU-ETS-2024-P1, CORSIA-2024).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance period record was first created in the sustainability data platform.',
    `compliance_period_description` STRING COMMENT 'Detailed textual description of the compliance period including its scope, applicability, and key obligations for the organization.',
    `effective_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance period record became effective in the system, supporting temporal queries and slowly changing dimension management.',
    `emissions_cap_tonnes_co2e` DECIMAL(18,2) COMMENT 'The total emissions cap or allowance allocation ceiling for the organization under this compliance period, expressed in metric tonnes of CO2 equivalent.',
    `end_date` DATE COMMENT 'The calendar date on which the compliance period ends and emissions accumulation ceases for this periods obligations.',
    `free_allocation_tonnes_co2e` DECIMAL(18,2) COMMENT 'The quantity of emission allowances allocated free of charge to the organization for this compliance period, expressed in metric tonnes of CO2 equivalent.',
    `ghg_scope_coverage` STRING COMMENT 'Indicates which GHG Protocol emission scopes are covered by this compliance periods obligations (Scope 1 direct, Scope 2 indirect energy, Scope 3 value chain).',
    `growth_factor_percent` DECIMAL(18,2) COMMENT 'The sectoral growth factor applied to baseline emissions to determine the compliance threshold, accounting for industry growth (used in CORSIAs sectoral approach).',
    `is_voluntary` BOOLEAN COMMENT 'Indicates whether participation in this compliance period is voluntary (true) or mandatory (false) for the organization based on regulatory thresholds.',
    `jurisdiction_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary jurisdiction or administering authority for this compliance period. For supranational schemes (e.g., EU ETS), represents the administering member state.',
    `max_offset_percentage` DECIMAL(18,2) COMMENT 'The maximum percentage of total compliance obligations that may be met through carbon offset credits rather than direct emission reductions or allowance purchases.',
    `monitoring_methodology` STRING COMMENT 'The prescribed or adopted methodology for monitoring and calculating emissions during this compliance period (e.g., Tier 1/2/3 calculation, continuous emissions monitoring, fuel-based method).',
    `compliance_period_name` STRING COMMENT 'Human-readable name or title of the compliance period (e.g., EU ETS Phase 4 - Year 2024, CORSIA Pilot Phase 2021-2023).',
    `notes` STRING COMMENT 'Free-text notes or annotations providing additional context about the compliance period, such as regulatory amendments, transitional provisions, or organizational decisions.',
    `offset_eligibility_flag` BOOLEAN COMMENT 'Indicates whether carbon offset credits (e.g., CERs, ERUs, eligible units) may be used to meet compliance obligations during this period.',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the non-compliance penalty rate applicable to this compliance period.',
    `penalty_rate_per_tonne` DECIMAL(18,2) COMMENT 'The monetary penalty rate per tonne of CO2e for non-compliance (failure to surrender sufficient allowances) during this compliance period, in the schemes base currency.',
    `period_type` STRING COMMENT 'Classification of the compliance period by its temporal structure — annual reporting cycle, multi-year commitment period, regulatory phase, pilot period, or baseline reference period.',
    `phase_number` STRING COMMENT 'The sequential phase number within the broader regulatory scheme (e.g., Phase 4 of EU ETS, Pilot Phase of CORSIA) to which this compliance period belongs.',
    `reduction_target_percent` DECIMAL(18,2) COMMENT 'The mandated or committed percentage reduction in greenhouse gas emissions relative to the baseline that must be achieved during this compliance period.',
    `regulatory_authority_name` STRING COMMENT 'Name of the competent regulatory authority or administering body responsible for overseeing compliance during this period (e.g., European Commission, ICAO, national environment agency).',
    `regulatory_scheme` STRING COMMENT 'The emissions trading or carbon compliance regulatory scheme under which this period is defined (e.g., EU ETS, CORSIA, IMO Data Collection System, UK ETS, California Cap-and-Trade).',
    `reporting_deadline_date` DATE COMMENT 'The regulatory deadline by which emissions reports and monitoring data must be submitted to the competent authority for this compliance period.',
    `reporting_frequency` STRING COMMENT 'The required frequency at which emissions data must be reported to the regulatory authority during this compliance period.',
    `start_date` DATE COMMENT 'The calendar date on which the compliance period becomes effective and emissions begin to be counted toward obligations under the regulatory scheme.',
    `compliance_period_status` STRING COMMENT 'Current lifecycle status of the compliance period indicating whether it is upcoming, currently active for emissions accumulation, in the reporting/verification window, closed, or archived.',
    `surrender_deadline_date` DATE COMMENT 'The regulatory deadline by which emission allowances or offset credits must be surrendered to cover verified emissions for this compliance period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance period record was last modified or updated.',
    `verification_deadline_date` DATE COMMENT 'The regulatory deadline by which third-party verification of emissions reports must be completed and submitted for this compliance period.',
    CONSTRAINT pk_compliance_period PRIMARY KEY(`compliance_period_id`)
) COMMENT 'Master reference table for compliance_period. Referenced by compliance_period_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ADD CONSTRAINT `fk_sustainability_emissions_factor_superseded_by_factor_emissions_factor_id` FOREIGN KEY (`superseded_by_factor_emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_customer_carbon_report_id` FOREIGN KEY (`customer_carbon_report_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`customer_carbon_report`(`customer_carbon_report_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ADD CONSTRAINT `fk_sustainability_shipment_carbon_footprint_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ADD CONSTRAINT `fk_sustainability_carbon_offset_transaction_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ADD CONSTRAINT `fk_sustainability_carbon_offset_transaction_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ADD CONSTRAINT `fk_sustainability_carbon_offset_transaction_green_shipment_certificate_id` FOREIGN KEY (`green_shipment_certificate_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate`(`green_shipment_certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ADD CONSTRAINT `fk_sustainability_fuel_consumption_record_saf_procurement_id` FOREIGN KEY (`saf_procurement_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`saf_procurement`(`saf_procurement_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ADD CONSTRAINT `fk_sustainability_eu_ets_allowance_compliance_period_id` FOREIGN KEY (`compliance_period_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`compliance_period`(`compliance_period_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ADD CONSTRAINT `fk_sustainability_eu_ets_allowance_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ADD CONSTRAINT `fk_sustainability_corsia_compliance_record_compliance_period_id` FOREIGN KEY (`compliance_period_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`compliance_period`(`compliance_period_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ADD CONSTRAINT `fk_sustainability_corsia_compliance_record_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ADD CONSTRAINT `fk_sustainability_green_shipment_certificate_carbon_offset_program_id` FOREIGN KEY (`carbon_offset_program_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`carbon_offset_program`(`carbon_offset_program_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ADD CONSTRAINT `fk_sustainability_green_shipment_certificate_saf_procurement_id` FOREIGN KEY (`saf_procurement_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`saf_procurement`(`saf_procurement_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ADD CONSTRAINT `fk_sustainability_green_shipment_certificate_shipment_carbon_footprint_id` FOREIGN KEY (`shipment_carbon_footprint_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`(`shipment_carbon_footprint_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ADD CONSTRAINT `fk_sustainability_saf_procurement_compliance_period_id` FOREIGN KEY (`compliance_period_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`compliance_period`(`compliance_period_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ADD CONSTRAINT `fk_sustainability_renewable_energy_certificate_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ADD CONSTRAINT `fk_sustainability_waste_record_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ADD CONSTRAINT `fk_sustainability_energy_consumption_record_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ADD CONSTRAINT `fk_sustainability_energy_consumption_record_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_target_id` FOREIGN KEY (`target_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ADD CONSTRAINT `fk_sustainability_supplier_emissions_disclosure_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_emissions_factor_id` FOREIGN KEY (`emissions_factor_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`emissions_factor`(`emissions_factor_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ADD CONSTRAINT `fk_sustainability_packaging_sustainability_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ADD CONSTRAINT `fk_sustainability_customer_carbon_report_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ADD CONSTRAINT `fk_sustainability_esg_rating_record_esg_disclosure_id` FOREIGN KEY (`esg_disclosure_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`esg_disclosure`(`esg_disclosure_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ADD CONSTRAINT `fk_sustainability_water_consumption_record_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`compliance_period` ADD CONSTRAINT `fk_sustainability_compliance_period_prior_compliance_period_id` FOREIGN KEY (`prior_compliance_period_id`) REFERENCES `transport_shipping_ecm`.`sustainability`.`compliance_period`(`compliance_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`sustainability` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `transport_shipping_ecm`.`sustainability` SET TAGS ('dbx_domain' = 'sustainability');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` SET TAGS ('dbx_subdomain' = 'carbon_accounting');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `superseded_by_factor_emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Emissions Factor ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `biofuel_blend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Biofuel Blend Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|estimated');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `emission_intensity_value` SET TAGS ('dbx_business_glossary_term' = 'Emission Intensity Value');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `emissions_factor_status` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `emissions_factor_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|draft|under_review|archived');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `factor_code` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `factor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `factor_name` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `gwp_multiplier_ch4` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP) Multiplier - CH4 (Methane)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `gwp_multiplier_co2` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP) Multiplier - CO2 (Carbon Dioxide)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `gwp_multiplier_n2o` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP) Multiplier - N2O (Nitrous Oxide)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `intensity_unit` SET TAGS ('dbx_business_glossary_term' = 'Intensity Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `intensity_unit` SET TAGS ('dbx_value_regex' = 'gCO2e/tonne-km|gCO2e/liter|gCO2e/kWh|kgCO2e/TEU-km|gCO2e/pkm|kgCO2e/shipment');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `load_factor_assumption` SET TAGS ('dbx_business_glossary_term' = 'Load Factor Assumption');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `publication_year` SET TAGS ('dbx_business_glossary_term' = 'Publication Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `scope_3_category` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `scope_classification` SET TAGS ('dbx_business_glossary_term' = 'GHG (Greenhouse Gas) Scope Classification');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `scope_classification` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Source Authority');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `source_publication` SET TAGS ('dbx_business_glossary_term' = 'Source Publication');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|facility');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `uncertainty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uncertainty Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `vehicle_category` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Category');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`emissions_factor` ALTER COLUMN `well_to_tank_included` SET TAGS ('dbx_business_glossary_term' = 'Well-to-Tank (WTT) Emissions Included');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` SET TAGS ('dbx_subdomain' = 'carbon_accounting');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `customer_carbon_report_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Carbon Report Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `parcel_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Manifest Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `actual_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `calculation_methodology_version` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology Version');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `calculation_notes` SET TAGS ('dbx_business_glossary_term' = 'Calculation Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `calculation_run_code` SET TAGS ('dbx_business_glossary_term' = 'Calculation Run ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `carbon_offset_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset (Kilograms CO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|pending_review');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'measured|modeled|default');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `dim_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance (Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `emissions_factor_co2e_per_tonne_km` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor (CO2e per Tonne-KM)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `emissions_factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Source');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `emissions_factor_source` SET TAGS ('dbx_value_regex' = 'glec|defra|carrier_specific|epa|custom');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `fuel_consumed_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed (Liters)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `green_logistics_sla_flag` SET TAGS ('dbx_business_glossary_term' = 'Green Logistics Service Level Agreement (SLA) Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `gross_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Carbon Dioxide Equivalent (CO2e) Emissions (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `load_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Load Factor (Percent)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `net_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Carbon Dioxide Equivalent (CO2e) Emissions (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_value_regex' = 'eu_ets|corsia|none');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `scope_classification` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Scope Classification');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `scope_classification` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Service Level');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `tonne_km` SET TAGS ('dbx_business_glossary_term' = 'Tonne-Kilometer (Tonne-KM)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `verification_body` SET TAGS ('dbx_business_glossary_term' = 'Verification Body');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending|rejected');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` SET TAGS ('dbx_subdomain' = 'offset_compliance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Program ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `additionality_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Additionality Verified Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `co_benefits` SET TAGS ('dbx_business_glossary_term' = 'Co-Benefits');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `corsia_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offsetting and Reduction Scheme for International Aviation (CORSIA) Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `credits_purchased` SET TAGS ('dbx_business_glossary_term' = 'Credits Purchased');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `credits_reserved` SET TAGS ('dbx_business_glossary_term' = 'Credits Reserved');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `credits_retired` SET TAGS ('dbx_business_glossary_term' = 'Credits Retired');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `eu_ets_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'European Union Emissions Trading System (EU ETS) Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Rejected|Under Review');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `permanence_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Permanence Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `permanence_risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `price_per_tonne_co2e` SET TAGS ('dbx_business_glossary_term' = 'Price Per Tonne Carbon Dioxide Equivalent (CO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Program Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Program Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Program Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Active|Suspended|Completed|Cancelled|Under Review|Approved');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Project Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'Reforestation|Renewable Energy|Methane Capture|Energy Efficiency|Avoided Deforestation|Carbon Sequestration');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `registry_url` SET TAGS ('dbx_business_glossary_term' = 'Registry Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goals (SDG) Alignment');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `total_credits_available` SET TAGS ('dbx_business_glossary_term' = 'Total Credits Available');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `verification_standard` SET TAGS ('dbx_business_glossary_term' = 'Verification Standard');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `vintage_year_end` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year End');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_program` ALTER COLUMN `vintage_year_start` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year Start');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` SET TAGS ('dbx_subdomain' = 'offset_compliance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `carbon_offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Transaction ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Offset Program ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `green_shipment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Green Shipment Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Retirement Certificate ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `compliance_scheme` SET TAGS ('dbx_business_glossary_term' = 'Compliance Scheme');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `compliance_scheme` SET TAGS ('dbx_value_regex' = 'CORSIA|EU_ETS|voluntary|other');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `offset_standard` SET TAGS ('dbx_business_glossary_term' = 'Offset Standard');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `project_location_country` SET TAGS ('dbx_business_glossary_term' = 'Project Location Country');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `project_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'renewable_energy|forestry|methane_capture|energy_efficiency|cookstoves|other');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `quantity_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Quantity (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'Registry Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `registry_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Serial Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `seller_name` SET TAGS ('dbx_business_glossary_term' = 'Seller Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `transaction_fee` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `transaction_purpose` SET TAGS ('dbx_business_glossary_term' = 'Transaction Purpose');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `transaction_purpose` SET TAGS ('dbx_value_regex' = 'voluntary_customer_offset|regulatory_compliance|internal_neutrality|corporate_commitment|customer_request|other');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|settled|cancelled|failed|under_review');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|retirement|transfer|cancellation|issuance|reversal');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|rejected|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` SET TAGS ('dbx_subdomain' = 'carbon_accounting');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `fuel_consumption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Record ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Certificate ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `dispatch_run_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Run Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `freight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Trip ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `last_mile_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Dispatch Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `saf_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Saf Procurement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `ambient_temperature` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature Celsius');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `carbon_offset_applied` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Applied Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `cargo_weight` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `cargo_weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `cargo_weight_unit` SET TAGS ('dbx_value_regex' = 'kilograms|tonnes|pounds');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `co2e_emissions` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `consumption_date` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|incomplete|anomaly|pending_review');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'iot_telemetry|manual_entry|edi_carrier|fuel_card|invoice|estimated');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `distance_travelled` SET TAGS ('dbx_business_glossary_term' = 'Distance Travelled');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `distance_unit` SET TAGS ('dbx_business_glossary_term' = 'Distance Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `distance_unit` SET TAGS ('dbx_value_regex' = 'kilometres|miles|nautical_miles');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `emission_factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Source');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `emission_factor_source` SET TAGS ('dbx_value_regex' = 'ipcc|defra|epa|corsia|eu_ets|custom');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `engine_hours` SET TAGS ('dbx_business_glossary_term' = 'Engine Operating Hours');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `fuel_cost` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `fuel_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `fuel_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `fuel_efficiency` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `fuel_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity Consumed');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `fuel_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `fuel_quantity_unit` SET TAGS ('dbx_value_regex' = 'litres|kilograms|kwh|gallons|tonnes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `fuel_supplier` SET TAGS ('dbx_business_glossary_term' = 'Fuel Supplier Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `load_factor` SET TAGS ('dbx_business_glossary_term' = 'Load Factor Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `operational_mode` SET TAGS ('dbx_business_glossary_term' = 'Operational Mode');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `refueling_location` SET TAGS ('dbx_business_glossary_term' = 'Refueling Location');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `route_segment` SET TAGS ('dbx_business_glossary_term' = 'Route Segment');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `scope_classification` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Scope Classification');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `scope_classification` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|audited|disputed');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`fuel_consumption_record` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|fog|wind|storm');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` SET TAGS ('dbx_subdomain' = 'reporting_governance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `baseline_recalculation_policy` SET TAGS ('dbx_business_glossary_term' = 'Baseline Recalculation Policy');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `boundary_definition` SET TAGS ('dbx_business_glossary_term' = 'Boundary Definition');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `current_value` SET TAGS ('dbx_business_glossary_term' = 'Current Value');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `current_value_year` SET TAGS ('dbx_business_glossary_term' = 'Current Value Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `disclosure_channel` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Channel');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country_specific|facility_specific');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `governing_framework` SET TAGS ('dbx_business_glossary_term' = 'Governing Framework');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `interim_milestone_value` SET TAGS ('dbx_business_glossary_term' = 'Interim Milestone Value');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `interim_milestone_year` SET TAGS ('dbx_business_glossary_term' = 'Interim Milestone Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `linked_incentive_flag` SET TAGS ('dbx_business_glossary_term' = 'Linked Incentive Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Methodology');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `offsetting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Offsetting Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `offsetting_limit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Offsetting Limit Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Progress Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reduction Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `renewable_energy_source_types` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Source Types');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `sbti_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Science Based Targets initiative (SBTi) Validation Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `sbti_validation_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|validated|rejected|expired');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `scope_3_category` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `scope_coverage` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Scope Coverage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `scope_coverage` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3|scope_1_2|scope_1_2_3|scope_3_category_specific');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'Target Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `target_description` SET TAGS ('dbx_business_glossary_term' = 'Target Description');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Target Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Target Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'absolute_emissions_reduction|intensity_reduction|renewable_energy_percentage|net_zero_pledge|sbti_aligned|carbon_neutral');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`target` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Target Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` SET TAGS ('dbx_subdomain' = 'reporting_governance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Disclosure Identifier');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity Identifier');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Assurance Level');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'none|limited|reasonable');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_opinion` SET TAGS ('dbx_business_glossary_term' = 'Assurance Opinion');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_opinion` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `board_independence_percentage` SET TAGS ('dbx_business_glossary_term' = 'Board Independence Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `carbon_offset_credits_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Credits in Tonnes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `corsia_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offsetting and Reduction Scheme for International Aviation (CORSIA) Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `data_privacy_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Incidents Count');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_framework` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Framework');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Reference Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption in Megawatt Hours (MWh)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `ethics_training_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ethics Training Completion Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `eu_ets_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'European Union Emissions Trading System (EU ETS) Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `female_workforce_percentage` SET TAGS ('dbx_business_glossary_term' = 'Female Workforce Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `lost_time_injury_rate` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Injury Rate (LTIR)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `net_zero_target_year` SET TAGS ('dbx_business_glossary_term' = 'Net Zero Target Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `prepared_by_name` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `publication_url` SET TAGS ('dbx_business_glossary_term' = 'Publication Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `science_based_targets_flag` SET TAGS ('dbx_business_glossary_term' = 'Science Based Targets Initiative (SBTi) Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `scope_1_emissions_co2e_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Emissions Carbon Dioxide Equivalent (CO2e) in Tonnes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `scope_2_emissions_co2e_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Emissions Carbon Dioxide Equivalent (CO2e) in Tonnes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `scope_3_emissions_co2e_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Emissions Carbon Dioxide Equivalent (CO2e) in Tonnes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `sustainability_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Investment Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `sustainability_investment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `total_emissions_co2e_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Total Emissions Carbon Dioxide Equivalent (CO2e) in Tonnes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `total_workforce_fte` SET TAGS ('dbx_business_glossary_term' = 'Total Workforce Full-Time Equivalent (FTE)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `waste_generated_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated in Tonnes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `waste_recycled_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Recycled Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `water_consumption_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `workforce_diversity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Workforce Diversity Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` SET TAGS ('dbx_subdomain' = 'carbon_accounting');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Inventory ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `base_year` SET TAGS ('dbx_business_glossary_term' = 'Base Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `base_year_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Base Year Emissions (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `base_year_recalculation_flag` SET TAGS ('dbx_business_glossary_term' = 'Base Year Recalculation Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `biogenic_co2_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Biogenic Carbon Dioxide (CO2) Emissions (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `carbon_offsets_purchased_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offsets Purchased (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `carbon_removals_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Removals (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `cdp_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Disclosure Project (CDP) Disclosure Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `intensity_ratio_tco2e_per_fte` SET TAGS ('dbx_business_glossary_term' = 'Intensity Ratio Tonnes Carbon Dioxide Equivalent (tCO2e) per Full-Time Equivalent (FTE)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `intensity_ratio_tco2e_per_revenue_million` SET TAGS ('dbx_business_glossary_term' = 'Intensity Ratio Tonnes Carbon Dioxide Equivalent (tCO2e) per Million Revenue');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `intensity_ratio_tco2e_per_tonne_km` SET TAGS ('dbx_business_glossary_term' = 'Intensity Ratio Tonnes Carbon Dioxide Equivalent (tCO2e) per Tonne-Kilometer');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|verified|published|archived');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `inventory_year` SET TAGS ('dbx_business_glossary_term' = 'Inventory Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inventory Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `organizational_boundary_method` SET TAGS ('dbx_business_glossary_term' = 'Organizational Boundary Method');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `organizational_boundary_method` SET TAGS ('dbx_value_regex' = 'operational_control|financial_control|equity_share');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_1_total_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Total Tonnes Carbon Dioxide Equivalent (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_2_location_based_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Location-Based Tonnes Carbon Dioxide Equivalent (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_2_market_based_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Market-Based Tonnes Carbon Dioxide Equivalent (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_15_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 15 Investments (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_1_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 1 Purchased Goods and Services (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_2_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 2 Capital Goods (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_3_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 3 Fuel and Energy Related Activities (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_4_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 4 Upstream Transportation and Distribution (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_5_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 5 Waste Generated in Operations (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_6_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 6 Business Travel (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_7_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 7 Employee Commuting (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_9_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 9 Downstream Transportation and Distribution (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_total_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Total Tonnes Carbon Dioxide Equivalent (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `tcfd_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Task Force on Climate-related Financial Disclosures (TCFD) Alignment Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `total_gross_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Emissions (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `total_net_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Total Net Emissions (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `verification_statement_url` SET TAGS ('dbx_business_glossary_term' = 'Verification Statement Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|limited_assurance|reasonable_assurance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` SET TAGS ('dbx_subdomain' = 'offset_compliance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `eu_ets_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'European Union Emissions Trading System (EU ETS) Allowance ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `compliance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `allocated_allowances` SET TAGS ('dbx_business_glossary_term' = 'Allocated Allowances');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'EUA|EUAA|CER|ERU');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `average_allowance_price` SET TAGS ('dbx_business_glossary_term' = 'Average Allowance Price');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `average_allowance_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `competent_authority` SET TAGS ('dbx_business_glossary_term' = 'Competent Authority');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `compliance_period_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_verification|pending_surrender|at_risk');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `corsia_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offsetting and Reduction Scheme for International Aviation (CORSIA) Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `member_state_code` SET TAGS ('dbx_business_glossary_term' = 'Member State Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `operator_code` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `outstanding_obligation_co2e` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Obligation Carbon Dioxide Equivalent (CO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = 'EUR');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `purchased_allowances` SET TAGS ('dbx_business_glossary_term' = 'Purchased Allowances');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `registry_account_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Account ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `reporting_entity` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `sector` SET TAGS ('dbx_value_regex' = 'aviation|maritime');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `surplus_allowances` SET TAGS ('dbx_business_glossary_term' = 'Surplus Allowances');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `surrender_date` SET TAGS ('dbx_business_glossary_term' = 'Surrender Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `surrender_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Surrender Deadline Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `surrendered_allowances` SET TAGS ('dbx_business_glossary_term' = 'Surrendered Allowances');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `total_allowance_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Allowance Cost');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `total_allowance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `total_available_allowances` SET TAGS ('dbx_business_glossary_term' = 'Total Available Allowances');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `transferred_in_allowances` SET TAGS ('dbx_business_glossary_term' = 'Transferred In Allowances');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `transferred_out_allowances` SET TAGS ('dbx_business_glossary_term' = 'Transferred Out Allowances');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `verified_emissions_co2e` SET TAGS ('dbx_business_glossary_term' = 'Verified Emissions Carbon Dioxide Equivalent (CO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `verifier_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Verifier Accreditation Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`eu_ets_allowance` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` SET TAGS ('dbx_subdomain' = 'offset_compliance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `corsia_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation) Compliance Record ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Airline Operator ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `compliance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `annual_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Annual Emissions (tCO2e - Tonnes of Carbon Dioxide Equivalent)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `baseline_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Baseline Emissions (tCO2e - Tonnes of Carbon Dioxide Equivalent)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `competent_authority` SET TAGS ('dbx_business_glossary_term' = 'Competent Authority');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `competent_authority_country_code` SET TAGS ('dbx_business_glossary_term' = 'Competent Authority Country Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `competent_authority_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `compliance_phase` SET TAGS ('dbx_business_glossary_term' = 'CORSIA Compliance Phase');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `compliance_phase` SET TAGS ('dbx_value_regex' = 'Phase 1|Phase 2|Phase 3');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `compliance_record_number` SET TAGS ('dbx_business_glossary_term' = 'CORSIA Compliance Record Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `compliance_record_number` SET TAGS ('dbx_value_regex' = '^CORSIA-[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'CORSIA Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|compliant|non_compliant|pending_remediation');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `eligible_units_retired_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Eligible Units Retired (tCO2e - Tonnes of Carbon Dioxide Equivalent)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `exemption_applied` SET TAGS ('dbx_business_glossary_term' = 'Exemption Applied Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `growth_factor` SET TAGS ('dbx_business_glossary_term' = 'Growth Factor');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Record Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `offset_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Offset Unit Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `offsetting_obligation_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Offsetting Obligation (tCO2e - Tonnes of Carbon Dioxide Equivalent)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `registry_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Confirmation Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'Carbon Registry Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `remediation_plan_submitted` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Submitted Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Offset Unit Retirement Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `shortfall_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Offsetting Shortfall (tCO2e - Tonnes of Carbon Dioxide Equivalent)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Submission Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Submission Deadline');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `verification_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Verification Report Reference');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|verified|verification_failed');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`corsia_compliance_record` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` SET TAGS ('dbx_subdomain' = 'reporting_governance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `green_shipment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Green Shipment Certificate ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Offset Program ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By User ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `saf_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Saf Procurement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `carbon_intensity_gco2e_per_tkm` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity in Grams CO2e per Tonne-Kilometer');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_value_regex' = '^GSC-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `certificate_pdf_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate PDF URL');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `certificate_pdf_url` SET TAGS ('dbx_value_regex' = '^https?://.*.pdf$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'issued|active|expired|revoked|suspended');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `customer_esg_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer ESG Report Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `emission_factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Source');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `green_product_tier` SET TAGS ('dbx_business_glossary_term' = 'Green Product Tier');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `green_product_tier` SET TAGS ('dbx_value_regex' = 'carbon_neutral|carbon_reduced|saf_powered|eco_standard|eco_premium');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `gross_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Issuance Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `issuance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issuance Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `issuing_organization` SET TAGS ('dbx_business_glossary_term' = 'Issuing Organization');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `net_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `offset_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Offset Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `offset_credit_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Offset Credit Serial Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `offset_program_name` SET TAGS ('dbx_business_glossary_term' = 'Offset Program Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `purchase_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Purchase Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `purchase_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `saf_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Aviation Fuel (SAF) Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `shipment_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Shipment Distance in Kilometers');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `shipment_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `verification_qr_code` SET TAGS ('dbx_business_glossary_term' = 'Verification QR Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `verification_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Verification URL');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`green_shipment_certificate` ALTER COLUMN `verification_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` SET TAGS ('dbx_subdomain' = 'offset_compliance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `saf_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Aviation Fuel (SAF) Procurement ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `compliance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Facility ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `blending_ratio_percentage` SET TAGS ('dbx_business_glossary_term' = 'Blending Ratio Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `book_and_claim_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Book-and-Claim Certificate Reference');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `certification_scheme` SET TAGS ('dbx_business_glossary_term' = 'Certification Scheme');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `certification_scheme` SET TAGS ('dbx_value_regex' = 'ISCC|RSB|SCS|LCFS|RED_II|RTFO');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `conventional_jet_fuel_displaced_litres` SET TAGS ('dbx_business_glossary_term' = 'Conventional Jet Fuel Displaced in Litres');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `corsia_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offsetting and Reduction Scheme for International Aviation (CORSIA) Batch Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `corsia_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offsetting and Reduction Scheme for International Aviation (CORSIA) Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `customer_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Allocation Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,4}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `delivery_location_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `energy_content_mj` SET TAGS ('dbx_business_glossary_term' = 'Energy Content in Megajoules (MJ)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `feedstock_origin` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Origin');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_value_regex' = 'HEFA|ATJ|FT-SPK|SIP|CHJ|HEFA-SPK');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `ghg_emissions_reduction_tonnes_co2e` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions Reduction in Tonnes Carbon Dioxide Equivalent (CO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `intended_use` SET TAGS ('dbx_value_regex' = 'operational_blending|book_and_claim|carbon_offset|research_development');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `lifecycle_ghg_intensity_gco2e_per_mj` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Greenhouse Gas (GHG) Intensity in grams Carbon Dioxide Equivalent (CO2e) per Megajoule (MJ)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Procurement Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|partially_paid|overdue|disputed');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `procurement_date` SET TAGS ('dbx_business_glossary_term' = 'Procurement Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `procurement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Procurement Reference Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `procurement_reference_number` SET TAGS ('dbx_value_regex' = '^SAF-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `procurement_status` SET TAGS ('dbx_business_glossary_term' = 'Procurement Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `saf_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Aviation Fuel (SAF) Volume in Gallons');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `saf_volume_litres` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Aviation Fuel (SAF) Volume in Litres');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `sustainability_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Report Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `unit_price_per_litre` SET TAGS ('dbx_business_glossary_term' = 'Unit Price per Litre');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`saf_procurement` ALTER COLUMN `unit_price_per_litre` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `renewable_energy_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `facility_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Inspection Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `cdp_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Disclosure Project (CDP) Reportable Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'active|retired|cancelled|expired|pending');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'REC|GO|I-REC|TIGR|LGC|Other');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `co2e_avoided_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Avoided (Tonnes)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `cost_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Cost per MWh');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `cost_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `energy_quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Quantity (MWh)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `energy_source` SET TAGS ('dbx_business_glossary_term' = 'Energy Source');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Country Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `facility_covered` SET TAGS ('dbx_business_glossary_term' = 'Facility Covered');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generating_facility_country_code` SET TAGS ('dbx_business_glossary_term' = 'Generating Facility Country Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generating_facility_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generating_facility_location` SET TAGS ('dbx_business_glossary_term' = 'Generating Facility Location');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generating_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Generating Facility Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Generation End Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `generation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Start Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `grid_emission_factor_kg_co2e_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Grid Emission Factor (kg CO2e per MWh)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `procurement_date` SET TAGS ('dbx_business_glossary_term' = 'Procurement Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'direct_purchase|PPA|unbundled|bundled|Other');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `re100_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'RE100 Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `registry_account_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Account Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `registry_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'Registry Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|not_verified');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `environmental_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Contractor ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `tertiary_waste_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `tertiary_waste_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `tertiary_waste_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Collection Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'recycling|landfill|incineration|composting|reuse|energy_recovery');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `diversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `emissions_factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Source');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `esg_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Reporting Category');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `esg_reporting_category` SET TAGS ('dbx_value_regex' = 'environmental|social|governance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `ghg_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions in Tonnes Carbon Dioxide Equivalent (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Waste Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|archived');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `regulatory_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Waste Contractor Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Description');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|tonnes|m3|liters');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_record_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_source_area` SET TAGS ('dbx_business_glossary_term' = 'Waste Source Area');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_value_regex' = 'cardboard|plastic|hazardous|e-waste|food|general');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`waste_record` ALTER COLUMN `zero_waste_target_contribution` SET TAGS ('dbx_business_glossary_term' = 'Zero Waste Target Contribution Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `energy_consumption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Record ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumption Quantity');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `consumption_unit` SET TAGS ('dbx_business_glossary_term' = 'Consumption Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Energy Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `customer_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Facing Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|incomplete|anomaly|pending_review');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `energy_intensity_denominator` SET TAGS ('dbx_business_glossary_term' = 'Energy Intensity Denominator');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `energy_intensity_unit` SET TAGS ('dbx_business_glossary_term' = 'Energy Intensity Unit');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `energy_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `energy_type` SET TAGS ('dbx_value_regex' = 'electricity|natural_gas|diesel|gasoline|lpg|district_heat');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `meter_code` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `metering_source` SET TAGS ('dbx_business_glossary_term' = 'Metering Source');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `metering_source` SET TAGS ('dbx_value_regex' = 'smart_meter|manual_meter|invoice|estimate|iot_sensor|telematics');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `operational_context` SET TAGS ('dbx_business_glossary_term' = 'Operational Context');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `renewable_energy_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Share Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4|monthly|annual');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `scope_1_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Emissions (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `scope_2_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Emissions (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `supplier_account_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Account Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `supplier_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Energy Supplier Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Energy Tariff Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|internally_verified|third_party_verified|audited');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`energy_consumption_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` SET TAGS ('dbx_subdomain' = 'reporting_governance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_co2e_reduction_tco2e_per_year` SET TAGS ('dbx_business_glossary_term' = 'Actual Carbon Dioxide Equivalent (CO2e) Reduction (tCO2e per Year)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `baseline_co2e_emissions_tco2e_per_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Carbon Dioxide Equivalent (CO2e) Emissions (tCO2e per Year)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `baseline_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Measurement Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `capex_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Investment Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `capex_investment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `corporate_sustainability_target_alignment` SET TAGS ('dbx_business_glossary_term' = 'Corporate Sustainability Target Alignment');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `customer_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer-Facing Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `expected_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Completion Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `external_certification_target` SET TAGS ('dbx_business_glossary_term' = 'External Certification Target');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_category` SET TAGS ('dbx_business_glossary_term' = 'Initiative Category');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_category` SET TAGS ('dbx_value_regex' = 'fleet_electrification|route_optimisation|packaging_reduction|modal_shift|saf_adoption|solar_installation');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_code` SET TAGS ('dbx_business_glossary_term' = 'Initiative Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_description` SET TAGS ('dbx_business_glossary_term' = 'Initiative Description');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Initiative Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_status` SET TAGS ('dbx_business_glossary_term' = 'Initiative Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `initiative_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `investment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Investment Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `investment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `key_performance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `opex_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Investment Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `opex_investment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Initiative Owner Email Address');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Initiative Owner Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `projected_co2e_reduction_tco2e_per_year` SET TAGS ('dbx_business_glossary_term' = 'Projected Carbon Dioxide Equivalent (CO2e) Reduction (tCO2e per Year)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `regulatory_compliance_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Driver');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `roi_payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Payback Period (Months)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `roi_payback_period_months` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `scope_1_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `scope_2_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `scope_3_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `sponsoring_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Unit');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`initiative` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Initiative Start Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` SET TAGS ('dbx_subdomain' = 'carbon_accounting');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `supplier_emissions_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Emissions Disclosure ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `shipment_carrier_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carrier Assignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Verification Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `alternative_fuel_usage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fuel Usage Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `calculation_approach` SET TAGS ('dbx_business_glossary_term' = 'Calculation Approach');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `calculation_approach` SET TAGS ('dbx_value_regex' = 'fuel_based|distance_based|spend_based|activity_based|hybrid');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `cdp_disclosure_year` SET TAGS ('dbx_business_glossary_term' = 'Carbon Disclosure Project (CDP) Disclosure Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `cdp_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Disclosure Project (CDP) Score');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `corsia_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offsetting and Reduction Scheme for International Aviation (CORSIA) Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `data_completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Data Completeness Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'tier_1_primary|tier_2_secondary|tier_3_estimated|tier_4_proxy');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `disclosure_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `disclosure_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `disclosure_document_url` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Document Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `disclosure_methodology` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Methodology');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `disclosure_methodology` SET TAGS ('dbx_value_regex' = 'ghg_protocol|glec_framework|iso_14064|cdp_questionnaire|sbti_methodology|custom');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `disclosure_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Reference Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|accepted|rejected|revision_requested');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `disclosure_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Submission Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `emissions_intensity_gco2e_per_shipment` SET TAGS ('dbx_business_glossary_term' = 'Emissions Intensity (gCO2e per shipment)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `emissions_intensity_gco2e_per_tonne_km` SET TAGS ('dbx_business_glossary_term' = 'Emissions Intensity (gCO2e per tonne-km)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `eu_ets_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'European Union Emissions Trading System (EU ETS) Participant Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `sbti_commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Science Based Targets initiative (SBTi) Commitment Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `sbti_commitment_status` SET TAGS ('dbx_value_regex' = 'committed|targets_set|targets_approved|no_commitment');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `sbti_target_year` SET TAGS ('dbx_business_glossary_term' = 'Science Based Targets initiative (SBTi) Target Year');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `scope_1_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Emissions (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `scope_2_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Emissions (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `scope_3_category_4_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 4 Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `scope_3_category_9_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 9 Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `scope_3_emissions_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Emissions (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `supplier_sustainability_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Sustainability Rating');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `supplier_sustainability_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F|not_rated');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `total_freight_volume_tonne_km` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Volume (tonne-km)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `total_shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Count');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `verification_body` SET TAGS ('dbx_business_glossary_term' = 'Verification Body');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|limited_assurance|reasonable_assurance|self_reported|not_verified');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_sustainability_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Sustainability Identifier');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `biodegradable_flag` SET TAGS ('dbx_business_glossary_term' = 'Biodegradable Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `co2e_impact_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Impact (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `compostable_flag` SET TAGS ('dbx_business_glossary_term' = 'Compostable Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `customer_green_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Green Commitment Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|estimated|verified');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `end_of_life_treatment` SET TAGS ('dbx_business_glossary_term' = 'End-of-Life Treatment');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `end_of_life_treatment` SET TAGS ('dbx_value_regex' = 'recycled|composted|landfill|incinerated|reused|returned');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `end_of_life_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `end_of_life_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `esg_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Disclosure Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `fsc_certification_code` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certification Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_cost` SET TAGS ('dbx_business_glossary_term' = 'Packaging Cost');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_date` SET TAGS ('dbx_business_glossary_term' = 'Packaging Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Packaging Lifecycle Stage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'production|distribution|use|end_of_life|recycling|disposal');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_material_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_optimization_score` SET TAGS ('dbx_business_glossary_term' = 'Packaging Optimization Score');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_standard_compliance` SET TAGS ('dbx_business_glossary_term' = 'Packaging Standard Compliance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_standard_compliance` SET TAGS ('dbx_value_regex' = 'FSC|PEFC|EU_Packaging_Directive|Cradle_to_Cradle|BPI_Compostable|OK_Compost');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packaging Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Volume (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_waste_generated_kg` SET TAGS ('dbx_business_glossary_term' = 'Packaging Waste Generated (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `packaging_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Packaging Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `plastic_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Plastic-Free Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `recycled_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = '^d{4}-Q[1-4]$|^d{4}-d{2}$|^d{4}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `return_reuse_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return and Reuse Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `reusable_packaging_flag` SET TAGS ('dbx_business_glossary_term' = 'Reusable Packaging Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`packaging_sustainability` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goals (SDG) Alignment');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` SET TAGS ('dbx_subdomain' = 'reporting_governance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `customer_carbon_report_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Carbon Report ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Source Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `air_freight_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Air Freight Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_value_regex' = 'ISO 14083|GLEC Framework|GHG Protocol|IATA Recommended Practice|IMO Guidelines|Custom');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `customer_acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `customer_esg_framework` SET TAGS ('dbx_business_glossary_term' = 'Customer Environmental, Social, and Governance (ESG) Framework');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `customer_notes` SET TAGS ('dbx_business_glossary_term' = 'Customer Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `emissions_intensity_gco2e_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Emissions Intensity (grams CO2e per kilogram)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `emissions_intensity_gco2e_per_tonne_km` SET TAGS ('dbx_business_glossary_term' = 'Emissions Intensity (grams CO2e per tonne-kilometer)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `gross_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `last_mile_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Last-Mile Delivery Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `methodology_version` SET TAGS ('dbx_business_glossary_term' = 'Methodology Version');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `net_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `ocean_freight_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Ocean Freight Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `offset_certificates_applied` SET TAGS ('dbx_business_glossary_term' = 'Offset Certificates Applied');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `offset_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Offset Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `offset_program_names` SET TAGS ('dbx_business_glossary_term' = 'Offset Program Names');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `rail_freight_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Rail Freight Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `regulatory_compliance_flags` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flags');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `report_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report Format');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `report_format` SET TAGS ('dbx_value_regex' = 'PDF|Excel|JSON|XML|API|EDI');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `report_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Generation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `report_language` SET TAGS ('dbx_business_glossary_term' = 'Report Language');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|generated|delivered|accepted|rejected|revised');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `road_freight_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Road Freight Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `scope_1_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `scope_2_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `scope_3_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `total_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Total Distance (Kilometers)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `total_shipments` SET TAGS ('dbx_business_glossary_term' = 'Total Shipments');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `total_tonne_km` SET TAGS ('dbx_business_glossary_term' = 'Total Tonne-Kilometers');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `uncertainty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uncertainty Percentage');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|internally_verified|third_party_verified|certified');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`customer_carbon_report` ALTER COLUMN `warehouse_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Operations Carbon Dioxide Equivalent (CO2e) in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` SET TAGS ('dbx_subdomain' = 'reporting_governance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `esg_rating_record_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Rating Record Identifier');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'ESG Assessment Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope Description');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'ESG Certification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|provisional|under_review|expired|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `customer_reporting_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Reporting Use Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_rated');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `disclosure_url` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `environmental_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Pillar Score');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `governance_score` SET TAGS ('dbx_business_glossary_term' = 'Governance Pillar Score');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `improvement_recommendations` SET TAGS ('dbx_business_glossary_term' = 'ESG Improvement Recommendations');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `industry_percentile` SET TAGS ('dbx_business_glossary_term' = 'Industry Percentile Ranking');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `industry_rank` SET TAGS ('dbx_business_glossary_term' = 'Industry Rank Position');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_review|rejected|draft');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `investor_relations_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Investor Relations Use Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `key_strengths` SET TAGS ('dbx_business_glossary_term' = 'Key ESG Strengths');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `key_weaknesses` SET TAGS ('dbx_business_glossary_term' = 'Key ESG Weaknesses');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `methodology_version` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology Version');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'ESG Rating Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall ESG Score');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `overall_score_scale` SET TAGS ('dbx_business_glossary_term' = 'Overall ESG Score Scale');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `peer_group_size` SET TAGS ('dbx_business_glossary_term' = 'Peer Group Size');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `prior_period_overall_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Overall ESG Score');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `prior_period_rating_tier` SET TAGS ('dbx_business_glossary_term' = 'Prior Period ESG Rating Tier');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `rating_agency` SET TAGS ('dbx_business_glossary_term' = 'ESG Rating Agency Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `rating_agency` SET TAGS ('dbx_value_regex' = 'MSCI|Sustainalytics|EcoVadis|CDP|DJSI|ISS');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `rating_agency_code` SET TAGS ('dbx_business_glossary_term' = 'ESG Rating Agency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `rating_tier` SET TAGS ('dbx_business_glossary_term' = 'ESG Rating Tier or Grade');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `rating_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Validity End Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'ESG Report Reference Number');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `score_change` SET TAGS ('dbx_business_glossary_term' = 'ESG Score Change');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `social_score` SET TAGS ('dbx_business_glossary_term' = 'Social Pillar Score');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `tender_qualification_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Tender Qualification Use Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `verification_body` SET TAGS ('dbx_business_glossary_term' = 'Verification Body Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'ESG Rating Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`esg_rating_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|partially_verified|pending');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` SET TAGS ('dbx_subdomain' = 'resource_operations');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_consumption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption Record ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempted');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `discharge_destination_type` SET TAGS ('dbx_business_glossary_term' = 'Discharge Destination Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `discharge_destination_type` SET TAGS ('dbx_value_regex' = 'surface_water|groundwater|seawater|municipal_sewer|third_party|land_application');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `discharge_water_quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Discharge Water Quality Standard');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'ESG (Environmental, Social, and Governance) Reporting Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Country Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `facility_region` SET TAGS ('dbx_business_glossary_term' = 'Facility Region');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'warehouse|distribution_center|office|terminal|sorting_facility|maintenance_depot');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `gri_303_disclosure_category` SET TAGS ('dbx_business_glossary_term' = 'GRI (Global Reporting Initiative) 303 Disclosure Category');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `gri_303_disclosure_category` SET TAGS ('dbx_value_regex' = '303_1|303_2|303_3|303_4|303_5');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'metered|estimated|calculated|supplier_invoice');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `non_compliance_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Incident Count');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `regulatory_permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Reference');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Water Supplier Name');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `total_water_withdrawn_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Water Withdrawn (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `verification_body` SET TAGS ('dbx_business_glossary_term' = 'Verification Body');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification|not_required');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `wastewater_treatment_method` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Method');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `wastewater_treatment_method` SET TAGS ('dbx_value_regex' = 'on_site_treatment|municipal_treatment|third_party_treatment|no_treatment|septic_system|direct_discharge');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `wastewater_treatment_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `wastewater_treatment_method` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_consumed_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Consumed (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Water Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Water Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_discharged_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Discharged (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_intensity_per_employee` SET TAGS ('dbx_business_glossary_term' = 'Water Intensity Per Employee');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_intensity_per_sqm` SET TAGS ('dbx_business_glossary_term' = 'Water Intensity Per Square Meter');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_recycled_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Recycled (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Water Source Type');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_source_type` SET TAGS ('dbx_value_regex' = 'municipal|groundwater|rainwater_harvesting|surface_water|seawater|third_party');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_stewardship_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Stewardship Program Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_stress_area_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Stress Area Flag');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_stress_level` SET TAGS ('dbx_business_glossary_term' = 'Water Stress Level');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`water_consumption_record` ALTER COLUMN `water_stress_level` SET TAGS ('dbx_value_regex' = 'low|low_to_medium|medium_to_high|high|extremely_high');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`compliance_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`compliance_period` SET TAGS ('dbx_subdomain' = 'offset_compliance');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`compliance_period` ALTER COLUMN `compliance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Identifier');
ALTER TABLE `transport_shipping_ecm`.`sustainability`.`compliance_period` ALTER COLUMN `prior_compliance_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
