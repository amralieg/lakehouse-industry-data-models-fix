-- Schema for Domain: product | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`product` COMMENT 'Authoritative catalog of all commercial offerings — sequencing platforms, array products, gene-editing tools (CRISPR), reagent kits, consumables, bioinformatics software licenses, and services. Owns SKU definitions, BOM linkages, product specifications, regulatory classifications (RUO/IVD/CE-IVD), ASP, and product lifecycle stages from R&D through commercialization and end-of-life.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`catalog_item` (
    `catalog_item_id` BIGINT COMMENT 'Unique identifier for the catalog item. Primary key for the catalog item master record.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to product.bundle. Business justification: Catalog items that are bundles need a direct reference to the bundle definition to avoid siloing; this FK enables navigation from a catalog item to its bundle and consolidates bundle‑specific attribut',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Product development and manufacturing costs are tracked by cost center for margin analysis, profitability reporting, and transfer pricing in genomics companies. Essential for product-level P&L and cos',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Catalog items belong to product families for hierarchical organization and reporting. Currently product_family and product_line are stored as STRING attributes on catalog_item (denormalized). Adding p',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Sequencing kits, arrays, and analysis software are designed and validated for specific reference genomes (hg38, GRCh37, mm10). Required for product specifications, regulatory submissions (FDA 510k, IV',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Clinical interpretation products and variant calling pipelines are validated against specific variant databases (ClinVar, gnomAD, COSMIC). Critical for IVD regulatory clearances, clinical validation s',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Product managers track which R&D project originated each commercial product for IP traceability, regulatory submission lineage, technology transfer documentation, and lifecycle planning. Essential for',
    `average_selling_price` DECIMAL(18,2) COMMENT 'Average price at which the product is sold across all channels and customer segments. Used for revenue forecasting, pricing strategy, and competitive analysis. Expressed in USD.',
    `bom_reference` STRING COMMENT 'Reference identifier linking to the Bill of Materials in the manufacturing system (SAP PP) defining component parts and assembly instructions. Applicable primarily to instruments and kits.',
    `bundle_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied when products are purchased as part of a bundle versus individual purchase. Nullable for non-bundle items. Used for bundle pricing calculations.',
    `bundle_eligibility_rules` STRING COMMENT 'Business rules defining which customer segments, regions, or purchase conditions qualify for bundle pricing. Nullable for non-bundle items.',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'Direct cost to manufacture or procure the product including materials, labor, and allocated overhead. Used for margin analysis, pricing decisions, and profitability reporting. Expressed in USD.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the product is manufactured or assembled. Required for customs compliance and trade reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the catalog item record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing and cost fields. Typically USD for US-based operations but may vary for regional products.. Valid values are `^[A-Z]{3}$`',
    `end_of_life_date` DATE COMMENT 'Date when the product will no longer be sold or supported. Nullable for active products. Triggers customer communication, inventory liquidation, and support transition planning.',
    `gmp_classification` STRING COMMENT 'Indicates whether the product is manufactured under Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), or other quality standards. Critical for pharmaceutical and clinical applications.. Valid values are `GMP|non-GMP|GLP|not_applicable`',
    `harmonized_tariff_code` STRING COMMENT 'International trade classification code used for customs declarations, import/export documentation, and tariff calculation. Required for cross-border shipments.. Valid values are `^[0-9]{6,10}$`',
    `hazmat_classification` STRING COMMENT 'Classification code for hazardous materials shipping and handling requirements per DOT/IATA regulations. Null for non-hazardous products. Drives special handling, labeling, and shipping restrictions.',
    `instrument_platform_compatibility` STRING COMMENT 'List of instrument platforms with which this reagent, consumable, or software is compatible. Applicable to reagents, flow cells, and bioinformatics software. Null for instruments and services.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the product is currently active and available for sale. False for discontinued or end-of-life products. Used to filter active catalog for customer-facing systems.',
    `is_bundle` BOOLEAN COMMENT 'Indicates whether this catalog item is a bundle of multiple products sold together as a package. True for bundles, False for individual products.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the catalog item record was most recently updated. Used for change tracking, audit trail, and data synchronization.',
    `launch_date` DATE COMMENT 'Date when the product was first made commercially available to customers. Used for lifecycle analysis, revenue forecasting, and market performance tracking.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the product lifecycle from initial concept through end-of-life. Drives business decisions on investment, marketing, manufacturing, and support. [ENUM-REF-CANDIDATE: concept|development|validation|launch|growth|maturity|decline|end_of_life — 8 candidates stripped; promote to reference product]',
    `list_price` DECIMAL(18,2) COMMENT 'Standard catalog price before any discounts, promotions, or volume adjustments. The baseline price used for discount calculations and contract negotiations. Expressed in USD.',
    `manufacturer_part_number` STRING COMMENT 'Internal manufacturing part number used in production planning, quality control, and supply chain systems. May differ from customer-facing SKU.',
    `marketing_tagline` STRING COMMENT 'Brief marketing message or slogan associated with the product for promotional campaigns and brand positioning.',
    `product_category` STRING COMMENT 'Primary classification of the product type defining its fundamental nature and business treatment. Determines applicable regulatory requirements, revenue recognition rules, and supply chain handling. [ENUM-REF-CANDIDATE: instrument|reagent|consumable|software|service|bundle|array|gene_editing_tool — 8 candidates stripped; promote to reference product]',
    `product_description` STRING COMMENT 'Comprehensive description of the product including technical specifications, intended use, key features, and benefits. Used for catalog documentation and customer communication.',
    `product_name` STRING COMMENT 'Full commercial name of the product as it appears in marketing materials, catalogs, and customer-facing documentation.',
    `product_url` STRING COMMENT 'Web address linking to the product detail page on the company website or customer portal for additional information and specifications.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$`',
    `read_length` STRING COMMENT 'Maximum read length in base pairs that the sequencing product can generate. Applicable to sequencing reagents and flow cells. Null for non-sequencing products.',
    `regulatory_classification` STRING COMMENT 'Regulatory designation defining the intended use and compliance requirements. RUO (Research Use Only) for laboratory research, IVD (In Vitro Diagnostic) for FDA-cleared clinical use, CE-IVD for European clinical use, LDT (Laboratory Developed Test) for CLIA-certified lab use.. Valid values are `RUO|IVD|CE-IVD|LDT`',
    `requires_cold_chain` BOOLEAN COMMENT 'Indicates whether the product requires temperature-controlled logistics (cold chain) during shipping and storage. True for temperature-sensitive reagents and biological materials.',
    `sequencing_chemistry` STRING COMMENT 'Type of sequencing chemistry used by the product (e.g., SBS - Sequencing by Synthesis, nanopore, pyrosequencing). Applicable to sequencing reagents and instruments. Null for non-sequencing products.',
    `service_contract_available` BOOLEAN COMMENT 'Indicates whether extended service contracts or maintenance agreements are available for purchase. Typically True for instruments, False for consumables.',
    `shelf_life_days` STRING COMMENT 'Number of days the product remains usable from manufacturing date under specified storage conditions. Critical for reagents, consumables, and biological materials. Null for non-perishable items.',
    `short_name` STRING COMMENT 'Abbreviated product name for use in constrained display contexts such as mobile interfaces, reports, and order forms.',
    `sku` STRING COMMENT 'Unique alphanumeric code identifying the commercial product offering. The canonical business identifier used across all systems for product identification, ordering, and inventory management.. Valid values are `^[A-Z0-9]{8,20}$`',
    `software_license_type` STRING COMMENT 'Type of software licensing model for bioinformatics and analysis software products. Defines usage rights, renewal requirements, and pricing structure. Null for non-software products.. Valid values are `perpetual|subscription|concurrent|node_locked|floating|trial`',
    `storage_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius allowed for proper product storage. Critical for reagents and biological materials. Null for products without temperature requirements.',
    `storage_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius required for proper product storage. Critical for reagents and biological materials. Null for products without temperature requirements.',
    `throughput_capacity` STRING COMMENT 'Maximum data generation capacity or processing throughput of the product (e.g., 6 Tb per run for sequencers, 12 samples per run for arrays). Applicable to instruments and high-throughput reagents.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the product is sold and inventoried (e.g., each for instruments, kit for reagent kits, license for software, run for sequencing services). [ENUM-REF-CANDIDATE: each|kit|pack|box|liter|milliliter|gram|license|hour|run|test — 11 candidates stripped; promote to reference product]',
    `warranty_period_months` STRING COMMENT 'Duration of the standard manufacturer warranty in months. Applicable primarily to instruments and equipment. Null for consumables and services.',
    CONSTRAINT pk_catalog_item PRIMARY KEY(`catalog_item_id`)
) COMMENT 'Authoritative master record for every commercial offering in the Genomics Biotech portfolio — sequencing platforms (NovaSeq/NextSeq-class instruments), array products, CRISPR gene-editing tools, reagent kits, consumables, bioinformatics software licenses, professional services, and commercial bundles. Owns the canonical SKU, product name, product family, product line, product category (instrument/reagent/software/service/consumable/bundle), regulatory use classification (RUO/IVD/CE-IVD/LDT), product description, short description, marketing tagline, product URL, launch date, end-of-life date, current lifecycle stage (concept/development/launch/growth/maturity/EOL), lifecycle stage history, and bundle-specific attributes (discount percentage, eligibility rules) where applicable. This is the SSOT for all product identity across the enterprise.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the SKU record. Primary key.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the parent product catalog item that this SKU represents a specific orderable variant of (e.g., a specific flow cell configuration, kit pack size, or software license tier).',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Procurement operations track preferred/approved suppliers per SKU for sourcing decisions, supplier performance evaluation, and supply chain risk management. Critical for reagent/consumable procurement',
    `replacement_sku_id` BIGINT COMMENT 'Reference to the successor SKU that replaces this SKU when discontinued. Used for customer migration planning and order substitution workflows.',
    `average_selling_price_usd` DECIMAL(18,2) COMMENT 'Average selling price of the SKU in USD, used for revenue forecasting, pricing analytics, and financial planning. Actual transaction prices may vary by customer, volume, and contract terms.',
    `configuration` STRING COMMENT 'Specific configuration or variant details distinguishing this SKU from other SKUs of the same product (e.g., 8-plex flow cell, 96-sample kit, 2x150bp read length, single-user license).',
    `country_availability` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this SKU is approved for sale and distribution (e.g., USA,CAN,GBR,DEU,JPN). Reflects regulatory clearances and market authorizations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU record was first created in the system. Used for audit trail and data lineage tracking.',
    `discontinuation_date` DATE COMMENT 'Date when the SKU was or will be discontinued and removed from active sales. Null if the SKU is still active. Used for end-of-life planning and customer communication.',
    `export_control_classification` STRING COMMENT 'Export Control Classification Number (ECCN) or equivalent export control designation for compliance with international trade regulations (e.g., US EAR, EU Dual-Use Regulation). Determines export licensing requirements.',
    `gtin` STRING COMMENT 'GS1 Global Trade Item Number (GTIN-8, GTIN-12, GTIN-13, or GTIN-14) for global supply chain identification and barcode scanning.. Valid values are `^[0-9]{8,14}$`',
    `harmonized_tariff_code` STRING COMMENT 'Harmonized System (HS) or Harmonized Tariff Schedule (HTS) code for international trade classification, customs clearance, and duty calculation.. Valid values are `^[0-9]{6,10}$`',
    `introduction_date` DATE COMMENT 'Date when the SKU was first made available for sale or distribution. Marks the beginning of the SKU lifecycle.',
    `is_bundle_component` BOOLEAN COMMENT 'Indicates whether this SKU is sold as part of a bundle or kit (true) or as a standalone item (false). Used to manage Bill of Materials (BOM) relationships.',
    `is_hazardous_material` BOOLEAN COMMENT 'Indicates whether the SKU contains hazardous materials requiring special handling, labeling, and shipping compliance (e.g., flammable reagents, biohazards). Triggers Safety Data Sheet (SDS) requirements.',
    `is_orderable` BOOLEAN COMMENT 'Indicates whether the SKU is currently available for customer orders. True if orderable, false if blocked for ordering (e.g., due to regulatory hold, supply constraint, or discontinuation).',
    `is_shippable` BOOLEAN COMMENT 'Indicates whether the SKU is a physical item that requires shipping (true) or a non-physical item such as a software license or service (false).',
    `last_order_date` DATE COMMENT 'Final date by which customers may place orders for a discontinued SKU. Typically precedes the discontinuation date to allow for final production and fulfillment.',
    `lead_time_days` STRING COMMENT 'Standard number of days from order placement to shipment or delivery. Used for customer expectation setting, inventory planning, and order promising.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the SKU: active (orderable and shippable), inactive (temporarily unavailable), discontinued (end-of-life announced), pending launch (approved but not yet released), obsolete (no longer supported).. Valid values are `active|inactive|discontinued|pending_launch|obsolete`',
    `list_price_usd` DECIMAL(18,2) COMMENT 'Published list price of the SKU in USD before discounts, volume pricing, or contract adjustments. Used as baseline for pricing negotiations and discount calculations.',
    `manufacturer_part_number` STRING COMMENT 'Internal manufacturer part number used in production, engineering, and quality systems. May differ from customer-facing SKU code.',
    `minimum_order_quantity` STRING COMMENT 'Minimum number of units that must be ordered in a single transaction. Used to enforce order minimums for manufacturing efficiency or distributor agreements.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified the SKU record. Used for audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU record was last updated. Used for change tracking, audit trail, and data synchronization.',
    `order_multiple` STRING COMMENT 'Quantity increment in which the SKU must be ordered (e.g., order multiple of 10 means orders must be in quantities of 10, 20, 30, etc.). Used to align with packaging or manufacturing batch sizes.',
    `pack_size` STRING COMMENT 'Number of units or samples included in one orderable pack (e.g., 96 for a 96-sample kit, 1 for a single instrument, 10 for a 10-pack of flow cells).',
    `regulatory_classification` STRING COMMENT 'Regulatory status of the SKU: RUO (Research Use Only), IVD (In Vitro Diagnostic - FDA cleared), CE-IVD (Conformité Européenne In Vitro Diagnostic - EU approved), LDT (Laboratory Developed Test), or not applicable for non-diagnostic products.. Valid values are `RUO|IVD|CE-IVD|LDT|not_applicable`',
    `requires_cold_chain` BOOLEAN COMMENT 'Indicates whether the SKU requires temperature-controlled storage and shipping (e.g., reagents stored at -20°C or -80°C). Triggers cold chain logistics and monitoring.',
    `sales_channel_eligibility` STRING COMMENT 'Comma-separated list of sales channels through which this SKU may be sold: direct (direct sales force), distributor, OEM (Original Equipment Manufacturer partner), ecommerce (online store), government (public sector contracts).',
    `shelf_life_days` STRING COMMENT 'Number of days from manufacturing date that the SKU remains within specification when stored under recommended conditions. Used for expiration date calculation and inventory rotation (FEFO - First Expired First Out).',
    `sku_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the orderable, shippable, or licensable variant. Used across order management, inventory, supply chain, and customer-facing systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `sku_description` STRING COMMENT 'Human-readable description of the SKU including configuration details, pack size, and distinguishing characteristics (e.g., NovaSeq 6000 S4 Reagent Kit v1.5 - 300 cycles).',
    `sku_type` STRING COMMENT 'Classification of the SKU by product category: instrument (sequencing platforms, gene editors), reagent kit, consumable (tips, plates), flow cell, array product (genotyping arrays), software license (bioinformatics tools), service (support, training), accessory, or bundle (multi-item package). [ENUM-REF-CANDIDATE: instrument|reagent_kit|consumable|flow_cell|array_product|software_license|service|accessory|bundle — 9 candidates stripped; promote to reference product]',
    `standard_cost_usd` DECIMAL(18,2) COMMENT 'Standard manufacturing or procurement cost of the SKU in USD, used for Cost of Goods Sold (COGS) calculation, margin analysis, and inventory valuation.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum recommended storage temperature in degrees Celsius for maintaining product stability and quality (e.g., -20.00 for frozen reagents, 25.00 for room temperature items).',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum recommended storage temperature in degrees Celsius for maintaining product stability and quality (e.g., -80.00 for ultra-low temperature reagents).',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for ordering, inventory, and pricing (e.g., each, kit, box, case, liter, milliliter, pack, license, hour, run). [ENUM-REF-CANDIDATE: each|kit|box|case|liter|milliliter|pack|license|hour|run — 10 candidates stripped; promote to reference product]',
    `volume_liters` DECIMAL(18,2) COMMENT 'Volume of one unit of the SKU in liters, used for warehouse space planning, shipping container optimization, and storage capacity management.',
    `warranty_period_months` STRING COMMENT 'Duration of manufacturer warranty coverage in months from date of purchase or installation. Applicable primarily to instruments and equipment. Null for consumables and reagents.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of one unit of the SKU in kilograms, used for shipping cost calculation, freight planning, and logistics optimization.',
    `created_by` STRING COMMENT 'User identifier or system account that created the SKU record. Used for audit trail and accountability.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock Keeping Unit definition record that maps each orderable, shippable, or licensable variant of a catalog item to a unique SKU code. Captures SKU code, SKU description, unit of measure (UOM), pack size, configuration (e.g., 8-plex flow cell, 96-sample kit), country availability, sales channel eligibility (direct/distributor/OEM/ecommerce), active/inactive status, introduction date, discontinuation date, and whether the SKU is a standalone item or a bundle component. Enables order management, inventory, and supply chain to reference precise orderable units.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`family` (
    `family_id` BIGINT COMMENT 'Unique identifier for the product family. Primary key.',
    `parent_family_id` BIGINT COMMENT 'Reference to the parent product family for hierarchical multi-level product family structures. Null for top-level families.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the product family is currently active and available for sale or use. True if active, False if discontinued or inactive.',
    `application_area` STRING COMMENT 'Primary scientific or clinical application domain for the product family (e.g., Whole Genome Sequencing (WGS), Whole Exome Sequencing (WES), RNA-Seq, Single Nucleotide Polymorphism (SNP) Genotyping, Copy Number Variation (CNV) Analysis, Liquid Biopsy, Agricultural Genomics, Precision Medicine).',
    `average_selling_price_usd` DECIMAL(18,2) COMMENT 'Average selling price for products within this family, expressed in USD. Used for portfolio-level revenue planning and pricing strategy analysis.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for the product family (e.g., Sequencing Systems, Clinical Genomics, Research Solutions, Agricultural Genomics).',
    `competitive_positioning` STRING COMMENT 'Strategic positioning of the product family relative to competitors, including key differentiators and competitive advantages in the genomics-biotechnology market.',
    `created_by_user` STRING COMMENT 'User identifier or name of the person who created the product family record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product family record was first created in the system.',
    `cross_sell_affinity_score` DECIMAL(18,2) COMMENT 'Quantitative score (0.00 to 1.00) representing the likelihood of cross-sell or upsell opportunities with other product families. Used for portfolio optimization and sales strategy.',
    `data_privacy_impact_flag` BOOLEAN COMMENT 'Indicates whether the product family processes or generates data subject to privacy regulations such as HIPAA (Health Insurance Portability and Accountability Act), GDPR (General Data Protection Regulation), or NIH Genomic Data Sharing Policy. True if privacy-sensitive, False otherwise.',
    `end_of_life_date` DATE COMMENT 'Planned or actual date when the product family will be or was discontinued. Null for active families with no planned discontinuation.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the product family is subject to environmental compliance regulations such as RoHS (Restriction of Hazardous Substances), REACH (Registration, Evaluation, Authorization of Chemicals), or WEEE (Waste Electrical and Electronic Equipment). True if subject to environmental regulations, False otherwise.',
    `family_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the product family for operational and reporting purposes (e.g., SR-SEQ for Short-Read Sequencing, LR-SEQ for Long-Read Sequencing, CRISPR-EDIT for CRISPR Editing tools).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `family_description` STRING COMMENT 'Detailed business description of the product family, including its purpose, target applications, and key differentiators in the genomics-biotechnology market.',
    `family_name` STRING COMMENT 'Full business name of the product family (e.g., Next-Generation Sequencing (NGS) Platforms, Microarray Solutions, Gene Editing Tools).',
    `family_type` STRING COMMENT 'High-level classification of the product family by offering type: instrument (sequencing platforms, array scanners), reagent (library prep kits, PCR reagents), consumable (flow cells, chips), software (bioinformatics pipelines, analysis tools), service (sequencing services, technical support), or assay (clinical test kits, diagnostic panels).. Valid values are `instrument|reagent|consumable|software|service|assay`',
    `go_to_market_segment` STRING COMMENT 'Target market segment for the product family (e.g., Academic Research, Clinical Diagnostics, Pharmaceutical R&D, Agricultural Biotech, Direct-to-Consumer, Population Genomics).',
    `last_modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified the product family record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the product family record was last updated or modified.',
    `launch_date` DATE COMMENT 'Date when the product family was first commercially launched or made available to customers.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the product family lifecycle: research (early R&D), development (active development), validation (clinical or analytical validation), launch (commercialization phase), active (general availability), mature (established market presence), declining (reduced investment), discontinued (end-of-life). [ENUM-REF-CANDIDATE: research|development|validation|launch|active|mature|declining|discontinued — 8 candidates stripped; promote to reference product]',
    `patent_portfolio_reference` STRING COMMENT 'Reference to the intellectual property (IP) and patent portfolio protecting the product family technology. May include patent numbers or internal IP tracking codes.',
    `quality_management_system_scope` STRING COMMENT 'Quality management system framework governing the product family: ISO_13485 (medical devices), ISO_9001 (general quality), GMP (Good Manufacturing Practice), GLP (Good Laboratory Practice), or none for non-regulated products.. Valid values are `ISO_13485|ISO_9001|GMP|GLP|none`',
    `regulatory_classification` STRING COMMENT 'Regulatory status of the product family: RUO (Research Use Only), IVD (In Vitro Diagnostic - FDA approved), CE-IVD (Conformité Européenne In Vitro Diagnostic - EU approved), LDT (Laboratory Developed Test), or FDA device class (Class I, II, III). [ENUM-REF-CANDIDATE: RUO|IVD|CE-IVD|LDT|Class I|Class II|Class III — 7 candidates stripped; promote to reference product]',
    `sales_channel_mix` STRING COMMENT 'Primary sales and distribution channels for the product family (e.g., Direct Sales, Distributor Network, OEM (Original Equipment Manufacturer) Partnerships, E-commerce, Field Application Scientists).',
    `service_level_agreement_tier` STRING COMMENT 'Standard service level agreement tier offered with the product family: standard (basic support), premium (enhanced support and turnaround time (TAT)), enterprise (dedicated support), custom (negotiated SLA terms).. Valid values are `standard|premium|enterprise|custom`',
    `strategic_priority_tier` STRING COMMENT 'Strategic importance and investment priority assigned to the product family: tier_1 (highest priority, flagship products), tier_2 (core portfolio), tier_3 (niche or legacy), strategic (future growth driver), maintenance (sustaining mode), sunset (planned phase-out).. Valid values are `tier_1|tier_2|tier_3|strategic|maintenance|sunset`',
    `target_margin_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage for the product family, used for profitability planning and pricing decisions.',
    `technology_platform` STRING COMMENT 'Core technology or methodology underlying the product family (e.g., Sequencing by Synthesis (SBS), Nanopore Sequencing, BeadChip Array, CRISPR-Cas9, qPCR (Quantitative Polymerase Chain Reaction)).',
    `training_certification_required_flag` BOOLEAN COMMENT 'Indicates whether customer training or operator certification is required or recommended for the product family. True if training/certification is required, False otherwise.',
    CONSTRAINT pk_family PRIMARY KEY(`family_id`)
) COMMENT 'Hierarchical grouping entity that organizes catalog items into product families and product lines (e.g., Short-Read Sequencing, Long-Read Sequencing, Microarray, CRISPR Editing, Liquid Biopsy). Stores family name, family code, parent family reference for multi-level hierarchy, owning business unit, strategic priority tier, and associated go-to-market segment. Enables portfolio-level reporting, roadmap planning, and cross-sell/upsell analysis without duplicating catalog item records.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`specification` (
    `specification_id` BIGINT COMMENT 'Unique identifier for the product specification record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Product specifications for IVD genomics products (NGS panels, microarrays, CRISPR kits) must reference the regulatory approval under which performance claims are authorized. Specifications cannot exce',
    `employee_id` BIGINT COMMENT 'Reference to the user or quality manager who approved this specification version.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Technical specifications must declare validated reference genome builds for sequencing/array products. Required for regulatory submissions (FDA 510k Section 6, IVDR Annex II technical documentation), ',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.protocol. Business justification: Product specifications reference the validated protocol that established performance characteristics (LOD, accuracy, precision). Required for regulatory submissions (510k, CE-IVD dossiers), quality sy',
    `sku_id` BIGINT COMMENT 'Reference to the catalog item or SKU that this specification describes.',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: Product specifications for IVD/genomics assays require analytical and clinical validation studies for regulatory clearance (FDA 510k, CE-IVD). Validation study ID links spec to supporting evidence for',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Variant interpretation products must specify which variant databases are supported and validated. Critical for clinical validation documentation, regulatory compliance (FDA guidance on NGS-based oncol',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this specification version was formally approved for release.',
    `average_selling_price_usd` DECIMAL(18,2) COMMENT 'Average selling price of the product in USD, used for revenue planning and pricing strategy.',
    `ce_marking_status` BOOLEAN COMMENT 'Indicates whether the product carries CE marking for European market compliance. True if CE marked, False otherwise.',
    `clia_applicable_flag` BOOLEAN COMMENT 'Indicates whether the product is applicable for use in CLIA-certified clinical laboratories. True if applicable, False otherwise.',
    `cluster_density_k_per_mm2` DECIMAL(18,2) COMMENT 'Optimal cluster density in thousands of clusters per square millimeter (K/mm²) for sequencing flow cells.',
    `cnv_resolution_kb` DECIMAL(18,2) COMMENT 'Resolution of copy number variation detection in kilobases (kb) for array-based or sequencing-based CNV analysis.',
    `cost_of_goods_sold_usd` DECIMAL(18,2) COMMENT 'Manufacturing cost of goods sold per unit in USD, used for margin analysis and financial reporting.',
    `coverage_depth_min` STRING COMMENT 'Minimum recommended sequencing coverage depth (number of reads covering each base) for reliable variant calling, applicable to WGS and WES assays.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this specification record was first created in the system.',
    `crispr_target_specificity_percent` DECIMAL(18,2) COMMENT 'On-target specificity percentage for CRISPR gene-editing tools, indicating precision of genome editing.',
    `effective_date` DATE COMMENT 'Date when this specification version became effective and active for use in manufacturing, sales, and regulatory submissions.',
    `expiration_date` DATE COMMENT 'Date when this specification version is superseded or becomes obsolete. Null if currently active.',
    `flow_cell_type` STRING COMMENT 'Type or model designation of the flow cell used in the sequencing platform (e.g., S1, S2, S4, NovaSeq X).',
    `hazard_classification` STRING COMMENT 'Chemical hazard classification per GHS (Globally Harmonized System) for reagents and consumables (e.g., flammable, corrosive, toxic, non-hazardous).',
    `instrument_compatibility` STRING COMMENT 'List of compatible sequencing or array instruments for this reagent kit or consumable (e.g., NovaSeq 6000, MiSeq, NextSeq 2000).',
    `iso_13485_compliant_flag` BOOLEAN COMMENT 'Indicates whether the product is manufactured under ISO 13485 quality management system for medical devices. True if compliant, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this specification record was last updated or modified.',
    `library_compatibility` STRING COMMENT 'Compatible library preparation kits or protocols (e.g., TruSeq, Nextera, Stranded mRNA). May be a comma-separated list.',
    `lod_copies_per_ml` DECIMAL(18,2) COMMENT 'Analytical sensitivity expressed as the Limit of Detection (LOD) in copies per milliliter, applicable to qPCR and molecular diagnostic assays.',
    `multiplexing_capacity` STRING COMMENT 'Maximum number of samples that can be pooled and sequenced simultaneously in a single run using index barcodes.',
    `pcr_cycle_count` STRING COMMENT 'Recommended or maximum number of PCR amplification cycles for library preparation or qPCR assays.',
    `product_category` STRING COMMENT 'High-level classification of the product type: sequencing platform, array product, gene-editing tool (CRISPR), reagent kit, consumable, bioinformatics software license, or service. [ENUM-REF-CANDIDATE: sequencing_platform|array_product|gene_editing_tool|reagent_kit|consumable|bioinformatics_software|service — 7 candidates stripped; promote to reference product]',
    `product_lifecycle_stage` STRING COMMENT 'Current stage in the product lifecycle from R&D through commercialization to end-of-life: research, development, validation, commercialization, active, mature, end-of-life, or discontinued. [ENUM-REF-CANDIDATE: research|development|validation|commercialization|active|mature|end_of_life|discontinued — 8 candidates stripped; promote to reference product]',
    `q30_score_threshold_percent` DECIMAL(18,2) COMMENT 'Minimum percentage of bases with Phred quality score ≥30 (Q30), indicating base call accuracy of 99.9%. Critical quality metric for NGS data.',
    `reaction_volume_ul` DECIMAL(18,2) COMMENT 'Standard reaction volume in microliters (µL) for reagent kits and assays.',
    `reactions_per_kit` STRING COMMENT 'Total number of reactions or tests provided in a single reagent kit package.',
    `read_length_bp` STRING COMMENT 'Sequencing read length in base pairs (bp) for NGS platforms. Applicable to sequencing instruments and reagent kits.',
    `regulatory_classification` STRING COMMENT 'Regulatory status of the product: Research Use Only (RUO), In Vitro Diagnostic (IVD), Conformité Européenne In Vitro Diagnostic (CE-IVD), Laboratory Developed Test (LDT), or FDA device class (I, II, III). [ENUM-REF-CANDIDATE: RUO|IVD|CE_IVD|LDT|Class_I|Class_II|Class_III — 7 candidates stripped; promote to reference product]',
    `shelf_life_days` STRING COMMENT 'Product shelf life or expiration period in days from manufacturing date, applicable to reagents and consumables.',
    `snp_array_probe_count` STRING COMMENT 'Total number of SNP probes on the array product, indicating genotyping capacity.',
    `software_version_compatibility` STRING COMMENT 'Compatible software versions or bioinformatics pipeline versions required to process data from this product (e.g., BaseSpace v2.0+, DRAGEN 3.9+).',
    `specification_name` STRING COMMENT 'Human-readable name or title of the product specification document.',
    `specification_status` STRING COMMENT 'Current lifecycle status of the specification document: draft, under review, approved, active, obsolete, or superseded by a newer version.. Valid values are `draft|under_review|approved|active|obsolete|superseded`',
    `storage_temperature_c` STRING COMMENT 'Required storage temperature or temperature range in degrees Celsius for reagents and consumables (e.g., -20°C, 2-8°C, room temperature).',
    `throughput_gb_per_run` DECIMAL(18,2) COMMENT 'Data output capacity in gigabases (Gb) per sequencing run. Key performance metric for sequencing platforms.',
    `turnaround_time_hours` STRING COMMENT 'Expected turnaround time in hours from sample input to result output for sequencing runs or assays.',
    `version` STRING COMMENT 'Version identifier for this specification document, following semantic versioning (e.g., 1.0, 2.1.3).. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_specification PRIMARY KEY(`specification_id`)
) COMMENT 'Technical and performance specification sheet for a catalog item or SKU. Captures instrument/reagent/software specifications including read length (bp), throughput (Gb/run), flow cell type, cluster density, Q30 score threshold, library compatibility, storage temperature, shelf life (days), hazard classification, CE marking status, ISO 13485 compliance flag, CLIA applicability, and software version compatibility matrix. Serves as the authoritative technical datasheet referenced by field application scientists, regulatory submissions, and quality teams.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`product_bom` (
    `product_bom_id` BIGINT COMMENT 'Unique identifier for the bill of materials record. Primary key for the BOM entity.',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: BOM changes (component substitutions, formulation modifications, supplier changes) require change control in GMP/QMS environments. Links BOM revision to change control for impact assessment, validatio',
    `sku_id` BIGINT COMMENT 'Reference to the component material, sub-assembly, reagent, consumable, or bundled SKU that is part of this BOM. Links to the product master record.',
    `tertiary_product_substitute_component_sku_id` BIGINT COMMENT 'Reference to an alternative component that can be used in place of the primary component. Supports supply chain flexibility and risk mitigation.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved this BOM for production use. Required for design control and quality management compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM was approved for production use. Critical for regulatory traceability and design control.',
    `assembly_instruction` STRING COMMENT 'Textual description of how this component should be assembled, installed, or integrated into the parent product. May reference work instructions, SOPs, or engineering drawings.',
    `backflush_indicator` BOOLEAN COMMENT 'Flag indicating whether this component is backflushed (automatically consumed upon production confirmation) rather than manually issued. True if backflushed, false if manual issue.',
    `bom_number` STRING COMMENT 'Business identifier for the BOM. Human-readable unique code used in manufacturing, engineering, and supply chain systems.',
    `bom_status` STRING COMMENT 'Current lifecycle state of the BOM: draft (under development), active (approved for use), superseded (replaced by newer version), obsolete (no longer valid), frozen (locked for regulatory compliance).. Valid values are `draft|active|superseded|obsolete|frozen`',
    `bom_type` STRING COMMENT 'Classification of the BOM purpose: production (manufacturing execution), engineering (design specification), costing (cost rollup), commercial-bundle (solution-selling package), service (field service parts), or planning (supply chain planning).. Valid values are `production|engineering|costing|commercial_bundle|service|planning`',
    `change_order_number` STRING COMMENT 'Reference to the engineering change order (ECO) or change request that authorized this BOM version or component change. Critical for design control and audit trails.',
    `co_product_indicator` BOOLEAN COMMENT 'Flag indicating whether this item is a co-product (additional output) rather than a component input. True if co-product, false if component.',
    `component_position` STRING COMMENT 'Sequential position or item number of this component within the BOM structure. Used for ordering and assembly instructions.',
    `component_quantity` DECIMAL(18,2) COMMENT 'Quantity of the component material required to produce one unit of the parent product. Supports fractional quantities for reagents and consumables.',
    `cost_rollup_method` STRING COMMENT 'Costing methodology used to calculate the component cost contribution to the parent product: standard (predetermined cost), average (moving average), FIFO (first-in-first-out), LIFO (last-in-first-out), or actual (transaction-based).. Valid values are `standard|average|fifo|lifo|actual`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM record was first created in the system. Part of audit trail for regulatory compliance.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied when this component is part of a commercial bundle. Used for solution-selling pricing strategies and promotional offers.',
    `effective_end_date` DATE COMMENT 'Date after which this BOM or component relationship is no longer valid. Null indicates open-ended validity.',
    `effective_start_date` DATE COMMENT 'Date from which this BOM or component relationship becomes valid and can be used in production or commercial transactions.',
    `eligibility_rules` STRING COMMENT 'Business rules or conditions that determine when this component is included in the BOM. May reference customer segments, geographic regions, regulatory classifications, or product configurations.',
    `is_critical_component` BOOLEAN COMMENT 'Flag indicating whether this component is critical for product functionality, regulatory compliance, or supply chain risk. True if critical, false otherwise.',
    `is_phantom_assembly` BOOLEAN COMMENT 'Flag indicating whether this component is a phantom (transient sub-assembly that is not stocked). True if phantom, false if physical inventory item.',
    `lead_time_offset_days` STRING COMMENT 'Number of days before the parent product start date that this component must be available. Used for backward scheduling in production planning.',
    `lot_traceability_required` BOOLEAN COMMENT 'Flag indicating whether lot-level traceability is required for this component per regulatory or quality requirements. True if lot tracking is mandatory, false otherwise.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this BOM record. Part of audit trail for regulatory compliance and change control.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM record was last modified. Part of audit trail for regulatory compliance and change control.',
    `notes` STRING COMMENT 'Free-text notes or comments about this BOM or component relationship. May include special handling instructions, quality requirements, or supply chain considerations.',
    `operation_sequence` STRING COMMENT 'Routing operation number at which this component is consumed. Links BOM items to production routing steps.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility where this BOM is used. Supports multi-site manufacturing and plant-specific BOMs.',
    `regulatory_classification` STRING COMMENT 'Regulatory status of the BOM or component: RUO (Research Use Only), IVD (In Vitro Diagnostic), CE-IVD (European IVD), LDT (Laboratory Developed Test), GMP (Good Manufacturing Practice), or non-regulated.. Valid values are `RUO|IVD|CE_IVD|LDT|GMP|non_regulated`',
    `scrap_factor_percent` DECIMAL(18,2) COMMENT 'Expected waste or loss percentage for this component during manufacturing. Used for material requirements planning (MRP) and cost rollup calculations.',
    `unit_of_measure` STRING COMMENT 'Unit in which the component quantity is expressed (e.g., EA for each, L for liters, ML for milliliters, G for grams, KG for kilograms). Aligns with ISO 80000 standards.',
    `version` STRING COMMENT 'Version identifier for the BOM. Tracks engineering changes and revisions over time. Critical for regulatory traceability and change control.',
    `work_center_code` STRING COMMENT 'Production work center or assembly station where this component is consumed or installed. Links BOM to routing operations.',
    `created_by` STRING COMMENT 'User identifier of the person who created this BOM record. Part of audit trail for regulatory compliance and change control.',
    CONSTRAINT pk_product_bom PRIMARY KEY(`product_bom_id`)
) COMMENT 'Bill of Materials header record linking a finished-goods catalog item, SKU, or commercial bundle to its component materials, sub-assemblies, reagents, packaging, or bundled SKUs. Stores BOM number, BOM type (production/engineering/costing/commercial-bundle), component item reference, component quantity, unit of measure, lead time offset, scrap factor, effective date range, discount percentage (for commercial bundles), eligibility rules, and BOM status (active/superseded/draft). Critical for manufacturing cost rollup, supply planning, regulatory traceability of component lots, and commercial bundle definition with solution-selling go-to-market strategies.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Unique identifier for the BOM line item. Primary key for the BOM line entity.',
    `sku_id` BIGINT COMMENT 'FK to product.sku',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Individual BOM line changes (component specification updates, alternative suppliers, quantity adjustments) require change control for traceability. Links component-level changes to formal change manag',
    `employee_id` BIGINT COMMENT 'Reference to the user (engineer, quality manager, or authorized approver) who approved this BOM line for production use. Required for GMP and ISO 13485 compliance.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Software/data components in BOMs (reference genome indices, annotation files) must track specific assembly versions for lot traceability and change control. Required for ISO 13485 design control, 21 C',
    `primary_bom_sku_id` BIGINT COMMENT 'Reference to the product master record for the component material, sub-assembly, reagent, consumable, or service item required in this BOM line.',
    `product_bom_id` BIGINT COMMENT 'Reference to the parent BOM header that this line belongs to. Links the component line to the finished good or assembly BOM.',
    `alternative_item_group` STRING COMMENT 'Identifier for a group of interchangeable components that can substitute for one another in the BOM. Enables flexible sourcing and component substitution management during production or supply shortages.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line was approved for production use. Part of the design control and change management audit trail.',
    `assembly_instruction` STRING COMMENT 'Free-text field containing specific assembly, handling, or usage instructions for this component. Used by manufacturing operators and documented in work instructions and SOPs.',
    `bom_line_status` STRING COMMENT 'Current lifecycle status of the BOM line: active (in production use), inactive (temporarily disabled), pending_approval (awaiting engineering or quality approval), obsolete (phased out, retained for historical reference).. Valid values are `active|inactive|pending_approval|obsolete`',
    `component_cost` DECIMAL(18,2) COMMENT 'Standard unit cost of the component material. Used for BOM cost rollup, COGS calculation, and product profitability analysis. Confidential business data.',
    `component_role` STRING COMMENT 'Functional role of the component within a commercial bundle or product offering. Used for revenue allocation, customer communication, and bundle composition analysis. [ENUM-REF-CANDIDATE: primary_instrument|reagent|consumable|software|accessory|service|documentation — 7 candidates stripped; promote to reference product]',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the component cost (e.g., USD, EUR, GBP). Enables multi-currency BOM costing for global manufacturing operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line record was first created in the system. Used for audit trail and change tracking.',
    `critical_component_flag` BOOLEAN COMMENT 'Indicates whether this component is critical to product performance, safety, or regulatory compliance. Critical components require enhanced quality control, supplier qualification, and change control procedures.',
    `engineering_change_number` STRING COMMENT 'Reference to the engineering change order or document control number that authorized the addition, modification, or removal of this component in the BOM. Critical for traceability and regulatory compliance.',
    `expiry_control_required_flag` BOOLEAN COMMENT 'Indicates whether expiration date tracking is required for this component. Essential for reagents, biological materials, and consumables with limited shelf life.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the component is classified as a hazardous material requiring special handling, storage, and documentation (SDS, shipping labels, disposal procedures).',
    `item_category` STRING COMMENT 'Classification of the component type within the BOM structure: raw_material (base chemicals, reagents), semi_finished (sub-assemblies, intermediate products), packaging (boxes, labels, inserts), phantom (logical grouping without inventory), bundle_component (commercial bundle item), service (installation, training, support).. Valid values are `raw_material|semi_finished|packaging|phantom|bundle_component|service`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line record was last updated. Used for audit trail, change tracking, and synchronization with downstream systems.',
    `lead_time_offset_days` STRING COMMENT 'Number of days before the production start date that this component must be available. Used for material requirements planning (MRP) and procurement scheduling.',
    `line_number` STRING COMMENT 'Sequential line number within the parent BOM, used for ordering and referencing specific component positions in the assembly structure.',
    `lot_control_required_flag` BOOLEAN COMMENT 'Indicates whether lot number tracking is required for this component. Critical for reagents, consumables, and materials subject to GMP, traceability, and recall management.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this component is mandatory for the finished product or optional. Optional components may be included based on customer configuration or production variant.',
    `reference_designator` STRING COMMENT 'Alphanumeric code identifying the physical location or position of the component in the assembly (e.g., R1, C5, U3 for electronics; position codes for mechanical assemblies). Used in assembly drawings and work instructions.',
    `regulatory_classification` STRING COMMENT 'Regulatory status of the component: RUO (Research Use Only), IVD (In Vitro Diagnostic), CE_IVD (CE marked IVD), GMP (Good Manufacturing Practice controlled), non_regulated. Determines handling, documentation, and quality requirements.. Valid values are `RUO|IVD|CE_IVD|GMP|non_regulated`',
    `required_quantity` DECIMAL(18,2) COMMENT 'The quantity of the component required to produce one unit of the parent finished good or assembly. Supports fractional quantities for reagents and consumables.',
    `revenue_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total bundle or product revenue allocated to this component. Used for revenue recognition, performance obligations under ASC 606, and component-level profitability analysis in commercial bundles.',
    `scrap_percentage` DECIMAL(18,2) COMMENT 'Expected scrap or waste percentage for this component during production. Used to calculate net material requirements and cost of goods sold (COGS) accurately.',
    `serial_number_control_flag` BOOLEAN COMMENT 'Indicates whether serial number tracking is required for this component. Typically applies to high-value instruments, critical sub-assemblies, and items requiring individual traceability.',
    `substitution_eligible_flag` BOOLEAN COMMENT 'Indicates whether this component can be substituted with an alternative item from the same alternative item group during production or order fulfillment.',
    `supply_type` STRING COMMENT 'Source of the component: in_house (manufactured internally), external (purchased from vendor), subcontract (manufactured by third party to our spec), customer_supplied (provided by customer for custom orders).. Valid values are `in_house|external|subcontract|customer_supplied`',
    `unit_of_measure` STRING COMMENT 'The unit in which the required quantity is expressed (e.g., EA for each, L for liters, KG for kilograms, ML for milliliters). Aligns with ISO and industry standards for laboratory and manufacturing materials.',
    `valid_from_date` DATE COMMENT 'The date from which this BOM line is effective. Supports BOM versioning, engineering changes, and time-phased component transitions.',
    `valid_to_date` DATE COMMENT 'The date until which this BOM line is effective. Null indicates the component is currently active with no planned end date. Used for component phase-out and obsolescence management.',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'Individual component line within a Bill of Materials, representing one raw material, sub-assembly, packaging item, or commercial bundle component required to produce or compose the parent finished good or bundle. Captures component SKU reference, required quantity, unit of measure, item category (raw material/semi-finished/packaging/phantom/bundle-component), component role (primary instrument/reagent/software/service for bundles), alternative item group, substitution eligibility flag, mandatory/optional flag, supply type (in-house/external), and validity dates. Enables granular cost analysis, component substitution management, lot traceability from raw material to finished product, and commercial bundle composition with revenue allocation.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`pricing` (
    `pricing_id` BIGINT COMMENT 'Unique identifier for the pricing record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Pricing approvals are a critical business control in genomics biotech, especially for regulated diagnostic products with transfer pricing and ASP reporting requirements. Approved_by is currently bare ',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU for which this pricing applies. Links to the product catalog.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the pricing record: draft (being prepared), pending_approval (submitted for review), approved (active and usable), rejected (not approved), expired (validity period ended), superseded (replaced by newer pricing).. Valid values are `draft|pending_approval|approved|rejected|expired|superseded`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing record was approved. Used for audit trail and compliance reporting.',
    `asp` DECIMAL(18,2) COMMENT 'Average Selling Price realized across all transactions for this SKU in the specified period and region. Used for revenue forecasting, margin analysis, and competitive benchmarking. Confidential business metric.',
    `contract_reference` STRING COMMENT 'Reference number of the customer contract or master agreement that governs this pricing. Null for standard list pricing. Used to link pricing to contractual commitments.',
    `cost_price` DECIMAL(18,2) COMMENT 'Cost of Goods Sold (COGS) per unit. Used for margin calculation and profitability analysis. Confidential financial data.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the price is denominated (e.g., USD, EUR, GBP, JPY, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment for this pricing tier: enterprise (large commercial accounts), mid_market, small_business, academic (universities and research institutes), government (public sector), clinical (diagnostic labs and hospitals), pharma (pharmaceutical companies), biotech (biotechnology firms). [ENUM-REF-CANDIDATE: enterprise|mid_market|small_business|academic|government|clinical|pharma|biotech — 8 candidates stripped; promote to reference product]',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Standard discount percentage applied to the list price to derive the unit price. Used for transparency in pricing calculations and margin analysis.',
    `effective_end_date` DATE COMMENT 'Date after which this pricing is no longer valid. Null for open-ended pricing. Used to manage price changes, promotions, and contract expirations.',
    `effective_start_date` DATE COMMENT 'Date from which this pricing becomes active and can be used in quotations and orders. Part of the pricing validity period.',
    `list_price` DECIMAL(18,2) COMMENT 'Standard catalog list price per unit before any discounts or adjustments. Used as the baseline for discount calculations and margin analysis.',
    `margin_percentage` DECIMAL(18,2) COMMENT 'Gross margin percentage calculated as (unit_price - cost_price) / unit_price. Used for profitability analysis and pricing strategy optimization. Confidential financial metric.',
    `minimum_order_quantity` STRING COMMENT 'Minimum number of units that must be purchased for this price to apply. Used to enforce volume thresholds and manage production efficiency.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about this pricing record, such as special terms, conditions, or rationale for pricing decisions. Used for internal documentation and knowledge transfer.',
    `owner` STRING COMMENT 'Name or identifier of the commercial operations team member responsible for maintaining this pricing record. Primary contact for pricing inquiries and updates.',
    `price_list_version` STRING COMMENT 'Version identifier of the price list or pricing schedule that contains this record. Used to manage pricing history and track price list updates.',
    `price_type` STRING COMMENT 'Classification of the pricing record: list (standard catalog price), contract (customer-specific negotiated), distributor (channel partner pricing), OEM (original equipment manufacturer pricing), government (public sector pricing), transfer (intercompany pricing), promotional (temporary campaign pricing). [ENUM-REF-CANDIDATE: list|contract|distributor|oem|government|transfer|promotional — 7 candidates stripped; promote to reference product]',
    `promotion_code` STRING COMMENT 'Unique code identifying the promotional campaign associated with this pricing. Null for non-promotional pricing. Used for campaign tracking and ROI analysis.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this pricing is part of a temporary promotional campaign (True) or standard pricing (False). Used to track promotional effectiveness and revenue impact.',
    `region_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or region code where this pricing applies (e.g., USA, GBR, DEU, CHN, JPN). Supports regional pricing strategies.. Valid values are `^[A-Z]{3}$`',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the product being priced: RUO (Research Use Only), IVD (In Vitro Diagnostic), CE-IVD (Conformité Européenne In Vitro Diagnostic), LDT (Laboratory Developed Test), GMP (Good Manufacturing Practice compliant), research_grade. Affects pricing strategy and market access.. Valid values are `ruo|ivd|ce_ivd|ldt|gmp|research_grade`',
    `sales_channel` STRING COMMENT 'Sales channel through which this pricing is offered: direct (direct sales force), distributor (channel partners), OEM (original equipment manufacturer partnerships), online (e-commerce), government (public sector contracts), academic (research institutions).. Valid values are `direct|distributor|oem|online|government|academic`',
    `transfer_price` DECIMAL(18,2) COMMENT 'Intercompany transfer price used for transactions between legal entities or business units. Used for internal cost allocation and tax compliance. Confidential.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the pricing (e.g., each for instruments, kit for reagent kits, run for sequencing services, license for software subscriptions, sample for assay services). [ENUM-REF-CANDIDATE: each|kit|box|case|liter|milliliter|gram|pack|license|run|sample — 11 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Effective selling price per unit after applying standard discounts, volume breaks, or channel adjustments. This is the operational price used in quoting and order entry.',
    `volume_tier_1_price` DECIMAL(18,2) COMMENT 'Unit price applicable when order quantity meets or exceeds volume_tier_1_quantity. Null if no volume pricing applies.',
    `volume_tier_1_quantity` STRING COMMENT 'Minimum quantity threshold for the first volume discount tier. Null if no volume pricing applies.',
    `volume_tier_2_price` DECIMAL(18,2) COMMENT 'Unit price applicable when order quantity meets or exceeds volume_tier_2_quantity. Null if tier does not exist.',
    `volume_tier_2_quantity` STRING COMMENT 'Minimum quantity threshold for the second volume discount tier. Null if tier does not exist.',
    `volume_tier_3_price` DECIMAL(18,2) COMMENT 'Unit price applicable when order quantity meets or exceeds volume_tier_3_quantity. Null if tier does not exist.',
    `volume_tier_3_quantity` STRING COMMENT 'Minimum quantity threshold for the third volume discount tier. Null if tier does not exist.',
    CONSTRAINT pk_pricing PRIMARY KEY(`pricing_id`)
) COMMENT 'Commercial pricing record defining the list price, ASP (Average Selling Price), transfer price, and tiered volume pricing for each SKU by currency, region, and sales channel. Stores price type (list/contract/distributor/OEM/government), currency code, unit price, minimum order quantity, volume break thresholds, effective start and end dates, approval status, and the pricing owner (commercial ops team). Supports revenue recognition, deal desk quoting, and margin analysis. Distinct from customer-specific contract pricing which lives in the order/agreement domain.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` (
    `regulatory_classification_id` BIGINT COMMENT 'Unique identifier for the regulatory classification record. Primary key for this entity.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the catalog product (sequencing platform, array, CRISPR tool, reagent kit, consumable, software license, or service) that this regulatory classification applies to.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory classifications (FDA device class, IVDR risk class, CE marking) require full audit trails for 21 CFR Part 11 and ISO 13485 compliance. Created_by is currently bare text; linking to employee',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: IVD regulatory submissions must specify validated reference genome(s) in technical documentation. Required for FDA 510k submissions (Section 6: Performance Characteristics), EU IVDR technical files (A',
    `submission_id` BIGINT COMMENT 'Internal tracking identifier for the regulatory submission dossier or application associated with this classification record.',
    `authorization_date` DATE COMMENT 'Date when regulatory authorization was granted by the governing authority in the specified jurisdiction. Format: yyyy-MM-dd.',
    `authorization_expiry_date` DATE COMMENT 'Date when the regulatory authorization expires and requires renewal. Null for authorizations without expiration. Format: yyyy-MM-dd.',
    `authorization_number` STRING COMMENT 'Unique authorization or clearance number assigned by the regulatory authority (e.g., FDA 510(k) number, premarket approval number, or equivalent jurisdiction-specific identifier).',
    `authorization_status` STRING COMMENT 'Current regulatory authorization status in the specified jurisdiction. Authorized (approved for market), Pending (under review), Withdrawn (voluntarily removed), Suspended (temporarily halted), Expired (authorization lapsed).. Valid values are `Authorized|Pending|Withdrawn|Suspended|Expired`',
    `biocompatibility_testing_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether biocompatibility testing per ISO 10993 series is required for regulatory approval in the jurisdiction.',
    `ce_certificate_number` STRING COMMENT 'Unique certificate number issued by the EU Notified Body for CE-IVD marked products, demonstrating conformity with EU IVDR requirements.',
    `clinical_evidence_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether clinical evidence (clinical trials, performance studies, or clinical evaluation reports) is required for regulatory authorization in this jurisdiction.',
    `controlled_substance_schedule` STRING COMMENT 'DEA controlled substance schedule if the product contains or is used with controlled substances. Applicable to certain reagents or diagnostic kits.. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Not Controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory classification record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cybersecurity_requirements_flag` BOOLEAN COMMENT 'Boolean flag indicating whether cybersecurity controls and documentation are required for regulatory submission, applicable to connected devices, software, and bioinformatics platforms.',
    `data_privacy_compliance_required` STRING COMMENT 'Comma-separated list of data privacy regulations that must be complied with for this product in the jurisdiction (e.g., HIPAA, GDPR, CCPA, PIPEDA). Applicable to products handling patient or customer data.',
    `effective_date` DATE COMMENT 'Date when this regulatory classification record becomes effective and applicable for commercial operations. Format: yyyy-MM-dd.',
    `environmental_compliance_required` STRING COMMENT 'Comma-separated list of environmental regulations applicable to the product (e.g., RoHS, REACH, WEEE) for manufacturing, distribution, and disposal in the jurisdiction.',
    `export_control_classification` STRING COMMENT 'Export control classification number (ECCN) or equivalent for products subject to export restrictions (e.g., gene-editing tools, high-throughput sequencers with dual-use potential).',
    `fda_device_class` STRING COMMENT 'FDA device classification under 21 CFR for US market. Class I (low risk, general controls), Class II (moderate risk, special controls), Class III (high risk, premarket approval required), or Not Applicable for non-device products or non-US jurisdictions.. Valid values are `Class I|Class II|Class III|Not Applicable`',
    `fda_product_code` STRING COMMENT 'Three-letter FDA product code assigned to the device type for classification and regulatory tracking purposes in the US market.',
    `gmdn_code` STRING COMMENT 'Five-digit GMDN code providing internationally recognized nomenclature for medical devices. Used for regulatory submissions and device identification across jurisdictions.',
    `gmdn_term_name` STRING COMMENT 'Human-readable GMDN term name corresponding to the GMDN code, describing the device type in standardized nomenclature.',
    `intended_use_classification` STRING COMMENT 'Primary regulatory classification defining the intended use of the product. RUO (Research Use Only) for research applications, IVD (In Vitro Diagnostic) for FDA-regulated diagnostic devices, CE-IVD (Conformité Européenne In Vitro Diagnostic) for EU-regulated diagnostics, LDT (Laboratory Developed Test) for lab-developed tests, ASR (Analyte Specific Reagent) for FDA ASR classification, GMP (Good Manufacturing Practice) for manufacturing-grade products.. Valid values are `RUO|IVD|CE-IVD|LDT|ASR|GMP`',
    `ivdr_risk_class` STRING COMMENT 'EU IVDR 2017/746 risk classification for in vitro diagnostic medical devices. Class A (lowest risk), Class B (low risk), Class C (moderate risk), Class D (highest risk), or Not Applicable for non-IVD products or non-EU jurisdictions.. Valid values are `Class A|Class B|Class C|Class D|Not Applicable`',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the regulatory jurisdiction where this classification applies (e.g., USA for United States, DEU for Germany, CHN for China). [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|DEU|FRA|ITA|ESP|CHE|NLD|BEL|AUT|SWE|DNK|NOR|FIN|IRL|POL|CZE|HUN|ROU|BGR|HRV|SVN|SVK|EST|LVA|LTU|GRC|PRT|CYP|MLT|LUX|CHN|JPN|KOR|IND|AUS|NZL|SGP|HKG|TWN|THA|MYS|IDN|PHL|VNM|BRA|ARG|CHL|COL|PER|ZAF|ISR|TUR|SAU|ARE|EGY|RUS|UKR — 60 candidates stripped; promote to reference product]',
    `labeling_language_required` STRING COMMENT 'Comma-separated list of ISO 639-1 two-letter language codes required for product labeling and instructions for use in the specified jurisdiction (e.g., en, de, fr, es, zh, ja).',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this regulatory classification record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory classification record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text field for additional regulatory notes, special conditions, or jurisdiction-specific requirements not captured in structured fields.',
    `notified_body_number` STRING COMMENT 'Four-digit identification number of the EU Notified Body responsible for conformity assessment and CE certification.',
    `post_market_surveillance_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether post-market surveillance activities (adverse event reporting, periodic safety updates, vigilance reporting) are mandated for this product in the jurisdiction.',
    `quality_management_system_standard` STRING COMMENT 'Quality management system standard required for manufacturing and commercialization in the jurisdiction (e.g., ISO 13485 for medical devices, FDA 21 CFR Part 820 for US QSR, MDSAP for Medical Device Single Audit Program).. Valid values are `ISO 13485|FDA 21 CFR Part 820|MDSAP|Other`',
    `regulatory_pathway` STRING COMMENT 'Specific regulatory pathway or submission route used to obtain market authorization in the jurisdiction (e.g., FDA 510(k) premarket notification, PMA premarket approval, De Novo classification, CE self-declaration, CE Notified Body route, NMPA China classifications, TGA Australia classifications).. Valid values are `510(k)|PMA|De Novo|Exempt|CE Self-Declaration|CE Notified Body|NMPA Class I|NMPA Class II|NMPA Class III|TGA Class I|TGA Class II|TGA Class III|TGA Class IV|Other`',
    `reimbursement_code` STRING COMMENT 'Healthcare reimbursement code (CPT, HCPCS, or jurisdiction-specific code) associated with the product for insurance billing and reimbursement purposes.',
    `reimbursement_status` STRING COMMENT 'Status of reimbursement approval for the product in the jurisdiction. Approved (reimbursement granted), Pending (under review), Not Applicable (not seeking reimbursement), Denied (reimbursement rejected).. Valid values are `Approved|Pending|Not Applicable|Denied`',
    `review_date` DATE COMMENT 'Date when this regulatory classification record is scheduled for periodic review to ensure continued compliance and accuracy. Format: yyyy-MM-dd.',
    `software_validation_level` STRING COMMENT 'FDA software validation level of concern for products containing software or bioinformatics pipelines. Level A (minor concern), Level B (moderate concern), Level C (major concern), or Not Applicable for non-software products.. Valid values are `Level A - Minor|Level B - Moderate|Level C - Major|Not Applicable`',
    `sterilization_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the product must be sterilized per regulatory requirements for the intended use and jurisdiction.',
    `udi_di` STRING COMMENT 'Device Identifier component of the UDI, a unique numeric or alphanumeric code specific to the device model and version, assigned by an FDA-accredited or EU-recognized issuing agency.',
    `udi_issuing_agency` STRING COMMENT 'Organization that issued the UDI-DI. Common agencies include GS1, HIBCC (Health Industry Business Communications Council), ICCBBA (International Council for Commonality in Blood Banking Automation), IFA (ICCBBA for Medical Devices).. Valid values are `GS1|HIBCC|ICCBBA|IFA|Other`',
    `udi_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether Unique Device Identification (UDI) labeling is required for this product in the specified jurisdiction per FDA UDI rule or EU IVDR requirements.',
    CONSTRAINT pk_regulatory_classification PRIMARY KEY(`regulatory_classification_id`)
) COMMENT 'Regulatory use and market authorization classification for each catalog item by jurisdiction. Captures intended use classification (RUO/IVD/CE-IVD/LDT/ASR), device class (Class I/II/III per FDA 21 CFR), IVDR risk class (A/B/C/D per EU 2017/746), GMDN code, product code (FDA), CE-IVD certificate number, authorization status (authorized/pending/withdrawn), jurisdiction (US/EU/APAC/ROW), authorization date, expiry date, and labeling language requirements. Serves as the SSOT for regulatory status consumed by regulatory submissions, quality, and commercial teams.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`launch_plan` (
    `launch_plan_id` BIGINT COMMENT 'Unique identifier for the commercial launch plan record. Primary key for the launch plan entity.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Launch plans for genomics products cannot proceed without regulatory approval (FDA clearance, CE mark, CLIA waiver). Launch readiness gates depend on approval status. Currently launch_plan tracks regu',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to commercial.campaign. Business justification: Product launches are executed through marketing campaigns. Launch readiness tracking, first-order achievement, and launch ROI analysis require linking launch plans to the campaigns that drive market a',
    `capex_request_id` BIGINT COMMENT 'Foreign key linking to finance.capex_request. Business justification: New product launches often require capital investments in manufacturing lines, quality systems, or instrument platforms. Capital planning and launch readiness assessment require linking launch plans t',
    `catalog_item_id` BIGINT COMMENT 'Reference to the catalog product being launched (sequencing platform, array product, CRISPR tool, reagent kit, consumable, bioinformatics software license, or service).',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Product launches require dedicated budgets for marketing, field training, regulatory submissions, and inventory build. Launch budget tracking and variance analysis (launch_budget_usd vs actuals) depen',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for overall launch execution and cross-functional coordination. Typically a product manager or commercial operations lead.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Launch plans are outcomes of R&D projects. Commercial teams track originating project for technology transfer coordination, field application training content development, competitive positioning, and',
    `stability_study_id` BIGINT COMMENT 'Foreign key linking to quality.stability_study. Business justification: Launch plans must confirm stability data supports claimed shelf life before market introduction. Links launch to stability study ensuring expiry date claims are substantiated for regulatory compliance',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Product launches must specify target genome build(s) for go-to-market positioning and competitive differentiation (e.g., first-to-market with T2T-CHM13 support). Drives marketing messaging, field trai',
    `tertiary_launch_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this launch plan record. Used for audit trail and change tracking.',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: Product launches require completed design verification/validation per 21 CFR 820.30 before commercial release. Links launch plan to validation study completion as critical launch readiness gate for ge',
    `actual_launch_date` DATE COMMENT 'Actual date when the product became commercially available. Null until launch occurs. Used for performance tracking and post-launch analysis.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for this launch (e.g., Sequencing Systems, Array Technologies, Gene Editing, Bioinformatics). Used for organizational reporting and P&L allocation.',
    `commercial_ops_signoff_date` DATE COMMENT 'Date when commercial operations approved launch readiness. Null until approval obtained. Final gate before launch execution.',
    `commercial_ops_signoff_status` STRING COMMENT 'Status of commercial operations readiness approval covering sales enablement, marketing materials, pricing, order management, and distribution: pending (review not complete), approved (ready to launch), rejected (gaps identified), conditional (approved with mitigation plans). Final launch readiness gate.. Valid values are `pending|approved|rejected|conditional`',
    `competitive_positioning` STRING COMMENT 'Strategic positioning statement describing how this product differentiates from competitor offerings (e.g., First CRISPR tool with 99.9% specificity, Lowest cost per genome WGS platform). Informs marketing messaging and sales strategy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this launch plan record was first created in the system. Used for audit trail and data lineage.',
    `cross_sell_products` STRING COMMENT 'Comma-separated list of product IDs for complementary products to be promoted alongside this launch (e.g., reagent kits for new sequencer, analysis software for array platform). Used for bundling and sales strategy.',
    `field_application_training_completion_date` DATE COMMENT 'Date when field application scientist training was completed and team certified to support customers. Null until training complete. Launch readiness gate.',
    `field_application_training_status` STRING COMMENT 'Status of field application scientist training and certification for product support: not_started (training not begun), in_progress (training underway), completed (training done), certified (competency verified), at_risk (insufficient coverage). Launch readiness gate for customer-facing technical support.. Valid values are `not_started|in_progress|completed|certified|at_risk`',
    `first_order_actual_date` DATE COMMENT 'Actual date when the first customer order was received post-launch. Null until first order occurs. Key launch success metric.',
    `first_order_target_date` DATE COMMENT 'Target date for receiving the first customer order post-launch. Used for sales pipeline planning and launch success measurement.',
    `first_shipment_actual_date` DATE COMMENT 'Actual date when first product was shipped to customer. Null until first shipment occurs. Key operational launch metric.',
    `first_shipment_target_date` DATE COMMENT 'Target date for first product shipment to customer. Used for supply chain and logistics planning.',
    `key_value_propositions` STRING COMMENT 'Comma-separated list of primary customer value propositions for this launch (e.g., reduced TAT, improved accuracy, lower COGS, regulatory compliance). Used for sales enablement and marketing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this launch plan record was most recently modified. Used for audit trail and change tracking.',
    `launch_actual_spend_usd` DECIMAL(18,2) COMMENT 'Actual spend to date in USD for launch activities. Updated throughout launch execution. Used for budget variance tracking and post-launch financial analysis.',
    `launch_announcement_date` DATE COMMENT 'Date of public announcement or press release for the product launch. May precede actual commercial availability. Used for marketing and investor relations.',
    `launch_budget_usd` DECIMAL(18,2) COMMENT 'Total approved budget in USD for launch activities including marketing, training, events, promotional materials, and launch support. Used for financial planning and ROI analysis.',
    `launch_plan_name` STRING COMMENT 'Human-readable name of the launch plan, typically including product name and launch wave identifier (e.g., NovaSeq X Plus Global Launch Q2 2024).',
    `launch_plan_number` STRING COMMENT 'Externally-known business identifier for the launch plan, formatted as LP-NNNNNN. Used for cross-functional communication and tracking.. Valid values are `^LP-[0-9]{6}$`',
    `launch_readiness_score` DECIMAL(18,2) COMMENT 'Composite readiness score (0.00 to 100.00) calculated from weighted checklist completion across regulatory, manufacturing, training, and commercial operations dimensions. Used for go/no-go decision making.',
    `launch_risk_assessment` STRING COMMENT 'Summary of identified launch risks and mitigation strategies covering regulatory delays, supply constraints, competitive threats, and market adoption challenges. Updated throughout launch planning and execution.',
    `launch_status` STRING COMMENT 'Current lifecycle status of the launch plan: planning (initial development), readiness_review (cross-functional assessment), approved (go decision made), in_progress (execution underway), launched (product available), completed (post-launch review done), cancelled (plan terminated), on_hold (temporarily paused). [ENUM-REF-CANDIDATE: planning|readiness_review|approved|in_progress|launched|completed|cancelled|on_hold — 8 candidates stripped; promote to reference product]',
    `launch_type` STRING COMMENT 'Classification of the launch strategy: global (worldwide availability), regional (specific geographies), limited_release (select customers), controlled_launch (phased rollout), soft_launch (pre-announcement availability), or pilot (evaluation phase).. Valid values are `global|regional|limited_release|controlled_launch|soft_launch|pilot`',
    `manufacturing_readiness_date` DATE COMMENT 'Date when manufacturing was confirmed ready to support launch demand. Null until readiness achieved. Used for launch timing decisions.',
    `manufacturing_readiness_status` STRING COMMENT 'Status of manufacturing capability to support launch volumes: not_started (planning phase), in_progress (scale-up underway), validation_complete (process validation done per GMP), production_ready (capacity confirmed), at_risk (supply constraints identified). Launch readiness gate.. Valid values are `not_started|in_progress|validation_complete|production_ready|at_risk`',
    `notes` STRING COMMENT 'Free-text field for additional launch planning notes, special considerations, or context not captured in structured fields.',
    `planned_launch_date` DATE COMMENT 'Target date for commercial availability of the product. Established during launch planning and used for cross-functional coordination.',
    `post_launch_review_date` DATE COMMENT 'Date when post-launch review was conducted to assess launch success, capture lessons learned, and identify improvement opportunities. Typically 90-180 days post-launch.',
    `post_launch_review_outcome` STRING COMMENT 'Overall assessment from post-launch review: exceeded_expectations (outperformed targets), met_expectations (achieved targets), partially_met (some targets missed), below_expectations (significant gaps), not_reviewed (review not yet conducted).. Valid values are `exceeded_expectations|met_expectations|partially_met|below_expectations|not_reviewed`',
    `regulatory_classification` STRING COMMENT 'Primary regulatory classification of the product for this launch: RUO (Research Use Only), IVD (In Vitro Diagnostic - FDA cleared), CE_IVD (Conformité Européenne In Vitro Diagnostic - EU), LDT (Laboratory Developed Test), investigational (clinical trial use), exempt (not regulated as medical device). Critical for compliance and market access.. Valid values are `RUO|IVD|CE_IVD|LDT|investigational|exempt`',
    `regulatory_clearance_date` DATE COMMENT 'Date when regulatory approval was obtained for the primary target market. Null if not required or not yet approved. Critical milestone for IVD and CE-IVD products.',
    `regulatory_clearance_status` STRING COMMENT 'Status of required regulatory approvals for target markets: not_required (RUO products), pending (submission planned), in_review (under agency review), approved (clearance obtained), conditional_approval (approved with restrictions), denied (clearance rejected). Launch readiness gate.. Valid values are `not_required|pending|in_review|approved|conditional_approval|denied`',
    `strategic_priority_tier` STRING COMMENT 'Strategic importance classification: tier_1 (flagship/breakthrough product), tier_2 (major product line extension), tier_3 (incremental improvement), tactical (minor update/regional variant). Drives resource allocation and executive visibility.. Valid values are `tier_1|tier_2|tier_3|tactical`',
    `target_customer_segments` STRING COMMENT 'Comma-separated list of primary customer segments targeted for this launch: research (academic/government labs), clinical (diagnostic labs/hospitals), biopharma (drug development), agricultural (crop/livestock genomics), consumer (direct-to-consumer). Informs marketing and sales strategy.',
    `target_geographies` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing the geographic markets included in this launch (e.g., USA,GBR,DEU,JPN). Drives regulatory, supply chain, and commercial operations planning.',
    CONSTRAINT pk_launch_plan PRIMARY KEY(`launch_plan_id`)
) COMMENT 'Commercial launch plan record for a new or updated catalog item, capturing planned launch date, actual launch date, target geographies, target customer segments (research/clinical/biopharma/agricultural), launch type (global/regional/limited release/controlled launch), launch readiness checklist status, regulatory clearance confirmation, manufacturing readiness confirmation, field application scientist training completion, and commercial ops sign-off. Bridges R&D handoff to commercial execution and is the SSOT for go-to-market launch tracking.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`change_notice` (
    `change_notice_id` BIGINT COMMENT 'Unique identifier for the product change notice record. Primary key.',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Product change notices frequently implement corrective actions from quality investigations. Links PCN to originating CAPA for traceability in QMS, ensuring product changes address root causes identifi',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Product Change Notice documents changes to released catalog items. The PCN must reference the primary catalog item being changed. Currently affected_product_skus is a denormalized STRING list; adding ',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: PCNs are a specialized type of change control in regulated genomics/biotech. Formal linkage ensures product changes follow QMS change control process with impact assessment, validation, and approval w',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Engineering changes are executed by specific cost centers (R&D, manufacturing engineering). Cost accounting for change orders (cost_impact_usd) and variance analysis require tracking PCNs to responsib',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Product change notices (PCNs) for material changes to genomics products (chemistry changes, manufacturing site changes, software updates) trigger regulatory submissions to FDA/notified bodies. Regulat',
    `affected_product_families` STRING COMMENT 'Comma-separated list of product family codes impacted by this change, enabling portfolio-level impact analysis and customer communication planning.',
    `approval_chain` STRING COMMENT 'Comma-separated list of approvers and their roles who authorized this change, in sequence. Typically includes Engineering, Quality, Regulatory, and Management approvals as required by change control procedures.',
    `approved_by` STRING COMMENT 'Name of the final approver who authorized implementation of this product change notice. Typically a senior manager or designated change control board member.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when final approval was granted for this product change notice, marking the change as authorized for implementation.',
    `change_category` STRING COMMENT 'Risk-based categorization of the change: major (significant impact on form, fit, function, or regulatory status), minor (limited impact with no regulatory implications), or administrative (documentation-only change with no product impact).. Valid values are `major|minor|administrative`',
    `change_description` STRING COMMENT 'Detailed narrative description of the product change, including what is being changed, the scope of the change, and technical details. Must be comprehensive enough for regulatory review and customer understanding.',
    `change_reason` STRING COMMENT 'Business and technical justification for the change, including root cause analysis if the change is corrective, or strategic rationale if the change is for improvement or cost reduction.',
    `change_title` STRING COMMENT 'Brief descriptive title summarizing the nature of the product change for quick identification and reporting.',
    `cost_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact of implementing this change in US dollars. Positive values indicate cost increases, negative values indicate cost savings. Includes one-time implementation costs and ongoing per-unit cost changes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this product change notice record was first created in the system.',
    `customer_notification_date` DATE COMMENT 'Date on which formal customer notification was sent or published. Used to track compliance with notification lead time requirements.',
    `customer_notification_lead_time_days` STRING COMMENT 'Number of days advance notice provided to customers before the change becomes effective. Typically 30, 60, or 90 days depending on change impact and regulatory requirements.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Indicates whether customers must be formally notified of this change. True if customer notification is required per regulatory requirements or commercial policy, False if change is transparent to customers.',
    `document_references` STRING COMMENT 'Comma-separated list of supporting document identifiers, including design specifications, validation reports, risk assessments, regulatory submissions, and quality records that provide detailed documentation for this change.',
    `effective_date` DATE COMMENT 'Date on which the product change becomes effective in production and commercial distribution. Products manufactured on or after this date will incorporate the change.',
    `implementation_date` DATE COMMENT 'Actual date the change was implemented in production systems, manufacturing processes, or product specifications. May differ from effective_date if implementation occurs earlier or later than planned.',
    `initiator_department` STRING COMMENT 'Department or business unit of the change initiator, such as R&D, Manufacturing, Quality Assurance, Regulatory Affairs, or Product Management.',
    `initiator_name` STRING COMMENT 'Full name of the individual who initiated or requested this product change notice. Typically an engineer, product manager, or quality professional.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who most recently modified this product change notice record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this product change notice record was most recently updated or modified.',
    `last_time_buy_date` DATE COMMENT 'Final date customers can place orders for products with the old specification before the change takes effect. Used for inventory planning and customer transition management.',
    `last_time_ship_date` DATE COMMENT 'Final date products with the old specification will be shipped to customers. After this date, only products incorporating the change will be available.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this product change notice. Used for implementation guidance, lessons learned, or other contextual information.',
    `pcn_number` STRING COMMENT 'Externally-known unique business identifier for the product change notice, typically formatted as PCN-NNNNNN. Used for customer communication and regulatory submissions.. Valid values are `^PCN-[0-9]{6,10}$`',
    `pcn_status` STRING COMMENT 'Current lifecycle status of the product change notice: draft (initial creation), under_review (pending approval), approved (change authorized), customer_notification_pending (awaiting customer communication), customer_notification_sent (customers notified), implemented (change in production), closed (change complete and verified), or cancelled (change withdrawn). [ENUM-REF-CANDIDATE: draft|under_review|approved|customer_notification_pending|customer_notification_sent|implemented|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `pcn_type` STRING COMMENT 'Classification of the change being documented: design (product specification or BOM change), process (manufacturing process change), labeling (packaging or labeling change), regulatory (classification or clearance change), material (raw material or component change), supplier (supplier change), or manufacturing_site (production location change). [ENUM-REF-CANDIDATE: design|process|labeling|regulatory|material|supplier|manufacturing_site — 7 candidates stripped; promote to reference product]',
    `quality_impact_flag` BOOLEAN COMMENT 'Indicates whether this change impacts product quality attributes, specifications, or quality control procedures. True if quality documentation or QC methods must be updated, False if no quality impact.',
    `regulatory_impact_assessment` STRING COMMENT 'Analysis of regulatory implications of the change, including whether the change requires regulatory submission (510(k), PMA amendment, CE-IVD notification), changes to Instructions for Use (IFU), or updates to regulatory documentation.',
    `regulatory_submission_required_flag` BOOLEAN COMMENT 'Indicates whether this change requires a formal regulatory submission to FDA, EMA, or other governing bodies. True if submission is required, False if change can be implemented under existing clearances.',
    `regulatory_submission_type` STRING COMMENT 'Type of regulatory submission required if regulatory_submission_required_flag is True: 510k (premarket notification), pma_supplement (PMA supplement), ce_ivd_notification (EU notified body notification), annual_report (included in annual regulatory report), or none (no submission required).. Valid values are `510k|pma_supplement|ce_ivd_notification|annual_report|none`',
    `related_change_orders` STRING COMMENT 'Comma-separated list of related engineering change order (ECO) numbers, deviation requests, or corrective action (CAPA) identifiers that are associated with or triggered by this product change notice.',
    `risk_assessment_summary` STRING COMMENT 'Executive summary of the risk analysis conducted for this change, including identified hazards, risk mitigation measures, and residual risk determination. References detailed risk assessment documentation.',
    `risk_level` STRING COMMENT 'Overall risk classification assigned to this change based on risk assessment: low (minimal impact), medium (moderate impact requiring controls), high (significant impact requiring extensive validation), or critical (potential safety or regulatory impact requiring full revalidation).. Valid values are `low|medium|high|critical`',
    `supply_chain_impact_flag` BOOLEAN COMMENT 'Indicates whether this change impacts supply chain operations, including supplier changes, component sourcing, manufacturing location changes, or logistics. True if supply chain coordination is required, False if no supply chain impact.',
    `validation_protocol_reference` STRING COMMENT 'Reference identifier to the validation protocol document(s) executed to verify this change meets specifications and regulatory requirements. Links to quality management system documentation.',
    `validation_required_flag` BOOLEAN COMMENT 'Indicates whether formal validation or verification activities are required before implementing this change. True if validation studies, performance testing, or clinical validation is needed, False if change can be implemented without additional validation.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this product change notice record.',
    CONSTRAINT pk_change_notice PRIMARY KEY(`change_notice_id`)
) COMMENT 'Formal product change notice (PCN) record documenting any change to a released catalog items specification, BOM, labeling, regulatory classification, or manufacturing process. Captures PCN number, change type (design/process/labeling/regulatory), change description, affected SKUs, reason for change, risk assessment summary, regulatory impact assessment, customer notification requirement flag, notification lead time (days), effective date, and approval chain. Required for ISO 13485 design change control and FDA 21 CFR 820.70 process change management.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` (
    `compatibility_matrix_id` BIGINT COMMENT 'Unique identifier for the compatibility matrix record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Compatibility claims between genomics products (flow cells + sequencers, library prep kits + instruments, software + assays) are constrained by regulatory approval scope. Off-label combinations may vo',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Instrument-reagent-software compatibility is genome-build-specific (e.g., DRAGEN v3.9 + NovaSeq reagents v1.5 validated for hg38 only). Essential for field application support, preventing customer wor',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this compatibility relationship. Typically a product manager, quality assurance manager, or regulatory affairs specialist.',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.protocol. Business justification: Compatibility validations (instrument-reagent, software-assay) are established through protocol execution. Field application scientists and technical support reference validation protocols when troubl',
    `sku_id` BIGINT COMMENT 'Reference to the source catalog item or SKU in the compatibility relationship. The item for which compatibility is being defined.',
    `superseded_by_compatibility_matrix_id` BIGINT COMMENT 'Reference to the compatibility matrix record that supersedes this relationship. Used to maintain historical lineage when compatibility relationships are updated or replaced.',
    `target_sku_id` BIGINT COMMENT 'Reference to the target catalog item or SKU in the compatibility relationship. The item that is compatible with or substitutes for the source item.',
    `tertiary_compatibility_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this compatibility matrix record.',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: Compatibility claims (reagent kit compatible with instrument platform, software version compatibility) require validation evidence. Links compatibility matrix entry to validation study substantiating ',
    `application_area` STRING COMMENT 'Scientific or clinical application area for which this compatibility relationship is validated. Examples: Whole Genome Sequencing (WGS), Whole Exome Sequencing (WES), targeted gene panels, RNA sequencing, methylation analysis, single-cell genomics, clinical diagnostics, research use only (RUO).',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this compatibility relationship was formally approved for use in production systems and customer-facing applications.',
    `bioinformatics_pipeline_compatibility` STRING COMMENT 'Describes compatibility with bioinformatics analysis pipelines and software versions. Specifies which pipeline versions, output formats (FASTQ, BAM, VCF), and analysis workflows are supported for this compatibility relationship.',
    `change_order_number` STRING COMMENT 'Reference to the engineering change order or product change notification that authorized the creation or modification of this compatibility relationship.',
    `compatibility_conditions` STRING COMMENT 'Detailed conditions, restrictions, or prerequisites that must be met for this compatibility relationship to be valid. Examples: specific run configurations, temperature ranges, sample types, workflow protocols, or instrument calibration requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compatibility matrix record was first created in the system.',
    `customer_approval_required_flag` BOOLEAN COMMENT 'Indicates whether explicit customer approval is required before substituting the target item for the source item. True requires customer consent; false allows automatic substitution per business rules.',
    `directionality` STRING COMMENT 'Indicates whether the compatibility relationship is one-way (source to target only) or bidirectional (mutual compatibility). Critical for order validation logic and substitution workflows.. Valid values are `one-way|bidirectional`',
    `effective_end_date` DATE COMMENT 'Date after which this compatibility relationship is no longer valid. Null indicates indefinite validity subject to status.',
    `effective_start_date` DATE COMMENT 'Date from which this compatibility relationship becomes valid and can be used for order validation, substitution, and field application guidance.',
    `field_application_notes` STRING COMMENT 'Technical guidance and recommendations for field application scientists and customer support teams regarding this compatibility relationship. May include protocol adjustments, troubleshooting tips, or customer communication templates.',
    `flow_cell_compatibility_notes` STRING COMMENT 'Specific notes regarding flow cell type compatibility, run configuration requirements, multiplexing limitations, and demultiplexing considerations for Next-Generation Sequencing (NGS) applications.',
    `instrument_compatibility_scope` STRING COMMENT 'Defines the scope of instrument models, serial number ranges, or firmware versions for which this compatibility relationship is validated. Critical for sequencing platform and array scanner compatibility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compatibility matrix record was most recently modified.',
    `library_preparation_compatibility` STRING COMMENT 'Describes compatibility with library preparation kits, protocols, and workflows. Includes information on adapter compatibility, index compatibility, and protocol modifications required.',
    `lot_traceability_impact_flag` BOOLEAN COMMENT 'Indicates whether this compatibility relationship has implications for lot traceability and Certificate of Analysis (COA) requirements. True indicates additional traceability documentation required; false indicates standard traceability applies.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context regarding this compatibility relationship. May include historical context, customer feedback, or special handling instructions.',
    `performance_impact_description` STRING COMMENT 'Description of any performance differences, quality impacts, or operational considerations when using the target item with the source item. Examples: read length differences, coverage depth variations, Phred score impacts, Turnaround Time (TAT) changes, cost implications.',
    `price_differential_percent` DECIMAL(18,2) COMMENT 'Percentage price difference between target and source items. Positive values indicate target is more expensive; negative values indicate target is less expensive. Used for customer communication and order adjustment workflows.',
    `quality_control_requirements` STRING COMMENT 'Additional quality control or quality assurance requirements that must be met when using this compatibility relationship. Examples: additional QC metrics, control samples, calibration procedures, or Standard Operating Procedure (SOP) references.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification applicable to this compatibility relationship. Research Use Only (RUO) for research applications; In Vitro Diagnostic (IVD) for FDA-cleared diagnostic use; Conformité Européenne In Vitro Diagnostic (CE-IVD) for European diagnostic use; Laboratory Developed Test (LDT) for CLIA-certified lab use; investigational for clinical trial use.. Valid values are `RUO|IVD|CE-IVD|LDT|investigational`',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the compatibility relationship. Active indicates currently valid and usable; inactive indicates temporarily disabled; pending-validation indicates awaiting formal validation; deprecated indicates scheduled for removal; superseded indicates replaced by newer relationship.. Valid values are `active|inactive|pending-validation|deprecated|superseded`',
    `relationship_type` STRING COMMENT 'Type of compatibility or substitution relationship between the source and target items. Validated-compatible indicates full validation testing completed; not-validated indicates no formal validation; conditionally-compatible requires specific conditions; substitute-equivalent indicates functionally identical replacement; substitute-upgrade indicates enhanced replacement; cross-reference indicates alternative ordering code for same item.. Valid values are `validated-compatible|not-validated|conditionally-compatible|substitute-equivalent|substitute-upgrade|cross-reference`',
    `source_version_max` STRING COMMENT 'Maximum version or revision of the source item for which this compatibility relationship applies. Null indicates no upper version limit.',
    `source_version_min` STRING COMMENT 'Minimum version or revision of the source item for which this compatibility relationship applies. Used for software, firmware, and versioned hardware components.',
    `substitution_priority` STRING COMMENT 'Numeric priority ranking for substitute items when multiple substitutes are available. Lower numbers indicate higher priority. Used in backorder resolution and inventory allocation workflows.',
    `target_version_max` STRING COMMENT 'Maximum version or revision of the target item for which this compatibility relationship applies. Null indicates no upper version limit.',
    `target_version_min` STRING COMMENT 'Minimum version or revision of the target item for which this compatibility relationship applies. Used for software, firmware, and versioned hardware components.',
    `technology_platform` STRING COMMENT 'Sequencing or genomics technology platform for which this compatibility applies. Examples: Next-Generation Sequencing (NGS), array-based genotyping, Polymerase Chain Reaction (PCR), quantitative PCR (qPCR), CRISPR gene editing, long-read sequencing, short-read sequencing.',
    `validation_date` DATE COMMENT 'Date when the compatibility validation testing or verification was completed and approved.',
    `validation_evidence_reference` STRING COMMENT 'Reference identifier to the validation study, test report, or documentation that supports this compatibility relationship. May reference analytical validation study ID, technical bulletin number, or quality management system document.',
    CONSTRAINT pk_compatibility_matrix PRIMARY KEY(`compatibility_matrix_id`)
) COMMENT 'Defines validated compatibility and substitution relationships between catalog items and SKUs — e.g., which reagent kits are validated for use with which sequencing instruments, which flow cell types are compatible with which run configurations, which bioinformatics software versions support which instrument output formats, and which SKUs are approved substitutes for others (equivalent/upgrade/cross-reference). Stores source item reference, target item reference, relationship type (validated-compatible/not-validated/conditionally-compatible/substitute-equivalent/substitute-upgrade), directionality (one-way/bidirectional), validation evidence reference, applicable version range, effective date range, conditions/restrictions, and relationship notes. Critical for field application support, order validation, backorder resolution, and customer success.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`software_release` (
    `software_release_id` BIGINT COMMENT 'Unique identifier for the software release record. Primary key.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the parent software product (bioinformatics software, instrument firmware, or analysis pipeline software) that this release belongs to.',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Software releases in regulated genomics environments require formal change control approval per 21 CFR Part 11 and QMS requirements. Links release to change control for traceability, impact assessment',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Software releases are validated for specific instrument models; required for firmware deployment eligibility checks, customer upgrade notifications, regulatory validation tracking, and technical suppo',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Bioinformatics software releases must declare supported genome builds in release notes. Critical for customer upgrade planning, validation study design, and regulatory change control. Enables traceabi',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Analysis software must specify compatible variant database versions for reproducible clinical results. Required for regulatory validation (FDA guidance on clinical decision support software), customer',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: QA approval for software releases is a GxP-critical control point for software as medical device (SaMD) regulatory compliance (FDA 21 CFR Part 820, IEC 62304). Qa_approved_by is currently bare text; l',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Bioinformatics software products (analysis pipelines, variant callers) originate from R&D projects. Product management tracks project lineage for feature roadmaps, IP disclosure, regulatory classifica',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: IVD software releases (bioinformatics pipelines, variant callers, analysis software) require regulatory submissions (510k, CE-IVD) for clearance/approval. Each major release must reference the submiss',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: Software as medical device (SaMD) in genomics requires validation per IEC 62304 and FDA software validation guidance. Links software release to validation study for regulatory compliance and performan',
    `api_version` STRING COMMENT 'Version number of the public API (Application Programming Interface) exposed by this software release (e.g., v2.1, v3.0). Used for integration and backward compatibility tracking.. Valid values are `^v[0-9]+.[0-9]+$`',
    `authentication_methods_supported` STRING COMMENT 'Comma-separated list of authentication mechanisms supported (e.g., LDAP, SAML 2.0, OAuth 2.0, Multi-Factor Authentication (MFA), API (Application Programming Interface) keys).',
    `backward_compatible_flag` BOOLEAN COMMENT 'Indicates whether this release is backward compatible with previous versions (True) or contains breaking changes requiring migration (False).',
    `build_number` STRING COMMENT 'Internal build identifier generated by the continuous integration system (e.g., Jenkins build #4523). Used for traceability and debugging.',
    `ce_mark_certificate_number` STRING COMMENT 'CE-IVD certification number issued by a Notified Body if this software is approved for diagnostic use in the European Union under IVDR 2017/746.',
    `checksum_sha256` STRING COMMENT 'SHA-256 cryptographic hash of the installation package for integrity verification and tamper detection.. Valid values are `^[a-f0-9]{64}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this software release record was first created in the system. Follows yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `docker_image_tag` STRING COMMENT 'Docker container image tag for this release if distributed as a containerized application (e.g., genomics-pipeline:2.5.1).',
    `encryption_standard` STRING COMMENT 'Encryption algorithms and standards used for data at rest and in transit (e.g., AES-256, TLS 1.3, RSA 2048).',
    `end_of_life_date` DATE COMMENT 'Date when the software release is officially retired and no longer available for download or use. Follows yyyy-MM-dd format.',
    `end_of_support_date` DATE COMMENT 'Date when technical support, bug fixes, and security patches will no longer be provided for this release. Critical for customer lifecycle planning. Follows yyyy-MM-dd format.',
    `fda_clearance_number` STRING COMMENT 'FDA 510(k) clearance number or PMA (Premarket Approval) number if this software is classified as a medical device or IVD (In Vitro Diagnostic).',
    `git_commit_hash` STRING COMMENT 'SHA-1 hash of the Git commit from which this release was built. Enables precise source code traceability.. Valid values are `^[a-f0-9]{40}$`',
    `installation_package_url` STRING COMMENT 'Download link for the software installation package (installer, Docker image, or deployment artifact).. Valid values are `^https?://.*`',
    `known_issues_log_reference` STRING COMMENT 'Reference identifier or URL to the known issues log documenting bugs, limitations, and workarounds for this release.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this software release record was last updated. Follows yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `license_model` STRING COMMENT 'Licensing and pricing model for this software release: perpetual (one-time purchase), subscription (recurring fee), SaaS (Software as a Service cloud-hosted), open_source (freely available), trial (time-limited evaluation).. Valid values are `perpetual|subscription|saas|open_source|trial`',
    `license_terms_url` STRING COMMENT 'Web link to the End User License Agreement (EULA) or software license terms document for this release.. Valid values are `^https?://.*`',
    `migration_guide_url` STRING COMMENT 'Web link to the migration guide document for customers upgrading from previous versions. Critical for releases with breaking changes.. Valid values are `^https?://.*`',
    `minimum_system_requirements` STRING COMMENT 'Minimum hardware and software specifications required to run this release (e.g., CPU: 8 cores, RAM: 32GB, Storage: 500GB SSD, Python 3.8+).',
    `package_size_mb` DECIMAL(18,2) COMMENT 'Size of the installation package in megabytes. Used for download planning and storage capacity estimation.',
    `planned_release_date` DATE COMMENT 'Originally scheduled date for the software release. Used for tracking schedule adherence and planning. Follows yyyy-MM-dd format.',
    `qa_approval_status` STRING COMMENT 'Quality Assurance approval status for this release: pending (under review), approved (passed all tests), rejected (failed quality gates), conditional (approved with known limitations).. Valid values are `pending|approved|rejected|conditional`',
    `qa_approval_timestamp` TIMESTAMP COMMENT 'Date and time when QA (Quality Assurance) approval was granted. Follows yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `recommended_system_requirements` STRING COMMENT 'Recommended hardware and software specifications for optimal performance (e.g., CPU: 16 cores, RAM: 64GB, Storage: 1TB NVMe SSD, Python 3.10+).',
    `regulatory_classification` STRING COMMENT 'Regulatory status of the software release: RUO (Research Use Only), IVD (In Vitro Diagnostic - FDA approved), CE-IVD (Conformité Européenne In Vitro Diagnostic - EU approved), LDT (Laboratory Developed Test), not_applicable (non-diagnostic software).. Valid values are `RUO|IVD|CE_IVD|LDT|not_applicable`',
    `release_date` DATE COMMENT 'Date when the software release was made generally available to customers. Follows yyyy-MM-dd format.',
    `release_manager` STRING COMMENT 'Name or employee identifier of the release manager responsible for coordinating and approving this software release.',
    `release_name` STRING COMMENT 'Marketing or code name for the software release (e.g., Aurora, Phoenix, Q4 2023 Release). Optional friendly identifier.',
    `release_notes_summary` STRING COMMENT 'High-level summary of key features, enhancements, and bug fixes included in this release. Detailed release notes are stored separately.',
    `release_notes_url` STRING COMMENT 'Web link to the complete release notes document hosted on the company documentation portal or knowledge base.. Valid values are `^https?://.*`',
    `release_number` STRING COMMENT 'Semantic version number of the software release following the pattern major.minor.patch (e.g., 2.5.1, 3.0.0-beta). Follows semantic versioning standard.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(-[a-zA-Z0-9]+)?$`',
    `release_status` STRING COMMENT 'Current lifecycle status of the software release: planned (scheduled), in_development (under construction), testing (QA phase), released (generally available), deprecated (superseded), end_of_life (no longer supported).. Valid values are `planned|in_development|testing|released|deprecated|end_of_life`',
    `release_type` STRING COMMENT 'Classification of the release based on scope and impact: major (breaking changes), minor (new features), patch (bug fixes), hotfix (urgent fix), beta (pre-release testing), alpha (early development).. Valid values are `major|minor|patch|hotfix|beta|alpha`',
    `security_certification` STRING COMMENT 'Security certifications and compliance standards met by this release (e.g., ISO 27001, SOC 2 Type II, HIPAA (Health Insurance Portability and Accountability Act) compliant, GDPR (General Data Protection Regulation) compliant).',
    `supported_cloud_platforms` STRING COMMENT 'Comma-separated list of cloud platforms where this software can be deployed (e.g., AWS (Amazon Web Services), Azure, GCP, on-premise, HPC (High-Performance Computing)).',
    `supported_os_platforms` STRING COMMENT 'Comma-separated list of operating systems compatible with this release (e.g., Linux Ubuntu 20.04, CentOS 7, Windows Server 2019, macOS 12).',
    `training_materials_url` STRING COMMENT 'Web link to training documentation, videos, or e-learning modules for this software release.. Valid values are `^https?://.*`',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training or certification is required for users to operate this software release (True/False). Relevant for IVD (In Vitro Diagnostic) and clinical software.',
    CONSTRAINT pk_software_release PRIMARY KEY(`software_release_id`)
) COMMENT 'Version and release record for bioinformatics software products, instrument firmware, and analysis pipeline software offered commercially by Genomics Biotech. Captures software product reference, version number (semantic versioning), release type (major/minor/patch/hotfix), release date, end-of-support date, supported OS and cloud platforms (AWS/on-premise/HPC), release notes summary, known issues log reference, validated instrument compatibility, and license model (perpetual/subscription/SaaS). Enables software lifecycle management and customer entitlement tracking.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` (
    `license_entitlement_id` BIGINT COMMENT 'Unique identifier for the license entitlement template. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Software license entitlements for IVD bioinformatics tools must be tied to regulatory clearance. RUO vs. IVD licenses have different compliance obligations. License entitlements must reference the reg',
    `catalog_item_id` BIGINT COMMENT 'Reference to the software product SKU (Stock Keeping Unit) that this entitlement template applies to, such as bioinformatics software licenses, DRAGEN pipeline modules, or BaseSpace Sequence Hub subscriptions.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Software license entitlements for bioinformatics tools and data analysis platforms require audit trails for compliance (HIPAA for PHI access, GDPR for data processing, export control for restricted al',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Software licenses may restrict usage to specific genome builds or require separate licenses per build (e.g., human-only vs. multi-species licenses). Critical for license compliance audits, revenue rec',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Software licenses are instrument-model-specific for usage tracking, compliance auditing, and activation validation. Required for license key generation, telemetry compliance verification, and customer',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Database access licenses are version-specific and may have usage restrictions (e.g., ClinVar commercial use, gnomAD research-only). Required for license management, customer entitlement tracking, and ',
    `activation_mechanism` STRING COMMENT 'Method by which the customer activates the license: online (internet-based activation server), offline (manual activation file), token-based (API token exchange), hardware dongle (USB security key), or cloud-native (no activation required for SaaS).. Valid values are `online|offline|token_based|hardware_dongle|cloud_native`',
    `api_call_limit` STRING COMMENT 'Maximum number of API (Application Programming Interface) calls allowed per billing period for cloud-based software services. Null indicates unlimited API access. Critical for BaseSpace Sequence Hub and bioinformatics platform integrations.',
    `compliance_audit_requirement` STRING COMMENT 'Frequency and method of license compliance audits: none (no audit rights), annual (yearly audit), quarterly (every 3 months), on-demand (vendor-initiated), or continuous telemetry (automated usage reporting).. Valid values are `none|annual|quarterly|on_demand|continuous_telemetry`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this license entitlement template record was first created in the system.',
    `data_processing_limit_gb` DECIMAL(18,2) COMMENT 'Maximum amount of genomic data (in gigabytes) that can be processed under this license entitlement per billing period. Common for cloud-based bioinformatics pipelines and BaseSpace subscriptions. Null indicates unlimited processing.',
    `effective_end_date` DATE COMMENT 'Date when this license entitlement template is retired and no longer available for new sales. Null indicates the template is currently active with no planned end date. Existing customer licenses remain valid beyond this date.',
    `effective_start_date` DATE COMMENT 'Date when this license entitlement template becomes available for new sales and customer assignments. Templates cannot be sold before this date.',
    `entitlement_code` STRING COMMENT 'Unique business identifier for this license entitlement template, used in sales orders, quotes, and customer communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `entitlement_description` STRING COMMENT 'Detailed description of the usage rights, technical constraints, and business terms granted by this license entitlement template.',
    `entitlement_duration_months` STRING COMMENT 'Duration of the license entitlement in months. Null or zero indicates perpetual license with no expiration. Common values: 12 (annual), 36 (three-year), 60 (five-year).',
    `entitlement_name` STRING COMMENT 'Human-readable name of the license entitlement template, such as DRAGEN Enterprise Annual Subscription or BaseSpace Pro Node-Locked License.',
    `export_control_classification` STRING COMMENT 'Export Control Classification Number (ECCN) or equivalent classification under U.S. Export Administration Regulations (EAR) or International Traffic in Arms Regulations (ITAR). Determines export licensing requirements and geographic restrictions.',
    `gdpr_compliance_required` BOOLEAN COMMENT 'Indicates whether this license entitlement requires GDPR (General Data Protection Regulation) compliance controls for processing personal data of EU residents. True for software handling human genomic data in EU jurisdictions.',
    `geographic_usage_restriction` STRING COMMENT 'Geographic regions where the license is valid, specified as comma-separated ISO 3166-1 alpha-3 country codes (e.g., USA,CAN,GBR) or region codes. Null indicates worldwide usage rights. Critical for export control compliance (EAR, ITAR).',
    `hipaa_compliance_required` BOOLEAN COMMENT 'Indicates whether this license entitlement requires HIPAA (Health Insurance Portability and Accountability Act) compliance controls for handling PHI (Protected Health Information). True for clinical diagnostic software; False for research-only tools.',
    `is_perpetual` BOOLEAN COMMENT 'Indicates whether this is a perpetual license (True) with indefinite usage rights, or a term-based license (False) that expires after the entitlement duration.',
    `license_key_generation_method` STRING COMMENT 'Method used to generate license keys or activation tokens for this entitlement: manual (generated by support team), automated API (system-generated), token-based (JWT or OAuth tokens), hardware fingerprint (tied to device ID), or cloud entitlement (managed by cloud platform).. Valid values are `manual|automated_api|token_based|hardware_fingerprint|cloud_entitlement`',
    `license_status` STRING COMMENT 'Current lifecycle status of the license entitlement template. Active templates are available for new sales; deprecated templates are phased out; retired templates are no longer offered.. Valid values are `active|inactive|deprecated|pending_approval|retired`',
    `license_type` STRING COMMENT 'Type of license deployment model: node-locked (tied to specific hardware), floating (shared pool), site (unlimited within location), cloud (cloud-hosted), SaaS subscription (software-as-a-service), or perpetual (one-time purchase with indefinite use).. Valid values are `node_locked|floating|site|cloud|saas_subscription|perpetual`',
    `licensed_feature_set` STRING COMMENT 'Comma-separated list of software features and modules included in this entitlement, such as DRAGEN alignment, variant calling, tumor-normal analysis, RNA-Seq, methylation analysis. Defines functional scope of the license.',
    `maintenance_included` BOOLEAN COMMENT 'Indicates whether software maintenance (bug fixes, security patches, minor updates) is included in the license entitlement (True) or requires separate purchase (False).',
    `max_compute_nodes` STRING COMMENT 'Maximum number of compute nodes (servers, HPC (High-Performance Computing) nodes, or cloud instances) on which the software can be deployed. Critical for bioinformatics pipeline scaling. Null indicates unlimited nodes.',
    `max_concurrent_users` STRING COMMENT 'Maximum number of users who can simultaneously access the software under this license entitlement. Null indicates unlimited concurrent access.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this license entitlement template record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this license entitlement template record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional information, special terms, exceptions, or internal guidance related to this license entitlement template.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the software product: RUO (Research Use Only), IVD (In Vitro Diagnostic), CE-IVD (European Conformité Européenne In Vitro Diagnostic), LDT (Laboratory Developed Test), or FDA device class (I, II, III). Determines permissible use cases and compliance requirements. [ENUM-REF-CANDIDATE: ruo|ivd|ce_ivd|ldt|class_i|class_ii|class_iii|exempt — 8 candidates stripped; promote to reference product]',
    `renewal_terms` STRING COMMENT 'Business terms governing license renewal, including renewal pricing model, advance notice requirements, auto-renewal policies, and renewal discount eligibility.',
    `sample_throughput_limit` STRING COMMENT 'Maximum number of samples that can be processed under this license entitlement per billing period. Relevant for clinical assay software and LIMS (Laboratory Information Management System) integrations. Null indicates unlimited sample processing.',
    `storage_quota_gb` DECIMAL(18,2) COMMENT 'Maximum cloud storage capacity (in gigabytes) included with this license entitlement for storing sequencing data, analysis results, and project files. Null indicates unlimited storage or storage not included.',
    `sublicensing_allowed` BOOLEAN COMMENT 'Indicates whether the customer is permitted to sublicense the software to third parties (True) or must use it exclusively for their own operations (False). Critical for service bureau and contract research organization (CRO) business models.',
    `support_tier` STRING COMMENT 'Level of technical support included with this license entitlement: basic (email support, business hours), standard (phone and email, extended hours), premium (24/7 support, dedicated engineer), enterprise (named account team, SLA (Service Level Agreement) guarantees), or none (no support included).. Valid values are `basic|standard|premium|enterprise|none`',
    `telemetry_reporting_enabled` BOOLEAN COMMENT 'Indicates whether the software automatically reports usage telemetry back to the vendor for license compliance monitoring and product analytics. True enables automated usage tracking; False requires manual compliance reporting.',
    `training_entitlement` STRING COMMENT 'Description of training services included with this license, such as two on-site training sessions, unlimited online training portal access, or annual certification workshop. Null if no training is included.',
    `transfer_restriction` STRING COMMENT 'Policy governing whether the license can be transferred to another legal entity or organizational unit: non-transferable (locked to original purchaser), transferable with approval (requires vendor consent), or freely transferable (no restrictions).. Valid values are `non_transferable|transferable_with_approval|freely_transferable`',
    `upgrade_eligibility` STRING COMMENT 'Defines which software upgrades the customer is entitled to receive: full upgrade (all major and minor versions), minor version only (patches and minor releases), no upgrade (locked to purchased version), maintenance only (bug fixes), or feature add-on (specific feature unlocks).. Valid values are `full_upgrade|minor_version_only|no_upgrade|maintenance_only|feature_add_on`',
    `usage_restriction_terms` STRING COMMENT 'Additional usage restrictions beyond geography, such as RUO (Research Use Only) - not for clinical diagnostics, internal use only - no service bureau, academic institution only, or non-commercial research only. Critical for regulatory compliance.',
    `version_number` STRING COMMENT 'Version number of this license entitlement template, following semantic versioning (major.minor.patch). Incremented when entitlement terms, features, or restrictions change.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_license_entitlement PRIMARY KEY(`license_entitlement_id`)
) COMMENT 'Product-level license entitlement template defining the usage rights and technical constraints granted when a customer purchases a specific software SKU. Captures license type (node-locked/floating/site/cloud/SaaS subscription), maximum concurrent users, maximum compute nodes, licensed feature set (e.g., DRAGEN alignment, variant calling, tumor-normal analysis), license key generation method, activation mechanism (online/offline/token-based), entitlement duration (perpetual/annual/multi-year), renewal terms, upgrade eligibility, geographic usage restrictions, and compliance audit requirements. Serves as the canonical template from which customer-specific license assignments (in the order/agreement domain) are instantiated. Critical for software revenue recognition, entitlement verification, and license compliance auditing.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`service_offering` (
    `service_offering_id` BIGINT COMMENT 'Unique identifier for the service offering record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Clinical genomics services (sequencing services, variant interpretation, genetic counseling) may require regulatory authorization (CLIA certification, CAP accreditation, LDT registration). Service off',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Service offerings (sequencing services, bioinformatics analysis, clinical assay validation) require business and regulatory approval before launch, especially for CLIA-certified lab services. Approved',
    `catalog_item_id` BIGINT COMMENT 'Reference to the parent catalog item of category=service. Each service offering extends a catalog item with service-specific operational detail.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Services (sequencing, bioinformatics, field application support) are delivered by specific cost centers. Service profitability analysis requires linking service offerings to delivery cost centers for ',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Sequencing services and bioinformatics analysis services must specify which reference genome(s) are used in data deliverables. Critical for customer SOWs, data analysis reports, and service quality sp',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Service offerings target specific instrument platforms; required for service eligibility validation, field service scheduling, training program assignment, and customer support routing. Compatible_ins',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Service delivery (sequencing services, bioinformatics pipelines) often requires supplier partnerships for reagents, consumables, or subcontracted analysis. Service costing, supplier performance tracki',
    `quality_training_curriculum_id` BIGINT COMMENT 'Foreign key linking to quality.training_curriculum. Business justification: Technical service delivery requires certified training (field application scientists, service engineers, laboratory technicians). Links service offering to required training curriculum ensuring person',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.protocol. Business justification: Service offerings (sequencing, genotyping, gene editing) are delivered using validated protocols. Operations teams link service SKUs to protocols for SOP compliance, quality control, CLIA/CAP accredit',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: Service offerings (sequencing services, bioinformatics analysis, sample processing) require validation for CLIA/CAP compliance and quality assurance. Links service to validation study demonstrating me',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this service offering was formally approved for commercial availability. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `business_unit` STRING COMMENT 'Organizational business unit or division responsible for delivering and supporting this service offering (e.g., Clinical Services, Field Application Science, Customer Training, Bioinformatics Consulting).',
    `compliance_requirements` STRING COMMENT 'Comma-separated list of compliance frameworks, standards, or regulations that govern service delivery (e.g., HIPAA, GDPR, ISO 15189, GxP, SOX). Used to ensure service execution meets all applicable legal and regulatory obligations.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated internal cost to deliver the service including labor, travel, materials, and overhead. Used for margin analysis and profitability tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this service offering record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard price (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `deliverables_description` STRING COMMENT 'Detailed description of tangible outputs and documentation provided upon service completion (e.g., qualification reports, training certificates, analysis reports, installation documentation).',
    `delivery_mode` STRING COMMENT 'Method by which the service is delivered to the customer: on-site (at customer location), remote (virtual/online), or hybrid (combination of on-site and remote).. Valid values are `on_site|remote|hybrid`',
    `discontinuation_date` DATE COMMENT 'Date when the service offering was or will be discontinued and no longer available for new customer engagements. Existing contracts may continue beyond this date.',
    `geographic_availability` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or region codes where this service is available for delivery. Reflects field service coverage, regulatory approvals, and operational capacity.',
    `launch_date` DATE COMMENT 'Date when the service offering was first made commercially available to customers.',
    `materials_included_flag` BOOLEAN COMMENT 'Indicates whether consumable materials, reagents, or spare parts required for service delivery are included in the standard price or billed separately.',
    `maximum_participants` STRING COMMENT 'Maximum number of customer participants allowed per service engagement. Primarily applicable to training and consulting services.',
    `minimum_notice_days` STRING COMMENT 'Minimum number of business days advance notice required to schedule the service. Used for resource planning and customer expectation management.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this service offering record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this service offering record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, internal comments, or operational notes relevant to service delivery planning and execution.',
    `prerequisite_services` STRING COMMENT 'Comma-separated list of service codes that must be completed before this service can be delivered (e.g., installation must precede qualification, basic training must precede advanced training).',
    `pricing_model` STRING COMMENT 'Commercial pricing structure for the service: fixed-fee (flat rate per engagement), time-and-materials (hourly/daily rate plus expenses), subscription (recurring periodic fee), per-sample (unit-based for sequencing services), or per-run (per instrument run for sequencing-as-a-service).. Valid values are `fixed_fee|time_and_materials|subscription|per_sample|per_run`',
    `regulatory_classification` STRING COMMENT 'Regulatory framework applicable to the service: Research Use Only (RUO), In Vitro Diagnostic (IVD), Conformité Européenne In Vitro Diagnostic (CE-IVD), Clinical Laboratory Improvement Amendments (CLIA), College of American Pathologists (CAP), Good Manufacturing Practice (GMP), or not applicable for non-regulated services. [ENUM-REF-CANDIDATE: RUO|IVD|CE_IVD|CLIA|CAP|GMP|not_applicable — 7 candidates stripped; promote to reference product]',
    `remote_delivery_capable_flag` BOOLEAN COMMENT 'Indicates whether the service can be delivered remotely without requiring on-site presence. True for virtual training, remote troubleshooting, and bioinformatics consulting.',
    `renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether this service offering is eligible for contract renewal or recurring subscription. True for maintenance contracts, support agreements, and subscription-based services.',
    `required_certifications` STRING COMMENT 'Comma-separated list of certifications, training credentials, or qualifications that delivery staff must hold to perform this service (e.g., CLIA certification, instrument-specific training, Good Manufacturing Practice (GMP) training, field service engineer certification).',
    `response_time_hours` DECIMAL(18,2) COMMENT 'Maximum time in hours from service request to initial response or service commencement as defined in the SLA tier.',
    `service_category` STRING COMMENT 'Primary classification of the service offering type: installation (instrument setup), qualification (IQ/OQ/PQ validation), maintenance (preventive/corrective), field application scientist (FAS on-site support), training (customer education programs), consulting (bioinformatics/assay development), or sequencing-service (sequencing-as-a-service). [ENUM-REF-CANDIDATE: installation|qualification|maintenance|field_application_scientist|training|consulting|sequencing_service — 7 candidates stripped; promote to reference product]',
    `service_code` STRING COMMENT 'Unique alphanumeric business identifier for the service offering used in commercial transactions and service delivery documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `service_description` STRING COMMENT 'Detailed description of the service offering including scope, objectives, and key activities performed during service delivery.',
    `service_name` STRING COMMENT 'Full commercial name of the service offering as presented to customers and used in contracts.',
    `service_owner` STRING COMMENT 'Name or identifier of the individual or team responsible for service definition, quality, and continuous improvement. Accountable for service performance and customer satisfaction.',
    `service_status` STRING COMMENT 'Current lifecycle status of the service offering: active (available for sale and delivery), inactive (temporarily unavailable), discontinued (end-of-life), under development (not yet launched), or pilot (limited availability for testing).. Valid values are `active|inactive|discontinued|under_development|pilot`',
    `service_subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the service category (e.g., preventive_maintenance, corrective_maintenance, IQ, OQ, PQ, basic_training, advanced_training).',
    `sla_tier` STRING COMMENT 'Service level tier defining response time commitments, availability guarantees, and support priority: standard (business hours), premium (extended hours), enterprise (24/7 with escalation), critical (immediate response for mission-critical systems).. Valid values are `standard|premium|enterprise|critical`',
    `standard_duration_days` DECIMAL(18,2) COMMENT 'Expected duration of the service engagement measured in business days. Used for multi-day engagements such as installation, qualification, or training programs.',
    `standard_duration_hours` DECIMAL(18,2) COMMENT 'Expected duration of the service engagement measured in hours under normal conditions. Used for resource planning and scheduling.',
    `standard_price_usd` DECIMAL(18,2) COMMENT 'List price for the service offering in United States Dollars before any discounts, volume adjustments, or contract negotiations. Used as baseline for pricing analytics and Average Selling Price (ASP) calculations.',
    `travel_expenses_included_flag` BOOLEAN COMMENT 'Indicates whether travel expenses (airfare, lodging, meals, ground transportation) are included in the standard price or billed separately. Applicable to on-site services.',
    `warranty_period_days` STRING COMMENT 'Number of days after service completion during which rework or corrections are provided at no additional charge if service deliverables do not meet specifications.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this service offering record in the system.',
    CONSTRAINT pk_service_offering PRIMARY KEY(`service_offering_id`)
) COMMENT 'Extended detail record for professional and technical services offered commercially — including instrument installation, IQ/OQ/PQ qualification, preventive maintenance contracts, field application scientist (FAS) support, custom assay development, bioinformatics consulting, sequencing-as-a-service, and training programs. Captures service-specific attributes beyond what catalog_item holds: service code, service category (installation/qualification/maintenance/FAS/training/consulting/sequencing-service), delivery mode (on-site/remote/hybrid), standard duration (hours/days), deliverables description, SLA tier, pricing model (fixed-fee/time-and-materials/subscription), required certifications for delivery staff, prerequisite services, and geographic availability. Each service_offering references a parent catalog_item of category=service; this entity extends the catalog with service-specific operational detail that does not apply to physical products.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`eol_plan` (
    `eol_plan_id` BIGINT COMMENT 'Unique identifier for the end-of-life plan record. Primary key.',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: EOL inventory disposition requires identifying affected materials (raw materials, components, finished goods) for write-off, liquidation, or transition planning. Finance and operations need material-l',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to commercial.campaign. Business justification: End-of-life transitions require customer communication campaigns to manage migration to replacement products, minimize churn, and maintain service revenue. EOL execution tracking and customer transiti',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: End-of-life activities require budgets for inventory write-offs, customer transition support, spare parts, and regulatory notifications. Financial planning for discontinuation (financial_impact_estima',
    `catalog_item_id` BIGINT COMMENT 'Reference to the catalog item (product, instrument, reagent kit, consumable, software license, or service) being discontinued under this EOL plan.',
    `employee_id` BIGINT COMMENT 'Reference to the product manager responsible for overseeing the EOL plan execution and stakeholder coordination.',
    `quaternary_eol_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the EOL plan record.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: End-of-life plans for regulated genomics products (sequencers, IVD kits, diagnostic assays) require regulatory notifications/submissions to FDA/competent authorities. The eol_plan.regulatory_submissio',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: End-of-life planning evaluates whether replacement products are in R&D pipeline. Product managers link EOL plans to active projects to coordinate customer transition timing, inventory planning, and co',
    `stability_study_id` BIGINT COMMENT 'Foreign key linking to quality.stability_study. Business justification: End-of-life decisions may be driven by inability to maintain stability specifications or expiration of stability data supporting shelf life claims. Links EOL plan to stability study justifying discont',
    `tertiary_eol_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created the EOL plan record.',
    `active_service_contract_count` STRING COMMENT 'Number of active service agreements, maintenance contracts, or SLAs associated with the discontinued product that must be honored or renegotiated.',
    `affected_customer_count` STRING COMMENT 'Number of active customers who have purchased or are currently using the discontinued product, requiring notification and transition support.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether executive or senior management approval is required before the EOL plan can be announced. Typically true for high-revenue products or strategic platforms.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the EOL plan was formally approved by authorized management. Null if not yet approved.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for executing the EOL plan (e.g., Sequencing Systems, Array Solutions, Gene Editing, Bioinformatics).',
    `communication_embargo_date` DATE COMMENT 'Date before which the EOL plan must remain confidential and not be communicated externally. Used to coordinate internal preparation before public announcement.',
    `competitor_notification_risk_flag` BOOLEAN COMMENT 'Indicates whether early disclosure of the EOL plan poses a competitive risk (e.g., competitors may target affected customers). Influences communication timing and strategy.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the EOL plan record was first created in the system.',
    `customer_notification_plan` STRING COMMENT 'Structured plan for communicating the EOL to customers, including notification channels (email, portal, field sales), timing, message templates, and escalation procedures for high-value accounts.',
    `data_retention_period_years` STRING COMMENT 'Number of years that product-related data, documentation, and records must be retained after discontinuation to meet regulatory, legal, and audit requirements (typically 7-10 years for IVD products).',
    `discontinuation_reason` STRING COMMENT 'Primary business reason for discontinuing the product: technology superseded (newer platform available), low demand (insufficient market), regulatory change (compliance issue), strategic portfolio rationalization (business focus shift), manufacturing obsolescence (production capability retired), component unavailability (supply chain constraint).. Valid values are `technology_superseded|low_demand|regulatory_change|strategic_portfolio_rationalization|manufacturing_obsolescence|component_unavailability`',
    `discontinuation_reason_detail` STRING COMMENT 'Detailed explanation of the discontinuation reason, including business context, market conditions, technical factors, or regulatory drivers that led to the EOL decision.',
    `documentation_archive_location` STRING COMMENT 'Reference to the archive location (document management system path, repository URL) where product documentation, user manuals, technical specifications, and regulatory files will be retained for compliance and historical reference.',
    `eol_announcement_date` DATE COMMENT 'Date when the EOL plan is officially announced to customers, partners, and internal stakeholders. Marks the beginning of the transition period.',
    `eol_plan_number` STRING COMMENT 'Business identifier for the EOL plan, used for tracking and communication with stakeholders (e.g., EOL-2024001).. Valid values are `^EOL-[0-9]{6,10}$`',
    `eol_status` STRING COMMENT 'Current lifecycle status of the EOL plan: draft (under development), approved (management sign-off), announced (communicated to customers), active (in execution), completed (all dates passed), cancelled (plan withdrawn).. Valid values are `draft|approved|announced|active|completed|cancelled`',
    `erp_system_deactivation_date` DATE COMMENT 'Date when the product SKU is deactivated or marked as discontinued in the ERP system (SAP S/4HANA), preventing new sales orders and purchase requisitions.',
    `field_sales_briefing_date` DATE COMMENT 'Date when field sales teams and customer-facing personnel are briefed on the EOL plan, enabling them to proactively address customer questions and concerns.',
    `financial_impact_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact of the product discontinuation in US dollars, including revenue loss, inventory write-offs, transition costs, and potential customer retention investments.',
    `inventory_disposition_plan` STRING COMMENT 'Plan for managing remaining inventory of the discontinued product, including sell-through strategy, return policies, disposal procedures for expired stock, and write-off accounting treatment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the EOL plan record was last updated.',
    `last_order_date` DATE COMMENT 'Final date by which customers can place new orders for the discontinued product. Orders received after this date will not be accepted.',
    `last_ship_date` DATE COMMENT 'Final date by which the product will be shipped to customers. Typically follows the last order date to allow for order fulfillment.',
    `last_support_date` DATE COMMENT 'Final date by which technical support, warranty service, and customer assistance will be provided for the discontinued product. After this date, no support is available.',
    `manufacturing_stop_date` DATE COMMENT 'Date when production of the discontinued product will cease. Typically precedes the last ship date to allow for inventory depletion.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the EOL plan, including special considerations, stakeholder feedback, or lessons learned from the discontinuation process.',
    `partner_notification_date` DATE COMMENT 'Date when distribution partners, OEMs, and channel partners are formally notified of the product discontinuation, allowing them to adjust their sales and support strategies.',
    `product_regulatory_classification` STRING COMMENT 'Regulatory classification of the discontinued product: RUO (Research Use Only), IVD (In Vitro Diagnostic), CE-IVD (European IVD), LDT (Laboratory Developed Test), or FDA device class (I, II, III). Determines regulatory notification requirements. [ENUM-REF-CANDIDATE: RUO|IVD|CE-IVD|LDT|Class_I|Class_II|Class_III — 7 candidates stripped; promote to reference product]',
    `quality_system_impact_assessment` STRING COMMENT 'Assessment of the impact of the product discontinuation on the Quality Management System (QMS), including document control, training records, validation studies, and audit trails that must be retained per ISO 13485 and GxP requirements.',
    `regulatory_notification_date` DATE COMMENT 'Date when regulatory authorities were formally notified of the product discontinuation. Required for IVD products with active registrations or certifications.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory authorities (FDA, EMA, notified bodies) must be formally notified of the product discontinuation, particularly for IVD and CE-IVD classified products.',
    `regulatory_submission_reference` STRING COMMENT 'Reference number or identifier for the regulatory submission documenting the product discontinuation (e.g., FDA 510(k) withdrawal notice, CE-IVD notification reference).',
    `spare_parts_availability_date` DATE COMMENT 'Final date by which spare parts, consumables, or accessories for the discontinued product will be available for purchase. Relevant for instruments and hardware platforms.',
    `transition_support_offering` STRING COMMENT 'Description of support services offered to customers during the transition period, such as migration assistance, training on replacement products, data transfer services, or extended warranty options.',
    `website_update_date` DATE COMMENT 'Date when the company website, product catalog, and online ordering systems are updated to reflect the EOL status and remove or flag the discontinued product.',
    CONSTRAINT pk_eol_plan PRIMARY KEY(`eol_plan_id`)
) COMMENT 'End-of-life (EOL) plan record for a catalog item being discontinued, capturing EOL announcement date, last order date, last ship date, last support date, reason for discontinuation (technology superseded/low demand/regulatory/strategic), customer notification plan, recommended replacement SKU, transition support offering, and regulatory notification requirements (e.g., FDA 510(k) withdrawal). Ensures structured EOL execution that protects customer relationships and meets regulatory obligations for IVD products.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Unique identifier for this supply agreement record. Primary key.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to the catalog item being sourced through this supply agreement',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier providing the catalog item under this agreement',
    `contract_reference` STRING COMMENT 'Reference identifier to the master supply contract or purchase agreement governing this product-supplier relationship. Links to contract management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit_price in this agreement. May differ from supplier default currency for specific product contracts.',
    `effective_date` DATE COMMENT 'Date when this supply agreement becomes effective. Supports time-based supplier transitions and contract lifecycle management.',
    `expiry_date` DATE COMMENT 'Date when this supply agreement expires or requires renewal. Nullable for evergreen agreements. Enables proactive contract renewal workflows.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this supply agreement is currently active and available for procurement operations. Inactive agreements are retained for historical analysis.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order placed for this catalog item from this supplier. Used for supplier activity tracking and agreement review.',
    `lead_time_days` STRING COMMENT 'Supplier-specific lead time in days from purchase order placement to delivery for this catalog item. Critical for supply chain planning and supplier selection.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity required by this supplier for this catalog item. Influences procurement batch sizing and supplier selection decisions.',
    `preferred_supplier_rank` STRING COMMENT 'Ranking of this supplier for this catalog item (1=primary, 2=secondary, etc.). Used in procurement decision logic and automated sourcing workflows.',
    `qualification_status` STRING COMMENT 'Current qualification status of this supplier for this specific catalog item. Reflects product-specific supplier qualification (e.g., GMP audit results, quality testing outcomes). Values: qualified, conditional, pending, disqualified.',
    `quality_rating` STRING COMMENT 'Product-specific quality rating for this supplier-catalog item combination based on COA compliance, defect rates, and QC results. Values: excellent, good, acceptable, poor, not_rated.',
    `total_quantity_purchased` BIGINT COMMENT 'Cumulative quantity of this catalog item purchased from this supplier across all purchase orders. Supports volume-based pricing negotiations and supplier performance analysis.',
    `unit_price` DECIMAL(18,2) COMMENT 'Negotiated price per unit for this catalog item from this specific supplier. Varies by supplier and is central to multi-sourcing cost optimization.',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'This association product represents the contractual supply relationship between a catalog item and a supplier. It captures supplier-specific sourcing terms, pricing, lead times, and qualification status for each product-supplier combination. Each record links one catalog item to one supplier with attributes that exist only in the context of this specific sourcing arrangement, enabling multi-sourcing strategies, supplier performance comparison, and procurement optimization.. Existence Justification: In genomics biotechnology procurement operations, catalog items (reagent kits, consumables, instruments) are routinely multi-sourced from multiple qualified suppliers to ensure supply chain resilience, cost optimization, and regulatory compliance. Each supplier relationship for a given product has distinct negotiated pricing, lead times, minimum order quantities, and product-specific qualification status. Procurement teams actively manage these supply agreements as operational entities, tracking supplier performance, qualification status, and contract terms for each product-supplier combination.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` (
    `sku_work_center_qualification_id` BIGINT COMMENT 'Unique identifier for this SKU-work center qualification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the manufacturing engineer or quality engineer who performed and approved the qualification of this SKU at this work center.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the SKU being qualified for production at this work center',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to the work center where this SKU is qualified to be manufactured',
    `capacity_units_per_shift` DECIMAL(18,2) COMMENT 'Maximum production capacity in units of this SKU that this work center can produce per shift under standard operating conditions, used for production scheduling and capacity planning. This is relationship-specific because capacity depends on both SKU processing requirements and work center throughput capabilities.',
    `is_preferred_work_center` BOOLEAN COMMENT 'Indicates whether this work center is the preferred/primary production location for this SKU when multiple qualified work centers exist. Used by production scheduling to prioritize work center selection for optimal efficiency and quality.',
    `last_production_date` DATE COMMENT 'Date when this SKU was last produced at this work center, used to identify dormant qualifications that may require revalidation before next use.',
    `maximum_batch_size` STRING COMMENT 'Maximum batch size for producing this SKU at this work center, constrained by equipment capacity, GMP batch size limits, or process validation parameters. This is relationship-specific because maximum batch size depends on both SKU process requirements and work center physical constraints.',
    `minimum_batch_size` STRING COMMENT 'Minimum economical batch size for producing this SKU at this work center, driven by setup time economics and work center characteristics. This is relationship-specific because minimum batch size depends on both SKU economics and work center setup costs.',
    `notes` STRING COMMENT 'Free-text notes capturing special handling requirements, process considerations, or quality observations specific to producing this SKU at this work center.',
    `qualification_expiry_date` DATE COMMENT 'Date when the qualification of this SKU at this work center expires and requires requalification, driven by GMP periodic review requirements, equipment changes, or process updates. This is relationship-specific because different SKU-work center combinations may have different requalification schedules based on risk assessment.',
    `qualification_status` STRING COMMENT 'Current status of the SKU-work center qualification: active (qualified and available for production scheduling), expired (qualification period ended, requalification required), suspended (temporarily not available due to quality hold or equipment issue), pending_requalification (in process of renewal), obsolete (SKU discontinued or work center decommissioned).',
    `qualified_date` DATE COMMENT 'Date when this SKU was qualified for production at this work center through process validation, equipment qualification, and quality approval. Tracks when the SKU-work center combination was approved for GMP production.',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Setup or changeover time in minutes required to configure this work center to begin production of this specific SKU variant, including equipment configuration, tooling changes, and line clearance. This is relationship-specific because setup time depends on both the SKU configuration (e.g., 8-plex vs 96-plex) and the work center capabilities.',
    `standard_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Standard production cycle time in minutes to produce one unit of this SKU at this specific work center, used for production scheduling and capacity planning. This is SKU-work center specific because different SKUs have different processing requirements and different work centers have different equipment capabilities.',
    `yield_target_percent` DECIMAL(18,2) COMMENT 'Target production yield percentage for this SKU when manufactured at this work center, representing the expected ratio of good units to total units started. This is relationship-specific because yield varies by SKU complexity and work center capability/maturity.',
    CONSTRAINT pk_sku_work_center_qualification PRIMARY KEY(`sku_work_center_qualification_id`)
) COMMENT 'This association product represents the manufacturing qualification relationship between a SKU and a work center. It captures the production engineering parameters, capacity planning data, and quality standards that exist only when a specific SKU variant is qualified to be manufactured at a specific work center. Each record links one SKU to one work center with manufacturing-specific attributes including cycle times, setup requirements, yield targets, and qualification status that cannot exist on either the SKU master or work center master alone.. Existence Justification: In genomics biotech manufacturing, SKUs represent specific product configurations (e.g., 8-plex flow cell vs 96-sample kit) that can be manufactured at multiple qualified work centers, and each work center is qualified to produce multiple SKU variants. Manufacturing engineering actively manages these qualifications as operational records, tracking SKU-specific cycle times, setup requirements, yield targets, and qualification status for each SKU-work center combination. This is not an analytical correlation but an operational manufacturing engineering process where qualification records are created through validation studies, maintained with periodic requalification, and used daily for production scheduling and capacity planning.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` (
    `retention_assignment_id` BIGINT COMMENT 'Unique identifier for this product-policy assignment record. Primary key for the association.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to the catalog item (sequencing platform, reagent kit, software, or service) that generates or is associated with data assets governed by the assigned retention policy.',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to the data retention and disposal policy that governs data assets associated with this catalog item during the effective period.',
    `approval_authority` STRING COMMENT 'Name or role of the individual or committee that approved this retention policy assignment, particularly when override_reason is present. Required for regulatory audit trail demonstrating proper governance of data retention decisions. Explicitly identified in detection phase relationship data.',
    `assigned_by` STRING COMMENT 'User ID or name of the data governance team member who created this policy assignment record. Part of audit trail for compliance purposes.',
    `assignment_date` DATE COMMENT 'Date when this retention policy was formally assigned to the catalog item in the system. May differ from effective_start_date when assignments are made in advance of product launch or policy change effective dates.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this policy assignment: active (currently in effect), superseded (replaced by newer assignment), pending (scheduled for future effective date), revoked (cancelled before effective date).',
    `effective_end_date` DATE COMMENT 'Date when this retention policy assignment expires or is superseded by a new policy assignment. Nullable for currently active assignments. Used to track historical policy changes due to regulatory updates, product reclassification, or jurisdictional changes. Explicitly identified in detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'Date when this retention policy assignment becomes effective for the catalog item. Marks the beginning of the period during which data generated by or associated with this product must be retained according to this policy. Explicitly identified in detection phase relationship data.',
    `geographic_scope` STRING COMMENT 'Geographic regions or jurisdictions where this specific policy assignment applies for this catalog item. Allows for jurisdiction-specific retention requirements when a product is sold globally (e.g., EU, US, China).',
    `override_reason` STRING COMMENT 'Business justification for assigning a non-standard retention policy to this catalog item, such as extended retention for ongoing litigation, clinical trial requirements, or customer contractual obligations. Nullable when standard policy assignment applies. Explicitly identified in detection phase relationship data.',
    `policy_version_at_assignment` STRING COMMENT 'Version identifier of the retention policy at the time of assignment to this catalog item. Critical for audit trail and regulatory compliance to demonstrate which policy rules were in effect when data was generated. Explicitly identified in detection phase relationship data.',
    `regulatory_trigger` STRING COMMENT 'Specific regulatory event or change that triggered this policy assignment or reassignment, such as FDA 510k clearance, CE-IVD certification, CLIA compliance requirement, or GDPR applicability determination.',
    CONSTRAINT pk_retention_assignment PRIMARY KEY(`retention_assignment_id`)
) COMMENT 'This association product represents the regulatory and compliance-driven assignment of data retention policies to catalog items at Genomics Biotech. It captures the effective period during which a specific retention policy governs a products associated data (sequencing outputs, clinical reports, batch records), the policy version in effect at assignment time, and any override justifications required for regulatory compliance. Each record links one catalog item to one retention policy with temporal and audit attributes that exist only in the context of this regulatory assignment relationship.. Existence Justification: In genomics biotechnology operations, catalog items (sequencing platforms, reagent kits, IVD devices, software) generate or are associated with multiple types of data assets that are governed by different retention policies over the product lifecycle. A single catalog item can have multiple retention policies simultaneously (e.g., an IVD sequencing platform generates both clinical genomic reports governed by CLIA 10-year retention and GxP batch records governed by 21 CFR Part 11 requirements) and over time (regulatory reclassification from RUO to IVD triggers policy changes). Conversely, a single retention policy applies to multiple catalog items (all CE-IVD Class II devices share the same EU MDR retention requirements). The business actively manages these assignments through data governance processes, tracking effective dates, policy versions, regulatory triggers, and approval authorities.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`validation` (
    `validation_id` BIGINT COMMENT 'Unique identifier for this product-validation coverage record. Primary key for the association.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to the catalog item being validated. References the commercial product offering (instrument, reagent, software, service) that is subject to this validation study.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who created this product-validation coverage record. Typically a quality assurance specialist or validation engineer.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified this product-validation coverage record.',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to the validation study providing regulatory evidence. References the analytical, process, or software validation study that covers this catalog item.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this product-validation association record was created in the system.',
    `deviation_count` STRING COMMENT 'Number of deviations or out-of-specification results observed for this catalog item during the validation study. Used for risk assessment and determining if passed_with_deviation status is appropriate.',
    `effective_date` DATE COMMENT 'Date when the validation coverage became effective for this catalog item. Represents when the product can be claimed as validated under this study. Critical for regulatory submissions, quality certificates, and compliance documentation.',
    `expiration_date` DATE COMMENT 'Date when this validation coverage expires or requires revalidation. Applicable for time-limited validations, stability studies, or periodic revalidation requirements. Null for validations that remain effective until superseded.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this product-validation association record was last modified.',
    `lot_range_end` STRING COMMENT 'Ending lot number or batch identifier for reagent/consumable catalog items covered by this validation. Defines the upper bound of lot coverage. Null if validation applies to all future lots.',
    `lot_range_start` STRING COMMENT 'Starting lot number or batch identifier for reagent/consumable catalog items covered by this validation. Applicable when validation is performed on representative lots and coverage extends to a defined lot range.',
    `notes` STRING COMMENT 'Free-text notes capturing product-specific validation considerations, limitations, or special conditions for this catalog item within the study. May include configuration dependencies, environmental conditions, or operator training requirements.',
    `phase` STRING COMMENT 'Identifies which phase of process validation or validation lifecycle this coverage represents. Supports FDA process validation guidance (phase 1/2/3) and change control validation requirements. Different catalog items may enter validation at different phases.',
    `product_configuration_tested` STRING COMMENT 'Specific product configuration, version, or SKU variant tested in this validation study. Critical for products with multiple configurations (e.g., NovaSeq 6000 with different flow cell types, reagent kit lot ranges, software version ranges). Defines the exact product specification covered by validation evidence.',
    `regulatory_claim_supported` STRING COMMENT 'Specific regulatory claim or intended use statement that this validation evidence supports for this catalog item (e.g., RUO use only, IVD for detection of BRCA1/2 variants, CE-IVD marked for EU). Links validation evidence to marketing claims and labeling.',
    `validation_scope` STRING COMMENT 'Defines the breadth of validation coverage for this catalog item within the study. Indicates whether the validation applies to the entire product, a product family, a specific configuration, or a component. Critical for determining regulatory applicability and claims scope.',
    `validation_status` STRING COMMENT 'Current status of validation coverage for this specific catalog item within the study. Tracks whether the product has passed validation, is undergoing validation, or failed validation. Essential for regulatory compliance tracking and product release decisions.',
    CONSTRAINT pk_validation PRIMARY KEY(`validation_id`)
) COMMENT 'This association product represents the validation coverage relationship between catalog items and validation studies in the genomics biotech regulatory compliance process. It captures which validation studies apply to which product configurations, tracking validation scope, phase, configuration tested, status, and effective dates. Each record links one catalog item to one validation study with attributes that exist only in the context of this specific validation coverage relationship.. Existence Justification: In genomics biotech regulatory operations, a single catalog item (e.g., NovaSeq sequencing platform) requires multiple validation studies covering different aspects: analytical method validation, software validation (CSV), equipment qualification (IQ/OQ/PQ), process validation, and potentially clinical validation for IVD claims. Conversely, a single validation study frequently covers multiple catalog items when validating a product family, platform, or shared process (e.g., a platform validation study covering multiple assay configurations, or a stability-indicating method validation covering an entire reagent kit family). The business actively manages this many-to-many relationship through validation planning, scope definition, and regulatory submission preparation.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`citation` (
    `citation_id` BIGINT COMMENT 'Unique identifier for this product citation relationship. Primary key.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to the catalog item that was cited or used in the publication',
    `publication_id` BIGINT COMMENT 'Foreign key linking to the scientific publication that cites or references the product',
    `added_date` DATE COMMENT 'Date when this product-publication citation relationship was identified and recorded in the system. Supports tracking of citation discovery and marketing response timing.',
    `context` STRING COMMENT 'Section of the publication where the product is cited or mentioned (e.g., methods section for sequencing platforms, results for performance data, acknowledgments for reagent donations). Identified in detection phase as relationship-specific data.',
    `marketing_approval_date` DATE COMMENT 'Date when marketing approved this citation for promotional use. Nullable if not yet reviewed or not approved.',
    `marketing_approved` BOOLEAN COMMENT 'Indicates whether this citation has been approved by marketing for use in promotional materials, sales presentations, and customer-facing content. Identified in detection phase as relationship-specific data.',
    `notes` STRING COMMENT 'Free-text notes about the citation context, significance, competitive implications, or marketing value. Used by product marketing and competitive intelligence teams.',
    `performance_data_included` BOOLEAN COMMENT 'Indicates whether the publication includes quantitative performance data, benchmarks, or comparative analysis of the product. Critical for marketing use and competitive intelligence. Identified in detection phase as relationship-specific data.',
    `product_role` STRING COMMENT 'Role the product played in the research study (e.g., primary sequencing platform, reagent used in sample prep, analysis software, comparison benchmark against competitor). Identified in detection phase as relationship-specific data.',
    `verified_flag` BOOLEAN COMMENT 'Indicates whether the citation has been manually verified by a reviewer (to confirm the product was actually used and cited correctly, not just mentioned in passing).',
    CONSTRAINT pk_citation PRIMARY KEY(`citation_id`)
) COMMENT 'This association product represents the Citation relationship between catalog_item and publication. It captures the use and mention of Genomics Biotech commercial products in scientific publications, conference presentations, and preprints. Each record links one catalog_item to one publication with attributes that describe how the product was used, the context of citation, performance data inclusion, and marketing approval status for promotional use.. Existence Justification: In genomics biotechnology, scientific publications routinely cite multiple commercial products used in research (sequencing platforms, reagents, software, consumables), and each product is cited across many publications. Marketing teams actively manage these product-publication citation relationships for sales enablement, competitive positioning, and promotional materials. The relationship itself carries meaningful business data including citation context, product role in the study, performance data inclusion, and marketing approval status.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`product`.`bundle` (
    `bundle_id` BIGINT COMMENT 'Primary key for bundle',
    `parent_bundle_id` BIGINT COMMENT 'Self-referencing FK on bundle (parent_bundle_id)',
    `bundle_category` STRING COMMENT 'High‑level functional category of the bundle.',
    `bundle_code` STRING COMMENT 'External catalog code used to reference the bundle in sales and ordering systems.',
    `compliance_status` STRING COMMENT 'Current compliance verification status of the bundle.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the bundle record was first created in the system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the bundle pricing.',
    `data_classification` STRING COMMENT 'Internal data classification level for the bundle record.',
    `deprecation_date` DATE COMMENT 'Date the bundle was officially retired or marked for phase‑out.',
    `bundle_description` STRING COMMENT 'Detailed textual description of the bundles contents and purpose.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Discount applied to the list price expressed as a percentage.',
    `effective_from` DATE COMMENT 'Date when the bundle becomes valid for sale or use.',
    `effective_until` DATE COMMENT 'Date when the bundle is no longer offered (null if open‑ended).',
    `is_customizable` BOOLEAN COMMENT 'Indicates whether the bundle can be customized for a specific customer.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the bundle record.',
    `list_price` DECIMAL(18,2) COMMENT 'Standard list price of the bundle before discounts.',
    `bundle_name` STRING COMMENT 'Human‑readable name of the product bundle.',
    `net_price` DECIMAL(18,2) COMMENT 'Final price after discount; used for invoicing.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the bundle.',
    `regulatory_classification` STRING COMMENT 'Regulatory category of the bundle (e.g., Research Use Only, In‑Vitro Diagnostic).',
    `release_date` DATE COMMENT 'Date the bundle was first released to customers.',
    `revision_number` STRING COMMENT 'Sequential revision number tracking changes to the bundle definition.',
    `bundle_status` STRING COMMENT 'Current lifecycle state of the bundle.',
    `support_level` STRING COMMENT 'Level of technical support offered with the bundle.',
    `target_market` STRING COMMENT 'Primary market segment the bundle is intended for.',
    `total_units` STRING COMMENT 'Total number of individual items or licenses included in the bundle.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Combined weight of all physical components in the bundle, expressed in kilograms.',
    `bundle_type` STRING COMMENT 'Category indicating whether the bundle is a physical product, a service, software license, or consumable.',
    `version` STRING COMMENT 'Version identifier for the bundle (e.g., v1.0, v2.1).',
    `warranty_period_months` STRING COMMENT 'Warranty duration provided for the bundle, in months.',
    CONSTRAINT pk_bundle PRIMARY KEY(`bundle_id`)
) COMMENT 'Master reference table for bundle. Referenced by bundle_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `genomics_biotech_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_replacement_sku_id` FOREIGN KEY (`replacement_sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ADD CONSTRAINT `fk_product_family_parent_family_id` FOREIGN KEY (`parent_family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_tertiary_product_substitute_component_sku_id` FOREIGN KEY (`tertiary_product_substitute_component_sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_primary_bom_sku_id` FOREIGN KEY (`primary_bom_sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `genomics_biotech_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ADD CONSTRAINT `fk_product_pricing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ADD CONSTRAINT `fk_product_regulatory_classification_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ADD CONSTRAINT `fk_product_change_notice_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_superseded_by_compatibility_matrix_id` FOREIGN KEY (`superseded_by_compatibility_matrix_id`) REFERENCES `genomics_biotech_ecm`.`product`.`compatibility_matrix`(`compatibility_matrix_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_target_sku_id` FOREIGN KEY (`target_sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ADD CONSTRAINT `fk_product_license_entitlement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ADD CONSTRAINT `fk_product_eol_plan_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ADD CONSTRAINT `fk_product_supply_agreement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ADD CONSTRAINT `fk_product_sku_work_center_qualification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ADD CONSTRAINT `fk_product_retention_assignment_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ADD CONSTRAINT `fk_product_validation_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ADD CONSTRAINT `fk_product_citation_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_parent_bundle_id` FOREIGN KEY (`parent_bundle_id`) REFERENCES `genomics_biotech_ecm`.`product`.`bundle`(`bundle_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `genomics_biotech_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `average_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price (ASP)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `average_selling_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `bom_reference` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Reference');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `bundle_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bundle Discount Percentage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `bundle_eligibility_rules` SET TAGS ('dbx_business_glossary_term' = 'Bundle Eligibility Rules');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'GMP|non-GMP|GLP|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `instrument_platform_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Instrument Platform Compatibility');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `is_bundle` SET TAGS ('dbx_business_glossary_term' = 'Is Bundle Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Product Launch Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Stage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `list_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `marketing_tagline` SET TAGS ('dbx_business_glossary_term' = 'Marketing Tagline');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `product_url` SET TAGS ('dbx_business_glossary_term' = 'Product Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `product_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `read_length` SET TAGS ('dbx_business_glossary_term' = 'Read Length in Base Pairs');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE-IVD|LDT');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `requires_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Requires Cold Chain Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `sequencing_chemistry` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Chemistry Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `service_contract_available` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Available Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Days');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Product Short Name');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `software_license_type` SET TAGS ('dbx_business_glossary_term' = 'Software License Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `software_license_type` SET TAGS ('dbx_value_regex' = 'perpetual|subscription|concurrent|node_locked|floating|trial');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `storage_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature in Celsius');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `storage_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature in Celsius');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `throughput_capacity` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period in Months');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `replacement_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `average_selling_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price (ASP) in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `average_selling_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `configuration` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Configuration');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `country_availability` SET TAGS ('dbx_business_glossary_term' = 'Country Availability List');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `introduction_date` SET TAGS ('dbx_business_glossary_term' = 'Introduction Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `is_bundle_component` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `is_hazardous_material` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `is_orderable` SET TAGS ('dbx_business_glossary_term' = 'Orderable Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `is_shippable` SET TAGS ('dbx_business_glossary_term' = 'Shippable Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_launch|obsolete');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_business_glossary_term' = 'List Price in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple Quantity');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size Quantity');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE-IVD|LDT|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `requires_cold_chain` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Requirement Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `sales_channel_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Eligibility');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `sku_description` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Description');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `sku_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Volume (Liters)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `parent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Family Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `application_area` SET TAGS ('dbx_business_glossary_term' = 'Application Area');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `average_selling_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price (ASP) in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `average_selling_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_business_glossary_term' = 'Competitive Positioning Statement');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `cross_sell_affinity_score` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Affinity Score');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `data_privacy_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End-of-Life (EOL) Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_business_glossary_term' = 'Product Family Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `family_description` SET TAGS ('dbx_business_glossary_term' = 'Product Family Description');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Product Family Name');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `family_type` SET TAGS ('dbx_business_glossary_term' = 'Product Family Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `family_type` SET TAGS ('dbx_value_regex' = 'instrument|reagent|consumable|software|service|assay');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `go_to_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Go-To-Market (GTM) Segment');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Product Family Launch Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Stage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `patent_portfolio_reference` SET TAGS ('dbx_business_glossary_term' = 'Patent Portfolio Reference');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `patent_portfolio_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `quality_management_system_scope` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System (QMS) Scope');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `quality_management_system_scope` SET TAGS ('dbx_value_regex' = 'ISO_13485|ISO_9001|GMP|GLP|none');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `sales_channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Mix');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise|custom');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Tier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|strategic|maintenance|sunset');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Margin Percentage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ALTER COLUMN `training_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training or Certification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `average_selling_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price (ASP) in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `average_selling_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `ce_marking_status` SET TAGS ('dbx_business_glossary_term' = 'Conformité Européenne (CE) Marking Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `clia_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `cluster_density_k_per_mm2` SET TAGS ('dbx_business_glossary_term' = 'Cluster Density (Thousands per Square Millimeter)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `cnv_resolution_kb` SET TAGS ('dbx_business_glossary_term' = 'Copy Number Variation (CNV) Resolution (Kilobases)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `cost_of_goods_sold_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `cost_of_goods_sold_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `coverage_depth_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `crispr_target_specificity_percent` SET TAGS ('dbx_business_glossary_term' = 'Clustered Regularly Interspaced Short Palindromic Repeats (CRISPR) Target Specificity (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `flow_cell_type` SET TAGS ('dbx_business_glossary_term' = 'Flow Cell Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `instrument_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Instrument Compatibility');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `iso_13485_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 13485 Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `library_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Library Preparation Compatibility');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `lod_copies_per_ml` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (Copies per Milliliter)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `multiplexing_capacity` SET TAGS ('dbx_business_glossary_term' = 'Multiplexing Capacity');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `pcr_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Polymerase Chain Reaction (PCR) Cycle Count');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `product_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Stage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `q30_score_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Q30 Score Threshold (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `reaction_volume_ul` SET TAGS ('dbx_business_glossary_term' = 'Reaction Volume (Microliters)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `reactions_per_kit` SET TAGS ('dbx_business_glossary_term' = 'Reactions per Kit');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `read_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Read Length (Base Pairs)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `snp_array_probe_count` SET TAGS ('dbx_business_glossary_term' = 'Single Nucleotide Polymorphism (SNP) Array Probe Count');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `software_version_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Software Version Compatibility Matrix');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|obsolete|superseded');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `throughput_gb_per_run` SET TAGS ('dbx_business_glossary_term' = 'Throughput (Gigabases per Run)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) in Hours');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Component Product Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `tertiary_product_substitute_component_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Component Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `assembly_instruction` SET TAGS ('dbx_business_glossary_term' = 'Assembly Instruction');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|obsolete|frozen');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'production|engineering|costing|commercial_bundle|service|planning');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `co_product_indicator` SET TAGS ('dbx_business_glossary_term' = 'Co-Product Indicator');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `component_position` SET TAGS ('dbx_business_glossary_term' = 'Component Position Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `component_quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `cost_rollup_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Rollup Method');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `cost_rollup_method` SET TAGS ('dbx_value_regex' = 'standard|average|fifo|lifo|actual');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `eligibility_rules` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rules');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `is_critical_component` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Indicator');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `is_phantom_assembly` SET TAGS ('dbx_business_glossary_term' = 'Phantom Assembly Indicator');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `lead_time_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Offset Days');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `lot_traceability_required` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability Required Indicator');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `operation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Operation Sequence Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE_IVD|LDT|GMP|non_regulated');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `scrap_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percentage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `primary_bom_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Component Product Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `alternative_item_group` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Group');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `assembly_instruction` SET TAGS ('dbx_business_glossary_term' = 'Assembly Instruction');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `bom_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|obsolete');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `component_cost` SET TAGS ('dbx_business_glossary_term' = 'Component Unit Cost');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `component_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `component_role` SET TAGS ('dbx_business_glossary_term' = 'Component Role');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `critical_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `engineering_change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number (ECN)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `expiry_control_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Expiry Control Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'raw_material|semi_finished|packaging|phantom|bundle_component|service');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `lead_time_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Offset Days');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `lot_control_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Control Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Component Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `reference_designator` SET TAGS ('dbx_business_glossary_term' = 'Reference Designator');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE_IVD|GMP|non_regulated');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `revenue_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Percentage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `revenue_allocation_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Percentage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `serial_number_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Control Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `substitution_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `supply_type` SET TAGS ('dbx_business_glossary_term' = 'Supply Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `supply_type` SET TAGS ('dbx_value_regex' = 'in_house|external|subcontract|customer_supplied');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|expired|superseded');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `asp` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price (ASP)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `asp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Price (COGS)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `cost_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pricing Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Pricing Owner');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `price_list_version` SET TAGS ('dbx_business_glossary_term' = 'Price List Version');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'ruo|ivd|ce_ivd|ldt|gmp|research_grade');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|oem|online|government|academic');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `transfer_price` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `transfer_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `volume_tier_1_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `volume_tier_1_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Quantity Threshold');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `volume_tier_2_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `volume_tier_2_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Quantity Threshold');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `volume_tier_3_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 3 Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ALTER COLUMN `volume_tier_3_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 3 Quantity Threshold');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `regulatory_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'Authorized|Pending|Withdrawn|Suspended|Expired');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `biocompatibility_testing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Biocompatibility Testing Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `ce_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Conformité Européenne (CE) Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `clinical_evidence_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Evidence Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Not Controlled');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `cybersecurity_requirements_flag` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Requirements Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `data_privacy_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Compliance Required');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `environmental_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Required');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `fda_device_class` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Device Class');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `fda_device_class` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III|Not Applicable');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `fda_product_code` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Product Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `gmdn_code` SET TAGS ('dbx_business_glossary_term' = 'Global Medical Device Nomenclature (GMDN) Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `gmdn_term_name` SET TAGS ('dbx_business_glossary_term' = 'Global Medical Device Nomenclature (GMDN) Term Name');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `intended_use_classification` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `intended_use_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE-IVD|LDT|ASR|GMP');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `ivdr_risk_class` SET TAGS ('dbx_business_glossary_term' = 'In Vitro Diagnostic Regulation (IVDR) Risk Class');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `ivdr_risk_class` SET TAGS ('dbx_value_regex' = 'Class A|Class B|Class C|Class D|Not Applicable');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `labeling_language_required` SET TAGS ('dbx_business_glossary_term' = 'Labeling Language Required');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `notified_body_number` SET TAGS ('dbx_business_glossary_term' = 'Notified Body Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `post_market_surveillance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `quality_management_system_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System (QMS) Standard');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `quality_management_system_standard` SET TAGS ('dbx_value_regex' = 'ISO 13485|FDA 21 CFR Part 820|MDSAP|Other');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_value_regex' = '510(k)|PMA|De Novo|Exempt|CE Self-Declaration|CE Notified Body|NMPA Class I|NMPA Class II|NMPA Class III|TGA Class I|TGA Class II|TGA Class III|TGA Class IV|Other');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `reimbursement_code` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_value_regex' = 'Approved|Pending|Not Applicable|Denied');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `software_validation_level` SET TAGS ('dbx_business_glossary_term' = 'Software Validation Level');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `software_validation_level` SET TAGS ('dbx_value_regex' = 'Level A - Minor|Level B - Moderate|Level C - Major|Not Applicable');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `sterilization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `udi_di` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identification Device Identifier (UDI-DI)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `udi_issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identification (UDI) Issuing Agency');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `udi_issuing_agency` SET TAGS ('dbx_value_regex' = 'GS1|HIBCC|ICCBBA|IFA|Other');
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ALTER COLUMN `udi_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identification (UDI) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Plan Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Owner User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Target Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `tertiary_launch_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `tertiary_launch_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `tertiary_launch_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `commercial_ops_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Operations Sign-Off Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `commercial_ops_signoff_status` SET TAGS ('dbx_business_glossary_term' = 'Commercial Operations Sign-Off Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `commercial_ops_signoff_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_business_glossary_term' = 'Competitive Positioning');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `cross_sell_products` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Products');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `field_application_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Field Application Scientist (FAS) Training Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `field_application_training_status` SET TAGS ('dbx_business_glossary_term' = 'Field Application Scientist (FAS) Training Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `field_application_training_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|certified|at_risk');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `first_order_actual_date` SET TAGS ('dbx_business_glossary_term' = 'First Order Actual Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `first_order_target_date` SET TAGS ('dbx_business_glossary_term' = 'First Order Target Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `first_shipment_actual_date` SET TAGS ('dbx_business_glossary_term' = 'First Shipment Actual Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `first_shipment_target_date` SET TAGS ('dbx_business_glossary_term' = 'First Shipment Target Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `key_value_propositions` SET TAGS ('dbx_business_glossary_term' = 'Key Value Propositions');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Launch Actual Spend United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Announcement Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Launch Budget United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Launch Plan Name');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Launch Plan Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_plan_number` SET TAGS ('dbx_value_regex' = '^LP-[0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_readiness_score` SET TAGS ('dbx_business_glossary_term' = 'Launch Readiness Score');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Launch Risk Assessment');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_risk_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_status` SET TAGS ('dbx_business_glossary_term' = 'Launch Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_type` SET TAGS ('dbx_business_glossary_term' = 'Launch Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `launch_type` SET TAGS ('dbx_value_regex' = 'global|regional|limited_release|controlled_launch|soft_launch|pilot');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `manufacturing_readiness_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Readiness Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `manufacturing_readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Readiness Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `manufacturing_readiness_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|validation_complete|production_ready|at_risk');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Launch Plan Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `planned_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Launch Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `post_launch_review_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Launch Review Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `post_launch_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Post-Launch Review Outcome');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `post_launch_review_outcome` SET TAGS ('dbx_value_regex' = 'exceeded_expectations|met_expectations|partially_met|below_expectations|not_reviewed');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE_IVD|LDT|investigational|exempt');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `regulatory_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Clearance Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `regulatory_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Clearance Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `regulatory_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_review|approved|conditional_approval|denied');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Tier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tactical');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `target_customer_segments` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segments');
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ALTER COLUMN `target_geographies` SET TAGS ('dbx_business_glossary_term' = 'Target Geographies');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `change_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notice (PCN) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `affected_product_families` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Families');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `approval_chain` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'major|minor|administrative');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `cost_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact (United States Dollars)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `cost_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `customer_notification_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Lead Time (Days)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `document_references` SET TAGS ('dbx_business_glossary_term' = 'Document References');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `initiator_department` SET TAGS ('dbx_business_glossary_term' = 'Initiator Department');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `initiator_name` SET TAGS ('dbx_business_glossary_term' = 'Initiator Name');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `last_time_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Ship (LTS) Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notice (PCN) Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `pcn_number` SET TAGS ('dbx_value_regex' = '^PCN-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `pcn_status` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notice (PCN) Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `pcn_type` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notice (PCN) Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `quality_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `regulatory_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Assessment');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `regulatory_submission_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_value_regex' = '510k|pma_supplement|ce_ivd_notification|annual_report|none');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `related_change_orders` SET TAGS ('dbx_business_glossary_term' = 'Related Change Orders');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `supply_chain_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `validation_protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Reference');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `validation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Validation Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `compatibility_matrix_id` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Matrix Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Source Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `superseded_by_compatibility_matrix_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Compatibility Matrix Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `target_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Target Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `tertiary_compatibility_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `tertiary_compatibility_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `tertiary_compatibility_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `application_area` SET TAGS ('dbx_business_glossary_term' = 'Application Area');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `bioinformatics_pipeline_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Bioinformatics Pipeline Compatibility');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `compatibility_conditions` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Conditions and Restrictions');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `customer_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `directionality` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Directionality');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `directionality` SET TAGS ('dbx_value_regex' = 'one-way|bidirectional');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `field_application_notes` SET TAGS ('dbx_business_glossary_term' = 'Field Application Scientist (FAS) Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `flow_cell_compatibility_notes` SET TAGS ('dbx_business_glossary_term' = 'Flow Cell Compatibility Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `instrument_compatibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Instrument Compatibility Scope');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `library_preparation_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Library Preparation Compatibility');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `lot_traceability_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Relationship Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `performance_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Impact Description');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `price_differential_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Differential Percentage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `quality_control_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Requirements');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE-IVD|LDT|investigational');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Relationship Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending-validation|deprecated|superseded');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Relationship Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'validated-compatible|not-validated|conditionally-compatible|substitute-equivalent|substitute-upgrade|cross-reference');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `source_version_max` SET TAGS ('dbx_business_glossary_term' = 'Source Item Maximum Version');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `source_version_min` SET TAGS ('dbx_business_glossary_term' = 'Source Item Minimum Version');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `substitution_priority` SET TAGS ('dbx_business_glossary_term' = 'Substitution Priority Rank');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `target_version_max` SET TAGS ('dbx_business_glossary_term' = 'Target Item Maximum Version');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `target_version_min` SET TAGS ('dbx_business_glossary_term' = 'Target Item Minimum Version');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `validation_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Validation Evidence Reference');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `software_release_id` SET TAGS ('dbx_business_glossary_term' = 'Software Release ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Software Product ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qa Approved By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'API (Application Programming Interface) Version');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `api_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `authentication_methods_supported` SET TAGS ('dbx_business_glossary_term' = 'Authentication Methods Supported');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `backward_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Backward Compatible Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `build_number` SET TAGS ('dbx_business_glossary_term' = 'Build Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `ce_mark_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'CE (Conformité Européenne) Mark Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'Checksum SHA-256');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{64}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `docker_image_tag` SET TAGS ('dbx_business_glossary_term' = 'Docker Image Tag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_business_glossary_term' = 'Encryption Standard');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `end_of_support_date` SET TAGS ('dbx_business_glossary_term' = 'End of Support Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `fda_clearance_number` SET TAGS ('dbx_business_glossary_term' = 'FDA (Food and Drug Administration) Clearance Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `git_commit_hash` SET TAGS ('dbx_business_glossary_term' = 'Git Commit Hash');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `git_commit_hash` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{40}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `installation_package_url` SET TAGS ('dbx_business_glossary_term' = 'Installation Package URL (Uniform Resource Locator)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `installation_package_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `known_issues_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Known Issues Log Reference');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `license_model` SET TAGS ('dbx_business_glossary_term' = 'License Model');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `license_model` SET TAGS ('dbx_value_regex' = 'perpetual|subscription|saas|open_source|trial');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `license_terms_url` SET TAGS ('dbx_business_glossary_term' = 'License Terms URL (Uniform Resource Locator)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `license_terms_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `migration_guide_url` SET TAGS ('dbx_business_glossary_term' = 'Migration Guide URL (Uniform Resource Locator)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `migration_guide_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `minimum_system_requirements` SET TAGS ('dbx_business_glossary_term' = 'Minimum System Requirements');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `package_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Package Size (Megabytes)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `planned_release_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Release Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `qa_approval_status` SET TAGS ('dbx_business_glossary_term' = 'QA (Quality Assurance) Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `qa_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `qa_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'QA (Quality Assurance) Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `recommended_system_requirements` SET TAGS ('dbx_business_glossary_term' = 'Recommended System Requirements');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE_IVD|LDT|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_manager` SET TAGS ('dbx_business_glossary_term' = 'Release Manager');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_name` SET TAGS ('dbx_business_glossary_term' = 'Release Name');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_notes_summary` SET TAGS ('dbx_business_glossary_term' = 'Release Notes Summary');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_notes_url` SET TAGS ('dbx_business_glossary_term' = 'Release Notes URL (Uniform Resource Locator)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_notes_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Release Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(-[a-zA-Z0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'planned|in_development|testing|released|deprecated|end_of_life');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'major|minor|patch|hotfix|beta|alpha');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `security_certification` SET TAGS ('dbx_business_glossary_term' = 'Security Certification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `supported_cloud_platforms` SET TAGS ('dbx_business_glossary_term' = 'Supported Cloud Platforms');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `supported_os_platforms` SET TAGS ('dbx_business_glossary_term' = 'Supported Operating System (OS) Platforms');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `training_materials_url` SET TAGS ('dbx_business_glossary_term' = 'Training Materials URL (Uniform Resource Locator)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `training_materials_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `license_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'License Entitlement Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `activation_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Activation Mechanism');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `activation_mechanism` SET TAGS ('dbx_value_regex' = 'online|offline|token_based|hardware_dongle|cloud_native');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `api_call_limit` SET TAGS ('dbx_business_glossary_term' = 'API (Application Programming Interface) Call Limit');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `compliance_audit_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Requirement');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `compliance_audit_requirement` SET TAGS ('dbx_value_regex' = 'none|annual|quarterly|on_demand|continuous_telemetry');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `data_processing_limit_gb` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Limit (Gigabytes)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `entitlement_description` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Description');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `entitlement_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Duration (Months)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `entitlement_name` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Name');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `gdpr_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Compliance Required');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `geographic_usage_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Usage Restriction');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `hipaa_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'HIPAA (Health Insurance Portability and Accountability Act) Compliance Required');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `is_perpetual` SET TAGS ('dbx_business_glossary_term' = 'Is Perpetual License');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `license_key_generation_method` SET TAGS ('dbx_business_glossary_term' = 'License Key Generation Method');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `license_key_generation_method` SET TAGS ('dbx_value_regex' = 'manual|automated_api|token_based|hardware_fingerprint|cloud_entitlement');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval|retired');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'node_locked|floating|site|cloud|saas_subscription|perpetual');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `licensed_feature_set` SET TAGS ('dbx_business_glossary_term' = 'Licensed Feature Set');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `maintenance_included` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Included');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `max_compute_nodes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Compute Nodes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `max_concurrent_users` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Users');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `sample_throughput_limit` SET TAGS ('dbx_business_glossary_term' = 'Sample Throughput Limit');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `storage_quota_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Quota (Gigabytes)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `sublicensing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `support_tier` SET TAGS ('dbx_business_glossary_term' = 'Support Tier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `support_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|enterprise|none');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `telemetry_reporting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Reporting Enabled');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `training_entitlement` SET TAGS ('dbx_business_glossary_term' = 'Training Entitlement');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `transfer_restriction` SET TAGS ('dbx_business_glossary_term' = 'Transfer Restriction');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `transfer_restriction` SET TAGS ('dbx_value_regex' = 'non_transferable|transferable_with_approval|freely_transferable');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `upgrade_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligibility');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `upgrade_eligibility` SET TAGS ('dbx_value_regex' = 'full_upgrade|minor_version_only|no_upgrade|maintenance_only|feature_add_on');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `usage_restriction_terms` SET TAGS ('dbx_business_glossary_term' = 'Usage Restriction Terms');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` SET TAGS ('dbx_subdomain' = 'manufacturing_operations');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `service_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `quality_training_curriculum_id` SET TAGS ('dbx_business_glossary_term' = 'Training Curriculum Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `deliverables_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Description');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `materials_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Materials Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `maximum_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `minimum_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Notice Days');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `prerequisite_services` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Services');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'fixed_fee|time_and_materials|subscription|per_sample|per_run');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `remote_delivery_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Delivery Capable Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Hours');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `service_owner` SET TAGS ('dbx_business_glossary_term' = 'Service Owner');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|under_development|pilot');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `service_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Service Subcategory');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise|critical');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `standard_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Duration Days');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `standard_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Standard Duration Hours');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `standard_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Price United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `standard_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `travel_expenses_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Travel Expenses Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `warranty_period_days` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Days');
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `eol_plan_id` SET TAGS ('dbx_business_glossary_term' = 'End-of-Life (EOL) Plan ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `quaternary_eol_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `quaternary_eol_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `quaternary_eol_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `tertiary_eol_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `tertiary_eol_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `tertiary_eol_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `active_service_contract_count` SET TAGS ('dbx_business_glossary_term' = 'Active Service Contract Count');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `active_service_contract_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `communication_embargo_date` SET TAGS ('dbx_business_glossary_term' = 'Communication Embargo Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `communication_embargo_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `competitor_notification_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitor Notification Risk Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `competitor_notification_risk_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `customer_notification_plan` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Plan');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `data_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Years)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Reason');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_value_regex' = 'technology_superseded|low_demand|regulatory_change|strategic_portfolio_rationalization|manufacturing_obsolescence|component_unavailability');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `discontinuation_reason_detail` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Reason Detail');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `documentation_archive_location` SET TAGS ('dbx_business_glossary_term' = 'Documentation Archive Location');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End-of-Life (EOL) Announcement Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `eol_plan_number` SET TAGS ('dbx_business_glossary_term' = 'End-of-Life (EOL) Plan Number');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `eol_plan_number` SET TAGS ('dbx_value_regex' = '^EOL-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `eol_status` SET TAGS ('dbx_business_glossary_term' = 'End-of-Life (EOL) Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `eol_status` SET TAGS ('dbx_value_regex' = 'draft|approved|announced|active|completed|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `erp_system_deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) System Deactivation Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `field_sales_briefing_date` SET TAGS ('dbx_business_glossary_term' = 'Field Sales Briefing Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `financial_impact_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate (USD)');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `financial_impact_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `inventory_disposition_plan` SET TAGS ('dbx_business_glossary_term' = 'Inventory Disposition Plan');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `last_support_date` SET TAGS ('dbx_business_glossary_term' = 'Last Support Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `manufacturing_stop_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Stop Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `partner_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `product_regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Product Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `quality_system_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Quality System Impact Assessment');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `spare_parts_availability_date` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Availability Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `transition_support_offering` SET TAGS ('dbx_business_glossary_term' = 'Transition Support Offering');
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ALTER COLUMN `website_update_date` SET TAGS ('dbx_business_glossary_term' = 'Website Update Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'product.catalog_item,supply.supplier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Catalog Item Id');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Supplier Id');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `preferred_supplier_rank` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Rank');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `total_quantity_purchased` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Purchased');
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` SET TAGS ('dbx_subdomain' = 'manufacturing_operations');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` SET TAGS ('dbx_association_edges' = 'product.sku,manufacturing.work_center');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `sku_work_center_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'SKU Work Center Qualification ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified By Employee');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Work Center Qualification - Sku Id');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Work Center Qualification - Work Center Id');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `capacity_units_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Shift');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `is_preferred_work_center` SET TAGS ('dbx_business_glossary_term' = 'Preferred Work Center Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `last_production_date` SET TAGS ('dbx_business_glossary_term' = 'Last Production Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `maximum_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Batch Size');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `minimum_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Batch Size');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `qualified_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `standard_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Cycle Time');
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ALTER COLUMN `yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Target Percentage');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` SET TAGS ('dbx_association_edges' = 'product.catalog_item,data.retention_policy');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `retention_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Product Retention Assignment Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Retention Assignment - Catalog Item Id');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Retention Assignment - Retention Policy Id');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment Approval Authority');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Policy Assigned By');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Assignment Geographic Scope');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Policy Assignment Override Reason');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `policy_version_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Policy Version at Assignment');
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ALTER COLUMN `regulatory_trigger` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Trigger Event');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` SET TAGS ('dbx_association_edges' = 'product.catalog_item,quality.validation_study');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `validation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Validation Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Validation - Catalog Item Id');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Product Validation - Validation Study Id');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `lot_range_end` SET TAGS ('dbx_business_glossary_term' = 'Lot Range End');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `lot_range_start` SET TAGS ('dbx_business_glossary_term' = 'Lot Range Start');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Product Validation Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Validation Phase');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `product_configuration_tested` SET TAGS ('dbx_business_glossary_term' = 'Product Configuration Tested');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `regulatory_claim_supported` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim Supported');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `validation_scope` SET TAGS ('dbx_business_glossary_term' = 'Validation Scope');
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` SET TAGS ('dbx_association_edges' = 'product.catalog_item,research.publication');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `citation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Citation ID');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Citation - Catalog Item Id');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `publication_id` SET TAGS ('dbx_business_glossary_term' = 'Product Citation - Publication Id');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `added_date` SET TAGS ('dbx_business_glossary_term' = 'Citation Added Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `context` SET TAGS ('dbx_business_glossary_term' = 'Citation Context');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `marketing_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `marketing_approved` SET TAGS ('dbx_business_glossary_term' = 'Marketing Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Citation Notes');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `performance_data_included` SET TAGS ('dbx_business_glossary_term' = 'Performance Data Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `product_role` SET TAGS ('dbx_business_glossary_term' = 'Product Role in Study');
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ALTER COLUMN `verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Citation Verified Flag');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bundle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bundle` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bundle` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Identifier');
ALTER TABLE `genomics_biotech_ecm`.`product`.`bundle` ALTER COLUMN `parent_bundle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
