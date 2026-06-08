-- Schema for Domain: freight | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`freight` COMMENT 'Manages freight forwarding operations and order lifecycle across air, ocean, road, and rail modes including FTL, LTL, FCL, LCL, and TEU-based container movements. Owns freight bookings, consolidations, load plans, carrier assignments, NVOCC arrangements, intermodal transfers, CFS and ICD operations, and mode-specific charge components such as BAF, GRI, and THC. Integrates with SAP TM and Oracle TMS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`freight_order` (
    `freight_order_id` BIGINT COMMENT 'Unique surrogate identifier for the freight forwarding order record in the lakehouse silver layer. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'FK to network.carrier',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: Freight orders link to certificates (origin, phytosanitary, fumigation, halal) required for specific commodities. Regulatory compliance requirement for controlled goods - customs clearance depends on ',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Every freight order must be assigned to a legal entity (company code) for revenue recognition, financial statement consolidation, and regulatory reporting. Core requirement for multi-entity logistics ',
    `consignee_profile_id` BIGINT COMMENT 'Reference to the consignee party profile designated to receive the freight at destination. Used for delivery instructions, customs clearance, and proof of delivery.',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: Ocean and intermodal freight orders are fulfilled using specific containers. Critical for container tracking, utilization reporting, repositioning decisions, and demurrage management. Core container s',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight orders are often assigned to cost centers for internal cost allocation, profitability analysis by business unit/service line, and operational cost management. Essential for management accounti',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit trail for freight order creation accountability. Essential for operational tracking, dispute resolution, and performance management. Standard business practice in logistics operations to track w',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that placed this freight order. Links to the customer domain for billing, SLA entitlement, and account management.',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Every freight order requires emissions calculation using standardized factors (GLEC/CORSIA methodology) based on transport mode, vehicle type, and fuel type for customer carbon reporting and regulator',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Freight orders must identify the importer of record for customs purposes. Critical for duty payment, compliance verification, AEO/C-TPAT status checks, and denied party screening at booking stage.',
    `lane_id` BIGINT COMMENT 'Reference to the origin-destination trade lane associated with this freight order. Used for rate lookup, carrier selection, and network planning.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Freight orders originating from warehouse facilities (e.g., export consolidation, cross-dock) need origin_facility_id for cargo readiness verification, facility performance metrics, and origin-to-carr',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Freight orders must be assigned to profit centers for segment P&L reporting, EBITDA analysis by service line/geography, and business unit performance measurement. Critical for financial reporting and ',
    `shipper_profile_id` BIGINT COMMENT 'Reference to the shipper party profile responsible for tendering the freight. Identifies the origin party for customs, documentation, and liability purposes.',
    `sla_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_entitlement. Business justification: Freight orders must validate against customer SLA entitlements to enforce transit time guarantees, OTD/OTIF targets, and penalty/incentive clauses. Operations teams need this link for real-time SLA co',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Freight orders are executed using specific transport assets (trucks, aircraft, vessels). Essential for asset utilization analysis, maintenance correlation with freight activity, and operational perfor',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time the freight was delivered to the consignee. Used for POD (Proof of Delivery) confirmation, OTD and OTIF KPI measurement, and SLA compliance reporting.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time the freight departed from the origin port or facility. Used for transit time calculation, carrier performance measurement, and OTD reporting.',
    `awb_number` STRING COMMENT 'Air Waybill (AWB) number assigned for air freight shipments. Serves as the primary transport document and contract of carriage for air mode. Null for non-air shipments. Follows IATA AWB numbering format.',
    `bol_number` STRING COMMENT 'Bill of Lading (BOL) number for ocean or road freight shipments. Serves as the contract of carriage, receipt of goods, and document of title. Null for air shipments. Includes both MBL (Master Bill of Lading) and HBL (House Bill of Lading) scenarios.',
    `booking_date` DATE COMMENT 'The business date on which the freight order was accepted and confirmed by the carrier or freight forwarder. Represents the principal real-world event time for this transaction and is used for revenue recognition and SLA measurement start.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The weight basis used for freight charge calculation — the higher of gross weight and dimensional weight. Stored explicitly to support freight audit, carrier invoice reconciliation, and revenue recognition.',
    `co2e_emissions_kg` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas (GHG) emissions in kilograms of CO2 equivalent (CO2e) for this freight order. Calculated based on transport mode, distance, and cargo weight. Required for EU ETS reporting, CORSIA compliance (air), and customer sustainability reporting.',
    `commodity_description` STRING COMMENT 'Plain-language description of the goods being shipped as declared by the shipper. Used for customs declarations, dangerous goods screening, and insurance underwriting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight order record was first created in the source system (SAP TM). Used for audit trail, data lineage, and SLA measurement.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this freight order (e.g., USD, EUR, GBP). Required for multi-currency operations and financial consolidation under IFRS.. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the freight destination. Used for customs import declarations, trade compliance, duty calculation, and lane-based rating.. Valid values are `^[A-Z]{3}$`',
    `destination_port_or_facility` STRING COMMENT 'UN/LOCODE or internal facility code identifying the specific port, airport, CFS, ICD, or delivery facility at the destination. Used for last-mile planning, customs clearance, and THC calculation.',
    `dim_weight_kg` DECIMAL(18,2) COMMENT 'Calculated dimensional weight in kilograms derived from shipment volume using the applicable DIM factor (e.g., 1:6000 for air). The chargeable weight is the higher of gross weight and DIM weight. Stored as a business field to support charge audit and dispute resolution.',
    `eta` TIMESTAMP COMMENT 'Estimated Time of Arrival (ETA) at the destination port or facility. Used for delivery scheduling, customs pre-clearance, and OTD (On-Time Delivery) KPI measurement. Updated dynamically by FourKites predictive ETA engine.',
    `etd` TIMESTAMP COMMENT 'Estimated Time of Departure (ETD) from the origin port or facility. Used for vessel/flight scheduling, carrier coordination, and customer notification. Sourced from SAP TM and updated via FourKites real-time visibility.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Base freight charge amount for this order before surcharges and adjustments, in the billing currency. Represents the core revenue line for freight forwarding. Used for revenue recognition, P&L reporting, and freight audit.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms as declared by the shipper. Used for freight charge calculation, carrier capacity planning, and customs declarations. Mandatory field per IATA and IMO regulations.',
    `hs_code` STRING COMMENT 'WCO Harmonized System commodity classification code (6–10 digits) for the primary commodity in this freight order. Drives tariff determination, duty calculation, import/export licensing, and trade statistics reporting.. Valid values are `^[0-9]{6,10}$`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms code defining the division of costs, risks, and responsibilities between shipper and consignee. Governs customs clearance obligations, insurance liability, and freight charge allocation. Aligned with ICC Incoterms 2020. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_dangerous_goods` BOOLEAN COMMENT 'Indicates whether the shipment contains dangerous goods (hazardous materials) requiring special handling, documentation, and regulatory compliance under IMDG Code (ocean), ICAO Technical Instructions (air), or ADR (road).',
    `is_nvocc` BOOLEAN COMMENT 'Indicates whether this freight order is executed under an NVOCC (Non-Vessel Operating Common Carrier) arrangement, where the company acts as a carrier to the shipper but uses another vessel operator. Affects BOL issuance, liability, and FMC filing requirements.',
    `order_number` STRING COMMENT 'Externally visible, human-readable business identifier for the freight order as assigned by SAP TM freight order management. Used in customer communications, EDI messages, and operational tracking.. Valid values are `^FO-[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle state of the freight order from booking acceptance through final delivery. Drives operational workflows, exception management, and SLA monitoring. [ENUM-REF-CANDIDATE: draft|booked|confirmed|in_transit|customs_hold|at_destination|delivered|cancelled|on_hold — promote to reference product]. Valid values are `draft|booked|in_transit|customs_hold|delivered|cancelled`',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the freight origin location. Used for customs export declarations, trade compliance screening, and lane-based rating.. Valid values are `^[A-Z]{3}$`',
    `origin_port_or_facility` STRING COMMENT 'UN/LOCODE or internal facility code identifying the specific port, airport, CFS (Container Freight Station), ICD (Inland Container Depot), or warehouse from which the freight departs. Used for scheduling, carrier assignment, and THC calculation.',
    `package_count` STRING COMMENT 'Total number of individual packages, cartons, pallets, or handling units in this freight order. Used for loading plans, warehouse receiving, and proof of delivery reconciliation.',
    `packaging_type` STRING COMMENT 'Type of outer packaging used for the freight. Influences stacking rules, handling instructions, and container loading plans. [ENUM-REF-CANDIDATE: pallet|carton|crate|drum|bag|loose|roll|bundle|cylinder — promote to reference product]. Valid values are `pallet|carton|crate|drum|bag|loose`',
    `payment_terms` STRING COMMENT 'Freight charge payment arrangement indicating whether charges are prepaid by the shipper, collected from the consignee, or billed to a third party. Drives invoicing workflow and accounts receivable allocation.. Valid values are `prepaid|collect|third_party`',
    `pod_received` BOOLEAN COMMENT 'Indicates whether a Proof of Delivery (POD) or ePOD (Electronic Proof of Delivery) has been received and confirmed for this freight order. Required for invoice release, claims prevention, and OTIF measurement.',
    `service_level` STRING COMMENT 'Contracted service level commitment for this freight order defining the speed and priority of delivery. Drives SLA measurement, carrier selection, and premium charge application. [ENUM-REF-CANDIDATE: same_day|next_day|two_day|standard|deferred|economy|priority — promote to reference product]. Valid values are `same_day|next_day|two_day|standard|deferred|economy`',
    `service_type` STRING COMMENT 'Classification of the freight service arrangement. FTL (Full Truckload) and LTL (Less Than Truckload) apply to road; FCL (Full Container Load) and LCL (Less Than Container Load) apply to ocean. Drives pricing, consolidation logic, and carrier assignment. [ENUM-REF-CANDIDATE: FTL|LTL|FCL|LCL|express|standard|economy|charter — promote to reference product]',
    `source_system_code` STRING COMMENT 'Identifier of the operational system of record from which this freight order was sourced. SAP_TM for orders originating from SAP Transportation Management; ORACLE_TMS for Oracle TMS-sourced orders. Used for data lineage and reconciliation.. Valid values are `SAP_TM|ORACLE_TMS`',
    `special_handling_code` STRING COMMENT 'Industry-standard special handling code indicating specific requirements such as temperature control, fragile, live animals, or oversized cargo. Uses IATA Special Handling Codes (e.g., PER for perishables, AVI for live animals, HEA for heavy cargo). Multiple codes may be concatenated.',
    `temperature_requirement` STRING COMMENT 'Temperature control requirement for the shipment. Applicable for pharmaceutical, perishable, and cold-chain freight. Drives equipment selection, carrier qualification, and GDP (Good Distribution Practice) compliance.. Valid values are `ambient|chilled|frozen|controlled`',
    `teu_count` DECIMAL(18,2) COMMENT 'Number of TEUs (Twenty-foot Equivalent Units) allocated to this freight order for ocean container movements. Applicable for FCL and LCL ocean shipments. Used for vessel capacity planning, GRI application, and port statistics reporting.',
    `total_order_amount` DECIMAL(18,2) COMMENT 'Total billable amount for this freight order including base freight charges, all surcharges, and applicable taxes. Represents the net total for invoicing and revenue recognition. Equals freight_charge_amount plus total_surcharge_amount plus applicable taxes.',
    `total_surcharge_amount` DECIMAL(18,2) COMMENT 'Aggregate of all applicable surcharges for this freight order including BAF (Bunker Adjustment Factor), GRI (General Rate Increase), THC (Terminal Handling Charge), fuel surcharge, and security surcharge. Stored as a total to support charge breakdown analysis.',
    `transport_mode` STRING COMMENT 'Primary mode of transport for this freight order. Determines applicable regulatory frameworks (IATA for air, IMO for ocean), charge components (BAF, GRI, THC for ocean; fuel surcharge for air), and documentation requirements (AWB for air, BOL for ocean).. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the freight order record in the source system. Used for change detection, incremental loads, and audit compliance.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters (CBM). Used alongside gross weight for dimensional weight (DIM weight) calculation, LCL rating, and container utilization planning.',
    CONSTRAINT pk_freight_order PRIMARY KEY(`freight_order_id`)
) COMMENT 'Core master entity representing a freight forwarding order across all transport modes (air, ocean, road, rail). Captures the full order lifecycle from booking acceptance through final delivery, including mode type (FTL, LTL, FCL, LCL), service level, origin/destination locations, commodity details, weight, volume (CBM), dimensional weight, incoterms reference, special handling requirements, and current order status. Acts as the primary anchor entity linking transport documents, charges, milestones, and exceptions. Sourced from SAP TM freight order management module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`booking` (
    `booking_id` BIGINT COMMENT 'Unique surrogate identifier for the freight booking record in the lakehouse silver layer. Primary key for the booking data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Bookings reference customer agreements for rate validation and capacity allocation. Business process: contract rate lookup at booking time, volume commitment tracking, service level verification again',
    `ams_filing_id` BIGINT COMMENT 'Foreign key linking to customs.ams_filing. Business justification: Air/ocean bookings require AMS (Automated Manifest System) filing for CBP advance screening. Links booking to manifest filing for hold resolution and cargo release coordination.',
    `network_node_id` BIGINT COMMENT 'Reference to the network node entity representing the pickup or origin point for this booking (e.g., shipper warehouse, Container Freight Station (CFS), Inland Container Depot (ICD), or airport/seaport terminal).',
    `carrier_id` BIGINT COMMENT 'Reference to the nominated carrier (airline, ocean carrier, trucking company, or rail operator) assigned to execute this booking. Populated upon carrier nomination or space reservation confirmation.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Bookings reference specific carrier service offerings (e.g., Maersk AE7 weekly string, Lufthansa express flight service) with defined schedules and transit times. Sales and operations teams book capac',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Bookings represent revenue commitments and must be assigned to legal entity for accrual accounting, revenue forecasting, and financial planning. Essential when bookings are made across multiple legal ',
    `consignee_profile_id` BIGINT COMMENT 'Reference to the consignee profile entity representing the party designated to receive the cargo at the destination.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Identifies employee who created booking. Essential for sales commission tracking, customer service accountability, and booking quality metrics. Standard practice in logistics to track booking originat',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account (shipper or freight forwarder) that submitted this booking request. Supports PARTY_REFERENCE requirement for TRANSACTION_HEADER role.',
    `customer_carbon_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.customer_carbon_report. Business justification: Booking-level carbon estimates feed into customer carbon reports for forward-looking emissions forecasting and proactive carbon management in customer sustainability planning.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Bookings for international shipments require pre-clearance customs declarations in many jurisdictions. Links booking to advance filing requirements and enables customs status visibility during space c',
    `destination_node_network_node_id` BIGINT COMMENT 'Reference to the network node entity representing the delivery or destination point for this booking (e.g., consignee warehouse, CFS, ICD, or airport/seaport terminal).',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Bookings accumulate document packages during pre-shipment phase. Operational workflow to track customer document submission status before cargo acceptance - prevents shipment delays due to missing doc',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: A booking is a freight forwarding request that, when confirmed, generates a freight_order. This FK tracks the quote-to-order conversion lifecycle. Nullable until booking is confirmed and order is crea',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.order. Business justification: Pre-booking freight capacity for known e-commerce order volumes in integrated supply chains. Real business process: merchants book freight space in advance for anticipated fulfillment orders, enabling',
    `isf_filing_id` BIGINT COMMENT 'Foreign key linking to customs.isf_filing. Business justification: Ocean bookings to USA require ISF (Importer Security Filing) 24 hours before vessel loading. Direct link enables compliance verification, penalty avoidance, and automated filing status tracking.',
    `lane_id` BIGINT COMMENT 'Reference to the route lane entity defining the origin-destination corridor for this booking. Used for rate lookup, capacity planning, and SLA determination.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Bookings for LCL/air cargo often originate from warehouse consolidation facilities (CFS). Tracking origin_facility_id enables facility-level capacity planning, dwell time analysis, and cargo handoff r',
    `quote_id` BIGINT COMMENT 'Foreign key linking to freight.freight_quote. Business justification: A booking may be created based on a freight quote. This FK tracks the quote-to-booking lineage. Nullable for direct bookings not based on a quote. No reverse FK exists, no bidirectional violation.',
    `request_id` BIGINT COMMENT 'Foreign key linking to document.document_request. Business justification: Bookings generate document requests to customers for required shipping documents (commercial invoice, packing list, certificates). Pre-shipment operational workflow to ensure document completeness bef',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: Bookings generate estimated carbon footprint at quote/booking stage for customer decision-making on green service tiers and carbon-neutral shipping product selection before order execution.',
    `shipper_profile_id` BIGINT COMMENT 'Reference to the shipper profile entity capturing the party responsible for tendering the cargo for transport. Distinct from the billing customer account.',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Bookings reserve capacity on specific transport assets (aircraft, vessels). Required for asset capacity planning, schedule optimization, and booking-to-execution reconciliation. Standard capacity mana',
    `booking_date` TIMESTAMP COMMENT 'The principal real-world event timestamp recording when the booking request was formally submitted by the shipper or freight forwarder. Distinct from system audit timestamps. Used for SLA measurement and capacity allocation.',
    `booking_status` STRING COMMENT 'Current lifecycle state of the freight booking. Tracks progression from initial submission through carrier confirmation or rejection to execution. executed indicates a freight order has been raised against this booking.. Valid values are `draft|pending|confirmed|rejected|cancelled|executed`',
    `cancellation_date` TIMESTAMP COMMENT 'Timestamp when this booking was cancelled by the shipper or operations team. Null if the booking has not been cancelled. Used for cancellation fee assessment, capacity release, and booking lifecycle analytics.',
    `cancellation_reason` STRING COMMENT 'Reason code or description provided when a booking is cancelled. Used for root cause analysis, carrier penalty assessment, and demand forecasting model calibration in Blue Yonder.',
    `cargo_description` STRING COMMENT 'General description of the goods to be transported as declared by the shipper. Used for customs pre-screening, dangerous goods assessment, and carrier acceptance checks. Aligns with commodity description fields in AWB and BOL documents.',
    `carrier_booking_ref` STRING COMMENT 'The booking confirmation reference number issued by the carrier upon space reservation acceptance. For ocean shipments this is the carriers booking number; for air it may be the airlines booking code. Used for cross-referencing with carrier systems.',
    `channel` STRING COMMENT 'Channel through which the booking request was submitted. Electronic Data Interchange (EDI) and Application Programming Interface (API) indicate automated integrations; web_portal and manual indicate human-initiated entries. Used for channel analytics and SLA differentiation.. Valid values are `EDI|API|web_portal|manual|email|phone`',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The weight basis used for freight charge calculation, being the higher of actual gross weight and Dimensional Weight (DIM weight). Calculated per IATA volumetric conversion factor for air freight or carrier-specific rules for other modes.',
    `container_type` STRING COMMENT 'ISO container type code for ocean freight bookings (e.g., 20GP = 20-foot General Purpose, 40HC = 40-foot High Cube, 20RF = 20-foot Refrigerated). Null for non-ocean or non-containerized shipments. Drives Twenty-foot Equivalent Unit (TEU) calculation and Terminal Handling Charge (THC) assessment. [ENUM-REF-CANDIDATE: 20GP|40GP|40HC|45HC|20RF|40RF|20OT|40OT — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this booking record was first persisted in the system of record. Supports data lineage, audit trail, and SOX compliance reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated freight charge and surcharge amounts on this booking (e.g., USD, EUR, SGD). Required for multi-currency financial reporting under IFRS.. Valid values are `^[A-Z]{3}$`',
    `dangerous_goods` BOOLEAN COMMENT 'Indicates whether the cargo contains dangerous goods or hazardous materials requiring special handling, documentation, and regulatory compliance. True triggers IMDG Code compliance checks for ocean, ICAO Technical Instructions for air, and ADR for road transport.',
    `estimated_freight_charge` DECIMAL(18,2) COMMENT 'Estimated base freight charge for this booking in the billing currency, calculated at time of booking based on applicable rate tariff, chargeable weight, and lane. Excludes surcharges (BAF, GRI, THC). Used for shipper quotation and revenue forecasting.',
    `eta` TIMESTAMP COMMENT 'Estimated Time of Arrival (ETA) — the planned arrival timestamp of the vessel, aircraft, truck, or train at the destination port or terminal. Used for consignee notification, customs pre-arrival filing, and delivery scheduling.',
    `etd` TIMESTAMP COMMENT 'Estimated Time of Departure (ETD) — the planned departure timestamp of the vessel, aircraft, truck, or train carrying this bookings cargo from the origin port or terminal. Used for schedule coordination, documentation cutoff management, and carrier slot reservation.',
    `freight_terms` STRING COMMENT 'Indicates who is responsible for paying the freight charges: prepaid (shipper pays), collect (consignee pays), or third_party (a nominated third party pays). Drives accounts receivable routing and invoice generation in SAP S/4HANA Finance.. Valid values are `prepaid|collect|third_party`',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the cargo in kilograms as declared by the shipper at time of booking. Used for freight charge calculation, carrier capacity planning, and dangerous goods compliance. Basis for chargeable weight comparison against DIM weight.',
    `hawb_number` STRING COMMENT 'House Air Waybill (HAWB) number issued by the freight forwarder or NVOCC for air freight consolidations. Issued under the MAWB when Transport Shipping acts as consolidator. Null for direct carrier bookings or non-air modes.',
    `hbl_number` STRING COMMENT 'House Bill of Lading (HBL) number issued by the freight forwarder or NVOCC for ocean LCL consolidations or NVOCC arrangements. Issued under the MBL. Null for FCL direct carrier bookings or non-ocean modes.',
    `hs_code` STRING COMMENT 'Harmonized System (HS) Code assigned to the primary commodity in this booking per the World Customs Organization (WCO) classification. Used for customs duty calculation, trade compliance screening, and export/import licensing checks via Descartes Customs.. Valid values are `^[0-9]{6,10}$`',
    `incoterms` STRING COMMENT 'International Commercial Terms (Incoterms) agreed between buyer and seller governing the transfer of risk, cost responsibility, and delivery obligations. Determines freight charge allocation (prepaid vs collect), insurance responsibility, and customs clearance party. Published by the International Chamber of Commerce (ICC). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `mawb_number` STRING COMMENT 'Master Air Waybill (MAWB) number issued by the airline or ground handling agent for air freight bookings. Follows IATA 3-digit airline prefix plus 8-digit serial number format. Null for non-air transport modes. Used for cargo tracking and customs filing.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `mbl_number` STRING COMMENT 'Master Bill of Lading (MBL) number issued by the ocean carrier for ocean freight bookings. Serves as the primary transport document and title of goods for ocean shipments. Null for non-ocean transport modes.',
    `nvocc_arrangement` BOOLEAN COMMENT 'Indicates whether this booking is executed under a Non-Vessel Operating Common Carrier (NVOCC) arrangement, where Transport Shipping acts as a carrier to the shipper but contracts with an actual vessel operator. Relevant for FMC tariff filing and House Bill of Lading (HBL) issuance.',
    `piece_count` STRING COMMENT 'Total number of individual pieces, packages, or handling units included in this booking. Used for cargo receipt verification, load planning, and Proof of Delivery (POD) reconciliation.',
    `reference` STRING COMMENT 'Externally-known alphanumeric booking reference number assigned at the time of booking submission. Communicated to the shipper and used across EDI, API, and manual channels for tracking and correspondence. Maps to Oracle TMS booking reference field.. Valid values are `^[A-Z0-9]{6,20}$`',
    `rejection_reason` STRING COMMENT 'Free-text or coded reason provided when a booking is rejected by the carrier or internal operations team. Populated only when booking_status is rejected. Used for exception management and carrier performance analysis.',
    `requested_delivery_date` DATE COMMENT 'The date on which the shipper requests cargo to be delivered to the consignee at the destination. Basis for SLA commitment and On-Time Delivery (OTD) performance measurement.',
    `requested_pickup_date` DATE COMMENT 'The date on which the shipper requests cargo to be collected from the origin location. Used for capacity planning, driver/vehicle scheduling, and SLA commitment calculation.',
    `service_type` STRING COMMENT 'Classification of the freight service requested. For road: Full Truckload (FTL) or Less Than Truckload (LTL). For ocean: Full Container Load (FCL) or Less Than Container Load (LCL). For air: express, standard, or economy. Drives pricing, capacity allocation, and consolidation logic. [ENUM-REF-CANDIDATE: FTL|LTL|FCL|LCL|express|standard|economy|charter|bulk|breakbulk — promote to reference product]',
    `space_confirmation_date` TIMESTAMP COMMENT 'Timestamp when the carrier confirmed space reservation for this booking. Null if space has not yet been confirmed. Used for SLA tracking and booking lead-time analytics.',
    `space_confirmed` BOOLEAN COMMENT 'Indicates whether the carrier has confirmed space reservation for this booking. True when the carrier has issued a booking confirmation; False when the booking is pending carrier acceptance or has been rejected.',
    `special_instructions` STRING COMMENT 'Free-text field capturing any special handling, stowage, or operational instructions provided by the shipper at time of booking (e.g., fragile, keep upright, top-load only, no stacking). Communicated to warehouse and carrier operations teams.',
    `temp_max_celsius` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in degrees Celsius for temperature-controlled cargo. Null when temperature_controlled is False. Used for reefer container set-point configuration and cold chain compliance monitoring.',
    `temp_min_celsius` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in degrees Celsius for temperature-controlled cargo. Null when temperature_controlled is False. Used for reefer container set-point configuration and cold chain compliance monitoring.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether this booking requires temperature-controlled (reefer/cold chain) transport and storage. True triggers assignment of refrigerated containers (RF) or temperature-controlled vehicles and monitoring requirements.',
    `teu_count` DECIMAL(18,2) COMMENT 'Number of Twenty-foot Equivalent Units (TEUs) represented by this booking. A 20-foot container = 1 TEU; a 40-foot container = 2 TEUs. Used for ocean capacity planning, vessel utilization reporting, and GRI/BAF charge calculation.',
    `transport_mode` STRING COMMENT 'Primary mode of transport for this freight booking. Determines applicable regulatory frameworks (IATA for air, IMO for ocean), charge components (BAF for ocean, fuel surcharge for air), and document requirements (AWB for air, BOL for ocean).. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this booking record was most recently modified in the system of record. Used for incremental data loading, change detection, and audit compliance.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the cargo in Cubic Meters (CBM) as declared by the shipper. Used for Dimensional Weight (DIM weight) calculation, container utilization planning, and LCL consolidation rating.',
    CONSTRAINT pk_booking PRIMARY KEY(`booking_id`)
) COMMENT 'Transactional record of a freight booking request submitted by a shipper or freight forwarder. Captures booking reference number, requested pickup and delivery dates, ETD, ETA, carrier nomination, space reservation confirmation, booking channel (EDI, API, manual), booking status, and acceptance/rejection details. Represents the commercial commitment to move cargo before a freight order is fully executed. Integrates with Oracle TMS shipment execution module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`air_waybill` (
    `air_waybill_id` BIGINT COMMENT 'Unique surrogate identifier for the air waybill record in the Transport Shipping data platform. Primary key for the air_waybill product in the freight domain.',
    `ams_filing_id` BIGINT COMMENT 'Foreign key linking to customs.ams_filing. Business justification: Air waybills drive AMS filing requirements for air cargo. Direct link enables manifest accuracy verification, CBP hold tracking, and automated filing reconciliation.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Air waybills execute under carrier agreements governing air freight rates and liability. Business process: carrier rate application, liability limit enforcement, operational SLA tracking for air trans',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Air waybills are the transport document for customs declarations in air freight. Links AWB to entry filing, duty assessment, and customs release for delivery authorization.',
    `freight_audit_id` BIGINT COMMENT 'Foreign key linking to billing.freight_audit. Business justification: Air waybills are audited against carrier invoices for AWB-specific charge validation. AWB-to-audit link enables air freight rate compliance verification and accessorial charge validation.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: An air waybill is the master transport document for air freight shipments, serving as the execution document for a freight order (air mode). One AWB documents one freight order. No reverse FK exists, ',
    `green_shipment_certificate_id` BIGINT COMMENT 'Foreign key linking to sustainability.green_shipment_certificate. Business justification: Air waybills commonly receive green certificates when SAF (Sustainable Aviation Fuel) or carbon offsets are applied, supporting CORSIA compliance and customer green logistics programs.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Air cargo AWBs often pass through warehouse facilities for break-bulk, customs clearance, and final-mile staging. Tracking handling_facility_id enables facility-level AWB volume reporting, dwell time ',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Air waybills represent completed air freight services requiring customer invoicing. AWB-to-invoice link enables service document reconciliation with billing, critical for freight audit and dispute res',
    `customer_account_id` BIGINT COMMENT 'Reference to the shipper (exporter/sender) party account responsible for tendering the cargo. Links to the shipper profile in the customer domain. Represents the PARTY_REFERENCE for this transaction.',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: Air shipments require specific carbon footprint calculations for CORSIA compliance reporting, customer carbon reports, and SAF (Sustainable Aviation Fuel) allocation tracking in aviation sustainabilit',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Air waybills document cargo transported on specific aircraft (modeled as transport_assets). Required for flight manifest reconciliation, aircraft utilization analysis, and cargo-to-flight traceability',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time the cargo arrived at the destination airport. Used for OTD (On-Time Delivery) KPI calculation, SLA compliance reporting, and claims assessment.',
    `awb_status` STRING COMMENT 'Current lifecycle status of the air waybill. DRAFT: document being prepared; ISSUED: AWB formally issued and accepted by carrier; ACCEPTED: cargo accepted at origin; IN_TRANSIT: cargo in movement; ARRIVED: cargo arrived at destination airport; DELIVERED: cargo delivered to consignee; CANCELLED: AWB voided. [ENUM-REF-CANDIDATE: DRAFT|ISSUED|ACCEPTED|IN_TRANSIT|ARRIVED|DELIVERED|CANCELLED — promote to reference product]',
    `awb_type` STRING COMMENT 'Indicates whether this record represents a Master Air Waybill (MAWB) issued by the airline, a House Air Waybill (HAWB) issued by the freight forwarder, or a DIRECT AWB for a single-shipper direct airline shipment.. Valid values are `MAWB|HAWB|DIRECT`',
    `carrier_name` STRING COMMENT 'Full legal or trade name of the airline carrier responsible for transporting the cargo (e.g., Emirates SkyCargo, Lufthansa Cargo AG). Denormalized from the carrier master for operational reporting and document generation.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The weight used for freight charge calculation, being the higher of the actual gross weight and the dimensional (DIM) weight. Calculated per IATA volumetric factor (typically 1:6000 cm³/kg for air freight). Core field for revenue calculation.',
    `charges_collect_or_prepaid` STRING COMMENT 'Indicates whether freight charges are to be paid by the shipper at origin (PREPAID) or by the consignee at destination (COLLECT). Determines billing party and accounts receivable assignment.. Valid values are `PREPAID|COLLECT`',
    `commodity_description` STRING COMMENT 'Plain-language description of the goods being shipped as declared by the shipper on the AWB (e.g., Electronic Components, Pharmaceutical Products). Required for customs clearance, dangerous goods assessment, and cargo acceptance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the air waybill record was first created in the source system (SAP TM). Used for audit trail, data lineage, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 3-letter currency code in which all monetary amounts on this AWB are denominated (e.g., USD, EUR, AED). Required for multi-currency financial reporting and CASS settlement.. Valid values are `^[A-Z]{3}$`',
    `declared_value_for_carriage` DECIMAL(18,2) COMMENT 'The value of the shipment declared by the shipper for the purpose of determining the carriers liability in case of loss or damage. May be NVD (No Value Declared) in which case this field is null. Governs maximum liability per IATA conditions of contract.',
    `declared_value_for_customs` DECIMAL(18,2) COMMENT 'The customs value of the shipment declared by the shipper for import duty and tax assessment at the destination country. Used by Descartes Customs for duty calculation and customs entry filing.',
    `destination_airport_code` STRING COMMENT '3-letter IATA airport code for the final destination airport where the cargo is to be delivered to the consignee (e.g., LAX, SIN, LHR). Used for routing, customs filing, and rate determination.. Valid values are `^[A-Z]{3}$`',
    `eta` TIMESTAMP COMMENT 'Estimated date and time of arrival of the carrying aircraft at the destination airport. Used for consignee notification, customs pre-arrival filing, and OTD performance measurement. Updated dynamically from FourKites.',
    `etd` TIMESTAMP COMMENT 'Estimated date and time of departure of the carrying aircraft from the origin airport. Used for shipment tracking, customer notifications, and SLA monitoring via FourKites.',
    `first_transit_airport_code` STRING COMMENT '3-letter IATA airport code for the first intermediate transit/transfer point in the routing, if applicable. Null for direct flights. Used for multi-leg routing documentation on the AWB.. Valid values are `^[A-Z]{3}$`',
    `flight_date` DATE COMMENT 'Scheduled departure date of the primary carrying flight. Used for booking confirmation, capacity planning, and ETD/ETA calculations.',
    `flight_number` STRING COMMENT 'The IATA flight designator code for the primary carrying flight (e.g., EK9301, LH8400). Used for shipment tracking, flight manifest reconciliation, and on-time performance reporting.. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}$`',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total base freight charge for the shipment calculated as chargeable weight multiplied by the rate per kg, in the billing currency. Represents the primary revenue line for the air freight service. Used for revenue recognition per IFRS 15.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total actual gross weight of the shipment in kilograms as declared by the shipper, including packaging and pallets. Used for load planning, aircraft weight and balance, and freight charge calculation.',
    `hawb_number` STRING COMMENT 'The House Air Waybill number issued by the freight forwarder or NVOCC to the individual shipper when consolidating multiple shipments under a single MAWB. Null when the AWB is a direct shipment not consolidated under a master. Sourced from SAP TM air freight module.',
    `hs_code` STRING COMMENT 'The Harmonized System commodity classification code assigned to the cargo, used for customs tariff determination, trade statistics, and import/export compliance. Minimum 6 digits per WCO standard; may be extended to 8 or 10 digits for national tariff schedules.. Valid values are `^[0-9]{6,10}$`',
    `iata_airline_code` STRING COMMENT 'The 3-digit IATA numeric airline prefix code identifying the issuing carrier (e.g., 176 for Emirates, 057 for Lufthansa Cargo). Forms the first segment of the MAWB number and identifies the contracting airline.. Valid values are `^[0-9]{3}$`',
    `incoterms_code` STRING COMMENT 'The ICC Incoterms 2020 code defining the division of costs, risks, and responsibilities between shipper and consignee (e.g., EXW, FOB, CIF, DDP). Determines freight charge responsibility and customs clearance obligations. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_dangerous_goods` BOOLEAN COMMENT 'Flag indicating whether the shipment contains dangerous goods as classified under IATA Dangerous Goods Regulations (DGR) and ICAO Technical Instructions. When true, additional DGR documentation and handling procedures are mandatory.',
    `isf_filing_number` STRING COMMENT 'The US Customs and Border Protection Importer Security Filing (ISF, also known as 10+2) reference number. Required for ocean and air cargo imports into the United States for advance security screening.',
    `issue_date` DATE COMMENT 'The date on which the air waybill was formally issued and signed, representing the principal business event timestamp for this contract of carriage. Corresponds to the execution date of the freight contract between shipper and carrier.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) when the air waybill was issued in SAP TM. Provides sub-day precision for operational sequencing and SLA measurement.',
    `mawb_number` STRING COMMENT 'The Master Air Waybill number issued by the airline or ground handling agent, formatted as the 3-digit IATA airline prefix followed by an 8-digit serial number (e.g., 176-12345678). Serves as the primary contract of carriage between the shipper and the airline. Sourced from SAP TM air freight module.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `notify_party_name` STRING COMMENT 'Name of the party to be notified upon arrival of the cargo at the destination airport, typically the customs broker or local agent. May differ from the consignee. Required for customs and airline notification purposes.',
    `origin_airport_code` STRING COMMENT '3-letter IATA airport code for the airport of departure where the cargo is tendered to the airline (e.g., DXB, FRA, JFK). Used for routing, rate determination, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the goods were manufactured or produced. Required for customs declarations, preferential tariff determination, and trade compliance screening.. Valid values are `^[A-Z]{3}$`',
    `other_charges_amount` DECIMAL(18,2) COMMENT 'Total of all ancillary charges beyond the base freight charge, including fuel surcharges, security surcharges, terminal handling charges (THC), and special handling fees. Aggregated from the charges breakdown for billing purposes.',
    `pieces_count` STRING COMMENT 'Total number of individual pieces, packages, or handling units included in this shipment as declared on the AWB. Used for cargo acceptance, loading, and delivery verification.',
    `pod_signatory_name` STRING COMMENT 'Name of the individual who signed for receipt of the cargo at delivery, as captured on the electronic or paper proof of delivery (ePOD). Used for delivery confirmation and dispute resolution.',
    `pod_timestamp` TIMESTAMP COMMENT 'Date and time when the cargo was confirmed as delivered to the consignee and proof of delivery (POD) was captured. Used for OTD measurement, SLA compliance, and triggering final invoice settlement.',
    `rate_class` STRING COMMENT 'IATA rate class code indicating the type of rate applied to this shipment (e.g., N=Normal, Q=Quantity, M=Minimum, B=Basic, C=Specific Commodity, E=Express, R=Reduced, S=Surcharge, U=Unit Load Device, X=Express). Determines the applicable tariff structure. [ENUM-REF-CANDIDATE: N|Q|M|B|C|E|R|S|U|X — 10 candidates stripped; promote to reference product]',
    `rate_per_kg` DECIMAL(18,2) COMMENT 'The agreed freight rate applied per kilogram of chargeable weight for this shipment, in the billing currency. Commercially sensitive pricing data used for revenue recognition and freight audit.',
    `second_transit_airport_code` STRING COMMENT '3-letter IATA airport code for the second intermediate transit/transfer point in the routing, if applicable. Null for direct or single-transit flights. Supports complex multi-leg air freight routing.. Valid values are `^[A-Z]{3}$`',
    `service_type` STRING COMMENT 'The service level or product type for this air freight shipment (e.g., EXPRESS for next-flight-out priority, STANDARD for regular scheduled service, DEFERRED for economy/consolidation, CHARTER for full aircraft charter, COURIER for express parcel). Determines SLA commitments and pricing tier.. Valid values are `EXPRESS|STANDARD|DEFERRED|CHARTER|COURIER`',
    `special_handling_codes` STRING COMMENT 'Comma-separated list of IATA Special Handling Codes (SHC) applicable to this shipment (e.g., DGR=Dangerous Goods, PER=Perishables, VAL=Valuables, HUM=Human Remains, AVI=Live Animals, COL=Cold Chain). Drives handling instructions, storage requirements, and regulatory compliance checks.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Grand total of all charges on the AWB including base freight charge and all other charges (surcharges, fees, taxes). Represents the total amount due from the shipper or consignee. Used for invoice generation and accounts receivable.',
    `un_number` STRING COMMENT 'The 4-digit United Nations identification number for dangerous goods (e.g., UN1263 for paint, UN3480 for lithium ion batteries). Mandatory when is_dangerous_goods is true. Used for emergency response, handling, and regulatory compliance.. Valid values are `^UN[0-9]{4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the air waybill record in the source system. Used for change detection, incremental loads, and audit compliance.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volumetric measurement of the shipment in cubic meters (CBM). Used to calculate dimensional weight (DIM weight) and determine the chargeable weight when volume weight exceeds actual weight.',
    CONSTRAINT pk_air_waybill PRIMARY KEY(`air_waybill_id`)
) COMMENT 'Master document for air freight shipments serving as the contract of carriage between shipper and airline/freight forwarder. Stores MAWB and HAWB numbers, IATA airline codes, origin and destination airport codes, flight details, commodity description, HS codes, declared value, chargeable weight, freight charges, special handling codes (e.g., DGR, PER, VAL), and consignee/shipper details. Governed by IATA regulations. Sourced from SAP TM air freight module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` (
    `bill_of_lading_id` BIGINT COMMENT 'Unique surrogate identifier for the bill of lading record in the Transport Shipping lakehouse. Primary key for the bill_of_lading data product. TRANSACTION_HEADER role.',
    `carbon_offset_transaction_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_transaction. Business justification: Ocean freight carbon offset purchases are linked to specific BOLs for customer carbon-neutral shipping programs and voluntary emissions reduction initiatives in maritime logistics.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Bills of lading execute under ocean carrier master agreements. Business process: contracted ocean freight rate application, carrier liability terms enforcement, service commitment verification for oce',
    `carrier_id` BIGINT COMMENT 'Reference to the NVOCC or freight forwarder acting as the contractual carrier on the house bill of lading. The NVOCC issues the HBL to the shipper and holds the MBL from the ocean carrier. Relevant for FMC-regulated NVOCC arrangements.',
    `consignee_id` BIGINT COMMENT 'Reference to the consignee (importer/receiver) party to whom the cargo is consigned. Links to the consignee_profile in the customer domain.',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: Bills of lading document cargo in specific containers. Fundamental ocean freight relationship for container tracking, cargo accountability, and container utilization. Replaces denormalized container_n',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Bills of lading are the primary transport document referenced in ocean customs declarations. Links BOL to entry filing for duty calculation and cargo release.',
    `freight_audit_id` BIGINT COMMENT 'Foreign key linking to billing.freight_audit. Business justification: Ocean BOLs are audited for rate compliance and container/weight-based charge validation. BOL-to-audit link supports ocean freight audit process and THC/BAF/GRI verification.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: A bill of lading is the master transport document for ocean freight shipments, serving as the execution document for a freight order (ocean mode). One BOL documents one freight order. No reverse FK ex',
    `green_shipment_certificate_id` BIGINT COMMENT 'Foreign key linking to sustainability.green_shipment_certificate. Business justification: Ocean BOLs receive green certificates for carbon-neutral shipping programs, providing customers with verified proof of emissions offsetting for Scope 3 Category 4 reporting.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Ocean freight BOLs trigger customer invoicing upon service completion. BOL-to-invoice link is essential for ocean freight billing reconciliation and supports proof-of-service validation in billing dis',
    `isf_filing_id` BIGINT COMMENT 'Foreign key linking to customs.isf_filing. Business justification: BOL numbers are mandatory ISF filing data elements. Direct link enables ISF compliance verification, amendment tracking, and penalty risk management for ocean shipments.',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: Ocean freight carbon footprinting per BOL is required for customer ESG disclosure, Scope 3 Category 4 emissions tracking, and IMO/EU MRV regulatory compliance reporting.',
    `shipper_profile_id` BIGINT COMMENT 'Reference to the shipper (exporter/consignor) party responsible for tendering the cargo. Links to the shipper_profile in the customer domain. Satisfies TRANSACTION_HEADER PARTY_REFERENCE minimum category.',
    `trade_party_id` BIGINT COMMENT 'Reference to the party to be notified upon arrival of the vessel at the port of discharge. Typically the customs broker or freight forwarder. Links to the customer domain.',
    `actual_arrival_date` DATE COMMENT 'Actual date the vessel arrived at the port of discharge. Used for transit time calculation, demurrage and detention computation, customs import filing, and on-time delivery (OTD) KPI reporting.',
    `actual_departure_date` DATE COMMENT 'Actual date the vessel departed from the port of loading. Used for transit time calculation, carrier performance measurement, and customs export record finalization.',
    `ams_filing_number` STRING COMMENT 'US Customs and Border Protection (CBP) Automated Manifest System (AMS) filing reference number. Required for all ocean shipments destined for or transiting through US ports. Must be filed 24 hours prior to vessel loading under the 24-Hour Advance Manifest Rule.',
    `bol_status` STRING COMMENT 'Current lifecycle state of the bill of lading document. Draft indicates pre-issuance; issued means the original has been released to the shipper; released indicates cargo release authorized; surrendered means original returned to carrier; amended reflects post-issuance corrections; cancelled indicates the BOL is void. Satisfies TRANSACTION_HEADER LIFECYCLE_STATUS minimum category.. Valid values are `draft|issued|released|surrendered|amended|cancelled`',
    `bol_type` STRING COMMENT 'Classification of the bill of lading indicating whether it is a master (MBL), house (HBL), seaway, straight (non-negotiable), to-order (negotiable), or surrendered BOL. Determines negotiability and title transfer rules. [ENUM-REF-CANDIDATE: master|house|seaway|straight|order|surrender — promote to reference product if additional types emerge]. Valid values are `master|house|seaway|straight|order|surrender`',
    `carrier_scac` STRING COMMENT 'Four-letter Standard Carrier Alpha Code (SCAC) identifying the ocean carrier (vessel operating common carrier) that issued the master bill of lading. Used for AMS filing, EDI transactions, and carrier performance tracking.. Valid values are `^[A-Z]{4}$`',
    `commodity_description` STRING COMMENT 'Free-text description of the goods as declared by the shipper on the bill of lading. Must accurately describe the nature of the cargo for customs classification, dangerous goods identification, and cargo insurance purposes. Carrier may use Said to Contain (STC) qualifier.',
    `container_count` STRING COMMENT 'Total number of containers covered by this bill of lading. Used for capacity planning, terminal handling charge (THC) calculation, and TEU-based reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bill of lading record was first created in the SAP TM ocean freight module and ingested into the Transport Shipping lakehouse silver layer. Satisfies TRANSACTION_HEADER RECORD_AUDIT_CREATED minimum category.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the cargo is destined. Used for import customs declarations, denied party screening, and trade compliance checks via Descartes Customs.. Valid values are `^[A-Z]{3}$`',
    `eta` TIMESTAMP COMMENT 'Estimated date and time the vessel is scheduled to arrive at the port of discharge. Used for consignee notification, customs pre-arrival filing, port berth planning, and on-time delivery (OTD) performance measurement. Updated dynamically via FourKites predictive ETA.',
    `etd` TIMESTAMP COMMENT 'Estimated date and time the vessel is scheduled to depart from the port of loading. Used for cargo cut-off planning, shipper notification, and SLA monitoring. Sourced from SAP TM ocean freight module and updated via FourKites real-time visibility.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Base ocean freight charge amount as stated on the bill of lading, before surcharges. Expressed in the currency indicated by freight_currency_code. Used for freight invoice reconciliation, revenue recognition in SAP S/4HANA Finance, and freight audit in Oracle TMS. Satisfies TRANSACTION_HEADER MONETARY_TRIPLET minimum category (base amount component).',
    `freight_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the freight charges are denominated (e.g., USD, EUR, CNY). Required for multi-currency freight invoice processing and foreign exchange revaluation in SAP S/4HANA Finance. Satisfies TRANSACTION_HEADER MONETARY_TRIPLET minimum category (currency code component).. Valid values are `^[A-Z]{3}$`',
    `freight_surcharge_amount` DECIMAL(18,2) COMMENT 'Total surcharge amount applied to the base freight, including Bunker Adjustment Factor (BAF), General Rate Increase (GRI), Terminal Handling Charge (THC), and other accessorial charges. Satisfies TRANSACTION_HEADER MONETARY_TRIPLET minimum category (adjustment component).',
    `freight_terms` STRING COMMENT 'Indicates who is responsible for paying the ocean freight charges: prepaid (shipper pays), collect (consignee pays), or third party (a nominated third party pays). Drives accounts receivable and accounts payable processing in SAP S/4HANA Finance.. Valid values are `prepaid|collect|third_party`',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the cargo including packaging, as declared by the shipper, expressed in kilograms. Used for vessel stability calculations, freight charge computation, customs declarations, and dangerous goods compliance under IMDG Code.',
    `hbl_number` STRING COMMENT 'Unique identifier issued by the NVOCC or freight forwarder to the shipper for the house bill of lading. Represents the contract of carriage between the forwarder and the shipper. Distinct from the MBL number issued by the ocean carrier.',
    `hs_code` STRING COMMENT 'World Customs Organization (WCO) Harmonized System commodity classification code for the primary commodity on this bill of lading. Minimum 6 digits at international level; may be extended to 8 or 10 digits for national tariff schedules. Used for customs duty calculation, trade statistics, and export control screening.. Valid values are `^[0-9]{6,10}$`',
    `imdg_class` STRING COMMENT 'IMDG hazard class of the dangerous goods (e.g., Class 1 Explosives, Class 3 Flammable Liquids, Class 6.1 Toxic Substances). Populated only when is_hazardous is true. Drives stowage segregation, emergency procedures, and port authority notifications. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — promote to reference product]',
    `imo_number` STRING COMMENT 'Unique 7-digit IMO vessel identification number assigned by IHS Markit on behalf of IMO. Provides a permanent, globally unique identifier for the vessel independent of name changes or flag changes. Used for regulatory compliance and vessel tracking.. Valid values are `^IMO[0-9]{7}$`',
    `incoterms_code` STRING COMMENT 'ICC Incoterms 2020 code defining the division of costs, risks, and responsibilities between the shipper and consignee. Determines freight payment obligations, insurance responsibility, and customs clearance duties. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `is_hazardous` BOOLEAN COMMENT 'Flag indicating whether the cargo contains dangerous goods as classified under the IMDG Code. When true, additional IMDG declarations, special stowage requirements, and emergency response information are mandatory.',
    `is_negotiable` BOOLEAN COMMENT 'Flag indicating whether the bill of lading is negotiable (to-order) or non-negotiable (straight/waybill). A negotiable BOL serves as a document of title and can be transferred by endorsement; a non-negotiable BOL cannot be used to transfer title.',
    `issue_date` DATE COMMENT 'The date on which the bill of lading was officially issued by the carrier or NVOCC. This is the principal real-world business event date for the BOL document and is used for letter of credit compliance, customs filing deadlines, and freight payment terms. Satisfies TRANSACTION_HEADER BUSINESS_EVENT_TIMESTAMP minimum category.',
    `mbl_number` STRING COMMENT 'Externally-known unique identifier issued by the ocean carrier (vessel operating common carrier) for the master bill of lading. Serves as the primary contract of carriage reference between the carrier and the NVOCC or freight forwarder. Satisfies TRANSACTION_HEADER BUSINESS_IDENTIFIER minimum category.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the cargo originates. Used for customs declarations, trade compliance screening, rules of origin determination, and preferential tariff eligibility.. Valid values are `^[A-Z]{3}$`',
    `original_bol_count` STRING COMMENT 'Number of original signed copies of the bill of lading issued to the shipper (typically 3). All originals must be surrendered to the carrier for cargo release when the BOL is negotiable. Used for document control and letter of credit compliance.',
    `package_count` STRING COMMENT 'Total number of individual packages, pieces, or units of cargo covered by this bill of lading as declared by the shipper. Used for cargo receipt verification, customs declarations, and cargo claims assessment.',
    `package_type` STRING COMMENT 'Description of the type of packaging used for the cargo (e.g., cartons, pallets, drums, crates, bags). Used for cargo handling instructions, stowage planning, and customs declarations. [ENUM-REF-CANDIDATE: carton|pallet|drum|crate|bag|bundle|roll|cylinder — promote to reference product]',
    `place_of_delivery` STRING COMMENT 'Final destination where the carrier delivers the cargo to the consignee, which may differ from the port of discharge (e.g., an inland CFS, ICD, or door delivery address). Defines the end of the carriers responsibility under the contract of carriage.',
    `place_of_issue` STRING COMMENT 'City and country where the bill of lading was issued by the carrier or NVOCC. Required for letter of credit compliance and legal jurisdiction determination in case of disputes.',
    `place_of_receipt` STRING COMMENT 'Location where the carrier takes custody of the cargo, which may differ from the port of loading (e.g., an inland container depot (ICD) or container freight station (CFS)). Defines the start of the carriers responsibility under the contract of carriage.',
    `port_of_discharge` STRING COMMENT 'UN/LOCODE of the port where the cargo is discharged from the ocean vessel. Represents the destination port for the ocean leg. Used for customs import filing, terminal handling charge (THC) calculation, and delivery planning.. Valid values are `^[A-Z]{5}$`',
    `port_of_loading` STRING COMMENT 'UN/LOCODE of the port where the cargo is loaded onto the ocean vessel. Represents the origin port for the ocean leg of the shipment. Used for freight rate calculation, customs export filing, and carrier scheduling.. Valid values are `^[A-Z]{5}$`',
    `service_type` STRING COMMENT 'Classification of the ocean freight service: Full Container Load (FCL), Less than Container Load (LCL), Roll-on/Roll-off (RORO), bulk, or break-bulk. Determines container allocation, consolidation requirements, and applicable tariff structures.. Valid values are `FCL|LCL|RORO|BULK|BREAKBULK`',
    `shipper_reference` STRING COMMENT 'Shippers own internal reference number or purchase order number associated with this shipment. Printed on the bill of lading for cross-referencing with the shippers ERP or order management system. Facilitates EDI reconciliation.',
    `teu_count` DECIMAL(18,2) COMMENT 'Total number of Twenty-foot Equivalent Units (TEUs) represented by the containers on this bill of lading. A 20-foot container = 1 TEU; a 40-foot container = 2 TEUs. Used for vessel capacity utilization, port statistics, and freight revenue reporting.',
    `total_freight_amount` DECIMAL(18,2) COMMENT 'Total freight charges payable as stated on the bill of lading, being the sum of the base freight amount and all applicable surcharges. Used for freight invoice generation, letter of credit compliance, and revenue reporting. Satisfies TRANSACTION_HEADER MONETARY_TRIPLET minimum category (net total component).',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the specific dangerous substance or article as assigned by the UN Committee of Experts on the Transport of Dangerous Goods. Populated only when is_hazardous is true. Required on shipping documents and package markings.. Valid values are `^UN[0-9]{4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the bill of lading record was last modified in the source system or the lakehouse. Used for incremental data loading, change data capture (CDC), and audit trail maintenance. Satisfies TRANSACTION_HEADER RECORD_AUDIT_UPDATED minimum category.',
    `vessel_name` STRING COMMENT 'Name of the ocean-going vessel (ship) carrying the cargo as recorded on the bill of lading. Used for shipment tracking, customs filing (AMS/ISF), and port authority notifications.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the cargo expressed in cubic meters (CBM). Used for LCL freight rate calculation, container utilization assessment, and dimensional weight (DIM weight) comparison for rating purposes.',
    `voyage_number` STRING COMMENT 'Carrier-assigned voyage or trip number identifying the specific sailing of the vessel. Combined with vessel name, uniquely identifies the ocean leg for scheduling, tracking, and customs manifest filing purposes.',
    CONSTRAINT pk_bill_of_lading PRIMARY KEY(`bill_of_lading_id`)
) COMMENT 'Master document for ocean freight shipments serving as the contract of carriage, receipt of goods, and document of title. Stores MBL and HBL numbers, vessel name, voyage number, port of loading (POL), port of discharge (POD), place of delivery, container numbers, seal numbers, commodity description, number of packages, gross weight, CBM, freight terms (prepaid/collect), and NVOCC details. Governed by FMC and IMO regulations. Sourced from SAP TM ocean freight module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`consolidation` (
    `consolidation_id` BIGINT COMMENT 'Unique identifier for the consolidation. Primary key for the consolidation entity.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Consolidations operate under carrier master agreements for capacity and rates. Business process: contracted consolidation rate application, capacity utilization tracking against carrier commitments, N',
    `carrier_id` BIGINT COMMENT 'Identifier of the ocean carrier, airline, or surface carrier assigned to transport the consolidation. For NVOCC operations, this is the underlying vessel or flight operator.',
    `consolidation_nvocc_operator_carrier_id` BIGINT COMMENT 'Identifier of the NVOCC or freight forwarder operating the consolidation. For direct carrier consolidations, this may be null.',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: Ocean consolidations are stuffed into specific containers. Critical for container-level consolidation tracking and CFS operations. Replaces denormalized container_number string with proper FK to conta',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Consolidation operations (CFS handling, groupage services) incur direct labor, facility, and equipment costs that must be allocated to specific cost centers for operational cost management and service',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Consolidated shipments require master customs declarations covering all house shipments. Links consolidation to entry filing for deconsolidation authorization and duty assessment.',
    `facility_id` BIGINT COMMENT 'Identifier of the destination CFS or ICD facility where the consolidation will be deconsolidated and cargo distributed. Links to warehouse or facility master data.',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Consolidations require complete document packages for deconsolidation and customs clearance. NVOCC operational requirement to maintain consolidated documentation set for all shipments within the conso',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Consolidations are planned and executed on specific contracted lanes between origin and destination ports. Master routing decisions, carrier selection, transit time commitments, and cost allocation al',
    `origin_cfs_facility_id` BIGINT COMMENT 'Identifier of the origin CFS or ICD facility where cargo is received and consolidated. Links to warehouse or facility master data.',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to network.hub_gateway. Business justification: Consolidations are built at specific hub/gateway facilities (CFS, container terminals, air cargo terminals). Operations track which hub handled consolidation for dwell time analysis, handling cost all',
    `partner_id` BIGINT COMMENT 'Identifier of a co-loading partner sharing space in this consolidation. Null if no co-loading arrangement exists.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Consolidation services are often separate profit centers or contribute to specific segment P&L. Required for segment reporting, service line profitability analysis, and strategic decisions on consolid',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Consolidation services (LCL, groupage) are priced using specialized consolidation rate cards. Rate_card_id links the consolidation to the applicable rate card, enables consolidation pricing validation',
    `saf_procurement_id` BIGINT COMMENT 'Foreign key linking to sustainability.saf_procurement. Business justification: SAF (Sustainable Aviation Fuel) procurement is allocated to specific air consolidations for CORSIA compliance, customer green product delivery, and book-and-claim certificate tracking in aviation.',
    `trade_document_id` BIGINT COMMENT 'Foreign key linking to document.trade_document. Business justification: Consolidations require consolidated trade documentation (manifests, consolidated invoices) for customs clearance. NVOCC regulatory requirement for presenting unified trade documentation at destination',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Consolidations are transported on specific assets (aircraft for air consolidations, trucks for LCL). Essential for consolidation execution tracking, asset utilization, and operational coordination. St',
    `actual_arrival_datetime` TIMESTAMP COMMENT 'Actual arrival date and time when the carrier arrived at the destination port.',
    `actual_departure_datetime` TIMESTAMP COMMENT 'Actual departure date and time when the carrier departed the origin port. ETD (Estimated Time of Departure) becomes actual once confirmed.',
    `cargo_cutoff_datetime` TIMESTAMP COMMENT 'Latest date and time by which cargo must be received at the origin CFS facility to be included in this consolidation.',
    `carrier_booking_reference` STRING COMMENT 'Booking or reservation number provided by the carrier for the consolidation space allocation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `consolidation_status` STRING COMMENT 'Current lifecycle status of the consolidation from planning through deconsolidation at destination. [ENUM-REF-CANDIDATE: planned|booking_open|cargo_receiving|closed|departed|in_transit|arrived|deconsolidated — 8 candidates stripped; promote to reference product]',
    `consolidation_type` STRING COMMENT 'Type of consolidation based on transport mode. Ocean LCL (Less Than Container Load) groups multiple shippers cargo into a single FCL container. Air groupage consolidates shipments into a single ULD (Unit Load Device). Road and rail groupage combine multiple LTL shipments.. Valid values are `ocean_lcl|air_groupage|road_groupage|rail_groupage`',
    `container_size_type` STRING COMMENT 'ISO container size and type code for ocean consolidations. 20GP = 20-foot General Purpose, 40GP = 40-foot General Purpose, 40HC = 40-foot High Cube, 45HC = 45-foot High Cube. Null for non-containerized modes.. Valid values are `20GP|40GP|40HC|45HC`',
    `contains_dangerous_goods` BOOLEAN COMMENT 'Indicates whether the consolidation contains any dangerous goods (hazardous materials) requiring special handling and documentation per IMDG or IATA DGR.',
    `contains_temperature_controlled` BOOLEAN COMMENT 'Indicates whether the consolidation contains temperature-sensitive cargo requiring reefer container or climate-controlled handling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation record was first created in the system.',
    `deconsolidation_complete_datetime` TIMESTAMP COMMENT 'Date and time when all cargo was deconsolidated and available for onward delivery or pickup.',
    `deconsolidation_start_datetime` TIMESTAMP COMMENT 'Date and time when deconsolidation operations began at the destination CFS facility.',
    `estimated_arrival_datetime` TIMESTAMP COMMENT 'Estimated arrival date and time at the destination port. Updated based on carrier tracking and real-time visibility data.',
    `freight_charge_currency` STRING COMMENT 'ISO 4217 three-letter currency code for freight charges (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `incoterm` STRING COMMENT 'Incoterms 2020 rule governing the transfer of costs and risks between shipper and consignee for the consolidation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the consolidation record was last updated in the system.',
    `notes` STRING COMMENT 'Free-text operational notes and special instructions for the consolidation, including handling requirements, stowage instructions, or exception documentation.',
    `reference` STRING COMMENT 'Externally-known business reference number for the consolidation, used in operational communications and documentation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `scheduled_departure_datetime` TIMESTAMP COMMENT 'Scheduled departure date and time of the carrier vessel, flight, or vehicle transporting the consolidation from origin port.',
    `service_level` STRING COMMENT 'Service level commitment for the consolidation, determining transit time and handling priority.. Valid values are `economy|standard|express|premium`',
    `total_chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Total chargeable weight for the consolidation, calculated as the greater of gross weight or volumetric weight (volume * dimensional weight factor). Used for freight charge calculation.',
    `total_freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight charges for the consolidation, including base ocean or air freight, BAF (Bunker Adjustment Factor), GRI (General Rate Increase), THC (Terminal Handling Charge), and other surcharges.',
    `total_gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of all cargo in the consolidation, measured in kilograms.',
    `total_piece_count` STRING COMMENT 'Total number of individual pieces or packages across all shipments in the consolidation.',
    `total_shipment_count` STRING COMMENT 'Number of individual shipper shipments (house shipments) consolidated into this master consolidation.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of all cargo in the consolidation, measured in cubic meters. Critical for LCL and air groupage space utilization.',
    `uld_number` STRING COMMENT 'IATA ULD identifier for air groupage consolidations. Format: 3-letter ULD type code + 5-digit serial + 2-letter owner code. Null for non-air consolidations.. Valid values are `^[A-Z]{3}[0-9]{5}[A-Z]{2}$`',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of container or ULD capacity utilized by the consolidation, calculated as (actual volume / maximum capacity) * 100. Key metric for consolidation efficiency.',
    CONSTRAINT pk_consolidation PRIMARY KEY(`consolidation_id`)
) COMMENT 'Represents an LCL or groupage consolidation where multiple shippers cargo is grouped into a single FCL container or air ULD for cost-efficient transport. Captures consolidation reference, mode (ocean LCL, air groupage), origin and destination CFS facilities, consolidation status, cargo cut-off date/time, departure date, total CBM utilized, total weight, number of constituent shipments, and assigned carrier. Central to NVOCC co-loading operations and CFS management workflows.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`load_plan` (
    `load_plan_id` BIGINT COMMENT 'Unique identifier for the load plan record. Primary key.',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: For air freight, a load plan defines how cargo is loaded onto an aircraft or ULD, and references the air waybill. One load_plan for one AWB. Nullable when load plan is for ocean or other modes.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: For ocean freight, a load plan defines how cargo is loaded into a container or vessel, and references the bill of lading. One load_plan for one BOL. Nullable when load plan is for air or other modes.',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: A load plan can be created for a consolidation (defining how consolidated cargo is loaded into a container or ULD). One load_plan for one consolidation. This is an alternative to load_plan → freight_o',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Load planning operations are performed by specific cost centers (planning teams, facilities). Labor and system costs must be allocated to cost centers for operational efficiency analysis and cost cent',
    `freight_manifest_id` BIGINT COMMENT 'Foreign key linking to shipment.freight_manifest. Business justification: Load plan is the pre-execution planning artifact; freight manifest is the actual executed load. In real operations, approved load plans are executed as manifests. Enables plan-to-execution traceabilit',
    `freight_order_id` BIGINT COMMENT 'Reference to the parent freight order for which this load plan is created. Links to the freight order entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or system user who created or approved the load plan. Links to workforce/user management system.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to warehouse.storage_location. Business justification: Load plans specify staging locations within warehouses where cargo is assembled before container/vehicle loading. Tracking staging_location_id enables warehouse space utilization analysis, load sequen',
    `tertiary_load_planner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `transport_asset_id` BIGINT COMMENT 'Identifier of the transport unit (vessel, aircraft, truck, railcar, container) onto which cargo is being loaded. May be vessel IMO number, aircraft registration, truck license plate, or container number.',
    `actual_load_completion_time` TIMESTAMP COMMENT 'Actual timestamp when loading operations were completed. Critical for on-time performance tracking and operational efficiency analysis.',
    `actual_load_start_time` TIMESTAMP COMMENT 'Actual timestamp when loading operations commenced. Used for performance measurement and variance analysis against planned time.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the load plan was formally approved for execution. Marks transition from planning to operational phase.',
    `cargo_placement_instructions` STRING COMMENT 'Detailed instructions for cargo placement within the transport unit, including stacking rules, orientation requirements, and securing methods.',
    `center_of_gravity_x` DECIMAL(18,2) COMMENT 'Calculated X-coordinate of the load center of gravity relative to transport unit reference point. Critical for vessel and aircraft stability.',
    `center_of_gravity_y` DECIMAL(18,2) COMMENT 'Calculated Y-coordinate of the load center of gravity relative to transport unit reference point. Critical for vessel and aircraft stability.',
    `center_of_gravity_z` DECIMAL(18,2) COMMENT 'Calculated Z-coordinate (vertical) of the load center of gravity relative to transport unit reference point. Critical for vessel and aircraft stability.',
    `contains_hazmat` BOOLEAN COMMENT 'Indicates whether the load plan includes hazardous materials requiring special handling and segregation. Triggers additional compliance checks.',
    `contains_temperature_controlled` BOOLEAN COMMENT 'Indicates whether the load plan includes temperature-sensitive cargo requiring refrigerated or climate-controlled transport.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the load plan record was first created in the system. Used for audit trail and data lineage.',
    `hazmat_class` STRING COMMENT 'UN hazard class of dangerous goods included in the load plan. Determines segregation requirements and handling procedures. Pipe-separated list if multiple classes present.',
    `hazmat_segregation_verified` BOOLEAN COMMENT 'Indicates whether hazmat segregation requirements have been verified and approved by qualified personnel. Mandatory for hazmat loads.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the load plan record was last updated. Used for change tracking and audit trail.',
    `load_optimization_method` STRING COMMENT 'Method used to create the load plan. Automated plans use TMS optimization algorithms, manual plans are created by planners, hybrid combines both.. Valid values are `manual|automated|hybrid`',
    `load_plan_status` STRING COMMENT 'Current lifecycle status of the load plan. Tracks progression from initial planning through execution completion. [ENUM-REF-CANDIDATE: draft|planned|approved|in_progress|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `load_sequence_number` STRING COMMENT 'Sequential order in which cargo items are to be loaded onto the transport unit. Critical for LIFO/FIFO optimization and unloading efficiency.',
    `loading_dock_bay` STRING COMMENT 'Specific dock, bay, or gate number where loading operations are performed. Used for operational coordination and resource allocation.',
    `loading_location_code` STRING COMMENT 'Code identifying the facility or terminal where loading operations take place. May be UN/LOCODE, IATA airport code, or internal facility code.. Valid values are `^[A-Z]{3,5}$`',
    `max_volume_capacity_cbm` DECIMAL(18,2) COMMENT 'Maximum volume capacity of the transport unit in cubic meters. Physical constraint for load planning.',
    `max_weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the transport unit in kilograms. Regulatory limit that must not be exceeded.',
    `notes` STRING COMMENT 'Free-text notes or comments about the load plan, including special circumstances, deviations from standard procedures, or operational alerts.',
    `planned_load_completion_time` TIMESTAMP COMMENT 'Scheduled timestamp when loading operations are expected to be completed. Used for departure scheduling and SLA management.',
    `planned_load_date` DATE COMMENT 'Scheduled date when loading operations are planned to begin. Used for resource planning and scheduling.',
    `planned_load_start_time` TIMESTAMP COMMENT 'Precise timestamp when loading operations are scheduled to commence. Critical for dock scheduling and labor planning.',
    `reference` STRING COMMENT 'Business-facing unique reference number for the load plan, used for external communication and documentation. Typically follows format LP-XXXXXXXX.. Valid values are `^LP-[A-Z0-9]{8,12}$`',
    `service_type` STRING COMMENT 'Service level for the load plan. FTL (Full Truckload), LTL (Less Than Truckload), FCL (Full Container Load), LCL (Less Than Container Load), or express/standard/economy for air and parcel. [ENUM-REF-CANDIDATE: FTL|LTL|FCL|LCL|express|standard|economy — 7 candidates stripped; promote to reference product]',
    `special_handling_requirements` STRING COMMENT 'Any special handling requirements for the load, such as fragile cargo, high-value goods, live animals, or oversized items requiring special equipment.',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature requirement in Celsius for temperature-controlled cargo in this load plan. Must be maintained throughout transport.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature requirement in Celsius for temperature-controlled cargo in this load plan. Must be maintained throughout transport.',
    `total_actual_volume_cbm` DECIMAL(18,2) COMMENT 'Total actual volume of all cargo loaded, measured in cubic meters. Captured post-loading for utilization analysis.',
    `total_actual_weight_kg` DECIMAL(18,2) COMMENT 'Total actual weight of all cargo loaded, measured in kilograms. Captured post-loading for verification and compliance documentation.',
    `total_planned_volume_cbm` DECIMAL(18,2) COMMENT 'Total planned volume of all cargo to be loaded, measured in cubic meters. Used for space utilization and capacity planning.',
    `total_planned_weight_kg` DECIMAL(18,2) COMMENT 'Total planned weight of all cargo to be loaded, measured in kilograms. Used for weight distribution calculations and regulatory compliance.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this load plan. Determines operational procedures, documentation requirements, and regulatory compliance.. Valid values are `air|ocean|road|rail|intermodal`',
    `transport_unit_type` STRING COMMENT 'Type of transport unit for which the load plan is created. Determines applicable loading rules and constraints.. Valid values are `vessel|aircraft|truck|railcar|container|trailer`',
    `version` STRING COMMENT 'Version number of the load plan. Incremented when significant changes are made to the plan after initial creation.',
    `volume_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of volume capacity utilized by the planned load. Key performance indicator for space optimization efficiency.',
    `weight_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of weight capacity utilized by the planned load. Key performance indicator for load optimization efficiency.',
    CONSTRAINT pk_load_plan PRIMARY KEY(`load_plan_id`)
) COMMENT 'Operational plan defining how cargo is loaded onto a transport unit (vessel, aircraft, truck, railcar). Captures load plan reference, transport unit identifier, planned vs actual load sequence, cargo placement instructions, weight distribution, center of gravity calculations, hazmat segregation requirements, load status, and planner details. Integrates with Oracle TMS load optimization module. Critical for FTL road and ocean vessel operations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` (
    `freight_carrier_assignment_id` BIGINT COMMENT 'Unique identifier for the carrier assignment record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Carrier assignments represent vendor service commitments that flow to AP for payment processing, cost accrual, and vendor liability tracking. Essential for carrier payment accuracy, cost matching, and',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Carrier assignment for air freight is documented in the air waybill. One carrier assignment per AWB (typically). Nullable when carrier assignment is for ocean or other modes.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Carrier assignment for ocean freight is documented in the bill of lading. One carrier assignment per BOL (typically). Nullable when carrier assignment is for air or other modes.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Carrier can be assigned at booking stage (space confirmation with carrier). Many carrier assignments for one booking (if booking is modified or reassigned). Nullable when carrier assignment is for con',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Carrier assignments reference specific carrier agreements for rate and service terms. Business process: agreement-based rate lookup, SLA enforcement, penalty/incentive calculation. Removes denormalize',
    `carrier_buy_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.carrier_buy_rate. Business justification: Carrier assignments use negotiated carrier buy rates for cost calculation and margin analysis. Carrier_buy_rate_id enables actual cost tracking at assignment level, supports margin calculation (sell r',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (airline, ocean carrier, road haulier, rail operator) assigned to this freight order. Links to the carrier master entity.',
    `carrier_payable_id` BIGINT COMMENT 'Foreign key linking to billing.carrier_payable. Business justification: Carrier assignments drive carrier payables (AP for carrier services). Assignment-to-payable link enables carrier cost tracking, rate validation, and carrier invoice reconciliation against contracted a',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Carrier assignments specify not just carrier but the specific service offering (e.g., ocean FCL weekly string, air express flight, LTL route). Rate cards, SLAs, and capacity allocations are service-sp',
    `freight_order_id` BIGINT COMMENT 'Reference to the freight order or consolidation to which this carrier is assigned. Links to the freight order entity managed in SAP TM or Oracle TMS.',
    `lane_id` BIGINT COMMENT 'Reference to the assigned transportation lane (origin-destination pair) for this carrier assignment. Links to the lane master entity in the route domain.',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that created this carrier assignment. Links to the workforce or system user entity.',
    `supplier_emissions_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_emissions_disclosure. Business justification: Carrier emissions data is required for Scope 3 Category 4 reporting, carrier sustainability scorecarding in procurement decisions, and CDP Supply Chain disclosure programs.',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: When carrier executes using own fleet modeled in system, links assignment to specific asset. Supports own-fleet vs subcontractor analysis and asset-level cost allocation. Operational tracking for inte',
    `accessorial_charges_amount` DECIMAL(18,2) COMMENT 'Total accessorial charges for additional services such as liftgate, inside delivery, detention, demurrage, Terminal Handling Charge (THC), or special equipment.',
    `assignment_date` DATE COMMENT 'Date when the carrier was assigned to the freight order. Represents the business event date of carrier selection.',
    `assignment_status` STRING COMMENT 'Current status of the carrier assignment in its lifecycle: pending carrier confirmation, confirmed by carrier, rejected by carrier, cancelled by shipper, or expired due to timeout.. Valid values are `pending|confirmed|rejected|cancelled|expired`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the carrier assignment was created in the system. Supports audit trail and carrier selection analytics.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the carrier assignment was cancelled. Includes carrier rejection reason, shipper cancellation reason, or system timeout. Null if not cancelled.',
    `carrier_booking_reference` STRING COMMENT 'Booking reference number or confirmation code provided by the carrier upon acceptance. Used for tracking and coordination with carrier systems.',
    `carrier_iata_code` STRING COMMENT 'IATA two-letter or three-character airline designator code for air carriers. Used for air waybill (AWB) and flight operations.. Valid values are `^[A-Z0-9]{2,3}$`',
    `carrier_instructions` STRING COMMENT 'Special instructions or requirements specific to this carrier assignment, such as handling requirements, delivery windows, contact information, or operational constraints.',
    `carrier_scac_code` STRING COMMENT 'Standard Carrier Alpha Code uniquely identifying the carrier in North American freight operations. 2-4 uppercase letters assigned by the National Motor Freight Traffic Association (NMFTA).. Valid values are `^[A-Z]{2,4}$`',
    `confirmation_date` DATE COMMENT 'Date when the carrier confirmed acceptance of the freight assignment. Null if not yet confirmed.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the carrier confirmed the assignment. Used for Service Level Agreement (SLA) tracking and carrier performance measurement.',
    `container_count` STRING COMMENT 'Number of containers assigned to this carrier for ocean or intermodal freight. Applicable for Full Container Load (FCL) and Less Than Container Load (LCL) shipments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier assignment record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight charge amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customs_broker_required` BOOLEAN COMMENT 'Boolean flag indicating whether this carrier assignment requires customs brokerage services for cross-border shipments. Integrates with Descartes Customs system.',
    `equipment_type` STRING COMMENT 'Type of equipment or container assigned by the carrier, such as 20ft dry container, 40ft high cube, refrigerated container (reefer), flatbed trailer, or tanker.',
    `estimated_delivery_date` DATE COMMENT 'Estimated date when the carrier will deliver the freight to the destination. Used for customer communication and Service Level Agreement (SLA) tracking.',
    `estimated_pickup_date` DATE COMMENT 'Estimated date when the carrier will pick up the freight from the origin location. Used for planning and coordination.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Base freight charge amount quoted or contracted with the carrier for this assignment, excluding surcharges and accessorial fees.',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Fuel surcharge or Bunker Adjustment Factor (BAF) applied by the carrier to account for fuel price fluctuations. Separate from base freight charge.',
    `hazmat_certified` BOOLEAN COMMENT 'Boolean flag indicating whether the assigned carrier is certified to transport hazardous materials (dangerous goods) per International Maritime Dangerous Goods (IMDG) Code or ICAO Technical Instructions.',
    `incoterm` STRING COMMENT 'Incoterms rule defining the responsibilities, costs, and risks between buyer and seller for this carrier assignment. Determines carrier liability and cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_intermodal` BOOLEAN COMMENT 'Boolean flag indicating whether this carrier assignment is part of an intermodal transport chain involving multiple modes (e.g., ocean to rail to road).',
    `is_primary_carrier` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary carrier assignment for the freight order. True if primary, False if backup or secondary carrier.',
    `master_awb_number` STRING COMMENT 'Master Air Waybill number issued by the air carrier for air freight assignments. Format: 3-digit airline code followed by 8-digit serial number.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `master_bol_number` STRING COMMENT 'Master Bill of Lading number issued by the ocean carrier or Non-Vessel Operating Common Carrier (NVOCC) for ocean freight assignments.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier assignment record was last modified. Updated on any change to assignment status, confirmation, or carrier details.',
    `priority_level` STRING COMMENT 'Priority level assigned to this carrier assignment for operational sequencing and resource allocation: critical (urgent), high, normal, or low priority.. Valid values are `critical|high|normal|low`',
    `selection_criteria` STRING COMMENT 'Business criteria or rules applied during carrier selection, such as lowest cost, fastest transit, preferred carrier, service level, or capacity availability.',
    `selection_method` STRING COMMENT 'Method used to select this carrier: manual selection by planner, automated rule-based selection, optimization algorithm, spot market quote, or pre-negotiated contract assignment.. Valid values are `manual|automated|optimization|spot_quote|contract`',
    `service_type` STRING COMMENT 'Type of carrier service assigned: Full Truckload (FTL), Less Than Truckload (LTL), Full Container Load (FCL), Less Than Container Load (LCL), express, standard, economy, or charter. [ENUM-REF-CANDIDATE: FTL|LTL|FCL|LCL|express|standard|economy|charter — 8 candidates stripped; promote to reference product]',
    `temperature_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether this carrier assignment requires temperature-controlled (refrigerated or heated) transport equipment.',
    `teu_count` DECIMAL(18,2) COMMENT 'Total capacity in Twenty-foot Equivalent Units (TEU) assigned to this carrier. Standard measure for container capacity where one 20-foot container equals 1 TEU and one 40-foot container equals 2 TEU.',
    `total_carrier_cost` DECIMAL(18,2) COMMENT 'Total cost payable to the carrier including base freight charge, fuel surcharge, and all accessorial charges. Used for freight audit and cost reconciliation.',
    `tracking_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether real-time shipment tracking is enabled for this carrier assignment via integration with FourKites or carrier tracking systems.',
    `transit_time_days` STRING COMMENT 'Expected transit time in days from pickup to delivery as committed by the carrier. Used for performance measurement and On-Time Delivery (OTD) tracking.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this carrier assignment: air freight, ocean freight, road (truck), rail, or intermodal (combination of modes).. Valid values are `air|ocean|road|rail|intermodal`',
    `vehicle_count` STRING COMMENT 'Number of vehicles (trucks, trailers, railcars) assigned by the carrier for this freight order. Applicable for road and rail transport modes.',
    CONSTRAINT pk_freight_carrier_assignment PRIMARY KEY(`freight_carrier_assignment_id`)
) COMMENT 'Records the assignment of a carrier (airline, ocean carrier, road haulier, rail operator) to a specific freight order or consolidation. Captures carrier SCAC/IATA code, service type, assigned lane, contracted rate reference, assignment date, confirmation status, carrier booking reference, and any carrier-specific instructions. Supports carrier selection logic from SAP TM and freight audit in Oracle TMS. Distinct from the contract domain which owns the carrier agreement terms.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`freight_leg` (
    `freight_leg_id` BIGINT COMMENT 'Unique identifier for the freight leg. Primary key for this transport segment within a multi-leg or intermodal freight movement.',
    `accrual_id` BIGINT COMMENT 'Foreign key linking to finance.accrual. Business justification: Individual freight legs may trigger cost accruals when carrier invoices arrive in different periods than service delivery. Required for matching principle compliance, accurate period-end cost recognit',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: For air freight, individual transport legs are documented in the air waybill. Many legs for one AWB (multi-leg air shipments with transits). Nullable when leg is for ocean or other modes.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: For ocean freight, individual transport legs are documented in the bill of lading. Many legs for one BOL (multi-leg ocean shipments with transshipments). Nullable when leg is for air or other modes.',
    `carbon_offset_transaction_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_transaction. Business justification: Offsets can be purchased at leg level for specific high-emission segments (e.g., air legs in multimodal shipments) enabling granular carbon neutrality in intermodal transport.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Individual freight legs execute under carrier agreements. Business process: leg-level carrier rate application, transit time SLA verification, carrier performance measurement against agreement commitm',
    `carrier_buy_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.carrier_buy_rate. Business justification: Individual transport legs reference carrier buy rates for segment-level cost allocation in intermodal shipments. Carrier_buy_rate_id enables leg-by-leg margin analysis, supports intermodal cost breakd',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier responsible for executing this transport leg. Identifies the logistics service provider or NVOCC handling this segment.',
    `carrier_payable_id` BIGINT COMMENT 'Foreign key linking to billing.carrier_payable. Business justification: Individual legs generate carrier payables (carrier invoices for leg operations). Leg-to-payable link enables granular carrier cost tracking and supports intermodal carrier settlement reconciliation.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Each freight leg executes on a specific carrier service (vessel voyage, flight, truck route). Operations track actual service used vs. planned for transit time analysis, service reliability metrics, a',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment that this leg is part of. Enables tracking of the leg within the broader shipment context.',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: Freight legs can be part of a consolidation movement (e.g., consolidated cargo moving from origin CFS to destination CFS). Many legs for one consolidation. Nullable when leg is for individual shipment',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: Intermodal legs transport specific containers through journey. Essential for container journey tracking and intermodal visibility. Replaces denormalized container_number string with proper FK to conta',
    `network_node_id` BIGINT COMMENT 'Reference to the destination location for this leg. Can be a port, airport, warehouse, Container Freight Station (CFS), Inland Container Depot (ICD), or other network node.',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Each leg uses specific emission factors based on actual transport mode, vehicle type, and fuel type for accurate carbon calculation per GLEC Framework and regulatory compliance.',
    `freight_carrier_assignment_id` BIGINT COMMENT 'Foreign key linking to freight.carrier_assignment. Business justification: Each freight leg has a carrier assignment (the carrier operating that specific leg). Many legs can share one carrier assignment, or each leg can have its own. Nullable when leg is planned but carrier ',
    `freight_order_id` BIGINT COMMENT 'Reference to the parent freight order that this leg belongs to. Links this transport segment to the overall freight booking.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Each freight leg executes on a specific contracted lane with defined carrier, service level, and pricing. Operational reporting (lane utilization, carrier performance by leg, cost variance analysis) a',
    `origin_node_network_node_id` BIGINT COMMENT 'Reference to the origin location for this leg. Can be a port, airport, warehouse, Container Freight Station (CFS), Inland Container Depot (ICD), or other network node.',
    `packaging_sustainability_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_sustainability. Business justification: Packaging materials and sustainability attributes are tracked per shipment leg for circular economy programs, customer ESG reporting, and plastic-free/recyclable packaging commitments in logistics ope',
    `primary_freight_network_node_id` BIGINT COMMENT 'Reference to the network node where the intermodal transfer occurs. Typically a Container Freight Station (CFS), Inland Container Depot (ICD), or intermodal terminal.',
    `revenue_recognition_id` BIGINT COMMENT 'Foreign key linking to billing.revenue_recognition. Business justification: Revenue recognized as individual legs complete (progress-based recognition for multi-leg shipments). Leg-to-recognition link enables granular revenue accounting and supports percentage-of-completion r',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: Each transport leg generates specific emissions data for granular carbon accounting, multimodal emissions breakdown, carrier performance tracking, and accurate customer carbon report allocation by leg',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Freight legs with intermodal transfers (e.g., ocean-to-rail, air-to-truck) occur at warehouse facilities (CFS, cross-dock terminals). Tracking transfer_facility_id enables transfer dwell time analysis',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Each freight leg is executed by a specific transport asset. Critical for multi-modal tracking, asset utilization per leg, and operational performance analysis. Replaces denormalized vehicle_registrati',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual arrival date and time when the freight reached the destination location for this leg. Used for performance tracking and On-Time Delivery (OTD) calculation.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual departure date and time when the freight left the origin location for this leg. Used for performance tracking and On-Time Delivery (OTD) calculation.',
    `actual_transit_time_hours` DECIMAL(18,2) COMMENT 'Actual transit time for this leg in hours. Calculated as the difference between actual arrival and actual departure timestamps. Used for On-Time Delivery (OTD) performance measurement.',
    `baf_amount` DECIMAL(18,2) COMMENT 'Bunker Adjustment Factor surcharge for this leg. Fuel-related surcharge applied to ocean freight to account for fluctuating fuel costs.',
    `container_type` STRING COMMENT 'Type and size of container used for this leg. Indicates standard dry containers (20ft, 40ft, 40ft High Cube), refrigerated (reefer), tank, flat rack, or open top containers. [ENUM-REF-CANDIDATE: 20ft|40ft|40ft_HC|45ft|reefer|tank|flat_rack|open_top — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this freight leg record was first created in the system. Used for audit trail and data lineage tracking.',
    `delay_duration_hours` DECIMAL(18,2) COMMENT 'Duration of delay for this leg in hours. Calculated as the difference between actual and scheduled arrival times when a delay occurs.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the reason for any delay on this leg. Used for root cause analysis and carrier performance evaluation.',
    `destination_location_type` STRING COMMENT 'Type of facility at the destination of this leg. Classifies the ending point as port, airport, warehouse, Container Freight Station (CFS), Inland Container Depot (ICD), terminal, or depot. [ENUM-REF-CANDIDATE: port|airport|warehouse|CFS|ICD|terminal|depot — 7 candidates stripped; promote to reference product]',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance covered by this leg in kilometers. Used for mileage-based pricing, carbon footprint calculation, and route optimization.',
    `dwell_time_hours` DECIMAL(18,2) COMMENT 'Duration in hours that freight remains at the destination location before moving to the next leg. Critical for intermodal transfer efficiency and Service Level Agreement (SLA) monitoring.',
    `freight_charges_amount` DECIMAL(18,2) COMMENT 'Base freight charges for this leg. Excludes surcharges such as Bunker Adjustment Factor (BAF), General Rate Increase (GRI), and Terminal Handling Charge (THC).',
    `freight_charges_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight charges amount. Indicates the currency in which base freight fees are denominated.. Valid values are `^[A-Z]{3}$`',
    `gri_amount` DECIMAL(18,2) COMMENT 'General Rate Increase surcharge for this leg. Carrier-imposed rate adjustment applied to base freight charges, typically for ocean freight.',
    `handling_charges_amount` DECIMAL(18,2) COMMENT 'Total handling charges incurred at the destination of this leg. Includes Terminal Handling Charge (THC), Container Freight Station (CFS) charges, and other transfer-related fees.',
    `handling_charges_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the handling charges amount. Indicates the currency in which handling fees are denominated.. Valid values are `^[A-Z]{3}$`',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether this leg carries hazardous materials requiring special handling and compliance with International Maritime Dangerous Goods (IMDG) Code or ICAO Technical Instructions.',
    `is_intermodal_transfer` BOOLEAN COMMENT 'Indicates whether this leg involves an intermodal transfer (change of transport mode) at the destination. True if freight transitions between air/ocean/road/rail at the end of this leg.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this freight leg record was last modified. Used for audit trail and change tracking.',
    `leg_status` STRING COMMENT 'Current operational status of this freight leg in its lifecycle. Tracks progression from planning through execution to completion.. Valid values are `planned|booked|in_transit|completed|cancelled|delayed`',
    `origin_location_type` STRING COMMENT 'Type of facility at the origin of this leg. Classifies the starting point as port, airport, warehouse, Container Freight Station (CFS), Inland Container Depot (ICD), terminal, or depot. [ENUM-REF-CANDIDATE: port|airport|warehouse|CFS|ICD|terminal|depot — 7 candidates stripped; promote to reference product]',
    `scheduled_arrival_timestamp` TIMESTAMP COMMENT 'Planned arrival date and time for this leg at the destination location. Represents the Estimated Time of Arrival (ETA) used for planning and customer communication.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned departure date and time for this leg from the origin location. Represents the Estimated Time of Departure (ETD) used for planning and customer communication.',
    `sequence_number` STRING COMMENT 'Sequential order of this leg within the multi-leg freight movement. Indicates the position in the transport chain (e.g., 1 for first leg, 2 for second leg).',
    `service_type` STRING COMMENT 'Type of freight service for this leg. Indicates Full Truckload (FTL), Less Than Truckload (LTL), Full Container Load (FCL), Less Than Container Load (LCL), or express/standard/economy service levels. [ENUM-REF-CANDIDATE: FTL|LTL|FCL|LCL|express|standard|economy — 7 candidates stripped; promote to reference product]',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether this leg requires temperature-controlled transport (refrigerated or heated). Applicable for perishable goods, pharmaceuticals, and temperature-sensitive cargo.',
    `teu_count` DECIMAL(18,2) COMMENT 'Number of Twenty-foot Equivalent Units (TEU) for this leg. Standard measure of container capacity where a 20ft container equals 1 TEU and a 40ft container equals 2 TEU.',
    `thc_amount` DECIMAL(18,2) COMMENT 'Terminal Handling Charge for this leg. Fee charged for handling containers at the origin or destination terminal.',
    `total_leg_charges_amount` DECIMAL(18,2) COMMENT 'Total charges for this leg including base freight, surcharges (BAF, GRI, THC), and handling charges. Represents the complete cost of this transport segment.',
    `total_leg_charges_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the total leg charges amount. Indicates the currency in which total leg costs are denominated.. Valid values are `^[A-Z]{3}$`',
    `transfer_type` STRING COMMENT 'Type of intermodal transfer occurring at the destination of this leg. Specifies the mode transition (e.g., ocean to road, air to road, rail to road) or none if no transfer. [ENUM-REF-CANDIDATE: ocean_to_road|ocean_to_rail|air_to_road|road_to_ocean|road_to_rail|rail_to_road|none — 7 candidates stripped; promote to reference product]',
    `transit_time_hours` DECIMAL(18,2) COMMENT 'Planned transit time for this leg in hours. Calculated as the difference between scheduled arrival and scheduled departure timestamps.',
    `transport_document_number` STRING COMMENT 'Reference number of the transport document for this leg. Can be an Air Waybill (AWB), Bill of Lading (BOL), House Air Waybill (HAWB), Master Air Waybill (MAWB), House Bill of Lading (HBL), or Master Bill of Lading (MBL) depending on mode.',
    `transport_document_type` STRING COMMENT 'Type of transport document issued for this leg. Identifies whether it is an Air Waybill (AWB), Bill of Lading (BOL), House/Master variants, or road/rail consignment note. [ENUM-REF-CANDIDATE: AWB|BOL|HAWB|MAWB|HBL|MBL|CMR|CIM — 8 candidates stripped; promote to reference product]',
    `transport_mode` STRING COMMENT 'Mode of transportation used for this leg. Defines whether the segment is moved by air, ocean, road, rail, or a combination (intermodal).. Valid values are `air|ocean|road|rail|intermodal`',
    `vessel_name` STRING COMMENT 'Name of the ocean vessel or aircraft used for this leg. Applicable for air and ocean transport modes.',
    `voyage_flight_number` STRING COMMENT 'Voyage number (for ocean) or flight number (for air) for this leg. Identifies the specific sailing or flight carrying the freight.',
    CONSTRAINT pk_freight_leg PRIMARY KEY(`freight_leg_id`)
) COMMENT 'Represents an individual transport segment within a multi-leg or intermodal freight movement, including intermodal transfer details at interchange points. Each leg captures mode of transport, origin and destination nodes (port, airport, ICD, CFS, warehouse), carrier for that segment, ETD/ETA, actual departure/arrival timestamps, leg sequence number, transport document reference, leg status, and transfer metadata (transfer type, dwell time, handling charges) when transitioning between modes. Enables end-to-end intermodal tracking, transfer management, and dwell time SLA monitoring across air, ocean, road, and rail.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` (
    `intermodal_transfer_id` BIGINT COMMENT 'Unique identifier for the intermodal transfer event. Primary key.',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Intermodal transfers can involve air legs (e.g., air-to-road transfer at airport). Many transfers for one AWB. Nullable when transfer is for ocean or other modes.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Intermodal transfers can involve ocean legs (e.g., ocean-to-rail transfer at port). Many transfers for one BOL. Nullable when transfer is for air or other modes.',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: Intermodal transfers can involve consolidated cargo (e.g., consolidated container transferred from vessel to rail). Many transfers for one consolidation. Nullable when transfer is for individual shipm',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: Transfers move specific containers between transport modes. Core intermodal operation tracking. Replaces denormalized container_number string with proper FK to container_unit for referential integrity',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Intermodal transfer operations (rail-to-truck, port-to-rail) incur handling, equipment, and dwell costs that must be allocated to specific cost centers for operational cost control and transfer facili',
    `employee_id` BIGINT COMMENT 'Reference to the terminal operator or facility operator responsible for executing the intermodal transfer.',
    `freight_carrier_assignment_id` BIGINT COMMENT 'Foreign key linking to freight.carrier_assignment. Business justification: Intermodal transfers involve carrier handoffs (inbound carrier to outbound carrier). Many transfers can be associated with carrier assignments. Nullable when transfer is internal (within same carrier ',
    `freight_order_id` BIGINT COMMENT 'Reference to the parent freight order or booking that this intermodal transfer is part of, providing end-to-end shipment context.',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to network.hub_gateway. Business justification: Intermodal transfers occur at specific hub/gateway facilities (rail ramps, container terminals, air cargo hubs). Operations must track transfer location for dwell time SLA compliance, handling cost al',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Intermodal transfers occur at warehouse facilities (CFS, ICD, cross-dock terminals). Formalizing transfer_facility_id as FK (replacing denormalized transfer_location_code/name) enables facility-level ',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Intermodal transfers involve specific handling assets at transfer points. Required for transfer coordination, dwell time analysis, and asset utilization at intermodal facilities. Role-prefixed to dist',
    `cargo_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the cargo being transferred, measured in cubic meters.',
    `cargo_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the cargo being transferred between modes, measured in kilograms.',
    `container_type` STRING COMMENT 'Type and size classification of the container involved in the transfer, following ISO container type codes. [ENUM-REF-CANDIDATE: 20ft_dry|40ft_dry|40ft_hc|20ft_reefer|40ft_reefer|flat_rack|open_top|tank — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this intermodal transfer record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts associated with this transfer.. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether customs clearance is required at this transfer point. True = customs clearance required, False = no customs clearance.',
    `customs_clearance_status` STRING COMMENT 'Current status of customs clearance process at the transfer point, if applicable.. Valid values are `not_required|pending|cleared|held|released`',
    `delay_duration_hours` DECIMAL(18,2) COMMENT 'The total duration of delay in hours beyond the scheduled transfer time, if applicable.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for any delay in the transfer process. [ENUM-REF-CANDIDATE: weather|equipment|congestion|documentation|customs|labor|mechanical — 7 candidates stripped; promote to reference product]',
    `dwell_time_hours` DECIMAL(18,2) COMMENT 'The total time in hours that cargo remained at the interchange facility between inbound arrival and outbound departure, critical for SLA monitoring.',
    `exception_description` STRING COMMENT 'Detailed narrative description of the exception or delay encountered during the intermodal transfer, including root cause and impact.',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator of whether any exceptions or irregularities occurred during the transfer. True = exception occurred, False = normal transfer.',
    `exception_type` STRING COMMENT 'Classification of the exception or irregularity encountered during the transfer, if any.. Valid values are `delay|damage|missing_cargo|documentation_error|equipment_failure|weather`',
    `handling_equipment_type` STRING COMMENT 'Type of material handling equipment used to perform the physical transfer of cargo between transport modes.. Valid values are `reach_stacker|gantry_crane|mobile_crane|forklift|side_loader|straddle_carrier`',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator of whether the cargo contains hazardous materials requiring special handling during transfer. True = hazmat cargo, False = non-hazmat.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or observations related to the intermodal transfer.',
    `scheduled_transfer_timestamp` TIMESTAMP COMMENT 'The planned date and time for the intermodal transfer as per the original schedule or booking.',
    `seal_number` STRING COMMENT 'Security seal number applied to the container or cargo unit at the transfer point to ensure cargo integrity.',
    `seal_verification_status` STRING COMMENT 'Status of seal verification at the transfer point, indicating whether the inbound seal was intact and whether a new seal was applied.. Valid values are `intact|broken|replaced|not_applicable`',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the actual dwell time met the SLA target. True = compliant, False = SLA breach.',
    `sla_dwell_time_hours` DECIMAL(18,2) COMMENT 'The maximum allowable dwell time in hours as defined by the service level agreement or operational target for this transfer type.',
    `source_system` STRING COMMENT 'The operational system of record that originated this intermodal transfer event (SAP TM, Oracle TMS, FourKites visibility platform, or manual entry).. Valid values are `SAP_TM|ORACLE_TMS|FOURKITES|MANUAL`',
    `storage_charge` DECIMAL(18,2) COMMENT 'Additional charge for cargo storage at the interchange facility if dwell time exceeds free time allowances.',
    `supervisor_name` STRING COMMENT 'Name of the on-site supervisor or shift manager who oversaw the transfer operation.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Boolean indicator of whether the cargo requires temperature control during transfer. True = temperature-controlled cargo, False = ambient cargo.',
    `teu_count` DECIMAL(18,2) COMMENT 'The TEU equivalent of the cargo being transferred, used for capacity planning and billing. One 20ft container = 1 TEU, one 40ft container = 2 TEU.',
    `thc_amount` DECIMAL(18,2) COMMENT 'Terminal Handling Charge assessed at the interchange facility for container handling, loading, unloading, and related terminal services.',
    `total_transfer_cost` DECIMAL(18,2) COMMENT 'Total cost of the intermodal transfer including handling charges, THC, storage, and any other applicable fees.',
    `transfer_facility_type` STRING COMMENT 'Classification of the interchange facility type. ICD = Inland Container Depot, CFS = Container Freight Station.. Valid values are `icd|cfs|rail_terminal|port|airport|cross_dock`',
    `transfer_handling_charge` DECIMAL(18,2) COMMENT 'The monetary charge for the physical handling and transfer of cargo at the interchange facility, excluding other accessorial charges.',
    `transfer_number` STRING COMMENT 'Business-facing unique reference number for the intermodal transfer, used for tracking and documentation across systems and partners.. Valid values are `^IMT-[0-9]{10}$`',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the intermodal transfer operation, tracking progression from scheduled through completion or exception states.. Valid values are `scheduled|in_progress|completed|delayed|cancelled|exception`',
    `transfer_timestamp` TIMESTAMP COMMENT 'The actual date and time when the physical transfer of cargo between transport modes occurred at the interchange point.',
    `transfer_type` STRING COMMENT 'The mode-to-mode transfer type indicating the inbound and outbound transport modes involved in this intermodal transfer.. Valid values are `ocean_to_rail|ocean_to_road|air_to_road|rail_to_road|road_to_ocean|road_to_air`',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous material classification, if applicable.. Valid values are `^UN[0-9]{4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this intermodal transfer record was last modified.',
    CONSTRAINT pk_intermodal_transfer PRIMARY KEY(`intermodal_transfer_id`)
) COMMENT 'Captures the physical transfer of cargo between transport modes at interchange points such as ICDs, CFSs, rail terminals, and port facilities. Records transfer location, transfer type (ocean-to-rail, air-to-road, etc.), inbound and outbound leg references, transfer date/time, dwell time, handling charges, transfer status, and any exceptions or delays encountered during the transfer. Supports cross-modal visibility and dwell time SLA monitoring.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`freight_charge` (
    `freight_charge_id` BIGINT COMMENT 'Unique identifier for the freight charge line item. Primary key for this entity.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Accessorial charges (liftgate, residential delivery, inside delivery) must reference the accessorial charge master for standardized billing and revenue recognition. Accessorial_charge_id ensures consi',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Carrier/vendor freight charges must link to AP for cost accrual, payment processing, three-way matching (PO/receipt/invoice), and vendor reconciliation. Critical for cash management and vendor payment',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Customer-billable freight charges must link to AR for invoice-to-cash reconciliation, aging analysis, credit management, and revenue recognition. Essential for cash flow management and customer accoun',
    `agreement_id` BIGINT COMMENT 'Reference to the customer contract or rate agreement under which this charge is calculated. Null if the charge is based on spot rates or standard tariffs.',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Freight charges are itemized at the air waybill level (e.g., air freight charge, fuel surcharge, security surcharge). Many charges for one AWB. Nullable when charge is for ocean or other modes.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Freight charges are itemized at the bill of lading level (e.g., ocean freight, BAF, CAF, THC, documentation fee). Many charges for one BOL. Nullable when charge is for air or other modes.',
    `billing_invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Freight charges must map to invoice lines for charge-to-bill reconciliation. Critical for freight audit, revenue assurance, and dispute resolution. Enables operational charge validation against billed',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Freight charges can be estimated and recorded at booking stage (e.g., estimated freight charge in booking table). Many charges for one booking. Nullable when charge is for confirmed order rather than ',
    `carbon_offset_transaction_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_transaction. Business justification: Carbon offset charges appear as line items on freight invoices requiring direct linkage for billing reconciliation, revenue recognition, and customer invoice transparency on sustainability surcharges.',
    `carrier_payable_id` BIGINT COMMENT 'Foreign key linking to billing.carrier_payable. Business justification: Freight charges include carrier cost components requiring reconciliation against carrier payables. Charge-to-payable link enables cost-to-payable matching and supports freight margin analysis.',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: Freight charges can be consolidation-level (e.g., consolidation fee, deconsolidation fee, CFS handling charge). Many charges for one consolidation. Nullable when charge is for individual shipments.',
    `contract_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.contract_rate. Business justification: Contract-based freight charges must link to specific negotiated contract rates for customer billing validation and dispute resolution. Contract_rate_id enables verification that billed rates match con',
    `freight_carrier_assignment_id` BIGINT COMMENT 'Foreign key linking to freight.carrier_assignment. Business justification: Freight charges are tied to carrier assignments (e.g., carrier cost, fuel surcharge, accessorial charges specific to a carrier assignment). Many charges for one carrier assignment. Nullable when charg',
    `freight_leg_id` BIGINT COMMENT 'Foreign key linking to freight.freight_leg. Business justification: Freight charges are often leg-specific (e.g., per-leg freight charge, BAF, GRI, THC, handling charges at interchange points). Many charges for one leg. Nullable when charge is at order or shipment lev',
    `freight_order_id` BIGINT COMMENT 'Reference to the parent freight order to which this charge applies. Links this charge to the shipment booking.',
    `issuance_id` BIGINT COMMENT 'Foreign key linking to document.document_issuance. Business justification: Freight charges trigger invoice document issuance. Billing process requires linking charges to the issued invoice document for payment tracking, dispute resolution, and financial audit trail.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Direct link from operational freight charges to GL journal entries enables complete audit trail from revenue/cost recognition to financial statements. Critical for SOX compliance, external audits, and',
    `payment_allocation_id` BIGINT COMMENT 'Foreign key linking to billing.payment_allocation. Business justification: Payment allocations reconcile customer payments against specific freight charges. Charge-level payment matching enables granular AR reconciliation and supports partial payment allocation to multi-char',
    `charge_code_id` BIGINT COMMENT 'Foreign key linking to pricing.charge_code. Business justification: Every freight charge must map to a standardized charge code for GL posting, revenue recognition, tax treatment, and financial reporting. Pricing_charge_code_id is fundamental for accounting integratio',
    `surcharge_id` BIGINT COMMENT 'Foreign key linking to pricing.surcharge. Business justification: Individual surcharge line items (fuel, security, peak season) must reference the surcharge definition master for billing transparency and regulatory compliance. Pricing_surcharge_id links each charge ',
    `rate_card_id` BIGINT COMMENT 'Reference to the rate card or tariff schedule from which this charge rate was derived. Used for rate audit and pricing governance.',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Freight charges must reference published tariffs for regulatory compliance, audit trails, and rate justification. Tariff-based charges require tariff_id to document the governing tariff, support regul',
    `amount` DECIMAL(18,2) COMMENT 'The calculated monetary value of this charge component in the specified currency. Represents the total charge before any adjustments or taxes.',
    `approval_status` STRING COMMENT 'Indicates whether this charge requires approval and its current approval state. Used for charges that exceed thresholds or require manual review before billing.. Valid values are `not_required|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'The username or identifier of the user who approved this charge. Null if approval is not required or the charge has not yet been approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this charge was approved. Null if approval is not required or the charge has not yet been approved.',
    `basis` STRING COMMENT 'Unit of measurement or calculation method for the charge. Defines how the charge is computed, such as per Twenty-foot Equivalent Unit (TEU), per kilogram, per Cubic Meter (CBM), flat rate, or as a percentage of another value. [ENUM-REF-CANDIDATE: per_TEU|per_kg|per_CBM|per_shipment|per_container|per_pallet|per_package|per_ton|per_mile|per_kilometer|per_day|flat_rate|percentage — promote to reference product]',
    `carrier_code` STRING COMMENT 'The unique code identifying the carrier or service provider to whom this charge is payable or from whom the charge originates. Used for carrier settlement and cost allocation.',
    `charge_category` STRING COMMENT 'High-level grouping of the charge for financial reporting and analysis. Distinguishes between core freight charges, surcharges, accessorial services, regulatory fees, administrative fees, and penalty charges.. Valid values are `freight|surcharge|accessorial|regulatory|administrative|penalty`',
    `charge_code` STRING COMMENT 'Standardized code identifying the type of charge. Used for charge classification and billing automation.',
    `charge_description` STRING COMMENT 'Human-readable description of the charge component. Provides additional context beyond the charge type for billing transparency and customer communication.',
    `charge_status` STRING COMMENT 'The current lifecycle status of this charge. Tracks whether the charge is pending approval, approved for billing, already invoiced, paid, under dispute, waived, or cancelled. [ENUM-REF-CANDIDATE: pending|approved|invoiced|paid|disputed|waived|cancelled — 7 candidates stripped; promote to reference product]',
    `charge_type` STRING COMMENT 'Classification of the freight charge component. Identifies whether this is a base freight rate or a specific surcharge type such as Bunker Adjustment Factor (BAF), General Rate Increase (GRI), Terminal Handling Charge (THC), fuel surcharge, peak season surcharge, port congestion surcharge, documentation fee, or other mode-specific and service-specific charges. [ENUM-REF-CANDIDATE: base_freight|BAF|GRI|THC|fuel_surcharge|peak_season_surcharge|port_congestion_surcharge|documentation_fee|customs_clearance_fee|handling_charge|storage_charge|demurrage|detention|chassis_fee|inland_haulage|security_surcharge|war_risk_surcharge|currency_adjustment_factor|low_sulfur_surcharge|emergency_bunker_surcharge|container_service_charge — promote to reference product]',
    `cost_center_code` STRING COMMENT 'The cost center to which this charge is allocated for internal cost accounting and profitability analysis. Used for operational cost tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this charge record was first created in the system. Used for audit trail and charge lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount. Identifies the currency in which this charge is denominated.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'The code identifying the destination location (port, airport, terminal, or facility) for which this charge applies. Used for location-specific charges such as destination terminal handling or delivery surcharges.',
    `direction` STRING COMMENT 'Indicates whether this charge is billable to the customer (shipper or consignee) or payable to a carrier or vendor. Determines the financial flow and accounting treatment of the charge.. Valid values are `billable_to_shipper|payable_to_carrier|billable_to_consignee|payable_to_vendor|internal_cost`',
    `dispute_reason` STRING COMMENT 'The reason provided for disputing this charge. Null if the charge is not disputed. Used for dispute resolution and root cause analysis.',
    `effective_from_date` DATE COMMENT 'The start date from which this charge rate or surcharge is applicable. Used for time-based charge validity and rate management.',
    `effective_to_date` DATE COMMENT 'The end date until which this charge rate or surcharge is applicable. Null for open-ended charges. Used for time-based charge validity and rate management.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied if currency conversion was performed. Used to convert the charge from the original currency to the billing currency. Null if no conversion was required.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code to which this charge is posted for financial accounting. Used for revenue recognition or cost allocation depending on charge direction.',
    `invoice_number` STRING COMMENT 'The invoice document number to which this charge has been posted. Null if the charge has not yet been invoiced. Links the charge to the billing domain.',
    `is_billable` BOOLEAN COMMENT 'Boolean flag indicating whether this charge should be included in customer invoicing. True if the charge is billable to the customer, false if it is an internal cost or non-billable item.',
    `is_disputed` BOOLEAN COMMENT 'Boolean flag indicating whether this charge is currently under dispute by the customer or carrier. True if a dispute has been raised, false otherwise.',
    `is_taxable` BOOLEAN COMMENT 'Boolean flag indicating whether this charge is subject to tax (VAT, GST, sales tax). Used to determine if tax calculation should be applied during invoicing.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this charge. Used to capture special circumstances, manual adjustments, dispute details, or other contextual information.',
    `origin_location_code` STRING COMMENT 'The code identifying the origin location (port, airport, terminal, or facility) for which this charge applies. Used for location-specific charges such as terminal handling or origin surcharges.',
    `profit_center_code` STRING COMMENT 'The profit center to which this charge is allocated for segment reporting and profitability analysis. Used for business unit performance measurement.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity or volume to which the charge rate is applied. For example, number of TEUs, weight in kilograms, volume in CBM, or number of days. Used in conjunction with charge_basis and unit_rate to calculate the charge amount.',
    `service_type` STRING COMMENT 'The freight service level to which this charge applies. Identifies whether the charge is for Full Truckload (FTL), Less Than Truckload (LTL), Full Container Load (FCL), Less Than Container Load (LCL), express, standard, economy, or charter services. [ENUM-REF-CANDIDATE: FTL|LTL|FCL|LCL|express|standard|economy|charter — 8 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'The name or code of the operational system from which this charge originated. Examples include SAP TM, Oracle TMS, or manual entry. Used for data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The unique identifier of this charge in the source operational system. Used for cross-system reconciliation and data lineage tracking.',
    `tax_code` STRING COMMENT 'The tax classification code applicable to this charge. Used by the financial system to determine the correct tax rate and treatment. Null if the charge is not taxable.',
    `transport_mode` STRING COMMENT 'The mode of transportation to which this charge applies. Identifies whether the charge is specific to air freight, ocean freight, road transport, rail transport, intermodal movements, or courier services.. Valid values are `air|ocean|road|rail|intermodal|courier`',
    `unit_rate` DECIMAL(18,2) COMMENT 'The rate per unit for this charge. Combined with quantity to calculate the total charge amount. For percentage-based charges, this represents the percentage value.',
    `updated_by` STRING COMMENT 'The username or identifier of the user or system process that last modified this charge record. Used for audit trail and change accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this charge record was last modified. Used for audit trail and change tracking.',
    `created_by` STRING COMMENT 'The username or identifier of the user or system process that created this charge record. Used for audit trail and accountability.',
    CONSTRAINT pk_freight_charge PRIMARY KEY(`freight_charge_id`)
) COMMENT 'Itemized charge component associated with a freight order or shipment, capturing mode-specific surcharges and base freight costs. Stores charge type (BAF, GRI, THC, fuel surcharge, peak season surcharge, port congestion surcharge, documentation fee), charge basis (per TEU, per kg, per CBM, flat), currency, amount, applicable date range, and whether the charge is billable to shipper or payable to carrier. Integrates with SAP TM charge calculation and billing domain. Distinct from the billing domain invoice which aggregates charges.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` (
    `cfs_operation_id` BIGINT COMMENT 'Unique identifier for the CFS operation transaction. Primary key for the CFS operation record.',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: CFS operations can handle air cargo (less common but possible for air freight consolidations or ULD handling). Many CFS operations for one AWB. Nullable when CFS operation is for ocean or other modes.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: CFS operations primarily handle LCL ocean cargo (container stuffing/destuffing, tally, storage at CFS facilities). Many CFS operations for one BOL. Nullable when CFS operation is for air or other mode',
    `facility_id` BIGINT COMMENT 'Reference to the CFS facility where the operation is performed. Identifies the physical location handling the cargo.',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: CFS (Container Freight Station) operations handle LCL cargo for consolidations (stuffing, destuffing, tally, storage). Many CFS operations for one consolidation. Nullable when CFS operation is for ind',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: CFS operations stuff or strip specific containers. Core container freight station function for LCL consolidation. Replaces denormalized container_reference_number with proper FK to container_unit.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CFS operations (container freight station handling, deconsolidation) are performed by specific cost centers with direct labor, facility, and equipment costs. Required for operational cost allocation, ',
    `freight_order_id` BIGINT COMMENT 'Reference to the parent freight order associated with this CFS operation. Links the CFS activity to the broader shipment context.',
    `ftz_admission_id` BIGINT COMMENT 'Foreign key linking to customs.ftz_admission. Business justification: CFS (Container Freight Station) operations at FTZ facilities require admission records for duty deferral and zone inventory tracking. Links CFS handling to FTZ compliance.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the CFS operator who performed the cargo handling. Links operation to workforce management records.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to warehouse.storage_location. Business justification: CFS operations place cargo in specific warehouse storage locations during consolidation/deconsolidation. Tracking storage_location_id enables location-level cargo traceability, storage utilization ana',
    `cargo_condition_on_receipt` STRING COMMENT 'Physical condition assessment of cargo when received at the CFS facility. Documents any pre-existing damage or discrepancies for liability purposes.. Valid values are `good|damaged|wet|soiled|shortage|overage`',
    `cargo_receipt_timestamp` TIMESTAMP COMMENT 'Date and time when cargo was received at the CFS facility. Establishes custody transfer and storage period start for demurrage calculation.',
    `container_cutoff_timestamp` TIMESTAMP COMMENT 'Deadline by which the container must be stuffed and ready for pickup or vessel loading. Critical for export consolidation scheduling and carrier coordination.',
    `container_type` STRING COMMENT 'Physical type and size classification of the container used in this CFS operation. Determines handling requirements and capacity. [ENUM-REF-CANDIDATE: 20ft_standard|40ft_standard|40ft_high_cube|20ft_reefer|40ft_reefer|20ft_open_top|40ft_open_top|20ft_flat_rack|40ft_flat_rack — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this CFS operation record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `customs_inspection_required` BOOLEAN COMMENT 'Indicates whether the cargo is flagged for customs examination at the CFS facility. Affects operation timing and coordination with customs authorities.',
    `customs_inspection_timestamp` TIMESTAMP COMMENT 'Date and time when customs inspection was performed at the CFS facility. Records compliance with customs clearance requirements.',
    `customs_release_timestamp` TIMESTAMP COMMENT 'Date and time when cargo was released by customs authorities for further handling or delivery. Marks clearance for onward movement.',
    `demurrage_accrued_amount` DECIMAL(18,2) COMMENT 'Total demurrage charges accrued for cargo storage beyond the free period. Calculated based on storage duration and applicable daily rates.',
    `demurrage_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for demurrage charges. Specifies the currency in which storage fees are denominated.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies or exceptions noted during the CFS operation. Documents issues for claims, investigations, and corrective action.',
    `discrepancy_noted` BOOLEAN COMMENT 'Indicates whether any discrepancies were identified during the CFS operation (e.g., piece count mismatch, damage, missing items). Triggers exception handling workflow.',
    `equipment_used` STRING COMMENT 'Description of material handling equipment used during the CFS operation (e.g., forklift, pallet jack, crane). Supports equipment utilization tracking and maintenance scheduling.',
    `free_storage_days` STRING COMMENT 'Number of days of complimentary storage allowed before demurrage charges begin to accrue. Typically defined by carrier or CFS facility terms.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of cargo handled in this CFS operation including packaging, measured in kilograms. Used for load planning and charge calculation.',
    `handling_charge_amount` DECIMAL(18,2) COMMENT 'CFS handling fee charged for stuffing, destuffing, or other cargo handling services. Separate from demurrage and transportation charges.',
    `handling_charge_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for CFS handling charges. Specifies the currency in which handling fees are denominated.. Valid values are `^[A-Z]{3}$`',
    `is_hazardous_cargo` BOOLEAN COMMENT 'Indicates whether the cargo handled in this operation is classified as dangerous goods requiring special handling, labeling, and documentation per IMDG or IATA DGR.',
    `operation_end_timestamp` TIMESTAMP COMMENT 'Date and time when the CFS operation was completed. Records the actual completion of all cargo handling activities.',
    `operation_number` STRING COMMENT 'Business identifier for the CFS operation. Human-readable reference number used for tracking and communication.',
    `operation_start_timestamp` TIMESTAMP COMMENT 'Date and time when the CFS operation commenced. Records the actual start of physical cargo handling activities.',
    `operation_status` STRING COMMENT 'Current lifecycle status of the CFS operation. Tracks the operational workflow state from scheduling through completion.. Valid values are `scheduled|in_progress|completed|on_hold|cancelled`',
    `operation_type` STRING COMMENT 'Type of CFS operation being performed. Stuffing is loading cargo into containers for export; destuffing is unloading containers for import; cross-docking is direct transfer without storage; consolidation combines multiple LCL shipments; deconsolidation separates consolidated cargo; transloading transfers cargo between transport modes.. Valid values are `stuffing|destuffing|cross_docking|consolidation|deconsolidation|transloading`',
    `operator_name` STRING COMMENT 'Name of the individual or team responsible for executing the CFS operation. Used for accountability and quality tracking.',
    `photo_documentation_url` STRING COMMENT 'URL or file path to photographic evidence captured during the CFS operation. Used for damage claims, condition verification, and audit trails.',
    `seal_number` STRING COMMENT 'Security seal number applied to the container after stuffing. Ensures cargo integrity and tamper detection during transport. Required for customs and security compliance.',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling requirements or operational notes for the CFS operation (e.g., fragile, this side up, keep dry, stack limit).',
    `storage_end_date` DATE COMMENT 'Date when cargo storage period ends at the CFS facility. Marks the end of storage liability and demurrage accrual.',
    `storage_start_date` DATE COMMENT 'Date when cargo storage period begins at the CFS facility. Used to calculate storage duration and demurrage charges.',
    `tally_piece_count` STRING COMMENT 'Verified count of individual pieces or packages handled in this CFS operation. Used for reconciliation against shipping documents and cargo manifests.',
    `target_temperature_celsius` DECIMAL(18,2) COMMENT 'Required storage and transport temperature for temperature-sensitive cargo, measured in degrees Celsius. Applicable for reefer and pharmaceutical shipments.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the cargo requires temperature-controlled handling and storage (reefer cargo). Determines equipment and monitoring requirements.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials. Required for dangerous goods classification and regulatory compliance.. Valid values are `^UN[0-9]{4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this CFS operation record was last modified. Tracks the most recent change for audit and data quality purposes.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of cargo handled in this CFS operation measured in cubic meters (CBM). Critical for container space utilization and LCL consolidation planning.',
    CONSTRAINT pk_cfs_operation PRIMARY KEY(`cfs_operation_id`)
) COMMENT 'Operational transaction recording Container Freight Station (CFS) activities for LCL cargo handling. Captures CFS facility reference, operation type (stuffing, destuffing, cross-docking), cargo receipt timestamp, container cut-off deadline, assigned container reference, cargo condition on receipt, tally/piece count verification, storage period, demurrage accrual, and CFS operator details. Supports origin stuffing for export consolidations and destination stripping for import deconsolidation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique identifier for the freight milestone event record. Primary key.',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Freight milestones track key events in the shipment lifecycle. For air freight, milestones are associated with the air waybill (e.g., cargo acceptance, departure, arrival, delivery). Many milestones f',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Freight milestones track key events in the shipment lifecycle. For ocean freight, milestones are associated with the bill of lading (e.g., vessel departure, port arrival, customs clearance, delivery).',
    `booking_id` BIGINT COMMENT 'Reference to the booking record associated with this milestone, if applicable.',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: Freight milestones can track consolidation-level events such as cargo cutoff, consolidation complete, deconsolidation start, deconsolidation complete. Many milestones for one consolidation. Nullable w',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: Container-specific milestones (gated in, loaded, discharged) are standard in container tracking systems. Essential for container visibility and event-driven workflows. Replaces denormalized container_',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Freight milestones like Arrived at CFS, Departed warehouse, Customs cleared at facility occur at specific warehouse facilities. Tracking milestone_facility_id enables facility-level milestone pe',
    `freight_leg_id` BIGINT COMMENT 'Foreign key linking to freight.freight_leg. Business justification: Freight milestones track events at the leg level (departure from origin, arrival at destination, transfer at interchange point). Many milestones for one leg. Nullable when milestone is at order or shi',
    `freight_order_id` BIGINT COMMENT 'Reference to the parent freight order for which this milestone event occurred.',
    `issuance_id` BIGINT COMMENT 'Foreign key linking to document.document_issuance. Business justification: Milestones trigger document issuance (departure triggers MAWB issuance, arrival triggers delivery order issuance). Operational workflow automation - milestone events drive document generation and dist',
    `partner_id` BIGINT COMMENT 'Identifier of the specific organization or entity responsible for this milestone (e.g., carrier ID, warehouse ID, customs broker ID).',
    `actual_timestamp` TIMESTAMP COMMENT 'Actual date and time when the milestone event occurred, as confirmed by carrier, warehouse, customs, or tracking system.',
    `awb_number` STRING COMMENT 'Master or House Air Waybill number if this milestone is related to air freight.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'Master or House Bill of Lading number if this milestone is related to ocean or road freight.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the location where the milestone event occurred.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user or system process that created this milestone record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this milestone record was first created in the system.',
    `customs_clearance_number` STRING COMMENT 'Customs declaration or clearance reference number if this milestone is related to customs processing.',
    `data_source` STRING COMMENT 'System or channel through which the milestone event data was received (e.g., EDI message, FourKites real-time feed, manual entry, carrier API). [ENUM-REF-CANDIDATE: edi|api|fourkites|manual|carrier_portal|tms|wms|customs_system — 8 candidates stripped; promote to reference product]',
    `delay_duration_hours` DECIMAL(18,2) COMMENT 'Duration of delay in hours if this milestone was delayed compared to the planned or estimated timestamp.',
    `edi_message_type` STRING COMMENT 'EDI message type code if this milestone was received via EDI (e.g., IFTSTA, IFTMAN, DESADV for EDIFACT; 214, 315 for ANSI X12).',
    `estimated_timestamp` TIMESTAMP COMMENT 'Current estimated date and time for this milestone event, updated dynamically based on real-time tracking data from FourKites and carrier feeds. Represents predictive ETA.',
    `exception_code` STRING COMMENT 'Standardized code representing the type of exception if is_exception is true (e.g., DELAY_WEATHER, CUSTOMS_HOLD, MISSED_CUTOFF, DAMAGED_CARGO).',
    `exception_description` STRING COMMENT 'Detailed description of the exception or issue that occurred at this milestone.',
    `is_critical_milestone` BOOLEAN COMMENT 'Indicates whether this milestone is considered critical for SLA compliance and customer notifications (e.g., vessel departure, customs clearance, delivery).',
    `is_exception` BOOLEAN COMMENT 'Indicates whether this milestone represents an exception or deviation from the planned schedule (e.g., delay, missed connection, customs hold).',
    `location_code` STRING COMMENT 'Standardized code for the geographic location where the milestone event occurred (e.g., UN/LOCODE for ports, IATA for airports, internal facility codes for warehouses and CFS).. Valid values are `^[A-Z]{3,5}$`',
    `location_name` STRING COMMENT 'Human-readable name of the location where the milestone event occurred (e.g., Port of Los Angeles, Singapore Changi Airport, Memphis Distribution Center).',
    `location_type` STRING COMMENT 'Type of facility or location where the milestone event occurred. [ENUM-REF-CANDIDATE: port|airport|warehouse|cfs|icd|customs_facility|customer_site|carrier_terminal — 8 candidates stripped; promote to reference product]',
    `milestone_category` STRING COMMENT 'High-level category grouping for the milestone event to support analytics and reporting segmentation. [ENUM-REF-CANDIDATE: booking|origin|transit|customs|destination|delivery|exception — 7 candidates stripped; promote to reference product]',
    `milestone_code` STRING COMMENT 'Standardized code representing the milestone event type (e.g., BKG_CONF, CARGO_RCV, CUST_CLR, VSL_DEP, VSL_ARR, POD_RCV). Aligns with industry EDI standards and internal TMS milestone taxonomy.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `milestone_name` STRING COMMENT 'Human-readable name or description of the milestone event (e.g., Booking Confirmed, Cargo Received at Origin, Customs Cleared, Vessel Departed, Vessel Arrived, Proof of Delivery Received).',
    `milestone_status` STRING COMMENT 'Current status of the milestone event in its lifecycle.. Valid values are `pending|in_progress|completed|skipped|cancelled`',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether a customer notification (email, SMS, portal alert) was sent for this milestone event.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer notification was sent for this milestone event.',
    `planned_timestamp` TIMESTAMP COMMENT 'Originally scheduled or planned date and time for this milestone event to occur, based on initial routing and scheduling.',
    `pod_document_url` STRING COMMENT 'URL or storage path to the electronic proof of delivery document (ePOD) or scanned signature.',
    `pod_signature_name` STRING COMMENT 'Name of the person who signed for delivery, if applicable and captured.',
    `proof_of_delivery_received` BOOLEAN COMMENT 'Indicates whether proof of delivery documentation has been received for this milestone (applicable to delivery milestones).',
    `remarks` STRING COMMENT 'Free-text remarks or notes associated with this milestone event, provided by the responsible party or operations team.',
    `responsible_party_name` STRING COMMENT 'Name of the organization or entity responsible for executing or reporting this milestone event.',
    `responsible_party_type` STRING COMMENT 'Type of organization or entity responsible for executing or reporting this milestone event. [ENUM-REF-CANDIDATE: carrier|warehouse|customs_broker|freight_forwarder|customer|consignee|shipper|terminal_operator — 8 candidates stripped; promote to reference product]',
    `sequence` STRING COMMENT 'Sequential order of this milestone within the freight order lifecycle. Enables chronological sorting and progress tracking.',
    `source_system_code` STRING COMMENT 'Identifier of the external or internal system that originated this milestone event record (e.g., SAP TM order number, Oracle TMS shipment ID, FourKites tracking ID).',
    `temperature_recorded_celsius` DECIMAL(18,2) COMMENT 'Temperature reading recorded at this milestone for temperature-controlled shipments.',
    `transport_mode` STRING COMMENT 'Mode of transportation relevant to this milestone event.. Valid values are `air|ocean|road|rail|intermodal`',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user or system process that last updated this milestone record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this milestone record was last updated or modified.',
    `vessel_name` STRING COMMENT 'Name of the vessel, aircraft, truck, or rail car associated with this milestone event, if applicable.',
    `voyage_number` STRING COMMENT 'Voyage number (ocean), flight number (air), or trip identifier (road/rail) associated with this milestone event.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Event-based tracking record capturing key milestones in the freight order lifecycle such as booking confirmed, cargo received at origin, customs cleared, vessel departed, vessel arrived, cargo available for delivery, and POD received. Each milestone stores event code, event description, planned and actual timestamps, location, responsible party, data source (EDI, FourKites, manual), and exception flag. Integrates with FourKites real-time visibility platform for predictive ETA updates.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`freight_exception` (
    `freight_exception_id` BIGINT COMMENT 'Unique identifier for the freight exception record. Primary key.',
    `accrual_id` BIGINT COMMENT 'Foreign key linking to finance.accrual. Business justification: Freight exceptions (delays, damages, service failures) often trigger financial accruals for customer credits, carrier penalties, insurance claims, or contractual penalties. Required for accurate perio',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Freight exceptions capture disruptions and deviations. For air freight, exceptions can be specific to an air waybill (e.g., flight delay, cargo damage, customs hold). Many exceptions for one AWB. Null',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links exception to responsible employee for resolution. Core exception management workflow requires clear ownership assignment. Enables workload balancing, SLA tracking, and performance measurement. R',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Freight exceptions capture disruptions and deviations. For ocean freight, exceptions can be specific to a bill of lading (e.g., vessel delay, port congestion, container damage). Many exceptions for on',
    `billing_dispute_id` BIGINT COMMENT 'Foreign key linking to billing.dispute. Business justification: Freight exceptions (delays, damage, service failures) trigger billing disputes. Exception-to-dispute causality link enables operational root cause linkage to billing disputes and supports service reco',
    `booking_id` BIGINT COMMENT 'Reference to the booking associated with this exception, if applicable.',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the cargo claim record if a claim was filed due to this exception.',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: Freight exceptions can occur at consolidation level (e.g., consolidation delay, deconsolidation issue, cargo discrepancy during CFS operations). Many exceptions for one consolidation. Nullable when ex',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: Container-specific exceptions (damaged, delayed, lost) require container reference for exception management and claims processing. Standard container exception handling. Replaces denormalized containe',
    `credit_note_id` BIGINT COMMENT 'Foreign key linking to billing.credit_note. Business justification: Exceptions (delays, damage) result in credit notes as service recovery. Exception-to-credit causality link enables automated credit validation against operational failures and supports SLA-based credi',
    `document_exception_id` BIGINT COMMENT 'Foreign key linking to document.document_exception. Business justification: Freight exceptions trigger document exceptions when documentation is missing, incorrect, or expired. Exception management process requires linking operational exceptions to their root cause documentat',
    `freight_leg_id` BIGINT COMMENT 'Foreign key linking to freight.freight_leg. Business justification: Freight exceptions often occur at specific leg level (e.g., delay on a particular leg, missed connection, carrier no-show). Many exceptions for one leg. Nullable when exception is at order or shipment',
    `freight_order_id` BIGINT COMMENT 'Reference to the freight order impacted by this exception.',
    `hold_id` BIGINT COMMENT 'Foreign key linking to customs.customs_hold. Business justification: Customs holds are a primary cause of freight exceptions and delivery delays. Links exception to hold for root cause tracking, customer notification, and SLA impact analysis.',
    `acknowledged_by` STRING COMMENT 'Name or identifier of the person or system that acknowledged the exception.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was acknowledged by operations team or responsible party.',
    `awb_or_bol_number` STRING COMMENT 'Transport document number associated with the exception. AWB for air shipments, BOL for ocean/road shipments.',
    `carrier_code` STRING COMMENT 'Standard code of the carrier involved in the exception event. IATA code for air, SCAC for ocean/road.',
    `claim_filed_flag` BOOLEAN COMMENT 'Indicates whether a cargo claim was filed as a result of this exception. True if claim filed, false otherwise.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was formally closed after resolution verification and customer confirmation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this exception record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `customer_notification_channel` STRING COMMENT 'Communication channel used to notify customer of the exception. Includes email, SMS, customer portal, phone, and EDI.. Valid values are `email|sms|portal|phone|edi`',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when customer was notified of the exception via email, portal, or other communication channel.',
    `customer_notified_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified of the exception. True if notification sent, false otherwise.',
    `delay_duration_hours` DECIMAL(18,2) COMMENT 'Total delay caused by the exception, measured in hours. Calculated as difference between original ETA and revised ETA.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the shipment destination.. Valid values are `^[A-Z]{3}$`',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was first detected or reported. Primary business event timestamp for this transaction.',
    `detection_location` STRING COMMENT 'Geographic location or facility where the exception was detected. May be port, airport, warehouse, or in-transit location.',
    `detection_source` STRING COMMENT 'Origin or channel through which the exception was identified. Includes system automated alerts, carrier notifications, customer reports, warehouse scans, customs alerts, manual inspections, IoT sensors, and GPS tracking. [ENUM-REF-CANDIDATE: system_automated|carrier_notification|customer_report|warehouse_scan|customs_alert|manual_inspection|iot_sensor|gps_tracking — 8 candidates stripped; promote to reference product]',
    `escalated_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was escalated to higher management tier.',
    `escalation_level` STRING COMMENT 'Current escalation tier for exception resolution. None indicates standard handling; tier 1-3 indicate progressive management escalation; executive indicates C-level involvement.. Valid values are `none|tier_1|tier_2|tier_3|executive`',
    `exception_category` STRING COMMENT 'High-level grouping of exception types for reporting and analysis. Categories include operational, carrier, customs, documentation, cargo, infrastructure, and force majeure. [ENUM-REF-CANDIDATE: operational|carrier|customs|documentation|cargo|infrastructure|force_majeure — 7 candidates stripped; promote to reference product]',
    `exception_number` STRING COMMENT 'Business-facing unique identifier for the exception, used in customer communications and tracking.. Valid values are `^EXC-[0-9]{8,12}$`',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception. Tracks progression from detection through resolution.. Valid values are `open|acknowledged|in_progress|resolved|closed|escalated`',
    `exception_type` STRING COMMENT 'Classification of the exception event. Includes delay, damage, missing cargo, carrier rollover, port congestion, customs hold, documentation error, weather disruption, equipment failure, and security incident. [ENUM-REF-CANDIDATE: delay|damage|missing_cargo|carrier_rollover|port_congestion|customs_hold|documentation_error|weather_disruption|equipment_failure|security_incident — 10 candidates stripped; promote to reference product]',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the exception, including additional costs, penalties, or revenue loss. Expressed in transaction currency.',
    `freight_exception_description` STRING COMMENT 'Detailed narrative description of the exception event, including circumstances, impact, and any immediate actions taken.',
    `impacted_leg_sequence` STRING COMMENT 'Sequence number of the freight order leg affected by this exception. Null if exception impacts entire order.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, observations, or context related to the exception. Used for collaboration and knowledge capture.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the shipment origin where exception occurred or was detected.. Valid values are `^[A-Z]{3}$`',
    `preventable_flag` BOOLEAN COMMENT 'Indicates whether the exception was preventable through better processes, controls, or carrier selection. Used for continuous improvement analysis.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this exception is a repeat occurrence on the same freight order or lane. True if recurring issue, false if first occurrence.',
    `resolution_action` STRING COMMENT 'Description of corrective actions taken to resolve the exception. Includes rerouting, re-booking, documentation correction, or customer accommodation.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was fully resolved and normal operations resumed.',
    `revised_eta` TIMESTAMP COMMENT 'Updated estimated arrival time following the exception event. Communicated to customer as part of exception management.',
    `root_cause` STRING COMMENT 'Detailed explanation of the underlying cause of the exception. Captured during investigation and resolution process.',
    `root_cause_category` STRING COMMENT 'Standardized classification of root cause for trend analysis and continuous improvement initiatives. [ENUM-REF-CANDIDATE: carrier_performance|customs_compliance|documentation_quality|cargo_handling|infrastructure|weather|security|process_failure — 8 candidates stripped; promote to reference product]',
    `severity_level` STRING COMMENT 'Business impact severity of the exception. Critical indicates immediate customer escalation required; high indicates significant delay or cost impact; medium indicates moderate impact; low indicates minor deviation.. Valid values are `critical|high|medium|low`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this exception caused a breach of customer service level agreement commitments. True if SLA was breached, false otherwise.',
    `sla_target_delivery_date` DATE COMMENT 'Original committed delivery date per customer SLA. Used to calculate breach impact.',
    `transport_mode` STRING COMMENT 'Mode of transportation affected by the exception. Aligns with freight order transport mode.. Valid values are `air|ocean|road|rail|intermodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this exception record was last modified.',
    CONSTRAINT pk_freight_exception PRIMARY KEY(`freight_exception_id`)
) COMMENT 'Operational record capturing exceptions, disruptions, and deviations in freight order execution. Stores exception type (delay, damage, missing cargo, carrier rollover, port congestion, customs hold, documentation error), severity level, detection timestamp, detection source, impacted freight order and leg, root cause, resolution action, resolution timestamp, and SLA breach flag. Feeds into OTD and OTIF KPI tracking and customer exception notifications.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`quote` (
    `quote_id` BIGINT COMMENT 'Unique identifier for the freight quote record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Quotes reference customer agreements to apply contracted rates vs spot rates. Business process: contract rate application, volume commitment tracking, rate validity verification. Removes denormalized ',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or transportation provider for the quoted service.',
    `consignee_profile_id` BIGINT COMMENT 'Reference to the consignee profile for the destination party of the freight movement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks sales/pricing employee who generated quote. Essential for commission calculation, quote-to-booking conversion analysis, and pricing accountability. Standard business requirement in freight forw',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account requesting the freight quote.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: A freight quote, when accepted by the customer, becomes a freight order. This FK tracks the quote-to-order conversion. Nullable until quote is accepted and order is created. No reverse FK exists, no b',
    `lane_id` BIGINT COMMENT 'Reference to the freight lane (origin-destination pair) for which the quote is issued.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to customer.opportunity. Business justification: Freight quotes generated during sales cycles must link to opportunities for pipeline conversion tracking, win/loss analysis, and quote-to-order conversion metrics. Sales operations require this to mea',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Freight quotes are generated from published rate cards for standard lane pricing. Rate_card_id tracks which rate card was used for quote generation, enables rate card effectiveness analysis, supports ',
    `shipper_profile_id` BIGINT COMMENT 'Reference to the shipper profile for the origin party of the freight movement.',
    `spot_quote_id` BIGINT COMMENT 'Foreign key linking to pricing.spot_quote. Business justification: Freight quotes generated from spot quote requests for non-contract customers must link to the originating spot quote. Spot_quote_id connects the operational freight quote to the pricing quote request,',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Freight quotes must reference applicable published tariffs for regulatory compliance and customer transparency. Tariff_id documents the tariff basis for quoted rates, supports regulatory filings, and ',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Quotes for amendments or re-routing reference existing transport documents to provide accurate pricing. Sales process for existing shipment modifications requires linking quote to original transport d',
    `revised_quote_id` BIGINT COMMENT 'Self-referencing FK on quote (revised_quote_id)',
    `accessorial_charges_amount` DECIMAL(18,2) COMMENT 'Total amount for accessorial services such as liftgate, inside delivery, residential delivery, or special handling.',
    `base_freight_charge_amount` DECIMAL(18,2) COMMENT 'Base freight charge amount quoted for the transportation service, excluding surcharges and accessorial fees.',
    `carrier_service_code` STRING COMMENT 'Specific service code or product code from the carrier for the quoted service level.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Chargeable weight used for pricing calculation, which may be the greater of gross weight or dimensional (DIM) weight.',
    `commodity_description` STRING COMMENT 'General description of the cargo or commodity to be transported under this quote.',
    `container_type` STRING COMMENT 'Type and size of container quoted for ocean freight (e.g., 20GP, 40GP, 40HC, 45HC, reefer).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight quote record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the quoted amounts.. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code for the destination country of the freight movement.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Port, airport, facility, or city code representing the destination point of the freight movement (e.g., IATA airport code, UN/LOCODE port code).',
    `estimated_transit_time_days` STRING COMMENT 'Estimated number of days for the freight movement from origin to destination.',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Fuel surcharge or Bunker Adjustment Factor (BAF) amount included in the quote to account for fuel price fluctuations.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the cargo in kilograms, including packaging.',
    `hs_code` STRING COMMENT 'Harmonized System code for tariff classification of the commodity, used for customs and trade compliance.',
    `imdg_class` STRING COMMENT 'IMDG classification class for dangerous goods, if applicable.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the responsibilities, costs, and risks between buyer and seller for the quoted freight movement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_dangerous_goods` BOOLEAN COMMENT 'Boolean flag indicating whether the cargo contains dangerous goods or hazardous materials requiring special handling.',
    `issue_date` DATE COMMENT 'Date when the freight quote was formally issued to the customer.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the freight quote was issued, capturing the business event time.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code for the origin country of the freight movement.. Valid values are `^[A-Z]{3}$`',
    `origin_location_code` STRING COMMENT 'Port, airport, facility, or city code representing the origin point of the freight movement (e.g., IATA airport code, UN/LOCODE port code).',
    `package_count` STRING COMMENT 'Total number of packages, pieces, or handling units included in the quote.',
    `packaging_type` STRING COMMENT 'Type of packaging used for the cargo (e.g., pallets, crates, boxes, drums, bulk).',
    `quote_number` STRING COMMENT 'Externally-known unique business identifier for the freight quote, used for customer communication and reference.',
    `quote_status` STRING COMMENT 'Current lifecycle status of the freight quote indicating its state in the quotation workflow.. Valid values are `draft|issued|accepted|rejected|expired|withdrawn`',
    `quote_type` STRING COMMENT 'Classification of the quote based on the commercial context: spot rate, contract rate, tender response, or Request for Quotation (RFQ) response.. Valid values are `spot|contract|tender|rfq_response`',
    `service_type` STRING COMMENT 'Type of freight service quoted: Full Truckload (FTL), Less Than Truckload (LTL), Full Container Load (FCL), Less Than Container Load (LCL), express, standard, or economy service level. [ENUM-REF-CANDIDATE: ftl|ltl|fcl|lcl|express|standard|economy — 7 candidates stripped; promote to reference product]',
    `special_instructions` STRING COMMENT 'Any special handling instructions, service requirements, or customer-specific notes associated with the quote.',
    `temperature_controlled` BOOLEAN COMMENT 'Boolean flag indicating whether the cargo requires temperature-controlled (reefer) transportation.',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature requirement in Celsius for temperature-controlled cargo.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature requirement in Celsius for temperature-controlled cargo.',
    `teu_count` DECIMAL(18,2) COMMENT 'Number of Twenty-foot Equivalent Units (TEU) for container-based ocean freight quotes.',
    `total_quoted_amount` DECIMAL(18,2) COMMENT 'Total amount quoted to the customer, including base freight charge, fuel surcharge, accessorial charges, and any applicable fees.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for the quoted freight movement: air, ocean, road, rail, or intermodal combination.. Valid values are `air|ocean|road|rail|intermodal`',
    `un_number` STRING COMMENT 'United Nations number for dangerous goods classification, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight quote record was last modified.',
    `valid_from_date` DATE COMMENT 'Start date of the quote validity period, indicating when the quoted rates become effective.',
    `valid_until_date` DATE COMMENT 'End date of the quote validity period, after which the quoted rates are no longer binding.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the cargo in cubic meters.',
    CONSTRAINT pk_quote PRIMARY KEY(`quote_id`)
) COMMENT 'Formal freight quotation issued to a shipper or customer for a specific freight movement, capturing quoted rates, validity period, service terms, and mode options prior to booking confirmation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`document_attachment` (
    `document_attachment_id` BIGINT COMMENT 'Unique identifier for this freight order to trade document attachment record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Reference to the user who attached this trade document to this freight order. Used for audit trail and accountability.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to the freight order that requires this trade document',
    `reviewed_by_user_employee_id` BIGINT COMMENT 'Reference to the compliance or operations user who reviewed this document attachment for completeness and accuracy. Nullable if not yet reviewed.',
    `trade_document_id` BIGINT COMMENT 'Foreign key linking to the trade document attached to this freight order',
    `acceptance_status` STRING COMMENT 'Current status of this trade document attachment in the customs/regulatory acceptance workflow for this freight order. Drives clearance readiness and exception handling.',
    `attached_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade document was first attached to this freight order in the system. Used for process timeline tracking and SLA monitoring.',
    `customs_reference` STRING COMMENT 'Reference number assigned by customs authority to this specific document submission for this freight order. Used for tracking clearance status and correspondence with customs.',
    `document_type` STRING COMMENT 'Classification of the trade document type attached to this freight order. Determines regulatory requirements and validation rules for this specific attachment.',
    `rejection_reason` STRING COMMENT 'Explanation provided by customs or regulatory authority for rejection of this trade document for this freight order. Nullable when acceptance_status is not REJECTED. Used for corrective action and resubmission.',
    `required_flag` BOOLEAN COMMENT 'Indicates whether this trade document is mandatory for customs clearance of this freight order based on origin/destination countries, commodity type, and incoterms. Drives compliance validation.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when this document attachment was reviewed for this freight order. Nullable if not yet reviewed. Used for compliance workflow tracking.',
    `submission_date` DATE COMMENT 'Business date when this specific trade document was submitted to customs or regulatory authority for this freight order. Used for compliance tracking and clearance timeline monitoring.',
    `version_number` STRING COMMENT 'Sequential version number tracking revisions of this document attachment relationship. Increments when a document is resubmitted or replaced for this freight order. Enables audit trail of document corrections.',
    CONSTRAINT pk_document_attachment PRIMARY KEY(`document_attachment_id`)
) COMMENT 'This association product represents the attachment relationship between freight orders and trade documents in international logistics operations. It captures the specific documents required for each freight order, tracking submission status, acceptance by customs/authorities, version control, and rejection handling. Each record links one freight order to one trade document with attributes that exist only in the context of this specific attachment relationship, enabling full traceability of document compliance per shipment.. Existence Justification: In international freight forwarding operations, a single freight order requires multiple trade documents (commercial invoice, packing list, certificate of origin, phytosanitary certificates, etc.) to satisfy customs and regulatory requirements across origin and destination countries. Conversely, in consolidation scenarios, a single trade document (such as a consolidated commercial invoice or master packing list) can cover multiple freight orders being shipped together. The business actively manages the attachment relationship, tracking submission dates, acceptance status by customs authorities, rejection reasons, and version control for each document-order pairing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` (
    `shipment_agent_service_id` BIGINT COMMENT 'Unique identifier for this shipment-agent service assignment record',
    `agent_id` BIGINT COMMENT 'Foreign key linking to the agent providing services for this freight order',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to the freight order being serviced by the agent',
    `assignment_status` STRING COMMENT 'The current status of this agent service assignment. Assigned indicates the agent has been nominated but not yet engaged, active indicates services are in progress, completed indicates services have been rendered, and cancelled indicates the assignment was revoked',
    `assignment_timestamp` TIMESTAMP COMMENT 'The timestamp when this agent was assigned to service this freight order in the operational system',
    `commission_rate` DECIMAL(18,2) COMMENT 'The commission percentage or rate applicable to this specific agent-shipment engagement, which may differ from the agents standard rate based on shipment characteristics, lane, or negotiated terms',
    `effective_date` DATE COMMENT 'The date on which this agent service assignment became effective for the shipment, typically aligned with booking confirmation or agent nomination',
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the handling_fee amount (e.g., USD, EUR, GBP)',
    `handling_fee` DECIMAL(18,2) COMMENT 'The handling fee amount charged by the agent for services rendered on this specific shipment, covering activities such as documentation, customs processing, or local delivery coordination',
    `service_scope` STRING COMMENT 'The specific scope of services the agent is responsible for on this shipment. Values include origin_handling (pickup and export documentation), destination_delivery (import clearance and final delivery), customs_clearance (customs brokerage only), transit_coordination (intermediate handling), full_service (end-to-end), or documentation_only (paperwork without physical handling)',
    `territory` STRING COMMENT 'The geographic territory or location where this agent is responsible for servicing this shipment, typically expressed as a country code, city, port code, or region identifier',
    CONSTRAINT pk_shipment_agent_service PRIMARY KEY(`shipment_agent_service_id`)
) COMMENT 'This association product represents the service engagement between a freight order and an agent in the Transport Shipping partner network. It captures the operational assignment of agents to specific shipments for services such as origin handling, destination delivery, customs clearance, or transit coordination. Each record links one freight_order to one agent with attributes that define the scope, compensation, and territorial responsibility for that specific engagement.. Existence Justification: In international freight forwarding operations, a single shipment routinely requires multiple agents across different territories and service functions—an origin agent for pickup and export documentation, a destination agent for import clearance and final delivery, and potentially transit agents for customs or intermediate handling. Conversely, each agent in the network handles hundreds or thousands of shipments. The business actively manages these agent assignments with specific service scopes, territorial responsibilities, commission rates, and handling fees that vary by shipment characteristics and lane requirements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` (
    `carbon_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for the freight carbon offset allocation record. Primary key.',
    `carbon_offset_program_id` BIGINT COMMENT 'Foreign key linking to the carbon offset program from which credits are allocated',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that created this allocation record. Used for audit and accountability purposes.',
    `freight_order_id` BIGINT COMMENT 'Foreign key to freight.freight_order.freight_order_id',
    `order_freight_order_id` BIGINT COMMENT 'Foreign key linking to the freight order receiving carbon offset allocation',
    `allocation_date` DATE COMMENT 'The business date on which the carbon offset credits were allocated from the program inventory to this freight order. Used for vintage tracking and accounting period assignment.',
    `allocation_method` STRING COMMENT 'The method by which the carbon offset program was selected and allocated to this freight order. AUTOMATIC indicates system-driven allocation based on availability and cost optimization; MANUAL indicates sustainability team override; CUSTOMER_SELECTED indicates customer-specified program preference; POLICY_BASED indicates allocation driven by corporate sustainability policy rules.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the carbon offset allocation. RESERVED indicates credits are allocated but not yet retired; RETIRED indicates credits have been permanently retired to the freight order; CANCELLED indicates allocation was reversed; PENDING indicates allocation is awaiting approval or payment.',
    `allocation_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation record was created in the system, capturing the precise moment the credits were reserved or retired for this freight order.',
    `customer_opt_in_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer explicitly opted in to carbon offset allocation for this freight order. True indicates customer-initiated carbon neutrality request; false indicates corporate default allocation policy applied.',
    `program_tier` STRING COMMENT 'The service tier classification of the carbon offset program selected for this allocation. STANDARD represents basic certified offsets; PREMIUM represents higher-quality offsets with co-benefits; GOLD represents top-tier offsets with verified additionality and permanence. Tier selection may be driven by customer preference or corporate policy.',
    `quantity_tco2e_allocated` DECIMAL(18,2) COMMENT 'The quantity of carbon offset credits in metric tonnes CO2e allocated from this program to this freight order. This value represents the portion of the freight orders carbon footprint neutralized by this specific program allocation.',
    `retirement_certificate_number` STRING COMMENT 'The unique certificate or serial number issued by the carbon offset registry when credits are permanently retired for this freight order. Provides audit trail and proof of carbon neutrality claim.',
    `total_allocation_cost` DECIMAL(18,2) COMMENT 'The total cost of this carbon offset allocation, calculated as quantity_tco2e_allocated multiplied by unit_cost_per_tonne. Used for cost accounting and customer billing when carbon offsets are a billable service.',
    `unit_cost_per_tonne` DECIMAL(18,2) COMMENT 'The actual cost per metric tonne CO2e paid for this specific allocation, captured at the time of allocation. May differ from the programs listed price due to volume discounts, contract terms, or market fluctuations.',
    CONSTRAINT pk_carbon_allocation PRIMARY KEY(`carbon_allocation_id`)
) COMMENT 'This association product represents the allocation event between freight_order and carbon_offset_program. It captures the operational process of allocating carbon offset credits from specific programs to individual freight orders to neutralize their carbon footprint. Each record links one freight_order to one carbon_offset_program with attributes that exist only in the context of this allocation transaction, including the quantity of CO2e credits allocated, allocation timestamp, allocation method, customer opt-in status, and program tier selection.. Existence Justification: In Transport Shippings sustainability operations, a single freight order can have its carbon footprint offset by drawing credits from multiple carbon offset programs (e.g., splitting between a reforestation program and a renewable energy program to meet total offset requirements or customer preferences). Conversely, a single carbon offset programs inventory serves as a credit pool allocated across many freight orders over time. The allocation process is an operational business activity managed by the sustainability team, with each allocation carrying specific transactional data including quantity allocated, allocation date, method, customer opt-in status, program tier, cost, and retirement certificate details.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`freight`.`cargo` (
    `cargo_id` BIGINT COMMENT 'Primary key for cargo',
    `consolidated_cargo_id` BIGINT COMMENT 'Self-referencing FK on cargo (consolidated_cargo_id)',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The greater of actual gross weight or volumetric weight, used as the billing basis for freight rate calculations.',
    `commodity_code` STRING COMMENT 'Harmonized System (HS) code classifying the cargo for customs tariff and trade statistics purposes.',
    `commodity_description` STRING COMMENT 'Standardized commodity description corresponding to the HS code, used for customs and trade compliance documentation.',
    `container_type` STRING COMMENT 'ISO container type code indicating the standard container size and specification suitable for this cargo (e.g., 20GP for 20-foot general purpose).',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the cargo was manufactured or produced, required for customs and trade compliance.',
    `customs_tariff_code` STRING COMMENT 'National or regional customs tariff classification code extending the HS code for duty rate determination and trade preference eligibility.',
    `declared_value` DECIMAL(18,2) COMMENT 'Monetary value of the cargo as declared by the shipper for customs and insurance purposes.',
    `declared_value_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the declared cargo value (e.g., USD, EUR, GBP).',
    `cargo_description` STRING COMMENT 'Human-readable description of the cargo contents, used on shipping documents and customs declarations.',
    `effective_from_date` DATE COMMENT 'Date from which this cargo master record becomes valid and available for use in booking and operational processes.',
    `effective_to_date` DATE COMMENT 'Date after which this cargo master record is no longer valid for new bookings. Null indicates an open-ended validity period.',
    `export_license_required_flag` BOOLEAN COMMENT 'Indicates whether an export license or permit is required for this cargo based on its classification and destination restrictions.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the cargo including packaging, measured in kilograms. Used for load planning, carrier rate calculation, and regulatory compliance.',
    `hazmat_class` STRING COMMENT 'UN hazardous materials classification (e.g., Class 1-9) indicating the nature of danger. Null for non-hazardous cargo. [ENUM-REF-CANDIDATE: 1.1|1.2|1.3|2.1|2.2|3|4.1|4.2|5.1|6.1|7|8|9 — promote to reference product]',
    `hazmat_packing_group` STRING COMMENT 'Packing group (I, II, or III) indicating the degree of danger for hazardous cargo, determining packaging and handling requirements.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the cargo piece in centimeters, used for stacking constraints and equipment clearance verification.',
    `incoterm` STRING COMMENT 'Default Incoterms rule applicable to this cargo defining the division of costs and risks between buyer and seller. [ENUM-REF-CANDIDATE: EXW|FCA|FAS|FOB|CFR|CIF|CPT|CIP|DAP|DPU|DDP — promote to reference product]',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether cargo insurance coverage is mandatory for this cargo based on value, type, or contractual requirements.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the cargo piece in centimeters, used for dimensional weight calculation and equipment compatibility checks.',
    `load_type` STRING COMMENT 'Freight load classification: Full Container Load (FCL), Less than Container Load (LCL), Full Truck Load (FTL), or Less than Truck Load (LTL).',
    `marks_and_numbers` STRING COMMENT 'Shipping marks, labels, and identification numbers physically applied to the cargo packages for identification during handling and delivery.',
    `max_temperature_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for temperature-sensitive cargo during transport and storage, measured in degrees Celsius.',
    `min_temperature_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for temperature-sensitive cargo during transport and storage, measured in degrees Celsius.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the cargo contents excluding packaging, measured in kilograms. Required for customs declarations and commodity valuation.',
    `packaging_type` STRING COMMENT 'Type of outer packaging used for the cargo, determining handling equipment requirements and stowage compatibility.',
    `piece_count` STRING COMMENT 'Total number of individual pieces or packages comprising this cargo consignment.',
    `reference_number` STRING COMMENT 'Externally-known business reference number used to identify the cargo across systems and documentation such as bills of lading and shipping instructions.',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements such as fragile, keep upright, do not freeze, or live animals.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether the cargo can be stacked upon during storage and transport, affecting load plan optimization and warehouse utilization.',
    `cargo_status` STRING COMMENT 'Current lifecycle status of the cargo master record indicating whether it is available for booking and operational use.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the cargo requires temperature-controlled transport and storage (reefer equipment).',
    `teu_count` DECIMAL(18,2) COMMENT 'Number of TEUs (Twenty-foot Equivalent Units) this cargo occupies, used for ocean freight capacity planning and terminal operations.',
    `transport_mode` STRING COMMENT 'Primary mode of transport for which this cargo is configured, determining applicable regulations and handling procedures.',
    `cargo_type` STRING COMMENT 'Primary classification of the cargo indicating its handling category and regulatory requirements.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous substance or article, prefixed with UN. Required for dangerous goods documentation and placarding.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the cargo measured in cubic meters. Used for volumetric weight calculations, container utilization, and load planning.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the cargo piece in centimeters, used for dimensional weight calculation and stowage planning.',
    CONSTRAINT pk_cargo PRIMARY KEY(`cargo_id`)
) COMMENT 'Master reference table for cargo. Referenced by cargo_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ADD CONSTRAINT `fk_freight_booking_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `transport_shipping_ecm`.`freight`.`quote`(`quote_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ADD CONSTRAINT `fk_freight_air_waybill_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ADD CONSTRAINT `fk_freight_bill_of_lading_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ADD CONSTRAINT `fk_freight_load_plan_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ADD CONSTRAINT `fk_freight_freight_carrier_assignment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_freight_carrier_assignment_id` FOREIGN KEY (`freight_carrier_assignment_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_carrier_assignment`(`freight_carrier_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ADD CONSTRAINT `fk_freight_freight_leg_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_freight_carrier_assignment_id` FOREIGN KEY (`freight_carrier_assignment_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_carrier_assignment`(`freight_carrier_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ADD CONSTRAINT `fk_freight_intermodal_transfer_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_freight_carrier_assignment_id` FOREIGN KEY (`freight_carrier_assignment_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_carrier_assignment`(`freight_carrier_assignment_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_freight_leg_id` FOREIGN KEY (`freight_leg_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_leg`(`freight_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ADD CONSTRAINT `fk_freight_freight_charge_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ADD CONSTRAINT `fk_freight_cfs_operation_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ADD CONSTRAINT `fk_freight_cfs_operation_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ADD CONSTRAINT `fk_freight_cfs_operation_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ADD CONSTRAINT `fk_freight_cfs_operation_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_freight_leg_id` FOREIGN KEY (`freight_leg_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_leg`(`freight_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ADD CONSTRAINT `fk_freight_milestone_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_air_waybill_id` FOREIGN KEY (`air_waybill_id`) REFERENCES `transport_shipping_ecm`.`freight`.`air_waybill`(`air_waybill_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `transport_shipping_ecm`.`freight`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `transport_shipping_ecm`.`freight`.`booking`(`booking_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_consolidation_id` FOREIGN KEY (`consolidation_id`) REFERENCES `transport_shipping_ecm`.`freight`.`consolidation`(`consolidation_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_freight_leg_id` FOREIGN KEY (`freight_leg_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_leg`(`freight_leg_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ADD CONSTRAINT `fk_freight_freight_exception_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ADD CONSTRAINT `fk_freight_quote_revised_quote_id` FOREIGN KEY (`revised_quote_id`) REFERENCES `transport_shipping_ecm`.`freight`.`quote`(`quote_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ADD CONSTRAINT `fk_freight_document_attachment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ADD CONSTRAINT `fk_freight_shipment_agent_service_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ADD CONSTRAINT `fk_freight_carbon_allocation_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ADD CONSTRAINT `fk_freight_carbon_allocation_order_freight_order_id` FOREIGN KEY (`order_freight_order_id`) REFERENCES `transport_shipping_ecm`.`freight`.`freight_order`(`freight_order_id`);
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` ADD CONSTRAINT `fk_freight_cargo_consolidated_cargo_id` FOREIGN KEY (`consolidated_cargo_id`) REFERENCES `transport_shipping_ecm`.`freight`.`cargo`(`cargo_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`freight` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `transport_shipping_ecm`.`freight` SET TAGS ('dbx_domain' = 'freight');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `consignee_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Profile ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Profile ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `sla_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Entitlement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight (kg)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `co2e_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions (kg)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `destination_port_or_facility` SET TAGS ('dbx_business_glossary_term' = 'Destination Port or Facility Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `dim_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (DIM Weight) kg');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `eta` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `etd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Departure (ETD)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms) Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `is_nvocc` SET TAGS ('dbx_business_glossary_term' = 'Non-Vessel Operating Common Carrier (NVOCC) Indicator');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^FO-[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|booked|in_transit|customs_hold|delivered|cancelled');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `origin_port_or_facility` SET TAGS ('dbx_business_glossary_term' = 'Origin Port or Facility Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'pallet|carton|crate|drum|bag|loose');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `pod_received` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Received Indicator');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'same_day|next_day|two_day|standard|deferred|economy');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Service Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_TM|ORACLE_TMS');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|controlled');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `teu_count` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `total_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Order Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `total_order_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `total_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Surcharge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `total_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_order` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `ams_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Ams Filing Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Network Node ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `consignee_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Profile ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `customer_carbon_report_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Carbon Report Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `destination_node_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Network Node ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `isf_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Isf Filing Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Quote Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Document Request Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Profile ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date and Time');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'draft|pending|confirmed|rejected|cancelled|executed');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `cargo_description` SET TAGS ('dbx_business_glossary_term' = 'Cargo Description');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `carrier_booking_ref` SET TAGS ('dbx_business_glossary_term' = 'Carrier Booking Reference');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'EDI|API|web_portal|manual|email|phone');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `estimated_freight_charge` SET TAGS ('dbx_business_glossary_term' = 'Estimated Freight Charge');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `estimated_freight_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `eta` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `etd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Departure (ETD)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `hawb_number` SET TAGS ('dbx_business_glossary_term' = 'House Air Waybill (HAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `hbl_number` SET TAGS ('dbx_business_glossary_term' = 'House Bill of Lading (HBL) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `mawb_number` SET TAGS ('dbx_business_glossary_term' = 'Master Air Waybill (MAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `mawb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `mbl_number` SET TAGS ('dbx_business_glossary_term' = 'Master Bill of Lading (MBL) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `nvocc_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Non-Vessel Operating Common Carrier (NVOCC) Arrangement Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `piece_count` SET TAGS ('dbx_business_glossary_term' = 'Piece Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Booking Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `requested_pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Pickup Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Service Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `space_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Space Confirmation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `space_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Space Reservation Confirmed Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `temp_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `temp_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `teu_count` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`booking` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` SET TAGS ('dbx_subdomain' = 'transport_documentation');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `ams_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Ams Filing Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `freight_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `green_shipment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Green Shipment Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Account ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `awb_status` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `awb_type` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `awb_type` SET TAGS ('dbx_value_regex' = 'MAWB|HAWB|DIRECT');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight (kg)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `charges_collect_or_prepaid` SET TAGS ('dbx_business_glossary_term' = 'Charges Collect or Prepaid Indicator');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `charges_collect_or_prepaid` SET TAGS ('dbx_value_regex' = 'PREPAID|COLLECT');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code (ISO 4217)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `declared_value_for_carriage` SET TAGS ('dbx_business_glossary_term' = 'Declared Value for Carriage');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `declared_value_for_carriage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `declared_value_for_customs` SET TAGS ('dbx_business_glossary_term' = 'Declared Value for Customs');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `declared_value_for_customs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `eta` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `etd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Departure (ETD)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `first_transit_airport_code` SET TAGS ('dbx_business_glossary_term' = 'First Transit Airport Code (IATA)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `first_transit_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `hawb_number` SET TAGS ('dbx_business_glossary_term' = 'House Air Waybill (HAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `iata_airline_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Airline Numeric Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `iata_airline_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DGR) Indicator');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `isf_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Importer Security Filing (ISF) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'AWB Issue Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'AWB Issue Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `mawb_number` SET TAGS ('dbx_business_glossary_term' = 'Master Air Waybill (MAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `mawb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code (IATA)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code (ISO 3166-1 alpha-3)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `other_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `other_charges_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `pieces_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Pieces');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `pod_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signatory Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `pod_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `pod_signatory_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `pod_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'IATA Rate Class Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `rate_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate per Kilogram');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `rate_per_kg` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `second_transit_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Second Transit Airport Code (IATA)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `second_transit_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Air Freight Service Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'EXPRESS|STANDARD|DEFERRED|CHARTER|COURIER');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `special_handling_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Codes (IATA SHC)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'UN Number (Dangerous Goods)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`air_waybill` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (CBM - Cubic Meter)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` SET TAGS ('dbx_subdomain' = 'transport_documentation');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `carbon_offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Transaction Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Vessel Operating Common Carrier (NVOCC) ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `freight_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `green_shipment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Green Shipment Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `isf_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Isf Filing Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Notify Party ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `actual_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `ams_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Manifest System (AMS) Filing Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `bol_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `bol_status` SET TAGS ('dbx_value_regex' = 'draft|issued|released|surrendered|amended|cancelled');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `bol_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `bol_type` SET TAGS ('dbx_value_regex' = 'master|house|seaway|straight|order|surrender');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `carrier_scac` SET TAGS ('dbx_business_glossary_term' = 'Carrier Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `carrier_scac` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `eta` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `etd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Departure (ETD)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `freight_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `freight_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Surcharge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `freight_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `hbl_number` SET TAGS ('dbx_business_glossary_term' = 'House Bill of Lading (HBL) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `imdg_class` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Dangerous Goods (IMDG) Class');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `imo_number` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Organization (IMO) Vessel Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms) Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `is_negotiable` SET TAGS ('dbx_business_glossary_term' = 'Negotiable Bill of Lading Indicator');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Issue Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `mbl_number` SET TAGS ('dbx_business_glossary_term' = 'Master Bill of Lading (MBL) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `original_bol_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Original Bills of Lading');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `place_of_delivery` SET TAGS ('dbx_business_glossary_term' = 'Place of Delivery');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `place_of_issue` SET TAGS ('dbx_business_glossary_term' = 'Place of Issue');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `place_of_receipt` SET TAGS ('dbx_business_glossary_term' = 'Place of Receipt');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `port_of_discharge` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge (POD)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `port_of_discharge` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading (POL)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Ocean Freight Service Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'FCL|LCL|RORO|BULK|BREAKBULK');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `shipper_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipper Reference Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `teu_count` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `total_freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `total_freight_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Dangerous Goods Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Cubic Meter (CBM)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`bill_of_lading` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` SET TAGS ('dbx_subdomain' = 'cargo_operations');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Identifier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `consolidation_nvocc_operator_carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Vessel Operating Common Carrier (NVOCC) Operator Identifier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Container Freight Station (CFS) Facility Identifier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `origin_cfs_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Container Freight Station (CFS) Facility Identifier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Hub Gateway Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Loader Identifier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `saf_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Saf Procurement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `trade_document_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `actual_arrival_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date and Time');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `actual_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Date and Time (ETD)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `cargo_cutoff_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cargo Cut-off Date and Time');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `carrier_booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Carrier Booking Reference Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `carrier_booking_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `consolidation_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `consolidation_type` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `consolidation_type` SET TAGS ('dbx_value_regex' = 'ocean_lcl|air_groupage|road_groupage|rail_groupage');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `container_size_type` SET TAGS ('dbx_business_glossary_term' = 'Container Size and Type Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `container_size_type` SET TAGS ('dbx_value_regex' = '20GP|40GP|40HC|45HC');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `contains_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Contains Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `contains_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Contains Temperature-Controlled Cargo Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `deconsolidation_complete_datetime` SET TAGS ('dbx_business_glossary_term' = 'Deconsolidation Complete Date and Time');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `deconsolidation_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Deconsolidation Start Date and Time');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `estimated_arrival_datetime` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `freight_charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `freight_charge_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Operational Notes');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Reference Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `scheduled_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Date and Time');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'economy|standard|express|premium');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `total_chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Chargeable Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `total_freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `total_piece_count` SET TAGS ('dbx_business_glossary_term' = 'Total Piece Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `total_shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `uld_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Load Device (ULD) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `uld_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{5}[A-Z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`consolidation` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` SET TAGS ('dbx_subdomain' = 'cargo_operations');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `load_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `freight_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Manifest Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Load Planner Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Staging Location Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `tertiary_load_planner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Unit Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `actual_load_completion_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Load Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `actual_load_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Load Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `cargo_placement_instructions` SET TAGS ('dbx_business_glossary_term' = 'Cargo Placement Instructions');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `center_of_gravity_x` SET TAGS ('dbx_business_glossary_term' = 'Center of Gravity X-Coordinate');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `center_of_gravity_y` SET TAGS ('dbx_business_glossary_term' = 'Center of Gravity Y-Coordinate');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `center_of_gravity_z` SET TAGS ('dbx_business_glossary_term' = 'Center of Gravity Z-Coordinate');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `contains_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Contains Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `contains_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Contains Temperature-Controlled Cargo Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `hazmat_segregation_verified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Segregation Verified Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `load_optimization_method` SET TAGS ('dbx_business_glossary_term' = 'Load Optimization Method');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `load_optimization_method` SET TAGS ('dbx_value_regex' = 'manual|automated|hybrid');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `load_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `load_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Load Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `loading_dock_bay` SET TAGS ('dbx_business_glossary_term' = 'Loading Dock or Bay Identifier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `loading_location_code` SET TAGS ('dbx_business_glossary_term' = 'Loading Location Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `loading_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,5}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `max_volume_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Capacity in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `max_weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Capacity in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Notes');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `planned_load_completion_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Load Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `planned_load_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Load Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `planned_load_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Load Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Reference Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `reference` SET TAGS ('dbx_value_regex' = '^LP-[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Range in Celsius');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Range in Celsius');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `total_actual_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `total_actual_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `total_planned_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `total_planned_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|intermodal');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `transport_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Transport Unit Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `transport_unit_type` SET TAGS ('dbx_value_regex' = 'vessel|aircraft|truck|railcar|container|trailer');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Load Plan Version Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `volume_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Volume Utilization Percentage');
ALTER TABLE `transport_shipping_ecm`.`freight`.`load_plan` ALTER COLUMN `weight_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Weight Utilization Percentage');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` SET TAGS ('dbx_subdomain' = 'carrier_services');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `freight_carrier_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Assignment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Buy Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `supplier_emissions_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Emissions Disclosure Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|rejected|cancelled|expired');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Carrier Booking Reference Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_instructions` SET TAGS ('dbx_business_glossary_term' = 'Carrier-Specific Instructions');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `customs_broker_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Required Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `estimated_pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Pickup Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `is_intermodal` SET TAGS ('dbx_business_glossary_term' = 'Is Intermodal Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `is_primary_carrier` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Carrier Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `master_awb_number` SET TAGS ('dbx_business_glossary_term' = 'Master Air Waybill (MAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `master_awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `master_bol_number` SET TAGS ('dbx_business_glossary_term' = 'Master Bill of Lading (MBL) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `selection_criteria` SET TAGS ('dbx_business_glossary_term' = 'Selection Criteria');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `selection_method` SET TAGS ('dbx_business_glossary_term' = 'Carrier Selection Method');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `selection_method` SET TAGS ('dbx_value_regex' = 'manual|automated|optimization|spot_quote|contract');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `teu_count` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `total_carrier_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Carrier Cost');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `total_carrier_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tracking Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time in Days');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|intermodal');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_carrier_assignment` ALTER COLUMN `vehicle_count` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` SET TAGS ('dbx_subdomain' = 'cargo_operations');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `freight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Leg Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `carbon_offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Transaction Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Buy Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Node Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `freight_carrier_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Assignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `origin_node_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Node Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `packaging_sustainability_id` SET TAGS ('dbx_business_glossary_term' = 'Pkg Sustainability Record Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `primary_freight_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Location Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `actual_transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Transit Time in Hours');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `baf_amount` SET TAGS ('dbx_business_glossary_term' = 'Bunker Adjustment Factor (BAF) Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `delay_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration in Hours');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `destination_location_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance in Kilometers (KM)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `dwell_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time in Hours');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `freight_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `freight_charges_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `freight_charges_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `gri_amount` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `handling_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Handling Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `handling_charges_currency` SET TAGS ('dbx_business_glossary_term' = 'Handling Charges Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `handling_charges_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `is_intermodal_transfer` SET TAGS ('dbx_business_glossary_term' = 'Is Intermodal Transfer Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_business_glossary_term' = 'Leg Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_value_regex' = 'planned|booked|in_transit|completed|cancelled|delayed');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `origin_location_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `scheduled_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Timestamp (ETA - Estimated Time of Arrival)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp (ETD - Estimated Time of Departure)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Leg Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `teu_count` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `thc_amount` SET TAGS ('dbx_business_glossary_term' = 'Terminal Handling Charge (THC) Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `total_leg_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Leg Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `total_leg_charges_currency` SET TAGS ('dbx_business_glossary_term' = 'Total Leg Charges Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `total_leg_charges_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `transit_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Transit Time in Hours');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `transport_document_number` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `transport_document_type` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|intermodal');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_leg` ALTER COLUMN `voyage_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage or Flight Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` SET TAGS ('dbx_subdomain' = 'cargo_operations');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `intermodal_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Intermodal Transfer ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `freight_carrier_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Assignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Gateway Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `cargo_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `cargo_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `customs_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|held|released');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `delay_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration in Hours');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `dwell_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time in Hours');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'delay|damage|missing_cargo|documentation_error|equipment_failure|weather');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `handling_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Handling Equipment Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `handling_equipment_type` SET TAGS ('dbx_value_regex' = 'reach_stacker|gantry_crane|mobile_crane|forklift|side_loader|straddle_carrier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `scheduled_transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Transfer Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `seal_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Seal Verification Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `seal_verification_status` SET TAGS ('dbx_value_regex' = 'intact|broken|replaced|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `sla_dwell_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Dwell Time in Hours');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_TM|ORACLE_TMS|FOURKITES|MANUAL');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `storage_charge` SET TAGS ('dbx_business_glossary_term' = 'Storage Charge');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `teu_count` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `thc_amount` SET TAGS ('dbx_business_glossary_term' = 'Terminal Handling Charge (THC) Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `total_transfer_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Cost');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transfer_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Facility Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transfer_facility_type` SET TAGS ('dbx_value_regex' = 'icd|cfs|rail_terminal|port|airport|cross_dock');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transfer_handling_charge` SET TAGS ('dbx_business_glossary_term' = 'Transfer Handling Charge');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Intermodal Transfer Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_value_regex' = '^IMT-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|delayed|cancelled|exception');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'ocean_to_rail|ocean_to_road|air_to_road|rail_to_road|road_to_ocean|road_to_air');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`intermodal_transfer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `freight_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `billing_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `carbon_offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Transaction Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `contract_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `freight_carrier_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Assignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `freight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Document Issuance Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `payment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Charge Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Surcharge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending_approval|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Charge Basis');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `charge_category` SET TAGS ('dbx_value_regex' = 'freight|surcharge|accessorial|regulatory|administrative|penalty');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Charge Direction');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'billable_to_shipper|payable_to_carrier|billable_to_consignee|payable_to_vendor|internal_cost');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `is_disputed` SET TAGS ('dbx_business_glossary_term' = 'Is Disputed Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Charge Notes');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Charge Quantity');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|intermodal|courier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_charge` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` SET TAGS ('dbx_subdomain' = 'cargo_operations');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `cfs_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Container Freight Station (CFS) Operation ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Container Freight Station (CFS) Facility ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `ftz_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Ftz Admission Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `cargo_condition_on_receipt` SET TAGS ('dbx_business_glossary_term' = 'Cargo Condition on Receipt');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `cargo_condition_on_receipt` SET TAGS ('dbx_value_regex' = 'good|damaged|wet|soiled|shortage|overage');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `cargo_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cargo Receipt Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `container_cutoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Container Cut-Off Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `customs_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Inspection Required');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `customs_inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customs Inspection Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `customs_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customs Release Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `demurrage_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Accrued Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `demurrage_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `demurrage_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `discrepancy_noted` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Noted');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Equipment Used');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `free_storage_days` SET TAGS ('dbx_business_glossary_term' = 'Free Storage Days');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `handling_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Handling Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `handling_charge_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Handling Charge Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `handling_charge_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `is_hazardous_cargo` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Cargo');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `operation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operation End Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'CFS Operation Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `operation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operation Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `operation_status` SET TAGS ('dbx_business_glossary_term' = 'CFS Operation Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `operation_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|on_hold|cancelled');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'CFS Operation Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'stuffing|destuffing|cross_docking|consolidation|deconsolidation|transloading');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'CFS Operator Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `photo_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Documentation URL');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Container Seal Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `storage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Storage End Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `storage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Storage Start Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `tally_piece_count` SET TAGS ('dbx_business_glossary_term' = 'Tally Piece Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `target_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cfs_operation` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Milestone ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `freight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Document Issuance Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `customs_clearance_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `delay_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration in Hours');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `edi_message_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `estimated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Milestone Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `is_critical_milestone` SET TAGS ('dbx_business_glossary_term' = 'Critical Milestone Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `is_exception` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,5}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `milestone_category` SET TAGS ('dbx_business_glossary_term' = 'Milestone Category');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Event Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Event Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|skipped|cancelled');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `planned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `pod_document_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Document URL');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `pod_signature_name` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signature Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `pod_signature_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `pod_signature_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `proof_of_delivery_received` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Received Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Milestone Remarks');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `temperature_recorded_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Recorded in Celsius');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|intermodal');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel or Vehicle Name');
ALTER TABLE `transport_shipping_ecm`.`freight`.`milestone` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage or Flight Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `freight_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Exception ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Dispute Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `document_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Document Exception Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `freight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `acknowledged_by` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `awb_or_bol_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) or Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `claim_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim Filed Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Channel');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `customer_notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|portal|phone|edi');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `delay_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detected Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `detection_location` SET TAGS ('dbx_business_glossary_term' = 'Detection Location');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `escalated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|tier_1|tier_2|tier_3|executive');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `exception_category` SET TAGS ('dbx_business_glossary_term' = 'Exception Category');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_value_regex' = '^EXC-[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|acknowledged|in_progress|resolved|closed|escalated');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `freight_exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `impacted_leg_sequence` SET TAGS ('dbx_business_glossary_term' = 'Impacted Leg Sequence');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `preventable_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventable Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `revised_eta` SET TAGS ('dbx_business_glossary_term' = 'Revised Estimated Time of Arrival (ETA)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `sla_target_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|intermodal');
ALTER TABLE `transport_shipping_ecm`.`freight`.`freight_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Quote Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `consignee_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee Profile Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Profile Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `spot_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `revised_quote_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `base_freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Freight Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `carrier_service_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `estimated_transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Time in Days');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `imdg_class` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Dangerous Goods (IMDG) Class');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Is Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_value_regex' = 'draft|issued|accepted|rejected|expired|withdrawn');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_business_glossary_term' = 'Quote Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_value_regex' = 'spot|contract|tender|rfq_response');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum in Celsius');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum in Celsius');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `teu_count` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Count');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `total_quoted_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Quoted Amount');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|intermodal');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`quote` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` SET TAGS ('dbx_subdomain' = 'transport_documentation');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` SET TAGS ('dbx_association_edges' = 'freight.freight_order,document.trade_document');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `document_attachment_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Document Attachment ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Attached By User');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Document Attachment - Freight Order Id');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `reviewed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `reviewed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `reviewed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `trade_document_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Document Attachment - Trade Document Id');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Document Acceptance Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `attached_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Attached Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `customs_reference` SET TAGS ('dbx_business_glossary_term' = 'Customs Reference Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Document Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `required_flag` SET TAGS ('dbx_business_glossary_term' = 'Document Required Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Review Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Document Submission Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`document_attachment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Attachment Version Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` SET TAGS ('dbx_subdomain' = 'carrier_services');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` SET TAGS ('dbx_association_edges' = 'freight.freight_order,network.agent');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `shipment_agent_service_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Agent Service ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Agent Service - Agent Id');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Agent Service - Freight Order Id');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Agent Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Agent Assignment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Rate');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Service Assignment Effective Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `handling_fee` SET TAGS ('dbx_business_glossary_term' = 'Agent Handling Fee');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Agent Service Scope');
ALTER TABLE `transport_shipping_ecm`.`freight`.`shipment_agent_service` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Agent Territory Responsibility');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` SET TAGS ('dbx_subdomain' = 'carrier_services');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` SET TAGS ('dbx_association_edges' = 'freight.freight_order,sustainability.carbon_offset_program');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `carbon_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Carbon Allocation ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Carbon Allocation - Carbon Offset Program Id');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `order_freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Carbon Allocation - Freight Order Id');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `customer_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Opt-In Flag');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `program_tier` SET TAGS ('dbx_business_glossary_term' = 'Program Tier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `quantity_tco2e_allocated` SET TAGS ('dbx_business_glossary_term' = 'Quantity CO2e Allocated');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `retirement_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Retirement Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `total_allocation_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Allocation Cost');
ALTER TABLE `transport_shipping_ecm`.`freight`.`carbon_allocation` ALTER COLUMN `unit_cost_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost Per Tonne');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` SET TAGS ('dbx_subdomain' = 'transport_documentation');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` ALTER COLUMN `cargo_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Identifier');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` ALTER COLUMN `consolidated_cargo_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`freight`.`cargo` ALTER COLUMN `declared_value` SET TAGS ('dbx_confidential' = 'true');
