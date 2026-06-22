# Construction Lakehouse Data Models

**Version 2** | Generated on June 22, 2026 at 05:24 PM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Bid](#domain-bid)
  - [Client](#domain-client)
  - [Compliance](#domain-compliance)
  - [Contract](#domain-contract)
  - [Design](#domain-design)
  - [Employee](#domain-employee)
  - [Equipment](#domain-equipment)
  - [Finance](#domain-finance)
  - [Hr](#domain-hr)
  - [Material](#domain-material)
  - [Org_unit](#domain-org_unit)
  - [Procurement](#domain-procurement)
  - [Project](#domain-project)
  - [Quality](#domain-quality)
  - [Safety](#domain-safety)
  - [Schedule](#domain-schedule)
  - [Site](#domain-site)
  - [Subcontractor](#domain-subcontractor)
  - [Sustainability](#domain-sustainability)
  - [Workforce](#domain-workforce)


## Business Description

construction industry enterprise data model.

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases. Both models share the same attribute depth per table; the difference is in breadth (number of domains and tables).

### MVM (Minimum Viable Model) — `v2_mvm`

The **MVM** is a production-ready, core data model that covers all essential business functions with full attribute depth. It is the recommended starting point for organizations that want to deploy quickly and expand incrementally. The MVM is ideal for:

- **Small-to-Mid Businesses** — A thin, efficient model for organizations that need a complete but focused data platform without the overhead of corporate back-office domains
- **Production-Ready Foundation** — Deploy to production from day one and grow by adding domains as business needs evolve
- **Proof-of-Concept & Demos** — Quick deployment for stakeholder presentations and proof-of-concept engagements
- **Targeted Analytics** — Focused analytical workloads centered on core business processes
- **Rapid Onboarding** — Simplified structure for teams getting started with the data platform
- **Development & Testing** — Lightweight model for development environments and integration testing

The MVM prioritizes **Operations** and **Business** division domains, excludes corporate/back-office functions, minimizes association (many-to-many bridge) tables, and relies on direct foreign key relationships for simplicity. Every table in the MVM has the **same attribute depth** as the ECM.

### ECM (Expanded Coverage Model) — `v2_ecm`

The **ECM** is a comprehensive, full-coverage data model that covers the complete breadth of business operations, including corporate functions, detailed audit trails, association tables, and granular reference data. It is designed for:

- **Enterprise-Scale Organizations** — Complete data platform for large-scale enterprises with complex operations
- **Full-Coverage Data Warehousing** — Lakehouse model supporting all business units and divisions
- **Regulatory & Compliance** — Includes audit, legal, and compliance domains required for governance
- **Cross-Functional Analytics** — Enables analysis across all divisions including HR, Finance, IT, and more

The ECM includes all domains from the MVM plus additional **Corporate/Supporting** division domains, many-to-many association tables, helper/lookup tables, and expanded attribute coverage.


## Head-to-Head Comparison

| Dimension | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| **Folder Convention** | `v2/mvm` | `v2/ecm` |
| **Target Organization** | Small-to-mid businesses, startups, focused teams | Large enterprises, complex multi-division organizations |
| **Domain Coverage** | Core operations + business domains | All domains including corporate back-office |
| **Divisions Included** | Operations, Business | Operations, Business, Corporate |
| **Attribute Depth** | Full (same as ECM) | Full |
| **M:N Associations** | Minimized (direct FKs preferred) | Comprehensive junction tables |
| **Growth Path** | Start here, enlarge to ECM as needed | Complete from day one |
| **Best For** | Quick production deployments, focused analytics, POC, growing businesses | Organization-wide analytics, compliance, global operations |

## Model Metrics Comparison

| Metric | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| Domains | 13 | 20 |
| Subdomains | 32 | 68 |
| Products (Tables) | 133 | 378 |
| Attributes (Columns) | 5231 | 14095 |
| Foreign Keys | 949 | 1874 |
| Avg Attributes/Product | 39.3 | 37.3 |

## Domain & Product Comparison

<a id="domain-bid"></a>
### bid

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| firm_qualification | bid_prequalification | ✅ | ❌ | Domain not in MVM |
| firm_qualification | bid_subcontractor_prequalification | ✅ | ❌ | Domain not in MVM |
| firm_qualification | firm_profile | ✅ | ❌ | Domain not in MVM |
| firm_qualification | jv_partner | ✅ | ❌ | Domain not in MVM |
| firm_qualification | subcontractor_bond | ✅ | ❌ | Domain not in MVM |
| pursuit_pipeline | approval | ✅ | ❌ | Domain not in MVM |
| pursuit_pipeline | bid_opportunity | ✅ | ❌ | Domain not in MVM |
| pursuit_pipeline | bid_team_assignment | ✅ | ❌ | Domain not in MVM |
| pursuit_pipeline | bond | ✅ | ❌ | Domain not in MVM |
| pursuit_pipeline | clarification | ✅ | ❌ | Domain not in MVM |
| pursuit_pipeline | response | ✅ | ❌ | Domain not in MVM |
| pursuit_pipeline | submission | ✅ | ❌ | Domain not in MVM |
| pursuit_pipeline | tender | ✅ | ❌ | Domain not in MVM |
| pursuit_pipeline | win_loss_record | ✅ | ❌ | Domain not in MVM |
| scope_pricing | bid_boq_line | ✅ | ❌ | Domain not in MVM |
| scope_pricing | bid_risk | ✅ | ❌ | Domain not in MVM |
| scope_pricing | boq | ✅ | ❌ | Domain not in MVM |
| scope_pricing | estimate | ✅ | ❌ | Domain not in MVM |
| scope_pricing | estimate_line | ✅ | ❌ | Domain not in MVM |
| scope_pricing | trade_package | ✅ | ❌ | Domain not in MVM |
| scope_pricing | vendor_quote | ✅ | ❌ | Domain not in MVM |

<a id="domain-client"></a>
### client

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ✅ | ✅ |  |
| account_management | account_credit_profile | ✅ | ✅ |  |
| account_management | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_management | address | ✅ | ✅ |  |
| account_management | client_framework_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | contact | ✅ | ✅ |  |
| account_management | jv_structure | ✅ | ✅ |  |
| account_management | segment | ✅ | ❌ | Excluded from MVM |
| business_development | client_opportunity | ✅ | ❌ | Excluded from MVM |
| business_development | client_prequalification | ✅ | ❌ | Excluded from MVM |
| business_development | interaction | ✅ | ✅ |  |
| business_development | project_engagement | ✅ | ✅ |  |
| business_development | rfp_issuance | ✅ | ❌ | Excluded from MVM |
| business_development | survey | ✅ | ❌ | Excluded from MVM |
| client_identity | jv_participation | ❌ | ✅ | MVM only (stub or new) |
| commercial_engagement | opportunity | ❌ | ✅ | MVM only (stub or new) |
| commercial_engagement | prequalification | ❌ | ✅ | MVM only (stub or new) |
| financial_agreements | framework_agreement | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_assurance | assessment | ✅ | ❌ | Domain not in MVM |
| audit_assurance | audit_report | ✅ | ❌ | Domain not in MVM |
| audit_assurance | compliance_action | ✅ | ❌ | Domain not in MVM |
| audit_assurance | finding | ✅ | ❌ | Domain not in MVM |
| audit_assurance | iso_audit | ✅ | ❌ | Domain not in MVM |
| audit_assurance | iso_certification | ✅ | ❌ | Domain not in MVM |
| environmental_standards | env_impact_assessment | ✅ | ❌ | Domain not in MVM |
| environmental_standards | env_monitoring | ✅ | ❌ | Domain not in MVM |
| environmental_standards | leed_certification | ✅ | ❌ | Domain not in MVM |
| environmental_standards | leed_credit | ✅ | ❌ | Domain not in MVM |
| permit_licensing | compliance_permit | ✅ | ❌ | Domain not in MVM |
| permit_licensing | permit_application | ✅ | ❌ | Domain not in MVM |
| permit_licensing | permit_condition | ✅ | ❌ | Domain not in MVM |
| permit_licensing | waiver_exemption | ✅ | ❌ | Domain not in MVM |
| privacy_security | consent_record | ✅ | ❌ | Domain not in MVM |
| privacy_security | pci_assessment | ✅ | ❌ | Domain not in MVM |
| privacy_security | pci_control | ✅ | ❌ | Domain not in MVM |
| privacy_security | privacy_incident | ✅ | ❌ | Domain not in MVM |
| privacy_security | privacy_obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | authority_notice | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | compliance_calendar | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_authority | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_change | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_obligation | ✅ | ❌ | Domain not in MVM |
| regulatory_oversight | regulatory_submission | ✅ | ❌ | Domain not in MVM |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_claims | change_order_activity_impact | ✅ | ❌ | Excluded from MVM |
| change_claims | contract_change_order | ✅ | ✅ |  |
| change_claims | contract_eot_claim | ✅ | ❌ | Excluded from MVM |
| change_claims | dispute | ✅ | ❌ | Excluded from MVM |
| change_claims | ld_assessment | ✅ | ❌ | Excluded from MVM |
| contract_administration | agreement | ✅ | ✅ |  |
| contract_administration | amendment | ✅ | ❌ | Excluded from MVM |
| contract_administration | closeout | ✅ | ❌ | Excluded from MVM |
| contract_administration | contract_insurance_certificate | ✅ | ❌ | Excluded from MVM |
| contract_administration | contract_scope | ✅ | ❌ | Excluded from MVM |
| contract_administration | contractual_notice | ✅ | ❌ | Excluded from MVM |
| contract_administration | party | ✅ | ✅ |  |
| contract_administration | scope | ❌ | ✅ | MVM only (stub or new) |
| financial_security | advance_payment | ✅ | ❌ | Excluded from MVM |
| financial_security | bond_guarantee | ✅ | ✅ |  |
| financial_security | contract_retention_ledger | ✅ | ❌ | Excluded from MVM |
| financial_security | insurance_register | ✅ | ✅ |  |
| financial_security | payment_certificate | ✅ | ✅ |  |
| financial_security | payment_schedule | ✅ | ✅ |  |
| milestone_obligations | contract_milestone | ✅ | ✅ |  |
| milestone_obligations | dlp_register | ✅ | ❌ | Excluded from MVM |
| payment_management | eot_claim | ❌ | ✅ | MVM only (stub or new) |
| subcontract_management | subcontract | ✅ | ✅ |  |
| subcontract_management | subcontract_payment | ✅ | ✅ |  |

<a id="domain-design"></a>
### design

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| document_control | access_permission | ✅ | ❌ | Excluded from MVM |
| document_control | correspondence | ✅ | ❌ | Excluded from MVM |
| document_control | correspondence_response | ✅ | ❌ | Excluded from MVM |
| document_control | distribution_matrix | ✅ | ❌ | Excluded from MVM |
| document_control | document_register | ✅ | ✅ |  |
| document_control | revision | ✅ | ✅ |  |
| document_control | rfi | ✅ | ✅ |  |
| document_control | transmittal | ✅ | ✅ |  |
| document_control | transmittal_item | ✅ | ❌ | Excluded from MVM |
| document_control | workflow_approval | ✅ | ✅ |  |
| document_control | workflow_template | ✅ | ❌ | Excluded from MVM |
| drawing_specifications | drawing_specification_compliance | ❌ | ✅ | MVM only (stub or new) |
| drawing_specifications | submittal | ❌ | ✅ | MVM only (stub or new) |
| engineering_deliverables | bim_model | ✅ | ✅ |  |
| engineering_deliverables | calculation_register | ✅ | ❌ | Excluded from MVM |
| engineering_deliverables | design_scope | ✅ | ❌ | Excluded from MVM |
| engineering_deliverables | drawing | ✅ | ✅ |  |
| engineering_deliverables | drawing_requirement | ✅ | ❌ | Excluded from MVM |
| engineering_deliverables | drawing_revision | ✅ | ✅ |  |
| engineering_deliverables | package | ✅ | ❌ | Excluded from MVM |
| engineering_deliverables | technical_specification | ✅ | ✅ |  |
| handover_commissioning | handover_item | ✅ | ❌ | Excluded from MVM |
| handover_commissioning | handover_package | ✅ | ❌ | Excluded from MVM |
| interface_coordination | change_impact | ✅ | ❌ | Excluded from MVM |
| interface_coordination | drawing_incident_link | ✅ | ❌ | Excluded from MVM |
| interface_coordination | equipment_installation | ✅ | ❌ | Excluded from MVM |
| interface_coordination | interface_equipment_assignment | ✅ | ❌ | Excluded from MVM |
| interface_coordination | interface_point | ✅ | ❌ | Excluded from MVM |
| interface_coordination | mep_coordination_zone | ✅ | ❌ | Excluded from MVM |
| interface_coordination | zone_equipment_allocation | ✅ | ❌ | Excluded from MVM |
| review_approval | change_notice | ✅ | ❌ | Excluded from MVM |
| review_approval | clash_detection_run | ✅ | ❌ | Excluded from MVM |
| review_approval | design_submittal | ✅ | ❌ | Excluded from MVM |
| review_approval | review | ✅ | ❌ | Excluded from MVM |
| review_approval | value_engineering_proposal | ✅ | ❌ | Excluded from MVM |

<a id="domain-employee"></a>
### employee

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | *(no products)* | ✅ | ❌ | |

<a id="domain-equipment"></a>
### equipment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | asset | ✅ | ✅ |  |
| asset_registry | asset_category | ✅ | ✅ |  |
| asset_registry | asset_valuation | ✅ | ❌ | Excluded from MVM |
| asset_registry | functional_location | ✅ | ❌ | Excluded from MVM |
| asset_registry | insurance_policy | ✅ | ❌ | Excluded from MVM |
| asset_registry | rental_agreement | ✅ | ✅ |  |
| fleet_operations | equipment_mobilization | ✅ | ❌ | Excluded from MVM |
| fleet_operations | fleet_assignment | ✅ | ✅ |  |
| fleet_operations | fuel_point | ✅ | ❌ | Excluded from MVM |
| fleet_operations | fuel_transaction | ✅ | ✅ |  |
| fleet_operations | hours | ✅ | ✅ |  |
| fleet_operations | telematics_reading | ✅ | ❌ | Excluded from MVM |
| maintenance_planning | inspection_record | ✅ | ✅ |  |
| maintenance_planning | maintenance_notification | ✅ | ❌ | Excluded from MVM |
| maintenance_planning | maintenance_order | ✅ | ✅ |  |
| maintenance_planning | maintenance_plan | ✅ | ✅ |  |
| operator_compliance | asset_activity_assignment | ✅ | ❌ | Excluded from MVM |
| operator_compliance | operator_certification | ✅ | ❌ | Excluded from MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| billing_collections | accounts_receivable_invoice | ✅ | ❌ | Excluded from MVM |
| billing_collections | billing_period | ✅ | ❌ | Excluded from MVM |
| billing_collections | finance_retention_ledger | ✅ | ❌ | Excluded from MVM |
| billing_collections | financial_guarantee | ✅ | ❌ | Excluded from MVM |
| billing_collections | invoice | ✅ | ✅ |  |
| billing_collections | payment_record | ✅ | ✅ |  |
| billing_collections | payment_run | ✅ | ❌ | Excluded from MVM |
| billing_collections | progress_billing | ✅ | ✅ |  |
| budget_planning | cash_flow_forecast | ✅ | ✅ |  |
| budget_planning | earned_value_record | ✅ | ✅ |  |
| budget_planning | finance_budget_revision | ✅ | ❌ | Excluded from MVM |
| budget_planning | job_cost_transaction | ✅ | ✅ |  |
| budget_planning | project_budget | ✅ | ✅ |  |
| cost_control | commitment | ✅ | ❌ | Excluded from MVM |
| cost_control | commitment_item | ✅ | ❌ | Excluded from MVM |
| cost_control | cost_center | ✅ | ✅ |  |
| cost_control | cost_code | ✅ | ✅ |  |
| cost_control | profit_center | ✅ | ❌ | Excluded from MVM |
| ledger_accounting | chart_of_accounts | ✅ | ❌ | Excluded from MVM |
| ledger_accounting | company_code | ✅ | ❌ | Excluded from MVM |
| ledger_accounting | gl_account | ✅ | ✅ |  |
| ledger_accounting | journal_entry | ✅ | ✅ |  |
| ledger_accounting | journal_entry_line | ✅ | ✅ |  |
| ledger_accounting | revenue_recognition_entry | ✅ | ❌ | Excluded from MVM |

<a id="domain-hr"></a>
### hr

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employee_relations | disciplinary_case | ✅ | ❌ | Domain not in MVM |
| employee_relations | grievance | ✅ | ❌ | Domain not in MVM |
| leave_attendance | leave_balance | ✅ | ❌ | Domain not in MVM |
| leave_attendance | leave_request | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | compensation_review | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_group | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| payroll_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| performance_development | goal | ✅ | ❌ | Domain not in MVM |
| performance_development | performance_review | ✅ | ❌ | Domain not in MVM |
| performance_development | training_course | ✅ | ❌ | Domain not in MVM |
| performance_development | training_enrollment | ✅ | ❌ | Domain not in MVM |
| talent_lifecycle | applicant | ✅ | ❌ | Domain not in MVM |
| talent_lifecycle | application | ✅ | ❌ | Domain not in MVM |
| talent_lifecycle | onboarding_checklist | ✅ | ❌ | Domain not in MVM |
| talent_lifecycle | onboarding_template | ✅ | ❌ | Domain not in MVM |
| talent_lifecycle | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
| talent_lifecycle | separation | ✅ | ❌ | Domain not in MVM |
| workforce_master | employee | ✅ | ❌ | Domain not in MVM |
| workforce_master | employment_contract | ✅ | ❌ | Domain not in MVM |
| workforce_master | job_profile | ✅ | ❌ | Domain not in MVM |
| workforce_master | kpi | ✅ | ❌ | Domain not in MVM |
| workforce_master | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_master | policy | ✅ | ❌ | Domain not in MVM |
| workforce_master | position | ✅ | ❌ | Domain not in MVM |
| workforce_master | succession_plan | ✅ | ❌ | Domain not in MVM |
| workforce_master | workforce_headcount_plan | ✅ | ❌ | Domain not in MVM |

<a id="domain-material"></a>
### material

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_registry | approved_material_list | ✅ | ❌ | Excluded from MVM |
| catalog_registry | batch_lot | ✅ | ✅ |  |
| catalog_registry | conformance_certificate | ✅ | ❌ | Excluded from MVM |
| catalog_registry | master | ✅ | ✅ |  |
| catalog_registry | specification | ✅ | ❌ | Excluded from MVM |
| hazard_compliance | hazmat_register | ✅ | ❌ | Excluded from MVM |
| hazard_compliance | wastage | ✅ | ❌ | Excluded from MVM |
| inventory_control | goods_issue | ✅ | ✅ |  |
| inventory_control | physical_inventory | ✅ | ❌ | Excluded from MVM |
| inventory_control | requisition | ✅ | ❌ | Excluded from MVM |
| inventory_control | stock_level | ✅ | ✅ |  |
| inventory_control | stock_movement | ✅ | ✅ |  |
| inventory_control | stock_transfer | ✅ | ❌ | Excluded from MVM |
| inventory_control | warehouse | ✅ | ✅ |  |
| material_catalog | boq_line | ❌ | ✅ | MVM only (stub or new) |
| quantity_planning | material_boq_line | ✅ | ❌ | Excluded from MVM |
| quantity_planning | mto_header | ✅ | ✅ |  |
| quantity_planning | mto_line | ✅ | ✅ |  |

<a id="domain-org_unit"></a>
### org_unit

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | *(no products)* | ✅ | ❌ | |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| order_fulfillment | delivery_schedule | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | goods_receipt | ✅ | ✅ |  |
| order_fulfillment | inspection_release | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | po_amendment | ✅ | ❌ | Excluded from MVM |
| order_fulfillment | po_line | ✅ | ✅ |  |
| order_fulfillment | purchase_order | ✅ | ✅ |  |
| order_fulfillment | purchase_requisition | ✅ | ✅ |  |
| sourcing_bidding | approval_workflow | ✅ | ❌ | Excluded from MVM |
| sourcing_bidding | procurement_bid | ✅ | ❌ | Excluded from MVM |
| sourcing_bidding | rfq | ✅ | ✅ |  |
| sourcing_bidding | rfq_line | ✅ | ✅ |  |
| sourcing_bidding | vendor_quotation | ✅ | ❌ | Excluded from MVM |
| vendor_management | material_catalog | ✅ | ✅ |  |
| vendor_management | procurement_framework_agreement | ✅ | ❌ | Excluded from MVM |
| vendor_management | service | ✅ | ❌ | Excluded from MVM |
| vendor_management | sourcing_info_record | ❌ | ✅ | MVM only (stub or new) |
| vendor_management | sourcing_plan | ✅ | ❌ | Excluded from MVM |
| vendor_management | vendor | ✅ | ✅ |  |
| vendor_management | vendor_document | ✅ | ❌ | Excluded from MVM |
| vendor_management | vendor_evaluation | ✅ | ❌ | Excluded from MVM |
| vendor_management | vendor_invoice | ✅ | ✅ |  |
| vendor_management | vendor_qualification | ✅ | ✅ |  |

<a id="domain-project"></a>
### project

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| handover_management | commissioning_package | ✅ | ❌ | Excluded from MVM |
| handover_management | handover_certificate | ✅ | ❌ | Excluded from MVM |
| handover_management | regulatory_oversight | ✅ | ❌ | Excluded from MVM |
| performance_tracking | evm_period_record | ✅ | ✅ |  |
| performance_tracking | forecast | ✅ | ❌ | Excluded from MVM |
| performance_tracking | progress_measurement | ✅ | ✅ |  |
| performance_tracking | reporting_period | ✅ | ❌ | Excluded from MVM |
| project_governance | construction_project | ✅ | ✅ |  |
| project_governance | phase | ✅ | ✅ |  |
| project_governance | project_baseline | ✅ | ✅ |  |
| project_governance | project_milestone | ✅ | ✅ |  |
| project_governance | project_site | ✅ | ✅ |  |
| project_governance | risk_register | ✅ | ✅ |  |
| project_governance | team_member | ✅ | ❌ | Excluded from MVM |
| scope_control | cost_account | ✅ | ✅ |  |
| scope_control | deliverable | ✅ | ✅ |  |
| scope_control | project_budget_revision | ✅ | ❌ | Excluded from MVM |
| scope_control | project_change_order | ✅ | ✅ |  |
| scope_control | wbs_element | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| defect_control | corrective_action | ✅ | ✅ |  |
| defect_control | defect | ✅ | ❌ | Excluded from MVM |
| defect_control | ncr | ✅ | ✅ |  |
| defect_control | punch_item | ✅ | ✅ |  |
| defect_control | punch_list | ✅ | ✅ |  |
| defect_control | quality_audit | ✅ | ❌ | Excluded from MVM |
| field_testing | acceptance_test | ✅ | ❌ | Excluded from MVM |
| field_testing | concrete_pour_record | ✅ | ❌ | Excluded from MVM |
| field_testing | inspection | ✅ | ✅ |  |
| field_testing | lab_test | ✅ | ❌ | Excluded from MVM |
| field_testing | laboratory | ✅ | ❌ | Excluded from MVM |
| field_testing | ndt_record | ✅ | ❌ | Excluded from MVM |
| field_testing | sample | ✅ | ❌ | Excluded from MVM |
| field_testing | test_certificate | ✅ | ✅ |  |
| field_testing | weld_record | ✅ | ❌ | Excluded from MVM |
| inspection_planning | checklist | ✅ | ✅ |  |
| inspection_planning | checklist_execution | ✅ | ❌ | Excluded from MVM |
| inspection_planning | itp | ✅ | ✅ |  |
| inspection_planning | itp_line | ✅ | ✅ |  |
| inspection_planning | plan | ❌ | ✅ | MVM only (stub or new) |
| inspection_planning | quality_plan | ✅ | ❌ | Excluded from MVM |
| inspection_planning | quality_submittal | ✅ | ❌ | Excluded from MVM |

<a id="domain-safety"></a>
### safety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_compliance | hse_inspection | ✅ | ❌ | Excluded from MVM |
| field_compliance | hse_plan | ✅ | ✅ |  |
| field_compliance | safety_audit | ✅ | ❌ | Excluded from MVM |
| field_compliance | toolbox_meeting | ✅ | ✅ |  |
| incident_management | incident | ✅ | ✅ |  |
| incident_management | incident_investigation | ✅ | ✅ |  |
| incident_management | incident_subcontractor_involvement | ✅ | ❌ | Excluded from MVM |
| risk_control | environmental_monitoring | ✅ | ❌ | Excluded from MVM |
| risk_control | hazard_register | ✅ | ✅ |  |
| risk_control | permit_to_work | ✅ | ✅ |  |
| risk_control | risk_assessment | ✅ | ✅ |  |
| risk_control | swms | ✅ | ✅ |  |
| worker_protection | chemical_register | ✅ | ❌ | Excluded from MVM |
| worker_protection | ppe_register | ✅ | ❌ | Excluded from MVM |
| worker_protection | training | ✅ | ❌ | Excluded from MVM |

<a id="domain-schedule"></a>
### schedule

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| activity_planning | activity | ✅ | ✅ |  |
| activity_planning | activity_relationship | ✅ | ✅ |  |
| activity_planning | activity_resource_assignment | ✅ | ✅ |  |
| activity_planning | resource | ✅ | ✅ |  |
| activity_planning | schedule_calendar | ✅ | ❌ | Excluded from MVM |
| activity_planning | wbs_node | ✅ | ❌ | Excluded from MVM |
| baseline_control | baseline_activity | ✅ | ✅ |  |
| baseline_control | schedule_baseline | ✅ | ✅ |  |
| baseline_control | schedule_eot_claim | ✅ | ❌ | Excluded from MVM |
| baseline_control | schedule_milestone | ✅ | ✅ |  |
| delay_impact | delay_activity_impact | ❌ | ✅ | MVM only (stub or new) |
| progress_tracking | delay_event | ✅ | ✅ |  |
| progress_tracking | lookahead_activity | ✅ | ❌ | Excluded from MVM |
| progress_tracking | lookahead_plan | ✅ | ❌ | Excluded from MVM |
| progress_tracking | progress_update | ✅ | ✅ |  |
| progress_tracking | schedule_risk | ✅ | ❌ | Excluded from MVM |

<a id="domain-site"></a>
### site

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| field_operations | crew_deployment | ✅ | ✅ |  |
| field_operations | equipment_deployment | ✅ | ✅ |  |
| field_operations | instruction | ✅ | ❌ | Excluded from MVM |
| field_operations | material_delivery | ✅ | ✅ |  |
| field_operations | work_front | ✅ | ✅ |  |
| field_operations | work_front_assignment | ✅ | ❌ | Excluded from MVM |
| production_tracking | concrete_pour | ✅ | ✅ |  |
| production_tracking | daily_log | ✅ | ✅ |  |
| production_tracking | earthwork_volume | ✅ | ❌ | Excluded from MVM |
| production_tracking | field_progress | ✅ | ✅ |  |
| production_tracking | production_entry | ✅ | ✅ |  |
| production_tracking | shift_report | ✅ | ❌ | Excluded from MVM |
| site_operations | permit | ❌ | ✅ | MVM only (stub or new) |
| site_setup | lift_plan | ✅ | ❌ | Excluded from MVM |
| site_setup | logistics_plan | ✅ | ❌ | Excluded from MVM |
| site_setup | site | ✅ | ✅ |  |
| site_setup | site_location | ✅ | ❌ | Excluded from MVM |
| site_setup | site_mobilization | ✅ | ❌ | Excluded from MVM |
| site_setup | site_permit | ✅ | ❌ | Excluded from MVM |

<a id="domain-subcontractor"></a>
### subcontractor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_claims | back_charge | ✅ | ❌ | Domain not in MVM |
| change_claims | final_account | ✅ | ❌ | Domain not in MVM |
| change_claims | subcontractor_change_order | ✅ | ❌ | Domain not in MVM |
| change_claims | subcontractor_eot_claim | ✅ | ❌ | Domain not in MVM |
| contract_administration | subcontract_scope_package | ✅ | ❌ | Domain not in MVM |
| contract_administration | subcontractor_agreement | ✅ | ❌ | Domain not in MVM |
| contract_administration | subcontractor_scope_package | ✅ | ❌ | Domain not in MVM |
| contract_administration | subcontractor_work_package | ✅ | ❌ | Domain not in MVM |
| contract_administration | subcontractor_work_package_assignment | ✅ | ❌ | Domain not in MVM |
| payment_settlement | subcontract_progress_claim | ✅ | ❌ | Domain not in MVM |
| payment_settlement | subcontractor_invoice | ✅ | ❌ | Domain not in MVM |
| payment_settlement | subcontractor_payment_application | ✅ | ❌ | Domain not in MVM |
| payment_settlement | subcontractor_payment_certificate | ✅ | ❌ | Domain not in MVM |
| vendor_onboarding | performance_scorecard | ✅ | ❌ | Domain not in MVM |
| vendor_onboarding | subcontractor_compliance_record | ✅ | ❌ | Domain not in MVM |
| vendor_onboarding | subcontractor_insurance | ✅ | ❌ | Domain not in MVM |
| vendor_onboarding | subcontractor_performance_evaluation | ✅ | ❌ | Domain not in MVM |
| vendor_onboarding | subcontractor_performance_review | ✅ | ❌ | Domain not in MVM |
| vendor_onboarding | subcontractor_performance_scorecard | ✅ | ❌ | Domain not in MVM |
| vendor_onboarding | subcontractor_prequalification | ✅ | ❌ | Domain not in MVM |
| vendor_onboarding | subcontractor_profile | ✅ | ❌ | Domain not in MVM |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carbon_management | carbon_emission | ✅ | ❌ | Domain not in MVM |
| carbon_management | carbon_offset | ✅ | ❌ | Domain not in MVM |
| carbon_management | carbon_reduction_initiative | ✅ | ❌ | Domain not in MVM |
| carbon_management | carbon_target | ✅ | ❌ | Domain not in MVM |
| carbon_management | embodied_carbon_assessment | ✅ | ❌ | Domain not in MVM |
| carbon_management | emission_factor | ✅ | ❌ | Domain not in MVM |
| carbon_management | emission_source | ✅ | ❌ | Domain not in MVM |
| carbon_management | supply_chain_carbon | ✅ | ❌ | Domain not in MVM |
| climate_risk | biodiversity_assessment | ✅ | ❌ | Domain not in MVM |
| climate_risk | climate_risk_assessment | ✅ | ❌ | Domain not in MVM |
| climate_risk | climate_risk_item | ✅ | ❌ | Domain not in MVM |
| esg_reporting | esg_disclosure_item | ✅ | ❌ | Domain not in MVM |
| esg_reporting | esg_report | ✅ | ❌ | Domain not in MVM |
| esg_reporting | social_value_record | ✅ | ❌ | Domain not in MVM |
| esg_reporting | sustainability_action | ✅ | ❌ | Domain not in MVM |
| esg_reporting | sustainability_audit | ✅ | ❌ | Domain not in MVM |
| esg_reporting | sustainability_plan | ✅ | ❌ | Domain not in MVM |
| green_building | energy_consumption | ✅ | ❌ | Domain not in MVM |
| green_building | green_certification | ✅ | ❌ | Domain not in MVM |
| green_building | green_credit | ✅ | ❌ | Domain not in MVM |
| green_building | sustainable_material | ✅ | ❌ | Domain not in MVM |
| green_building | water_consumption | ✅ | ❌ | Domain not in MVM |
| waste_environmental | disposal_facility | ✅ | ❌ | Domain not in MVM |
| waste_environmental | env_incident | ✅ | ❌ | Domain not in MVM |
| waste_environmental | waste_carrier | ✅ | ❌ | Domain not in MVM |
| waste_environmental | waste_record | ✅ | ❌ | Domain not in MVM |
| waste_environmental | waste_target | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agency_staffing | agency | ✅ | ❌ | Excluded from MVM |
| agency_staffing | agency_labor_order | ✅ | ❌ | Excluded from MVM |
| agency_staffing | apprenticeship_progression | ✅ | ❌ | Excluded from MVM |
| agency_staffing | labor_mobilization | ✅ | ❌ | Excluded from MVM |
| agency_staffing | site_access_record | ✅ | ❌ | Excluded from MVM |
| field_productivity | carbon_reduction_participation | ✅ | ❌ | Excluded from MVM |
| field_productivity | labor_cost_code | ✅ | ✅ |  |
| field_productivity | production_rate | ✅ | ❌ | Excluded from MVM |
| field_productivity | staffing_plan | ✅ | ❌ | Excluded from MVM |
| field_productivity | timesheet | ✅ | ✅ |  |
| field_productivity | timesheet_line | ✅ | ✅ |  |
| labor_registry | craft_certification | ✅ | ✅ |  |
| labor_registry | craft_worker | ✅ | ✅ |  |
| labor_registry | crew | ✅ | ✅ |  |
| labor_registry | crew_assignment | ✅ | ✅ |  |
| labor_registry | labor_agreement | ✅ | ❌ | Excluded from MVM |
| labor_registry | labor_rate | ✅ | ✅ |  |
| labor_registry | skill_trade | ✅ | ❌ | Excluded from MVM |
