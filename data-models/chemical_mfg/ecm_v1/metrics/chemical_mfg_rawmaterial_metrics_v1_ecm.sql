-- Metric views for domain: rawmaterial | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_material_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core material master KPIs for inventory planning and product strategy"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`material_master`"
  dimensions:
    - name: "material_master_name"
      expr: material_master_name
      comment: "Descriptive name of the material"
    - name: "material_class"
      expr: material_class
      comment: "High‑level classification of the material"
    - name: "material_group"
      expr: material_group
      comment: "Group within the material class"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the material"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Indicates if the material is hazardous"
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Indicates regulatory controlled‑substance status"
    - name: "physical_state"
      expr: physical_state
      comment: "Physical state (solid, liquid, gas)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Base unit of measure for the material"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the material became effective"
  measures:
    - name: "total_materials"
      expr: COUNT(1)
      comment: "Total number of material master records"
    - name: "avg_molecular_weight"
      expr: AVG(CAST(molecular_weight AS DOUBLE))
      comment: "Average molecular weight across materials"
    - name: "avg_storage_temperature_max"
      expr: AVG(CAST(storage_temperature_max_c AS DOUBLE))
      comment: "Average maximum recommended storage temperature (°C)"
    - name: "avg_storage_temperature_min"
      expr: AVG(CAST(storage_temperature_min_c AS DOUBLE))
      comment: "Average minimum recommended storage temperature (°C)"
    - name: "total_min_order_quantity"
      expr: SUM(CAST(min_order_quantity AS DOUBLE))
      comment: "Sum of minimum order quantities across all materials"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_lot_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot‑level inventory and cost KPIs for supply chain visibility"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`lot_record`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the lot (e.g., active, held, expired)"
    - name: "lot_owner_department"
      expr: lot_owner_department
      comment: "Department responsible for the lot"
    - name: "storage_location"
      expr: storage_location
      comment: "Physical storage location identifier"
    - name: "lot_creation_timestamp"
      expr: lot_creation_timestamp
      comment: "Timestamp when the lot record was created"
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date the lot was received"
  measures:
    - name: "total_lots"
      expr: COUNT(1)
      comment: "Total number of lot records"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all lots (units as per uom)"
    - name: "avg_storage_temperature"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature (°C) across lots"
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Aggregate cost of all lots"
    - name: "recalled_lot_count"
      expr: SUM(CASE WHEN is_recalled THEN 1 ELSE 0 END)
      comment: "Count of lots flagged as recalled"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_incoming_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality inspection KPIs to monitor incoming raw material conformity"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type/category of inspection"
    - name: "storage_location"
      expr: storage_location
      comment: "Location where inspected material is stored"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for inspected quantities"
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of the inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total incoming inspections performed"
    - name: "passed_inspections"
      expr: SUM(CASE WHEN overall_decision = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of inspections that passed overall"
    - name: "avg_assay_percent"
      expr: AVG(CAST(assay_percent AS DOUBLE))
      comment: "Average assay percentage across inspections"
    - name: "avg_moisture_percent"
      expr: AVG(CAST(moisture_percent AS DOUBLE))
      comment: "Average moisture percentage"
    - name: "avg_ph_value"
      expr: AVG(CAST(ph_value AS DOUBLE))
      comment: "Average pH value measured"
    - name: "avg_density"
      expr: AVG(CAST(density_kg_m3 AS DOUBLE))
      comment: "Average density (kg/m³)"
    - name: "avg_viscosity"
      expr: AVG(CAST(viscosity_cp AS DOUBLE))
      comment: "Average viscosity (cP)"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received in inspections"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_distribution_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial agreement KPIs for distributor pricing and regulatory compliance"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`distribution_agreement`"
  dimensions:
    - name: "reach_compliance_required"
      expr: reach_compliance_required
      comment: "Indicates if REACH compliance is required"
    - name: "tsca_compliance_required"
      expr: tsca_compliance_required
      comment: "Indicates if TSCA compliance is required"
    - name: "distributor_id"
      expr: distributor_id
      comment: "Identifier of the distributor"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total distribution agreements"
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit across agreements"
    - name: "total_moq"
      expr: SUM(CAST(moq_kg AS DOUBLE))
      comment: "Sum of minimum order quantities (kg) across agreements"
    - name: "compliant_agreements"
      expr: SUM(CASE WHEN reach_compliance_required AND tsca_compliance_required THEN 1 ELSE 0 END)
      comment: "Count of agreements meeting both REACH and TSCA compliance"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_material_hazard_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety and regulatory hazard KPIs for material risk assessment"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`material_hazard_profile`"
  dimensions:
    - name: "dot_hazard_class"
      expr: dot_hazard_class
      comment: "DOT hazard class"
    - name: "rcra_classification"
      expr: rcra_classification
      comment: "RCRA classification"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the hazard profile became effective"
  measures:
    - name: "total_profiles"
      expr: COUNT(1)
      comment: "Total hazard profiles recorded"
    - name: "avg_flash_point"
      expr: AVG(CAST(flash_point_celsius AS DOUBLE))
      comment: "Average flash point (°C)"
    - name: "avg_boiling_point"
      expr: AVG(CAST(boiling_point_celsius AS DOUBLE))
      comment: "Average boiling point (°C)"
    - name: "avg_autoignition_temp"
      expr: AVG(CAST(autoignition_temperature_celsius AS DOUBLE))
      comment: "Average auto‑ignition temperature (°C)"
    - name: "avg_vapor_pressure"
      expr: AVG(CAST(vapor_pressure_kpa AS DOUBLE))
      comment: "Average vapor pressure (kPa)"
    - name: "avg_specific_gravity"
      expr: AVG(CAST(specific_gravity AS DOUBLE))
      comment: "Average specific gravity"
    - name: "marine_pollutant_count"
      expr: SUM(CASE WHEN marine_pollutant_flag THEN 1 ELSE 0 END)
      comment: "Count of materials flagged as marine pollutants"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`rawmaterial_coa_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certificate of Analysis KPIs for quality assurance and compliance monitoring"
  source: "`chemical_mfg_ecm`.`rawmaterial`.`coa_document`"
  dimensions:
    - name: "coa_document_status"
      expr: coa_document_status
      comment: "Current status of the COA document"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result classification (e.g., Pass, Fail)"
    - name: "lab_name"
      expr: lab_name
      comment: "Name of the laboratory that issued the COA"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Identifier of the vendor supplying the material"
    - name: "issue_date"
      expr: issue_date
      comment: "Date the COA was issued"
  measures:
    - name: "total_documents"
      expr: COUNT(1)
      comment: "Total COA documents"
    - name: "passed_documents"
      expr: SUM(CASE WHEN overall_pass_fail THEN 1 ELSE 0 END)
      comment: "Count of COA documents that passed overall"
    - name: "avg_assay_percent"
      expr: AVG(CAST(assay_percent AS DOUBLE))
      comment: "Average assay percentage across COAs"
    - name: "avg_purity_percent"
      expr: AVG(CAST(purity_percent AS DOUBLE))
      comment: "Average purity percentage across COAs"
    - name: "avg_heavy_metals_ppm"
      expr: AVG(CAST(heavy_metals_ppm AS DOUBLE))
      comment: "Average heavy metals concentration (ppm)"
    - name: "expired_documents"
      expr: SUM(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of COA documents that are past expiry"
$$;