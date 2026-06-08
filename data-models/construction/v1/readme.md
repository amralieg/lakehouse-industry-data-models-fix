# Construction Lakehouse Data Models

**Version 1** | Generated on May 07, 2026 at 09:26 AM

**Industry:** construction

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Bid](#domain-bid)
  - [Client](#domain-client)
  - [Compliance](#domain-compliance)
  - [Contract](#domain-contract)
  - [Design](#domain-design)
  - [Equipment](#domain-equipment)
  - [Finance](#domain-finance)
  - [Hr](#domain-hr)
  - [Material](#domain-material)
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

Construction is a global engineering and building industry delivering large-scale infrastructure, energy, and commercial projects including highways, airports, bridges, power plants, and residential developments.

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases. Both models share the same attribute depth per table; the difference is in breadth (number of domains and tables).

### MVM (Minimum Viable Model) — `v1_mvm`

The **MVM** is a production-ready, core data model that covers all essential business functions with full attribute depth. It is the recommended starting point for organizations that want to deploy quickly and expand incrementally. The MVM is ideal for:

- **Small-to-Mid Businesses** — A thin, efficient model for organizations that need a complete but focused data platform without the overhead of corporate back-office domains
- **Production-Ready Foundation** — Deploy to production from day one and grow by adding domains as business needs evolve
- **Proof-of-Concept & Demos** — Quick deployment for stakeholder presentations and proof-of-concept engagements
- **Targeted Analytics** — Focused analytical workloads centered on core business processes
- **Rapid Onboarding** — Simplified structure for teams getting started with the data platform
- **Development & Testing** — Lightweight model for development environments and integration testing

The MVM prioritizes **Operations** and **Business** division domains, excludes corporate/back-office functions, minimizes association (many-to-many bridge) tables, and relies on direct foreign key relationships for simplicity. Every table in the MVM has the **same attribute depth** as the ECM.

### ECM (Expanded Coverage Model) — `v1_ecm`

The **ECM** is a comprehensive, full-coverage data model that covers the complete breadth of business operations, including corporate functions, detailed audit trails, association tables, and granular reference data. It is designed for:

- **Enterprise-Scale Organizations** — Complete data platform for large-scale enterprises with complex operations
- **Full-Coverage Data Warehousing** — Lakehouse model supporting all business units and divisions
- **Regulatory & Compliance** — Includes audit, legal, and compliance domains required for governance
- **Cross-Functional Analytics** — Enables analysis across all divisions including HR, Finance, IT, and more

The ECM includes all domains from the MVM plus additional **Corporate/Supporting** division domains, many-to-many association tables, helper/lookup tables, and expanded attribute coverage.


## Head-to-Head Comparison

| Dimension | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| **Folder Convention** | `v1/mvm` | `v1/ecm` |
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
| Domains | 15 | 18 |
| Subdomains | 43 | 52 |
| Products (Tables) | 189 | 365 |
| Attributes (Columns) | 7761 | 13220 |
| Foreign Keys | 1839 | 1817 |
| Avg Attributes/Product | 41.1 | 36.2 |

## Domain & Product Comparison

<a id="domain-bid"></a>
### bid

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| bid_process | approval | ✅ | ✅ |  |
| bid_process | bid_opportunity | ✅ | ✅ |  |
| bid_process | bid_prequalification | ✅ | ❌ | Excluded from MVM |
| bid_process | bid_risk | ✅ | ❌ | Excluded from MVM |
| bid_process | bid_team_assignment | ✅ | ❌ | Excluded from MVM |
| bid_process | clarification | ✅ | ✅ |  |
| bid_process | response | ✅ | ❌ | Excluded from MVM |
| bid_process | submission | ✅ | ✅ |  |
| bid_process | tender | ✅ | ✅ |  |
| bid_process | win_loss_record | ✅ | ❌ | Excluded from MVM |
| contract_administration | bond | ✅ | ✅ |  |
| contract_administration | contract_agreement | ✅ | ❌ | Excluded from MVM |
| contract_administration | jv_partner | ✅ | ❌ | Excluded from MVM |
| contract_administration | payment_application | ✅ | ❌ | Excluded from MVM |
| cost_pricing | risk | ❌ | ✅ | MVM only (stub or new) |
| estimate_pricing | bid_boq_line | ✅ | ✅ |  |
| estimate_pricing | boq | ✅ | ✅ |  |
| estimate_pricing | estimate | ✅ | ✅ |  |
| estimate_pricing | estimate_line | ✅ | ✅ |  |
| estimate_pricing | trade_package | ✅ | ✅ |  |
| estimate_pricing | vendor_quote | ✅ | ❌ | Excluded from MVM |
| subcontractor_management | firm_profile | ✅ | ❌ | Excluded from MVM |
| subcontractor_management | insurance_certificate | ✅ | ❌ | Excluded from MVM |
| subcontractor_management | lien_waiver | ✅ | ❌ | Excluded from MVM |
| subcontractor_management | performance_scorecard | ✅ | ❌ | Excluded from MVM |
| subcontractor_management | subcontractor_bond | ✅ | ❌ | Excluded from MVM |
| subcontractor_management | subcontractor_prequalification | ✅ | ❌ | Excluded from MVM |

<a id="domain-client"></a>
### client

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_administration | account | ✅ | ✅ |  |
| account_administration | account_credit_profile | ✅ | ✅ |  |
| account_administration | account_hierarchy | ✅ | ❌ | Excluded from MVM |
| account_administration | address | ✅ | ✅ |  |
| account_administration | client_framework_agreement | ✅ | ❌ | Excluded from MVM |
| account_administration | contact | ✅ | ✅ |  |
| account_administration | jv_structure | ✅ | ✅ |  |
| account_administration | segment | ✅ | ❌ | Excluded from MVM |
| account_identity | jv_participant | ❌ | ✅ | MVM only (stub or new) |
| commercial_engagement | framework_agreement | ❌ | ✅ | MVM only (stub or new) |
| opportunity_procurement | client_opportunity | ✅ | ✅ |  |
| opportunity_procurement | client_prequalification | ✅ | ❌ | Excluded from MVM |
| opportunity_procurement | interaction | ✅ | ❌ | Excluded from MVM |
| opportunity_procurement | project_engagement | ✅ | ✅ |  |
| opportunity_procurement | rfp_issuance | ✅ | ✅ |  |
| opportunity_procurement | survey | ✅ | ❌ | Excluded from MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| environmental_compliance | env_impact_assessment | ✅ | ✅ |  |
| environmental_compliance | env_monitoring | ✅ | ✅ |  |
| environmental_compliance | leed_certification | ✅ | ❌ | Excluded from MVM |
| environmental_compliance | leed_credit | ✅ | ❌ | Excluded from MVM |
| permit_management | compliance_calendar | ✅ | ✅ |  |
| permit_management | compliance_permit | ✅ | ❌ | Excluded from MVM |
| permit_management | permit | ❌ | ✅ | MVM only (stub or new) |
| permit_management | permit_application | ✅ | ✅ |  |
| permit_management | permit_condition | ✅ | ✅ |  |
| permit_management | regulatory_submission | ✅ | ✅ |  |
| regulatory_governance | assessment | ✅ | ✅ |  |
| regulatory_governance | audit_report | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | authority_notice | ✅ | ✅ |  |
| regulatory_governance | compliance_action | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | consent_record | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | finding | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | iso_audit | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | iso_certification | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | pci_assessment | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | pci_control | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | privacy_incident | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | privacy_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | regulatory_authority | ✅ | ✅ |  |
| regulatory_governance | regulatory_change | ✅ | ❌ | Excluded from MVM |
| regulatory_governance | regulatory_obligation | ✅ | ✅ |  |
| regulatory_governance | waiver_exemption | ✅ | ❌ | Excluded from MVM |
| regulatory_obligations | action | ❌ | ✅ | MVM only (stub or new) |
| regulatory_obligations | obligation_assessment_result | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_control | amendment | ✅ | ✅ |  |
| change_control | change_order_activity_impact | ✅ | ❌ | Excluded from MVM |
| change_control | contract_change_order | ✅ | ✅ |  |
| change_control | contract_eot_claim | ✅ | ❌ | Excluded from MVM |
| change_control | dispute | ✅ | ❌ | Excluded from MVM |
| change_control | ld_assessment | ✅ | ✅ |  |
| contract_administration | agreement | ✅ | ✅ |  |
| contract_administration | closeout | ✅ | ✅ |  |
| contract_administration | contract_milestone | ✅ | ✅ |  |
| contract_administration | contract_scope | ✅ | ❌ | Excluded from MVM |
| contract_administration | contractual_notice | ✅ | ❌ | Excluded from MVM |
| contract_administration | dlp_register | ✅ | ❌ | Excluded from MVM |
| contract_administration | party | ✅ | ✅ |  |
| contract_administration | payment_schedule | ✅ | ✅ |  |
| contract_administration | subcontract | ✅ | ✅ |  |
| contract_setup | scope | ❌ | ✅ | MVM only (stub or new) |
| financial_obligations | eot_claim | ❌ | ✅ | MVM only (stub or new) |
| financial_obligations | retention_ledger | ❌ | ✅ | MVM only (stub or new) |
| financial_operations | advance_payment | ✅ | ❌ | Excluded from MVM |
| financial_operations | bond_guarantee | ✅ | ✅ |  |
| financial_operations | contract_retention_ledger | ✅ | ❌ | Excluded from MVM |
| financial_operations | insurance_register | ✅ | ❌ | Excluded from MVM |
| financial_operations | payment_certificate | ✅ | ✅ |  |
| financial_operations | subcontract_payment | ✅ | ✅ |  |

<a id="domain-design"></a>
### design

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| change_control | change_impact | ✅ | ❌ | Excluded from MVM |
| change_control | change_notice | ✅ | ✅ |  |
| change_control | value_engineering_proposal | ✅ | ❌ | Excluded from MVM |
| design_documentation | bim_model | ✅ | ✅ |  |
| design_documentation | calculation_register | ✅ | ❌ | Excluded from MVM |
| design_documentation | design_scope | ✅ | ❌ | Excluded from MVM |
| design_documentation | document_register | ✅ | ✅ |  |
| design_documentation | drawing | ✅ | ✅ |  |
| design_documentation | drawing_revision | ✅ | ✅ |  |
| design_documentation | package | ✅ | ✅ |  |
| design_documentation | revision | ✅ | ✅ |  |
| design_documentation | technical_specification | ✅ | ✅ |  |
| document_control | submittal | ❌ | ✅ | MVM only (stub or new) |
| project_coordination | access_permission | ✅ | ❌ | Excluded from MVM |
| project_coordination | clash_detection_run | ✅ | ❌ | Excluded from MVM |
| project_coordination | correspondence | ✅ | ✅ |  |
| project_coordination | correspondence_response | ✅ | ❌ | Excluded from MVM |
| project_coordination | distribution_matrix | ✅ | ❌ | Excluded from MVM |
| project_coordination | drawing_incident_link | ✅ | ❌ | Excluded from MVM |
| project_coordination | drawing_requirement | ✅ | ❌ | Excluded from MVM |
| project_coordination | equipment_installation | ✅ | ❌ | Excluded from MVM |
| project_coordination | handover_item | ✅ | ✅ |  |
| project_coordination | handover_package | ✅ | ✅ |  |
| project_coordination | interface_equipment_assignment | ✅ | ❌ | Excluded from MVM |
| project_coordination | interface_point | ✅ | ❌ | Excluded from MVM |
| project_coordination | mep_coordination_zone | ✅ | ❌ | Excluded from MVM |
| project_coordination | transmittal | ✅ | ✅ |  |
| project_coordination | transmittal_item | ✅ | ❌ | Excluded from MVM |
| project_coordination | zone_equipment_allocation | ✅ | ❌ | Excluded from MVM |
| workflow_management | design_submittal | ✅ | ❌ | Excluded from MVM |
| workflow_management | review | ✅ | ✅ |  |
| workflow_management | rfi | ✅ | ✅ |  |
| workflow_management | workflow_approval | ✅ | ✅ |  |
| workflow_management | workflow_template | ✅ | ❌ | Excluded from MVM |

<a id="domain-equipment"></a>
### equipment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | asset | ✅ | ✅ |  |
| asset_management | asset_activity_assignment | ✅ | ❌ | Excluded from MVM |
| asset_management | asset_category | ✅ | ✅ |  |
| asset_management | asset_valuation | ✅ | ❌ | Excluded from MVM |
| asset_management | functional_location | ✅ | ❌ | Excluded from MVM |
| asset_management | insurance_policy | ✅ | ❌ | Excluded from MVM |
| fleet_logistics | equipment_mobilization | ✅ | ✅ |  |
| fleet_logistics | fleet_assignment | ✅ | ✅ |  |
| fleet_logistics | fuel_point | ✅ | ❌ | Excluded from MVM |
| fleet_logistics | fuel_transaction | ✅ | ✅ |  |
| fleet_logistics | hours | ✅ | ✅ |  |
| fleet_logistics | rental_agreement | ✅ | ✅ |  |
| fleet_logistics | telematics_reading | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | inspection_record | ✅ | ✅ |  |
| maintenance_operations | maintenance_notification | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | maintenance_order | ✅ | ✅ |  |
| maintenance_operations | maintenance_plan | ✅ | ✅ |  |
| maintenance_operations | operator_certification | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cash_operations | accounts_receivable_invoice | ✅ | ❌ | Excluded from MVM |
| cash_operations | cash_flow_forecast | ✅ | ✅ |  |
| cash_operations | invoice | ✅ | ✅ |  |
| cash_operations | payment_record | ✅ | ✅ |  |
| financial_accounting | chart_of_accounts | ✅ | ❌ | Excluded from MVM |
| financial_accounting | commitment | ✅ | ❌ | Excluded from MVM |
| financial_accounting | commitment_item | ✅ | ❌ | Excluded from MVM |
| financial_accounting | company_code | ✅ | ✅ |  |
| financial_accounting | cost_center | ✅ | ✅ |  |
| financial_accounting | cost_code | ✅ | ✅ |  |
| financial_accounting | finance_retention_ledger | ✅ | ❌ | Excluded from MVM |
| financial_accounting | financial_guarantee | ✅ | ❌ | Excluded from MVM |
| financial_accounting | gl_account | ✅ | ✅ |  |
| financial_accounting | journal_entry | ✅ | ✅ |  |
| financial_accounting | journal_entry_line | ✅ | ✅ |  |
| financial_accounting | payment_run | ✅ | ❌ | Excluded from MVM |
| financial_accounting | profit_center | ✅ | ✅ |  |
| project_management | billing_period | ✅ | ❌ | Excluded from MVM |
| project_management | earned_value_record | ✅ | ❌ | Excluded from MVM |
| project_management | finance_budget_revision | ✅ | ❌ | Excluded from MVM |
| project_management | job_cost_transaction | ✅ | ✅ |  |
| project_management | progress_billing | ✅ | ✅ |  |
| project_management | project_budget | ✅ | ✅ |  |
| project_management | revenue_recognition_entry | ✅ | ✅ |  |

<a id="domain-hr"></a>
### hr

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | compensation_review | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | leave_balance | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_group | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_run | ✅ | ❌ | Domain not in MVM |
| employee_development | goal | ✅ | ❌ | Domain not in MVM |
| employee_development | onboarding_checklist | ✅ | ❌ | Domain not in MVM |
| employee_development | onboarding_template | ✅ | ❌ | Domain not in MVM |
| employee_development | performance_review | ✅ | ❌ | Domain not in MVM |
| employee_development | succession_plan | ✅ | ❌ | Domain not in MVM |
| employee_development | training_course | ✅ | ❌ | Domain not in MVM |
| employee_development | training_enrollment | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | applicant | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | application | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | job_profile | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | position | ✅ | ❌ | Domain not in MVM |
| talent_acquisition | recruitment_requisition | ✅ | ❌ | Domain not in MVM |
| workforce_operations | disciplinary_case | ✅ | ❌ | Domain not in MVM |
| workforce_operations | employee | ✅ | ❌ | Domain not in MVM |
| workforce_operations | employment_contract | ✅ | ❌ | Domain not in MVM |
| workforce_operations | grievance | ✅ | ❌ | Domain not in MVM |
| workforce_operations | kpi | ✅ | ❌ | Domain not in MVM |
| workforce_operations | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_operations | policy | ✅ | ❌ | Domain not in MVM |
| workforce_operations | separation | ✅ | ❌ | Domain not in MVM |
| workforce_operations | workforce_headcount_plan | ✅ | ❌ | Domain not in MVM |

<a id="domain-material"></a>
### material

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| inventory_management | goods_issue | ✅ | ✅ |  |
| inventory_management | physical_inventory | ✅ | ❌ | Excluded from MVM |
| inventory_management | stock_level | ✅ | ✅ |  |
| inventory_management | stock_movement | ✅ | ✅ |  |
| inventory_management | stock_transfer | ✅ | ✅ |  |
| inventory_management | warehouse | ✅ | ✅ |  |
| inventory_management | wastage | ✅ | ✅ |  |
| material_specification | approved_material_list | ✅ | ❌ | Excluded from MVM |
| material_specification | batch_lot | ✅ | ❌ | Excluded from MVM |
| material_specification | conformance_certificate | ✅ | ❌ | Excluded from MVM |
| material_specification | hazmat_register | ✅ | ❌ | Excluded from MVM |
| material_specification | master | ✅ | ✅ |  |
| material_specification | specification | ✅ | ✅ |  |
| project_planning | material_boq_line | ✅ | ✅ |  |
| project_planning | mto_header | ✅ | ❌ | Excluded from MVM |
| project_planning | mto_line | ✅ | ✅ |  |
| project_planning | requisition | ✅ | ✅ |  |

<a id="domain-procurement"></a>
### procurement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| material_planning | material_catalog | ✅ | ✅ |  |
| material_planning | sourcing_plan | ✅ | ✅ |  |
| purchase_execution | approval_workflow | ✅ | ❌ | Excluded from MVM |
| purchase_execution | delivery_schedule | ✅ | ❌ | Excluded from MVM |
| purchase_execution | goods_receipt | ✅ | ✅ |  |
| purchase_execution | po_amendment | ✅ | ❌ | Excluded from MVM |
| purchase_execution | po_line | ✅ | ✅ |  |
| purchase_execution | procurement_bid | ✅ | ❌ | Excluded from MVM |
| purchase_execution | purchase_order | ✅ | ✅ |  |
| purchase_execution | purchase_requisition | ✅ | ✅ |  |
| purchase_execution | rfq | ✅ | ✅ |  |
| purchase_execution | rfq_line | ✅ | ❌ | Excluded from MVM |
| supplier_management | inspection_release | ✅ | ✅ |  |
| supplier_management | procurement_framework_agreement | ✅ | ❌ | Excluded from MVM |
| supplier_management | service | ✅ | ✅ |  |
| supplier_management | vendor | ✅ | ✅ |  |
| supplier_management | vendor_document | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_evaluation | ✅ | ✅ |  |
| supplier_management | vendor_invoice | ✅ | ✅ |  |
| supplier_management | vendor_qualification | ✅ | ✅ |  |
| supplier_management | vendor_quotation | ✅ | ✅ |  |

<a id="domain-project"></a>
### project

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| cost_control | cost_account | ✅ | ✅ |  |
| cost_control | evm_period_record | ✅ | ❌ | Excluded from MVM |
| cost_control | forecast | ✅ | ❌ | Excluded from MVM |
| cost_control | progress_measurement | ✅ | ✅ |  |
| cost_control | project_budget_revision | ✅ | ❌ | Excluded from MVM |
| cost_control | project_change_order | ✅ | ✅ |  |
| cost_control | reporting_period | ✅ | ❌ | Excluded from MVM |
| project_definition | project_site | ❌ | ✅ | MVM only (stub or new) |
| project_planning | commissioning_package | ✅ | ❌ | Excluded from MVM |
| project_planning | construction_project | ✅ | ✅ |  |
| project_planning | deliverable | ✅ | ✅ |  |
| project_planning | phase | ✅ | ✅ |  |
| project_planning | project_baseline | ✅ | ✅ |  |
| project_planning | project_milestone | ✅ | ✅ |  |
| project_planning | site | ✅ | ❌ | Excluded from MVM |
| project_planning | team_member | ✅ | ❌ | Excluded from MVM |
| project_planning | wbs_element | ✅ | ✅ |  |
| risk_management | handover_certificate | ✅ | ✅ |  |
| risk_management | regulatory_oversight | ✅ | ❌ | Excluded from MVM |
| risk_management | risk_register | ✅ | ✅ |  |

<a id="domain-quality"></a>
### quality

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| defect_control | plan | ❌ | ✅ | MVM only (stub or new) |
| quality_planning | itp | ✅ | ✅ |  |
| quality_planning | itp_line | ✅ | ✅ |  |
| quality_planning | quality_audit | ✅ | ❌ | Excluded from MVM |
| quality_planning | quality_plan | ✅ | ❌ | Excluded from MVM |
| quality_planning | quality_submittal | ✅ | ❌ | Excluded from MVM |
| site_inspection | checklist | ✅ | ✅ |  |
| site_inspection | checklist_execution | ✅ | ✅ |  |
| site_inspection | corrective_action | ✅ | ✅ |  |
| site_inspection | defect | ✅ | ✅ |  |
| site_inspection | inspection | ✅ | ✅ |  |
| site_inspection | ncr | ✅ | ✅ |  |
| site_inspection | punch_item | ✅ | ✅ |  |
| site_inspection | punch_list | ✅ | ✅ |  |
| test_records | acceptance_test | ✅ | ❌ | Excluded from MVM |
| test_records | concrete_pour_record | ✅ | ❌ | Excluded from MVM |
| test_records | lab_test | ✅ | ❌ | Excluded from MVM |
| test_records | laboratory | ✅ | ❌ | Excluded from MVM |
| test_records | ndt_record | ✅ | ❌ | Excluded from MVM |
| test_records | sample | ✅ | ❌ | Excluded from MVM |
| test_records | test_certificate | ✅ | ✅ |  |
| test_records | weld_record | ✅ | ❌ | Excluded from MVM |

<a id="domain-safety"></a>
### safety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_assurance | audit | ❌ | ✅ | MVM only (stub or new) |
| incident_management | environmental_monitoring | ✅ | ✅ |  |
| incident_management | hse_inspection | ✅ | ✅ |  |
| incident_management | incident | ✅ | ✅ |  |
| incident_management | incident_investigation | ✅ | ✅ |  |
| incident_management | incident_subcontractor_involvement | ✅ | ❌ | Excluded from MVM |
| incident_management | safety_audit | ✅ | ❌ | Excluded from MVM |
| incident_management | toolbox_meeting | ✅ | ✅ |  |
| safety_planning | chemical_register | ✅ | ❌ | Excluded from MVM |
| safety_planning | hazard_register | ✅ | ✅ |  |
| safety_planning | hse_plan | ✅ | ✅ |  |
| safety_planning | permit_to_work | ✅ | ✅ |  |
| safety_planning | ppe_register | ✅ | ❌ | Excluded from MVM |
| safety_planning | risk_assessment | ✅ | ✅ |  |
| safety_planning | swms | ✅ | ✅ |  |
| safety_planning | training | ✅ | ✅ |  |

<a id="domain-schedule"></a>
### schedule

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| activity_planning | lookahead_activity_commitment | ❌ | ✅ | MVM only (stub or new) |
| progress_monitoring | delay_event | ✅ | ✅ |  |
| progress_monitoring | lookahead_activity | ✅ | ❌ | Excluded from MVM |
| progress_monitoring | lookahead_plan | ✅ | ✅ |  |
| progress_monitoring | progress_update | ✅ | ✅ |  |
| progress_monitoring | schedule_eot_claim | ✅ | ❌ | Excluded from MVM |
| progress_monitoring | schedule_risk | ✅ | ❌ | Excluded from MVM |
| progress_tracking | activity_delay_impact | ❌ | ✅ | MVM only (stub or new) |
| resource_management | activity_resource_assignment | ✅ | ✅ |  |
| resource_management | resource | ✅ | ✅ |  |
| schedule_planning | activity | ✅ | ✅ |  |
| schedule_planning | activity_relationship | ✅ | ✅ |  |
| schedule_planning | baseline_activity | ✅ | ✅ |  |
| schedule_planning | schedule_baseline | ✅ | ✅ |  |
| schedule_planning | schedule_calendar | ✅ | ✅ |  |
| schedule_planning | schedule_milestone | ✅ | ✅ |  |
| schedule_planning | wbs_node | ✅ | ✅ |  |

<a id="domain-site"></a>
### site

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| construction_planning | concrete_pour | ✅ | ❌ | Excluded from MVM |
| construction_planning | earthwork_volume | ✅ | ❌ | Excluded from MVM |
| construction_planning | instruction | ✅ | ✅ |  |
| construction_planning | site_permit | ✅ | ❌ | Excluded from MVM |
| logistics_management | lift_plan | ✅ | ❌ | Excluded from MVM |
| logistics_management | logistics_plan | ✅ | ❌ | Excluded from MVM |
| logistics_management | material_delivery | ✅ | ✅ |  |
| site_management | site_site | ❌ | ✅ | MVM only (stub or new) |
| site_operations | crew_deployment | ✅ | ✅ |  |
| site_operations | daily_log | ✅ | ✅ |  |
| site_operations | equipment_deployment | ✅ | ✅ |  |
| site_operations | field_progress | ✅ | ✅ |  |
| site_operations | production_entry | ✅ | ✅ |  |
| site_operations | shift_report | ✅ | ✅ |  |
| site_operations | site | ✅ | ❌ | Excluded from MVM |
| site_operations | site_location | ✅ | ❌ | Excluded from MVM |
| site_operations | site_mobilization | ✅ | ✅ |  |
| site_operations | work_front | ✅ | ✅ |  |
| site_operations | work_front_assignment | ✅ | ❌ | Excluded from MVM |

<a id="domain-subcontractor"></a>
### subcontractor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_adjustments | back_charge | ✅ | ❌ | Domain not in MVM |
| contract_adjustments | subcontractor_change_order | ✅ | ❌ | Domain not in MVM |
| project_closure | final_account | ✅ | ❌ | Domain not in MVM |
| project_closure | subcontractor_eot_claim | ✅ | ❌ | Domain not in MVM |

<a id="domain-sustainability"></a>
### sustainability

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carbon_strategy | carbon_emission | ✅ | ❌ | Domain not in MVM |
| carbon_strategy | carbon_offset | ✅ | ❌ | Domain not in MVM |
| carbon_strategy | carbon_reduction_initiative | ✅ | ❌ | Domain not in MVM |
| carbon_strategy | carbon_target | ✅ | ❌ | Domain not in MVM |
| carbon_strategy | embodied_carbon_assessment | ✅ | ❌ | Domain not in MVM |
| carbon_strategy | emission_factor | ✅ | ❌ | Domain not in MVM |
| carbon_strategy | emission_source | ✅ | ❌ | Domain not in MVM |
| carbon_strategy | supply_chain_carbon | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | climate_risk_assessment | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | climate_risk_item | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | energy_consumption | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | env_incident | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | esg_disclosure_item | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | esg_report | ✅ | ❌ | Domain not in MVM |
| environmental_reporting | water_consumption | ✅ | ❌ | Domain not in MVM |
| sustainability_planning | biodiversity_assessment | ✅ | ❌ | Domain not in MVM |
| sustainability_planning | green_certification | ✅ | ❌ | Domain not in MVM |
| sustainability_planning | green_credit | ✅ | ❌ | Domain not in MVM |
| sustainability_planning | social_value_record | ✅ | ❌ | Domain not in MVM |
| sustainability_planning | sustainability_action | ✅ | ❌ | Domain not in MVM |
| sustainability_planning | sustainability_audit | ✅ | ❌ | Domain not in MVM |
| sustainability_planning | sustainability_plan | ✅ | ❌ | Domain not in MVM |
| sustainability_planning | sustainable_material | ✅ | ❌ | Domain not in MVM |
| waste_operations | disposal_facility | ✅ | ❌ | Domain not in MVM |
| waste_operations | waste_carrier | ✅ | ❌ | Domain not in MVM |
| waste_operations | waste_record | ✅ | ❌ | Domain not in MVM |
| waste_operations | waste_target | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| apprenticeship_development | apprenticeship_progression | ✅ | ❌ | Excluded from MVM |
| apprenticeship_development | carbon_reduction_participation | ✅ | ❌ | Excluded from MVM |
| apprenticeship_development | craft_worker | ✅ | ✅ |  |
| crew_management | crew | ✅ | ✅ |  |
| crew_management | crew_assignment | ✅ | ✅ |  |
| crew_management | labor_mobilization | ✅ | ✅ |  |
| crew_management | production_rate | ✅ | ❌ | Excluded from MVM |
| crew_management | site_access_record | ✅ | ❌ | Excluded from MVM |
| crew_management | timesheet | ✅ | ✅ |  |
| crew_management | timesheet_line | ✅ | ✅ |  |
| staffing_planning | trade_staffing_requirement | ❌ | ✅ | MVM only (stub or new) |
| workforce_planning | agency | ✅ | ❌ | Excluded from MVM |
| workforce_planning | agency_labor_order | ✅ | ❌ | Excluded from MVM |
| workforce_planning | craft_certification | ✅ | ✅ |  |
| workforce_planning | labor_agreement | ✅ | ❌ | Excluded from MVM |
| workforce_planning | labor_cost_code | ✅ | ✅ |  |
| workforce_planning | labor_rate | ✅ | ✅ |  |
| workforce_planning | skill_trade | ✅ | ✅ |  |
| workforce_planning | staffing_plan | ✅ | ✅ |  |
