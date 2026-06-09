-- Metric views for domain: regulatory | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:12:43

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_establishment_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility registration and compliance status metrics for regulatory oversight and renewal management"
  source: "`food_beverage_ecm`.`regulatory`.`establishment_registration`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of registered facility (manufacturing, warehouse, distribution, etc.)"
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status (active, expired, pending, suspended)"
    - name: "registration_program"
      expr: registration_program
      comment: "Regulatory program under which facility is registered (FDA, USDA, state-level)"
    - name: "country"
      expr: country
      comment: "Country where facility is located"
    - name: "state"
      expr: state
      comment: "State or province where facility is located"
    - name: "registration_year"
      expr: YEAR(effective_date)
      comment: "Year when registration became effective"
    - name: "renewal_due_month"
      expr: DATE_TRUNC('month', renewal_due_date)
      comment: "Month when registration renewal is due"
  measures:
    - name: "total_registered_facilities"
      expr: COUNT(DISTINCT establishment_registration_id)
      comment: "Total number of unique registered facilities"
    - name: "facilities_requiring_renewal"
      expr: COUNT(DISTINCT CASE WHEN renewal_due_date <= CURRENT_DATE + INTERVAL 90 DAY THEN establishment_registration_id END)
      comment: "Number of facilities with renewals due within 90 days - critical for compliance planning"
    - name: "expired_registrations"
      expr: COUNT(DISTINCT CASE WHEN expiration_date < CURRENT_DATE THEN establishment_registration_id END)
      comment: "Number of facilities with expired registrations - immediate compliance risk"
    - name: "overdue_inspections"
      expr: COUNT(DISTINCT CASE WHEN next_inspection_due < CURRENT_DATE THEN establishment_registration_id END)
      comment: "Number of facilities with overdue inspections - regulatory exposure metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_facility_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility inspection outcomes, compliance findings, and corrective action tracking for quality and regulatory risk management"
  source: "`food_beverage_ecm`.`regulatory`.`facility_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (routine, for-cause, follow-up, pre-approval)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Agency conducting inspection (FDA, USDA, state health department)"
    - name: "disposition"
      expr: disposition
      comment: "Inspection outcome classification (no action indicated, voluntary action indicated, official action indicated)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of findings (critical, major, minor, observation)"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions (pending, in progress, completed, overdue)"
    - name: "facility_inspection_status"
      expr: facility_inspection_status
      comment: "Overall inspection status (scheduled, in progress, completed, closed)"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month when inspection was conducted"
    - name: "follow_up_required_flag"
      expr: follow_up_required
      comment: "Whether inspection requires follow-up action"
  measures:
    - name: "total_inspections"
      expr: COUNT(DISTINCT facility_inspection_id)
      comment: "Total number of facility inspections conducted"
    - name: "critical_findings_count"
      expr: COUNT(DISTINCT CASE WHEN severity_level = 'critical' THEN facility_inspection_id END)
      comment: "Number of inspections with critical findings - highest regulatory risk"
    - name: "inspections_requiring_followup"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN facility_inspection_id END)
      comment: "Number of inspections requiring follow-up - workload and risk indicator"
    - name: "overdue_corrective_actions"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_deadline < CURRENT_DATE AND corrective_action_status != 'completed' THEN facility_inspection_id END)
      comment: "Number of inspections with overdue corrective actions - compliance exposure metric"
    - name: "official_action_indicated_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN disposition = 'official action indicated' THEN facility_inspection_id END) / NULLIF(COUNT(DISTINCT facility_inspection_id), 0), 2)
      comment: "Percentage of inspections resulting in official action indicated - key quality and compliance KPI"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_food_safety_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety plan compliance, approval status, and reanalysis tracking for FSMA and HACCP program management"
  source: "`food_beverage_ecm`.`regulatory`.`food_safety_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of food safety plan (HACCP, HARPC, VACCP, TACCP, preventive controls)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of plan (approved, pending, rejected, under review)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of plan (compliant, non-compliant, conditional)"
    - name: "food_safety_plan_status"
      expr: food_safety_plan_status
      comment: "Operational status of plan (active, inactive, superseded, draft)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of products covered by plan (high, medium, low)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority governing the plan (FDA, USDA, CFIA)"
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category covered by the food safety plan"
    - name: "training_required_flag"
      expr: training_required
      comment: "Whether plan requires PCQI or HACCP training"
  measures:
    - name: "total_food_safety_plans"
      expr: COUNT(DISTINCT food_safety_plan_id)
      comment: "Total number of food safety plans in system"
    - name: "plans_requiring_reanalysis"
      expr: COUNT(DISTINCT CASE WHEN next_reanalysis_date <= CURRENT_DATE + INTERVAL 60 DAY THEN food_safety_plan_id END)
      comment: "Number of plans requiring reanalysis within 60 days - compliance deadline tracking"
    - name: "non_compliant_plans"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'non-compliant' THEN food_safety_plan_id END)
      comment: "Number of non-compliant food safety plans - immediate regulatory risk"
    - name: "high_risk_plans"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'high' THEN food_safety_plan_id END)
      comment: "Number of plans covering high-risk products - prioritization for oversight"
    - name: "plans_with_overdue_training"
      expr: COUNT(DISTINCT CASE WHEN training_required = TRUE AND (training_completion_date IS NULL OR training_completion_date < CURRENT_DATE - INTERVAL 3 YEAR) THEN food_safety_plan_id END)
      comment: "Number of plans with overdue or missing PCQI training - compliance gap indicator"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_gfsi_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GFSI certification status, audit outcomes, and renewal tracking for supplier qualification and customer requirements"
  source: "`food_beverage_ecm`.`regulatory`.`gfsi_certification`"
  dimensions:
    - name: "scheme_name"
      expr: scheme_name
      comment: "GFSI scheme (SQF, BRC, FSSC 22000, IFS, Global GAP)"
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (certified, suspended, withdrawn, expired)"
    - name: "grade_level"
      expr: grade_level
      comment: "Certification grade or rating (A, AA, AAA, B, C, or scheme-specific)"
    - name: "certification_body"
      expr: certification_body
      comment: "Certification body that issued the certificate"
    - name: "country_code"
      expr: country_code
      comment: "Country where certified site is located"
    - name: "is_active_flag"
      expr: is_active
      comment: "Whether certification is currently active"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required
      comment: "Whether certification audit identified corrective actions"
    - name: "certification_year"
      expr: YEAR(issue_date)
      comment: "Year when certification was issued"
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT gfsi_certification_id)
      comment: "Total number of GFSI certifications held"
    - name: "active_certifications"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN gfsi_certification_id END)
      comment: "Number of active GFSI certifications - supplier qualification status"
    - name: "certifications_expiring_soon"
      expr: COUNT(DISTINCT CASE WHEN expiry_date <= CURRENT_DATE + INTERVAL 90 DAY AND is_active = TRUE THEN gfsi_certification_id END)
      comment: "Number of certifications expiring within 90 days - renewal planning metric"
    - name: "certifications_with_corrective_actions"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN gfsi_certification_id END)
      comment: "Number of certifications requiring corrective actions - quality improvement tracking"
    - name: "total_certification_cost"
      expr: SUM(CAST(certification_cost AS DOUBLE))
      comment: "Total cost of GFSI certifications - compliance investment tracking"
    - name: "avg_certification_cost"
      expr: AVG(CAST(certification_cost AS DOUBLE))
      comment: "Average cost per GFSI certification - benchmarking metric"
    - name: "top_grade_certification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN grade_level IN ('A', 'AA', 'AAA') THEN gfsi_certification_id END) / NULLIF(COUNT(DISTINCT gfsi_certification_id), 0), 2)
      comment: "Percentage of certifications achieving top grades - quality excellence indicator"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall effectiveness, recovery rates, and regulatory response metrics for crisis management and quality improvement"
  source: "`food_beverage_ecm`.`regulatory`.`recall_event`"
  dimensions:
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall classification (Class I, II, III) indicating health hazard severity"
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (voluntary, mandatory, market withdrawal)"
    - name: "recall_priority"
      expr: recall_priority
      comment: "Priority level for recall execution (urgent, high, medium, low)"
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Agency overseeing recall (FDA, USDA, CFIA)"
    - name: "recall_initiated_by"
      expr: recall_initiated_by
      comment: "Party initiating recall (manufacturer, distributor, regulatory agency)"
    - name: "recall_effectiveness_status"
      expr: recall_effectiveness_status
      comment: "Effectiveness check status (ongoing, completed, terminated)"
    - name: "distribution_scope"
      expr: distribution_scope
      comment: "Geographic scope of recall (nationwide, regional, local, international)"
    - name: "product_category"
      expr: product_category
      comment: "Category of recalled product"
    - name: "recall_month"
      expr: DATE_TRUNC('month', recall_date)
      comment: "Month when recall was initiated"
  measures:
    - name: "total_recall_events"
      expr: COUNT(DISTINCT recall_event_id)
      comment: "Total number of recall events - quality and safety performance indicator"
    - name: "class_i_recalls"
      expr: COUNT(DISTINCT CASE WHEN recall_class = 'Class I' THEN recall_event_id END)
      comment: "Number of Class I recalls (serious health hazard) - critical safety metric"
    - name: "total_units_affected"
      expr: SUM(CAST(total_units_affected AS DOUBLE))
      comment: "Total product units affected by recalls - scope of quality issue"
    - name: "total_units_recovered"
      expr: SUM(CAST(total_units_recovered AS DOUBLE))
      comment: "Total product units successfully recovered from market"
    - name: "recall_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(total_units_recovered AS DOUBLE)) / NULLIF(SUM(CAST(total_units_affected AS DOUBLE)), 0), 2)
      comment: "Percentage of affected units recovered - recall effectiveness KPI"
    - name: "avg_units_per_recall"
      expr: AVG(CAST(total_units_affected AS DOUBLE))
      comment: "Average number of units affected per recall event - scale indicator"
    - name: "recalls_with_followup_required"
      expr: COUNT(DISTINCT CASE WHEN recall_effectiveness_status = 'ongoing' THEN recall_event_id END)
      comment: "Number of recalls still requiring effectiveness checks - workload metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_product_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product registration status, market authorization, and renewal tracking for global market access and compliance"
  source: "`food_beverage_ecm`.`regulatory`.`product_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status (approved, pending, rejected, expired, withdrawn)"
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (new, renewal, variation, transfer)"
    - name: "country_code"
      expr: country_code
      comment: "Country where product is registered"
    - name: "product_category"
      expr: product_category
      comment: "Category of registered product"
    - name: "is_compliant_flag"
      expr: is_compliant
      comment: "Whether product registration is currently compliant"
    - name: "is_export_allowed_flag"
      expr: is_export_allowed
      comment: "Whether product is authorized for export"
    - name: "is_renewal_required_flag"
      expr: is_renewal_required
      comment: "Whether registration requires periodic renewal"
    - name: "regulatory_change_indicator_flag"
      expr: regulatory_change_indicator
      comment: "Whether registration is affected by regulatory changes"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year when product registration was approved"
  measures:
    - name: "total_product_registrations"
      expr: COUNT(DISTINCT product_registration_id)
      comment: "Total number of product registrations - market access portfolio size"
    - name: "approved_registrations"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'approved' THEN product_registration_id END)
      comment: "Number of approved product registrations - active market authorizations"
    - name: "registrations_expiring_soon"
      expr: COUNT(DISTINCT CASE WHEN expiry_date <= CURRENT_DATE + INTERVAL 180 DAY AND registration_status = 'approved' THEN product_registration_id END)
      comment: "Number of registrations expiring within 180 days - renewal planning metric"
    - name: "non_compliant_registrations"
      expr: COUNT(DISTINCT CASE WHEN is_compliant = FALSE THEN product_registration_id END)
      comment: "Number of non-compliant product registrations - regulatory risk exposure"
    - name: "registrations_affected_by_regulatory_change"
      expr: COUNT(DISTINCT CASE WHEN regulatory_change_indicator = TRUE THEN product_registration_id END)
      comment: "Number of registrations impacted by regulatory changes - change management workload"
    - name: "export_authorized_products"
      expr: COUNT(DISTINCT CASE WHEN is_export_allowed = TRUE THEN product_registration_id END)
      comment: "Number of products authorized for export - international market access metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_nutrition_label`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutrition labeling compliance, claim verification, and regulatory status for consumer transparency and legal compliance"
  source: "`food_beverage_ecm`.`regulatory`.`nutrition_label`"
  dimensions:
    - name: "label_status"
      expr: label_status
      comment: "Current status of nutrition label (active, pending, expired, withdrawn)"
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Compliance status with nutrition labeling regulations"
    - name: "country"
      expr: country
      comment: "Country for which label is formatted"
    - name: "label_format"
      expr: label_format
      comment: "Format of nutrition label (vertical, horizontal, linear, simplified)"
    - name: "is_organic_flag"
      expr: is_organic
      comment: "Whether product is certified organic"
    - name: "is_non_gmo_flag"
      expr: is_non_gmo
      comment: "Whether product is non-GMO verified"
    - name: "is_gluten_free_flag"
      expr: is_gluten_free
      comment: "Whether product is gluten-free"
    - name: "is_vegan_flag"
      expr: is_vegan
      comment: "Whether product is vegan"
    - name: "is_kosher_flag"
      expr: is_kosher
      comment: "Whether product is kosher certified"
    - name: "is_halal_flag"
      expr: is_halal
      comment: "Whether product is halal certified"
  measures:
    - name: "total_nutrition_labels"
      expr: COUNT(DISTINCT nutrition_label_id)
      comment: "Total number of nutrition labels in system"
    - name: "compliant_labels"
      expr: COUNT(DISTINCT CASE WHEN regulatory_compliance_status = 'compliant' THEN nutrition_label_id END)
      comment: "Number of compliant nutrition labels - regulatory adherence metric"
    - name: "avg_calories_per_serving"
      expr: AVG(CAST(calories AS DOUBLE))
      comment: "Average calories per serving across products - portfolio nutrition profile"
    - name: "avg_sodium_mg_per_serving"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium per serving - key health metric for reformulation"
    - name: "avg_total_sugars_g_per_serving"
      expr: AVG(CAST(total_sugars_g AS DOUBLE))
      comment: "Average total sugars per serving - reformulation and health target"
    - name: "organic_product_count"
      expr: COUNT(DISTINCT CASE WHEN is_organic = TRUE THEN nutrition_label_id END)
      comment: "Number of organic certified products - premium portfolio metric"
    - name: "non_gmo_product_count"
      expr: COUNT(DISTINCT CASE WHEN is_non_gmo = TRUE THEN nutrition_label_id END)
      comment: "Number of non-GMO verified products - consumer preference alignment"
    - name: "gluten_free_product_count"
      expr: COUNT(DISTINCT CASE WHEN is_gluten_free = TRUE THEN nutrition_label_id END)
      comment: "Number of gluten-free products - dietary accommodation portfolio"
    - name: "specialty_diet_coverage_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_vegan = TRUE OR is_gluten_free = TRUE OR is_organic = TRUE THEN nutrition_label_id END) / NULLIF(COUNT(DISTINCT nutrition_label_id), 0), 2)
      comment: "Percentage of products meeting specialty diet criteria - market positioning KPI"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_label_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Label approval workflow, claim verification, and regulatory review tracking for compliant product launch"
  source: "`food_beverage_ecm`.`regulatory`.`label_approval`"
  dimensions:
    - name: "label_approval_status"
      expr: label_approval_status
      comment: "Current approval status (approved, pending, rejected, under review, conditional)"
    - name: "approval_type"
      expr: approval_type
      comment: "Type of approval (new, revision, renewal, emergency)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority reviewing label (FDA, USDA, TTB, state agency)"
    - name: "country_code"
      expr: country_code
      comment: "Country where label approval is sought"
    - name: "market"
      expr: market
      comment: "Market or region for label approval"
    - name: "allergen_declaration_verified_flag"
      expr: allergen_declaration_verified
      comment: "Whether allergen declaration has been verified"
    - name: "nutrition_facts_verified_flag"
      expr: nutrition_facts_verified
      comment: "Whether nutrition facts panel has been verified"
    - name: "marketing_claim_verified_flag"
      expr: marketing_claim_verified
      comment: "Whether marketing claims have been substantiated and verified"
    - name: "change_requested_flag"
      expr: change_requested
      comment: "Whether regulatory body requested changes to label"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month when label was submitted for approval"
  measures:
    - name: "total_label_submissions"
      expr: COUNT(DISTINCT label_approval_id)
      comment: "Total number of label approval submissions"
    - name: "approved_labels"
      expr: COUNT(DISTINCT CASE WHEN label_approval_status = 'approved' THEN label_approval_id END)
      comment: "Number of approved labels - successful regulatory clearances"
    - name: "pending_approvals"
      expr: COUNT(DISTINCT CASE WHEN label_approval_status IN ('pending', 'under review') THEN label_approval_id END)
      comment: "Number of labels awaiting approval - pipeline and launch planning metric"
    - name: "rejected_labels"
      expr: COUNT(DISTINCT CASE WHEN label_approval_status = 'rejected' THEN label_approval_id END)
      comment: "Number of rejected label submissions - quality and compliance issue indicator"
    - name: "labels_requiring_changes"
      expr: COUNT(DISTINCT CASE WHEN change_requested = TRUE THEN label_approval_id END)
      comment: "Number of labels requiring revisions - rework and delay metric"
    - name: "label_approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN label_approval_status = 'approved' THEN label_approval_id END) / NULLIF(COUNT(DISTINCT CASE WHEN label_approval_status IN ('approved', 'rejected') THEN label_approval_id END), 0), 2)
      comment: "Percentage of submitted labels approved - regulatory submission quality KPI"
    - name: "first_pass_approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN label_approval_status = 'approved' AND change_requested = FALSE THEN label_approval_id END) / NULLIF(COUNT(DISTINCT CASE WHEN label_approval_status IN ('approved', 'rejected') THEN label_approval_id END), 0), 2)
      comment: "Percentage of labels approved without changes - regulatory excellence metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_packaging_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging regulatory compliance, sustainability claims, and material certification tracking for environmental and legal requirements"
  source: "`food_beverage_ecm`.`regulatory`.`packaging_compliance`"
  dimensions:
    - name: "packaging_compliance_status"
      expr: packaging_compliance_status
      comment: "Current compliance status of packaging (compliant, non-compliant, under review)"
    - name: "material_type"
      expr: material_type
      comment: "Type of packaging material (plastic, paper, glass, metal, composite)"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Type of packaging (primary, secondary, tertiary, transport)"
    - name: "recyclability_classification"
      expr: recyclability_classification
      comment: "Recyclability classification (widely recyclable, limited recyclability, not recyclable)"
    - name: "eu_directive_94_62_ec_compliant_flag"
      expr: eu_directive_94_62_ec_compliant
      comment: "Whether packaging complies with EU Directive 94/62/EC"
    - name: "heavy_metal_compliance_flag"
      expr: heavy_metal_compliance
      comment: "Whether packaging meets heavy metal content limits"
    - name: "material_supplier_certified_flag"
      expr: material_supplier_certified
      comment: "Whether material supplier is certified"
    - name: "hazardous_substance_present_flag"
      expr: hazardous_substance_present
      comment: "Whether packaging contains hazardous substances"
    - name: "ftc_green_guides_claim_flag"
      expr: ftc_green_guides_claim
      comment: "Whether packaging makes environmental claims under FTC Green Guides"
  measures:
    - name: "total_packaging_items"
      expr: COUNT(DISTINCT packaging_compliance_id)
      comment: "Total number of packaging items tracked for compliance"
    - name: "compliant_packaging_count"
      expr: COUNT(DISTINCT CASE WHEN packaging_compliance_status = 'compliant' THEN packaging_compliance_id END)
      comment: "Number of compliant packaging items - regulatory adherence metric"
    - name: "avg_recycled_content_pct"
      expr: AVG(CAST(recycled_content_percent AS DOUBLE))
      comment: "Average recycled content percentage - sustainability performance indicator"
    - name: "avg_packaging_weight_kg"
      expr: AVG(CAST(packaging_weight_kg AS DOUBLE))
      comment: "Average packaging weight - lightweighting and efficiency metric"
    - name: "widely_recyclable_packaging_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN recyclability_classification = 'widely recyclable' THEN packaging_compliance_id END) / NULLIF(COUNT(DISTINCT packaging_compliance_id), 0), 2)
      comment: "Percentage of packaging that is widely recyclable - circular economy KPI"
    - name: "packaging_with_hazardous_substances"
      expr: COUNT(DISTINCT CASE WHEN hazardous_substance_present = TRUE THEN packaging_compliance_id END)
      comment: "Number of packaging items containing hazardous substances - risk and phase-out tracking"
    - name: "heavy_metal_compliant_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN heavy_metal_compliance = TRUE THEN packaging_compliance_id END) / NULLIF(COUNT(DISTINCT packaging_compliance_id), 0), 2)
      comment: "Percentage of packaging meeting heavy metal limits - regulatory compliance KPI"
    - name: "avg_environmental_impact_score"
      expr: AVG(CAST(packaging_environmental_impact_score AS DOUBLE))
      comment: "Average environmental impact score - sustainability benchmarking metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_import_export_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Import/export permit status, customs compliance, and trade authorization tracking for international supply chain operations"
  source: "`food_beverage_ecm`.`regulatory`.`import_export_permit`"
  dimensions:
    - name: "import_export_permit_status"
      expr: import_export_permit_status
      comment: "Current permit status (active, expired, pending, suspended, revoked)"
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (import, export, re-export, transit)"
    - name: "permit_category"
      expr: permit_category
      comment: "Category of permit (general, specific, open, restricted)"
    - name: "origin_country"
      expr: origin_country
      comment: "Country of origin for goods"
    - name: "destination_country"
      expr: destination_country
      comment: "Destination country for goods"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit"
    - name: "preferential_agreement"
      expr: preferential_agreement
      comment: "Trade agreement under which preferential treatment is claimed (USMCA, CPTPP, EU FTA)"
    - name: "fda_prior_notice_flag"
      expr: fda_prior_notice_flag
      comment: "Whether FDA prior notice is required"
    - name: "cbp_entry_compliance_flag"
      expr: cbp_entry_compliance_flag
      comment: "Whether entry is compliant with CBP requirements"
    - name: "issuance_year"
      expr: YEAR(issuance_date)
      comment: "Year when permit was issued"
  measures:
    - name: "total_permits"
      expr: COUNT(DISTINCT import_export_permit_id)
      comment: "Total number of import/export permits"
    - name: "active_permits"
      expr: COUNT(DISTINCT CASE WHEN import_export_permit_status = 'active' THEN import_export_permit_id END)
      comment: "Number of active permits - current trade authorization capacity"
    - name: "permits_expiring_soon"
      expr: COUNT(DISTINCT CASE WHEN expiration_date <= CURRENT_DATE + INTERVAL 60 DAY AND import_export_permit_status = 'active' THEN import_export_permit_id END)
      comment: "Number of permits expiring within 60 days - renewal planning metric"
    - name: "expired_permits"
      expr: COUNT(DISTINCT CASE WHEN expiration_date < CURRENT_DATE THEN import_export_permit_id END)
      comment: "Number of expired permits - compliance risk and supply chain disruption indicator"
    - name: "avg_duty_rate"
      expr: AVG(CAST(duty_rate AS DOUBLE))
      comment: "Average duty rate across permits - landed cost and sourcing optimization metric"
    - name: "preferential_trade_agreement_utilization_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN preferential_agreement IS NOT NULL AND preferential_agreement != '' THEN import_export_permit_id END) / NULLIF(COUNT(DISTINCT import_export_permit_id), 0), 2)
      comment: "Percentage of permits utilizing preferential trade agreements - duty savings opportunity KPI"
$$;