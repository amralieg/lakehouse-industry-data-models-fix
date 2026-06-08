# Education Lakehouse Data Models

**Version 1** | Generated on May 06, 2026 at 03:13 PM

**Industry:** higher-education

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Advancement](#domain-advancement)
  - [Aid](#domain-aid)
  - [Athletics](#domain-athletics)
  - [Billing](#domain-billing)
  - [Compliance](#domain-compliance)
  - [Curriculum](#domain-curriculum)
  - [Enrollment](#domain-enrollment)
  - [Facility](#domain-facility)
  - [Faculty](#domain-faculty)
  - [Finance](#domain-finance)
  - [Hr](#domain-hr)
  - [Instruction](#domain-instruction)
  - [Library](#domain-library)
  - [Research](#domain-research)
  - [Student](#domain-student)
  - [Studentlife](#domain-studentlife)
  - [Technology](#domain-technology)


## Business Description

Education is a foundational industry spanning universities, colleges, and research institutions that deliver undergraduate, graduate, and professional programs across the arts, sciences, engineering, and business disciplines.

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
| Domains | 14 | 17 |
| Subdomains | 38 | 56 |
| Products (Tables) | 203 | 446 |
| Attributes (Columns) | 8251 | 17010 |
| Foreign Keys | 1507 | 2337 |
| Avg Attributes/Product | 40.6 | 38.1 |

## Domain & Product Comparison

<a id="domain-advancement"></a>
### advancement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| alumni_relations | advanced_degree | ✅ | ❌ | Excluded from MVM |
| alumni_relations | advancement_application_access | ✅ | ❌ | Excluded from MVM |
| alumni_relations | advancement_assignment | ✅ | ❌ | Excluded from MVM |
| alumni_relations | advancement_registration | ✅ | ❌ | Excluded from MVM |
| alumni_relations | affinity_group | ✅ | ❌ | Excluded from MVM |
| alumni_relations | alumni_award | ✅ | ❌ | Excluded from MVM |
| alumni_relations | alumni_communication_preference | ✅ | ❌ | Excluded from MVM |
| alumni_relations | alumni_contact | ✅ | ✅ |  |
| alumni_relations | alumni_event | ✅ | ✅ |  |
| alumni_relations | alumni_event_registration | ✅ | ✅ |  |
| alumni_relations | alumni_survey | ✅ | ❌ | Excluded from MVM |
| alumni_relations | alumnus | ✅ | ✅ |  |
| alumni_relations | award_catalog | ✅ | ❌ | Excluded from MVM |
| alumni_relations | award_recipient | ✅ | ❌ | Excluded from MVM |
| alumni_relations | career_record | ✅ | ❌ | Excluded from MVM |
| alumni_relations | engagement_activity | ✅ | ✅ |  |
| alumni_relations | group_membership | ✅ | ❌ | Excluded from MVM |
| alumni_relations | lifelong_learning_enrollment | ✅ | ❌ | Excluded from MVM |
| alumni_relations | mentorship_match | ✅ | ❌ | Excluded from MVM |
| alumni_relations | mentorship_program | ✅ | ❌ | Excluded from MVM |
| alumni_relations | outreach_communication | ✅ | ❌ | Excluded from MVM |
| alumni_relations | survey_response | ✅ | ❌ | Excluded from MVM |
| alumni_relations | volunteer_assignment | ✅ | ❌ | Excluded from MVM |
| alumni_relations | volunteer_role | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | advancement_fund | ✅ | ✅ |  |
| fundraising_operations | appeal | ✅ | ✅ |  |
| fundraising_operations | campaign | ✅ | ✅ |  |
| fundraising_operations | campaign_volunteer | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | constituent | ✅ | ✅ |  |
| fundraising_operations | corporate_sponsorship | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | donor | ✅ | ✅ |  |
| fundraising_operations | endowment | ✅ | ✅ |  |
| fundraising_operations | event | ✅ | ✅ |  |
| fundraising_operations | gift | ✅ | ✅ |  |
| fundraising_operations | gift_agreement | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | major_gift_proposal | ✅ | ✅ |  |
| fundraising_operations | matching_gift_claim | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | organization | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | planned_gift | ✅ | ✅ |  |
| fundraising_operations | pledge | ✅ | ✅ |  |
| fundraising_operations | prospect_rating | ✅ | ✅ |  |
| fundraising_operations | recognition_society | ✅ | ❌ | Excluded from MVM |
| fundraising_operations | stewardship_action | ✅ | ✅ |  |
| fundraising_operations | stewardship_plan | ✅ | ❌ | Excluded from MVM |

<a id="domain-aid"></a>
### aid

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| application_eligibility | sap_evaluation | ❌ | ✅ | MVM only (stub or new) |
| application_processing | aid_application | ✅ | ✅ |  |
| application_processing | aid_sap_evaluation | ✅ | ❌ | Excluded from MVM |
| application_processing | award_year | ✅ | ✅ |  |
| application_processing | coa_budget | ✅ | ✅ |  |
| application_processing | isir_record | ✅ | ✅ |  |
| application_processing | professional_judgment | ✅ | ❌ | Excluded from MVM |
| application_processing | verification | ✅ | ✅ |  |
| award_management | aid_award | ✅ | ✅ |  |
| award_management | aid_fund | ✅ | ✅ |  |
| award_management | award_package | ✅ | ✅ |  |
| award_management | fund_fee_coverage | ✅ | ❌ | Excluded from MVM |
| award_management | scholarship | ✅ | ✅ |  |
| award_management | veteran_benefit | ✅ | ✅ |  |
| award_management | workstudy_assignment | ✅ | ❌ | Excluded from MVM |
| disbursement_operations | disbursement | ✅ | ✅ |  |
| disbursement_operations | r2t4_calculation | ✅ | ❌ | Excluded from MVM |
| loan_administration | borrower | ✅ | ❌ | Excluded from MVM |
| loan_administration | lender | ✅ | ❌ | Excluded from MVM |
| loan_administration | loan_record | ✅ | ✅ |  |
| loan_administration | master_promissory_note | ✅ | ❌ | Excluded from MVM |

<a id="domain-athletics"></a>
### athletics

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| eligibility_compliance | athletic_eligibility | ✅ | ❌ | Domain not in MVM |
| eligibility_compliance | compliance_waiver | ✅ | ❌ | Domain not in MVM |
| eligibility_compliance | drug_test | ✅ | ❌ | Domain not in MVM |
| eligibility_compliance | eada_report | ✅ | ❌ | Domain not in MVM |
| eligibility_compliance | eligibility_certification | ✅ | ❌ | Domain not in MVM |
| eligibility_compliance | secondary_violation | ✅ | ❌ | Domain not in MVM |
| financial_awards | athletic_award | ✅ | ❌ | Domain not in MVM |
| financial_awards | athletic_scholarship | ✅ | ❌ | Domain not in MVM |
| financial_awards | booster | ✅ | ❌ | Domain not in MVM |
| financial_awards | nil_activity | ✅ | ❌ | Domain not in MVM |
| recruitment_management | nli | ✅ | ❌ | Domain not in MVM |
| recruitment_management | official_visit | ✅ | ❌ | Domain not in MVM |
| recruitment_management | recruit | ✅ | ❌ | Domain not in MVM |
| recruitment_management | recruiting_contact | ✅ | ❌ | Domain not in MVM |
| team_operations | athletic_facility | ✅ | ❌ | Domain not in MVM |
| team_operations | coach | ✅ | ❌ | Domain not in MVM |
| team_operations | facility_event_booking | ✅ | ❌ | Domain not in MVM |
| team_operations | game | ✅ | ❌ | Domain not in MVM |
| team_operations | game_participation | ✅ | ❌ | Domain not in MVM |
| team_operations | practice_session | ✅ | ❌ | Domain not in MVM |
| team_operations | roster | ✅ | ❌ | Domain not in MVM |
| team_operations | sport | ✅ | ❌ | Domain not in MVM |
| team_operations | sports_medicine_case | ✅ | ❌ | Domain not in MVM |
| team_operations | student_athlete | ✅ | ❌ | Domain not in MVM |
| team_operations | team | ✅ | ❌ | Domain not in MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account_hold | ✅ | ✅ |  |
| account_management | charge_adjustment | ✅ | ❌ | Excluded from MVM |
| account_management | fee_schedule | ✅ | ✅ |  |
| account_management | late_fee | ✅ | ❌ | Excluded from MVM |
| account_management | statement | ✅ | ✅ |  |
| account_management | student_account | ✅ | ✅ |  |
| account_management | tuition_charge | ✅ | ✅ |  |
| payment_processing | cashier_session | ✅ | ❌ | Excluded from MVM |
| payment_processing | payment | ✅ | ✅ |  |
| payment_processing | payment_plan | ✅ | ✅ |  |
| payment_processing | payment_plan_installment | ✅ | ✅ |  |
| payment_processing | refund | ✅ | ✅ |  |
| sponsor_billing | collections_case | ✅ | ❌ | Excluded from MVM |
| sponsor_billing | sponsor_invoice | ✅ | ❌ | Excluded from MVM |
| sponsor_billing | tax_form_1098t | ✅ | ✅ |  |
| sponsor_billing | third_party_contract | ✅ | ✅ |  |
| sponsorship_billing | sponsorship_authorization | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accreditation_standards | accreditation_review | ✅ | ✅ |  |
| accreditation_standards | accreditation_standard | ✅ | ✅ |  |
| accreditation_standards | accrediting_body | ✅ | ✅ |  |
| accreditation_standards | standard_requirement_mapping | ✅ | ❌ | Excluded from MVM |
| audit_monitoring | audit | ✅ | ✅ |  |
| audit_monitoring | audit_finding | ✅ | ❌ | Excluded from MVM |
| audit_monitoring | corrective_action | ✅ | ❌ | Excluded from MVM |
| audit_monitoring | internal_review | ✅ | ❌ | Excluded from MVM |
| audit_monitoring | risk_assessment | ✅ | ✅ |  |
| incident_management | ada_accommodation | ✅ | ❌ | Excluded from MVM |
| incident_management | certificate_template | ✅ | ❌ | Excluded from MVM |
| incident_management | clery_incident | ✅ | ✅ |  |
| incident_management | compliance_training_completion | ✅ | ❌ | Excluded from MVM |
| incident_management | ferpa_disclosure | ✅ | ✅ |  |
| incident_management | title_ix_case | ✅ | ✅ |  |
| incident_management | training_program | ✅ | ✅ |  |
| regulatory_oversight | ipeds_submission | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | obligation | ✅ | ✅ |  |
| regulatory_oversight | policy | ✅ | ✅ |  |
| regulatory_oversight | policy_implementation | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | policy_version | ✅ | ❌ | Excluded from MVM |
| regulatory_oversight | regulatory_filing | ✅ | ✅ |  |
| regulatory_oversight | regulatory_requirement | ✅ | ✅ |  |
| regulatory_oversight | state_authorization | ✅ | ❌ | Excluded from MVM |

<a id="domain-curriculum"></a>
### curriculum

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| course_delivery | requirement_course_rule | ❌ | ✅ | MVM only (stub or new) |
| governance_workflow | articulation_agreement | ✅ | ✅ |  |
| governance_workflow | assessment_cycle | ✅ | ❌ | Excluded from MVM |
| governance_workflow | assessment_instrument | ✅ | ❌ | Excluded from MVM |
| governance_workflow | competency_framework | ✅ | ❌ | Excluded from MVM |
| governance_workflow | course_proposal | ✅ | ❌ | Excluded from MVM |
| governance_workflow | program_accreditation | ✅ | ✅ |  |
| governance_workflow | program_proposal | ✅ | ❌ | Excluded from MVM |
| governance_workflow | transfer_equivalency | ✅ | ✅ |  |
| program_design | academic_program | ✅ | ✅ |  |
| program_design | cip_code | ✅ | ✅ |  |
| program_design | concentration | ✅ | ✅ |  |
| program_design | course | ✅ | ✅ |  |
| program_design | degree_requirement | ✅ | ✅ |  |
| program_design | map | ✅ | ✅ |  |
| program_design | plo | ✅ | ✅ |  |
| program_design | prerequisite_rule | ✅ | ✅ |  |
| program_design | slo | ✅ | ✅ |  |
| teaching_operations | course_asset_requirement | ✅ | ❌ | Excluded from MVM |
| teaching_operations | course_training_requirement | ✅ | ❌ | Excluded from MVM |
| teaching_operations | curriculum_enrollment | ✅ | ❌ | Excluded from MVM |
| teaching_operations | institution | ✅ | ✅ | Also in domain(s): enrollment |
| teaching_operations | prerequisite_group | ✅ | ❌ | Excluded from MVM |
| teaching_operations | program_affiliation | ✅ | ❌ | Excluded from MVM |
| teaching_operations | section | ✅ | ✅ |  |
| teaching_operations | teaching_assignment | ✅ | ✅ |  |

<a id="domain-enrollment"></a>
### enrollment

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| admissions_pipeline | admission_criteria | ✅ | ✅ |  |
| admissions_pipeline | admission_decision | ✅ | ✅ |  |
| admissions_pipeline | admission_offer | ✅ | ✅ |  |
| admissions_pipeline | application_checklist | ✅ | ❌ | Excluded from MVM |
| admissions_pipeline | application_program | ✅ | ✅ |  |
| admissions_pipeline | application_review | ✅ | ❌ | Excluded from MVM |
| admissions_pipeline | athletic_recruitment | ✅ | ❌ | Excluded from MVM |
| admissions_pipeline | communication_activity | ✅ | ❌ | Excluded from MVM |
| admissions_pipeline | deposit | ✅ | ✅ |  |
| admissions_pipeline | enrollment_applicant | ✅ | ✅ |  |
| admissions_pipeline | enrollment_application | ✅ | ✅ |  |
| admissions_pipeline | enrollment_test_score | ✅ | ✅ |  |
| admissions_pipeline | event_registration | ✅ | ✅ |  |
| admissions_pipeline | institution | ✅ | ❌ | Excluded from MVM |
| admissions_pipeline | international_credential | ✅ | ❌ | Excluded from MVM |
| admissions_pipeline | matriculation | ✅ | ✅ |  |
| admissions_pipeline | prospect | ✅ | ✅ |  |
| admissions_pipeline | recommendation | ✅ | ❌ | Excluded from MVM |
| admissions_pipeline | recruitment_event | ✅ | ✅ |  |
| admissions_pipeline | recruitment_event_session | ✅ | ❌ | Excluded from MVM |
| admissions_pipeline | recruitment_territory | ✅ | ❌ | Excluded from MVM |
| admissions_pipeline | review_committee | ✅ | ❌ | Excluded from MVM |
| admissions_pipeline | transcript | ✅ | ✅ |  |
| admissions_pipeline | transfer_credit_eval | ✅ | ✅ |  |
| admissions_pipeline | waitlist | ✅ | ✅ |  |
| course_registration | add_drop_transaction | ✅ | ✅ |  |
| course_registration | census | ✅ | ❌ | Excluded from MVM |
| course_registration | concurrent_enrollment | ✅ | ❌ | Excluded from MVM |
| course_registration | cross_list_group | ✅ | ❌ | Excluded from MVM |
| course_registration | enrollment_registration | ✅ | ❌ | Excluded from MVM |
| course_registration | registration_hold | ✅ | ✅ |  |
| course_registration | registration_override | ✅ | ❌ | Excluded from MVM |
| course_registration | registration_period | ✅ | ❌ | Excluded from MVM |
| course_registration | repeat_course_record | ✅ | ❌ | Excluded from MVM |
| course_registration | restriction | ✅ | ❌ | Excluded from MVM |
| course_registration | student_term_record | ✅ | ✅ |  |
| course_registration | term | ✅ | ✅ |  |
| course_registration | waitlist_entry | ✅ | ❌ | Excluded from MVM |
| student_matriculation | registration | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-facility"></a>
### facility

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_operations | asset | ✅ | ✅ |  |
| asset_operations | asset_compliance | ✅ | ❌ | Excluded from MVM |
| asset_operations | crew | ✅ | ❌ | Excluded from MVM |
| asset_operations | inspection | ✅ | ❌ | Excluded from MVM |
| asset_operations | pm_schedule | ✅ | ✅ |  |
| asset_operations | work_order | ✅ | ✅ |  |
| asset_operations | work_order_template | ✅ | ❌ | Excluded from MVM |
| environmental_compliance | hazmat_inventory | ✅ | ❌ | Excluded from MVM |
| environmental_compliance | survey_period | ✅ | ❌ | Excluded from MVM |
| environmental_compliance | utility_meter | ✅ | ❌ | Excluded from MVM |
| project_funding | capital_project | ✅ | ✅ |  |
| project_funding | project_funding | ✅ | ❌ | Excluded from MVM |
| space_management | accessibility_feature | ✅ | ❌ | Excluded from MVM |
| space_management | building | ✅ | ✅ |  |
| space_management | campus | ✅ | ✅ |  |
| space_management | floor | ✅ | ✅ |  |
| space_management | lease_agreement | ✅ | ❌ | Excluded from MVM |
| space_management | room | ✅ | ✅ |  |
| space_management | room_booking | ✅ | ✅ |  |
| space_management | space_assignment | ✅ | ✅ |  |
| space_management | space_utilization_survey | ✅ | ❌ | Excluded from MVM |

<a id="domain-faculty"></a>
### faculty

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| academic_responsibilities | accreditation_qualification | ✅ | ✅ |  |
| academic_responsibilities | advising_assignment | ✅ | ✅ |  |
| academic_responsibilities | annual_review | ✅ | ✅ |  |
| academic_responsibilities | external_engagement | ✅ | ❌ | Excluded from MVM |
| academic_responsibilities | faculty_training_completion | ✅ | ❌ | Excluded from MVM |
| academic_responsibilities | leave_record | ✅ | ✅ |  |
| academic_responsibilities | professional_development | ✅ | ❌ | Excluded from MVM |
| academic_responsibilities | sabbatical | ✅ | ❌ | Excluded from MVM |
| academic_responsibilities | scholarly_activity | ✅ | ❌ | Excluded from MVM |
| academic_responsibilities | service_assignment | ✅ | ❌ | Excluded from MVM |
| academic_responsibilities | teaching_load | ✅ | ✅ |  |
| external_relations | event_participation | ✅ | ❌ | Excluded from MVM |
| external_relations | faculty_application_access | ✅ | ❌ | Excluded from MVM |
| external_relations | project_participation | ✅ | ❌ | Excluded from MVM |
| external_relations | resource_evaluation | ✅ | ❌ | Excluded from MVM |
| personnel_management | appointment | ✅ | ✅ |  |
| personnel_management | compensation | ✅ | ✅ |  |
| personnel_management | credential | ✅ | ✅ |  |
| personnel_management | department_affiliation | ✅ | ✅ |  |
| personnel_management | endowed_position | ✅ | ❌ | Excluded from MVM |
| personnel_management | hire_event | ✅ | ✅ |  |
| personnel_management | instructor | ✅ | ✅ |  |
| personnel_management | rank_history | ✅ | ✅ |  |
| personnel_management | tenure_case | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| general_ledger | bank_account | ✅ | ✅ |  |
| general_ledger | budget | ✅ | ✅ |  |
| general_ledger | budget_amendment | ✅ | ❌ | Excluded from MVM |
| general_ledger | business_unit | ✅ | ❌ | Excluded from MVM |
| general_ledger | college_school | ✅ | ❌ | Excluded from MVM |
| general_ledger | cost_center | ✅ | ✅ |  |
| general_ledger | division | ✅ | ❌ | Excluded from MVM |
| general_ledger | finance_fund | ✅ | ✅ |  |
| general_ledger | fiscal_period | ✅ | ✅ |  |
| general_ledger | fixed_asset | ✅ | ✅ |  |
| general_ledger | investment_pool | ✅ | ❌ | Excluded from MVM |
| general_ledger | journal_batch | ✅ | ❌ | Excluded from MVM |
| general_ledger | journal_entry | ✅ | ✅ |  |
| general_ledger | journal_line | ✅ | ✅ |  |
| general_ledger | ledger | ✅ | ❌ | Excluded from MVM |
| general_ledger | ledger_account | ✅ | ✅ |  |
| general_ledger | program | ✅ | ❌ | Excluded from MVM |
| general_ledger | recurring_schedule | ✅ | ❌ | Excluded from MVM |
| payables_procurement | ap_payment_application | ❌ | ✅ | MVM only (stub or new) |
| payables_procurement | vendor | ❌ | ✅ | MVM only (stub or new) |
| procurement_payables | ap_invoice | ✅ | ✅ |  |
| procurement_payables | ap_payment | ✅ | ✅ |  |
| procurement_payables | finance_vendor | ✅ | ❌ | Excluded from MVM |
| procurement_payables | payment_batch | ✅ | ❌ | Excluded from MVM |
| procurement_payables | purchase_order | ✅ | ✅ |  |
| procurement_payables | purchase_order_line | ✅ | ✅ |  |
| receivables_banking | ar_receipt_application | ❌ | ✅ | MVM only (stub or new) |
| revenue_receivables | ar_invoice | ✅ | ✅ |  |
| revenue_receivables | ar_receipt | ✅ | ✅ |  |
| revenue_receivables | customer | ✅ | ❌ | Excluded from MVM |
| sponsored_research | endowment_distribution | ✅ | ❌ | Excluded from MVM |
| sponsored_research | grant_account | ✅ | ✅ |  |
| sponsored_research | grant_expenditure | ✅ | ❌ | Excluded from MVM |
| sponsored_research | space_allocation | ✅ | ❌ | Excluded from MVM |

<a id="domain-hr"></a>
### hr

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_payroll | absence_event | ✅ | ✅ |  |
| compensation_payroll | accrual_plan | ✅ | ❌ | Excluded from MVM |
| compensation_payroll | benefit_enrollment | ✅ | ✅ |  |
| compensation_payroll | benefit_plan | ✅ | ✅ |  |
| compensation_payroll | benefit_program | ✅ | ❌ | Excluded from MVM |
| compensation_payroll | compensation_plan | ✅ | ❌ | Excluded from MVM |
| compensation_payroll | employee_compensation | ✅ | ✅ |  |
| compensation_payroll | pay_grade | ✅ | ❌ | Excluded from MVM |
| compensation_payroll | pay_period | ✅ | ❌ | Excluded from MVM |
| compensation_payroll | payroll_calendar | ✅ | ❌ | Excluded from MVM |
| compensation_payroll | payroll_result | ✅ | ✅ |  |
| compensation_payroll | payroll_run | ✅ | ❌ | Excluded from MVM |
| talent_acquisition | competency_framework | ✅ | ❌ | Excluded from MVM |
| talent_acquisition | grievance | ✅ | ❌ | Excluded from MVM |
| talent_acquisition | hr_applicant | ✅ | ✅ |  |
| talent_acquisition | onboarding_task | ✅ | ❌ | Excluded from MVM |
| talent_acquisition | performance_review | ✅ | ✅ |  |
| talent_acquisition | recruitment_requisition | ✅ | ✅ |  |
| talent_acquisition | time_entry | ✅ | ✅ |  |
| talent_acquisition | training_record | ✅ | ❌ | Excluded from MVM |
| workforce_administration | employee | ✅ | ✅ |  |
| workforce_administration | job_family | ✅ | ❌ | Excluded from MVM |
| workforce_administration | job_profile | ✅ | ✅ |  |
| workforce_administration | org_unit | ✅ | ✅ |  |
| workforce_administration | position | ✅ | ✅ |  |
| workforce_administration | staffing_event | ✅ | ✅ |  |

<a id="domain-instruction"></a>
### instruction

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| academic_performance | attendance_record | ✅ | ✅ |  |
| academic_performance | final_grade | ✅ | ✅ |  |
| academic_performance | grade_appeal_case | ✅ | ❌ | Excluded from MVM |
| academic_performance | grade_change_log | ✅ | ❌ | Excluded from MVM |
| academic_performance | grade_entry | ✅ | ✅ |  |
| academic_performance | instruction_early_alert | ✅ | ❌ | Excluded from MVM |
| academic_performance | instruction_submission | ✅ | ❌ | Excluded from MVM |
| academic_performance | slo_assessment | ✅ | ✅ |  |
| assessment_grading | assignment | ❌ | ✅ | MVM only (stub or new) |
| assessment_grading | submission | ❌ | ✅ | MVM only (stub or new) |
| course_delivery | course_section | ✅ | ✅ |  |
| course_delivery | faculty_assignment | ✅ | ✅ |  |
| course_delivery | faculty_training_requirement | ✅ | ❌ | Excluded from MVM |
| course_delivery | incomplete_contract | ✅ | ❌ | Excluded from MVM |
| course_delivery | instruction_assignment | ✅ | ❌ | Excluded from MVM |
| course_delivery | lms_course_shell | ✅ | ✅ |  |
| course_delivery | rubric | ✅ | ✅ |  |
| course_delivery | scorm_package | ✅ | ❌ | Excluded from MVM |
| course_delivery | section_meeting | ✅ | ✅ |  |

<a id="domain-library"></a>
### library

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_management | bib_record | ✅ | ❌ | Domain not in MVM |
| catalog_management | collection | ✅ | ❌ | Domain not in MVM |
| catalog_management | digital_object | ✅ | ❌ | Domain not in MVM |
| catalog_management | holding | ✅ | ❌ | Domain not in MVM |
| catalog_management | item | ✅ | ❌ | Domain not in MVM |
| catalog_management | library | ✅ | ❌ | Domain not in MVM |
| electronic_access | collection_policy_compliance | ✅ | ❌ | Domain not in MVM |
| electronic_access | electronic_resource | ✅ | ❌ | Domain not in MVM |
| electronic_access | ill_request | ✅ | ❌ | Domain not in MVM |
| electronic_access | license | ✅ | ❌ | Domain not in MVM |
| electronic_access | oer_resource | ✅ | ❌ | Domain not in MVM |
| electronic_access | platform | ✅ | ❌ | Domain not in MVM |
| electronic_access | resource_compliance_verification | ✅ | ❌ | Domain not in MVM |
| electronic_access | usage_stat | ✅ | ❌ | Domain not in MVM |
| patron_services | course_reserve | ✅ | ❌ | Domain not in MVM |
| patron_services | fine | ✅ | ❌ | Domain not in MVM |
| patron_services | hold_request | ✅ | ❌ | Domain not in MVM |
| patron_services | loan | ✅ | ❌ | Domain not in MVM |
| patron_services | patron | ✅ | ❌ | Domain not in MVM |
| patron_services | research_support_request | ✅ | ❌ | Domain not in MVM |
| patron_services | service_desk | ✅ | ❌ | Domain not in MVM |
| resource_acquisition | acquisition_order | ✅ | ❌ | Domain not in MVM |
| resource_acquisition | library_fund | ✅ | ❌ | Domain not in MVM |
| resource_acquisition | library_vendor | ✅ | ❌ | Domain not in MVM |
| resource_acquisition | publisher | ✅ | ❌ | Domain not in MVM |
| resource_acquisition | subscription | ✅ | ❌ | Domain not in MVM |

<a id="domain-research"></a>
### research

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_oversight | compliance_event | ✅ | ✅ |  |
| compliance_oversight | conflict_of_interest | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | export_control_review | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | iacuc_protocol | ✅ | ❌ | Excluded from MVM |
| compliance_oversight | irb_protocol | ✅ | ✅ |  |
| compliance_oversight | research_training_completion | ✅ | ❌ | Excluded from MVM |
| financial_operations | effort_certification | ✅ | ❌ | Excluded from MVM |
| financial_operations | expenditure | ✅ | ✅ |  |
| financial_operations | idc_rate | ✅ | ✅ |  |
| grant_administration | award_account | ✅ | ✅ |  |
| grant_administration | award_budget | ✅ | ✅ |  |
| grant_administration | award_modification | ✅ | ❌ | Excluded from MVM |
| grant_administration | award_report | ✅ | ❌ | Excluded from MVM |
| grant_administration | principal_investigator | ✅ | ✅ |  |
| grant_administration | proposal | ✅ | ✅ |  |
| grant_administration | proposal_personnel | ✅ | ✅ |  |
| grant_administration | research_award | ✅ | ✅ |  |
| grant_administration | sponsor | ✅ | ✅ |  |
| grant_administration | subaward | ✅ | ✅ |  |
| grant_administration | subrecipient | ✅ | ❌ | Excluded from MVM |
| innovation_transfer | invention_disclosure | ✅ | ❌ | Excluded from MVM |
| innovation_transfer | scholarly_output | ✅ | ❌ | Excluded from MVM |

<a id="domain-student"></a>
### student

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| academic_records | academic_history | ✅ | ✅ |  |
| academic_records | academic_standing | ✅ | ✅ |  |
| academic_records | degree_conferral | ✅ | ✅ |  |
| academic_records | degree_progress | ✅ | ✅ |  |
| academic_records | enrollment_status | ✅ | ✅ |  |
| academic_records | graduation_application | ✅ | ✅ |  |
| academic_records | profile | ✅ | ✅ |  |
| academic_records | residency_classification | ✅ | ✅ |  |
| academic_records | student_test_score | ✅ | ✅ |  |
| academic_records | transfer_credit | ✅ | ✅ |  |
| compliance_services | cohort_membership | ✅ | ❌ | Excluded from MVM |
| compliance_services | conduct_record | ✅ | ❌ | Excluded from MVM |
| compliance_services | disability_accommodation | ✅ | ✅ |  |
| compliance_services | ferpa_consent | ✅ | ✅ |  |
| compliance_services | hold | ✅ | ✅ |  |
| compliance_services | leave_of_absence | ✅ | ✅ |  |
| compliance_services | student_sap_evaluation | ✅ | ❌ | Excluded from MVM |
| compliance_services | visa_immigration | ✅ | ✅ |  |
| support_interventions | access_authorization | ✅ | ❌ | Excluded from MVM |
| support_interventions | advising_note | ✅ | ❌ | Excluded from MVM |
| support_interventions | checkout | ✅ | ❌ | Excluded from MVM |
| support_interventions | participation | ✅ | ❌ | Excluded from MVM |
| support_interventions | student_early_alert | ✅ | ❌ | Excluded from MVM |
| support_interventions | student_enrollment | ✅ | ❌ | Excluded from MVM |
| support_interventions | student_housing_assignment | ✅ | ❌ | Excluded from MVM |
| support_interventions | student_submission | ✅ | ❌ | Excluded from MVM |
| support_interventions | student_training_completion | ✅ | ❌ | Excluded from MVM |

<a id="domain-studentlife"></a>
### studentlife

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| behavioral_standards | conduct_case | ✅ | ✅ |  |
| behavioral_standards | conduct_sanction | ✅ | ✅ |  |
| campus_engagement | campus_event | ✅ | ✅ |  |
| campus_engagement | cocurricular_record | ✅ | ❌ | Excluded from MVM |
| campus_engagement | event_attendance | ✅ | ✅ |  |
| campus_engagement | org_application_access | ✅ | ❌ | Excluded from MVM |
| campus_engagement | org_membership | ✅ | ✅ |  |
| campus_engagement | service_learning_placement | ✅ | ✅ |  |
| campus_engagement | student_org | ✅ | ✅ |  |
| campus_housing | housing_assignment | ❌ | ✅ | MVM only (stub or new) |
| residential_services | dining_enrollment | ✅ | ✅ |  |
| residential_services | dining_plan | ✅ | ✅ |  |
| residential_services | dining_transaction | ✅ | ❌ | Excluded from MVM |
| residential_services | hall_service_provision | ✅ | ❌ | Excluded from MVM |
| residential_services | housing_application | ✅ | ✅ |  |
| residential_services | housing_contract | ✅ | ❌ | Excluded from MVM |
| residential_services | housing_waitlist | ✅ | ❌ | Excluded from MVM |
| residential_services | llc_enrollment | ✅ | ❌ | Excluded from MVM |
| residential_services | llc_program | ✅ | ❌ | Excluded from MVM |
| residential_services | residence_hall | ✅ | ✅ |  |
| residential_services | residence_room | ✅ | ✅ |  |
| residential_services | roommate_group | ✅ | ❌ | Excluded from MVM |
| residential_services | studentlife_housing_assignment | ✅ | ❌ | Excluded from MVM |
| wellness_support | counseling_case | ✅ | ✅ |  |
| wellness_support | health_appointment | ✅ | ✅ |  |
| wellness_support | health_visit | ✅ | ✅ |  |
| wellness_support | immunization_record | ✅ | ✅ |  |
| wellness_support | wellness_participation | ✅ | ❌ | Excluded from MVM |
| wellness_support | wellness_program | ✅ | ❌ | Excluded from MVM |

<a id="domain-technology"></a>
### technology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_operations | application_contract_coverage | ✅ | ❌ | Domain not in MVM |
| asset_operations | asset_software_installation | ✅ | ❌ | Domain not in MVM |
| asset_operations | configuration_item | ✅ | ❌ | Domain not in MVM |
| asset_operations | it_asset | ✅ | ❌ | Domain not in MVM |
| asset_operations | it_asset_lifecycle_event | ✅ | ❌ | Domain not in MVM |
| asset_operations | it_contract | ✅ | ❌ | Domain not in MVM |
| asset_operations | network_device | ✅ | ❌ | Domain not in MVM |
| asset_operations | software_license | ✅ | ❌ | Domain not in MVM |
| portfolio_management | application_integration | ✅ | ❌ | Domain not in MVM |
| portfolio_management | approval_workflow | ✅ | ❌ | Domain not in MVM |
| portfolio_management | enterprise_application | ✅ | ❌ | Domain not in MVM |
| portfolio_management | it_chargeback | ✅ | ❌ | Domain not in MVM |
| portfolio_management | it_project | ✅ | ❌ | Domain not in MVM |
| security_governance | access_certification | ✅ | ❌ | Domain not in MVM |
| security_governance | access_entitlement | ✅ | ❌ | Domain not in MVM |
| security_governance | access_provisioning_event | ✅ | ❌ | Domain not in MVM |
| security_governance | cybersecurity_incident | ✅ | ❌ | Domain not in MVM |
| security_governance | identity_account | ✅ | ❌ | Domain not in MVM |
| security_governance | it_policy | ✅ | ❌ | Domain not in MVM |
| security_governance | it_risk | ✅ | ❌ | Domain not in MVM |
| security_governance | vulnerability | ✅ | ❌ | Domain not in MVM |
| service_delivery | change_request | ✅ | ❌ | Domain not in MVM |
| service_delivery | incident | ✅ | ❌ | Domain not in MVM |
| service_delivery | it_service | ✅ | ❌ | Domain not in MVM |
| service_delivery | it_service_outage | ✅ | ❌ | Domain not in MVM |
| service_delivery | it_sla_record | ✅ | ❌ | Domain not in MVM |
| service_delivery | knowledge_article | ✅ | ❌ | Domain not in MVM |
| service_delivery | knowledge_category | ✅ | ❌ | Domain not in MVM |
| service_delivery | knowledge_subcategory | ✅ | ❌ | Domain not in MVM |
| service_delivery | notification_template | ✅ | ❌ | Domain not in MVM |
| service_delivery | problem | ✅ | ❌ | Domain not in MVM |
| service_delivery | service_request | ✅ | ❌ | Domain not in MVM |
