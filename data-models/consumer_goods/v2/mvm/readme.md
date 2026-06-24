# Consumer_Goods Lakehouse Data Model

**v2_mvm** generated using Vibe Modelling Agent on June 24, 2026 at 01:55 AM

This document outlines a vibed Lakehouse data model for the Consumer_Goods business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Distribution](#domain-distribution)
  - [Manufacturing](#domain-manufacturing)
  - [Procurement](#domain-procurement)
  - [Quality](#domain-quality)
  - [Supply](#domain-supply)
  - [Product](#domain-product)
  - [Promotion](#domain-promotion)
  - [Sales](#domain-sales)
  - [Finance](#domain-finance)
- [Metric Views](#metric-views)

## Output Folder Structure

All artifacts for version **v2_mvm** are organized as follows:

```
v2/mvm/
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
| `schemas/` | `consumer_goods_<domain>_schema_v2_mvm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `consumer_goods_catalogs_v2_mvm.sql` (catalog-level DDL) |
| `metrics/` | `consumer_goods_<domain>_metrics_v2_mvm.sql` (one file per domain) |
| `docs/` | `consumer_goods_model_v2_mvm.xlsx`, `consumer_goods_model_v2_mvm.csv`, `releasenotes.txt` |
| `diagram/` | `consumer_goods_dbml_v2_mvm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `consumer_goods_rdf_v2_mvm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | MVM (Minimum Viable Model) |
| Total Domains | 9 |
| Total Subdomains | 25 |
| Total Products | 99 |
| Total Attributes | 3583 |
| Primary Keys | 99 |
| Foreign Keys | 569 |
| Avg Attributes/Product | 36.2 |
| Metric Views | 74 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Consumer_Goods | Consumer_Goods | MVM (Minimum Viable Model) | consumer goods industry enterprise data model. |  | 2 |

## Business Domains & Subdomains

<a id="domain-distribution"></a>

### Domain: Distribution

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| distribution | operations | 3 | Owns warehouse operations, inventory management, and order fulfillment across distribution centers. Manages inbound/outbound logistics within DCs, put-away/picking/packing processes, cycle counting, FEFO/FIFO inventory rotation, WMS integration (Blue Yonder), OTIF performance, OSA metrics, and DSD execution for direct store delivery channels. | 9 |

**Subdomains:** facility_operations, inbound_receiving, outbound_fulfillment


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| facility_operations | distribution_facility | master_data | Physical distribution center or warehouse used for storing and shipping finished goods to customers. SSOT owner for distribution/logistics facility master. Distinct from manufacturing_facility which represents production plants. | 54 |
| facility_operations | inventory_position | master_data | Current on-hand inventory position at the DC-location-SKU-lot level within distribution center walls. Captures storage location, SKU, lot number, manufacture and expiry dates, quantity on hand, allocated quantity, available-to-pick (ATP) quantity, quarantine quantity, inventory status (available, hold, damaged, expired), and last cycle count date. This is the operational working inventory view for DC execution — distinct from the inventory domain's network-wide planning position which aggregates across all nodes. | 55 |
| facility_operations | storage_location | master_data | Physical storage bin/slot/rack within a distribution facility (WMS-managed). SSOT for physical DC location layout. Distinct from inventory.inventory_storage_location which is the logical inventory holding location. | 42 |
| inbound_receiving | inbound_receipt | transactional_data | Transactional record capturing the physical receipt of goods at a DC from suppliers, manufacturing plants, or inter-DC transfers. Records ASN reference, carrier, trailer/container ID, dock door, receipt date/time, received quantity by SKU/lot, temperature check results, and discrepancy flags. Integrates with SAP WM goods receipt and Blue Yonder WMS inbound processing. Drives inventory on-hand updates and FEFO/FIFO lot registration. | 51 |
| inbound_receiving | inbound_receipt_line | transactional_data | Line-level detail for each SKU/lot received within an inbound receipt transaction. Captures SKU code, GTIN, lot number, manufacture date, expiry date, received quantity (cases and eaches), unit of measure, pallet ID, temperature at receipt, and variance from expected ASN quantity. Supports FEFO/FIFO lot registration and discrepancy resolution workflows. | 43 |
| outbound_fulfillment | outbound_order | transactional_data | Master outbound fulfillment order record representing a customer or retailer replenishment request to be fulfilled from a DC. Captures order number, order type (retail replenishment, DSD, e-commerce, inter-DC transfer), customer/account reference, requested ship date, required delivery date, priority, OTIF commitment, and order status lifecycle. Sourced from SAP SD and Salesforce Consumer Goods Cloud order management. | 47 |
| outbound_fulfillment | outbound_order_line | transactional_data | Line-level detail for each SKU within an outbound fulfillment order. Records SKU code, GTIN, ordered quantity, confirmed quantity, allocated quantity, picked quantity, shipped quantity, unit of measure, lot number, expiry date, and line-level OTIF status. Enables order fill rate tracking, short-ship identification, and OSA impact analysis at the SKU-customer level. | 46 |
| outbound_fulfillment | pick_task | transactional_data | Fulfillment task record covering both picking and packing operations within DC outbound execution. For picking: captures pick list reference, source location, SKU, lot, pick quantity, assigned operator, wave/batch reference, pick accuracy flag, and task timestamps. For packing: captures pack station, carton/pallet ID, packed SKUs and quantities, packaging material, gross weight, dimensions, GS1-128/SSCC label, and packer operator. Supports wave picking, batch picking, zone picking, and cartonization strategies in Blue Yonder WMS. Task_type discriminator distinguishes pick vs pack execution steps. | 44 |
| outbound_fulfillment | shipment | transactional_data | Outbound shipment dispatched from a distribution center to a customer/store. SSOT for DC-originated shipment records. Distinct from logistics.logistics_shipment which tracks carrier-level transport execution. | 61 |

<a id="domain-manufacturing"></a>

### Domain: Manufacturing

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| manufacturing | operations | 3 | Owns production planning, scheduling, and execution across manufacturing facilities. Manages production orders, batch records, work orders, MES integration (Siemens Opcenter), line performance (OEE), yield tracking, MRP runs, GMP compliance events, changeover management, and shop floor data collection aligned with ISO 22716 standards. | 10 |

**Subdomains:** facility_resources, production_planning, shop_execution


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| facility_resources | equipment | master_data | Master reference table for equipment. Referenced by equipment_id. | 59 |
| facility_resources | manufacturing_facility | master_data | Physical manufacturing plant or factory where products are produced. SSOT owner for production facility master. Distinct from distribution_facility which represents warehouses/DCs. | 44 |
| facility_resources | production_line | master_data | Master record for each physical production line within a manufacturing facility. Captures line code, line name, facility reference, line type (filling, blending, packaging, assembly), design speed (units/hour), nominal OEE target, GMP classification, MES asset tag (Siemens Opcenter), changeover time standard (minutes), and current operational status. Enables OEE benchmarking, scheduling capacity allocation, and MES integration at the line level. | 44 |
| facility_resources | work_center | master_data | Master record for individual work centers (machines, stations, cells) within a production line. Captures work center code, description, work center type (mixing vessel, filling machine, labeler, capper, palletizer), rated capacity, standard cycle time, maintenance class, MES equipment ID (Siemens Opcenter), GMP equipment qualification status (IQ/OQ/PQ), and calibration due date. Supports MRP capacity planning, scheduling, and equipment qualification tracking per ISO 22716. | 47 |
| production_planning | manufacturing_bom | master_data | Bill of Materials master record (header + component lines) defining the complete material structure for each finished good or semi-finished SKU. Header captures BOM number, BOM type (production, co-product, phantom), base quantity, unit of measure, validity dates, PLM system reference, and BOM status. Component lines capture item number, material reference (raw material, packaging, semi-finished), component quantity per base quantity, scrap factor percentage, item category (stock, non-stock, phantom), INCI name for cosmetic ingredients, allergen flag, hazardous material flag, and component validity dates. SSOT for MRP explosion, production order material requirements, COGS calculation, and regulatory ingredient disclosure per FDA/EU REACH. This is the single authoritative source for all BOM component data — no separate component entity exists. | 43 |
| production_planning | planned_order | transactional_data | Production planning record representing the complete planning pipeline from S&OP/IBP through MRP execution to production order conversion. Encompasses both Master Production Schedule (MPS) entries (planned quantities by SKU/facility/period with schedule versioning) and MRP-generated planned orders (system-proposed production or procurement proposals). Captures planned order ID, order type (MPS, MRP planned, CBP), SKU, plant, MRP run reference, planned quantity, scheduled start/finish dates, planning period (week/month), schedule version, S&OP cycle reference, IBP plan version, firming indicator, schedule status (draft, firmed, released, converted, deleted), exception message code, planner ID, and conversion status. SSOT for MRP exception management, MPS governance, and the complete production planning pipeline from demand signal through to production order creation. | 55 |
| production_planning | routing | master_data | Production routing master (header + operation steps) defining the complete manufacturing process sequence for a finished or semi-finished SKU. Header captures routing number, routing type (standard, reference, rate), base quantity, plant, validity dates, and total standard lead time. Operation steps capture operation number, work center assignment, standard values (setup time, machine time, labor time), control key (internal processing, external processing, milestone), yield quantity, scrap percentage, GMP critical step flag, and IPC checkpoint flag. SSOT for production scheduling, capacity planning, standard cost calculation, and GMP batch record generation per ISO 22716. This is the single authoritative source for all routing operation data — no separate operation entity exists. Aligned with SAP PP Routing master. | 41 |
| shop_execution | batch_record | transactional_data | Electronic batch manufacturing record (eBMR) capturing the complete GMP-compliant execution history for a production batch. Captures batch number, production order reference, SKU, batch size, manufacturing date, expiry date (FEFO), facility, production line, batch status (in-process, released, rejected, quarantine, recalled), GMP deviation flag, electronic signature records, yield percentage, and Veeva Vault document reference. SSOT for GMP batch traceability per ISO 22716 and FDA 21 CFR Part 211. | 51 |
| shop_execution | production_confirmation | transactional_data | Shop floor execution and confirmation record capturing the complete lifecycle of each manufacturing operation within a production order — from assignment and scheduling through actual execution and final confirmation. Captures work order number, parent production order reference, operation number, work center, assigned operator, scheduled start/end, actual start/end, confirmation type (partial, final), confirmed yield quantity, confirmed scrap quantity, actual setup/machine/labor time, operation status (open, in-progress, completed, cancelled), posting date, and MES transaction reference (Siemens Opcenter). SSOT for granular shop floor execution tracking, labor confirmation, production order settlement, and OEE calculation. Subsumes discrete work order assignment data. | 48 |
| shop_execution | production_order | transactional_data | Core transactional record representing a manufacturing production order issued to produce a specific SKU quantity at a facility. Captures order number, order type (PP01 standard, PP03 rework), SKU reference, plant, production line, scheduled start/finish dates, actual start/finish dates, order quantity, confirmed quantity, scrap quantity, order status (created, released, partially confirmed, technically complete, closed), MRP controller, and cost object. SSOT for production execution tracking in SAP S/4HANA PP. | 58 |

<a id="domain-procurement"></a>

### Domain: Procurement

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| procurement | operations | 2 | Owns sourcing, supplier management, and purchase order execution for raw materials, packaging, and indirect goods. Manages supplier master data, contracts, RFQs, purchase requisitions, PO lifecycle, goods receipt, invoice verification, MOQ terms, SDS documentation, supplier performance scorecards, VMI programs, and sustainable sourcing initiatives (FSC, RSPO). | 10 |

**Subdomains:** purchase_operations, supplier_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| purchase_operations | goods_receipt | transactional_data | Receipt of goods from suppliers | 12 |
| purchase_operations | invoice_line | transactional_data | Supplier invoice line items | 12 |
| purchase_operations | po_line | transactional_data | Purchase order line items | 17 |
| purchase_operations | purchase_order | transactional_data | Purchase orders to suppliers | 16 |
| purchase_operations | supplier_invoice | transactional_data | Invoices from suppliers | 14 |
| supplier_management | approved_supplier_list | master_data | Approved suppliers for materials | 11 |
| supplier_management | contract_line | master_data | Line items in supplier contracts | 13 |
| supplier_management | supplier | master_data | Master record for suppliers providing goods and services | 18 |
| supplier_management | supplier_contract | master_data | Contracts with suppliers | 18 |
| supplier_management | supplier_site | master_data | Physical locations for suppliers | 17 |

<a id="domain-quality"></a>

### Domain: Quality

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| quality | operations | 2 | Owns quality assurance, quality control, and GMP compliance data across the product lifecycle. Manages QC inspection results, non-conformance records, CAPA processes, batch release decisions, stability studies, certificate of analysis, GMP audit findings, supplier quality assessments, product complaints, and regulatory hold events. Integrates with SAP QM and Veeva Vault. | 10 |

**Subdomains:** compliance_management, inspection_control


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| compliance_management | batch_release | transactional_data | Final quality approval authorizing a manufactured batch for distribution and sale | 22 |
| compliance_management | capa | transactional_data | Corrective and Preventive Action record to address root causes of quality issues and prevent recurrence | 26 |
| compliance_management | certificate_of_analysis | transactional_data | Official document certifying that a batch meets all quality specifications and regulatory requirements | 24 |
| compliance_management | nonconformance | transactional_data | Record of quality defect, deviation, or non-compliance event requiring investigation and corrective action | 32 |
| compliance_management | product_complaint | transactional_data | Customer or consumer complaint regarding product quality, safety, or performance requiring investigation | 28 |
| inspection_control | inspection_lot | transactional_data | Specific batch or lot of material/product subject to quality inspection per the inspection plan | 27 |
| inspection_control | inspection_plan | master_data | Master plan defining inspection procedures, sampling strategies, and acceptance criteria for materials, in-process, and finished goods | 23 |
| inspection_control | inspection_result | transactional_data | Individual test or inspection characteristic result recorded during quality inspection | 22 |
| inspection_control | specification | master_data | Quality specification defining acceptance criteria, test methods, and limits for materials and products | 21 |
| inspection_control | usage_decision | transactional_data | Disposition decision for inspected lot: accept, reject, rework, or conditional release | 17 |

<a id="domain-supply"></a>

### Domain: Supply

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| supply | operations | 3 | Owns end-to-end supply chain planning and orchestration including demand planning, supply planning, inventory optimization, S&OP/IBP processes, DRP execution, safety stock targets, ATP/CTP calculations, supply network design, demand sensing, forecast accuracy tracking, and supply risk management. Integrates with SAP IBP. | 10 |

**Subdomains:** demand_planning, inventory_management, network_replenishment


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| demand_planning | demand_plan | master_data | Core master entity representing the demand plan across all versions, stages, and consensus outcomes within the S&OP/IBP cycle for each SKU/location/channel/planning period combination. Each record represents a specific version-point: captures version name, version type (statistical baseline/field sales overlay/marketing-adjusted/consensus/final approved), planning cycle reference, created-by persona, approval status, effective date range, planning bucket (weekly/monthly), statistical baseline quantity, commercial overlay, marketing event uplift, new product launch volume, consensus quantity, variance to statistical baseline, channel disaggregation, promotional overlays, and lifecycle stage. The consensus version represents the single agreed demand signal passed to supply planning. Enables forecast accuracy benchmarking across versions. Sourced from SAP IBP Demand Planning module. | 48 |
| demand_planning | forecast_version | master_data | Tracks each named version or snapshot of the demand forecast within the IBP/S&OP cycle (e.g., statistical baseline, field sales overlay, marketing-adjusted, consensus, final approved). Captures version name, version type, planning cycle reference, created-by persona, approval status, and effective date range. Enables forecast accuracy benchmarking across versions. | 46 |
| demand_planning | planning_run | master_data | Master reference table for planning_run. Referenced by planning_run_id. | 32 |
| demand_planning | sku_planning_param | master_data | Master entity storing SKU-level planning parameters used in demand and supply planning calculations. Captures planning horizon, lot size, minimum order quantity (MOQ), shelf life (days), FEFO/FIFO flag, planning strategy (make-to-stock/make-to-order), ABC/XYZ classification, demand pattern type, seasonality index, and IBP planning group assignment. Distinct from product master (owned by product domain) as this captures supply-planning-specific parameters. | 58 |
| inventory_management | atp_record | transactional_data | Transactional record capturing the Available-to-Promise (ATP) and Capable-to-Promise (CTP) calculation results for each SKU/location/date combination. Stores confirmed ATP quantity, CTP quantity, cumulative ATP, demand pegging reference, supply pegging reference, calculation timestamp, and ATP method (simple, cumulative, multi-level). Consumed by sales order management for order promising. | 49 |
| inventory_management | inventory_policy | master_data | Master entity defining inventory policy parameters, safety stock calculations, service level commitments, and OTIF targets for each SKU/location node in the supply network. Captures safety stock target and calculated quantities (days of supply, units, calculation method, demand variability, lead time variability, service level input, calculated vs approved SS units, effective date, review status), reorder point, min/max levels, cycle stock target, replenishment method (MRP/DRP/VMI), review cycle, service level targets (fill rate %, on-time delivery %, OTIF composite %), customer/channel-level OTIF commitments, retailer-mandated target flags, penalty clause indicators, and measurement windows. Owned by supply planning; consumed by distribution and manufacturing execution. | 47 |
| inventory_management | safety_stock | transactional_data | Transactional record capturing the calculated and approved safety stock quantity for each SKU/location/time-period combination. Stores calculation method (statistical, days-of-supply, manual override), demand variability, lead time variability, service level input, calculated SS units, approved SS units, effective date, and review status. Distinct from inventory_policy (policy target) as this captures the actual calculated output. | 54 |
| network_replenishment | network_lane | master_data | Master entity defining the sourcing lane between two supply network nodes (source-destination pair). Captures lane type (production, transfer, external procurement), primary/secondary sourcing priority, standard lead time, transportation lead time, minimum order quantity (MOQ), lot size, and active status. Used by DRP and IBP to determine replenishment routing. | 45 |
| network_replenishment | network_node | master_data | Master entity representing each node in the supply network (manufacturing plant, regional DC, forward DC, co-manufacturer, 3PL site). Captures node type, geographic location, capacity class, lead time to downstream nodes, sourcing rules, and active status. Forms the backbone of the supply network design used in IBP supply planning and DRP. | 44 |
| network_replenishment | replenishment_order | transactional_data | Supply network replenishment order for inter-node stock transfers driven by DRP/MRP planning. SSOT for network-level supply replenishment. Distinct from inventory.inventory_replenishment_order which is location-level restocking. | 51 |

<a id="domain-product"></a>

### Domain: Product

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| product | business | 3 | Single source of truth for all product master data across the CPG/FMCG portfolio. Owns SKU definitions, GTIN/UPC/EAN identifiers, product hierarchies, BOM structures, PLM lifecycle stages, formulation records, packaging specifications, INCI ingredient declarations, and regulatory labeling attributes. Serves as the authoritative product catalog referenced by all other domains. | 12 |

**Subdomains:** compliance_certification, material_composition, product_identity


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| compliance_certification | certification | master_data | Product certifications | 35 |
| compliance_certification | label_spec | master_data | Label specifications | 46 |
| material_composition | bom_line | master_data | BOM line items | 44 |
| material_composition | material | master_data | Material master | 33 |
| material_composition | packaging_spec | master_data | Product packaging specifications | 44 |
| material_composition | product_bom | master_data | Product bill of materials | 41 |
| product_identity | brand | master_data | Product brand master | 39 |
| product_identity | category | master_data | Product category hierarchy | 1 |
| product_identity | gtin_registry | master_data | GTIN registry for product identification | 43 |
| product_identity | hierarchy | reference_data | Product hierarchy structure | 43 |
| product_identity | product_category | master_data | Product categories | 25 |
| product_identity | sku | master_data | Stock keeping unit master | 52 |

<a id="domain-promotion"></a>

### Domain: Promotion

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| promotion | business | 3 | Owns trade promotion planning, execution, and optimization (TPM/TPO). Manages promotional calendars, trade spend allocation, retailer funding agreements, promotional pricing (Hi-Lo, EDLP), accruals, deductions, post-event analysis, promotional lift measurement, ROI/GMROI analysis, and retailer rebate settlements. Integrates with Salesforce TPM. | 11 |

**Subdomains:** deduction_management, funding_settlement, trade_planning


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| deduction_management | deduction | transactional_data | Transactional record representing the full lifecycle of a retailer deduction from initial short-payment through final settlement. Captures deduction number, retailer account, invoice reference, deduction amount, deduction type (promotional, pricing, shortage, compliance), deduction date, dispute status (open, approved, disputed, written-off), and complete settlement details: settlement date, settlement method (credit memo, check, offset against future invoice, write-off), settled amount, approved amount, disputed amount, settlement reason code, approver, and linkage to originating promotion event and funding agreement. Serves as the single entity for the entire deduction management workflow — no separate settlement record exists. Central to trade spend reconciliation, dispute resolution, and retailer relationship management. | 45 |
| deduction_management | deduction_settlement | transactional_data | Transactional record capturing the resolution and settlement of a retailer deduction. Tracks settlement date, settlement method (credit memo, check, offset against future invoice, write-off), settled amount, approved amount, disputed amount, settlement reason code, approver, and linkage to the originating deduction and funding agreement. Enables closed-loop deduction management and accurate trade spend reconciliation. | 37 |
| funding_settlement | accrual | transactional_data | Trade promotion accrual tracking expected promotional spend obligations. SSOT for trade promotion accruals. Distinct from finance.finance_accrual which is the general corporate accrual. | 44 |
| funding_settlement | funding_agreement | master_data | Master entity representing a formal retailer funding agreement (RFA) or joint business plan (JBP) between the CPG manufacturer and a retail account. Captures agreement name, retailer account, agreement type (annual lump sum, scan-back, co-op, slotting, performance-based), total committed funding amount, funding period, payment terms, performance conditions, approval status, and signatory details. Serves as the contractual basis for trade spend commitments and deduction settlements. | 52 |
| funding_settlement | funding_allocation | association_data | This association product represents the Contract between trade_promotion and funding_agreement. It captures the formal financial commitment that links a specific funding agreement to a specific trade promotion, recording how much of the agreement's budget is allocated to the promotion, at what percentage, and over what effective period. Each record links one trade_promotion to one funding_agreement with attributes (allocated_amount, allocation_percentage, funding_type, effective dates) that exist only in the context of this specific allocation relationship. Managed by brand managers and trade finance teams in TPM systems as a distinct operational entity.. Existence Justification: In Consumer Goods TPM, a trade promotion can draw funding from multiple funding agreements (e.g., an annual lump-sum RFA plus a scan-back agreement plus a co-op fund), and a single funding agreement (e.g., an annual JBP) can fund multiple distinct trade promotions across the year. Brand managers and trade finance teams actively manage these allocations — deciding how much of each agreement's budget is committed to each promotion — as a distinct operational process in systems like Salesforce TPM and SAP TPM. The relationship itself carries financial data (allocated_amount, allocation_percentage, funding_type) that belongs neither to the promotion nor the agreement alone, but to the specific funding commitment between them. | 10 |
| funding_settlement | trade_spend_allocation | transactional_data | Transactional record capturing the allocation of trade spend budget to a specific promotion event, retailer account, brand, or SKU group. Tracks allocated amount, spend type (off-invoice discount, scan-back, bill-back, lump sum, co-op advertising, slotting fee, display allowance, free goods), spend category classification, GL account mapping, fiscal period, cost center, approval status, and variance between planned and committed spend. Feeds into COGS and trade spend reporting for S&OP and finance reconciliation. | 44 |
| trade_planning | event | transactional_data | Trade promotion event representing a specific promotional execution with a retailer (TPR, display, feature). SSOT for trade promotion events. Distinct from marketing.marketing_event which covers brand marketing events. | 43 |
| trade_planning | event_sku | transactional_data | Association entity linking individual SKUs (GTINs/UPCs) to a specific promotion event with full promotional pricing authority. Captures SKU-level promotional details including promoted price, promoted price type (Hi-Lo temporary price reduction, EDLP, multi-buy, BOGO, scan-back, off-invoice, bill-back), price reduction depth (%), regular shelf price (RSP/MSRP), effective date range, planned promotional volume (cases/units), actual promotional volume, baseline volume estimate, incremental lift volume, promotional discount amount per unit, retailer account, channel, and pricing approval status. Serves as the SSOT for SKU-level promotional pricing within trade events — distinct from standard list pricing owned by the product domain. Enables SKU-level trade spend, lift analysis, and promotional price compliance per event. | 45 |
| trade_planning | promoted_price | master_data | Master entity capturing the promotional price points defined for SKUs within a promotion event or pricing program. Tracks promoted price type (Hi-Lo temporary price reduction, EDLP, multi-buy, BOGO, scan-back price), promoted price amount, regular shelf price (RSP/MSRP), price reduction depth (%), effective date range, retailer account, channel, and approval status. Distinct from standard list pricing — this entity owns the promotional price layer used during trade events. | 38 |
| trade_planning | trade_calendar | master_data | Master entity representing the annual or periodic trade promotional calendar for a brand, category, or retailer account. Captures calendar name, fiscal year, planning cycle, owning brand/category manager, retailer account scope, calendar status (draft, approved, locked), total planned trade spend envelope, and number of planned promotion events. Serves as the planning container for all trade promotion events within a given period and account relationship. | 33 |
| trade_planning | trade_promotion | master_data | Core master entity for trade promotion programs. Captures the full definition of a trade promotion including name, type (Hi-Lo, EDLP, display, coupon, scan-back, off-invoice), promotional period, owning brand/category, status (planned, active, closed, cancelled), total authorized trade spend budget, promotion objectives, promotion type classification (temporary price reduction, feature ad, display, BOGO, multi-buy, scan-back, coupon, loyalty reward), applicable channels, and integration reference to Salesforce TPM. Serves as the SSOT for all trade promotion definitions and the parent entity for all promotion events, spend allocations, and post-event analyses. | 41 |

<a id="domain-sales"></a>

### Domain: Sales

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| sales | business | 3 | Owns commercial sales execution, order management, and revenue transactions across all channels (retail, wholesale, DTC, e-commerce). Manages sales orders, pricing agreements, sales force automation (SFA), retail account call records, POG compliance, RSP/MSRP price management, ACV/TDP/SOM metrics, and field sales KPIs. Integrates with Salesforce Consumer Goods Cloud. | 13 |

**Subdomains:** account_management, order_processing, pricing_strategy


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| account_management | account_address | master_data | Physical and mailing addresses for trade accounts | 14 |
| account_management | account_assignment | association_data | This association product represents the Role-based assignment between a sales rep and a trade account. It captures which reps are actively (or historically) responsible for a given trade account, in what capacity, and for what period. Each record links one rep to one trade_account with attributes — role, start_date, end_date — that exist only in the context of this assignment relationship and are required for commission calculation and sales performance reporting.. Existence Justification: In consumer goods SFA (Salesforce Automation), a sales rep manages a portfolio of many trade accounts, and a large B2B trade account is actively served by multiple reps in distinct roles (e.g., key account manager, field rep, inside sales rep). This is a well-established operational concept — 'Account Team Membership' or 'Account Assignment' — that businesses actively create, update, and deactivate as territories shift and roles change. The relationship carries its own first-class attributes (role, start_date, end_date) that belong to neither the rep nor the account alone. | 6 |
| account_management | account_contact | master_data | Contact persons associated with trade accounts | 11 |
| account_management | rep | master_data | Sales representatives | 11 |
| account_management | retail_store | master_data | Physical retail locations associated with trade accounts | 17 |
| account_management | territory | master_data | Sales territories for account assignment | 9 |
| account_management | trade_account | master_data | Customer account master for B2B trade relationships | 17 |
| order_processing | invoice | transactional_data | Sales invoices issued to trade accounts | 15 |
| order_processing | order | transactional_data | Sales orders from trade accounts | 19 |
| order_processing | return_order | transactional_data | Product returns from trade accounts | 13 |
| pricing_strategy | price_list | master_data | Master price lists for products | 10 |
| pricing_strategy | price_list_item | master_data | Individual SKU prices within price lists | 9 |
| pricing_strategy | pricing_agreement | master_data | Master pricing agreements with trade accounts | 14 |

<a id="domain-finance"></a>

### Domain: Finance

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| finance | corporate | 3 | Owns financial planning, accounting, and reporting including general ledger, accounts payable/receivable, cost accounting, COGS allocation, EBITDA reporting, DSO/DIO tracking, budgeting, revenue recognition, and SOX-compliant financial controls and audit trails. Integrates with SAP S/4HANA FI/CO and Oracle Cloud Financials. | 14 |

**Subdomains:** accounting_structure, ledger_transactions, payable_receivable


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| accounting_structure | chart_of_accounts | master_data | Master reference table for chart_of_accounts. Referenced by chart_of_accounts_id. | 66 |
| accounting_structure | company_code | master_data | Master reference table for company_code. Referenced by company_code_id. | 46 |
| accounting_structure | cost_center | master_data | Master record for organizational cost centers used in SAP S/4HANA CO module. Defines the financial accountability units within the CPG enterprise — brand units, manufacturing plants, regional sales offices, and shared service centers. Each cost center carries a hierarchy path, responsible manager, controlling area, profit center assignment, currency, and active period. Serves as the foundational dimension for all cost accounting, COGS allocation, and EBITDA reporting. | 34 |
| accounting_structure | gl_account | master_data | General ledger chart of accounts master for the consumer goods enterprise. Defines every account in the COA including P&L accounts (revenue, COGS, trade spend, marketing, SG&A), balance sheet accounts (inventory, AR, AP, fixed assets), and statistical accounts. Stores account type, financial statement category, tax category, reconciliation account flag, currency, and controlling relevance. Source of truth for all financial postings in SAP S/4HANA FI and Oracle Cloud Financials. | 61 |
| accounting_structure | ledger | master_data | Financial ledger master defining the accounting ledgers maintained in the enterprise — leading ledger (IFRS/GAAP), parallel ledgers for local GAAP, and extension ledgers for management reporting. Each ledger record captures ledger type, accounting principle, currency type, fiscal year variant, and posting period variant. Supports multi-GAAP reporting requirements common in global CPG companies operating across multiple regulatory jurisdictions. | 36 |
| accounting_structure | profit_center | master_data | Master record for profit centers representing autonomous business segments within the consumer goods enterprise — product lines, brands, or geographic business units. Tracks revenue, cost, and profitability at a granular level below the legal entity. Integrates with SAP S/4HANA CO-PCA (Profit Center Accounting) and Oracle Cloud Financials for segment reporting and EBITDA decomposition. | 44 |
| ledger_transactions | cogs_allocation | transactional_data | Product costing and COGS allocation master for CPG manufacturing. Owns both standard cost estimates (planned) and actual cost allocations for finished goods, semi-finished goods, and raw materials. Captures cost component splits (raw material, packaging, direct labor, variable/fixed overhead, machine overhead, freight-in, depreciation), costing version, validity period, costing lot size, release status, plant, allocation date, fiscal period, standard vs actual cost, variance amount, variance category, and allocation method. The single source of truth for inventory valuation, SKU-level and brand-level gross margin analysis, manufacturing variance reporting, COGS decomposition, and make-vs-buy cost comparison. Sourced from SAP S/4HANA CO-PC (Product Costing). | 59 |
| ledger_transactions | journal_entry | transactional_data | Core general ledger journal entry header capturing every financial posting in the consumer goods enterprise. Records document type (vendor invoice, customer payment, goods issue, payroll posting, accrual, reversal), posting date, fiscal period, company code, ledger, currency, exchange rate, reference document, and SOX-compliant posting user and approval chain. The authoritative transactional record for all financial activity sourced from SAP S/4HANA FI and Oracle Cloud Financials. | 54 |
| ledger_transactions | journal_entry_line | transactional_data | Individual line items of a general ledger journal entry. Each line captures the GL account, cost center, profit center, WBS element, business area, debit/credit indicator, amount in transaction currency, amount in company code currency, amount in group currency, tax code, and assignment field. Enables granular cost allocation, COGS decomposition, and audit trail tracing at the line level as required by SOX compliance. | 62 |
| ledger_transactions | standard_cost | master_data | Standard cost master record for finished goods, semi-finished goods, and raw materials used in CPG manufacturing. Stores the cost estimate per SKU/material including cost component split (raw material, packaging, direct labor, machine overhead, fixed overhead, freight-in), costing version, validity period, plant, costing lot size, and release status. The authoritative source for inventory valuation, COGS calculation, and manufacturing variance analysis. Sourced from SAP S/4HANA CO-PC. | 62 |
| payable_receivable | ap_invoice | transactional_data | Accounts payable master record representing the full trade payable lifecycle for raw materials, packaging, contract manufacturing, and indirect goods/services. Owns invoice receipt, three-way match verification, payment scheduling, payment execution, early payment discount capture, and clearing. Captures vendor invoice number, invoice date, posting date, due date, gross amount, tax, net amount, payment terms, currency, match status, payment method, payment date, payment amount, payment run ID, bank account reference, early discount taken, clearing document, and payment block details. The single source of truth for all payable balances, payment execution, DIO tracking, working capital optimization, and supplier payment management. Integrates with SAP S/4HANA MM-IV, FI-AP, and Oracle Cloud Payables. | 53 |
| payable_receivable | ap_payment | transactional_data | Accounts payable payment record capturing outgoing payments to suppliers for raw materials, packaging, and services. Records payment date, payment method (ACH, wire, check, EDI 820), payment amount, currency, exchange rate, bank account, payment run ID, clearing document, early payment discount taken, and payment block release authorization. Supports cash flow management, supplier relationship management, and working capital optimization. Sourced from SAP S/4HANA FI-AP. | 49 |
| payable_receivable | ar_invoice | transactional_data | Accounts receivable master record representing the full trade receivable lifecycle for consumer goods sales to retailers, distributors, and wholesalers. Owns invoice creation, payment terms, cash receipt application, partial payments, deductions/short-payments, clearing, and write-offs. Captures invoice number, billing date, due date, payment terms, gross amount, trade discounts, net amount, tax, currency, payment method, payment date, amount received, clearing reference, DSO aging bucket, dunning level, and deduction reason codes. The single source of truth for all receivable balances, cash application, deduction management, DSO tracking, cash flow forecasting, and revenue recognition under ASC 606/IFRS 15. Integrates with SAP S/4HANA SD billing and FI-AR. | 60 |
| payable_receivable | ar_payment | transactional_data | Accounts receivable payment record capturing cash receipts from trade customers against outstanding AR invoices. Records payment date, payment method (ACH, wire, check, EDI 820), amount received, currency, exchange rate, bank account, clearing document reference, partial payment flag, and deduction/short-payment details. Supports cash application, deduction management, and DSO calculation. Sourced from SAP S/4HANA FI-AR and Oracle Cloud Receivables. | 57 |

## Metric Views

Total metric views generated: **74**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | distribution_facility | distribution | distribution_facility | Facility-level KPIs for distribution network capacity, certification coverage, and operational readiness. Used by supply chain leadership to evaluate network footprint and facility capability. |
| 2 | distribution_inbound_receipt | distribution | inbound_receipt | Inbound receiving performance KPIs covering receipt accuracy, quality compliance, OTIF adherence, and temperature integrity. Used by DC operations and procurement to manage supplier and inbound quality performance. |
| 3 | distribution_inbound_receipt_line | distribution | inbound_receipt_line | Line-level inbound receipt KPIs covering quantity accuracy, cost, and quality at the SKU/lot level. Used by procurement and quality teams to manage supplier fill rates and product condition at receipt. |
| 4 | distribution_inventory_position | distribution | inventory_position | Inventory health and availability KPIs at the facility-SKU-lot level. Used by supply chain planners and DC managers to manage stock levels, availability, and inventory quality across the distribution network. |
| 5 | distribution_outbound_order | distribution | outbound_order | Outbound order fulfillment KPIs covering order volume, value, fill rate, OTIF performance, and service level. Used by sales operations and supply chain leadership to manage customer service and order execution performance. |
| 6 | distribution_outbound_order_line | distribution | outbound_order_line | Line-level outbound fulfillment KPIs covering pick accuracy, shipment completeness, OTIF status, and short-ship rates at the SKU level. Used by DC operations and customer service to manage line-level fulfillment quality. |
| 7 | distribution_pick_task | distribution | pick_task | Warehouse picking productivity and accuracy KPIs at the task level. Used by DC operations managers to optimize labor efficiency, picking accuracy, and wave execution performance. |
| 8 | distribution_shipment | distribution | shipment | Outbound shipment performance KPIs covering OTIF compliance, freight cost, delivery reliability, and shipment volume. Used by logistics, supply chain, and finance leadership to manage carrier performance and customer delivery commitments. |
| 9 | distribution_storage_location | distribution | storage_location | Storage location capacity and utilization KPIs for warehouse slotting, compliance, and space management. Used by DC managers and supply chain engineers to optimize warehouse layout and storage strategy. |
| 10 | manufacturing_batch_record | manufacturing | batch_record | Batch-level manufacturing performance metrics covering yield, scrap, cost variance, OEE, and quality compliance. Used by manufacturing VPs and quality directors to steer production efficiency and GMP adherence. |
| 11 | manufacturing_equipment | manufacturing | equipment | Equipment asset performance and maintenance metrics covering OEE, reliability (MTBF/MTTR), maintenance cost, energy consumption, and calibration compliance. Used by asset management, maintenance, and operations leadership to optimize equipment lifecycle and minimize unplanned downtime. |
| 12 | manufacturing_facility | manufacturing | manufacturing_facility | Manufacturing facility capacity, compliance, and sustainability metrics. Used by network strategy, regulatory affairs, and sustainability leadership to evaluate facility performance, compliance posture, and environmental footprint. |
| 13 | manufacturing_planned_order | manufacturing | planned_order | Planned order metrics covering demand fulfillment planning, order conversion rates, safety stock adequacy, and schedule adherence. Used by supply chain planners and S&OP leadership to manage production planning effectiveness and demand responsiveness. |
| 14 | manufacturing_production_confirmation | manufacturing | production_confirmation | Real-time production confirmation metrics capturing actual vs. scheduled execution, OEE components, labor and machine time efficiency, and quality compliance at the operation level. Used by plant managers and operations analysts for shift-level and daily performance management. |
| 15 | manufacturing_production_line | manufacturing | production_line | Production line capacity, efficiency, and compliance metrics. Used by manufacturing engineering and operations leadership to benchmark line performance, plan capacity investments, and manage GMP and environmental compliance. |
| 16 | manufacturing_production_order | manufacturing | production_order | Production order execution metrics covering schedule adherence, cost performance, yield, scrap, and OEE. Used by supply chain, manufacturing operations, and finance leadership to manage production efficiency and cost. |
| 17 | manufacturing_work_center | manufacturing | work_center | Work center capacity, efficiency, and compliance metrics. Used by manufacturing engineering and operations management to optimize work center utilization, manage GMP qualification status, and plan maintenance. |
| 18 | procurement_approved_supplier_list | procurement | approved_supplier_list | Approved Supplier List (ASL) KPIs for sourcing governance and compliance. Enables procurement and quality teams to monitor supplier approval coverage, preferred supplier utilisation, and ASL expiry risk. |
| 19 | procurement_contract_line | procurement | contract_line | Contract line KPIs for spend coverage and pricing governance. Enables category managers to analyse contracted unit prices, quantities, and line values to assess contract utilisation and pricing competitiveness. |
| 20 | procurement_goods_receipt | procurement | goods_receipt | Inbound goods receipt KPIs tracking volume, quality inspection requirements, and receipt status. Enables supply chain and quality teams to monitor inbound fulfilment performance. |

*... and 54 more metric views. See the `metrics/` folder for full details.*