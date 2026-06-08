-- Schema for Domain: supply | Business: Grocery | Version: v1_mvm
-- Generated on: 2026-05-04 20:42:52

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`supply` COMMENT 'End-to-end supply chain from vendor sourcing through DC receiving to store replenishment. Manages purchase orders, inbound shipments, cross-dock operations, DSD workflows, transportation routing, cold chain logistics, and RFID tracking. Integrates with Blue Yonder Demand Planning, JDA TMS, and Manhattan Associates WMS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order. Primary key.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for shipment, if known at PO creation. May be vendor-selected for FOB origin terms.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for posting PO expenses to the appropriate cost center for budgeting and variance analysis.',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: PO cost compliance: purchase orders are placed against an approved cost agreement. Linking PO header to cost_price enables cost compliance reporting — verifying the PO was issued at the approved cos',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supply.dc_facility. Business justification: Purchase orders are delivered to DC facilities as the primary receiving location. While primary_purchase_store_location_id covers store-direct POs, the majority of grocery POs are DC-destined. Adding ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: PO commitment accounting requires period-stamping for open-PO accrual reporting and budget consumption tracking by fiscal period. Retail-grocery finance teams run period-close open-PO reports to accru',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Essential for GL posting of purchase order line amounts to the correct account in financial statements.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: POs are issued by a specific legal entity (company code), determining tax jurisdiction, intercompany accounting, and financial statement consolidation. Retail-grocery operators with multiple banners o',
    `store_location_id` BIGINT COMMENT 'Identifier of the destination location where goods should be delivered. Can be a distribution center (DC), store, or micro-fulfillment center (MFC) depending on PO type.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Needed to allocate PO costs to profit centers for profitability reporting and performance dashboards.',
    `promo_campaign_id` BIGINT COMMENT 'Identifier of the promotional campaign or ad circular associated with this purchase order, if promotional_flag is true.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier_contract. Business justification: Purchase orders are issued under supplier contracts that govern pricing, payment terms, fill rate SLAs, and EDI requirements. Linking purchase_order to supply_supplier_contract is a fundamental supply',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom goods or services are being purchased.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: POs are fulfilled from a specific supplier site (plant or warehouse). The originating site determines cold-chain capability, HACCP certification, FDA registration, and lead times — all operationally c',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Purchase orders in grocery retail are issued under a governing trade agreement that controls pricing, allowances, and payment terms. Buyers and AP teams reference this link for cost validation, allowa',
    `allowance_amount` DECIMAL(18,2) COMMENT 'Total vendor allowances, rebates, or promotional funding applied to this purchase order. Reduces net cost and impacts GMROI (Gross Margin Return on Investment) calculation.',
    `approval_date` DATE COMMENT 'Date when the purchase order was approved by authorized personnel, triggering transmission to vendor. Null if still in draft status.',
    `cancellation_reason` STRING COMMENT 'Reason code for purchase order cancellation, used for vendor performance analysis and process improvement.. Valid values are `vendor_unable_to_fulfill|demand_change|pricing_issue|quality_issue|duplicate_order|other`',
    `cancelled_date` DATE COMMENT 'Date when the purchase order was cancelled, if applicable. Null for active orders.',
    `closed_date` DATE COMMENT 'Date when the purchase order was administratively closed after all goods were received and invoices matched. Marks end of PO lifecycle.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether this purchase order contains temperature-sensitive perishable items requiring cold chain logistics (refrigerated or frozen transport and storage). Critical for fresh produce, dairy, meat, and frozen goods.',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the vendor for delivery via EDI (Electronic Data Interchange) acknowledgment or manual confirmation. May differ from requested date due to vendor capacity or lead time constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `edi_transmission_flag` BOOLEAN COMMENT 'Indicates whether this purchase order was transmitted to the vendor via EDI 850 transaction set (true) or via manual methods such as email or fax (false).',
    `edi_transmission_timestamp` TIMESTAMP COMMENT 'Timestamp when the EDI 850 purchase order transaction was transmitted to the vendor. Null if edi_transmission_flag is false.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight or shipping charges associated with this purchase order. May be vendor-paid, prepaid-and-add, or collect depending on Incoterms.',
    `incoterms` STRING COMMENT 'International commercial terms defining the division of costs and risks between buyer and vendor. FOB (Free On Board), CIF (Cost Insurance Freight), EXW (Ex Works), DDP (Delivered Duty Paid), DAP (Delivered At Place), FCA (Free Carrier).. Valid values are `FOB|CIF|EXW|DDP|DAP|FCA`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was last updated. Tracks changes to status, amounts, dates, or other fields throughout the PO lifecycle.',
    `notes` STRING COMMENT 'Free-form text field for special instructions, handling requirements, or additional context for the vendor or receiving team. May include delivery window constraints, quality specifications, or packaging requirements.',
    `order_date` DATE COMMENT 'Date when the purchase order was created and issued to the vendor. Principal business event timestamp for procurement cycle measurement.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms with the vendor, expressed as discount/days or net days (e.g., 2/10_net_30 means 2% discount if paid within 10 days, otherwise net due in 30 days; net_30 means payment due in 30 days with no discount).. Valid values are `^(net_[0-9]{1,3}|[0-9]{1,2}/[0-9]{1,3}_net_[0-9]{1,3})$`',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order, typically formatted as PO followed by numeric sequence. Used for vendor communication and three-way match with goods receipt and invoice.. Valid values are `^PO[0-9]{8,12}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order. Tracks progression from draft through approval, vendor confirmation, shipment, receipt, and closure. Supports three-way match validation and exception management. [ENUM-REF-CANDIDATE: draft|submitted|approved|confirmed|in_transit|partially_received|fully_received|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order based on fulfillment method and business purpose. Standard for regular DC delivery, DSD (Direct Store Delivery) for vendor-direct shipments, cross-dock for immediate transfer without storage, promotional for ad-driven buys, emergency for urgent replenishment, blanket for long-term agreements with release schedules.. Valid values are `standard|dsd|cross_dock|promotional|emergency|blanket`',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this purchase order is associated with a promotional event or ad circular, requiring special handling, display, and timing coordination.',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods to the ship-to location. Used for replenishment planning and vendor performance measurement.',
    `rfid_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether this purchase order shipment will be tracked using RFID tags for real-time visibility and automated receiving at DC or store.',
    `shipping_method` STRING COMMENT 'Primary mode of transportation for delivery of goods from vendor to ship-to location. Impacts lead time and freight cost.. Valid values are `truck|rail|intermodal|air|parcel|vendor_fleet`',
    `slotting_fee_amount` DECIMAL(18,2) COMMENT 'One-time or recurring fee charged to vendor for shelf space allocation, particularly for new item introductions. Revenue offset against procurement cost.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order, calculated based on ship-to location tax jurisdiction and product tax categories.',
    `temperature_range_max` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Fahrenheit for cold chain shipments. Null if cold_chain_required_flag is false.',
    `temperature_range_min` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Fahrenheit for cold chain shipments. Null if cold_chain_required_flag is false.',
    `total_order_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, before taxes and freight charges. Sum of (ordered_quantity × unit_cost) across all lines.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Grand total value of the purchase order including line items, taxes, and freight. Used for budget tracking and three-way match validation.',
    `vendor_acknowledgment_received_flag` BOOLEAN COMMENT 'Indicates whether the vendor has acknowledged receipt and acceptance of the purchase order via EDI 855 or other communication method.',
    `vendor_acknowledgment_timestamp` TIMESTAMP COMMENT 'Timestamp when vendor acknowledgment was received. Used to measure vendor responsiveness and confirm order acceptance.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Master record for all purchase orders issued to vendors, encompassing both header-level details (vendor, buyer, order type, delivery window, ship-to location, payment terms, lifecycle status) and line-level detail (SKU, ordered quantity, unit cost, pack size, allowances, line status, confirmed ship date). Supports regular, DSD, cross-dock, and promotional PO types. Enables three-way match with goods receipt and vendor invoice. Sourced from SAP MM and Oracle Retail Merchandising System.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the po_line product.',
    `category_id` BIGINT COMMENT 'Foreign key reference to the merchandise category or commodity group for this item. Used for spend analysis and category management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PO lines are charged to specific cost centers for departmental cost allocation and AP matching. cost_center_code is a denormalized string on po_line; replacing it with a proper FK supports line-level ',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: PO line cost validation: buyers must verify that the unit_cost on each PO line matches the approved cost_price record for that SKU/supplier. This three-way match and cost variance reporting process ',
    `cost_schedule_id` BIGINT COMMENT 'Foreign key linking to vendor.cost_schedule. Business justification: Each PO lines unit_cost must be traceable to the active cost schedule for that vendor item. Grocery buyers use this link during invoice matching and cost change audits to detect pricing discrepancies',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: PO lines are received into specific store departments (produce, deli, pharmacy). Department-level receiving, shrink reporting, and department P&L require this link. The denormalized cost_center_code p',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: DEA Form 222 controlled substance ordering and DSCSA traceability require PO lines for pharmaceutical products to reference the drug entity (NDC, DEA schedule). Grocery pharmacy buyers need drug_id on',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: PO line accruals (uninvoiced received goods) must be period-stamped for received-not-invoiced (RNI) accrual reporting at period close. Retail-grocery finance teams require line-level period assignment',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Individual PO lines post to different GL accounts (produce COGS vs. pharmacy vs. fuel). Line-level GL coding is required for AP 3-way match and cost allocation. gl_account_code is a denormalized strin',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the SKU being ordered on this line. Links to the product master for item details.',
    `store_location_id` BIGINT COMMENT 'Foreign key reference to the distribution center, store, or facility where this line will be received.',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the supplier providing this item. Denormalized from header for line-level vendor analysis.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: PO line unit costs and allowances are governed by trade agreements. Grocery AP teams validate each lines unit_cost against the active trade agreement during invoice matching. This line-level link ena',
    `vendor_funding_id` BIGINT COMMENT 'Foreign key linking to promotion.vendor_funding. Business justification: PO line unit costs reflect vendor-funded allowances — AP teams reconcile the allowance_amount and allowance_type on each PO line against the governing vendor funding agreement. This link drives trade ',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: PO line must reference the exact vendor catalog item for pricing, compliance, and traceability; experts expect a vendor_item_id FK.',
    `allowance_amount` DECIMAL(18,2) COMMENT 'Total promotional allowances, rebates, or discounts applied to this line. Reduces net cost to retailer.',
    `allowance_type` STRING COMMENT 'Category of allowance applied to this line. Determines accounting treatment and vendor settlement process.. Valid values are `off_invoice|scan_based|volume_rebate|promotional|slotting|markdown`',
    `case_pack_quantity` STRING COMMENT 'Number of individual units (eaches) contained in one case. Used for converting between case and each quantities.',
    `confirmed_delivery_date` DATE COMMENT 'Vendor-confirmed date when this line item will be delivered to the destination. Used for receiving dock scheduling.',
    `confirmed_ship_date` DATE COMMENT 'Vendor-confirmed date when this line item will ship. Received via EDI 855 PO acknowledgment or vendor portal.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line was originally created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Logistics method for delivering this line. Warehouse=DC receiving, DSD=Direct Store Delivery, Cross-Dock=no storage, Drop-Ship=vendor to customer.. Valid values are `warehouse|dsd|cross_dock|drop_ship`',
    `extended_cost` DECIMAL(18,2) COMMENT 'Total line cost calculated as ordered quantity multiplied by unit cost. Base amount before allowances and freight.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight or transportation charges allocated to this line item. May be actual or estimated based on shipment method.',
    `gtin` STRING COMMENT 'GS1 standard global trade item number for the product. May be GTIN-8, GTIN-12 (UPC), GTIN-13 (EAN), or GTIN-14 format.. Valid values are `^d{8}$|^d{12}$|^d{13}$|^d{14}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this item is classified as hazardous material requiring special handling, labeling, and transportation compliance.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity invoiced by the vendor for this line. Used for three-way match reconciliation (PO, receipt, invoice).',
    `item_description` STRING COMMENT 'Textual description of the item being ordered. Captured at time of PO creation for reference and receiving verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line was last updated. Tracks most recent change for audit and reconciliation purposes.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Used for ordering and referencing specific line items on the PO document.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line. Tracks progression from creation through receiving and closure.. Valid values are `open|confirmed|partially_received|fully_received|cancelled|closed`',
    `notes` STRING COMMENT 'Free-text notes or special instructions for this line item. May include receiving instructions, quality requirements, or vendor communications.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item ordered on this line. Expressed in the unit of measure specified.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this item is USDA organic certified. Used for merchandising, labeling, and regulatory compliance.',
    `pack_size` STRING COMMENT 'Consumer-facing pack size description (e.g., 12 oz, 1 gallon, 500g). Used for merchandising and shelf labeling.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this item is a store-owned private label brand versus a national brand CPG product.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity received to date for this line. Updated as goods receipts are posted in the WMS.',
    `requested_delivery_date` DATE COMMENT 'Date by which the retailer requests delivery of this line item. Used for supply planning and vendor scheduling.',
    `srp` DECIMAL(18,2) COMMENT 'Vendors suggested retail price for the item. Used as a reference for pricing decisions and margin analysis.',
    `tax_code` STRING COMMENT 'Tax jurisdiction or rate code applicable to this line item. Used for sales tax calculation and compliance reporting.',
    `temperature_zone` STRING COMMENT 'Required temperature control zone for this item during transportation and storage. Critical for cold chain compliance.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Agreed cost per unit of measure from the vendor. Used for invoice matching and COGS calculation. Excludes allowances and discounts.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the ordered quantity. EA=Each, CS=Case, PL=Pallet, LB=Pound, KG=Kilogram, GAL=Gallon, LTR=Liter, DZ=Dozen, BX=Box. [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|GAL|LTR|DZ|BX — 9 candidates stripped; promote to reference product]',
    `upc` STRING COMMENT '12-digit UPC barcode identifier for the item. Used for scanning at receiving and point-of-sale.. Valid values are `^d{12}$`',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Line-item detail for each SKU/item on a purchase order. Captures ordered quantity, unit of measure, agreed cost per unit, SRP, GTIN/UPC, item description, pack size, case pack quantity, allowances, line status, and confirmed ship date. Each line maps to a single SKU and is the atomic unit for receiving reconciliation and invoice matching in SAP MM.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`inbound_shipment` (
    `inbound_shipment_id` BIGINT COMMENT 'Unique identifier for the inbound shipment record. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for delivering this shipment.',
    `wave_id` BIGINT COMMENT 'Foreign key linking to fulfillment.wave. Business justification: Cross-dock wave assignment: inbound shipments with cross_dock_flag=true are assigned to outbound pick waves without putaway. Grocery DC cross-dock operations require this link for wave scheduling, doc',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the destination location (DC or store) where the shipment is to be received.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Inbound shipments trigger inventory receipt accruals. Period-close RNI (received-not-invoiced) accrual reporting requires shipments to be period-stamped. Retail-grocery finance teams use this to accru',
    `new_item_intro_id` BIGINT COMMENT 'Foreign key linking to assortment.new_item_intro. Business justification: New item first receipt tracking: grocery retailers track the first inbound shipment against the new_item_intro record to confirm first_receipt_date and validate launch readiness. Category managers and',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that authorized this shipment from the vendor.',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: Inbound receiving SLA compliance: grocery DC operations enforce receiving window SLAs governing dock scheduling, labor allocation, and supplier on-time delivery measurement. Linking inbound_shipment t',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier_contract. Business justification: Inbound shipments are governed by supply-chain supplier contracts that specify fill rate SLAs, EDI requirements, temperature compliance standards, and freight terms. Linking inbound_shipment to supply',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier originating this shipment.',
    `supplier_site_id` BIGINT COMMENT 'Identifier of the origin location (vendor facility, supplier DC, or cross-dock) from which the shipment departed.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Inbound shipments are governed by trade agreements specifying freight terms, OTIF SLAs, and chargeback policies. Logistics and compliance teams reference this link when processing OTIF chargebacks for',
    `transport_route_id` BIGINT COMMENT 'Foreign key linking to supply.transport_route. Business justification: Inbound shipments travel along defined transport routes from vendor origin to DC. Linking inbound_shipment to transport_route enables route-level performance analysis (scheduled vs. actual arrival, te',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the shipment arrived at the destination dock and was checked in.',
    `actual_ship_date` DATE COMMENT 'Actual date the shipment departed from the origin location.',
    `asn_number` STRING COMMENT 'Vendor-provided advance ship notice number transmitted via EDI 856 to notify the DC or store of the pending shipment.. Valid values are `^[A-Z0-9]{8,20}$`',
    `bol_number` STRING COMMENT 'Carrier-issued bill of lading number serving as the legal document for the shipment.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inbound shipment record was first created in the system (typically when ASN was received).',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether this shipment is designated for cross-dock operations (transfer without storage).',
    `destination_type` STRING COMMENT 'Type of destination facility receiving the shipment: Distribution Center, Store, Cross-Dock, or Micro-Fulfillment Center.. Valid values are `DC|Store|Cross-Dock|MFC`',
    `discrepancy_notes` STRING COMMENT 'Free-text notes documenting any receiving discrepancies, damages, or quality issues identified during inspection.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost for this shipment in USD.',
    `freight_terms` STRING COMMENT 'Freight payment terms defining who pays for transportation: Prepaid (vendor pays), Collect (buyer pays), Third-Party, FOB-Origin, or FOB-Destination.. Valid values are `Prepaid|Collect|Third-Party|FOB-Origin|FOB-Destination`',
    `haccp_compliant_flag` BOOLEAN COMMENT 'Indicates whether the shipment met all HACCP food safety requirements during transit and receiving.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inbound shipment record was last modified.',
    `priority_level` STRING COMMENT 'Priority classification for receiving and putaway: Standard (normal flow), High (expedited), Urgent (same-day), Critical (immediate).. Valid values are `Standard|High|Urgent|Critical`',
    `receiving_complete_timestamp` TIMESTAMP COMMENT 'Timestamp when the receiving process was completed and all items were putaway or staged.',
    `receiving_discrepancy_flag` BOOLEAN COMMENT 'Indicates whether any discrepancies (quantity variance, damage, quality issues) were identified during receiving.',
    `receiving_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the receiving process began (unloading and inspection started).',
    `rfid_tracked_flag` BOOLEAN COMMENT 'Indicates whether this shipment was tracked using RFID technology for real-time visibility.',
    `scheduled_arrival_date` DATE COMMENT 'Planned date the shipment is scheduled to arrive at the destination location.',
    `scheduled_arrival_time` TIMESTAMP COMMENT 'Planned timestamp for the shipment arrival at the destination dock, used for dock scheduling and labor planning.',
    `scheduled_ship_date` DATE COMMENT 'Planned date the shipment was scheduled to depart from the origin location.',
    `seal_number` STRING COMMENT 'Security seal number applied to the trailer to ensure shipment integrity during transit.. Valid values are `^[A-Z0-9]{6,20}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the inbound shipment: Planned (ASN received), In-Transit (departed origin), Arrived (at destination dock), Receiving (being unloaded), Received (fully processed), or Cancelled.. Valid values are `Planned|In-Transit|Arrived|Receiving|Received|Cancelled`',
    `shipment_type` STRING COMMENT 'Classification of the shipment method: Standard warehouse delivery, Direct Store Delivery (DSD), Cross-Dock transfer, Emergency replenishment, or Inter-facility Transfer.. Valid values are `Standard|DSD|Cross-Dock|Emergency|Transfer`',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicates whether the shipment maintained required temperature throughout transit (True) or experienced temperature excursions (False).',
    `temperature_max_f` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Fahrenheit for temperature-controlled shipments to maintain product integrity.',
    `temperature_min_f` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Fahrenheit for temperature-controlled shipments to maintain product integrity.',
    `temperature_requirement` STRING COMMENT 'Cold chain temperature requirement for this shipment: Ambient (room temperature), Refrigerated (33-40°F), Frozen (0°F or below), or Controlled (specific range).. Valid values are `Ambient|Refrigerated|Frozen|Controlled`',
    `total_case_count` STRING COMMENT 'Total number of cases (cartons) included in this shipment across all line items.',
    `total_cube_ft` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic feet, used for capacity planning and freight optimization.',
    `total_pallet_count` STRING COMMENT 'Total number of pallets included in this shipment.',
    `total_unit_count` STRING COMMENT 'Total number of individual units (eaches) included in this shipment across all SKUs.',
    `total_weight_lbs` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in pounds, including packaging.',
    `trailer_number` STRING COMMENT 'Identifier of the trailer or container used to transport the shipment.. Valid values are `^[A-Z0-9]{4,15}$`',
    CONSTRAINT pk_inbound_shipment PRIMARY KEY(`inbound_shipment_id`)
) COMMENT 'Tracks vendor-initiated shipments (ASN — Advance Ship Notice) from origin to DC or store, encompassing both shipment-level details (carrier, BOL, trailer, origin, destination, scheduled/actual arrival, temperature requirement, status) and line-level detail (SKU, shipped quantity, lot number, expiration date, country of origin, HACCP compliance, pallet configuration). Integrates with JDA TMS and Manhattan Associates WMS for receiving reconciliation.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key.',
    `compliance_record_id` BIGINT COMMENT 'Foreign key linking to vendor.compliance_record. Business justification: At goods receipt, grocery DCs verify the suppliers active compliance record (HACCP, organic cert, FDA registration) before accepting product. This link supports regulatory audit trails, food safety g',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Goods receipt cost validation: receiving teams compare the invoiced cost at receipt against the approved cost_price record to detect discrepancies and trigger price change workflows. This is the cost ',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the distribution center (DC) or store where the goods were physically received.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Goods receipt posting date determines the fiscal period for inventory and COGS recognition. Period-close RNI accruals and GR/IR clearing depend on this link. Retail-grocery accountants require GR-to-p',
    `inbound_shipment_id` BIGINT COMMENT 'Reference to the inbound shipment or advanced ship notice (ASN) associated with this receipt.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: Goods receipts are recorded against specific PO lines to enable line-level receipt quantity tracking (ordered vs. received vs. rejected). While goods_receipt has purchase_order_id for header-level lin',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is recorded.',
    `slot_location_id` BIGINT COMMENT 'Foreign key linking to fulfillment.slot_location. Business justification: Putaway assignment at receiving: grocery DC operations require goods_receipt to record the slot_location where items are putaway for inventory accuracy, audit trails, and FIFO enforcement. Domain expe',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Goods receipt in grocery requires SKU-level identification for inventory accuracy, shrink tracking, HACCP compliance, and receiving discrepancy resolution. A DC receiving manager would expect goods_re',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Goods receipts occur at store level for DSD and direct deliveries (destination_type field confirms this). Store-level receiving reports, food safety compliance, and shrink tracking require a store_loc',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the goods were received.',
    `bill_of_lading_number` STRING COMMENT 'The bill of lading number provided by the carrier, serving as the shipping document and receipt for the goods in transit.. Valid values are `^[A-Z0-9]{8,25}$`',
    `carrier_name` STRING COMMENT 'Name of the transportation carrier or logistics provider that delivered the shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was first created in the system.',
    `cross_dock_flag` BOOLEAN COMMENT 'Indicates whether this receipt is part of a cross-dock operation where goods are transferred directly from inbound to outbound without storage (True) or follows standard receiving and putaway (False).',
    `dock_door_number` STRING COMMENT 'The physical dock door or receiving bay where the shipment was unloaded.. Valid values are `^[A-Z0-9]{1,10}$`',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this receipt is a direct store delivery from a vendor bypassing the distribution center (True) or a standard DC receipt (False).',
    `gr_document_number` STRING COMMENT 'The externally-known goods receipt document number generated by the ERP or WMS system (e.g., SAP MIGO document number).. Valid values are `^[A-Z0-9]{10,20}$`',
    `inspection_completed_flag` BOOLEAN COMMENT 'Indicates whether the required quality inspection has been completed (True) or is still pending (False).',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt requires formal quality inspection before acceptance into inventory (True) or can be received without inspection (False).',
    `inspection_result` STRING COMMENT 'The outcome of the quality inspection: PASSED (all items accepted), FAILED (all items rejected), PARTIAL (some accepted, some rejected), PENDING (inspection not yet complete), NOT_REQUIRED (no inspection needed).. Valid values are `PASSED|FAILED|PARTIAL|PENDING|NOT_REQUIRED`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was last modified or updated in the system.',
    `osd_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt contains any overage, shortage, or damage discrepancies (True) or was received as expected (False).',
    `osd_notes` STRING COMMENT 'Free-text notes describing the nature and details of any overage, shortage, or damage issues identified during receipt.',
    `osd_type` STRING COMMENT 'Classification of the OS&D discrepancy: OVERAGE (more received than ordered), SHORTAGE (less received than ordered), DAMAGE (damaged goods), MULTIPLE (combination of issues), NONE (no discrepancy).. Valid values are `OVERAGE|SHORTAGE|DAMAGE|MULTIPLE|NONE`',
    `packing_slip_number` STRING COMMENT 'The packing slip or delivery note number provided by the vendor, listing the contents of the shipment.. Valid values are `^[A-Z0-9]{6,20}$`',
    `posting_date` DATE COMMENT 'The accounting date on which the goods receipt was posted to inventory and financial ledgers.',
    `putaway_status` STRING COMMENT 'Current status of the putaway process for moving received goods from the receiving area to storage locations: NOT_STARTED, IN_PROGRESS, COMPLETED, BLOCKED.. Valid values are `NOT_STARTED|IN_PROGRESS|COMPLETED|BLOCKED`',
    `receipt_date` DATE COMMENT 'The calendar date on which the goods were physically received at the location.',
    `receipt_notes` STRING COMMENT 'Free-text notes or comments recorded by the receiving personnel regarding any special conditions, observations, or issues during the receipt process.',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the goods receipt: DRAFT (not yet started), IN_PROGRESS (receiving in process), COMPLETED (physically received but not posted), POSTED (posted to inventory), CANCELLED (receipt cancelled).. Valid values are `DRAFT|IN_PROGRESS|COMPLETED|POSTED|CANCELLED`',
    `receipt_timestamp` TIMESTAMP COMMENT 'The precise date and time when the goods receipt transaction was initiated or completed.',
    `receipt_type` STRING COMMENT 'Classification of the receipt transaction: PO (purchase order receipt), DSD (direct store delivery), RETURN (vendor return), TRANSFER (inter-location transfer), CROSS_DOCK (cross-dock operation), SAMPLE (vendor sample).. Valid values are `PO|DSD|RETURN|TRANSFER|CROSS_DOCK|SAMPLE`',
    `rfid_scanned_flag` BOOLEAN COMMENT 'Indicates whether RFID tags were scanned during the receipt process for automated item tracking (True) or manual receipt was performed (False).',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the security seal was found intact upon receipt (True) or broken/missing (False).',
    `seal_number` STRING COMMENT 'The security seal number affixed to the trailer or container, verified at receipt to ensure shipment integrity.. Valid values are `^[A-Z0-9]{6,20}$`',
    `source_system` STRING COMMENT 'The operational system of record that originated this goods receipt transaction: SAP_MM (SAP Materials Management), MANHATTAN_WMS (Manhattan Associates WMS), ORACLE_RETAIL (Oracle Retail), MANUAL (manual entry).. Valid values are `SAP_MM|MANHATTAN_WMS|ORACLE_RETAIL|MANUAL`',
    `temperature_at_receipt` DECIMAL(18,2) COMMENT 'The measured temperature (in Celsius) of the shipment at the time of receipt, critical for cold chain compliance and perishable goods.',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicates whether the shipment temperature was within the acceptable range per cold chain requirements (True) or out of compliance (False).',
    `total_accepted_quantity` DECIMAL(18,2) COMMENT 'The aggregate quantity of all items accepted into inventory after quality inspection, summed across all line items.',
    `total_received_quantity` DECIMAL(18,2) COMMENT 'The aggregate quantity of all items physically received in this goods receipt transaction, summed across all line items.',
    `total_rejected_quantity` DECIMAL(18,2) COMMENT 'The aggregate quantity of all items rejected due to damage, quality issues, or discrepancies, summed across all line items.',
    `trailer_number` STRING COMMENT 'The trailer or container identification number used for the inbound shipment.. Valid values are `^[A-Z0-9]{4,15}$`',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of merchandise at a DC or store against a purchase order or inbound shipment, encompassing both receipt-level details (date/time, dock door, receiver, temperature, GR document number) and item-level detail (received/accepted/rejected quantities by SKU, rejection reason, lot number, expiration date, putaway assignment). Captures OS&D (overage/shortage/damage) at both aggregate and item level. Sourced from SAP MM MIGO and Manhattan Associates WMS.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order. Primary key for internal DC-to-store or DC-to-DC transfer orders generated by Blue Yonder CAO/demand planning or manually by buyers.',
    `allocation_plan_id` BIGINT COMMENT 'Foreign key linking to supply.allocation_plan. Business justification: In constrained supply scenarios, replenishment orders are generated from Blue Yonder Allocation Optimization plans. Linking replenishment_order to allocation_plan creates the execution traceability fr',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier assigned to deliver the order. May be internal fleet or third-party carrier.',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Inventory valuation at replenishment: replenishment orders move goods from DC to store at a specific cost basis. Linking to cost_price supports inventory valuation reporting and ensures the cost bas',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supply.dc_facility. Business justification: Replenishment orders originate from a DC facility (the source node for DC-to-store replenishment). While destination_location_store_location_id captures the store destination, there is no FK capturing',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to supply.demand_forecast. Business justification: Replenishment orders are generated by Blue Yonder CAO/demand planning from demand forecasts. Linking replenishment_order to the driving demand_forecast creates end-to-end planning traceability — enabl',
    `store_location_id` BIGINT COMMENT 'Identifier of the store or DC receiving the replenishment inventory. Can be a retail store, MFC, or downstream DC.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Replenishment orders drive inventory movement costs (freight, handling) that must be period-stamped for inventory accounting and inter-location cost allocation. Retail-grocery finance teams require pe',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: REQUIRED: Replenishment execution assigns a fulfillment node (DC) for picking/shipping; node performance reports depend on this link.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: Pharmacy inventory replenishment orders require linking to the pharmacy location for stock planning, fill‑rate analysis, and regulatory audit.',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: Planogram-driven replenishment: seasonal and reset planograms in grocery generate replenishment orders to stock new SKUs and remove discontinued ones. Supply planners reference the planogram to determ',
    `primary_replenishment_store_location_id` BIGINT COMMENT 'Identifier of the distribution center or warehouse from which inventory is being transferred. Typically a DC in the supply chain network.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Needed for Promotional Replenishment Planning process that creates replenishment orders based on active promo campaigns.',
    `reward_offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.reward_offer. Business justification: Loyalty-offer-driven replenishment: active reward offers (bonus points, fuel rewards on specific SKUs) cause demand spikes requiring dedicated replenishment orders. Grocery supply planners link replen',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Replenishment orders in grocery retail are generated at SKU level to drive reorder point calculations, safety stock management, and fill rate reporting. A retail-grocery supply planner would expect re',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: Store replenishment SLA compliance: grocery retailers enforce delivery window SLAs for store replenishment (overnight windows, fill rate minimums). Linking replenishment_order to sla_policy enables fo',
    `transport_route_id` BIGINT COMMENT 'Identifier of the transportation route assigned for delivery. Used for multi-stop route optimization and last-mile delivery planning.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the order was received at the destination location. Used to measure delivery SLA performance and calculate fill rate timing.',
    `actual_ship_date` DATE COMMENT 'Actual date when the order was shipped from the source DC. Used to measure on-time shipment performance and calculate actual transit time.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the order requires management approval before fulfillment. True for high-value orders, emergency orders, or orders exceeding allocation thresholds.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order was approved. Used for approval cycle time analysis and compliance tracking.',
    `cancellation_reason` STRING COMMENT 'Reason code for order cancellation. Populated only when order_status is cancelled. Used for root cause analysis and process improvement.. Valid values are `inventory_unavailable|destination_closed|duplicate_order|demand_change|system_error|other`',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether the order contains perishable items requiring temperature-controlled transportation and storage. True if any line item requires refrigeration or freezing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order record was first created in the system. Used for audit trail and order age analysis.',
    `cross_dock_eligible_flag` BOOLEAN COMMENT 'Indicates whether the order is eligible for cross-dock operations, where inventory is transferred directly from inbound to outbound without intermediate storage. Used for flow-through optimization.',
    `destination_type` STRING COMMENT 'Classification of the destination location. Store represents retail locations, DC represents distribution centers, MFC represents micro-fulfillment centers for omnichannel orders.. Valid values are `store|dc|mfc`',
    `fill_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of ordered quantity that was successfully shipped, calculated as (total_shipped_quantity / total_ordered_quantity) * 100. Key supply chain KPI for measuring DC fulfillment performance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the replenishment order record was last updated. Used for change tracking and data freshness validation.',
    `notes` STRING COMMENT 'Free-text field for additional comments, exceptions, or context about the replenishment order. Used for communication between buyers, planners, and fulfillment teams.',
    `order_date` DATE COMMENT 'Date when the replenishment order was created in the system. Represents the business event timestamp for order initiation.',
    `order_number` STRING COMMENT 'Human-readable business identifier for the replenishment order, used for tracking and communication across supply chain systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the replenishment order in the fulfillment workflow. Tracks progression from creation through delivery and enables exception management. [ENUM-REF-CANDIDATE: draft|submitted|approved|allocated|picking|packed|shipped|in_transit|received|cancelled — 10 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the replenishment order based on trigger and business purpose. Auto-replenishment orders are system-generated based on CAO algorithms, manual orders are buyer-initiated, emergency orders address stockouts, seasonal orders support seasonal demand, promotional orders support ad circulars, and new store orders support store openings.. Valid values are `auto_replenishment|manual|emergency|seasonal|promotional|new_store`',
    `priority_level` STRING COMMENT 'Priority classification for order fulfillment and transportation routing. Critical priority is used for emergency stockout situations, high priority for fast-moving SKUs, normal for standard replenishment, low for slow-moving items.. Valid values are `critical|high|normal|low`',
    `replenishment_trigger` STRING COMMENT 'The business rule or algorithm that initiated the replenishment order. CAO forecast uses demand planning algorithms, min-max threshold triggers when inventory falls below reorder point, safety stock maintains buffer inventory, manual override is buyer-initiated, promotional event supports ad circulars, seasonal demand addresses seasonal patterns.. Valid values are `cao_forecast|min_max_threshold|safety_stock|manual_override|promotional_event|seasonal_demand`',
    `requested_delivery_date` DATE COMMENT 'Target date by which the destination location requires the replenishment inventory to arrive. Used for transportation planning and SLA tracking.',
    `rfid_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether the order is tracked using RFID technology for real-time visibility and automated receiving. True if RFID tags are applied at case or pallet level.',
    `scheduled_ship_date` DATE COMMENT 'Planned date for the order to be shipped from the source DC. Calculated based on requested delivery date and transit time.',
    `special_handling_instructions` STRING COMMENT 'Free-text field for special handling requirements such as fragile items, hazardous materials, or delivery time windows. Communicated to warehouse and transportation teams.',
    `temperature_zone` STRING COMMENT 'Required temperature control classification for the order. Ambient for shelf-stable products, refrigerated for fresh produce and dairy, frozen for frozen foods, multi-temp for mixed orders requiring multiple temperature zones.. Valid values are `ambient|refrigerated|frozen|multi_temp`',
    `total_cube_volume` DECIMAL(18,2) COMMENT 'Total cubic volume of the order in cubic feet or cubic meters. Used for trailer utilization optimization and cross-dock planning.',
    `total_line_count` STRING COMMENT 'Number of distinct SKU line items included in the replenishment order. Used for picking complexity assessment and labor planning.',
    `total_ordered_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all line items in the replenishment order, measured in eaches or cases depending on line-level unit of measure. Used for capacity planning and transportation optimization.',
    `total_pallet_count` STRING COMMENT 'Number of pallets required to ship the order. Used for transportation capacity planning and dock scheduling.',
    `total_received_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all line items received at the destination location. May differ from shipped quantity due to damage, loss, or receiving discrepancies.',
    `total_shipped_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all line items actually shipped from the source DC. May differ from ordered quantity due to inventory availability or allocation adjustments.',
    `total_weight` DECIMAL(18,2) COMMENT 'Total weight of the order in pounds or kilograms. Used for transportation cost calculation and carrier selection.',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Store or DC replenishment orders generated by Blue Yonder CAO/demand planning or manually by buyers, encompassing both order-level details (type, source, destination, trigger, status) and line-level detail (SKU, ordered quantity, suggested vs. override quantity, fill rate, line status). Covers auto-replenishment, manual, and emergency order types. Distinct from purchase orders — these are internal DC-to-store transfer orders.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`dc_transfer` (
    `dc_transfer_id` BIGINT COMMENT 'Unique identifier for the distribution center transfer transaction. Primary key for the dc_transfer product.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for moving the shipment between origin and destination.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DC transfers incur freight costs (freight_cost_usd) allocated to cost centers for internal logistics cost accounting. Retail-grocery finance teams track inter-DC and DC-to-store transfer costs against',
    `delivery_route_id` BIGINT COMMENT 'Foreign key linking to fulfillment.delivery_route. Business justification: REQUIRED: DC transfer is scheduled as a delivery route; route KPI dashboards need the transfer‑to‑route association.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: DC transfer costs and inventory movements must be period-stamped for inter-location cost allocation and inventory accounting by fiscal period. Retail-grocery finance teams require this for period-end ',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supply.dc_facility. Business justification: dc_transfer records inter-DC and DC-to-store movements. The existing origin_location_id -> store.store_location covers store origins, but for DC-to-DC transfers the origin is a dc_facility. Adding ori',
    `store_location_id` BIGINT COMMENT 'Identifier of the source facility from which inventory is being transferred. Can reference a distribution center or store location.',
    `primary_dc_store_location_id` BIGINT COMMENT 'Identifier of the target facility to which inventory is being transferred. Can reference a distribution center or store location.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: dc_transfer already has a purchase_order_number STRING column, indicating a business relationship to purchase orders (cross-dock flow-through scenarios). Normalizing this to a proper FK purchase_order',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.replenishment_order. Business justification: DC transfers are the physical execution of replenishment orders. Linking dc_transfer to replenishment_order creates the plan-to-execution traceability essential for fill rate measurement, on-time deli',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: DC transfer SLA compliance: inter-DC and DC-to-store transfers are governed by delivery window SLAs in grocery operations. This link enables formal tracking of on_time_delivery_flag against policy thr',
    `transfer_order_id` BIGINT COMMENT 'Foreign key linking to inventory.transfer_order. Business justification: dc_transfer (supply-side movement execution) fulfills an inventory-side transfer_order authorization. Logistics teams reconcile dc_transfer execution against transfer_order approvals for quantity vari',
    `transport_route_id` BIGINT COMMENT 'Foreign key linking to supply.transport_route. Business justification: DC transfers execute along defined transport routes (DC-to-store and inter-DC routes). Linking dc_transfer to transport_route enables route performance analysis (on-time delivery, actual vs. estimated',
    `wave_id` BIGINT COMMENT 'Identifier of the warehouse picking wave that generated this transfer. Used to group transfers for efficient picking and loading operations.',
    `actual_delivery_date` DATE COMMENT 'Actual arrival date at the destination location when the shipment was received. Null until delivery occurs.',
    `actual_ship_date` DATE COMMENT 'Actual departure date from the origin location when the shipment left the facility. Null until shipment departs.',
    `actual_transit_hours` STRING COMMENT 'Actual duration in hours from departure to arrival. Used for carrier performance analysis and transit time optimization. Null until delivery complete.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'System timestamp when the transfer was confirmed as received and put away at the destination location. Marks completion of the transfer lifecycle. Null until confirmation occurs.',
    `contains_hazmat` BOOLEAN COMMENT 'Indicator whether the transfer shipment contains hazardous materials requiring special handling, documentation, and carrier certification per DOT regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the transfer record was first created in the warehouse management system. Used for audit trail and data lineage.',
    `damage_reported_flag` BOOLEAN COMMENT 'Indicator whether product damage was reported during receiving inspection. Triggers claims process and carrier performance review.',
    `destination_location_type` STRING COMMENT 'Classification of the destination facility. DC is distribution center, store is retail location, MFC is micro-fulfillment center, cross-dock is flow-through facility.. Valid values are `dc|store|mfc|cross-dock`',
    `estimated_transit_hours` STRING COMMENT 'Planned duration in hours for the shipment to travel from origin to destination. Used for delivery date calculation and carrier performance measurement.',
    `freight_cost_usd` DECIMAL(18,2) COMMENT 'Total transportation cost for the transfer shipment in US dollars. Includes carrier charges, fuel surcharges, and accessorial fees. Used for supply chain cost allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the transfer record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form text field for additional transfer instructions, special handling requirements, or operational comments. Used for communication between origin, carrier, and destination.',
    `on_time_delivery_flag` BOOLEAN COMMENT 'Indicator whether the transfer was delivered by the scheduled delivery date. Used for carrier scorecard and supply chain performance metrics.',
    `origin_location_type` STRING COMMENT 'Classification of the origin facility. DC is distribution center, store is retail location, MFC is micro-fulfillment center, cross-dock is flow-through facility.. Valid values are `dc|store|mfc|cross-dock`',
    `priority_level` STRING COMMENT 'Urgency classification for the transfer affecting processing sequence and transportation mode selection. Standard is normal flow, expedited is accelerated, urgent is same-day target, critical is immediate action required.. Valid values are `standard|expedited|urgent|critical`',
    `rfid_enabled` BOOLEAN COMMENT 'Indicator whether the transfer shipment uses RFID tags for automated tracking and receiving. Enables real-time visibility and reduces manual scanning.',
    `scheduled_delivery_date` DATE COMMENT 'Planned arrival date at the destination location. Used for receiving planning and labor scheduling.',
    `scheduled_ship_date` DATE COMMENT 'Planned departure date from the origin location. Used for transportation planning and carrier scheduling.',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the trailer to ensure shipment integrity during transit. Verified at receiving to detect tampering.. Valid values are `^[A-Z0-9]{6,15}$`',
    `shortage_reported_flag` BOOLEAN COMMENT 'Indicator whether quantity shortages were identified during receiving verification. Triggers inventory reconciliation and carrier investigation.',
    `temperature_zone` STRING COMMENT 'Cold chain requirement for the transfer shipment. Ambient is room temperature, refrigerated is 32-40F, frozen is below 0F, multi-temp contains mixed zones. Critical for perishable inventory compliance.. Valid values are `ambient|refrigerated|frozen|multi-temp`',
    `total_cases` STRING COMMENT 'Total number of cases or cartons included in the transfer shipment. Used for detailed inventory tracking and receiving verification.',
    `total_cube_cf` DECIMAL(18,2) COMMENT 'Total volume of the transfer shipment in cubic feet. Used for trailer utilization optimization and space planning.',
    `total_pallets` STRING COMMENT 'Total number of pallets included in the transfer shipment. Used for capacity planning and receiving resource allocation.',
    `total_units` STRING COMMENT 'Total number of individual units or eaches included in the transfer shipment. Represents the most granular inventory count.',
    `total_weight_lbs` DECIMAL(18,2) COMMENT 'Total weight of the transfer shipment in pounds. Used for freight costing, carrier capacity planning, and compliance with weight restrictions.',
    `trailer_number` STRING COMMENT 'Unique identifier of the trailer or container used for the transfer shipment. Used for tracking and yard management.. Valid values are `^[A-Z0-9]{4,12}$`',
    `transfer_date` DATE COMMENT 'The business date when the transfer transaction was initiated or scheduled. This is the principal event date for the transfer, distinct from audit timestamps.',
    `transfer_number` STRING COMMENT 'Externally-known business identifier for the transfer transaction, used for tracking and reference across systems and with carriers.. Valid values are `^TRF-[0-9]{10}$`',
    `transfer_reason` STRING COMMENT 'Business justification for the transfer. Allocation is planned distribution, rebalancing is inventory optimization, emergency is urgent replenishment, recall is product withdrawal, seasonal is assortment change, promotion is event-driven, new-store is initial stocking. [ENUM-REF-CANDIDATE: allocation|rebalancing|emergency|recall|seasonal|promotion|new-store — 7 candidates stripped; promote to reference product]',
    `transfer_status` STRING COMMENT 'Current lifecycle state of the transfer transaction. Planned indicates scheduled but not started, picking indicates warehouse fulfillment in progress, loaded indicates staged on carrier, in-transit indicates shipment en route, delivered indicates arrival at destination, confirmed indicates receiving complete, cancelled indicates transaction voided. [ENUM-REF-CANDIDATE: planned|picking|loaded|in-transit|delivered|confirmed|cancelled — 7 candidates stripped; promote to reference product]',
    `transfer_type` STRING COMMENT 'Classification of the transfer operation indicating the movement pattern and handling requirements. Cross-dock indicates flow-through without storage, pick-and-ship is standard DC fulfillment, store-to-store is lateral rebalancing, dc-to-dc is network redistribution, emergency is expedited replenishment, recall is product withdrawal.. Valid values are `cross-dock|pick-and-ship|store-to-store|dc-to-dc|emergency|recall`',
    CONSTRAINT pk_dc_transfer PRIMARY KEY(`dc_transfer_id`)
) COMMENT 'Records inter-DC and DC-to-store stock transfer movements including cross-dock flow-through and store-to-store rebalancing operations. Captures transfer type (cross-dock, pick-and-ship, store-to-store, DC-to-DC), origin location, destination location, transfer date, carrier, trailer number, total pallets, total cases, transfer reason (allocation, rebalancing, emergency, recall, seasonal), priority level, and transfer status (planned, picking, loaded, in-transit, delivered, confirmed). Managed in Manhattan Associates WMS and SAP WM. Enables inventory movement visibility and network optimization.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`direct_store_delivery` (
    `direct_store_delivery_id` BIGINT COMMENT 'Primary key for direct_store_delivery',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: DSD vendors invoice at store level, often without a PO. The DSD delivery record must link to its AP invoice for invoice reconciliation, payment processing, and vendor deduction management — a core ret',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: REQUIRED: DSD delivery performance dashboards aggregate metrics by category, so each delivery must reference its category.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DSD delivery costs (invoice_amount, discount_amount) are charged to store cost centers for departmental P&L reporting. Retail-grocery store-level cost accounting requires DSD costs to be allocated to ',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: DSD cost validation: DSD invoices carry invoice_amount that must be validated against the approved cost_price for that SKU/supplier. Grocery DSD operations require this link for DSD invoice reconcili',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: DSD deliveries must be period-stamped for COGS accrual and period-close inventory reporting. Retail-grocery finance teams accrue DSD costs by fiscal period; without this link, DSD deliveries cannot be',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: DSD invoices post to specific GL accounts (inventory, COGS, or expense) depending on product type. Retail-grocery AP teams require GL account assignment on DSD records for automated journal entry crea',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: DSD deliveries in grocery retail are typically backed by a purchase order for reconciliation and accounts payable matching. Adding purchase_order_id to direct_store_delivery creates the traceability l',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: DSD deliveries in grocery are SKU-specific — vendors deliver particular SKUs directly to stores. Invoice reconciliation, inventory receiving, and vendor compliance scorecards all require knowing which',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Every DSD event is tied to a specific store for receiving, inventory posting, and invoice reconciliation. Store-level DSD receiving reports, compliance audits, and accounts payable matching all requir',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier_contract. Business justification: DSD deliveries are governed by supply-chain supplier contracts that specify DSD terms, fill rate SLAs, payment terms, and quality inspection requirements. The supply_supplier_contract has a dsd_flag c',
    `supplier_id` BIGINT COMMENT 'Identifier for the vendor delivering merchandise directly to the store, bypassing the distribution center network. Common DSD vendors include bread, snack, and beverage suppliers.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: DSD deliveries originate from a specific supplier site. The originating site is required for HACCP traceability, FDA recall management, and route scheduling. Existing FK only covers inbound_shipment.s',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: DSD transactions are governed by trade agreements specifying DSD-specific pricing, payment terms, and allowances. AP teams reconcile DSD invoices against the applicable trade agreement. supply_supplie',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the DSD delivery was received at the store. Used for on-time delivery performance measurement and vendor compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DSD delivery record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the DSD delivery transaction. Supports multi-currency operations for international vendors.. Valid values are `^[A-Z]{3}$`',
    `delivery_number` STRING COMMENT 'Business identifier for the DSD delivery transaction, typically assigned by the vendor or receiving system. Used for tracking and reconciliation purposes.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the DSD delivery transaction. Tracks progression from scheduling through final reconciliation or dispute resolution.. Valid values are `scheduled|in_transit|delivered|reconciled|disputed|cancelled`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the DSD delivery invoice. Includes promotional allowances, volume discounts, and vendor rebates.',
    `discrepancy_description` STRING COMMENT 'Free-text description of any quantity or quality discrepancies identified during DSD delivery receipt. Used for vendor dispute resolution and claims processing.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was identified between the delivered quantity and the invoice quantity. Triggers dispute resolution workflow.',
    `driver_license_number` STRING COMMENT 'Drivers license number for the delivery driver. Captured for security verification and compliance with store access policies.',
    `driver_name` STRING COMMENT 'Full name of the delivery driver who executed the DSD delivery. Used for accountability, quality tracking, and security verification.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Total invoice amount for the DSD delivery before any adjustments or discounts. Represents the vendors billed amount for the merchandise delivered.',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with the DSD delivery. Used for accounts payable processing and financial reconciliation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the DSD delivery record was last updated. Used for audit trail and change tracking.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount due for the DSD delivery after applying taxes, discounts, and adjustments. Represents the final payment obligation to the vendor.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms for the DSD delivery, such as net 30, net 60, or 2/10 net 30. Defines the payment due date and any early payment discounts.',
    `pos_integration_flag` BOOLEAN COMMENT 'Indicates whether the DSD delivery has been integrated with the POS system for immediate inventory and cost updates. Critical for real-time inventory accuracy.',
    `pos_integration_timestamp` TIMESTAMP COMMENT 'Timestamp when the DSD delivery was integrated with the POS system. Used for inventory accuracy tracking and system reconciliation.',
    `quality_inspection_flag` BOOLEAN COMMENT 'Indicates whether the DSD delivery passed quality inspection at the time of receipt. Used for vendor performance tracking and product quality assurance.',
    `quality_issue_description` STRING COMMENT 'Free-text description of any quality issues identified during DSD delivery receipt. Includes details on damaged goods, expired products, or specification non-compliance.',
    `receiving_notes` STRING COMMENT 'Free-text notes captured by the receiving associate during DSD delivery receipt. Includes observations, special handling instructions, or operational comments.',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'Timestamp when the DSD delivery was fully reconciled between received quantities, invoice amounts, and POS integration. Marks completion of the DSD workflow.',
    `route_number` STRING COMMENT 'Vendor-assigned route identifier for the delivery drivers scheduled stops. Used for delivery sequencing and driver performance tracking.',
    `scheduled_delivery_date` DATE COMMENT 'Planned date for the DSD delivery to arrive at the store location. Used for store labor planning and receiving dock scheduling.',
    `scheduled_delivery_time` TIMESTAMP COMMENT 'Planned timestamp for the DSD delivery arrival, including time of day. Enables precise receiving dock coordination and labor allocation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the DSD delivery invoice. Used for sales tax reconciliation and financial reporting.',
    `temperature_compliance_flag` BOOLEAN COMMENT 'Indicates whether the DSD delivery met required temperature control standards for cold chain products. Critical for food safety compliance and quality assurance.',
    `temperature_reading` DECIMAL(18,2) COMMENT 'Actual temperature reading (in Fahrenheit) recorded at the time of DSD delivery receipt. Used for cold chain compliance verification and quality control.',
    `total_case_count` STRING COMMENT 'Total number of cases delivered in the DSD transaction. Used for receiving dock capacity planning and inventory volume tracking.',
    `total_sku_count` STRING COMMENT 'Total number of distinct SKUs included in the DSD delivery. Used for receiving complexity assessment and labor planning.',
    `total_unit_count` STRING COMMENT 'Total number of individual units (eaches) delivered across all SKUs in the DSD delivery. Used for detailed inventory tracking and shrink analysis.',
    `vendor_delivery_note_number` STRING COMMENT 'Vendor-provided delivery note or packing slip number accompanying the DSD delivery. Used for cross-reference and dispute resolution.',
    CONSTRAINT pk_direct_store_delivery PRIMARY KEY(`direct_store_delivery_id`)
) COMMENT 'Direct Store Delivery records for vendor-delivered merchandise bypassing the DC network. Captures DSD vendor, delivery date/time, store location, delivery route number, driver name, total SKUs, total cases, invoice number, payment method (check, EFT, credit), receiving associate, temperature compliance flag, product category (bread, snacks, beverages, dairy), and DSD status (scheduled, delivered, reconciled, disputed). Common for bread, snack, and beverage vendors. Integrates with POS for immediate inventory and cost update.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`transport_route` (
    `transport_route_id` BIGINT COMMENT 'Unique identifier for the transportation route. Primary key.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier or logistics provider responsible for executing this route. Links to vendor or carrier master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transport routes have fixed and variable costs (route_cost_fixed, route_cost_per_mile) that must be allocated to cost centers for freight cost management and carrier performance reporting. Retail-groc',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the distribution center or facility where the route originates. Links to the facility or warehouse master data.',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Route-to-node assignment: transport routes connect origin DCs to destination fulfillment nodes (stores, e-commerce DCs). Grocery supply chain planners use this link for route optimization, node capaci',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_location. Business justification: DEA requires tracking of transport routes used for controlled substance delivery to pharmacy locations. Cold chain drug delivery routes must be designated per pharmacy for compliance audits. Grocery p',
    `backhaul_enabled` BOOLEAN COMMENT 'Indicates whether this route includes backhaul operations, where the trailer picks up goods from vendors or stores on the return trip to the DC. True if backhaul is planned; false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was first created in the JDA TMS system. Used for audit trail and data lineage.',
    `cross_dock_eligible` BOOLEAN COMMENT 'Indicates whether this route supports cross-dock operations, where goods are transferred directly from inbound to outbound trailers without intermediate storage. True if cross-dock is allowed; false otherwise.',
    `effective_end_date` DATE COMMENT 'Date when this route configuration was or will be retired or replaced. Null for currently active routes. Used for route lifecycle management and historical tracking.',
    `effective_start_date` DATE COMMENT 'Date when this route configuration became or will become active. Used for route lifecycle management and historical tracking.',
    `estimated_transit_time_hours` DECIMAL(18,2) COMMENT 'Expected total time to complete the route including driving time, stop time, and rest breaks, measured in hours. Used for scheduling and on-time delivery tracking.',
    `fill_rate_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of trailer capacity utilization for this route, used for load optimization and efficiency tracking. Represents the percentage of orders fulfilled completely on each route execution.',
    `fuel_surcharge_rate` DECIMAL(18,2) COMMENT 'Fuel surcharge rate applied to this route, typically expressed as a percentage or per-mile amount. Adjusted periodically based on diesel fuel price indices.',
    `gps_tracking_enabled` BOOLEAN COMMENT 'Indicates whether GPS tracking is enabled for real-time location monitoring of the trailer or truck on this route. True if GPS devices are installed; false otherwise.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether this route is certified and equipped to transport hazardous materials. True if carrier and equipment meet DOT HAZMAT requirements; false otherwise.',
    `last_executed_date` DATE COMMENT 'Date when this route was most recently executed. Used for route utilization analysis and performance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was last updated in the JDA TMS system. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, instructions, or comments about the route. May include driver instructions, seasonal considerations, or operational alerts.',
    `on_time_delivery_target_pct` DECIMAL(18,2) COMMENT 'Target percentage for on-time delivery performance for this route, used for carrier performance evaluation and SLA compliance. Typically 95-98% for grocery retail.',
    `operating_days` STRING COMMENT 'Days of the week on which this route operates, typically stored as comma-separated day codes (e.g., MON,WED,FRI) or day-of-week flags.',
    `rfid_tracking_enabled` BOOLEAN COMMENT 'Indicates whether RFID technology is used to track shipments on this route. True if RFID tags are applied to pallets or cases for real-time visibility; false otherwise.',
    `route_cost_fixed` DECIMAL(18,2) COMMENT 'Fixed cost component for executing this route, independent of distance or load. Includes dispatch fees, administrative overhead, and minimum carrier charges.',
    `route_cost_per_mile` DECIMAL(18,2) COMMENT 'Standard cost per mile for this route, used for freight cost allocation and budgeting. Includes fuel, driver wages, maintenance, and carrier fees.',
    `route_frequency` STRING COMMENT 'Scheduled frequency at which this route is executed. Daily routes run every day; weekly routes run on specific days; bi-weekly routes run every two weeks; monthly routes run once per month; on-demand routes are triggered by need; seasonal routes operate during specific periods.. Valid values are `daily|weekly|bi_weekly|monthly|on_demand|seasonal`',
    `route_name` STRING COMMENT 'Human-readable name or description of the route, typically indicating origin and destination or geographic coverage.',
    `route_number` STRING COMMENT 'Business identifier for the route, used in operational communications and dispatch systems. Managed in JDA TMS.',
    `route_optimization_enabled` BOOLEAN COMMENT 'Indicates whether this route is subject to dynamic optimization algorithms in JDA TMS. True if stop sequence and timing can be adjusted by the system; false if route is fixed.',
    `route_status` STRING COMMENT 'Current lifecycle status of the route. Active routes are in regular operation; inactive routes are temporarily not in use; suspended routes are on hold pending review; planned routes are designed but not yet operational; archived routes are historical records.. Valid values are `active|inactive|suspended|planned|archived`',
    `route_type` STRING COMMENT 'Classification of the route based on its operational purpose. DC-to-store routes deliver from distribution center to retail locations; inter-DC routes transfer between distribution centers; DSD (Direct Store Delivery) routes bypass DC; cross-dock routes involve immediate transfer without storage; backhaul routes return empty trailers or pick up vendor goods; milk-run routes serve multiple stops in sequence.. Valid values are `dc_to_store|inter_dc|dsd|cross_dock|backhaul|milk_run`',
    `scheduled_departure_time` TIMESTAMP COMMENT 'Standard time of day when the route is scheduled to depart from the origin DC, stored as HH:MM format (e.g., 06:00 for 6 AM departure). Used for dispatch planning and driver scheduling.',
    `special_handling_requirements` STRING COMMENT 'Free-text description of any special handling, loading, or delivery requirements for this route (e.g., liftgate required, inside delivery, appointment required, security escort).',
    `stop_count` STRING COMMENT 'Total number of delivery or pickup stops on this route, excluding the origin DC. Used for route complexity assessment and driver workload planning.',
    `temperature_max_fahrenheit` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in Fahrenheit for temperature-controlled routes. Used for cold chain monitoring and compliance verification.',
    `temperature_min_fahrenheit` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in Fahrenheit for temperature-controlled routes. Used for cold chain monitoring and compliance verification.',
    `temperature_zone_required` STRING COMMENT 'Temperature control requirement for this route. Ambient for room temperature; refrigerated for 32-40°F; frozen for below 0°F; multi-temp for trailers with multiple zones; controlled for specific temperature ranges. Critical for cold chain compliance.. Valid values are `ambient|refrigerated|frozen|multi_temp|controlled`',
    `total_route_distance_miles` DECIMAL(18,2) COMMENT 'Total distance of the route from origin to final destination, including all intermediate stops, measured in miles. Used for freight cost calculation and driver scheduling.',
    `trailer_capacity_cases` STRING COMMENT 'Maximum number of cases that can be loaded on the trailer for this route, used when shipments are measured in case count rather than pallets.',
    `trailer_capacity_cubic_feet` DECIMAL(18,2) COMMENT 'Volumetric capacity of the trailer in cubic feet, used for cube optimization and load planning.',
    `trailer_capacity_pallets` STRING COMMENT 'Maximum number of standard pallets that can be loaded on the trailer for this route. Typically 26-28 pallets for a 53-foot trailer.',
    `trailer_capacity_weight_lbs` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the trailer in pounds, constrained by DOT regulations and vehicle specifications. Typically 40,000-45,000 lbs for a loaded trailer.',
    `trailer_type` STRING COMMENT 'Type of trailer equipment required for this route. Dry van for ambient goods; refrigerated for cold chain; flatbed for oversized items; tanker for liquids; intermodal for rail/truck combination; multi-temp for mixed temperature zones.. Valid values are `dry_van|refrigerated|flatbed|tanker|intermodal|multi_temp`',
    CONSTRAINT pk_transport_route PRIMARY KEY(`transport_route_id`)
) COMMENT 'Master record for DC-to-store and inter-DC transportation routes and their execution, encompassing route definition (origin DC, stop sequence, mileage, carrier, trailer type, capacity, frequency), individual stop details (stop location, arrival window, pallet/case count, special handling), and load plan execution (trailer assignment, departure time, load sequence, temperature zones, dispatch status). Managed in JDA TMS. Enables route optimization, freight cost allocation, and carrier performance tracking.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`vendor_lead_time` (
    `vendor_lead_time_id` BIGINT COMMENT 'Unique identifier for the vendor lead time record. Primary key for this operational planning parameter.',
    `carrier_id` BIGINT COMMENT 'Identifier of the primary carrier used for this vendor-item-destination lane. Links to carrier master for routing and performance tracking.',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Landed cost modeling: vendor lead time tiers (lead_time_tier, total_lead_time_days) directly affect freight and landed cost calculations stored in cost_price. Procurement analysts use this link in la',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supply.dc_facility. Business justification: Vendor lead times are by vendor-item-location combination where the destination location can be a DC facility. The existing store_location_id covers store destinations, but DC-destined lead times need',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: Pharmacy drug shortage management and formulary compliance require NDC-level lead time tracking distinct from general merchandise. FDA drug shortage reporting and 340B program management depend on dru',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: vendor_lead_time has a plain `sku` text column — a clear denormalization of the SKU entity. Lead times in grocery vary by SKU pack size and barcode variant. Normalizing to sku_id FK enables accurate l',
    `store_location_id` BIGINT COMMENT 'Identifier of the destination DC, store, or MFC receiving the shipment. Determines where the lead time applies.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier_contract. Business justification: Vendor lead time parameters are defined within supplier contracts (supply_supplier_contract has lead_time_days column confirming this). Linking vendor_lead_time to supply_supplier_contract establishes',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor supplying the item. Links to the vendor master in the vendor domain.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier_site. Business justification: Lead times in grocery supply chain are site-specific — a suppliers eastern DC has different lead times than its western facility. Linking vendor_lead_time to supplier_site enables site-level lead tim',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Lead time commitments are codified in trade agreements as SLA terms. Linking vendor_lead_time to trade_agreement enables compliance tracking against contractual lead time obligations and supports vend',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_item. Business justification: Lead times are item-specific at the vendor level — case pack size, order multiples, and shelf life on vendor_item directly affect replenishment lead time calculations. Linking vendor_lead_time to vend',
    `case_pack_size` STRING COMMENT 'Number of units per case pack from the vendor. Defines the vendor shipping unit for this item.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether temperature-controlled logistics are required for this vendor-item combination. True for perishable items requiring refrigeration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead time record was first created in the system. Establishes the origin point for this parameter configuration.',
    `cross_dock_eligible_flag` BOOLEAN COMMENT 'Indicates whether this vendor-item can bypass DC storage and be cross-docked directly to stores. True enables flow-through distribution.',
    `destination_type` STRING COMMENT 'Type of destination location for the shipment. DC = Distribution Center, MFC = Micro-Fulfillment Center.. Valid values are `dc|store|mfc`',
    `effective_date` DATE COMMENT 'Date when this lead time parameter becomes active. Start of the validity period for this lead time configuration.',
    `expiration_date` DATE COMMENT 'Date when this lead time parameter expires. End of the validity period. Null indicates no expiration.',
    `incoterm_code` STRING COMMENT 'Three-letter Incoterm code defining responsibility for shipping costs and risk transfer. Examples: FOB, CIF, DDP.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead time record was last modified. Used for change tracking and audit purposes.',
    `lead_time_status` STRING COMMENT 'Current operational status of this lead time parameter. Active = in use for replenishment calculations, Inactive = not currently used, Suspended = temporarily disabled, Under Review = being evaluated for changes.. Valid values are `active|inactive|suspended|under_review`',
    `lead_time_tier` STRING COMMENT 'Service level tier for the lead time. Standard = normal replenishment, Expedited = faster service, Emergency = urgent fulfillment, DSD = Direct Store Delivery bypass DC.. Valid values are `standard|expedited|emergency|dsd`',
    `lead_time_variability_days` DECIMAL(18,2) COMMENT 'Standard deviation of lead time in days. Measures consistency of vendor delivery performance. Used to calculate safety stock.',
    `minimum_order_quantity` STRING COMMENT 'Minimum number of units that must be ordered from the vendor for this item. Vendor-imposed constraint on order size.',
    `notes` STRING COMMENT 'Free-text field for additional comments or special instructions related to this vendor lead time configuration. Used for context that does not fit structured fields.',
    `order_multiple` STRING COMMENT 'Order quantity must be a multiple of this value. Ensures orders align with vendor case pack or pallet configurations.',
    `order_to_ship_days` DECIMAL(18,2) COMMENT 'Number of days from purchase order placement to vendor shipment departure. Vendor processing time component of total lead time.',
    `reorder_point_units` STRING COMMENT 'Inventory level in units that triggers automatic replenishment. Calculated from lead time, demand forecast, and safety stock.',
    `rfid_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether RFID tags are used to track shipments from this vendor for this item. Enables real-time supply chain visibility.',
    `safety_stock_days` DECIMAL(18,2) COMMENT 'Number of days of safety stock coverage calculated based on lead time and variability. Buffer inventory to protect against stockouts.',
    `seasonal_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to base lead time during seasonal periods. Values >1.0 extend lead time, <1.0 reduce it. Used for holiday or peak season adjustments.',
    `seasonal_period_code` STRING COMMENT 'Code identifying the seasonal period for which the adjustment factor applies. Examples: HOLIDAY, SUMMER, BACKTOSCHOOL.. Valid values are `^[A-Z0-9]{2,10}$`',
    `ship_to_receipt_days` DECIMAL(18,2) COMMENT 'Number of days from vendor shipment departure to receipt at destination location. Transit time component of total lead time.',
    `source_system_code` STRING COMMENT 'Code identifying the source system that provided this lead time data. Examples: BYDP (Blue Yonder Demand Planning), ORMS (Oracle Retail Merchandising System), MANUAL.. Valid values are `^[A-Z]{2,10}$`',
    `total_lead_time_days` DECIMAL(18,2) COMMENT 'Total end-to-end lead time from PO placement to receipt at destination. Sum of order-to-ship and ship-to-receipt days. Used to calculate reorder points.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation used for shipments from this vendor to the destination. Impacts transit time and cost.. Valid values are `truck|rail|air|ocean|intermodal`',
    `vendor_fill_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of orders fulfilled completely by the vendor for this item. Historical performance metric used to adjust lead time parameters.',
    CONSTRAINT pk_vendor_lead_time PRIMARY KEY(`vendor_lead_time_id`)
) COMMENT 'Operational lead time parameters by vendor-item-location combination used by Blue Yonder demand planning to calculate reorder points and safety stock. Captures vendor ID, item/SKU, destination DC or store, order-to-ship days, ship-to-receipt days, total lead time days, minimum order quantity, order multiple, case pack size, effective/expiration dates, lead time tier (standard, expedited, emergency), and seasonal adjustment factors. Drives automated replenishment calculations and PO timing. Distinct from vendor master (vendor domain) — this is supply-chain operational planning data.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`demand_forecast` (
    `demand_forecast_id` BIGINT COMMENT 'Primary key for demand_forecast',
    `ad_circular_id` BIGINT COMMENT 'Foreign key linking to promotion.ad_circular. Business justification: Ad circular features are a primary demand driver in grocery — forecast models apply ad lift factors based on circular placement. Demand planners explicitly reference the ad circular when building prom',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Demand forecasts drive open-to-buy (OTB) merchandise budgets. Linking forecast to budget enables forecast-vs-budget variance tracking, a core retail-grocery financial planning process. Merchandise fin',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: Pharmacy drug demand forecasting by NDC is a distinct operational process for formulary management, 340B program compliance, and drug shortage planning. Existing product_item_id covers general merchan',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Demand forecasts must align with fiscal periods for financial planning, open-to-buy budget management, and forecast vs. actual variance reporting. Retail-grocery merchandise finance teams use period-a',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Omnichannel demand forecasting: grocery retailers generate demand forecasts for e-commerce fulfillment nodes (dark stores, micro-fulfillment centers) distinct from physical store_location. This link e',
    `product_item_id` BIGINT COMMENT 'Reference to the product or SKU (Stock Keeping Unit) being forecasted. Links to the item master data.',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: Price-elastic demand forecasting: demand forecasts are generated at a specific price point; the retail_price in effect during the forecast period is an input to price elasticity modeling. Grocery dema',
    `reward_offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.reward_offer. Business justification: Loyalty-offer demand lift forecasting: demand_forecast.promotional_lift_units must be attributed to the specific loyalty reward_offer driving incremental volume. Distinct from TPR events, loyalty offe',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Cluster-level demand forecasting: grocery retailers generate forecasts segmented by store cluster to drive model selection, seasonal indices, and promotional lift estimates. A demand_forecast scoped t',
    `store_location_id` BIGINT COMMENT 'Reference to the store or DC (Distribution Center) for which the forecast is generated. Supports both store-level and DC-level forecasting.',
    `baseline_forecast_units` DECIMAL(18,2) COMMENT 'The baseline demand forecast in units, excluding promotional lift. Represents normal demand patterns based on historical trends and seasonality.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A score between 0 and 1 indicating the quality of input data used for forecast generation. Factors include completeness of historical sales, POS (Point of Sale) data accuracy, and inventory data reliability.',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'The coefficient of variation for historical demand, measuring demand volatility. Higher values indicate more variable demand patterns requiring higher safety stock.',
    `forecast_approval_timestamp` TIMESTAMP COMMENT 'The date and time when the forecast was approved by the demand planner and released for use in replenishment planning.',
    `forecast_bias_percentage` DECIMAL(18,2) COMMENT 'The historical forecast bias as a percentage, indicating systematic over-forecasting (positive) or under-forecasting (negative). Used for forecast accuracy monitoring.',
    `forecast_confidence_score` DECIMAL(18,2) COMMENT 'A confidence score between 0 and 1 indicating the reliability of the forecast. Higher scores indicate greater confidence based on historical accuracy and data quality.',
    `forecast_generation_timestamp` TIMESTAMP COMMENT 'The date and time when the forecast was initially generated by the Blue Yonder Demand Planning system.',
    `forecast_horizon_weeks` STRING COMMENT 'The number of weeks into the future this forecast covers from the period start date. Typical horizons range from 4 to 52 weeks.',
    `forecast_lower_bound_units` DECIMAL(18,2) COMMENT 'The lower bound of the forecast confidence interval in units, representing the pessimistic scenario for demand.',
    `forecast_method` STRING COMMENT 'The method used to generate the forecast. Statistical methods include time series models, machine learning uses advanced algorithms, manual override indicates planner adjustments, hybrid combines multiple methods, and consensus represents collaborative planning.. Valid values are `statistical|machine_learning|manual_override|hybrid|consensus`',
    `forecast_model_name` STRING COMMENT 'The specific forecasting model or algorithm used to generate the forecast (e.g., ARIMA, exponential smoothing, neural network, ensemble model).',
    `forecast_period_end_date` DATE COMMENT 'The end date of the forecast period. Typically represents the end of a week for weekly forecasts.',
    `forecast_period_start_date` DATE COMMENT 'The start date of the forecast period. Typically represents the beginning of a week for weekly forecasts.',
    `forecast_status` STRING COMMENT 'The current lifecycle status of the forecast. Draft forecasts are under review, approved forecasts are validated by planners, published forecasts are released to replenishment systems, superseded forecasts are replaced by newer versions, and rejected forecasts are not used.. Valid values are `draft|approved|published|superseded|rejected`',
    `forecast_upper_bound_units` DECIMAL(18,2) COMMENT 'The upper bound of the forecast confidence interval in units, representing the optimistic scenario for demand.',
    `forecast_version_number` STRING COMMENT 'Version number of the forecast for the same item-location-period combination. Increments with each revision to support forecast history and audit trails.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the forecast was last modified, either by system recalculation or manual planner override.',
    `mean_absolute_percentage_error` DECIMAL(18,2) COMMENT 'The Mean Absolute Percentage Error (MAPE) for this item-location combination, measuring historical forecast accuracy. Lower values indicate better accuracy.',
    `new_product_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this forecast is for a new product introduction with limited or no historical sales data. True indicates a new product.',
    `override_notes` STRING COMMENT 'Free-text notes entered by the planner explaining the rationale for manual forecast overrides or adjustments.',
    `override_reason_code` STRING COMMENT 'The reason code when a planner manually overrides the system-generated forecast. Captures business context for forecast adjustments. [ENUM-REF-CANDIDATE: promotion|stockout|weather|seasonality|new_product|discontinuation|market_trend|competitive_action|supply_constraint|other — 10 candidates stripped; promote to reference product]',
    `promotional_lift_units` DECIMAL(18,2) COMMENT 'The incremental demand units expected from promotional activities such as BOGO (Buy One Get One), TPR (Temporary Price Reduction), or ad circular features.',
    `safety_stock_units` DECIMAL(18,2) COMMENT 'The recommended safety stock level in units to buffer against forecast variability and supply chain uncertainty. Used in replenishment calculations.',
    `seasonal_index` DECIMAL(18,2) COMMENT 'The seasonal index applied to the forecast for this period, representing the expected demand variation due to seasonality. A value of 1.0 represents average demand, above 1.0 indicates peak season, below 1.0 indicates off-season.',
    `total_forecast_units` DECIMAL(18,2) COMMENT 'The total demand forecast in units, combining baseline forecast and promotional lift. This is the primary forecast value used for replenishment planning.',
    `trend_factor` DECIMAL(18,2) COMMENT 'The trend factor applied to the forecast, representing the expected growth or decline in demand over time. Positive values indicate growth, negative values indicate decline.',
    CONSTRAINT pk_demand_forecast PRIMARY KEY(`demand_forecast_id`)
) COMMENT 'Demand and supply forecasts generated by Blue Yonder Demand Planning at the item-location-week level. Captures forecast period, item/SKU, location (store or DC), baseline forecast units, promotional lift units, total forecast units, forecast confidence score, forecast method (statistical, ML, manual override), last updated timestamp, and planner ID. Used to drive replenishment orders and DC allocation. Operational planning data — not an analytics aggregate.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`allocation_plan` (
    `allocation_plan_id` BIGINT COMMENT 'Unique identifier for the allocation plan record. Primary key.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Allocation plans consume open-to-buy budget. Direct allocation_plan → budget link enables real-time budget consumption tracking as allocations are executed, supporting retail-grocery merchandise finan',
    `category_id` BIGINT COMMENT 'Reference to the merchandise category or department for this allocated item.',
    `dc_facility_id` BIGINT COMMENT 'Reference to the distribution center from which inventory will be allocated to stores.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to supply.demand_forecast. Business justification: Allocation plans are generated by Blue Yonder Allocation Optimization based on demand forecasts. Linking allocation_plan to the driving demand_forecast creates the planning chain traceability from for',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Allocation plans execute inventory investment decisions within fiscal periods. Period-stamping allocation plans enables budget consumption tracking and period-end inventory allocation variance reporti',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Node-level allocation planning: allocation plans specify which fulfillment node receives allocated inventory. In omnichannel grocery, this covers e-commerce DCs and dark stores beyond store_location s',
    `plan_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_plan. Business justification: Assortment-to-allocation execution: allocation plans operationalize assortment plans by distributing authorized SKUs across the supply network. Grocery merchants and supply planners jointly reference ',
    `planogram_id` BIGINT COMMENT 'Reference to the visual merchandise display plan (planogram) that defines shelf placement and facing count for this allocated item.',
    `product_item_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) or product being allocated across stores.',
    `promo_campaign_id` BIGINT COMMENT 'Reference to the promotional event driving this allocation, if applicable (e.g., BOGO, TPR, ad circular feature).',
    `retail_price_id` BIGINT COMMENT 'Foreign key linking to pricing.retail_price. Business justification: Promotional allocation margin validation: allocation plans with endcap_display_flag and ad_circular_week must reference the retail_price to calculate expected revenue and validate margin thresholds be',
    `reward_offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.reward_offer. Business justification: Loyalty-driven inventory allocation: when a reward_offer activates a buy-X-get-points promotion, supply planners create an allocation_plan to guarantee sufficient store-level inventory. Linking alloca',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Allocation plans in grocery are executed at SKU level — WMS pick instructions, pack-size-specific allocation, and promotional display execution require SKU precision beyond product_item. Existing prod',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to assortment.store_cluster. Business justification: Cluster-based allocation planning: allocation plans in grocery are executed against store clusters to determine priority, min/max quantities, and fill-rate targets per cluster segment. A retail-grocer',
    `vendor_funding_id` BIGINT COMMENT 'Foreign key linking to promotion.vendor_funding. Business justification: Promotional allocation plans are backed by vendor funding commitments — the constrained_supply_flag and fill_rate_target_pct on allocation_plan are directly governed by the vendor funding agreement. S',
    `wave_id` BIGINT COMMENT 'Foreign key linking to fulfillment.wave. Business justification: Allocation-to-wave execution: grocery DC operations release allocation plans into pick waves. This link enables allocation fill rate vs. wave completion analysis, promotional allocation execution trac',
    `actual_fill_rate_pct` DECIMAL(18,2) COMMENT 'Actual percentage of store orders completely fulfilled after allocation execution, calculated post-completion for performance measurement.',
    `ad_circular_week` STRING COMMENT 'ISO week identifier for the ad circular promotional flyer period this allocation supports (format: YYYY-Www).. Valid values are `^[0-9]{4}-W[0-9]{2}$`',
    `allocation_method` STRING COMMENT 'Algorithm or strategy used to distribute inventory: proportional to store size, store tier-based, historical sales-based, forecast-driven, manual override by category captain, or equal distribution.. Valid values are `proportional|store_tier|sales_history|forecast_driven|manual_override|equal_distribution`',
    `allocation_notes` STRING COMMENT 'Free-text notes from the merchandise planner or buyer providing context, special instructions, or business rationale for this allocation plan.',
    `allocation_strategy_code` STRING COMMENT 'System code representing the specific allocation algorithm configuration used by Blue Yonder.. Valid values are `^[A-Z0-9]{3,10}$`',
    `allocation_type` STRING COMMENT 'Category of allocation plan indicating the business driver: promotional (BOGO, TPR), constrained supply, seasonal launch, new item introduction, standard replenishment, or ad circular support.. Valid values are `promotional|constrained|seasonal|new_item|replenishment|ad_circular`',
    `allocation_unit_of_measure` STRING COMMENT 'Unit of measure for allocated quantities: each (individual units), case (vendor case pack), pallet (full pallet), or inner pack (intermediate pack size).. Valid values are `each|case|pallet|inner_pack`',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether the allocated item requires temperature-controlled logistics (fresh produce, frozen, dairy, meat, pharmacy).',
    `constrained_supply_flag` BOOLEAN COMMENT 'Indicates whether this allocation is for limited or constrained inventory requiring equitable distribution across stores.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation plan record was first created in the system.',
    `cross_dock_eligible_flag` BOOLEAN COMMENT 'Indicates whether allocated inventory can be cross-docked (transferred without storage) at the DC for faster store delivery.',
    `endcap_display_flag` BOOLEAN COMMENT 'Indicates whether this allocation includes inventory for end-of-aisle promotional displays (endcaps) in addition to regular shelf stock.',
    `fifo_enforcement_flag` BOOLEAN COMMENT 'Indicates whether FIFO inventory rotation must be enforced during allocation fulfillment to manage perishable goods and expiration dates.',
    `fill_rate_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of store orders that should be completely fulfilled by this allocation plan, used to measure allocation effectiveness.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation plan record was last modified, tracking changes through the plan lifecycle.',
    `max_store_quantity` STRING COMMENT 'Maximum quantity each store can receive based on shelf capacity, backroom space, or planogram facing constraints.',
    `min_store_quantity` STRING COMMENT 'Minimum quantity each store should receive to maintain shelf presence and avoid out-of-stock (OOS) conditions.',
    `override_reason` STRING COMMENT 'Explanation for any manual overrides applied to system-generated allocation recommendations, documenting planner judgment.',
    `plan_approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation plan was approved by the merchandise planner or category manager.',
    `plan_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when all store allocations in the plan were fulfilled and the plan was marked complete.',
    `plan_created_date` DATE COMMENT 'Date when the allocation plan was initially created in the Blue Yonder system.',
    `plan_released_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation plan was released to the warehouse management system for fulfillment execution.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the allocation plan: draft (being created), approved (ready for execution), released (sent to WMS), in progress (actively fulfilling), completed (all stores fulfilled), or cancelled.. Valid values are `draft|approved|released|in_progress|completed|cancelled`',
    `priority_level` STRING COMMENT 'Business priority for fulfilling this allocation plan, affecting warehouse picking and shipping sequence.. Valid values are `critical|high|medium|low`',
    `rfid_tracked_flag` BOOLEAN COMMENT 'Indicates whether the allocated item is tracked using RFID technology for real-time inventory visibility and shrink reduction.',
    `seasonal_event` STRING COMMENT 'Seasonal or holiday event associated with this allocation (e.g., Thanksgiving, Back to School, Summer BBQ).',
    `store_count` STRING COMMENT 'Number of stores included in this allocation plan.',
    `temperature_requirement` STRING COMMENT 'Temperature control classification for allocated inventory: ambient (room temp), refrigerated (33-40°F), frozen (0°F or below), or controlled room temperature (pharmacy).. Valid values are `ambient|refrigerated|frozen|controlled_room_temp`',
    `total_allocated_quantity` STRING COMMENT 'Total number of units allocated across all stores in this plan.',
    `total_available_quantity` STRING COMMENT 'Total quantity of the item available at the source DC at the time the allocation plan was created.',
    CONSTRAINT pk_allocation_plan PRIMARY KEY(`allocation_plan_id`)
) COMMENT 'DC-to-store allocation plans generated by Blue Yonder Allocation Optimization for constrained or promotional inventory, encompassing both plan-level details (item, source DC, allocation type, method, status) and store-level allocation detail (destination store, allocated quantity, min/max, store tier, override, fulfillment status). Enables equitable distribution of limited supply and store-level fill rate measurement.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`dc_facility` (
    `dc_facility_id` BIGINT COMMENT 'Unique identifier for the distribution center or micro-fulfillment center facility.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each DC facility is a cost center for overhead allocation, labor cost tracking, and operational P&L. Retail-grocery finance teams budget and report DC operating costs (utilities, labor, depreciation) ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: DC facilities belong to specific legal entities for tax reporting, property accounting, and financial consolidation. Multi-banner retail-grocery operators require this link to assign DC assets, liabil',
    `address_line1` STRING COMMENT 'Primary street address line for the distribution center facility. Organizational contact data classified as confidential.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, building, or unit information. Organizational contact data classified as confidential.',
    `ambient_capacity_cubic_ft` DECIMAL(18,2) COMMENT 'Total cubic feet of ambient (room temperature) storage capacity for non-perishable inventory.',
    `average_daily_outbound_volume` DECIMAL(18,2) COMMENT 'Average number of cases or pallets shipped outbound per day for store replenishment and customer fulfillment.',
    `city` STRING COMMENT 'City where the distribution center is located. Organizational contact data classified as confidential.',
    `closed_date` DATE COMMENT 'Date when the distribution center was permanently closed or decommissioned. Null for active facilities.',
    `cold_chain_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified for cold chain logistics and temperature-controlled supply chain operations for perishable goods.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the distribution center location (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution center facility record was first created in the system.',
    `cross_dock_enabled_flag` BOOLEAN COMMENT 'Indicates whether this facility supports cross-dock operations (transfer of goods from inbound to outbound without storage).',
    `dc_code` STRING COMMENT 'Business identifier code for the distribution center used across operational systems and reporting. Typically a short alphanumeric code.. Valid values are `^[A-Z0-9]{3,10}$`',
    `dc_name` STRING COMMENT 'Full business name of the distribution center or micro-fulfillment center facility.',
    `dock_door_count` STRING COMMENT 'Total number of dock doors available for inbound receiving and outbound shipping operations.',
    `dsd_receiving_flag` BOOLEAN COMMENT 'Indicates whether this distribution center receives DSD shipments directly from vendors for consolidation and redistribution to stores.',
    `erp_location_code` STRING COMMENT 'Location identifier in the enterprise ERP system (SAP, Oracle) used for financial posting and inventory accounting.',
    `facility_status` STRING COMMENT 'Current operational status of the distribution center facility in its lifecycle.. Valid values are `active|inactive|under_construction|decommissioned|seasonal|temporarily_closed`',
    `facility_type` STRING COMMENT 'Classification of the distribution center by operational model: full-service DC (receiving, storage, picking, shipping), cross-dock (transfer without storage), MFC (micro-fulfillment center for last-mile delivery), cold storage (refrigerated/frozen only), ambient-only, or perishable-focused.. Valid values are `full_service_dc|cross_dock|mfc|cold_storage|ambient_only|perishable`',
    `frozen_capacity_cubic_ft` DECIMAL(18,2) COMMENT 'Total cubic feet of frozen storage capacity for frozen goods inventory (typically 0°F or below).',
    `haccp_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility maintains HACCP certification for food safety and hazard prevention in handling perishable and food products.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution center facility record was most recently modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the distribution center for routing and logistics optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the distribution center for routing and logistics optimization.',
    `opened_date` DATE COMMENT 'Date when the distribution center facility first became operational and began receiving and shipping inventory.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for weekdays (Monday-Friday) in format HH:MM-HH:MM (e.g., 06:00-22:00). Used for scheduling inbound shipments and outbound loads.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for weekends (Saturday-Sunday) in format HH:MM-HH:MM. May differ from weekday hours or be closed.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified for handling and storing USDA organic products with required segregation and handling protocols.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the distribution center facility. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the distribution center address. Organizational contact data classified as confidential.',
    `primary_service_region` STRING COMMENT 'Geographic region or market area primarily served by this distribution center (e.g., Northeast, Southeast, Midwest, West Coast).',
    `refrigerated_capacity_cubic_ft` DECIMAL(18,2) COMMENT 'Total cubic feet of refrigerated storage capacity for temperature-controlled perishable inventory (typically 32-40°F).',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether this facility is equipped with RFID infrastructure for automated inventory tracking and shipment verification.',
    `sap_plant_code` STRING COMMENT 'SAP ERP plant code assigned to this distribution center for materials management and logistics execution in SAP MM/WM modules.. Valid values are `^[A-Z0-9]{4}$`',
    `state_province` STRING COMMENT 'State or province code for the distribution center location. Organizational contact data classified as confidential.',
    `store_count_served` STRING COMMENT 'Number of retail store locations actively served by this distribution center for replenishment.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the distribution center location used for scheduling and operational hours (e.g., America/New_York, America/Chicago).',
    `total_square_footage` DECIMAL(18,2) COMMENT 'Total building square footage of the distribution center facility including all storage, operational, and administrative areas.',
    `twenty_four_hour_operation_flag` BOOLEAN COMMENT 'Indicates whether the distribution center operates 24 hours per day, 7 days per week for continuous receiving and shipping.',
    `wms_system_instance` STRING COMMENT 'Identifier for the WMS system instance deployed at this distribution center. References Manhattan Associates WMS or other warehouse management platform.',
    CONSTRAINT pk_dc_facility PRIMARY KEY(`dc_facility_id`)
) COMMENT 'Master record for Distribution Centers and Micro-Fulfillment Centers (MFCs) in the Grocery supply network. Captures DC code, DC name, address, facility type (full-service DC, cross-dock, MFC, cold storage), total square footage, dock door count, refrigerated capacity (cubic feet), frozen capacity, ambient capacity, WMS system instance, SAP plant code, operating hours, and facility status. Distinct from store master (owned by store domain).';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`supplier_contract` (
    `supplier_contract_id` BIGINT COMMENT 'Unique identifier for the supplier contract. Primary key.',
    `banner_id` BIGINT COMMENT 'Foreign key linking to store.banner. Business justification: Supplier contracts in grocery are frequently negotiated at banner level — especially private label programs, promotional allowances, and category captain agreements. Banner-level contract management a',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: Category-level supplier contract management: grocery supplier contracts are scoped to categories (category captainship, category fill-rate SLAs, private-label exclusivity). The category_captain_flag a',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supply.dc_facility. Business justification: Supplier contracts in grocery supply chains are often scoped to specific DC facilities (a vendor may have different contract terms for different DCs based on geography, volume, or service region). Add',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Supplier contracts generate allowance accruals (allowance_rate_pct, slotting_fee_amount) that must be period-stamped for vendor income recognition. Retail-grocery finance teams accrue vendor allowance',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Supplier contracts in grocery are negotiated at category/hierarchy level — category captain agreements, slotting fees, and promotional allowances are structured by department or category node. A groce',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Supplier contracts are executed between specific legal entities, determining which company code bears the contractual obligations, allowances, and slotting fees. Retail-grocery legal and finance teams',
    `private_label_id` BIGINT COMMENT 'Foreign key linking to product.private_label. Business justification: Private label supplier contracts are a distinct contract type in grocery retail — co-manufacturing agreements, quality standards, and packaging specs are managed per private label program. The plain `',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: REQUIRED: Store‑level supplier contract compliance reports require linking each contract to the specific store it governs; this FK enables per‑store contract performance tracking.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor master record. Links to the vendor who is party to this supply agreement.',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Supplier contracts in grocery formally specify the agreed payment method (ACH, wire, check). Linking supply_supplier_contract to tender_type enforces contractual payment method compliance during AP pr',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Supplier contracts in the supply domain are operationally aligned with trade agreements in the vendor domain. Linking them enables contract hierarchy management, allowance validation cross-reference, ',
    `allowance_rate_pct` DECIMAL(18,2) COMMENT 'Negotiated allowance or discount percentage applied to invoice amounts. May represent volume rebates, promotional allowances, or early payment discounts.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews for another term if neither party provides termination notice by the renewal deadline.',
    `category_captain_flag` BOOLEAN COMMENT 'Indicates whether this vendor serves as the category captain, providing category management insights, planogram recommendations, and assortment optimization guidance.',
    `chargeback_policy` STRING COMMENT 'Detailed policy governing vendor chargebacks for non-compliance events including late shipments, short fills, mislabeling, EDI errors, and HACCP violations. Defines chargeback amounts, dispute process, and resolution timelines.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether temperature-controlled logistics (cold chain) are required for all shipments under this contract. Enforced for perishable goods, frozen foods, and pharmacy products.',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed contract document stored in the document management system. Provides audit trail and legal reference.',
    `contract_name` STRING COMMENT 'Human-readable name or title of the supplier contract for easy identification and reference.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the supplier contract. Used in procurement documents, EDI transactions, and vendor communications.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the supplier contract. Active contracts govern current procurement operations. Suspended contracts are temporarily inactive. Expired contracts have passed their end date. Terminated contracts were ended early.. Valid values are `draft|active|suspended|expired|terminated|pending_renewal`',
    `contract_type` STRING COMMENT 'Classification of the contract governing the procurement relationship. Blanket PO for recurring orders, spot buy for one-time purchases, DSD for Direct Store Delivery agreements, private label for store-owned brand sourcing, consignment for vendor-owned inventory.. Valid values are `blanket_po|spot_buy|master_agreement|dsd_agreement|private_label|consignment`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system. Audit trail for contract lifecycle tracking.',
    `cross_dock_eligible_flag` BOOLEAN COMMENT 'Indicates whether shipments under this contract are eligible for cross-dock operations (transfer without DC storage). Requires vendor to meet strict ASN accuracy and delivery window compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this contract (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_process` STRING COMMENT 'Agreed process for resolving contract disputes including escalation paths, mediation requirements, and arbitration clauses. May reference specific legal jurisdictions.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this contract governs Direct Store Delivery operations, where vendor delivers directly to stores bypassing the DC. Common for bread, beverages, snacks, and magazines.',
    `edi_required_flag` BOOLEAN COMMENT 'Indicates whether EDI transaction compliance is mandatory under this contract. True means vendor must submit ASN (856), invoices (810), and other documents via EDI. False allows manual or alternative submission methods.',
    `edi_transaction_types` STRING COMMENT 'Comma-separated list of required EDI transaction set codes (e.g., 850 for PO, 856 for ASN, 810 for Invoice, 997 for Functional Acknowledgment). Defines the EDI compliance scope.',
    `effective_end_date` DATE COMMENT 'Date when the contract terms expire. Nullable for open-ended agreements. Triggers renewal or termination workflows as the date approaches.',
    `effective_start_date` DATE COMMENT 'Date when the contract terms become binding and procurement operations under this agreement may begin.',
    `freight_terms` STRING COMMENT 'Freight payment and liability terms. FOB Origin means buyer pays freight and assumes risk at vendor location. FOB Destination means vendor pays freight and assumes risk until delivery. Prepaid means vendor pays and may bill back. Collect means buyer pays carrier directly.. Valid values are `fob_origin|fob_destination|prepaid|collect|third_party`',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern contract interpretation and enforcement. Typically the state or country where the retailer is headquartered.',
    `haccp_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether vendor must maintain HACCP certification and provide HACCP documentation for shipments. Critical for fresh produce, meat, dairy, and perishable goods suppliers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated. Tracks amendments, status changes, and data corrections.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order submission to expected delivery at DC or store. Used in demand planning and replenishment forecasting.',
    `minimum_fill_rate_pct` DECIMAL(18,2) COMMENT 'Contractually required fill rate percentage. Vendor must fulfill at least this percentage of ordered quantity to avoid chargeback penalties. Monitored against actual shipment performance.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required per purchase order under this contract. Used in CAO (Computer-Assisted Ordering) and replenishment planning systems.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum monetary value required per purchase order to meet contract terms. Enforced in procurement systems to avoid order rejection.',
    `notes` STRING COMMENT 'Free-text field for additional contract terms, special conditions, or operational notes not captured in structured fields.',
    `on_time_delivery_sla_pct` DECIMAL(18,2) COMMENT 'Contractually required on-time delivery percentage. Vendor must meet scheduled delivery windows at least this percentage of the time to avoid penalties. Tracked via TMS and WMS receiving timestamps.',
    `organic_certification_required_flag` BOOLEAN COMMENT 'Indicates whether vendor must maintain USDA Organic certification for products supplied under this contract. Enforced for organic private-label and branded organic SKUs.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms governing invoice settlement. Examples: Net 30, Net 60, 2/10 Net 30 (2% discount if paid within 10 days, otherwise net 30).',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming shipments under this contract require mandatory quality inspection at receiving before putaway. Common for fresh produce, meat, and private-label goods.',
    `renewal_notice_days` STRING COMMENT 'Number of days before contract expiration that renewal or termination notice must be provided. Triggers workflow alerts in procurement systems.',
    `return_policy` STRING COMMENT 'Terms governing product returns, including acceptable reasons (damage, expiration, overstock), timeframes, and restocking fees. Critical for managing shrink and vendor chargebacks.',
    `rfid_tracking_required_flag` BOOLEAN COMMENT 'Indicates whether vendor must apply RFID tags to pallets or cases for automated tracking through the supply chain. Supports inventory visibility and shrink reduction initiatives.',
    `slotting_fee_amount` DECIMAL(18,2) COMMENT 'One-time or recurring fee paid by vendor for shelf space allocation and new item introduction. Common in category captain and promotional agreements.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required to terminate the contract before its natural expiration. Protects both parties from abrupt supply disruption.',
    CONSTRAINT pk_supplier_contract PRIMARY KEY(`supplier_contract_id`)
) COMMENT 'Supply-chain-specific vendor contracts governing purchase terms, fill rate SLAs, lead times, EDI requirements, and compliance obligations. Encompasses contract terms (type, effective dates, minimum fill rate, on-time SLA, EDI compliance) and compliance enforcement including vendor chargebacks for non-compliance events (late shipments, short fills, mislabeling, EDI errors, HACCP violations). Captures chargeback amounts, dispute status, and resolution. Distinct from vendor master (vendor domain) — this is the operational supply agreement and its enforcement.';

CREATE OR REPLACE TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` (
    `inbound_shipment_line_id` BIGINT COMMENT 'Primary key for the inbound_shipment_line association',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking this line item to its parent inbound shipment (ASN). Identifies which physical shipment/trailer this line-level record belongs to.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking this line item to the specific purchase order line being fulfilled. Enables receiving reconciliation and three-way invoice matching at the line level.',
    `line_shipment_status` STRING COMMENT 'Current lifecycle status of this specific PO line within the inbound shipment. Tracks progression from ASN creation through receiving completion. Distinct from both the shipment-level status and the PO line status, as a single shipment may have lines in different states.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity of this PO line actually received and confirmed during dock receiving for this specific shipment. Updated by WMS during goods receipt. Used for three-way matching against shipped_quantity and invoiced quantity.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Quantity of the PO line item shipped on this specific ASN. Expressed in the unit of measure of the PO line. This value is vendor-reported via EDI 856 and may differ from ordered quantity (partial shipment) or received quantity (variance).',
    `temperature_compliance_flag` BOOLEAN COMMENT 'Indicates whether this specific line item maintained required temperature compliance during transit and at receiving for this shipment. Relevant for perishable, refrigerated, and frozen SKUs. Captured at the line level because a single shipment may carry items with different temperature requirements.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between shipped_quantity and received_quantity for this line on this shipment. Positive value indicates overage; negative indicates shortage. Triggers discrepancy workflow in SAP MM when outside tolerance thresholds.',
    CONSTRAINT pk_inbound_shipment_line PRIMARY KEY(`inbound_shipment_line_id`)
) COMMENT 'This association product represents the ASN Line Item — the operational record linking one inbound shipment to one purchase order line. It captures the line-level fulfillment detail for each SKU within an ASN, including quantities shipped, quantities received, variance, and per-line compliance status. Each record is created during ASN processing in Manhattan Associates WMS and reconciled against SAP MM goods receipts during receiving. This entity is the atomic unit for three-way matching (PO line → ASN line → invoice line) and cannot be derived from either the shipment header or the PO line alone.. Existence Justification: In grocery supply chain operations, a single PO line can be fulfilled across multiple inbound shipments (partial shipments, split deliveries across ASNs), and a single inbound shipment (ASN) routinely covers multiple PO lines from one or more purchase orders. This is a genuine operational M:N: the business actively creates, tracks, and reconciles ASN-to-PO-line linkages in Manhattan Associates WMS and SAP MM as part of the receiving and invoice-matching process. The relationship itself carries operational data (shipped quantity per line, received quantity per line, variance, line-level shipment status) that belongs to neither the shipment header nor the PO line alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `grocery_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `grocery_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `grocery_ecm`.`supply`.`transport_route`(`transport_route_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `grocery_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `grocery_ecm`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_allocation_plan_id` FOREIGN KEY (`allocation_plan_id`) REFERENCES `grocery_ecm`.`supply`.`allocation_plan`(`allocation_plan_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `grocery_ecm`.`supply`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `grocery_ecm`.`supply`.`transport_route`(`transport_route_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `grocery_ecm`.`supply`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ADD CONSTRAINT `fk_supply_dc_transfer_transport_route_id` FOREIGN KEY (`transport_route_id`) REFERENCES `grocery_ecm`.`supply`.`transport_route`(`transport_route_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `grocery_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ADD CONSTRAINT `fk_supply_direct_store_delivery_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `grocery_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ADD CONSTRAINT `fk_supply_transport_route_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ADD CONSTRAINT `fk_supply_vendor_lead_time_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `grocery_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ADD CONSTRAINT `fk_supply_allocation_plan_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `grocery_ecm`.`supply`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_dc_facility_id` FOREIGN KEY (`dc_facility_id`) REFERENCES `grocery_ecm`.`supply`.`dc_facility`(`dc_facility_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` ADD CONSTRAINT `fk_supply_inbound_shipment_line_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `grocery_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` ADD CONSTRAINT `fk_supply_inbound_shipment_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `grocery_ecm`.`supply`.`po_line`(`po_line_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `grocery_ecm`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'vendor_procurement');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Contract Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'vendor_unable_to_fulfill|demand_change|pricing_issue|quality_issue|duplicate_order|other');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `edi_transmission_flag` SET TAGS ('dbx_business_glossary_term' = 'EDI (Electronic Data Interchange) Transmission Flag');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `edi_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'EDI (Electronic Data Interchange) Transmission Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DDP|DAP|FCA');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^(net_[0-9]{1,3}|[0-9]{1,2}/[0-9]{1,3}_net_[0-9]{1,3})$');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{8,12}$');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|dsd|cross_dock|promotional|emergency|blanket');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `rfid_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Tracking Enabled Flag');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'truck|rail|intermodal|air|parcel|vendor_fleet');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `slotting_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee Amount');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `temperature_range_max` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `temperature_range_min` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `total_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Order Amount');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_acknowledgment_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acknowledgment Received Flag');
ALTER TABLE `grocery_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acknowledgment Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` SET TAGS ('dbx_subdomain' = 'vendor_procurement');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `cost_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Schedule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `vendor_funding_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funding Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'off_invoice|scan_based|volume_rebate|promotional|slotting|markdown');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `confirmed_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Ship Date');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'warehouse|dsd|cross_dock|drop_ship');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_business_glossary_term' = 'Extended Cost');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^d{8}$|^d{12}$|^d{13}$|^d{14}$');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|partially_received|fully_received|cancelled|closed');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `srp` SET TAGS ('dbx_business_glossary_term' = 'Suggested Retail Price (SRP)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`supply`.`po_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^d{12}$');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` SET TAGS ('dbx_subdomain' = 'inbound_logistics');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment ID');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Cross Dock Wave Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `new_item_intro_id` SET TAGS ('dbx_business_glossary_term' = 'New Item Intro Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Contract Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Route Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Ship Notice (ASN) Number');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `bol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Flag');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'DC|Store|Cross-Dock|MFC');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'Prepaid|Collect|Third-Party|FOB-Origin|FOB-Destination');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `haccp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Compliant Flag');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'Standard|High|Urgent|Critical');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `receiving_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receiving Complete Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `receiving_discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Receiving Discrepancy Flag');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `receiving_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receiving Start Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `rfid_tracked_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tracked Flag');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `scheduled_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Date');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `scheduled_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Time');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'Planned|In-Transit|Arrived|Receiving|Received|Cancelled');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'Standard|DSD|Cross-Dock|Emergency|Transfer');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_max_f` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_min_f` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'Ambient|Refrigerated|Frozen|Controlled');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `total_case_count` SET TAGS ('dbx_business_glossary_term' = 'Total Case Count');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `total_cube_ft` SET TAGS ('dbx_business_glossary_term' = 'Total Cube (Cubic Feet)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `total_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Total Pallet Count');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `total_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Count');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `total_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Pounds)');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'inbound_logistics');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Record Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment ID');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `slot_location_id` SET TAGS ('dbx_business_glossary_term' = 'Putaway Slot Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,25}$');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `cross_dock_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Flag');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `inspection_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Flag');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'PASSED|FAILED|PARTIAL|PENDING|NOT_REQUIRED');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `osd_flag` SET TAGS ('dbx_business_glossary_term' = 'Overage Shortage Damage (OS&D) Flag');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `osd_notes` SET TAGS ('dbx_business_glossary_term' = 'Overage Shortage Damage (OS&D) Notes');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `osd_type` SET TAGS ('dbx_business_glossary_term' = 'Overage Shortage Damage (OS&D) Type');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `osd_type` SET TAGS ('dbx_value_regex' = 'OVERAGE|SHORTAGE|DAMAGE|MULTIPLE|NONE');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `packing_slip_number` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Number');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `packing_slip_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `putaway_status` SET TAGS ('dbx_business_glossary_term' = 'Putaway Status');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `putaway_status` SET TAGS ('dbx_value_regex' = 'NOT_STARTED|IN_PROGRESS|COMPLETED|BLOCKED');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receipt_notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Notes');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'DRAFT|IN_PROGRESS|COMPLETED|POSTED|CANCELLED');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'PO|DSD|RETURN|TRANSFER|CROSS_DOCK|SAMPLE');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `rfid_scanned_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Scanned Flag');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_MM|MANHATTAN_WMS|ORACLE_RETAIL|MANUAL');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `temperature_at_receipt` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Receipt (Celsius)');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `total_accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Accepted Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `total_received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Received Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `total_rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Rejected Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `grocery_ecm`.`supply`.`goods_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'inventory_replenishment');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `allocation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `primary_replenishment_store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'inventory_unavailable|destination_closed|duplicate_order|demand_change|system_error|other');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `cross_dock_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Eligible Flag');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'store|dc|mfc');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Order Fill Rate Percentage');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Date');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Type');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'auto_replenishment|manual|emergency|seasonal|promotional|new_store');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Order Priority Level');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Computer-Assisted Ordering (CAO) Replenishment Trigger');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_trigger` SET TAGS ('dbx_value_regex' = 'cao_forecast|min_max_threshold|safety_stock|manual_override|promotional_event|seasonal_demand');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `rfid_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tracking Enabled Flag');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi_temp');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `total_cube_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Cube Volume');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `total_line_count` SET TAGS ('dbx_business_glossary_term' = 'Total Line Count');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `total_ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Ordered Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `total_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Total Pallet Count');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `total_received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Received Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `total_shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Shipped Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`replenishment_order` ALTER COLUMN `total_weight` SET TAGS ('dbx_business_glossary_term' = 'Total Weight');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` SET TAGS ('dbx_subdomain' = 'inventory_replenishment');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `dc_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Transfer ID');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Route Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Dc Facility Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `primary_dc_store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Route Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `actual_transit_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Transit Hours');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `contains_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Contains Hazardous Materials (HAZMAT)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `damage_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Reported Flag');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `destination_location_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Type');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `destination_location_type` SET TAGS ('dbx_value_regex' = 'dc|store|mfc|cross-dock');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `estimated_transit_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Hours');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `freight_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost (United States Dollars)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `freight_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `on_time_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Flag');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `origin_location_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Type');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `origin_location_type` SET TAGS ('dbx_value_regex' = 'dc|store|mfc|cross-dock');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|urgent|critical');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `rfid_enabled` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `shortage_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Shortage Reported Flag');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi-temp');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `total_cases` SET TAGS ('dbx_business_glossary_term' = 'Total Cases');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `total_cube_cf` SET TAGS ('dbx_business_glossary_term' = 'Total Cube (Cubic Feet)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `total_pallets` SET TAGS ('dbx_business_glossary_term' = 'Total Pallets');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `total_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Pounds)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Number');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_value_regex' = '^TRF-[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `grocery_ecm`.`supply`.`dc_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'cross-dock|pick-and-ship|store-to-store|dc-to-dc|emergency|recall');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` SET TAGS ('dbx_subdomain' = 'inbound_logistics');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `direct_store_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery Identifier');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Contract Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Vendor ID');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_transit|delivered|reconciled|disputed|cancelled');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_business_glossary_term' = 'Driver License Number');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `driver_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `driver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `pos_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Integration Flag');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `pos_integration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Integration Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `quality_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Flag');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `quality_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Description');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `receiving_notes` SET TAGS ('dbx_business_glossary_term' = 'Receiving Notes');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `route_number` SET TAGS ('dbx_business_glossary_term' = 'Route Number');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `scheduled_delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Time');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `temperature_reading` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `total_case_count` SET TAGS ('dbx_business_glossary_term' = 'Total Case Count');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Keeping Unit (SKU) Count');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `total_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Count');
ALTER TABLE `grocery_ecm`.`supply`.`direct_store_delivery` ALTER COLUMN `vendor_delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Delivery Note Number');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` SET TAGS ('dbx_subdomain' = 'distribution_operations');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Route ID');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Distribution Center (DC) ID');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `backhaul_enabled` SET TAGS ('dbx_business_glossary_term' = 'Backhaul Enabled');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `cross_dock_eligible` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Eligible');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `estimated_transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Time in Hours');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `fill_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Percentage');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Rate');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `gps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Tracking Enabled');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `last_executed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Date');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Route Notes');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `on_time_delivery_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Target Percentage');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `operating_days` SET TAGS ('dbx_business_glossary_term' = 'Operating Days');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `rfid_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tracking Enabled');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_cost_fixed` SET TAGS ('dbx_business_glossary_term' = 'Route Fixed Cost');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_cost_fixed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_cost_per_mile` SET TAGS ('dbx_business_glossary_term' = 'Route Cost Per Mile');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_cost_per_mile` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_frequency` SET TAGS ('dbx_business_glossary_term' = 'Route Frequency');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|bi_weekly|monthly|on_demand|seasonal');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_number` SET TAGS ('dbx_business_glossary_term' = 'Route Number');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Enabled');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|archived');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'dc_to_store|inter_dc|dsd|cross_dock|backhaul|milk_run');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `scheduled_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Time');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `stop_count` SET TAGS ('dbx_business_glossary_term' = 'Stop Count');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `temperature_max_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Fahrenheit');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `temperature_min_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Fahrenheit');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `temperature_zone_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Required');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `temperature_zone_required` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi_temp|controlled');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `total_route_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Total Route Distance in Miles');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `trailer_capacity_cases` SET TAGS ('dbx_business_glossary_term' = 'Trailer Capacity in Cases');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `trailer_capacity_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Trailer Capacity in Cubic Feet');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `trailer_capacity_pallets` SET TAGS ('dbx_business_glossary_term' = 'Trailer Capacity in Pallets');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `trailer_capacity_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Trailer Capacity Weight in Pounds (lbs)');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `trailer_type` SET TAGS ('dbx_business_glossary_term' = 'Trailer Type');
ALTER TABLE `grocery_ecm`.`supply`.`transport_route` ALTER COLUMN `trailer_type` SET TAGS ('dbx_value_regex' = 'dry_van|refrigerated|flatbed|tanker|intermodal|multi_temp');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` SET TAGS ('dbx_subdomain' = 'vendor_procurement');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `vendor_lead_time_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lead Time ID');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Contract Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `case_pack_size` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Size');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `cross_dock_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Eligible Flag');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'dc|store|mfc');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm) Code');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `lead_time_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Status');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `lead_time_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `lead_time_tier` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Tier');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `lead_time_tier` SET TAGS ('dbx_value_regex' = 'standard|expedited|emergency|dsd');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `lead_time_variability_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability Days');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `order_to_ship_days` SET TAGS ('dbx_business_glossary_term' = 'Order to Ship Days');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `reorder_point_units` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Units');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `rfid_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tracking Enabled Flag');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `safety_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `seasonal_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Adjustment Factor');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `seasonal_period_code` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period Code');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `seasonal_period_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `ship_to_receipt_days` SET TAGS ('dbx_business_glossary_term' = 'Ship to Receipt Days');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `total_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Total Lead Time Days');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|ocean|intermodal');
ALTER TABLE `grocery_ecm`.`supply`.`vendor_lead_time` ALTER COLUMN `vendor_fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Vendor Fill Rate Percent');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` SET TAGS ('dbx_subdomain' = 'inventory_replenishment');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Identifier');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `ad_circular_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `baseline_forecast_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Forecast Units');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approval Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_bias_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percentage');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Score');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Generation Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Weeks');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_lower_bound_units` SET TAGS ('dbx_business_glossary_term' = 'Forecast Lower Bound Units');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'statistical|machine_learning|manual_override|hybrid|consensus');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_model_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Name');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|approved|published|superseded|rejected');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_upper_bound_units` SET TAGS ('dbx_business_glossary_term' = 'Forecast Upper Bound Units');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `forecast_version_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Number');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `mean_absolute_percentage_error` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `new_product_indicator` SET TAGS ('dbx_business_glossary_term' = 'New Product Indicator');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `override_notes` SET TAGS ('dbx_business_glossary_term' = 'Override Notes');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Override Reason Code');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `promotional_lift_units` SET TAGS ('dbx_business_glossary_term' = 'Promotional Lift Units');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `safety_stock_units` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Units');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `seasonal_index` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Index');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `total_forecast_units` SET TAGS ('dbx_business_glossary_term' = 'Total Forecast Units');
ALTER TABLE `grocery_ecm`.`supply`.`demand_forecast` ALTER COLUMN `trend_factor` SET TAGS ('dbx_business_glossary_term' = 'Trend Factor');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` SET TAGS ('dbx_subdomain' = 'inventory_replenishment');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `allocation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Plan ID');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Distribution Center (DC) ID');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram ID');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `retail_price_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `reward_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `vendor_funding_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Funding Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `actual_fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Fill Rate Percentage');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `ad_circular_week` SET TAGS ('dbx_business_glossary_term' = 'Ad Circular Week');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `ad_circular_week` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-W[0-9]{2}$');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'proportional|store_tier|sales_history|forecast_driven|manual_override|equal_distribution');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `allocation_strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Strategy Code');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `allocation_strategy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'promotional|constrained|seasonal|new_item|replenishment|ad_circular');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `allocation_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Allocation Unit of Measure');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `allocation_unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|inner_pack');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `constrained_supply_flag` SET TAGS ('dbx_business_glossary_term' = 'Constrained Supply Flag');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `cross_dock_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Eligible Flag');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `endcap_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Endcap Display Flag');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `fifo_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'FIFO (First In First Out) Enforcement Flag');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `fill_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Percentage');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `max_store_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Store Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `min_store_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Store Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `plan_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Approved Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `plan_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Completed Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `plan_created_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Created Date');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `plan_released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Released Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Plan Status');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|released|in_progress|completed|cancelled');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `rfid_tracked_flag` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Tracked Flag');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `seasonal_event` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `store_count` SET TAGS ('dbx_business_glossary_term' = 'Store Count');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled_room_temp');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `total_allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Allocated Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`allocation_plan` ALTER COLUMN `total_available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Available Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` SET TAGS ('dbx_subdomain' = 'distribution_operations');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Facility ID');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `ambient_capacity_cubic_ft` SET TAGS ('dbx_business_glossary_term' = 'Ambient Capacity (Cubic Feet)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `average_daily_outbound_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Outbound Volume');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `cold_chain_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Certified Flag');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `cross_dock_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Enabled Flag');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `dc_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Code');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `dc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `dc_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Name');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `dock_door_count` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Count');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `dsd_receiving_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Receiving Flag');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `erp_location_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Location ID');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Status');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|seasonal|temporarily_closed');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'full_service_dc|cross_dock|mfc|cold_storage|ambient_only|perishable');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `frozen_capacity_cubic_ft` SET TAGS ('dbx_business_glossary_term' = 'Frozen Capacity (Cubic Feet)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `haccp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Certified Flag');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours (Weekday)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours (Weekend)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `primary_service_region` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Region');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `refrigerated_capacity_cubic_ft` SET TAGS ('dbx_business_glossary_term' = 'Refrigerated Capacity (Cubic Feet)');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `store_count_served` SET TAGS ('dbx_business_glossary_term' = 'Store Count Served');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `total_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Total Square Footage');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `twenty_four_hour_operation_flag` SET TAGS ('dbx_business_glossary_term' = '24-Hour Operation Flag');
ALTER TABLE `grocery_ecm`.`supply`.`dc_facility` ALTER COLUMN `wms_system_instance` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Instance');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'vendor_procurement');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract ID');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `banner_id` SET TAGS ('dbx_business_glossary_term' = 'Banner Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `private_label_id` SET TAGS ('dbx_business_glossary_term' = 'Private Label Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `allowance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Allowance Rate Percentage');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Flag');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `category_captain_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Captain Flag');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `chargeback_policy` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Policy');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|pending_renewal');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'blanket_po|spot_buy|master_agreement|dsd_agreement|private_label|consignment');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `cross_dock_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Eligible Flag');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `dispute_resolution_process` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Process');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `edi_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `edi_transaction_types` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Types');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'fob_origin|fob_destination|prepaid|collect|third_party');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `haccp_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Compliance Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `minimum_fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fill Rate Percentage');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `on_time_delivery_sla_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Service Level Agreement (SLA) Percentage');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `organic_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `return_policy` SET TAGS ('dbx_business_glossary_term' = 'Return Policy');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `rfid_tracking_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tracking Required Flag');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `slotting_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Slotting Fee Amount');
ALTER TABLE `grocery_ecm`.`supply`.`supplier_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` SET TAGS ('dbx_subdomain' = 'inbound_logistics');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` SET TAGS ('dbx_association_edges' = 'supply.inbound_shipment,supply.po_line');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` ALTER COLUMN `inbound_shipment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Line - Inbound Shipment Line Id');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Line - Inbound Shipment Id');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Line - Po Line Id');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` ALTER COLUMN `line_shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Line Shipment Status');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Line Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`supply`.`inbound_shipment_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Receiving Variance Quantity');
