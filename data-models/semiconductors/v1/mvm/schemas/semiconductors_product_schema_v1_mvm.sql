-- Schema for Domain: product | Business: Semiconductors | Version: v1_mvm
-- Generated on: 2026-05-06 20:34:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `semiconductors_ecm`.`product` COMMENT 'Authoritative semiconductor product catalog encompassing ICs, SoCs, ASICs, FPGAs, IP cores, and discrete devices. SSOT for product specifications, SKUs, BOM, process node assignments, PPA metrics, product lifecycle status (NPI through EOL), PCN management, and LTB notifications. Integrates with PLM systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`ic_catalog` (
    `ic_catalog_id` BIGINT COMMENT 'Unique identifier for the IC catalog entry. Primary key for the master record of semiconductor products including ICs, SoCs, ASICs, FPGAs, discretes, and licensable IP cores.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Product characterization and qualification require tracking which fab tool was used for electrical/physical parameter validation. Critical for yield correlation analysis, process transfer, and manufac',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for product cost tracking and profitability reporting; each IC is assigned to a cost center for budgeting.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Required for Export Control: each IC must be linked to its ECCN classification for export compliance reporting.',
    `family_id` BIGINT COMMENT 'FK to product.product_family',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: IC products are manufactured and sold by specific legal entities for revenue recognition, export compliance (ECCN/ITAR already tracked, entity needed for licensing), tax reporting, and inter-company t',
    `process_node_id` BIGINT COMMENT 'FK to product.process_node.process_node_id — Every IC product is manufactured on a specific process node. This is a fundamental product attribute that references the process node master.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Individual IC products are tracked by profit center for product-level revenue, margin, and P&L reporting; enables portfolio analysis, pricing decisions, and product lifecycle profitability management.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Procurement process requires linking each IC catalog entry to its primary supplier for sourcing, cost analysis, and compliance tracking.',
    `aec_qualification_level` STRING COMMENT 'Specific AEC qualification standard met. Q100: ICs, Q101: Discretes, Q102: Optoelectronics, Q200: Passives. Set to NA if not automotive qualified.. Valid values are `AEC-Q100|AEC-Q101|AEC-Q102|AEC-Q200|NA`',
    `automotive_qualified` BOOLEAN COMMENT 'Indicates whether the product has passed automotive-grade qualification testing per AEC-Q standards. Required for automotive market. Includes extended temperature, reliability, and quality requirements.',
    `catalog_to_family` BIGINT COMMENT 'FK to product.product_family.product_family_id — Every IC product belongs to a product family in the taxonomy hierarchy. This is the primary classification FK.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the IC was manufactured or substantially transformed. Used for trade compliance, tariffs, and country-of-origin marking requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IC catalog record was first created in the PLM system. Audit trail for data governance and lineage tracking.',
    `design_type` STRING COMMENT 'Design methodology used for IC development. Determines NRE cost, time to market, and flexibility. Full custom offers maximum optimization; standard cell balances speed and cost.. Valid values are `Full_Custom|Semi_Custom|Standard_Cell|Gate_Array|Structured_ASIC|Platform_Based`',
    `die_size_mm2` DECIMAL(18,2) COMMENT 'Physical die area in square millimeters after final layout. Critical cost driver as it determines dies per wafer and manufacturing yield economics. Part of PPA metrics.',
    `ear_eccn_code` STRING COMMENT 'ECCN code assigned under US Export Administration Regulations. Determines export licensing requirements for dual-use items. Format: 3A001.a. EAR99 indicates no specific ECCN.. Valid values are `^[0-9][A-Z][0-9]{3}(.[a-z])?$`',
    `eol_announcement_date` DATE COMMENT 'Date when EOL was formally announced to customers via Product Change Notification (PCN). Triggers last-time-buy (LTB) planning and customer transition activities.',
    `external_part_number` STRING COMMENT 'Customer-facing orderable part number published in datasheets and used for commercial transactions. May differ from internal part number for marketing or legacy reasons.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `first_silicon_date` DATE COMMENT 'Date when first fabricated silicon wafers were received from the fab for initial testing and validation. Marks start of silicon bring-up phase.',
    `hts_code` STRING COMMENT 'US Harmonized Tariff Schedule classification code for customs and import duty determination. Format: 8542.31.0000 for electronic integrated circuits.. Valid values are `^[0-9]{4}.[0-9]{2}.[0-9]{4}$`',
    `internal_part_number` STRING COMMENT 'Company-assigned unique part number for internal identification, tracking, and PLM integration. Primary business identifier for the IC design.. Valid values are `^[A-Z0-9]{8,20}$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this catalog entry is currently active and available for business operations. False indicates archived or soft-deleted record retained for historical reference.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the product is subject to ITAR export controls for defense-related articles. True if product requires US State Department export license for international shipment.',
    `last_ship_date` DATE COMMENT 'Final date when product shipments will be made. Marks complete discontinuation of the product. Typically 6-12 months after last-time-buy date to allow for manufacturing lead time.',
    `last_time_buy_date` DATE COMMENT 'Final date for customers to place orders before product is discontinued. Typically 6-12 months after EOL announcement. After this date, no new orders are accepted.',
    `lead_free_compliant` BOOLEAN COMMENT 'Indicates whether the product meets RoHS (Restriction of Hazardous Substances) lead-free requirements. True if compliant with EU RoHS Directive for lead-free solder and materials.',
    `lifecycle_status` STRING COMMENT 'Current stage in the product lifecycle from New Product Introduction (NPI) through End of Life (EOL). Governs manufacturing, sales, and support activities. Transitions tracked in status history. [ENUM-REF-CANDIDATE: NPI|Qualification|Production|Mature|EOL_Announced|EOL_Active|Obsolete — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IC catalog record was last updated. Tracks data currency and change history for audit and synchronization purposes.',
    `npi_phase` STRING COMMENT 'Detailed phase within NPI lifecycle for products in pre-production stages. Tracks progress from concept through design, tapeout, silicon bring-up, and qualification. Set to NA for production products. [ENUM-REF-CANDIDATE: Concept|Design|Tapeout|Silicon_Validation|Qualification|Ramp|Production|NA — 8 candidates stripped; promote to reference product]',
    `operating_frequency_max_mhz` DECIMAL(18,2) COMMENT 'Maximum clock frequency in MHz at which the IC can reliably operate. Key performance metric for processors, SoCs, and high-speed digital circuits. Part of PPA metrics.',
    `operating_voltage_max_v` DECIMAL(18,2) COMMENT 'Maximum supply voltage in volts for safe operation. Defines upper bound of operating voltage range. Exceeding this may cause device damage or reliability issues.',
    `operating_voltage_min_v` DECIMAL(18,2) COMMENT 'Minimum supply voltage in volts for guaranteed operation. Defines lower bound of operating voltage range for power optimization and battery operation.',
    `pin_count` STRING COMMENT 'Total number of external pins or balls on the package. Determines PCB routing complexity, package cost, and I/O capability.',
    `power_max_mw` DECIMAL(18,2) COMMENT 'Maximum power consumption in milliwatts under worst-case operating conditions. Used for thermal design, power supply sizing, and system integration planning.',
    `power_typical_mw` DECIMAL(18,2) COMMENT 'Typical operating power consumption in milliwatts under nominal conditions. Critical PPA metric for mobile, IoT, and battery-powered applications. Measured at specified voltage and frequency.',
    `process_technology` STRING COMMENT 'Underlying semiconductor process technology architecture. Examples: CMOS (Complementary Metal-Oxide-Semiconductor), FinFET (Fin Field-Effect Transistor), GAA (Gate All Around), BiCMOS (Bipolar CMOS). [ENUM-REF-CANDIDATE: CMOS|FinFET|GAA|BiCMOS|SOI|GaN|SiGe — 7 candidates stripped; promote to reference product]',
    `product_name` STRING COMMENT 'Human-readable marketing name of the IC product used in customer communications, datasheets, and sales collateral.',
    `product_type` STRING COMMENT 'High-level classification of the semiconductor product type. Determines design flow, manufacturing process, and business model (silicon vs. licensable IP). [ENUM-REF-CANDIDATE: IC|SoC|ASIC|FPGA|IP_Core|Discrete|Memory|Analog|Mixed_Signal|RF — 10 candidates stripped; promote to reference product]',
    `production_release_date` DATE COMMENT 'Date when product was officially released to production status and made available for volume manufacturing and customer orders. Marks end of qualification phase.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates compliance with EU REACH (Registration, Evaluation, Authorization and Restriction of Chemicals) regulation. Confirms no Substances of Very High Concern (SVHC) above threshold.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates full compliance with EU RoHS Directive restricting hazardous substances (lead, mercury, cadmium, hexavalent chromium, PBB, PBDE). Required for European market access.',
    `rtl_language` STRING COMMENT 'Hardware description language used for RTL design specification. Verilog and SystemVerilog are industry standard for digital design. Set to NA for analog-only or IP-only products.. Valid values are `Verilog|VHDL|SystemVerilog|Chisel|NA`',
    `tapeout_date` DATE COMMENT 'Date when final GDSII design database was released to the fab for mask generation and wafer fabrication. Marks completion of design phase and start of manufacturing.',
    `target_market` STRING COMMENT 'Primary market segment or application domain for which the IC is designed. Determines qualification requirements, reliability standards, and regulatory compliance needs. [ENUM-REF-CANDIDATE: Automotive|Consumer|Industrial|Medical|Aerospace|Defense|Telecom|Computing|IoT|AI_ML — 10 candidates stripped; promote to reference product]',
    `temperature_grade` STRING COMMENT 'Temperature range classification determining qualified operating environment. Commercial: 0-70C, Industrial: -40-85C, Automotive: -40-125C, Military: -55-125C. Critical for market qualification.. Valid values are `Commercial|Industrial|Automotive|Military|Extended`',
    `transistor_count` BIGINT COMMENT 'Total number of transistors on the die. Key complexity metric for digital ICs and SoCs. Used for design effort estimation and manufacturing complexity assessment.',
    CONSTRAINT pk_ic_catalog PRIMARY KEY(`ic_catalog_id`)
) COMMENT 'Master record for all semiconductor products (ICs, SoCs, ASICs, FPGAs, discretes, licensable IP cores). SSOT for product identity, internal/external part numbers, product family assignment, process node, target market, and lifecycle state with full NPI→qualification→production→EOL transition history. Golden record integrated with PLM. Each entry represents a unique silicon design with one or more orderable SKU variants.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the stock keeping unit record. Primary key for the SKU entity representing a distinct orderable variant of a catalog product.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Orderable SKUs require direct ECCN classification for export compliance, customs documentation, and shipping restrictions. While ic_catalog has ECCN, SKU variants (speed/voltage/temp) may have differe',
    `replacement_sku_id` BIGINT COMMENT 'Reference to the recommended replacement SKU for customers when this SKU reaches end of life. Facilitates design migration and continuity planning.',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the parent product definition in the IC catalog. Links this SKU to the base product design and specification.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: SKUs (speed grades, temperature grades, package variants) are derived from a specific tapeout die. Product operations teams must trace which tapeout produced the die underlying each orderable SKU — re',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to product.ic_catalog.ic_catalog_id — Every SKU is an orderable variant of a catalog product. This is the most fundamental FK in the domain — without it, SKUs are orphaned from their parent product definition.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the country where final manufacturing or substantial transformation occurred. Required for customs documentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU record was first created in the system. Audit trail for data lineage and compliance.',
    `customer_part_number` STRING COMMENT 'Optional customer-specific part number assigned to this SKU for custom or design-win scenarios. Facilitates customer BOM alignment.',
    `eol_announcement_date` DATE COMMENT 'Date when Product Change Notification (PCN) was issued announcing the end of life for this SKU. Triggers Last Time Buy (LTB) planning for customers.',
    `halogen_free` BOOLEAN COMMENT 'Indicates whether this SKU is manufactured without halogen-containing materials (chlorine, bromine compounds). Required for certain environmental certifications.',
    `hts_code` STRING COMMENT 'International customs classification code for tariff and duty calculation. Used for cross-border shipments and trade compliance.. Valid values are `^[0-9]{4}.[0-9]{2}.[0-9]{2}.[0-9]{2}$`',
    `introduction_date` DATE COMMENT 'Date when this SKU was first made available for customer orders. Marks the transition from NPI to Active lifecycle status.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether this SKU is subject to US ITAR export controls for defense articles. Requires special licensing and handling procedures.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SKU record was most recently updated. Tracks data currency and change history.',
    `last_ship_date` DATE COMMENT 'Final date when shipments of this SKU will be fulfilled. Marks the end of product availability and transition to discontinued status.',
    `last_time_buy_date` DATE COMMENT 'Final date for customers to place orders for this SKU before discontinuation. Typically 6-12 months after EOL announcement.',
    `lead_time_weeks` STRING COMMENT 'Typical manufacturing and delivery lead time in weeks from order placement to shipment. Subject to capacity allocation and supply chain conditions.',
    `lifecycle_status` STRING COMMENT 'Current stage in the product lifecycle. NPI (New Product Introduction), Active (full production), Mature (stable demand), Declining (phase-out), EOL Announced (End of Life notice issued), Discontinued (no longer available).. Valid values are `npi|active|mature|declining|eol_announced|discontinued`',
    `list_price_usd` DECIMAL(18,2) COMMENT 'Published list price in US dollars for this SKU at 1000-unit quantity. Actual transaction prices subject to volume discounts and customer agreements.',
    `manufacturer_part_number` STRING COMMENT 'Official manufacturer part number assigned to this SKU. Used for cross-reference with distributor catalogs and customer Bill of Materials (BOM).. Valid values are `^[A-Z0-9-]{6,30}$`',
    `minimum_order_quantity` STRING COMMENT 'Smallest quantity that can be ordered for this SKU in a single purchase order line. Driven by packaging constraints and economic order quantities.',
    `moisture_sensitivity_level` STRING COMMENT 'JEDEC moisture sensitivity classification indicating required storage and handling conditions before reflow soldering. MSL1 (unlimited floor life) to MSL6 (mandatory bake before use). [ENUM-REF-CANDIDATE: MSL1|MSL2|MSL2a|MSL3|MSL4|MSL5|MSL5a|MSL6 — 8 candidates stripped; promote to reference product]',
    `orderable_flag` BOOLEAN COMMENT 'Indicates whether this SKU is currently available for new customer orders. May be false during allocation, quality holds, or phase-out periods.',
    `pcn_required_flag` BOOLEAN COMMENT 'Indicates whether any changes to this SKU specification, manufacturing process, or supply chain require formal Product Change Notification (PCN) to customers per contractual or regulatory requirements.',
    `pin_count` STRING COMMENT 'Total number of electrical pins or balls on the package. Critical for PCB design and routing complexity assessment.',
    `qualification_level` STRING COMMENT 'Reliability and qualification standard met by this SKU. AEC-Q100 for automotive ICs, AEC-Q101 for discrete automotive, MIL-STD-883 for military/aerospace.. Valid values are `commercial|industrial|automotive_aec_q100|automotive_aec_q101|military_mil_std_883|space`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether this SKU meets EU REACH regulation requirements for chemical substance registration and disclosure.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether this SKU meets EU RoHS directive requirements for restricted substances (lead, mercury, cadmium, hexavalent chromium, PBB, PBDE).',
    `shippable_flag` BOOLEAN COMMENT 'Indicates whether this SKU is currently authorized for shipment. May be false during quality holds, regulatory blocks, or export restrictions.',
    `sku_code` STRING COMMENT 'Externally-facing unique alphanumeric code identifying this orderable SKU variant. Used in customer orders, invoices, and supply chain documentation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `speed_grade` STRING COMMENT 'Performance binning classification indicating maximum operating frequency or timing specification. Higher grades command premium pricing.',
    `standard_cost_usd` DECIMAL(18,2) COMMENT 'Fully-loaded standard manufacturing cost in US dollars including wafer fabrication, assembly, test, and allocated overhead. Used for margin analysis and inventory valuation.',
    `standard_pack_quantity` STRING COMMENT 'Number of units in a standard shipping container (tape and reel, tray, tube). Orders are typically placed in multiples of this quantity.',
    `temperature_range` STRING COMMENT 'Qualified operating temperature range classification. Commercial (0-70C), Industrial (-40-85C), Automotive (-40-125C), Military (-55-125C), Extended (-40-105C).. Valid values are `commercial|industrial|automotive|military|extended`',
    `unit_weight_grams` DECIMAL(18,2) COMMENT 'Weight of a single packaged unit in grams. Used for shipping cost calculation and logistics planning.',
    `voltage_variant` STRING COMMENT 'Core or I/O voltage specification variant for this SKU. Defines power supply requirements and compatibility with system voltage rails.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock-keeping unit records representing orderable, shippable variants of catalog products. Each SKU captures the specific combination of package type, speed grade, temperature range, voltage variant, and qualification level (commercial, industrial, automotive AEC-Q100/Q101) that constitutes a distinct orderable item. Links to ic_catalog for the parent product definition and to inventory for stock tracking.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`family` (
    `family_id` BIGINT COMMENT 'Unique identifier for the product family. Primary key for the product family entity.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Product families share common ECCN classifications for portfolio-level export control planning, TAA compliance reporting, and strategic market access decisions. Supports family-level restricted countr',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Product families are owned by legal entities for revenue recognition, IP ownership, export control compliance (ITAR/EAR classification), and regulatory reporting by jurisdiction.',
    `parent_family_id` BIGINT COMMENT 'Reference to the parent product family in the hierarchy. Supports multi-level taxonomy: portfolio → family → sub-family → product → variant. Null for top-level portfolio entries.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Product families are designed for a specific semiconductor process node (e.g., a Cortex-class SoC family targeting 5nm FinFET). family.process_node_nm (INT) and family.process_technology (STRING) are ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Product families map to profit centers to attribute revenue and margin in financial statements.',
    `active_pcn_count` STRING COMMENT 'Number of active PCNs currently in effect for this product family. Indicates ongoing changes to process, materials, or design that require customer notification and approval.',
    `application_domain` STRING COMMENT 'Specific application domain or use case this product family addresses (e.g., Advanced Driver Assistance Systems, Edge AI Inference, 5G Baseband Processing). Used for technical marketing and customer solution mapping.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for this product family (e.g., Automotive Solutions, Mobile Computing, IoT and Embedded). Aligns with organizational structure and P&L responsibility.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product family record was first created in the system. Used for data lineage and audit trail.',
    `design_center_location` STRING COMMENT 'Primary design center location responsible for this product family (e.g., San Jose CA, Austin TX, Bangalore India). Used for resource planning and IP ownership tracking.',
    `dfm_score` DECIMAL(18,2) COMMENT 'Design for Manufacturability score (0-100) indicating how well the product family design aligns with manufacturing best practices. Higher scores correlate with better yield and lower manufacturing risk.',
    `dft_coverage_percent` DECIMAL(18,2) COMMENT 'Design for Testability coverage percentage indicating the proportion of circuit nodes accessible for ATPG (Automatic Test Pattern Generation). Higher coverage enables better defect detection during wafer test.',
    `discontinuation_date` DATE COMMENT 'Date when this product family was fully discontinued and removed from active catalog. No further production or shipments after this date.',
    `eda_tool_suite` STRING COMMENT 'Primary EDA tool suite used for design and verification of this product family (e.g., Cadence Virtuoso/Innovus, Synopsys Design Compiler/IC Compiler). Defines design methodology and tool licensing requirements.',
    `eol_announcement_date` DATE COMMENT 'Date when EOL was announced to customers via PCN (Product Change Notification). Triggers LTB (Last Time Buy) planning and customer migration activities.',
    `fab_site_code` STRING COMMENT 'Code identifying the primary fabrication facility for this product family. Links to fab capacity planning, process capability, and supply chain routing.',
    `family_code` STRING COMMENT 'Unique alphanumeric code identifying the product family in external systems and customer communications. Used in PLM, ERP, and CRM systems for product taxonomy navigation.. Valid values are `^[A-Z0-9]{4,12}$`',
    `family_description` STRING COMMENT 'Detailed description of the product family including target applications, key features, and market positioning. Used for technical documentation and sales enablement.',
    `family_name` STRING COMMENT 'Business name of the product family (e.g., Cortex-M Series, Automotive MCU Family, RF Transceiver Family). Used in roadmap planning, marketing materials, and customer design-in targeting.',
    `family_type` STRING COMMENT 'Classification of the product family by semiconductor device type. Aligns with industry standard device categories for design, fabrication, and test planning. [ENUM-REF-CANDIDATE: IC|SoC|ASIC|FPGA|IP_Core|Discrete|Mixed_Signal — 7 candidates stripped; promote to reference product]',
    `hierarchy_level` STRING COMMENT 'Numeric level in the product family hierarchy (1=portfolio, 2=family, 3=sub-family, 4=product, 5=variant). Supports up to five levels of product taxonomy as defined in the product domain.',
    `ip_core_count` STRING COMMENT 'Number of reusable IP cores integrated into products in this family. Indicates design complexity and IP licensing requirements. Used for NRE (Non-Recurring Engineering) cost estimation.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether this product family is subject to ITAR export controls for defense-related technology. Restricts international sales and requires export licensing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product family record was last updated. Used for change tracking and data synchronization across systems.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the product family: Concept (early planning), NPI (New Product Introduction), Active (volume production), Mature (stable production), Phase_Out (declining), EOL (End of Life announced), Discontinued (no longer available). Drives supply chain and customer communication strategies. [ENUM-REF-CANDIDATE: Concept|NPI|Active|Mature|Phase_Out|EOL|Discontinued — 7 candidates stripped; promote to reference product]',
    `lithography_type` STRING COMMENT 'Photolithography technology used for patterning (EUV Extreme Ultraviolet, DUV Deep Ultraviolet). Impacts design complexity, mask costs, and fab capability requirements.. Valid values are `EUV|DUV|Immersion|Dry`',
    `ltb_date` DATE COMMENT 'Final date for customers to place orders before product family is discontinued. Part of EOL process and customer lifecycle management.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this product family record. Used for audit trail and data governance.',
    `npi_start_date` DATE COMMENT 'Date when this product family entered NPI phase. Marks the beginning of qualification, ramp, and early customer shipments. Used for TTM (Time to Market) tracking.',
    `osat_partner` STRING COMMENT 'Name of the OSAT partner responsible for packaging and final test of this product family. Critical for supply chain planning and quality management.',
    `package_type` STRING COMMENT 'Primary packaging technology for this product family (e.g., WLCSP Wafer-Level Chip Scale Package, BGA Ball Grid Array, QFN Quad Flat No-Lead, CoWoS Chip on Wafer on Substrate, InFO Integrated Fan-Out). Defines assembly process and thermal/electrical characteristics.',
    `pdk_version` STRING COMMENT 'Version of the Process Design Kit used for this product family. PDK contains design rules, device models, and technology files required for IC design. Critical for design-to-manufacturing alignment.',
    `product_line_manager` STRING COMMENT 'Name of the product line manager responsible for roadmap, positioning, and lifecycle management of this product family. Business owner for strategic decisions.',
    `qualification_standard` STRING COMMENT 'Industry qualification standard this product family must meet (e.g., AEC-Q100 for automotive, MIL-STD-883 for military, JEDEC JESD47 for stress testing). Defines reliability testing requirements.',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether this product family complies with EU REACH Regulation for chemical substance safety. Required for European market sales and supply chain transparency.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether this product family is designed to comply with EU RoHS Directive restricting hazardous substances in electronic equipment. Critical for European market access.',
    `target_market_segment` STRING COMMENT 'Primary market segment this product family targets. Used for roadmap planning, pricing strategy, and customer design-in targeting. Aligns with business unit structure and go-to-market strategy. [ENUM-REF-CANDIDATE: Computing|Mobile|Automotive|AI_ML|IoT|Industrial|Consumer|Networking|Data_Center — 9 candidates stripped; promote to reference product]',
    `target_performance_metric` STRING COMMENT 'Key performance metric and target value for this product family (e.g., 3.5 GHz clock frequency, 100 TOPS AI performance, 10 Gbps throughput). Used for competitive analysis and roadmap planning.',
    `target_power_mw` DECIMAL(18,2) COMMENT 'Target typical power consumption in milliwatts for this product family. Part of PPA (Power Performance Area) metrics used for competitive positioning and customer design-in evaluation.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target manufacturing yield percentage (good dies per wafer) for this product family at volume production. Used for cost modeling, capacity planning, and fab performance tracking.',
    `typical_die_size_mm2` DECIMAL(18,2) COMMENT 'Representative die size in square millimeters for products in this family. Used for wafer yield modeling, cost estimation, and capacity planning. Actual die sizes may vary by specific product variant.',
    `volume_production_date` DATE COMMENT 'Date when this product family achieved volume production status (Active lifecycle). Indicates full manufacturing qualification and capacity availability.',
    CONSTRAINT pk_family PRIMARY KEY(`family_id`)
) COMMENT 'Hierarchical grouping of related IC products into product families and sub-families (e.g., Cortex-class SoCs, automotive MCU family, RF transceiver family). Manages the multi-level product taxonomy used for roadmap planning, pricing strategy, and customer design-in targeting. Supports up to five levels of hierarchy: portfolio → family → sub-family → product → variant.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`process_node` (
    `process_node_id` BIGINT COMMENT 'Primary key for process_node',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Process node development and maintenance are assigned to R&D/process engineering cost centers for tracking development costs, equipment depreciation, and operational expenses by technology node.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Process nodes are developed and owned by specific legal entities for IP ownership, patent filing, tax treatment of R&D, and transfer pricing in foundry partnerships and inter-company technology licens',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Process node development is a major capital project tracked via WBS for R&D cost capitalization, milestone-based funding, equipment procurement, and PDK development cost allocation.',
    `active_product_count` STRING COMMENT 'Current count of active product SKUs (ICs, SoCs, ASICs, FPGAs) assigned to this process node. Used for capacity planning and node utilization analysis.',
    `baseline_yield_percent` DECIMAL(18,2) COMMENT 'Expected baseline yield percentage (good dies per wafer) for this process node under standard manufacturing conditions. Used for cost modeling and capacity planning. Confidential manufacturing metric.',
    `cost_per_wafer_usd` DECIMAL(18,2) COMMENT 'Standard manufacturing cost per wafer in USD for this process node. Includes FEOL (Front End of Line), MOL (Middle of Line), and BEOL (Back End of Line) processing costs. Confidential financial data used for product costing and NRE (Non-Recurring Engineering) estimation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process node record was first created in the system. Audit trail for data lineage and compliance reporting.',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Standard manufacturing cycle time in days from wafer start to wafer completion for this process node. Includes all FEOL, MOL, and BEOL processing steps. Critical for TTM (Time to Market) planning.',
    `design_rule_complexity` STRING COMMENT 'Qualitative assessment of design rule complexity for DFM (Design for Manufacturability) and DFT (Design for Testability). Higher complexity requires more sophisticated EDA tools and longer design cycles.. Valid values are `Low|Medium|High|Very High`',
    `environmental_compliance_status` STRING COMMENT 'Compliance status with environmental regulations including RoHS (Restriction of Hazardous Substances), REACH (Registration Evaluation Authorization and Restriction of Chemicals), and TSCA (Toxic Substances Control Act). Compliant indicates full adherence; Non-Compliant indicates violations; Under Review indicates pending assessment.. Valid values are `Compliant|Non-Compliant|Under Review`',
    `eol_announcement_date` DATE COMMENT 'Date when EOL (End of Life) was officially announced for this process node via PCN (Product Change Notification). Triggers LTB (Last Time Buy) planning for affected products. Null if node is still active.',
    `export_control_classification` STRING COMMENT 'Export control classification under ITAR (International Traffic in Arms Regulations), EAR (Export Administration Regulations), or BIS (Bureau of Industry and Security) frameworks. Determines international transfer restrictions and CHIPS Act compliance requirements.',
    `foundry_source` STRING COMMENT 'The semiconductor foundry or fabrication facility that provides manufacturing capability for this process node. May be internal FAB or external OSAT (Outsourced Semiconductor Assembly and Test) partner.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this process node record. Tracks data currency and change history for audit and compliance purposes.',
    `lifecycle_stage` STRING COMMENT 'Current lifecycle stage of the process node. NPI (New Product Introduction) indicates initial ramp; Growth indicates volume expansion; Mature indicates stable production; Decline indicates phasing out; EOL (End of Life) indicates discontinued with LTB (Last Time Buy) notifications issued.. Valid values are `NPI|Growth|Mature|Decline|EOL`',
    `lithography_type` STRING COMMENT 'Primary lithography technology used for patterning at this process node. EUV (Extreme Ultraviolet Lithography), DUV (Deep Ultraviolet Lithography), I-Line, G-Line, or Mixed for multi-generation processes.. Valid values are `EUV|DUV|I-Line|G-Line|Mixed`',
    `ltb_deadline_date` DATE COMMENT 'Final date for customers to place orders for products manufactured on this process node before complete discontinuation. Null if node is not in EOL status.',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers available in the BEOL (Back End of Line) stack for this process node. Higher counts enable more complex routing and integration.',
    `minimum_feature_size_nm` DECIMAL(18,2) COMMENT 'The smallest manufacturable feature dimension in nanometers for this process node. Represents the critical dimension capability and defines the nodes resolution limit.',
    `modified_by_user` STRING COMMENT 'User identifier or system account that performed the last modification to this record. Supports audit trail and accountability requirements.',
    `multi_patterning_layers` STRING COMMENT 'Number of critical layers requiring multi-patterning techniques (double, triple, or quad patterning) to achieve target feature sizes. Zero indicates single-exposure capability. Higher counts increase mask costs and cycle time.',
    `node_code` STRING COMMENT 'Standardized alphanumeric code or identifier for the process node used across systems and documentation. Serves as the business key for external references.',
    `node_generation` STRING COMMENT 'The technology generation or family classification (e.g., sub-3nm, 5nm-class, 7nm-class, mature node). Groups nodes by manufacturing era and capability tier.',
    `node_name` STRING COMMENT 'Human-readable name of the semiconductor process technology node (e.g., 3nm GAA, 5nm FinFET, 7nm EUV, 28nm HKMG, 180nm BCD). This is the industry-standard designation for the manufacturing process generation.',
    `notes` STRING COMMENT 'Free-text field for additional technical notes, special considerations, design guidelines, or process-specific information not captured in structured fields. Used by process engineers and design teams.',
    `opc_required_flag` BOOLEAN COMMENT 'Indicates whether OPC (Optical Proximity Correction) is mandatory for mask preparation at this process node. True for advanced nodes where lithography effects require computational correction.',
    `pdk_release_date` DATE COMMENT 'Date when the current PDK version was officially released and made available to design teams. Tracks PDK maturity and design enablement timeline.',
    `pdk_version` STRING COMMENT 'Version identifier of the PDK (Process Design Kit) that defines design rules, device models, and technology files for EDA (Electronic Design Automation) tools. Critical for DFM (Design for Manufacturability) compliance.',
    `power_performance_area_rating` STRING COMMENT 'Qualitative assessment of the process nodes PPA (Power Performance Area) characteristics relative to industry benchmarks. Excellent indicates best-in-class metrics; Limited indicates mature node with constrained PPA.. Valid values are `Excellent|Good|Fair|Limited`',
    `qualification_date` DATE COMMENT 'Date when the process node achieved full production qualification status and was approved for volume manufacturing. Null if not yet qualified.',
    `qualification_status` STRING COMMENT 'Current qualification and readiness state of the process node for production use. Qualified indicates full production readiness; In Qualification indicates active validation; Pre-Production indicates pilot runs; Development indicates early-stage R&D; Deprecated indicates phasing out; Obsolete indicates end-of-life.. Valid values are `Qualified|In Qualification|Pre-Production|Development|Deprecated|Obsolete`',
    `supported_device_types` STRING COMMENT 'Comma-separated list of device types and IP (Intellectual Property Core) categories supported by this process node (e.g., Logic, SRAM, Analog, RF, High-Voltage, IO). Defines the breadth of design capabilities.',
    `technology_readiness_level` STRING COMMENT 'TRL score from 1 (basic research) to 9 (full production deployment) indicating the maturity of the process node technology. Used for R&D planning and risk assessment.',
    `transistor_architecture` STRING COMMENT 'The fundamental transistor structure used in this process node. GAA (Gate All Around), FinFET (Fin Field-Effect Transistor), Planar, FDSOI (Fully Depleted Silicon On Insulator), or Other specialized architectures.. Valid values are `GAA|FinFET|Planar|FDSOI|Other`',
    `wafer_size_mm` STRING COMMENT 'Standard wafer diameter in millimeters supported by this process node (e.g., 300mm, 200mm, 150mm). Determines die count per wafer and manufacturing economics.',
    CONSTRAINT pk_process_node PRIMARY KEY(`process_node_id`)
) COMMENT 'Reference master for semiconductor process technology nodes (e.g., 3nm GAA, 5nm FinFET, 7nm EUV, 28nm HKMG, 180nm BCD). Captures node name, lithography generation (EUV/DUV), foundry source, PDK version, minimum feature size, metal layer count, and qualification status. Used to assign products to manufacturing process capabilities and to track node-level yield and cost baselines.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`product_spec` (
    `product_spec_id` BIGINT COMMENT 'Unique identifier for the product specification record. Primary key.',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the parent product (IC, SoC, ASIC, FPGA, IP core, or discrete device) for which this specification applies.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Product specifications are inherently tied to a specific process node — PPA (Power-Performance-Area) metrics are only meaningful in the context of the process technology used. product_spec.process_nod',
    `product_ic_catalog_id` BIGINT COMMENT 'FK to product.ic_catalog.ic_catalog_id — Product specifications describe a specific IC product. Must reference the catalog entry.',
    `approval_date` DATE COMMENT 'Date when this specification was formally approved for release to manufacturing or customers.',
    `approved_by` STRING COMMENT 'Name or identifier of the engineering authority who approved this specification for release.',
    `automotive_grade` STRING COMMENT 'AEC-Q100 automotive qualification grade indicating temperature range and reliability requirements (Grade 0: -40°C to 150°C, Grade 1: -40°C to 125°C, Grade 2: -40°C to 105°C, Grade 3: -40°C to 85°C).. Valid values are `none|aec_q100_grade_0|aec_q100_grade_1|aec_q100_grade_2|aec_q100_grade_3`',
    `characterization_date` DATE COMMENT 'Date when this specification was characterized and validated through silicon testing or simulation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product specification record was first created in the system.',
    `data_retention_years` STRING COMMENT 'Guaranteed data retention period in years for non-volatile memory components at specified temperature.',
    `die_area_achieved_mm2` DECIMAL(18,2) COMMENT 'Actual measured silicon die area in square millimeters (mm²) from physical layout. Part of PPA (Power-Performance-Area) metrics.',
    `die_area_target_mm2` DECIMAL(18,2) COMMENT 'Target silicon die area in square millimeters (mm²). Part of PPA (Power-Performance-Area) metrics.',
    `dynamic_power_achieved_mw` DECIMAL(18,2) COMMENT 'Actual measured or characterized dynamic power consumption in milliwatts (mW) during active switching operation at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `dynamic_power_target_mw` DECIMAL(18,2) COMMENT 'Target dynamic power consumption in milliwatts (mW) during active switching operation at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `endurance_cycles` BIGINT COMMENT 'Number of program/erase cycles guaranteed for non-volatile memory components (applicable to flash, EEPROM).',
    `esd_protection_level_kv` DECIMAL(18,2) COMMENT 'Electrostatic discharge protection rating in kilovolts (kV) per JEDEC standards (e.g., HBM, CDM models).',
    `functional_safety_rating` STRING COMMENT 'Functional safety certification level achieved by the product. ISO 26262 ASIL (Automotive Safety Integrity Level) A through D for automotive applications; IEC 61508 SIL (Safety Integrity Level) 1 through 4 for industrial applications. [ENUM-REF-CANDIDATE: none|iso_26262_asil_a|iso_26262_asil_b|iso_26262_asil_c|iso_26262_asil_d|iec_61508_sil_1|iec_61508_sil_2|iec_61508_sil_3|iec_61508_sil_4 — 9 candidates stripped; promote to reference product]',
    `gate_count` BIGINT COMMENT 'Total number of logic gates (or gate equivalents) in the design, representing design complexity.',
    `interface_protocols` STRING COMMENT 'Comma-separated list of supported communication interface protocols (e.g., PCIe, USB, DDR4, MIPI, SPI, I2C, CAN, Ethernet).',
    `io_count` STRING COMMENT 'Total number of input/output pins or pads available on the integrated circuit for signal connectivity.',
    `leakage_power_achieved_mw` DECIMAL(18,2) COMMENT 'Actual measured or characterized static leakage power consumption in milliwatts (mW) when the circuit is idle at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `leakage_power_target_mw` DECIMAL(18,2) COMMENT 'Target static leakage power consumption in milliwatts (mW) when the circuit is idle at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `max_frequency_achieved_mhz` DECIMAL(18,2) COMMENT 'Actual measured or characterized maximum operating frequency in megahertz (MHz) at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `max_frequency_target_mhz` DECIMAL(18,2) COMMENT 'Target maximum operating frequency in megahertz (MHz) at nominal conditions. Part of PPA (Power-Performance-Area) metrics.',
    `memory_configuration` STRING COMMENT 'Description of on-chip memory architecture including SRAM, cache, ROM, and embedded flash sizes and organization (e.g., 256KB L2 Cache, 2MB SRAM, 512KB ROM).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product specification record was last modified.',
    `notes` STRING COMMENT 'Additional notes, caveats, or clarifications regarding this product specification, including test conditions, measurement methodology, or known limitations.',
    `operating_condition_corner` STRING COMMENT 'Process-voltage-temperature (PVT) corner at which this specification is characterized. Typical represents nominal conditions; best/worst case represent performance extremes; slow/fast combinations represent process variation corners. [ENUM-REF-CANDIDATE: typical|best_case|worst_case|slow_slow|fast_fast|slow_fast|fast_slow — 7 candidates stripped; promote to reference product]',
    `operating_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum junction temperature in degrees Celsius at which the product is guaranteed to function within specification.',
    `operating_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum junction temperature in degrees Celsius at which the product is guaranteed to function within specification.',
    `operating_voltage_max_v` DECIMAL(18,2) COMMENT 'Maximum operating voltage in volts (V) at which the product is guaranteed to function within specification.',
    `operating_voltage_min_v` DECIMAL(18,2) COMMENT 'Minimum operating voltage in volts (V) at which the product is guaranteed to function within specification.',
    `operating_voltage_nominal_v` DECIMAL(18,2) COMMENT 'Nominal (typical) operating voltage in volts (V) for standard operation.',
    `package_type` STRING COMMENT 'Semiconductor package type and form factor (e.g., BGA, QFN, WLCSP, LGA, SOIC, DIP, CoWoS, InFO).',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the product meets EU REACH regulation requirements for chemical substance registration and restriction.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the product meets EU RoHS directive requirements for restriction of hazardous substances (lead, mercury, cadmium, etc.).',
    `security_features` STRING COMMENT 'Comma-separated list of implemented hardware security features (e.g., Secure Boot, TrustZone, AES-256, SHA-256, Hardware Root of Trust, Anti-Tamper).',
    `spec_status` STRING COMMENT 'Current lifecycle status of this product specification (Draft: under development, Preliminary: pre-silicon or early silicon, Final: production-qualified, Obsolete: superseded by newer version).. Valid values are `draft|preliminary|final|obsolete`',
    `transistor_architecture` STRING COMMENT 'Type of transistor structure used in the process technology (Planar, FinFET, GAA - Gate All Around, Nanosheet, Nanowire).. Valid values are `planar|finfet|gaa|nanosheet|nanowire`',
    `transistor_count` BIGINT COMMENT 'Total number of transistors in the integrated circuit design.',
    `version` STRING COMMENT 'Version number of this product specification, following semantic versioning (e.g., 1.0, 2.1, 3.0.1). Incremented with each specification revision.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_product_spec PRIMARY KEY(`product_spec_id`)
) COMMENT 'Detailed electrical, functional, and PPA (Power-Performance-Area) specifications for each IC product at given operating condition corners. Covers operating voltage range, temperature range, I/O count, interface protocols, memory configuration, security features, functional safety ratings (ISO 26262 ASIL, IEC 61508 SIL), plus target and achieved values for dynamic power, leakage power, maximum frequency, and die area. Supports multi-corner characterization and competitive PPA benchmarking.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`bom` (
    `bom_id` BIGINT COMMENT 'Unique identifier for the bill of materials header record. Primary key for the BOM entity.',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the parent IC product or assembly that this BOM defines. Links to the product master catalog.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Assembled BOMs require aggregate ECCN determination per EAR 734.4 for export classification. BOM-level ECCN drives license requirements, de minimis calculations, and determines if assembly changes cla',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Manufacturing execution links each BOM to an internal order for cost capture and settlement.',
    `pcn_id` BIGINT COMMENT 'Foreign key linking to product.pcn. Business justification: bom.pcn_number (STRING) is a denormalized reference to the PCN that triggered or is associated with this BOM revision. Normalizing this to bom.pcn_id → pcn.pcn_id enables proper relational traceabilit',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: BOMs represent specific product configurations sold to customers; profit center assignment enables product-line P&L reporting, margin analysis by configuration, and transfer pricing for inter-company ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: BOMs often designate a contract manufacturer or primary supplier for the overall assembly, needed for production planning.',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to product.ic_catalog.ic_catalog_id — Each BOM defines the component structure of a specific IC product. The BOM header must reference the product it describes.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: BOMs are developed under NPI project WBS elements for tracking engineering costs, prototype builds, and capitalization decisions; links product structure to project cost accounting.',
    `approval_date` DATE COMMENT 'Date when this BOM was formally approved for use. Marks the transition from draft/review to approved status.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The quantity of the parent product that this BOM defines. Typically 1 for single-unit BOMs, but may be higher for batch or lot-based manufacturing. All component quantities in BOM lines are relative to this base quantity.',
    `base_unit_of_measure` STRING COMMENT 'Unit of measure for the base quantity, such as EA (each), LOT, WAFER, or other semiconductor-specific units. Must align with product master UOM.',
    `bom_number` STRING COMMENT 'Business identifier for the BOM, typically a human-readable code used across PLM and ERP systems for tracking and reference.',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM. Draft indicates work in progress, in_review indicates pending approval, approved indicates ready for use, active indicates currently in production, frozen indicates locked for manufacturing, obsolete indicates no longer valid, superseded indicates replaced by newer revision. [ENUM-REF-CANDIDATE: draft|in_review|approved|active|frozen|obsolete|superseded — 7 candidates stripped; promote to reference product]',
    `bom_type` STRING COMMENT 'Classification of the BOM by its intended use: engineering BOM (EBOM) for design, manufacturing BOM (MBOM) for production, service BOM for maintenance, planning BOM for forecasting, as-designed for original specification, or as-built for actual production configuration.. Valid values are `engineering|manufacturing|service|planning|as_designed|as_built`',
    `conflict_minerals_compliant_flag` BOOLEAN COMMENT 'Indicates whether the BOM and all its components are free from conflict minerals (tin, tantalum, tungsten, gold) sourced from conflict regions, per Dodd-Frank Act Section 1502 requirements.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the total material cost. Typically USD for semiconductor industry but may vary by region.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `critical_material_flag` BOOLEAN COMMENT 'Indicates whether this BOM contains components classified as critical materials (long lead time, single source, strategic importance). Used for supply chain risk management.',
    `effective_end_date` DATE COMMENT 'Date after which this BOM revision is no longer valid for new production orders. Null indicates the BOM is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this BOM revision becomes valid and can be used for manufacturing, procurement, and costing. Critical for managing engineering changes and product transitions.',
    `engineering_change_order_number` STRING COMMENT 'Reference to the engineering change order that created or last modified this BOM revision. Critical for change traceability and audit compliance.',
    `eol_date` DATE COMMENT 'Planned or actual end-of-life date for this BOM. After this date, the product is no longer manufactured or supported.',
    `explosion_type` STRING COMMENT 'Defines how the BOM should be exploded for planning and costing: single-level shows only immediate children, multi-level shows full hierarchy, summarized shows consolidated component totals.. Valid values are `single_level|multi_level|summarized`',
    `external_bom_reference` STRING COMMENT 'Original BOM identifier from the source PLM or ERP system. Maintains traceability to upstream systems and enables cross-system reconciliation.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether this BOM contains components or technology subject to ITAR export control regulations. Critical for defense and aerospace semiconductor applications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOM record was last updated. Tracks the most recent change for change management and audit purposes.',
    `lot_size` DECIMAL(18,2) COMMENT 'Standard production lot size for which this BOM is optimized. Used in material requirements planning (MRP) and capacity planning calculations.',
    `ltb_notification_date` DATE COMMENT 'Date when Last Time Buy notification was issued for this BOM, indicating the product is approaching end-of-life and customers should place final orders.',
    `plant_code` STRING COMMENT 'Manufacturing plant or fabrication facility (FAB) where this BOM is applicable. Different plants may have different BOMs for the same product due to process variations or equipment differences.',
    `production_version` STRING COMMENT 'Production version identifier linking this BOM to a specific routing or process flow. Enables coordination between BOM and manufacturing process definitions.',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether the BOM and all its components meet REACH regulation requirements for chemical substance registration and safety. Rolled up from component-level compliance data.',
    `revision` STRING COMMENT 'Revision level or version of the BOM, incremented with each engineering change. Critical for change management and traceability.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the BOM and all its components meet RoHS directive requirements for restriction of hazardous substances. Rolled up from component-level compliance data.',
    `scrap_percentage` DECIMAL(18,2) COMMENT 'Expected scrap or yield loss percentage at the BOM level. Used to adjust material requirements and costing. Typical semiconductor yield losses are factored here.',
    `source_system` STRING COMMENT 'Identifier of the source system from which this BOM was ingested (e.g., Teamcenter, Agile PLM, SAP). Used for data lineage and integration troubleshooting.',
    `total_component_count` STRING COMMENT 'Total number of distinct component line items in this BOM. Provides quick visibility into BOM complexity without querying detail records.',
    `total_material_cost` DECIMAL(18,2) COMMENT 'Rolled-up total material cost for all components in this BOM, calculated from component costs and quantities. Used for product costing and margin analysis.',
    `usage` STRING COMMENT 'Intended usage context for this BOM: production for manufacturing execution, costing for financial analysis, engineering for design reference, maintenance for service operations, or sales for customer quotations.. Valid values are `production|costing|engineering|maintenance|sales`',
    CONSTRAINT pk_bom PRIMARY KEY(`bom_id`)
) COMMENT 'Bill of Materials header records defining the hierarchical component structure of each IC product assembly. Captures BOM revision, effectivity dates, BOM type (engineering, manufacturing, service), approval status, and overall RoHS/REACH compliance rollup. Parent entity for bom_line detail records. Integrates with PLM and ERP systems for manufacturing execution and change management.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Unique identifier for the BOM line item. Primary key for the BOM line entity.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: BOM line items in semiconductor design frequently reference other ICs from the product catalog as sub-components (e.g., a SoC BOM may include memory ICs, power management ICs, or interface chips from ',
    `parent_line_bom_line_id` BIGINT COMMENT 'Reference to the parent BOM line in a multi-level BOM structure. Null for top-level components. Enables recursive BOM explosion and indented BOM reports.',
    `bom_id` BIGINT COMMENT 'Reference to the parent BOM header that this line belongs to. Links the line item to the overall product BOM structure.',
    `supplier_id` BIGINT COMMENT 'Reference to the primary supplier or vendor for this component. Links to supplier master data for procurement and supply chain management.',
    `to_bom_id` BIGINT COMMENT 'FK to product.bom.bom_id — Classic header-line relationship. BOM lines are meaningless without their parent BOM header.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this BOM line is currently active and should be used in production planning and costing. Inactive lines are retained for historical reference but excluded from current operations.',
    `approved_substitute_part_numbers` STRING COMMENT 'Comma-separated list of approved alternate or substitute part numbers that can be used in place of the primary component. Supports supply chain flexibility and risk mitigation.',
    `assembly_process_code` STRING COMMENT 'Code identifying the assembly or packaging process used to integrate this component (e.g., wirebond, flip-chip, CoWoS, InFO). Links to process routing and manufacturing execution.',
    `bom_level` STRING COMMENT 'The hierarchical level of this component in the multi-level BOM structure. Level 0 is the finished product, level 1 is direct sub-assembly, level 2 is sub-component of level 1, and so on. Supports BOM explosion for cost rollup and supply chain analysis.',
    `component_description` STRING COMMENT 'Detailed textual description of the component, including technical specifications, material properties, and functional purpose within the assembly.',
    `component_part_number` STRING COMMENT 'The unique part number or SKU of the component material used in this BOM line. May reference die, package substrate, passive components, interposer, or other materials.',
    `component_type` STRING COMMENT 'Classification of the component by its functional role in the semiconductor assembly. Includes die (silicon chip), package substrate, passive components (resistors, capacitors), interposer, leadframe, wirebond, solder ball, underfill material, and mold compound. [ENUM-REF-CANDIDATE: die|package_substrate|passive|interposer|leadframe|wirebond|solder_ball|underfill|mold_compound — 9 candidates stripped; promote to reference product]',
    `conflict_minerals_status` STRING COMMENT 'Compliance status for conflict minerals (tin, tantalum, tungsten, gold) sourcing per Dodd-Frank Act Section 1502. Tracks whether component supply chain is free from conflict region sourcing.. Valid values are `compliant|non_compliant|under_review|not_applicable`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard cost. Supports multi-currency costing and global supply chain operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_component_flag` BOOLEAN COMMENT 'Indicates whether this component is critical to product functionality, quality, or supply chain continuity. Used for risk assessment and inventory planning.',
    `ear_eccn_code` STRING COMMENT 'The ECCN code assigned under US Export Administration Regulations, classifying the component for export control purposes. Required for international trade compliance.',
    `effectivity_end_date` DATE COMMENT 'The date on which this BOM line becomes obsolete or is replaced. Null for currently active components. Supports phase-in/phase-out scenarios and Product Change Notification (PCN) tracking.',
    `effectivity_start_date` DATE COMMENT 'The date from which this BOM line becomes effective. Supports date-based BOM versioning and engineering change management.',
    `engineering_change_order_number` STRING COMMENT 'The ECO number that introduced or last modified this BOM line. Provides traceability to engineering change management processes.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether the component is subject to ITAR export controls for defense-related articles and services. Critical for aerospace and defense semiconductor applications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line record was last updated. Supports change tracking and audit trail.',
    `line_number` STRING COMMENT 'Sequential line number within the parent BOM, used for ordering and referencing specific components in the assembly hierarchy.',
    `make_or_buy_indicator` STRING COMMENT 'Indicates whether the component is manufactured in-house (make), procured externally (buy), or transferred from another plant (transfer). Drives procurement and production planning logic.. Valid values are `make|buy|transfer`',
    `manufacturer_name` STRING COMMENT 'The name of the original equipment manufacturer (OEM) or component manufacturer. May differ from the supplier if purchased through distributors.',
    `manufacturer_part_number` STRING COMMENT 'The manufacturers original part number for the component. Used for cross-referencing and supplier communication.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, assembly instructions, quality requirements, or special handling instructions for this BOM line.',
    `phantom_bom_flag` BOOLEAN COMMENT 'Indicates whether this is a phantom or transient sub-assembly that is not stocked or tracked as inventory. Phantom BOMs are exploded through during MRP but not manufactured as discrete items.',
    `procurement_lead_time_days` STRING COMMENT 'The typical lead time in days required to procure this component from suppliers. Used for material requirements planning (MRP) and supply chain risk analysis.',
    `quantity_per_assembly` DECIMAL(18,2) COMMENT 'The quantity of this component required to produce one unit of the parent assembly. Supports fractional quantities for materials measured by weight or volume.',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether the component complies with EU REACH Regulation for chemical substance registration and safety. Required for European market access.',
    `reference_designator` STRING COMMENT 'The reference designator or location identifier for the component on the physical layout or assembly drawing (e.g., U1, C23, R45). Links BOM to physical design.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the component complies with EU RoHS Directive restricting hazardous substances (lead, mercury, cadmium, hexavalent chromium, PBB, PBDE). Critical for regulatory compliance and market access.',
    `scrap_factor_percent` DECIMAL(18,2) COMMENT 'Expected scrap or yield loss percentage for this component during manufacturing. Used to calculate net material requirements accounting for process losses.',
    `single_source_flag` BOOLEAN COMMENT 'Indicates whether this component is available from only one supplier, representing a supply chain risk. Triggers dual-sourcing initiatives and risk mitigation strategies.',
    `standard_cost` DECIMAL(18,2) COMMENT 'The standard unit cost of the component in the base currency. Used for BOM cost rollup, product costing, and margin analysis.',
    `unit_of_measure` STRING COMMENT 'The unit in which the component quantity is expressed. Common values include EA (each), KG (kilogram), G (gram), L (liter), ML (milliliter), M (meter), MM (millimeter), WAFER, DIE. [ENUM-REF-CANDIDATE: EA|KG|G|L|ML|M|MM|WAFER|DIE — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'Line items within a product BOM, each representing a component or sub-assembly. Captures component part number, quantity per assembly, UoM, component type (die, package substrate, passive, interposer), approved substitutes, lead time, and compliance attributes (RoHS, REACH, conflict minerals). Supports multi-level BOM explosion for cost rollup and supply chain risk analysis.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`pcn` (
    `pcn_id` BIGINT COMMENT 'Unique identifier for the product change notification record. Primary key.',
    `product_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_spec. Business justification: Product Change Notifications document changes to product specifications. Linking pcn.affected_product_spec_id → product_spec.product_spec_id establishes a direct traceability path from a PCN to the sp',
    `change_notification_id` BIGINT COMMENT 'Unique identifier from Oracle Agile PLM system linking this PCN to the formal engineering change order (ECO) or manufacturing change order (MCO) that implements the change.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PCN implementation costs (re-qualification testing, documentation, customer notification, samples) are tracked to engineering cost centers for budgeting and variance analysis of change management acti',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: PCNs affecting controlled products may trigger export license amendments or new license applications when changes alter technical parameters, manufacturing location, or ECCN classification. Required f',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: pcn records are change notifications for specific IC products; linking pcn to ic_catalog provides parent relationship and enables traceability.',
    `product_qualification_program_id` BIGINT COMMENT 'Foreign key linking to product.product_qualification_program. Business justification: PCNs that involve material, process, or specification changes typically require a re-qualification program before the change becomes effective. pcn.qualification_plan (STRING) and qualification_status',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to product.ic_catalog.ic_catalog_id — Product Change Notifications affect specific products. Must reference the affected catalog entry (may be multi-valued via junction).',
    `affected_customer_count` STRING COMMENT 'Total number of customers who have active orders, design-ins, or inventory of the affected products and must be notified of the change.',
    `affected_product_list` STRING COMMENT 'Comma-separated or structured list of product SKUs, part numbers, or device families impacted by this change. May reference specific die revisions, package codes, or product lines.',
    `approval_date` DATE COMMENT 'Date when the PCN received final internal approval from engineering, quality, and business stakeholders to proceed with customer notification and implementation.',
    `approved_by_name` STRING COMMENT 'Name of the executive or manager who provided final approval for the PCN, typically a VP of Engineering, Quality Director, or Product Line Manager.',
    `automotive_qualification_required_flag` BOOLEAN COMMENT 'Indicates whether the change requires re-qualification under automotive quality standards such as IATF 16949 or AEC-Q100/Q200, applicable when affected products are used in automotive applications.',
    `change_category` STRING COMMENT 'Severity classification of the change: major (requires customer qualification), minor (limited impact, may require notification), or notification_only (informational, no action required).. Valid values are `major|minor|notification_only`',
    `change_description` STRING COMMENT 'Detailed technical description of the product change, including what is being modified, the scope of the change, and technical specifications affected.',
    `change_owner_email` STRING COMMENT 'Email address of the change owner for customer inquiries and internal coordination regarding the PCN.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `change_owner_name` STRING COMMENT 'Name of the engineer, product manager, or business owner responsible for driving the PCN through approval, customer notification, and implementation.',
    `change_rationale` STRING COMMENT 'Business and technical justification for the change, including reasons such as cost reduction, yield improvement, supply chain continuity, obsolescence mitigation, or performance enhancement.',
    `change_title` STRING COMMENT 'Brief descriptive title summarizing the nature of the product change for quick identification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PCN record was first created in the system, marking the initiation of the change notification process.',
    `customer_approval_count` STRING COMMENT 'Number of customers who explicitly approved or acknowledged acceptance of the proposed change.',
    `customer_approval_required_flag` BOOLEAN COMMENT 'Indicates whether explicit customer approval or acknowledgment is required before implementing the change, typically true for major changes affecting form, fit, or function.',
    `customer_objection_count` STRING COMMENT 'Number of customers who formally objected to or raised concerns about the proposed change during the notification period.',
    `customer_response_deadline` DATE COMMENT 'Date by which customers must provide feedback, objections, or approval for the proposed change. After this date, silence may be interpreted as acceptance per JEDEC guidelines.',
    `effective_date` DATE COMMENT 'Date when the product change will be implemented in production and new product shipments will reflect the change. Typically allows customer qualification time after notification.',
    `electrical_impact_assessment` STRING COMMENT 'Engineering assessment of how the change affects electrical characteristics such as timing, power consumption, signal integrity, or parametric specifications.',
    `environmental_compliance_impact` STRING COMMENT 'Assessment of whether the change affects environmental compliance status, including RoHS, REACH, halogen-free, or conflict minerals declarations.',
    `form_fit_function_impact` STRING COMMENT 'Classification of whether the change affects form (physical dimensions/appearance), fit (mechanical interchangeability), function (electrical/performance characteristics), multiple aspects, or none. Critical for customer qualification scope determination.. Valid values are `none|form|fit|function|multiple`',
    `implementation_date` DATE COMMENT 'Actual date when the product change was implemented in production and new shipments began reflecting the change. May differ from planned effective_date.',
    `jedec_compliance_status` STRING COMMENT 'Indicates whether the PCN process and content comply with JEDEC JESD46 standard requirements for product change notification in the semiconductor industry.. Valid values are `compliant|non_compliant|not_applicable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the PCN record, tracking changes to status, dates, or other attributes throughout the PCN lifecycle.',
    `last_ship_date` DATE COMMENT 'Final date by which product manufactured under the old specification will be shipped to customers. Marks the end of old-spec product availability.',
    `last_time_buy_date` DATE COMMENT 'Final date by which customers can place orders for product manufactured under the old specification before the change takes effect. Applicable for major changes requiring customer transition planning.',
    `new_specification` STRING COMMENT 'Technical specification, process parameters, material composition, or design revision identifier for the product after the change. Defines the target state.',
    `notification_date` DATE COMMENT 'Date when the PCN was officially communicated to affected customers, typically via email, customer portal, or formal letter.',
    `old_specification` STRING COMMENT 'Technical specification, process parameters, material composition, or design revision identifier for the product before the change. Provides baseline for comparison.',
    `pcn_number` STRING COMMENT 'Externally-known unique business identifier for the PCN, typically formatted as PCN-YYYYNNNN. Used for customer communication and tracking.. Valid values are `^PCN-[0-9]{6,10}$`',
    `pcn_status` STRING COMMENT 'Current lifecycle state of the PCN: draft (being prepared), pending_approval (awaiting internal review), approved (ready for customer notification), customer_notification_sent (communicated to affected customers), in_qualification (customers testing), implemented (change is live in production), cancelled (change abandoned), or superseded (replaced by newer PCN). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|customer_notification_sent|in_qualification|implemented|cancelled|superseded — 8 candidates stripped; promote to reference product]',
    `pcn_type` STRING COMMENT 'Classification of the change being notified: process change (fab process modification), material change (substrate or compound change), package change (assembly or form factor), test change (ATE or test flow), design change (die revision), or specification change (datasheet update).. Valid values are `process|material|package|test|design|specification`',
    `qualification_completion_date` DATE COMMENT 'Date when internal qualification testing was successfully completed and the change was validated for production release.',
    `qualification_plan` STRING COMMENT 'Description of the testing and validation activities required to qualify the changed product, including reliability tests, electrical characterization, and compatibility verification per JEDEC standards.',
    `qualification_status` STRING COMMENT 'Current state of internal qualification testing for the changed product: not_started, in_progress, completed (passed all tests), failed (did not meet criteria), or waived (qualification not required for this change category).. Valid values are `not_started|in_progress|completed|failed|waived`',
    `reliability_impact_assessment` STRING COMMENT 'Engineering assessment of how the change affects product reliability, including MTBF, failure modes, stress test results, and long-term performance predictions.',
    `sample_request_deadline` DATE COMMENT 'Last date by which customers can request evaluation samples of the changed product for their own qualification testing.',
    `samples_available_flag` BOOLEAN COMMENT 'Indicates whether product samples manufactured with the new change are available for customer evaluation and qualification testing.',
    `superseded_by_pcn_number` STRING COMMENT 'PCN number that replaces or supersedes this PCN, used when a newer change notification obsoletes or modifies a previous one.. Valid values are `^PCN-[0-9]{6,10}$`',
    CONSTRAINT pk_pcn PRIMARY KEY(`pcn_id`)
) COMMENT 'Product Change Notification records documenting all planned changes to product specifications, materials, manufacturing processes, or package configurations. Captures PCN number, change type (process, material, package, test), affected SKUs, change rationale, qualification plan, customer notification list, JEDEC JESD46 compliance status, and implementation timeline. Integrates with Oracle Agile PLM change management workflow.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`ltb_notification` (
    `ltb_notification_id` BIGINT COMMENT 'Unique identifier for the Last Time Buy notification record. Primary key for the product LTB notification entity.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Last-Time-Buy notifications must include current ECCN classification so customers can assess export compliance impact of product discontinuance and plan for replacement part licensing. Critical for de',
    `pcn_id` BIGINT COMMENT 'Foreign key linking to product.pcn. Business justification: Last Time Buy notifications are typically issued in conjunction with or following a PCN that announces EOL. product_ltb_notification.pcn_number (STRING) is a denormalized reference to the associated P',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the recommended replacement product in the product catalog. Identifies the form-fit-function equivalent or next-generation product that customers should transition to. May be null if no direct replacement exists.',
    `actual_ltb_revenue` DECIMAL(18,2) COMMENT 'Actual revenue realized from LTB orders. Captured after the final order date to measure forecast accuracy and assess the financial impact of the product discontinuance.',
    `actual_ltb_units` STRING COMMENT 'Actual unit volume of LTB orders received. Captured after the final order date to measure demand forecast accuracy and assess inventory disposition requirements.',
    `approved_by` STRING COMMENT 'Name or identifier of the business authority who approved the LTB notification for issuance. Typically a product line manager, business unit director, or discontinuance review board representative.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the LTB notification was approved for issuance. Establishes the audit trail for discontinuance governance and compliance with internal approval processes.',
    `cancellation_reason` STRING COMMENT 'Explanation of why the LTB notification was cancelled. Provides business context for discontinuance reversals, such as renewed customer demand, supply chain recovery, or strategic product portfolio changes.',
    `cancelled_by` STRING COMMENT 'Name or identifier of the business authority who cancelled the LTB notification. Populated only if the notification is cancelled before completion, typically due to business strategy changes or supply chain recovery.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the LTB notification was cancelled. Establishes the audit trail for notification lifecycle changes and supports customer communication of discontinuance reversals.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the LTB notification record was first created in the system. Establishes the audit trail for notification lifecycle and supports compliance with record retention requirements.',
    `customer_acknowledgment_deadline` DATE COMMENT 'Date by which customers must acknowledge the LTB notification if acknowledgment is required. Ensures timely customer response and enables proactive follow-up for non-responsive accounts.',
    `customer_acknowledgment_required` BOOLEAN COMMENT 'Indicates whether customers are required to formally acknowledge receipt and understanding of the LTB notification. True for high-value or strategic customers; false for standard commercial notifications.',
    `discontinuance_reason_code` STRING COMMENT 'Primary business reason for product discontinuance and LTB issuance. Categorizes the strategic, operational, or compliance driver behind the End of Life (EOL) decision.. Valid values are `eol_lifecycle|low_demand|technology_obsolescence|supply_constraint|regulatory_compliance|cost_optimization`',
    `discontinuance_reason_description` STRING COMMENT 'Detailed explanation of the business rationale for product discontinuance. Provides context for customers and internal stakeholders on the strategic or operational factors driving the EOL decision.',
    `estimated_ltb_revenue` DECIMAL(18,2) COMMENT 'Projected revenue from LTB orders during the notification period. Used for financial planning, production capacity allocation, and business impact assessment of the product discontinuance.',
    `estimated_ltb_units` STRING COMMENT 'Projected unit volume of LTB orders. Used for production planning, wafer start authorization, and supply chain capacity allocation during the LTB period.',
    `final_order_date` DATE COMMENT 'Last date on which customers may place orders for the discontinued product. After this date, no new orders will be accepted. Critical milestone for customers planning bridge inventory or transitioning to replacement products.',
    `final_shipment_date` DATE COMMENT 'Last date on which the discontinued product will be shipped to customers. Represents the absolute end of product availability and marks the transition to replacement product or alternative sourcing.',
    `issued_by` STRING COMMENT 'Name or identifier of the individual who issued the LTB notification to customers. Typically a product marketing manager, customer communications specialist, or PCN coordinator.',
    `issued_timestamp` TIMESTAMP COMMENT 'Date and time when the LTB notification was issued to customers. Marks the official start of the notification period and triggers customer acknowledgment and ordering timelines.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the LTB notification record was last updated. Tracks the most recent change to the notification and supports audit trail requirements for data lineage and compliance.',
    `maximum_order_quantity` STRING COMMENT 'Maximum quantity that may be ordered during the LTB period. Caps total available inventory to prevent over-commitment and ensure fair allocation across customer base.',
    `minimum_order_quantity` STRING COMMENT 'Minimum quantity that must be ordered during the LTB period. Ensures economically viable production runs for discontinued products and helps customers plan bridge inventory requirements.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special instructions, or customer-specific considerations related to the LTB notification. Supports operational flexibility and captures information not covered by structured fields.',
    `notification_channel` STRING COMMENT 'Primary communication channel used to deliver the LTB notification to customers. Tracks the method of notification delivery for compliance and audit purposes.. Valid values are `email|portal|direct_mail|sales_rep|distributor`',
    `notification_issue_date` DATE COMMENT 'Date when the LTB notification was formally issued to customers. Marks the start of the official notification period and triggers customer acknowledgment requirements per JEDEC JESD48 standard.',
    `notification_language` STRING COMMENT 'Primary language in which the LTB notification was issued. Supports multi-lingual customer communication requirements and regulatory compliance in international markets.. Valid values are `ENG|CHN|JPN|KOR|GER|FRE`',
    `notification_number` STRING COMMENT 'Business identifier for the LTB notification. Externally communicated reference number used in customer correspondence and Product Change Notifications (PCN).. Valid values are `^LTB-[0-9]{6,10}$`',
    `notification_status` STRING COMMENT 'Current lifecycle status of the LTB notification. Tracks progression from draft through issuance, customer acknowledgment, and final expiration or cancellation.. Valid values are `draft|issued|acknowledged|expired|cancelled|superseded`',
    `notification_type` STRING COMMENT 'Classification of the LTB notification based on timeline and business circumstances. Standard LTB follows normal discontinuance timelines; expedited LTB has shortened notice periods; extended LTB provides longer lead times; emergency discontinuance addresses immediate supply chain or compliance issues.. Valid values are `standard_ltb|expedited_ltb|extended_ltb|emergency_discontinuance`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether the product discontinuance requires regulatory approval or notification in specific jurisdictions. True for products subject to ITAR, EAR, or industry-specific regulations; false for standard commercial products.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval for the product discontinuance. Tracks compliance with export control, defense, or industry-specific regulations that govern product lifecycle changes.. Valid values are `not_required|pending|approved|denied`',
    `replacement_product_qualification_required` BOOLEAN COMMENT 'Indicates whether the replacement product requires customer qualification and design-in activities. True if the replacement is not a drop-in substitute and requires engineering validation; false if it is form-fit-function compatible.',
    `total_customers_acknowledged` STRING COMMENT 'Count of customers who have formally acknowledged the LTB notification. Enables tracking of acknowledgment completion rate and identification of customers requiring follow-up.',
    `total_customers_notified` STRING COMMENT 'Count of unique customers who received the LTB notification. Tracks the breadth of customer impact and supports acknowledgment tracking and follow-up activities.',
    CONSTRAINT pk_ltb_notification PRIMARY KEY(`ltb_notification_id`)
) COMMENT 'Last Time Buy notification records issued when a product reaches EOL, specifying the final order date, final shipment date, recommended replacement product, minimum order quantity for LTB, and customer acknowledgment tracking. Manages the formal LTB process per JEDEC JESD48 standard, ensuring customers have adequate notice to qualify replacement parts or place bridge inventory orders.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`product_ip_core` (
    `product_ip_core_id` BIGINT COMMENT 'Unique identifier for the IP core product record. Primary key for the IP core catalog.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: IP cores require ECCN classification for export; linking each core to its classification supports export license generation.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: product_ip_core represents reusable IP blocks that belong to a catalog product; adding ic_catalog_id creates the required parent link.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: IP cores have explicit legal entity ownership for licensing agreements, royalty revenue tracking, IP protection, transfer pricing between entities, and tax treatment of intangible assets.',
    `process_node_id` BIGINT COMMENT 'FK to product.product_process_node.product_process_node_id — IP cores have process node compatibility. Must reference which nodes the IP is qualified for.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: IP core licensing revenue is tracked against a profit center for financial reporting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: IP core licensing management records the vendor (supplier) that provides each IP core for royalty and support purposes.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: IP core development is a project with WBS for tracking design costs, verification expenses, milestone payments to vendors, and capitalization decisions for internally-developed or acquired IP.',
    `area_mm2` DECIMAL(18,2) COMMENT 'Physical silicon area occupied by the IP core in square millimeters. Part of PPA (Power, Performance, Area) metrics.',
    `compliance_certifications` STRING COMMENT 'Comma-separated list of industry compliance certifications the IP core meets (e.g., ISO 26262 for automotive, DO-254 for aerospace, FIPS 140-2 for cryptography).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the IP core record was first created in the system.',
    `design_for_testability` BOOLEAN COMMENT 'Indicates whether the IP core includes DFT features such as scan chains, BIST (Built-In Self-Test), or ATPG support.',
    `documentation_package` STRING COMMENT 'Reference to the documentation package location or identifier (e.g., datasheet, integration guide, verification plan, user manual).',
    `eda_tool_compatibility` STRING COMMENT 'Comma-separated list of EDA tools that support this IP core (e.g., Cadence Virtuoso, Synopsys Design Compiler, Mentor Graphics).',
    `eol_date` DATE COMMENT 'Planned or actual end-of-life date for the IP core. After this date, the IP is no longer supported for new designs.',
    `errata_notes` STRING COMMENT 'Known issues, limitations, or workarounds for the IP core. Reference to errata document or summary of key issues.',
    `foundry_compatibility` STRING COMMENT 'Comma-separated list of foundries whose PDKs this IP core is compatible with (e.g., TSMC, Samsung, GlobalFoundries, Intel).',
    `gate_count` BIGINT COMMENT 'Approximate number of logic gates in the IP core. Used for complexity estimation and area prediction.',
    `integration_complexity` STRING COMMENT 'Estimated complexity level for integrating the IP core into an SoC or ASIC design: low (plug-and-play), medium (moderate customization), high (significant integration effort), very high (extensive customization required).. Valid values are `low|medium|high|very_high`',
    `interface_protocol` STRING COMMENT 'Standard interface protocol(s) supported by the IP core (e.g., AXI4, AHB, APB, PCIe Gen4, USB 3.2, DDR5). Comma-separated if multiple.',
    `ip_category` STRING COMMENT 'Functional classification of the IP core: processor cores, memory controllers, interface controllers (USB, PCIe, Ethernet), analog blocks, PHYs, security engines, DSP blocks, or hardware accelerators. [ENUM-REF-CANDIDATE: processor|memory_controller|interface|analog|phy|security|dsp|accelerator — 8 candidates stripped; promote to reference product]',
    `ip_core_code` STRING COMMENT 'Unique business identifier or SKU for the IP core used in PLM and EDA systems.',
    `ip_core_name` STRING COMMENT 'Human-readable name of the IP core block (e.g., ARM Cortex-A78, USB 3.2 PHY, DDR5 Memory Controller).',
    `ip_type` STRING COMMENT 'Classification of IP core implementation: hard IP (physical layout fixed), soft IP (RTL synthesizable), or firm IP (netlist with some physical constraints).. Valid values are `hard_ip|soft_ip|firm_ip`',
    `licensing_model` STRING COMMENT 'Business model for IP core licensing: royalty-free (one-time fee), per-unit royalty (fee per chip manufactured), NRE upfront (non-recurring engineering fee), subscription (annual license), or hybrid (combination).. Valid values are `royalty_free|per_unit_royalty|nre_upfront|subscription|hybrid`',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the IP core: development (under design), verification (testing phase), production (available for integration), mature (stable and widely used), deprecated (not recommended for new designs), or EOL (end of life).. Valid values are `development|verification|production|mature|deprecated|eol`',
    `low_power_modes` STRING COMMENT 'Comma-separated list of low-power operating modes supported by the IP core (e.g., sleep, retention, power gating, clock gating).',
    `ltb_notification_date` DATE COMMENT 'Date when the last time buy notification was issued for the IP core, alerting customers to place final orders before discontinuation.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the IP core record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the IP core record was last modified.',
    `nre_cost_usd` DECIMAL(18,2) COMMENT 'One-time non-recurring engineering cost in USD for licensing and integrating the IP core into a design.',
    `operating_frequency_mhz` DECIMAL(18,2) COMMENT 'Maximum operating frequency of the IP core in megahertz.',
    `operating_voltage_v` DECIMAL(18,2) COMMENT 'Nominal operating voltage for the IP core in volts (e.g., 0.8V, 1.2V).',
    `per_unit_royalty_usd` DECIMAL(18,2) COMMENT 'Royalty fee in USD charged per manufactured chip that incorporates this IP core. Null if licensing model is royalty-free.',
    `performance_metric` STRING COMMENT 'Key performance indicator for the IP core (e.g., clock frequency in MHz, throughput in Gbps, DMIPS for processors). Part of PPA metrics.',
    `power_consumption_mw` DECIMAL(18,2) COMMENT 'Typical power consumption of the IP core in milliwatts under nominal operating conditions. Part of PPA (Power, Performance, Area) metrics.',
    `process_node_compatibility` STRING COMMENT 'Comma-separated list of process nodes (technology nodes) that this IP core supports (e.g., 7nm, 5nm, 3nm). Indicates which fabrication processes the IP can be manufactured on.',
    `reference_designs` STRING COMMENT 'Comma-separated list of reference design identifiers or links that demonstrate the IP core integration and usage.',
    `release_date` DATE COMMENT 'Date when this version of the IP core was officially released for production use.',
    `rtl_language` STRING COMMENT 'Hardware description language used for the IP core RTL: Verilog, VHDL, SystemVerilog, Chisel, or not applicable (for hard IPs without RTL).. Valid values are `verilog|vhdl|systemverilog|chisel|not_applicable`',
    `security_features` STRING COMMENT 'Comma-separated list of security features provided by the IP core (e.g., AES encryption, secure boot, TrustZone, cryptographic accelerators).',
    `support_contact` STRING COMMENT 'Contact information for technical support and integration assistance for the IP core.',
    `temperature_range_c` STRING COMMENT 'Operating temperature range for the IP core in Celsius (e.g., -40 to 125). Format: min to max.',
    `vendor_name` STRING COMMENT 'Name of the IP core vendor or provider (e.g., ARM, Synopsys, Cadence, internal design team).',
    `verification_status` STRING COMMENT 'Current verification state of the IP core: not started, in progress (under verification), verified (passed all tests), or silicon proven (validated in actual silicon).. Valid values are `not_started|in_progress|verified|silicon_proven`',
    `version` STRING COMMENT 'Version identifier of the IP core (e.g., v2.1, r1p3). Tracks revisions and updates to the IP block.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the IP core record.',
    CONSTRAINT pk_product_ip_core PRIMARY KEY(`product_ip_core_id`)
) COMMENT 'Intellectual Property core catalog for reusable silicon IP blocks available for integration into SoC and ASIC designs, including hard IPs (PHYs, memory compilers, analog blocks) and soft IPs (processor cores, interface controllers, security engines). Captures IP name, version, process node compatibility, licensing model (royalty-free, per-unit royalty, NRE), PPA characteristics, verification status, and EDA tool compatibility.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`product_qualification_program` (
    `product_qualification_program_id` BIGINT COMMENT 'Unique identifier for the product qualification program record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Qualification programs have dedicated budgets; linking to a cost center enables expense tracking.',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, IP core, or discrete device) undergoing qualification testing.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Qualification programs are funded and owned by legal entities; results submitted to regulatory bodies under entity name; liability for qualification claims and warranty is entity-specific.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Customer-funded qualification programs generate revenue and are tracked by profit center for P&L reporting, margin analysis, and revenue recognition of qualification services sold to customers.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Qualification programs (AEC-Q100, JEDEC, ISO 26262) generate formal compliance certifications upon successful completion. Links qualification test results to issued certificates for automotive, aerosp',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: AEC-Q100/Q101 product qualification programs require a completed process qualification as a prerequisite gate. Product qualification engineers must reference the specific process_qualification record ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Qualification programs in semiconductors are often conducted for specific orderable variants (SKUs) — a qualification for a commercial-grade SKU does not automatically qualify the automotive-grade SKU',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Supplier Qualification Program tracks qualification status, audits, and risk for each supplier associated with a product line.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Qualification programs are projects tracked via WBS for cost control, schedule management, resource allocation, and capitalization of qualification costs for new products or process nodes.',
    `acceptance_criteria` STRING COMMENT 'Pass/fail criteria for the qualification program, typically expressed as maximum allowable failure rate or zero failures for critical parameters.',
    `actual_completion_date` DATE COMMENT 'Actual date when qualification program was completed and final report approved. Gate-keeps product lifecycle transition from NPI to volume production.',
    `actual_start_date` DATE COMMENT 'Actual date when qualification testing activities commenced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification program record was first created in the system.',
    `deviation_description` STRING COMMENT 'Detailed description of any approved deviations from the standard qualification test plan, including technical justification and risk assessment.',
    `deviation_granted` BOOLEAN COMMENT 'Indicates whether any deviations from the standard qualification test matrix were granted by engineering review board.',
    `esd_cdm_enabled` BOOLEAN COMMENT 'Indicates whether ESD Charged Device Model stress test is included in the qualification plan. CDM simulates discharge from a charged device to ground.',
    `esd_cdm_voltage_v` STRING COMMENT 'Target voltage level in volts for ESD Charged Device Model testing, typically 500V minimum for Class C2 devices.',
    `esd_hbm_enabled` BOOLEAN COMMENT 'Indicates whether ESD Human Body Model stress test is included in the qualification plan. HBM simulates discharge from human contact.',
    `esd_hbm_voltage_v` STRING COMMENT 'Target voltage level in volts for ESD Human Body Model testing, typically 2000V minimum for Class 2 devices.',
    `failure_threshold_ppm` STRING COMMENT 'Maximum allowable failure rate expressed in Defective Parts Per Million (DPPM) for the qualification program to pass.',
    `hast_duration_hours` STRING COMMENT 'Duration in hours for Highly Accelerated Stress Test, typically 96 to 264 hours.',
    `hast_enabled` BOOLEAN COMMENT 'Indicates whether Highly Accelerated Stress Test is included in the qualification plan. HAST combines high temperature, high humidity, and voltage bias to accelerate corrosion and moisture-related failures.',
    `hast_relative_humidity_pct` STRING COMMENT 'Relative humidity percentage for Highly Accelerated Stress Test, typically 85% RH.',
    `hast_temperature_c` STRING COMMENT 'Temperature in degrees Celsius for Highly Accelerated Stress Test, typically 110°C to 130°C.',
    `htol_duration_hours` STRING COMMENT 'Duration in hours for High Temperature Operating Life stress test, typically 1000 hours minimum per JEDEC standards.',
    `htol_enabled` BOOLEAN COMMENT 'Indicates whether High Temperature Operating Life stress test is included in the qualification plan. HTOL accelerates time-dependent failure mechanisms under elevated temperature and voltage bias.',
    `htol_temperature_c` STRING COMMENT 'Junction temperature in degrees Celsius for High Temperature Operating Life stress testing, typically 125°C to 150°C.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification program record was last updated.',
    `latchup_current_ma` STRING COMMENT 'Trigger current in milliamperes for latch-up testing, typically 100mA minimum per JEDEC standards.',
    `latchup_enabled` BOOLEAN COMMENT 'Indicates whether latch-up susceptibility test is included in the qualification plan. Latch-up is a CMOS failure mode where parasitic thyristor structures create low-impedance paths.',
    `lot_count` STRING COMMENT 'Number of independent fabrication lots from which qualification samples must be drawn to ensure manufacturing process representativeness.',
    `planned_completion_date` DATE COMMENT 'Planned date for completion of all qualification testing and final report approval.',
    `planned_start_date` DATE COMMENT 'Planned date for initiation of qualification testing activities.',
    `program_code` STRING COMMENT 'Business identifier for the qualification program, typically combining product family code and qualification standard abbreviation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `program_name` STRING COMMENT 'Descriptive name of the qualification program including product identifier and target application domain.',
    `program_status` STRING COMMENT 'Current lifecycle status of the qualification program. Gate-keeps product lifecycle transition from NPI to volume production.. Valid values are `PLANNED|IN_PROGRESS|ON_HOLD|COMPLETED|FAILED|WAIVED`',
    `qualification_standard` STRING COMMENT 'Industry or customer-specific reliability qualification standard governing the test plan. JEDEC JESD47 for general semiconductor reliability, AEC-Q100 for automotive ICs, AEC-Q101 for discrete semiconductors, AEC-Q104 for multi-chip modules, MIL-STD-883 for military/aerospace, or customer-specific requirements. [ENUM-REF-CANDIDATE: JEDEC_JESD47|AEC_Q100|AEC_Q101|AEC_Q104|MIL_STD_883|CUSTOMER_SPECIFIC|IEC_60749|IEC_62196 — 8 candidates stripped; promote to reference product]',
    `qualification_type` STRING COMMENT 'Category of qualification program based on trigger event: new product introduction, process node change, package technology change, supply chain change, periodic requalification, or extended temperature range qualification.. Valid values are `NEW_PRODUCT|PROCESS_CHANGE|PACKAGE_CHANGE|SUPPLIER_CHANGE|REQUALIFICATION|EXTENDED_TEMP`',
    `responsible_engineer` STRING COMMENT 'Name of the reliability engineer responsible for planning, executing, and reporting the qualification program.',
    `sample_size` STRING COMMENT 'Total number of device units required for the complete qualification test plan across all test conditions and lots.',
    `tc_cycle_count` STRING COMMENT 'Number of temperature cycles for Temperature Cycling test, typically 500 to 1000 cycles minimum.',
    `tc_enabled` BOOLEAN COMMENT 'Indicates whether Temperature Cycling stress test is included in the qualification plan. TC accelerates thermal fatigue failures due to coefficient of thermal expansion mismatch.',
    `tc_max_temperature_c` STRING COMMENT 'Maximum temperature in degrees Celsius for Temperature Cycling test, typically 125°C to 150°C.',
    `tc_min_temperature_c` STRING COMMENT 'Minimum temperature in degrees Celsius for Temperature Cycling test, typically -55°C or -65°C.',
    `test_matrix_version` STRING COMMENT 'Version identifier of the qualification test matrix document defining the complete set of reliability and environmental stress tests, sample sizes, and acceptance criteria.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `waiver_granted` BOOLEAN COMMENT 'Indicates whether a waiver was granted to allow production release despite qualification test failures or incomplete testing.',
    `waiver_justification` STRING COMMENT 'Business and technical justification for granting a qualification waiver, including risk mitigation plan and customer approval documentation.',
    CONSTRAINT pk_product_qualification_program PRIMARY KEY(`product_qualification_program_id`)
) COMMENT 'Product qualification program records defining the reliability and environmental test plan required before production release gate. Captures qualification standard (JEDEC JESD47, AEC-Q100/Q101/Q104, MIL-STD-883, customer-specific), test matrix, sample plan, stress conditions (HTOL, HAST, TC, ESD, latch-up), duration, pass/fail criteria, qualification status, completion date, and any deviations or waivers granted. Gate-keeps product lifecycle transition from NPI to volume production.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`compliance_cert` (
    `compliance_cert_id` BIGINT COMMENT 'Unique identifier for the product compliance certification record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Regulatory reporting requires each compliance certification to be linked to the customer account that holds it, enabling audit trails and certification status per client.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Compliance certifications in semiconductors are often package-specific and variant-specific — a RoHS certification for a TQFP-144 package may not apply to the same IC in a BGA-256 package. Linking com',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Certification activities (third-party testing, audit fees, lab costs, documentation) are cost center expenses in quality/compliance organizations, tracked for regulatory compliance budgets and cost al',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Certifications (RoHS, REACH, automotive, ISO) are issued to legal entities; compliance liability, market access rights, and regulatory reporting are entity-specific for each jurisdiction.',
    `pcn_id` BIGINT COMMENT 'Foreign key linking to product.pcn. Business justification: compliance_cert.pcn_reference_number (STRING) is a denormalized reference to the PCN that triggered recertification or is associated with a compliance change. Normalizing to pcn_id → pcn.pcn_id enable',
    `ic_catalog_id` BIGINT COMMENT 'FK to product.ic_catalog.ic_catalog_id — Compliance certifications are obtained for specific products or SKUs. Required for export control screening and customer documentation.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Product-specific compliance certificates (RoHS, REACH, conflict minerals) reference underlying site/process certifications (ISO 9001, ISO 14001, IATF 16949). Establishes certification hierarchy for se',
    `applicable_markets` STRING COMMENT 'Comma-separated list of geographic markets, regions, or countries where this compliance certification is recognized and valid (e.g., USA, EU, CHN, JPN, KOR). Uses ISO 3166-1 alpha-3 country codes.',
    `applicable_regions` STRING COMMENT 'Comma-separated list of regulatory regions or jurisdictions where this certification applies (e.g., North America, European Union, Asia-Pacific, EMEA).',
    `auditor_name` STRING COMMENT 'Name of the lead auditor or assessor from the certification body who conducted the compliance assessment.',
    `automotive_grade_certified` BOOLEAN COMMENT 'Boolean flag indicating whether the product has achieved automotive-grade qualification certification (e.g., AEC-Q100 for ICs, AEC-Q101 for discrete semiconductors) for use in automotive applications.',
    `certification_body` STRING COMMENT 'Name of the accredited third-party organization or regulatory authority that issued the compliance certification (e.g., TÜV, UL, Intertek, SGS, Bureau Veritas).',
    `certification_number` STRING COMMENT 'Unique certificate number or identifier issued by the certification body for this compliance certification.',
    `certification_scope` STRING COMMENT 'Detailed description of the scope of the certification, including specific product variants, process nodes, package types, or application domains covered by this certification.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the compliance certification indicating whether it is active and valid, expired, pending approval, suspended, revoked, or under review.. Valid values are `active|expired|pending|suspended|revoked|under_review`',
    `certification_type` STRING COMMENT 'Type of regulatory or standards certification obtained. RoHS (Restriction of Hazardous Substances), REACH (Registration Evaluation Authorization and Restriction of Chemicals), TSCA (Toxic Substances Control Act), AEC-Q100/Q101 (Automotive Electronics Council qualification standards), ISO 26262 (Automotive Functional Safety), IEC 61508 (Functional Safety), UL (Underwriters Laboratories), CE (Conformité Européenne), FCC (Federal Communications Commission), ITAR (International Traffic in Arms Regulations), EAR (Export Administration Regulations). [ENUM-REF-CANDIDATE: RoHS|REACH|TSCA|AEC-Q100|AEC-Q101|ISO 26262|IEC 61508|UL|CE|FCC|ITAR|EAR — 12 candidates stripped; promote to reference product]',
    `compliance_notes` STRING COMMENT 'Free-text field for additional notes, exceptions, conditions, or special handling instructions related to this compliance certification.',
    `conflict_minerals_declaration` STRING COMMENT 'Declaration of conflict minerals (tin, tantalum, tungsten, gold - 3TG) sourcing and compliance status with Dodd-Frank Act Section 1502 and OECD Due Diligence Guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance certification record was first created in the system.',
    `customer_specific_requirement` STRING COMMENT 'Description of any customer-specific compliance requirements or certifications that this record addresses beyond standard regulatory requirements.',
    `ear_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether the product is subject to EAR (Export Administration Regulations) export controls administered by the Bureau of Industry and Security.',
    `effective_date` DATE COMMENT 'Date from which the compliance certification becomes valid and enforceable for the product.',
    `environmental_standard` STRING COMMENT 'Environmental management system standard under which this certification was issued (e.g., ISO 14001, ISO 50001 for energy management).',
    `expiry_date` DATE COMMENT 'Date on which the compliance certification expires and requires renewal or re-certification. Nullable for certifications without expiration.',
    `export_control_classification` STRING COMMENT 'Export control classification code or category assigned to the product under this certification (e.g., ECCN - Export Control Classification Number under EAR, or USML category under ITAR).',
    `functional_safety_level` STRING COMMENT 'Functional safety integrity level achieved by the product under ISO 26262 (ASIL A/B/C/D for automotive) or IEC 61508 (SIL 1/2/3/4 for industrial) standards. ASIL (Automotive Safety Integrity Level), SIL (Safety Integrity Level). [ENUM-REF-CANDIDATE: ASIL_A|ASIL_B|ASIL_C|ASIL_D|SIL_1|SIL_2|SIL_3|SIL_4|not_applicable — 9 candidates stripped; promote to reference product]',
    `hazardous_substance_declaration` STRING COMMENT 'Detailed declaration of hazardous substances present in the product, including substance names, CAS (Chemical Abstracts Service) numbers, concentration levels, and compliance status with RoHS, REACH, and TSCA regulations.',
    `internal_owner` STRING COMMENT 'Name or employee identifier of the internal compliance manager or product quality engineer responsible for maintaining this certification.',
    `issue_date` DATE COMMENT 'Date on which the compliance certification was officially issued by the certification body.',
    `itar_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether the product is subject to ITAR (International Traffic in Arms Regulations) export controls and requires special handling for international shipments.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance certification record was last modified or updated in the system.',
    `quality_management_standard` STRING COMMENT 'Quality management system standard under which this certification was issued (e.g., ISO 9001, IATF 16949, AS9100, ISO 13485).',
    `reach_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the product is compliant with REACH Regulation EC 1907/2006 governing the registration, evaluation, authorization, and restriction of chemicals in the European Union.',
    `recertification_frequency_months` STRING COMMENT 'Number of months between required recertification cycles. Null if recertification is not required or is event-driven rather than time-based.',
    `recertification_required` BOOLEAN COMMENT 'Boolean flag indicating whether this certification requires periodic recertification or renewal (True) or is a one-time certification (False).',
    `recertification_trigger_events` STRING COMMENT 'Comma-separated list of business events that trigger mandatory recertification (e.g., design change, process node migration, package change, supplier change, PCN issuance, material substitution).',
    `restricted_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes to which export or sale of this product is restricted or prohibited under applicable export control regulations.',
    `rohs_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the product is compliant with RoHS (Restriction of Hazardous Substances) Directive 2011/65/EU restricting the use of specific hazardous materials in electrical and electronic equipment.',
    `supporting_documentation_url` STRING COMMENT 'URL or file path to the repository location containing supporting documentation, test reports, certificates, and compliance declarations for this certification.',
    `test_laboratory` STRING COMMENT 'Name of the accredited testing laboratory that performed the compliance testing and analysis supporting this certification.',
    `test_report_number` STRING COMMENT 'Reference number of the official test report or assessment document that supports this compliance certification.',
    CONSTRAINT pk_compliance_cert PRIMARY KEY(`compliance_cert_id`)
) COMMENT 'Product compliance certification records tracking regulatory and standards certifications obtained for each product or SKU, including RoHS, REACH, TSCA, AEC-Q100/Q101, ISO 26262, IEC 61508, UL, CE, FCC, and ITAR classification. Captures certification body, certificate number, issue date, expiry date, applicable markets/regions, and re-certification trigger events. Supports export control screening and customer compliance documentation requests.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`errata` (
    `errata_id` BIGINT COMMENT 'Unique identifier for the product errata record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer who first reported this errata, if discovered externally. Null if discovered internally. Used for customer relationship management (CRM) and design-win tracking.',
    `product_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_spec. Business justification: Errata documents deviations from the product specification — a silicon bug is fundamentally a deviation from what product_spec defines. Linking errata.affected_product_spec_id → product_spec.product_s',
    `case_id` BIGINT COMMENT 'Reference to the automatic test equipment (ATE) test pattern, design verification plan test case, or simulation run that reproduces the errata. Used for regression testing and validation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Errata investigation, root cause analysis, workaround development, and customer technical support are engineering cost center activities tracked for quality cost reporting and resource allocation.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Errata are often discovered via specific test programs. Root cause analysis and test coverage improvement initiatives require linking errata to the test program that detected (or failed to detect) the',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the affected integrated circuit (IC) product, system on chip (SoC), application-specific integrated circuit (ASIC), or field-programmable gate array (FPGA) product.',
    `pcn_id` BIGINT COMMENT 'Foreign key linking to product.pcn. Business justification: errata.pcn_number (STRING) is a denormalized reference to the PCN that addresses or is associated with a silicon errata. When a silicon bug is fixed in a new silicon revision, a PCN is issued. Normali',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Silicon errata affecting functional safety (automotive ISO 26262, medical IEC 62304) or security features require regulatory disclosure filings. Links technical defects to mandatory safety notificatio',
    `to_ic_catalog_id` BIGINT COMMENT 'FK to product.ic_catalog.ic_catalog_id — Errata document bugs in specific IC products. Must reference the affected product and revision.',
    `affected_revisions` STRING COMMENT 'Comma-separated list of all silicon revisions affected by this errata (e.g., A0,A1,B0). Used to determine scope of customer impact.',
    `affected_use_cases` STRING COMMENT 'Description of customer application scenarios or operating modes impacted by the errata (e.g., high-speed PCIe Gen4 operation, concurrent multi-channel DMA, low-power sleep modes).',
    `business_impact` STRING COMMENT 'Assessment of commercial and operational impact including potential revenue risk, customer satisfaction impact, warranty exposure, and time to market (TTM) implications.',
    `closure_reason` STRING COMMENT 'Reason for closing the errata record. Fixed in Silicon: corrected in new revision; Fixed in Software: resolved via patch; Workaround Sufficient: mitigation acceptable; Product EOL: end-of-life product; Not Reproducible: cannot verify; Working as Designed: not a defect.. Valid values are `fixed_in_silicon|fixed_in_software|workaround_sufficient|product_eol|not_reproducible|working_as_designed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this errata record was first created in the product lifecycle management (PLM) system. Used for audit trail and lifecycle tracking.',
    `customer_disclosure_status` STRING COMMENT 'Status of customer communication regarding this errata. Not Disclosed: internal only; Pending Approval: awaiting management approval; Disclosed NDA: shared under non-disclosure agreement; Disclosed Public: published in public errata sheet.. Valid values are `not_disclosed|pending_approval|disclosed_nda|disclosed_public`',
    `disclosure_date` DATE COMMENT 'Date when the errata was first communicated to customers via product change notification (PCN), errata sheet update, or technical advisory. Null if not yet disclosed.',
    `discovered_by` STRING COMMENT 'Source or method by which the errata was discovered. Internal Validation: found during wafer testing or quality assurance; Customer Report: reported by design-in customer; Field Failure: observed in production deployment; Design Verification: identified during design for testability (DFT) or automatic test pattern generation (ATPG).. Valid values are `internal_validation|customer_report|field_failure|design_verification`',
    `discovered_date` DATE COMMENT 'Date when the silicon bug or functional deviation was first identified, either during internal validation, customer testing, or field deployment.',
    `engineering_owner` STRING COMMENT 'Name or identifier of the design engineer or engineering team responsible for investigating and resolving this errata. Used for accountability and workload tracking.',
    `errata_number` STRING COMMENT 'Business identifier for the errata record, typically formatted as product-family prefix followed by sequential number (e.g., SOC-001234, FPGA-000567). Used in customer communications and product change notifications (PCN).. Valid values are `^[A-Z0-9]{2,6}-[0-9]{3,6}$`',
    `errata_status` STRING COMMENT 'Current lifecycle status of the errata record. Draft: initial documentation; Under Review: engineering validation; Confirmed: verified silicon bug; Disclosed: communicated to customers; Resolved: fix available; Closed: no longer applicable.. Valid values are `draft|under_review|confirmed|disclosed|resolved|closed`',
    `fix_plan` STRING COMMENT 'Planned resolution approach for the errata. Next Silicon Revision: will be corrected in next tapeout; Software Patch: addressable via firmware/driver update; No Fix Planned: low priority or end-of-life (EOL) product; Under Evaluation: fix strategy being assessed.. Valid values are `next_silicon_revision|software_patch|no_fix_planned|under_evaluation`',
    `fix_target_revision` STRING COMMENT 'Silicon stepping or revision where the errata will be corrected (e.g., C0, D1). Null if fix is software-only or no fix planned.. Valid values are `^[A-Z][0-9]{1,2}$`',
    `functional_block` STRING COMMENT 'Name of the intellectual property (IP) core, register transfer level (RTL) module, or functional block where the errata occurs (e.g., PCIe Controller, DDR PHY, CPU Core, DMA Engine).',
    `impacted_customer_count` STRING COMMENT 'Estimated or actual number of customers affected by this errata based on product shipments and silicon revision distribution. Used for risk assessment and communication prioritization.',
    `internal_notes` STRING COMMENT 'Confidential internal notes for engineering team use only. May contain sensitive technical details, customer names, or business strategy information not suitable for external disclosure.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this errata record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this errata record. Used for change tracking and synchronization with downstream systems.',
    `regulatory_impact` STRING COMMENT 'Assessment of whether the errata affects compliance with industry standards or regulatory requirements such as automotive IATF 16949, functional safety ISO 26262, or export control ITAR/EAR classifications. Null if no regulatory impact.',
    `resolution_date` DATE COMMENT 'Date when the errata was resolved either through silicon revision fix, software patch release, or closure decision. Null if still open or under evaluation.',
    `root_cause` STRING COMMENT 'Engineering analysis of the underlying silicon defect or design flaw causing the errata. May reference RTL logic error, timing violation, or process variation sensitivity.',
    `severity` STRING COMMENT 'Business impact severity of the errata. Critical: system failure or data corruption; Major: significant functional impact; Moderate: limited functional impact with workaround; Minor: cosmetic or edge-case issue.. Valid values are `critical|major|moderate|minor`',
    `silicon_revision` STRING COMMENT 'Silicon stepping or revision identifier where the errata was discovered (e.g., A0, B1, C2). Corresponds to mask revision in the fabrication process.. Valid values are `^[A-Z][0-9]{1,2}$`',
    `symptom_description` STRING COMMENT 'Detailed technical description of the observable behavior or functional deviation caused by the silicon bug. Includes conditions under which the issue manifests.',
    `title` STRING COMMENT 'Concise summary title of the silicon bug or functional deviation. Used in errata lists and customer-facing documentation.',
    `to_revision` BIGINT COMMENT 'FK to product.product_revision.product_revision_id — Errata are specific to a silicon revision/stepping. Must link to the affected revision.',
    `verification_date` DATE COMMENT 'Date when engineering verification of the errata was completed and status changed to verified or cannot reproduce. Null if verification still in progress or not started.',
    `verification_status` STRING COMMENT 'Engineering validation status of the reported errata. Unverified: initial report not yet investigated; In Progress: under engineering analysis; Verified: confirmed as silicon bug; Cannot Reproduce: unable to replicate reported behavior.. Valid values are `unverified|in_progress|verified|cannot_reproduce`',
    `workaround_available` BOOLEAN COMMENT 'Indicates whether a software, firmware, or operational workaround exists to mitigate the errata impact. True if workaround documented; False if no mitigation available.',
    `workaround_description` STRING COMMENT 'Detailed instructions for software, firmware, or operational workaround to avoid or mitigate the errata. May include register configuration changes, driver patches, or usage restrictions. Null if no workaround available.',
    `workaround_performance_impact` STRING COMMENT 'Description of any power, performance, or area (PPA) degradation introduced by the workaround (e.g., 5% throughput reduction, 10mW additional power consumption, increased latency). Null if no measurable impact or no workaround.',
    CONSTRAINT pk_errata PRIMARY KEY(`errata_id`)
) COMMENT 'Product errata records documenting known silicon bugs, functional deviations, and workarounds for released IC products. Captures errata ID, affected product and revision, silicon stepping, errata title, functional impact description, affected use cases, workaround availability, fix target (next silicon revision or software workaround), customer disclosure status, and severity classification. Critical for customer technical support and design-in risk management.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`configuration_rule` (
    `configuration_rule_id` BIGINT COMMENT 'System-generated unique identifier for the configuration rule.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Configuration rules enabling/disabling features (encryption, performance tiers) can alter ECCN classification per EAR 740.17(b). Configurable semiconductors need ECCN determination per configuration f',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: configuration_rule defines constraints that are scoped to a product family; a foreign key to product_family replaces the free‑text family field, normalizing the model.',
    `ic_catalog_id` BIGINT COMMENT 'FK to product.ic_catalog.ic_catalog_id — Configuration rules define valid SKU combinations for a specific catalog product. Product reference is mandatory.',
    `overridden_configuration_rule_id` BIGINT COMMENT 'Self-referencing FK on configuration_rule (overridden_configuration_rule_id)',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: configuration_rule.applicable_process_node (STRING) is a denormalized reference to the process node for which a configuration rule applies. Configuration rules define valid combinations of package, sp',
    `applicable_market` STRING COMMENT 'Target market segment (e.g., automotive, consumer, industrial) for which the rule is valid.',
    `automotive_qualified` BOOLEAN COMMENT 'True if the rule applies to automotive‑qualified SKUs.',
    `configuration_rule_description` STRING COMMENT 'Detailed free‑text description of the rule logic and intent.',
    `configuration_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|deprecated|pending`',
    `constraint_expression` STRING COMMENT 'Logical expression defining the valid combination of options (e.g., "package_type=BGA AND speed_grade=high => voltage_variant=1.2V").',
    `country_of_origin` STRING COMMENT 'ISO‑3 country code indicating the origin of the component when the rule is applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the rule expires; null for open‑ended rules.',
    `effective_start_date` DATE COMMENT 'Date on which the rule becomes effective for SKU creation.',
    `hts_code` STRING COMMENT 'Customs classification code applicable to the rules configurations.',
    `is_default_rule` BOOLEAN COMMENT 'Indicates whether this rule is the default fallback when no other rule matches.',
    `itar_controlled` BOOLEAN COMMENT 'True if the rule is subject to ITAR export controls.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent formal review of the rule.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the rule.',
    `option_dependencies` STRING COMMENT 'Textual description of any dependent options or exclusions related to the rule.',
    `package_type` STRING COMMENT 'Package option that the rule constrains.. Valid values are `BGA|QFN|LGA|CSP|WLCSP|DIP`',
    `priority` STRING COMMENT 'Numeric priority used when multiple rules apply; lower numbers indicate higher priority.',
    `qualification_level` STRING COMMENT 'Qualification level option that the rule constrains.. Valid values are `standard|qualified|high_reliability|automotive|space`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the rule enforces REACH‑compliant configurations.',
    `reviewed_by` STRING COMMENT 'Identifier of the person or team that performed the last review.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the rule enforces RoHS‑compliant configurations.',
    `rule_code` STRING COMMENT 'Business identifier or code used to reference the rule in downstream systems.',
    `rule_name` STRING COMMENT 'Human‑readable name describing the purpose of the rule.',
    `rule_owner` STRING COMMENT 'Name or identifier of the person or team responsible for the rule.',
    `rule_type` STRING COMMENT 'Category of rule based on the option it governs.. Valid values are `package|speed|temperature|voltage|qualification|composite`',
    `rule_version` STRING COMMENT 'Incremental version number for change management of the rule.',
    `speed_grade` STRING COMMENT 'Speed grade option that the rule constrains.. Valid values are `low|mid|high|ultra`',
    `temperature_range` STRING COMMENT 'Temperature range option that the rule constrains.. Valid values are `commercial|industrial|extended|military`',
    `voltage_variant` STRING COMMENT 'Voltage variant option that the rule constrains.. Valid values are `1.0V|1.2V|1.5V|1.8V|2.5V`',
    CONSTRAINT pk_configuration_rule PRIMARY KEY(`configuration_rule_id`)
) COMMENT 'Rules defining valid combinations of package, speed grade, temperature range, voltage variant, and qualification level for orderable SKU creation. Captures constraint expressions, option dependencies, and effectivity dates. Prevents invalid SKU proliferation and powers customer-facing configurator tools for ASIC/FPGA option selection.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`product`.`pcn_impact` (
    `pcn_impact_id` BIGINT COMMENT 'Unique identifier for this PCN impact record. Primary key.',
    `pcn_id` BIGINT COMMENT 'Foreign key linking to the Product Change Notification that affects this SKU',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the specific SKU affected by this PCN',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PCN impact record was created, marking when this SKU was identified as affected by the PCN.',
    `customer_approval_count` STRING COMMENT 'Number of customers who explicitly approved or acknowledged acceptance of this PCN for this specific SKU. Tracked per SKU because customer base and approval requirements vary.',
    `customer_approval_required_flag` BOOLEAN COMMENT 'Indicates whether explicit customer approval or acknowledgment is required before implementing this change for this specific SKU. May vary by SKU based on customer contracts or qualification requirements.',
    `customer_objection_count` STRING COMMENT 'Number of customers who formally objected to or raised concerns about this PCN as it affects this specific SKU. Tracked per SKU because customer base varies by SKU.',
    `customer_response_deadline` DATE COMMENT 'Date by which customers must provide feedback, objections, or approval for this PCN as it affects this specific SKU. Typically 90-120 days from PCN issuance per JEDEC JESD46.',
    `effective_date` DATE COMMENT 'Date when the product change will be implemented in production for this specific SKU. New shipments of this SKU after this date will reflect the new specification.',
    `implementation_status` STRING COMMENT 'Current status of PCN implementation for this specific SKU. Tracks whether the change has been successfully implemented in production for this SKU variant.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this PCN impact record, tracking changes to dates, status, or customer response counts.',
    `last_ship_date` DATE COMMENT 'Final date by which this SKU manufactured under the old specification will be shipped. Marks the transition cutoff for this specific SKU.',
    `last_time_buy_date` DATE COMMENT 'Final date by which customers can place orders for this SKU manufactured under the old specification. Provides customers with a window to stock up before the change.',
    `sku_specific_impact_notes` STRING COMMENT 'Additional notes or clarifications about how this PCN specifically affects this SKU, including any SKU-specific qualification requirements, customer notifications, or implementation considerations.',
    CONSTRAINT pk_pcn_impact PRIMARY KEY(`pcn_impact_id`)
) COMMENT 'This association product represents the impact relationship between a Product Change Notification (PCN) and the specific SKUs affected by that change. It captures the per-SKU implementation timeline, customer response requirements, and transition dates that exist only in the context of a specific PCN affecting a specific SKU. Each record links one PCN to one affected SKU with attributes governing how and when that particular SKU transitions to the new specification.. Existence Justification: In semiconductor PLM operations, PCNs routinely affect multiple SKUs (a process change may impact an entire product family with dozens of orderable variants), and each SKU accumulates multiple PCNs over its lifecycle (process improvements, material changes, package updates). The business actively manages PCN Impact as a distinct operational entity with per-SKU implementation timelines, customer response tracking, and transition dates that cannot be stored on either the PCN or SKU alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ADD CONSTRAINT `fk_product_ic_catalog_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_replacement_sku_id` FOREIGN KEY (`replacement_sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`family` ADD CONSTRAINT `fk_product_family_parent_family_id` FOREIGN KEY (`parent_family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`family` ADD CONSTRAINT `fk_product_family_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ADD CONSTRAINT `fk_product_product_spec_product_ic_catalog_id` FOREIGN KEY (`product_ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ADD CONSTRAINT `fk_product_bom_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_parent_line_bom_line_id` FOREIGN KEY (`parent_line_bom_line_id`) REFERENCES `semiconductors_ecm`.`product`.`bom_line`(`bom_line_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `semiconductors_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_to_bom_id` FOREIGN KEY (`to_bom_id`) REFERENCES `semiconductors_ecm`.`product`.`bom`(`bom_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_product_qualification_program_id` FOREIGN KEY (`product_qualification_program_id`) REFERENCES `semiconductors_ecm`.`product`.`product_qualification_program`(`product_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ADD CONSTRAINT `fk_product_pcn_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ADD CONSTRAINT `fk_product_ltb_notification_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ADD CONSTRAINT `fk_product_ltb_notification_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ADD CONSTRAINT `fk_product_product_ip_core_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ADD CONSTRAINT `fk_product_product_qualification_program_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ADD CONSTRAINT `fk_product_compliance_cert_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_product_spec_id` FOREIGN KEY (`product_spec_id`) REFERENCES `semiconductors_ecm`.`product`.`product_spec`(`product_spec_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ADD CONSTRAINT `fk_product_errata_to_ic_catalog_id` FOREIGN KEY (`to_ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ADD CONSTRAINT `fk_product_configuration_rule_family_id` FOREIGN KEY (`family_id`) REFERENCES `semiconductors_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ADD CONSTRAINT `fk_product_configuration_rule_ic_catalog_id` FOREIGN KEY (`ic_catalog_id`) REFERENCES `semiconductors_ecm`.`product`.`ic_catalog`(`ic_catalog_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ADD CONSTRAINT `fk_product_configuration_rule_overridden_configuration_rule_id` FOREIGN KEY (`overridden_configuration_rule_id`) REFERENCES `semiconductors_ecm`.`product`.`configuration_rule`(`configuration_rule_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ADD CONSTRAINT `fk_product_configuration_rule_process_node_id` FOREIGN KEY (`process_node_id`) REFERENCES `semiconductors_ecm`.`product`.`process_node`(`process_node_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ADD CONSTRAINT `fk_product_pcn_impact_pcn_id` FOREIGN KEY (`pcn_id`) REFERENCES `semiconductors_ecm`.`product`.`pcn`(`pcn_id`);
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ADD CONSTRAINT `fk_product_pcn_impact_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `semiconductors_ecm`.`product`.`sku`(`sku_id`);

-- ========= TAGS =========
ALTER SCHEMA `semiconductors_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `semiconductors_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit (IC) Catalog Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Characterization Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `family_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `aec_qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Automotive Electronics Council (AEC) Qualification Level');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `aec_qualification_level` SET TAGS ('dbx_value_regex' = 'AEC-Q100|AEC-Q101|AEC-Q102|AEC-Q200|NA');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `automotive_qualified` SET TAGS ('dbx_business_glossary_term' = 'Automotive Qualification Status');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'IC Design Methodology Type');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `design_type` SET TAGS ('dbx_value_regex' = 'Full_Custom|Semi_Custom|Standard_Cell|Gate_Array|Structured_ASIC|Platform_Based');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Size in Square Millimeters');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN)');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}(.[a-z])?$');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `external_part_number` SET TAGS ('dbx_business_glossary_term' = 'External Part Number');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `external_part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `first_silicon_date` SET TAGS ('dbx_business_glossary_term' = 'First Silicon Date');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `hts_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}.[0-9]{2}.[0-9]{4}$');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `internal_part_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Part Number');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `internal_part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `lead_free_compliant` SET TAGS ('dbx_business_glossary_term' = 'Lead-Free RoHS Compliance');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `npi_phase` SET TAGS ('dbx_business_glossary_term' = 'New Product Introduction (NPI) Phase');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `operating_frequency_max_mhz` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Frequency in Megahertz');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `operating_voltage_max_v` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Voltage in Volts');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `operating_voltage_min_v` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Voltage in Volts');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `pin_count` SET TAGS ('dbx_business_glossary_term' = 'Package Pin Count');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `power_max_mw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Power Consumption in Milliwatts');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `power_typical_mw` SET TAGS ('dbx_business_glossary_term' = 'Typical Power Consumption in Milliwatts');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Type');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Marketing Name');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type Classification');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `production_release_date` SET TAGS ('dbx_business_glossary_term' = 'Production Release Date');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Regulation Compliance');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Status');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `rtl_language` SET TAGS ('dbx_business_glossary_term' = 'Register Transfer Level (RTL) Language');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `rtl_language` SET TAGS ('dbx_value_regex' = 'Verilog|VHDL|SystemVerilog|Chisel|NA');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `tapeout_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Date');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Grade');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_value_regex' = 'Commercial|Industrial|Automotive|Military|Extended');
ALTER TABLE `semiconductors_ecm`.`product`.`ic_catalog` ALTER COLUMN `transistor_count` SET TAGS ('dbx_business_glossary_term' = 'Transistor Count');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `replacement_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit (IC) Catalog Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `halogen_free` SET TAGS ('dbx_business_glossary_term' = 'Halogen Free');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `hts_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}.[0-9]{2}.[0-9]{2}.[0-9]{2}$');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `introduction_date` SET TAGS ('dbx_business_glossary_term' = 'Market Introduction Date');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `lead_time_weeks` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Weeks)');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'npi|active|mature|declining|eol_announced|discontinued');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_business_glossary_term' = 'List Price (United States Dollar)');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `orderable_flag` SET TAGS ('dbx_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `pcn_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Required Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `pin_count` SET TAGS ('dbx_business_glossary_term' = 'Pin Count');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Qualification Level');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `qualification_level` SET TAGS ('dbx_value_regex' = 'commercial|industrial|automotive_aec_q100|automotive_aec_q101|military_mil_std_883|space');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `shippable_flag` SET TAGS ('dbx_business_glossary_term' = 'Shippable Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `speed_grade` SET TAGS ('dbx_business_glossary_term' = 'Speed Grade');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (United States Dollar)');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `standard_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Standard Pack Quantity');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Range');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `temperature_range` SET TAGS ('dbx_value_regex' = 'commercial|industrial|automotive|military|extended');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `unit_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Unit Weight (Grams)');
ALTER TABLE `semiconductors_ecm`.`product`.`sku` ALTER COLUMN `voltage_variant` SET TAGS ('dbx_business_glossary_term' = 'Voltage Variant');
ALTER TABLE `semiconductors_ecm`.`product`.`family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`family` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Family Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `parent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Family Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `active_pcn_count` SET TAGS ('dbx_business_glossary_term' = 'Active Product Change Notification (PCN) Count');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `application_domain` SET TAGS ('dbx_business_glossary_term' = 'Application Domain');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `design_center_location` SET TAGS ('dbx_business_glossary_term' = 'Design Center Location');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `dfm_score` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Score');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `dft_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Coverage Percentage');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `eda_tool_suite` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Suite');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_business_glossary_term' = 'Product Family Code');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `family_description` SET TAGS ('dbx_business_glossary_term' = 'Product Family Description');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Product Family Name');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `family_type` SET TAGS ('dbx_business_glossary_term' = 'Product Family Type');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `ip_core_count` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Count');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'EUV|DUV|Immersion|Dry');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `ltb_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `npi_start_date` SET TAGS ('dbx_business_glossary_term' = 'New Product Introduction (NPI) Start Date');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `osat_partner` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Partner');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `product_line_manager` SET TAGS ('dbx_business_glossary_term' = 'Product Line Manager');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `target_performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Performance Metric');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `target_power_mw` SET TAGS ('dbx_business_glossary_term' = 'Target Power Consumption (Milliwatts)');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `typical_die_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Typical Die Size (Square Millimeters)');
ALTER TABLE `semiconductors_ecm`.`product`.`family` ALTER COLUMN `volume_production_date` SET TAGS ('dbx_business_glossary_term' = 'Volume Production Date');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `active_product_count` SET TAGS ('dbx_business_glossary_term' = 'Active Product Count');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `baseline_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Baseline Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `baseline_yield_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `cost_per_wafer_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Wafer (United States Dollars)');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `cost_per_wafer_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Cycle Time (Days)');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Complexity Level');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Very High');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `environmental_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Status');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `environmental_compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Under Review');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `foundry_source` SET TAGS ('dbx_business_glossary_term' = 'Foundry Source');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `foundry_source` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Process Node Lifecycle Stage');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'NPI|Growth|Mature|Decline|EOL');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology Type');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'EUV|DUV|I-Line|G-Line|Mixed');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `ltb_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Deadline Date');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `minimum_feature_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Feature Size (Nanometers)');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `multi_patterning_layers` SET TAGS ('dbx_business_glossary_term' = 'Multi-Patterning Layer Count');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Process Node Code');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `node_generation` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Generation');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Process Node Name');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Process Node Notes');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `opc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Required Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `pdk_release_date` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Release Date');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `power_performance_area_rating` SET TAGS ('dbx_business_glossary_term' = 'Power Performance Area (PPA) Rating');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `power_performance_area_rating` SET TAGS ('dbx_value_regex' = 'Excellent|Good|Fair|Limited');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Process Node Qualification Date');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Process Node Qualification Status');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'Qualified|In Qualification|Pre-Production|Development|Deprecated|Obsolete');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `supported_device_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Types');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture Type');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_value_regex' = 'GAA|FinFET|Planar|FDSOI|Other');
ALTER TABLE `semiconductors_ecm`.`product`.`process_node` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification ID');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `automotive_grade` SET TAGS ('dbx_business_glossary_term' = 'Automotive Grade');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `automotive_grade` SET TAGS ('dbx_value_regex' = 'none|aec_q100_grade_0|aec_q100_grade_1|aec_q100_grade_2|aec_q100_grade_3');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `characterization_date` SET TAGS ('dbx_business_glossary_term' = 'Characterization Date');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `data_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention (Years)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `die_area_achieved_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Area Achieved (mm²)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `die_area_target_mm2` SET TAGS ('dbx_business_glossary_term' = 'Die Area Target (mm²)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `dynamic_power_achieved_mw` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Power Achieved (mW)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `dynamic_power_target_mw` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Power Target (mW)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `endurance_cycles` SET TAGS ('dbx_business_glossary_term' = 'Endurance Cycles');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `esd_protection_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Electrostatic Discharge (ESD) Protection Level (kV)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `functional_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Functional Safety Rating');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `interface_protocols` SET TAGS ('dbx_business_glossary_term' = 'Interface Protocols');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `io_count` SET TAGS ('dbx_business_glossary_term' = 'Input/Output (I/O) Count');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `leakage_power_achieved_mw` SET TAGS ('dbx_business_glossary_term' = 'Leakage Power Achieved (mW)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `leakage_power_target_mw` SET TAGS ('dbx_business_glossary_term' = 'Leakage Power Target (mW)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `max_frequency_achieved_mhz` SET TAGS ('dbx_business_glossary_term' = 'Maximum Frequency Achieved (MHz)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `max_frequency_target_mhz` SET TAGS ('dbx_business_glossary_term' = 'Maximum Frequency Target (MHz)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `memory_configuration` SET TAGS ('dbx_business_glossary_term' = 'Memory Configuration');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `operating_condition_corner` SET TAGS ('dbx_business_glossary_term' = 'Operating Condition Corner');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `operating_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Maximum (°C)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `operating_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Minimum (°C)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `operating_voltage_max_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Maximum (V)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `operating_voltage_min_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Minimum (V)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `operating_voltage_nominal_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage Nominal (V)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `security_features` SET TAGS ('dbx_business_glossary_term' = 'Security Features');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|obsolete');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanosheet|nanowire');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `transistor_count` SET TAGS ('dbx_business_glossary_term' = 'Transistor Count');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `semiconductors_ecm`.`product`.`product_spec` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` SET TAGS ('dbx_subdomain' = 'structure_definition');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `pcn_id` SET TAGS ('dbx_business_glossary_term' = 'Pcn Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'engineering|manufacturing|service|planning|as_designed|as_built');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `conflict_minerals_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `critical_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `engineering_change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `eol_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Explosion Type');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_value_regex' = 'single_level|multi_level|summarized');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `external_bom_reference` SET TAGS ('dbx_business_glossary_term' = 'External Bill of Materials (BOM) ID');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `ltb_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Notification Date');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Revision');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Percentage');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `total_component_count` SET TAGS ('dbx_business_glossary_term' = 'Total Component Count');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Material Cost');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `usage` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Usage');
ALTER TABLE `semiconductors_ecm`.`product`.`bom` ALTER COLUMN `usage` SET TAGS ('dbx_value_regex' = 'production|costing|engineering|maintenance|sales');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'structure_definition');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Component Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `parent_line_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent BOM Line Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `approved_substitute_part_numbers` SET TAGS ('dbx_business_glossary_term' = 'Approved Substitute Part Numbers');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `assembly_process_code` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Code');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `bom_level` SET TAGS ('dbx_business_glossary_term' = 'BOM Level');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `component_part_number` SET TAGS ('dbx_business_glossary_term' = 'Component Part Number');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `conflict_minerals_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Status');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `conflict_minerals_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_applicable');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `critical_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `ear_eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN)');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `effectivity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity End Date');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `effectivity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Start Date');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `engineering_change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Number');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `make_or_buy_indicator` SET TAGS ('dbx_business_glossary_term' = 'Make or Buy Indicator');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `make_or_buy_indicator` SET TAGS ('dbx_value_regex' = 'make|buy|transfer');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Notes');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `phantom_bom_flag` SET TAGS ('dbx_business_glossary_term' = 'Phantom BOM Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `quantity_per_assembly` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Assembly');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `reference_designator` SET TAGS ('dbx_business_glossary_term' = 'Reference Designator');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `scrap_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percentage');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `single_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Source Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` SET TAGS ('dbx_subdomain' = 'lifecycle_governance');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `pcn_id` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) ID');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `change_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Agile Product Lifecycle Management (PLM) Change Order ID');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Pcn Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `product_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `affected_product_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Product List');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `automotive_qualification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Automotive Qualification Required Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'major|minor|notification_only');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `change_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Change Owner Email');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `change_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `change_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `change_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Change Owner Name');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `change_rationale` SET TAGS ('dbx_business_glossary_term' = 'Change Rationale');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `customer_approval_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Count');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `customer_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `customer_objection_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Objection Count');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `customer_response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Deadline');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `electrical_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Electrical Impact Assessment');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `environmental_compliance_impact` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Impact');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `form_fit_function_impact` SET TAGS ('dbx_business_glossary_term' = 'Form Fit Function (FFF) Impact');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `form_fit_function_impact` SET TAGS ('dbx_value_regex' = 'none|form|fit|function|multiple');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `jedec_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Joint Electron Device Engineering Council (JEDEC) Compliance Status');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `jedec_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `new_specification` SET TAGS ('dbx_business_glossary_term' = 'New Specification');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `old_specification` SET TAGS ('dbx_business_glossary_term' = 'Old Specification');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Number');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `pcn_number` SET TAGS ('dbx_value_regex' = '^PCN-[0-9]{6,10}$');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `pcn_status` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Status');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `pcn_type` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Type');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `pcn_type` SET TAGS ('dbx_value_regex' = 'process|material|package|test|design|specification');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `qualification_plan` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed|waived');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `reliability_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Reliability Impact Assessment');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `sample_request_deadline` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Deadline');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `samples_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Samples Available Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `superseded_by_pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Product Change Notification (PCN) Number');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn` ALTER COLUMN `superseded_by_pcn_number` SET TAGS ('dbx_value_regex' = '^PCN-[0-9]{6,10}$');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` SET TAGS ('dbx_subdomain' = 'lifecycle_governance');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `ltb_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Last Time Buy (LTB) Notification ID');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Ltb Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `pcn_id` SET TAGS ('dbx_business_glossary_term' = 'Pcn Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Product ID');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `actual_ltb_revenue` SET TAGS ('dbx_business_glossary_term' = 'Actual Last Time Buy (LTB) Revenue');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `actual_ltb_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `actual_ltb_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Last Time Buy (LTB) Units');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `customer_acknowledgment_deadline` SET TAGS ('dbx_business_glossary_term' = 'Customer Acknowledgment Deadline');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `customer_acknowledgment_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Acknowledgment Required');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `discontinuance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discontinuance Reason Code');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `discontinuance_reason_code` SET TAGS ('dbx_value_regex' = 'eol_lifecycle|low_demand|technology_obsolescence|supply_constraint|regulatory_compliance|cost_optimization');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `discontinuance_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Discontinuance Reason Description');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `estimated_ltb_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Last Time Buy (LTB) Revenue');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `estimated_ltb_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `estimated_ltb_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Last Time Buy (LTB) Units');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `final_order_date` SET TAGS ('dbx_business_glossary_term' = 'Final Order Date');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `final_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Final Shipment Date');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `issued_by` SET TAGS ('dbx_business_glossary_term' = 'Issued By');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|portal|direct_mail|sales_rep|distributor');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Issue Date');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_language` SET TAGS ('dbx_business_glossary_term' = 'Notification Language');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_language` SET TAGS ('dbx_value_regex' = 'ENG|CHN|JPN|KOR|GER|FRE');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Notification Number');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_value_regex' = '^LTB-[0-9]{6,10}$');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'draft|issued|acknowledged|expired|cancelled|superseded');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'standard_ltb|expedited_ltb|extended_ltb|emergency_discontinuance');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `replacement_product_qualification_required` SET TAGS ('dbx_business_glossary_term' = 'Replacement Product Qualification Required');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `total_customers_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Total Customers Acknowledged');
ALTER TABLE `semiconductors_ecm`.`product`.`ltb_notification` ALTER COLUMN `total_customers_notified` SET TAGS ('dbx_business_glossary_term' = 'Total Customers Notified');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `product_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Product Intellectual Property (IP) Core Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Silicon Area in Square Millimeters (mm²)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `design_for_testability` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Support');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `documentation_package` SET TAGS ('dbx_business_glossary_term' = 'Documentation Package');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `eda_tool_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Compatibility');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `eol_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `errata_notes` SET TAGS ('dbx_business_glossary_term' = 'Errata Notes');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `foundry_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Foundry Compatibility');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `gate_count` SET TAGS ('dbx_business_glossary_term' = 'Gate Count');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `integration_complexity` SET TAGS ('dbx_business_glossary_term' = 'Integration Complexity');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `integration_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `interface_protocol` SET TAGS ('dbx_business_glossary_term' = 'Interface Protocol');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `ip_category` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Functional Category');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `ip_core_code` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Code');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `ip_core_name` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Name');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `ip_type` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Type');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `ip_type` SET TAGS ('dbx_value_regex' = 'hard_ip|soft_ip|firm_ip');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `licensing_model` SET TAGS ('dbx_business_glossary_term' = 'Licensing Model');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `licensing_model` SET TAGS ('dbx_value_regex' = 'royalty_free|per_unit_royalty|nre_upfront|subscription|hybrid');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'development|verification|production|mature|deprecated|eol');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `low_power_modes` SET TAGS ('dbx_business_glossary_term' = 'Low Power Modes');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `ltb_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Notification Date');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost in United States Dollars (USD)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `nre_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `operating_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Operating Frequency in Megahertz (MHz)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `operating_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage in Volts (V)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `per_unit_royalty_usd` SET TAGS ('dbx_business_glossary_term' = 'Per-Unit Royalty in United States Dollars (USD)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `per_unit_royalty_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `power_consumption_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption in Milliwatts (mW)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `process_node_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Process Node Compatibility');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `reference_designs` SET TAGS ('dbx_business_glossary_term' = 'Reference Designs');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `rtl_language` SET TAGS ('dbx_business_glossary_term' = 'Register Transfer Level (RTL) Language');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `rtl_language` SET TAGS ('dbx_value_regex' = 'verilog|vhdl|systemverilog|chisel|not_applicable');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `security_features` SET TAGS ('dbx_business_glossary_term' = 'Security Features');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `support_contact` SET TAGS ('dbx_business_glossary_term' = 'Support Contact');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `support_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `temperature_range_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Range in Celsius (°C)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|silicon_proven');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core Version');
ALTER TABLE `semiconductors_ecm`.`product`.`product_ip_core` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` SET TAGS ('dbx_subdomain' = 'lifecycle_governance');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `product_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program ID');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Program Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Qualification Acceptance Criteria');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Qualification Completion Date');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Qualification Start Date');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Qualification Deviation Description');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `deviation_granted` SET TAGS ('dbx_business_glossary_term' = 'Qualification Deviation Granted');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `esd_cdm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electrostatic Discharge (ESD) Charged Device Model (CDM) Test Enabled');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `esd_cdm_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'ESD CDM Test Voltage (Volts)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `esd_hbm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electrostatic Discharge (ESD) Human Body Model (HBM) Test Enabled');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `esd_hbm_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'ESD HBM Test Voltage (Volts)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `failure_threshold_ppm` SET TAGS ('dbx_business_glossary_term' = 'Failure Threshold (Defective Parts Per Million)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `hast_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'HAST Test Duration (Hours)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `hast_enabled` SET TAGS ('dbx_business_glossary_term' = 'Highly Accelerated Stress Test (HAST) Enabled');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `hast_relative_humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'HAST Relative Humidity (Percent)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `hast_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'HAST Test Temperature (Celsius)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `htol_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'HTOL Test Duration (Hours)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `htol_enabled` SET TAGS ('dbx_business_glossary_term' = 'High Temperature Operating Life (HTOL) Test Enabled');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `htol_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'HTOL Test Temperature (Celsius)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `latchup_current_ma` SET TAGS ('dbx_business_glossary_term' = 'Latch-Up Test Current (Milliamperes)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `latchup_enabled` SET TAGS ('dbx_business_glossary_term' = 'Latch-Up Test Enabled');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `lot_count` SET TAGS ('dbx_business_glossary_term' = 'Qualification Lot Count');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Qualification Completion Date');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Qualification Start Date');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Code');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Name');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Status');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'PLANNED|IN_PROGRESS|ON_HOLD|COMPLETED|FAILED|WAIVED');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'NEW_PRODUCT|PROCESS_CHANGE|PACKAGE_CHANGE|SUPPLIER_CHANGE|REQUALIFICATION|EXTENDED_TEMP');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Qualification Engineer');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Qualification Sample Size');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `tc_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'TC Cycle Count');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `tc_enabled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Cycling (TC) Test Enabled');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `tc_max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'TC Maximum Temperature (Celsius)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `tc_min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'TC Minimum Temperature (Celsius)');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `test_matrix_version` SET TAGS ('dbx_business_glossary_term' = 'Test Matrix Version');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `test_matrix_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `waiver_granted` SET TAGS ('dbx_business_glossary_term' = 'Qualification Waiver Granted');
ALTER TABLE `semiconductors_ecm`.`product`.`product_qualification_program` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Qualification Waiver Justification');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `compliance_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification ID');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Certified Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `pcn_id` SET TAGS ('dbx_business_glossary_term' = 'Pcn Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Site Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Applicable Markets');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `applicable_regions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regions');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `automotive_grade_certified` SET TAGS ('dbx_business_glossary_term' = 'Automotive Grade Certified Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|suspended|revoked|under_review');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `conflict_minerals_declaration` SET TAGS ('dbx_business_glossary_term' = 'Conflict Minerals Declaration');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `customer_specific_requirement` SET TAGS ('dbx_business_glossary_term' = 'Customer-Specific Requirement');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `customer_specific_requirement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR (Export Administration Regulations) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `environmental_standard` SET TAGS ('dbx_business_glossary_term' = 'Environmental Management Standard');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `functional_safety_level` SET TAGS ('dbx_business_glossary_term' = 'Functional Safety Level');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `hazardous_substance_declaration` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Declaration');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `internal_owner` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR (International Traffic in Arms Regulations) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `quality_management_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Management Standard');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH (Registration Evaluation Authorization and Restriction of Chemicals) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency in Months');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `recertification_required` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `recertification_trigger_events` SET TAGS ('dbx_business_glossary_term' = 'Recertification Trigger Events');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `restricted_countries` SET TAGS ('dbx_business_glossary_term' = 'Restricted Countries');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `restricted_countries` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS (Restriction of Hazardous Substances) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `supporting_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation URL');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `test_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Test Laboratory');
ALTER TABLE `semiconductors_ecm`.`product`.`compliance_cert` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` SET TAGS ('dbx_subdomain' = 'lifecycle_governance');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `errata_id` SET TAGS ('dbx_business_glossary_term' = 'Errata Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Customer Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `pcn_id` SET TAGS ('dbx_business_glossary_term' = 'Pcn Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Errata Regulatory Filing Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `affected_revisions` SET TAGS ('dbx_business_glossary_term' = 'Affected Silicon Revisions');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `affected_use_cases` SET TAGS ('dbx_business_glossary_term' = 'Affected Use Cases');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Assessment');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'fixed_in_silicon|fixed_in_software|workaround_sufficient|product_eol|not_reproducible|working_as_designed');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `customer_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Disclosure Status');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `customer_disclosure_status` SET TAGS ('dbx_value_regex' = 'not_disclosed|pending_approval|disclosed_nda|disclosed_public');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Disclosure Date');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `discovered_by` SET TAGS ('dbx_business_glossary_term' = 'Discovery Source');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `discovered_by` SET TAGS ('dbx_value_regex' = 'internal_validation|customer_report|field_failure|design_verification');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `discovered_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `engineering_owner` SET TAGS ('dbx_business_glossary_term' = 'Engineering Owner');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `errata_number` SET TAGS ('dbx_business_glossary_term' = 'Errata Number');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `errata_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}-[0-9]{3,6}$');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `errata_status` SET TAGS ('dbx_business_glossary_term' = 'Errata Status');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `errata_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|confirmed|disclosed|resolved|closed');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `fix_plan` SET TAGS ('dbx_business_glossary_term' = 'Fix Plan');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `fix_plan` SET TAGS ('dbx_value_regex' = 'next_silicon_revision|software_patch|no_fix_planned|under_evaluation');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `fix_target_revision` SET TAGS ('dbx_business_glossary_term' = 'Fix Target Silicon Revision');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `fix_target_revision` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{1,2}$');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `functional_block` SET TAGS ('dbx_business_glossary_term' = 'Functional Block');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `impacted_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted Customer Count');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Engineering Notes');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Assessment');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `silicon_revision` SET TAGS ('dbx_business_glossary_term' = 'Silicon Revision');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `silicon_revision` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{1,2}$');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `symptom_description` SET TAGS ('dbx_business_glossary_term' = 'Symptom Description');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Errata Title');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Completion Date');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|in_progress|verified|cannot_reproduce');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `workaround_available` SET TAGS ('dbx_business_glossary_term' = 'Workaround Available Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `workaround_description` SET TAGS ('dbx_business_glossary_term' = 'Workaround Description');
ALTER TABLE `semiconductors_ecm`.`product`.`errata` ALTER COLUMN `workaround_performance_impact` SET TAGS ('dbx_business_glossary_term' = 'Workaround Performance Impact');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` SET TAGS ('dbx_subdomain' = 'structure_definition');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `configuration_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `overridden_configuration_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `applicable_market` SET TAGS ('dbx_business_glossary_term' = 'Applicable Market');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `automotive_qualified` SET TAGS ('dbx_business_glossary_term' = 'Automotive Qualification Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `configuration_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Description');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `configuration_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Status');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `configuration_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `constraint_expression` SET TAGS ('dbx_business_glossary_term' = 'Constraint Expression');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule Code');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `is_default_rule` SET TAGS ('dbx_business_glossary_term' = 'Default Rule Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Notes');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `option_dependencies` SET TAGS ('dbx_business_glossary_term' = 'Option Dependencies');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'BGA|QFN|LGA|CSP|WLCSP|DIP');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Priority');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Qualification Level');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `qualification_level` SET TAGS ('dbx_value_regex' = 'standard|qualified|high_reliability|automotive|space');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Code');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Name');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `rule_owner` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Owner');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Type');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'package|speed|temperature|voltage|qualification|composite');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Rule Version');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `speed_grade` SET TAGS ('dbx_business_glossary_term' = 'Speed Grade');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `speed_grade` SET TAGS ('dbx_value_regex' = 'low|mid|high|ultra');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `temperature_range` SET TAGS ('dbx_value_regex' = 'commercial|industrial|extended|military');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `voltage_variant` SET TAGS ('dbx_business_glossary_term' = 'Voltage Variant');
ALTER TABLE `semiconductors_ecm`.`product`.`configuration_rule` ALTER COLUMN `voltage_variant` SET TAGS ('dbx_value_regex' = '1.0V|1.2V|1.5V|1.8V|2.5V');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` SET TAGS ('dbx_association_edges' = 'product.pcn,product.sku');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `pcn_impact_id` SET TAGS ('dbx_business_glossary_term' = 'PCN Impact Identifier');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `pcn_id` SET TAGS ('dbx_business_glossary_term' = 'Pcn Impact - Pcn Id');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Pcn Impact - Sku Id');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `customer_approval_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Count');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `customer_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `customer_objection_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Objection Count');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `customer_response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Deadline');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy Date');
ALTER TABLE `semiconductors_ecm`.`product`.`pcn_impact` ALTER COLUMN `sku_specific_impact_notes` SET TAGS ('dbx_business_glossary_term' = 'SKU-Specific Impact Notes');
