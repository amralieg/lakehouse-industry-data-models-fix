-- Schema for Domain: claim | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`claim` COMMENT 'Manages cargo insurance claims, loss and damage assessments, liability determinations, delay claims, and subrogation processes across all transport modes. Owns claim registration, cargo survey reports, settlement calculations, insurer correspondence, claim status lifecycle, and dangerous goods claims. Aligned to IMO, IATA Warsaw-Montreal Convention, and CMR Convention liability frameworks. Interfaces with billing for credit notes and finance for reserve accounting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` (
    `cargo_claim_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the cargo claim record. Primary key for the cargo_claim data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Claims arise from service failures under contractual agreements. Liability limits, SLA breach penalties, and settlement authority are defined in the governing agreement. Essential for liability determ',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Air cargo claims must reference AWB as primary transport document for Montreal/Warsaw Convention liability determination. Replaces denormalized awb_number with proper FK for weight verification, rate ',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Ocean cargo claims must reference B/L as primary transport document and contract of carriage for Hague-Visby/Hamburg Rules liability determination. Replaces denormalized bol_number with proper FK for ',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Claims may reference original booking when incident occurs during booking phase (space rejection, cargo refused at origin). Supports pre-shipment commercial dispute resolution and booking-level liabil',
    `carbon_offset_transaction_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_transaction. Business justification: When claims require replacement shipments or remediation logistics, ESG-conscious customers may mandate carbon-neutral resolution. Links claim to the offset transaction purchased to neutralize the env',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Claims arise from carrier handling incidents; liability determination, subrogation recovery, and settlement negotiations require direct carrier identification. Essential for carrier liability assessme',
    `claimant_id` BIGINT COMMENT 'Reference to the party (customer, shipper, consignee, or third party) who filed the cargo claim. Serves as the PARTY_REFERENCE for this transaction header.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Claims are financial liabilities posted to GL and must belong to a legal entity (company code) for financial statement preparation, SOX compliance, and intercompany reconciliation. Required for period',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment against which this cargo claim is filed. Links the claim to the originating transport event.',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: Many cargo claims involve container-specific issues (structural damage, contamination, seal breaches, temperature control failures). Links claim to container maintenance, inspection, certification rec',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Claim costs must be allocated to operational cost centers (regional operations, business units) for management accounting, budget variance analysis, and P&L attribution by organizational unit.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Claims arising from customs issues (duty disputes, valuation disagreements, inspection damage, holds) require linking to the customs declaration to verify declared values, duty assessments, and custom',
    `delivery_attempt_id` BIGINT COMMENT 'Foreign key linking to fulfillment.delivery_attempt. Business justification: Claims arise from specific delivery attempts (proof of delivery disputes, signature fraud, delivery to wrong address, recipient impersonation). Legal and claims teams need attempt-level evidence inclu',
    `dg_incident_id` BIGINT COMMENT 'Foreign key linking to safety.dg_incident. Business justification: Claims for dangerous goods cargo must link to DG incident records for regulatory compliance (IATA, IMO, DOT reporting), liability determination under hazmat conventions, and insurer notification. Mand',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Claims may involve driver negligence, improper cargo handling, accidents, or HOS violations. Links to driver certification, training records, incident history, and performance data for liability deter',
    `employee_id` BIGINT COMMENT 'Name or employee identifier of the claims handler or adjuster responsible for investigating and processing this cargo claim. Used for workload management and accountability tracking.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Claims are filed against specific freight orders when cargo damage/loss/delay occurs. Core business process for linking claim liability to the shipment contract. Essential for claim investigation, lia',
    `fulfillment_exception_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_exception. Business justification: Fulfillment exceptions often escalate to formal claims (persistent delivery failures, warehouse damage, inventory discrepancies). Claims reference originating exception for root cause documentation, p',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.order. Business justification: Claims frequently arise from fulfillment operations (damaged goods during picking/packing, delivery failures). Real-world claims processing requires tracing back to original fulfillment order for liab',
    `hold_id` BIGINT COMMENT 'Foreign key linking to customs.customs_hold. Business justification: Customs holds are a frequent cause of delay claims and can cause cargo deterioration (perishables, temperature-sensitive goods). Claims management must track which hold caused the loss to determine li',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Claims arising from HSE incidents (workplace injuries during cargo handling, facility accidents, equipment failures) require direct linkage for liability determination, root cause analysis, and regula',
    `last_mile_dispatch_id` BIGINT COMMENT 'Foreign key linking to fulfillment.last_mile_dispatch. Business justification: Last-mile delivery is highest-risk stage for claims (delivery failures, COD disputes, recipient refusals, theft). Claims must reference specific dispatch for driver accountability, route analysis, and',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to fulfillment.merchant. Business justification: B2B e-commerce claims where merchant is claimant or liable party (merchant-owned inventory damage, merchant packaging inadequacy). Merchant account management needs claim history visibility for credit',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: Parcel-level claims are standard in logistics (individual package damage, loss during transit, dimensional weight disputes). Claims adjusters need direct parcel reference for liability assessment, ins',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Claims teams perform root-cause analysis by tracing incidents back to the executed route plan. Essential for determining if routing decisions (carrier selection, lane choice, hub routing) contributed ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to claim.claim_policy. Business justification: Cargo claim is filed under a specific insurance policy. N:1 relationship (many claims per policy). Adding policy_id FK allows normalization of policy_number which is currently stored as STRING. The cl',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Claims reduce profitability and must be attributed to profit centers for segment reporting, EBITDA calculation by service line/geography, and performance measurement against revenue targets.',
    `spot_quote_id` BIGINT COMMENT 'Foreign key linking to pricing.spot_quote. Business justification: Claims frequently trigger replacement shipment quotes when cargo is damaged/lost. Claim handlers coordinate with sales to obtain spot quotes for re-shipping goods to consignee or returning salvage. Re',
    `surveyor_id` BIGINT COMMENT 'Foreign key linking to claim.surveyor. Business justification: Cargo claim may be assigned to a primary surveyor for assessment. N:1 relationship (many claims per surveyor). Adding surveyor_id FK allows normalization of surveyor_company_name and surveyor_name whi',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Cargo claims frequently involve specific transport assets (trucks, trailers, containers) that caused or were involved in damage incidents. Essential for liability determination, maintenance history re',
    `approved_amount` DECIMAL(18,2) COMMENT 'Monetary amount approved for settlement after liability determination, deductibles, and applicable convention liability caps. May differ from claimed_amount based on investigation findings and regulatory limits.',
    `cargo_description` STRING COMMENT 'Description of the cargo goods subject to the claim, including commodity type, packaging, and any special handling characteristics. Used for valuation and liability assessment.',
    `claim_number` STRING COMMENT 'Externally-known, human-readable unique reference number assigned to the cargo claim at registration. Used in all claimant correspondence, insurer filings, and regulatory submissions. Format: CLM-{YYYY}-{8-digit sequence}.. Valid values are `^CLM-[0-9]{4}-[0-9]{8}$`',
    `claim_status` STRING COMMENT 'Current lifecycle state of the cargo claim from initial registration through final resolution. Drives workflow routing and SLA monitoring. [ENUM-REF-CANDIDATE: registered|under_investigation|liability_determined|settled|rejected|withdrawn|subrogation — promote to reference product]',
    `claim_type` STRING COMMENT 'Classification of the cargo claim by the nature of the loss event. Determines applicable liability framework and settlement calculation methodology. [ENUM-REF-CANDIDATE: loss|damage|shortage|delay|contamination|dangerous_goods|misdelivery — promote to reference product]',
    `claimant_email` STRING COMMENT 'Primary email address of the claimant for claim correspondence, status notifications, and settlement communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `claimant_name` STRING COMMENT 'Full legal name of the party filing the cargo claim (individual or organization). Used in formal claim correspondence, insurer filings, and legal proceedings.',
    `claimant_reference` STRING COMMENT 'The claimants own internal reference number for this claim (e.g., their purchase order, insurance policy number, or internal claim ID). Facilitates cross-referencing in claimant correspondence and EDI exchanges.',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Gross monetary amount claimed by the claimant for the loss, damage, shortage, delay, or contamination event. Represents the claimants stated valuation before liability assessment and adjustment.',
    `claimed_pieces` STRING COMMENT 'Number of pieces, packages, or units of cargo subject to the claim. Used in per-package liability limit calculations under Hague-Visby Rules and for shortage quantification.',
    `claimed_weight_kg` DECIMAL(18,2) COMMENT 'Gross weight in kilograms of the cargo subject to the claim as declared by the claimant. Used in per-kilogram liability limit calculations under Warsaw-Montreal and CMR conventions.',
    `credit_note_reference` STRING COMMENT 'Reference number of the credit note issued to the claimants billing account as part of the claim settlement. Links the claim to the billing and accounts receivable process in SAP S/4HANA Finance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts on this claim (claimed, approved, settlement) are denominated.. Valid values are `^[A-Z]{3}$`',
    `damaged_pieces` STRING COMMENT 'Number of pieces or packages confirmed as damaged or lost following cargo survey. Used to calculate the proportion of the shipment affected and to validate the claimed amount.',
    `dangerous_goods_class` STRING COMMENT 'IMDG/ICAO dangerous goods classification class and division (e.g., Class 1 Explosives, Class 3 Flammable Liquids, Class 6.1 Toxic Substances) for cargo subject to the claim. Populated only when is_dangerous_goods is true.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Insurance policy deductible amount applied to the claim settlement calculation. Reduces the net payable amount to the claimant.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the shipments destination country. Used for jurisdictional analysis, cross-border claim routing, and applicable convention determination.. Valid values are `^[A-Z]{3}$`',
    `finance_reserve_amount` DECIMAL(18,2) COMMENT 'Monetary amount set aside in the financial reserve (provision) for this outstanding claim. Used by SAP S/4HANA Finance for IFRS 4 insurance contract accounting and balance sheet provisioning.',
    `hs_code` STRING COMMENT 'World Customs Organization Harmonized System commodity classification code for the cargo subject to the claim. Used for customs valuation, trade compliance, and dangerous goods classification.. Valid values are `^[0-9]{6,10}$`',
    `incident_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the incident occurred. Used for jurisdictional determination, regulatory reporting, and geographic analytics.. Valid values are `^[A-Z]{3}$`',
    `incident_date` DATE COMMENT 'Calendar date on which the loss, damage, shortage, delay, or contamination event occurred or was discovered. Principal real-world event date for the claim. Used to determine applicable liability periods and statute of limitations.',
    `incident_description` STRING COMMENT 'Narrative description of the circumstances surrounding the loss, damage, shortage, delay, or contamination event. Captures the factual account as reported by the claimant or discovered during survey.',
    `incident_location` STRING COMMENT 'Geographic location (city, port, airport, warehouse, or route segment) where the loss, damage, shortage, or contamination event occurred or was identified. Used for root cause analysis and carrier liability determination.',
    `insurer_name` STRING COMMENT 'Name of the cargo insurance underwriter or insurer responsible for covering this claim. Used for insurer correspondence and subrogation recovery tracking.',
    `insurer_reference` STRING COMMENT 'Reference number assigned by the cargo insurer or underwriter to this claim. Used for insurer correspondence, reimbursement tracking, and subrogation proceedings.',
    `is_dangerous_goods` BOOLEAN COMMENT 'Flag indicating whether the cargo subject to the claim is classified as dangerous goods under IMDG Code or ICAO Technical Instructions. Triggers specialized handling, regulatory notification, and enhanced liability assessment procedures.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the cargo claim record was last modified. Used for audit trail, change detection, and incremental data pipeline processing.',
    `liability_convention` STRING COMMENT 'International liability convention governing this claim and determining the applicable liability limits, time bars, and burden of proof. Determined by transport mode and route.. Valid values are `warsaw_montreal|hague_visby|cmr|cim|hamburg_rules|uncitral`',
    `liability_determination` STRING COMMENT 'Outcome of the liability investigation indicating the degree to which the carrier is responsible for the loss or damage event. Drives settlement calculation and rejection decisions.. Valid values are `carrier_liable|carrier_not_liable|partial_liability|force_majeure|claimant_fault`',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Maximum carrier liability amount applicable to this claim as determined by the governing international convention (e.g., SDR per kg under Warsaw-Montreal, SDR per package under Hague-Visby, SDR per kg under CMR). Used to cap the approved settlement.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the shipments origin country. Used for jurisdictional analysis, cross-border claim routing, and trade compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `registration_timestamp` TIMESTAMP COMMENT 'Date and time when the cargo claim was formally registered in the claims management system. Marks the start of the claim lifecycle and SLA clock. Aligns with RECORD_AUDIT_CREATED category.',
    `rejection_reason` STRING COMMENT 'Narrative explanation for the rejection of the cargo claim, including the specific convention article or policy clause invoked. Populated when claim_status is rejected. Required for formal rejection correspondence to the claimant.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final net monetary amount paid or to be paid to the claimant after applying approved_amount minus deductible_amount and any recoveries. Represents the actual financial outflow for this claim.',
    `settlement_date` DATE COMMENT 'Date on which the claim settlement payment was made or the claim was formally closed. Used for financial reserve release, P&L recognition, and SLA performance measurement.',
    `subrogation_recovery_amount` DECIMAL(18,2) COMMENT 'Monetary amount recovered through subrogation proceedings from the liable third party. Reduces the net financial impact of the claim on the carrier or insurer.',
    `subrogation_status` STRING COMMENT 'Status of the subrogation process whereby the insurer or carrier pursues recovery from a liable third party (e.g., sub-carrier, port operator, customs authority) after settling the claim.. Valid values are `not_applicable|pending|in_progress|recovered|closed`',
    `survey_date` DATE COMMENT 'Date on which the cargo survey was conducted by the appointed surveyor. Used to validate timeliness of damage assessment relative to incident date and convention time bars.',
    `survey_report_number` STRING COMMENT 'Reference number of the independent cargo survey report documenting the extent of loss or damage. Issued by a licensed cargo surveyor and forms the evidentiary basis for liability determination.',
    `time_bar_date` DATE COMMENT 'Statutory deadline by which legal action must be commenced under the applicable liability convention. After this date the claim is time-barred. Calculated from incident_date per convention rules (e.g., 2 years under Warsaw-Montreal, 1 year under Hague-Visby, 1 year under CMR).',
    `transport_mode` STRING COMMENT 'Mode of transport under which the cargo loss or damage event occurred. Determines the applicable international liability convention (Warsaw-Montreal for air, Hague-Visby for ocean, CMR for road, CIM for rail).. Valid values are `air|ocean|road|rail|multimodal`',
    CONSTRAINT pk_cargo_claim PRIMARY KEY(`cargo_claim_id`)
) COMMENT 'Core master entity representing a registered cargo insurance or liability claim. Captures the full claim lifecycle from initial registration (claimant details, claimed amount, AWB/BOL references) through investigation, liability determination, settlement or rejection. Covers loss, damage, shortage, delay, contamination, and dangerous goods claims across all transport modes (air, ocean, road, rail). Includes incident event details (date, location, circumstances, transport mode) and claim type classification. Aligned to IMO, IATA Warsaw-Montreal Convention, CMR Convention, and Hague-Visby liability frameworks. Serves as the SSOT for all claim identity, status, valuation, and lifecycle data.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`claim_event` (
    `claim_event_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the cargo loss or damage event record. Primary key for the claim_event data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Incident events occur under active service contracts. Claims handlers need immediate access to liability conventions, coverage terms, and SLA commitments from the governing agreement for initial asses',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Air cargo incidents must be linked to AWB for liability convention application and carrier identification. Replaces denormalized awb_number with proper FK for flight details, weight verification, and ',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Ocean cargo incidents must be linked to B/L for liability determination under Hague-Visby/Hamburg rules. Replaces denormalized bol_number with proper FK for vessel details, container info, and package',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Claim events may occur during booking phase (space rejection causing commercial loss, cargo refused at origin). Supports pre-shipment incident tracking and booking-level dispute documentation.',
    `cargo_claim_id` BIGINT COMMENT 'Foreign key linking to claim.cargo_claim. Business justification: A claim_event is the initiating loss/damage event that triggers a cargo claim. Multiple events can relate to one claim (e.g., initial damage event plus subsequent delay). The event exists before the c',
    `cargo_survey_id` BIGINT COMMENT 'Reference to the cargo survey report generated following physical inspection of the damaged or lost cargo. Links to the survey report product for detailed findings, photographs, and surveyor recommendations.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (airline, ocean carrier, road haulier, or rail operator) responsible for the leg of transport during which the incident occurred. Used for subrogation proceedings and carrier liability assessment.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment record associated with the cargo incident event. Links to the shipment master for transport details, routing, and cargo manifest. Sourced from SAP TM or Oracle TMS shipment execution records.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Claim events are reported by specific customer contacts. Enables notification routing, escalation tracking, and contact-level claim activity analysis. Critical for customer service and SLA compliance ',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: Claim events frequently involve specific containers (damage, loss, contamination, reefer failure). Container-specific incidents require tracking container history, CSC certification status, condition ',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer or party who is the claimant for this cargo incident event. Links to the customer master for account management and correspondence. Populated from Salesforce CRM account records.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Claim events often originate from customs incidents (examination damage, hold-related delays, confiscation). Tracking the customs declaration enables root cause analysis and liability determination wh',
    `dg_incident_id` BIGINT COMMENT 'Foreign key linking to safety.dg_incident. Business justification: Claim events involving dangerous goods must reference DG incident for regulatory traceability (IATA DGR, IMDG Code compliance), liability determination under hazmat conventions, and mandatory authorit',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Claim events often involve driver actions (accidents, harsh braking, improper handling, loading errors). Links claim events to driver history, training records, certification status, and performance d',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution facility where the cargo incident occurred, if the event took place in a storage or handling facility rather than in transit. Sourced from Manhattan WMS facility master.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Claim events (damage incidents, loss discoveries, delay notifications) are triggered by specific freight orders. Essential for incident tracking, root cause analysis, and linking event to shipment con',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Incident location tracking - claim events occurring at specific fulfillment centers (warehouse damage, loading accidents, inventory shrinkage, equipment failures). Facility management analyzes center-',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.order. Business justification: Claim events track incidents during fulfillment lifecycle (warehouse damage, packing errors, last-mile delivery issues). Operations teams perform root cause analysis by tracing claim events to fulfill',
    `hold_id` BIGINT COMMENT 'Foreign key linking to customs.customs_hold. Business justification: Claim events triggered by customs holds (examination damage, delay, temperature excursion during hold) require direct linkage to the hold record for root cause analysis, liability attribution, and SLA',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Claim-triggering events often originate from HSE incidents (forklift accidents, loading dock injuries, warehouse fires). Operations teams need to trace claim events back to safety incidents for root c',
    `last_mile_dispatch_id` BIGINT COMMENT 'Foreign key linking to fulfillment.last_mile_dispatch. Business justification: Delivery incidents (failed delivery, damaged on delivery, COD collection issues, access problems) are recorded as claim events tied to specific dispatches. Operations teams analyze dispatch-level inci',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: Incident events occur at parcel level (dropped package, water damage, tampering, lost parcel). Tracking requires parcel-level granularity for accurate incident documentation, photographic evidence lin',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Incident events (damage, loss, delay) occur during route execution. Claims investigators need to link events to the planned route for timeline reconstruction, carrier accountability, and SLA breach va',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Third-party logistics providers handle cargo where damage/loss occurs; claims management requires tracking which 3PL was responsible for custody at incident time. Essential for 3PL liability determina',
    `transport_asset_id` BIGINT COMMENT 'Reference to the specific vehicle (truck, aircraft, vessel, or rail wagon) involved in the cargo incident. Used for fleet incident tracking, maintenance correlation, and road/rail liability investigations. Sourced from Fleet and Transport Management domain.',
    `affected_pieces` STRING COMMENT 'Number of pieces, packages, or units confirmed as lost, damaged, short-shipped, or contaminated in the incident. Derived from initial notification; may be revised following cargo survey. Used for shortage and partial loss liability calculations.',
    `cargo_description` STRING COMMENT 'Textual description of the cargo involved in the incident as declared on the transport document. Includes commodity type, packaging, and any special handling designations. Used for survey instructions and liability limit calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the claim event record was first created in the data platform. Used for audit trail and data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `declared_cargo_value` DECIMAL(18,2) COMMENT 'Declared commercial value of the cargo as stated on the transport document or commercial invoice at the time of shipment. Forms the basis for liability limit calculations and insurer reserve setting. Customer-specific financial data.',
    `declared_cargo_value_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the declared cargo value. Required for multi-currency liability calculations and insurer correspondence in cross-border claims.. Valid values are `^[A-Z]{3}$`',
    `destination_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the intended shipment destination at the time of the incident. Used for jurisdictional liability determination and cross-border regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `dg_class` STRING COMMENT 'IMDG/ICAO dangerous goods hazard class and division for the cargo involved in the incident (e.g., Class 1 Explosives, Class 3 Flammable Liquids, Class 6.1 Toxic Substances). Null if is_dangerous_goods is False. Drives emergency response and regulatory notification requirements.',
    `event_status` STRING COMMENT 'Current lifecycle state of the cargo incident event. Drives workflow routing from initial registration through survey, liability determination, claim generation, and closure. [ENUM-REF-CANDIDATE: registered|under_survey|liability_assessed|claim_raised|closed|withdrawn — promote to reference product if additional states are required]. Valid values are `registered|under_survey|liability_assessed|claim_raised|closed|withdrawn`',
    `event_type` STRING COMMENT 'Classification of the nature of the cargo incident. Determines the applicable liability framework, survey methodology, and settlement calculation approach. Loss = total non-delivery; Damage = physical harm to cargo; Shortage = partial non-delivery; Delay = late delivery beyond SLA; Contamination = cargo quality compromise; Dangerous Goods Incident = IMDG/ICAO DG event.. Valid values are `loss|damage|shortage|delay|contamination|dangerous_goods_incident`',
    `flight_voyage_number` STRING COMMENT 'Flight number (air) or voyage number (ocean) of the specific service on which the cargo was carried at the time of the incident. Used for incident investigation, carrier correspondence, and regulatory reporting to IATA or IMO.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the cargo consignment involved in the incident, expressed in kilograms. Used for weight-based liability limit calculations under IATA Warsaw-Montreal Convention (SDR per kg) and CMR Convention.',
    `hawb_number` STRING COMMENT 'House Air Waybill number issued by the freight forwarder or NVOCC for the specific consignment involved in the incident. Distinct from the Master AWB (MAWB) issued by the airline. Used for HAWB-level liability claims in consolidated air shipments.',
    `hbl_number` STRING COMMENT 'House Bill of Lading number issued by the freight forwarder or NVOCC for the specific consignment involved in the ocean freight incident. Distinct from the Master Bill of Lading (MBL). Used for HBL-level liability claims in consolidated ocean shipments.',
    `hs_code` STRING COMMENT 'World Customs Organization Harmonized System commodity classification code for the cargo involved in the incident. Used for customs valuation, trade compliance reporting, and determining applicable duty drawback on lost or damaged goods.. Valid values are `^[0-9]{6,10}$`',
    `incident_cause_code` STRING COMMENT 'Standardized code classifying the root cause of the cargo incident (e.g., mishandling, weather, theft, fire, flooding, collision, improper packaging, documentation error). Used for root cause analysis, carrier performance management, and insurer reporting. [ENUM-REF-CANDIDATE: mishandling|weather|theft|fire|flooding|collision|improper_packaging|documentation_error|contamination|unknown — promote to reference product]',
    `incident_circumstances` STRING COMMENT 'Free-text narrative describing the circumstances of the cargo incident as reported by the notifying party. Captures initial factual account used for survey instructions, insurer notification, and liability investigation. Sourced from Salesforce CRM case notes or direct claimant notification.',
    `incident_location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the cargo incident occurred or was discovered. Used for jurisdictional liability determination and regulatory reporting to national transport authorities.. Valid values are `^[A-Z]{3}$`',
    `incident_location_name` STRING COMMENT 'Descriptive name of the specific location where the cargo incident occurred, such as port name, airport code, warehouse facility name, road segment, or rail terminal. Provides operational context for survey dispatch and liability assessment.',
    `incident_location_type` STRING COMMENT 'Classification of the type of location where the cargo incident occurred. Determines survey access procedures and applicable handling standards. CFS = Container Freight Station; ICD = Inland Container Depot. [ENUM-REF-CANDIDATE: port|airport|warehouse|road|rail_terminal|cfs|icd|customer_premises — promote to reference product if additional types are required]',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time at which the cargo loss, damage, shortage, delay, contamination, or dangerous goods incident occurred or was first observed. Principal real-world event time used for liability determination and convention time-bar calculations. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) applicable to the shipment at the time of the incident. Determines the point of risk transfer between seller and buyer, which is critical for establishing which party bears the loss and has insurable interest. ICC Incoterms 2020. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurer_notification_timestamp` TIMESTAMP COMMENT 'Date and time at which the cargo insurer was formally notified of the incident. Used to verify compliance with policy notification time requirements and to track insurer response timelines. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `insurer_notified` BOOLEAN COMMENT 'Indicates whether the cargo insurer has been formally notified of this incident. Mandatory for incidents exceeding the insurer notification threshold. Tracks compliance with policy notification obligations.',
    `is_dangerous_goods` BOOLEAN COMMENT 'Indicates whether the cargo involved in the incident is classified as dangerous goods under IMDG Code (ocean), ICAO Technical Instructions (air), or ADR/RID (road/rail). Triggers mandatory regulatory notification and specialist DG survey procedures.',
    `liability_convention` STRING COMMENT 'International liability convention applicable to this cargo incident based on transport mode and route. Determines the carrier liability limit (e.g., SDR per kg under Montreal Convention, SDR per package under Hague-Visby). Drives settlement calculation methodology.. Valid values are `warsaw_montreal|hague_visby|hamburg_rules|cmr|cotif_cim|none`',
    `liability_limit_sdr` DECIMAL(18,2) COMMENT 'Calculated maximum carrier liability for this incident expressed in IMF Special Drawing Rights (SDR), derived from the applicable convention limit and cargo weight or package count. Used as the ceiling for settlement calculations and insurer reserve setting.',
    `number_of_pieces` STRING COMMENT 'Total number of individual pieces, packages, or units in the consignment involved in the incident. Used to quantify shortage claims and assess the scope of damage surveys.',
    `origin_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the shipment origin at the time of the incident. Used for jurisdictional liability determination and cross-border regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the cargo incident event at the time of registration. Used in insurer correspondence, survey reports, and claimant communications. Format: CE-{YYYY}-{8-digit sequence}.. Valid values are `^CE-[0-9]{4}-[0-9]{8}$`',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time at which the cargo incident was formally reported to Transport Shipping by the claimant, consignee, or shipper. Used to calculate notification compliance against convention time-bar requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `source_system` STRING COMMENT 'Operational system of record from which the claim event was originated or first captured. Supports data lineage tracking and reconciliation between source systems. Salesforce CRM is the primary source for customer-reported incidents; FourKites for visibility-triggered exceptions.. Valid values are `salesforce_crm|sap_tm|oracle_tms|fourkites|manual`',
    `survey_required` BOOLEAN COMMENT 'Indicates whether a physical cargo survey by an independent surveyor or loss adjuster is required for this incident. Determined by incident type, declared value threshold, and insurer requirements. Triggers survey dispatch workflow.',
    `time_bar_date` DATE COMMENT 'Calculated deadline by which a formal cargo claim must be filed under the applicable liability convention before the right to claim is extinguished. Derived from incident date and convention-specific time limits (e.g., 2 years under Montreal Convention, 1 year under Hague-Visby). Critical for claims management SLA monitoring.',
    `transport_mode` STRING COMMENT 'Mode of transport in operation at the time of the cargo incident. Determines the applicable liability convention (IATA Warsaw-Montreal for air, Hague-Visby/Hamburg Rules for ocean, CMR for road, CIM/COTIF for rail). Drives insurer notification and survey requirements.. Valid values are `air|ocean|road|rail|multimodal`',
    `un_number` STRING COMMENT 'United Nations dangerous goods identification number for the hazardous substance involved in the incident. Mandatory for IMDG and ICAO DG incident reporting. Null if is_dangerous_goods is False. Format: UN followed by 4-digit number (e.g., UN1203).. Valid values are `^UN[0-9]{4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the claim event record was last modified. Supports change tracking and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the cargo consignment involved in the incident, expressed in cubic metres (CBM). Used for volumetric assessment of damage extent and DIM weight calculations for air freight liability.',
    CONSTRAINT pk_claim_event PRIMARY KEY(`claim_event_id`)
) COMMENT 'Transactional record capturing the initiating loss or damage event that triggers a cargo claim. Records the incident date, location, transport mode, event type (loss, damage, shortage, delay, contamination, dangerous goods incident), and initial circumstances. Provides the factual basis for liability determination and insurer correspondence. One claim event may generate one or more cargo claims.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` (
    `cargo_survey_id` BIGINT COMMENT 'Unique system-generated identifier for the cargo survey report record. Primary key for the cargo_survey data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Surveyors assess damage against contractual incoterms, liability limits, and service commitments. Survey reports cite contract terms to establish liability basis. Required for determining whether dama',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Air cargo surveys must reference AWB for weight/piece verification and liability assessment. Replaces denormalized awb_number with proper FK for declared value comparison, chargeable weight verificati',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Ocean cargo surveys must reference B/L for cargo description and liability limit determination. Replaces denormalized bol_number with proper FK for package count verification, gross weight comparison,',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Surveys may reference booking when damage discovered pre-departure or during cargo receipt at origin. Supports pre-shipment damage assessment and booking-level cargo condition verification.',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the parent cargo insurance claim for which this survey was commissioned. Links the survey report to the claim lifecycle.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment record associated with the cargo loss or damage event being surveyed.',
    `container_unit_id` BIGINT COMMENT 'Foreign key linking to fleet.container_unit. Business justification: Surveyors inspect container condition as part of cargo damage assessment. Container CSC certification, maintenance history, condition grade, and structural integrity are critical survey inputs for det',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Surveys are commissioned on behalf of customer accounts for cargo damage assessment. Enables survey cost allocation, customer survey history tracking, and customer-specific survey performance reportin',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Surveyors need customs documentation to verify declared values, HS codes, and customs status when assessing damage/loss. Essential for valuation disputes and determining if customs examination contrib',
    `dg_incident_id` BIGINT COMMENT 'Foreign key linking to safety.dg_incident. Business justification: Surveys of dangerous goods damage must reference DG incident report for regulatory compliance (IATA DGR, IMDG Code), proper hazmat assessment, and liability determination. Surveyors require DG inciden',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Cargo surveys are frequently conducted at warehouse facilities where damaged goods are held. Survey reports must document the inspection location for evidence chain-of-custody and legal purposes. Ware',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Surveys are commissioned to assess damage on specific freight orders. Core claims investigation process for determining extent of loss, cause of damage, and supporting liability determination and sett',
    `center_id` BIGINT COMMENT 'Foreign key linking to fulfillment.center. Business justification: Surveys conducted at fulfillment centers to assess damage before dispatch or upon return (pre-shipment inspection, RMA receipt inspection). Survey location tracking enables facility-specific quality m',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Surveys investigating cargo damage may discover damage resulted from HSE incident (worker injury causing dropped cargo, equipment failure causing spill). Surveyors must document this causal link for l',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to fulfillment.parcel. Business justification: Surveyors inspect specific parcels to assess physical damage extent, packaging adequacy, and determine liability. Survey reports must reference exact parcel with tracking number, weight, dimensions fo',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Surveyors inspect cargo at specific route milestones (origin, hub, destination). Survey reports reference the route plan to document handling conditions, transit mode changes, and custody transfers. E',
    `surveyor_id` BIGINT COMMENT 'Foreign key linking to claim.surveyor. Business justification: Cargo survey is conducted by a specific surveyor. N:1 relationship (many surveys per surveyor). Adding surveyor_id FK allows normalization of surveyor_company_name, surveyor_name, and surveyor_license',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Surveyors inspect cargo damage involving specific transport assets. Survey reports document asset condition, loading/unloading practices, equipment failures, and asset-related damage causes. Critical ',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Cargo surveys produce formal survey reports that are specific document instances. Claims adjusters, insurers, and legal teams need direct access to the authoritative survey report document for liabili',
    `cargo_volume_cbm` DECIMAL(18,2) COMMENT 'Volume of the cargo under survey in cubic meters (CBM). Used for dimensional weight calculations, container utilization assessment, and loss quantification.',
    `cargo_weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the cargo under survey in kilograms as declared on the transport document. Used as basis for liability limit calculations under applicable conventions (e.g., SDR per kg under Montreal Convention).',
    `commissioned_timestamp` TIMESTAMP COMMENT 'Date and time when the cargo survey was formally commissioned and the surveyor was appointed. Used for SLA tracking and claim timeline management.',
    `commodity_description` STRING COMMENT 'Detailed description of the cargo commodity being surveyed, including nature of goods, packaging type, and any special handling characteristics relevant to the damage assessment.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the cargo survey report was formally completed and submitted. Used for turnaround time measurement and claim settlement scheduling.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the cargo survey record was first created in the data platform. Used for audit trail and data lineage.',
    `damage_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the cargo damage or loss as determined by the surveyor (e.g., mishandling, water ingress, temperature excursion, collision, theft). [ENUM-REF-CANDIDATE: mishandling|water_ingress|temperature_excursion|collision|theft|contamination|improper_packing|force_majeure — promote to reference product]',
    `damage_cause_narrative` STRING COMMENT 'Free-text narrative explanation of the probable cause of the cargo damage or loss as assessed by the surveyor, including contributing factors and chain of events.',
    `damage_description` STRING COMMENT 'Detailed narrative description of the nature, extent, and visible characteristics of the cargo damage or loss as observed and documented by the surveyor during inspection.',
    `damaged_pieces_count` STRING COMMENT 'Number of individual pieces or packages found to be damaged during the survey inspection. Used to calculate partial loss ratio and settlement amount.',
    `dangerous_goods_class` STRING COMMENT 'IMDG/IATA/ADR dangerous goods classification class and division for the cargo (e.g., Class 3 Flammable Liquids, Class 6.1 Toxic Substances). Populated only when is_dangerous_goods is true.',
    `declared_cargo_value` DECIMAL(18,2) COMMENT 'Value of the cargo as declared by the shipper on the transport document (AWB or BOL). Used as the upper bound for claim settlement and comparison against surveyors estimated loss value.',
    `estimated_loss_value` DECIMAL(18,2) COMMENT 'Surveyors estimated monetary value of the cargo loss or damage based on inspection findings, market value assessment, and applicable depreciation. Primary input to claim settlement calculation.',
    `hs_code` STRING COMMENT 'World Customs Organization Harmonized System commodity classification code for the cargo under survey. Used for customs compliance, trade statistics, and liability limit calculations under applicable conventions.. Valid values are `^[0-9]{6,10}$`',
    `insurer_reference_number` STRING COMMENT 'Reference number assigned by the cargo insurer to this survey report for their internal claim file. Used for insurer correspondence and settlement coordination.',
    `is_dangerous_goods` BOOLEAN COMMENT 'Indicates whether the cargo under survey is classified as dangerous goods. Triggers application of IMDG Code (ocean), ICAO Technical Instructions (air), or ADR (road) liability and survey protocols.',
    `joint_survey_indicator` BOOLEAN COMMENT 'Indicates whether the survey was conducted jointly with the carrier, insurer, or other interested party. Joint surveys carry greater evidentiary weight in liability disputes.',
    `liability_attribution` STRING COMMENT 'Surveyors determination of the party to whom liability for the cargo loss or damage is attributed. Directly informs claim settlement calculations and subrogation proceedings.. Valid values are `carrier|shipper|consignee|third_party|force_majeure|undetermined`',
    `liability_convention` STRING COMMENT 'International liability convention applicable to this cargo survey based on the transport mode and route. Determines the liability limit calculation methodology and currency (SDR).. Valid values are `montreal_convention|hague_visby|cmr_convention|cim_convention|warsaw_convention`',
    `liability_limit_sdr` DECIMAL(18,2) COMMENT 'Maximum carrier liability limit expressed in IMF Special Drawing Rights (SDR) as calculated under the applicable liability convention (e.g., 19 SDR/kg under Montreal Convention). Used to cap claim settlement.',
    `missing_pieces_count` STRING COMMENT 'Number of individual pieces or packages confirmed missing or unaccounted for during the survey. Used to quantify shortage claims and establish carrier liability for non-delivery.',
    `number_of_pieces` STRING COMMENT 'Total number of individual pieces, packages, or units comprising the cargo consignment as declared on the transport document. Used to quantify shortage and partial loss.',
    `photographic_evidence_indicator` BOOLEAN COMMENT 'Indicates whether photographic or video evidence of the cargo damage was captured and attached to the survey report. Affects evidentiary strength of the claim.',
    `report_submission_date` DATE COMMENT 'Date on which the completed survey report was formally submitted to the claims department or insurer. Used for SLA compliance tracking and claim filing deadline management.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual or salvage value of the damaged cargo that can be recovered or sold. Deducted from estimated loss value to determine net claim settlement amount.',
    `subrogation_applicable` BOOLEAN COMMENT 'Indicates whether the survey findings support a subrogation action against a liable third party. Triggers the subrogation process in the claims management workflow.',
    `survey_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the declared cargo value, estimated loss value, and salvage value are expressed in this survey report.. Valid values are `^[A-Z]{3}$`',
    `survey_date` DATE COMMENT 'The date on which the physical cargo survey inspection was conducted by the appointed surveyor. Principal real-world event date for this record.',
    `survey_location_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the cargo survey was conducted. Used for jurisdictional liability determination and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `survey_location_name` STRING COMMENT 'Name of the facility, port, warehouse, or location where the cargo survey inspection was physically conducted (e.g., port terminal name, warehouse address, CFS name).',
    `survey_methodology` STRING COMMENT 'Method employed by the surveyor to assess the cargo loss or damage. Determines the evidentiary weight of the survey findings in claim settlement.. Valid values are `physical_inspection|documentary_review|joint_inspection|remote_assessment|sampling`',
    `survey_reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the cargo survey report, used in insurer correspondence and claim settlement documentation.. Valid values are `^SRV-[A-Z0-9]{6,20}$`',
    `survey_report_number` STRING COMMENT 'Unique report number assigned by the surveying company to their formal survey report document. Used for document management and insurer correspondence cross-referencing.',
    `survey_status` STRING COMMENT 'Current lifecycle state of the cargo survey report. Tracks progression from initial commissioning through completion or cancellation.. Valid values are `draft|commissioned|in_progress|completed|cancelled|disputed`',
    `survey_type` STRING COMMENT 'Classification of the cargo survey by the nature of the incident being assessed. Determines the survey methodology and applicable liability framework. [ENUM-REF-CANDIDATE: loss|damage|shortage|delay|contamination|dangerous_goods|theft|misdelivery — promote to reference product]. Valid values are `loss|damage|shortage|delay|contamination|dangerous_goods`',
    `surveyor_recommendations` STRING COMMENT 'Surveyors formal recommendations for cargo disposal, remediation, repair, or preventive measures to avoid recurrence. Used in claim settlement negotiations and operational improvement.',
    `transport_mode` STRING COMMENT 'Mode of transport under which the cargo was being carried at the time of the loss or damage event. Determines applicable liability convention (IATA Warsaw-Montreal for air, IMO/Hague-Visby for ocean, CMR for road, CIM for rail).. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the cargo survey record was last modified. Used for change tracking and audit compliance.',
    CONSTRAINT pk_cargo_survey PRIMARY KEY(`cargo_survey_id`)
) COMMENT 'Master record for a cargo survey report commissioned to assess the nature, extent, and cause of cargo loss or damage. Captures surveyor identity, survey date and location, survey methodology, findings, estimated loss value, and liability attribution. Used as primary evidence in claim settlement calculations and insurer correspondence. Aligned to IATA and IMO cargo survey standards.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`liability_determination` (
    `liability_determination_id` BIGINT COMMENT 'Unique surrogate identifier for the liability determination record. Primary key for this transactional entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Core adjudication process—liability officers determine settlement amounts by applying contractual liability caps, conventions, and penalty clauses. Cannot adjudicate liability without direct reference',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Air cargo liability determination requires AWB reference for Montreal/Warsaw Convention application. Replaces denormalized awb_number with proper FK for declared value verification, weight-based liabi',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Ocean cargo liability determination requires B/L reference for Hague-Visby rules application. Replaces denormalized bol_number with proper FK for package-based liability limits, freight terms verifica',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Liability may be determined at booking level when contractual terms are disputed (space confirmation breach, rate disputes). Supports pre-shipment commercial liability assessment and booking contract ',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the parent cargo claim record for which this liability determination has been made. Links the determination to the originating claim lifecycle.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Liability determinations explicitly assess carrier responsibility percentages under transport conventions; direct carrier linkage is fundamental to liability allocation, legal proceedings, and carrier',
    `claim_party_id` BIGINT COMMENT 'Reference to the party (shipper, consignee, or insurer) who filed the cargo claim and against whom or in whose favour the liability determination is made.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment involved in the claim, enabling traceability to the transport event that gave rise to the liability determination.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Liability determinations directly affect customer accounts for settlement amounts and credit management. Enables customer-level liability analysis, credit risk assessment, and financial reserve planni',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Liability determinations require customs data to establish declared cargo value (liability cap basis under conventions), verify HS codes for restricted goods, and assess if customs delays/actions cont',
    `driver_profile_id` BIGINT COMMENT 'Foreign key linking to fleet.driver_profile. Business justification: Driver qualifications, training, certification, and incident history are critical factors in liability determinations for cargo claims. Links liability analysis to driver licensing, HOS compliance, sa',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Liability determination for warehouse-related incidents requires facility context including certifications (ISO, C-TPAT), operating procedures, equipment capabilities, and bonded/FTZ status. Essential',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Liability determinations are made per freight order to establish carrier/shipper responsibility percentages. Core claims adjudication process for applying liability conventions, calculating maximum li',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Liability assessors must reference HSE incidents when determining fault and apportionment (was damage caused by unsafe working conditions? employee negligence? equipment failure?). Critical for accura',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Liability limits and applicable conventions (CMR, Warsaw, Hague-Visby) vary by lane characteristics (cross-border, transport mode, incoterms). Determinations reference the lane to apply correct legal ',
    `employee_id` BIGINT COMMENT 'Reference to the claims officer or legal counsel responsible for issuing this liability determination. Supports accountability, audit trail, and workload reporting.',
    `supplier_id` BIGINT COMMENT 'Reference to the cargo insurer involved in this liability determination. Required for insurer correspondence, subrogation processes, and reserve accounting.',
    `surveyor_id` BIGINT COMMENT 'FK to claim.surveyor',
    `transport_asset_id` BIGINT COMMENT 'Foreign key linking to fleet.transport_asset. Business justification: Liability determinations often hinge on asset condition, maintenance compliance, inspection records, and equipment certification status. Links claim liability analysis to specific vehicle/container in',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Liability determinations are formal documented decisions by claims adjusters or legal counsel. Settlement negotiations, dispute resolution, and regulatory audits require the authoritative determinatio',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the liability determination was formally approved by the authorised approver. Marks the transition from under_review to approved status.',
    `cargo_declared_value` DECIMAL(18,2) COMMENT 'The value of the cargo as declared by the shipper on the Air Waybill (AWB) or Bill of Lading (BOL). Used when ad valorem liability basis applies or when declared value exceeds the convention limit.',
    `cargo_declared_value_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the cargo declared value. Required for multi-currency settlement and insurer correspondence.. Valid values are `^[A-Z]{3}$`',
    `cargo_weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the cargo in kilograms as recorded on the transport document (AWB or BOL). Used to calculate the per-kg liability limit under applicable conventions.',
    `carrier_liability_pct` DECIMAL(18,2) COMMENT 'The percentage of total loss or damage attributed to the carriers fault or negligence, expressed as a value between 0.00 and 100.00. Used in proportional settlement calculations.',
    `claim_type` STRING COMMENT 'Classification of the cargo claim type that this liability determination addresses. Determines applicable convention provisions and liability cap calculations.. Valid values are `loss|damage|delay|shortage|misdelivery|dangerous_goods`',
    `consignee_liability_pct` DECIMAL(18,2) COMMENT 'The percentage of total loss or damage attributed to the consignees contributory negligence or fault (e.g., failure to mitigate, improper handling at destination). Complements carrier and shipper liability percentages.',
    `contributory_negligence_flag` BOOLEAN COMMENT 'Indicates whether contributory negligence by the shipper or consignee has been identified and factored into the liability determination, reducing the carriers proportional liability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this liability determination record was first created in the system. Used for audit trail and data lineage tracking.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the cargo involved in the claim is classified as dangerous goods, triggering additional liability provisions under IMDG Code or ICAO Technical Instructions.',
    `delay_hours` DECIMAL(18,2) COMMENT 'Number of hours by which the shipment was delayed beyond the agreed or scheduled delivery time. Applicable for delay claims under Montreal Convention Article 19 and CMR Convention Article 23(5).',
    `determination_date` DATE COMMENT 'The business event date on which the formal liability assessment was completed and the determination was issued. Distinct from the record creation timestamp.',
    `determination_number` STRING COMMENT 'Externally-known business reference number for this liability determination, used in insurer correspondence, legal filings, and settlement documentation. Format: LD-YYYY-NNNNNN.. Valid values are `^LD-[0-9]{4}-[0-9]{6}$`',
    `determination_status` STRING COMMENT 'Current lifecycle state of the liability determination record. Drives workflow routing for settlement calculation and insurer correspondence.. Valid values are `draft|under_review|approved|disputed|withdrawn|closed`',
    `dispute_raised_date` DATE COMMENT 'Date on which the formal dispute against this liability determination was raised. Used to track statutory limitation periods under applicable conventions.',
    `dispute_reason` STRING COMMENT 'Narrative description of the grounds on which the liability determination has been disputed by the claimant or carrier. Populated when determination_status is disputed.',
    `incoterms_code` STRING COMMENT 'The Incoterms code applicable to the shipment, determining the point at which risk transfers from seller to buyer. Influences the liability determination by establishing which party bears risk at the time of loss or damage. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `legal_basis_description` STRING COMMENT 'Narrative description of the legal and factual basis for the liability determination, including specific convention articles, exclusions applied (e.g., act of God, inherent vice, shipper fault), and supporting evidence references.',
    `liability_basis` STRING COMMENT 'The unit basis on which the carrier liability limit is calculated — per kilogram, per package, per unit, or based on declared/ad valorem value. Drives the settlement calculation formula.. Valid values are `per_kg|per_package|per_unit|declared_value|ad_valorem`',
    `liability_convention` STRING COMMENT 'The international legal convention or regulatory framework applied to determine carrier liability limits for this claim. Governs the applicable liability cap per kg or per package. [ENUM-REF-CANDIDATE: Warsaw-Montreal|CMR|Hague-Visby|COGSA|CIM-COTIF|Montreal-1999|other — promote to reference product]',
    `liability_exclusion_type` STRING COMMENT 'Category of liability exclusion applied to reduce or eliminate carrier liability under the applicable convention. Drives the legal basis narrative and settlement outcome.. Valid values are `act_of_god|inherent_vice|shipper_fault|war_risk|nuclear|none`',
    `liability_limit_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the liability limit per unit is expressed. Typically SDR (Special Drawing Rights) for international conventions, or USD for COGSA.. Valid values are `^[A-Z]{3}$`',
    `liability_limit_per_unit` DECIMAL(18,2) COMMENT 'The maximum carrier liability amount per unit (kg or package) as prescribed by the applicable convention. For Montreal Convention air freight: 22 SDR/kg. For Hague-Visby ocean: 666.67 SDR/package or 2 SDR/kg. Used in settlement calculation.',
    `limitation_period_expiry_date` DATE COMMENT 'The date on which the statutory limitation period for legal action expires under the applicable convention. Montreal Convention: 2 years; CMR: 1 year (3 for wilful misconduct); Hague-Visby: 1 year.',
    `maximum_liability_amount` DECIMAL(18,2) COMMENT 'The calculated maximum monetary amount the carrier is liable for under the applicable convention, derived from liability_limit_per_unit multiplied by the applicable weight or package count. Cap for settlement calculation.',
    `maximum_liability_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the maximum liability amount is expressed for settlement purposes.. Valid values are `^[A-Z]{3}$`',
    `negligence_description` STRING COMMENT 'Narrative description of the contributory negligence factors identified for the shipper or consignee, including evidence basis (e.g., improper packaging, misdeclared weight, inadequate labelling).',
    `package_count` STRING COMMENT 'Number of packages or units in the shipment as declared on the transport document. Used to calculate per-package liability limits under Hague-Visby Rules and COGSA.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'The financial reserve amount set aside in the general ledger for this liability determination, representing the estimated carrier liability exposure. Feeds SAP S/4HANA Finance reserve accounting.',
    `reserve_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the claims reserve amount. Required for multi-currency financial reporting and IFRS compliance.. Valid values are `^[A-Z]{3}$`',
    `settlement_recommendation_amount` DECIMAL(18,2) COMMENT 'The recommended monetary settlement amount derived from this liability determination, factoring in the maximum liability cap, carrier liability percentage, and contributory negligence. Input to the settlement calculation process.',
    `settlement_recommendation_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the settlement recommendation amount.. Valid values are `^[A-Z]{3}$`',
    `shipper_liability_pct` DECIMAL(18,2) COMMENT 'The percentage of total loss or damage attributed to the shippers contributory negligence or fault (e.g., improper packaging, misdeclaration). Complements carrier_liability_pct.',
    `subrogation_amount` DECIMAL(18,2) COMMENT 'The monetary amount the insurer is seeking to recover from the carrier through subrogation after having settled the claim with the insured party.',
    `subrogation_flag` BOOLEAN COMMENT 'Indicates whether the insurer has exercised or intends to exercise subrogation rights against the carrier following settlement of the cargo claim.',
    `survey_report_number` STRING COMMENT 'Reference number of the independent cargo survey report that assessed the extent of loss or damage. Provides evidentiary basis for the liability determination.',
    `transport_mode` STRING COMMENT 'Mode of transport applicable to the shipment leg on which the loss, damage, or delay occurred. Determines which liability convention and limit applies.. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this liability determination record. Supports audit trail and change tracking requirements.',
    CONSTRAINT pk_liability_determination PRIMARY KEY(`liability_determination_id`)
) COMMENT 'Transactional record documenting the formal liability assessment for a cargo claim. Captures the applicable liability convention (Warsaw-Montreal, CMR, Hague-Visby, COGSA), liability limit per kg or per package, contributory negligence factors, carrier liability percentage, shipper/consignee liability percentage, and the legal basis for the determination. Drives settlement calculation and insurer correspondence.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Unique surrogate identifier for the claim settlement record in the Transport Shipping lakehouse. Primary key for this transactional entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Settlement amounts are bounded by contractual liability limits and payment terms. Finance teams reconcile settlements against contract commitments and verify that settlements do not exceed contractual',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Air cargo settlements require AWB reference for payment allocation and carrier invoicing. Replaces denormalized awb_number with proper FK for freight charge reconciliation, credit note generation, and',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Ocean cargo settlements require B/L reference for payment allocation and carrier invoicing. Replaces denormalized bol_number with proper FK for freight charge reconciliation, credit note generation, a',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Settlements may reference booking for pre-shipment commercial disputes (space confirmation breach penalties, rate dispute refunds). Supports booking-level financial reconciliation and commercial dispu',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the parent cargo claim record for which this settlement is being processed. Links the settlement back to the originating claim registration in the Claims and Insurance domain.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Settlements involve carrier payments or recoveries; financial reconciliation, subrogation tracking, and carrier account management require carrier identification. Essential for carrier settlement reco',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Settlement GL posting requires specific account assignment (liability accounts, expense accounts, reserve release accounts) from chart of accounts for proper financial statement classification and rep',
    `claim_party_id` BIGINT COMMENT 'Reference to the party (customer, shipper, or consignee) who filed the cargo claim and is the beneficiary of the settlement. Satisfies the PARTY_REFERENCE requirement for TRANSACTION_HEADER role.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Settlement payments are posted to GL and must belong to a legal entity for financial statement preparation, cash flow reporting, and intercompany reconciliation. Required for audit trail and SOX compl',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Settlement costs must be allocated to operational cost centers for budget control, variance analysis, and cost management reporting. Enables tracking of claim costs by organizational responsibility.',
    `credit_note_id` BIGINT COMMENT 'Foreign key linking to billing.credit_note. Business justification: Claim settlements trigger credit notes issued to customers for financial reconciliation. Real business process: when carrier settles cargo claim, finance issues credit note to customer account. Existi',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Settlements are paid to/from customer accounts. Critical for AR/AP reconciliation, customer financial reporting, credit limit management, and payment terms enforcement. Core financial process linking ',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Settlement calculations depend on customs-declared values as the liability basis. Finance teams need customs data for GL coding, duty recovery calculations in total loss scenarios, and validating clai',
    `employee_id` BIGINT COMMENT 'Name or employee identifier of the claims manager or finance controller who authorized the settlement. Required for SOX segregation of duties and internal audit compliance.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Settlement accounting and cost allocation require facility-level attribution for self-insured warehouse operations, facility-specific insurance policies, and cost center reporting. Critical for tracki',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Settlements are paid against specific freight orders. Essential for financial reconciliation, GL posting, credit note generation, and linking settlement payment to original shipment invoice for accoun',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Finance and network planning teams analyze settlement costs by lane for carrier performance evaluation, rate negotiation, and network optimization. Lane-level aggregation of claim costs informs carrie',
    `liability_determination_id` BIGINT COMMENT 'Foreign key linking to claim.liability_determination. Business justification: A settlement is calculated based on a formal liability determination. The settlement table has liability_basis which is defined authoritatively on the liability_determination record (which has liabili',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Settlements reduce profit center performance and must be tracked for segment P&L, EBITDA reporting, and profitability analysis by service line or geographic region.',
    `supplier_id` BIGINT COMMENT 'Reference to the insurance carrier or underwriter involved in the settlement. Used for insurer recovery tracking and subrogation processes.',
    `surveyor_id` BIGINT COMMENT 'Foreign key linking to claim.surveyor. Business justification: Claim settlement may reference a surveyor whose report formed the basis for settlement amount determination. N:1 relationship (many settlements per surveyor). Adding surveyor_id FK allows normalizatio',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Settlement agreements are formal legal documents signed by claimant and carrier. Finance teams require the executed settlement document for payment authorization, audit trails, and regulatory complian',
    `acceptance_date` DATE COMMENT 'Date on which the claimant formally accepted the settlement offer. Triggers payment processing and reserve release in SAP S/4HANA Finance.',
    `acceptance_status` STRING COMMENT 'Indicates whether the claimant has formally accepted the settlement offer. Pending means offer made but not yet responded to; accepted means claimant signed off; disputed means claimant contests the amount; withdrawn means claimant retracted acceptance.. Valid values are `pending|accepted|disputed|withdrawn`',
    `actual_settlement_days` STRING COMMENT 'Actual number of calendar days taken to settle the claim from claim registration date to settlement_date. Used to measure SLA compliance and KPI performance against sla_settlement_target_days.',
    `amount` DECIMAL(18,2) COMMENT 'Gross base amount agreed to be paid to the claimant as settlement for the cargo claim, expressed in the settlement currency. This is the pre-deduction gross figure before any excess, deductible, or recovery offsets. Part of the MONETARY_TRIPLET for TRANSACTION_HEADER role.',
    `approval_date` DATE COMMENT 'Date on which the settlement was internally approved by the authorized claims manager or finance controller. Required for SOX internal controls and audit trail.',
    `claim_type` STRING COMMENT 'Category of the underlying cargo claim being settled. Determines applicable liability framework and maximum settlement limits per governing conventions (Warsaw-Montreal for air, CMR for road, Hague-Visby for ocean).. Valid values are `loss|damage|delay|shortage|misdelivery|dangerous_goods`',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Original amount claimed by the claimant as submitted in the claim registration. Used to calculate settlement ratio and measure liability exposure versus actual payout for analytics and reserve adequacy assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was first created in the system. Used for audit trail and SLA compliance tracking. Satisfies the RECORD_AUDIT_CREATED category for TRANSACTION_HEADER role.',
    `currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the settlement amount is denominated and paid (e.g., USD, EUR, GBP). Required for multi-currency financial reporting and FX conversion. Part of the MONETARY_TRIPLET.. Valid values are `^[A-Z]{3}$`',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the cargo claim involves dangerous goods shipments. When true, triggers additional regulatory compliance checks under IMDG Code (ocean), ICAO Technical Instructions (air), and ADR (road) for settlement processing.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Policy excess or deductible amount subtracted from the gross settlement before net payment to the claimant. Represents the adjustment component of the MONETARY_TRIPLET.',
    `dispute_reason` STRING COMMENT 'Description of the reason for claimant dispute when acceptance_status is disputed. Captures the basis of disagreement (e.g., valuation methodology, liability limit application, deductible amount) for escalation and resolution tracking.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert the settlement amount from the settlement currency to the companys functional reporting currency at the time of settlement. Required for multi-currency financial consolidation under IFRS.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Net settlement amount converted to the companys functional reporting currency using the exchange rate at settlement date. Used for financial consolidation, P&L reporting, and reserve release accounting in SAP S/4HANA Finance.',
    `insurer_correspondence_reference` STRING COMMENT 'Reference number or file number assigned by the cargo insurer for their internal tracking of this claim settlement. Used for insurer correspondence, recovery claims, and co-insurance coordination.',
    `insurer_recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the cargo insurer or underwriter as part of the settlement, reducing the net cost to Transport Shipping. Relevant for subrogation processes and insurer correspondence tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement record. Supports audit trail, change tracking, and incremental data pipeline processing. Satisfies the RECORD_AUDIT_UPDATED category for TRANSACTION_HEADER role.',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Maximum carrier liability amount applicable to this claim under the governing convention or contract (e.g., SDR per kg under Warsaw-Montreal, SDR per kg under CMR). Used to validate that settlement does not exceed statutory limits.',
    `liability_limit_currency` STRING COMMENT 'ISO 4217 currency code or SDR (Special Drawing Rights) denomination in which the liability limit is expressed under the applicable convention. Typically SDR for international conventions.. Valid values are `^[A-Z]{3}$`',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Final net amount payable to the claimant after deducting the policy excess/deductible from the gross settlement amount. Represents the net total component of the MONETARY_TRIPLET for TRANSACTION_HEADER role.',
    `notes` STRING COMMENT 'Free-text field capturing additional context, negotiation notes, special conditions, or remarks relevant to the settlement. Includes basis for ex gratia payments, dispute resolution notes, or partial settlement justification.',
    `payment_date` DATE COMMENT 'Date on which the settlement payment was actually disbursed to the claimant. May differ from settlement_date (agreement date) due to payment processing lead times. Used for cash flow reporting and SLA measurement.',
    `payment_method` STRING COMMENT 'Method by which the settlement amount is disbursed to the claimant. Bank transfer is the standard for large settlements; credit note offsets against outstanding freight invoices; cheque for legacy or specific jurisdictions.. Valid values are `bank_transfer|credit_note|cheque|offset|cash`',
    `payment_reference` STRING COMMENT 'Bank payment reference, cheque number, or transaction ID from the payment system confirming disbursement of the settlement amount to the claimant. Used for payment reconciliation in SAP S/4HANA Finance AP.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'Financial reserve amount set aside in SAP S/4HANA Finance for this claim at the time of claim registration. Used to track reserve adequacy and calculate reserve release upon settlement.',
    `reserve_release_amount` DECIMAL(18,2) COMMENT 'Amount of the financial reserve released back to the P&L upon settlement of the claim. Equals the difference between the reserve amount and the net settlement amount. Interfaces with SAP S/4HANA Finance for reserve accounting journal entries.',
    `settlement_date` DATE COMMENT 'The date on which the settlement was formally agreed and accepted by all parties. Represents the principal real-world business event date for this transaction. Satisfies the BUSINESS_EVENT_TIMESTAMP category.',
    `settlement_number` STRING COMMENT 'Externally-known, human-readable business identifier for the settlement transaction. Used in correspondence with claimants, insurers, and finance teams. Satisfies the BUSINESS_IDENTIFIER category for TRANSACTION_HEADER role.. Valid values are `^STL-[0-9]{4}-[0-9]{6}$`',
    `settlement_status` STRING COMMENT 'Current lifecycle state of the claim settlement workflow. Tracks progression from initial draft through approval, payment, and closure. Satisfies the LIFECYCLE_STATUS category for TRANSACTION_HEADER role.. Valid values are `draft|pending_approval|approved|paid|rejected|withdrawn`',
    `settlement_type` STRING COMMENT 'Classification of the settlement by nature of resolution. Full settlement closes the claim entirely; partial settlement covers a portion; ex gratia is a goodwill payment without liability admission; subrogation involves insurer recovery; credit note offsets against future billing.. Valid values are `full|partial|ex_gratia|subrogation|credit_note`',
    `sla_settlement_target_days` STRING COMMENT 'Target number of calendar days within which the claim settlement must be completed from claim registration date, as defined in the applicable SLA or service contract. Used for KPI and OTD performance measurement.',
    `source_system` STRING COMMENT 'Operational system of record from which this settlement record originated. SAP S/4HANA Finance is the primary system for reserve accounting and payment processing; Salesforce CRM for claim case management. Used for data lineage and reconciliation.. Valid values are `SAP_S4HANA|SALESFORCE_CRM|MANUAL|LEGACY`',
    `subrogation_amount` DECIMAL(18,2) COMMENT 'Amount pursued or recovered through subrogation against a third-party carrier, vendor, or responsible party after Transport Shipping has paid the claimant. Distinct from insurer recovery; represents direct third-party liability recovery.',
    `subrogation_initiated_flag` BOOLEAN COMMENT 'Indicates whether a subrogation action has been initiated against a third-party carrier, vendor, or responsible party following payment of the settlement to the claimant.',
    `transport_mode` STRING COMMENT 'Mode of transport under which the cargo claim arose. Determines the applicable international liability convention and maximum compensation limits (e.g., IATA Warsaw-Montreal for air, Hague-Visby for ocean, CMR for road).. Valid values are `air|ocean|road|rail|multimodal`',
    CONSTRAINT pk_settlement PRIMARY KEY(`settlement_id`)
) COMMENT 'Transactional record capturing the financial settlement of a cargo claim. Records settlement amount, settlement currency, payment method, settlement date, credit note reference (linked to billing domain), reserve release amount, insurer recovery amount, and settlement acceptance status. Interfaces with SAP S/4HANA Finance for reserve accounting and billing for credit note issuance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Unique surrogate identifier for each claim status history record. Primary key of the claim_status_history entity.',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the parent cargo claim record for which this status transition is being recorded. Links each history entry to its owning claim.',
    `claim_party_id` BIGINT COMMENT 'Identifier of the specific individual or organizational unit responsible for actioning this status transition. References the workforce or party entity depending on responsible_party_type.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Claim status transitions may trigger or reference corrective actions (repeated claims from same facility trigger process improvements, high-value claims require preventive measures). Essential for con',
    `supplier_id` BIGINT COMMENT 'Identifier of the cargo insurer involved at this stage of the claim lifecycle. Populated when the transition involves insurer correspondence, liability determination, or settlement negotiation.',
    `surveyor_id` BIGINT COMMENT 'Identifier of the independent cargo surveyor or survey firm appointed to assess loss or damage at this stage of the claim lifecycle. Populated when responsible_party_type is SURVEYOR.',
    `awb_number` STRING COMMENT 'Air Waybill number associated with the shipment underlying this claim. Denormalized for audit trail completeness and to support regulatory reporting under IATA frameworks without requiring joins to the shipment domain.',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with the ocean or road shipment underlying this claim. Denormalized for audit trail completeness and regulatory reporting under IMO and CMR frameworks.',
    `claim_number` STRING COMMENT 'Externally-known business identifier of the cargo claim (e.g., CLM-2024-00012345). Denormalized here to support audit trail queries without joining to the parent claim table.. Valid values are `^CLM-[0-9]{4}-[0-9]{8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this claim status history record was first created in the system. Represents the audit creation timestamp, distinct from the business event transition_timestamp. Used for data lineage and audit trail compliance.',
    `credit_note_reference` STRING COMMENT 'Reference number of the credit note issued to the claimant as part of the settlement at this status transition. Links to the billing system credit note for financial reconciliation in SAP S/4HANA Finance.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the cargo claim involves dangerous goods, triggering additional regulatory handling requirements under IMDG Code or ICAO Technical Instructions. Affects claim processing procedures and liability frameworks.',
    `days_in_previous_status` STRING COMMENT 'Number of calendar days the claim remained in the from_status_code before transitioning. Calculated at the time of transition and stored for SLA monitoring, aging analysis, and claims processing efficiency KPIs.',
    `delay_claim_flag` BOOLEAN COMMENT 'Indicates whether this claim is a delay claim (as opposed to loss or damage), which has distinct liability limits and processing rules under the Warsaw-Montreal Convention and CMR Convention.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this status transition was triggered by or resulted in an escalation of the claim to a higher authority (e.g., senior claims manager, legal counsel, or executive review). Used for management reporting and SLA breach tracking.',
    `escalation_reason` STRING COMMENT 'Free-text description of the reason for escalation when escalation_flag is True. Documents the specific circumstances requiring senior review or intervention.',
    `from_status_code` STRING COMMENT 'The claim lifecycle status code immediately before this transition occurred (e.g., REGISTERED, UNDER_INVESTIGATION, SURVEY_COMMISSIONED, LIABILITY_DETERMINED, SETTLEMENT_OFFERED, SETTLED, REJECTED, SUBROGATED, CLOSED, WITHDRAWN). [ENUM-REF-CANDIDATE: REGISTERED|UNDER_INVESTIGATION|SURVEY_COMMISSIONED|LIABILITY_DETERMINED|SETTLEMENT_OFFERED|SETTLED|REJECTED|SUBROGATED|CLOSED|WITHDRAWN — promote to reference product]',
    `insurer_reference_number` STRING COMMENT 'The cargo insurers own reference or file number for this claim, as communicated during insurer correspondence. Used to cross-reference claim records between Transport Shipping and the insurers system.',
    `liability_convention_code` STRING COMMENT 'The international liability convention governing this claim at the time of this status transition (e.g., WARSAW_MONTREAL for air freight, CMR for road, HAGUE_VISBY for ocean, CIM for rail). Determines liability limits and procedural requirements.. Valid values are `WARSAW_MONTREAL|CMR|HAGUE_VISBY|CIM|DOMESTIC`',
    `liability_determination_code` STRING COMMENT 'The outcome of the liability assessment at this status transition (FULL_LIABILITY, PARTIAL_LIABILITY, NO_LIABILITY, SHARED_LIABILITY, PENDING). Populated when to_status_code is LIABILITY_DETERMINED. Governs settlement calculation and reserve accounting.. Valid values are `FULL_LIABILITY|PARTIAL_LIABILITY|NO_LIABILITY|SHARED_LIABILITY|PENDING`',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'The maximum monetary liability applicable to this claim under the governing convention or contract at the time of liability determination. Expressed in settlement_currency_code. Used for settlement calculation and reserve accounting in SAP S/4HANA Finance.',
    `notes` STRING COMMENT 'General free-text notes recorded by the claims handler at the time of this status transition. Captures additional context, instructions, or observations not covered by structured fields. Supports audit trail and claims review processes.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether this status transition triggers a mandatory regulatory notification obligation (e.g., dangerous goods incident reporting to IMO/IATA, customs authority notification under C-TPAT or AEO programs). Drives compliance workflow automation.',
    `regulatory_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the required regulatory notification has been dispatched following this status transition. Used in conjunction with regulatory_notification_required_flag to track compliance obligations and identify outstanding notifications.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'The financial reserve amount set aside in the general ledger for this claim at this status transition point. Updated at each significant status change (e.g., when liability is determined or settlement is offered). Feeds SAP S/4HANA Finance reserve accounting.',
    `responsible_party_name` STRING COMMENT 'Full name or organizational name of the party responsible for this status transition. Denormalized for audit trail completeness and regulatory reporting without requiring joins.',
    `responsible_party_type` STRING COMMENT 'Category of the party responsible for initiating or actioning this status transition (e.g., CLAIMS_HANDLER, SURVEYOR, INSURER, LEGAL_COUNSEL, CUSTOMER, SYSTEM for automated transitions).. Valid values are `CLAIMS_HANDLER|SURVEYOR|INSURER|LEGAL_COUNSEL|CUSTOMER|SYSTEM`',
    `settlement_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the settlement offer amount (e.g., USD, EUR, GBP). Applicable when settlement_offer_amount is populated.. Valid values are `^[A-Z]{3}$`',
    `settlement_offer_amount` DECIMAL(18,2) COMMENT 'The monetary value of the settlement offer made to the claimant at this status transition. Populated when to_status_code is SETTLEMENT_OFFERED. Expressed in the currency defined by settlement_currency_code.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the status transition occurred after the sla_target_resolution_date, constituting an SLA breach. True if the transition_timestamp exceeded the target date; False otherwise. Used for SLA KPI reporting and escalation tracking.',
    `sla_target_resolution_date` DATE COMMENT 'The contractual or regulatory target date by which the claim must be resolved or advanced to the next status, based on the applicable SLA for this claim type and transport mode. Used for SLA breach monitoring and KPI reporting.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record that originated this status transition record (e.g., SALESFORCE_CRM for customer-facing claim cases, SAP_S4HANA for finance-driven transitions, ORACLE_TMS for transport-triggered events, MANUAL for manually entered transitions).. Valid values are `SALESFORCE_CRM|SAP_S4HANA|ORACLE_TMS|MANUAL`',
    `source_system_transaction_reference` STRING COMMENT 'The unique transaction or record identifier from the originating operational system (e.g., Salesforce Case ID, SAP document number) that triggered this status transition. Enables traceability back to the system of record.',
    `subrogation_flag` BOOLEAN COMMENT 'Indicates whether this status transition initiates or is associated with a subrogation process, where Transport Shipping or the insurer pursues recovery from a third party responsible for the loss or damage.',
    `subrogation_reference_number` STRING COMMENT 'Reference number assigned to the subrogation recovery action initiated at this status transition. Populated when subrogation_flag is True and to_status_code is SUBROGATED.',
    `survey_reference_number` STRING COMMENT 'Reference number of the cargo survey report commissioned or received during this status transition. Applicable when to_status_code is SURVEY_COMMISSIONED or when survey findings trigger a transition. Links to the cargo survey report document.',
    `to_status_code` STRING COMMENT 'The claim lifecycle status code immediately after this transition occurred (e.g., REGISTERED, UNDER_INVESTIGATION, SURVEY_COMMISSIONED, LIABILITY_DETERMINED, SETTLEMENT_OFFERED, SETTLED, REJECTED, SUBROGATED, CLOSED, WITHDRAWN). This is the new current state of the claim following this event. [ENUM-REF-CANDIDATE: REGISTERED|UNDER_INVESTIGATION|SURVEY_COMMISSIONED|LIABILITY_DETERMINED|SETTLEMENT_OFFERED|SETTLED|REJECTED|SUBROGATED|CLOSED|WITHDRAWN — promote to reference product]',
    `transition_reason_code` STRING COMMENT 'Standardized reason code explaining why the status transition occurred (e.g., SURVEY_REQUESTED, DOCS_RECEIVED, LIABILITY_ACCEPTED, LIABILITY_DENIED, SETTLEMENT_AGREED, INSURER_DECLINED, SUBROGATION_INITIATED, CLAIMANT_WITHDREW). [ENUM-REF-CANDIDATE: SURVEY_REQUESTED|DOCS_RECEIVED|LIABILITY_ACCEPTED|LIABILITY_DENIED|SETTLEMENT_AGREED|INSURER_DECLINED|SUBROGATION_INITIATED|CLAIMANT_WITHDREW — promote to reference product]',
    `transition_reason_description` STRING COMMENT 'Free-text narrative providing additional context or explanation for the status transition, supplementing the structured transition_reason_code. Used by claims handlers to document specific circumstances, exceptions, or instructions.',
    `transition_timestamp` TIMESTAMP COMMENT 'The exact date and time (with timezone offset) at which the claim status transitioned from the from_status_code to the to_status_code. This is the principal business event time for this history record and is used for SLA monitoring and regulatory audit trails.',
    `transport_mode` STRING COMMENT 'Mode of transport associated with the underlying cargo claim (AIR, OCEAN, ROAD, RAIL, MULTIMODAL). Determines the applicable liability convention (e.g., Warsaw-Montreal for air, CMR for road, Hague-Visby for ocean).. Valid values are `AIR|OCEAN|ROAD|RAIL|MULTIMODAL`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this claim status history record was last modified. Supports data lineage tracking and identifies records that have been amended post-creation (e.g., corrections to reason codes or notes).',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Lifecycle tracking entity recording every status transition of a cargo claim from registration through closure. Captures status code, transition timestamp, responsible party, reason code, and notes for each state change (e.g., Registered → Under Investigation → Survey Commissioned → Liability Determined → Settlement Offered → Settled/Rejected/Subrogated). Enables SLA monitoring and regulatory audit trails.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` (
    `subrogation_case_id` BIGINT COMMENT 'Unique system-generated identifier for the subrogation case record. Primary key for the subrogation_case data product within the claim domain.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Recovery actions cite contractual liability allocation and subrogation rights. Legal teams need contract terms to pursue third-party recovery, establish limitation periods, and determine whether subro',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Air cargo subrogation requires AWB reference to identify liable carrier and apply liability limits. Replaces denormalized awb_number with proper FK for carrier identification, Montreal Convention enfo',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Ocean cargo subrogation requires B/L reference to identify liable carrier and apply liability limits. Replaces denormalized bol_number with proper FK for carrier identification, Hague-Visby rules enfo',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Subrogation may reference booking when contractual breach occurs pre-shipment (space confirmation failure causing consequential loss). Supports booking-level recovery action and pre-shipment contractu',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the originating cargo claim record that triggered this subrogation case. Links the subrogation recovery process back to the settled claim.',
    `cargo_survey_id` BIGINT COMMENT 'Foreign key linking to claim.cargo_survey. Business justification: Subrogation case references the cargo survey report as primary evidence for recovery pursuit. N:1 relationship (many subrogation cases per survey, though typically 1:1). Adding cargo_survey_id FK allo',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Subrogation cases primarily target carriers as respondent parties for recovery; carrier identification is essential for legal proceedings, demand letters, arbitration, and recovery tracking. Required ',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Recovery income and legal costs require specific GL account assignment for P&L classification, financial statement presentation, and proper matching of recovery revenue with original claim expense.',
    `claim_party_id` BIGINT COMMENT 'Reference to the third-party entity against whom subrogation recovery is being pursued — may be a sub-carrier, port operator, customs authority, freight handler, or warehouse operator.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Subrogation recoveries are posted as income to a legal entity and require GL posting for revenue recognition, financial statement preparation, and intercompany reconciliation. Required for audit trail',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment record associated with the cargo loss event underlying this subrogation case. Links to shipment tracking and transport documentation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Legal costs and recovery administration costs must be allocated to cost centers for budget tracking, variance analysis, and cost management. Enables monitoring of subrogation program efficiency.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Subrogation cases involve customer accounts as beneficiaries of recovery actions. Enables customer-level recovery tracking, financial reporting of subrogation proceeds, and customer communication on r',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Subrogation recovery actions require customs declarations to prove cargo value, establish duty paid (recoverable in total loss), and verify customs compliance status of the liable party. Critical evid',
    `employee_id` BIGINT COMMENT 'Name or employee identifier of the internal claims handler or subrogation specialist responsible for managing this case within the claims department.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Subrogation recovery actions against third parties (equipment suppliers, contractors, carriers) for warehouse incidents require facility context for evidence documentation, jurisdiction determination,',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Subrogation cases pursue recovery against carriers/parties responsible for specific freight orders. Essential for identifying liable carrier, calculating recovery amount based on freight charges, and ',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Subrogation recovery actions against third parties often stem from HSE incidents (contractor negligence causing injury and cargo damage, equipment supplier fault). Legal teams require HSE incident evi',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Subrogation recovery actions against carriers cite lane-specific contract terms, service level agreements, and liability caps. Legal teams need lane reference to identify applicable carrier agreement,',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to claim.claim_settlement. Business justification: Subrogation case is initiated after the insurer/carrier settles the claim with the claimant. 1:1 or N:1 relationship (one subrogation case per settlement). Adding claim_settlement_id FK allows normali',
    `supplier_id` BIGINT COMMENT 'Reference to the insurer or underwriter who settled the original cargo claim and is now the subrogating party pursuing recovery from the liable third party.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Demand letters are formal legal documents initiating subrogation recovery. Legal teams track demand_letter_date but need the actual document for statute of limitations proof, arbitration filings, and ',
    `arbitration_body` STRING COMMENT 'Name of the arbitration institution or tribunal handling the subrogation dispute (e.g., ICC International Court of Arbitration, LMAA, AAA). Populated when case_status is arbitration.',
    `case_notes` STRING COMMENT 'Free-text field capturing key case developments, negotiation positions, legal strategy notes, and correspondence summaries maintained by the assigned claims handler.',
    `case_reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the subrogation case, used in all correspondence with insurers, legal counsel, and third-party respondents. Format: SUB-YYYY-NNNNNN.. Valid values are `^SUB-[0-9]{4}-[0-9]{6}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the subrogation case. Tracks progression from initial opening through demand, negotiation, legal or arbitration proceedings, to final closure. [ENUM-REF-CANDIDATE: open|demand_issued|negotiation|legal_proceedings|arbitration|settled|closed_recovered|closed_unrecovered|withdrawn — promote to reference product]',
    `case_type` STRING COMMENT 'Classification of the subrogation case by the nature of the underlying loss event. Determines applicable liability convention and recovery strategy. [ENUM-REF-CANDIDATE: cargo_loss|cargo_damage|delay|dangerous_goods|misdelivery|theft|contamination — promote to reference product]',
    `closure_date` DATE COMMENT 'Date on which the subrogation case was formally closed, either following successful recovery, settlement, exhaustion of legal remedies, or commercial decision to withdraw.',
    `closure_reason` STRING COMMENT 'Reason for closing the subrogation case. Captures the outcome basis for recovery P&L analysis and third-party liability management reporting. [ENUM-REF-CANDIDATE: full_recovery|partial_recovery|settlement|statute_barred|respondent_insolvent|commercial_decision|unenforceable|withdrawn — promote to reference product]',
    `court_jurisdiction` STRING COMMENT 'Legal jurisdiction (country and court) in which legal proceedings have been or will be filed against the respondent party. Determined by applicable liability convention and contract terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subrogation case record was first created in the system. Audit trail field aligned to SOX and GDPR record-keeping requirements.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the cargo involved in the underlying loss event was classified as dangerous goods under IMDG Code or ICAO Technical Instructions. Triggers specialized liability assessment and regulatory reporting.',
    `dangerous_goods_un_number` STRING COMMENT 'United Nations dangerous goods identification number for the hazardous cargo involved in the loss event. Populated only when dangerous_goods_flag is true.. Valid values are `^UN[0-9]{4}$`',
    `demand_letter_date` DATE COMMENT 'Date on which the formal demand letter was issued to the respondent party requesting recovery of the subrogation amount. Marks the formal commencement of the recovery action.',
    `external_legal_counsel` STRING COMMENT 'Name of the external law firm or legal counsel engaged to pursue the subrogation recovery action on behalf of the insurer or carrier.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) applicable to the underlying shipment, determining the point of risk transfer between buyer and seller and influencing liability attribution in the subrogation case. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the subrogation case record. Used for change tracking, audit compliance, and incremental data pipeline processing in the Databricks Silver Layer.',
    `legal_costs_incurred` DECIMAL(18,2) COMMENT 'Cumulative legal and professional fees incurred in pursuing the subrogation recovery, including attorney fees, court filing fees, expert witness costs, and arbitration fees. Used in recovery P&L tracking.',
    `legal_filing_date` DATE COMMENT 'Date on which legal proceedings were formally filed against the respondent party in the competent court or arbitration tribunal. Relevant for statute of limitations compliance tracking.',
    `liability_convention` STRING COMMENT 'International liability convention or legal framework governing the subrogation recovery rights and liability limits for this case. Determines maximum recoverable amounts and burden of proof.. Valid values are `CMR|Warsaw_Montreal|Hague_Visby|Hamburg_Rules|COTIF_CIM|domestic`',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount applicable to the respondent under the governing international convention (e.g., SDR per kg under CMR, SDR per kg under Hague-Visby). Constrains the maximum recoverable amount.',
    `loss_event_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the cargo loss or damage event occurred. Used for jurisdictional determination and applicable liability convention selection.. Valid values are `^[A-Z]{3}$`',
    `loss_event_date` DATE COMMENT 'Date on which the cargo loss, damage, delay, or other qualifying event occurred that gave rise to the original claim and subsequent subrogation right.',
    `loss_event_location` STRING COMMENT 'Geographic location (port, terminal, warehouse, road segment, airport) where the cargo loss or damage event occurred. Determines jurisdiction and applicable liability convention.',
    `opened_date` DATE COMMENT 'Calendar date on which the subrogation case was formally opened following settlement of the originating cargo claim. Marks the start of the recovery pursuit period.',
    `recovery_amount_received` DECIMAL(18,2) COMMENT 'Actual monetary amount recovered from the respondent party to date. Populated incrementally as payments are received and updated upon final case closure.',
    `recovery_amount_sought` DECIMAL(18,2) COMMENT 'Total monetary amount being demanded from the respondent party in the subrogation recovery action. May differ from the settlement amount due to contributory negligence, liability caps, or partial recovery strategy.',
    `recovery_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which recovery amounts are denominated and tracked for this subrogation case.. Valid values are `^[A-Z]{3}$`',
    `recovery_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of the recovery amount sought that was actually recovered from the respondent party. Calculated as (recovery_amount_received / recovery_amount_sought) * 100. Key KPI for subrogation P&L performance tracking.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'Financial reserve amount set aside in the general ledger for the expected net recovery from this subrogation case. Used for reserve accounting and financial reporting under IFRS.',
    `respondent_insurer_name` STRING COMMENT 'Name of the respondent partys liability insurer, if known. Relevant when recovery is pursued against the respondents insurance policy rather than directly against the respondent.',
    `respondent_insurer_policy_number` STRING COMMENT 'Policy number of the respondent partys liability insurance policy against which the subrogation recovery is being pursued.',
    `respondent_party_type` STRING COMMENT 'Classification of the liable third-party respondent against whom recovery is sought. Determines applicable liability framework and legal jurisdiction. [ENUM-REF-CANDIDATE: sub_carrier|port_operator|customs_authority|freight_handler|warehouse_operator|nvocc|terminal_operator — promote to reference product]',
    `respondent_response_date` DATE COMMENT 'Date on which the respondent party formally responded to the subrogation demand letter, either accepting, partially accepting, or disputing liability.',
    `settlement_date` DATE COMMENT 'Date on which a negotiated settlement agreement was reached with the respondent party, resolving the subrogation recovery action without full legal proceedings.',
    `statute_of_limitations_date` DATE COMMENT 'Date by which legal action must be commenced against the respondent party under the applicable liability convention or domestic law. Critical for case management and legal filing deadlines.',
    `transport_mode` STRING COMMENT 'Mode of transport applicable to the underlying cargo loss event, determining which international liability convention governs the subrogation claim (e.g., Warsaw-Montreal for air, CMR for road, Hague-Visby for ocean).. Valid values are `air|ocean|road|rail|multimodal`',
    CONSTRAINT pk_subrogation_case PRIMARY KEY(`subrogation_case_id`)
) COMMENT 'Master record managing the subrogation process where the insurer or carrier pursues recovery from a liable third party (sub-carrier, port operator, customs authority, freight handler) after settling a cargo claim. Captures subrogation target party, recovery amount sought, legal proceedings status, and case closure outcome. Includes individual recovery action tracking: demand letters, legal filings, arbitration proceedings, settlement negotiations, amounts demanded vs. recovered, and action outcomes. Aligned to international subrogation rights under CMR, Warsaw-Montreal, Hague-Visby, and marine insurance law. Supports recovery P&L tracking and third-party liability management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`claim_document` (
    `claim_document_id` BIGINT COMMENT 'Unique surrogate identifier for each document or formal correspondence record attached to a cargo claim file in the Transport Shipping claims management system.',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Air cargo claim documents must reference AWB for transport document verification. Replaces denormalized awb_number with proper FK for linking POD, damage reports, and survey photos to air waybill.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Ocean cargo claim documents must reference B/L for transport document verification. Replaces denormalized bol_number with proper FK for linking POD, damage reports, and survey photos to bill of lading',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Claim documents may reference booking confirmation for pre-shipment disputes (booking confirmation emails, rate quotes, space rejection notices). Supports booking-level evidence management and pre-shi',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the parent cargo claim record to which this document belongs. Links the document to its claim file for completeness tracking and liability determination.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Claim documents are submitted by/to customer accounts (POD, invoices, packing lists). Enables customer-specific document management, compliance tracking, and customer portal access control. Critical f',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Claims documentation routinely includes customs declarations as supporting evidence. Essential for validating declared values, verifying HS codes, establishing cargo legitimacy in fraud investigations',
    `dg_incident_id` BIGINT COMMENT 'Foreign key linking to safety.dg_incident. Business justification: Claims involving dangerous goods require DG incident reports as mandatory documentation for regulatory compliance (IATA, IMO, DOT), liability assessment under hazmat conventions, and insurer notificat',
    `employee_id` BIGINT COMMENT 'Name or identifier of the claims handler or analyst who reviewed and assessed this document. Provides accountability and audit trail for document acceptance or rejection decisions.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Claim documents (POD, packing lists, commercial invoices, photos) are submitted per freight order. Essential for linking supporting evidence to shipment, verifying cargo value, and substantiating dama',
    `surveyor_id` BIGINT COMMENT 'Foreign key linking to claim.surveyor. Business justification: Claim documents may be issued by or related to a specific surveyor (e.g., survey reports, surveyor correspondence). N:1 relationship (many documents per surveyor). Adding surveyor_id FK allows normali',
    `communication_channel` STRING COMMENT 'Channel through which the document was transmitted or received. Captures whether the document arrived via EDI (Electronic Data Interchange), email, carrier portal, postal mail, fax, or API integration. Supports audit trail and SLA measurement.. Valid values are `email|edi|portal|post|fax|api`',
    `country_of_origin_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the document was issued or originated. Relevant for customs declarations, certificates of origin, and cross-border claim regulatory compliance under WCO and trade compliance frameworks.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this claim document record was first created in the system. Serves as the audit creation timestamp for data lineage, SOX compliance, and Silver layer ingestion tracking.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Monetary value declared on the document (e.g., commercial invoice value, declared cargo value on AWB or BOL). Used as the basis for liability calculation and settlement offer determination under applicable liability conventions.',
    `declared_value_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the declared value amount on the document (e.g., USD, EUR, GBP). Required for multi-currency claim settlement calculations and financial reporting under IFRS.. Valid values are `^[A-Z]{3}$`',
    `direction` STRING COMMENT 'Indicates whether the document was received by Transport Shipping (inbound) or sent by Transport Shipping to an external party (outbound). Distinguishes correspondence flow for insurer SLA compliance and claim file completeness checks.. Valid values are `inbound|outbound`',
    `document_category` STRING COMMENT 'High-level grouping of the document type for claim file organisation and regulatory compliance reporting. Enables structured retrieval of document sets required by IATA, IMO, and WCO frameworks.. Valid values are `supporting_evidence|legal_correspondence|transport_document|customs_document|financial_document|survey_report`',
    `document_date` DATE COMMENT 'The official date printed or stated on the document itself (e.g., invoice date, survey report date, AWB issue date). Distinct from upload or received timestamps; represents the documents own declared date for legal and regulatory validity.',
    `document_description` STRING COMMENT 'Free-text description of the document content, purpose, or any relevant notes about the documents role in the claim file. Provides context for claim handlers and insurers reviewing the document.',
    `document_number` STRING COMMENT 'Externally-known unique reference number or identifier assigned to the document (e.g., AWB number, BOL number, invoice number, survey report reference). Serves as the business-facing identifier for the document within the claim file.',
    `document_source` STRING COMMENT 'Originating party or system that provided or generated the document. Identifies whether the document was submitted by the claimant, insurer, carrier, customs authority, independent surveyor, or generated internally. Used for chain-of-custody tracking. [ENUM-REF-CANDIDATE: claimant|insurer|carrier|customs_authority|surveyor|internal|third_party — 7 candidates stripped; promote to reference product]',
    `document_status` STRING COMMENT 'Current lifecycle state of the document within the claim file. Tracks whether the document has been received, reviewed, accepted as valid evidence, rejected, or superseded by a newer version. Drives insurer SLA compliance monitoring.. Valid values are `pending|received|under_review|accepted|rejected|superseded`',
    `document_type` STRING COMMENT 'Classification of the document attached to the claim file. Identifies the nature and purpose of the document within the claims process. [ENUM-REF-CANDIDATE: awb|bol|commercial_invoice|packing_list|survey_report|photo_evidence|epod|customs_declaration|dangerous_goods_manifest|insurer_correspondence|demand_letter|settlement_offer|claim_form|certificate_of_origin|delivery_receipt — promote to reference product]',
    `file_format` STRING COMMENT 'File format or MIME type of the stored document. Determines rendering capability and archival requirements. EDI and XML formats indicate structured electronic documents; PDF/image formats indicate scanned or photographed evidence. [ENUM-REF-CANDIDATE: pdf|jpeg|png|tiff|xlsx|docx|xml|edi — 8 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'Original file name of the uploaded document as provided by the submitting party. Preserves the source file identity for audit trail and document retrieval purposes.',
    `file_size_kb` STRING COMMENT 'Size of the document file in kilobytes. Used for storage management, upload validation, and ensuring document completeness (e.g., detecting empty or corrupt uploads).',
    `hawb_number` STRING COMMENT 'House Air Waybill number issued by the freight forwarder or NVOCC for the specific consignment within a consolidated air shipment. Distinguishes individual shipper consignments within a master consolidation for claim document traceability.',
    `hbl_number` STRING COMMENT 'House Bill of Lading number issued by the freight forwarder or NVOCC for the specific consignment within a consolidated ocean shipment. Used to trace claim documents to individual shipper consignments within LCL (Less Than Container Load) shipments.',
    `hs_code` STRING COMMENT 'Harmonized System commodity classification code for the cargo described in the document. Required for customs declarations and dangerous goods manifests. Enables tariff classification verification and trade compliance under WCO Harmonized System Convention.. Valid values are `^[0-9]{6,10}$`',
    `insurer_reference` STRING COMMENT 'Reference number assigned by the cargo insurer to this document or correspondence. Enables cross-referencing between Transport Shippings claim file and the insurers own claim management system for settlement negotiations.',
    `is_dangerous_goods` BOOLEAN COMMENT 'Indicates whether this document relates to a dangerous goods shipment claim. When True, additional regulatory requirements apply under IMDG Code (ocean), ICAO Technical Instructions (air), or ADR (road). Triggers dangerous goods claims handling workflow.',
    `is_latest_version` BOOLEAN COMMENT 'Indicates whether this document record represents the most current version of the document. Set to True for the active version and False for superseded versions. Prevents use of outdated documents in claim settlement calculations.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this document type is mandatory for the claim file to be considered complete under applicable regulatory or insurer requirements (e.g., AWB is mandatory for air claims under IATA, BOL for ocean claims under IMO). Drives claim file completeness validation.',
    `issuing_authority` STRING COMMENT 'Name of the authority, organisation, or party that officially issued or certified the document (e.g., customs authority, classification society, independent surveyor firm, insurer). Validates document authenticity for liability determination.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code of the document (e.g., EN, FR, DE, ZH). Determines whether translation is required for regulatory submission or insurer review. Relevant for cross-border claims under WCO and customs authority requirements.. Valid values are `^[A-Z]{2}$`',
    `page_count` STRING COMMENT 'Total number of pages in the document. Used to verify document completeness and detect partial uploads. Particularly relevant for multi-page survey reports, customs declarations, and dangerous goods manifests.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the document was received by Transport Shipping. Applicable for inbound documents. Critical for calculating claim notification deadlines and insurer SLA compliance under IATA Warsaw-Montreal Convention and CMR Convention.',
    `rejection_reason` STRING COMMENT 'Reason for rejecting the document when document_status is rejected. Captures why the document was deemed invalid or insufficient (e.g., illegible scan, missing signature, expired document, incorrect format). Required for claimant notification and resubmission guidance.',
    `response_due_date` DATE COMMENT 'Deadline by which a response to this document is required, based on applicable SLA or regulatory timeframe (e.g., insurer acknowledgement deadline, claimant response window under IATA or CMR Convention). Drives SLA compliance monitoring and escalation workflows.',
    `response_received_date` DATE COMMENT 'Actual date on which a response to this document was received. Compared against response_due_date to determine SLA compliance and insurer response performance.',
    `response_status` STRING COMMENT 'Current status of the expected response to this document. Tracks whether a reply is pending, has been received, is not required, or is overdue. Supports insurer SLA compliance reporting and claim escalation management.. Valid values are `awaiting_response|response_received|no_response_required|overdue`',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the document was reviewed by the claims handler. Used to measure internal processing time and SLA compliance for document review workflows.',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time when the document was dispatched by the sending party. Applicable for outbound documents. Used to measure insurer SLA response times and regulatory submission deadlines under IATA and IMO frameworks.',
    `storage_reference` STRING COMMENT 'Physical or digital storage location reference for the document file (e.g., object storage path, document management system URI, DMS folder reference). Enables retrieval of the actual document from the underlying storage system for claim review and regulatory audit.',
    `transport_mode` STRING COMMENT 'Mode of transport associated with the claim document, determining the applicable liability convention (IATA Warsaw-Montreal for air, CMR Convention for road, Hague-Visby Rules for ocean, CIM Convention for rail). Critical for regulatory compliance and liability framework selection.. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this claim document record was last modified. Tracks the most recent update to the document record for audit trail, data lineage, and change management purposes.',
    `upload_timestamp` TIMESTAMP COMMENT 'Date and time when the document was uploaded or ingested into the claims management system. Distinct from received_timestamp; captures the system ingestion event for audit trail and data lineage purposes.',
    `version_number` STRING COMMENT 'Sequential version number of the document, incremented when a revised or amended version is submitted. Enables tracking of document amendments throughout the claim lifecycle and ensures the latest version is used for liability determination.',
    CONSTRAINT pk_claim_document PRIMARY KEY(`claim_document_id`)
) COMMENT 'Master record cataloguing all documents and formal correspondence attached to a cargo claim file. Captures document type (AWB, BOL, commercial invoice, packing list, survey report, photos, ePOD, customs declaration, dangerous goods manifest, insurer correspondence, demand letters, settlement offers), document source, communication channel, sent/received timestamp, response status, upload timestamp, document status, and storage reference. Ensures claim file completeness for liability determination, insurer SLA compliance, and regulatory compliance under IATA, IMO, and WCO requirements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`reserve` (
    `reserve_id` BIGINT COMMENT 'Unique surrogate identifier for the claim reserve record in the Transport Shipping lakehouse. Primary key for the claim_reserve data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Reserve amounts are set based on contractual liability caps and coverage terms. Risk management requires contract reference to ensure reserves do not exceed maximum contractual exposure and to assess ',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the parent cargo claim record for which this financial reserve has been established. Links the reserve to the claim lifecycle in the claim domain.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Reserves are established based on carrier liability exposure; reserve adequacy reviews require carrier risk assessment. Essential for carrier-specific reserve management, financial provisioning, and c',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Reserve posting requires specific GL account assignment (provision accounts, accrual accounts) for proper balance sheet classification, financial statement presentation, and compliance with accounting',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Reserves are financial liabilities posted to GL and must belong to a legal entity for balance sheet reporting, SOX compliance, and financial statement preparation. Required for audit and regulatory re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reserve establishment impacts cost center budgets and requires allocation for management reporting, budget control, and variance analysis. Enables tracking of reserve adequacy by organizational unit.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Reserves are established per customer account for financial planning and credit risk management. Enables customer-level reserve reporting, credit exposure analysis, and customer financial health monit',
    `employee_id` BIGINT COMMENT 'Name or employee identifier of the claims finance analyst or manager who conducted the most recent reserve adequacy review. Supports SOX audit trail and segregation of duties requirements.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Reserves must be established and adjusted within specific fiscal periods for period-end close, financial reporting, and audit trail. Required for tracking reserve movements and ensuring period cutoff ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to claim.claim_policy. Business justification: Financial reserve is established under a specific insurance policy for liability exposure tracking. N:1 relationship (many reserves per policy). Adding claim_policy_id FK allows normalization of polic',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Reserves reduce profit center performance and must be tracked for EBITDA reporting, profitability forecasting, and segment performance measurement. Critical for management decision-making.',
    `supplier_id` BIGINT COMMENT 'Reference to the cargo insurer or underwriter responsible for covering the claim liability. Used for insurer correspondence tracking and subrogation recovery workflows.',
    `adequacy_review_date` DATE COMMENT 'Date of the most recent periodic reserve adequacy review conducted by the claims finance team. IAS 37 requires reserves to be reviewed at each reporting date and adjusted to reflect the current best estimate.',
    `approval_date` DATE COMMENT 'Date on which the reserve establishment or most recent material adjustment was formally approved by the authorized approver. Part of the SOX-compliant financial control audit trail.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the authorized approver who sanctioned the reserve establishment or most recent material adjustment. Required for SOX segregation of duties and financial control compliance.',
    `claim_type` STRING COMMENT 'Category of the underlying cargo claim driving this reserve. Determines applicable liability convention (IATA Warsaw-Montreal, CMR, IMO) and maximum reserve ceiling. [ENUM-REF-CANDIDATE: cargo_loss|cargo_damage|delay|shortage|misdelivery|dangerous_goods — promote to reference product]. Valid values are `cargo_loss|cargo_damage|delay|shortage|misdelivery|dangerous_goods`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the claim reserve record was first created in the Transport Shipping lakehouse. Supports audit trail, SOX compliance, and data lineage tracking.',
    `currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the reserve amounts are denominated (e.g., USD, EUR, GBP). Required for multi-currency balance sheet consolidation under IFRS.. Valid values are `^[A-Z]{3}$`',
    `current_reserve_amount` DECIMAL(18,2) COMMENT 'Most recent reserve balance after all adjustments (increases and decreases). Reflects the current best estimate of outstanding liability exposure on the balance sheet. Updated with each reserve adjustment posting in SAP S/4HANA Finance.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the underlying claim involves dangerous goods cargo. Triggers enhanced reserve assessment procedures and compliance checks under IMDG Code and ICAO Technical Instructions.',
    `days_reserve_open` STRING COMMENT 'Number of calendar days the reserve has been open since establishment_date. Used in reserve aging reports and KPI dashboards to identify long-outstanding reserves requiring management escalation.',
    `establishment_date` DATE COMMENT 'Calendar date on which the financial reserve was first established in SAP S/4HANA Finance. Used as the IAS 37 provision recognition date for balance sheet reporting and SOX-compliant financial close.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to translate reserve_currency amounts into functional_currency_amount at the reporting date. Sourced from SAP S/4HANA Finance exchange rate tables.',
    `expected_settlement_date` DATE COMMENT 'Estimated date by which the underlying claim is expected to be settled and the reserve released. Used for cash flow forecasting, reserve aging analysis, and IFRS 37 disclosure of timing of outflows.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Current reserve amount translated into the entitys functional currency using the closing exchange rate at the reporting date. Required for IFRS consolidated financial statements and SOX reporting.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the entitys functional currency used in IFRS consolidated reporting (e.g., USD). Paired with functional_currency_amount.. Valid values are `^[A-Z]{3}$`',
    `initial_reserve_amount` DECIMAL(18,2) COMMENT 'Original estimated liability exposure amount posted to the balance sheet at reserve establishment. Represents the best estimate of the probable outflow of economic resources as required by IAS 37. Denominated in reserve_currency.',
    `insurer_notification_date` DATE COMMENT 'Date on which the insurer was formally notified of the claim and reserve. Used to track compliance with policy notification deadlines and manage insurer correspondence timelines.',
    `insurer_notified` BOOLEAN COMMENT 'Indicates whether the insurer has been formally notified of the claim and reserve establishment. Required for compliance with policy notification obligations and IFRS 17 insurance contract accounting.',
    `last_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of the most recent reserve adjustment. Positive values indicate a reserve increase (strengthening); negative values indicate a reserve decrease (release). Denominated in reserve_currency.',
    `last_adjustment_date` DATE COMMENT 'Date of the most recent reserve adjustment (increase or decrease). Used to identify stale reserves requiring review during monthly reserve adequacy assessments.',
    `last_adjustment_reason_code` STRING COMMENT 'Standardized reason code explaining the basis for the most recent reserve adjustment. Supports audit trail requirements and reserve movement analysis. [ENUM-REF-CANDIDATE: new_evidence|survey_update|legal_development|settlement_negotiation|subrogation_recovery|reserve_adequacy_review — promote to reference product]. Valid values are `new_evidence|survey_update|legal_development|settlement_negotiation|subrogation_recovery|reserve_adequacy_review`',
    `liability_convention` STRING COMMENT 'International liability convention governing the maximum reserve ceiling for this claim. Determines the per-kg or per-SDR liability cap applied during reserve calculation. [ENUM-REF-CANDIDATE: warsaw_montreal|cmr|hague_visby|cotif_cim|imdg|domestic — promote to reference product]. Valid values are `warsaw_montreal|cmr|hague_visby|cotif_cim|imdg|domestic`',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Maximum liability exposure ceiling calculated under the applicable liability convention (e.g., SDR per kg under Warsaw-Montreal, SDR per package under Hague-Visby). Reserve cannot exceed this amount. Denominated in reserve_currency.',
    `notes` STRING COMMENT 'Free-text narrative providing additional context for the reserve establishment, adjustment, or release. May include cargo survey findings, legal counsel opinions, or negotiation status relevant to reserve adequacy.',
    `release_amount` DECIMAL(18,2) COMMENT 'Amount released from the reserve upon settlement or closure. May be a partial or full release. Denominated in reserve_currency. Reconciled against settlement_amount in the claim record.',
    `release_date` DATE COMMENT 'Date on which the reserve was fully or partially released upon claim settlement, withdrawal, or closure. Triggers the corresponding SAP S/4HANA Finance reversal posting.',
    `release_reason` STRING COMMENT 'Reason for releasing the reserve. Supports audit trail and reserve movement reporting. [ENUM-REF-CANDIDATE: claim_settled|claim_withdrawn|claim_denied|subrogation_recovered|statute_expired|management_decision — promote to reference product]. Valid values are `claim_settled|claim_withdrawn|claim_denied|subrogation_recovered|statute_expired|management_decision`',
    `reserve_number` STRING COMMENT 'Externally-known business identifier for the reserve record, assigned at the time of reserve establishment. Used in insurer correspondence, SAP S/4HANA Finance postings, and audit trails. Format: RES-{YYYY}-{8-digit sequence}.. Valid values are `^RES-[0-9]{4}-[0-9]{8}$`',
    `reserve_status` STRING COMMENT 'Current lifecycle state of the claim reserve. Drives IFRS 17/IAS 37 provisioning workflows and monthly reserve adequacy reviews. [ENUM-REF-CANDIDATE: open|adjusted|partially_released|fully_released|closed|cancelled — promote to reference product]. Valid values are `open|adjusted|partially_released|fully_released|closed|cancelled`',
    `reserve_type` STRING COMMENT 'Classification of the reserve by its business purpose. Initial reserves are established at claim registration; supplemental reserves are created for additional exposure; subrogation reserves track recoverable amounts; salvage reserves reflect recoverable cargo value; litigation reserves cover legal proceedings.. Valid values are `initial|supplemental|subrogation|salvage|litigation`',
    `sap_document_number` STRING COMMENT 'SAP S/4HANA Finance accounting document number generated when the reserve provision was posted. Provides the audit trail linkage between the claim reserve record and the financial ledger entry.',
    `subrogation_potential` BOOLEAN COMMENT 'Indicates whether the claim has identified subrogation recovery potential (i.e., the right to recover paid amounts from a liable third party such as a carrier or supplier). Triggers subrogation workflow initiation.',
    `subrogation_recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered or expected to be recovered through subrogation from a liable third party. Reduces the net reserve exposure. Denominated in reserve_currency.',
    `total_adjustments_amount` DECIMAL(18,2) COMMENT 'Cumulative net amount of all reserve adjustments since establishment (sum of all increases and decreases). Denominated in reserve_currency. Supports reserve movement waterfall reporting.',
    `transport_mode` STRING COMMENT 'Mode of transport associated with the underlying claim. Determines the applicable liability convention and maximum reserve ceiling (e.g., IATA for air, CMR for road, Hague-Visby for ocean).. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the claim reserve record. Used for incremental data pipeline processing, audit trail, and SOX change management compliance.',
    CONSTRAINT pk_reserve PRIMARY KEY(`reserve_id`)
) COMMENT 'Financial reserve record established for an open cargo claim representing estimated liability exposure on the balance sheet. Captures initial reserve amount, reserve currency, reserve establishment date, periodic reserve adjustments (increases/decreases with reason codes), reserve release date and amount upon settlement, and linkage to finance domain cost center and GL account. Required for IFRS 17/IAS 37 provisioning compliance, SOX-compliant financial reporting, and monthly reserve adequacy reviews. Interfaces with SAP S/4HANA Finance for automated reserve posting and release.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`line` (
    `line_id` BIGINT COMMENT 'Unique surrogate identifier for each claim line record within the cargo claims management system. Primary key for the claim_line data product in the Silver Layer lakehouse.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Line-item liability assessment references contract commodity coverage, per-unit liability limits, and incoterms. Claims handlers need contract terms to determine whether specific commodities are cover',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Air cargo claim lines must reference AWB for piece-level damage assessment. Replaces denormalized awb_number with proper FK for piece count verification, weight comparison, and line-level liability ca',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Ocean cargo claim lines must reference B/L for container/package-level damage assessment. Replaces denormalized bol_number with proper FK for package count verification, weight comparison, and line-le',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Claim lines may reference booking for pre-shipment cargo condition disputes (cargo refused at origin, pre-shipment damage). Supports line-level pre-shipment damage assessment and booking-level cargo c',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the parent cargo claim header record. Establishes the header-to-line relationship linking this line item to its governing claim event, claimant, and liability determination. Mandatory HEADER_REFERENCE per TRANSACTION_LINE role.',
    `cargo_survey_id` BIGINT COMMENT 'Foreign key linking to claim.cargo_survey. Business justification: Individual claim line items may reference specific survey findings that assessed damage to that particular commodity/SKU. N:1 relationship (many line items per survey). Adding cargo_survey_id FK allow',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment record against which this claim line is raised. Links the damaged or lost cargo line to the originating transport movement for liability and subrogation analysis.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Claim lines track customer-specific cargo items and SKUs. Enables SKU-level claim analysis per customer, customer product risk profiling, and customer-specific packaging/handling recommendations. Crit',
    `declaration_line_id` BIGINT COMMENT 'Foreign key linking to customs.declaration_line. Business justification: Line-level claims need line-level customs data to match specific commodities, verify per-item declared values (liability caps per package/unit), and validate HS codes. Essential for multi-commodity sh',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Claim lines itemize damaged/lost cargo from specific freight orders. Essential for line-level damage assessment, SKU-level loss calculation, and linking claimed items to original shipment manifest for',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Individual claim lines (damaged SKUs) are analyzed by lane for loss-ratio reporting, carrier scorecarding, and commodity-specific risk assessment. Enables lane-level profitability analysis adjusted fo',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to fulfillment.order_line. Business justification: Claims are filed against specific order line items (SKU-level damage, quantity discrepancies, wrong item shipped). Finance and operations need line-item traceability for accurate settlement calculatio',
    `approved_quantity` DECIMAL(18,2) COMMENT 'Quantity approved by the claims assessor following survey and investigation. May differ from claimed_quantity where partial loss or damage is confirmed. Used in settlement calculation.',
    `approved_value` DECIMAL(18,2) COMMENT 'Monetary value approved for settlement on this line item following assessment, survey, and liability determination. May be less than claimed_value due to liability caps, depreciation, or partial loss findings.',
    `claim_filing_date` DATE COMMENT 'Date on which this claim line was formally filed with the carrier or insurer. Used to assess compliance with statutory filing deadlines under the Montreal Convention (14 days for damage, 21 days for delay) and CMR Convention.',
    `claim_type` STRING COMMENT 'Classification of the nature of the claim line: loss (cargo not delivered), damage (cargo delivered in damaged condition), shortage (partial quantity missing), delay (late delivery causing financial loss), contamination, or pilferage. Drives liability framework selection.. Valid values are `loss|damage|shortage|delay|contamination|pilferage`',
    `claimed_quantity` DECIMAL(18,2) COMMENT 'Number of units, pieces, or cargo items being claimed on this line. Represents the quantity declared as lost, damaged, or short-shipped by the claimant.',
    `claimed_value` DECIMAL(18,2) COMMENT 'Total monetary value claimed by the claimant for this line item, calculated as claimed_quantity multiplied by unit_value plus any ancillary costs. Represents the claimants gross demand before assessment.',
    `commodity_description` STRING COMMENT 'Free-text description of the commodity or cargo item being claimed, as declared on the Air Waybill (AWB) or Bill of Lading (BOL). Used for customs reporting and insurer correspondence.',
    `condition_at_destination` STRING COMMENT 'Recorded condition of the cargo item upon delivery at destination, as noted on the Proof of Delivery (POD) or cargo survey report. Compared against condition_at_origin to establish loss or damage.. Valid values are `good|damaged|wet|open|repackaged|missing`',
    `condition_at_origin` STRING COMMENT 'Recorded condition of the cargo item at the point of origin or acceptance by the carrier, as noted on the AWB, BOL, or cargo receipt. Establishes the baseline for damage assessment and liability determination.. Valid values are `good|damaged|wet|open|repackaged|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim line record was first created in the system. Used for audit trail, SLA measurement, and data lineage tracking in the Silver Layer lakehouse.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this claim line (claimed_value, approved_value, unit_value). Ensures consistent multi-currency claim valuation and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `damage_category` STRING COMMENT 'Categorical classification of the damage type for this claim line, enabling trend analysis and root cause reporting. [ENUM-REF-CANDIDATE: physical|water|fire|theft|contamination|temperature|handling|vermin|customs_examination — promote to reference product]',
    `damage_description` STRING COMMENT 'Detailed free-text description of the nature and extent of damage, loss, or shortage observed for this claim line item. Captured from cargo survey reports and used in insurer correspondence and settlement negotiations.',
    `dangerous_goods_class` STRING COMMENT 'IMDG/ICAO dangerous goods classification class or division for the cargo item (e.g., Class 3 Flammable Liquids, Division 6.1 Toxic Substances). Populated only when is_dangerous_goods is true. Required for regulatory incident reporting.. Valid values are `^(Class [1-9]|Division [1-9].[0-9A-Z])?$`',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Depreciation rate applied to the cargo items declared value to reflect age, wear, or market value reduction at the time of loss or damage. Expressed as a decimal (e.g., 0.1500 = 15%). Applied in approved_value calculation.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the cargo destination for this claim line. Used for cross-border claims, import duty recovery, and jurisdictional liability framework determination.. Valid values are `^[A-Z]{3}$`',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Gross weight in kilograms of the cargo items on this claim line as declared on the AWB or BOL. Used for liability cap calculation under weight-based conventions (e.g., Montreal Convention SDR per kg).',
    `hs_code` STRING COMMENT 'Harmonized System (HS) Code classifying the commodity under the World Customs Organization (WCO) nomenclature. Required for customs and trade compliance reporting, particularly for cross-border claims and duty recovery under DDP or DAP Incoterms.. Valid values are `^[0-9]{6,10}$`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) applicable to the shipment for this claim line, determining the point of risk transfer between buyer and seller. Influences liability determination and insurable interest. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurer_reference` STRING COMMENT 'Reference number assigned by the cargo insurer for this claim line. Used for insurer correspondence, subrogation tracking, and recovery management.',
    `is_dangerous_goods` BOOLEAN COMMENT 'Flag indicating whether the cargo item on this claim line is classified as dangerous goods under IMDG Code or ICAO Technical Instructions. Triggers specialist handling procedures and regulatory notification requirements for dangerous goods claims.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this claim line record. Supports change data capture (CDC) in the Databricks Silver Layer and audit compliance under SOX.',
    `liability_basis` STRING COMMENT 'The legal or contractual framework governing carrier liability for this claim line. Determines the applicable liability cap and burden of proof. [ENUM-REF-CANDIDATE: montreal_convention|cmr_convention|hague_visby|cotif|contractual|waiver — promote to reference product if additional conventions are added]. Valid values are `montreal_convention|cmr_convention|hague_visby|cotif|contractual|waiver`',
    `liability_cap_value` DECIMAL(18,2) COMMENT 'Maximum carrier liability applicable to this claim line under the governing convention or contract (e.g., SDR per kg under Montreal Convention for air, or CMR limits for road). Constrains the approved_value ceiling.',
    `line_number` STRING COMMENT 'Sequential line number ordering this item within the parent claim. Used for display, sorting, and referencing individual line items in insurer correspondence and settlement documentation.',
    `line_status` STRING COMMENT 'Current lifecycle status of this individual claim line item. Tracks the workflow state from initial registration through assessment, approval or rejection, and final settlement or withdrawal.. Valid values are `open|under_review|approved|rejected|settled|withdrawn`',
    `loss_discovery_date` DATE COMMENT 'Date on which the loss, damage, or shortage for this claim line was first discovered or reported by the consignee or shipper. Critical for determining claim filing timeliness under applicable liability conventions.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the cargo origin for this claim line. Used for cross-border claims, customs duty recovery, and WCO trade compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `quantity_unit` STRING COMMENT 'Unit of measure for the claimed quantity (e.g., PCS for pieces, KG for kilograms, CBM for cubic metres, CTN for cartons, PLT for pallets, BAG for bags). Aligns with the unit declared on the AWB or BOL.. Valid values are `PCS|KG|CBM|CTN|PLT|BAG`',
    `rejection_reason` STRING COMMENT 'Free-text or coded reason for rejection of this claim line, populated when line_status is rejected. Documents the basis for denial (e.g., late filing, inherent vice, force majeure, insufficient evidence) for audit and dispute resolution.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Residual monetary value of the damaged cargo recovered through salvage operations for this claim line. Deducted from the approved_value to determine the net settlement payable.',
    `settlement_date` DATE COMMENT 'Date on which the claim line was financially settled and payment was made or credit note issued to the claimant. Used for finance reserve accounting and SAP S/4HANA AR reconciliation.',
    `sku_code` STRING COMMENT 'Stock Keeping Unit (SKU) identifier for the specific product or cargo item being claimed. Sourced from the shippers inventory or WMS system (Manhattan WMS) to enable granular claim valuation at the item level.',
    `subrogation_flag` BOOLEAN COMMENT 'Indicates whether subrogation rights have been exercised or are being pursued for this claim line, enabling the insurer to recover costs from the liable carrier or third party after settlement.',
    `subrogation_recovery_value` DECIMAL(18,2) COMMENT 'Monetary amount recovered through subrogation proceedings for this claim line. Populated after recovery is confirmed. Used in finance for net claims cost reporting and P&L impact analysis.',
    `survey_date` DATE COMMENT 'Date on which the cargo survey or physical inspection was conducted for this claim line item. Used to track assessment timelines and SLA compliance for claims processing.',
    `transport_mode` STRING COMMENT 'Mode of transport applicable to this claim line, determining the governing liability convention (IATA Warsaw-Montreal for air, Hague-Visby/CMR for ocean/road, COTIF for rail). Critical for liability cap calculation.. Valid values are `air|ocean|road|rail|multimodal`',
    `unit_value` DECIMAL(18,2) COMMENT 'Declared or assessed value per unit of the cargo item at origin, as stated on the commercial invoice. Used as the basis for claim valuation and liability cap comparison under applicable conventions.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Volume in cubic metres (CBM) of the cargo items on this claim line. Used for dimensional weight (DIM Weight) calculations and ocean freight LCL/FCL claim assessments.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Line-item detail record within a cargo claim, representing individual damaged, lost, or short-shipped SKUs or cargo units. Captures SKU reference, commodity description, HS code, quantity claimed, unit value, total claimed value, currency, condition at origin, and condition at destination. Enables granular claim valuation and supports customs and trade compliance reporting under WCO requirements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`claim_party` (
    `claim_party_id` BIGINT COMMENT 'Unique surrogate identifier for each claim party association record in the Transport Shipping claims management system. Primary key for the claim_party entity.',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the parent cargo claim record to which this party is associated. Links the party to the specific claim event.',
    `contract_party_id` BIGINT COMMENT 'Reference to the master party record (organisation or individual) involved in this claim. Enables lookup of full party profile from the master party registry.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to claim.claim_policy. Business justification: Claim party involvement (especially insurer parties) is under a specific insurance policy. N:1 relationship (many party records per policy). Adding claim_policy_id FK allows normalization of policy_nu',
    `aeo_number` STRING COMMENT 'AEO certification number of the party where applicable (carriers, freight handlers, customs brokers). Relevant for customs authority and freight handler roles in cross-border claims.',
    `awb_number` STRING COMMENT 'Air Waybill number associated with this partys involvement in the claim, applicable when the transport mode is air freight. Links to the specific air cargo consignment under IATA conventions.',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with this partys involvement in the claim, applicable for ocean freight shipments. Identifies the specific consignment under Hague-Visby or similar maritime rules.',
    `contact_email` STRING COMMENT 'Primary email address of the claim contact at this party. Used for formal claim notifications, document exchange, and settlement correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Full name of the primary contact person at this party organisation responsible for handling the claim. Used for direct correspondence and escalation.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the claim contact at this party. Used for urgent claim escalations and survey coordination.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the partys registered jurisdiction. Determines applicable national regulations, customs authority jurisdiction, and governing law for the claim.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this claim party association record was first created in the Transport Shipping claims management system. Supports audit trail and data lineage requirements.',
    `dispute_raised` BOOLEAN COMMENT 'Indicates whether this party has formally raised a dispute against the claim amount, liability determination, or settlement terms. Triggers escalation to legal proceedings or arbitration.',
    `dispute_reason` STRING COMMENT 'Reason code for the dispute raised by this party. Categorises the basis of the dispute to guide resolution strategy and legal response.. Valid values are `liability_denied|amount_disputed|documentation_incomplete|time_bar|jurisdiction|other`',
    `document_submission_deadline` DATE COMMENT 'Deadline by which this party must submit supporting documentation (e.g., survey reports, invoices, packing lists, customs declarations) to support or defend the claim.',
    `documents_received` BOOLEAN COMMENT 'Indicates whether all required supporting documents have been received from this party. Drives claim processing workflow and completeness checks.',
    `iata_code` STRING COMMENT 'IATA airline or agent code assigned to this party, applicable for air carrier and freight forwarder roles. Used to identify the party in air freight claim proceedings under IATA conventions.. Valid values are `^[A-Z0-9]{2,3}$`',
    `imo_number` STRING COMMENT 'IMO vessel or company identification number for ocean carrier parties. Used to identify the maritime carrier in ocean freight claims under Hague-Visby or similar rules.. Valid values are `^IMO[0-9]{7}$`',
    `legal_representation_type` STRING COMMENT 'Indicates whether this party is represented by in-house legal counsel, external legal counsel, or has no legal representation in the claim proceedings.. Valid values are `in_house|external_counsel|none`',
    `liability_accepted` BOOLEAN COMMENT 'Indicates whether this party has formally accepted liability for the cargo loss, damage, or delay. Drives settlement calculation and subrogation recovery processes.',
    `liability_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the liability limit amount is expressed (e.g., USD, EUR, XDR for Special Drawing Rights).. Valid values are `^[A-Z]{3}$`',
    `liability_framework` STRING COMMENT 'International or contractual liability convention governing this partys exposure in the claim. Determines maximum liability limits and burden of proof requirements.. Valid values are `warsaw_montreal|cmr|hague_visby|cotif|domestic|contractual`',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary liability cap applicable to this party under the governing convention or contract (e.g., SDR per kg under Warsaw-Montreal, SDR per kg under CMR). Used in settlement calculations.',
    `liability_percentage` DECIMAL(18,2) COMMENT 'Percentage of total claim liability attributed to this party in cases of shared or apportioned liability across multiple carriers or intermediaries in intermodal shipments.',
    `notification_method` STRING COMMENT 'Channel used to formally notify this party of the claim. Relevant for legal admissibility of notice under applicable conventions and SLA tracking.. Valid values are `email|post|edi|portal|fax`',
    `notification_status` STRING COMMENT 'Status of the formal claim notification sent to this party. Tracks whether the party has been formally notified per applicable convention timelines (e.g., 14-day notice under CMR, 7-day notice under Warsaw-Montreal).. Valid values are `pending|sent|acknowledged|overdue`',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the formal claim notification was dispatched to this party. Critical for calculating statutory response deadlines under applicable liability conventions.',
    `party_role` STRING COMMENT 'Functional role of the party within the cargo claim process. Determines liability exposure, notification obligations, and response requirements. [ENUM-REF-CANDIDATE: claimant|carrier|sub_carrier|insurer|underwriter|surveyor|legal_counsel|customs_authority|port_operator|freight_handler — promote to reference product]',
    `party_status` STRING COMMENT 'Current lifecycle status of this partys involvement in the claim. Tracks progression from initial notification through response, dispute resolution, and final settlement or withdrawal.. Valid values are `active|notified|responded|disputed|settled|withdrawn`',
    `party_type` STRING COMMENT 'Classification of the party as an organisation, individual, government body, or regulatory authority. Drives applicable liability frameworks and communication protocols.. Valid values are `organisation|individual|government_body|regulatory_authority`',
    `power_of_attorney` BOOLEAN COMMENT 'Indicates whether a power of attorney has been received from this party authorising a representative to act on their behalf in the claim proceedings.',
    `primary_party` BOOLEAN COMMENT 'Indicates whether this party is the primary counterparty for the claim (e.g., the main claimant or the primary liable carrier) as opposed to a secondary or supporting party.',
    `reference_number` STRING COMMENT 'External reference number assigned by the party to this claim (e.g., insurer claim reference, carrier incident number, surveyor job number). Enables cross-referencing with counterparty systems.',
    `response_deadline` DATE COMMENT 'Contractual or statutory deadline by which this party must respond to the claim notification. Derived from notification date plus applicable convention or SLA response period.',
    `response_received_timestamp` TIMESTAMP COMMENT 'Date and time when this partys formal response to the claim notification was received. Used to assess timeliness of response against statutory deadlines.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Agreed monetary settlement amount attributed to or recoverable from this party. Populated upon settlement agreement and used for finance reserve accounting and credit note generation.',
    `settlement_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the settlement amount with this party is denominated.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Date on which the financial settlement with this party was agreed and confirmed. Triggers finance reserve release and credit note issuance in SAP S/4HANA.',
    `subrogation_applicable` BOOLEAN COMMENT 'Indicates whether subrogation rights apply to this partys involvement, enabling the insurer to pursue recovery from the liable carrier or third party after settling the claimant.',
    `subrogation_recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered or expected to be recovered from this party through subrogation proceedings. Relevant for insurer and underwriter roles in the claim.',
    `survey_report_reference` STRING COMMENT 'Reference number of the cargo survey report issued by the surveyor party. Links the partys assessment findings to the claim record for loss quantification and liability determination.',
    `surveyor_accreditation` STRING COMMENT 'Professional accreditation or certification number of the cargo surveyor party. Validates the surveyors authority to conduct loss and damage assessments for insurance and legal purposes.',
    `time_bar_date` DATE COMMENT 'Statutory limitation date by which legal action must be commenced against this party under the applicable liability convention (e.g., 2 years under Warsaw-Montreal, 1 year under CMR). Critical for claim management and legal escalation.',
    `transport_mode` STRING COMMENT 'Mode of transport under which this partys liability or involvement arises. Determines the applicable international convention (Warsaw-Montreal for air, CMR for road, Hague-Visby for ocean, COTIF for rail).. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this claim party association record was last modified. Supports audit trail, change tracking, and Silver layer incremental processing in the Databricks Lakehouse.',
    CONSTRAINT pk_claim_party PRIMARY KEY(`claim_party_id`)
) COMMENT 'Association entity linking all parties involved in a cargo claim to their respective roles and responsibilities. Captures party type (claimant, carrier, sub-carrier, insurer, underwriter, surveyor, legal counsel, customs authority, port operator, freight handler), party reference ID, contact details, notification status, response deadlines, and role-specific attributes. Enables multi-party claim management across complex intermodal and cross-border shipments where liability may be shared among multiple carriers and intermediaries.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`policy` (
    `policy_id` BIGINT COMMENT 'Unique surrogate identifier for the cargo insurance policy record within the Transport Shipping data platform. Primary key for the claim_policy entity.',
    `aggregate_annual_limit_amount` DECIMAL(18,2) COMMENT 'Maximum total insurer liability across all claims filed within the policy year, expressed in coverage_limit_currency. Once exhausted, no further claims are payable under this policy until renewal. Critical for reserve accounting in SAP S/4HANA Finance.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this policy automatically renews at expiry without requiring explicit action from Transport Shipping. When True, cancellation notice must be given before the renewal_date to prevent automatic continuation.',
    `broker_name` STRING COMMENT 'Name of the insurance broker or intermediary who placed this policy on behalf of Transport Shipping. The broker is the primary point of contact for policy renewals, endorsements, and claim escalations.',
    `broker_reference` STRING COMMENT 'Brokers own reference number for this policy placement. Used in broker correspondence, premium invoices, and claim notifications routed through the broker.',
    `cancellation_notice_period_days` STRING COMMENT 'Minimum number of calendar days written notice required by either party to cancel this policy before its expiry_date. Breach of this period may result in premium liability for the full policy term.',
    `cargo_category` STRING COMMENT 'Classification of cargo types covered under this policy. Determines applicable liability frameworks and special conditions. dangerous_goods aligns to IMDG Code and ICAO Technical Instructions; high_value triggers enhanced survey requirements. [ENUM-REF-CANDIDATE: general|perishable|dangerous_goods|high_value|fragile|bulk|pharmaceutical|automotive — promote to reference product]. Valid values are `general|perishable|dangerous_goods|high_value|fragile|bulk`',
    `claims_filing_period_days` STRING COMMENT 'Maximum number of calendar days after the loss event within which a formal claim must be filed with the insurer. Distinct from the notification period; this is the hard deadline for submitting full claim documentation.',
    `claims_notification_period_days` STRING COMMENT 'Maximum number of calendar days after discovery of loss or damage within which a claim must be notified to the insurer to remain eligible for settlement. Breach of this period may void the claim. Aligned to IATA, CMR, and IMO convention time limits.',
    `co_insurance_flag` BOOLEAN COMMENT 'Indicates whether this policy is co-insured by multiple underwriters sharing the risk proportionally. When True, the co_insurance_lead_insurer and individual underwriter shares must be tracked for claim apportionment.',
    `co_insurance_share_pct` DECIMAL(18,2) COMMENT 'Percentage of the total risk retained by the lead insurer named in insurer_name when this is a co-insured policy. Expressed as a decimal percentage (e.g., 60.00 for 60%). Only applicable when co_insurance_flag is True.',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount the insurer will pay for any single claim or in aggregate under this policy, expressed in the policy currency. Serves as the upper bound for settlement calculations. Critical for claim eligibility assessment.',
    `coverage_limit_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the coverage limit amount and deductible are denominated (e.g., USD, EUR, GBP). Required for multi-currency settlement calculations.. Valid values are `^[A-Z]{3}$`',
    `covered_transport_modes` STRING COMMENT 'Pipe-delimited list of transport modes covered under this policy (e.g., air|ocean|road|rail). Determines claim eligibility based on the mode used for the shipment. Aligned to IATA (air), IMO (ocean), CMR Convention (road), and CIM/COTIF (rail) liability frameworks. [ENUM-REF-CANDIDATE: air|ocean|road|rail|multimodal|courier — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim policy record was first created in the Transport Shipping data platform. Populated automatically at insert time. Used for data lineage, audit trails, and SOX compliance. Maps to RECORD_AUDIT_CREATED canonical category.',
    `dangerous_goods_covered` BOOLEAN COMMENT 'Indicates whether this policy explicitly covers dangerous goods shipments as classified under the IMDG Code (ocean), ICAO Technical Instructions (air), or ADR/RID (road/rail). When True, the policy must reference applicable DG endorsements and special conditions.',
    `declaration_period_days` STRING COMMENT 'Number of calendar days after shipment dispatch within which a declaration must be submitted to the insurer under an open cover policy. Only applicable when declaration_required_flag is True. Null for specific voyage policies.',
    `declaration_required_flag` BOOLEAN COMMENT 'Indicates whether individual shipment declarations must be submitted to the insurer under this open cover policy. When True, each shipment must be declared within the agreed declaration period to activate coverage for that consignment.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount that Transport Shipping must absorb before the insurers liability commences on any individual claim. Deducted from gross claim settlement to arrive at net insurer payment. Expressed in coverage_limit_currency.',
    `deductible_type` STRING COMMENT 'Method by which the deductible is applied. fixed is a flat monetary amount; percentage is a proportion of the claim value; franchise means the deductible is waived if the claim exceeds the threshold; nil means no deductible applies.. Valid values are `fixed|percentage|franchise|nil`',
    `dispute_resolution_method` STRING COMMENT 'Agreed mechanism for resolving disputes between Transport Shipping and the insurer regarding claim settlements or policy interpretation. arbitration is most common in international cargo insurance under Lloyds and London Market policies.. Valid values are `arbitration|litigation|mediation|expert_determination`',
    `document_reference` STRING COMMENT 'Document management system reference or URL pointing to the signed policy wording, schedule, and endorsements stored in the enterprise content management system. Enables auditors and claims handlers to retrieve the authoritative policy text.',
    `effective_date` DATE COMMENT 'Calendar date on which the cargo insurance policy becomes binding and coverage commences. Used to determine claim eligibility based on shipment date. Maps to EFFECTIVE_FROM canonical category for MASTER_AGREEMENT role.',
    `exclusions` STRING COMMENT 'Structured description of risks, cargo types, or circumstances explicitly excluded from coverage under this policy. Common exclusions include inherent vice, delay, inadequate packing, and nuclear risks. Used during claim eligibility assessment.',
    `expiry_date` DATE COMMENT 'Calendar date on which the cargo insurance policy coverage terminates. Claims for shipments dispatched after this date are not eligible under this policy. Nullable for open-ended or evergreen open cover policies. Maps to EFFECTIVE_UNTIL canonical category for MASTER_AGREEMENT role.',
    `geographic_scope` STRING COMMENT 'Territorial extent of coverage under this policy. worldwide covers all global shipments; regional covers a defined geographic region; domestic covers in-country shipments only; cross_border covers international shipments excluding domestic legs.. Valid values are `worldwide|regional|domestic|cross_border`',
    `governing_law` STRING COMMENT 'Jurisdiction whose laws govern the interpretation and enforcement of this insurance policy (e.g., English Law, New York Law, German Law). Determines dispute resolution forum and applicable legal standards for claim settlement.',
    `insurer_name` STRING COMMENT 'Legal trading name of the insurance company or underwriting syndicate that issued the cargo insurance policy. Used in insurer correspondence, claim submissions, and settlement negotiations.',
    `insurer_policy_reference` STRING COMMENT 'Insurers own internal reference or certificate number for this policy, distinct from the policy_number used by Transport Shipping. Required for direct insurer correspondence and electronic claim submission via EDI.',
    `issuing_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction in which this insurance policy was issued. Determines applicable regulatory oversight (e.g., FCA in GBR, BaFin in DEU, NAIC in USA) and tax treatment of premiums.. Valid values are `^[A-Z]{3}$`',
    `liability_basis` STRING COMMENT 'Valuation method used to calculate the insured value of cargo for settlement purposes. invoice_value uses the commercial invoice amount; declared_value uses the shipper-declared value on the AWB or BOL; market_value uses prevailing market price at destination; replacement_cost uses the cost to replace the goods.. Valid values are `invoice_value|declared_value|market_value|replacement_cost`',
    `open_cover_flag` BOOLEAN COMMENT 'Indicates whether this policy is structured as an open cover (blanket policy covering all qualifying shipments automatically without individual declaration) rather than a specific voyage or shipment policy. Open cover policies are common for high-volume freight forwarders.',
    `per_shipment_limit_amount` DECIMAL(18,2) COMMENT 'Maximum insurer liability for any single shipment event under this policy, expressed in coverage_limit_currency. May be lower than the aggregate coverage_limit_amount. Used in claim settlement calculations for individual AWB, BOL, or consignment note events.',
    `policy_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned by the insurer to uniquely identify the cargo insurance policy. Used in all insurer correspondence, claim filings, and settlement documentation. Maps to the BUSINESS_IDENTIFIER canonical category for MASTER_AGREEMENT role.',
    `policy_status` STRING COMMENT 'Current lifecycle state of the cargo insurance policy. active indicates the policy is in force and eligible for claim filing; suspended indicates temporary coverage halt; expired indicates the policy period has ended without renewal; cancelled indicates early termination; pending_renewal indicates renewal is in progress; lapsed indicates non-renewal after expiry. Maps to LIFECYCLE_STATUS canonical category.. Valid values are `active|suspended|expired|cancelled|pending_renewal|lapsed`',
    `policy_type` STRING COMMENT 'Classification of the cargo insurance policy by coverage scope. all_risk covers all physical loss or damage except named exclusions; named_perils covers only explicitly listed risks; war_risk covers war, strikes, and political risks; total_loss_only covers only complete cargo loss; open_cover is a continuous blanket policy for multiple shipments. Maps to CLASSIFICATION_OR_TYPE canonical category.. Valid values are `all_risk|named_perils|war_risk|total_loss_only|open_cover`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Annual or periodic insurance premium paid by Transport Shipping to the insurer for this policy. Used in finance for cost allocation, OPEX reporting, and profitability analysis per trade lane or business unit.',
    `premium_payment_frequency` STRING COMMENT 'Frequency at which the insurance premium is paid to the insurer. Drives accounts payable scheduling in SAP S/4HANA Finance and cash flow forecasting.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `reinsurance_flag` BOOLEAN COMMENT 'Indicates whether the insurer has placed reinsurance for this policy. Relevant for large-value cargo policies where the insurers net retention is limited. Affects claim recovery timelines and insurer solvency risk assessment.',
    `renewal_date` DATE COMMENT 'Date on which the policy is due for renewal. Used to trigger renewal negotiations, premium reviews, and coverage reassessment. Typically aligns with or precedes the expiry_date.',
    `special_conditions` STRING COMMENT 'Free-text field capturing policy-specific endorsements, exclusions, warranties, or special clauses that modify the standard Institute Cargo Clauses terms. Examples include temperature warranty for perishables, packing warranty, or exclusion of specific trade lanes.',
    `subrogation_rights` BOOLEAN COMMENT 'Indicates whether the insurer retains the right of subrogation to pursue recovery from liable third parties (carriers, handlers, customs authorities) after settling a claim. When True, Transport Shipping must cooperate with insurer recovery actions and preserve evidence.',
    `survey_required_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum claim value (in coverage_limit_currency) above which an independent cargo survey report is mandatory before the insurer will process the claim. Below this threshold, claims may be settled on documentary evidence alone.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this claim policy record was last modified in the Transport Shipping data platform. Updated on every write operation. Used for change data capture, incremental ETL processing, and audit compliance.',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Reference entity defining the cargo insurance policy under which a claim is filed. Captures policy number, insurer name, policy type (all-risk, named perils, war risk), coverage limit, deductible amount, policy period, covered transport modes, and special conditions. Serves as the contractual basis for claim eligibility assessment and settlement calculation. Distinct from the contract domain which manages carrier and customer service contracts.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`recovery_action` (
    `recovery_action_id` BIGINT COMMENT 'Unique system-generated identifier for each recovery action record within the subrogation or direct carrier recovery workflow.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Demand letters and legal filings reference contractual liability provisions, limitation periods, and dispute resolution clauses. Essential for recovery strategy, determining jurisdiction, and establis',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Air cargo recovery requires AWB reference to identify liable carrier and enforce liability limits. Replaces denormalized awb_number with proper FK for carrier identification, Montreal Convention enfor',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Ocean cargo recovery requires B/L reference to identify liable carrier and enforce liability limits. Replaces denormalized bol_number with proper FK for carrier identification, Hague-Visby rules enfor',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Recovery actions may reference booking for pre-shipment contractual breaches (space confirmation failure, rate dispute). Supports booking-level recovery demand and pre-shipment contractual breach enfo',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the parent cargo insurance claim against which this recovery action is being pursued. Links the recovery action to the originating loss or damage event.',
    `cargo_survey_id` BIGINT COMMENT 'Foreign key linking to claim.cargo_survey. Business justification: Recovery action against liable third parties references survey evidence to substantiate the recovery demand. N:1 relationship (many recovery actions per survey). Adding cargo_survey_id FK allows norma',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Recovery actions are predominantly directed at carriers; demand letters, legal filings, settlements, and arbitration require carrier linkage. Essential for carrier recovery tracking, dispute resolutio',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Recovery transactions require GL account assignment for expense and income classification, enabling proper P&L presentation and tracking of net recovery effectiveness.',
    `claim_party_id` BIGINT COMMENT 'Reference to the third-party entity (sub-carrier, port operator, freight handler, warehouse operator) held liable and against whom the recovery action is directed. Primary counterparty reference for this transaction.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Recovery actions generate financial transactions (legal costs, settlements, recoveries) that must be posted to a legal entity for financial statement preparation and intercompany reconciliation.',
    `consignment_id` BIGINT COMMENT 'Reference to the internal shipment record associated with the cargo loss or damage event underlying this recovery action. Links to SAP TM or Oracle TMS shipment execution records.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Legal costs and recovery expenses must be allocated to cost centers for budget control, variance analysis, and tracking of recovery program costs against recovered amounts.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Recovery actions may involve customer accounts when customer liability is determined (e.g., shipper negligence). Enables customer-level recovery tracking, customer liability reporting, and customer co',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee or team responsible for managing and progressing this recovery action. Used for workload assignment, escalation, and performance tracking in Workday HCM.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Recovery actions require facility attribution for cost center allocation, GL account coding, and tracking facility-specific recovery rates. Critical for financial reporting, facility P&L statements, a',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Recovery actions pursue reimbursement from liable parties for specific freight orders. Essential for identifying liable carrier from freight order, calculating recovery amount based on freight charges',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Recovery actions may target parties responsible for HSE incidents that caused cargo loss (facility operator negligence, carrier safety violations). Legal teams require HSE incident documentation for d',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Recovery demands reference lane-specific carrier agreements to establish liability basis, statutory limits, and contractual remedies. Enables tracking of recovery success rates by lane and carrier for',
    `subrogation_case_id` BIGINT COMMENT 'Foreign key linking to claim.subrogation_case. Business justification: Recovery actions are tactical steps taken within a strategic subrogation case. N:1 relationship (many recovery actions per subrogation case). A subrogation case may involve multiple recovery actions (',
    `supplier_id` BIGINT COMMENT 'Reference to the cargo insurer involved in the subrogation process. Identifies the insurer to whom the insurer share of recovery proceeds must be remitted.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Legal filings (court complaints, arbitration notices) are specific document instances required for litigation management. Legal teams track legal_filing_date and court_case_number but need the actual ',
    `action_date` DATE COMMENT 'The real-world business date on which the recovery action was formally initiated or executed (e.g., date a demand letter was issued, date a legal filing was lodged). Distinct from the record creation timestamp.',
    `action_notes` STRING COMMENT 'Free-text field capturing key correspondence summaries, negotiation positions, legal strategy notes, and material developments in the recovery action. Supports case management and audit trail requirements.',
    `action_outcome` STRING COMMENT 'Final result of the recovery action upon closure. Indicates whether the full demanded amount, a partial amount, or nothing was recovered. Drives reserve release and P&L recognition in SAP S/4HANA Finance.. Valid values are `full_recovery|partial_recovery|no_recovery|withdrawn|pending_judgment`',
    `action_reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to this recovery action, used in correspondence with liable third parties, legal counsel, and insurers. Follows the format RA-YYYY-NNNNNN.. Valid values are `^RA-[0-9]{4}-[0-9]{6}$`',
    `action_status` STRING COMMENT 'Current lifecycle state of the recovery action, tracking progression from initiation through resolution. Drives workflow routing and P&L reserve adjustments in SAP S/4HANA Finance.. Valid values are `initiated|in_progress|responded|settled|closed|withdrawn`',
    `action_type` STRING COMMENT 'Classification of the recovery action being taken against the liable third party. Indicates the legal or commercial mechanism employed. [ENUM-REF-CANDIDATE: demand_letter|legal_filing|arbitration|settlement_negotiation|mediation|subrogation_notice — promote to reference product if additional types are required]. Valid values are `demand_letter|legal_filing|arbitration|settlement_negotiation|mediation|subrogation_notice`',
    `arbitration_body` STRING COMMENT 'Name of the arbitration institution or tribunal handling the dispute where action type is arbitration (e.g., ICC International Court of Arbitration, LMAA, AAA). Null for non-arbitration action types.',
    `court_case_number` STRING COMMENT 'Official case reference number assigned by the court or tribunal where a legal filing has been lodged. Applicable only when action type is legal_filing. Used for docket tracking and legal correspondence.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this recovery action record was first created in the data platform. Used for audit trail, data lineage, and SOX compliance reporting.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the cargo involved in the underlying loss event was classified as dangerous goods. Triggers additional regulatory reporting requirements under IMDG Code or ICAO Technical Instructions and may affect liability limits.',
    `demanded_amount` DECIMAL(18,2) COMMENT 'Gross monetary amount formally demanded from the liable third party in this recovery action, expressed in the transaction currency. Represents the full claim value before any negotiated reduction or statutory cap.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this recovery action has been escalated to senior management, legal leadership, or external counsel due to complexity, high value, or imminent limitation period expiry.',
    `external_counsel_reference` STRING COMMENT 'Reference number or name of the external legal counsel or law firm engaged to pursue this recovery action. Used for legal spend tracking and matter management.',
    `insurer_notification_date` DATE COMMENT 'Date on which the insurer was formally notified of the recovery action being pursued on their behalf under subrogation rights. Required for insurer correspondence audit trail.',
    `insurer_share_amount` DECIMAL(18,2) COMMENT 'Portion of the recovered amount attributable to the insurer under subrogation rights. Represents the amount to be remitted to the insurer from the total recovery proceeds.',
    `jurisdiction_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the legal jurisdiction in which the recovery action is being pursued. Determines applicable procedural law, court system, and enforcement mechanisms.. Valid values are `^[A-Z]{3}$`',
    `legal_costs` DECIMAL(18,2) COMMENT 'Total legal and professional fees incurred in pursuing this recovery action (attorney fees, court filing fees, arbitration fees). Deducted from gross recovery to calculate net recovery P&L.',
    `liability_convention` STRING COMMENT 'International liability convention governing the maximum recoverable amount and burden of proof for this recovery action. Determines statutory limits applied to the demanded amount.. Valid values are `warsaw_montreal|cmr|hague_visby|cotif_cim|uncitral`',
    `liable_party_name` STRING COMMENT 'Legal or trading name of the third-party entity against whom the recovery action is directed (e.g., sub-carrier, port terminal operator, freight handler). Captured for correspondence and legal documentation purposes.',
    `liable_party_type` STRING COMMENT 'Classification of the liable third party by their operational role in the logistics chain. Determines applicable liability convention and recovery limits. [ENUM-REF-CANDIDATE: sub_carrier|port_operator|freight_handler|warehouse_operator|customs_broker|nvocc — promote to reference product if additional types are required]. Valid values are `sub_carrier|port_operator|freight_handler|warehouse_operator|customs_broker|nvocc`',
    `limitation_period_expiry_date` DATE COMMENT 'Statutory deadline by which the recovery action must be formally filed or concluded under the applicable liability convention (e.g., 2 years under Warsaw-Montreal, 1 year under CMR). Critical for legal compliance and action prioritization.',
    `loss_type` STRING COMMENT 'Nature of the cargo loss or damage event that gave rise to the recovery action. Determines applicable liability provisions and evidentiary requirements under the governing convention.. Valid values are `total_loss|partial_loss|damage|delay|misdelivery|pilferage`',
    `net_recovery_amount` DECIMAL(18,2) COMMENT 'Net monetary benefit realized from the recovery action after deducting legal costs and any insurer share from the gross recovered amount. Primary P&L metric for recovery performance reporting.',
    `priority_level` STRING COMMENT 'Business priority assigned to this recovery action based on demanded amount, limitation period proximity, and strategic importance. Drives case handler workload prioritization and escalation thresholds.. Valid values are `critical|high|medium|low`',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Actual monetary amount successfully recovered from the liable third party upon conclusion of the recovery action. May be less than the demanded amount due to negotiation, statutory caps, or partial liability acceptance.',
    `recovery_basis` STRING COMMENT 'Legal or contractual basis under which the recovery action is pursued. Subrogation arises when the insurer recovers from the liable party after paying the insured; direct carrier recovery is pursued by the shipper or 3PL directly.. Valid values are `subrogation|direct_carrier_recovery|contractual_indemnity|tort_claim`',
    `recovery_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the demanded and recovered amounts are denominated (e.g., USD, EUR, GBP). Required for multi-currency P&L reporting and FX conversion in SAP S/4HANA Finance.. Valid values are `^[A-Z]{3}$`',
    `reserve_amount` DECIMAL(18,2) COMMENT 'Financial reserve set aside in the general ledger for the expected recovery proceeds from this action. Managed in SAP S/4HANA Finance for IFRS 9 expected credit loss provisioning and P&L reserve accounting.',
    `resolution_date` DATE COMMENT 'Date on which the recovery action was formally concluded, whether through settlement, withdrawal, legal judgment, or arbitration award. Null if action is still open.',
    `response_due_date` DATE COMMENT 'Contractual or statutory deadline by which the liable third party must respond to the recovery action. Used for SLA monitoring and escalation triggering.',
    `settlement_agreement_reference` STRING COMMENT 'Reference number or identifier of the executed settlement agreement where the recovery action was resolved through negotiated settlement. Links to the contract management system for document retrieval.',
    `statutory_liability_limit` DECIMAL(18,2) COMMENT 'Maximum recoverable amount permitted under the applicable international liability convention (e.g., SDR per kg under Warsaw-Montreal, SDR per kg under CMR). Used to cap the demanded amount where applicable.',
    `transport_mode` STRING COMMENT 'Mode of transport applicable to the underlying shipment loss or damage event, determining the governing liability convention (e.g., IATA Warsaw-Montreal for air, CMR for road, Hague-Visby for ocean).. Valid values are `air|ocean|road|rail|multimodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to this recovery action record. Supports change data capture, audit trail, and data quality monitoring in the Databricks Silver Layer.',
    CONSTRAINT pk_recovery_action PRIMARY KEY(`recovery_action_id`)
) COMMENT 'Transactional record tracking individual recovery actions taken against liable third parties (sub-carriers, port operators, freight handlers) as part of subrogation or direct carrier recovery. Captures action type (demand letter, legal filing, arbitration, settlement negotiation), action date, responsible party, amount demanded, amount recovered, and action outcome. Supports the full subrogation workflow and recovery P&L tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`appeal` (
    `appeal_id` BIGINT COMMENT 'Unique system-generated identifier for the claim appeal record. Primary key for the claim_appeal data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Appeals challenge settlement decisions by citing contract terms—SLA targets, penalty clauses, liability limits. Contract is the authoritative reference for appeal adjudication. Reviewers must verify t',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Appeals may reference booking for pre-shipment commercial dispute escalations (space confirmation breach appeals, rate dispute escalations). Supports booking-level appeal management and pre-shipment d',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the parent cargo insurance claim against which this appeal has been lodged. Links the appeal to the original claim record.',
    `claim_party_id` BIGINT COMMENT 'Reference to the party (customer, shipper, consignee, or insured) who has lodged the formal appeal against the initial claim decision.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Appeal-related costs and revised settlements must be posted to a legal entity for financial reporting, reserve adjustment tracking, and audit trail. Required for SOX compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Appeal handling costs must be allocated to operational cost centers for budget tracking, variance analysis, and monitoring of appeals program efficiency and cost-effectiveness.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Appeals are filed by customer accounts disputing claim decisions. Enables customer appeal tracking, customer satisfaction management, and customer-level dispute resolution reporting. Critical for cust',
    `employee_id` BIGINT COMMENT 'Reference to the internal claims officer, adjuster, or review panel member assigned to evaluate and adjudicate the appeal. Sourced from Workday HCM workforce records.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Appeals challenge claim decisions on specific freight orders. Essential for linking appeal to original shipment, reviewing freight charges for settlement recalculation, and verifying transport documen',
    `liability_determination_id` BIGINT COMMENT 'Foreign key linking to claim.liability_determination. Business justification: An appeal may contest the liability determination that led to claim rejection or reduced settlement. The appeal has original_claim_decision which relates to the liability finding, but a direct FK enab',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to claim.settlement. Business justification: An appeal contests a specific settlement decision. The appeal table has original_settlement_amount which is derivable from the settlement record via JOIN. Adding settlement_id creates a direct navigab',
    `supplier_id` BIGINT COMMENT 'Reference to the insurance carrier or underwriter involved in the appeal review process. Used for insurer correspondence tracking.',
    `surveyor_id` BIGINT COMMENT 'Foreign key linking to claim.surveyor. Business justification: Claim appeal may reference a surveyor whose report is being contested or used as evidence in the appeal. N:1 relationship (many appeals per surveyor). Adding surveyor_id FK allows normalization of sur',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Appeal submissions are formal documents containing grounds for appeal and supporting evidence. Claims review teams need the submitted appeal document for adjudication, compliance with appeal procedure',
    `appeal_date` DATE COMMENT 'The calendar date on which the claimant formally lodged the appeal against the initial claim rejection or partial settlement. Used to calculate statutory appeal deadlines under IATA and CMR frameworks.',
    `appeal_number` STRING COMMENT 'Externally-known unique business reference number assigned to the appeal at registration. Used in all claimant correspondence and regulatory filings. Format: APL-{YYYY}-{sequence}.. Valid values are `^APL-[0-9]{4}-[0-9]{8}$`',
    `appeal_status` STRING COMMENT 'Current lifecycle state of the claim appeal within the dispute resolution workflow. Drives SLA monitoring and regulatory compliance tracking. [ENUM-REF-CANDIDATE: submitted|under_review|pending_evidence|upheld|partially_upheld|rejected|withdrawn|escalated — promote to reference product]',
    `appeal_type` STRING COMMENT 'Classification of the appeal based on the nature of the dispute. Distinguishes between appeals against full rejections, partial settlements, liability determinations, quantum assessments, delay claims, or dangerous goods claims. [ENUM-REF-CANDIDATE: full_rejection_appeal|partial_settlement_appeal|liability_dispute|quantum_dispute|delay_claim_appeal|dangerous_goods_appeal — promote to reference product]. Valid values are `full_rejection_appeal|partial_settlement_appeal|liability_dispute|quantum_dispute|delay_claim_appeal|dangerous_goods_appeal`',
    `arbitration_reference` STRING COMMENT 'External reference number assigned by the arbitration body or court if the appeal has been referred to formal dispute resolution proceedings. Populated when review_outcome is referred_to_arbitration.',
    `awb_number` STRING COMMENT 'Air Waybill number associated with the underlying air freight shipment subject to the appeal. Applicable for air transport mode appeals. Format follows IATA AWB numbering standard: airline prefix (3 digits) followed by 8-digit serial number.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with the underlying ocean or road freight shipment subject to the appeal. Applicable for ocean (MBL/HBL) and road (CMR consignment note) transport mode appeals.',
    `claimant_reference` STRING COMMENT 'The claimants own internal reference number for the appeal, as provided in their submission. Used to cross-reference with the claimants records and facilitate correspondence via Salesforce CRM.',
    `claimed_appeal_amount` DECIMAL(18,2) COMMENT 'The monetary amount the claimant is seeking through the appeal process. Represents the claimants revised or full demand as stated in the appeal submission.',
    `closure_date` DATE COMMENT 'The date on which the appeal was formally closed, either following a final decision, withdrawal by the claimant, or referral to external arbitration. Marks the end of the appeal lifecycle.',
    `communication_channel` STRING COMMENT 'The channel through which the appeal was submitted and through which correspondence with the claimant is conducted. Supports multi-channel dispute resolution workflows including EDI-based submissions from freight forwarders.. Valid values are `email|postal|portal|edi|fax`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which the claim appeal record was first created in the system. Audit trail field aligned to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Sourced from Salesforce CRM case creation event.',
    `credit_note_reference` STRING COMMENT 'Reference number of the credit note issued by the billing function following a successful appeal outcome. Links the appeal resolution to the financial credit note for accounts receivable reconciliation in SAP S/4HANA Finance.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the underlying shipment involved dangerous goods, triggering additional regulatory compliance requirements under IMDG Code or ICAO Technical Instructions for the appeal assessment.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the appeal has been escalated beyond the standard review process, such as referral to senior management, legal counsel, external arbitration, or a regulatory body.',
    `escalation_reason` STRING COMMENT 'Narrative description of the reason the appeal was escalated beyond the standard review process. Populated only when escalation_flag is True.',
    `evidence_description` STRING COMMENT 'Narrative description of the additional evidence submitted by the claimant in support of the appeal. Includes document types such as cargo survey reports, commercial invoices, packing lists, photographs, expert opinions, or ePOD records.',
    `evidence_received_date` DATE COMMENT 'The date on which the additional evidence package submitted by the claimant was formally received and acknowledged by the claims team. Used to track SLA compliance for evidence review.',
    `evidence_submitted_flag` BOOLEAN COMMENT 'Indicates whether the claimant has submitted additional supporting evidence (e.g., survey reports, photographs, invoices, expert assessments) as part of the appeal. True when evidence package has been received.',
    `finance_reserve_amount` DECIMAL(18,2) COMMENT 'The monetary amount reserved in the financial accounts (SAP S/4HANA Finance) against this appeal for potential liability exposure. Used for reserve accounting and financial reporting under IFRS 4 and SOX requirements.',
    `grounds_for_appeal` STRING COMMENT 'Detailed narrative description of the claimants stated reasons for contesting the initial claim decision. Captures the legal, factual, or procedural basis for the appeal as submitted by the claimant.',
    `internal_notes` STRING COMMENT 'Internal working notes recorded by the claims reviewer during the appeal assessment process. Not shared with the claimant. Contains observations, legal analysis references, and inter-departmental communications.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which the claim appeal record was most recently modified. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit trail compliance.',
    `liability_convention` STRING COMMENT 'The international liability framework governing the appeal. Determines applicable liability limits, time bars, and procedural rights. [ENUM-REF-CANDIDATE: montreal_convention|warsaw_convention|cmr_convention|hague_visby_rules|cotif_cim|uncitral — promote to reference product]. Valid values are `montreal_convention|warsaw_convention|cmr_convention|hague_visby_rules|cotif_cim|uncitral`',
    `original_claim_decision` STRING COMMENT 'The decision outcome of the initial claim that is being appealed. Indicates whether the original claim was fully rejected, partially settled, or settled at a disputed amount.. Valid values are `rejected|partially_settled|settled`',
    `priority` STRING COMMENT 'Business priority classification assigned to the appeal based on claim value, claimant tier, regulatory sensitivity, or reputational risk. Drives resource allocation and review sequencing within the claims team.. Valid values are `low|medium|high|critical`',
    `regulatory_notification_flag` BOOLEAN COMMENT 'Indicates whether a regulatory body (e.g., IATA, IMO, national transport authority) has been notified of the appeal, as required for high-value claims, dangerous goods incidents, or cross-border disputes.',
    `review_outcome` STRING COMMENT 'The formal decision reached by the reviewer upon completion of the appeal assessment. Determines whether the original claim decision is overturned, partially revised, maintained, or escalated to arbitration.. Valid values are `upheld|partially_upheld|rejected|referred_to_arbitration|withdrawn`',
    `review_outcome_rationale` STRING COMMENT 'Detailed written justification provided by the reviewer explaining the basis for the appeal decision. Documents the legal, factual, and evidentiary reasoning applied in reaching the outcome.',
    `review_start_date` DATE COMMENT 'The date on which the formal review of the appeal was initiated by the assigned reviewer. Used to measure review cycle time against SLA targets.',
    `revised_settlement_amount` DECIMAL(18,2) COMMENT 'The revised monetary settlement amount agreed or awarded following the appeal review. Populated only when the appeal outcome results in an uphold or partial uphold. Null if appeal is rejected or pending.',
    `settlement_currency` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary amounts on this appeal record (original settlement, claimed amount, revised settlement). Ensures consistent financial reporting across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `sla_breached_flag` BOOLEAN COMMENT 'Indicates whether the appeal review process exceeded the defined SLA due date without a final decision being communicated. True when the closure date or current date exceeds the SLA due date.',
    `sla_due_date` DATE COMMENT 'The contractual or regulatory deadline by which the appeal must be reviewed and a decision communicated to the claimant. Derived from the appeal lodgement date and applicable SLA or statutory time bar.',
    `statutory_time_bar_date` DATE COMMENT 'The legally mandated deadline by which the appeal must be filed or resolved under the applicable liability convention (e.g., 2-year limit under Montreal Convention, 1-year under CMR). Failure to act before this date extinguishes the claimants rights.',
    `subrogation_flag` BOOLEAN COMMENT 'Indicates whether the appeal involves a subrogation claim, where the insurer is pursuing recovery from a third party (e.g., carrier, freight forwarder) after having compensated the insured claimant.',
    `transport_mode` STRING COMMENT 'Mode of transport applicable to the underlying shipment for which the claim appeal has been raised. Determines the applicable liability convention (IATA Montreal for air, CMR for road, Hague-Visby for ocean).. Valid values are `air|ocean|road|rail|multimodal`',
    CONSTRAINT pk_appeal PRIMARY KEY(`appeal_id`)
) COMMENT 'Transactional record managing formal appeals lodged by claimants against an initial claim rejection or partial settlement. Captures appeal date, grounds for appeal, additional evidence submitted, appeal review outcome, revised settlement amount (if any), and appeal closure date. Supports the dispute resolution workflow and regulatory compliance with IATA and CMR appeal rights.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`surveyor` (
    `surveyor_id` BIGINT COMMENT 'Unique system-generated identifier for the accredited cargo surveyor or loss adjuster entity. Primary key for the surveyor master record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Some surveyors are carrier-appointed or carrier-affiliated; tracking this relationship is essential for independence assessment and conflict-of-interest management in joint surveys. Required for surve',
    `supplier_id` BIGINT COMMENT 'Reference identifier linking the surveyor to their corresponding vendor/supplier master record in the procurement system (Coupa) and accounts payable module (SAP S/4HANA Finance). Enables invoice processing and payment for survey fees.',
    `accreditation_body` STRING COMMENT 'Name of the professional body or industry association that has accredited or certified the surveyor (e.g., RICS - Royal Institution of Chartered Surveyors, BIMCO - Baltic and International Maritime Council, IUMI - International Union of Marine Insurance, IICL - Institute of International Container Lessors). Validates professional standing for engagement eligibility. [ENUM-REF-CANDIDATE: RICS|BIMCO|IUMI|IICL|ACII|CILA|AIMU|Lloyds — promote to reference product]',
    `accreditation_expiry_date` DATE COMMENT 'Date on which the surveyors professional accreditation or certification expires. Used to trigger renewal reminders and to block engagement of lapsed surveyors.',
    `accreditation_number` STRING COMMENT 'Official certificate or membership number issued by the accreditation body confirming the surveyors professional standing and authorization to conduct cargo surveys.',
    `bank_account_reference` STRING COMMENT 'Internal reference code pointing to the surveyors registered bank account details held in the secure payment vault of SAP S/4HANA Finance. Not the raw account number — a tokenized reference for payment processing.',
    `blacklist_reason` STRING COMMENT 'Free-text description of the reason a surveyor has been blacklisted or suspended from the approved panel (e.g., fraudulent report, conflict of interest, repeated SLA breaches, lapsed accreditation). Populated only when status is blacklisted or suspended.',
    `company_code` STRING COMMENT 'Internally assigned alphanumeric code uniquely identifying the surveyor company within Transport Shipping systems. Used for cross-system referencing and EDI transactions.. Valid values are `^[A-Z0-9]{3,20}$`',
    `company_name` STRING COMMENT 'Legal registered name of the surveying firm or loss adjusting company engaged by Transport Shipping to conduct cargo damage and loss assessments.',
    `contact_email` STRING COMMENT 'Primary email address of the surveyor company contact used for engagement notifications, survey report submissions, and claim correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Full name of the primary individual contact at the surveyor company responsible for coordinating survey engagements with Transport Shipping.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the surveyor company contact, including international dialing code, used for urgent claim engagement and coordination.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the surveyor master record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for record provenance and data governance compliance.',
    `customs_compliance_cleared` BOOLEAN COMMENT 'Indicates whether the surveyor has been screened and cleared under customs compliance programs (e.g., C-TPAT, AEO) allowing them to operate in bonded warehouses, free trade zones, and customs-controlled areas.',
    `dangerous_goods_certified` BOOLEAN COMMENT 'Indicates whether the surveyor holds valid certification to assess dangerous goods cargo incidents. Required for engagement on claims involving IMDG or ICAO dangerous goods shipments.',
    `engagement_rate_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the surveyors standard engagement rates are denominated (e.g., USD, EUR, GBP). Required for multi-currency claim cost accounting in SAP S/4HANA Finance.. Valid values are `^[A-Z]{3}$`',
    `geographic_coverage_zones` STRING COMMENT 'Pipe-delimited list of ISO 3166-1 alpha-3 country codes or regional zone identifiers representing the geographic areas where the surveyor is operationally available to conduct surveys. Used for proximity-based surveyor selection.',
    `headquarters_city` STRING COMMENT 'City of the surveyor companys registered headquarters. Used in conjunction with country code for geographic routing and reporting.',
    `headquarters_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the surveyor companys registered headquarters location. Used for jurisdictional compliance, tax treatment, and primary contact routing.. Valid values are `^[A-Z]{3}$`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly billing rate for the surveyors time, expressed in the engagement rate currency. Applied for complex or extended surveys that exceed the standard flat-rate scope.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum coverage amount of the surveyors professional indemnity insurance policy, expressed in the engagement rate currency. Used to validate adequacy of coverage relative to claim values assigned.',
    `insurance_expiry_date` DATE COMMENT 'Expiry date of the surveyors professional indemnity insurance policy. Surveyors with expired insurance must be suspended from the panel until renewed coverage is confirmed.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the surveyors professional indemnity (errors and omissions) insurance. Required to validate that the surveyor carries adequate liability coverage before engagement on high-value claims.',
    `last_engagement_date` DATE COMMENT 'Date of the most recent survey engagement completed by this surveyor for Transport Shipping. Used to identify dormant panel members and to assess recency of operational experience.',
    `notes` STRING COMMENT 'Free-text operational notes and remarks about the surveyor, including special engagement instructions, regional limitations, preferred contact protocols, or historical context relevant to claim handlers.',
    `panel_approval_date` DATE COMMENT 'Date on which the surveyor was formally approved and added to Transport Shippings approved surveyor panel following vetting and accreditation verification.',
    `panel_review_date` DATE COMMENT 'Scheduled date for the next periodic performance and compliance review of the surveyors panel membership. Supports ongoing quality monitoring and accreditation renewal tracking.',
    `payment_terms` STRING COMMENT 'Agreed payment terms for survey fee invoices, indicating the number of days from invoice date within which payment is due. Aligned to Coupa procurement and SAP S/4HANA accounts payable configuration.. Valid values are `net_15|net_30|net_45|net_60|immediate`',
    `preferred_language` STRING COMMENT 'ISO 639-1 or 639-2 language code representing the surveyors preferred language for survey reports, correspondence, and engagement communications (e.g., en, fr, de, zh, es).. Valid values are `^[a-z]{2,3}$`',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality score (0.00–100.00) derived from internal assessments of the surveyors report accuracy, completeness, and professional standards. Updated after each engagement review cycle. Used for panel ranking and surveyor selection.',
    `refrigerated_cargo_certified` BOOLEAN COMMENT 'Indicates whether the surveyor is certified and experienced to assess temperature-controlled and refrigerated cargo damage claims, including cold chain integrity assessments.',
    `report_language_codes` STRING COMMENT 'Pipe-delimited list of ISO 639-1 language codes in which the surveyor is capable of producing survey reports. Supports multi-jurisdictional claim handling where local language reports are required by customs or courts.',
    `sla_attendance_hours` STRING COMMENT 'Contractually agreed maximum number of hours within which the surveyor must physically attend the cargo location after being engaged. Critical for time-sensitive perishable or dangerous goods claims.',
    `sla_turnaround_hours` STRING COMMENT 'Contractually agreed maximum number of hours within which the surveyor must deliver a completed survey report from the time of engagement notification. Used for SLA monitoring and performance scoring.',
    `specialization_codes` STRING COMMENT 'Pipe-delimited list of specialization codes indicating the cargo types and transport modes the surveyor is qualified to assess (e.g., MARINE_CARGO|AIR_CARGO|ROAD_FREIGHT|DANGEROUS_GOODS|REFRIGERATED|BULK|BREAKBULK|CONTAINER). Used for automated surveyor matching to claim type. [ENUM-REF-CANDIDATE: MARINE_CARGO|AIR_CARGO|ROAD_FREIGHT|RAIL_FREIGHT|DANGEROUS_GOODS|REFRIGERATED|BULK|BREAKBULK — promote to reference product]',
    `standard_survey_rate` DECIMAL(18,2) COMMENT 'Standard fee charged by the surveyor per survey engagement, expressed in the engagement rate currency. Used as the baseline for claim cost estimation and insurer reimbursement calculations.',
    `surveyor_status` STRING COMMENT 'Current operational status of the surveyor in Transport Shippings approved panel. Active surveyors are eligible for engagement; suspended or blacklisted surveyors are blocked from new assignments pending review.. Valid values are `active|inactive|suspended|pending_approval|blacklisted`',
    `surveyor_type` STRING COMMENT 'Classification of the surveyor entity indicating whether it is an individual independent surveyor, a specialist surveying firm, a loss adjuster, or a marine average adjuster. Drives engagement workflow and rate card selection.. Valid values are `individual|firm|loss_adjuster|average_adjuster|independent`',
    `tax_registration_number` STRING COMMENT 'Government-issued tax identification or VAT registration number of the surveyor company. Required for invoice validation, withholding tax determination, and regulatory tax reporting.',
    `total_engagements` STRING COMMENT 'Cumulative count of survey engagements completed by this surveyor for Transport Shipping since panel onboarding. Used for experience weighting in surveyor selection and volume-based rate negotiation.',
    `transport_mode_coverage` STRING COMMENT 'Primary transport mode(s) the surveyor is authorized and experienced to cover for cargo damage assessments. Aligned to Transport Shippings freight forwarding modes: air, ocean, road, rail, or multimodal.. Valid values are `air|ocean|road|rail|multimodal`',
    `travel_expense_policy` STRING COMMENT 'Policy governing how travel and out-of-pocket expenses are handled for the surveyor engagement: included in the standard rate, separately reimbursable, subject to a cap, or not applicable for local surveyors.. Valid values are `included|reimbursable|capped|not_applicable`',
    `turnaround_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage (0.00–100.00) of survey engagements where the surveyor delivered the report within the contracted SLA turnaround hours. Calculated over the trailing 12-month period. Key performance indicator for panel management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the surveyor master record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture, data lineage tracking, and audit compliance.',
    CONSTRAINT pk_surveyor PRIMARY KEY(`surveyor_id`)
) COMMENT 'Master entity representing accredited external cargo surveyors and loss adjusters engaged by Transport Shipping to assess cargo damage and loss. Captures surveyor company name, individual surveyor contacts, accreditation body (e.g., RICS, BIMCO, IUMI), certification numbers, specializations (marine cargo, air cargo, road freight, dangerous goods, refrigerated cargo), geographic coverage zones, standard engagement rates, turnaround SLAs, and historical performance metrics (survey quality scores, turnaround compliance). Used for surveyor selection, engagement management, and quality monitoring.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`claim`.`claimant` (
    `claimant_id` BIGINT COMMENT 'Primary key for claimant',
    `represented_by_claimant_id` BIGINT COMMENT 'Self-referencing FK on claimant (represented_by_claimant_id)',
    `address_line1` STRING COMMENT 'First line of the claimants street address.',
    `address_line2` STRING COMMENT 'Second line of the claimants street address (optional).',
    `aml_flag` BOOLEAN COMMENT 'Indicates whether the claimant is flagged for AML review.',
    `city` STRING COMMENT 'City component of the claimants address.',
    `claim_count` STRING COMMENT 'Total count of claims filed by the claimant.',
    `claimant_category` STRING COMMENT 'Business classification of the claimant for claim processing.',
    `claimant_type` STRING COMMENT 'Category of claimant indicating legal form or role.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the claimants residence.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the claimant record was first created.',
    `date_of_birth` DATE COMMENT 'Birth date of an individual claimant; null for corporate entities.',
    `effective_from` DATE COMMENT 'Date when the claimant became active in the system.',
    `effective_until` DATE COMMENT 'Date when the claimants record is scheduled to become inactive (nullable).',
    `email` STRING COMMENT 'Primary email address used for claimant communications.',
    `external_reference_code` STRING COMMENT 'Identifier of the claimant in an external legacy system.',
    `insurance_policy_number` STRING COMMENT 'Policy number under which the claimant is covered.',
    `claimant_name` STRING COMMENT 'Legal full name of the claimant (person or organization).',
    `national_id_number` STRING COMMENT 'Government‑issued personal identifier (e.g., SSN, passport number).',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the claimant.',
    `phone_number` STRING COMMENT 'Primary telephone number for the claimant.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the claimants address.',
    `preferred_contact_method` STRING COMMENT 'Claimants preferred channel for communications.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating used for underwriting and fraud detection.',
    `sanctions_listed` BOOLEAN COMMENT 'True if the claimant appears on any international sanctions list.',
    `state` STRING COMMENT 'State or province component of the claimants address.',
    `claimant_status` STRING COMMENT 'Current lifecycle status of the claimant record.',
    `tax_id_number` STRING COMMENT 'Corporate or personal tax registration number.',
    `total_claims_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all claims submitted by the claimant.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the claimant record.',
    CONSTRAINT pk_claimant PRIMARY KEY(`claimant_id`)
) COMMENT 'Master reference table for claimant. Referenced by claimant_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_claimant_id` FOREIGN KEY (`claimant_id`) REFERENCES `transport_shipping_ecm`.`claim`.`claimant`(`claimant_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `transport_shipping_ecm`.`claim`.`policy`(`policy_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ADD CONSTRAINT `fk_claim_cargo_claim_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `transport_shipping_ecm`.`claim`.`surveyor`(`surveyor_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ADD CONSTRAINT `fk_claim_claim_event_cargo_survey_id` FOREIGN KEY (`cargo_survey_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_survey`(`cargo_survey_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ADD CONSTRAINT `fk_claim_cargo_survey_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `transport_shipping_ecm`.`claim`.`surveyor`(`surveyor_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_claim_party_id` FOREIGN KEY (`claim_party_id`) REFERENCES `transport_shipping_ecm`.`claim`.`claim_party`(`claim_party_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ADD CONSTRAINT `fk_claim_liability_determination_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `transport_shipping_ecm`.`claim`.`surveyor`(`surveyor_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_claim_party_id` FOREIGN KEY (`claim_party_id`) REFERENCES `transport_shipping_ecm`.`claim`.`claim_party`(`claim_party_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_liability_determination_id` FOREIGN KEY (`liability_determination_id`) REFERENCES `transport_shipping_ecm`.`claim`.`liability_determination`(`liability_determination_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ADD CONSTRAINT `fk_claim_settlement_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `transport_shipping_ecm`.`claim`.`surveyor`(`surveyor_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_claim_party_id` FOREIGN KEY (`claim_party_id`) REFERENCES `transport_shipping_ecm`.`claim`.`claim_party`(`claim_party_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `transport_shipping_ecm`.`claim`.`surveyor`(`surveyor_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_cargo_survey_id` FOREIGN KEY (`cargo_survey_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_survey`(`cargo_survey_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_claim_party_id` FOREIGN KEY (`claim_party_id`) REFERENCES `transport_shipping_ecm`.`claim`.`claim_party`(`claim_party_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ADD CONSTRAINT `fk_claim_subrogation_case_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `transport_shipping_ecm`.`claim`.`settlement`(`settlement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ADD CONSTRAINT `fk_claim_claim_document_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `transport_shipping_ecm`.`claim`.`surveyor`(`surveyor_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ADD CONSTRAINT `fk_claim_reserve_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `transport_shipping_ecm`.`claim`.`policy`(`policy_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_cargo_survey_id` FOREIGN KEY (`cargo_survey_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_survey`(`cargo_survey_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ADD CONSTRAINT `fk_claim_claim_party_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ADD CONSTRAINT `fk_claim_claim_party_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `transport_shipping_ecm`.`claim`.`policy`(`policy_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_cargo_survey_id` FOREIGN KEY (`cargo_survey_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_survey`(`cargo_survey_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_claim_party_id` FOREIGN KEY (`claim_party_id`) REFERENCES `transport_shipping_ecm`.`claim`.`claim_party`(`claim_party_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ADD CONSTRAINT `fk_claim_recovery_action_subrogation_case_id` FOREIGN KEY (`subrogation_case_id`) REFERENCES `transport_shipping_ecm`.`claim`.`subrogation_case`(`subrogation_case_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_cargo_claim_id` FOREIGN KEY (`cargo_claim_id`) REFERENCES `transport_shipping_ecm`.`claim`.`cargo_claim`(`cargo_claim_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_claim_party_id` FOREIGN KEY (`claim_party_id`) REFERENCES `transport_shipping_ecm`.`claim`.`claim_party`(`claim_party_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_liability_determination_id` FOREIGN KEY (`liability_determination_id`) REFERENCES `transport_shipping_ecm`.`claim`.`liability_determination`(`liability_determination_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `transport_shipping_ecm`.`claim`.`settlement`(`settlement_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ADD CONSTRAINT `fk_claim_appeal_surveyor_id` FOREIGN KEY (`surveyor_id`) REFERENCES `transport_shipping_ecm`.`claim`.`surveyor`(`surveyor_id`);
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ADD CONSTRAINT `fk_claim_claimant_represented_by_claimant_id` FOREIGN KEY (`represented_by_claimant_id`) REFERENCES `transport_shipping_ecm`.`claim`.`claimant`(`claimant_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`claim` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `transport_shipping_ecm`.`claim` SET TAGS ('dbx_domain' = 'claim');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` SET TAGS ('dbx_subdomain' = 'claim_registration');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `carbon_offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Transaction Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimant_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `delivery_attempt_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `dg_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Dg Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Claims Handler');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `fulfillment_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Exception Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `last_mile_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Dispatch Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `spot_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Spot Quote Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `surveyor_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `approved_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `cargo_description` SET TAGS ('dbx_business_glossary_term' = 'Cargo Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^CLM-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimant_email` SET TAGS ('dbx_business_glossary_term' = 'Claimant Email Address');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimant_reference` SET TAGS ('dbx_business_glossary_term' = 'Claimant Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimed_pieces` SET TAGS ('dbx_business_glossary_term' = 'Claimed Pieces Count');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `claimed_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Claimed Cargo Weight (kg)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `credit_note_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `damaged_pieces` SET TAGS ('dbx_business_glossary_term' = 'Damaged Pieces Count');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `dangerous_goods_class` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Class');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Shipment Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `finance_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Finance Reserve Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `finance_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `finance_reserve_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `incident_country_code` SET TAGS ('dbx_business_glossary_term' = 'Incident Country Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `incident_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `insurer_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurer Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `liability_convention` SET TAGS ('dbx_business_glossary_term' = 'Liability Convention');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `liability_convention` SET TAGS ('dbx_value_regex' = 'warsaw_montreal|hague_visby|cmr|cim|hamburg_rules|uncitral');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `liability_determination` SET TAGS ('dbx_business_glossary_term' = 'Liability Determination');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `liability_determination` SET TAGS ('dbx_value_regex' = 'carrier_liable|carrier_not_liable|partial_liability|force_majeure|claimant_fault');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Shipment Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Registration Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Claim Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `subrogation_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recovery Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `subrogation_recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `subrogation_recovery_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `subrogation_status` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `subrogation_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|in_progress|recovered|closed');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Cargo Survey Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `survey_report_number` SET TAGS ('dbx_business_glossary_term' = 'Cargo Survey Report Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `time_bar_date` SET TAGS ('dbx_business_glossary_term' = 'Time Bar Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_claim` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` SET TAGS ('dbx_subdomain' = 'claim_registration');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `claim_event_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Event ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Claim Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `cargo_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `dg_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Dg Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `last_mile_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Dispatch Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `affected_pieces` SET TAGS ('dbx_business_glossary_term' = 'Affected Pieces Count');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `cargo_description` SET TAGS ('dbx_business_glossary_term' = 'Cargo Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `declared_cargo_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Cargo Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `declared_cargo_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `declared_cargo_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `declared_cargo_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Cargo Value Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `declared_cargo_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `destination_country` SET TAGS ('dbx_business_glossary_term' = 'Destination Country');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `destination_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `dg_class` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Class');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Event Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'registered|under_survey|liability_assessed|claim_raised|closed|withdrawn');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Event Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'loss|damage|shortage|delay|contamination|dangerous_goods_incident');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `flight_voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Flight or Voyage Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `hawb_number` SET TAGS ('dbx_business_glossary_term' = 'House Air Waybill (HAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `hbl_number` SET TAGS ('dbx_business_glossary_term' = 'House Bill of Lading (HBL) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `incident_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Incident Cause Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `incident_circumstances` SET TAGS ('dbx_business_glossary_term' = 'Incident Circumstances Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `incident_location_country` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Country');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `incident_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `incident_location_name` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `incident_location_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `insurer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `insurer_notified` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notified Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Is Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `liability_convention` SET TAGS ('dbx_business_glossary_term' = 'Liability Convention');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `liability_convention` SET TAGS ('dbx_value_regex' = 'warsaw_montreal|hague_visby|hamburg_rules|cmr|cotif_cim|none');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `liability_limit_sdr` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit (SDR)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `number_of_pieces` SET TAGS ('dbx_business_glossary_term' = 'Number of Pieces');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `origin_country` SET TAGS ('dbx_business_glossary_term' = 'Origin Country');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `origin_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Event Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^CE-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Reported Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_tm|oracle_tms|fourkites|manual');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `survey_required` SET TAGS ('dbx_business_glossary_term' = 'Survey Required Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `time_bar_date` SET TAGS ('dbx_business_glossary_term' = 'Time Bar Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'UN Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_event` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (CBM)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` SET TAGS ('dbx_subdomain' = 'loss_assessment');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `cargo_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Survey ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `container_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `dg_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Dg Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `surveyor_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Report Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `cargo_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume Cubic Meter (CBM)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `cargo_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight (kg)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `commissioned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Commissioned Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `damage_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Damage Cause Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `damage_cause_narrative` SET TAGS ('dbx_business_glossary_term' = 'Damage Cause Narrative');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `damaged_pieces_count` SET TAGS ('dbx_business_glossary_term' = 'Damaged Pieces Count');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `dangerous_goods_class` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Class');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `declared_cargo_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Cargo Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `declared_cargo_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `estimated_loss_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `estimated_loss_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `insurer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Insurer Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `joint_survey_indicator` SET TAGS ('dbx_business_glossary_term' = 'Joint Survey Indicator');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `liability_attribution` SET TAGS ('dbx_business_glossary_term' = 'Liability Attribution');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `liability_attribution` SET TAGS ('dbx_value_regex' = 'carrier|shipper|consignee|third_party|force_majeure|undetermined');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `liability_convention` SET TAGS ('dbx_business_glossary_term' = 'Liability Convention');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `liability_convention` SET TAGS ('dbx_value_regex' = 'montreal_convention|hague_visby|cmr_convention|cim_convention|warsaw_convention');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `liability_limit_sdr` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Special Drawing Rights (SDR)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `missing_pieces_count` SET TAGS ('dbx_business_glossary_term' = 'Missing Pieces Count');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `number_of_pieces` SET TAGS ('dbx_business_glossary_term' = 'Number of Pieces');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `photographic_evidence_indicator` SET TAGS ('dbx_business_glossary_term' = 'Photographic Evidence Indicator');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `salvage_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `subrogation_applicable` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Applicable Indicator');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Location Country Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_location_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Location Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_methodology` SET TAGS ('dbx_business_glossary_term' = 'Survey Methodology');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_methodology` SET TAGS ('dbx_value_regex' = 'physical_inspection|documentary_review|joint_inspection|remote_assessment|sampling');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_reference_number` SET TAGS ('dbx_value_regex' = '^SRV-[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_report_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Report Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|commissioned|in_progress|completed|cancelled|disputed');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'loss|damage|shortage|delay|contamination|dangerous_goods');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `surveyor_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Recommendations');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`cargo_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` SET TAGS ('dbx_subdomain' = 'loss_assessment');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `liability_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Determination ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `claim_party_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Determination Officer ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `surveyor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Determination Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `cargo_declared_value` SET TAGS ('dbx_business_glossary_term' = 'Cargo Declared Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `cargo_declared_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `cargo_declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Cargo Declared Value Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `cargo_declared_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `cargo_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight (kg)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `carrier_liability_pct` SET TAGS ('dbx_business_glossary_term' = 'Carrier Liability Percentage');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `carrier_liability_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'loss|damage|delay|shortage|misdelivery|dangerous_goods');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `consignee_liability_pct` SET TAGS ('dbx_business_glossary_term' = 'Consignee Liability Percentage');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `consignee_liability_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `contributory_negligence_flag` SET TAGS ('dbx_business_glossary_term' = 'Contributory Negligence Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Delay Hours');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Liability Determination Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `determination_number` SET TAGS ('dbx_business_glossary_term' = 'Liability Determination Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `determination_number` SET TAGS ('dbx_value_regex' = '^LD-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `determination_status` SET TAGS ('dbx_business_glossary_term' = 'Liability Determination Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `determination_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|disputed|withdrawn|closed');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms) Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `legal_basis_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `liability_basis` SET TAGS ('dbx_business_glossary_term' = 'Liability Basis');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `liability_basis` SET TAGS ('dbx_value_regex' = 'per_kg|per_package|per_unit|declared_value|ad_valorem');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `liability_convention` SET TAGS ('dbx_business_glossary_term' = 'Liability Convention');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `liability_exclusion_type` SET TAGS ('dbx_business_glossary_term' = 'Liability Exclusion Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `liability_exclusion_type` SET TAGS ('dbx_value_regex' = 'act_of_god|inherent_vice|shipper_fault|war_risk|nuclear|none');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `liability_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `liability_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `liability_limit_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Per Unit');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `liability_limit_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `limitation_period_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Limitation Period Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `maximum_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Liability Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `maximum_liability_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `maximum_liability_currency` SET TAGS ('dbx_business_glossary_term' = 'Maximum Liability Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `maximum_liability_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `negligence_description` SET TAGS ('dbx_business_glossary_term' = 'Contributory Negligence Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Claims Reserve Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `reserve_currency` SET TAGS ('dbx_business_glossary_term' = 'Claims Reserve Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `reserve_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `settlement_recommendation_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Recommendation Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `settlement_recommendation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `settlement_recommendation_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Recommendation Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `settlement_recommendation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `shipper_liability_pct` SET TAGS ('dbx_business_glossary_term' = 'Shipper Liability Percentage');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `shipper_liability_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `subrogation_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `subrogation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `survey_report_number` SET TAGS ('dbx_business_glossary_term' = 'Cargo Survey Report Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`liability_determination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` SET TAGS ('dbx_subdomain' = 'financial_resolution');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Settlement ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `claim_party_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `liability_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Determination Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `surveyor_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Acceptance Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Acceptance Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|disputed|withdrawn');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `actual_settlement_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Settlement Days');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Approval Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'loss|damage|delay|shortage|misdelivery|dangerous_goods');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `insurer_correspondence_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurer Correspondence Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `insurer_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurer Recovery Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `insurer_recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `insurer_recovery_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `liability_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `liability_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|credit_note|cheque|offset|cash');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `reserve_release_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Release Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `reserve_release_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `reserve_release_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_value_regex' = '^STL-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|paid|rejected|withdrawn');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'full|partial|ex_gratia|subrogation|credit_note');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `sla_settlement_target_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Service Level Agreement (SLA) Target Days');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|SALESFORCE_CRM|MANUAL|LEGACY');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `subrogation_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `subrogation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `subrogation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `subrogation_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Initiated Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`settlement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` SET TAGS ('dbx_subdomain' = 'claim_registration');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Status History ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `claim_party_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `surveyor_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^CLM-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `credit_note_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `days_in_previous_status` SET TAGS ('dbx_business_glossary_term' = 'Days in Previous Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `delay_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Delay Claim Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `from_status_code` SET TAGS ('dbx_business_glossary_term' = 'From Status Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `insurer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Insurer Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `liability_convention_code` SET TAGS ('dbx_business_glossary_term' = 'Liability Convention Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `liability_convention_code` SET TAGS ('dbx_value_regex' = 'WARSAW_MONTREAL|CMR|HAGUE_VISBY|CIM|DOMESTIC');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `liability_determination_code` SET TAGS ('dbx_business_glossary_term' = 'Liability Determination Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `liability_determination_code` SET TAGS ('dbx_value_regex' = 'FULL_LIABILITY|PARTIAL_LIABILITY|NO_LIABILITY|SHARED_LIABILITY|PENDING');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Notes');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `regulatory_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'CLAIMS_HANDLER|SURVEYOR|INSURER|LEGAL_COUNSEL|CUSTOMER|SYSTEM');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `settlement_offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Offer Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `settlement_offer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `sla_target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SALESFORCE_CRM|SAP_S4HANA|ORACLE_TMS|MANUAL');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `source_system_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `subrogation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `survey_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `to_status_code` SET TAGS ('dbx_business_glossary_term' = 'To Status Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `transition_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transition Reason Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `transition_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Transition Reason Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'AIR|OCEAN|ROAD|RAIL|MULTIMODAL');
ALTER TABLE `transport_shipping_ecm`.`claim`.`status_history` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` SET TAGS ('dbx_subdomain' = 'financial_resolution');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `subrogation_case_id` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Case ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `cargo_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Survey Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `claim_party_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent (Liable Third Party) ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Claims Handler');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Settlement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer Party ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Letter Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `arbitration_body` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Body Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Case Notes');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `case_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Case Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `case_reference_number` SET TAGS ('dbx_value_regex' = '^SUB-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Case Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Case Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Case Closure Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `court_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Court Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `dangerous_goods_un_number` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods UN Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `dangerous_goods_un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `demand_letter_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Letter Issued Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `external_legal_counsel` SET TAGS ('dbx_business_glossary_term' = 'External Legal Counsel Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `external_legal_counsel` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms) Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `legal_costs_incurred` SET TAGS ('dbx_business_glossary_term' = 'Legal Costs Incurred');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `legal_costs_incurred` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `legal_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Filing Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `liability_convention` SET TAGS ('dbx_business_glossary_term' = 'Applicable Liability Convention');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `liability_convention` SET TAGS ('dbx_value_regex' = 'CMR|Warsaw_Montreal|Hague_Visby|Hamburg_Rules|COTIF_CIM|domestic');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Convention Liability Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `loss_event_country_code` SET TAGS ('dbx_business_glossary_term' = 'Loss Event Country Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `loss_event_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `loss_event_date` SET TAGS ('dbx_business_glossary_term' = 'Cargo Loss Event Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `loss_event_location` SET TAGS ('dbx_business_glossary_term' = 'Cargo Loss Event Location');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Case Opened Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `recovery_amount_received` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount Received');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `recovery_amount_received` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `recovery_amount_sought` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount Sought');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `recovery_amount_sought` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `recovery_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Recovery Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `recovery_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `recovery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `recovery_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Reserve Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `respondent_insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Respondent Insurer Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `respondent_insurer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `respondent_insurer_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Respondent Insurer Policy Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `respondent_insurer_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `respondent_party_type` SET TAGS ('dbx_business_glossary_term' = 'Respondent Party Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `respondent_response_date` SET TAGS ('dbx_business_glossary_term' = 'Respondent Response Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Settlement Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `statute_of_limitations_date` SET TAGS ('dbx_business_glossary_term' = 'Statute of Limitations Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`subrogation_case` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` SET TAGS ('dbx_subdomain' = 'claim_registration');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `claim_document_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Document ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `dg_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Dg Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `surveyor_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|edi|portal|post|fax|api');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Document Direction');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'supporting_evidence|legal_correspondence|transport_document|customs_document|financial_document|survey_report');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `document_source` SET TAGS ('dbx_business_glossary_term' = 'Document Source');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'pending|received|under_review|accepted|rejected|superseded');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'Document File Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Document File Size (KB)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `hawb_number` SET TAGS ('dbx_business_glossary_term' = 'House Air Waybill (HAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `hbl_number` SET TAGS ('dbx_business_glossary_term' = 'House Bill of Lading (HBL) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `insurer_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurer Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Is Dangerous Goods Document Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `is_latest_version` SET TAGS ('dbx_business_glossary_term' = 'Is Latest Version Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Document Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Document Language Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Document Page Count');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Received Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Document Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Response Received Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'awaiting_response|response_received|no_response_required|overdue');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Reviewed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Sent Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `storage_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `upload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Upload Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` SET TAGS ('dbx_subdomain' = 'financial_resolution');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Reserve ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Policy Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Review Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'cargo_loss|cargo_damage|delay|shortage|misdelivery|dangerous_goods');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Reserve Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `current_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Reserve Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `current_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `days_reserve_open` SET TAGS ('dbx_business_glossary_term' = 'Days Reserve Open');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Establishment Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `expected_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Settlement Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `initial_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Reserve Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `initial_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `insurer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notification Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `insurer_notified` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notified Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `last_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `last_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `last_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `last_adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Reason Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `last_adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'new_evidence|survey_update|legal_development|settlement_negotiation|subrogation_recovery|reserve_adequacy_review');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `liability_convention` SET TAGS ('dbx_business_glossary_term' = 'Liability Convention');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `liability_convention` SET TAGS ('dbx_value_regex' = 'warsaw_montreal|cmr|hague_visby|cotif_cim|imdg|domestic');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reserve Notes');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `release_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Release Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `release_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Release Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Reserve Release Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `release_reason` SET TAGS ('dbx_value_regex' = 'claim_settled|claim_withdrawn|claim_denied|subrogation_recovered|statute_expired|management_decision');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `reserve_number` SET TAGS ('dbx_business_glossary_term' = 'Reserve Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `reserve_number` SET TAGS ('dbx_value_regex' = '^RES-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_value_regex' = 'open|adjusted|partially_released|fully_released|closed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `reserve_type` SET TAGS ('dbx_business_glossary_term' = 'Reserve Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `reserve_type` SET TAGS ('dbx_value_regex' = 'initial|supplemental|subrogation|salvage|litigation');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `subrogation_potential` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Potential Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `subrogation_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recovery Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `subrogation_recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `total_adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustments Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `total_adjustments_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` SET TAGS ('dbx_subdomain' = 'claim_registration');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `cargo_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Survey Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `declaration_line_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `approved_value` SET TAGS ('dbx_business_glossary_term' = 'Approved Claim Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `approved_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `approved_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `claim_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Filing Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'loss|damage|shortage|delay|contamination|pilferage');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `claimed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Claimed Quantity');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `claimed_value` SET TAGS ('dbx_business_glossary_term' = 'Claimed Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `claimed_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `claimed_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `condition_at_destination` SET TAGS ('dbx_business_glossary_term' = 'Cargo Condition at Destination');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `condition_at_destination` SET TAGS ('dbx_value_regex' = 'good|damaged|wet|open|repackaged|missing');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `condition_at_origin` SET TAGS ('dbx_business_glossary_term' = 'Cargo Condition at Origin');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `condition_at_origin` SET TAGS ('dbx_value_regex' = 'good|damaged|wet|open|repackaged|unknown');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `damage_category` SET TAGS ('dbx_business_glossary_term' = 'Damage Category');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `dangerous_goods_class` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Class');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `dangerous_goods_class` SET TAGS ('dbx_value_regex' = '^(Class [1-9]|Division [1-9].[0-9A-Z])?$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (KG)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `insurer_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurer Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `liability_basis` SET TAGS ('dbx_business_glossary_term' = 'Liability Basis');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `liability_basis` SET TAGS ('dbx_value_regex' = 'montreal_convention|cmr_convention|hague_visby|cotif|contractual|waiver');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `liability_cap_value` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `liability_cap_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `liability_cap_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|under_review|approved|rejected|settled|withdrawn');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `loss_discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Discovery Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'PCS|KG|CBM|CTN|PLT|BAG');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `salvage_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `salvage_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `subrogation_recovery_value` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recovery Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `subrogation_recovery_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `subrogation_recovery_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Cargo Survey Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `unit_value` SET TAGS ('dbx_business_glossary_term' = 'Unit Value');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `unit_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `unit_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`line` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Cubic Metres (CBM)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` SET TAGS ('dbx_subdomain' = 'claim_registration');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `claim_party_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Party ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Policy Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `aeo_number` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Party Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Party Contact Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Party Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Party Country Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `dispute_raised` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_value_regex' = 'liability_denied|amount_disputed|documentation_incomplete|time_bar|jurisdiction|other');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `document_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Document Submission Deadline');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `documents_received` SET TAGS ('dbx_business_glossary_term' = 'Documents Received Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `imo_number` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Organization (IMO) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `legal_representation_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Representation Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `legal_representation_type` SET TAGS ('dbx_value_regex' = 'in_house|external_counsel|none');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `liability_accepted` SET TAGS ('dbx_business_glossary_term' = 'Liability Accepted Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `liability_currency` SET TAGS ('dbx_business_glossary_term' = 'Liability Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `liability_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `liability_framework` SET TAGS ('dbx_business_glossary_term' = 'Liability Framework');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `liability_framework` SET TAGS ('dbx_value_regex' = 'warsaw_montreal|cmr|hague_visby|cotif|domestic|contractual');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `liability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Liability Percentage');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|post|edi|portal|fax');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'pending|sent|acknowledged|overdue');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `party_role` SET TAGS ('dbx_business_glossary_term' = 'Claim Party Role');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Party Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|notified|responded|disputed|settled|withdrawn');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Party Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'organisation|individual|government_body|regulatory_authority');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `power_of_attorney` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `primary_party` SET TAGS ('dbx_business_glossary_term' = 'Primary Party Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Party Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `response_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Received Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `subrogation_applicable` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `subrogation_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Recovery Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `subrogation_recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `survey_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Survey Report Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `surveyor_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Accreditation Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `time_bar_date` SET TAGS ('dbx_business_glossary_term' = 'Time Bar Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claim_party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` SET TAGS ('dbx_subdomain' = 'financial_resolution');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Policy ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `aggregate_annual_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Annual Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `aggregate_annual_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `broker_reference` SET TAGS ('dbx_business_glossary_term' = 'Broker Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `cancellation_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Period (Days)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `cargo_category` SET TAGS ('dbx_business_glossary_term' = 'Cargo Category');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `cargo_category` SET TAGS ('dbx_value_regex' = 'general|perishable|dangerous_goods|high_value|fragile|bulk');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `claims_filing_period_days` SET TAGS ('dbx_business_glossary_term' = 'Claims Filing Period (Days)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `claims_notification_period_days` SET TAGS ('dbx_business_glossary_term' = 'Claims Notification Period (Days)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `co_insurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Insurance Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `co_insurance_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Co-Insurance Share Percentage');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `coverage_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `coverage_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `coverage_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `coverage_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `covered_transport_modes` SET TAGS ('dbx_business_glossary_term' = 'Covered Transport Modes');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `dangerous_goods_covered` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Covered Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `declaration_period_days` SET TAGS ('dbx_business_glossary_term' = 'Declaration Period (Days)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `declaration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Declaration Required Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `deductible_type` SET TAGS ('dbx_business_glossary_term' = 'Deductible Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `deductible_type` SET TAGS ('dbx_value_regex' = 'fixed|percentage|franchise|nil');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'arbitration|litigation|mediation|expert_determination');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Policy Exclusions');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'worldwide|regional|domestic|cross_border');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurer Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `insurer_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurer Policy Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `insurer_policy_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Policy Issuing Country');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `liability_basis` SET TAGS ('dbx_business_glossary_term' = 'Liability Basis');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `liability_basis` SET TAGS ('dbx_value_regex' = 'invoice_value|declared_value|market_value|replacement_cost');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `open_cover_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Cover Policy Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `per_shipment_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Shipment Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `per_shipment_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|cancelled|pending_renewal|lapsed');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'all_risk|named_perils|war_risk|total_loss_only|open_cover');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `reinsurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Renewal Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `subrogation_rights` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Rights Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `survey_required_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Survey Required Threshold Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` SET TAGS ('dbx_subdomain' = 'financial_resolution');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `recovery_action_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `cargo_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Survey Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `claim_party_id` SET TAGS ('dbx_business_glossary_term' = 'Liable Party ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Handler ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `subrogation_case_id` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Case Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Filing Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_notes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Notes');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_outcome` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Outcome');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_outcome` SET TAGS ('dbx_value_regex' = 'full_recovery|partial_recovery|no_recovery|withdrawn|pending_judgment');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_value_regex' = '^RA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|responded|settled|closed|withdrawn');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'demand_letter|legal_filing|arbitration|settlement_negotiation|mediation|subrogation_notice');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `arbitration_body` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Body');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `court_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `demanded_amount` SET TAGS ('dbx_business_glossary_term' = 'Demanded Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `demanded_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `demanded_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `external_counsel_reference` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `external_counsel_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `insurer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Insurer Notification Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `insurer_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurer Share Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `insurer_share_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `insurer_share_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `jurisdiction_country` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `jurisdiction_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `legal_costs` SET TAGS ('dbx_business_glossary_term' = 'Legal Costs');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `legal_costs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `legal_costs` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `liability_convention` SET TAGS ('dbx_business_glossary_term' = 'Liability Convention');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `liability_convention` SET TAGS ('dbx_value_regex' = 'warsaw_montreal|cmr|hague_visby|cotif_cim|uncitral');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `liable_party_name` SET TAGS ('dbx_business_glossary_term' = 'Liable Party Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `liable_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `liable_party_type` SET TAGS ('dbx_business_glossary_term' = 'Liable Party Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `liable_party_type` SET TAGS ('dbx_value_regex' = 'sub_carrier|port_operator|freight_handler|warehouse_operator|customs_broker|nvocc');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `limitation_period_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Limitation Period Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `loss_type` SET TAGS ('dbx_business_glossary_term' = 'Loss Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `loss_type` SET TAGS ('dbx_value_regex' = 'total_loss|partial_loss|damage|delay|misdelivery|pilferage');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `net_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Recovery Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `net_recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `net_recovery_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Priority Level');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `recovery_basis` SET TAGS ('dbx_business_glossary_term' = 'Recovery Basis');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `recovery_basis` SET TAGS ('dbx_value_regex' = 'subrogation|direct_carrier_recovery|contractual_indemnity|tort_claim');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `recovery_currency` SET TAGS ('dbx_business_glossary_term' = 'Recovery Currency');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `recovery_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `settlement_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `settlement_agreement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `statutory_liability_limit` SET TAGS ('dbx_business_glossary_term' = 'Statutory Liability Limit');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `statutory_liability_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `statutory_liability_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`recovery_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` SET TAGS ('dbx_subdomain' = 'loss_assessment');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Appeal ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `claim_party_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reviewer ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `liability_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Determination Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Insurer ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `surveyor_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Lodgement Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `appeal_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `appeal_number` SET TAGS ('dbx_value_regex' = '^APL-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_value_regex' = 'full_rejection_appeal|partial_settlement_appeal|liability_dispute|quantum_dispute|delay_claim_appeal|dangerous_goods_appeal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `arbitration_reference` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `claimant_reference` SET TAGS ('dbx_business_glossary_term' = 'Claimant Reference Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `claimed_appeal_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Appeal Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `claimed_appeal_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Closure Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|postal|portal|edi|fax');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `credit_note_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `evidence_received_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Received Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `evidence_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submitted Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `finance_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Finance Reserve Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `finance_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `grounds_for_appeal` SET TAGS ('dbx_business_glossary_term' = 'Grounds for Appeal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Notes');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `liability_convention` SET TAGS ('dbx_business_glossary_term' = 'Liability Convention');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `liability_convention` SET TAGS ('dbx_value_regex' = 'montreal_convention|warsaw_convention|cmr_convention|hague_visby_rules|cotif_cim|uncitral');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `original_claim_decision` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Decision');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `original_claim_decision` SET TAGS ('dbx_value_regex' = 'rejected|partially_settled|settled');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Appeal Priority');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `regulatory_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Review Outcome');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'upheld|partially_upheld|rejected|referred_to_arbitration|withdrawn');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `review_outcome_rationale` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome Rationale');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Review Start Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `revised_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `revised_settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `sla_breached_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal SLA (Service Level Agreement) Due Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `statutory_time_bar_date` SET TAGS ('dbx_business_glossary_term' = 'Statutory Time Bar Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`claim`.`appeal` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` SET TAGS ('dbx_subdomain' = 'loss_assessment');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `surveyor_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Master ID');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Reference');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `blacklist_reason` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Reason');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Company Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Company Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Name');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `customs_compliance_cleared` SET TAGS ('dbx_business_glossary_term' = 'Customs Compliance Clearance Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `dangerous_goods_certified` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `engagement_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate Currency Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `engagement_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `geographic_coverage_zones` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Zones');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Hourly Rate');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Insurance Coverage Amount');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Insurance Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Professional Indemnity Insurance Policy Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `last_engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Survey Engagement Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Notes');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `panel_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Panel Approval Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `panel_review_date` SET TAGS ('dbx_business_glossary_term' = 'Panel Review Date');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|immediate');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Language Code');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Survey Quality Score');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `refrigerated_cargo_certified` SET TAGS ('dbx_business_glossary_term' = 'Refrigerated Cargo Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `report_language_codes` SET TAGS ('dbx_business_glossary_term' = 'Survey Report Language Codes');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `sla_attendance_hours` SET TAGS ('dbx_business_glossary_term' = 'Survey Attendance Service Level Agreement (SLA) Hours');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `sla_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Survey Report Turnaround Service Level Agreement (SLA) Hours');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `specialization_codes` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Specialization Codes');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `standard_survey_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Survey Engagement Rate');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `standard_survey_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `surveyor_status` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Lifecycle Status');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `surveyor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blacklisted');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `surveyor_type` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Type');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `surveyor_type` SET TAGS ('dbx_value_regex' = 'individual|firm|loss_adjuster|average_adjuster|independent');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `total_engagements` SET TAGS ('dbx_business_glossary_term' = 'Total Survey Engagements Count');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `transport_mode_coverage` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode Coverage');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `transport_mode_coverage` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `travel_expense_policy` SET TAGS ('dbx_business_glossary_term' = 'Travel Expense Policy');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `travel_expense_policy` SET TAGS ('dbx_value_regex' = 'included|reimbursable|capped|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `turnaround_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Service Level Agreement (SLA) Compliance Rate');
ALTER TABLE `transport_shipping_ecm`.`claim`.`surveyor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` SET TAGS ('dbx_subdomain' = 'claim_registration');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `claimant_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Identifier');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `represented_by_claimant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `claimant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `claimant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `total_claims_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`claim`.`claimant` ALTER COLUMN `total_claims_amount` SET TAGS ('dbx_pii_financial' = 'true');
