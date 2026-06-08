-- Metric views for domain: rawmaterial | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:33:25

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_supplier_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier material performance metrics tracking cost efficiency, compliance status, and supply risk across approved suppliers and materials"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`supplier_material`"
  dimensions:
    - name: "supplier_part_number"
      expr: supplier_part_number
      comment: "Unique part number assigned by the supplier for this material"
    - name: "supplier_trade_name"
      expr: supplier_trade_name
      comment: "Commercial trade name used by the supplier for this material"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the supplier material (e.g., Qualified, Pending, Disqualified)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the material (e.g., Compliant, Non-Compliant, Under Review)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the material is manufactured or sourced"
    - name: "supply_risk_tier"
      expr: supply_risk_tier
      comment: "Risk classification tier for supply continuity (e.g., Low, Medium, High, Critical)"
    - name: "preferred_supplier_flag"
      expr: preferred_supplier
      comment: "Indicates whether this is a preferred supplier for the material"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the material is classified as hazardous"
    - name: "material_grade"
      expr: material_grade
      comment: "Quality or purity grade of the material (e.g., Technical, Pharmaceutical, Food Grade)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the material is priced"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Type of packaging used for the material (e.g., Drum, Bag, Tote, Bulk)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for pricing and ordering (e.g., KG, LB, MT)"
    - name: "tsca_status"
      expr: tsca_status
      comment: "Toxic Substances Control Act compliance status"
    - name: "ghs_classification"
      expr: ghs_classification
      comment: "Globally Harmonized System hazard classification"
  measures:
    - name: "total_supplier_materials"
      expr: COUNT(DISTINCT supplier_material_id)
      comment: "Total count of unique supplier material records"
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit across supplier materials, used to benchmark supplier pricing competitiveness"
    - name: "total_procurement_value"
      expr: SUM(CAST(price_per_unit AS DOUBLE) * CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total procurement value based on minimum order quantities, indicating capital commitment per supplier material"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average procurement lead time in days, critical for production planning and inventory optimization"
    - name: "avg_shelf_life_days"
      expr: AVG(CAST(shelf_life_days AS DOUBLE))
      comment: "Average shelf life in days, impacting inventory turnover and waste management strategies"
    - name: "avg_purity_percent"
      expr: AVG(CAST(purity_percent AS DOUBLE))
      comment: "Average material purity percentage, indicating quality consistency across suppliers"
    - name: "preferred_supplier_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preferred_supplier = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supplier materials from preferred suppliers, indicating strategic sourcing effectiveness"
    - name: "hazardous_material_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hazardous_material_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of materials classified as hazardous, driving EHS resource allocation and compliance costs"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supplier materials in compliant status, critical for regulatory risk management"
    - name: "high_risk_supply_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN supply_risk_tier IN ('High', 'Critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of materials in high or critical supply risk tiers, driving supply chain resilience investments"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_incoming_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control and inspection performance metrics tracking acceptance rates, out-of-specification events, and inspection cycle times for incoming raw materials"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Pending, In Progress, Completed, On Hold)"
    - name: "overall_decision"
      expr: overall_decision
      comment: "Final inspection decision (e.g., Accept, Reject, Conditional Accept, Return)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., Full, Reduced, Skip Lot, 100% Inspection)"
    - name: "quality_flag"
      expr: quality_flag
      comment: "Quality flag indicating special conditions or concerns"
    - name: "oos_flag"
      expr: oos_flag
      comment: "Out-of-specification flag indicating material failed specification limits"
    - name: "oot_flag"
      expr: oot_flag
      comment: "Out-of-trend flag indicating unusual variation from historical norms"
    - name: "capap_triggered"
      expr: capap_triggered
      comment: "Corrective and Preventive Action (CAPA) triggered flag"
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location assigned after inspection"
    - name: "sample_plan"
      expr: sample_plan
      comment: "Sampling plan used for the inspection (e.g., AQL 2.5, 100%, Reduced)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the inspected material"
    - name: "color"
      expr: color
      comment: "Observed color of the material during inspection"
    - name: "appearance"
      expr: appearance
      comment: "Physical appearance description of the material"
  measures:
    - name: "total_inspections"
      expr: COUNT(DISTINCT incoming_inspection_id)
      comment: "Total count of incoming inspection events"
    - name: "total_inspected_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of material inspected, indicating inspection workload and throughput"
    - name: "avg_inspected_quantity"
      expr: AVG(CAST(received_quantity AS DOUBLE))
      comment: "Average quantity per inspection, used for resource planning and capacity analysis"
    - name: "acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_decision = 'Accept' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in acceptance, key indicator of supplier quality performance"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_decision = 'Reject' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in rejection, driving supplier corrective actions and cost of quality"
    - name: "oos_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN oos_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Out-of-specification rate, critical quality metric triggering investigations and supplier performance reviews"
    - name: "oot_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN oot_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Out-of-trend rate, early warning indicator for process drift and quality degradation"
    - name: "capa_trigger_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capap_triggered = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections triggering corrective actions, indicating systemic quality issues requiring intervention"
    - name: "avg_assay_percent"
      expr: AVG(CAST(assay_percent AS DOUBLE))
      comment: "Average assay percentage across inspections, indicating material potency and quality consistency"
    - name: "avg_moisture_percent"
      expr: AVG(CAST(moisture_percent AS DOUBLE))
      comment: "Average moisture content, critical for material stability and shelf life"
    - name: "avg_ph_value"
      expr: AVG(CAST(ph_value AS DOUBLE))
      comment: "Average pH value, important for chemical compatibility and process control"
    - name: "avg_density_kg_m3"
      expr: AVG(CAST(density_kg_m3 AS DOUBLE))
      comment: "Average material density, used for quality verification and process calculations"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_lot_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot-level inventory and quality metrics tracking lot status, expiry risk, quality inspection outcomes, and inventory valuation for raw material lots"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`lot_record`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current lifecycle status of the lot (e.g., Quarantine, Released, Rejected, Expired, Consumed)"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Status of quality inspection for the lot (e.g., Pending, In Progress, Passed, Failed)"
    - name: "quality_inspection_result"
      expr: quality_inspection_result
      comment: "Result of the quality inspection (e.g., Pass, Fail, Conditional)"
    - name: "batch_type"
      expr: batch_type
      comment: "Type of batch (e.g., Production, Pilot, R&D, Rework)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the material was manufactured"
    - name: "storage_location"
      expr: storage_location
      comment: "Physical storage location of the lot"
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the material in this lot"
    - name: "is_recalled"
      expr: is_recalled
      comment: "Indicates whether the lot has been recalled"
    - name: "lot_owner_department"
      expr: lot_owner_department
      comment: "Department responsible for the lot"
    - name: "uom"
      expr: uom
      comment: "Unit of measure for the lot quantity"
    - name: "supplier_lot_number"
      expr: supplier_lot_number
      comment: "Lot number assigned by the supplier"
  measures:
    - name: "total_lots"
      expr: COUNT(DISTINCT lot_record_id)
      comment: "Total count of unique lot records"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of material received across all lots, indicating procurement volume"
    - name: "total_inventory_value"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total inventory value across all lots, critical for working capital management and financial reporting"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across lots, used for cost benchmarking and variance analysis"
    - name: "quality_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_inspection_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots passing quality inspection, key supplier performance and quality assurance metric"
    - name: "recall_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_recalled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots recalled, critical quality and risk management indicator"
    - name: "expired_lot_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lot_status = 'Expired' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots that have expired, indicating inventory turnover efficiency and waste"
    - name: "quarantine_lot_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lot_status = 'Quarantine' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots in quarantine status, indicating quality hold volume and working capital tied up"
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature across lots, used for environmental control monitoring"
    - name: "avg_storage_humidity_percent"
      expr: AVG(CAST(storage_humidity_percent AS DOUBLE))
      comment: "Average storage humidity, critical for material stability and quality preservation"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_coa_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certificate of Analysis quality compliance metrics tracking specification conformance, assay performance, and overall pass/fail rates for incoming materials"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`coa_document`"
  dimensions:
    - name: "coa_document_status"
      expr: coa_document_status
      comment: "Status of the COA document (e.g., Draft, Issued, Approved, Rejected)"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of the COA (e.g., Pass, Fail, Conditional)"
    - name: "overall_pass_fail"
      expr: overall_pass_fail
      comment: "Boolean flag indicating overall pass or fail status"
    - name: "supplier_name"
      expr: supplier_name
      comment: "Name of the supplier who issued the COA"
    - name: "lab_name"
      expr: lab_name
      comment: "Name of the laboratory that performed the analysis"
    - name: "lab_location"
      expr: lab_location
      comment: "Location of the testing laboratory"
    - name: "analytical_method"
      expr: analytical_method
      comment: "Analytical method used for testing (e.g., HPLC, GC, Titration)"
    - name: "material_name"
      expr: material_name
      comment: "Name of the material being certified"
    - name: "cas_number"
      expr: cas_number
      comment: "CAS registry number of the material"
    - name: "assay_pass"
      expr: assay_pass
      comment: "Indicates whether the assay test passed specification"
    - name: "purity_pass"
      expr: purity_pass
      comment: "Indicates whether the purity test passed specification"
    - name: "ph_pass"
      expr: ph_pass
      comment: "Indicates whether the pH test passed specification"
  measures:
    - name: "total_coa_documents"
      expr: COUNT(DISTINCT coa_document_id)
      comment: "Total count of unique COA documents"
    - name: "overall_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_pass_fail = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of COAs with overall pass status, primary supplier quality performance indicator"
    - name: "assay_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN assay_pass = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of COAs passing assay specification, indicating material potency compliance"
    - name: "purity_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN purity_pass = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of COAs passing purity specification, critical for product quality and regulatory compliance"
    - name: "ph_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ph_pass = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of COAs passing pH specification, important for process compatibility"
    - name: "avg_assay_percent"
      expr: AVG(CAST(assay_percent AS DOUBLE))
      comment: "Average assay percentage across COAs, indicating typical material strength"
    - name: "avg_purity_percent"
      expr: AVG(CAST(purity_percent AS DOUBLE))
      comment: "Average purity percentage, indicating material quality consistency"
    - name: "avg_moisture_percent"
      expr: AVG(CAST(moisture_percent AS DOUBLE))
      comment: "Average moisture content, affecting material stability and yield"
    - name: "avg_heavy_metals_ppm"
      expr: AVG(CAST(heavy_metals_ppm AS DOUBLE))
      comment: "Average heavy metals content in parts per million, critical for safety and regulatory compliance"
    - name: "avg_residual_solvents_ppm"
      expr: AVG(CAST(residual_solvents_ppm AS DOUBLE))
      comment: "Average residual solvents in parts per million, important for product safety and quality"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_material_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material and supplier qualification performance metrics tracking qualification cycle times, approval rates, and trial outcomes for new materials and suppliers"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`material_qualification`"
  dimensions:
    - name: "material_qualification_status"
      expr: material_qualification_status
      comment: "Current status of the material qualification (e.g., Initiated, In Progress, Approved, Rejected)"
    - name: "qualification_decision"
      expr: qualification_decision
      comment: "Final qualification decision (e.g., Qualified, Not Qualified, Conditionally Qualified)"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., New Material, New Supplier, Requalification, Change Control)"
    - name: "qualification_scope"
      expr: qualification_scope
      comment: "Scope of the qualification (e.g., Full, Partial, Limited)"
    - name: "lab_evaluation_result"
      expr: lab_evaluation_result
      comment: "Result of laboratory evaluation phase (e.g., Pass, Fail, Conditional)"
    - name: "pilot_trial_result"
      expr: pilot_trial_result
      comment: "Result of pilot trial phase (e.g., Successful, Failed, Inconclusive)"
    - name: "production_trial_result"
      expr: production_trial_result
      comment: "Result of production trial phase (e.g., Successful, Failed, Inconclusive)"
    - name: "technical_review_outcome"
      expr: technical_review_outcome
      comment: "Outcome of technical review (e.g., Approved, Rejected, Requires Revision)"
    - name: "regulatory_review_outcome"
      expr: regulatory_review_outcome
      comment: "Outcome of regulatory review (e.g., Approved, Rejected, Pending)"
  measures:
    - name: "total_qualifications"
      expr: COUNT(DISTINCT material_qualification_id)
      comment: "Total count of material qualification projects"
    - name: "qualification_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qualification_decision = 'Qualified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications resulting in approval, indicating supplier and material suitability success rate"
    - name: "lab_evaluation_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lab_evaluation_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications passing lab evaluation, early indicator of material quality"
    - name: "pilot_trial_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pilot_trial_result = 'Successful' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications with successful pilot trials, indicating process compatibility"
    - name: "production_trial_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN production_trial_result = 'Successful' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications with successful production trials, final validation before full approval"
    - name: "technical_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN technical_review_outcome = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications approved by technical review, indicating technical feasibility"
    - name: "regulatory_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_review_outcome = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications approved by regulatory review, critical for compliance and market access"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_reach_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "REACH regulatory compliance metrics tracking registration status, SVHC candidate substances, and compliance deadline adherence for EU chemical regulations"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`reach_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current REACH registration status (e.g., Registered, Pending, Expired, Not Required)"
    - name: "registration_type"
      expr: registration_type
      comment: "Type of REACH registration (e.g., Full, Intermediate, Transported Isolated Intermediate)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the registration (e.g., Active, Inactive, Under Review)"
    - name: "authorisation_status"
      expr: authorisation_status
      comment: "Authorization status under REACH (e.g., Authorized, Not Required, Pending)"
    - name: "restriction_status"
      expr: restriction_status
      comment: "Restriction status under REACH (e.g., Restricted, Not Restricted, Under Review)"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Evaluation status by ECHA (e.g., Evaluated, Under Evaluation, Not Evaluated)"
    - name: "svhc_candidate_flag"
      expr: svhc_candidate_flag
      comment: "Indicates whether the substance is on the SVHC candidate list"
    - name: "co_registrant_flag"
      expr: co_registrant_flag
      comment: "Indicates whether the company is a co-registrant in a joint submission"
    - name: "tonnage_band"
      expr: tonnage_band
      comment: "Tonnage band for the registration (e.g., 1-10 tonnes, 10-100 tonnes, 100-1000 tonnes)"
    - name: "substance_classification"
      expr: substance_classification
      comment: "Classification of the substance under REACH"
    - name: "substance_name"
      expr: substance_name
      comment: "Name of the substance registered under REACH"
    - name: "ec_number"
      expr: ec_number
      comment: "European Community number for the substance"
  measures:
    - name: "total_reach_registrations"
      expr: COUNT(DISTINCT reach_registration_id)
      comment: "Total count of REACH registration records"
    - name: "active_registration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN registration_status = 'Registered' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of substances with active REACH registration, critical for EU market access compliance"
    - name: "svhc_candidate_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN svhc_candidate_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of substances on SVHC candidate list, indicating high regulatory risk and potential substitution needs"
    - name: "restricted_substance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN restriction_status = 'Restricted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of substances with REACH restrictions, requiring special handling and use limitations"
    - name: "authorization_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN authorisation_status = 'Authorized' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of substances requiring REACH authorization, indicating highest regulatory scrutiny and compliance cost"
    - name: "co_registrant_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN co_registrant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrations as co-registrant, indicating cost-sharing opportunities in joint submissions"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_material_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material master data quality and regulatory profile metrics tracking hazardous material prevalence, controlled substance status, and lifecycle management"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`material_master`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the material (e.g., Active, Obsolete, Phase-Out, Restricted)"
    - name: "material_class"
      expr: material_class
      comment: "Classification of the material (e.g., Raw Material, Intermediate, Reagent)"
    - name: "material_group"
      expr: material_group
      comment: "Material group for categorization (e.g., Solvents, Acids, Polymers)"
    - name: "physical_state"
      expr: physical_state
      comment: "Physical state of the material (e.g., Solid, Liquid, Gas)"
    - name: "hazard_class_ghs"
      expr: hazard_class_ghs
      comment: "GHS hazard class of the material"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Indicates whether the material is classified as hazardous"
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Indicates whether the material is a controlled substance"
    - name: "is_restricted_substance"
      expr: is_restricted_substance
      comment: "Indicates whether the material is a restricted substance"
    - name: "tsca_regulation_status"
      expr: tsca_regulation_status
      comment: "TSCA regulatory status of the material"
    - name: "batch_number_required"
      expr: batch_number_required
      comment: "Indicates whether batch number tracking is required"
    - name: "quality_control_required"
      expr: quality_control_required
      comment: "Indicates whether quality control is required for the material"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the material has regulatory compliance requirements"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Standard unit of measure for the material"
  measures:
    - name: "total_materials"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Total count of unique materials in the master data"
    - name: "hazardous_material_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hazardous = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of materials classified as hazardous, driving EHS program scope and compliance costs"
    - name: "controlled_substance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_controlled_substance = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of materials that are controlled substances, requiring special licensing and security measures"
    - name: "restricted_substance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_restricted_substance = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of materials with usage restrictions, impacting formulation flexibility and market access"
    - name: "active_material_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lifecycle_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of materials in active lifecycle status, indicating portfolio health and obsolescence management"
    - name: "qc_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_control_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of materials requiring quality control, driving QC resource allocation and testing costs"
    - name: "avg_molecular_weight"
      expr: AVG(CAST(molecular_weight AS DOUBLE))
      comment: "Average molecular weight across materials, used for technical analysis and formulation calculations"
    - name: "avg_storage_temp_max_c"
      expr: AVG(CAST(storage_temperature_max_c AS DOUBLE))
      comment: "Average maximum storage temperature, informing warehouse environmental control requirements"
    - name: "avg_humidity_requirement_percent"
      expr: AVG(CAST(humidity_requirement_percent AS DOUBLE))
      comment: "Average humidity requirement, driving storage facility design and operating costs"
$$;