-- Schema for Domain: order | Business: Semiconductors | Version: v1_mvm
-- Generated on: 2026-05-06 20:34:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `semiconductors_ecm`.`order` COMMENT 'Customer orders, order fulfillment, delivery schedules, and shipment tracking. SSOT for order-to-cash lifecycle including order entry, wafer start authorizations, die bank orders, allocation, backlog management, and delivery confirmation. Manages MPW orders and production lot assignments.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`order` (
    `order_id` BIGINT COMMENT 'Primary key for order',
    `account_id` BIGINT COMMENT 'Reference to the customer who placed the sales order. Links to the customer master data product.',
    `blanket_order_id` BIGINT COMMENT 'Foreign key linking to order.blanket_order. Business justification: An order may be covered by a blanket purchase agreement; adding FK from order to blanket_order captures this relationship without creating a cycle.',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to sales.channel_partner. Business justification: Orders may be placed via channel partners; the FK enables partner‑attributed revenue and commission reporting.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Order Management requires a primary sales contact for each order; the Order Confirmation Report pulls contact details, making this link essential.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Orders are charged to a cost center for expense tracking and budgeting in the finance system.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Export compliance reporting requires linking each order to its ECCN classification for customs documentation.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export License Management: each sales order must reference the approved export license, replacing the free‑text export_license_number.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Order creation originates from a closed‑won opportunity; linking enables opportunity‑to‑order conversion reporting.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.price_agreement. Business justification: Pricing Governance applies a specific price agreement to an order; the Pricing Audit Report and revenue recognition rely on this relationship.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit‑center reporting requires each sales order to be linked to the responsible profit center.',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: Customer orders for automotive (IATF 16949) and aerospace applications require qualification program compliance tracking. Orders must reference the applicable qualification program to ensure all deliv',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Orders are generated from accepted quotes; the link supports quote‑to‑order tracking and pricing audit.',
    `restricted_party_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.restricted_party_screening. Business justification: Trade compliance hold process records the screening result for the customer/account on the order.',
    `sales_design_win_id` BIGINT COMMENT 'Reference to the Salesforce CRM design-win opportunity that originated this sales order. Links the order to the customer design-in engagement, enabling design-win to revenue conversion tracking.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Shipping Execution process stores the exact customer address for each order; the Shipping Manifest and compliance checks depend on this link.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Direct orders placed with suppliers for foundry services, wafer procurement, or material purchases. Supplier linkage at order header enables supplier order tracking, delivery performance monitoring, a',
    `actual_delivery_date` DATE COMMENT 'The actual date on which the ordered products were delivered to the customer or ship-to location. Used for on-time delivery (OTD) performance analysis and customer satisfaction reporting.',
    `allocation_status` STRING COMMENT 'Current inventory or production capacity allocation status of the order. Indicates whether sufficient die, wafer, or finished goods inventory has been reserved to fulfill the order. Critical for backlog management and supply-demand balancing.. Valid values are `UNALLOCATED|PARTIALLY_ALLOCATED|FULLY_ALLOCATED|OVER_ALLOCATED`',
    `backlog_flag` BOOLEAN COMMENT 'Indicates whether this order is currently included in the active order backlog. True when the order is open and not yet fully shipped or invoiced. Used for backlog valuation, revenue forecasting, and capacity planning.',
    `cancellation_reason` STRING COMMENT 'Business reason code or description for order cancellation. Populated only when order_status is CANCELLED. Used for lost revenue analysis, demand forecasting accuracy, and customer relationship management.',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether this order is associated with products or programs eligible for US CHIPS and Science Act incentives or reporting requirements. Used for government reporting and subsidy tracking.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the semiconductor manufacturer based on production capacity, wafer fab scheduling, and logistics. May differ from the requested delivery date. Used for backlog management and customer commitment tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales order record was first created in the source system (SAP S/4HANA SD). Used for audit trail, data lineage, and order entry performance measurement. Corresponds to SAP VBAK.ERDAT + VBAK.ERZET.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the order transaction (e.g., USD, EUR, JPY, TWD, KRW). Defines the currency in which order values, pricing, and invoicing are denominated. Corresponds to SAP VBAK.WAERK.. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'The purchase order number provided by the customer at the time of order placement. Used for cross-referencing with the customers procurement system and required for invoice matching. Corresponds to SAP VBAK.BSTNK.',
    `distribution_channel` STRING COMMENT 'The sales channel through which the order was placed. Determines pricing tiers, commission structures, and revenue reporting by channel. Corresponds to SAP VBAK.VTWEG.. Valid values are `DIRECT|DISTRIBUTOR|REPRESENTATIVE|ONLINE|OEM`',
    `end_market_segment` STRING COMMENT 'The end-market application segment for which the ordered semiconductor products are destined. Used for market segmentation analysis, revenue reporting by vertical, and strategic planning. [ENUM-REF-CANDIDATE: COMPUTING|MOBILE|AUTOMOTIVE|AI_ML|IOT|INDUSTRIAL|NETWORKING|CONSUMER|DEFENSE|MEDICAL — promote to reference product]',
    `export_license_required` BOOLEAN COMMENT 'Indicates whether an export license is required for this order based on the destination country, end-user, and product ECCN classification. True triggers export compliance review workflow before shipment authorization.',
    `gross_order_value` DECIMAL(18,2) COMMENT 'Total gross value of the sales order before application of discounts, taxes, or surcharges, expressed in the order currency. Represents the sum of all line item gross values. Used for revenue forecasting and backlog valuation.',
    `hold_reason` STRING COMMENT 'Reason code or description for placing the order on hold. Populated when order_status is ON_HOLD. Common reasons include credit hold, export compliance review, customer request, or supply shortage.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the responsibilities of buyer and seller for delivery, risk transfer, and cost allocation. Corresponds to SAP VBAK.INCO1. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `incoterms_location` STRING COMMENT 'The named place or port associated with the Incoterms code, specifying where risk and cost transfer between buyer and seller (e.g., Shanghai Port, Customer Dock). Corresponds to SAP VBAK.INCO2.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether any products in this order are subject to ITAR (International Traffic in Arms Regulations) controls. When True, additional export authorization and end-use certification requirements apply before shipment.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sales order record in the source system. Used for change tracking, audit compliance, and incremental data pipeline processing. Corresponds to SAP VBAK.AEDAT.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Net value of the sales order after application of all discounts and pricing conditions but before tax. Represents the contractually agreed revenue amount. Corresponds to SAP VBAK.NETWR. Used for revenue recognition and financial reporting.',
    `notes` STRING COMMENT 'Free-text notes or special instructions associated with the sales order, capturing customer-specific requirements, handling instructions, or internal processing notes. Corresponds to SAP order header text.',
    `nre_amount` DECIMAL(18,2) COMMENT 'Non-Recurring Engineering (NRE) charges associated with this order, covering one-time design, mask set, and process development costs. Applicable for ASIC, custom IC, and MPW order types. Reported separately from unit product revenue.',
    `order_date` DATE COMMENT 'The calendar date on which the customer placed the sales order. Represents the principal business event date for the order-to-cash lifecycle. Corresponds to SAP VBAK.AUDAT.',
    `order_source` STRING COMMENT 'The channel or system through which the customer order was received and entered. Used for order entry efficiency analysis and digital transformation tracking.. Valid values are `EDI|PORTAL|EMAIL|PHONE|SALESFORCE|MANUAL`',
    `order_status` STRING COMMENT 'Current lifecycle status of the sales order within the order-to-cash process. Drives workflow routing, backlog reporting, and revenue recognition. [ENUM-REF-CANDIDATE: DRAFT|OPEN|IN_FULFILLMENT|SHIPPED|DELIVERED|CLOSED|CANCELLED|ON_HOLD — promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the sales order by product or engagement type. Determines order processing rules, pricing, and fulfillment workflow. Values include: STANDARD_IC (standard integrated circuit), ASIC (Application-Specific Integrated Circuit), FPGA (Field-Programmable Gate Array), MPW (Multi-Project Wafer), NRE (Non-Recurring Engineering), DIE_BANK (die bank pull order), WAFER_START (wafer start authorization). [ENUM-REF-CANDIDATE: STANDARD_IC|ASIC|FPGA|MPW|NRE|DIE_BANK|WAFER_START — promote to reference product]',
    `payment_terms_code` STRING COMMENT 'SAP payment terms key defining the payment due date, early payment discount conditions, and cash discount percentages applicable to this order. Corresponds to SAP VBAK.ZTERM (e.g., NT30, NT60, 2/10NET30).. Valid values are `^[A-Z0-9]{2,10}$`',
    `priority` STRING COMMENT 'Business priority level assigned to the order, influencing production scheduling, wafer start queue position, and allocation decisions. Critical orders may trigger expedite fees or override standard allocation rules.. Valid values are `CRITICAL|HIGH|STANDARD|LOW`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the products ordered comply with the EU REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) Regulation. Required for EU market access and supply chain chemical safety reporting.',
    `requested_delivery_date` DATE COMMENT 'The date by which the customer has requested delivery of the ordered products. Used for delivery scheduling, wafer start planning, and on-time delivery (OTD) performance measurement. Corresponds to SAP VBAK.VDATU.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the products ordered comply with the EU RoHS (Restriction of Hazardous Substances) Directive, restricting the use of specific hazardous materials in electronic equipment. Required for EU market access and customer compliance declarations.',
    `ship_to_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the destination country for shipment. Critical for export compliance screening (EAR/ITAR/BIS), trade sanctions checks, and logistics routing. Corresponds to SAP ship-to party country.. Valid values are `^[A-Z]{3}$`',
    `so_number` STRING COMMENT 'Externally visible sales order number as assigned by SAP S/4HANA SD module. Used in all customer-facing communications, shipping documents, and invoices. Corresponds to the VBELN field in SAP VBAK table.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the sales order, including VAT, GST, or other applicable taxes, expressed in the order currency. Required for tax reporting and financial compliance.',
    `wafer_start_authorization` BOOLEAN COMMENT 'Indicates whether this order has triggered a wafer start authorization in the fabrication facility (FAB). When True, the MES (Manufacturing Execution System) has been instructed to initiate wafer lot processing for this order.',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Master record for all customer sales orders in the semiconductor order-to-cash lifecycle. Captures order header information including customer identity, order type (standard IC, ASIC, FPGA, MPW, NRE), order date, requested delivery date, priority, incoterms, payment terms, currency, total order value, and order status. SSOT for all customer-placed orders including wafer start authorizations, die bank orders, and production lot assignments. Sourced from SAP S/4HANA SD module.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`line` (
    `line_id` BIGINT COMMENT 'Unique surrogate identifier for each order line item within the Databricks Silver Layer. Serves as the primary key for the order_line data product.',
    `account_id` BIGINT COMMENT 'Reference to the customer placing the order. Used for line-level customer attribution in multi-ship-to or multi-sold-to scenarios. Corresponds to SAP S/4HANA SD KUNNR (Customer Number).',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Engineering sample orders, pre-production orders, and design-win tracking require catalog-level product reference before SKU finalization. Critical for NRE orders and prototype fulfillment where packa',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order header to which this line item belongs. Establishes the header-to-line relationship in the order-to-cash lifecycle. Corresponds to SAP S/4HANA SD VBELN (Sales Document Number).',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Required for Test Program Assignment per SKU during order fulfillment; ensures each order line selects the correct test program for quality validation.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Order lines must reference applicable quality specifications for acceptance criteria. Each order line commits to specific quality parameters (yield, defect density, reliability) that are defined in qu',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Each order line is derived from a quote line; needed for line‑level margin and fulfillment analysis.',
    `reach_svhc_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.reach_svhc_declaration. Business justification: REACH SVHC Declaration is required per SKU on an order line to certify hazardous substance compliance.',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, or discrete device) being ordered on this line. Links to the product master for SKU-level configuration details including package type, speed grade, and temperature range.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Primary supplier for the SKU on each order line, used in procurement planning and supplier performance reporting.',
    `actual_ship_date` DATE COMMENT 'The date on which the semiconductor units for this order line were physically shipped from the warehouse or OSAT facility. Populated upon goods issue posting in SAP S/4HANA. Used for on-time delivery (OTD) performance measurement.',
    `allocation_type` STRING COMMENT 'Classification of the supply allocation method applied to this order line. Standard = normal backlog allocation; Priority = customer-priority or design-win protected allocation; Strategic = long-term agreement allocation; Spot = spot market fulfillment; Buffer = safety stock draw.. Valid values are `standard|priority|strategic|spot|buffer`',
    `cancellation_reason` STRING COMMENT 'Reason code for cancellation of this order line when line_status is cancelled. Supports backlog analysis, demand planning accuracy, and customer relationship management. Populated only for cancelled lines. [ENUM-REF-CANDIDATE: customer_request|supply_constraint|end_of_life|duplicate|pricing_dispute|export_hold|other — 7 candidates stripped; promote to reference product]',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity of semiconductor units confirmed by supply chain for delivery on this order line, reflecting available inventory, wafer start authorizations, and die bank allocations. May differ from ordered quantity due to allocation constraints.',
    `confirmed_ship_date` DATE COMMENT 'The date confirmed by supply chain and manufacturing for shipment of this order line, based on available inventory, die bank status, and OSAT packaging capacity. May differ from requested ship date due to supply constraints.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the semiconductor product was manufactured (FAB location). Required for customs declarations, trade compliance, tariff classification, and CHIPS Act domestic content reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this order line record was first created in the data platform. Used for audit trail, data lineage, and Silver Layer ingestion tracking. Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction currency of this order line (e.g., USD, EUR, JPY, KRW, TWD). Semiconductor industry commonly transacts in USD but supports multi-currency for global customers.. Valid values are `^[A-Z]{3}$`',
    `customer_part_number` STRING COMMENT 'The customers own internal part number or cross-reference number for the ordered semiconductor product. Critical for design-win tracking, customer portal integration, and order acknowledgment matching. Sourced from Salesforce CRM design-win records.',
    `date_entered` DATE COMMENT 'The business date on which this order line was entered into the SAP S/4HANA SD system. Represents the commercial event date for backlog aging calculations and order-to-cash cycle time measurement.',
    `die_bank_order` BOOLEAN COMMENT 'Indicates whether this order line is to be fulfilled from the die bank (inventory of known good dies (KGD) awaiting packaging) rather than from finished goods or new wafer starts. True = die bank fulfillment; False = standard finished goods or new production.',
    `export_control_classification` STRING COMMENT 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN) for the semiconductor product on this order line (e.g., 3A001 for advanced ICs). Required for export compliance screening, license determination, and ITAR/EAR regulatory reporting.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost responsibilities between the semiconductor company and the customer for this order line (e.g., FOB, DDP, EXW). Corresponds to SAP S/4HANA SD INCO1. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `item_category` STRING COMMENT 'SAP SD item category classification for this order line, indicating the business nature of the line (e.g., standard product sale, consignment fill-up, customer return, engineering sample, NRE charge, MPW service, evaluation unit). Drives pricing, delivery, and billing behavior. [ENUM-REF-CANDIDATE: standard|consignment|returns|sample|nre|mpw|evaluation — 7 candidates stripped; promote to reference product]',
    `line_number` STRING COMMENT 'Sequential position number of this line item within the parent sales order. Used for ordering, display, and reference in customer-facing documents. Corresponds to SAP S/4HANA SD POSNR (Item Number of the SD Document).',
    `line_status` STRING COMMENT 'Current workflow status of this order line item within the order-to-cash lifecycle. Drives backlog management, allocation decisions, and revenue recognition. Corresponds to SAP S/4HANA SD overall delivery status at item level.. Valid values are `open|confirmed|allocated|shipped|invoiced|cancelled`',
    `lot_number` STRING COMMENT 'The manufacturing lot number assigned to the production batch fulfilling this order line. Enables traceability from customer order back to wafer fabrication lot, die bank lot, and OSAT packaging lot. Sourced from Camstar MES lot tracking.',
    `material_number` STRING COMMENT 'SAP material number (MATNR) identifying the specific semiconductor product SKU ordered on this line. Includes full part number with package, speed grade, and temperature range encoded per internal part numbering convention.',
    `mpw_order` BOOLEAN COMMENT 'Indicates whether this order line is associated with a Multi-Project Wafer (MPW) run, where multiple customer designs share a single wafer to reduce NRE costs. True = MPW order; False = dedicated production lot order.',
    `net_value` DECIMAL(18,2) COMMENT 'Total net value of this order line calculated as confirmed quantity multiplied by unit price in the transaction currency. Used for backlog reporting, revenue forecasting, and SOX-compliant revenue recognition. Corresponds to SAP S/4HANA SD NETWR (Net Value of the Order Item).',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of semiconductor units (dies, packaged ICs, wafers, or reels) requested by the customer on this order line. Expressed in the sales unit of measure (e.g., pieces, wafers, reels). Corresponds to SAP S/4HANA SD KWMENG (Cumulative Order Quantity).',
    `partial_shipment_allowed` BOOLEAN COMMENT 'Indicates whether the customer permits partial shipments against this order line. True = partial shipments accepted; False = complete order line quantity must ship together. Drives delivery scheduling and backlog management decisions.',
    `product_revision` STRING COMMENT 'The silicon revision or stepping of the ordered semiconductor product (e.g., A0, B1, C2). Critical for tracking product change notifications (PCNs), errata management, and ensuring customers receive the correct silicon revision per their qualification.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the semiconductor product on this order line is compliant with the EU REACH Regulation (Registration, Evaluation, Authorisation and Restriction of Chemicals). Required for EU chemical safety compliance and customer material declarations.',
    `requested_delivery_date` DATE COMMENT 'The date by which the customer requires receipt of the semiconductor units at their facility. Distinct from requested ship date; accounts for transit time. Used for customer SLA compliance tracking.',
    `requested_ship_date` DATE COMMENT 'The date on which the customer has requested shipment of this order line. Drives production scheduling, wafer start authorization timelines, and OSAT packaging commitments. Corresponds to SAP S/4HANA SD WUNSK (Customers Requested Delivery Date at Item Level).',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the semiconductor product on this order line is compliant with the EU Restriction of Hazardous Substances (RoHS) Directive, restricting use of lead, mercury, cadmium, and other hazardous materials. Required for EU market access.',
    `sap_line_item_number` STRING COMMENT 'The native SAP S/4HANA SD six-digit item number (POSNR) for this order line, used for traceability back to the system of record and for EDI/customer portal reconciliation.. Valid values are `^[0-9]{6}$`',
    `ship_to_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the destination country of this order line shipment. Used for export control screening, customs documentation, tariff determination, and trade compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of semiconductor units actually shipped against this order line across all partial shipments. Used for backlog calculation and revenue recognition. Sourced from SAP S/4HANA SD delivery documents.',
    `special_handling_code` STRING COMMENT 'Code indicating special handling, storage, or shipping requirements for this order line (e.g., ESD-sensitive, moisture-sensitive level (MSL), controlled humidity, ITAR-controlled, hazmat). Drives warehouse and logistics instructions. [ENUM-REF-CANDIDATE: ESD|MSL1|MSL2|MSL3|ITAR|HAZMAT|CONTROLLED_TEMP|FRAGILE — promote to reference product]',
    `speed_grade` STRING COMMENT 'The speed or performance grade of the ordered semiconductor product, indicating the maximum operating frequency or timing specification (e.g., -1, -2, -3 for FPGAs; 3200MHz, 4800MHz for memory). Differentiates SKUs within the same product family.',
    `temperature_grade` STRING COMMENT 'Operating temperature range classification for the ordered semiconductor product. Commercial (0°C to 70°C), Industrial (-40°C to 85°C), Automotive (-40°C to 125°C, AEC-Q100), Military (-55°C to 125°C). Determines qualification standard and pricing tier.. Valid values are `commercial|industrial|automotive|military|extended`',
    `to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Fundamental header-to-line relationship. Every order line must belong to exactly one sales order. This is the most critical FK in the domain — without it, order lines are orphaned.',
    `unit_of_measure` STRING COMMENT 'Sales unit of measure for the ordered semiconductor product. EA = Each (individual packaged IC), WFR = Wafer, REEL = Tape-and-reel packaging, TRAY = JEDEC tray, TUBE = Tube packaging. Corresponds to SAP S/4HANA SD VRKME (Sales Unit).. Valid values are `EA|WFR|REEL|TRAY|TUBE`',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed net unit selling price for the semiconductor product on this order line, expressed in the transaction currency. Reflects negotiated pricing, volume discounts, and design-win pricing agreements. Corresponds to SAP S/4HANA SD NETPR (Net Price).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this order line record in the data platform. Supports change data capture (CDC), audit trail, and incremental processing in the Databricks Lakehouse Silver Layer.',
    `wafer_start_authorization` BOOLEAN COMMENT 'Indicates whether a wafer start authorization (WSA) has been issued to the fabrication facility (FAB) to initiate production of wafers for fulfilling this order line. True = WSA issued; False = pending or not required (e.g., fulfilled from die bank or finished goods inventory).',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Individual line items within a customer sales order, each representing a distinct semiconductor product SKU, quantity, unit price, requested ship date, confirmed ship date, and line-level status. Captures product configuration details such as package type, speed grade, temperature range, and special handling requirements. Supports partial shipments and line-level allocation tracking. Sourced from SAP S/4HANA SD order line items.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` (
    `wafer_start_authorization_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a wafer start authorization record. Primary key for this entity in the Silver Layer lakehouse.',
    `account_id` BIGINT COMMENT 'Reference to the customer account on whose behalf the wafer start is authorized. Supports order-to-cash traceability and customer-level fab demand reporting. Fulfills the PARTY_REFERENCE minimum category for TRANSACTION_HEADER.',
    `customer_design_registration_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_registration. Business justification: Wafer start authorizations for custom designs must link to design registration to enforce NRE payment verification, track design revision for fab instructions, and validate customer-specific process n',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Wafer starts for controlled process technologies require ECCN classification for export control determination before fab authorization. Critical compliance gate in semiconductor manufacturing.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Wafer starts for ITAR/EAR-controlled designs require export license validation before authorizing production. Prevents license violations in fab operations.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Wafer start authorizations must reference the specific process flow to be executed in the fab. Fab operations teams use this link to validate that the authorized wafer starts follow the correct, quali',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Wafer fabrication authorizations target specific IC designs at catalog level. Essential for fab planning, die bank replenishment, and wafer lot traceability to base product design before packaging dec',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: A wafer start authorization authorizes fab production for a specific IC design project. Fab operations, export control screening, and supply planning all require knowing which design project a WSA cov',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: A wafer start authorization is triggered by a specific order line (the line item requiring wafer fabrication). Currently WSA only links to the order header (wafer_order_id, wafer_sales_order_id → orde',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the MPW run record that groups multiple customer designs sharing this wafer start. Populated only when is_mpw is True. Enables allocation of wafer cost and die yield across participating customers.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Wafer start authorizations specify the primary fab tool for wafer processing. Critical for manufacturing capacity planning, tool loading schedules, and fab resource allocation. Semiconductor fabs must',
    `order_id` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Wafer start authorizations are triggered by customer orders. The WSA must reference the originating sales order for demand traceability.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Wafer start authorizations must specify process technology node for fab capacity allocation, cycle time planning, and technology-specific manufacturing routing. Replaces denormalized process_node stri',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: wafer_start_authorization carries process_node and process_technology_code as plain text — direct denormalization of process_technology_node. WSAs are node-specific for capacity planning and fab sched',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: Wafer start authorization for a new product or process requires completed process qualification as a release gate. This link enforces the qualification-to-production control: fab operations cannot aut',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Wafer start authorizations must reference process quality specifications that define acceptance criteria for the wafer lot. Fab operations require quality spec compliance before authorizing wafer star',
    `sales_design_win_id` BIGINT COMMENT 'Foreign key linking to sales.sales_design_win. Business justification: WSAs authorize fab capacity for specific design wins. Linking enables design-win-specific revenue recognition, capacity planning, yield tracking, and ramp monitoring—critical for semiconductor design ',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, etc.) for which wafers are being authorized to start fabrication. Links to the product master in PLM.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Wafer start authorizations in foundry model specify which fab supplier executes the wafer fabrication. Critical for capacity planning, cost allocation, and supply chain visibility in fabless/fab-lite ',
    `actual_start_date` DATE COMMENT 'Actual calendar date on which wafer fabrication commenced at the fab site, as recorded by the MES. Compared against planned_start_date to measure schedule adherence and on-time start performance.',
    `approval_level` STRING COMMENT 'Organizational approval tier required and applied for this wafer start authorization. Higher-value or hot-lot authorizations may require director or VP approval. Supports SOX internal controls and delegation-of-authority compliance.. Valid values are `auto_approved|manager|director|vp`',
    `authorization_number` STRING COMMENT 'Externally-known, human-readable business identifier for the wafer start authorization, used across order management, MES, and fab planning systems. Typically formatted as WSA-{SITE}-{SEQUENCE}. This is the BUSINESS_IDENTIFIER category field for this TRANSACTION_HEADER entity.. Valid values are `^WSA-[A-Z0-9]{4,10}-[0-9]{6}$`',
    `authorization_status` STRING COMMENT 'Current lifecycle state of the wafer start authorization record, tracking progression from initial creation through fab release and completion. Fulfills the LIFECYCLE_STATUS minimum category for TRANSACTION_HEADER. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|released_to_fab|in_progress|completed|cancelled|on_hold — promote to reference product]',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer start authorization was formally approved and issued. This is the principal BUSINESS_EVENT_TIMESTAMP for this TRANSACTION_HEADER — the moment the authorization became binding and the demand signal was created.',
    `authorized_by` STRING COMMENT 'Name or employee identifier of the person who formally approved and issued the wafer start authorization. Required for SOX compliance and audit trail. Typically a fab planning manager or order management lead.',
    `authorized_wafer_qty` STRING COMMENT 'Number of wafers authorized to start fabrication under this authorization record. This is the primary quantitative demand signal passed from order management to the MES. Fulfills the QUANTITATIVE_RESULT minimum category for this non-monetary TRANSACTION_HEADER.',
    `cancellation_reason` STRING COMMENT 'Reason code explaining why the wafer start authorization was cancelled, when authorization_status is cancelled. Used for backlog management analysis, demand forecasting accuracy improvement, and fab capacity recovery planning. [ENUM-REF-CANDIDATE: customer_request|forecast_revision|capacity_constraint|design_change|yield_risk|export_hold|other — 7 candidates stripped; promote to reference product]',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether this wafer start authorization qualifies for US CHIPS and Science Act incentives or domestic production reporting requirements. Relevant for fab sites receiving CHIPS Act funding and for regulatory compliance reporting to the US Department of Commerce.',
    `cost_center_code` STRING COMMENT 'SAP cost center to which the wafer fabrication costs for this authorization are allocated. Used for internal cost accounting, NRE cost recovery, and fab P&L reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the wafer start authorization record was first created in the source system. Fulfills the RECORD_AUDIT_CREATED minimum category for TRANSACTION_HEADER. Used for data lineage and audit trail.',
    `cycle_time_target_days` STRING COMMENT 'Target number of calendar days from wafer start to wafer out (completion of all fab processing steps). Defined by process node and priority class. Hot lots have compressed cycle time targets. Used for delivery commit date calculation and fab performance measurement.',
    `die_bank_replenishment_code` BIGINT COMMENT 'Reference to the die bank replenishment plan that triggered this authorization when the wafer start is driven by inventory replenishment rather than a direct customer sales order. Nullable when authorization originates from a sales order.',
    `die_per_wafer` STRING COMMENT 'Number of individual die sites on each wafer for the specified product and process node. Determined by die size and wafer diameter. Used in conjunction with yield_target_pct to compute expected_good_die_qty.',
    `expected_good_die_qty` STRING COMMENT 'Projected number of Known Good Dies (KGD) expected from this wafer start, calculated from authorized_wafer_qty, die per wafer count, and yield_target_pct. Used for order fulfillment planning and die bank replenishment forecasting.',
    `fab_work_order_number` STRING COMMENT 'SAP PP production order or work order number generated in ERP when the wafer start authorization is released to manufacturing. Bridges the order management domain to the ERP manufacturing execution module for cost collection and WIP tracking.',
    `is_mpw` BOOLEAN COMMENT 'Indicates whether this authorization is for a Multi-Project Wafer (MPW) run, where multiple customer designs share a single wafer to reduce NRE cost. MPW lots require special reticle set management and die allocation tracking.',
    `is_nre` BOOLEAN COMMENT 'Indicates whether this wafer start authorization is for a Non-Recurring Engineering (NRE) run, such as a first-time tapeout, process qualification, or engineering lot, as opposed to a production volume order. NRE lots have distinct cost accounting and yield expectations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the wafer start authorization record. Fulfills the RECORD_AUDIT_UPDATED minimum category for TRANSACTION_HEADER. Used for incremental data pipeline processing and change tracking.',
    `lot_number` STRING COMMENT 'MES-assigned lot identifier for the wafer batch initiated under this authorization. Populated after the authorization is released to the fab and a lot is created in the MES (Camstar or SmartFactory). Links the authorization to the physical WIP lot in the fab.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or exceptions associated with this wafer start authorization. May include hot-lot justification, customer escalation notes, or fab-specific handling instructions.',
    `nre_charge_usd` DECIMAL(18,2) COMMENT 'Non-Recurring Engineering fee in US dollars associated with this wafer start authorization, applicable for first-time tapeouts, mask set fabrication, and engineering qualification lots. Populated when is_nre is True. Used for customer invoicing and cost recovery tracking.',
    `planned_completion_date` DATE COMMENT 'Expected date by which wafer fabrication (FEOL through BEOL) is planned to be completed and wafers released for wafer test and probing. Drives downstream packaging and delivery commit date calculations.',
    `planned_start_date` DATE COMMENT 'Scheduled calendar date on which wafer fabrication is planned to begin at the fab site. Used for fab capacity planning, WIP (Work in Process) scheduling, and order commit date calculations.',
    `priority_class` STRING COMMENT 'Fabrication priority classification assigned to this wafer start authorization. Hot lots receive highest fab priority and cycle time targets; MPW (Multi-Project Wafer) lots share wafer capacity across multiple designs; NRE pilot lots are for non-recurring engineering qualification runs.. Valid values are `hot_lot|expedite|standard|mpw|nre_pilot`',
    `required_ship_date` DATE COMMENT 'Customer-committed or order-driven date by which finished product must ship. Used to back-calculate the wafer start date and validate that the planned_start_date supports on-time delivery. Key input to TTM (Time to Market) and delivery performance metrics.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system of record from which this wafer start authorization record originated (e.g., SAP S/4HANA PP, Camstar MES, Applied Materials SmartFactory, Salesforce CRM design-win). Supports data lineage and Silver Layer reconciliation.. Valid values are `SAP_S4|CAMSTAR|SMARTFACTORY|SFDC|AGILE_PLM|MANUAL`',
    `source_system_reference` STRING COMMENT 'Native record identifier from the originating source system (e.g., SAP production order number, Camstar lot ID, Salesforce opportunity ID). Enables cross-system traceability and reconciliation between the lakehouse Silver Layer and operational systems.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the silicon wafer substrate in millimeters (e.g., 200mm, 300mm, 450mm). Determines equipment compatibility and fab line routing at the fabrication facility.',
    `wafer_unit_cost_usd` DECIMAL(18,2) COMMENT 'Standard cost per wafer in US dollars for the specified process node and fab site at the time of authorization. Used for cost of goods sold (COGS) estimation, margin analysis, and financial planning.',
    `wsa_to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Wafer start authorizations are triggered by sales orders. This link is essential for demand-to-supply traceability and is explicitly mentioned in the WSA description.',
    `yield_target_pct` DECIMAL(18,2) COMMENT 'Expected die yield percentage (good dies per wafer as a percentage of total die sites) for this wafer start, based on process node maturity and historical SPC data. Used to calculate expected good die output and validate order fulfillment feasibility.',
    CONSTRAINT pk_wafer_start_authorization PRIMARY KEY(`wafer_start_authorization_id`)
) COMMENT 'Formal authorization record that triggers wafer fabrication starts in the FAB for a specific customer order or forecast commit. Captures authorized wafer quantity, target process node, fab site, planned start date, priority class (hot lot, standard, MPW), NRE flag, and linkage to the originating sales order or die bank replenishment plan. SSOT for wafer start demand signals passed from order management to manufacturing execution (MES). Bridges order domain to fabrication domain.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`mpw_order` (
    `mpw_order_id` BIGINT COMMENT 'Unique system-generated identifier for the MPW order record. Primary key for the mpw_order data product within the order domain.',
    `account_id` BIGINT COMMENT 'Reference to the fabless customer or design house placing this MPW order. Links to the customer master record for billing, contract terms, and design-win tracking in Salesforce CRM.',
    `customer_contract_id` BIGINT COMMENT 'Reference to the master agreement or NRE contract governing this MPW order, including pricing, IP ownership, and delivery terms. Links to the contract master in SAP S/4HANA or Oracle Agile PLM.',
    `customer_design_registration_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_registration. Business justification: MPW orders must link to design registration for reticle slot assignment coordination, tapeout file validation, and tracking customer-specific design parameters (die size, layer count) that determine s',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: MPW shuttles contain multiple customer designs requiring ECCN classification for each reticle slot before tapeout acceptance. Real compliance workflow in multi-project wafer programs.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: MPW shuttle orders execute a specific, qualified process flow. The mpw_order must reference the process_flow to define manufacturing steps, layer counts, and cycle time for the shuttle run. MPW progra',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Multi-project wafer shuttle orders are scoped to IC designs at catalog level for prototype fabrication and design verification, typically before SKU-level packaging specifications are finalized.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: An MPW order allocates a reticle slot to a specific IC design project. Reticle slot scheduling, export control classification, and NRE billing all require direct traceability from mpw_order to ic_desi',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: An MPW order corresponds to a specific order line representing the MPW product being ordered. Currently mpw_order links to the order header but not to the specific line item. Adding this FK enables li',
    `mpw_shuttle_id` BIGINT COMMENT 'Externally-known identifier for the shared wafer shuttle run in which this MPW order participates. Used to group all customer designs co-fabricated on the same wafer lot. Sourced from the fab or MPW program operator (e.g., TSMC shuttle run code, GlobalFoundries MPW run number).',
    `order_id` BIGINT COMMENT 'FK to order.order.order_id — MPW orders are a specialized order type linked to the master order record for customer and commercial terms.',
    `primary_mpw_sales_order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: MPW order belongs to a specific sales order; adding child-to-parent FK enables order‑level reporting and removes duplicate order_number.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: MPW shuttle runs are organized by process node for mask set management, foundry coordination, and reticle sharing. Essential for shuttle scheduling and multi-project wafer logistics.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: mpw_order.process_node is a plain-text denormalization of process_technology_node. MPW shuttle programs are node-specific — reticle sharing, PDK version, and design rules all depend on the technology ',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: MPW shuttle execution requires the process to be qualified. Linking mpw_order to process_qualification enables program managers to enforce the qualification gate before shuttle wafer starts are author',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: MPW shuttle runs are executed by foundry suppliers. Tracking the supplier is essential for shuttle coordination, cost reconciliation, and tapeout logistics in multi-project wafer programs.',
    `tapeout_id` BIGINT COMMENT 'Reference to the tapeout record (final GDSII design submission) associated with this MPW order. Links the order to the design domain tapeout product for design-to-manufacturing traceability.',
    `actual_delivery_date` DATE COMMENT 'Actual date on which the ordered dies were delivered to the customer. Used to measure on-time delivery performance, close the order-to-cash cycle, and trigger final revenue recognition.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the MPW order record was first created in the source system. Used for audit trail, data lineage, and SLA measurement from order entry.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the order value and NRE charges (e.g., USD, EUR, JPY). Supports multi-currency billing for international fabless customers.. Valid values are `^[A-Z]{3}$`',
    `die_quantity_delivered` STRING COMMENT 'Actual number of known-good dies (KGD) delivered to the customer from this MPW order. May differ from die_quantity_ordered due to yield loss. Used for fulfillment reconciliation and yield-adjusted billing.',
    `die_quantity_ordered` STRING COMMENT 'Number of known-good dies (KGD) ordered by the customer from this MPW shuttle run. Used for delivery planning, yield-adjusted fulfillment, and revenue recognition.',
    `fab_site_code` STRING COMMENT 'Identifier for the wafer fabrication facility (FAB) where this MPW shuttle run is manufactured (e.g., internal fab or OSAT partner site code). Used for capacity planning, yield tracking, and export compliance (ITAR/EAR).',
    `itar_flag` BOOLEAN COMMENT 'Indicates whether this MPW order involves ITAR-controlled technology requiring State Department licensing and restricted handling. True = ITAR-controlled; False = not ITAR-controlled. Drives access controls and shipment documentation requirements.',
    `lot_number` STRING COMMENT 'Fab-assigned wafer lot number for the MPW shuttle run associated with this order. Used for WIP tracking in Camstar MES, yield analysis, and defect traceability through the fabrication process.',
    `mpw_program_type` STRING COMMENT 'Classification of the MPW shuttle program under which this order is placed. Determines pricing tiers, slot priority, NRE subsidies, and export control applicability (e.g., government programs may require ITAR review).. Valid values are `standard|expedited|academic|government|internal`',
    `mpw_to_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — MPW orders may be linked to a parent sales order for billing and customer relationship tracking.',
    `mpw_to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — MPW orders are a specialized order type that should link back to the parent sales order for billing and customer relationship tracking.',
    `nre_charge_usd` DECIMAL(18,2) COMMENT 'One-time Non-Recurring Engineering charge billed to the customer for mask set preparation, reticle slot allocation, and design-in support for this MPW order. Expressed in US dollars. Shared proportionally among shuttle participants based on reticle slot area.',
    `order_date` DATE COMMENT 'The calendar date on which the customer formally placed the MPW order. Represents the principal business event date for order-to-cash lifecycle tracking and backlog reporting.',
    `order_notes` STRING COMMENT 'Free-text field for capturing special instructions, customer-specific requirements, design constraints, or internal processing notes associated with this MPW order. Not used for structured data.',
    `order_status` STRING COMMENT 'Current lifecycle state of the MPW order from initial entry through fabrication completion. Drives backlog management, revenue recognition, and customer communication workflows. [ENUM-REF-CANDIDATE: draft|confirmed|tapeout_received|wafer_started|in_fab|completed|cancelled — promote to reference product]',
    `order_value_usd` DECIMAL(18,2) COMMENT 'Total monetary value of this MPW order in US dollars, comprising NRE charges plus die unit price multiplied by ordered quantity. Used for backlog reporting, revenue forecasting, and SAP FI billing.',
    `package_type` STRING COMMENT 'Semiconductor package type requested for the delivered dies (e.g., bare die/KGD, WLCSP, BGA, QFN, flip-chip). Determines OSAT engagement, packaging cost, and delivery lead time. [ENUM-REF-CANDIDATE: bare_die|WLCSP|BGA|QFN|flip_chip|CSP — promote to reference product]',
    `planned_delivery_date` DATE COMMENT 'Committed date by which the ordered dies are planned to be delivered to the customer after wafer fabrication, dicing, and optional packaging. Used for customer delivery scheduling and order-to-cash SLA tracking.',
    `po_number` STRING COMMENT 'Customer-issued purchase order number referencing this MPW order. Required for invoice matching, accounts receivable, and customer procurement compliance. Sourced from SAP S/4HANA SD order entry.',
    `priority_level` STRING COMMENT 'Business priority assigned to this MPW order for slot allocation, fab scheduling, and customer support escalation. Critical orders receive expedited processing and dedicated account management.. Valid values are `standard|high|critical`',
    `reticle_slot_area_mm2` DECIMAL(18,2) COMMENT 'Physical area in square millimeters allocated to this customers design within the shared MPW reticle. Determines die size, die-per-wafer count, and proportional NRE cost allocation among shuttle participants.',
    `reticle_slot_number` STRING COMMENT 'The specific slot number assigned to this customers design on the shared MPW reticle. Each slot represents a distinct die area on the shared mask set. Slot allocation drives NRE cost sharing and die quantity calculations.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the materials and processes used in this MPW order comply with the EU RoHS Directive restricting hazardous substances in electronic equipment. Required for EU market access and customer compliance declarations.',
    `sales_region_code` STRING COMMENT 'Geographic sales region code associated with this MPW order (e.g., AMER, EMEA, APAC, JAPAN). Used for regional revenue reporting, quota management, and export control jurisdiction determination.. Valid values are `^[A-Z]{2,6}$`',
    `tapeout_deadline` DATE COMMENT 'Contractual deadline by which the customer must submit the final GDSII design data (tapeout) to secure their reticle slot in the MPW shuttle run. Missing this date results in slot forfeiture and potential NRE penalty.',
    `tapeout_received_date` DATE COMMENT 'Actual date on which the customers final GDSII tapeout data was received and accepted by the fab or design services team. Used to confirm slot lock and trigger wafer start authorization.',
    `unit_price_usd` DECIMAL(18,2) COMMENT 'Per-die price charged to the customer for the ordered die quantity from this MPW run. Expressed in US dollars. Used for revenue recognition, invoice generation, and margin analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the MPW order record. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `wafer_quantity` STRING COMMENT 'Number of wafers allocated to this customers design within the MPW shuttle run. Determines the maximum achievable die yield and is used for fab capacity reservation and WIP tracking.',
    `wafer_start_date_actual` DATE COMMENT 'Actual date on which wafer fabrication was initiated for this MPW shuttle run. Compared against planned wafer start date to measure schedule adherence and TTM performance.',
    `wafer_start_date_planned` DATE COMMENT 'Planned date for initiating wafer fabrication (wafer start) for this MPW shuttle run at the fab site. Used for fab capacity scheduling, WIP planning, and customer delivery commitment.',
    `yield_pct` DECIMAL(18,2) COMMENT 'Percentage of good dies produced relative to the total possible dies from the allocated wafer area in this MPW run. Expressed as a percentage (0.00–100.00). Used for quality reporting, customer communication, and yield improvement programs.',
    CONSTRAINT pk_mpw_order PRIMARY KEY(`mpw_order_id`)
) COMMENT 'Multi-Project Wafer (MPW) order record managing shared wafer shuttle runs where multiple customer designs are co-fabricated on a single wafer. Captures shuttle run ID, process node, fab site, reticle slot assignments per customer, die quantity per design, NRE charges, tapeout deadline, planned wafer start date, and delivery schedule. Supports fabless customers and design houses participating in MPW programs. Distinct from standard production orders due to shared-reticle economics and slot-based allocation.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`die_bank_order` (
    `die_bank_order_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the die bank order record. Primary key for this entity in the Silver Layer lakehouse.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that placed the die bank order. Links to the customer master for account-level reporting, design-win tracking, and allocation priority management.',
    `die_bank_id` BIGINT COMMENT 'Reference to the specific die bank (customer-specific or generic KGD inventory pool) from which this order draws down inventory. Identifies the source die bank record in the inventory management system.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Die bank fulfillment requires ECCN classification to determine if export license is needed for die shipment to OSAT or customer. Operational necessity for KGD distribution.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Die bank inventory and known-good-die orders track IC designs at catalog level before packaging, enabling flexible packaging strategies and KGD sales to assembly partners.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Reference to the specific wafer fabrication lot from which the die bank inventory was sourced. Enables full traceability from die bank order back to the originating fab lot for quality and yield analysis.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: A die bank order draws down inventory for a specific order line. Currently die_bank_order links to the order header (die_order_id, die_sales_order_id → order.order) but not to the specific line item. ',
    `order_id` BIGINT COMMENT 'FK to order.order.order_id — Die bank orders draw from pre-built inventory against a customer order for commercial and delivery tracking.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: die_bank_order.process_node is a plain-text denormalization of process_technology_node. Die bank inventory is organized by technology node; die bank orders must reference the correct node to ensure so',
    `program_id` BIGINT COMMENT 'Reference to the Automatic Test Equipment (ATE) test program used to qualify the die bank inventory as Known Good Die. Ensures the correct test coverage was applied before die bank entry.',
    `sales_design_win_id` BIGINT COMMENT 'Foreign key linking to sales.sales_design_win. Business justification: Die bank replenishment orders serve production design wins. Linking enables design-win-specific inventory planning, supply chain optimization, and revenue attribution—essential for managing known-good',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Die bank orders often involve OSAT suppliers for packaging, test, and die bank services. Supplier tracking enables OSAT performance monitoring, cost tracking, and supply chain risk management for know',
    `actual_ship_date` DATE COMMENT 'Date on which the packaged dies or bare die shipment was physically dispatched from the OSAT or warehouse facility. Used for on-time delivery measurement and revenue recognition triggering.',
    `allocated_die_quantity` STRING COMMENT 'Number of dies formally allocated from the die bank inventory against this order. May differ from requested quantity due to partial allocation, inventory constraints, or backlog management decisions.',
    `backlog_flag` BOOLEAN COMMENT 'Indicates whether this die bank order is currently in backlog status due to insufficient die bank inventory or OSAT capacity constraints. Used for backlog management reporting and customer communication.',
    `cancellation_reason` STRING COMMENT 'Reason code for order cancellation when order_status is cancelled. Supports root cause analysis of order cancellations and customer satisfaction reporting.. Valid values are `customer_request|inventory_shortage|quality_hold|export_hold|duplicate_order|end_of_life`',
    `confirmed_delivery_date` DATE COMMENT 'Internally confirmed delivery date committed to the customer after OSAT capacity and die bank inventory checks. May differ from requested delivery date due to packaging lead time or inventory availability.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the die bank order record was first created in the source system. Used for audit trail, data lineage, and SLA measurement from order entry.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the order value and unit price (e.g., USD, EUR, JPY). Required for multi-currency financial reporting and SAP FI/CO currency translation.. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'Customer-provided purchase order number associated with this die bank order. Required for invoice matching, accounts receivable reconciliation, and customer audit trail.',
    `die_bank_to_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Die bank drawdown orders are typically linked to a customer sales order that triggers the packaging/assembly run.',
    `die_bank_to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Die bank drawdown orders link to the customer sales order that triggered the drawdown request.',
    `die_form` STRING COMMENT 'Physical form in which the die inventory is held in the die bank and will be delivered. Determines whether OSAT packaging conversion is required before shipment.. Valid values are `bare_die|wafer|singulated_kgd|tape_and_reel`',
    `die_part_number` STRING COMMENT 'Internal part number identifying the specific die type (IC design revision, process node, and configuration) being ordered from the die bank. Aligns with Oracle Agile PLM and SAP MM material master.',
    `die_revision` STRING COMMENT 'Design revision or stepping identifier of the die (e.g., A0, B1, C2) as tracked in the PLM system. Critical for ensuring the correct silicon revision is pulled from the die bank, especially when multiple steppings coexist.',
    `export_license_required` BOOLEAN COMMENT 'Indicates whether a US government export license is required for this shipment based on the ECCN, destination country, and end-use screening. True triggers export compliance hold before shipment release.',
    `incoterms` STRING COMMENT 'ICC Incoterms rule governing delivery obligations, risk transfer, and cost responsibility between seller and buyer for this die bank order shipment. Captured in SAP SD delivery terms. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `kgd_grade` STRING COMMENT 'Quality grade of the Known Good Die (KGD) inventory being drawn from the die bank. Grade A represents fully tested, production-qualified die; Grade B may have minor parametric deviations; Engineering grade is for internal use only.. Valid values are `grade_a|grade_b|grade_c|engineering`',
    `order_value` DECIMAL(18,2) COMMENT 'Total commercial value of the die bank order (unit price × allocated die quantity), in the transaction currency. Used for revenue backlog reporting, order-to-cash financial tracking, and SOX-compliant revenue recognition.',
    `osat_work_order_number` STRING COMMENT 'Work order or job number issued to the OSAT vendor for the packaging run triggered by this die bank order. Used for tracking assembly progress, yield, and delivery confirmation from the OSAT facility.',
    `package_type` STRING COMMENT 'Target package type for die conversion at OSAT (e.g., WLCSP, BGA, QFN, Flip-Chip, InFO, CoWoS). Specifies the packaging assembly instructions triggered by this die bank order. Null if order is for bare die or wafer delivery. [ENUM-REF-CANDIDATE: WLCSP|BGA|QFN|flip_chip|InFO|CoWoS|CSP|LGA — promote to reference product]',
    `packaging_instruction_code` BIGINT COMMENT 'Reference to the specific package conversion instruction document that defines the assembly process, substrate, wire bond or flip-chip specifications, and test requirements for the OSAT packaging run triggered by this order.',
    `priority_level` STRING COMMENT 'Business priority assigned to the die bank order for allocation and OSAT scheduling purposes. Critical and high priority orders receive preferential die bank drawdown and packaging slot assignment.. Valid values are `critical|high|normal|low`',
    `requested_delivery_date` DATE COMMENT 'Customer-requested date by which the packaged or bare die shipment must be delivered. Used for OSAT scheduling, just-in-time packaging workflow planning, and on-time delivery KPI measurement.',
    `requested_die_quantity` STRING COMMENT 'Number of individual dies (Known Good Die units) requested by the customer or internal order for drawdown from the die bank. Drives OSAT packaging run sizing and inventory reservation.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the die and its packaging materials comply with the EU RoHS Directive restricting hazardous substances. Required for shipments to EU customers and for customer compliance declarations.',
    `ship_to_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the destination country for the shipment. Critical for export control screening (ITAR/EAR), RoHS/REACH compliance declarations, and customs documentation.. Valid values are `^[A-Z]{3}$`',
    `shipment_tracking_number` STRING COMMENT 'Carrier-assigned tracking number for the outbound shipment of packaged dies. Enables end-to-end shipment visibility and proof-of-delivery confirmation for order fulfillment closure.',
    `shipped_die_quantity` STRING COMMENT 'Actual number of dies (post-packaging or in bare die form) confirmed as shipped to the customer. Used for fulfillment confirmation, revenue recognition, and DPPM tracking.',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed commercial price per die unit for this order, as captured in the SAP SD pricing condition. Used for revenue recognition, margin analysis, and customer invoice generation.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the die bank order record. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `wafer_fab_site` STRING COMMENT 'Identifier of the wafer fabrication facility (FAB) where the source lot was manufactured. Relevant for quality traceability, site-specific yield analysis, and regulatory compliance (ITAR/EAR site-of-manufacture declarations).',
    CONSTRAINT pk_die_bank_order PRIMARY KEY(`die_bank_order_id`)
) COMMENT 'Order record for drawing down inventory from a customer-specific or generic die bank (KGD inventory held in wafer or singulated die form). Captures die bank source lot, requested die quantity, die type, package conversion instructions, requested delivery date, and fulfillment status. Supports just-in-time packaging and assembly workflows where die inventory is pre-built and orders trigger OSAT packaging runs. Distinct from wafer start orders as no new fab starts are required.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for each delivery schedule line record in the SAP S/4HANA SD schedule line table (VBEP). Primary key for the delivery_schedule data product in the Silver layer.',
    `account_id` BIGINT COMMENT 'Reference to the sold-to customer for whom this delivery schedule is planned. Supports customer-level delivery performance analytics and blanket order management.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Scheduled deliveries cannot ship without passing inspection lot disposition. Delivery schedule lines must reference the inspection lot to enforce quality gates, prevent shipment of non-conforming mate',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order header from which this delivery schedule line originates. Links the schedule line back to the order-to-cash transaction header.',
    `line_id` BIGINT COMMENT 'Reference to the specific sales order line item (order item) for which this delivery schedule line is created. A single order line may have multiple schedule lines representing different delivery windows.',
    `storage_location_id` BIGINT COMMENT 'Reference to the customers destination ship-to location (customer site, distribution center, or consignment hub) for this delivery schedule line.',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, or packaged die) being scheduled for delivery on this schedule line.',
    `to_order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Delivery schedules define delivery windows per order line. delivery_schedule.order_line_id → order_line.order_line_id.',
    `actual_delivery_date` DATE COMMENT 'The date on which the shipment was confirmed as received at the customers ship-to location. Used for on-time delivery (OTD) KPI calculation and customer satisfaction reporting.',
    `actual_ship_date` DATE COMMENT 'The actual date on which the shipment physically departed the ship-from location. Populated upon goods issue posting in SAP. Used for on-time shipment performance measurement.',
    `allocation_priority` STRING COMMENT 'Numeric priority rank assigned to this delivery schedule line during constrained supply allocation. Lower values indicate higher priority. Used by supply chain planners to allocate limited wafer or die inventory across competing customer orders.',
    `backlog_flag` BOOLEAN COMMENT 'Indicates whether this delivery schedule line is currently in backlog status (confirmed delivery date is past due or confirmed quantity is less than ordered quantity). Used for backlog management reporting and customer escalation tracking.',
    `blanket_order_flag` BOOLEAN COMMENT 'Indicates whether this delivery schedule line is part of a blanket (framework) order with periodic call-offs. Blanket orders are common for high-volume semiconductor customers with rolling delivery schedules.',
    `call_off_number` STRING COMMENT 'The specific call-off or release number issued by the customer against a blanket order for this delivery schedule line. Identifies the periodic release instruction within the blanket order framework.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the semiconductor manufacturer to the customer after availability check (ATP) and capacity validation. May differ from the requested date due to wafer fab cycle time or OSAT capacity constraints.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity confirmed by the manufacturer for delivery on this schedule line after ATP (Available-to-Promise) check. May be less than ordered quantity due to allocation constraints or yield limitations.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the semiconductor product was manufactured (wafer fab or final assembly location). Required for customs declarations, tariff classification, and export control compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery schedule line record was first created in the source SAP S/4HANA SD system. Supports audit trail, data lineage, and SLA measurement from order entry.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction value fields on this delivery schedule line (e.g., USD, EUR, JPY). Supports multi-currency semiconductor sales operations.. Valid values are `^[A-Z]{3}$`',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of units shipped and delivered against this schedule line. Populated from goods issue and proof-of-delivery confirmation. Used to compute open backlog.',
    `delivery_document_number` STRING COMMENT 'SAP outbound delivery document number (SD delivery order) created against this schedule line. Links the schedule line to the physical goods issue and shipping execution documents.',
    `die_bank_order_number` STRING COMMENT 'Reference number for a die bank order when delivery is fulfilled from pre-tested Known Good Die (KGD) inventory rather than a new wafer start. Supports die bank fulfillment tracking in the order-to-cash lifecycle.',
    `eccn_code` STRING COMMENT 'Export Control Classification Number assigned to the semiconductor product on this schedule line per the US Commerce Control List (CCL). Determines applicable export license requirements. Examples: 3A001 (electronic components), 3E001 (technology for IC design).',
    `export_control_status` STRING COMMENT 'Export control compliance status for this delivery schedule line. Semiconductor shipments may be subject to EAR (Export Administration Regulations), ITAR (International Traffic in Arms Regulations), or CHIPS Act restrictions. blocked prevents shipment until clearance is obtained.. Valid values are `approved|pending_review|blocked|not_required`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment for this delivery schedule line contains hazardous materials (e.g., certain chemical compounds in semiconductor packaging). Triggers special handling, labeling, and documentation requirements per RoHS and REACH regulations.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the transfer of risk and responsibility between the semiconductor manufacturer and the customer for this delivery. Governs freight cost allocation and insurance obligations. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'The named place or port associated with the Incoterms code for this delivery schedule line (e.g., FOB Shanghai, DAP Austin TX). Required by ICC Incoterms 2020 to complete the delivery terms specification.',
    `last_reschedule_reason` STRING COMMENT 'Free-text or coded reason for the most recent rescheduling of this delivery schedule line (e.g., wafer yield shortfall, OSAT capacity constraint, customer push-out request, export hold). Supports root cause analysis for delivery performance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this delivery schedule line record in the source SAP S/4HANA SD system. Used for incremental data pipeline processing and change detection in the Silver layer.',
    `lot_number` STRING COMMENT 'Semiconductor production lot number (wafer lot or assembly lot) assigned to the units being delivered on this schedule line. Enables full traceability from customer delivery back to wafer fabrication and process parameters. Sourced from Camstar MES lot tracking.',
    `mpw_order_flag` BOOLEAN COMMENT 'Indicates whether this delivery schedule line is associated with a Multi-Project Wafer (MPW) order, where multiple customer designs share a single wafer run. MPW orders have distinct lead times and delivery constraints.',
    `net_value` DECIMAL(18,2) COMMENT 'Net monetary value of the confirmed quantity on this delivery schedule line in the transaction currency. Calculated as confirmed quantity multiplied by the agreed unit price. Used for revenue recognition, backlog valuation, and SOX financial reporting.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of semiconductor units (dies, packaged ICs, wafers) originally ordered by the customer on this schedule line. Expressed in the sales unit of measure (e.g., pieces, wafers).',
    `packaging_type` STRING COMMENT 'The physical packaging format for the semiconductor units being delivered on this schedule line. Packaging type affects handling, storage, and customer assembly line compatibility. Common formats include tape-and-reel (for SMT), tray, tube, bulk, waffle pack, and bare wafer.. Valid values are `tape_and_reel|tray|tube|bulk|waffle_pack|wafer`',
    `quantity_unit` STRING COMMENT 'Unit of measure for all quantity fields on this schedule line. Common semiconductor units include PC (pieces/individual ICs), WF (wafers), KGD (Known Good Die), LOT (production lot), REEL (tape-and-reel packaging), TRAY (tray packaging).. Valid values are `PC|WF|KGD|LOT|REEL|TRAY`',
    `requested_delivery_date` DATE COMMENT 'The delivery date originally requested by the customer for this schedule line. Represents the customers desired receipt date and is the baseline for on-time delivery (OTD) measurement.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the semiconductor product being delivered on this schedule line is compliant with the EU Restriction of Hazardous Substances (RoHS) Directive. Required for shipments to EU customers and increasingly mandated globally.',
    `sap_schedule_line_category` STRING COMMENT 'SAP SD schedule line category code controlling the delivery and goods movement behavior of this schedule line (e.g., CP = standard delivery with transfer of requirements, CN = no goods movement). Sourced from SAP VBEP-ETTYP.. Valid values are `CP|CN|CS|BN|BP|BS`',
    `schedule_line_number` STRING COMMENT 'Sequential line number of this delivery schedule entry within the parent order line item. Used to order multiple delivery windows for the same order line (e.g., line 1 = 500 units on date A, line 2 = 500 units on date B).',
    `schedule_line_revision` STRING COMMENT 'Revision counter tracking how many times this delivery schedule line has been modified (date changes, quantity adjustments, rescheduling). Supports audit trail requirements and customer change notification (PCN) tracking.',
    `schedule_line_status` STRING COMMENT 'Current fulfillment lifecycle status of this delivery schedule line. Drives backlog management, delivery performance reporting, and customer communication. blocked indicates an export control or credit hold.. Valid values are `open|confirmed|partially_delivered|fully_delivered|cancelled|blocked`',
    `scheduled_ship_date` DATE COMMENT 'The planned date on which the shipment is expected to leave the ship-from location (fab, OSAT, or warehouse). Calculated by subtracting transit lead time from the confirmed delivery date.',
    `shipment_tracking_number` STRING COMMENT 'External carrier-assigned tracking number (AWB, BOL, or parcel tracking ID) for the shipment associated with this delivery schedule line. Enables real-time shipment visibility and proof-of-delivery confirmation.',
    `wafer_start_authorization_number` STRING COMMENT 'Wafer Start Authorization number linking this delivery schedule line to the authorized wafer fab start that will produce the units for this delivery. Critical for semiconductor order-to-cash lifecycle management and fab capacity planning.',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Planned and confirmed delivery schedule for customer orders, capturing multiple delivery windows per order line. Records scheduled delivery date, confirmed quantity, ship-from location (fab, OSAT, warehouse), ship-to customer location, carrier, incoterms, and schedule line status. Supports rolling delivery schedules for high-volume customers with blanket orders and periodic call-offs. Sourced from SAP S/4HANA SD schedule lines.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique system-generated identifier for the shipment record. Primary key for the shipment data product in the order domain.',
    `account_id` BIGINT COMMENT 'Reference to the customer receiving this shipment. Used for delivery confirmation, revenue recognition, and customer service tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight, logistics, and export compliance costs are allocated to cost centers for supply chain cost accounting. Real business process: transfer pricing and profitability analysis require shipment cost',
    `delivery_schedule_id` BIGINT COMMENT 'Foreign key linking to order.delivery_schedule. Business justification: A shipment fulfills one or more delivery schedule lines. Linking shipment to delivery_schedule enables traceability from planned delivery windows to actual physical shipments, which is essential for o',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Each shipment must reference the export license authorizing the goods, replacing the free‑text field.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Shipments require quality release certificates from inspection lots before goods issue. Semiconductor operations gate all outbound shipments on passing inspection lot disposition to ensure customer re',
    `line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Shipments fulfill order lines. After merging shipment_line into shipment, the shipment entity needs direct linkage to order lines for fulfillment tracking.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Shipments originate from specific warehouse/storage locations for logistics tracking, inventory depletion, and compliance documentation. Origin_facility_code is denormalized; proper FK enables accurat',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order that initiated this shipment. Links the shipment back to the order-to-cash lifecycle.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Inbound shipments from suppliers delivering wafers, materials, or packaged units. Supplier linkage enables receiving inspection, goods receipt matching, on-time delivery tracking, and supplier scoreca',
    `to_order_id` BIGINT COMMENT 'FK to order.order.order_id — Shipments fulfill customer orders. shipment.sales_order_id → order.sales_order_id. Critical for order-to-cash traceability.',
    `actual_arrival_date` DATE COMMENT 'Confirmed date the shipment physically arrived at the customer receiving location. Populated from carrier proof of delivery (POD) or customer EDI 856 acknowledgement.',
    `asn_number` STRING COMMENT 'Advance Shipment Notice (ASN) number transmitted to the customer via EDI 856 prior to physical delivery. Enables customer warehouse receiving preparation and automated goods receipt.',
    `carrier_name` STRING COMMENT 'Name of the freight carrier or logistics service provider responsible for transporting the shipment (e.g., FedEx, DHL, UPS, Nippon Express). Used for carrier performance analytics and claims management.',
    `carrier_tracking_number` STRING COMMENT 'Carrier-assigned tracking number for the shipment. Enables real-time shipment visibility and customer self-service tracking via carrier portals.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for monetary values in this shipment record (e.g., USD, EUR, JPY). Supports multi-currency operations across global semiconductor supply chains.. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'Customer-provided purchase order number referenced on the shipment and delivery documentation. Required for customer receiving, invoice matching, and accounts payable processing.',
    `damaged_goods_flag` BOOLEAN COMMENT 'Indicates whether the customer reported damaged goods upon delivery. Triggers carrier claims process, RMA initiation, and DPPM (Defective Parts Per Million) quality reporting.',
    `declared_value_usd` DECIMAL(18,2) COMMENT 'Declared value of the shipment contents in US dollars for customs and insurance purposes. Required for import duty calculation and export documentation under EAR/ITAR.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the customer delivery destination. Required for export compliance screening under EAR and ITAR regulations.. Valid values are `^[A-Z]{3}$`',
    `estimated_arrival_date` DATE COMMENT 'Carrier-provided estimated date of arrival at the customer destination. Used for delivery scheduling, customer communication, and on-time delivery (OTD) performance tracking.',
    `export_control_classification` STRING COMMENT 'Export Control Classification Number (ECCN) assigned to the semiconductor products in this shipment per the Commerce Control List (CCL). Determines applicable export license requirements.',
    `freight_cost_usd` DECIMAL(18,2) COMMENT 'Total freight and logistics cost for this shipment in US dollars. Used for cost allocation, customer billing (if freight is charged), and supply chain cost analytics.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms including packaging. Required for carrier freight billing, customs declarations, and dangerous goods compliance.',
    `hs_tariff_code` STRING COMMENT 'Harmonized System (HS) tariff classification code for the semiconductor products in this shipment. Required for customs declarations, import duties, and cross-border trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the transfer of risk and responsibility between seller and buyer. Governs freight cost allocation and title transfer point. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `inspection_certificate_number` STRING COMMENT 'Reference number of the quality inspection certificate (Certificate of Conformance or Certificate of Analysis) accompanying the shipment. Required for automotive (IATF 16949) and aerospace customers.',
    `is_multi_leg` BOOLEAN COMMENT 'Indicates whether this shipment involves multiple transportation legs (e.g., fab to OSAT to customer, or cross-border transshipment). Enables multi-leg shipment tracking and compliance documentation.',
    `lot_numbers` STRING COMMENT 'Comma-separated list of manufacturing lot numbers (wafer lot IDs) included in this shipment. Enables full traceability from customer delivery back to wafer fabrication and process engineering records in Camstar MES.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special handling instructions, or customer-specific delivery requirements associated with this shipment (e.g., ESD handling, temperature-controlled transport).',
    `package_count` STRING COMMENT 'Total number of physical packages (boxes, reels, trays, tubes) included in this shipment. Used for carrier manifest, customs declaration, and receiving verification.',
    `package_type` STRING COMMENT 'Physical packaging format used for the semiconductor products in this shipment. Determines handling requirements, ESD protection, and customer assembly line compatibility.. Valid values are `tape_and_reel|jedec_tray|tube|waffle_pack|bulk|wafer_carrier`',
    `pod_confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed as received by the customer at the delivery location per the proof of delivery (POD). Compared against shipped_quantity to identify shortages or overages.',
    `pod_receipt_date` DATE COMMENT 'Date the customer confirmed receipt of the shipment as captured in the proof of delivery (POD). Triggers downstream invoice release and revenue recognition in SAP S/4HANA FI.',
    `pod_signoff_reference` STRING COMMENT 'Customer signoff reference or electronic signature identifier from the proof of delivery document. Serves as legal evidence of delivery completion for dispute resolution and revenue recognition.',
    `quantity_shortage_flag` BOOLEAN COMMENT 'Indicates whether the customer reported a quantity shortage at delivery (POD confirmed quantity less than shipped quantity). Triggers discrepancy investigation and potential credit memo.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the shipment contents comply with EU REACH regulation requirements for chemical substance registration and restriction. Required for EU market access.',
    `receiving_location_code` STRING COMMENT 'Code identifying the specific customer receiving dock, warehouse, or facility where the shipment was delivered. Used for multi-site customer delivery routing and POD reconciliation.',
    `rma_reference_number` STRING COMMENT 'Return Merchandise Authorization (RMA) number associated with this shipment if a return or dispute has been initiated. Links shipment to the RMA and reverse logistics process.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether all semiconductor products in this shipment comply with the EU Restriction of Hazardous Substances (RoHS) Directive. Required for EU market access and customer compliance declarations.',
    `service_level` STRING COMMENT 'Carrier service tier selected for this shipment (e.g., overnight, express, standard ground). Determines transit time commitment and freight cost.. Valid values are `standard|express|overnight|economy|priority`',
    `ship_date` DATE COMMENT 'Actual date the shipment physically departed the origin facility (fab, OSAT, or distribution center). Principal business event date for the shipment transaction.',
    `shipment_number` STRING COMMENT 'Externally visible, human-readable shipment identifier used in carrier communications, customer EDI 856 ASN, and logistics documentation. Sourced from SAP S/4HANA SD outbound delivery number.. Valid values are `^SHP-[0-9]{10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle state of the shipment. Drives downstream processes including invoice release and revenue recognition upon delivery confirmation.. Valid values are `draft|confirmed|in_transit|delivered|cancelled|on_hold`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Total quantity of semiconductor units (dies, packaged ICs, wafers) physically shipped in this shipment. Expressed in the base unit of measure (UOM) for the product.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the shipped quantity. EA = each (packaged IC), WFR = wafer, DIE = individual die, REEL = tape-and-reel, TRAY = JEDEC tray, TUBE = IC tube.. Valid values are `EA|WFR|DIE|REEL|TRAY|TUBE`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the shipment record. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `wrong_part_flag` BOOLEAN COMMENT 'Indicates whether the customer reported receipt of an incorrect part number or product. Triggers RMA process, root cause analysis, and corrective action in the quality management system.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Physical shipment record tracking the outbound movement of semiconductor products from origin (fab, OSAT, distribution center) to customer destination. Header captures shipment number, carrier, tracking number, ship date, estimated and actual arrival dates, package count, gross weight, HS tariff codes, export license reference, and shipment status. Line-level detail captures shipped quantity per order line, lot numbers, wafer lot IDs, package types, serial numbers, unit of measure, and inspection certificate references. Delivery confirmation section captures proof of delivery (POD) including confirmed receipt date, receiving location, confirmed quantity, customer PO reference, discrepancy flags (quantity shortage, wrong part, damaged goods), and customer signoff reference. POD receipt triggers downstream invoice release and revenue recognition. Supports multi-leg shipments, cross-border trade compliance (EAR, ITAR), RMA dispute resolution, and full traceability from order line through physical delivery. Sourced from SAP S/4HANA SD outbound delivery, carrier POD data, and customer EDI 856 ASN acknowledgements.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`shipment_line` (
    `shipment_line_id` BIGINT COMMENT 'Unique surrogate identifier for each shipment line record in the Silver Layer lakehouse. Primary key for the shipment_line data product.',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Die bank shipments for KGD sales require traceability to the specific die bank lot shipped, enabling lot genealogy tracking, quality issue containment, and customer-specific bin/grade fulfillment veri',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Individual shipment lines may contain different SKUs with different ECCN codes; line-level classification enables accurate EEI filing and license consumption tracking. Regulatory reporting requirement',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Finished goods shipments must link to specific inventory lots for lot traceability, date code tracking, and quality issue containment. Critical for customer notifications, field returns correlation, a',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Shipment line release depends on line-level quality disposition from inspection lots. Each shipment line must reference the specific inspection lot that cleared the material for shipment, enabling lot',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the wafer lot from which the shipped dies or packaged ICs originated. Enables fab-level traceability from customer shipment back to wafer fabrication run in the MES.',
    `mpw_shuttle_id` BIGINT COMMENT 'Identifier for the Multi-Project Wafer run from which this shipment lines product originated. Enables traceability for MPW orders where multiple customer designs share a single wafer fabrication run.',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment header record. Links this line to the physical shipment event (HEADER_REFERENCE per TRANSACTION_LINE role).',
    `line_id` BIGINT COMMENT 'Reference to the customer order line that this shipment line fulfills. Enables traceability from physical shipment back to the originating sales order line in the order-to-cash lifecycle.',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, etc.) being shipped on this line. RESOURCE_REFERENCE per TRANSACTION_LINE role.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Shipment lines may contain items from multiple suppliers in consolidated shipments. Line-level supplier tracking supports accurate goods receipt, quality inspection routing, and supplier performance a',
    `to_order_line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Critical fulfillment traceability link. Each shipment line fulfills a specific order line. Required for order fulfillment tracking, partial shipment management, and revenue recognition.',
    `to_shipment_id` BIGINT COMMENT 'FK to order.shipment.shipment_id — Fundamental header-to-line relationship. Every shipment line must belong to exactly one shipment.',
    `actual_ship_date` DATE COMMENT 'Date on which the product was physically handed over to the carrier or freight forwarder. Used for on-time shipment performance, revenue recognition trigger, and export documentation.',
    `advance_ship_notice_number` STRING COMMENT 'EDI Advance Ship Notice (ASN/856) document number transmitted to the customer prior to shipment. Enables customer receiving automation and inventory planning.',
    `backorder_flag` BOOLEAN COMMENT 'Indicates whether this shipment line represents a partial fulfillment of a backordered quantity, where the full ordered quantity could not be shipped due to inventory allocation constraints.',
    `certificate_of_conformance_number` STRING COMMENT 'Document number of the Certificate of Conformance issued by quality assurance, attesting that the shipped product meets all specified requirements. Required for automotive (IATF 16949) and aerospace customers.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the semiconductor product was manufactured or substantially transformed. Required for customs declarations, export control (EAR/ITAR), and RoHS/REACH compliance documentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipment line record was first created in the system. Used for audit trail, data lineage, and Silver Layer ingestion tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit selling price and line value (e.g., USD, EUR, JPY). Required for multi-currency order management.. Valid values are `^[A-Z]{3}$`',
    `customer_part_number` STRING COMMENT 'Customer-assigned part number or device designation for the shipped product. Required for customer-facing shipping documents, ASN (Advance Ship Notice), and design-in traceability.',
    `date_code` STRING COMMENT 'Manufacturing date code in YYWW format (year + work week) indicating when the product was fabricated or assembled. Required for shelf-life management, FIFO inventory rotation, and customer quality audits.. Valid values are `^[0-9]{4}[0-9]{2}$`',
    `delivery_document_number` STRING COMMENT 'Externally-visible SAP outbound delivery document number associated with this shipment line, used for customer communication and logistics coordination.',
    `die_bank_order_number` STRING COMMENT 'Reference to the die bank order from which known good dies (KGD) were drawn for this shipment. Applicable when shipping bare dies or KGD from die bank inventory rather than packaged product.',
    `goods_issue_timestamp` TIMESTAMP COMMENT 'Precise timestamp when goods issue was posted in SAP, marking the transfer of ownership and triggering revenue recognition and inventory reduction. BUSINESS_EVENT_TIMESTAMP for this transaction line.',
    `inspection_certificate_number` STRING COMMENT 'Reference number of the quality inspection certificate (Certificate of Conformance or Certificate of Analysis) issued for this shipment line. Links to quality records from KLA ICOS inspection systems and QM module.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether this shipment line item is subject to ITAR controls as a defense article or defense service. When true, requires State Department export license and end-use certificate.',
    `line_net_value` DECIMAL(18,2) COMMENT 'Total net value of this shipment line (shipped_quantity × unit_selling_price after applicable discounts). Used for revenue recognition, invoice generation, and SOX financial reporting.',
    `line_number` STRING COMMENT 'Sequential line number within the parent shipment, used to order and reference individual line items. LINE_SEQUENCE per TRANSACTION_LINE role.',
    `line_status` STRING COMMENT 'Current fulfillment lifecycle status of this shipment line. Tracks progression from open through picking, packing, shipment, and delivery confirmation or cancellation.. Valid values are `open|picking|packed|shipped|delivered|cancelled`',
    `lot_number` STRING COMMENT 'Manufacturing lot number assigned during wafer fabrication or assembly. Critical for traceability, quality dispute resolution, and RMA processing. Sourced from Camstar MES lot management.',
    `moisture_sensitivity_level` STRING COMMENT 'JEDEC moisture sensitivity level classification for the shipped packaged IC. Determines floor life, storage, and baking requirements at the customers SMT assembly facility.. Valid values are `MSL1|MSL2|MSL2a|MSL3|MSL4|MSL5`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Original quantity requested on the customer order line for this product. Enables calculation of fulfillment rate and identification of short-ships or over-ships.',
    `package_type` STRING COMMENT 'Semiconductor package type for the shipped product (e.g., BGA, QFN, WLCSP, InFO, CoWoS, TSOP, DIP, SOP). Determines handling, inspection, and customer board assembly requirements. [ENUM-REF-CANDIDATE: BGA|QFN|WLCSP|InFO|CoWoS|TSOP|DIP|SOP|LGA|CSP — promote to reference product]',
    `packaging_configuration` STRING COMMENT 'Physical packaging configuration used for the shipped semiconductor units. Determines handling requirements, moisture sensitivity level (MSL), and customer SMT assembly compatibility.. Valid values are `tape_and_reel|tray|tube|bulk|waffle_pack|dry_pack`',
    `part_number` STRING COMMENT 'Manufacturer part number (MPN) for the shipped semiconductor product as listed in the product catalog and on the shipping documentation. Used for customer identification and BOM matching.',
    `partial_shipment_flag` BOOLEAN COMMENT 'Indicates whether this line represents a partial shipment against the order line quantity. When true, additional shipment lines are expected to fulfill the remaining ordered quantity.',
    `promised_delivery_date` DATE COMMENT 'Committed delivery date for this shipment line as agreed with the customer at order entry. Used for on-time delivery (OTD) performance measurement and customer SLA tracking.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the shipped product complies with EU REACH regulation requirements for chemical substance registration and restriction. Required for EU market access and supply chain transparency.',
    `revision_level` STRING COMMENT 'Hardware or mask revision level of the shipped IC (e.g., A0, B1, C2). Critical for customer compatibility verification, PCN (Product Change Notification) compliance, and field failure analysis.',
    `rma_reference_number` STRING COMMENT 'RMA number associated with this shipment line if it is a replacement shipment for a previously returned or disputed lot. Enables linkage between original shipment, quality dispute, and replacement fulfillment.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the shipped product complies with EU RoHS Directive restrictions on hazardous substances (lead, mercury, cadmium, etc.). Required for EU market access and customer compliance declarations.',
    `serial_number_range_end` STRING COMMENT 'Ending serial number of the serialized unit range included in this shipment line. Used with serial_number_range_start to define the complete set of serialized units shipped.',
    `serial_number_range_start` STRING COMMENT 'Starting serial number of the serialized unit range included in this shipment line. Applicable for high-value or security-sensitive ICs requiring individual unit traceability (e.g., automotive, military-grade).',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of semiconductor units (dies, packaged ICs, wafers, etc.) physically shipped on this line. LINE_QUANTITY per TRANSACTION_LINE role. May differ from ordered quantity due to partial shipments or allocation constraints.',
    `temperature_grade` STRING COMMENT 'Operating temperature range grade of the shipped IC (commercial: 0–70°C, industrial: -40–85°C, automotive: -40–125°C, military: -55–125°C). Critical for customer application qualification and IATF 16949 automotive compliance.. Valid values are `commercial|industrial|automotive|military|extended`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the shipped quantity. Common semiconductor UoMs include EA (each/die), WFR (wafer), LOT (production lot), REEL (tape-and-reel packaging), TRAY (IC tray), BOX (carton). Aligned with SAP base UoM.. Valid values are `EA|WFR|LOT|REEL|TRAY|BOX`',
    `unit_selling_price` DECIMAL(18,2) COMMENT 'Agreed selling price per unit for this shipment line as invoiced to the customer. LINE_VALUE_OR_RESULT per TRANSACTION_LINE role. Sensitive commercial pricing data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this shipment line record. Supports change data capture (CDC), audit compliance, and Silver Layer delta processing.',
    `wafer_start_authorization_number` STRING COMMENT 'Wafer Start Authorization number that triggered the production lot associated with this shipment line. Links shipment fulfillment back to the original fab capacity commitment in the order-to-cash lifecycle.',
    `yield_grade` STRING COMMENT 'Quality or speed grade assigned to the shipped product based on wafer test (probe) results and final test binning. Indicates performance tier (e.g., commercial, industrial, automotive, military grade) for the shipped units.',
    CONSTRAINT pk_shipment_line PRIMARY KEY(`shipment_line_id`)
) COMMENT 'Line-level detail of a shipment record, linking specific order lines and quantities to a physical shipment. Captures shipped quantity, unit of measure, lot number, wafer lot ID, package type, serial numbers (where applicable), and inspection certificate references. Enables traceability from customer order line to physical shipment and supports RMA and quality dispute resolution.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`backlog_position` (
    `backlog_position_id` BIGINT COMMENT 'Unique surrogate identifier for each backlog position snapshot record in the order-to-cash lifecycle. Primary key for the backlog_position data product.',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with this backlog position. Used for customer-level backlog aggregation, escalation prioritization, and revenue forecasting.',
    `delivery_schedule_id` BIGINT COMMENT 'Foreign key linking to order.delivery_schedule. Business justification: A backlog position snapshot captures the open order backlog for a specific order line, including committed delivery dates. Linking backlog_position to delivery_schedule enables reconciliation between ',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order header to which this backlog position belongs. Links the backlog snapshot to the originating customer order.',
    `line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Backlog positions track unshipped quantities for specific order lines. Without this FK, backlog cannot be reconciled to orders.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Backlog items track quality spec compliance for allocation prioritization. Semiconductor operations prioritize backlog allocation based on available inventory meeting the orders quality specification',
    `sales_design_win_id` BIGINT COMMENT 'Foreign key linking to sales.sales_design_win. Business justification: Backlog positions represent unfulfilled demand for design wins. Linking enables design-win-specific backlog reporting, revenue forecasting, and capacity planning—essential for managing design win ramp',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, or discrete device) associated with this backlog position. Enables product-level backlog analysis and demand planning.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Backlog positions track supply-constrained parts by supplier source. Supplier linkage enables backlog analysis by supplier capacity, allocation priority management, and supply risk assessment for cons',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity from available inventory or in-process production lots that has been formally allocated to fulfill this backlog position. May be less than committed_quantity in constrained supply scenarios.',
    `allocation_status` STRING COMMENT 'Indicates the degree to which available inventory or production capacity has been allocated to fulfill this backlog position. Critical for backlog management and supply-demand balancing in constrained semiconductor supply environments.. Valid values are `unallocated|partially_allocated|fully_allocated|over_allocated`',
    `backlog_aging_days` STRING COMMENT 'Number of calendar days this order line has been in open backlog as of the snapshot date, calculated from order_entry_date. Used for customer escalation prioritization and aged backlog reporting.',
    `backlog_status` STRING COMMENT 'Current workflow state of this backlog position. open = unshipped committed order; committed = confirmed with delivery date; at_risk = delivery commitment in jeopardy; pushed_out = delivery date deferred; cancelled = order line cancelled; fulfilled = shipped and closed.. Valid values are `open|committed|at_risk|pushed_out|cancelled|fulfilled`',
    `backlog_value` DECIMAL(18,2) COMMENT 'The monetary value of the unshipped committed backlog quantity, calculated as committed_quantity multiplied by the net selling price. Used for revenue forecasting, quarterly guidance, and book-to-bill ratio reporting.',
    `cancelled_quantity` DECIMAL(18,2) COMMENT 'Quantity cancelled from the original order line. Tracks cancellation impact on backlog coverage and book-to-bill ratio reporting.',
    `committed_quantity` DECIMAL(18,2) COMMENT 'The unshipped quantity (in units) that remains committed in backlog for this order line as of the snapshot date. Core metric for backlog management and production planning.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this backlog position record was first created in the data platform. Used for audit trail, data lineage, and record lifecycle management.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the backlog value and selling price are denominated (e.g., USD, EUR, JPY, KRW, TWD). Required for multi-currency backlog reporting and FX exposure analysis.. Valid values are `^[A-Z]{3}$`',
    `current_commit_date` DATE COMMENT 'The most recent confirmed delivery date committed to the customer, reflecting any push-outs or pull-ins from the original promise date. Used for revenue forecasting and quarterly close planning.',
    `customer_part_number` STRING COMMENT 'The customers own part number or reference code for the ordered product. Required for customer-facing order confirmations and cross-referencing customer purchase orders with internal part numbers.',
    `customer_po_number` STRING COMMENT 'The customers purchase order number referencing this backlog position. Required for customer reconciliation, invoice matching, and accounts receivable processing.',
    `design_win_flag` BOOLEAN COMMENT 'Indicates whether this backlog position is associated with a strategic design-win account tracked in Salesforce CRM. Design-win orders receive elevated fulfillment priority to protect long-term revenue relationships.',
    `end_market_segment` STRING COMMENT 'The end-market application segment for which the ordered semiconductor product is destined. Used for segment-level backlog analysis, demand forecasting, and investor guidance on market exposure. [ENUM-REF-CANDIDATE: computing|mobile|automotive|industrial|iot|communications|consumer|ai_datacenter — promote to reference product]',
    `export_control_flag` BOOLEAN COMMENT 'Indicates whether this order line is subject to export control regulations (EAR/ITAR). When true, shipment requires validated export license or license exception before fulfillment.',
    `export_license_number` STRING COMMENT 'The export license number issued by the Bureau of Industry and Security (BIS) or State Department authorizing shipment of controlled semiconductor products. Required when export_control_flag is true.',
    `hold_code` STRING COMMENT 'Code indicating the reason this backlog position is on hold and cannot be shipped. Examples include credit hold, export license pending, quality hold, or customer-requested hold. Null when no hold is active. [ENUM-REF-CANDIDATE: credit_hold|export_hold|quality_hold|customer_hold|compliance_hold|capacity_hold — promote to reference product]',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost responsibilities between seller and buyer for this order line. Impacts revenue recognition timing. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this backlog position record was most recently modified, reflecting the latest change to any field such as commit date revision, quantity adjustment, or status change.',
    `net_selling_price` DECIMAL(18,2) COMMENT 'The agreed net unit selling price for this order line after all applicable discounts and price adjustments. Used to compute backlog value and support revenue recognition under ASC 606.',
    `order_entry_date` DATE COMMENT 'The date on which the customer order was originally entered into the order management system. Used to calculate backlog aging and time-in-backlog metrics.',
    `order_type` STRING COMMENT 'Classification of the order type driving this backlog position. Distinguishes standard production orders from Multi-Project Wafer (MPW) orders, die bank orders, wafer start authorizations, sample orders, Return Material Authorizations (RMA), and consignment orders. [ENUM-REF-CANDIDATE: standard|mpw|die_bank|wafer_start|sample|rma|consignment — promote to reference product]',
    `original_order_quantity` DECIMAL(18,2) COMMENT 'The total quantity originally ordered by the customer on this order line. Used to calculate fulfillment percentage and track cancellation or reduction impacts on backlog.',
    `original_promise_date` DATE COMMENT 'The initial delivery date committed to the customer at the time of order entry. Baseline for measuring push-outs and delivery performance against original commitment.',
    `part_number` STRING COMMENT 'The manufacturers part number (MPN) of the semiconductor product ordered. Used for product identification, cross-referencing with PLM and ERP systems, and customer-facing order documentation.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking assigned to this backlog position for allocation and fulfillment sequencing. Lower values indicate higher priority. Used during supply-constrained periods to prioritize strategic customers and design-win accounts.',
    `push_out_days` STRING COMMENT 'Number of calendar days the current_commit_date has been deferred beyond the original_promise_date. Positive value indicates a push-out (delay); negative value indicates a pull-in (acceleration). Key metric for delivery performance and customer satisfaction.',
    `push_out_reason_code` STRING COMMENT 'Standardized reason code explaining why the delivery commitment was pushed out or pulled in. Examples include wafer yield issue, capacity constraint, material shortage, customer request, or logistics delay. [ENUM-REF-CANDIDATE: yield_issue|capacity_constraint|material_shortage|customer_request|logistics_delay|design_change|export_hold — promote to reference product]',
    `requested_delivery_date` DATE COMMENT 'The delivery date originally requested by the customer on the purchase order. May differ from the original promise date if the committed date was negotiated.',
    `revenue_recognition_flag` BOOLEAN COMMENT 'Indicates whether this backlog position meets the criteria for revenue recognition upon shipment under ASC 606 / IFRS 15. False indicates revenue deferral conditions apply (e.g., consignment, bill-and-hold arrangements).',
    `sales_region` STRING COMMENT 'Geographic sales region associated with this backlog position (e.g., Americas, EMEA, Japan, Greater China, Rest of APAC). Used for regional backlog reporting and revenue forecasting.',
    `ship_to_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the destination country for shipment. Used for export control screening, logistics routing, and regional revenue reporting.. Valid values are `^[A-Z]{3}$`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity already shipped against this order line as of the snapshot date. Together with committed_quantity, reconciles to the original order quantity.',
    `snapshot_date` DATE COMMENT 'The calendar date on which this point-in-time backlog position snapshot was captured. Enables time-series backlog trending, quarterly close reporting, and book-to-bill ratio calculation.',
    `unit_of_measure` STRING COMMENT 'The unit in which quantities are expressed for this backlog position. EA = each (individual units), KU = thousands of units, WAFER = full wafer, DIE = individual die, REEL = tape-and-reel packaging unit, TRAY = tray packaging unit.. Valid values are `EA|KU|WAFER|DIE|REEL|TRAY`',
    `wafer_lot_number` STRING COMMENT 'The fabrication lot number of the wafer batch assigned to fulfill this backlog position. Links the backlog to the specific Work in Process (WIP) lot in the fab for production tracking and yield impact analysis.',
    CONSTRAINT pk_backlog_position PRIMARY KEY(`backlog_position_id`)
) COMMENT 'Point-in-time snapshot of open order backlog for a specific order line, capturing unshipped committed quantity, backlog value, original promise date, current commit date, and backlog aging in days. Used for backlog management, revenue forecasting, customer escalation prioritization, and quarterly book-to-bill ratio reporting. Tracks push-outs, pull-ins, and cancellations affecting committed backlog. Critical for semiconductor revenue recognition, quarterly close processes, and investor guidance on backlog coverage.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`allocation_record` (
    `allocation_record_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a single inventory, capacity, or lot allocation record within the order fulfillment process.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom inventory or capacity is being allocated. Used for constrained supply allocation prioritization across competing customers.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Allocations may be tool-specific when fab capacity is constrained by particular equipment bottlenecks. Enables tool-level capacity allocation decisions, supports constrained capacity management, and t',
    `delivery_schedule_id` BIGINT COMMENT 'Foreign key linking to order.delivery_schedule. Business justification: An allocation record reserves inventory/capacity to fulfill a specific delivery schedule line. Linking allocation_record to delivery_schedule enables allocation-to-schedule traceability, supporting co',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Die bank inventory is frequently allocated to customer orders for KGD shipments. Allocation records must track which die bank lot is reserved to fulfill order commitments, enabling ATP calculations an',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Allocations of controlled inventory to orders require export license validation before allocation confirmation to prevent license violations. Compliance control point in supply allocation.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Finished goods allocations reserve specific inventory lots to customer orders, critical for ATP/CTP planning, lot traceability, and FEFO/FIFO fulfillment logic. Enables linking allocation decisions to',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Allocation records reference specific inspection lot dispositions for quality-gated inventory allocation. Semiconductor operations allocate only material that has passed inspection to customer orders,',
    `mpw_shuttle_id` BIGINT COMMENT 'Reference to the Multi-Project Wafer run associated with this allocation, applicable when the lot type is mpw_lot. Supports MPW order and production lot assignment management.',
    `line_id` BIGINT COMMENT 'FK to order.order_line.order_line_id — Allocations reserve inventory against specific order lines. This is the core link for constrained supply management.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Supply allocation decisions are driven by process node capacity constraints, technology transitions, and fab loading. Critical for capacity-constrained allocation strategy and technology migration pla',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: allocation_record.process_node is a plain-text denormalization of process_technology_node. Semiconductor supply allocation is fundamentally node-specific — allocation teams manage constrained wafer st',
    `sales_design_win_id` BIGINT COMMENT 'Foreign key linking to sales.sales_design_win. Business justification: Allocation decisions prioritize constrained supply to strategic design wins. Linking enables design-win-based allocation policy enforcement, supply commitment tracking, and priority-based fulfillment—',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order header under which this allocation record is created. Supports backlog management and order-to-cash reporting.',
    `sku_id` BIGINT COMMENT 'Reference to the semiconductor product (IC, SoC, ASIC, FPGA, packaged die, or wafer) being allocated to the customer order line.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Allocation records tie inventory/capacity allocations to supplier source (foundry, OSAT). Supplier linkage supports allocation fairness audits, supplier capacity utilization tracking, and supply chain',
    `wafer_start_authorization_id` BIGINT COMMENT 'Foreign key linking to order.wafer_start_authorization. Business justification: An allocation record may be linked to a specific wafer start authorization when allocating wafer capacity for a customer order. The allocation_record already has a wafer_start_authorization_number (st',
    `actual_ship_date` DATE COMMENT 'The actual date on which the allocated goods were shipped to the customer. Used for on-time delivery measurement and order fulfillment confirmation.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity of units (dies, wafers, or packaged devices) reserved against the customer order line. Expressed in the unit of measure applicable to the lot type.',
    `allocation_date` DATE COMMENT 'The business date on which the allocation was created and the inventory or capacity was reserved against the order line. Principal business event date for this transaction.',
    `allocation_number` STRING COMMENT 'Externally visible, human-readable business identifier for this allocation record. Used in customer communications, ERP transactions, and supply chain coordination.. Valid values are `^ALLOC-[0-9]{10}$`',
    `allocation_source` STRING COMMENT 'Identifies the inventory or capacity pool from which this allocation is drawn: finished_goods (packaged inventory), die_bank (singulated die inventory), wafer_lot (in-process wafer inventory), fab_capacity (reserved fab production capacity), mpw_pool (Multi-Project Wafer shared pool).. Valid values are `finished_goods|die_bank|wafer_lot|fab_capacity|mpw_pool`',
    `allocation_type` STRING COMMENT 'Categorizes the nature of the allocation: hard (firm reservation of physical inventory), soft (provisional hold pending confirmation), tentative (preliminary planning hold), capacity (fab capacity reservation), die_bank (allocation from die bank inventory), mpw (Multi-Project Wafer run allocation). [ENUM-REF-CANDIDATE: hard|soft|tentative|capacity|die_bank|mpw — promote to reference product]. Valid values are `hard|soft|tentative|capacity|die_bank|mpw`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the allocation assignment: tentative (preliminary hold), confirmed (firm allocation committed to order), shipped (goods dispatched against this allocation), cancelled (allocation voided), expired (allocation lapsed past expiry date), on_hold (allocation suspended pending resolution). [ENUM-REF-CANDIDATE: tentative|confirmed|shipped|cancelled|expired|on_hold — promote to reference product]. Valid values are `tentative|confirmed|shipped|cancelled|expired|on_hold`',
    `backlog_flag` BOOLEAN COMMENT 'Indicates whether this allocation record is part of the open order backlog (i.e., not yet shipped). Used for backlog management reporting and supply-demand balancing.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why this allocation was cancelled. Populated when assignment_status transitions to cancelled. Supports root cause analysis and supply planning.',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether this allocation is associated with production eligible for US CHIPS and Science Act incentives or reporting requirements. Supports CHIPS Act compliance tracking.',
    `confirmation_date` DATE COMMENT 'The date on which the allocation was formally confirmed, transitioning from tentative or soft to confirmed status. Triggers downstream shipment scheduling.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity formally confirmed for shipment after quality disposition and availability verification. May differ from allocated_quantity due to yield loss, quality holds, or partial confirmations.',
    `constrained_supply_flag` BOOLEAN COMMENT 'Indicates whether this allocation was made under constrained supply conditions, where demand exceeded available inventory or fab capacity. Triggers priority-based allocation logic.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this allocation record was first created in the order fulfillment system. Supports audit trail and data lineage requirements.',
    `end_market_segment` STRING COMMENT 'Target end-market segment for the allocated product: automotive, mobile, computing, iot, aerospace, industrial, consumer. Drives allocation priority rules and regulatory traceability requirements (e.g., IATF 16949 for automotive). [ENUM-REF-CANDIDATE: automotive|mobile|computing|iot|aerospace|industrial|consumer — promote to reference product]',
    `expiry_date` DATE COMMENT 'The date after which this allocation record is no longer valid and reserved inventory or capacity is released back to available supply. Critical for managing soft allocations and tentative holds.',
    `export_control_classification` STRING COMMENT 'Export Administration Regulations (EAR) Export Control Classification Number (ECCN) applicable to the allocated product lot. Required for export compliance screening and license determination.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility (FAB) where the allocated wafer lot or die lot was manufactured. Supports supply chain traceability and export control compliance.',
    `hold_reason` STRING COMMENT 'Reason code or description explaining why this allocation is placed on hold. Populated when assignment_status is on_hold. May relate to quality holds, export control review, or customer credit issues.',
    `inventory_batch_code` STRING COMMENT 'SAP batch management identifier for the specific inventory batch being allocated. Enables batch-level traceability and quality disposition linkage within SAP S/4HANA MM.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the allocated lot is subject to International Traffic in Arms Regulations (ITAR) controls. When true, additional export licensing and handling restrictions apply.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to this allocation record. Used for change tracking, audit compliance, and incremental data pipeline processing.',
    `lot_number` STRING COMMENT 'Manufacturing lot number of the wafer lot, die lot, or packaged goods lot being allocated. Critical for automotive (IATF 16949) and aerospace lot-level traceability from order through shipment. Sourced from Camstar MES lot tracking.',
    `lot_type` STRING COMMENT 'Classifies the type of manufacturing lot being allocated: wafer_lot (silicon wafer lot at fab), die_lot (singulated die inventory), packaged_goods_lot (finished packaged semiconductor units), mpw_lot (Multi-Project Wafer shared lot).. Valid values are `wafer_lot|die_lot|packaged_goods_lot|mpw_lot`',
    `osat_site_code` STRING COMMENT 'Code identifying the Outsourced Semiconductor Assembly and Test (OSAT) facility responsible for packaging and testing the allocated lot. Relevant for packaged goods lot allocations.',
    `priority_rank` STRING COMMENT 'Numeric priority rank assigned to this allocation record for constrained supply allocation decisions. Lower values indicate higher priority. Used during supply shortages to sequence allocation across competing customer orders.',
    `quality_disposition` STRING COMMENT 'Quality disposition status of the allocated lot or inventory batch: accepted (meets all quality specifications), rejected (fails quality criteria), conditionally_accepted (accepted with documented deviations), under_review (quality evaluation in progress), scrapped (lot destroyed). Supports IATF 16949 lot-level quality traceability.. Valid values are `accepted|rejected|conditionally_accepted|under_review|scrapped`',
    `quality_disposition_notes` STRING COMMENT 'Free-text notes documenting lot-specific quality disposition findings, deviations, or conditions associated with this allocation. Supports automotive and aerospace traceability requirements.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the allocated quantity: EA (each, for packaged units), WFR (wafers), DIE (individual die), KPC (thousand pieces). Aligns with SAP base unit of measure.. Valid values are `EA|WFR|DIE|KPC`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the allocated lot complies with EU REACH regulation requirements for chemical safety. Required for EU market shipments and supply chain due diligence.',
    `requested_ship_date` DATE COMMENT 'Customer-requested shipment date for the allocated quantity. Used for delivery schedule management and on-time delivery performance tracking.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the allocated lot meets EU RoHS Directive requirements for restriction of hazardous substances. Required for EU market shipments and customer compliance documentation.',
    `scheduled_ship_date` DATE COMMENT 'Internally confirmed shipment date scheduled by supply chain planning for this allocation. May differ from requested_ship_date due to capacity or inventory constraints.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity shipped against this allocation record. Populated upon delivery confirmation. Used for order fulfillment reconciliation and backlog management.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this allocation record originated: SAP_S4HANA (ERP-driven allocation), CAMSTAR_MES (lot-level MES allocation), SMARTFACTORY_MES (fab capacity allocation), MANUAL (manually entered allocation).. Valid values are `SAP_S4HANA|CAMSTAR_MES|SMARTFACTORY_MES|MANUAL`',
    CONSTRAINT pk_allocation_record PRIMARY KEY(`allocation_record_id`)
) COMMENT 'Inventory, capacity, and lot allocation record that reserves specific wafer lots, die bank inventory, finished goods, or fab capacity against a customer order line. Captures allocated quantity, allocation type (hard/soft), allocated lot or inventory batch, lot number, lot type (wafer lot, die lot, packaged goods lot), assignment status (tentative, confirmed, shipped), assignment date, lot-specific quality disposition notes, allocation expiry date, and priority rank. SSOT for all allocation and lot-to-order assignment decisions in the order fulfillment process. Manages constrained supply allocation across competing customer orders during supply shortages. Supports automotive (IATF 16949) and aerospace lot-level traceability requirements from order through shipment.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`nre_order` (
    `nre_order_id` BIGINT COMMENT 'Unique identifier for the NRE order record. Primary key for the NRE order entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer who contracted this NRE engagement. The party responsible for NRE payment and acceptance.',
    `customer_design_registration_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_registration. Business justification: NRE orders are directly tied to specific design registrations for milestone billing verification, deliverable tracking (tapeout, PDK, test vectors), and linking NRE charges to the registered design pr',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: NRE projects involving controlled technology (advanced process nodes, IP cores) require ECCN classification for deemed export control and technology transfer restrictions. Regulatory requirement.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: NRE projects with foreign national involvement or offshore deliverables require export license validation before project authorization. Compliance gate for technology transfer.',
    `finance_nre_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.finance_nre_agreement. Business justification: NRE orders must link to financial agreements for revenue recognition, milestone billing, and contract compliance. Finance tracks NRE revenue against contractual milestones; this link enables reconcili',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: NRE orders fund development or qualification of a specific process flow (e.g., custom process bring-up, new node development). Linking nre_order to process_flow enables NRE revenue recognition tied to',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Non-recurring engineering orders are contracted for specific IC design projects at catalog level. Essential for custom design contracts, engineering services billing, and IP development tracking.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the IC design project that this NRE order funds. Links NRE charges to specific design engineering work.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: An NRE order is associated with a specific order line representing the NRE charge on the sales order. Currently nre_order links to the order header (nre_sales_order_id, order_id → order.order) but not',
    `order_id` BIGINT COMMENT 'FK to order.order.order_id — NRE orders are linked to associated production orders for the same customer engagement.',
    `primary_nre_sales_order_id` BIGINT COMMENT 'Reference to the associated production sales order that this NRE order supports. Links NRE charges to the recurring product order.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: NRE orders frequently include test program development as a contractual deliverable. Required for NRE milestone tracking (test program delivery), customer acceptance of test coverage, and billing for ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: NRE orders frequently involve supplier-provided services: mask shop for photomask sets, foundry NRE charges, IP vendor licenses. Supplier linkage supports NRE cost allocation, vendor performance track',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: NRE orders frequently target specific fab tools for process development, tool qualification, or technology node enablement. Essential for NRE project planning, tool reservation, and tracking which equ',
    `technology_control_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.technology_control_plan. Business justification: NRE projects involving controlled technology must reference approved TCP for access control, clean team protocols, and foreign national restrictions. Regulatory mandate for deemed exports.',
    `acceptance_criteria` STRING COMMENT 'Contractually defined criteria that must be met for customer acceptance of NRE deliverables. Used for milestone signoff and dispute resolution.',
    `actual_completion_date` DATE COMMENT 'Actual date when all NRE deliverables were completed and accepted. Triggers final milestone billing and project closure.',
    `actual_start_date` DATE COMMENT 'Actual date when engineering work began. Used to track schedule adherence and project performance.',
    `cancellation_clause` STRING COMMENT 'Contractual terms governing NRE order cancellation, including notice periods, cancellation fees, and work-in-progress settlement.',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether this NRE project qualifies for CHIPS Act funding or incentives. Used for government reporting and subsidy tracking.',
    `completed_milestone_count` STRING COMMENT 'Number of milestones that have been completed and accepted by the customer. Used to calculate project completion percentage.',
    `confidentiality_level` STRING COMMENT 'Classification of confidentiality requirements for NRE deliverables and design information. Determines access controls and disclosure restrictions.. Valid values are `standard|proprietary|highly_confidential`',
    `contract_date` DATE COMMENT 'Date when the NRE contract was signed and became legally binding. Establishes the start of contractual obligations.',
    `contract_type` STRING COMMENT 'Commercial structure of the NRE contract. Determines billing method and risk allocation between customer and supplier.. Valid values are `fixed_price|time_and_materials|milestone_based|cost_plus`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NRE order record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for NRE amounts. Defines the monetary unit for all financial values in this order.. Valid values are `^[A-Z]{3}$`',
    `customer_po_number` STRING COMMENT 'Customers purchase order number authorizing the NRE engagement. Used for invoice reconciliation and payment tracking.',
    `deliverable_list` STRING COMMENT 'Comprehensive list of engineering deliverables committed in the NRE contract. Includes design files, documentation, test reports, and IP cores.',
    `design_complexity_score` DECIMAL(18,2) COMMENT 'Quantitative measure of IC design complexity based on gate count, IP blocks, and verification requirements. Used for NRE pricing and resource estimation.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Cumulative amount invoiced to date across all completed milestones. Used to track billing progress and outstanding receivables.',
    `ip_core_list` STRING COMMENT 'List of third-party or internal IP cores integrated as part of this NRE engagement. Tracks IP licensing and royalty obligations.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether this NRE engagement involves ITAR-controlled defense articles or technical data. Triggers strict export and access controls.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this NRE order record. Used for change tracking and data synchronization.',
    `milestone_count` STRING COMMENT 'Total number of engineering milestones defined in this NRE contract. Used for progress tracking and billing schedule management.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the NRE engagement. Used for knowledge capture and handoff.',
    `nre_order_number` STRING COMMENT 'Human-readable business identifier for the NRE order. Externally communicated reference number used in contracts and invoices.. Valid values are `^NRE-[0-9]{8}$`',
    `nre_status` STRING COMMENT 'Current lifecycle status of the NRE order. Tracks progression from contract approval through engineering completion and invoicing. [ENUM-REF-CANDIDATE: draft|approved|in_progress|milestone_review|completed|invoiced|cancelled — 7 candidates stripped; promote to reference product]',
    `nre_to_sales_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — NRE orders are associated with a customer engagement that typically has a parent sales order or contract reference.',
    `nre_type` STRING COMMENT 'Classification of the NRE engagement by engineering deliverable category. Determines the type of one-time engineering work being performed.. Valid values are `mask_nre|design_nre|qualification_nre|tapeout_nre|ip_integration_nre|dft_nre`',
    `paid_amount` DECIMAL(18,2) COMMENT 'Cumulative amount received from customer to date. Used to track payment status and outstanding balances.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining milestone payment schedule and due dates. References master payment terms configuration.',
    `pdk_version` STRING COMMENT 'Version of the Process Design Kit used for this NRE design work. Ensures design-manufacturing compatibility.',
    `penalty_clause` STRING COMMENT 'Contractual penalties for late delivery or non-conformance to acceptance criteria. Defines financial consequences of schedule or quality failures.',
    `planned_completion_date` DATE COMMENT 'Contractually committed date for completion of all NRE deliverables. Used for customer expectation management and penalty clauses.',
    `planned_start_date` DATE COMMENT 'Scheduled date for engineering work to commence. Used for resource planning and project scheduling.',
    `revenue_recognition_method` STRING COMMENT 'Accounting method used to recognize NRE revenue. Determines timing of revenue booking based on contract structure and completion criteria.. Valid values are `milestone|percentage_of_completion|completed_contract`',
    `total_nre_amount` DECIMAL(18,2) COMMENT 'Total contracted value of the NRE engagement across all milestones. Represents the full one-time engineering charge.',
    CONSTRAINT pk_nre_order PRIMARY KEY(`nre_order_id`)
) COMMENT 'Non-Recurring Engineering (NRE) order record capturing one-time engineering charges associated with custom IC design, mask set fabrication, or process qualification for a specific customer. Captures NRE type (mask NRE, design NRE, qualification NRE), total NRE amount, deliverable list, acceptance criteria, and linkage to the associated production order or design project. Includes milestone records defining specific engineering deliverables and payment triggers: milestone name, description, planned completion date, actual completion date, milestone amount, billing status, customer acceptance date, and acceptance signoff reference. Supports milestone-based revenue recognition for NRE contracts and tracks engineering project progress against contractual commitments. Distinct from recurring product orders due to milestone-based billing and engineering deliverable tracking.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`nre_milestone` (
    `nre_milestone_id` BIGINT COMMENT 'Unique identifier for the NRE milestone record. Primary key for the order_nre_milestone product.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to design.design_milestone. Business justification: Semiconductor NRE contracts gate payment milestones on design milestones (RTL freeze, tapeout sign-off, first silicon). Linking order_nre_milestone to design_milestone enables automated invoice trigge',
    `nre_order_id` BIGINT COMMENT 'Foreign key linking to order.nre_order. Business justification: order_nre_milestone is described as Individual milestone record within an NRE order — it is a direct child of nre_order. Currently the milestone only has order_id → order.order, which is a header-le',
    `order_id` BIGINT COMMENT 'Reference to the parent NRE order under which this milestone is defined. Links milestone to the contractual order.',
    `acceptance_signoff_by` STRING COMMENT 'Name or identifier of the customer representative who provided formal acceptance signoff for the milestone.',
    `acceptance_signoff_reference` STRING COMMENT 'Reference to the formal customer acceptance document, email, or system record confirming milestone approval.',
    `actual_completion_date` DATE COMMENT 'Actual date when the milestone deliverable was completed and submitted for customer review.',
    `actual_start_date` DATE COMMENT 'Actual date when engineering work on this milestone commenced.',
    `billing_status` STRING COMMENT 'Current billing and payment status of the milestone, tracking progression from acceptance through payment receipt.. Valid values are `not_billable|ready_to_bill|billed|paid|disputed`',
    `contract_modification_flag` BOOLEAN COMMENT 'Indicates whether this milestone has been modified from the original contract terms through a formal change order or amendment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the milestone amount (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `customer_acceptance_date` DATE COMMENT 'Date when the customer formally accepted the milestone deliverable, triggering payment and revenue recognition.',
    `deliverable_location` STRING COMMENT 'File path, document management system reference, or repository location where the milestone deliverable artifacts are stored.',
    `dependency_milestones` STRING COMMENT 'Comma-separated list of prerequisite milestone numbers or identifiers that must be completed before this milestone can begin.',
    `effort_hours_actual` DECIMAL(18,2) COMMENT 'Actual engineering effort in hours expended to complete this milestone, tracked for cost accounting and future estimation.',
    `effort_hours_planned` DECIMAL(18,2) COMMENT 'Estimated engineering effort in hours required to complete this milestone, used for resource planning and cost estimation.',
    `invoice_date` DATE COMMENT 'Date when the invoice for this milestone was issued to the customer.',
    `invoice_number` STRING COMMENT 'Reference to the invoice document generated for this milestone billing.',
    `milestone_amount` DECIMAL(18,2) COMMENT 'Contractual payment amount associated with this milestone in the order currency. Represents the revenue to be recognized upon milestone acceptance.',
    `milestone_description` STRING COMMENT 'Detailed description of the engineering deliverable, acceptance criteria, and scope of work associated with this milestone.',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone indicating progress and acceptance state. [ENUM-REF-CANDIDATE: not_started|in_progress|completed|accepted|rejected|on_hold|cancelled — 7 candidates stripped; promote to reference product]',
    `milestone_type` STRING COMMENT 'Classification of the milestone by engineering phase or deliverable category.. Valid values are `design|verification|tapeout|silicon_validation|documentation|customer_acceptance`',
    `modification_reference` STRING COMMENT 'Reference to the contract change order or amendment document that modified this milestone terms, scope, or payment.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, clarifications, or context regarding milestone execution, issues, or customer interactions.',
    `payment_due_date` DATE COMMENT 'Date by which payment for this milestone is contractually due from the customer.',
    `payment_received_date` DATE COMMENT 'Actual date when payment for this milestone was received from the customer.',
    `planned_completion_date` DATE COMMENT 'Contractually committed or planned date by which the milestone deliverable is expected to be completed.',
    `planned_start_date` DATE COMMENT 'Scheduled date when engineering work on this milestone is planned to begin.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the customer if the milestone deliverable was rejected, including specific deficiencies or gaps.',
    `revenue_recognition_amount` DECIMAL(18,2) COMMENT 'Actual amount of revenue recognized for this milestone, which may differ from milestone_amount due to contract modifications or adjustments.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue for this milestone was recognized in the financial system, typically aligned with customer acceptance date per ASC 606.',
    `rework_required_flag` BOOLEAN COMMENT 'Indicates whether engineering rework is required to address customer feedback or rejection reasons.',
    `risk_level` STRING COMMENT 'Assessment of technical or schedule risk associated with achieving this milestone on time and meeting acceptance criteria.. Valid values are `low|medium|high|critical`',
    `sequence_number` STRING COMMENT 'Ordinal position of this milestone within the NRE order, defining the execution sequence and dependencies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last modified, supporting audit trail and change tracking.',
    CONSTRAINT pk_nre_milestone PRIMARY KEY(`nre_milestone_id`)
) COMMENT 'Individual milestone record within an NRE order, defining specific engineering deliverables and associated payment triggers. Captures milestone name, description, planned completion date, actual completion date, milestone amount, billing status, customer acceptance date, and acceptance signoff reference. Supports milestone-based revenue recognition for NRE contracts and tracks engineering project progress against contractual commitments.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`rma` (
    `rma_id` BIGINT COMMENT 'Primary key for rma',
    `account_id` BIGINT COMMENT 'Reference to the customer initiating the return. Links RMA to the customer master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: RMA processing incurs inspection, rework, and scrap costs that must be allocated to cost centers for operational accounting and variance analysis. Monthly cost center reporting includes RMA-related ex',
    `customer_complaint_id` BIGINT COMMENT 'Foreign key linking to quality.customer_complaint. Business justification: RMAs are frequently initiated by customer complaints. Linking RMA to the originating customer complaint enables root cause tracking, DPPM impact analysis, and closed-loop corrective action verificatio',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Die bank RMAs require linking returned die to original die bank lot for failure analysis correlation, yield impact assessment, and potential lot containment actions. Enables root cause analysis tied t',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the manufacturing lot from which the returned units originated. Critical for traceability and yield impact analysis.',
    `failure_analysis_report_id` BIGINT COMMENT 'Reference to the failure analysis record if FA was performed. Links RMA to detailed root cause investigation and corrective action.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: RMA credit memos and warranty claims post to specific GL accounts for financial statement accuracy and audit trail. Month-end close requires RMA reserve reconciliation against GL for ASC 606 complianc',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Failure analysis requires tracking to base IC design for systemic quality issues, errata correlation, and design revision impact analysis beyond specific SKU packaging variants.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: An RMA is initiated for a specific product/line item that was shipped. Currently rma links to the order header (rma_order_id, rma_replacement_order_id, rma_sales_order_id → order.order) but not to the',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: RMA disposition triggers nonconformance report workflow for root cause analysis and corrective action. Semiconductor quality systems require NCR linkage to track material disposition, containment acti',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to order.shipment. Business justification: An RMA is triggered by a specific outbound shipment that contained defective or incorrect product. Linking rma to the originating shipment enables full traceability from return to original dispatch, s',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: RMA returns must be received into specific quarantine/inspection storage locations for failure analysis, disposition decisions, and inventory reconciliation. Receiving_facility_code is denormalized; F',
    `order_id` BIGINT COMMENT 'FK to order.order.order_id — RMAs reference the original sales order for the returned product. rma.sales_order_id → order.sales_order_id.',
    `rma_replacement_order_id` BIGINT COMMENT 'Reference to the replacement sales order created to ship substitute product to the customer. Nullable if disposition is not replacement.',
    `rma_sales_order_id` BIGINT COMMENT 'Reference to the original sales order from which the returned product was shipped. Links RMA to the originating order transaction.',
    `sku_id` BIGINT COMMENT 'Reference to the product master record for the returned semiconductor product (IC, SoC, ASIC, FPGA, or packaged die).',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: RMAs for supplier-provided materials, wafers, or services require supplier traceability for root cause analysis, supplier corrective action requests (SCAR), and quality scorecarding. Essential for sup',
    `approval_date` DATE COMMENT 'Date when the RMA was approved by the quality or customer service team. Nullable if RMA is rejected or still pending.',
    `closed_date` DATE COMMENT 'Date when the RMA was fully closed after disposition action completed (credit issued, replacement shipped, or material scrapped).',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a formal corrective action (CAPA) is required based on the RMA findings. True triggers CAPA workflow per ISO 9001 and IATF 16949.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RMA record was first created in the system. Audit trail for record lifecycle tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary value of the credit issued to the customer in the transaction currency. Nullable if no credit is issued.',
    `credit_memo_number` STRING COMMENT 'Reference number of the credit memo issued to the customer for the returned material. Nullable if no credit is issued (e.g., customer error returns).. Valid values are `^CM-[0-9]{8,12}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit amount (e.g., USD, EUR, JPY, CNY).. Valid values are `^[A-Z]{3}$`',
    `customer_contact_email` STRING COMMENT 'Email address of the customer contact for RMA correspondence, status updates, and resolution communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_contact_name` STRING COMMENT 'Name of the customer representative who initiated or is managing the RMA on the customer side. Used for communication and escalation.',
    `customer_contact_phone` STRING COMMENT 'Phone number of the customer contact for urgent RMA inquiries or escalation.',
    `defect_description` STRING COMMENT 'Free-text description of the defect or issue reported by the customer. Captures detailed failure symptoms, visual observations, or functional anomalies.',
    `disposition_instruction` STRING COMMENT 'Action to be taken with the returned material. Determines downstream workflow (credit memo, replacement order, FA request, or scrap authorization).. Valid values are `scrap|rework|credit|replacement|return_to_vendor|failure_analysis`',
    `dppm_impact_flag` BOOLEAN COMMENT 'Indicates whether this RMA should be counted in DPPM calculations. True if the defect is attributable to manufacturing or design (excludes customer-induced damage).',
    `export_control_flag` BOOLEAN COMMENT 'Indicates whether the returned product is subject to export control regulations (ITAR, EAR). True requires special handling and documentation.',
    `failure_analysis_requested` BOOLEAN COMMENT 'Indicates whether a formal failure analysis (FA) has been requested for the returned units. True triggers FA workflow and lab assignment.',
    `inspection_result` STRING COMMENT 'Outcome of the incoming inspection. Determines whether the return claim is valid and informs disposition and credit decisions.. Valid values are `defect_confirmed|no_defect_found|customer_induced|shipping_damage|inconclusive`',
    `internal_notes` STRING COMMENT 'Internal notes and comments for cross-functional coordination (quality, engineering, customer service). Not shared with customer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RMA record was last updated. Audit trail for change tracking and data lineage.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the returned product is REACH compliant. Affects material handling, disposal, and rework procedures.',
    `received_date` DATE COMMENT 'Date when the returned material was physically received at the receiving facility or OSAT partner. Nullable until material arrives.',
    `request_date` DATE COMMENT 'Date when the customer initiated the RMA request. Principal business event timestamp for the RMA lifecycle.',
    `return_reason_code` STRING COMMENT 'Standardized code categorizing the reason for the return. Used for root cause analysis, DPPM tracking, and warranty claim classification.. Valid values are `quality_defect|shipping_damage|wrong_product|customer_error|eol_return|excess_inventory`',
    `return_shipping_carrier` STRING COMMENT 'Name of the logistics carrier used to ship the returned material (e.g., FedEx, UPS, DHL, regional freight forwarder).',
    `return_tracking_number` STRING COMMENT 'Carrier tracking number for the return shipment. Used for shipment visibility and proof of receipt.',
    `returned_quantity` STRING COMMENT 'Number of units (dies, packaged chips, or wafers) returned under this RMA. Used for DPPM calculation and inventory adjustment.',
    `rma_number` STRING COMMENT 'Externally-visible unique business identifier for the RMA. Used in customer communications, shipping labels, and cross-system tracking.. Valid values are `^RMA-[0-9]{8,12}$`',
    `rma_status` STRING COMMENT 'Current lifecycle status of the RMA. Tracks progression from customer request through receipt, inspection, and final disposition. [ENUM-REF-CANDIDATE: requested|approved|rejected|in_transit|received|inspected|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the returned product is RoHS compliant. Affects disposition options (scrap vs. rework) and environmental handling requirements.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause identified during inspection or FA. Used for DPPM trending and corrective action prioritization.. Valid values are `design|process|material|handling|test_escape|customer_misuse`',
    `to_original_order` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — RMAs reference the original sales order for the returned product. Required for credit processing and quality traceability.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the returned quantity. EA=each (individual die/chip), WFR=wafer, LOT=production lot, KIT=assembly kit.. Valid values are `EA|WFR|LOT|KIT`',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this RMA is being processed as a warranty claim. True if the return is within warranty period and defect is covered.',
    `warranty_expiration_date` DATE COMMENT 'Date when the warranty coverage for the returned product expires. Used to validate warranty claim eligibility.',
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'RMA (Return Material Authorization) record managing customer returns of semiconductor products for quality issues, shipping damage, or end-of-life returns. Captures RMA number, return reason code, defect description, returned product and quantity, original order reference, disposition instruction (scrap, rework, credit, replacement), credit memo reference, and failure analysis request flag. SSOT for customer return workflows and DPPM tracking inputs.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`order`.`blanket_order` (
    `blanket_order_id` BIGINT COMMENT 'Unique surrogate identifier for the blanket purchase agreement record in the Databricks Silver layer. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer (OEM, automotive Tier-1, or distributor) who has entered into this blanket purchase agreement.',
    `customer_design_win_id` BIGINT COMMENT 'Reference to the design win record in Salesforce CRM that originated this blanket order. Links the long-term supply commitment back to the customer design-in event and program qualification milestone.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Blanket purchase agreements for controlled commodities require ECCN classification to determine license requirements for all future call-offs. Compliance framework for long-term agreements.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Blanket orders to restricted countries or end-users require export license with authorized quantity ceiling tracked against releases. License utilization tracking for multi-year agreements.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Long-term supply agreements often cover IC designs across multiple SKU variants (package/speed/temperature grades). Critical for allocation management, pricing contracts, and multi-year capacity commi',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Long-term blanket purchase agreements embed quality specifications as contractual requirements. Each blanket order must reference the agreed quality spec to ensure all call-off releases meet the custo',
    `agreed_unit_price` DECIMAL(18,2) COMMENT 'The contractually agreed price per unit for the product under this blanket order. May be a single fixed price or the base tier price when pricing tiers are defined. Expressed in the contract currency.',
    `agreement_type` STRING COMMENT 'Classification of the blanket order agreement type. Scheduling agreements define delivery cadence; quantity contracts commit to total volume; value contracts commit to total spend; MPW (Multi-Project Wafer) blankets cover shuttle run commitments; distributor frame agreements govern stocking distributor relationships.. Valid values are `scheduling_agreement|quantity_contract|value_contract|mpw_blanket|distributor_frame`',
    `allocation_priority` STRING COMMENT 'Numeric priority ranking (lower value = higher priority) used during constrained supply allocation to determine which blanket orders receive preferential wafer starts and finished goods inventory. Automotive and safety-critical programs typically receive highest priority.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when the blanket order agreement was formally approved by the authorized signatory (e.g., VP of Sales or Finance Controller) and transitioned from draft to active status. Required for SOX revenue recognition controls.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this blanket order agreement is configured to automatically renew for an additional contract period upon expiry if neither party issues a termination notice within the agreed notice window.',
    `blanket_order_number` STRING COMMENT 'Externally visible alphanumeric identifier for the blanket purchase agreement, used in customer-facing communications, SAP SD scheduling agreements, and ERP cross-references. Follows the BO- prefix convention.. Valid values are `^BO-[A-Z0-9]{6,20}$`',
    `calloff_frequency` STRING COMMENT 'The agreed cadence at which the customer issues individual release orders (call-offs) against this blanket agreement. Drives wafer start planning, fab scheduling, and inventory build strategy.. Valid values are `weekly|biweekly|monthly|quarterly|on_demand`',
    `chips_act_eligible` BOOLEAN COMMENT 'Indicates whether the product or program covered by this blanket order qualifies for US CHIPS and Science Act incentives or domestic content requirements. Relevant for US government-funded programs and domestic semiconductor supply chain initiatives.',
    `committed_quantity` DECIMAL(18,2) COMMENT 'The total quantity of units (dies, packaged ICs, or wafers) the customer has committed to purchase over the full contract period. This is the binding volume commitment underpinning the blanket agreement.',
    `contract_duration_months` STRING COMMENT 'Total duration of the blanket order agreement expressed in calendar months. Standard semiconductor blanket agreements run 12 or 24 months; automotive long-term supply agreements may extend to 36 months.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this blanket order record was first created in the source system (SAP S/4HANA SD). Represents the business event of agreement entry, not the ETL load time. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this blanket order (e.g., USD, EUR, JPY, KRW, TWD). Semiconductor contracts are predominantly denominated in USD.. Valid values are `^[A-Z]{3}$`',
    `customer_contract_number` STRING COMMENT 'The customers own purchase contract or frame agreement reference number as provided on the customers procurement documentation. Used for cross-referencing with the customers ERP or procurement system.',
    `customer_part_number` STRING COMMENT 'The customers own part number or device designation for the product covered by this blanket agreement. Required for cross-reference on customer purchase orders and shipping documents.',
    `distribution_channel` STRING COMMENT 'The sales channel through which this blanket order is fulfilled. Direct: sold directly to end customer; Distributor: fulfilled via authorized stocking distributor; Rep Firm: managed through manufacturers representative; OEM: original equipment manufacturer direct program; EMS: electronics manufacturing services partner.. Valid values are `direct|distributor|rep_firm|oem|ems`',
    `effective_date` DATE COMMENT 'The date on which the blanket order agreement becomes legally binding and call-off releases may begin. Marks the start of the contract period, typically aligned with the customers fiscal year or program start.',
    `end_market_segment` STRING COMMENT 'The primary end-market application segment for the product covered by this blanket order. Used for revenue segmentation, demand planning, and strategic reporting. [ENUM-REF-CANDIDATE: automotive|mobile|computing|industrial|iot|ai_datacenter|aerospace_defense|consumer|networking|medical — promote to reference product]',
    `expiry_date` DATE COMMENT 'The date on which the blanket order agreement expires and no further call-off releases may be issued. Typically 12 to 24 months from the effective date for semiconductor OEM and automotive Tier-1 agreements.',
    `export_license_required` BOOLEAN COMMENT 'Indicates whether an export license is required to ship product under this blanket order to the customers destination country based on the ECCN and end-use classification. Triggers compliance review workflow when True.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost responsibilities between Semiconductors and the customer for shipments under this blanket agreement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the product or technology covered by this blanket order is subject to International Traffic in Arms Regulations (ITAR) controls. When True, additional compliance approvals and end-use certificates are required before shipment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to this blanket order record in the source system. Tracks amendments to pricing, quantities, dates, or terms. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_release_date` DATE COMMENT 'The date of the most recent call-off release order issued against this blanket agreement. Used to monitor customer ordering activity, identify dormant blankets, and trigger account management follow-up.',
    `lead_time_weeks` STRING COMMENT 'The agreed manufacturing and delivery lead time in weeks from call-off release order placement to customer delivery. Encompasses wafer fab cycle time, assembly and test (OSAT), and logistics. Critical for wafer start authorization scheduling.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity per individual call-off release order as agreed in the blanket contract. Enforces production lot efficiency and wafer start economics. Expressed in the same unit of measure as committed_quantity.',
    `ncnr_coverage_percentage` DECIMAL(18,2) COMMENT 'The percentage of the committed quantity or blanket value that is subject to NCNR terms. A value of 100 means the entire commitment is NCNR; partial NCNR coverage is common in distributor agreements.',
    `ncnr_flag` BOOLEAN COMMENT 'Indicates whether the blanket order is subject to Non-Cancellable Non-Returnable (NCNR) terms. When True, the customer cannot cancel or return product once a release order is issued. Standard for automotive and high-volume OEM semiconductor supply agreements.',
    `order_status` STRING COMMENT 'Current lifecycle state of the blanket order agreement. Draft: under negotiation; Active: binding and open for call-offs; On Hold: temporarily suspended; Partially Released: some call-off orders issued; Fully Released: all committed quantity has been called off; Closed: contract period ended; Cancelled: terminated before expiry. [ENUM-REF-CANDIDATE: draft|active|on_hold|partially_released|fully_released|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `payment_terms_code` STRING COMMENT 'SAP payment terms code defining the invoice due date, early payment discount conditions, and payment schedule applicable to release orders issued under this blanket agreement (e.g., NET30, NET60, 2/10NET30).',
    `pricing_tier_structure` STRING COMMENT 'Defines the pricing model applied to this blanket order. Fixed: single price for all quantities; Volume Tiered: unit price decreases at defined quantity thresholds; Time Tiered: price adjusts at defined calendar intervals; Milestone Tiered: price adjusts upon reaching program milestones such as design-in or production ramp.. Valid values are `fixed|volume_tiered|time_tiered|milestone_tiered`',
    `product_part_number` STRING COMMENT 'The Semiconductors internal part number (device identifier) for the IC, SoC, ASIC, or FPGA product covered by this blanket order. Aligns with the product master in SAP MM and Oracle Agile PLM.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the committed and released quantities. EA = each (packaged unit); WFR = wafer; DIE = bare die; REEL = tape-and-reel packaging unit; TRAY = tray packaging unit. Aligns with SAP MM unit of measure configuration.. Valid values are `EA|WFR|DIE|REEL|TRAY`',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the product and its packaging materials comply with EU REACH Regulation (EC No 1907/2006) requirements for chemical substance registration and restriction. Required for EU market access.',
    `release_order_to_blanket` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Individual sales orders (release orders) are created against blanket orders. The sales order must reference its parent blanket for volume tracking.',
    `released_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity that has been called off against this blanket order through individual release orders to date. Used to track consumption of the committed volume and compute remaining open quantity.',
    `renewal_notice_days` STRING COMMENT 'The number of calendar days prior to the expiry date by which either party must provide written notice to prevent automatic renewal or to initiate renegotiation of the blanket agreement terms.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the product shipped under this blanket order is compliant with the EU RoHS Directive (2011/65/EU) restricting hazardous substances in electronic equipment. Mandatory for EU market shipments.',
    `sales_order_to_blanket` BIGINT COMMENT 'FK to order.sales_order.sales_order_id — Individual sales orders are call-offs against blanket orders. This link is critical for blanket quantity consumption tracking and volume commitment management.',
    `ship_to_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary customer delivery destination under this blanket agreement. Used for export control classification, logistics routing, and trade compliance screening.. Valid values are `^[A-Z]{3}$`',
    `total_blanket_value` DECIMAL(18,2) COMMENT 'The total monetary value of the blanket order agreement, calculated as committed_quantity multiplied by agreed_unit_price (or sum of tier values). Represents the maximum revenue commitment from this customer for the contract period. Used for revenue forecasting and SOX financial reporting.',
    CONSTRAINT pk_blanket_order PRIMARY KEY(`blanket_order_id`)
) COMMENT 'Long-term blanket purchase agreement with a customer defining total committed quantity, pricing tiers, and delivery cadence over a contract period (typically 12-24 months). Captures blanket order value, product mix, agreed unit prices, minimum order quantities, call-off frequency, remaining open quantity, and NCNR (non-cancellable non-returnable) terms. Supports high-volume OEM, automotive Tier-1, and distributor relationships where customers commit to annual volumes with periodic release orders against the blanket.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `semiconductors_ecm`.`order`.`order` ADD CONSTRAINT `fk_order_order_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `semiconductors_ecm`.`order`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ADD CONSTRAINT `fk_order_wafer_start_authorization_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ADD CONSTRAINT `fk_order_mpw_order_primary_mpw_sales_order_id` FOREIGN KEY (`primary_mpw_sales_order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ADD CONSTRAINT `fk_order_die_bank_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ADD CONSTRAINT `fk_order_delivery_schedule_to_order_line_id` FOREIGN KEY (`to_order_line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `semiconductors_ecm`.`order`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_to_order_id` FOREIGN KEY (`to_order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `semiconductors_ecm`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_to_order_line_id` FOREIGN KEY (`to_order_line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ADD CONSTRAINT `fk_order_shipment_line_to_shipment_id` FOREIGN KEY (`to_shipment_id`) REFERENCES `semiconductors_ecm`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `semiconductors_ecm`.`order`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ADD CONSTRAINT `fk_order_backlog_position_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `semiconductors_ecm`.`order`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ADD CONSTRAINT `fk_order_allocation_record_wafer_start_authorization_id` FOREIGN KEY (`wafer_start_authorization_id`) REFERENCES `semiconductors_ecm`.`order`.`wafer_start_authorization`(`wafer_start_authorization_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ADD CONSTRAINT `fk_order_nre_order_primary_nre_sales_order_id` FOREIGN KEY (`primary_nre_sales_order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ADD CONSTRAINT `fk_order_nre_milestone_nre_order_id` FOREIGN KEY (`nre_order_id`) REFERENCES `semiconductors_ecm`.`order`.`nre_order`(`nre_order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ADD CONSTRAINT `fk_order_nre_milestone_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_line_id` FOREIGN KEY (`line_id`) REFERENCES `semiconductors_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `semiconductors_ecm`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_order_id` FOREIGN KEY (`order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_rma_replacement_order_id` FOREIGN KEY (`rma_replacement_order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_rma_sales_order_id` FOREIGN KEY (`rma_sales_order_id`) REFERENCES `semiconductors_ecm`.`order`.`order`(`order_id`);

