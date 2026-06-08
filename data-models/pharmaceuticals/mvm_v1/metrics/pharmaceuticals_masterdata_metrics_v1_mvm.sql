-- Metric views for domain: masterdata | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the pharmaceutical material master — covering portfolio composition, quality risk, hazard exposure, and shelf-life management. Used by Supply Chain, Quality, and Regulatory leadership to govern the active material catalogue."
  source: "`pharmaceuticals_ecm`.`masterdata`.`material`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Classifies the material (e.g. API, excipient, packaging, finished goods) — primary segmentation axis for portfolio analysis."
    - name: "material_group"
      expr: material_group
      comment: "Commodity or therapeutic grouping of the material, used for spend and portfolio segmentation."
    - name: "material_status"
      expr: material_status
      comment: "Lifecycle status of the material record (Active, Discontinued, Blocked) — critical for regulatory and supply continuity decisions."
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification tier assigned to the material, driving quality oversight requirements."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Indicates whether the material is externally procured, internally manufactured, or both — informs make-vs-buy strategy."
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA/regulatory controlled substance schedule, used for compliance reporting and access controls."
    - name: "hazardous_material_indicator"
      expr: hazardous_material_indicator
      comment: "Boolean flag indicating whether the material is classified as hazardous — drives EHS reporting and storage requirements."
    - name: "temperature_sensitive_indicator"
      expr: temperature_sensitive_indicator
      comment: "Boolean flag for cold-chain or temperature-controlled materials — informs logistics and storage investment decisions."
    - name: "batch_managed_indicator"
      expr: batch_managed_indicator
      comment: "Indicates whether the material requires batch-level traceability, a key GMP compliance attribute."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month in which the material became effective — used to track portfolio expansion over time."
    - name: "discontinuation_date_year"
      expr: YEAR(discontinuation_date)
      comment: "Year of material discontinuation — used to analyse portfolio rationalisation trends."
  measures:
    - name: "total_active_materials"
      expr: COUNT(CASE WHEN material_status = 'Active' THEN material_id END)
      comment: "Count of materials currently in Active status. Baseline KPI for portfolio size; a sudden drop signals unplanned discontinuations or data quality issues."
    - name: "hazardous_material_count"
      expr: COUNT(CASE WHEN hazardous_material_indicator = TRUE THEN material_id END)
      comment: "Number of hazardous materials in the catalogue. Drives EHS compliance investment and regulatory reporting obligations."
    - name: "hazardous_material_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazardous_material_indicator = TRUE THEN material_id END) / NULLIF(COUNT(material_id), 0), 2)
      comment: "Percentage of the material catalogue classified as hazardous. Executives use this to benchmark EHS risk exposure and prioritise mitigation spend."
    - name: "temperature_sensitive_material_count"
      expr: COUNT(CASE WHEN temperature_sensitive_indicator = TRUE THEN material_id END)
      comment: "Count of materials requiring temperature-controlled handling. Directly informs cold-chain infrastructure investment and logistics cost planning."
    - name: "cold_chain_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_sensitive_indicator = TRUE THEN material_id END) / NULLIF(COUNT(material_id), 0), 2)
      comment: "Percentage of materials requiring cold-chain logistics. A rising rate signals increasing cold-chain cost pressure and supply chain complexity."
    - name: "batch_managed_material_count"
      expr: COUNT(CASE WHEN batch_managed_indicator = TRUE THEN material_id END)
      comment: "Number of materials under batch management. Reflects GMP traceability scope and the operational overhead of batch record management."
    - name: "avg_gross_weight_kg"
      expr: ROUND(AVG(CAST(gross_weight AS DOUBLE)), 4)
      comment: "Average gross weight across materials in the selected segment. Used in logistics planning and freight cost modelling."
    - name: "avg_net_weight_kg"
      expr: ROUND(AVG(CAST(net_weight AS DOUBLE)), 4)
      comment: "Average net weight across materials. Supports yield and fill-weight analysis in manufacturing."
    - name: "controlled_substance_material_count"
      expr: COUNT(CASE WHEN controlled_substance_schedule IS NOT NULL AND controlled_substance_schedule <> '' THEN material_id END)
      comment: "Number of materials assigned a controlled substance schedule. Drives DEA/regulatory compliance scope and security investment decisions."
    - name: "quality_inspection_required_count"
      expr: COUNT(CASE WHEN quality_inspection_required = TRUE THEN material_id END)
      comment: "Count of materials mandating incoming quality inspection. Informs QC lab capacity planning and supplier qualification priorities."
    - name: "quality_inspection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_inspection_required = TRUE THEN material_id END) / NULLIF(COUNT(material_id), 0), 2)
      comment: "Percentage of materials requiring quality inspection. A high rate relative to QC capacity signals a bottleneck risk in the supply chain."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_business_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and risk KPIs over the business partner master — covering supplier qualification, GMP compliance, credit exposure, and partner lifecycle health. Used by Procurement, Quality, Finance, and Regulatory Affairs leadership."
  source: "`pharmaceuticals_ecm`.`masterdata`.`business_partner`"
  dimensions:
    - name: "bp_category"
      expr: bp_category
      comment: "High-level category of the business partner (e.g. Supplier, Customer, Contract Manufacturer) — primary segmentation axis."
    - name: "bp_role"
      expr: bp_role
      comment: "Functional role of the partner in the value chain (e.g. API Supplier, Distributor, CRO) — used for spend and risk segmentation."
    - name: "business_partner_status"
      expr: business_partner_status
      comment: "Lifecycle status of the partner record (Active, Blocked, Inactive) — critical for procurement and compliance gating."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Supplier qualification status (Qualified, Conditional, Disqualified) — directly governs whether the partner can be used in GMP supply chains."
    - name: "gmp_certification_status"
      expr: gmp_certification_status
      comment: "Current GMP certification status of the partner — a key regulatory compliance dimension for pharmaceutical supply chains."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk tier assigned to the partner (e.g. Critical, High, Medium, Low) — drives audit frequency and oversight investment."
    - name: "company_code"
      expr: company_code
      comment: "SAP company code associated with the partner — used for entity-level financial and compliance reporting."
    - name: "credit_limit_currency_code"
      expr: credit_limit_currency_code
      comment: "Currency of the credit limit — needed for multi-currency credit exposure analysis."
    - name: "avl_flag"
      expr: avl_flag
      comment: "Approved Vendor List flag — indicates whether the partner is on the AVL, a mandatory gate for GMP procurement."
    - name: "mdm_golden_record_flag"
      expr: mdm_golden_record_flag
      comment: "Indicates whether this record is the MDM-designated golden record — used to filter out duplicates in reporting."
    - name: "gmp_expiry_date_month"
      expr: DATE_TRUNC('MONTH', gmp_expiry_date)
      comment: "Month of GMP certification expiry — used to build a forward-looking compliance renewal calendar."
  measures:
    - name: "total_active_partners"
      expr: COUNT(CASE WHEN business_partner_status = 'Active' THEN business_partner_id END)
      comment: "Count of active business partners. Baseline for partner portfolio size; used to track network growth and rationalisation."
    - name: "avl_qualified_partner_count"
      expr: COUNT(CASE WHEN avl_flag = TRUE THEN business_partner_id END)
      comment: "Number of partners on the Approved Vendor List. A critical compliance KPI — only AVL partners may supply GMP materials."
    - name: "avl_qualification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN avl_flag = TRUE THEN business_partner_id END) / NULLIF(COUNT(business_partner_id), 0), 2)
      comment: "Percentage of partners that are AVL-qualified. Low rates signal procurement compliance risk and potential supply disruption."
    - name: "gmp_certified_partner_count"
      expr: COUNT(CASE WHEN gmp_certification_status = 'Certified' THEN business_partner_id END)
      comment: "Number of partners with active GMP certification. Directly reflects the regulatory-compliant supplier base available for pharmaceutical manufacturing."
    - name: "gmp_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_certification_status = 'Certified' THEN business_partner_id END) / NULLIF(COUNT(business_partner_id), 0), 2)
      comment: "Percentage of partners holding GMP certification. A declining rate is an early warning of supply chain compliance degradation."
    - name: "high_risk_partner_count"
      expr: COUNT(CASE WHEN risk_classification IN ('Critical', 'High') THEN business_partner_id END)
      comment: "Number of partners classified as Critical or High risk. Drives audit resource allocation and risk mitigation investment decisions."
    - name: "high_risk_partner_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_classification IN ('Critical', 'High') THEN business_partner_id END) / NULLIF(COUNT(business_partner_id), 0), 2)
      comment: "Percentage of the partner base classified as high or critical risk. Executives use this to benchmark supply chain risk concentration."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all business partners. Measures aggregate financial exposure to the partner network."
    - name: "avg_credit_limit_per_partner"
      expr: ROUND(AVG(CAST(credit_limit_amount AS DOUBLE)), 2)
      comment: "Average credit limit per business partner. Used to benchmark credit policy consistency and identify outlier exposures."
    - name: "gmp_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN gmp_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN business_partner_id END)
      comment: "Number of partners whose GMP certification expires within the next 90 days. A forward-looking compliance risk KPI that triggers renewal actions."
    - name: "blocked_partner_count"
      expr: COUNT(CASE WHEN business_partner_status = 'Blocked' THEN business_partner_id END)
      comment: "Number of blocked business partners. A rising count signals procurement disruption risk and may indicate systemic quality or compliance failures."
    - name: "golden_record_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mdm_golden_record_flag = TRUE THEN business_partner_id END) / NULLIF(COUNT(business_partner_id), 0), 2)
      comment: "Percentage of partner records designated as MDM golden records. Low coverage indicates data duplication risk that inflates compliance and financial reporting."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing site governance KPIs — covering GMP compliance status, inspection readiness, capacity, and certification health across the pharmaceutical manufacturing network. Used by Manufacturing, Quality, and Regulatory Affairs leadership."
  source: "`pharmaceuticals_ecm`.`masterdata`.`plant`"
  dimensions:
    - name: "plant_type"
      expr: plant_type
      comment: "Type of manufacturing site (e.g. API Manufacturing, Fill-Finish, Packaging, Warehouse) — primary segmentation for network analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the plant (Active, Decommissioned, Under Construction) — used to filter the active manufacturing network."
    - name: "gmp_certification_status"
      expr: gmp_certification_status
      comment: "GMP certification status of the plant — a mandatory compliance attribute for pharmaceutical manufacturing sites."
    - name: "iso_certification_status"
      expr: iso_certification_status
      comment: "ISO certification status — reflects quality management system maturity at the site level."
    - name: "environmental_permit_status"
      expr: environmental_permit_status
      comment: "Environmental permit status — a regulatory compliance dimension affecting site operational continuity."
    - name: "plant_code"
      expr: plant_code
      comment: "Unique plant code used in ERP and regulatory filings — enables site-level drill-down in operational dashboards."
    - name: "gmp_certification_date_year"
      expr: YEAR(gmp_certification_date)
      comment: "Year of most recent GMP certification — used to assess certification age and renewal urgency."
    - name: "gmp_expiry_date_month"
      expr: DATE_TRUNC('MONTH', gmp_expiry_date)
      comment: "Month of GMP certification expiry — used to build a forward-looking compliance renewal calendar for the manufacturing network."
    - name: "last_inspection_date_year"
      expr: YEAR(last_inspection_date)
      comment: "Year of the last regulatory inspection — used to identify sites overdue for inspection."
  measures:
    - name: "total_active_plants"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN plant_id END)
      comment: "Count of operationally active manufacturing plants. Baseline for network capacity planning and regulatory oversight scope."
    - name: "gmp_certified_plant_count"
      expr: COUNT(CASE WHEN gmp_certification_status = 'Certified' THEN plant_id END)
      comment: "Number of plants with active GMP certification. Only GMP-certified plants may manufacture regulated pharmaceutical products."
    - name: "gmp_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_certification_status = 'Certified' THEN plant_id END) / NULLIF(COUNT(plant_id), 0), 2)
      comment: "Percentage of plants with active GMP certification. A rate below 100% for active plants is a critical regulatory risk signal."
    - name: "gmp_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN gmp_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN plant_id END)
      comment: "Number of plants whose GMP certification expires within 90 days. A forward-looking KPI that triggers renewal and inspection scheduling actions."
    - name: "total_annual_capacity_units"
      expr: SUM(CAST(annual_capacity_units AS DOUBLE))
      comment: "Total annual manufacturing capacity across all plants in the selected segment. Foundational for supply planning, capacity investment, and network optimisation decisions."
    - name: "avg_annual_capacity_per_plant"
      expr: ROUND(AVG(CAST(annual_capacity_units AS DOUBLE)), 2)
      comment: "Average annual capacity per plant. Used to identify under-utilised or over-burdened sites and guide capital investment allocation."
    - name: "plants_overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() THEN plant_id END)
      comment: "Number of plants past their scheduled next inspection date. A direct regulatory risk KPI — overdue inspections can trigger Warning Letters or import alerts."
    - name: "inspection_overdue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() THEN plant_id END) / NULLIF(COUNT(plant_id), 0), 2)
      comment: "Percentage of plants overdue for regulatory inspection. Executives use this to prioritise inspection readiness resources and manage regulatory relationship risk."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_legal_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate structure and entity governance KPIs — covering entity lifecycle, GMP compliance, data quality, and regulatory registration health across the legal entity master. Used by Finance, Legal, Regulatory Affairs, and Corporate Governance leadership."
  source: "`pharmaceuticals_ecm`.`masterdata`.`legal_entity`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Type of legal entity (e.g. Operating Company, Holding Company, Joint Venture) — primary segmentation for corporate structure analysis."
    - name: "entity_status"
      expr: entity_status
      comment: "Lifecycle status of the legal entity (Active, Dissolved, Dormant) — used to scope active corporate structure reporting."
    - name: "legal_form"
      expr: legal_form
      comment: "Legal form of incorporation (e.g. GmbH, Inc., Ltd.) — relevant for regulatory filing and tax reporting segmentation."
    - name: "gmp_certification_status"
      expr: gmp_certification_status
      comment: "GMP certification status at the legal entity level — relevant for entities that are also manufacturing or distribution licence holders."
    - name: "iso_certification_status"
      expr: iso_certification_status
      comment: "ISO certification status of the legal entity — reflects quality management system maturity."
    - name: "functional_currency"
      expr: functional_currency
      comment: "Functional currency of the entity — used for financial consolidation and FX exposure analysis."
    - name: "consolidation_group"
      expr: consolidation_group
      comment: "Financial consolidation group the entity belongs to — used for group-level financial reporting segmentation."
    - name: "stock_exchange_listing"
      expr: stock_exchange_listing
      comment: "Stock exchange on which the entity is listed (if applicable) — relevant for investor relations and disclosure obligations."
    - name: "incorporation_date_year"
      expr: YEAR(incorporation_date)
      comment: "Year of incorporation — used to analyse entity age distribution and identify legacy structures for rationalisation."
    - name: "dissolution_date_year"
      expr: YEAR(dissolution_date)
      comment: "Year of dissolution — used to track entity wind-down activity and corporate simplification progress."
  measures:
    - name: "total_active_entities"
      expr: COUNT(CASE WHEN entity_status = 'Active' THEN legal_entity_id END)
      comment: "Count of active legal entities. Baseline for corporate structure complexity; a key input to legal entity rationalisation programmes."
    - name: "gmp_certified_entity_count"
      expr: COUNT(CASE WHEN gmp_certification_status = 'Certified' THEN legal_entity_id END)
      comment: "Number of legal entities holding GMP certification. Relevant for entities that hold manufacturing or distribution authorisations."
    - name: "entities_dissolved_current_year"
      expr: COUNT(CASE WHEN YEAR(dissolution_date) = YEAR(CURRENT_DATE()) THEN legal_entity_id END)
      comment: "Number of legal entities dissolved in the current year. Tracks corporate simplification progress — a strategic KPI for legal entity rationalisation programmes."
    - name: "avg_data_quality_score"
      expr: ROUND(AVG(CAST(data_quality_score AS DOUBLE)), 2)
      comment: "Average MDM data quality score across legal entities. Low scores indicate master data gaps that create regulatory filing risk and financial reporting errors."
    - name: "low_data_quality_entity_count"
      expr: COUNT(CASE WHEN data_quality_score < 70 THEN legal_entity_id END)
      comment: "Number of legal entities with a data quality score below 70. Identifies the highest-priority records for MDM remediation to reduce regulatory and financial reporting risk."
    - name: "low_data_quality_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_score < 70 THEN legal_entity_id END) / NULLIF(COUNT(legal_entity_id), 0), 2)
      comment: "Percentage of legal entities with sub-threshold data quality. A rising rate signals deteriorating master data governance and increasing downstream reporting risk."
    - name: "entities_missing_lei_code_count"
      expr: COUNT(CASE WHEN lei_code IS NULL OR lei_code = '' THEN legal_entity_id END)
      comment: "Number of active legal entities without a Legal Entity Identifier (LEI). Missing LEIs block regulatory reporting (e.g. MiFID II, EMIR) and financial transaction processing."
    - name: "entities_missing_tax_id_count"
      expr: COUNT(CASE WHEN tax_identification_number IS NULL OR tax_identification_number = '' THEN legal_entity_id END)
      comment: "Number of entities missing a tax identification number. Missing tax IDs create compliance risk for tax filings and intercompany transactions."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_inn_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmaceutical substance portfolio KPIs over the INN (International Nonproprietary Name) registry — covering substance lifecycle, orphan drug designation, breakthrough therapy status, and controlled substance scope. Used by R&D, Regulatory Affairs, and Portfolio Strategy leadership."
  source: "`pharmaceuticals_ecm`.`masterdata`.`inn_registry`"
  dimensions:
    - name: "inn_status"
      expr: inn_status
      comment: "Lifecycle status of the INN record (Active, Proposed, Retired) — used to scope the active substance portfolio."
    - name: "substance_class"
      expr: substance_class
      comment: "Chemical or biological class of the substance (e.g. Small Molecule, Biologic, Peptide) — primary segmentation for R&D portfolio analysis."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the substance (e.g. Oncology, Immunology, Rare Disease) — key dimension for portfolio strategy and investment allocation."
    - name: "pharmacological_class"
      expr: pharmacological_class
      comment: "Pharmacological mechanism class — used for competitive landscape and patent cliff analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Primary route of administration (e.g. Oral, IV, Subcutaneous) — informs formulation strategy and market access decisions."
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "Controlled substance schedule assigned to the substance — drives regulatory compliance scope and market access complexity."
    - name: "orphan_drug_designation_flag"
      expr: orphan_drug_designation_flag
      comment: "Boolean flag for orphan drug designation — a strategic portfolio attribute that unlocks regulatory incentives and market exclusivity."
    - name: "breakthrough_therapy_designation_flag"
      expr: breakthrough_therapy_designation_flag
      comment: "Boolean flag for FDA Breakthrough Therapy Designation — signals accelerated development pathway and high strategic priority."
    - name: "mdm_golden_record_flag"
      expr: mdm_golden_record_flag
      comment: "MDM golden record flag — used to filter to deduplicated, authoritative substance records."
    - name: "who_publication_date_year"
      expr: YEAR(who_publication_date)
      comment: "Year of WHO INN publication — used to track the pace of new substance registrations over time."
  measures:
    - name: "total_active_substances"
      expr: COUNT(CASE WHEN inn_status = 'Active' THEN inn_registry_id END)
      comment: "Count of active INN-registered substances in the portfolio. Baseline KPI for R&D pipeline breadth and substance master completeness."
    - name: "orphan_drug_designated_count"
      expr: COUNT(CASE WHEN orphan_drug_designation_flag = TRUE THEN inn_registry_id END)
      comment: "Number of substances with orphan drug designation. A strategic portfolio KPI — orphan designations unlock regulatory incentives and premium pricing in rare disease markets."
    - name: "orphan_drug_designation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN orphan_drug_designation_flag = TRUE THEN inn_registry_id END) / NULLIF(COUNT(inn_registry_id), 0), 2)
      comment: "Percentage of the substance portfolio with orphan drug designation. Reflects the organisation's strategic commitment to rare disease and the associated regulatory incentive capture."
    - name: "breakthrough_therapy_designated_count"
      expr: COUNT(CASE WHEN breakthrough_therapy_designation_flag = TRUE THEN inn_registry_id END)
      comment: "Number of substances with FDA Breakthrough Therapy Designation. A high-signal pipeline quality KPI — BTD substances have accelerated approval pathways and higher commercial success probability."
    - name: "breakthrough_therapy_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN breakthrough_therapy_designation_flag = TRUE THEN inn_registry_id END) / NULLIF(COUNT(inn_registry_id), 0), 2)
      comment: "Percentage of the substance portfolio with Breakthrough Therapy Designation. Executives use this to benchmark pipeline quality and regulatory strategy effectiveness."
    - name: "controlled_substance_count"
      expr: COUNT(CASE WHEN controlled_substance_schedule IS NOT NULL AND controlled_substance_schedule <> '' THEN inn_registry_id END)
      comment: "Number of substances classified as controlled. Drives DEA/regulatory compliance scope, security requirements, and market access complexity assessment."
    - name: "avg_molecular_weight"
      expr: ROUND(AVG(CAST(molecular_weight AS DOUBLE)), 4)
      comment: "Average molecular weight across substances in the selected segment. Used by R&D and formulation teams to characterise portfolio complexity and predict formulation challenges."
    - name: "golden_record_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mdm_golden_record_flag = TRUE THEN inn_registry_id END) / NULLIF(COUNT(inn_registry_id), 0), 2)
      comment: "Percentage of INN records designated as MDM golden records. Low coverage indicates substance master data duplication that can corrupt regulatory submissions and clinical trial data."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_ndc_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "US product registration and NDC portfolio KPIs — covering marketed product status, biosimilar landscape, REMS obligations, controlled substance scope, and data quality. Used by Regulatory Affairs, Commercial, and Market Access leadership."
  source: "`pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`"
  dimensions:
    - name: "marketing_status"
      expr: marketing_status
      comment: "FDA marketing status of the NDC product (e.g. Prescription, OTC, Discontinued) — primary lifecycle dimension for the US product portfolio."
    - name: "product_type"
      expr: product_type
      comment: "Type of drug product (e.g. Human Prescription Drug, Biologic, OTC) — used for portfolio segmentation and regulatory pathway analysis."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Pharmaceutical dosage form (e.g. Tablet, Injection, Capsule) — used for formulation portfolio and manufacturing complexity analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for the product — informs market access strategy and patient adherence analysis."
    - name: "rx_otc_indicator"
      expr: rx_otc_indicator
      comment: "Prescription vs. OTC classification — a fundamental commercial and regulatory segmentation dimension."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule — drives compliance obligations and market access restrictions."
    - name: "biosimilar_flag"
      expr: biosimilar_flag
      comment: "Indicates whether the product is a biosimilar — a strategic portfolio dimension for competitive and pricing strategy."
    - name: "interchangeable_biosimilar_flag"
      expr: interchangeable_biosimilar_flag
      comment: "Indicates FDA interchangeability designation for biosimilars — a premium regulatory status that enables pharmacy-level substitution."
    - name: "rems_flag"
      expr: rems_flag
      comment: "Risk Evaluation and Mitigation Strategy (REMS) flag — products with REMS have significant additional compliance and distribution obligations."
    - name: "record_status"
      expr: record_status
      comment: "MDM record status — used to filter to active, validated NDC records."
    - name: "start_marketing_date_year"
      expr: YEAR(start_marketing_date)
      comment: "Year the product entered the US market — used to analyse portfolio vintage and product lifecycle stage."
  measures:
    - name: "total_active_ndc_products"
      expr: COUNT(CASE WHEN marketing_status NOT IN ('Discontinued', 'Expired') AND record_status = 'Active' THEN masterdata_ndc_code_id END)
      comment: "Count of active NDC-registered products in the US portfolio. Baseline KPI for US commercial portfolio breadth and regulatory registration completeness."
    - name: "biosimilar_product_count"
      expr: COUNT(CASE WHEN biosimilar_flag = TRUE THEN masterdata_ndc_code_id END)
      comment: "Number of biosimilar products in the NDC portfolio. A strategic KPI reflecting the organisation's biosimilar pipeline and competitive positioning in biologics markets."
    - name: "biosimilar_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN biosimilar_flag = TRUE THEN masterdata_ndc_code_id END) / NULLIF(COUNT(masterdata_ndc_code_id), 0), 2)
      comment: "Percentage of the NDC portfolio that are biosimilars. Executives use this to track biosimilar strategy execution and portfolio diversification."
    - name: "interchangeable_biosimilar_count"
      expr: COUNT(CASE WHEN interchangeable_biosimilar_flag = TRUE THEN masterdata_ndc_code_id END)
      comment: "Number of products with FDA interchangeability designation. Interchangeable biosimilars command superior market access and pharmacy substitution rates — a high-value commercial KPI."
    - name: "rems_obligated_product_count"
      expr: COUNT(CASE WHEN rems_flag = TRUE THEN masterdata_ndc_code_id END)
      comment: "Number of products subject to REMS programmes. REMS products carry significant compliance cost and distribution complexity — this KPI informs compliance resource planning."
    - name: "rems_obligation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rems_flag = TRUE THEN masterdata_ndc_code_id END) / NULLIF(COUNT(masterdata_ndc_code_id), 0), 2)
      comment: "Percentage of the NDC portfolio subject to REMS. A rising rate signals increasing compliance burden and distribution complexity across the US product portfolio."
    - name: "controlled_substance_product_count"
      expr: COUNT(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule <> '' THEN masterdata_ndc_code_id END)
      comment: "Number of NDC products with a DEA controlled substance schedule. Drives DEA compliance scope, security requirements, and restricted distribution programme obligations."
    - name: "avg_data_quality_score"
      expr: ROUND(AVG(CAST(data_quality_score AS DOUBLE)), 2)
      comment: "Average MDM data quality score across NDC records. Low scores indicate registration data gaps that can cause FDA submission errors and supply chain disruptions."
    - name: "low_data_quality_ndc_count"
      expr: COUNT(CASE WHEN data_quality_score < 70 THEN masterdata_ndc_code_id END)
      comment: "Number of NDC records with data quality score below 70. Identifies priority records for MDM remediation to prevent regulatory filing failures."
    - name: "products_listing_expiring_within_90_days"
      expr: COUNT(CASE WHEN listing_expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN masterdata_ndc_code_id END)
      comment: "Number of NDC products whose FDA listing expires within 90 days. Expired listings result in products being unlawfully marketed — a critical regulatory compliance KPI."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_atc_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WHO ATC classification portfolio KPIs — covering therapeutic class coverage, orphan drug scope, biosimilar reference substances, and controlled substance distribution across the ATC hierarchy. Used by Portfolio Strategy, Regulatory Affairs, and Market Access leadership."
  source: "`pharmaceuticals_ecm`.`masterdata`.`atc_classification`"
  dimensions:
    - name: "atc_level"
      expr: atc_level
      comment: "ATC hierarchy level (1–5) — used to analyse portfolio coverage at different therapeutic granularities."
    - name: "atc_level_1_description"
      expr: atc_level_1_description
      comment: "ATC Level 1 anatomical main group (e.g. Alimentary tract, Antineoplastic) — highest-level therapeutic segmentation for portfolio strategy."
    - name: "atc_level_2_description"
      expr: atc_level_2_description
      comment: "ATC Level 2 therapeutic subgroup — used for competitive landscape and market access analysis."
    - name: "atc_level_3_description"
      expr: atc_level_3_description
      comment: "ATC Level 3 pharmacological subgroup — used for mechanism-of-action portfolio analysis."
    - name: "atc_status"
      expr: atc_status
      comment: "Status of the ATC classification record (Active, Retired) — used to scope analysis to current WHO classifications."
    - name: "administration_route"
      expr: administration_route
      comment: "Route of administration associated with the ATC classification — used for formulation and market access segmentation."
    - name: "orphan_drug_designation_flag"
      expr: orphan_drug_designation_flag
      comment: "Orphan drug designation at the ATC classification level — used to map rare disease portfolio coverage across the ATC hierarchy."
    - name: "biosimilar_reference_flag"
      expr: biosimilar_reference_flag
      comment: "Indicates whether the ATC entry is a biosimilar reference substance — used to map biosimilar competition landscape."
    - name: "combination_product_flag"
      expr: combination_product_flag
      comment: "Indicates combination products — relevant for regulatory pathway complexity and pricing strategy."
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "Controlled substance schedule at the ATC level — used to assess regulatory complexity across therapeutic classes."
    - name: "valid_from_date_year"
      expr: YEAR(valid_from_date)
      comment: "Year the ATC classification became valid — used to track WHO classification evolution over time."
  measures:
    - name: "total_active_atc_classifications"
      expr: COUNT(CASE WHEN atc_status = 'Active' THEN atc_classification_id END)
      comment: "Count of active ATC classifications in the master. Baseline for therapeutic class coverage breadth — used to assess portfolio diversification across the WHO ATC hierarchy."
    - name: "orphan_drug_atc_count"
      expr: COUNT(CASE WHEN orphan_drug_designation_flag = TRUE THEN atc_classification_id END)
      comment: "Number of ATC classifications with orphan drug designation. Maps the rare disease footprint across the therapeutic hierarchy — a strategic portfolio KPI."
    - name: "orphan_drug_atc_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN orphan_drug_designation_flag = TRUE THEN atc_classification_id END) / NULLIF(COUNT(atc_classification_id), 0), 2)
      comment: "Percentage of ATC classifications with orphan drug designation. Reflects the organisation's rare disease strategic commitment across the therapeutic portfolio."
    - name: "biosimilar_reference_atc_count"
      expr: COUNT(CASE WHEN biosimilar_reference_flag = TRUE THEN atc_classification_id END)
      comment: "Number of ATC classifications flagged as biosimilar reference substances. Identifies therapeutic areas exposed to biosimilar competition — a critical commercial risk KPI."
    - name: "combination_product_atc_count"
      expr: COUNT(CASE WHEN combination_product_flag = TRUE THEN atc_classification_id END)
      comment: "Number of ATC entries for combination products. Combination products carry higher regulatory complexity and development cost — this KPI informs regulatory resource planning."
    - name: "avg_ddd_value"
      expr: ROUND(AVG(CAST(ddd_value AS DOUBLE)), 4)
      comment: "Average WHO Defined Daily Dose (DDD) value across ATC classifications. Used by Market Access and Health Economics teams to benchmark dosing intensity and model treatment cost per patient."
    - name: "controlled_substance_atc_count"
      expr: COUNT(CASE WHEN controlled_substance_schedule IS NOT NULL AND controlled_substance_schedule <> '' THEN atc_classification_id END)
      comment: "Number of ATC classifications with a controlled substance schedule. Quantifies the regulatory compliance scope for controlled substances across the therapeutic portfolio."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center governance KPIs — covering active cost center portfolio, GMP classification, SOX relevance, and statistical cost center scope. Used by Finance, Controlling, and Compliance leadership to govern the cost center master and ensure financial reporting integrity."
  source: "`pharmaceuticals_ecm`.`masterdata`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (e.g. Production, R&D, Administration, Quality) — primary segmentation for cost allocation and financial reporting."
    - name: "cost_center_category"
      expr: cost_center_category
      comment: "Category of the cost center within the controlling hierarchy — used for overhead allocation and profitability analysis."
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Lifecycle status of the cost center (Active, Locked, Inactive) — used to scope active financial reporting structures."
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification of the cost center — identifies cost centers associated with GMP-regulated activities, driving quality cost tracking."
    - name: "functional_area_code"
      expr: functional_area_code
      comment: "Functional area code (e.g. Manufacturing, R&D, Sales) — used for functional cost allocation and P&L reporting."
    - name: "cost_allocation_method"
      expr: cost_allocation_method
      comment: "Method used to allocate costs from this cost center — relevant for controlling accuracy and intercompany cost transparency."
    - name: "sox_relevant_flag"
      expr: sox_relevant_flag
      comment: "SOX relevance flag — identifies cost centers in scope for Sarbanes-Oxley internal controls, driving audit and compliance resource allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost center — used for multi-currency cost consolidation and FX analysis."
    - name: "valid_from_date_year"
      expr: YEAR(valid_from_date)
      comment: "Year the cost center became valid — used to track cost center master evolution and rationalisation over time."
  measures:
    - name: "total_active_cost_centers"
      expr: COUNT(CASE WHEN cost_center_status = 'Active' THEN cost_center_id END)
      comment: "Count of active cost centers. Baseline for controlling structure complexity — a large active count relative to headcount signals over-fragmentation and reporting overhead."
    - name: "sox_relevant_cost_center_count"
      expr: COUNT(CASE WHEN sox_relevant_flag = TRUE THEN cost_center_id END)
      comment: "Number of SOX-relevant cost centers. Directly determines the scope and cost of SOX internal control testing — a key Finance and Audit KPI."
    - name: "sox_relevance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sox_relevant_flag = TRUE THEN cost_center_id END) / NULLIF(COUNT(cost_center_id), 0), 2)
      comment: "Percentage of cost centers in SOX scope. A rising rate increases audit cost and compliance burden — used to benchmark and optimise the SOX control perimeter."
    - name: "gmp_classified_cost_center_count"
      expr: COUNT(CASE WHEN gmp_classification IS NOT NULL AND gmp_classification <> '' THEN cost_center_id END)
      comment: "Number of cost centers with a GMP classification. Identifies the financial tracking scope for GMP-regulated activities — essential for quality cost reporting and regulatory inspection readiness."
    - name: "statistical_cost_center_count"
      expr: COUNT(CASE WHEN statistical_cost_center_flag = TRUE THEN cost_center_id END)
      comment: "Number of statistical cost centers. Statistical cost centers are used for internal allocation modelling — a high count relative to real cost centers may indicate controlling complexity that should be rationalised."
    - name: "locked_cost_center_count"
      expr: COUNT(CASE WHEN lock_indicator IS NOT NULL AND lock_indicator <> '' THEN cost_center_id END)
      comment: "Number of cost centers with a lock indicator set. Locked cost centers block postings — a rising count signals potential financial close process disruptions."
    - name: "mdm_golden_record_cost_center_count"
      expr: COUNT(CASE WHEN mdm_golden_record_flag = TRUE THEN cost_center_id END)
      comment: "Number of cost centers designated as MDM golden records. Used to assess master data deduplication coverage — low coverage indicates duplicate cost centers that distort financial reporting."
    - name: "golden_record_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mdm_golden_record_flag = TRUE THEN cost_center_id END) / NULLIF(COUNT(cost_center_id), 0), 2)
      comment: "Percentage of cost centers with MDM golden record designation. Low coverage is a data quality risk signal for financial controlling and consolidation accuracy."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse and storage governance KPIs — covering GMP zone compliance, temperature-controlled capacity, DEA authorisation, qualification status, and storage network health. Used by Supply Chain, Quality, and Regulatory Affairs leadership."
  source: "`pharmaceuticals_ecm`.`masterdata`.`storage_location`"
  dimensions:
    - name: "storage_type"
      expr: storage_type
      comment: "Type of storage location (e.g. Ambient, Cold Chain, Controlled Substance Vault) — primary segmentation for storage network analysis."
    - name: "storage_location_status"
      expr: storage_location_status
      comment: "Operational status of the storage location (Active, Inactive, Quarantine) — used to scope active storage capacity reporting."
    - name: "gmp_zone_classification"
      expr: gmp_zone_classification
      comment: "GMP zone classification of the storage location (e.g. Grade A, B, C, D) — a critical quality attribute for pharmaceutical storage compliance."
    - name: "gdp_compliant_flag"
      expr: gdp_compliant_flag
      comment: "Good Distribution Practice compliance flag — mandatory for pharmaceutical distribution network locations."
    - name: "quarantine_zone_flag"
      expr: quarantine_zone_flag
      comment: "Indicates whether the location is a quarantine zone — used to track quarantine capacity and manage product release workflows."
    - name: "dea_schedule_authorized"
      expr: dea_schedule_authorized
      comment: "DEA schedule authorisation for the storage location — determines which controlled substances may be stored at this location."
    - name: "security_level"
      expr: security_level
      comment: "Security classification of the storage location — relevant for controlled substance and high-value product storage compliance."
    - name: "wms_integration_flag"
      expr: wms_integration_flag
      comment: "Indicates whether the location is integrated with a Warehouse Management System — a digital maturity and inventory accuracy KPI."
    - name: "last_qualification_date_year"
      expr: YEAR(last_qualification_date)
      comment: "Year of last qualification — used to identify storage locations with ageing qualifications that may require requalification."
  measures:
    - name: "total_active_storage_locations"
      expr: COUNT(CASE WHEN storage_location_status = 'Active' THEN storage_location_id END)
      comment: "Count of active storage locations. Baseline for storage network capacity planning and GMP compliance scope."
    - name: "total_storage_capacity_units"
      expr: SUM(CAST(capacity_storage_units AS DOUBLE))
      comment: "Total storage capacity across all locations in the selected segment. Foundational for supply chain capacity planning and network optimisation decisions."
    - name: "avg_storage_capacity_per_location"
      expr: ROUND(AVG(CAST(capacity_storage_units AS DOUBLE)), 2)
      comment: "Average storage capacity per location. Used to identify under-utilised or over-burdened storage nodes and guide warehouse investment decisions."
    - name: "gdp_compliant_location_count"
      expr: COUNT(CASE WHEN gdp_compliant_flag = TRUE THEN storage_location_id END)
      comment: "Number of GDP-compliant storage locations. Only GDP-compliant locations may be used in the pharmaceutical distribution network — a critical regulatory compliance KPI."
    - name: "gdp_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdp_compliant_flag = TRUE THEN storage_location_id END) / NULLIF(COUNT(storage_location_id), 0), 2)
      comment: "Percentage of storage locations that are GDP-compliant. A rate below 100% for active distribution locations is a regulatory risk signal requiring immediate remediation."
    - name: "quarantine_zone_count"
      expr: COUNT(CASE WHEN quarantine_zone_flag = TRUE THEN storage_location_id END)
      comment: "Number of quarantine zone storage locations. Tracks quarantine capacity — insufficient quarantine zones create product release bottlenecks and GMP compliance risk."
    - name: "locations_overdue_qualification_count"
      expr: COUNT(CASE WHEN next_qualification_due_date < CURRENT_DATE() THEN storage_location_id END)
      comment: "Number of storage locations past their qualification due date. Overdue qualifications are a GMP non-compliance finding — a critical quality risk KPI for inspection readiness."
    - name: "qualification_overdue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_qualification_due_date < CURRENT_DATE() THEN storage_location_id END) / NULLIF(COUNT(storage_location_id), 0), 2)
      comment: "Percentage of storage locations overdue for qualification. Executives use this to prioritise qualification resources and manage GMP inspection risk."
    - name: "avg_temperature_range_celsius"
      expr: ROUND(AVG(CAST(temperature_max_celsius AS DOUBLE) - CAST(temperature_min_celsius AS DOUBLE)), 2)
      comment: "Average temperature range (max minus min) across storage locations. A narrow average range indicates a cold-chain-heavy network with higher operating cost and compliance complexity."
    - name: "wms_integrated_location_count"
      expr: COUNT(CASE WHEN wms_integration_flag = TRUE THEN storage_location_id END)
      comment: "Number of storage locations integrated with a WMS. WMS integration drives inventory accuracy and traceability — low coverage signals digital supply chain maturity gaps."
    - name: "wms_integration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN wms_integration_flag = TRUE THEN storage_location_id END) / NULLIF(COUNT(storage_location_id), 0), 2)
      comment: "Percentage of storage locations with WMS integration. A low rate indicates inventory visibility gaps that increase the risk of stock-outs, write-offs, and regulatory traceability failures."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_org_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organisational structure and workforce governance KPIs — covering headcount, budget, GMP/GCP/GLP regulatory scope, and org unit lifecycle health. Used by HR, Finance, Quality, and Operations leadership to govern the organisational master."
  source: "`pharmaceuticals_ecm`.`masterdata`.`org_unit`"
  dimensions:
    - name: "unit_type"
      expr: unit_type
      comment: "Type of organisational unit (e.g. Department, Division, Business Unit, Site) — primary segmentation for workforce and budget analysis."
    - name: "unit_level"
      expr: unit_level
      comment: "Hierarchical level of the org unit — used to scope analysis to specific layers of the organisational structure."
    - name: "org_unit_status"
      expr: org_unit_status
      comment: "Lifecycle status of the org unit (Active, Inactive, Dissolved) — used to scope active organisational structure reporting."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area of the org unit (e.g. R&D, Manufacturing, Commercial, Quality) — key dimension for workforce and budget allocation analysis."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the org unit — used to align headcount and budget to portfolio strategy."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the org unit — used for regional workforce and budget distribution analysis."
    - name: "gmp_regulated_flag"
      expr: gmp_regulated_flag
      comment: "Indicates whether the org unit operates under GMP regulations — determines quality oversight and compliance resource requirements."
    - name: "gcp_regulated_flag"
      expr: gcp_regulated_flag
      comment: "Indicates whether the org unit operates under GCP (Good Clinical Practice) — relevant for clinical operations and R&D compliance scope."
    - name: "glp_regulated_flag"
      expr: glp_regulated_flag
      comment: "Indicates whether the org unit operates under GLP (Good Laboratory Practice) — relevant for non-clinical safety study compliance scope."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the org unit budget — used for multi-currency budget consolidation."
    - name: "effective_start_date_year"
      expr: YEAR(effective_start_date)
      comment: "Year the org unit became effective — used to track organisational structure evolution over time."
  measures:
    - name: "total_active_org_units"
      expr: COUNT(CASE WHEN org_unit_status = 'Active' THEN org_unit_id END)
      comment: "Count of active organisational units. Baseline for organisational complexity — used to benchmark span of control and identify rationalisation opportunities."
    - name: "total_headcount_fte"
      expr: SUM(CAST(headcount_fte AS DOUBLE))
      comment: "Total FTE headcount across org units in the selected segment. A foundational workforce planning KPI used by HR and Finance for capacity and cost planning."
    - name: "avg_headcount_fte_per_unit"
      expr: ROUND(AVG(CAST(headcount_fte AS DOUBLE)), 2)
      comment: "Average FTE headcount per org unit. Used to assess span of control and identify over- or under-resourced units relative to budget and workload."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across org units in the selected segment. Foundational for financial planning and budget vs. actuals analysis."
    - name: "avg_budget_per_fte"
      expr: ROUND(SUM(CAST(budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(headcount_fte AS DOUBLE)), 0), 2)
      comment: "Average budget per FTE across org units. A productivity and cost efficiency KPI — significant variance across units signals resource allocation imbalances."
    - name: "gmp_regulated_unit_count"
      expr: COUNT(CASE WHEN gmp_regulated_flag = TRUE THEN org_unit_id END)
      comment: "Number of org units operating under GMP regulations. Determines the scope of GMP quality oversight and compliance resource requirements."
    - name: "gmp_regulated_headcount_fte"
      expr: SUM(CASE WHEN gmp_regulated_flag = TRUE THEN CAST(headcount_fte AS DOUBLE) ELSE 0 END)
      comment: "Total FTE headcount in GMP-regulated org units. Used to size GMP training, qualification, and quality oversight investment."
    - name: "gcp_regulated_unit_count"
      expr: COUNT(CASE WHEN gcp_regulated_flag = TRUE THEN org_unit_id END)
      comment: "Number of org units operating under GCP. Determines the scope of clinical operations compliance oversight and ICH E6 training requirements."
    - name: "qms_scope_unit_count"
      expr: COUNT(CASE WHEN qms_scope_flag = TRUE THEN org_unit_id END)
      comment: "Number of org units within the Quality Management System scope. Used to assess QMS coverage breadth and identify gaps in quality governance."
    - name: "qms_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qms_scope_flag = TRUE THEN org_unit_id END) / NULLIF(COUNT(CASE WHEN org_unit_status = 'Active' THEN org_unit_id END), 0), 2)
      comment: "Percentage of active org units within QMS scope. Low coverage is a quality governance gap — regulators expect QMS to cover all GxP-relevant organisational units."
$$;