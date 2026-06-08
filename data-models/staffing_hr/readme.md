# Staffing Hr Lakehouse Data Models

**Version 1** | Generated on May 02, 2026 at 10:45 PM

**Industry:** staffing-and-recruitment

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Billing](#domain-billing)
  - [Candidate](#domain-candidate)
  - [Client](#domain-client)
  - [Compliance](#domain-compliance)
  - [Contract](#domain-contract)
  - [Credentialing](#domain-credentialing)
  - [Employee](#domain-employee)
  - [Finance](#domain-finance)
  - [Joborder](#domain-joborder)
  - [Onboarding](#domain-onboarding)
  - [Payroll](#domain-payroll)
  - [Placement](#domain-placement)
  - [Recruitment](#domain-recruitment)
  - [Shared](#domain-shared)
  - [Timesheet](#domain-timesheet)
  - [Vendor](#domain-vendor)


## Business Description

Staffing and Human Resources is a workforce solutions industry providing temporary and permanent talent placement, recruitment process outsourcing, workforce management, and HR consulting services across all industries and skill levels.

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
| **Folder Convention** | `mvm_v1` | `ecm_v1` |
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
| Domains | 12 | 16 |
| Subdomains | 30 | 47 |
| Products (Tables) | 153 | 302 |
| Attributes (Columns) | 6932 | 11925 |
| Foreign Keys | 1568 | 2097 |
| Avg Attributes/Product | 45.3 | 39.5 |

## Domain & Product Comparison

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| payment_collections | dispute | ❌ | ✅ | MVM only (stub or new) |
| payment_processing | billing_dispute | ✅ | ❌ | Excluded from MVM |
| payment_processing | collection_activity | ✅ | ✅ |  |
| payment_processing | credit_memo | ✅ | ✅ |  |
| payment_processing | payment | ✅ | ✅ |  |
| payment_processing | payment_application | ✅ | ✅ |  |
| payment_processing | payment_plan | ✅ | ❌ | Excluded from MVM |
| payment_processing | write_off | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | bill_rate | ✅ | ✅ |  |
| revenue_recognition | billing_account | ✅ | ✅ |  |
| revenue_recognition | billing_rate_schedule | ✅ | ✅ |  |
| revenue_recognition | expense_charge | ✅ | ✅ |  |
| revenue_recognition | invoice | ✅ | ✅ |  |
| revenue_recognition | invoice_line | ✅ | ✅ |  |
| revenue_recognition | placement_fee | ✅ | ✅ |  |
| revenue_recognition | sow_billing_milestone | ✅ | ❌ | Excluded from MVM |
| revenue_recognition | spread_record | ✅ | ❌ | Excluded from MVM |

<a id="domain-candidate"></a>
### candidate

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| engagement_tracking | assessment | ✅ | ✅ |  |
| engagement_tracking | audit_sample | ✅ | ❌ | Excluded from MVM |
| engagement_tracking | candidate_compliance | ✅ | ❌ | Excluded from MVM |
| engagement_tracking | interaction | ✅ | ✅ |  |
| engagement_tracking | status_history | ✅ | ✅ |  |
| placement_readiness | availability | ✅ | ✅ |  |
| placement_readiness | pay_rate_agreement | ✅ | ✅ |  |
| placement_readiness | right_to_represent | ✅ | ✅ |  |
| placement_readiness | talent_pool | ✅ | ✅ |  |
| placement_readiness | talent_pool_membership | ✅ | ✅ |  |
| recruitment_engagement | orientation_session | ❌ | ✅ | In ECM under domain(s): onboarding |
| talent_identity | diversity_profile | ✅ | ❌ | Excluded from MVM |
| talent_identity | education | ✅ | ✅ |  |
| talent_identity | profile | ✅ | ✅ |  |
| talent_identity | resume | ✅ | ✅ |  |
| talent_identity | skill | ✅ | ✅ |  |
| talent_identity | work_history | ✅ | ✅ |  |

<a id="domain-client"></a>
### client

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_hierarchy | ✅ | ✅ |  |
| account_management | account_segment | ✅ | ✅ |  |
| account_management | client_account | ✅ | ✅ |  |
| account_management | client_contact | ✅ | ✅ |  |
| account_management | credit_profile | ✅ | ✅ |  |
| account_management | engagement | ❌ | ✅ | MVM only (stub or new) |
| account_management | location | ✅ | ✅ |  |
| account_management | opportunity | ✅ | ❌ | Excluded from MVM |
| account_management | territory | ✅ | ❌ | Excluded from MVM |
| program_operations | client_rate_card | ✅ | ✅ |  |
| program_operations | location_budget_allocation | ✅ | ❌ | Excluded from MVM |
| program_operations | managed_program | ✅ | ✅ |  |
| program_operations | program_compliance_requirement | ✅ | ❌ | Excluded from MVM |
| program_operations | program_credential_requirement | ✅ | ❌ | Excluded from MVM |
| program_operations | program_supplier | ✅ | ✅ |  |
| program_operations | rate_card_line | ✅ | ✅ |  |
| program_operations | vms_program | ✅ | ✅ |  |
| relationship_tracking | client_engagement | ✅ | ❌ | Excluded from MVM |
| relationship_tracking | nps_response | ✅ | ❌ | Excluded from MVM |
| relationship_tracking | sla_measurement | ✅ | ✅ |  |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| employment_eligibility | everify_case | ✅ | ✅ |  |
| employment_eligibility | i9_verification | ✅ | ✅ |  |
| employment_eligibility | onboarding_compliance_checkpoint | ✅ | ❌ | Excluded from MVM |
| employment_eligibility | placement_compliance_check | ✅ | ✅ |  |
| employment_eligibility | placement_requirement_check | ✅ | ❌ | Excluded from MVM |
| employment_eligibility | wage_hour_determination | ✅ | ✅ |  |
| employment_eligibility | worker_classification | ✅ | ✅ |  |
| regulatory_reporting | checklist_compliance_rule | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | eeoc_filing | ✅ | ✅ |  |
| regulatory_reporting | establishment | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | ofccp_compliance | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | privacy_request | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | regulatory_violation | ✅ | ✅ |  |
| regulatory_reporting | requirement | ✅ | ✅ |  |
| regulatory_reporting | staff_compliance_certification | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | state_compliance_rule | ✅ | ✅ |  |
| regulatory_reporting | state_credential_requirement | ✅ | ❌ | Excluded from MVM |
| regulatory_reporting | violation_breach | ✅ | ❌ | Excluded from MVM |
| risk_assessment | audit | ✅ | ✅ |  |
| risk_assessment | audit_finding | ✅ | ❌ | Excluded from MVM |
| risk_assessment | coe_risk_assessment | ✅ | ❌ | Excluded from MVM |
| workplace_safety | osha_incident | ✅ | ✅ |  |
| workplace_safety | workers_comp_policy | ✅ | ❌ | Excluded from MVM |

<a id="domain-contract"></a>
### contract

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| agreement_governance | amendment | ✅ | ✅ |  |
| agreement_governance | contract_document | ✅ | ❌ | Excluded from MVM |
| agreement_governance | contract_rate_schedule | ✅ | ✅ |  |
| agreement_governance | ic_agreement | ✅ | ✅ |  |
| agreement_governance | msa | ✅ | ✅ |  |
| agreement_governance | nda | ✅ | ✅ |  |
| agreement_governance | non_compete | ✅ | ❌ | Excluded from MVM |
| agreement_governance | sla | ✅ | ✅ |  |
| agreement_governance | sow | ✅ | ✅ |  |
| agreement_governance | template | ✅ | ✅ |  |
| agreement_governance | vendor_agreement | ✅ | ✅ |  |
| commercial_terms | document | ❌ | ✅ | MVM only (stub or new) |
| compliance_requirements | msa_credential_requirement | ✅ | ❌ | Excluded from MVM |
| compliance_requirements | sow_credential_requirement | ✅ | ❌ | Excluded from MVM |
| financial_allocation | allocation | ✅ | ❌ | Excluded from MVM |
| financial_allocation | vendor_cost_center_allocation | ✅ | ❌ | Excluded from MVM |
| lifecycle_management | contract_approval_workflow | ✅ | ❌ | Excluded from MVM |
| lifecycle_management | envelope | ✅ | ❌ | Excluded from MVM |
| lifecycle_management | obligation | ✅ | ❌ | Excluded from MVM |
| lifecycle_management | renewal | ✅ | ✅ |  |
| lifecycle_management | sla_breach_event | ✅ | ❌ | Excluded from MVM |

<a id="domain-credentialing"></a>
### credentialing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| qualification_management | checklist_credential_requirement | ✅ | ❌ | Excluded from MVM |
| qualification_management | credential | ✅ | ✅ |  |
| qualification_management | credential_document | ✅ | ✅ |  |
| qualification_management | credential_instance | ✅ | ✅ |  |
| qualification_management | credential_package | ✅ | ✅ |  |
| qualification_management | credential_requirement | ✅ | ✅ |  |
| qualification_management | credential_type | ✅ | ✅ |  |
| qualification_management | package_requirement | ✅ | ✅ |  |
| qualification_management | readiness_status | ✅ | ❌ | Excluded from MVM |
| qualification_management | service | ✅ | ❌ | Excluded from MVM |
| screening_verification | adverse_action | ✅ | ❌ | Excluded from MVM |
| screening_verification | bgc_order | ✅ | ✅ |  |
| screening_verification | bgc_result | ✅ | ✅ |  |
| screening_verification | drug_screen | ✅ | ✅ |  |
| screening_verification | education_verification | ✅ | ❌ | Excluded from MVM |
| screening_verification | employment_verification | ✅ | ❌ | Excluded from MVM |
| screening_verification | license_verification | ✅ | ✅ |  |
| screening_verification | reference_check | ✅ | ❌ | Excluded from MVM |
| training_assessment | skills_assessment | ✅ | ✅ |  |
| training_assessment | training_record | ✅ | ✅ |  |
| training_assessment | work_authorization | ✅ | ✅ |  |

<a id="domain-employee"></a>
### employee

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_incentives | accrual_policy | ✅ | ❌ | Domain not in MVM |
| compensation_incentives | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_incentives | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_incentives | commission_earning | ✅ | ❌ | Domain not in MVM |
| compensation_incentives | commission_plan | ✅ | ❌ | Domain not in MVM |
| compensation_incentives | compensation | ✅ | ❌ | Domain not in MVM |
| compensation_incentives | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_incentives | leave_request | ✅ | ❌ | Domain not in MVM |
| performance_development | development_plan | ✅ | ❌ | Domain not in MVM |
| performance_development | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| performance_development | performance_goal | ✅ | ❌ | Domain not in MVM |
| performance_development | performance_review | ✅ | ❌ | Domain not in MVM |
| performance_development | pip_record | ✅ | ❌ | Domain not in MVM |
| performance_development | review_period | ✅ | ❌ | Domain not in MVM |
| performance_development | survey | ✅ | ❌ | Domain not in MVM |
| territory_training | internal_training | ✅ | ❌ | Domain not in MVM |
| territory_training | job_role | ✅ | ❌ | Domain not in MVM |
| territory_training | recruiter_desk | ✅ | ❌ | Domain not in MVM |
| territory_training | territory | ✅ | ❌ | Domain not in MVM |
| territory_training | territory_assignment | ✅ | ❌ | Domain not in MVM |
| territory_training | training_completion | ✅ | ❌ | Domain not in MVM |
| workforce_administration | department | ✅ | ❌ | Domain not in MVM |
| workforce_administration | headcount_position | ✅ | ❌ | Domain not in MVM |
| workforce_administration | internal_requisition | ✅ | ❌ | Domain not in MVM |
| workforce_administration | job_title | ✅ | ❌ | Domain not in MVM |
| workforce_administration | office_location | ✅ | ❌ | Domain not in MVM |
| workforce_administration | org_change_event | ✅ | ❌ | Domain not in MVM |
| workforce_administration | role_assignment | ✅ | ❌ | Domain not in MVM |
| workforce_administration | staff_profile | ✅ | ❌ | Domain not in MVM |
| workforce_administration | team | ✅ | ❌ | Domain not in MVM |
| workforce_administration | team_membership | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| general_ledger | accounting_period | ✅ | ❌ | Domain not in MVM |
| general_ledger | accrual | ✅ | ❌ | Domain not in MVM |
| general_ledger | budget | ✅ | ❌ | Domain not in MVM |
| general_ledger | budget_allocation | ✅ | ❌ | Domain not in MVM |
| general_ledger | budget_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | business_unit | ✅ | ❌ | Domain not in MVM |
| general_ledger | cost_center | ✅ | ❌ | Domain not in MVM |
| general_ledger | fiscal_calendar | ✅ | ❌ | Domain not in MVM |
| general_ledger | gl_account | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_ledger | journal_entry_line | ✅ | ❌ | Domain not in MVM |
| general_ledger | legal_entity | ✅ | ❌ | Domain not in MVM |
| general_ledger | period_close_task | ✅ | ❌ | Domain not in MVM |
| subledger_operations | ap_account | ✅ | ❌ | Domain not in MVM |
| subledger_operations | ap_invoice | ✅ | ❌ | Domain not in MVM |
| subledger_operations | ap_payment | ✅ | ❌ | Domain not in MVM |
| subledger_operations | ar_account | ✅ | ❌ | Domain not in MVM |
| subledger_operations | ar_transaction | ✅ | ❌ | Domain not in MVM |
| subledger_operations | deferred_revenue | ✅ | ❌ | Domain not in MVM |
| subledger_operations | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| subledger_operations | payment_batch | ✅ | ❌ | Domain not in MVM |
| subledger_operations | purchase_order | ✅ | ❌ | Domain not in MVM |
| subledger_operations | requisition | ✅ | ❌ | Domain not in MVM |
| subledger_operations | revenue_recognition_event | ✅ | ❌ | Domain not in MVM |
| treasury_management | bank_account | ✅ | ❌ | Domain not in MVM |
| treasury_management | bank_reconciliation | ✅ | ❌ | Domain not in MVM |
| treasury_management | bank_transaction | ✅ | ❌ | Domain not in MVM |
| treasury_management | depreciation_schedule | ✅ | ❌ | Domain not in MVM |
| treasury_management | fixed_asset | ✅ | ❌ | Domain not in MVM |
| treasury_management | tax_liability | ✅ | ❌ | Domain not in MVM |

<a id="domain-joborder"></a>
### joborder

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| requisition_management | fulfillment_team | ✅ | ✅ |  |
| requisition_management | job_category | ✅ | ✅ |  |
| requisition_management | joborder_approval_workflow | ✅ | ❌ | Excluded from MVM |
| requisition_management | order_extension | ✅ | ✅ |  |
| requisition_management | order_header | ✅ | ✅ |  |
| requisition_management | order_location | ✅ | ✅ |  |
| requisition_management | order_modification | ✅ | ❌ | Excluded from MVM |
| requisition_management | order_status_history | ✅ | ✅ |  |
| requisition_management | position_requirement | ✅ | ✅ |  |
| requisition_management | rate_override | ✅ | ✅ |  |
| requisition_management | skill_requirement | ✅ | ✅ |  |
| requisition_management | sla_commitment | ✅ | ✅ |  |
| requisition_management | vms_order | ✅ | ✅ |  |
| workforce_compliance | tax_form_submission | ❌ | ✅ | In ECM under domain(s): onboarding |
| workforce_planning | capacity_plan | ✅ | ❌ | Excluded from MVM |
| workforce_planning | demand_forecast | ✅ | ❌ | Excluded from MVM |
| workforce_planning | fte_actuals | ✅ | ❌ | Excluded from MVM |
| workforce_planning | headcount_plan | ✅ | ✅ |  |

<a id="domain-onboarding"></a>
### onboarding

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_documentation | communication_log | ✅ | ❌ | Domain not in MVM |
| compliance_documentation | direct_deposit_setup | ✅ | ❌ | Domain not in MVM |
| compliance_documentation | document_collection | ✅ | ❌ | Domain not in MVM |
| compliance_documentation | tax_form_submission | ✅ | ❌ | Domain not in MVM |
| process_configuration | onboarding_sla_target | ✅ | ❌ | Domain not in MVM |
| process_configuration | requirement_rule | ✅ | ❌ | Domain not in MVM |
| process_configuration | task_assignment | ✅ | ❌ | Domain not in MVM |
| process_configuration | task_checklist | ✅ | ❌ | Domain not in MVM |
| training_enablement | equipment_provisioning | ✅ | ❌ | Domain not in MVM |
| training_enablement | lms_course | ✅ | ❌ | Domain not in MVM |
| training_enablement | lms_enrollment | ✅ | ❌ | Domain not in MVM |
| training_enablement | orientation_attendance | ✅ | ❌ | Domain not in MVM |
| training_enablement | orientation_session | ✅ | ❌ | Domain not in MVM |
| worker_lifecycle | offboarding_record | ✅ | ❌ | Domain not in MVM |
| worker_lifecycle | onboarding_engagement | ✅ | ❌ | Domain not in MVM |
| worker_lifecycle | status_event | ✅ | ❌ | Domain not in MVM |

<a id="domain-payroll"></a>
### payroll

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| benefit_administration | arrangement_compliance_requirement | ✅ | ❌ | Excluded from MVM |
| benefit_administration | eor_arrangement | ✅ | ❌ | Excluded from MVM |
| benefit_administration | pay_stub_compliance_validation | ✅ | ❌ | Excluded from MVM |
| benefit_administration | pto_accrual | ✅ | ❌ | Excluded from MVM |
| benefit_administration | pto_policy | ✅ | ❌ | Excluded from MVM |
| deduction_management | burden_rate | ✅ | ✅ |  |
| deduction_management | deduction_line | ✅ | ✅ |  |
| deduction_management | garnishment_order | ✅ | ❌ | Excluded from MVM |
| deduction_management | wc_policy | ✅ | ✅ |  |
| payment_processing | earnings_line | ✅ | ✅ |  |
| payment_processing | pay_adjustment | ✅ | ❌ | Excluded from MVM |
| payment_processing | pay_rate | ✅ | ✅ |  |
| payment_processing | pay_run | ✅ | ✅ |  |
| payment_processing | pay_stub | ✅ | ✅ |  |
| tax_compliance | tax_filing | ✅ | ✅ |  |
| tax_compliance | tax_form | ✅ | ✅ |  |
| tax_compliance | tax_line | ✅ | ✅ |  |
| tax_compliance | tax_withholding_election | ✅ | ✅ |  |
| worker_onboarding | document_collection | ❌ | ✅ | In ECM under domain(s): onboarding |
| worker_onboarding | task_checklist | ❌ | ✅ | In ECM under domain(s): onboarding |

<a id="domain-placement"></a>
### placement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| regulatory_adherence | assignment_compliance | ✅ | ✅ |  |
| regulatory_adherence | assignment_credential_compliance | ✅ | ❌ | Excluded from MVM |
| regulatory_adherence | assignment_sla_measurement | ✅ | ❌ | Excluded from MVM |
| regulatory_adherence | location_compliance_mandate | ✅ | ❌ | Excluded from MVM |
| regulatory_adherence | location_credential_requirement | ✅ | ❌ | Excluded from MVM |
| shift_operations | dispatch_order | ✅ | ❌ | Excluded from MVM |
| shift_operations | schedule_exception | ✅ | ❌ | Excluded from MVM |
| shift_operations | shift_template | ✅ | ❌ | Excluded from MVM |
| shift_operations | worker_schedule | ✅ | ❌ | Excluded from MVM |
| worker_engagement | assignment | ✅ | ✅ |  |
| worker_engagement | assignment_extension | ✅ | ✅ |  |
| worker_engagement | assignment_status_history | ✅ | ✅ |  |
| worker_engagement | backfill | ✅ | ❌ | Excluded from MVM |
| worker_engagement | bench_roster | ✅ | ❌ | Excluded from MVM |
| worker_engagement | conversion | ✅ | ✅ |  |
| worker_engagement | direct_hire | ✅ | ✅ |  |
| worker_engagement | fall_off | ✅ | ✅ |  |
| worker_engagement | offer | ✅ | ✅ |  |
| worker_engagement | per_diem | ✅ | ❌ | Excluded from MVM |
| worker_engagement | rate | ✅ | ✅ |  |
| worker_engagement | redeployment | ✅ | ✅ |  |
| worker_engagement | sow_engagement | ✅ | ✅ |  |
| worker_engagement | supervisor | ✅ | ✅ |  |
| worker_engagement | work_location | ✅ | ✅ |  |

<a id="domain-recruitment"></a>
### recruitment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| candidate_placement | candidate_screening | ✅ | ✅ |  |
| candidate_placement | hiring_decision | ✅ | ✅ |  |
| candidate_placement | interview | ✅ | ✅ |  |
| candidate_placement | interview_feedback | ✅ | ✅ |  |
| candidate_placement | recruiter_assignment | ✅ | ✅ |  |
| candidate_placement | req_pipeline | ✅ | ✅ |  |
| candidate_placement | rtr_agreement | ✅ | ✅ |  |
| candidate_placement | submittal | ✅ | ✅ |  |
| candidate_placement | submittal_compliance_check | ✅ | ❌ | Excluded from MVM |
| onboarding_management | onboarding_engagement | ❌ | ✅ | In ECM under domain(s): onboarding |
| onboarding_management | status_event | ❌ | ✅ | In ECM under domain(s): onboarding |
| onboarding_management | task_assignment | ❌ | ✅ | In ECM under domain(s): onboarding |
| performance_management | recruitment_sla_target | ✅ | ❌ | Excluded from MVM |
| performance_management | sla_breach | ✅ | ❌ | Excluded from MVM |
| talent_sourcing | job_board_integration | ✅ | ❌ | Excluded from MVM |
| talent_sourcing | job_posting | ✅ | ✅ |  |
| talent_sourcing | referral | ✅ | ✅ |  |
| talent_sourcing | sourcing_activity | ✅ | ❌ | Excluded from MVM |
| talent_sourcing | sourcing_campaign | ✅ | ✅ |  |

<a id="domain-shared"></a>
### shared

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
|  | holiday_calendar | ✅ | ❌ | Domain not in MVM |

<a id="domain-timesheet"></a>
### timesheet

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| approval_processing | adjustment | ✅ | ✅ |  |
| approval_processing | approved_hours_summary | ✅ | ✅ |  |
| approval_processing | timesheet_approval_workflow | ✅ | ❌ | Excluded from MVM |
| approval_processing | timesheet_dispute | ✅ | ❌ | Excluded from MVM |
| approval_processing | vms_timesheet_sync | ✅ | ❌ | Excluded from MVM |
| time_recording | punch_event | ✅ | ❌ | Excluded from MVM |
| time_recording | schedule | ✅ | ✅ |  |
| time_recording | shift | ✅ | ✅ |  |
| time_recording | time_entry | ✅ | ✅ |  |
| time_recording | timesheet | ✅ | ✅ |  |
| time_tracking | approval_workflow | ❌ | ✅ | MVM only (stub or new) |
| worker_compensation | absence_record | ✅ | ✅ |  |
| worker_compensation | labor_category | ✅ | ✅ |  |
| worker_compensation | ot_rule | ✅ | ✅ |  |
| worker_compensation | pay_period | ✅ | ✅ |  |
| worker_compensation | per_diem_claim | ✅ | ❌ | Excluded from MVM |
| worker_onboarding | direct_deposit_setup | ❌ | ✅ | In ECM under domain(s): onboarding |
| worker_onboarding | offboarding_record | ❌ | ✅ | In ECM under domain(s): onboarding |

<a id="domain-vendor"></a>
### vendor

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| contract_performance | performance_scorecard | ✅ | ✅ |  |
| contract_performance | program_allocation | ✅ | ✅ |  |
| contract_performance | rate_agreement | ✅ | ✅ |  |
| contract_performance | sow_agreement | ✅ | ✅ |  |
| regulatory_compliance | diversity_certification | ✅ | ✅ |  |
| regulatory_compliance | supplier_checklist_assignment | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | supplier_compliance_obligation | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | supplier_orientation_attendance | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | supplier_package_qualification | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | vendor_compliance | ✅ | ✅ |  |
| supplier_management | desk_supplier_allocation | ✅ | ❌ | Excluded from MVM |
| supplier_management | exclusion | ✅ | ❌ | Excluded from MVM |
| supplier_management | preferred_supplier_list | ✅ | ✅ |  |
| supplier_management | supplier | ✅ | ✅ |  |
| supplier_management | tier_classification | ✅ | ✅ |  |
| supplier_management | vendor_contact | ✅ | ✅ |  |
| supplier_management | vendor_document | ✅ | ❌ | Excluded from MVM |
| supplier_management | vendor_rate_card | ✅ | ✅ |  |
| supplier_management | vms_enrollment | ✅ | ✅ |  |