-- ========= TAGS =========
ALTER SCHEMA `semiconductors_ecm`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `semiconductors_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `semiconductors_ecm`.`order`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`order` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `restricted_party_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Party Screening Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win ID');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'UNALLOCATED|PARTIALLY_ALLOCATED|FULLY_ALLOCATED|OVER_ALLOCATED');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Eligible Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'DIRECT|DISTRIBUTOR|REPRESENTATIVE|ONLINE|OEM');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `end_market_segment` SET TAGS ('dbx_business_glossary_term' = 'End Market Segment');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `gross_order_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Order Value');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `gross_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Hold Reason');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Amount');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `nre_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'EDI|PORTAL|EMAIL|PHONE|SALESFORCE|MANUAL');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|STANDARD|LOW');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `so_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `so_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`order` ALTER COLUMN `wafer_start_authorization` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`line` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `reach_svhc_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Svhc Declaration Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'standard|priority|strategic|spot|buffer');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `confirmed_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `date_entered` SET TAGS ('dbx_business_glossary_term' = 'Order Line Entry Date');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `die_bank_order` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Order Line Item Category');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Order Line Number');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Order Line Status');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|allocated|shipped|invoiced|cancelled');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Production Lot Number');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `mpw_order` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Order Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Order Line Net Value');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `net_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `partial_shipment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Partial Shipment Allowed Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `product_revision` SET TAGS ('dbx_business_glossary_term' = 'Product Revision');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales Order Line Item Number');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `sap_line_item_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `speed_grade` SET TAGS ('dbx_business_glossary_term' = 'Speed Grade');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_business_glossary_term' = 'Temperature Grade');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_value_regex' = 'commercial|industrial|automotive|military|extended');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|REEL|TRAY|TUBE');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`line` ALTER COLUMN `wafer_start_authorization` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization (WSA) Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` SET TAGS ('dbx_subdomain' = 'production_authorization');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_start_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization ID');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `customer_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Registration Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Run ID');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Design Win Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Wafer Start Date');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'auto_approved|manager|director|vp');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Number');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `authorization_number` SET TAGS ('dbx_value_regex' = '^WSA-[A-Z0-9]{4,10}-[0-9]{6}$');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Authorized By');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `authorized_wafer_qty` SET TAGS ('dbx_business_glossary_term' = 'Authorized Wafer Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'US CHIPS Act Eligibility Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `cycle_time_target_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Target (Days)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `die_bank_replenishment_code` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Replenishment Plan ID');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `die_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Die Per Wafer');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `expected_good_die_qty` SET TAGS ('dbx_business_glossary_term' = 'Expected Good Die Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `fab_work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Work Order Number');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `is_mpw` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `is_nre` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `nre_charge_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Charge (USD)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `nre_charge_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Wafer Fabrication Completion Date');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Wafer Start Date');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `priority_class` SET TAGS ('dbx_value_regex' = 'hot_lot|expedite|standard|mpw|nre_pilot');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `required_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Required Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_S4|CAMSTAR|SMARTFACTORY|SFDC|AGILE_PLM|MANUAL');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference Number');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (mm)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Wafer Unit Cost (USD)');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `wafer_unit_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`wafer_start_authorization` ALTER COLUMN `yield_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Yield Target Percentage');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` SET TAGS ('dbx_subdomain' = 'production_authorization');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `mpw_order_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Order ID');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `customer_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Registration Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'MPW Shuttle Run ID');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `primary_mpw_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Sales Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout ID');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Die Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `die_quantity_delivered` SET TAGS ('dbx_business_glossary_term' = 'Die Quantity Delivered');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `die_quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Die Quantity Ordered');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `itar_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Number');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `mpw_program_type` SET TAGS ('dbx_business_glossary_term' = 'MPW Program Type');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `mpw_program_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|academic|government|internal');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `nre_charge_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Charge (USD)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `nre_charge_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'MPW Order Placement Date');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'MPW Order Notes');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'MPW Order Status');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `order_value_usd` SET TAGS ('dbx_business_glossary_term' = 'MPW Order Value (USD)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `order_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Die Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Order Priority Level');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|critical');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `reticle_slot_area_mm2` SET TAGS ('dbx_business_glossary_term' = 'Reticle Slot Area (mm²)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `reticle_slot_number` SET TAGS ('dbx_business_glossary_term' = 'Reticle Slot Number');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Code');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `tapeout_deadline` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Deadline Date');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `tapeout_received_date` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Received Date');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Die Unit Price (USD)');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `wafer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Wafer Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `wafer_start_date_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Wafer Start Date');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `wafer_start_date_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Wafer Start Date');
ALTER TABLE `semiconductors_ecm`.`order`.`mpw_order` ALTER COLUMN `yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Die Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` SET TAGS ('dbx_subdomain' = 'production_authorization');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `die_bank_order_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order ID');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank ID');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Source Lot ID');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program ID');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Design Win Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `allocated_die_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Die Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'customer_request|inventory_shortage|quality_hold|export_hold|duplicate_order|end_of_life');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `die_form` SET TAGS ('dbx_business_glossary_term' = 'Die Form');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `die_form` SET TAGS ('dbx_value_regex' = 'bare_die|wafer|singulated_kgd|tape_and_reel');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `die_part_number` SET TAGS ('dbx_business_glossary_term' = 'Die Part Number');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `die_revision` SET TAGS ('dbx_business_glossary_term' = 'Die Revision');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `kgd_grade` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Grade');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `kgd_grade` SET TAGS ('dbx_value_regex' = 'grade_a|grade_b|grade_c|engineering');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `order_value` SET TAGS ('dbx_business_glossary_term' = 'Order Value');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `osat_work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Work Order Number');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `packaging_instruction_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Instruction ID');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Order Priority Level');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `requested_die_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Die Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `shipped_die_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Die Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`die_bank_order` ALTER COLUMN `wafer_fab_site` SET TAGS ('dbx_business_glossary_term' = 'Wafer Fabrication (FAB) Site');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule ID');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Item ID');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `blanket_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `call_off_number` SET TAGS ('dbx_business_glossary_term' = 'Call-Off Number');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `delivery_document_number` SET TAGS ('dbx_business_glossary_term' = 'Outbound Delivery Document Number');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `die_bank_order_number` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order Number');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `export_control_status` SET TAGS ('dbx_business_glossary_term' = 'Export Control Status');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `export_control_status` SET TAGS ('dbx_value_regex' = 'approved|pending_review|blocked|not_required');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Named Place');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `last_reschedule_reason` SET TAGS ('dbx_business_glossary_term' = 'Last Reschedule Reason');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Production Lot Number');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `mpw_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Order Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Schedule Line Value');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `net_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'tape_and_reel|tray|tube|bulk|waffle_pack|wafer');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'PC|WF|KGD|LOT|REEL|TRAY');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `sap_schedule_line_category` SET TAGS ('dbx_business_glossary_term' = 'SAP Schedule Line Category');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `sap_schedule_line_category` SET TAGS ('dbx_value_regex' = 'CP|CN|CS|BN|BP|BS');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `schedule_line_revision` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Revision Number');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `schedule_line_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Status');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `schedule_line_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|partially_delivered|fully_delivered|cancelled|blocked');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `semiconductors_ecm`.`order`.`delivery_schedule` ALTER COLUMN `wafer_start_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization (WSA) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Storage Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Shipment Notice (ASN) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `carrier_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `damaged_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Damaged Goods Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `declared_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Declared Customs Value (USD)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `declared_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Date');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `freight_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost (USD)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `freight_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `hs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `hs_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `is_multi_leg` SET TAGS ('dbx_business_glossary_term' = 'Multi-Leg Shipment Indicator');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `lot_numbers` SET TAGS ('dbx_business_glossary_term' = 'Lot Numbers');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shipment Notes');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'tape_and_reel|jedec_tray|tube|waffle_pack|bulk|wafer_carrier');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `pod_confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Confirmed Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `pod_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Receipt Date');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `pod_signoff_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signoff Reference');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `quantity_shortage_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Shortage Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `receiving_location_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Receiving Location Code');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `rma_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Reference Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|express|overnight|economy|priority');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP-[0-9]{10}$');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|in_transit|delivered|cancelled|on_hold');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|DIE|REEL|TRAY|TUBE');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment` ALTER COLUMN `wrong_part_flag` SET TAGS ('dbx_business_glossary_term' = 'Wrong Part Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `shipment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line ID');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Run ID');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `advance_ship_notice_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Ship Notice (ASN) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `certificate_of_conformance_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Conformance (CoC) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `date_code` SET TAGS ('dbx_business_glossary_term' = 'Date Code (YYWW)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `date_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[0-9]{2}$');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `delivery_document_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `die_bank_order_number` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Order Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `line_net_value` SET TAGS ('dbx_business_glossary_term' = 'Line Net Value');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `line_net_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Status');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|picking|packed|shipped|delivered|cancelled');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Production Lot Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_value_regex' = 'MSL1|MSL2|MSL2a|MSL3|MSL4|MSL5');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `packaging_configuration` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `packaging_configuration` SET TAGS ('dbx_value_regex' = 'tape_and_reel|tray|tube|bulk|waffle_pack|dry_pack');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `partial_shipment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Shipment Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Product Revision Level');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `rma_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Reference Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `serial_number_range_end` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range End');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `serial_number_range_start` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range Start');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_business_glossary_term' = 'Temperature Grade');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `temperature_grade` SET TAGS ('dbx_value_regex' = 'commercial|industrial|automotive|military|extended');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|LOT|REEL|TRAY|BOX');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `unit_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Selling Price');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `unit_selling_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `wafer_start_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization (WSA) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`shipment_line` ALTER COLUMN `yield_grade` SET TAGS ('dbx_business_glossary_term' = 'Yield Grade');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `backlog_position_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Position ID');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Design Win Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'unallocated|partially_allocated|fully_allocated|over_allocated');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `backlog_aging_days` SET TAGS ('dbx_business_glossary_term' = 'Backlog Aging Days');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `backlog_status` SET TAGS ('dbx_business_glossary_term' = 'Backlog Position Status');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `backlog_status` SET TAGS ('dbx_value_regex' = 'open|committed|at_risk|pushed_out|cancelled|fulfilled');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `backlog_value` SET TAGS ('dbx_business_glossary_term' = 'Backlog Value');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `backlog_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `cancelled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Backlog Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `current_commit_date` SET TAGS ('dbx_business_glossary_term' = 'Current Commit Date');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Number');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `design_win_flag` SET TAGS ('dbx_business_glossary_term' = 'Design-Win Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `end_market_segment` SET TAGS ('dbx_business_glossary_term' = 'End Market Segment');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `export_license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `hold_code` SET TAGS ('dbx_business_glossary_term' = 'Order Hold Code');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `net_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Net Selling Price');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `net_selling_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `order_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Order Entry Date');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `original_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Original Order Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `original_promise_date` SET TAGS ('dbx_business_glossary_term' = 'Original Promise Date');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Backlog Priority Rank');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `push_out_days` SET TAGS ('dbx_business_glossary_term' = 'Push-Out Days');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `push_out_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Push-Out Reason Code');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Requested Delivery Date');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `revenue_recognition_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Eligible Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Backlog Snapshot Date');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KU|WAFER|DIE|REEL|TRAY');
ALTER TABLE `semiconductors_ecm`.`order`.`backlog_position` ALTER COLUMN `wafer_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Number');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` SET TAGS ('dbx_subdomain' = 'production_authorization');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `allocation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Record ID');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Run ID');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Design Win Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `wafer_start_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^ALLOC-[0-9]{10}$');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `allocation_source` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `allocation_source` SET TAGS ('dbx_value_regex' = 'finished_goods|die_bank|wafer_lot|fab_capacity|mpw_pool');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'hard|soft|tentative|capacity|die_bank|mpw');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'tentative|confirmed|shipped|cancelled|expired|on_hold');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Eligible Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `constrained_supply_flag` SET TAGS ('dbx_business_glossary_term' = 'Constrained Supply Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `end_market_segment` SET TAGS ('dbx_business_glossary_term' = 'End Market Segment');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `inventory_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Batch ID');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'wafer_lot|die_lot|packaged_goods_lot|mpw_lot');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `osat_site_code` SET TAGS ('dbx_business_glossary_term' = 'Outsourced Semiconductor Assembly and Test (OSAT) Site Code');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `quality_disposition` SET TAGS ('dbx_business_glossary_term' = 'Quality Disposition');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `quality_disposition` SET TAGS ('dbx_value_regex' = 'accepted|rejected|conditionally_accepted|under_review|scrapped');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `quality_disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Disposition Notes');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|DIE|KPC');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`order`.`allocation_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|CAMSTAR_MES|SMARTFACTORY_MES|MANUAL');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` SET TAGS ('dbx_subdomain' = 'engineering_services');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `nre_order_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Order Identifier');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `customer_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Registration Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `finance_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Nre Agreement Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Project Identifier');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `primary_nre_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Target Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `technology_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Criteria');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Engineering Completion Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Engineering Start Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `cancellation_clause` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Clause Terms');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'Creating Helpful Incentives to Produce Semiconductors (CHIPS) Act Eligible Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `completed_milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Milestone Count');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|proprietary|highly_confidential');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `contract_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Contract Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Contract Type');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fixed_price|time_and_materials|milestone_based|cost_plus');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `customer_po_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Number');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `deliverable_list` SET TAGS ('dbx_business_glossary_term' = 'Engineering Deliverable List');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `design_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Design Complexity Score');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Non-Recurring Engineering (NRE) Amount');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `ip_core_list` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Core List');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Order Notes');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `nre_order_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Order Number');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `nre_order_number` SET TAGS ('dbx_value_regex' = '^NRE-[0-9]{8}$');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `nre_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Order Status');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `nre_type` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Type');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `nre_type` SET TAGS ('dbx_value_regex' = 'mask_nre|design_nre|qualification_nre|tapeout_nre|ip_integration_nre|dft_nre');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Non-Recurring Engineering (NRE) Amount');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) Version');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Terms');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Engineering Completion Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Engineering Start Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'milestone|percentage_of_completion|completed_contract');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_order` ALTER COLUMN `total_nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Non-Recurring Engineering (NRE) Amount');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` SET TAGS ('dbx_subdomain' = 'engineering_services');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `nre_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Order Non-Recurring Engineering (NRE) Milestone Identifier');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Design Milestone Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `nre_order_id` SET TAGS ('dbx_business_glossary_term' = 'Nre Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `acceptance_signoff_by` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Signoff By');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `acceptance_signoff_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `acceptance_signoff_reference` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Signoff Reference');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'not_billable|ready_to_bill|billed|paid|disputed');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `contract_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `customer_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `deliverable_location` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Location');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `dependency_milestones` SET TAGS ('dbx_business_glossary_term' = 'Dependency Milestones');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `effort_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Effort Hours Actual');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `effort_hours_planned` SET TAGS ('dbx_business_glossary_term' = 'Effort Hours Planned');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amount');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'design|verification|tapeout|silicon_validation|documentation|customer_acceptance');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `modification_reference` SET TAGS ('dbx_business_glossary_term' = 'Modification Reference');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `revenue_recognition_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Amount');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `rework_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Required Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `semiconductors_ecm`.`order`.`nre_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Identifier');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis (FA) ID');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Shipment Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Storage Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `rma_replacement_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Order ID');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `rma_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) ID');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Approval Date');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Closed Date');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_value_regex' = '^CM-[0-9]{8,12}$');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Email Address');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone Number');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `disposition_instruction` SET TAGS ('dbx_business_glossary_term' = 'Disposition Instruction');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `disposition_instruction` SET TAGS ('dbx_value_regex' = 'scrap|rework|credit|replacement|return_to_vendor|failure_analysis');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `dppm_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM) Impact Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `failure_analysis_requested` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis (FA) Requested Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'defect_confirmed|no_defect_found|customer_induced|shipping_damage|inconclusive');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Material Received Date');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Request Date');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'quality_defect|shipping_damage|wrong_product|customer_error|eol_return|excess_inventory');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `return_shipping_carrier` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Carrier');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `return_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Tracking Number');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Number');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA-[0-9]{8,12}$');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `rma_status` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Status');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'design|process|material|handling|test_escape|customer_misuse');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|LOT|KIT');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`rma` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` SET TAGS ('dbx_subdomain' = 'sales_fulfillment');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order ID');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win ID');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `agreed_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Agreed Unit Price');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `agreed_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Blanket Agreement Type');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'scheduling_agreement|quantity_contract|value_contract|mpw_blanket|distributor_frame');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Agreement Approved Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_number` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Number');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_number` SET TAGS ('dbx_value_regex' = '^BO-[A-Z0-9]{6,20}$');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `calloff_frequency` SET TAGS ('dbx_business_glossary_term' = 'Call-Off Release Frequency');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `calloff_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|on_demand');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `chips_act_eligible` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Eligible Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration (Months)');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `customer_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Number');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `customer_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `customer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Part Number');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|rep_firm|oem|ems');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `end_market_segment` SET TAGS ('dbx_business_glossary_term' = 'End Market Segment');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `last_release_date` SET TAGS ('dbx_business_glossary_term' = 'Last Release Order Date');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `lead_time_weeks` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Weeks)');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `ncnr_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Non-Cancellable Non-Returnable (NCNR) Coverage Percentage');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `ncnr_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Cancellable Non-Returnable (NCNR) Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Status');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `pricing_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier Structure');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `pricing_tier_structure` SET TAGS ('dbx_value_regex' = 'fixed|volume_tiered|time_tiered|milestone_tiered');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `pricing_tier_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `product_part_number` SET TAGS ('dbx_business_glossary_term' = 'Product Part Number');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|WFR|DIE|REEL|TRAY');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Released Quantity');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `total_blanket_value` SET TAGS ('dbx_business_glossary_term' = 'Total Blanket Order Value');
ALTER TABLE `semiconductors_ecm`.`order`.`blanket_order` ALTER COLUMN `total_blanket_value` SET TAGS ('dbx_confidential' = 'true');
