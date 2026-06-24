# Healthcare Lakehouse Data Model

**v2_mvm** generated using Vibe Modelling Agent on June 23, 2026 at 04:09 PM

This document outlines a vibed Lakehouse data model for the Healthcare business that can be deployed to Databricks Platform. The model is structured into business-aligned domains and denormalized data products, optimized for analytical workloads.

## Table of Contents

- [Output Folder Structure](#output-folder-structure)
- [Model Metrics](#model-metrics)
- [Business Summary](#business-summary)
- [Business Domains & Subdomains](#business-domains--subdomains)
  - [Clinical](#domain-clinical)
  - [Consent](#domain-consent)
  - [Encounter](#domain-encounter)
  - [Laboratory](#domain-laboratory)
  - [Order](#domain-order)
  - [Pharmacy](#domain-pharmacy)
  - [Reference](#domain-reference)
  - [Scheduling](#domain-scheduling)
  - [Billing](#domain-billing)
  - [Claim](#domain-claim)
  - [Insurance](#domain-insurance)
  - [Patient](#domain-patient)
  - [Provider](#domain-provider)
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
| `schemas/` | `healthcare_<domain>_schema_v2_mvm.sql` (combined per-domain SQL: schemas/databases + tables with inline PKs + FKs + tags) |
| `schemas/` | `healthcare_catalogs_v2_mvm.sql` (catalog-level DDL) |
| `metrics/` | `healthcare_<domain>_metrics_v2_mvm.sql` (one file per domain) |
| `docs/` | `healthcare_model_v2_mvm.xlsx`, `healthcare_model_v2_mvm.csv`, `releasenotes.txt` |
| `diagram/` | `healthcare_dbml_v2_mvm.dbml` |
| `vibes/` | `current_vibes.txt`, `next_vibes.txt` |
| `/` | `model.json` (full model with requirements, metadata, and model data) |
| `ontology/` | `healthcare_rdf_v2_mvm.rdf` |
| `samples/` | One CSV file per data product (e.g., `customer.csv`, `order.csv`) |

## Model Metrics
| Metric | Value |
|---|---|
| Model Scope | MVM (Minimum Viable Model) |
| Total Domains | 13 |
| Total Subdomains | 33 |
| Total Products | 134 |
| Total Attributes | 5830 |
| Primary Keys | 134 |
| Foreign Keys | 1041 |
| Avg Attributes/Product | 43.5 |
| Metric Views | 105 |

## Business Summary
| Business | Industry Alignment | Model Scope | Description | References | Version |
|---|---|---|---|---|---|
| Healthcare | Healthcare | MVM (Minimum Viable Model) | healthcare industry enterprise data model. |  | 2 |

## Business Domains & Subdomains

<a id="domain-clinical"></a>

### Domain: Clinical

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| clinical | operations | 2 | Comprehensive clinical documentation and care delivery data. Owns diagnoses (ICD-10), procedures (CPT, HCPCS), clinical notes, problem lists, allergies, immunizations, vital signs, care plans, assessments, nursing documentation, clinical observations (LOINC-coded), SNOMED CT-coded clinical findings, and CDI (Clinical Documentation Improvement) workflows. Core EHR/EMR operational data. | 12 |

**Subdomains:** care_management, patient_encounters


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| care_management | allergy | master_data | Patient allergies and adverse reactions | 38 |
| care_management | care_plan | master_data | Patient care plans | 43 |
| care_management | care_plan_goal | transactional_data | Care plan goals and targets | 45 |
| care_management | care_team | master_data | Patient care teams | 42 |
| care_management | care_team_member | master_data | Care team member assignments | 37 |
| care_management | problem | master_data | Patient problem list | 40 |
| patient_encounters | diagnosis | transactional_data | Captures all patient diagnoses recorded during encounters, including ICD-10 codes, present-on-admission indicators, and CDI query status for DRG optimization. | 43 |
| patient_encounters | immunization | transactional_data | Patient immunization records | 40 |
| patient_encounters | note | transactional_data | Stores all clinical notes and documentation, including progress notes, discharge summaries, H&P, operative notes, and consult notes, with support for CDI queries, amendments, and confidentiality levels. | 40 |
| patient_encounters | observation | transactional_data | Clinical observations and assessments | 41 |
| patient_encounters | procedure_event | transactional_data | Records all clinical procedures performed on patients, including surgical procedures, diagnostic procedures, and therapeutic interventions, with CPT/ICD-10-PCS codes for billing and quality reporting. | 51 |
| patient_encounters | vital_sign | transactional_data | Patient vital signs measurements | 38 |

<a id="domain-consent"></a>

### Domain: Consent

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| consent | operations | 2 | Enterprise consent management for patient treatment consent, research consent, data sharing authorizations, HIPAA authorizations, HIE opt-in/opt-out, and telehealth consent. SSOT for all consent records across clinical, research, and administrative contexts. | 8 |

**Subdomains:** consent_documentation, privacy_disclosure


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| consent_documentation | form_template | master_data | Consent form template library storing approved consent form versions with regulatory basis, IRB approval, language translations, and versioning. Supports form lifecycle management and compliance tracking. | 37 |
| consent_documentation | hipaa_authorization | master_data | HIPAA authorization for use and disclosure of PHI beyond treatment/payment/operations. Captures recipient, purpose, PHI categories, expiration, and right to revoke per 45 CFR 164.508. | 36 |
| consent_documentation | record | master_data | Master reference table for consent_record. Referenced by disclosure_consent_record_id. | 36 |
| consent_documentation | restriction_request | master_data | Master record for patient requests to restrict uses and disclosures of their PHI beyond HIPAA's standard permissions. Captures restriction type (restrict disclosure to specific payer when patient paid out-of-pocket per HITECH, restrict sharing with family members, restrict specific data types), requested restriction scope, organization's decision to accept or deny the restriction, effective date, and operational instructions for honoring the restriction across clinical systems. Governed by HITECH Act amendment to HIPAA 45 CFR 164.522. | 44 |
| consent_documentation | treatment_consent | master_data | Master record for general and procedure-specific treatment consent obtained from patients or their authorized representatives prior to clinical care. Captures consent type (general treatment, surgical, anesthesia, blood transfusion, chemotherapy, ECT, restraint), procedure or treatment being consented to, risks and benefits documented, alternatives discussed, patient questions addressed, capacity determination, and legal representative details when patient lacks decision-making capacity. Distinct from HIPAA authorization — governs clinical care delivery. | 37 |
| privacy_disclosure | disclosure_log | transactional_data | Transactional record of every PHI disclosure made under a patient consent or authorization, providing the accounting of disclosures required by HIPAA. Captures disclosure date, recipient identity and type, purpose of disclosure, PHI elements disclosed, consent or authorization reference, and whether the disclosure was for TPO (exempt from accounting) or non-TPO (subject to accounting). Enables generation of the HIPAA Accounting of Disclosures report provided to patients upon request per 45 CFR 164.528. | 38 |
| privacy_disclosure | npp_acknowledgment | transactional_data | Transactional record of patient acknowledgment of receipt of the organization's HIPAA Notice of Privacy Practices (NPP). Captures acknowledgment date, delivery method (paper, electronic, patient portal), NPP version acknowledged, patient or representative signature, and documentation of good-faith efforts when acknowledgment could not be obtained. Distinct from compliance.notice_of_privacy_practices which tracks the NPP document itself — this tracks the patient-level acknowledgment transaction required by 45 CFR 164.520. | 38 |
| privacy_disclosure | revocation | transactional_data | Transactional record of every consent revocation submitted by a patient or their authorized representative. Captures revocation date and time, revocation method (written, verbal, electronic), reason for revocation (if provided), scope of revocation (full or partial), actions taken in response (notifications sent, data access restricted, disclosures halted), and any disclosures that occurred prior to revocation that cannot be undone. Provides the legal audit trail required by HIPAA and state law for consent withdrawal. | 39 |

<a id="domain-encounter"></a>

### Domain: Encounter

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| encounter | operations | 3 | Core operational record of every patient-provider interaction. Owns ADT (Admit, Discharge, Transfer) events, visit types (inpatient, outpatient, ED, observation, telehealth), admission source and disposition, attending and consulting providers, LOS (Length of Stay), DRG assignment, discharge status, and care setting transitions. Central hub linking patient, provider, clinical, and billing domains. | 12 |

**Subdomains:** billing_authorization, clinical_documentation, patient_encounters


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| billing_authorization | authorization | transactional_data | Prior authorization record for services rendered during an encounter. MVM alias: authorization (ECM superset of MVM). | 83 |
| billing_authorization | drg_assignment | transactional_data | Diagnosis-Related Group assignment record for inpatient visit reimbursement classification. | 45 |
| billing_authorization | visit_insurance | transactional_data | Insurance coverage details applicable to a specific visit, including eligibility and authorization. | 38 |
| clinical_documentation | visit_diagnosis | transactional_data | Diagnosis recorded during a visit, including ICD-10 coding, POA indicator, and DRG relevance. | 41 |
| clinical_documentation | visit_procedure | transactional_data | Procedure performed during a visit, including CPT/ICD-10-PCS coding and clinical details. | 53 |
| clinical_documentation | visit_provider | association_data | Provider assignment record linking clinicians to visits with role and participation details. | 45 |
| patient_encounters | adt_event | transactional_data | Admit-Discharge-Transfer event record tracking patient movements within and between facilities. | 47 |
| patient_encounters | bed_assignment | transactional_data | Bed assignment record tracking patient placement in specific beds during a visit. | 43 |
| patient_encounters | discharge_summary | transactional_data | Discharge summary document capturing the hospital course, discharge instructions, and follow-up plan. | 46 |
| patient_encounters | readmission | transactional_data | Readmission tracking record for HRRP compliance and care quality improvement. | 46 |
| patient_encounters | triage_assessment | transactional_data | Emergency department triage assessment including vital signs, ESI level, and chief complaint. | 48 |
| patient_encounters | visit | master_data | Core encounter/visit record representing a patient interaction with the health system. | 43 |

<a id="domain-laboratory"></a>

### Domain: Laboratory

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| laboratory | operations | 3 | Laboratory testing and diagnostic services. Owns lab orders, specimen collection and tracking, test results (LOINC-coded), reference ranges, critical value alerts, pathology reports, microbiology cultures, blood bank operations, point-of-care testing, and CLIA-compliant quality control. Integrates with LIS (Laboratory Information System) including Epic Beaker and Cerner PathNet. | 8 |

**Subdomains:** order_management, result_reporting, test_catalog


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| order_management | lab_order | transactional_data | Laboratory test orders placed by clinicians, including order details, specimen requirements, and fulfillment status. | 50 |
| order_management | specimen | master_data | Biological specimens collected for laboratory testing, including collection details, chain of custody, and storage information. | 40 |
| result_reporting | microbiology_culture | transactional_data | Microbiology culture results including organism identification, colony counts, and antimicrobial susceptibility testing. | 44 |
| result_reporting | pathology_report | master_data | Pathology reports including surgical pathology, cytology, and autopsy findings with synoptic reporting elements. | 48 |
| result_reporting | reference_range | reference_data | Reference ranges for laboratory tests, including normal limits, critical thresholds, and demographic-specific ranges. | 35 |
| result_reporting | test_result | transactional_data | Laboratory test results including numeric and text values, reference ranges, critical value alerts, and result interpretation. | 43 |
| test_catalog | instrument | master_data | Laboratory instruments including calibration, maintenance, and connectivity status. | 34 |
| test_catalog | test_catalog | reference_data | Laboratory test catalog defining orderable tests, specimen requirements, and turnaround times. | 48 |

<a id="domain-order"></a>

### Domain: Order

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| order | operations | 2 | Manages the full lifecycle of clinical orders including CPOE (Computerized Physician Order Entry) for lab, radiology, pharmacy, and referral orders. Tracks order status, priority, routing, and fulfillment. Integrates with Epic Orders, Beaker (LIS), Radiant (RIS), and Willow (pharmacy) as the operational order management backbone. | 8 |

**Subdomains:** clinical_fulfillment, order_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| clinical_fulfillment | fulfillment | transactional_data | Order fulfillment records capturing the completion of clinical orders including charge capture, quantity fulfilled, and turnaround time. | 50 |
| clinical_fulfillment | reconciliation | transactional_data | Medication and order reconciliation events at care transitions, supporting Joint Commission NPSG.03.06.01 and CMS Transitions of Care requirements. | 48 |
| clinical_fulfillment | routing | transactional_data | Order routing records tracking the dispatch and delivery of orders to performing departments, workstations, and queues. | 36 |
| order_management | clinical_order | master_data | Core clinical order record representing any order placed in the CPOE system including lab, radiology, pharmacy, referral, diet, and therapy orders. | 54 |
| order_management | referral_order | transactional_data | Referral orders directing patients to specialists or external facilities, including authorization tracking and referral loop closure. | 54 |
| order_management | set | master_data | Master reference table for set. Referenced by set_id. | 27 |
| order_management | set_item | master_data | Individual order items within an order set, including default values, conditional logic, and clinical rationale for each component. | 53 |
| order_management | standing_order | master_data | Pre-authorized standing orders allowing qualified staff to initiate specific orders based on defined clinical criteria without individual physician sign-off. | 59 |

<a id="domain-pharmacy"></a>

### Domain: Pharmacy

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| pharmacy | operations | 3 | Owns the medication lifecycle from prescribing through dispensing and administration. Manages formulary, NDC (National Drug Code) drug master, MAR (Medication Administration Record), medication reconciliation, controlled substance tracking (DEA Schedule), adverse drug event monitoring, pharmacy inventory, and prescription fulfillment. Sourced from Epic Willow and Cerner PharmNet. | 9 |

**Subdomains:** drug_formulary, medication_dispensing, safety_compliance


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| drug_formulary | drug_master | master_data | Authoritative pharmacy drug master for every medication managed within the organization. Captures NDC (National Drug Code), drug name (generic and brand), drug class, DEA schedule, dosage form, strength, route of administration, unit of measure, therapeutic category, formulary status, controlled substance indicator, hazardous drug flag, tall-man lettering, ISMP high-alert flag, look-alike/sound-alike (LASA) indicators, and regulatory approval metadata. Serves as the pharmacy-owned SSOT for drug attributes consumed by prescribing, dispensing, administration, and inventory workflows. Distinct from reference domain NDC code sets — this product adds pharmacy-operational attributes (formulary status, ISMP flags, hazardous drug classification). Sourced from Epic Willow and Cerner PharmNet drug dictionaries. | 49 |
| drug_formulary | formulary | master_data | Defines the approved drug formulary for each health plan, payer, or facility tier. Captures formulary tier (preferred/non-preferred/specialty), prior authorization requirements, step therapy requirements, quantity limits, formulary effective and expiration dates, therapeutic alternatives, payer-specific coverage rules, and specialty drug classification. Supports formulary management, clinical decision support at point of prescribing, and prescription adjudication. Benefit plan financial details (copay/coinsurance schedules, deductible applicability, mail-order benefit rules) are sourced from the billing domain; this product owns drug-level coverage and access rules only. Sourced from Epic Willow and Cerner PharmNet formulary modules. | 46 |
| drug_formulary | inventory | master_data | Real-time and periodic snapshot of medication inventory levels and movement history across all pharmacy locations including inpatient, outpatient, and automated dispensing cabinets. Captures drug NDC, location, on-hand quantity, reorder point, par level, lot number, expiration date, unit cost, inventory status (active/quarantined/recalled/expired), shortage indicators, and transaction history (receipts, returns, waste, transfers, cycle count adjustments). Supports medication availability, drug shortage management, supply chain integration, waste reduction, and full inventory audit trail. Sourced from Epic Willow and Cerner PharmNet. | 33 |
| drug_formulary | lasa_pair | association_data | This association product represents the formally recognized Look-Alike Sound-Alike (LASA) pairing between two drugs in the pharmacy drug master. It captures the operational patient safety relationship mandated by ISMP and The Joint Commission. Each record links one drug to another LASA partner drug with attributes that exist only in the context of this specific pairing — including pair type, alert level, ISMP designation, and effective date. Replaces the denormalized lasa_drug_pairs STRING column on drug_master.. Existence Justification: LASA (Look-Alike Sound-Alike) drug pairs are a formally recognized patient safety concept mandated by ISMP and The Joint Commission. The relationship is genuinely symmetric and many-to-many: Drug A can be LASA-paired with multiple drugs, and Drug B can be LASA-paired with multiple drugs, and the pairing is bidirectional by definition. Pharmacy safety programs actively manage, create, update, and audit these pairs as operational safety records — not as analytical derivations. | 11 |
| medication_dispensing | dispense_event | transactional_data | Transactional record of each medication dispensing action performed by the pharmacy. Captures prescription reference, dispensed NDC, dispensed quantity, dispensed days supply, lot number, expiration date, dispensing pharmacist NPI, dispensing location, dispense date and time, fill number (original vs. refill), dispense type (inpatient/outpatient/retail/specialty), patient counseling flag, and verification status. Represents the physical fulfillment of a prescription. Sourced from Epic Willow and Cerner PharmNet. | 56 |
| medication_dispensing | mar_record | transactional_data | Medication Administration Record (MAR) capturing each instance of medication administration to an inpatient or outpatient patient. Records administered drug, dose given, route, administration date and time, administering nurse/clinician NPI, administration site, patient response, waste amount (for controlled substances), witness NPI for controlled substance waste, and administration status (given/held/refused/not-available). Core to inpatient medication safety and regulatory compliance. Sourced from Epic ClinDoc MAR and Cerner PharmNet. | 45 |
| medication_dispensing | prescription | transactional_data | Core transactional record representing a medication order written by an authorized prescriber for a patient. Captures MRN, prescriber NPI, drug name, NDC, sig (directions), quantity prescribed, days supply, refills authorized, prescribing date, indication (ICD-10), prescription status (active/discontinued/expired/on-hold), e-prescribing transmission status, DEA number for controlled substances, and EPCS (Electronic Prescribing of Controlled Substances) compliance flag. Sourced from Epic Willow and Cerner PharmNet. | 54 |
| safety_compliance | adverse_drug_event | transactional_data | Operational record of adverse drug events (ADEs), adverse drug reactions (ADRs), and medication errors identified during patient care. Captures event date and time, patient reference, causative drug (NDC), event type (allergic reaction/toxicity/medication error/near-miss), severity level, harm category (NCC MERP index), contributing factors, reporter NPI, encounter reference, root cause analysis findings, and corrective actions taken. Supports pharmacovigilance, FDA MedWatch reporting, ISMP medication error reporting, and pharmacy P&T committee safety reviews. Sourced from Epic Willow and Cerner PharmNet. | 53 |
| safety_compliance | controlled_substance_log | transactional_data | DEA-compliant audit log for all controlled substance transactions including dispensing, administration, waste, returns, inventory counts, and automated dispensing cabinet (ADC) access events. Captures DEA schedule, drug NDC, transaction type, quantity in/out, running balance, transaction timestamp, responsible pharmacist NPI, witness NPI, patient reference, source system (manual/ADC/Pyxis/Omnicell), cabinet/location identifier, override reason, and discrepancy flags. Supports DEA 222 form compliance, state PDMP reporting, diversion detection, and nursing unit controlled substance accountability. Sourced from Epic Willow, Cerner PharmNet, and Pyxis/Omnicell ADC systems. | 44 |

<a id="domain-reference"></a>

### Domain: Reference

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| reference | operations | 2 | SSOT for all enterprise reference data and standardized code sets. Owns ICD-10 diagnosis codes, CPT procedure codes, HCPCS codes, DRG (Diagnosis-Related Group) grouper tables, SNOMED CT clinical terms, LOINC observation codes, NDC drug codes, payer master lists, provider taxonomies, geographic codes, and HL7/FHIR value sets. Provides the authoritative terminology consumed by clinical, billing, pharmacy, and quality domains. | 10 |

**Subdomains:** clinical_coding, provider_registry


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| clinical_coding | cpt_code | reference_data | Authoritative master catalog of CPT (Current Procedural Terminology) codes published by the AMA. Captures CPT code, descriptor (short and full), category (Category I, II, III), work RVU, practice expense RVU, malpractice RVU, total RVU, global period, effective and termination dates. Used by professional billing (CMS-1500), MIPS reporting, and clinical order management. | 34 |
| clinical_coding | drg | reference_data | Master table of Diagnosis-Related Groups (DRGs) and their parent Major Diagnostic Categories (MDCs) used for inpatient prospective payment under CMS MS-DRG, AP-DRG, and APR-DRG grouper systems. DRG records capture DRG code, title, type (medical/surgical/procedure), relative weight, geometric and arithmetic mean LOS, cost threshold, effective fiscal year, and grouper version. MDC records (included as a classification dimension) capture MDC number, title, description, principal diagnosis criteria, and associated DRG range. Central to inpatient reimbursement, CMI (Case Mix Index) calculation, case mix analysis, and service line performance management. | 29 |
| clinical_coding | hcpcs_code | reference_data | Master catalog of HCPCS (Healthcare Common Procedure Coding System) Level II codes maintained by CMS. Covers durable medical equipment, prosthetics, orthotics, supplies, drugs, and non-physician services not captured by CPT. Includes code, description, category, coverage indicator, pricing methodology, effective and termination dates. Used in facility billing (UB-04) and Medicare/Medicaid claims. | 38 |
| clinical_coding | icd_code | reference_data | Authoritative master catalog of ICD-10-CM diagnosis codes and ICD-10-PCS procedure codes as published by WHO and maintained by CMS. Each record captures the full code, short and long descriptions, code category, chapter, validity dates, billable flag, and hierarchical parent code. Consumed by clinical documentation, billing, claims, and quality domains for diagnosis and procedure coding. | 28 |
| clinical_coding | loinc_code | reference_data | Authoritative catalog of LOINC (Logical Observation Identifiers Names and Codes) codes maintained by the Regenstrief Institute. Captures LOINC number, component, property, time aspect, system, scale type, method type, long common name, short name, class, order/observation flag, status, and effective dates. Used to standardize lab results, vital signs, clinical observations, and radiology reports across LIS, RIS, and EHR systems. | 30 |
| clinical_coding | snomed_concept | reference_data | Master catalog of SNOMED CT (Systematized Nomenclature of Medicine Clinical Terms) clinical concepts as distributed by SNOMED International and the NLM. Each record captures concept ID, fully specified name, preferred term, semantic tag, concept status (active/inactive), module, effective time, and hierarchy path. Provides the clinical terminology backbone for problem lists, allergies, clinical findings, and FHIR-based interoperability. | 34 |
| provider_registry | code_set_version | master_data | Lifecycle and version tracking for all enterprise reference code sets (ICD-10, CPT, HCPCS, SNOMED CT, LOINC, NDC, RxNorm, DRG grouper, etc.). Each record captures code set name, version identifier, effective date, termination date, source authority, download URL, file hash, record count, load status, load timestamp, and superseded-by reference. Enables audit of which code set version was active at any point in time, supporting retrospective claims adjudication, regulatory compliance, and reproducible terminology expansion for FHIR value sets. | 31 |
| provider_registry | crosswalk | reference_data | Enterprise terminology crosswalk and mapping table maintaining authoritative code-to-code translations between clinical and billing code systems. Each mapping record captures source code system, source code, target code system, target code, mapping type (equivalent, broader, narrower, related), mapping quality (exact, inexact), directionality, source and target code_set_version references, effective and termination dates, and source authority. Covers ICD-9→ICD-10 GEMs, SNOMED CT→ICD-10 maps, NDC→RxNorm, CPT→SNOMED procedure maps, LOINC→SNOMED observation maps, and SDOH code mappings (ICD-10-Z↔SNOMED↔LOINC SDOH panels). Essential for claims migration, clinical-to-billing translation, SDOH reporting, and cross-system interoperability. | 29 |
| provider_registry | ndc_drug | reference_data | Master catalog of NDC (National Drug Code) drug products as maintained by the FDA, enriched with RxNorm normalized drug concept mappings (RxCUI, term type, ingredient/brand/clinical drug hierarchy) published by the NLM. NDC records capture the 11-digit NDC, labeler name, product name, proprietary and non-proprietary names, dosage form, route of administration, strength, unit, DEA schedule, marketing category, application number, package description, and active/inactive status. RxNorm normalization records capture RxCUI, name, term type (TTY: ingredient, brand name, clinical drug, etc.), source vocabulary, suppress flag, and effective dates, providing the canonical drug terminology layer that maps NDC codes, proprietary names, and generic names to a single clinical drug concept. Consumed by pharmacy, formulary management, MAR, medication reconciliation, FHIR MedicationRequest interoperability, and billing domains. | 44 |
| provider_registry | npi_registry | master_data | Enterprise copy of the CMS National Plan and Provider Enumeration System (NPPES) NPI registry, enriched with NUCC Health Care Provider Taxonomy code classifications. NPI records capture NPI number, entity type (individual Type 1/organization Type 2), provider name, credential, gender, enumeration date, last update date, deactivation date, reactivation date, mailing and practice addresses, phone, fax, and authorized official information. Taxonomy classification records capture taxonomy code, provider type, classification, specialization, definition, and effective dates for each NPI's primary and secondary taxonomy assignments. Serves as the authoritative NPI and provider taxonomy lookup for claims submission, credentialing, payer enrollment, and provider directory across all domains. Note: this is the enterprise reference copy; provider domain owns the operational provider record. | 44 |

<a id="domain-scheduling"></a>

### Domain: Scheduling

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| scheduling | operations | 2 | Appointment and resource scheduling across all care settings. Includes outpatient appointments (Epic Cadence), surgical scheduling (OpTime), procedure scheduling, resource allocation (rooms, equipment, staff), waitlist management, appointment reminders, no-show tracking, and capacity planning. Supports patient access and operational throughput optimization. | 10 |

**Subdomains:** appointment_management, resource_planning


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| appointment_management | appointment_reminder | transactional_data | Records of all patient appointment reminders sent via automated channels (phone, SMS, email, patient portal). Captures reminder type, channel, scheduled send datetime, actual send datetime, delivery status, patient response (confirmed, cancelled, no response), reminder template used, and number of attempts. Supports patient engagement workflows and no-show reduction programs. Sourced from Epic Cadence automated messaging. | 40 |
| appointment_management | appointment_type | reference_data | Reference catalog of all appointment types defined across care settings (e.g., new patient visit, follow-up, annual wellness, pre-op, post-op, telehealth, urgent care). Includes CPT/visit type code mapping, default duration, care setting applicability, specialty association, and scheduling rules. Drives appointment booking logic and capacity planning in Epic Cadence and Cerner Millennium. | 40 |
| appointment_management | open_slot | transactional_data | Individual available scheduling slots generated from schedule templates for providers, rooms, and equipment. Captures slot date/time, duration, slot type, care setting, resource assignment, appointment type eligibility, hold status, and remaining capacity. Represents the real-time inventory of bookable time — aligns with HL7 FHIR Slot resource. Consumed by appointment booking workflows, patient self-scheduling (Epic MyChart), and patient access teams in Epic Cadence and Cerner scheduling. | 35 |
| appointment_management | surgical_case | transactional_data | Master record for every scheduled surgical or procedural case managed through OpTime or Cerner SurgiNet. Captures case type, procedure codes (CPT/ICD-10-PCS), scheduled OR suite, primary surgeon, anesthesia type, estimated duration, case status (requested, scheduled, in-progress, completed, cancelled), ASA classification, and block time utilization. SSOT for surgical scheduling distinct from outpatient appointments. | 55 |
| appointment_management | telehealth_session | transactional_data | Records of telehealth and virtual care appointments including video visits, e-visits, and telephone encounters. Captures session type (video, phone, asynchronous), platform used, session URL/access code, scheduled and actual start/end times, technical connection status, patient device type, provider attestation of completion, and billing eligibility flag. Distinct from in-person appointments due to unique workflow, platform, and reimbursement requirements. | 55 |
| appointment_management | waitlist_entry | transactional_data | Tracks all scheduling work items awaiting action — including patients on scheduling waitlists, unscheduled referrals, pending orders, recall-driven requests, surgical scheduling requests, and scheduling department work queues. Captures entry type (waitlist, referral queue, order-based, recall, surgical request), priority level, requested appointment type, patient scheduling preferences (preferred provider, preferred care site/location, preferred days/times, preferred contact channel, language preference, transportation needs, telehealth eligibility), queue entry datetime, assigned scheduling team, SLA target datetime, estimated wait time, status (active, offered, accepted, expired, removed, pending, in-progress, scheduled, escalated, closed), escalation/aging flags, and outreach attempt history. SSOT for all scheduling queue, waitlist, and patient preference management. Supports patient access optimization, scheduling department workflow, demand management, access SLA compliance, and patient-centered scheduling. | 55 |
| resource_planning | provider_availability | transactional_data | Real-time and planned provider availability records capturing when providers are available, unavailable, or on leave for scheduling purposes. Captures provider NPI, availability type (scheduled, on-call, blocked, vacation, CME, administrative), start/end datetime, care setting, and reason for unavailability. Distinct from schedule templates — this captures actual availability exceptions and overrides that modify the template-generated slots. | 42 |
| resource_planning | resource_assignment | association_data | Association record linking schedulable resources (providers, rooms, equipment, care team members) to specific appointments, surgical cases, or procedures. Captures assignment role (primary surgeon, co-surgeon, anesthesiologist, CRNA, scrub tech, circulating nurse, perfusionist, room, equipment operator), assignment status (requested, confirmed, in-use, released, declined), start/end time, confirmation flag, credentialing verification status, equipment asset ID, equipment reservation status, maintenance/sterilization clearance, conflict flags, and actual vs. scheduled participation. SSOT for all resource-to-event associations in the scheduling domain — including surgical case team assignments and equipment reservations. Supports multi-resource scheduling, OR team staffing, equipment management, credentialing compliance, and case documentation. | 45 |
| resource_planning | schedulable_resource | master_data | Master catalog of all resources that can be scheduled across care settings: providers (physicians, APPs, therapists), rooms (exam, OR suite, procedure, imaging, infusion bay), equipment (MRI, CT, C-arm, surgical robot, laser, perfusion pump), and care teams. Captures resource type, name, NPI (for providers), location/facility, building/floor/unit (for rooms), room capacity and configuration, specialty, equipment asset ID, maintenance windows, sterilization cycle requirements, minimum turnover time, active/inactive status, and scheduling constraints. SSOT for resource identity within the scheduling domain. Links to workforce domain (provider master), facility domain (location/room master), and supply domain (equipment asset master) via cross-domain FKs. | 38 |
| resource_planning | schedule_template | master_data | Provider and resource schedule templates defining recurring availability patterns (daily, weekly, rotating) plus real-time availability exceptions, overrides, and leave records. For templates: captures template name, effective date range, applicable provider or resource, time block definitions, appointment type slots, session duration, and recurrence rules. For availability exceptions: captures provider NPI, exception type (vacation, CME, administrative, on-call, blocked, emergency override), start/end datetime, care setting, reason for unavailability, and approval status. SSOT for all provider/resource availability — both the recurring blueprint and its real-time modifications. Aligns with HL7 FHIR Schedule resource. Used by Epic Cadence and OpTime to generate open scheduling slots. | 42 |

<a id="domain-billing"></a>

### Domain: Billing

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| billing | business | 3 | SSOT for all revenue cycle management (RCM) activities. Owns charge capture, CDM (Charge Description Master), professional and facility billing (CMS-1500, UB-04), coding (ICD-10, CPT, DRG), claim generation, payment posting, patient statements, collections, bad debt, contractual adjustments, ERA/EOB processing, and denial management. Integrates with Epic Resolute PB/HB, 3M HIS, and Cerner Revenue Cycle. | 10 |

**Subdomains:** charge_capture, patient_invoicing, payment_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| charge_capture | cdm_entry | master_data | Charge Description Master (CDM) entry defining billable services, supplies, and procedures with pricing, revenue codes, and GL mapping. Central to charge capture and pricing transparency. | 39 |
| charge_capture | charge | transactional_data | Individual billable service or supply charge captured during patient care delivery. Links clinical activity to revenue cycle and supports charge capture, coding, and claim submission workflows. | 56 |
| charge_capture | coding_assignment | transactional_data | Assignment of diagnosis and procedure codes to a patient visit or claim by certified coders. Supports DRG assignment, CDI queries, and coding compliance workflows. | 43 |
| patient_invoicing | invoice | transactional_data | Patient invoice or bill summarizing charges, payments, adjustments, and outstanding balance for a visit or account period. Supports patient billing, collections, and revenue cycle reporting. | 52 |
| patient_invoicing | invoice_line | transactional_data | Individual line item on a patient invoice detailing a specific charge, procedure, or service with associated codes, amounts, and adjudication details. | 55 |
| patient_invoicing | statement | transactional_data | Patient billing statement summarizing charges, payments, adjustments, and balance due for a billing cycle. Supports patient communication and collections. | 46 |
| payment_management | adjustment | transactional_data | Financial adjustment to a charge, invoice, or account balance. Includes contractual adjustments, write-offs, refunds, and corrections. | 46 |
| payment_management | patient_account | master_data | Patient financial account aggregating charges, payments, adjustments, and balances across visits. Supports patient billing, collections, and financial assistance workflows. | 44 |
| payment_management | payment | transactional_data | Patient or payer payment received and applied to invoices or accounts. Supports payment posting, reconciliation, and cash management workflows. | 44 |
| payment_management | payment_plan | master_data | Patient payment plan agreement for installment payments on outstanding balances. Tracks payment schedule, compliance, and default status. | 44 |

<a id="domain-claim"></a>

### Domain: Claim

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| claim | business | 4 | Insurance claims processing and payer adjudication. Owns claim submission, claim status tracking, payer adjudication, remittance advice (ERA - Electronic Remittance Advice), EOB (Explanation of Benefits), denial management, appeals, prior authorization, eligibility verification, payer contract management, RAC audit responses, and coordination of benefits across HMO, PPO, POS, Medicare, and Medicaid payers. | 12 |

**Subdomains:** claim_processing, coverage_verification, denial_recovery, payment_adjudication


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| claim_processing | claim | master_data | Core claim record representing a request for payment from a payer for healthcare services rendered. Links patient, provider, payer, and clinical context. Supports revenue cycle, denial management, and compliance workflows. | 52 |
| claim_processing | diagnosis_link | transactional_data | Links diagnosis codes to claims for medical necessity justification, DRG grouping, and quality measure attribution. Tracks POA indicators, HAC flags, and CDI query status. Critical for compliance and reimbursement optimization. | 29 |
| claim_processing | line | transactional_data | Individual service line within a claim. Each line represents a distinct procedure, supply, or service with its own charge, diagnosis pointers, and adjudication. Supports line-level denial analysis and revenue integrity. | 47 |
| claim_processing | status_history | transactional_data | Claim lifecycle status-history SSOT. Tracks payer adjudication status transitions (submitted, accepted, denied, paid, appealed) for a claim. Distinct from order.order_status_history which tracks clinical order fulfillment lifecycle; differentiated per SSOT review. | 34 |
| claim_processing | submission | transactional_data | Tracks each claim submission attempt to a payer, including EDI transmission details, acknowledgment status, and rejection reasons. Supports resubmission workflows, timely filing tracking, and clearinghouse reconciliation. | 41 |
| coverage_verification | cob | transactional_data | Coordination of Benefits logic determining primary/secondary/tertiary payer order, tracking payments and adjustments across multiple payers. Supports birthday rule, gender rule, and Medicare Secondary Payer (MSP) determination. | 34 |
| coverage_verification | eligibility | transactional_data | Real-time eligibility verification responses (270/271) capturing coverage status, benefit details, deductible/OOP amounts, and network status. Supports pre-service financial counseling and authorization workflows. | 45 |
| coverage_verification | prior_authorization | master_data | Tracks prior authorization requests and approvals for services, procedures, and supplies. Links to payer rules, clinical orders, and utilization review. Supports authorization tracking, unit consumption, and appeal workflows. | 42 |
| denial_recovery | appeal | transactional_data | Manages multi-level appeal process for denied claims, tracking deadlines, clinical rationale, peer review requirements, and outcomes. Links to corrective action plans and recovery journal entries. Supports appeal success rate analysis. | 39 |
| denial_recovery | denial | master_data | Tracks denied claims and lines with root cause analysis, preventability flags, and recovery tracking. Links to appeals, corrective action plans, and quality peer review. Supports denial prevention and revenue recovery workflows. | 49 |
| payment_adjudication | remittance | transactional_data | Electronic Remittance Advice (835) from payer detailing payment, adjustments, and denials across multiple claims. Links to cash posting, AR transactions, and GL journal entries. Supports auto-posting and variance analysis. | 40 |
| payment_adjudication | remittance_line | transactional_data | Line-level detail from 835 ERA showing allowed amount, paid amount, adjustments (contractual, deductible, copay), and CARC/RARC codes. Links to claim lines and GL accounts for automated posting and variance reconciliation. | 49 |

<a id="domain-insurance"></a>

### Domain: Insurance

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| insurance | business | 3 | Master data management for insurance payers, health plans, benefit structures, provider networks, and coverage policies. SSOT for payer identity, plan configurations, network definitions, and benefit rules that are referenced by billing, claim, patient, and encounter domains. | 12 |

**Subdomains:** contract_reimbursement, member_coverage, payer_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| contract_reimbursement | fee_schedule | master_data | Master record for payer-specific reimbursement fee schedules defining the contracted payment rates for procedures, services, and supplies. Captures fee schedule name, payer ID, contract ID, fee schedule type (professional, facility, DME, lab, pharmacy), effective date, termination date, geographic adjustment factor (GPCI), and the basis for rates (% of Medicare, % of billed charges, case rate, per diem). Parent entity for fee schedule line items. Supports contract modeling, underpayment detection, and revenue cycle optimization. | 49 |
| contract_reimbursement | fee_schedule_line | master_data | Individual line-item rate record within a fee schedule, defining the contracted reimbursement rate for a specific procedure code, service, or supply item. Captures fee schedule ID, procedure code (CPT/HCPCS), modifier applicability, revenue code (for facility), place of service, contracted rate amount, rate basis (flat rate, RVU-based, % of Medicare allowable), RVU value, conversion factor, effective date, and termination date. Enables line-level contract modeling, expected reimbursement calculation, and underpayment variance analysis. | 49 |
| contract_reimbursement | payer_contract | master_data | Master record for negotiated contracts between the healthcare organization (provider) and insurance payers, defining reimbursement terms, fee schedules, value-based care arrangements, and contractual obligations. Captures contract number, payer ID, contract type (fee-for-service, capitation, bundled payment, shared savings, P4P — Pay for Performance), contract effective date, termination date, auto-renewal terms, base fee schedule reference, carve-out provisions, quality bonus/penalty terms, risk arrangement type, and contract status. SSOT for provider-payer contractual relationships governing reimbursement. | 47 |
| member_coverage | dependent | master_data | Master record for individuals covered under a subscriber's health plan as dependents, including spouses, domestic partners, and children. Captures dependent ID, subscriber ID, dependent name, date of birth, gender, relationship type (spouse, child, domestic partner, disabled dependent), dependent eligibility status, coverage effective date, termination date, termination reason (aging off at 26, divorce, loss of eligibility), and student status for age-extension eligibility. Enables accurate member-level eligibility verification and COB determination for dependents. | 39 |
| member_coverage | member_enrollment | transactional_data | Transactional record of a member's enrollment into a specific health plan, capturing the full enrollment lifecycle from initial enrollment through termination. Captures member ID (subscriber ID), payer ID, health plan ID, group number, subscriber vs dependent relationship, enrollment type (open enrollment, special enrollment period, auto-enrollment, COBRA), enrollment effective date, termination date, termination reason, premium amount, premium payment status, benefit period, and enrollment source (employer group, exchange, Medicaid agency, Medicare CMS). SSOT for member plan enrollment referenced by eligibility verification and claim adjudication. | 42 |
| member_coverage | subscriber | master_data | Master record for the primary insured individual (subscriber/policyholder) who holds the insurance contract with the payer. Distinct from the patient master (patient.mpi_record) — the subscriber is the contractual party responsible for premium payment and may or may not be a patient. Captures subscriber ID (member ID), payer-assigned subscriber number, subscriber name, date of birth, gender, SSN (masked), employer group, group number, relationship to dependents, premium responsibility, COBRA eligibility status, and Medicare/Medicaid dual eligibility flags. SSOT for the insurance contractual relationship owner. | 44 |
| payer_management | benefit | master_data | Master record defining individual benefit components within a health plan, representing the specific coverage rules for a category of healthcare services. Captures benefit category (inpatient hospital, outpatient surgery, primary care, specialist, emergency, mental health, substance use, preventive, DME, home health, hospice, vision, dental, pharmacy), benefit tier, in-network vs out-of-network rules, prior authorization requirement flag, referral requirement flag, copay amount, coinsurance percentage, deductible applicability, benefit limit (visit limits, dollar limits, day limits), and benefit effective dates. Enables granular benefit adjudication and member cost-sharing calculation. | 50 |
| payer_management | coverage_policy | master_data | Master record for payer coverage policies and medical policies governing whether specific services, procedures, diagnoses, or technologies are covered under a health plan. Captures policy number, policy title, policy type (medical policy, coverage determination, LCD — Local Coverage Determination, NCD — National Coverage Determination), covered/non-covered determination, applicable CPT/HCPCS codes, applicable ICD-10 diagnosis codes, prior authorization requirements, clinical criteria (medical necessity criteria, step therapy requirements), effective date, and review/expiration date. SSOT for coverage rules referenced during prior authorization and claim adjudication. | 47 |
| payer_management | health_plan | master_data | Specific health insurance plan products offered by payers, including benefit design and coverage rules. | 49 |
| payer_management | payer | master_data | Insurance payer organization master table storing health plan companies, government programs, and third-party administrators. | 41 |
| payer_management | prior_auth_rule | master_data | Master record defining payer-specific prior authorization (PA) requirements for procedures, services, medications, and care settings. Captures payer ID, health plan ID, procedure code (CPT/HCPCS), diagnosis code applicability, service category, place of service, PA requirement type (required, not required, clinical review, peer-to-peer), clinical criteria reference, turnaround time standard (urgent vs standard), submission method (portal, fax, phone, EDI 278), effective date, and termination date. SSOT for PA requirement rules used by utilization management and order authorization workflows. | 51 |
| payer_management | provider_network | master_data | Master record for every provider network defined and managed by a payer, representing the contracted network of providers available to plan members. Captures network name, network ID, network type (HMO, PPO, EPO, narrow network, tiered network, ACO network), geographic service area, network tier (preferred, standard, out-of-network), network effective and termination dates, network adequacy status, CMS network adequacy filing status, and the payer that owns the network. SSOT for network identity referenced by plan-network associations, provider participation records, and claim adjudication. | 44 |

<a id="domain-patient"></a>

### Domain: Patient

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| patient | business | 3 | Master data for all individuals receiving healthcare services. SSOT for patient identity, demographics, MRN (Medical Record Number), MPI (Master Patient Index), insurance coverage, emergency contacts, consent records, SDOH (Social Determinants of Health), patient preferences, and PHI-protected identity information. Referenced by every clinical and financial domain via patient_id FK. | 12 |

**Subdomains:** care_engagement, financial_coverage, identity_management


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| care_engagement | consent_reference | master_data | Lightweight reference record linking a patient to their consent records in the consent domain SSOT. Captures patient_id and consent_master_id FK for cross-domain joins. | 40 |
| care_engagement | emergency_contact | master_data | Patient emergency contact records capturing contact name, relationship type, priority order, phone numbers (home, mobile, work), address, and authorization level (e.g., authorized to receive PHI, healthcare proxy, legal guardian). Supports EMTALA compliance, care coordination, and discharge planning workflows. Sourced from Epic and Cerner registration modules. | 43 |
| care_engagement | pcp_attribution | master_data | Patient attribution to Primary Care Physician (PCP) or care team records capturing attributed provider NPI, attribution method (claims-based, enrollment-based, manual), attribution panel, attribution effective and end dates, ACO/HMO/PPO plan attribution, and attribution confidence score. SSOT for care team assignment used in population health, HEDIS, MIPS, and value-based care reporting. Sourced from population health management and payer attribution feeds. | 47 |
| care_engagement | portal_account | master_data | Patient portal and digital engagement account record capturing portal platform, account creation date, activation status, last login date, two-factor authentication enrollment, proxy access grants (parent/guardian, adult caregiver, legal guardian, healthcare POA) with proxy identity, access levels (full, limited, view-only), authorization and expiration dates, revocation dates, supporting legal documentation references, messaging opt-in status, appointment self-scheduling enablement, and digital health app linkages. SSOT for patient digital engagement and proxy access management. Supports patient engagement, HIPAA-compliant proxy access, MIPS Promoting Interoperability measures, and digital front door strategy. Aligned with HL7 FHIR RelatedPerson resource for proxy relationships. Sourced from patient portal and proxy management systems. | 47 |
| financial_coverage | eligibility_check | transactional_data | Real-time and batch insurance eligibility verification transaction records capturing verification date and time, payer queried, verification method (270/271 EDI, portal, phone), eligibility status returned, coverage details confirmed, copay/deductible amounts verified, prior authorization requirements, and verification source system. Supports front-end RCM workflows and reduces claim denials. Sourced from Epic Resolute and Cerner Revenue Cycle eligibility modules. | 40 |
| financial_coverage | guarantor | master_data | Financial guarantor record identifying the individual or entity responsible for patient account balances. Captures guarantor name, relationship to patient, address, phone, employer information, SSN (masked), and account responsibility percentage. Supports RCM billing workflows, patient financial counseling, and self-pay collection processes. Sourced from EHR revenue cycle and patient accounting modules. | 49 |
| financial_coverage | insurance_coverage | master_data | Patient insurance coverage, eligibility, and verification records. Captures payer name, plan name, plan type (HMO, PPO, POS, Medicare, Medicaid, self-pay), member ID, group number, subscriber relationship, coverage effective and termination dates, coordination of benefits (COB) priority, copay/deductible/out-of-pocket amounts, pre-authorization requirements, and real-time/batch eligibility verification transactions (270/271 EDI, portal, phone) with verification status, confirmed coverage details, verification date/time, payer queried, and verification audit trail. SSOT for patient payer eligibility and verification consumed by billing and claims domains. Supports front-end RCM workflows, claim denial prevention, and prior authorization management. Aligned with X12 270/271 transaction standards and HL7 FHIR Coverage resource. Sourced from EHR revenue cycle and eligibility verification modules. | 43 |
| identity_management | address | master_data | Patient address records supporting multiple address types (home, mailing, temporary, work) with full address components, geocoding coordinates, county/census tract for SDOH analysis, address validation status, effective date ranges, and do-not-mail flags. Supports population health outreach, care gap closure, and SDOH stratification. Sourced from Epic and Cerner registration systems. | 46 |
| identity_management | demographics | master_data | Patient demographic information including contact details, addresses, and personal characteristics. | 51 |
| identity_management | mpi_record | master_data | Master Patient Index record serving as the enterprise single-source-of-truth for patient identity across multi-facility health systems, supporting identity resolution, merge/unmerge workflows, and cross-system MRN mapping. | 45 |
| identity_management | mrn_crosswalk | reference_data | ECM-tier extension of the MPI providing multi-system Medical Record Number (MRN) crosswalk for identity resolution across facilities, EHR systems, HIEs, and payer networks. Maps every known patient identifier back to the enterprise MPI golden record. Essential for multi-facility health systems performing data integration, analytics, and interoperability. | 48 |
| identity_management | registration_event | transactional_data | Patient registration lifecycle event records capturing event type (new registration, pre-registration, update, merge, unmerge), registration date and time, registering facility, registration source (ED walk-in, scheduled, transfer, online pre-registration), registration completeness score, identity verification method (photo ID, insurance card, biometric), and registration staff. Provides the audit trail for patient identity creation and maintenance events within the MPI lifecycle. Distinct from encounter-level ADT events — this product tracks identity/registration events, not clinical visit movements. Sourced from EHR ADT and registration modules. | 43 |

<a id="domain-provider"></a>

### Domain: Provider

| Domain | Division | Total Subdomains | Description | Total Products |
|---|---|---|---|---|
| provider | business | 3 | Authoritative repository for all healthcare professionals and organizational providers. Includes physicians, nurses, allied health professionals, NPI (National Provider Identifier), DEA numbers, credentials, specialties, licensure, hospital privileges, credentialing status, payer enrollment, and provider network affiliations. SSOT for provider identity and authorization. | 11 |

**Subdomains:** clinical_credentialing, network_participation, provider_identity


**List of Data Products**

| Subdomain | Product | Data Type | Description | Total Attributes |
|---|---|---|---|---|
| clinical_credentialing | board_certification | master_data | Tracks specialty board certifications earned by clinicians from recognized certifying bodies (ABMS, AOA). Captures certifying board name, specialty certified, certification number, initial certification date, expiration date, maintenance of certification (MOC) status, and recertification history. Used in credentialing, provider directory, and quality reporting. | 41 |
| clinical_credentialing | credential | master_data | Provider credentials (licenses, certifications, DEA, board certifications, CME) with expiration tracking and primary source verification. | 46 |
| clinical_credentialing | dea_registration | master_data | Master record of DEA (Drug Enforcement Administration) controlled substance registrations for clinicians authorized to prescribe Schedule II-V medications. Captures DEA number, registration date, expiration date, DEA schedule authorizations, state of registration, registration status, and business activity type. Required for pharmacy order validation and controlled substance compliance. | 44 |
| clinical_credentialing | privileging | master_data | Clinical privilege granted to a clinician at a specific care site, tracking privilege type, status, approval, FPPE/OPPE requirements, and case volume for medical staff office compliance. | 42 |
| network_participation | group_membership | transactional_data | Association record capturing the complete current and historical membership, affiliations, and employment relationships of individual clinicians within provider groups, hospitals, health systems, academic medical centers, and other organizational entities. Includes organization name, organization type (group practice, hospital, health system, academic medical center, FQHC), role within the organization (owner, partner, employee, contractor, attending, consulting), effective and end dates, FTE allocation, primary practice location, departure reason, and voluntary/involuntary separation indicator. Provides complete affiliation history for credentialing primary source verification (work history verification is mandatory per NCQA and Joint Commission), NPDB adverse action reporting context, billing attribution, and workforce planning. Serves as the consolidated SSOT for all clinician-to-organization affiliation and employment history records — no other product in this domain stores affiliation history or organizational membership data. | 41 |
| network_participation | network_affiliation | transactional_data | Association record linking clinicians and organizational providers to payer networks, ACOs, HMOs, PPOs, and integrated care networks. Captures network name, network tier, participation type, effective and termination dates, panel status (open/closed), and geographic service area. Supports provider directory accuracy and network adequacy reporting required by CMS. | 43 |
| provider_identity | clinician | master_data | Individual healthcare provider (physician, NP, PA, etc.) with credentialing, licensure, and employment details. | 51 |
| provider_identity | group | master_data | Master record for medical group practices, physician organizations, and care delivery groups that aggregate individual clinicians under a shared organizational identity. Captures group NPI, group name, group type (single-specialty, multi-specialty, FQHC), tax ID, billing entity, primary service location, and group size. Supports group-level contracting, billing, and network management. | 46 |
| provider_identity | org_provider | master_data | Organizational provider (hospital, clinic, group practice, etc.) with credentialing, accreditation, and network participation details. | 48 |
| provider_identity | specialty | reference_data | Clinical specialty master table with taxonomy codes, board certification requirements, and payer enrollment rules. | 42 |
| provider_identity | taxonomy | reference_data | Reference catalog of NUCC (National Uniform Claim Committee) Health Care Provider Taxonomy codes used to classify provider type, classification, and specialization on claims and enrollment forms. Captures taxonomy code, provider type, classification, specialization, effective date, and CMS crosswalk to specialty codes. Used in NPI registry, claims submission, and payer enrollment. | 39 |

## Metric Views

Total metric views generated: **105**. Showing top 20.

| # | View Name | Domain | Source Table | Description |
|---|---|---|---|---|
| 1 | clinical_allergy | clinical | allergy | Allergy documentation KPIs covering drug allergy prevalence, severity distribution, and documentation quality — critical for patient safety, medication safety programs, and regulatory compliance. |
| 2 | clinical_care_plan | clinical | care_plan | Care plan KPIs measuring population health program enrollment, care gap closure, readmission risk stratification, and patient consent — core metrics for value-based care and population health management. |
| 3 | clinical_care_plan_goal | clinical | care_plan_goal | Care plan goal KPIs measuring goal achievement rates, patient agreement, and SDOH-related goal tracking — essential for value-based care program effectiveness and population health outcome reporting. |
| 4 | clinical_diagnosis | clinical | diagnosis | Clinical diagnosis KPIs tracking chronic disease burden, coding quality, complication rates, and CDI performance — core metrics for quality, risk adjustment, and revenue integrity programs. |
| 5 | clinical_immunization | clinical | immunization | Immunization KPIs covering vaccination rates, series completion, adverse reaction rates, and registry reporting compliance — essential for public health, quality measure performance, and regulatory reporting. |
| 6 | clinical_note | clinical | note | Clinical note KPIs measuring documentation volume, CDI query rates, late entry rates, and DRG impact — essential for revenue integrity, coding quality, and clinical documentation program performance. |
| 7 | clinical_observation | clinical | observation | Clinical observation KPIs covering assessment scores, critical value rates, and SDOH screening — drives quality program performance, patient safety, and population health equity reporting. |
| 8 | clinical_problem | clinical | problem | Problem list KPIs measuring chronic disease burden, HCC capture rates, and problem list quality — critical for risk adjustment, value-based care performance, and population health management. |
| 9 | clinical_procedure_event | clinical | procedure_event | Procedure-level KPIs covering surgical volume, revenue, efficiency, and quality — essential for OR management, service line performance, and value-based care reporting. |
| 10 | clinical_vital_sign | clinical | vital_sign | Vital sign monitoring KPIs covering abnormality rates, patient-reported data quality, and early warning score contributions — essential for clinical quality, deterioration detection, and nursing performance. |
| 11 | consent_disclosure_log | consent | disclosure_log | Operational and compliance KPI layer over the PHI disclosure log. Tracks disclosure volume, TPO vs. non-TPO patterns, minimum-necessary compliance, and accounting-of-disclosures obligations — essential for HIPAA Privacy Rule reporting and executive risk oversight. |
| 12 | consent_form_template | consent | form_template | Governance KPI layer over consent form templates. Tracks template portfolio health, electronic signature enablement, IRB approval coverage, active vs. superseded template ratios, and multi-language availability — essential for consent governance, regulatory compliance, and form lifecycle management. |
| 13 | consent_hipaa_authorization | consent | hipaa_authorization | Compliance KPI layer over HIPAA authorizations for non-TPO PHI disclosures. Tracks authorization completeness, signature capture rates, personal representative usage, and compensation disclosure compliance — essential for HIPAA Privacy Rule audit readiness. |
| 14 | consent_npp_acknowledgment | consent | npp_acknowledgment | Patient rights KPI layer over Notice of Privacy Practices acknowledgments. Tracks acknowledgment rates, good-faith effort documentation, first-service compliance, and material change acknowledgment coverage — core HIPAA Notice Rule compliance metrics. |
| 15 | consent_record | consent | record | Strategic KPI layer over the consent record fact table. Tracks consent lifecycle health, revocation rates, expiration exposure, and sensitive-data consent coverage — core metrics for compliance officers, privacy teams, and executive risk dashboards. |
| 16 | consent_restriction_request | consent | restriction_request | Patient rights KPI layer over PHI restriction requests. Tracks request volume, organizational decision rates, out-of-pocket payment verification, system enforcement, and restriction lifecycle compliance — essential for HIPAA patient rights and operational risk management. |
| 17 | consent_revocation | consent | revocation | Compliance and risk KPI layer over consent revocations. Tracks revocation volume, legal review completion, data access restriction enforcement, disclosure halting compliance, and patient notification fulfillment — critical for HIPAA Privacy Rule and consent lifecycle governance. |
| 18 | consent_treatment_consent | consent | treatment_consent | Clinical quality and compliance KPI layer over treatment consent records. Tracks informed consent completeness, interpreter utilization, emergency exception rates, legal representative involvement, and documentation quality — essential for clinical risk management and Joint Commission compliance. |
| 19 | encounter_authorization | encounter | authorization | Prior authorization metrics covering approval rates, denial patterns, turnaround time, peer-to-peer review outcomes, and financial authorization amounts. Critical for revenue cycle, utilization management, and payer relations. |
| 20 | encounter_discharge_summary | encounter | discharge_summary | Discharge summary completion and quality metrics covering documentation timeliness, care transition compliance, medication reconciliation, and follow-up scheduling. Drives regulatory compliance, readmission prevention, and quality program performance. |

*... and 85 more metric views. See the `metrics/` folder for full details.*