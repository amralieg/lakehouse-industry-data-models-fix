# Consumer_Goods Lakehouse Data Model

**v2_ecm** generated using Vibe Modelling Agent on June 23, 2026 at 11:49 PM

This document outlines a vibed Lakehouse data model for the Consumer_Goods business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Distribution](#domain-distribution)
  - [Inventory](#domain-inventory)
  - [Logistics](#domain-logistics)
  - [Manufacturing](#domain-manufacturing)
  - [Procurement](#domain-procurement)
  - [Quality](#domain-quality)
  - [Shared](#domain-shared)
  - [Supply](#domain-supply)
  - [Consumer](#domain-consumer)
  - [Customer](#domain-customer)
  - [Marketing](#domain-marketing)
  - [Product](#domain-product)
  - [Promotion](#domain-promotion)
  - [Sales](#domain-sales)
  - [Finance](#domain-finance)
  - [Regulatory](#domain-regulatory)
  - [Research](#domain-research)
  - [Sustainability](#domain-sustainability)
  - [Workforce](#domain-workforce)
- [Metric Views](#metric-views)

## Output Folder Structure

All artifacts for version **v2_ecm** are organized as follows:

```
v2/ecm/
  schemas/          DDL SQL files (one per domain)
  metrics/          Metric view SQL files (one per domain)
  samples/          Sample data CSV files (one per data product)
  docs/             Excel workbook, model CSV, release notes
  diagram/          DBML schema
  vibes/            Current & next vibes context
  ontology/         RDF/Turtle ontology schema
  model.json        Full model with requirements, metadata, and model data
  readme.md         This file
```

| Folder | Contents |
|---|---|
| `schemas/` | `consumer_goods_<domain>_schema_v2_ecm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `consumer_goods_catalogs_v2_ecm.sql` (catalog-level DDL) |
| `metrics/` | `consumer_goods_<domain>_metrics_v2_ecm.sql` (one file per domain) |
| `docs/` | `consumer_goods_model_v2_ecm.xlsx`, `consumer_goods_model_v2_ecm.csv`, `releasenotes.txt` |
| `diagram/` | `consumer_goods_dbml_v2_ecm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `consumer_goods_rdf_v2_ecm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | ECM (Expanded Coverage Model) |
| Total Domains | 19 |
| Total Subdomains | 70 |
| Total Products | 409 |
| Total Attributes | 13687 |
| Primary Keys | 409 |
| Foreign Keys | 1656 |
| Avg Attributes/Product | 33.5 |
| Metric Views | 217 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Consumer_Goods | consumer-goods | ECM (Expanded Coverage Model) | Consumer Goods is a broad manufacturing industry producing and marketing household, health, hygiene, and personal care products distributed through retail stores, e-commerce platforms, and wholesale channels worldwide. | FDA (U.S. Food and Drug Administration), EPA (U.S. Environmental Protection Agency), CPSC (Consumer Product Safety Commission), EU REACH Regulation (Registration Evaluation Authorization and Restriction of Chemicals), GS1 (Global Standards for Supply Chain), ISO 9001 (Quality Management Systems), ISO 22716 (Good Manufacturing Practices for Cosmetics), IFRA (International Fragrance Association), OECD Guidelines for Testing of Chemicals, FTC (Federal Trade Commission - Advertising and Labeling), OSHA (Occupational Safety and Health Administration), SOX (Sarbanes-Oxley Act - Financial Reporting), GDPR (General Data Protection Regulation), CCPA (California Consumer Privacy Act), ISO 14001 (Environmental Management Systems), FSC (Forest Stewardship Council - Sustainable Sourcing), RSPO (Roundtable on Sustainable Palm Oil) | 2 |

## Business Domains & Subdomains

<a id="domain-distribution"></a>

### Domain: Distribution

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| distribution | operations | 5 | Owns warehouse operations, inventory management, and order fulfillment across distribution centers. Manages inbound/outbound logistics within DCs, put-away/picking/packing processes, cycle counting, FEFO/FIFO inventory rotation, WMS integration (Blue Yonder), OTIF performance, OSA metrics, and DSD execution for direct store delivery channels. | 21 |

**Subdomains:** direct_delivery, facility_infrastructure, inbound_operations, outbound_fulfillment, quality_performance


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| direct_delivery | distribution_dsd_delivery | transactional_data | DSD delivery record from distribution/logistics perspective - proof of delivery, temperature compliance, physical goods movement. SSOT for delivery logistics. Distinct from sales.sales_dsd_delivery which tracks sales/financial aspects. | 46 |
| direct_delivery | distribution_dsd_route | master_data | DSD route definition from a distribution/logistics perspective - vehicle routing, capacity, and delivery scheduling. SSOT for route logistics planning. Distinct from sales.sales_dsd_route which tracks sales execution on the route. | 42 |
| direct_delivery | dsd_delivery_line | transactional_data | Line-level SKU detail for each product delivered or returned during a DSD store visit. Records SKU code, GTIN, lot number, expiry date, ordered quantity, delivered quantity, returned quantity, return reason code, unit selling price, line total value, and shelf placement confirmation. Enables secondary sales capture, OOS identification, and FEFO compliance tracking at the store-SKU level. | 42 |
| facility_infrastructure | distribution_facility | master_data | Physical distribution center or warehouse used for storing and shipping finished goods to customers. SSOT owner for distribution/logistics facility master. Distinct from manufacturing_facility which represents production plants. | 54 |
| facility_infrastructure | distribution_storage_location | master_data | Physical storage bin/slot/rack within a distribution facility (WMS-managed). SSOT for physical DC location layout. Distinct from inventory.inventory_storage_location which is the logical inventory holding location. | 42 |
| facility_infrastructure | dock_appointment | transactional_data | Scheduled dock door appointment record for inbound or outbound truck arrivals at a DC. Captures appointment date/time window, dock door assignment, appointment type (inbound receipt, outbound load, inter-DC transfer), carrier, trailer number, expected SKUs and quantities, appointment status (scheduled, confirmed, arrived, completed, no-show), and actual arrival/departure timestamps. Supports dock scheduling optimization and carrier compliance tracking. | 48 |
| facility_infrastructure | inventory_position | master_data | Current on-hand inventory position at the DC-location-SKU-lot level within distribution center walls. Captures storage location, SKU, lot number, manufacture and expiry dates, quantity on hand, allocated quantity, available-to-pick (ATP) quantity, quarantine quantity, inventory status (available, hold, damaged, expired), and last cycle count date. This is the operational working inventory view for DC execution — distinct from the inventory domain's network-wide planning position which aggregates across all nodes. | 49 |
| inbound_operations | inbound_receipt | transactional_data | Transactional record capturing the physical receipt of goods at a DC from suppliers, manufacturing plants, or inter-DC transfers. Records ASN reference, carrier, trailer/container ID, dock door, receipt date/time, received quantity by SKU/lot, temperature check results, and discrepancy flags. Integrates with SAP WM goods receipt and Blue Yonder WMS inbound processing. Drives inventory on-hand updates and FEFO/FIFO lot registration. | 48 |
| inbound_operations | inbound_receipt_line | transactional_data | Line-level detail for each SKU/lot received within an inbound receipt transaction. Captures SKU code, GTIN, lot number, manufacture date, expiry date, received quantity (cases and eaches), unit of measure, pallet ID, temperature at receipt, and variance from expected ASN quantity. Supports FEFO/FIFO lot registration and discrepancy resolution workflows. | 45 |
| inbound_operations | putaway_task | transactional_data | Operational task record generated by Blue Yonder WMS directing warehouse associates to move goods within the DC — covering both inbound putaway (staging/dock to storage) and internal replenishment (reserve to pick face). Captures source location, target location, SKU, lot, pallet ID, assigned operator, task creation and completion timestamps, task type (inbound putaway, replenishment, cross-dock), movement strategy (FEFO, min/max, kanban, wave-driven), and priority. Tracks DC labor productivity, putaway cycle time, and pick face availability KPIs. | 47 |
| inbound_operations | returns_receipt | transactional_data | Inbound returns processing record capturing goods returned from retailers, DSD customers, or consumers to a DC. Records return authorization number (RA#), originating customer/account, return reason code (damaged, expired, overstock, recall, consumer return), SKU, lot, quantity returned, condition assessment (resalable, destroy, rework), disposition decision, and credit memo reference. Supports reverse logistics, FEFO expiry management, and product recall execution. | 55 |
| outbound_fulfillment | distribution_shipment | transactional_data | Outbound shipment dispatched from a distribution center to a customer/store. SSOT for DC-originated shipment records. Distinct from logistics.logistics_shipment which tracks carrier-level transport execution. | 62 |
| outbound_fulfillment | load_plan | transactional_data | Outbound load plan record defining the assignment of outbound orders and shipments to a specific trailer/vehicle for dispatch from a DC. Captures load plan number, DC, carrier, trailer ID, planned departure datetime, total weight, total cube, pallet configuration, stop sequence, and load plan status (draft, confirmed, loaded, dispatched). Integrates with Blue Yonder WMS load planning and transportation management. | 49 |
| outbound_fulfillment | outbound_order | transactional_data | Master outbound fulfillment order record representing a customer or retailer replenishment request to be fulfilled from a DC. Captures order number, order type (retail replenishment, DSD, e-commerce, inter-DC transfer), customer/account reference, requested ship date, required delivery date, priority, OTIF commitment, and order status lifecycle. Sourced from SAP SD and Salesforce Consumer Goods Cloud order management. | 51 |
| outbound_fulfillment | outbound_order_line | transactional_data | Line-level detail for each SKU within an outbound fulfillment order. Records SKU code, GTIN, ordered quantity, confirmed quantity, allocated quantity, picked quantity, shipped quantity, unit of measure, lot number, expiry date, and line-level OTIF status. Enables order fill rate tracking, short-ship identification, and OSA impact analysis at the SKU-customer level. | 47 |
| outbound_fulfillment | pack_task | transactional_data | Packing task record capturing the consolidation and packaging of picked items into shipping cartons or pallets for outbound dispatch. Records pack station ID, outbound order reference, carton/pallet ID, packed SKUs and quantities, packaging material used, gross weight, dimensions, label applied (GS1-128 / SSCC), pack completion timestamp, and packer operator ID. Drives cartonization and pallet build compliance. | 46 |
| outbound_fulfillment | pick_task | transactional_data | Fulfillment task record covering both picking and packing operations within DC outbound execution. For picking: captures pick list reference, source location, SKU, lot, pick quantity, assigned operator, wave/batch reference, pick accuracy flag, and task timestamps. For packing: captures pack station, carton/pallet ID, packed SKUs and quantities, packaging material, gross weight, dimensions, GS1-128/SSCC label, and packer operator. Supports wave picking, batch picking, zone picking, and cartonization strategies in Blue Yonder WMS. Task_type discriminator distinguishes pick vs pack execution steps. | 47 |
| outbound_fulfillment | wave | master_data | Master reference table for wave. Referenced by wave_id. | 32 |
| quality_performance | distribution_cycle_count | transactional_data | Physical cycle count performed in a distribution center using WMS processes. SSOT for DC-level physical counts. Distinct from inventory.inventory_cycle_count which is the ERP/planning-level count reconciliation. | 42 |
| quality_performance | distribution_offset_allocation | association_data | Carbon offset allocation to distribution operations (warehousing, last-mile delivery). SSOT for distribution carbon offset tracking. Distinct from marketing.marketing_offset_allocation which allocates offsets to marketing activities. | 49 |
| quality_performance | otif_event | transactional_data | OTIF (On Time In Full) performance measurement record for each outbound shipment or DSD delivery against committed service levels. Captures shipment/delivery reference, customer/account, committed vs actual delivery date, on-time flag, committed vs delivered quantity, in-full flag, composite OTIF score, root cause category for failures (DC pick error, inventory shortage, dock delay, carrier issue), and retailer penalty exposure amount. Primary KPI entity for DC operations accountability and retailer scorecard compliance. | 45 |

<a id="domain-inventory"></a>

### Domain: Inventory

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| inventory | operations | 3 | Owns physical inventory positions across the entire distribution network. Manages stock on hand, in-transit inventory, warehouse locations, FEFO/FIFO rotation rules, DIO metrics, OOS/OSA events, VMI replenishment triggers, lot/batch traceability for recall readiness, safety stock levels, and multi-echelon inventory visibility. | 16 |

**Subdomains:** quality_control, replenishment_planning, stock_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| quality_control | inventory_cycle_count | transactional_data | Cycle count activities for inventory accuracy | 19 |
| quality_control | oos_event | transactional_data | Out-of-stock events and tracking | 16 |
| quality_control | recall_event | master_data | Product recall events and affected inventory | 20 |
| replenishment_planning | intransit_shipment | transactional_data | Inventory in transit between locations | 19 |
| replenishment_planning | inventory_replenishment_order | transactional_data | Orders to replenish inventory levels | 19 |
| replenishment_planning | inventory_vmi_agreement | master_data | Vendor-managed inventory agreements | 19 |
| replenishment_planning | reservation | transactional_data | Inventory reservations for orders and allocations | 19 |
| replenishment_planning | safety_stock_policy | master_data | Safety stock policies by SKU and location | 17 |
| stock_management | inventory_storage_location | master_data | Physical storage locations within warehouses | 19 |
| stock_management | lot_batch | master_data | Lot and batch tracking for inventory traceability | 18 |
| stock_management | stock_adjustment | transactional_data | Inventory adjustments and corrections | 21 |
| stock_management | stock_hold | transactional_data | Inventory holds for quality or regulatory reasons | 19 |
| stock_management | stock_movement | transactional_data | All inventory movements and transactions | 19 |
| stock_management | stock_position | master_data | Current inventory position by SKU, location, and lot/batch | 20 |
| stock_management | stock_valuation | transactional_data | Inventory valuation records | 17 |
| stock_management | warehouse | master_data | Warehouse master data | 21 |

<a id="domain-logistics"></a>

### Domain: Logistics

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| logistics | operations | 5 | Owns transportation management, freight optimization, and delivery execution across inbound and outbound networks. Manages carrier contracts, shipment planning, route optimization, freight audit, track-and-trace, 3PL coordination, proof of delivery, cold-chain compliance, and transportation cost tracking. Distinct from distribution (warehouse-focused) — logistics covers inter-facility and last-mile movement. | 25 |

**Subdomains:** asset_registry, carrier_management, financial_settlement, shipment_execution, transportation_planning


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| asset_registry | handling_unit | master_data | Handling unit (pallet, carton, etc.) | 14 |
| asset_registry | transport_unit | master_data | Transport unit (container, trailer, etc.) | 13 |
| asset_registry | vehicle | master_data | Vehicle master data | 17 |
| carrier_management | carrier | master_data | Transportation carrier master data | 26 |
| carrier_management | carrier_contract | master_data | Carrier contract agreements | 20 |
| carrier_management | carrier_performance | transactional_data | Carrier performance metrics | 15 |
| carrier_management | freight_rate | reference_data | Freight rate master | 16 |
| carrier_management | lane | master_data | Transportation lanes between origin and destination | 17 |
| carrier_management | third_party_provider | master_data | Third-party logistics providers (3PL) | 15 |
| financial_settlement | freight_audit_result | transactional_data | Freight audit results | 13 |
| financial_settlement | freight_cost | transactional_data | Freight cost breakdown | 12 |
| financial_settlement | freight_invoice | transactional_data | Freight invoice from carrier | 16 |
| shipment_execution | cold_chain_log | transactional_data | Temperature monitoring log for cold chain shipments | 11 |
| shipment_execution | customs_declaration | transactional_data | Customs declaration for international shipments | 17 |
| shipment_execution | delivery | transactional_data | Delivery record for shipment | 14 |
| shipment_execution | logistics_shipment | transactional_data | Logistics shipment master record | 24 |
| shipment_execution | proof_of_delivery | transactional_data | Proof of delivery documentation | 15 |
| shipment_execution | shipment_item | transactional_data | Line items within a shipment | 14 |
| shipment_execution | shipment_leg | transactional_data | Individual leg of a multi-leg shipment | 17 |
| shipment_execution | tracking_event | transactional_data | Shipment tracking events | 13 |
| shipment_execution | transport_exception | transactional_data | Transportation exceptions and issues | 12 |
| transportation_planning | consolidation | master_data | Shipment consolidation record | 12 |
| transportation_planning | freight_order | transactional_data | Freight order for transportation | 18 |
| transportation_planning | route | transactional_data | Delivery route master | 12 |
| transportation_planning | route_stop | transactional_data | Individual stop on a route | 13 |

<a id="domain-manufacturing"></a>

### Domain: Manufacturing

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| manufacturing | operations | 4 | Owns production planning, scheduling, and execution across manufacturing facilities. Manages production orders, batch records, work orders, MES integration (Siemens Opcenter), line performance (OEE), yield tracking, MRP runs, GMP compliance events, changeover management, and shop floor data collection aligned with ISO 22716 standards. | 16 |

**Subdomains:** facility_infrastructure, order_execution, performance_monitoring, process_definition


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| facility_infrastructure | equipment | master_data | Master reference table for equipment. Referenced by equipment_id. | 56 |
| facility_infrastructure | manufacturing_facility | master_data | Physical manufacturing plant or factory where products are produced. SSOT owner for production facility master. Distinct from distribution_facility which represents warehouses/DCs. | 47 |
| facility_infrastructure | production_line | master_data | Master record for each physical production line within a manufacturing facility. Captures line code, line name, facility reference, line type (filling, blending, packaging, assembly), design speed (units/hour), nominal OEE target, GMP classification, MES asset tag (Siemens Opcenter), changeover time standard (minutes), and current operational status. Enables OEE benchmarking, scheduling capacity allocation, and MES integration at the line level. | 46 |
| facility_infrastructure | work_center | master_data | Master record for individual work centers (machines, stations, cells) within a production line. Captures work center code, description, work center type (mixing vessel, filling machine, labeler, capper, palletizer), rated capacity, standard cycle time, maintenance class, MES equipment ID (Siemens Opcenter), GMP equipment qualification status (IQ/OQ/PQ), and calibration due date. Supports MRP capacity planning, scheduling, and equipment qualification tracking per ISO 22716. | 46 |
| order_execution | batch_record | transactional_data | Electronic batch manufacturing record (eBMR) capturing the complete GMP-compliant execution history for a production batch. Captures batch number, production order reference, SKU, batch size, manufacturing date, expiry date (FEFO), facility, production line, batch status (in-process, released, rejected, quarantine, recalled), GMP deviation flag, electronic signature records, yield percentage, and Veeva Vault document reference. SSOT for GMP batch traceability per ISO 22716 and FDA 21 CFR Part 211. | 55 |
| order_execution | planned_order | transactional_data | Production planning record representing the complete planning pipeline from S&OP/IBP through MRP execution to production order conversion. Encompasses both Master Production Schedule (MPS) entries (planned quantities by SKU/facility/period with schedule versioning) and MRP-generated planned orders (system-proposed production or procurement proposals). Captures planned order ID, order type (MPS, MRP planned, CBP), SKU, plant, MRP run reference, planned quantity, scheduled start/finish dates, planning period (week/month), schedule version, S&OP cycle reference, IBP plan version, firming indicator, schedule status (draft, firmed, released, converted, deleted), exception message code, planner ID, and conversion status. SSOT for MRP exception management, MPS governance, and the complete production planning pipeline from demand signal through to production order creation. | 51 |
| order_execution | production_confirmation | transactional_data | Shop floor execution and confirmation record capturing the complete lifecycle of each manufacturing operation within a production order — from assignment and scheduling through actual execution and final confirmation. Captures work order number, parent production order reference, operation number, work center, assigned operator, scheduled start/end, actual start/end, confirmation type (partial, final), confirmed yield quantity, confirmed scrap quantity, actual setup/machine/labor time, operation status (open, in-progress, completed, cancelled), posting date, and MES transaction reference (Siemens Opcenter). SSOT for granular shop floor execution tracking, labor confirmation, production order settlement, and OEE calculation. Subsumes discrete work order assignment data. | 49 |
| order_execution | production_order | transactional_data | Core transactional record representing a manufacturing production order issued to produce a specific SKU quantity at a facility. Captures order number, order type (PP01 standard, PP03 rework), SKU reference, plant, production line, scheduled start/finish dates, actual start/finish dates, order quantity, confirmed quantity, scrap quantity, order status (created, released, partially confirmed, technically complete, closed), MRP controller, and cost object. SSOT for production execution tracking in SAP S/4HANA PP. | 58 |
| performance_monitoring | changeover | transactional_data | Changeover execution record capturing each line or work center changeover event between production runs. Captures changeover ID, facility, production line, from-SKU, to-SKU, changeover type (flavor, format, size, cleaning), scheduled start/end, actual start/end, actual duration (minutes), standard duration (minutes), variance (minutes), changeover status (planned, in-progress, completed), operator ID, and GMP cleaning verification flag. Supports SMED improvement programs and scheduling optimization. | 37 |
| performance_monitoring | downtime_event | transactional_data | Individual downtime event record capturing each unplanned or planned stoppage on a production line or work center. Captures event ID, facility, production line, work center, downtime start/end timestamps, duration (minutes), downtime category (mechanical failure, changeover, material shortage, operator absence, planned maintenance, cleaning/sanitation), root cause code, responsible department, production order impacted, and corrective action taken. Feeds OEE loss analysis and maintenance work order creation. | 41 |
| performance_monitoring | gmp_event | transactional_data | GMP compliance event record capturing deviations, non-conformances, and critical control point (CCP) observations during manufacturing. Captures event ID, batch record reference, facility, event type (deviation, OOS result, environmental monitoring excursion, equipment failure, process parameter breach), event severity (critical, major, minor), event description, detection timestamp, GMP regulation reference (ISO 22716, FDA 21 CFR 211), CAPA reference, event status (open, under investigation, closed), and electronic signature of approver. SSOT for GMP compliance event management. | 51 |
| performance_monitoring | oee_record | transactional_data | Overall Equipment Effectiveness (OEE) measurement record captured per production line per shift. Captures OEE record ID, facility, production line, shift date, shift number, planned production time (minutes), downtime (minutes), speed loss (minutes), quality loss (minutes), availability rate, performance rate, quality rate, composite OEE percentage, total units produced, total units rejected, and MES data source (Siemens Opcenter). SSOT for line performance analytics and continuous improvement programs. | 46 |
| performance_monitoring | process_parameter | transactional_data | In-process control (IPC) and critical process parameter (CPP) record capturing measured process variables during manufacturing operations. Captures parameter record ID, batch record reference, work order reference, work center, parameter name (temperature, pH, viscosity, fill weight, torque, pressure), parameter type (CPP, CQA, IPC), target value, lower control limit, upper control limit, actual measured value, unit of measure, measurement timestamp, measurement method, operator ID, and out-of-specification (OOS) flag. Supports GMP process validation and real-time SPC monitoring. | 42 |
| performance_monitoring | yield_record | transactional_data | Yield tracking record capturing input vs. output quantities at each stage of the manufacturing process for a production order or batch. Captures yield record ID, production order reference, batch number, routing operation, work center, input quantity, output quantity, scrap quantity, rework quantity, theoretical yield percentage, actual yield percentage, yield variance, unit of measure, and yield loss reason code. Enables yield variance analysis, COGS accuracy, and GMP batch record reconciliation. | 43 |
| process_definition | manufacturing_bom | master_data | Bill of Materials master record (header + component lines) defining the complete material structure for each finished good or semi-finished SKU. Header captures BOM number, BOM type (production, co-product, phantom), base quantity, unit of measure, validity dates, PLM system reference, and BOM status. Component lines capture item number, material reference (raw material, packaging, semi-finished), component quantity per base quantity, scrap factor percentage, item category (stock, non-stock, phantom), INCI name for cosmetic ingredients, allergen flag, hazardous material flag, and component validity dates. SSOT for MRP explosion, production order material requirements, COGS calculation, and regulatory ingredient disclosure per FDA/EU REACH. This is the single authoritative source for all BOM component data — no separate component entity exists. | 44 |
| process_definition | routing | master_data | Production routing master (header + operation steps) defining the complete manufacturing process sequence for a finished or semi-finished SKU. Header captures routing number, routing type (standard, reference, rate), base quantity, plant, validity dates, and total standard lead time. Operation steps capture operation number, work center assignment, standard values (setup time, machine time, labor time), control key (internal processing, external processing, milestone), yield quantity, scrap percentage, GMP critical step flag, and IPC checkpoint flag. SSOT for production scheduling, capacity planning, standard cost calculation, and GMP batch record generation per ISO 22716. This is the single authoritative source for all routing operation data — no separate operation entity exists. Aligned with SAP PP Routing master. | 43 |

<a id="domain-procurement"></a>

### Domain: Procurement

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| procurement | operations | 6 | Owns sourcing, supplier management, and purchase order execution for raw materials, packaging, and indirect goods. Manages supplier master data, contracts, RFQs, purchase requisitions, PO lifecycle, goods receipt, invoice verification, MOQ terms, SDS documentation, supplier performance scorecards, VMI programs, and sustainable sourcing initiatives (FSC, RSPO). | 26 |

**Subdomains:** inventory_agreements, purchase_orders, receipt_invoice, service_procurement, sourcing_events, supplier_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| inventory_agreements | procurement_vmi_agreement | master_data | Vendor managed inventory agreements | 11 |
| inventory_agreements | procurement_vmi_agreement2 |  |  | 47 |
| inventory_agreements | vmi_agreement_type |  | Types of VMI agreements | 9 |
| purchase_orders | po_confirmation | transactional_data | Supplier confirmations of purchase orders | 9 |
| purchase_orders | po_line | transactional_data | Purchase order line items | 13 |
| purchase_orders | price_condition | master_data | Pricing conditions and discounts | 9 |
| purchase_orders | purchase_order | transactional_data | Purchase orders to suppliers | 13 |
| purchase_orders | purchase_requisition | transactional_data | Internal purchase requests | 10 |
| receipt_invoice | delivery_schedule | transactional_data | Scheduled deliveries from suppliers | 9 |
| receipt_invoice | goods_receipt | transactional_data | Receipt of goods from suppliers | 11 |
| receipt_invoice | invoice_line | transactional_data | Supplier invoice line items | 11 |
| receipt_invoice | supplier_invoice | transactional_data | Invoices from suppliers | 12 |
| service_procurement | service | master_data | Master data for procured services | 11 |
| service_procurement | service_entry_sheet | master_data | Service entry sheets for service procurement | 11 |
| service_procurement | service_entry_sheet_line | master_data | Service entry sheet line items | 11 |
| sourcing_events | rfq | transactional_data | Request for quotation | 9 |
| sourcing_events | rfq_response | transactional_data | Supplier responses to RFQs | 10 |
| sourcing_events | sourcing_event | transactional_data | Strategic sourcing events | 11 |
| sourcing_events | spend_category | reference_data | Procurement spend categories | 9 |
| supplier_management | approved_supplier_list | master_data | Approved suppliers for materials | 10 |
| supplier_management | contract_line | master_data | Line items in supplier contracts | 12 |
| supplier_management | supplier | master_data | Master record for suppliers providing goods and services | 18 |
| supplier_management | supplier_contract | master_data | Contracts with suppliers | 14 |
| supplier_management | supplier_qualification | transactional_data | Supplier qualification records | 10 |
| supplier_management | supplier_scorecard | transactional_data | Supplier performance metrics | 11 |
| supplier_management | supplier_site | master_data | Physical locations for suppliers | 16 |

<a id="domain-quality"></a>

### Domain: Quality

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| quality | operations | 3 | Owns quality assurance, quality control, and GMP compliance data across the product lifecycle. Manages QC inspection results, non-conformance records, CAPA processes, batch release decisions, stability studies, certificate of analysis, GMP audit findings, supplier quality assessments, product complaints, and regulatory hold events. Integrates with SAP QM and Veeva Vault. | 24 |

**Subdomains:** compliance_management, product_certification, testing_operations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| compliance_management | audit_checklist | master_data | Standardized checklist of audit questions and criteria used during quality audits | 16 |
| compliance_management | audit_finding | transactional_data | Specific non-conformance or observation identified during a quality audit requiring corrective action | 22 |
| compliance_management | audit_program | master_data | Planned schedule and scope of quality audits for facilities, suppliers, and processes | 18 |
| compliance_management | capa | transactional_data | Corrective and Preventive Action record to address root causes of quality issues and prevent recurrence | 27 |
| compliance_management | change_control | transactional_data | Formal change management record for modifications to products, processes, or quality systems | 27 |
| compliance_management | gmp_audit | transactional_data | Good Manufacturing Practice audit assessing compliance with quality system regulations and standards | 24 |
| compliance_management | nonconformance | transactional_data | Record of quality defect, deviation, or non-compliance event requiring investigation and corrective action | 29 |
| compliance_management | notification | transactional_data | Quality event notification alerting stakeholders of issues, deviations, or required actions | 21 |
| compliance_management | regulatory_hold | transactional_data | Quality or regulatory hold preventing release or distribution of product pending investigation or approval | 25 |
| compliance_management | supplier_assessment | transactional_data | Quality evaluation of supplier performance, capability, and compliance with quality standards | 25 |
| product_certification | batch_release | transactional_data | Final quality approval authorizing a manufactured batch for distribution and sale | 23 |
| product_certification | certificate_of_analysis | transactional_data | Official document certifying that a batch meets all quality specifications and regulatory requirements | 25 |
| product_certification | product_complaint | transactional_data | Customer or consumer complaint regarding product quality, safety, or performance requiring investigation | 29 |
| product_certification | quality_stability_study | master_data | Long-term study monitoring product quality attributes over time under defined storage conditions | 25 |
| product_certification | stability_result | transactional_data | Individual timepoint measurement from a stability study tracking product degradation over time | 22 |
| testing_operations | control_chart | master_data | Statistical process control chart monitoring quality characteristic variation over time | 23 |
| testing_operations | inspection_lot | transactional_data | Specific batch or lot of material/product subject to quality inspection per the inspection plan | 24 |
| testing_operations | inspection_plan | master_data | Master plan defining inspection procedures, sampling strategies, and acceptance criteria for materials, in-process, and finished goods | 22 |
| testing_operations | inspection_result | transactional_data | Individual test or inspection characteristic result recorded during quality inspection | 23 |
| testing_operations | lab_test_request | transactional_data | Request for laboratory testing of samples to verify quality specifications | 21 |
| testing_operations | laboratory | master_data | Quality control or analytical laboratory facility performing product testing | 23 |
| testing_operations | sample | master_data | Physical sample collected for quality testing and analysis | 21 |
| testing_operations | specification | master_data | Quality specification defining acceptance criteria, test methods, and limits for materials and products | 21 |
| testing_operations | usage_decision | transactional_data | Disposition decision for inspected lot: accept, reject, rework, or conditional release | 18 |

<a id="domain-shared"></a>

### Domain: Shared

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| shared | operations | 2 | Shared domain (auto-created for table region) | 6 |

**Subdomains:** geographic_hierarchy, reference_standards


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| geographic_hierarchy | country |  | Country master reference data | 19 |
| geographic_hierarchy | region | master_data | Geographic region hierarchy for market and operational segmentation | 30 |
| reference_standards | calendar |  | Fiscal and operational calendar reference | 16 |
| reference_standards | currency |  | Currency master reference data | 12 |
| reference_standards | language |  | Language master reference data | 10 |
| reference_standards | unit_of_measure |  | Unit of measure master reference data | 12 |

<a id="domain-supply"></a>

### Domain: Supply

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| supply | operations | 4 | Owns end-to-end supply chain planning and orchestration including demand planning, supply planning, inventory optimization, S&OP/IBP processes, DRP execution, safety stock targets, ATP/CTP calculations, supply network design, demand sensing, forecast accuracy tracking, and supply risk management. Integrates with SAP IBP. | 23 |

**Subdomains:** demand_planning, inventory_strategy, network_configuration, supply_execution


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| demand_planning | consensus_demand | transactional_data | Transactional record capturing the final consensus demand volume agreed upon during the S&OP demand review for each SKU/location/planning period. Stores statistical forecast input, commercial overlay, marketing event uplift, new product launch volume, consensus quantity, variance to statistical baseline, approver, and S&OP cycle reference. Represents the single agreed demand signal passed to supply planning. | 46 |
| demand_planning | demand_event | master_data | Master entity capturing planned business events that create demand uplift or downlift adjustments to the statistical forecast. Includes trade promotions, new product launches (with ramp-up volume curves, cannibalization impacts, and supply readiness status), product discontinuations, price changes, seasonal events, and market expansion activities. Stores event type, affected SKUs, affected customers/channels, volume impact (units and percentage), event start/end date, confidence level, initial stocking quantity (for launches), launch market/channel scope, and source system reference. Provides the causal layer that explains forecast adjustments beyond statistical extrapolation and bridges R&D/product NPD pipeline with supply chain readiness planning. | 45 |
| demand_planning | demand_plan | master_data | Core master entity representing the demand plan across all versions, stages, and consensus outcomes within the S&OP/IBP cycle for each SKU/location/channel/planning period combination. Each record represents a specific version-point: captures version name, version type (statistical baseline/field sales overlay/marketing-adjusted/consensus/final approved), planning cycle reference, created-by persona, approval status, effective date range, planning bucket (weekly/monthly), statistical baseline quantity, commercial overlay, marketing event uplift, new product launch volume, consensus quantity, variance to statistical baseline, channel disaggregation, promotional overlays, and lifecycle stage. The consensus version represents the single agreed demand signal passed to supply planning. Enables forecast accuracy benchmarking across versions. Sourced from SAP IBP Demand Planning module. | 46 |
| demand_planning | forecast_accuracy | transactional_data | Transactional record capturing forecast accuracy measurements and demand sensing corrections for each SKU/location/planning period. Stores accuracy metrics (MAPE, WMAPE, bias, FA%, forecast error), actuals vs forecast volumes, measurement period, benchmark targets, and near-term demand sensing signals (POS data, syndicated feeds from Nielsen IQ, TradeEdge secondary sales). Captures signal source, sensing horizon, sensed quantity, confidence score, and uplift/downlift versus statistical forecast. Supports both cycle-close accuracy measurement and short-horizon demand correction within SAP IBP. Enables continuous improvement of statistical models and demand sensing algorithms. | 46 |
| demand_planning | forecast_version | master_data | Tracks each named version or snapshot of the demand forecast within the IBP/S&OP cycle (e.g., statistical baseline, field sales overlay, marketing-adjusted, consensus, final approved). Captures version name, version type, planning cycle reference, created-by persona, approval status, and effective date range. Enables forecast accuracy benchmarking across versions. | 44 |
| demand_planning | sop_cycle | master_data | Master entity representing each S&OP/IBP planning cycle instance (monthly cadence). Captures cycle name, planning month, cycle phase (statistical forecast, demand review, supply review, pre-S&OP, executive S&OP), phase status, cycle owner, key milestones, and sign-off records. Provides the governance framework for all demand and supply planning activities within the cycle. | 47 |
| inventory_strategy | inventory_policy | master_data | Master entity defining inventory policy parameters, safety stock calculations, service level commitments, and OTIF targets for each SKU/location node in the supply network. Captures safety stock target and calculated quantities (days of supply, units, calculation method, demand variability, lead time variability, service level input, calculated vs approved SS units, effective date, review status), reorder point, min/max levels, cycle stock target, replenishment method (MRP/DRP/VMI), review cycle, service level targets (fill rate %, on-time delivery %, OTIF composite %), customer/channel-level OTIF commitments, retailer-mandated target flags, penalty clause indicators, and measurement windows. Owned by supply planning; consumed by distribution and manufacturing execution. | 46 |
| inventory_strategy | inventory_projection | transactional_data | Transactional record capturing the forward-looking inventory projection (projected available balance) for each SKU/location/date combination as output from the supply planning run. Stores projected on-hand, projected on-order, projected demand, projected receipts, days-of-supply projection, OOS risk flag, excess inventory flag, and planning run reference. Distinct from physical inventory positions (owned by inventory domain). | 40 |
| inventory_strategy | otif_target | master_data | Master entity defining On-Time-In-Full (OTIF) service level targets by customer, channel, and product category. Captures on-time delivery target (%), in-full fill rate target (%), OTIF composite target (%), measurement window, penalty clause flag, retailer-mandated target flag, and effective date range. Provides the service level commitment baseline for supply planning and distribution execution. | 43 |
| inventory_strategy | safety_stock | transactional_data | Transactional record capturing the calculated and approved safety stock quantity for each SKU/location/time-period combination. Stores calculation method (statistical, days-of-supply, manual override), demand variability, lead time variability, service level input, calculated SS units, approved SS units, effective date, and review status. Distinct from inventory_policy (policy target) as this captures the actual calculated output. | 49 |
| inventory_strategy | sku_planning_param | master_data | Master entity storing SKU-level planning parameters used in demand and supply planning calculations. Captures planning horizon, lot size, minimum order quantity (MOQ), shelf life (days), FEFO/FIFO flag, planning strategy (make-to-stock/make-to-order), ABC/XYZ classification, demand pattern type, seasonality index, and IBP planning group assignment. Distinct from product master (owned by product domain) as this captures supply-planning-specific parameters. | 52 |
| network_configuration | constraint | master_data | Master entity capturing identified supply constraints at each node in the supply network for a given planning horizon. Stores constraint type (capacity, material, labor, regulatory, supplier), constrained resource identifier, constrained SKU or product family, constraint quantity (available vs required), constraint start/end date, severity level, mitigation action, resolution status, owning planner, and allocation method applied during shortage (proportional, priority-based, fair share). Used in constrained supply planning runs within IBP to drive supply allocation decisions and exception generation. | 43 |
| network_configuration | network_lane | master_data | Master entity defining the sourcing lane between two supply network nodes (source-destination pair). Captures lane type (production, transfer, external procurement), primary/secondary sourcing priority, standard lead time, transportation lead time, minimum order quantity (MOQ), lot size, and active status. Used by DRP and IBP to determine replenishment routing. | 43 |
| network_configuration | network_node | master_data | Master entity representing each node in the supply network (manufacturing plant, regional DC, forward DC, co-manufacturer, 3PL site). Captures node type, geographic location, capacity class, lead time to downstream nodes, sourcing rules, and active status. Forms the backbone of the supply network design used in IBP supply planning and DRP. | 46 |
| network_configuration | risk_register | master_data | Master entity tracking identified supply chain risks that could disrupt supply continuity. Captures risk category (supplier, logistics, geopolitical, regulatory, natural disaster), affected SKUs/nodes, probability score, impact severity, risk owner, mitigation plan, contingency stock requirement, and risk status. Supports supply risk management and business continuity planning. | 45 |
| supply_execution | atp_record | transactional_data | Transactional record capturing the Available-to-Promise (ATP) and Capable-to-Promise (CTP) calculation results for each SKU/location/date combination. Stores confirmed ATP quantity, CTP quantity, cumulative ATP, demand pegging reference, supply pegging reference, calculation timestamp, and ATP method (simple, cumulative, multi-level). Consumed by sales order management for order promising. | 38 |
| supply_execution | atp_rule | master_data | Master reference table for atp_rule. Referenced by atp_rule_id. | 28 |
| supply_execution | drp_run | master_data | Master reference table for drp_run. Referenced by drp_run_id. | 36 |
| supply_execution | plan | master_data | Core master entity representing the constrained and unconstrained supply plan for each SKU/plant/DC combination. Captures planned production quantities, planned replenishment orders, supply source, planning horizon, constraint flags, and IBP supply planning run metadata. Sourced from SAP IBP Supply Planning module. | 51 |
| supply_execution | planning_exception | transactional_data | Transactional record capturing supply planning exceptions and alerts generated during IBP supply planning and DRP execution runs. Stores exception type (OOS risk, excess inventory, late replenishment, unmet demand, capacity breach), affected SKU/location, exception severity, exception date, recommended action, planner assignment, resolution status, resolution notes, and originating run reference. Drives exception-based planning workflows and planner workbench prioritization. | 48 |
| supply_execution | planning_period | master_data | Master reference table for planning_period. Referenced by planning_period_id. | 25 |
| supply_execution | planning_run | master_data | Master reference table for planning_run. Referenced by planning_run_id. | 32 |
| supply_execution | supply_replenishment_order | transactional_data | Supply network replenishment order for inter-node stock transfers driven by DRP/MRP planning. SSOT for network-level supply replenishment. Distinct from inventory.inventory_replenishment_order which is location-level restocking. | 45 |

<a id="domain-consumer"></a>

### Domain: Consumer

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| consumer | business | 5 | SSOT for all end consumers, shoppers, households, and loyalty program members in B2C and DTC channels. Manages consumer profiles, preferences, purchase history, segmentation, NPS scores, CLTV calculations, consent and privacy preferences (GDPR/CCPA), and contact data. Supports CRM, personalization, and consumer engagement programs. | 28 |

**Subdomains:** analytics_insights, identity_management, loyalty_programs, preference_engagement, privacy_governance


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| analytics_insights | cltv_record | master_data | Customer lifetime value calculation record for a shopper, including predicted revenue, churn probability, and model metadata. | 45 |
| analytics_insights | nps_response | transactional_data | A Net Promoter Score survey response submitted by a consumer. | 41 |
| analytics_insights | referral | transactional_data | A consumer referral record tracking referrer, referee, and referral reward status. | 49 |
| analytics_insights | segment | reference_data | A consumer segment definition used for targeting, personalization, and analytics. | 43 |
| analytics_insights | segment_membership | association_data | A record of a consumer's membership in a segment, including assignment method and confidence score. | 45 |
| identity_management | address | master_data | Physical or mailing address associated with a consumer shopper, including validation and geocoding metadata. | 45 |
| identity_management | dtc_order | transactional_data | A direct-to-consumer order placed by a shopper through a brand-owned channel. | 51 |
| identity_management | dtc_order_line | transactional_data | A line item within a direct-to-consumer order, capturing SKU, quantity, pricing, and fulfillment details. | 52 |
| identity_management | dtc_return | transactional_data | A return request initiated by a consumer for a DTC order, including disposition and refund details. | 51 |
| identity_management | household | master_data | A household entity grouping one or more shoppers sharing a residence, used for panel and loyalty analytics. | 44 |
| identity_management | identity_link | master_data | A cross-system identity linkage record connecting a consumer identity across multiple source systems. | 45 |
| identity_management | panel | master_data | A consumer research panel member record capturing demographic and participation attributes. | 57 |
| identity_management | research_participation | association_data | A record of a consumer's participation in a research study or consumer test. | 52 |
| identity_management | shopper | master_data | A consumer shopper master record capturing identity, contact, consent, and loyalty attributes. | 42 |
| identity_management | subscription | master_data | A recurring subscription held by a consumer for a product or service. | 43 |
| identity_management | survey | master_data | A consumer survey definition associated with a brand or campaign. | 48 |
| loyalty_programs | loyalty_account | master_data | A loyalty program account held by a shopper, tracking points balance, tier, and enrollment details. | 46 |
| loyalty_programs | loyalty_program | master_data | A loyalty program definition including tiers, earn rules, and redemption policies. | 38 |
| loyalty_programs | loyalty_tier | master_data | A tier level within a loyalty program defining qualification thresholds and benefits. | 33 |
| loyalty_programs | loyalty_transaction | transactional_data | A points earn or redemption transaction within a loyalty account. | 44 |
| preference_engagement | communication_preference | master_data | Consumer communication channel preferences including opt-in/opt-out status per channel and brand. | 51 |
| preference_engagement | interaction | transactional_data | A consumer interaction event such as a call, chat, email, or in-store visit with the brand. | 52 |
| preference_engagement | preference | master_data | A consumer preference record capturing product, channel, and communication preferences. | 44 |
| preference_engagement | preference_center | master_data | A preference center record capturing a consumer's opt-in/opt-out choices across communication channels. | 47 |
| privacy_governance | consent_event | transactional_data | Immutable audit event capturing a change in consumer consent status, including legal basis and proof of consent. | 44 |
| privacy_governance | consent_record | master_data | Current consent record for a consumer covering all consent types, legal bases, and regulatory jurisdictions. | 45 |
| privacy_governance | consent_session | master_data | A web or app session during which consent was captured or updated for a consumer. | 37 |
| privacy_governance | data_subject_request | master_data | A formal data subject request (DSR) submitted by a consumer under GDPR, CCPA, or similar regulation. | 38 |

<a id="domain-customer"></a>

### Domain: Customer

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| customer | business | 0 | SSOT for B2B trade customer and retail account master data. Owns retailer, distributor, wholesaler, and foodservice account profiles, account hierarchies, ACV/TDP metrics, EDI trading partner configurations, VMI agreements, and SLA terms. Distinct from consumer (B2C) — this domain serves the trade channel. | 1 |

**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
|  | channel_classification | reference_data | Reference taxonomy defining the trade channel hierarchy used to classify trade accounts and retail stores. Captures channel code, channel name, channel tier (primary: retail, foodservice, wholesale, DTC; secondary: grocery, mass, club, drug, convenience, e-commerce, QSR, institutional), channel description, applicable region, and active status. Used as a standardized classification across sales, promotion, and distribution domains. | 33 |

<a id="domain-marketing"></a>

### Domain: Marketing

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| marketing | business | 4 | Owns brand management, consumer engagement campaigns, digital marketing, and market research. Manages campaign planning, media spend, creative assets, influencer partnerships, social media engagement, marketing attribution, brand health metrics, SOV (Share of Voice), SOM, consumer sentiment analysis, and Nielsen IQ panel insights. | 27 |

**Subdomains:** brand_management, campaign_execution, partner_relationships, performance_analytics


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| brand_management | brand_assignment | association_data | This association captures the operational relationship between trade accounts and brands. It records when a brand is launched at a specific trade account, its current status, and whether it is the primary brand for shelf planning.. Existence Justification: Brands are allocated to trade accounts for shelf planning and promotional purposes. Each trade account can carry multiple brands, and each brand can be sold through multiple trade accounts. The assignment is actively managed and includes attributes such as launch date, status, and a primary‑brand flag. | 41 |
| brand_management | brand_distribution_allocation | association_data | This association captures the allocation of brands to supply network nodes, including the percentage of inventory allocated, primary flag, and the effective date range for each allocation.. Existence Justification: Brands are actively allocated to supply network nodes with defined allocation percentages, primary flags, and effective date ranges. The planning team manages these allocations, and a single brand can be stocked at many nodes while a node can carry many brands. | 53 |
| brand_management | consumer_segment | reference_data | Reference master for consumer segmentation definitions used in targeting and campaign planning. Captures segment name, segmentation model (behavioral, psychographic, demographic, needs-based), segment size estimate, key characteristics, target channel affinity, brand affinity, and strategic priority tier. Used to align campaign targeting across digital, retail, and DTC channels. Distinct from consumer profile (owned by consumer domain). | 45 |
| brand_management | marketing_brand | master_data | Brand entity from marketing perspective - brand equity, positioning, campaigns, and consumer perception. SSOT for brand marketing strategy. Distinct from product.product_brand which is the product portfolio/PLM brand assignment. | 48 |
| brand_management | marketing_budget | master_data | Marketing department budget for campaigns, media, and brand activities. SSOT for marketing spend planning. Distinct from finance.finance_budget which is the corporate-level financial budget. | 48 |
| brand_management | marketing_offset_allocation | association_data | Carbon offset allocation to marketing activities (events, campaigns, media production). SSOT for marketing carbon offset tracking. Distinct from distribution.distribution_offset_allocation which covers distribution operations. | 46 |
| campaign_execution | campaign | master_data | Master record for each marketing campaign executed by Consumer Goods. Captures campaign name, type (ATL, BTL, digital, shopper, influencer, integrated), objective, target audience, brand association, channel mix, planned vs. actual media spend, campaign start/end dates, creative concept, campaign status, and owning brand/category. Sourced from Salesforce Consumer Goods Cloud and internal campaign management systems. | 44 |
| campaign_execution | campaign_assignment | association_data | This association captures the staffing of marketing campaigns. Each record links one campaign to one employee and stores attributes that belong to the assignment such as role, allocation percentage, and assignment dates.. Existence Justification: A marketing campaign is staffed by multiple employees (e.g., planners, creatives, analysts) and an employee can be assigned to multiple campaigns over time. The assignment is actively managed, with role, allocation percentage, and start/end dates captured for each employee‑campaign pairing. | 56 |
| campaign_execution | campaign_flight | transactional_data | Transactional record of campaign execution at the flight level, capturing performance metrics across ALL channels (digital, TV, OOH, print, social, search, programmatic) at the campaign-channel-market-date grain. Defines scheduled media run dates, channel, market/geography, budget allocation, and flight-level performance targets. Captures planned and actual impressions, clicks, CTR, video views, view-through rate, conversions, CPC, CPA, ROAS, reach, frequency, GRPs (traditional), and platform-specific metrics (Meta, Google, TikTok, programmatic DSP). A single campaign may have multiple flights across different channels or geographies. Sourced from digital ad platform APIs, agency post-buy reports, and media monitoring systems. Serves as the unified granular performance record for omnichannel campaign measurement. | 49 |
| campaign_execution | campaign_inventory_allocation | association_data | This association product represents the allocation relationship between a marketing campaign and a stock position. It captures the percentage of inventory allocated and the start/end dates of the allocation period for each link.. Existence Justification: A marketing campaign allocates portions of inventory at specific locations to support promotional activities. Each allocation is defined by a percentage and a time window, and the same inventory can be allocated to multiple campaigns over time, while a campaign can allocate to many stock positions. | 36 |
| campaign_execution | campaign_submission_link | association_data | This association product represents the contractual link between a marketing campaign and a regulatory submission. It captures claim_type, approval_status, and approval_date that are specific to each campaign‑submission pairing.. Existence Justification: In Consumer Goods, a marketing campaign often requires regulatory submissions to obtain claim approvals. A single campaign may depend on several submissions (e.g., different claims or regions) and a single submission can be used to support multiple campaigns. | 40 |
| campaign_execution | creative_asset | master_data | Master record for each creative asset and content item (TV commercial, digital banner, social post, print ad, packaging visual, influencer brief, video, blog post, email template) used in marketing campaigns or published on owned/earned channels. Captures asset name, format, dimensions, file type, brand, campaign association, creative concept, approval status, rights/usage restrictions, expiry date, DAM reference ID, and content publishing metadata (planned publish date, actual publish date, publishing channel, content status, content type, target audience segment, content owner). Serves as the unified creative and content management record supporting brand compliance, creative reuse tracking, DAM integration, and coordinated omnichannel content calendar planning. No separate content calendar product exists — all scheduling and publishing metadata lives here. | 49 |
| campaign_execution | event_participation | association_data | Association representing the participation of employees in marketing events, capturing the employee's role and the start/end dates of their involvement for each event.. Existence Justification: Marketing events are staffed by multiple employees (coordinators, hosts, presenters) and each employee can be assigned to many events over time. The business actively records each employee's role and the dates they participated in the event for planning, reporting, and post‑event analysis. | 53 |
| campaign_execution | influencer | master_data | Master record for influencer and content creator partners engaged by Consumer Goods, including full engagement/activation history. Captures influencer handle, platform(s), follower count, engagement rate, audience demographics, content category, tier (nano, micro, macro, mega), brand safety score, contract status, preferred contact, and historical campaign participation. Engagement detail records capture: engagement type (sponsored post, product seeding, brand ambassador, event appearance), campaign association, contracted deliverables, content submission dates, approval status, agreed fee, actual fee paid, platform, post URLs, reach, impressions, engagement metrics, and content performance. Serves as the SSOT for influencer partner identity, roster management, and all activation history. No separate engagement product exists — all engagement transactional data lives here as detail records. | 48 |
| campaign_execution | marketing_event | master_data | Marketing event such as product launches, brand activations, sponsorships, and experiential marketing. SSOT for marketing event management. Distinct from promotion.promotion_event which is a trade promotion execution event. | 49 |
| campaign_execution | media_plan | master_data | Formal media plan document capturing planned media investments across channels (TV, digital, OOH, print, social, search, programmatic) for a brand or campaign. Includes planned impressions, GRPs, reach, frequency, CPM, total planned spend, agency, media owner, market, and planning period. Serves as the authoritative pre-buy record for media investment decisions. | 43 |
| campaign_execution | media_spend | transactional_data | Transactional record of actual media spend incurred per channel, campaign, brand, and time period. Captures invoiced spend, committed spend, variance to plan, media owner, agency fees, working vs. non-working spend classification, and cost-per-metric actuals (CPM, CPC, CPV). Sourced from agency billing systems and reconciled against media plan commitments. | 49 |
| partner_relationships | agency | master_data | Master record for marketing agency partners engaged by Consumer Goods. Captures agency name, agency type (creative, media, digital, PR, shopper, research, influencer), holding group, scope of services, retainer vs. project basis, primary contact, contract status, performance rating, markets served, assigned brands, and fee structure. Serves as the SSOT for agency partner identity and roster management within the marketing domain. Enables agency performance benchmarking and spend consolidation analysis. | 45 |
| partner_relationships | sponsorship | master_data | Master record for brand sponsorship agreements with sports, entertainment, events, or cultural properties. Captures sponsorship name, property type (sports team, event, festival, celebrity), brand, sponsorship tier, contract value, activation rights, exclusivity terms, territory, contract start/end dates, renewal option, and performance obligations. Enables sponsorship portfolio management and ROI tracking. | 46 |
| performance_analytics | attribution | transactional_data | Marketing attribution record linking consumer purchase or conversion events to contributing marketing touchpoints (campaign, channel, creative) using a defined attribution model (last-touch, first-touch, linear, data-driven, MTA). Captures attributed revenue, attributed conversions, attribution model type, touchpoint sequence, channel contribution weight, and brand. Enables ROI measurement across the marketing mix. | 47 |
| performance_analytics | brand_health_tracker | transactional_data | Consolidated periodic brand performance scorecard capturing all consumer perception, market position, competitive share, media share, and social sentiment metrics for a brand in a specific market and time period. Captures awareness (spontaneous, aided), consideration, preference, purchase intent, NPS, brand equity index, SOV% (Share of Voice by channel — TV, digital, OOH, social), SOM% (value share, volume share by category/channel/geography), total category spend, competitor benchmarks, social sentiment scores (positive/neutral/negative breakdown), mention volume, share of conversation, platform distribution, net sentiment score, and key image attribute scores. Sourced from Nielsen Ad Intel/Kantar media monitoring (SOV), Nielsen IQ Retail Measurement/Circana (SOM), proprietary brand tracking studies (awareness/equity), and social listening platforms (sentiment). Serves as the single authoritative brand scorecard enabling longitudinal brand health monitoring, SOV vs. SOM gap analysis, competitive benchmarking, market share trend tracking, and sentiment trend analysis. | 51 |
| performance_analytics | digital_performance | transactional_data | Transactional record of digital campaign performance metrics captured at the campaign-channel-date grain. Captures impressions, clicks, CTR, video views, view-through rate, conversions, cost-per-click (CPC), cost-per-acquisition (CPA), ROAS (Return on Ad Spend), reach, frequency, and platform (Meta, Google, TikTok, programmatic DSP). Sourced from digital ad platforms via API integration. | 46 |
| performance_analytics | market_research_study | master_data | Master record for each market research study or syndicated data subscription commissioned or conducted by Consumer Goods. Captures study name, research type (quantitative, qualitative, U&A, concept test, pack test, NPS, brand health tracker, consumer panel), research agency/data provider (Nielsen IQ, Kantar, Circana, Ipsos), fieldwork dates, target market, sample size, methodology, status, key findings summary, and periodic panel metrics (household penetration, purchase frequency, basket size, repeat rate, switching behavior, buyer demographics). Serves as the SSOT for all primary and syndicated research investment, output tracking, and consumer panel insight management. Enables research ROI tracking and insight activation across brand strategy. | 50 |
| performance_analytics | market_share_record | transactional_data | Periodic market share (SOM) measurement record capturing a brand's or SKU's value and volume share within a defined category, channel, and geography at a given time period. Captures value share %, volume share %, category total value, brand value, data source (Nielsen IQ Retail Measurement, IRI/Circana), market definition, and period. Enables SOM trend tracking and competitive benchmarking. | 41 |
| performance_analytics | nielsen_panel_insight | transactional_data | Periodic consumer panel insight record sourced from Nielsen IQ panel data. Captures category, brand, SKU-level household penetration, purchase frequency, basket size, repeat rate, switching behavior, buyer profile demographics, and panel period. Serves as the authoritative source for Nielsen IQ consumer panel metrics used in brand and category strategy decisions. | 50 |
| performance_analytics | social_listening_record | transactional_data | Transactional record of social media listening and sentiment monitoring results for a brand, product, or topic at a given time period. Captures mention volume, sentiment breakdown (positive, neutral, negative), share of conversation, top themes, platform distribution (Twitter/X, Instagram, TikTok, Reddit, YouTube), net sentiment score, and data source. Enables consumer sentiment trend analysis and brand reputation monitoring. | 48 |
| performance_analytics | sov_measurement | transactional_data | Periodic Share of Voice (SOV) measurement record capturing a brand's advertising share relative to total category spend across media channels, market, and time period. Captures brand SOV%, competitor SOV%, total category spend, brand spend, channel (TV, digital, OOH, social), data source (Nielsen Ad Intel, Kantar), and measurement period. Enables SOV vs. SOM gap analysis. | 37 |

<a id="domain-product"></a>

### Domain: Product

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| product | business | 4 | Single source of truth for all product master data across the CPG/FMCG portfolio. Owns SKU definitions, GTIN/UPC/EAN identifiers, product hierarchies, BOM structures, PLM lifecycle stages, formulation records, packaging specifications, INCI ingredient declarations, and regulatory labeling attributes. Serves as the authoritative product catalog referenced by all other domains. | 23 |

**Subdomains:** assignment_rules, lifecycle_compliance, master_data, structure_specification


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| assignment_rules | freight_contract_assignment | association_data | Freight contract SKU assignments | 8 |
| assignment_rules | sku_substitution | master_data | SKU substitution rules | 32 |
| assignment_rules | supply_agreement | association_data | Supply agreements | 10 |
| assignment_rules | vmi_sku_assignment | association_data | VMI SKU assignments | 10 |
| lifecycle_compliance | certification | master_data | Product certifications | 33 |
| lifecycle_compliance | plm_transition | transactional_data | PLM stage transitions | 35 |
| lifecycle_compliance | product_claim | master_data | Product claims | 42 |
| lifecycle_compliance | product_registration | association_data | Consumer product registrations | 7 |
| master_data | category | master_data | Product categories | 17 |
| master_data | gtin_registry | master_data | GTIN registry for product identification | 43 |
| master_data | hierarchy | reference_data | Product hierarchy structure | 44 |
| master_data | material | master_data | Material master | 32 |
| master_data | pack_hierarchy | master_data | Pack hierarchy structure | 33 |
| master_data | product_brand | master_data | Product brand master | 39 |
| master_data | product_category | master_data | Product category hierarchy | 18 |
| master_data | sku | master_data | Stock keeping unit master | 59 |
| master_data | sku_group | master_data | SKU groupings | 22 |
| structure_specification | bom_line | master_data | BOM line items | 42 |
| structure_specification | label_spec | master_data | Label specifications | 44 |
| structure_specification | product_bom | master_data | Product bill of materials | 42 |
| structure_specification | product_formulation | master_data | Product formulation master | 43 |
| structure_specification | product_formulation_ingredient | master_data | Formulation ingredients | 46 |
| structure_specification | product_packaging_spec | master_data | Product packaging specifications | 44 |

<a id="domain-promotion"></a>

### Domain: Promotion

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| promotion | business | 4 | Owns trade promotion planning, execution, and optimization (TPM/TPO). Manages promotional calendars, trade spend allocation, retailer funding agreements, promotional pricing (Hi-Lo, EDLP), accruals, deductions, post-event analysis, promotional lift measurement, ROI/GMROI analysis, and retailer rebate settlements. Integrates with Salesforce TPM. | 20 |

**Subdomains:** consumer_incentives, financial_settlement, performance_analytics, trade_planning


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| consumer_incentives | consumer_offer | master_data | Master entity defining consumer-facing promotional offers (coupons, digital offers, loyalty rewards, instant rebates, free goods with purchase) that are part of a trade promotion or brand marketing program. Captures offer code, offer type, offer description, discount value/percentage, qualifying SKUs, minimum purchase requirement, offer validity period, distribution channel (FSI, digital, in-store, DTC app), maximum redemption limit, and offer status. Distinct from trade funding — this entity owns the consumer-facing offer definition. | 47 |
| consumer_incentives | flight_allocation | association_data | This association captures the allocation of a promotion_event to a campaign_flight, including spend and volume metrics that are specific to the event‑flight pairing. Each record links one promotion_event to one campaign_flight and stores attributes that exist only in the context of this relationship.. Existence Justification: A promotion_event represents a specific trade promotion execution at a retailer/store, while a campaign_flight represents a media flight for a marketing campaign. In practice, a single promotion_event can be linked to multiple campaign_flights (e.g., the same in‑store promotion is supported by TV, digital, and print flights), and a single campaign_flight can include many promotion_events across different retailers. The business tracks allocation of spend and volume per promotion_event‑flight pair, which is managed by planners as a distinct record. | 47 |
| consumer_incentives | pos_redemption | transactional_data | Transactional record capturing point-of-sale redemption data for consumer-facing promotional offers (coupons, scan-back discounts, loyalty rewards, digital offers). Tracks redemption date, retailer store, SKU, redemption quantity, redemption value, offer type (manufacturer coupon, retailer coupon, digital offer, loyalty reward), redemption channel (in-store, e-commerce, DTC), and data source (EDI 844/849, retailer POS feed, coupon clearinghouse). Enables consumer promotion ROI and redemption rate tracking. | 44 |
| consumer_incentives | promoted_price | master_data | Master entity capturing the promotional price points defined for SKUs within a promotion event or pricing program. Tracks promoted price type (Hi-Lo temporary price reduction, EDLP, multi-buy, BOGO, scan-back price), promoted price amount, regular shelf price (RSP/MSRP), price reduction depth (%), effective date range, retailer account, channel, and approval status. Distinct from standard list pricing — this entity owns the promotional price layer used during trade events. | 41 |
| financial_settlement | deduction_settlement | transactional_data | Transactional record capturing the resolution and settlement of a retailer deduction. Tracks settlement date, settlement method (credit memo, check, offset against future invoice, write-off), settled amount, approved amount, disputed amount, settlement reason code, approver, and linkage to the originating deduction and funding agreement. Enables closed-loop deduction management and accurate trade spend reconciliation. | 38 |
| financial_settlement | promotion_accrual | transactional_data | Trade promotion accrual tracking expected promotional spend obligations. SSOT for trade promotion accruals. Distinct from finance.finance_accrual which is the general corporate accrual. | 46 |
| financial_settlement | promotion_deduction | transactional_data | Transactional record representing the full lifecycle of a retailer deduction from initial short-payment through final settlement. Captures deduction number, retailer account, invoice reference, deduction amount, deduction type (promotional, pricing, shortage, compliance), deduction date, dispute status (open, approved, disputed, written-off), and complete settlement details: settlement date, settlement method (credit memo, check, offset against future invoice, write-off), settled amount, approved amount, disputed amount, settlement reason code, approver, and linkage to originating promotion event and funding agreement. Serves as the single entity for the entire deduction management workflow — no separate settlement record exists. Central to trade spend reconciliation, dispute resolution, and retailer relationship management. | 48 |
| financial_settlement | promotion_rebate_agreement | master_data | Master entity representing a retailer rebate agreement including its periodic settlement history. Captures agreement terms: retailer account, rebate type (volume tier, growth incentive, category captain, compliance), calculation basis (% of net sales, $ per case), tier thresholds, measurement period, payment frequency, and agreement status. Contains embedded settlement records: settlement period, earned rebate amount, qualifying volume/revenue, tier achieved, payment method, payment date, settlement status (calculated, approved, paid, disputed), and SAP FI payment reference. Distinct from funding agreements in that rebates are earned retrospectively based on performance. Serves as the SSOT for both rebate agreement terms and their periodic settlement calculations. | 49 |
| financial_settlement | rebate_settlement | transactional_data | Transactional record capturing the periodic calculation and payment settlement of retailer rebates under a rebate agreement. Tracks settlement period, earned rebate amount, qualifying volume/revenue, tier achieved, payment method, payment date, settlement status (calculated, approved, paid, disputed), and SAP FI payment reference. Enables accurate rebate liability tracking and cash flow forecasting for the trade finance function. | 35 |
| performance_analytics | baseline_volume | transactional_data | Transactional record capturing the statistical baseline volume estimate for a SKU-retailer-period combination, representing expected sales absent any promotional activity. Stores baseline volume (units/cases), baseline revenue, baseline methodology (moving average, regression, Nielsen IQ panel, Bayesian structural time series), data source, baseline period, confidence interval, last refresh date, analyst override flag, and model version. Serves as the reusable baseline denominator consumed by post_event_analysis for incremental lift calculation across all promotion events. Maintained independently of any single promotion event to enable consistent cross-event comparison and baseline trend monitoring. | 44 |
| performance_analytics | lift_measurement | transactional_data | Transactional record capturing incremental volume lift measurements for a promotion event at the SKU-retailer-week level. Stores baseline volume (pre-promotion trend), actual promoted volume, incremental lift units, incremental lift percentage, lift source (POS scan data, Nielsen IQ panel, TradeEdge secondary sales), measurement methodology, confidence interval, and data vintage. Feeds TPO optimization models and post-event ROI calculations. | 43 |
| performance_analytics | post_event_analysis | transactional_data | Comprehensive analytical record capturing post-event review (PER) results for a completed promotion event at SKU-retailer-period granularity. Stores baseline volume estimates (methodology, confidence interval, data source, pre-promotion trend), actual promoted volume, incremental lift measurements (units, percentage, lift source — POS scan data, Nielsen IQ panel, TradeEdge secondary sales), measurement methodology, data vintage, planned vs. actual trade spend, promotional ROI, GMROI, cost per incremental case, sell-through rate, OOS incidents, retailer compliance score, and analyst notes. Serves as the single analytical SSOT for all promotion performance measurement including baseline estimation, lift calculation, and ROI analysis. Feeds TPO optimization models, learning loops, and future planning decisions. | 48 |
| performance_analytics | retailer_compliance | transactional_data | Transactional record capturing retailer execution compliance for a promotion event — whether the retailer delivered the agreed promotional mechanics (feature ad, display, price point, shelf placement per POG). Tracks compliance check date, compliance type (ad feature, display, price compliance, OSA), compliance score (%), non-compliance reason, penalty amount applied, auditor/field rep reference, and data source (SFA field audit, third-party compliance service). Feeds deduction dispute resolution and future funding negotiations. | 37 |
| trade_planning | event_sku | transactional_data | Association entity linking individual SKUs (GTINs/UPCs) to a specific promotion event with full promotional pricing authority. Captures SKU-level promotional details including promoted price, promoted price type (Hi-Lo temporary price reduction, EDLP, multi-buy, BOGO, scan-back, off-invoice, bill-back), price reduction depth (%), regular shelf price (RSP/MSRP), effective date range, planned promotional volume (cases/units), actual promotional volume, baseline volume estimate, incremental lift volume, promotional discount amount per unit, retailer account, channel, and pricing approval status. Serves as the SSOT for SKU-level promotional pricing within trade events — distinct from standard list pricing owned by the product domain. Enables SKU-level trade spend, lift analysis, and promotional price compliance per event. | 50 |
| trade_planning | funding_agreement | master_data | Master entity representing a formal retailer funding agreement (RFA) or joint business plan (JBP) between the CPG manufacturer and a retail account. Captures agreement name, retailer account, agreement type (annual lump sum, scan-back, co-op, slotting, performance-based), total committed funding amount, funding period, payment terms, performance conditions, approval status, and signatory details. Serves as the contractual basis for trade spend commitments and deduction settlements. | 45 |
| trade_planning | promotion_event | transactional_data | Trade promotion event representing a specific promotional execution with a retailer (TPR, display, feature). SSOT for trade promotion events. Distinct from marketing.marketing_event which covers brand marketing events. | 44 |
| trade_planning | tpo_scenario | master_data | Master entity representing a Trade Promotion Optimization (TPO) scenario — a modeled alternative promotion plan generated to optimize trade spend ROI. Captures scenario name, optimization objective (maximize volume, maximize ROI, maximize GMROI, minimize OOS), scenario status (draft, evaluated, approved, rejected), total scenario spend, projected incremental volume, projected ROI, comparison baseline scenario reference, and analyst owner. Enables what-if planning and scenario comparison for trade investment decisions. | 48 |
| trade_planning | trade_calendar | master_data | Master entity representing the annual or periodic trade promotional calendar for a brand, category, or retailer account. Captures calendar name, fiscal year, planning cycle, owning brand/category manager, retailer account scope, calendar status (draft, approved, locked), total planned trade spend envelope, and number of planned promotion events. Serves as the planning container for all trade promotion events within a given period and account relationship. | 36 |
| trade_planning | trade_promotion | master_data | Core master entity for trade promotion programs. Captures the full definition of a trade promotion including name, type (Hi-Lo, EDLP, display, coupon, scan-back, off-invoice), promotional period, owning brand/category, status (planned, active, closed, cancelled), total authorized trade spend budget, promotion objectives, promotion type classification (temporary price reduction, feature ad, display, BOGO, multi-buy, scan-back, coupon, loyalty reward), applicable channels, and integration reference to Salesforce TPM. Serves as the SSOT for all trade promotion definitions and the parent entity for all promotion events, spend allocations, and post-event analyses. | 39 |
| trade_planning | trade_spend_allocation | transactional_data | Transactional record capturing the allocation of trade spend budget to a specific promotion event, retailer account, brand, or SKU group. Tracks allocated amount, spend type (off-invoice discount, scan-back, bill-back, lump sum, co-op advertising, slotting fee, display allowance, free goods), spend category classification, GL account mapping, fiscal period, cost center, approval status, and variance between planned and committed spend. Feeds into COGS and trade spend reporting for S&OP and finance reconciliation. | 46 |

<a id="domain-sales"></a>

### Domain: Sales

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| sales | business | 4 | Owns commercial sales execution, order management, and revenue transactions across all channels (retail, wholesale, DTC, e-commerce). Manages sales orders, pricing agreements, sales force automation (SFA), retail account call records, POG compliance, RSP/MSRP price management, ACV/TDP/SOM metrics, and field sales KPIs. Integrates with Salesforce Consumer Goods Cloud. | 37 |

**Subdomains:** account_management, field_operations, pricing_strategy, transaction_processing


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| account_management | account_address | master_data | Physical and mailing addresses for trade accounts | 14 |
| account_management | account_assortment | master_data | Product assortment authorized for specific trade accounts | 9 |
| account_management | account_compliance_record | master_data | Compliance and regulatory records for trade accounts | 10 |
| account_management | account_contact | master_data | Contact persons associated with trade accounts | 11 |
| account_management | account_credit_profile | master_data | Credit and financial risk profile for trade accounts | 10 |
| account_management | account_hierarchy | master_data | Hierarchical relationships between trade accounts | 9 |
| account_management | account_onboarding | master_data | New account onboarding workflow tracking | 10 |
| account_management | account_pricing_agreement | master_data | Special pricing agreements with trade accounts | 11 |
| account_management | account_segment | reference_data | Segmentation classification for trade accounts | 7 |
| account_management | account_sla | master_data | Service level agreements with trade accounts | 11 |
| account_management | account_status_history | transactional_data | Historical record of account status changes | 8 |
| account_management | account_team | master_data | Team members assigned to manage trade accounts | 9 |
| account_management | compliance_assignment | association_data | Compliance requirement assignments to trade accounts | 10 |
| account_management | customer_vmi_agreement | master_data | Vendor-managed inventory agreements with customers | 13 |
| account_management | edi_trading_partner | master_data | EDI configuration for electronic data interchange with trade accounts | 12 |
| account_management | retail_store | master_data | Physical retail locations associated with trade accounts | 15 |
| account_management | sales_vmi_agreement | association_data | Sales-specific VMI agreement details | 11 |
| account_management | trade_account | master_data | Customer account master for B2B trade relationships | 18 |
| field_operations | account_call | transactional_data | Sales representative visits to trade accounts | 8 |
| field_operations | call | association_data | Sales call activity tracking | 10 |
| field_operations | distribution_point | master_data | Distribution points for product delivery | 11 |
| field_operations | opportunity | transactional_data | Sales opportunities and pipeline management | 11 |
| field_operations | planogram_compliance | transactional_data | Retail planogram compliance tracking | 9 |
| field_operations | quota | master_data | Sales quotas for representatives | 10 |
| field_operations | rep | master_data | Sales representatives | 10 |
| field_operations | sales_dsd_route | master_data | Direct store delivery routes | 9 |
| field_operations | territory | master_data | Sales territories for account assignment | 8 |
| pricing_strategy | price_list | master_data | Master price lists for products | 9 |
| pricing_strategy | price_list_item | master_data | Individual SKU prices within price lists | 9 |
| pricing_strategy | pricing_agreement | master_data | Master pricing agreements with trade accounts | 10 |
| pricing_strategy | sales_rebate_agreement | master_data | Rebate agreements with trade accounts | 11 |
| transaction_processing | invoice | transactional_data | Sales invoices issued to trade accounts | 13 |
| transaction_processing | order | transactional_data | Sales orders from trade accounts | 13 |
| transaction_processing | pos_transaction | transactional_data | Point-of-sale transaction data from retail stores | 10 |
| transaction_processing | return_order | transactional_data | Product returns from trade accounts | 10 |
| transaction_processing | sales_deduction | transactional_data | Customer deductions and chargebacks | 11 |
| transaction_processing | sales_dsd_delivery | transactional_data | Direct store delivery transactions | 9 |

<a id="domain-finance"></a>

### Domain: Finance

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| finance | corporate | 6 | Owns financial planning, accounting, and reporting including general ledger, accounts payable/receivable, cost accounting, COGS allocation, EBITDA reporting, DSO/DIO tracking, budgeting, revenue recognition, and SOX-compliant financial controls and audit trails. Integrates with SAP S/4HANA FI/CO and Oracle Cloud Financials. | 29 |

**Subdomains:** cost_planning, enterprise_controls, organizational_accounting, payables_processing, receivables_management, transaction_recording


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| cost_planning | cogs_allocation | transactional_data | Product costing and COGS allocation master for CPG manufacturing. Owns both standard cost estimates (planned) and actual cost allocations for finished goods, semi-finished goods, and raw materials. Captures cost component splits (raw material, packaging, direct labor, variable/fixed overhead, machine overhead, freight-in, depreciation), costing version, validity period, costing lot size, release status, plant, allocation date, fiscal period, standard vs actual cost, variance amount, variance category, and allocation method. The single source of truth for inventory valuation, SKU-level and brand-level gross margin analysis, manufacturing variance reporting, COGS decomposition, and make-vs-buy cost comparison. Sourced from SAP S/4HANA CO-PC (Product Costing). | 57 |
| cost_planning | finance_budget | master_data | Enterprise financial budget at cost center/profit center level for corporate planning and control. SSOT for corporate financial budgets. Distinct from marketing.marketing_budget which is the marketing-specific spend plan. | 61 |
| cost_planning | fixed_asset | master_data | Fixed asset master and lifecycle record for capital assets owned by the consumer goods enterprise — manufacturing equipment, production lines, warehouse automation, vehicles, buildings, and IT infrastructure. Covers the full asset lifecycle: acquisition, capitalization, depreciation, transfer, revaluation, impairment, and disposal. Captures asset class, description, acquisition date/cost, useful life, depreciation method, accumulated depreciation, net book value, plant/location, responsible cost center, and all transaction events (transaction type, posting date, amount, document reference, originating business process). Supports capex tracking, depreciation run reconciliation, asset lifecycle audit trail, and SOX-compliant fixed asset management. Sourced from SAP S/4HANA FI-AA and Oracle Cloud Fixed Assets. | 53 |
| cost_planning | standard_cost | master_data | Standard cost master record for finished goods, semi-finished goods, and raw materials used in CPG manufacturing. Stores the cost estimate per SKU/material including cost component split (raw material, packaging, direct labor, machine overhead, fixed overhead, freight-in), costing version, validity period, plant, costing lot size, and release status. The authoritative source for inventory valuation, COGS calculation, and manufacturing variance analysis. Sourced from SAP S/4HANA CO-PC. | 62 |
| enterprise_controls | contract_party | master_data | Master reference table for contract_party. Referenced by contract_party_id. | 49 |
| enterprise_controls | finance_accrual | transactional_data | General financial accrual for period-end accounting (expenses, liabilities). SSOT for corporate accrual accounting. Distinct from promotion.promotion_accrual which tracks trade promotion-specific accruals. | 49 |
| enterprise_controls | intercompany_transaction | transactional_data | Intercompany financial transaction record capturing cross-entity postings between legal entities within the consumer goods corporate group. Covers intercompany sales of finished goods, cost allocations, management fee charges, royalty payments, intercompany loans, and dividend distributions. Stores sending company code, receiving company code, transaction type, posting date, amount, currency, transfer price, arm's-length validation flag, netting status, elimination flag, reconciliation reference, and matching status. Critical for consolidated financial reporting, transfer pricing compliance, intercompany elimination in group close, and regulatory documentation under OECD transfer pricing guidelines. | 58 |
| enterprise_controls | party | master_data | Master reference table for party. Referenced by party_id. | 56 |
| enterprise_controls | performance_obligation | master_data | Master reference table for performance_obligation. Referenced by performance_obligation_id. | 48 |
| enterprise_controls | revenue_contract | master_data | Master reference table for revenue_contract. Referenced by contract_id. | 53 |
| enterprise_controls | sox_control | master_data | SOX (Sarbanes-Oxley) internal control record defining and tracking the financial controls framework for the consumer goods enterprise. Covers the full control lifecycle: definition, testing, remediation, and certification. Captures control ID, name, objective, type (preventive/detective), frequency, risk area, responsible owner, test date, test method (inquiry, observation, inspection, re-performance), sample size, exceptions identified, remediation status, remediation due date, effectiveness rating, and test conclusion. Supports SOX 302/404 compliance, internal audit management, control deficiency tracking, and external auditor evidence packages. | 67 |
| organizational_accounting | chart_of_accounts | master_data | Master reference table for chart_of_accounts. Referenced by chart_of_accounts_id. | 60 |
| organizational_accounting | company_code | master_data | Master reference table for company_code. Referenced by company_code_id. | 48 |
| organizational_accounting | controlling_area | master_data | Master reference table for controlling_area. Referenced by controlling_area_id. | 24 |
| organizational_accounting | cost_center | master_data | Master record for organizational cost centers used in SAP S/4HANA CO module. Defines the financial accountability units within the CPG enterprise — brand units, manufacturing plants, regional sales offices, and shared service centers. Each cost center carries a hierarchy path, responsible manager, controlling area, profit center assignment, currency, and active period. Serves as the foundational dimension for all cost accounting, COGS allocation, and EBITDA reporting. | 37 |
| organizational_accounting | gl_account | master_data | General ledger chart of accounts master for the consumer goods enterprise. Defines every account in the COA including P&L accounts (revenue, COGS, trade spend, marketing, SG&A), balance sheet accounts (inventory, AR, AP, fixed assets), and statistical accounts. Stores account type, financial statement category, tax category, reconciliation account flag, currency, and controlling relevance. Source of truth for all financial postings in SAP S/4HANA FI and Oracle Cloud Financials. | 64 |
| organizational_accounting | ledger | master_data | Financial ledger master defining the accounting ledgers maintained in the enterprise — leading ledger (IFRS/GAAP), parallel ledgers for local GAAP, and extension ledgers for management reporting. Each ledger record captures ledger type, accounting principle, currency type, fiscal year variant, and posting period variant. Supports multi-GAAP reporting requirements common in global CPG companies operating across multiple regulatory jurisdictions. | 38 |
| organizational_accounting | profit_center | master_data | Master record for profit centers representing autonomous business segments within the consumer goods enterprise — product lines, brands, or geographic business units. Tracks revenue, cost, and profitability at a granular level below the legal entity. Integrates with SAP S/4HANA CO-PCA (Profit Center Accounting) and Oracle Cloud Financials for segment reporting and EBITDA decomposition. | 47 |
| payables_processing | ap_invoice | transactional_data | Accounts payable master record representing the full trade payable lifecycle for raw materials, packaging, contract manufacturing, and indirect goods/services. Owns invoice receipt, three-way match verification, payment scheduling, payment execution, early payment discount capture, and clearing. Captures vendor invoice number, invoice date, posting date, due date, gross amount, tax, net amount, payment terms, currency, match status, payment method, payment date, payment amount, payment run ID, bank account reference, early discount taken, clearing document, and payment block details. The single source of truth for all payable balances, payment execution, DIO tracking, working capital optimization, and supplier payment management. Integrates with SAP S/4HANA MM-IV, FI-AP, and Oracle Cloud Payables. | 55 |
| payables_processing | ap_payment | transactional_data | Accounts payable payment record capturing outgoing payments to suppliers for raw materials, packaging, and services. Records payment date, payment method (ACH, wire, check, EDI 820), payment amount, currency, exchange rate, bank account, payment run ID, clearing document, early payment discount taken, and payment block release authorization. Supports cash flow management, supplier relationship management, and working capital optimization. Sourced from SAP S/4HANA FI-AP. | 51 |
| payables_processing | bank_account | master_data | Master reference table for bank_account. Referenced by bank_account_id. | 41 |
| payables_processing | netting_run | master_data | Master reference table for netting_run. Referenced by netting_run_id. | 35 |
| payables_processing | payment_run | master_data | Master reference table for payment_run. Referenced by payment_run_id. | 38 |
| receivables_management | ar_invoice | transactional_data | Accounts receivable master record representing the full trade receivable lifecycle for consumer goods sales to retailers, distributors, and wholesalers. Owns invoice creation, payment terms, cash receipt application, partial payments, deductions/short-payments, clearing, and write-offs. Captures invoice number, billing date, due date, payment terms, gross amount, trade discounts, net amount, tax, currency, payment method, payment date, amount received, clearing reference, DSO aging bucket, dunning level, and deduction reason codes. The single source of truth for all receivable balances, cash application, deduction management, DSO tracking, cash flow forecasting, and revenue recognition under ASC 606/IFRS 15. Integrates with SAP S/4HANA SD billing and FI-AR. | 62 |
| receivables_management | ar_payment | transactional_data | Accounts receivable payment record capturing cash receipts from trade customers against outstanding AR invoices. Records payment date, payment method (ACH, wire, check, EDI 820), amount received, currency, exchange rate, bank account, clearing document reference, partial payment flag, and deduction/short-payment details. Supports cash application, deduction management, and DSO calculation. Sourced from SAP S/4HANA FI-AR and Oracle Cloud Receivables. | 58 |
| transaction_recording | journal_entry | transactional_data | Core general ledger journal entry header capturing every financial posting in the consumer goods enterprise. Records document type (vendor invoice, customer payment, goods issue, payroll posting, accrual, reversal), posting date, fiscal period, company code, ledger, currency, exchange rate, reference document, and SOX-compliant posting user and approval chain. The authoritative transactional record for all financial activity sourced from SAP S/4HANA FI and Oracle Cloud Financials. | 58 |
| transaction_recording | journal_entry_line | transactional_data | Individual line items of a general ledger journal entry. Each line captures the GL account, cost center, profit center, WBS element, business area, debit/credit indicator, amount in transaction currency, amount in company code currency, amount in group currency, tax code, and assignment field. Enables granular cost allocation, COGS decomposition, and audit trail tracing at the line level as required by SOX compliance. | 62 |
| transaction_recording | material_ledger_posting | master_data | Master reference table for material_ledger_posting. Referenced by material_ledger_posting_id. | 48 |
| transaction_recording | revenue_recognition | transactional_data | Revenue recognition event record capturing the timing and amount of revenue recognized under ASC 606 / IFRS 15 for consumer goods sales transactions. Stores performance obligation ID, contract reference, recognition date, recognition method (point-in-time vs over-time), recognized revenue amount, deferred revenue amount, variable consideration estimate (trade promotions, rebates, returns), constraint applied flag, and cumulative catch-up adjustment. Supports compliant revenue reporting and audit trail for complex CPG revenue arrangements. | 54 |

<a id="domain-regulatory"></a>

### Domain: Regulatory

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| regulatory | corporate | 4 | Owns product registration, regulatory submissions, labeling compliance, and safety documentation management. Manages regulatory dossiers, SDS/MSDS sheets, ingredient declarations, country-specific registrations (FDA, EPA, EU), CPSC filings, IFRA compliance records, post-market surveillance, and CFR compliance. Ensures multi-jurisdictional regulatory adherence. | 19 |

**Subdomains:** compliance_management, documentation_standards, enforcement_response, product_authorization


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| compliance_management | compliance_assessment | transactional_data | Compliance assessments against obligations | 49 |
| compliance_management | compliance_obligation | master_data | Regulatory compliance obligations | 48 |
| compliance_management | ifra_compliance_record | transactional_data | IFRA compliance records for fragrances | 46 |
| compliance_management | jurisdiction | reference_data | Regulatory jurisdictions | 43 |
| compliance_management | reach_substance | master_data | REACH substance registrations and compliance | 53 |
| compliance_management | restricted_substance | reference_data | Restricted substances by jurisdiction | 44 |
| documentation_standards | ingredient_list | master_data | Ingredient lists for regulatory labeling | 54 |
| documentation_standards | label_version | master_data | Approved label versions for regulatory compliance | 58 |
| documentation_standards | regulatory_claim | master_data | Regulatory-approved product claims | 51 |
| documentation_standards | sds | master_data | Safety Data Sheets for products and ingredients | 56 |
| enforcement_response | action | transactional_data | Regulatory actions and enforcement | 57 |
| enforcement_response | change | master_data | Regulatory change control records | 46 |
| enforcement_response | cpsc_filing | transactional_data | CPSC filings for consumer products | 57 |
| enforcement_response | product_recall | transactional_data | Product recall events | 63 |
| enforcement_response | surveillance_event | transactional_data | Post-market surveillance events | 61 |
| product_authorization | dossier | master_data | Regulatory dossiers containing product documentation | 51 |
| product_authorization | epa_registration | master_data | EPA registrations for regulated products | 50 |
| product_authorization | regulatory_registration | master_data | Regulatory registration records for products in various jurisdictions | 57 |
| product_authorization | submission | transactional_data | Regulatory submissions to authorities | 49 |

<a id="domain-research"></a>

### Domain: Research

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| research | corporate | 4 | Owns research and development, innovation pipeline, and NPD data. Manages R&D project portfolios, formulation development records, lab testing, clinical/consumer test results, prototype development, patent filings, INCI ingredient libraries, sensory evaluation, regulatory dossiers, and stage-gate milestone tracking for new product launches from concept to commercialization. | 25 |

**Subdomains:** compliance_safety, formulation_development, innovation_portfolio, testing_validation


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| compliance_safety | claim_substantiation | master_data | Records the evidence package assembled to substantiate specific marketing and product performance claims for regulatory and legal defense. Captures claim text (e.g., '48-hour moisturization', 'clinically proven', 'dermatologist tested'), claim type (efficacy, safety, environmental, comparative), substantiation method (clinical study, consumer test, instrumental measurement, expert endorsement), supporting study references, claim approval status, legal review sign-off, market applicability, and expiry/renewal date. Bridges R&D evidence to marketing claim usage and ensures claims are defensible under advertising standards (NAD, ASA) and regulatory requirements. | 42 |
| compliance_safety | regulatory_dossier | master_data | Master record for regulatory submission dossiers prepared for new product registrations and notifications. Captures dossier type (CPNP EU notification, FDA OTC monograph, ASEAN ASEAN Cosmetic Directive, Health Canada), target market, submission date, regulatory authority reference number, dossier status (in preparation, submitted, under review, approved, rejected), responsible regulatory affairs manager, and linked product/formulation. Distinct from the regulatory domain's product registration — this is the R&D-owned dossier preparation record. | 45 |
| compliance_safety | safety_assessment | master_data | Formal product safety assessment records required for regulatory compliance and consumer safety. Captures assessment type (cosmetic product safety report per EU Regulation 1223/2009, toxicological risk assessment, dermal sensitization assessment, HRIPT), assessor name and qualification, assessment date, product/formulation assessed, safety conclusion (safe/unsafe/conditionally safe), conditions of use, and any required label warnings. Mandatory for EU CPSR and other market registrations. | 42 |
| formulation_development | inci_library | reference_data | Enterprise master reference library and technical specification repository for all INCI ingredients and raw materials used across R&D formulations. Captures INCI name, CAS number, EC number, chemical family, function class, physical form, raw material code, supplier name, grade/quality level, specification parameters (purity, moisture content, particle size, color, odor), approved concentration range, regulatory status per major jurisdiction (EU REACH, FDA, Health Canada, ASEAN), restricted/prohibited flag, maximum permitted concentration, approved supplier grades, storage conditions, SDS reference, and R&D approval status. Serves as the single authoritative ingredient dictionary and raw material specification record for formulation development, regulatory compliance, and supplier qualification within R&D. | 40 |
| formulation_development | prototype | master_data | Master record for physical product prototypes developed during the NPD process, including associated packaging component specifications. Captures prototype code, prototype generation (P1, P2, P3), associated formulation version, packaging configuration with component-level detail (component type, material type — HDPE, PET, glass, aluminum, paperboard — dimensions, weight, closure type, decoration method, compatibility test status with formulation, recyclability classification), fill weight/volume, manufacturing scale (bench, pilot, scale-up), prototype creation date, prototype status (active, superseded, approved for consumer test), R&D packaging approval status, and the R&D project it belongs to. Prototypes are distinct from formulations — they represent the physical product iteration including packaging. | 43 |
| formulation_development | raw_material_spec | master_data | R&D-owned specification records for raw materials and ingredients used in formulation development. Captures raw material code, material name, INCI name, supplier name, grade/quality level, physical form, specification parameters (purity, moisture content, particle size, color, odor), approved concentration range, storage conditions, and R&D approval status. Distinct from procurement's supplier material master — this is the R&D technical specification that governs formulation use. | 34 |
| formulation_development | research_formulation | master_data | R&D experimental formulation developed during research phase - may have multiple iterations before commercialization. SSOT for research formulations. Distinct from product.product_formulation which is the approved production recipe. | 43 |
| formulation_development | research_formulation_ingredient | master_data | Ingredient in an R&D experimental formulation - may have trial concentrations and preliminary safety data. SSOT for research ingredient experiments. Distinct from product.product_formulation_ingredient which is the approved production ingredient. | 35 |
| formulation_development | research_packaging_spec | master_data | R&D packaging specification for prototypes and trials - experimental materials and designs under evaluation. SSOT for research packaging development. Distinct from product.product_packaging_spec which is the approved production spec. | 41 |
| formulation_development | scale_up_trial | transactional_data | Records manufacturing scale-up trials conducted to transfer formulations from R&D bench scale to pilot or commercial production scale, serving as the formal technology transfer record. Captures trial date, manufacturing site, batch size, equipment used, process parameters (mixing speed, temperature, time, order of addition), yield, in-process test results, deviation observations, scale-up status (pass/fail/conditional), technology transfer checklist completion, and manufacturing readiness sign-off. Bridges R&D formulation development with manufacturing operations and commercial launch readiness. | 44 |
| innovation_portfolio | innovation_brief | master_data | Formal innovation brief document that initiates an NPD project, capturing the business opportunity, target consumer, desired product benefits, cost target (COGS), RSP target, competitive benchmarks, key performance indicators, and strategic fit rationale. Serves as the contract between marketing/commercial and R&D at project inception. Distinct from the R&D project master — the brief is the upstream commercial trigger that precedes project creation. | 43 |
| innovation_portfolio | patent_family | master_data | Master reference table for patent_family. Referenced by patent_family_id. | 31 |
| innovation_portfolio | patent_filing | master_data | Master record for patent applications and granted patents arising from R&D innovation activities. Captures patent application number, patent title, filing date, jurisdiction (US, EU, JP, CN, global PCT), patent type (utility, design, composition of matter, process), inventors list, assignee, prosecution status (filed, published, granted, abandoned, expired), grant date, expiry date, and linked R&D project or formulation. Supports IP portfolio management and freedom-to-operate analysis. | 42 |
| innovation_portfolio | rd_project | master_data | Master record for all R&D and NPD projects in the innovation pipeline, from initial business opportunity through commercialization. Captures project identity, innovation brief details (target consumer, desired benefits, cost/RSP targets, competitive benchmarks, strategic fit rationale, key performance indicators), stage-gate phase, project type (new product, reformulation, line extension, cost optimization), target launch date, project sponsor, brand alignment, strategic priority tier, budget allocation, resource assignment, current milestone status, and the originating business opportunity context. Serves as the backbone of the R&D portfolio management function and links all downstream formulation, testing, regulatory, and scale-up activities. Subsumes the innovation brief as the project inception record. | 39 |
| innovation_portfolio | stage_gate_milestone | transactional_data | Tracks each formal stage-gate review milestone within an R&D project lifecycle. Records gate number (G0 concept through G5 launch), gate decision (go/kill/hold/recycle), review date, gate owner, decision rationale, deliverables checklist completion status, and next gate target date. Enables portfolio governance and NPD pipeline velocity tracking across all active projects. | 33 |
| testing_validation | consumer_test | master_data | Master record for consumer and clinical use tests conducted to validate product performance, safety, and consumer acceptance. Captures study type (HUT, CLT, clinical efficacy, dermatologist test), study design, sample size, target consumer segment, test geography, test dates, primary claim being validated, overall study outcome, and individual respondent-level results including anonymized respondent ID, test panel, attribute ratings (lather, fragrance, skin feel, efficacy perception), rating scale values, open-text verbatims, claim substantiation outcomes, statistical significance flags, and net promoter intent scores. Enables claim validation, consumer insight generation, and NPD decision-making across the full test lifecycle. | 43 |
| testing_validation | consumer_test_result | transactional_data | Individual respondent-level or aggregate result records from consumer and clinical use tests. Captures respondent ID (anonymized), test panel, attribute being rated (lather, fragrance, skin feel, efficacy perception), rating scale value, open-text verbatim, claim substantiation outcome, statistical significance flag, and net promoter intent score. Enables claim validation and consumer insight generation for NPD decision-making. | 38 |
| testing_validation | lab_test | transactional_data | Records individual laboratory tests conducted on formulations or prototypes during R&D. Captures test type (stability, efficacy, microbiological, compatibility, pH, viscosity, irritation), test method reference (ISO, ASTM, internal), sample ID, test date, lab location, analyst, result value, result unit, pass/fail determination, and out-of-specification (OOS) flag. Provides the primary test execution record linking formulations to their performance data. | 37 |
| testing_validation | panel_session | master_data | Master reference table for panel_session. Referenced by panel_session_id. | 27 |
| testing_validation | research_sample | master_data | Master reference table for sample. Referenced by sample_id. | 27 |
| testing_validation | research_stability_study | master_data | Master record for formal stability studies conducted on formulations and finished product prototypes, including all time-point measurement data. Captures study type (accelerated, real-time, freeze-thaw, photostability), ICH condition (25°C/60%RH, 40°C/75%RH, etc.), study start date, planned duration, container-closure system, orientation, study status, overall stability conclusion, and individual time-point measurements (T=0 through T=24M) with test parameters (appearance, pH, viscosity, assay, microbial count), measured values, specification limits, pass/fail status, and analyst sign-off. Supports trend analysis, shelf-life determination, and regulatory dossier preparation. | 39 |
| testing_validation | respondent | master_data | Master reference table for respondent. Referenced by respondent_id. | 35 |
| testing_validation | sensory_evaluation | transactional_data | Records formal sensory panel evaluations of product prototypes and formulations. Captures panel type (trained expert panel, consumer panel, QC panel), evaluation date, product sample code, sensory attributes assessed (color, odor, texture, spreadability, rinse-off feel, after-feel), scoring methodology (QDA, hedonic scale, JAR scale), panelist count, and overall sensory profile outcome. Sensory evaluation is a distinct R&D sub-function with its own workflow and data structure. | 38 |
| testing_validation | stability_timepoint | transactional_data | Individual time-point measurement records within a stability study. Captures time-point interval (T=0, T=1M, T=3M, T=6M, T=12M, T=24M), test parameter (appearance, pH, viscosity, assay, microbial count), measured value, specification limit, pass/fail status, and analyst sign-off. Enables trend analysis across the stability study lifecycle and supports shelf-life determination and regulatory dossier preparation. | 34 |
| testing_validation | study_protocol | master_data | Master reference table for study_protocol. Referenced by study_protocol_id. | 36 |

<a id="domain-sustainability"></a>

### Domain: Sustainability

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| sustainability | corporate | 4 | Owns environmental, social, and governance (ESG) data. Manages carbon footprint tracking, packaging recyclability metrics, FSC/RSPO sustainable sourcing certifications, ISO 14001 environmental compliance, water and energy consumption records, waste reduction programs, circular economy initiatives, and ESG reporting obligations for regulatory and investor disclosure. | 22 |

**Subdomains:** environmental_measurement, governance_reporting, product_sustainability, supply_responsibility


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| environmental_measurement | biodiversity_impact | transactional_data | Transactional record capturing biodiversity impact assessments and nature-related risk data for Consumer Goods facilities and sourcing regions. Captures assessment date, facility or sourcing region reference, proximity to protected areas or biodiversity hotspots (km), land use type and area in hectares, biodiversity impact category (habitat loss, water stress, pollution, invasive species), TNFD (Taskforce on Nature-related Financial Disclosures) risk classification, mitigation measures in place, and net biodiversity impact score. Supports TNFD disclosure and nature-positive commitments. | 40 |
| environmental_measurement | carbon_emission | transactional_data | Transactional record of greenhouse gas (GHG) emissions measured or calculated at the facility, production line, product, or supply chain activity level. Captures emission date, emission source category (Scope 1 direct combustion, Scope 2 purchased energy, Scope 3 upstream/downstream), activity type (manufacturing, logistics, raw material extraction, packaging), CO2e quantity in metric tonnes, calculation methodology (GHG Protocol, ISO 14064), emission factor applied, data quality flag, and verification status. Primary operational record for carbon footprint tracking and CDP/GRI reporting. | 52 |
| environmental_measurement | carbon_offset | master_data | Master record for carbon offset credits purchased or retired by Consumer Goods to compensate for residual GHG emissions. Captures offset project name, project type (reforestation, renewable energy, methane capture, blue carbon), project location, registry (Gold Standard, Verra VCS, American Carbon Registry), credit vintage year, quantity purchased in tCO2e, quantity retired in tCO2e, retirement date, retirement certificate number, cost per tonne, and alignment with net-zero strategy (interim offset vs. permanent removal). Supports carbon neutrality claims and CDP climate disclosure. | 40 |
| environmental_measurement | energy_certificate | master_data | Master record for Renewable Energy Certificates (RECs), Guarantees of Origin (GOs), or I-RECs procured by Consumer Goods to substantiate renewable electricity claims. Captures certificate type (REC, GO, I-REC), energy source (solar, wind, hydro, biomass), generating facility name and location, certificate vintage period, quantity in MWh, registry name, certificate serial number, procurement date, retirement date, retirement confirmation number, and associated facility or business unit. Supports Scope 2 market-based accounting and RE100 commitment tracking. | 42 |
| environmental_measurement | energy_consumption | transactional_data | Transactional record of energy consumed across manufacturing facilities, distribution centers, and offices. Captures consumption period (daily, monthly), facility reference, energy type (natural gas, electricity, steam, renewable solar/wind), quantity in MWh or GJ, renewable energy percentage, energy intensity ratio (per unit of production), tariff rate, meter ID, and ISO 50001 compliance flag. Feeds into Scope 1 and Scope 2 carbon emission calculations and energy reduction program tracking. | 50 |
| environmental_measurement | environmental_incident | transactional_data | Transactional record of environmental incidents, spills, exceedances, and near-misses at Consumer Goods facilities or in the supply chain. Captures incident date and time, facility or location reference, incident type (chemical spill, air emission exceedance, wastewater discharge violation, soil contamination), severity classification, quantity and substance released, regulatory notification requirement flag, notification date, corrective action plan reference, root cause category, and closure date. Supports EPA/OSHA regulatory reporting and ISO 14001 nonconformance management. | 55 |
| environmental_measurement | social_impact_program | master_data | Master record for social responsibility and community impact programs under the ESG Social pillar. Captures program name, type (community investment, employee volunteering, DE&I initiative, living wage program, smallholder farmer support, women's economic empowerment, WASH access), geographic focus, target beneficiary group, program dates, investment amount, beneficiaries reached, UN SDG alignment, partner organizations, and measured social outcomes. Supports GRI 400-series reporting, SASB social metrics, and B Corp assessment. | 49 |
| environmental_measurement | waste_generation | transactional_data | Transactional record of waste generated, diverted, and disposed of at manufacturing and distribution facilities. Captures waste generation date, facility reference, waste stream type (plastic, cardboard, organic, hazardous, e-waste), waste quantity in kg or tonnes, disposal method (landfill, incineration, recycling, composting, energy recovery), diversion rate, waste contractor reference, manifest number for hazardous waste, and zero-waste-to-landfill program flag. Supports circular economy KPIs and EPA/OSHA regulatory compliance. | 41 |
| environmental_measurement | water_consumption | transactional_data | Transactional record of water withdrawal, usage, and discharge at the facility or process level. Captures measurement period, facility reference, water source type (municipal, groundwater, surface water, recycled), withdrawal volume in cubic meters, consumption volume, discharge volume, discharge destination (sewer, waterway, treatment plant), water stress area flag (based on WRI Aqueduct), water recycling rate, and regulatory permit reference. Supports water stewardship commitments and CDP Water disclosure. | 43 |
| governance_reporting | commitment_progress | transactional_data | Periodic operational record tracking actual progress against each ESG commitment target. Captures ESG commitment reference, reporting period (monthly, quarterly, annual), actual metric value achieved, unit of measure, target value for the period, percentage of target achieved, trajectory status (on-track, at-risk, off-track), data source system, reporting boundary (facility, region, global), and commentary on variances. Provides the time-series progress data layer that connects raw ESG metrics to formal commitment tracking and investor reporting. | 32 |
| governance_reporting | environmental_permit | master_data | Master record for environmental operating permits and licenses held by Consumer Goods facilities. Captures permit type (air emissions, wastewater discharge, hazardous waste storage, stormwater), issuing regulatory authority (EPA, state/local agency, EU competent authority), permit number, facility reference, permitted activity description, emission or discharge limits, permit issue date, expiry date, renewal status, and ISO 14001 EMS linkage. Serves as the authoritative registry of environmental operating authorizations. | 31 |
| governance_reporting | esg_audit | transactional_data | Transactional record of internal and external ESG audits and environmental management system audits conducted at Consumer Goods facilities. Captures audit date, audit type (ISO 14001 surveillance, ISO 22716 GMP environmental, third-party ESG audit, internal EMS audit), auditing body, facility or scope reference, audit findings count by severity (major nonconformance, minor nonconformance, observation), overall audit result, corrective action plan reference, next audit scheduled date, and certification renewal impact flag. Supports ISO 14001 certification maintenance and ESG assurance processes. | 51 |
| governance_reporting | esg_commitment | master_data | Master record for Consumer Goods formal ESG commitments, targets, and pledges. Captures commitment type (carbon neutrality, net-zero, water stewardship, zero-waste-to-landfill, deforestation-free), target year, baseline year and value, target value, measurement unit, commitment owner, governing body alignment (SBTi, UN Global Compact, RE100), public disclosure status, and progress tracking cadence. Serves as the authoritative registry linking to periodic commitment_progress records for time-series tracking. Referenced by esg_disclosure for external reporting. | 35 |
| governance_reporting | esg_disclosure | master_data | Master record for formal ESG disclosure submissions made to external frameworks, regulators, and investors. Captures disclosure framework (GRI, CDP, TCFD, SASB, EU CSRD, SEC Climate Rule, UN SDG), reporting period, submission date, disclosure status (draft, submitted, published), reported metrics summary (carbon emissions, water, waste, social indicators), assurance level (limited, reasonable, none), assurance provider, public URL, and materiality assessment reference. SSOT for all external ESG reporting obligations. | 47 |
| governance_reporting | materiality_assessment | master_data | Master reference table for materiality_assessment. Referenced by materiality_assessment_id. | 51 |
| product_sustainability | circular_initiative | master_data | Master record for circular economy programs managed by Consumer Goods. Captures initiative name, type (take-back program, refillable packaging, PCR content increase, packaging elimination, product-as-a-service, industrial symbiosis), target material or product category, launch date, target end date, geographic scope, material recovered/diverted in tonnes, partner organizations, investment amount, consumer participation rate, and progress status against circular economy KPIs. Supports Ellen MacArthur Foundation reporting and public sustainability communications. | 54 |
| product_sustainability | packaging_profile | master_data | Master record defining the sustainability attributes of a product's packaging configuration. Captures SKU/GTIN reference, packaging component type (primary, secondary, tertiary), material composition (PCR plastic %, virgin plastic %, glass, aluminum, paper/cardboard), recyclability rating, compostability certification, recycled content percentage, packaging weight in grams, lightweighting reduction vs. prior version, FSC certification flag for paper-based materials, and EU Packaging and Packaging Waste Regulation compliance status. SSOT for packaging sustainability data linked to the product domain. | 61 |
| product_sustainability | product_lca | master_data | Master record for Life Cycle Assessment (LCA) studies conducted on Consumer Goods products or product categories. Captures SKU or product category reference, LCA study type (cradle-to-gate, cradle-to-grave, cradle-to-cradle), functional unit definition, system boundary description, study date, LCA practitioner, ISO 14040/14044 compliance flag, total carbon footprint in kg CO2e per functional unit, water footprint, key hotspot life cycle stages, peer review status, and intended use (product labeling, R&D reformulation, regulatory submission). Supports product-level environmental footprint claims and eco-design decisions. | 40 |
| supply_responsibility | deforestation_assessment | transactional_data | Transactional record of deforestation risk assessments conducted for high-risk commodities (palm oil, soy, paper/pulp, cattle-derived ingredients, cocoa) in the Consumer Goods supply chain. Captures assessment date, commodity type, supplier or sourcing region reference, risk methodology (Trase, Global Forest Watch, EUDR traceability), deforestation risk score, forest cover change data, certification coverage percentage, traceability level (farm, mill, trader), EUDR (EU Deforestation Regulation) compliance status, and remediation action required flag. Supports EUDR compliance and zero-deforestation commitments. | 48 |
| supply_responsibility | sourcing_certification | master_data | Master record for sustainable sourcing certifications held by Consumer Goods or its suppliers for specific raw materials or ingredients. Captures certification type (RSPO, FSC, Rainforest Alliance, Fair Trade, UTZ, organic), certified entity (supplier or internal facility), raw material or ingredient covered, certification body, certificate number, issue date, expiry date, certification scope (mass balance, segregated, book-and-claim), annual certified volume, and audit status. Supports RSPO and FSC compliance reporting and Scope 3 sustainable procurement claims. | 40 |
| supply_responsibility | supplier_esg_eval | transactional_data | Transactional record of sustainability assessments conducted on raw material and packaging suppliers. Captures assessment date, supplier reference, assessment type (self-assessment questionnaire, third-party audit, EcoVadis scorecard, Sedex SMETA), assessment scope (environmental, social, governance, ethics), overall sustainability score, individual pillar scores, critical findings count, corrective action required flag, corrective action due date, reassessment date, and assessor identity. Supports responsible sourcing programs and Scope 3 supply chain sustainability management. | 52 |
| supply_responsibility | supply_chain_activity | master_data | Master reference table for supply_chain_activity. Referenced by supply_chain_activity_id. | 46 |

<a id="domain-workforce"></a>

### Domain: Workforce

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| workforce | corporate | 3 | Owns human capital and workforce management data. Manages employee master records, organizational structure, payroll, benefits, talent acquisition, performance management, compensation, workforce planning, OSHA safety incident records, training records, and labor compliance across manufacturing and commercial operations. Integrates with Workday HCM. | 21 |

**Subdomains:** compensation_processing, personnel_management, talent_operations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| compensation_processing | benefit_enrollment | transactional_data | Employee benefit enrollment records | 13 |
| compensation_processing | payroll_group | master_data | Payroll group configuration | 9 |
| compensation_processing | payroll_period | master_data | Payroll period calendar | 10 |
| compensation_processing | payroll_record | transactional_data | Individual payroll transaction records | 12 |
| compensation_processing | payroll_run | master_data | Payroll processing run header | 11 |
| personnel_management | employee | master_data | Core employee master record | 19 |
| personnel_management | job_profile | reference_data | Job profile definitions | 9 |
| personnel_management | labor_relation | master_data | Labor relations and union records | 10 |
| personnel_management | org_unit | master_data | Organizational unit hierarchy | 11 |
| personnel_management | position | master_data | Position master data | 11 |
| personnel_management | shift_schedule | master_data | Employee shift scheduling | 10 |
| personnel_management | work_location | master_data | Physical work location master data | 15 |
| talent_operations | applicant | master_data | Job applicant master records | 12 |
| talent_operations | enrollment | association_data | General enrollment records for programs and initiatives | 49 |
| talent_operations | job_application | transactional_data | Candidate job applications | 12 |
| talent_operations | performance_review | transactional_data | Employee performance review records | 11 |
| talent_operations | recruiting_requisition | transactional_data | Job requisition records | 12 |
| talent_operations | safety_incident | transactional_data | Workplace safety incident records | 14 |
| talent_operations | time_entry | transactional_data | Employee time and attendance records | 12 |
| talent_operations | training_course | reference_data | Training course catalog | 11 |
| talent_operations | training_record | transactional_data | Employee training completion records | 10 |

## Metric Views

Total metric views generated: **217**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | distribution_cycle_count | distribution | distribution_cycle_count | Cycle count accuracy and inventory control metrics |
| 2 | distribution_facility | distribution | distribution_facility | Distribution facility operational performance and capacity metrics |
| 3 | distribution_inbound_receipt | distribution | inbound_receipt | Inbound receiving operations and quality compliance metrics |
| 4 | distribution_inventory_position | distribution | inventory_position | Inventory availability and stock health metrics |
| 5 | distribution_load_plan | distribution | load_plan | Load planning efficiency and trailer utilization metrics |
| 6 | distribution_otif_event | distribution | otif_event | On-time in-full delivery performance and compliance metrics |
| 7 | distribution_outbound_order | distribution | outbound_order | Outbound order fulfillment and delivery performance metrics |
| 8 | distribution_pick_task | distribution | pick_task | Warehouse picking productivity and accuracy metrics |
| 9 | distribution_returns_receipt | distribution | returns_receipt | Product returns processing and disposition metrics |
| 10 | distribution_shipment | distribution | distribution_shipment | Distribution shipment execution and freight performance metrics |
| 11 | distribution_wave | distribution | wave | Wave planning and execution performance metrics |
| 12 | inventory_cycle_count | inventory | inventory_cycle_count | Cycle count accuracy and variance metrics for inventory control, audit compliance, and operational excellence measurement. |
| 13 | inventory_lot_batch | inventory | lot_batch | Lot and batch traceability metrics for quality management, expiry tracking, and regulatory compliance in consumer goods supply chain. |
| 14 | inventory_oos_event | inventory | oos_event | Out-of-stock event metrics tracking stockout frequency, duration, and lost sales impact for service level and revenue protection analysis. |
| 15 | inventory_recall_event | inventory | recall_event | Product recall event metrics tracking recall scope, recovery effectiveness, and regulatory compliance for risk management and quality assurance. |
| 16 | inventory_safety_stock_policy | inventory | safety_stock_policy | Safety stock policy metrics for inventory planning optimization, service level management, and working capital efficiency. |
| 17 | inventory_stock_adjustment | inventory | stock_adjustment | Inventory adjustment transaction metrics tracking write-offs, corrections, and shrinkage for inventory accuracy and loss prevention analysis. |
| 18 | inventory_stock_movement | inventory | stock_movement | Inventory movement transaction metrics tracking transfers, receipts, issues, and adjustments for supply chain velocity and accuracy analysis. |
| 19 | inventory_stock_position | inventory | stock_position | Core inventory position metrics tracking on-hand, available, allocated, and reserved quantities by SKU and location for inventory optimization and fulfillment planning. |
| 20 | inventory_stock_valuation | inventory | stock_valuation | Inventory valuation metrics by costing method for financial reporting, working capital management, and inventory investment optimization. |

*... and 197 more metric views. See the `metrics/` folder for full details.*