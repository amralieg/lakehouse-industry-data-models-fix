# Water_Utilities Lakehouse Data Model

**v2_mvm** generated using Vibe Modelling Agent on June 22, 2026 at 08:12 PM

This document outlines a vibed Lakehouse data model for the Water_Utilities business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Asset](#domain-asset)
  - [Distribution](#domain-distribution)
  - [Metering](#domain-metering)
  - [Quality](#domain-quality)
  - [Treatment](#domain-treatment)
  - [Wastewater](#domain-wastewater)
  - [Billing](#domain-billing)
  - [Customer](#domain-customer)
  - [Compliance](#domain-compliance)
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
| `schemas/` | `water_utilities_<domain>_schema_v2_mvm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `water_utilities_catalogs_v2_mvm.sql` (catalog-level DDL) |
| `metrics/` | `water_utilities_<domain>_metrics_v2_mvm.sql` (one file per domain) |
| `docs/` | `water_utilities_model_v2_mvm.xlsx`, `water_utilities_model_v2_mvm.csv`, `releasenotes.txt` |
| `diagram/` | `water_utilities_dbml_v2_mvm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `water_utilities_rdf_v2_mvm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | MVM (Minimum Viable Model) |
| Total Domains | 9 |
| Total Subdomains | 23 |
| Total Products | 79 |
| Total Attributes | 3438 |
| Primary Keys | 79 |
| Foreign Keys | 387 |
| Avg Attributes/Product | 43.5 |
| Metric Views | 62 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Water_Utilities | Water_Utilities | MVM (Minimum Viable Model) | water utilities industry enterprise data model. |  | 2 |

## Business Domains & Subdomains

<a id="domain-asset"></a>

### Domain: Asset

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| asset | operations | 2 | Enterprise asset management domain owning the full lifecycle of physical infrastructure assets including WTP/WWTP equipment, pipes, pumps, valves, electrical systems, and vehicles. Manages asset registry, condition assessments, criticality ratings, preventive and corrective maintenance, work order management, depreciation schedules, and CAPEX/OPEX planning. Integrates with IBM Maximo CMMS and SAP PM. | 8 |

**Subdomains:** asset_inventory, maintenance_operations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| asset_inventory | acquisition | transactional_data | Records the acquisition of new assets into the utility's asset base, capturing acquisition type (purchase, construction, donation, transfer), acquisition date, purchase order reference, vendor/contractor, acquisition cost, funding source (CAPEX, grant, developer contribution), commissioning date, and initial condition grade. Triggers creation of the asset_registry record and depreciation_schedule. Integrates with SAP MM purchase orders and SAP FI asset capitalization. | 36 |
| asset_inventory | class | reference_data | Reference taxonomy defining the classification hierarchy for utility assets (e.g., Mechanical, Electrical, Civil, Instrumentation, Vehicle). Each class carries default useful life, depreciation method, maintenance strategy, criticality weighting rules, and applicable regulatory standards. Used to drive preventive maintenance scheduling, CAPEX planning, and ISO 55001 asset management framework alignment. [SSOT: Canonical asset classification taxonomy; service.service_class references this as SSOT] [SSOT: governed by service.service_class] [DEPRECATED: Single source of truth is service.service_class] | 41 |
| asset_inventory | location | master_data | Hierarchical location registry defining where assets are physically installed or stored — from service territory down to facility, building, floor, room, and GIS coordinate. Supports Esri ArcGIS integration with spatial reference data (latitude, longitude, elevation, DMA zone, pressure zone, watershed). Enables location-based maintenance routing, network topology analysis, and regulatory reporting by geographic jurisdiction. | 41 |
| asset_inventory | registry | master_data | Master record for every physical infrastructure asset owned or operated by the utility, including WTP/WWTP equipment, pipes, pumps, valves, electrical systems, meters, and vehicles. Captures asset identity, classification, installation details, location (GIS coordinates), manufacturer, model, serial number, asset tag, parent-child hierarchy, operational status, and lifecycle dates. This is the authoritative SSOT for all physical assets — the IBM Maximo asset master and SAP PM equipment master both synchronize to this record. | 47 |
| maintenance_operations | condition_assessment | transactional_data | Records the results of all formal assessments and inspections performed on infrastructure assets, encompassing both scored condition evaluations (condition grade 1-5 per AWWA/WRF standards, structural integrity score, remaining useful life estimate, failure probability) and regulatory/compliance inspections (EPA, state primacy agency, OSHA requirements). Captures assessment date, type (condition-scoring, regulatory-compliance, routine-operational, post-incident, pre-commissioning), method (visual, CCTV, acoustic, vibration analysis, ultrasonic thickness, leak detection), inspector identity and certification, checklist/protocol used, pass/fail outcome, deficiencies identified, corrective action required flag, recommended intervention, and regulatory permit reference. A single unified record for any event where an asset is formally evaluated — whether for condition scoring, compliance verification, or operational readiness. Drives asset renewal prioritization, CIP planning, regulatory inspection compliance tracking, and OSHA safety audit evidence. Integrates with IBM Maximo inspection records and supports EPA/state primacy agency reporting requirements. | 43 |
| maintenance_operations | failure_record | transactional_data | Documents asset failure events including failure date and time, failure mode, failure cause, failure effect, affected system, downtime duration, service impact (customers affected, MGD lost, PSI drop), emergency response actions taken, and root cause analysis findings. Supports reliability-centered maintenance (RCM) analysis, MTBF/MTTR calculations, and regulatory SSO/CSO incident reporting. Linked to corrective work orders in IBM Maximo. | 42 |
| maintenance_operations | pm_schedule | master_data | Defines preventive maintenance schedules for assets, including maintenance task description, trigger type (calendar-based, meter-based, condition-based), frequency or interval, last performed date, next due date, estimated labor hours, required skill certifications, and associated job plan. Drives automatic work order generation in IBM Maximo. Supports AWWA O&M best practices and regulatory inspection compliance requirements. | 43 |
| maintenance_operations | work_order | transactional_data | Core transactional record for all maintenance activities — preventive (PM), corrective (CM), predictive (PdM), and emergency work orders. Captures work type, priority, originating asset, assigned crew/technician, scheduled and actual start/finish dates, labor hours, failure code, cause code, remedy code, downtime duration, and work order cost. Includes material line items: parts consumed or reserved with quantity, unit cost, issue date, storeroom, and reservation status. Enables actual vs. planned cost tracking (labor, material, contractor/service, overhead) per work order with GL account code and cost center. The authoritative SSOT for maintenance execution and O&M cost accounting, synchronized with IBM Maximo Work Order and SAP PM Order. Supports rate case cost justification and AWWA benchmarking. | 39 |

<a id="domain-distribution"></a>

### Domain: Distribution

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| distribution | operations | 3 | Owns the potable water distribution network topology, hydraulic modeling, and operational data including mains, service lines, valves, PRVs, hydrants, pump stations, storage tanks, DMAs, and pressure zones. Integrates with Esri ArcGIS and Innovyze InfoWater for network modeling, NRW/UFW analysis, and pressure (PSI) and flow (GPM/MGD) management. | 10 |

**Subdomains:** network_infrastructure, operational_monitoring, storage_facilities


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| network_infrastructure | dma | master_data | Master record for District Metered Areas (DMAs) — discrete, hydraulically isolated zones of the distribution network used for NRW/UFW monitoring and leakage management. Captures DMA name, boundary description, inlet meter points, outlet meter points, target NRW percentage, minimum night flow (MNF) threshold (GPM), associated pressure zone, GIS polygon boundary, and active status. Core to leakage detection and water loss control programs. | 30 |
| network_infrastructure | hydrant | master_data | Master record for fire hydrants in the distribution network. Captures hydrant type (dry barrel, wet barrel), manufacturer, installation year, GIS location, nearest main pipe, outlet size and count, color coding (flow capacity class per NFPA 291), last flow test date, last inspection date, condition status, and municipality ownership flag. Supports fire flow planning, flushing programs, and regulatory compliance. | 41 |
| network_infrastructure | network_valve | master_data | Master record for all distribution network valves including gate valves, butterfly valves, ball valves, and check valves used for flow control and system isolation. Captures valve type, size (inches), manufacturer, installation year, location (GIS coordinates, street address, nearest main reference), pressure zone, DMA, normal operating position (open/closed), number of turns to operate, last exercised date, condition rating, and CMMS asset reference. Critical for isolation analysis (determining minimum valve closures to isolate a pipe segment) and valve exercising programs. | 39 |
| network_infrastructure | pipe_main | master_data | Water distribution pipe main segments with material, diameter, installation date, condition assessment, break history, and GIS geometry. | 43 |
| network_infrastructure | pressure_zone | master_data | Master record defining hydraulic pressure zones within the distribution network. Captures zone name, target operating pressure range (PSI min/max), design pressure, elevation range, boundary description, associated storage facilities, PRV stations controlling the zone, and Innovyze InfoWater hydraulic model zone reference. Used for pressure management, NRW analysis, and DMA boundary definition. | 32 |
| network_infrastructure | service_line | master_data | Service line connections from main to customer premise, including LCRR lead service line inventory, material verification, and replacement priority. | 41 |
| operational_monitoring | flow_reading | transactional_data | Transactional record of flow measurements (GPM/MGD) captured at DMA inlet/outlet meters, pump station discharge meters, PRV station meters, and bulk transfer points. Sourced from OSIsoft PI Historian SCADA telemetry and AMI bulk meters. Captures reading timestamp, measurement point reference, raw flow value, engineering unit, data quality flag, and source system. Foundation for NRW/UFW water balance calculations and hydraulic model calibration. | 32 |
| operational_monitoring | main_break | transactional_data | Transactional record of distribution network incidents including main breaks (pipe bursts, joint failures), planned shutdowns, and emergency/planned isolation events. Captures incident type, date/time, location (GIS coordinates, address, pipe main reference), failure mode (circumferential, longitudinal, blowout, joint) for breaks, valves operated with sequence for isolations, customers affected count and service addresses, estimated volume lost (gallons), repair method, repair duration, root cause classification, pressure zone impact, crew supervisor, and restoration confirmation timestamp. SSOT for outage management, customer notification, asset renewal prioritization, and regulatory reporting of service interruptions. | 44 |
| storage_facilities | pump_station | master_data | Master record for booster pump stations within the distribution network that maintain pressure and flow across the system. Captures station name, location (GIS), pressure zone served, design flow capacity (GPM/MGD), total dynamic head (TDH), number of pumps, VFD configuration, SCADA integration tags (OSIsoft PI Historian), power supply details, backup generator status, and operational status. Distinct from WTP/WWTP pump stations owned by treatment/wastewater domains. | 45 |
| storage_facilities | storage_tank | master_data | Master record for potable water storage facilities in the distribution network including elevated tanks, ground-level reservoirs, and standpipes. Captures tank type, material, capacity (gallons/MG), operating level range (min/max feet), overflow elevation, pressure zone served, GIS location, SCADA level sensor tags (OSIsoft PI Historian), last inspection date, coating condition, and regulatory inspection status. Supports system storage adequacy and fire flow reserve analysis. | 47 |

<a id="domain-metering"></a>

### Domain: Metering

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| metering | operations | 3 | Owns all metering infrastructure and consumption data including meter inventory, AMI/AMR device management (Sensus FlexNet), meter reads, interval consumption data, leak detection flags, meter accuracy testing, meter replacement programs, and high usage alerts. Serves as the authoritative source for consumption data feeding billing and NRW/UFW analysis. | 10 |

**Subdomains:** device_inventory, meter_maintenance, reading_operations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| device_inventory | ami_endpoint | master_data | Master record for each AMI/AMR communication endpoint device (encoder/receiver/transmitter unit) associated with a meter, and the fixed-network collector infrastructure (base stations, repeaters, mobile collectors) that enables automated reading across the service territory. Captures endpoint serial number, device type, firmware version, network node assignment, signal strength, battery level, last communication timestamp, encryption key version, tamper status, collector assignment, collector location, coverage area, and backhaul connection type. Distinct from the meter itself — one meter may have its endpoint replaced independently. | 42 |
| device_inventory | installation | master_data | Tracks the physical installation of a meter at a service location, linking a specific meter device to a service address and customer account. Records installation date, installer ID, work order reference, meter position (pit, vault, curb box), setter size, service line material, lock/seal number, initial register reading at installation, and removal date when replaced. Maintains the full history of which meter served which location over time, supporting NRW analysis and billing continuity. | 83 |
| device_inventory | meter | master_data | Master inventory record for every physical meter device deployed across the water and wastewater service territory. Captures meter make, model, size, type (AMI/AMR/manual), serial number, manufacturer, installation date, current status, register type, pulse output factor, maximum flow rate (GPM), meter generation, and communication module type. Includes bulk/compound meters, fire service meters, and all residential/commercial/industrial meter classes. Serves as the authoritative SSOT for meter device identity and specifications within the metering domain. | 89 |
| device_inventory | meter_size_type | master_data | Master reference table for meter_size_type.  | 58 |
| meter_maintenance | accuracy_test | transactional_data | Records meter assessment activities including accuracy testing (bench test, in-situ, field test per AWWA M6 standards) and physical field inspections (condition assessment, seal verification, pit/vault inspection, AMI antenna check). Captures assessment date, meter installation reference, assessment type, technician ID, test results (accuracy percentages at low/intermediate/high flow rates for tests; condition ratings and observations for inspections), pass/fail determination, photographic evidence reference, and recommended action. Supports meter replacement program decisions and proactive asset management. | 88 |
| meter_maintenance | replacement_order | transactional_data | Individual work order record for the physical replacement of a meter at a service location, executed as part of a replacement program or triggered by accuracy failure, damage, or customer request. Captures replacement program reference, scheduled date, completion date, old meter ID, new meter ID, technician ID, reason for replacement, old meter final read, new meter initial read, service interruption duration, and Maximo work order number. Bridges the metering domain with the asset and workforce domains. | 68 |
| reading_operations | high_usage_alert | transactional_data | Operational alert record generated when a meter's consumption exceeds a defined threshold relative to historical baseline, seasonal norms, or absolute volume limits. Stores alert generation timestamp, meter installation reference, alert type (high consumption, continuous flow, backflow suspected), threshold value, actual consumption value, percentage over threshold, alert status (open, notified, resolved, dismissed), customer contact attempt log, and resolution notes. Feeds customer service workflows in Microsoft Dynamics 365. | 38 |
| reading_operations | interval_consumption | transactional_data | High-frequency interval consumption data collected from AMI endpoints, typically at 15-minute or hourly intervals. Stores meter installation reference, interval start and end timestamps, consumption volume (gallons), flow rate (GPM), data quality indicator, gap flag, and raw pulse count. Sourced from the AMI head-end system and time-series data historian. Enables leak detection, high-usage alerting, time-of-use analysis, and demand forecasting at sub-daily granularity. | 30 |
| reading_operations | read | transactional_data | Individual meter reading record capturing the register value at a specific point in time for a given meter installation. Stores read date and time, read value (gallons or CCF), read type (AMI automated, AMR drive-by, manual field read, estimated), read source system, reader employee ID (for manual reads), read quality flag, exception code, and whether the read was used for billing. The authoritative transactional record for all meter reads feeding the Oracle CC&B billing cycle. | 76 |
| reading_operations | read_route | master_data | Defines meter reading routes for AMR drive-by, walk-by, or manual reading operations, organizing meter installations into logical geographic sequences for field reader efficiency. Stores route code, name, assigned reader, read frequency, estimated read date, meter count, geographic area, sequence order, and active status. Used by field operations scheduling and coordinates with billing cycle management for timely consumption data delivery. | 60 |

<a id="domain-quality"></a>

### Domain: Quality

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| quality | operations | 3 | Water quality monitoring and compliance including sampling schedules, MCL/MCLG tracking, DBP monitoring (THM, HAA5), PFAS testing, turbidity (NTU), pH, BOD, COD, TSS, TDS, TOC analysis, bacteriological testing, CCR preparation, and regulatory compliance reporting. Manages water quality from source through distribution system and wastewater effluent discharge. | 10 |

**Subdomains:** compliance_monitoring, regulatory_reporting, sampling_infrastructure


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| compliance_monitoring | analytical_result | transactional_data | Analytical result from water quality testing SSOT: This is the canonical source for all water quality analytical results across drinking water, wastewater, and source water monitoring. | 41 |
| compliance_monitoring | contaminant | reference_data | Contaminant master list for water quality monitoring SSOT: This is the canonical master for all contaminant definitions, regulatory limits, and monitoring requirements across all water quality programs. | 73 |
| compliance_monitoring | contaminant_limit | reference_data | Regulatory and operational limits for each contaminant at each applicable monitoring context (drinking water, effluent discharge, source water). Captures MCL, MCLG, action level, treatment technique standard, permit-specific effluent limit (daily max, monthly average), applicable regulation citation, effective date, superseded date, and jurisdiction (federal, state primacy agency). Enables automated compliance comparison against analytical_result values. | 27 |
| compliance_monitoring | exceedance | transactional_data | Transactional record of each confirmed MCL, action level, or permit limit exceedance detected from analytical results. Captures exceedance date, contaminant, sampling point, measured value, applicable limit, exceedance magnitude, regulatory notification deadline, public notification requirement flag, corrective action required, and resolution status. This is the primary operational record driving regulatory response workflows and violation tracking. SSOT: References quality.analytical_result as the canonical source for measured values; this entity captures regulatory exceedance events and response actions. | 25 |
| regulatory_reporting | ccr_period | master_data | Master record for each annual Consumer Confidence Report (CCR) reporting period. Captures report year, water system name, PWSID (Public Water System ID), primacy agency, report preparation status, publication date, distribution method (mailed, posted, electronic), number of customers served, water source summary, detected contaminant summary count, violation summary, and certification submission date to primacy agency. Serves as the organizing entity for all CCR-related quality data aggregation. | 48 |
| regulatory_reporting | water_system | master_data | Master reference table for water_system. Referenced by water_system_id. | 43 |
| sampling_infrastructure | lead_copper_result | transactional_data | Specialized transactional record for Lead and Copper Rule (LCR/LCRR) monitoring at customer tap sampling sites. Captures sampling round (6-month period), customer service line material classification (lead, galvanized, copper, unknown), first-draw sample result (lead ppb, copper ppb), 90th percentile calculation inputs, action level exceedance flag (lead >15 ppb, copper >1300 ppb), tier classification of sampling site, and corrosion control treatment optimization status. Distinct from general analytical_result due to LCRR-specific site selection, tiering, and 90th percentile compliance methodology. | 38 |
| sampling_infrastructure | sampling_point | master_data | Sampling point for water quality monitoring SSOT: Physical sampling point infrastructure is managed in asset.asset_sampling_point; this entity extends it with water quality monitoring context. | 48 |
| sampling_infrastructure | sampling_schedule | master_data | Schedule for water quality sampling activities | 38 |
| sampling_infrastructure | water_sample | transactional_data | Water sample collected for quality testing SSOT: This is the canonical source for water sample collection events; laboratory.lab_sample extends this with LIMS-specific workflow context. | 40 |

<a id="domain-treatment"></a>

### Domain: Treatment

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| treatment | operations | 2 | Authoritative domain for all water treatment and purification operations at WTPs and WWTPs. Owns process data for coagulation, filtration, disinfection (UV, chlorination, RO, UF, MF, GAC), CT compliance, chemical dosing, and finished water production. Integrates with SCADA/OSIsoft PI Historian for real-time process control and MOR regulatory submissions. | 9 |

**Subdomains:** facility_operations, process_monitoring


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| facility_operations | facility | master_data | Water treatment facility master record capturing design capacity, treatment technology, PFAS capability, regulatory classification, and operational status. | 31 |
| facility_operations | process_unit | master_data | Individual treatment process unit (filter, clarifier, GAC contactor, membrane train) with design parameters, PFAS removal capability, media specifications, and operational status. | 33 |
| facility_operations | treatment_permit | master_data | Treatment facility permit record capturing permit number, type, status, effective/expiration dates, permitted capacity, PFAS monitoring requirement, monitoring frequency, and discharge point. | 12 |
| facility_operations | water_source | master_data | Water source master record capturing source name, type, location, capacity, quality characteristics, and regulatory classification. | 9 |
| process_monitoring | chemical | reference_data | Chemical master record capturing chemical name, formula, CAS number, category, PFAS compound flag, PFAS chain length/functional group, US EPA MCL/MCLG, EU DWD inclusion, REACH registration, treatment removal technology, GAC/IX removal efficiency, exposure pathway, and receptor type. | 19 |
| process_monitoring | chemical_dose_event | transactional_data | Chemical dosing event capturing dose rate, mass applied, CT value achieved, compliance status, and cost for chlorine, coagulant, or other treatment chemicals. | 18 |
| process_monitoring | finished_water_production | transactional_data | Daily finished water production record capturing volume produced, average/peak production rate, chlorine residual, CT achieved, turbidity, pH, and regulatory exceedance flags. | 17 |
| process_monitoring | process_reading | transactional_data | Time-series process reading from SCADA or manual entry capturing flow, pressure, chemical dose, turbidity, chlorine residual, CT value, and regulatory compliance flags. | 13 |
| process_monitoring | source_water_intake | transactional_data | Source water intake event capturing volume withdrawn, flow rate, turbidity, TOC, pH, temperature, source type, permit compliance status, and GIS coordinates. | 18 |

<a id="domain-wastewater"></a>

### Domain: Wastewater

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| wastewater | operations | 2 | Manages wastewater collection, conveyance, and treatment operations including sewer network topology, gravity sewers, force mains, lift stations, manholes, CSO/SSO management, I&I monitoring, FOG program management, industrial user permits (IUP), and NPDES compliance tracking. Supports DMR submissions and biosolids management. | 4 |

**Subdomains:** collection_infrastructure, treatment_operations


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| collection_infrastructure | manhole | master_data | Manholes providing access to sewer network with condition and GIS attributes | 33 |
| collection_infrastructure | sewer_network | master_data | Sewer pipe segments in the collection system with hydraulic, condition, and GIS attributes | 40 |
| treatment_operations | sewershed_basin | master_data | Sewershed Basin entity | 42 |
| treatment_operations | wwtp | master_data | Wastewater treatment plants with capacity, permit, and operational attributes | 45 |

<a id="domain-billing"></a>

### Domain: Billing

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| billing | business | 3 | Revenue cycle management including consumption-based billing, rate structures, invoice generation, payment processing, payment plans, collections, delinquency management, billing adjustments, dispute resolution, and revenue recognition. SSOT for all financial transactions with customers including water, wastewater, stormwater, and other utility charges. | 9 |

**Subdomains:** account_rates, invoice_management, payment_processing


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| account_rates | billing_account | master_data | Billing account master [DEPRECATED: Single source of truth is customer.customer_account] | 44 |
| account_rates | rate_component | reference_data | Rate components within rate schedules | 37 |
| account_rates | rate_schedule | reference_data | Billing rate schedules [DEPRECATED: Single source of truth is service.service_rate_schedule] | 29 |
| invoice_management | adjustment | transactional_data | Billing adjustments | 52 |
| invoice_management | invoice | transactional_data | Customer invoice for water, wastewater, and stormwater services | 41 |
| invoice_management | invoice_line | transactional_data | Individual line items on customer invoices | 37 |
| payment_processing | payment | transactional_data | Customer payments received | 38 |
| payment_processing | payment_application | transactional_data | Application of payments to invoices | 34 |
| payment_processing | payment_plan | master_data | Payment plans for delinquent accounts | 28 |

<a id="domain-customer"></a>

### Domain: Customer

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| customer | business | 3 | Single source of truth for all water and wastewater service accounts including residential, commercial, industrial, and municipal customers. Manages customer profiles, service addresses, account hierarchies, customer segments, contact information, service agreements, and customer lifecycle from application through termination. SSOT for customer identity across all billing, metering, and service delivery systems. | 10 |

**Subdomains:** account_management, customer_engagement, service_delivery


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| account_management | account_person_rel | association_data | Association entity capturing the relationship between a person and a water utility account, including the role the person plays (primary account holder, co-applicant, authorized representative, emergency contact, third-party notification recipient). Carries its own business data: relationship type, effective start date, effective end date, notification preferences for this role, and whether the person has billing authority. Supports scenarios such as landlord-tenant relationships, property managers, and third-party bill payers. Required for LCRR lead service line notification compliance. | 30 |
| account_management | customer_account | master_data | Master record for every water and wastewater service account — residential, commercial, industrial, and municipal. Serves as the SSOT for customer identity across Oracle CC&B, SAP, AMI, and all downstream systems. Captures account number, account type (residential/commercial/industrial/municipal), account status (active/inactive/pending/suspended/terminated), service class, credit rating, account open date, account close date, language preference, paperless billing flag, autopay enrollment, lifecycle stage, and water budget allocation (where applicable). This is the primary anchor entity for the customer domain — all billing, metering, service delivery, and regulatory reporting references flow through this entity. | 98 |
| account_management | organization | master_data | Master record for commercial, industrial, and municipal organizations that hold water and wastewater service accounts. Captures legal entity name, DBA name, federal tax ID (EIN), NAICS/SIC industry code, organization type (corporation/LLC/municipality/HOA/government), primary contact name, incorporation state, credit tier, industrial user classification (for IUP purposes), and parent organization reference for corporate hierarchies. Supports B2B account management and industrial pretreatment program tracking. | 43 |
| account_management | person | master_data | Master record for individual persons associated with water utility accounts — account holders, co-applicants, authorized contacts, and guarantors. Captures legal name, date of birth, government ID type and masked number, primary phone, secondary phone, email address, preferred contact method, language preference, identity verification status, and privacy consent flags. Distinct from the account entity: one person may hold multiple accounts (e.g., landlord with multiple rental properties). SSOT for individual identity within the customer domain. | 42 |
| customer_engagement | complaint | transactional_data | Formal record of a customer complaint or grievance filed with the utility, including water quality complaints, billing disputes, service interruption complaints, pressure complaints, odor/taste complaints, and regulatory complaints escalated to the state primacy agency or PUC. Captures complaint number, complaint category, complaint description, reported date, assigned resolution owner, target resolution date, actual resolution date, resolution description, regulatory escalation flag, and customer satisfaction outcome. Distinct from customer_interaction (which captures all contacts) — a complaint has its own formal resolution workflow and regulatory reporting obligations. [SSOT: Canonical complaint record; metering.metering_complaint references this as SSOT] | 66 |
| customer_engagement | service_application | transactional_data | Record of a customer's application to establish, transfer, or modify water and/or wastewater service. Captures application number, application type (new service, transfer, upgrade, downgrade, termination), applicant identity, requested service address, requested service start date, application submission channel (online, phone, walk-in), application status (submitted, under review, approved, rejected, withdrawn), identity verification outcome, credit check result, deposit requirement, and processing timestamps. Represents the start of the customer lifecycle. Sourced from Oracle CC&B and Microsoft Dynamics 365. | 44 |
| service_delivery | contact | master_data | Master record of all contact points, communication preferences, and third-party notification arrangements associated with a customer account or person. Captures contact type (billing, service, emergency, legal notice, third-party notification), contact value, contact channel (phone/email/SMS/postal/portal), is_primary flag, is_verified flag, verification date, opt-in/opt-out status per communication channel, preferred language, notification trigger type (for third-party arrangements: pre-disconnect, outage, boil-water notice), ADA accommodation flags (large print, braille, TTY), relationship to account holder (for third-party contacts), effective date range, and consent documentation reference. Supports multi-channel customer communications including CCR delivery, boil-water notices, outage notifications, TCPA/CAN-SPAM compliance, EPA CCR electronic delivery rules, and state PUC consumer protection rules for third-party notification before disconnection. | 35 |
| service_delivery | premise | master_data | The physical property or facility at which utility service is provided, representing the utility's view of a serviceable location independent of the customer occupying it. Captures premise type (single-family residential, multi-family, commercial, industrial, irrigation, fire protection), lot size, building type, number of units (for multi-family), number of fixture units (for capacity planning), zoning classification, construction year, lead service line status (known lead, galvanized requiring replacement, non-lead, unknown — per LCRR inventory), and whether the premise is subject to low-income assistance programs. Bridges the customer domain to the distribution network and metering domains. Distinct from service_address: a premise is the utility's asset record for the location; service_address is the postal/GIS record. | 43 |
| service_delivery | service_address | master_data | Physical location where water and/or wastewater service is delivered. Captures full street address, city, state, ZIP+4, county, parcel number (APN), GIS coordinates (latitude/longitude), service territory code, pressure zone, DMA (District Metered Area) code, sewer basin, flood zone designation, address validation status, and whether the address is within the utility service boundary. Linked to the distribution network and metering domains via service point. One address may have multiple active accounts over time (tenant turnover). | 33 |
| service_delivery | service_agreement | master_data | The contractual relationship between a customer account and the utility for a specific service type (potable water, wastewater, recycled water, fire protection, irrigation) at a premise. Captures service agreement number, service type, rate schedule code, start date, end date, deposit amount, deposit waiver reason, service class, budget billing enrollment, and agreement status. This is the SSOT for what service a customer is contracted to receive and at what rate. Distinct from billing invoices (which are transactional) and from the rate schedule (which is a reference entity in the service domain). | 80 |

<a id="domain-compliance"></a>

### Domain: Compliance

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| compliance | corporate | 2 | Regulatory compliance management including permit tracking (NPDES, IUP, state primacy agency permits), MOR/DMR preparation and submission, violation management, enforcement action tracking, audit trails, environmental reporting, SDWA and CWA compliance, CCR publication tracking, and regulatory correspondence. Ensures adherence to all federal, state, and local water and wastewater regulations. | 9 |

**Subdomains:** enforcement_tracking, permit_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| enforcement_tracking | enforcement_action | transactional_data | Formal enforcement action initiated by a regulatory agency (EPA, state primacy agency, NPDES authority) against the utility in response to violations, including Notices of Violation (NOVs), Administrative Orders (AOs), Consent Orders, Compliance Schedules, civil penalties, and criminal referrals. Tracks the issuing agency, action type, associated violations, compliance schedule milestones, penalty amounts, response deadlines, legal counsel assigned, and resolution outcome. Drives the utility's formal regulatory response process. | 43 |
| enforcement_tracking | regulatory_agency | master_data | Master reference table for regulatory_agency. Referenced by: compliance.regulatory_submission.regulatory_agency_id, treatment.mor_submission.regulatory_agency_id, treatment.treatment_permit.regulatory_agency_id, treatment.treatment_violation.regulatory_agency_id | 72 |
| enforcement_tracking | regulatory_inspection | transactional_data | Record of regulatory inspections and audits conducted by EPA, state primacy agencies, or other regulatory bodies at utility facilities. Tracks the inspection type (sanitary survey, compliance inspection, pretreatment audit, NPDES inspection), inspecting agency, facility inspected, inspection date, inspector name, findings and deficiencies identified, significant deficiency classifications, required corrective actions, response deadlines, and final inspection report status. Drives post-inspection corrective action tracking. | 39 |
| enforcement_tracking | regulatory_submission | transactional_data | Master record of all formal regulatory submissions made by the utility to regulatory agencies, serving as the single audit trail for submission compliance. Covers DMR submissions (via NetDMR), MOR submissions, CCR certifications, annual compliance reports, pretreatment program reports, SSO/CSO notifications, PFAS reporting, LCRR service line inventory submissions, and Lead Service Line Replacement (LSLR) progress reports. Tracks submission type, receiving agency, submission date, submission method (NetDMR, state portal, paper, email), reporting period, submitter, certifying official, certification status, acknowledgment receipt, late submission flags, and resubmission history. Enables monitoring of submission timeliness — a key compliance metric tracked by state primacy agencies. | 36 |
| enforcement_tracking | violation | transactional_data | Records of regulatory violations including MCL exceedances, monitoring violations, treatment technique violations, and reporting violations with severity, root cause, and resolution tracking. [SSOT: Canonical violation record; treatment.treatment_violation references this as SSOT] | 84 |
| permit_management | compliance_permit | master_data | Master record for all regulatory permits held by the utility including NPDES, SDWA, air quality, and state-level permits with full lifecycle tracking. [SSOT: Canonical permit record; project.project_permit and treatment.treatment_permit reference this as SSOT] | 59 |
| permit_management | obligation | master_data | Trackable compliance obligations derived from permits, regulations, and enforcement actions with due dates, responsible parties, and fulfillment evidence. | 45 |
| permit_management | permit_condition | master_data | Individual conditions, limits, and monitoring requirements attached to a compliance permit including numeric limits, monitoring frequencies, and reporting requirements. | 41 |
| permit_management | regulatory_requirement | master_data | Master catalog of regulatory requirements from federal, state, and international authorities including SDWA NPDWR, NPDES, EU DWD 2020/2184, and state primacy rules with jurisdiction dimension for multi-region support. | 56 |

## Metric Views

Total metric views generated: **62**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | asset_acquisition | asset | acquisition | Capital acquisition KPIs — tracks asset procurement spend, capitalization, warranty coverage, and funding sources to support capital program governance and financial reporting. |
| 2 | asset_condition_assessment | asset | condition_assessment | Asset health and risk KPIs derived from condition assessments — supports rehabilitation prioritization, risk-based asset management, and regulatory compliance for infrastructure renewal programs. |
| 3 | asset_failure_record | asset | failure_record | Asset reliability and failure impact KPIs — measures failure frequency, downtime, cost, and regulatory exposure to drive reliability-centered maintenance and risk mitigation strategies. |
| 4 | asset_pm_schedule | asset | pm_schedule | Preventive maintenance program KPIs — measures PM schedule coverage, cost planning, compliance, and labor resource requirements to optimize maintenance strategy and regulatory adherence. |
| 5 | asset_registry | asset | registry | Strategic KPIs over the asset registry — covers asset portfolio value, replacement exposure, condition health, and lifecycle status for capital planning and risk management decisions. |
| 6 | asset_work_order | asset | work_order | Operational and financial KPIs for work order execution — covers cost performance, labor efficiency, schedule adherence, and compliance for maintenance and capital work management. |
| 7 | distribution_dma | distribution | dma | District Metered Area (DMA) performance and configuration metrics. Tracks NRW/UFW targets, pressure performance, network complexity, and leakage management readiness across the distribution network. Strategic KPI layer for zone-level loss reduction and infrastructure planning. |
| 8 | distribution_flow_reading | distribution | flow_reading | Operational flow telemetry metrics for the distribution network. Tracks volumetric throughput, pressure performance, data quality, and alarm rates across DMAs, meters, and pump stations. Core KPI layer for NRW analysis, hydraulic performance monitoring, and SCADA data governance. |
| 9 | distribution_hydrant | distribution | hydrant | Fire hydrant asset metrics covering flow capacity, inspection compliance, operational readiness, and flushing programme performance. Strategic KPI layer for fire protection service level management, regulatory compliance, and asset renewal planning. |
| 10 | distribution_main_break | distribution | main_break | Main break incident metrics for the distribution network. Tracks break frequency, repair performance, water loss, customer impact, and regulatory exposure. Core KPI layer for infrastructure risk management, capital investment prioritisation, and regulatory compliance reporting. |
| 11 | distribution_network_valve | distribution | network_valve | Network valve asset metrics covering operational readiness, exercising compliance, condition, and isolation capability. Strategic KPI layer for network resilience, maintenance programme management, and emergency response planning. |
| 12 | distribution_pipe_main | distribution | pipe_main | Pipe main asset metrics covering network length, hydraulic capacity, condition, and renewal readiness. Strategic KPI layer for capital investment planning, risk-based asset management, and infrastructure performance reporting. |
| 13 | distribution_pressure_zone | distribution | pressure_zone | Pressure zone performance metrics covering demand, storage, NRW/UFW losses, and hydraulic design compliance. Strategic KPI layer for pressure management, capacity planning, and regulatory performance reporting. |
| 14 | distribution_pump_station | distribution | pump_station | Pump station asset and capacity metrics. Tracks pumping capacity, backup power resilience, SCADA integration, and operational readiness across the distribution network. Strategic KPI layer for energy management, resilience planning, and capital investment decisions. |
| 15 | distribution_service_line | distribution | service_line | Service line asset metrics covering material composition, LCRR compliance, connection status, and replacement programme performance. Strategic KPI layer for lead service line replacement tracking, regulatory compliance (LCRR/LCR), and customer risk management. |
| 16 | distribution_storage_tank | distribution | storage_tank | Storage tank asset and capacity metrics. Tracks total and usable storage capacity, emergency and fire flow reserves, condition, and inspection compliance. Strategic KPI layer for system resilience, regulatory compliance, and capital planning. |
| 17 | metering_accuracy_test | metering | accuracy_test | Meter accuracy testing performance KPIs — pass rates, accuracy deviations, repair outcomes, and replacement recommendations. Used by field operations, regulatory compliance, and asset management to manage meter accuracy programs and meet regulatory testing requirements. |
| 18 | metering_ami_endpoint | metering | ami_endpoint | AMI endpoint fleet health, communication performance, and security KPIs. Used by AMI operations, IT/OT security, and field services to monitor network reliability, battery health, tamper events, and firmware currency across the smart metering infrastructure. |
| 19 | metering_high_usage_alert | metering | high_usage_alert | High-usage alert management KPIs — alert volume, resolution rates, revenue impact, and customer notification effectiveness. Used by customer service, revenue protection, and operations teams to manage leak and high-consumption events and recover revenue. |
| 20 | metering_installation | metering | installation | Meter installation fleet composition, AMI readiness, and infrastructure condition KPIs. Used by field operations, asset management, and capital planning to understand the installed base, remote-read capability, and physical infrastructure condition across all service connections. |

*... and 42 more metric views. See the `metrics/` folder for full details.*